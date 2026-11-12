Article
Quality of Crowdsourced Data on Urban
Morphology—The Human Influence
Experiment (HUMINEX)
BenjaminBechtel1,*,MatthiasDemuzere2,PanagiotisSismanidis3,4,DanielFenner5,
OscarBrousse6,ChristophBeck7,FriekeVanCoillie2,OlafConrad1,IphigeniaKeramitsoglou3,
ArianeMiddel8,GeraldMills9,DevNiyogi10,MarcoOtto5,LindaSee11and
Marie-LeenVerdonck2
1 CenterforEarthSystemResearchandSustainability,UniversityofHamburg,D-20146Hamburg,Germany;
olaf.conrad@uni-hamburg.de
2 DepartmentofForestandWaterManagement,GhentUniversity,9000Ghent,Belgium;
matthias.demuzere@ugent.be(M.D.);Frieke.Vancoillie@UGent.be(F.V.C.);
marieleen.verdonck@ugent.be(M.-L.V.)
3 InstituteforAstronomy,Astrophysics,SpaceApplicationsandRemoteSensing,
NationalObservatoryofAthens,AthensGR-15236,Greece;panosis@noa.gr(P.S.);ik@noa.gr(I.K.)
4 SchoolofChemicalEngineering,NationalTechnicalUniversityofAthens,AthensGR-15780,Greece
5 InstituteofEcology,TechnischeUniversitätBerlin,D-12165Berlin,Germany;
daniel.fenner@tu-berlin.de(D.F.);marco.otto@klima.tu-berlin.de(M.O.)
6 DepartmentofEarthandEnvironmentalSciences,KULeuven,3001Leuven,Belgium;
oscar.brousse@kuleuven.be
7 InstituteofGeography,UniversityofAugsburg,D-86159Augsburg,Germany;
christoph.beck@geo.uni-augsburg.de
8 SchoolofGeographicalSciencesandUrbanPlanning,ArizonaStateUniversity,Tempe,AZ85287,USA;
ariane.middel@asu.edu
9 SchoolofGeography,UniversityCollegeDublin,Dublin4,Ireland;gerald.mills@ucd.ie
10 PurdueUniversity,WestLafayette,IN47906,USA;climate@purdue.edu
11 EcosystemsServicesandManagementProgram,InternationalInstituteforAppliedSystemsAnalysis,
A-2361Laxenburg,Austria;see@iiasa.ac.at
* Correspondence:benjamin.bechtel@uni-hamburg.de;Tel.:+49-40-42838-4962
AcademicEditors:ElizabethWentz,LindseyConrowandHeatherFischer
Received:13March2017;Accepted:6May2017;Published:9May2017
Abstract: TheWorldUrbanDatabaseandAccessPortalTools(WUDAPT)isacommunityinitiative
tocollectworldwidedataonurbanform(i.e., morphology, materials)andfunction(i.e., useand
metabolism). This is achievedthroughcrowdsourcing, which we definehereas the collectionof
databyaboundedcrowd,composedofstudents. Inthisprocess,trainingdatafortheclassification
ofurbanstructuresintoLocalClimateZones(LCZ)areobtained,whichare,likemostvolunteered
geographicinformationinitiatives,ofunknownquality. Inthisstudy,weinvestigatedthequalityof
94crowdsourcedtrainingdatasetsfortencities,generatedby119studentsfromsixuniversities. The
resultsshowedlargediscrepanciesandtheresultingLCZmapsweremostlyofpoortomoderate
quality. Thiswasduetogeneraldifficultiesinthehumaninterpretationofthe(urban)landscapeand
intheunderstandingoftheLCZscheme. However,thequalityoftheLCZmapsimprovedwiththe
numberoftrainingdatarevisions. Asevidenceforthewisdomofthecrowd,improvementsofupto
20%inoverallaccuracywerefoundwhenmultipletrainingdatasetswereusedtogethertocreatea
singleLCZmap. Thisimprovementwasgreatestforsmalltrainingdatasets,saturatingataboutten
tofifteensets.
UrbanSci.2017,1,15;doi:10.3390/urbansci1020015 www.mdpi.com/journal/urbansci

UrbanSci.2017,1,15 2of21
Keywords: Local Climate Zones (LCZs); urban climate; crowdsourcing; volunteered geographic
information;classification;WUDAPT
1. Introduction
The role of cities as drivers of global environmental change and as places that are uniquely
exposedtoarangeofnaturalhazards(bothcurrentandprojected)hashighlightedadatagap. While
there are numerous studies on urban growth [1–3], building urban resilience [4–6], and on urban
analyticsandsmartcities[7–9],thereisadearthofinformationontheplace-specificcharacterofurban
landscapesworldwide. Thisinformationisneededtomakeinformeddecisionsaboutthenatureof
urbanrisks,toprovideabasisforplanningofsustainablecities,totransferknowledgebetweencities,
torunincreasinglysophisticatedmodelsonurbanimpactsonecosystems,andtolinkglobal/regional
environmentalchangetocityoutcomes. Fundamentally,urbanscienceneedsdataontheformand
functionsofcitiesatascalethatisusefulfordecisionmaking. Formdescribesthephysicallayoutof
thecity(land-cover),whilefunctioncapturesthe‘metabolic’processesthatconsumeenergy,materials
andwaterandgeneratewastes(land-use). Urbanadaptationandmitigationstrategiesseektomodify
andregulatetheseaspectsofcitiestomanageriskanditscomponents. Dataonformandfunction
mustbeacquiredusingconsistentmethodologiestohaveuniversalrelevance. Satellite-basedsensors
areideallysuitedtothistaskandhavebeenusedtogenerateglobalurbanmasks(thatis,theextent
ofurbancover)[10,11]butthesehavenotprovidedanydetailontheinternalmake-upofcities[12].
TheWorldUrbanDatabaseandAccessPortalTools(WUDAPT)projectisdesignedtoaddressthis
lacuna[13].
WUDAPTtakesahierarchicalapproachtourbandataacquisition;itsfirstobjectiveistomapthe
basicphysicalgeographyofcitiesworldwideusingastandardclassificationscheme,Landsatdata
andcrowdsourcedknowledge. TheLocalClimateZones(LCZ)system[14]providestheframework
fordatagathering. LCZtypes(alsoreferredtointhispaperasLCZcategoriesandLCZclasses)are
comprisedof10urbanand7naturaltypesthatareeachassociatedwithdatavaluesthatdescribe
variablesonthetypicalbuilding,thermal,radiativeandmetabolicpropertiesofurbanneighborhoods
(≥1km2). TheLCZschemewasdesignedprimarilyforassessinglocalclimateimpacts[15–19];butas
itdescribestheurbanlandscapegenerally(e.g.,vegetativeandbuildingfractions),amapofLCZtypes
acrossacityalsoencodesitsinternalstructure. Assuch,WUDAPTdatacanbeusedtoassesscurrent
andprojecturbanimpactsonthelocalatmosphereandhydrosphereandcanbeusedtomapexposure
toexistingandprojectedhazards[20–22]. Moreover, thesemapscanprovideaspatialframework
forgatheringrelatedinformationonecosystems,carbonemissions,publichealth,etc. Aworldwide
LCZdatabaseoncitieswouldprovidemuchofthedatainfrastructuretosupportglobalinitiativeson
urban-scaleriskassessmentandappropriateadaptationandmitigationstrategies.
Several methods for creating LCZ maps have been proposed, including supervised
pixel-basedclassificationfrommultipleEarthObservation(EO)datastreams[23],model-basedGIS
approaches [24–26], and object-based image analysis [27,28]. For WUDAPT, it was decided that a
simpleandefficientcomputingworkflowbasedonfreesoftwareanddatawasneeded. Thisresulted
inauniversalWUDAPTmethodology[29]thatuseshigh-resolutionimageryfromGoogleEarthas
the basis for identifying and digitizing training areas (TAs) that represent typical examples of the
LCZspresentintheircity. AlongwithfreeLandsatsatelliteimagery,theseTAsareusedintheLCZ
classification,whichherereferstotheprocessofusingamachinelearningapproachtoassigntheLCZ
typestoderiveacompleteLCZmapfortherespectivecity. Thismethodhasbeenimplementedina
singleLCZclassificationtoolintheopensourceSAGAsoftware[30]. Whileseveralimprovements
withnewsourcesofdata[31–34]andmethods[35–38]arecurrentlybeinginvestigated,thissimple
methodologyhasproventobeuseful: todate,alargenumberofindividualsaroundtheworldhave
classifiedover50citiesworldwide[31,32,39]. Assuch,WUDAPTisanexampleofthecrowdsourcing

UrbanSci.2017,1,15 3of21
ofgeographicinformation—alsoreferredtoasvolunteeredgeographicinformation(VGI)[40]and
citizenscience—amongstothertermsrelatedtousergeneratedcontent[41]. Generally,crowdsourcing
involvesthedistributionoftaskstoacrowd[42],oftenduetothesheervolumeoftheworkinvolved
andthelackoflabourneededtocompleteit. ForWUDAPT,anotherimportantelementininvolving
thecrowdistoelicittheknowledgeofindividualslocatedindifferentcitiesaroundtheworld. Hence,
membersoftheInternationalAssociationofUrbanClimate[43]arethemaincontributorstoWUDAPT
duetotheirstronginterestinurbanclimaterelatedissuesbutanyonewithaninterestincontributing
totheWUDAPTdatabasecanparticipate.
Since the LCZ maps are intended for use in a range of different applications, such as climate
modelsatvariousscales,thereisaclearneedforacommonqualityassessmentprocess. Criticalfor
mappingaccuracyisthequalityoftheTAsprovidedbythecrowd. PreviousexaminationsofTAs
fordifferentcitiesrevealedthatnoteveryoneinthecrowdfollowstheWUDAPTrecommendations
for TA sizes and shapes and that often LCZ TAs have simply been misidentified. This is mainly
drivenbythelargevariabilityinhumaninterpretationofimagery,whichisacommonproblemin
supervisedclassification[44–46]. Similarconcernshaverecentlybeenraisedwithrespecttothequality
ofcrowdsourceddata[47,48]. Hence,newmethodsareemergingtoassessandimprovethequalityof
crowdsourceddata,bothduringdatacollectionandinpost-processingafterwards[49,50].
ToinvestigatetheeffectofthecrowdsourcingofTAsontheLCZmappingprocesswithinthe
WUDAPTmethodology,theHUManINfluenceEXperiment(HUMINEX)wasdesigned. Theoverall
aims are to (1) investigate the quality of LCZ maps produced by different individuals (hereafter
referred to as the operators) using the WUDAPT methodology; (2) address the influence of their
individualperceptionandinterpretation,whichisbasedontheirexperienceandpriorknowledge;
and(3)investigatehowthemappingaccuracycanbeimproved,e.g.,byrevisionoftheinitialtraining
dataorbyjoiningcrowdsourceddatafromseveraloperators. Thispaperprovidesthefirstresultsof
HUMINEX,organizedasfollows: (i)inSection2theexperimentisintroduced;(ii)inSection3the
datacollectionfortheexperimentandtheanalysismethodsareoutlined;(iii)theresultsobtainedare
presentedinSection4;followedby(iv)adiscussionoftheimplicationsofthefindingsforfutureLCZ
mappinginSection5;(v)andfinally,theconclusionsarepresentedinSection6.
2. DescriptionoftheHumanInfluenceExperiment
HUMINEXwasdesignedtoevaluatehowindividualperceptionandbiasimpactsthemapping
accuracy of cities following the WUDAPT framework across different cities in the world. The
experiment was set up as a coordinated effort among student courses from several universities.
Participantswereprovidedwithmaterials(software,website,andpapers)fortheirclassroomexercises,
whichincludedtheLCZmappingworkflowasdescribedbrieflybelow. However,sincethecourses
haddifferentstartingtimesanddifferentformats,thedegreeofstandardizationwaslimited.
2.1. TheLCZScheme
The LCZ scheme presented in Figure 1 includes ten urban types that describe urban
neighbourhoods in terms of typical building heights and densities, construction materials (i.e.,
lightweightvs. concrete),andvegetationcover. Theseurbantypescanbefurthercategorizedas: dense
urbanfabric(LCZs1to3),openurbanfabric(LCZs4to6),andcommercialandotherurbanfabric
(LCZs7to10). TheLCZschemealsocontainssevennaturaltypes,whicharediscriminatedbythe
abundanceandkindofvegetation,baresoil,barerockandwater.

UrbanSci.2017,1,15 4of21
Urban Sci. 2017, 1, 15 4 of 20
Urban Sci. 2017, 1, 15 4 of 20
Figure 1. Urban (1–10) and natural (A–G) LCZ types and their characteristics (adapted from Table 2
Figure1.Urban(1–10)andnatural(A–G)LCZtypesandtheircharacteristics(adaptedfromTable2
in [14], text shortened, icons reworked) and colour code used in the WUDAPT framework. B:
in[14],textshortened,iconsreworked)andcolourcodeusedintheWUDAPTframework.B:Buildings;
BFiugiuldrien 1g.s ;U Crb: caonv (e1r–; 1M0): amnadt enraiatulsr; aFl : (fAu–nGct)i oLnC; ZT atlylp: >e1s 0a sntdo rtihees,i rM chida-rraiscete: r3i–st9i csst o(raideas,p Lteodw f:r 1o–m3 sTtaobrilees 2.
C:covine r[;1M4],: mtexatt esrhiaolrste;nFe:dfu, niccotnios nr;eTwaollr:k>ed1)0 asntodr iceosl,oMuri dc-ordisee :u3se–d9 sinto rthiees ,WLUowDA:1P–T3 fsrtaomrieews.ork. B:
2.2. LBCuZil dCilnagsss;i fCic: actoiovne rW; Mor: kmflaotwer ials; F: function; Tall: >10 stories, Mid-rise: 3–9 stories, Low: 1–3 stories.
2.2. LCZClassificationWorkflow
The classification workflow is outlined in Figure 2. Since LCZs are visually identifiable from
2.2. LCZ Classification Workflow
Thihgeh-crleassosluifiticoant isoantewllitoer kimflaogweryis, othuet lfiinrsetd stienp Fisig tuo riede2n.tiSfyin acnedL dCigZistizaer erevpirseusaenlltyatiidvee netxiafimapbllees from
(=polTyhgoe ncsl)a ossf iafilcl aLtCioZn tywpoersk pflroewse nist ionu at lciniteyd ( i.ien. , Fthigeu TrAe s2). uSsiinncge t hLeC GZos oagrlee vEiasrutha ldlye sikdteonpt iafpiapblliec aftrioomn.
high-resolution satellite imagery, the first step is to identify and digitize representative examples
high-resolution satellite imagery, the first step is to identify and digitize representative examples
(=polygons)ofallLCZtypespresentinacity(i.e.,theTAs)usingtheGoogleEarthdesktopapplication.
(=polygons) of all LCZ types present in a city (i.e., the TAs) using the Google Earth desktop application.
Figure 2. LCZ classification workflow (by operators) and HUMINEX evaluation (by authors of this study).
TFihgeu rsee 2c.o LnCdZ sctlaesps iifinc atthioen LwCoZrk fclolaws s(ibfyic oapteiorant owrso) arnkdfl oHwU M(FINigEuXr ee v2a,l upaotiionnt (2b)y i asu ttoh odrso owf nthliosa sdtu dLya)n. dsat
Figure 2. LCZ classification workflow (by operators) and HUMINEX evaluation (by authors of
imagery for the city, clip it to the region of interest (including a buffer around the city built-up), and
thisstudy).
resamTphlee stehceo nimd asgteepry i nto t hae c LoCmZm colnas 1si0f0ic amti ognri dw o(grrkifdlo cwe l(lsF iagruer ere 2fe, rproeidn tt o2 )a iss ptoix delosw hnelroea) du sLianngd tshaet
SimAaGgAer yG IfSo rs tohfetw ciatrye, c[3li0p] .i tS tuob tsheeq ureegnitolyn, oaf siuntpeerrevsits (eidn crlaunddinogm a fboureffset rc alarsosuifniedr t[h5e1 c] iitsy abpupillti-eudp t)o, atnhde
Trehseamsepcleo nthde sitmepagienryt htoe aL CcoZmcmlaosns i1fi0c0a mtio gnriwd o(grrkifld ocwells(F airgeu rreefe2r,repdo iton ta2s )piisxetols dhoerwe)n ulosiandg Lthaen dsat
imagSeAryGAfo rGtIhS esocfittwy,arcel i[p30i]t. Stoubtsheequreengtiloyn, ao sfuipnetrevriesesdt (rianncdluomdi nfogreast bculafsfseirfiearr o[5u1n] dis tahpeplcieitdy tob uthilet -up),
andresampletheimagerytoacommon100mgrid(gridcellsarereferredtoaspixelshere)using

UrbanSci.2017,1,15 5of21
theSAGAGISsoftware[30]. Subsequently,asupervisedrandomforestclassifier[51]isappliedto
themultispectralandthermalsatelliteimagedatatocreateanLCZmap(Figure2,point3). Thisis
implementedintheLCZclassificationtoolinSAGAasdetailedin[29]. TheLCZmapistheninspected
visuallybytheoperatorusingGoogleEarthtoevaluatehowwellitmatchestheunderlyingurban
landscape. Subsequently,additionalTAsaredigitizedandexistingTAsaremodifiedforthoseLCZ
classesthatarenotwellrepresentedorwhereconfusionbetweendifferentLCZclasseshasoccurred
(Figure 2, point 4). This procedure is then repeated iteratively until no further improvements are
deemednecessary.
ThisbasicLCZworkflowwasprovidedasasetofonlinetrainingmaterialsthatwereusedin
designated student exercises. Typically, the students (subsequently referred to as operators) were
introduced to the LCZ scheme and the WUDAPT framework before they were provided with the
software and a template containing predefined folders for each LCZ class. Each participant was
asked to define TAs for their specific city according to the WUDAPT protocol, i.e., to be of a size
of approximately 1 km2; to be as homogeneous as possible; to be compact in shape, and to have
sufficientspacealongtheborderswithneighbouringLCZareas. Inaddition,theTAsofeachLCZclass
shouldincludeatleastfivetotenTApolygonsinthefirstroundtocoverthecity-specificclassinternal
variation(e.g.,foranurbanLCZclasstheinternalvariationduetodifferentroofcolors/materials).
2.3. CollectionofMetadataonIndividualOperators
InadditiontotheTAsandLCZmaps,comprehensivemetadatawascollectedfromeachoperator
usingaquestionnaire. Table1providesanoverviewofthecollectedmetadata,rangingfrombasic
information (e.g., age and gender) to LCZ specific knowledge, details on the TA collection and
LCZclassification(e.g.,numberofiterations),andquestionsrelatingtothebehaviouralaspectsand
personality(e.g.,“Iliketocollaborate”). Additionally,someself-assessmentquestionswereasked,
including their assessment of the final LCZ map, their knowledge of the city being mapped, and
theirimageclassificationexperience. ThedesignofthequestionnairewasinfluencedlargelybyVan
Coillieetal.[46],whofoundthattheoperatorperformanceismainlydeterminedbydemographic,
non-cognitiveandcognitivepersonalityfactors,andlessbyexternalandtechnicalfactors.
Table1.Metadatacollectedfromtheparticipants.Theallowedanswersareprovidedinbrackets.
Category MetadataCollected
General ID;Cityname
Numberofoperatorspertrainingareaset;highestdegree(B.Sc./M.Sc./Ph.D.);totalyears
Operator ofstudy(Numberofyears);Universitycourse;ExperiencewithImageClassification
(Self-Estimation1);Age;Gender;Cityoforigin
Introductioninseminar/course(Yes/No);WUDAPTwebsitevisit(Yes/No);studyof
Stewart&Oke2012paper(Yes/No);studyofLCZfactsheets(Yes/No);completionof
LCZknowledge
LCZDrivingtest(Yes/No);Numbersofcitiesclassifiedbefore(Numberofcities);LCZ
knowledgeself-estimation(0–100%)
Howlonghaveyoulivedinthecityofinterest(Numberofyears);howlonghaveyou
Cityknowledge livedinsimilar(climate,morphology)cities(Numberofyears);Familiaritywithcityof
interestself-estimation(0–100%)
Timeinvestedfortrainingareacollection(Numberofhours);Numberofiterations
Classification (Numberofiterations);Usedonlinemanuals?(Yes/No);WhichLCZdidyoufinddifficult
todistinguish?(LCZtype)
Overall Self-Rating(0–100%)offinalclassification[map]quality
Iliketofollowaschedule;Iknowhowtocaptivatepeople;Iamrelaxedmostofthetime;I
don’tmindbeingthecentreofattention;Iseemyselfassympathetic/warm,Iseemyselfas
Personality2
dependable,self-disciplined;Iseemyselfasopentonewexperiences;Iseemyselfascalm,
emotionallystable;Iliketocollaborate.
1Experiencewithimageclassification:0-Novice;1-AdvancedBeginner;2-Competent;3-Proficient;4-Expert;2The
answertothepersonalityquestionswasavaluebetween1and5,where1correspondsto“stronglydisagree”and5
to“stronglyagree”.

UrbanSci.2017,1,15 6of21
ItshouldbenotedthatsomecourseshadalreadystartedwhenHUMINEXwasfullysetup,sothat
themetadatawasnotalwayscollectedduringthemappingexercise. Inthesecases,thequestionnaire
wasfilledinretrospectively,whichimpactedcompletenessandmayhaveaffectedanswersdepending
ontherecalloftheparticipants.
3. DataandMethods
3.1. TAsandLCZMapsCollectedduringHUMINEX
Intotal,sixinstitutionstookpartinHUMINEX,creatingmultipleversionsofTAsandLCZmaps
fortendifferentcities,asoutlinedinTable2andshowninFigure3. 119studentsparticipated,while
thenumberofoperatorsworkingonasinglecityvariedbetweeninstitutions,rangingfromfourfor
Antwerp,Belgium,andDublin,Ireland,to31forthecityofLeuven,Belgium.Moreover,operatorswere
givendifferenttimesforcompletion,fromtwelvehourstoseveralweeksasahomeworkassignment.
In a few cases, two or more participants worked together to digitize the TAs while creating only
asingleLCZmap. AfewoperatorsonlysubmittedtheclassifiedmapsandnottheTAsandwere
excludedfromtheanalysis. Onemapwasnotconsideredduetoanerroneousoutputformatofthe
| classificationresult. | Intotal,94TAsetswereevaluated. |     |     |     |     |
| --------------------- | ------------------------------ | --- | --- | --- | --- |
Table2. ParticipantsandcitiesintheHUManINfluenceEXperiment. ForAUGandTUBmultiple
operators were working on joint TA sets. Students from NOA additionally classified Hamburg,
Madrid,Milan,Prague,Vienna,whichwerenotincludedintheevaluationduetothesmallnumberof
classificationspercity.
Cities
|             |      |          |            | Maximum    | NumberofTA |
| ----------- | ---- | -------- | ---------- | ---------- | ---------- |
|             |      | Numberof | Classified |            |            |
| InstituteID | Name |          |            | Timefor    | SetsUsedin |
|             |      | Students | (Numberof  |            |            |
|             |      |          |            | Completion | Evaluation |
Students)
|     | ArizonaState |     |               | 2weeks     |     |
| --- | ------------ | --- | ------------- | ---------- | --- |
| ASU |              | 7   | Phoenix(7)    |            | 7   |
|     | University   |     |               | (homework) |     |
|     | Universityof |     | Augsburg(12), |            |     |
| AUG |              | 12  |               | homework   | 14  |
|     | Augsburg     |     | Vancouver(12) |            |     |
Universityof
| KUL |     | 31  | Leuven(31) | 9h  | 28  |
| --- | --- | --- | ---------- | --- | --- |
Leuven
National
Observatoryof
Athens&
| NOA |     | 8   | Athens(8) | homework | 8   |
| --- | --- | --- | --------- | -------- | --- |
Universityof
Peloponnese
(Jointcourse)
Technical
| TUB | Universityof | 14  | Berlin(14) | 2days(16h) | 9   |
| --- | ------------ | --- | ---------- | ---------- | --- |
Berlin
Antwerp(4),
Berlin(5),
|     | Ghent      |     | Brussels(5), |     |     |
| --- | ---------- | --- | ------------ | --- | --- |
| GU  |            | 28  |              | 12h | 28  |
|     | University |     | Dublin(4),   |     |     |
Ghent(6),
Vancouver(4)
SincetheWUDAPTprotocolinvolvesaniterativeprocess,additionalTAsweredigitizedand
newLCZmapswereproducedaftereachiteration. Thenumberofiterationsvariedwidelybetween
operators. TUB,NOA,andKULsavedtheTAsetsfromeachiterationforfurtheranalysis.

UrbanSci.2017,1,15 7of21
Urban Sci. 2017, 1, 15 7 of 20
FigurFeig3u.rCel 3a.s Csilfiasesdificeidti ecist:ieAs:n Atwntewrepr,pB, Beleglgiuiumm;; AAtthheennss,, GGrreeeecec;e A;Augusgbsubrug,r Gg,eGrmearmnya; nByer;lBine, rGlienr,mGaenrym; any;
BrussBerluss&selLs e&u vLeenuv,eBne, lBgeiulgmiu;mD; uDbulbinli,n,I rIerelalanndd;; GGhheenntt,, BBeelglgiuiumm; P;hPoheoneixn, iUx,SAU;S VAa;nVcoaunvceoru, vCearn,aCdaa.n ada.
PleasePlneaostee nthotee dthifef edrieffnetresncta slecasleins itnh ethme mapasp.s.© ©I Immaaggeerryy:: GGoooogglele EEaratrht h& &BinBgin AgeAriaelr. ial.
3.2. Accuracy Assessment of the LCZ Maps
3.2. AccuracyAssessmentoftheLCZMaps
We assessed the accuracy of the training data based on the resulting LCZ maps; other sources of
Wereroar stsheasts earde tihnehearcecnut rianc ythoe fmthacehtirnaei nleianrgnidnagt aprboacessesd woenret higenroerseudl.t iFnogr LeaCcZh cmitayp, as; soatmhperles oofu rces
oferrroerfetrhenactea arreeains hweerreen itdeinnttifhieedm bya cahni LnCeZle eaxrpneirnt g(inp rmoocsets csawsese,r teheig cnoourresed t.eaFcohrere)a fcahmciliitayr, waitsha mthpe leof
referemnectehoadreoalosgwy earnedi dtheen tciifitye dunbdyera nstuLdCyZ. Seixnpcee rtthe(i nremferoesntcec adsaetsa, tahree calosuo rasfefetcetaecdh beyr) sfuabmjeicltiiavre with
theminettehropdreotlaotigoyn,a an sdectohnedc eitxypeurnt dreevrieswtuedd yt.heSmin tcoe mthineimreifzeer ethnicse efdfeactta; uanrecleaalsr ocaasfefse cwteerde bexyclsuudbejde ctive
interpfrroemta tthioen s,tuadsye.c ondexpertreviewedthemtominimizethiseffect;unclearcaseswereexcluded
For each map, we derived the following standard accuracy measures from their respective
fromthestudy.
confusion matrices: overall accuracy (OA = percentage of correctly classified pixels); producer
For each map, we derived the following standard accuracy measures from their respective
accuracy (PAi = percentage of correctly classified pixels for class i); user accuracy (UAi = percentage
confusionmatrices:overallaccuracy(OA=percentageofcorrectlyclassifiedpixels);produceraccuracy
of the pixels classified as class i that actually belong to class i); the F1 value, which is the weighted
(PA =percentageofcorrectlyclassifiedpixelsforclassi);useraccuracy(UA =percentageofthepixels
i harmonic mean of UA and PA: F1i = 2 × UAi × PAi/(UAi + PAi); and the κ-iindex, which is a single
classisfiteanddaasrdc lamsesaistuhrae taaccctouuanlltyinbg efloorn gthteo ccllaassss-wi)i;steh peeFr1fovrmalaunec,ew. Ahi cshumismthaeryw oefi grhelteevdanhta ramccounraiccym ean
ofUAmaenadsuPreAs :cFa1ni b=e 2fo×unUd Aini [×52]P. A
i
/(UA
i
+PA
i
);andtheκ-index,whichisasinglestandardmeasure
accountinSginfcoer tthhee ucrlbaasns -LwCiZse typpeersf oarrme oafn pcaer.tiAcuslaurm remleavrayncoef (ree.gle.,v wanitth arcecspuercatc tyo minetraas-uurrbeasnc aclnimbaetifco und
in[52d].ifferentiations) and because several of these types are quite similar, we introduced additional
Saicncuceratchye muerabsaunreLs.C TZhety OpAesurba rise tohfep OaArt iocuf loanrlyr etlheev aunrbcaen( ere.gfe.,rewnicteh proelsypgeocnts taonidn ttrhau-su rgbivaens cthliem atic
differ q e u n a ti l a it t y io f n o s r ) t a h n e d u b rb e a c n a u c s l e as s s e e v s. e r T a h l e o O ft A hbeusiletupt y is p e th s e a r o e v q er u a i l t l e a s c i c m ur il a a c r y , w of e b in u t il r t o v d s u . c n e a d tu a r d a d l i t t y i p on es a l o a n c ly cu , racy
ignoring their internal differentiation. Therefore, we reclassified the maps into urban and natural only
measures. TheOA istheOAofonlytheurbanreferencepolygonsandthusgivesthequalityfor
(class E is omitteudrb since it can be paved (artificial) or rock (natural)). Finally, we introduced a weighted
theurbanclasses. TheOA istheoverallaccuracyofbuiltvs. naturaltypesonly,ignoringtheir
accuracy (WA) measureb,u wilthupich uses a similarity matrix called the LCZ metric (cf. Appendix A) to
internaldifferentiation. Therefore,wereclassifiedthemapsintourbanandnaturalonly(classEis
omittedsinceitcanbepaved(artificial)orrock(natural)). Finally,weintroducedaweightedaccuracy
(WA)measure,whichusesasimilaritymatrixcalledtheLCZmetric(cf. AppendixA)toaccountfor

UrbanSci.2017,1,15 8of21
thesimilaritybetweenLCZtypes. WAisbasedontheclimaticimpactasdiscussedin[15]andconsists
of up to twelve points for the properties openness, height, cover, and thermal inertia, penalizing
confusionbetweendissimilartypesmorethanconfusionbetweensimilarclasses[53]. Forexample,
LCZ1ismostsimilartotheothertwocompacturbantypes(LCZs2and3)andhencethesepairshave
higherweightsthanclasseswhichareverydifferent,suchasLCZ1andthenaturaltypes. Theweights
areappliedtotheconfusionmatrixsothatWAmeasurestheaccuracyoftheLCZmapintermsofthe
expectedthermalimpact,ratherthanthepercentageofpredictedLCZvaluesthatexactlymatchthose
inthereferenceareas.
In addition, we used ordinal statistics to assess the spatial and type wise accordance of the
classificationresultsofdifferentoperators. Inparticular,themodalLCZtype(mostfrequentlychosen
LCZtypeamongNoperators)wascalculatedforeachpixel. Theconsistencyoftheclassforthispixel
wasfurtherdefinedasthepercentageofclassificationswherethemodalclasswaschosen.
4. Results
Theanalysiswasperformedindifferentphases. First,wecomparedtheclassificationsofthesame
citytoassesstheimpactoftheoperatorontheclassificationresult(Section4.1). Second,weconducted
aclass-specificanalysisthroughthecomparisonwithreferencedatatodetermineifsomeLCZtypes
wereconsistentandgenerallyhadhigheraccuraciesthanothers(Section4.2). Third,weassessedthe
accuracyofthedifferentiterationsbydiverseaccuracymeasures(Section4.3);andfinally,theadded
valueofcombiningmultipleTAdatasetstocreateasingleLCZmapwasassessed(Section4.4).
4.1. VariationinClassificationResults
TheLCZclassificationsshowedconsiderablevariationwhencomparedwitheachother. This
isthecaseforallcitiesincludedinHUMINEX.Figures4and5showtheclassificationresultsfrom
thefinaliterationofeachparticipantforBerlinandVancouver,respectively,highlightingdifferences
betweenLCZsandtheirsizeandextent. Overall,thedifferentiationbetweenurbanandnaturalareas
foronecitywassimilar. Yet,someclassificationresultsdifferedconsiderablyfromtherest(e.g.,for
Berlin,themapinthesecondrow,secondcolumnofFigure4). Moreover,thedifferentiationbetween
water(LCZG)andlandsurfaceswasgenerallygood, especiallyforcoastalcities(e.g., Vancouver,
Figure5)orcitieswithanabundanceofwatersurfaces. However,somedeviationsfromthisgeneral
patternexist,e.g.,thefirstclassificationresultforVancouver(Figure5).
ThemodalLCZtypeofallclassificationsforAthens,Greece,isshowninFigure6a,alongwith
thecorrespondingconsistencymap(Figure6b). Asstatedabove,consistencyisdefinedhereasthe
fractionofallmapsthatmatchthemodalclassforthatpixel. ThehighestagreementamongsttheLCZ
mapsforAthenscanbefoundforwatersurfaces(LCZG),densetrees(LCZA),andcentralareasof
thecity(LCZ2)(Figure6). Fortheothertypes,noclearpatternexists.
Figure7shows,asanexample,thedistributionofconsistencyamongstdifferentoperatorsfor
urbanandnaturalLCZtypesforeachcity(Figure7a)andforeachLCZtypeinVancouver(Figure7b).
Forthemajorityoftheconsideredcities,themedianconsistencyfornaturaltypeswashigherthanfor
urbantypes;whileforAntwerpandPhoenix,themedianconsistencyvalueswerethesame(Figure7a).
Sincethepossiblevaluesarediscreteaccordingtothenumberofmapspercityandthemedianis
alwaysoneofthesevalues,themeanconsistencywasalsoevaluated(notshowninFigure7). The
meanurbanconsistenciesvariedbetween0.45forPhoenixand0.69forBrussels. Withtheexceptionof
Antwerp,themeanconsistencywashigherfornaturaltypesthanforurban,withthelargestdifferences
foundinVancouver(meanconsistenciesof0.78forthenaturaltypes(LCZsAtoG)and0.59forthe
urbantypes(LCZs1to10)andBerlin(0.73and0.52,respectively). Figure7billustratesthereason
behindthisfinding: forVancouver,themostprominentnaturalLCZtypesareLCZA(23%ofpixels)
andLCZG(24%ofpixels). TheestimatedconsistencyforthesetwoLCZtypeswashigh(average
valuesof0.82and0.92,respectively),whilefortheurbantypesthemeanconsistencyrangedbetween
0.39(LCZ10, 1%ofpixels)and0.62(LCZ6, 17%ofpixels). Thenaturaltypeswithloweraverage

UrbanSci.2017,1,15 9of21
consistencywereonlypresentinasmallnumberofpixels(withtheexceptionofLCZD;0.50,8%of
pixels). Thisimpliesthatthedominantnaturaltypes(LCZsAtoG)showedhighconsistencyamongst
different operators. However, high consistency does not necessarily mean that the modal LCZ is
correct. Forthisreason,acomparisonwithreferencedata,whichispresentedinthenextsection,was
alsoperformed.
LCZ
1 6 A F
2 7 B G
3 8 C
4 9 D
5 10 E
Figure4.ClassificationresultsusingdifferenttrainingareasetsforBerlin,Germany.

UrbanSci.2017,1,15 10of21
Urban Sci. 2017, 1, 15 10 of 20
LCZ
1 6 A F
2 7 B G
3 8 C
4 9 D
5 10 E
Figure5.ClassificationresultsusingdifferenttrainingareasetsforVancouver,Canada.
Figure 5. Classification results using different training area sets for Vancouver, Canada.
(a) (b)
Figure 6. (a) The modal LCZ type and (b) the consistency (see Section 3.2 for details) for Athens, Greece.
Figure6.(a)ThemodalLCZtypeand(b)theconsistency(seeSection3.2fordetails)forAthens,Greece.

UrbanSci.2017,1,15 11of21
Urban Sci. 2017, 1, 15 11 of 20
Urban Sci. 2017, 1, 15 11 of 20
(a) (b)
Figure 7. (a) Consistency per city for urban (red) and natural (green) LCZ types (including LCZ E:
Figure7. (a)Consistencypercityforurban(red)andnatural(green)LCZtypes(includingLCZE:
paved/rock) and (b) c(oan) sistency per LCZ for Vancouver, Canada. Central m(abr)k is median, the solid
paved/rock)and(b)consistencyperLCZforVancouver,Canada.Centralmarkismedian,thesolid
box corresponds to the 25th–75th percentile range, whiskers extend to all data points not considered
boxcFoirgruersep o7.n (da)s Ctoonthsiest2e5ntchy– p7e5rt hcitpye frocre nurtiblaenr a(rnegde) ,awndh insakteurrsale (xgtreenedn) tLoCaZll tdyapteas p(ionicnlutsdinnogt LcCoZn sEid: ered
outliers; Outliers (distance to solid box greater than 1.5 times its length) are discrete due to the fixed
paved/rock) and (b) consistency per LCZ for Vancouver, Canada. Central mark is median, the solid
outliers;Outliers(distancetosolidboxgreaterthan1.5timesitslength)arediscreteduetothefixed
number N of classifications per city.
box corresponds to the 25th–75th percentile range, whiskers extend to all data points not considered
numberNofclassificationspercity.
outliers; Outliers (distance to solid box greater than 1.5 times its length) are discrete due to the fixed
4.2. LCZ Type Specific Accuracies
number N of classifications per city.
4.2. LCZTypeSpecificAccuracies
The type-specific accuracies for all operators are shown in Figure 8, which plots F1 scores by
4L.C2.Z L tCyZp eT.y LpCe SZpse Acif i(cd Aenccsue rtarceieess ), D (low plants), and G (water) were recognized consistently by all
Thetype-specificaccuraciesforalloperatorsareshowninFigure8,whichplotsF1scoresbyLCZ
operators (high F1 scores). Of the urban types, LCZs 2 (compact midrise), 6 (open low-rise), and 8
type. LCZTshAe t(ydpeen-sspeetcriefeics )a,cDcu(rlaocwiesp floarn tasl)l ,oapnedraGto(rws aartee rs)hwowerne irne cFoiggunriez e8d, wcohnicshis ptelonttsl yFb1 yscaolrleosp beyr ators
(large low-rise) performed well, while LCZ 4 and 5 (open high- and midrise) did not. LCZs 1 (compact
(highLFC1Zs ctyoprees. )L.COZfst hAe (udrebnasen ttryepese)s, ,DL C(lZows 2p(lcaonmts)p, aacntdm Gi d(wriasete)r,)6 w(oerpee nrecloowgn-irziesed) ,coannsdis8te(nlatlryg beyl oawll -rise)
high-rise) and 7 (lightweight low-rise) were not present in most cities under study. In addition, there
operators (high F1 scores). Of the urban types, LCZs 2 (compact midrise), 6 (open low-rise), and 8
performedwell,whileLCZ4and5(openhigh-andmidrise)didnot. LCZs1(compacthigh-rise)and
were differences between cities (vertical lines in Figure 8).
(large low-rise) performed well, while LCZ 4 and 5 (open high- and midrise) did not. LCZs 1 (compact
7(lightweightlow-rise)werenotpresentinmostcitiesunderstudy. Inaddition,thereweredifferences
high-rise) and 7 (lightweight low-rise) were not present in most cities under study. In addition, there
betweencities(verticallinesinFigure8).
were differences between cities (vertical lines in Figure 8).
Figure 8. F1 accuracy (bottom legend) per LCZ type for all classification results.
Figure 9 provides a more detailed illustration of the F1 accuracy score for Augsburg, Germany
Figure 8. F1 accuracy (bottom legend) per LCZ type for all classification results.
and LeuveFni,g Buerlegi8u.mF1. Saicmcuilraarc yto( bFoigttuorme 8le, gsoenmde) LpCerZL tCyZpetsy pweefroer aaclclucrlaastesliyfi ccalatisosnifireedsu (lFts1. close to 1)
in both cities, while others were not. As expected, for both cities, LCZ G was digitized accurately by
Figure 9 provides a more detailed illustration of the F1 accuracy score for Augsburg, Germany
all operators and none reported in the questionnaire that this LCZ type was difficult to identify (cf.
Fanigdu Lreeu9vepnr,o Bveildgeiusma.m Siomrieladr ettoa Filiegduriel l8u,s stormateio LnCoZf ttyhpeesF 1waercec uacrcaucryatseclyo rcelafsosrifiAedu g(Fs1b uclrogse, Gtoe 1rm) any
Table 1). For LCZ A, again most operators identified this category accurately, but some found it hard
andLine ubvotehn c,iBtieeslg, wiuhmile. Soitmheirlsa wrteoreF nigotu. rAes8 e,xspoemcteedL, CfoZr btoytphe csitwiese,r LeCaZc cGu rwaates ldyigciltaizsesdifi aecdcu(rFa1teclylo bsye to1)
all operators and none reported in the questionnaire that this LCZ type was difficult to identify (cf.
inbothcities,whileotherswerenot. Asexpected,forbothcities,LCZGwasdigitizedaccuratelyby
Table 1). For LCZ A, again most operators identified this category accurately, but some found it hard
alloperatorsandnonereportedinthequestionnairethatthisLCZtypewasdifficulttoidentify(cf.
Table1). ForLCZA,againmostoperatorsidentifiedthiscategoryaccurately,butsomefoundithard

UrbanSci.2017,1,15 12of21
todisUtirnbagn uSciis. h20(127,5 1%, 15a nd9%forAugsburgandLeuven,respectively). LowestF1accuraciesw12e orfe 2f0o und
forLCZs9(sparselybuilt)andB(scatteredtrees). ForAugsburg,86%oftheoperatorsidentifiedLCZ
to distinguish (25% and 9% for Augsburg and Leuven, respectively). Lowest F1 accuracies were
B,although25%statedthatitwasdifficulttoidentify. ThisisreflectedinalowmedianF1accuracy
found for LCZs 9 (sparsely built) and B (scattered trees). For Augsburg, 86% of the operators
ofapipdreonxtiifmieadt LelCyZ0 B.1, .alFthooruLgehu 2v5e%n s,ttahteeds tahmate itp wearcs edniftfaicguelto tfo oidpeenrtaiftyo.r Tshiids eisn rteififleecdtetdh iins aL lCoZw bmuetdoiannl y9%
consiFd1e raecdcuirtadcyif ofifc aupltprtooxiidmeantetilfyy 0;.h1.e Freo,r tLheeuovvene,r tahlle msaemdei apneraccecnutargaec yofw opasersaltiogrhs tildyenbteitftieedr (th0.i3s 5L)C.ZL CZ9
inLebuuvte onnwly a9s%m coanpspideedrebdy it5 5d%iffiocufltth teo oidpeenrtaiftyo; rhsearelt, hthoeu ogvher8a2ll% mceodniasnid aecrceudratchyi wscaas tseliggohrtyly absetdteifrfi cult
toide(0n.t3i5fy).. LTChZe 9a icnc uLreaucvyeno wftahsi msLapCpZedw bays 5v5a%r ioafb tlhee, bopetewraetoerns 0altahnodug0h.7 852.%F ocornmsiodsetreodf tthhies coattheegrorcyla sses
as difficult to identify. The accuracy of this LCZ was variable, between 0 and 0.75. For most of the
it was difficultto find a direct relation between theF1 accuracy scores for LCZ categoriesand the
other classes it was difficult to find a direct relation between the F1 accuracy scores for LCZ categories
self-assessedlevelofdifficultyinidentifyingthatcategory. Forexample,LCZ6inLeuvenwasmapped
and the self-assessed level of difficulty in identifying that category. For example, LCZ 6 in Leuven
byalloftheoperatorswithrelativelyhighaccuracies,despitethefactthatalloperatorsindicatedthat
was mapped by all of the operators with relatively high accuracies, despite the fact that all operators
LCZ6wasdifficulttoidentify. Bycomparison,LCZ2inAugsburghadaccuraciesbetween0.5and
indicated that LCZ 6 was difficult to identify. By comparison, LCZ 2 in Augsburg had accuracies
0.9, yet 75% of the operators found this class difficult to distinguish. Note that these inconclusive
between 0.5 and 0.9, yet 75% of the operators found this class difficult to distinguish. Note that these
resultinscmonacylupsaivret lryesourlitgs imnaayte pfarrotlmy otrhigeifnaactet tfrhoamt stohme feacot fthtahte soompeer oaft othres ohpaevraetporrso hvaidvee dprtohveidiredan thsweire rsto
thequanesswtioernsn toa itrheer qeutreosstipoencntaivireel rye.trospectively.
FigurFeig9u.rDe is9t. rDibiusttriiobnustioofnsF 1oaf cFc1u raacccyurfaocrya lflorL CalZl sLfCoZrsA fuogr sAbuurggsb,Guregr,m Gaenrmy(alneyf t)(l,eafnt)d, aLnedu vLeenu,vBeenl,g ium
Belgium (right). Box and whiskers refer to the interquartile range and min -and maximum values,
(right).Boxandwhiskersrefertotheinterquartilerangeandmin-andmaximumvalues,respectively.
respectively. Numbers in blue denote the percentage of operators identifying a specific LCZ in the
NumbersinbluedenotethepercentageofoperatorsidentifyingaspecificLCZinthecity,rednumbers
city, red numbers indicate the percentage of operators tagging a LCZ as difficult to distinguish in the
indicatethepercentageofoperatorstaggingaLCZasdifficulttodistinguishinthequestionnaire(cf.
questionnaire (cf. Table 1).
Table1).
4.3. Iterations
4.3. Iterations
Figure 10 presents the OAurb and κ for Berlin, and OAbuiltup for Leuven by iteration, whilst Figure
F11ig suhroew1s 0thpe rienscerenatsse tihne OOA Aas a fuanncdtioκn foofr thBee irtleirna,tiaonn droOunAd for difffeorrenLt eoupvereantobrsy. Titheer adtiifofenre,nwt hilst
urb builtup
Figuraecc1u1raschyo iwndsicthateorisn cclreeaarslye iimnpOroAveads waiftuh nthceti nounmobfetrh oef iitteerraattiioonns.r Foiugunrde f1o0ra dreivffeearles nthtaot ptheer amtoearns. The
differ O en A turab c in cu cr r e a a c s y ed i n fr d o i m ca i t t o e r r s at c io le n a 1 r l t y o i i m ter p a r ti o o v n e 4 d b w y i m th or t e h t e h n an u m 10 b % e r (f o ro f m it e 0 r .5 a 3 t i t o o n 0 s . . 67 F ) i , g w u h re ile 1 F 0 i a gu re re v e 1 a 0 l b s that
shows that the mean κ increased from 0.67 for iteration 1 to 0.74 for iteration 4 (an increase of 7%).
themeanOA increasedfromiteration1toiteration4bymorethan10%(from0.53to0.67),while
This trendu ribs also visible in Figure 10c, where the mean OAbuiltup for Leuven increased by 6% after
Figure10bshowsthatthemeanκincreasedfrom0.67foriteration1to0.74foriteration4(anincrease
three iterations (from 0.83 for iteration 1 to 0.89 for iteration 3). As the iteration process progresses,
of7%). ThistrendisalsovisibleinFigure10c,wherethemeanOA forLeuvenincreasedby6%
the classification accuracy achieved by the different operators also convbeurgilteudp to a higher accuracy value.
afterTthhries eisi dteerpaitcitoedn sin( fFriogmure0 .1803, wfohreirtee trhaet iboonx 1sitzoe 0(2.58t9hf–o7r5tihte preartcieonnti3le)s.) Aansdt htheei twehraistkioern lepnrgotche (s5sthp–r9o5gthre sses,
theclpaesrsciefinctailteiso) ndeaccrceuasrea cwyitahc nhuiemvbeedr obfy ittehraetidoinfsfe, arenndt aolspoe irna Ftoigrusrael 1s1obc, ownhveererg thede OtoAa, whhigichhe srhaocwcsu racy
valuec.oTnhsiidseirsabdlee pviacrtieadbiliintyF aitg iuterreat1i0o,nw 1,h ceornevtehrgeebs oaxt aspizpero(2xi5mtha–te7ly5 t0h.7p feorrc ietnertailteiosn) a3n. Idn tahdedwitiohnis tkoe rthlee ngth
(5th–r9e5lathtiopnsehricpesn btieltewse)edn eaccrceuarsaecyw aintdh inteuramtiobne,r colafssiitfeicraattioionn tsim, ae nadnda clslaossiinficFatiigoun raecc1u1rbac,yw shelef-rreattinhge OA,
were also reported in the metadata and thus also investigated, but no meaningful correlations were found.
which shows considerable variability at iteration 1, converges at approximately 0.7 for iteration 3.
Inadditiontotherelationshipsbetweenaccuracyanditeration,classificationtimeandclassification
accuracyself-ratingwerealsoreportedinthemetadataandthusalsoinvestigated,butnomeaningful
correlationswerefound.

| UrbanSci.2017,1,15 |     |     |     |     |     |         |     | 13of21 |
| ------------------ | --- | --- | --- | --- | --- | ------- | --- | ------ |
|                    | 1.0 |     | 1.0 |     |     |         | 1.0 |        |
|                    | 0.8 |     | 0.8 |     |     |         | 0.8 |        |
| bru                | 0.6 |     | 0.6 |     |     | putliub | 0.6 |        |
| AO                 |     | a.  | κ   |     | b.  |         |     | c.     |
AO
|     | 0.4          |        | 0.4          |            |        |     | 0.4          |        |
| --- | ------------ | ------ | ------------ | ---------- | ------ | --- | ------------ | ------ |
|     |              | 95%    |              |            | 95%    |     |              | 95%    |
|     |              | 75%    |              |            | 75%    |     |              | 75%    |
|     |              | Median |              |            | Median |     |              | Median |
|     | 0.2          | Mean   | 0.2          |            | Mean   |     | 0.2          | Mean   |
|     |              | 25%    |              |            | 25%    |     |              | 25%    |
|     |              | 5%     |              |            | 5%     |     |              | 5%     |
|     | City: Berlin |        | City: Berlin |            |        |     | City: Leuven |        |
|     | 0.0          |        | 0.0          |            |        |     | 0.0          |        |
|     | 1 2 3        | 4 5 6  | 1            | 2 3        | 4 5 6  |     | 1 2          | 3      |
|     | Iterations   |        |              | Iterations |        |     | Iterations   |        |
Figure10. Resultsofdifferentiterations. (a)urbanOAforBerlin, Germany; (b)κforBerlin, and
| (c)OA | forLeuven,Belgium. |     |     |     |     |     |     |     |
| ----- | ------------------ | --- | --- | --- | --- | --- | --- | --- |
builtup
|     | 1.0                   |               |     |     | 1.0 |                       |           |     |
| --- | --------------------- | ------------- | --- | --- | --- | --------------------- | --------- | --- |
|     | 0.8                   |               |     |     | 0.8 |                       |           |     |
|     | 0.6                   |               |     |     | 0.6 |                       |           |     |
|     | AO                    |               |     |     | AO  |                       |           |     |
|     | 0.4                   |               |     |     | 0.4 |                       |           |     |
|     | 0.2                   |               |     |     | 0.2 |                       |           |     |
|     | Each line corresponds |               |     |     |     | Each line corresponds |           |     |
|     |                       |               | a.  |     |     |                       |           | b.  |
|     |                       | to a student. |     |     |     | to a student.         |           |     |
|     | 0.0                   |               |     |     | 0.0 |                       |           |     |
|     | 1 2                   | 3 4 5         | 6 7 |     | 1   |                       | 2         | 3   |
|     |                       | Iteration     |     |     |     |                       | Iteration |     |
Figure11.Resultsofindividualoperatorsatdifferentnumberofiterations.(a)OAforBerlin,Germany
and(b)OAforLeuven,Belgium.
4.4. MultipleTrainingSets
Thefinalexperimenttestedifadditionaltrainingdataimprovetheclassification. Therefore,the
accuracymeasureswerecomparedacrossthedifferentcities(Table3)using:
(1) themeanaccuraciesachievedacrossindividualruns,i.e.,theLCZmapscreatedwithoneTAset
asshowninFigure12aforLeuven(=µofindividualruns);
(2) thebestaccuraciesachievedacrosstheindividualruns, whichrequirespriorknowledgeand
thereforecannotbedonewithoutreferencedata(=bestrun);
(3) theaccuraciesachievedwhenselectingthemostfrequentlychosencategoryacrosstheindividual
maps(=modalLCZ);and
(4) theaccuraciesachievedwhencombiningallTAsintoasingleLCZclassificationpercity.
Figure 12b shows all the TAs digitized by the operators for Leuven, which are then used to
createasingleLCZmapforthecity(=allin). Thisexampleimplementstheideaofthewisdomofthe
crowd[54]orverificationofLinus’Law[55],andexamineswhetherthecombinedeffortsmightyield
abetterLCZmapthanindividualones.

| UrbanSci.2017,1,15 |     |     |     |     | 14of21 |
| ------------------ | --- | --- | --- | --- | ------ |
Table3.Resultsoftheexperimentcomparingtheuseofmultipletrainingareas.N:numberoftraining
areasets;1.mean(µ)and2.bestaccuraciesofNindividualclassifications;3.ModalofallTA:accuracies
ofmodalLCZtypefromNclassifications;4.allTAsusedtocreateasingleLCZmap:accuraciesifone
classificationusingalltrainingareas.
CITY Antwerp Athens AugsburgBerlin Brussels Dublin Ghent Leuven Phoenix Vancouver
| N 4 | 8 7 | 14 5 | 4 6 | 28 7 | 11  |
| --- | --- | ---- | --- | ---- | --- |
1.µsingleruns
| OA 0.71 | 0.56 0.66 | 0.76 0.71 | 0.71 0.61 | 0.72 0.18 | 0.78 |
| ------- | --------- | --------- | --------- | --------- | ---- |
| k 0.67  | 0.52 0.58 | 0.72 0.67 | 0.65 0.55 | 0.64 0.12 | 0.73 |
| OA 0.70 | 0.54 0.60 | 0.61 0.59 | 0.55 0.55 | 0.60 0.30 | 0.57 |
urb
| OA 0.93 | 0.92 0.85 | 0.96 0.94 | 0.93 0.96 | 0.89 0.66 | 0.91 |
| ------- | --------- | --------- | --------- | --------- | ---- |
builtup
| WA 0.93 | 0.91 0.90 | 0.95 0.93 | 0.91 0.91 | 0.92 0.64 | 0.93 |
| ------- | --------- | --------- | --------- | --------- | ---- |
2.bestsinglerun
| OA 0.75 | 0.74 0.71 | 0.93 0.85 | 0.74 0.72 | 0.83 0.28 | 0.87 |
| ------- | --------- | --------- | --------- | --------- | ---- |
| k 0.72  | 0.71 0.63 | 0.92 0.82 | 0.68 0.68 | 0.78 0.20 | 0.83 |
| OA 0.72 | 0.74 0.81 | 0.89 0.74 | 0.65 0.75 | 0.80 0.44 | 0.82 |
urb
| OA 0.93 | 0.97 0.90 | 0.99 0.98 | 0.95 0.99 | 0.97 0.79 | 0.96 |
| ------- | --------- | --------- | --------- | --------- | ---- |
builtup
| WA 0.95 | 0.95 0.92 | 0.98 0.97 | 0.91 0.95 | 0.95 0.72 | 0.97 |
| ------- | --------- | --------- | --------- | --------- | ---- |
3.modeallTA
| OA 0.79         | 0.73 0.79 | 0.95 0.81 | 0.75 0.66 | 0.85 0.23 | 0.87 |
| --------------- | --------- | --------- | --------- | --------- | ---- |
| k 0.76          | 0.70 0.72 | 0.93 0.78 | 0.69 0.61 | 0.80 0.17 | 0.83 |
| OA urb 0.76     | 0.75 0.66 | 0.89 0.70 | 0.69 0.76 | 0.77 0.41 | 0.74 |
| OA builtup 0.94 | 0.97 0.91 | 0.99 0.98 | 0.93 0.95 | 0.94 0.75 | 0.93 |
| WA 0.95         | 0.95 0.94 | 0.99 0.97 | 0.92 0.93 | 0.95 0.68 | 0.96 |
4.allTAin
| OA 0.79 | 0.75 0.85 | 0.94 0.86 | 0.79 0.80 | 0.92 0.23 | 0.93 |
| ------- | --------- | --------- | --------- | --------- | ---- |
| k 0.77  | 0.72 0.80 | 0.93 0.84 | 0.74 0.76 | 0.90 0.17 | 0.91 |
| OA 0.72 | 0.77 0.85 | 0.87 0.79 | 0.66 0.72 | 0.89 0.36 | 0.84 |
urb
| OA 0.94 | 0.99 0.92 | 1.00 0.97 | 0.95 0.99 | 0.98 0.82 | 0.97 |
| ------- | --------- | --------- | --------- | --------- | ---- |
builtup
| WA 0.96                 | 0.96 0.96 | 0.99 0.98 | 0.93 0.97 | 0.98 0.72 | 0.98      |
| ----------------------- | --------- | --------- | --------- | --------- | --------- |
| Urban Sci. 2017, 1, 15  |           |           |           |           | 14 of 20  |
|                         | (a)       |           |           | (b)       |           |
Figure 12. (a) Multiple individual classifications for comparison of accuracy measures and (b) the
Figure12. (a)Multipleindividualclassificationsforcomparisonofaccuracymeasuresand(b)the
combined training areas from all participants to create a single LCZ map for the city of Leuven, Belgium.
combinedtrainingareasfromallparticipantstocreateasingleLCZmapforthecityofLeuven,Belgium.
Table 3. Results of the experiment comparing the use of multiple training areas. N: number of training
Theaarcecau sreatsc;y 1.o fmtehaen m(µo) danadl L2.C bZesmt aacpcusra(3ci.esin ofT aNb lined3iv)iwduaasl bcleatstseifrictahtiaonns;t h3.e Mavodearla gofe aallc cTuAr:a cyofthe
mapsfromacctuhraeciiensd oifv midoudaall LTCAZ steytpse (f1ro)mfo Nr aclllasmsifeiacastuiorness; 4a.n adll cTiAtise suseexdc teop ctrefaotre Oa Asingle LCZf omraDp:u  blinand
built-up
accuracies if one classification using all training areas.
Ghent. TheclassificationresultsusingmultipleTAsets(4)werealwaysbetterthantheaverageofthe
individCuIaTlYr unAsn(t1w)e,rapn dAfthoern8s 2%Auogfsbthureg citBieerslianndBrmusesealssurDeus,bltihneaGchceunrtacLyeuwveans ePvheonenhixig  hVearncthouavnerforthe
| N  4  | 8 7  | 14 5 | 4 6 | 28 7  | 11  |
| ----- | ---- | ---- | --- | ----- | --- |
1. µ single runs
OA  0.71  0.56  0.66  0.76  0.71  0.71  0.61  0.72  0.18  0.78
ĸ  0.67  0.52  0.58  0.72  0.67  0.65  0.55  0.64  0.12  0.73
OAurb  0.70  0.54  0.60  0.61  0.59  0.55  0.55  0.60  0.30  0.57
OAbuiltup  0.93  0.92  0.85  0.96  0.94  0.93  0.96  0.89  0.66  0.91
WA  0.93  0.91  0.90  0.95  0.93  0.91  0.91  0.92  0.64  0.93
2. best single run
OA  0.75  0.74  0.71  0.93  0.85  0.74  0.72  0.83  0.28  0.87
ĸ  0.72  0.71  0.63  0.92  0.82  0.68  0.68  0.78  0.20  0.83
OAurb  0.72  0.74  0.81  0.89  0.74  0.65  0.75  0.80  0.44  0.82
OAbuiltup  0.93  0.97  0.90  0.99  0.98  0.95  0.99  0.97  0.79  0.96
WA  0.95  0.95  0.92  0.98  0.97  0.91  0.95  0.95  0.72  0.97
3. mode all TA
OA  0.79  0.73  0.79  0.95  0.81  0.75  0.66  0.85  0.23  0.87
ĸ  0.76  0.70  0.72  0.93  0.78  0.69  0.61  0.80  0.17  0.83
OAurb  0.76  0.75  0.66  0.89  0.70  0.69  0.76  0.77  0.41  0.74
OAbuiltup  0.94  0.97  0.91  0.99  0.98  0.93  0.95  0.94  0.75  0.93
WA  0.95  0.95  0.94  0.99  0.97  0.92  0.93  0.95  0.68  0.96
4. all TA in
OA  0.79  0.75  0.85  0.94  0.86  0.79  0.80  0.92  0.23  0.93
ĸ  0.77  0.72  0.80  0.93  0.84  0.74  0.76  0.90  0.17  0.91
OAurb  0.72  0.77  0.85  0.87  0.79  0.66  0.72  0.89  0.36  0.84
OAbuiltup  0.94  0.99  0.92  1.00  0.97  0.95  0.99  0.98  0.82  0.97
WA  0.96  0.96  0.96  0.99  0.98  0.93  0.97  0.98  0.72  0.98
The accuracy of the modal LCZ maps (3. in Table 3) was better than the average accuracy of the
maps from the individual TA sets (1) for all measures and cities except for OAbuilt-up for Dublin and
Ghent. The classification results using multiple TA sets (4) were always better than the average of the
individual runs (1), and for 82% of the cities and measures, the accuracy was even higher than for the

UrbanSci.2017,1,15 15of21
bestindividualTAset(2). TheaverageincreaseoverthetencitiesinOA(OA )was0.102(0.151)
urb
forthemodalcategory(3), and0.145(0.184)forthemultipleTAclassification(4)comparedtothe
meanoftheindividualruns(1). ComparedtothebestindividualrunforthemultipleTAclassification
(2),theaverage(urban)OAstillincreasedby0.042(0.010). Figure13showsthedistributionofthe
improvementsforthemodalclassification(3)andtheclassificationusingmultipleTAscompared(4)
withtheaverageaccuraciesoftheindividualmaps(1). ItcanbeseenthatOA,κ,andOA benefited,
urb
inparticular,fromtheadditionaltrainingdata.
weighted weighted
OA OA
builtup builtup
OA
urb OA
urb
κ κ
OA a. OA b.
-0.1 0.0 0.1 0.2 0.3 0.00 0.05 0.10 0.15 0.20 0.25 0.30
Accuracy Improvement Accuracy Improvement
Figure13.Improvementswithadditionaltrainingdata:(a)modaltypeand(b)multipletrainingareas
(TA)resultvsaverageofindividualTAsets.Distributionfortencities.
Figure14showsthedependencyoftheaccuracyimprovementinthefivestandardmeasures
on the number N of available TA sets. There was a strong positive correlation found between the
improvementandN.LessimprovementwasseenintheOA andtheWA,sincebotharealready
builtup
quitehighfortheindividualclassifications. Thisincreasewasnotlinearbutrathershowedastrong
increaseinthebeginningandsaturationatabouttentofifteenTAsetsformostaccuracymeasures.
ThisseemstobeastrategytoimprovetheaccuracyofWUDAPTLCZmaps, buttheeffectofbad
qualityTAsandtheneedforfilteringprocessesinsuchasetupneedtobeinvestigatedinmoredetail.
0.30
0.25
0.20
0.15
0.10
0.05
0.00
0 5 10 15 20 25 30 35
Number of TAs
tnemevorpmI
ycaruccA
)nur.elgnis.μ.sunim.ni.AT.lla(
OA
Logarithmic.fit
κ
Logarithmic.fit
OAurb
Logarithmic.fit
OAbuiltup
Logarithmic.fit
Weighted
Logarithmic.fit
Figure14.DependencyoftheaccuracyimprovementonthenumberofavailableTAsets.
5. Discussion
HUMINEXshowedthattherearelargedifferencesbetweendifferentLCZmapsgeneratedfora
singlecity. TheconsistencyandaccuracymeasuresindicatedthatthequalityofsingleTAsetsand
theresultingLCZmapswas,inmostcases,poortomoderate. Furthermore,thereweredifferences
foundbetweenthecities,whichcanpartlybeexplainedbysmalldifferencesintheexperimentalsetup.
In particular, the Phoenix classifications performed substantially worse than the other cities. This

UrbanSci.2017,1,15 16of21
couldbeexplainedbythestructureoftheexerciseonthiscity,whichallocatedoperatorstodifferent
areasinthePhoenixmetropolitanarea;theTAsweresupposedtobecombinedintoacity-wideTAset
subsequently,butneverthelesswereevaluatedseparatelyhere. Therefore,theindividualTAsetsdid
notincludeallLCZs(forexample,high-rise(LCZs1and4)wasonlyfoundinPhoenixDowntown,
butnowhereelse)anddidnotrepresentthevariationwithinthescene. Yet,evenbycombiningallthe
TAs,theoverallaccuracywasnotgreatlyimprovedforthiscity,mainlybecauseiterationswerenot
performeduntiltheaccuracyconvergedtoastablevalue.
For many TA sets, the number of iterations was low and iterations were not performed until
classification results converged to acceptable results due to the schedules of the different courses.
Whiletheseproblemscouldclearlybeidentifiedintheaccuracyassessment,thereareotherfactors
suchasthenumberandtypeofclassespresent,domainsize,andfrequencydistributioninreference
data, which hamper an inter-city comparison. For instance, coastal cities typically achieve higher
OA, since the LCZ type G (water) is comparably easy to detect. This underlines the added value
of the new accuracy measures based on the urban types, built-up and WA for different purposes.
However,itremainsashortcomingofanon-stratifiedsamplingapproachthattheaccuracymeasures
maybebiasedtowardssomecategories,whichwasaddressedbycarefulselectionandcheckingofthe
referencedata.
Generally, the results show that it is more difficult for largely untrained operators to identify
TAsforLCZclassificationthanexpected. Whilethisinfluenceofhumaninterpretationisageneral
topicinremotesensing[46]andcrowdsourcing[56],someaspectsarespecifictotheLCZtypology. In
particular,urbanmorphologiesareacontinuumandtherealexistingformsaremorediversethanthe
idealizedtypes(e.g.,mixtureofdifferentheightanddensities),whichimpliesacertainfuzzinessofthe
system. Moreover,thesizeofhomogenousareasgreatlydependsontheexistingandpastplanning
regulations and there is some evidence that in some cases (e.g., smaller towns, historic cores, and
rapidlyevolvingcities),thetypicalpatchesmightbesmallerthantheneighbourhoodscale(≤1km2).
Inaddition,someLCZcategoriescausespecificproblems. Forexample,LCZ9(sparselybuilt)isurban,
buthasabuiltfractionoflessthan20%,whichisdifficulttodefineinthegivenspatialresolution,since
atthelocalscalemanypixelswillcontainnohouses. LCZE(barerockorpaved)canbeeitherpaved
or natural stone, which makes little difference for the climatic impact but an enormous difference
forsettlementmapping. Moreover,operatorsoftendonotfollowtherecommendationfordefining
TAsregardingsize,shape,anddistancetootherLCZsasspecifiedintheinstructions. Insummary,it
canbestatedthat: (1)operatorknowledgeiscritical(hencetheneedforstandardizedtrainingand
assessment);and(2)independentcontrols(referencedataorreviewbyatrainedexpert)arenecessary.
However,thereisalsogoodnewsforthevalidityofcrowdsourceddataonurbanstructurein
theWUDAPTframework. First,thequalityoftheclassificationsclearlyimprovedwiththenumber
ofiterations,whichindicatesthatgoodclassificationscanbeachievedifsufficienttimeisinvested,
eventhoughthegeneralrelationbetweentimeandaccuracyoveralldatasetswasunclear. Thelatter
wasalsothecaseformostotherparametersofthemetadataandthefewsignificantcorrelationsfound
werepartlycontradictiveorcounter-intuitiveandthusneedfurtherinvestigationbeforepublication.
Inadditiontothedifficultiesininter-citycomparisonsdiscussedabove,thiscanberelatedtothepartly
retrospectivecollectionofmetadata,sincesomecourseshadalreadystartedwhiletheexperimentwas
stillinthedesignphase, resultinginareducedqualityof, andconsiderablegapsin, themetadata.
Thismightalsopartlyexplainwhytherewasgenerallylittleagreementbetweenthequalityofthe
classificationandtheself-assessmentbytheparticipants. Therefore,theexperimentiscurrentlybeing
repeatedwithamorerigidsetupandmorestandardizedprotocolsinasecondphaseofHUMINEX.
Second,astrikingandwelcomefindingwasthatconsiderableimprovementoftheLCZmaps
couldbeachievedbycombiningmultipletrainingdatasets. Despitethevariableaccuracyofindividual
LCZ maps, the aggregation of all TA sets showed improved accuracy, which is evidence for the
‘wisdomofthecrowd’. Moreover, thedependencyoftheaccuracyonthenumberofavailableTA
setsshowedastrongincreaseinthebeginning,withsaturationafterwards,indicatingthatTAsets

UrbanSci.2017,1,15 17of21
fromabouttentofifteenindividualscouldresultinagoodqualityLCZmap. Thisissimilartothe
findingbyHaklayetal.[55]inthecontextofthepositionalaccuracyofroadfeaturesinOpenStreetMap
asafunctionofthenumberofvolunteers,whofoundthatthefirstfivevolunteersmakethelargest
contributionstoimprovingthepositionalaccuracy. Thus,onefuturestrategyforWUDAPTwillbeto
focusonthecollectionofaminimumoftensetsofTAspercity.
6. Conclusions
Inthispaper,wehavepresentedtheresultsofHUMINEX,anexperimenttoassesstheinfluence
ofindividualoperatorsinclassifyingurbanareasintoLCZsaccordingtotheWUDAPTprotocol. Six
universitiescontributedtotheexperimentwithatotalof94setsoftrainingdatafrom119operators
fortendifferentcities. Despitesomelimitationsintheexperimentalsetup,wewereabletocollect
consistentresultsacrosstheinstitutions. Specifically,wefoundthatsomeLCZscouldbeidentifiedin
thelandscapewithoutdifficulty(e.g.,LCZsAorG),whileothercategoriesposedproblemsresultingin
lower consistencies and accuracies. This was independent of the geographic location of the city
or climatic region. In most cases, these LCZ categories were also reported as ‘hard to classify’
(=identify)bytheparticipants,indicatingthatthisquestionmightberelevantforevaluationofsingle
LCZclassifications. Inaddition,wefoundthatwithanincreasingnumberofiterationsintheLCZ
classificationprocess,theaccuracyoftheclassificationimproved,indicatingthattheexistingWUDAPT
protocolisavalidapproachforLCZmapping,butthatatleastfouriterationsshouldbecarriedout.
Finally,itwasshownthatclassificationsusingthemodeofallavailableclassificationsorusingmultiple
trainingdatasetsforoneclassificationhadhigheraccuraciesthanthemeanaccuracyofindividual
classificationsofacity,andoftenevenhigherthanthebestone. Thiswasespeciallytruefortheurban
LCZtypes. Fromtheseresults,weconcludethatatleasttenindividualTAsetsshouldbeusedforone
citytoproduceaLCZmapofgoodquality,althoughthisaspectneedsfurtherinvestigation.
Hence, HUMINEX is currently being continued in a second phase with a more systematic
approach. This includes a standardized introduction to the topic as part of the student courses
within participating institutions and a focus on a single city. This could help to address further
questions,suchas: CanthequalityofLCZTAsbeassessedfromtheTAthemselves? Canthequality
ofLCZTAsbeassessedfromoperatorself-assessment? Doesthepersonalityoftheoperatorinfluence
theclassificationquality? IslocalknowledgeakeyfactorforanaccurateLCZclassification?
Itgoeswithoutsayingthateducationandthemotivationoftheoperatorsareindispensablefor
achievinggoodresults. Thus,improvedcoursematerialsanda‘drivingtest’forLCZknowledgeto
helpbecomefamiliarwiththeLCZschemeandtobetterrecognizeLCZclassesfromaerialimagery
arecurrentlybeingdeveloped.
Acknowledgments:Mostofallwethanktheparticipatingstudents,namely:AlexApostolakis,LienArnalsteen,
Julia Bartsch, Jeany Behrens, Gunnar Berghman, Anjes Bloch, Kasper Bonte, Willem Boone, Eirini Bouskou,
Adamantia Boutsi, Fran Broekmans, Gauthier Buyse, Gauthier Buyse, Thomas Chavakis, Tina Christmann,
MarnickClé,IliasDaradimos,VasilikiDaskalopoulou,KarelDeBauw,FienDeDoncker,AntonDeboeck,Koen
Devos,SinahDrenske,AthanasiosDrivas,AnnElen,VeraGebhardt,IoannisGerardis,DavidHaaf,NoraHerbosch,
TonyHuang,CuineraIsenborghs,HannahJacobs,NickKalogeras,IoannisKaravasilis,DavidKöhler,Michael
Kottas,CarolinaKrynda,CarinaLemke,AnneliesLoos,AnneliesLoos,AmberMertens,DorienMollen,Katharina
Patricia, Ellen Philips, Siebe Puynen, Siebe Puynen, Maria Reisert, Lukas Röder, Spyridon Savvas, Stefanie
Schepers, Vasileios Sitokonstantinou, Laurence Stalmans, Sara Stoffels, Helena Tavernier, Helena Tavernier,
RhuneVanCleemput,JonasVandenBrande,KorneelvanDooren,WouterVanRoeyen,RoxanneVanhaeren,
KasperVanRoey,VyronVasileiadis,VincetVerswijvel,MarliesVervoort,AxelleVincent,JefVinken,Odysseas
Vlachopoulos,Pieter-JanVroom,SimonWeber,MaximilianWirth,NeleWuytsaswellasthosewhowereforgotten
ordidnotdeliverthemetadata.WewouldalsoliketothankIainStewartforsupportwiththeLCZmetricand
alldataproviders,i.e.,NASAandUSGS.ThisworkwaspartlysupportedbytheClusterofExcellence‘CliSAP’
(EXC177),UniversityofHamburg,fundedthroughtheGermanScienceFoundation(DFG)andtheEUFP7funded
ERCgrantCrowdland(No.617754).
AuthorContributions:BenjaminBechtel,DanielFenner,OscarBrousseandMatthiasDemuzerefirstconceived
oftheideaforrunningtheHUMINEX.OscarBrousse,PanagiotisSismanidis,IphigeniaKeramitsoglou,Daniel
Fenner, Marco Otto, Marie-Leen Verdonck, Matthias Demuzere, Ariane Middel and Christoph Beck ran the

UrbanSci.2017,1,15 18of21
Urban Sci. 2017, 1, 15 18 of 20
HUMINEXexperimentwiththeirstudents.BenjaminBechtelmostlyanalysedthedata,supportedbyMatthias
HUMINEX experiment with their students. Benjamin Bechtel mostly analysed the data, supported by Matthias
DemuzereandPanagiotisSismanidisinparticular.Alloftheauthorscontributedtothewritingofthepaper.
Demuzere and Panagiotis Sismanidis in particular. All of the authors contributed to the writing of the paper.
ConflictsofInterest:Theauthorsdeclarenoconflictofinterest.
Conflicts of Interest: The authors declare no conflict of interest.
AppendixA
Appendix A
Figure A1. LCZ metrics: similarity used for the weighted accuracy (WA).
FigureA1.LCZmetrics:similarityusedfortheweightedaccuracy(WA).
References
References
1. Makse, H.A.; Havlin, S.; Stanley, H.E. Modelling urban growth patterns. Nature 1995, 377, 608–612.
1. Makse,H.A.;Havlin,S.;Stanley,H.E.Modellingurbangrowthpatterns.Nature1995,377,608–612.[CrossRef]
2. Batty, M. Cities and Complexity: Understanding Cities with Cellular Automata, Agent-Based Models, and Fractals;
2. Batty,M.CitiesandComplexity:UnderstandingCitieswithCellularAutomata,Agent-BasedModels,andFractals;
MIT Press: Cambridge, MA, USA, 2005.
M3. ITPScrehsnse:idCearm, Ab.;r Widogoed,cMocAk,, CU.SEA. C,o2m00p5a.ct, dispersed, fragmented, extensive? A comparison of urban growth
3. Schneinid tewre,nAty.;-Wfivoeo gdlocboaclk c,itCie.sE u.sCinogm rpemacott,edlyis spenersseedd d,aftraa, gpmatteenrnte md,eetrxictes nansidv cee?nAsusc oinmfopramraistioonn.o Ufrubrabn aSntugdr. owth
intwe20n0t8y,- fi45v, e65g9lo–6b9a2l. citiesusingremotelysenseddata,patternmetricsandcensusinformation.UrbanStud.
240. 08,J4h5a,, 6A5.9K–.;6 M92i.ne[Cr, rTo.sWsR.; eSft]anton-Geddes, Z. Building Urban Resilience: Principles, Tools, and Practice; World
4. Jha,AB.aKn.k; MPuinbelirc,aTti.oWn.s;: SWtaanshtoinng-Gtoend, DdeCs,, UZS.AB,u 2il0d1i3n.g UrbanResilience:Principles,Tools,andPractice;WorldBank
5. Satterthwaite, D.; Dodman, D. Towards resilience and transformation for cities within a finite planet.
Publications:Washington,DC,USA,2013.
Environ. Urban. 2013, 25, 291–298.
5. Satterthwaite, D.; Dodman, D. Towards resilience and transformation for cities within a finite planet.
6. Meerow, S.; Newell, J.P.; Stults, M. Defining urban resilience: A review. Landsc. Urban Plan. 2016, 147, 38–49.
Environ.Urban.2013,25,291–298.[CrossRef]
7. Batty, M. The New Science of Cities; MIT Press: Cambridge, MA, USA, 2013.
6. Meerow,S.;Newell,J.P.;Stults,M.Definingurbanresilience:Areview.Landsc.UrbanPlan.2016,147,38–49.
8. Kitchin, R. The real-time city? Big data and smart urbanism. GeoJournal 2014, 79, 1–14.
[CrossRef]
9. White, L.; Burger, K.; Yearworth, M. Smart Cities: Big Data and Behavioral Operational Research. In
7. Batty,BMeha.vTiohrealN OewperSactiioennacle RofesCeairticehs; ;KMuInTc,P Mre.,s sM:aClpaamssb, rJi.d, gWeh,iMteA, L,.U, ESdAs.,; 2P0a1l3g.rave Macmillan: London, UK,
8. Kitch2in01,6R; .pTph. 3e0r3e–a3l1-8ti.m ecity?Bigdataandsmarturbanism.GeoJournal2014,79,1–14.[CrossRef]
9. W10h. iteE,sLch.;, BTu.;r gMear,rcKo.n;cYienai,r wMo.; rFthel,bMie.r,S Am.a; rRtoCthit, iAes.:; BHiegldDeantsa, aWn.d; HBuehbearv, iMor.a; lSOchpwerinagtieorn, aMl.R; eTsaeuabrecnhb.oIcnkB, Heh.a; vioral
OperaMtiuonllaelr, RAe.s; eDaercchh;, SK. uUnrbca,nM fo.,otMprainlpt apsros,ceJs.s,oWr—hFiutell,yL a.u,tEomdsa.t;edP aplrgorcaesvseinMg cahcamini lglaenne:raLtionngd soetntl,emUeKn,t 2016;
pp.30m3a–s3k1s8 f.rom global data of the TanDEM-X mission. IEEE Geosci. Remote Sens. Lett. 2013, 10, 1617–1621.
11. Pesaresi, M.; Ferri, S.; Ehrlich, D.; Florczyk, A.J.; Freire, S.; Halkia, M.; Julena, A.; Kemper, T.; Soille, P.;
10. Esch,T.; Marconcini,M.; Felbier,A.; Roth,A.; Heldens,W.; Huber,M.; Schwinger,M.; Taubenbock,H.;
Syrris, V. Operating Procedure for the Production of the Global Human Settlement Layer from Landsat Data of the
Muller,A.;Dech,S.Urbanfootprintprocessor—Fullyautomatedprocessingchaingeneratingsettlement
Epochs 1975, 1990, 2000, and 2014; JRC Technical Report; Publications Office of the European Union:
masksfromglobaldataoftheTanDEM-Xmission. IEEEGeosci. RemoteSens. Lett. 2013,10,1617–1621.
Luxembourg, 2016; Volume EUR 27741 EN.
[CrossRef]
11. Pesaresi,M.; Ferri,S.; Ehrlich,D.; Florczyk,A.J.; Freire,S.; Halkia,M.; Julena,A.; Kemper,T.; Soille,P.;
Syrris,V.OperatingProcedurefortheProductionoftheGlobalHumanSettlementLayerfromLandsatDataof
theEpochs1975,1990,2000,and2014; JRCTechnicalReport; PublicationsOfficeoftheEuropeanUnion:
Luxembourg,2016;VolumeEUR27741EN.

UrbanSci.2017,1,15 19of21
12. Bechtel,B.;Pesaresi,M.;See,L.;Mills,G.;Ching,J.;Alexander,P.J.;Feddema,J.J.;Florczyk,A.J.;Stewart,I.
Towardsconsistentmappingofurbanstructures—Globalhumansettlementlayerandlocalclimatezones.
ISPRSInt.Arch.Photogramm.RemoteSens.Spat.Inform.Sci.2016,XLI-B8,1371–1378.[CrossRef]
13. Mills,G.;Ching,J.;See,L.;Bechtel,B.;Feddema,J.;Masson,V.;Stewart,I.;Neophytou,M.;O’Connor,M.;
Chen,F.;etal.IntroductiontotheWUDAPTproject.InProceedingsofthe9thInternationalConferenceon
UrbanClimate,Toulouse,France,20–24July2015.
14. Stewart,I.D.;Oke,T.R.LocalClimateZonesforUrbanTemperatureStudies.Bull.Am.Meteorol.Soc.2012,
93,1879–1900.[CrossRef]
15. Stewart,I.D.;Oke,T.R.;Krayenhoff,E.S.Evaluationofthe“localclimatezone”schemeusingtemperature
observationsandmodelsimulations.Int.J.Climatol.2014,34,1062–1080.[CrossRef]
16. Alexander,P.J.;Mills,G.LocalclimateclassificationandDublin’surbanheatisland. Atmosphere2014,5,
755–774.[CrossRef]
17. Lehnert, M.; Geleticˇ, J.; Husák, J.; Vysoudil, M. Urban field classification by “local climate zones” in a
medium-sizedCentralEuropeancity:ThecaseofOlomouc(CzechRepublic).Theor.Appl.Climatol.2015,
122,531–541.[CrossRef]
18. Fenner, D.; Meier, F.; Scherer, D.; Polze, A. Spatial and temporal air temperature variability in Berlin,
Germany,duringtheyears2001–2010.UrbanClim.2014,10(Part2),308–331.[CrossRef]
19. Arnds,D.;Böhner,J.;Bechtel,B.Spatio-temporalvarianceandmeteorologicaldriversoftheurbanheat
islandinaEuropeancity.Theor.Appl.Climatol.2017,128,43–61.[CrossRef]
20. Brousse,O.;Martilli,A.;Foley,M.;Mills,G.;Bechtel,B.WUDAPT,anefficientlanduseproducingdata
toolformesoscalemodels?IntegrationofurbanLCZinWRFoverMadrid.UrbanClim.2016,17,116–134.
[CrossRef]
21. Alexander,P.J.;Bechtel,B.;Chow,W.T.L.;Fealy,R.;Mills,G.Linkingurbanclimateclassificationwithan
urbanenergyandwaterbudgetmodel: Multi-siteandmulti-seasonalevaluation. UrbanClim. 2016,17,
196–215.[CrossRef]
22. Wouters,H.;Demuzere,M.;Blahak,U.;Fortuniak,K.;Maiheu,B.;Camps,J.;Tielemans,D.;vanLipzig,N.P.M.
Theefficienturbancanopydependencyparametrization(SURY)v1.0foratmosphericmodelling:Description
andapplicationwiththeCOSMO-CLMmodelforaBelgiansummer.Geosci.ModelDev.2016,9,3027–3054.
[CrossRef]
23. Bechtel,B.;Daneke,C.ClassificationofLocalClimateZonesbasedonmultipleEarthObservationdata.
IEEEJ.Sel.Top.Appl.EarthObs.RemoteSens.2012,5,1191–1202.[CrossRef]
24. Lelovics,E.;Unger,J.;Gál,T.;Gál,C.DesignofanurbanmonitoringnetworkbasedonLocalClimateZone
mappingandtemperaturepatternmodelling.Clim.Res.2014,60,51–62.[CrossRef]
25. Gal, T.; Bechtel, B.; Lelovics, E. Comparison of two different Local Climate Zone mapping methods.
InProceedingsoftheICUC9,Toulouse,France,20–24July2015.
26. Geleticˇ,J.; Lehnert,M.GIS-baseddelineationoflocalclimatezones: Thecaseofmedium-sizedCentral
Europeancities.Morav.Geogr.Rep.2016,24.[CrossRef]
27. Weng, Q. (Ed.) Global Urban Monitoring and Assessment through Earth Observation; Remote Sensing
ApplicationsSeries;CRCPress:BocaRaton,FL,USA,2014.
28. Casonne, A. Deriving Local Climate Zones from Remote Sensing Data. Master’s Thesis, University of
Strasbourg,Strasbourg,France,2016.
29. Bechtel,B.;Alexander,P.J.;Böhner,J.;Ching,J.;Conrad,O.;Feddema,J.;Mills,G.;See,L.;Stewart,I.Mapping
LocalClimateZonesforaworldwidedatabaseoftheformandfunctionofcities.ISPRSInt.J.Geo-Inf.2015,
4,199–219.[CrossRef]
30. Conrad,O.;Bechtel,B.;Bock,M.;Dietrich,H.;Fischer,E.;Gerlitz,L.;Wehberg,J.;Wichmann,V.;Böhner,J.
System for Automated Geoscientific Analyses (SAGA) v. 2.1.4. Geosci. Model Dev. 2015, 8, 1991–2007.
[CrossRef]
31. Bechtel,B.;See,L.;Mills,G.;Foley,M.ClassificationofLocalClimateZonesusingSARandmulti-spectral
datainanaridenvironment.IEEEJ.Sel.Top.Appl.EarthObs.RemoteSens.2016,9,3097–3105.[CrossRef]
32. Danylo,O.;See,L.;Bechtel,B.;Schepaschenko,D.;Fritz,S.ContributingtoWUDAPT:ALocalClimate
ZoneclassificationoftwocitiesinUkraine.IEEEJ.Sel.Top.Appl.EarthObs.RemoteSen.2016,9,1841–1853.
[CrossRef]

UrbanSci.2017,1,15 20of21
33. Kaloustian,N.;Bechtel,B.LocalclimaticzoningandurbanheatislandinBeirut. Proced. Eng. 2016,169,
216–223.[CrossRef]
34. Xu,Y.;Ren,C.;Meng,C.;Ng,E.;Wu,T.ClassificationoflocalclimatezonesusingASTERandLandsatdata
forhigh-densitycities.IEEEJ.Sel.Top.Appl.EarthObs.RemoteSens.2017.[CrossRef]
35. Tuia,D.;Moser,G.;Saux,B.L.;Bechtel,B.;See,L.2017IEEEGRSSDataFusionContest:OpenDataforGlobal
MultimodalLandUseClassification[TechnicalCommittees].IEEEGeosci.RemoteSens.Mag.2017,5,70–73.
[CrossRef]
36. Mitraka, Z.; Frate, F.D.; Chrysoulakis, N.; Gastellu-Etchegorry, J.P. Exploiting Earth Observation data
productsformappingLocalClimateZones.InProceedingsofthe2015JointUrbanRemoteSensingEvent
(JURSE),Ecublens,Switzerland,30March–1April2015;pp.1–4.
37. Bechtel,B.;Demuzere,M.;Xu,Y.;Verdonck,M.L.;Lopes,P.;See,L.;Ren,C.;VanCoillie,F.M.B.;Tuia,D.;
Fonte,C.C.;etal. BeyondtheUrbanMask: LocalClimateMaskZonesasaGenericDescriptorofUrban
Areas—PotentialandRecentDevelopments.InProceedingsoftheIEEE2017JointUrbanRemoteSensing
Event(JURSE),Dubai,UAE,6–8March2017.
38. Tuia, D.; Moser, G.; Wurm, M.; Taubenbock, H. Land Use Modelling in North Rhine-Westphalia with
InteractionandScalingLaws.InProceedingsoftheIEEE2017JointUrbanRemoteSensingEvent(JURSE),
Dubai,UAE,6–8March2017.
39. Perera,N.G.R.; Emmanuel,R.A“LocalClimateZone”basedapproachtourbanplanninginColombo,
SriLanka.UrbanClim.2016.[CrossRef]
40. Goodchild,M.F.Citizensassensors: Theworldofvolunteeredgeography. GeoJournal2007,69,211–221.
[CrossRef]
41. See,L.;Mooney,P.;Foody,G.;Bastin,L.;Comber,A.;Estima,J.;Fritz,S.;Kerle,N.;Jiang,B.;Laakso,M.;etal.
Crowdsourcing,citizenscienceorVolunteeredGeographicInformation?Thecurrentstateofcrowdsourced
geographicinformation.ISPRSInt.J.Geo-Inf.2016,5,55.[CrossRef]
42. Howe,J.Theriseofcrowdsourcing.WiredMag.2006,14,1–4.
43. InternationalAssociationforUrbanClimate.Availableonline:http://www.urban-climate.org/(accessed
on13March2017).
44. Foody,G.M.;See,L.;Fritz,S.;VanderVelde,M.;Perger,C.;Schill,C.;Boyd,D.S.Assessingtheaccuracyof
VolunteeredGeographicInformationarisingfrommultiplecontributorstoanInternetbasedcollaborative
project:AccuracyofVGI.Trans.GIS2013,17,847–860.[CrossRef]
45. Foody,G.M.;See,L.;Fritz,S.;VanderVelde,M.;Perger,C.;Schill,C.;Boyd,D.S.;Comber,A.Accurate
attributemappingfromVolunteeredGeographicInformation: Issuesofvolunteerquantityandquality.
Cartogr.J.2015,52,336–344.[CrossRef]
46. VanCoillie,F.M.B.;Gardin,S.;Anseel,F.;Duyck,W.;Verbeke,L.P.C.;Wulf,R.R.D.Variabilityofoperator
performanceinremote-sensingimageinterpretation:Theimportanceofhumanandexternalfactors.Int.J.
RemoteSens.2014,35,754–778.[CrossRef]
47. Flanagin,A.;Metzger,M.Thecredibilityofvolunteeredgeographicinformation.GeoJournal2008,72,137–148.
[CrossRef]
48. Antoniou,V.;Skopeliti,A.MeasuresandindicatorsofVGIquality: Anoverview. InISPRSAnnalsofthe
Photogrammetry,RemoteSensingandSpatialInformationSciences;ISPRSAnnals: LaGrandeMotte,France,
2015;VolumeII-3/W5,pp.345–351.
49. Allahbakhsh,M.; Benatallah,B.; Ignjatovic,A.; Motahari-Nezhad,H.R.; Bertino,E.; Dustdar,S.Quality
controlincrowdsourcingsystems:Issuesanddirections.IEEEInternetComput.2013,17,76–81.[CrossRef]
50. Fonte,C.C.;Bastin,L.;See,L.;Foody,G.;Lupia,F.UsabilityofVGIforvalidationoflandcovermaps.Int.J.
Geogr.Inf.Sci.2015,29,1269–1291.[CrossRef]
51. Breiman,L.RandomForests.Mach.Learn.2001,45,5–32.[CrossRef]
52. Congalton,R.G.Areviewofassessingtheaccuracyofclassificationsofremotelysenseddata.RemoteSens.
Environ.1991,37,35–46.[CrossRef]
53. Stewart, I.; Global Cities Institute, University of Toronto, Toronto, Canada, LCZ metric. Personal
communication,2016.
54. Surowiecki,J.TheWisdomofCrowds;AnchorBooks:NewYork,NY,USA,2005.

UrbanSci.2017,1,15 21of21
55. Haklay,M.;Basiouka,S.;Antoniou,V.;Ather,A.Howmanyvolunteersdoesittaketomapanareawell?
ThevalidityofLinus’Lawtovolunteeredgeographicinformation.Cartogr.J.2010,47,315–322.[CrossRef]
56. See,L.;Comber,A.;Salk,C.;Fritz,S.;VanderVelde,M.;Perger,C.;Schill,C.;McCallum,I.;Kraxner,F.;
Obersteiner,M.Comparingthequalityofcrowdsourceddatacontributedbyexpertandnon-experts.PLoS
ONE2013,8,e69958.[CrossRef][PubMed]
©2017bytheauthors.LicenseeMDPI,Basel,Switzerland.Thisarticleisanopenaccess
articledistributedunderthetermsandconditionsoftheCreativeCommonsAttribution
(CCBY)license(http://creativecommons.org/licenses/by/4.0/).
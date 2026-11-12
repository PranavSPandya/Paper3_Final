Generating WUDAPT level 0 data –current status of
production and evaluation
BenjaminBechtel,PaulJ.Alexander,ChristophBeck,JürgenBöhner,Oscar
Brousse,JasonChing,MatthiasDemuzere,CidáliaFonte,TamásGál,Julia
Hidalgo,PeterHoffmann,ArianeMiddel,GeraldMills,ChaoRen,LindaSee,
PanagiotisSismanidis,Marie-LeenVerdonck,GuangXu,YongXu
AngabenzurVeröffentlichung/Publicationdetails:
Bechtel,Benjamin,PaulJ.Alexander,ChristophBeck,JürgenBöhner,OscarBrousse,Jason
Ching,MatthiasDemuzere,etal.2019.“GeneratingWUDAPTlevel0data–currentstatusof
productionandevaluation.”UrbanClimate27:24–45.https://doi.org/10.1016/j.uclim.2018.10.001.
Nutzungsbedingungen/Termsofuse: CCBY-NC-ND4.0
DiesesDokumentwirdunterfolgendenBedingungenzurVerfügunggestellt:/Thisdocumentismadeavailableundertheseconditions:
CC-BY-NC-ND4.0:CreativeCommons:Namensnennung-Nichtkommerziell-KeineBearbeitung
WeitereInformationenfindenSieunter:/Formoreinformationsee:
https://creativecommons.org/licenses/by-nc-nd/4.0/deed.de

–
Generating WUDAPT Level 0 data Current status of production
and evaluation
Benjamin Bechtela,⁎ , Paul J. Alexanderb, Christoph Beckc, Jürgen Böhnera,
Oscar Broussed, Jason Chinge, Matthias Demuzeref, Cidália Fonteg, Tamás Gálh,
Julia Hidalgoi, Peter Hoffmannj,1, Ariane Middelk, Gerald Millsl, Chao Renm,
Linda Seen, Panagiotis Sismanidiso, Marie-Leen Verdonckp, Guang Xuq, Yong Xur
aUniversityofHamburg,Inst.ofGeography,Bundesstraße55,20146Hamburg,Germany
bCentralStatisticsOffice(CSO),CensusGeography,Swords,Dublin,Ireland
cUniversityofAugsburg,InstituteofGeography,AlterPostweg118,86159Augsburg,Germany
dKULeuven,DepartmentofEarthandEnvironmentalSciences,DivisionofGeography,Celestijnenlaan200E,3001,Leuven,Belgium
eUniversityofNorthCarolinaatChapelHill,ChapelHill,NC,UnitedStates
fLaboratoryofHydrologyandWaterManagement,GhentUniversity,CoupureLinks653,B-9000Gent,Belgium
gUniversityofCoimbra,DepartmentofMathematics,P-3001-501Coimbra,Portugal
hUniversityofSzeged,DepartmentofClimatologyandLandscapeEcology,Egyetemu.2,H-6723Szeged,Hungary
iNationalCenterofScientificResearch(CNRS),InterdisciplinaryLaboratorySolidarities,Society,Territories(LISST),5,alléesAntonioMachado,
31058Toulouse,France
jUniversityofHamburg,DepartmentofMathematics,Bundesstraße55,20146Hamburg,Germany
kSchoolofArts,MediaandEngineering,SchoolofComputing,Informatics,andDecisionSystemsEngineering,ArizonaStateUniversity,Tempe,AZ
85281,UnitedStates
lUCD,SchoolofGeography,Belfield,Dublin4,Ireland
mFacultyofArchitecture,TheUniversityofHongKong,HongKongSAR,China
nInternationalInstituteforAppliedSystemsAnalysis,EcosystemsServicesandManagementProgram,Schlossplatz1,A-2361,Laxenburg,Austria
oNationalObservatoryofAthens,InstituteforAstronomy,Astrophysics,SpaceApplicationsandRemoteSensing,Vas.Pavlou&I.Metaxa,15236
Penteli,Greece
pGhentUniversity,Laboratoryofforestmanagementandspatialinformationtechniques,CoupureLink653,B-9000Gent,Belgium
qMonashUniversity,SchoolofEarth,AtmosphereandEnvironment,9RainforestWalk,ClaytonCampusWellingtonRoadClayton,VIC3800,
Australia
rSchoolofCivilEngineering,PurdueUniversity,US
ABSTRACT
TheWorldUrbanDatabaseandAccessPortalTools(WUDAPT)projecthasgrownoutoftheneedforbetterinformationontheformandfunctionof
citiesglobally.CitiesaredescribedusingLocalClimateZones(LCZ),whichareassociatedwitharangeofkeyurbanclimatemodelparametersand
thuscanserveasinputstohighresolutionurbanclimatemodels.Werefertothisaslevel0dataforeachcity.
TheLCZlevel0productisproducedusingfreelyavailableLandsatimagery,crowdsourcedtrainingareasfromthecommunity,andtheopen
sourceSAGAsoftware.ThispaperoutlinestheprotocolbywhichLCZmapsgeneratedbydifferentmembersofthecommunityareproducedand
evaluated.Inparticular,thequalityassessmentcomprisescross-validation,review,andcross-comparisonwithotherdatasets.
⁎Correspondingauthor.
E-mailaddresses:benjamin.bechtel@uni-hamburg.de(B.Bechtel),paul.alexander@cso.ie(P.J.Alexander),
christoph.beck@geo.uni-augsburg.de(C.Beck),juergen.boehner@uni-hamburg.de(J.Böhner),oscar.brousse@kuleuven.be(O.Brousse),
matthias.demuzere@ugent.be(M.Demuzere),cfonte@mat.uc.pt(C.Fonte),tgal@geo.u-szeged.hu(T.Gál),julia.hidalgo@univ-tlse2.fr(J.Hidalgo),
peter.hoffmann@hzg.de(P.Hoffmann),ariane.middel@asu.edu(A.Middel),gerald.mills@ucd.ie(G.Mills),renchao@hku.hk(C.Ren),
see@iiasa.ac.at(L.See),panosis@noa.gr(P.Sismanidis),marieleen.verdonck@ugent.be(M.-L.Verdonck),guang.xu@monash.edu(G.Xu),
xu1129@purdue.edu(Y.Xu).
1Presentaddress:ClimateServiceCenterGermany(GERICS),Fischertwiete1,20095Hamburg,Germany.

To date, the results from the different quality assessments show that the LCZ maps are generally of moderate quality, i.e. 50–60% overall
accuracy(OA),butthisismuchhigherwhenconsideringallbuilt-upclassestogetherorusingweightsthattakethemorphologicalandclimatic
similarity of certain classes into account. The training data contributed by researchers from around the world also vary in quality andin the
interpretationofthelandscape,whichaffectsthefinalqualityoftheLCZmaps.
Theacceptablelevelofqualityneededwilldependheavilyontheapplicationofthedata.However,initialmodellingstudiesthatusethelevel0
productsasinputsshowedimprovedperformanceinsimulatingtheurbanclimatewhenreplacingthedefaultsurfacedescriptionswiththeWUDAPT
level0data.Thisisalsopromisingfortheapplicationoflevel0datainregionalandglobalclimateandweathermodelsandsupportstheassumption
thatthecurrentlevel0productsarealreadyofsufficientqualityforcertainapplications.Moreover,therearevariousongoingdevelopmentsto
improvethemethodsusedtoproduceLCZmapsandtheiraccuracy.
1. Introduction
TheWorldUrbanDatabaseandAccessPortalTools(WUDAPT)projecthasgrownoutoftheneedforbetterinformationonthe
form and function of cities globally (Mills et al., 2015). Developed as a bottom-up initiative from members of the urban climate
community,citiesarebeingclassifiedusingtheLocalClimateZone(LCZ)schemedevelopedbyStewartandOke(2012).Consistingof
10urbanclassesand7naturalclasses(seeFig.1b),theLCZclassificationprovidesarichsourceofinformationabouturbanareasthat
isconsistentandcomparableacrosscities.Althoughdatasetsofurbanorbuilt-upareasexist,theyeitherlackdetailbeyondurban/
non-urbanclasses,e.g.theGlobalHumanSettlementLayer(GHSL)producedbytheJRC(Pesaresietal.,2013)andtheGlobalUrban
Footprint(GUF+)productofDLR(Eschetal.,2017),ortheyarenotavailableglobally,e.g.theUrbanAtlas2012,whichisonly
availableforEUcitieswith50,000inhabitantsormore(EEA,2012).Inaddition,eachLCZhasanassociatedrangeofvaluesfora
numberofkeyurbanclimatemodelparameters.Hence,anLCZmapcanbeusedasaninputtohighresolutionurbanclimatemodels.
Thisishighlyrelevantastheerrorsinmodelledurbansurfaceenergybalancecomponentstendtobedominatedmorebythechoice
ofurbancanopyparameters(UCPs)thanbythephysicsandcomplexityofvariousurbanlandsurfacemodels(Demuzereetal.,2017).
In addition, recent work has shown that using UCPs derived from LCZ maps can lead to improved urban climate model results
(Brousseetal.,2016;Woutersetal.,2016;Hammerbergetal.,2018).
LCZmapsofthecityarereferredtoasthe‘level0’productastheyrepresentthefirstlevelofinformationabouturbanareas.
Levels1and2representmoredetailedandhigherresolutioninformation;thereaderisreferredtoChingetal.(2018)forfurther
details.TheWUDAPTcommunityprovidesaprocedureforgeneratingtheLCZlevel0product,whichusesfreelyavailableLandsat
imagery,GoogleEarthforcreatingthetrainingareas(TA),andtheopensourceSAGAsoftware(Conradetal.,2015),embeddedina
workflowthatisintendedtobeeasytofollowsothatcommunitymembersaroundtheworldcanproduceLCZmapsoftheirown
cities.However,thereareotherapproachesforgeneratingLCZlevel0products,whichcanalsoleadtothemoredetailedlevel1and
2data.Oneapproachistosampletheurbanlandscapeusingfieldwork;thisrequiresconsiderableexpertiseasshownbyHouetand
Pigeon(2011)andLeconteetal.(2015)forToulouseandNantes,France,respectively.Inothercases,wherethedataareavailable,
administrativedata(onbuildingfootprints,heights,greenspaces,etc.)andGeographicInformationSystem(GIS)softwarecanbe
used.Raster-based methods superimpose astandardgridovertheurban landscape andinformation aboutselectedvariables (e.g.
buildingheight,skyviewfactor)canbeacquiredatthescaleoftheindividualcell.Eachvariablerepresentsalayerandthegridded
layersarethencombinedusingrulestogenerateLCZtypes.ThismethodhasbeenusedtogenerateLCZmapsforHongKong(Zheng
et al., 2017), for Nagpur in India (Kotharkar and Bagade, 2018), for three medium-sized Central European cities, Brno, Hradec
Fig.1.a)TheLocalClimateZone(LCZ)rasterandvectordataprocessingworkflow(Bechteletal.,2015).b)theLCZtypes(StewartandOke,2012;
Bechteletal.,2017b).
25

Kralove,andOlomoucintheCzechRepublic(GeletičandLehnert,2016)andforBilbaoinSpain(Aceroetal.,2013).Vector-based
methods capturetheboundary oftheLCZneighbourhood andrepresenta moreprecisedelineation ofcontiguousneighbourhood
typesasindividualobjects;Ungeretal.(2014)andPereraandEmmanuel(2018)haveusedthismethodforSzegedandColombo,
respectively.GiventhatmanydifferentindividualsareproducingLCZmapsusingdifferentmethods,theymustgothroughaprocess
ofqualitycontrolbeforetheycanbeuploadedtotheWUDAPTportal(accessiblefromthewudapt.orgwebsite)fordisseminationto
thewidercommunityofusers(Millsetal.,2015;Chingetal.,2018).
The aim of this paper is to outline the processes by which LCZ maps generated by different members of the community are
evaluatedandtohighlightongoingdevelopmentsinmethodsforimprovingtheclassificationaccuracyofLCZmaps.Thenextsection
givesabriefoutlineoftheworkflowforproducingtheWUDAPTlevel0LCZproductsfollowedbyarangeofmethodsusedinthe
quality control process. The paper then discusses ongoing developments in the improvement of the product and concludes with
reflectionsonfuturedevelopmentsofWUDAPT.
2. Productionworkflow
2.1. LCZmappingandthelevel0productionprotocol
For LCZ mapping, a supervised machine learning approach with multispectral data from remote sensing and crowdsourced
trainingdataareused(Bechtel,2011;BechtelandDaneke,2012).TheuniversalityofLCZs(Fig.1b),coupledwiththeirsimplified
representation of the urban landscape, allows users to easily identify them from satellite images using guidance provided on the
WUDAPTwebsite.Tothatend,theWUDAPTprojectaimstocollectLCZdatasetsforvariouscitiesaroundtheworldbyinvolving
volunteerlocalexpertsinsatelliteimageclassification.Open-accesssatelliteimagery,suchasSentinel2orLandsat8,supportsthe
philosophy and initiative of the WUDAPT project and allows the consistent and effective application of WUDAPT's LCZ mapping
schemeglobally.
WUDAPT'sstandardLCZclassificationworkflow(Bechteletal.,2015)showninFig.1acomprisesthreekeyoperations:firstthe
preprocessing of the satellite raster data (ideally several cloud-free images should be used that correspond to various seasons);
secondlythedigitizationandpreprocessingofappropriateTA;andthirdlytheapplicationoftheclassificationalgorithm.Toachieve
thedesiredhighquality,operations2and3shouldbeperformediterativelyuntilthereisagoodmatchbetweentheclassification
outputandtheunderlyingurbanlandscape.Inparticular,theusershouldcomparetheclassifiedLCZmapwiththecorresponding
GoogleEarthimageryandthen,basedonobservedinconsistencies,adjusttheTAsaccordinglyoraddadditionalones.Theuserthen
re-appliestheclassificationalgorithmusingtherevisedTAdata.Thisiterativeprocessshouldbeperformedasmanytimesasneeded
inordertoachieveahighqualityLCZmap.TheabovethreeoperationsareperformedinSAGAGIS(Conradetal.,2015)andin
GoogleEarth,whilethesatellitedataarefromSentinel2orLandsat8OLI-TIRS.
ThepreprocessingoftheLandsat8rasterdataisperformedinSAGAGISandincludesthecroppingofthedatatotheregion-of-
interest(ROI)boundariesandtheresamplingoftheimagedatatoacommon-sizedgrid.Landsat8acquiresdataatthevisibleand
near-infrared(VNIR),shortwaveinfrared(SWIR)andthermalinfrared(TIR)regionsoftheelectromagneticspectrum.Theground
samplingdistanceoftheVNIRandSWIRbandsis30mand100mfortheTIR.Afterpreprocessing,theLandsat8dataarereadytobe
usedinWUDAPT'sLCZclassificationalgorithm.
ThesecondinputtotheclassificationalgorithmaretheTApolygons.TherequiredTAdataareacquiredbythevolunteerlocal
experts.TheycorrespondtopolygonsrepresentingcontinuousandhomogenousLCZsoverlargeenoughpatches(ideallyabout1km2)
andaredirectlydrawnintheformofvectorisedKMZfilesoversatelliteimageryprovidedinGoogleEarth.EvenifLCZsaredesigned
Fig.2.TheLCZproductionandqualityassessmentworkflow.
26

asuniversalclasses,theirspectralsignaturescandifferacrosstheworld,acrossregions,orevenacrossacity.Therefore,theTAsused
shouldbecity-specificandtheusersshouldtakeparticularcareintheirselection.Thisisbecausetheyarethekeytoachievingahigh
LCZclassificationaccuracy.
Aftertheinitialselection oftheTAdata,thenextstepistheapplication oftheLCZclassificationalgorithm.Thisoperationis
incorporated in SAGA GIS for the purpose of WUDAPT as discussed in Bechtel et al. (2015). The classification algorithm re-
commendedforWUDAPTisaRandomForestclassifier,whichconsistsofintegrateddecisiontreesthatclassifyeachimagepixelinto
oneLCZtype.Therandomforestclassifierhasbeenselectedduetoitsincreasedmappingandcomputationalperformanceasde-
monstrated in Bechtel and Daneke (2012). Moreover, it is non-parametric which means it supports different appearances of the
classes.
Onceavolunteerhasproducedamapofsufficienthighquality,therespectiveTAandLandsatdataaresubmittedtotheWUDAPT
team.ThesubmitteddataismadeavailableviatheWUDAPTwebsitebutitisfurtherprocessedintheWUDAPTproductionchain
(Fig.2)beforeinclusioninthedatabaseandportal.Morespecifically,wheneveratrainingdataorLandsatimagefileiscreatedor
modified,ahashvalue(anumberoffixedsizetoidentifyuniquedatasets)iscalculatedandcomparedwiththepreviouslyprocessed
versions. If the file is new, the classification, postprocessing, and documentation process is started. This involves an automated
quantitative quality assessment (see below), conversion into multiple file formats such as geoTIFF, and the creation of metadata
factsheets.Finally,amanualreviewisdonebyexperts(seesection3.2).TheLCZmapsarethenincludedintheDatabase(DB).The
LCZmapsandmetadataaremadeaccessibleviathetheWUDAPTportal(https://wudapt.cs.purdue.edu/),whereseveraladditional
toolsareavailable.NotethattheWUDAPTportalfacilitatesuserstoutilizeLCZandrelatedmorphologicalandphysicalparameters
(UCPs)formodelapplicationsusingthevariousurbanoptionsintheWeatherResearchandForecasting(WRF)modellingsystem
(Chingetal.,2018).
3. Qualityassessment
QualityassessmentandcontrolarecriticalforthesuccessofWUDAPT.However,thequestionofhowtodefineandmeasurethe
quality of an LCZ map is not straightforward and the appropriateness of a data set largely depends on the requirements of the
applicationsinwhichtheLCZmapswillbeused.Fundamentally,twoquestionsneedconsideration:whatisthecorrectLCZforapixel
andhowdowebestmeasureaccuracy?
ThefirstquestionisrelatedtogeneralmattersoftheappropriatenessofLCZmapping,whicharediscussedinBechteletal.(2015)
indetail.Oneproblemisthefuzziness(orcompositeblendoftypologicalbuildingmixtures)thatemergesfromthediscretisationofa
multidimensional space of morphologies based on compactness, height and other properties, into discrete classes, where real
neighbourhoodscanhavecharacteristicsofseveralclassessuchasamixtureofhigh-,mid-,andlow-risebuildings.Secondly,this
Fig.3.ScaledependencyofLCZscheme;a)CentreofBerlinaerialimage©GoogleEarth;b)buildingfootprintsfromOpenStreetMap;compactness
classaccordingtotheLCZschemeatresolutionsofc)100m,d)250m,e)500mandf)1000m.
27

depends on the spatial scale, as illustrated in Fig. 3 for the case of central Berlin, Germany. The building footprints from Open-
StreetMap(OSM)wereusedtocalculatethebuildingfractionatdifferentscalesfrom100mto1000m,allofwhichfallintotherange
ofscalesgivenbytheLCZdefinition.Theclassesnatural,sparse,open,andcompactareoneofthebasicdiscriminatorsoftheLCZ
system,yetitcanbeseenthattheresultsvaryconsiderablywithscale.Inparticular,the1000mscalemightbethemostappropriate
intermsoftheclimaticdefinitionoflocalscale,butitistoocoarsetoevendetectcentralBerlinasacompactstructure.Ontheother
hand,the100mresolutionmightbethebestrepresentationbuttheresultingpatternistoonoisytorepresenthomogenouslocalscale
zones.Inotherwords,thedecisionaboutwhichscaletouseimpliesanintendedlevelofgeneralisationandhencethe“correct”value
forapixelalsodependsonitssurroundings,whichisinherentinthedefinitionofalocalscalezone.
Thesecondquestionregardinghowtomeasureaccuracyisaschallengingasthefirstone,sincethereisnoglobalindependent
referencedata(orgroundtruth)ofLCZtypesforurbanareas.Asystematicsamplingofreferencedatawouldbeverytimeconsuming
andcounteractmostofthebenefitsofthechosenapproach,particularlyintermsofefficiency.Moreover,thesampledreferencedata
wouldinheritthesameuncertaintiesintermsofhumanrecognitionoftheclassesoroperatorbias.
Therefore,threeapproachesareusedinacombinedqualityassessmentofthelevel0LCZmaps.Thefirsttwoarecross-validation
(section3.1)andmanualreview(section3.2).TogetherthesetwoapproachesdeterminewhetheraLCZmapisofacceptablequality
andcanbereleasedopenlyontheWUDAPTportal.Thethirdapproachiscross-comparisonwithotherdata,whichisdescribedin
moredetailinSection4.
3.1. Cross-validation
Thefirstqualitycontrol processforthelevel0 LCZproduct usesan automated cross-validation approachon theoriginal grid
resolutionof100m,whichemploysbootstrapping(KaloustianandBechtel,2016;Bechteletal.,2016b).Theworkflowisoutlinedin
Fig.4.Bootstrappingmeansthatarandomsamplingschemeisappliedtoestimateaccuracymeasuresfromagivensample–theTA–
andcontrol for their consistency and thestability of the results. Here a number of sub-samples are used to performthe machine
learningandclassificationandtheaccuracyisevaluatedwiththenon-usedsamples.Specifically,25differentRandomForestsare
trained,applied,andevaluated,eachusing50%ofthetrainingpolygonsfortraining(stratifiedbyclass)andtheremaining50%for
testing.Inadditiontotheaccuracyestimatesthisprocedurealsoallowstomapthepercentageofrunsresultinginthemostfrequently
chosen(modal)LCZtype,whichprovidesaspatialmeasureforthecertaintyoftheresultsovertheentiredomainandnotonlythetest
polygons.
Foreachrun,fiveaccuracymeasuresarecomputedfromtheconfusionmatrixofthetestdata:
− overallaccuracy(OA)forallpolygons(percentageofcorrectlyclassifiedpixels);
− kappa,whichisastandardmeasureaccountingforaccuraciesofdifferentclasses;
− OA_urb,whichistheOAononlytheurbanpolygons,whichisnecessarysinceOAisoftenbiasedbylargeTAfornaturalclasses(in
particularwater);
− OA_builtup,whichistheOAoftheclassificationintwoclassesonly,i.e.urbanandnatural.LCZE(barerockorpaved)isomitted,
sinceitcanbeinboth;
− weightedaccuracy(WA),whichisametricthataccountsforsimilarityanddissimilaritybetweenclasses(seeFig.5bandBechtel
etal.(2017b)formoredetails).
Fig.4.Overviewoftheautomatedqualityassessmentworkflowwithbootstrapping.
28

Fig.5.a)BootstrappingresultsforBerlin;b)similarityofLCZtypesappliedtoaweightedaccuracymeasure.Source:Bechteletal.(2017b).
Fig. 5a shows a boxplot of the distribution of these accuracies across the 25 runs for an LCZ map of Berlin. These accuracy
measuresarereportedintheL0meta-datasheetsthataccompanyeachLCZmap.Aminimumaverageaccuracyof50%isrequiredfor
eachaccuracymeasuretopasstheautomatedqualitycontrolbeforetheproductisreviewedandsubsequentlydisseminatedviathe
WUDAPTportal.Ifallaccuracymeasuresreachaminimumlevelof45%,thequalityflag‘warning’isassignedtothedataset(cf.
Fig.4).ThesemeasuresreflecttherobustnessofthetrainingdatabuttheydonotindicatewhethertheTAsaresemanticallycorrect,
onlythattheyareconsistent.
3.2. Manualreview
The subsequent quality control involves a manual review of the LCZ maps, i.e. visual comparison of the map with very high
resolutionimageryfromGoogleEarth.Thismethodisusedtofinderroneousinterpretationsofthelandscapebytheoperatorand
areasthatareincorrectlyclassifiedandthereforeneedadditionaltrainingdata.Anumberofdifficultiesarecommon.Theseinclude
theconfusionofsimilarclasses(suchasLCZs3and7,AandB,or8,10andE);interpretationscalesthatdonotmatchthe100m
resolutionoftheclassifier(e.g.largeareaswithoutbuildingslabelledasLCZ9);TAwhicharetoosmallortooclosetootherLCZ
types;andtheuseofnon-persistentlandcoversasTA(e.g.tidalinfluence,ricepaddies,constructionsiteslabelledassand(LCZF),
agriculturalareasasbaresoil(LCZD).Moreover,somelandcovertypes(e.g.green-houses)arecurrentlynotcoveredbytheLCZ
schemeormustbeaddedtotheclass(e.g.snow).Whilesomeoftheseareactuallyaddressedbythedigitisingguidelinesbutnot
alwaysfollowed,othersmayneedtobeincorporatedinfuture.
Hence,duringthereviewtheLCZmapandtheTAsarecarefullycheckedbyanexperiencedoperatoragainstaerialimageryand
auxiliarydata,whothenassignsoneofthe3labelstotheTAsandtheLCZmap:major,minor,oraccept(Fig.2).Amajorrevision
indicatesthatsubstantialdisagreementswerefoundintheinterpretationofthelandscapeandtheassignmentofLCZclasses.Aminor
revision typically indicates a good map, which needs refinement in some classes or specific areas, while accept indicates that no
improvementsarerequired.DatasetswithqualitylevelsofminororacceptcanbefreelydownloadedfromtheportalundertheCC-
BY-NC-SAlicense,whiletheothersarecurrentlyonlyavailableuponrequest.However,alldatasetsmayberevisedandimproved
withtime.
4. Comparisonwithotherdatasets
Thecross-validationapproachindicatesconsistencyoftheTAsbutitdoesnotevaluatethecorrectnessoftheLCZclassification.To
revealthepresenceofanysystematicerrors,theLCZmapscanbecomparedwithotherindependentdatasets.Thissectionoutlinesa
numberofsignificantcomparisonactivitiesthathavebeenundertakenonanadhocbasis;thepurposeistohelprevealandinform
improvedqualitycontrolprocessesinthefuture.
4.1. GHSL
TheGlobalHumanSettlementLayer(GHSL)representsthefirstglobalandmulti-decadaltemporalassessmentofartificialbuilt-
upsurfaces(definedascontainingarooforapartofit),withbuilt-upmapsfor1975,1990,2000and2014(Pesaresietal.,2016).
The2014mapwasproducedusing9089Landsat8scenesmainlyfromhighvegetationgrowingseasons.Moreover,the2014dataset
contains an experimental add-on called GHSL-LABEL, which represents a global, fine-scale multi-class urban map for better
29

descriptionofthephysicalcharacteristics ofhuman settlements andthereforeauniqueresource(Pesaresietal.,2016).In GHSL-
LABEL, the built-up areas are discretized into 19 types according to a set of rules, mainly considering vegetation and estimated
buildingvolumefromdigitalsurfacemodels(Bechteletal.,2018).ThetypesareG-1:Other,G-2:Iceandsnow,G-3:Baresoiland
rocks,G-4:Shrubsandgrassland,G-5:MosaiccroplandsandForest,G-6:Raincropland,G-7:Irrigatedcropland,G-8:Forest,G-9:
Occasionally water / land-water interface, G-10: Surface water, G-11: Roads, G-12: Highly reflecting roof, G-13: Very light im-
pervious,G-14:Lightimpervious,G-15:Mediumimpervious,G-16:Lowrisebuildings,G-17:Mediumrisebuildings,G-18:Highrise
buildings,G-19:Veryhighrisebuildings.
AfirstcomparisonbetweentheGHSL-LABELandWUDAPT-LCZdatasetswasconductedinBechteletal.(2016a)andamore
comprehensivestudyusing50citieson5continentsispresentedinBechteletal.(2018).TheresultsforRiodeJaneiro,Brazil,are
showninFig.6andFig.7.Thecomparisonwasconductedusingaggregatedclasssetsthataccountforthemismatchinscaleand
semanticdiscretisationbetweenthetwoproducts.TheLCZmapswerefirstprojectedtotheGHSL-LABELcoordinatesystemandthe
correspondingtilesfromtheGHSL-LABELweremosaickedtothesametargetgridsystemastheLCZmaps(Fig.6).Bothdatasets
werethenreclassifiedusingsixaggregatedclassesforLCZsandfourfortheGHSL-LABELproduct.Finally,thearealfractionoccupied
byeachaggregatedclasswascalculatedata1kmresolution(Bechteletal.,2018).
TheaggregatedclassesfortheLCZsareallbuilt-upLCZs(1−10),nosparse(1–8,10),compact&open(1–6),compact(1–3),open
(4–6),andcommercialLCZ(8)whiletheaggregatedclassesfortheGHSL-LABELareallbuilt-upGHSL(G-1–G-19),strongbuilt-up(G-
16–G-19),light-medium(G-13–G-15),andcommercialGHSL(G-12).Thecorrespondencebetweenthetwoproductswasevaluated
visuallyandquantitatively;fordetailsseeBechteletal.(2018).
Sincetheaggregatedclassesbetweentheschemesdonotmatchperfectly,theyremaindifficulttointerpretvisually,despitethe
useofsimilarcoloursinFig.6.However,thescatterplotsandthefractionmapsrevealsubstantialagreement.Inparticular,setpairs
full, built, and open shown in Fig. 7 agree very well, while the correlation is high for set pair compact but the LCZ shows higher
fractions.Thereisaweakaccordancebetweenthetwoproductsforsetpaircommercial.Generally,thestudyshowedgoodagreement
betweentheallbuilt-upaggregatedclassesoftheGHSL-LABELandWUDAPT-LCZ(inparticularopenandcompactclassesbetween
bothdatasets),butnouniversalrelationcouldbefound.However,specificproblemsinLCZmapstypicallyresultinloweragreement
betweenthedatasets.Therefore,thecross-comparisonmaybecomeapartofthestandardevaluationprocedureinthefuture.
4.2. ComparisonofperviousfractionUCPwithEEAsoilsealing
Inadditiontoglobaldatasetsonurbanbuilt-upareasandtheirstructure,theevaluationofanLCZmapcanalsobebasedonUCPs
derived from these maps. However, there is currently a lack of consistent global data sets on such parameters. Yet if regional or
nationaldatasetsdoexist,thenthesecanstillbeusedtoassessthequalityoftheUCPsderivedfromLCZmaps.Agoodreferencefor
EuropeistheEEA(EuropeanEnvironmentAgency)soilsealingdataset,whichisfreelyavailableata20mand100mresolution.
Inthisexample,anLCZmapfromBelgium(cf.Fig.15)wasevaluatedusingthe100mresolutionEEAsoilsealingdataset.The
LCZmapwasconvertedtoUCPsusingSAGAGIS.Toderivethevaluesperclass,theaverageofthestandardvaluerangeforthe
perviousfraction(PF)providedbyStewartandOke(2012)wastakenfortheurbanclasses,whileforthenaturalclasses,PFwassetto
0%forrockandto100%forallothers.Thesoilsealingwasthenderivedas1–PF.Bothmapswerethenresampledtoacommon1km
grid.ThecomparisonoftheLCZderivedsoilsealing(left)andtheEEAdataispresentedinFig.8.Itshowsagoodagreementandboth
patterns clearly show the urban footprint. The scatterplot confirms the high degree of agreement with a correlation R of 0.93.
However,itcanbeseenthattheLCZmethodslightlyoverestimatesthesoilsealing.Inthedifferencemap,itcanbeseen,thatthisbias
has a spatial pattern. Generally, the soil sealing is overestimated in theNorth-West andunderestimated inthe South-East, which
might be related to topography or surface characteristics and needs further investigation. In particular, the road network can be
depicted,whichisnaturallyneglectedbytheLCZ-basedmethod.However,theagreementisverypromisingandcouldbeimproved
bymorespecificUCPvaluesfortheareaofinterest.GiventheenormouseffortandcosttoderivetheEEAsoilsealingproduct,the
LCZisseenasaveryquickandefficientalternative.
Fig.6.WUDAPT-LCZandGlobalHumanSettlementLayer(GHSL)LABELmapsforRiodiJaneiro,Brazil.a)theLCZ,b)GHSL-LABELmap.
30

ZCL.svtliubllaLSHG(lluf:LSHGdnaZCLfosriapfostesdetcelesrofstolprettacsdnaspamnoitcarf,atadLEBAL)LSHG(reyaLtnemeltteSnamuHlabolGdnaZCL-TPADUWfonosirapmoc-ssorC.7.giF ees;)laicremmocZCL.svlaicremmocLSHG(laicremmocdna;)nepoZCL.svmuidem-thgilLSHG(nepo;)tcapmocZCL.svtliubgnortsLSHG(tcapmoc;)esrapsonZCL.svtliubllaLSHG(tliub;)tliublla
.sliatedrof)a6102(,.latelethceB
31

Fig.8.SoilsealingderivedfromtheLCZmapforBelgium(seeFig.15)comparedtotheEEAdata:a)soilsealingforROI(%)forLCZapproach(left)
andEEAdata(right);b)scatterplot;c)absolutedifferencein%soilsealing.
4.3. City-specificevaluations
Forsomeindividualcities,quantitativedetaileddescriptionofthemorphologies,coverandUCPsareavailable.Asameansto
betterevaluatethequalityofWUDAPTlevel0data,selectedcity-specificcomparisonshavebeenperformedandarepresentedinthe
sectionsthatfollow.
4.4. Dublin,Ireland
Simpletechniquescanalsobeusedtogeneratelandcoverstatisticstoevaluatelevel0data.Millsetal.(2015)usedGeo-Wiki
(Fritzetal.,2012)toclassifyabout300,000samplepointsacrossDublin,Irelandintolandcovertypes(Fig.9).Thepointdatawere
subsequentlyaggregated to 250mcellsandthefractional areaobtained wascomparedagainsttheequivalent rangesfortheLCZ
typesassignedtothatcell(Table1).Thesesampledatawerealsousedtoestimatethesamplingdensitythatwouldbehypothetically
neededtoderivelandcoverparametervaluesatadesiredprecision.Abootstrappingexperimentwasconductedthatestimatedthe
built and impervious fractions for each LCZ category. The results of this experiment showed that, while parameter values vary
considerablywithsmallsamples,thevaluesquicklystabilizeathighersamplesizesandthatmostoftheestimatedfractionsfallwell
withintheparameterrangesgivenbyStewartandOke(2012).
Middeletal.(2018)andLukasczyketal.(n.d.)developedamethodologytoderiveSkyViewFactor(SVF),andotherUCPfor
citiesworldwidefromGoogleStreetView(GSV)imagery.Theyusedadeeplearningframeworktosegment90-degreefieldsofview
GSVimagecubesintosixsurfacetypeclasses:buildings,trees,pervioussurfaces,impervioussurfaces,movingobjects,andsky.The
classifiedsurfaceswerethenprojectedfromtheimagecubeontoaspherewherethefractionsofeachsurfacetypewerecalculated.To
compute SVF, the lateral and upward facing GSV images were projected onto a hemisphere, and the sky vs. non-sky pixels were
evaluatedusingamodifiedSteynmethod(Middeletal.,2017;Middeletal.,2018).
ToassessWUDAPTlevel0dataforDublin,GSVimagesfor573,431locations(completespatialGSVcoverage)wereretrieved
usingtheGoogleMapsAPIandprocessed.Theskyandmovingobjectfractionswereremovedfromthe3Dfractioncomposition,as
theydonotrepresentpermanentsurfaces;treesandpervioussurfaceswereaggregatedintoavegetationclass.Theresultingfrac-
tional data for buildings, vegetation, impervious surfaces, and SVFs for Dublin were mapped (Fig. 10), and zonal averages were
comparedtoLCZranges(Table1).Thesurfacetypefractionsgenerallyfallwellwithinthespecifiedrangesexceptforheavyindustry
(LCZ10)andlargelow-rise(LCZ8).GSVimageryismostlyavailableonstreets,andtherewerefewGSVsamplelocationsontheroad
networkinthoseextensiveareassotheimagesdonotprovideanaccuratezonalrepresentation.AverageSVFsfromGSVexhibitlarge
deviations from LCZ parameter ranges in Dublin's compact urban areas, especially for the high-rise zone. This is most likely a
classificationerrorintheLCZmap,asEuropeancitiessuchasDublingenerallydonotfeaturecompacthigh-riseneighbourhoodswith
low SVFs as can be found in Manhattan or Hong Kong. This highlights the usability of Level 1 data for detecting errors in LCZ
classifications.
32

noitcarftliub)cdnanoitcarfgnilaeslios)ehtob;nilbuDrofpamZCLeht)d;)WG(ikiW-oeGgnisudetcellocatadelpmasnilbuDehtfostesbusrof)cdna)b;htraEelgooG©nilbuDfoegamilaireA)a.9.giF
.atadelpmasWGehtmorfdetamitseera
33

|                |     |     |     |     |     |            |                     |
| -------------- | --- | --- | --- | --- | --- | ---------- | ------------------- |
Table1
Theplanfraction(%)ofvegetation(λ),buildings(λ),impervious(λ)surface,andSkyViewFactors(SVF)fortheDublinurbanareabasedonthe
|     | v   | b   | l   |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
GeowikiandsegmentedGoogleStreetViewimagesalongwithrangesfromtheLCZscheme.
LCZ Geowikiexperiment GoogleStreetViewexperiment StewartandOke,2012
|     | λ λ | λ λ | λ   | λ   |     | λ λ | λ     |
| --- | --- | --- | --- | --- | --- | --- | ----- |
|     | V b | I V | b   | I   | SVF | V b | I SVF |
Compacthigh-rise 10.5 42.4 47.1 14.2 38.5 47.3 82.8 <10 40–60 40–60 20–40
|                |           |           |      |      |      | 40–70 | 30–50 30–60 |
| -------------- | --------- | --------- | ---- | ---- | ---- | ----- | ----------- |
| Compactmidrise | 11.3 43.9 | 43.7 15.1 | 42.6 | 42.3 | 79.7 | <20   |             |
Compactlow-rise 17.6 36 45.1 15.0 44.9 40.1 82.8 <30 40–70 20–50 20–60
| Openhigh-rise | 25.9 24.3 | 48.9 |     |     |     | 30–40 20–40 | 30–40 50–70 |
| ------------- | --------- | ---- | --- | --- | --- | ----------- | ----------- |
Openmidrise 39.1 19.8 36.8 20.1 30.4 49.5 88.8 20–40 20–40 30–50 50–80
|               |           |           |      |      |      | 30–60 20–40 | 20–50 60–90 |
| ------------- | --------- | --------- | ---- | ---- | ---- | ----------- | ----------- |
| Openlow-rise  | 39.4 22.2 | 38.1 34.7 | 17.9 | 47.5 | 86.5 |             |             |
| Sparselybuilt | 62.3 11.5 | 24.9 –    | –    | –    | –    | 60–80 10–20 | <20 >80     |
|               | – –       | –         |      |      |      | 30–50       | 40–50       |
| Largelow-rise |           | 27.5      | 23.1 | 49.4 | 89.4 | <20         | >70         |
HeavyIndustry – – – 12.9 34.7 52.4 93.0 40–50 20–30 20–40 60–90
Fig.10.a)SkyViewFactor;b)3Dimpervioussurfacefraction;c)3Dbuildingfraction;andd)3DvegetationfractionasestimatedfromGoogle
StreetViewimagery.Backgroundimagesource(ArcGIS): Esri,DigitalGlobe, GeoEye,i-cubed,Earthstar,Geographics,CNES/AirbusDS, USDA,
USGS,AEX,GEtmapping,Aerogrid,IGN,IGP,swisstopo,andtheGISUserCommunity.
ExceptforLCZ5,whichisquiterareinDublin,theagreementbetweentheGeowikiandGSVcomparisonapproachesisveryhigh.
The vegetation fraction of LCZ 5 as estimated from GSV is 19% lower than the corresponding fraction from Geo-Wiki, while the
imperviousfractionis12.2%larger.ThismightberelatedtotheGSVbiastowardsroadsthatunderestimateshorizontalpervious
surfacessuchasgrass.
4.5. HongKong,China
Buildingheightdetectionandextractionarewell-knownchallenges,especiallyforhigh-densityhigh-riseurbanareas.HongKong
34

.gnoKgnoHrofthgiehgnidliubegarevaehT)b;gnoKgnoHrofpamZCLehT)a.11.giF
35

hasaparticularlycomplicatedurbanmorphologyandinhomogeneousbuildingheights,whichriseuptohundredsofmeters(Zheng
etal.,2017).Thus,HongKongrepresentsaninterestingcaseforinvestigatingtheUCPsrangesinhigh-densityurbanscenarios.
First,asetoftypicalsamplesevenlydistributedacrossthewholeareausinghighresolutionGoogleStreetMapwasselected.3D
urbanmorphologicaldataweregeneratedbyusinganinnovativeremotesensingtechnologyandmethod(Xuetal.,2017a).This
developeddatawasusedtocalculatetheUCPrangesbyLCZforHongKong(Fig.11).Byaggregatingtheaveragebuildingheight
informationoverthesameLCZsamplingarea,statisticsforthebuildingheightforallLCZcategorieswereobtained(Table2).These
werecomparedwiththestandardLCZrangesforthesameparameter.Theresultsgenerallyagreewiththestandardvalueranges
proposedbyStewartandOke(2012).Forexample,LCZ1andLCZ4havethehighestbuildingheight,andthenLCZ2andLCZ5,and
LCZ3andLCZ6,respectively,whichisconsistentwiththestandardscheme.Themaindifferenceisthattheaveragebuildingheight
fortheareasclassifiedasLCZ6inHongKongwasabove10m,whichshouldbelongtoLCZ5accordingtothestandardscheme.Also,
itwasobservedthattheaveragebuildingheights forthesameLCZclassestendtobehigherthanthebuildingheights underthe
standardschemeforEuropeancities,whichindicatesthatthestandardschemeshouldbeadaptedtoensurethatitismoresuitablefor
somehigh-densityurbanareas.ThisfindingalsoreflectstheneedtoconsiderrevisionstotheLevel0lookuptablesordevelopprecise
level1or2WUDAPTproductsforbetterurbanapplicationsatthecitylevel.
4.6. Paris,NantesandToulouse,France
A 'bottom-up' approach based on administrative data and GIS was recently proposed to automaticallygenerate LCZ maps for
French cities. A vector administrative data set was developed in the nationally-funded MApUCE project and is available at this
address:http://mapuce.orbisgis.org/LCZmapsbasedonthisdatabasewereobtainedthroughasemi-automaticclusterclassification
methodthattakesregionalvariationsintoaccountandallowsformoreprecisedefinitionsoftheUCPsforeachLCZtype(formore
detailsseeHidalgoetal.,2018).
The classification method was tested on three cities, namely Paris, Nantes and Toulouse. These citieshave a typical European
morphologicalstructurewithadensercitycentre(mostlyLCZ2)surroundedbylargeurbansuburbsofresidentialhousing(LCZ6).
The commercial and industrial developments (LCZ 8and 10) are mostly concentrated along certain axes, which mostly represent
majortrafficroutes.However,therearealsodistinctdifferences.Forexample,thedenseurbancoreofParisislargecomparedtothe
other two cities, while for Toulouse, a large extensive development can be seen, butadjacent to the town centre and patches of
compactlow-rise(LCZ3)andopenmidrise(LCZ5)canalsobefound.
TheMApUCEmapswerecomparedwiththoseobtainedusingthe‘top-down’approachproposedintheframeworkofWUDAPT
level 0. WUDAPT maps were vectorized in order to obtain comparable polygonsto those of the MApUCE maps. A geographical
analysisbasedonacomparisonbetweenMApUCEandWUDAPTfortotalandindividualLCZsurfacesshowedthatalthoughthecity
coreswerequitewellrepresentedintheWUDAPTapproachintermsofurbanextension,MApUCEhadabetterresolutionforthose
areasandthestructureoftowncentreswereconsequentlybettercaptured.Themaindifferencescouldbefoundinsmallsuburban
areaswithfewbuildings.ThesedifferencesweremainlyconcentratedinLCZs6,8and9buttheywerenothomogeneousandstrongly
dependentonthecitystructure.ThekeydifferenceswereconcentratedinLCZ6forToulouse.ForParis,thebiggestdifferencesbeing
foundforLCZ3andLCZ4withahighover-representationbytheWUDAPTmethodology,215%and414%respectively.ForNantes,
even though the classes were comparable, the built-up areas were particularlyunderrepresented (37%) in the WUDAPT data set
comparedtoMApUCE.
4.7. Szeged,Hungary
Lelovicsetal.(2014)presentedabottom-upapproachtoLCZmappingusingvariousdatabasesandurbansurfaceparameters.As
afirststep,allparametersthatdefinetheLCZclasses(StewartandOke,2012)werecollectedonaspatialunitcalledlotareapolygons
(Gál and Unger, 2009). In the next step, the method decides on the first and second most likely LCZ category for each polygon.
Finally,thepolygonsareaggregatedtoachieveareasofadequatesize,comparabletothesourceareaofthetemperatureobservations
at2mheight(Oke,2004;Unger,2009).Themethodologyrequiresmanyinputdatasets(e.g.3Dbuildingdatabase,CorineLand
Cover,RapidEyesatelliteimagery,topographicmaps,roaddatabase)tocalculatetheurbansurfaceparameters,whichisoneofits
mainlimitations;applicationofthismethodinothercitiesis,therefore,notastraightforwardtask.However,inthecaseofSzeged,it
waspossibletomakeadirectcomparisonbetweenthebottom-upGISmethodandtheWUDAPTapproachforcreatinganLCZmap.
IntheWUDAPTmethod,theappearanceoftheLCZmapdependshighlyonthepost-classificationfilterappliedtothemap.For
Szeged,theoptimalsolutionwastouseafilterof3pixels(Fig.12a).Inthestudyarea,LCZs2,3,5,6,8,9arepresentfromthebuilt-
uptypeswhileintheruralarea,therearemainlyLCZs4and6(Fig.12a).WiththeGIS-basedmethod,onlythebuiltuptypescanbe
examined,becausethismethodisnotsuitablefordetectingnon-urbanlandcovertypes.TheLCZtypesandtheirspatialpatternsare
Table2
Statisticsforthemeanbuildingheight(MBH)ofrelevantLCZsinHongKong.
MBH(m) LCZ_1 LCZ_2 LCZ_3 LCZ_4 LCZ_5 LCZ_6
HongKong 43 22 9 46 18 14
Standard(StewartandOke,2012) > 25 10–25 3–10 > 25 10–25 3–10
36

Fig.12.TheLCZmapofSzegedobtainedusinga)theWUDAPTmethodusingapost-classificationfilterof3pixelsandb)theGISmethod(Lelovics
etal.,2014).c)ExamplesofdifferencesbetweentheWUDAPTandGISmethodsareidentifiedasdescribedinthetext.
mostlythesameintheurbanareas.However,therearefewminordifferences(Fig.12b).TheedgesoftheLCZsaresharperandmore
linearlyshaped(Fig.12b).
Intotal, 22%oftheurbanareawereclassified differently inthetwoapproaches.Insomeplacesthesurfacematerialscaused
differences.Forexample,arailroadstationwasidentifiedasopenlow-riseintheWUDAPTmethod(Area1inFig.12c)andaslarge
low-rise in the GIS method. Area 2 in Fig. 12c is an example that results from the post-classification filtering; the GIS method
identifiedthisareaasopenmidrisewhiletheWUDAPTmethodidentifiedthisareaaslargelow-riseduetothesurroundingareas.
NearthecentreofSzeged(Area3inFig.12c)anopenmidriseareawasidentifiedbytheGISmethod,butthisareawasfilteredoutby
theWUDAPTmethod.Area4inFig.12cwasidentifiedasopenlow-risebytheGISmethodandopenmidrisebyWUDAPTbutthis
areaissocomplexthatthecorrectclassisopentointerpretation.
Basedontheseresultsthehighlydata-intensiveGISmethodandgloballyapplicableWUDAPTmethodproducelargelyconsistent
mapswithslightdifferences,whichcanmostlyberelatedtouniquesurfacecharacteristics(e.g.railroads)orthepost-classification
filtering. Thus, by using the WUDAPT mapping protocol, a fairly accurate LCZ map can be produced. Hence the use of the data-
intensiveGISmethodmaynotbeworththeeffortneededtocollectallthenecessarydatalayers.
4.8. Augsburg,Germany
SincetheoriginalintentoftheLCZschemewasinformedplanninganddocumentationofstationnetworks,itisinterestingtosee
iftheclassesdepictedwiththestandardworkflowdoexhibitclimaticdifferences.Therefore,aclimaticevaluationofanLCZmap
determined according to the WUDAPT standard LCZ classification workflow has been performed for Augsburg, Germany, and its
surroundings.
Theevaluationswerebasedonairtemperaturemeasurementsfromaloggernetworkincluding80sitesandcovertheperiodsince
December2012(varyingamongsites).Approximately50sitescouldbeclearlyassignedtospecificLCZclassesthatarepresentinthe
Augsburgregion(LCZs2,5,6,8,A,B,D).Airtemperaturedifferencesbetweeneachsiteandaruralreferencestation(Augsburg-
MühlhausenfromDeutscherWetterdienst)havebeenderivedutilizingrespectivehourlymeandata.Analysesoftheairtemperature
37

differences have been performed stratified according to LCZ classes, season, time of the day and as well synoptic situation (as
characterizedbywindandcloudiness).
Ingeneral,distinctdifferencesinairtemperatureamongLCZclassesandwithrespecttotheruralreferencestationwerefound.In
particularpositivetemperaturedeviationsappear–indecreasingorder–forthebuiltupcategoriescompactmidrise,openmidrise,
large lowrise and open lowrise. Concerning the natural categories air temperatures decrease from low plants to dense trees and
scatteredtrees.Forcalm(windspeed0-2m/s)andclear(cloudcover0–2octas)conditionsandoverallseasonsandtimesoftheday
themediansofthetemperaturedifferencesbetweenLCZsandruralreferencestationwere3.4K(LCZ2),1.8K(LCZ5),1.4K(LCZ6),
2.0K(LCZ8),0.7K(LCZA),−0.1K(LCZB)and1.0K(LCZD),whichconfirmstheclimaticrelevanceoftheLCZmapofAugsburg.
MoredetailedinformationonthevariationsintemperaturecharacteristicsofLCZsaccordingtoseason,timeofthedayandsynoptic
boundarycanbefoundin(Becketal.,2018)andareingoodaccordancewithfindingsforothercities,e.g.Berlin,Germany(Fenner
etal.,2017).
5. Ongoingdevelopments
5.1. Evaluationofthehumanfactor
Inadditiontothequalitycontrolprocessesdescribedintheprevioussection,theHUManInfluenceEXperiment(HUMINEX)was
runin2016toevaluatetheimpactofindividualperceptionandbiasontheLCZmappingaccuracyofdifferentcitiesaroundtheworld
(Bechteletal.,2017b).Theoverallaimswereto(1)investigatethequalityofLCZmapsproducedbydifferentindividualsusingthe
WUDAPTmethodology;and(2)investigatehowthemappingaccuracycanbeimproved,e.g.,byrevisionoftheinitialtrainingdata
orbycombiningcrowdsourceddatafromseveraloperatorstocreateasingleLCZmap.
The results showed large differences between LCZ maps for a single city developed by different operators; see Fig. 13 for an
exampleofLCZmapsforGhent,Belgium.Theconsistencyandaccuracymeasuresusedtoevaluatethequalityindicatedthatboththe
qualityoftheTAdatasetsandtheresultingLCZmapswerepoortomoderate.
Oftenthedurationoftheexercisewastooshorttoperformiterationsuntiltheclassificationresultsconvergedtoanacceptable
result.Assuch,thenumberofiterationswaslow,andsometimesonlythefinalTAsetwasdelivered.Duetoinconsistenciesinthe
number and type of classes present in the different study areas, region of interest etc., inter-city comparison was difficult if not
impossible.LargediscrepancieswerefoundintheOAfordifferentcities,e.g.incoastalcities,wherehighOAsarereachedbecause
Fig. 13.Different LCZ maps for Ghent Each map was produced with training data from a different operator as part of the HUMan INfluence
EXperiment(HUMINEX)(Bechteletal.,2017b).
38

watercanbeclassifiedcorrectlywithgreatereasecomparedtootherurbanLCZtypes.
Secondly,theHUMINEXshowedthatitismoredifficultforuntrainedoperatorstoidentifyTAscorrectly.Humaninterpretationis
generallyknowntobedifficultinremotesensing(VanCoillieetal.,2014)andcrowdsourcing(Seeetal.,2013;Seeetal.,2016).The
resultsalsoshowedthattherecommendationsfordelineatingTAsareoftenneglectedorforgotten,resultinginTAsthatdifferfrom
theinstructionsregardingsize,shapeanddistancefromotherLCZs.Insummary,itcanbestatedthat:(1)operatorknowledgeis
critical and therefore in the second phase of the experiment, a driver's test will be provided to teach operators how to correctly
delineatetheTAs;and(2)independentcontrolsarenecessary.However,theresultsalsoshowedthatthequalityoftheclassifications
clearlyimprovedwiththenumberofiterations(Fig.14),whichindicatesthattheexistingWUDAPTprotocolisavalidapproachfor
LCZmapping,despitesomedifficultiesinusinguntrainedoperatorsforgatheringcrowdsourceddata.
Finally, considerable improvement in the LCZ maps can be achieved by combining multiple training data sets from different
operators,whichisevidenceforthe‘wisdomofthecrowd’.Usingthemodeofallavailableclassificationsorusingmultipletraining
datasetsforoneclassificationcanproducehigheraccuraciesthanthemeanaccuracyofindividualclassificationsofacity,especially
fortheurbanLCZtypes.Theresultsshowed,however,thataftertentofifteenTAsets,theincreaseinaccuracysaturatesandtheLCZ
map does not improve anymore. From these results, the HUMINEX concludes that at least ten individual TA sets from untrained
operatorsshouldbeusedforonecitytoproduceanLCZmapofgoodquality,althoughthisaspectneedsfurtherinvestigation(Bechtel
etal.,2017b).
5.2. ImprovementsinLCZmapping
ThequalityapproachesdescribedinthispaperaregenerallybeingappliedtoLCZmapsdevelopedusingtheWUDAPTproduction
workflowasdescribedinsection2.However,therearemanyongoingdevelopmentswithrespecttoimprovingtheactualmethod
usedtoderivetheLCZmaps(Bechteletal.,2017a)andhenceimprovetheiroverallquality.TheseincludethetransferabilityofTAs,
theuseofnewdatasetsandfeaturesandnewapproachestoLCZclassification.
AglobalLCZmapdatabasethathasbeenderivedfromauniformclassificationmodelisneededtoperformstandardizedurban
climatestudiesglobally.However,TAsarenotyetavailableforeverycityaroundtheworld.Henceitwouldbeusefultodetermine
whetherTAsfromonecitycanbeusedtocreateLCZmapsinanothercitywherenotrainingdataexists.Duetodifferentbio-physical
backgrounds, altitudes, and image characteristics, classification models are not always effectively transferable, as discovered by
Kaloustianetal.(2017)forLebanonandSyria.
Inordertoovercomethisproblem,itisimportanttodeveloparobustgeneralizedclassificationmodel.Thiswasalsothepurpose
ofthe2017DataFusionContest(Tuiaetal.,2017a)runbytheImageAnalysisandDataFusionTechnicalCommittee(IADFTC)ofthe
IEEEGeoscienceandRemoteSensingSociety.Inthiseditionoftheannualimageanalysischallenge,theteamswereprovidedwitha
setoffreeandopendatafromLandsat8,Sentinel2,andOSMaswellastraininglabelsfromaselectionoftrainingcities(Berlin,
Rome,Paris,SãoPaulo,HongKong).Inthesecondstep,participantsreceivedthesamedatawithoutthelabelsfromasecondsetof
cities(Amsterdam,Chicago,Madrid,andXi'an)andtheteamswereinvitedtouploadclassifiedmapsofthetestcitiestoanevaluation
server.>500teamsfromover50countriesdownloadedthedataandatotalof857setsofmapswereuploaded,whichisseenasa
greatsuccessfortheprominenceofWUDAPTintheImageAnalysiscommunity.Thebestteamreachedanoverallaccuracyof74.9%
(Tuiaetal.,2017a),whichisimpressively highcomparedto thestandardmethodused (asdescribed in section2). Thebestper-
formingteamsusedanumberofstateoftheartmachinelearningmethodssuchasRandomForest(includingRotationForestsand
decisiontreeapproaches),Boosting,DeepLearning,andexperthandcraftedfeatures(seeYokoyaetal.,2018,alsoforthedetailed
methodsofthetwowinningteams).
Amongthefourwinningteams,theWUDAPTteamofCUHKproposedaco-trainingbasedapproachtogeneratehigh-qualityLCZ
mapsfornewtargetcitieswithouttheneedfortrainingsamples(Xuetal.,2017c).Theapproachincludedfourmainstages.First,a
novel feature extraction approach was employed to generate spectral-spatial features from the original Landsat 8 and Sentinel 2
satellite data. Second, the spectral-spatial features derived from both satellite and land cover data were combined to train two
Fig.14.HUMINEXresultsfordifferentiterationsforLeuven;a)boxplots;b)individualoperators.
39

independentclassifiersbasedondifferentcombinationsoffeatures.Third,aco-trainingapproachwasdesignedtoadaptthemodelto
suit the target cities, in which two original classifiers were iteratively modified by adding new valid samples from target cities.
Finally,acombinationoftheco-trainingapproachwithotherclassifiers,suchasasupportvectormachine(SVM),wasusedtofurther
enhancethefinalclassificationaccuracy.
Theproposedapproachhasseveraladvantages.First,multi-sourcesatellitedataarewellintegratedintoamulti-viewmodelto
achieveimproved LCZ classification results. Second, the classifiers based on source cities were iteratively adapted intothe target
citiesbyaddingmorevalidsamples.TheexperimentalresultsshowedthattheproposedapproachcouldderiveLCZmapsforthefour
testing cities with an OA of about 70%, which is over 10% more accurate than conventional approaches with the same settings.
Compared with conventional approaches, the novel approach does not need prior knowledge about the target cities, and it can
automaticallygenerateworldwideLCZmapstosupporturban-climatestudiesforcitiesintheworld.
Incorporatingmoredatasourcesinonlineprocessingplatformscanalsohelptoaddresstheissueoftransferability.Thisincludes
the use of different Earth observation data sets such as Sentinel 1, Sentinel 2 and the Defense Meteorological Program (DMSP)
OperationalLinescanSystem(OLS)night-timelightsproduct.Suchonlineprocessingplatformscanalsofacilitateimplementationof
the online cross-validation bootstrapping procedure (see section 3.1), and provide the ability to scale-up from single cities over
countriestocontinents.ThelatterisillustratedinFig.15,whichprovidesanexampleLCZmapforBelgiumprocessedusingGoogle
EarthEngine(Gorelicketal.,2017),whichusedseasonalLandsat8compositesandTAsfromAntwerp,Brussels,GhentandLeuven
(Verdoncketal.,2017;Bechteletal.,2017b).
Consideringthelimitationsofmoderateresolutionsatelliteimages,othertypesofdatasetsshouldbeincludedinLCZmapping,
suchasASTER,Sentinel2,SAR(synthetic-apertureradar)data(e.g.fromSentinel1),OSMandGSVimages.Xuetal.(2017b)found
thatincludingtexturalinformationfromLandsatandASTERdatacanachievemuchbetterresultsforLCZmappingwhileKaloustian
etal.(2017)foundthatthermalorSARdatawithoutmultispectraldataresultedinloweraccuracies.DatafromOSMhavealsobeen
foundtobehelpfulfortheLCZclassification,especiallyforthenaturallandcoverclasses(AtoF).Lopesetal.(2017)investigatedthe
useOSMdatatoenhancethedevelopmentofLCZs,complementtheexistingdatasources,andimprovetheaccuracyofthemapsbya
fuzzylogicapproachandaweightedcombinationmethodandachievedimprovementsforsomeclasses,intermsofaccuracyand
representationonthemap.Toobtainbetterpredictionaccuracyforurbantypes,GoogleStreetViewimageshavealsoproventobe
helpfulwiththeassistanceofdeeplearningtechnology(Xuetal.,2018).Moreover,veryhighresolutionaerialimageryobtainedfrom
commercialsatellitesandUAVsshouldbebeneficialforaccurateLCZmappingbuthavenotyetbeenexploredindetail.
Inadditiontopixel-basedsupervisedclassificationapproaches,manyothermethodsarebeingexploredforbetterLCZclassifi-
cation,suchasobject-basedimagerecognitionandtheinclusionofneighbourhoodinformation.Forexample,Casonne(2016)found
thattheobject-basedandpixel-basedaccuracieswerecomparablewhenusingLandsat8dataata30mresolutionwhileVerdonck
etal.(2017)foundthatacontextualclassifierthatincludedneighbourhoodinformationshowedimproveddiscrimination,especially
forthebuilt-upclasses.Inanotherstudy,Tuiaetal.(2017b)showedthataMarkovmodelthatcapturesspatialinteractionsbetween
classeswasbeneficialforLCZmapping.Tobetterextractcontextualinformation,deeplearningtechnologiescouldalsobefurther
studiedinthefuturetoextracthighlevelimagefeaturesforimprovingtheclassificationaccuracy.
5.3. Applicationoflevel0data
One of the challenges in terms of model applications has been the description of urban areas in both meso- and micro-scale
modelling frameworks. Traditionally, providing the requisite level of surface information for such models has restricted model
applicationstoindividualsites(Wardetal.,2016),orledtoanoversimplificationoftheurbanformwithinthemodels.Oneofthe
Fig.15.LCZmapofBelgiumproducedwithGoogleEarthEngine.
40

.)CRD(ssalcssenhguortropnevaD)d;mnithgiehyponac)c;%ninoitcarftliub)b;odeblA)a;ylatI,naliMfopamZCLehtmorfdeviredsretemarapyponaCnabrU.61.giF
41

advantages of level 0 data has been to readily provide the required parameter information forurban climate models (Fig. 16) to
enableintra-urbandifferentiationintermsofbothsurfacefluxesandairtemperatures(Hammerbergetal.,2018)formultiplecities.
Forexample,ithasbeendemonstratedthatlevel0datacanbeusedtosatisfactorilyrunurban-scalemodels(Alexanderetal.,
2015)withoutcompromisingsignificantlyonthemodel'sabilitytosimulatetheurbanenergybudget,northeabilityofthesemodels
todifferentiatebetweenvariousurbandensities,i.e.highlyurban,suburban,andnon-urban.Thishastheadvantageofproviding
surfaceparametersinaconsistentmanneracrossdomains,whichenablesinter-citycomparisonstobeundertaken inaconsistent
manner (Alexander et al., 2016). It was hence assumed that those parameters derived from the LCZ classification may be im-
plementedindifferenturbancanopymodelsembeddedindifferentregionalclimatemodels(Demuzereetal.,2017).
ApioneeringstudyoverMadrid,Spain,byBrousseetal.(2016)demonstratedthattheBEP-BEMmodel(Salamancaetal.,2011)
within the WRF model (Chen et al., 2011) was sensitive to the heterogeneity of the landscape obtained from the LCZ mapping.
Indeed,animprovementofabout10%inthestatisticalindicators(RMSEandMeanBias)fortheairtemperatureinbothsummerand
wintercasesata333mhorizontalresolutionwasobservedwhencomparedwith30officialweatherstationsandCORINElandcover
asaninput.ResearchersinHongKonghaveadoptedtheWUDAPTlevel0methodtogeneratehistoricalLCZmapsofthePearlRiver
DeltaRegion, whichwere usedas inputdata to theWRF model.The results showed that theeffects oflocal urbanization can be
examinedifhistoricalurbanmorphologicaldataareavailable(Renetal.,2017).Theseresultssupportedtheideathatmoretrust-
worthyresultsandnewinsightsintourbanclimateimpactscouldbeobtainedbybetterdefiningtheurbanmorphologyintermsof
formandfunctionwhencomparedwiththeuseofsimplerbinary(i.e.urban/rural)orternary(i.e.lowdensity/highdensity/others)
classifications.
Other work in this area includes investigation into the added value of detailed data sets and their impact on urban climate
modellingperformance.Forexample,somestudieshavemadeuseofGIStechniquesformappingLCZs(Gáletal.,2015;Zhengetal.,
2017),whileastudyinVienna,Austria,triedtoquantifytherequireddetailneededforWRFmodelling(Hammerbergetal.,2018).
Thesameprotocolwasappliedandthemodelresultswerecomparedtoanetworkof150stationscomingoutofofficialandpersonal
Fig.17.DifferentLCZmorphologicalparameterisationsofthecityofVienna,AustriaintheBEP-BEMmodel,embeddedintheWRFclimatemodel,
bysourceofparameters.AdetailedbuildingparameterGISdatasetisusedforViennaGISandLCZs'rangesofparametersareusedforWUDAPT.In
theViennaGIScase,heightsareaggregatedto5mintervals(the5mvaluerepresentsheightsfrom0to5m,etc.).SeeHammerbergetal.(2018)for
details.
42

weatherstationnetworkmeasurementsfordifferentcases.OnecasemadeuseofadetaileddatasetderivedfromGISdata(Fig.17),
accessible within the city boundary ofVienna, while theother was parameterized using an LCZ map created using theWUDAPT
protocolanditsrelatedmorphologicalparameters.
Inthecurrentstateofregionalandurbanclimatedevelopment,whenlookingatthebiasesofbothruns,therewasnotangible
addedvalueinusingthedetailedGISdataformesocaleurbanclimatemodelling.Indeed,theoverallRMSEforthefiveperiodswere
2.61°Cand2.65°CfortheGISandWUDAPTcases,respectively,whilethemeanbiaseswere0.56°Cand0.62°C.However,thetwo
differenturbanstructuresresultedinmodeldifferencesofupto1°Cduringsummertime.Thisimpliesthatthesmalldifferencesin
performancebetweenthetwostructuresisaresultofmultiplesourcesoferrors,whicharedescribedinmoredetailinHammerberg
etal.(2018).Therefore, thedetail ofurban morphological information inan LCZ mapmayalready besufficientforsome model
applications. Similarly, level 0 enables a first-pass assessment of the urban climate at sufficient detail to engage decision makers
(PiconeandCampo,2015).
6. Conclusions
The WUDAPT initiative is producing LCZ maps for many cities around the world, contributed by a community ofresearchers
interestedincreatingaglobaldatabaseoftheformandfunctionofcitiesforurbanclimatemodellingandotherapplications.Before
the LCZ maps are released to the wider community via the WUDAPT portal, they must undergo quality assessment and are then
published with metadata related to the quality achieved. Different approaches used in the quality assessment process were high-
lightedinthispaper.Inparticularthebootstrappingcross-validationandthereviewweredescribed,whicharecurrentlypartofthe
standardLCZqualityassessmentprocedure.Inaddition,comparisonswithindependentdatasetsofurbanstructureandurbancanopy
parameters at country and city level were presented, where some of these additional approaches may become included in the
standardqualityassessmentprotocolinfuture.
Todate,theresultsfromthedifferentqualityprocessesshowthattheLCZmapsaregenerallyofmoderatequality,i.e.50–60%
OA,butthisismuchhigherwhenconsideringallbuilt-upclassestogetherorusingweightsthattakethemorphologicalandclimatic
similarityofcertainclassesintoaccount.CurrentlythetrainingdatafortheLCZsarecontributedbyresearchersfromaroundthe
world,whichcanbeverydifferentandcanaffectthefinalqualityoftheLCZmaps.OnereasonisthatsomeLCZclassesaredifficultto
distinguishfromsatelliteimageryanditrequiresexpertknowledgeortrainingtocreateasuitableTAset.Anotherreason isthat
peoplemayhavedifferentopinionswheninterpretingLCZtypes.Theimpactoftheoperatorsontheclassificationaccuracywasfound
tobeconsiderablebasedonexperiencesfromtheHUMINEX,whichstressesthenecessityofstrictqualityassessmentandreview.
Someclassesarespecificallychallenging,i.e.LCZ9(sparselybuilt),whichisabuilttypebuthaslowbuildfraction.
Whatisconsideredanacceptablequalitywilldependupontheapplication.Forexample,theLCZmapsmightberesampledtoa
coarser resolution for input into global atmospheric models and be less sensitive to accuracy at the 100m resolution. Therefore,
differentaccuracymeasuresareusedwhichallowsevaluationspecifictothepurpose.Experimentationwillneedtobeundertakento
better understand the desirable and acceptable accuracies for different applications. Initial modelling studies, however, showed
improvedperformanceinsimulatingtheurbanclimatewhenreplacingstandardsurfacedescriptionsbyWUDAPTlevel0data,which
ispromisingforitsapplicationinregionalandglobalclimatemodellingexperimentsandweatherforecastsbutlikewisesupportsthe
assumption of sufficient detail for certain model applications. Moreover, WUDAPT level 0 maps have been found to agree with
observedtemperaturedifferences,whichisalsoencouragingfortheirfurtheruse.
In parallel, there are ongoing developments to improve the methods used to produce LCZ maps and hence the accuracy, e.g.
throughtheadditionofothertypesofdatasourcessuchasSARimages,veryhighresolutionimages,andgroundlevelimagessuchas
GoogleStreetView,aswellasexperimentationwithotherclassificationalgorithmsanddeeplearningtechniques.Additionalefforts
togeneratespatiallypreciseUCPs,theso-calledLevel1and2data,aredescribedelsewhereinthisspecialissue.
Acknowledgements
MostofallwethankallWUDAPTcontributors.ThisworkwaspartlysupportedbytheClusterofExcellence‘CliSAP’(EXC177),
University of Hamburg, funded through the German Science Foundation (DFG), the German Academic Exchange Service (DAAD)
(Project ID 57320776), the research project ‘Cities in Change–Development of a multi-sectoral urban-development–impact model
(UrbMod)’ (LFF-FV17), funded by the State of Hamburg, the EU FP7 funded ERC grant Crowdland (No. 617754), the Hungarian
Scientific Research Fund (NKFI K 120346) and by the ÚNKP-17-4 New National Excellence Program of the Ministry of Human
Capacities.WorkonFrenchcitieswasfundedbytheFrenchNationalResearchAgency(AgenceNationaledelaRecherche)under
grant #ANR-13-VBDU-004. Matthias Demuzere is funded by the Belgian Science Policy Office (BELSPO) in the frameworkof the
STEREOIIIprogramme,projectSAT-EX(SR/00/306).ThisstudyispartiallysupportedbytheVice-Chancellor'sOne-offDiscretionary
FundofTheChineseUniversityofHongKongtitled“World-wideUrbanDataBankonPhysicalFormsofCities&ImpactStudiesof
UrbanFormsonHumanComfort,HealthandEnvironmentWell-being”andtheGeneralResearchFundProjectGrants(ProjectNo.:
RGC-GRF14611015&14,643,816)ofHongKongResearchGrantsCouncil.
References
Acero,J.A.,Arrizabalaga,J.,Kupski,S.,Katzschner,L.,2013.DerivinganUrbanclimateMapincoastalareaswithcomplexterrainintheBasqueCountry(Spain).
UrbanClim.4,35–60.https://doi.org/10.1016/j.uclim.2013.02.002.
43

Alexander,P.J.,Mills,G.,Fealy,R.,2015.UsingLCZdatatorunanurbanenergybalancemodel.UrbanClim.13,14–37.
Alexander,P.J.,Bechtel,B.,Chow,W.T.L.,Fealy,R.,Mills,G.,2016.Linkingurbanclimateclassificationwithanurbanenergyandwaterbudgetmodel:Multi-siteand
multi-seasonalevaluation.UrbanClim.17,96–215.
Bechtel,B.,2011.MultitemporalLandsatdataforurbanheatislandassessmentandclassificationoflocalclimatezones.In:UrbanRemoteSensingEvent(JURSE),
2011Joint.PresentedattheUrbanRemoteSensingEvent(JURSE),2011Joint.IEEE,pp.129–132.https://doi.org/10.1109/JURSE.2011.5764736.
Bechtel,B.,Daneke,C.,2012.ClassificationoflocalclimatezonesbasedonmultipleEarthObservationdata.IEEEJournalofSelectedTopicsinAppliedEarth
ObservationsandRemoteSensing5,1191–1202.https://doi.org/10.1109/JSTARS.2012.2189873.
Bechtel,B.,Alexander,P.J.,Böhner,J.,Ching,J.,Conrad,O.,Feddema,J.,Mills,G.,See,L.,Stewart,I.,2015.MappinglocalclimatezonesforaWorldwideDatabaseof
theformandFunctionofCities.ISPRSInt.J.Geo-Informat.4,199–219.https://doi.org/10.3390/ijgi4010199.
Bechtel,B.,Pesaresi,M.,See,L.,Mills,G.,Ching,J.,Alexander,P.J.,Feddema,J.J.,Florczyk,A.J.,Stewart,I.,2016a.Towardsconsistentmappingofurbanstructures–
GlobalHumanSettlementLayerandLocalClimateZones.In:TheInternationalArchivesofthePhotogrammetry,RemoteSensingandSpatialInformationSciences
XLI-B8,pp.1371–1378.https://doi.org/10.5194/isprs-archives-XLI-B8-1371-2016.
Bechtel,B.,See,L.,Mills,G.,Foley,M.,2016b.ClassificationoflocalclimatezonesusingSARandMultispectralDatainanAridEnvironment.IEEEJournalofSelected
TopicsinAppliedEarthObservationsandRemoteSensing9,3097–3105.https://doi.org/10.1109/JSTARS.2016.2531420.
Bechtel,B.,Conrad,O.,Tamminga,M.,Verdonck,M.L.,Coillie,F.V.,Tuia,D.,Demuzere,M.,See,L.,Lopes,P.,Fonte,C.C.,Xu,Y.,Ren,C.,Mills,G.,Kaloustian,N.,
Cassone,A.,2017a.Beyondtheurbanmask.In:2017JointUrbanRemoteSensingEvent(JURSE).Presentedatthe2017JointUrbanRemoteSensingEvent
(JURSE),pp.1–4.https://doi.org/10.1109/JURSE.2017.7924557.
Bechtel,B.,Demuzere,M.,Sismanidis,P.,Fenner,D.,Brousse,O.,Beck,C.,VanCoillie,F.,Conrad,O.,Keramitsoglou,I.,Middel,A.,Mills,G.,Niyogi,D.,Otto,M.,See,
L.,Verdonck,M.-L.,2017b.QualityofCrowdsourcedDataonUrbanMorphology—theHumanInfluenceExperiment(HUMINEX).UrbanSci.1,15.https://doi.
org/10.3390/urbansci1020015.
Bechtel,B.,Pesaresi,M.,Florczyk,A.J.,Mills,G.,2018.Beyondbuilt-up–theinternalmakeupofurbanareas.In:Weng,Q.,Quattrochi,D.A.,Gamba,P.(Eds.),Urban
RemoteSensing.Taylor&Francis.
Beck,C.,Straub,A.,Breitner,S.,Cyrys,J.,Philipp,A.,Rathmann,J.,Schneider,A.,Wolf,K.,Jacobeit,J.,2018.Airtemperaturecharacteristicsoflocalclimatezonesin
theAugsburgurbanarea(Bavaria,southernGermany)undervaryingsynopticconditions.UrbanClim.25,152–166.
Brousse,O.,Martilli,A.,Foley,M.,Mills,G.,Bechtel,B.,2016.WUDAPT,anefficientlanduseproducingdatatoolformesoscalemodels?IntegrationofurbanLCZin
WRFoverMadrid.UrbanClim.17,116–134.https://doi.org/10.1016/j.uclim.2016.04.001.
Casonne,A.,2016.Derivinglocalclimatezonesfromremotesensingdata.UniversitédeStrasbourg,FacultédeGéographieetd'AménagementMasterThesis.
Chen,F.,Kusaka,H.,Bornstein,R.,Ching,J.,Grimmond,C.S.B.,Grossman-Clarke,S.,...Sailor,D.,2011.TheintegratedWRF/urbanmodellingsystem:development,
evaluation,andapplicationstourbanenvironmentalproblems.Int.J.Climatol.31(2),273–288.
Ching,J.,Mills,G.,Bechtel,B.,See,L.,Feddema,J.,Wang,X.,Ren,C.,Brousse,O.,Martilli,A.,Neophytou,M.,Mouzourides,P.,Stewart,I.,Hanna,A.,Ng,E.,Foley,
M.,Alexander,P.,Aliaga,D.,Niyogi,D.,Shreevastava,A.,Bhalachandram,S.,Masson,V.,Hidalgo,J.,Fung,J.,Fatima-Andrade,M.,Baklanov,A.,WeiDai,D.,
Milcinski,G.,Demuzere,M.,Brunsell,N.,Pesaresi,M.,Miao,S.,Mu,Q.,Chen,F.,Theeuwes,N.,2018.WorldUrbanDatabaseandAccessPortalTools(WUDAPT),
anurbanweather,climateandenvironmentalmodelinginfrastructurefortheAnthropocene.Bull.Am.Meteorol.Soc.2018(Inpress).
Conrad,O.,Bechtel,B.,Bock,M.,Dietrich,H.,Fischer,E.,Gerlitz,L.,Wehberg,J.,Wichmann,V.,Böhner,J.,2015.SystemforAutomatedGeoscientificanalyses
(SAGA)v.2.1.4.Geosci.ModelDev.8,1991–2007.https://doi.org/10.5194/gmd-8-1991-2015.
Demuzere,M.,Harshan,S.,Jarvi,L.,Roth,M.,Grimmond,C.S.B.,Masson,V.,Oleson,K.W.,Velasco,E.,Wouters,H.,2017.Impactofurbancanopymodelsand
externalparametersonthemodelledurbanenergybalanceinatropicalcity.Q.J.R.Meteorol.Soc.143(704),1581–1596.https://doi.org/10.1002/qj.3028.
EEA,2012.MappingguideforaEuropeanUrbanAtlas. Availablefrom:http://land.copernicus.eu/local/urban-atlas[Accessed24November2017].
Esch,T.,Heldens,W.,Hirner,A.,Keil,M.,Marconcini,M.,Roth,A.,Zeidler,J.,Dech,S.,Strano,E.,2017.Breakingnewgroundinmappinghumansettlementsfrom
space–theGlobalUrbanFootprint.ISPRSJ.Photogramm.RemoteSens.134,30–42.https://doi.org/10.1016/j.isprsjprs.2017.10.012.
Fenner,D.,Meier,F.,Bechtel,B.,Otto,M.,2017.Intraandinter‘localclimatezone’variabilityofairtemperatureasobservedbycrowdsourcedcitizenweather
stationsinBerlinGermany.Meteorol.Z.26,525–547.
Fritz,S.,McCallum,I.,Schill,C.,Perger,C.,See,L.,Schepaschenko,D.,vanderVelde,M.,Kraxner,F.,Obersteiner,M.,2012.Geo-Wiki:anonlineplatformforland
covervalidationandtheimprovementofgloballandcover.Environ.Model.Softw.31,110–123.
Gál,T.,Unger,J.,2009.Detectionofventilationpathsusinghigh-resolutionroughnessparametermappinginalargeurbanarea.Build.Environ.44,198–206.
Gál,T.,Bechtel,B.,Unger,J.,2015.ComparisonoftwodifferentLocalClimateZonemappingmethods.In:ProceedingsoftheICUC9–ICUC9.Toulouse,France.
Geletič,J.,Lehnert,M.,2016.GIS-baseddelineationoflocalclimatezones:thecaseofmedium-sizedcentralEuropeancities.MoravianGeo.Rep.24,2–12.https://
doi.org/10.1515/mgr-2016-0012.
Gorelick,N.,Hancher,M.,Dixon,M.,Ilyushchenko,S.,Thau,D.,Moore,R.,2017.GoogleEarthEngine:Planetary-scalegeospatialanalysisforeveryone.RemoteSens.
Environ.202,18–27.https://doi.org/10.1016/j.rse.2017.06.031.
Hammerberg,K.,Brousse,O.,Martilli,A.,Mahdavi,A.,2018.Implicationsofemployingdetailedurbancanopyparametersformesoscaleclimatemodelling:a
comparisonbetweenWUDAPTandGISdatabasesoverVienna,Austria.Int.J.Climatol.38,e1241–e1257.
Hidalgo,J.,Dumas,G.,Masson,V.,Gwendall,P.,Bechtel,B.,Bocher,E.,Foley,M.,Schoetter,R.,Mills,G.,2018.ComparisonbetweenLocalClimateZonesmaps
derivedfromadministrativedatasetsandsatelliteobservations.UrbanClim(UCLIM-D-17-00193R)(accepted).
Houet,T.,Pigeon,G.,2011.Mappingurbanclimatezonesandquantifyingclimatebehaviors–anapplicationonToulouseurbanarea(France).In:Environmental
Pollution,selectedpapersfromtheconferenceUrbanEnvironmentalPollution:OvercomingObstaclestoSustainabilityandQualityofLife(UEP2010),20-23June
2010,Boston,USA. 159.pp.2180–2192.https://doi.org/10.1016/j.envpol.2010.12.027.
Kaloustian,N.,Bechtel,B.,2016.LocalClimaticZoningandurbanheatislandinBeirut.ProcediaEng.169,216–223.https://doi.org/10.1016/j.proeng.2016.10.026.
Kaloustian,N.,Tamminga,M.,Bechtel,B.,2017.LocalclimatezonesandannualsurfacethermalresponseinaMediterraneancity.In:UrbanRemoteSensingEvent
(JURSE),2017Joint.IEEE,pp.2017.
Kotharkar,R.,Bagade,A.,2018.EvaluatingurbanheatislandinthecriticallocalclimatezonesofanIndiancity.Landsc.UrbanPlan.169,92–104.https://doi.org/10.
1016/j.landurbplan.2017.08.009.
Leconte,F.,Bouyer,J.,Claverie,R.,Pétrissans,M.,2015.UsinglocalclimateZoneschemeforUHIassessment:Evaluationofthemethodusingmobilemeasurements.
BuildingandEnvironment,SpecialIssu83,39–49.https://doi.org/10.1016/j.buildenv.2014.05.005.
Lelovics,E.,Unger,J.,Gál,T.,Gál,C.V.,2014.DesignofanurbanmonitoringnetworkbasedonlocalclimateZonemappingandtemperaturepatternmodelling.Clim.
Res.61(1),51–62.
Lopes,P.,Fonte,C.,See,L.,Bechtel,B.,2017.UsingOpenStreetMapdatatoassistinthecreationofLCZmaps.In:UrbanRemoteSensingEvent(JURSE),2017Joint,
pp.1–4.IEEE,2017.
Lukasczyk,J.,Middel,A.,Zakrzewski,S.,Arnold,M.,Maciejewski,R.,Underreview.UrbanFormandCompositionofStreetCanyons:aHuman-CentricbigDataand
DeepLearningApproach.Landsc.UrbanPlan.underreview.
Middel,A.,Lukasczyk,J.,Maciejewski,R.,2017.SkyViewFactorsfromSyntheticFisheyePhotosforthermalComfortRouting–aCaseStudyinPhoenix,Arizona.
UrbanPlanning2(1),19–30.https://doi.org/10.17645/up.v2i1.855.
Middel,A.,Lukasczyk,J.,Maciejewski,R.,Demuzere,M.,Roth,M.,2018.Skyviewfactorfootprintsforurbanclimatemodeling.UrbanClim.25,120–134.
Mills,G.,Ching,J.,See,L.,Bechtel,B.,Feddema,J.,Masson,V.,Stewart,I.,etal.,2015.AnIntroductiontotheWUDAPTProject.In:InProceedingsoftheICUC9–
ICUC9.France,Toulouse.
Oke,T.R.,2004.Initialguidancetoobtainrepresentativemeteorologicalobservationsites.In:WMO/TDno.1250,Geneva.
Perera,N.G.R.,Emmanuel,R.,2018.A“LocalClimateZone”BasedApproachtoUrbanPlanninginColombo,SriLanka.In:UrbanClimate,ICUC9:The9th
InternationalConferenceonUrbanClimate23,pp.188–203.https://doi.org/10.1016/j.uclim.2016.11.006.
Pesaresi,M.,Huadong,G.,Blaes,X.,Ehrlich,D.,Ferri,S.,Gueguen,L.,Halkia,M.,etal.,2013.AGlobalHumanSettlementLayerfromOpticalHR/VHRRSData:
44

Conceptandfirstresults.IEEEJournalofSelectedTopicsinAppliedEarthObservationsandRemoteSensing6,2102–2131.https://doi.org/10.1109/JSTARS.
2013.2271445.
Pesaresi,M.,Ferri,S.,Ehrlich,D.,Florczyk,A.J.,Freire,S.,Halkia,M.,Julena,A.,Kemper,T.,Soille,P.,Syrris,V.,2016.OperatingProcedurefortheProductionofthe
GlobalHumanSettlementLayerfromLandsatDataoftheEpochs1975,1990,2000,and2014. (JRCTechnicalReport).
Picone,N.,Campo,A.M.,2015.PreparingurbanclimatemapsusingtheLCZmethodologyforimprovingcommunicationwithurbanplanners:thecaseofTandilcity,
Argentina.In:InProceedingsoftheICUC9–ICUC9.France,Toulouse.
Ren,C.,Fung,J.C.-H.,Tse,J.W.P.,Wang,R.,Wong,M.M.F.,Xu,Y.,2017.ImplementingWUDAPTproductintourbandevelopmentimpactanalysisbyusingWRF
simulationresult-AcasestudyofthePearlRiverDeltaRegion(1980-2010).In:13thSymposiumoftheUrbanEnvironment,97thAmericanMeteorological
SocietyAnnualMeeting2017.Seattle,US,AMS.
Salamanca,F.,Martilli,A.,Tewari,M.,Chen,F.,2011.Astudyoftheurbanboundarylayerusingdifferenturbanparameterizationsandhigh-resolutionurbancanopy
parameterswithWRF.J.Appl.Meteorol.Climatol.50(5),1107–1128.
See,L.,Comber,A.,Salk,C.,Fritz,S.,VanderVelde,M.,Perger,C.,Schill,C.,McCallum,I.,Kraxner,F.,Obersteiner,M.,2013.Comparingthequalityofcrowdsourced
datacontributedbyexpertandnon-experts.PLoSOne8,e69958.
See,L.,Mooney,P.,Foody,G.,Bastin,L.,Comber,A.,Estima,J.,Fritz,S.,Kerle,N.,Jiang,B.,Laakso,M.,etal.,2016.Crowdsourcing,citizenscienceorVolunteered
GeographicInformation?Thecurrentstateofcrowdsourcedgeographicinformation.ISPRSInternationalJGeo-information5,55.
Stewart,I.D.,Oke,T.R.,2012.LocalclimatezonesforUrbanTemperatureStudies.Bull.Am.Meteorol.Soc.93,1879–1900.https://doi.org/10.1175/BAMS-D-11-
00019.1.
Tuia,D.,Moser,G.,LeSaux,B.,Bechtel,B.,See,L.,2017a.2017IEEEGRSSDataFusionContest:OpenDataforGlobalMultimodalLandUseClassification[Technical
committees].IEEEGeoscienceandRemoteSensingMagazine5,70–73.https://doi.org/10.1109/MGRS.2016.2645380.
Tuia,D.,Moser,G.,Wurm,M.,Taubenböck,H.,2017b.LandUseModellinginNorthRhine-WestphaliawithInteractionandScalingLaws. (JointUrbanRemote
SensingEvent).
Unger,J.,2009.Connectionbetweenurbanheatislandandskyviewfactorapproximatedbyasoftwaretoolona3Durbandatabase.Int.J.Environ.Pollut.36,59.
https://doi.org/10.1504/IJEP.2009.021817.
Unger,J.,Lelovics,E.,Gál,T.,2014.LocalclimateZonemappingusingGISmethodsinSzeged.HungarianGeograph.Bull.63,29–41.
VanCoillie,F.,Gardin,S.,Anseel,F.,Duyck,W.,Verbeke,L.,DeWulf,R.,2014.Variabilityofoperatorperformanceinremote-sensingimageinterpretation:the
importanceofhumanandexternalfactors.Int.J.RemoteSens.35(2),754–778.
Verdonck,M.-L.,Okujeni,A.,vanderLinden,S.,Demuzere,M.,DeWulf,R.,VanCoillie,F.,2017.Influenceofneighbourhoodinformationon‘localclimateZone’
mappinginheterogeneouscities.Int.J.Appl.EarthObs.Geoinf.62,102–113.
Ward,H.C.,Kotthaus,S.,Järvi,L.,Grimmond,C.S.B.,2016.SurfaceUrbanEnergyandWaterBalanceScheme(SUEWS):developmentandevaluationattwoUKsites.
UrbanClim.18,1–32.
Wouters,H.,Demuzere,M.,Blahak,U.,Fortuniak,K.,Maiheu,B.,Camps,J.,Tielemans,D.,vanLipzig,N.P.M.,2016.Theefficienturbancanopydependency
parametrization(SURY)v1.0foratmosphericmodelling:descriptionandapplicationwiththeCOSMO-CLMmodelforaBelgiansummer.Geosci.ModelDev.9,
3027–3054.https://doi.org/10.5194/gmd-9-3027-2016.
Xu,Y.,Ren,C.,Ma,P.,Ho,J.,Wang,W.,etal.,2017a.Urbanmorphologydetectionandcomputationforurbanclimateresearch.Landsc.UrbanPlan.167,212–224.
Xu,Y.,Ren,C.,Meng,C.,Ng,E.,Wu,T.,2017b.ClassificationoflocalclimatezonesusingASTERandLandsatdataforhigh-densitycities.IEEEJournalofSelected
TopicsinAppliedEarthObservationsandRemoteSensing10(7),3397–3405.
Xu,Y.,Ma,F.,Meng,D.,Ren,C.,Leung,Y.,2017c.Aco-trainingapproachtotheclassificationoflocalclimatezoneswithmulti-sourcedata.In:2017IEEE
InternationalGeoscienceandRemoteSensingSymposium(IGARSS),pp.1209–1212.https://doi.org/10.1109/IGARSS.2017.8127175.
Xu,G.,Zhu,X.,Tapper,N.,Bechtel,B.,2018.Urbanclimatezoneclassificationusingconvolutionalneuralnetworkandground-levelimages.Prog.Phys.Geogrunder
Review.
Yokoya,N.,Ghamisi,P.,Xia,J.,Sukhanov,S.,Heremans,R.,Tankoyeu,I.,Bechtel,B.,LeSaux,B.,Moser,G.,Tuia,D.,2018.Opendataforglobalmultimodallanduse
classification:Outcomeofthe2017IEEEGRSSDataFusionContest.IEEEJournalofSelectedTopicsinAppliedEarthObservationsandRemoteSensing11,1–15.
https://doi.org/10.1109/JSTARS.2018.2799698.
Zheng,Y.,Ren,C.,Xu,Y.,Wang,R.,Ho,J.,Lau,K.,Ng,E.,2017.GIS-basedmappingoflocalclimateZoneinthehigh-densitycityofHongKong.UrbanClim.24,
419–448.https://doi.org/10.1016/j.uclim.2017.05.008.
45
SystematicReview
Understanding Cyclists’ Visual Behavior Using Eye-Tracking
Technology: A Systematic Review
FatimaKchour* ,SalvatoreCafiso*andGiuseppinaPappalardo
DepartmentofCivilEngineeringandArchitecture,UniversityofCatania,64SantaSofiaStreet,Catania95123,
Italy;giuseppina.pappalardo1@unict.it
* Correspondence:fatima.kchour@phd.unict.it(F.K.);dcafiso@unict.it(S.C.)
Abstract: Eye-trackingtechnologiesareemerginginresearchaimingtounderstandthe
visual behavior of cyclists to improve their safety. These technologies gather real-time
informationtorevealwhatthecyclistslookatandhowtheyrespondataspecificlocation
andtime. Thissystematicreviewinvestigatestheuseofeye-trackingsystemstoimprove
cyclist safety. An extensive search of the SCOPUS and WoS databases, following the
PRISMA 2020 guidelines, found 610 studies published between 2010 and 2024. After
filteringthesestudiesaccordingtopredefinedinclusionandexclusioncriteria, 25were
selected for final review. The included studies were conducted in real traffic or virtual
environmentsaimingtoassessvisualattention,workload,orhazardperception. Studies
focusingonothertypesofroadusersorparticipantsnotinvolvedinactivecyclingwere
excluded. Resultsrevealtheimportantimpactofroadelements’design,trafficdensity,and
weatherconditionsoncyclists’gazepatterns.Significantvisualworkloadisimposedmainly
byintersections. Alongwiththevaluableinsightsintocyclistsafety,potentialbiasesrelated
tosmallsamplesizesandtechnologicallimitationswereidentified. Recommendationsfor
futureresearcharediscussedtoaddressthesechallengesthroughmorediversesamples,
advancedtechnologies,andagreaterfocusonperipheralvision.
Keywords: eye-trackingsystems;cyclistsafety;roadsafety;gazebehavior;visualattention;
hazardperception;visualworkload
AcademicEditors:DuoLuand
BharateshChakravarthi
Received:30September2024 1. Introduction
Revised:12December2024
Accepted:21December2024 Cyclistsrepresentoneofthemostvulnerablegroupsofroadusers. Theyaretheonly
Published:24December2024 categoryofroaduserswhosefatalityratehasnotdecreasedsince2010. Approximately
Citation: Kchour,F.;Cafiso,S.; 2000bicycle-relatedfatalitiesandnumerousseriousinjurieswerereportedtotheauthorities
Pappalardo,G.Understanding inEuropein2022. Accordingly,bicyclesaccountforoneoutofeverytenrecordedfatal
Cyclists’VisualBehaviorUsing crashes,andthemajorityofbikefatalitieshappenincrasheswithmotorizedvehicles[1].
Eye-TrackingTechnology:A
Additionally,therehasbeennoreductioninthepercentageofseriousinjuriesrecordedin
SystematicReview.Sensors2025,25,
incidentsinvolvingcyclists;rather,itclimbedfrom7%in2010to9%in2019[2],andmost
22. https://doi.org/10.3390/
oftheseinjurieshappeninsinglebicyclecrashes[1]. However,becausethesecrashesare
s25010022
likelynotbeingreportedregularly,thevolumeofthispercentagecouldbesignificantly
Copyright:©2024bytheauthors.
higher[3].
LicenseeMDPI,Basel,Switzerland.
Crashes between cyclists and other vehicles usually happen when different road
Thisarticleisanopenaccessarticle
distributedunderthetermsand users interact, such as at crossings, junctions, and road segments with no designated
conditionsoftheCreativeCommons cyclingfacilities[4]. Approximatelytwo-thirdsofcyclingfatalitiesintheEUhappenover
Attribution(CCBY)license longstretchesofroad,andnearlyone-fifthhappenataroundaboutorintersection. The
(https://creativecommons.org/
percentage of bike deaths is lower on longer road segments and significantly higher at
licenses/by/4.0/).
Sensors2025,25,22 https://doi.org/10.3390/s25010022

Sensors2025,25,22 2of53
crossingswhencomparedtoallroadfatalities[2]. Thetwotypesofcrashscenariosthat
accountforthemajorityoffatalitiesandseriousinjuriesinbicyclecrashesareknownas
crossingscenarios,inwhichthebicycleandthemotorvehiclearetravelinginperpendicular
directions,andturningscenarios,inwhichthecycliststurnleft(orrightintheUK)infront
ofthemotorvehicle[5].
Ontheotherhand,themaincontributingfactorstosinglebicyclecrashesarepropor-
tionedasfollows: 60%arerelatedtoskiddingoniceorwater,24.9%arerelatedtoroad
design(curbstones,obstaclesneartheroad,roadmaintenance),andasmallerproportion
areduetocyclists’conditionandbehavior(alcohol,speed,distraction)[6].
To mitigate the risks, understanding the behavior and decision-making processes
ofcyclistsiscrucialfordevelopingsafertransportationinfrastructureandimplementing
efficientsafetymeasures. Becausemostoftheinformationreceivedwhilenavigatingthe
roadsisvisual,understandingwherethecyclistlooksandhowtheirenvironmentaffects
their behavior is essential to prevent crashes by taking suitable countermeasures. Eye-
trackingtechnologyhasevolvedintoausefultoolforstudyinghowcyclistsperceiveand
interactwiththeirsurroundingsbecauseitrecordsgazedatainrealtime. Researcherscan
learnmoreabouttheelementsthataffectcyclistsafety,suchasweather,trafficdensity,and
roaddesign,byexaminingvisualbehavior.
Despitethegrowingnumberofresearchstudiesonbicyclesafety,comparativelylittle
hasbeenrevealedabouttheapplicationofeye-trackingtechnologyinthisarea. Although
existingstudieshavedemonstratedaninterestinunderstandingvisualattentiontoenhance
safety,athoroughsynthesisofthedataisstillrequiredtoguidefutureinvestigationsand
urbanplanningstrategies. Thissystematicreviewseekstofillthegapbyinvestigating
theuseofeye-trackingtechnologiestoevaluatethevisualbehaviorofcyclists. Itaimsto
provideanoverviewofthecurrentliterature,highlightsignificanttrendsandlimitations
in the application of eye tracking for bicycle safety, and present recommendations for
furtherstudies.
2. Methodology
Thissectionpresentsthemethodologicalapproachemployedtoconductthesystematic
review,fromsettingtheresearchquestionandextractingrelevantarticlesfromdifferent
databasestoselectingstudiesincludedinthereview.
2.1. DefiningtheMethodologicalApproachandKeyStepsoftheReview
Thisstudyintendstosummarizetheliteratureoneyetrackertechnologyandiden-
tify the key challenges involved in their applications and the key opportunities these
technologieswillbringtothespecificfieldofapplicationforcyclistbehaviorandsafety.
Toachievethisaim,thestudyadoptsasystematicliteraturereviewapproachusing
thePRISMA(PreferredReportingItemsforSystematicReviewsandMeta-Analyses)[7]
protocoltoimprovethestudy’seffectivenessandreplicability. TheflowchartinFigure1
presentsthephasesofthesystematicreview,anditisalsotheformalstructureofthepaper.
2.2. SearchStrategyandSelectionProcess
InNovember2023,anarrowsearchwasconductedinthetwodatabases,SCOPUSand
WoS(WebofScience),toinvestigatetheuseofeye-trackingtechnologyforcyclistsafety
inthecontextofroadsafety. TheSCOPUSandWoSdatabaseshaveexcellentcoverageof
appropriatedisciplinesandhigh-qualityindexedpublications. Theyaffordgoodindexing,
especiallyinpeer-reviewedjournals,andaccesstoqualityresearcharticlesacrossawide
rangeoftopicsassociatedwithroadsafetyandeye-trackingtechnology. Itisimportantto

Sensors2025,25,22 3of53
Sensors 2025, 25, x FOR PEER REVIEWno tethatSCOPUSandWoSalsoincludecontentfromIEEEandPubMeddatab3a soef s5,1t hus
ensuringtheavailabilityofhigh-qualityandrelevantstudies.
FFiigguurree 11.. KKeeyy sstteeppss oof fththe esysystsetmemataicti rcerveivewie.w .
2.2. SFeairrscth, Sthtreatseegayr cahnds tSrealteectgiyoni nPvrooclevsesd usingasetofkeywordsobtainedbybrainstorming
and asking advanced AI tools (ChatGPT-3.5) for keywords appropriate to the research
In November 2023, a narrow search was conducted in the two databases, SCOPUS
qaundes tWioonS, f(oWcuebsi nogf Socniehnocwe),e tyoe -itnrvaecsktiinggattee cthhen oulsoeg yofc eayneh-terlapckiminpgr toevcehnooulrougyn dfoerrs ctayncldisint gof
csyafceltisyt ibne thhaev cioonrtaenxtd orfo raodadsa sfaefteyt.y. The SCOPUS and WoS databases have excellent cov-
erageT ohfe aspeparrocphrqiautee rdyissceiptlfionretsh aendda htiagbha-sqeusailsitays infodleloxewds :p(uTbIlTicLaEti-oAnBs.S T-KheEyY aff(“oeryde gtoraocdk er*”
OinRde“xeinyge, treascpkeicniagl*ly” OinR p“eeeyr-eretvraiecwkiendg jsoyusrtneamls*, ”aOndR a“cecyeesst rtaoc kqiunaglitayp prelisceaatricohn sa”rtOiclRes“ eye
tarcarcoksisn ag wgildases reasn”gOe Rof “teoypeicgs aazsesodcaiattae*d” wOiRth“ rroeaadl- tsiamfeetyg aazned deaytea-t*r”acOkRingga tzeech*nOoRlo“gmy. eIat sur*
eisy iemppoosrittaionnt ”toO nRot“e mtheaat sSuCrO*ePyUeSm anodv eWmoeSn at”lsOo iRnc“leuydee mcoonvteenmt efrnotm*” IOEERE“ avnisdu PaulbaMtteendt ion”
OdaRta“bgaasezse, dthautsa *e”nsOuRrin“gD trhiev earv’asilvaibsiuliatyl aotft heingthio-qnu”aOlitRy a“nCdy rcelilsetv’asnvti sstuuadlieast.t ention“)AND
TITLFEi-rAstB, tSh-eK sEeYarc(hsa sfter*atOegRy “inrovaodlvseadf uetsyin”gO aR se“t soaff keeryowaodr*d”sO obRta“icnyecdl *bysa bfreatiyn”stOorRm“inbgic ycl*
saanfde tays”kOinRg a“dsavfaenrcreoda dA*I” toOoRls “(sCahfeartGroPaTd-3*.”5)O fRor“ kbeiykw*soarfdest ya”ppOrRop“rmiatiec rtoo- mthoeb rielisteyarscahfe ty“
OquRes“titorna,f fifoccusasfinetgy o”n) AhoNwD eyTeI-TtrLaEck-AinBgS t-eKchEnYo(locygycl *caOn Rheblpik iem*pOrRovbei ocyucr lu*nOdRer“stcayncdl*inugs er*”
of cyclist behavior and road safety.
OR “bik* user*” OR “bicycl* user*” OR “vulnerable road users” OR “cycl* rider” OR
The search query set for the databases is as follows: (TITLE-ABS-KEY (“eye tracker*”
“bik* rider” OR “bicycl* rider” OR “micro-mobility road user*” OR micromobility* OR
OR “eye tracking*” OR “eye tracking system*” OR “eye tracking applications” OR “eye
“cyclistbehavior“))ANDPUBYEAR>2009ANDPUBYEAR<2024AND(LIMIT-TO
tracking glasses” OR “eye gaze data*” OR “real-time gaze data*” OR gaze* OR “measur*
(LANGUAGE,“English”)).
eye position” OR “measur* eye movement” OR “eye movement*” OR “visual attention”
AfterconductingthequeryonSCOPUS,weusedForwardandBackwardCitation
OR “gaze data*” OR “Driver’s visual attention” OR “Cyclist’s visual attention “) AND
SearchingmethodsonthefirsteightrelevantpapersfromSCOPUS,revealingarichvein
TITLE-ABS-KEY (safe* OR “road safety” OR “safe road*” OR “cycl* safety” OR “bicycl*
of literature. These eight papers were selected from the search query by applying the
safety” OR “safer road*” OR “safer road*” OR “bik* safety” OR “micro-mobility safety “
“sortbyrelevance”filter. InSCOPUS,SearchEngineRelevance[8]isacomplexstatistical
OR “ traffic safety”) AND TITLE-ABS-KEY (cycl* OR bike* OR bicycl* OR “cycl* user*”
calculation that indicates how well the search terms and criteria match the text of the
OR “bik* user*” OR “bicycl* user*” OR “vulnerable road users” OR “cycl* rider” OR “bik*
returned documents, helping to refine the search for better results. The query initially
rider” OR “bicycl* rider” OR “micro-mobility road user*” OR micromobility* OR “ cyclist
resultedin221documents. UsingtheForwardCitationSearchingmethod,whichinvolves
behavior “)) AND PUBYEAR > 2009 AND PUBYEAR < 2024 AND (LIMIT-TO (LAN-
eGxUpAorGtiEn,g “Ethneglliissht”o)f).p aperscitingthefirsteightrelevantpapersfromSCOPUS,wefound
24doAcfutemr ecnotnsd.uCcotinnvge trhsee lqy,utehrey Boanc SkCwOaPrdUCS,i twatei ounseSde aFrocrhwinargdm anetdh oBdac,kwwhaircdh Cloitoaktisoant the
rSeefaerrcehnincegs mciettehdodins othne thfier sfitresti gehigthrte rleelveavnatntp paappeersrsa fnrodmp uSCblOisPhUeSd, breevtweaelienng 2a0 r1i0cha vnedin2 023,
yoife llidteerdatu2r0e2. Tdhoecsuem eiegnhtts ptahpaetrsw wereeres seelleecctteedd. frTohme nth,ef rsoemarcthh qeuWeroyS byd aatpapblaysineg, wthee “osbotrati ned
1b4y2 rdeloecvuamnceen”t fis.ltAerd. dInit iSoCnOalPlyU,Sa, fSoelalorcwh- uEnpgsienaer cRhelienvaAnpcrei l[82]0 i2s4 af ocoumndpl1e4x isntaStiCstOicPaUl cSala-nd7
icnulWatoioSn, etxhtaetn idnidnigcatthees lhaotewst wpeulbl ltihcaet isoenardcha tteetromtsh aenfidr sctrhitaelrfiao fm2a0t2c4h. tIhnet otetaxlt, owf ethide ernet-ified
6tu1r0nsetdu ddioecsu.ments, helping to refine the search for better results. The query initially re-
sulted in 221 documents. Using the Forward Citation Searching method, which involves
exporting the list of papers citing the first eight relevant papers from SCOPUS, we found

Sensors2025,25,22 4of53
Thefirststepinvolvedremovingallduplicatestudies,resultinginatotalof572studies.
Subsequently,thetitleandabstractofeachstudywerescreenedandevaluated. Studies
werethenfilteredbasedonthefollowingexclusioncriteria:
• Itwasaconferencepaperorthesis,becauseonlypeer-reviewedjournalarticlesthat
underwentathoroughandrigorousreviewprocesswereincluded,thusensuringhigh
reliabilityandvalidityoftheselectedresearchpapersforthereview.
• Itwasinthesubjectareasofmedicine,neuroscience,biochemistry,pharmacology,etc.
anditwasnotrelatedtothegeneralresearchquestion.
• Itassessedbehaviorusinganymethodotherthaneye-tracking.
• Theeye-trackingstudyfocusedoncarsandpedestriansbutdidnotconsiderinterac-
tionswithcyclists.
• Itinvolvedaccidents/collisionsrelatedtocardrivers.
• Itfocusesonroadsafetywithoutmentioningcyclistsafety.
• Thescreeningoftitlesandabstractswasperformedusingthefollowingtwoapproaches:
• Thetitlewasassessed,andifitwasclearthatthereportwasinadifferentfieldthan
roadsafety(forexample,medicineorneuroscience),thereportwasexcluded.
• BygivingChatGPT-3.5thetitleandabstractandaskingthefollowingyes/noquestions:
“Waseyetrackerusedinthisstudy?”,“Werecyclistsincludedinthisstudy?”,and
“Wascyclistsafetyassessedinthisstudy?”.
• Byevaluatingtheabstractthoroughly. BecausetheuseofChatGPTisexperimentalin
systematicreviews,itisimportanttoconfirmtheresultsoftheAItool.
Thisprocessresultedin488studiesbeingexcludedfromthereviewand84studies
beingincludedinthefull-textscreeningstep.
Thefull-textscreeningprocesswasexecutedfortheincludedpapersbysettingthe
followinginclusioncriteria:
• Itincludedinteractionsofcyclistswithotherroadusers(driversofalltypesofmotor-
izedvehicles,pedestrians,motorists,ande-scooterriders).
• Theeyetrackerwasusedinthestudytoassessoneoftheseoutcomes,whicharevisual
attention,visualworkload,andhazardperceptioninthecontextofcyclistsafety.
• Theparticipantswereactivelycyclingduringthetest,eitherinrealtrafficorusinga
bicyclingsimulator. Studieswhereparticipantswereseatedandonlyobservingor
reactingtorecordedvideofootageorphotographsonacomputerscreenwerenotin-
cluded. Thus,thetwoincludeddatacollectionmethodswererealtrafficenvironments
andvirtualsimulations,whichwillbediscussedindetailinSection3.
Thisprocesswasconductedbyemployingthefollowingtwomethods:
• Using the AI tool, ChatPDF, which allows researchers to upload their documents
and then analyzes them and answers the questions asked by the reviewers. The
yes/noquestionswerethefollowing: “Doesthisstudyincludeinteractionsofcyclists
withotherroadusers?”,“Wastheeyetrackerusedintheexperimenttoassessvisual
attention/workload/hazardperceptioninthecontextofcyclistsafety?”,and“Are
cyclistsactivelycyclingduringtheexperiment?”.
• Whennecessary, thereviewerreadthetextfullytoanswerthepreviousquestions.
ChatPDFprovidesanswerswithprooffromthetextbygivingthepagenumberand
highlightingtheevidenceinthedocument. However,itmaysometimesprovidea
doubtfulresponseinsteadofadefinitiveyesorno. Thus,theanswersofChatPDF
werecheckedcarefully,andmanualdataextractionwasperformedwhenneededfor
accurateanswers.
After screening, 25 studies were included in the review for further analysis and
interpretation. APRISMAflowdiagram,showninFigure2,illustratestheselectionprocess

Sensors 2025, 25, x FOR PEER REVIEW 5 of 51
• When necessary, the reviewer read the text fully to answer the previous questions.
ChatPDF provides answers with proof from the text by giving the page number and
highlighting the evidence in the document. However, it may sometimes provide a
doubtful response instead of a definitive yes or no. Thus, the answers of ChatPDF
were checked carefully, and manual data extraction was performed when needed for
Sensors2025,25,22 accurate answers. 5of53
After screening, 25 studies were included in the review for further analysis and in-
terpretation. A PRISMA flow diagram, shown in Figure 2, illustrates the selection process
andprovidesavisualimpressionoftheflowofinformationthroughdifferentphasesofthe
and provides a visual impression of the flow of information through different phases of
systematicreview.
the systematic review.
FFigiguurree 22.. SSttuuddyy sseelleeccttiioonn pprroocceesss sbbasaesde dono nthteh e“P“RPIRSIMSMA A202200 2fl0oflwo wdiadgiraagmra fmor fnoerwn eswystseymstaetmic atic
rerevvieiewwss””..
33.. RReessuullttss
TThhiiss sseeccttiioonn iiss ddiivviiddeedd iinntoto twtwoo susub-bs-escetciotinosn: so:noen perepsreenstesn tthset hsteusdtiuesd’i gese’ngereanle crhaalrc-har-
aacctteerriissttiiccss,, aanndd tthhee ootthheerr ddisisccuusssesse sthteh ererseuslutsl tesxetrxatcrtaecdte fdrofmro meaceha cshtudstyu dinydiivniddiuvaildlyu.a lly.
TThhrreeee ssuummmmaarryy ttaabblleess wwitihth thteh emmaina idnedtaeitlsa irleslarteeldat teod atlol oafl lthoef stthuedisetsu adriee savaarielaabvlea iinla ble
inAppendixA;TablesA1andA2includethegeneralcharacteristicsandtheoutcomes
interpreted, Tables A3 and A4 contain the methodological information, and Table A3
presentstheresultsofeachstudy. Theybrieflydescribethecontributionofeachstudyto
understandingcyclistsafetythrougheye-tracking.
3.1. Studies’Characteristics
The 25 reviewed research studies differ in methodology, population, location, etc.
Thesearticlesselectedforthefinalreviewcover8years,from2016to2024,withthehighest

Sensors 2025, 25, x FOR PEER REVIEW  6 of 51

Appendix A; Tables A1 and A2 include the general characteristics and the outcomes in-
terpreted, Tables A3 and A4 contain the methodological information, and Table A3 pre-
sents the results of each study. They briefly describe the contribution of each study to
understanding cyclist safety through eye-tracking.
3.1. Studies’ Characteristics
The 25 reviewed research studies differ in methodology, population, location, etc.
Sensors2025,25,22
6of53
These articles selected for the final review cover 8 years, from 2016 to 2024, with the high-
est number of studies, totaling six, in 2023. The distribution of these articles over the years
numberofstudies,totalingsix,in2023. Thedistributionofthesearticlesovertheyearsis
is illustrated in the bar chart in Figure 3.
illustratedinthebarchartinFigure3.

Figure3.Thedistributionofstudiesacrosstheyears.
Figure 3. The distribution of studies across the years.
Thereviewencompassedstudiesdistributedacrossdifferentjournals,asshownin
Table1T.he review encompassed studies distributed across different journals, as shown in
Table 1.
Table1.Thenumberofarticlesperjournal.
JournalName NumberofArticles
Table 1. The number of articles per journal.
| TransportationResearchPartF:TrafficPsychologyandBehaviour |     |     |     | 4   |     |
| --------------------------------------------------------- | --- | --- | --- | --- | --- |
CaseStudiesonTraJnospuorrtnPaolli cNy ame  2 Number of Articles
|                                                         | A cc id en                       | tA n a ly s is a n                | d P r e v e n tio n affic Psychology and Beh2aviour  |     |     |
| ------------------------------------------------------- | -------------------------------- | --------------------------------- | ---------------------------------------------------- | --- | --- |
| Transport                                               | at io n  R                       | es e a r c h   P                  | a r t   F :  T r                                     |     | 4   |
|                                                         | JournalofSafetyResearch          |                                   |                                                      | 2   |     |
|                                                         |                                  | Case Studies on Transport Policy  |                                                      |     | 2   |
|                                                         | TrafficSafetyResearch            |                                   |                                                      | 1   |     |
|                                                         |                                  | Accident Analysis and Prevention  |                                                      |     | 2   |
|                                                         |                                  | IEEEAccess                        |                                                      | 1   |     |
|                                                         |                                  | Journal of Safety Research        |                                                      |     | 2   |
| TransportationResearchInterdisciplinaryPerspectives     |                                  |                                   |                                                      | 1   |     |
|                                                         |                                  | Traffic Safety Research           |                                                      |     | 1   |
|                                                         | TransportationResearchProcedia   |                                   |                                                      | 1   |     |
|                                                         |                                  |                                   | IEEE Access                                          |     | 1   |
|                                                         | JournalofArchitectureandUrbanism |                                   |                                                      | 1   |     |
| Transportation Research Interdisciplinary Perspectives  |                                  |                                   |                                                      |     | 1   |
Infrastructures
1
|     |     | Transportation Research Procedia  |     |     | 1   |
| --- | --- | --------------------------------- | --- | --- | --- |
|     |     | Sustainability                    |     | 1   |     |
CognitiveReJsoeaurcrhn:aPlr ionfc iAplreschanitdeIcmtpulricea taionnds Urbanism  1 1
|     |     | SensorsInfrastructures  |     |     | 1   |
| --- | --- | ----------------------- | --- | --- | --- |
1
InternationalJournalofAutoSmuotsitvaeiEnnagbinileietryin g 1 1
|     | CognitivHeu mRaenseFaacrtcohrs: Principles and Implications  |     |     | 1   |     |
| --- | ------------------------------------------------------------ | --- | --- | --- | --- |
1
|                                                         | TransportationResearchBoard                      |                                | Sensors          | 1   | 1   |
| ------------------------------------------------------- | ------------------------------------------------ | ------------------------------ | ---------------- | --- | --- |
|                                                         | JournalofAdvancedTransportation                  |                                |                  | 1   |     |
|                                                         | International Journal of Automotive Engineering  |                                |                  |     | 1   |
| JournalofTransportationEngineering,PartA:Systems        |                                                  |                                |                  | 1   |     |
|                                                         |                                                  | Human Factors                  |                  |     | 1   |
|                                                         |                                                  | VirtualReality                 |                  | 1   |     |
|                                                         |                                                  | Transportation Research Board  |                  |     | 1   |
|                                                         | Journal of Advanced Transportation               |                                |                  |     | 1   |
| Journal of Transportation Engineering, Part A: Systems  |                                                  |                                |                  |     | 1   |
|                                                         |                                                  |                                | Virtual Reality  |     | 1   |

Sensors2025,25,22 7of53
Themajorityofstudies(n=14)wereconductedinEurope,whereasninestudieswere
conductedinNorthAmericaandtwoinAsia. Thedemographicdistributionisshownin
Table2.
Table2.Thedistributionofstudiesacrossthecountries.
Continent Countries NumberofArticles
Belgium 1
Germany 3
Sweden 3
Italy 2
Europe TheNetherlands 1
Finland 1
Poland 1
Norway 1
UK 1
USA 7
NorthAmerica
Canada 2
Japan 1
Asia
SouthKorea 1
3.2. ResultsofIndividualStudies
Thissectiondescribestheresultsobtainedfromthe25studies,categorizedbasedon
theirdatacollectionmethod(realenvironmentstudies,virtualenvironmentstudies,and
comparative studies including real and virtual traffic experiments). For each group of
studies,thecharacteristicsdiscussedarecompiledasfollows:
1. Samples’characteristics.
2. Experimentaldesignandprocedure.
3. Datacollectionandanalysis.
3.2.1. RealEnvironmentStudies
Elevenstudieswereconductedinarealtrafficenvironment,whereresearchersgath-
ered data as participants drove or interacted with real traffic. Thus, observations and
measurementswereconductedinreal-worlddrivingconditions.
1. Samples’Characteristics
First,theaveragesamplesizeacrossallthestudiesis22,withaminimumsizeof13
andamaximumof50. Theagerangeoftheparticipantsspansfrom11to65years,with
anunweightedmeanageof29.55. Regardinggenderdistribution,fivestudiesachieved
gender equity among participants. Four studies had fewer female participants, with
percentagesrangingfrom0%to46.50%,whileonestudyhadmorefemaleparticipants,
withapercentageof52%. Onestudydidnotreportthegenderdistributionofitssample.
Most studies required participants to have normal or corrected-to-normal vision using
contactlensestoensureprecisemeasurements,withtwostudiesspecificallymandatingthat
participantsnotweareyeglasses. Secondly,thesamplingstrategiesemployedacrossthe
studiesincludedpurposive,convenience,andmixed-method(purposiveandconvenience)
sampling. Themajorityofstudies(n=9)utilizedpurposivesampling,wheresamplesare
selectedbasedontheresearcher’sdiscretionorspecificcriteria. Conveniencesampling,
wheresamplesarechosenduetotheireasyaccessibilityoravailabilitytotheresearcher,
wasusedinonestudy. Additionally,amixed-methodapproachcombiningpurposiveand
conveniencesampling,whichinvolvesselectingparticipantswhoarebotheasilyaccessible
andmeettheresearcher’scriteria,wasemployedinonestudy.

Sensors2025,25,22 8of53
Subsequently,participantswererecruitedthroughoneormoreofthefollowingmeth-
ods: fromschoolsinproximitytotheexperiment’slocation(n=2),fromthecommunityof
thecitywheretheexperimentwasconducted(n=2),bypostingaquestionnaireonsocial
mediaandonlineplatforms(n=3),throughuniversityemaillists,byusingtheuniversity’s
announcementboardandwebsite(n=7),andbydistributingflyersintheneighborhood
surroundingtheexperiment’slocation(n=2).
Thirdly,participantswerecategorizedascyclists,drivers,orpedestrians,ortheywere
required to experience the scenarios twice, once while cycling and once while driving
or walking. Consequently, seven studies involved participants solely as cyclists, two
studiesinvolvedonlydrivers,andonestudyincludedbothcyclistsanddrivers. Instudies
involvingcyclists,participantsexhibitedvaryinglevelsofcyclingexperience,rangingfrom
cycling once a month for exercise and leisure to cycling daily. This diversity in cycling
experienceensuredtheinclusionofbothexperiencedandinexperiencedcyclists,thereby
enhancingthegeneralizabilityoftheresults. Onestudyspecificallyfocusedonexperienced
cyclists. For studies involving only drivers, the sample was divided into two groups,
cyclists, andnon-cyclists, toassesstheimpactofcyclingexperienceondriverbehavior
towardscyclists. Thestudythatincludedbothroadusertypesrequiredparticipantsto
engageincyclinganddrivingactivitiesatleastoccasionally. Finally,onestudyrequired
participantstoparticipateascyclists,electricscooterriders,andpedestrians,necessitating
thecompletionofthetestthreetimes.
Detailedinformationonsamplesize,genderdistribution,sourceofparticipants,road
usertype,andcyclingexperienceisprovidedinAppendixA,TableA2,whileinformation
onsamplingstrategiesisavailableinTableA3.
2. ExperimentalDesignandProcedure
Firstly, study design approaches adopted in the literature were reviewed to find
suitable methods that can be used to analyze eye-tracking data from road users in real
trafficenvironments.
Eightstudiesutilizedtheobservational/naturalisticmethodology[9–15],whichen-
tailsresearchersobservinganddocumentingbehaviors,phenomena,oroutcomeswithout
manipulatinganyvariable. Thismethodologywasemployedtoexaminethegazebehavior
of participants (cyclists, drivers, pedestrians, electric scooter riders), focusing on their
visualattentiontowardstheareasofinterest(AOI)[9,10,12–15]. Additionally,itwasused
toassessthevisualworkloadexperiencedbycyclists[11],thevisualscanningbehavior
ofcyclistsinrelationtothespatialcharacteristicsoftheenvironment[11],andthevisual
scanningbehaviorofdriverswheninteractingwithcyclistsandothervulnerableroadusers
(VRU)[12]. Study[12]alsoinvestigateddrivergazepatternswhileexecutingturnsaturban
intersections,whilestudies[13,14]analyzedcyclistgazepatternsduringurbancycling. The
relationshipbetweencyclists’visualbehavior[10–14]andphysiologicalmeasures[10,14],
roadconditions,participants’characteristics,andenvironmentalfactors[11–13]wasex-
plored. Furthermore,studies[10,11]examinedtherelationshipbetweengazebehaviorand
subjectiveriskperception.
In[16],KircherK.etal. utilizedacross-sectionalmethodologytoobserveandcollect
data on the attentional demands and visual behavior of cyclists and drivers at a single
point in time across three types of urban intersections: stop-controlled, unsignalized,
andsignalized.
In[17],MantuanoA.etal. implementedaquasi-experimentaldesigntoevaluatethe
impactofnewsignageoncyclists’behavioranddecision-makingprocesses. Datawere
collectedbothbeforeandafterthesignageimplementationtoanalyzecyclists’visualatten-
tiontosignageandinteractionswithotherroadusers. Unlikeatraditionalexperimental
design,participantswerenotrandomlyassignedbutwereselectedbasedontheircycling

Sensors2025,25,22 9of53
experienceandlimitedfamiliaritywiththeroutetoassesstheinfluenceofthenewsystem
onagrouppotentiallyrepresenting“beginnercyclists”.
In[18],KayaN.etal. employedamixed-methodsdesign,combiningquantitativeand
qualitativeapproaches,toexaminedrivers’gazepatternsandvisualattention. Thestudy
analyzescodedvideorecordingstoidentifydrivers’scanningfailurestowardspedestrians
andcyclistsaturbanintersections,providingbothquantitativeandqualitativeinsights.
Insynthesis,thekeyaspectsofvisualbehaviorevaluation,addressedandanalyzedin
realtrafficenvironments,areasfollows:
• Visualattentiontowardsdifferentareasofinterest(AOI).
• Visualworkloadinvariedrouteenvironments.
• Visualscanningbehaviorandgazepatterns.
• Integration of kinematic, physiological, and subjective risk perception data with
gazedata.
Characteristics related to the procedure and conditions of executing the different
experimentsarediscussed. Theresearchersselectedthedrivingscenariosbasedonthe
study’sobjective. Studies[9,11,12,14,16,18,19]focusedonvarioustypesofintersectionsto
examinevisualbehavioratthesecriticallocations. Incontrast,studies[10,15,17]conducted
experiments along complete urban routes with various characteristics to evaluate their
influenceoncyclinganddrivingbehavioringeneralandvisualbehaviorspecifically. The
featuresexaminedincludedthefollowing:
• Cycling path: on-street cycling lane with mixed traffic [10], on-street separate cy-
clinglanevisuallydistinguishedbyacoloredpathwayseparatingthemfromvehi-
cles[10,13],on-streetseparatecyclinglaneseparatedfrommotorizedtrafficusinga
bollard[13],sharedbicycle–buslane[10],sharedpedestrian–cyclistlane[10,11,14,17],
designatedbikelanesinurbantraffic[12,18],narrowpedestrian/cyclisttunnel[11],
sharedpedestrian–cyclist–electricscooterriderlaneinapark[15],andoff-roadcy-
clingpath[12,18],alsoknownasamountainbikingtrailoradirttrail,designedand
constructedforcyclistsawayfrompublicroadsandurbanareas.
• Roadside parking areas: the presence of roadside parking areas along the cycling
path[10,18].
• Intersections: Studies [16,18,19] included stop-controlled, unsignalized, and sig-
nalized intersections, while study [9] focused only on uncontrolled intersections.
Studies[12,14] included only signalized intersections, whereas study [11] did not
specifythetypesofintersectionsselected.
Selectingappropriateweatherconditionsiscrucialinthistypeofexperiment. Clear
weatherpresentschallengesduetovariationsincontrast,makingitdifficulttodistinguish
objectsinareasofbothbrightlightandshadow[19]. Additionally,directsunlightinterferes
withtheinfraredsignaloftheeyetrackercamera,causingfrequentfailurestocapturepupil
andcornealreflection(CR)positions[17]. Therefore,whenusingtheMobileEyeapparatus
inoutdoorsettings,acloudyskyispreferabletoreducesignallossandeffectivelypreserve
gazeinformation[17]. Studies[14,16,17]wereconductedincloudyweatherduringautumn
and/orspring,whilestudies[9,12,13,15,18]reporteddryandgoodconditions.Experiments
instudies[13,19]wereconductedinsunnyandclearweather. Onestudyaimedtoassess
safetyandcomfortwhilecyclingincoldweather(temperaturesbetween−11◦Cand9◦C)
andsnow-coveredsurfaces[10].
Detailedinformationaboutthestudydesign,drivingscenarios,andweathercondi-
tionsisprovidedinAppendixA,TableA3.
3. DataCollectionandAnalysis

Sensors2025,25,22 10of53
Thissectiondiscussesthedatametricscollectedacrossthestudiestoanalyzethecy-
clists’/drivers’behavioringeneral,withaparticularfocusonvisualbehavior.Additionally,
theequipmentusedfordatacollectionandthesoftwareemployedfordataprocessingand
analysisaredetailed.
For each study, information about the data collected is provided in Appendix A,
TableA3;theoutcomesmeasuredareinTableA4,andtheresultsareinTableA5.
Three types of data were collected in the selected research, which are discussed
asfollows:
• Gazedata: collectedusingeyetrackers. Table3presentsthedifferentgazemetrics
measuredandanalyzed,alongwiththeirobjectives.
• Kinematicdata: obtainedthroughGPStracking,accelerometers,andgyroscopes,or
bycalculatingtheselecteddistancepertime. Table4presentsthedifferentkinematic
metricscollectedandanalyzed,alongwiththeirobjectives.
• Subjective data: gathered through questionnaires, surveys, or interviews after the
experiment. Similarly,Table5presentsthesubjectivedatacollectedandanalyzedand
theirobjectives.
Table3.Gazemetrics’characteristicsandusesindataanalysisinrealenvironmentstudies.
Eye-TrackingData Characteristics Objectives
Investigatecyclists’visualattentionwhile
listeningtomusicandridinginurbanareas,
including,specifically,intersections[9],
- Number explorevisualsamplingstrategiesandtheir
- Duration differentpurposes[16],understandthe
- Percentageofglancesto drivers’behaviortowardscyclistsandroad
Glance(fixationandsaccades) specificAOIs featureswhenapproaching
- Frequencycategorizedby intersections[12],understandhowcyclists’
directionandtypeoftarget visualattentionwasallocatedtodifferent
objectswhilecyclingandinteractingwith
otherroadusers,andidentifyhowvisual
scanpatternsareaffectedbydifferenturban
features[13].
Quantifyvisualworkloadduring
- Duration
cycling[17],exploretherelationship
- Number
betweenvisualattentionandphysiological
- Averagepointofgaze
Fixation responses(levelofcortisol)[14],understand
horizontalandvertical
howspatialpropertiesimpactgazepatterns
coordinatesduringfixation
andriskperception[11],andunderstand
thevisualattentionpatterns[15]
Analyzethedriver’svisualattention
- Gazedirectionaccuracy
allocationtowardsareaswherepotentially
- Pupiltrackingaccuracy
Gaze conflictingvulnerableroadusers(VRUs)
- Visualangleaccuracy
couldapproachduringdrivingmaneuvers
aturbanintersections[18]
Explorecyclists’behaviorandunderstand
howcyclistsnavigatechallenging
conditionsandrespondtoenvironmental
Eye-trackervideosAnalysis stimuli(whenapproachingatwo-way
cyclingpathwheninteractingwithcars,on
aU-turn,whenfacedwitharedtrafficlight,
etc.) [10].

Sensors2025,25,22 11of53
Table4.Kinematicmetrics’characteristicsandusesindataanalysisinrealenvironmentstudies.
Kinematic
Objectives
Data
Understandtheeffectsofdifferentroadconditions(snowyanddry)on
cyclists’safetyandcomfortwhilecycling[10],examinetheinfluenceof
speedonvisualattentionbehaviorandvisualsearchpatternsfor
Speed pedestrians,cyclists,ande-scooterridersinsharedroadspaces[15],
andexplorehowcyclistsanddriversnavigateintersectionsandthe
effectofspeedontheirabilitytoprocessvisualinformationand
respondtostimuli[16].
Measurestheamountofeffortmadebycyclistswhilepedalingto
Power evaluatethephysicaldemandsoncyclistsandtheiroverall
performanceindifferentsituations[10].
Reflectsacyclist’spedalingrhythm,revealinghowtheyadapttheir
Cadence techniquetomaintainefficiency,control,stability,andsafetyin
differentconditions[10].
Studyhowroadusers’locationsinintersectionsinfluencevisibility,
Position decision-making,andpotentialconflictsbetweencyclistsand
drivers[16].
Table5.Subjectivedatacharacteristicsandusesindataanalysisinrealenvironmentstudies.
SubjectiveData Objectives
Understandhowcyclistsinteractinchallenging
conditionsbyanalyzingtheirsafetyfeelingswhile
Perceivedsafetyandrisks cyclingincoldandsnowyconditions[10]and
understandtheeffectsofthedifferentlevelsofrisk
perceptionofcyclistsontheirbehavior[11,14].
Identifychallengesfacedinadverseweatherconditions,
thusimprovingcyclinginfrastructure[10],understand
factorsinfluencingdecisionmakingindifferent
Comfortlevelsanddifficultiesencountered
scenarios[16],understandhowpathqualityaffects
cyclists’comfort,andimprovecyclingfacilitiesthatare
morechallengingtonavigate[17].
Identifytheelementsthatcapturecyclists’attentionat
intersections[16]andurbanroutes[17],thus
understandingthecyclists’interactionbehaviorwith
Perceivedvisualinformation
otherroadusersandtheirenvironment[16,17],and
exploretheeffectivenessofimplementinganewsignage
strategyanditsinfluenceoncyclists’behavior[19].
Aimstounderstandtheindividualdifferencesbasedon
Familiaritywithtestlocations cyclists’familiaritywiththeroadandcorrelatethemwith
cyclists’visualbehavior[11,14].
Classifyparticipantsandexplorehowdifferent
Cyclingskillsandhabits experiencelevelsmightinfluencetheirgaze
patterns[11,14,16,17].
Examinehowwinterclothingaffectscyclists’visibility
Effectsofwinterclothes
andmobility[10].
Allstudiescollectedgazedata,whileonlythreestudies[10,15,16]collectedkinematic
data. Post-questionnairesandsurveyswereconductedinsixstudies[10,11,14,16,17,19].
Equipmentusedtocollectgazeandkinematicdata:Differenttypesofequipmentwere
usedtocollectgazeandkinematicdata,whichwillbeaddressedinthefollowingsection.

Sensors2025,25,22 12of53
Forcollectinggazedata,differenttypesofeyetrackersarereported: the“PupilPro”
Eye tracker system (Pupil Labs GmbH, Berlin, Germany) with “Pupil” software (Pupil
CaptureandPupilPlayer-JointReleasev0.3.8)[9],the“ASLMobileEye-XG”(ASLEye
Tracking,Billerica,MA,USA)Eyetrackersystemwith“EyeVision”software[14,17],the
“PupilLabsInvisible”(PupilLabsGmbH,Berlin,Germany)withamachinelearningneural
networksalgorithmfortrafficobjectidentificationdevelopedbyEpigramAS[19],“Tobii
Pro-Glasses2”(Tobii,Stockholm,Sweden)[10,13,15,16],the“SMIEyeTrackingGlassesV1”
Eyetrackersystem(SensoMotoricInstruments,Teltow,Germany),inwhichgazepositions
were manually marked on allocentric reference maps containing all stationary, traffic-
relatedfeatures[11],andthe“DikablisEyeTrackingGlasses3”EyeTracker(Ergoneers
GmbH,Egling,Germany)withD-Labsoftwarev3.50.8786.0[12,18].
Forcollectingkinematicdata,study[16]usedtwoactioncameras(GarminLtd.,Olathe,
KS,USA)equippedwithGPStocollectdatafromcyclists,capturingthefrontviewand
thecyclist’sface,aswellasthespeedandposition. Fordrivers,aninstrumentedvehicle,
the“VolvoV60”(VolvoCarCorporation,Gothenburg,Sweden),equippedwiththedata
logger“VideoVBOXPro”(RACELOGIC,Buckingham,UK),wasusedtocollectthespeed,
position, and views from the forward, rearward, right-side, and driver’s perspectives.
Study[10]collectedthespeed,power,andcadenceusingthe“Garminsystem”(Garmin
Ltd.,Olathe,KS,USA),whichcomprisesvarioussensors. Ontheotherhand,study[15]
calculatedthespeedfromrecordedvideos,usingasimpleformula: dividingthedistance
overtimetaken.
Regardingthedurationofglances,itisimportanttonotethatcertainstudieshave
defined specific thresholds for saccades and fixations. Table 6 displays the thresholds
specifiedineachstudy.
Table6.Thethresholdsforfixationandsaccadedurationsacrossthestudies.
SaccadeDuration FixationDuration
StudyID
(Milliseconds) (Milliseconds)
[9,16] <200 >200
[17] (0–80) (80–500)
[12] <100 >100
[15] <200 >200
SubjectiveData: Participantswereprimarilyquestionedabouttheirtestexperience,
focusingontheirperceptionofriskandhazards,aswellasanychallengesthatimpacted
theircomfortandsafetywhiledriving.
StatisticalTests: Thestatisticaltestsemployedacrossthestudiescanbecategorized
intothreegroups.
Descriptivestatisticaltestswereusedtodescribedatacharacteristicssuchasthemean,
variance,andstandarddeviation. Studies[10,13,14,16,17]utilizeddescriptivestatisticsto
calculatemeasureslikethemean,thestandarddeviation,thefrequency,andthepercentage,
andtheyalsoemployedpiecharts,histograms,andvariousgraphicalplots.
Model-basedstatisticaltestswereusedtofitmodelstothedataforpredictionsandcon-
clusions. TheseincludedGeneralizedLinearMixedModels(GLMMs)instudies[9,11,18],
ANOVA tests in study [9], Wilcoxon Signed Ranks tests in studies [9,16], Z-tests in
studies[11,16,17],logisticregressionmodelsinstudy[18],negativebinomialmodelsin
study[12],andpairedt-testsinstudies[13,14].
Machinelearningstatisticaltestsinvolvealgorithmsforcertaintasks, suchasclas-
sification, segmentation, and tracking. Two algorithms were used in this review: the
“Dwell-timefixationdetectionalgorithm”intwostudies[14,17],whichisanunsupervised

Sensors2025,25,22 13of53
algorithm,withitstasksbeingsegmentationandclassification(itsegmentsglanceswitha
minimumdurationof100ms,classifiesthemasfixations,andexportsmetricslikeduration
andinter-fixationduration),andTheNeuralNetworksforTrafficObjectIdentificationin
thestudy[19],analgorithmthatcomprisestwosub-algorithms. TheFasteRCNNmodel
consistsofclassifyingobjects(classificationtask)andidentifyingthemwithinthevideo
framethroughsegmentation,andtheKalmanfilterisusedfortrackingtheobjectsover
time. Thus, theneuralnetworksalgorithmcanbeusedtoautomaticallycategorizethe
objectsparticipantswereviewing.
3.2.2. VirtualEnvironmentStudies
Elevenstudieswereconductedinasimulatedenvironment. Thistypeofexperiment
isdesignedtoimitatereal-worlddrivingconditions. Participantsengagewithdrivingsim-
ulatorsthatreproducethesensationofoperatingavehicle,incorporatingvisual,auditory,
andtactilesensations.
Varioustypesofvirtualenvironmentresearchwereutilized,fromlow-levelcomputer-
based to high-fidelity and interactive virtual environments. The various types are
explainedbelow.
• DesktopSimulation: Thisinvolvessimulationconfigurationswherebyparticipants
operatewithinanimmersiveenvironment,anon-immersivesetup,physicalinterfaces
forcontrol,andwithouthead-mounteddisplaysorfullyenclosedenvironments[20].
• Virtual Reality (VR) Cycling Simulator: a Virtual Reality (VR) Cycling Simulator,
designedforhazardperceptiontrainingintrafficandclutteredenvironments. Itfea-
turesreal-timesensorintegrationandusesproceduralcontentgenerationfordynamic
scenariocreation[21].
• High-FidelityVirtualRealityCyclingSimulator: High-fidelityvirtualrealitycycling
simulatorsjoinreal-world-standardcyclingequipmentwiththatofvirtualrealityto
bringaboutrealisticridingconditionsofcyclistsforanalysisofcyclistbehaviorin
realisticsurroundings[22].
• AdvancedImmersiveBicyclingSimulator: Utilizationofhigh-fidelityvisualscoupled
with the situation in an extended manner is a technique that mimics closely the
physicalandvisualdynamismofbicyclingintherealworld[23,24].
• High-FidelityDrivingSimulator: Thistypeofsimulatorischaracterizedbyitsability
toprovidearealisticdrivingexperiencethatcloselymimicsactualvehiclebehavior
andenvironmentalinteractions[25–28].
• AdvancedImmersiveDrivingSimulator:Thisisacombinationofhigh-qualityfeatures
thatenabletheprovisionofdeepimmersionandaresponsivedrivingexperiencefor
effectivestudiesofdriverbehaviorindynamicandemergencyconditions[29].
• Full-Scale High-Fidelity Driving Simulator: A high-fidelity driving simulator that
involvestheuseofrealisticfull-scalesystemswithinthevehicle,advancedmotion
systems,andtechnologiesinvolvingvisualandauditoryimmersiontocreateahighly
preciseandrealisticdrivingexperience[30].
Figure 4 shows the distribution of the studies across the different types of virtual
simulators.

Sensors 2025, 25, x FOR PEER REVIEW 13 of 51
interfaces for control, and without head-mounted displays or fully enclosed environ-
ments [20].
•
Virtual Reality (VR) Cycling Simulator: a Virtual Reality (VR) Cycling Simulator, de-
signed for hazard perception training in traffic and cluttered environments. It fea-
tures real-time sensor integration and uses procedural content generation for dy-
namic scenario creation [21].
•
High-Fidelity Virtual Reality Cycling Simulator: High-fidelity virtual reality cycling
simulators join real-world-standard cycling equipment with that of virtual reality to
bring about realistic riding conditions of cyclists for analysis of cyclist behavior in
realistic surroundings [22].
•
Advanced Immersive Bicycling Simulator: Utilization of high-fidelity visuals cou-
pled with the situation in an extended manner is a technique that mimics closely the
physical and visual dynamism of bicycling in the real world [23,24].
•
High-Fidelity Driving Simulator: This type of simulator is characterized by its ability
to provide a realistic driving experience that closely mimics actual vehicle behavior
and environmental interactions [25–28].
•
Advanced Immersive Driving Simulator: This is a combination of high-quality fea-
tures that enable the provision of deep immersion and a responsive driving experi-
ence for effective studies of driver behavior in dynamic and emergency conditions
[29].
•
Full-Scale High-Fidelity Driving Simulator: A high-fidelity driving simulator that in-
volves the use of realistic full-scale systems within the vehicle, advanced motion sys-
tems, and technologies involving visual and auditory immersion to create a highly
precise and realistic driving experience [30].
Figure 4 shows the distribution of the studies across the different types of virtual
Sensors2025,25,22 simulators. 14of53
Figure4.Thenumberofstudiesforeachtypeofvirtualsimulator.
Figure 4. The number of studies for each type of virtual simulator.
1. Samples’Characteristics
1. FSirastm,thpelaevse’r aCghesaarmapclteesriizsetiincasl lstudiesis46,witharangefrom5to130participants.
Theagerangeofparticipantsacrossallstudiesisbetween10.83and65.8years,withan
First, the average sample size in all studies is 46, with a range from 5 to 130 partici-
unweightedmeanageof27.9.Onestudymaintainedgenderequity. Fourstudieshadfewer
pfeamnatlse.p Tahrteic iapganet sr,awnigthep oerfc penatratgiecsipraanngitnsg afcrormos0s% atlol 4s6tu.50d%ie,sw ihsi lbeefotuwresteund i1es0h.8a3d and 65.8 years, with
morefemaleparticipants,withpercentagesrangingfrom57%to70.77%. Amongtheeleven
an unweighted mean age of 27.9. One study maintained gender equity. Four studies had
studies,fourrequiredparticipantstohavenormalorcorrected-to-normalvision,whileone
fewer female participants, with percentages ranging from 0% to 46.50%, while four studies
studynotedissueswitheyetrackingwhenwearingglasses. Twostudiesspecifiedthatonly
hcoandta mctolernese fsewmeraeleal lpowaretdi,cnipotaenytesg,l awssietsh. T pheerrcemenaitnaigngesfo ruarnstguidniegs dfridomno t5p7ro%v idtoe 70.77%. Among the
einlefovremna tsiotnudonievsi,s ifoonurerq rueirqemuiernetds f oprapratritcicipipaannttss. tSoec ohnadvlye, tnhoersmamapll iongr sctorartreegcietsed-to-normal vision,
employedinthestudiesincludedpurposive,convenience,andmixedmethods(purposive
andconvenience). Themajorityofstudies(n=6)utilizedconveniencesampling. Four
studiesemployedmixed-methodsampling,whileonlyonestudyusedpurposivesampling.
Subsequently,participantswererecruitedthroughoneormoreofthefollowingmethods:
fromschoolsneartheexperiment’slocation(n=1),fromthecommunityofthecitywhere
the experiment took place (n = 4), through university email lists, announcements, and
thewebsite(n=2),fromtheuniversitycampus(n=2),andbydistributingflyersinthe
neighborhoodneartheexperiment’slocation(n=2).
Thirdly,participantswerecategorizedascyclists,drivers,orpedestrians,andsome
wereaskedtogothroughthescenariostwice.Thisresultedinfourstudieswithparticipants
exclusivelyascyclists,sixstudieswithparticipantsexclusivelyasdrivers,andonestudy
thatincludedcyclistsandpedestrians. Amongthestudiesinvolvingcyclists,participants
hadvaryinglevelsofcyclingexperience,rangingfrombeginnerstoexperiencedcyclists.
Thisdiversityinparticipantsenhancesthegeneralizabilityoftheresults. Inonestudywith
driversonly,thesamplewassplitintotwogroups,cyclists,andnon-cyclists,toexamine
theinfluenceofcyclingexperienceondriverbehaviortowardscyclists. Theotherstudies
involvingdriversrequiredaminimumofoneyearofdrivingexperience.
Detailedinformationonsamplesize,genderdistribution,sourceofparticipants,road
usertype,andcyclingexperienceisprovidedinAppendixA,TableA2,whileinformation
onsamplingstrategiesisavailableinTableA3.

Sensors2025,25,22 15of53
2. ExperimentalDesignandProcedure
Allstudieswereconductedinsimulatedvirtualenvironmentsusinganexperimental
designmethod. Researchersmanipulatedvariablesandobservedtheireffectsincontrolled
settings,selectingspecificscenariosbasedontheaimofeachstudy.
Springer-Teumer S. et al. [20] conducted a 2 × 2 mixed-design bicycle simulator,
whichincludedanexperimentalwithin-factor(systemusage: WITHvs. WITHOUTCyclist
WarningSystem(CWS))andaquasi-experimentalbetween-factor(agegroup: youngervs.
oldercyclists)toevaluatetheeffectsoftheCWSoncyclists’hazardperceptionthroughthe
analysisofgazebehavior.
Inonestudy[23],JashamiH.etal. controlledenvironmentalandroadwayconditions
toassessthevisualattentionofcyclistsincommercialvehicleloadingzones. AbadiM.G.
etal.[24]createdvirtualscenariostoinvestigatetheimpactofpavementmarkings,truck
traffic,andgenderoncyclists’visualattention.
WarnerJ.etal.[25]exposeddriverstodifferenttreatmentconfigurationstoassess
theeffectsofengineeringcountermeasuresondrivers’visualattentionduringright-turn
maneuversatsignalizedintersections.
Kim A.J. et al. [26] manipulated variables (physiological arousal, attention to cy-
clists)withinacontrolledenvironment(adrivingsimulator)toobservetheireffectson
drivingbehavior.
Inthestudy[29],ZhaoY.etal. conducteddrivingsimulatorexperimentstoanalyze
driverresponsestocyclistscrossingfromnearandfarsides.
RobbinsC.J.etal.[30]involvedthecontrolledmanipulationofindependentvariables
(suchasroadsignsandvehicletypes)inasimulatedenvironmenttoobservetheireffects
ondependentvariables,suchasdrivers’visualattentionandbehavior.
Fleskes K. et al. [27] manipulated independent variables (TOR proximity, relative
bicycleposition,secondarytaskengagement)toobservetheireffectsondriverperformance
andinteractionswithcyclists.
Inthestudy[28],JannatM.etal. exposedparticipantstodifferentscenariosinthe
simulateddrivingenvironmenttoassessdriverbehaviorandvisualattention.
GuoX.etal.[22]usedimmersivevirtualenvironmentstomanipulateroadwaydesign
variables,analyzingtheirimpactonthevisualbehaviorandphysiologicalresponsesof
cyclistsandpedestriansincontrolledsettings.
ZeuwtsL.H.R.H.etal.[21]manipulatedtrafficscenarioswithinaVRsimulator,exam-
iningyoungcyclists’hazarddetectionandanticipationinacontrolledsettingthatprecisely
measurestheirresponses.
Characteristics related to the procedure and conditions of executing the different
experimentsarediscussed. Thedrivingscenariossimulatedweretailoredtothespecific
objectives of the study. Researchers controlled the environment by introducing critical
eventsandconflictsamongdifferentroadusers. Somestudiesaimedtomanipulateurban
features to observe their impact on participants’ gaze behavior. The simulated driving
scenariosincludedthefollowing.
• NavigatingRight-TurnManeuversatIntersections: usedtoexplorethecyclists’and
drivers’behaviorinvariousintersectionconfigurations[20,25–28].
• Cyclist–VehicleConflictDynamicsinUrbanEnvironments: usedtoanalyzethecon-
flicts between cyclists and other vehicles (trucks, cars) in different urban settings
(e.g., dooring scenarios, various loading zone configurations, lane configurations,
intersectiontypes)[20,21,23–26,29,30].
• Cyclist–Pedestrian Interactions: used to assess cyclists’ and pedestrians’ behavior
at pedestrian crossings at signalized and unsignalized intersections [22]. Detailed

Sensors2025,25,22 16of53
informationaboutthestudydesignanddrivingscenariosisprovidedinAppendixA,
TableA3.
3. DataCollectionandAnalysis
In this part, the data metrics collected used across the studies to analyze the cy-
clists/drivers’behavioringeneralandtheirvisualbehaviorinparticularwillbediscussed.
Inaddition,theequipmentusedtocollectdataandthesoftwarefordataprocessingand
analysisarealsomentioned.
For each study, information about the data collected is provided in Appendix A,
TableA3;outcomesmeasuredareinTableA4,andtheresultsareinTableA5.
Fourtypesofdatawerecollectedintheselectedresearchstudies,whicharediscussed
asfollows:
• Gazedatacollectedusingeye-trackingsystems. Thesedataarebrieflysummarizedin
Table7.
• KinematicdataobtainedthroughGPStracking,accelerometers,andgyroscopesorby
dividingtheselecteddistancepertime. Thesemetricsaremeasuredandanalyzed,
andtheirobjectivesarepresentedinTable8.
• Subjective data, gathered through questionnaires, surveys, or interviews after
the experiment. Table 9 shows the subjective data collected and analyzed, and
theirobjectives.
Table7.Gazemetrics’characteristicsandusesindataanalysisinvirtualenvironmentstudies.
Eye-TrackingData Characteristics Objectives
- Duration: meanduration,
Assessthehazardperceptionofcyclistsinresponseto
averagetotalduration,total
differentAOIswithintheirfieldofview[20]andthe
duration
Fixation visualattentionperformanceofcyclistsasthey
- NumberoneachAOI
navigatecommercialvehicleloadingzones[23],
- The“Entrytimeofthefirst
understandtheeffectsofpavementmarkings,truck
fixation”
maneuvering,andgenderoncyclists’visualattention
duringconflictswithtrucktraffic[24],assessthe
distributionofcyclists’visualattentiontodifferent
AOIsduringthetest[25],assessifvisualattentionis
linkedtophysiologicalarousalandchangesindriving
behavior[26],evaluatethedrivers’visualattentionat
junctions[30],assessthevisualattentionofdriversof
Saccade - Number automatedvehicleswhentheyinteractedwithcyclists
duringaright-turnmaneuverafterreceivinga
take-overrequest(TOR)[27],measuredrivers’visual
attentionduringright-turnmaneuversinthepresence
ofadjacentcyclists[28],andevaluateyoungcyclists’
hazardperceptionandanticipationabilityindifferent
trafficsituations[21].
- Gazeangle Integratedwithvelocity,acceleration,andbraking
- Gazelocation reactiontimetounderstandtheeffectsofthese
- Horizontalgazedirection parametersoncar–cyclistcollisionoccurrence[29]to
Gaze
- Pupildiameter explorevisualscanningpatterns,thelevelofvisual
- StationaryGazeEntropy—Gaze workload,andstresslevels(inferredfrompupil
TransitionEntropy diametersize)ofparticipants[22].

Sensors2025,25,22 17of53
Table8.Kinematicmetrics’characteristicsandusesindataanalysisinvirtualenvironmentstudies.
KinematicData Objectives
Assesshowquicklyparticipantsapproachhazardsto
indicatetheirlevelofrisk-takingbehavior[21],
understandtheircomfortlevelsandreactionstoroadway
designsortrafficconditions[22],evaluateinteraction
Speed/velocity
dynamicsbetweenvehiclesandcyclists,including
scenarioslikerightturnsandintersectionmaneuvers[27],
andassesscollisionrisksandsafedriving
practices[26,29].
Evaluatehowquicklycyclistsrespondtocriticalevents
withandwithoutcollisionwarningsystems(CWSs),thus
Brakingreactiontime(BRT) assessingCWSs’effectivenessinenhancingreactiontimes
tohazards[20]andevaluatehowmuchtimedriversneed
toinitiatebrakingaftercyclistsbecomevisible[29].
EvaluateCWSs’influenceoncyclists’hazardawareness
andreaction[20]andunderstandcollisionrisksduring
Timetocollision(TTC)
interactions,suchasright-turnscenariosorautomated
vehicletake-overrequests[27,29].
Evaluatecyclingefficiency,control,andsafetyin
Cadence
simulatedtrafficscenarios[21]
Analyzeparticipantmaneuveringtoavoidhazards,
indicatingdecision-makingandcontrolabilities[22],and
Steering evaluatehowdriversadjuststeeringinresponseto
cyclists,reflectingtheirattentivenessandinteraction
dynamics[26].
Analyzetheinteractiondynamicsbetweenvehiclesand
Positiondata
cyclists,particularlyinright-turnscenarios[27].
Assesshowthedistanceaffectsthedriver’svisual
Distancemeasurementtooncomingvehiclesatjunctions attentionanddecisionmaking,particularlyintermsof
whenandhowsafelytheypulloutatthejunction[30].
Evaluatehowdriversadjusttheirlaneposition,steering
wheelposition,acceleratorpedalposition,andbrake
pedalpositionwheninteractingwithcycliststoensure
safenavigationandcollisionavoidanceandanalyzetime
Driverperformancedata
headwaytoupstreamobjectsandthetimetolane
crossingtounderstanddrivers’situationalawarenessand
abilitytoreactappropriatelytothepresenceof
cyclists[30].
Table9.Subjectivedatacharacteristicsandusesindataanalysisinvirtualenvironmentstudies.
SubjectiveData Objectives
Assesscyclists’feelingsofsafetywhenusingcollision
warningsystems(CWSs),focusingontheirconfidence
andsenseofsecurityinhazardoussituations[20],and
PerceivedSafety evaluatedrivers’perceptionsofsafetywheninteracting
withcyclists,particularlyinchallengingscenarios,to
understandtheemotionalandcognitiveinfluenceson
behavior[26,30].

Sensors2025,25,22 18of53
Table9.Cont.
SubjectiveData Objectives
AnalyzethecognitivedemandsputoncyclistsusingtheCWS
MentalWorkload todeterminewhethertheCWShasapositiveornegativeeffect
onmentalworkload[20].
Evaluatetherealismanduserexperienceofvirtual
environmentstoensuretheyeffectivelyreplicatereal-life
RealismandSimulatorExperience
conditionswhileminimizingsimulatorsickness
symptoms[21–23].
Capturedrivers’feelingsofanxiety,nervousness,and
EmotionalResponsesandSelf-Perception self-perceivedskillswheninteractingwithcycliststo
understandemotionalandcognitiveeffectsonbehavior[26].
Gatherdemographicdataanddrivingorcyclingexperienceto
IndividualDifferencesandCycling/DrivingSkills betterunderstandparticipantbehavior,focusingondifferences
inreactionstoroadscenarios[23,29,30].
Physiologicaldatacollectedusingsensors. Similarly,Table10presentsthesubjective
datacollectedandanalyzedandtheirobjectives.
Table10.Physiologicaldatacharacteristicsandusesindataanalysisinvirtualenvironmentstudies.
PhysiologicalData Objectives
Trackcardiovascularresponsestotraffic
conditions,potentialhazards,and
HeartRate(HR) environmentalstimuli,offeringinsightsinto
stress,excitement,oranxietylevelsduring
interactionsorsimulatedscenarios[22,26].
Evaluatevariationsindrivers’breathing
patternsasindicatorsofstressoranxietywhen
BreathingRate
interactingwithcyclists,thusassessing
emotionalarousal[26].
Monitorskinconductancechangestoevaluate
ElectrodermalActivity(EDA)/GalvanicSkin physiologicalarousalorstress,helpingto
Response(GSR) analyzeparticipants’emotionalresponses
duringchallengingtrafficscenarios[23,26].
Studyparticipants’headmovementpatternsto
HeadMovements understandtheirvisualscanningbehaviorand
awarenessofpotentialhazards[22].
Allstudiescollectedgazedata,whileonlysevenstudies[20–22,26,27,29,30]collected
kinematicdata.Post-questionnairesandsurveyswereusedinsevenstudies[20–23,26,29,30].
Inaddition,threestudies[22,23,26]gatheredphysiologicaldata.
Equipmentusedtocollectgazeandkinematicdata: Thedifferenttypesofequipment
usedtocollectgazeandkinematicdatawillbeaddressedinthefollowingsection.
For collecting gaze data, the different eye-tracking systems used are the “SMI Eye
Tracking Glasses 2” Eye tracker system (SensoMotoric Instruments, Teltow, Germany)
with“SMIiViewETG”v2.7softwaretorecordgazedata[20],the“ASLMobileEye-XG”
eye tracker (ASL Eye Tracking, Billerica, MA, USA) [23–25,27,28] to collect gaze data,
withaLogitechC920HDProCamera(Logitech,Lausanne,Switzerland)torecordvideos
forcyclistsduringtheexperiment[23],aneye-trackingcamera“FOVIO”system(Seeing
Machines,Canberra,Australia),usedinastudy[26]tocollectdrivers’gazedata,a“Smart
EyeProDXsystem”(SmartEye,Gothenburg,Sweden),usedtostudythedriver’sgaze
movementsinastudy[29],andthe“FaceLAB5.0”eye-trackingsystem(SeeingMachines,
Canberra, Australia), used to collect the driver’s gaze movements in a study [30]. One

SS eennssoorrss2 2002255,,2 255,,2 x2 FOR PEER REVIEW 1
1
8
9
o
o
f
f 5
5
3
1
ssttuuddyy [[2222]] uusseedd aa VVRR hheeaaddsseett wwiitthh eeyyee ttrraacckkiinngg,, ““HHTTCC VVIIVVEE PPrroo EEyyee”” ((HHTTCC CCoorrppoorraattiioonn,,
TTaaooyyuuaann,, TTaaiwiwaann)),, ttoo ccoolllelecctt ccyycclilsisttss’’ aanndd ppeeddeessttrriaiannss’’ ggaazzee ddaattaa,, aanndd ththee VVRR//AARR eeyyee--
ttrraacckkiinnggg glalasssseess( P(PuuppililL LabasbsG GmmbHbH,B, eBrelirnl,inG, eGrmeramnayn)yw) ewreeures eudsetod ctool lceocltlgecatz egadzaet adiantath ien
stthued sytu[2d1y] .[2S1e]v. eSnevsteund siteusd[i2e0s, 2[230,2,253–2,285,3–02]8,e3s0t]a beslitsahbelidshtheed fithxea tfiioxnattihorne sthhroelsdhaosld1 0a0s m10s0. ms.
IItt iissi mimppoortratannttt oton ontoeteth tahtabt ebyeoynodnsdt asntadnadrdargda zgeazmee mtriectsr,icssu,c shuacshfi axsa fitixoantiaonnd asnadcc asadce-
dcuadraet idounrsaotirocnosu onrt csoounnatsr eoans aorfeianst eorfe sintt(eAreOsIt) ,(AmOoIr)e, smooprhei sstoicpahteisdtimcaetetrdi cmswetreirces awlseoreu saelsdo.
Sutsueddy. S[t2u1d]yin [2tr1o]d inutcreodduthceed“ tEhnet “ryEnttimrye tiomfet hofe thfiers fitrfistx fiatxiaotnio”n,”w, whihchichm meaesausurersest htheet tiimmee
bbeettwweeeennt htheeo onnsesteto fotfh tehee veevnetnatn adntdh ethfier sfitrfistx afitxioantioonn tohne tahree aaorefain otfe rienstte.rIensta. dIdni taidond,ittiwono,
atdwvoa nadcevdanmceedtr imcsewtriecrse wemerpe loemyepdlouyneidq uuenlyiqiuneloyn iens otundey st[u22d]y: S[2ta2t]i: oSnteartiyonGearzye GEanztero Epny-,
wtrhoipcyh, qwuhainchti fiqeusatnhteifileesv tehleo lfefvoeclu osf ofofcausp eorfs ao npebrysomn ebays umrienagsuthriengg athzee gdaiszpee drsisiopnerasinodn
caonndc ecnotrnacteionntradtuiornin gduarviniegw ain gvipeweriinogd ,paenrdioGd,a zaenTdr aGnsaizteio nTrEanntsriotipoyn, wEhnitcrhopmy,e awsuhriecsh
tmheeacsoumrepsl etxhiet ycoomf tprlaenxsitityi oonfs tbraentwsiteieonnsd ibfefetwreenetng daziffeepreonint tgs.azMe epaoniwnths.i lMe,etahnewmheilteh,o tdhse
umseedthofodrs cuosleledc tfionrg ckoilnleecmtiantgic kdinaetamiantcicl uddaetam ienacsluudrien gmTeaTsCur(itnimg eTTtoC c(otilmlisei otno) ctohlrloisuiognh)
rtehcroorudgehd rveicdoerodseads vaidmeeotsr iacsf oar mbreatkriicn gforre abcrtaikoinngb erheaavctiioorn[ 2b0e]haanvdiofro r[2c0o]l laisnido nfoarv cooidllaisniocen
baevhoaidvaionrc[e2 b7e],hmaveiaosru [r2i7n]g, mtheeadsurirvinerg’ sthtrea dvreilvteirm’se tarasvaeml teimtreic afso ra ampeptrroica cfhorb aephparvoioacrh[3 b0e]-,
ahnadvicoorl l[e3c0t]in, agnddr icvoinllgecmtinegas durrievsi,nsgu cmheaassuverelos,c istuy,cahc aces lverealoticointy,,a ancdceblrearkaitniognr, eaancdti obnratikmineg,
frreoamctitohne stiimmue,l aftroormso tfhtwe asrime[u2l6a,t2o9r] .sIonftawnaorteh e[r26st,2u9d]y. I[n2 1a]n,tohtehesrp esetuddayn d[2b1r],a kthineg srpaeteedw aenred
cborlalekcintegd ruastien gwtehree incsotlrluecmteedn tuedsinbgic ytchlee .iAnsstrtuudmyen[2t2e]du bseicdytchlee. “ASW sEtuAdRy” [a2p2p] iunssetda lltehde
o“nSWaEsmAaRr”t wapatpc hintsotacloleldle cotnh aa nsdmaacrctwelaetrcahti oton cdoaltleac,tw hhaincdh wacecreeleurasetidonto diantfae, rwshpiecehd wanerde
suteseerdi ntog idnaftear. speed and steering data.
SSuubbjjeeccttiivvee ddaattaa:: PPaartritciicpipanantst swwereer eprpimriamrialryi lqyuqesuteiostnieodn eadftearf ttehre tehxepeerxipmeernimt teon atntao-
alynzaely tzheeitrh emirenmtaeln wtaolrwkloorakdlo, apde,rcpeeivrceedi vseadfetsya,f ectoym, cfoormt floervtellse,v aenlsd, acnycdlincygc/dlinrigv/indgr isvkinilgls
s[k2i0l,l2s1[,2203,,2216,,2239,,2360,]2.9 A,30d]d.itAiodndailtliyo,n palalryt,icpiapratnictisp awnetrsew aesrkeedas kaebdouatb othuetirt hpeririopr reioxrpeexripeenrcie-
ewnictehw diitffhedriefnfet retynptetys poefs soifmsuimlauteladt eedxepxepriemriemnetsn t[s2[12,213,2]3. ]T. hTeh emmaajojorirtiyty ooff ppaarrttiicciippaannttss iinn
ssttuuddyy[ [2233]]r reeppoorrteteddp prerevvioiouusse xepxpereireinecnecew withitha ab ibcyiccylicnlignsgi msiumlautloart,owr, hwerheearseapsa rptaicritpicainptasnints
sitnu dstyu[d2y1 ][2h1a]d hnaode nxop eerxipenercieewncieth waivthir atu vailrrteuaalli tryea(VliRty) (cVycRl)in cgycsilminug lsaitmoru.lPaatrotri.c iPpaarntitcsirpaatnedts
trhaetevdir tthuea lveirntvuiarlo ennmveirnotn’smcoennst’iss tceonncsyiswteinthcyth weirteha tlhwe orreladl [w21o–rl2d3 ][.2T1–h2e3r]a. tTinhges riantidnigcas tienddai-
hciagthedle av ehligofhc loenvseils toefn ccoynbseistwteenecny tbheetwreeaelna nthdes irmeaul laatnedd seinmvuirloantemde enntsv,irdoenmmoennsttsra, tdinegmtohne-
ssitmrautilnatgo trh’se esfifmecutilvateonre’sss eaffnedctriveaelnisemss. and realism.
Physiologicaldata: Forcollectingphysiologicaldata,the“Shimmer3GSR+”sensor
Physiological data: For collecting physiological data, the “Shimmer3 GSR +” sensor
(Shimmer,Dublin,Ireland)wasusedtocollectgalvanicskinresponse(GSR)data[23]and
(Shimmer, Dublin, Ireland) was used to collect galvanic skin response (GSR) data [23] and
electrodermalactivity(EDA)[26]tounderstandthephysiologicalstateandtheemotional
electrodermal activity (EDA) [26] to understand the physiological state and the emotional
arousalofcyclists[23,26], the“ZephyrBioHarness3.0”(ZephyrTechnology, Annapolis,
arousal of cyclists [23,26], the “Zephyr BioHarness 3.0”(Zephyr Technology, Annapolis,
MD, USA) was used to collect heart rate and breathing rate data in a study [26], the
MD, USA) was used to collect heart rate and breathing rate data in a study [26], the
“SWEAR”appwasusedtocollectheartratedata,andtheVRheadsetwasusedtocollect
“SWEAR” app was used to collect heart rate data, and the VR headset was used to collect
thehorizontalheadmovementdirectiondata[22].
the horizontal head movement direction data [22].
Figure5presentsthediagramshowingthestepsofdataanalysistoevaluatevisual
Figure 5 presents the diagram showing the steps of data analysis to evaluate visual
behavioranditsrelationshipwithphysiologicalandsubjectivedata.
behavior and its relationship with physiological and subjective data.
FFiigguurree 55.. SStteeppss ooff ddaattaa aannaallyyssiiss iinn ssiimmuullaatteedd eennvviirroonnmmeenntts sttuuddiieess..
SSttaattiissttiiccaallt etsetsst:s:T hTehset asttiasttiisctailcatels ttsesints ailnl oafltlh oefs ttuhdei esstuadreiecsa taergeo rciazteedgoinrtiozetdw oingtroo utwpso.
Dgreoscurpips.t iDveessctraitpisttivicea lsttaestitsstiacrael utessetds taored eusscerdib teot hdeesdcaritbaec hthaera dctaetrai scthicasr,ascutecrhisatsictsh, esumceha ans,
the mean, variance, and standard deviation. Studies [21–29] used descriptive statistics to

Sensors2025,25,22 20of53
variance,andstandarddeviation. Studies[21–29]useddescriptivestatisticstocalculate
measureslikethemean,thestandarddeviation,thefrequency,andthepercentage. They
alsoutilizedpiecharts,histograms,andvariousgraphicalplots.
Model-basedstatisticaltestswereusedtofitamodeltothedatatodrawpredictions
and conclusions. These included ANOVA tests in studies [20,22,24–27,29,30], t-tests in
studies [21,22,25,28,29], Correlation Analysis [21,22,26], Chi-square tests [21,28], linear
mixedmodels(LMMs)[23],theF-testinstudy[29],therandomizationtest[26],andpost
hoccontrasts[26].
3.2.3. ComparativeStudies(RealEnvironmentvs. VirtualEnvironment)
Thesestudiesinvolveconductingtwoexperiments: oneinavirtualenvironmentand
theotherinrealtraffic. Themainobjectiveoftheseexperimentsistocomparethevisual
behaviorofcyclistsinbothenvironmentstoevaluatethevalidityofvirtual-basedstudies.
Onestudy[31]utilizedaVRcyclingsimulator,whereasstudies[32]and[33]employedan
AdvancedImmersivebicyclingsimulator.
1. Samples’Characteristics
Theaveragesamplesizeis21,rangingfrom6to40participants.Instudies[31]and[33],
the same participants cycled twice, once in real and once in simulated environments.
Study[32]dividedthesampleinhalf,withonegroupcyclinginrealtrafficandtheother
in a VR environment. The age range of participants in all studies is between 19 and
48.85years,withanunweightedmeanageof30.44. Onestudy[31]includedonlymale
participants,whilethepercentageoffemaleswas45%instudy[32]and26%instudy[33].
Thesamplingstrategiesemployedinthestudiesconsistedofpurposiveandconvenience
sampling. Studies[31]and[33]employedconveniencesampling,whilestudy[32]utilized
purposive sampling. Participants were recruited through one or more of the following
methods: volunteersfromthecommunitywithoutspecifyingthesourcein[31]and[33],
students from the university campus [32], and using social media platforms [32]. All
participantswerecyclists,withvaryinglevelsofexperience,rangingfrombeginnersto
experiencedcyclists.
See detailed information concerning the sample size, gender distribution, source
of participants, road user type, and cycling experience in Appendix A, Table A2, and
informationaboutsamplingstrategiesinAppendixA,TableA3.
2. ExperimentalDesignandProcedure
Allstudiesemployedanexperimentaldesignmethodtocomparegazebehaviorin
virtualtrafficwithreal-worldsettings. Researchersmanipulatedsimulatorconditionsto
simulate real-world scenarios and then compared the findings with observations from
fieldstudies.
Inthevirtualscenarios,researchersinstudy[31]utilizedmachinelearningalgorithms
togeneratescenariosbytrainingthemodelwithinputdataandreceivingfeedbackfrom
theoutput. Studies[32,33]replicatedthesamecircuitusedinrealcyclingscenarios. The
drivingscenariosincludedthefollowing.
• Cyclist–VehicleConflictsinUrbanSettings: usedtoexamineinteractionsinbusbays,
nearparkingareas,andsharedpaths[31–33].
• Cyclist–PedestrianInteractions: usedtounderstandbehavioralpatternsatpedestrian
crossingsatintersections[31,33]andonsharedpaths[32,33].
Detailed information about the study design and driving scenarios is provided in
AppendixA,TableA3.
3. DataCollectionandAnalysis

Sensors2025,25,22 21of53
Thissectionwilldiscussthedatametricsutilizedinthestudiestoanalyzecyclists’
visualbehavior. Additionally,wewillmentiontheequipmentemployedfordatacollection
andthesoftwareusedfordataprocessingandanalysis.
For each study, information about the data collected is provided in Appendix A,
TableA3;outcomesmeasuredareinTableA4,andresultsareinTableA5.
Thethreeresearchstudiescollectedtwotypesofdata.
• Gazedatawereobtainedthrougheyetrackers,andtheircharacteristicsandroleswere
examined in the data analysis and the results. These data are briefly summarized
inTable11.
Table11.Gazemetrics’characteristicsandusesindataanalysisincomparativestudies.
Eye-TrackingData Characteristics Objectives
- Percentageoffixations
- Duration:meandwelltime(mean Assessthehazardperceptionskillsof
Fixation fixationduration),totalfixation cyclists[31],analyzecyclists’visual
duration attention[32],andassessthedifferencein
- FixationcountsoneachAOI gazedistributionandfixationdurations
andnumbers[33].Inallstudies,results
Saccade - Percentageofsaccades
werecomparedbetweenrealand
Blink - Percentageofblinks simulatedexperiments.
• Subjectivedataweregatheredviaquestionnairesadministeredaftertheexperiment.
Allstudiesincludedthecollectionofgazedata,withonlyonestudy[32]incorporating
post-experimentquestionnairesfordataanalysis.
Equipmentusedtocollectgazedata: Forcollectinggazedata,varioustypesofeye-
trackingsystemswereused.Study[31]utilizedthe“FOVEVRHeadset”(FOVEInc.,Minato-
ku,Tokyo)inaVRexperimentandthe“SMImobileeyegaze”(SensoMotoricInstruments,
Teltow,Germany)inrealtraffic,“PupilCore”(PupilLabsGmbH,Berlin,Germany)was
usedinstudy[32]andthe“TobiiProGlasses2”eyetracker(Tobii,Stockholm,Sweden),
alongwiththe“GoProMAX”camera(GoProInc.,SanMateo,CA,USA)tocapturethe
viewfromthecyclists’perspectiveusedinstudy[33].
Aftercollectingandsynchronizingthedata,theeyegazemetricswereanalyzedusing
differentmethodsbasedonthestudy’smethodologyandobjectives.
Instudy[31], researchersidentifiedcomparablescenariosofcyclistspassingabus
in both VR and real-life settings. Hazard perception was assessed by analyzing fixa-
tions, saccades, and blinks from the first fixation until passing the bus using MATLAB
R2020av9.8. TheagreementbetweenVRandreal-lifegazebehaviorswasevaluatedusing
Bland–Altmanplots.
Instudy[32],PupilCorevideodatawereanalyzedframebyframetoidentifyareas
ofinterest(AOI)andassignattentionorinattentionvaluesforanalyzingcyclists’visual
attention. Thesevalueswerethencomparedbetweenrealandsimulatedexperiments.
In study [33], researchers defined AOIs to categorize elements of the street envi-
ronment and mapped gaze points onto a reference picture using Tobii Pro Lab. Gaze
distribution was compared between real and simulated experiments using heat maps.
Additionally,gazemetrics,suchasthedwelltime,visitcount,averagevisitduration,and
numberoffixationspersecondoneachAOI,werepresentedandcomparedbetweenreal
andsimulatedexperiments.
Subjectivedata: Study[32]collecteddatathroughtwotypesofquestionnaires: the
“NASATaskLoadIndex”andadiseasequestionnairetoinvestigatethefactorsinfluencing
cyclists’safetyandperformance.

Sensors2025,25,22 22of53
Allstudiesuseddescriptivestatisticsteststocalculatemeasureslikethemean,stan-
darddeviation, frequency, andpercentage. TheyalsoutilizedBland–Attmanplots, pie
charts,histograms,andheatmaps.
4. Discussion
ThissectionelucidatesthefindingsofSection3withintwoprimarycontexts. Initially,
theframeworksemployedacrossthestudiesaredelineated. Subsequently,theprincipal
outcomesofthesestudies,especiallyregardingvisualattentionandvisualworkload,are
examinedindetail.
4.1. DiscussionofAdaptedFrameworks
This review aims to elucidate cyclists’ visual behavior through the application of
eye-trackingtechnologyinvariousstudies. Itsynthesizestheextantknowledgeonhow
gazedatacanbeeffectivelyutilizedtoenhancecyclists’safetybyevaluatingtheirvisual
behavior. Thereviewencompassestwoprimarydatacollectionmethodologies: real-world
environments and virtual environments. This categorization provides diverse perspec-
tives and assists researchers in selecting the most appropriate method based on their
researchobjectives.
1. Advantagesandlimitationsofrealandvirtualenvironmentstudies. Studiescon-
ductedinrealtrafficenvironmentsoffertheadvantageofyieldingunbiasedresults,
as participants are fully immersed in the actual traffic conditions. This contrasts
withvirtualenvironments,whichimposecontrolledsettingsthatmayaffectcyclists’
naturalbehavior[33]. However,ethicalconsiderationsconstrainrealtrafficstudies,
particularlythoseinvolvingdistractions,hazards,andconflictswithotherroadusers
toassesstheirimpactoncyclists’visualbehavior.Thisethicalissuecanbemitigatedin
virtualandsimulatedstudies[9,16,32].Thefindingsindicatethatbothrealandvirtual
environmentsprovidevaluableinsightsintocyclists’visualbehavior,althoughthere
arenotabledifferencesingazedistributionandfixationdurationsbetweenlaboratory
andfieldstudies[32].
2. Importance of including different types of road users and different experience
levels. Thisreviewdemonstratesthatdespitethefocusonenhancingcyclists’safety,
theparticipantpoolshouldnotberestrictedtocyclistsalone[12,15,16,26,28–30]. Un-
derstandingthebehaviorofdriversandpedestrianstowardscyclistsiscrucial, as
interactionsbetweendriversandcyclistspredominantlyoccuratcriticalpoints,such
asright-turnmaneuvers,crossings,andon-roadparking,whileinteractionsbetween
cyclistsandpedestriansmainlyoccuratcrossingsandsharedpaths. Furthermore,
includingcyclistsanddriverswithvaryinglevelsofexperienceenhancesthegeneral-
izabilityandapplicabilityofthefindingstobroaderpopulations[11,30].
3. Maintrafficscenariosincludedinthestudies. Regardingthedrivingscenariosem-
ployed,thefindingsindicatethatthemostprevalentscenariosacrossallstudytypes
wereintersection-relatedandurbanroutedrivingscenarios. Theseresultsunderscore
theimportanceofexaminingcyclists’behavioratintersections,whichareconsidered
themostcomplexandhigh-risksegment. Thesescenariosprimarilyassessthevisual
behavior, decisionmaking, andinteractionofcyclistsanddriverswithotherroad
usersatcriticalpoints[12,14,17,18,25,27,28]. Additionally,urbanroutescenariosin-
cludedamixoftrafficconditions,roadwayfeatures,andinteractionswithpedestrians
andothervehicles,providingcomprehensivedataonvisualsearchstrategies,visual
searchpatterns,andriskmanagementinurbansettings[13,21,23,32,33].
4. Relationship with subjective risk perception. Various methods were employed
acrossthestudiestoprocessandanalyzegazedata. Thegeneralframeworkinvolved

Sensors2025,25,22 23of53
definingareasofinterest(AOI),whichareobjectsinthecyclists’environmentthat
maybeobservedduringtheexperiment. Subsequently,gazelocationswereextracted
andoverlaidonframesorthecompletescenevideo. Theframe-by-frameanalysis[9],
whichinvolvesextractingfixationdataandmanuallyassociatingeachfixationwiththe
relevantroadfactor,isthemostconsumingtimemethod[14,17]. Overlayingfixation
dataonthescenevideousingsoftwareisthemosteffectivemethod. Additionally,
theintroductionofmachinelearningalgorithmsisincreasinglybeingadaptedfor
extractingandprocessinggazedata. Forinstance,aclassificationtaskwasperformed
usinganunsupervisedmachinelearningalgorithmcalledthe“Dwell-timefixation
detection algorithm”, which classifies glances as fixations based on a determined
glancedurationthreshold[14,17]. Apatternrecognitionalgorithmwasdeveloped
usingneuralnetworkstoidentifytrafficobjectsthatcyclistswerelookingatduring
thetrip[19].
5. Relationshipwithphysiologicalmeasures. Thegazedataextractedandanalyzed
variedacrossthestudiesandwereselectedbasedonthespecificaimsofeachstudy.
Theprimaryfocusacrossallstudieswasonthefixationanalysis,asitprovidesinsights
intovariousaspectsofgazebehavior,suchasvisualattention,visualworkload,visual
searchpatterns,andstrategies,asdetailedintheprevioussections. Generally,fixation
data were used to assess how cyclists and drivers navigate through intersections
andrespondtosignageandotherroadstimuli[13,15,17,24]. Additionally,thishelps
researchersevaluatetheimpactofdifferentroadlayouts,vehicletypes,andpedestrian
activitiesonvisualattentionandexplorehowenvironmentalconditions,likelighting
orweather,affectthevisualbehaviorofroadusers[9,12,16,28,32]. Theprincipalgaze
metricscalculatedarediscussedasfollows:
• Fixationdurationsandfrequenciesmeasurehowlongandhowoftenparticipants
fixateonspecificpointsorobjects,providinginsightsintowhatattractstheatten-
tionofdriversandcyclistsandinfluencestheirbehavioranddecisionmaking.
• Fixation’slocationshelpresearchersinferthepriorityofvisualinformationand
howenvironmentalfactorsinfluencevisualscanningbehaviors.
4.2. DiscussionoftheMainFindings
Thisreviewhighlightedthecriticalroleofemployingeye-trackingsystemstoevaluate
thegazebehaviorofvariousroadusers,includingcyclistsandthoseinteractingwiththem.
Theincludedstudiesdemonstratedtheimpactofseveralfactorsoneachgazebehavior,
suchasvisualattentionandvisualsearchpatterns. Thissectionisdividedintothreeparts.
Thefirsttwopartswillexaminethefactorsinfluencingvisualattention,visualworkload,
and visual search patterns. The third one will discuss the role of intersection designs
in shaping cyclists’ visual behavior and safety, given that intersections were the most
frequentlystudieddrivingscenarios.
4.2.1. VisualAttentionandVisualWorkload
Visualattentionisthecognitiveprocessofselectivelyconcentratingonaspecificaspect
ofthevisualenvironmentwhileignoringotherirrelevantinformation. Cyclistsfocusmore
intenselyonacertainvisualstimulustoprocessitrigorouslyandefficiently. Conversely,
visualworkloadreferstothecognitiveeffortrequiredtoprocessvisualinformationand
perform visual tasks, representing the mental demands placed on an individual when
interactingwithvisualstimuli.
Theliteraturedemonstratesthesignificantimpactofenvironmental,infrastructural,
andsituationalfactorsonthevisualattentionandworkloadofcyclists. Thesefactorsare
discussedasfollows.

Sensors2025,25,22 24of53
Environmentalcomplexity: Itnecessitatesthatcyclistsbalancetheirvisualattention
betweencentralandperipheralfieldsofvision,particularlyincomplexenvironments,such
asintersectionsorareaswithhighpedestriandensity. Researchindicatesthatanincreasein
pedestrianpresenceleadstogreaterenvironmentalfocusbycyclists[17].Similarly,complex
urbanenvironmentsimposeahighvisualworkloadduetonumerousexposededgesand
potentialhazardsrequiringcontinuousandrapidvisualscanning. Intersectiondesignalso
playsacrucialrole;signalizedintersectionsandthosewithpoorsignageimposegreater
cognitiveloadsbyforcingcycliststodividetheirattentionamongpotentialthreats[11,14].
Road surface and weather conditions: The type and quality of the road surface
significantlyimpactsvisualattention. Adverseweatherconditionsandpoorroadsurfaces
addtothecognitiveloadbycompellingcycliststopayextraattentiontoavoidhazards[10].
Signage and route guidance: Proper signage improves navigation and safety by
enablingcycliststoremainfocusedonthepath,especiallyincomplextrafficsituations.New
strategiesinthisdirectionhavebeenidentifiedthatpositivelyimpactthevisualattentionof
cyclists. Effectivesignagecanreducethevisualworkloadbyofferingclearnavigationcues,
althoughsignificantcognitivechallengesremainincomplextrafficenvironments[19].
Trafficandvehicleinteractions: Thepresenceofothertypesofvehicles,especially
largeones,liketrucks,influencesvisualattentionandworkload. Cycliststendtoincrease
thefrequencyoftheirvisualscanninginheavytraffictoensuresafety,leadingtoincreased
visualworkloadandshort-durationfixations[24]. Visualattentionandcrashrisksdiffer
considerablywiththerelativepositioningofcycliststodrivers,especiallyinright-hook
scenarios. Approachanglesandvisibilityinfluencedriverresponse[28].
Personalexperience: Experiencedcyclistsdemonstratemoreregulatedvisualscan-
ningandlongerfixationdurationsthaninexperiencedones. Theytendtobearalower
visualworkloadastheycanmanagetheirvisualattentionmoreexpertly[11].Thisindicates
thatexperienceisasignificantfactorinmanagingvisualattentionwhilecycling[11].
4.2.2. VisualSearchPatterns
Visualsearchpatternsareaffectedbyboththespatialcomplexityoftheenvironment
and the perceived risk. Areas with a high number of exposed edges necessitate more
frequentvisualscanningbycyclists,resultinginanincreasedvisualworkloadandshorter
fixationperiods[11]. Atintersections, cyclistsdisplaydistinctvisualpatterns, withthe
numberanddurationoffixationsvaryingaccordingtointersectiondesign.
4.2.3. Intersections’ImpactonCyclists’VisualBehavior
Intersectiondesigncansignificantlyimpactthevisualbehaviorandsafetyofcyclists.
Thenumberanddurationofvisualfixationsvarywidelybasedontheintersectiondesign.
Signalizedintersectionsandthosewithclearseparationofcyclistsfromothertraffictendto
reducethecognitiveloadonthecyclists,facilitatingmorefocusedvisualattention[14].
The complexity of intersection designs, particularly those with multiple lanes or
obstructions,necessitatesincreasedvisualscanningbycyclists. Suchareasdemandahigh
visual workload and shorter fixation periods, which can negatively affect safety if not
properlycontrolled[11].
Raisedcycletracksandotherdesignfeatures,suchasphysicalseparationfrompedes-
triansorclearsignageatintersections,havebeenshowntoenhancevisualattentionand
safety. Well-designed intersections help cyclists maintain the required T-shaped gaze
patternwithfrequentfixationpoints[13],reducingcognitiveloadandenhancingvisual
readiness for road situations. This predictability in gaze patterns contributes to safer
navigation[13].

Sensors2025,25,22 25of53
Furthermore, intersection design influences how drivers allocate their attention to
cyclists. Protectedintersectiondesignshavebeenshowntoreducethepotentialseverityof
acrashbypositivelyaffectingdriverbehavior[25].
4.3. LimitationsandFutureResearch
4.3.1. Limitations
Somelimitationshavebeenwidelynotedanddiscussedinthestudies. Itisimportant
to focus on them in future research to improve the quality of the results and increase
accuracy. Thelimitationsareclassifiedandpresentedasfollows.
1. Samplesizeandpower: Smallsamplesizeswerereportedinmanyofthestudies
to have been one of the limitations, hence influencing the possibility to identify
understatedbutpotentiallyimportanteffects[9,12,14,17,19,25].
2. Generalizability: Manystudiesarefacedwiththeproblemoftheirresultsnotbeing
generalizabletoabroaderpopulation[10,11,19,29,32].Forinstance,instudy[14],there
arechallengesoftheirsamplebeingdiverse;hence,theapplicabilityofitsresultswill
notworkoutforallagebracketsandplaces. Similarly,Refs.[24]and[20]hadfindings
whoseusefulnessdemonstratedthatthesamplefromsimulatingenvironmentshas
limitsinrepresentingreal-worldsituations.
3. Selectionbias:Manyoftheresearchersreportedselectionbiasesbecausetheparticipants
weredrawnfromparticulardemographicsorinstitutions;see[10,12]. Thislimitsthe
generalizabilityandapplicabilityofthefindingstoamoregeneral/differentpopulation.
4. Limiteduseofmachinelearningindataprocessingandanalysis:Theuseofmachine
learningindataprocessingandanalysiswaslimitedandfoundonlyinthreestudies,
wheretheneuralnetworksalgorithmwasusedtocategorizetheobjectsparticipants
wereviewing[19]andthe“Dwell-timefixationdetectionalgorithm”classifiedglances
asfixationsbasedonadeterminedglancedurationthreshold[14,17]. Thesetasksare
amongthefirstattemptstoemploymachinelearningforworkingwithgazedata.
5. Eye-trackingtechnologylimitations(informationbias):Severalstudiesreportedthat
eye-trackingtechnologylaysabiasonthelocationofthefoveaconsideringthatfoveal
processingalonecannotsupportcyclecontrolandsafetyduetolimitedinformation
throughput[9,11,18]. Additionally,thereexistsaquestionregardingtheapplicabil-
ityandreliabilityofeyetrackingindynamiccyclingenvironments; see[13,18]. In
addition,eye-trackingdatamaynotaccuratelyrepresentactualvisualattentionor
consciousperceptionandthereforemayintroduceinformationbias. Thus,misinter-
pretationofeye-trackingdatawasnotedasariskinseveralstudies,specificallyby
notingthatthegazemaynotimplyvisualattentionorhazardperception[9,11,13,19].
6. Confoundingvariables: Themostsignificantconcernsweretheexternalfactorsand
the presence of the experimenters. For example, study [16] notes that the logging
equipmentandexperimentersmaycausepotentialconfoundingthroughalterationof
participants’naturalbehavior.
7. Studydesign:Fatigueandcarryovereffectswereoftennotedinwithin-subjectdesigns
andthusaffectdatareliability, asin[23,28]. Thelackofreplicationofthesetupof
peripheralvisionwasnotedinstudies,suchas[17].
4.3.2. RecommendationsforFutureResearch
Toaddressthepreviouslymentionedlimitationsandenhancetheframeworksand
resultsoffuturestudies,researchersfromthereviewedstudiesproposedvariousrecom-
mendationsforfurtherimplementation.
1. Increasingsamplesizeanddiversity:Numerousstudieshighlightedtheneedforlarger
andmorediversesamplestoimprovethegeneralizabilityofresults[9,12,14,16,17,19].

Sensors2025,25,22 26of53
Forexample,study[17]recommendsrecruitingabroaderrangeofindividualsand
conductingstudiesindifferentlocations. Similarly,study[14]suggestsincreasingthe
samplesizeandincludingparticipantsfromvariedbackgrounds,ages,andgenders.
Toanalyzedatausingstatisticaltestsandmodels,theaveragesamplesizeforeye-
trackingstudiesis21participants[34]. Forstudiesimplementingmachinelearning
techniques,nopreviousstudieshavespecifiedacertainnumber;however,because
foreachparticipantthereisalargedataset,thesamplesizecanbeequaltoorsmaller
than21(withaminimumof10). Notethatareductioninthenumberofparticipants
duetotechnicalissuesshouldbeconsidered.
2. Exploringperipheralvisionanddifferenturbansettings: Severalstudiesempha-
sized the importance of considering peripheral vision and real-world conditions.
This would allow researchers to gain a more comprehensive understanding of cy-
clists’visualattentioninvarioustrafficconditions. Forinstance,study[18]suggests
investigating the role of peripheral vision in VRU detection, while several recom-
mendationshighlighttheneedtoconductstudiesundervariedurbanlayoutsand
trafficdensitiestounderstandhowdifferentenvironmentsimpactcyclistbehavior
andsafety[13,16,24,25].
3. Behavioralstudiesundervariedconditions: Conductingexperimentsthatexamine
cyclistbehavioracrossdifferentweatherconditions,timesofday,andtrafficscenarios
can provide more actionable insights into effective safety interventions [20,23,28].
As a proposed solution, long-term studies that capture data across different road
types,weatherconditions,andperiodsensureanenhancedcomprehensionofcyclists’
adaptabilitytoinfrastructureandenvironmentalchanges. Thistypeofstudyneedsto
defineaclearobjectiveandoverallscope,selectdependentandindependentvariables
duringlong-termdatacollection,useeye-trackingdatawithadvancedpropertiesthat
overcomeallweatherconditions,andprovideincentivesforparticipants.
4. Advancingdataanalysisthroughbroadermachinelearningapplications:Study[19]
suggestsexploringmachinelearningtounderstandcyclists’datademandsbetterand
enhancingexistingdatamodelsbyincorporatingadditionalinformation. Moreover,
machine learning can improve the accuracy of visual behavior models and help
identifypatternsmoreeffectively. Becausetheroadenvironmentdatasetcontains
significant variability, machine learning can also be applied to large datasets that
includemorefactorsfromboththeinfrastructureandthecyclists’environment[35,36].
Asaresult,adeeperunderstandingofcyclists’behaviorundervariousconditionscan
beachieved.
5. Enhancingsimulationfidelity: Manystudiesrecommendusingadvancedsimulation
technologies to better replicate real-world scenarios and reduce simulator-related
biases[10,11,21,22,31]. Forexample,ref.[22]proposesnewmethodstoimprovethe
simulation experience by integrating development platforms like Unity or Unreal
withthetransportationsimulationsoftware(SynchroorVissim)tosimulatetraffic
networks,objects,andvehiclebehaviorsmorecrediblyandcreatescenarioswhere
different users can interact together, while [31] suggests adapting virtual reality
settingstogeneratevaryinglevelsoftrafficdensity.
6. Validatingandcomparingresults: Conductingfieldteststovalidatesimulatorfind-
ings and comparing gaze behavior across different environments were recurrent
recommendations. Study[20]emphasizestheneedforfurthersimulatorandfield
teststovalidatethesafetyimpactoftheinvestigatedsystems. Additionally,ref.[11]
suggests comparing gaze behavior and risk perception between different types of
urbanenvironments.

Sensors2025,25,22 27of53
7. Equipment and multimodal data collection: Studies [9,18,19] recommend using
moredevelopedeyetrackerswithbetterstorageandbatterycapacityandtheability
to include peripheral vision. In study [19], the used eye tracker Pupil Invisible
(manufacturedbyPupilLabs)hasabatterywithupto2.5hofrecordingtimeand
40hofrecordingstorage,butasequipmenthasdevelopedovertheyears,neweye-
trackingglasseshaveupto4hofrecordingtimeand25+hofrecordingstorage,such
asPupilsNeon(manufacturedalsobyPupilLabs).Combiningeyetrackingwithother
methods,likeEEG,emotionrecognition,andinterviews,canenhancetheaccuracy
anddepthofbehavioralanalysis[13]. Inaddition,ref.[22]highlightstheimportance
ofintegratingheartratedataandbehavioralresponseswithgazedatatounderstand
theeffectofstresslevelsandmentalworkloadontheinteractionsofparticipantswith
thesurroundingenvironment. Thus,suchintegrationscanprovideaholisticviewof
thecognitiveandemotionalstatesinfluencingcyclists’gazebehaviors.
8. Establishmentofethicalstandards: Giventhepotentialrisksassociatedwithreal
trafficresearch,establishing,andenforcingglobalethicalstandardsforroadsafetyre-
searchiscrucial[9]. Thisensurestheprotectionofparticipantswhilealsomaintaining
theintegrityoftheresearchdata.
4.3.3. LimitationsoftheReviewProcess
Thesystematicreviewprocessimposessomelimitations. First,thelimitednumberof
databasesusedandtherestrictiontoselectingonlypeer-reviewedjournalarticlesinEnglish
can introduce publication biases because some important research in other languages
couldbemissed. Also,importantfindingsfromconferencepapers,theses,andothergray
literatureexcludedcouldbemissed. Second,thereviewincludedonlystudiesbetween
2010andApril2024;thus,somestudiesbetweenAprilandSeptember2024couldbemissed.
Inaddition,somerelevantpapersmaynotbeidentifiedwhileconductingForwardand
BackwardCitationSearches. Finally,theuseofAItoolsinscreeningprocessesmayresult
inselectionbias. Becausethesetoolsareemerginginsystematicreviews,severalstudies
have evaluated their use, focusing mainly on ChatGPT and ChatPDF and highlighting
theirpotentialandlimitations. ChatGPThelpsingeneratingsearchstringsfordifferent
databasesandassiststheresearcherinscreeningtitlesandabstracts,thusenhancingand
speedingupthefirststepsoftheselectionprocedure[37]. However,itcansometimesfail
tounderstandthemeaningofkeywordsinsearchqueries,missBooleanoperators,and
degradethequalityofsearchresults[37]. SuggestionsfromChatGPTtodecidewhether
to include or exclude a paper may be inconsistent or inaccurate, showing instances of
erroneous content or missingimportant information [38]. Meanwhile, ChatPDF assists
in full-text screening by providing semantic searches, evidence-based responses, and
interaction with documents [38]. Its shortcomings stem from significant challenges in
extractingandinterpretingvisualdata,suchastables,figures,andgraphs,andinadequate
performanceinextractingdetailedmethodologicalinformationrelatedtodatacollection
andsamplingmethods[39]. Inaddition,inaccurateanswerswererecordedwhenthetitle
ofthePDFdocumentwasmissing[38]. Tomitigatepossiblebiases, researchersshould
usecross-checkingandmanualevaluationofAI-generatedoutputs[37,38],andmaintain
human judgment at critical review stages to guarantee the reliability and accuracy of
results[39]. Thesepracticeshelpachieveabalancebetweenensuringrigorousandreliable
systematicreviewsandtakingadvantageofAItechnologies.
5. Conclusions
Thisreviewemphasizestheimportanceofeye-trackingtechnologyinstudyingcyclist
behaviorandimprovingcyclistsafety. Theexaminedstudiesprovidevariousmethods

Sensors2025,25,22 28of53
toanalyzevisualbehaviorusingdifferentgazemetricsandthusunderstandhowcyclists
interact with their environments, especially at critical locations, such as intersections,
and in various urban environments under different traffic conditions. Analyzing the
studiesbasedontwodatacollectionmethods,real-worldandvirtualenvironments,shows
importantfindings. Thecomparisonofthetwoapproacheshighlightedtheadvantages
andlimitationsofeachone,mainlyconcerningtheparticipants’behavior,theethicalissues,
andthepossiblebiasesinthedatacollected.
Interpreting the results enabled us to investigate the limitations across the studies
andtosuggestrecommendationsthathelpimprovefindingsinfurtherresearch. Issues,
suchassmallsamplesizes,selectionbias,andlimitedapplicabilitytobroaderpopulations,
wereidentified. Furthermore,manystudiesencounteredchallenges,suchasthelimited
informationcollectedbyeyetrackers,whichmaynotfullyrepresentactualvisualbehavior,
confounding variables that affect the naturality of the tests, and fatigue and carryover
effects that influence participants’ behavior. In addition, the reliance on conventional
datatechniques,andthelimiteduseofmachinelearningalgorithms,restricttheabilityto
integrateadditionalfactorsintotheroaddatasetandachievemoreinnovativeresults.
To address these limitations and improve the outcomes of future studies, several
recommendations can be implemented. First, the generalizability of the results can be
enhanced by increasing the sample size, including participants from diverse ages and
backgrounds,andconductingtestsindifferentlocationsthatreflectvariedinfrastructure
designs,weatherconditions,andenvironmentalconditions. Second,datareliabilitycanbe
improvedbyexploringperipheralvisionanditsimportanceinvisualbehavioranalysis.
Thiscanbeachievedthroughtheutilizationofadvancedeye-trackingtechnologiesand
theimplementationoflong-termstudiesthatencompassamorecomprehensiverangeof
variables.Moreover,thecreationofvisualbehaviormodelsbasedonmachinelearningalgo-
rithmswillfacilitateadvancedandaccuratedataanalysis,aswellaspatternidentification.
Integratinggazedatawithphysiologicalandsubjectivedataprovidesacomprehensive
understandingofcognitivedemandsandemotionalandvisualresponses.Bettersimulation
toolsarealsoworthdevelopingtocreatevirtualenvironmentsthatevokeaheightened
senseofrealism. Whencombinedwithreal-worldteststoconfirmtheresults,thesetools
can help bridge the gap between controlled experiments and actual cycling conditions.
Finally,adherencetoethicalguidelinesensuresparticipantsafetyandkeepstheresearch
trustworthy,pavingthewayforsaferandbetter-designedcyclingenvironments.
AuthorContributions:Conceptualization,F.K.,S.C.andG.P.;methodology,F.K.andG.P.;validation,
S.C.andG.P.;writing—originaldraftpreparation,F.K.andG.P.;writing—reviewandediting,F.K.
andG.P.;supervision,S.C.;projectadministration,G.P.;fundingacquisition,S.C.Allauthorshave
readandagreedtothepublishedversionofthemanuscript.
Funding:ThispaperwaspartiallysupportedbytheEuropeanUnion(NextGenerationEUthrough
theMUR-PNRRprojectRESTART(CUPE63C22002070006)aswellasbyPNRR,theNationalCen-
treforHPC,BigDataandQuantumComputing, Mission4Component2, Investment1.4, CUP
E63C22001000006.
InstitutionalReviewBoardStatement:Notapplicable.
InformedConsentStatement:Notapplicable.
DataAvailabilityStatement:Notapplicable.
ConflictsofInterest:Theauthorsdeclarenoconflictsofinterest.

Sensors2025,25,22
29of53
AppendixA
TableA1.Generalcharacteristics—part1.
ID,Ref. Objective(s)(Obj) ResearchQuestion(RQ)/Hypothesis(Hyp) Country SampleSize
Examinetheimpactoflisteningtomusiconthe
| 1,  |                                       | Docyclistscounterbalancethereducedauditoryinput |                |     |
| --- | ------------------------------------- | ----------------------------------------------- | -------------- | --- |
|     | visualbehaviorofteenagecyclistsinreal |                                                 | TheNetherlands | 14  |
| [9] |                                       | byamplifyingtheirvisualattention?               |                |     |
trafficenvironments.
UsetheMinimumRequiredAttention(MiRA)
theoryandtheSalience,Effort,Expectancy,Value
Itisassumedthatdriversandcyclistsexperience
| 2,   | (SEEV)modeltoexaminewhetherattentional       |                                              |        |     |
| ---- | -------------------------------------------- | -------------------------------------------- | ------ | --- |
|      |                                              | differinglevelsofattentionaldemandswithinthe | Sweden | 23  |
| [16] | demandsputondriversandcyclistsaredifferentin |                                              |        |     |
sameenvironment.
urbanintersectionsandhowdifficultitistofulfill
theserequirementsforthetworoadusergroups.
|     | Investigatecyclistgazebehaviorinarealurban | Thisexperimentenablesanalyzingquantitatively |     |     |
| --- | ------------------------------------------ | -------------------------------------------- | --- | --- |
3,
environmentonbicycletracksthatareexclusiveor cyclists’gazepatternsandunderstandingthefactors Italy 13
[17]
|     | sharedwithpedestrians. | thataffecttheirtrip. |     |     |
| --- | ---------------------- | -------------------- | --- | --- |
Obj1:Exploreinnovativeapproachesfor
|     | evaluatingtheimpactofrouteguidancemeasures | RQ1:Howbeneficialwastheimplementationofthe |     |     |
| --- | ------------------------------------------ | ------------------------------------------ | --- | --- |
4, oncyclistswithinactualtrafficconditions. newsignagestrategybytheOsloCityCouncil?
|     |     |     | Norway | 20–28 |
| --- | --- | --- | ------ | ----- |
[19] Obj2:Assesstheusabilityandtrafficsafety RQ2:TowhatextentdidtheOslocitycouncil’s
|     | implicationsofthenewlyimplemented | adoptionofthenewsignagestrategyprovebeneficial? |     |     |
| --- | --------------------------------- | ----------------------------------------------- | --- | --- |
wayfindingsystem.
|     | Examinecyclists’behavior,theirinteractionswith | Howdodifferentroadsurfacecharacteristicsand |        |     |
| --- | ---------------------------------------------- | ------------------------------------------- | ------ | --- |
| 5,  | roadusersand,theirresponsetovariousaspectsof   | geometricdesignsinfluencecyclists’behavior, |        |     |
|     |                                                |                                             | Sweden | 22  |
[10] theroadsurfaceandgeometriclayout,usingan perception,andinteractionswithotherroadusersin
|     | instrumentedbikeinbadweather. | extremeweatherconditions? |     |     |
| --- | ----------------------------- | ------------------------- | --- | --- |
Hyp1:Cyclistsconsiderlocationswithincreased
spatialcomplexityandnumerousobstaclesthat
obstructthelineofsightasmoreunsafe,astheyinhibit
theearlydetectionofpotentialhazards.
|     | Investigatetheeffectsofsubjectiveriskperception | Hyp2:Thespatialcomplexityofalocationandthe |     |     |
| --- | ----------------------------------------------- | ------------------------------------------ | --- | --- |
6,
andspatialcharacteristicsofalocationongaze perceivedlevelofriskdonotnecessarilydictatehow Germany 20
[11]
|     | behaviorduringurbancycling. | longanobjectisfixatedupon,buttheysignificantly |     |     |
| --- | --------------------------- | ---------------------------------------------- | --- | --- |
influencetheabilityandcapacitytolookahead.In
spatiallycomplexenvironments,cyclistsmayneedto
diverttheirgazeinvariousdirectionsandanticipate
potentialhazardsfrommultipleangles.

Sensors2025,25,22
30of53
TableA1.Cont.
ID,Ref. Objective(s)(Obj) ResearchQuestion(RQ)/Hypothesis(Hyp) Country SampleSize
Hyp1:Experienceddriverswhoregularlyusea
| Obj1:Identifytheprevalenceofdrivers’visual   | bicycleasatransportationtoolwillhavefewervisual |     |     |
| -------------------------------------------- | ----------------------------------------------- | --- | --- |
| scanningfailurestowardsareaswhereconflicting | scanningfailurestowardsareaswhereconflicting    |     |     |
| vulnerableroadusers(VRUs)couldapproachat     | vulnerableroadusers(VRUs)canapproachcompared    |     |     |
7,
urbanintersections. todriverswhorarelyorneveruseabicyclefor Canada 26
[18]
| Obj2:Assesshowthesescanningfailuresare | transportation.                              |     |     |
| -------------------------------------- | -------------------------------------------- | --- | --- |
| moderatedbycyclingexperiencefor        | Hyp2:Driverswillexhibitmorevisualscanning    |     |     |
| non-novicedrivers.                     | failuresatintersectionswithahistoryofcrashes |     |     |
comparedtothosewithoutacrashhistory.
Obj1:Provideamoredetailedquantificationofthe
areaswheredriversdirecttheirattention,aimingto
| enhancecomprehensionofhumanfactor | Howdodriversdistributetheirvisualattentionto |     |     |
| --------------------------------- | -------------------------------------------- | --- | --- |
8,
challengesrelatedtoattentiondistributionat vulnerableroaduserswhilenavigatingurban Canada 26
[12]
| urbanintersections. | intersections? |     |     |
| ------------------- | -------------- | --- | --- |
Obj2:Examinepotentialdiscrepanciesbetween
driverswhoarecyclistsandthosewhoarenot.
Obj1:Characterizetheeyemovementpatterns
| ofcyclists.                                | RQ:Studyhowurbanfeatureslikeelevatedcycle      |     |     |
| ------------------------------------------ | ---------------------------------------------- | --- | --- |
| Obj2:Explorepossiblecorrelationsbetweenthe | paths,physicalbarriers,landusage,andpedestrian |     |     |
9,
eyegazebehaviorofcyclistsandurban densityimpactthegazepatternsofcyclists. Korea 50
[13]
| environmentalfeatures,suchaselevatedcycle | Hyp:Cyclistswouldexhibitspecificgazebehaviors |     |     |
| ----------------------------------------- | --------------------------------------------- | --- | --- |
| paths,physicalbarriers,landuse,and        | influencedbydifferenturbancharacteristics.    |     |     |
pedestrianvolume.
| Understandhowdesigncharacteristicsof | Howdocyclistsvisuallyinteractwiththe |     |     |
| ------------------------------------ | ------------------------------------ | --- | --- |
10, intersectionsmoderatehowcyclistsofvarious environment,andhowdocertainfactors,suchas
|     |     | Italy | 13  |
| --- | --- | ----- | --- |
[14] experiencelevelsnegotiatetheintersections,as experiencelevelandintersectiondesign,influence
| measuredbythenumberanddurationoffixations. | theirvisualattentionanddecision-making? |     |     |
| ------------------------------------------ | --------------------------------------- | --- | --- |
Comparethevisualattentionandspeedsof
Investigatethevisualattentionandspeedsof
11, pedestrians,cyclists,andelectricscooterridersin
| pedestrians,cyclists,andelectricscooter(ES)riders |     | Poland | 12  |
| ------------------------------------------------- | --- | ------ | --- |
[15] sharedroadenvironmentstounderstanddifferencesin
whenusingsharedroads.
behaviorandpotentialhazards.
Assesstheimpactofthecyclistwarningsystem
InvestigatetheeffectsofaCWSonabehaviorallevel
12, (CWS)onbehavioralindicators(brakingreaction,
|     | anditsusers’assessments,considering | Germany | 51  |
| --- | ----------------------------------- | ------- | --- |
[20] gazebehavior)andsubjectiveratingsofperceived
age-relatedeffects.
safetyandmentalworkload.

Sensors2025,25,22
31of53
TableA1.Cont.
ID,Ref. Objective(s)(Obj) ResearchQuestion(RQ)/Hypothesis(Hyp) Country SampleSize
|     | Analyzethephysiologicalresponseandvisual | Determinehowthesizeofthecommercialvehicle |     |     |
| --- | ---------------------------------------- | ----------------------------------------- | --- | --- |
13, attentionofcyclistsincommercialvehicleloading loadingzoneinfluencesthestressresponsesofcyclists,
|     |     |     | Oregon,USA | 48  |
| --- | --- | --- | ---------- | --- |
[23] zonestounderstandhowdifferentenvironmental consideringfactorslikethepresenceandpositionofa
|     | androadwayconditionsaffectcycliststresslevels. | courierandloadingzoneaccessories. |     |     |
| --- | ---------------------------------------------- | --------------------------------- | --- | --- |
RQ1:Dopavementmarkingsandtruckmaneuvers
Investigatetheimpactofpavementmarkings,
| 14, |                                              | affectthevisualattentionofcyclists? |            | 48(7excludeddueto |
| --- | -------------------------------------------- | ----------------------------------- | ---------- | ----------------- |
|     | trucktraffic,andgenderonthevisualattentionof |                                     | Oregon,USA |                   |
[24] RQ2:Doescyclistgenderinfluencecyclists’visual technicalproblems)
cyclistsduringconflictswithtrucktraffic.
attentionduringconflictswithtrucktraffic?
Hyp1:“Theengineeringinterventiondoesnotimpact
theaveragedurationoffixationforright-turning
driversonareasofinterest(AOIs)withinthedriving
environment.”
Evaluatetheeffectsofengineeringtreatmentson
Hyp2:“Theengineeringinterventiondoesnot
| 15,  | motoristbehaviorduringright-turnmaneuversat    |                                            |            |     |
| ---- | ---------------------------------------------- | ------------------------------------------ | ---------- | --- |
|      |                                                | influencethetime-to-collision(TTC)valuesof | Oregon,USA | 28  |
| [25] | signalizedintersections,specificallyfocusingon |                                            |            |     |
right-turningmotoristsduringnear-collisionor
thelatterportionofthegreenphase.
collisionevents.”
Hyp3:“Theengineeringinterventiondoesnotimpact
thevelocityofright-turningmotoristsduringnear
collisionorcollisionoccurrences.”
Investigatetheimpactofcyclist-evokedarousal
| 16,  |                                              | Strongerphysiologicalarousalandgreaterattentionto |           |     |
| ---- | -------------------------------------------- | ------------------------------------------------- | --------- | --- |
|      | andattentiontocyclistsondrivingbehaviorinthe |                                                   | Texas,USA | 104 |
| [26] |                                              | cyclistswillbeassociatedwithsaferdrivingbehavior. |           |     |
contextofdriver–cyclistinteractions.
Obj1:Investigatedriverresponsesinemergency
car-to-cyclistcollisions.
17, Obj2:Understandthefactorsinfluencingcollision Howdodriversreactwhencyclistsintrudeintoacar’s
|      |                                           |                       | Japan | 31  |
| ---- | ----------------------------------------- | --------------------- | ----- | --- |
| [29] | occurrencesinscenarioswithdifferenttimeto | pathatanintersection? |       |     |
collision(TTC)valuesforcyclistsapproaching
fromnearandfarsides.
Examinethevisualattentionandbehavioroftwo
Investigatingthebehaviorandvisualattentionof
categoriesofdriverswithvaryinglevelsof
| 18,  |                                      | driverswithdifferingpedalcyclingexperiences |     | Study1:40 |
| ---- | ------------------------------------ | ------------------------------------------- | --- | --------- |
|      | experienceinpedalcycling(cyclistsand |                                             | UK  |           |
| [30] |                                      | towardsvulnerableroadusersatjunctionsina    |     | Study2:40 |
non-cyclists)towardsvulnerableroadusersat
drivingsimulator.
intersectionswithinadrivingsimulator.

Sensors2025,25,22
32of53
TableA1.Cont.
ID,Ref. Objective(s)(Obj) ResearchQuestion(RQ)/Hypothesis(Hyp) Country SampleSize
|     | Investigatehowthepresenceofcyclistsaffects | Howdohumandriversofautomatedvehiclesinteract |     |                   |
| --- | ------------------------------------------ | -------------------------------------------- | --- | ----------------- |
| 19, |                                            |                                              |     | 46(3excludeddueto |
driverperformanceduringautomatedvehicle withcyclistsduringaright-turnmaneuverafter Oregon,USA
| [27] |                                             |                                  |     | technicalproblems) |
| ---- | ------------------------------------------- | -------------------------------- | --- | ------------------ |
|      | take-overrequests(TORs)inadrivingsimulator. | receivingatake-overrequest(TOR)? |     |                    |
Investigatethedriver’svisualattentionandthe
Howdotherelativepositionsofadjacentcyclists
|     | riskofaright-hookcrashinasimulatedvirtual |                                                |     | 67(16excludeddue |
| --- | ----------------------------------------- | ---------------------------------------------- | --- | ---------------- |
| 20, |                                           | influencearight-turningdriver’svisualsearchand |     |                  |
environmentatsignalizedintersectionswhena Oregon,USA totechnical
| [28] |                                             | meantotalfixationdurationonareasofinterestinthe |     |           |
| ---- | ------------------------------------------- | ----------------------------------------------- | --- | --------- |
|      | cyclistispresentandindifferentcircumstances |                                                 |     | problems) |
drivingenvironment?
thatmightaffectthedriver’svisualattention.
Proposeaframeworkforevaluatingcyclistand
Howareparticipants’stresslevelsandcognitiveload
| 21,  | pedestrianbehavioralchangesbyintegrating |                                                |              |     |
| ---- | ---------------------------------------- | ---------------------------------------------- | ------------ | --- |
|      |                                          | impactedbydifferentroadwaysettingsandreal-time | Virginia,USA | 5   |
| [22] | humanphysiologicalsensingwithinimmersive |                                                |              |     |
eventsintheIVE?
virtualenvironments(IVEs).
|     | Evaluatehazarddetectionandanticipationofovert | Assesstheeffectivenessofavirtualrealitycycling |     |     |
| --- | --------------------------------------------- | ---------------------------------------------- | --- | --- |
22,
andcoverttrafficsituationsinyoungcyclistsusing simulatorinmeasuringhazardanticipationskillsin Belgium 130
[21]
|     | animmersivevirtualrealitybicyclesimulator. | children. |     |     |
| --- | ------------------------------------------ | --------- | --- | --- |
ThedevelopmentandevaluationofaCyclingand
23, Developandevaluateavirtualenvironmentto HazardPerceptionvirtualreality(VR)simulator
|     |     |     | Finland | 6   |
| --- | --- | --- | ------- | --- |
[31] assesscyclinghazardperceptionskills. (CHP-VRsimulator)toassessandpotentiallytrain
hazardperceptionskillsincyclists.
RQ:Comparethevisualbehaviorofcyclistsin
|     | Obj1:Analyzethevisualbehaviorofcyclistsin |     |     | 40(20fortheon-site |
| --- | ----------------------------------------- | --- | --- | ------------------ |
simulatedandrealscenariostohighlightobjective
| 24,  | bothsimulatedandrealscenarios.                |                        |        | testand20forthe |
| ---- | --------------------------------------------- | ---------------------- | ------ | --------------- |
|      |                                               | differencesinbehavior. | Sweden |                 |
| [32] | Obj2:Understandthefactorsthatcouldaffecttheir |                        |        | simulated       |
Hyp:Therewillbevariationsinvisualattentionand
|     | performanceandsafety. |     |     | experiment) |
| --- | --------------------- | --- | --- | ----------- |
workloadbetweenthetwoscenarios.
Hyp1:Morecontrolglancesattheroadwayinthefield
Evaluateandcomparethegazebehaviorinthe
|      |                                             | studyareexpectedcomparedtothesimulationstudy.  |         | 19                 |
| ---- | ------------------------------------------- | ---------------------------------------------- | ------- | ------------------ |
| 25,  | fieldwiththatinacyclingsimulatorsetupto     |                                                |         |                    |
|      |                                             | Hyp2:Moreactivegazebehaviorsinthefieldstudy    | Germany | Simulationstudy:15 |
| [33] | assesstherealismofthesimulatorinreproducing |                                                |         |                    |
|      |                                             | areanticipatedintermsofthenumberoffixationsper |         | Fieldstudy:14      |
trafficbehavior.
timeunit.

Sensors2025,25,22
33of53
TableA2.Generalcharacteristics—part2.
ID,Ref. SourceofParticipants MeanAge(sd) Female,% RoadUserType CyclingExperience Equipment
Fromasecondaryschoolnear
1, theSWOVInstituteforRoad Onaverageabout6.5hof Amobileeye-trackingheadsetata
|                               | 17.1(0.5) | 50  | Cyclist |                |            |
| ----------------------------- | --------- | --- | ------- | -------------- | ---------- |
| [9] SafetyResearchinTheHague, |           |     |         | cyclingperweek | rateof30Hz |
Netherlands.
1.Forcyclistsonly:twoaction
camerasequippedwithGPS
2.Fordriversonly:adatalogger
2, Aweb-basedquestionnaire, Cycledanddroveat thatrecordsspeed,position,andthe
|     | 39(14) | 52  | Cyclistanddriver |     |     |
| --- | ------ | --- | ---------------- | --- | --- |
[16] distributedviaFacebook. leastsometimes forward,rearward,right-side,and
driverviews
3.Forcyclistsanddrivers:a
head-mountedeyetracker
3, Fromthecommunityofthe 46%cycleeverydayand Amobileeye-trackingsystemwith
|     | 25(7) | 3   | Cyclist |     |     |
| --- | ----- | --- | ------- | --- | --- |
[17] urbancenterofBologna. 3inexperiencedcyclists glassesatarateof30Hz
| 4,                          |     |     |         | Havesome,butnotmuch, | Amobileeye-trackingsystemwith |
| --------------------------- | --- | --- | ------- | -------------------- | ----------------------------- |
| Parentsofchildrenofaschool. | N/A | N/A | Cyclist |                      |                               |
| [19]                        |     |     |         | cyclingexperience    | glassesatarateof30Hz          |
1.Instrumentedbicycle:IMU,GPS,
1.Emailssenttouniversity andothersensors
Formales:30.9(15.9)yearsof
5, studentsandstaff. Male:37.9(13.4) 2.Mobileeye-trackerglassesata
|     |     | 36  | Cyclist | averagecyclingexperience |     |
| --- | --- | --- | ------- | ------------------------ | --- |
[10] 2.PostsonStockholm’ssocial Female:32.4(14.1) rateof50or100Hz,anda
Forfemales:26(15.8)years
mediagroups. microphonetorecord
ambientsounds
Studentrecruitmentviathe Experienced 1.Mobileeye-trackingsystem
6,
announcementboardofa 26.6(7.46) 50 Cyclist cyclists:meanhours: glassesatarateof60Hz
[11]
| researchcenter. |     |     |     | 5.44(1.04) | 2.LiDARscanning |
| --------------- | --- | --- | --- | ---------- | --------------- |
1.Theinstrumentedvehicle“2014
1.Universityemaillists,
ToyotaRAV4vehicle”,equipped
public.
withtwodashboardcameras—one
| 7, 2.Onlineplatforms.         |         |     |        | 13cyclistsand  |                          |
| ----------------------------- | ------- | --- | ------ | -------------- | ------------------------ |
|                               | 42(4.5) | 50  | Driver |                | facingtheroadandtheother |
| [18] 3.Flyersdistributedinthe |         |     |        | 13non-cyclists |                          |
towardsthedriver’sseat
vicinityoftheuniversity
2.Head-mountedeye-tracking
campus.
glassesatarateof60Hz

Sensors2025,25,22
34of53
TableA2.Cont.
ID,Ref. SourceofParticipants MeanAge(sd) Female,% RoadUserType CyclingExperience Equipment
1.Universityemaillists,
public. 1.Theinstrumentedvehicle“2014
| 8, 2.Onlineplatforms. |         |     |        | 13cyclistsand | ToyotaRAV4vehicle” |
| --------------------- | ------- | --- | ------ | ------------- | ------------------ |
|                       | 42(4.5) | 50  | Driver |               |                    |
[12] 3.Flyersdistributedinthe 13non-cyclists 2.Head-mountedeye-tracking
vicinityoftheuniversity glassesatarateof60Hz
campus.
Themajority
9, FromthewebsiteofSeoul cycledonceamonthorseveral 1.Mobileeye-trackerglassesata
|                          | 24  | 50  | Cyclist |                          |            |
| ------------------------ | --- | --- | ------- | ------------------------ | ---------- |
| [13] NationalUniversity. |     |     |         | timesayearforexerciseand | rateof50Hz |
leisure
Dividednearlyequally
| 10,                 |     |     |         |                       | Amobileeye-trackingsystemwith |
| ------------------- | --- | --- | ------- | --------------------- | ----------------------------- |
| Universitystudents. | 25  | 23  | Cyclist | betweenexperiencedand |                               |
| [14]                |     |     |         |                       | glassesatarateof30Hz          |
inexperiencedcyclists
Frequentusers
| 11, StudentsatPolitechnika | Formales:22.7(1.3)   |     | Pedestrian,cyclist,and |                           |                               |
| -------------------------- | -------------------- | --- | ---------------------- | ------------------------- | ----------------------------- |
|                            |                      | 41  |                        | ofbothbicyclesandelectric | Mobileeyetrackeratarateof25Hz |
| [15] Krakowska.            | Forfemales:22.6(3.3) |     | electricscooterrider   |                           |                               |
scooters(ESs)
1.Bicyclesimulatorwithacyclist
Forthe
1.Fromuniversityemail warningsystem(CWS)developed
|                             | Fortheyoungergroup:   | younger     |         |                      |                           |
| --------------------------- | --------------------- | ----------- | ------- | -------------------- | ------------------------- |
| 12, distributors.           |                       |             |         |                      | byFraunhoferIVI(atarateof |
|                             | 25.5                  | group:63%   | Cyclist | Experienced(regular) |                           |
| [20] 2.Contactsintheprivate |                       |             |         |                      | 10Hz)                     |
|                             | Fortheoldergroup:65.8 | Fortheolder |         |                      |                           |
network. 2.Eye-trackingglassesatarateof
group:29%
60Hz
1.Bicyclingsimulator
2.Galvanicskinresponse
| Notexplicitlymentioned;the |                   |     |     | Morethanhalfofthe | (GSR)sensor |
| -------------------------- | ----------------- | --- | --- | ----------------- | ----------- |
| 13,                        | Male:36.45(15.57) |     |     |                   |             |
majorityofparticipantswere 0.5 Cyclist participantswere 3.Mobileeyetrackeratarateof
| [23]                | Female:29.84(7.48) |     |     |                     |      |
| ------------------- | ------------------ | --- | --- | ------------------- | ---- |
| universitystudents. |                    |     |     | experiencedcyclists | 30Hz |
4.Acameratocapturethe
participants’runs
Bypostinganddistributing
1.Full-scalebicyclingsimulator
| 14, flyersacrosstheOSUcampus | Male:29.44(13.07)   |      |         |              |                             |
| ---------------------------- | ------------------- | ---- | ------- | ------------ | --------------------------- |
|                              |                     | 0.57 | Cyclist | Notmentioned | 2.Mobileeyetrackeratarateof |
| [24] andthecityofCorvallis,  | Female:28.52(11.93) |      |         |              |                             |
30Hz
Oregon.

Sensors2025,25,22
35of53
TableA2.Cont.
ID,Ref. SourceofParticipants MeanAge(sd) Female,% RoadUserType CyclingExperience Equipment
Fromthelocalcommunities 1.High-fidelitydrivingsimulator
15,
neighboringCorvallis, 38 36 Driver Notmentioned 2.Mobileeyetrackeratarateof
[25]
Oregon. 30Hz
1.High-fidelitydrivingsimulator
2.Physiologicalsensor
| 16, |     |     |     | Drivingexperienceofatleast |     |
| --- | --- | --- | --- | -------------------------- | --- |
Fromauniversitycampus. 26.7(9.9) 0.63 Driver 3.Eye-trackingcameraatarateof
| [26] |     |     |     | 1.5years |     |
| ---- | --- | --- | --- | -------- | --- |
60Hz
4.GSRsensor
| 17,                     |            |        |        | Notexplicitlymentioned;they | 1.Immersivedrivingsimulator |
| ----------------------- | ---------- | ------ | ------ | --------------------------- | --------------------------- |
| Notexplicitlymentioned. | 40.3(17.2) | 0.0645 | Driver |                             |                             |
| [29]                    |            |        |        | haveadrivinglicense         | 2.Eye-trackingsystems       |
*Halfofthe
|     | Study1:24(6.8)for   |     |     | participants    |     |
| --- | ------------------- | --- | --- | --------------- | --- |
|     | pedalcyclists,and22 |     |     | cyclefrequently |     |
Notexplicitlymentioned; (2.1)fornon-pedal *Drivinglicensedated
Study1:
18, selectedbasedontheir cyclists between 1.High-fidelitydrivingsimulator
|     |     | 57.5% | Driver |     |     |
| --- | --- | ----- | ------ | --- | --- |
[30] frequencyofpedal Study2:25(7.3)for aminimumof 2.Eye-trackingsystems
Study2:60%
| cyclingusage. | pedalcyclists,and22 |     |     | 1monthandamaximumof     |     |
| ------------- | ------------------- | --- | --- | ----------------------- | --- |
|               | (7.3)fornon-pedal   |     |     | 263months               |     |
|               | cyclists            |     |     | *Annualmileagebetween50 |     |
and10,000mile
1.Flyersdistributedacross
Corvallis,Oregon. 1.Full-scalebicyclingsimulator
| 19, |     |     |     | Drivingexperienceofatleast |     |
| --- | --- | --- | --- | -------------------------- | --- |
2.Emailssenttovarious 30.7(15.11) 0.465 Driver 2.Mobileeyetrackeratarateof
| [27] |     |     |     | 1year |     |
| ---- | --- | --- | --- | ----- | --- |
campusgroupsand 30Hz
mailinglists.
1.High-fidelitymotion-based
simulator
| 20, Fromtheareaneighboring |       |        |        | Drivingexperienceofatleast |     |
| -------------------------- | ----- | ------ | ------ | -------------------------- | --- |
|                            | 30.24 | 0.4117 | Driver |                            |     |
| [28] Corvallis,Oregon.     |       |        |        | 1year                      |     |
2.Head-mountedeyetrackerata
rateof30Hz

Sensors2025,25,22
36of53
TableA2.Cont.
ID,Ref. SourceofParticipants MeanAge(sd) Female,% RoadUserType CyclingExperience Equipment
1.VRheadsetwitheyetracking
2.Smartwatchthathasthe
“SWEAR”appinstalled
| 21, Fromthelocalcommunity:       |         | Not       | Cyclistand |                      |                  |
| -------------------------------- | ------- | --------- | ---------- | -------------------- | ---------------- |
|                                  | 31(3.4) |           |            | Experiencedincycling | 3.Stationarybike |
| [22] residentsinCharlottesville. |         | mentioned | pedestrian |                      |                  |
4.Bicyclesimulator
5.Treadmill
6.Cameras
1.Instrumentedbicycle
| 22, Fromthreeschools |             |        |         | Justbeabletorideabike;no | 2.VRheadset |
| -------------------- | ----------- | ------ | ------- | ------------------------ | ----------- |
|                      | 11.37(0.54) | 0.7077 | Cyclist |                          |             |
[21] thatvolunteered. additionalcriteria 3.Eye-trackingglassesatarateof
120Hz
1.CHP-VRsimulator:stationary
bicycle
23, Volunteering,withnomention Experienced:onaverage, 2.HeadsettodeveloptheVR
|                   | 33.7(8.5) | 0   | Cyclist |                          |               |
| ----------------- | --------- | --- | ------- | ------------------------ | ------------- |
| [31] ofthesource. |           |     |         | 3.8±2.9hofcyclingperweek | 3.Speedsensor |
4.Inrealtrafficenvironment:
eye-trackingglasses
Formales:30.9(15.9)yearsof
experience
1.Socialmedianetworks. Fortheon-sitetest:35.15 Forfemales:26(15.8)yearsof 1.Mobileeyetracker
| 24, 2.Posterswithinthe | (13.7) |     |         | experience | 2.Bicyclesimulator |
| ---------------------- | ------ | --- | ------- | ---------- | ------------------ |
|                        |        | 45  | Cyclist |            |                    |
[32] universitieswherethetests Forthesimulated *Noprevious 3.TheNASATaskLoadIndex
wereconducted. experiment:27.47(4.5) experience (NASA-TLX)questionnaire
withbicycle
simulator
Notexplicitlymentioned
|     |     |     |     | Variedbetweencycling | 1.Head-mountedeyetrackerata |
| --- | --- | --- | --- | -------------------- | --------------------------- |
(wereinvolvedinaprior
| 25,                        |             |     |         | frequently(manytimes)per | rateof60Hz    |
| -------------------------- | ----------- | --- | ------- | ------------------------ | ------------- |
| studyexaminingvisualsearch | 26.31(7.31) | 26  | Cyclist |                          |               |
| [33]                       |             |     |         | weekandlessoftenthanonce | 2.Scenecamera |
behaviorswhilecycling
|     |     |     |     | perweek | 3.Simulator |
| --- | --- | --- | --- | ------- | ----------- |
onroad).

Sensors2025,25,22
37of53
TableA3.Methodologicalcharacteristics—part1.
|     |     |     |     | DataCollection | Experiment |     |
| --- | --- | --- | --- | -------------- | ---------- | --- |
ID,Ref. DrivingScenarios Environment StudyDesign SamplingStrategy Variables
|     |     |     |     | Method | Duration |     |
| --- | --- | --- | --- | ------ | -------- | --- |
1.Numberofglances
1, Daylight Observational Purposive Realtraffic 2.Glanceduration
Intersections Average:13min
[9] anddryweather (naturalistic) sampling environment 3.Glancepercentagetointersectingroads
totheright
1.Attentionalrequirement
2.Visualbehavior
2, Intersections Inautumn:cloudy Purposive Realtraffic 3.Informationsamplingstrategies(looking
|      |         | Cross-sectional |          |             | Notmentioned |                         |
| ---- | ------- | --------------- | -------- | ----------- | ------------ | ----------------------- |
| [16] | weather |                 | sampling | environment |              | forward,left,down,etc.) |
4.Complexitylevelsofintersections
5.Gazebehaviorofcyclistsanddrivers
1.Cyclistgazebehavior
|               | Inautumn         |                |           |             |              | 2.Visualelementsintheurban   |
| ------------- | ---------------- | -------------- | --------- | ----------- | ------------ | ---------------------------- |
| 3,            |                  | Observational  | Purposive | Realtraffic |              |                              |
| Intersections | andspring:cloudy |                |           |             | Notmentioned | environment                  |
| [17]          |                  | (naturalistic) | sampling  | environment |              |                              |
|               | weather          |                |           |             |              | 3.Cyclingpathcharacteristics |
4.Participantdemographics
1.Independentvariablesrelatedtothe
signagestrategy:typeofsignage,location
Clearweather
| 4,            |                     | Quasi- | Purposive | Realtraffic |            | ofsigns |
| ------------- | ------------------- | ------ | --------- | ----------- | ---------- | ------- |
| Intersections | (createschallenging |        |           |             | About20min |         |
[19] experimental sampling environment 2.Dependentvariables:cyclists’route
conditions)
choices,gazebehavior,andinteractionwith
roadusersandsignage
1.Roadsurfacecharacteristics
2.Geometricdesignoftheinfrastructure
Coldweatherwith
5, Observational Convenience Realtraffic 3.Cyclingspeed,power,andcadence
| Urbanroute | snow-covered |     |     |     | Notmentioned |     |
| ---------- | ------------ | --- | --- | --- | ------------ | --- |
[10] (naturalistic) sampling environment 4.Cyclists’behavior,perceptionofsafety
surfaces
andcomfort,andparticipants’
demographicinformation
1.Subjectiveriskperception
2.Vistaspaceproperties(openness,drift,
Mixedmethod:
andmeanradiallength)
| 6,            | Goodweather | Observational  | convenienceand | Realtraffic |              |                                   |
| ------------- | ----------- | -------------- | -------------- | ----------- | ------------ | --------------------------------- |
| Intersections |             |                |                |             | Aboutonehour | 3.Individualfactors(suchascycling |
| [11]          | conditions  | (naturalistic) | purposive      | environment |              |                                   |
experience)
sampling
4.Gazebehaviorparameters(fixation
duration,sightvectorlengths,gazeangles)

Sensors2025,25,22
38of53
TableA3.Cont.
|     |     |     |     | DataCollection | Experiment |     |
| --- | --- | --- | --- | -------------- | ---------- | --- |
ID,Ref. DrivingScenarios Environment StudyDesign SamplingStrategy Variables
|     |     |     |     | Method | Duration |     |
| --- | --- | --- | --- | ------ | -------- | --- |
1.Cyclingexperience(cyclistdriversvs.
non-cyclistdrivers)
2.Demographicvariables(gender,age,
Mixed-methods
yearsoffulllicensure)
|                | Goodweather       | design:       |           |             |               |                    |
| -------------- | ----------------- | ------------- | --------- | ----------- | ------------- | ------------------ |
| 7, Urbanroute, |                   |               | Purposive | Realtraffic |               | 3.Drivingfrequency |
|                | conditionsbetween | quantitative– |           |             | Average:14min |                    |
[18] intersections sampling environment 4.Presenceoffamilymemberswhoride
|     | AprilandMay | qualitative |     |     |     |     |
| --- | ----------- | ----------- | --- | --- | --- | --- |
bicyclesfrequently
5.Eyegazemetrics:gazedirectionaccuracy,
pupiltrackingaccuracy,andvisualangle
accuracy
1.DriverCharacteristics(suchascycling
|     | Goodweather |     |     |     |     | experience) |
| --- | ----------- | --- | --- | --- | --- | ----------- |
8, conditions Observational Purposive Realtraffic Not 2.Signalstatus(greenorred)
Intersections
[12] betweenApril (naturalistic) sampling environment mentioned 3.Areasofrelevanceforvulnerable
|     | andMay |     |     |     |     | roadusers |
| --- | ------ | --- | --- | --- | --- | --------- |
4.Drivergazebehaviors
1.Urbancharacteristics:
- Raisedcycletrack
- Physicalseparation
Sunnydays
- Landuse
| 9,         | betweenAugust | Observational  | Purposive | Realtraffic |            |                         |
| ---------- | ------------- | -------------- | --------- | ----------- | ---------- | ----------------------- |
| Urbanroute |               |                |           |             | About50min | - Numberofpedestrians   |
| [13]       | and           | (naturalistic) | sampling  | environment |            |                         |
|            | September     |                |           |             |            | 2.Cyclists’gazebehavior |
- Gazeallocation
- Gazedispersion
1.Cyclists’experiencelevel
2.Eyegazebehavior:
- Fixationduration
10, Observational Purposive Realtraffic Not - Numberoffixations
Intersections Cloudyweather
[14] (naturalistic) sampling environment mentioned - Firstfixationdistance
3.Intersectiondesigncharacteristics
4.Physiologicalresponses,suchascortisol
activity

Sensors2025,25,22
39of53
TableA3.Cont.
|     |     |     |     | DataCollection | Experiment |     |
| --- | --- | --- | --- | -------------- | ---------- | --- |
ID,Ref. DrivingScenarios Environment StudyDesign SamplingStrategy Variables
|     |     |     |     | Method | Duration |     |
| --- | --- | --- | --- | ------ | -------- | --- |
1.Modeoftransport(pedestrians,cyclists,
electricscooterriders)
|            | Dryweather(late |                |           |             |         | 2.Fixationzones(horizon,sides,roadway, |
| ---------- | --------------- | -------------- | --------- | ----------- | ------- | -------------------------------------- |
| 11,        |                 | Observational  | Purposive | Realtraffic |         |                                        |
| Urbanroute | summer,early    |                |           |             | About2h | pedestrian,transportvehicle)           |
| [15]       |                 | (naturalistic) | sampling  | environment |         |                                        |
|            | autumn)         |                |           |             |         | 3.Fixationdistances                    |
4.Speeds
5.Trafficruleviolations
Cyclist–driver
|                  |              |              |             | Virtualtraffic    |           | 1.Systemusage(WITHvs.WITHOUT        |
| ---------------- | ------------ | ------------ | ----------- | ----------------- | --------- | ----------------------------------- |
| 12, interaction  |              |              | Convenience |                   | Not       |                                     |
|                  | Notavailable | Experimental |             | environmentusing  |           | CWS)                                |
| [20] scenariosat |              |              | sampling    |                   | mentioned |                                     |
|                  |              |              |             | abicyclesimulator |           | 2.Agegroup(youngervs.oldercyclists) |
intersections
1.Loadingzonesize
| Cyclist–driver |     |     | Mixedmethod: |     |     | 2.Courierposition |
| -------------- | --- | --- | ------------ | --- | --- | ----------------- |
Virtualtraffic
| 13, interaction         |              |              | convenienceand |                  |               | 3.Presenceofaccessories   |
| ----------------------- | ------------ | ------------ | -------------- | ---------------- | ------------- | ------------------------- |
|                         | Notavailable | Experimental |                | environmentusing | Average:15min |                           |
| [23] scenariosatvehicle |              |              | purposive      |                  |               | 4.Participantdemographics |
abicyclesimulator
| loadingzones |     |     | sampling |     |     | 5.Numberoffixations |
| ------------ | --- | --- | -------- | --- | --- | ------------------- |
6.Fixationduration
1.Coloredpavementmarkings
2.Truckmaneuvering
| Cyclist–truck |     |     |             | Virtualtraffic |     | 3.Cyclists’gender |
| ------------- | --- | --- | ----------- | -------------- | --- | ----------------- |
| 14,           |     |     | Convenience |                | Not |                   |
driverinteraction Notavailable Experimental environmentusing 3.Totalfixationdurationonpavement
| [24]      |     |     | sampling |                   | mentioned |                  |
| --------- | --- | --- | -------- | ----------------- | --------- | ---------------- |
| scenarios |     |     |          | abicyclesimulator |           | markings(TFD-PM) |
4.Totalfixationdurationonthetruck
(TFD-Truck)

Sensors2025,25,22 40of53
TableA3.Cont.
DataCollection Experiment
ID,Ref. DrivingScenarios Environment StudyDesign SamplingStrategy Variables
Method Duration
1.Engineeringtreatments:
- Regulatorysignage
Cyclist–driver
- Intersectionpavementmarking
interaction
- Smallercurbradius
scenariosat
- Protectedintersectiondesign
intersectionswith
Virtualtraffic 2.Driverperformancemeasures:
15, different Convenience Not
Notavailable Experimental environmentusing
[25] engineering sampling mentioned - Fixationdurationonareasofinterest
adrivingsimulator
treatments (AOI)
(markings,signs, - Timetocollision(TTC)valuesatthe
curb timeofnear-collisionsorcollisions
radius) - Motorist’svelocityatthetimeof
near-collisionorcollision
1.Driverperformancedata:
- Steeringwheelposition
- Acceleratorpedalposition
- Brakepedalposition
- Velocity
- Timetolanecrossing
- Timeheadwaytoanupstreamobject
- Laneposition
16, Cyclist–driver Convenience Virtualtraffic 2.Physiologicaldata(atbaselineandwhen
[26] interaction Notavailable Experimental sampling environmentusing Onehour visuallyencounteringacyclist):
scenarios adrivingsimulator
- Heartrate
- Breathingrate
- EDA(electrodermalactivity)
3.Eyemovementdata:
- Saccades
- Fixationsdurations
4.Self-reportedmeasuresfrom
questionnaires

Sensors2025,25,22
41of53
TableA3.Cont.
|     |     |     | DataCollection | Experiment |     |
| --- | --- | --- | -------------- | ---------- | --- |
ID,Ref. DrivingScenarios Environment StudyDesign SamplingStrategy Variables
|     |     |     | Method | Duration |     |
| --- | --- | --- | ------ | -------- | --- |
1.Carandcyclistvelocities
2.Distancesfromthecarandcyclisttothe
| Cyclist–driver |     |             | Virtualtraffic |     | pointofintersection |
| -------------- | --- | ----------- | -------------- | --- | ------------------- |
| 17,            |     | Convenience |                | Not |                     |
interaction Notavailable Experimental environmentusing 3.Timetocollision(TTC)
| [29]      |     | sampling |                   | mentioned |                            |
| --------- | --- | -------- | ----------------- | --------- | -------------------------- |
| scenarios |     |          | adrivingsimulator |           | 4.Brakingreactiontime(BRT) |
5.Timewhenthecyclistisvisible
6.Gazebehavior
1.RoadSign:“GiveWay”and“Stop”
2.Group:pedalcyclistsvs.non-pedal
cyclists,
|     | Mixed-methods |     |     |     | 3.Drivers’license |
| --- | ------------- | --- | --- | --- | ----------------- |
design:
Cyclist–driver 4.Annualmileage
Virtualtraffic
| 18, interaction | - Experimental | Purposive |     | Not | 5.Agerange |
| --------------- | -------------- | --------- | --- | --- | ---------- |
Notavailable environmentusing
[30] scenariosat - sampling mentioned 6.Vehicletype:pedalcycle,motorcycle,
adrivingsimulator
| T-junction | Observational |     |     |     | andcar |
| ---------- | ------------- | --- | --- | --- | ------ |
7.Distancetooncomingvehiclesat
junctions(near,medium,andfar)
8.Proportionoffixations
9.Meanfixationduration
1.Relativebicycleposition
2.Secondarytaskengagement
3.Driver’sspeed
Mixedmethod:
| Right-turn |     |                | Virtualtraffic |     | 4.Tracklength |
| ---------- | --- | -------------- | -------------- | --- | ------------- |
| 19,        |     | convenienceand |                |     |               |
maneuvers Notavailable Experimental environmentusing 30min 5.Driverperformancemeasures:
| [27] |     | purposive |     |     |     |
| ---- | --- | --------- | --- | --- | --- |
scenarios adrivingsimulator
|     |     | sampling |     |     | - Timetocollision |
| --- | --- | -------- | --- | --- | ----------------- |
- Thedriver’syieldingbehavior
- Fixationdata

Sensors2025,25,22
42of53
TableA3.Cont.
|     |     |     |     | DataCollection | Experiment |     |
| --- | --- | --- | --- | -------------- | ---------- | --- |
ID,Ref. DrivingScenarios Environment StudyDesign SamplingStrategy Variables
|     |     |     |     | Method | Duration |     |
| --- | --- | --- | --- | ------ | -------- | --- |
1.Therelativepositionsandspeedsof
adjacentcyclists
2.Thepresenceofoncomingleft-turning
vehiculartraffic
3.Thepresenceofconflictingpedestrians
|     |     |     | Mixedmethod: | Virtualtraffic |     |     |
| --- | --- | --- | ------------ | -------------- | --- | --- |
Right-turn 4.Eyemovementdata:
| 20,       |              |              | convenienceand | environmentusing |            |                     |
| --------- | ------------ | ------------ | -------------- | ---------------- | ---------- | ------------------- |
| maneuvers | Notavailable | Experimental |                |                  | About50min |                     |
| [28]      |              |              | purposive      | adriving         |            | - Numberoffixations |
scenarios
|     |     |     | sampling | simulator |     | - Totalfixationdurations |
| --- | --- | --- | -------- | --------- | --- | ------------------------ |
- Averagefixationdurations
- Timeofthefirstfixationwithineach
AOI
1.Heartrate
2.Handacceleration
3.Fixations
4.Horizontalgazedirection
| 21, Scenariosin |     |     | Convenience | Virtualtraffic | Not |     |
| --------------- | --- | --- | ----------- | -------------- | --- | --- |
Notavailable Experimental 5.GazeEntropy:StationaryGazeEntropy
| [22] urbanroute |     |     | sampling | environment(VR) | mentioned |     |
| --------------- | --- | --- | -------- | --------------- | --------- | --- |
(SGE)and
GazeTransitionEntropy(GTE)
6.Pupildiameter
7.Horizontalheadmovementdirection

Sensors2025,25,22
43of53
TableA3.Cont.
|     |     |     |     | DataCollection | Experiment |     |
| --- | --- | --- | --- | -------------- | ---------- | --- |
ID,Ref. DrivingScenarios Environment StudyDesign SamplingStrategy Variables
|     |     |     |     | Method | Duration |     |
| --- | --- | --- | --- | ------ | -------- | --- |
1.Gazebehavior:
- Fixationrate(whethertheparticipant
fixatedontheareaofinterestduring
theevent)
- Entrytimeofthefirstfixation(time
betweentheonsetoftheeventandthe
firstfixationontheareaofinterest)
- Dwelltimeontheareaofinterest
(durationoffixationontheareaof
Mixedmethod:
interest)
| 22, Hazardsscenarios  |              |              | convenienceand | Virtualtraffic  | Not       |                    |
| --------------------- | ------------ | ------------ | -------------- | --------------- | --------- | ------------------ |
|                       | Notavailable | Experimental |                |                 |           | 2.Cyclingbehavior: |
| [21] foryoungcyclists |              |              | purposive      | environment(VR) | mentioned |                    |
- Speed(meanspeedoftheparticipant
sampling
duringtheevent)
- Brakingrate(binarycodeindicating
whetherthecyclistbrakedforthe
presenteddangerwithinthe
timeframe)
3.Hazarddetection
4.Hazardanticipation
5.Simulatorsickness
6.Realismperception
1.Gazelocation:
- Fixation
Virtualtraffic
|            |            |              | Convenience |                 |           | - Blinks   |
| ---------- | ---------- | ------------ | ----------- | --------------- | --------- | ---------- |
| 23,        | Dryweather |              |             | environment     | Not       |            |
| Urbanroute |            | Experimental | sampling    |                 |           | - Saccades |
| [31]       | conditions |              |             | (virtualreality | mentioned |            |
(opportunistic)
|     |     |     |     | (VR)) |     | 2.Participantcharacteristics(suchas |
| --- | --- | --- | --- | ----- | --- | ----------------------------------- |
cyclingexperience)
3.Reactiontimestohazards

Sensors2025,25,22 44of53
TableA3.Cont.
DataCollection Experiment
ID,Ref. DrivingScenarios Environment StudyDesign SamplingStrategy Variables
Method Duration
1.Visualattention
2.Workload
3.Fixationduration
24, Dryweather Purposive
Urbanroute Experimental Comparative Notmentioned 4.Attentiondistribution
[32] conditions sampling
5.Cyclingexperience
6.Familiaritywiththeroute
7.Subjectiveperception
1.Gazebehaviormetrics:
- Numberoffixations
- Fixationduration
- Gazefrequency
25, Dryweather Convenience
Urbanroute Experimental Comparative Notmentioned - Gazedensity
[33] conditions sampling
- Fixationcountsonareasofinterest
(AOI)
2.Areasofinterest(AOI)
3.Eyemovementpatterns
TableA4.Methodologicalcharacteristics—part2.
ID,Ref. OutcomesMeasured StudyID OutcomesMeasured
Theeffectsofpavementmarkings,truckmaneuvering,and
1, 14,
Visualattention genderoncyclists’visualattentionduringconflictswith
[9] [24]
trucktraffic
1.Differencesinattentionalrequirementsbetween
driversandcyclists
2.Fulfillmentofattentionalrequirements(ifthe Changesindriverperformanceduringright-turnmaneuvers
demandwashighorlow) atsignalizedintersections:
2, 15,
3.Fulfillmentofinformationsamplingstrategies 1.Visualattentionofmotorists
[16] [25]
(effortandtimingneeded) 2.Crashavoidancebehavior
4.Difficultyoffulfillingtheserequirementsforboth 3.Potentialcrashseverity
roadusergroups
5.Glancefrequencyperdirectionandtargettype

Sensors2025,25,22
45of53
TableA4.Cont.
| ID,Ref. |     | OutcomesMeasured | StudyID |     | OutcomesMeasured |
| ------- | --- | ---------------- | ------- | --- | ---------------- |
1.Timetofixateonthecyclistonthefirstovertakeinteraction
1.Proportionoffixation 2.Peakresponseanddifferencesinvaluesofphysiological
|     | 2.Numberanddurationoffixations |     |     | datawhenencounteringacyclist |     |
| --- | ------------------------------ | --- | --- | ---------------------------- | --- |
| 3,  |                                |     | 16, |                              |     |
3.Relativefrequencyoffixationondifferent 3.Relationshipbetweentheself-reportedresponses,
| [17] |          |     | [26] |                                                   |     |
| ---- | -------- | --- | ---- | ------------------------------------------------- | --- |
|      | elements |     |      | physiologicalandeye-trackingmeasures,andsimulator |     |
4.Cyclists’visualworkload behaviorsusingacorrelationmatrix:attentionalbiasto
cyclists,arousalduetoencounteringacyclist
1.Numberofcollisionsandavoidances
1.Impactofthesignagestrategyoncyclists’route 2.Behaviorchangestoavoidcollisions
|     | choices |     |     | 3.Comparethevaluesofspeed,BRT,andTTCbetweenthe |     |
| --- | ------- | --- | --- | ---------------------------------------------- | --- |
4, 2.Glancedurationatroaditems 17, collisiongroupandthecollisionavoidedgroup
| [19] | 3.Attentiontoroadusersandsignage |     | [29] | 4.Gazelocation |     |
| ---- | -------------------------------- | --- | ---- | -------------- | --- |
4.Overallnavigationalexperienceinurban 5.Brakingandswervingresponsesofparticipants
|     | environments |     |     | 6.Noticetime |     |
| --- | ------------ | --- | --- | ------------ | --- |
7.Gazeangle
1.Visualattentionmeasuresofdriverstowardsvulnerable
|     | 1.Perceptionofsafetyandcomfort |     |     | roadusersatjunctions |     |
| --- | ------------------------------ | --- | --- | -------------------- | --- |
5, 2.Powerandcadenceduringcycling 18, 2.Differencesinvisualsearchbehaviorbasedonpedal
[10] 3.Visualattentionusingtheeyetracker [30] cyclingexperience
4.Subjectiveevaluationsofthecyclingexperience 3.Comparisonofdrivers’behaviorwhenpullingoutor
waitingatjunctions
1.Collisionavoidancebehavior:
|     | 1.Travelingspeed |     |     | - Driver’syieldingbehavior |     |
| --- | ---------------- | --- | --- | -------------------------- | --- |
2.Subjectiveriskperception - Timetocollision(TTC)withacyclist
| 6,   |                    |     | 19,  |                    |     |
| ---- | ------------------ | --- | ---- | ------------------ | --- |
|      | 3.Fixationduration |     |      | 2.Visualattention: |     |
| [11] |                    |     | [27] |                    |     |
4.Sightvectorlengths
- Driver’stotalfixationduration(TFD)onthecyclist
5.Gazeangles
- Driver’sfirstfixationonthecyclistintheroadway

Sensors2025,25,22 46of53
TableA4.Cont.
ID,Ref. OutcomesMeasured StudyID OutcomesMeasured
1.Gazelocations:toidentifypatternsofvisual
attentionallocationandpotentialscanningfailures
towardsVRUs
7, 2.Numberofturns,categorizedasinstancesof 20, 1.Driver’svisualattention
[18] visualscanningfailureacrosseachcombinationof [28] 2.Riskofaright-hookcrash
cyclingexperienceandcrashhistory
3.Numberofturns,identifiedasinstancesofvisual
scanningfailureacrossvarioustypesofturns
1.Driverglancepatterns(temporalglance
distributions,percentageoftimelookingat
1.Changesinheartrate
differentAOIs,percentageoftimelookingby
2.Gazebehavior
8, cyclingexperience) 21,
3.Visualscanningpatterns
[12] 2.Attentionallocationtopedestriansandcyclists [22]
4.Stresslevelsofparticipantsinresponsetodifferent
3.Potentialrisksposedtovulnerableroadusers
roadwaysettingsandeventsintheIVE
(glanceallocationtovisualscanningfailurerelated
toAOIs)
1.Distributionofcyclists’gazefixations 1.Performanceinhazarddetectiontasks
2.Fixationdurationpercentagebasedondifferent 2.Performanceinhazardanticipationtasks
9, 22,
roadfactors 3.Simulatorsicknessscores
[13] [21]
3.Impactofurbancharacteristicsoncyclists’gaze 4.Realismperceptionscores
patterns 5.Gazebehaviormetrics
1.Patternsofgazebehavior 1.Gazebehavior
2.Differencesinvisualattentionbetween 2.Perception–actioncouplinginVRandnaturalistic
10, 23,
experiencedandinexperiencedcyclists environments
[14] [31]
3.Impactofintersectiondesignoncyclists’visual 3.ThecomparabilityofvisualsearchbehaviorinVRand
behavioranddecisionmaking real-worldcyclingscenarios
1.Variationsinvisualattentionbetweensimulatedandreal
1.Numberoffixations
scenarios
2.Fixationdurations
2.Differencesinattentiondistribution
11, 3.DistributionofFixationsindifferentzones 24,
3.Fixationduration
[15] 4.Speedsofparticipants [32]
3.Subjectiveperceptionofmentalandphysicalworkload
5.Interactionswithotherroadusers
4.Leveloffrustration
6.Trafficruleviolations
5.Cognitiveandphysicalworkload

Sensors2025,25,22 47of53
TableA4.Cont.
ID,Ref. OutcomesMeasured StudyID OutcomesMeasured
1.Brakingbehavior:brakingreactiontime 1.Differencesinfixationsandvisitsbetweenthefieldand
2.Gazebehavior simulationsettings
2.Variationinaveragevisitdurationbetweenthefieldand
- Gazereactiontime
12, 25, simulationstudies
- Fixationduration
[20] [33] 3.Comparisonofgazedistributionbetweenthefieldand
- Fixationnumber
simulationsettings
3.Mentalworkload 4.Comparisonoffixationdurationspersecondbetweenthe
4.Perceivedsafety fieldandsimulationsettings
1.Post-surveyresults
13, 2.GSRreadingsandvisualattentionperformance
[23] ofcyclistsastheynavigatecommercialvehicle
loadingzones
TableA5.Studies’results.
ID,Ref. Results StudyID Results
- Truckmaneuvershadthemostsignificanteffectoncyclists’
visualattention,anddashedgreenbikelanesweremore
1, 14, effectiveatattractingvisualattentionthanotherpavement
[9] Cyclists’visualbehaviorwasnotaffectedbylisteningtomusic. [24] markingdesigns.
- Menfixatedmoreonpavementmarkingsthanwomen,
regardlessoftruckmaneuverorpavementmarkingtype.
- Mostofthedifferencesinmotoristperformancemeasureswere
notstatisticallysignificant.
- Thelevel-onesignagetreatment,specificallythe“Turning
2, Therearedifferencesinattentionalrequirementsandinformation 15, VehiclesYieldtoBicycles”symbolsign,positivelyinfluenced
[16] samplingstrategiesbetweencyclistsanddrivers. [25] driverbehaviorwithrespecttovisualattention.
- Theprotectedintersectiondesignshowedsomeimprovements
indriverperformancewithrespecttopotentialcrashseverity,
asmeasuredbyvehiclespeedsinnearandactualcollisions.

Sensors2025,25,22 48of53
TableA5.Cont.
ID,Ref. Results StudyID Results
- Encounteringacyclistcanevokenegativearousalindrivers:
- Optimalcyclingconditionsarewhencyclistskeepthebalance anincreaseinpeakheartrateandelectrodermalactivity
ofattentiondistributionbetweenthecentral(trajectory)and (EDA).
peripheralregionsofthevisualfield;itisreducedwhen - Greaterattentiontocyclistsisassociatedwithsaferdriving:
3, pedestriandensityincreases. 16, evidencedisbasedoncorrelationsbetweeneyemovement
[17] - Moreattentionwaspaidtointersectionsandcrosswalks,but [26] measuresanddrivingperformance.
thenon-physicalseparationbetweencyclistsandpedestrians - Attentionandphysiologicalarousalcanseparatelyinfluence
resultedinalackofattentiontopresentedrisks. drivingbehavior:nosignificantcorrelationsbetween
physiologicalarousalandattentiontothecyclist.
- Collisionsoccurredwhenthesumofthebrakingreactiontime
(BRT)andthecarbrakingdecelerationtimewaslargerthanthe
- Theanalysisofeye-trackingdataallowedresearchersto timetocollision(TTC)whenthecyclistwasvisibletodrivers.
categorizegazebehaviorandfixationpatterns. - Asthetimeforparticipantstonoticecyclistscrossingfromthe
4, - Thenewsignagestrategywasexperiencedaspositivebymost 17, farsidewaslonger,itledtoalongerbrakingresponsetime
[19] participants,andithelpedthemnavigatetheroutemoreeasily. [29] (BRT).Thestudyobservedthatparticipants’behaviortoavoid
- Withtheincreasingcomplexityofthetrafficenvironment, collisionschangedfromswervingtobrakingasthenoticetime
prioritizingrouteguidanceinformationdiminished. increased.
- Participantstendedtonoticethecyclistmorequicklywhenthe
gazeanglewassmall.
- Cyclistsfaceddangersinriskyweatherconditions.The
buildupofsnowpromptedcycliststodeviatefromtheir
designatedcyclingpaths,exposingthemtotheriskof
- Pedalcyclingexperiencedidnotsignificantlyaffectdrivers’
collisions.
visualattentiontowardspedalcycles.
5, - Cyclists’riskyactionsmayposeadangertoboththemand 18, - Drivers,ingeneral,didnotpayasmuchattentiontopedal
[10] otherroadusers. [30] cyclesapproachingfromfardistances,despitethem
- Theparticipantsperceivedgreatersafetyinareaswith
approachingatidenticalspeedstocarsandmotorcycles.
dedicatedcyclinglanes.
- Cyclists’behaviorwasdirectlyinfluencedbythecharacteristics
oftheroadsurfaceandthedesignofinfrastructuregeometry.

Sensors2025,25,22 49of53
TableA5.Cont.
ID,Ref. Results StudyID Results
- Thecurrentspatialarrangementdoesnotdictatetheduration
ofindividuals’fixationonaspecificspot.
- Cyclistsarerequiredtoincreasetheirvisualscanninginareas
characterizedbyahighernumberofexposededges.
- Whenconfrontedwithnumerousanglesobscuringpotential
hazards,participantsexperiencedahighvisualworkload,
- Thepresenceofcyclistssignificantlyaffecteddriver
leadingthemtoprimarilyfocusonwhatlayaheadofthem.
performance,includingvisualattentionandcrashavoidance
6, - Theperceptionofsubjectiverisk,influencedbythespatial 19, behavior.
[11] complexityofthelocation,leadstomorehurriedand [27] - Secondarytaskengagementhadasignificanteffectondriver
disorganizedvisualscanningbehavior.Thisincludesshorter
performance.
periodsoffixatingonobjectssituatedclosertotheindividual
andindirectionsthatdeviatemorefromthedirectionoftravel.
- Experiencedcyclistsexhibitamoreregulatedvisualscanning
processanddemonstratemoreforward-lookingbehavior,as
indicatedbylongerfixationdurations.Additionally,they
assessedtheoveralltestlocationstobelesshazardous.
- Therelativepositionofcyclistshadasignificantimpacton
drivers’visualattentionandcrashriskinright-hookcrash
- Drivershadahighprevalenceofvisualscanningfailures scenarios.
towardsareaswhereVRUscouldapproachaturban - Driversweremorelikelytodetectandfixateoncyclistswhen
7, intersections,particularlyduringrightturns. 20, theywereridingaheadofthedriverintheirfocalvisionthan
[18] - Cyclingexperiencewasfoundtohaveamoderatingeffecton [28] whentheywereapproachingfrombehindinthedriver’sblind
thesescanningfailures,withnon-cyclistdriversexhibiting spot.
morefailuresthancyclistdrivers. - Thepresenceofoncomingleft-turningvehiculartrafficand
conflictingpedestriansinthecrosswalkalsoincreasedtherisk
ofright-hookcrashesinvolvingcyclists.

Sensors2025,25,22 50of53
TableA5.Cont.
ID,Ref. Results StudyID Results
- Physiologicaldata,particularlychangesinheartrateandgaze
- Pedestriansconsideredrelevantweretheprimaryfocusof
behavior,aresensitivetoroadenvironmentchangesand
8, attentionregardlessofthetrafficsignal’sstatus. 21, real-timeeventsintheimmersivevirtualenvironment(IVE).
[12] - Duringredlightturns,driverattentionwaspredominantly [22] - Differentenvironmentalfactorscanimpactparticipants’stress
directedtowardstrafficcomingfromtheleft.
levelsandcognitiveload.
- Thevirtualrealitycyclingsimulatorprovidedarealisticand
engagingtooltoassesshazardanticipationskillsinchild
- Thereareparticularlocationswithinurbanareaswherecyclists
cyclists.
aremorelikelytolookordirecttheirgaze.
9, - CyclistspresentaT-shapedgazepatternwithtwospotsof 22, - Participantsdemonstrateddelayedresponsesincovert
[13] frequenteyefixationpoints,whichmaybenefitcyclistswith [21] hazardoussituationscomparedtoovertones,indicatinga
needforimprovedhazarddetectionincertainscenarios.
greatersafetyandbetterreadinessforroadsituations.
- Consideringfactorslikespeedandroadpositioning,is
importantinevaluatinghazardanticipationskills.
- Cyclistsbehavedcomparablyinvirtualandinsitu
- Thenumberanddurationoffixationsvariedwidelybasedon environments,andthevirtualenvironmentdemonstrated
10, theintersection. 23, potentialapplicabilityfordevelopinghazardperception
[14] - Intersectiondesigncharacteristicscanimpactcyclists’ [31] amongyoungcyclists.
behavior. - Furtherworkisneededtofullyunderstandthecomparability
ofvisualsearchbehaviorinbothvirtualandinsitusettings.
- Thereweresignificantdifferencesinthevisualattention
patternsofpedestrians,cyclists,andelectricscooterriders.
- Therearesimilaritiesbetweenthevisualbehaviorof
- Themodeoftransport“pedestrians”hadadifferentpatternof
participantsinthesimulatedandrealscenarios,emphasizing
visualattentioncomparedtotheothertwomodes.
11, - Therearedangerousridingbehaviors,particularlyamong 24, thevalidityoftheuseofthebicyclesimulator.
[15] electricscooterriders,withspeedsdeemedtoohightoensure [32] - Thesimulatorwasascloseaspossibletotherealscenario,
obtainingobjectiveresultsverysimilartoeachotherand
pedestrians’safety.
providingvisualsensations,vibrationmovement,andnoise.
- Atotalof261violationsoftrafficrulesbytheparticipantswere
identified,includingbothminorandmajorinfractions.

Sensors2025,25,22 51of53
TableA5.Cont.
ID,Ref. Results StudyID Results
- CWSusageresultedinearlierbrakingreactionstoall - Theresultsindicatedsignificantdifferencesingazebehavior
investigatedSCEsandpartlyearlierfixationoncritical betweenthesimulatorandfieldstudy.
interactionpartners(CIPs),indicatingincreasedsituation - Inthesimulator,thegazedistributionwasmorehorizontal,
12, awarenessamongcyclists. 25, whileinthefieldstudy,itwasvertical.
[20] - Participants’assessmentsregardingperceivedsafetyfurther [33] - Morefixationsandvisitswereobservedinthefieldstudy,with
supportedthesafetyimprovementsderivedfromCWSusage shorteraveragevisitdurations.
independentlyofagegroup. - Thegazebehaviorwasfoundtobemoreactiveinthefield
- CWSusagedidnotaddtomentalworkloadratings. studycomparedtothesimulation.
- Cyclistsexhibitedhighvisualattentiontothetrafficareaof
interestwhilenavigatingcommercialvehicleloadingzones.
- Factors,suchasthesizeoftheloadingzone,thepresenceofa
13, courier,andloadingzoneaccessories,influencedthestress
[23] levelsofcyclists.
- Thereisacorrelationbetweenperceivedrisk,galvanicskin
response(GSR)measurements,andvisualattentionin
commercialvehicleloadingzones.

Sensors2025,25,22 52of53
References
1. Boele-Vos, M.; Schagen, I.V.EuropeanCommissionRoadSafetyThematicReport—Cyclists; EuropeanCommission, Directorate
GeneralforTransport:Brussels,Belgium,2024.
2. Mellauner,M.;Fleischer,M.;Donabauer,M.;Soteropoulos,A.EuropeanCommissionFactsandFiguresCyclists;EuropeanCommis-
sion,DirectorateGeneralforTransport:Brussels,Belgium,2021.
3. Shinar,D.;Valero-Mora,P.;vanStrijp-Houtenbos,M.;Haworth,N.;Schramm,A.;DeBruyne,G.;Cavallo,V.;Chliaoutakis,J.;Dias,
J.;Ferraro,O.E.;etal.Under-ReportingBicycleAccidentstoPoliceintheCOSTTU1101InternationalSurvey:Cross-Country
ComparisonsandAssociatedFactors.Accid.Anal.Prev.2018,110,177–186.[CrossRef][PubMed]
4. Schepers,J.P.;Weijermars,A.M.;Boele,M.J.;Dijkstra,A.;Bos,N.M.OudereFietsers:OngevallenMetOudereFietsersEnFactorenDie
DaarbijEenRolSpelen;SWOVInstituteforRoadSafetyResearch:TheHague,TheNetherlands,2020.
5. Morris,A.;Brown,L.;Thomas,P.;Davidse,R.J.;Phan,V.;Margaritis,D.;Usami,D.S.;Robibaro,M.;Krupinska,A.;Sicinska,
K.; etal. SaferWheelsStudyonPoweredTwo-WheelerandBicycleAccidentsintheEU—FinalReport; LoughboroughUniversity:
Loughborough,UK,2018.
6. Olesen, A.V.; Madsen, T.K.O.; Hels, T.; Hosseinpour, M.; Lahrmann, H.S.Single-BicycleCrashes: Anin-DepthAnalysisof
Self-ReportedCrashesandEstimationofAttributableHospitalCost.Accid.Anal.Prev.2021,161,106353.[CrossRef][PubMed]
7. Page,M.J.; McKenzie,J.E.; Bossuyt,P.M.; Boutron,I.; Hoffmann,T.C.; Mulrow,C.D.; Shamseer,L.; Tetzlaff,J.M.; Akl,E.A.;
Brennan,S.E.;etal.ThePRISMA2020Statement:AnUpdatedGuidelineforReportingSystematicReviews.BMJ2021,372,n71.
[CrossRef][PubMed]
8. SparckJones,K.AStatisticalInterpretationofTermSpecificityandItsApplicationinRetrieval.J.Doc.1972,28,11–21.[CrossRef]
9. Stelling-Konczak,A.;Vlakveld,W.P.;vanGent,P.;Commandeur,J.J.F.;vanWee,B.;Hagenzieker,M.AStudyinRealTraffic
ExaminingGlanceBehaviourofTeenageCyclistsWhenListeningtoMusic:ResultsandEthicalConsiderations.Transp.Res.Part
FTrafficPsychol.Behav.2018,55,47–57.[CrossRef]
10. Shoman,M.M.;Imine,H.;Acerra,E.M.;Lantieri,C.EvaluationofCyclingSafetyandComfortinBadWeatherandSurface
ConditionsUsinganInstrumentedBicycle.IEEEAccess2023,11,15096–15108.[CrossRef]
11. vonStülpnagel,R.GazeBehaviorduringUrbanCycling:EffectsofSubjectiveRiskPerceptionandVistaSpaceProperties.Transp.
Res.PartFTrafficPsychol.Behav.2020,75,222–238.[CrossRef]
12. Girgis,J.;Powell,M.;Donmez,B.;Pratt,J.;Hess,P.HowDoDriversAllocateVisualAttentiontoVulnerableRoadUsersWhen
TurningatUrbanIntersections?Transp.Res.Interdiscip.Perspect.2023,19,100822.[CrossRef]
13. Jang,G.;Kim,S.InvestigatingtheEffectofaRaisedCycleTrack,PhysicalSeparation,LandUseandNumberofPedestrianon
Cyclists’GazeBehavior.J.Archit.Urban.2019,43,112–122.[CrossRef]
14. Rupi,F.;Krizek,K.J.VisualEyeGazeWhileCycling:AnalyzingEyeTrackingatSignalizedIntersectionsinUrbanConditions.
Sustainability2019,11,6089.[CrossRef]
15. Pashkevich,A.;Burghardt,T.E.;Puławska-Obiedowska,S.;Šucha,M.VisualAttentionandSpeedsofPedestrians,Cyclists,and
ElectricScooterRidersWhenUsingSharedRoad—AFieldEyeTrackerExperiment.CaseStud.Transp.Policy2022,10,549–558.
[CrossRef]
16. Kircher,K.;Ahlström,C.AttentionalRequirementsonCyclistsandDriversinUrbanIntersections. Transp. Res. PartFTraffic
Psychol.Behav.2020,68,105–117.[CrossRef]
17. Mantuano,A.;Bernardi,S.;Rupi,F.CyclistGazeBehaviorinUrbanSpace:AnEye-TrackingExperimentontheBicycleNetwork
ofBologna.CaseStud.Transp.Policy2017,5,408–416.[CrossRef]
18. Kaya,N.;Girgis,J.;Hansma,B.;Donmez,B.Hey,WatchWhereYou’reGoing!Anon-RoadStudyofDriverScanningFailures
towardsPedestriansandCyclists.Accid.Anal.Prev.2021,162,106380.[CrossRef]
19. Aasvik,O.;Fyhri,A.DistractingorInformative? ExaminingSignageforCyclistsUsingEye-Tracking. TrafficSaf. Res. 2022,2,
000013.[CrossRef]
20. Springer-Teumer, S.; Kreißig, I.; Krems, J.F. Anticipatory Information Makes the Difference: Behavioral Effects and User
AssessmentsofaCyclistWarningSystemtoEnhanceCyclists’SituationAwareness.J.SafetyRes.2023,87,266–284.[CrossRef]
[PubMed]
21. Zeuwts,L.H.R.H.;Vanhuele,R.;Vansteenkiste,P.; Deconinck,F.J.A.; Lenoir,M.UsinganImmersiveVirtualRealityBicycle
SimulatortoEvaluateHazardDetectionandAnticipationofOvertandCovertTrafficSituationsinYoungBicyclists.VirtualReal.
2023,27,1507–1527.[CrossRef]
22. Guo, X.; Angulo, A.; Robartes, E.; Chen, T.D.; Heydarian, A.ORCLSim: ASystemArchitectureforStudyingBicyclistand
PedestrianPhysiologicalBehaviorthroughImmersiveVirtualEnvironments.J.Adv.Transp.2022,2022,2750369.[CrossRef]
23. Jashami, H.; Cobb, D.; Sinkus, I.; Liu, Y.; McCormack, E.; Goodchild, A.; Hurwitz, D.EvaluationofBicyclistPhysiological
ResponseandVisualAttentioninCommercialVehicleLoadingZones.J.SafetyRes.2024,88,313–325.[CrossRef][PubMed]
24. Abadi,M.G.;Maloney,P.;Hurwitz,D.ExploringBicyclists’VisualAttentionduringConflictswithTruckTraffic.Transp.Res.Rec.
2022,2676,137–144.[CrossRef]

Sensors2025,25,22 53of53
25. Warner,J.;Hurwitz,D.S.;Monsere,C.M.;Fleskes,K.ASimulator-BasedAnalysisofEngineeringTreatmentsforRight-Hook
BicycleCrashesatSignalizedIntersections.Accid.Anal.Prev.2017,104,46–57.[CrossRef]
26. Kim,A.J.;Alambeigi,H.;Goddard,T.;McDonald,A.D.;Anderson,B.A.Bicyclist-EvokedArousalandGreaterAttentionto
BicyclistsIndependentlyPromoteSaferDriving.Cogn.Res.Princ.Implic.2021,6,66.[CrossRef][PubMed]
27. Fleskes,K.;Hurwitz,D.S.InfluenceofBicyclistPresenceonDriverPerformanceduringAutomatedVehicleTake-overRequests.
Transp.Res.PartFTrafficPsychol.Behav.2019,64,495–508.[CrossRef]
28. Jannat,M.;Tapiro,H.;Monsere,C.;Hurwitz,D.S.Right-HookCrashScenario: EffectsofEnvironmentalFactorsonDriver’s
VisualAttentionandCrashRisk.J.Transp.Eng.PartSyst.2020,146,04020026.[CrossRef]
29. Zhao,Y.;Mizuno,K.;Aoshima,Y.;Kanianthra,J.N.;Inagami,M.DriverResponsestoCyclistsCrossingfromNearandFarSidein
DrivingSimulatorExperiments.Int.J.Automot.Eng.2022,13,89–96.[CrossRef][PubMed]
30. Robbins,C.J.;Chapman,P.Drivers’VisualSearchBehaviorTowardVulnerableRoadUsersatJunctionsasaFunctionofCycling
Experience.Hum.Factors2018,60,889–901.[CrossRef]
31. vanParidon,K.;Timmis,M.A.;SadeghiEsfahlani,S.DevelopmentandEvaluationofaVirtualEnvironmenttoAssessCycling
HazardPerceptionSkills.Sensors2021,21,5499.[CrossRef][PubMed]
32. Acerra,E.M.;Shoman,M.;Imine,H.;Brasile,C.;Lantieri,C.;Vignali,V.TheVisualBehaviouroftheCyclist:Comparisonbetween
SimulatedandRealScenarios.Infrastructures2023,8,92.[CrossRef]
33. Gay,N.;Trefzger,M.;Sawilla,S.;Schlegel,T.HowRealisticIstheGazeBehaviourinaCyclingSimulator?AComparativeStudy
betweenLabandField.Transp.Res.Procedia2023,72,1061–1068.[CrossRef]
34. Caine,K.LocalStandardsforSampleSizeatCHI.InProceedingsofthe2016CHIConferenceonHumanFactorsinComputing
Systems;AssociationforComputingMachinery,NewYork,NY,USA,7May2016;pp.981–992.
35. Yaqoob,S.;Cafiso,S.;Morabito,G.;Pappalardo,G.DeepTransferLearning-BasedAnomalyDetectionforCyclingSafety.J.Safety
Res.2023,87,122–131.[CrossRef]
36. Yaqoob,S.;Cafiso,S.;Morabito,G.;Pappalardo,G.DetectionofAnomaliesinCyclingBehaviorwithConvolutionalNeural
NetworkandDeepLearning.Eur.Transp.Res.Rev.2023,15,9.[CrossRef]
37. Nguyen-Trung,K.;Saeri,A.K.;Kaufman,S.ApplyingChatGPTandAI-PoweredToolstoAccelerateEvidenceReviews.Hum.
Behav.Emerg.Technol.2024,2024,8815424.[CrossRef]
38. Souifi, L.; Khabou, N.; Rodriguez, I.; Kacem, A. Towards the Use of AI-Based Tools for Systematic Literature Review. In
Proceedingsofthe16thInternationalConferenceonAgentsandArtificialIntelligenceICAART2024,Rome,Italy,23–25February
2024;Volume2,pp.595–603.
39. Infante,A.;Guerri,G.;DelCiello,A.;Gullì,C.;Chiloiro,S.;DeVizio,S.;Ruscelli,L.;Merlino,B.;Natale,L.;Sala,E.;etal.Would
ChatPDFBeAdvantageousforExpeditingtheInterpretationofImagingandClinicalArticlesinPDFFormat?J.Med.Artif.Intell.
2025,8.[CrossRef]
Disclaimer/Publisher’sNote: Thestatements, opinionsanddatacontainedinallpublicationsaresolelythoseoftheindividual
author(s)andcontributor(s)andnotofMDPIand/ortheeditor(s).MDPIand/ortheeditor(s)disclaimresponsibilityforanyinjuryto
peopleorpropertyresultingfromanyideas,methods,instructionsorproductsreferredtointhecontent.
BULLETINOFTHEPOLISHACADEMYOFSCIENCES SPECIALSECTION
TECHNICALSCIENCES,Vol.73(6),2025,Articlenumber:e152709
DOI:10.24425/bpasts.2025.152709
Enhancing mobile eye-tracking in extreme urban
lighting conditions
MartaRUSNAK1,2∗, ZofiaKOSZEWICZ2,1 , FranciszekHACKEMER2 , IzabelaGARASZCZUK3,1 ,
AndrewT.DUCHOWSKI4 , and RafałKARNICKI2
1LET’sGOLaboratoryofEye-trackingGivesOpportunities,FacultyofCivilEngineering,WrocławUniversityofScienceandTechnology,Poland
2FacultyofArchitecture,WrocławUniversityofScienceandTechnology,Poland
3FacultyofFundamentalProblemsofTechnology,WrocławUniversityofScienceandTechnology,Poland
4SchoolofComputing,ClemsonUniversity,USA
Abstract. Oneofthemethodsforunderstandingresidents’needsandsociallyimprovingurbanspacesintermsoftransportation,safety,landscape
protectionandmanagingtouristtrafficloadiseye-tracking(ET).ResearchersusingmobileETforoutdoorstudiesfacesignificantchallenges,
particularlyduetosunlightaffectingdataquality. Existingsolutionsoftenoverlookparticipantcomfort. Thisarticleintroducesanovelaccessory
designedforextremelightingconditions,suchasbrightdays,sunsetsandsnowyorwater-filledenvironments. Thegoalistoeliminatedisruptions
causedbyuncontrolledsunlightonparticipants’eyes,andtoenablestudiesinurbanenvironments. Acustomsunshield,designedforETsbased
onspectacleframes,prioritizesbothphysicalandpsychologicalcomfort. Thelightweightshieldiseasytoinstall,minimallyrestrictsthefieldof
view,anddoesnotinterferewitheye-trackingcomponents. Itiscost-effectiveandsuitableforDIY3Dprinting. Controlstudiesandfieldresearch
confirmeditseffectiveness,withfeedbackfromover100usersimprovingthefinaldesign. Theshieldenhanceseye-trackingresearchcredibility
undersunnyconditions, supportsefficientcalibration, andimprovesparticipantrecruitmentandwell-being. Thequalityofdataobtainedhas
improvedsignificantly,whichismanifestedbyacomparisonofdateconcerningthemannerofpupildetection. Thankstothissolution,itwill
becomepossibletoconductresearchaimedatbetterunderstandingthebehaviorofcityusers,whileensuringtheircomfortandsafety. Itwill
alsobepossibletoconductresearchwithintheframeworkofso-calledlivinglabs. Importantly, studiesshowthattheapproachtodesigning
subsequentmobileETsbasedonIRshouldundergosignificantmodification.
Keywords: outdooreye-tracking;smartcity;dataquality;calibration;sunlight.
1. INTRODUCTION product design [6]. This applies to various objects and activi-
Video eye-trackers (ETs) are based on estimating the position ties, including those carried out in natural and urban spaces;
ofthepupilcenterrelativetotheinfrared(IR)lightreflections whilewalking[7],driving[8],cycling[9],working[10],while
onthecorneaofafixedlightsource,e.g.usuallyasmallnear- practicing sports [2] or in combat [11]. Field studies can be
IR light emitting diode (LED) or multiple LEDs [1]. The use conductedundervariouslightingconditions[12].Atechnolog-
of IR allows indicating the direction in which the participant icalchallengeaffectingtheperformanceofETisthesituationin
is looking. The light itself is invisible to the participant. One whichintensesunlighthinderseffectiveresearch[13].Thereare
type of ET includes mobile devices. With them, research can atleasttwoaspectsofnaturallightinginfluencingthedeteriora-
beconductedinmotion[2],invariouscognitivesituations,also tionorlackofdata[14].Firstly,thereisglare–whenparticipants
outside of laboratories and building interiors [3]. This type of partiallyorcompletelyclosetheireyes[15].Thiseffectprevents
device is typically worn on the participant’s head. These ETs the diagnosis of cognitive load based on the number of blinks
can be attached to helmets, straps, bands and frames. Almost oreye-openness[4].Itdiminishesthepercentofgazedatacol-
everyone wears or has worn glasses at some point (corrective, lected. The second element negatively affecting the feasibility
sunglasses,protective),sothemostcognitivelynaturalapproach and quality of studies conducted in highly sun-exposed areas
seemstobetheuseofglassesorframeswornonthenoseand istheoccurrenceofadditionalIRreflections,generatedonthe
ears.Glassesarealsoanelementthatotherpeoplearelesslikely eye due to sunlight. This is a problem noted by numerous re-
tonotice. searchersfromvariousfields.Solutionsofferedbymanufactur-
ETsareutilizedassensorsinsmartobjects[4],theyalsocon- ers(protectivecovers,sunglassesandpolarizedlenses),despite
tributetohuman-computerinteraction [5]andassessorenhance theirassurances,areofteninsufficient[14].Inbrightlylitareas,
calibration,whichallowsforconsideringtheinfluenceofindi-
vidualcharacteristicsoftheparticipantonthemeasurements,is
∗e-mail:marta.rusnak@pwr.edu.pl
oftenimpossible.Thenumberofdatacollectedperunitoftime
dropstolevelsbelow40%.Thismeans,forexample,thatfora
Manuscriptsubmitted2024-10-13,revised2024-11-17,initially
acceptedforpublication2021-11-17,publishedinNovember2025. 120HzET,lessthan50eyepositionsarediagnosedpersecond,
Bull.Pol.Acad.Sci.Tech.Sci.,vol.73,no.6,p.e152709,2025 1
©2025TheAuthor(s).ThisisanopenaccessarticleundertheCCBYlicense(http://creativecommons.org/licenses/by/4.0/)

M.Rusnak,Z.Koszewicz,F.Hackemer,I.Garaszczuk,A.T.Duchowski,andR.Karnicki
indicating that these data are not evenly distributed over time In the summer’s intense sunlight, especially with the low sun
(no continuity). Interpreting eye positions based on randomly andneartheriver,thedataqualitywasinadequate.Duringthe
recordedfixationsandsaccadesisimpossiblebecausethereare research, calibration of the device was often ineffective, and
manyinterferences.Thegazepathrecordedbythedevicecould whenregistrationstartedintheshade,thedevicecouldnotfre-
lookcompletelyunbelievable(illogicalfastjumpswithextreme quentlyindicatetheparticipant’sgazedirectionduringthewalk.
amplitudeandrandomdirection). Conducting research in this manner would result in a massive
Literature reviews reveal how scientists have attempted to lossofdata.
preventbothoftheseunfavorablesituations: Similartostudiesdescribedintheintroduction,attemptswere
• conductingstudiesexclusivelyunderovercastsky[9] made to conduct registrations with a cap with a visor, a high-
• usingshadingroofs[16] crownedhat,andevenahood.Noneofthesemethodsweresat-
• askingparticipantstowearlargeMexicanhats[17] isfactoryneartheriver,wheretheatypical,bottom-updirection
• constructing helmets with a shield made of special foil as ofsunlightpenetrationundertheeyetrackerremainedproblem-
faceshields[7] atic.Theeffectwaspartiallyeliminatedbyapplyingblacklip-
• proposingtheuseoftintedorphotochromiclenses[14] stick/facepaintordarkadhesivebandage(sizearound3×4cm)
• someevenabandoningopticaleye-trackinginfavorofelec- justbelowthelowereyelids.However,thissolutionwasdeemed
trooculography[11]. unacceptable by recruited passersby (strange appearance, po-
What is important is that the problem is common, first no- tential allergic reaction, makeup smudging, the need to touch
ticed and described more than 10 years ago (2012–2023), and theparticipant,difficultyinremovingthepaint)andunnaturally
thatitaffectsmanyproducts(typeswereindicatedinbrackets). drewtheattentionofothers.Duetotheineffectivenessofprevi-
Insomearticles,therearenosectionsreportingsuchproblems oussolutionsortheirnegativeimpactonresearchresults,itwas
[18], which seems to be an oversight from a methodological deemednecessarytodesignanelementthatwouldenableone
point of view. It should be noted that in many cases, despite to conduct studies in a wider range of real-life situations. The
the shields applied, data quality still raised doubts. However, newsolutionwasintendedtofacilitateresearchnearwaterbod-
scientists using these solutions did not discuss the impact of ies (beach, lifeguard training, navigation, sailing, landscapes,
narrowingthefieldofvieworheadloadonthefocusofthepar- waterfronturbanplanning),outdoorsportsstudies(equestrian-
ticipants[19].Individualsolutionscausedadditionalreflections ism,cycling,tennis,skiing),andresearchconductedatdifferent
([7]–videoabstract1:00–1:35).Someoftheseprojectsmight times of the day associated with the sunlight’s unfavorable di-
have also looked unusual because the research was conducted rectionforeye-trackeroperation(morning–sunrise,evening–
inisolation[7].However,thisisnotpermissiblewhenpartici- sunset) and seasons (in winter with a dazzling effect from the
pantsaresupposedtoactasnaturallyaspossibleinurbanspace. snowcover).
The design of the apparatus can influence the behavior of the Expandingtherangeoflocationswherereliableresearchus-
participants and people around them. As a result, the research ingETcanbeconductediscrucialforthesociallyresponsible
findings become less credible. It is also essential that without design of sustainable urban spaces that cater to the needs of
accesstotheprojectofthechangesmade,theresearchcannot diverse users. These include residents, tourists, cyclists, peo-
beverifiedorcontinued(thepresentedstudiesdonotmeetthe plewithdisabilities,andindividualsperformingoutdoorwork
basic criterion of scientific credibility). Additionally, the un- such as rescue workers, municipal guards, police officers, and
usual appearance of additional eye-tracking elements (shape, constructionworkers.
size, color), their weight, and the long time needed for their
properinstallationcouldhinderorevenpreventtheiruseintests
on randomly recruited participants. The need for an unfavor- 2. GOAL
ablelimitationtoindividualswhomayknowtheresearchgoal Thenewelementisintendedtobeaneffective,affordable,easy-
or be professionals is mentioned by de la Fuerte Suárez [20]. to-use accessory for ET glasses. Considering usage guidelines
Theseareallveryimportantdistractorsthatneedtobeavoided. and warranties, the solution should not modify other compo-
Duetocalibrationissuesanddataloss,asignificantportionof nents of the eye tracker and should be universal enough that,
research,despitefocusingonurbanspaces,areasbeyondbuild- with slight modifications to its design, its operating principle
ings,andlandscapes,isconductedinlaboratories.Themethod couldbeappliedtodifferentmobileeyetrackers.Originally,the
of assessing gaze is based on photos [21], visualizations and goalwastocreateanideaallowingforuniversaluseinallsuch
photomontages [22], videos games or VR technology [23]. It eyetrackers,asshowninthesketchpresentedinFig.1.Itwasde-
iscrucialtoconductandcomparetestresultsindifferentenvi- cidedthattheaccessorymustblocklightfromthreedirections:
ronments as often as possible. Currently, due to technological frombelow,fromthesidebehindtheear,andfromabove.The
reasons,thisoftenprovesimpossible.Dataacquiredinintense needtochangethedesignapproachforETdevicesintendedfor
and/or directly shining sunlight on the participant’s face are useinthefieldwillbeverifiedbyexaminingthreekeyaspects.
usuallyofpoorquality[24].ThisissuewasencounteredinJuly Whether complete shielding of light from all directions will:
2023 during the preparation of research on the perception of support proper pupil detection by mobile ET devices, enable
OstrowTumskiinWrocław.Participantsweresupposedtowalk or shorten the calibration procedure, and impact the percent-
alongasunnyboulevardbytheriver.Originally,dataweretobe age of data collected. Beyond achieving the primary technical
collectedusingTobiiGlasses3+protectivetintedlenses[25]. goals,thearticleaimstopresentthenextdesignstagesfocused
2 Bull.Pol.Acad.Sci.Tech.Sci.,vol.73,no.6,p.e152709,2025

Enhancingmobileeye-trackinginextremeurbanlightingconditions
onmodifyingthemethodofblockinglight,takingintoaccount According to the review conducted, the selected ET has the
otherfactorssuchasmaterialproperties,aesthetics,psychologi- greatestpotentialforconductingscientificresearchundercondi-
cal,economic,andergonomicaspects.Theadditionalobjectives tionsofintenselighting.Fulldevicespecificationsareavailable
arecharacterizedbelow.Andtheissueoffittingandinstallation onthemanufacturer’swebsite.Theyincludedescriptionsofthe
needstobeaddressedindividually. tinted protective lenses (15%) designed to block 850nm IR
waves[25].Theproductdescriptionstatesthat:“Withadiscreet
design,ourprotectivelensesfitsnuglyoverTobiiProGlasses3,
providing the wearer with optimum comfort and freedom of
movement – enhancing the accuracy of data capture and low-
ering the impact of external influences, such as sunlight and
nearbyobjects”.Aspertheconcernsmentionedintheintroduc-
tion,thefactorysolutionprovedunsatisfactory.Beforestarting
the project, verification of the described parameters and addi-
tional measurements were carried out. The spectral transmit-
tanceofthedarktintedfilteronprotectivelenseswasmeasured
(Fig.2)withtheUV-VISMETASHV-5100spectrophotometer.
Spectroscopicassessmentwasperformedinaccordancewiththe
Fig.1.Conceptsketchoftheshield
EuropeanstandardISOEN12312-1andcomparedagainstit.It
isanEuropeanstandardtestonUVtransmittance,whichcate-
gorizesfourfilterlevels(0–4).Additionally,theBritishstandard
The connection between the shield and the frame must not
testofsunglassesagainsttheirUVtransmittancewasperformed.
be permanent or carry the risk of damaging the devices and
Allsunglassesthatmeetthesestandardswillcarrythe‘CE’mark
accessories covered by the warranty. The design of the new
or‘UV400’,whichshouldbevisibleonthesunglasses.Onecan
elementshouldmeethighstandardstoensurethatparticipants
see that this attachment fulfills the criteria for sunglasses with
feelcomfortablebothphysicallyandpsychologically.Thecasing
a filter of category 3 (dark tint). This filter has transmittance
shouldbelightweight,stable,easytoinstall,anditshouldonly
below 18% in the visible light spectrum and protects the eye
minimally restrict the field of view. Aesthetic solutions were
against harmful UV light below 400 nm in wavelength. This
sought, and the colors and materials used should be similar to
filtercategoryismostsuitableforverybrightweatherorwater
thoseappliedinthemodifieddevice.Thecasingshouldallowfor
orsnowsportswherelightisreflected.
disinfectionorbedisposable.Itwasimportantforthesolution
tobecost-effective,evenfeasibleforDIYproduction.
3. MATERIALANDMETHOD
To identify the most suitable ET device for research purposes,
we sought a model that, according to the manufacturer’s de-
scription, would be best suited for conducting studies in en-
vironments with intense sunlight. Additionally, considerations
included user comfort, aesthetics (appearance resembling reg-
ular glasses), and the ability to customize the device to meet
participants’ visual needs (vision correction, eye protection). Fig.2.SpectraltransmittanceofthedarkfilterattachmentofTobii
Glasses3
Based on a literature review (see introduction), we analyzed
data on various ET devices used by researchers, who reported
difficultiesinconductingstudiesunderdirectsunlight.Thede-
vicesreviewedincludedETVision,VPSNeon,TobiiGlasses2, 3.1. Descriptionofthedesignedelement
TobiiGlasses3,PupilLabs,ASLMobileEye-XG,PositiveSci- TheshieldisslidontotheincludedTobiiGlasses3polycarbon-
ence, Pupil Labs, ASL Mobile Eye-XG, SMI Glasses 2.0 and ateprotectivelenses(tinted),andthen,alongwiththeshield,is
aSeeGlasses.ETdeviceswereeliminatedfromconsiderationif mountedontotheET.Thecasing’sdesignallowsforfillinggaps
theywere:nolongeravailableonthemarket,trackedonlyone between the eyeglass frame and the test subjects’ nose wings,
eye,requiredalaptopinsteadofaportabledevice,lackedWi-Fi forehead,jaw,cheekbonesandtemples.Theshieldpreventsun-
functionality,orrecordedeyepositiondataatafrequencylower controlled entry of sunlight from the sides, top and bottom of
than60 Hz,or lackedsolutionsthat allowedfor thecorrection thedevice.Theshielddoesnottouchorobstructanyfunctional
ofparticipants’visualimpairments. elementsoftheET,suchascameras,LEDsormountingmag-
Aftertheanalysis,TobiiGlasses2andTobiiGlasses3were nets (Fig. 3). The project was modeled in Blender 4.0 based
selected. Since it was demonstrated that Tobii 3 outperformed onaphotogrammetricscanoftheET’sprotectivelensesusing
Tobii 2 in terms of accuracy during walking trials [26], the AgiSoft Metashape Professional. Due to the impossibility of
analysiswasconductedusingthenewergenerationdevice. scanningtransparentobjects,theeye-trackerwascoveredwith
Bull.Pol.Acad.Sci.Tech.Sci.,vol.73,no.6,p.e152709,2025 3

M.Rusnak,Z.Koszewicz,F.Hackemer,I.Garaszczuk,A.T.Duchowski,andR.Karnicki
anopaquelayer(50photosfromdifferentdirectionsweretaken). volved effectiveness tests (V1). The third was partially con-
Theshieldforstudiesunderextremelightingconditionsconsists nectedwiththefourthandincludedcomparativemeasurements
oftwoparts.Thefirstpart(1)isablackplasticmountingelement oftheimpactoftheshieldonthecomfortofusersandtheirfield
(frame).TheelementwasprintedfromPETGusingaPRUSA ofvision(V1andFV).Lasttestcomparedtheappearanceofthe
i3Mk3printer.Thesecondpart(2)isablackflexiblematerial eyetracker(ET)withoutandwiththeshield(V1andFV).
| filler – a | gasket. | In the | illustrated | example, | it is | a sponge, but |     |     |     |     |     |     |     |     |
| ---------- | ------- | ------ | ----------- | -------- | ----- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
itisalsoacceptabletomakeitfromblack,softrubber(Fig.3, 4.1. Pupildiametermeasurementsandeffectiveness
Fig.4).Theadvantageofthesecondsolutionistheabsenceof
Topresentthedifferenceinthequalityofdatacollectedwithout
theneedfordryingafterdisinfectionwithasurface-activeagent.
andwiththeshield,acomparisonwasmadeofhowthedevice
|     |     |     |     |     |     |     | performed | in detecting |     | and recognizing |     | eye | pupils. | Charts are |
| --- | --- | --- | --- | --- | --- | --- | --------- | ------------ | --- | --------------- | --- | --- | ------- | ---------- |
basedonrawdatafromTobiiProLab(Fig.5)andrepresentpupil
diametersof3healthyparticipantswalkinginasunnycourtyard
|     |     |     |     |     |     |     | (Wrocław,21 | Oct2023)while |     |     | performingatask |     | thatrequired |     |
| --- | --- | --- | --- | --- | --- | --- | ----------- | ------------- | --- | --- | --------------- | --- | ------------ | --- |
lookinginvariousdirectionsandcontinuouslymovingbetween
shadedandsunlitareas.Measurementstakenwithouttheshield
|     |     |     |     |     |     |     | show numerous      |     | inconsistencies. |     | Considering  |          | the   | study loca- |
| --- | --- | --- | --- | --- | --- | --- | ------------------ | --- | ---------------- | --- | ------------ | -------- | ----- | ----------- |
|     |     |     |     |     |     |     | tion, measurements |     | indicating       |     | a pupil      | diameter | of    | over 8mm    |
|     |     |     |     |     |     |     | for a participant  |     | are unreliable.  |     | Measurements |          | taken | with the    |
shieldshowverygooddataqualityintwocases.Measurements
|     |     |     |     |     |     |     | for Participant | 2     | have    | significantly | improved,  |     | but they | are still    |
| --- | --- | --- | --- | --- | --- | --- | --------------- | ----- | ------- | ------------- | ---------- | --- | -------- | ------------ |
|     |     |     |     |     |     |     | not ideal       | (max. | 6.8mm). | The           | comparison |     | reveals  | that the use |
Fig.3.Shieldanditsmountingmechanism(1–eye-tracker; of the shield resulted in an increase in pupil diameter, and the
2–protectivelens[25];3–shieldFV) shieldblocksoutsomelightandeliminatesglare.Initially,com-
parativestudieswereconductedon20participants(studentsof
|     |     |     |     |     |     |     | various | genders, | aged | 19–24 | y/o, without |     | vision impairments |     |
| --- | --- | --- | --- | --- | --- | --- | ------- | -------- | ---- | ----- | ------------ | --- | ------------------ | --- |
suchasstrabismus,functioningwithouthabitualopticalcorrec-
tion,withdifferentphysiognomies,bodymasses,andheights).
|     |     |     |     |     |     |     | Participants | were             | recruited | from | a group          | of  | passersby.  | Volun- |
| --- | --- | --- | --- | --- | --- | --- | ------------ | ---------------- | --------- | ---- | ---------------- | --- | ----------- | ------ |
|     |     |     |     |     |     |     | teers were   | not remunerated. |           |      | After explaining |     | the purpose | and    |
courseofthestudy,participantsgavetheirconsenttoparticipate
and,inaccordancewithethicalprinciples,couldwithdrawfrom
thetestsatanytime.Thetestswereconductedinacourtyardillu-
minatedbybrightpanels(51◦07′07.6′′N17◦03′14.6′′E)during
clearweatherinOctoberandDecember,withthesunpositioned
lowandinassimilarpositionaspossible(morning8:00–10:00
Frontal view and cross-section [mm] A – 3D printed PETG hours).Participants,standingatadesignatedpoint,weretasked
Fig. 4.
|              |       |        |         |             |       |             | with looking | twice, | in  | the appropriate |     | sequence, | at  | several ar- |
| ------------ | ----- | ------ | ------- | ----------- | ----- | ----------- | ------------ | ------ | --- | --------------- | --- | --------- | --- | ----------- |
| frame, upper | beam; | B – 3D | printed | PETG frame, | lower | half beams; |              |        |     |                 |     |           |     |             |
C–polyurethanefoam25kg/m3gluedtotheframe
| 3D printing | of  | the frame | (V1 | and FV) | took approximately |     |     |     |     |     |     |     |     |     |
| ----------- | --- | --------- | --- | ------- | ------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- |
7hours,assumingacubicinfilllevelof30%andalayerthick-
| ness of | 0.15mm. | PETG | filament | was used, | with | a consump- |     |     |     |     |     |     |     |     |
| ------- | ------- | ---- | -------- | --------- | ---- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
tionofapproximately49g(V1)and35g(FV).Additionally,2–3
hourswerededicatedtoattachingfoampadding(V1)orblocking
rubberelements(FV).Thecostofpurchasingmaterialsformak-
ingtheV1shieldin2023waslessthanEUR5/USD5.TheV1
shieldiseasiertoprint“athome”,theFVversionrequiresmore
| advanced | equipment | – that | fore is | more expensive |     | (cost of the |     |     |     |     |     |     |     |     |
| -------- | --------- | ------ | ------- | -------------- | --- | ------------ | --- | --- | --- | --- | --- | --- | --- | --- |
commercialprintorderwasestimatedatEUR/USD350–500.
4. RESULTS
Fig.5.Comparisonofpupildiametermeasurementswithoutandwith
| For the | created | concept, | to examine | how | physically | blocking |     |     |     |     |     |     |     |     |
| ------- | ------- | -------- | ---------- | --- | ---------- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
sunshield.Uppergraph:range:[0.000;8.387],mean:2.439,standard
side,topandbottomlightwouldaffecttheperformanceofthe deviation: 1.467: Lower graph: range [0.000, 6.723], mean: 2.923,
ET,severalcontrolstudieswereconducted.Thefirstconcerned
standarddeviation:0.932,Solidline:mean,dashedlinesdenotemargin
of±standarddeviation
| comparison | of pupil | diameter | measurements. |     | The | second in- |     |     |     |     |     |     |     |     |
| ---------- | -------- | -------- | ------------- | --- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
4
Bull.Pol.Acad.Sci.Tech.Sci.,vol.73,no.6,p.e152709,2025

Enhancingmobileeye-trackinginextremeurbanlightingconditions
chitecturalelementssurroundingthecourtyard.Bodyandhead eyelashes. The frame positively influenced the research flow.
rotationsresultedindifferentpositionsoftheETrelativetothe For 8 individuals, the frame reduced the number of necessary
sun. Observed objects were located low (participants lowered calibrationattempts(onaverageby2attempts).However,forone
their heads), at eye level, and high (participants raised their outof20individuals,thenumberofcalibrationswiththecover
heads). The task was performed once without the enclosure, was higher. In 15 out of 20 cases, data quality increased from
only with the protective glasses provided by the manufacturer 3% to 83%, with an average increase of 23.2%. In two cases,
(tinted)(Fig.5).Thesecondrepetitionwasperformedwiththe after applying the cover, effectiveness was lower (by 4% and
additionally applied cover (Fig. 5). The registration sequence 6%,respectively).Itisnoteworthythatthequalityofcollected
wasalternating(10timesWI-WII/10timesWII-WI).Thestud- datainthosetwocaseswithoutthecoverwasinitiallyveryhigh
ies were conducted under a cloudless sky. Participants spent (95–96%), but after using the cover, it decreased to the level
from24to37secondsonthetask.Table1showstheresultsof of90/91%.Additionally,recordingsinvariantWIturnedoutto
theenclosureeffectivenesstests. be inappropriate for further interpretation in six cases, and in
|     |     |        |     |     | variant WII,                                        | three | cases | were unsuitable. | In  | total, | in 10 cases, |
| --- | --- | ------ | --- | --- | --------------------------------------------------- | ----- | ----- | ---------------- | --- | ------ | ------------ |
|     |     | Table1 |     |     | WIdata,andfor3cases,WIIdatahadtobedeemedineffective |       |       |                  |     |        |              |
orfaultybecausethetimeduringwhichthedevicewasunable
Resultsofsimulation
toregisterthegazedirectionexceeded40%.
Location
Withoutshieldwith Withshield(V1)with The cover positively affected all aspects of research. A sig-
51.118771N
tintedprotectiveglass tintedprotectiveglass nificantsuccessistheconsiderablereductionindataloss(ata
17.054067E
levelof20%).Wilcoxonsigned-ranktestsshowedthatboththe
|     |     | calibration |     | calibration |     |     |     |     |     |     |     |
| --- | --- | ----------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
P-Participant %data* %data* numberofattemptedcalibrationsandeffectivenessofdatasam-
|     |     | attempts |     | attempts |     |     |     |     |     |     |     |
| --- | --- | -------- | --- | -------- | --- | --- | --- | --- | --- | --- | --- |
plingimprovedsignificantly(p<0.05).Thisnotonlysignifies
| 1   | 36% | II  | 68% | I   |          |              |     |               |     |             |         |
| --- | --- | --- | --- | --- | -------- | ------------ | --- | ------------- | --- | ----------- | ------- |
|     |     |     |     |     | time and | cost savings | but | also enhances | the | credibility | of data |
2 – IV 63% I interpretation. These findings are supported by field research
|     |     |     |     |     | conducted | near | a watercourse | [28]. | During | landscape | studies, |
| --- | --- | --- | --- | --- | --------- | ---- | ------------- | ----- | ------ | --------- | -------- |
| 3   | 69% | I   | 83% | I   |           |      |               |       |        |           |          |
82peoplewererecruited,andafterconsideringallmethodolog-
4 80% I 88% I ical exclusion aspects (accidental exclusion, battery depletion,
5 58% III 85% I cameraobstructionbybangs,failuretoperformthetask,talking
|     |     |     |     |     | on the phone, | removing |               | the ET), recordings |            | of 62 | individuals |
| --- | --- | --- | --- | --- | ------------- | -------- | ------------- | ------------------- | ---------- | ----- | ----------- |
| 6   | 84% | I   | 94% | I   |               |          |               |                     |            |       |             |
|     |     |     |     |     | remained      | (75%     | of the data). | Without             | the cover, | data  | would be    |
| 7   | 88% | I   | 91% | I   |               |          |               |                     |            |       |             |
justover50%.
Afterthedescribedtestsandfieldstudies(September2023in
| 8   | –   | IV  | –   | IV  |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
thecenterofWrocław,Poland),duringwhichover100people
| 9   | 81% | II  | 84% | I   |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
usedtheshield[27],itwasobservedthattheeffectivenessofthe
10 83% I 93% I cover varies and depends on the structure of the participants’
11 91% I 96% I facial anatomy (cheekbones, face width, nasal bone) and eyes.
Despiteusingfoamontheinnersideofthecover,insomecases,
| 12  | 44% | II  | 49% | III |            |          |              |              |     |     |             |
| --- | --- | --- | --- | --- | ---------- | -------- | ------------ | ------------ | --- | --- | ----------- |
|     |     |     |     |     | it was not | possible | to eliminate | translucency |     | due | to the less |
13 96% I 90% I prominentstructureofthezygomaticbonesinsomeparticipants.
Thematerialandshapeoftheshieldrequiredmodification,also
| 14  | 67% | I   | 78% | I   |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
becausepeoplewithwidenostrilsorprominentmouthsreported
| 15  | 46% | III | 69% | I   |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
itchingwhenspeaking.Therewerealsoremarksaboutslipping
| 16  | 95% | II  | 91% | I   |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
offthenose,thefeelingoftheframebeingrepelledfromtheface,
thelargesize,thesenseoftheenvironment.Duringtheresearch,
| 17  | 59% | I   | 91% | I   |                |      |            |           |                |          |              |
| --- | --- | --- | --- | --- | -------------- | ---- | ---------- | --------- | -------------- | -------- | ------------ |
|     |     |     |     |     | it was noticed | that | the casing | is not    | controversial, |          | but attracts |
| 18  | –   | IV  | 58% | II  |                |      |            |           |                |          |              |
|     |     |     |     |     | the attention  | of   | passersby  | much more | than           | ordinary | glasses.     |
19 67% I 83% I For this reason, an analysis of the appearance and subsequent
modificationsdescribedbelowwereundertaken.
| 20  | –   | IV  | 83% | I   |        |          |           |                |     |        |              |
| --- | --- | --- | --- | --- | ------ | -------- | --------- | -------------- | --- | ------ | ------------ |
|     |     |     |     |     | Due to | the need | to refine | the appearance |     | of the | V1, the fol- |
summary 4P.withoutcalibration 1Pwithoutcalibration lowing changes were introduced to the final version: strength-
|     | 5P.withpoordata |     | 2Pwithpoordata |     |              |          |          |            |          |                |            |
| --- | --------------- | --- | -------------- | --- | ------------ | -------- | -------- | ---------- | -------- | -------------- | ---------- |
|     |                 |     |                |     | ening the    | joints,  | reducing | the amount | of       | filament       | used (cost |
|     | 65%recordings   |     | 85%recordings  |     |              |          |          |            |          |                |            |
|     |                 |     |                |     | and weight), | changing | foam     | to rubber  | (enables | disinfection), |            |
|     | couldbeused     |     | couldbeused    |     |              |          |          |            |          |                |            |
ensuringventilation.
In 3 out of 20 cases, the application of the cover allowed 4.2. Aestheticcomparison
forsuccessfulcalibration,whichwouldnotbepossiblewithout Primarily,thetestsaimedtoverifytowhatextentadditionalac-
theshield.Inonecase,thecoverdidnotresolvethecalibration cessories (V1) influenced the way participants were perceived
issue;thispertainedtoanindividualwithlongupperandlower by other individuals in the nearby space. It proved impossible
5
Bull.Pol.Acad.Sci.Tech.Sci.,vol.73,no.6,p.e152709,2025

M.Rusnak,Z.Koszewicz,F.Hackemer,I.Garaszczuk,A.T.Duchowski,andR.Karnicki
to maintain the unchanged appearance of the person being ex- tions introduced led to the creation of the final version of the
aminedduetothenecessityofenclosingthespacebetweenthe shield(FV)(Fig.6E).ShieldFVhasadistinctlysmallerimpact
ETandtheface.Additionally,itwasnecessarytoinsertalayer on the perception of the figure and face of people wearing the
| adaptingtotheshapeoftheface.Becauseoftheaddedweight |     |     |     |     |     | device. |     |     |     |     |     |     |
| --------------------------------------------------- | --- | --- | --- | --- | --- | ------- | --- | --- | --- | --- | --- | --- |
onlyatthefrontoftheETandthusshiftingthecenterofgravity,
itisnecessarytousetheoriginalglassesstabilizingstrap,which 4.3. Impactonthefieldofvision
alsoaffectsparticipants’appearance(notmanypeopleareusing Toquantifythefitofthedesignandadjustit,theimpactofthe
theminreallifesituationswithregularcorrectiveglasses).De- opticalaidsonthesubjects’fieldofvisionwasassessedbyusing
spitethesefeatures,thedevicedoesnotoverlyattractattention thebinocularEstermanvisualfieldtest(EVFT).Measurements
frompassersby,asobservedduringrecordings.Glasseswiththe were performed with an automated projection perimeter PTS
| casing do | not disrupt | the perception | of the | silhouette | from | a   |     |     |     |     |     |     |
| --------- | ----------- | -------------- | ------ | ---------- | ---- | --- | --- | --- | --- | --- | --- | --- |
2000(Optopol,Poland,www.optopol.com.pl).EVTFwasorig-
distance greater than 5 meters. At a closer distance there is a inally designed to predict an individual’s mobility (walking),
noticeable change in facial proportions while wearing V1 of a butiscurrentlybeingusedasavisualfieldtestfordetermining
shield(Fig.6C/D).Thisappliestobothwomenandmenwhen fitnesstodriveintheUK.Itpresentsabrightwhitelightstimu-
seen from the front and from the side. ET with V1 shield is lus(10dB)ateachofthe120locationswithinthevisualfieldin
similartoskigogglesorVRglasses,theimageofwhichisal-
75degreeshorizontaland55degreesverticalranges,arranged
readywidelypresentinpublicconsciousness,butitisunusual in a pattern. During the measurement, subjects were required
inreallifesituations.Designworkatthisstageofresearchcon- to fixate on a red small target that was displayed in the center
sisted of reducing the external size of the shield and material of the device and press the button whenever they see a white
tests.Particularlyimportantwasthereductionofthesizeofthe light in any parts of their visual field. Static field of view was
| elements | overlapping | the forehead | and cheeks. | The | modifica- |     |     |     |     |     |     |     |
| -------- | ----------- | ------------ | ----------- | --- | --------- | --- | --- | --- | --- | --- | --- | --- |
assessed.Eachmeasurementresultsinamapofpointsinwhich
subjectswereunabletoseethewhitelight,enablingqualitative
assessmentoftheimpactoftheshieldsand/orETframesonthe
observers’fieldofvisionandaidingfurtherimprovementstobe
implementedinthedesign.
Measurementswereperformedon12subjects(6malesand6
females;19–56yearsold),in3differentset-ups.Toensurethat
|     |     |     |     |     |     | subjects | have no | visible | impairment | (scotomas) |     | in their field |
| --- | --- | --- | --- | --- | --- | -------- | ------- | ------- | ---------- | ---------- | --- | -------------- |
ofvision,thefirstroundofvisualfieldmeasurementswasper-
|     |     |     |     |     |     | formed | on subjects’ | wearing | no  | additional | attachments | or any |
| --- | --- | --- | --- | --- | --- | ------ | ------------ | ------- | --- | ---------- | ----------- | ------ |
meansofvisioncorrections.Thereforeitwasassuredthatsub-
jectsareabletoseethetargetswithouttheirhabitualcorrections,
|     |     |     |     |     |     | which additionally |     | implies | that the | subjects’ | refractive | correc- |
| --- | --- | --- | --- | --- | --- | ------------------ | --- | ------- | -------- | --------- | ---------- | ------- |
tionwaslimitedtoapproximately4dioptresofmyopia.Subjects
whodidnotpassthispartofthetestwereexcluded.Thesecond
testwasperformedonsubjectswearingtheeye-trackingglasses
andthethirdmeasurementwasperformedwithanysubsequent
versionoftheshield(V1orFV).Eachofthesemeasurements
wasapproximately2.5minuteslong(dependingonthesubject’s
responsetime).Itisworthnotingthattheimpactoftheshieldor
eye-trackersonthesubject’sfieldofvision(staticfield)cannot
bedirectlyregardedasanimpactonthesubject’sfieldofview
|     |     |     |     |     |     | (when the   | eyes   | are moving). | Therefore | one      | cannot   | make clin- |
| --- | --- | --- | --- | --- | --- | ----------- | ------ | ------------ | --------- | -------- | -------- | ---------- |
|     |     |     |     |     |     | ical claims | on the | subjects     | fitness   | to drive | from the | results of |
theperimetrictestingshownbelow.Thisassessment,however,
|     |     |     |     |     |     | can be used | to quantitatively |               | assess      | the          | fit of the | shield or ET |
| --- | --- | --- | --- | --- | --- | ----------- | ----------------- | ------------- | ----------- | ------------ | ---------- | ------------ |
|     |     |     |     |     |     | glasses,    | allowing          | for objective | comparison. |              | In Fig.    | 7 we sum-    |
|     |     |     |     |     |     | marize the  | results           | of the        | perimetric  | measurements |            | performed    |
onthe12subjects.
|     |     |     |     |     |     | As we | can see | from the | examples | above | (Fig. 6A), | subjects |
| --- | --- | --- | --- | --- | --- | ----- | ------- | -------- | -------- | ----- | ---------- | -------- |
withoutanyadditionalopticalaidsmadeonlysomeminorerrors
Fig.6.Deviceappearanceandanalysisoftheperceptiondifferencein
intheEstermantest.Thesemistakeshoweverdonotqualifyas
apersonwearinganeyetracker:A–withouteyetracker,B–witheye
|     |     |     |     |     |     | clinically | significant | errors. | Therefore, |     | the group | of subjects |
| --- | --- | --- | --- | --- | --- | ---------- | ----------- | ------- | ---------- | --- | --------- | ----------- |
tracker,C–witheyetrackerandsunvisor,D–witheyetracker,sun
testedcouldbeincludedinfurtheranalysis.
visorandthedesignedshieldV1(firstversion),E–witheyetracker,sun
visorandthedesignedshieldFV(finalversion);1–femalesilhouette, As shown in Fig. 5B, the ET-glasses frame impacts both
|               |            |             |            |          |             | peripheral | temporal | parts | of the | field of | vision (75 | degrees on |
| ------------- | ---------- | ----------- | ---------- | -------- | ----------- | ---------- | -------- | ----- | ------ | -------- | ---------- | ---------- |
| frontal view, | 2 – female | silhouette, | side view, | 3 – male | silhouette, |            |          |       |        |          |            |            |
frontalview,4–malesilhouette,sideview theleftandontheright),andthischangecouldbeconsidered
6
Bull.Pol.Acad.Sci.Tech.Sci.,vol.73,no.6,p.e152709,2025

Enhancingmobileeye-trackinginextremeurbanlightingconditions
field of vision more than the final version including the ET
glasses and FV casing. This might be due to several technical
factorsthatcharacterizethisnewdesign,whichinclude:
• Asmentionedearlier,theinterchangeablenosepadsofthe
ETglassesprovidedbythemanufacturerdonotfitallsub-
jectswithdiversefacialfeaturesandnosestructuresandin
thesesubjectsglassesmaybeslidingoffevenwhensecured
with the strap. Application of the nose pads additionally
increasesthevertexdistance,whichwasshowntobeapa-
rameterthatnarrowsthefieldofvision.
• TherubbercollarsaroundthecasingofFVmakethecasing
sit more stably on the nose, rest higher on the face and
preventitfromslidingoff,whichresultedinlessimpacton
the upper and lower portion of the field of vision in those
subjects.
Fig.7.Summaryofperimetricmeasurementsforthegroupof12sub- • Additionally,FVdoesnotobscurethetemporalpartsofthe
jects.Colorandnumberswritteninbracketscorrespondwiththenum-
fieldofvisionwhileV1does.Thispartofthefieldofvision
berofsubjectsthatdidnotseethecorrespondingpointintheirfield
is already covered by the transparent anti-glare attachment
of vision. A – measurements without any optical aids on B – mea-
providedbythemanufacturer.
surementswitheyetrackerglasseson;C–measurementswithETand
• Itwasshownthatthespectacleframemayhavelessimpact
shieldV1;D–measurementswithETandshieldFV
on the field of vision in subjects with larger pupils [28].
Theincreaseinpupildiametercausedbyadecreaseinthe
clinicallyrelevantifthetestwasperformedforthepurposesof amountoflightreachingtheeyecouldaddtotheobserved
licensingGroup1carandmotorcycledrivingintheUK. differences in the field of vision. This may also provide a
This is most probably caused by the temples of ET-glasses validreasonforprescribingtintsfordaytimedriving.
coveringalargerportionofthispartofthefieldofvision.Some • TheFVframeisthinnerthanthatofV1,obscuringsmaller
subjects display errors in their upper field of vision, which is areasinthefieldofvision.
mostprobablyduetotheglassesslidingdownorsittinglower • FV is placed closer to the face than all the other solutions
on the nose. This points to the fact that even with the inter- applied,andthedecreasedvertexdistanceenablesawider,
changeable nose pads of different sizes, that are provided by unobstructedfieldofvision.
the manufacturer, the ET-glasses frame cannot be firmly fitted TheET-glasses framedoes notallow adjustingtheframe to
and secured in all subjects or it sits lower on the nose due to thesubject’sinterpupillarydistance(PD),whichwouldfurther
individual anatomical features of the subjects’ face structure. improve the field of view in some subjects with smaller faces.
Additionally, the nose pads make the ET glasses move further TakingintoaccounttheimpactofFVonthefieldofvision,no
awayfromthewearer’sface(increasingthevertexdistance),and furtherimprovementsinthedesignoftheshieldwereadvised,
this results in the frame being more visible as it moves to the resultinginthefinalversionoftheshielddesign.
central parts of the field of vision. The full set of attachments
installed(V1)impactedbothverticalandhorizontalmeridians
intheexternalpartsofthesubjects’fieldofvision(Fig.6C).In 5. DISCUSSIONANDCONCLUSIONS
thecaseofV1,theimpactofthecoverwaslargerthanthatofthe Theideaandtheoperatingprincipleoftheshieldhavebeensub-
ETglasses,whichismostprobablycausedbythetemporalparts mittedasaninvention–ApplicationWIPOST10/CPL447199.
oftheshieldcoveringasubstantialpartofthefieldofvisionin Inthecaseoffurtherdevelopment,materialstrengthtestsofFV
ahorizontalmeridian.Additionally,becauseofthepaddingin- should be conducted. The shield, even when damaged, should
stalledintheV1,thecushioningactionmakesitmoredifficult notcreatesharpedgesorfragments.Additionally,theideaofthe
tofirmlyattachthesettothesubject’sface.Softpaddinginthe shield can be adapted to eye trackers of other brands. Various
temporalpartoftheshieldcoveredthefieldofviewinthehor- mountingoptionsshouldbeprovidedforindividualmodelsand
izontal meridian comparable with ET glasses. The V1 version addingaglasstintedcovershouldbeconsideredformodelsthat
of the shield must be more firmly attached with the strap and donotoriginallyhavesuchasolutionprovided.
supportedbyextranosepaddingtopreventitfromslidingdown Although data show that pupil diameter measurements vary
fromthesubject’sfaceandcoveringtheupperandlowerfieldof widelywithouttheshieldandthosewiththeshieldinplaceap-
view.TakingtheimpactoftheV1shieldonthesubjects’field pear to be much more in line with expectations, there is still a
ofvision,improvementsweremadeandanotherversionofthe needforfuturetestingoftheimpactoftheshieldoneyetracker
shieldwasdesignedandmanufactured. accuracy.Thisisbecausethemethodofcamera-basedeyetrack-
As predicted, the FV shield impacted the field of vision in ers typically relies on estimation of pupil center in relation to
both horizontal and vertical meridians and its impact on the cornealreflectionsofthenear-IRlightsources,anditisnotclear
subjects’ field of vision is lower than that of V1 (Fig. 6D). howchangesinpupildiametermightaffectestimationofpupil
What’s interesting is the fact that ET itself seems to limit the center.Itmaybethatthecenteroftheellipsethatistypicallyfit
Bull.Pol.Acad.Sci.Tech.Sci.,vol.73,no.6,p.e152709,2025 7

M.Rusnak,Z.Koszewicz,F.Hackemer,I.Garaszczuk,A.T.Duchowski,andR.Karnicki
tothepupillimbusisunchangedbutthisrequiresfurthertesting inSports:ASystematicReviewof40YearsofResearch,”Front.
ofeyetrackeraccuracyandprecision,i.e.avalidationstudyis Psychol.,vol.8,2017,doi:10.3389/fpsyg.2017.01845.
plannedasfuturework. [3] J. Lien and S. Dupont, “Analyzing the perception of wa-
The shield designed and presented by our interdisciplinary ter surfaces in urban landscapes using eye-tracking,” in IALE
team enables conducting studies in urban and landscape envi- Europe 2013, 2013, Available: https://iale2013.eu/analyzing-
ronmentsusingtheTobiiGlasses3eyetrackerevenoncloudless, perception-water-surfaces-urban-landscapes-using-eye-tracking
very sunny days, near bright and light-reflecting objects. This [Accessed19.11.2024].
expandsthepossibilitiesofusingeyetrackingforscientificand [4] T. Imabuchi, O.D.A. Prima, and H. Ito, “Visible spectrum eye
commercialresearch.Italsoenablesbroaderapplicationsinso- tracking for safety driving assistance,” in Trends in Applied
Knowledge-BasedSystemsandDataScience.IEA/AIE2016.Lec-
calledlivinglabs.Potentialnewapplicationsinclude:research
tureNotesinComputerScience,2016,vol.9799,pp.428–434,
near or on water (sea, lake, river); studies of athletes outdoors
doi:10.1007/978-3-319-42007-3_37.
(horseback riding, tennis, skiing); studies at different times of
[5] M.Mokatren,T.Kuflik,andI.Shimshoni,“Exploringthepoten-
theday(morning,sunset).
tialofamobileeyetrackerasanintuitiveindoorpointingdevice:
Strengthsofthefinalsolutioninclude:
Acasestudyinculturalheritage,”Futur.Gener.Comp.Syst.,vol.
• smallsizeandweight;easyassemblyanddisassembly;
81,pp.528–541,2018,doi:10.1016/j.future.2017.07.007.
• effectivecalibration,possiblenotonlyinshadedareas;
[6] F.Jungwirth,M.Murauer,M.Haslgrübler,andA.Ferscha,“Eyes
• significantimprovementindatacollectedinfullysunlitlo-
aredifferentthanHands:AnAnalysisofGazeasInputModality
cations;
forIndustrialMan-MachineInteractions,”inProc.11thPETRA
• eliminationofreflectionsoccurringontheinnersideofET
Conf.,2018,pp.303–310,doi:10.1145/3197768.320156.
lenses;
[7] J.S.Matthis,J.L.Yates,andM.M.Hayhoe,“GazeandtheCon-
• possibilityofDIYproductionandlowcost.
trolofFootPlacementWhenWalkinginNaturalTerrain,”Curr.
The project meets almost all the assumptions arising from the
Biol.,vol.28,no.8,pp.1224–1233.e5,2018,doi:10.1016/j.cub.
initialneedsanalysis;however,furtheruseandtestinghaveiden- 2018.03.008.
tifiedadditionaldesignchallenges:increaseddimensionsofthe
[8] P.Konstantopoulos,P.Chapman,andD.Crundall,“Driver’svi-
eye tracker; extended study time because of the need for dis-
sualattentionasafunctionofdrivingexperienceandvisibility.
infection; increased risk of an accident while driving (limited Usingadrivingsimulatortoexploredrivers’eyemovementsin
fieldofview;theadditionalframemaycauselensfogging). day, night and rain driving,” Accid. Anal. Prev., vol. 42, no. 3,
In everyday life, we increasingly use optical solutions such pp.827–834,2010.doi:10.1016/j.aap.2009.09.022.
as lenses with filters or variable transparency, tailored to in- [9] A.Mantuano,S.Bernardi,andF.Rupi,“Cyclistgazebehaviorin
dividual vision protection needs. A similar approach could be urbanspace:Aneye-trackingexperimentonthebicyclenetwork
consideredforETtechnology,particularlyinthecontextofdy- ofBologna,”CaseStud.Transp.Policy,vol.5,no.2,pp.408–416,
namicallychanginglightingconditionsinurbanenvironments. 2017,doi:10.1016/J.CSTP.2016.06.001.
People,astheymove,changepositions,enterorexitbuildings [10] J.Wang,M.Liang,andP.-C.Liao,“Towardanintuitivedevice
orvehicles,areconstantlyexposedtofluctuationsinbothnatu- forconstructionhazardrecognitionmanagement:Eyefixation–
ralandartificiallighting.Inthefuture,researchonmobileET related potentials in reinvestigation of hazard recognition per-
systemsshouldfocusonverifyingthereliabilityofdatacollec- formanceprediction,”J.Constr.Eng.Manage.,vol.150,no.5,
p.105674,2024,doi:10.1061/JCEMD4.COENG-13675.
tionunderlow-lightconditions,whichrequirestheuseofnew
typesofscenecameras.Additionally,implementingintelligent [11] T.Schweizer,T.Wyss,andR.Gilgen-Ammann,“DetectingSol-
diers’FatigueUsingEye-TrackingGlasses:PracticalFieldAp-
coatingsandparallelimagerecordingwithcamerasofvarious
plicationsandResearchOpportunities,”Milit.Med.,vol.187,pp.
technical specifications will be essential. A critical task will
E1330–E1337,2022,doi:10.1093/milmed/usab032.
betoassesshowtheseinnovationsimpactdataqualityandex-
[12] K.Evans,R.Jacobs,J.Tarduno,andJ.B.Pelz,“Collectingand
perimental outcomes. Another challenge for ET technology is
analyzing eye-tracking data in outdoor environments,” J. Eye
conductingstudiesduringtherain,influctuatingtemperatures,
Mov.Res.,vol.5,no.2,p.6,2012,doi:10.16910/jemr.5.2.6.
or in high humidity, which can lead to equipment fogging and
[13] J.A. Yamin Garretón, R.G. Rodriguez, A. Ruiz, and A.E. Pat-
malfunction. Addressing these difficulties calls for an expan-
tini,“Degreeofeyeopening:Anewdiscomfortglareindicator,”
sion of available accessories and dynamic, close collaboration
Build.Environ.,vol.88,pp.142–150,2015,doi:10.1016/j.build
between equipment manufacturers and the scientific commu-
env.2014.11.010.
nity.OnlythroughsucheffortscanETtechnologybeeffectively
[14] T.Schweizer,T.Wyss,andR.Gilgen-Ammann,“EyeblinkDetec-
developedandadaptedtotherealitiesofeverydaylifeandsci-
tionintheField:AProofofConceptStudyofTwoMobileOptical
entificresearch.
Eye-Trackers,”Milit.Med.,vol.187,pp.e404–e409,2021,doi:
10.1093/milmed/usab032.
[15] A.Armato,A.Lanatà,andE.P.Scilingo,“Comparativestudyon
REFERENCES
photometricnormalizationalgorithmsforaninnovative,robust
[1] A.T. Duchowski, Eye tracking methodology. Theory and prac- and real-time eye gaze tracker,” J. Real-Time Image Process.,
tice.,Springer-Verlag,2007. vol.8,no.1,pp.21–33,2013.
[2] R.Kredel,C.Vater,A.Klostermann,andE.-J.Hossner,“Eye- [16] P.Kiefer,I.Giannopoulos,andM.Raubal,“WhereAmI?Inves-
TrackingTechnologyandtheDynamicsofNaturalGazeBehavior tigating Map Matching During Self-Localization With Mobile
8 Bull.Pol.Acad.Sci.Tech.Sci.,vol.73,no.6,p.e152709,2025

Enhancingmobileeye-trackinginextremeurbanlightingconditions
Eye Tracking in an Urban Environment,” Trans. GIS, vol. 18, PlantsinUrbanGreenSpace:AnEye-TrackingStudy,”Forests,
no.5,pp.660–686,2014,doi:10.1111/tgis.12067. vol.13,no.11,p.1871,2022,doi:10.3390/f13111871.
[17] J.Simpson,M.Freeth,K.J.Simpson,andK.Thwaites,“Visual [23] L.-M.Zhang,R.-X.Zhang,T.-S.Jeng,andZ.-Y.Zeng,“Cityscape
engagementwithurbanstreetedges:insightsusingmobileeye- protectionusingVRandeyetrackingtechnology,”J.Vis.Com-
tracking,”J.Urban.-Int.Res.Placemak.UrbanSustain.,vol.12, mun.ImageRepresent.,vol.64,p.102639,2019,doi:10.1016/
no.3,pp.259–278,2019,doi:10.1080/17549175.2018.1552884. j.jvcir.2019.102639.
[18] X.Jiang,J.Li,andB.Yang,“Luminanceandsaliencyhaveim- [24] K.Binaee,C.Sinnott,K.J.Capurro,P.Macneilage,andM.D.Le-
pactonpedestrians’fixationdistributionduringnaturalwalking: scroart, “Pupil Tracking under Direct Sunlight,” Eye Track-
Evidencefrommobileeye-tracker,”Light.Res.Technol.,vol.53, ing Research and Applications Symposium (ETRA), 2021, doi:
no.4,pp.359–372,2020,doi:10.1177/1477153520968158. 10.1145/3450341.3458490.
[19] L.Chelazzi,F.Marini,D.Pascucci,andM.Turatto,“Gettingrid [25] Tobii.[Online] Available: https://www.tobii.com/products[Ac-
ofvisualdistractors:thewhy,when,how,andwhere,”Curr.Opin. cessed:19.11.2024].
Psychol., vol. 29, pp. 135–147, 2019, doi: 10.1016/j.copsyc. [26] V. Onkhar, D. Dodou, and J. de Winter, “Evaluating the Tobii
2019.02.004. Pro Glasses 2 and 3 in static and dynamic conditions,” Behav.
[20] L.A.delaFuenteSuárez,“Subjectiveexperienceandvisualat- Res.Methods,vol.56,no.5,pp.4221–4238,2024.doi:10.3758/
tentiontoahistoricbuilding:Areal-worldeye-trackingstudy,” s13428-023-02173-7.
Front.Archit.Res.,vol.9,no.4,pp.774–804,2020,doi:10.1016/ [27] M. Rusnak et al., “Eye-Tracking Research on the Panorama of
J.FOAR.2020.07.006. Ostrow Tumski – Pilot Study,” RepOD, 2023, doi: 10.18150/
[21] Y. Liu, Z. Zhou, and Y. Xu, “Design Element Preferences in RK7JQH.
PublicFacilities:AnEyeTrackingStudy,”Land,vol.12,no.7, [28] S.Steel,S.W.Mackie,andG.Walsh,“Visualfielddefectsdueto
p.1411,2023,doi:10.3390/land12071411. spectacleframes:TheirpredictionandrelationshiptoUKdriving
[22] J.Zheng,Y.Huang,Y.Chen,L.Guan,andQ.Liu,“Subjective standards,”OphthalmicPhysiol.Opt.,vol.16,no.2,pp.95–100,
PreferenceandVisualAttentiontotheAttributesofOrnamental 1996,doi:10.1016/0275-5408(95)00026-7.
Bull.Pol.Acad.Sci.Tech.Sci.,vol.73,no.6,p.e152709,2025 9
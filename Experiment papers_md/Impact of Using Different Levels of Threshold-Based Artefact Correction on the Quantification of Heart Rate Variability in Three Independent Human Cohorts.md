Journal of
Clinical Medicine
Article
ff
Impact of Using Di erent Levels of Threshold-Based
Artefact Correction on the Quantification of Heart
Rate Variability in Three Independent
Human Cohorts
JuanM.A.Alcantara1,*,† ,AbelPlaza-Florido1,† ,FranciscoJ.Amaro-Gahete1,2 ,
FranciscoM.Acosta1,JairoH.Migueles1,PabloMolina-Garcia1,3,JerzySacha4,5 ,
GuillermoSanchez-Delgado1,6andBorjaMartinez-Tellez7
1 PROFITH“PROmotingFITnessandHealthThroughPhysicalActivity”ResearchGroup,SportandHealth
UniversityResearchInstitute(iMUDS),DepartmentofPhysicalandSportsEducation,FacultyofSport
Sciences,UniversityofGranada,18011Granada,Spain;abeladrian@ugr.es(A.P.-F.);
amarof@ugr.es(F.J.A.-G.);acostaf@ugr.es(F.M.A.);jairohm@ugr.es(J.H.M.);pablomolinag5@ugr.es(P.M.-G.);
gsanchezdelgado@ugr.es(G.S.-D.)
2 EFFECTS-262ResearchGroup,DepartmentofPhysiology,SchoolofMedicine,UniversityofGranada,
18071Granada,Spain
3 DepartmentofRehabilitationSciences,KULeuven,UniversityofLeuven,3000Leuven,Belgium
4 FacultyofPhysicalEducationandPhysiotherapy,OpoleUniversityofTechnology,45-758Opole,Poland;
sacha@op.pl
5 DepartmentofCardiology,UniversityHospitalinOpole,UniversityofOpole,45-401Opole,Poland
6 PenningtonBiomedicalResearchCenter,BatonRouge,LA70808,USA
7 DepartmentofMedicine,divisionofEndocrinology,andEinthovenLaboratoryforExperimentalVascular
Medicine,LeidenUniversityMedicalCenter,2333Leiden,TheNetherlands;borjammt@gmail.com
* Correspondence: alcantarajma@ugr.es;Tel.:+34-958-244-353
† Theseauthorshavemadeanequalcontribution.
(cid:1)(cid:2)(cid:3)(cid:1)(cid:4)(cid:5)(cid:6)(cid:7)(cid:8)(cid:1)
(cid:1)(cid:2)(cid:3)(cid:4)(cid:5)(cid:6)(cid:7)
Received: 23December2019;Accepted: 21January2020;Published: 23January2020
Abstract: Heart rate variability (HRV) is a non-invasive indicator of autonomic nervous system
function. HRV recordings show artefacts due to technical and/or biological issues. The Kubios
software is one of the most used software to process HRV recordings, offering different levels of
threshold-basedartefactcorrection(i.e.,Kubiosfilters). Theaimofthestudywastoanalyzetheimpact
ofdifferentKubiosfiltersonthequantificationofHRVderivedparametersfromshort-termrecordings
inthreeindependenthumancohorts. Atotalof312participantswereincluded: 107childrenwith
overweight/obesity(10.0±1.1years,58%men),132youngadults(22.2±2.2years,33%men)and73
middle-agedadults(53.6±5.2years,48%men). HRVwasassessedusingaheartratemonitorduring
10–15min,andtheKubiossoftwarewasusedforHRVdataprocessingusingalltheKubiosfilters
available(i.e.,6). Repeated-measuresanalysisofvarianceindicatedsignificantdifferencesinHRV
derivedparametersinthetime-domain(allp<0.001)acrosstheKubiosfiltersinallcohorts,moreover
similarresultswereobservedinthefrequency-domain. WhencomparingtwoextremeKubiosfilters,
thesestatisticaldifferencescouldbeclinicallyrelevant,e.g. morethan10msinthestandarddeviation
ofallnormalR-Rintervals(SDNN).Inconclusion,theresultsofthepresentstudysuggestthatthe
applicationofdifferentKubiosfiltershadasignificantimpactonHRVderivedparametersobtained
fromshort-termrecordingsinbothtimeandfrequency-domains.
Keywords: Kubiossoftware;autonomicnervoussystem;dataprocessing;children;youngadults;
middle-agedadults
J.Clin.Med.2020,9,325;doi:10.3390/jcm9020325 www.mdpi.com/journal/jcm

J.Clin.Med.2020,9,325 2of11
1. Introduction
Heart rate variability (HRV) refers to the variation of the time interval between R peaks
(i.e.,heartbeats)registeredinanelectrocardiogram(ECG)[1]. Previousstudieshaveshownthatalow
HRVatrestingconditionsreflectsalowmodulationoftheparasympatheticbranchonthesino-auricular
node[1,2],whichisconsideredanindicatorofcardiovascularandmortalityrisk[1–4]. Furthermore,
ithasbeenpreviouslyreportedthatHRVdecreaseswithageing[5,6],especiallyinmiddle-agedadults
regardlessofgender[6]. BeyondECG,HRVcanbeestimatedwithcertainheartratemonitors,which
makestheHRVassessmentmorefeasible(i.e.,lessintrusiveandeconomicallyaffordable).
HRVrecordingsusingheartratemonitorsareaffectedbytechnical(e.g., wrongplacementof
theheartratemonitor’sband)and/orbiological(e.g.,ectopicbeats)artefacts. Theseartefactscould
contaminatetheHRVrecordings,makingitdifficulttoobtainHRVderivedparametersfromlong-term
(≈24h)andespeciallyshort-term(≈5min)recordings[1,7,8]. Artefactscouldmodifyandproduce
importantover-orunder-estimationofHRVderivedparameters(upto50%)[9]. Therefore,correction
ofartefactsbeforetheHRVassessmentisneededfortheaccuratedeterminationofHRVparameters
derivedfromshort-termrecordings.
DifferentcommerciallyavailablesoftwarehavebeendevelopedtoprocessHRVrawdata[10].
TheKubiossoftware[11,12]isoneofthemost-frequentlyusedinbothclinicalandresearchsettings.
Itallowstheuseofdifferentthreshold-basedartefactcorrectionfilters(henceforth“Kubiosfilters”)[11].
The Kubios filter selection is usually based on subjective decisions since there is no consensus on
whatisthemostappropriateKubiosfiltertoprocessHRVrawdata. Toourknowledge,thereisonly
onestudyinvestigatingtheimpactofdifferentKubiosfiltersonthequantificationofHRVderived
parametersfromshort-termrecordings[13]. Inthisstudy,Arandaetal. showedthattheselectionof
themostrestrictivefilterhadanoticeablyimpactonthequantificationofHRVderivedparameters
comparedwiththelessrestrictivefilterinhigh-levelprofessionalathletes[13]. SinceHRVdepends
onawiderangeofbiologicalcharacteristics(e.g.,ageorbodycomposition)[14],thereisaneedof
determiningtheimpactofusingdifferentKubiosfiltersonHRVderivedparametersestimationin
differentpopulations[13]. Thus,thisstudyaimedtoanalyzetheimpactofdifferentKubiosfilterson
thequantificationofHRVderivedparametersfromshort-termrecordingsinsedentarychildrenwith
overweight/obesity,sedentaryyoungandsedentarymiddle-agedadults.
2. ExperimentalSection
2.1. Participants
ThepresentstudyincludedbaselinedatafromtheActiveBrains[15],theACTIBATE[16]and
theFIT-AGEING[17]studies. Atotalof312participantswereincludedinthiscross-sectionalstudy:
107 sedentary children (ActiveBrains) with overweight/obesity [15], 132 sedentary young adults
(ACTIBATE)[16]and, 73sedentarymiddle-agedadults(FIT-AGEING)[17]. Detailedinformation
aboutthemethodology,inclusionandexclusioncriteriaoftheaforementionedstudiescanbefound
elsewhere[15–17]. Briefly,theinclusioncriteriawere: (1)beingphysicallyinactive;(2)havingastable
bodyweight; (3)notbeingenrolledinaweightlossprogram; (4)notbeingasmokers; and(5)not
beingpregnant.
AllstudieswereconductedaccordingtotheCommitteeforResearchInvolvingHumanSubjects
attheUniversityofGranada(References#848and#924fortheActiveBrainsandACTIBATEstudies,
respectively),ServicioAndaluzdeSalud(CentrodeGranada,CEI-GranadafortheACTIBATEstudy)and
theHumanResearchEthicsCommitteeoftheJuntadeAndalucia(0838-N-2017)fortheFIT-AGEING
study. AllofthemwereperformedinaccordancewiththeDeclarationofHelsinki(revisionof2013)and
registeredinaspecificclinicaltrialdatabase(i.e.,Clinicaltrial.gov. IDs: NCT02295072,NCT02365129
andNCT03334357fortheActiveBrains,ACTIBATEandFIT-AGEINGstudy,respectively). Both,oral
andwritteninformedconsentwereobtainedfromalltheparticipantsandthechildrenparentsbefore

J.Clin.Med.2020,9,325 3of11
J. Clin. Med. 2020, 9, 325 3 of 11
theirenrollment. Althoughtheparticipantswereenrolledintheaforementionedmainstudies,allof
aforementioned main studies, all of them agreed to transfer their scientific data for other scientific
themagreedtotransfertheirscientificdataforotherscientificpurposesorresearchstudies.
purposes or research studies.
2.2. HeartRateVariabilityAssessment
2.2. Heart Rate Variability Assessment
Participantscameinthemorningtotheresearchcentrebycarorbybus,avoidinganyphysical
Participants came in the morning to the research centre by car or by bus, avoiding any physical
activity before the HRV assessment. Measurements took place between 8 AM and 12 PM for the
activity before the HRV assessment. Measurements took place between 8 AM and 12 PM for the
ActiveBrainsstudy,andbetween8and9AMforboth,theACTIBATEandtheFIT-AGEINGstudies.
ActiveBrains study, and between 8 and 9 AM for both, the ACTIBATE and the FIT‐AGEING studies.
Onceintheresearchcentre,participantslayonabedorastretcherinsupinepositionequippedwitha
Once in the research centre, participants lay on a bed or a stretcher in supine position equipped with
PolarRS800CXheartratemonitor(PolarElectroOyInc.,Kempele,Finland)inaquietroomwithdim
a Polar RS800CX heart rate monitor (Polar Electro Oy Inc., Kempele, Finland) in a quiet room with
lighting(forallthestudies),andcontrolledambienttemperatureandhumidity(fortheACTIBATE
dim lighting (for all the studies), and controlled ambient temperature and humidity (for the
anAdCthTeIBFAITT-EA aGnEdI tNhGe FsItTu‐dAiGesE)I.NHGe asrtutdrhieyst)h. mHewarats rhreyctohrmd ewdads urercinorgd1e0d– d15urminign 1(0s–a1m5p mliinng (sfaremqpuleinngc yof
10f0r0eqHuze)n.cBy eoffo 1r0e0s0u Hchz)a. Breefcoorred siuncgh, ap raerctoicridpianng,t spawrteirceipiannsttsr uwcetreed intostrburcetaetdh eton borremathalel yn,oarnmdalnlyo,t atnodt alk,
fidngoett ,too rtasllke,e pfidwgheti,l eomr selaeesup rwemhielen tmsweaesruerebmeienngtst awkeerne (bFeiignugr eta1k)e.nO (fFnigoutree, t1h)e. OPof lnaortRe,S t8h0e0 CPoXlahre art
ratReSm80o0nCiXto hrehaarst braeteen mvaolniditoarte hdaasg baeinenst vealelicdtarotecda radgiaoignrsat pehleyc,taroncdaradlsiooghraapshbye,e annpdr oavlseod haass abreeelnia ble
eqpuriopvmeden atsi an rtehleiaabsles eesqsumipemnteonft iHn RthVe ianssbeostshmcehnitl dofr eHnR[V18 i,n1 9b]oathn dchaidldurletns [[1280,,1291]] .and adults [20,21].
Figure1. Studydesign. HRV:heartratevariability. None(A),VeryLow(B),Low(C),Medium(D),
Figure 1. Study design. HRV: heart rate variability. None (A), Very Low (B), Low (C), Medium (D),
Strong(E)andVeryStrong(F)filtersreferstothelevelofthreshold-basedartefactcorrection(i.e.,Kubios
Strong (E) and Very Strong (F) filters refers to the level of threshold‐based artefact correction (i.e.,
filter). Graphsareexamplesofthesamebest5minperiod(ofthewholeheartrhythmrecoding)that
Kubios filter). Graphs are examples of the same best 5 min period (of the whole heart rhythm
mettheselectioncriteriaafterusingdifferentKubiosfilters. RR:R-Rintervals;S:seconds;min:minutes.
recoding) that met the selection criteria after using different Kubios filters. RR: R‐R intervals; S:
seconds; min: minutes.
2.3. HeartRateVariabilityDataProcessing
2.3.F Horeatrht eRHatRe VVadriaabtailiptyr oDcaetsas Pinrogcewsseinugs edtheKubiossoftware(v.3.0.0,HRVanalysis,Universityof
EasternFinland)[11,12]. Thebest5minperiodofthewholeheartrhythmrecordingwasmanually
For the HRV data processing we used the Kubios software (v.3.0.0, HRV analysis, University of
selectedbyoneevaluatorbasedonthefollowingcriteria: (1)GaussiansR-Rintervalsandheartrate
Eastern Finland) [11,12]. The best 5 min period of the whole heart rhythm recording was manually
distributiongraphs;(2)nolargeR-Rintervaloutliers;and(3)R-Rintervalsequidistance[22–24]. The
selected by one evaluator based on the following criteria: (1) Gaussians R‐R intervals and heart rate
R-dRisitnrtiebruvtiaolns sgerraipehssw; (e2r)e ndoe ltarregned Re‐dRu insitnergvtahl eousmtlieorost;h anneds s(3p) rRio‐Rr minteetrhvoadls weqituhidailsptahnacsee [t2a2–t2540]0. .The
R‐RA ilnltKeruvbailoss sfierltieesr wlevereel sd(ei.tere.,ntdhereds uhsoilndg- bthasee sdmaorotethfancetscso prrrieocrt imone;thFoigdu wreit1h) awlpehrea useste dato 5n00th. eselected
5-min Apellr iKodubsi[o2s5 f]i.ltTerh elevKeulsb i(oi.se.fi, lttherresahlgooldr‐ibthasmedc oamrtepfaacrte scoervreercytioRn-;R Fiignuterrev 1a)l wvaelruee uasgedai nosnt tahelo cal
avseerlaegcteedin 5te‐mrvianl p[2e5ri]o.dTsh [e25lo].c Tahlea vKeurbaigoes ifniltteerrv aalgloisripthromc ucoremdpbayrems eevdeirayn Rfi‐lRte irnitnegrvtahle vRal-uRe iangtearinvsatl at ime
serloiecsa,l aavnedratghee rineftoerrvea,lt h[2e5]l.o Tchael alovcearla agveeriasgneo itntienrflvuale insc perdocbuyreodu btlyi emrsedRi-aRn fiinltteerrivnagl sth.eT Rh‐uRs i,nitfetrhvealR -R
intteimrvea slevriaersi,e asnfdro thmertehfeorleo,c tahlea lvocearla agveeirnatgeer visa nlomt ionrfelutehnacneda bsyp eocuitfilieedrst Rh‐rRes ihnotelrdvvalasl.u Teh,utsh,e ifi nthtee rRv‐alis
deRsi ignnteartvedal avsarainesa frrtoemfa cthtea nlodcaml aavrkereadgefo irntceorrvraelc mtioonreb tyhatnh ea ssopfetcwifaierde t[h25re].shTohlde avvalauilea, bthlee Kinutebrivoasl fiisl ters
are: (1)None(nocorrectionisperformed;Figure1A),(2)VeryLow(0.45s;Figure1B),(3)Low(0.35;

J.Clin.Med.2020,9,325 4of11
Figure1C),(4)Medium(0.25s;Figure1D),(5)Strong(0.15s;Figure1E)and,(6)VeryStrong(0.05s;
Figure1F)[25]. Forexample,ifaVeryLowKubiosfilterisused,thesoftwaremarksforcorrectionall
R-Rintervalsthatare0.45slargerorsmallerthanthelocalaverageinterval. Then,theseartefactsare
subsequentlyinterpolatedusingacubicsplineinterpolation.
In the present study, we considered the most-frequently used HRV derived parameters from
short-termrecordingsinbothtimeandfrequencydomains. Inthetime-domain,wecomputed(1)the
standarddeviationofallnormalR-Rintervals(SDNN)inmilliseconds(ms),(2)thesquaredrootofthe
meanofthesumofthesquaresofsuccessivenormalR–Rintervaldifferences(RMSSD)inms,and(3)the
numberofpairsofadjacentnormalR-Rintervalsdifferingbymorethan50msintheentirerecording
(pNN50)expressedaspercentage. Regardingthefrequency-domain,wederived(1)thepowerinthe
highfrequency(HF:0.15–0.4Hertz(Hz)),(2)thepowerinthelowfrequency(LF:0.04–0.15Hz),and(3)
thepowerintheverylowfrequency(VLF:0–0.04Hz)usingthefastFouriertransformationalgorithm
(FFT),allexpressedinabsoluteunits(ms2). TheLF/HFratiowasalsocalculated.
2.4. AnthropometricAssessment
Wemeasuredtheparticipants’heightandbodyweightwithoutshoesandwithlightclothing
usingaSecascale(model799,ElectronicColumnScale,Hamburg,Germany)andastadiometer. Body
massindex(BMI)wascalculatedasbodyweight(kg)dividedbysquareheight(m2). Childrenwere
classifiedaschildrenwithoverweight/obesityaccordinglytotheWorldObesityFederationsex-and-age
specificinternationalBMIstandards[26]. Waistcircumferencewasmeasuredtwice, inastanding
position, and using a plastic tape at the midpoint between the costal margin and iliac crest in the
mid-axillaryline[27]. Theaverageofbothmeasurementswasused.
2.5. StatisticalAnalysis
Descriptive data are presented as means ± standard deviation or frequency and percentages
as appropriate. Normality of the HRV derived parameters in time- and frequency-domains were
testedusingKolmogorov-Smirnovtestandvisualinspectionofhistograms. AlthoughHRVderived
parametersdidnotexhibitanormaldistribution,foranalyticalpurposeswedidnottransformthem.
Repeated-measureanalysesofvariance(ANOVA)wereusedtotestdifferencesinHRVderived
parametersintime-andfrequency-domainsacrossthedifferentKubiosfilters(i.e.,None,VeryLow,Low,
Medium,StrongandVeryStrong). Analyseswerereplicatedwiththenon-parametricFriedmantest
andsimilarresultswerefound,andtherefore,onlyANOVAresultsarereported. Bonferronicorrections
wereusedforpost-hoccomparisons. AnalyseswereconductedusingtheStatisticalPackageforSocial
Sciences(SPSS,v. 22.0,IBMSPSSStatistics,IBMCorporation,Chicago,IL,USA).Thesignificancelevel
wassetat0.05.
3. Results
ThedescriptivecharacteristicsoftheparticipantsarepresentedinTable1. Thepercentagesof
R-Rintervalsinterpolatedduringthewholerecordingandduringtheselectedbest5minperiodfor
dataanalysisareshowninTable2. ThemeanofinterpolatedR-Rintervalsacrossstudieswere0.3,
0.7,1.6,4.9and29.9%whentheVeryLow,Low,Medium,StrongandVeryStrongfilterswereused
respectively(Table2). Moreover,weperformedavisualinspectionoftheR-Rsignals(FigureS1)for
detectingpossibleprematurecontractions(characterizedbyshort-longR-Rintervals,i.e. coupling
intervalandcompensatorypause)andwedidnotobserveprematurecontractionsinthemostofthe
R-Rsignalsbasedontheobservercriteria.

| J.Clin.Med.2020,9,325 |     |     |         |                                   |     |                    |     |     |                         |     |     | 5of11 |
| --------------------- | --- | --- | ------- | --------------------------------- | --- | ------------------ | --- | --- | ----------------------- | --- | --- | ----- |
|                       |     |     | Table1. | Descriptivedataoftheparticipants. |     |                    |     |     |                         |     |     |       |
|                       |     |     |         | Children(n=107)                   |     | YoungAdults(n=132) |     |     | Middle-AgedAdults(n=73) |     |     |       |
|                       |     |     |         | n                                 |     | % n                |     | %   | n                       |     | %   |       |
Sex
|     |                        | Male       |     | 60   |     | 57.1 43  |     | 32.6 | 35   |     | 47.9 |     |
| --- | ---------------------- | ---------- | --- | ---- | --- | -------- | --- | ---- | ---- | --- | ---- | --- |
|     |                        | Female     |     | 45   |     | 42.9 89  |     | 67.4 | 38   |     | 52.1 |     |
|     |                        |            |     | Mean | ±   | SD Mean  | ±   | SD   | Mean | ±   | SD   |     |
|     |                        | Age(years) |     | 10   | ±   | 1 22     | ±   | 2    | 54   | ±   | 5    |     |
|     | Bodymassindex(kg/m2)   |            |     |      | ±   |          | ±   |      |      | ±   |      |     |
|     |                        |            |     | 26.9 |     | 3.7 25.0 |     | 4.8  | 26.7 |     | 3.8  |     |
|     | Waistcircumference(cm) |            |     | 90.2 | ±   | 9.9 81.6 | ±   | 14.6 | 95.0 | ±   | 11.8 |     |
Dataarepresentedasmeanandstandarddeviation(SD)unlessotherwisestated.
Table2. PercentageofR-Rintervalsinterpolatedintheheartratevariability(HRV)measurements
whenusingdifferentKubiosfilter.
|     |     |     | Children(n=107) |      |         | YoungAdults(n=132) |      |     | Middle-AgedAdults(n=73) |      |         |     |
| --- | --- | --- | --------------- | ---- | ------- | ------------------ | ---- | --- | ----------------------- | ---- | ------- | --- |
|     |     |     | Mean            | ± SD | Min Max | Mean               | ± SD | Min | Max Mean                | ± SD | Min Max |     |
Beatscorrected(%)
Duringthewholemeasurement(10–15min)
|     |      |     |     | ±   |     |         | ±   |     |         | ±   |         |     |
| --- | ---- | --- | --- | --- | --- | ------- | --- | --- | ------- | --- | ------- | --- |
|     | None |     | 0.0 | 0.0 | 0.0 | 0.0 0.0 | 0.0 | 0.0 | 0.0 0.0 | 0.0 | 0.0 0.0 |     |
VeryLow 0.8 ± 1.7 0.0 11.8 0.2 ± 0.7 0.0 5.3 0.1 ± 0.1 0.0 0.8
|     |     | Low | 1.6 | ± 2.6 | 0.0 15.5 | 0.4 | ± 1.1 | 0.0 | 5.4 0.1 | ± 0.2 | 0.0 1.0 |     |
| --- | --- | --- | --- | ----- | -------- | --- | ----- | --- | ------- | ----- | ------- | --- |
Medium 3.4 ± 4.4 0.0 20.9 1.3 ± 2.7 0.0 15.6 0.1 ± 0.4 0.0 2.8
Strong 9.0 ± 9.2 0.0 36.9 5.2 ± 6.9 0.0 35.4 0.8 ± 1.7 0.0 9.3
|     |     |     |     | ±   |     |     | ±   |     |     | ±   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
VeryStrong 41.0 18.1 1.9 76.6 35.0 17.2 1.1 74.8 14.9 11.5 0.06 45.7
Duringtheselectedperiod(5min)
|     | None    |     | 0.0 | ± 0.0 | 0.0      | 0.0 0.0 | ± 0.0 | 0.0 | 0.0 0.0  | ± 0.0 | 0.0 0.0 |     |
| --- | ------- | --- | --- | ----- | -------- | ------- | ----- | --- | -------- | ----- | ------- | --- |
|     |         |     |     | ±     |          |         | ±     |     |          | ±     |         |     |
|     | VeryLow |     | 0.7 | 1.8   | 0.0 11.6 | 0.1     | 0.7   | 0.0 | 7.7 0.1  | 0.3   | 0.0 1.5 |     |
|     |         | Low | 1.5 | ± 3.0 | 0.0 17.9 | 0.4     | ± 1.1 | 0.0 | 7.7 0.2  | ± 0.8 | 0.0 5.2 |     |
|     |         |     |     | ±     |          |         | ±     |     |          | ±     |         |     |
|     | Medium  |     | 3.2 | 5.0   | 0.0 25.3 | 1.2     | 2.7   | 0.0 | 17.1 0.4 | 1.5   | 0.0 8.8 |     |
Strong 8.5 ± 9.7 0.0 39.6 4.5 ± 7.1 0.0 36.1 1.7 ± 4.4 0.0 21.0
VeryStrong 39.4 ± 19.3 1.0 77.2 33.1 ± 18.8 0.0 75.5 17.1 ± 15.8 0.0 60.8
Dataarepresentedasmeanandstandarddeviation(SD),minimum(Min)andmaximum(Max).
Figure2showsmeanandstandarddeviationvaluesofSDNN,RMSSDandpNN50forevery
cohort across the different Kubios filters. Significant differences were observed in mean SDNN
(Figure2A,D,G),meanRMSSD(Figure2B,E,H)andmeanpNN50(Figure2C,F,I)acrossKubiosfilters
inallcohorts(allp<0.001). Significantdifferenceswereobservedafterpost-hocBonferronicorrections
inbothchildrenandyoungadults(Figure2A–F).MeanSDNN,meanRMSSDandmeanpNN50were
similaracrossKubiosfiltersinmiddle-agedadultsexceptwhentheVeryStrongfilterwascompared
withtheotherKubiosfilters(Figure2G,H,I).
Figure3showsmeanandstandarddeviationvaluesoffrequency-domainHRVderivedparameters
acrossdifferentKubiosfilters,showingsimilarresultstothoseintime-domainparameters. Significant
| differences |     |     |     |     |     | <   |     |     |     |     |     | <   |
| ----------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
were observed in mean HF (all p 0.025; Figure 3A,E,I) and mean LF (all p 0.038;
SignificantdifferenceswerealsofoundintheLF/HF
Figure3B,F,J)acrossfiltersinthethreecohorts.
ratioacrossdifferentKubiosfiltersinchildrenandyoungadults(allp<0.001;Figure3C,G),whereas
nodifferenceswerenotedinmiddleagedadults(p=0.794;Figure3K).Likewise,significantdifferences
wereobservedintheVLFinchildrenandinmiddle-agedadults(allp<0.008;Figure3D,L).Although
repeated-measuresANOVAshowednodifferencesinVLFacrossdifferentKubiosfiltersinyoung
adults(p=0.233;Figure3H),significantpost-hocdifferenceswereobserved(Figure3).
differences
We repeated the ANOVA model to test in HRV derived parameters in time- and
frequency-domainsexcludingtheVeryStrongKubiosfilter,andtheresultsremainedsimilar(Figure
S2andFigureS3). Moreover,indeeperanalysesweobservedthattheVeryStrongfilterequalizesHRV
amongthestudyparticipantsalthoughthedifferencesbetweenthecohortsstillremainedsignificant
(FigureS4,FigureS5andFigureS6).

J.Clin.Med.2020,9,325 6of11
J. Clin. Med. 2020, 9, 325 6 of 11
Figure2. DifferencesontheHeartRateVariability(HRV)time-domainparametersusingdifferent
Figure 2. Differences on the Heart Rate Variability (HRV) time‐domain parameters using different
Kubiosfiltersinthreedifferentcohorts. Dataarerepresentedasmeanandstandarddeviation. SDNN:
Kubios filters in three different cohorts. Data are represented as mean and standard deviation. SDNN:
standard deviation of all normal R–R intervals (Panels A, D and G); RMSSD: squared root of the
standard deviation of all normal R–R intervals (Panels A, D and G); RMSSD: squared root of the mean
meanofthesumofthesquaresofsuccessivenormalR–Rintervaldifferences(PanelsB,EandH);
of the sum of the squares of successive normal R–R interval differences (Panels B, E and H); pNN50:
pNN50: numberofpairsofadjacentnormalR–Rintervalsdifferingbymorethan50msintheentire
number of pairs of adjacent normal R–R intervals differing by more than 50ms in the entire recording
J. Crelicno. (Mr P d aeidn n.e g2l0s (2 P C0a,, 9n F,e 3a l2s n5d C , I) F ; p a n v d alu I) e ; p fro v m al u th e e f r A o N m O th V e A A c N om O p V a A ris c o o n m s; p s a im ris il o a n r s l ; e s tt i e m rs i l m ar e l a e n tt s e B rs on m fe e r a r n o s ni B p o o n s f t‐ e h r o r7c o onfi 11
post-hocdifferences.
differences.
Figure 3 shows mean and standard deviation values of frequency‐domain HRV derived
parameters across different Kubios filters, showing similar results to those in time‐domain
parameters. Significant differences were observed in mean HF (all p < 0.025; Figures 3A,3E,3I) and
mean LF (all p < 0.038; Figures 3B,3F,3J) across filters in the three cohorts. Significant differences were
also found in the LF/HF ratio across different Kubios filters in children and young adults (all p < 0.001;
Figures 3C,3G), whereas no differences were noted in middle aged adults (p = 0.794; Figure 3K).
Likewise, significant differences were observed in the VLF in children and in middle‐aged adults (all
p < 0.008; Figures 3D,3L). Although repeated‐measures ANOVA showed no differences in VLF across
different Kubios filters in young adults (p = 0.233; Figure 3H), significant post‐hoc differences were
observed (Figure 3).
We repeated the ANOVA model to test differences in HRV derived parameters in time‐ and
frequency‐domains excluding the Very Strong Kubios filter, and the results remained similar
(Figure S2 and Figure S3). Moreover, in deeper analyses we observed that the Very Strong filter
equalizes HRV among the study participants although the differences between the cohorts still
remained significant (Figures S4–S6).
Figure3. DifferencesontheHeartRateVariability(HRV)frequency-domainparametersusingdifferent
KubFiiogusrfiel t3e.r Diniftfherreenecdesi ffoenr etnhtec oHheoarrtts .RaDtea tVaaarrieabrieliptyre s(HenRtVed) afrseqmueeanncya‐dnodmsatainn dpaarrdamdeetveirast iuosnin.gH F:
powdeifrfeinretnhte Khuibgihosf rfeilqteure innc tyhr(eine dabifsfeorleuntet cuonhiotsr,tsm. Ds2a;taP aarnee rlsepAre,sEenantedd Ia)s; mLFe:apno awnde rstianntdhaerdlo dwevfrieaqtiuonen. cy
(inHabFs: oplouwteeur ninit sth,em hsi2g;hP farneqeulsenBc,yF (ainn dabJs)o;lLuFte/ HunFi:tsr,a tmios2o; fPtahneelps oAw, eEr ainndt hI)e; lLoFw: pforewqeure innc tyhed ilvoiwd ed
bytfrheequpeonwcye r(iinn atbhseohluitgeh ufnrietqs,u mens2c;y P(aPnaenlse Bls, FC ,aGnda Jn);d LKF/)H;VF:L rFat:ipo oowf tehrei pnotwheerv ienr tyhleo lwowf rferqequueennccyy (in
absdoilvuitdeeudn bitys ,tmhes 2p;oPwanere lsinD t,hHe haingdh Lfr)e.qpuveanlcuye (fProamneltsh eCA, GN OaVndA Kco);m VpLaFri:s opnows;esri minil athrele vtteerrys mlowea ns
Bon
fr
fe
eq
rr
u
o
e
n
n
i
c
p
y
o
(
s
i
t
n
- h
a
o
b
c
so
d
l
i
ufft
e
e
r
u
en
n
c
it
e
s
s
,
.
ms2; Panels D, H and L). p value from the ANOVA comparisons; similar
letters means Bonferroni post‐hoc differences.
4. Discussion
The present study showed that the application of certain Kubios filters had a significant impact
on the quantification of HRV derived parameters obtained from short‐term recordings in time and
frequency‐domains in sedentary children with overweight/obesity, sedentary young and sedentary
middle‐aged adults. Our results also suggest that children and young adults’ recordings were more
affected by lower intensity Kubios filters (i.e., Very Low, Low and Medium) than middle‐aged adults.
Thus, potential artefacts could be corrected or interpolated with Kubios filters of lower intensity in
children and in young adults. The Very Strong filter should be used with caution, given that the
interpolated R‐R intervals were 39% (from 1% to 77.2%) in children, 33% (from 0 to 75.5%) in young
adults, and 17% (from 0 to 60.8%) in middle‐aged adults in the selected best 5 min period, which
means that most of the selected period is “artificial” (i.e., interpolated) in younger populations.
Furthermore, after the visual inspection of the R‐R signals in children, young adults and middle‐aged
adults we did not visually find any premature contractions based on the observer criteria. However,
we do not have ECG tracings to verify whether “real” artefacts happened or not. Therefore, we cannot
exclude that the high number of interpolated R‐R intervals using the Very Strong filter could be
related to either the Very Strong filter has some problem of excessive sensitivity or the heart rate
monitor used for HRV assessment creates an excess of artefacts that are detected only by the Very
Strong filter. Nevertheless, the former option is very likely since children and young adults usually
present high sinus rhythm fluctuations resulting in big differences between consecutive R‐R intervals
which may be “overfiltered” by the Kubios filters. This is even more possible because the visual
inspection before HRV analysis did not detect artefacts or premature contractions in the most of the
R‐R interval signals visually inspected.
Several studies have reported the importance of artefact correction on the quantification of HRV
derived parameters from short‐term recordings [8,28,29]. However, there is scarce evidence
regarding the impact of using different Kubios filters on the quantification of HRV derived

J.Clin.Med.2020,9,325 7of11
4. Discussion
ThepresentstudyshowedthattheapplicationofcertainKubiosfiltershadasignificantimpact
onthequantificationofHRVderivedparametersobtainedfromshort-termrecordingsintimeand
frequency-domainsinsedentarychildrenwithoverweight/obesity,sedentaryyoungandsedentary
middle-agedadults. Ourresultsalsosuggestthatchildrenandyoungadults’recordingsweremore
affectedbylowerintensityKubiosfilters(i.e.,VeryLow,LowandMedium)thanmiddle-agedadults.
Thus,potentialartefactscouldbecorrectedorinterpolatedwithKubiosfiltersoflowerintensityin
children and in young adults. The Very Strong filter should be used with caution, given that the
interpolatedR-Rintervalswere39%(from1%to77.2%)inchildren,33%(from0to75.5%)inyoung
adults,and17%(from0to60.8%)inmiddle-agedadultsintheselectedbest5minperiod,whichmeans
thatmostoftheselectedperiodis“artificial”(i.e.,interpolated)inyoungerpopulations. Furthermore,
afterthevisualinspectionoftheR-Rsignalsinchildren,youngadultsandmiddle-agedadultswedid
notvisuallyfindanyprematurecontractionsbasedontheobservercriteria. However,wedonothave
ECGtracingstoverifywhether“real”artefactshappenedornot. Therefore,wecannotexcludethatthe
highnumberofinterpolatedR-RintervalsusingtheVeryStrongfiltercouldberelatedtoeitherthe
VeryStrongfilterhassomeproblemofexcessivesensitivityortheheartratemonitorusedforHRV
assessmentcreatesanexcessofartefactsthataredetectedonlybytheVeryStrongfilter. Nevertheless,
theformeroptionisverylikelysincechildrenandyoungadultsusuallypresenthighsinusrhythm
fluctuationsresultinginbigdifferencesbetweenconsecutiveR-Rintervalswhichmaybe“overfiltered”
bytheKubiosfilters. ThisisevenmorepossiblebecausethevisualinspectionbeforeHRVanalysisdid
notdetectartefactsorprematurecontractionsinthemostoftheR-Rintervalsignalsvisuallyinspected.
SeveralstudieshavereportedtheimportanceofartefactcorrectiononthequantificationofHRV
derivedparametersfromshort-termrecordings[8,28,29]. However,thereisscarceevidenceregarding
theimpactofusingdifferentKubiosfiltersonthequantificationofHRVderivedparametersfrom
short-termrecordingsintime-andfrequency-domainsemployingthecommerciallyavailableKubios
software[10]. TheselectionoftheKubiosfilterhasbeenusuallyperformedsubjectively. Whilesome
studieshaveselectedandreportedtheuseofaLoworMediumKubiosfiltersforthesamecohort,
others did not report the filter employed. Based on the results of the current study, it should be
mandatorytoexplicitlyacknowledgewhichKubiosfilterisusedinordertoeasecomparabilityof
HRVderivedparametersamongdifferentstudies.
Tothebestofourknowledge, thereisonlyonestudytestingtheimpactoftheapplicationof
differentKubiosfiltersonthequantificationoftheHRVderivedparametersobtainedbyshort-term
recordings[13]. Arandaetal.[13]foundthattheuseofaVeryStrongfilter(comparedtotheothersfilters)
significantlyaffectedthequantificationofHRVderivedparametersintime-andfrequency-domainsin
30professionalathletes. Thesefindingsconcurwithours,andinfactweobservedasignificantimpact
onHRVderivedparametersintime-andfrequency-domainsamongtheKubiosfiltersevenusingthe
VeryLow,theLow,theMediumandtheStrongfilters(seeFigures2and3). Despitetheparticipantsof
theArandaetal. study[13]wereyoungadults(25±3yearsold),thedifferentresultsobtainedbetween
studiescouldbeexplainedbythetrainingstatus(professionalathletesvs. sedentary),methodological
factorssuchasthebodypositioningduringtheHRVassessment(sittingvs. lying),ortheheartrate
monitoremployedfortheHRVrecordings(FirstbeatBodyguardvs. PolarRS800CX).
The clinical relevance of the observed differences on the HRV derived parameters should be
considered. SDNNinrestingconditionsisconsideredagoodindicatorofcardiovascularandmortality
risk[1]. Indeed,apreviousstudyhasreportedthateachincreaseof10msinSDNNcouldindicatea
reductionof≈20%intheriskofmortalityinadultswithischemiccardiomyopathy[30]. Comparing
theSDNNvaluesaftertheapplicationoftwosimilarKubiosfiltersinourstudy(theVeryLowfilter
vs. theLowfilter),weobservedameanSDNNdifferenceof3.66ms,1.16msand0.08msinchildren,
youngandmiddle-agedadults. Therefore,thesedifferencesbetweenfiltersmightnothaveaclinically
relevantimpact. However,whenextremeKubiosfilterswerecompared(i.e.,theVeryLowfiltervs. the
VeryStrongfilter),weobservedameanSDNNdifferenceof38.68ms,27.25msand7.83msinchildren,

J.Clin.Med.2020,9,325 8of11
youngandmiddle-agedadults. ThesemeanSDNNdifferencesbetweenfilterslikelyrepresentaclinical
relevancydifferenceonbothchildrenandyoungadults, consideringtheaforementioned10msin
SDNNsuggestingareductionontheriskofmortality. Ofnote,theclinicalrelevancymentionedshould
beconsideredwithcautionassomeimportantdifferencesneedtobeacknowledged: thecohortsof
thestudy(adultswithcardiovasculardiseasesvs. children,youngandmiddle-agedadultswithout
cardiovasculardiseases),thelengthandinstrumentemployedduringtheHRVassessment(24hHolter
vs. 10–15minPolarRS800CXheartratemonitor). Furthermore,inpractice,couldbeinappropriate
tocompareSDNNvaluesbecausethetotalvarianceofHRVincreaseswiththedurationoftheHRV
recording[1].
TheKubiosuser’sguiderecommendsapercentageofinterpolatedR-Rintervalslowerthan5%.
Thesoftwaredevelopersarguethatthispercentageshouldbeenoughtoremoveartefactsavoidingan
excessiveinterpolationofR-Rintervals. Toourknowledge,thisrecommendationhasnotbeentestedin
largeand/ordifferentcohorts. Moreover,theysuggestedthattheKubiosfiltershouldbeindividually
selectedtoaccountforinter-individualvariabilityintheHRV.Basedonourresults,wesuggestedthe
usealowerintensityKubiosfilter(i.e. VeryLow,LoworMediumfilters)inyoungerpopulations,
whileastrongerKubiosfiltercouldbeusedinolderpopulations(withcautionwhenusingtheVery
StrongKubiosfilter)toachievethemanufacturer’recommendationoflessthan5%ofR-Rintervals
interpolatedtoremoveHRVrecordingsartefacts(seeTable2). WealsoobservedthattheVeryStrong
filterhighlyreducestheHRV,becausebydefinition,itmustexcludeeveryR-Rintervalwhichis50ms
longerorshorterthanthelocalaverageR-Rinterval. Thus,theVeryStrongfilterequalizestheHRV
amongthestudyparticipants(FigureS4,FigureS5andFigureS6).
The design of the current study precludes providing definitive thresholds and future studies
are needed testing those recommendations. Moreover, we do not know whether Kubios filters
remove“real”artefactsorlargeprolongationsofR-Rintervalwhichmayappearinhealthyyoung
individuals. Therefore, for Kubios software users, it is important to choose a reasonable filtering
level(e.g.,withcautionwhenusingtheVeryStrongKubiosfilter),andhence,thisstudymayhave
practicalimplications. Indeed,thekindoffiltershouldcorrespondtothequalityofthedata,e.g.,data
collectedduringexercisesordailyactivitywillneedstrongerfiltersthanthoserecordedatrest. In
addition, accordingtotheresultsofourstudy, oneshouldalsoconsidertheageofsubjectsbefore
choosingtheappropriatefilter. Furthermore,wewouldrecommendtotheKubiossoftwareusersto
applydifferentfiltersandtoperformsensitivityanalysesinordertostudytheeffectofatreatment
“X”ontheHRVderivedparameters. Thus,theKubiossoftwareusersmighthaveahigherconfident
levelintheirresultsbecausearenot“filterdependent”(i.e.,theirresultsareconsistentacrossdifferent
Kubiosfilters).
Weareawareofsomelimitationsinourstudy: (1)thechildrencohortincludedinthepresentstudy
wasasampleofsedentarychildrenwithoverweight/obesity,sowecannotextrapolateourfindingsto
normal-weightchildren,(2)theexperimentalconditionsduringtheHRVassessmentwerenotexactly
thesameinthethreedifferentstudies(e.g.,thehourand/ordatesoftheHRVassessments),(3)theHRV
assessmentwasperformedonceperparticipantduringarelativelyshortperiod(10–15min),and(4)
wedidnotemployECGtracingstoverifywhether“real”artefactshappenedornot,thusourresults
couldbeinfluencedbythefactthatwehaveusedapolarRS800CX.Therefore,futurestudiesshould
beperformedusingotheralternativestools(e.g.,adifferentheartratemonitororECG)toconfirm
whethertheimpactofthedifferentKubiosfiltersremainedindependentlyofthetoolemployedfor
recordingtheheartrhythm. Ontheotherhand,thestrengthsofourstudywere: (1)alargesamplesize;
(2)theimpactofdifferentKubiosfilterswastestedinthreedifferentandindependenthumancohorts;
(3)allR-Rintervalsignalshavebeenvisuallyinspectedtodetectobviousartefacts;and,(4)theHRV
derivedparameterswereobtainedfromshort-termrecordings,whichareincreasingtheirpopularity
inbothclinicalandresearchcontextduetheirrelativeeaseindatacollectionandmanagement.

J.Clin.Med.2020,9,325 9of11
5. Conclusions
The results of the present study suggest that the application of different Kubios filters had
a significant impact on the quantification of HRV derived parameters obtained from short-term
recordingsinbothtimeandfrequency-domainsinchildren,youngandmiddle-agedadults. Moreover,
reportingthefilteremployedshouldbemandatorytoallowcomparisonsacrossstudies. Althoughthe
designofthecurrentstudyprecludesprovidingdefinitivethresholds,wesuggestedtouseaVeryLow,
LoworMediumfilterinchildrenandyoungadults,whereasanyKubiosfilter(withcautionwhen
usingtheVeryStrongKubiosfilter)maybeemployedformiddle-agedadults,whentheprocessing
oftheshort-termsHRVrecordingsisperformedusingthecommerciallyavailableKubiossoftware.
FurtherstudiesareguaranteedinordertoelucidatewhicharethebestKubiosfilterstoobtainvalid
dataofHRVderivedparameters.
Supplementary Materials: The following are available onlineat http://www.mdpi.com/2077-0383/9/2/325/s1,
FigureS1: ExampleofavisualinspectionofaR-Rsignaltofindpossibleartefactsorprematurecontractionsacross
Kubiosfilters;FiguresS2andS3: DifferencesontheHeartRateVariability(HRV)time-andfrequency-domains
parametersrespectivelywithoutconsideringtheVeryStrongfilter;FigureS4: Differencesbetweencohortsonthe
SDNNusingdifferentKubiosfilters;FigureS5: DifferencesbetweencohortsonthepNN50usingdifferentKubios
filters;andFigureS6: DifferencesbetweencohortsontheHFusingdifferentKubiosfilters.
AuthorContributions: Conceptualization,J.M.A.A.,A.P.-F.,F.M.A.,G.S.-D.andB.M.-T.;Datacuration,J.M.A.A.,
A.P.-F.,F.J.A.-G.andF.M.A.;Formalanalysis,J.M.A.A.,A.P.-F.andB.M.-T.;Methodology,J.M.A.A.andA.P.-F.;
Writing–originaldraft,J.M.A.A.andA.P.-F.;Writing–review&editing,J.M.A.A.,A.P.-F.,F.J.A.-G.,F.M.A.,J.H.M.,
P.M.-G.,J.S.,G.S.-D.andB.M.-T.Allauthorshavereadandagreedtothepublishedversionofthemanuscript.
Funding:JuanM.A.Alcantara,AbelPlaza-Florido,JairoH.Migueles,GuillermoSanchez-DelgadoandFranciscoJ.
Amaro-GahetearesupportedbytheSpanishMinistryofEducation,CultureandSport(FPU15/04059,FPU16/02760,
FPU15/02645,FPU13/04365andFPU14/04172respectively). GuillermoSanchez-Delgadoissupportedbythe
UniversityofGranadaPlanPropiodeInvestigación2018(ProgramaContratos-PuenteandProgramaPerfeccionamiento
deDocotres). FranciscoJ.Amaro-GaheteissupportedbytheUniversityofGranadaPlanPropiodeInvestigación2019
(ProgramaContratos-Puente). GuillermoSanchez-DelgadoandBorjaMartinez-Tellezaresupportedbyindividual
postdoctoralgrantsfromtheFundaciónAlfonsoMartinEscudero. ThestudywasfundedbytheSpanishMinistryof
EconomyandCompetitiveness(DEP2013-47540andDEP2016-79512-R),theFondodeInvestigaciónSanitariadel
InstitutodeSaludCarlosIII(PI13/01393),EuropeanUnionDevelopmentFunds,theFundaciónIberoamericanade
Nutrición(FINUT),theRedesTemáticasdeInvestigaciónCooperativaRETIC(RedSAMIDRD16/0022),theUniversity
of Granada Plan Propio de Investigación 2016 (Excellence actions: Unit of Excellence on Exercise and Health
[UCEES]), and the Junta de Andalucía, Consejería de Conocimiento, Investigación y Universidades (FEDER: ref.
SOMM17/6107/UGR).
Acknowledgments: This study is part of a PhD thesis conducted within the framework of the Biomedicine
DoctoralStudiesProgrammeoftheUniversityofGranada,Spain.
ConflictsofInterest: Theauthorsdonothaveanyconflictofinteresttodisclose.
References
1. Task Force of the European Society of Cardiology and the North American Society of Pacing and
Electrophysiology. Heart rate variability: Standards of measurement, physiological interpretation and
clinicaluse. Circulation1996,93,1043–1065.
2. Lahiri,M.K.;Kannankeril,P.J.;Goldberger,J.J.AssessmentofAutonomicFunctioninCardiovascularDisease.
Physiological Basis and Prognostic Implications. J. Am. Coll. Cardiol. 2008, 51, 1725–1733. [CrossRef]
[PubMed]
3. Shaffer,F.;McCraty,R.;Zerr,C.L.Ahealthyheartisnotametronome: Anintegrativereviewoftheheart’s
anatomyandheartratevariability. Front. Psychol. 2014,5,1–19. [CrossRef][PubMed]
4. Gidron,Y.;Deschepper,R.;DeCouck,M.;Thayer,J.;Velkeniers,B.TheVagusNerveCanPredictandPossibly
ModulateNon-CommunicableChronicDiseases: IntroducingaNeuroimmunologicalParadigmtoPublic
Health. J.Clin. Med. 2018,7,371. [CrossRef][PubMed]
5. Zhang,J.EffectofAgeandSexonHeartRateVariabilityinHealthySubjects. J.Manip. Physiol. Ther. 2007,
30,374–379. [CrossRef][PubMed]

| J.Clin.Med.2020,9,325 |     |     |     |     |     |     |     | 10of11 |
| --------------------- | --- | --- | --- | --- | --- | --- | --- | ------ |
6. Almeida-Santos,M.A.;Barreto-Filho,J.A.;Oliveira,J.L.M.;Reis,F.P.;daCunhaOliveira,C.C.;Sousa,A.C.S.
Aging,heartratevariabilityandpatternsofautonomicregulationoftheheart. Arch. Gerontol. Geriatr. 2016,
63,1–8. [CrossRef]
7. Peltola,M.A.RoleofeditingofR-Rintervalsintheanalysisofheartratevariability. Front. Physiol. 2012,3,
1–10. [CrossRef]
8. Stapelberg,N.J.C.;Neumann,D.L.;Shum,D.H.K.;McConnell,H.;Hamilton-Craig,I.Thesensitivityof38
heartratevariabilitymeasurestotheadditionofartifactinhumanandartificial24-hrcardiacrecordings.
| Ann. NoninvasiveElectrocardiol. |     |     | 2018,23,1–12. |     | [CrossRef] |     |     |     |
| ------------------------------- | --- | --- | ------------- | --- | ---------- | --- | --- | --- |
9. Buchheit,M.MonitoringtrainingstatuswithHRmeasures: DoallroadsleadtoRome? Front. Physiol. 2014,
5,1–19.
[CrossRef]
10. Singh,B.;Bharti,N.;Engineering,C.SoftwareToolsforHeartRateVariabilityAnalysis. Int. J.RecentSci. Res.
2015,6,3501–3506.
11. Tarvainen,M.P.;Niskanen,J.P.;Lipponen,J.A.;Ranta-aho,P.O.;Karjalainen,P.A.KubiosHRV—Heartrate
variabilityanalysissoftware. Comput. MethodsProgramsBiomed. 2014,113,210–220. [CrossRef][PubMed]
12. Niskanen,J.P.;Tarvainen,M.P.;Ranta-Aho,P.O.;Karjalainen,P.A.SoftwareforadvancedHRVanalysis.
| Comput. MethodsProgramsBiomed. |     |     |     | 2004,76,73–81. |     | [CrossRef][PubMed] |     |     |
| ------------------------------ | --- | --- | --- | -------------- | --- | ------------------ | --- | --- |
Aranda,C.;DeLaCruz,B.;Naranjo,J.Effectsofdifferentautomaticfiltersontheanalysisofheartrate
13.
| variabilitywithkubiosHRVsoftware. |     |     |     | Arch. | Med. | Deporte2017,34,196–200. |     |     |
| --------------------------------- | --- | --- | --- | ----- | ---- | ----------------------- | --- | --- |
14. Tegegne,B.S.;Man,T.;vanRoon,A.M.;Riese,H.;Snieder,H.Determinantsofheartratevariabilityinthe
generalpopulation: TheLifelinesCohortStudy. Hear. Rhythm. 2018,15,1552–1558. [CrossRef][PubMed]
15. Cadenas-Sánchez, C.; Mora-González, J.; Migueles, J.H.; Martín-Matillas, M.; Gómez-Vida, J.;
Escolano-Margarit, M.V.; Maldonado, J.; Enriquez, G.M.; Pastor-Villaescusa, B.; de Teresa, C.; et al.
An exercise-based randomized controlled trial on brain, cognition, physical health and mental health
inoverweight/obesechildren(ActiveBrainsproject):
|                  |     |            |     |     |     | Rationale,designandmethods. | Contemp. Clin. | Trials |
| ---------------- | --- | ---------- | --- | --- | --- | --------------------------- | -------------- | ------ |
| 2016,47,315–324. |     | [CrossRef] |     |     |     |                             |                |        |
16. Sanchez-Delgado,G.; Martinez-Tellez,B.; Olza,J.; Aguilera,C.M.; Labayen,I.; Ortega,F.B.; Chillon,P.;
Fernandez-Reguera,C.;Alcantara,J.M.A.;Martinez-Avila,W.D.;etal. Activatingbrownadiposetissue
throughexercise(ACTIBATE)inyoungadults: Rationale,designandmethodology. Contemp. Clin. Trials
| 2015,45,416–425. |     | [CrossRef] |     |     |     |     |     |     |
| ---------------- | --- | ---------- | --- | --- | --- | --- | --- | --- |
17. Amaro-Gahete,F.J.;De-la-O,A.;Jurado-Fasoli,L.;Espuch-Oliver,A.;Robles-Gonzalez,L.;Navarro-Lomas,G.;
de Haro, T.; Femia, P.; Castillo, M.J.; Gutierrez, A. Exercise training as S-Klotho protein stimulator in
sedentaryhealthyadults: Rationale,design,andmethodology. Contemp. Clin. TrialsCommun. 2018,11,
10–19. [CrossRef]
18. Gamelin,F.X.;Baquet,G.;Berthoin,S.;Bosquet,L.ValidityofthepolarS810tomeasureR-Rintervalsin
| children. | Int. J.SportsMed. |     | 2008,29,134–138. |     | [CrossRef] |     |     |     |
| --------- | ----------------- | --- | ---------------- | --- | ---------- | --- | --- | --- |
19. Vasconcellos,F.V.A.;Seabra,A.;Cunha,F.A.;Montenegro,R.A.;Bouskela,E.;Farinatti,P.Heartratevariability
assessmentwithfingertipphotoplethysmographyandpolarRS800cxascomparedwithelectrocardiography
| inobeseadolescents. |     | BloodPress. |     | Monit. | 2015,20,351–360. | [CrossRef] |     |     |
| ------------------- | --- | ----------- | --- | ------ | ---------------- | ---------- | --- | --- |
20. Tsitoglou,K.I.;Koutedakis,Y.;Dinas,P.C.ValidationofthePolarRS800CXforassessingheartratevariability
duringrest,moderatecyclingandpost-exerciserecovery. F1000Research2018,7,1501. [CrossRef]
21. Williams,D.P.;Jarczok,M.N.;Ellis,R.J.;Hillecke,T.K.;Thayer,J.F.;Koenig,J.Two-weektest—Retestreliability
ofthePolar®RS800CXTMtorecordheartratevariability. Clin. Physiol. Funct. Imaging2017,37,776–781.
[CrossRef]
22. Michels,N.; Clays,E.; DeBuyzere,M.; Huybrechts,I.; Marild,S.; Vanaelst,B.; DeHenauw,S.; Sioen,I.
Determinantsandreferencevaluesofshort-termheartratevariabilityinchildren. Eur. J.Appl. Physiol. 2013,
| 113,1477–1488. | [CrossRef] |     |     |     |     |     |     |     |
| -------------- | ---------- | --- | --- | --- | --- | --- | --- | --- |
23. Sandercock,G.R.H.;Bromley,P.D.;Brodie,D.A.Thereliabilityofshort-termmeasurementsofheartrate
| variability. | Int. J.Cardiol. | 2005,103,238–247. |     |     | [CrossRef] |     |     |     |
| ------------ | --------------- | ----------------- | --- | --- | ---------- | --- | --- | --- |
24. Van De Wielle, R.; Michels, N. Longitudinal Associations of Leptin and Adiponectin with Heart Rate
| VariabilityinChildren. |     | Front. | Physiol. | 2017,8,1–9. |     | [CrossRef][PubMed] |     |     |
| ---------------------- | --- | ------ | -------- | ----------- | --- | ------------------ | --- | --- |
25. Tarvainen,M.;Lipponen,J.;Niskanen,J.;Ranta-aho,P.O.KubiosUser’sGuide. Availableonline: https:
//www.kubios.com/hrv-standard/(accessedon23December2019).

J.Clin.Med.2020,9,325 11of11
26. Cole,T.J.;Lobstein,T.Extendedinternational(IOTF)bodymassindexcut-offsforthinness,overweightand
obesity. Pediatr. Obes. 2012,7,284–294. [CrossRef][PubMed]
27. WorldHealthOrganization. WaistCircumferenceandWaist-HipRatio: ReportofaWHOExpertConsultation;
WHO:Geneva,Switzerland,2008;pp.1–39.
28. Salo,M.A.;Huikuri,H.V.;Seppanen,T.Ectopicbeatsinheartratevariabilityanalysis: Effectsofeditingon
timeandfrequencydomainmeasures. Ann. NoninvasiveElectrocardiol. 2001,6,5–17. [CrossRef][PubMed]
29. Choi,A.;Shin,H.Quantitativeanalysisoftheeffectofanectopicbeatontheheartratevariabilityinthe
restingcondition. Front. Physiol. 2018,9,922. [CrossRef][PubMed]
30. Bilchick, K.C.; Fetics, B.; Djoukeng, R.; Fisher, S.G.; Fletcher, R.D.; Singh, S.N.; Nevo, E.; Berger, R.D.
Prognosticvalueofheartratevariabilityinchroniccongestiveheartfailure(VeteransAffairs’SurvivalTrial
ofAntiarrhythmicTherapyinCongestiveHeartFailure). Am. J.Cardiol. 2002,90,24–28. [CrossRef]
©2020bytheauthors. LicenseeMDPI,Basel,Switzerland. Thisarticleisanopenaccess
articledistributedunderthetermsandconditionsoftheCreativeCommonsAttribution
(CCBY)license(http://creativecommons.org/licenses/by/4.0/).
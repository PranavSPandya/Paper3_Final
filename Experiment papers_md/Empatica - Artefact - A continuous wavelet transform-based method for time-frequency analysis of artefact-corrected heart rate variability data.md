Physiological Measurement
Related content
A continuous wavelet transform-based method for -Customized filtering compared with FFT in
neonatal HRV
N A M de Beer, P Andriessen, R C M
time-frequency analysis of artefact-corrected heart
Berendsen et al.
rate variability data -EMD analysis of HRV data from patients
undergoing local anaesthesia
K Shafqat, S K Pal, S Kumari et al.
To cite this article: C H L Peters et al 2011 Physiol. Meas. 32 1517 -Time-frequency analysis of heartrate
variability
Sigrid Elsenbruch, Zhishun Wang, William
C Orr et al.
View the article online for updates and enhancements.
Recent citations
-Using uterine activity to improve fetal heart
rate variability analysis for detection of
asphyxia during labor
G J J Warmerdam et al
This content was downloaded from IP address 150.216.68.200 on 22/12/2017 at 10:23

| IOPPUBLISHING |     |     |     |     |     |     |     | PHYSIOLOGICALMEASUREMENT |     |     |     |
| ------------- | --- | --- | --- | --- | --- | --- | --- | ------------------------ | --- | --- | --- |
Physiol.Meas.32(2011)1517–1527 doi:10.1088/0967-3334/32/10/001
| A continuous     |     | wavelet |          | transform-based |                       |     |     | method |     | for   |     |
| ---------------- | --- | ------- | -------- | --------------- | --------------------- | --- | --- | ------ | --- | ----- | --- |
| time-frequency   |     |         | analysis |                 | of artefact-corrected |     |     |        |     | heart |     |
| rate variability |     |         | data     |                 |                       |     |     |        |     |       |     |
CHLPeters1,RVullings2,MJRooijakkers2,JWMBergmans2,
SGOei3andPFFWijn4
1DepartmentofClinicalPhysics,JeroenBoschHospital,’s-Hertogenbosch,TheNetherlands
2DepartmentofElectricalEngineering,EindhovenUniversityofTechnology,TheNetherlands
3DepartmentofObstetricsandGynaecology,Ma´ximaMedicalCenter,Veldhoven,
TheNetherlands
4DepartmentofClinicalPhysics,Ma´ximaMedicalCenter,Veldhoven,TheNetherlands
E-mail:c.peters@jbz.nl
Received23January2011,acceptedforpublication27July2011
Published18August2011
Onlineatstacks.iop.org/PM/32/1517
Abstract
|     | Time-frequency                                        |                                                             | analysis      |             | of heart | rate           | variability   | (HRV)       | provides     | relevant        |         |
| --- | ----------------------------------------------------- | ----------------------------------------------------------- | ------------- | ----------- | -------- | -------------- | ------------- | ----------- | ------------ | --------------- | ------- |
|     | clinical                                              | information.                                                |               | However,    |          | time-frequency |               | analysis    | is very      | sensitive       | to      |
|     | artefacts.                                            | Artefactsthatarepresentinheartraterecordingsmaybecorrected, |               |             |          |                |               |             |              |                 |         |
|     | but                                                   | this reduces                                                | the           | variability |          | in the signal  | and           | therefore   | adversely    |                 | affects |
|     | the                                                   | accuracy                                                    | of calculated |             | spectral | estimates.     |               | To overcome |              | this limitation |         |
|     | of                                                    | traditional                                                 | techniques    |             | for      | time-frequency |               | analysis,   | a new        | continuous      |         |
|     | wavelet                                               | transform                                                   |               | (CWT)-based |          | method         | was           | developed   | in           | which parts     | of      |
|     | the                                                   | scalogram                                                   | that          | have        | been     | affected       | by artefact   | correction  |              | are excluded    |         |
|     | from                                                  | power                                                       | calculations. |             | The      | method         | was evaluated | by          | simulating   | artefact        |         |
|     | correctiononHRVdatathatwereoriginallyfreeofartefacts. |                                                             |               |             |          |                |               |             | Commonlyused |                 |         |
spectralHRVparameterswerecalculatedbythedevelopedmethodandbythe
|     | short-timeFouriertransform(STFT),whichwasusedasareference. |     |     |     |     |     |     |     |     |     | Except |
| --- | ---------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------ |
forthepowersintheverylow-frequencyandlow-frequency(LF)bands,powers
calculatedbytheSTFTprovedtobeextremelysensitivetoartefactcorrection.
|     | The                                              | CWT-based |     | calculations | in       | the high-frequency |     | and                   | very         | high-frequency |     |
| --- | ------------------------------------------------ | --------- | --- | ------------ | -------- | ------------------ | --- | --------------------- | ------------ | -------------- | --- |
|     | bandscorrespondedwellwiththeirtheoreticalvalues. |           |     |              |          |                    |     | Thestandarddeviations |              |                |     |
|     | of these                                         | powers,   |     | however,     | increase | with               | the | number                | of corrected | artefacts      |     |
whichistheresultofthenon-stationarityoftheR–Rintervalseriesthatwere
|     | analysed. |             | The powers | calculated  |     | in the        | LF      | band turned     | out      | to be slightly |     |
| --- | --------- | ----------- | ---------- | ----------- | --- | ------------- | ------- | --------------- | -------- | -------------- | --- |
|     | sensitive | to          | artefact   | correction, |     | but the       | results | were acceptable |          | up to          | 20% |
|     | artefact  | correction. |            | Therefore,  |     | the CWT-based |         | method          | provides | a valuable     |     |
0967-3334/11/101517+11$33.00 ©2011InstituteofPhysicsandEngineeringinMedicine PrintedintheUK 1517

1518 CHLPetersetal
alternative for the analysis of HRV data that cannot be guaranteed to be free
ofartefacts.
Keywords: continuouswavelettransform,heartratevariability,artefacts
(Somefiguresinthisarticleareincolouronlyintheelectronicversion)
1. Introduction
Togetherwithstrokevolumeandperipheralvascularresistance,heartrateisoneofthemain
cardiovascular parameters that is regulated by the autonomic nervous system to control the
supply of blood to the organs. To fulfil this task, the cardiovascular control centres in the
medullaoblongatareceiveinputfromvarioustypesofsensorsinthebody. Twoveryimportant
typesofsensorarethepressure-sensitivebaroreceptors,whicharelocatedinthewallsofthe
arteries and in the heart, and the chemoreceptors, which are located in the carotid arteries,
theaorticarchandthemedullaoblongata. Inresponsetothissensoryinput,theheartrateis
controlledthroughbothneurologicalandhormonalpathways. Consequently,changesinthe
heartratereflectthesensoryinputtothecardiovascularcontrolcentres. Therefore, changes
intheheartrateindirectlyreflectchangesinthephysiologicalcondition. However,duetothe
complexityofthecardiovascularregulation,itisdifficulttoobtainunambiguousinformation
on changes in the physiological condition from a recording of the heart rate (Notarius and
Floras2001,Paratietal2006).
To a certain extent, the hormonal and neurological pathways that are used to control
the heart rate operate on different time bases. More in particular, the sympathetic and
parasympatheticpartsoftheautonomicnervoussystemactonverycharacteristictimescales.
Time-frequency analysis of heart rate variability (HRV) can therefore be used to evaluate
sympatheticandparasympatheticnervousactivityinregulatingtheheartrate(Akselrodetal
1981). Currently, time-frequency analysis of HRV is applied widely in clinical research in
variousfieldsofmedicine(Mainardietal2002,Acharyaetal2006). Successfulapplications
in clinical practice have, however, remained scarce. This is partially due to the complexity
ofthecardiovascularcontrolmechanisms. Additionally,foraccurateresultsthebeat-to-beat
heartrateisrequired,andalsodatamustbepreprocessedadequately. Finally,time-frequency
analysisisverysensitivetoartefacts,andthereforeanartefact-freeheartratesignalisrequired
(CliffordandTarassenko2005,Petersetal2008).
In clinical practice, artefact-free signals cannot always be guaranteed. An illustrative
exampleisthenon-invasivemeasurementofthefoetalECGfromtheabdomenofapregnant
woman. Time-frequencyanalysisoffoetalHRVcanprovidevaluableinformationonfoetal
condition (van Laar et al 2008, Siira et al 2005, Rantonen et al 2001, Cerutti et al 1989,
vanLaaretal2010). However, antepartumthequalityofthemeasuredECGsignalscanbe
rather poor, as the electrical source of the signals—the foetal heart—is still very small and
only accessible through maternal tissue (Lewis 2003). Foetal heart rates obtained from the
maternalabdomenarethereforeoftencontaminatedbyartefacts.
Themostfrequentlyoccurringartefactsinbeat-to-beatheartratesignalsresultfrom
(i) incorrectlocalizationoftheQRScomplex(misdetectedheartbeat),
(ii) oneormultipleundetectedQRScomplexes(missedheartbeats)and
(iii) falsedetectionofaQRScomplex(phantomheartbeat).

CWT-basedtime-frequencyanalysisofartefact-correctedHRVdata 1519
Each of these conditions results in artefacts in the calculated heart rate, which must
be detected and corrected before performing time-frequency analysis. Artefact correction
involvesremovingphantomheartbeatsfromtherecording,replacingmisdetectedheartbeats
and inserting missed heart beats in the recording. For replacement and insertion, substitute
QRS locations are usually obtained by means of interpolation, autoregressive modelling or
other statistical methods. Irrespective of the method that is used to replace and insert QRS
locations,artefactcorrectionwillreducethevariabilityinthesignal. Therefore,itisinevitable
that artefact correction will adversely affect the accuracy of calculated spectral estimates.
This limits the application of traditional techniques for time-frequency analysis to data that
arealmostentirelyfreeofartefacts.
To overcome this severe limitation, a new method for time-frequency analysis of HRV
isintroduced. Themethodthatisdescribedinthisworkisbasedonthecontinuouswavelet
transform(CWT)andcanbeappliedfortime-frequencyanalysis,afterartefactcorrection,of
HRVdatathatoriginallycontainedconsiderableamountsofartefacts. However,thisworkdoes
notaddresstheactualdetectionoftheseartefacts,whichmaybeachallengeitself,nordoes
itaddresstheprocessofartefactcorrectionforwhichvariousmethodsexist. Instead,artefact
correction was simulated on HRV data that were originally free of artefacts. This approach
allows objective evaluation of the developed method for various amounts of artefacts, but
implicitlyassumesadequateartefactdetectionandcorrection. Asareference,thegenerated
dataarealsoanalysedbytheshort-timeFouriertransform(STFT).
2. Methodology
2.1. Generalapproach
Beat-to-beat heart rate data from newborns and foetuses were used to study the effect of
artefact correction on time-frequency analysis of HRV. In newborns, the respiration rate is
significantly higher than in adults. As the heart rate is modulated by respiration, neonatal
heart rate data will contain variability at frequencies of up to 1.5 Hz. Foetal heart rate data
will also contain variability at high frequencies, mainly due to respiratory movements. In
adultheartratedata,variabilityisusuallyabsentinthisfrequencyrange. Usingneonataland
foetalheartratedatathereforeprovidesauniqueopportunitytoincludetheeffectofartefact
correctiononhigh-frequencyspectralestimatesintotheevaluation.
(i) Neonataldata. Neonatalheartratedatawereobtainedintheneonatalintensivecareunit
(NICU)oftheMa´ximaMedicalCenter. Three-leadECGsignalsfromaGeneralElectric
Solar 8000M patient monitor were recorded at a sample rate of 240 Hz. In these ECG
signals,QRScomplexesweredetectedusingaquadraticR-fittoreducesamplingerrors.
This resulted in a dataset containing time stamps for the R-peak in all QRS complexes
that were detected inthe recorded signal. Five segments of 192 s that were completely
free of artefacts were selected from this dataset for further analysis. Figure 1(a) shows
theR–Rintervalseriesforoneofthefivesegments.
(ii) Foetal data. Foetal heart rate data were obtained in the obstetrics department of the
Ma´xima Medical Center. During delivery, single-lead direct foetal scalp ECG signals
wererecordedfromaNeoventaSTANs31foetalmonitoratasamplerateof500Hz. A
datasetwithtimestampsfortheR-peakinallQRScomplexesthatweredetectedbythe
foetalmonitorwasobtainedfromthedigitaloutputoftheSTANs31. Fivesegmentsof
192 s that were completely free of artefacts were selected from this dataset for further
analysis. Figure1(b)showstheR–Rintervalseriesforoneofthefivesegments.

1520 CHLPetersetal
(a) Neonatalheartratedata
(b)Foetalheartratedata
Figure1.Examplesofartefact-freeneonatal(a)andfoetal(b)heartratedata.
To simulate artefacts, timestamps were deleted at random positions in the foetal and
neonataldatasegments. Timestampsweredeleteduntilthedesirednumberofartefactswas
achieved. Next, R–Rintervalswerecalculatedfromthesedata, usinglinearinterpolationto
substitutedatathatweremarkedastheartefact. Thisway,theR–Rintervalserieswerecreated
thatsimulatedartefact-correctedheartratedataattendifferentnumbersofartefacts,varying
from5%to50%ofthesegmentlengthinequalsteps. Foreachnumberofartefacts,eachof
thefoetalandneonataldatasegmentswasreusedtogenerate20differentdatasetsfromeach
originalsegment. Thisresultedinatotalof2000differentdatasegmentsthatwereanalysed
bythedevelopedCWT-basedmethodandbytheSTFT.
2.2. NewCWT-basedmethod
ThestandardtechniqueforfrequencyanalysisistheFouriertransform. Whenappliedfortime-
frequencyanalysis,theFouriertransformischaracterizedbyitsconstantresolutionintimeand
frequency,whichisfixedbythechoiceofsamplerateandwindowlength. Consequently,the
time-frequencyplaneofthespectrogramistiledinHeisenbergboxesofconstantdimensions.
FortheanalysisofHRVinthisstudy,thisisamajordisadvantageasthepresenceofcorrected

CWT-basedtime-frequencyanalysisofartefact-correctedHRVdata 1521
Figure 2. Tiling of the time-frequency plane for a dyadic wavelet decomposition. Artefact
locationsareindicatedabovethefigureinblack,andtheaffectedtime-frequencytilesarecoloured
grey.Thewaveletfunctionsψi,mandψi+1,ncorrespondtotheboldoutlinedHeisenbergboxes.
artefacts will influence the calculated spectrogram for the entire window length. However,
artefact correction will mainly affect the higher frequencies in the spectrogram. Therefore,
a shorter time resolution in these frequencies would limit the duration of the influence of
artefact correction and allow for discarding parts of the spectrogram that are affected by
artefactcorrection.
A technique that allows for multi-resolution analysis is the wavelet transform, which
decomposes the input signal by convolution with scaled and dilated functions of a mother
wavelet function (Mallat 1998, Addison 2002, Akansu and Haddad 2001). An important
naturalfeatureofwavelettransformsisthattimeandfrequencyresolutionarescalable,with
the restriction that the area of the Heisenberg boxes must remain constant. Figure 2 shows
the tiling of the scalogram for a traditional dyadic wavelet decomposition. The figure also
illustratesthedurationoftheeffectthatartefactcorrectionhasfordifferentwaveletscales.
Becauseofitsscalabletimeandfrequencyresolution,thewavelettransformqualifiesfor
analysisofnon-stationarysignalsandthereforehasbeensuccessfullyappliedfortheanalysis
ofHRV(Wiklundetal1997,Kimuraetal1998,Pichotetal1999). Adyadicdecomposition
is however far from ideal for the analysis, as the specific frequency bands of interest (Task
force of the European Society of Cardiology and the North American Society of Pacing
Electrophysiology 1996) will not be matched exactly by dyadic scales. Consequently, the
focus of most studies that used the wavelet transform for the analysis of HRV has been on
matchingthesefrequencybands. Elegantsolutionswerefoundintheuseofwaveletpackets
(TanakaandHargens2004)andinintegratingthescalogramoftheCWT(Davidetal2007).
Table1containsanoverviewofthespectralparametersofinterestandtheircorresponding
frequency bands. The very low-frequency (VLF) band reflects the long-term regulation of
the heart rate, including hormonal and thermoregulation. The low-frequency (LF) band is
associated with both the sympathetic and the parasympathetic branches of the autonomic
nervoussystem,whereashigherfrequenciesmainlyreflectparasympatheticnervousactivity.
As vagal nervous activity is modulated by respiration, the main contribution to the power
at high frequencies is found at the respiration frequency. For adults, the high-frequency
(HF)bandiscommonlydefinedas0.15–0.4Hz. Duetoahigherrespirationfrequency, this
frequency band is defined as 0.4–1.5 Hz (VHF) for foetuses and newborns. It is common

1522 CHLPetersetal
Figure3.Fifth-ordersymletmotherwaveletfunction.
Table1.Overviewofspectralparametersofinterest.
Symbol Description Frequencyband
VLF Powerinverylow-frequencyband <0.04Hz
LF Powerinlow-frequencyband 0.04–0.15Hz
HF Powerinhigh-frequencyband 0.15–0.4Hz
VHF Powerinveryhigh-frequencyband(foetus/newborn) 0.4–1.5Hz
TP Totalpower(outsideVLF) 0.04–1.5Hz
LFn LFpowerinnormalizedunits
VHFn VHFpowerinnormalizedunits
LF/VHF LF/VHFratio
to express the powers in the frequency bands of interest in normalized units (LFn, VHFn)
astheseparametersmaymorereliablycharacterizeautonomiccardiovascularcontrol. These
normalizedLFandVHFpowersarecalculatedbydividingthepowersin,respectively,theLF
andVHFbandsbythetotalpower(TP)between0.04and1.5Hz.
Inourapproach,thetimeresolutionofaCWTisexploitedtodiscardpartsofthescalogram
thatareaffectedbyartefactcorrection. AselectionofspecificscalesfromaCWTisusedto
matchthefrequencybandsofinterest. Basedontheadditionalrequirementsoforthogonality
andashortsupportwidth,thefifth-ordersymletwaveletwasselectedfortheanalysisofHRV.
Figure3displaysthemotherwaveletfunctionofthiswavelet. Aleast-squarescalculationwas
usedtoselectthescalesoftheCWTthatcorrespondwiththefrequencybandsofinterest.
Duetotheirbeat-to-beatcharacter,theR–Rintervalseriesarenotequidistantlydistributed
in time. Before performing the CWT, the R–R interval series were transformed into an
equidistant set of data. This was achieved by applying a sample and hold technique to the
R–R interval series. The resulting signal was convolved with a square function of width

CWT-basedtime-frequencyanalysisofartefact-correctedHRVdata 1523
0.5sandenergyequalto1,andthenresampledatarateof4Hz(Petersetal2004,deJong
2000). Thisway, anequidistantdatasetwasobtained, inwhicheachdatapointcorresponds
totheweightedaverageoftheR–Rintervalsinthe0.5ssurroundingthesample. TheCWT
wascalculatedfromscale0.1toscale80instepsof0.1. Tocorrectfortheconvolutionwith
the square function during the resampling procedure, the calculated wavelet coefficients are
dividedbythecoefficientsofthewavelettransformofthissquarefunction. Then,thepower
scalogramwascalculatedaccordingto
|     | (cid:2) (cid:2) |     |     |     |
| --- | --------------- | --- | --- | --- |
|     | (cid:2) (cid:2) |     |     |     |
1 (cid:2) W [n ,s](cid:2)
| P [n,s]= | f (cid:2). |     |     | (1) |
| -------- | ---------- | --- | --- | --- |
| Wf       | (cid:2)    |     |     |     |
C s 2
g
In equation (1), W [n,s] is the corrected wavelet coefficients, s is the scale and C is the
| f   |     |     |     | g   |
| --- | --- | --- | --- | --- |
admissibilityconstantofthemotherwaveletfunction. Thepowersinthefrequencybandsof
interest can be calculated from the power scalogram by time averaging over the duration of
thesegmentandintegratingoverscale,asgivenby
| (cid:3) | (cid:3) |     |     |     |
| ------- | ------- | --- | --- | --- |
1
| P = | P [n,s](cid:3)t(cid:3)s. |     |     | (2) |
| --- | ------------------------ | --- | --- | --- |
| xF  | Wf                       |     |     |     |
T
| s∈xF | n   |     |     |     |
| ---- | --- | --- | --- | --- |
To reduce the effectof corrected artefacts for powers intheHF bands, thematrix A[n,s] is
introducedtoeliminatespecificpartsofthescalogramfromthecalculation. Thepowerinthe
HFbandisthencalculatedby
(cid:4)
(cid:3)
|      | (A[n,s]◦P    | [n,s])            |     |     |
| ---- | ------------ | ----------------- | --- | --- |
| =    | n (cid:4) Wf |                   |     |     |
| P HF |              | (cid:3)t(cid:3)s. |     | (3) |
A[n,s]
| s∈HF | n   |     |     |     |
| ---- | --- | --- | --- | --- |
Inequation(3),(A[n,s]◦P
[n,s])denotestheHadamardproduct,orentrywiseproduct,of
Wf
matricesA[n,s]andP [n,s],whoseelementsaregivenby
Wf
| (A[n,s]◦P | [n,s]) =(A[n,s]) | ·(P [n,s]) | .   | (4) |
| --------- | ---------------- | ---------- | --- | --- |
|           | Wf i,j           | i,j Wf     | i,j |     |
Forartefact-freepartsoftheR–Rintervalseries,theelementsofmatrixA[n,s]areequalto1.
FortheVHFfrequencyband,A[n,s]isequaltozeroaroundlocationsofcorrectedartefacts
for one-third of the support width of scale s, which was considered an acceptable effective
supportwidth. Alongereffectivesupportwidthwouldexcludeunnecessarylargepartsofthe
R–Rintervalseriesfromtheanalysis,whilenotsignificantlycontributingtofurtherreduction
oftheeffectofartefactcorrection. FortheHFfrequencyband,thenumberelementsthatare
set to zero around corrected artefacts were limited to one-third of the support width of the
smallest scale in that frequency band, as it is expected that the effect of artefact correction
oncalculatedpowerswillbesmallerforlargerscales,andlongereffectivesupportwidthsare
undesirable. For the LF and VLF frequency bands, A[n,s] is equal to 1 for all scales for
theentireR–Rintervalseries. BypointwisemultiplyingA[n,s]withthescalogram,partsof
thescalogramthatarestronglyaffectedbyartefactcorrectionarediscardedinthecalculation
ofthepowersinthetwoHFbands.
2.3. Referencemethod
Asareferencemethodfortime-frequencyanalysisofthegeneratedR–Rintervalseries, the
STFT,orwindowedFouriertransform,wasused. IdenticaltothepreprocessingfortheCWT,
theR–Rintervalseriesweretransformedintoanequidistantsetofdatabeforeprocessing. The
STFTwascalculatedusinga256-pointParzenwindowandawindowshiftof0.25s. Before
applicationoftheParzenwindow,theDCoffsetoftheR–Rintervalswithinthewindowwas
removedtopreventspectralleakage. ThecalculatedFouriertransformsaresquaredtoobtain
the power spectrogram, and then corrected for the energy reduction due to the application

1524 CHLPetersetal
Figure 4. Relative deviations in VLF, LF and TP and their standard deviations for both the
CWT-basedmethodandtheSTFT.
oftheParzenwindow(Petersetal2004,deJong2000). Thiscorrectionismadebydividing
the spectrogram by the ratio of the power in the Parzen window and the power in a square
windowofidenticallength. Alsothespectrogramiscorrectedfortheconvolutionoftheinput
signalwiththesquarefunctionbymeansofdivisionbyasquaredsincfunction, theFourier
transformofthesquarefunctionthatwasused(Petersetal2004,deJong2000).
3. Results
All2000segmentsoffoetalandneonatalR–Rintervalserieswithvariousnumbersofcorrected
artefactswereanalysedusingboththeCWT-basedmethodandtheSTFT.Forallcalculated
spectral estimates, the relative deviation from their theoretical value—the value calculated
for the artefact-free data segments—was determined. For both methods, figure 4 shows the
relative deviations in VLF power, LF power and TP for all analysed segments. Figure 5
showstherelativedeviationsintheHFandVHFpowers. Finally,figure6showstherelative
deviationsintheLFnandVHFn.
4. Discussion
4.1. Short-timeFouriertransform
For the STFT analysis of HRV, the calculated powers in the LF and VLF range correspond
wellwiththeirtheoreticalvaluesfordatasetsinwhichupto30%oftheR–Rintervalseries
hasbeenreplacedbyinterpolatedvalues. ThepowersintheHFandVHFrangescalculatedby
STFThoweveraresignificantlysmallerthantheirtheoreticalvalues. Thisdeviationalready
occurs at relative low numbers of corrected artefacts and increases rapidly as this number
increases. This is a direct consequence of the reduced variability in these frequency ranges

CWT-basedtime-frequencyanalysisofartefact-correctedHRVdata 1525
Figure5.RelativedeviationsinHFandVHFandtheirstandarddeviationsforboththeCWT-based
methodandtheSTFT.
Figure6. RelativedeviationsinLFnandVHFnandtheirstandarddeviationsforboththeCWT-
basedmethodandtheSTFT.
duetothereplacementofartefactsbyinterpolatedvalues. AlthoughthedeviationsintheHF
bandaresmallerthanintheVHFband,inbothrangesSTFTanalysiswillnotprovidereliable
parameterswhentheR–Rintervalseriesthatareanalysedoriginallycontainedartefacts.
Consequently,mostotherspectralparametersthatcoverthesefrequencyranges,suchas
TP, VHFn and LF/VHF ratio, can also not be calculated reliably for datasets that originally

1526 CHLPetersetal
contained artefacts. However, for the analysed datasets, the normalized LF power (LFn)
could be calculated with acceptable accuracy as long as less than 25% of the dataset was
replaced by interpolated values to correct for artefacts. This can be explained by the
relatively very large amount of power that is present in the LF range, compared to higher
frequencies. Forthedatasetsthatwereanalysed,thisisquitecommon;however,fordatasets
inwhichthisisnotthecase, itisexpectedthatLFnpowerswillalsobeaffectedbyartefact
correction.
4.2. CWT-basedmethod
SimilartotheSTFTanalysis,theresultsintheVLFdomainfortheCWT-basedmethodremain
unaffected even for very high numbers of corrected artefacts. The calculated powers in the
LF band on the other hand show an underestimation of their theoretical value, which grows
with the number of corrected artefacts, but is acceptable when up to 20% of the dataset has
beenreplacedwithinterpolatedvalues. Thiseffectisduetothetrailingedgeofthefifth-order
symlet’sfrequencyresponseintheHFrange. TheCWTpowersinboththeHFandVHFbands
remain within a few per cent of their theoretical values even when up to 50% of the dataset
hasbeenreplacedwithinterpolatedvalues. Thestandarddeviationofthecalculatedpowers
inthesefrequencybandsincreaseswiththenumberofcorrectedartefacts. Mostlikely,thisis
theresultofthenon-stationarityoftheR–Rintervalseriesthatareanalysed. Thecalculated
powers in the HF range will therefore fluctuate slightly, dependent on the exact location of
artefactsintheoriginaldatasets.
Due to the relatively large amount of power in the LF range, the calculated TPs show
almost similar underestimations as the calculated LF powers and therefore the normalized
LFpowerisonlyslightlyunderestimated. TheLF/VHFratioisunderestimated,whichisthe
directconsequenceoftheunderestimationoftheLFpower. Logically, VHFnoverestimates
its theoretical value. Nevertheless, also for these parameters, the correspondence with their
theoretical values is acceptable when up to 20% of the dataset has been replaced with
interpolatedvalues.
5. Conclusion
Time-frequency analysis of HRV by means of the STFT is sensitive to artefact correction.
Although LF parameters can be calculated accurately when up to 30% of an R–R interval
series is replaced by interpolated values, it is not possible to calculate HF parameters
reliably if artefacts were originally present in the dataset. The STFT analysis is therefore
notsuitablefortime-frequencyanalysisofheartratedatathatarenotguaranteedtobefreeof
artefacts.
BydevelopingaCWT-basedmethodfortime-frequencyanalysisofHRV,partsofR–R
interval series that originally contained artefacts can be discarded in the calculation of HF
spectralestimates. Byusingthisapproach,HFspectralparameterscanbecalculatedreliably
evenwhenextremelylargepartsofdataaremissingduetoartefacts. However,comparedto
STFT,thecalculationofspectralparametersintheLFrangeismoresensitivetoartefactsbut
acceptablefordatasetsinwhichupto20%ofthedatahavebeenreplacedwithinterpolated
valuestocorrectforartefacts.
The developed CWT-based method offers a valuable alternative for time-frequency
analysis of HRV data that contain artefacts, for example, foetal heart rate data from non-
invasiverecordingsofthefoetalECG.

CWT-basedtime-frequencyanalysisofartefact-correctedHRVdata 1527
References
AcharyaU,JosephK,KannathalN,LimCMandSuriJ2006Heartratevariability: areviewMed.Biol.Eng.
Comput.441031–51
AddisonP2002TheIllustratedWaveletTransformHandbook(Bristol:InstituteofPhysicsPublishing)
AkansuAandHaddadR2001MultiresolutionSignalDecomposition(NewYork:Academic)
AkselrodS,GordonD,UbelF,ShannonD,BergerAandCohenR1981Powerspectrumanalysisofheartrate
fluctuation:aquantitativeprobeofbeat-to-beatcardiovascularcontrolScience213220–2
CeruttiS,CivardiS,BianchiA,SignoriniM,FerrazziEandPardiG1989Spectralanalysisofantepartumheartrate
variabilityClin.Phys.Physiol.Meas.10(Suppl.B)27–31
CliffordGandTarassenkoL2005QuantifyingerrorsinspectralestimatesofHRVduetobeatreplacementand
resamplingIEEETrans.Biomed.Eng.53630–8
DavidM,HirschM,ToledoEandAkselrodS2007Anestimateoffetalautonomicstatebytime-frequencyanalysis
offetalheartratevariabilityJ.Appl.Physiol.1021057–64
deJongW2000Bloodpressurevariabilityinneonates:withaspecialfocusonsignalacquisitionandsignalprocessing
PhDThesisEindhovenUniversityofTechnology
KimuraY,OkamuraK,WatanabeT,YaegashiN,UeharaSandYajimaA1998Time-frequencyanalysisoffetal
heartbeatfluctuationusingwavelettransformAm.J.Physiol.275H1993–9
LewisM2003ReviewofelectromagneticsourceinvestigationsofthefetalheartMed.Eng.Phys.25801–10
MainardiL,BianchiAandCeruttiS2002Time-frequencyandtime-varyinganalysisforassessingthedynamic
responsesofcardiovascularcontrolCrit.Rev.Biomed.Eng.30175–217
MallatS1998AWaveletTourofSignalProcessing(NewYork:Academic)
NotariusCandFlorasJ2001Limitationsoftheuseofspectralanalysisofheartratevariabilityfortheestimationof
cardiacsympatheticactivityinheartfailureEuropace329–38
ParatiG,ManciaG,RienzoMD,CastiglioniP,TaylorJandStudingerP2006Point:counterpoint: cardiovascular
variabilityis/isnotanindexofautonomiccontrolofcirculationJ.Appl.Physiol.101676–82
PetersC,tenBroekeE,AndriessenP,VermeulenB,BerendsenR,WijnPandOeiS2004Beat-to-beatdetectionof
fetalheartrate: DopplerultrasoundcardiotocographycomparedtodirectECGcardiotocographyintimeand
frequencydomainPhysiol.Meas.25585–93
PetersC,VullingsR,BergmansJ,OeiSandWijnP2008Theeffectofartifactcorrectiononspectralestimatesof
heartratevariabilityConf.Proc.IEEEEng.Med.Biol.Soc.20082669–72
PichotV,GaspozJ,MolliexS,AntoniadisA,BussoT,RocheF,CostesF,QuintinL,LacourJandBarthe´le´myJ1999
WavelettransformtoquantifyheartratevariabilityandtoassessitsinstantaneouschangesJ.Appl.Physiol.
861081–91
RantonenT,EkholmE,SiiraS,Metsa¨la¨T,LeinoR,EkbladUandVa¨lima¨kiI2001Periodicspectralcomponents
offetalheartratevariabilityreflectthechangesincordarterialbasedeficitvalues: apreliminaryreportEarly
Hum.Dev.60233–8
SiiraS,OjalaT,VahlbergT,JalonenJ,Va¨lima¨kiI,Rose´nKandEkholmE2005Markedfetalacidosisandspecific
changes in power spectrum analysis of fetal heart rate variability recorded during the last hour of labour
BJOG112418–23
TanakaKandHargensA2004WaveletpackettransformforR–RintervalvariabilityMed.Eng.Phys.26313–9
TaskforceoftheEuropeanSocietyofCardiologyandtheNorthAmericanSocietyofPacingElectrophysiology
1996 Heart rate variability: standards of measurement, physiological interpretation, and clinical use
Circulation931043–65
vanLaarJ,PetersC,VullingsR,HoutermanS,BergmansJandOeiS2010Fetalautonomicresponsetosevere
acidaemiaduringlabourBJOG117429–37
vanLaarJ,PorathM,PetersCandOeiS2008Spectralanalysisoffetalheartratevariabilityforfetalsurveillance:
reviewoftheliteratureActaObstet.Gynecol.Scand.87300–6
WiklundU,AkayMandNiklassonU1997Short-termanalysisofheart-ratevariabilitybyadaptedwavelettransforms
IEEEEng.Med.Biol.Mag.16113–8
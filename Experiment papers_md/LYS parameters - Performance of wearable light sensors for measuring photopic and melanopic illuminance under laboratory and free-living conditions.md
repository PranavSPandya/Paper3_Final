SLEEPJ,2026,49,1–13
doi:10.1093/sleep/zsaf358
AdvanceAccesspublication13November2025
OriginalArticle
Original Article
Performance of wearable light sensors for measuring
photopic and melanopic illuminance under laboratory
and free-living conditions
AsukaIshihara *,RobertJ.Brychta ,SamuelR.LaMunion ,SuzanneMcGehee,MagalyDonayre,OliviaJordan,KyndallDavis,
GabrielSanchez,LindseySmith,StephanieT.Chung,AmberB.CourvilleandKongY.Chen*
NationalInstituteofDiabetesandDigestiveandKidneyDiseases,NationalInstitutesofHealth,Bethesda,MD,UnitedStates
*Correspondingauthors.AsukaIshihara,NationalInstituteofDiabetesandDigestiveandKidneyDiseases,9000RockvillePike,10CenterDrive5N323,Bethesda,
MD20892,UnitedStates.Email:asuka.ishihara@nih.govandKongY.Chen,NationalInstituteofDiabetesandDigestiveandKidneyDiseases,9000RockvillePike,
10CenterDrive5N323A,Bethesda,MD20892,UnitedStates.Email:chenkong@niddk.nih.gov.
Abstract
Wearablesensorsarecommonlyusedtostudytheeffectsoffree-livinglightexposureonphysiologicaloutcomes;however,rigorous
validation of their performance has been limited.To address this gap,we quantified the accuracy and precision of light measure-
mentsfromfourcommonlyusedwearablesensors(LYS,ActLumus,GENEActiv,andActiGraphwGT3X-BT).Eightdevicesfromeach
manufacturer (32 total) were compared to a criterion spectrometer under light-emittingdiode–generated cool (peak∼460 nm) and
warm (peak ∼600 nm) white light at indoor intensities (2–1000 lux) and broad-spectrum sunlight (5 k–100 k lux).We found linear
responsesforallsensorsbetween50and20kphotopiclux,irrespectiveofspectrum,butdetectionrangesvaried:ActLumus(2–100k
lux),LYS (2–60 k lux),GENEActiv (2–40 k lux),and ActiGraph (50–20 k lux).Accuracy—percent difference to criterion—also differed:
ActLumus(+3.3±13.4%,mean±SD),LYS(+19.5±42.0%),andbelow−20%forGENEActivandActiGraph.Interdevicevariabilitywas
consistentlylowestforActLumus,andmelanopicilluminancewaslessaccuratewithLYSthanActLumus,particularlyinwarmindoor
light.Laboratoryfindingswerecomparedto1-weekfree-livinglightmeasurementsin21individualsconcurrentlywearingthemostand
leastaccuratesensorsinrandomizedpositionsonthenondominantwrist.Themean24hluxperparticipantwascorrelated(r=0.91,
p<.001)butlowerforActiGraph(77.3±68.5lux)thanActLumus(515.0±436.0lux;p<.001)withthegreatestdifferences≤100lux
(p<.001),consistentwiththelaboratoryresults.Thus,differencesinilluminancerangeandaccuracycanleadtolargedisparitiesin
free-livingmeasuresacrossmanufacturers,suggestinganeedforgreatertechnicalstandardization.
Clinical Trial: A Natural History Study of Metabolic Sizing in Health and Disease. https://clinicaltrials.gov/study/NCT05398783
(NCT05398783).
Keywords:lightexposure;wearables;sensitivity;variability
Submitted:8August,2025;Revised:30October,2025;Accepted:3November,2025
PublishedbyOxfordUniversityPressonbehalfofSleepResearchSociety2025.
Thisworkiswrittenby(a)USGovernmentemployee(s)andisinthepublicdomainintheUS.

2 | SLEEPJ,2026,Vol.49,No.2
GraphicalAbstract
StatementofSignificance
Emerging evidence suggests light exposure has a greater impact on human health than previously appreciated.Wearable sensors
embeddedwithlight-measuringcapabilitiescanplayacrucialroleinstudyingtherelationshipbetweenlightandphysiologicalhealth.
Thus,theperformanceoflightsensorsshouldbethoroughlyevaluated.Wetestedthedetectionlimits,accuracy,andvariabilityoffour
commonlyusedwearablelightsensorstoindoorandoutdoorintensitiesandspectrareflectiveofthereal-worldlightenvironmentand
assessedthetranslatabilityoflaboratory-basedobservationsinafree-livingpilotstudy.Ourfindingsdemonstratebroadvariationin
accuracywithinandacrossmanufacturersthatemphasizestheneedforrigoroussensorevaluationandhighlightsthechallengesof
interpretingilluminancemeasuresacrossstudiesdeployingdifferentlightsensors.
Introduction
exposureandhavebeenusedtostudytherelationshipofphotic
Lightinfluencesvariousaspectsofhumanhealth[1–3],including exposure to physiological health outcomes such as sleep [12],
theentrainmentofcircadianrhythmsandtheregulationofsleep- daytimeactivity[13],type2diabetes[14,15],andcardiometabolic
/wake cycles [4]. Laboratory-based studies have demonstrated mortality[16].
thattheconsequencesandbenefitsoflightexposuredependon Despite the advantages sensors offer in collecting objective
variousfactors,suchasintensity,duration,wavelength,andtim- lightinformationonanindividualbasisundermorenaturalistic
ing[5–9].Althoughthesefindingsprovidemechanisticinsightinto conditions,fewindependentstudieshavesystematicallyinvesti-
the physiological responses to light in controlled settings,free- gatedtheaccuracyorprecisionoftheselightsensorsagainstacri-
living data are also needed to determine how they translate to terion standard measurement [17–21].Moreover,manufacturer-
thedailylightenvironment,wherelightlevelscanvarydrastically provided technical information on hardware specifications and
[10]. Self-report can be used to estimate free-living light expo- performance is typically limited [22]. This lack of comparative
sures,butitssubjectivityintroducespotentialbiasesonexposure detailcancomplicateinterpretationofresultsobtainedwithdif-
durationsandintensities[11].Wearablelightsensors,ontheother ferentsensors.Forexample,onerecentmeta-analysisfoundmea-
hand,offeramoreobjectivemethodtoquantifyreal-worldlight suredlightlevelsofofficeworkersrangedbroadly,averagingfrom

|     |     |     |     |     |     |     |     |     |     |     | Ishiharaetal. | | 3 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- |
Wearablelightsensorspecifications∗
Table1.
|     |     | LYS |     |     | ActLumus |     |     | GENEActiv |     |     | wGT3x-BT |     |
| --- | --- | --- | --- | --- | -------- | --- | --- | --------- | --- | --- | -------- | --- |
Manufacturer LYSTechnologies CondorInstruments Activinsights ActiGraph
Sensors Ambientlight Accelerometer Accelerometer Accelerometer
|     |     | Accelerometer |     |     | Ambientlight    |     |     | Ambientlight |     |     | Ambientlight |     |
| --- | --- | ------------- | --- | --- | --------------- | --- | --- | ------------ | --- | --- | ------------ | --- |
|     |     |               |     |     | Skintemperature |     |     | Temperature  |     |     |              |     |
Lightmeasurements Photopic,Melanopic Photopic,Melanopic Photopic Photopic
| Spectralranges         |     | 380–1100nm |     |     | ∼360–1100nm  |     |     | Unknown   |     |     | Unknown |     |
| ---------------------- | --- | ---------- | --- | --- | ------------ | --- | --- | --------- | --- | --- | ------- | --- |
|                        |     | (RGB)      |     |     | (10channels) |     |     |           |     |     |         |     |
| Illuminanceranges(lux) |     | 0–100000   |     |     | 1–100000     |     |     | 0–20000   |     |     | 5000    |     |
| Accuracyasadvised      |     | 90%–95%    |     |     | 90%          |     |     | ±90%      |     |     | Unknown |     |
|                        |     | (0–500lx)  |     |     | (1000lux)    |     |     | (1000lux) |     |     |         |     |
∗Obtainedfromthemanufacturermanualsandwebsites.
72to1134lux[23].However,theninestudiesincorporatedinthe ongoingstudiesinourlaboratoryandthoseofourcollaborators.
analysis each had distinct designs and included eight different SpecificationsforeachsensorarelistedinTable1.
lightsensors,makingitdifficulttodeterminewhatproportionof
|     |     |     |     |     |     | Protocol | for technical | validation |     | in the | laboratory. | We con- |
| --- | --- | --- | --- | --- | --- | -------- | ------------- | ---------- | --- | ------ | ----------- | ------- |
thevariationwasduetodifferencesinactuallightenvironments
versuspotentialdisparitiesinsensorperformance[23]. ductedstudiesunderawiderangeoflightintensitiesandmultiple
spectra.Totestlightsensorperformanceinindoorlight(≤80lux)
Althoughwearablelightsensorshavetraditionallymeasured
photopicilluminance,weightedtomatchthespectrumofimage- and outdoor conditions, 32 devices, 8 from each manufacturer,
forming cone photoreceptors (peak at ∼555 nm), some models were placed randomly on a flat surface (26 × 42 cm) around a
criterionspectrometerlocatedinthecenter(samplesetupshown
| also estimate | melanopic illuminance. |     | This | metric reflects | the |     |     |     |     |     |     |     |
| ------------- | ---------------------- | --- | ---- | --------------- | --- | --- | --- | --- | --- | --- | --- | --- |
∼480
spectral sensitivity of melanopsin (peak at nm), the pho- in Figure1A). The devices were spaced to mitigate obstruction
topigment of intrinsically photosensitive retinal ganglion cells orreflectionfromencasings,accountforthevarieddimensions
thatplayanimportantroleintheregulationofsleep–wakecycles, ofeachsensor,andeaseswappingofdevicesbetweentrials.For
circadianprocesses,andothernonvisualresponsesgovernedby brighter indoor light (100–1000 lux), sixteen sensors (four from
|     |     |     |     |     |     | each manufacturer) |     | were | concurrently | tested | at a | time in each |
| --- | --- | --- | --- | --- | --- | ------------------ | --- | ---- | ------------ | ------ | ---- | ------------ |
thesuprachiasmaticnucleus[24–26].Despiteitsnotedbiological
relevance[7],toourknowledge,thevalidityofmelanopicoutput trial to minimize possible deviations from the centrally located
fromwearablesensorshasnotbeenevaluated. spectrometer. When measured with the criterion spectrometer,
To better facilitate comparison of light measurements col- lux values in the test areas were determined to deviate <10%
lected using different wearable sensors, greater technical eval- at all tested intensities, in accordance with 2024 International
|           |                           |     |     |                |       | Electrotechnical |     | Commission | testing | standards | [29] | (Figure1A). |
| --------- | ------------------------- | --- | --- | -------------- | ----- | ---------------- | --- | ---------- | ------- | --------- | ---- | ----------- |
| uation of | their hardware components |     | and | software-based | algo- |                  |     |            |         |           |      |             |
rithms is needed.Thus,we assessed the reliability and validity All indoor light testing took place in a box with walls covered
offourcurrentlyavailablewearablelightsensorstostandardized by light-absorbing, nonreflective black sheets (Edmund Optics,
stimuliinthelabandunderfree-livingconditions.Wedesigned Barrington, NJ, USA) to minimize reflection and maximize uni-
thisinvestigationaspartoftheinitialverificationstepproposed formity of the projected light. Light-emitting diode (LED bulbs
intheV3+framework—asetofguidelinesputforthbytheDigital (GECyncSmartLED,GELighting)withadjustableintensityand
spectralcontentwereusedtogeneratepolychromaticwhitelight
MedicineSocietytoevaluatebiometricmonitoringtechnologies
foruseinclinicalresearch[27,28].Theprimaryaimofthisstudy withspectratypicalofindoorsettings,including“coolwhite”light
was to quantify the accuracy and variability of these research- with a peak at 460 nm and “warm white” light with a peak at
and consumer-grade wearable light sensors that measure pho- 600 nm (Figure1B).The indoor light trials included six dimmer
topic illuminance in a range of intensities and spectra typical (2,5,10,30,50,80lux)andfivebrighter(100,300,500,700,1000
|               |                    |     |           |               |      | lux) target | intensities | of  | each spectrum. | Each | indoor | intensity |
| ------------- | ------------------ | --- | --------- | ------------- | ---- | ----------- | ----------- | --- | -------------- | ---- | ------ | --------- |
| of real-world | indoor and outdoor |     | settings. | Our secondary | aims |             |             |     |                |      |        |           |
included evaluating the accuracy and precision of melanopic waspresentedinarandomizedorderfor30minutes,followedby
measurementsintwoofthedevicesthatprovideitandtodeter- a10-minuteperiodofdarknesstominimizepotentialcarryover
minehowlaboratoryfindingstranslatetoreal-worldconditionsin effects(hysteresis).Dimmerindoorlightwastestedwithonelight
apilotstudyofsimultaneouswearoftwodevicescapturingdaily bulbplacedapproximately200cmawayfromthelightsensors.
|     |     |     |     |     |     | Brighter | intensity | indoor | light trials | required | two | bulbs placed |
| --- | --- | --- | --- | --- | --- | -------- | --------- | ------ | ------------ | -------- | --- | ------------ |
free-livinglightexposure.
approximately100cmawayfromthelightsensors.Full-spectrum
outdoorlightwasrecordedfrommiddaytosunsetbyallsensors
placedinanunobstructedlocation(openfieldorlargecourtyard)
Methods
onbothovercast(5k,8k,10klux)andsunnydays(20k,30k,40k,
Laboratoryassessmentwithstandardizedstimuli 50k,60k,90k,100klux)betweenAugustandNovember.Sample
| Wearable | light sensors. | Wearable | light | sensors from | four |           |     |           |              |     |        |             |
| -------- | -------------- | -------- | ----- | ------------ | ---- | --------- | --- | --------- | ------------ | --- | ------ | ----------- |
|          |                |          |       |              |      | data from | the | criterion | spectrometer | for | indoor | and outdoor |
manufacturers, LYS (LYS Technologies, Copenhagen, Denmark), testingconditionsareshowninFigure1C.
| ActLumus | (Condor Instruments, | São | Paulo, | Brazil), GENEActiv |     |     |     |     |     |     |     |     |
| -------- | -------------------- | --- | ------ | ------------------ | --- | --- | --- | --- | --- | --- | --- | --- |
(Activinsights, Cambridgeshire, UK), and ActiGraph wGT3X-BT Analysis. TheLYSandActLumusdeviceswereprogrammedto
(ActiGraph,Pensacola,FL,USA),werecomparedagainstanNIST- sampleevery15sand10susingtheLYSCollectapplicationand
calibrated criterion spectrometer (ILT560-A, International Light ActStudio Software (ver.2.2.0),respectively.The GENEActiv and
Technologies, Peabody, MA, USA). These four wearable sensors ActiGraphdeviceswereprogrammedtocollectrawdataat30Hz,
wereselectedfortheiravailabilityatthetimeoftestingandusein which was later exported in 10-s epoch for analysis using the

4 | SLEEPJ,2026,Vol.49,No.2
Figure1.Lightsensortestingconditionsandsampledata.(A)Lightsensorswererandomlyplacedsurroundingthespectrometer(samplelayoutleft)
withinthe≤10%deviationrange(outlinedrectangle)(right).(B)Spectraldistributionofthetestedlightconditions,includingcoolwhite(left),warm
white(center),andsunlight(right).Thesunlightfigureshowsthemeasuredspectraldistribution(solidline)andLOESSsmoothing(boldline)withSE
(shaded).(C)Sampledatafromthecriterionspectrometerunderindoor(left)andoutdoor(right)lightconditions.
GENEActivWindowsSoftwarefromActivinsights(ver.4.0.9)and was assessed with concordance correlation coefficients (CCCs)
ActiLifefromActiGraphwGT3X-BT(ver.6.13.4),respectively.The with95%confidenceintervals.ModifiedBland–Altmanplots,with
y-axis
mean of a 3-minute steady-state period at each light condition absolute differences to the criterion on the vs. criterion
and intensity was used to compare measurements from each readingsonthex-axis,wereusedtoevaluatetheagreementbias
devicetothecriterion,expressedasmean±SDofalldevicesper
|     |     |     |     | between | the light sensors | and the criterion | for each condition |
| --- | --- | --- | --- | ------- | ----------------- | ----------------- | ------------------ |
manufacturer.Allwearablelightsensorsprovidephotopicillumi- (dimmer≤80lux,brighter100–1000lux,outdoor5k–100klux).
nancevalues,whereasmelanopicilluminancewasonlyavailable Interdevicevariabilitywasdeterminedbythestandarddeviation
fortheLYSandActLumussensors.Photopicandmelanopicillu- of percent error. All data were analyzed and visualized with R
| minanceforthecriterionspectrometerwascalculatedusingthe |                 |                        |            | studio(ver.4.2.0). |     |     |     |
| ------------------------------------------------------- | --------------- | ---------------------- | ---------- | ------------------ | --- | --- | --- |
| conversion                                              | factors derived | from the International | Commission |                    |     |     |     |
Free-livingcomparisons
| on Illumination | (CIE) [30, | 31]. The strength | of the relationship |     |     |     |     |
| --------------- | ---------- | ----------------- | ------------------- | --- | --- | --- | --- |
betweenthelightsensorandspectrometeroutputwasassessed Twenty-one healthy adult participants (16F/5M; 35.1±15.9 yrs)
| using the marginal | R2 (R2) | values from | mixed-effects models |                                                          |     |     |     |
| ------------------ | ------- | ----------- | -------------------- | -------------------------------------------------------- | --- | --- | --- |
|                    |         | m           |                      | fromanongoingnaturalhistorystudyoftherelationshipbetween |     |     |     |
with device-specific random intercepts, while their agreement bodysize,composition,andenergymetabolism(ClinicalTrials.gov

Ishiharaetal. | 5
identifiernumber:NCT05398783)wererecruitedtoconcurrently
weartheActLumusandActiGraphwGT3X-BTfor1weekinfree
living.Thetwowearablesensorswereoriginallyselectedtomea-
surefree-livinglightexposure,sleep,andphysicalactivityinthis
| protocol.The | ActiGraph |     | wGT3X-BT | provides | raw | accelerometer |     |     |     |     |     |     |
| ------------ | --------- | --- | -------- | -------- | --- | ------------- | --- | --- | --- | --- | --- | --- |
data,employsvalidatedalgorithmsforstepcount[32]andsleep
| scoring | [33, 34], | and has | been | incorporated | in  | large-scale, | US- |     |     |     |     |     |
| ------- | --------- | ------- | ---- | ------------ | --- | ------------ | --- | --- | --- | --- | --- | --- |
basedstudies[35].TheCondorActLumusdevicewasnewlyavail-
abletoresearchersatthetimeoftestingandcapableofmeasuring
lightintensityineightseparatespectralbandsandnear-infrared
| wavelengths | (ActLumus |             | manual | ver.2.1.0).These |     | two | wearable    |     |     |     |     |     |
| ----------- | --------- | ----------- | ------ | ---------------- | --- | --- | ----------- | --- | --- | --- | --- | --- |
| sensors     | also had  | contrasting |        | performance      | in  | the | laboratory- |     |     |     |     |     |
basedtestunderbothindoorandoutdoorconditions.Participants
| were instructed    |             | to wear      | both sensors | for             | 7 days          | (24      | hours/day) |     |     |     |     |     |
| ------------------ | ----------- | ------------ | ------------ | --------------- | --------------- | -------- | ---------- | --- | --- | --- | --- | --- |
| on their           | nondominant |              | wrist,       | with randomized |                 | proximal | and        |     |     |     |     |     |
| distal placement.A |             | rolling      | accruement   |                 | of participants |          | ensured    |     |     |     |     |     |
| a random           | seasonal    | distribution |              | of assessment   |                 | periods, | which      |     |     |     |     |     |
occurredbetweenmid-April2024andMayof2025(TableS1).Each
participantreceivedauniquecombinationfromthe9available
ActLumusand13differentActiGraphdevices.ActLumusdevices
| were programmed |     | to sample |     | every 60 | s using | ActStudio | (ver |     |     |     |     |     |
| --------------- | --- | --------- | --- | -------- | ------- | --------- | ---- | --- | --- | --- | --- | --- |
2.2.0).ActiGraphcollectedrawdataat30Hzwithidlesleepmode
| disabled,      | which | was later  | exported | in           | 60-s epochs | for     | analysis |     |     |     |     |     |
| -------------- | ----- | ---------- | -------- | ------------ | ----------- | ------- | -------- | --- | --- | --- | --- | --- |
| using ActiLife | (ver  | 6.13.4).   | Periods  | of ActiGraph |             | nonwear | were     |     |     |     |     |     |
| detected       | using | a modified | version  | of           | Troiano’s   | method  | [36]—    |     |     |     |     |     |
≥60
| zero activity | counts | in  | all three | cardinal | axes | for | minutes. |     |     |     |     |     |
| ------------- | ------ | --- | --------- | -------- | ---- | --- | -------- | --- | --- | --- | --- | --- |
Outputfromthemanufacturer-described“off-wrist”capacitance
| sensor was | used | to detect | ActLumus | nonwear. |     | Only | periods of |     |     |     |     |     |
| ---------- | ---- | --------- | -------- | -------- | --- | ---- | ---------- | --- | --- | --- | --- | --- |
simultaneouswearondayswith≥10h[36]ofconcurrentwear
| were used | for | analyses. | Pearson’s | correlation |     | was | applied to |     |     |     |     |     |
| --------- | --- | --------- | --------- | ----------- | --- | --- | ---------- | --- | --- | --- | --- | --- |
Figure2.Lightsensordetectionlimitsundercoolandwarmindoor
assess the relationship between the 24-hour mean lux outputs whitelight.Percentageofdevicesfromeachmanufacturerdetectinglux
forthetwodevicesinthefreeliving.PairedWilcoxonsigned-rank output>0luxundertargetilluminancebelow1000luxin(A)cooland
(B)warmindoorlight.
testwasusedtocomparethepercentofweartimespentinfour
illuminancecategories(0,1–100,100–1000,>1000lux).
Results
|     |     |     |     |     |     |     |     | (Figure S2).The | output of | GENEActiv | and | LYS were both linear |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --------- | --------- | --- | -------------------- |
Detectionlimitsandlinearityforphotopicilluminance with the criterion below a plateau range (spectrometer values
|     |     |     |     |     |     |     |     | of 40 k–60 | k lux). Above | this range, | as  | source light intensity |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ------------- | ----------- | --- | ---------------------- |
Wefirstdescribetheperformanceofeachwearablelightsensor
increased,themeanluxvaluesremainedrelativelyconsistentand
intermsofitsminimumdetectionthreshold,linearity,andsatu-
belowthecriterion(Figure3A,TableS2).Thus,forbothsensors,
rationintensity.
correlationtothecriterionwasweakerinoutdoorthaninindoor
| All tested | indoor | light | intensities | were | detected | by  | 100% of |     |     |     |     |     |
| ---------- | ------ | ----- | ----------- | ---- | -------- | --- | ------- | --- | --- | --- | --- | --- |
conditions(FigureS2).TheActiGraphwGT3X-BThadanarrower
ActLumus devices (Figure2A and B). Over 85% of LYS devices ∼50 and∼20
|     |     |     |     |     |     |     |     | linear response | range, between |     |     | k lux, with most |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------- | -------------- | --- | --- | ---------------- |
alsodetectedlightateachintensity.AbouthalfoftheGENEActiv
ActiGraphwGT3X-BTdevicesoutputting0luxatcriterioninten-
devicesdidnotdetectanylightat2lux,but100%ofthedevices
sities<100luxandallwGT3X-BTdevicessaturatingat∼20klux
| detected | all other | photopic | intensities |     | (≥5 lux). | No  | ActiGraph |     |     |     |     |     |
| -------- | --------- | -------- | ----------- | --- | --------- | --- | --------- | --- | --- | --- | --- | --- |
(Figure3AandS2,TableS2).Consequently,ActiGraphwGT3X-BT
wGT3X-BTdevicesdetectedlight≤30lux,onedeviceregistered
showedweakercorrelationsindimmerindoor(R2
|            |       |       |         |             |     |           |         |     |     |     |     | m =0.22forcool |
| ---------- | ----- | ----- | ------- | ----------- | --- | --------- | ------- | --- | --- | --- | --- | -------------- |
| a non-zero | value | at 50 | lux,and | 100% device |     | detection | was not |     |     |     |     |                |
andR2 =0.21forwarmwhite)andoutdoorlightR2=0.37)thanin
achieveduntil300lux.Resultsforallsensorswerelargelysimilar m m
|                                                         |     |     |     |     |     |     |     | brighterindoorlight(R2 | =0.85)(FigureS2).Therangeoflinearity |     |     |     |
| ------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | ---------------------- | ------------------------------------ | --- | --- | --- |
| forcool(Figs.2AandS1A)andwarm(Figs.2BandS1B)whitelight. |     |     |     |     |     |     |     |                        | m                                    |     |     |     |
andcorrelationforeachmanufacturerwaslargelyconsistentin
Intermittentdropout—anabsenceofluxmeasurementsduring
warmandcoolindoorlight(Figures3A,S2,andS3).
| the 3-minute | period | sampled     |     | for analysis—was |             | observed | for  |     |     |     |     |     |
| ------------ | ------ | ----------- | --- | ---------------- | ----------- | -------- | ---- | --- | --- | --- | --- | --- |
| all but      | three  | LYS devices | at  | various          | intensities | (Figure  | S1). |     |     |     |     |     |
Accuracyofphotopicilluminancebetweenlightsensors
| We excluded | one | LYS | device | with consistent |     | dropout | from |     |     |     |     |     |
| ----------- | --- | --- | ------ | --------------- | --- | ------- | ---- | --- | --- | --- | --- | --- |
andcriterion
| further | analysis | (LYS2 | in Figure | S1). | None of | the | other light |     |     |     |     |     |
| ------- | -------- | ----- | --------- | ---- | ------- | --- | ----------- | --- | --- | --- | --- | --- |
sensors had any dropouts during the data collection period Theagreementofeachlightsensorwiththecriterionspectrom-
(FigureS1). eterwasfurtherevaluatedusingthepercentdifferenceateach
The output of devices from each manufacturer was plotted tested intensity (Figure3B), CCCs for dimmer indoor, brighter
against the criterion spectrometer measurements to examine indoor, and outdoor conditions (Figure4), and modified Bland–
linearityandcorrelation(Figure3A,FigureS2).ActLumusdevice Altman plots (Figure S4). Overall, ActLumus had the smallest
measurementswerelinearandhighlycorrelatedtothecriterion averagepercenterroracrossallintensities(3.3±13.4%),whileLYS
spectrometervaluesthroughoutthetestedintensityrange(R2> (19.5±42.0%),GENEActiv(−35.7±24.2%),andActiGraphwGT3X-
m
BT(−68.0±37.1%)over/under-reportedby∼6–20foldcompared
| 0.99 for | all testing | conditions), |     | with no | observable |     | saturation |     |     |     |     |     |
| -------- | ----------- | ------------ | --- | ------- | ---------- | --- | ---------- | --- | --- | --- | --- | --- |

6 | SLEEPJ,2026,Vol.49,No.2
Figure3.Photopiclightmeasurementaccuracybyawearablesensor.(A)Photopicilluminanceforeachsensorplottedagainstthecriterionspectrometer.
Individualpointsrepresentanaverageoverastable3-minuteperiodfromonedeviceateachtargetintensity.Symbolsrepresentwarmwhite(circle)
andoutdoor(triangle)lightconditions.Dashedlineisthelineofidentity.(B)Deviationfromcriterion,shownasmeanpercenterror±SDofalldevices
ateachtargetintensity.Darkershaderepresenting±10%andlightershaderepresenting±20%range.Warmwhite(circle),outdoorlight(triangles).
toActLumus.However,eachsensordemonstrateddifferentpat-
ternsofaccuracyandagreementoverthetestedintensityrange.
| While   | the concordance |              | of LYS | and the    | criterion | was high   |
| ------- | --------------- | ------------ | ------ | ---------- | --------- | ---------- |
| in both | dimmer          | and brighter | indoor | conditions |           | (CCC>0.75) |
(Figure4),themeandifferenceswere+46.8±25.4%and+37.7±
15.0%(mean±SD%),respectively(Figure3B,FigureS4).Inoutdoor
| conditions, | LYS under-reported |     | compared |     | to and | had lower |
| ----------- | ------------------ | --- | -------- | --- | ------ | --------- |
agreementwiththecriterion(−30.9±29.1%,CCC=0.5)(Figure3B,
| Figure4),partially |     | due to an | apparent | saturation |     | near 60 k lux |
| ------------------ | --- | --------- | -------- | ---------- | --- | ------------- |
(FigureS2).Thedifferencetothecriterion,however,wassmallest
(<20%)between5kand10kluxofoutdoorlight(TableS2).
ActLumusreadingsweregenerallywithin20%ofthecriterion
forindoorconditions,withminimaldifferencesinbrighterindoor
light(0.8±0.9%)(Figure3B,TableS2).AlthoughActLumusdevices
tendedtounder-reportindimmerindoorlight(−8.3±9.0%)and
over-reportinoutdoorlight(+19.6±6.6%),highconcordancewas
observedinallthreeconditions(CCC>0.95)(Figure4).
TheagreementforGENEActivwasmoderatelyhighindimmer
| (CCC>0.8)     | and       | brighter (CCC>0.7) |             | indoor | light           | conditions. |
| ------------- | --------- | ------------------ | ----------- | ------ | --------------- | ----------- |
| For ActiGraph | wGT3X-BT, |                    | concordance | was    | high            | in brighter |
| (CCC>0.85)    | but poor  | for dimmer         |             | indoor | light (CCC>0.2) | due         |
tolowdetectabilitybelow300lux(Figures4andS2).Meansfor
| GENEActiv     | and ActiGraph |             | wGT3X-BT      | were       | consistently  | below        |
| ------------- | ------------- | ----------- | ------------- | ---------- | ------------- | ------------ |
|               |               |             | (−31.2±30.6%; |            | −93.1±23.6%)  |              |
| the criterion | for           | both dimmer |               |            |               |              |
| and brighter  | indoor        | conditions  | (−28.8±10.7%; |            | −26.6±30.4%), |              |
| respectively  | (Figures3B    | and         | S4, Table     | S2).       | Agreement     | was low      |
| for both      | ActiGraph     | wGT3X-BT    |               | (CCC=0.02) | and           | GENEActiv    |
| (CCC=0.24)    | in outdoor    | conditions  |               | (Figure4), | as            | both sensors |
under-reportedbyarespective−79.4±14.9%and−47.9±20.8%
duetotheirmaximumsaturationintensities(Figure3BandS4).
| Interestingly, | although | the | manufacturer-specified |     |     | maximum |
| -------------- | -------- | --- | ---------------------- | --- | --- | ------- |
detectableilluminancewas5kluxforActiGraphwGT3X-BTand
20kluxforGENEActiv,theydidnotreachthesemaximumvalues
untilspectrometer-measuredintensitiesabove20kand40klux,
respectively(TableS2). Figure4.Concordancecorrelationcoefficient(CCC)forphotopic
Performanceforindoorcoolandwarmwhitelightwascompa- illuminance.Concordancewiththecriterionoveralldevicesper
rableforalllightsensorsacrossintensities(Figure3andS3). manufacturershownwith95%confidenceintervalsfordimmerindoor,
brighterindoor,andoutdoorconditions.

|     |     |     |     |     |     |     |     |     |     |     | Ishiharaetal. | | 7 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- |
Figure5.Inter-devicevariabilityofeachlightsensor.Variationshownasthestandarddeviationofthepercenterrorforphotopicilluminanceforeach
lightsensorundercoolindoorlight,warmindoorlight,andoutdoorlight.VariabilityamongstActiGraphdeviceswas0atlowilluminancewhenall
devicesregistered0lux(<50lux)andhighilluminancewhenalldevicesreachedthedetectablethreshold(>20klux).
Interdevicevariabilityofphotopicilluminance (CCC=0.36,Figure6C),withilluminancelevelsbetween5kand
(−46.5±21.2%,
To quantify interdevice variability, we calculated the standard 50 k lux being under-reported Figure6B and C)
(+73.3±156.7%,
deviation of the percent error of all devices per manufacturer and>50 k lux being over-reported Figure6B
| ateachtestedintensity(Figure5).Thebetween-devicevariability |     |     |     |     |     | andC)(TableS3). |          |              |     |             |             |     |
| ----------------------------------------------------------- | --- | --- | --- | --- | --- | --------------- | -------- | ------------ | --- | ----------- | ----------- | --- |
|                                                             |     |     |     |     |     | As with         | photopic | illuminance, |     | interdevice | variability | for |
wassmallestforActLumusacrossallintensities:1.8%fordimmer
|     |     |     |     |     |     | melanopic | illuminance | was | considerably |     | higher for | LYS than |
| --- | --- | --- | --- | --- | --- | --------- | ----------- | --- | ------------ | --- | ---------- | -------- |
indoor,0.7%forbrighterindoor,and2.1%foroutdoorconditions.
For both LYS and GENEActiv,variability was greater in dimmer ActLumus (Figure6D). The standard deviation of the percent
(24.7%and 25.7%,respectively)than brighter(15.3%and 10.5%, errorfromActLumusdeviceswasgenerallybelow5%acrossall
respectively) indoor light. ActiGraph interdevice variability was intensities,which was consistent in both cool and warm white
<5%atintensitiesbelowitsdetectablethreshold(50lux)butwas light and sunlight. For LYS, interdevice variability differed with
|     |     |     |     |     |     | spectral | composition | and | illuminance. |     | LYS variability | in cool |
| --- | --- | --- | --- | --- | --- | -------- | ----------- | --- | ------------ | --- | --------------- | ------- |
higherthanallothersensorsat25.8%from80to1000lux.Inout-
doorlightexceedingtheirrespectivesaturationintensities,Acti- whiteindoorlightingrangedfrom18%to37%fordimmerand9%
graphandGENEActivexhibitedlowvarianceasalldevicereadings to13%forbrighterconditions.TheLYSbetween-devicedispersion
plateauedatamanufacturer-specificvalue.Themeanoutputof was higher in warm white indoor lighting, ranging from 80%
|     |     |     |     |     |     | to160% | in dimmer | and 46% | to  | 94% in | brighter conditions. | The |
| --- | --- | --- | --- | --- | --- | ------ | --------- | ------- | --- | ------ | -------------------- | --- |
LYSdevicesalsoappearedtoplateauathigheroutdoorintensities,
smallestvariabilityforLYSdevices(<20%)wasobservedbetween
butbetween-devicevariabilityincreasedforLYSatspectrometer-
5kand40kluxbutexceeded60%inoutdoorlightabove50klux.
| measured values | >10 k | lux, suggesting |     | the saturation | output |     |     |     |     |     |     |     |
| --------------- | ----- | --------------- | --- | -------------- | ------ | --- | --- | --- | --- | --- | --- | --- |
valuesforLYSdevicesmayvarymore,oroutputathighintensities
was less consistent than those of other sensors (Figure5). For Free-livingcomparisons
| each manufacturer,the | pattern | of  | interdevice | variability | across |     |     |     |     |     |     |     |
| --------------------- | ------- | --- | ----------- | ----------- | ------ | --- | --- | --- | --- | --- | --- | --- |
Tobetterunderstandhowdifferencesobservedinthestandard-
indoorintensitieswaslargelysimilarincoolandwarmwhitelight ized laboratory conditions are reflected in free-living measure-
(Figure5). ments,wecomparedthephotopicluxoutputsfromconcurrently
|     |     |     |     |     |     | worn ActLumus |     | and ActiGraph |     | wGT3X-BT | (Table S1).As | in the |
| --- | --- | --- | --- | --- | --- | ------------- | --- | ------------- | --- | -------- | ------------- | ------ |
Accuracyandvariabilityofmelanopicilluminance
|     |     |     |     |     |     | laboratory | tests, | intensity | measurement |     | from the | ActiGraph |
| --- | --- | --- | --- | --- | --- | ---------- | ------ | --------- | ----------- | --- | -------- | --------- |
Wealsocomparedtheaccuracyofmelanopicilluminance,which wGT3X-BT was drastically lower than that from the ActLumus
wasavailableonlyforLYSandActLumussensors.Melanopicillu- (Figure7A)acrossallindividuals—withdailymean±SDluxval-
minance measures from both manufacturers increased linearly uesof77.3±68.5luxand515.0±436.0lux(p<.001),respectively.
with the criterion across all intensities (Figure6A). ActLumus Despite the incongruent absolute lux output, the two sensors
demonstratedexcellentagreementwiththecriterion(CCC>0.93, showed similar temporal response patterns when ActLumus-
Figure6C) and deviations for indoor light were generally <20% measuredluxwas>100(Figure7AandB)andtheirmeandaily
(Figure6B), with a small difference between cool (−4.3±7.9%) luxvaluesperparticipantwerewellcorrelated(R=0.91,p<.001)
| and warm white | light (−5.4±17.9%) |     | (Figure6C). | Outdoor | light, | (Figure7C). |     |     |     |     |     |     |
| -------------- | ------------------ | --- | ----------- | ------- | ------ | ----------- | --- | --- | --- | --- | --- | --- |
however,wasover-reported(+23.1±6.5%)(Figure6BandS5).
Thedegreeofagreementandcorrelationbetweenthesensors
AccuracyforLYSmelanopicilluminancedependedlargelyon wasdependentonlightintensity.Thetimespentineachintensity
thespectralcontentofthelightsource.Deviationsweregenerally bracket during the wear period was significantly different
within 20% in cool white light (−10.9±23.7%, CCC>0.85, between the two devices (Figure7D), with ActiGraph showing
Figure6B and C), while warm white light was over-reported agreaterpercentageofwear-timespentat0luxthanActLumus
| (+209.4±111.7%, | CCC>0.2, |          |     |                 |     | (88.5±7.6% |     | 39.7±10.3%, |     | <.001) |              |         |
| --------------- | -------- | -------- | --- | --------------- | --- | ---------- | --- | ----------- | --- | ------ | ------------ | ------- |
|                 |          | Figure6B | and | C). Concordance |     |            | vs. |             | p   |        | and ActLumus | showing |
for LYS melanopic illuminance was also low in outdoor light a greater percentage of time spent in all other intensity ranges

8 | SLEEPJ,2026,Vol.49,No.2
Figure6.Melanopiclightmeasurementaccuraciesbywearablesensors.(A)MelanopicilluminanceofLYSandActLumusplottedagainstthecriterion
photometer,eachsymbolrepresentsanaverageoverastable3-minuteperiodfromonedeviceateachtargetintensity,dashedlinesrepresenttheline
ofidentity.(B)Deviationfromthecriterionshownasmeanpercenterror±SDofalldevices(n=8)forindoorcoolwhite(closedcircle),indoorwarm
white(opencircle),andoutdoorlight(triangle).Thedark-shadedregionindicates±10%andthelight-shadedregionrepresents±20%ofthecriterion.
(C)Concordancecorrelationcoefficient(CCC)with95%confidenceinterval.(D)Standarddeviationofpercenterrorforcool,warm,andoutdoorlight
conditions.
(Figure7D).Asidefromminutesof0lux,thegreatestdiscrepancy testedtheirperformanceacrossarangeofintensitiesandspectra
between ActiGraph and ActLumus occurred in dimmer indoor typicalofreal-worldlightenvironments.Thesensorstestedhere
light(1–100lux;4.6±3.1%vs.40.8±11.2%;p<.001)(Figure7D), demonstratedintensity-dependentdifferencesinmeanaccuracy
which agrees with the laboratory finding of a lower minimal and interdevice variability of photopic and melanopic illumi-
detectionlimitforActLumusandalackofsensitivityindimmer nancecomparedtoanNIST-calibratedcriterionlightspectrom-
light for ActiGraph devices. Differences among the sensors at eter. Detection of light under indoor conditions (≤30 lux) was
higherintensitieswerelesspronounced,thoughstillsignificant largelyachievedwithGENEActiv,LYS,andActLumusdevicesbut
(e.g. >1000 lux, 2.5±2.3% for ActiGraph vs. 4.6±3.6% for not ActiGraph. Similarly, all sensors that we tested accurately
ActLumus, p <.001) (Figure7D). Similarly, while minutes spent discriminatedoutdoorfromindoorlightatintensitiesabove20k
in higher intensities (>100 lux) registered by the two sensors lux,but performance between 5 k and 10 k lux was mixed and
were correlated,those in lower intensities (1–100 lux) were not linearitywaslimitedbydetectorsaturationforActiGraph(∼20k
(FigureS6AandB). lux),GENEActiv (∼40 k lux),and LYS (∼60 k lux).The accuracy
of melanopic lux varied more with the spectral content of the
lightsourceforLYSthanforActLumus.Differencesininterdevice
Discussion
variation between manufacturers were broad for both photopic
With growing interest in the use of wearable sensors to study andmelanopicilluminance.Simultaneousfree-livinglightmea-
the impacts of free-living light exposure on human health, we surementsconfirmeddiscrepanciesinphotopicluxoutputfrom

Ishiharaetal. | 9
Figure7.Free-living24-hcumulativeluxmeasurementbetweenActLumusandActiGraph.Sampledatafromoneindividualmeasuring(A)24-hlight
exposureinluxand(B)activityinproportionalintegratingmeasure(PIM)forActLumusandvectormagnitudeforActiGraph.Lowactivitylevelsduring
theperiodprolongedof0lux(∼02:00–∼08:00)suggestdevicewearwhilesleepinginadarkenvironment.(C)Pearsoncorrelation(dottedblueline)
between24hmeanlightexposurebetweenActiGraphwGT3X-BTandActLumus.Individualblackdotsrepresentthe24hmeanluxoutputthroughout
theentirewearperiodperindividual;thedashedblacklineisthelineofidentity.(D)Timespentineachintensityrangeduringthewearperiodfor
Actigraph(red)andActLumus(blue)ateachintensityrange.Eachdotisthemeanperindividual.Boxesrepresentthefirstandthirdquartileswiththe
centrallineindicatingthegroupmedian.Whiskersare1.5timestheIQRfromthefirstandthirdquartiles.
different devices. These findings underscore the importance of intensity range by wearable sensors may be important for the
consideringtheilluminancerange,photopicandmelanopicillu- studyoftheeffectsoflightonfree-livingsleep.Wefoundthatall
minanceaccuracies,andinterdevicevariabilityrequiredtoquan- devicesexcepttheActigraphsensedlight>2lux.TheActiGraph
tifyaspecificoutcomewhenselectingawearablelightsensor. wGT3X-BTdevicesdetectedlessthanhalfofthenonzeroluxval-
Studiesofhumansandanimalshaveyieldedinsightintoboth uesatintensitiesbetween50and100luxanddidnotdetectany
theadversehealthoutcomesandtreatmentopportunitiesoflight lightbelow50lux,limitingitsutilityforquantifyingthepresence
exposure[24,37].However,challengesremaininquantifyinglight or absence of light in many built environments.Our free-living
measurementsaccuratelyinextremeilluminancelevels(e.g.very dataalsosupportthelaboratoryobservations—ActiGraphsensor
dim light before bedtime or very bright daylight). Studies have reported∼50%moreminutesofdatameasuredat0luxand∼40%
demonstrated that nocturnal dim light (<10 lux) alters sleep fewerminutesbetween1and100luxthanActLumus.Thesefind-
architecture[38]andexposuretolowlevelsoflight(<30lux)prior ingssuggestthatdifferencesinminimaldetectionlimitandaccu-
tobedtimeresultsina∼50%suppressionofmelatonin(albeitwith racyunderlow-intensitylightmightresultindivergentinterpre-
highindividualvariability)[39],suggestingthatdetectionofthis tationsforoutcomesinvolvingdimandmoderatelightexposure.

10 | SLEEPJ,2026,Vol.49,No.2
Whileeveninglightexposureislinkedtonegativehealthout- thatActLumus,GENEActiv,andActiGraphwGT3X-BTallprovided
comes, exposure to high intensities of naturalistic daylight is valid continuous recordings during 1–6 hours of testing. LYS
associatedwithimprovedmoodandsleep[11],circadianrhythm deviceswerereliable90%ofthetime,withoccasionaldropouts,
[40], and cognitive performance [41]. The potential benefits of whichweremorefrequentforsomedevicesthanothers.While
brighterlightexposureduringthedayhavebeenstudiedbyusing it is difficult to definitively identify the cause of the dropout
a light intensity threshold as a proxy to categorize indoor vs. in our study, we should note that LYS devices have limited
outdoorlight[42,43].Inourlaboratorystudy,wefoundthatunder on-board memory and rely on Bluetooth communication to
20 k lux, GENEActiv and ActiGraph wGT3X-BT devices consis- regularly transmit data to the software application whereas
tently underreported, while LYS devices routinely overreported other sensors do not.Regardless of the cause,the frequency of
photopic illuminance compared to the criterion.This divergent LYSdropoutsuggestsadditionalattentionisrequiredtoconfirm
accuracy among sensors suggests a common threshold would thecontinuityofdatacollection.Together,theseresultsindicate
leadtodifferenttimespentinoutdoorversusindoorconditions. thatmostdevicescanprovidecontinuousfree-livingrecordings,
Theresultsofourfree-livingstudysupportthisobservation,as butdropoutandinterdevicevariabilitymayaddtothevariation
ActlumusandActiGraphsensorsrecordedsignificantlydifferent betweensubjects,dependingonthesensorand/ormeasuredlight
timeabovethecommonlyused1000luxthreshold[43].However, conditions.
despite this difference, time above 1000 lux for ActiGraph and LYS and ActLumus light sensors both provide measures of
ActLumuswasstronglycorrelatedacrossparticipants,suggesting melanopic light intensity, which is thought to be more biologi-
eachsensoriscapableofdifferentiatingoutdoorfromindoorillu- callyrelevantthanphotopicilluminancesinceitbetterpredicts
minance,butmayrequireindividualizedthresholds.Thus,further the effects of light on the melanopsin-expressing, intrinsically
studyisneededtodeterminewhethersensor-specificthresholds photosensitive retinal ganglion cells responsible for entraining
mayyieldmoreuniformcategorizationofoutdoorexposuretime the circadian rhythm [26].Melanopsin has a peak sensitivity to
acrossmanufacturers. theshorterwavelengthsoflightthatisreflectedinthespectrum
For outcome metrics involving cumulative light exposures, usedtoestimatemelanopicilluminance[26].Whiletheaccuracy
propertiessuchasaccuracyandrangeoflinearitycanaffectthe ofmelanopicluxfrombothdeviceswascomparablefordimmer
comparabilityofthedatabetweenmanufacturers.Theaccuracy cool white light, ActLumus was much more consistent for the
ofphotopicilluminancewasfoundtovarydramaticallybysensor warm spectrum, across intensities, and between devices. The
and illuminance level. Overall, ActLumus had the lowest error highermelanopicvaluesforLYSinwarmwhite—whichincludes
comparedtoothermanufacturersacrossallintensities.Thelight greater spectral power in the longer wavelengths—suggest an
intensityrangeyieldingthehighestaccuracyalsodifferedbysen- overlybroadmelanopicfilterbandwidthandthatthenumberof
sor—dimmerandbrighterindoorlight(10–1000lx)forActLumus, spectralchannelsusedtoderivemelanopiclux(3RGBchannels
brighterindoorlight(300–1000lx)forActiGraphwGT3X-BT,and forLYSversus10channelsforActLumus)mayplayanimportant
outdoor light (5 k–10 k lux) for LYS and GENEActiv. Accuracy roleinitsaccuracy.
wasalsorelatedtotherangeoflinearityforeachmanufacturer Differences in hardware components and calibration proce-
since error increased as source light intensity deviated further dureslikelycontributetothevariationinaccuracyandvariability
fromthelowerandupperdetectionlimits.TheActiGraphwGT3X- between manufacturers. According to manufacturer-provided
BT devices had the smallest range of linearity (∼50–20 k lux), information, most sensors are calibrated with brighter indoor
whereas GENEActiv and LYS sensors demonstrated saturation light (500–1000 lux), suggesting higher accuracy compared to
effectsathigherintensities(∼40kand∼60klux,respectively)and the extreme intensities. The noted calibration processes also
ActLumus showed minimal saturation—consistent with a prior differedbymanufacturer,increasingthepotentialforinter-and
model [18]. These differences in accuracy and linearity across intramanufacturer variation [22]. Differences in photodetectors
photopicintensitieswerealsoreflectedinourfree-livingportion [22, 45], use of optical filters [18], diffusers [45], and, in some
ofthestudycomparingcumulativeilluminancebetweenActLu- instances,sensorcasing[18]likelyaffectedaccuracyandinterde-
musandActiGraph.Although24-hmeanluxoutputfromthetwo vicevariability.Dataqualitymayalsohavebeeninfluencedbythe
deviceswashighlycorrelated,ActiGraphoutputwasconsistently manufacturer-specificmethodsofdataacquisition/transmission,
an order of magnitude smaller than that from ActLumus. The asmentionedpreviously.Thevariabilitybetweenmanufacturers
discrepanciesinabsolutedailymeanluxvaluesbetweensensors emphasizes the importance of reporting device specifications,
may lead to inconsistent recommendations of daily light expo- both by manufacturers and in future research involving light
sure. measurements[46].
While differences in accuracy illustrate potential issues Inourlaboratorytesting,ActLumusdeviceshadthebroadest
for comparing data across manufacturers, metrics such as detectionrange,thehighestaccuracycomparedtothecriterion
interdevicevariabilityandrecordingconsistencycanbeusefulto spectrometer, and the smallest interdevice variability for both
gaugeconfidencewhencomparingmeasurementsfromabatch photopicandmelanopicilluminance.ActLumusdevicesalsoreg-
ofdevicesofthesamemanufacturer.Wefoundthatthestandard istered the extreme low and high intensities in our free-living
deviation of percent error varied widely by manufacturer, measurements, suggesting the expanded detection range may
particularly in indoor light ≤100 lux, light levels in which the be important to metrics of cumulative light exposure.However,
majority of the waking day is spent [44], as confirmed by our though ActLumus has the capacity to collect other physiolog-
free-living data. We mitigated the potential contribution of ical data, it is a relatively new device with fewer validations
device placement on interdevice variability in our laboratory andpublishedfree-livingstudiesthansomeoftheothertested
experimentbyrandomizingdeviceplacementbetweenconditions sensors. Contrarily, while ActiGraph wGT3X-BT and GENEActiv
and limiting the test area to the region where spectrometer- havebeenextensivelyvalidatedandimplementedinlarge-scale
measuredlightintensityvariedby<10%.Reliable,uninterrupted studiesofphysicalactivityandsleep[32,47,48],theirlightsen-
measurement is also crucial to understand how free-living sorsdemonstratedlimitedperformance.AlthoughtheActiGraph
exposuresmayinfluencesleepandcircadianrhythms.Wefound wGT3X-BTlightsensorexhibitedthenarrowestresponserange,

|     |     |     |     |     |     |     |     |     |     | Ishiharaetal. | | 11 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------- | ---- |
a similar ActiGraphdevicewas observed to differentiate indoor lightexposureoutputsvariedsignificantlybylightsensors.Thus,
fromoutdoorlightexposure[42],whichmaybeusedtosupple- along with other device-specific features,wearable light sensor
ment activity and sleep measurements.The GENEActiv devices selectionshoulddependonthesensitivityandilluminancerange
consistentlyunderreportedphotopicintensities,butcouplingthe requiredbythefree-livingoutcomesofinterest.Aswearablelight-
light information with that from its movement [47, 48] and/or sensingtechnologyrapidlyevolves,simultaneousassessmentsof
temperature [49], sensors may improve the accuracy of sleep sensor performance is crucial to clearly interpret findings and
timing,nonweartime,andsedentarybehaviormetrics.TheLYS understandthetrueimpactofdifferentlightexposuresonhuman
| devices | provide | melanopic | output | and | can be | implemented | in  | health. |     |     |     |
| ------- | ------- | --------- | ------ | --- | ------ | ----------- | --- | ------- | --- | --- | --- |
free-livingstudieswithflexibleattachmentsites[21,50].However,
inconsistenciesindatacollectionbetweendevicesandintermit- Acknowledgments
| tent dropouts | need | to be | carefully | monitored.Thus,the |     |     | sensor |     |     |     |     |
| ------------- | ---- | ----- | --------- | ------------------ | --- | --- | ------ | --- | --- | --- | --- |
performanceexhibitedinthisstudyshouldbeconsideredalong- TheauthorswouldliketothankDrs.CharlesE.Matthews,Sarah
sideotherdevicecapabilitiesandoutcomesofinterest. Keadle,andPedroF.Saint-MauriceforgenerouslyprovidingLYS
Our study had some limitations. An LED light source was sensors, and Drs. Kathleen Merikangas and Gena Glickman for
usedforourindoorlightconditions.Priorassessmentsofsensor providingcriticalfeedbackonourdraft.Wealsothanktheclinical
performance using other light sources,such as fluorescent [20] center staff for their contributions to patient care. Finally, we
or monochromatic light [18, 20], have produced slightly differ- thank the participants for their contribution to the study. This
ent results. For instance, an evaluation of the GENEActiv light research was supported by the Intramural Research Program
sensordemonstratedasimilarmagnitudeofunder-reportingof of the National Institute of Diabetes and Digestive and Kidney
LED intensities to that in our study,but an even greater under- Diseases(NIDDK)withintheNationalInstitutesofHealth(NIH).
reporting of fluorescent light intensities [20]. When the same The contributions of the NIH author(s) were made as part of
sensorwastestedwithmonochromaticred,green,andbluelight, theirofficialdutiesasNIHfederalemployees,areincompliance
therewasanotedspectralbiastowardgreaterunderestimation withagencypolicyrequirements,andareconsideredWorksofthe
of shorter wavelengths [18,20],which was not apparent in our UnitedStatesGovernment.However,thefindingsandconclusions
study,asGENEActivunder-reportedpolychromaticcoolandwarm presented in this paper are those of the author(s) and do not
white light similarly. These differences, along with the variety necessarilyreflecttheviewsoftheNIHortheU.S.Department
ofartificiallightsourcestypicallyusedineverydayindoorenvi- ofHealthandHumanServices.
ronments[51]andforsensorcalibration[22]highlighttheneed
for further testing of wearable light sensors with varied source Author contributions
lighting.Wewereonlyabletotestthefourmodelsofwearable
|               |           |     |                 |     |           |      |        | A.I., R.J.B., S.R.L., | and K.Y.C. designed | the laboratory | study. A.I. |
| ------------- | --------- | --- | --------------- | --- | --------- | ---- | ------ | --------------------- | ------------------- | -------------- | ----------- |
| light sensors | available | to  | our laboratory, |     | and thus, | this | is not |                       |                     |                |             |
performeddatacollectionandanalysisofthelaboratoryprotocol.
| a comprehensive |     | study of | the many | currently | available |     | models |     |     |     |     |
| --------------- | --- | -------- | -------- | --------- | --------- | --- | ------ | --- | --- | --- | --- |
A.I.,R.J.B.,S.R.L.,andK.Y.C.interpretedthedata.S.T.C.,A.B.C.,and
[22].However,thedataandanalysesprovidesomeguidancefor
K.Y.C.conceptualizedanddesignedthefree-livingstudy.A.I.,S.M.,
wearablesensorselectionandraiseawarenessofpotentiallight
sensoroutputvariationwithinandbetweenmanufacturers.The M.D.,O.J.,K.D.,G.S.,L.S.,andA.B.C.collecteddataforthefree-living
study.A.I.andR.J.B.processedandanalyzedfree-livingdata.All
methodologiesdescribedherecanalsobeextendedtoevaluate
authorscontributedtoreviewingandeditingthefinalversionof
othersensors.Althoughourlaboratorytestincorporatedawide
thepaper.
rangeofintensitiesandwavelengthsoflightexperiencedindaily
| life, we | did not | account | for angular | responses |     | or concurrent |     |     |     |     |     |
| -------- | ------- | ------- | ----------- | --------- | --- | ------------- | --- | --- | --- | --- | --- |
exposurestomultiplelightsources.Lastly,thespacingbetween Supplementary material
| devices | may have | introduced | some | error | during | our laboratory |     |     |     |     |     |
| ------- | -------- | ---------- | ---- | ----- | ------ | -------------- | --- | --- | --- | --- | --- |
SupplementarymaterialisavailableatSLEEPonline.
testing,althoughweattemptedtominimizetheimpactbyran-
| domizing | their | placement | and | limiting | testing | to the | zone of |     |     |     |     |
| -------- | ----- | --------- | --- | -------- | ------- | ------ | ------- | --- | --- | --- | --- |
<10% deviation in the criterion sensor output. Selection of a Disclosure statement
wearablesensorforfree-livingmeasurementalsorequiresother
considerations,including storage capacity,data complexity and Financialdisclosure:Nonedeclared.
Non-financialdisclosure:Nonedeclared.
| accessibility, | battery | life,        | waterproof | rating, | cost,        | capability | for   |     |     |     |     |
| -------------- | ------- | ------------ | ---------- | ------- | ------------ | ---------- | ----- | --- | --- | --- | --- |
| other on-board |         | measurements | (e.g.      | motion, | temperature, |            | heart |     |     |     |     |
rate,eventmarking),andattachmentsite(e.g.wristversuscloser
|             |       |            |      |           |           |     |           | Data availability |     |     |     |
| ----------- | ----- | ---------- | ---- | --------- | --------- | --- | --------- | ----------------- | --- | --- | --- |
| to the eye) | [22]. | Therefore, | when | selecting | wearables |     | for light |                   |     |     |     |
research, the results of our study on light sensor performance ThedataandsourcecodehavebeendepositedinOpenScience
Framework(osf.io/97dct).
| should be | weighed | alongside | the | other | capabilities | required | to  |     |     |     |     |
| --------- | ------- | --------- | --- | ----- | ------------ | -------- | --- | --- | --- | --- | --- |
quantifythedesiredoutcome.
References
Conclusion
|     |     |     |     |     |     |     |     | 1. BedrosianTA,NelsonRJ.Timingoflightexposureaffectsmood |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------------------------------------------------- | --- | --- | --- |
Wefoundthatmosttestedwearablelightsensorsunderknown andbraincircuits.TranslPsychiatry.2017;7(1):e1017.https://doi.
stimulihadalinearresponsetoarangeofintensitiesindicative org/10.1038/tp.2016.262
of indoor light to midday outdoor illuminance (50–20 k). How- 2. PaulS,BrownT.Directeffectsofthelightenvironmentondaily
ever,sensorsdifferedintheirdetectableintensityrange,photopic neuroendocrinecontrol.JEndocrinol.2019;243(1):R1–R18.https://
andmelanopicaccuracies,andinterdevicevariability,especially doi.org/10.1530/JOE-19-0302
under extreme low and high intensities. Consistent with the 3. Fleury G, Masis-Vargas A, Kalsbeek A. Metabolic implications
laboratoryfindings,ourfree-livingstudyalsodemonstratedthat ofexposuretolightatnight:lessonsfromanimalandhuman

12 | SLEEPJ,2026,Vol.49,No.2
studies. Obesity. 2020;28(S1):S18–S28. https://doi.org/10.1002/ 19. Joyce DS, Zele AJ, Feigl B, Adhikari P. The accuracy of artifi-
oby.22807 cialandnaturallightmeasurementsbyactigraphs.JSleepRes.
4. DuffyJF,CzeislerCA.Effectoflightonhumancircadianphys- 2020;29(5):e12963.https://doi.org/10.1111/jsr.12963
iology.SleepMedClin.2009;4(2):165–177.https://doi.org/10.1016/ 20. StoneJE,McGlashanEM,Facer-ChildsER,CainSW,PhillipsAJK.
j.jsmc.2009.01.004 AccuracyoftheGENEActivdeviceformeasuringlightexposure
5. Prayag AS,Munch M,Aeschbach D,Chellappa SL,Gronfier C. insleepandcircadianresearch.ClocksSleep.2020;2(2):143–152.
Lightmodulationofhumanclocks,wake,andsleep.ClocksSleep. https://doi.org/10.3390/clockssleep2020012
2019;1(1):193–208.https://doi.org/10.3390/clockssleep1010017 21. StevensonS,SuppiahH,DrillerM.Researchnote:thevalidity
6. Cho Y, Ryu SH, Lee BR, Kim KH, Lee E, Choi J. Effects of and reliability of a novel wearable sensor in measuring light
artificial light at night on human health: a literature review exposureinanindoorandoutdoorenvironment.LightResTech-
of observational and experimental studies applied to expo- nol.2025;0(0).https://doi.org/10.1177/14771535251338582
sure assessment. Chronobiol Int. 2015;32(9):1294–1310. https:// 22. van Duijnhoven J, Hartmeyer SL, Didikoglu A, et al. Measur-
doi.org/10.3109/07420528.2015.1073158 ing light exposure in daily life: a review of wearable light
7. Vetter C, Pattison PM, Houser K, et al. A review of human loggers.BuildEnviron.2025;274:112771.https://doi.org/10.1016/
physiological responses to light: implications for the devel- j.buildenv.2025.112771
opment of integrative lighting solutions. Leukos. 2022;18(3): 23. deVriesSW,Gkaintatzi-MasoutiM,vanDuijnhovenJ,Mardal-
387–414.https://doi.org/10.1080/15502724.2021.1872383 jevic J,Aarts MPJ.Recommendations for light-dosimetry field
8. Zee PC, Goldstein CA. Treatment of shift work disorder and studies based on a meta-analysis of personal light levels of
jetlag.CurrTreatOptionsNeurol.2010;12(5):396–411.https://doi. office workers. Light Res Technol. 2024;57(1):47–70. https://doi.
org/10.1007/s11940-010-0090-9 org/10.1177/14771535241248540
9. MaruaniJ,GeoffroyPA.Brightlightasapersonalizedprecision 24. BrownTM,BrainardGC,CajochenC,etal.Recommendationsfor
treatmentofmooddisorders.FrontPsych.2019;10:85.https://doi. daytime,evening,andnighttimeindoorlightexposuretobest
org/10.3389/fpsyt.2019.00085 support physiology, sleep, and wakefulness in healthy adults.
10. Bhandary SK, Dhakal R, Sanghavi V, Verkicharla PK. Ambi- PLoS Biol. 2022;20(3):e3001571. https://doi.org/10.1371/journal.
entlightlevelvarieswithdifferentlocationsandenvironmen- pbio.3001571
tal conditions: potential to impact myopia. PLoS One. 2021; 25. LucasRJ,PeirsonSN,BersonDM,etal.Measuringandusinglight
16(7):e0254027.https://doi.org/10.1371/journal.pone.0254027 in the melanopsin age.Trends Neurosci.2014;37(1):1–9.https://
11. Burns AC, Saxena R, Vetter C, Phillips AJK, Lane JM, Cain doi.org/10.1016/j.tins.2013.10.004
SW. Time spent in outdoor light is associated with mood, 26. Brown TM. Melanopic illuminance defines the magnitude of
sleep,andcircadianrhythm-relatedoutcomes:across-sectional human circadian light responses under a wide range of con-
and longitudinal study in over 400,000 UK Biobank partici- ditions. J Pineal Res. 2020;69(1):e12655. https://doi.org/10.1111/
pants.JAffectDisord.2021;295:347–352.https://doi.org/10.1016/ jpi.12655
j.jad.2021.08.056 27. GoldsackJC,CoravosA,BakkerJP,etal.Verification,analytical
12. LokR,Ancoli-IsraelS,EnsrudK,RedlineS,StoneKL,ZeitzerJM. validation,andclinicalvalidation(V3):thefoundationofdeter-
Timingofoutdoorlightexposureisassociatedwithsleep-wake mining fit-for-purpose for biometric monitoring technologies
consolidation in community-dwelling older men. Front. Sleep. (BioMeTs). NPJ Digit Med. 2020;3(1):55. https://doi.org/10.1038/
2023;2:2.https://doi.org/10.3389/frsle.2023.1268379 s41746-020-0260-4
13. Shochat T, Martin J, Marler M, Ancoli-Israel S. Illumination 28. Spitschan M, Smolders K, Vandendriessche B, et al. Verifi-
levels in nursing home patients: effects on sleep and activity cation, analytical validation and clinical validation (V3) of
rhythms.JSleepRes.2000;9(4):373–379.https://doi.org/10.1046/ wearable dosimeters and light loggers. Digit. Health. 2022;
j.1365-2869.2000.00221.x 8:205520762211448.https://doi.org/10.1177/20552076221144858
14. ObayashiK,YamagamiY,KurumataniN,SaekiK.Bedroomlight- 29. Wearable electronic devices and technologies. Part 402-3: Per-
ingenvironmentandincidentdiabetesmellitus:alongitudinal formance measurement of fitness wearables - Test methods for the
studyoftheHEIJO-KYOcohort.SleepMed.2020;65:1–3.https:// determination of the accuracy of heart rate. Geneva, Switzerland:
doi.org/10.1016/j.sleep.2019.07.006 InternationalElectrotechnicalCommission;2024.
15. WindredDP,BurnsAC,RutterMK,etal.Personallightexposure 30. Commission Internationale de l’Eclairage 2019, CIE spectral
patternsandincidenceoftype2diabetes:analysisof13million luminous efficiency for photopic vision. Vienna, AT: Inter-
hoursoflightsensordataand670,000person-yearsofprospec- national Commission on Illumination (CIE). https://cie.co.at/
tiveobservation.LancetRegHealthEur.2024;42:100943.https:// datatable/cie-spectral-luminous-efficiency-photopic-vision
doi.org/10.1016/j.lanepe.2024.100943 31. CIE system for metrology of optical radiation for ipRGC-
16. WindredDP,BurnsAC,LaneJM,etal.Brighternightsanddarker influenced responses to light. CIE S 026:2018. https://cie.co.
days predict higher mortality risk: a prospective analysis of at/publications/cie-system-metrology-optical-radiation-iprgc-
personal light exposure in >88,000 individuals.Proc Natl Acad influenced-responses-light-0.2025
Sci U S A. 2024;121(43):e2405924121. https://doi.org/10.1073/ 32. Ngueleu AM, Barthod C, Best KL, Routhier F, Otis M, Batcho
pnas.2405924121 CS.CriterionvalidityofActiGraphmonitoringdevicesforstep
17. MarkvartJ,HansenÅM,ChristoffersenJ.Comparisonandcor- countinganddistancemeasurementinadultsandolderadults:
rectionofthelightsensoroutputfrom48wearablelightexpo- asystematicreview.JNeuroengRehabil.2022;19(1):112.https://
sure devices by using a side-by-side field calibration method. doi.org/10.1186/s12984-022-01085-5
Leukos. 2015;11(3):155–171. https://doi.org/10.1080/15502724. 33. ColeRJ,KripkeDF,GruenW,MullaneyDJ,GillinJC.Automatic
2015.1020948 sleep/wakeidentificationfromwristactivity.Sleep.1992;15(5):
18. Price LLA, Lyachev A, Khazova M. Optical performance char- 461–469.https://doi.org/10.1093/sleep/15.5.461
acterization of light-logging actigraphy dosimeters. J Opt Soc 34. SadehA,SharkeyKM,CarskadonMA.Activity-basedsleep-wake
Am A. 2017;34(4):545–557. https://doi.org/10.1364/JOSAA.34. identification:anempiricaltestofmethodologicalissues.Sleep.
000545 1994;17(3):201–207.https://doi.org/10.1093/sleep/17.3.201

Ishiharaetal. | 13
35. Troiano RP, McClain JJ, Brychta RJ, Chen KY. Evolution of objectiveandsubjectivesleepoutcomesincommunity-dwelling
accelerometer methods for physical activity research. Brit adults. Sleep Health. 2019;5(1):31–48. https://doi.org/10.1016/j.
J Sport Med. 2014;48(13):1019–1023. https://doi.org/10.1136/ sleh.2018.09.006
bjsports-2014-093546 44. ScheuermaierK,LaffanAM,DuffyJF.Lightexposurepatterns
36. TroianoRP,BerriganD,DoddKW,MasseLC,TilertT,McDow- in healthy older and young adults. J Biol Rhythm. 2010;25(2):
ell M. Physical activity in the United States measured by 113–122.https://doi.org/10.1177/0748730410361916
accelerometer.MedSciSportsExerc.2008;40(1):181–188.https:// 45. DanilenkoKV,StefaniO,VoroninKA,etal.Wearablelight-and-
doi.org/10.1249/mss.0b013e31815a51b3 motiondataloggersforsleep/wakeresearch:areview.ApplSci.
37. WalbeekTJ,HarrisonEM,GormanMR,GlickmanGL.Naturalistic 2022;12(22):11794.https://doi.org/10.3390/app122211794
intensities of light at night: a review of the potent effects of 46. Spitschan M, Kervezee L, Lok R, McGlashan E, Najjar RP,
very dim light on circadian responses and considerations for ENLIGHT Consortium. ENLIGHT: a consensus checklist for
translationalresearch.FrontNeurol.2021;12:625334.https://doi. reporting laboratory-based studies on the non-visual effects
org/10.3389/fneur.2021.625334 of light in humans. EBioMedicine. 2023;98:104889. https://doi.
38. Cho CH, Yoon HK, Kang SG, Kim L, Lee EI, Lee HJ. Impact of org/10.1016/j.ebiom.2023.104889
exposuretodimlightatnightonsleepinfemaleandcompar- 47. AntczakD,LonsdaleC,DelPozoCB,ParkerP,SandersT.Reli-
isonwithmalesubjects.PsychiatryInvestig.2018;15(5):520–530. abilityofGENEActivaccelerometerstoestimatesleep,physical
https://doi.org/10.30773/pi.2018.03.17 activity,andsedentarytimeinchildren.IntJBehavNutrPhysAct.
39. Phillips AJK, Vidafar P, Burns AC, et al. High sensitivity and 2021;18(1):73.https://doi.org/10.1186/s12966-021-01143-6
interindividualvariabilityintheresponseofthehumancirca- 48. Pavey TG, Gomersall SR, Clark BK, Brown WJ. The validity of
dian system to evening light. Proc Natl Acad Sci U S A. 2019; the GENEActiv wrist-worn accelerometer for measuring adult
116(24):12019–12024.https://doi.org/10.1073/pnas.1901824116 sedentarytimeinfreeliving.JSciMedSport.2016;19(5):395–399.
40. WrightKP,McHillAW,BirksBR,GriffinBR,RusterholzT,Chinoy https://doi.org/10.1016/j.jsams.2015.04.007
ED.Entrainment of the human circadian clock to the natural 49. HewittL,OkelyAD,StanleyRM,BatterhamM,Cliff DP.Valid-
light-dark cycle. Curr Biol. 2013;23(16):1554–1558. https://doi. ity of GENEActiv accelerometer wear and nonwear time for
org/10.1016/j.cub.2013.06.039 useininfants.JPhysActHealth.2021;18(5):488–494.https://doi.
41. Boubekri M, Lee J, MacNaughton P, et al. The impact of opti- org/10.1123/jpah.2019-0486
mizeddaylightandviewsonthesleepdurationandcognitive 50. Dal EV, Snaphaan L, Bouwmeester S, de Kort Y, Bongers
performance of office workers. Int J Environ Res Public Health. I. Testing a single-case experimental design to study
2020;17(9):3219.https://doi.org/10.3390/ijerph17093219 dynamic light exposure in people with dementia living at
42. Flynn JI,Coe DP,Larsen CA,Rider BC,Conger SA,Bassett DR. home. Appl Sci. 2021;11(21):10221. https://doi.org/10.3390/app
Detecting indoor and outdoor environments using the Acti- 112110221
GraphGT3X+lightsensorinchildren.MedSciSportsExerc.2014; 51. Montoya FG, Peña-García A, Juaidi A, Manzano-Agugliaro F.
46(1):201–206.https://doi.org/10.1249/MSS.0b013e3182a388c0 Indoorlightingtechniques:anoverviewofevolutionandnew
43. Dautovich ND, Schreiber DR, Imel JL, et al. A systematic trendsforenergysaving.EnergBuildings.2017;140:50–60.https://
review of the amount and timing of light in association with doi.org/10.1016/j.enbuild.2017.01.028
PublishedbyOxfordUniversityPressonbehalfofSleepResearchSociety2025.Thisworkiswrittenby(a)USGovernmentemployee(s)andisinthepublicdomainintheUS.
SLEEPJ,2026,49,1–13
https://doi.org/10.1093/sleep/zsaf358
OriginalArticle
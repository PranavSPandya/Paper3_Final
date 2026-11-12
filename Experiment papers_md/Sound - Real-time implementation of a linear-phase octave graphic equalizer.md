PPrroocceeeeddiinnggssoofftthhee2277tthhIInntteerrnnaattiioonnaallCCoonnffeerreenncceeoonnDDiiggiittaallAAuuddiiooEEffffeeccttss((DDAAFFxx2244)),GGuuiillddffoorrdd,,SUunrrieteyd,UKKin,gSdeopmte,m3b-e7r3S-e7p,te2m02b4er2024
REAL-TIMEIMPLEMENTATIONOFALINEAR-PHASEOCTAVEGRAPHICEQUALIZER
|     |     | ValeriaBruschi |     |     |     |     |     | StefaniaCecchi |     |     |     |     |     |
| --- | --- | -------------- | --- | --- | --- | --- | --- | -------------- | --- | --- | --- | --- | --- |
DepartmentofInformationEngineering DepartmentofInformationEngineering
UniversitàPolitecnicadelleMarche UniversitàPolitecnicadelleMarche
|     |                           | Ancona,Italy       |     |     |     |     |     | Ancona,Italy             |     |     |     |     |     |
| --- | ------------------------- | ------------------ | --- | --- | --- | --- | --- | ------------------------ | --- | --- | --- | --- | --- |
|     | v.bruschi@staff.univpm.it |                    |     |     |     |     |     | s.cecchi@staff.univpm.it |     |     |     |     |     |
|     |                           | AlessandroNicolini |     |     |     |     |     | VesaVälimäki             |     |     |     |     |     |
LeaffEngineeringSrl AcousticsLab,Dept.ofInformation&CommunicationsEngr.
|     |                   | Ancona,Italy |     |     |     |     |     | AaltoUniversity |     |     |     |     |     |
| --- | ----------------- | ------------ | --- | --- | --- | --- | --- | --------------- | --- | --- | --- | --- | --- |
|     | nicolini@leaff.it |              |     |     |     |     |     | Espoo,Finland   |     |     |     |     |     |
vesa.valimaki@aalto.fi
ABSTRACT thephaseresponse, affectingthespatialimpression[6]. Inaddi-
tion,phasedistortionsmaybemoreaudible,especiallyinspeech
Thispaperproposesareal-timeimplementationofalinear-phase
equalization[7].
octavegraphicequalizer(GEQ),previouslyintroducedbythesame
authors. ThestructureoftheGEQisbasedoninterpolatedfinite Minimum-phase GEQs are usually realized with infinite im-
|                  |                 |               |            |          |          |         | pulse response | (IIR) filters   | arranged   | in  | a cascade | [8, 1,      | 9, 10] |
| ---------------- | --------------- | ------------- | ---------- | -------- | -------- | ------- | -------------- | --------------- | ---------- | --- | --------- | ----------- | ------ |
| impulse response | (IFIR)          | filters and   | is derived | from     | a single | pro-    |                |                 |            |     |           |             |        |
|                  |                 |               |            |          |          |         | or a parallel  | [1, 11, 12, 13] | structure, | in  | which     | each filter | has a  |
| totype FIR       | filter. The low | computational |            | cost and | small    | latency |                |                 |            |     |           |             |        |
fixedcenterfrequencyandbandwidthandonlythegainisvariable
| make the   | presented GEQ    | suitable    | for real-time | applications. |     | In     |                                                        |     |     |     |     |     |     |
| ---------- | ---------------- | ----------- | ------------- | ------------- | --- | ------ | ------------------------------------------------------ | --- | --- | --- | --- | --- | --- |
|            |                  |             |               |               |     |        | [14]. In[15,10,13],GEQsformedbysecond-orderIIRsections |     |     |     |     |     |     |
| this work, | the GEQ has been | implemented |               | as a plugin   | of  | a spe- |                                                        |     |     |     |     |     |     |
areproposed,reachingagoodaccuracywithareducedcomputa-
| cific software,                                  | used for real-time    |     | tests. The | performance |           | of the |                                                             |     |     |     |     |        |     |
| ------------------------------------------------ | --------------------- | --- | ---------- | ----------- | --------- | ------ | ----------------------------------------------------------- | --- | --- | --- | --- | ------ | --- |
|                                                  |                       |     |            |             |           |        | tionalcostintermsofnumberofoperationspersample.             |     |     |     |     | Incon- |     |
| equalizerhasbeenevaluatedthroughsubjectivetests, |                       |     |            |             | comparing |        |                                                             |     |     |     |     |        |     |
|                                                  |                       |     |            |             |           |        | trast, linear-phaseequalizerscanbedesignedwithfiniteimpulse |     |     |     |     |        |     |
| it with a                                        | filterbank equalizer. | For | the tests, | four        | standard  | equal- |                                                             |     |     |     |     |        |     |
izationcurveshavebeenchosen. Theexperimentalresultsshow response(FIR)filters,whichguaranteealinearphaseresponse[3].
promisingoutcomes. Theresultisanaccuratereal-time-capable Moreover,FIRfiltersarenotaffectedbynumericalproblemsthat
linear-phaseGEQwithareasonablelatency. may occur with IIR solutions [16]. The first digital FIR GEQs
|     |     |     |     |     |     |     | were developed | in the 1980s | [17, | 18, 19] | and, as | for IIR GEQs, |     |
| --- | --- | --- | --- | --- | --- | --- | -------------- | ------------ | ---- | ------- | ------- | ------------- | --- |
theyareusuallydesignedwithparallelstructures[17,18,20].
1. INTRODUCTION
Alinear-phaseGEQcanberealizedwithasinglehigh-order
Inaudioapplications,graphicequalizers(GEQs)playanessential FIR filter that approximates a target frequency response defined
role. Thistypeofequalizeriscalledgraphicbecausetheusercan bytheuser,assuggestedbyMcGrath[20]. Thetargetcurvecan
adjustonlythegainofeachband,definingagraphofthedesired beobtainedthroughtheinterpolationofthecommand-gainpoints
magnituderesponse[1,2,3]. GEQsarerealizedasfilterbanksin [19, 21], since only the gains of the center frequency bands are
whichthecenterfrequencyandthefrequencybandwidtharefixed. welldefined.ThelengthoftheFIRfiltercorrespondstothelength
ofthelowestbandfilter,sinceitisthenarrowestandthushasthe
Thispaperpresentsareal-timeimplementationofthelinear-phase
|     |     |     |     |     |     |     | longestringing. | Usually,agoodaccuracyatthelowfrequencies |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --------------- | ---------------------------------------- | --- | --- | --- | --- | --- |
octaveGEQproposedin[4].
|     |     |     |     |     |     |     | is achieved | with a filter length | of  | at least | several | thousand | sam- |
| --- | --- | --- | --- | --- | --- | --- | ----------- | -------------------- | --- | -------- | ------- | -------- | ---- |
GEQscanbecategorizeddependingontheirphaseresponse
|                              |     |     |                       |     |     |     | ples [19, 22, | 23, 24]. In | addition, | the single | FIR | filter must | be  |
| ---------------------------- | --- | --- | --------------------- | --- | --- | --- | ------------- | ----------- | --------- | ---------- | --- | ----------- | --- |
| asminimumphaseorlinearphase. |     |     | Minimum-phaseGEQsshow |     |     |     |               |             |           |            |     |             |     |
completelyredesignedeverytimethegainsatthecommandpoints
| the lowest | latency and their | impulse | response | is  | zero before | the |     |     |     |     |     |     |     |
| ---------- | ----------------- | ------- | -------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
main peak, avoiding pre-ringing effects. These properties make change,requiringadditionalcomputing,whichisunsuitedforreal-
minimum-phaseGEQssuitableforlivemusicapplications,where timemodificationsofthetargetresponse.
thelatencymustbeassmallaspossible. However,theminimum Differentsolutionscanbefoundtoreducethecomputational
phasemayaffecttheaudioperceptioninapplicationssuchasmul- complexityofFIRGEQs. Frequency-warpedFIRfilters[25,26]
tichannelequalization,parallelprocessing,phasecompatibilityof allow for the reduction of the filter lengths at low frequencies.
audioequipment,andcrossovernetworkdesign,wherethelinear
However,warpedFIRfiltersareobtainedthroughafrequencytrans-
phaseismoresuitable.
|     |     |     |     |     |     |     | formation | that uses IIR filters | and | results | in a non-linear |     | phase |
| --- | --- | --- | --- | --- | --- | --- | --------- | --------------------- | --- | ------- | --------------- | --- | ----- |
Alinear-phasesystempreservesthephaseoftheinputsignal response. Fast convolution [27] is another approach applied for
[5]andpreventsphasedistortions.Asanexample,inmultichannel reducingthecomputationalcostofFIRGEQs[28,29,30,31]. In
audioequalization,thetargetmagnituderesponseofeachchannel this case, the equalized signal is obtained by executing complex
changes. A non-linear-phase system also produces variations in multiplicationofthediscreteFouriertransform(DFT)oftheinput
Copyright:©2024ValeriaBruschietal.Thisisanopen-accessarticledistributed signal,elaboratedinframes,withtheDFTofthefilter’simpulse
underthetermsoftheCreativeCommonsAttribution4.0InternationalLicense,which responseandanti-transformingoftheresult. Thetransformations
permitsunrestricteduse,distribution,adaptation,andreproductioninanymedium, areperformedbyimplementingthefastFouriertransform(FFT)to
providedtheoriginalauthorandsourcearecredited. savecomputationalcost. AlthoughtheFFT-basedapproachguar-
DAFx.1
| <   |     |     |     |     |     | 459 |     |     |     |     |     |     | >   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

PPrroocceeeeddiinnggssoofftthhee2277tthhIInntteerrnnaattiioonnaallCCoonnffeerreenncceeoonnDDiiggiittaallAAuuddiiooEEffffeeccttss((DDAAFFxx2244)),GGuuiillddffoorrdd,,SUunrrieteyd,UKKin,gSdeopmte,m3b-e7r3S-e7p,te2m02b4er2024
anteesalinearphaseresponse,theframe-basedfilteringintroduces theKaiserwindowwithβ = 4[36]. Thelastbandoftheequal-
ahighlatency[29,4]. izer H (z) is obtained by the complementary highpass filter of
10
| Linear-phaseFIRGEQsalsocanberealizedusingmultirate |                   |         |           |        |      |        | theprototypefilteras |     |             |     |     |      |     |     |
| -------------------------------------------------- | ----------------- | ------- | --------- | ------ | ---- | ------ | -------------------- | --- | ----------- | --- | --- | ---- | --- | --- |
| processing                                         | [18, 19, 32, 23]. | In this | case, the | sample | rate | can be |                      |     |             |     |     |      |     |     |
|                                                    |                   |         |           |        |      |        |                      |     | H (z)=z−D−H |     |     | (z), |     | (1) |
differentforeachband. Inparticular,thehigherfrequencybands 10 LP
usealargesamplerate,whilethelowerfrequencybandsworkat
|                 |                                              |               |     |              |            |         | whereD                                 | = N/2isthedelay. |                                        | AccordingtoEq. |        |                  | (1),thefilterof |      |
| --------------- | -------------------------------------------- | ------------- | --- | ------------ | ---------- | ------- | -------------------------------------- | ---------------- | -------------------------------------- | -------------- | ------ | ---------------- | --------------- | ---- |
| aslowerrate.    | Afterthefiltering,thebandsignalsareupsampled |               |     |              |            |         |                                        |                  |                                        |                |        |                  |                 |      |
|                 |                                              |               |     |              |            |         | thehighestbandH                        |                  | 10 (z)isimplementedusingadelaylineanda |                |        |                  |                 |      |
| to the original | sample rate                                  | and summed    | to  | obtain       | the output | of      |                                        |                  |                                        |                |        |                  |                 |      |
|                 |                                              |               |     |              |            |         | subtraction,asshowninthetoprightofFig. |                  |                                        |                |        | 1. Theotherbands |                 |      |
| theequalizer.   | Thefilterbankequalizer(FBEq)of[32],          |               |     |              | basedon    |         |                                        |                  |                                        |                |        |                  |                 |      |
|                 |                                              |               |     |              |            |         | are                                    | obtained         | with stretched                         | versions       | of the | prototype        | filter,         | such |
| multirate       | filtering, is used                           | in this paper | as  | a comparison |            | for the |                                        |                  |                                        |                |        |                  |                 |      |
|                 |                                              |               |     |              |            |         | asH                                    | (z2)andH         | (z4),whicharepreparedbyinsertingoneor  |                |        |                  |                 |      |
| experiments.    |                                              |               |     |              |            |         |                                        | LP               | LP                                     |                |        |                  |                 |      |
threezerosamplesbetweeneachtwocoefficientsoftheprototype
Aninterestingoptionforsavingcomputationalcomplexityhas
FIRfilter,respectively[37].
beenproposedbyHergum[33]:anFIRGEQisdesignedusingin-
|                                 |     |     |                           |     |     |     |     | AsdepictedinFig.2,theoutputsignalY |     |     |     | (z)ofthemthband |     |     |
| ------------------------------- | --- | --- | ------------------------- | --- | --- | --- | --- | ---------------------------------- | --- | --- | --- | --------------- | --- | --- |
| terpolatedFIR(IFIR)filters[34]. |     |     | TheuseofIFIRfiltersforthe |     |     |     |     |                                    |     |     |     | m               |     |     |
isobtainedfromtheinputsignalX(z)as
| GEQ design | has recently | been extended | in  | [35, 4]. | An IFIR | fil- |     |     |     |     |     |     |     |     |
| ---------- | ------------ | ------------- | --- | -------- | ------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
ter is composed of the cascade of two FIR filters, in which the Y (z)=H (z)X(z), (2)
|     |     |     |     |     |     |     |     |     | m   |     | m   |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
firstoneisinterpolated(stretched)andthesecondoneattenuates
theunwantedspectralimagesproducedbytheinterpolation[34]. whereH m (z)isthetransferfunctionofthemthband,computed
| IFIRfiltershavealinearphaseandsmallripplerequiringacom- |     |     |     |     |     |     | as  |                |     |     |     |         |     |     |
| ------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | -------------- | --- | --- | --- | ------- | --- | --- |
|                                                         |     |     |     |     |     |     |     | (z)=z−∆m[z−DLm |     |     |     | (zLm)]G |     |     |
putational cost lower than conventional FIR filters. In [33, 35], H m −H LP m (z), (3)
theIFIRapproachisusedtodevelopuniformGEQs,inwhichall
|           |                          |     |          |          |     |         | wherethemthinterpolationfactorL |     |     |     | m iscomputedas |     |     |     |
| --------- | ------------------------ | --- | -------- | -------- | --- | ------- | ------------------------------- | --- | --- | --- | -------------- | --- | --- | --- |
| the bands | have the same bandwidth. |     | However, | standard |     | graphic |                                 |     |     |     |                |     |     |     |
equalizersusealogarithmicbanddivision[3],whichisnecessary =2(M−m) =2(10−m),
|     |     |     |     |     |     |     |     |     | L m |     |     |     |     | (4) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
foraudioapplicationsduetothehumanperceptionofsoundand
thenatureofmusic. andthetransferfunctionG (z),whichisshownindetailinFig.3,
m
In this context, in [4], an efficient linear-phase octave GEQ iscomposedofthecascadeofallpreviousbandfiltersas
| basedonIFIRfiltersisproposed. |     | ThebandfiltersoftheGEQare |     |     |     |     |     |     |     |     |     |     |     |     |
| ----------------------------- | --- | ------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
M−1
arrangedinaparalleltreestructurederivedfromaprototypeFIR (cid:89) (zLk),
|             |                           |     |         |              |     |        |     |     | G m (z)=H | LP (z) | H   | LP  |     | (5) |
| ----------- | ------------------------- | --- | ------- | ------------ | --- | ------ | --- | --- | --------- | ------ | --- | --- | --- | --- |
| filter. The | design uses complementary |     | filters | to guarantee |     | a flat |     |     |           |        |     |     |     |     |
k=m+1
| magnitude | response when | all the gains | are | the same. | The | IFIR |     |     |     |     |     |     |     |     |
| --------- | ------------- | ------------- | --- | --------- | --- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
GEQof[4]presentsanapproximationerroroflessthan±1dBat withm = 2,3,...,M andM = 10. LookingatFig.2,theinput
thecommandfrequencies,similartothetraditionalIIRGEQs.The signal x(n) is first filtered by the filter G (z) and the resulting
m
computationalcostismuchlowerthanthelinear-phaseGEQsand intermediatesignalx (n),shownforeachbandinFig.1,isthen
m
slightlyhigherthanthestate-of-the-artIIRGEQs.Thereducedla- filteredbyH (zLm)thatisimplementedthroughadelaylineand
10
tencyandtheimprovedcomputationalefficiencyofthisequalizer
asubtraction,accordingtoEq.(1).
makeitsuitableforreal-timeapplications.
|         |                    |                |     |        |     |        |     | Fromthethirdtothetenthband,asynchronizationdelay∆ |     |     |     |     |     | m , |
| ------- | ------------------ | -------------- | --- | ------ | --- | ------ | --- | ------------------------------------------------- | --- | --- | --- | --- | --- | --- |
| In this | paper, a real-time | implementation |     | of the | GEQ | of [4] |     |                                                   |     |     |     |     |     |     |
alsoshowninFig.2,isappliedtoalignthebandoutputsanditis
| ispresented. | Thelowlatencyandthereducedcomputationalcost |     |     |     |     |     |     |     |     |     |     |     |     |     |
| ------------ | ------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
computedas
maketheGEQsuitableforreal-timeapplications.Theimplemen-
|     |     |     |     |     |     |     |     | −[2(M+1−m)−1]D=τ |     |     | −[2(11−m)−1]D, |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- | --- | -------------- | --- | --- | --- |
tationisrealizedbyusingaspecificsoftwareandtheGEQisdevel- ∆ m =τ (6)
opedasaplugin.Theperformanceoftheequalizerhasbeenevalu-
|     |     |     |     |     |     |     | whereτ | isthetotaldelayoftheequalizerinsamples: |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------ | --------------------------------------- | --- | --- | --- | --- | --- | --- |
atedthroughsubjectivelisteningtestsimplementingfourstandard
equalizationcurvesandcomparingitwiththeFBEqof[32].
|           |              |             |         |     |           |     |     |     | τ =[2(M−1)−1]D=511D. |     |     |     |     | (7) |
| --------- | ------------ | ----------- | ------- | --- | --------- | --- | --- | --- | -------------------- | --- | --- | --- | --- | --- |
| The paper | is organized | as follows. | Section | 2   | describes | the |     |     |                      |     |     |     |     |     |
designoftheimplementedGEQ.Section3explainsthereal-time
|     |     |     |     |     |     |     |     | InFig.1,thesynchronizationdelays∆ |     |     |     | areshownoneupon |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------------------------- | --- | --- | --- | --------------- | --- | --- |
implementation. Section4discussestheexperimentalresults. Fi- m
theotherontheright-handside,nexttothecommandgainfactors
nally,Section5concludesthepaper.
|     |     |     |     |     |     |     | g   | . Inthe highestband(the |     | topsignalpath |     | inFig.1), |     | thetotal |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------------------- | --- | ------------- | --- | --------- | --- | -------- |
m
delayof511Dsamplesisformedbythecascadeofthedelayline
2. GRAPHICEQUALIZERDESIGN z−D andthesynchronizationdelayz−510D. Inthelowestband,
thesynchronizationdelayisformedbythecascadeofallthedelay
Thelinear-phaseGEQproposedbyBruschietal.[4]isanoctave linesbetweentheinput(topleftcornerinFig.1)andtheoutputy
1
equalizerwiththefollowingtenbandcenterfrequencies:31.25Hz, (bottomrightcornerinFig.1),whichhavethelengthsD,2D,4D,
62.5Hz, 125Hz, 250Hz, 500Hz, 1.0kHz, 2.0kHz, 4.0kHz, 8.0 8D,16D,32D,64D,128D,and256D. Thisaddsupto511D
| kHz,and16.0kHz. | Thebandsarenumberedfromlowesttohigh- |     |     |     |     |     | samplesofdelay. |     |     |     |     |     |     |     |
| --------------- | ------------------------------------ | --- | --- | --- | --- | --- | --------------- | --- | --- | --- | --- | --- | --- | --- |
estusingindexm=1,2,3,...,10. Thelowestbandfilteroftheequalizerisobtainedasabyprod-
Theschemeoftheimplementedlinear-phaseoctave-bandGEQ uct,whenthesignalx (n)isfilteredwiththeprototypefilterup-
2
is shown in Fig. 1. This design uses the sample rate of f = sampledbyafactorof28,or256,asshowninFig.1.Theresulting
s
48kHz.TheGEQdesignisbasedonatreestructurederivedfrom signalx (n)doesnotrequirefurtherprocessing,asitistheoutput
1
ahalf-bandlowpassprototypeFIRfilterH (z)withacutofffre- signaly (n)ofthelowestbandfilter.ThefilterH (z256)alsoim-
|     |     |     | LP  |     |     |     |     | 1   |     |     |     | LP  |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
quency of 12 kHz and order N = 18, corresponding to a filter plementsthelargestinput-outputdelay,soasynchronizationdelay
length of N +1 = 19 [4]. The filter H (z) is designed using isunnecessaryinthetwolowestbands,asseeninFig.1.
LP
DAFx.2
| <   |     |     |     |     |     | 460 |     |     |     |     |     |     |     | >   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

PPrroocceeeeddiinnggssoofftthhee2277tthhIInntteerrnnaattiioonnaallCCoonnffeerreenncceeoonnDDiiggiittaallAAuuddiiooEEffffeeccttss((DDAAFFxx2244)),GGuuiillddffoorrdd,,SUunrrieteyd,UKKin,gSdeopmte,m3b-e7r3S-e7p,te2m02b4er2024
|     |     |     |     |     |     |     |     |     |     |     |        |     | g         | y   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------ | --- | --------- | --- |
| x   | ++  |     |     |     |     |     |     |     |     |     |        |     | y 10 10 + |     |
| z-D |     |     |     |     |     |     |     |     |     |     | z-510D |     |           |     |
|     | -   |     |     |     |     |     |     |     |     |     |        |     | g         |     |
y 9
| H    | (z) | z- 2 D ++ |        |     |     |     |     |     |     |     | z - | 5 0 8 D | 9 +   |     |
| ---- | --- | --------- | ------ | --- | --- | --- | --- | --- | --- | --- | --- | ------- | ----- | --- |
| x LP |     | -         |        |     |     |     |     |     |     |     |     |         |       |     |
| 10   |     |           |        |     |     |     |     |     |     |     |     |         | y g   |     |
|      |     | (z2) z-   | 4 D ++ |     |     |     |     |     |     |     |     |         | 8 8 + |     |
|      | x   | H         |        |     |     |     |     |     |     |     | z - | 5 0 4 D |       |     |
|      | 9   | L P       | -      |     |     |     |     |     |     |     |     |         | g     |     |
y 7
|     |     | H   | (z4) z- | 8 D ++ |     |     |     |     |     |     | z - | 4 9 6 D | 7 + |     |
| --- | --- | --- | ------- | ------ | --- | --- | --- | --- | --- | --- | --- | ------- | --- | --- |
|     |     | x 8 | L P     |        | -   |     |     |     |     |     |     |         |     |     |
y g
|     |     |     | H   | (z8) | z- 1 6 D | ++   |     |     |     |     | -   | 4 8 0 D | 6 6 +   |     |
| --- | --- | --- | --- | ---- | -------- | ---- | --- | --- | --- | --- | --- | ------- | ------- | --- |
|     |     |     | x   | L P  |          | -    |     |     |     |     | z   |         |         |     |
|     |     |     | 7   |      |          |      |     |     |     |     |     |         | g       |     |
|     |     |     |     |      |          |      | ++  |     |     |     |     |         | y 5 5 + |     |
|     |     |     |     | x    | H ( z16) | z- 3 | 2 D |     |     |     | z - | 4 4 8 D |         |     |
|     |     |     |     |      | 6 L P    |      | -   |     |     |     |     |         | g       |     |
y 4
|     |     |     |     |     |     | H     | ( z32) z- 6 4 D | ++   |       |     | z - | 3 8 4 D | 4 +   |     |
| --- | --- | --- | --- | --- | --- | ----- | --------------- | ---- | ----- | --- | --- | ------- | ----- | --- |
|     |     |     |     |     |     | x L P |                 | -    |       |     |     |         |       |     |
|     |     |     |     |     |     | 5     |                 |      |       |     |     |         | y g   |     |
|     |     |     |     |     |     |       | z64)            |      | + +   |     |     |         | 3 3 + |     |
|     |     |     |     |     |     |       | x H (           | z- 1 | 2 8 D |     | z - | 2 5 6 D |       |     |
|     |     |     |     |     |     |       | 4 L P           |      | -     |     |     |         | g     |     |
y 2
|     |     |     |     |     |     |     |     | H   | ( z 128 ) z- | 2 5 6 D + + |     |     | 2 + |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------ | ----------- | --- | --- | --- | --- |
|     |     |     |     |     |     |     |     | x L | P            |             | -   |     |     |     |
|     |     |     |     |     |     |     |     | 3   |              |             |     |     | y g |     |
|     |     |     |     |     |     |     |     |     | H            | ( z 256 )   |     |     | 1 1 |     |
|     |     |     |     |     |     |     |     |     | x            | L P         | x   |     |     |     |
|     |     |     |     |     |     |     |     |     | 2            |             | 1   |     |     |     |
Figure1: BlockdiagramoftheparallelFIRgraphicequalizerfortenoctavebands[4]. Thesignalpathatthetopproducesthehighest
band(16kHz)whereasthebottomoneproducesthelowestband(31.25Hz).
H (zLm) Table 1: Performance of the proposed equalizer compared with
HP
|     |         |         |     |     |     |     | other        | linear-phase | GEQs | [4]. | The best | result | in each column | is  |
| --- | ------- | ------- | --- | --- | --- | --- | ------------ | ------------ | ---- | ---- | -------- | ------ | -------------- | --- |
| x   |         | x       |     |     | y   |     |              |              |      |      |          |        |                |     |
|     |         | m z-DLm | ++  | z-  |     | m   | highlighted. |              |      |      |          |        |                |     |
|     | G m (z) |         |     |     | m   |     |              |              |      |      |          |        |                |     |
-
x
|     |     | H   | (zLm) m-1 |     |     |     |     | Method |     | Latency |     | Mul | Add |     |
| --- | --- | --- | --------- | --- | --- | --- | --- | ------ | --- | ------- | --- | --- | --- | --- |
LP
|     |     |     |     |     |     |     |     | SingleFIR |     | 4599 |     | 4600 | 9198 |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | --- | ---- | --- | ---- | ---- | --- |
Figure 2: Filters and delay lines associated with a single band FFT-based 20983 116 168
|                                      |       |     |                             |               |     |     |         | Proposed |               | 4599          |     | 64    | 108           |     |
| ------------------------------------ | ----- | --- | --------------------------- | ------------- | --- | --- | ------- | -------- | ------------- | ------------- | --- | ----- | ------------- | --- |
| form = 2,3,...,M,cf.Fig.1.           |       |     | Thismthbandtransferfunction |               |     |     |         |          |               |               |     |       |               |     |
| H m (z)representstherelationbetweenY |       |     |                             | m (z)andX(z). |     |     |         |          |               |               |     |       |               |     |
|                                      | G (z) |     |                             |               |     |     |         |          |               |               |     |       |               |     |
|                                      |       |     |                             |               |     |     | method, | but      | a much higher | computational |     | cost. | The FFT-based |     |
m
approachshowsthelargestlatencyintroducedbytheframe-based
| x=x |     | x   | x   |     |     | x   |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
10 H (z) H (z2) (zLm+1) FFTprocessing. Althoughthelatencycanbereducedbyapply-
|     |     | 9   |     | m+1 | H   | m   |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
LP LP LP ingthezero-latencypartitionedconvolution[38,39],thecomputa-
tionalcomplexityremainshigherthantheproposedGEQ.Finally,
theerroriscomputedasthemaximummagnitudedifferencebe-
| Figure3:DetailsofthetransferfunctionG |     |     |     | m (z)usedinFig.2. |     |     |     |     |     |     |     |     |     |     |
| ------------------------------------- | --- | --- | --- | ----------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
tweenthedesiredandtheobtainedgainsatthecommandfrequen-
ciesoftheGEQ,takingintoaccountallthepossibleconfigurations
with±12dB[40],anditisequalto0.79dB.
| Finally, | aspresentedinFig.1, |     | thedesiredgainfactorg |     |     |     | of  |     |     |     |     |     |     |     |
| -------- | ------------------- | --- | --------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
m
eachbandisappliedandthetotalresponseoftheequalizery(n)is
obtainedasaweightedsumofallbandoutputsignals:
3. REAL-TIMEIMPLEMENTATION
M
|     |     |       | (cid:88) |      |     |     | TheproposedGEQhasbeenimplementedasaPlugInoftheNU- |     |     |     |     |     |     |     |
| --- | --- | ----- | -------- | ---- | --- | --- | ------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
|     |     | y(n)= | g y      | (n). |     | (8) |                                                   |     |     |     |     |     |     |     |
m m Tech software [41], that is a platform specifically developed to
m=1
testandtunereal-timeDSPalgorithmsthroughaPCworkbench.
Since the band filters determine the gain on their own band ThedevelopercanwritehisownplugIns,calledNUTSs(NU-Tech
very accurately, optimization of filter gains is unnecessary, and Satellites),inC++andplugthemintotheGUItotesttheresults
command gains can directly be used as weights g . It is worth onacommonPC.TheinternalparametersofeveryplugIncanbe
m
remarkingthattheuseofcomplementaryfiltersguaranteesacom- adjustedusingtheRTWatch(RealTimeWatch).
pletelyflattotalresponse, ensuringtheperfectreconstruction, as Fig. 4 shows the flowchart of the real-time implementation
demonstratedin[4]. oftheIFIRGEQ,andFig. 5showstheNU-Techinterfaceused
TheperformanceofthedescribedGEQhasbeenevaluatedin forexperimentaltests. TheproposedGEQisimplementedinthe
[4]intermsofcomputationalcomplexity,latency,anderror. The NUTS“IFIR_GEQ”builtasastandardC++dllfile.TheRTWatch,
totalnumberofoperationsoftheGEQis172,ofwhich64multi- shownatthebottomofFig. 5,allowsforthesettingoftwelvepa-
plicationsand108additions.Thelatency,calculatedfollowingEq. rameters,i.e.,“ResetGdb,”whichresetallthegainstozero,“By-
(7), isequalto4599samples, i.e., 95.8ms. In[4], theproposed pass,”whichcanbypasstheequalizerandcopytheinputdirectly
equalizerhasbeencomparedtootherlinear-phaseapproaches,i.e., totheoutputwithnoelaboration,andthegainsofthetenbandsof
singleFIRGEQandFFT-basedGEQ,andtheresultsareshownin theequalizer. Whentheuserpressestheplaybuttonofthetrans-
Tab.1.ThesingleFIRGEQhasthesamelatencyastheproposed portpanel,theinstructionsreportedinFig.4areexecuted.So,the
DAFx.3
| <   |     |     |     |     |     |     | 461 |     |     |     |     |     |     | >   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

PPrroocceeeeddiinnggssoofftthhee2277tthhIInntteerrnnaattiioonnaallCCoonnffeerreenncceeoonnDDiiggiittaallAAuuddiiooEEffffeeccttss((DDAAFFxx2244)),GGuuiillddffoorrdd,,SUunrrieteyd,UKKin,gSdeopmte,m3b-e7r3S-e7p,te2m02b4er2024
|     |     |     |       |     |     | performed.                                 | Thesubjectsinvolvedintheexperimentwere10ex- |     |             |     |
| --- | --- | --- | ----- | --- | --- | ------------------------------------------ | ------------------------------------------- | --- | ----------- | --- |
|     |     |     | input |     |     | pertlisteners,ranginginagefrom26to53years. |                                             |     | Theterm“ex- |     |
pert”referstoapersonwithatechnicalbackgroundinacoustics,
workingintheaudiofield,andwhoisexperiencedwithsubjective
listeningtests.Testsconductedwiththistypeoflistenerprovidea
update input buffer
(frame size) betterandquickerindicationoflikelylong-termresults.However,
toavoidbiasintheresultsofthelisteningtest,thelistenerswere
|     |     |     |     |     |     | notfamiliarwiththestudyandtheexpectedresults.            |     |     | Thetestwas |     |
| --- | --- | --- | --- | --- | --- | -------------------------------------------------------- | --- | --- | ---------- | --- |
|     |     |     |     |     | yes | designedasacomparativetestbetweentheequalizedandunequal- |     |     |            |     |
bypass?
izedtrack,usedasareference,andthebipolardiscreteseven-grade
scale,showninTab.2,wasused.
no
|     |     |     |     |     |     | Eachlistener, | performedatotalof16trialsconsideringfour |     |     |     |
| --- | --- | --- | --- | --- | --- | ------------- | ---------------------------------------- | --- | --- | --- |
,L , Δ   referencesignalsofdifferentmusicgenres, listedinTab. 3, and
| prototype filter and  |     | H LP m | m filter with the IFIR |     |     |     |     |     |     |     |
| --------------------- | --- | ------ | ---------------------- | --- | --- | --- | --- | --- | --- | --- |
fourequalizationcurvesderivedfromtheequalizationcurvesused
| parameters design   |     |     | structure |     |     |     |     |     |     |     |
| ------------------- | --- | --- | --------- | --- | --- | --- | --- | --- | --- | --- |
in[43],i.e.,
|     |     |     |     |     |     | • BassBoost(BB)withgains[3.433.433.4332.51.3-1-6 |     |     |     |     |
| --- | --- | --- | --- | --- | --- | ------------------------------------------------ | --- | --- | --- | --- |
g
| update gains of the  |     | m   | multiply gains with |     |     | -6-6];                                           |     |     |     |     |
| -------------------- | --- | --- | ------------------- | --- | --- | ------------------------------------------------ | --- | --- | --- | --- |
| GEQ 10 bands         |     |     | the band outputs    |     |     |                                                  |     |     |     |     |
|                      |     |     |                     |     |     | • TrebleBoost(TB)withgains[-6.25-5.63-4.38-23333 |     |     |     |     |
33];
sum band outputs, • MidrangeDip(MD)withgains[6.253.431-1-2-2.2-2-3
|     |     |     | update output buffer |     |     | 2-1]; |     |     |     |     |
| --- | --- | --- | -------------------- | --- | --- | ----- | --- | --- | --- | --- |
(frame size)
|     |     |     |     |     |     | • MidrangeBoost(MB)withgains[-6.25-3.43-1122.22 |     |     |     |     |
| --- | --- | --- | --- | --- | --- | ----------------------------------------------- | --- | --- | --- | --- |
3-21].
The“BassBoost”andthe“TrebleBoost”curvesemphasizelow
output
|     |     |     |     |     |     | andhighfrequencies,respectively. |     | The“MidrangeDip”isorigi- |     |     |
| --- | --- | --- | --- | --- | --- | -------------------------------- | --- | ------------------------ | --- | --- |
natedfroman80-phonequivalentloudnesscontour(ELC)ofthe
ISO-226standard[44],byderivingtheexactgainoftheELCcurve
Figure4: Flowchartofthereal-timeimplementationoftheIFIR
GEQ. atthecorrespondingtencommandfrequencies.Anequal-loudness
contourisameasureofsoundpressureoverthefrequencyspec-
trum,forwhichalistenerperceivesaconstantloudnesswhenpre-
|     |     |     |     |     |     | sentedwithpuretones[43]. |     | Finally,the“MidrangeBoost”curve |     |     |
| --- | --- | --- | --- | --- | --- | ------------------------ | --- | ------------------------------- | --- | --- |
inputbuffer,withaframesizelength,isupdatedwithinputsignal
isobtainedbychangingthecontrolgainsofthe“MidrangeDip”
| samples. | Ifthebypassisselected, |     | theinputsamplesaredirectly |     |     |     |     |     |     |     |
| -------- | ---------------------- | --- | -------------------------- | --- | --- | --- | --- | --- | --- | --- |
bysign.
copiedtotheoutputsignalwithoutelaboration.Ifthebypassisnot
|     |     |     |     |     |     | The proposed | IFIR GEQ | has been compared | with | the filter- |
| --- | --- | --- | --- | --- | --- | ------------ | -------- | ----------------- | ---- | ----------- |
active,theinputsignalisfilteredwiththeIFIRstructure,derived
|     |     |     |     |     |     | bank equalizer | (FBEq) of [32]. | Fig. 7(a) shows | the | four equal- |
| --- | --- | --- | --- | --- | --- | -------------- | --------------- | --------------- | --- | ----------- |
fromtheprototypefilter,asshowninFig.1.
|     |     |     |     |     |     | izationcurvesobtainedwiththeIFIRGEQ,andFig. |     |     |     | 7(b)shows |
| --- | --- | --- | --- | --- | --- | ------------------------------------------- | --- | --- | --- | --------- |
Theprototypefilterdesignandthecalculationoftheparame-
|     |     |     |     |     |     | the ones obtained | with the | FBEq, using a prototype | filter | with a |
| --- | --- | --- | --- | --- | --- | ----------------- | -------- | ----------------------- | ------ | ------ |
tersareimplementedoncebeforetheaudioplaybackandremain
lengthof8000samples.ItisworthnotingthattheFBEqfilterhas
| always the | same during | the reproduction. | Then, | each mth | band |     |     |     |     |     |
| ---------- | ----------- | ----------------- | ----- | -------- | ---- | --- | --- | --- | --- | --- |
amuchhighercomputationalcostthantheIFIRGEQ,requiringa
| outputismultipliedbytherespectivemthgaing |     |     |     | . Thegainsare |     |     |     |     |     |     |
| ----------------------------------------- | --- | --- | --- | ------------- | --- | --- | --- | --- | --- | --- |
m
chosenbytheuserusingtheRTWatchandmaychangeduringthe totalofmorethan600,000operationspersample.Moreover,even
thelatencyoftheFBEqisveryhighabove300ms.
| reproduction. | Asanexample,intheRTWatchofFig. |     |     | 5(i.e.,the |     |     |     |     |     |     |
| ------------- | ------------------------------ | --- | --- | ---------- | --- | --- | --- | --- | --- | --- |
Ineachtest,eachsubjectwassubjectedtotheevaluation,with
tableattheleftbottomoftheNU-Techboard)a±12dBzig-zag
respecttothereferencetrack,ofthesametrackequalizedwiththe
| settinggainischosen. |     | Finally,thebandoutputsaresummedand |     |     |     |     |     |     |     |     |
| -------------------- | --- | ---------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
IFIRGraphicEqualizer(IFIRGEQ),ofthesametrackequalized
| savedintheoutputbuffer,sotheoutputsignalisupdated. |          |            |                 | Forthe       |     |                     |                                                   |                |            |        |
| -------------------------------------------------- | -------- | ---------- | --------------- | ------------ | --- | ------------------- | ------------------------------------------------- | -------------- | ---------- | ------ |
|                                                    |          |            |                 |              |     | with the Filterbank | Equalizer                                         | (FBEq), and of | the Hidden | Refer- |
| experiments,                                       | a sample | rate of 48 | kHz and a frame | size of 8192 |     |                     |                                                   |                |            |        |
|                                                    |          |            |                 |              |     | ence, i.e.,         | thereference, unequalizedtrackhiddenwithinthetest |                |            |        |
sampleshavebeenused.
toauthenticatethelistener’sreliability.
Alltesttrackshadadurationoftwentyseconds,followingthe
4. EXPERIMENTALRESULTS guidelinesof[42]. Initially, foralltests, thereferencetrackwas
playedsothatthelistenerbecamefamiliarwiththeoriginalsound.
TheproposedGEQhasalreadybeenobjectivelyvalidatedin[4], After that, for each reference signal, the program sequence was
evaluating its performance, as reported in Sec. 2. In this work, presented in random order, and the listener did not know which
subjective tests are performed in a listening room shown in Fig. equalizationmethodologywasundertest. Inaddition,thelistener
6, using two loudspeakers Hedd Type 20 MK2 spaced two me- wasallowedtolistentoatrackunderexaminationseveraltimesto
tersfromthelistener. Theloudspeakershavebeenconnectedtoa obtainamorerationalandlessinstinctivejudgment. Toevaluate
soundcardRolandRubix22,managedbyanHPNotebooklaptop theperformanceoftheIFIRGEQandFBEqagainsttheoriginal
Intel(R)Core(TM)i7. track,listenerswereaskedtoratesomeoftheattributessuggested
Toassesstheperceptionoftheaudioqualityofequalizedsound, by[42]accordingtotheseven-gradecomparisonscaleshownin
listeningtestsfollowingtheITU-RBS.1284-1standard[42]were Tab.2.Thefollowingattributeshavebeenevaluated:
DAFx.4
| <   |     |     |     |     | 462 |     |     |     |     | >   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

PPrroocceeeeddiinnggssoofftthhee2277tthhIInntteerrnnaattiioonnaallCCoonnffeerreenncceeoonnDDiiggiittaallAAuuddiiooEEffffeeccttss((DDAAFFxx2244)),GGuuiillddffoorrdd,,SUunrrieteyd,UKKin,gSdeopmte,m3b-e7r3S-e7p,te2m02b4er2024
Figure5:ScreenoftheNU-Techboardusedforexperimentaltests.
Table2:Bipolardiscreteseven-gradescale[42].
Comparison
3 Muchbetter
2 Better
1 Slightlybetter
0 Thesame
-1 Slightlyworse
-2 Worse
-3 Muchworse
Table3:Musictracksusedforlisteningtests.
|     |     |     |     |     | Genre Author | Track |     |
| --- | --- | --- | --- | --- | ------------ | ----- | --- |
Figure6:Photoofthesetupusedforlisteningtests.
|     |     |     |     |     | Classical Tchaikovsky | WaltzoftheFlowers  |     |
| --- | --- | --- | --- | --- | --------------------- | ------------------ | --- |
|     |     |     |     |     | Jazz H.Hancock        | EdithandtheKingpin |     |
• Timbre,i.e.,accurateportrayalofthedifferentsoundchar- Pop G.Michael Amazing
| acteristicsofsoundsource; |     |     |     |     | Rock ZZTop | ConcreteandSteel |     |
| ------------------------- | --- | --- | --- | --- | ---------- | ---------------- | --- |
• Transparency,i.e.,capacitytoperceivealldetailsofperfor-
manceclearly;
Tab.4reportstheexperimentalresultsobtainedwiththeequal-
• Mainimpression,i.e.,theintegrityofthetotalsoundimage,
izationcurve“BassBoost”forallfourmusicgenres(i.e.,classi-
andtheinteractionbetweenthevariousparameters. cal,jazz,pop,androck),comparingtheIFIRGEQwiththeFBEq.
Theanalysisoftheresultsofthe“BassBoost”equalizationcurve
| The evaluation | of the attributes | is also affected | by the nature | of  |     |     |     |
| -------------- | ----------------- | ---------------- | ------------- | --- | --- | --- | --- |
showsaverysimilarlevelofbothalgorithmsforallattributesin
| thetypeofequalization. | However,althoughsomeattributesmay |     |     |                 |                                          |     |     |
| ---------------------- | --------------------------------- | --- | --- | --------------- | ---------------------------------------- | --- | --- |
|                        |                                   |     |     | eachmusicgenre. | Themostsignificantgapisinthetransparency |     |     |
presentaratelowerthanzero,whichmeansthattheoriginaltrack
|               |                    |              |            | of the | classical genre where | the IFIR GEQ scored | 0.33 points |
| ------------- | ------------------ | ------------ | ---------- | ------ | --------------------- | ------------------- | ----------- |
| sounds better | than the equalized | one, the two | equalizers | can be |                       |                     |             |
evaluatedbycomparingthescoreofeachattribute. higher than its competitor equalizer at the same standard devia-
Theresultsofthesubjectivetestswereprocessedbyderiving tion. Overall,theFBEqwaspreferredfivetimesversustheIFIR
themeanvalueandconfidenceintervalsforthestandarddeviation, GEQ’sfourtimes,andthreetimestheyscoredthesame.
calculatedconsideringasignificancelevelofα = 0.05,i.e.,with Next, Tab. 5 shows the test results for the “Treble Boost”
a standard deviation (SD) of 95%, thus providing a statistically equalization curve for the four music genres. In this case, the
meaningfulanalysis. results show a slight preference for the IFIR equalizer in that it
DAFx.5
| <   |     |     |     | 463 |     |     | >   |
| --- | --- | --- | --- | --- | --- | --- | --- |

PPrroocceeeeddiinnggssoofftthhee2277tthhIInntteerrnnaattiioonnaallCCoonnffeerreenncceeoonnDDiiggiittaallAAuuddiiooEEffffeeccttss((DDAAFFxx2244)),GGuuiillddffoorrdd,,SUunrrieteyd,UKKin,gSdeopmte,m3b-e7r3S-e7p,te2m02b4er2024
Table4:Experimentalresultsobtainedwiththeequalizationcurve
|     |     |     |     |     |     | “BassBoost”. | Foreachattributeandeachmusicgenre,thehigh- |     |     |     |     |
| --- | --- | --- | --- | --- | --- | ------------ | ------------------------------------------ | --- | --- | --- | --- |
estmeanvalueishighlighted.
|     |     |     |     |     |     |           | Timbre      | Transparency | Mainimpression |          |     |
| --- | --- | --- | --- | --- | --- | --------- | ----------- | ------------ | -------------- | -------- | --- |
|     |     |     |     |     |     | Equalizer | Mean SD     | Mean SD      | Mean           | SD Genre |     |
|     |     |     |     |     |     |           | value (95%) | value (95%)  | value          | (95%)    |     |
|     |     |     |     |     |     | IFIRGEQ   | -1.0 0.57   | -0.67 0.65   | -1.0           | 0.57     |     |
Classical
|     |     |     |     |     |     | FBEq    | -0.89 0.83 | -1.0 0.65  | -1.0  | 0.80 |     |
| --- | --- | --- | --- | --- | --- | ------- | ---------- | ---------- | ----- | ---- | --- |
|     |     |     |     |     |     | IFIRGEQ | -1.0 0.92  | -1.22 0.79 | -1.11 | 0.95 |     |
Jazz
|     |     |     |     |     |     | FBEq    | -1.22 0.71 | -1.11 0.76 | -1.22 | 0.71      |     |
| --- | --- | --- | --- | --- | --- | ------- | ---------- | ---------- | ----- | --------- | --- |
|     |     | (a) |     |     |     | IFIRGEQ | -1.5 0.33  | -0.9 0.46  | -1.5  | 0.44      | Pop |
|     |     |     |     |     |     | FBEq    | -1.4 0.32  | -1.0 0.51  | -1.5  | 0.53      |     |
|     |     |     |     |     |     | IFIRGEQ | -1.4 0.32  | -1.7 0.42  | -1.7  | 0.42      |     |
|     |     |     |     |     |     | FBEq    | -1.4 0.32  | -1.5 0.53  | -1.6  | 0.43 Rock |     |
Table5:Experimentalresultsobtainedwiththeequalizationcurve
“TrebleBoost”.Foreachattributeandeachmusicgenre,thehigh-
estmeanvalueishighlighted.
|     |     |     |     |     |     |           | Timbre      | Transparency | Mainimpression |                |     |
| --- | --- | --- | --- | --- | --- | --------- | ----------- | ------------ | -------------- | -------------- | --- |
|     |     |     |     |     |     | Equalizer | Mean SD     | Mean SD      | Mean           | SD Genre       |     |
|     |     |     |     |     |     |           | value (95%) | value (95%)  | value          | (95%)          |     |
|     |     |     |     |     |     | IFIRGEQ   | -0.5 0.74   | -0.38 0.63   | -0.38          | 0.82 Classical |     |
|     |     |     |     |     |     | FBEq      | -0.75 0.89  | -0.25 0.72   | -0.38          | 0.82           |     |
(b)
|     |     |     |     |     |     | IFIRGEQ | 0.0 0.83 | 0.38 0.9 | 0.13 | 0.78 |     |
| --- | --- | --- | --- | --- | --- | ------- | -------- | -------- | ---- | ---- | --- |
Jazz
|     |     |     |     |     |     | FBEq | 0.25 0.96 | 0.38 1.04 | 0.13 | 0.86 |     |
| --- | --- | --- | --- | --- | --- | ---- | --------- | --------- | ---- | ---- | --- |
Figure7:Fourequalizationcurvesobtained(a)withtheproposed IFIRGEQ -0.56 0.87 0.11 0.83 -0.78 0.91
Pop
IFIRGEQand(b)withtheFBEq. FBEq -0.66 0.73 -0.33 0.73 -1.0 0.65
|     |     |     |     |     |     | IFIRGEQ | -0.7 0.78 | -0.5 0.67 | -0.8 | 0.87 Rock |     |
| --- | --- | --- | --- | --- | --- | ------- | --------- | --------- | ---- | --------- | --- |
|     |     |     |     |     |     | FBEq    | -1.1 0.74 | -0.8 0.49 | -1.1 | 0.68      |     |
was preferred seven times out of twelve, and three times scored Table6:Experimentalresultsobtainedwiththeequalizationcurve
thesameastheFBEq. Inaddition,althoughbyonly0.11points, “Midrange Dip”. For each attribute and each music genre, the
thetransparencyoftheIFIRGEQinthepopgenrewaspreferred highestmeanvalueishighlighted.
| to the referencetrack | as opposed        | to thetrack        | equalized | with | the  |     |        |              |                |     |     |
| --------------------- | ----------------- | ------------------ | --------- | ---- | ---- | --- | ------ | ------------ | -------------- | --- | --- |
| FBEq. In              | addition, for the | pop and rock music | genres,   | the  | IFIR |     |        |              |                |     |     |
|                       |                   |                    |           |      |      |     | Timbre | Transparency | Mainimpression |     |     |
GEQwasalwayspreferredovertheFBEq. Equalizer Mean SD Mean SD Mean SD Genre
Tab. 6 shows the results obtained with the “Midrange Dip” value (95%) value (95%) value (95%)
|     |     |     |     |     |     | IFIRGEQ | 0.67 0.57 | 0.44 0.58 | 0.67 | 0.57 |     |
| --- | --- | --- | --- | --- | --- | ------- | --------- | --------- | ---- | ---- | --- |
Classical
equalization curve. This type of equalization curve improves all FBEq 0.56 0.47 1.0 0.46 0.67 0.80
threeattributes,inboththeequalizersandwithallfourmusicgen- IFIRGEQ 0.56 0.66 0.44 0.66 0.55 0.66
|     |     |     |     |     |     | FBEq | 0.22 0.71 | 0.44 0.47 | 0.11 | 0.61 Jazz |     |
| --- | --- | --- | --- | --- | --- | ---- | --------- | --------- | ---- | --------- | --- |
res. Inparticular,theIFIRGEQscoredbetterfortimbreineach
|             |                                             |     |     |     |     | IFIRGEQ | 0.89 0.69 | 0.89 0.51 | 0.67 | 0.57 |     |
| ----------- | ------------------------------------------- | --- | --- | --- | --- | ------- | --------- | --------- | ---- | ---- | --- |
| musicgenre. | Italsoscoredahighermainimpressionforjazzmu- |     |     |     |     |         |           |           |      |      | Pop |
|             |                                             |     |     |     |     | FBEq    | 0.67 0.57 | 0.67 0.46 | 0.67 | 0.57 |     |
sic than the FBEq by 0.44 points. The FBEq equalizer, on the IFIRGEQ 0.8 0.64 0.9 0.46 0.9 0.54
Rock
otherhand,wasbetterintermsoftransparencywiththeclassical FBEq 0.7 0.42 1.0 0.41 1.0 0.29
| genre by | 0.56 points. Overall, | the IFIR GEQ | was | preferred | six |     |     |     |     |     |     |
| -------- | --------------------- | ------------ | --- | --------- | --- | --- | --- | --- | --- | --- | --- |
timesagainsttheFBEq’sthreetimes,andthreetimestheyscored
Table7:Experimentalresultsobtainedwiththeequalizationcurve
thesame.
|     |     |     |     |     |     | “MidrangeBoost”. | Foreachattributeandeachmusicgenre,the |     |     |     |     |
| --- | --- | --- | --- | --- | --- | ---------------- | ------------------------------------- | --- | --- | --- | --- |
Finally, Tab. 7 reports the results for the “Midrange Boost” highestmeanvalueishighlighted.
equalizationcurve.Inthiscase,thereisapreferenceforthetimbre
withIFIRGEQforeachmusicalgenre. Inaddition,themainim- Timbre Transparency Mainimpression
pressionforthepopgenreoftheimplementedequalizerisfoundto Equalizer Mean SD Mean SD Mean SD Genre
be0.5pointshigherthanthatoftheFBEqtrack.Also,aswiththe value (95%) value (95%) value (95%)
|     |     |     |     |     |     | IFIRGEQ | -0.44 0.58 | -0.11 0.61 | -0.78 | 0.71 |     |
| --- | --- | --- | --- | --- | --- | ------- | ---------- | ---------- | ----- | ---- | --- |
“TrebleBoost”curve,theIFIRGEQwaspreferredoveritscom- Classical
|                                                    |     |     |     |        |     | FBEq    | -0.78 0.44 | -0.33 0.57 | -0.78 | 0.71      |     |
| -------------------------------------------------- | --- | --- | --- | ------ | --- | ------- | ---------- | ---------- | ----- | --------- | --- |
| petitorforallattributesinthepopandrockmusicgenres. |     |     |     | Ingen- |     |         |            |            |       |           |     |
|                                                    |     |     |     |        |     | IFIRGEQ | -0.3 0.93  | 0.0 0.65   | -0.3  | 0.78 Jazz |     |
eral,theIFIRGEQwaspreferredninetimesoutoftwelve,twice FBEq -0.4 0.78 0.1 0.62 -0.3 0.78
theygotthesamescore,andonlyoncewastheFBEqpreferred. IFIRGEQ -0.6 0.67 -0.4 0.6 -0.5 0.67
Pop
|     |     |     |     |     |     | FBEq | -1.0 0.51 | -0.6 0.6 | -1.0 | 0.65 |     |
| --- | --- | --- | --- | --- | --- | ---- | --------- | -------- | ---- | ---- | --- |
Overall, thereisaslightpreferencefortheIFIRequalizerin IFIRGEQ -0.44 0.66 -0.33 0.57 -0.56 0.66
Rock
thatitwaspreferredtwenty-sixtimescomparedtoelevenforthe FBEq -0.67 0.33 -0.56 0.34 -0.89 0.22
| FBEq,andeleventimestheyscoredthesame. |     |     | However,themain |     |     |     |     |     |     |     |     |
| ------------------------------------- | --- | --- | --------------- | --- | --- | --- | --- | --- | --- | --- | --- |
advantageofthisgraphicalequalizerliesinthefactthatthecom-
putationalcostofmakingitissignificantlylowerthanthatrequired
to make the Filterbank Equalizer. The use of the prototype FIR ing the filtering phase, and the symmetry of the prototype filter
half-bandinterpolatedfilteranditsstretchedversionsmakesitpos- responsemakesitpossibletohalvethenumberofoperations. In
sibletoavoidmultiplicationswiththenullvaluesofthefilterdur- contrast, theFBEqwithasubbandstructure, basedontwoanal-
DAFx.6
| <   |     |     |     |     | 464 |     |     |     |     |     | >   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

PPrroocceeeeddiinnggssoofftthhee2277tthhIInntteerrnnaattiioonnaallCCoonnffeerreenncceeoonnDDiiggiittaallAAuuddiiooEEffffeeccttss((DDAAFFxx2244)),GGuuiillddffoorrdd,,SUunrrieteyd,UKKin,gSdeopmte,m3b-e7r3S-e7p,te2m02b4er2024
ysisandtwosynthesisfiltersforeachdirectbranchtowhichare 728–737, Nov.2000, https://doi.org/110.1109/
addedtwocontributionsduetothecrossanalysisandsynthesisfil- 89.876311.
tersthattakeintoaccounttheinteractionbetweenadjacentbands,
|     |     |     |     |     |     |     |     | [8] Y.Hirata, | “Digitalizationofconventionalanalogfiltersfor |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --------------------------------------------- | --- | --- | --- | --- | --- |
hasahighercomputationalcomplexity.
|     |     |     |     |     |     |     |     | recordinguse,” |     | J.AudioEng.Soc.,vol.29,no.5,pp.333– |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------- | --- | ----------------------------------- | --- | --- | --- | --- |
337,May1981.
5. CONCLUSIONS
|     |     |     |     |     |     |     |     | [9] S.PrinceandK.R.S.Kumar, |     |     |     | “AnovelNth-orderIIRfilter- |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- | --- | -------------------------- | --- | --- |
basedgraphicequalizeroptimizedthroughgeneticalgorithm
Thepaperproposesareal-timeimplementationofalinear-phase
|             |             |             |        |                 |         |              |     | forcomputingfilterorder,” |     |     | SoftComput.,vol.23,no.8,pp. |     |     |     |
| ----------- | ----------- | ----------- | ------ | --------------- | ------- | ------------ | --- | ------------------------- | --- | --- | --------------------------- | --- | --- | --- |
| octave-band | graphic     | equalizer   | based  | on interpolated |         | FIR filters. |     |                           |     |     |                             |     |     |     |
|             |             |             |        |                 |         |              |     | 2683–2691,Apr.2019,       |     |     | https://doi.org/10.1007/    |     |     |     |
| The GEQ     | is realized | as a PlugIn | inside | the             | NU-Tech | software.    |     |                           |     |     |                             |     |     |     |
s00500-018-3640-9.
| A first validation |            | of the system     | has | proven   | the performance |          | of  |                                           |     |     |     |     |               |     |
| ------------------ | ---------- | ----------------- | --- | -------- | --------------- | -------- | --- | ----------------------------------------- | --- | --- | --- | --- | ------------- | --- |
|                    |            |                   |     |          |                 |          |     | [10] JussiRämö,JuhoLiski,andVesaVälimäki, |     |     |     |     | “Third-octave |     |
| the GEQ,           | confirming | its effectiveness |     | in terms | of error,       | latency, |     |                                           |     |     |     |     |               |     |
and computational complexity. Successively, the equalizer has andbarkgraphic-equalizerdesignwithsymmetricbandfil-
beentestedthroughsubjectivetestsandcomparedwithafilterbank ters,”Appl.Sci.,vol.10,no.4,pp.1–22,Feb.2020,https:
equalizer. Theexperimentalresultshaveshownthattheproposed //doi.org/10.3390/app10041222.
equalizerispreferredinmostofthecasesanditpresentsamuch
|                     |     |           |                 |     |        |         |     | [11] S.Tassart, | “Graphicalequalizationusinginterpolatedfilter |     |     |     |     |     |
| ------------------- | --- | --------- | --------------- | --- | ------ | ------- | --- | --------------- | --------------------------------------------- | --- | --- | --- | --- | --- |
| lower computational |     | load than | the filterbank. |     | Future | plan of | the |                 |                                               |     |     |     |     |     |
banks,” J.AudioEng.Soc.,vol.61,no.5,pp.263–279,May
systemincludethedevelopmentoftheIFIRGEQonanembedded
2013.
system.
|     |     |     |     |     |     |     |     | [12] J. Rämö, | V.      | Välimäki,   | and B.   | Bank, “High-precision |       | par-   |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | ------- | ----------- | -------- | --------------------- | ----- | ------ |
|     |     |     |     |     |     |     |     | allel         | graphic | equalizer,” | IEEE/ACM | Trans.                | Audio | Speech |
6. ACKNOWLEDGMENTS
|     |     |     |     |     |     |     |     | Lang. | Process., | vol. | 22, no. | 12, pp. | 1894–1904, | Dec. |
| --- | --- | --- | --- | --- | --- | --- | --- | ----- | --------- | ---- | ------- | ------- | ---------- | ---- |
2014, https://doi.org/10.1109/TASLP.2014.
ThisresearchhasreceivedfundingfromtheprojectVitality–Pro-
2354241.
jectCodeECS00000041,CUPI33C22001330007-fundedunder
the National Recovery and Resilience Plan (NRRP), Mission 4 [13] Juho Liski, Balázs Bank, Julius O. Smith, and Vesa
Component2Investment1.5-’Creationandstrengtheningofin- Välimäki, “Converting series biquad filters into delayed
novationecosystems,’constructionof’territorialleadersinR&D’ parallel form: Application to graphic equalizers,” IEEE
–InnovationEcosystems-Project’Innovation,digitalizationand Trans.SignalProcess.,vol.67,no.14,pp.3785–3795,Jul.
sustainabilityforthediffusedeconomyinCentralItaly–VITAL- 2019, https://doi.org/110.1109/TSP.2019.
| ITY’ Call | for tender | No. 3277 | of 30/12/2021, |     | and | Concession |     | 2919419. |     |     |     |     |     |     |
| --------- | ---------- | -------- | -------------- | --- | --- | ---------- | --- | -------- | --- | --- | --- | --- | --- | --- |
DecreeNo.0001057.23-06-2022ofItalianMinistryofUniversity [14] DennisABohn, “Constant-Qgraphicequalizers,” J.Audio
fundedbytheEuropeanUnion–NextGenerationEU. Eng.Soc.,vol.34,no.9,pp.611–626,Sep.1986.
|     |     |               |     |     |     |     |     | [15] V.VälimäkiandJ.Liski, |            |                              | “Accuratecascadegraphicequal- |          |        |          |
| --- | --- | ------------- | --- | --- | --- | --- | --- | -------------------------- | ---------- | ---------------------------- | ----------------------------- | -------- | ------ | -------- |
|     |     | 7. REFERENCES |     |     |     |     |     |                            |            |                              |                               |          |        |          |
|     |     |               |     |     |     |     |     | izer,”                     | IEEE       | Signal Process.              | Lett.,                        | vol. 24, | no. 2, | pp. 176– |
|     |     |               |     |     |     |     |     | 180,                       | Feb. 2017, | https://doi.org/10.1109/LSP. |                               |          |        |          |
[1] RichardA.GreinerandMichaelSchoessow,“Designaspects
2016.2645280.
J.AudioEng.Soc.,vol.31,no.6,pp.
ofgraphicequalizers,”
|     |     |     |     |     |     |     |     | [16] KristófHorváthandBalázsBank, |     |     |     | “Optimizingthenumeri- |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------------------------- | --- | --- | --- | --------------------- | --- | --- |
394–407,Jun.1983.
[2] S. K. Mitra and J. F. Kaiser, Handbook for Digital Signal calnoiseofparallelsecond-orderfiltersinfixed-pointarith-
Processing, JohnWiley&Sons, NewYork, NY,USA,1st metic,”J.AudioEng.Soc.,vol.67,no.10,pp.763–771,Oct.
2019, https://doi.org/10.17743/jaes.2019.
edition,Aug.1993.
0027.
| [3] V.VälimäkiandJ.D.Reiss, |     |     | “Allaboutaudioequalization: |     |     |     |     |     |     |     |     |     |     |     |
| --------------------------- | --- | --- | --------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Solutionsandfrontiers,” Appl.Sci.,vol.6,no.5,May2016, [17] J.A.Jensen, “Anewprincipleforanall-digitalpreamplifier
https://doi.org/10.3390/app6050129. andequalizer,” J.AudioEng.Soc.,vol.35,no.12,pp.994–
1003,Dec.1987.
| [4] V. Bruschi, |     | V. Välimäki, | J. Liski, | and | S. Cecchi, | “Linear- |     |     |     |     |     |     |     |     |
| --------------- | --- | ------------ | --------- | --- | ---------- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
phaseoctavegraphicequalizer,” J.AudioEng.Soc.,vol.70, [18] J.Henriquez,T.Riemer,andR.TrahanJr., “APhase-Linear
no.6,pp.435–445,June2022,SpecialIssueonAudioFilter Audio Equalizer: Design and Implementation,” J. Audio
| Design. |     |     |     |     |     |     |     | Eng.Soc.,vol.38,no.9,pp.653–666,Sept.1990. |     |     |     |     |     |     |
| ------- | --- | --- | --- | --- | --- | --- | --- | ------------------------------------------ | --- | --- | --- | --- | --- | --- |
[5] AlexisFavrotandChristofFaller, “Wiener-basedspatialb- [19] Michael Waters, Mark Sandler, and A. C. Davies, “Low-
format equalization,” J. Audio Eng. Soc., vol. 68, no. 7/8, orderFIRfiltersforaudioequalization,” inProc.91stCon-
pp. 488–494, Jul./Aug. 2020, https://doi.org/10. ventionoftheAudioEngineeringSociety,Oct.1991, paper
| 17743/jaes.2020.0029. |     |     |     |     |     |     |     | 3188. |     |     |     |     |     |     |
| --------------------- | --- | --- | --- | --- | --- | --- | --- | ----- | --- | --- | --- | --- | --- | --- |
[6] Juha Vilkamo, Tom Bäckström, and Achim Kuntz, “Op- [20] DavidS.McGrath, “Anefficient30-bandgraphicequalizer
timized covariance domain framework for time–frequency implementationforalow-costdspprocessor,” inProc.95th
processing of spatial audio,” J. Audio Eng. Soc., vol. 61, ConventionoftheAudioEngineeringSociety,Oct.1993,pa-
| no.6,pp.403–411,Jun.2013. |     |     |     |     |     |     |     | per3756. |     |     |     |     |     |     |
| ------------------------- | --- | --- | --- | --- | --- | --- | --- | -------- | --- | --- | --- | --- | --- | --- |
[7] B.D. Radlovic and R.A. Kennedy, “Nonminimum-phase [21] PaulH.Kraght,“Alinear-phasedigitalequalizerwithcubic-
equalization and its subjective importance in room acous- splinefrequencyresponse,” J.AudioEng.Soc.,vol.40,no.
tics,” IEEETrans.SpeechAudioProcess.,vol.8,no.6,pp. 5,pp.403–414,May1992.
DAFx.7
| <   |     |     |     |     |     |     | 465 |     |     |     |     |     |     | >   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

PPrroocceeeeddiinnggssoofftthhee2277tthhIInntteerrnnaattiioonnaallCCoonnffeerreenncceeoonnDDiiggiittaallAAuuddiiooEEffffeeccttss((DDAAFFxx2244)),GGuuiillddffoorrdd,,SUunrrieteyd,UKKin,gSdeopmte,m3b-e7r3S-e7p,te2m02b4er2024
[22] D.S.McGrath, “Anewapproachtodigitalaudioequaliza- [37] P. P. Vaidyanathan, Multirate Systems and Filterbanks,
tion,” in Proc. 97th Convention of the Audio Engineering Prentice-Hall,Inc.,EnglewoodCliffs,NJ,1993, Chapter4,
| Society,SanFrancisco,CA,Nov.1994, |     |     |     |     | paper3899. |     |     | pp.134-143. |     |     |     |     |     |     |
| --------------------------------- | --- | --- | --- | --- | ---------- | --- | --- | ----------- | --- | --- | --- | --- | --- | --- |
[23] R.VäänänenandJ.Hiipakka, “Efficientaudioequalization [38] W.G.Gardner, “Efficientconvolutionwithoutinput/output
usingmultirateprocessing,” J.AudioEng.Soc.,vol.56,no. delay,” J.AudioEng.Soc.,vol.43,no.3,pp.127–136,Mar.
| 4,pp.255–266,Apr.2008. |     |     |     |     |     |     |     | 1995. |     |     |     |     |     |     |
| ---------------------- | --- | --- | --- | --- | --- | --- | --- | ----- | --- | --- | --- | --- | --- | --- |
[24] M.K.OthmanandT.H.Lim, “Runtimeanalysisofanau- [39] Frank Wefers and Jan Berg, “High-performance real-time
diographicequalizerforportableindustrialdirectionalsound fir-filteringusingfastconvolutionongraphicshardware,” in
systemsinindustrialusage,” inProc.14thIEEEConference Proceedingsofthe13thInternationalConferenceonDigital
on Industrial Electronics and Applications (ICIEA), Xi’an, AudioEffects(DAFx),Sep.2010.
| China, | Jun. 2019, | pp. | 2177–2181, |     | https://doi.org/ |     |     |           |           |                |     |            |     |          |
| ------ | ---------- | --- | ---------- | --- | ---------------- | --- | --- | --------- | --------- | -------------- | --- | ---------- | --- | -------- |
|        |            |     |            |     |                  |     |     | [40] Juho | Liski and | Vesa Välimäki, |     | “The quest | for | the best |
110.1109/ICIEA.2019.8833760.
|     |     |     |     |     |     |     |     | graphic | equalizer,” | in Proc. | 20th International |     | Conference |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | ----------- | -------- | ------------------ | --- | ---------- | --- |
[25] R.J.Oliver,“Frequency-warpedaudioequalizer,”USPatent
onDigitalAudioEffects(DAFx),Sep.2017,pp.95–102.
7,764,802B2,Jul.2010.
|                    |         |           |              |     |               |            |     | [41] ArianoLattanzi,FerruccioBettarelli,StefaniaCecchi,etal., |     |                                     |               |           |     |       |
| ------------------ | ------- | --------- | ------------ | --- | ------------- | ---------- | --- | ------------------------------------------------------------- | --- | ----------------------------------- | ------------- | --------- | --- | ----- |
| [26] J. Siiskonen, |         | “Graphic  | Equalization |     | Using         | Frequency- |     |                                                               |     |                                     |               |           |     |       |
|                    |         |           |              |     |               |            |     | “Nu-tech:                                                     | The | entry tool                          | of the hartes | toolchain | for | algo- |
| Warped             | Digital | Filters,” | Master’s     |     | thesis, Aalto | University |     |                                                               |     |                                     |               |           |     |       |
|                    |         |           |              |     |               |            |     | rithmsdesign,”                                                |     | inProc.124thConventionoftheAudioEn- |               |           |     |       |
SchoolofElectricalEngineering,Espoo,Finland,Jul.2016.
gineeringSociety,May2008,pp.1–8.
| [27] T. G. | Stockham | Jr.,   | “High-Speed |          | Convolution | and | Corre- |                      |     |                                    |     |     |     |     |
| ---------- | -------- | ------ | ----------- | -------- | ----------- | --- | ------ | -------------------- | --- | ---------------------------------- | --- | --- | --- | --- |
|            |          |        |             |          |             |     |        | [42] ITU-RBS.1284-1, |     | “Generalmethodsforthesubjectiveas- |     |     |     |     |
| lation,”   | in Proc. | Spring | Joint       | Computer | Conference, |     | New    |                      |     |                                    |     |     |     |     |
sessmentofsoundquality,”Geneva,2003.
York,NY,Apr.1966,vol.28,pp.229–233.
|     |     |     |     |     |     |     |     | [43] Weidong | Shen, | Tiffany Chua, | Kelly | Reavis, | Hongmei | Xia, |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | ----- | ------------- | ----- | ------- | ------- | ---- |
[28] BarryD.Kulp,“DigitalequalizationusingFouriertransform
DuoZhang,GeraldAMaguire,DavidFranklin,VincentLiu,
techniques,”inProc.85thConventionoftheAudioEngineer-
|                                    |     |     |     |     |            |     |     | WeiHou,andHungTran, |     |     | “Subjectiveevaluationofperson- |     |     |     |
| ---------------------------------- | --- | --- | --- | --- | ---------- | --- | --- | ------------------- | --- | --- | ------------------------------ | --- | --- | --- |
| ingSociety,LosAngeles,CA,Oct.1988, |     |     |     |     | paper2694. |     |     |                     |     |     |                                |     |     |     |
alizedequalizationcurvesinmusic,”inProc.133rdConven-
[29] H.SchöppandH.Hetze, “Alinear-phase512-bandgraphic tionoftheAudioEngineeringSociety,2012.
| equalizer | using | the | fast-Fourier | transform,” |     | in Proc. | 96th |            |           |           |             |     |            |     |
| --------- | ----- | --- | ------------ | ----------- | --- | -------- | ---- | ---------- | --------- | --------- | ----------- | --- | ---------- | --- |
|           |       |     |              |             |     |          |      | [44] Sunil | Bharitkar | and Chris | Kyriakakis, | “A  | comparison | be- |
ConventionoftheAudioEngineeringSociety,Feb.1994,pa-
|     |     |     |     |     |     |     |     | tween | multi-channel | audio | equalization | filters | using | warp- |
| --- | --- | --- | --- | --- | --- | --- | --- | ----- | ------------- | ----- | ------------ | ------- | ----- | ----- |
per3816.
ing,”inProc.IEEEWorkshoponApplicationsofSignalPro-
[30] G. F. P. Fernandes, L. G. P. M. Martins, M. F. M. Sousa, cessingtoAudioandAcoustics,2003,pp.63–66.
| F.S.Pinto,andA.J.S.Ferreira,       |     |     |     | “Implementationofanew |                  |     |     |     |     |     |     |     |     |     |
| ---------------------------------- | --- | --- | --- | --------------------- | ---------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| methodtodigitalaudioequalization,” |     |     |     |                       | inProc.106thCon- |     |     |     |     |     |     |     |     |     |
ventionoftheAudioEngineeringSociety,Munich,Germany,
| May1999,                         | paper4895. |     |                                |     |                  |     |     |     |     |     |     |     |     |     |
| -------------------------------- | ---------- | --- | ------------------------------ | --- | ---------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [31] S.RiesandG.Frieling,        |            |     | “PC-basedequalizerwithvariable |     |                  |     |     |     |     |     |     |     |     |     |
| gainanddelayin31frequencybands,” |            |     |                                |     | inProc.108thCon- |     |     |     |     |     |     |     |     |     |
ventionoftheAudioEngineeringSociety,Paris,France,Feb.
| 2000,           | paper5173. |            |             |     |                |     |        |     |     |     |     |     |     |     |
| --------------- | ---------- | ---------- | ----------- | --- | -------------- | --- | ------ | --- | --- | --- | --- | --- | --- | --- |
| [32] S. Cecchi, | L.         | Palestini, | E. Moretti, |     | and F. Piazza, |     | “A new |     |     |     |     |     |     |     |
approachtodigitalaudioequalization,”inProc.IEEEWork-
| shop      | on Applications                      |     | of Signal | Processing |          | to Audio | and     |     |     |     |     |     |     |     |
| --------- | ------------------------------------ | --- | --------- | ---------- | -------- | -------- | ------- | --- | --- | --- | --- | --- | --- | --- |
| Acoustics | (WASPAA),                            |     | New       | Paltz,     | NY, Oct. | 2007,    | pp. 62– |     |     |     |     |     |     |     |
| 65,       | https://doi.org/110.1109/ASPAA.2007. |     |           |            |          |          |         |     |     |     |     |     |     |     |
4393011.
| [33] R. Hergum,      |                                          | “A Low    | Complexity, |           | Linear        | Phase | Graphic |     |     |     |     |     |     |     |
| -------------------- | ---------------------------------------- | --------- | ----------- | --------- | ------------- | ----- | ------- | --- | --- | --- | --- | --- | --- | --- |
| Equalizer,”          | inProc.85thConventionoftheAudioEngineer- |           |             |           |               |       |         |     |     |     |     |     |     |     |
| ingSociety,Nov.1988, |                                          |           | paper2738.  |           |               |       |         |     |     |     |     |     |     |     |
| [34] Y. Neuvo,       | D.                                       | Cheng-Yu, | and         | S. Mitra, | “Interpolated |       | finite  |     |     |     |     |     |     |     |
impulseresponsefilters,”IEEETrans.Acoust.SpeechSignal
| Process., | vol.32, | no.3, | pp.563–570, |     | Jun.1984, |     | https: |     |     |     |     |     |     |     |
| --------- | ------- | ----- | ----------- | --- | --------- | --- | ------ | --- | --- | --- | --- | --- | --- | --- |
//doi.org/10.1109/TASSP.1984.1164348.
| [35] Valeria                       | Bruschi, | Stefano      | Nobili,        |            | Alessandro         | Terenzi, | and     |     |     |     |     |     |     |     |
| ---------------------------------- | -------- | ------------ | -------------- | ---------- | ------------------ | -------- | ------- | --- | --- | --- | --- | --- | --- | --- |
| Stefania                           | Cecchi,  | “A           | low-complexity |            | linear-phase       |          | graphic |     |     |     |     |     |     |     |
| audioequalizerbasedonifirfilters,” |          |              |                |            | IEEESignalProcess. |          |         |     |     |     |     |     |     |     |
| Lett.,                             | vol. 28, | pp. 429–433, |                | Feb. 2021, | https://doi.       |          |         |     |     |     |     |     |     |     |
org/10.1109/LSP.2021.3057228.
| [36] A. V.     | Oppenheim            | and                                     | R. W. | Schafer, | Discrete-Time |     | Sig- |     |     |     |     |     |     |     |
| -------------- | -------------------- | --------------------------------------- | ----- | -------- | ------------- | --- | ---- | --- | --- | --- | --- | --- | --- | --- |
| nalProcessing, |                      | Prentice-Hall,Inc.,UpperSaddleRiver,NJ, |       |          |               |     |      |     |     |     |     |     |     |     |
| 1999,          | Chapter7,pp.465-478. |                                         |       |          |               |     |      |     |     |     |     |     |     |     |
DAFx.8
| <   |     |     |     |     |     |     | 466 |     |     |     |     |     |     | >   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
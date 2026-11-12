sensors
Article
Mapping Urban Environmental Noise
Using Smartphones
JinboZuo,HaoXia*,ShuoLiuandYanyouQiao
TheInstituteofRemoteSensingandDigitalEarth,No.20DatunRoad,ChaoyangDistrict,Beijing100101,China;
zuojb@radi.ac.cn(J.Z.);liushuo@radi.ac.cn(S.L.);y56yqiao@irsa.ac.cn(Y.Q.)
* Correspondence:xiahao@radi.ac.cn;Tel.:+86-10-6486-2913
AcademicEditor:YuWang
Received:27June2016;Accepted:8October2016;Published:13October2016
Abstract: Noise mapping is an effective method of visualizing and accessing noise pollution.
In this paper, a noise-mapping method based on smartphones to effectively and easily measure
environmentalnoiseisproposed. Byusingthismethod,anoisemapofanentireareacanbecreated
usinglimitedmeasurementdata.Toachievethemeasurementwithcertainprecision,asetofmethods
wasdesignedtocalibratethesmartphones. Measuringnoisewithmobilephonesisdifferentfrom
the traditional static observations. The users may be moving at any time. Therefore, a method
of attaching an additional microphone with a windscreen is proposed to reduce the wind effect.
However, coveringanentireareaisimpossible. Therefore, aninterpolationmethodisneededto
achievefullcoverageofthearea. Toreducetheinfluenceofspatialheterogeneityandimprovethe
precisionofnoisemapping,aregion-basednoise-mappingmethodisproposedinthispaper,which
isbasedonthedistributionofnoiseindifferentregiontypestaggedbyvolunteers,tointerpolate
andcombinethemtocreateanoisemap. Tovalidatetheeffectofthemethod,acomparisonofthe
interpolationresultswasmadetoanalyseourmethodandtheordinaryKrigingmethod. Theresult
showsthatourmethodismoreaccurateinreflectingthelocaldistributionofnoiseandhasbetter
interpolationprecision.Webelievethattheproposednoise-mappingmethodisafeasibleandlow-cost
noise-mappingsolution.
Keywords: noisemap;smartphone;participatorysensing;spatialinterpolation
1. Introduction
With the development of society and economy, noise pollution has become a new challenge
forsustainabledevelopmentinurbanareas. In[1],theEuropeanEnvironmentAgencystatedthat
“noise pollution is a major environmental health problem in Europe. Environmental noise causes
atleast1000casesofprematuredeathinEuropeeachyear; over900,000casesofhypertensionare
caused by environmental noise each year”. Estimates have shown that approximately 20 million
adultscomplainaboutenvironmentalnoise,morethan8millionpeoplesuffersleepdisturbancesfrom
environmentalnoise,and43,000casesofhospitaladmissionsarecausedbynoisepollutioneachyear
inEurope[1]. Approximately15%oftheU.S.populationaged20–69(26millionpeople)mayhave
sufferedfromnoise-inducedpermanentthresholdshiftcausedbyexcessiveexposuretoworkplaceor
leisurenoise[2]. Thisproblemisalsopressingindevelopingcountries[3].
Noisemonitoringwasusuallycarriedoutincertainregionsinthepast,anditisusuallydifficult
tocompletelyandaccuratelyreflecttheurbannoisepollutioninalargearea.Noisemappingisauseful
andeffectiveassessmentmethod,whichcanbecombinedwithacoustics,geographicalinformation
system (GIS), and computational modelling to visualise the different regional exposure to noise
pollution,statisticsofaffectedpopulation,anddifferentnoisesourcecontributionanalysis. Noisemap
Sensors2016,16,1692;doi:10.3390/s16101692 www.mdpi.com/journal/sensors

Sensors2016,16,1692 2of18
isausefultoolincreatingagovernmentnoise-controlplan. Italsoprovidesanavailablemethodfor
thepublictoidentifytheenvironmentalnoiselevelaroundthem.
Owingtotheadvantagesofnoisemaps, theyhaveattractedwidespreadattentionnowadays
and have been widely applied in many countries and regions [4–7]. In [8], the European Noise
Directiverequiresallmemberstatestoprepareandpublishnoisemapsandnoisemanagementaction
plansforlargecitieseveryfiveyears,andthenoisemapsshouldbeincorporatedintheEuropean
EnvironmentAgency’sReportNetsystem. In[9],theauthorsinferredafine-grainednoise-mapping
situation(consistingofanoisepollutionindicatorandacompositionofnoises)atdifferenttimesof
adayforeachregioninNewYorkCityusing311complaintdatatogetherwithsocialmedia,road
networkdata,andpointsofinterests. Someotheravailablenoise-mappingmethodsandtechniques
basedonsocialmediadatahavebeenproposed,suchastheintegrationofsoundscapewithnoise
mappingin[10]andthestudyontherelationshipsamongpicturetags,emotions,andsoundscapes
in[11].
For these types of noise maps, three major data sources are available: (1) simulations based
on inputs such as traffic-flow data, road or rail type; and vehicle type and (2) noise monitoring
stations; (3) social media data. For the first, a simulation approach is extremely useful because it
allowsassessmentofbackgroundnoiseintheabsenceofphysicaldatawithadequategranularity[12].
However, thismethodsuffersfromsomeproblems. Themostimportantoftheseproblemsisthat
the types of data sources are limited. This approach does not consider incidental sounds such as
thosegeneratedbytrafficjams,constructionworks,assembledcrowd,andotherunexpectedsounds.
As widely known, these sounds are also a disturbance to local dwellers. On the other hand, the
collectionofsuchinputdataisveryexpensive,whichcauseslongerupdateintervalsofthesemaps[13].
Inaddition,becausethepropagationofsoundisgreatlyinfluencedbybuildingsandpublicfacilities,
thesesimulationapproacheshavedifficultyindepictingthenoiselevelofcornersinurbanareas.
Forthesecond,althoughnoisemonitoringstationscanachieveahighlevelofprecision,thenoise
neverthelessdramaticallyvarieswiththespatialvariation. Deployingmillionsofthesestationsto
measurefinergrainedenvironmentalnoiseineverynookandcrannyofcitiesisimpossible[9]. Maybe
low-costwirelesssensingunitshavebeenalreadyprovenfeasiblefornoiseandotherenvironmental
data,suchasin[14,15],buttheproblemisthefeasibilityintechnologydoesnotmeanthatwecan
acquire the data from these sensors easily. For example: in Beijing, with more than 20 million of
population,anddevelopedadvancedtransportsystem,itisnotveryconvenienttolearnsoundlevelof
environmentalnoisefrompublicchannel. Wearealsonotsurewhetherthiskindofsensingnetworkis
established. Forthethird,itisnotamethodtomonitornoiserelyingdirectlyonmeasurementsand
nottheoriginalintentionofourstudy.
Thelackofconvenientandlow-costnoise-mappingsolutionswithcertainprecisionisalwaysa
problem. Nowadays,smartphonesexperiencehighadoptionrates. Smartphonesarepersonaldevices
carriedalldaylong,whichareequippedwithdifferentsensorsandconnectedtotheInternet. Theyare
aperfectplatformforsensingtheenvironment[16]. Someresearchersaresearchingforanewsolution
tocreatenoisemapsusingsmartphonesinanattempttoreducethecostofnoisemappingandto
improvetheirrefreshfrequency.
NoiseTubegeneratesonemappermeasurementtrackusingcoloureddotsforeachindividual
measurement [12,17]. NoiseTube focuses on the culture of democracy and citizen science, where
peoplecanmeasurethenoisetheyareexposedtointheirdailyenvironment. Inthismanner,theycan
createcollectivenoisemapsbysharingcitizenmeasurementsandpersonalannotations. Ear-Phone
investigatestheuseofdifferentinterpolationandregularisationmethodstoaddressthefundamental
problemofrecoveringanoisemapfromincompleteandrandomsamplesobtainedbycrowdsourcing
datacollection[13,18]. Ear-Phoneleveragescontext-awaresensingtodetectthestatusandplacement
ofthephonetodetectwhetherthephoneisusedforcommunication,whetherthecarrieristalkingwith
othersorpassingthroughaconversationarea,orwhetherthephoneisheldinthehand. NoiseMapis
anapplicationthatgathersdataonloudnessandtransfersthemtoda_sense.da_senseisanopenurban

Sensors2016,16,1692 3of18
sensingplatformthatallowsuserstoaccessandcontroltheirdataandtogeneratereal-timenoise
mapsanddatagraphs[19]. In[20],aspatialdatainfrastructurebasedontheopen-sourcetoolsnamed
OnoM@p (Institute for Research on Urban Sciences and Techniques, Nantes, France) is presented,
whichreliesonparticipatorysmartphone-basednoisemeasurements. Itaimstoofferaframeworkfor
capitalizingoncrowdnoisedatarecordedbyinexperiencedindividuals. In[21],thestudyoffersa
methodofestimatingnoiselevelsandblackcarbonbythecombinationofmobileandfixed-station
measurements. However,althoughthesestudiesprovideavailablemethodstomapnoise,threemajor
limitationsremain.
1. Thecalibrationofsmartphonesusedtomeasurenoiserequiressomeoperations,whichmaylead
toahighvolumeofworkloadwhenthenumberofphonesincreases.
2. Inthesestudies,thevolunteersshouldalwayscarrythephonesintheirhandsbecauseputting
thephonesintheirtrouserpockets,bags,orbeltpouchesmayresultinlargeerrors,whichwould
beineffectiveinlong-termdatacollection.
3. Because infinitely increasing the spatial density of measurements is impossible, a suitable
interpolation method is needed to map noise. Owing to the spatial heterogeneity of noise
distribution,thespatialinterpolationmethodmaybeinfluencedbythisheterogeneity. However,
noneoftheseworkstriedtosolvethisinfluence.
To address the abovementioned problems, the current paper proposed a low-cost and easy
noise-mappingmethodusingsmartphoneswithadditionalmicrophones. Thegoalsofthepresent
studyareasfollows: aconvenientcalibrationmethodusingsmartphonestomeasureenvironmental
noise,feasibilityofusingadditionalmicrophoneattachedtothephonefornoisemeasurement,anda
suitablespatialinterpolationmethod.
Inthispaperweproposedthefollowingsolutions: firstly,inordertoachievecertainprecisionof
thenoisemeasurementbysmartphones,wedesignedasetofmethodstocalibratethesmartphones
and the calibration process can be done by the software. Secondly, we confirmed the necessity of
attachinganadditionalmicrophonewithawindscreentoreducetheeffectofwind;asaresult,wecan
releaseourhandsandcanputthemobilephonesinourpocketwhichwillbringgreatconveniences
totheusers. Thirdly,weproposedtheregion-basednoise-mappingmethod,whichisbasedonthe
distributionofnoiseindifferentregiontypestaggedbyvolunteers,tointerpolateandcombinethemto
reducetheinfluenceofspatialheterogeneityandimprovetheprecisionofnoisemapping.Weanalyzed
theinterpolationresultsofourmethodandtheordinaryKriginginterpolationmethod. Theresult
showsthatourmethodismoreaccurateinreflectingthelocaldistributionofnoiseandconsequently
hasabetterinterpolationprecision.
The remainder of this paper is organised as follows: in Section 2, we detail the theory and
techniquesusedintheproposedmethod. InSection3, weoutlinetheexperimentalprocessusing
theproposedmethod. WedescribeandanalysetheresultsinSection4. InSection5,wepresentour
concludingremarks.
2. Methods
Thissectiondescribesthemethodsofmappingenvironmentalnoiseusingmobilephones.
2.1. Skeleton
Afterthecalibrationofthesmartphonesneededinthetask,mappingtheenvironmentalnoise
canbedoneusingournoise-mappingprototypesystemwhoseskeletonisshowninFigure1. Using
mobilephones,ourapplicationcollectsnoisedatathroughamicrophoneandobtainsthelocationof
thecollectionusingGlobalPositioningSystem. Then,therawdataareprocessedandincorporated
intonoiselogrecordswithatimestamp. TherecordsaretransmittedthroughwirelessInternettoour
server. Theserverdrawsthenoisemapsusingthenoiseandlocationdatafromthephones,together
withthelocallystoredspatialdata.

SSenensosorsr s22001166, ,1166, ,11669922 44 oof f1188
Figure1.Skeletonofthenoise-mappingprototypesystem.
Figure 1. Skeleton of the noise-mapping prototype system.
2.2. MeasuringNoise
2.2. Measuring Noise
To measure noise using mobile phones, the equipment needs to meet the following
requTiroe mmeenatssu[r1e2 ,n13o]i:se (1u)siAng-w emigohbtiilne g;ph(o2n)ecso, mthpeu taetqiounipmofenLt neoevdesr taor bimtreaerty tthime efoilnlotewrvinagls ;
Aeq
r(e3q)uciarelimbreanttiso n[;12(4,1)3p]:r o(c1e) dAu-rweeoinghhtoinwg;t o(2c)a rcroymtphuetpahtioonne so;f aLnAdeq (o5v)ewr inadrbpitrroatreyc ttiiomne. Rinetqeurviraelms; e(n3t)s
c(a1l)ibarnadtio(2n); c(4o)r rpersopcoedndurteo otnh ehoinwte tron acatirornya tlhset apnhdoanreds;f aonrds o(5u)n wdilnedv eplrmoteetcetriosn(S. RLMeqsu)ir[2em2].enWtse (p1r)e asnedn t
(2o)u rcoprrroepspoosendd rtaop itdhec ailnibterrantiaotniomnaelt hstoadndtoarsdat ifsofry sroequunidr elmeveenlt m(3e)tienrst h(eSLnMexst)s e[2c2ti]o. nWs.eA pnreasdednitt ioonuar l
pmroipcroospehdo rnaepiisdu csaeldibtroastiaotnis fmyerethqoudir etmo esnattsis(f4y) raenqdu(i5re).ment (3) in the next sections. An additional
microphone is used to satisfy requirements (4) and (5).
2.2.1. AdditionalMicrophone
2.2.1. Additional Microphone
Althoughadditionalmicrophoneswillslightlyincreasethecostofsmartphones,weusethemfor
threAerltehaosoungsh: additional microphones will slightly increase the cost of smartphones, we use them
for three reasons:
(1) Benefitforlong-termdatacollection
(1) Benefit for long-term data collection
Research conducted by Nokia [23] suggests that people tend to carry their mobile phones in
theirRtersoeuasrecrh pcoocnkdeutsc,tbedag bsy,b Nelotkpioau [c2h3e]s s,uogrgheasntsd st.hEatx ppeecotpinleg ttehnadt vtool ucanrtreye rtshweiirl lmalowbailyes pcharornyetsh ieni r
thpehior ntreosuinsetrh peoirchkaetnsd, sbawgist,h btehlet pmoiuccrohpesh,o onre hsacnodrrse. cEtlxyppecotsinitgio tnheadt vtoolsuanmtepelresa wmiblli eanlwtnayosis ceawrroyu tlhdeibre
puhnorneeasl iisnti cth[e1i3r ]h.aInndtsh we cituhr rthene tmsticurdoyp,hwoneeuss ceoarrdedcittliyo npaolsimtioicnreodp htoo nsaems wpliet hamexbtieennsti onnoiwsei nwdosuclrde ebnes ,
ucnorredasl,isatincd [1c3li]p. sI.n Tthhee mcuircrreonpth sotnuedyc,a nwbe eupsein andeddittioonthale mclioctrhoipnhgoonfetsh weivtho luexntteenesriso.nI nwtihnidssmcraenennse,r ,
ctohredsv,o alnudn tceleiprss.w Tohuel dmbiceroapbhleotnoec caarnry bteh peimnnoebdi lteop thhoen celostihninthge oirf ttrhoeu vsoerlupnotcekerest.s ,Inb athgsis, bmealtnpnoeur,c thhees ,
voorluhnatnederss wwiothuoldu tbaef afebcltei ntog ctahrerym tehaes muroebmileen ptsh.onTehse imn tehaesiurr termouesnetr wpoilclkneotst, ablasogsb, ebealftf epcotuedchbeys, tohre
hmanodvse mweinthtsouoft tahfefevcotilnugn tetheres .measurements. The measurement will not also be affected by the
movements of the volunteers.
(2) Reducingtheeffectofenvironmentalwind
(2) Reducing the effect of environmental wind
Noisemeasurementshouldbetakenonadaywithcalmtogentlebreezeandwithoutrain. Some
condNitoioisnes mtheaatsmuruesmtebneta svhooidueldd abree tsatkroenng own ian dd(agye nweirtahl lcya,lwme tdoo gneonttplee rbfroeremzem aenads uwreimtheonutts riafitnh.e
Swomined ciosnsdtriotinognesr ththaat nm5umst /bse) aavnodiddeudr ainreg srtarionn[g2 4w].inWd i(ngdesncerreaelnlys, nweee ddoto nboet pinesrftoalrlmed moenatshueredmevenictess
ifw thheen witinisd wisi nsdtryo.nTghere tahdadni t5io mna/ls)m aincrdo pdhuorinneg craaninh a[2v4e].a Wwiinnddssccrreeeenns, nbueetdth teo bbuei litn-isntamlleicdr oopnh tohnee
dceavninceost .wAhneand diti tiiso nwalinmdiycr. oTphheo naedwdiittihonaawl imndicsrcorpeehnoncaen cgarne ahtlayvree dau wceinthdescwreinend, ebffuetc tt.he built-in
microphone cannot. An additional microphone with a windscreen can greatly reduce the wind
(3) Facilitatingmeasurementswhilemoving
effect.
Intraditionalnoisemeasurements,theSLMisfixedonabracket. However,forenvironmental
(3) Facilitating measurements while moving
noisemeasurementsusingsmartphonesinparticipatorysensing[12],thevolunteerscannotstayat
thesInam treadpiltaicoenafol rnaoilsoen mgetiamsueraenmdenwtisl,l tnhoet SbLeMca irsr yfiixnegda obnr aac bkreatcwkeitth. Hthoewmevtoeri,n fsotra lelnthveiroSnLmMesnatnald
nootihseer meqeuasipumreemnte.nStos museinvgo lusmntaeretrpshwoonuesld inb epianrtteicreipstaetdoriyn sceonllseicntgin [g1d2]a,t athwe hveonluwnatelkeirnsg caonrnevoet nstraiyd iantg
thaeb sicaymclee .pTlahcee wfoirn ad lcoanugs etidmbey atnhde sweialcl tnivoitt ibees cwairlrlyaifnfgec at tbhreacmkeeta swuirtehm thenemts otof einnsvtiarlol nthmee SnLtaMlsso aunndd
oltehveerl .eWqueibpemlieenvte. tShoamtaen vaodludnittieoenrasl wmoicurlodp hboen ienwteritehstaedw iinnd csocrlleeecntincagn dmatina imwhiseent hwesaelkeifnfgec tosr. even
riding a bicycle. The wind caused by these activities will affect the measurements of environmental

Sensors2016,16,1692 5of18
2.2.2. A-WeightedEquivalentContinuousSoundPressureLevel
NoiselevelismeasuredintermsoftheA-weightedequivalentcontinuoussoundlevelorL .
AeqT
A-weightingiscommonlyusedfrequencyweightingforenvironmentnoisemeasurementbecauseit
canreflecttheloudnessperceivedbyahumanbeing[22,25].
Thesoundpressureleveliscapturedbyamicrophoneasaninducedvoltage. Tomeasurenoise
using a smartphone, firstly, we need to obtain induced voltage v(t) from the microphone sensors
duringtimeT.Then,v(t)shouldbeprocessedusinganA-weighteddigitalfilter. Afterfiltering,we
canacquiretheinducedvoltageusingA-weightedv (t). TheA-weightingfilterisstandardisedinthe
A
InternationalElectrotechnicalCommission(IEC)document[22]. TheA-weightedequivalentsound
levelisexpressedasfollows:
|     |     | (cid:40)(cid:20) |             | (cid:41) |     |     |
| --- | --- | ---------------- | ----------- | -------- | --- | --- |
|     |     | (cid:90)         | (cid:21)1/2 |          |     |     |
T
|     | L =20lg | (1/T) | v2 (t)dt | /v  |     | (1) |
| --- | ------- | ----- | -------- | --- | --- | --- |
|     | AeqT    |       | A        | 0   |     |     |
0
wherev Thestandardreferencepressureis20µPa[22].
| 0 isthereferenceinducedvoltage. |     |     |     |     | However, |     |
| ------------------------------- | --- | --- | --- | --- | -------- | --- |
fordifferentsmartphones,wedonotknowwhatinputvoltagecorrespondstothisreferencepressure,
i.e.,whatv valuecorrespondsto20µPa. Becausev isafixedvalue,wecanexpressL asfollows:
| 0   |     |          | 0                 |     | AeqT |     |
| --- | --- | -------- | ----------------- | --- | ---- | --- |
|     |     | (cid:20) | (cid:90) (cid:21) |     |      |     |
T
|     | L =10lg | (1/T) | v2 (t)dt | +C. |     | (2) |
| --- | ------- | ----- | -------- | --- | --- | --- |
|     | AeqT    |       | A        |     |     |     |
0
CalibrationconstantCcanbedeterminedfromexperiments,asdiscussedinthenextsection.
2.2.3. Calibration
According to Section 2.2.2, we must empirically determine the value of C in Equation (2).
To simplify the problem, a linear model between the induced voltage from the phones and the
measurementfromtheSLMisassumed. Welet:
|     |         | (cid:20) | (cid:21)   |     |     |     |
| --- | ------- | -------- | ---------- | --- | --- | --- |
|     |         |          | (cid:90) T |     |     |     |
|     | V =10lg | (1/T)    | v2 (t)dt   |     |     | (3) |
|     | p       |          | A          |     |     |     |
0
Then,wecanestablishtherelationshipbetweenV (themeasurementfromthephone)andV
|     |     |     | p   |     |     | s   |
| --- | --- | --- | --- | --- | --- | --- |
(themeasurementfromtheSLM)as:
|     |     | V =V +C+ε |     |     |     | (4) |
| --- | --- | --------- | --- | --- | --- | --- |
s p
Thus,thevalueofCcanbecalculated.
whereεistheerror.
AcommonmethodforobtainingCisbyrecordingthephoneresponsestodifferentsoundlevels.
Along with the measurements by an SLM or other devices, linear interpolation is used to
determine C [12]. However, the measurement process under different sound levels must reduce
theinfluenceofthebackgroundnoise. Withtheincreaseinthenumberofphones,thisprocesswould
incurahighvolumeofworkload. Forparticipatorysensing,convenienceismoreimportantifthe
requiredprecisioncanbesatisfied. Thus,wedesignamoreconvenientmethodtocalibratethemobile
phonesfornoisemeasurementinwhichthecalibrationprocesscanbeprogrammed.
Similartoarelatedwork[13],weusethefreelyavailableAudacity[26]softwaretoconstructa
calibrationtone. Thistoneismadeupoftwo4-min1-kHzsinusoidaltonesandsilencethatspansfor
2min(Weuseapuretoneforcalibration,sincestandardcalibrationprocessusesonesinglefrequency,
namely 1 kHz). The amplitude scale of these sinusoidal tones is set from 0 to 0.6 for two reasons.
On the one hand, we can achieve the offsets under different sound pressure levels and obtain the
fullresponseofthephonesatdifferentsoundlevels. Ontheotherhand,whentheresponsedataare
convertedtothetimeseries-soundlevelformat,thedatawillbedisplayedinspecialshapes,including
archedandinflectionpoints. Alloftheseobviousfeatureswillgreatlyhelpusandourprogramsmake
comparisonoftheSLMandthemobilephoneshapes.

Sensors2016,16,1692 6of18
Tofacilitatethecalibrationprocess,weneedaquietroomtoperformourcalibration. Theother
specialequipmentisCEMDT-8852,anSLMthatconformstotheIEC61672-1Class2standard,which
servesasacalibrationstandard. Severalmobilephonesareusedtoverifythecalibrationmethods:
an HTC butterfly J (HTC), a Samsung Galaxy I9300 S3 (S3), two Unistrong J4 (J4-1, J4-2), and an
iPhone6plus(iPhone6p). HTCandS3areequippedwithadditionalmicrophones. Thecalibration
stepsaredescribedasfollows:
Step1: Datarecording. Inaquietroom,whilethecalibrationtoneisbeingplayed,thesoundpressure
level[expressedinA-weighteddecibel(dBA)unit]isrecordedbytheSLMandmobilephones.
Afterthisprocesshasstarted,theoperatorleavestheroomtopreventhisactionsorbreathing
frombeingrecorded. Figure2ashowsthatthesegmentswithpeaksaresinusoidaltones,and
thedurationbetweenthemrepresentssilence. Thedataarerecordedevery2s.
Step2: Resampling. Because of the limitation of the SLM, we cannot substantially increase the
samplingrate. Asmentionedinthepreviousstep,2sisselected. Toimprovethealignment
precision in the follow-up step, as shown in Figure 2b, we employ 20 times the rate
of the original signal for resampling by considering the balance between precision and
computingload.
Step3: Time-seriesalignment. Thecalibrationofthephonesrequiresmanualpressingofthebuttonsof
theSLMorthemobilesoftwaretostartthedatarecording.Simultaneouslypressingthebuttons
ofthedifferentdevicesrequiresdifferentprocesses,especiallyforproductssuchastheCEM
DT-8852SLM.Anunalignedtimeserieswillreducecalibrationprecision;thus,weneedtoalign
thesedatausingalgorithms. First,thecorrelationcoefficientsateachindentationbetweenthe
resampledtimeseriesfromtheSLMandthatfromthephonesarecalculated. Then,wechoose
theindentationwiththemaximumcorrelationcoefficientasastandardtotranslatethetime
seriesofthephones. Inthismanner,alignedtimeseriesareobtained,asshowninFigure2c.
Step4: Calculatingoffsets. Thedurationofthecalibrationtoneis10min. Toobtainacompletetime
series,weneedtostarttherecordingbeforethetoneisplayedandstoptherecordingfora
periodoftimeaftercompletion. ThepressingofthebuttonsoftheSLMormobilesoftware
bytheoperatorandhisotheractionswillberecordedduringthetimethetoneisnotplayed.
Toremovethenoisefromtheseactions,weintroduceaslidingtimewindow. Thelengthof
thewindowisthesameasthatofthetone(10min). Aftercalculatingthemeansandstandard
deviations of the difference between the measurements of the sound pressure level by the
SLMandthephonesinthetimewindowineachindentation,wechoosethemeanwiththe
minimumstandarddeviationasoffsetCtocompensatethemeasurementsofeachindividual
phone. Throughthisprocess,wecanremovethenoisecausedbytheoperatorandcancalibrate
thephones. Thetime-seriescompensatedoffsetisshowninFigure2d.
Inthesesteps, theoperatoronlyplaysthetoneandrecordsthedata. Theotherprocessesare
performed by the program. In this manner, we can significantly reduce the calibration workload.
Anotheradvantageisthatthesuitabilityofthephonetoperformsoundpressurelevelmeasurement
can be evaluated by analysing the correlation between the time series in the SLM and the phones.
Apparently, phones with low correlation coefficient are not suitable for sound pressure level
measurement. TheresultsoftheexperimentarepresentedinSection4.
Figure2showsthatlargedifferencesoccurbetweenthemeasurementsfromsmartphoneswithout
calibrationandtheSLMunderthesameenvironment. Thesedifferencescanbeobservednotonly
betweenthesmartphonesandSLMbutalsoamongsmartphonesofdifferentbrandsanddifferent
phoneages. Weobservethatevenforthesamephonemodel,thecalibrationoffsetvariesfromphone
tophone. Otherresearchworkshavereachedsimilarconclusions[13,27]. Therefore,forenvironmental
noisemeasurementsusingsmartphones,weneedtoindividuallycalibrateeachdevice.

Sensors 2016, 16, 1692 7 of 18
Sensors2016,16,1692 7of18
environmental noise measurements using smartphones, we need to individually calibrate each
device.
(a) (b)
(c) (d)
Figure 2. Calibration steps. (a) Raw time series from sound pressure level data from the SLM and
Figure2. Calibrationsteps. (a)RawtimeseriesfromsoundpressureleveldatafromtheSLMand
phones; (b) Time series after resampling; (c) Time series after alignment; (d) Time series after
phones;(b)Timeseriesafterresampling;(c)Timeseriesafteralignment;(d)Timeseriesaftercalibration.
calibration.
2.3. NoiseMapping
2.3. Noise Mapping
After the phone calibration, we can use these phones to measure the sound level as well as
After the phone calibration, we can use these phones to measure the sound level as well as the
thelocationandtimestamp. Then,wecancombinethesedatatogeneratethenoisemap. Because
location and timestamp. Then, we can combine these data to generate the noise map. Because noise
noisemmapasp saraer ecocnosntrsutcrutecdt eudsiunsgi nGgISG tIoS itnoteignrtaetger athtee tmheeamsuereamsuernetms wenitths wthiet hspthateiasl piantfioarlminatfioornm aantdio n
andiinnfifinniitteellyy iinnccrreeaassiningg tthhee ssppaatitaial lddeennsistiyt yoof fththee mmeeaasusurermemenetns tsis isimimpopsossibslieb,l ew,ew neeneede da asusiutaibtaleb le
interpinotelartpioolnatmioent hmoedth.od.
TobleTro’bslfierr’sst lfairwst olfagwe oogf rgapeohgyrasptahtyes stthaatetsa ltlhaattt raibllu atettrviabluutees voanluaegs eoong raa pgheiocgsruarpfhaicce saurerfraeclea taerde to
onearneolattheedr .toN oenvee rathneoltehsesr,. cNloesveerrtvhaellueesss, acrleosmero vrealsuteros nagrely mreolraet esdtrothnagnlyt hreeladtiesdta tnhtaonn tehse [d2i8s]t.aHnto owneevs er,
spati[a2l8o].b Hjeocwtteyvpere,s sspuactihala osbbjeucitl dtyipnegss s,urocha dass ,baunilddiontghse, rrooabdjesc, tasnadr oetpherer soebnjetcitns aarne aprreeasetnhta itnr eanq uairreeas a
that requires a noise map. The spatial distribution of environmental noise is very complex, and
noisemap. Thespatialdistributionofenvironmentalnoiseisverycomplex,andspatialheterogeneity
spatial heterogeneity exists in environmental noise data [29].
existsinenvironmentalnoisedata[29].
Several interpolation methods are available, such as the linear, nearest neighbour, and Kriging
Severalinterpolationmethodsareavailable,suchasthelinear,nearestneighbour,andKriging
methods [30]; however, these interpolation methods do not take into account the influence of spatial
methods[30];however,theseinterpolationmethodsdonottakeintoaccounttheinfluenceofspatial
heterogeneity on the interpolation results. A large difference in the value of the property between
heterogeneityontheinterpolationresults. Alargedifferenceinthevalueofthepropertybetween
different sub-regions may exist; thus, the property values of two adjacent points are also different.
differentsub-regionsmayexist; thus,thepropertyvaluesoftwoadjacentpointsarealsodifferent.
Therefore, we design a noise-mapping method called region-based noise-mapping method
Therefore,wedesignanoise-mappingmethodcalledregion-basednoise-mappingmethod(RNMM),
(RNMM), which is based on the noise distribution of different regional types tagged by volunteers to
whicmhoisdebla, siendteorpnotlhatee,n oainsde dciosmtrbibinuet iothnesoef dnioffiseer ednitsrtreigbiuotnioanlst ytpo esretdaugcgee dthbey invfoluluenntceee rosf tospmatoiadl el,
interphoetleartoeg,eanneditcyo amndbi inmepthroevsee tnhoei sneoidsies-tmriabpuptiinogn sptroecriesdiounc, east hsehoinwflnu ienn Fciegoufres p3.a tialheterogeneityand
improvethenoise-mappingprecision,asshowninFigure3.
Step 1: Create fishnet (grids) according to the extent of the experimental field. As is shown in
Step1: CreateFfiisghunree t4(ag. rids)accordingtotheextentoftheexperimentalfield. AsisshowninFigure4a.
Step2S:tepC 2o:m puCtoemtphuetne ethaere nsetamreesat smueraesmureenmtefnotr feoar cehacghr igdrida nadndc lcalassssififyy tthhee ggrriidd iinnttoo ddififfefreernetn ttytpyeps es
according to the label of the measurement (tagged by the volunteers). As is shown in
accordingtothelabelofthemeasurement(taggedbythevolunteers). AsisshowninFigure4b.
Figure 4b.
Step3: Establishthespatialinterpolationmodelsofthenoisefordifferentregiontypes. Asisshown
Step 3: Establish the spatial interpolation models of the noise for different region types. As is
inFigure4c.
shown in Figure 4c.
Step4: Predictthesoundlevelforthedifferentregiontypesbasedonthemodelsestablishedfromthe
laststepandcreatethenoisemapsforeachtype.
Step5: Combinethenoisemapsofthedifferentregiontypestogeneratethenoisemapofthewhole
experimentalfield. AsisshowninFigure4d.

SSeennssoorrss 2 2001166, ,1 166, ,1 1669922 88 o of f1 188
SStteepp 4 4: : PPrreeddiicctt t thhee s soouunndd l leevveell f foorr t thhee d diiffffeerreenntt r reeggiioonn t tyyppeess b baasseedd o onn t thhee m mooddeellss e essttaabblliisshheedd f frroomm
tthhee l laasstt s stteepp a anndd c crreeaattee t thhee n nooiissee m maappss f foorr e eaacchh t tyyppee. .
SStteepp 5 5: : CCoommbbiinnee tthhee nnooiissee mmaappss ooff tthhee ddiiffffeerreenntt rreeggiioonn ttyyppeess ttoo ggeenneerraattee tthhee nnooiissee mmaapp ooff tthhee
Sensorsw2w0h1h6o,ol1le6e, e 1e6xx9p2peerriimmeennttaall f fiieelldd. .A Ass i iss s shhoowwnn i inn F Fiigguurree 4 4dd. . 8of18
FFiigguuFrirege u3 3r. .eS S3tte.epSpstes i pnins c icnrrecearatetianintging ga a an nonoiosiisese em mmaaappp u uusssiininnggg tt hthheee mm meeaeasasusuruermreememnetennatnt a dannsdpd as stpipaaalttidaiaalt lda d.aattaa. .
((aa)) ((bb))
((cc)) ((dd))
FFiigguur Fre ie g 4 u4. r . e DD4 iai.aggD rra iaa mmgr mmam aat mticica s tsi k ckees t ktcch eht c o hoff o s fstte sep tpe s ps s oof of f RRR NNN MMM M MM. . . ( ((a aa) )) C CCr r ere aea tat etee t h tth ehe fie s ffi h sinshhe n tne wett i w twh itilth ahb l e allab sb; ee( l b sls; ) ; ( N(bbe )) a N rNe e set aarreesstt
mmeeaassmuurereaemsmuereennmtt eaannntdda n ssdpplsilptit l iitninitntoot o dddifiiffffefeerrreeennnttt rrereegggiiooinonnt y ttpyyeppse;es(s;c ;) ((cIcn)) t IeInrnptteoerlrapptoioolalnatftiooiornnd fifofofrer r dednifitfffteyerrpeeennst;t (tdtyy)ppPeerses; d; (i(dcdt)) a PnPrdreeddicictt
aanndd c ccooommmbbbiinnineee tt hthheeer re regegigoioinontny t ptyyepspe.ess. .
WWee fWfoolelllofoowwll o ttwhheet h cceooncnoccneecppetpt otofof f pppaaarrrttiticicciiipppaaatttooorrryyy s sesenensnsisniingngbg a bbsaeasdseeoddn ootnhn e tthchleae s csclilafiascssasitififioicncaatotifiootnhn e oorffe tgthihoeen rreteagggigiooennd tbtaayggggeedd
bbyy tthhtehe e vvvooolluluunnnttteeeeeerrrsss.. . TTThhheee v vvooolullununtnetteeereesrrscs a cncaaenna seeialayssimillyya mrmkatarhrkek rtthehgeei o rrneegtgyiioponen s ttyiynppteheses iminn e tathhseue r mmemeeaeasnsutu;rrtehemmusee,nnttht;e ; tsthehudusas,t ,a tthheessee
ddaattaa cc caaannn bb beeee e aeasaislsiyillyoy bo otbabtitnaaieindne.edd. .
OrdinaryKrigingwasusedforthespatialinterpolation. TheKrigingmethodisoneofthemost
OOrrddiinnaarryy K Krriiggiinngg w waass u usseedd f foorr t thhee s sppaattiiaall i inntteerrppoollaattiioonn. .T Thhee K Krriiggiinngg m meetthhoodd i iss o onnee o off t thhee m moosstt
widelyusedgeostatisticalinterpolationmethods. Somerelatedresearchactivitiesalsousethismethod
wwiiddeellyy uusseedd ggeeoossttaattiissttiiccaall iinntteerrppoollaattiioonn mmeetthhooddss. . SSoommee rreellaatteedd rreesseeaarrcchh aaccttiivviittiieess aallssoo uussee tthhiiss
innoisemapping[7,13]. OrdinaryKriging,oneoftheKrigingmethods,isadoptedinthepresentstudy
mmeetthhoodd iinn nnooiissee mmaappppiinngg [[77,1,133]]. . OOrrddiinnaarryy KKrriiggiinngg, , oonnee ooff tthhee KKrriiggiinngg mmeetthhooddss, , iiss aaddoopptteedd iinn tthhee
forspatialinterpolationofthenoisedatatomeasurethenoisedistributions. Kriginginterpolation
pprreesseenntt ssttuuddyy ffoorr ssppaattiiaall iinntteerrppoollaattiioonn ooff tthhee nnooiissee ddaattaa ttoo mmeeaassuurree tthhee nnooiissee ddiissttrriibbuuttiioonnss. . KKrriiggiinngg

Sensors2016,16,1692 9of18
Sensors 2016, 16, 1692 9 of 18
interpolation is applicable to regional variables with spatial correlation, and the spatial correlation is
is applicable to regional variables with spatial correlation, and the spatial correlation is used for
used for interpolation or extrapolation. It has a solid statistical theory basis and can estimate an error
interpolationorextrapolation. Ithasasolidstatisticaltheorybasisandcanestimateanerrorpointby
point by point, which is very suitable for the present study.
point,whichisverysuitableforthepresentstudy.
In summary, this method combines the subjective perception of the participants with the spatial
Insummary,thismethodcombinesthesubjectiveperceptionoftheparticipantswiththespatial
interpolation method. It can fully utilise the advantages of the volunteer perception of the
interpolationmethod.Itcanfullyutilisetheadvantagesofthevolunteerperceptionoftheenvironment,
environment, and no additional new sources of data are required. Thus, it is a very practical and
andnoadditionalnewsourcesofdataarerequired. Thus,itisaverypracticalandvaluablemethod.
valuable method. In the next sections, we will verify this method by experiment.
Inthenextsections,wewillverifythismethodbyexperiment.
33.. EExxppeerriimmeenntt
IInn tthhiiss sseeccttiioonn,, tthhee ddeevviicceess uusseedd inin ththe eexepxepreirmimenetn atraer leisltiesdte, da,nadn tdhet heexpeexrpimereimnteanl tparlopcreossceess saerse
aoruetoliunteldin. ed.
33..11.. DDeevviicceess aanndd SSooffttwwaarree
AAss mmeennttiioonneedd iinn SSeeccttiioonn 22..22..33,, wwee uussee tthhee IIEECC 6611667722--11 CCllaassss 22 SSLLMM CCEEMM DDTT--88885522 ((wwhhiicchh ccoossttss
aabboouutt $$117700)) aass tthhee ccaalliibbrraattiioonn ssttaannddaarrdd ssoouunndd lelevveelli nino ouurre exxppeerrimimeennt.t. SSeevveerraall mmoobbiillee pphhoonneess aarree
uusseedd iinn tthhee mmeeaassuurreemmeennttss:: aann HHTTCC bbuutttteerrflflyy JJ,, aa SSaammssuunngg GGaallaaxxyy II99330000 SS33,, ttwwoo UUnniissttrroonngg JJ44,, aanndd aann
iiPPhhoonnee 66p pluluss.. TThhee aaddddiittiioonnaall mmiiccrroopphhoonnee ttyyppee iiss BBYY--LLMM1100 ((FFiigguurree 55)),, wwhhiicchh iiss aanno ommnniiddiirreeccttiioonnaall
ccoonnddeennsseerrm micircoropphhoonnees psepceicailalylldy edsiegsnigendefdo rfoIPr hIoPnheo/nIeP/aIPda,dIP, oIdPotodu tcohu,cahn,d amndo smtAosntd Aroniddrdoeivdi cdeesv[i3c1e]s.
I[t3s1p].r iIctse pisrincoe mis onroe mthoarne $t2h0a.n0 0$.20.00.
FFiigguurree 55.. BBYY--LLMM1100 mmiiccrroopphhoonnee wwiitthh aal laappeellc clliippa anndda af fooaammw wiinnddssccrreeeenn..
We wrote the measurement software used by the smartphones by ourselves. Matlab [32] and
Wewrotethemeasurementsoftwareusedbythesmartphonesbyourselves. Matlab[32]and
ArcGIS [33] were used to draw the figures.
ArcGIS[33]wereusedtodrawthefigures.
33..22.. EExxppeerriimmeennttaall FFiieelldd
WWeec chhoooosseea anna apppprrooxximimaatetelyly5 50000m m× × 550000 mm ppaarrkk iinn BBeeiijjiinngg aass oouurr eexxppeerriimmeennttaall fifieelldd.. TThhee mmaaiinn
pplloottss aanndd rrooaaddd diissttrriibbuuttioionnssa arrees shhoowwnni ninF Figiguurree6 6a annddd deessccrirbibeedda assf ofolllolowwss::
TThhiiss fifieelldd iiss aa ttyyppiiccaall aarreeaa tthhaatt iinncclluuddeess aa bbuuiilltt--uupp rreeggiioonn aanndd aa rreellaattiivveellyy eemmppttyy rreeggiioonn aanndd iiss
ssuurrrroouunnddeedd bbyy rrooaaddss iinn tthhee ffoouurr ddiirreeccttiioonnss.. AAss tthhee mmaaiinn rrooaadd,, tthhee ssoouutthheerrnn ppaarrtt hhaass aa llaarrggee ttrraafffificc
flflooww,,a annddt htheeo oththererr oraodasdsh ahvaevere rlaetlaivtievlyellye slesstsr atfrfiacff.iWc. eWceh ocohsoeotshei sthairse aaraesa oausr oeuxrp eexripmeerinmtaelnfitaell dfifeoldr
tfworo trweaos ornesa.soFnirss.t ,Ftihrisst,fi tehldis cfoienltda incosnatlalitnhse athllr etehety tphirceael rteygpioicnasl wreegnioenesd w(wee nneeeedd (twoeu sneebeudi ltdoi nugsse,
sbquuialdreins,gasn, dsqruoaardess,t oanredp rreosaednst tthoi sretphrreeesetnytp tichaisl rtehgrieoen sty).pSiceacol nredg,itohnest)o. tSaelcsoiznedo, fththee tfiotealdl smizeee tosf otuhre
dfieemlda mndeetotsg oeunre draetmesaunfdfi ctoie gnetnmereaatseu sruemffiecnietsn.t measurements.

Sensors2016,16,1692 10of18
Sensors 2016, 16, 1692 10 of 18
Figure 6. Experimental field: an office park of the Chinese Academy of Sciences in Beijing (from
Figure6.Experimentalfield:anofficeparkoftheChineseAcademyofSciencesinBeijing(fromGoogleMap).
Google Map).
3.3. ExperimentalProcess
3.3. Experimental Process
Inthisstudy,theexperimentalprocesscanbemainlydividedintothreesteps:
In this study, the experimental process can be mainly divided into three steps:
Step1: Calibration. ThemethodmentionedinSection2.2.3isusedtocalibratethephonesand
Step 1: Calibration. The method mentioned in Section 2.2.3 is used to calibrate the phones and
determinetheprecision. Thispartoftheexperimentismainlycompletedintheroom. Inaddition,
determine the precision. This part of the experiment is mainly completed in the room. In addition,
theeffectivenessandnecessityofanadditionalmicrophone,togetherwiththemeasurementresults,
the effectiveness and necessity of an additional microphone, together with the measurement results,
arefurtherstudied.
are further studied.
Step2:Environmenttest.Thecalibrationworkisdoneintheroom.However,weneedtodetermine
Step 2: Environment test. The calibration work is done in the room. However, we need to
whether the calibrated equipment reliably works in outdoor environment. In traditional noise
determine whether the calibrated equipment reliably works in outdoor environment. In traditional
monitoring,thenoisemetershouldbeplacedinafixedposition. Incontrast,inusingsmartphones
noise monitoring, the noise meter should be placed in a fixed position. In contrast, in using
forenvironmentalmonitoring,thevolunteersneitherstayinoneplaceforalongtimenorcarrythe
smartphones for environmental monitoring, the volunteers neither stay in one place for a long time
equipmentsuchasthetripodfixedtothemobiles. Weneedtodeterminewhethertheeffectofwind
nor carry the equipment such as the tripod fixed to the mobiles. We need to determine whether the
resulting from the movements and other actions of the volunteers when they are walking fast or
effect of wind resulting from the movements and other actions of the volunteers when they are
ridingabikefordatacollectioncanbeneglected. Wealsoneedtodeterminewhethertheadditional
walking fast or riding a bike for data collection can be neglected. We also need to determine whether
microphonewithawindshieldcanovercometheeffectofwindonthemeasurement. Theseproblems
the additional microphone with a wind shield can overcome the effect of wind on the measurement.
areaddressedinthenextsections.
These problems are addressed in the next sections.
Todeterminetheeffectsofwindandmotionssuchaswalkingandbicycleridingonthenoise
To determine the effects of wind and motions such as walking and bicycle riding on the noise
measurement,weusetheSLM,HTCwithamicrophoneandS3withoutamicrophonetomeasurethe
measurement, we use the SLM, HTC with a microphone and S3 without a microphone to measure
environmentalnoiseundertheconditionsofwalkingandridingabicycle. Weperformacomparative
the environmental noise under the conditions of walking and riding a bicycle. We perform a
analysisofthedifferencebetweenthesetime-seriesmeasurements.
comparative analysis of the difference between these time-series measurements.
Step3: Measurementcampaign. Inclassicparticipatorysensing,themeasurementprocessmainly
Step 3: Measurement campaign. In classic participatory sensing, the measurement process mainly
reliesonthespontaneousbehaviouroftheparticipants,andthemeasurementpositionisdistributed
relies on the spontaneous behaviour of the participants, and the measurement position is distributed
withthebehaviouroftheparticipants[12,17]. Thisprocessinevitablyresultsinanunevendistribution
with the behaviour of the participants [12,17]. This process inevitably results in an uneven
ofmeasurementdatainlocationswheretheparticipantsfrequentlypassby,thusgeneratingmore
distribution of measurement data in locations where the participants frequently pass by, thus
measurements. Ontheotherhand,inlocationswheretheparticipantsseldompass,fewmeasurements
generating more measurements. On the other hand, in locations where the participants seldom pass,
areobtained, andsomelocationsevenhavenodata. Inthisstudy, wemainlyrelyontheplanned
few measurements are obtained, and some locations even have no data. In this study, we mainly rely
campaignmeasurementtocollectdata:twovolunteers(thevolunteersarecompensatedandsupported
on the planned campaign measurement to collect data: two volunteers (the volunteers are
byourresearchfund)performthemeasurementcampaigntwiceduringpeakhours(8:00–9:00)and
compensated and supported by our research fund) perform the measurement campaign twice
off-peakhours(21:00–22:00)onaworkdaytomeasurethesoundlevelscoveringthewholeareaof
during peak hours (8:00–9:00) and off-peak hours (21:00–22:00) on a work day to measure the sound
theofficeparkandsurroundingroads. Tocoverthewholeareaofthefield,thevolunteershaveto
levels covering the whole area of the office park and surrounding roads. To cover the whole area of
walkaroundthefieldfollowthesamerouteinmorningandnightinordertoensurecomparabilityof
the field, the volunteers have to walk around the field follow the same route in morning and night
in order to ensure comparability of the results. When they walk along the road, they choose the

Sensors2016,16,1692 11of18
theresults. Whentheywalkalongtheroad,theychoosetheroadtagbyusingoursoftware;when
theygothroughthebuildingarea,theyjustchoosethebuildingtag,andwhentheygothroughthe
squares,theyjustchoosethesquaretag. Volunteerscanpinthemicrophonetothecollarandcanput
thephoneinthepocket. Thesoftwarewilltagautomaticallyforeachcollectpointuntilthevolunteer
changeit,sothevolunteerwon’tbesotired. Duringtheacquisitionprocess,therecordfrequencyof
theA-weighteddatais2s. Simultaneously,thethreeregiontypes,namely,building,squareandroad,
aretagged.
4. ResultsandDiscussion
Thissectiondescribesthemeasurementanalysisandthenoise-mappingresults.
4.1. NoiseMeasurement
4.1.1. CalibrationandMeasurementPrecision
WeemploythemethodmentionedinSection2.2.3tocalibratethesmartphones. Toverifythe
calibrationresults,werecordandcomparethecorrespondingresultsfromtheSLMandthephones
underdifferentsoundlevels. TheresultsarelistedinTable1.
Table1.MeasurementsbySLMandsmartphonesatdifferentsoundlevels(dBA).
| SLM   | HTC   | S3    | J4-1  | J4-2  | iPhone6p |
| ----- | ----- | ----- | ----- | ----- | -------- |
| 53.75 | 54.31 | 54.60 | 54.34 | 56.38 | 56.10    |
| 63.20 | 63.57 | 63.89 | 63.68 | 65.82 | 65.54    |
| 67.56 | 67.87 | 68.22 | 68.02 | 70.12 | 69.87    |
| 70.24 | 70.61 | 70.98 | 70.80 | 72.95 | 72.64    |
| 72.41 | 72.59 | 73.00 | 72.83 | 74.99 | 74.67    |
| 74.00 | 74.15 | 74.58 | 74.43 | 76.58 | 75.89    |
| 76.99 | 77.01 | 77.51 | 77.36 | 79.50 | 77.61    |
| 80.65 | 80.57 | 81.05 | 80.88 | 83.01 | 79.69    |
HTCandS3areequippedwithadditionalmicrophones.
Table1indicatesthatinmostcases,themeasurementsbythesmartphonesandSLMarevery
close. Tomoreaccuratelydescribetheerrorsinmeasurements,Table2liststhemeasurementstatistics.
Table2.StatisticsofmeasurementsbytheSLMandsmartphones(dBA).
|         | HTC  | S3   | J4-1 | J4-2 | iPhone6p |
| ------- | ---- | ---- | ---- | ---- | -------- |
| Mean    | 0.24 | 0.63 | 0.44 | 2.57 | 1.65     |
| Maximum | 0.56 | 0.85 | 0.59 | 2.71 | 2.40     |
FromTable2,wecanmakethefollowingconclusions:
1. ThedifferencesinmeasurementsbetweenHTC,S3,J4-1,andSLMarerelativelysmall;eventhe
maximumdifferenceislessthan1dBA.Webelievethatthesephonesaresuitabletocarryout
measurementofenvironmentalnoise.
2. ThedifferencesinmeasurementsbetweenJ4-2,iPhone6p,andSLMareslightlylargebutare
muchbetterthanthoseoftheuncalibrateddevices.
3. WhereasJ4-1andJ4-2areofthesametypeandbrand,differencesexistinthecalibration,which
provesonceagainthatindependentcalibrationofeachphoneisnecessary.
4. AlthoughHTCandS3areequippedwithadditionalmicrophones,nosignificantdifferenceis
observedcomparedwiththeotherphones.

Sensors2016,16,1692 12of18
Sensors 2016, 16, 1692 12 of 18
4.1.2. Additional Microphone
4.1.2. AdditionalMicrophone
To determine the validity of the calibration of a certain phone with or without an additional
To determine the validity of the calibration of a certain phone with or without an additional
microphone, we use the offset from HTC with an additional microphone to calibrate the same phone
microphone,weusetheoffsetfromHTCwithanadditionalmicrophonetocalibratethesamephone
without an additional microphone. The result is shown in Figure 7.
withoutanadditionalmicrophone. TheresultisshowninFigure7.
Figure 7. Comparison of the time series from HTC butterfly with and without an additional
Figure7.ComparisonofthetimeseriesfromHTCbutterflywithandwithoutanadditionalmicrophone.
microphone.
Figure7showsthatthecurvefromtheHTCwithanadditionalmicrophoneverywellcoincides
Figure 7 shows that the curve from the HTC with an additional microphone very well coincides
withthatfromtheSLM,whichverifiestheeffectivenessofthecalibration. However,althoughthe
with that from the SLM, which verifies the effectiveness of the calibration. However, although the
shapesaresimilar,thecurvesfromtheHTCwithoutanyadditionalmicrophoneappearverydifferent
shapes are similar, the curves from the HTC without any additional microphone appear very
from those of the SLM. In particular, when the sound level is higher than 60 dBA, the maximum
different from those of the SLM. In particular, when the sound level is higher than 60 dBA, the
differenceismorethan10dBA.Thisphenomenoncanbequantisedusingthecorrelationcoefficients.
maximum difference is more than 10 dBA. This phenomenon can be quantised using the correlation
For example, Figure 7 shows that the correlation coefficient between the HTC with an additional
coefficients. For example, Figure 7 shows that the correlation coefficient between the HTC with an
microphoneandSLMis0.9792,andthatbetweentheHTCwithoutanadditionalmicrophoneand
additional microphone and SLM is 0.9792, and that between the HTC without an additional
SLM is 0.8951, which is lower than all the other values shown in Figure 2d. Therefore, we do not
microphone and SLM is 0.8951, which is lower than all the other values shown in Figure 2d.
considerthattheHTCwithoutanyadditionalmicrophoneissuitableformeasuringenvironmental
Therefore, we do not consider that the HTC without any additional microphone is suitable for
noise. Usingtheaccumulateddata,wecandeterminethethresholdofwhetherthephonesshouldbe
measuring environmental noise. Using the accumulated data, we can determine the threshold of
calibratedusingthecorrelationcoefficientbetweenthephonesandSLM.Inthismanner,wecanalso
whether the phones should be calibrated using the correlation coefficient between the phones and
determinewhetheraphoneiscapableofmeasuringenvironmentalnoisewithoutlearningthedetails
SLM. In this manner, we can also determine whether a phone is capable of measuring environmental
ofthephonetechnicalparameters.
noise without learning the details of the phone technical parameters.
4.1.3. EffectsofWindandMovement
4.1.3. Effects of Wind and Movement
Toensurethenecessityandeffectivenessofadditionalmicrophoneswithawindscreen,wecarried
To ensure the necessity and effectiveness of additional microphones with a windscreen, we
out a series of experiments. The DT-8852 SLM, HTC with an additional microphone, and S3 with
carried out a series of experiments. The DT-8852 SLM, HTC with an additional microphone, and S3
built-inmicrophonewereusedintheexperiments. Theenvironmentsoundlevelwasrecordedusing
with built-in microphone were used in the experiments. The environment sound level was recorded
thesethreedeviceswhenavolunteerwaswalkingorcycling. Fromthelocalweatherforecast,the
using these three devices when a volunteer was walking or cycling. From the local weather forecast,
windspeedwaslessthan5m/s. Figure8showsthetimeseriesofthedata.
the wind speed was less than 5 m/s. Figure 8 shows the time series of the data.
Figure 8a shows that the time series of the sound level from the HTC with an additional
Figure 8a shows that the time series of the sound level from the HTC with an additional
microphone(redline)ishighlysimilartothatfromtheSLMwhenthevolunteerwaswalking.Thetime
microphone (red line) is highly similar to that from the SLM when the volunteer was walking. The
series of the sound level from S3 with built-in microphone shows some unexpected fluctuations
time series of the sound level from S3 with built-in microphone shows some unexpected fluctuations
comparedwiththatfromtheSLM.Thecorrelationcoefficientbetweentheformertwoconditionswas
compared with that from the SLM. The correlation coefficient between the former two conditions
0.8437,whereasthatofthelatterwas0.6894.
was 0.8437, whereas that of the latter was 0.6894.
Similarphenomenonwasobservedwhenthevolunteerwascycling,andthecorrespondingvalues
Similar phenomenon was observed when the volunteer was cycling, and the corresponding
were0.7881and0.6756. Webelievethatthelackofwindscreensforthebuilt-inmicrophonesisamajor
values were 0.7881 and 0.6756. We believe that the lack of windscreens for the built-in microphones
causeofthesefluctuations. Therefore,werecommendthatwhenenvironmentalnoiseismeasured,the
is a major cause of these fluctuations. Therefore, we recommend that when environmental noise is
resultcanbemademoreaccurateusingmobilephonesequippedwithanadditionalmicrophonewitha
measured, the result can be made more accurate using mobile phones equipped with an additional
windscreen. Theseadditionsnotonlyreducetheeffectofwindbutalsobringconveniencetotheusers
microphone with a windscreen. These additions not only reduce the effect of wind but also bring
inthatthemicrophonescanbekeptintheclothing,bagstraps,andpockets. Inthismanner,wedonot
convenience to the users in that the microphones can be kept in the clothing, bag straps, and
needtoholdthephonesinthehandsforalongtime,whicheasestheworkloadofthemeasurements.
pockets. In this manner, we do not need to hold the phones in the hands for a long time, which eases

Sensors2016,16,1692 13of18
Sensors 2016, 16, 1692 13 of 18
Ofcourse,themobilephonesandmicrophonesshouldbetestedbeforethemeasurementusingthe
the workload of the measurements. Of course, the mobile phones and microphones should be tested
methodspresentedintheprevioussection.
before the measurement using the methods presented in the previous section.
(a)
(b)
Figure 8. Time series of the measurements under different conditions: (a) walking and (b) cycling.
Figure8.Timeseriesofthemeasurementsunderdifferentconditions:(a)walkingand(b)cycling.
4.2. Noise Mapping
4.2. NoiseMapping
In the next sections, we present a rough description of the measurements and pay attention to
Inthenextsections,wepresentaroughdescriptionofthemeasurementsandpayattentiontothe
the difference in the interpolation result using the RNMM and ordinary Kriging method.
differenceintheinterpolationresultusingtheRNMMandordinaryKrigingmethod.
4.2.1. Noise Maps
4.2.1. NoiseMaps
The volunteers performed the measurement campaign twice during the peak hour (8:00–9:00)
Thevolunteersperformedthemeasurementcampaigntwiceduringthepeakhour(8:00–9:00)and
and off-peak hour (21:00–22:00) by covering the whole area of the office park and the surrounding
off-peakhour(21:00–22:00)bycoveringthewholeareaoftheofficeparkandthesurroundingroads.
roads. After eliminating the error data and exception handling, we obtained 1898 measurements
After eliminating the error data and exception handling, we obtained 1898 measurements during
during the peak hour and 2045 measurements during the off-peak hour. Then, we employed the
thepeakhourand2045measurementsduringtheoff-peakhour. Then, weemployedthemethod
method mentioned in Section 2.3.1 to deal with the data and created the noise maps. To obtain a
mentionedinSection2.3todealwiththedataandcreatedthenoisemaps. Toobtainabalancebetween
th
b
e
al
c
a
o
n
m
ce
p u
be
te
tw
d
e
lo
e
a
n
d
th
a
e
n d
co
m
m
a
p
p
u
d
te
e
d
ta
l
i
o
ls
a
,
d
a
a
2
n
0
d
m
m×ap
2 0
de
m
ta
g
il
r
s
i
,
d
a
w
20
a s
m
c h
×
o
2
s
0
e n
m
.
grid was chosen.
For RNMM, we take 10% as the validation data which is used for validation and 90% as the
For RNMM, we take 10% as the validation data which is used for validation and 90% as the
training data which is used to interpolation for each region type. For the Kriging method, we merge
trainingdatawhichisusedtointerpolationforeachregiontype. FortheKrigingmethod,wemerge
the three region types as the raw data, 10% of the raw measurement data as the validation data used
thethreeregiontypesastherawdata,10%oftherawmeasurementdataasthevalidationdataused
for validation and 90% as the training data which is used to interpolation.
forvalidationand90%asthetrainingdatawhichisusedtointerpolation.
The results for the peak and off-peak hours are shown in Figures 9 and 10, respectively, where
Theresultsforthepeakandoff-peakhoursareshowninFigures9and10,respectively,where
(a) uses the RNMM and (b) uses the Kriging method. By visual comparison of the two maps shown
(a)usestheRNMMand(b)usestheKrigingmethod. Byvisualcomparisonofthetwomapsshownin
in Figure 9, we can see that the noise distribution of the two corresponds to the actual situation. The
Figure9,wecanseethatthenoisedistributionofthetwocorrespondstotheactualsituation. Themain
main road in the south shows higher sound levels, especially the crossroads in the southeast
roadinthesouthshowshighersoundlevels,especiallythecrossroadsinthesoutheastfollowedbythe
followed by the roads around the park. The sound levels in the area near the road tend to be higher
roadsaroundthepark. Thesoundlevelsintheareaneartheroadtendtobehigherthanthosefarfrom
th
th
e
a
r
n
o a
t
d
h
.
o
M
se
o
f
s
a
t
r
p
fr
a
o
rt
m
s o
th
f
e
th
r
e
o
p
ad
ar
.
k
M
d
o
i
s
s
t
p l
p
a
a
y
rt
l
s
o w
of
s
t
o
h
u
e
n
p
d
ar
le
k
v
d
e
i
ls
sp
e
l
x
a
c
y
e p
lo
t
w
th
s
e
o
a
u
r
n
ea
d
i
l
n
ev
th
el
e
s
n
e
o
x
r
c
t
e
h
p
(
t
m
th
a
e
r k
a
e
r
d
ea
b
i
y
n(cid:13)
1
th
)
e
an
n
d
or
t
t
h
h
a
(
t
m
w
a
e
r
s
k
t
e
o
d
f
b
th
y
e
①
ce
)
n
a
t
n
ra
d
l p
th
a
a
r
t
t
w
(m
e
a
s
r
t
k
o
e
f
d
th
b
e
y
c(cid:13)e
2
n
)
t
.
r
I
a
n
l
t
p
h
a
e
rt
f o
(m
rm
a
e
rk
r,
e
w
d
e
b
b
y
e
②
lie
)
v
.
e
In
th
t
a
h
t
e
t
f
h
o
e
r
s
m
e
e
h
r
i
,
g
w
he
e
r
b
v
e
a
l
l
i
u
ev
es
e
a
th
re
at
these higher values are partly due to the north exit of the park and the operation of large exhaust
partlyduetothenorthexitoftheparkandtheoperationoflargeexhaustfansattachedtoanearby
fans attached to a nearby dining hall. In the latter, we attribute the higher noise level to the
dininghall. Inthelatter,weattributethehighernoiseleveltotheintersectionintheparkwherethe
intersection in the park where the crowd and vehicles generate loud noise.
crowdandvehiclesgenerateloudnoise.
In addition to the overall similarity, some marked differences are observed between the two
maps. Figure 9b shows an obvious yellow area between the red area of the main road in the south
and the green area in the park. We designate this yellow area as the transition zone. However, Figure
9a does not show such transition zone. In fact, many tall buildings are present in this area. The
buildings will cause a dramatic change in the noise level. Therefore, we consider that the transition
zone should not be obvious here compared with that shown in Figure 9b knowing that the Kriging

Sensors 2016, 16, 1692 14 of 18
Sensors 2016, 16, 1692 14 of 18
method is based on spatial correlation. Hence, the interpolation produces a smooth transition
method is based on spatial correlation. Hence, the interpolation produces a smooth transition
without considering the spatial heterogeneity of sound propagation in the different region types. On
without considering the spatial heterogeneity of sound propagation in the different region types. On
Sensors2016,16,1692 14of18
the other hand, the different region types are modelled and interpolated by the RNMM by
the other hand, the different region types are modelled and interpolated by the RNMM by
considering the influence of spatial heterogeneity.
considering the influence of spatial heterogeneity.
(a) (b)
(a) (b)
Figure 9. Noise maps of the experimental field during the peak hour (8:00–9:00) obtained by different
FiFgiugruere9 .9N. Noiosiesem mapapsso foft htheee xepxpereirmimenentatlafil feiledldd duurirnigngth tehep peaekakh houourr(8 (:80:00–09–:90:00)0o) botbatianiendedb ybyd dififfefreernetnt
methods: (a) RNMM and (b) Kriging.
methods:(a)RNMMand(b)Kriging.
methods: (a) RNMM and (b) Kriging.
(a) (b)
(a) (b)
Figure 10. Noise maps of the experimental field during the off-peak hour (21:00–22:00) obtained by
Figure 10. Noise maps of the experimental field during the off-peak hour (21:00–22:00) obtained by
Fi d g i u ff r e e re 1 n 0 t . mNeotihseodmsa: (pas) oRfNthMeMex apnedri m(be) nKtarilgfiinegld. duringtheoff-peakhour(21:00–22:00)obtainedby
different methods: (a) RNMM and (b) Kriging.
differentmethods:(a)RNMMand(b)Kriging.
The overall distributions of the sound levels of the two maps shown in Figure 10 are also
The overall distributions of the sound levels of the two maps shown in Figure 10 are also
simIinlara.d Tdhiteio rnotaodt hareeoav setrialll lisnidmicilaatreisty a, shoimgheemr asrokuenddd lieffveerel;n hceoswaerveeorb, sbeercvaeudsbe etthwee ternaftfhice tiws noomt avpesr.y
similar. The road area still indicates a higher sound level; however, because the traffic is not very
Fihgeuarvey9 bats hnoigwhst,a nthoeb vniooiuses yleevlleolw aalsroe adbeectrweaeseens.t hSeimreidlaarr etoa otfhteh emmapa induroraindgi nththe epseoaukt hhaonudr,t hthee
heavy at night, the noise level also decreases. Similar to the map during the peak hour, the
grcereonssarroeaadisn atth tehpe afroku.rW coerdneesrisg dnaistpeltahyi shyigehlleorw soaruenada sletvheelst.r aWnistihtioount ztohnee i.nHfluowenecvee or,fF tihgeu rpee9daesdtroieasn,
crossroads at the four corners display higher sound levels. Without the influence of the pedestrian,
noontslyh othwe snuocihset roafn tshieti oexnhzaounset .faInnsfa ocpt,emraatinnygt faollr b2u4 ihld iisn pgrseasreenpt;r tehsuens,t tihnet yheisllaorwea a.rTeha einb uthiled ninogrtshw piallrt
only the noise of the exhaust fans operating for 24 h is present; thus, the yellow area in the north part
caouf stehea pdararkm (amticarckheadn gbey i①nt)h aelsnoo sisigenleifviceal.nTtlhye dreefcorreea,swese. cTohnes iydeelrlotwha atrtehae tthraant siintdioincaztoesn ehisghhoeurl dsonuontd
of the park (marked by ①) also significantly decreases. The yellow area that indicates higher sound
beleovbelv iinosuisdhe ethree cpoamrkp anroe dlowngitehr ethxaisttss.h Aow hnigihn-nFoigisuer ear9eba kinndoiwcaintegdt bhya trtehde aKprpigeainrsg amt eththeo wdeisst bsaidseed of
level inside the park no longer exists. A high-noise area indicated by red appears at the west side of
onthsep aptairakl c(omrraerlkaetido nb.yH ②en)c eb,etchaeuisnet esropmolea tivoenndpororsd ugcaetshears mheoroet hint rathnes iteiovnenwinitgh, ocuatucsoinngsi dae rlianrgge
the park (marked by ②) because some vendors gather here in the evening, causing a large
thceonspceantitarlahtieotne roofg peenoepitlye aonfdso tuhnuds ipnrcorpeaasgiantgio tnhein ntohiseed liefvfeerle. ntregiontypes. Ontheotherhand,the
concentration of people and thus increasing the noise level.
differeBnyt rceogmiopnartiynpge tshaer etwmoo mdealplesd, wane dcainn tsetrilpl osleaet ead trbaynsthiteioRnN zMonMe ibny Fcigounrseid 1e0rbin. Hgothweeivneflru, eitn occecoufrs
By comparing the two maps, we can still see a transition zone in Figure 10b. However, it occurs
spdautriainlgh ettheer oogffe-npeeiatyk. hour; thus, the difference in the noise levels between adjacent regions is not as
during the off-peak hour; thus, the difference in the noise levels between adjacent regions is not as
obvTiohueso vase rtahlladt isshtroibwunti oinn sFoifgtuhree so9bu.n dThleevreeflsoroef, thtreantwsiotiomna pzsonsheos wonnliyn Faipgpueraer1 0beatrweeaelsno asidmjaiclaern.t
obvious as that shown in Figure 9b. Therefore, transition zones only appear between adjacent
Trheegrioonads warheeares tail llairngdei cgaatpes ina thhieg hneorisseo luenvdelsle evxeils;tsh. owever,becausethetrafficisnotveryheavyat
regions where a large gap in the noise levels exists.
night,Bthye annoailsyesilnegv eFligalusroesd e9c arenads e1s0., Swime bilealrietvoet htheamt mapeadsuurriinngg tnhoeispee aakndh ocurera,ttihnegc nroosissero madaspsa tutshineg
By analysing Figures 9 and 10, we believe that measuring noise and creating noise maps using
focuarlibcroartneedr ssdmisaprtlpahyohniegsh earres ofuenadsiblelev,e lasn.dW tihthe onuotitshee-leinvflelu edniscteriobfutthioenp eind etshteri aenx,poenrilmyethnetanl ofiiseeld
calibrated smartphones are feasible, and the noise-level distribution in the experimental field
ofgethneereaxthedau bsyt ftahniss ompeetrhaotidn gisf ocron24sishteisntp rwesitehn tc;otmhums,otnh eseyneslleo. wSoamreea siinmtihlaernitoiersth aprea ratlosof tohbesperavrked
generated by this method is consistent with common sense. Some similarities are also observed
(markedby(cid:13)1 )alsosignificantlydecreases. Theyellowareathatindicateshighersoundlevelinside
the park no longer exists. A high-noise area indicated by red appears at the west side of the park
(m arkedby(cid:13)2 )becausesomevendorsgatherhereintheevening,causingalargeconcentrationof
peopleandthusincreasingthenoiselevel.

Sensors2016,16,1692 15of18
Bycomparingthetwomaps,wecanstillseeatransitionzoneinFigure10b. However,itoccurs
duringtheoff-peakhour;thus,thedifferenceinthenoiselevelsbetweenadjacentregionsisnotas
obviousasthatshowninFigure9b. Therefore,transitionzonesonlyappearbetweenadjacentregions
wherealargegapinthenoiselevelsexists.
ByanalysingFigures9and10,webelievethatmeasuringnoiseandcreatingnoisemapsusing
calibratedsmartphonesarefeasible,andthenoise-leveldistributionintheexperimentalfieldgenerated
bythismethodisconsistentwithcommonsense. Somesimilaritiesarealsoobservedbetweenthe
RNMMandtheKrigingmethod. Withrespecttotheprecisionofthetwomethods,wepresentthe
issueinthenextsection.
4.2.2. PrecisionAnalysis
WehavevisuallylearnedthedifferenceintheinterpolationresultsoftheRNMMandKriging
methodbycomparingthenoisemapspresentedinthelastsection. However,wehaveyettodetermine
theprecisionofthetwomethods. Becausenoofficialorotherauthoritiesinnoisemapsareavailablein
thefield,wecannotcompareourmapwithanofficialonetodetermineitsprecision. Therefore,weuse
crossvalidationtodeterminetheprecisionofspatialinterpolationandcomparetheirrespectiveresults.
TheresultsarelistedinTable3.
Table3.Meanandstandarddeviationofthedifferentmethodsanddifferentregiontypes.
Period Precision Kriging RNMM Building Road Square
Mean 0.44 0.17 0.46 0.08 −2.19
Peakhour
Std. 3.06 2.49 2.19 2.52 4.42
Off-peak Mean −0.09 −0.01 0.08 −0.02 −0.70
hour Std. 3.11 3.02 2.50 3.46 1.07
InTable3,KrigingandRNMMrespectivelyrepresentthestatisticsoftheinterpolationresultsof
thewholeareausingtheordinaryKrigingmethodandRNMM.Building,Road,andSquarerepresent
thestatisticsofthevalueofthethreedifferentregiontypesusingtheordinaryKrigingmethod.
Table 3 indicates that the data during the peak or off-peak hour, the average error, and the
standard deviation of the RNMM are smaller than those of the ordinary Kriging method, which
provethevalidityoftheRNMM.Wealsonotethattheaverageerrorandstandarddeviationforthe
road,building,andsquareshowalargedifference. Wearguethatthisdifferenceisduetothespatial
heterogeneityofthenoisedistributionindifferentregiontypes.
Table3showsthattheaverageerrorandstandarddeviationofthesquareareaduringthepeak
hourarelargerthanthoseduringtheoff-peakhourmainlybecauseduringrushhour,alargenumber
ofpeoplegatheredinthesquarewhenthevolunteerswentthroughthecrowd. Thus,noisiersounds
wererecordedwhichwerelargelyrandomanduncertain,thusleadingtoalargererrorandhigher
instability. Compared with the same place during the off-peak hour when the square was almost
deserted,theresultswereverymuchdifferent. Similarly,thebuildingandroadduringthepeakhour
haveacontinuousbalanceoftrafficflowandresultinarelativelystablenoiselevel. Forthebuilding
regionduringtheoff-peakhourintheeveningwhenfewerpeoplearepresentandisrelativelyquiet,
asuddenvoicecauseslargerfluctuationinthecollecteddata. Fortheroadregion,thedistributionof
trafficflowisnotbalanced,whichincreasestherandomnessofthenoisedistributionofthecollected
data points. Therefore, in these two regions, the standard deviation (or the volatility) during the
off-peakhourwashigherthanthatduringthepeakhour.
In summary, the RNMM has better spatial interpolation precision than the ordinary Kriging
method by taking into account the difference in the spatial correlation in different region types.
WebelievethattheRNMMisparticularlysuitableforparticipatorysensingdatameasurementusing
smartphones. BecausetheRNMMconsiderstheparticipantunderstandingofthespatialdistribution

Sensors2016,16,1692 16of18
inthemeasurementregion,theinterpolationprecisionisfurtherimprovedwithoutincreasingthe
workloadoraddingfurtherinformation.
5. Conclusions
Inthispaperwehavepresentedanoise-mappingmethodusingsmartphones,whichinvolves
twoaspects: easilyandeffectivelymeasureenvironmentalnoiseandcreatingofanoisemapofthe
wholeareausinglimitedmeasurementdata.
Toachievecertainprecisionforthemeasurement,wedesignedasetofmethodstocalibratethe
smartphones. Usingthismethod,wecouldeasilycompletethecalibrationwithoutusingadditional
equipment. Wecalibratedseveralcommonsmartphonesinourstudy. Theresultshowsthatmost
ofthephoneshavemeasurementresultsclosetothatoftheSLMaftercalibration. Theerrorofthe
differentphoneslargelyvariedevenforthesametypesofphone,wherethecalibrationvaluewasstill
different. Therefore,webelievethatindividualcalibrationofeachphoneisnecessary.
Using smartphones for noise monitoring is different from the traditional static observations.
Thephoneuserscanbemovingatanytime,andholdingphoneswiththeirhandstomeasurenoise
canbringgreatinconveniencetotheusers. Atthesametime,theinfluenceofwindcausedbytheuser
movementandtravelcannotbeignored.Therefore,weproposedamethodandconfirmedthenecessity
of attaching an additional microphone with a windscreen to reduce the effect of wind. The result
showsthattheadditionalmicrophonecaneffectivelyreducetheeffectofmotionssuchaswalkingand
cyclingonthemeasurementandcanyieldameasurementvalueclosertothatoftheSLM.Webelieve
thatinusingsmartphonesfornoisemeasurement,weneedtoattachanadditionalmicrophone,which
cannotonlyimprovetheprecisionofthemeasurementbutalsobemoreconvenienttotheusers.
During the noise measurement, the density of the data that we gathered is always limited;
thus, coveringanentireareawasimpossible. Therefore, weneedtoachieveafullcoverageofthe
measurementfieldusinganinterpolationmethod. Thenoise-leveldistributioncanbelocallyabnormal
asaresultofspatialheterogeneity. Tominimisetheinfluenceofspatialheterogeneityandtoimprove
theprecisionofthelocalnoisedistributioninthenoisemap,weproposedtheRNMM,whichisbased
onthedistributionofnoiseindifferentregiontypestaggedbyvolunteers,tomodel,interpolate,and
combinethesedistributions. Weanalysedtheinterpolationresultsofthedatafromtheexperimental
fieldusingtheRNMMandordinaryKriging. TheresultshowsthattheRNMMismoreaccuratein
reflectingthelocaldistributionofnoiseandconsequentlyhasbetterinterpolationprecision.
Inthispaper,Wemainlyfocusontheparticipatesensingandcitizeninvolvingandtrytomeasure
soundlevelsandnoisemappingbyusingtheembeddedsensorsofmobilephones. Inthefollowing
study,wewilltrytoadoptthesoundpropagationmodelsandsimulatedistributionsusingcommercial
softwaresuchasCadna,SoundPLANtoimproveourmodelandmethodcontinuously.
Insummary,webelievethattheproposednoise-mappingmethodbasedonsmartphonesisafast
andlow-costnoise-mappingsolutionthatcanachievecertainprecisionandhaspracticalvaluefor
citiesthatlackbasicequipmentfornoisemonitoringandforvolunteersconcernedabouttheurban
environment. Inthefuture,weintendtocombineurbanland-usemapsandconductfurtherdetailed
studyofthenoisepropagationcharacteristicsinotherregiontypessuchasanurbangreenspaceand
tocontinuouslyenhanceourproposedRNMM.
Acknowledgments: ThisworkwassupportedbytheOpenResearchFundofKeyLaboratoryofDigitalEarth
Science,InstituteofRemoteSensingandDigitalEarth,ChineseAcademyofSciences(No.2015LDE006).
AuthorContributions:H.X.andY.Q.designedthesmartphonecalibrationandthespatialinterpolationmethods.
H.X.andJ.Z.conceivedanddesignedtheexperiments.H.X.,J.Z.andS.L.performedtheexperiments.H.X.and
J.Z.developedthesoftware,analysedthedata,andwrotethepaper.
ConflictsofInterest:Theauthorsdeclarenoconflictofinterest.

Sensors2016,16,1692 17of18
References
1. European Environment Agency. Noise in Europe 2014; Publications Office of the European Union:
Luxembourg,2014.
2. Lewis,R.C.;Gershon,R.R.M.;Neitzel,R.L.Estimationofpermanentnoise-inducedhearinglossinanurban
setting.Environ.Sci.Technol.2013,47,6393–6399.[CrossRef][PubMed]
3. Hunashal,R.B.;Patil,Y.B.AssessmentofnoisepollutionindicesinthecityofKolhapur,India.ProcediaSoc.
Behav.Sci.2012,37,448–457.[CrossRef]
4. Ausejo,M.;Recuero,M.;Asensio,C.;Pavón,I.;López,J.M.Studyofprecision,deviationsanduncertainty
in the design of the strategic noise map of the macrocenter of the city of Buenos Aires, Argentina.
Environ.Model.Assess.2009,15,125–135.[CrossRef]
5. Butler,D.Noisemanagement:Soundandvision.Nature2004,427,480–481.[CrossRef][PubMed]
6. Wing,L.C.;Kwan,L.C.;Kwong,T.M.VisualizationofComplexNoiseEnvironmentbyVirtualRealityTechnologies;
EnvironmentProtectionDepartment(EPD):HongKong,China,2006.
7. Tsai,K.-T.;Lin,M.-D.;Chen,Y.-H.Noisemappinginurbanenvironments:ATaiwanstudy.Appl.Acoust.
2009,70,964–972.[CrossRef]
8. Directive,E.Directive2002/49/ECoftheEuropeanparliamentandtheCouncilof25June2002relatingto
theassessmentandmanagementofenvironmentalnoise.Off.J.Eur.Commun.2002,L189,12–26.
9. Zheng,Y.;Liu,T.;Wang,Y.;Zhu,Y.;Liu,Y.;Chang,E.DiagnosingNewYorkcity’snoiseswithubiquitousdata.
InProceedingsofthe2014ACMInternationalJointConferenceonPervasiveandUbiquitousComputing,
Seattle,WA,USA,13–17September2014;pp.715–725.
10. Aletta,F.;Kang,J.Soundscapeapproachintegratingnoisemappingtechniques:AcasestudyinBrighton,
UK.NoiseMapp.2015,2,1–12.[CrossRef]
11. Aiello,L.M.;Schifanella,R.;Quercia,D.;Aletta,F.Chattymaps:Constructingsoundmapsofurbanareas
fromsocialmediadata.OpenSci.2016,3,150690.[CrossRef][PubMed]
12. D’Hondt,E.;Stevens,M.;Jacobs,A.Participatorynoisemappingworks! Anevaluationofparticipatory
sensingasanalternativetostandardtechniquesforenvironmentalmonitoring.PervasiveMob.Comput.2013,
9,681–694.[CrossRef]
13. Rana,R.;Chou,C.T.;Bulusu,N.;Kanhere,S.;Hu,W.Ear-phone: Acontext-awarenoisemappingusing
smartphones.PervasiveMob.Comput.2015,17,1–22.[CrossRef]
14. Hsieh,H.-P.;Lin,S.-D.;Zheng,Y.Inferringairqualityforstationlocationrecommendationbasedonurban
bigdata.InProceedingsofthe21thACMSIGKDDInternationalConferenceonKnowledgeDiscoveryand
DataMining,Sydney,Australia,10–13August2015;pp.437–446.
15. Du,W.;Xing,Z.;Li,M.;He,B.;Chua,L.H.C.;Miao,H.Optimalsensorplacementandmeasurementof
windforwaterqualitystudiesinurbanreservoirs.InProceedingsofthe13thInternationalSymposiumon
InformationProcessinginSensorNetworks,Berlin,Germany,15–17April2014;pp.167–178.
16. Macias,E.;Suarez,A.;Lloret,J.Mobilesensingsystems.Sensors2013,13,17292–17321.[CrossRef][PubMed]
17. Maisonneuve,N.;Stevens,M.;Niessen,M.E.;Steels,L.NoiseTube:Measuringandmappingnoisepollution
withmobilephones. InInformationTechnologiesinEnvironmentalEngineering;Springer: Berlin,Germany,
2009;pp.215–228.
18. Rana,R.K.;Chou,C.T.;Kanhere,S.S.;Bulusu,N.;Hu,W.Ear-phone: Anend-to-endparticipatoryurban
noisemappingsystem. InProceedingsofthe9thACM/IEEEInternationalConferenceonInformation
ProcessinginSensorNetworks,Stockholm,Sweden,12–15April2010;pp.105–116.
19. Schweizer,I.;Bärtl,R.;Schulz,A.;Probst,F.;Mühläuser,M.NoiseMap-real-timeparticipatorynoisemaps.
InProceedingsofthePhoneSense2011—SecondInternationalWorkshoponSensingApplicationsonMobile
Phones,Seattle,WA,USA,1–4November2011;pp.1–5.
20. Guillaume,G.;Can,A.;Petit,G.;Fortin,N.;Palominos,S.;Gauvreau,B.;Bocher,E.;Picaut,J.Noisemapping
basedonparticipativemeasurements.NoiseMapp.2016,3,140–156.[CrossRef]
21. Can,A.;VanRenterghem,T.;Botteldooren,D.Exploringtheuseofmobilesensorsfornoiseandblackcarbon
measurementsinanurbanenvironment.InProceedingsoftheAcoustics2012NantesConference,Nantes,
France,23–27April2012;pp.1549–1554.
22. International Electrotechnical Commission. Electroacoustics—Sound Level Meters. Part 1: Specifications;
IEC61672-1;IEC:Geneva,Switzerland,2002.

Sensors2016,16,1692 18of18
23. Cui,Y.;Chipchase,J.;Ichikawa,F.Acrossculturestudyonphonecarryingandphysicalpersonalization.
InUsabilityandInternationalization,ProceedingsoftheHciandCulture:SecondInternationalConferenceon
UsabilityandInternationalization,Ui-Hcii2007,Beijing,China,22–27July2007;Aykin,N.,Ed.;Springer:
Berlin/Heidelberg,Germany,2007;pp.483–492.
24. GuidelinesandManuals(DepartmentofEnvironmentandHeritageProtection). Availableonline: https:
//www.ehp.qld.gov.au/licences-permits/guidelines.html(accessedon18June2016).
25. Cuevas-Martinez,J.C.;Gadeo-Martos,M.A.;Fernandez-Prieto,J.A.;Yuste-Delgado,A.J.WirelessIntelligent
SensorsManagementApplicationProtocol-WISMAP.Sensors2010,10,8827–8849.[CrossRef][PubMed]
26. Audacity.Availableonline:http://www.audacityteam.org/(accessedon20February2016).
27. Murphy,E.;King,E.A.Testingtheaccuracyofsmartphonesandsoundlevelmeterapplicationsformeasuring
environmentalnoise.Appl.Acous.2016,106,16–22.[CrossRef]
28. Li,T.J.-J.;Sen,S.;Hecht,B.LeveragingadvancesinnaturallanguageprocessingtobetterunderstandTobler’s
firstlawofgeography.InProceedingsofthe22ndACMSIGSPATIALInternationalConferenceonAdvances
inGeographicInformationSystems,Dallas,TX,USA,4–7November2014;pp.513–516.
29. Wang,J.F.;Christakos,G.;Hu,M.G.Modelingspatialmeansofsurfaceswithstratifiednonhomogeneity.
IEEETrans.Geosci.RemoteSens.2009,47,4167–4174.[CrossRef]
30. Oliver,M.A.;Webster,R.Kriging:Amethodofinterpolationforgeographicalinformationsystems.Int.J.
Geogr.Inf.Syst.1990,4,313–332.[CrossRef]
31. BoyaAudioEquipmentCo.,LTD.By-lm10.Availableonline:http://www.boya-mic.com/products/show-
398.html(accessedon16May2016).
32. MathWorks-MakersofMATLABandSimulink.Availableonline:http://www.mathworks.com/(accessed
on23August2016).
33. ArcGISPlatform.Availableonline:http://www.esri.com/software/arcgis(accessedon23August2016).
©2016bytheauthors;licenseeMDPI,Basel,Switzerland. Thisarticleisanopenaccess
articledistributedunderthetermsandconditionsoftheCreativeCommonsAttribution
(CC-BY)license(http://creativecommons.org/licenses/by/4.0/).
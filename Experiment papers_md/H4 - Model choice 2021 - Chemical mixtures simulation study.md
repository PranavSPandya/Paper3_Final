PLOS ONE
RESEARCHARTICLE
Model choice for estimating the association
between exposure to chemical mixtures and
health outcomes: A simulation study
LaurenHoskovecID 1*,WandeBenka-Coker2,RachelSeverson2,SherylMagzamen2,
AnderWilson1
1DepartmentofStatistics,ColoradoStateUniversity,FortCollins,CO,UnitedstatesofAmerica,
2DepartmentofEnvironmentalandRadiologicalHealthSciences,ColoradoStateUniversity,FortCollins,
CO,UnitedstatesofAmerica
a1111111111
a1111111111 *lvheck@rams.colostate.edu
a1111111111
a1111111111
a1111111111 Abstract
Challengesariseinresearchinghealtheffectsassociatedwithchemicalmixtures.Several
methodshaverecentlybeenproposedforestimatingtheassociationbetweenhealthout-
comesandexposuretochemicalmixtures,butaformalsimulationstudycomparingbroad-
OPENACCESS
rangingmethodsislacking.Weselectfiverecentlydevelopedmethodsandevaluatetheir
Citation:HoskovecL,Benka-CokerW,SeversonR,
performanceinestimatingtheexposure-responsefunction,identifyingactivemixturecom-
MagzamenS,WilsonA(2021)Modelchoicefor
ponents,andidentifyinginteractionsinasimulationstudy.Bayesiankernelmachineregres-
estimatingtheassociationbetweenexposureto
chemicalmixturesandhealthoutcomes:A sion(BKMR)andnonparametricBayesshrinkage(NPB)weretop-performingmethodsin
simulationstudy.PLoSONE16(3):e0249236. oursimulationstudy.BKMRandNPBoutperformedothercontemporarymethodsandtradi-
https://doi.org/10.1371/journal.pone.0249236
tionallinearmodelsinestimatingtheexposure-responsefunctionandidentifyingactivemix-
Editor:JaymieMeliker,StonyBrookUniversity, turecomponents.BKMRandNPBproducedsimilarresultsinadataanalysisoftheeffects
GraduatePrograminPublicHealth,UNITED
ofmultipollutantexposureonlungfunctioninchildrenwithasthma.
STATES
Received:October8,2020
Accepted:March13,2021
Published:March25,2021
Copyright:©2021Hoskovecetal.Thisisanopen
accessarticledistributedunderthetermsofthe Introduction
CreativeCommonsAttributionLicense,which
Individualsarecontinuouslyexposedtocomplexmixturesofenvironmentalchemicals.
permitsunrestricteduse,distribution,and
Mountingevidencefromepidemiologicalstudieslinksenvironmentalexposurestoincreased
reproductioninanymedium,providedtheoriginal
authorandsourcearecredited. morbidityandmortality[1–5].Traditionalepidemiologicalstudieshavefocusedonasingle
pollutantandadditivemodelswithasmallnumberofexposures;however,studyingpollutants
DataAvailabilityStatement:Alldataforthestudy
inisolationcanleadtobiasedestimates[6,7]anddoesnotreflecttherealitythatpeopleare
areprotectedunderColoradoStateUniversity’s
InstitutionalReviewBoard(IRB).Datacannotbe jointlyexposedtomixturesofpollutants.Hence,interestisrapidlygrowinginstudyinghealth
sharedpubliclyduetoconcernsforprotectionof outcomesassociatedwithsimultaneousexposuretomixturesofpollutants[8,9].TheNational
humansubjects.Thedatacontainprotectedhealth InstituteforEnvironmentalHealthSciences(NIEHS)identifiedthestudyofmixturesasagoal
informationanddatathatcouldpotentiallyidentify
inits2012-2017strategicplanwhilenotingthatthiswillrequirenovelquantitativeapproaches
subjects.Thedataunderlyingtheresultspresented
[10].Assuch,numerousstatisticalmethodshavebeenproposed.Thereisaneedtoidentify
inthestudyareavailablefromColoradoState
themostappropriatestatisticalmethodscurrentlyavailableforestimatinghealthoutcomes
University’sIRB.TheIRBcontactemailis
RICRO_IRB@mail.colostate.edu. associatedwithexposuretomixtures[11,12].
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 1/21

PLOS ONE Modelchoiceforchemicalmixtures
Funding:Thisworkwassupportedbygrants Studyinghealthoutcomesassociatedwithexposuretomixturesiscomplicatedbysmall
ES023815awardedtoA.W.andES028811 effectsizes,highlycorrelatedexposures,possiblenonlinearandinteractioneffects,andoften
awardedtoS.M.fromtheNationalInstitutesof
smallsamplesizes.Inthiscontext,traditionalregressionmethodsareofteninadequateasthey
Health(www.nih.gov).Thisworkutilizedthe
mayyieldbiasedorunstableestimates[13]andhavelowpowertodetecteffects,especiallyin
RMACCSummitsupercomputer,whichis
thecaseofnonlinearassociationsandinteractions.Commonmethodsdesignedforvariable
supportedbytheNationalScienceFoundation
(www.nsf.gov,awardsACI-1532235andACI- selectiontendtoincorrectlyselectpredictorswhenmanypredictorsarehighlycorrelated[14]
1532236toA.W.andL.H.),theUniversityof andclassicalmodelselectiontechniquesignoreuncertaintyinboththeselectedmodeland
ColoradoBoulderandColoradoStateUniversity. selectedmixturecomponentswhenestimatingtheexposure-responsefunction[15,16].
TheRMACCSummitsupercomputerisajoint
Inabroadliteraturereview,Davalosetal.[17]identifiedfiveclassesofmethodscurrently
effortoftheUniversityofColoradoBoulderand
usedinmixturesanalyses:additivemaineffects(AME),effectmeasuremodification(EMM),
ColoradoStateUniversity.Thefundershadnorole
instudydesign,datacollectionandanalysis, unsuperviseddimensionreduction(UDR),superviseddimensionreduction(SDR),andnon-
decisiontopublish,orpreparationofthe parametric(NP).AMEandEMMmethodsaretypicallyregressionbased.AMEallowsonly
manuscript.Thisresearchwassupportedby additiveeffects,whileEMMincludesmultiplicativeinteractions.Hierarchicalandpenalized
USEPAgrantsRD-839278.Itscontentsaresolely
regressionmethodshavebeenappliedtoAMEandEMMmodelstoidentifyimportantmix-
theresponsibilityofthegranteeanddonot
turecomponentsandimproveprecision[18–22].Thenexttwogroupsaredimensionreduc-
necessarilyrepresenttheofficialviewsofthe
tiontechniques(UDRandSDR)thattransformexposuredatatoreducethedimensionofthe
USEPA.Further,USEPAdoesnotendorsethe
purchaseofanycommercialproductsorservices predictorand,therefore,therequiredparameterspace.UDRmethodssuchask-means[23,
mentionedinthepublication. 24]transformexposuredatawithoutregardtothehealthoutcome[25–28].SDRmethods,
includingsupervisedprinciplecomponentsanalysis[29],lettheoutcomeinformexposure
Competinginterests:Theauthorshavedeclared
thatnocompetinginterestsexist. datatransformation[30–35].Finally,NPmethodslikeBayesiankernelmachineregression
[36]areflexibledata-driventechniquesforestimatingacomplexexposure-responsefunction
thatmayincludeinteractionsandnonlineareffects[37,38].
Choosinganappropriatestatisticalmodeldependsontheresearchobjectives[11,39]and
requiresunderstandingtheempiricalperformanceofmethods.Recentstudieshavecompared
severalmethodsinsubsetsofthemodelclassesproposed.Amongthoseevaluatedinclude
linearregressionAME[40]andEMMmethods[14],principlecomponentsanalysis[34],
structuralequationmodels[41],Bayesiankernelmachineregression[41],andBayesiansemi-
parametricregression[42].Thesestudieshighlightchallengesinducedbyhighlycorrelated
datainestimatingcomplexexposure-responsefunctionsandcharacterizinguncertainty.To
ourknowledge,therehasbeennoformalevaluationofmethodsfromallfiveclassesidentified
byDavalosetal.[17]inasinglesimulationstudy.
Evaluatingtheempiricalperformanceofmethodsacrossawidespectrumofmodelclasses
isimportantasitguidesresearchersinchoosingacrossclassesofmodelsandaidsininterpret-
ingresultsandunderstandingthelimitationsofepidemiologicalstudiesusingthesemethods.
Inaddition,theexistingliteratureissparsewithregardstoacomparisonamongBayesian
methods,whicharefavorableinthemultipollutantsettingastheycanincorporatepriorinfor-
mationandfullycharacterizeuncertainty[12,34,43].Tothisend,wefocusonacomparison
ofBayesianmethodsacrossavarietyofmodelclassesinthispaper.Bycomparingperformance
acrossclassesofmodels,researcherscanalsogaininsightintopromisingfuturedirectionsfor
statisticalmethodsdevelopment.
Motivatedbyresearchlinkingmixturesofairpollutantandpesticideexposurestochild
respiratoryhealth,weconductedasimulationstudytocomparecontemporarymethodsdevel-
opedforestimatingtheassociationbetweenhealthoutcomesandexposuretomixtures.We
consideredonemethodfromeachofthefiveclassesidentifiedbyDavalosetal.[17]andevalu-
atedeachmethodinthreedata-generatingscenarios.Thedata-generatingscenarioscovera
rangeoflineartononlinearfunctionsofmultiplepollutantswithsynergisticeffectsonthe
responseinordertotesteachmethodinitsabilitytoestimatebothsimpleandcomplexexpo-
sure-responsefunctionsthatmaybeencounteredinpractice.
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 2/21

PLOS ONE Modelchoiceforchemicalmixtures
Incontrasttomanyrecentstudiesthathavecomparedmethodsfromaconceptualstand-
pointorcomparedtheirperformanceintheanalysisofasingledataset,theprimarycontribu-
tionofourworkistocomparediversemethodsinasimulationstudyaddressingavarietyof
researchquestions.Specifically,wequantifiedfouraspectsofmodelperformancecorrespond-
ingtopreviouslyidentifiedepidemiologicalquestionsofinterest:1)howwelldoesthemodel
estimatetheexposure-responsefunction,2)canthemodelidentifyimportantmixturecompo-
nents,3)canthemodelidentifycomponentsnotassociatedwiththeoutcome,and4)canthe
modelidentifyinteractionsamongexposures[39].
Asecondarycontributionofourworkistoprovidesoftwareforthetestedmethodsthat
currentlylacksoftware.Oursimulationstudydescribesthestrengthsandweaknessesofeach
methodandavailablesoftwareencouragespractitionerstousethemostappropriatemethods
inagivenapplication.SoftwareisavailableintheformoftheRpackagemmpack[44]to
reproducethesimulation.Further,thesoftwareallowsresearcherstoeasilyconductasimula-
tionstudyusingthesamemethodsandsimulatedexposure-responsefunctionsbutsubstitut-
ingintheirownexposuredatawhichwillhaveadifferentcorrelationstructureandmayresult
indifferentmodelperformance.Hence,researcherscandeterminewhichmethodsaremost
appropriatefortheirownstudy.Finally,weappliedeachmethodtoadataanalysisofacohort
studyinvestigatingtherelationshipbetweenairpollutantandpesticideexposuresandlung
functioninchildrenwithasthma.Wedescribethedifferencesinresultsamongthemethods,
highlightingtheimportanceofmodelchoice.
Materialsandmethods
Data
Healthdata. ThisstudywasapprovedbytheInstitutionalReviewBoardofColorado
StateUniversity,ProtocolNumber19-9437H.Thiswasasecondarydataanalysisfromaclosed
cohortwithallpersonalidentifyinginformationstrippedfromthedatabase.Weuseddata
fromFresnoAsthmaticChildren’sEnvironmentStudy(FACES).Thestudydesign,including
recruitment,eligibilitycriteria,andmeasurementprocedures,isdescribedelsewhere[45–50].
FACESincludesdataforchildrenaged6-11yearswithasthmasymptomsatthetimeofenroll-
mentandlivingwithina20kilometerradiusofoneofFresno‘sEPAairqualitymonitoring
sites.Thehealthoutcomeofinterestwasbaselineforcedexpiratoryvolumeinthefirstsecond
(FEV )measuredviaspirometry.WeregressedFEV onage,sex,heightandethnicityand
1 1
usedtheresidualsastheoutcomeinourdataanalysis[51–53].Age,sex,height,andethnicity
arewell-knownpredictorsofFEV soweremoveallvariationfromthesepredictorsbefore
1
lookingintotheeffectsofairpollutionandpesticideexposureonFEV .Othercovariateshave
1
notbeenaswellstudiedregardingtheirassociationwithFEV andareincludingthemodelas
1
potentialconfoundingvariables.Completeexposure,health,andcovariatedatawereavailable
for153children.
Thedatacontaininformationoncovariatesandpotentialconfoundingvariables(S1
TableinS1File).Weincludedaveragetemperatureandprecipitationoverthreemonths,the
temporalscaleofthepesticideexposuredata,priortobaselineascovariates.Subject-specific
covariatesincludebodymassindex(BMI,kg/m2)andindicatorsfor:self-reportedresidence
withinoneblockofafreeway,anysmokinginthehome,positiveatopyorallergytest,modi-
fiedGlobalInitiativeforAsthma(GINA)score�3atbaseline,householdincomegreaterthan
$30K/year,motherhavingpost-secondaryeducation,childnotcoveredbyinsurance,andsea-
sonofbaselinespirometrytest.Temperature,precipitation,andBMIwerescaledtohave
mean0andvariance1.Approximately1%ofthecovariatedatawasmissing,includingany
smokinginthehome(16%),householdincome(3%),andmotherhavingpost-secondary
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 3/21

PLOS ONE
Modelchoiceforchemicalmixtures
Table1.Pesticideandairpollutantexposuredatasummarystatistics.Tableshowsmean,standarddeviation(SD),minimum,25thpercentile,median,75thpercentile,
andmaximumconcentrationforeachexposure.
|     | mean |     | SD  | min |     | 25th | median |     | 75th | max |     |
| --- | ---- | --- | --- | --- | --- | ---- | ------ | --- | ---- | --- | --- |
C×106(kg/3km2)
|                   | 0.15 |     | 0.33 | 0.00 |     | 0.00 | 0.00 |     | 0.15 | 2.35  |     |
| ----------------- | ---- | --- | ---- | ---- | --- | ---- | ---- | --- | ---- | ----- | --- |
| MeBr×106(kg/3km2) | 3.88 |     | 9.90 | 0.00 |     | 0.00 | 0.00 |     | 0.00 | 48.92 |     |
OP×106(kg/3km2)
|         | 0.93 |     | 1.08 | 0.00 |     | 0.00 | 1.11 |     | 1.17 | 5.40 |     |
| ------- | ---- | --- | ---- | ---- | --- | ---- | ---- | --- | ---- | ---- | --- |
| O (ppb) | 0.04 |     | 0.01 | 0.01 |     | 0.03 | 0.04 |     | 0.04 | 0.06 |     |
3
| NO 2 (ppb) | 15.48 |     | 3.26 | 9.49 |     | 12.64 | 14.42 |     | 17.96 | 23.07 |     |
| ---------- | ----- | --- | ---- | ---- | --- | ----- | ----- | --- | ----- | ----- | --- |
| PM (μg/m3) | 16.35 |     | 9.80 | 6.66 |     | 10.14 | 11.23 |     | 18.20 | 40.21 |     |
2.5
(μg/m3)
| PM 10 | 37.89 |     | 10.68 | 19.55 |     | 30.30 | 32.49 |     | 47.23 | 65.94 |     |
| ----- | ----- | --- | ----- | ----- | --- | ----- | ----- | --- | ----- | ----- | --- |
https://doi.org/10.1371/journal.pone.0249236.t001
education(1%).Asallcovariateswithmissingdatawerebinaryvariables,wesinglyimputed
themissingvalueswith0andthenaddedadummyvariableforeachcovariatewithanymiss-
ingdatathatindicatedwhichvaluesofthatcovariateweremissing.
Airpollutionandpesticidedata. WeobtainedairpollutiondatafromtheEPAAirQual-
itySystemDataMart.Airpollutantconcentrationswerecalculatedas24-houraveragesfor
particles�2.5μminaerodynamicdiameter(PM 2.5 )andparticles�10μminaerodynamic
diameter(PM ),8-hourdailymaximumlevelsforozone(O )andone-hourdailymaximum
|     |     |     | 10  |     |     |     |     | 3   |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
levelsfornitrogendioxide(NO )[47].Concentrationsweretakenfromtheairmonitoringsite
2
closesttoeachchild’sresidenceandexposurelevelsweresummarizedasaveragesoverthree
monthspriortobaselinespirometryteststobeconsistentwithavailablepesticideexposure
data.Duetoright-skeweddistributions,airpollutantexposuresweresquare-roottransformed
andthenscaledtohavemean0andvariance1.
Weobtaineddataonthedate,location,andamount(kilograms)ofappliedagriculturalpes-
ticidesfromtheCaliforniaPesticideUseReport(PUR)[54].Basedonpreviousevidencelink-
ingpesticideexposuretorespiratoryillness[55,56],weconsideredthreepesticideclasses:
carbamates(C),methylbromide(MeBr),andorganophosphates(OP).Pesticideexposures
wereestimatedusingthepurexposure[57]packageinR.Weappliedinversedistance
weightingtothetotalreportedpesticideamountoverthreemonthspriortobaselinespirome-
trytests(asPURreportsareaggregatedquarterly)toestimateexposureswithina3kmbuffer
ofeachchild’sresidence.Pesticideexposureswerealsohighlyskewedandsoweresquare-root
transformedandthenscaledtohavemean0andvariance1.
ExposuredatasummarystatisticsareshowninTable1.StrongSpearmancorrelation
existedbetweenNO andPM (ρ=0.88)andbetweenNO andPM (ρ=0.72).Moderate
|     |     |     |     | 2   | 2.5 |     |     | 2   | 10  |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
SpearmancorrelationexistedbetweenPM andPM (ρ=0.67),O andNO (ρ=-0.63),O
|     |     |       |             |                          |     | 2.5 | 10  |                    | 3 2 |     | 3   |
| --- | --- | ----- | ----------- | ------------------------ | --- | --- | --- | ------------------ | --- | --- | --- |
|     |     | andPM | (ρ=-0.54),O | andOP(ρ=0.53),andOPandNO |     |     |     | (ρ=-0.53)(Table2). |     |     |     |
|     |     |       | 2.5         | 3                        |     |     |     | 2                  |     |     |     |
Table2.Spearmancorrelationamongallpairsofairpollutantandpesticideexposures.
|      | MeBr |     | OP    |     | O    | 3   | NO 2  |     | PM 2.5 |     | PM 10 |
| ---- | ---- | --- | ----- | --- | ---- | --- | ----- | --- | ------ | --- | ----- |
| C    | 0.27 |     | 0.12  |     | 0.09 |     | 0.08  |     | 0.06   |     | 0.01  |
| MeBr |      |     | -0.08 |     | 0.02 |     | 0.07  |     | -0.03  |     | -0.13 |
| OP   |      |     |       |     | 0.53 |     | -0.53 |     | -0.38  |     | -0.24 |
| O 3  |      |     |       |     |      |     | -0.63 |     | -0.54  |     | -0.22 |
| NO   |      |     |       |     |      |     |       |     | 0.88   |     | 0.72  |
2
| PM 2.5 |     |     |     |     |     |     |     |     |     |     | 0.67 |
| ------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---- |
https://doi.org/10.1371/journal.pone.0249236.t002
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 4/21

PLOS ONE
Modelchoiceforchemicalmixtures
Statisticalmethods
Ourprimaryinterestwastoestimatetheassociationbetweenexposurestoppollutantsx =
i
)Tandacontinuousoutcomey,whilecontrollingforqpotentialconfoundersw
| (x i1 ,...,x |     |     |     | =   |
| ------------ | --- | --- | --- | --- |
| ip           |     | i   |     | i   |
(w ,...,w )Tinasamplei=1,...,n.Weconsideredfiverecentlyproposedmethods.The
i1 iq
firsttwoaretheAMEmodelnonparametricBayesshrinkagewithmaineffectsonly(NPBr)
andtheEMMmodelnonparametricBayesshrinkagewithmaineffectsandallpairwisemulti-
plicativeinteractions(NPB)asproposedbyHerring[19].Thenexttwomodelsareunsuper-
vised(UPR)andsupervisedBayesianprofileregression(SPR)asproposedbyMolitoretal.
[58].ThefifthistheNPmodelBayesiankernelmachineregression(BKMR)[36].Wechose
thesemethodssincetheyrepresentthefiveclassesidentifiedbyDavalosetal.[17]andare
recentlydevelopedBayesianmethodsforestimatinghealthoutcomesassociatedwithexposure
tomixtures.Thesefivemethodscoveravarietyofexposure-responsefunctionshapes,handle
multicollinearityinvariousways,andincludeoptionsforvariableselection.BKMRispre-
sentedexactlyasproposedbyBobbetal.[36];NPBandSPRhavebeenmodifiedtoaccommo-
datethecontinuousoutcomewithnormalresidualsratherthanthelogisticmodeloriginally
proposedbyHerring[19]andMolitoretal.[58],respectively;andNPBrandUPRarefurther
modificationsofthosepreviouslyintroducedmethods.Forabaselinecomparison,wealso
includedanormallinearmodelwithmaineffectsonly(LM)andwithallpairwiseinteractions
(LM-int),bothestimatedwithleastsquares.Allmodelsconsideredinthispaperhavetheform
|     | y ¼hðxÞþwTgþ�; |     |     | ð1Þ |
| --- | -------------- | --- | --- | --- |
|     | i              | i i | i   |     |
areindependentN(0,σ2)andh(x)representstheexposure-responsefunction.All
where�
| i   |     | i   |     |     |
| --- | --- | --- | --- | --- |
modelswerefitinRversion3.6.0[59].
NonparametricBayesshrinkage. NonparametricBayesshrinkage[19]wasoriginally
introducedasalogisticregressionEMMmodelandwasadaptedtothelinearregressionset-
tingusedhere.Weconsidertwovariations.NPB,originallyproposedbyHerring[19]isan
EMMmodelincludingmaineffectsandallpairwiseinteractions,where
|     | Xp    | Xp(cid:0) 1  | Xp       |     |
| --- | ----- | ------------ | -------- | --- |
|     | hðxÞ¼ | x b þ        | x x z :  | ð2Þ |
|     | i     | ij j         | ij ik jk |     |
|     |       | j¼1 j¼1k¼jþ1 |          |     |
NPBrisareducedAMEmodelnotoriginallyproposedinHerring[19]thatincludesonly
maineffects:
Xp
|     |     | hðxÞ¼ x | b:   | ð3Þ |
| --- | --- | ------- | ---- | --- |
|     |     | i       | ij j |     |
j¼1
BothmodelsplaceaDirichletProcess(DP)prioronregressioncoefficients.Thebasedistri-
butionoftheDPisafinitemixtureofanormaldistributionandapointmassat0toinduce
sparsityinthemodel.Hence,somecoefficientsaresetexactlyto0,effectivelyselectingoutvar-
iablesthatdonotcontributetothehealthoutcome.Correlatedexposurescanbeclusteredand
assignedequalregressioncoefficientstoreducevariance[19,60].Thiseffectivelyreparame-
terizesthemodeltohaveasingleeffectforthesumoftwocorrelatedpredictorsandisparticu-
larlyadvantageousinsituationswhereitisdifficulttodifferentiatetheeffectsoftwohighly
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 5/21

PLOS ONE
Modelchoiceforchemicalmixtures
correlatedpredictors.TheDPpriorformaineffectsisconstructedas:
|     |     | bjD     | � D ; | j¼1;...p          |     | ð4Þ |
| --- | --- | ------- | ----- | ----------------- | --- | --- |
|     |     | j 1     | 1     |                   |     |     |
|     |     | ja      | ;D �  | DPða Þ            |     |     |
|     |     | D       |       | D                 |     |     |
|     |     | 1       | 1 01  | 1 01              |     |     |
|     |     | D jp ;G | ¼ p   | d þð1(cid:0) p ÞG |     |     |
|     |     | 01 01   | 1     | 01 0 01 1         |     |     |
|     |     |         | ;�2   | ;�2Þ;             |     |     |
|     |     | G       | jm �  | Nðm               |     |     |
|     |     | 1       | 1 1   | 1 1               |     |     |
whereδ 0 representstheDiracdeltafunctionat0.Themodeliscompletedwithstandard
| hyperpriorsα | *Gamma(α | ,β ),π | *Beta(α | ,β ),m �Nð0;s2 | Þ,and |     |
| ------------ | -------- | ------ | ------- | -------------- | ----- | --- |
|              | 1        | α1 α1  | 01      | π1 π1 1        | m1    |     |
�(cid:0) 2 �Gammaða ;b Þ.TheDPpriorforinteractionsissimilarlyconstructed.Specifically,
| 1   | �1 �1 |         |                 |                   |     |     |
| --- | ----- | ------- | --------------- | ----------------- | --- | --- |
|     | z jD  | � D ;   | j¼1;...p(cid:0) | 1&k¼jþ1;...;p     |     | ð5Þ |
|     | jk    | 2 2     |                 |                   |     |     |
|     |       | ja      | ;D �            | DPða Þ            |     |     |
|     |       | D       |                 | D                 |     |     |
|     |       | 2       | 2 02            | 2 02              |     |     |
|     |       | D jp ;G | ¼ p             | d þð1(cid:0) p ÞG |     |     |
|     |       | 02 02   | 2               | 02 0 02 2         |     |     |
|     |       |         | ;�2             | ;�2Þ:             |     |     |
|     |       | G       | jm �            | Nðm               |     |     |
|     |       | 2       | 2 2             | 2 2               |     |     |
,and�(cid:0) 2comefromthesamefamiliesspecifiedforthemain
| Thehyperpriorsonα | ,π  | ,μ   |     |     |     |     |
| ----------------- | --- | ---- | --- | --- | --- | --- |
|                   | 2   | 02 2 | 2   |     |     |     |
effects.Thedistributionsonthemaineffectsandinteractionsareindependentapriori.
Posteriorinclusionprobabilities(PIPs)arecalculatedforeachmixturecomponentasthe
posteriorprobabilityoftheregressioncoefficientbeingassignedanon-zerovalue.BothNPBr
andNPBwerefitusingtheRpackagemmpack[44].
| Bayesianprofileregression. |     | Bayesianprofileregressionisadimensionreduction |     |     |     |     |
| -------------------------- | --- | ---------------------------------------------- | --- | --- | --- | --- |
approachthatclassifiespollutantexposureprofiles,x,intoaparsimonioussetofclustersusing
i
aDPmixturemodel(DPMM)[58,61].Eachclusterrepresentsagroupofobservationswith
similarexposurelevelsacrossthevectorofpollutants.Thehealthoutcomeisregressedonclus-
terindicatorstoestimate
|     |     |     | hðxÞ¼y |     |     | ð6Þ |
| --- | --- | --- | ------ | --- | --- | --- |
i c
ifprofilex isassignedtoclusterc.Weintroducealatentvariablez =cifexposureprofileiis
|     | i   |     |     |     | i   |     |
| --- | --- | --- | --- | --- | --- | --- |
assignedtoclusterc.Conditionalonclusterassignment,themodelforanindividualexposure
profileis
|     |     | xjz ¼c;m;S |     | � Nðm;SÞ |     | ð7Þ |
| --- | --- | ---------- | --- | -------- | --- | --- |
|     |     | i i        | c c | c c      |     |     |
|     |     |            | m � | Nðn ;L Þ |     |     |
|     |     |            |     | 0 0      |     |     |
c
|     |     | S(cid:0) | 1 � Wish | ðR;rÞ: |     |     |
| --- | --- | -------- | -------- | ------ | --- | --- |
|     |     |          | c        | p      |     |     |
TheDPMMforclusterassignmentplacesatruncatedstick-breakingpriorontheassignment
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 6/21

PLOS ONE
Modelchoiceforchemicalmixtures
probabilitiestoeachcluster.Thestick-breakingprocessandclusterassignmentmodelare
|     |     | V ;...;V | ja         | � Betað1;aÞ; |      | V ¼1 |     | ð8Þ |
| --- | --- | -------- | ---------- | ------------ | ---- | ---- | --- | --- |
|     |     | 1        | C(cid:0) 1 |              |      | C    |     |     |
|     |     |          | a �        | Gammaða      | ;b Þ |      |     |     |
|     |     |          |            |              | a a  |      |     |     |
Yc(cid:0) 1
|     |     | Pðz | ¼cÞ¼c | ¼   | ð1(cid:0) | Þ   |     |     |
| --- | --- | --- | ----- | --- | --------- | --- | --- | --- |
|     |     |     |       |     | V         | V   |     |     |
|     |     |     | i     | c   | c         | h   |     |     |
h¼1
|     |     |     | z � | CategoricalðcÞ: |     |     |     |     |
| --- | --- | --- | --- | --------------- | --- | --- | --- | --- |
i
SubjecttoamaximumofCclusters,theDPMMallowsthenumberofnon-emptyclustersto
beestimatedfromthedata.Toidentifythemostoptimalpartitioningofthedata,wefollowthe
approachdescribedinDahl[62]andMolitoretal[58].First,weconstructann×nscore
matrixateachiterationwitha1inthei,jlocationifindividualsiandjbelongtothesameclus-
teranda0otherwise.ThenwecalculateaprobabilitymatrixSbyaveragingthescorematrices.
ThemostoptimalclusteringistheclusteringfromtheMCMCiterationthathasascorematrix
withminimumleastsquareddistancetotheprobabilitymatrixS.Wecalculatemodelaveraged
estimatesofthecluster-specificparametersθ toincorporatetheuncertaintypresentinthe
c
bestclustering[58].
Themodelhasbeenextendedtoincludevariableselectiontoidentifymixturecomponents
activelycontributingtoclusterassignment[63–65].Briefly,binaryrandomvariablesareintro-
ducedthatindicatewhetherthemeanforamixturecomponentwithinaclusterisuniqueto
thatclusterorcommonamongallclusters.Hence,mixturecomponentsthatareselectedinto
themodelareinterpretedasbeinginformativeinpartitioningtheexposuredataintoclusters,
butarenotnecessarilyrelatedtothehealthoutcome.
Weconsidertwovariationsofprofileregression.Thefirst,supervisedprofileregression
(SPR),originallyintroducedbyMolitoretal.[58]belongstotheSDRclassofmethodssince
clusterassignmentsareinfluencedbythehealthoutcome.Thesecondisanunsupervised
adaptation(UPR)notoriginallyproposedbyMolitoretal.[58]thatbelongstotheUDRclass.
Thedifferencebetweenthetwovariationsmanifestswhenthelatentclusterassignmentvari-
ablez isupdated.Inthesupervisedcase,wejointlymodeltheresponseandestimatecluster
i
assignments.Hence,thereisfeedbackbetweenthehealthoutcomemodelandtheprofile
assignmentmodelwherethehealthoutcomescaninfluenceclusterassignment.Thefullcondi-
tionalforz dependsonboththelikelihoodofexposuresx andthelikelihoodoftheresponse
| i   |     |     |     |     | i   |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
y:
i
|               |     |     | cfðxjz | ¼c;m;SÞfðyjz       |     | ¼c;y;b;s2Þ |     |     |
| ------------- | --- | --- | ------ | ------------------ | --- | ---------- | --- | --- |
| Pðz ¼cjx;y;�Þ |     | ¼   | P c    | i i                | c c | i i        | c : | ð9Þ |
| i             | i i |     | C      |                    |     |            |     |     |
|               |     |     | c      | fðxjz ¼c;m;SÞfðyjz |     | ¼c;y;b;s2Þ |     |     |
|               |     |     | c¼1 c  | i i                | c c | i i        | c   |     |
Hence,inSPR,individualswithsimilarexposureprofilesbutdifferenthealthoutcomes
maybeassignedtodifferentclustersdependingontheirresponses.
Theunsupervisedcaseinvolvesatwo-stepprocedurewherewefirstestimateclusterassign-
mentsindependentlyoftheresponseandthenmodeltheresponseconditionaloncluster
assignment.Here,z dependsonlyontheexposurelikelihood:
i
|     |     |         |     | cfðxjz | ¼c;m;SÞ |     |     |      |
| --- | --- | ------- | --- | ------ | ------- | --- | --- | ---- |
|     | Pðz | ¼cjx;�Þ | ¼   | P c    | i i     | c c | :   | ð10Þ |
|     |     | i       | i   | C      |         |     |     |      |
cfðxjz ¼c;m;SÞ
|     |     |     |     | c¼1 c | i i | c c |     |     |
| --- | --- | --- | --- | ----- | --- | --- | --- | --- |
SincetheresponsedoesnotinformclusterassignmentinUPR,theremaybehighuncertainty
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 7/21

PLOS ONE
Modelchoiceforchemicalmixtures
intheestimatesoftheclusterindicatorsθ ifindividualswithsimilarexposureprofileshave
c
verydifferenthealthoutcomes.
WefitSPRusingtheRpackagePReMiuM[65]andUPRusingtheRpackagemmpack
developedforthispaper[44].
Bayesiankernelmachineregression. Bayesiankernelmachineregression(BKMR)[36]
belongstotheNPclassofmethodsandflexiblymodelstheexposure-responsefunctionto
allowfornonlinearassociationsandhigherorderinteractions.InBKMR,h(x)isasmooth
functionrepresentedusingaGaussiankernel.Theresponseismodeledas
|     |     |     |     | y � | Nðh | þwTg;s2Þ |     |     |     | ð11Þ |
| --- | --- | --- | --- | --- | --- | -------- | --- | --- | --- | ---- |
|     |     |     |     | i   |     | i        |     |     |     |      |
i
|     |     |     | h�ðh | ;...;h |     | ÞT � Nð0;tKÞ; |     |     |     |     |
| --- | --- | --- | ---- | ------ | --- | ------------- | --- | --- | --- | --- |
|     |     |     |      | 1      | n   |               |     |     |     |     |
P
|                                               |     |     |     |     |     |      |             | p     | Þ2g,τisa  |     |
| --------------------------------------------- | --- | --- | --- | --- | --- | ---- | ----------- | ----- | --------- | --- |
| whereKisthekernelmatrixwith(i,i0)elementKðx;x |     |     |     |     |     | Þ¼   | expf(cid:0) | rðx   | (cid:0) x |     |
|                                               |     |     |     |     |     | i i0 |             | j¼1 j | ij i0j    |     |
)Tarevariableselectionparameters.Estimatedhealthout-
| hyperparameter,andr=(r |     |     | ,...,r |     |     |     |     |     |     |     |
| ---------------------- | --- | --- | ------ | --- | --- | --- | --- | --- | --- | --- |
|                        |     |     | 1      | p   |     |     |     |     |     |     |
comesforindividualswithsimilarexposurelevelsacrosstheppredictorsareshrunktowards
eachother,resultinginasmoothbutflexibleexposure-responsefunction.
BKMRallowsforbothcomponent-wiseandhierarchicalvariableselection(HVS)toiden-
tifyimportantmixturecomponents.Inoursimulationanddataanalysis,weimplemented
component-wisevariableselectionandcalculatedPIPsforeachexposure.Wealsoimple-
mentedHVSinourdataanalysistoaddresssensitivityofresults.Wepartitionedthemixture
componentsintogroupsofairpollutants(PM ,PM ,NO ,andO )andpesticides(C,
|     |     |     |     |     |     | 2.5 10 | 2   | 3   |     |     |
| --- | --- | --- | --- | --- | --- | ------ | --- | --- | --- | --- |
MeBr,andOP)andcalculatedPIPsforeachgroup(groupPIPs)andeachcomponentwithina
group,conditionalongroupinclusion(conditionalPIPs).WefitBKMRusingtheRpackage
bkmr[66].
Simulationstudydesign
Weevaluatedtheproposedmethodsinasimulationstudy.Weensurearealisticcorrelation
structureamongthepollutantsbyusingtheobservedexposuredatafrom153individualsin
theFACESdatasetinoursimulationstudy.Wealsousetheobservedcovariatedatainour
simulationstudy.Healthresponsesweresimulatedforthreeexposure-responsescenarios,
denotedh ,k=1,2,3,asy ¼h ðxÞþwTgþε,withε *N(0,1).Thecovariatecoefficients
|     | k   |     |     |     |     | i   |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|     |     |     | i   | k i | i   | i   |     |     |     |     |
γ ,...,γ weresimulatedasindependentN(0,1).
1 q
Thefirstscenario,h (linear),isanEMMmodel.Forexposuresx,j=1,...,4,theexpo-
|     |     | 1   |     |     |     |     |     | j   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
sure-responsefunctionis
|     |     | h ðxÞ¼x |     | (cid:0) x þx | (cid:0) | x þ0:7x x | (cid:0) 0:5x | x : |     | ð12Þ |
| --- | --- | ------- | --- | ------------ | ------- | --------- | ------------ | --- | --- | ---- |
|     |     | 1       |     | 1 2          | 3       | 4 1       | 2            | 3 4 |     |      |
Second,h (nonlinear)includesnonlinearsigmoidalfunctionsofthreepollutantsandamulti-
2
plicativeinteractionbetweentwoofthosepollutants:
|     |        |                | 2   |      | 2           |         | 2           |              |     |      |
| --- | ------ | -------------- | --- | ---- | ----------- | ------- | ----------- | ------------ | --- | ---- |
|     | h ðxÞ¼ |                |     | þ    |             | (cid:0) |             | (cid:0) 0:4x | x : | ð13Þ |
|     | 2      | 1þ expð(cid:0) | 3x  | Þ 1þ | expð(cid:0) | 5x Þ 1þ | expð(cid:0) | 5x Þ         | 1 2 |      |
|     |        |                |     | 1    |             | 2       |             | 3            |     |      |
Last,h 3 (fixedprofiles)groupsindividualsintofourdistinctclustersbasedondichotomous
cut-offsfortwopollutants.Weassignaconstanthealtheffecttoindividualsinthesame
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 8/21

PLOS ONE Modelchoiceforchemicalmixtures
cluster:
8
>>>>>>>< (cid:0)
(cid:0)
2
1
;
;
x
x
1
�
�
m
m
e
e
d
d
i
i
a
a
n
n
ð
ð
x
x
1
Þ
Þ
a
a
n
n
d
d
x
x
2
�
>
m
m
e
e
d
d
i
i
a
a
n
n
ð
ð
x
x
2
Þ
Þ
1 1 2 2
h ðxÞ¼ ð14Þ
3 >>>>>>>:
0; x
1
>medianðx
1
Þ and x
2
�medianðx
2
Þ
2; x >medianðx Þ and x >medianðx Þ:
1 1 2 2
Weselectedthesethreeexposure-responsescenariostocatertodifferentmethodsinour
simulationstudy.ThelinearscenarioplaystoNPBrandNPB,thenonlinearscenarioplaysto
BKMR,andthefixedprofilesscenarioplaystoUPRandSPR.Wehypothesizethatthemeth-
odstowhicheachscenariocaterswillperformbestinthatscenario.Weareinterestedinevalu-
atinghowmethodsperforminexposure-responsescenariosforwhichtheywerenotexplicitly
developed.
Wesimulated200datasetsforeachscenarioandfitallfiveBayesianmethodsplusLMand
LM-int.Asresultscanbesensitivetowhichpollutants,x,j=1,...,4,areincludedinh(x),we
j
randomlyselectedpollutantstobetheactivecomponentsineachsimulateddataset.Allpol-
lutants,eventhosenotselectedasoneoftheactivecomponents,areincludedasinputsinthe
estimatedmodels.Byrandomlyselectingwhichexposuresaretheactivecomponentsofthe
mixture,eachsimulateddatasethasadifferentcorrelationstructureamongtheactiveexpo-
sures,whichaddsrobustnesstooursimulationstudyresults.WecalculatedtheCalinski-Hara-
baszindex[67],thesilhouettestatistic[68],andthenumberofclusterstomaximizethegap
width[69]tomeasurethegroupingstructureofthedatageneratedbythefixedprofilessce-
nario.Althoughtheexposuredataremainsthesameforeachdataset,theexposuresusedin
theexposure-responsefunctiondifferforeachdataset;hencetheclusteringinthefixedpro-
filesscenario,whichisbasedontheresponse,differsforeachdataset.Acrossthe200datasets
usedinoursimulationstudy,themedianCalinski-Harabaszindexwas22.54,themediansil-
houettewas0.15,andthemediannumberofclusterstomaximizethegapwidthwas6.The
distributionofeachofthesestatisticscanbefoundinS2TableinS1File.Ingeneral,thefixed
profilesscenariodidnotalwaysgenerateastronggroupingstructurewiththisdata,butinstead
representsawidevarietyofclusteringschemes.
Weevaluatedexposure-responsefunctionestimationusingrootmeansquarederror
qffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffi
P
(RMSE)andintervalcoverage(Cvg).RMSEwascalculatedas 1 n ½hðxÞ(cid:0) h ^ðxÞ�2and
n i¼1 i i
coveragewascalculatedasthepercentofh(x)’scoveredby95%credibleorconfidenceinter-
i
vals.RMSEmeasuresthevariationbetweenestimatedandtruevaluesoftheexposure-response
function.Coveragemeasureshowoftenthe95%credibleorconfidenceintervalsfortheesti-
matedexposure-responsefunctioncapturethetruemixtureeffect.AmethodwithhighRMSE
andlowcoveragefailstocapturetheoverallmixtureeffect.Inthisway,RMSEandcoverage
measuretheabilityofeachmethodtocapturetheoverallmixtureeffect.
Wesummarizedvariableselectionthroughtrueandfalseselectionrates.IntheBayesian
methods,weconsideravariablewithaPIPabove0.5asselectedintothemodel[70].InLM
andLM-int,avariableisselectedifthe95%confidenceintervalfortherespectiveregression
coefficientdoesnotcontain0.Wecalculatedtrueselectionrate(TSR)astheproportionof
mixturecomponentsactiveintheexposure-responsefunctionasmaineffectsthatwere
selectedintothemodelasmaineffects,andfalseselectionrate(FSR)astheproportionofmix-
turecomponentsnotintheexposure-responsefunctionasmaineffectsthatwereselectedinto
themodelasmaineffects.Allsevenexposuresareincludedinthemodelsasinputs,butthe
activemixturecomponentsarethosethatdefinetheexposure-responsefunctionforeach
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 9/21

PLOS ONE Modelchoiceforchemicalmixtures
simulateddataset.Forscenario1,theactivemaineffectsaretherandomlyselectedexposures
denotedbyx ,x ,x ,andx ;forscenario2,theactivemaineffectsarex ,x ,andx ;andfor
1 2 3 4 1 2 3
scenario3theactivemaineffectsarex andx .Inmostmethods(NPBr,UPR,SPR,BKMR,
1 2
andLM),TSRandFSRarecalculatedonlyformaineffects.InNPBwecancalculatePIPsfor
interactionsandinLM-intwecancalculateconfidenceintervalsfortheinteractioneffects.
Hence,wealsoevaluatevariableselectionratesforinteractionsinNPBandLM-int.We
calculatetrueselectionrateforinteractions(TSR )astheproportionoftheexactpairwise
int
interactionsactiveintheexposureresponsefunctionthatwereselectedintothemodelas
interactions,andfalseselectionrateforinteractions(FSR )astheproportionofinteractions
int
thatwerenotactiveintheexposure-responsefunctionthatwereselectedintothemodelas
interactions.Inscenario1,thetrueactiveinteractionsarex x andx x andinscenarios2
1 2 3 4
and3theonlyactiveinteractionisx x .
1 2
Weassessedconvergenceforafewsimulateddatasetsbyvisualizingtraceplotsandcom-
paringresultsfrommultiplechains.Wefoundevidenceofconvergenceby20,000iterations
forallmethods.Toensureconvergenceacrossallsimulateddatasets,webasedinferenceon
25,000samplesafteraburn-inof25,000samples.
Weconductedthreeadditionalsimulationstudiestofurtherassessmethodperformance.
First,weconsideredanullscenario,h (x),wherenoneoftheexposuresareassociatedwiththe
4
response.Second,weconsideredacomplexmixturescenario,h (x),wherewesimulateddata
5
forsevenadditionalpollutantstohaveatotalof14mixturecomponents.Third,weapplied
ouroriginalsimulationstudydesigntoalargersampleofsizen=1000foreachdataset.
DetailsontheadditionalsimulationscanbefoundinS1AppendixinS1File.
Dataanalysis
Weconductedadataanalysison153individualswithcompletedataintheFACESdataset.
Weusedregression-adjustedFEV astheoutcome.S1TableinS1Filesummarizesthecharac-
1
teristicsofthesample.Pesticideandairpollutantexposuresandcovariatedatawereidentical
tothatinoursimulationstudy(Tables1,2,andS1TableinS1File).Wefitthesamemodelsas
inthesimulationstudy.PriorspecificationfortheBayesianmodelsislistedinS2Appendixin
S1File.
Results
Simulationstudyresults
SimulationresultsareshowninTable3.StandarderrorsareshowninS3–S5TablesinS1File.
Weshowthecomputationaltimeforeachmethodtorunfor5000iterationsinTable4.
OverallBKMRandNPBwerethebestperformingmethodswithBKMRperformingslightly
betterinthenonlinearandfixedprofilesscenarios.RegardingRMSEfortheexposure-
responsefunction,BKMR(RMSE=0.55)andNPB(RMSE=0.54)tiedforlowestinthelinear
scenario.Inthenonlinearscenario,BKMR(RMSE=0.59)pulledslightlyaheadofNPB
(RMSE=0.69),whileinthefixedprofilesscenario,BKMR(RMSE=0.69)outperformedall
othermethodsbyasubstantialmargin.UPRhadthehighestRMSEinallthreescenarioswith
SPRhavingthesecondhighestRMSE.
InadditiontohavingthelowestRMSEinallthreescenarios,BKMRconsistentlyhadinter-
valcoverageclosesttothenominallevel.LM-intalsohadintervalcoveragenearthenominal
levelinallthreescenariosandNPBperformedwellinthelinearscenario.BKMR(Cvg=0.96),
NPB(Cvg=0.95),andLM-int(Cvg=0.95)allachievedthenominalcoveragelevel(0.95)in
thelinearscenario.Inthenonlinearscenario,BKMR(Cvg=0.92)andLM-int(Cvg=0.91)
cameclosesttothenominallevel,withNPBnextbestbuttrailingbehind(Cvg=0.86).BKMR
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 10/21

PLOS ONE
Modelchoiceforchemicalmixtures
Table3.Summaryofmethodperformanceinthreedata-generatingscenarios.Tableshowsmeansacrossalldatasetsfor:rootmeansquarederror(RMSE),coverage
(Cvg),trueselectionrateformaineffects(TSR),falseselectionrateformaineffects(FSR),trueselectionrateforinteractions(TSR ),andfalseselectionrateforinterac-
int
tions(FSR int ).Top-performingmethodswillhavelowRSME,coveragenearthenominallevel(0.95),highTSRandlowFSR.Foreachmeasureandexposure-responsesce-
nario,resultsfromthetop-performingmethod(s)arelistedinbold.
| Method | RMSE | Cvg | TSR | FSR | TSR int | FSR int |
| ------ | ---- | --- | --- | --- | ------- | ------- |
h1 (x):linearwithmultiplicativeinteractions
| NPBr   | 1.02 | 0.73 | 0.85 | 0.35 | –    | –    |
| ------ | ---- | ---- | ---- | ---- | ---- | ---- |
| NPB    | 0.54 | 0.95 | 0.92 | 0.10 | 0.59 | 0.02 |
| UPR    | 2.01 | 0.56 | 0.25 | 0.26 | –    | –    |
| SPR    | 1.59 | 0.54 | 0.63 | 0.53 | –    | –    |
| BKMR   | 0.55 | 0.96 | 1.00 | 0.39 | –    | –    |
| LM     | 1.01 | 0.73 | 0.84 | 0.29 | –    | –    |
| LM-int | 0.73 | 0.95 | 0.68 | 0.04 | 0.32 | 0.04 |
h2 (x):nonlinearwithmultiplicativeinteractions
| NPBr   | 0.77 | 0.80 | 0.79 | 0.22 | –    | –    |
| ------ | ---- | ---- | ---- | ---- | ---- | ---- |
| NPB    | 0.69 | 0.86 | 0.78 | 0.16 | 0.25 | 0.01 |
| UPR    | 1.42 | 0.56 | 0.27 | 0.24 | –    | –    |
| SPR    | 1.27 | 0.58 | 0.68 | 0.58 | –    | –    |
| BKMR   | 0.59 | 0.92 | 0.96 | 0.48 | –    | –    |
| LM     | 0.78 | 0.81 | 0.78 | 0.17 | –    | –    |
| LM-int | 0.89 | 0.91 | 0.54 | 0.08 | 0.20 | 0.07 |
h3 (x):constantfunctionoffixedprofiles
| NPBr   | 1.11 | 0.66 | 0.66 | 0.11 | –    | –    |
| ------ | ---- | ---- | ---- | ---- | ---- | ---- |
| NPB    | 1.02 | 0.75 | 0.68 | 0.13 | 0.06 | 0.02 |
| UPR    | 1.41 | 0.55 | 0.27 | 0.25 | –    | –    |
| SPR    | 1.38 | 0.54 | 0.68 | 0.59 | –    | –    |
| BKMR   | 0.69 | 0.91 | 0.97 | 0.64 | –    | –    |
| LM     | 1.13 | 0.70 | 0.69 | 0.14 | –    | –    |
| LM-int | 0.99 | 0.91 | 0.56 | 0.14 | 0.12 | 0.11 |
https://doi.org/10.1371/journal.pone.0249236.t003
(Cvg=0.91)andLM-int(Cvg=0.91)hadthehighestcoveragebyfarinthefixedprofilessce-
nario.Again,UPRandSPRperformedpoorlywiththelowestcoverageinallthreescenarios.
Thestoryismorecomplexwhenitcomestovariableselection.WhileBKMRhadthehigh-
estTSRinallthreescenarios,italsohadthehighestFSR.Again,NPBperformedverywellin
thelinearscenariobutnotaswellintheotherscenarios,whileUPRandSPRhadconsistently
poorselectionrates.RegardingTSR,BKMR(TSR=1.00)andNPB(TSR=0.92)performed
bestinthelinearscenario.BKMRhadthehighestTSRinthenonlinearscenario(TSR=0.96),
wherethenextbestmethods,NPBr,NPB,andLM,allhadmeanTSRjustunder0.80.BKMR
issingledoutwiththebestTSRinthefixedprofilesscenario(TSR=0.97).UPR,SPR,and
LM-inttendedtohavelowTSRinallthreescenarios.
Table4.Computationaltimeforeachmethodtorun5000iterationsonMacBookProinRversion3.6.1.Timeis
reportedinseconds.Resultsreflect10evaluationsofeachmethod.
|     |     | method | minimum |     | mean   | maximum |
| --- | --- | ------ | ------- | --- | ------ | ------- |
|     |     | NPBr   | 6.90    |     | 7.03   | 7.17    |
|     |     | NPB    | 24.73   |     | 24.95  | 25.23   |
|     |     | BKMR   | 219.43  |     | 222.96 | 235.41  |
|     |     | UPR    | 57.82   |     | 58.66  | 59.50   |
|     |     | SPR    | 90.34   |     | 92.47  | 98.65   |
https://doi.org/10.1371/journal.pone.0249236.t004
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 11/21

PLOS ONE
Modelchoiceforchemicalmixtures
Alowfalseselectionrateindicatesamodeldoesnoterroneouslyclassifyexposuresasasso-
ciatedwiththeoutcomewhentheyarenot.Here,BKMRhadsomeofthehighestFSRacross
thethreescenarios.Inthelinearscenario,LM-int(FSR=0.04)andNPB(FSR=0.10)hadthe
lowestFSR.LM-intalsohadthelowestFSRinthenonlinearscenario(FSR=0.08).Inthe
fixedprofilesscenario,NPBr,NPB,LM,LM-intallhadsimilarFSRatorbelow0.14.Along
withBKMR,SPRhadhighFSRinallthreescenarios.
Whenconsideringoverallvariableselectionperformance,NPBtakesthetopspotinthelin-
earscenario,withhighTSRandlowFSR.Nomethodwasabletosimultaneouslyachievedom-
inantTSRandFSRinthenonlinearorfixedprofilesscenarios.
OnlyNPBandLM-intdirectlyparameterizedvariableselectionforinteractionsinaneasily
interpretablemanner.Interpretablevariableselectionforinteractionsisitselfanadvantageof
theseapproachesovertheothermethods.Inthelinearscenario,NPB(TSR =0.59)had
int
higherTSR thanLM-int(TSR =0.32).BothmethodshadpoorTSR inthenonlinearand
|     |     | int | int |     | int |     |
| --- | --- | --- | --- | --- | --- | --- |
fixedprofilesscenarios,withvaluesatorbelow0.25.RegardingFSR ,bothmethodsper-
int
|     | formedwellinallthreescenarios,withFSR |     |     | consistentlyatorbelow0.11. |     |     |
| --- | ------------------------------------- | --- | --- | -------------------------- | --- | --- |
int
Theadditionalsimulationsproducedsimilarresults,withNPBandBKMRbeingconsis-
tentlytop-performingmethodsintermsofestimatingtheexposure-responsefunctionand
identifyingactivemixturecomponents.Inthenullscenario,NPBrandNPBhadlowestFSR,
meaningthesemethodswerethebestatnotselectinganymixturecomponentsintothemodel
whennonewereassociatedwiththeresponse(S6TableinS1File).Resultsfromthecomplex
mixturescenariolargelymirroredthosefromthelinearscenario(S7TableinS1File).BKMR
andNPBremainedtop-performinginthelargersamplesizesimulationandTSRimprovedfor
allmethods.Here,UPRandSPRhadhighTSRandFSR,meaningtheyoftenselectedallofthe
mixturecomponentsintothemodel(S8TableinS1File).
Dataanalysisresults
TheresultsfromouranalysisoftheFACESdatasetvariedacrossthemethods.Firstwecon-
siderthetraditionalmodelsLMandLM-int.LMshowedevidenceformaineffectsofNO (b^:
2
-0.32,CI:-0.54,-0.10)andPM (b^:0.19,CI:0.02,0.35).LM-intshowedevidenceformain
10
effectsofMeBr(b^:0.17,CI:0.05,0.29),NO (b^:-0.68,CI:-1.10,-0.25),andPM (b^:0.50,CI:
|     |     |     |     | 2   |     | 10  |
| --- | --- | --- | --- | --- | --- | --- |
0.08,0.93)andaninteractionbetweenCandPM (b^:0.28,CI:0.01,0.54)(Table5).The
2.5
Table5.ResultsfromanalysisofFACESdatasetusingLMandLM-int.Tableincludeseffectestimates(b^),95%confidenceintervals,andassociatedp-valuesforall
maineffectsinLMandLM-intplustheinteractioneffectsinLM-intwithp-values�0.10.Theregressioncoefficientb^istheexpectedchangeinFEV
fora1standard
1
deviationincreaseinthesquareroottransformedexposures.
|      |       | LM           |         |       | LM-int       |         |
| ---- | ----- | ------------ | ------- | ----- | ------------ | ------- |
|      | b^    | 95%CI        | p-value | b^    | 95%CI        | p-value |
| C    | 0.04  | (-0.03,0.11) | 0.24    | 0.05  | (-0.08,0.19  | 0.44    |
| MeBr | 0.00  | (-0.06,0.07) | 0.96    | 0.17  | (0.05,0.29)  | 0.01    |
| OP   | 0.05  | (-0.03,0.13) | 0.24    | 0.02  | (-0.17,0.22) | 0.80    |
| O    | -0.06 | (-0.20,0.07) | 0.36    | -0.13 | (-0.32,0.06) | 0.17    |
3
| NO  | -0.32 | (-0.54,-0.10) | 0.01 | -0.68 | (-1.10,-0.25) | 0.00 |
| --- | ----- | ------------- | ---- | ----- | ------------- | ---- |
2
| PM  | -0.01 | (-0.20,0.17) | 0.90 | -0.11 | (-0.48,0.26) | 0.55 |
| --- | ----- | ------------ | ---- | ----- | ------------ | ---- |
2.5
| PM  | 0.19 | (0.02,0.35) | 0.03 | 0.50 | (0.08,0.93) | 0.02 |
| --- | ---- | ----------- | ---- | ---- | ----------- | ---- |
10
| C:PM | –   | –   | –   | 0.28 | (0.01,0.54) | 0.04 |
| ---- | --- | --- | --- | ---- | ----------- | ---- |
2.5
| OP:PM | –   | –   | –   | 0.31 | (-0.01,0.62) | 0.05 |
| ----- | --- | --- | --- | ---- | ------------ | ---- |
10
| NO:PM | –   | –   | –   | 0.33 | (-0.05,0.72) | 0.09 |
| ----- | --- | --- | --- | ---- | ------------ | ---- |
2 10
https://doi.org/10.1371/journal.pone.0249236.t005
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 12/21

PLOS ONE
Modelchoiceforchemicalmixtures
Table6.ResultsfromanalysisofFACESdatasetusingNPBrandNPB.Tableshowsestimates(b^),95%credibleintervals,andposteriorinclusionprobabilities(PIP)for
maineffectexposuresinNPBandNPBr.Theregressioncoefficientb^istheexpectedchangeinFEV fora1standarddeviationincreaseinthesquareroottransformed
1
exposures.AllinteractioneffectsinNPBhadposteriorinclusionprobabilitiesbelow0.12.
|      |      | NPBr         |      |       | NPB          |      |
| ---- | ---- | ------------ | ---- | ----- | ------------ | ---- |
|      | b^   |              |      | b^    |              |      |
|      |      | 95%CI        | PIP  |       | 95%CI        | PIP  |
| C    | 0.00 | (0.00,0.04)  | 0.07 | 0.00  | (0.00,0.03)  | 0.07 |
| MeBr | 0.00 | (-0.02,0.00) | 0.06 | 0.00  | (-0.01,0.00) | 0.06 |
| OP   | 0.02 | (0.00,0.12)  | 0.21 | 0.01  | (0.00,0.11)  | 0.16 |
| O    | 0.00 | (-0.08,0.02) | 0.11 | -0.01 | (-0.12,0.01) | 0.11 |
3
| NO  | -0.08 | (-0.35,0.00) | 0.47 | -0.12 | (-0.36,0.00) | 0.60 |
| --- | ----- | ------------ | ---- | ----- | ------------ | ---- |
2
| PM  | 0.00 | (-0.08,0.06) | 0.13 | 0.00 | (-0.09,0.05) | 0.12 |
| --- | ---- | ------------ | ---- | ---- | ------------ | ---- |
2.5
| PM  | 0.02 | (0.00,0.21) | 0.21 | 0.02 | (-0.01,0.20) | 0.19 |
| --- | ---- | ----------- | ---- | ---- | ------------ | ---- |
10
https://doi.org/10.1371/journal.pone.0249236.t006
resultsfromthelinearmodelsindicatingaprotectiveeffectofPM arecounter-intuitiveas
10
thereisanextensiveliteratureonthedeleterioushealtheffectsofPMonlungfunction.None
oftheothermethodsfoundevidenceofprotectiveeffectsforanyoftheexposures.
Nextweconsiderthefivecontemporarymethods.NPBrdidnotidentifyanyexposures
withPIPsabove0.5.TheexposurewiththehighestPIPwasNO (PIP=0.47),whichwasesti-
2
matedtobenegativelyassociatedwithFEV (b^:-.08,CI:-0.35,0.00).InNPB,NO was
|     |     |     |     | 1   |     | 2   |
| --- | --- | --- | --- | --- | --- | --- |
selected(PIP=0.60)andwasalsonegativelyassociatedwithFEV (b^:-0.12,CI:-0.36,0.00)
1
(Table6).Noothermaineffectsorinteractionswereselectedbyeithermethod(S10Tablein
S1File).
InBKMR,NO wasselectedasanimportantmixturecomponentwithaPIPof0.96(S11
2
TableinS1File).NootherexposureshadPIPsabove0.5.ResultsweresimilarusingtheHVS
formulation(S12TableinS1File).NO hadanegativeandnonlinearassociationwithFEV
|     |     |     |     | 2   |     | 1   |
| --- | --- | --- | --- | --- | --- | --- |
(Fig1).Toidentifyinteractions,weplottheposteriordistributionoftheexposure-response
functionforeachpairofexposures,holdingallotherexposuresconstantattheirmedianval-
ues,andvisuallyinspectchangesintheresponseasbothexposureschange.Indoingsowe
foundnonotableinteractionsamongexposures(S1FiginS1File).
Asclusteringalgorithms,UPRandSPRrevealadifferentkindofstory.UPRrevealedfour
clustersasthebestpartitioningofthedata.Eachclusterhadsimilarestimatedhealtheffects
(Fig2a);hence,despitepartitioningtheexposurespacetherewasnomeaningfulassociation
betweentheexposureprofilesandthehealthoutcome.Fig2b–2eshowstheempiricalexposure
meansforindividualsassignedtoeachcluster.Thefirstclusterofn=25individualswasdis-
tinguishedbyhigherthanaverageexposuretoMeBr.Cluster2(n=33)hadlowexposureto
OPandO andhighexposuretoNO andPM relativetotheaverage.Thethirdcluster
|     |     | 3   | 2   | 2.5 |     |     |
| --- | --- | --- | --- | --- | --- | --- |
(n=9)wascharacterizedbyrelativelyhighexposuretoOPandlowexposuretoO .Individu-
3
alsincluster4(n=86)hadnearlyaverageexposuretomostpollutantsexceptMeBR,which
wasnotablybelowaverage;inaddition,O 3 exposurewasslightlyaboveandPM 2.5 exposure
wasslightlybelowaverage.UPRselectedOP(PIP=0.57),O (PIP=0.54),NO (PIP=0.61),
|     |     |     |     | 3   | 2   |     |
| --- | --- | --- | --- | --- | --- | --- |
andPM (PIP=0.56)asimportantmixturecomponents(S13TableinS1File).
2.5
SPRalsorevealedfourclustersasthebestpartitioningofthedata.Theestimatedexposure-
responsefunctionforcluster3,thesmallestcluster(n=9),hada0.97posteriorprobabilityof
beinggreaterthantheoverallmeanestimatedexposure-responsefunction(Fig3a).Thecluster
samplesizesandassociatedempiricalexposuremeanswereverysimilartothoseinUPR(Fig
3b–3e),withthelabelsswitchedforclusters1and4.InbothUPRandSPR,cluster3wasthe
smallestclusterandhadanestimatedmeanhealtheffecthigherthanaverage,buttherewas
moreuncertaintyaroundthehealtheffectinUPRlikelyduetothetwo-stageapproachfor
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 13/21

PLOS ONE Modelchoiceforchemicalmixtures
Fig1.ResultsfromanalysisofFACESdatasetusingBKMR.Figureshowstheunivariaterelationshipbetweeneachexposure
andFEV,holdingallotherexposuresattheirmedianvalue.
1
https://doi.org/10.1371/journal.pone.0249236.g001
Fig2.ResultsfromanalysisofFACESdatasetusingUPR.Panel(a)showsthedistributionofthemodelaveragedestimated
exposure-responsefunction(θ)foreachclusteridentifiedinthebestclusteringbyUPR.Thedottedlinerepresentstheoverall
c
meanestimatedexposure-responsefunctionacrossallclusters.Panels(b-e)showtheempiricalexposuremeansofthe
individualsassignedtoeachclusterinthebestclustering,with1standarddeviationerrorbars.Thedottedlinesaredrawnat0,
themeanofthestandardizedexposuredata.
https://doi.org/10.1371/journal.pone.0249236.g002
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 14/21

PLOS ONE Modelchoiceforchemicalmixtures
Fig3.ResultsfromanalysisofFACESdatasetusingSPR.Panel(a)showsthedistributionofthemodelaveragedestimated
exposure-responsefunction(θ)foreachclusteridentifiedinthebestclusteringbySPR.Thedottedlinerepresentstheoverall
c
meanestimatedexposure-responsefunctionacrossallclusters.Panels(b-e)showtheempiricalexposuremeansofthe
individualsassignedtoeachclusterinthebestclustering,with1standarddeviationerrorbars.Thedottedlinesaredrawnat0,
themeanofthestandardizedexposuredata.
https://doi.org/10.1371/journal.pone.0249236.g003
estimation.SPRselectedfiveimportantmixturecomponents:MeBr(PIP=0.71),OP
(PIP=0.51),O (PIP=0.75),NO (PIP=0.67),andPM (PIP=0.63)(S13TableinS1File).
3 2 2.5
WefoundtheclusteringandPIPsinUPRandSPRtobesensitivetopriorchoiceparticularly
forthecluster-specificprecisionmatrixanderrorprecision.
Discussion
Interestisrapidlygrowinginestimatingtheassociationbetweenexposuretomixturesofenvi-
ronmentalchemicalsandhealthoutcomes.Asaresult,newstatisticalapproacheshavebeen
developedforstudyinghealthoutcomesassociatedwithexposuretomixtures.Thepurposeof
thispaperwastoevaluateandcomparerecentlydevelopedmethodsformixturesanddeter-
minewhichresearchquestionstheyanswerwellandinwhichscenarios.Welimitedourstudy
tocontemporaryBayesianmethodssincetheyareunder-studied,under-utilized,andmay
havetheabilitytoanswermultipleresearchquestions.Ourresultshighlighttheadvantagesof
theflexiblemodelingandBayesianframeworkofBKMRandNPBinestimatingtheexposure-
responsefunctionpreciselyandidentifyingmixturecomponentsmoststronglyassociated
withthehealthoutcome.
Overall,BKMRwasatop-performingmethod.Ineachofthescenarios,BKMRestimated
theexposure-responsefunctionwithcoverageclosesttothenominallevel(0.95)andlowest
RMSE.DespitebeingamoreflexibleapproachbasedonGaussianprocesses,BKMRhadlower
RMSEinthelinearscenariothanNPBr,LM,andLM-int,allofwhichassumelinearity.Thisis
likelybecauseNPBrandLMdonotaccountforinteractionsandLM-intcanresultininflated
standarderrorsinthepresenceofcorrelateddata.BKMRidentifiedactivemixturecompo-
nentswiththegreatestfrequency,butalsoincludedinactivecomponentsmoreoftenthan
othermethods.AlthoughwedidnotevaluatevariableselectionratesforinteractionsinBKMR
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 15/21

PLOS ONE Modelchoiceforchemicalmixtures
inoursimulation,BKMRcanidentifylinearornonlinearinteractionsamongexposures
throughvisualizationorsummarizingtheposteriordistributionoftheexposure-response
function.AdrawbacktoBKMRisthatresultsarenotaseasilyinterpretedasinNPBorthelin-
earmodels,thoughtherearecurrentlyeffortstoenhanceinterpretationandasuiteofvisuali-
zationapproachesthataidininterpretation.BKMRisanappealingchoiceformixtures
becauseitmakesminimalassumptionsontheshapeoftheexposure-responsefunctionand
includesasophisticatedvariableselectionalgorithmforidentifyingimportantmixture
components.
NPBwastop-performinginthelinearscenarioregardingestimatingtheexposure-response
function,identifyingbothactiveandinactivemixturecomponents,andidentifyinginterac-
tions.NPBperformedwellevenwhentheexposure-responsefunctionwasmildlynonlinear,
butlackstheflexibilityofBKMRforthefixedprofilesscenario,whichishighlynonlinear.The
AMEmethodNPBrpoorlyestimatedtheexposure-responsefunctioninthelinearscenario,
likelyfromnotaccountingforinteractions.AnadvantageofNPBisitseaseofinterpretation,
whichissimilartointerpretingalinearregressionmodel.NPBestimatesPIPsandeffectsizes
forallmaineffectandinteractionterms,providingpreciseinformationregardingthecontri-
butionofeachexposuretothemixtureanditseffectonthehealthoutcome.
Theprofileregressionmethods,UPRandSPR,poorlyaddressedtheresearchquestionsof
interestinallthreescenarios.Twoexplanationsforthisincludelackofaclusteringstructure
intheexposuredataandaweaksignal,bothofwhichinhibitthesemethodsfromaccurately
estimatingthemultipollutantexposure-responsefunction.Further,UPRandSPRdonothave
theabilitytoidentifyorestimateinteractionsorteaseoutindividualeffectsofthepollutants
withinamixture.Thesemethodsmaynotbeappropriateforstudiesinwhichtheprimary
objectivesaretoestimatethemultipollutantexposure-responsefunctionandidentifydriving
mixturecomponents.Asclusteringmethods,UPRandSPRarelikelytoperformbetteron
datathathasastronggroupingstructure.Sinceweusedasingledatasetinoursimulation
study,theresultsofoursimulationshouldnotbeinterpretedasrepresentativeofperformance
onalldatastructures.AparticularadvantageofUPRandSPRisthatthenumberofclusters
neednotbepre-specified.
Thelinearmodelwithinteractions,LM-int,hadcoverageabove0.91inallthreescenarios,
buthadhigherRMSEandlowerTSRthanBKMRandNPB.LM-intandNPBarebothEMM
methods,andNPBoutperformedLM-intinthelinearEMMscenario.LMandLM-inthave
theadvantageofbeingeasytoimplementandinterpret,butthesemethodsestimatedtheexpo-
sure-responsefunctionwithmoreuncertaintythanthetop-performingmethodsandgenerally
lackedtheabilitytoselecttrulyactivemixturecomponents,likelyduetohighcorrelation
amongexposures.
InourapplicationtotheFACESdataset,fourmethods(LM,LM-int,NPB,andBKMR)
identifiedNO asanimportantmixturecomponentnegativelyassociatedwiththehealthout-
2
come.Inaddition,LMandLM-intestimatedPM tohaveapositiveassociationwithFEV ,
10 1
andPM waspositivelycorrelatedwithNO .Further,themagnitudeoftheeffectestimatefor
10 2
NO inLMandLM-intwasseveraltimeslargerthanthatestimatedinNPB,andtheconfi-
2
denceintervalswerealsolarger,reflectingmoreuncertainty.UPRandSPRalsoidentified
NO asanimportantmixturecomponent,butwecannotdeterminethesignofeffectusing
2
thesemethods.Instead,UPRandSPRhavetheabilitytoestimatehowtheoverallmixtureis
associatedwiththehealthoutcome.UPRrevealedfourclusterswithsimilarestimatedhealth
effects;hence,patternsintheexposuredatawerenotassociatedwithFEV .InSPR,thesmall-
1
estclusterwasassociatedwithhigheraverageFEV thantheotherclusters,suggestinganasso-
1
ciationbetweenarelativelyraremixtureofexposuresandthehealthoutcome.Alternatively,
thissmallclustermayreflectastronginfluencefromthehealthoutcomeintheclustering
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 16/21

PLOS ONE Modelchoiceforchemicalmixtures
usingasupervisedlearner.Meanwhile,BKMRwasabletodescribeanonlinearassociation
betweenNO andFEV .
2 1
Usingmissingindicatorsmayhaveintroducedsomebiasintheeffectestimates.Addition-
ally,allBayesianmethodsaresensitivetopriorspecificationandresultsmayvarywithmore
orlessinformativepriors.PIPsareparticularlysensitivetopriorspecificationinallmethods,
sochangingpriorhyperparametersmayleadtochangesinTSRandFSR.Weimplementedall
modelsusingthedefaultpriorsasspecifiedbytheauthorstoobtainanobjectivecomparison
ofthesemethods.
Alongwiththeprimaryresearchquestion,thebestperformingmethodislikelytodepend
ontheexposuredata.Weusedobservedexposuredatasoourresultsarehighlyrelevantto
realisticsettings.Oursimulationresultscanbegeneralizedtosmalldatasetswithalimited
numberoflocalizedexposures,whichisafrequentscenarioinepidemiologicalstudies.
Inanalysesofenvironmentalmixturesandhumanhealth,modelchoicedependsonthe
assumedexposure-responserelationshipandtheprimaryquestionsofinterest.NPBand
BKMRarerecentlyproposedmethodsthatoutperformedtraditionalregressionmodelsand
offerpromisingtoolsformixturesanalyses.WerecommendNPBwhentheexposure-response
functionisassumedtobeapproximatelylinearandaprimarygoalisaccuratelyidentifying
whicharetheactiveandinactivecomponentsofthemixture.NPBisalsohighlyinterpretable
andexplicitlytestsforinteractions.WerecommendBKMRiftheexposure-responsefunction
isassumedtotakeonacomplexformandtheprimarygoalisestimatingtheformoftheexpo-
sure-responsefunctionwhileatthesametimeidentifyingimportantmixturecomponents.
OurresultssuggestthatUPRandSPRdonotreliablyanswerourspecifiedresearchquestions,
butmaybeapplicablefordifferentresearchquestionssuchaspatternrecognition.Wefurther
encourageuserstotakeadvantageofourRpackagemmpack[44]toreplicatethesimulation
anddeterminehoweachmethodperformsontheirowndata.Resultswilllikelybedifferent
ondifferentdatasets.Inparticular,theprofileregressionmethodsmayperformbetterondata
thatexhibitsastrongerclusteringstructureinthefixedprofilesscenario.Weincludetheclus-
teringstatisticsaspartofthesummaryofthefixedprofilescenariooutputsouserscansee
howmuchgroupingstructureisintheirowndata.Replicatingthesimulationontheirown
datawillenableuserstochoosethebestmethodfortheirdataandspecificresearchquestion.
Supportinginformation
S1File.
(PDF)
AuthorContributions
Datacuration:WandeBenka-Coker,RachelSeverson,SherylMagzamen.
Formalanalysis:LaurenHoskovec.
Fundingacquisition:SherylMagzamen.
Methodology:LaurenHoskovec,SherylMagzamen,AnderWilson.
Resources:AnderWilson.
Software:LaurenHoskovec.
Supervision:SherylMagzamen,AnderWilson.
Visualization:LaurenHoskovec.
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 17/21

PLOS ONE Modelchoiceforchemicalmixtures
Writing–originaldraft:LaurenHoskovec.
Writing–review&editing:WandeBenka-Coker,SherylMagzamen,AnderWilson.
References
1. DockeryDW,PopeCA,XuX,SpenglerJD,WareJH,FayME,etal.AnAssociationbetweenAirPollu-
tionandMortalityinSixU.S.Cities.NewEnglandJournalofMedicine.1993;329(24):1753–1759.
https://doi.org/10.1056/NEJM199312093292401
2. DockeryDW,PopeCA.AcuteRespiratoryEffectsofParticulateAirPollution.AnnualReviewofPublic
Health.1994;15(1):107–132.https://doi.org/10.1146/annurev.pu.15.050194.000543
3. DiQ,DaiL,WangY,ZanobettiA,ChoiratC,SchwartzJD,etal.AssociationofShort-termExposureto
AirPollutionWithMortalityinOlderAdults.JAMA.2017;318(24):2446–2456.https://doi.org/10.1001/
jama.2017.17923
4. DiQ,WangY,ZanobettiA,WangY,KoutrakisP,ChoiratC,etal.AirPollutionandMortalityintheMedi-
carePopulation.NewEnglandJournalofMedicine.2017;376(26):2513–2522.https://doi.org/10.1056/
NEJMoa1702747
5. PanL,WuS,LiH,XuJ,DongW,ShanJ,etal.Theshort-termeffectsofindoorsize-fractionedparticu-
latematterandblackcarbononcardiacautonomicfunctioninCOPDpatients.EnvironmentInterna-
tional.2018;112(38):261–268.https://doi.org/10.1016/j.envint.2017.12.037
6. SlamaR,VrijheidM.SomechallengesofstudiesaimingtorelatetheExposometohumanhealth.Occu-
pationalandEnvironmentalMedicine.2015;72(6):383–384.https://doi.org/10.1136/oemed-2014-
102546
7. WeisskopfMG,SealsRM,WebsterTF.BiasAmplificationinEpidemiologicAnalysisofExposureto
Mixtures.EnvironmentalHealthPerspectives.2018;126(4):047003.https://doi.org/10.1289/EHP2450
8. SametJM.TheperspectiveoftheNationalResearchCouncil’sCommitteeonResearchPrioritiesfor
AirborneParticulateMatter.JournalofToxicologyandEnvironmentalHealth—PartA.2005;68(13-
14):1063–1067.https://doi.org/10.1080/15287390590935905PMID:16024488
9. DominiciF,PengRD,BarrCD,BellML.ProtectingHumanHealthFromAirPollution.Epidemiology.
2010;21(2):187–194.https://doi.org/10.1097/EDE.0b013e3181cc86e8
10. NIEHS.2012-2017StrategicPlan:AdvancingScience,ImprovingHealth:Aplanforenvironmental
healthresearch;2012.
11. TaylorKW,JoubertBR,BraunJM,DilworthC,GenningsC,HauserR,etal.StatisticalApproachesfor
AssessingHealthEffectsofEnvironmentalChemicalMixturesinEpidemiology:LessonsfromanInno-
vativeWorkshop.EnvironmentalHealthPerspectives.2016;124(12):A227–A229.https://doi.org/10.
1289/EHP547
12. HamraGB,BuckleyJP.EnvironmentalExposureMixtures:QuestionsandMethodstoAddressThem.
CurrentEpidemiologyReports.2018;5:160–165.https://doi.org/10.1007/s40471-018-0145-0
13. WitteJS,GreenlandS.SimulationStudyofHierarchicalRegression.StatisticsinMedicine.1996;15
(11):1161–1170.https://doi.org/10.1002/(SICI)1097-0258(19960615)15:11%3C1161::AID-SIM221%
3E3.0.CO;2-7
14. Barrera-Go´mezJ,AgierL,PortengenL,Chadeau-HyamM,Giorgis-AllemandL,SirouxV,etal.Asys-
tematiccomparisonofstatisticalmethodstodetectinteractionsinexposome-healthassociations.Envi-
ronmentalHealth:AGlobalAccessScienceSource.2017;16(74).https://doi.org/10.1186/s12940-017-
0277-6
15. HoetingJA,MadiganD,RafteryAE,VolinskyCT.Bayesianmodelaveraging:Atutorial.StatisticalSci-
ence.1999;14(4):382–401.https://doi.org/10.2307/2676803
16. ClydeM.Modeluncertaintyandhealtheffectstudiesforparticulatematter.Environmetrics.2000;
11(6):745–763.https://doi.org/10.1002/1099-095X(200011/12)11:6%3C745::AID-ENV431%3E3.0.
CO;2-N
17. DavalosAD,LubenTJ,HerringAH,SacksJD.Currentapproachesusedinepidemiologicstudiesto
examineshort-termmultipollutantairpollutionexposures.AnnalsofEpidemiology.2017;27(2):145–
153.https://doi.org/10.1016/j.annepidem.2016.11.016
18. RobertsS,MartinM.Acriticalassessmentofshrinkage-basedregressionapproachesforestimating
theadversehealtheffectsofmultipleairpollutants.AtmosphericEnvironment.2005;39:6223–6230.
https://doi.org/10.1016/j.atmosenv.2005.07.004
19. HerringAH.Nonparametricbayesshrinkageforassessingexposurestomixturessubjecttolimitsof
detection.Epidemiology.2010;21:S71–S76.https://doi.org/10.1097/EDE.0b013e3181cf0058
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 18/21

PLOS ONE Modelchoiceforchemicalmixtures
20. Carbajal-ArroyoL,Miranda-SoberanisV,Medina-Ramo´nM,Rojas-BrachoL,TzintzunG,Sol´ıs-Gutie´r-
rezP,etal.EffectofPM10andO3oninfantmortalityamongresidentsintheMexicoCityMetropolitan
Area:Acase-crossoveranalysis,1997-2005.JournalofEpidemiologyandCommunityHealth.2011;
65(8):715–721.https://doi.org/10.1136/jech.2009.101212
21. WinquistA,KirraneE,KleinM,StricklandM,DarrowLA,SarnatSE,etal.Jointeffectsofambientair
pollutantsonpediatricasthmaemergencydepartmentvisitsinatlanta,1998-2004.Epidemiology.2014;
25(5):666–673.https://doi.org/10.1097/EDE.0000000000000146
22. LentersV,PortengenL,Rignell-HydbomA,Jo¨nssonBAG,LindhCH,PiersmaAH,etal.Prenatal
Phthalate,PerfluoroalkylAcid,andOrganochlorineExposuresandTermBirthWeightinThreeBirth
Cohorts:Multi-PollutantModelsBasedonElasticNetRegression.EnvironmentalHealthPerspectives.
2016;124(3):365–372.https://doi.org/10.1289/ehp.1408933
23. AustinE,CoullB,ThomasD,KoutrakisP.Aframeworkforidentifyingdistinctmultipollutantprofilesin
airpollutiondata.EnvironmentInternational.2012;45:112–121.https://doi.org/10.1016/j.envint.2012.
04.003
24. ZanobettiA,AustinE,CoullBA,SchwartzJ,KoutrakisP.Healtheffectsofmulti-pollutantprofiles.Envi-
ronmentInternational.2014;71:13–19.https://doi.org/10.1016/j.envint.2014.05.023
25. SacksJD,ItoK,WilsonWE,NeasLM.Impactofcovariatemodelsontheassessmentoftheairpollu-
tion-mortalityassociationinasingle-andmultipollutantcontext.AmericanJournalofEpidemiology.
2012;176(7):622–634.https://doi.org/10.1093/aje/kws135
26. PearceJL,WallerLA,ChangHH,KleinM,MulhollandJA,SarnatJA,etal.Usingself-organizingmaps
todevelopambientairqualityclassifications:atimeseriesexample.EnvironmentalHealth:AGlobal
AccessScienceSource.2014;13(1):56.https://doi.org/10.1186/1476-069X-13-56
27. PearceJL,WallerLA,MulhollandJA,SarnatSE,StricklandMJ,ChangHH,etal.Exploringassocia-
tionsbetweenmultipollutantdaytypesandasthmamorbidity:Epidemiologicapplicationsofself-orga-
nizingmapambientairqualityclassifications.EnvironmentalHealth:AGlobalAccessScienceSource.
2015;14(55).https://doi.org/10.1186/s12940-015-0041-8
28. PearceJL,WallerLA,SarnatSE,ChangHH,KleinM,MulhollandJA,etal.Characterizingthespatial
distributionofmultiplepollutantsandpopulationsatriskinAtlanta,Georgia.SpatialandSpatio-temporal
Epidemiology.2016;18:13–23.https://doi.org/10.1016/j.sste.2016.02.002
29. RobertsS,MartinMA.UsingSupervisedPrincipalComponentsAnalysistoAssessMultiplePollutant
Effects.EnvironmentalHealthPerspectives.2006;114(12):1877–1882.https://doi.org/10.1289/ehp.
9226
30. WoldS,RuheA,WoldH,DunnWJIII.Thecollinearityprobleminlinearregression.Thepartialleast
squares(PLS)approachtogeneralizedinverses.SocietyforIndustrialandAppliedMathematics.1984;
5(3):735–743.
31. RobertsS,MartinM.Investigatingthemixtureofairpollutantsassociatedwithadversehealthout-
comes.AtmosphericEnvironment.2006;40(5):984–991.https://doi.org/10.1016/j.atmosenv.2005.10.
022
32. NikolovMC,CoullBA,CatalanoPJ,GodleskiJJ.AninformativeBayesianstructuralequationmodelto
assesssource-specifichealtheffectsofairpollution.Biostatistics.2007;8(3):609–624.https://doi.org/
10.1093/biostatistics/kxl032
33. PachonJE,BalachandranS,HuY,MulhollandJA,DarrowLA,SarnatJA,etal.Developmentofout-
come-based,multipollutantmobilesourceindicators.JournaloftheAirandWasteManagementAssoci-
ation.2012;62(4):431–442.https://doi.org/10.1080/10473289.2012.656218
34. SunZ,TaoY,LiS,FergusonKK,MeekerJD,ParkSK,etal.Statisticalstrategiesforconstructinghealth
riskmodelswithmultiplepollutantsandtheirinteractions:possiblechoicesandcomparisons.Environ-
mentalHealth:AGlobalAccessScienceSource.2013;12(1):85.https://doi.org/10.1186/1476-069X-
12-85
35. CarricoC,GenningsC,WheelerDC,Factor-LitvakP.CharacterizationofWeightedQuantileSum
RegressionforHighlyCorrelatedDatainaRiskAnalysisSetting.JournalofAgricultural,Biological,and
EnvironmentalStatistics.2015;20(1):100–120.https://doi.org/10.1007/s13253-014-0180-3
36. BobbJF,ValeriL,ClausHennB,ChristianiDC,WrightRO,MazumdarM,etal.Bayesiankernel
machineregressionforestimatingthehealtheffectsofmulti-pollutantmixtures.Biostatistics.2015;
16(3):493–508.https://doi.org/10.1093/biostatistics/kxu058
37. GassK,KleinM,ChangHH,DanaFlandersW,StricklandMJ.Classificationandregressiontreesfor
epidemiologicresearch:Anairpollutionexample.EnvironmentalHealth:AGlobalAccessScience
Source.2014;13(1):17.https://doi.org/10.1186/1476-069X-13-17
38. GassK,KleinM,SarnatSE,WinquistA,DarrowLA,FlandersWD,etal.Associationsbetweenambient
airpollutantmixturesandpediatricasthmaemergencydepartmentvisitsinthreecities:aclassification
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 19/21

PLOS ONE Modelchoiceforchemicalmixtures
andregressiontreeapproach.EnvironmentalHealth:AGlobalAccessScienceSource.2015;14(1):58.
https://doi.org/10.1186/s12940-015-0044-5
39. BraunJM,GenningsC,HauserR,WebsterTF.Whatcanepidemiologicalstudiestellusaboutthe
impactofchemicalmixturesonhumanhealth?EnvironmentalHealthPerspectives.2016;124(1):A6–
A9.https://doi.org/10.1289/ehp.1510569
40. AgierL,PortengenL,Chadeau-hyamM,BasagañaX,Giorgis-allemandL,SirouxV,etal.ASystematic
ComparisonofLinearRegression—BasedStatisticalMethodstoAssessExposome-HealthAssocia-
tions.EnvironmentalHealthPerspectives.2016;124(12):1848–1856.https://doi.org/10.1289/EHP172
41. ChiuYH,BellaviaA,James-ToddT,CorreiaKF,ValeriL,MesserlianC,etal.Evaluatingeffectsofpre-
natalexposuretophthalatemixturesonbirthweight:Acomparisonofthreestatisticalapproaches.Envi-
ronmentInternational.2018;113(November2017):231–239.https://doi.org/10.1016/j.envint.2018.02.
005
42. AntonelliJ,MazumdarM,BellingerD,ChristianiDC,WrightR,CoullBA.Estimatingthehealtheffects
ofenvironmentalmixturesusingBayesiansemiparametricregressionandsparsityinducingpriors.
AnnalsofAppliedStatistics.2020;14(1):257–275.https://doi.org/10.1214/19-AOAS1307
43. GibsonEA,GoldsmithJ,KioumourtzoglouMA.ComplexMixtures,ComplexAnalyses:anEmphasison
InterpretableResults.CurrentEnvironmentalHealthReports.2019;6(2):53–61.https://doi.org/10.
1007/s40572-019-00229-5
44. HoskovecL.mmpack:Implementmethodsformultipollutantmixturesanalyses.Rpackageversion
0.1.0.;2019.Availablefrom:https://github.com/lvhoskovec/mmpack.
45. MortimerK,NeugebauerR,LurmannF,AlcornS,BalmesJ,TagerI.Early-lifetimeexposuretoairpollu-
tionandallergicsensitizationinchildrenwithasthma.JournalofAsthma.2008;45(10):874–881.https://
doi.org/10.1080/02770900802195722
46. MargolisHG,MannJK,LurmannFW,MortimerKM,BalmesJR,HammondSK,etal.Alteredpulmonary
functioninchildrenwithasthmaassociatedwithhighwaytrafficnearresidence.InternationalJournalof
EnvironmentalHealthResearch.2009;19(2):139–155.https://doi.org/10.1080/09603120802415792
47. MannJK,BalmesJR,BrucknerTA,MortimerKM,MargolisHG,PrattB,etal.Short-termeffectsofair
pollutiononwheezeinasthmaticchildreninFresno,California.EnvironmentalHealthPerspectives.
2010;118(10):1497–1502.https://doi.org/10.1289/ehp.0901292
48. NothEM,HammondSK,BigingGS,TagerIB.Aspatial-temporalregressionmodeltopredictdailyout-
doorresidentialPAHconcentrationsinanepidemiologicstudyinFresno,CA.AtmosphericEnviron-
ment.2011;45(14):2394–2403.https://doi.org/10.1016/j.atmosenv.2011.02.014
49. GaleSL,NothEM,MannJ,BalmesJ,HammondSK,TagerIB.Polycyclicaromatichydrocarbonexpo-
sureandwheezeinacohortofchildrenwithasthmainFresno,CA.JournalofExposureScienceand
EnvironmentalEpidemiology.2012;22(4):386–392.https://doi.org/10.1038/jes.2012.29
50. PadulaAM,BalmesJR,EisenEA,MannJ,NothEM,LurmannFW,etal.Ambientpolycyclicaromatic
hydrocarbonsandpulmonaryfunctioninchildren.JournalofExposureScienceandEnvironmentalEpi-
demiology.2015;25(3):295–302.https://doi.org/10.1038/jes.2014.42
51. VanSickleD,MagzamenS,MullahyJ.Understandingsocioeconomicandracialdifferencesinadult
lungfunction.AmericanJournalofRespiratoryandCriticalCareMedicine.2011;184(5):521–527.
https://doi.org/10.1164/rccm.201012-2095OC
52. RaananR,BalmesJR,HarleyKG,GunierRB,MagzamenS,BradmanA,etal.Decreasedlungfunc-
tionin7-year-oldchildrenwithearly-lifeorganophosphateexposure.Thorax.2016;71(2):148–153.
https://doi.org/10.1136/thoraxjnl-2014-206622
53. Benka-CokerW,HoskovecL,SeversonR,BalmesJ,WilsonA,MagzamenS.Thejointeffectofambi-
entairpollutionandagriculturalpesticideexposuresonlungfunctionamongchildrenwithasthma.Envi-
ronmentalResearch.2020;190(February):109903.https://doi.org/10.1016/j.envres.2020.109903
54. CaliforniaDepartmentofPesticideRegulation.CaliforniaPesticideUseReportingData;2015.Available
from:http://www.cdpr.ca.gov/docs/pur/purmain.htm.
55. ColovicMB,KrstiDZ,Lazarevi-PatiTD,BondiAM,VasiVM.AcetylcholinesteraseInhibitors:Pharma-
cologyandToxicology.CurrentNeuropharmacology.2013;11:315–335.https://doi.org/10.2174/
1570159X11311030006
56. BulathsinghalaAT,ShawIC.Thetoxicchemistryofmethylbromide.HumanandExperimentalToxicol-
ogy.2014;33(1):81–91.https://doi.org/10.1177/0960327113493299
57. SeversonR.purexposure:PullandCalculateExposuretoCAPesticideUseRegistryRecords.Rpack-
ageversion0.1.0;2019.Availablefrom:https://github.com/leighseverson/purexposure.
58. MolitorJ,PapathomasM,JerrettM,RichardsonS.Bayesianprofileregressionwithanapplicationto
theNationalSurveyofChildren’sHealth.Biostatistics.2010;11(3):484–498.https://doi.org/10.1093/
biostatistics/kxq013
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 20/21

PLOS ONE Modelchoiceforchemicalmixtures
59. RCoreTeam.R:Alanguageandenvironmentforstatisticalcomputing;2018.
60. DunsonDB,HerringAH,EngelSM.BayesianSelectionandClusteringofPolymorphismsinFunction-
allyRelatedGenes.JournaloftheAmericanStatisticalAssociation.2008;103(482):534–546.https://
doi.org/10.1198/016214507000000554
61. MolitorJ,SuJG,MolitorNT,RubioVG,RichardsonS,HastieD,etal.Identifyingvulnerablepopulations
throughanexaminationoftheassociationbetweenmultipollutantprofilesandpoverty.Environmental
ScienceandTechnology.2011;45(18):7754–7760.https://doi.org/10.1021/es104017x
62. DahlDB.Model-BasedClusteringforExpressionDataviaaDirichletProcessMixtureModel.Bayesian
InferenceforGeneExpressionandProteomics.2006;p.201–218.https://doi.org/10.1017/
CBO9780511584589.011
63. ChungY,DunsonDB.NonparametricBayesConditionalDistributionModelingWithVariableSelection.
JournaloftheAmericanStatisticalAssociation.2009;104(488):1646–1660.https://doi.org/10.1198/
jasa.2009.tm08302PMID:23580793
64. PapathomasM,MolitorJ,HoggartC,HastieD,RichardsonS.ExploringDataFromGeneticAssocia-
tionStudiesUsingBayesianVariableSelectionandtheDirichletProcess:ApplicationtoSearchingfor
Gene×GenePatterns.GeneticEpidemiology.2012;36(6):663–674.https://doi.org/10.1002/gepi.
21661
65. LiveraniS,HastieDI,AziziL,PapathomasM,RichardsonS.PReMiuM:AnRPackageforProfile
RegressionMixtureModelsUsingDirichletProcesses.JournalofStatisticalSoftware.2015;64(7):1–
30.https://doi.org/10.18637/jss.v064.i07
66. BobbJF.bkmr:BayesianKernelMachineRegression.Rpackageversion0.2.0;2017.Availablefrom:
https://cran.r-project.org/package=bkmr.
67. CalińskiT,HarabaszJ.CommunicationsinStatistics—TheoryandMethods.CommunicationsinStatis-
tics.1974;3(1):1–27.
68. RousseeuwPJ.Silhouettes:Agraphicalaidtotheinterpretationandvalidationofclusteranalysis.Jour-
nalofComputationalandAppliedMathematics.1987;20(C):53–65.https://doi.org/10.1016/0377-0427
(87)90125-7
69. TibshiraniR,WaltherG,HastieT.Estimatingthenumberofdataclustersviathegapstatistic;2001.
70. BarbieriMM,BergerJO.Optimalpredictivemodelselection.AnnalsofStatistics.2004;32(3):870–897.
https://doi.org/10.1214/009053604000000238
PLOSONE|https://doi.org/10.1371/journal.pone.0249236 March25,2021 21/21
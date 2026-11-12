STATISTICSINMEDICINE,VOL.16,2349—2380(1997)
TUTORIAL IN BIOSTATISTICS
USING THE GENERAL LINEAR MIXED MODEL TO
ANALYSE UNBALANCED REPEATED MEASURES AND
LONGITUDINAL DATA
AVITALCNAAN!*,NANM.LAIRD"ANDPETERSLASOR"
!DivisionofBiostatistics,DepartmentofPediatrics,UniversityofPennsylvaniaSchoolofMedicine,Philadelphia,
Pennsylvania,U.S.A.
"DepartmentofBiostatistics,HarvardSchoolofPublicHealth,Boston,Massachusetts,U.S.A.
SUMMARY
Thegenerallinearmixedmodelprovidesausefulapproachforanalysingawidevarietyofdatastructures
whichpractisingstatisticiansoftenencounter.Twosuchdatastructureswhichcanbeproblematictoanalyse
areunbalancedrepeatedmeasuresdataandlongitudinaldata.Owingtorecentadvancesinmethodsand
software,themixedmodelanalysisisnowreadilyavailabletodataanalysts.Themodelissimilarinmany
respects to ordinary multiple regression, but because it allows correlation between the observations, it
requiresadditionalworktospecifymodelsandtoassessgoodness-of-fit.Theextracomplexityinvolvedis
compensatedforbytheadditionalflexibilityitprovidesinmodelfitting.Thepurposeofthistutorialisto
providereaderswithasufficientintroductiontothetheorytounderstandthemethodandamoreextensive
discussionofmodelfittingandcheckinginordertoprovideguidelinesforitsuse.Weprovidetwodetailed
casestudies,oneaclinicaltrialwithrepeatedmeasuresanddropouts,andoneanepidemiologicalsurvey
withlongitudinalfollow-up.!1997byJohnWiley& Sons,Ltd.
Statist.Med.,16,2349—2380(1997)
No.ofFigures:6 No.ofTables:8 No.ofReferences:34
1. INTRODUCTION
Thistutorial deals with the use of the generallinear mixed model for the regression analysis of
correlateddata.Thecorrelationarisesbecausesubjectsmaycontributemultipleresponsestothe
dataset.The modelassumesacontinuousoutcomevariablewhichis linearlyrelatedtoasetof
explanatory variables; it expands on the ordinary linear regression model by allowing one to
incorporatelackofindependencebetweenobservationsandtomodelmorethanoneerrorterm.
Thetypesofdatathatcanbeanalysedusingthegenerallinearmixedmodelincludelongitudinal
*Correspondence to: Avital Cnaan, Division of Biostatistics, Department of Pediatrics, University of Pennsylvania
SchoolofMedicine,Philadelphia,Pennsylvania,U.S.A.
Contractgrantsponsor:NationalInstitutesofHealth
Contractgrantnumber:GM29745,RR00240-31
CCC 0277—6715/97/202349—32$17.50
! 1997 by John Wiley & Sons, Ltd.

2350 A.CNAAN,N.M.LAIRDANDP.SLASOR
data, repeated measures data (including cross-over studies), growth and dose—response curve
data,clustered(ornested)data,multivariatedataandcorrelateddata.Despitethiswideapplica-
bility,theresultsofsuchanalysesareonlynowbeginningtoappearintheresearchliterature;we
willdescribebrieflyseveralrecentapplications.Themodel’slimiteduseisdueinparttothefact
thatcommercialsoftwarehasbeenlimitedinthepast,andinparttoalackoffamiliaritywiththe
modelbythegeneralstatisticalandmedicalcommunity.Thegoalofthistutorialistointroduce
the model and its analysis to applied statisticians, to provide some guidelines on model fitting,
andto illustrateits use withtwo data sets. Two recent bookswhich cover aspectsof the model
and its analysis in more detail are those of Longford! and Diggle et al."
We use the term longitudinal data to imply that each subject is measured repeatedly on the
sameoutcomeatseveralpointsintime.Themaininterestisusuallyincharacterizingthewaythe
outcomechangesovertime,andthepredictorsofthatchange.Atypicalexampleofalongitudinal
studyistheTucsonEpidemiologicalStudyofAirwaysObstructiveDisease,inwhichtheeffectsof
smoking onset and cessation on changes in pulmonary function were assessed.# This study
followed 288 subjects for 17 years. Using a random-effectsmodel, the authors showed that the
largest beneficial effect related to quitting smoking was in younger subjects and the effect
decreasedlinearlywithageatquitting.Theadvantageofthisstudyovermanystudiesinthisarea
isthatthemodellingenabledtheauthorstoaccountforboththeageatonsetofsmokingandat
quitting,inadditiontootherimportantcovariates,andthusgiveamorecomprehensivepicture
than previous studies which approached only one aspect or another of the problem.
A widely used and general term is repeated measures data, which refers to data on subjects
measuredrepeatedlyeitherunderdifferentconditions,oratdifferenttimes,orboth.Anexample
isastudyofstressandimmuneresponseinmothersofverylowbirthweightinfantsandmothers
of normal weight infants.$ The two groups of mothers, comparable in sociodemographic vari-
ables, were measured for stress and various immune function markers at delivery of the infant,
one, two and four months post-delivery. The data for each outcome were analysed separately
using the balanced and complete repeated measures data approach with an unstructured
covariancematrixfor the four measurements.The mothers of the very low birth weightinfants
hadincreasedanxietyanddecreasedlymphocyteproliferationaswellasdecreasedpercentagesof
some immunologic cell subsets. Longitudinal models of these markers as either a linear or
aquadraticfunctionoftimeshowedthatresolutionoftheimmunosuppressionofpregnancywas
substantiallyfasterinmothersofverylowbirthweightinfantsthaninmothersofnormalweight
infants, although neither group reached normal levels by four months. The advantage of using
longitudinalmodelsinthisstudywasthatthetimeofactualmeasurementoftheimmunemarkers
wasused,whichoftendeviatedforthesemothersfromtheoriginalpresetschedule.Thisenabled
theauthorstoobtainawell-fittingfunctionoftime,andmodeltheresolutionofimmunemarkers’
levels.
In growth and dose—response curve data, the subjects are ordinarily measured repeatedly at
acommonsetofagesordoses.InastudyconductedinPittsburg,thepurposewastoidentifythe
effectof prenatalalcoholexposureongrowth.%It has previouslybeen establishedthatprenatal
alcohol exposure is associated with smaller birth size. However, it has not been clear whether
thereissubsequentcatch-upgrowth,andcross-sectionalstudieshavenotbeenabletosatisfactor-
ily answer this question. This study followed the infants from birth to three years, and, using
a growth curve model, was able to ascertain that there was no long-term catch-up growth; the
smaller size observed at birth is maintained. The model used for analysis was a general
unbalanced repeated measures model with a fully parameterized covariance matrix.
Statist.Med.,16,2349—2380(1997) ! 1997byJohnWiley&Sons,Ltd.

USINGTHEGENERALLINEARMIXEDMODEL 2351
Clustereddataarisecommonlyinsurveysandobservationalstudiesofpopulationswhichhave
anaturalhierarchicalstructure,suchasindividualsclusteredinhouseholdsandpatientsclustered
inhospitalsorotherservicedeliverysystems.Hereinterestmaycentreonwhichcharacteristicsof
the individual or of the cluster, or both, affect the outcome. An example of a data set where
mixed-effects models were used in a cluster setting involves a study for predicting microbial
interactionsinthevaginalecosystem.&Thedataforthestudyconsistedofbacteriaconcentrations
from in vivo samples; samples could be obtained from a subject once or multiple times during
a study. The explanatory variables were concentrations of various specific bacteria, timing in
menstrualcycle,andflowstage.Thegeneralapproachforinclusionofvariableswasabackward
elimination process. The mixed-effects modelling enabled the researchers to use all the data
available,accountfor repeatswithin subjects,andmodel total aerobic bacteria,total anaerobic
bacteria and mean pH values, as three different mixed-effects models, with different fixed and
random effects.
Multivariate data refers to the case where the same subject is measured on more than one
outcome variable. In this setting, one is looking at the effects of covariates on several different
outcomes simultaneously. Using the general linear mixed model analysis allows one more
flexibilitythanusingtraditionalmultivariateregressionanalysisbecauseitpermitsonetospecify
differentsetsofpredictorsforeachresponse,itpermitssharedparametersfordifferentoutcomes
when covariates are the same, and it allows subjects who are missing some outcomes to be
includedintheanalysis.Astudywithmultivariateoutcomeslookedatindividualpaintrendsin
children following bone marrow transplantation.’ Children aged 6—16 years and their parents
werebothaskedtoevaluatethechild’spainonastandardizedanaloguescaledailyfor20days.
EmpiricalBayes’methodologywasusedtomodelpainasaquadraticfunctionofnumberofdays
post-transplant. Separate models were used for describing children’s and parent’s pain ratings
andcurveswerecomparedinformally.Usingasingleanalysiswithamultivariateresponseofthe
childrenandparentswouldhaveallowedadirectstatisticalcomparisonofthepaincurves.The
analysis did show that the empirical Bayes’ approach to the modelling gave a better fit than
ordinary least squares (OLS) modelling separately for each child, which was possible in this
exampledue to the large numberof observationsper child. In general, parents reported higher
painlevelsthanthechildren,andtherewassomevariabilityinreportingwithinthechildrenby
age group.
Correlated data is a generic term which includes all of the foregoing types of data as special
cases.Theonlyrestrictionisthatthecorrelationmatrixoftheentiredatamatrixmustbeblock
diagonal,thusthemodeldoesnotaccommodatetimeseriesdata,inwhichanon-zerocorrelation
is assumed at least between every two consecutive observations. In all of these cases the
observations are clustered, or grouped within subject. Thus we can structure the data by first
identifyingthesubjectorcluster,andthentherepeatedobservationonthesubjectorthecluster.
Indescribingthishierarchicalstructure,onemightencounterintheliteraturethetermslevelone
andlevel two, stage one and stage two, observation level and subjectlevel, or subject level and
cluster level; the latter two are especially confusing since sometimes subject is level one and
sometimesitisleveltwo,dependingupontheapplication.Ratherthanexclusivelyusingasingle
terminology in this paper, we will use the terminology most appropriate to the context and
indicateinparenthesiswhatismeant,ifnecessary.Intheabsenceofaparticularcontextwewill
generally use subject and observation to denote the two levels of the hierarchy.
A wide variety of names are also used in the statistical literature to describe versions of the
samemodel,reflectingthediversity of its use inmany fields. Thesenamesinclude: mixedlinear
! 1997byJohnWiley&Sons,Ltd. Statist.Med.,16,2349—2380(1997)

2352 A.CNAAN,N.M.LAIRDANDP.SLASOR
model;(two-stagerandomeffectsmodel;)multilevellinearmodel;!*hierarchicallinearmodel;!!
empiricalBayes’model,!"andrandomregressioncoefficients.!#Thehierarchicalstructureforthe
data leads naturally to the terms hierarchical linear model or multilevel linear model. Strictly
speaking, both of these terms are used to describe models which may include more than two
levels.Examplesofmorethantwolevelsarecommonlyencounteredintheeducationalliterature
where we have students grouped in classes and classes grouped in schools. Since many of the
biomedicalapplicationsdealwithonlytwolevels,wewillnotconsiderthehigherlevelmodelsin
this paper.
One can broadly characterize many versions of the models as methods for handling the
between- and within-subject variability in the data. There are basically two ways which are
commonlyusedtomodelthesetwotypesofvariability.Theapproachthatseemsmostnaturalto
manyinvestigatorsistodevelopthemodelintwostages.Atthefirststage,wespecifyaseparate
linear regression for the observations on each subject, as a function of covariates made on the
observations,forexample,timeoftheobservation.Therewillbeasmanyoftheseregressionsas
we have subjects; each regression must use the same set of predictor variables, so that each
regression has the same vector of coefficients, but the regression coefficients themselves are
allowedto vary over subjects. At the second stage, the regression coefficientsmodelledat stage
one are the random outcome variables, hence the terms random coefficient regressions and
random effects models. The term mixed effects comes from combining the two regressions into
asingleequationwithtwotypesofregressioncoefficients.Thetwo-stageapproachisattractiveto
manyinvestigators,sincethesubjectsareexplicitlytreatedastheunitofanalysisatstagetwo,and
onemodelsdirectlythetwotypesofregressions:thewithinatstageoneandthebetweenatstage
two.
However,theapproachcanbelimitinginthewaymodelsaredevelopedforboththemeanand
the variance-covariance structure. The mixed model approach is to simply write out a single
regressionmodelforeachobservation.Themodelhastheusuallinearregressionpredictorforthe
mean response, but has two types of random error terms: between-subject errors and within-
subject errors. All of the observations on the same subject will have the same between-subject
errors;theirwithin-subjecterrorswilldiffer,andcanbecorrelatedwithinasubject.Bothwithin-
andbetween-subjecterrorsare assumedindependentfrom subjectto subject,thus observations
on different subjects are independent.
InSection2weintroducetwocasestudies.InSection3wewillintroducenotation,andshow
howthesetwoapproachestoformulatingthemodelarerelated.Wethenaddressestimationand
testing issues and offer suggestions about strategies for model specification and checking. In
Section4wediscussstatisticalsoftwareandillustratethetechniquesappliedtothecasestudiesin
Section 5. Source code for the software programs is provided in the Appendix.
2. DESCRIPTION OF CASE STUDIES
2.1. Clinical trial in patients with Schizophrenia
As an example to motivate this tutorial, we consider a clinical trial of a medication for the
treatment of schizophrenia during an acute phase of illness.!$ This clinical trial was a double-
blindedstudywithrandomizationamongfourtreatments:threedoses(low,mediumandhigh)of
an experimental drug and a control drug with known antipsychotic effects as well as known
side-effects.Initialstudiespriortothisdouble-blindedstudysuggestedthattheexperimentaldrug
Statist.Med.,16,2349—2380(1997) ! 1997byJohnWiley&Sons,Ltd.

USINGTHEGENERALLINEARMIXEDMODEL 2353
Figure1. DistributionofBPRSbycentreforthe schizophreniatrial.Inthis box andwhiskerplotthe boxgivesthe
interquartilerangeandthemedian.Thewhiskersarethreehalvedtheinterquartilerangerolledbacktowherethereare
data.Valuesbeyondtheseareplottedasoutliers.Thewidthoftheboxisproportionaltothenumberofsubjectsobserved
atbaseline.
hadequivalentantipsychoticactivity,withlesserside-effects.Theprimaryobjectivesofthisstudy
wasthedeterminationofadose—responserelationshipforefficacy,tolerabilityandsafely,andthe
comparisontothecontroldrug.Thestudywasconductedat13clinicalcentres,andatotalof245
patients were enrolled. The primary efficacy parameter was the Brief Psychiatric Rating Scale
(BPRS).!% This scale measures the extent of a total of 18 observed behaviours, reported beha-
viours, moods and feelings, and rates each one on a seven-point scale, with a higher score
reflectingaworseevaluation.ThetotalBPRSscoreisthesumofthescoresonthe18items.Study
entrycriteriaincluded,amongothers,ascoreofatleast20oninitialevaluation.Thedistribution
ofBPRSscoresatbaselinewasdifferentinthedifferentcentres,asisshowninFigure1.Thewidth
of the boxes is proportional to the number of patients contributing to the box, showing the
differentsample sizes in the different centres. Analysis of variance on the baseline BPRS shows
asignificantdifferencebetweencentres(p(0·0001).Infact,36percentofthebaselinevariability
inBPRSscoresisexplainedbycentre.TherewerenodifferencesinbaselineBPRSscoresbetween
treatment groups. Because of the differences at baseline between the centres and because
the randomization was done by blocks within centre, all analyses will include centre in the
model.
Patientswereevaluatedatbaselineandafterone,two,three,fourandsixweeksoftreatment.
Patientswereadmittedtothehospitalforthefirstfourweeksoftreatment,anddischargedasthe
clinical condition permitted for the final two weeks. Since each patient had a different baseline
value(range20—69),thefocusofthisanalysisisontherateofchangeduringthesixweeks,rather
thanon a targetdesirableBPRSvalue. Of the patients,134 (55%) completedthe study,and 11
additional patients had a week six evaluation, even though they were technically considered
non-completers.Figure2 givesthe boxplots of BPRSvalues for each of the four treatments at
each of the observation points. The width of the box plots gives a feel for the dropout rate.
Theprimaryreasonfordiscontinuationwasaperceivedlackof effectivenessofthetreatment
bythephysician;therewerealsoseveralwithdrawalsduetoside-effects.TableIgivesthenumber
! 1997byJohnWiley&Sons,Ltd. Statist.Med.,16,2349—2380(1997)

2354
A.CNAAN,N.M.LAIRDANDP.SLASOR
Figure2. DistributionofBPRSbytreatmentgroupateachmeasurementoccasionfortheschizophreniatrial
TableI. Schizophreniacasestudy:numberofpatientsmeasuredat eachtimepoint
| Week | Exp-low | Exp-medium | Exp-high | Control | Total |
| ---- | ------- | ---------- | -------- | ------- | ----- |
| 0    | 61      | 61         | 60       | 63      | 245   |
| 1    | 55      | 57         | 57       | 60      | 229   |
| 2    | 45      | 53         | 50       | 57      | 205   |
| 3    | 38      | 46         | 46       | 51      | 181   |
| 4    | 32      | 43         | 40       | 44      | 159   |
| 6    | 29      | 42         | 36       | 38      | 145   |
ofpatientsateachobservationpointoneachtreatment.TableIIgivesthereasonsfordiscontinu-
ationbytreatment.TableIshowsthatthelargestdropoutoccurredontheexperimentallow-dose
treatment, and Table II shows that the primary reason for this loss was perceived lack of
therapeuticeffectiveness.However,thetablesalsoshowthattherewassubstantialdropoutdueto
side-effects in the control treatment. When a discontinuation or a dropout occurred, every
attempt was made to conduct a final observation at that time, often between two scheduled
| Statist.Med.,16,2349—2380(1997) |     |     |     | ! 1997byJohnWiley&Sons,Ltd. |     |
| ------------------------------- | --- | --- | --- | --------------------------- | --- |

2355
USINGTHEGENERALLINEARMIXEDMODEL
TableII. Schizophreniacasestudy:reasonsfordiscontinuationfromclinicaltrial
| Reason            |     | Exp-low | Exp-medium | Exp-high | Control | Total |
| ----------------- | --- | ------- | ---------- | -------- | ------- | ----- |
| Completed*        |     | 27      | 40         | 33       | 34      | 134   |
| Adverseexperience |     | 2       | 1          | 2        | 12      | 17    |
| Lackofeffect      |     | 21      | 7          | 13       | 11      | 52    |
| Otherreasons      |     | 11      | 13         | 12       | 6       | 42    |
* Several patients discontinuedbetween weeks 4 and 6 and had a final observation, which was recorded as a week
6observation,withtheappropriatenon-completercoding
observationpoints.Forpurposesofthisanalysis,thefinalobservationwasassumedtobeatthe
next observation point, since the exact times were not available to us. Thus, for a patient who
discontinued after the week 4 observation, their final observation was recorded at the week
6observationpoint.Therefore,therearemorepatientswithweek6data(TableI)thanthereare
| completers | (Table II). |     |     |     |     |     |
| ---------- | ----------- | --- | --- | --- | --- | --- |
Inordertofurtherunderstandthedropout,Coxregressionmodelswereappliedtotimeuntil
discontinuation. In these models, discontinuation was considered a failure event, and subjects
who completed the study were considered censored at six weeks. High BPRS scores either at
baseline,orlater,orlargedifferences(increases)inBPRSscores,wereallassociatedwithashorter
timeto discontinuation.However, discontinuationwas not related to treatmentdirectly (in the
presence of BPRS score), nor, in general, to centre. Results were similar either when the failure
eventwasdefinedasdiscontinuationofanykindorwhenitwasdefinedonlyasdiscontinuation
duetolackoftherapeuticresponse.Thehazardratioforallcausesof discontinuationbasedon
adifferenceoftenpointsontheBPRSscalewasestimatedas2·4;fordiscontinuationduetolack
| of effect, | the corresponding | hazard ratio | is 3·9. |     |     |     |
| ---------- | ----------------- | ------------ | ------- | --- | --- | --- |
2.2. Epidemiologicstudy of pulmonary function development in children
The Six Cities Study of Air Pollution and Health was designed to characterize pulmonary
function growth between the ages of six and eighteen and the factors that affect growth.!&
A cohortof 13,379 childrenborn in or after 1967 was enrolledin six communities:Watertown,
MA;KingstonandHariman,TN;asectionofSt.Louis,MO;Steubenville,OH;Portage,WI;and
Topeka,KN.Mostchildrenwereenrolledinthefirstorsecondgradeandparticipantswereseen
annuallyuntilhighschoolgraduationorlesstofollow-up.Ateachexamination,spirometrywas
performedandFEV ,thevolumeofairexhaledbyforceinthefirstsecond,wasmeasured.Forthe
!
purposeoftheanalysesdemonstratedhere,asubsetof300girlsfromTopeka,KN,withatotalof
1994measurementsis presented. The data included their FEV , age and height. Baseline mean
!
age was 8.29 years (SD 1·38) and mean height was 1·29 metres (SD 0·095). The number of
measurements(observations)foreachgirlrangedfrom1to12,andthetotalfollow-upduration
| for each | girl ranged from | zero to 11 | years. |     |     |     |
| -------- | ---------------- | ---------- | ------ | --- | --- | --- |
In our analysis, we will replicate the modelling approach suggested by Hopper et al.!’ in
asimilarAustralianstudy.Inthatstudy,thenaturallogarithmoftheFEV ! wasfoundtobewell
predictedbybothcurrentheightandage.despitethestrongcorrelationbetweenthetwo.Healso
found that an autocorrelation structure represented the correlation in the data better than
| a random                    | effects structure. |     |     |     |                                 |     |
| --------------------------- | ------------------ | --- | --- | --- | ------------------------------- | --- |
| ! 1997byJohnWiley&Sons,Ltd. |                    |     |     |     | Statist.Med.,16,2349—2380(1997) |     |

2356 A.CNAAN,N.M.LAIRDANDP.SLASOR
3. THE DEVELOPMENTOF THE GENERAL LINEAR MIXED MODEL
3.1. Design considerations
Wewill let i"1,2,N index the subjectsin thestudyand y
!
denotethe vectorof observations
madeontheithsubject.Sincesubjectsareallowedtohaveunequalnumbersofobservations,the
vectorsy mayhavedifferentdimensions.Indesignedexperiments,thenumberofobservationsis
!
usuallyfixedtobethesameforallsubjects,andinequalitiesariseasaresultofmissingdata.Inthe
schizophrenia trial (Section 2.1), the length of y varies from one to six depending upon if and
!
when the patient dropped out. In clustered data applications, where the second level might be
ahospital,andobservationsaremadeondifferentpatientswithinthehospital,thedimensionof
y canvaryarbitrarilyfromhospitaltohospital.Wewilldenotethedimensionofy byn,sothat
! ! !
the total number of observations that we have in the data set are !! " +! n ! .
Eachsubjectalsohasavectorofcovariates;intheschizophreniatrial(Section2.1),thesubject
level covariates are treatment group and centre. In addition, each observation typically has its
owncovariates.Thesubjectlevelcovariatesremainconstantforalltherepeatedobservationson
asubject,whereasobservationlevelcovariatesmayvaryastherepeatedobservationsaremade.
In the schizophrenia trial, time and functions of time such as time squared etc., are the main
observationlevelcovariates.Withclustereddatawhereobservationsondifferentsubjectsarethe
repeated measures, the observation level covariates can be numerous, for example, age, sex,
severityscore, etc. In cross-over trials where one subject receives several treatments in different
periods, both period and treatment are observation level covariates.
Many longitudinal studies where an individual is the subject typically have time as the only
observation level covariate. The FEV data example (Section 2.2) we present is an exception,
!
wheretwoimportantpredictors,ageandheight,arecharacteristicsoftheobservation.Sometimes
avariablecanappearasacovariateatbothlevels.Forexample,Wechsleretal.usedatwo-stage
cluster survey to study drinking behaviour in college students.!( First a random sample of
collegeswasdrawn,thenarandomsampleofstudentsweresurveyedineachcollegeappearingin
thestageonesample.Intheanalysis,boththesexoftheindividualstudent(observationlevel)and
the per cent of students in the college who were a specific sex (cluster level) were used as
covariates. Another example arises in longitudinal studies where subjects are measured at
differentinitialages,andbothcurrentageandinitialagecanappearaspredictorsinthemodel.!)
In this case, the initial age is a subject level covariate and current age is a covariate at the
observation level.
Thisdistinctionbetweenobservationallevelandsubjectlevelcovariatesisimportant,sincethis
typicallydrives model formulationand selection,and determinesto some extent the amountof
information available in the data to estimate the effects of different variables. The repeated
observations on a subject are usually assumed to be positively correlated; this implies that the
effects of within-subject (or observation level) variables will typically be estimated with greater
precisionthan the effects of between-subjectvariables.This is becausethe former are estimated
using within-subjectcontrasts, and the variance of a contrast is reducedwhen the observations
arepositivelycorrelated.Thisisthebasicprincipleofasplit-plotdesign,wherethewholeplot(or
between-subject)factorisestimatedwithlessprecisionthanthesubplot(orwithin-subject)factor
andtheinteractionofthetwofactors."*Likewise,thecross-overdesignhaspotentialforgreater
efficiencythan the‘parallel’design becausetreatmentcontrastsare constructedusing positively
correlatedresponses."!Inthecontextoflongitudinalstudies,theimplicationisthattimetrends,
and the effects of subject level variables on time trends, will be the effects best estimated.""
Statist.Med.,16,2349—2380(1997) ! 1997byJohnWiley&Sons,Ltd.

USINGTHEGENERALLINEARMIXEDMODEL 2357
In classically designed experiments with balanced and complete data, covariates (or factors)
typicallyvaryeitherwithinsubjects(observationlevel)orbetweensubjects(subjectlevel)butnot
both.Forexample,ifeachschizophreniapatient(Section2.1)wereobservedonallsixoccasions,
timewouldvarywithinbutnotbetweenpatients,sinceeachpatientwouldhavethesamevector
of values for time. Treatment and centre vary between but not within subjects. This clean
separation of between- and within-subject variables is a hallmark of designed experiments and
hastheadvantageofleadingtoorthogonaldesignsandasimplifiedrepeatedmeasuresanalysis.
With observational studies, unbalanced designs and/or missing data, it is rarely possible to
achievethisclearseparationofbetween-andwithin-subjectvariables.Forexample,intheFEV
!
data set (Section 2.2), it is not logistically possible to design the study so that each subject is
measured at the same set of ages and heights. If a covariate varies both within and between
subjects,itmaybeimportanttospecifyamodelwhichreflectsthis,asintheexamplespreviously
cited.!(,!)
3.2. Model development
We will begin in this section by formulating a two-stage or two-level model and then show its
relationshiptothegenerallinearmixedmodel.LetZ
!
denotethen !!qmatrixofobservationlevel
covariatesforsubjecti.Typicallythefirstcolumnisavectorofonesfortheintercept,buttherest
ofthecolumnsmustbevariablesthatvarywithinthesubject(observationlevelcovariates).Itis
notnecessarythat thevaluesvarywithineverysubject,thatis,Z maybelessthanfullrankfor
!
some individuals, but by definition, Z contains the observation level covariates and should
!
consistofvariableswhichmodelwithin-subjectvariation.Forexample,intheschizophreniatrial,
wemightpositthattheresponseovertimeforeachsubjectfollowsaquadraticcurve.Inthiscase
Z
!
would be n !!3; the first column would be all ones, the second would be the time of the
observation,and the third would be time squared.
Parenthetically, when modelling time trends, it is often desirable to use orthogonal poly-
nomialsfornumericalstabilityorinterpretation.Indoingso,itisimportanttouseasinglesetof
orthogonal polynomials for all subjects, even though different subjects may be observed at
differenttimes. In the schizophreniadata set we could use the protocoldesign, that is observa-
tions at weeks 0, 1, 2, 3, 4, 6 to calculate our orthogonal polynomials. Then Z would be
!
orthogonalonlyforthesubjectsobservedatallsixoccasions,butthemeaningofthecoefficients
remains the same for each subject. The first-stage (or level one, observation level) regression
model is given by
y !# "z !#!! #e !# , i"1,2,N (1)
where!
!
representstheq!1vectorofregressioncoefficientsfortheithsubject,z
!#
isthejthrowof
Z,andthee arezeromeanerrorterms.The! representinherentcharacteristicsofthesubjects,
! !# !
for example, parameters of a subject’s ‘true’ growth curve, and the e can be thought of as
!#
sampling error, or random perturbations. The e are typically taken to be independently and
!#
identicallydistributedwithvariance"".Incaseswheretheobservationshaveaclearorderingor
structure,someinvestigatorsalternativelyassumethatcorrelationamongthee isnon-zero,and
!#
varies in a systematic way. For example, with equallyspaced points in time, one might assume
simple autoregressive structure (AR1) for var(e
!
), where e-
!
"(e
!!
,2,e
!$
!
). When the e
!
can be
thoughtofasmeasurementorsamplingerrortheassumptionofindependenceisnatural.Welet
R"var(e). In the second-stage regression (or level two, subject level), the ! are regarded as
! ! !
! 1997byJohnWiley&Sons,Ltd. Statist.Med.,16,2349—2380(1997)

2358 A.CNAAN,N.M.LAIRDANDP.SLASOR
N independent q-dimensional random vectors, hence the term random regression coefficients.
Theirmean dependsuponsubjectlevelcharacteristics.Leta denotethevector ofsubjectlevel
%!
characteristicswhichaffectthemeanofthekthcoefficient.Tomodeltheleveltworegression,we
assume the ! are independently distributed with
!
E(! )"A" (2)
! !
where
a- 0 2 0
!!
0 a-
"!
A"
!
#
0 . 2 a-
&!
"-"("-
!
,2,"-
&
).
andthe " ’s are regression parametervectors,of varying length dependingupon the number of
%
subject level covariates (in a ) which affect the mean of the kth coefficient. We further assume
!%
var(!)"D.
!
ThediagonalelementsofD(aq!qmatrix)tellushowmuchtheindividualregressioncoefficients,
the !, vary from subject to subject, after adjusting for the covariates in A. Thus the D matrix
! !
models the between-subject variance, while the "" from level one models the within-subject
(observation level) variance.
Because we have specified a linear model for the mean of !! , it is convenient to write !! as
!"A"#b
! ! !
whereA"areasdefinedabove,andtheb areindependentandidenticallydistributedwithzero
! !
meanandvarianceD.Hereeachb canberegardedastheithsubject’srandomdeviationfromthe
!
mean (A"). Rewriting equation (1) in vector and matrix notation we have
!
y"Z!#e
! ! ! !
which in turns implies
y"Z A"#Zb#e . (3)
! ! ! ! ! !
As a result
E(y)"ZA "
! ! !
and
var(y)"Z DZ-#R.
! ! ! !
Noticethatwhenwecombinethetworegressionsintoasinglemodelfortheresponseasin(3),we
havetwotypesofregressionparameters,the",andtheb’s (sincethereareNsubjectsthereare
!
Ndifferentb’s).The"parameterisoftentermedthefixedeffect,incontrasttotheb’s,whichare
! !
calledrandomeffectsorrandomcoefficients.Theb’scanalsobeviewedaserrortermssinethey
!
are random variables with zero mean.
Statist.Med.,16,2349—2380(1997) ! 1997byJohnWiley&Sons,Ltd.

2359
USINGTHEGENERALLINEARMIXEDMODEL
Theformofthedesignmatrixforthefixedeffectsinmodel(3)impliesthatanyobservationlevel
variablesmustbespecifiedasrandomeffectsiftheyaretobeincludedinthemodel.Thiscanbe
an unattractive modelling strategy in situations where there are several observation level vari-
ables or they are all indicator variables, as in cross-over designs. One way to avoid this
requirementistoforcecomponentsofDtobezero.Alternatively,themodelismademuchmore
flexible by replacing Z A by an arbitrary design matrix X, and writing
|     | !   | !   |     |         | !   |     |
| --- | --- | --- | --- | ------- | --- | --- |
|     |     |     | y"X | "#Z b#e | .   | (4) |
|     |     |     | !   | ! ! !   | !   |     |
Equation (4) defines what we call the general linear mixed model. We use the term general
linear mixed model to emphasize that X, Z and R can be quite general; other versions of the
|     |     |     |     | ! ! ! |     |     |
| --- | --- | --- | --- | ----- | --- | --- |
modelplaceimplicitconstraintsononeorallofthesematrices.Themodelhastwotypesoferror
terms: the b are the random subject effects and the e are observation level error terms. In the
|     | !   |     |     |     | !   |     |
| --- | --- | --- | --- | --- | --- | --- |
generallinearmixedmodelweassumeonlythattheb ! ande ! areindependentlydistributedwith
| zero mean | and variances | D and R, | respectively, | implying | that |     |
| --------- | ------------- | -------- | ------------- | -------- | ---- | --- |
!
E(y)"X"
|     |     |     |     | ! ! |     |     |
| --- | --- | --- | --- | --- | --- | --- |
and
|                  |              |        | var(y)"ZDZ-#R |             | .   |     |
| ---------------- | ------------ | ------ | ------------- | ----------- | --- | --- |
|                  |              |        |               | ! ! !       | !   |     |
| 3.3. The general | linear mixed | model: | estimation    | and testing |     |     |
Under the assumption that the b ! and e ! are independently distributed as multivariate normal,
estimation of the parameters by maximum likelihood (ML) is straightforward."# The variance-
covarianceparameterscanalsobeestimatedusingRestrictedMaximumLikelihood(REML).As
thenameimplies,theREMLestimatesmaximizethelikelihoodoftheerrorcontrasts,ratherthan
thefulldata,andareoftenpreferredoverMLestimatessincetheyyieldwellknownmethod-of-
moment estimators in balanced cases which have closed form solutions.
| The maximum | likelihood | estimate | of "   | is given by |         |     |
| ----------- | ---------- | -------- | ------ | ----------- | ------- | --- |
|             |            |          | "ˆ"(!X | -VK .!X )!X | -VK .!y | (5) |
|             |            |          |        | ! ! !       | ! ! !   |     |
where
|     |     |     | V"var(y)"Z | DZ-#R |     |     |
| --- | --- | --- | ---------- | ----- | --- | --- |
|     |     |     | !          | ! !   | ! ! |     |
and VK is V with D and R replaced by their ML estimators. In practice, REML estimators are
| ! ! |     | !   |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- |
oftenusedtoestimateV.Theestimatorof"definedinequation(5)isalsocalledtheGeneralized
!
LeastSquares(GLS)estimatorbecauseitisinversevarianceweightedleastsquares,whereeach
subject’sestimatedvariance,V# ,determinestheirweightintheestimationof".Thevarianceof"L is
!
| usually estimate | by  |     |             |         |      |     |
| ---------------- | --- | --- | ----------- | ------- | ---- | --- |
|                  |     |     |             | -VK .!X | ).!. |     |
|                  |     |     | var("ˆ)"(!X | ! !     | !    | (6) |
TheGLSestimator(andhencetheMLestimator)of"hasgoodoptimalitypropertiesthathold
withouttheassumptionofnormalityfortheerrorterms(e andb).Itisconsistent,asymptotically
! !
normal,andfullyefficientifV correctlyspecifiedthevar(y).Ifwehavemisspecifiedthevariance,
|     |     | !   |     |     | !   |     |
| --- | --- | --- | --- | --- | --- | --- |
so that var(y)OV, ! ! "ˆ is still consistent and asymptotically normal, but not fully efficient, and
! 1997byJohnWiley&Sons,Ltd. Statist.Med.,16,2349—2380(1997)

2360 A.CNAAN,N.M.LAIRDANDP.SLASOR
equation (6) is not a valid estimate of var ("ˆ). Liang and Zeger"$ suggest using an alternative
estimator of var("ˆ) which is valid when var(y)OV
! !
var("ˆ)"(!X
!
-VK
!
.!X
!
).! !X
!
-VK
!
.!(y
!
!X
!
"ˆ)(y
!
!X
!
"ˆ)-VK
!
.!X
!
(!X
!
-VK
!
.!X
!
).!.
Because this estimate of var("ˆ) is not currently available via commercial software, we do not
consider it further. Tests for covariance structure are considered in Section 3.5.
ThreeapproachesareusedtotesthypothesesoftheformH :C""0.Likelihoodratiotestscan
*
be used with large samples, providing one uses ML, rather than REML, for model fitting.
StandardWaldtestsarewidelyavailable;thesearealsoasymptotically$".ApproximateF-tests
for class variables can be carried out by dividing the Wald test by the numerator degrees-of-
freedom and approximating the denominator degrees-of-freedom. All of these tests are large
sample,andmoreresearchonsmallsampleadjustmentsisneeded."%Aswithordinaryunivariate
regression,normalityof theerrorsisnotrequiredforasymptoticnormalityoftheestimateof",
buthighlyskewederrordistributionscanleadtoinvalidtestsandconfidenceintervals,thusitis
wise to consider transformations to promote normality, if appropriate.
Sometimes it is useful to have estimates of the individual random effects, the b’s, or equiva-
!
lently,the!’s.Therandomeffectsareestimatedusing‘shrinkage’orempiricalBayesestimators
!
whichrepresentacompromisebetweenestimatesbasedonlyonanindividualsubject’sdata,and
estimatesbasedonlyonthepopulationmean.Theseestimatescanbeusedtoconstructindividual
growth curves for each subject, as we illustrate with the FEV data (Section 2.2). For example,
!
Tsiatiset al."& used estimatesof individualtrajectoriesof CD4counts to study the relationship
betweenfallin CD4countanddiseaseprogressioninAIDS.Subjectswithsubstantialdatawill
have estimates close to their individual least squares curves, whereas subjects with sparse data
willhaveestimatesclosetothepopulationmean.Theseshrinkageestimatorsarealsoknownas
best linear unbiased predictors (BLUP)."’
3.4. Model selection
Selectingamodelmeansspecifyingadesignmatrixforeachsubject,X,therandomeffects(orZ),
! !
and the variance-covariancestructure for e , R. In many cases, the mean parameters, or ", are
! !
thoseofmostinterestandtherandomeffectsandcorrelationstructurecanbeviewedasnuisance
quantities.Evenin this lattercaseitis importanttomodelvar(y)carefully,sinceit affectsboth
!
the efficiency of "ˆ, and the validity of the estimate of var("ˆ).
BecauseE(y)"X ", the mean parameters are determinedentirely by the design matrixX; it
! ! !
can includeany arbitrary combinationof subjectleveland observationlevel covariatesthatwe
desire.TheZ matrixspecifiesthedesignfortherandomeffects.Itmustcontainonlyobservation
!
levelcovariates,apartfromanintercept.Ingrowthcurvestudiesittypicallycontainsthedesign
on time or age. Whereas X determines our specification for the mean, the Z matrix, or
! !
specificationofrandomeffects,onlyaffectsvariance.Toseethis,notethatitispossibletospecify
no random effects so that Z"0. Here we still have E(y)"X " but now var(y)"R. Thus, in
! ! ! ! !
manycasestheuseofrandomeffectscanbeviewedsimplyasadeviceformodellingcorrelation
structure.
3.4.1. Modelling the mean
Although it is technically possible to specify X and Z independently, in the case where we do
! !
choosetoincluderandomeffects,therearesomeguidelinesoneshoulduseinchoosingmodels.In
Statist.Med.,16,2349—2380(1997) ! 1997byJohnWiley&Sons,Ltd.

USINGTHEGENERALLINEARMIXEDMODEL 2361
general, the columns of Z should be a subset of the columns of X to avoid the problem of
! !
specifyingas ‘errorterms’ effects whichdo not havezero mean. Toreturn to our schizophrenia
example(Section2.1),wecouldassumethataquadraticcurveisneededtocharacterizethemean
responseforeachsubject,implyinganinitiallargeeffect,followedbyalevellingoffoftheeffect.
WewouldnotwanttoincludeaquadraticeffectinZ andomititinthemean(X),sincethismodel
! !
wouldimplythateachsubjecthadaquadraticcurve,butthatthepopulationcurvewaslinear.
Alternatively, omitting observation level effects from Z that are contained in X can lead to
! !
serious underestimation of the standard errors of "ˆ. Consider the case where we fit linear time
trendsforthemean,butassumethatonlytheinterceptsarerandom.Inthiscase,Z isacolumnof
!
ones for each subject, and, if R
!
is taken to be ""I, then the variance of y
!
has the compound
symmetry assumption. This assumption will cause the estimated standard errors of estimated
slopestobetoosmallifitfailstohold.Includingthelineartermasarandomeffectcorrectsthis
problem."( Assuming R has a richer structure is an alternative solution.
!
Oneadvantageofthetwo-stageapproachtomodellingisthatifX"AZ ,whereA contains
! ! ! !
all the subject level covariates and Z contains all of the observation level covariates, then the
!
Z are necessarily a subset of X and any observation level variables modelled in X are also
! ! !
containedinZ.RecallthatA containsthevectorsofcovariates,a ,fortheregressionofthekth
! ! %!
elementof! onsubjectlevelvariables.Eachofthecomponentsin! mayhaveadifferentsetof
! !
predictorcovariates.Inmostsettingstherewillbeconsiderableoverlapinthecovariateset,and
we may want to assume a "a for all k.
%! !
Tofix ideas,considertheschizophreniastudy (Section2.1) wherewefit aquadraticresponse
function in time, so that each Z
!
is n !!3 with an intercept, a linear and a quadratic term. The
subjectlevelcharacteristicsarecentreandtreatmentgroup.Theregressionmodelwechoosefor
A will depend upon how we have parameterized time. Suppose we do not use orthogonal
!
polynomials so that the intercept estimates baseline (or prerandomization) means. We would
certainlywanttoincludecentreasapredictorofbaselinemeanssinceweknowthatmeanBPRS
scores are different at baseline. This may be due to differences in centre populations or to
differences in interpreting the BPRS rating system. We could have centre as a predictor of the
slope and quadratic terms as well to account for possible systematic differences in time trends
from centre to centre. However, if data are sparse at the centre level, we might fit a more
parsimonious model, omitting centre as a predictor of the quadratic or linear and quadratic
terms.Sincethestudyisrandomized,treatmentisformallynotapredictorofintercept,although
itispreferabletoincludeitinthemodel,toavoidpossiblemodelmisspecification.Thuswewould
includebothcentreandtreatmentina .Ifwewanttotestfortreatmenteffects,wewouldomit
!!
treatment as a predictor for both the linear and quadratic terms, and compare the results to
modelsfitincludingtreatmentasapredictorofthelinearorthelinearandquadraticterms.Ifwe
useorthogonalpolynomials,thentreatmenteffectswouldalsohavetobetestedbylookingatthe
effect of treatment on the intercept, which now estimates a mean level over all times. Since the
groups were designed to be equivalent at baseline, testing for a treatment difference in a mean
levelwhichincludesbaselineisnotverycompelling.Noticethatthe‘main’effectsareallspecified
bytheregressionoftheinterceptona andtheremainingportionsofA specifyinteractionsof
!! !
subject level and observation level variables.
When the observation level variables are class variables, as in cross-over and many other
repeatedmeasuresdesigns,usingrandomeffectsbeyondarandominterceptisnotnatural,hence
themoregeneralformofX isuseful.Inacross-overstudy,onechoiceofX mightbeacolumnfor
! !
the intercept, ¹!1 columns for the ¹ treatments and P!1 columns for the P periods (or
! 1997byJohnWiley&Sons,Ltd. Statist.Med.,16,2349—2380(1997)

2362 A.CNAAN,N.M.LAIRDANDP.SLASOR
occasions), all of which are observation level covariates. However, Z can still include only
!
arandomintercept.Inmanylongitudinalstudieswithasmallnumberofobservationspersubject
itmayalsobeattractivetouseclassvariablestomodelthemeanresponseovertime.Thisallows
onetomodelthedatawithoutmakinganyassumptionsabouttimetrend,ratherthanassuming
aparametricmodelforhowthemeanresponse variesasafunctionoftime.Forexampleinthe
schizophrenia study, there are six possible observation times. One could use three columns of
X forintercept,linearandquadraticterms.Alternatively,onecouldusefiveindicatorvariablesto
!
uniquely define the observation times.
Anotherissuethatoftenarises,especiallyinthecontextoflongitudinalclinicaltrials,ishowto
handletheresponsemadeatbaseline.Itcanbeincludedaspartoftheresponsevector,oronecan
usethebaselinemeasurementasasubjectlevelcovariateinX,oronecansubtractthebaseline
!
responsefromeachsubsequentresponseand modelthe vectorofchanges.In theschizophrenia
study (Section 2.1), the first approach implies that each subject has six observations. The time
trend(linearorquadratic)isfitfrombaselinetoweek6.Thesecondapproachimpliesthateach
subjecthas five observations and the interceptin the model is part of the treatment effect. The
coefficient of the baseline covariate captures the changes in response from baseline to week 1,
while the time trend coefficients capture changes from week 1 to week 6. In both approaches,
because there are large differences in the response at baseline between centres, 12 indicator
variables for the 13 centresare requiredin X for centre effects. However, in the first approach,
!
because the baseline is part of the response, one might need additional 12 or 24 variables for
centre by time linear or linear and quadratic interactions.In the second approach, because the
baselineinnotpartoftheresponse,andthetimetrendcoefficientsmodelonlythechangesfrom
week1toweek6,thereisapotentialforsimplermodelswithoutcentrebytimeinteractions.The
thirdapproachofusingchangesfrombaselineratherthanbaselineasacovariateisappealingto
clinicians, but is generally less statistically efficient.
3.4.2. Modelling the Variance
Thevarianceofy ,V"ZDZ-#R,isdeterminedbyhowwemodelR andtherandomeffects.
! ! ! ! ! !
One commonly used strategy is to set R
!
"""I, and use random effects to give additional
structure to V
!
. For example, in the schizophrenia study, setting R
!
"""I implies independence
between observations within the subject. If Z
!
is the n !!3 vector with intercept, linear and
quadratictimetrends,thenDisa3!3matrixwhichprovidestheadditionalstructuretoV
!
.This
generallyworkswellwhenwearefittingparametriccurvesinlongitudinalstudies;itisespecially
usefulwhensubjectsareobservedatalargenumberofirregulartimes.Alimitingfeatureisthatif
eachsubjectisobservedononlyafewoccasions,lackofidentifiabilityandconvergenceproblems
can occur even for only two or three random effects. This strategy is also limiting when we are
usingindicatorvariablestomodelthetimecourse,becauseitimpliesestimationofn!(n#1)/2
parameters in the matrix, which may be a large number and result in poor estimation.
Attheotherextreme,wemayassumenorandomeffects(Z"0),andputadditionalstructure
!
onR.Ifeachsubjecthasobservationsatthesamesetof¹occasions,and¹ismodestrelativeto
!
N, we may choose to let R be an arbitrary ¹!¹ correlation matrix. Because R can be totally
arbitrary (positive definite) R can be called an ‘unstructured matrix’. If a subject is missing an
observation, R is R with the rows and columns corresponding to the missing observations
!
removed. In the schizophrenia study, since there are ¹"6 possible observation points and
N"245, we use this approach. This strategy is also attractive for modelling multivariate data,
Statist.Med.,16,2349—2380(1997) ! 1997byJohnWiley&Sons,Ltd.

USINGTHEGENERALLINEARMIXEDMODEL 2363
whereeach componentof y is a differentvariable,rather than arepeatedmeasure on the same
!
variable.Forexample,ifwewishtomodelheight,weightandarmcircumferenceasafunctionof
age and sex, the response variable has three components which are not repeats on the same
variable, and an arbitrary R may be the only logical choice for a variance structure.
Diggle") proposed a useful model which can be viewed as an extension of the general linear
mixedmodel.Hesuggestsusingasinglesubjecteffect(b isscalarandZ avectorofones),setting
! !
var(e
!
)"""
’
I, and introducinga third random error vector,say r
!
, which has an autoregressive
error structure. Specifically, he assumed var(r
!
)"""
(
, and that the correlation between r
!#
and
r dependsonlyonthedistanceortimebetweentheobservations.Hesuggestsseveralparametric
!%
formsforthecorrelationswhichmodelitasadecreasingfunctionofincreasingtime.Thismodel
has the attractive feature that the variance and correlation are modelled with only a few
parameters,evenwhentherearemanydifferentobservationtimes,thecorrelationishighestfor
measurementsclosetogetherintime,butdoesnotnecessarilygettozeroevenformeasurements
madefarapart.AnadvantageoftheDigglemodelisthatitallowsonetomodelcorrelationwith
very irregularly spaced intervals using only one random effect. It does still assume constant
variance over time. In the longitudinal data setting, this assumption is often violated. For
example,inmodellinggrowthdata,valuesatadolescencemayshowmuchmorevariabilitythan
early childhood data.
SpecifyingR andtherandomeffectsinvolvesatrade-off.Ifthenumberofrepeatedmeasuresis
!
small,saylessthan5,andNissubstantial,sayatleast100,themostattractivestrategymaybeto
set Z"0 and let R be arbitrary. With larger numbers of repeat observations, some modelling
! !
strategy which incorporates random effects is attractive. This is especially true for longitudinal
datawhichishighlyunbalanced,forexample,observationsaremadeatarbitrarytimesleadingto
a highlyunbalanceddata setsuch as in data registries involvingpatientfollow-up. In this case,
setting R
!
"""I and using random effects may be the only feasible strategy. The Diggle")
approach is one that has been used successfully to model FEV data (Section 2.2).!’
!
ItisnotpossibletoincludeanarbitrarysetofrandomeffectsandletR becompletelygeneral,
!
becausethisresultsinoverparameterization.Considerthefollowingsimplecase.Ifwespecifythat
R has compound symmetry structure and let Z be a vector of ones, then V is the sum of two
! !
matriceswithidenticalstructure(constantvarianceon the diagonaland samecorrelationatall
positionsoffthediagonal)andtheyarenotseparatelyidentifiable.Withlargenumbersofrepeat
measures,itispossibletofitseveralrandomeffectsandspecifysomenon-saturatedstructurefor
R, such as autoregressive, but general rules for identifiability of model parameters are not
!
available.Asimpleapproachthatseemstoworkwellinmanysituationsistoeitherloadupthe
variance in the random effects and set R
!
"""I, or set Z
!
"0 and allow R
!
to be arbitrary.
Practical experience suggests that the simple compound symmetry assumption, which involves
settingR
!
"""Iandusingasinglerandomsubjecteffect(intercept),typicallyfailstoadequately
model the variance structure. Often adding just a single additional random effect is adequate.
3.5. Model checking
Manyissuesofmodelsensitivityandcheckinggoodness-of-fitareexactlythesameasthosewhich
ariseinordinaryleastsquaresregression.Thestandardresidualdiagnosticscanbehelpful; it can
also be useful to look at residuals stratified on time (in longitudinal studies) or by subject.
Waternauxetal.#*suggestmethodsforoutlierdetectionbasedontheempiricalBayesestimatesofthe
subject random effects. They can help identify outlying subjects, rather than outlying observations.
! 1997byJohnWiley&Sons,Ltd. Statist.Med.,16,2349—2380(1997)

2364 A.CNAAN,N.M.LAIRDANDP.SLASOR
Oneissuethatisdifferentfromordinaryunivariateregressionisthatamodelmustbespecified
for var(y). Likelihood ratio tests based on the REML likelihoods can be used informally for
!
comparingnestedmodelsforvar(y
!
),buttheasymptotic$"distributionfailstoholdbecausethe
nullhypothesiscorrespondstoaboundaryvalue.Somecomputerpackagesgivegoodness-of-fit
measuresbasedonSchwartz’sBayesianCriterionandtheAkaike’sInformationCriterion.Both
ofthesearefunctionsofthelikelihood,withapenaltyforthenumberofcovarianceparameters.
Forbothcriteria,largervaluesimplybetterfittingmodels,andcanbeusedtocomparenon-nested
models.Moreinformally,inthebalancedsetting,onecancompareafittedmodelwiththeempirical
covariancematrix,whichisobtainedbyfittingtheunstructuredvariancemodel.Thisispreferable
tousingthe‘allavailablepairs’estimateavailablefromsomesoftwarepackages,sincethelattermay
be biased by missing data. Diggle") and Laird et al.!) illustrate the use of the empirical semi-
variogram to check model adequacy of the correlation structure in more complex settings where
modelsarenotnested;itisnotcurrentlyavailablewithsoftwareforthegenerallinearmixedmodel.
3.6. Missing data
Fromatechnicalpointofview,itiseasytohandlemissingresponsesintheoutcomesincethereis
norequirementthatalln areequal,orthatsubjectsaremeasuredatthesamesetofoccasions.All
!
thatisrequiredisthatthedesignmatrixandcorrelationstructurecanbespecifiedforthevector
of responses that are observed. A bigger issue is the validity of the estimates in the presence of
missingdata.Ifthemissingnessisunrelatedtooutcome,thentheMLestimatesarevalidandfully
efficient.ThisisprobablythecasewithmostmissingnessintheFEV dataset(Section2.2)since
!
datawerecollectedinschool,andmissingnesswasrelatedtoschoolattendance,andlikelynotto
child FEV .
!
Theprobability of missingness may often be related to covariates; in principle this causes no
difficulty but in practice it implies one should take care in the process of model selection. For
example,supposechildrenwhosmokearelikelytohavepoorerattendancerecords,orleavethe
schoolearly.IfsmokingaffectsFEV ,thentheprobabilityofmissingnessisindirectlyrelatedto
!
outcome.Inthiscase,smokingstatusshouldbeusedasasubjectlevelcovariateinthemodelfor
FEV in order to avoid bias due to missing data. The parameter estimates would then model
!
meanresponseconditionalonsmoking.IfwewanttoestimatethemarginalmeanFEV ateach
!
age, unconditional on smoking, we will need to take the appropriate weighted combination of
smoker and non-smoker means.
If missingness is related to observed responses but not missing ones, termed Missing at
Random(MAR)byLittleandRubin,#!thentheestimateswillbevalidandfullyefficientprovided
thatthemodelassumedforthedatadistributioniscorrect.Dropoutsinlongitudinalstudiesare
sometimesregardedasMARifonecan arguethatthelikelihoodof droppingoutonlydepends
upon (observed) past history, and not on future values. In the schizophrenia trial (Section 2.1),
Coxregressionanalysiswasusedtoshowthattheprobabilityofdiscontinuingonprotocol,and
hencesubsequentmissingness,wasstronglyrelatedtochangesinBPRS.ThevalidityoftheML
analysis that we present rests on the assumption that conditional on their observed BPRS
outcomes,treatmentgroupandcentre,thefutureBPRSvaluesofadiscontinuedsubjectcanbe
predictedfromtheassumedmultivariatenormaldistribution.Theimplicationofthisisthatthe
distributionoffuturevaluesforasubjectwhodropsoutattimetisthesameasthedistributionof
futurevaluesforasubjectwhoremainsinattimet,iftheyhavethesamecovariates,andthesame
past history of outcome until and time t.
Statist.Med.,16,2349—2380(1997) ! 1997byJohnWiley&Sons,Ltd.

USINGTHEGENERALLINEARMIXEDMODEL 2365
Ifdropoutdependsuponsomeotherprocesswhichisrelatedtooutcome,thenconditioningon
pastoutcomesmaynotcaptureallofthedependenceofdropoutonfuture(unobserved)outcome,
andthedropoutprocessisinformative,ornonignorable.Forexample,intheschizophreniatrial,
discontinuing on protocol might have reflected decisions based on physician assessment of
patientconditiononlyweaklyrelatedtoBPRS.TheCoxregressionshowsthatBPRSisstrongly
predictive of discontinuation, and is consistent with the assumption that the missingness is at
random, but does not preclude a non-ignorable mechanism.
Thegeneralcaseofnon-ignorablemissingnessoccurswhentheprobabilitythataresponseis
missingis directlyrelatedtothemissingoutcome.Forexample,intrialsofpatientsundergoing
chemotherapy treatment for cancer, quality-of-life assessments may be required on a quarterly
schedule.Mostquality-of-lifeformsareself-reportandmayrequiresubstantialeffortonthepart
ofthe patient.Patientswho are experiencingpoorquality-of-lifearelikelyto be farless able to
complete the self-report required for response. Obtaining valid estimates of population para-
meters in this setting is far more complicated, since we are in a situation of having to make
assumptionsaboutthedistributionofthemissingoutcomeswhichcannotbefullytestedbythe
data.
4. SOFTWARE FOR MAXIMUM LIKELIHOOD ANALYSIS OF GENERAL LINEAR
MIXED MODEL
Several statistical software packages are available for the analysis of correlated data. These
includeBMDP-5V,SAS,andML3,amongother.HLMandS-plusareotherprogramsavailable,
but these are restricted to analysis of random effects models, and are not discussed here.
Most of the software packages offer a choice between maximum likelihood and restricted
maximumlikelihoodestimation.Theoptimizationalgorithmmay bechosenas Newton—Raph-
son,FisherScoring,ortheEMalgorithm.The useris requiredto specifyan equationfor mean
response that is linear in the fixed effects, and to specify a covariance structure. The user may
select a full parametrization of the covariance structure (unstructured) or choose from among
structured covariances which are more parsimonious. The covariance structure is also deter-
mined by inclusion of random effects and specification of their covariance structure.
Output generated includes a history of the optimization iterations, estimates of fixed effects,
covarianceparameters,andtheirstandarderrors.Estimatesofuser-specifiedcontrastsandtheir
standard errors are also printed. Graphics facilities for these software packages are currently
limited.Parameterestimates,fittedvaluesandresidualsproducedfromamodelrunmaybesaved
as data sets, and supplied to programs suited for graphics.
SAS PROC MIXED was designed for the analysis of mixed models. It providesa very large
choiceofcovariancestructures.In additiontotheunstructured,randomeffectsandautoregres-
sive,itcanfittheDigglemodelwithR
!
"""I#S
!
,whereS
!
canhaveoneofseveralautoregres-
sive structures. In addition, covariance can be specified to depend on a grouping variable.
Separate analyses can be run on subgroups of the data through use of a single BY statement.
PROCMIXEDconvenientlyprovides empiricalBayes estimates(random effects andpredicted
values).SASconstructsapproximateF-testsforclassvariablesbydividingtheWaldtestbythe
numerator degrees-of-freedom and approximating the denominator degrees-of-freedom. All
componentsoftheSASoutput,suchasparameterestimates,residualsandcontrastmatrices,can
be saved as data sets, for purposes of graphics or manipulation by other SAS procedures. The
FEV data set (Section 2.2) was analysed using SAS.
!
! 1997byJohnWiley&Sons,Ltd. Statist.Med.,16,2349—2380(1997)

2366 A.CNAAN,N.M.LAIRDANDP.SLASOR
BMDP-5V was designed for the analysis of unbalanced repeated measures data. It also
provides a large variety of options for the covariance structure, and for estimation. The data
set-up is different between SAS and BMDP. In SAS PROC MIXED, every observation within
asubjectconstitutesaline,orarecord.InBMDP5V,thelineorrecordistheentiresubject,with
allitsobservations.ThismakesBMDPparticularlyusefulandeasytomanipulatewhenstudies
are planned to be complete and balanced. It also allows one to very easily see the patterns of
missingness.However,for epidemiologicalstudies,whichare inherentlyunbalanced,settingthe
data up in BMDP may be awkward. The schizophrenia case study (Section 2.1) was analysed
usingBMDP.BMDPprovidesaWaldtestto examineoveralleffectsofclass variables,such as
clinic, in the schizophrenia study. This is similar to the F-test provided by SAS.
SeveralmodelswererunbothinBMDPandSAS.Resultswereidenticaluptofourthdecimal
place for the log-likelihood, regression coefficients estimates and their standard errors, and
estimatesofcovarianceparameters.BothSASPROCMIXEDandBMDP-5V,aspartsoflarger
packages,havetheflavouroftheirparentpackages.Inbothprograms,inordertorunadifferent
model on the same data set, one needs to enter the editor, change the model specificationsand
then rerun the program. This is somewhat short of fully interactive.
ML3, which stands for Software for Three Level Analysis, was developed for applications
within the fields of education and human growth.#" Nutall et al.## used ML3 for modelling
achievementscoresin96schoolsinLondon,wheretheobservationswereonindividualstudents
and the clusters were schools. Input and manipulation of data are very similar to MINITAB,
makingitrelativelyeasytouseforMINITABusers.Theprogramishighlyinteractive.Theuser
setsthemodel,andwithaonewordcommandseesthespecifications.Theusercanrunthemodel,
andview, save, or print out what they want to see, and in the same session, simply change one
parameter,forexample,addafixedeffect,andrerunthemodel.Inthatinteractiveenvironment,
ML3 is somewhat more convenient to use than either BMDP or SAS, which require an actual
separate batch run, when the user wishes to change one thing in the model.
5. CASE STUDIES ANALYSIS
5.1. Schizophrenia clinical trial
5.1.1. Design considerations
Theclinicaltrialinschizophrenia(Section2.1)isatypicalexampleofastudywithapre-planned
repeatedmeasuresdesign,inwhichincompletedataresultedfromstudydropouts,necessitating
the use of the mixed model, instead of the regular repeated measures approach. Because there
wereonlysixdifferentobservationpoints,and245subjects,weusedanunstructuredcovariance
matrixintheanalysis.Inaddition,wefocusedonthenatureoftherateofchangeinBPRSacross
time.Thefactthattherewereonlysixdifferentobservationpointsenabledustoconstructmodels
with indicator variables for all observation points, reflecting no specific trend across time, and
compareanyfittedfunctionoftime(suchasalinearorquadratictimetrend)withthemodelwith
indicator variables to examine goodness-of-fit.
Inordertostabilizepolynomialeffectsinthetimetrends,wechosealocationtransformation
by subtracting three weeks from the week number, which makes the data for the linear and
quadraticeffectsforsubjectswithcompletedatanearlyorthogonaltoeachother.Inamodelwith
a linear or a linear and quadratic effect using the untransformed time scale, the estimate of the
Statist.Med.,16,2349—2380(1997) ! 1997byJohnWiley&Sons,Ltd.

USINGTHEGENERALLINEARMIXEDMODEL 2367
intercept reflects an estimate of BPRS score at baseline. In a model using the suggested
transformedtime scale, the estimate of the intercept reflects the mean BPRS at three weeks. In
alinearmodel,thelinearcoefficientreflectingthelinearrateofchangeofBPRSwithtimeremains
thesame,regardlessoftransformation.Inthequadraticmodel,however,thequadraticcoefficient
remains the same after the transformation, but the linear coefficient changes as a results of the
transformation.
5.1.2. Model selection and testing
OurfirstapproachtotheanalysiswastouseBPRSscoresfromallsixobservationsasresponse
variablesy
!#
,iindicatingsubjectnumberandjindicatingtheobservationnumber(j"1,2,6).
Wecomparedmodelswithlinearandquadratictimetrends(observationlevelcovariates)tothe
model withindicator variablesfor each time point. We chosenot to fit trends withtime higher
thanquadraticbecausethosearedifficulttointerpretinthisstudy.Acombinationoflinearand
quadratic effects can be interpreted as a decrease in BPRS scores linearly with time, and the
decreaseislargerinitially,andthenlevelsoff,hencethequadraticterm.Plotsofthedatasupport
thisinterpretation.We also added first-orderinteractionsboth betweensubject-levelcovariates
(for example, treatment!centre) and between subject and observation level covariates (for
example, treatment!week). The model with a quadratic effect for time, as well as a quadratic
effectfor the interactionbetween time and centre provided a substantiallybetter log-likelihood
than the model with indicators at each time point and without a time by centre interaction,
althoughata cost of estimating21 moreparameters.A directlog-likelihoodcomparisonis not
possible, since these models are not nested.
There were several unattractive features in this quadratic model. The first is the time—centre
quadratic-interaction. While it is not surprising that the centres had different baseline BPRS
means (reflecting either somewhat different patient populations at the centre or somewhat
different interpretations of the BPRS scoring systems), it is unexpected to see a strongly
significantlydifferentchangeacrosstimebetweenthecentres,giventhatallcentresgavethesame
treatmentsaccordingtothesameprotocol.Moreover,acloseexaminationofthewithin-subject
correlationsfromtheestimatedmodelshowsstrongercorrelationsbetweenallobservationpoints
beyond baseline than correlations with the baseline values, and a tendency of decreasing
correlationswithincreasingtimedifferences.Finally,a quadratictrendwithoutthe time—centre
quadraticinteractiondidnotprovideafitthatwascomparabletothemodelwithnoassumptions
onthetimetrend.Observingalsothat36percentofthebaselinevariabilityinBPRSisexplained
by centre alone, we chose to fit subsequent models using the baseline BPRS score as a subject
level covariate, rather than a response.
TableIIIgivestheBMDPresultsofmodelsfittedtothedatapresentedasfiveresponsevalues
(weeks1, 2, 3, 4, 6), with the baseline BPRS score as a subjectlevel covariate.This reduced the
numberofsubjectsincludedinthemodelfrom245to233,since12subjectshadnoobservations
beyond baseline, and thus no responses in these models. Adding the baseline BPRS score as
asubjectlevelcovariatereducedsubstantiallythevariabilitytobefitbyothertermsinthemodel,
suggesting that the approach to analysing the data as at most five responses rather than six
responseswaspreferable.Inmodels1and2,timeisenteredaslinearandquadraticobservation
levelterms;model2alsocontainsasubjectlevelmaineffectoftreatment.Acomparisonbetween
models1and2showsthattheadditionofatreatmenteffectwasnotsignificant.Theadditionof
adifferentlineartrendintimeamongthetreatments(observationlevel)wasalsonon-significant
! 1997byJohnWiley&Sons,Ltd. Statist.Med.,16,2349—2380(1997)

2368
A.CNAAN,N.M.LAIRDANDP.SLASOR
Table III. Models for schizophrenia study. Baseline BPRS and centre are included as covariates in all
models
Model Variablesinmodel MLlog- Numberof Baseline Week Week" Testeffect p-value
| numbers |     | likelihood | regparms BPRS | coefficient coefficient |     |     |
| ------- | --- | ---------- | ------------- | ----------------------- | --- | --- |
coefficient
| 1   | Week,week"      | !3266·33 | 16 0·65 | !1·55 0·38 |     |      |
| --- | --------------- | -------- | ------- | ---------- | --- | ---- |
| 2   | Trt.,week,week" | !3263·85 | 19 0·64 | !1·56 0·38 | Trt | 0·21 |
3 Trt.,week,week",
|     | week!trt.                   | !3261·90 | 22 0·65 | !1·50 0·38 | Week!trt. | 0·26 |
| --- | --------------------------- | -------- | ------- | ---------- | --------- | ---- |
| 4   | Trt.,weekindicators!3256·29 |          | 21 0·63 | — —        |           |      |
5 Trt.,week,week",
|     | week!centre | !3257·07 | 31 0·64 | !1·72 0·38 | Week!cent- |      |
| --- | ----------- | -------- | ------- | ---------- | ---------- | ---- |
|     |             |          |         |            | re         | 0·25 |
6 Trt.,week,week",
|     | status | !3164·03 | 20 0·58 | !2·35 0·48 | status | )0·0001 |
| --- | ------ | -------- | ------- | ---------- | ------ | ------- |
Forallmodels,boththelineartimetrendcoefficient(week)andthequadratic,aswellastheoverallcentreeffect,were
significantatthe0·001levelbytheWaldtest.Overalltreatmenteffectwasnotsignificantinanymodel
(week!treatment,model 3, comparedto model 2). Sincethe purpose of the study was to show
that the experimental treatment was as efficacious as the active control, this result is not
surprising. The non-significance of the treatment effect does not, of course, imply equivalence.
Thefourtreatmenteffectsneedtobetestedforequivalence,whichisnotthefocusofthistutorial,
andisnotconsideredhere.Model4,whichreflectsnoassumptiononthetimetrend,hasallthe
timeindicatorssignificant.A comparisonwithmodel2, givesa likelihoodratiotest of15·12 on
twodegreesoffreedom,implyingthataquadraticintimemodeldoesnotadequatelydescribethe
time trend.
| 5.1.3. | Estimation and effect | of missingness |     |     |     |     |
| ------ | --------------------- | -------------- | --- | --- | --- | --- |
Model 5 shows the addition of a centre by week interaction (observation level covariate). The
overall log-likelihood is comparable to the unrestricted model 4, although with ten more
estimatedparameters.Theoverallcentrebylinearweekinteractionwasnotasignificanttermby
the Wald test, nor was it a significant contribution beyond model 2 by a likelihood ratio test.
From Table III we can see that results are very similar for models 1, 2 and 3 in terms of both
coefficient values and log-likelihoods. The coefficient of baseline BPRS indicates a substantial
drop from baseline to week 1 in BPRS of approximately one-third, which on average means
a reduction of 12 points. Correcting for the linear and quadratic effect on that first week, adds
approximatelyfivepoints,foraneteffectofanestimatedmeansevenpointdropduringthefirst
weekoftreatment.Subsequently,betweenweeks1and6thereisacontinued,slowerdropwhich
gives a total estimated additional reduction of six points by study end. Comparing model 2 to
model4showsthatthequadraticmodeldoesnotprovideacompletelyadequatedescriptionof
thetimetrend.TableIVgivesthemodelfittedvariance-covariancematrixformodel2.Standard
| deviations | are between | 9.5 and 14 BPRS | points. |     |     |     |
| ---------- | ----------- | --------------- | ------- | --- | --- | --- |
Model6wasexaminedinanefforttostudytheeffectofdropout.Thestudyprotocolcalledfor
discontinuationofthestudyiftherewasaperceivedlackoftherapeuticeffectofthestudydrug.
Thedecisiontodiscontinueapatientonthosegroundswasdonewithoutknowledgeoftreatment
| Statist.Med.,16,2349—2380(1997) |     |     |     | !   | 1997byJohnWiley&Sons,Ltd. |     |
| ------------------------------- | --- | --- | --- | --- | ------------------------- | --- |

2369
USINGTHEGENERALLINEARMIXEDMODEL
TableIV. Covariancematrixforschizophreniastudy.ModelwithbaselineBPRS,treatment,
centre,week,andweek"(Correlationsabovethediagonal;covariancesbelow)
|       |     | Week1 | Week2  | Week3  | Week4  | Week6  |
| ----- | --- | ----- | ------ | ------ | ------ | ------ |
| Week1 |     | 92·20 | 0·63   | 0·52   | 0·34   | 0·35   |
| Week2 |     | 66·04 | 120·30 | 0·76   | 0·64   | 0·60   |
| Week3 |     | 64·07 | 106·26 | 161·80 | 0·77   | 0·72   |
| Week4 |     | 43·67 | 91·75  | 127·41 | 169·22 | 0·85   |
| Week5 |     | 46·79 | 93·07  | 128·92 | 155·08 | 196·37 |
TableV. Covariance matrix for schizophrenia study.Model with baseline BPRS, treatment,
centre,week,week",andpatientstatus (correlationsabovethediagonal;covariancesbelow)
|       |     | Week1 | Week2 | Week3    | Week4  | Week6  |
| ----- | --- | ----- | ----- | -------- | ------ | ------ |
| Week1 |     | 85·47 | 0·61  | 00··5500 | 0·27   | 0·32   |
| Week2 |     | 55·54 | 95·50 | 0·75     | 0·59   | 0·60   |
| Week3 |     | 50·92 | 80·34 | 121·02   | 0·73   | 0·67   |
| Week4 |     | 26·14 | 60·01 | 83·07    | 108·13 | 0·77   |
| Week5 |     | 31·30 | 60·96 | 76·92    | 83·39  | 107·34 |
assignmentandnotbasedonBPRSscores.However,thefinalobservationinthestudyforthose
cases was performed after the decision to discontinue. Thus, we added an observation-level
indicatorcovariateofpatientstatus.Thisvariablewasdefinedas0whilethepatientwasonstudy
andas1atthelastobservationifthepatientwasdiscontinuedduetolackoftherapeuticeffect,so
that the last observation reflected a status of being off-study. Model 6 provided the highest
likelihood with the fewest parameters of any of the previous models.
Table V gives the variance-covariancematrix of this model, and all variances are reduced as
comparedtomodel2(SDsare9—10.5BPRSpointsinmodel6),andthisreductionbecomesmore
substantialinlatertimepoints.BothTablesIVandVshowanincreaseinvariancewithtime;this
isacommonphenomenainlongitudinalstudies.Onereasonisthatentrytothestudyisrestricted
tothosepatientswithBPRSof20orgreater,thuslimitingthetotalrange,ascomparedtolater
time points. In model 6, both the baseline BPRS coefficient and the linear trend coefficient
showed an even greater mean reduction in BPRS than other models in Table III, which is
adjustedbyanincreaseinBPRSinthosepatientswhowerediscontinuedduetoperceivedlackof
therapeutic effect. The estimated treatment effects for this model, which includes status, can be
interpreted as effects of treatment, assuming that patients are maintained on therapy. In that
| sense it might | be viewed | as an explanatory | analysis.#$ |     |     |     |
| -------------- | --------- | ----------------- | ----------- | --- | --- | --- |
Toillustratetherelationshipbetweenthenotationof themodelsinSection3andthemodels
presented here, we define model 6 in the terminology of the general linear mixed model as
presented in equation (4). Recall that X is defined by a combination of subject level and
!
observationlevelcovariates.Thesubjectlevelcovariatesare:(i)acolumnof1’sfortheintercept;
(ii)thesubject’sbaselineBPRSvalue;(iii)threecolumnsoftreatmentindicators;(iv)12columnsof
centreindicators.Theobservationlevelcovariatesare:(a)alinearweekeffect(range!2to#3;
(b)a quadratic week effect (range 0 to 9); (c) a column for the status variable.The vector y ! has
| ! 1997byJohnWiley&Sons,Ltd. |     |     |     |     | Statist.Med.,16,2349—2380(1997) |     |
| --------------------------- | --- | --- | --- | --- | ------------------------------- | --- |

2370
A.CNAAN,N.M.LAIRDANDP.SLASOR
TableVI. Regressioncoefficientsandstandarderrorsforthreecovariancemodels
Variablename Unstructurescovariance Randomeffects Autoregressive
|                     |     | Estimate | SE    | Estimate | SE Estimate | SE    |
| ------------------- | --- | -------- | ----- | -------- | ----------- | ----- |
| Intercept           |     | 2·13     | 2·47  | 1·90     | 2·51 3·73   | 2·54  |
| BaselineBPRS        |     | 0·64     | 0·067 | 0·65     | 0·067 0·58  | 0·069 |
| Lowdosetreatment    |     | 1·93     | 1·04  | 2·04     | 1·06 2·69   | 1·10  |
| Mediumdosetreatment |     | !1·86    | 1·02  | !1·64    | 1·03 !1·75  | 1·06  |
| Highdosetreatment   |     | 0·10     | 1·03  | !0·13    | 1·05 !0·36  | 1·07  |
| Week                |     | !1·56    | 0·25  | !1·52    | 0·25 !1·91  | 0·23  |
| Week"               |     | 0·38     | 0·084 | 0·37     | 0·085 0·36  | 0·090 |
between one and five elements, depending on the number of observations beyond baseline.
We assume, as defined earlier, that Z"0 ! and that var(y) ! is arbitrary. The BMDP code
| associated with | this model | is given in Appendix | I.  |     |     |     |
| --------------- | ---------- | -------------------- | --- | --- | --- | --- |
If we wish to use a random effects approach. we would define Z to have three columns
!
including an intercept, slope and quadratic effect. The observation level covariate status, being
binary,wouldnothaveanassociatedrandomeffect.Examiningthewithin-subjectsmodel-based
correlations matrices in both models 2 and 6 showed similar correlations of 0·5—0·85 between
BPRSscoresatdifferentobservationpoints,exceptforbetweenweek1andweeks4and6,which
were approximately 0·3. In addition, there was uniformly a decreasing correlation between
observation points as the time gap was larger. This suggested exploring a random effects error
structure with random intercept, linear trend and quadratic trend, that is, all observation-level
covariates as recommended in Section 3, as well as exploring an autoregressive structure
(AR1).
Table VI gives the estimated coefficients and SEs under all three covariance structures for
model2.Investigatingthecoefficientsshowsthatallthreemodelsestimatethecoefficientofthe
baseline value to be approximately two-thirds. The unstructured covariance matrix and the
random effects model had similar linear and quadratic time trends coefficients, indicating
areductionofsixpointsfromweek1toweek6beyondtheinitialreductioninthefirstweek.The
AR1 model predicted a reduction by eight points. Part of the reason may be due to the
model-estimated within-subject covariance matrices. In both the unstructured and the random
effects models, the variances and covariancesare not restricted, and, as Table IV shows for the
unstructuredcovariancemodel,thevariancesincreasewithtime.TheAR1modelconstrainsthe
structuretoequal variancesatall observationpoints, andcovariancesdependonly onthetime
gap.Thus,this model assumesmore precision than the other modelsfor the late time pointsin
thisstudy,andthusgivesthemrelativelymoreweight.Becauseasubstantialpartofthedropout
is due to a perceivedlack of therapeuticeffect, at least theoretically, the mean of week 6 BPRS
values may be biased down. Thus, an estimate which puts slightly more weight on week 6 will
show overall a slightly larger reduction in the BPRS score. It should be stressed that this
difference between the AR1 model estimates and the two other models is primarily a result
of different estimated within-subject variances and not different estimated within-subject
correlations.
Figure 3 illustrates the fitted model 6 and the observed data for two subjects in the medium
| dose treatment                  | group. |     |     |     |                             |     |
| ------------------------------- | ------ | --- | --- | --- | --------------------------- | --- |
| Statist.Med.,16,2349—2380(1997) |        |     |     |     | ! 1997byJohnWiley&Sons,Ltd. |     |

USINGTHEGENERALLINEARMIXEDMODEL 2371
Figure3. Fittedcurvesfortwopatientsintheschizophreniatrialinthelargestcentreandreceivingthemediumdose.
Model6isassumed
5.2. Pulmonary function developmentin children
5.2.1. Model selection and checking
Incontrasttotheschizophreniatrial,thedatafromthisstudy(Section2.2)arehighlyunbalanced.
The study called for annual measurements, but girls were different ages at entry and there is
considerable missing data. Figure 4 gives the distribution of subjects’ entry age and number of
measurements.Ageatentryrangesfromages6to14with81.3percentofgirlsbeingbetweenages
7and9atentry.Girlsenteringatalateagehadfewmeasurementstaken,whileyoungerentrants
had as many as 12 measurements. Dropout does occur, likely as a result of families moving
between school districts.
Wefollowtheanalysis ofHopperet al.!’ wherethenaturallogarithmofFEV wasfound to
!
depend on both age and height (observation level covariates). They found that it was best to
representthecovariateageasalinearspline,withslopedependingonwhetherornotthegirlwas
ofagelessthanorgreaterthan12.5.Intheirdata,priorFEV measurementwashighlypredictive
!
ofcurrentFEV ,sothatinadditiontomeasurementerror,thecovariancestructureconsistedof
!
a first-order autoregressive component. They also considered a Diggle model for covariance
consistingofmeasurementerror,first-orderautoregressivecomponent,andrandominterceptas
describedin Section 3.4. The parsimoniousmodel choiceretainedheight and age as predictors.
Thefirstpartofthesplineforagewasforcedtohaveslopezero,sothatagewasnotpredictiveof
FEV prior to age 12·5, after adjusting for height. The covariance structure employed was the
!
! 1997byJohnWiley&Sons,Ltd. Statist.Med.,16,2349—2380(1997)

2372 A.CNAAN,N.M.LAIRDANDP.SLASOR
Figure4. ThedistributionofageatentryfortheFEV data,showingalsothenumberofmeasurementsobtainedoneach
!
subject
measurement error plus first order autoregressive. In this data set there were no subject level
covariatesexcept for intercept.
Previousanalysesofourdatasuggestedtheuseoflogheightratherthanheightasapredictor
ofFEV ;wealsohadnoreasontosupportthesplinewithknotatage12·5years.Thusourfirst
!
stepwastofitmodelswithbothversionsofheight(linearandlogarithmic)andvaryingtheknot
pointforthesplinefrom11·5to17·0insixmonthincrements.Wedidnotassumethattheslope
for age prior to the knot was zero. We used the Diggle covariance structure, and then used
likelihood values and residual plots to choose the best model. Residual plots revealed an
observation that was clearly outlying. This observation was of a subject who only had one
measurementavailable.Wedroppedthisobservation,sothatallsubsequentanalysisisbasedon
the data of 299 girls. The spline with knot at age 16 provided the highest likelihood, and the
likelihood ratio test comparing this model to the simpler model with linear age, was highly
significant (p(0·0001). Table VII gives the likelihood values for these models.
Plotsofresiduals,orderedbyage,aregiveninFigure5.Thethreegraphsontheleftsidegive
residualsformodelsobtainedwithknotsatages15,16and17,respectively.Thethreegraphson
the right are similar, except height has been transformed by taking the natural logarithm. It is
difficulttodiscernapatternintheresiduals.Alowesscurveisrunthroughthedatapointsofeach
plot.The best fitting model should have a lowesscurve that is closest to a linewith slope zero.
Inspectingthegraphs,oneseesthatthelowesscurvesarenotverydifferent.Themodelwithknot
Statist.Med.,16,2349—2380(1997) ! 1997byJohnWiley&Sons,Ltd.

2373
USINGTHEGENERALLINEARMIXEDMODEL
|     |     | TableVII. LikelihoodvaluesforFEV |     | data |
| --- | --- | -------------------------------- | --- | ---- |
!
|     |     | Ageatknot | (2log-likelihood) |     |
| --- | --- | --------- | ----------------- | --- |
Covariateused
|     |     |      | Height  | Logheight |
| --- | --- | ---- | ------- | --------- |
|     |     | 11·5 | 4743·68 | 4734·59   |
|     |     | 12·0 | 4743·51 | 4730·25   |
|     |     | 12·5 | 4741·64 | 4720·32   |
|     |     | 13·0 | 4740·24 | 4711·09   |
|     |     | 13·5 | 4742·97 | 4708·37   |
|     |     | 14·0 | 4754·66 | 4719·16   |
|     |     | 14·5 | 4772·73 | 4739·14   |
|     |     | 15·0 | 4792·16 | 4760·68   |
|     |     | 15·5 | 4803·19 | 4773·08   |
|     |     | 16·0 | 4805·90 | 4775·90   |
|     |     | 16·5 | 4795·08 | 4764·46   |
|     |     | 17·0 | 4780·84 | 4749·42   |
atage16seemstohavetheflattestcurveforlaterages,givingfurtherevidencethatage16isthe
bestchoicefortheknot.Theplotsforthemodelsusinglogarithmofheightarenotmuchdifferent
fromplotsformodelsusingheight.Wekeepheight(untransformed),andageasasplinewithknot
| at age 16, | in subsequent | analyses. |     |     |
| ---------- | ------------- | --------- | --- | --- |
TableVIIIshowstheSASresultsoffittingseveraldifferentmodelstotheFEV data;allhave
!
the same mean predictors (height and spline for age with knot at age 16), but the models have
differentcovariancestructures.AppendixIIgivestheSAScodeforusingtheDigglemodelforthe
covariance,andtheresults ofthismodelaregivenincolumn4ofTable VIII.The coefficientof
AGE1 gives the slope prior to age 16 and the coefficient of AGE2 gives the deviation of the
post-16slopefromthepre-16slope.AgeandheightaresignificantpredictorsofFEV .LogFEV
! !
ispredictedtoincreaseby0·034peryearpriortoage,16,and0·014percentimetreofgrowth.Log
FEV changes with age beyond age 16 are predicted to be !0·006 per year. A model was fit
!
where the slope beyond age 16 was forced to be zero (not shown). The one degree-of-freedom
likelihood ratio test was not quite significant (P"0·083). This finding differs from the Hopper
result, where log FEV was found to have zero slope with respect to age less than 12·5, and
!
| positive slope | beyond | age 12·5. |     |     |
| -------------- | ------ | --------- | --- | --- |
TheremainingcolumnsofTableVIIIshowtheresultsoffittingthesamemodelforthemean,
butmakingdifferentassumptionsaboutthevariance.Becauseofthehighlyunbalancednatureof
thedata,andthelargenumberofpotentialobservationsofeachsubject,itisnotpossibletofitan
unstructuredcovariancematrix.WefitthemodelsusedbyHopper,andalsoonewhichtreatsthe
two slopes on age as random effects. For this last model, the Z matrix contains an intercept,
!
AGE1 and AGE2. Apart from the OLS fit, the estimated regression parameters are all very
similar, as are their estimated standard errors. The OLS fit gives quite different estimates and
standard errors, although in this case the inferences are similar. The Diggle model yields the
| highest likelihood, | again | consistent with Hopper’s | result. |     |
| ------------------- | ----- | ------------------------ | ------- | --- |
Figure 6 gives empirical Bayes estimates for selected girls (broken curve), contrasted with
ordinaryleastsquaresestimatebasedonthesubject’sdata(solidcurve).Noticethatthesecurves
| ! 1997byJohnWiley&Sons,Ltd. |     |     |     | Statist.Med.,16,2349—2380(1997) |
| --------------------------- | --- | --- | --- | ------------------------------- |

2374 A.CNAAN,N.M.LAIRDANDP.SLASOR
Figure5. ResidualplotsfortheFEV data,contrastingtheuseofheightversuslogheight,andusingsplinesinagewith
!
knotsat15,16and17yearsofage.Thelowesscurveisplotted
Statist.Med.,16,2349—2380(1997) ! 1997byJohnWiley&Sons,Ltd.

Figure6. EmpiricalBayes’andleastsquarescurvesforselectedindividuals.Actualdataareindicatedbydots
!
1997byJohnWiley&Sons,Ltd.
Statist.Med.,16,2349—2380(1997)
USINGTHEGENERALLINEARMIXEDMODEL
2375

2376
A.CNAAN,N.M.LAIRDANDP.SLASOR
Table VIII. Estimated parameters for models fit to FEV data using different co-variance structure
!
(standarderrorsinparentheses)
|     |     | OLS |     | Compound |     | AR        | (1) | Diggle | Random |
| --- | --- | --- | --- | -------- | --- | --------- | --- | ------ | ------ |
|     |     |     |     | symmetry |     | pluserror |     |        | slopes |
INT !1·778(0·038) !1·663(0·037) !1·679(0·042) !1·679(0·044) !1·708(0·038)
AGE1 0·027(0·002) 0·034(0·002) 0·034(0·002) 0·034(0·002) 0·032(0·002)
AGE2 !0·026(0·006) !0·037(0·004) !0·039(0·005) !0·039(0·005) !0·034(0·004)
HT(m) 1·506(0·041) 1·380(0·040) 1·390(0·046) 1·389(0·047) 1·426(0·041)
" 0·0129(0·0004) 0·0039(0·0001) 0·0023(0·0002) 0·0017(0·0003) 0·0033(0·0001)
"’
| d   |     |     |     | 0·0092(0·0008) |     |     |     | 0·0080(0·0009) | 0·014(0·002) |
| --- | --- | --- | --- | -------------- | --- | --- | --- | -------------- | ------------ |
**
| "   |     |     |     |     |     | 0·0106(0·0008) |     | 0·0033(0·0004) |     |
| --- | --- | --- | --- | --- | --- | -------------- | --- | -------------- | --- |
"(
|     |     |     |     |     |     | 0·953(0·007) |     | 0·665(0·084) |     |
| --- | --- | --- | --- | --- | --- | ------------ | --- | ------------ | --- |
%
| d   |     |     |     |     |     |     |     |     | 0·00007(0·00014) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------------- |
!!
| d   |     |     |     |     |     |     |     |     | 0·00007(0·00018) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------------- |
""
| !2logL |     | !3010·58 |     | !4644·38 |     | !4791·71 |     | !4805·90 | !4742·03 |
| ------ | --- | -------- | --- | -------- | --- | -------- | --- | -------- | -------- |
are not simple splines in age because of the dependence of log FEV on height as well. The
!
empirical Bayes’ estimates are a weighted average of population and subject parameters. For
subjectswithfeworhighlyvariableFEV ! measurements,theweighingoftheestimatestowards
thepopulationmeanisrelativelystrong,sothatthereisvisibleseparationbetweentheempirical
Bayes’andleastsquarescurves.Theseparationisalsoapparentinsubjectswhoappeartohave
outlyingdata.TheempiricalBayes’plotsaremoreappealingbecausetheyarenotsosensitiveto
outlying values at the ends of the range, and because they do not turn down, as some of the
| individual |     | subject’s | OLS      | curves | do.     |      |           |        |     |
| ---------- | --- | --------- | -------- | ------ | ------- | ---- | --------- | ------ | --- |
|            |     |           | APPENDIX |        | I: BMDP | CODE | FOR MIXED | MODELS |     |
/INPUTFILE"‘c:&bmdp&schiz.por’.
CODE"SCHIZ.
PORT.
/VARIABLENAMES"TRT, CENTER, PATID, WEEKO, BPRSO, WE11, BPRS1,
|     | D1,    | WE21, | BPRS2, | D2, | WE31, | BPRS3, | D3, | WE41, BPRS4, | D4, WE61, |
| --- | ------ | ----- | ------ | --- | ----- | ------ | --- | ------------ | --------- |
|     | BPRS6, |       | D6.    |     |       |        |     |              |           |
/TRANSFORM
WE12"WE11*WE11.
WE22"WE21*WE21.
WE32"WE31*WE31.
WE42"WE41*WE41.
WE62"WE61*WE61.
Thedataarereadinasarecordperpatient.Eachrecordcontainsthepatient’streatment,centre,
all six week numbers, associated BPRS scores and status, which is 0, except at the point of
discontinuation.Ifthediscontinuationisduetolackofeffect,therelevant‘D’variableis1.Ifdata
| Statist.Med.,16,2349—2380(1997) |     |     |     |     |     |     |     | ! 1997byJohnWiley&Sons,Ltd. |     |
| ------------------------------- | --- | --- | --- | --- | --- | --- | --- | --------------------------- | --- |

2377
USINGTHEGENERALLINEARMIXEDMODEL
aremissing,forexample,discontinuanceafterweek4,orweek2skipped,thefieldscontain‘·’to
| signify | missing data. |         |     |     |
| ------- | ------------- | ------- | --- | --- |
| /GROUP  | VARIABLE"TRT, | CENTER. |     |     |
CODES (TRT)"1,2,3,4.
|     | NAMES (TRT)"‘Lo’, | ‘Med’, | ‘Hi’, | ‘Cont’. |
| --- | ----------------- | ------ | ----- | ------- |
The categorial variables of treatment and centre are defined, so that BMDP can create the
| appropriate | indicator variables | in the model. |        |               |
| ----------- | ------------------- | ------------- | ------ | ------------- |
| /DESIGN     | DPNAME"BPRS.        |               |        |               |
|             | DPVAR"BPRS1,        | BPRS2,        | BPRS3, | BPRS4, BPRS6. |
REPEAT"WEEK.
LEVEL"5.
|     | CVNAME"BPR0, | WE1,        | WE2,   | STATUS.       |
| --- | ------------ | ----------- | ------ | ------------- |
|     | BPRO"BPRS0,  | BPRS0,      | BPRS0, | BPRS0, BPRS0. |
|     | WE1"WE11,    | WE21, WE31, |        | WE41, WE61.   |
|     | WE2"WE12,    | WE22, WE32, |        | WE42, WE62.   |
|     | STATUS"D1,   | D2, D3, D4, | D6.    |               |
Thedefinitionofdependentandindependentvariablesismade,includingthecompletestructure
ofthedesignmatrix.BPRSisidentifiedasthedependentvariable.Thisparagraphidentifiesthe
factthatthereisapotentialforfiverepeatswithineachrecord,andgivesanameforeachvariable,
dependentorcovariate,thatcanhavefiverepeats,aswellastheassociateddatavariableswhich
| form these | five repeats. |     |     |     |
| ---------- | ------------- | --- | --- | --- |
| /STRUCTURE | TYPE"UNSTRUC. |     |     |     |
Thiscommandidentifiesthecovariancestructureasunstructured,thusinthiscaseafivebyfive
matrix.Otheroptionswouldhavebeen:‘TYPE"CS’(compoundsymmetry),‘TYPE"AR(1)’
(first-order autoregressive), ‘TYPE"BANDED’ (banded, or general autoregressive).
Structures which would require additional input would be: ‘TYPE"RANDOM’ (random
effects), ‘TYPE"ARANDOM (random effects with AR(1) residual correlation structure),
‘TYPE"LINEAR’(generallinearstructure),‘TYPE"USER’(definedbyuserinFORTRAN
subroutine).
If we had chosen TYPE"RANDOM and wanted to specify a random intercept, slope and
quadratic,wewouldhaveadded:ZVAR"INT,INT,INT,INT,INT,WE11,WE21,WE31,
| WE41,  | WE61, WE12, WE22,                      | WE32, | WE42, | WE62. |
| ------ | -------------------------------------- | ----- | ----- | ----- |
| /MODEL | BPRS"‘BPR0#TRT#CENTER#WE1#WE2#STATUS’. |       |       |       |
Defines the linear regression model within the subject. BMDP has the option to add
a/COMPUTEstatementtospecifynumberofiterations,convergencecriterion,halving,andthe
algorithm to be used for convergence. The default is Newton—Raphson, but the EM can be
! 1997byJohnWiley&Sons,Ltd. Statist.Med.,16,2349—2380(1997)

2378
A.CNAAN,N.M.LAIRDANDP.SLASOR
specified.Therearesomelimitationsaboutallowablecombinationsbetweenthe/STRUCTURE
| statement | and the | /COMPUTEstatement. |     |     |     |     |     |
| --------- | ------- | ------------------ | --- | --- | --- | --- | --- |
/PRINTCOVR.
There are a variety of print options, including the possibility to obtain predicted values and
residuals.
/END.
|     |     | APPENDIX |     | II: | SAS CODE | FOR MIXED | MODELS |
| --- | --- | -------- | --- | --- | -------- | --------- | ------ |
DATA STEP
| data fev;   | set | fev;      | rage"round |     | (age); | age1"age; |     |
| ----------- | --- | --------- | ---------- | --- | ------ | --------- | --- |
| age2"max(0, |     | age1—16); |            |     |        |           |     |
Modellinglogarithmof FEV ! ,usingcovariatesheightandage(linearsplinewithknotat age
| 16). Diggle | covariance |     | structure. |     |     |     |     |
| ----------- | ---------- | --- | ---------- | --- | --- | --- | --- |
Inthedatastepabove,thevariablesAGE1,andAGE2arecreatedasthepiecesofaspline,with
knotatage16.ThevariableRAGEisaclass(categorical)variable.Thisvariableswillbeaninput
totheREPEATEDstatementofPROCMIXED.TheREPEATEDstatementrequiresthatone
provideaclassvariableindicatingthetimepointofanindividual’smeasurement.Wewillusethe
REPEATED statement to implement the autoregressive component of the Diggle covariance
structure.
PROC MIXED
| proc mixed | data"fev |     | method"ml; |     | class | id rage; |     |
| ---------- | -------- | --- | ---------- | --- | ----- | -------- | --- |
model lnfev"age1 age 2 ht /s p; random int/type"un subject"id
| g; repeated/local |     | r   | subject"id |     | type"sp | (pow) (agel); | make |
| ----------------- | --- | --- | ---------- | --- | ------- | ------------- | ---- |
‘SolutionF’ out"fix1; make ‘Predicted’ out"pred1; title ‘Spline
model (Diggle Covariance)’; *next line gives alternate REPEATED
statement;
| *repeated | rage/local |     | r subject"id |     | type"AR(1); |     |     |
| --------- | ---------- | --- | ------------ | --- | ----------- | --- | --- |
METHOD"ML indicates that maximum likelihood estimation is used.
TheCLASSstatementdeclaresclassificationvariablessothatSAScancreateasetofdummy
variablesthatspanthecategories.Tofitmixedmodels,SASrequiresaclassvariabletospecifythe
subjects(seebelow).Ifrepeatedstatementisused,anadditionalclassvariablemaybenecessaryto
define the distinct occasions of measurement (see discussion under repeated).
MODEL LNFEV"AGE1 AGE2 HT is the specificationof the equation for the mean. The
SoptionindicatesthatwewouldlikeestimatesofthefixedeffectsandthePoptionindicatesthat
wewouldlikepredictedvalues,aspartoftheSASoutput.SAScomputespredictedvaluesbased
on the estimates of the fixed and random effects, so that when random effects are specified, the
| predicted                       | values | are empirical |     | Bayes’ | estimates. |     |                             |
| ------------------------------- | ------ | ------------- | --- | ------ | ---------- | --- | --------------------------- |
| Statist.Med.,16,2349—2380(1997) |        |               |     |        |            |     | ! 1997byJohnWiley&Sons,Ltd. |

USINGTHEGENERALLINEARMIXEDMODEL 2379
RANDOM INT specifies the random intercept component. We have only specified one
random effect. If we wished to run a random slope we would write RANDOM INT AGE1.
TYPE"UNspecifiesthatthecovariancematrixfortherandomeffectsinunstructured.Sincewe
only have one random term, it does not matter which structure is specified. SUBJECT"ID
providesSASwith theclassvariablethatidentifiessubject(forgroupingof observationswithin
subjects) in both the RANDOM and REPEATEDstatements. The G option indicates that we
would like an estimate of the random effects covariance printed.
REPEATED statement specifies that the covariance is modelled within subject (SUB-
JECT"ID); TYPE"SP(POW) (AGE1) specifies a particular covariance structure which is
a continuous time generalization of the discrete time AR(1) model, it allows for a continuous
representation of age. The alternative version, using REPEATED RAGE, fits a discrete time
AR(1) model; for purposes of estimating the covariance parameters with this specification, the
agesofmeasurementarefirstroundedtothenearestyear.TheLOCALoptionindicatesthatwe
would like to add an additional diagonal component to the AR(1) structure. The R option
requests that SAS print an estimate of the covariance block for an individual.
ThefirstMAKEstatementtellsSAStosavetheestimatesofthefixedeffectsintheSASdataset
namedFIX1.ThesecondMAKEstatementindicatesthatestimatesofpredictedvaluesbesaved
in the data set PRED1. You must specify the appropriate option (S for fixed effects, P for
predictedvalues)intheMODELstatement,inordertohaveSASsaveresultstoadataset.Most
componentsofthecomputationsandoutputofSAScanbesavedtodatasets.Thisisusefulwhen
one wishes to perform further computations or graphics.
Specification of other covariance structures is straightforward. For example, dropping the
REPEATED statement above gives a specification for a random intercepts (compound sym-
metry)model.DroppingtheRANDOMstatementandtheLOCALoptionintheREPEATED
statement,wouldgiveafirst-orderautoregressivestructure.DroppingtheRANDOMstatement
andspecifyingTYPE"UNin theREPEATEDstatementgives themostgeneral unstructured
covariance model.
REFERENCES
1. Longford,N.T.RandomCoefficientModels,ClarendonPress,Oxford,1993.
2. Diggle,P.J.,Liang,K.-Y.andZeger,S.L.¹heAnalysisof¸ongitudinalData,ClarendonPress,Oxford,
1993.
3. Sherrill,D.L.,Holberg,C.J.,Enright,P.L.,Lebowitz,M.D.andBurrows,B.‘Longitudinalanalysisof
theeffectsofsmokingonsetandcessationonpulmonaryfunction’,AmericanJournalofRespiratoryand
CriticalCareMedicine,149,591—597(1994).
4. Gennaro, S., Fehder, W. P., Cnaan, A., York, R., Campbell, D. E., Gallaghar, P. and Douglas, S. D.
‘StressandimmuneresponseinmothersoftermandpretermVLBWinfants’,(submitted).
5. Geva, D., Goldschmidt, L., Stoffer, D. and Day, N. L. ‘A longitudinal analysis of effect of prenatal
alcoholexposureon growth’,Alcoholism:ClinicalandExperimentalResearch,17,1124—1129(1993).
6. Ross,R.A.,Lee,M.-L.T.,Delaney,M.L.andOnderdonk,A.B.‘Mixed-effectsmodelsforpredicting
microbialinteractionsinthevaginalecosystem’s,JournalofClinicalMicrobiology,32,871—875(1994).
7. Donaldson,G.W.andMonipour,C.M.‘Strengthenedestimatesofindividualpaintrendsinchildren
followingbonemarrowtransplantation’,Pain,48,147—155(1992).
8. McLean,R.A.,Sanders,W.L.andStroup,W.W.‘Aunifiedapproachtomixedlinearmodels’,American
Statistician,45,54—63(1991).
9. Laird, N. M. and Ware, J. H. ‘Random effects models for longitudinal data: an overview of recent
results’,Biometrics,38,963—974(1982).
10. Goldstein,H.MultilevelModelsinEducationalandSocialResearch,Griffin,London,1987.
! 1997byJohnWiley&Sons,Ltd. Statist.Med.,16,2349—2380(1997)

2380 A.CNAAN,N.M.LAIRDANDP.SLASOR
11. Bryk,A.S.andRaudenbush,S.W.Hierarchical¸inearModels:ApplicationsandDataAnalysisMethods,
SagePublications,NewberryPark,California,1992.
12. Louis,T.A.Generalmethodsforanalyzingrepeatedmeasures,StatisticsinMedicine,7,29—45(1988).
13. Crowder,M.J.andHand,D.J.AnalysisofRepeatedMeasures,Chapman&Hall,London,1990.
14. Lapierre,Y.D.,Nai,N.V.,Chauinard,G.,Awad,A.G.,Saxena,B.,James,B.,McClure,D.J.,Bakish,D.,
Max,P.,Manchanda,R.,Beaudry,P.,Bloom,D.,Rotstein,E.,Ancill,R.,Sandor,P.,Sladen-Dew,N.,
Durand,C.,Chandrasena,R.,Horn,E.,Elliot,D.,Das,M.,Ravindra,A.andMatsos,G.‘Acontrolled
dose-rangingstudy of remoxipride and haloperidol in schizophrenia—A Canadian multicentre trial’,
ActaPsychiatricScandinavica,82,72—76(1990).
15. Overall,J.E.andGorham,D.R.‘TheBriefPsychiatricRatingScale(BPRS):recentdevelopmentsin
ascertainmentandscaling’,PsychopharmacologyBulletin,22,97—99(1988).
16. Wang,X.,Dockery,D.W.,Wypij,D.,Fay,M.E. andFerris,B.G.,Jr.‘Pulmonaryfunctionbetween
6and18yearsofage’,PediatricPulmonology,15,75—88(1993).
17. Hopper,J.L.,Hibbert,M.E.,Macaskill,G.T.,Phelan,P.D.andLandau,L.I.‘Longitudinalanalysisof
lung functiongrowth in healthy childrenandadolescents’, Journal ofAppliedPhysiology,7, 770—777
(1991).
18. Wechsler,H.,Dowdall,G.,Davenport,A.,Moeykens,B.andCastillo,S.‘Correlatesofcollegestudent
bingedrinking’,AmericanJournalofPublicHealth,85,921—926(1995).
19. Laird,N.M.,Donnelly,C.andWare,J.H.‘Longitudinalstudieswithcontinuousresponses’,Statistical
MethodsinMedicalResearch,1,3—25(1992).
20. Cox, D.R.Planningof Experiments,Wiley,NewYork,1958.
21. Jones,B.andKenward,M.G.DesignandAnalysisofCrossover¹rials,ChapmanHall,London,1989.
22. Zeger,S.L.‘Commentary’,StatisticsinMedicine,7,161—168(1988).
23. Jennrich,R.I.andSchluchter,M.D.‘Unbalancedrepeated-measuresmodelswithstructuredcovariance
matrices’,Biometrics,42,805—820(1986).
24. Liang,K.Y.andZeger,S.‘Longitudinaldataanalysisusinggeneralizedlinearmodels’,Biometrika,73,
13—22(1986).
25. Schluchter, M. D. and Elashoff, J. D. ‘Small sample adjustments to tests with unbalanced repeated
measuresassuminggeneralcovariancestructures’,JournalofStatisticalComputationandSimulation,37,
69—87(1990).
26. Tsiatis,A.,DeGruttola,V.andWulfsohn,M.‘Modelingtherelationshipofsurvivaltolongitudinaldata
measuredwitherror;applicationstopatientsinAIDS’,JournaloftheAmericanStatisticalAssociation,
90,27—37(1995).
27. Harville, D. A. ‘Confidence intervals and sets for linear combinations of fixed and random effects’,
Biometrics,32,403—407(1976).
28. Lange, N. and Laird, N. M. ‘Random effects and growth curve modelingfor balanced and complete
longitudinaldata’,Journalofthe AmericanStatisticalAssociation,84,241—247(1989).
29. Diggle,P.J.‘Anapproachtotheanalysisofrepeatedmeasures’,Biometrics,44,959—971(1988).
30. Waternaux,C., Laird, N. M. and Ware, J. H. ‘Methods for analysis of longitudinal data: Blood lead
concentrationsandcognitivedevelopment’,Journal ofthe AmericanStatisticalAssociation,84,33—41
(1989).
31. Little,J.A.andRubin,D.B.StatisticalAnalysiswithMissingData,Wiley,NewYork,1987.
32. Prosser,R.,Rasbash,J.andGoldstein,H.M¸3Softwarefor¹hree-levelAnalysis,ºser’sGuidefor».2
InstituteofEducation,UniversityofLondon,1991.
33. Nutall D., Goldstein, H., Prosser, R. and Rasbash, J. ‘Differential school effectiveness’, International
JournalofEducationalResearch,13,769—776(1989).
34. Heyting,A.,Tolboom,J.T.B.M.,andEssers,J.G.A.‘Statisticalhandlingofdrop-outsinlongitudinal
clinicaltrials’,Statisticsin Medicine,11,2043—2061(1992).
Statist.Med.,16,2349—2380(1997) ! 1997byJohnWiley&Sons,Ltd.
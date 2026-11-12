METHODS
published:07April2017
doi:10.3389/fpsyg.2017.00456
Repeated Measures Correlation
JonathanZ.Bakdash1* andLauraR.Marusich2
1USArmyResearchLaboratory,HumanResearchandEngineeringDirectorate,AberdeenProvingGround,USA,2USArmy
LaboratorySouthFieldElement,HumanResearchandEngineeringDirectorate,UniversityofTexasArlington,Arlington,TX,
USA
Repeated measures correlation (rmcorr) is a statistical technique for determining the
common within-individual association for paired measures assessed on two or more
occasions for multiple individuals. Simple regression/correlation is often applied to
non-independent observations oraggregateddata;thismayproduce biased,specious
results due to violation of independence and/or differing patterns between-participants
versus within-participants. Unlike simple regression/correlation, rmcorr does not violate
the assumption of independence of observations. Also, rmcorr tends to have much
greater statistical power because neither averaging nor aggregation is necessary for
an intra-individual research question. Rmcorr estimates the common regression slope,
the association shared among individuals. To make rmcorr accessible, we provide
background information for its assumptions and equations, visualization, power, and
tradeoffs with rmcorr compared to multilevel modeling. We introduce the R package
(rmcorr) and demonstrate its use for inferential statistics and visualization with two
example datasets. The examples are used to illustrate research questions at different
levelsofanalysis,intra-individual,andinter-individual.Rmcorriswell-suitedforresearch
Editedby:
PrathibaNatesan, questions regarding the common linear association in paired repeated measures data.
UniversityofNorthTexas,USA
Allresultsarefullyreproducible.
Reviewedby:
ZhaohuiSheng, Keywords:correlation,repeatedmeasures,individualdifferences,intra-individual,statisticalpower,multilevel
WesternIllinoisUniversity,USA modeling
JocelynHoldenBolin,
BallStateUniversity,USA
INTRODUCTION
*Correspondence:
JonathanZ.Bakdash
jonathan.z.bakdash.civ@mail.mil Correlation is a popular measure to quantify the association between two variables. However,
widely used techniques for correlation, such as simple (ordinary least squares with a single
Specialtysection: independent variable) regression/Pearson correlation, assume independence of error between
Thisarticlewassubmittedto observations (Howell, 1997; Johnston and DiNardo, 1997; Cohen et al., 2003). This assumption
QuantitativePsychologyand
doesnotposeaproblemifeachparticipantorindependentobservationisasingledatapointof
Measurement,
paired measures (i.e., two data points corresponding to the same individual such as height and
asectionofthejournal
weight). For example, when correlating the current height and weight of people drawn from a
FrontiersinPsychology
randomsample,thereisnoreasontoexpectaviolationofindependence.
Received:06January2017
However, the assumption of independence is violated in repeated measures, in which each
Accepted:13March2017
participant provides more than one data point. For example, if a study collected height and
Published:07April2017
weightforasampleofpeopleatthreetimepoints,therewouldlikelybenon-independenceinthe
Citation:
errorsofthethreeobservationsbelongingtothesameperson.Analyzingnon-independentdata
BakdashJZandMarusichLR(2017)
with techniquesthatassumeindependence isa widespreadpracticebut onethatoften produces
RepeatedMeasuresCorrelation.
Front.Psychol.8:456. erroneousresults(KennyandJudd,1986;Molenaar,2004;Aartsetal.,2014).Onecommonsolution
doi:10.3389/fpsyg.2017.00456 istoaveragetherepeatedmeasuresdataforeachparticipantpriortoperformingthecorrelation.
FrontiersinPsychology|www.frontiersin.org 1 April2017|Volume8|Article456

| BakdashandMarusich |     |     |     |     |     |     |     |     |     |     | RepeatedMeasuresCorrelation |     |     |     |
| ------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- | --- |
Thisaggregationmayresolvetheissueofnon-independencebut rmcorr (using one of the paired measures to statistically adjust
canproducemisleadingresultsiftherearemeaningfulindividual for between-participants variance) (see Rmcorr and ANCOVA
| differences | (Estes, | 1956; | Myung | et  | al., 2000). | Furthermore, |     | fordetails). |     |     |     |     |     |     |
| ----------- | ------- | ----- | ----- | --- | ----------- | ------------ | --- | ------------ | --- | --- | --- | --- | --- | --- |
analysis of individual differences can be useful as a strong test Despitethepotentialutilityofrmcorrforrepeatedmeasures
fortheory(Underwood,1975;VogelandAwh,2008). data, it is relatively unknown in psychological research. To
Bland and Altman (1995a,b) introduced the within- address this gap, the paper is structured as follows. The
participants correlation in biostatistics to analyze the common background describes how rmcorr works, its relation to
intra-individual association for paired repeated measures, ANCOVA,andthetradeoffsforrmcorrcomparedtomultilevel
which are two corresponding measures assessed for each modeling.Next,weprovideanoverviewofthermcorrRpackage
participant/case/individual on two or more occasions. Here, using two examples with real data. Last, we summarize when
we refer to the technique as the repeated measures correlation rmcorrmaybeinformativeandpotentialapplications.
(rmcorr). Rmcorr accounts for non-independence among All graphs and results are fully reproducible using R
observations using analysis of covariance (ANCOVA) to (R Core Team, 2017), the rmcorr R package https://cran.
statistically adjust for inter-individual variability. By removing r-project.org/web/packages/rmcorr/, and the accompanying R
measured variance between-participants, rmcorr provides the Markdown document: https://osf.io/djphm/. R packages used
best linear fit for each participant using parallel regression in the paper, but not cited in the references, are listed in
| lines (the  | same        | slope) with | varying | intercepts. |             | Like | a Pearson | AppendixA. |     |     |     |     |     |     |
| ----------- | ----------- | ----------- | ------- | ----------- | ----------- | ---- | --------- | ---------- | --- | --- | --- | --- | --- | --- |
| correlation | coefficient | (r),        | the     | rmcorr      | coefficient |      | (r rm) is |            |     |     |     |     |     |     |
bounded by −1 to 1 and represents the strength of the linear BACKGROUND
| association                               | between | two | variables. | Also | akin | to the | Pearson  |           |              |               |     |     |         |     |
| ----------------------------------------- | ------- | --- | ---------- | ---- | ---- | ------ | -------- | --------- | ------------ | ------------- | --- | --- | ------- | --- |
| correlation,thenullhypothesisforrmcorrisρ |         |     |            |      |      | =      | 0,andthe |           |              |               |     |     |         |     |
|                                           |         |     |            |      |      | rm     |          | To convey | a conceptual | understanding |     | of  | rmcorr, | we  |
research/alternative hypothesis is ρ rm 6= 0. Unlike the Pearson first provide visualizations comparing rmcorr and simple
correlation, which assesses the inter-individual association regression/correlationusinghypotheticaldata.Then,toexplain
| because | it assumes | each | paired | data point | is  | Independent | and |     |     |     |     |     |     |     |
| ------- | ---------- | ---- | ------ | ---------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
theunderlyingmechanicsofrmcorrweprovideanoverviewof
Identically Distributed (IID), rmcorr evaluates the overall or ANCOVAforaspectsrelevanttormcorr;keyassumptions(e.g.,
common intra-individual association between two measures. parallel slopes); and the notation, data structure, and formulas
| Because | rmcorr | takes into | account | non-independence, |     |     | it tends |     |     |     |     |     |     |     |
| ------- | ------ | ---------- | ------- | ----------------- | --- | --- | -------- | --- | --- | --- | --- | --- | --- | --- |
forrmcorr(equationsforcalculationsanddegreesoffreedom).
toyieldmuchgreaterpowerthandatathatareaveragedinorder
Last,wecalculatepowercurvesforrmcorrtoshowthebenefits
to meet the IID assumption for simple regression/correlation. of repeated measures for higher statistical power relative to
Hence, rmcorr can detect associations between variables that simpleregression/correlation.
mightotherwisebeobscuredorspuriousduetoaggregationor
|     |     |     |     |     |     |     |     | Visualization: | Rmcorr |     | Plot |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------- | ------ | --- | ---- | --- | --- | --- |
treatingnon-independentvaluesasIID.
Conceptually,rmcorrisclosetoanullmultilevelmodel(i.e., In rmcorr, separate parallel lines are fit to the data from each
| varying | intercept  | and a  | common | slope    | for        | each | individual), |              |             |            |             |        |          |     |
| ------- | ---------- | ------ | ------ | -------- | ---------- | ---- | ------------ | ------------ | ----------- | ---------- | ----------- | ------ | -------- | --- |
|         |            |        |        |          |            |      |              | participant. | The sign of | the rmcorr | coefficient | (i.e., | positive | or  |
| but the | techniques | differ | on     | how they | treat/pool |      | variance.    |              |             |            |             |        |          |     |
negative)isindicatedbythedirectionofthecommonregression
Rmcorr assesses the common intra-individual variance in slope. The left panel of Figure1 shows an rmcorr plot for a
data, whereas multilevel modeling can simultaneously analyze setofhypotheticalrepeatedmeasuresdata,with10participants
| different | sources | of variance | using | fixed | and | random | effects. |           |                  |       |                    |     |      |     |
| --------- | ------- | ----------- | ----- | ----- | --- | ------ | -------- | --------- | ---------------- | ----- | ------------------ | --- | ---- | --- |
|           |         |             |       |       |     |        |          | providing | five data points | each. | Each participant’s |     | data | and |
The tradeoff with more complex multilevel models is that they correspondinglineareshowninadifferentcolor.Thecomputed
require more data and are more challenging to specify and rmcorrvalueforthisnotionaldatais0.96.Therightpanelshows
interpretthansimpleranalysisofvariance(ANOVA)/regression
|         |         |         |          |     |             |     |            | the same | notional data, | but with | each subject’s |     | data averaged |     |
| ------- | ------- | ------- | -------- | --- | ----------- | --- | ---------- | -------- | -------------- | -------- | -------------- | --- | ------------- | --- |
| models, | such as | rmcorr. | However, | the | flexibility | of  | multilevel |          |                |          |                |     |               |     |
intoonedatapointeach.Theregressionlineisplottedwiththis
modelinghasbenefits:Overallandindividualdifferencescanbe averageddata.Notethatthecomputedcorrelationcoefficientfor
analyzed simultaneously, models of varying complexity can be thisaverageddataismuchsmaller(0.13)andisnotsignificant.
| systematically | compared, |     | and they | can | provide | greater | insights |                  |        |          |            |                  |     |     |
| -------------- | --------- | --- | -------- | --- | ------- | ------- | -------- | ---------------- | ------ | -------- | ---------- | ---------------- | --- | --- |
|                |           |     |          |     |         |         |          | In this example, | rmcorr | captures | the strong | intra-individual |     |     |
intoindividualdifferences. relationship between the two variables that is missed by using
| Besides     | multilevel | modeling, |          | we contend | there | are | no other   | averageddata. |     |     |     |     |     |     |
| ----------- | ---------- | --------- | -------- | ---------- | ----- | --- | ---------- | ------------- | --- | --- | --- | --- | --- | --- |
| widely used | techniques |           | that can | correctly  | model |     | paired and |               |     |     |     |     |     |     |
InterpretingResults
| repeated | measures | data | that are | continuous. |     | The | common |     |     |     |     |     |     |     |
| -------- | -------- | ---- | -------- | ----------- | --- | --- | ------ | --- | --- | --- | --- | --- | --- | --- |
correlation techniques (e.g., Pearson, Kendall, and Spearman) Note that rmcorr can reveal very different within-participant
for paired data and canonical correlation for multivariate data associations among similar patterns of aggregated data, as
allassumeindependentobservations.Repeatedobservationscan depicted with notional data in Figure2. All the data in a given
be modeled with multivariate analysis of variance (MANOVA) row exhibit the same relationship when treated (incorrectly) as
andrepeatedmeasuresANOVA,buttheyareforfactorialdesigns IID, indicated by the black simple regression line in each cell.
and not paired data. While ANCOVA can operate on paired However,acrosscolumnstheintra-individualassociationisquite
data, its purpose (to statistically adjust for a nuisance, within- different. This phenomenon is why generating an rmcorr plot
participants variance, in each individual) is opposite to that of canbehelpfulforunderstandingagivendataset.Aswithother
FrontiersinPsychology|www.frontiersin.org 2 April2017|Volume8|Article456

| BakdashandMarusich |     |     |     |                  |         |                                   |                                   |       |          | RepeatedMeasuresCorrelation |
| ------------------ | --- | --- | --- | ---------------- | ------- | --------------------------------- | --------------------------------- | ----- | -------- | --------------------------- |
|                    |     | A   |     |                  |         | B                                 |                                   |       |          |                             |
|                    |     | 6   |     |                  |         |                                   | 6                                 |       |          |                             |
|                    |     | 4   |     |                  |         | )tnapicitrap hcae rof degareva( y | 4                                 |       |          |                             |
|                    |     | 2   |     |                  |         |                                   | 2                                 |       |          |                             |
|                    | y   | 0   |     |                  |         |                                   | 0                                 |       |          |                             |
|                    |     | −2  |     |                  |         |                                   | −2                                |       |          |                             |
|                    |     | −4  |     |                  |         |                                   | −4                                |       |          |                             |
|                    |     |     |     |       r rm       |  = 0.96 |                                   |                                   |       | r = 0.13 |                             |
|                    |     |     |     |        p < 0.001 |         |                                   |                                   |       | p < 0.72 |                             |
|                    |     | −6  |     |                  |         |                                   | −6                                |       |          |                             |
|                    |     |     | −3  | −2 −1 0          | 1       |                                   | −3                                | −2 −1 | 0        | 1                           |
|                    |     |     |     | x                |         |                                   | x (averaged for each participant) |       |          |                             |
FIGURE1|(A)Rmcorrplot:rmcorrplotforasetofhypotheticaldataand(B)simpleregressionplot:thecorrespondingregressionplotforthesamedataaveraged
byparticipant.
statisticaltechniques,visualizationiskeyforinterpretingresults one subject are transformed by subtracting 2. Note that the
(Tukey,1977). rmcorr values are the same for the original data and the two
| Figure2        | also depicts | examples | of       | Simpson’s Paradox | (note   | transformations. |     |        |     |     |
| -------------- | ------------ | -------- | -------- | ----------------- | ------- | ---------------- | --- | ------ | --- | --- |
| in particular  | Panel        | (A), Row | 1, and   | Panel (C), Row    | 3), in  |                  |     |        |     |     |
|                |              |          |          |                   |         | Rmcorr           | and | ANCOVA |     |     |
| which patterns | at           | a higher | level of | analysis (e.g.,   | sample, |                  |     |        |     |     |
experiment, study, or aggregated data) conflict with patterns Rmcorr is calculated using a form of ANCOVA, thus the two
at a lower level of analysis (Tu et al., 2008; Robinson, 2009; techniques share assumptions and equations (Howell, 1997;
see Kievit et al., 2013; e.g., individual). For patterns at one Miller and Chapman, 2001; Tabachnick and Fidell, 2007).
level of analysis to generalize to another, the data must be However, rmcorr is an atypical application of ANCOVA.
ergodicbetweenlevels(Molenaar,2004;MolenaarandCampbell, Typically, ANCOVA is used to determine the effect of a
2009). Rmcorr, and especially the rmcorr plot, may be useful categorical independent variable upon a continuous dependent
for understanding non-ergodic data that have intra-individual variable by removing the observed variance of a second
and inter-individual patterns that do not generalize to each “nuisance” continuous variable, or covariate (Howell, 1997;
other. Miller and Chapman, 2001; Tabachnick and Fidell, 2007).
|         |            |              |        |                 |        | Rmcorr, | however, | is used | to determine | the relationship |
| ------- | ---------- | ------------ | ------ | --------------- | ------ | ------- | -------- | ------- | ------------ | ---------------- |
| Similar | to Pearson | correlation, | linear | transformations | (i.e., |         |          |         |              |                  |
addition, subtraction, multiplication, and/or division) of data between the two continuous variables, while controlling for
do not alter the rmcorr value because the relationships among the effect of the categorical variable, which in this case
variablesarepreserved.Morespecifically,alineartransformation is the between-participants variance. In other words, the
can be applied to the entire dataset, all data for one or more typical use of ANCOVA is opposite to the purpose of
| participants, | or even | by applying | different | transformations | to  | rmcorr. |     |     |     |     |
| ------------- | ------- | ----------- | --------- | --------------- | --- | ------- | --- | --- | --- | --- |
the data of each participant without affecting the value of RmcorrisestimatedusingANCOVA,albeitwithanunusual
rmcorr.Figure3depictslineartransformationsforhypothetical model specification. ANCOVA is typically used to assess the
data in which effect sizes do not change. The first panel effectsofdifferent(treatmentorfactor)levelsuponadependent
shows the rmcorr plot for a set of three participants, with measure,whilecontrollingfortheeffectsofanothercontinuous
five data points each. The second panel shows the resulting variable(thecovariate).Forrmcorr,theparticipantisthefactor
rmcorr plot when the x-variable values for all participants are level and the covariate is the second measure. We describe
transformed by dividing by 2 and adding 1. The third panel estimation of rmcorr by first providing the equation for a one-
depicts the rmcorr plot when the y-variable values for only way ANCOVA (Equation 1); second, modifying this equation
FrontiersinPsychology|www.frontiersin.org 3 April2017|Volume8|Article456

BakdashandMarusich RepeatedMeasuresCorrelation
A B C
10
8
6
y
4
2
OLS
0
10
8
6
y
4
2
0
10
8
6
y
4
2
0
0 1 2 3 4 0 1 2 3 4 0 1 2 3 4
x x x
FIGURE2|Thesenotionalplotsillustratetherangeofpotentialsimilaritiesanddifferencesintheintra-individualassociationassessedbyrmcorrand
theinter-individualassociationassessedbyordinaryleastsquares(OLS)regression.Rmcorr-valuesdependonlyontheintra-individualassociationbetween
variablesandwillbethesameacrossdifferentpatternsofinter-individualvariability.(A)rrm=−1:depictsnotionaldatawithaperfectnegativeintra-individual
associationbetweenvariables,(B)rrm=0:depictsdatawithnointra-individualassociation,and(C)rrm=1:depictsdatawithaperfectpositiveintra-individual
association.Ineachcolumn,therelationshipbetweensubjects(inter-individualvariability)isdifferent,whichdoesnotchangethermcorr-valueswithinacolumn.
However,thisdoeschangetheassociationthatwouldbepredictedbyOLSregression(blacklines)ifthedataweretreatedasIIDoraveragedbyparticipant.
for rmcorr (Equation 2); and third, simplifying it (Equation Chapman,2001;TabachnickandFidell,2007)1.Inpractice,this
3). Last, we show the rmcorr table and calculations for the assumptionisconsideredtobemetwhenthereisnoevidenceof
rmcorr coefficient (the direction is based on the sign of the strongheterogeneityofslopes2.However,parallellinesarenotan
slope). assumptionforrmcorr;rather,rmcorrspecificallytestsforsuch
a common association between variables. Therefore, the degree
Assumptions to which each subject’s data is reflected by the common slope
The standard assumptions required for rmcorr include the of the best-fit parallel lines is appropriately represented in the
standardonesforGeneralLinearModel(GLM)techniques(e.g.,
Gelman and Hill, 2007) with a single exception: Independence 1InANCOVA,parallelslopesaretestedbyaddinganinteractiontermtothemodel
oferrorsisrelaxedinrmcorr.MajorGLMassumptionsinclude forthefactorbythecovariate(e.g.,TabachnickandFidell,2007).Asignificant
linearity (predictors are a linear function of the dependent interactionindicatesnon-parallelslopes,whichforANCOVAmaybeconsidered
an uninterpretable model depending on a variety of factors (e.g., Miller and
measure),errorsareIID[independentandidenticallydistributed
Chapman,2001;TabachnickandFidell,2007).Althoughsuchaninteractiontest
(i.e.,equalvariance)],anderrorsarenormallydistributed.Severe
couldbeusedwithrmcorr,wecontenditisnotlikelytobeinformativebecause
violations of the above assumptions could result in a biased non-parallelslopeswouldbeappropriatelyindicatedbythermcorreffectsizeand
model,whichmaybemisleadingorevenuninterpretable. multilevelmodelingcouldbeusedinstead.
In addition to the basic GLM assumptions, an additional
2Slopescanbenon-parallelincountlessways(e.g.,stronglyheterogeneouswith
opposing directions from positive to negative to weakly heterogeneous, all in
assumption for ANCOVA is that the slopes indicating the
thesamedirectionwithsmallvariation).Thisissupportedbyevidencethat,for
relationship between the dependent variable and the covariate
ANCOVA,thedegreeofheterogeneityinslopesiswhatmattersnotmerelythe
be parallel across conditions (e.g., Howell, 1997; Miller and presenceofastatisticallysignificantinteraction(Rogosa,1980).
FrontiersinPsychology|www.frontiersin.org 4 April2017|Volume8|Article456

| BakdashandMarusich |     |             |       |     |     |             |       |     |     |     |           | RepeatedMeasuresCorrelation |     |
| ------------------ | --- | ----------- | ----- | --- | --- | ----------- | ----- | --- | --- | --- | --------- | --------------------------- | --- |
|                    |     | 2 r  = 0.87 |       |     |     | 2 r  = 0.87 |       |     |     | 2   | r  = 0.87 |                             |     |
|                    |     | rm          |       |     |     | rm          |       |     |     |     | rm        |                             |     |
|                    |     | p < 0.001   |       |     |     | p < 0.001   |       |     |     |     | p < 0.001 |                             |     |
|                    |     | 1           |       |     |     | 1           |       |     |     | 1   |           |                             |     |
|                    |     | 0           |       |     |     | 0           |       |     |     | 0   |           |                             |     |
|                    | y   |             |       |     | y   |             |       |     |     | y   |           |                             |     |
|                    |     | −1          |       |     |     | −1          |       |     |     | −1  |           |                             |     |
|                    |     | −2          |       |     |     | −2          |       |     |     | −2  |           |                             |     |
|                    |     | −3          | −2 −1 | 0 1 |     | −3          | −2 −1 | 0   | 1   |     | −3        | −2 −1                       | 0 1 |
|                    |     |             | x     |     |     |             | x     |     |     |     |           | x                           |     |
FIGURE3|Rmcorr-values(andcorrespondingp-values)donotchangewithlineartransformationsofthedata,illustratedherewiththreeexamples:
(A)original,(B)x/2+1,and(C)y−1.
| rmcorreffectsize.Whentherelationshipbetweenvariablesvaries |     |     |     |     |     |     | TABLE1|Notation. |     |     |     |     |     |     |
| ---------------------------------------------------------- | --- | --- | --- | --- | --- | --- | ---------------- | --- | --- | --- | --- | --- | --- |
widelyacrosssubjects,thermcorreffectsizewillbenearzerowith
|     |     |     |     |     |     |     | Notation |     | Definition |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | -------- | --- | ---------- | --- | --- | --- | --- |
confidenceintervalsalsoaroundzero.Whenthereisnostrong
heterogeneityacrosssubjectsandparallellinesprovideagoodfit,
|     |     |     |     |     |     |     | L   |     | Totalnumberofpairedrepeatedmeasures(numberofrows) |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------------------------------------------- | --- | --- | --- | --- |
thermcorreffectsizewillbelarge,withtightconfidenceintervals.
|                                                        |     |     |     |     |     |     | N   |     | Samplesize(numberofuniqueindividuals)           |     |     |     |     |
| ------------------------------------------------------ | --- | --- | --- | --- | --- | --- | --- | --- | ----------------------------------------------- | --- | --- | --- | --- |
| Ifmodelingvaryingslopesisimportantandthereissufficient |     |     |     |     |     |     |     | L   |                                                 |     |     |     |     |
|                                                        |     |     |     |     |     |     | k=  | N   | Meannumberofpairedrepeatedmeasuresperindividual |     |     |     |     |
data,thebestapproachwouldbefittingandcomparingmultilevel
models (see Multilevel Modeling). Small effect sizes for rmcorr Thenotationandtheirdefinitions.Rmcorrcanaccommodateunbalanceddesigns(i.e.,
differingnumbersofpairedrepeatedmeasuresperparticipant).
maybecausednotonlybyheterogeneousslopes(poormodelfit),
however,butalsobyconsistentlynear-zeroslopesacrosssubjects
(seeInterpretingResultsandFigure2B),orbyrestrictioninthe Rmcorr data is in a long or narrow format with separate
rangeofoneorbothmeasures(Cohenetal.,2003).Visualization columns for the participant and paired measures, and separate
ofthedataiscriticaltodeterminewhichoftheseistheunderlying rows for each repeated observation, labeled by participant
causeofasmalleffectsize. (Table2A). In contrast, each row of data formatted for the
Two additional ANCOVA assumptions that are directly simpleregression/correlationispresumedtobeanindependent
|          |           |     |          |             |            |         | observation |     | (Table2B). | The | distinction | between | the two data |
| -------- | --------- | --- | -------- | ----------- | ---------- | ------- | ----------- | --- | ---------- | --- | ----------- | ------- | ------------ |
| relevant | to rmcorr | are | a linear | association | (linearity | is also |             |     |            |     |             |         |              |
a standard GLM assumption) and high reliability for the formats is similar to the difference between the person period
covariate/measure (Howell, 1997; Miller and Chapman, 2001; format and the person level format used in longitudinal data
analysis.
| Tabachnick |     | and Fidell,       | 2007). A | clear nonlinear |     | association |     |     |     |     |     |     |     |
| ---------- | --- | ----------------- | -------- | --------------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
| should     | be  | visually apparent | from     | plotting        | the | raw data    |     |     |     |     |     |     |     |
and examining the rmcorr plot. One option is to apply a EquationsandrmcorrTable
transformation to the data to make the association more Rmcorr is estimated using ANCOVA, albeit with an unusual
linear (e.g., Cohen et al., 2003). Another possibility is to fit model specification. ANCOVA is typically used to assess the
a nonlinear multilevel model. There are many methods for effectsofdifferent(treatmentorfactor)levelsuponadependent
assessingreliability(consistency)(e.g.,JohnandBenet-Martinez, measure,whilecontrollingfortheeffectsofanothercontinuous
2014).Reliabilityisacomplicatedtopicthatisbeyondthescope variable(thecovariate).Forrmcorr,theparticipantisthefactor
of this paper. However, if measurement reliability is previously level and the covariate is the second measure. We describe
known, or can be calculated, a correction for attenuation (e.g., estimation of rmcorr by first providing the equation for a one-
JohnandBenet-Martinez,2014)couldbeappliedtothermcorr way ANCOVA (Equation 1); second, modifying this equation
coefficient. for rmcorr (Equation 2); and third, simplifying it (Equation 3).
|     |     |     |     |     |     |     | Last, | we show | the rmcorr | table | and | calculations | for the rmcorr |
| --- | --- | --- | --- | --- | --- | --- | ----- | ------- | ---------- | ----- | --- | ------------ | -------------- |
RmcorrNotationandDataFormat coefficient(thedirectionisbasedonthesignoftheslope).
ThenotationforrmcorrisdefinedinTable1,andthedataformat Theequationforaone-wayANCOVAwithiparticipantsand
forthermcorrandPearsoncorrelationareshowninTable2. j(factor)levels(Howell,1997;TabachnickandFidell,2007)is:
FrontiersinPsychology|www.frontiersin.org 5 April2017|Volume8|Article456

| BakdashandMarusich |     |     |     |     |     |     |     |     |     |     |     | RepeatedMeasuresCorrelation |     |     |     |
| ------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- | --- |
TABLE2|DataFormat. Participant j isauniqueidentifierthatactsasadummyorproxy
codedvariable.
| Participant(i) |     | Trial(j) |     | X   |     | Y   |      |           |     |     |            |       |     |             |     |
| -------------- | --- | -------- | --- | --- | --- | --- | ---- | --------- | --- | --- | ---------- | ----- | --- | ----------- | --- |
|                |     |          |     |     |     |     | β is | the value | of  | the | covariate, | which | is  | the overall | or  |
commonslope.
(A)RmcorrDATAFORMAT,k=3.
|     |     |     |     |     |     |     | Measure2 | ij isthevalueofMeasure2forthejthparticipantattheir |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | -------- | -------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
| 1   |     | 1   |     |     |     |     |          |                                                    |     |     |     |     |     |     |     |
ithtrial.
| 1   |     | 2   |     |     |     |     |          |     |     |      |             |     |        |         |         |
| --- | --- | --- | --- | --- | --- | --- | -------- | --- | --- | ---- | ----------- | --- | ------ | ------- | ------- |
|     |     |     |     |     |     |     | Measure2 | is  | the | mean | of Measure2 |     | (all i | trials) | for the |
| 1   |     | 3   |     |     |     |     |          | j   |     |      |             |     |        |         |         |
jthparticipant.
| 2   |     | 1   |     |     |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
ε ij istheerrorforthejthparticipantattheirithtrial.
| 2   |     | 2   |     |     |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Equation2isrewrittentocalculatethepredictedvalueofthe
| 2   |     | 3   |     |     |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
rmcorrregressionlineforeachparticipantbytrial.Wedropthe
| ... |     | ... |     |     |     |     |       |              |     |       |         |              |     |          |         |
| --- | --- | --- | --- | --- | --- | --- | ----- | ------------ | --- | ----- | ------- | ------------ | --- | -------- | ------- |
|     |     |     |     |     |     |     | error | term because |     | we do | not fit | a confidence |     | interval | for the |
| ... |     | ... |     |     |     |     |       |              |     |       |         |              |     |          |         |
regressionline.
| ...         |     | ... |     |     |     |     |          |           |        |                  |          |               |          |            |         |
| ----------- | --- | --- | --- | --- | --- | --- | -------- | --------- | ------ | ---------------- | -------- | ------------- | -------- | ---------- | ------- |
| N           |     | 1   |     |     |     |     |          | Measure1′ |        | = Measure1       |          | + Participant |          |            |         |
|             |     |     |     |     |     |     |          |           |        | ij               |          | j             |          | j          |         |
| N           |     | 2   |     |     |     |     |          |           |        |                  |          |               |          |            |         |
|             |     |     |     |     |     |     |          |           |        | +β               | Measure2 | −             | Measure2 |            | (3)     |
| N           |     | 3   |     |     |     |     |          |           |        |                  |          | ij            |          | j          |         |
|             |     |     |     |     |     |     | Measure1 | ′         | is the | predicted(cid:0) | y-value  | of            | Measure1 | fo(cid:1)r | the jth |
| Participant |     |     | X   |     |     | Y   |          | ij        |        |                  |          |               |          |            |         |
participantattheirithtrial.
(B)SIMPLEREGRESSION/CORRELATION.
|     |     |     |     |     |     |     | Measure2 |     | is the | actual | x-value | which | corresponds |     | to the |
| --- | --- | --- | --- | --- | --- | --- | -------- | --- | ------ | ------ | ------- | ----- | ----------- | --- | ------ |
| 1   |     |     |     |     |     |     |          | ij  |        |        |         |       |             |     |        |
predictedy-valueintheregressionline.
2
Pleasenotethatthermcorrpackagehasalwaysproducedthe
...
correctedresults.
N
|     |     |     |     |     |     |     | Like | a regression |     | or  | ANOVA | table, | the | rmcorr | table |
| --- | --- | --- | --- | --- | --- | --- | ---- | ------------ | --- | --- | ----- | ------ | --- | ------ | ----- |
ThetwomeasuresarerepresentedbyXandY.Linesbetweenparticipantrowsindicate summarizesquantitativeresults(Table3).
independencebetweenobservations.Dataforrmcorrisinawide/longformatwitha
Basedonthesumsofsquaresvaluesforthemeasureanderror,
minimumoftworepeatedobservations.Theisubscriptrepresentseachparticipantand
thermcorrcorrelationcoefficientiscalculatedasfollows:
thejsubscriptindicateseachtrial(perparticipant).
SS
|     |     | Y = µ+ | τ + | c + ε |     | (1) |     |     |     |     |        |         | Measure |       |     |
| --- | --- | ------ | --- | ----- | --- | --- | --- | --- | --- | --- | ------ | ------- | ------- | ----- | --- |
|     |     | ij     | j   |       | ij  |     |     |     |     |     | r rm = |         |         |       | (4) |
|     |     |        |     |       |     |     |     |     |     |     |        | sSS     | +       | SS    |     |
|     |     |        |     |       |     |     |     |     |     |     |        | Measure |         | Error |     |
Y is the dependent measure for the ith participant at the jth Sign ofr positive or negative = Sign ofβ
| ij  |     |     |     |     |     |     |     |     | rm  |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
factorlevel.
|                    |     |     |     |     |     |     | Whetherr |     | takesa(cid:0)positiveornegativev(cid:1)alueisbasedonthesign |     |     |     |     |     |     |
| ------------------ | --- | --- | --- | --- | --- | --- | -------- | --- | ----------------------------------------------------------- | --- | --- | --- | --- | --- | --- |
| µistheoverallmean. |     |     |     |     |     |     |          | rm  |                                                             |     |     |     |     |     |     |
τ istheeffectofthejthfactorlevel. ofβ (thecommonslope),inEquation3.Additionally,thesign
j
cisthecovariate:c = β(X − X)(βisoverallslopecoefficient oftheslopeshouldbeapparentinthermcorrplot.
|         |            |             | ij j  |        |           |             |     |          |        |       |     |         |          |              |     |
| ------- | ---------- | ----------- | ----- | ------ | --------- | ----------- | --- | -------- | ------ | ----- | --- | ------- | -------- | ------------ | --- |
|         |            |             |       |        |           |             | It  | does not | matter | which | of  | the two | measures | is specified |     |
| for the | covariate, | X ij is the | value | of the | covariate | for the ith |     |          |        |       |     |         |          |              |     |
participant at the jth factor level, and X is the mean of the as the dependent variable and which one is the covariate.
j
|     |     |     |     |     |     |     | This | is equivalent | to  | switching | the | dependent | and | independent |     |
| --- | --- | --- | --- | --- | --- | --- | ---- | ------------- | --- | --------- | --- | --------- | --- | ----------- | --- |
covariatevaluesatthejthfactorlevel).
variableinsimpleregression/correlation.Inrmcorr,thevariable
| ε ij is | the error | for the | ith participant |     | at the jth | factor level |     |     |     |     |     |     |     |     |     |
| ------- | --------- | ------- | --------------- | --- | ---------- | ------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- |
specificationonlychangesthevaluesofthesumsofsquares.All
(theerroristhedifferencebetweentheactualvalueofdependent
measureanditsestimatedvalue,fortheithparticipantatthejth otherparameterestimatesareunchanged.
|     |     |     |     |     |     |     | We  | recommend |     | reporting | rmcorr | descriptively |     | with | the |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | --- | --------- | ------ | ------------- | --- | ---- | --- |
factorlevel).
|     |     |     |     |     |     |     | rmcorr | plot | and quantitatively |     | using | the | r (error | degrees | of  |
| --- | --- | --- | --- | --- | --- | --- | ------ | ---- | ------------------ | --- | ----- | --- | -------- | ------- | --- |
In Equations 2 and 3, Equation 1 is rewritten for rmcorr to rm
show one measure as a function of its mean value, participant, freedominparentheses),p-value,anda95%confidenceinterval
|          |          |               |           |          |                  |           | forr | rm (seermcorrRpackagesection).Presentingthepoint(r |          |      |        |              |     |                 | rm ) |
| -------- | -------- | ------------- | --------- | -------- | ---------------- | --------- | ---- | -------------------------------------------------- | -------- | ---- | ------ | ------------ | --- | --------------- | ---- |
| and the  | covaried | value of      | the other | measure. | Note             | following |      |                                                    |          |      |        |              |     |                 |      |
|          |          |               |           |          |                  |           | and  | interval                                           | estimate | (95% | CI) of | effect sizes | is  | a meta-analytic |      |
| Equation | 1, i     | and j are now | exchanged |          | for consistency: | j =       |      |                                                    |          |      |        |              |     |                 |      |
approach(Wilkinson,1999;Cumming,2014),andisconsistent
participantandi=trialorrepeatedmeasure.
withcurrentstatisticalbestpractices.
Measure1 ij = Measure1 j + Participant j Degrees of Freedom and Power
+β Measure2 − Measure2 + ε (2) Because rmcorr uses repeated measures, it will generally
|     |     |         |     | ij  | j       | ij  |      |        |         |     |         |           |     |        |        |
| --- | --- | ------- | --- | --- | ------- | --- | ---- | ------ | ------- | --- | ------- | --------- | --- | ------ | ------ |
|     |     |         |     |     |         |     | have | higher | degrees | of  | freedom | and power |     | than a | simple |
|     |     | (cid:0) |     |     | (cid:1) |     |      |        |         |     |         |           |     |        |        |
Measure1andMeasure2areexchangeable. regression/correlation with averaged data. The covariate in
Measure1 isthevalueofMeasure1forthejthparticipantattheir rmcorrslightlyreducesthedegreesoffreedom,byone,butthis
ij
ithtrial. loss is miniscule compared to the gains because of repeated
Measure1 j is the mean of Measure1 (all i trials) for the measures. Consequently, rmcorr generally has much higher
| jthparticipant. |     |     |     |     |     |     | powerthanPearsoncorrelationwithaverageddata. |     |     |     |     |     |     |     |     |
| --------------- | --- | --- | --- | --- | --- | --- | -------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
FrontiersinPsychology|www.frontiersin.org 6 April2017|Volume8|Article456

| BakdashandMarusich |     |     |     |     |     |     |     |     |     |     | RepeatedMeasuresCorrelation |     |     |     |
| ------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- | --- |
Table3|RmcorrTable.
Source DegreesofFreedom SumofSquares MeanSquareError Fratio p-value
| Participants |     | N–1 |     | SSParticipant | SSP | ar tic ipant | M SE M ea s | u re |     |     |     |     |     |     |
| ------------ | --- | --- | --- | ------------- | --- | ------------ | ----------- | ---- | --- | --- | --- | --- | --- | --- |
|              |     |     |     |               |     | N − 1        | M S EE      |      |     |     |     |     |     |     |
rr o r
|     |     |     |     |     | SSM | easure | M SE M ea s | u re |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | ------ | ----------- | ---- | --- | --- | --- | --- | --- | --- |
Measure 1 SSMeasure 1 M S EE SignificancevalueisdeterminedbytheF-ratio:
|       |          |        |     |         |     |              | rr  | o r F(Measuredf |     | (1), Errordf) |     |     |     |     |
| ----- | -------- | ------ | --- | ------- | --- | ------------ | --- | --------------- | --- | ------------- | --- | --- | --- | --- |
| Error | N(k−1)−1 |        |     | SSError |     | S S E rr o r |     |                 |     |               |     |     |     |     |
|       |          |        |     |         | N   | (k − 1 ) − 1 |     |                 |     |               |     |     |     |     |
| Total |          | (Nk)−1 |     | SSTotal | S   | S T o ta l   |     |                 |     |               |     |     |     |     |
(N k ) − 1
Thistableissimilartoaregression/ANOVAtable.
DegreesofFreedom analyze both intra- and inter-individual variance using partial
To calculate statistical power for rmcorr, we provide the exact pooling,whichpermitsvaryingslopesandotherparametersthat
degrees of freedom as well as approximations for convenience. cannotbeestimatedwithsimplertechniques.
Theexactdegreesofforrmcorr(fromTable3)are: Comparedtoothertypesofpooling,andthusotherstatistical
|     |     |     |     |     |     |     | techniques, | multilevel |     | modeling | has the | unique | advantage | of  |
| --- | --- | --- | --- | --- | --- | --- | ----------- | ---------- | --- | -------- | ------- | ------ | --------- | --- |
N(k−1) −1 (5) being able to estimate variance at multiple hierarchical levels
ofanalysissimultaneouslyusingpartialpooling4.Partialpooling
Where k is the (average) number of repeated measures per estimatesparametersatmultiplelevelsbytreatingalowerlevel
participant and N is the total number of participants. Note of analysis (e.g., individuals) as random/varying effects from a
the loss of a degree of freedom for the covariate. The degrees probability distribution drawn from a higher level of analysis
of freedom for rmcorr can be approximated as a multiplier (e.g., experiment) (see Gelman, 2005). Estimating random or
of (k − 1) times the degrees of freedom for the Pearson varying effects requires sufficient, but not excessive, variation,
correlation (N − 2). See Appendix B for the proof for this and typically five or more levels (Bolker, 2015). Consequently,
approximation. multilevel models with varying slopes will generally need more
InstandardpowertablesorprogramssuchasG∗Power(Faul datathanisrequiredforrmcorrandotherANOVAtechniques.
et al., 2009), users may calculate power for rmcorr by using Withpartialpooling,multilevelmodelshavethepotentialto
the entries for a Pearson correlation, but substituting in the providefargreaterinsightintoindividualdifferencesandother
appropriatedegreesoffreedomforrmcorr. patternscomparedtoANOVAtechniques.Themainadvantages
|     |     |     |     |     |     |     | of multilevel | modeling |     | are that | it can | accommodate |     | much |
| --- | --- | --- | --- | --- | --- | --- | ------------- | -------- | --- | -------- | ------ | ----------- | --- | ---- |
Power more complex designs than ANOVAs, such as varying slopes,
Becausermcorrisabletotakeadvantageofmultipledatapoints
|     |     |     |     |     |     |     | crossed | and nested | factors—up |     | to three | hierarchical | levels— |     |
| --- | --- | --- | --- | --- | --- | --- | ------- | ---------- | ---------- | --- | -------- | ------------ | ------- | --- |
per participant, it generally has much greater statistical power and missing data. This flexibility may make it challenging to
than a standard Pearson correlation using averaged data. Low implementandunderstandcomparedtoANOVA(Gueorguieva
| power typically |     | overestimates | effect | sizes | (e.g., Button | et al., |     |     |     |     |     |     |     |     |
| --------------- | --- | ------------- | ------ | ----- | ------------- | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
andKrystal,2004;QuenéandvandenBergh,2004).Withmore
2013).Powerforrmcorrincreasesexponentiallywheneitherthe
|     |     |     |     |     |     |     | complex | multilevel | models, | there | is potential |     | for overfitting |     |
| --- | --- | --- | --- | --- | --- | --- | ------- | ---------- | ------- | ----- | ------------ | --- | --------------- | --- |
valueofk(thenumberofrepeatedobservations)orthevalueof or overparameterization (i.e., excessive free parameters given
N (thetotalnumberofuniqueparticipants)increases.Figure4
|                                                     |     |     |     |     |     |     | the amount | of  | data | and the | model form). | Overfitting |     | may |
| --------------------------------------------------- | --- | --- | --- | --- | --- | --- | ---------- | --- | ---- | ------- | ------------ | ----------- | --- | --- |
| illustratesthepowercurvesoverdifferentvaluesofkandN |     |     |     |     |     | for |            |     |      |         |              |             |     |     |
produceuninterpretableresults,somodelcomparisonisessential
small,medium,andlargeeffectsizes. (Singer and Willett, 2003; Bates et al., 2015). However,
|            |          |     |     |     |     |     | concerns | about | model | overfitting | are general |     | and extend | to  |
| ---------- | -------- | --- | --- | --- | --- | --- | -------- | ----- | ----- | ----------- | ----------- | --- | ---------- | --- |
| Multilevel | Modeling |     |     |     |     |     |          |       |       |             |             |     |            |     |
ANOVA/regression/correlationandnumerousothertechniques
| A powerful  | and            | flexible | method        | for handling | different | sources   |          |             |       |         |                      |     |            |     |
| ----------- | -------------- | -------- | ------------- | ------------ | --------- | --------- | -------- | ----------- | ----- | ------- | -------------------- | --- | ---------- | --- |
|             |                |          |               |              |           |           | (Babyak, | 2004; e.g., | Aarts | et al., | 2014). Nevertheless, |     | multilevel |     |
| of variance | simultaneously |          | is multilevel |              | (linear)  | modeling3 |          |             |       |         |                      |     |            |     |
modelingcanprovideinsightsthatareotherwiseimpossiblewith
| (Kreft and | de Leeuw, | 1998; | Singer | and | Willett, 2003; | Gelman |     |     |     |     |     |     |     |     |
| ---------- | --------- | ----- | ------ | --- | -------------- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
ANOVA/regression.
| and Hill,        | 2007;        | see Aarts | et           | al., 2014).     | Rmcorr          | can be     |        |     |         |     |     |     |     |     |
| ---------------- | ------------ | --------- | ------------ | --------------- | --------------- | ---------- | ------ | --- | ------- | --- | --- | --- | --- | --- |
| viewed           | as a “light” | version   | of           | multilevel      | modeling        | because    |        |     |         |     |     |     |     |     |
|                  |              |           |              |                 |                 |            | RMCORR | R   | PACKAGE |     |     |     |     |     |
| it is comparable |              | to a      | simple,      | null multilevel |                 | model with |        |     |         |     |     |     |     |     |
| random/varying   |              | effects   | of intercept | for             | each individual | and        |        |     |         |     |     |     |     |     |
a fixed effect (i.e., common/overall) slope (see Appendix C To make rmcorr more accessible to researchers, we have
for direct comparisons). However, rmcorr only analyzes intra- developedthermcorrpackageforuseinR(RCoreTeam,2017).
Thepackagecontainsfunctionsforbothcomputingthermcorr
| individual | variance. | Multilevel | modeling |     | can simultaneously |     |     |     |     |     |     |     |     |     |
| ---------- | --------- | ---------- | -------- | --- | ------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- |
3Multilevelmodelinghasmanydifferentnames(e.g.,hierarchicallinearmodeling, 4Inpartialpoolingthelevelsmustinfluenceeachother,seeGelmanandHill(2007)
generalizedlinear[mixed]modeling,andlinearmixedeffectsmodeling). andKreftanddeLeeuw(1998).
FrontiersinPsychology|www.frontiersin.org 7 April2017|Volume8|Article456

BakdashandMarusich RepeatedMeasuresCorrelation
| A     |     |     | B     |     |     |     | C     |     |     |     |     |
| ----- | --- | --- | ----- | --- | --- | --- | ----- | --- | --- | --- | --- |
| 100%  |     |     | 100%  |     |     |     | 100%  |     |     |     |     |
| 80%   |     |     | 80%   |     |     |     | 80%   |     |     |     |     |
| 60%   |     |     | 60%   |     |     |     | 60%   |     |     |     |     |
| rewoP |     |     | rewoP |     |     |     | rewoP |     |     |     |     |
| 40%   |     |     | 40%   |     |     |     | 40%   |     |     |     |     |
| 20%   |     |     | 20%   |     |     |     | 20%   |     |     |     |     |
|       |     | k   |       |     |     | k   |       |     |     | k   |     |
|       |     | 1   |       |     |     | 1   |       |     |     | 1   |     |
|       |     | 3   |       |     |     | 3   |       |     |     | 3   |     |
|       |     | 5   |       |     |     | 5   |       |     |     | 5   |     |
|  0%   |     | 10  |  0%   |     |     | 10  |  0%   |     |     | 10  |     |
|       |     | 20  |       |     |     | 20  |       |     |     | 20  |     |
0 0 100 100 200 200 300 300 0 0 20 20 40 40 60 60 0 0 10 10 20 20 30 30
|     | Sample Size (N) |     |     | Sample Size (N) |     |     |     | Sample Size (N) |     |     |     |
| --- | --------------- | --- | --- | --------------- | --- | --- | --- | --------------- | --- | --- | --- |
FIGURE4|Powercurvesfor(A)small,rrm,andr=0.10,(B)medium,rrm,andr=0.3,and(C)largeeffectsizes,rrm,andr=0.50.X-axisissamplesize.Note
thesamplesizerangediffersamongthepanels.Y-axisispower.kdenotesthenumberofrepeatedpairedmeasures.Eightypercentpowerisindicatedbythedotted
blackline.Forrmcorr,thepowerofk=2isasymptoticallyequivalenttok=1.AcomparisontothepowerforaPearsoncorrelationwithonedatapointper
participant(k=1)isalsoshown.
coefficient (as well as confidence intervals, etc.) and generating 1) rmcorr: This function takes as input repeated measures
rmcorr plots. It also includes several example data sets, two of paireddataandcomputestherepeatedmeasurescorrelation
whicharedescribedindetailbelow.Thispackagecanbeaccessed coefficient.Ittakestheform:
in CRAN R: https://cran.r-project.org/web/packages/rmcorr/ rmc.out <- rmcorr(participant,
andinstalledandloadedinRusingthefollowingcommands: measure1, measure2, dataset, CIs =
|     |     |     |     |     | c(“analytic,” |     |     | “bootstrap”), |     | nreps | = 100, |
| --- | --- | --- | --- | --- | ------------- | --- | --- | ------------- | --- | ----- | ------ |
(1) install.packages(“rmcorr”)
|     |     |     |     |     | bstrap.out |     | =F) |     |     |     |     |
| --- | --- | --- | --- | --- | ---------- | --- | --- | --- | --- | --- | --- |
(2) library(rmcorr)
|     |     |     |     |     | Where | participant, |     | measure1, |     | and measure2 | are |
| --- | --- | --- | --- | --- | ----- | ------------ | --- | --------- | --- | ------------ | --- |
variablesgivingtheparticipantID/number,observationsfor
Package Overview
|     |     |     |     |     | the | first measure, | and | observations | for | the second | measure, |
| --- | --- | --- | --- | --- | --- | -------------- | --- | ------------ | --- | ---------- | -------- |
Package respectively,anddatasetisadataframecontainingthese
rmc
The rmcorr package has two primary functions: rmcorr and three variables. The function returns an object, a list
plot.rmc. containingfourprimarycomponents:Thevalueofthermcorr
FrontiersinPsychology|www.frontiersin.org 8 April2017|Volume8|Article456

| BakdashandMarusich |     |     |     |     |     |     |     |     |     |     |     | RepeatedMeasuresCorrelation |     |     |     |
| ------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- | --- |
coefficient, error numerator degrees of freedom, the 95% calculate the bootstrapped rmcorr coefficient (r rmboot ) and its
confidenceintervalforthermcorrcoefficient,andthep-value corresponding confidenceinterval(CI ).Thereareavariety
boot
forthermcorrcoefficient. of methods for calculating a bootstrapped confidence interval
An additional optional parameter, CIs, allows the user (see (DiCiccio and Efron, 1996; Canty and Support, 2015). An
to specify if the confidence intervals generated by the example is presented in the documentation for the rmcorr
| function       | are | computed   |           | analytically    |     | using      | the Fisher | package.    |     |          |     |     |     |     |     |
| -------------- | --- | ---------- | --------- | --------------- | --- | ---------- | ---------- | ----------- | --- | -------- | --- | --- | --- | --- | --- |
| transformation |     | or         | using     | a bootstrapping |     | procedure. | If         |             |     |          |     |     |     |     |     |
|                |     |            |           |                 |     |            |            | Two Example |     | Datasets |     |     |     |     |     |
| bootstrapped   |     | confidence | intervals |                 | are | chosen,    | additional |             |     |          |     |     |     |     |     |
arguments specify the number of resamples and whether Two example datasets are shown using the rmcorr package
the function output will include the resampled rmcorr to calculate inferential statistics and visualize results. These
values.
|     |     |     |     |     |     |     |     | examples | demonstrate |     | the potential | application |     | of rmcorr | for |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ----------- | --- | ------------- | ----------- | --- | --------- | --- |
2) plot.rmc: This function takes as input an rmc object (the intra-individualresearchquestions,andillustratehowandwhy
output from the rmcorr function) and the dataset used to results can differ from simple regression/correlation, which
generateit.Itproducesascatterplotoftherepeatedmeasures
|     |     |     |     |     |     |     |     | addresses | inter-individual |     | research | questions. | The | first | dataset |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ---------------- | --- | -------- | ---------- | --- | ----- | ------- |
paireddata,witheachparticipant’sdataplottedinadifferent is composed of repeated measures of age and brain structure
color.Thefunctiontakestheform: volumeovertwotimeperiods.Theseconddatasetistheaverage
plot(rmc, dataset, overall = T, palette reaction time (RT) and accuracy for repeated blocks of visual
| = NULL, |     | xlab | = NULL, | ylab | =   | NULL, |     |     |     |     |     |     |     |     |     |
| ------- | --- | ---- | ------- | ---- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
searchtrials.
| overall.col |     | =   | “gray60,” |     | overall.lwd |     | =3, |                                     |     |     |     |     |     |     |     |
| ----------- | --- | --- | --------- | --- | ----------- | --- | --- | ----------------------------------- | --- | --- | --- | --- | --- | --- | --- |
| overall.lty |     | =   | 2, ...)   |     |             |     |     | Example1:AgeandBrainStructureVolume |     |     |     |     |     |     |     |
The overall parameter specifies whether a line should Usingdatafrom(Razetal.,2005)weassesstheintra-individual
be plotted, indicating the regression line that would relationshipbetweenageandcerebellarhemispherebrain(CBH)
result from treating the data as independent observations structuralvolume.Eachmeasurewasassessedontwooccasions
(ignoring the repeated measures nature of the data). approximately 5 years apart, thus the data are longitudinal.
| overall.col, |     | overall.lwd, |     |     | overall.lty |     |     |     |     |     |     |     |     |     |     |
| ------------ | --- | ------------ | --- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
and are The researchers found a negative association between age and
optional parameters specifying the appearance of this line. CBHvolumewhenusingseparatesimpleregression/correlation
Thepaletteparameterallowstheusertooptionallychoose modelsforeachofthetwotimeperiods(Razetal.,2005).
acolorpalettefortheplot.xlabandylabareparameters Here, we demonstrate a variety of ways to analyze these
for labeling the x- and y-axis, defaulting to the variable data, using both simple regression/correlation and rmcorr: (a)
names in dataset. Finally, additional arguments to the separate simple regression/correlations, (b) rmcorr, and (c)
genericplotfunction(...)canspecifyotheraspectsoftheplot’s simple regression/correlation using averaged data. For each of
appearance. thesethreemethods,wedescribeandplotthegeneratedresults
anddiscusstheirinterpretation.
| Help and        | examples |      | for each | of                  | these | functions     | can be |               |             |     |              |                 |       |                  |     |
| --------------- | -------- | ---- | -------- | ------------------- | ----- | ------------- | ------ | ------------- | ----------- | --- | ------------ | --------------- | ----- | ---------------- | --- |
|                 |          |      |          |                     |       |               |        | First,        | we recreate |     | the original | cross-sectional |       | (between-        |     |
| accessed        | within   | R by | typing   | help(function.name) |       |               | or     |               |             |     |              |                 |       |                  |     |
|                 |          |      |          |                     |       |               |        | participants) | analysis    |     | from the     | paper,          | where | the relationship |     |
| ?function.name. |          | The  | Rmcorr   | package             |       | also includes | three  |               |             |     |              |                 |       |                  |     |
betweenageandCBHvolumewereassessedwithseparatesimple
| built-in | example | datasets: | bland1995 |     | the | data | described in |                        |     |     |        |         |      |          |     |
| -------- | ------- | --------- | --------- | --- | --- | ---- | ------------ | ---------------------- | --- | --- | ------ | ------- | ---- | -------- | --- |
|          |         |           |           |     |     |      |              | regression/correlation |     |     | models | at Time | 1 [r | = −0.36, | 95% |
Bland and Altman (1995a), raz2005 (the dataset used in the (70)
|                                                      |        |         |          |             |     |           |              | CI [−0.54, | −0.14],      | p                   | < 0.01]  | and Time   | 2 [r     | = −0.40,       | 95%    |
| ---------------------------------------------------- | ------ | ------- | -------- | ----------- | --- | --------- | ------------ | ---------- | ------------ | ------------------- | -------- | ---------- | -------- | -------------- | ------ |
| firstexamplebelow),andgilden2010(thedatasetusedinthe |        |         |          |             |     |           |              |            |              |                     |          |            | (70)     |                |        |
|                                                      |        |         |          |             |     |           |              | CI [−0.58, | −0.19],      | p                   | < 0.001; | Figure5A]. | The      | interpretation |        |
| second example                                       |        | below). | More     | information |     | about     | each dataset |            |              |                     |          |            |          |                |        |
|                                                      |        |         |          |             |     |           |              | of these   | results      | is cross-sectional: |          | They       | indicate | a moderately   |        |
| is accessible                                        | within | R       | with the | commands    |     | of help() | or ?.        |            |              |                     |          |            |          |                |        |
|                                                      |        |         |          |             |     |           |              | negative   | relationship |                     | between  | age and    | CBH      | volume         | across |
Inthesectionsbelow,wedescribethebootstrappingprocedure
|           |         |         |     |      |         |          |         | people, where | older  | individuals |         | tend to | have a    | smaller | volume |
| --------- | ------- | ------- | --- | ---- | ------- | -------- | ------- | ------------- | ------ | ----------- | ------- | ------- | --------- | ------- | ------ |
| available | in this | package | in  | more | detail, | and then | provide |               |        |             |         |         |           |         |        |
|           |         |         |     |      |         |          |         | and vice      | versa. | If we       | instead | analyze | this data | at the  | intra- |
examplesofthepackagefunctionsusingrealdata.
|     |     |     |     |     |     |     |     | individual  | level   | using | rmcorr, | we see a    | much stronger |        | negative |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ------- | ----- | ------- | ----------- | ------------- | ------ | -------- |
|     |     |     |     |     |     |     |     | association | between | age   | and     | CBH volume, | r             | (71) = | −0.70,   |
rm
Bootstrapping
|     |     |     |     |     |     |     |     | 95% CI | [−0.81, | −0.56], | p < | 0.001 (Figure5B). |     | These | results |
| --- | --- | --- | --- | --- | --- | --- | --- | ------ | ------- | ------- | --- | ----------------- | --- | ----- | ------- |
Thermcorreffectsizeisestimatedusingaparametricconfidence areinterpretedlongitudinally,andindicatethatasanindividual
interval, which assumes normality but can be more robustly ages, CBH volume tends to decrease. Finally, it is possible to
determinedusingbootstrapping.Bootstrappingdoesnotrequire analyze the relationship between age and CBH volume using
distributional assumptions and uses random resampling to each participant’s data averaged across the two time periods
estimate parameter accuracy (Efron and Tibshirani, 1994). andasimpleregression/correlation.Thismodelproducessimilar
The bootstrap for rmcorr is implemented by randomly resultstotheoriginalcross-sectionalanalysis:r =−0.39,95%
(70)
drawingobservationswithreplacement,within-individuals.This CI[−0.57,−0.17],p<0.01(Figure5C).
procedureisrepeatedoneachindividual,yieldingabootstrapped The three approaches address different research questions.
sample. The number of bootstrapped samples can be specified. The separate models analyze between-individual or cross-
Eachbootstrapsampleisthenanalyzedwithrmcorr,producing sectionalchange(Figure5A),whereasrmcorrassessestheintra-
a distribution of r rm values. Last, these values are used to individual or longitudinal change (Figure5B). Taken together,
FrontiersinPsychology|www.frontiersin.org 9 April2017|Volume8|Article456

| BakdashandMarusich |     |     |     |        |     |     |     |     |     |     | RepeatedMeasuresCorrelation |     |     |
| ------------------ | --- | --- | --- | ------ | --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- |
|                    | A   |     |     |        | B   |     |     |     | C   |     |                             |     |     |
|                    | 170 |     |     | Time 1 |     |     |     |     |     |     |                             |     |     |
|                    |     |     |     |        |     | 170 |     |     | 170 |     |                             |     |     |
160
150
|     |     |     |     |     |     | 160 |     |     | 160 |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
140
)3mc( emuloV erehpsimeH rallebereC
130
|     |     |     |     |     |     | 150 |     |     | 150 |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
120
|     | 110 | r = 0.36 |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | -------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
p < 0.01
|     |     |     |     |        |     | 140 |     |     | 140 |     |     |     |     |
| --- | --- | --- | --- | ------ | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|     | 170 |     |     | Time 2 |     |     |     |     |     |     |     |     |     |
|     |     |     |     |        |     | 130 |     |     | 130 |     |     |     |     |
160
150
|     | 140 |     |     |     |     | 120 |     |     | 120 |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
130
120
|     |     |           |     |     |     | 110         |     |     | 110 |           |     |     |     |
| --- | --- | --------- | --- | --- | --- | ----------- | --- | --- | --- | --------- | --- | --- | --- |
|     |     | r = −0.40 |     |     |     | rrm = −0.70 |     |     |     | r = −0.39 |     |     |     |
|     | 110 |           |     |     |     | p < 0.001   |     |     |     | p < 0.001 |     |     |     |
p < 0.001
20 30 40 50 60 70 80 20 30 40 50 60 70 80 20 30 40 50 60 70 80
|     |     |     | Age |     |     |     | Age |     |     |     | Age |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
FIGURE5|Comparisonofrmcorrandsimpleregression/correlationresultsforageandbrainstructurevolumedata.Eachdotrepresentsoneoftwo
separateobservationsofageandCBHforaparticipant.(A)Separatesimpleregressions/correlationsbytime:eachobservationistreatedasindependent,represented
byshadingallthedatapointsblack.Theredlineisthefitofthesimpleregression/correlation.(B)Rmcorr:observationsfromthesameparticipantaregiventhesame
color,withcorrespondinglinestoshowthermcorrfitforeachparticipant.(C)Simpleregression/correlation:averagedbyparticipant.Notethattheeffectsizeisgreater
(strongernegativerelationship)usingrmcorr(B)thanwitheitheruseofsimpleregressionmodels(A)and(C).ThisfigurewascreatedusingdatafromRazetal.(2005).
differing magnitudes of associations indicate that the negative 2) Rmcorrplot: plot(brainvolage.rmc, raz2005,
relationship for age and CBH volume is stronger within- overall = F, lty = 2, xlab = “Age”, ylab =
individualsthanbetween-individuals.Separatemodelspresume expression(Cerebellar∼Hemisphere∼Volume
that longitudinal and cross-sectional data are interchangeable, ∼(cmˆ{3})))
| which     | is  | not the case     | here    | and is a general |     | challenge with |     |     |     |     |     |     |     |
| --------- | --- | ---------------- | ------- | ---------------- | --- | -------------- | --- | --- | --- | --- | --- | --- | --- |
| assessing |     | the relationship | between | changes          | in  | age and brain  |     |     |     |     |     |     |     |
Example2:VisualSearchandResponseTime
| volume.5         |     | The third       | result assesses | a similar |        | question as the |              |           |        |            |             |                  |       |
| ---------------- | --- | --------------- | --------------- | --------- | ------ | --------------- | ------------ | --------- | ------ | ---------- | ----------- | ---------------- | ----- |
|                  |     |                 |                 |           |        |                 | Using visual | search    | data   | from one   | of the many | search           | tasks |
| original,        |     | separate models | (Figure5C).     | Although  |        | this model is   |              |           |        |            |             |                  |       |
|                  |     |                 |                 |           |        |                 | reported     | in Gilden | et al. | (2010), we | assess the  | intra-individual |       |
| straightforward, |     | using           | averaged        | data may  | reduce | or obscure      |              |           |        |            |             |                  |       |
associationbetweenspeedandaccuracy.Thecontinuoustradeoff
| meaningful |     | intra-individual |     | variance, | leading | to decreased |     |     |     |     |     |     |     |
| ---------- | --- | ---------------- | --- | --------- | ------- | ------------ | --- | --- | --- | --- | --- | --- | --- |
betweenspeed(reactiontime)andaccuracy(correctorincorrect)
power.
iswell-knownandoccursinavarietyoftasksassessingcognitive
|     | Rmcorr | results and | the rmcorr | plot (a | simplified | version of |     |     |     |     |     |     |     |
| --- | ------ | ----------- | ---------- | ------- | ---------- | ---------- | --- | --- | --- | --- | --- | --- | --- |
processes(Wickelgren,1977).Inthisexperiment,11participants
Figure5B)areproducedbyrunningthefollowingcode:
|     |         |                 |     |     |     |        | each completed |     | four separate | blocks | of 288 visual | search | trials |
| --- | ------- | --------------- | --- | --- | --- | ------ | -------------- | --- | ------------- | ------ | ------------- | ------ | ------ |
| 1)  | Rmcorr: | brainvolage.rmc |     |     | <-  | rmcorr |                |     |               |        |               |        |        |
apiece.RTandaccuracywerecomputedforeachblock,foreach
|     | (participant |     | =   | Participant, |     | measure1 | participant. |     |     |     |     |     |     |
| --- | ------------ | --- | --- | ------------ | --- | -------- | ------------ | --- | --- | --- | --- | --- | --- |
= Age, measure2 = Volume, dataset = As in the first example dataset, we worked through three
raz2005) different models for analyzing the relationship between
|     |     |     |     |     |     |     | RT and                 | accuracy | in          | Figure6: (A) | rmcorr,    | (B) | simple   |
| --- | --- | --- | --- | --- | --- | --- | ---------------------- | -------- | ----------- | ------------ | ---------- | --- | -------- |
|     |     |     |     |     |     |     | regression/correlation |          | (averaged   | data),       | and        | (C) | simple   |
|     |     |     |     |     |     |     | regression/correlation |          | (aggregated | data):       | improperly |     | treating |
5Observedassociationsforchangesinageandbrainvolumewithlongitudinal
(within-individual) versus cross-sectional (between-individual) designs are not each observation as independent. At the intra-individual
necessarilyequivalent(Salthouse,2011). level, rmcorr yields a negative relationship between speed and
FrontiersinPsychology|www.frontiersin.org 10 April2017|Volume8|Article456

| BakdashandMarusich |     |      |     |     |     |      |     |     |     |      |     | RepeatedMeasuresCorrelation |     |     |
| ------------------ | --- | ---- | --- | --- | --- | ---- | --- | --- | --- | ---- | --- | --------------------------- | --- | --- |
|                    | A   |      |     |     |     | B    |     |     |     | C    |     |                             |     |     |
|                    |     | 1.00 |     |     |     | 1.00 |     |     |     | 1.00 |     |                             |     |     |
|                    |     | 0.95 |     |     |     | 0.95 |     |     |     | 0.95 |     |                             |     |     |
ycaruccA
|     |     | 0.90 |         |     |             | 0.90 |     |         |          | 0.90 |         |     |          |     |
| --- | --- | ---- | ------- | --- | ----------- | ---- | --- | ------- | -------- | ---- | ------- | --- | -------- | --- |
|     |     | 0.85 |         |     |             | 0.85 |     |         |          | 0.85 |         |     |          |     |
|     |     | 0.80 |         |     | rrm = −0.41 | 0.80 |     |         | r = 0.59 | 0.80 |         |     | r = 0.38 |     |
|     |     |      |         |     | p < 0.02    |      |     |         | p = 0.06 |      |         |     | p = 0.01 |     |
|     |     |      | 0.5 0.6 | 0.7 | 0.8 0.9     |      | 0.5 | 0.6 0.7 | 0.8      | 0.9  | 0.5 0.6 | 0.7 | 0.8 0.9  |     |
Response Time (seconds) Response Time (seconds) Response Time (seconds)
FIGURE6|Thex-axisisreactiontime(seconds)andthey-axisisaccuracyinvisualsearch.(A)Rmcorr:eachdotrepresentstheaveragereactiontimeand
accuracyforablock,coloridentifiesparticipant,andcoloredlinesshowrmcorrfitsforeachparticipant.(B)Simpleregression/correlation(averageddata):eachdot
representsablock,(improperly)treatedasanindependentobservation.Theredlineisthefittothesimpleregression/correlation.(C)Simpleregression/correlation
(aggregateddata):improperlytreatingeachdotasindependent.ThisfigurewascreatedusingdatafromGildenetal.(2010).
accuracy, r (32) = −0.41, 95% CI [−0.66, −0.07], p < 0.02 of independence; in essence, the data are treated as if 44
rm
(Figure6A), consistent with a speed-accuracy tradeoff. This separate participants each completed one block of data. This
indicates that for a given individual, faster speed comes at the incorrect specification overfits the model, making the results
costofreducedaccuracy. uninterpretable. We include this example to illustrate the
We can instead average each participant’s RT and accuracy importance of identifying the research question of interest,
across the four experimental blocks and assess the inter- whether within-individuals, between-individuals, or both, and
individual relationship between speed and accuracy. A simple definingtheanalysisaccordingly.
regression/correlation model suggests a positive relationship, Rmcorrresultsandanrmcorrplot(similartoFigure6A)are
althoughtheresultisnotsignificant:r =0.59,95%CI[−0.01, producedbyrunningthefollowingcode:
(9)
=
| 0.88], | p       | 0.06 (Figure6B). |     | Note     | the decrease    | in  | power and   |            |      |               |       |                    |     |        |
| ------ | ------- | ---------------- | --- | -------- | --------------- | --- | ----------- | ---------- | ---- | ------------- | ----- | ------------------ | --- | ------ |
|        |         |                  |     |          |                 |     |             | 1) Rmcorr: |      | vissearch.rmc | <-    | rmcorr(participant |     |        |
| that   | a large | correlation,     |     | albeit a | highly unstable |     | one, is not |            |      |               |       |                    |     |        |
|        |         |                  |     |          |                 |     |             | =          | sub, | measure1      | = rt, | measure2           |     | = acc, |
significantbecausethismodelhasonlyninedegreesoffreedom.
|     |     |     |     |     |     |     |     | dataset |     | = gilden2010) |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | --- | ------------- | --- | --- | --- | --- |
Thefirstandsecondanalysesappearcontradictory.However,the
|     |     |     |     |     |     |     |     | 2) Rmcorr |     | plot: plot(vissearch.rmc, |     |     | gilden2010, |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | --- | ------------------------- | --- | --- | ----------- | --- |
appropriateanalysisandinterpretationoftheresultsdependon
|     |     |     |     |     |     |     |     | overall |     | = F, | lty = 2, | xlab | = “Reaction |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | --- | ---- | -------- | ---- | ----------- | --- |
theresearchquestion.Ifwewanttoquantifythespeed-accuracy
|           |             |     |      |        |                     |     |           | Time,” |     | ylab = | “Accuracy”) |     |     |     |
| --------- | ----------- | --- | ---- | ------ | ------------------- | --- | --------- | ------ | --- | ------ | ----------- | --- | --- | --- |
| tradeoff, | a phenomena |     | that | occurs | within-individuals, |     | the first |        |     |        |             |     |     |     |
analysiswithrmcorrisappropriate.Ifwewanttoknow,between
participants and collapsed across blocks, if faster people tend CONCLUSION
| to be | more | or less | accurate, | the second | analysis | is  | informative |     |     |     |     |     |     |     |
| ----- | ---- | ------- | --------- | ---------- | -------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
(thoughunderpowered).
|     |     |     |     |     |     |     |     | Unlike | standard | correlation/regression |     | techniques, |     | rmcorr can |
| --- | --- | --- | --- | --- | --- | --- | --- | ------ | -------- | ---------------------- | --- | ----------- | --- | ---------- |
Finally, we show the result of aggregating all data and handle repeated measures data without violating independence
improperly treating each observation as independent. Because assumptionsorrequiringfirstaveragingthedata.Thestrengths
| the data | are | not | averaged, | power | is much | higher, | which |           |     |            |               |      |             |           |
| -------- | --- | --- | --------- | ----- | ------- | ------- | ----- | --------- | --- | ---------- | ------------- | ---- | ----------- | --------- |
|          |     |     |           |       |         |         |       | of rmcorr |     | are in its | potential for | high | statistical | power, as |
may make this model initially attractive. Indeed, results well as its simplicity. Rmcorr is ideal for assessing a common
show a significant positive relationship between RT and association across individuals, specifically a homogenous intra-
| accuracy: | r   | =   | 0.38, | 95% CI | [0.09, | 0.61], | p = 0.01 |     |     |     |     |     |     |     |
| --------- | --- | --- | ----- | ------ | ------ | ------ | -------- | --- | --- | --- | --- | --- | --- | --- |
(42) individual linear association relationship between two paired
(Figure6C). However, the model violates the assumption measures. The two examples provided above illustrate how
FrontiersinPsychology|www.frontiersin.org 11 April2017|Volume8|Article456

| BakdashandMarusich |     |     |     |                      |     | RepeatedMeasuresCorrelation |     |
| ------------------ | --- | --- | --- | -------------------- | --- | --------------------------- | --- |
|                    |     |     |     | AUTHOR CONTRIBUTIONS |     |                             |     |
rmcorrisstraightforwardtoapply,visualize,andinterpretwith
realdata.
Because rmcorr analyzes paired repeated measures without JB drafted the paper, LM wrote sections, and both revised the
averagingorviolatingtheIIDassumptionithasclearadvantages paper. Both authors contributed to the analyses and LM wrote
themajorityofthecodefortheRpackage.Theauthorsapprove
oversimpleregression/correlation.Thisisparticularlytruewhen
there are violations of assumptions that result in biased and thefinalversionofthepaper.
spuriousparameterestimates.Researchersmayfindtheanalysis
FUNDING
| and visualization | tools available  | in the rmcorr | package useful    |     |     |     |     |
| ----------------- | ---------------- | ------------- | ----------------- | --- | --- | --- | --- |
| for understanding | and interpreting | paired        | repeated measures |     |     |     |     |
data, especially in cases where these data exhibit non-intuitive Thisresearchwassupportedbythesecondauthor’sappointment
patterns (e.g., Simpson’s Paradox). This may include assessing to the U.S. Army Research Laboratory Postdoctoral Fellowship
ProgramadministeredbytheOakRidgeAssociatedUniversities
| and comparing | the association | within-individuals | versus the |     |     |     |     |
| ------------- | --------------- | ------------------ | ---------- | --- | --- | --- | --- |
association between individuals. For more complex datasets, under Cooperative Agreement W911NF-16-2-0008. The views
rmcorrisnotareplacementformultilevelmodeling. and conclusions contained in this document are those of the
authorsandshouldnotbeinterpretedasrepresentingtheofficial
| Future | work will expand | the examples | and functionality |     |     |     |     |
| ------ | ---------------- | ------------ | ----------------- | --- | --- | --- | --- |
of the rmcorr package. Rmcorr could complement multilevel policies,eitherexpressedorimplied,oftheU.S.ArmyResearch
modeling. For example, it may be informative for assessing LaboratoryortheU.S.government.
| collinearity | in multilevel | models and provide | an effect size |     |     |     |     |
| ------------ | ------------- | ------------------ | -------------- | --- | --- | --- | --- |
for a null multilevel model. Other possibilities include more ACKNOWLEDGMENTS
| detailed comparisons | with | a null multilevel | model. Another |     |     |     |     |
| -------------------- | ---- | ----------------- | -------------- | --- | --- | --- | --- |
futuredirectioncouldbedeterminingthestabilityofthermcorr WethankJessicaSchultheisandWalterBaileyforcopy-editing
coefficient across different sample and effect sizes, building and also acknowledge Sean Fitzhugh, Katherine Gamble, and
upon research simulating the stability of Pearson correlations DonHeadleyforhelpfulandinsightfulcomments.
(SchönbrodtandPerugini,2013).
|        |           |     |     | SUPPLEMENTARY     | MATERIAL |                  |              |
| ------ | --------- | --- | --- | ----------------- | -------- | ---------------- | ------------ |
| ETHICS | STATEMENT |     |     |                   |          |                  |              |
|        |           |     |     | The Supplementary | Material | for this article | can be found |
Bothdatasetsarefrompreviouslypublishedpapers,nonewdata online at: http://journal.frontiersin.org/article/10.3389/fpsyg.
wascollectedforthismanuscript. 2017.00456/full#supplementary-material
REFERENCES Cumming, G. (2014). The new statistics why and how. Psychol. Sci. 25, 7–29.
doi:10.1177/0956797613504966
Aarts,E.,Verhage,M.,Veenvliet,J.V.,Dolan,C.V.,andvanderSluis,S.(2014).A DiCiccio, T. J., and Efron, B. (1996). Bootstrap confidence intervals. Stat. Sci.
| solutiontodependency:usingmultilevelanalysistoaccommodatenesteddata. |     |     |     | 189–212. |     |     |     |
| -------------------------------------------------------------------- | --- | --- | --- | -------- | --- | --- | --- |
Nat.Neurosci.17,491–496.doi:10.1038/nn.3648 Efron,B.,andTibshirani,R.J.(1994).AnIntroductiontotheBootstrap.NewYork,
| Babyak,M.A.(2004).Whatyouseemaynotbewhatyouget:abrief,nontechnical |     |     |     | NY:CRCPress. |     |     |     |
| ------------------------------------------------------------------ | --- | --- | --- | ------------ | --- | --- | --- |
introduction to overfitting in regression-type models. Psychosom. Med. 66, Estes,W.K.(1956).Theproblemofinferencefromcurvesbasedongroupdata.
| 411–421. |     |     |     | Psychol.Bull.53,134.doi:10.1037/h0045156 |     |     |     |
| -------- | --- | --- | --- | ---------------------------------------- | --- | --- | --- |
Bates, D., Kliegl, R., Vasishth, S., and Baayen, H. (2015). Parsimonious Faul, F., Erdfelder, E., Buchner, A., and Lang, A.-G. (2009). Statistical power
Mixed Models. ArXiv150604967 Stat. Available online at: analysesusingG∗Power3.1:testsforcorrelationandregressionanalyses.Behav.
http://arxiv.org/abs/1506.04967(AccessedFebruary7,2016). Res.Methods41,1149–1160.doi:10.3758/BRM.41.4.1149
Bland, J. M., and Altman, D. G. (1995a). Calculating correlation coefficients Gelman,A.(2005).Analysisofvariance?Whyitismoreimportantthanever.Ann.
withrepeatedobservations:part1Correlationwithinsubjects.BMJ310:446. Stat.33,1–53.doi:10.1214/009053604000001048
doi:10.1136/bmj.310.6977.446 Gelman, A., and Hill, J. (2007). Data Analysis Using Regression and
Bland, J. M., and Altman, D. G. (1995b). Calculating correlation coefficients Multilevel/Hierarchical Models. New York, NY: Cambridge University
| withrepeatedobservations:part2Correlationbetweensubjects.BMJ310:633. |     |     |     | Press. |     |     |     |
| -------------------------------------------------------------------- | --- | --- | --- | ------ | --- | --- | --- |
doi:10.1136/bmj.310.6980.633 Gilden, D. L., Thornton, T. L., and Marusich, L. R. (2010). The serial
Bolker,B.M.(2015).“Linearandgeneralizedlinearmixedmodels,”inEcological process in visual search. J. Exp. Psychol. Hum. Percept. Perform. 36, 533.
Statistics:ContemporaryTheoryandApplication,edsG.A.Fox,S.Negrete- doi:10.1037/a0016464
Yankelevich, and V. J. Sosa (Oxford: Oxford University Press), 309–334. Gueorguieva, R., and Krystal, J. H. (2004). Move over anova: progress in
doi:10.1093/acprof:oso/9780199672547.003.0014 analyzing repeated-measures data andits reflection in papers published in
Button,K.S.,Ioannidis,J.P.A.,Mokrysz,C.,Nosek,B.A.,Flint,J.,Robinson,E.S. the archives of general psychiatry. Arch. Gen. Psychiatry 61, 310–317.
J.,etal.(2013).Powerfailure:whysmallsamplesizeunderminesthereliability doi:10.1001/archpsyc.61.3.310
ofneuroscience.Nat.Rev.Neurosci.14,365–376.doi:10.1038/nrn3475 Howell, D. (1997). Statistical Methods for Psychology, 4th Edn. Belmont, CA:
Canty, A., and Support, B. R. (2015). boot: Bootstrap Functions WadsworthPublishingCompany.
(Originally by Angelo Canty for S). Available online at: John,O.P.,andBenet-Martinez,V.(2014).“Measurement:reliability,construction
https://cran.r-project.org/web/packages/boot/index.html (Accessed October validation,andscaleconstruction,”inHandbookofResearchMethodsinSocial
28,2015). andPersonalityPsychology,edsH.T.ReisandC.M.Judd(NewYork,NY:
Cohen, J., Cohen, P., West, S. G., and Aiken, L. S. (2003). Applied Multiple CambridgeUniversityPress),473–503.
Regression/CorrelationAnalysisfortheBehavioralSciences,3rdEdn.Mahwah, Johnston,J.,andDiNardo,J.E.(1997).EconometricMethods,3rdEdn.NewYork,
NJ:LawrenceErlbaumAssociates,Inc. NY:McGraw-HillCompaines,Inc.
FrontiersinPsychology|www.frontiersin.org 12 April2017|Volume8|Article456

BakdashandMarusich RepeatedMeasuresCorrelation
Kenny, D. A., and Judd, C. M. (1986). Consequences of violating the Salthouse, T. A. (2011). Cognitive correlates of cross-sectional differences and
independence assumption in analysis of variance. Psychol. Bull. 99:422. longitudinalchangesintrailmakingperformance.J.Clin.Exp.Neuropsychol.
doi:10.1037/0033-2909.99.3.422 33,242–248.doi:10.1080/13803395.2010.509922
Kievit, R. A., Frankenhuis, W. E., Waldorp, L. J., and Borsboom, D. (2013). Schönbrodt,F.D.,andPerugini,M.(2013).Atwhatsamplesizedocorrelations
Simpson’sparadoxinpsychologicalscience:apracticalguide.Front.Psychol. stabilize?J.Res.Personal.47,609–612.doi:10.1016/j.jrp.2013.05.009
4:513.doi:10.3389/fpsyg.2013.00513 Singer,J.D.,andWillett,J.B.(2003).AppliedLongitudinalDataAnalysis:Modeling
Kreft,I.,anddeLeeuw,J.(1998).IntroducingMultilevelModeling.ThousandOaks, ChangeandEventOccurrence.Oxford:OxfordUniversityPress
CA:SAGEPublications. Tabachnick,B.G.,andFidell,L.S.(2007).UsingMultivariateStatistics,4thEdn.
Matuschek,H.,Kliegl,R.,Vasishth,S.,Baayen,H.,andBates,D.(2015).Balancing NewYork,NY:PearsonEducation.
TypeIErrorandPowerinLinearMixedModels.ArXivPrepr.ArXiv151101864. Tu,Y.-K.,Gunnell,D.,andGilthorpe,M.S.(2008).Simpson’sParadox,Lord’s
Miller,G.A.,andChapman,J.P.(2001).Misunderstandinganalysisofcovariance. Paradox, and Suppression Effects are the same phenomenon the reversal
J.Abnorm.Psychol.110:40.doi:10.1037/0021-843X.110.1.40 paradox.Emerg.ThemesEpidemiol.5:2.doi:10.1186/1742-7622-5-2
Molenaar,P.C.(2004).Amanifestoonpsychologyasidiographicscience:bringing Tukey,J.W.(1977).ExploratoryDataAnalysis.NewYork,NY:Addison-Wesley
thepersonbackintoscientificpsychology,thistimeforever.Measurement2, PublishingCompany.
201–218.doi:10.1207/s15366359mea0204_1 Underwood, B. J. (1975). Individual differences as a crucible in theory
Molenaar, P. C., and Campbell, C. G. (2009). The new person-specific construction.Am.Psychol.30,128.doi:10.1037/h0076759
paradigm in psychology. Curr. Dir. Psychol. Sci. 18, 112–117. Vogel,E.K.,andAwh,E.(2008).Howtoexploitdiversityforscientificgain:using
doi:10.1111/j.1467-8721.2009.01619.x individualdifferencestoconstraincognitivetheory.Curr.Dir.Psychol.Sci.17,
Myung,I.J.,Kim,C.,andPitt,M.A.(2000).Towardanexplanationofthepower 171–176.doi:10.1111/j.1467-8721.2008.00569.x
lawartifact:insightsfromresponsesurfaceanalysis.Mem.Cognit.28,832–840. Wickelgren,W.A.(1977).Speed-accuracytradeoffandinformationprocessing
doi:10.3758/BF03198418 dynamics.ActaPsychol.41,67–85.doi:10.1016/0001-6918(77)90012-9
Quené, H., and van den Bergh, H. (2004). On multilevel modeling of data Wilkinson, L. (1999). Statistical methods in psychology journals: guidelines
from repeated measures designs: a tutorial. Speech Commun. 43, 103–121. and explanations. Am. Psychol. 54, 594–604. doi: 10.1037/0003-066X.
doi:10.1016/j.specom.2004.02.004 54.8.594
Raz,N.,Lindenberger,U.,Rodrigue,K.M.,Kennedy,K.M.,Head,D.,Williamson,
A., et al. (2005). Regional brain changes in aging healthy adults: general Conflict of Interest Statement: The authors declare that the research was
trends, individual differences and modifiers. Cereb. Cortex 15, 1676–1689. conductedintheabsenceofanycommercialorfinancialrelationshipsthatcould
doi:10.1093/cercor/bhi044 beconstruedasapotentialconflictofinterest.
RCoreTeam(2017).R:ALanguageandEnvironmentforStatisticalComputing.
Vienna: R Foundation for Statistical Computing. Available online at: Copyright©2017BakdashandMarusich.Thisisanopen-accessarticledistributed
https://www.R-project.org/ underthetermsoftheCreativeCommonsAttributionLicense(CCBY).Theuse,
Robinson,W.(2009).EcologicalCorrelationsandthebehaviorofIndividuals.Int. distribution or reproduction in other forums is permitted, provided the original
J.Epidemiol.38,337–341.doi:10.1093/ije/dyn357 author(s)andthecopyrightowner(s)arecreditedandthattheoriginalpublication
Rogosa, D. (1980). Comparing nonparallel regression lines. Psychol. Bull. 88, in this journal is cited, in accordance with accepted academic practice. No use,
307–321.doi:10.1037/0033-2909.88.2.307 distributionorreproductionispermittedwhichdoesnotcomplywiththeseterms.
FrontiersinPsychology|www.frontiersin.org 13 April2017|Volume8|Article456
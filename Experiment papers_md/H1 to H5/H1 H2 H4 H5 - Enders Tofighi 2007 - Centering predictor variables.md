PsychologicalMethods Copyright2007bytheAmericanPsychologicalAssociation
2007,Vol.12,No.2,121–138 1082-989X/07/$12.00 DOI:10.1037/1082-989X.12.2.121
Centering Predictor Variables in Cross-Sectional Multilevel Models:
|     |     |     |     |     | A New |     | Look   | at an Old  | Issue   |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | ----- | --- | ------ | ---------- | ------- | --- | --- | --- | --- | --- | --- |
|     |     |     |     |     | Craig | K.  | Enders | and Davood | Tofighi |     |     |     |     |     |     |
ArizonaStateUniversity
AppropriatelycenteringLevel1predictorsisvitaltotheinterpretationofinterceptandslope
parameters in multilevel models (MLMs). The issue of centering has been discussed in the
literature, but it is still widely misunderstood. The purpose of this article is to provide a
detailedoverviewofgrandmeancenteringandgroupmeancenteringinthecontextof2-level
MLMs. The authors begin with a basic overview of centering and explore the differences
between grand and group mean centering in the context of some prototypical research
questions.Empiricalanalysesofartificialdatasetsareusedtoillustratekeypointsthrough-
out. The article provides a number of practical recommendations designed to facilitate
centeringdecisionsinMLMapplications.
Keywords: centering, grand mean centering, group mean centering, multilevel models,
hierarchicallinearmodels
Supplementalmaterials:http://dx.doi.org/10.1037/1082-989X.12.2.121.supp
Multilevelmodels(MLMs)haveenjoyedwidespreaduse considerably more complex when considering Level 1 pre-
inthebehavioralsciencesinrecentyears.Thesemodelsare dictors in an MLM analysis. In the MLM context, Level 1
attractive because they provide a straightforward mecha- covariates can be centered at the grand mean (centering at
nismforanalyzingdatasetsinwhichstudyparticipantsare thegrandmean;CGM),ortheycanbedeviatedaroundthe
clustered within organizational units (e.g., clients nested mean of the cluster j to which case i belongs; the latter
| within therapists, |     | students | nested | within | schools, |     | individu- |        |               |          |     |               |     |           |     |
| ------------------ | --- | -------- | ------ | ------ | -------- | --- | --------- | ------ | ------------- | -------- | --- | ------------- | --- | --------- | --- |
|                    |     |          |        |        |          |     |           | option | is frequently | referred | to  | as group-mean |     | centering | in  |
alsnestedwithinfamilies,employeesnestedwithincompa- the MLM literature, but we henceforth refer to this tech-
nies,dailydiaryobservationsnestedwithinindividuals).In
|     |     |     |     |     |     |     |     | nique as | centering | within | cluster | (CWC) | in order | to  | avoid |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | --------- | ------ | ------- | ----- | -------- | --- | ----- |
contexts such as these, it is often of interest to explore the confusionwithCGM.Althoughbothformsofcenteringcan
| influence  | of variables |       | at both | levels        | of the | data hierarchy, |          |               |              |             |              |           |             |             |       |
| ---------- | ------------ | ----- | ------- | ------------- | ------ | --------------- | -------- | ------------- | ------------ | ----------- | ------------ | --------- | ----------- | ----------- | ----- |
|            |              |       |         |               |        |                 |          | be used       | to establish |             | a meaningful |           | zero point, | CGM         | and   |
| and MLMs   | readily      | allow | one     | to examine    |        | the influence   | of       |               |              |             |              |           |             |             |       |
|            |              |       |         |               |        |                 |          | CWC generally |              | produce     | parameter    | estimates |             | that differ | in    |
| individual | (i.e.,       | Level | 1) and  | cluster-level |        | (i.e.,          | Level 2) |               |              |             |              |           |             |             |       |
|            |              |       |         |               |        |                 |          | value and     | also         | in meaning. | Although     |           | there are   | unique      | situ- |
covariates.
ationsinwhichCGMandCWCproduceequivalentparam-
| Psychological |     | constructs | are | frequently |     | expressed | on ar- |     |     |     |     |     |     |     |     |
| ------------- | --- | ---------- | --- | ---------- | --- | --------- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
eterestimates(Kreft,deLeeuw,&Aiken,1995),thisisthe
bitrarymetricsthatlackaclearlyinterpretableormeaning-
|             |           |          |            |         |              |          |          | exception      | rather | than   | the norm. |           |              |      |        |
| ----------- | --------- | -------- | ---------- | ------- | ------------ | -------- | -------- | -------------- | ------ | ------ | --------- | --------- | ------------ | ---- | ------ |
| ful zero    | point     | (Blanton | & Jaccard, |         | 2006).       | Although | it is    |                |        |        |           |           |              |      |        |
|             |           |          |            |         |              |          |          | It should      | be     | noted  | that the  | centering | of Level     | 2    | (e.g., |
| clearly not | a panacea |          | for the    | problem | of arbitrary |          | metrics, |                |        |        |           |           |              |      |        |
|             |           |          |            |         |              |          |          | organizational |        | level) | variables | is far    | less complex | than | the    |
centeringcanbeusedtoestablishazeropointonscalesthat
|           |               |        |                 |         |              |          |          | centering | decisions | required | at      | Level  | 1, as it is | only | neces- |
| --------- | ------------- | ------ | --------------- | ------- | ------------ | -------- | -------- | --------- | --------- | -------- | ------- | ------ | ----------- | ---- | ------ |
| otherwise | lack          | such a | value.          | The use | of centering |          | for this |           |           |          |         |        |             |      |        |
|           |               |        |                 |         |              |          |          | sary to   | choose    | between  | the raw | metric | and CGM;    | CWC  | is     |
| purpose   | is relatively |        | straightforward |         | in           | ordinary | least    |           |           |          |         |        |             |      |        |
squares (OLS) regression (Aiken & West, 1991), but it is notanoptionbecauseeachmemberofagivenclustershares
thesamevalueontheLevel2predictor.Centeringdecisions
|          |        |     |        |          |            |     |          | at Level       | 2 generally  |            | mimic        | prescribed | practice     | from       | the    |
| -------- | ------ | --- | ------ | -------- | ---------- | --- | -------- | -------------- | ------------ | ---------- | ------------ | ---------- | ------------ | ---------- | ------ |
|          |        |     |        |          |            |     |          | OLS regression |              | literature | (Aiken       | &          | West, 1991), |            | so the |
| Craig K. | Enders | and | Davood | Tofighi, | Department | of  | Psychol- |                |              |            |              |            |              |            |        |
|          |        |     |        |          |            |     |          | focus of       | this article | is         | on centering | at         | Level 1.     | Throughout |        |
ogy,ArizonaStateUniversity.
|                |            |            |     |                |        |     |           | the remainder |     | of the   | article, | we assume | that  | all Level | 2   |
| -------------- | ---------- | ---------- | --- | -------------- | ------ | --- | --------- | ------------- | --- | -------- | -------- | --------- | ----- | --------- | --- |
| Correspondence |            | concerning |     | this article   | should | be  | addressed |               |     |          |          |           |       |           |     |
|                |            |            |     |                |        |     |           | predictors    | are | centered | at their | grand     | mean. |           |     |
| to Craig       | K. Enders, | Department |     | of Psychology, |        | Box | 87-1104,  |               |     |          |          |           |       |           |     |
Arizona State University, Tempe, AZ 85287-1104. E-mail: The issue of centering predictor variables in MLM has
beendiscussedinthemethodologicalliterature(Hofmann&
cenders@asu.edu
121

122 ENDERSANDTOFIGHI
Gavin, 1998; Kreft, 1995; Kreft et al., 1995; Longford, in longitudinal MLMs (i.e., growth curve models). In the
1989b; Paccagnella, 2006; Plewis, 1989; Raudenbush, typical growth curve application, the Level 1 covariate of
1989a, 1989b; Wu & Wooldridge, 2005), but it is still interest is a temporal predictor such as age or elapsed
widelymisunderstoodbysubstantiveresearchersandmeth- time.Insituationssuchasthis,theLevel1predictor(i.e.,
odologistsalike.Weconductedaninformalreviewofrecent the “time” variable) is typically centered around a fixed
volumes of several American Psychological Association value rather than around the mean. For example, in a
(APA) journals and found examples of inappropriate cen- longitudinalstudyofadolescentdepression,achild’sage
teringpractices.Forexample,therewerecasesinwhichthe at a particular assessment (i.e., the Level 1 predictor)
authors made no mention of the centering technique they couldbeexpressedasadeviationrelativetoage16(e.g.,
used(Griffin,2001;Kallestad&Olweus,2003),makingthe Montague,Enders,Dietz,Morrison,&Dixon,2006),and
resulting regression coefficients difficult, if not impossible, this centered age variable would appear in the Level 1
to interpret. In other cases, authors explicitly stated that regression model. Centering around a fixed point in time
the Level 1 predictors were left uncentered (Balsam, in a longitudinal study is arguably less complex than the
Beauchaine, Mickey, & Rothblum, 2005), even though a decision to use CGM or CWC in the cross-sectional
number of these variables had a raw metric with no mean- context,sowefocusourdiscussiononthelattersituation.
ingful zero point (e.g., age, education, self-esteem, life Excellent discussions of centering in the context of
satisfaction). It is interesting to note that we also found growthcurvemodelsarefoundinSingerandWillett(2003)
cases in which authors based centering decisions on the and in Biesanz, Deeb-Sossa, Aubrecht, Bollen, and Curran
results of empirical tests rather than on their substantive (2004).However,ourdiscussionofcenteringdoesapplyto
research questions. For example, Wampold and Brown other types of within-person data structures in which mul-
(2005) stated that “We conducted the analysis using both tiple observations are obtained from each individual but in
parameterizations [CGM and CWC], which yielded the which intraindividual variation is not expressed as a func-
finding that the within-therapist regression coefficient was tion of elapsed time (e.g., daily diary observations nested
not too different from the between-therapist regression co- within individuals). Interested readers can consult Nezlek
efficient” (p. 918). Similarly, Zohar and Luria (2005) (2001) for a discussion of multilevel modeling in this con-
explained that “When testing moderation effects in this text.
and subsequent hypotheses, we first tested the effect of
centering of variables in the statistical models ... This
Illustrative Data
operationresultedinnoimprovement,andthusitwasnot
performed in the final model” (p. 623). The decision to
Inordertomakeourdiscussionmoreconcrete,werelyon
base centering decisions on empirical results is problem-
a hypothetical research scenario from the occupational
atic because it should be based on the substantive ques-
stress literature. Specifically, suppose it was of interest to
tionofinterest.Kreftetal.(1995)underscoredthispoint,
studytheinfluenceofworkload(measuredbythenumberof
stating that “There is no statistically correct choice
workhoursperweek;HOURS)onpsychologicalwell-being
among RAS [the raw metric], CGM, and CWC” (p. 17).
(WELLBEING). Furthermore, assume that the data are hi-
It is certainly not our intent to single out these articles as
erarchically structured such that employees are nested
exemplarsofpoorpractice,norisitourintenttocriticize
within workgroups (organizations). In this scenario, both
these authors. Rather, we use these articles to illustrate
workloadandwell-beingareLevel1(i.e.,individuallevel)
the complexity of centering as a methodological issue
variables, but it may also be of interest to investigate the
and to demonstrate that confusion exists, even in articles
influence of organizational-level (i.e., Level 2) variables
published in top APA journals.
such as workgroup size (SIZE). Our decision to use an
Given the confusion that exists over centering, the pur-
occupational stress example was somewhat arbitrary, and
poseofthisarticleistoprovideadetailedoverviewofCGM
the concepts discussed in this article generalize to any
andCWCandtoprovideanumberofpracticalrecommen-
number of multilevel analysis problems. Nevertheless, we
dations designed to facilitate centering decisions in MLM
felt that this research scenario was useful because it pro-
research. In doing so, we chose to avoid comparisons of
videsanintuitiveplatformfromwhichtoexplorecentering
CGM and CWC based on numerical stability or computa-
issues.
tional efficiency (e.g., Longford, 1989a). Instead, we at-
TheLevel1regressionequationfortheillustrativemodel
tempt to address a relatively simple question: Which form
is
ofcenteringprovidesinterpretableparameterestimatesthat
can be used to address a particular substantive research
question? WELLBEING (cid:1)(cid:1) (cid:2)(cid:1) (cid:2)HOURS (cid:3)(cid:2)r , (1)
ij 0j 1j ij ij
Our discussion of centering is restricted to the cross-
sectionalcase,andwedonotconsidertheissueofcentering where (cid:1) is the intercept for cluster j, (cid:1) is the regression
0j 1j

CENTERINGINMULTILEVELMODELS 123
coefficient for cluster j, and r is the Level 1 residual.1 In (i.e., Level 1) and a between-cluster (i.e., Level 2) compo-
ij
turn, the Level 2 models for the intercept and slope are as nent.2 Returning to the top panel in Figure 1, the scores
follows: within each workgroup are negatively correlated, such that
individuals who work more tend to have lower well-being
(cid:1) (cid:1)(cid:4) (cid:2)u (2) scores. Additionally, the workload and well-being means
0j 00 0j
for each cluster can be viewed as Level 2 variables (Pac-
(cid:1) (cid:1)(cid:4) (cid:2)u . (3) cagnella, 2006), the scatter plot for which is shown in the
1j 10 1j
bottom panel of Figure 1. As seen in the figure, the cluster
meansarenearlyperfectlycorrelated,suchthattheaverage
The equations above express each cluster’s intercept and
slopeasafunctionofthemeaninterceptandslope((cid:4) and well-beingscoreforaparticularworkgroupdecreasesasthe
(cid:4) , respectively) plus a residual term that captures c 0 l 0 uster mean number of work hours increases. Figure 1 depicts an
10 associationbetweenworkloadandwell-beingatbothlevels
j’s deviation from the mean (u and u ).
0j 1j of the hierarchy, yet this complex relationship is summa-
In principle, each cluster has a unique slope and inter-
rized with a single regression slope in Equation 4. This is
cept, but the MLM analysis summarizes the j regressions
thecruxofthecenteringissueinMLMs,andthegoalofthis
by using a smaller set of parameters. Substituting Equa-
article is to demonstrate how CGM and CWC partition the
tions 2 and 3 into the Level 1 equation yields the so-
relationship between X and Y and produce different inter-
called combined model regression equation shown be-
pretations of the MLM parameters.
low.
WELLBEING (cid:1)(cid:4) (cid:2)(cid:4) (cid:2)HOURS (cid:3)(cid:2)u Centering at the Grand Mean (CGM)
ij 00 10 ij 0j
(cid:2)u (cid:2)HOURS (cid:3)(cid:2)r . (4)
1j ij ij Under CGM, the Level 1 predictor (work hours) is devi-
ated around the grand mean (i.e., HOURS (cid:3) x(cid:1) ); for
ij HOURS
This basic model yields six parameter estimates: the mean simplicity, the grand mean-centered scores are henceforth
intercept and slope ((cid:4) 00 and (cid:4) 10 , respectively), variance referredtoasHOURS cgm .Beforeconsideringtheimpactof
estimates for u 0j and u 1j that quantify the heterogeneity in centeringonMLMparameters,itisinformativetoseehow
the intercepts and slopes ((cid:5) 00 and (cid:5) 11 , respectively), the CGM affects the multilevel structure of the data. Applying
covariance between the intercepts and slopes ((cid:5) 10 ), and the CGMtothesmallartificialdatasetproducedthescatterplot
Level 1 residual variance ((cid:6)2). showninthetoppanelofFigure2.Asseeninthefigure,the
To facilitate the subsequent discussion, we generated a CGM scatter plot is identical to that of the raw data (see
small artificial data set that consisted of three clusters Figure 1), except for the labeling of the workload values
(workgroups) and n j (cid:7) 5 cases (employees) within each along the horizontal axis. The fact that CGM does nothing
cluster.Ascatterplotdisplayingtherawdataisgiveninthe to the rank order of scores on either variable suggests that
top panel of Figure 1. The data were generated such that the complex, multilevel association between work hours
work hours and well-being contained a considerable pro- and well-being is unaffected by grand mean centering.
portion of between-cluster variation (i.e., mean differences To further illustrate the impact of CGM, the correlations
among clusters accounted for a significant portion of the andclustermeansfromtheartificialdataaregiveninTable
totalscorevariation).Thebetween-clustervariationinwork 1. As seen in the table, the magnitude of the mean differ-
hours is evidenced by the spread of the clusters along the encesontheworkloadvariable isunaffectedby CGM,and
horizontal axis, and the vertical separation of the clusters the raw and centered workload scores possess the same
reflects between-group variation in the well-being scores. correlationwiththewell-being(r(cid:7)(cid:9).86).Moreimportant,
The mean differences in workload accounted for approxi-
mately 69% of the total score variation (i.e., the intraclass
correlation,ortheproportionofthetotalvariationthatexists 1A brief explanation of the notation used in this article is
at Level, 2 was (cid:5) /[(cid:5) (cid:8) (cid:6)2] (cid:7) .69), and differences warranted. Like OLS regression, the values of explanatory vari-
00 00
ablesinMLMsareassumedtobefixedasopposedtorandom.Our
among well-being means accounted for 84% of the varia-
notationalschememakesnodistinctionbetweenfixedandrandom
tion. These data do not represent a realistic application of
variables, and we generically refer to any measured variable by
MLMbecausethenumberofclustersisverysmall,andthe
usinguppercase,italictypeface.Therealizedvaluesofavariable
intraclasscorrelationislargerthanwhatonemighttypically are designated using lowercase, italic typeface (e.g., x (cid:7) 0).
ij
seewithcross-sectionaldata.However,thesecharacteristics
Finally, all residual terms are denoted using lowercase, italic
maketheartificialdatasetusefulforvisuallydemonstrating typeface.
the effects of different forms of centering. 2Interested readers are encouraged to consult Snijders and
Itmaynotbeimmediatelyobvious,butthetotalcorrela- Bosker (1999, p. 26) for an excellent discussion of within- and
tion between workload and well-being has both a within- between-clusterrelationships.

| 124 |     |     |     | ENDERSANDTOFIGHI |     |     |             |            |     |     |            |           |
| --- | --- | --- | --- | ---------------- | --- | --- | ----------- | ---------- | --- | --- | ---------- | --------- |
| A   |     |     |     |                  |     | the | table shows | that HOURS |     | is  | correlated | with both |
cgm
Level1andLevel2variables(e.g.,workgroupsize;SIZE).
|     | 80  |     |     |     |     | Atfirstglance,itmayappearstrangethataLevel1variable |     |                |                |             |             |                |
| --- | --- | --- | --- | --- | --- | --------------------------------------------------- | --- | -------------- | -------------- | ----------- | ----------- | -------------- |
|     |     |     |     |     |     | is correlated                                       |     | with variables | at             | both levels | of          | the hierarchy. |
|     |     |     |     |     |     | However,                                            | the | fact that      | the intraclass |             | correlation | is greater     |
70
80
gnieB-lleW
60
70
A
50
gnieB-lleW
60
40
B
|     | 30  | 40  | 50  | 60  | 70  |     | 50  |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Work Hours
B
|     | 80  |     |     |     |     |     | 40  |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|     |     |     |     |     |     |     | -20 | -10 |     | 0   | 10  | 20  |
Work Hours (CGM)
70
| snaeM retsulC gnieB-lleW |     |     |     |     |     |     | 80  |     |     |     |     |     |
| ------------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
60
70
A
gnieB-lleW
50
60
B
40
50
|     | 30  | 40  | 50  | 60  | 70  |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Work Hour Cluster Means
| Figure1. |     | A:Scatterplotoftheartificialdataset.Cluster1cases |     |     |     |     |     |     |     |     |     |     |
| -------- | --- | ------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
40
| are         | denoted | by open triangles,  | and Cluster            | 2 and 3     | cases are |     |     |     |     |     |     |     |
| ----------- | ------- | ------------------- | ---------------------- | ----------- | --------- | --- | --- | --- | --- | --- | --- | --- |
| denoted     | by      | plus signs and open | circles, respectively. | A           | negative  |     |     |     |     |     |     |     |
|             |         |                     |                        |             |           |     | -20 | -10 |     | 0   | 10  | 20  |
| correlation |         | exists within each  | cluster, such          | that higher | workload  |     |     |     |     |     |     |     |
Work Hours (CWC)
scoresareassociatedwithlowerwell-being.B:Scatterplotofthe
cluster means. A negative association exists among the means, Figure2. Scatterplotofartificialdataundergrandmeancenter-
such that the average well-being score decreases as the mean ing (CGM) and within-cluster centering (CWC). Cluster 1 cases
workloadincreases. are denoted by open triangles, and Cluster 2 and 3 cases are
denotedbyplussignsandopencircles,respectively.

|     |     |     |     |     |     | CENTERINGINMULTILEVELMODELS |     |     |     |     |     |     |     |     | 125 |
| --- | --- | --- | --- | --- | --- | --------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Table1 expected well-being score for a case belonging to cluster j
ClusterMeansandCorrelationsfortheArtificialDataUnder after “equating” the clusters on their average workload). A
DifferentFormsofCentering
|     |     |     |     |     |     |     |     | graphical | depiction | of  | the ANCOVA |     | adjustment | can | be  |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | --------- | --- | ---------- | --- | ---------- | --- | --- |
foundinintermediatestatisticstexts(e.g.,Stevens,1999,p.
ClusterM
311).
| Cluster |     | WELLBEING | HOURS |     | HOURS |     | HOURS |     |     |     |     |     |     |     |     |
| ------- | --- | --------- | ----- | --- | ----- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
raw cgm cwc Asdiscussedearlier,theMLManalysisultimatelyyields
(cid:9)10
1 72 40 0 anestimateofthemeanintercept,whichwasdenotedas(cid:4)
00
|     | 2   | 62  |     | 50  |     | 0   | 0   |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
inEquation4.Fromthepreviousdiscussion,itfollowsthat
|     | 3    | 48  |     | 60  |     | 10  | 0   |                |     |             |     |             |          |     |       |
| --- | ---- | --- | --- | --- | --- | --- | --- | -------------- | --- | ----------- | --- | ----------- | -------- | --- | ----- |
|     |      |     |     |     |     |     |     | this parameter | is  | interpreted | as  | the average | adjusted |     | mean. |
|     | Data |     | 1 2 | 3   | 4   | 5   | 6 7 |                |     |             |     |             |          |     |       |
AlthoughtheMLMintercepthasastraightforwardinterpre-
| 1.WELLBEING |     |     | —   |     |     |     |     |     |     |     |     |     |     |     |     |
| ----------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
tation,thepresenceofbetween-clustervariationinthecen-
| 2.HOURS |     |     | (cid:9).86 — |     |     |     |     |     |     |     |     |     |     |     |     |
| ------- | --- | --- | ------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
raw
|         |     |     | (cid:9).86 |     |     |     |     | teredworkloadscoresmakestheinterpretationoftheCGM |     |     |     |     |     |     |     |
| ------- | --- | --- | ---------- | --- | --- | --- | --- | ------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
| 3.HOURS |     |     | 1.00       |     | —   |     |     |                                                   |     |     |     |     |     |     |     |
cgm (cid:9).22 slope coefficient more problematic. To illustrate, the top
| 4.HOURS |     |     |     | .57 | .57 — |     |     |     |     |     |     |     |     |     |     |
| ------- | --- | --- | --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
cwc panel of Figure 3 superimposes three regression lines over
| 5.x(cid:1) |     |     | (cid:9).90 | .82 | .82 0 | —   |     |     |     |     |     |     |     |     |     |
| ---------- | --- | --- | ---------- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
HOURSi
6.y(cid:1) .90 (cid:9).82 (cid:9).82 0 (cid:9).99 — theCGMscatterplot.Specifically,thedottedlinerepresents
W E LLBEINGj
7.S IZ E (cid:9).44 .33 .33 0 .40 (cid:9).48 — the regression of well-being on workload within each clus-
ter(i.e.,thepooledwithin-clusterregression,(cid:1)
Note. RAW(cid:7)originalmetric;CGM(cid:7)grandmeancentered;CWC(cid:7) ).Next,the
w
centered within cluster; WELLBEING (cid:7) psychological well-being; solidlinereflectstherelationshipbetweentheclustermeans
HOURS(cid:7)workloadmeasuredinhoursperweek;SIZE(cid:7)workgroupsize.
|     |     |     |     |     |     |     |     | at Level | 2 (i.e., | the between-cluster |     |     | regression, | (cid:1) | ); this |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | -------- | ------------------- | --- | --- | ----------- | ------- | ------- |
b
|     |     |     |     |     |     |     |     | association | was | previously | depicted | in  | the bottom | panel | of  |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | --- | ---------- | -------- | --- | ---------- | ----- | --- |
Figure1.Finally,thedashedlinerepresentsthetotalregres-
((cid:1))
thanzero(andlessthanunity)impliesthatworkhours(and sion line and can be thought of as the slope obtained
t
thusHOURS )canbeviewedasacompositevariablethat from an analysis that ignores the nesting of cases within
cgm
contains both within- and between-cluster variation (i.e., organizations (i.e., a disaggregated analysis).
|     |     | (cid:3) x(cid:1) | (cid:7) |     | (cid:3) | x(cid:1) | (cid:8) [x(cid:1) |     |     |     |     |     |     |     |     |
| --- | --- | ---------------- | ------- | --- | ------- | -------- | ----------------- | --- | --- | --- | --- | --- | --- | --- | --- |
HOURS [HOURS ] When analyzing clustered data such as these using OLS
|     | ij  | HOURS |     |     | ij  | HOURSj | HOURSj |     |     |     |     |     |     |     |     |
| --- | --- | ----- | --- | --- | --- | ------ | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
(cid:9)x(cid:1) ] (cid:7) within (cid:8) between). The presence of variation regression, the total regression coefficient is actually a
HOURS
at both levels of the hierarchy leads to an important con- weighted combination of the within- and between-cluster
clusion: CGM yields scores that are correlated with vari- regressioncoefficients(Raudenbush&Bryk,2002,p.137).
ablesatbothlevelsofthehierarchy.Theprecedingpointis ThisresultisclearlyevidentinthetoppanelofFigure3,in
vital for understanding the differences between CGM and which the total regression line (the dashed line) is flatter
CWC, and we revisit it throughout the article. thanthebetween-clusterslope(thesolidline)butissteeper
How does CGM affect the interpretation of the MLM than the within-cluster regression (the dotted line). The
parameters?TheLevel1regressionequationunderCGMis problem with an OLS analysis of clustered data is that it
|     |     |     |     |     |     |     |     | incorrectly | summarizes | the | complex | association |     | between | X   |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ---------- | --- | ------- | ----------- | --- | ------- | --- |
WELLBEING (cid:1)(cid:1) (cid:2)(cid:1) (cid:2)HOURS (cid:3)x(cid:1) (cid:3)(cid:2)r . (5) andYbyusingonlyasingleparameter((cid:1)).Asaresult,“(cid:1)ˆ
|           |     | ij        | 0j       | 1j        | ij       | HOURS       | ij        |              |         |                 |          |       |                 |            |       |
| --------- | --- | --------- | -------- | --------- | -------- | ----------- | --------- | ------------ | ------- | --------------- | -------- | ----- | --------------- | ---------- | ----- |
|           |     |           |          |           |          |             |           |              |         |                 |          |       | t               |            | t     |
|           |     |           |          |           |          |             |           | is generally | an      | uninterpretable |          | blend | of (cid:1)ˆ and | (cid:1)ˆ ” | (Rau- |
| Equation  |     | 5 shows   | that the | intercept |          | for cluster | j is the  |              |         |                 |          |       | w               | b          |       |
|           |     |           |          |           |          |             |           | denbush      | & Bryk, | 2002,           | p. 138). |       |                 |            |       |
| predicted |     | score for | a case   | whose     | workload | value       | is at the |              |         |                 |          |       |                 |            |       |
ReturningtothecombinedmodelnotationinEquation4,
| grand | mean | (i.e., | when HOURS |     | (cid:7) x(cid:1) | ,   | the predicted |     |     |     |     |     |     |     |     |
| ----- | ---- | ------ | ---------- | --- | ---------------- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
ij HOURS the association between workload and well-being is also
(cid:1)
WELLBEING score is ). Further insight into the defini- ((cid:4)
|     |     |     | 0j  |     |     |     |     | represented | by a | single | regression | coefficient |     | )   | that is |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ---- | ------ | ---------- | ----------- | --- | --- | ------- |
tion of (cid:1) can be achieved by taking the expectation of 10
0j analogous to (cid:1). The presence of between-cluster variation
| Equation |     | 5 within | each cluster |     | (the expectation |     | of WELL- |     | t   |     |     |     |     |     |     |
| -------- | --- | -------- | ------------ | --- | ---------------- | --- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
inthecenteredscoresmeansthattheCGMregressionslope
| BEING  |     | and HOURS   | is  | the cluster | mean, | and | the expec- |                                                     |          |     |                 |     |            |     |     |
| ------ | --- | ----------- | --- | ----------- | ----- | --- | ---------- | --------------------------------------------------- | -------- | --- | --------------- | --- | ---------- | --- | --- |
|        | ij  |             | ij  |             |       |     |            | isalsoamixtureofthewithin-andbetween-clusterassoci- |          |     |                 |     |            |     |     |
| tation | of  | r is zero), | and | rearranging | terms | as  | follows:   |                                                     |          |     |                 |     |            |     |     |
|        |     | ij          |     |             |       |     |            | ation between                                       | workload |     | and well-being. |     | Raudenbush |     | and |
(cid:1) (cid:1)(cid:10) (cid:3)(cid:1) (cid:2)x(cid:1) (cid:3)x(cid:1) (cid:3). (6) Bryk (2002) made this point, stating that, “the hierarchical
|     |     | 0j  | WELLBEINGj | 1j  | HOURSj | HOURS |     |           |       |            |           |     |                     |     |     |
| --- | --- | --- | ---------- | --- | ------ | ----- | --- | --------- | ----- | ---------- | --------- | --- | ------------------- | --- | --- |
|     |     |     |            |     |        |       |     | estimator | under | grand-mean | centering |     | is an inappropriate |     |     |
Equation 6 shows that the Level 1 intercept is equal to the estimator of the person-level [i.e., Level 1] effect. It too is
well-being mean for cluster j, minus an adjustment that an uninterpretable blend: neither (cid:1) nor (cid:1) ” (p. 139).
|     |     |     |     |     |     |     |     |     |     |     |     | w   | b   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
depends on the regression slope, and on the deviation be- The use of CGM also affects the interpretation of the
tweentheworkloadmeanforclusterjandthegrandmean. MLM variance components. We have previously shown
Readers may recognize Equation 6 as the formula used to that the intercept for cluster j is interpreted as an adjusted
obtain adjusted means in the analysis of covariance mean, so it follows that the CGM estimate of the intercept
(ANCOVA) context, and the Level 1 intercept can also be variance ((cid:5) ) quantifies variation in the adjusted outcome
00
interpreted as the adjusted mean for cluster j (i.e., the means (i.e., the variation in the well-being means after

| 126 |     |     |     |     | ENDERSANDTOFIGHI |     |             |     |            |     |            |          |     |     |     |
| --- | --- | --- | --- | --- | ---------------- | --- | ----------- | --- | ---------- | --- | ---------- | -------- | --- | --- | --- |
|     |     |     |     |     |                  |     | partialling | out | the effect | of  | workload). | However, |     | the | CGM |
80 estimate of the slope variance ((cid:5) ) is problematic and is
11
|     |     |     |     |     |     |     | potentially                                        | biased    | toward      | zero.        | When    | the           | regression | slopes  |     |
| --- | --- | --- | --- | --- | --- | --- | -------------------------------------------------- | --------- | ----------- | ------------ | ------- | ------------- | ---------- | ------- | --- |
|     |     |     |     |     |     |     | vary across                                        | clusters, |             | a dependency |         | is introduced |            | between |     |
|     |     |     |     |     |     |     | the intercepts                                     |           | and slopes, |              | because | the           | magnitude  | of      | the |
|     | 70  |     |     |     |     |     | adjustmenttoeachcluster’smean(seeEquation6)depends |           |             |              |         |               |            |         |     |
((cid:1)
|     |     |     |     |     |     |     | on the cluster-specific |     |     | slope | coefficient |     | )—this | is  | anal- |
| --- | --- | --- | --- | --- | --- | --- | ----------------------- | --- | --- | ----- | ----------- | --- | ------ | --- | ----- |
1j
|            |     |     |     |     |     |     | ogous to                                          | violating | the          | homogeneity     |          | of regression |               | assump-     |       |
| ---------- | --- | --- | --- | --- | --- | --- | ------------------------------------------------- | --------- | ------------ | --------------- | -------- | ------------- | ------------- | ----------- | ----- |
| gnieB-lleW |     |     |     |     |     |     | tioninANCOVA.Thisdependencyservestoconfoundthe    |           |              |                 |          |               |               |             |       |
|            | 60  |     |     |     |     |     | CGMestimatesoftheinterceptandslopevariance,making |           |              |                 |          |               |               |             |       |
|            |     |     |     |     |     |     | the interpretation                                |           | of           | these estimates |          | somewhat      |               | ambiguous.  |       |
|            |     |     |     |     |     |     | Understanding                                     |           | the          | resulting       | bias     | in the        | CGM           | slope       | vari- |
|            |     |     |     |     |     |     | ance estimate                                     |           | requires     | a brief         | tangent  | into          | the           | expectation |       |
|            | 50  |     |     |     |     |     | maximization                                      |           | (EM)         | algorithm,      | an       | iterative     | computational |             |       |
|            |     |     |     |     |     |     | algorithm                                         | used      | to obtain    | maximum         |          | likelihood    |               | parameter   |       |
|            |     |     |     |     |     |     | estimates.                                        | The       | EM algorithm |                 | requires | the           | computation   |             | of    |
|            |     |     |     |     |     |     | empirical                                         | Bayes     | (EB)         | estimates       | of       | each          | cluster’s     | intercept   |       |
|            |     |     |     |     |     |     | and slope,                                        | computed  |              | as a            | weighted | sum           | of the        | OLS         | esti- |
40
|     |     |     |     |     |     |     |          | (cid:1) | (cid:1) |         |                 |     |        |     |        |
| --- | --- | --- | --- | --- | --- | --- | -------- | ------- | ------- | ------- | --------------- | --- | ------ | --- | ------ |
|     |     |     |     |     |     |     | mates of | and     |         | and the | model-predicted |     | values |     | of the |
0j 1j
-20 -10 0 10 20 interceptandslope(e.g.,(cid:4) and(cid:4) ).WhentherangeofX
|     |     |     |     |     |     |     |     |     |     | 00  |     | 10  |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Work Hours (CGM)
|     |     |     |     |     |     |     | values for   | cluster | j does      | not       | include    | the        | grand         | mean,   | the  |
| --- | --- | --- | --- | --- | --- | --- | ------------ | ------- | ----------- | --------- | ---------- | ---------- | ------------- | ------- | ---- |
|     |     |     |     |     |     |     | OLS estimate |         | of the      | intercept | is         | unreliable |               | because | the  |
|     | 80  |     |     |     |     |     | adjustment   | term    | in Equation |           | 6 involves |            | extrapolation |         | out- |
sidetherangeofobservedXvalues.Asaconsequence,the
|     |     |     |     |     |     |     | EB estimate | of              | the intercept |        | is more | heavily | weighted |     | by a |
| --- | --- | --- | --- | --- | --- | --- | ----------- | --------------- | ------------- | ------ | ------- | ------- | -------- | --- | ---- |
|     |     |     |     |     |     |     | constant    | model-predicted |               | value, |         | and the | estimate | of  | the  |
70 intercept variation becomes attenuated—this concept is re-
ferredtoasshrinkageintheMLMliterature.BecauseCGM
|     |     |     |     |     |     |     | induces | a dependency |     | between | the | intercepts | and | slopes, | it  |
| --- | --- | --- | --- | --- | --- | --- | ------- | ------------ | --- | ------- | --- | ---------- | --- | ------- | --- |
gnieB-lleW follows that the variation in the slopes is also artificially
|     | 60  |     |     |     |     |     | compressed,resultinginanegativelybiasedestimateofthe |     |             |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ---------------------------------------------------- | --- | ----------- | --- | --- | --- | --- | --- | --- |
|     |     |     |     |     |     |     | slope variance                                       |     | ((cid:5) ). |     |     |     |     |     |     |
11
|     |     |     |     |     |     |     |     | Centering |     | Within | Cluster | (CWC) |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | --- | ------ | ------- | ----- | --- | --- | --- |
50
|     |     |     |     |     |     |     | Under | CWC, | the Level | 1   | predictor | (work | hours) | is  | devi- |
| --- | --- | --- | --- | --- | --- | --- | ----- | ---- | --------- | --- | --------- | ----- | ------ | --- | ----- |
atedaroundthemeanoftheclusterjtowhichcaseibelongs
|     |     |     |     |     |     |     | (i.e., HOURS |     | (cid:3) x(cid:1) | );  | for simplicity, |     | the group | mean- |     |
| --- | --- | --- | --- | --- | --- | --- | ------------ | --- | ---------------- | --- | --------------- | --- | --------- | ----- | --- |
ij HOURSj
|     | 40  |     |     |     |     |     | centered | scores | are | henceforth | referred |     | to as | HOURS | .   |
| --- | --- | --- | --- | --- | --- | --- | -------- | ------ | --- | ---------- | -------- | --- | ----- | ----- | --- |
cwc
|     |     |     |     |     |     |     | Again, it | is informative |     | to  | see how | CWC | affects | the | mul- |
| --- | --- | --- | --- | --- | --- | --- | --------- | -------------- | --- | --- | ------- | --- | ------- | --- | ---- |
|     | -20 | -10 | 0   |     | 10  | 20  |           |                |     |     |         |     |         |     |      |
tilevelstructureofthedatabeforeconsideringitsimpacton
Work Hours (CWC)
|     |     |     |     |     |     |     | MLM parameters. |     | The | bottom | panel | of  | Figure | 2 shows | a   |
| --- | --- | --- | --- | --- | --- | --- | --------------- | --- | --- | ------ | ----- | --- | ------ | ------- | --- |
Figure3. Scatterplotofartificialdataundergrandmeancenter- CWC scatter plot that is radically different from that of
| ing | (CGM) | and within-cluster | centering | (CWC). | Ordinary | least |         |             |          |     |          |        |         |     |     |
| --- | ----- | ------------------ | --------- | ------ | -------- | ----- | ------- | ----------- | -------- | --- | -------- | ------ | ------- | --- | --- |
|     |       |                    |           |        |          |       | CGM. To | illustrate, | consider |     | the data | points | labeled | A   | and |
squaresregressionlinesaresuperimposedovertheplot.Inthetop Binthefigure.CaseAhasthehighestworkloadamongthe
panel(CGM),thedottedlinerepresentsthepooledwithin-cluster Cluster 1 cases (denoted with a diamond), and Case B has
| regression | ((cid:1) | ), whereas     | the solid line | is           | the between-cluster |             |              |          |     |            |           |          |       |            |     |
| ---------- | -------- | -------------- | -------------- | ------------ | ------------------- | ----------- | ------------ | -------- | --- | ---------- | --------- | -------- | ----- | ---------- | --- |
|            |          | w              |                |              |                     |             | the lowest   | workload |     | in Cluster | 3         | (denoted | with  | a circle). |     |
| regression | of       | the well-being | means on       | the workload | means               | ((cid:1) ). |              |          |     |            |           |          |       |            |     |
|            |          |                |                |              |                     | b           | Furthermore, | the      | top | panel      | of Figure | 2        | shows | that Case  | B   |
Thedashedlineisthetotalregressionthatignorestheclusteringof
((cid:1)). has a slightly higher workload score than Case A (this is
| cases | within | organizations | In the | bottom | panel (CWC), | the |     |     |     |     |     |     |     |     |     |
| ----- | ------ | ------------- | ------ | ------ | ------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
workloadscorescontainnobetween-clustervariation,so(cid:1) t (cid:7)0, also true of the raw data, as seen in Figure 1). In contrast,
b
and the total regression line quantifies the pooled within-cluster the relative position of these two cases changes rather
regressioncoefficient. dramatically under CWC, such that Case A has the higher
workloadscore.Therankorderchangeowestothefactthat

CENTERINGINMULTILEVELMODELS 127
workload scores are now expressed relative to other cases pooledwithin-cluster(i.e.,Level1)regressionofwell-being
belonging to the same cluster. on workload. This can be seen graphically in the bottom
The descriptive statistics and correlations in Table 1 fur- panel of Figure 3, in which the total regression line (the
therclarifythedifferencesbetweenCGMandCWC.Unlike dashed line) is approximately equal to the pooled within-
CGM,CWCfundamentallyaltersthemeanandcorrelation cluster regressions (the dotted lines).
structure of the data. For example, note that the workload The use of CWC also affects the interpretation of the
cluster means are all zero under CWC; said differently, variance components. Because the Level 1 intercept is an
HOURS contains no between-cluster variation. The ab- unadjustedmean,itfollowsthattheinterceptvariance((cid:5) )
cwc 00
senceofbetween-clustervariationisseengraphicallyinthe quantifies the between-cluster variation in the outcome
bottompanelofFigure2,inwhichtheclustersarenolonger scores, or the variance of the unadjusted cluster means. As
separated along the horizontal axis. such, the estimate of (cid:5) obtained from CWC should be
00
Removing the between-cluster variation in the workload nearly identical to that obtained from an unconditional
scores has important implications for the correlation struc- model with no predictors. We previously pointed out that
ture. Specifically, notice that HOURS is correlated with theCGMestimateoftheslopevarianceispotentiallybiased
cwc
Level1variables(e.g.,well-being)butisuncorrelatedwith because of a dependency on intercepts that were subject to
Level2variables(e.g.,workgroupsize).Also,notethatthe shrinkage. The same is not true of CWC, so the resulting
magnitude of the correlation between workload and well- estimate of the slope variation is generally more accurate
being is different under CGM and CWC. HOURS is a (Raudenbush & Bryk, 2002).
cgm
composite variable that contains variation at both levels of
the hierarchy, so it follows that the correlation between The Linkage Between Centering and
HOURS and well-being is a blend of the within- and Substantive Questions
cgm
between-cluster associations depicted in Figure 1. In con-
trast, the correlation between HOURS and well-being is Thus far, we have established that the interpretation of
cwc
much weaker (r (cid:7) (cid:9).22 versus (cid:9).86) because it is unaf- MLM parameters is fundamentally different under CGM
fected by the strong Level 2 association shown in the and CWC. To briefly summarize, CGM produced an inter-
bottompanelofFigure1.ThefactthatCWCpurgesscores cept value that was interpreted as the average adjusted
of all between-cluster mean differences leads to a second mean, whereas the CWC intercept value was the average
importantconclusion:CWCproducesscoresthatareuncor- unadjusted mean. The centered scores under CGM con-
relatedwithLevel2variables.Again,theprecedingpointis tained both within- and between-cluster variation, resulting
vital for understanding the differences between CGM and in a regression slope that was an ambiguous mixture of the
CWC and is revisited throughout the remainder of the Level 1 (e.g., person level) and Level 2 (e.g., organization
article. level) association between X and Y. In contrast, centered
Having gained some intuition about CWC, we now ex- scores under CWC were uncorrelated with Level 2 vari-
amine its impact on the interpretation of MLM parameters. ables, so the resulting regression coefficient was a pure
The Level 1 regression equation under CWC is estimate of the Level 1 relationship between X and Y. The
choice of centering also affected the interpretation of the
WELLBEING (cid:1)(cid:1) (cid:2)(cid:1) (cid:2)HOURS (cid:3)x(cid:1) (cid:3)(cid:2)r . (7) variance components. The CGM estimate of the intercept
ij 0j 1j ij HOURSj ij
variance quantified variation in the adjusted means (i.e.,
Equation7showsthattheinterceptisthepredictedscorefor variation in the outcome means, having controlled for the
a case in which the workload value is at the cluster mean Level 1 predictor), whereas the CWC variance estimate
(i.e.,whenHOURS (cid:7)x(cid:1) ,thepredictedWELLBEING captured variation in the unadjusted means. We also dis-
ij HOURSj
scoreis(cid:1) ).FromOLSregression,weknowthatthemean cussedthedifferencesintheestimatesoftheslopevariation
0j
ofYisthepredictedvalueassociatedwiththemeanofX,so and pointed out potential problems associated with the
it follows that the Level 1 intercept is the unadjusted mean CGM estimate of the slope variance.
for cluster j. By extension, the intercept parameter in the Fromthepreviousdiscussion,onemightreasonablycon-
combined model ((cid:4) in Equation 4) is interpreted as the clude that the use of CGM is problematic and should be
00
average unadjusted cluster mean. avoided. However, this is far from true. It is our view that
The use of CWC also changes the interpretation of the thechoiceofcenteringmethodisintimatelylinkedtoone’s
MLMregressionslope.TheCGMslopecoefficientisprob- substantive research questions, and both CGM and CWC
lematic because it is a mixture of the within- and between- areappropriateincertaincircumstancesandareinappropri-
cluster association between X and Y. In contrast, CWC ate in others. It is generally true that a particular research
removes all between-cluster variation from the predictor question calls for either CGM or CWC, but it is also true
variable and yields a slope coefficient (i.e., the (cid:4) coeffi- that CGM and CWC may be used to address different
10
cientinEquation4)thatisunambiguouslyinterpretedasthe questions within the same study.

128 ENDERSANDTOFIGHI
Given the linkage between centering and one’s substan- studentmayfeellessefficaciouswhensurroundedbyhigh-
tive question, we further explore the differences between achieving peers (Marsh & Hau, 1987, 2003). Per the occu-
CGM and CWC in the context of some prototypical re- pationalstressexample,researchershavepositedthatstrain
search questions that may be of interest to researchers who mayresultwhenanindividual’sworkloadishighrelativeto
use MLM. In doing so, we hope to provide a few straight- othersintheirimmediateworkgroupbecauseofperceptions
forwardrulesofthumbforcenteringLevel1predictors.For of unfairness (Bliese & Jex, 2002). In situations such as
thispurpose,weclassifysubstantiveresearchquestionsinto these, it is natural to conceive of the multilevel analysis as
four broad scenarios: (a) the primary substantive interest a two-step procedure, whereby separate models are first fit
involvesaLevel1predictor(e.g.,Whatistheimpactofan to each organization’s data, and the resulting regression
individual’s workload on his or her well-being?), (b) the coefficients are subsequently aggregated in order to obtain
primary substantive interest involves the influence of a anestimateofthepooledwithin-cluster slope.Thistypeof
Level2predictor(e.g.,Whatistheimpactofcompanysize substantivefocusnaturallylendsitselftoCWC(Kreftetal.,
on well-being?), (c) it is of interest to determine whether a 1995).
predictor exerts the same influence at the individual and
cluster level (i.e., Is the influence of an individual’s work- A Level 2 Predictor Is of Substantive Interest
loadonwell-beingthesameastheinfluenceofacompany’s
averageworkloadonwell-being?),and(d)itisofinterestto In this scenario, the primary substantive focus is on a
examine interaction effects (e.g., Does company size mod- Level 2 (i.e., cluster level) predictor variable (e.g., What is
erate the relationship between individual workload and the impact of company size on well-being?). The cluster-
well-being?). These four categories are obviously not ex- level variable of interest may be an aggregate of the indi-
haustive and do not capture every research question that vidualscoreswithineachcluster(e.g.,averageworkhours)
MLMs are capable of addressing. Nevertheless, we believe or may contain no systematic variation at the individual
that these scenarios are inclusive of many substantive ap- level(e.g.,companysize);Susser(1994)referredtotheseas
plications of MLM found in the behavioral science litera- contextual and integral variables, respectively. At one ex-
ture.Again,itisimportanttoemphasizethatdifferentforms treme,theremaynoLevel1predictorsinthemodel,sothe
of centering may be required to address research questions centering of Level 2 variables would simply follow the
within the same study, so the centering recommendations prescribed practice in the OLS literature (e.g., Aiken &
below should not be viewed as mutually exclusive deci- West, 1991). However, it is probably more typically the
casethatbothLevel1andLevel2variablesareincludedin
sions.
the model, in which case the Level 1 (e.g., person level)
predictors might be viewed as nuisance variables that need
A Level 1 Predictor Is of Substantive Interest
to be controlled for. A prototypical example of this type of
application is a cluster randomized study where Level 2
CWC may be the most appropriate form of centering in
units (e.g., organizations, schools) are assigned to partici-
situationsinwhichtheprimarysubstantiveinterestinvolves
pateineitherthetreatmentorcontrolcondition.Inthiscase
aLevel1(i.e.,personlevel)predictor.Therationaleforthis
itwouldbeofinteresttoassessthetreatmenteffect(e.g.,a
suggestion follows from the fact that CWC removes all
Level 2 dummy variable), controlling for individual differ-
between-cluster variation from the predictor and yields a
ences on a number of Level 1 covariates. We subsequently
“pure” estimate of the pooled within-cluster (i.e., Level 1)
demonstrate that CGM is ideally suited for this situation.
regression coefficient. Raudenbush and Bryk (2002) sum-
Returning to the occupational stress scenario, suppose
marized this situation, stating that “when an unbiased esti-
mateof(cid:1) [i.e.,theLevel1relationship]isdesired,group- thatitwasofinteresttoexaminetheinfluenceofgroupsize
w
(SIZE)onpsychologicalwell-being,controllingforindivid-
mean centering [i.e., CWC] will produce it” (p. 139). The
ual differences in workload. Although we have not yet
use of CWC is also beneficial in this situation because it
discussed models with Level 2 predictors, CGM is the
yields a more accurate estimate of the slope variance.
method of choice for assessing the impact of cluster-level
Again, Raudenbush and Bryk (2002) suggested the use of
variables,controllingforLevel1covariates.Tounderstand
CWC for this purpose, stating that “we recommend group-
whythis is so,weexaminethecombinedmodel regression
mean centering [CWC] to detect and estimate properly the
equation that results from adding workgroup size to the
slope heterogeneity” (p. 143).
model, as follows:
The substantive focus on a Level 1 predictor and the
subsequentuseofCWCimpliesthatanindividual’srelative
WELLBEING (cid:1)(cid:4) (cid:2)(cid:4) (cid:2)SIZE(cid:3)
positionwithinagroupisanimportantdeterminantofhisor ij 00 01 j
her behavior (i.e., the frog pond effect; Davis, 1966). For (cid:2)(cid:4) (cid:2)HOURS (cid:3)(cid:2)(cid:11)residuals]. (8)
10 cgm
example, it has been hypothesized that academic self-con-
cept is influenced by one’s immediate peers, such that a For simplicity, the collection of residual terms from Equa-

CENTERINGINMULTILEVELMODELS 129
tion 4 has been omitted and has been replaced by a single being and accounted for a significant proportion of the
terminbrackets.BecausetheLevel1predictor,HOURS , variation in well-being scores, above and beyond that of
cgm
isacompositeofwithin-andbetween-clustervariation,itis workload. Consistent with recommendations from the OLS
correlatedwiththeLevel2predictor,SIZE.Assuch,(cid:4) is regression literature, the Level 2 predictor was centered at
01
a partial regression coefficient that reflects the influence of the grand mean. All models were estimated by using full
group size, controlling for workload. It is still true that the maximumlikelihood,andtheanalyseswereperformedwith
regression coefficient associated with workload ((cid:4) ) is an the mixed procedure in SPSS 14 (Peugh & Enders, 2005).
10
ambiguous mixture of the Level 1 and Level 2 association TheartificialdataandSPSSsyntaxfortheexampleanalyses
between workload and well-being, but this is less of a are available from the authors and can also be obtained
| concern, | given that the substantive | focus is on | the Level | 2 online. |     |     |     |     |     |
| -------- | -------------------------- | ----------- | --------- | --------- | --- | --- | --- | --- | --- |
covariateanditscorrespondingregressioncoefficient((cid:4) ). We first estimated an unconditional model with no pre-
01
It is important to note that CWC does not control for dictors at either level of the hierarchy, the results from
the effects of Level 1 covariates and thus would be which are given in Table 2. As seen in the table, the
inappropriate in this scenario. This conclusion can be interceptvaluewas(cid:4) (cid:7)60.07,andtheinterceptvariance
00
(cid:5) (cid:7)
reachedbysubstitutingHOURS intoEquation8inplace estimate was 47.36.
|     |     | cwc |     |     | 00  |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
of HOURS . Level 1 predictors that are centered at the The next section in Table 2 gives the results from two
cgm
group mean are uncorrelated with Level 2 variables, so the models, one of which included HOURS as a predictor
cgm
useofCWCinthissituationwouldresultintwoorthogonal and the other of which included HOURS . First, notice
cwc
predictors, and the influence of SIZE would be evaluated, that the CGM regression coefficient was slightly larger in
|     |     |     |     |     |     |     | ((cid:4) | (cid:7) (cid:9).31 | (cid:9).29, |
| --- | --- | --- | --- | --- | --- | --- | -------- | ------------------ | ----------- |
independentofworkhours.Infact,theregressionslopefor absolute value than that of CWC vs.
10
workgroup size would be the same regardless of whether respectively). Recall from a previous discussion that CWC
HOURS was even in the model. is preferred when the substantive focus involves a Level 1
cwc
variable,becausethe(cid:4)
Toillustratetheconceptspresentedthusfar,wegenerated coefficientisanunbiasedestimate
10
anartificialdatasetwith300clustersof40caseseach.The ofthewithin-clusterregression.Incontrast,thecorrespond-
data were roughly consistent with Figure 1, such that the ing CGM coefficient is a blend of the Level 1 and Level 2
Level 2 association between workload and well-being was regressions. The fact that the CGM coefficient was some-
stronger than that at Level 1; both variables had an intra- whatlargerthanthatofCWCisexpectedinthiscase,given
class correlation of approximately .50. Additionally, the that the association between workload and well-being was
Level 2 variable SIZE was negatively correlated with well- stronger at Level 2 (i.e., the CGM coefficient is getting
Table2
ParameterEstimates(PEs)FromExampleAnalysis1
|           |                         |          |            |        | CGM   |        |     | CWC |     |
| --------- | ----------------------- | -------- | ---------- | ------ | ----- | ------ | --- | --- | --- |
|           |                         |          |            |        | SE    | t      |     | SE  | t   |
|           | Model                   |          |            | PE     |       |        | PE  |     |     |
|           | (cid:7)(cid:4) (cid:8)u | (cid:8)r | (cid:4)    |        |       |        |     |     |     |
| WELLBEING |                         |          |            | 60.074 | .403  | 149.25 |     |     |     |
|           | ij 00 0j                | ij       | (cid:5) 00 |        |       |        |     |     |     |
|           |                         |          |            | 47.355 | 3.969 | 11.93  |     |     |     |
00
|     |     |     | (cid:6)2 | 49.956 | .653 | 76.49 |     |     |     |
| --- | --- | --- | -------- | ------ | ---- | ----- | --- | --- | --- |
WELLBEING (cid:7)(cid:4) (cid:8)(cid:4) (HOURS )(cid:8)u (cid:4) 59.927 .353 169.97 60.074 .403 149.25
|     | ij 00 10 | ij 0j | 00  |     |     |     |     |     |     |
| --- | -------- | ----- | --- | --- | --- | --- | --- | --- | --- |
(cid:8)u (HOURS )(cid:8)r (cid:4) (cid:9).306 .012 (cid:9)24.54 (cid:9).295 .013 (cid:9)23.06
| 1j  | ij ij |     | 10  |     |     |     |     |     |     |
| --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
(cid:5)
|     |     |     |     | 35.762 | 3.064 | 11.67 | 47.492 | 3.969 | 11.97 |
| --- | --- | --- | --- | ------ | ----- | ----- | ------ | ----- | ----- |
(cid:5) 00
.024 .004 6.23 .025 .004 6.31
11
|     |     |     | (cid:5) | (cid:9).593 | .084 | (cid:9)7.01 | (cid:9).606 | .095 | (cid:9)6.36 |
| --- | --- | --- | ------- | ----------- | ---- | ----------- | ----------- | ---- | ----------- |
10
|     |     |     | (cid:6)2 | 44.474 | .589 | 75.54  | 44.469 | .589 | 75.51  |
| --- | --- | --- | -------- | ------ | ---- | ------ | ------ | ---- | ------ |
|     |     |     | (cid:4)  | 59.878 | .337 | 177.46 | 60.074 | .398 | 150.93 |
00
(cid:7)(cid:4) (cid:8)(cid:4) (SIZE)(cid:8)(cid:4) (cid:4) (cid:9).165 (cid:9)5.63 (cid:9).096 (cid:9)2.64
| WELLBEING |     | (HOURS | )   |     | .029 |     |     | .036 |     |
| --------- | --- | ------ | --- | --- | ---- | --- | --- | ---- | --- |
(cid:8)u (cid:8)u ij 00 )(cid:8)r 01 j 10 ij (cid:4) 01 (cid:9).311 (cid:9)25.00 (cid:9).295 (cid:9)23.06
|     | (HOURS |     |         |        | .012  |       |        | .013  |       |
| --- | ------ | --- | ------- | ------ | ----- | ----- | ------ | ----- | ----- |
| 0j  | 1j ij  | ij  | 10      |        |       |       |        |       |       |
|     |        |     | (cid:5) | 32.624 | 2.821 | 11.57 | 46.418 | 3.881 | 11.96 |
00
|     |     |     | (cid:5) | .023 | .004 | 6.20 | .025 | .004 | 6.31 |
| --- | --- | --- | ------- | ---- | ---- | ---- | ---- | ---- | ---- |
11
|     |     |     | (cid:5) | (cid:9).581 | .081 | (cid:9)7.17 | (cid:9).601 | .094 | (cid:9)6.37 |
| --- | --- | --- | ------- | ----------- | ---- | ----------- | ----------- | ---- | ----------- |
10
(cid:6)2
|     |     |     |     | 44.486 | .589 | 75.54 | 44.468 | .589 | 75.51 |
| --- | --- | --- | --- | ------ | ---- | ----- | ------ | ---- | ----- |
Note. Allsignificancetestsweresignificantatp(cid:12).01.SignificancetestsforvariancecomponentsareWaldztests.Allresidualtermsweregenerated
tohaveanormaldistribution.ResultsfromtheunconditionalmodelwerearbitrarilylistedunderCGM,althoughnopredictorswereinthemodel.Asaresult
ofroundingerrorinthetabledvalues,someteststatisticsdonotequaltheestimatedividedbythestandarderror.CGM(cid:7)centeringatthegrandmean;
CWC(cid:7)centeringwithincluster;WELLBEING(cid:7)psychologicalwell-being;HOURS(cid:7)workloadmeasuredinhoursperweek;SIZE(cid:7)workgroupsize.

| 130 |     |     |     |     |     | ENDERSANDTOFIGHI |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | ---------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
“pulled” toward the Level 2 regression line). Second, note sion of the well-being means on the workload means (i.e.,
|          |              |     |        |           |          |     |        | the cluster-level |     | effect). |     |     |     |     |     |
| -------- | ------------ | --- | ------ | --------- | -------- | --- | ------ | ----------------- | --- | -------- | --- | --- | --- | --- | --- |
| that the | CWC estimate |     | of the | intercept | variance | was | virtu- |                   |     |          |     |     |     |     |     |
allyidenticaltothatobtainedfromtheunconditionalmodel, Inordertotestwhetherapredictorhasadifferentialeffect
which follows from the definition of (cid:1) as an unadjusted at both levels of the hierarchy, we must use the individual
0j
(cid:5)
mean. In contrast, the CGM estimate of was substan- scores and the cluster means as predictors in the model.
00
tially lower and reflects the variation in the adjusted out- DespitethefactthattheLevel2predictorisanaggregateof
theindividualscoreswithineachcluster,itisnotnecessarily
| come means | (i.e., | the | variation | in  | the well-being |     | means, |     |     |     |     |     |     |     |     |
| ---------- | ------ | --- | --------- | --- | -------------- | --- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
x(cid:1)
having partialled out the effect of workload). The (cid:5) term true that X and share the same meaning or that they
10
|                   |     |         |     |            |     |             |     | measure | the same | construct | (Firebaugh, |     | 1978). | For exam- |     |
| ----------------- | --- | ------- | --- | ---------- | --- | ----------- | --- | ------- | -------- | --------- | ----------- | --- | ------ | --------- | --- |
| is the covariance |     | between | the | intercepts |     | and slopes, | and |         |          |           |             |     |        |           |     |
differs in value due to the fact that CGM and CWC have ple, in the occupational stress literature, it has been argued
(cid:1) that the average work hours within a workgroup may be
| different | definitions | of  | .   |     |     |     |     |     |     |     |     |     |     |     |     |
| --------- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
0j
ThefinaltwomodelsinTable2includebothworkload(a dictated by externally mandated work requirements,
Level 1 variable) and group size (a Level 2 variable) as whereasanindividual’sworkloadmaybedrivenbyadesire
|     |     |     |     |     |     |     |     | to get ahead, | a   | desire | to avoid | one’s | family, | etc. (Bliese, |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- | ------ | -------- | ----- | ------- | ------------- | --- |
covariates.First,noticethattheCWCestimateofthework-
load regression coefficient was unaffected by the inclusion 2000; Bliese & Halverson, 1996). A similar distinction has
|          |          |         |      |     |           |       |     | been made | between | X and | x(cid:1) in | the public | health | literature, |     |
| -------- | -------- | ------- | ---- | --- | --------- | ----- | --- | --------- | ------- | ----- | ----------- | ---------- | ------ | ----------- | --- |
| of group | size and | follows | from | the | fact that | HOURS | is  |           |         |       |             |            |        |             |     |
cwc
orthogonal to Level 2 variables. As such, the CWC regres- in which individual and aggregated neighborhood poverty
mayexertdifferent,independenteffectsonhealthoutcomes
| sion coefficients |        | reflect  | the independent |                | influence |               | of work- |              |        |              |            |       |              |              |       |
| ----------------- | ------ | -------- | --------------- | -------------- | --------- | ------------- | -------- | ------------ | ------ | ------------ | ---------- | ----- | ------------ | ------------ | ----- |
|                   |        |          |                 |                |           |               |          | (Schwartz,   | 1994). | We include   |            | these | two examples | in           | order |
| load and          | group  | size     | as Level        | 1 and          | Level     | 2 predictors, |          |              |        |              |            |       |              |              |       |
|                   |        |          |                 |                |           |               |          | to highlight | the    | complexities | associated |       | with         | interpreting | a     |
| respectively      | (i.e., | workload | is              | not partialled |           | out when      | con-     |              |        |              |            |       |              |              |       |
Level2variablethatisanaggregateofindividualscores.A
| sidering | the influence |     | of group | size). | Under | CWC, | the (cid:4) |     |     |     |     |     |     |     |     |
| -------- | ------------- | --- | -------- | ------ | ----- | ---- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
10
|     |     |     |     |     |     |     |     | more thorough |     | discussion | of  | this issue | can | be found | in a |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- | ---------- | --- | ---------- | --- | -------- | ---- |
regressioncoefficientstillprovidesanunbiasedestimateof
|                    |        |             |     |          |       |       |           | number           | of different | sources |         | (Bliese | & Jex, | 2002; | Chan, |
| ------------------ | ------ | ----------- | --- | -------- | ----- | ----- | --------- | ---------------- | ------------ | ------- | ------- | ------- | ------ | ----- | ----- |
| the within-cluster |        | regression, |     | but the  | model | now   | yields an |                  |              |         |         |         |        |       |       |
|                    |        |             |     |          |       |       |           | 1998; Firebaugh, |              | 1978;   | Willms, | 1986).  |        |       |       |
| estimate           | of the | regression  | of  | y(cid:1) | on    | SIZE. | In con-   |                  |              |         |         |         |        |       |       |
WELLBEINGj
|               |          |          |        |          |            |       |         | Contextual | models | have         | a long | history | in        | education | and    |
| ------------- | -------- | -------- | ------ | -------- | ---------- | ----- | ------- | ---------- | ------ | ------------ | ------ | ------- | --------- | --------- | ------ |
| trast, the    | CGM      | estimate | of the | workload | regression |       | coeffi- |            |        |              |        |         |           |           |        |
|               |          |          |        |          |            |       |         | sociology, | but    | the interest | in X   | as a    | predictor | at two    | levels |
| cient changed | slightly |          | when   | group    | size was   | added | to the  |            |        |              |        |         |           |           |        |
alsohaspotentialapplicationsinpsychology.Forexample,
| model because |     | HOURS | is  | correlated | with | both | Level 1 |     |     |     |     |     |     |     |     |
| ------------- | --- | ----- | --- | ---------- | ---- | ---- | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
cgm suppose that it was of interest to examine the influence of
| and Level   | 2 variables. |      | In this       | situation, | the          | (cid:4) regression |          |                                                     |             |           |                |        |               |           |      |
| ----------- | ------------ | ---- | ------------- | ---------- | ------------ | ------------------ | -------- | --------------------------------------------------- | ----------- | --------- | -------------- | ------ | ------------- | --------- | ---- |
|             |              |      |               |            |              | 01                 |          | anxietyonpainperception.Furthermore,supposethatmul- |             |           |                |        |               |           |      |
| coefficient | quantifies   |      | the influence | of         | SIZE,        | controlling        | for      |                                                     |             |           |                |        |               |           |      |
|             |              |      |               |            |              |                    |          | tiple measurements                                  |             | of        | both variables |        | were          | obtained  | from |
| individual  | workload.    |      | The (cid:4)   | regression |              | coefficient        | still    |                                                     |             |           |                |        |               |           |      |
|             |              |      |               | 10         |              |                    |          | hospitalized                                        | individuals |           | at a           | number | of random     | intervals |      |
| gives a     | distorted    | view | of the        | Level      | 1 regression |                    | of well- |                                                     |             |           |                |        |               |           |      |
|             |              |      |               |            |              |                    |          | throughout                                          | the         | course of | a week.        | This   | is a somewhat |           | dif- |
| being on    | workload,    | but  | this is       | not a      | concern      | if the             | substan- |                                                     |             |           |                |        |               |           |      |
ferentapplicationfromtheonewehavebeenusingthrough-
tivefocusisontheLevel2covariateandthe(cid:4)
|     |     |     |     |     |     | coefficient. |     | outthisarticle,asrepeatedmeasurements(i.e.,Level1)are |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | ------------ | --- | ----------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
01
nownestedwithinindividuals(i.e.,Level2).Regardless,it
It Is of Interest to Examine a Predictor’s Influence is possible to ask whether there is a differential association
at Two Levels betweenanxietyandperceivedpainatLevel1andatLevel
|     |     |     |     |     |     |     |     | 2. The | Level 1 | association | between |     | anxiety | and pain | ad- |
| --- | --- | --- | --- | --- | --- | --- | --- | ------ | ------- | ----------- | ------- | --- | ------- | -------- | --- |
In certain situations it may be of interest to determine dresses whether, for any given person, perceived pain is
whethertheassociationbetweenXandYisthesameatboth
|     |     |     |     |     |     |     |     | high when | anxiety | is high | (i.e., | How | do state-like | fluctua- |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ------- | ------- | ------ | --- | ------------- | -------- | --- |
levelsofthehierarchy.Thatis,itisofinteresttodetermine tions in anxiety influence pain ratings?). In contrast, the
whethertheperson-levelregressionofYonXisthesameas
|           |              |     |                |                  |        |      |      | Level 2                                              | relationship | asks | whether |     | individuals | with | high |
| --------- | ------------ | --- | -------------- | ---------------- | ------ | ---- | ---- | ---------------------------------------------------- | ------------ | ---- | ------- | --- | ----------- | ---- | ---- |
| the Level | 2 regression |     | of y(cid:1) on | x(cid:1) . These | models | have | been |                                                      |              |      |         |     |             |      |      |
|           |              |     | j              | j                |        |      |      | averageanxietyscoresalsohavehighpainratings(i.e.,How |              |      |         |     |             |      |      |
referred to as contextual, or compositional, models in the is trait-like variation in anxiety related to perceived pain?).
| MLM literature, |     | and are | frequently |     | of interest | in education |     |               |     |         |                 |     |      |                 |     |
| --------------- | --- | ------- | ---------- | --- | ----------- | ------------ | --- | ------------- | --- | ------- | --------------- | --- | ---- | --------------- | --- |
|                 |     |         |            |     |             |              |     | The preceding |     | example | is inconsistent |     | with | the traditional |     |
andsociology(Blalock,1984;Raudenbush,1989b;Rauden- definitionofacontextualmodel,butitisimportanttopoint
| bush & | Bryk, 2002). |     | Per the | occupational |     | stress | example, |          |            |           |     |         |         |               |     |
| ------ | ------------ | --- | ------- | ------------ | --- | ------ | -------- | -------- | ---------- | --------- | --- | ------- | ------- | ------------- | --- |
|        |              |     |         |              |     |        |          | out that | the models | described |     | in this | section | have applica- |     |
the differential impact of a predictor at two levels can be tions in psychology. We now return to the occupational
seen graphically in the top panel of Figure 3, in which the stress example for the remainder of this section.
organization-level effect of workload is much stronger, or Insituationsinwhichitisofinteresttodeterminewhether
has a steeper slope, than the corresponding person-level the association between X and Y is the same at both levels
effect;thedottedregressionlinerepresentsthepooledwith- of the hierarchy, it is necessary to decompose the predictor
in-cluster regression of well-being on work hours (i.e., the into a within- and a between-level component. This is
person-leveleffect)andthesolidlinerepresentstheregres- accomplished by using the cluster means, x(cid:1) , as a
HOURSj

|     |     |     |     |     | CENTERINGINMULTILEVELMODELS |     |     |     |     |     |     |     |     | 131 |
| --- | --- | --- | --- | --- | --------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
predictorintheLevel2interceptequation.UnderCGM,the algebraic relationship appears to be inconsistent with the
combined model equation becomes earlierconclusionthatCGMyieldsabiasedestimateofthe
Level1regression.However,addingtheclustermeansasa
|     |     | (cid:1)(cid:4) (cid:2)(cid:4) | (cid:2)x(cid:1) | (cid:3) |     |     |     |     |     |     |     |     |     |     |
| --- | --- | ----------------------------- | --------------- | ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
WELLBEING predictor in Equation 9 serves to partial out the Level 2
|     | ij  | 00  | 01 HOURSj |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | --------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
(cid:2)(cid:4) (cid:2)HOURS (cid:3)(cid:2)(cid:11)residuals], (9) influence of workload, resulting in an unbiased estimate of
|         |               |     | 10    | cgm |     |     |                  |     |         |            |     |          |     |       |
| ------- | ------------- | --- | ----- | --- | --- | --- | ---------------- | --- | ------- | ---------- | --- | -------- | --- | ----- |
|         |               |     |       |     |     |     | the relationship |     | between | individual |     | workload | and | well- |
| and the | corresponding | CWC | model | is  |     |     | being.           |     |         |            |     |          |     |       |
Finally,Kreftetal.(1995)notedthattheCGMandCWC
|           |     | (cid:1)(cid:4) (cid:2)(cid:4) | (cid:2)x(cid:1) | (cid:3) |     |     |     |     |     |     |     |     |     |              |
| --------- | --- | ----------------------------- | --------------- | ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------ |
| WELLBEING |     |                               |                 |         |     |     |     |     |     |     |     |     |     | (cid:4) cg m |
ij 00 01 HOURSj intercepts can be algebraically equated such that
0 0
(cid:2)(cid:4) (cid:2)HOURS (cid:3)(cid:2)(cid:11)residuals]. (10) (cid:9)(cid:4) cg mx(cid:1) (cid:7)(cid:4) cw c.ItisworthnotingthattheCGMandCWC
|     |     |     | 10  | cwc |     |     | 1 0 | 0 0 |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
regressioncoefficientsinEquations9and10areequivalent
Equations 9 and 10 are interesting because they represent regardlessofhowonechoosestomodeltherandomeffects.
oneofthefewsituationsinwhichCGMandCWCproduce However, CGM and CWC variance components are only
equivalentparameterestimates(Kreftetal.,1995),soeither
equivalentwhentheintercepts,butnottheslopes,randomly
formofcenteringisappropriate.Inthiscontext,equivalence vary across clusters. The equivalence of contextual model
| means that | the | parameter | estimates | from | CGM | can be |     |     |     |     |     |     |     |     |
| ---------- | --- | --------- | --------- | ---- | --- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
parameterswasexploredindetailbyKreftetal.(1995),so
algebraically equated with those of CWC, even though the readers who are interested in a more rigorous treatment of
| actual values | of   | the two  | sets of | coefficients | differ. |              |            |                |     |            |       |         | work.3 |     |
| ------------- | ---- | -------- | ------- | ------------ | ------- | ------------ | ---------- | -------------- | --- | ---------- | ----- | ------- | ------ | --- |
|               |      |          |         |              |         |              | this topic | are encouraged |     | to consult | their | earlier |        |     |
| The fact      | that | both CGM | and     | CWC can      | be      | used to test |            |                |     |            |       |         |        |     |
Thesecondsetofillustrativeanalysesinvolvedthemod-
whetheradifferentialassociationexistsbetweenXandYat elsfromEquations9and10,andusedtheartificialdataset
| Level 1 | and Level | 2 stems | from | the following |     | algebraic                    |           |        |          |          |     |           |           |     |
| ------- | --------- | ------- | ---- | ------------- | --- | ---------------------------- | --------- | ------ | -------- | -------- | --- | --------- | --------- | --- |
|         |           |         |      |               |     |                              | described | in the | previous | example. |     | Parameter | estimates |     |
|         |           |         |      |               |     | (cid:4)cgm(cid:7) (cid:4)cwc |           |        |          |          |     |           |           |     |
relationship given by Kreft et al. (1995): from these analyses are given in Table 3.
|     |     |     |     |     |     | 01 01 |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
(cid:9)(cid:4)cwc.Theequivalenceoftheseparameterscanbeunder-
| 10  |     |     |     |     |     |     | WehavepreviouslyshownthatbothCGMandCWCcan |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ----------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
stoodbyexaminingtheregressioncoefficientsinEquations
|     |     |     |     |     |     |     | be used | to test | whether | a differential |     | association |     | exists |
| --- | --- | --- | --- | --- | --- | --- | ------- | ------- | ------- | -------------- | --- | ----------- | --- | ------ |
9 and 10. Level 1 predictors that are centered at the group betweenXandYatLevel1andatLevel2.UnderCWC,(cid:4)
| mean are | uncorrelated | with | Level | 2 variables, |     | so the CWC |     |     |     |     |     |     |     | 10  |
| -------- | ------------ | ---- | ----- | ------------ | --- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
and(cid:4) quantifytheindependentassociationbetweenwork-
01
| model in | Equation | 10 is | comprised | of two | orthogonal | pre- |     |     |     |     |     |     |     |     |
| -------- | -------- | ----- | --------- | ------ | ---------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
loadandwell-beingatLevel1andLevel2,respectively,so
| dictors, | and (cid:4) | and (cid:4) | quantify | the independent |     | associa- |     |     |     |     |     |     |     |     |
| -------- | ----------- | ----------- | -------- | --------------- | --- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
10 01 the primary focus of this analysis involves testing whether
tionbetweenworkloadandwell-beingatLevel1andLevel
(cid:4) (cid:7)(cid:4) .AsshowninTable3,thedifferencebetween(cid:4)
|     |     |     |     |     |     |     | 10  | 0 1 |     |     |     |     |     | 1 0 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
2,respectively.Inordertodeterminewhetheradifferential d(cid:4) asapproximately(cid:9).314,andacustomhypothes
|             |        |         |       |          |     |               | an             | w    |                 |     |     |               |     | is        |
| ----------- | ------ | ------- | ----- | -------- | --- | ------------- | -------------- | ---- | --------------- | --- | --- | ------------- | --- | --------- |
| association | exists | between | X and | Y at the | two | levels of the | 01             |      |                 |     |     |               |     |           |
|             |        |         |       |          |     |               | test indicated | that | this difference |     | was | statistically |     | different |
hierarchy (i.e., a contextual effect exists), it is necessary to (cid:7) (cid:9)7.39, (cid:12) (cid:4)
|     |     |     |     |     |     |     | from zero | (t  |     | p   | .01). Under |     | CGM, | the |
| --- | --- | --- | --- | --- | --- | --- | --------- | --- | --- | --- | ----------- | --- | ---- | --- |
test whether the two coefficients are statistically different 01
|     |     |     |     |     |     |     | regression | coefficient | quantifies |     | the additional |     | explanatory |     |
| --- | --- | --- | --- | --- | --- | --- | ---------- | ----------- | ---------- | --- | -------------- | --- | ----------- | --- |
fromoneanother.Incontrast,thepredictorvariablesinthe
|               |       |                               |          |       |        |            | power of | the cluster | means, |     | controlling | for   | influence | of  |
| ------------- | ----- | ----------------------------- | -------- | ----- | ------ | ---------- | -------- | ----------- | ------ | --- | ----------- | ----- | --------- | --- |
| CGM model     | shown | in                            | Equation | 9 are | highly | correlated |          |             |        |     |             |       |           |     |
|               |       |                               |          |       |        |            | workload | at Level    | 1, so  | the | primary     | focus | of the    | CGM |
| (becauseHOURS |       | is,inpart,comprisedofx(cid:1) |          |       |        | ),sothe    |          |             |        |     |             |       |           |     |
cgm HOURSj analysis involves testing whether (cid:4) differs from zero; as
(cid:4)coefficientsarepartialregressionslopesthatquantifythe 01
|                                                       |     |     |     |     |     |     |          |       | (cid:4) |             |     | (cid:9).315, |     |         |
| ----------------------------------------------------- | --- | --- | --- | --- | --- | --- | -------- | ----- | ------- | ----------- | --- | ------------ | --- | ------- |
|                                                       |     |     |     |     |     |     | shown in | Table | 3, the  | coefficient |     | was          |     | and was |
| effectofworkloadatonelevel,controllingfortheinfluence |     |     |     |     |     |     |          |       |         | 01          |     |              |     |         |
statisticallysignificant.NoticethattheCGMestimateof(cid:4)
| ofworkloadattheotherlevel.Inthissituation,adifferential |     |     |     |     |     |     |            |           |     |                |     |         |         | 01      |
| ------------------------------------------------------- | --- | --- | --- | --- | --- | --- | ---------- | --------- | --- | -------------- | --- | ------- | ------- | ------- |
|                                                         |     |     |     |     |     |     |            |           |     |                |     |         | (cid:4) | (cid:4) |
|                                                         |     |     |     |     |     |     | was nearly | identical | to  | the difference |     | between |         | and     |
relationship between X and Y at the two levels would be 10 01
|         |        |               |     |                |      |          | under CWC  | and   | follows | from      | the fact | that   | the CGM        | and |
| ------- | ------ | ------------- | --- | -------------- | ---- | -------- | ---------- | ----- | ------- | --------- | -------- | ------ | -------------- | --- |
| evident | if the | cluster means |     | are associated | with | Y, after |            |       |         |           |          |        |                |     |
|         |        |               |     |                |      |          | CWC models | shown | in      | Equations | 9        | and 10 | are equivalent |     |
controllingfortheeffectofXatLevel1.Saiddifferently,if
|               |     |                    |     |         |       |            | (Kreft et | al., 1995). |     |     |     |     |     |     |
| ------------- | --- | ------------------ | --- | ------- | ----- | ---------- | --------- | ----------- | --- | --- | --- | --- | --- | --- |
| the magnitude |     | of the association |     | between | X and | Y is iden- |           |             |     |     |     |     |     |     |
ticalatbothlevels,thentheclustermeanswouldprovideno Two additional points should be made about the param-
(cid:4) eter estimates in Table 3. First, notice that both models
| additional | explanatory |     | power, | and | would | equal zero. |          |          |          |     |        |       |               |     |
| ---------- | ----------- | --- | ------ | --- | ----- | ----------- | -------- | -------- | -------- | --- | ------ | ----- | ------------- | --- |
|            |             |     |        | 01  |       |             | produced | the same | estimate |     | of the | Level | 1 association |     |
Mostmultilevelsoftwarepackagesallowtheusertospecify
betweenworkloadandwell-being—thisfollowsfromKreft
| custom  | contrasts, | so testing   |     | the difference |                    | between the |                |     |       |             |     |               |     |        |
| ------- | ---------- | ------------ | --- | -------------- | ------------------ | ----------- | -------------- | --- | ----- | ----------- | --- | ------------- | --- | ------ |
|         |            |              |     |                |                    |             | et al. (1995). | As  | noted | previously, |     | the inclusion |     | of the |
| Level 1 | and Level  | 2 regression |     | slopes         | is straightforward |             |                |     |       |             |     |               |     |        |
under CWC. Nevertheless, the use of CGM is arguably cluster means in the CGM model serves to partial out the
easierinthiscontext,giventhattheuserneedonlyexamine
| the significance |     | test for | (cid:4) . |     |     |     |     |     |     |     |     |     |     |     |
| ---------------- | --- | -------- | --------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
01 3Because of a lack of precision in the estimation process, the
Kreft et al. (1995) also illustrated that CGM and CWC algebraic identities outlined by Kreft et al. (1995) may not hold
yieldidenticalestimatesoftheLevel1associationbetween exactlywhensubstitutingtheestimatedparametervaluesintothe
| X and | Y, such | that (cid:4)cgm | (cid:1) | (cid:4)cwc. At | first | glance, this |                                 |     |     |     |     |     |     |     |
| ----- | ------- | --------------- | ------- | -------------- | ----- | ------------ | ------------------------------- | --- | --- | --- | --- | --- | --- | --- |
|       |         |                 | 10      | 10             |       |              | equationsoutlinedinthissection. |     |     |     |     |     |     |     |

132 ENDERSANDTOFIGHI
Table3
ParameterEstimates(PEs)FromExampleAnalysis2
CGM CWC
Model PE SE t PE SE t
WELLBEING (cid:7)(cid:4) (cid:8)(cid:4) (x(cid:1) )(cid:8)(cid:4) (HOURS ) (cid:4) 60.064 .332 180.77 60.074 .320 187.90
(cid:8)u (cid:8)u
ij
(HOU
0
R
0
S )(cid:8)
01
r
HOURSj 10 ij
(cid:4)
00
(cid:9).315 .043 (cid:9)7.30 (cid:9).608 .040 (cid:9)15.04
0j 1j ij ij 01
(cid:4) (cid:9).294 .013 (cid:9)23.44 (cid:9).294 .013 (cid:9)22.99
10
(cid:5) 31.475 2.701 11.65 29.552 2.504 75.52
00
(cid:5) .024 .004 6.21 .025 .004 6.34
11
(cid:5) (cid:9).584 .080 (cid:9)7.28 (cid:9).595 .079 (cid:9)7.58
10
(cid:6)2 44.465 .589 75.55 44.464 .589 75.52
Note. Allsignificancetestsweresignificantatp(cid:12).01.SignificancetestsforvariancecomponentsareWaldztests.Allresidualtermsweregenerated
tohaveanormaldistribution.Asaresultofroundingerrorinthetabledvalues,someteststatisticsdonotequaltheestimatedividedbythestandarderror.
CGM(cid:7)centeringatthegrandmean;CWC(cid:7)centeringwithincluster;WELLBEING(cid:7)psychologicalwell-being;HOURS(cid:7)workloadmeasuredinhours
perweek.
between-clustervariationinworkload,resultinginanunbi- Again, the collection of residual terms from Equation 4 is
ased estimate of the Level 1 regression slope. Finally, note representedbyasingleterminbrackets.The(cid:4) regression
11
thattheCGMandCWCestimatesoftheinterceptvariance coefficientisofparticularinterestinthiscontextbecauseit
((cid:5) )werequitesimilarinthesetwomodels.Recallfroman quantifies the moderating influence that the group size has
00
earlier discussion that the CGM estimate of (cid:5) quantifies onmagnitudeoftheLevel1associationbetweenworkload
00
variation in the well-being means after adjusting for mean and well-being.
differencesinworkload.Theadditionofx(cid:1) totheCWC The impact of centering on cross-level interactions was
HOURSj
model effectively removed the between-cluster variation in raisedinaclassicarticlebyCronbachandWebb(1975)that
well-being that was attributable to workload, so the CGM reexaminedanAptitude(cid:13)Treatmentinteraction(ATI)ina
andCWCestimatesof(cid:5) 00 nowhavethesameinterpretation. studyofmathematicsachievement.Apreviousanalysishad
incorrectly concluded that an ATI was present, when this
An Interaction Effect Is of Substantive Interest
effect was actually due to an interaction at the classroom
level (i.e., Level 2). Specifically, the association between
Given the important role that centering plays in OLS
regression models with interaction terms (Aiken & West, the aptitude and achievement means differed for treatment
1991),thisissuehasreceivedsurprisinglylittleattentionin and control classrooms, but a failure to separate out the
the MLM literature—popular MLM textbooks are virtually within-level (i.e., individual) and between-level (i.e., class-
devoid of the topic. Hofmann and Gavin (1998) under- room) relationship between X and Y led to the incorrect
scored the importance of this issue, stating that “When conclusion concerning the ATI. Cronbach and Webb hy-
moving to models that include cross-level interactions, the pothesized that a true ATI would be evidenced by a cross-
differences between grand mean and group mean centering level interaction, such that the within-class (i.e., Level 1)
become even more critical” (p. 631). relationship between aptitude and achievement would be
MLManalysesallowfortheestimationofwithin-leveland attenuated by participation in the treatment (i.e., a Level 2
cross-level interactions. We focus primarily on cross-level variable).However,appropriatelydisentanglingthewithin-
interactions in this section, briefly addressing within-level in- and between-cluster relationship revealed no such effect.
teractions as well. A cross-level interaction occurs when a Hofmann and Gavin (1998) noted a problem similar to
Level 2 variable moderates the magnitude of a Level 1 rela- thatofCronbachandWebb(1975)andusedartificialdatato
tionship. Returning to the occupational stress example, sup- demonstratethatCGMcanproduceasignificantcross-level
posethatgroupsize(anorganization-levelvariable)moderated interaction effect, when no such effect exists in the popu-
therelationshipbetweenworkloadandwell-being(theperson- lation. Again, the problem with CGM stems from the fact
level regression), such that the association between workload that HOURS is a composite of within- and between-
cgm
andwell-beingwasweakerinsmallworkgroups.Across-level cluster variation.Thisideamakesitpossibletoexpressthe
interactioneffectismodeledbyaddingaLevel2covariateto cross-level interaction using the following formula:
the slope formula shown in Equation 3. Under CGM, the (cid:4) (cid:2)SIZE(cid:3)(cid:2)HOURS (cid:2) HOURS (cid:3). With some ad-
11 j within between
combinedmodelregressionequationisasfollows: ditional algebra, the formula becomes (cid:4) (SIZE) (cid:13)
11 j
(HOURS ) (cid:8) (cid:4) (SIZE)(HOURS ). The previous
WELLBEING (cid:1)(cid:4) (cid:2)(cid:4) (cid:2)SIZE(cid:3)(cid:2)(cid:4) (cid:2)HOURS (cid:3) within 11 j between
ij 00 01 j 10 cgm expression illustrates the important point that (cid:4) is poten-
11
(cid:2)(cid:4) (cid:2)SIZE(cid:3)(cid:2)HOURS (cid:3)(cid:2)(cid:11)residuals] (11) tially influenced by two qualitatively different interaction
11 j cgm

|     |     |     |     |     | CENTERINGINMULTILEVELMODELS |     |     |     |     |     |     | 133 |
| --- | --- | --- | --- | --- | --------------------------- | --- | --- | --- | --- | --- | --- | --- |
effects: the interaction between SIZE and the Level 1 vari- means that the parameters in the CGM model can be alge-
ation in workload scores and the Level 2 interaction be- braicallyequatedtothoseintheCWCmodel.Intheinterest
tween SIZE and the workload means. As such, the CGM of space, the analytic details related to model equivalence
estimate of (cid:4) suffers from the same problem that was are given in Appendix A, and we instead focus on the
11
encountered when estimating the person-level association substantive interpretation of the interaction coefficients un-
between X and Y, namely that it is an uninterpretable mix- der CGM and CWC. The interpretation of Equation 12
ture of two different influences on the outcome. relies on two previously established points: CGM yields
Now reconsider the previous conceptual formula after Level 1 scores that are correlated with both Level 1 and
substitutingHOURS inplaceofHOURS .Groupmean Level2variables,whereasCWCyieldsLevel1scoresthat
|     |     | cwc |     |     | cgm |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
centeringremovesallbetween-clustervariationinX,sothe areorthogonaltoallLevel2variables.BecauseHOURS
cwc
formulasimplifiesto(cid:4) (cid:2)SIZE(cid:3)(cid:2)HOURS (cid:3).Ataconcep- and x(cid:1) are orthogonal, it follows that the (cid:4) and (cid:4)
|             |     | 11       | j             | within |                   |     | HOURSj       |             |             |           |     | 11 03         |
| ----------- | --- | -------- | ------------- | ------ | ----------------- | --- | ------------ | ----------- | ----------- | --------- | --- | ------------- |
| tual level, | CWC | yields a | pure estimate |        | of the moderating |     |              |             |             |           |     |               |
|             |     |          |               |        |                   |     | coefficients | reflect the | independent | influence |     | of the cross- |
influence that a Level 2 predictor exerts on the Level 1 level interaction and the interaction involving SIZE and
associationbetweenXandYandcannotbedistortedbythe the workload cluster means, respectively. In contrast,
|     |     |     |     |     |     |     |     | x(cid:1) |     |     | (cid:4) |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | --- | --- | ------- | --- |
presenceofaninteractionthatinvolvestheclustermeansof HOURS and are correlated, so is interpreted
|     |     |     |     |     |     |     | cgm | HOURSj |     |     | 03  |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------ | --- | --- | --- | --- |
X. It is for this reason that Hofmann and Gavin (1998) and as the unique influence of the interaction involving SIZE
| Raudenbush | (1989a, | 1989b) | recommended |     | using | CWC |                 |        |       |            |      |               |
| ---------- | ------- | ------ | ----------- | --- | ----- | --- | --------------- | ------ | ----- | ---------- | ---- | ------------- |
|            |         |        |             |     |       |     | and the cluster | means, | above | and beyond | that | of the cross- |
when cross-level interactions are of substantive interest. level interaction (i.e., the effect of the Level 2 interaction,
The potential confounding that occurs under CGM also having partialled out the cross-level interaction). Because
impliesthatCWCisappropriatewhenthesubstantivefocus theCGMinteractioneffectsareinterpretedaspartialregres-
involvesaninteractionbetweenapairofLevel1variables. sion coefficients, it also follows that (cid:4) is a pure estimate
11
| At a conceptual |     | level, a | cross-level | interaction |     | and an in- |                    |              |     |           |        |            |
| --------------- | --- | -------- | ----------- | ----------- | --- | ---------- | ------------------ | ------------ | --- | --------- | ------ | ---------- |
|                 |     |          |             |             |     |            | of the cross-level | interaction, |     | and is no | longer | confounded |
teraction involving a pair of Level 1 variables both require with the Level 2 interaction, because it has been appropri-
an accurate estimate of the Level 1 slope because this ately partialled out. In fact, the analytic details given in
coefficient is being moderated by another predictor. The Appendix A demonstrate that CGM and CWC yield iden-
need for an unbiased estimate of the Level 1 association tical estimates of the cross-level interaction in this case.
| makes CWC | a natural | choice | for | examining | these | types of |               |         |         |             |     |                  |
| --------- | --------- | ------ | --- | --------- | ----- | -------- | ------------- | ------- | ------- | ----------- | --- | ---------------- |
|           |           |        |     |           |       |          | It is unclear | whether | the two | interaction |     | effects actually |
interaction effects. occur simultaneously in practice, but the model outlined in
Although the model in Equation 11 does lead to the Equation12allowsonetoappropriatelydisentanglethetwo
possibilityofaspuriouscross-levelinteractioneffect(Hof- effects by using either CGM or CWC. The model in Equa-
mann&Gavin,1998),itendsupthatbothCGMandCWC tion 12 is also interesting because it is a second case in
canbeusedtoappropriatelydistinguishacross-levelinter-
|     |     |     |     |     |     |     | which CGM | and CWC | yield | equivalent | regression | coeffi- |
| --- | --- | --- | --- | --- | --- | --- | --------- | ------- | ----- | ---------- | ---------- | ------- |
action from an interaction involving the Level 2 moderator cients; CGM and CWC also yield equivalent estimates of
andtheclustermeans(i.e.,thetwointeractiontermsthatare the contextual model parameters in Equations 9 and 10
confounded in Equation 11). Returning to the occupational (Kreftetal.,1995).TheequivalenceofCGMandCWChas
stressexample,weconsiderthefollowingcombinedmodel not been widely studied, so it is unclear whether more
equation:
|     |     |     |     |     |     |     | general conditions | of equivalence |     | can | be established. |     |
| --- | --- | --- | --- | --- | --- | --- | ------------------ | -------------- | --- | --- | --------------- | --- |
Toillustratetheeffectofcenteringoninteractioneffects,
Y (cid:1)(cid:4) (cid:2)(cid:4) (cid:2)x(cid:1) (cid:3)(cid:2)(cid:4) (cid:2)SIZE(cid:3)(cid:2)(cid:4) (cid:2)x(cid:1) (cid:3)(cid:2)SIZE(cid:3) weagaingeneratedanartificialdatasetwith300clustersof
| ij 00 | 01  | HOURSj | 02  | j   | 03 HOURSj | j   |          |                |      |           |      |               |
| ----- | --- | ------ | --- | --- | --------- | --- | -------- | -------------- | ---- | --------- | ---- | ------------- |
|       |     |        |     |     |           |     | 40 cases | each. The data | were | generated | such | that the out- |
(cid:2)(cid:4) (cid:2)HOURS (cid:3)(cid:2)(cid:4) (cid:2)HOURS (cid:3)(cid:2)SIZE(cid:3)(cid:2)(cid:11)residuals(cid:14). (cid:2)12(cid:3) come variable scores were a function of the Level 2 inter-
| 10  | ij  | 11  | ij  | j   |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
actioninvolvingSIZEandx(cid:1)
,andallothertermsinthe
HOURSj
The model outlined above includes a main effect for the model were set to zero.
Level 1 predictor (i.e., (cid:4) ), main effects for the Level 2 Webeganbyestimatingastandardcross-levelinteraction
10
predictorandtheclustermeansoftheLevel1predictor(i.e., model such as that given in Equation 11. As seen in Table
(cid:4) and (cid:4) , respectively), a cross-level interaction (i.e., 4,CGMproducedasignificantcross-levelinteraction,even
| 02  | 01  |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
(cid:4)
),andaninteractioninvolvingtheLevel2predictorand though no such effect existed in the data. This finding is
11
theclustermeans(i.e.,(cid:4) ).ThenotationinEquation12is similar to that reported by Hofmann and Gavin (1998) and
03
somewhatgenericbecauseeitherHOURS orHOURS demonstrates the pitfalls associated with using CGM to
|     |     |     |     |     | cgm | cwc |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
canbeusedinplaceofHOURS .Thecollectionofresidual investigatecross-levelinteractioneffects.Incontrast,CWC
ij
terms in the bracket is identical to that in Equation 4. appropriately disentangled the two interaction effects and
It is interesting to note that the model in Equation 12 produced a nonsignificant cross-level interaction.
represents another special case in which CGM and CWC TheinteractionmodelproposedinEquation12wasused
yieldequivalentparameterestimates;asbefore,equivalence for the second analysis and was estimated by using both

| 134 |     |     |     |     | ENDERSANDTOFIGHI |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | ---------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Table4
ParameterEstimates(PEs)FromExampleAnalysis3
|     |     |     |       |     |     |     |     |     | CGM |     |     |     | CWC |     |
| --- | --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|     |     |     | Model |     |     |     |     | PE  | SE  | t   |     | PE  | SE  | t   |
WELLBEING (cid:7)(cid:4) (cid:8)(cid:4) (SIZE)(cid:8)(cid:4) (HOURS )(cid:8) (cid:4) 147.34 143.12
|     | ij  | 00  | 01 j | 10  | ij  |     | 00  | 59.394 | 0.403 |     | 59.389 |     | 0.415 |     |
| --- | --- | --- | ---- | --- | --- | --- | --- | ------ | ----- | --- | ------ | --- | ----- | --- |
(cid:4) )(SIZE)(cid:8)u (cid:8)u )(cid:8)r (cid:4) (cid:9)0.028 (cid:9)0.70 (cid:9)0.022
| (HOURS |     |     |       | (HOURS |       |         |     |       | 0.040 |      |       |     | 0.041 | 0.55 |
| ------ | --- | --- | ----- | ------ | ----- | ------- | --- | ----- | ----- | ---- | ----- | --- | ----- | ---- |
| 11     | ij  | j   | 0j 1j |        | ij ij |         | 01  |       |       |      |       |     |       |      |
|        |     |     |       |        |       | (cid:4) |     | 0.013 | 0.010 | 1.25 | 0.012 |     | 0.010 | 1.17 |
10
|     |     |     |     |     |     | (cid:4) |     | 0.003 | 0.001 | 3.02 | 0.001 |     | 0.001 | 0.97 |
| --- | --- | --- | --- | --- | --- | ------- | --- | ----- | ----- | ---- | ----- | --- | ----- | ---- |
11
|     |     |     |     |     |     | (cid:5) |     | 48.818 | 0.647 | 75.51 | 50.433 |     | 4.217 | 11.96 |
| --- | --- | --- | --- | --- | --- | ------- | --- | ------ | ----- | ----- | ------ | --- | ----- | ----- |
00
|     |     |     |     |     |     | (cid:5) |     |       |       | 2.61 |       |     |       | 2.56 |
| --- | --- | --- | --- | --- | --- | ------- | --- | ----- | ----- | ---- | ----- | --- | ----- | ---- |
|     |     |     |     |     |     |         | 11  | 0.007 | 0.003 |      | 0.007 |     | 0.003 |      |
(cid:5)
|     |     |     |     |     |     |     |     | 0.094 | 0.071 | 1.33 | 0.052 |     | 0.075 | 0.69 |
| --- | --- | --- | --- | --- | --- | --- | --- | ----- | ----- | ---- | ----- | --- | ----- | ---- |
10
|     |     |     |     |     |     | (cid:6)2 |     | 48.818 | 0.647 | 75.51 | 48.788 |     | 0.646 | 75.50 |
| --- | --- | --- | --- | --- | --- | -------- | --- | ------ | ----- | ----- | ------ | --- | ----- | ----- |
WELLBEING (cid:7)(cid:4) (cid:8)(cid:4) (x(cid:1) )(cid:8)(cid:4) (SIZE) (cid:4) 59.967 0.274 218.76 59.976 0.274 219.12
|     | ij  | 0 0 | 01 HO UR | S   | 02 j |     | 00  |     |     |     |     |     |     |     |
| --- | --- | --- | -------- | --- | ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
(cid:8)(cid:4) (x(cid:1) )(S I ZE)(cid:8) (cid:4) (H O U j RS ) (cid:4) 0.037 0.039 0.96 0.049 0.038 1.31
| 03  | H O UR | S j | 1 0 | ij  |     |     | 01  |     |     |     |     |     |     |     |
| --- | ------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
(cid:8)(cid:4) (H O U R S j )(SIZE )(cid:8) u (cid:8)u (H OURS )(cid:8)r (cid:4) (cid:9)0.022 (cid:9)0.81 (cid:9)0.023 (cid:9)0.84
| 11  |     | ij  | j 0j | 1j  | ij ij |     | 02  |     | 0.027 |     |     |     | 0.027 |     |
| --- | --- | --- | ---- | --- | ----- | --- | --- | --- | ----- | --- | --- | --- | ----- | --- |
(cid:4)
|     |     |     |     |     |     |     |     | 0.069 | 0.004 | 18.89 | 0.070 |     | 0.003 | 19.99 |
| --- | --- | --- | --- | --- | --- | --- | --- | ----- | ----- | ----- | ----- | --- | ----- | ----- |
03
|     |     |     |     |     |     | (cid:4) |     | 0.012 | 0.010 | 1.19 | 0.012 |     | 0.010 | 1.18 |
| --- | --- | --- | --- | --- | --- | ------- | --- | ----- | ----- | ---- | ----- | --- | ----- | ---- |
10
|     |     |     |     |     |     | (cid:4) |     | 0.001 | 0.001 | 0.98 | 0.001 |     | 0.001 | 0.97 |
| --- | --- | --- | --- | --- | --- | ------- | --- | ----- | ----- | ---- | ----- | --- | ----- | ---- |
11
|     |     |     |     |     |     | (cid:5) |     | 20.834 | 1.818 | 11.46 | 20.996 |     | 1.814 | 11.57 |
| --- | --- | --- | --- | --- | --- | ------- | --- | ------ | ----- | ----- | ------ | --- | ----- | ----- |
00
|     |     |     |     |     |     | (cid:5) |     |       |       | 2.16 |       |     |       | 2.55 |
| --- | --- | --- | --- | --- | --- | ------- | --- | ----- | ----- | ---- | ----- | --- | ----- | ---- |
|     |     |     |     |     |     |         | 11  | 0.005 | 0.002 |      | 0.007 |     | 0.003 |      |
(cid:5)
|     |     |     |     |     |     |     |     | 0.093 | 0.047 | 1.99 | 0.072 |     | 0.049 | 1.45 |
| --- | --- | --- | --- | --- | --- | --- | --- | ----- | ----- | ---- | ----- | --- | ----- | ---- |
10
|     |     |     |     |     |     | (cid:6)2 |     | 48.859 | 0.647 | 75.48 | 48.790 |     | 0.646 | 75.50 |
| --- | --- | --- | --- | --- | --- | -------- | --- | ------ | ----- | ----- | ------ | --- | ----- | ----- |
(cid:12)
Note. Bold typeface denotes statistical significance at p .05. Significance tests for variance components are Wald z tests. All residual terms were
generatedtohaveanormaldistribution.Asaresultofroundingerrorinthetabledvalues,someteststatisticsdonotequaltheestimatedividedbythe
standarderror.CGM(cid:7)centeringatthegrandmean;CWC(cid:7)centeringwithincluster;WELLBEING(cid:7)psychologicalwell-being;SIZE(cid:7)workgroupsize;
HOURS(cid:7)workloadmeasuredinhoursperweek.
CGMandCWC.Mostimportant,thetwointeractioneffects First,consideraLevel1dummyvariable(i.e.,x (cid:7)0,1)
ij
were appropriately disentangled, such that the cross-level (cid:7)
|     |     |     |     |     |     |     | with | n   | cases in the | base | group (i.e., | x   | 0) and | n cases |
| --- | --- | --- | --- | --- | --- | --- | ---- | --- | ------------ | ---- | ------------ | --- | ------ | ------- |
|     |     |     |     |     |     |     |      | 0j  |              |      |              | ij  |        | 1j      |
interaction was nonsignificant, and the Level 2 interaction in the comparison group (i.e., x (cid:7) 1). Returning to the
ij
| involvingSIZEandx(cid:1) |     |     | wasstatisticallysignificant.4As |     |     |     |     |     |     |     |     |     |     |     |
| ------------------------ | --- | --- | ------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
HOURSj occupational stress example, suppose that it was of interest
outlined in Appendix A, CGM and CWC now yield iden- to include a dummy code for gender in the Level 1 model.
tical estimates of the cross-level interaction. More gener- In this situation, the Level 1 intercept (i.e., (cid:1) ) would be
0j
ally,theparameterestimatesgiveninthebottomportionof
|     |     |     |     |     |     |     | interpreted |     | as the | male mean | in cluster | j   | (i.e., the | expected |
| --- | --- | --- | --- | --- | --- | --- | ----------- | --- | ------ | --------- | ---------- | --- | ---------- | -------- |
Table4areconsistentwiththealgebraicidentitiesgivenin value when FEMALE (cid:7) 0), and (cid:5) would quantify the
00
| Appendix | A (e.g., | (cid:4)cgm | (cid:1) (cid:4)cwc | (cid:3) (cid:4)cwc | (cid:7) .069 (cid:7) | .070– |     |     |     |     |     |     |     |     |
| -------- | -------- | ---------- | ------------------ | ------------------ | -------------------- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
03 03 11 variation in the male averages across the j clusters. Alter-
.001). Although the two sets of estimates are algebraically natively, gender could be represented as an effect code
equivalentinthissituation,webelievethattheCWCmodel (cid:7) (cid:9)1, (cid:7) (cid:1)
|                                                      |     |     |     |     |     |     | variable |     | (i.e., male |     | female | 1), | in which | case |
| ---------------------------------------------------- | --- | --- | --- | --- | --- | --- | -------- | --- | ----------- | --- | ------ | --- | -------- | ---- |
| ismoreuseful,asitleadstoamorenaturalinterpretationof |     |     |     |     |     |     |          |     |             |     |        |     |          | 0j   |
wouldbeinterpretedastheunweightedmeanofYincluster
| the two                                          | interaction | effects | (i.e.,           | the interaction | coefficients |         |          | (cid:5) |                    |     |               |       |                    |        |
| ------------------------------------------------ | ----------- | ------- | ---------------- | --------------- | ------------ | ------- | -------- | ------- | ------------------ | --- | ------------- | ----- | ------------------ | ------ |
|                                                  |             |         |                  |                 |              |         | j,       | and     | would quantify     |     | the variation | in    | the unweighted     |        |
| areindependentunderCWC,whereastheCGMcoefficients |             |         |                  |                 |              |         |          | 00      |                    |     |               |       |                    |        |
|                                                  |             |         |                  |                 |              |         | means.   |         | The interpretation |     | of the        | Level | 1 intercept        | in the |
| reflect the                                      | influence   | of      | one interaction, |                 | partialling  | out the |          |         |                    |     |               |       |                    |        |
|                                                  |             |         |                  |                 |              |         | previous |         | two examples       | is  | consistent    | with  | the interpretation |        |
other).
|     |           |        |       |     |            |     | of     | dummy | and effect | codes  | in  | OLS regression |     | (Cohen, |
| --- | --------- | ------ | ----- | --- | ---------- | --- | ------ | ----- | ---------- | ------ | --- | -------------- | --- | ------- |
|     |           |        |       |     |            |     | Cohen, | West, | & Aiken,   | 2003). |     |                |     |         |
|     | Centering | Binary | Level | 1   | Predictors |     |        |       |            |        |     |                |     |         |
Centeringadummyvariablearoundthegrandmeanfun-
damentallychangestheinterpretationoftheMLMintercept
| Having | established | some | centering | recommendations |     | for |     |      |             |      |               |      |                |     |
| ------ | ----------- | ---- | --------- | --------------- | --- | --- | --- | ---- | ----------- | ---- | ------------- | ---- | -------------- | --- |
|        |             |      |           |                 |     |     | but | does | so in a way | that | is consistent | with | the continuous |     |
continuousLevel1predictors,wenowbrieflydiscussissues
ofcenteringwithbinarypredictors(e.g.,gender).Although case. Specifically, CGM yields a Level 1 intercept that is
| it may   | seem     | unnatural | to center | nominal | predictors, | the  |     |      |                |     |                     |     |             |         |
| -------- | -------- | --------- | --------- | ------- | ----------- | ---- | --- | ---- | -------------- | --- | ------------------- | --- | ----------- | ------- |
| previous | concepts | also      | extend to | dummy   | and effect  | code |     |      |                |     |                     |     |             |         |
|          |          |           |           |         |             |      |     | 4CGM | does not yield | a   | direct significance |     | test of the | Level 2 |
variables that appear in the Level 1 model. We provide a interaction involving SIZE and x(cid:1) . Rather, the CGM coeffi-
HOURSj
nontechnical discussion of centering in this section, but a cientquantifiesthedifferencebetweentheLevel2andcross-level
moredetailedalgebraicpresentationisgiveninAppendixB.
interactions.

CENTERINGINMULTILEVELMODELS 135
interpretedastheadjustedoutcomemeanforclusterj.Inthe As a cautionary note, we encourage readers to carefully
continuous case, the outcome mean was adjusted for mean consider the impact of leaving a dummy or effect code
differencesthatexistamongclustersonthecovariateX(see variable uncentered in the Level 1 model because doing so
Equation 6). The mean of a binary dummy variable is may produce an awkward interpretation of certain model
simply the proportion of cases in the comparison group parameters. For example, suppose that Equation 5 was
(e.g., FEMALE (cid:7) 1), so the CGM intercept for cluster j is expandedtoincludeanuncentereddummycodeforgender
adjusted for differences in the proportion of comparison (i.e., male (cid:7) 0, female (cid:7) 1). Because workload was grand
group cases across clusters. That is, (cid:1) is the cluster mean meancentered,theLevel1interceptwouldbeinterpretedas
0j
that would result had the proportion of females been iden- themalemean,adjustedforclusterdifferencesinworkload.
tical across workgroups. Consistent with the continuous By extension, (cid:5) would then quantify the variation in the
00
case, (cid:5) quantifies the variation in the adjusted outcome adjustedoutcomemeansformales;hadbothvariablesbeen
00
means. It is interesting to note that applying CGM to a grand mean centered, (cid:5) would have quantified the varia-
00
binaryeffectcodevariableyieldsanidenticalinterpretation, tion in the well-being means, having partialled out both
sothechoiceofcodinghasnobearingontheinterpretation gender and workload. In summary, the use of a binary
of the intercept or on the intercept variance, provided that variable in the Level 1 equation does not change our cen-
thedataarecentered.Algebraicsupportforthisconclusion tering recommendations, so researchers should carefully
is given in Appendix B. consider the impact of centering, regardless of whether the
Applying CWC to a dummy or effect code variable also predictor variable is continuous or binary.
yields the same interpretation as it did in the continuous
case. Specifically, applying CWC to a Level 1 dummy Centering Level 2 Predictors
variable (e.g., deviating each person’s gender value around
the proportion of females in cluster j) yields a Level 1 A brief discussion of centering Level 2 predictors is
interceptthatisinterpretedastheunadjusted(i.e.,weighted) warranted before concluding. Centering at Level 2 is typi-
meanforclusterj.Infact,theCWCinterceptisinterpreted callyfarlesscomplexthanthecenteringdecisionsrequired
asanunadjustedmean,regardlessofwhetheronechoosesto at Level 1 because it is only necessary to choose between
usedummyoreffectcodingintheLevel1equation,sothe the raw metric and CGM; CWC is not an option because
choiceofcodingschemeiscompletelyarbitrary.Again,the scoresonaLevel2variableareconstantwithineachcluster.
algebraic details supporting this conclusion are given in In general, centering decisions at Level 2 can be based on
Appendix B. recommendationsfromtheOLSregressionliterature(Aiken
In summary, the interpretation of the MLM intercept is & West, 1991; Cohen et al., 2003). For example, if the
unaffectedbytheuseofdummyoreffectcodesanddepends Level 2 equation contains only first-order terms, choosing
solelyonthemethodofcenteringused.UnderCWC,(cid:1) is between the raw metric and CGM will only affect the
0j
interpretedastheunadjusted(i.e.,weighted)meanforclus- intercept ((cid:4) ). Consistent with standard practice, CGM is
00
terj,and(cid:5) quantifiesthevariationintheoutcomevariable preferredwhenhigherordertermsareaddedtotheLevel2
00
means. Under CGM, the dependent variable means are model (e.g., an interaction between a pair of Level 2 vari-
adjusted for differences in the proportion of comparison ables, or a quadratic effect in the Level 2 model). CGM
group cases (i.e., x (cid:7) 1) across clusters, so (cid:1) is inter- generally provides a convenient option for centering Level
ij 0j
preted as the adjusted mean for cluster j. As such, (cid:5) 2 variables, but it may also be useful to leave a variable in
00
quantifies the variation in the adjusted means. Again, note its raw metric (e.g., a dummy or effect coded variable).
that these interpretations are identical to the continuous
case. Summary and Conclusions
The coding scheme at Level 1 does affect the within-
cluster regression coefficient. Consistent with dummy cod- Psychological constructs are frequently expressed on ar-
inginOLSregression,(cid:1) equalsthegroupmeandifference bitrarymetricsthatlackaclearlyinterpretableormeaning-
1j
within cluster j and is equal to half the mean difference ful zerovalue,andcentering is frequentlyusedtoestablish
when effect codes are applied (see Cohen et al., 2003). It a useful zero point. However, the centering of Level 1
also follows that the slope variance estimate (i.e., (cid:5) ) will predictors in MLM analyses is complex, and confusion
11
differ across coding schemes, as will the covariance be- continues to exist over the appropriate use of CGM and
tween the intercepts and slopes (i.e., (cid:5) ). Specifically, the CWC. The purpose of this article was to explicate the vital
01
slope variance under dummy coding will be exactly four role that centering plays in defining MLM parameter esti-
times larger than the variance under effect coding. How- mates and to provide researchers with rules of thumb to
ever,thesignificancetestsforthevariancecomponentswill guide centering decisions in their own research.
be identical under dummy and effect coding, so the choice The decision to use CGM or CWC cannot be based on
of coding scheme makes very little difference. statistical evidence, but depends heavily on one’s substan-

136 ENDERSANDTOFIGHI
tive research questions. This issue is clearly complex, and thetic models of job stress: An examination of work hours,
no single model may sufficiently address an entire set of cohesion,andwell-being.JournalofAppliedSocialPsychology,
substantive research questions. In fact, it seems quite rea- 26,1171–1189.
sonabletouseCGMandCWCwithinthecontextofasingle Bliese, P. D., & Jex, S. M. (2002). Incorporating a multilevel
study. It is possible that one research question requires the perspectiveintooccupationalstressresearch:Theoretical,meth-
useofCGM,whereasadifferentquestionisbestaddressed odological,andpracticalimplications.JournalofOccupational
with CWC. Even when the substantive question calls for HealthPsychology,7,265–276.
CGM, Raudenbush and Bryk (2002) noted that CWC may Chan,D.(1998).Functionalrelationsamongconstructsinthesame
provide the most accurate estimates of the slope variance contentdomainatdifferentlevelsofanalysis.Atypologyofcom-
duetothenegativebiasthatcansometimesbepresentinthe positionalmodels.JournalofAppliedPsychology,83,234–246.
CGM estimate of this parameter. Cohen,J.,Cohen,P.,West,S.G.,&Aiken,L.S.(2003).Applied
Weproposedsomestraightforwardrulesofthumbthatwe multipleregression/correlationanalysisforthebehavioralsci-
hope will be of use to substantive researchers and method- ences(3rded.).Mahwah,NJ:Erlbaum.
ologists alike. These guidelines are as follows: (a) CWC is Cronbach, L. J., & Webb, N. (1975). Between- and within-class
appropriateiftheLevel1associationbetweenXandYisof effects in a reported aptitude-by-treatment interaction: Reanal-
substantive interest; (b) CGM is appropriate when one is ysis of a study by G. L. Anderson. Journal of Educational
primarily interested in a Level 2 predictor and wants to Psychology,67,717–724.
controlforLevel1covariates;(c)eitherCGMorCWCcan Davis,J.A.(1966).Thecampusasafrogpond:Anapplicationof
beusedtoexaminethedifferentialinfluenceofavariableat thetheoryofrelativedeprivationtocareerdecisionsofcollege
Level 1 and Level 2; and (d) CWC is preferable for exam- men.AmericanJournalofSociology,72,17–31.
iningcross-levelinteractionsandinteractionsthatinvolvea Firebaugh, G. (1978). A rule for inferring individual-level rela-
pair of Level 1 variables, and CGM is appropriate for tionships from aggregate data. American Sociological Review,
interactions between Level 2 variables. 43,557–572.
The thoughtless application of such guidelines is always Griffin, M. A. (2001). Dispositions and work reactions: A
problematic, and we encourage readers to use our sugges- multilevel approach. Journal of Applied Psychology, 86,
tions as a springboard for examining the linkage between 1142–1151.
theirsubstantiveresearchquestionsandtheformofcenter- Hofmann, D. A., & Gavin, M. B. (1998). Centering decisions in
ing that will best address those questions. In addition, we hierarchical linear models: Implications for research in organi-
stronglyrecommendthatcenteringdecisionsarereportedin zations.JournalofManagement,24,623–641.
published articles and that authors provide a brief rationale Kallestad,J.H.,&Olweus,D.(2003,October1).Predictingteachers’
for their analytic choices. and schools’ implementation of the Olweus Bullying Prevention
Program:Amultilevelstudy.PreventionandTreatment,6.
References Kreft,I.(1995).Theeffectsofcenteringinmultilevelanalysis:Is
thepublicschooltheloserorthewinner?Anewanalysisofan
Aiken, L. S., & West, S. G. (1991). Multiple regression: Testing oldquestion.MultilevelModellingNewsletter,7(3),5–8.
andinterpretinginteractions.NewburyPark,CA:Sage. Kreft,I.G.G.,deLeeuw,J.,&Aiken,L.S.(1995).Theeffectof
Balsam, K. F., Beauchaine, T. P., Mickey, R. M., & Rothblum, differentformsofcenteringinhierarchicallinearmodels.Mul-
E. D. (2005). Mental health of lesbian, gay, bisexual, and tivariateBehavioralResearch,30,1–21.
heterosexualsiblings:Effectsofgender,sexualorientation,and Longford, N. (1989a). Contextual effects and group means. Mul-
family.JournalofAbnormalPsychology,114,471–476. tilevelModellingNewsletter,1(3),5,11.
Biesanz,J.C.,Deeb-Sossa,N.,Aubrecht,A.M.,Bollen,K.A.,& Longford, N. (1989b). To center or not to center. Multilevel
Curran,P.J.(2004).Theroleofcodingtimeinestimatingand ModellingNewsletter,1(3),7,11.
interpreting growth curve models. Psychological Methods, 9, Marsh,H.W.,&Hau,K.-T.(1987).Big-fish-little-pondeffecton
30–52. academicselfconcept.JournalofEducationalPsychology,79,
Blalock, H. M. (1984). Contextual-effects models: Theoretical and 280–295.
methodologicalissues.AnnualReviewofSociology,10,353–372. Marsh,H.W.,&Hau,K.-T.(2003).Big-fish-little-pondeffecton
Blanton,H.,&Jaccard,J.(2006).Arbitrarymetricsinpsychology. academicselfconcept.AmericanPsychologist,58,364–376.
AmericanPsychologist,61,27–41. Montague,M.,Enders,C.,Dietz,S.,Morrison,W.,&Dixon,J.(in
Bliese,P.D.(2000).Within-groupagreement,non-independence, press).Alongitudinalstudyofdepressivesymptomologyandself-
andreliability:Implicationsfordataaggregationandanalysis.In conceptinadolescents.JournalofSpecialEducation.
K. J. Klein & S. W. Kozlowski (Eds.), Multilevel theory, re- Nezlek, J. B. (2001). Multilevel random coefficient analyses of
search,andmethodsinorganizations(pp.349–381).SanFran- event and interval contingent data in social and personality
cisco:Jossey-Bass. psychologyresearch.Personality&SocialPsychologyBulletin,
Bliese, P. D., & Halverson, R. R. (1996). Individual and nomo- 27,771–785.

CENTERINGINMULTILEVELMODELS 137
Paccagnella, O. (2006). Centering or not centering in multilevel Snijders,T.A.B.,&Bosker,R.J.(1999).Multilevelanalysis:An
models? The role of the group mean and the assessment of introduction to basic and advanced multilevel modeling. Lon-
| groupeffects.EvaluationReview,30,66–85. |     |     |     |     |     |     |     | don:Sage. |     |     |
| --------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --------- | --- | --- |
Peugh, J. L., & Enders, C. K. (2005). Using the SPSS mixed Stevens, J. (1999). Intermediate statistics: A modern approach
proceduretofitcross-sectionalandlongitudinalmultilevelmod- (2nded.).Mahwah,NJ:Erlbaum.
els.EducationalandPsychologicalMeasurement,65,717–741. Susser,M.(1994).Thelogicinecological:Thelogicofanalysis.
Plewis,I.(1989).Commenton“centering”predictorsinmultilevel AmericanJournalofPublicHealth,85,825–829.
analysis.MultilevelModellingNewsletter,1(3),6,11. Wampold,B.E.,&Brown,G.S.(2005).Estimatingvariabilityin
Raudenbush, S. W. (1989a). “Centering” predictors in multilevel outcomesattributabletotherapists:Anaturalisticstudyofout-
analysis: Choices and consequences. Multilevel Modelling comes in managed care. Journal of Consulting and Clinical
| Newsletter,1(2),10–12. |     |     |     |     |     |     |     | Psychology,73,914–923. |     |     |
| ---------------------- | --- | --- | --- | --- | --- | --- | --- | ---------------------- | --- | --- |
Raudenbush,S.W.(1989b).AresponsetoLongfordandPlewis. Willms,J.D.(1986).Socialclasssegregationanditsrelationship
MultilevelModellingNewsletter,1(3),8–11. topupils’examinationresultsinScotland.AmericanSociolog-
Raudenbush, S. W., & Bryk, A. S. (2002). Hierarchical linear icalReview,51,224–241.
models: Applications and data analysis methods (2nd ed.). Wu, Y.-W. B., & Wooldridge, P. J. (2005). The impact of
ThousandOaks,CA:Sage. centering first-level predictors on individual and contextual
Schwartz, S. (1994). The fallacy of the ecological fallacy: The effects in multilevel data analysis. Nursing Research, 54,
| potential | misuse | of  | a concept | and the | consequences. | American |     | 212–216. |     |     |
| --------- | ------ | --- | --------- | ------- | ------------- | -------- | --- | -------- | --- | --- |
JournalofPublicHealth,84,819–824. Zohar, D., & Luria, G. (2005). A multilevel model of safety
Singer, J. D., & Willett, J. B. (2003). Applied longitudinal data climate: Cross-level relationships between organization and
analysis: Modeling change and event occurrence. New York: group-level climates. Journal of Abnormal Psychology, 90,
| OxfordUniversityPress. |     |     |     |     |             |     |          | 616–628.            |     |     |
| ---------------------- | --- | --- | --- | --- | ----------- | --- | -------- | ------------------- | --- | --- |
|                        |     |     |     |     |             |     | Appendix | A                   |     |     |
|                        |     |     |     | The | Equivalence | of  | CGM      | and CWC in Equation | 16  |     |
Intheequationsbelow,asingleasteriskisusedtodenote (cid:2)(cid:4)**(cid:2)W(cid:3)(cid:2)(cid:4)**(cid:2)x(cid:1)(cid:3)(cid:2)W(cid:3)(cid:2)(cid:4)**(cid:2)X (cid:3)(cid:3)(cid:4)**(cid:2)x(cid:1)(cid:3)
|     |             |     |          |          |     |          |      | 02 j | 03 j j                   | 10 ij 10 j                                                       |
| --- | ----------- | --- | -------- | -------- | --- | -------- | ---- | ---- | ------------------------ | ---------------------------------------------------------------- |
| CGM | parameters, | and | a double | asterisk | is  | used for | CWC. |      |                          |                                                                  |
|     |             |     |          |          |     |          |      |      | (cid:2)(cid:4)**(cid:2)X | (cid:3)(cid:3)(cid:4)**(cid:2)x(cid:1)(cid:3)(cid:2)W(cid:3) (2) |
Level 1 and Level 2 predictors are denoted X and W, 11 ij 11 j j
respectively.FollowingKreftetal.(1995),theequivalence
ofCGMandCWCisdemonstratedbyfindingasolutionto
CollectingliketermsfrombothsidesofEquationA2yields
Equation A1.
|                                                                                                                                                         |     |     |     |     |     |                        |     | the following solution: |     |     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------- | --- | --- | --- | --- | --- | ---------------------- | --- | ----------------------- | --- | --- |
| (cid:4)* (cid:2)(cid:4)*(cid:2)x(cid:1)(cid:3)(cid:2)(cid:4)*(cid:2)W(cid:3)(cid:2)(cid:4)*(cid:2)x(cid:1)(cid:3)(cid:2)W(cid:3)(cid:2)(cid:4)*(cid:2)X |     |     |     |     |     | (cid:3)x(cid:1)(cid:3) |     |                         |     |     |
00 01 j 02 j 03 j j 10 ij (cid:4)* (cid:3)(cid:4)*(cid:2)x(cid:1)(cid:3)(cid:1)(cid:4)**
(A3)
(cid:2)(cid:4)*(cid:2)X (cid:3)x(cid:1)(cid:3)(cid:2)W(cid:3)(cid:1)(cid:4)**(cid:2)(cid:4)**(cid:2)x(cid:1)(cid:3)(cid:2)(cid:4)**(cid:2)W(cid:3) 00 10 00
|     | 11  | ij  | j   | 00  | 01 j | 02  | j   |     |     |     |
| --- | --- | --- | --- | --- | ---- | --- | --- | --- | --- | --- |
(cid:4)* (cid:1)(cid:4)**(cid:3)(cid:4)** (A4)
(cid:2)(cid:4)**(cid:2)x(cid:1)(cid:3)(cid:2)W(cid:3)(cid:2)(cid:4)**(cid:2)X (cid:3)x(cid:1)(cid:3)(cid:2)(cid:4)**(cid:2)X (cid:3)x(cid:1)(cid:3)(cid:2)W(cid:3) 01 01 10
|     | 03  | j   | j 10 | ij  | j 11 | ij  | j j |     |     |     |
| --- | --- | --- | ---- | --- | ---- | --- | --- | --- | --- | --- |
(cid:4)* (cid:3)(cid:4)*(cid:2)x(cid:1)(cid:3)(cid:1)(cid:4)** (A5)
|     |     |     |     |     |     |     | (A1) |     | 02 11 | 02  |
| --- | --- | --- | --- | --- | --- | --- | ---- | --- | ----- | --- |
(cid:4)* (cid:1)(cid:4)**(cid:3)(cid:4)**
(A6)
| Equation | A1  | can be | further | expanded | as follows: |     |     |     | 03 03 | 11  |
| -------- | --- | ------ | ------- | -------- | ----------- | --- | --- | --- | ----- | --- |
(cid:4)* (cid:1)(cid:4)** (A7)
(cid:4)* (cid:2)(cid:4)*(cid:2)x(cid:1)(cid:3)(cid:2)(cid:4)*(cid:2)W(cid:3)(cid:2)(cid:4)*(cid:2)x(cid:1)(cid:3)(cid:2)W(cid:3)(cid:2)(cid:4)*(cid:2)X (cid:3) 10 10
| 00  | 01 j | 02  | j   | 03 j | j   | 10 ij |     |     |     |     |
| --- | ---- | --- | --- | ---- | --- | ----- | --- | --- | --- | --- |
(cid:4)* (cid:1)(cid:4)*
(cid:3)(cid:4)*(cid:2)x(cid:1)(cid:3)(cid:2)(cid:4)*(cid:2)X (cid:3)(cid:3)(cid:4)*(cid:2)x(cid:1)(cid:3)(cid:2)W(cid:3)(cid:1)(cid:4)**(cid:2)(cid:4)**(cid:2)x(cid:1)(cid:3) *. (A8)
|     | 10  |     | 11 ij | 11  | j   | 00          | 01 j |           | 11  | 11  |
| --- | --- | --- | ----- | --- | --- | ----------- | ---- | --------- | --- | --- |
|     |     |     |       |     |     | (Appendixes |      | continue) |     |     |

138 ENDERSANDTOFIGHI
Appendix B
Algebraic Details Associated With Centering
Binary Level 1 Predictors
ToillustratetheuseofCGM,consideradummyvariable where x(cid:1) equals p (cid:9) p . Consistent with a dummy code
j 1j 0j
(i.e.,x (cid:7)0,1)wherethetotalsampleNiscomprisedofn scheme, applying CGM to a binary effect code variable
ij 0
cases in the base group (i.e., x (cid:7) 0) and n cases in the yieldsa(cid:1) valuethatisinterpretedasanadjustedmeanfor
ij 1 0j
comparison group (i.e., x (cid:7) 1). The grand mean for a cluster j. Although it may not be immediately obvious, the
ij
binarydummyvariableisthetotalproportionofcasesinthe portion of the adjustment that involves the proportion of
comparison group, denoted p as follows: base and comparison group cases will be twice as large as
1
the corresponding term in Equation B2—intuitively, this
(cid:15)x n (cid:2)0(cid:3)(cid:2)n (cid:2)1(cid:3) n follows from the fact that the centered scores are twice as
x(cid:1) (cid:1) ij(cid:1) 0 1 (cid:1) 1(cid:1)p . (B1)
N N N 1 large under effect coding. This is compensated for by the
fact that effect coding produces a (cid:1) value that is exactly
1j
As such, X can be written as x (cid:3) x(cid:1) (cid:1) x (cid:3) p . half as large as it was under dummy coding and results in
cgm ij ij 1
Simplifying this expression (i.e., substituting x (cid:7) 0 or 1 identical interpretations of (cid:1) and (cid:5) .
ij 0j 00
into the equation) yields centered scores of (cid:9)p and p for The algebraic details associated with CWC are as follows.
1 0
thebaseandcomparisongroupcases,respectively,wherep Consideradummyvariable(i.e.,x (cid:7)0,1)withn casesin
0 ij 0j
is the total proportion of base group cases. the base group (i.e., x (cid:7) 0) and n cases in the comparison
ij 1j
Underadummycodescheme,Equation6canberewrittenas group(i.e.,x (cid:7)1).Underadummycodingscheme,x(cid:1) isequal
ij j
to the proportion of comparison group cases within cluster j
(cid:1) (cid:1)y(cid:1) (cid:3)(cid:1) (cid:2)x(cid:1) (cid:3)x(cid:1)(cid:3)(cid:1)y(cid:1) (cid:3)(cid:1) (cid:2)p (cid:3)p (cid:3) (i.e., n /n (cid:7) p ), so X can be written as x (cid:3) x(cid:1) (cid:1) x
0j j 1j j j 1j 1j 1 1j j 1j cwc ij j ij
(cid:1)y(cid:1) (cid:3)(cid:2)y(cid:1) (cid:3)y(cid:1) (cid:3)(cid:2)p (cid:3)p (cid:3), (B2) (cid:3) p 1j .Substitutingx ij (cid:7)0and1intotheexpressionforX cwc
j 0j 1j 1j 1 yieldsacenteredscoreof (cid:9)p forthebasegroupcases(i.e.,
1j
w pr h o e p r o e rt (cid:1) io 1j n eq o u f a c l o s m th p e a m ris e o a n nd g i r f o fe u r p en c c a e se w s it i h n in cl c u lu st s e t r er j. j, E an q d ua p t 1 io j n ist B h 2 e c x i a j s (cid:7) es 0 ( ) i , .e a ., nd x ij a (cid:7) cod 1 e ). o E f q 1 u (cid:9) ati p o 1 n j (cid:7) B5 p i 0 l j lu fo s r tr t a h te e s co th m at pa th ri e so c n en g t r e o r u e p d
showsthat(cid:1) isequaltotheoutcomevariablemeanforclusterj, dummycodevalueshaveameanofzerowithineachcluster,
0j
whichisconsistentwiththecontinuouscase.
minus an adjustment term that corrects for differences in the
proportionofcomparisongroupcasesacrossclusters.
(cid:15)X n (cid:2)(cid:9)p (cid:3)(cid:2)n (cid:2)p (cid:3)
Applying CGM to an effect code variable in the Level 1 x(cid:1) (cid:1) cwc(cid:1) 0j 1j 1j 0j
j n n
equationyieldsthesameresultasthedummyvariablecase. j j
Toillustrate,consideraneffectcodevariable(i.e.,x (cid:7)(cid:9)1, (cid:1)(cid:9)p p (cid:2)p p (cid:1)0 (B5)
ij 0j 1j 1j 0j
1)wherethetotalsampleNiscomprisedofn casesinthe
g b r a o s u e p g ( r i o .e u . p ,x ( i i j .e (cid:7) ., 1 x ) ij .T (cid:7) he (cid:9) g 1 r ) an a d nd m n e 1 an ca fo se r s a i b n in th ar e 0 y c e o f m fe p c a t r c i o so d n e t B o ec v a e u r s if e y x(cid:1) j t (cid:7) hat 0a (cid:1) f 0 te j r i a s pp in ly te i r n p g re C te W d C a , s Eq th u e ati u o n n a 7 dj c u a s n te b d eu (i s . e e d .,
variableisthedifferencebetweentheproportionofbaseand weighted) mean for cluster j.
comparison group cases, as follows: When using a binary effect code, the mean for cluster j
is (n (cid:9) n )/n (cid:7) p (cid:9) p , and X can be written as
1j 0j j 1j 0j cwc
(cid:15)x n (cid:2)(cid:9)1(cid:3)(cid:2)n (cid:2)1(cid:3) (cid:3)n (cid:2)n x (cid:3) x(cid:1) (cid:1) x (cid:3) (cid:2)p (cid:3) p (cid:3).Simplifyingthisexpression
x(cid:1) (cid:1) N ij(cid:1) 0 N 1 (cid:1) 0 N 1(cid:1)p 1 (cid:3)p 0 . y i i j elds a j cente i r j ed scor 1 e j of (cid:9) 0 2 j p 1j for the base group cases
(i.e.,x (cid:7)(cid:9)1),andascoreof2p forthecomparisongroup
ij 0j
(B3) cases (i.e., x (cid:7) 1). These centered values are identical to
ij
thosefromthedummycodescheme,exceptforthepresence
X isnowx (cid:3) x(cid:1) (cid:1) x (cid:3) (cid:2)p (cid:3) p (cid:3),andthecentered
cgm ij j ij 1 0 ofamultiplicativeconstant.Ifthecenteredeffectcodesare
scores become (cid:9)2p and 2p for the base and comparison
1 0 inserted into Equation B5, the additional constant terms
groupcases,respectively(i.e.,aftersubstitutingx (cid:7)(cid:9)1or
ij cancel,resultinginx(cid:1) (cid:7)0.Assuch,(cid:1) isinterpretedasthe
1 into the expression for X ). j 0j
cgm unadjusted mean for cluster j, regardless of whether one
When using effect codes, (cid:1) equals half the mean dif-
1j usesdummyoreffectcodestorepresentthebinaryvariable.
ferenceinclusterj,soEquation6canbewrittenasfollows
Received February 8, 2006
(cid:1) (cid:1)y(cid:1) (cid:3)(cid:1) (cid:2)x(cid:1) (cid:3)x(cid:1)(cid:3)
0j j 1j j Revision received January 24, 2007
(cid:1)y(cid:1) (cid:3)(cid:2).5(cid:3)(cid:2)y(cid:1) (cid:3)y(cid:1) (cid:3)(cid:2)p (cid:3)p (cid:3)p (cid:2)p (cid:3), (B4) Accepted January 25, 2007 (cid:1)
j 0j 1j 1j 0j 1 0
AAllll iinn--tteexxtt rreeffeerreenncceess uunnddeerrlliinneedd iinn bblluuee aarree lliinnkkeedd ttoo ppuubblliiccaattiioonnss oonn RReesseeaarrcchhGGaattee,, lleettttiinngg yyoouu aacccceessss aanndd rreeaadd tthheemm iimmmmeeddiiaatteellyy..
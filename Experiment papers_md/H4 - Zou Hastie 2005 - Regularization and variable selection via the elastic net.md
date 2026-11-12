J.R.Statist.Soc.B(2005)
67,Part2,pp.301–320
Regularization and variable selection via the
elastic net
HuiZouandTrevorHastie
StanfordUniversity,USA
[ReceivedDecember2003.FinalrevisionSeptember2004]
Summary.Weproposetheelasticnet,anewregularizationandvariableselectionmethod.Real
worlddataandasimulationstudyshowthattheelasticnetoftenoutperformsthelasso,while
enjoyingasimilarsparsityofrepresentation.Inaddition,theelasticnetencouragesagrouping
effect,wherestronglycorrelatedpredictorstendtobeinoroutofthemodeltogether.Theelastic
netisparticularlyusefulwhenthenumberofpredictors(p)ismuchbiggerthanthenumberof
observations(n).Bycontrast,thelassoisnotaverysatisfactoryvariableselectionmethodinthe
p(cid:1)ncase.AnalgorithmcalledLARS-ENisproposedforcomputingelasticnetregularization
pathsefficiently,muchlikealgorithmLARSdoesforthelasso.
Keywords: Groupingeffect;LARSalgorithm;Lasso;Penalization;p(cid:1)nproblem;Variable
selection
1. Introductionandmotivation
Weconsidertheusuallinearregressionmodel:givenppredictorsx
1
,...,x p,theresponseyis
predictedby
yˆ=βˆ
0
+x
1
βˆ
1
+...+x
p
βˆ
p
: .1/
Amodelfittingprocedureproducesthevectorofcoefficientsβˆ=.βˆ
0
,...,βˆ
p
/.Forexample,the
ordinaryleastsquares(OLS)estimatesareobtainedbyminimizingtheresidualsumofsquares.
The criteria for evaluating the quality of a model will differ according to the circumstances.
Typicallythefollowingtwoaspectsareimportant:
(a) accuracy of prediction on future data—it is difficult to defend a model that predicts
poorly;
(b) interpretationofthemodel—scientistspreferasimplermodelbecauseitputsmorelight
ontherelationshipbetweentheresponseandcovariates.Parsimonyisespeciallyanimpor-
tantissuewhenthenumberofpredictorsislarge.
ItiswellknownthatOLSoftendoespoorlyinbothpredictionandinterpretation.Penaliza-
tiontechniqueshavebeenproposedtoimproveOLS.Forexample,ridgeregression(Hoerland
Kennard,1988)minimizestheresidualsumofsquaressubjecttoaboundontheL -normofthe
2
coefficients.Asacontinuousshrinkagemethod,ridgeregressionachievesitsbetterprediction
performance through a bias–variance trade-off. However, ridge regression cannot produce a
parsimoniousmodel,foritalwayskeepsallthepredictorsinthemodel.Bestsubsetselectionin
Addressforcorrespondence: TrevorHastie,DepartmentofStatistics,StanfordUniversity,Stanford,CA94305,
USA.
E-mail:hastie@stanford.edu
2005RoyalStatisticalSociety 1369–7412/05/67301

302 H.ZouandT.Hastie
contrastproducesasparsemodel,butitisextremelyvariablebecauseofitsinherentdiscreteness,
asaddressedbyBreiman(1996).
A promising technique called the lasso was proposed by Tibshirani (1996). The lasso is a
penalized least squares method imposing an L -penalty on the regression coefficients. Owing
1
tothenatureoftheL -penalty,thelassodoesbothcontinuousshrinkageandautomaticvari-
1
able selection simultaneously. Tibshirani (1996) and Fu (1998) compared the prediction per-
formance of the lasso, ridge and bridge regression (Frank and Friedman, 1993) and found
thatnoneofthemuniformlydominatestheothertwo.However,asvariableselectionbecomes
increasinglyimportantinmoderndataanalysis,thelassoismuchmoreappealingowingtoits
sparserepresentation.
Althoughthelassohasshownsuccessinmanysituations,ithassomelimitations.Consider
thefollowingthreescenarios.
(a) Inthep>ncase,thelassoselectsatmostnvariablesbeforeitsaturates,becauseofthe
nature of the convex optimization problem. This seems to be a limiting feature for a
variable selection method. Moreover, the lasso is not well defined unless the bound on
theL -normofthecoefficientsissmallerthanacertainvalue.
1
(b) Ifthereisagroupofvariablesamongwhichthepairwisecorrelationsareveryhigh,then
thelassotendstoselectonlyonevariablefromthegroupanddoesnotcarewhichoneis
selected.SeeSection2.3.
(c) Forusualn>psituations,iftherearehighcorrelationsbetweenpredictors,ithasbeen
empiricallyobservedthatthepredictionperformanceofthelassoisdominatedbyridge
regression(Tibshirani,1996).
Scenarios(a)and(b)makethelassoaninappropriatevariableselectionmethodinsomesit-
uations.Weillustrateourpointsbyconsideringthegeneselectionprobleminmicroarraydata
analysis. A typical microarray data set has many thousands of predictors (genes) and often
fewerthan100samples.Forthosegenessharingthesamebiological‘pathway’,thecorrelations
between them can be high (Segal and Conklin, 2003). We think of those genes as forming a
group. The ideal gene selection method should be able to do two things: eliminate the trivial
genes and automatically include whole groups into the model once one gene among them is
selected(‘groupedselection’).Forthiskindofp(cid:1)nandgroupedvariablessituation,thelasso
isnottheidealmethod,becauseitcanonlyselectatmostnvariablesoutofpcandidates(Efron
etal.,2004),anditlackstheabilitytorevealthegroupinginformation.Asforpredictionper-
formance,scenario(c)isnotrareinregressionproblems.Soitispossibletostrengthenfurther
thepredictionpowerofthelasso.
Ourgoalistofindanewmethodthatworksaswellasthelassowheneverthelassodoesthe
best,andcanfixtheproblemsthatwerehighlightedabove,i.e.itshouldmimictheidealvariable
selectionmethodinscenarios(a)and(b),especiallywithmicroarraydata,anditshoulddeliver
betterpredictionperformancethanthelassoinscenario(c).
Inthispaperweproposeanewregularizationtechniquewhichwecalltheelasticnet.Similar
to the lasso, the elastic net simultaneously does automatic variable selection and continuous
shrinkage,anditcanselectgroupsofcorrelatedvariables.Itislikeastretchablefishingnetthat
retains‘allthebigfish’.Simulationstudiesandrealdataexamplesshowthattheelasticnetoften
outperformsthelassointermsofpredictionaccuracy.
InSection2wedefinethena¨ıveelasticnet,whichisapenalizedleastsquaresmethodusinga
novelelasticnetpenalty.Wediscussthegroupingeffectthatiscausedbytheelasticnetpenalty.
InSection3,weshowthatthisna¨ıveproceduretendstoovershrinkinregressionproblems.We
thenintroducetheelasticnet,whichcorrectsthisproblem.AnefficientalgorithmLARS-ENis

|     |     |     |     |     |     |     |     | ElasticNet | 303 |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | --- |
proposedforcomputingtheentireelasticnetregularizationpathswiththecomputationaleffort
of a single OLS fit. Prostate cancer data are used to illustrate our methodology in Section 4,
and simulation results comparing the lasso and the elastic net are presented in Section 5.
Section6showsanapplicationoftheelasticnettoclassificationandgeneselectioninaleukae-
miamicroarrayproblem.
2. Na¨ıveelasticnet
2.1. Definition
Suppose that the data set has n observations with p predictors. Let y=.y ,...,y /T be the
|     |     |     |     |     |     |     |     | 1 n |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
responseandX=.x |...|x /bethemodelmatrix,wherex =.x 1j,...,x /T, j=1,...,p,are
|     | 1   | p   |     |     |     |     | j   | nj  |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
the predictors. After a location and scale transformation, we can assume that the response is
centredandthepredictorsarestandardized,
| (cid:1)n |       | (cid:1)n |         |     | (cid:1)n |         |                 |     |     |
| -------- | ----- | -------- | ------- | --- | -------- | ------- | --------------- | --- | --- |
| y        | i =0, |          | x ij =0 |     | and      | x 2 =1, | forj=1,2,...,p: |     | .2/ |
i j
| i=1 |     | i=1 |     |     | i=1 |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Foranyfixednon-negativeλ andλ ,wedefinethena¨ıveelasticnetcriterion
|     |     |     | 1                | 2   |     |        |       |     |     |
| --- | --- | --- | ---------------- | --- | --- | ------ | ----- | --- | --- |
|     |     | L.λ | ,λ ,β/=|y−Xβ|2+λ |     |     | |β|2+λ | |β|   |     | .3/ |
|     |     |     | 1 2              |     |     | 2      | 1 1 , |     |     |
where
(cid:1)p
|     |     |     |     | |β|2= |     | β 2, |     |     |     |
| --- | --- | --- | --- | ----- | --- | ---- | --- | --- | --- |
j
j=1
(cid:1)p
|     |     |     |     | |β| | =   | |β |: |     |     |     |
| --- | --- | --- | --- | --- | --- | ----- | --- | --- | --- |
|     |     |     |     |     | 1   | j     |     |     |     |
j=1
Thena¨ıveelasticnetestimatorβˆ
istheminimizerofequation(3):
|     |     |     | βˆ=argmin{L.λ |     |     | ,λ ,β/}: |     |     | .4/ |
| --- | --- | --- | ------------- | --- | --- | -------- | --- | --- | --- |
1 2
β
Thisprocedurecanbeviewedasapenalizedleastsquaresmethod.Letα=λ =.λ +λ /;then
|     |     |     |     |     |     |     |     | 2 1 | 2   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
solvingβˆ
inequation(3)isequivalenttotheoptimizationproblem
βˆ=argmin|y−Xβ|2,
|     |     |     |     | subjectto.1−α/|β| |     |     | +α|β|2(cid:1)tforsomet: |     | .5/ |
| --- | --- | --- | --- | ----------------- | --- | --- | ----------------------- | --- | --- |
1
β
Wecallthefunction.1−α/|β| +α|β|2theelasticnetpenalty,whichisaconvexcombination
1
ofthelassoandridgepenalty.Whenα=1,thena¨ıveelasticnetbecomessimpleridgeregression.
Inthispaper,weconsideronlyα<1.Forallα∈[0,1/,theelasticnetpenaltyfunctionissingular
(withoutfirstderivative)at0anditisstrictlyconvexforallα>0,thushavingthecharacteristics
of both the lasso and ridge regression. Note that the lasso penalty (α=0) is convex but not
strictlyconvex.TheseargumentscanbeseenclearlyfromFig.1.
2.2. Solution
We now develop a method to solve the na¨ıve elastic net problem efficiently. It turns out that
minimizingequation(3)isequivalenttoalasso-typeoptimizationproblem.Thisfactimplies
thatthena¨ıveelasticnetalsoenjoysthecomputationaladvantageofthelasso.

304 H.ZouandT.Hastie
β
2
β 1
Two-dimensionalcontourplots(level1)((cid:2)-(cid:2)-(cid:2)-,shapeoftheridgepenalty;-------,contourofthe
Fig.1.
lassopenalty; ,contouroftheelasticnetpenaltywithαD0:5):weseethatsingularitiesatthevertices
andtheedgesarestrictlyconvex;thestrengthofconvexityvarieswithα
Å Å
Givendataset.y,X/and.λ ,λ /,defineanartificialdataset.y ,X /by
Lemma1. 1 2
|          |       | (cid:2) (cid:3) |        | (cid:2) (cid:3) |
| -------- | ----- | --------------- | ------ | --------------- |
| Å        |       | X               | Å      | y               |
| X =.1+λ  | /−1=2 | √ ,             | y      | = :             |
|          | 2     | λ I             | . n+p/ |                 |
| . n+p/×p |       | 2               |        | 0               |
| √ √      |       |                 |        |                 |
Letγ=λ = .1+λ /andβ Å = .1+λ /β.Thenthena¨ıveelasticnetcriterioncanbewritten
| 1 2 | 2   |     |     |     |
| --- | --- | --- | --- | --- |
as
|              |              | (cid:4) | (cid:4) (cid:4)     | (cid:4)  |
| ------------ | ------------ | ------- | ------------------- | -------- |
|              | Å /=(cid:4)y | Å Å     | Å(cid:4)2+γ(cid:4)β | Å(cid:4) |
| L.γ,β/=L.γ,β |              | −X β    |                     | :        |
1
Let
|     | Å                |     | Å   |     |
| --- | ---------------- | --- | --- | --- |
|     | βˆ =argminL{.γ,β |     | /}; |     |
βÅ
then
|     |      | 1 Å    |     |     |
| --- | ---- | ------ | --- | --- |
|     | βˆ=√ | βˆ     | :   |     |
|     |      | .1+λ / |     |     |
2
Theproofisjustsimplealgebra,whichweomit.Lemma1saysthatwecantransformthena¨ıve
elasticnetproblemintoanequivalentlassoproblemonaugmenteddata.Notethatthesample
Å
sizeintheaugmentedproblemisn+pandX hasrankp,whichmeansthatthena¨ıveelastic
netcanpotentiallyselectallppredictorsinallsituations.Thisimportantpropertyovercomes
the limitations of the lasso that were described in scenario (a). Lemma 1 also shows that the
na¨ıveelasticnetcanperformanautomaticvariableselectioninafashionsimilartothelasso.In
thenextsectionweshowthatthena¨ıveelasticnethastheabilityofselecting‘grouped’variables,
apropertythatisnotsharedbythelasso.

ElasticNet 305
^β
β
Fig.2. Exactsolutionsforthelasso(-------),ridgeregression((cid:2)-(cid:2)-(cid:2)-)andthena¨ıveelasticnet( )
inanorthogonaldesign(.......,OLS):theshrinkageparametersareλ D2andλ D1
1 2
Inthecaseofanorthogonaldesign,itisstraightforwardtoshowthatwithparameters.λ ,λ /
1 2
thena¨ıveelasticnetsolutionis
βˆ
i
.na¨ıveelasticnet/= .|βˆ i .OL
1
S
+
/|
λ
−λ 1 =2/ + sgn{βˆ
i
.OLS/}, .6/
2
whereβˆ.OLS/=XTyandz
+
denotesthepositivepart,whichiszifz>0and0otherwise.The
solutionofridgeregressionwithparameterλ isgivenbyβˆ.ridge/=βˆ.OLS/=.1+λ /,andthe
2 2
lassosolutionwithparameterλ is
1
βˆ
i
.lasso/=.|βˆ
i
.OLS/|−λ
1
=2/ +sgn{βˆ
i
.OLS/}:
Fig.2showstheoperationalcharacteristicsofthethreepenalizationmethodsinanorthogonal
design,wherethena¨ıveelasticnetcanbeviewedasatwo-stageprocedure:aridge-typedirect
shrinkagefollowedbyalasso-typethresholding.
2.3. Thegroupingeffect
Inthe‘largep,smalln’problem(Westetal.,2001),the‘groupedvariables’situationisapartic-
ularlyimportantconcern,whichhasbeenaddressedmanytimesintheliterature.Forexample,
principal component analysis has been used to construct methods for finding a set of highly
correlatedgenesinHastieetal.(2000)andD´ıaz-Uriarte(2003).Treeharvesting(Hastieetal.,
2003) uses supervised learning methods to select groups of predictive genes found by hierar-
chical clustering. Using an algorithmic approach, Dettling and Bu¨hlmann (2004) performed
the clustering and supervised learning together. A careful study by Segal and Conklin (2003)
stronglymotivatestheuseofaregularizedregressionproceduretofindthegroupedgenes.We
considerthegenericpenalizationmethod

306 H.ZouandT.Hastie
βˆ=argmin|y−Xβ|2+λJ.β/ .7/
β
whereJ.·/ispositivevaluedforβ(cid:4)=0.
Qualitatively speaking, a regression method exhibits the grouping effect if the regression
coefficientsofagroupofhighlycorrelatedvariablestendtobeequal(uptoachangeofsignif
negativelycorrelated).Inparticular,intheextremesituationwheresomevariablesareexactly
identical,theregressionmethodshouldassignidenticalcoefficientstotheidenticalvariables.
Lemma2. Assumethatx i =x j,i,j∈{1,...,p}.
(a) IfJ.·/isstrictlyconvex,thenβˆ i =β Å ˆ j,∀λ>0.
(b) IfJ.β/=|β| 1 ,thenβˆ i βˆ j (cid:2)0andβˆ isanotherminimizerofequation(7),where

Å
βˆ
k
ifk(cid:4)=iandk(cid:4)=j,
βˆ
k
=

.βˆ
i
+βˆ
j
/·.s/ ifk=i,
.βˆ
i
+βˆ
j
/·.1−s/ ifk=j,
foranys∈[0,1].
Lemma2showsacleardistinctionbetweenstrictly convexpenaltyfunctionsandthelasso
penalty.Strictconvexityguaranteesthegroupingeffectintheextremesituationwithidentical
predictors.Incontrastthelassodoesnotevenhaveauniquesolution.Theelasticnetpenalty
withλ >0isstrictlyconvex,thusenjoyingthepropertyinassertion(1).
2
Theorem 1. Given data .y,X/ and parameters .λ ,λ /, the response y is centred and the
1 2
predictorsX arestandardized.Letβˆ.λ ,λ /bethena¨ıveelasticnetestimate.Supposethat
1 2
βˆ
i
.λ
1
,λ
2
/βˆ
j
.λ
1
,λ
2
/>0.Define
1
D
λ 1,λ 2
.i,j/=
|y|
|βˆ
i
.λ
1
,λ
2
/−βˆ
j
.λ
1
,λ
2
/|;
1
then
1 √
D
λ 1,λ
2
.i,j/(cid:1)
λ
{2.1−ρ/},
2
whereρ=x
i
Tx j,thesamplecorrelation.
The unitless quantity D λ 1,λ 2 .i,j/ describes the difference : between : the coefficient paths of
predictors i and j. If x i and x j are highly correlated, i.e. ρ=1 (if ρ=−1 then consider −x j),
theorem1saysthatthedifferencebetweenthecoefficientpathsofpredictoriandpredictorjis
almost0.Theupperboundintheaboveinequalityprovidesaquantitativedescriptionforthe
groupingeffectofthena¨ıveelasticnet.
The lasso does not have the grouping effect. Scenario (b) in Section 1 occurs frequently in
practice. A theoretical explanation is given in Efron et al. (2004). For a simpler illustration,
let us consider the linear model with p=2. Tibshirani (1996) gave the explicit expression for
.βˆ ,βˆ /,fromwhichweeasilyobtainthat|βˆ −βˆ |=|cos.θ/|,whereθ istheanglebetweeny
1 2 1 2
andx −x .Itiseasytoconstructexamplessuchthatρ=corr.x ,x /→1butcos.θ/doesnot
1 2 1 2
vanish.
2.4. BayesianconnectionsandtheL q-penalty
Bridgeregression(FrankandFriedman,1993;Fu,1998)hasJ.β/=|β|q q =Σp j=1 |β j |q inequa-
tion (7), which is a generalization of both the lasso (q=1) and ridge regression (q=2). The

|     |     |     |     |     | ElasticNet | 307 |
| --- | --- | --- | --- | --- | ---------- | --- |
bridgeestimatorcanbeviewedastheBayesposteriormodeundertheprior
.β/=C.λ,q/exp.−λ|β|q
|     | p λ,q |     |     | /:  |     | .8/ |
| --- | ----- | --- | --- | --- | --- | --- |
q
Ridgeregression(q=2)correspondstoaGaussianpriorandthelasso(q=1)aLaplacian(or
double-exponential)prior.Theelasticnetpenaltycorrespondstoanewpriorgivenby
| p   | .β/=C.λ,α/exp[−λ{α|β|2+.1−α/|β| |     |     |     | }], | .9/ |
| --- | ------------------------------- | --- | --- | --- | --- | --- |
| λ,α |                                 |     |     |     | 1   |     |
a compromise between the Gaussian and Laplacian priors. Although bridge regression with
1<q<2
will have many similarities with the elastic net, there is a fundamental difference
between them. The elastic net produces sparse solutions, whereas bridge regression does not.
FanandLi(2001)provedthat,intheL (q(cid:2)1)penaltyfamily,onlythelassopenalty(q=1)
q
canproduceasparsesolution.Bridgeregression(1<q<2)alwayskeepsallpredictorsinthe
model,asdoesridgeregression.Sinceautomaticvariableselectionviapenalizationisaprimary
objectiveofthispaper,L (1<q<2)penalizationisnotacandidate.
q
3. Elasticnet
3.1. Deficiencyofthena¨ıveelasticnet
As an automatic variable selection method, the na¨ıve elastic net overcomes the limitations of
the lasso in scenarios (a) and (b). However, empirical evidence (see Sections 4 and 5) shows
that the na¨ıve elastic net does not perform satisfactorily unless it is very close to either ridge
regressionorthelasso.Thisiswhywecallitna¨ıve.
In the regression prediction setting, an accurate penalization method achieves good pre-
diction performance through the bias–variance trade-off. The na¨ıve elastic net estimator is a
two-stage procedure: for each fixed λ we first find the ridge regression coefficients, and then
2
we do the lasso-type shrinkage along the lasso coefficient solution paths. It appears to incur
adoubleamountofshrinkage.Doubleshrinkagedoesnothelptoreducethevariancesmuch
andintroducesunnecessaryextrabias,comparedwithpurelassoorridgeshrinkage.Inthenext
sectionweimprovethepredictionperformanceofthena¨ıveelasticnetbycorrectingthisdouble
shrinkage.
3.2. Theelasticnetestimate
WefollowthenotationinSection2.2.Givendata.y,X/,penaltyparameter.λ ,λ /andaug-
1 2
menteddata.y Å ,X Å /,thena¨ıveelasticnetsolvesalasso-typeproblem
λ
| Å   |           | Å   | Å Å    |      | Å      |      |
| --- | --------- | --- | ------ | ---- | ------ | ---- |
| βˆ  | =argmin|y | −X  | β |2+√ | 1    | |β | : | .10/ |
|     | βÅ        |     |        | .1+λ | / 1    |      |
2
Theelasticnet(corrected)estimatesβˆ aredefinedby
|     |                 |     | √    | Å   |     |      |
| --- | --------------- | --- | ---- | --- | --- | ---- |
|     | βˆ.elasticnet/= |     |      | /βˆ |     |      |
|     |                 |     | .1+λ | :   |     | .11/ |
2
|                                    |     | √    | Å    |     |     |     |
| ---------------------------------- | --- | ---- | ---- | --- | --- | --- |
| Recallthatβˆ.na¨ıveelasticnet/={1= |     | .1+λ | /}βˆ |     |     |     |
;thus
2
| βˆ.elasticnet/=.1+λ |     |     | /βˆ.na¨ıveelasticnet/: |     |     | .12/ |
| ------------------- | --- | --- | ---------------------- | --- | --- | ---- |
2
Hencetheelasticnetcoefficientisarescaledna¨ıveelasticnetcoefficient.
Such a scaling transformation preserves the variable selection property of the na¨ıve elastic
netandisthesimplestwaytoundoshrinkage.Henceallthegoodpropertiesofthena¨ıveelastic

308 H.ZouandT.Hastie
netthatweredescribedinSection2holdfortheelasticnet.Empiricallywehavefoundthatthe
elasticnetperformsverywellwhencomparedwiththelassoandridgeregression.
1+λ
We have another justification for choosing as the scaling factor. Consider the exact
2
solutionofthena¨ıveelasticnetwhenthepredictorsareorthogonal.Thelassoisknowntobe
minimaxoptimal(Donohoetal.,1995)inthiscase,whichimpliesthatthena¨ıveelasticnetis
notoptimal.Afterscalingby1+λ ,theelasticnetautomaticallyachievesminimaxoptimality.
2
A strong motivation for the .1+λ /-rescaling comes from a decomposition of the ridge
2
operator.SincethepredictorsXarestandardized,wehave
|     |     |       |    |     |    |     |     |     |
| --- | --- | ----- | --- | --- | --- | --- | --- | --- |
|     |     |       | 1 ρ | ·   | ρ   |     |     |     |
|     |     |       |     | 12  | 1p  |     |     |     |
|     |     |       |    |     |    |     |     |     |
|     |     | XTX= |     | 1 · | ·   |     |     |     |
 ,
|     |     |     |     | 1 ρ | p−1,p |     |     |     |
| --- | --- | --- | --- | --- | ----- | --- | --- | --- |
1
p×p
whereρ i,jissamplecorrelation.Ridgeestimateswithparameterλ aregivenbyβˆ.ridge/=Ry,
2
with
|     |     |     | R=.XTX+λ | I/−1XT: |     |     |     |     |
| --- | --- | --- | -------- | ------- | --- | --- | --- | --- |
2
WecanrewriteRas
|     |     |     |    | ρ   |     | ρ −1 |     |      |
| --- | --- | --- | --- | --- | --- | ----- | --- | ---- |
|     |     |     |     | 12  |     | 1p    |     |      |
|     |     |     |     | 1   | ·   |       |     |      |
|     |     |     |     | 1+λ |     | 1+λ   |     |      |
|     |     |     |    |     | 2   | 2    |     |      |
|     | 1   | Å   | 1  | 1   | ·   | ·    |     |      |
| R=  |     | R = |    |     |     | ρ    | XT: | .13/ |
p −1 ,p
|     | 1+λ | 1+λ |    |     | 1   |    |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
|     |     | 2   | 2   |     |     | + λ |     |     |
1 2
1
Å
R isliketheusualOLSoperatorexceptthatthecorrelationsareshrunkbythefactor1=.1+λ /,
2
whichwecalldecorrelation.Hencefromequation(13)wecaninterprettheridgeoperatoras
decorrelationfollowedbydirectscalingshrinkage.
This decomposition suggests that the grouping effect of ridge regression is caused by the
decorrelation step. When we combine the grouping effect of ridge regression with the lasso,
thedirect1=.1+λ /shrinkagestepisnotneededandisremovedbyrescaling.Althoughridge
2
| 1=.1+λ |     | /   |     |     |     |     |     |     |
| ------ | --- | --- | --- | --- | --- | --- | --- | --- |
regression requires 2 shrinkage to control the estimation variance effectively, in our
newmethod,wecanrelyonthelassoshrinkagetocontrolthevarianceandtoobtainsparsity.
Fromnowon,letβˆ standforβˆ.elasticnet/.Thenexttheoremgivesanotherpresentationof
theelasticnet,inwhichthedecorrelationargumentismoreexplicit.
Theorem2. Givendata.y,X/and.λ ,λ /,thentheelasticnetestimatesβˆ aregivenby
|     |             |     | 1 2     |             |     |     |       |      |
| --- | ----------- | --- | ------- | ----------- | --- | --- | ----- | ---- |
|     |             |     | (cid:2) | (cid:3)     |     |     |       |      |
|     |             |     | XTX+λ   | I           |     |     |       |      |
|     | βˆ=argminβT |     |         | 2 β−2yTXβ+λ |     |     | |β| : | .14/ |
|     |             |     | 1+λ     |             |     | 1   | 1     |      |
β
2
Itiseasytoseethat
|     | βˆ.lasso/=argminβT.XTX/β−2yTXβ+λ |     |     |     |     | |β| | :   | .15/ |
| --- | -------------------------------- | --- | --- | --- | --- | --- | --- | ---- |
|     |                                  |     |     |     |     | 1   | 1   |      |
β
Hencetheorem2interpretstheelasticnetasastabilizedversionofthelasso.NotethatΣˆ =XTX
isasampleversionofthecorrelationmatrixΣand
|     |     | XTX+λ |     | I   |     |     |     |     |
| --- | --- | ----- | --- | --- | --- | --- | --- | --- |
2
|     |     |     |     | =.1−γ/Σˆ | +γI |     |     |     |
| --- | --- | --- | --- | -------- | --- | --- | --- | --- |
1+λ
2

ElasticNet 309
with γ=λ =.1+λ / shrinks Σˆ towards the identity matrix. Together equations (14) and (15)
2 2
saythatrescalingaftertheelasticnetpenalizationismathematicallyequivalenttoreplacingΣˆ
withitsshrunkenversioninthelasso.Inlineardiscriminantanalysis,thepredictionaccuracy
can often be improved by replacing Σˆ by a shrunken estimate (Friedman, 1989; Hastie et al.,
2001).LikewiseweimprovethelassobyregularizingΣˆ inequation(15).
3.3. Connectionswithunivariatesoftthresholding
Thelassoisaspecialcaseoftheelasticnetwithλ =0.Theotherinterestingspecialcaseofthe
2
elasticnetemergeswhenλ →∞.Bytheorem2,βˆ→βˆ.∞/asλ →∞,where
2 2
βˆ.∞/=argminβTβ−2yTXβ+λ |β|:
1 1
β
βˆ.∞/hasasimpleclosedform
(cid:2) (cid:3)
λ
βˆ.∞/
i
= |yTx
i
|− 1 sgn.yTx
i
/, i=1,2,...,p: .16/
2
+
ObservethatyTx
i
istheunivariateregressioncoefficientoftheithpredictorandβˆ.∞/arethe
estimatesbyapplyingsoftthresholdingonunivariateregressioncoefficients;thusequation(16)
iscalledunivariatesoftthresholding(UST).
USTtotallyignoresthedependencebetweenpredictorsandtreatsthemasindependentvari-
ables.Althoughthismaybeconsideredillegitimate,USTanditsvariantsareusedinothermeth-
odssuchassignificanceanalysisofmicroarrays(Tusheretal.,2001)andthenearestshrunken
centroidsclassifier(Tibshiranietal.,2002),andhaveshowngoodempiricalperformance.The
elasticnetnaturallybridgesthelassoandUST.
3.4. Computation:thealgorithmLARS-EN
WeproposeanefficientalgorithmcalledLARS-ENtosolvetheelasticnetefficiently,whichis
basedontherecentlyproposedalgorithmLARSofEfronetal.(2004).Theyprovedthat,starting
fromzero,thelassosolutionpathsgrowpiecewiselinearlyinapredictableway.Theyproposed
anewalgorithmcalledLARStosolvetheentirelassosolutionpathefficientlybyusingthesame
orderofcomputationsasasingleOLSfit.Bylemma1,foreachfixedλ theelasticnetproblem
2
isequivalenttoalassoproblemontheaugmenteddataset.SoalgorithmLARScanbedirectly
usedtocreatetheentireelasticnetsolutionpathefficientlywiththecomputationaleffortsofa
singleOLSfit.Note,however,thatforp(cid:1)ntheaugmenteddatasethasp+n‘observations’
andpvariables,whichcanslowthecomputationconsiderably.
Å
We further facilitate the computation by taking advantage of the sparse structure of X ,
which is crucial in the p(cid:1)n case. In detail, as outlined in Efron et al. (2004), at the kth step
Å Å
we need to invert the matrix G Ak =X A T k X Ak , where A k is the active variable set. This is done
efficientlybyupdatingordowndatingtheCholeskyfactorizationofG A thatisfoundatthe
k−1
previousstep.Notethat
1
G = .XTX +λ I/
A 1+λ A A 2
2
for any index set A, so it amounts to updating or downdating the Cholesky factorization of
t i X n o A T g ri k z − t a h 1 X t e io A C n k− h 1 o o + f le X s λ k A T 2 y I k− . f 1 a I X t ct A t o u k r − r i n 1 z s a + t o i λ o u 2 n t I, t o h w f a h X t i w A T ch k e −1 c is X an A ve k u − r 1 y se ( s G a im o si i l m l u a b r pl a t e o n f d o th r V m e a u f n o la r L m t o o u a l n u a , p t 1 d h 9 a a 8 t t e 3 i ) t s . h u T e s h C e e d h e o f x o le a r s c k t u y p sa d fa m a c t e - -

310 H.ZouandT.Hastie
d
λ
o
I
w
.
n
I
d
n
a
a
ti
d
n
d
g
it
f
i
u
o
n
n
c
,
t
w
io
h
n
en
ca
c
n
al
b
c
e
ul
u
a
s
t
e
in
d
g
fo
th
r
e
do
eq
w
u
n
i
d
a
a
n
t
g
i
u
n
l
g
ar
th
v
e
ec
C
t
h
o
o
r
l
a
e
n
sk
d
y
t
f
h
a
e
ct
i
o
n
r
n
i
e
z
r
at
p
io
ro
n
d
o
u
f
ct
X
s
A T
o
k
f
−1
t
X
he
A k
n
−
o
1
n
+
-
2
activepredictorswiththecurrentresiduals,wecansavecomputationsbyusingthesimplefact
Å Å
that X has p−1 zero elements. In a word, we do not explicitly use X to compute all the
j
quantitiesinalgorithmLARS.Itisalsoeconomicaltorecordonlythenon-zerocoefficientsand
theactivevariablessetateachLARS-ENstep.
Algorithm LARS-EN sequentially updates the elastic net fits. In the p(cid:1)n case, such as
withmicroarraydata,itisnotnecessarytorunthealgorithmtotheend(earlystopping).Real
data and simulated computational experiments show that the optimal results are achieved at
anearlystageofalgorithmLARS-EN.Ifwestopthealgorithmaftermsteps,thenitrequires
O.m3+pm2/operations.
3.5. Choiceoftuningparameters
We now discuss how to choose the type and value of the tuning parameter in the elastic
net. Although we defined the elastic net by using .λ ,λ /, it is not the only choice as the
1 2
tuning parameter. In the lasso, the conventional tuning parameter is the L -norm of the
1
coefficients (t) or the fraction of the L -norm (s). By the proportional relationship between
Å 1
βˆ and βˆ , we can also use .λ ,s/ or .λ ,t/ to parameterize the elastic net. The advantage
2 2
of using .λ ,s/ is that s is always valued within [0,1]. In algorithm LARS the lasso is des-
2
cribedasaforwardstagewiseadditivefittingprocedureandshowntobe(almost)identicalto
"-L boosting (Efron et al., 2004). This new view adopts the number of steps k of algorithm
2
LARS as a tuning parameter for the lasso. For each fixed λ , the elastic net is solved by our
2
algorithm LARS-EN; hence similarly we can use the number of the LARS-EN steps .k/ as
the second tuning parameter besides λ . The above three types of tuning parameter corres-
2
pond to three ways to interpret the piecewise elastic net or lasso solution paths as shown in
Fig.3.
Therearewell-establishedmethodsforchoosingsuchtuningparameters(Hastieetal.(2001),
chapter7).Ifonlytrainingdataareavailable,tenfoldcross-validation(CV)isapopularmethod
for estimating the prediction error and comparing different models, and we use it here. Note
that there are two tuning parameters in the elastic net, so we need to cross-validate on a
two-dimensional surface. Typically we first pick a (relatively small) grid of values for λ , say
2
.0,0:01,0:1,1,10,100/. Then, for each λ , algorithm LARS-EN produces the entire solution
2
pathoftheelasticnet.Theothertuningparameter(λ ,s ork)isselectedbytenfoldCV.The
1
chosenλ istheonegivingthesmallestCVerror.
2
For each λ , the computational cost of tenfold CV is the same as 10 OLS fits. Thus two-
2
dimensional CV is computationally thrifty in the usual n>p setting. In the p(cid:1)n case, the
costgrowslinearlywithpandisstillmanageable.Practically,earlystoppingisusedtoeasethe
computationalburden.Forexample,supposethatn=30andp=5000;ifwedonotwantmore
than 200 variables in the final model, we may stop algorithm LARS-EN after 500 steps and
consideronlythebestkwithin500.
Fromnowonwedropthesubscriptofλ ifsorkistheotherparameter.
2
4. Prostatecancerexample
Thedatainthisexamplecomefromastudyofprostatecancer(Stameyetal.,1989).Thepredic-
torsareeightclinicalmeasures:log(cancervolume)(lcavol),log(prostateweight)(lweight),age,
the logarithm of the amount of benign prostatic hyperplasia (lbph), seminal vesicle invasion

|     |     |     |     |     |     | ElasticNet |     | 311 |
| --- | --- | --- | --- | --- | --- | ---------- | --- | --- |
| 8   |     |     |     |     | 8   |            |     |     |
lcavol
| 6   |     |     |     | lcavol | 6   |     |     |     |
| --- | --- | --- | --- | ------ | --- | --- | --- | --- |
svi
lcp
lweight
| stneiciffeoC dezidradnatS |     |     |     | stneiciffeoC dezidradnatS |     |     |     | pgg45 |
| ------------------------- | --- | --- | --- | ------------------------- | --- | --- | --- | ----- |
| 4                         |     |     |     |                           | 4   |     |     |       |
gleason
lbph
lweight svi
|     |     |     |     | pgg45 |     |     |     | age |
| --- | --- | --- | --- | ----- | --- | --- | --- | --- |
| 2   |     |     |     |       | 2   |     |     |     |
lbph
| 0   |     |     |     | gleason | 0   |     |     |     |
| --- | --- | --- | --- | ------- | --- | --- | --- | --- |
age
| 2−  |     |     |     |     | 2−  |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
lcp
|     | 0.0 0.2 | 0.4                      | 0.6 0.8 1.0 |     | 0.0 0.2 | 0.4 0.6                  | 0.8 | 1.0 |
| --- | ------- | ------------------------ | ----------- | --- | ------- | ------------------------ | --- | --- |
|     |         | s = | beta| /max| beta|  |             |     |         | s = | beta| /max| beta|  |     |     |
|     |         | (a)                      |             |     |         | (b)                      |     |     |
(a)Lassoestimatesasafunctionofs and(b)elasticnetestimates(λD1000)asafunctionofs:
Fig.3.
bothestimatesarepiecewiselinear,whichisakeypropertyofourefficientalgorithm;thesolutionpathsalso
showthattheelasticnetisidenticaltounivariatesoftthresholdinginthisexample(· · ·,finalmodelselected)
·
(svi),log(capsularpenetration)(lcp),Gleasonscore(gleason)andpercentageGleasonscore4
or5(pgg45).Theresponseisthelogarithmofprostate-specificantigen(lpsa).
OLS,ridgeregression,thelasso,thena¨ıveelasticnetandtheelasticnetwereallappliedto
thesedata.Theprostatecancerdataweredividedintotwoparts:atrainingsetwith67obser-
vations and a test set with 30 observations. Model fitting and tuning parameter selection by
tenfoldCVwerecarriedoutonthetrainingdata.Wethencomparedtheperformanceofthose
methodsbycomputingtheirpredictionmean-squarederroronthetestdata.
Table 1 clearly shows that the elastic net is the winner among all the competitors in terms
ofbothpredictionaccuracyandsparsity.OLSistheworstmethod.Thena¨ıveelasticnetper-
formsidenticallytoridgeregressioninthisexampleandfailstodovariableselection.Thelasso
includes lcavol, lweight lbph, svi and pgg45 in the final model, whereas the elastic net selects
|     | Table1.          | Prostatecancerdata:comparingdifferentmethods |              |                       |              |                   |     |     |
| --- | ---------------- | -------------------------------------------- | ------------ | --------------------- | ------------ | ----------------- | --- | --- |
|     | Method           |                                              | Parameter(s) | Testmean-squarederror |              | Variablesselected |     |     |
|     | OLS              |                                              |              |                       | 0.586(0.184) | All               |     |     |
|     | Ridgeregression  |                                              | λ=1          |                       | 0.566(0.188) | All               |     |     |
|     | Lasso            |                                              | s=0:39       |                       | 0.499(0.161) | (1,2,4,5,8)       |     |     |
|     | Na¨ıveelasticnet |                                              | λ=1,s=1      |                       | 0.566(0.188) | All               |     |     |
λ=1000,s=0:26
|     | Elasticnet |     |     |     | 0.381(0.105) | (1,2,5,6,8) |     |     |
| --- | ---------- | --- | --- | --- | ------------ | ----------- | --- | --- |

312 H.ZouandT.Hastie
lcavol, lweight, svi, lcp and pgg45. The prediction error of the elastic net is about 24% lower
thanthatofthelasso.WealsoseeinthiscasethattheelasticnetisactuallyUST,becausetheλ
selectedisverybig(1000).Thiscanbeconsideredasapieceofempiricalevidencesupporting
UST.Fig.3displaysthelassoandtheelasticnetsolutionpaths.
Ifwecheckthecorrelationmatrixoftheseeightpredictors,weseethattherearesomemedium
correlations,althoughthehighestis0.76(betweenpgg45andgleason).Wehaveseenthatthe
elasticnetdominatesthelassobyagoodmargin.Inotherwords,thelassoishurtbythehigh
correlation.Weconjecturethat,wheneverridgeregressionimprovesonOLS,theelasticnetwill
improvethelasso.Wedemonstratethispointbysimulationsinthenextsection.
5. Asimulationstudy
Thepurposeofthissimulationistoshowthattheelasticnetnotonlydominatesthelassoin
termsofpredictionaccuracybutalsoisabettervariableselectionprocedurethanthelasso.We
simulatedatafromthetruemodel
|     | y=Xβ+σ", | "∼N.0,1/: |     |     |
| --- | -------- | --------- | --- | --- |
Fourexamplesarepresentedhere.Thefirstthreeexampleswereusedintheoriginallassopaper
(Tibshirani, 1996), to compare the prediction performance of the lasso and ridge regression
systematically.Thefourthexamplecreatesagroupedvariablesituation.
Withineachexample,oursimulateddataconsistofatrainingset,anindependentvalidation
set and an independent test set. Models were fitted on training data only, and the validation
datawereusedtoselectthetuningparameters.Wecomputedthetesterror(themean-squared
error)onthetestdataset.Weusethenotation·=·=·todescribethenumberofobservationsin
thetraining,validationandtestsetrespectively,e.g.20/20/200.Herearethedetailsofthefour
scenarios.
(a) Inexample1,wesimulated50datasetsconsistingof20/20/200observationsandeight
predictors.Weletβ=.3,1:5,0,0,2,0,0,0/andσ=3.Thepairwisecorrelationbetween
| x iandx wassettobecorr.i,j/=0:5             |     | |i−j| |               |     |
| ------------------------------------------- | --- | ----- | ------------- | --- |
| j                                           |     | .     |               |     |
| (b) Example2isthesameasexample1,exceptthatβ |     |       | =0:85forallj. |     |
j
(c) In example 3, we simulated 50 data sets consisting of 100/100/400 observations and 40
predictors.Weset
β=.0,...,0,2,...,2,0,...,0,2,...,2/
|     | (cid:14) (cid:15)(cid:16) | (cid:17) (cid:14) (cid:15)(cid:16) (cid:17) (cid:14) | (cid:15)(cid:16) (cid:17) (cid:14) (cid:15)(cid:16) | (cid:17) |
| --- | ------------------------- | ---------------------------------------------------- | --------------------------------------------------- | -------- |
|     | 10                        | 10                                                   | 10 10                                               |          |
andσ=15;corr.i,j/=0:5foralliandj.
(d) Inexample4wesimulated50datasetsconsistingof50/50/400observationsand40pre-
dictors.Wechose
β=.3,...,3,0,...,0/
|     |     | (cid:14) (cid:15)(cid:16) (cid:17) (cid:14) | (cid:15)(cid:16) (cid:17) |     |
| --- | --- | ------------------------------------------- | ------------------------- | --- |
|     |     | 15                                          | 25                        |     |
andσ=15.ThepredictorsXweregeneratedasfollows:
|            | x =Z +"x                            | Z ∼N.0,1/, | i=1,...,5,   |              |
| ---------- | ----------------------------------- | ---------- | ------------ | ------------ |
|            | i 1                                 | i , 1      |              |              |
|            | x =Z +"x                            | Z ∼N.0,1/, | i=6,...,10,  |              |
|            | i 2                                 | i , 2      |              |              |
|            | x =Z +"x                            | Z ∼N.0,1/, | i=11,...,15, |              |
|            | i 3                                 | i , 3      |              |              |
| x ∼N.0,1/, | x                                   |            |              | i=16,:::,40, |
| i          | iindependentidenticallydistributed, |            |              |              |

ElasticNet 313
Table2. Medianmean-squarederrorsforthesimulatedexamplesand
fourmethodsbasedon50replications†
| Method           |     |            | Resultsforthefollowingexamples: |     |            |            |
| ---------------- | --- | ---------- | ------------------------------- | --- | ---------- | ---------- |
|                  |     | Example1   | Example2                        |     | Example3   | Example4   |
| Lasso            |     | 3.06(0.31) | 3.87(0.38)                      |     | 65.0(2.82) | 46.6(3.96) |
| Elasticnet       |     | 2.51(0.29) | 3.16(0.27)                      |     | 56.6(1.75) | 34.5(1.64) |
| Ridgeregression  |     | 4.49(0.46) | 2.84(0.27)                      |     | 39.5(1.80) | 64.5(4.78) |
| Na¨ıveelasticnet |     | 5.70(0.41) | 2.73(0.23)                      |     | 41.0(2.13) | 45.9(3.72) |
†Thenumbersinparenthesesarethecorrespondingstandarderrors(ofthe
medians)estimatedbyusingthebootstrapwithB=500resamplingsonthe
50mean-squarederrors.
where"x areindependentidenticallydistributedN.0,0:01/,i=1,:::,15:Inthismodel,
i
wehavethreeequallyimportantgroups,andwithineachgrouptherearefivemembers.
There are also 25 pure noise features. An ideal method would select only the 15 true
featuresandsetthecoefficientsofthe25noisefeaturesto0.
Table2andFig.4(boxplots)summarizethepredictionresults.Firstweseethatthena¨ıve
elasticneteitherhasaverypoorperformance(inexample1)orbehavesalmostidenticallyto
eitherridgeregression(inexamples2and3)orthelasso(inexample4).Inalltheexamples,the
elasticnetissignificantlymoreaccuratethanthelasso,evenwhenthelassoisdoingmuchbetter
thanridgeregression.Thereductionsinthepredictionerrorinexamples1,2,3and4are18%,
18%,13%and27%respectively.Thesimulationresultsindicatethattheelasticnetdominates
thelassoundercollinearity.
Table 3 shows that the elastic net produces sparse solutions. The elastic net tends to select
morevariablesthanthelassodoes,owingtothegroupingeffect.Inexample4wheregrouped
selectionisrequired,theelasticnetbehaveslikethe‘oracle’.Theadditional‘groupedselection’
abilitymakestheelasticnetabettervariableselectionmethodthanthelasso.
Hereisanidealizedexampleshowingtheimportantdifferencesbetweentheelasticnetand
thelasso.LetZ andZ betwoindependentU.0,20/variables.Theresponseyisgeneratedas
1 2
N.Z +0:1Z ,1/.Supposethatweobserveonly
1 2
|     | x =Z | +"  | x =−Z | +"  | x =Z | +"  |
| --- | ---- | --- | ----- | --- | ---- | --- |
|     |      | ,   |       | ,   |      | ,   |
|     | 1 1  | 1   | 2 1   | 2   | 3    | 1 3 |
|     | x =Z | +"  | x =−Z | +"  | x =Z | +"  |
|     |      | ,   |       | ,   |      | ,   |
|     | 4 2  | 4   | 5 2   | 5   | 6    | 2 6 |
" N.0,1=16/.
where i are independent identically distributed 100 observations were generated
fromthismodel.Thevariablesx ,x andx formagroupwhoseunderlyingfactorisZ ,and
|        |     | 1   | 2 3 |     |     | 1   |
| ------ | --- | --- | --- | --- | --- | --- |
| x ,x x |     |     |     |     | Z   |     |
4 5 and 6 form a second group whose underlying factor is 2 . The within-group correla-
tionsarealmost1andthebetween-groupcorrelationsarealmost0.Anoraclewouldidentify
theZ -groupastheimportantvariates.Fig.5comparesthesolutionpathsofthelassoandthe
1
elasticnet.
6. Microarrayclassificationandgeneselection
Atypicalmicroarraydatasethasthousandsofgenesandfewerthan100samples.Becauseof
theuniquestructureofthemicroarraydata,wefeelthatagoodclassificationmethodshould
havethefollowingproperties.

314 H.ZouandT.Hastie
51
01
5
0
51
01
5
Lasso Enet Ridge NEnet
(a) (b)
(c) (d)
ESM
Lasso Enet Ridge NEnet
041
021
001
08
06
04
02
ESM
Lasso Enet Ridge NEnet
ESM
051
001
05
0
Lasso Enet Ridge NEnet
ESM
Fig. 4. Comparing the accuracy of prediction of the lasso, the elasic net (Enet), ridge regression and
the na¨ıve elastic net (NEnet) (the elastic net outperforms the lasso in all four examples):(a) example 1;
(b)example2;(c)example3;(d)example4
(a) Geneselectionshouldbebuiltintotheprocedure.
(b) Itshouldnotbelimitedbythefactthatp(cid:1)n.
(c) Forthosegenessharingthesamebiologicalpathway,itshouldbeabletoincludewhole
groupsintothemodelautomaticallyonceonegeneamongthemisselected.
From published results in this domain, it appears that many classifiers achieve similar low
classificationerrorrates.Butmanyofthesemethodsdonotselectgenesinasatisfactoryway.
Most of the popular classifiers fail with respect to at least one of the above properties. The
lassoisgoodat(a)butfailsboth(b)and(c).Thesupportvectormachine(Guyonetal.,2002)
andpenalizedlogisticregression(ZhuandHastie,2004)areverysuccessfulclassifiers,butthey
cannot do gene selection automatically and both use either univariate ranking (Golub et al.,

|     |     |     |     | ElasticNet | 315 |
| --- | --- | --- | --- | ---------- | --- |
Table3. Mediannumberofnon-zerocoefficients
|     | Method     | Resultsforthefollowingexamples: |          |          |     |
| --- | ---------- | ------------------------------- | -------- | -------- | --- |
|     |            | Example1 Example2               | Example3 | Example4 |     |
|     | Lasso      | 5                               | 6 24     | 11       |     |
|     | Elasticnet | 6                               | 7 27     | 16       |     |
| 04  |            |                                 | 04       |          |     |
3
6
5
| stneiciffeoC dezidradnatS |     |     | stneiciffeoC dezidradnatS |     | 13  |
| ------------------------- | --- | --- | ------------------------- | --- | --- |
| 02                        |     |     | 02                        |     |     |
1
|     |     | 4   |     |     | 46  |
| --- | --- | --- | --- | --- | --- |
| 0   |     |     | 0   |     |     |
5
2
| 02− |     |     | 02− |     |     |
| --- | --- | --- | --- | --- | --- |
2
| 0.0 0.2 | 0.4 0.6                  | 0.8 1.0 | 0.0 0.2 | 0.4 0.6                  | 0.8 1.0 |
| ------- | ------------------------ | ------- | ------- | ------------------------ | ------- |
|         | s = | beta| /max| beta|  |         |         | s = | beta| /max| beta|  |         |
|         | (a)                      |         |         | (b)                      |         |
Fig.5. (a)Lassoand(b)elasticnet(λ D0:5)solutionpaths:thelassopathsareunstableand(a)does
2
notrevealanycorrectioninformationbyitself;incontrast,theelasticnethasmuchsmoothersolutionpaths,
whileclearlyshowingthe‘groupedselection’—x,x 1 2 andx 3 areinone‘significant’groupandx 4 ,x 5 andx 6
areintheother‘trivial’group;thedecorrelationyieldsthegroupingeffectandstabilizesthelassosolution
1999)orrecursivefeatureelimination(Guyonetal.,2002)toreducethenumberofgenesinthe
finalmodel.
Asanautomaticvariableselectionmethod,theelasticnetnaturallyovercomesthedifficulty
ofp(cid:1)nandhastheabilitytodogroupedselection.Weusetheleukaemiadatatoillustratethe
elasticnetclassifier.
Theleukaemiadataconsistof7129genesand72samples(Golubetal.,1999).Inthetraining
dataset,thereare38samples,amongwhich27aretype1leukaemia(acutelymphoblasticleu-
kaemia) and 11 are type 2 leukaemia (acute myeloid leukaemia). The goal is to construct a
diagnosticrulebasedontheexpressionlevelofthose7219genestopredictthetypeofleukae-
mia.Theremaining34samplesareusedtotestthepredictionaccuracyofthediagnosticrule.To
applytheelasticnet,wefirstcodedthetypeofleukaemiaasa0–1responsey.Theclassification

316 H.ZouandT.Hastie
function is I.fittedvalue>0:5/, where I.·/ is the indicator function. We used tenfold CV to
selectthetuningparameters.
We used prescreening to make the computation more manageable. Each time that a model
is fitted, we first select the 1000 most ‘significant’ genes as the predictors, according to their
t-statistic
scores (Tibshirani et al., 2002). Note that this screening is done separately in each
trainingfoldintheCV.Inpractice,thisscreeningdoesnotaffecttheresults,becausewestop
41
rorrE noitacifissalcsiM 21
01
8
6
4
2
0
| 0   | 50  | 100 | 150 | 200 |
| --- | --- | --- | --- | --- |
steps
(a)
41
rorrE noitacifissalcsiM 21
s(steps=200)
| 01  |     | = 0.50 |     |     |
| --- | --- | ------ | --- | --- |
8
6
4
2
0
| 0.0 | 0.2 0.4 | 0.6 | 0.8 | 1.0 |
| --- | ------- | --- | --- | --- |
s
(b)
Fig. 6. Leukaemia classification and gene selection by the elastic net (λD0:01):(a) the early stopping
strategyat200stepsfindstheoptimalclassifierwithmuchlesscomputationalcostthan(b)thewholeelastic
netpaths;withearlystopping,thenumberofstepsismuchmoreconvenientthans,thefractionofL -norm,
sincecomputings dependsonthefitatthelaststepofalgorithmLARS-EN;theactualvaluesofs 1
arenot
availableintenfoldCV(+)ifthealgorithmisstoppedearly;onthetrainingset,200stepsareequivalentto
sD0:50(· · ·)
·
Table4. Summaryoftheleukaemiaclassificationresults
| Method                         |     | TenfoldCV | Testerror | Numberof |
| ------------------------------ | --- | --------- | --------- | -------- |
|                                |     | error     |           | genes    |
| Golub                          |     | 3/38      | 4/34      | 50       |
| Supportvectormaching–recursive |     | 2/38      | 1/34      | 31       |
featureelimination
| Penalizedlogisticregression–recursive |     | 2/38 | 1/34 | 26  |
| ------------------------------------- | --- | ---- | ---- | --- |
featureelimination
| Nearestshrunkencentroids |     | 2/38 | 2/34 | 21  |
| ------------------------ | --- | ---- | ---- | --- |
| Elasticnet               |     | 3/38 | 0/34 | 45  |

ElasticNet 317
0 20 40 60 80 100
8.0
6.0
4.0
2.0
0.0
2.0−
4.0−
Steps
stneiciffeoC
dezidradnatS
0 5 10 14 18 22 24 25 30 31 34 37 37 41 41 43 45 45 47 47 52
Fig.7. Leukaemiadata—elasticnetcoefficientspaths(uptokD100):thenumbersonthetopindicatethe
numberofnon-zerocoefficients(selectedgenes)ateachstep;theoptimalelasticnetmodelisgivenbythe
fitatstep82(· ·
·
·)with45selectedgenes;notethatthesizeofthetrainingsetis38,sothelassocanatmost
select38genes;incontrast,theelasticnetselectedmorethan38genes,notlimitedbythesamplesize;
λD0:01ischosenbytenfoldCV;ifabiggerλisused,thegroupingeffectwillbestronger
theelasticnetpathrelativelyearly,atastagewhenthescreenedvariablesareunlikelytobein
themodel.
Alltheprescreening,fittingandtuningweredoneusingonlythetrainingsetandtheclassifi-
cationerrorisevaluatedonthetestdata.
WestoppedalgorithmLARS-ENafter200steps.AscanbeseenfromFig.6,usingthenum-
berofstepsk inthealgorithmasthetuningparameter,theelasticnetclassifier(λ=0:01and
k=82)givesatenfoldCVerrorof3/38andatesterrorof0/34with45genesselected.Fig.7
displaystheelasticnetsolutionpathsandthegeneselectionresults.Table4comparestheelastic
netwithseveralcompetitorsincludingGolub’smethod,thesupportvectormachine,penalized
logistic regression and the nearest shrunken centroid (Tibshirani et al., 2002). The elastic net
givesthebestclassification,andithasaninternal geneselectionfacility.
7. Discussion
Wehaveproposedtheelasticnet,anovelshrinkageandselectionmethod.Theelasticnetpro-
ducesasparsemodelwithgoodpredictionaccuracy,whileencouragingagroupingeffect.The
empiricalresultsandsimulationsdemonstratethegoodperformanceoftheelasticnetandits
superiority over the lasso. When used as a (two-class) classification method, the elastic net
appearstoperformwellonmicroarraydataintermsofthemisclassificationerror,anditdoes
automaticgeneselection.

318 H.ZouandT.Hastie
Althoughourmethodologyismotivatedbyregressionproblems,theelasticnetpenaltycan
beusedinclassificationproblemswithanyconsistent(Zhang,2004)lossfunctions,including
theL
-losswhichwehaveconsideredhereandbinomialdeviance.Somenicepropertiesofthe
2
elasticnetarebetterunderstoodintheclassificationparadigm.Forexample,Fig.6isafamiliar
pictureinboosting:thetesterrorkeepsdecreasingandreachesalongflatregionandthenslightly
increases(Hastieetal.,2001).Thisisnocoincidence.Infactwehavediscoveredthattheelastic
netpenaltyhasacloseconnectionwiththemaximummarginexplanation(Rossetetal.,2004)
tothesuccessofthesupportvectormachineandboosting.ThusFig.6hasanicemargin-based
explanation.Wehavemadesomeprogressinusingtheelasticnetpenaltyinclassification,which
willbereportedinafuturepaper.
Weviewtheelasticnetasageneralizationofthelasso,whichhasbeenshowntobeavaluable
toolformodelfittingandfeatureextraction.Recentlythelassowasusedtoexplainthesuccessof
boosting:boostingperformsahighdimensionallassowithoutexplicitlyusingthelassopenalty
(Hastieetal.,2001;Friedmanetal.,2004).Ourresultsofferotherinsightsintothelasso,and
waystoimproveit.
Acknowledgements
WethankRobTibshiraniandJiZhuforhelpfulcomments,andanAssociateEditorandref-
ereefortheirusefulcommentsandreferences.TrevorHastiewaspartiallysupportedbygrant
DMS-0204162fromtheNationalScienceFoundationandgrantRO1-EB0011988-08fromthe
NationalInstitutesofHealth.HuiZouwassupportedbygrantDMS-0204162fromtheNational
ScienceFoundation.
AppendixA:Proofs
A.1. Proofoflemma2
| A.1.1.      | Part(1)    |                  |     | Å          |     |     |     |     |     |     |
| ----------- | ---------- | ---------------- | --- | ---------- | --- | --- | --- | --- | --- | --- |
| Fixλ>0.Ifβˆ | (cid:4)=βˆ | ,letusconsiderβˆ |     |            |     |     |     |     |     |     |
|             | i j        |                  |     | asfollows: |     |     |     |     |     |     |
(cid:1)
|     |     |     | Å   | βˆ  |     | ifk(cid:4)=iandk(cid:4)=j, |     |     |     |     |
| --- | --- | --- | --- | --- | --- | -------------------------- | --- | --- | --- | --- |
|     |     |     | βˆ  | k   |     |                            |     |     |     |     |
=
|     |     |     | k   | 1.βˆ | +βˆ / | ifk=iork=j. |     |     |     |     |
| --- | --- | --- | --- | ---- | ----- | ----------- | --- | --- | --- | --- |
|     |     |     |     | 2 i  | j     |             |     |     |     |     |
|     |     |     |     | Å    |       | Å           |     |     |     |     |
Becausex =x j,itÅisobviousthatXβˆ =Xβˆ;thus|y−Xβˆ |2=|y−Xβˆ|2:However,J.·/isstrictlycon-
i
vex,sowehaveJ.βˆ /<J.βˆ/.Thereforeβˆcannotbetheminimizerofequation(7),whichisacontradiction.
| Sowemusthaveβˆ |     | =βˆ : |     |     |     |     |     |     |     |     |
| -------------- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
i j
| A.1.2. | Part(2) |     | Å   |     |     | Å   |     |     |     |     |
| ------ | ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Ifβˆβˆ <0,considerthesameβˆ again.Weseethat|βˆ |<|βˆ|,soβˆcannotbealassosolution.Therest
i j
canbedirectlyverifiedbythedefinitionofthelasso,whichisthusomitted.
A.2. Proofoftheorem1
Ifβˆ.λ ,λ /βˆ .λ ,λ />0,thenbothβˆ.λ ,λ /andβˆ .λ ,λ /arenon-zero,andwehavesgn{βˆ.λ ,λ /}=
| i 1       | 2 j 1                           | 2   |     | i 1 | 2   | j 1 2      |     |     | i   | 1 2 |
| --------- | ------------------------------- | --- | --- | --- | --- | ---------- | --- | --- | --- | --- |
| sgn{βˆ .λ | ,λ /}.Becauseofequation(4),βˆ.λ |     |     |     | ,λ  | /satisfies |     |     |     |     |
| j         | 1 2                             |     |     |     | 1   | 2          |     |     |     |     |
(cid:2)
|     |     | @L.λ | ,λ  | ,β/(cid:2) |     |     |     |     |     |     |
| --- | --- | ---- | --- | ---------- | --- | --- | --- | --- | --- | --- |
(cid:2)
|     |     |     | 1   | 2 (cid:2) |       | =0  | ifβˆ .λ ,λ | /(cid:4)=0: |     | .17/ |
| --- | --- | --- | --- | --------- | ----- | --- | ---------- | ----------- | --- | ---- |
|     |     |     | @ β |           |       |     | k 1        | 2           |     |      |
|     |     |     | k   | β=βˆ.λ    | 1,λ / |     |            |             |     |      |
2
Hencewehave
|     |     | −2xT{y−Xβˆ.λ |     | ,λ /}+λ | sgn{βˆ.λ | ,λ    | /}+2λ | βˆ.λ ,λ /=0, |     | .18/ |
| --- | --- | ------------ | --- | ------- | -------- | ----- | ----- | ------------ | --- | ---- |
|     |     | i            |     | 1 2     | 1        | i 1 2 | 2     | i 1 2        |     |      |

|     |              |     |     |         |        |     |          |     | ElasticNet    | 319  |
| --- | ------------ | --- | --- | ------- | ------ | --- | -------- | --- | ------------- | ---- |
|     | −2xT{y−Xβˆ.λ |     |     | ,λ /}+λ | sgn{βˆ | .λ  | ,λ /}+2λ |     | βˆ .λ ,λ /=0: | .19/ |
|     |              | j   |     | 1 2     | 1      | j   | 1 2      | 2   | j 1 2         |      |
Subtractingequation(18)fromequation(19)gives
|     |     | .xT−xT/{y−Xβˆ.λ |     |     | ,λ /}+λ | {βˆ.λ | ,λ /−βˆ | .λ  | ,λ /}=0, |     |
| --- | --- | --------------- | --- | --- | ------- | ----- | ------- | --- | -------- | --- |
|     |     |                 |     |     |         | i     |         | j   |          |     |
|     |     | j               | i   |     | 1 2     | 2     | 1 2     |     | 1 2      |     |
whichisequivalentto
1
|     |     |     | βˆ.λ ,λ | /−βˆ | .λ ,λ | /= .xT−xT/rˆ.λ |     |     | ,λ /, | .20/ |
| --- | --- | --- | ------- | ---- | ----- | -------------- | --- | --- | ----- | ---- |
|     |     |     | i 1     | 2    | j 1   | 2 λ            | i j | 1   | 2     |      |
2
whererˆ.λ ,λ /=y−xβˆ.λ ,λ /istheresidualvector.SinceXarestandardized,|x −x |2=2.1−ρ/where
| 1 2 |     | 1   | 2   |     |     |     |     |     | i j |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
ρ=x Tx :Byequation(4)wemusthave
i j
|     |     |     | L{λ | ,λ ,βˆ.λ | ,λ  | /}(cid:1)L.λ | ,λ ,β=0/, |     |     |     |
| --- | --- | --- | --- | -------- | --- | ------------ | --------- | --- | --- | --- |
|     |     |     |     | 1 2      | 1   | 2            | 1 2       |     |     |     |
i.e.
|βˆ.λ
|     |     | |rˆ.λ | ,λ  | /|2+λ | |βˆ.λ ,λ | /|2+λ |     | ,λ /| | (cid:1)|y|2: |     |
| --- | --- | ----- | --- | ----- | -------- | ----- | --- | ----- | ------------ | --- |
|     |     |       | 1   | 2     | 2 1      | 2     | 1   | 1 2 1 |              |     |
So|rˆ.λ ,λ /|(cid:1)|y|.Thenequation(20)impliesthat
1 2
|     |     |     |              | 1   | |rˆ.λ ,λ | /|      |          | 1 √       |     |     |
| --- | --- | --- | ------------ | --- | -------- | ------- | -------- | --------- | --- | --- |
|     |     | D   | .i,j/(cid:1) |     | 1        | 2 |x −x | |(cid:1) | {2.1−ρ/}: |     |     |
|     |     |     | λ 1,λ        | λ   | | y|     | i       | j λ      |           |     |     |
|     |     |     | 2            | 2   |          |         |          | 2         |     |     |
A.3. Proofoftheorem2
Letβˆbetheelasticnetestimates.Bydefinitionandequation(10)wehave
|     |     |           | (cid:2)   |     |     | (cid:2)    |     | (cid:2)   | (cid:2)   |     |
| --- | --- | --------- | --------- | --- | --- | ---------- | --- | --------- | --------- | --- |
|     |     |           | (cid:2)   |     | β   | (cid:2) 2  | λ   | (cid:2)   | β (cid:2) |     |
|     |     |           | (cid:2)   | Å Å |     | (cid:2)    | 1   | (cid:2)   | (cid:2)   |     |
|     |     | βˆ=argmin | (cid:2) y | −X  | √   | (cid:2) +√ |     | (cid:2) √ | (cid:2)   |     |
.1 +λ / .1+λ / .1+λ /
|     |     |           | β   | (cid:3) | (cid:4) | 2    |     | 2     | 2 1     |      |
| --- | --- | --------- | --- | ------- | ------- | ---- | --- | ----- | ------- | ---- |
|     |     |           |     | Å       | Å       |      | Å Å |       |         |      |
|     |     |           |     | X       | TX      | y    | TX  | Å     | Å λ |β| |      |
|     |     | =argminβT |     |         | β−2√    |      |     | +y Ty | + 1 1:  | .21/ |
|     |     |           |     | 1+λ     |         | .1+λ | /   |       | 1+λ     |      |
|     |     |           | β   |         | 2       |      | 2   |       | 2       |      |
Substitutingtheidentities
|     |     |     |     |     |      | (cid:3) | (cid:4) |     |     |     |
| --- | --- | --- | --- | --- | ---- | ------- | ------- | --- | --- | --- |
|     |     |     |     |     | Å Å  | XTX+λ   |         |     |     |     |
|     |     |     |     | X   | TX = |         | 2 ,     |     |     |     |
1+λ
2
yTX
|     |     |     |     |     | y Å TX Å | =√  |     |     |     |     |
| --- | --- | --- | --- | --- | -------- | --- | --- | --- | --- | --- |
,
|     |     |     |     |     |     | .1+λ | /   |     |     |     |
| --- | --- | --- | --- | --- | --- | ---- | --- | --- | --- | --- |
2
|     |     |     |     |     | y Å Ty | Å =yTy |     |     |     |     |
| --- | --- | --- | --- | --- | ------ | ------ | --- | --- | --- | --- |
intoequation(21),wehave
|     |     |     |     | (cid:1) | (cid:3) | (cid:4) |     |     | (cid:5) |     |
| --- | --- | --- | --- | ------- | ------- | ------- | --- | --- | ------- | --- |
|     |     |     |     |         | XTX+λ   | I       |     |     |         |     |
1
|     | βˆ=argmin |           |           | βT    |             | 2   | β−2yTXβ+λ |       | |β| +yTy |     |
| --- | --------- | --------- | --------- | ----- | ----------- | --- | --------- | ----- | -------- | --- |
|     |           |           | 1+        | λ     | 1+λ         |     |           |       | 1 1      |     |
|     |           |           | β (cid:3) | 2     | (cid:4)     | 2   |           |       |          |     |
|     |           |           |           | XTX+λ | I           |     |           |       |          |     |
|     |           | =argminβT |           |       | 2 β−2yTXβ+λ |     |           | |β| : |          |     |
|     |           |           |           | 1+λ   |             |     |           | 1 1   |          |     |
|     |           |           | β         |       | 2           |     |           |       |          |     |
References
Breiman,L.(1996)Heuristicsofinstabilityandstabilizationinmodelselection.Ann.Statist.,24,2350–2383.
Dettling,M.andBu¨hlmann,P.(2004)Findingpredictivegenegroupsfrommicroarraydata.J.Multiv.Anal.,90,
106–131.
D´ıaz-Uriarte, R. (2003) A simple method for finding molecular signatures from gene expression data. Tech-
nical Report. Spanish National Cancer Center. (Available from http://www.arxiv.org/abs/q-bio.
QM/0401043.)
Donoho,D.L.,Johnstone,I.M.,Kerkyacharian,G.andPicard,D.(1995)Waveletshrinkage:asymptopia(with
discussion)?J.R.Statist.Soc.B,57,301–369.
Efron,B.,Hastie,T.,Johnstone,I.andTibshirani,R.(2004)Leastangleregression.Ann.Statist.,32,407–499.

320 H.ZouandT.Hastie
Fan,J.andLi,R.(2001)Variableselectionvianonconcavepenalizedlikelihoodanditsoracleproperties.J.Am.
Statist.Ass.,96,1348–1360.
Frank,I.andFriedman,J.(1993)Astatisticalviewofsomechemometricsregressiontools.Technometrics,35,
109–148.
Friedman,J.(1989)Regularizeddiscriminantanalysis.J.Am.Statist.Ass.,84,249–266.
Friedman,J.,Hastie,T.,Rosset,S.,Tibshirani,R.andZhu,J.(2004)Discussionofboostingpapers.Ann.Statist.,
32,102–107.
Fu,W.(1998)Penalizedregression:thebridgeversusthelasso.J.ComputnlGraph.Statist.,7,397–416.
Golub,G.andVanLoan,C.(1983)MatrixComputations.Baltimore:JohnsHopkinsUniversityPress.
Golub,T.,Slonim,D.,Tamayo,P.,Huard,C.,Gaasenbeek,M.,Mesirov,J.,Coller,H.,Loh,M.,Downing,J.and
Caligiuri,M.(1999)Molecularclassificationofcancer:classdiscoveryandclasspredictionbygeneexpression
monitoring.Science,286,513–536.
Guyon,I.,Weston,J.,Barnhill,S.andVapnik,V.(2002)Geneselectionforcancerclassificationusingsupport
vectormachines.Mach.Learn.,46,389–422.
Hastie,T.,Tibshirani,R.,Botstein,D.andBrown,P.(2003)Supervisedharvestingofexpressiontrees.Genome
Biol.,2,0003.1–0003.12.
Hastie,T.,Tibshirani,R.,Eisen,M.,Brown,P.,Ross,D.,Scherf,U.,Weinstein,J.,Alizadeh,A.,Staudt,L.and
Botstein,D.(2000)‘Geneshaving’asamethodforidentifyingdistinctsetsofgeneswithsimilarexpression
patterns.GenomeBiol.,1,1–21.
Hastie,T.,Tibshirani,R.andFriedman,J.(2001)TheElementsofStatisticalLearning;DataMining,Inference
andPrediction.NewYork:Springer.
Hoerl,A.andKennard,R.(1988)Ridgeregression.InEncyclopediaofStatisticalSciences,vol.8,pp.129–136.
NewYork:Wiley.
Rosset,S.,Zhu,J.andHastie,T.(2004)Boostingasaregularizedpathtoamaximummarginclassifier.J.Mach.
Learn.Res.,5,941–973.
Segal,M.,Dahlquist,K.andConklin,B.(2003)Regressionapproachformicroarraydataanalysis.J.Computnl
Biol.,10,961–980.
Stamey,T.,Kabalin,J.,McNeal,J.,Johnstone,I.,Freiha,F.,Redwine,E.andYang,N.(1989)Prostatespecific
antigeninthediagnosisandtreatmentofadenocarcinomaoftheprostateii:radicalprostatectomytreated
patients.J.Urol.,16,1076–1083.
Tibshirani,R.(1996)Regressionshrinkageandselectionviathelasso.J.R.Statist.Soc.B,58,267–288.
Tibshirani,R.,Hastie,T.,Narasimhan,B.andChu,C.(2002)Diagnosisofmultiplecancertypesbyshrunken
centroidsofgeneexpression.Proc.Natn.Acad.Sci.USA,99,6567–6572.
Tusher, V., Tibshirani, R. and Chu, C. (2001) Significance analysis of microarrays applied to transcriptional
responsestoionizingradiation.Proc.Natn.Acad.Sci.USA,98,5116–5121.
West,M.,Blanchettem,C.,Dressman,H.,Huang,E.,Ishida,S.,Spang,R.,Zuzan,H.,Marks,J.andNevins,J.
(2001)Predictingtheclinicalstatusofhumanbreastcancerusinggeneexpressionprofiles.Proc.Natn.Acad.
Sci.USA,98,11462–11467.
Zhang,T.(2004)Statisticalbehaviorandconsistencyofclassificationmethodsbasedonconvexriskminimization.
Ann.Statist.,32,469–475.
Zhu,J.andHastie,T.(2004)Classificationofgenemicroarraysbypenalizedlogisticregression.Biostatistics,5,
427–444.
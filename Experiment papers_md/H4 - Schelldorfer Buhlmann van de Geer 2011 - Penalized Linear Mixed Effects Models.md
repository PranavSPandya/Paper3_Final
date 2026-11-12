ScandinavianJournalofStatistics,Vol.38:197–214,2011
doi:10.1111/j.1467-9469.2011.00740.x
©
2011BoardoftheFoundationoftheScandinavianJournalofStatistics.PublishedbyBlackwellPublishingLtd.
| Estimation |               | for High-Dimensional |        |       |     |
| ---------- | ------------- | -------------------- | ------ | ----- | --- |
| Linear     | Mixed-Effects |                      | Models | Using |     |
(cid:2)
-Penalization
1
| JÜRG SCHELLDORFER, |                | PETER  | BÜHLMANN | and SARA | VAN DE GEER |
| ------------------ | -------------- | ------ | -------- | -------- | ----------- |
| Seminar für        | Statistik, ETH | Zurich |          |          |             |
ABSTRACT.Weproposean(cid:2) -penalizedestimationprocedureforhigh-dimensionallinearmixed-
1
effects models. The models are useful whenever there is a grouping structure among high-
dimensional observations, that is, for clustered data. We prove a consistency and an oracle
optimalityresultandwedevelopanalgorithmwithprovablenumericalconvergence.Furthermore,
wedemonstratetheperformanceofthemethodonsimulatedandarealhigh-dimensionaldataset.
Keywords: adaptiveLasso,coordinategradientdescent,coordinatewiseoptimization,Lasso,
random-effectsmodel,variableselection,variancecomponents
1. Introduction
1.1. High-dimensional statistical inference: some known results for convex loss functions
Substantial progress has been achieved over the last decade in high-dimensional statistical
inference where the number of parameters p is allowed to be of much larger order than
samplesizen.Tofixideas,supposewefocusonestimationofap-dimensionalparameter(cid:2)
0
noisyobservationswherep(cid:2)n.Althoughsuchaproblemisill-posedingeneral,
basedonn
itcanbeaccuratelysolvediftheunderlyingtruestructureof(cid:2) issparse.Here,sparsitymay
|     |     |     | (cid:2)                             | 0               |     |
| --- | --- | --- | ----------------------------------- | --------------- | --- |
|     |     | `   | (cid:3)(cid:2)(cid:3) =( p |(cid:2) | |r)1/r (0≤r<∞). |     |
be measured in terms of the r -norm r j=1 j Very roughly speak-
ing, high-dimensional statistical inference is possible, in the sense of leading to reasonable
| accuracy or             | asymptotic consistency, | if  |     |     |     |
| ----------------------- | ----------------------- | --- | --- | --- | --- |
| log(p)·sparsity((cid:2) | )(cid:3)(cid:6)n,       |     |     |     |     |
0
|     | (cid:3)=2 | (cid:3)=1 |     |     |     |
| --- | --------- | --------- | --- | --- | --- |
where typically [cf. (1)] or [cf. (2)], and assuming that the underlying (e.g. regres-
| sion) design | behaves reasonably. |     |     |     |     |
| ------------ | ------------------- | --- | --- | --- | --- |
A lot of attention has been devoted to high-dimensional linear models
| y=X(cid:2) | +(cid:3), |     |     |     |     |
| ---------- | --------- | --- | --- | --- | --- |
0
with n×p design matrix X and p(cid:2)n. A very popular and powerful estimation method
is the Lasso, proposed by Tibshirani (1996). It is an acronym for least absolute shrinkage
and selection operator and the name indicates that the method does some variable selection
in the sense that some of the regression coefficient estimates are exactly zero. Among the
main reasons why it has become very popular for high-dimensional estimation problems are
its statistical accuracy for prediction and variable selection coupled with its computational
feasibilitywhichinvolvesconvexoptimizationonly.Thelatterisinsharpcontrasttoexhaus-
tive variable selection based on least squares estimation whose computational complexity is
in general exponential in p. The statistical properties of the Lasso in high-dimensional set-
tings have been worked out in numerous articles. Without (essentially) a condition on the
| design X, | the Lasso satisfies: |     |     |     |     |
| --------- | -------------------- | --- | --- | --- | --- |
This paper is based on a plenary presentation at NORDSTAT Meeting in Voss Norway, June 2010.

| 198 | J. Schelldorfer | et  | al. |     |     |     | ScandJStatist38 |
| --- | --------------- | --- | --- | --- | --- | --- | --------------- |
(cid:3)
(cid:3)X((cid:2)ˆ−(cid:2) )(cid:3)2/n=O ((cid:3)(cid:2) (cid:3) log(p)/n), (1)
|     | 0   | 2 P | 0 1 |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
where O (·) is with respect to(cid:3)p≥n→∞ (Bühlmann & van de Geer, 2011). That is, if the
P
model is sparse with (cid:3)(cid:2) (cid:3) (cid:6) log(p)/n, we obtain consistency. Such kind of a result has
0 1
beenprovedbyGreenshtein&Ritov(2004).Later,optimalityhasbeenestablishedwhere(1)
| is improved | to  |     |     |     |     |     |     |
| ----------- | --- | --- | --- | --- | --- | --- | --- |
(cid:4)−2log(p)/n),
| (cid:3)X((cid:2)ˆ−(cid:2) | )(cid:3)2/n=O |     | (s  |     |     |     |     |
| ------------------------- | ------------- | --- | --- | --- | --- | --- | --- |
|                           | 0             | 2 P | 0   |     |     |     |     |
and furthermore
(cid:3)
| (cid:3)(cid:2)ˆ−(cid:2) | =O      | (s1/r(cid:4)−2 |            |          |     |     |     |
| ----------------------- | ------- | -------------- | ---------- | -------- | --- | --- | --- |
|                         | (cid:3) |                | log(p)/n), | r∈{1,2}, |     |     | (2) |
0 r P 0
wheres equalsthenumberofnon-zerocoefficientsand(cid:4)2 denotesarestrictedeigenvalueof
0
X
the design matrix (Bühlmann & van de Geer, 2011). The rate in (2) is optimal up to the
log(p) factor and the restricted eigenvalue (cid:4)2: oracle least squares estimation where the rel-
evant variables would be known would have rate O (s /n). We emphasize that for obtaining
|     |     |     |     |     | P 0 |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
optimal convergence rates as in (2), we need to make some assumptions on the design that
(cid:4)2 is not getting too small as p≥n→∞, something we do not require in (1). Works dealing
with various aspects around (2) include Bunea et al. (2007), van de Geer (2008), Zhang &
| Huang | (2008), | Meinshausen | & Yu (2009) | and Bickel | et al. (2009). |     |     |
| ----- | ------- | ----------- | ----------- | ---------- | -------------- | --- | --- |
A quite different problem is variable selection for inferring the true underlying active set
| ={1≤k≤p:(cid:2) |     | =/0}. |                    | Sˆ={1≤k≤p: |     | (cid:2)ˆ =/0}         |     |
| --------------- | --- | ----- | ------------------ | ---------- | --- | --------------------- | --- |
| S               |     |       | A simple estimator | is         |     | where no significance |     |
| 0               |     | 0,k   |                    |            |     | k                     |     |
testing is involved. Meinshausen & Bühlmann (2006) show for the Lasso that under the
so called neighbourhood stability condition for the design, the Lasso does consistent vari-
| able selection | in          | the sense | that |     |     |     |     |
| -------------- | ----------- | --------- | ---- | --- | --- | --- | --- |
| P[Sˆ=S         | ]→1(p≥n→∞), |           |      |     |     |     | (3) |
0
assuming that the non-zero(cid:3)coefficients in S are sufficiently large in absolute value, for ex-
0
ample, min |(cid:2) |(cid:2)(cid:4)−2 s log(p)/n which is the rate in (2) for r=2. The neighbourhood
|     | k∈S0 | 0,k | 0   |     |     |     |     |
| --- | ---- | --- | --- | --- | --- | --- | --- |
stability condition is equivalent to the irrepresentable condition used in Zhao & Yu (2006),
and they are both sufficient and (essentially) necessary for consistent model selection as in
(3). Unfortunately, the neighbourhood stability and the irrepresentable condition are rather
restrictiveandmanydesignsX wouldviolatethem.Incaseof(weaker)restrictiveeigenvalue
conditions, one still has the variable screening property for the Lasso
| P[Sˆ⊇S | ]→1 | (p≥n→∞), |     |     |     |     |     |
| ------ | --- | -------- | --- | --- | --- | --- | --- |
|        | 0   |          |     |     |     |     | (4) |
again assuming that the non-zero coefficients in S are sufficiently large in absolute value.
0
Equation (4) says that the Lasso does not miss a relevant variable from S ; in addition, for
0
theLasso,thecardinality|Sˆ|≤min(n,p)andhence,forp(cid:2)n,weachieveahugedimension-
ality reduction in (4). The adaptive Lasso, proposed by Zou (2006) is a two-stage method
which achieves (3) under a weaker restrictive eigenvalue assumption than the irrepresentable
condition (Huang et al., 2008; van de Geer et al., 2010). We summarize the basic facts in
Table 1. Moreover, everything essentially holds in an analogous way when using the Lasso
`
in generalized linear models, that is, 1 -norm penalization of the negative log-likelihood
(vandeGeer,2008).Finally,wenotethatBickeletal.(2009)proveequivalenttheoreticalbe-
haviouroftheLassoandtheDantzigselector(Candes&Tao,2007)intermsof(2),exempli-
fying that properties like (2) hold for other estimators than the Lasso as well.
Having some variable screening property as in (4), we can reduce the false positive
selections by various methods, besides the adaptive Lasso mentioned above, including also
stability selection (Meinshausen & Bühlmann, 2010) based on subsampling or via assigning
p-values (Meinshausen et al., 2009; Wasserman & Roeder, 2009) based on sample splitting.
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

ScandJStatist38 High-dimensional mixed-effects models 199
Table 1. Properties of the Lasso and required conditions to achieve them. Restricted eigenvalue
assumption is weaker than the neighbourhood stability or irrepresentable condition (van de Geer
& Bühlmann, 2009). For the adaptive Lasso: variable selection as in (3) can be achieved under
restricted eigenvalue conditions
Property Design condition Size of non-zero coefficients
Consistency as in (1) No requirement No requirement
Fast convergence rate as in (2) Restricted eigenvalue No requirement
Variable selection as in (3) Neighbourhood stability Sufficiently large
⇔ irrepresentable condition
Variable screening as in (4) Restricted eigenvalue Sufficiently large
Regarding computation, the Lasso involves convex optimization. Popular algorithms are
based on the homotopy method (Osborne et al., 2000) such as LARS (Efron et al., 2004).
Morerecently,ithasbeenarguedthatthecoordinategradientdescentapproach(inaGauss–
Seidel manner) is typically more efficient (Meier et al., 2008; Wu & Lange, 2008; Friedman
et al., 2010).
1.2. High-dimensional linear mixed-effects models with non-convex loss function
The underlying assumption that all observations are independent is not always appropri-
ate. We consider here linear mixed-effects models (Laird & Ware, 1982; Pinheiro & Bates,
2000; Verbeke & Molenberghs, 2000; Demidenko, 2004) where high-dimensional data incor-
porate a grouping structure with independent observations between and dependence within
groups. Mixed-effects models, including random besides fixed effects, are a popular exten-
sionoflinearmodelsinthatdirection.Forexample,manyapplicationsconcernlongitudinal
data where the random effects vary between groups and thereby induce a dependence struc-
turewithingroups.Itisacrucialandimportantquestionhowtocopewithhigh-dimensional
linear mixed-effects models. Surprisingly, for this problem, there is no established procedure
which is well understood in terms of statistical properties.
Themaindifficultyarisesfromnon-convexityofthenegativelog-likelihoodfunctionwhich
makes computation and theory very challenging. We are presenting some methodology,
computation and theory for ` -norm penalized maximum likelihood estimation in linear
1
mixed-effects models where the number of fixed effects may be much larger than the overall
samplesizebutthenumberofcovarianceparametersoftherandomeffectspartbeingsmall.
Basedonaframeworkfor` -penalizationofsmoothbutnon-convexnegativelog-likelihood
1
functions(Städleretal.,2010),wedevelopinsection3analoguesof(1),(2)and(4),seealso
Table 1, and some properties of an adaptively ` -penalized estimator. In our view, these are
1
the key properties in high-dimensional statistical inference in any kind of model. For exam-
ple, with (4) at hand, p-values for single fixed-effects coefficients could be constructed along
thelinesofMeinshausenetal.(2009),controllingthefamilywiseerrororfalsediscoveryrate
(but we do not apply such a method in this article). Furthermore, we design in section 4
an efficient coordinate gradient descent algorithm for linear mixed-effects models which is
proved to converge numerically to a stationary point of the corresponding non-convex opti-
mization problem.
We remark that we focus here on the case where it is prespecified which covariates are
modelled with a random effect and which are not. In some situations, this is fairly realis-
tic: for example, a random intercept model is quite popular and often leads to a reasonable
model fit. Without prespecification of the covariates having a random effect, one could do
variable selection based on penalized likelihood approaches on the level of random effects:
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

| 200 J. Schelldorfer | et al. |     |     |     |     | ScandJStatist38 |
| ------------------- | ------ | --- | --- | --- | --- | --------------- |
this has been developed from a methodological and computational perspective by Bondell
et al. (2010) and Ibrahim et al. (2010) for low-dimensional settings. Addressing such prob-
lems in the truly high-dimensional scenario is beyond the scope of this article. However, we
present in section 6 a real high-dimensional data problem where some exploratory analy-
sis is used for deciding which covariates are to be modelled with a random effect. This ex-
ample also illustrates empirically that there is a striking improvement if we incorporate
random effects into the model, in comparison with a high-dimensional linear model fit.
The rest of this article is organized as follows. In section 2, we define the ` -penalized
1
linear mixed-effects estimator. In section 3, we present the theoretical results for this esti-
mator before describing the details of a computational algorithm in section 4. After some
simulations in section 5 we apply the procedure to a real data set. The technical proofs are
deferred to an Appendix in the online Supporting Information on the journal website.
| 2. Linear mixed-effects | models | and (cid:2) | 1-penalized | estimation |     |     |
| ----------------------- | ------ | ----------- | ----------- | ---------- | --- | --- |
| 2.1. High-dimensional   | model  | set-up      |             |            |     |     |
We assume that the observations are inhomogeneous in the sense that they are not indepen-
dent, but grouped. Let i=1,...,N be the grouping index and j=1,...,n the observation
|     |     |     | (cid:2) |     | i   |     |
| --- | --- | --- | ------- | --- | --- | --- |
|     |     |     | = N     |     |     |     |
index within a group. Denote by N n the total number of observations. For each
|     |     |     | T i=1 | i   |     |     |
| --- | --- | --- | ----- | --- | --- | --- |
group,weobserveann ×1vectorofresponsesy,andletX beann ×pfixed-effectsdesign
|         | i   |     |     | i i | i   |     |
| ------- | --- | --- | --- | --- | --- | --- |
| (cid:2) | p×1 |     |     |     | ×q  |     |
matrix, a vector of fixed regression coefficients, Z i an n i random-effects design
matrix and b a group-specific vector of random regression coefficients.
i
Using the notation from Pinheiro & Bates (2000), the model can be written as:
| =X(cid:2)+Zb | i=1,...,N, |     |     |     |     |     |
| ------------ | ---------- | --- | --- | --- | --- | --- |
| y            | +(cid:3)   |     |     |     |     | (5) |
| i i          | i i i      |     |     |     |     |     |
assuming that
| (i) (cid:3) ∼N             | (0,(cid:5)2I ) and | uncorrelated     | for        | i=1,...,N, |     |     |
| -------------------------- | ------------------ | ---------------- | ---------- | ---------- | --- | --- |
| i                          | ni ni              |                  |            |            |     |     |
| ∼N                         | (0,(cid:2))        |                  | i=1,...,N, |            |     |     |
| (ii) b                     | and uncorrelated   |                  | for        |            |     |     |
| i                          | q                  |                  |            |            |     |     |
| (iii) (cid:3) ,...,(cid:3) | ,b ,...,b          | are independent. |            |            |     |     |
| 1                          | N 1 N              |                  |            |            |     |     |
Here, (cid:2)=(cid:2) is a general covariance matrix where (cid:4) is an unconstrained set of parameters
(cid:4)
|     | q∗) | (cid:2) |     |     |     |     |
| --- | --- | ------- | --- | --- | --- | --- |
(with dimension such that (cid:4) is positive definite (i.e. by using the Cholesky decompo-
sition). Possible structures for (cid:2) may be a multiple of the identity, a diagonal or a general
positive definite matrix. We would like to remark that assumption (i) can be generalized to
=(cid:3)((cid:5))foraparametervector(cid:5).Thisgeneralizationstillfitsinto
| (i’)(cid:3) ∼N (0,(cid:5)2(cid:3))with(cid:3) |     |     |     |     |     |     |
| --------------------------------------------- | --- | --- | --- | --- | --- | --- |
| i ni                                          | i   | i i |     |     |     |     |
the theoretical framework presented in section 3. Nonetheless, for the sake of notational
simplicity, we restrict ourselves to assumption (i). As indicated by the index i, the b i are
different among the groups. All observations have the coefficient (cid:2) in common whereas the
value of b depends on the group that the observation belongs to. In other words, for each
i
fromtheoveralleffects(cid:2).Weassumethroughout
grouptherearegroup-specificdeviationsb
i
the article that the design matrices X and Z are deterministic, that is, fixed design. The
|     |     |     | i   | i   |     |     |
| --- | --- | --- | --- | --- | --- | --- |
case with random design does neither change the methodology (i.e. we can use the same
methods presented next) nor alter much the theory, although the latter needs an adaptation
| of mathematical | arguments. |     |     |     |     |     |
| --------------- | ---------- | --- | --- | --- | --- | --- |
Weallowthatthenumberpoffixed-effectsregressioncoefficientsmaybemuchlargerthan
thetotalnumberofobservations,thatis,N (cid:6)p.Furthermore,thenumberqofrandom-effects
T
|     |     | q≤p, |     | q∗  |     |     |
| --- | --- | ---- | --- | --- | --- | --- |
variables might be as large as but the dimension of the variance–covariance para-
metersisassumedtobesmall(q∗(cid:6)N ).Weaimatestimatingthefixedregressionparameter
T
vector (cid:2), the random effects b and the variance–covariance parameters (cid:4) and (cid:5)2. Therefore,
i
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

ScandJStatist38 High-dimensional mixed-effects models 201
(cid:6)˜ :=((cid:2)T,(cid:4)T,(cid:5)2)T definesthecompleteparametervectorwithatmostlengthp+q(q+1)/2+1.
From model (5) we deduce that y ,...,y are independent and y ∼N (X(cid:2),V((cid:4),(cid:5)2)) with
1 N i ni i i
V
i
((cid:4),(cid:5)2)=Z
i
(cid:2) (cid:4)ZT
i
+(cid:5)2I
ni
. Denote the stacked vectors y=(y
1
T,...,y
N
T)T, b=(b
1
T,...,b
N
T)T,
(cid:3)=((cid:3)T,...,(cid:3)T)T and the stacked matrices X=(XT,...,XT)T, Z=diag(Z ,...,Z ) and
1 N 1 N 1 N
V=diag(V ,...,V ). Then model (5) can be written as:
1 N
y=X(cid:2)+Zb+(cid:3) (6)
and the negative log-likelihood is given by
−`((cid:6)˜ )=−`((cid:2),(cid:4),(cid:5)2)= 1 {N log(2(cid:6))+log|V|+(y−X(cid:2))TV−1(y−X(cid:2))}, (7)
2 T
where |V|=det(V).
2.2. ` -penalized maximum likelihood estimator
1
Because of the possibly large number of covariates (N (cid:6)p setting), we cannot use the clas-
T
sicalmaximumlikelihoodorrestrictedmaximumlikelihood(REML)approach.Assumethat
thefixedregressioncoefficientsaresparseinthesensethatmanyparametersarezero.Wethen
attenuate these difficulties by adding an ` -penalty on the fixed regression coefficients. By
1
doing so, we achieve a sparse solution with respect to the fixed effects. This leads us to
consider the following objective function:
(cid:4)p
1 1
Q(cid:7)((cid:2),(cid:4),(cid:5)2):=
2
log|V|+
2
(y−X(cid:2))TV−1(y−X(cid:2))+(cid:7) |(cid:2)
k
|, (8)
k=1
where(cid:7)isanon-negativeregularizationparameter.Consequently,weestimatethefixedregres-
sion coefficient vector (cid:2) and the variance components (cid:4) and (cid:5)2 by
(cid:6)ˆ˜=((cid:2)ˆ,(cid:4)ˆ,(cid:5)ˆ2)= argmin Q(cid:7)((cid:2),(cid:4),(cid:5)2). (9)
(cid:2),(cid:4),(cid:5)2>0,(cid:2)>0
Forfixedvarianceparameters(cid:4)and(cid:5)2,theminimizationwithrespectto(cid:2)isaconvexopti-
mization problem. Since we want to make use of this convexity (see section 4), we do not
profile the likelihood function, as usually performed in the mixed-effects model framework
(Pinheiro & Bates, 2000). However, with respect to the full parameter vector
(cid:6)˜
, we have a
non-convex objective function and hence, we have to deal with a non-convex problem. This
requires a more general framework in theory as well as in computation. In the following
sections, we discuss how to address this issue.
2.3. Prediction of the random-effects coefficients
Wepredicttherandom-effectscoefficientsb,i=1,...,N bythemaximumaposteriori(MAP)
i
principle. Denoting by f the density of the corresponding Gaussian random variable, we
define
˜ b =argmaxf(b |y ,...,y ,(cid:2),(cid:4),(cid:5)2)=argmaxf(b |y,(cid:2),(cid:4),(cid:5)2)
i i 1 N i i
bi bi
f(y |b,(cid:2),(cid:5)2)·f(b |(cid:4))
=argmax i i i
f(y |(cid:2),(cid:4),(cid:5)2)
bi (cid:5) i (cid:6)
=argmin 1 (cid:3)y −X(cid:2)−Zb(cid:3)2+bT(cid:2)−1b .
(cid:5)2 i i i i i (cid:4) i
bi
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

| 202 | J. Schelldorfer |     | et al. |     |     |     |     |     | ScandJStatist38 |
| --- | --------------- | --- | ------ | --- | --- | --- | --- | --- | --------------- |
˜
From this we get b =[ZTZ +(cid:5)2(cid:2)−1]−1ZTr, where r =(y −X(cid:2)) is the (marginal) residual
|     |     | i   | i   | i (cid:4) | i i | i i | i   |     |     |
| --- | --- | --- | --- | --------- | --- | --- | --- | --- | --- |
vector.Sincethetruevaluesof(cid:2),(cid:4)and(cid:5)2 areunknown,thebsarepredictedbyˆb =[ZTZ +
|                           |      |                    |                  |           |               |           | i   | i   | i i |
| ------------------------- | ---- | ------------------ | ---------------- | --------- | ------------- | --------- | --- | --- | --- |
| (cid:5)ˆ2(cid:2)−1]−1ZTˆr |      |                    | =(y −X(cid:2)ˆ), |           |               |           |     |     |     |
|                           | with | ˆr                 |                  | using     | the estimates | from (9). |     |     |     |
| (cid:4)ˆ                  | i i  | i                  | i                | i         |               |           |     |     |     |
| 2.4. Selection            | of   | the regularization |                  | parameter |               |           |     |     |     |
The estimation requires to choose a regularization parameter (cid:7). We propose to use the
| Bayesian | information |     | criterion | (BIC) | defined by |     |     |     |     |
| -------- | ----------- | --- | --------- | ----- | ---------- | --- | --- | --- | --- |
BIC(cid:7):=−2`((cid:2)ˆ,(cid:4)ˆ,(cid:5)ˆ2)+logN ·dˆf , (10)
|       |                    |     |     | T (cid:7)          |        |            |        |                 |       |
| ----- | ------------------ | --- | --- | ------------------ | ------ | ---------- | ------ | --------------- | ----- |
|       | :=|{1≤k≤p:(cid:2)ˆ |     |     | =/0}|+dim((cid:4)) |        |            |        |                 |       |
| where | dˆf                |     |     |                    | is the | sum of the | number | of the non-zero | fixed |
|       | (cid:7)            |     | k   |                    |        |            |        |                 |       |
regression coefficients and the number of variance–covariance parameters. The use of |{1≤
k≤p:(cid:2)ˆ =/0}|
as a measure of the degrees of freedom is motivated by the work of Zou et al.
k
(2007) who show that the expected number of degrees of freedom for the Lasso in a linear
| model | is given | by the | number | of non-zero | estimated | coefficients. |     |     |     |
| ----- | -------- | ------ | ------ | ----------- | --------- | ------------- | --- | --- | --- |
Obviously, there are other tuning parameter selection methods, for example cross-
validationandAkaikeinformation-typecriteria,amongothers.AdvocatingtheBICasselection
criterion is based on our empirical experience that it performs best in both simulations and
| real data     | examples | (see       | sections | 5 and      | 6).       |     |     |     |     |
| ------------- | -------- | ---------- | -------- | ---------- | --------- | --- | --- | --- | --- |
| 2.5. Adaptive | `        | -penalized | maximum  | likelihood | estimator |     |     |     |     |
1
Because of the bias of the Lasso, Zou (2006) proposed the adaptive Lasso. For some given
weights w ,...,w , the adaptive ` -penalized maximum likelihood estimator has the follow-
|               | 1        | p   |         | 1       |     |     |     |     |     |
| ------------- | -------- | --- | ------- | ------- | --- | --- | --- | --- | --- |
| ing objective | function |     | instead | of (8): |     |     |     |     |     |
(cid:4)p
|                                        |         |     | 1       | 1                                    |     |     |     |             |     |
| -------------------------------------- | ------- | --- | ------- | ------------------------------------ | --- | --- | --- | ----------- | --- |
| Qw1,...,wp((cid:2),(cid:4),(cid:5)2):= |         |     | log|V|+ | (y−X(cid:2))TV−1(y−X(cid:2))+(cid:7) |     |     | w   | |(cid:2) |, |     |
|                                        | (cid:7) |     |         |                                      |     |     | k   | k           |     |
|                                        |         |     | 2       | 2                                    |     |     |     |             |     |
k=1
and hence
| (cid:6)ˆ˜=((cid:2)ˆ,(cid:4)ˆ,(cid:5)ˆ2)= |     |     |        | Qw1,...,wp((cid:2),(cid:4),(cid:5)2). |     |     |     |     |      |
| ---------------------------------------- | --- | --- | ------ | ------------------------------------- | --- | --- | --- | --- | ---- |
|                                          |     |     | argmin |                                       |     |     |     |     | (11) |
(cid:7)
(cid:2),(cid:4),(cid:5)2>0,(cid:2)>0
The weights w ,...,w may be calculated from an initial estimator (cid:2)ˆ in (9) with w :=
|             |            | 1          | p   |     |     |     |     | init | k   |
| ----------- | ---------- | ---------- | --- | --- | --- | --- | --- | ---- | --- |
| 1/|(cid:2)ˆ | ((cid:7))| | k=1,...,p. |     |     |     |     |     |      |     |
init,k for Unless specified otherwise, we employ these weights.
| 3. Theoretical |     | results |     |     |     |     |     |     |     |
| -------------- | --- | ------- | --- | --- | --- | --- | --- | --- | --- |
In the high-dimensional setting with p(cid:2)N , the theory for penalized estimation based on
T
convexlossfunctionswithan` -penaltyiswellstudied,seeforexamplevandeGeer(2008).
1
From (8) and (9) we see that we are dealing with a non-convex loss function, because
ofthevarianceparameters(cid:4)and(cid:5)2,andaconvex` -penalty.Tothebestofourknowledge,
1
`
only Städler et al. (2010) consider high-dimensional non-convex 1 -penalized smooth
likelihood problems. In this section, we build upon the theory presented in Städler et al.
(2010) and extend their results to prove an oracle inequality for the adaptive ` -penalized
1
estimator (11).
We use the following framework and notation. Let i=1,...,N as before. In the remain-
≡n>1
der of this article, we assume that n i the same for all i. This assumption eases the
mathematical presentation while all theoretical and computational results remain valid for
different ns. Denote by y ∈Y⊂Rn the response variable. Let X be the fixed covariates in
|     | i   |     | i   |     |     |     | i   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

| ScandJStatist38 |     |     |         |     |     |     | High-dimensional |     | mixed-effects | models | 203 |
| --------------- | --- | --- | ------- | --- | --- | --- | ---------------- | --- | ------------- | ------ | --- |
|                 |     |     | Xn⊂Rn×p |     | ⊂X. |     |                  |     |               |        |     |
some space and Z The latter can be assumed without loss of generality,
|     |     |     |     |     | i   | i   |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
sincewecanassigntoeveryvariableafixedeffectbeingequaltozero.Definetheparameter
(cid:6)T:=((cid:2)T,(cid:4)T,2log(cid:5))=((cid:2)T,(cid:4)T,(cid:2))=((cid:2)T,(cid:7)T)∈Rp+q∗+1 (cid:6)
|     |     |     |     |     |     |     |     | and | denote by | the true parameter |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --------- | ------------------ | --- |
0
|     | vector. | For                                                                          | a constant | 0<K<∞, |     | consider | the parameter           | space |     |     |      |
| --- | ------- | ---------------------------------------------------------------------------- | ---------- | ------ | --- | -------- | ----------------------- | ----- | --- | --- | ---- |
|     |         | (cid:4)={(cid:6)T=((cid:2)T,(cid:7)T):sup|xT(cid:2)|≤K,(cid:3)(cid:7)(cid:3) |            |        |     |          | ≤K,(cid:2) >0}∈Rp+q∗+1, |       |     |     |      |
|     |         |                                                                              |            |        |     |          | ∞                       |       |     |     | (12) |
x∈X
where (cid:3)(cid:7)(cid:3) =max |(cid:8) |. We modify the estimators in (9) and (11) by restricting the solution
|     |     |     | ∞   | l l |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
(cid:4):
|     | to  | lie in           | the parameter   |         | space |                                      |     |          |            |     |      |
| --- | --- | ---------------- | --------------- | ------- | ----- | ------------------------------------ | --- | -------- | ---------- | --- | ---- |
|     |     |                  |                 | (cid:7) |       |                                      |     |          | (cid:8)    |     |      |
|     |     |                  |                 | 1       | 1     |                                      |     | (cid:4)p |            |     |      |
|     |     | (cid:6)ˆ:=argmin |                 | log|V|+ |       | (y−X(cid:2))TV−1(y−X(cid:2))+(cid:7) |     |          | |(cid:2) | |     |      |
|     |     |                  |                 |         |       |                                      |     |          | ,          |     | (13) |
|     |     |                  | (cid:6)∈(cid:4) | 2       | 2     |                                      |     |          | k          |     |      |
k=1
|     |     |     |     | (cid:7) |     |     |     |     | (cid:8) |     |     |
| --- | --- | --- | --- | ------- | --- | --- | --- | --- | ------- | --- | --- |
(cid:4)p
|     |     | (cid:6)ˆ | :=argmin |                 | 1 log|V|+ | 1 (y−X(cid:2))TV−1(y−X(cid:2))+(cid:7) |     |     | |(cid:2) | |     |      |
| --- | --- | -------- | -------- | --------------- | --------- | -------------------------------------- | --- | --- | ---------- | --- | ---- |
|     |     |          |          |                 |           |                                        |     |     | w          | .   | (14) |
|     |     | weight   |          |                 | 2         | 2                                      |     |     | k k        |     |      |
|     |     |          |          | (cid:6)∈(cid:4) |           |                                        |     |     | k=1        |     |      |
Now, let f(cid:6),Xi,Zi be the Gaussian density for y with respect to the aforegiven parameteriza-
i
tion. Since we use the negative log-likelihood as loss function, the excess risk coincides with
|     | the | Kullback–Leibler |                     | distance: |                 |          |           |     |     |     |      |
| --- | --- | ---------------- | ------------------- | --------- | --------------- | -------- | --------- | --- | --- | --- | ---- |
|     |     |                  |                     | (cid:9)   | (cid:10)        | (cid:11) |           |     |     |     |      |
|     |     | E                | ((cid:6)|(cid:6) )= |           | f (cid:6) , X , | Z        | d(cid:9), |     |     |     |      |
|     |     |                  |                     | log       | 0               | f(cid:6) |           |     |     |     | (15) |
|     |     | X,Z              | 0                   |           | f               | 0,X,Z    |           |     |     |     |      |
|     |     |                  |                     |           | (cid:6) , X , Z |          |           |     |     |     |      |
where (cid:9) denotes the Lebesgue measure, and we define the average excess risk as:
(cid:4)N
1
|     |     | E                   |     | ((cid:6)|(cid:6) | )=  | E     | ((cid:6)|(cid:6) ). |     |     |     |     |
| --- | --- | ------------------- | --- | ---------------- | --- | ----- | ------------------- | --- | --- | --- | --- |
|     |     | X1,...,XN,Z1,...,ZN |     |                  | 0   | Xi,Zi | 0                   |     |     |     |     |
N
i=1
In the sequel, we drop the indices X,Z and X1,...,XN,Z1,...,ZN , respectively.
`
|     | 3.1. | Consistency |     | for the | 1 -penalized | estimator |     |     |     |     |     |
| --- | ---- | ----------- | --- | ------- | ------------ | --------- | --- | --- | --- | --- | --- |
Werequireonlyoneconditionforconsistency.Itisaconditionontherandom-effectsdesign
|     | matrices |     | Z. i |     |     |      |     |                |            |     |     |
| --- | -------- | --- | ---- | --- | --- | ---- | --- | -------------- | ---------- | --- | --- |
|     |          |     |      |     |     | ZTZ, |     | ((cid:10)(i))q | i=1,...,N, |     |     |
Assumption 1. The eigenvalues of i i denoted by j=1 for are bounded:
j
|     | (cid:10)(i)≤K<∞ |     | for | all i and | j, with | K from | (12). |     |     |     |     |
| --- | --------------- | --- | --- | --------- | ------- | ------ | ----- | --- | --- | --- | --- |
j
|     |     | Now we      | consider | a triangular |            | scheme | of observations | from | (5): |     |      |
| --- | --- | ----------- | -------- | ------------ | ---------- | ------ | --------------- | ---- | ---- | --- | ---- |
|     |     | y =X(cid:2) | +Zb      | +(cid:3),    | i=1,...,N, |        |                 |      |      |     | (16) |
|     |     | i           | i N      | i i          | i          |        |                 |      |      |     |      |
wheretheparameters(cid:2) and(cid:7) areallowedtodependonN.WestudyconsistencyasN→∞
|     |     |     |     | N   | N   |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
but the group size n is fixed (in general, (n i ) i≥1 are fixed). Moreover, let us use the notation
a∨b:=max{a,b}.
Theorem1(consistency). Considermodel (16)andtheestimator (13).Underassumption1and
assuming
|     |     |     |     | (cid:12)(cid:13) |     | (cid:14) | (cid:13) |     |     |     |     |
| --- | --- | --- | --- | ---------------- | --- | -------- | -------- | --- | --- | --- | --- |
log4(N)log(p∨N)
|     |     |                | =o      |                 | N   |     | =C        |     |     |     |     |
| --- | --- | -------------- | ------- | --------------- | --- | --- | --------- | --- | --- | --- | --- |
|     |     | (cid:3)(cid:2) | (cid:3) |                 |     |     | , (cid:7) |     |     |     |     |
|     |     | 0,N            | 1       | log4(N)log(p∨N) |     |     | N         |     | N   |     |     |
for some C>0, any global minimizer (cid:6)ˆ as in (13) satisfies E¯ ((cid:6)ˆ|(cid:6) )=o (1) as N→∞.
|     |     |     |     |     |     |     |     |     | 0 P |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

| 204 | J. Schelldorfer |     | et al. |     |     |     |     |     | ScandJStatist38 |
| --- | --------------- | --- | ------ | --- | --- | --- | --- | --- | --------------- |
AproofisgivenintheAppendixintheonlineSupportingInformation.Theconditionon
(cid:3)(cid:2) (cid:3) is a sparsity condition on the true underlying fixed-effects coefficients.
0,N 1
`
| 3.2. | Oracle | inequality | for the | adaptive | 1 -penalized |     | estimator |     |     |
| ---- | ------ | ---------- | ------- | -------- | ------------ | --- | --------- | --- | --- |
Wenowpresentanoracleoptimalityresultinnon-asymptoticformfortheadaptiveestimator
(andtherebycoveringalsothenon-adaptivecase).Preliminarily,weintroducesomenotation
| and        | two further | assumptions. |     |     |     |     |     |     |     |
| ---------- | ----------- | ------------ | --- | --- | --- | --- | --- | --- | --- |
| Assumption |             | 2.           |     |     |     |     |     |     |     |
i=1,...,N.Atleasttwoeigenvaluesare
| (a) | Let ((cid:11)(i))n |       | betheeigenvaluesof |           | Z(cid:2)ZT | for        |      |                            |     |
| --- | ------------------ | ----- | ------------------ | --------- | ---------- | ---------- | ---- | -------------------------- | --- |
|     |                    | j j=1 |                    |           |            | i i        |      |                            |     |
|     |                    |       |                    |           | ∃ =/j      | ∈{1,...,n} |      | (cid:11)(i)=/ (cid:11)(i). |     |
|     | different,         |       | that is,           | for all i | j 1 2      |            | such | that                       |     |
j1 j2
| (b) | For          | i=1,...,N, | the                | matrices | (cid:5) de | fined by       |     |     |     |
| --- | ------------ | ---------- | ------------------ | -------- | ---------- | -------------- | --- | --- | --- |
|     |              |            | (cid:10)           |          | i (cid:11) |                |     |     |     |
|     |              |            | ∂V                 |          | ∂V         |                |     |     |     |
|     | ((cid:5))    | =tr        | V−1                | i V−1    | i          | r,s=1,...,q∗+1 |     |     |     |
|     |              | i r,s      | i ∂(cid:12)        | i        | ∂(cid:12)  |                |     |     |     |
|     |              |            |                    | p+r      | p+s        |                |     |     |     |
|     | are strictly |            | positive definite. |          |            |                |     |     |     |
(cid:2)=(cid:13)2I,
Remark.In the special case assumption 2(b) automatically holds.
LetS((cid:2))={1≤k≤p:(cid:2) =/0}betheactivesetof(cid:2),thatis,thesetofnon-zerocoefficients,
k
and (cid:2) ={(cid:2) :k∈K} for K⊂{1,...,p}. We denote by S =S((cid:2) ) the true active set and by
|     | K          | k            |          |                |     |     | 0      | 0   |     |
| --- | ---------- | ------------ | -------- | -------------- | --- | --- | ------ | --- | --- |
| =|S | |          |              |          | XT=(xi,...,xi) |     |     |        |     |     |
| s   | its        | cardinality. | Write    |                |     | and | define |     |     |
| 0   | 0          |              |          | i              | 1   | n   |        |     |     |
|     |            | (cid:4)N     | (cid:4)n |                |     |     |        |     |     |
|     | (cid:6) := | 1            |          | ∈Rp×p.         |     |     |        |     |     |
xi(xi)T
|     | N,n | N     | j   | j   |     |     |     |     |     |
| --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- |
|     |     | T i=1 | j=1 |     |     |     |     |     |     |
Assumption 3 (restricted eigenvalue condition).There exists a constant (cid:14)≥1, such that for all
| (cid:2)∈Rp | satisfying | (cid:3)(cid:2) | (cid:3) ≤6(cid:3)(cid:2) | (cid:3) it | holds | that (cid:3)(cid:2) | (cid:3)2≤(cid:14)2(cid:2)T(cid:6) | (cid:2). |     |
| ---------- | ---------- | -------------- | ------------------------ | ---------- | ----- | ------------------- | --------------------------------- | -------- | --- |
|            |            |                | S c 1                    | S0 1       |       | S0                  | 2                                 | N,n      |     |
0
A discussion of this assumption can be found in Bickel et al. (2009) and van de Geer &
| Bühlmann |     | (2009). | Define |     |     |     |     |     |     |
| -------- | --- | ------- | ------ | --- | --- | --- | --- | --- | --- |
(cid:15)
log(p∨N)
|     | (cid:7) =M | logN |     | ,   |     |     |     |     | (17) |
| --- | ---------- | ---- | --- | --- | --- | --- | --- | --- | ---- |
|     | 0          | N    | N   |     |     |     |     |     |      |
whereM isoforderlogN andanexactdefinitionisgivenintheproofoftheorem1.Forany
N
T≥a ,letJ beasetdefinedbytheunderlyingempiricalprocess(see(A.6)intheSupporting
1
J
Information). It is shown in the proof of theorem 1 that the set has large probability,
|     |          |     | (cid:16)        |     |     | (cid:17) |            |     |     |
| --- | -------- | --- | --------------- | --- | --- | -------- | ---------- | --- | --- |
|     |          |     | T2log2Nlog(p∨N) |     |     |          | (cid:15) 1 |     |     |
|     | P[J]≥1−a |     | −               |     |     | −        |            |     |     |
2 exp
|     |     |     |     | a2  |     | logN | N1−2(cid:16) |     |     |
| --- | --- | --- | --- | --- | --- | ---- | ------------ | --- | --- |
3
,(cid:16),(cid:15)>0;seelemmas2and3inappendix
| forNsufficientlylargeandsomeconstantsa |                |     |               |     |     | 1 ,a 2 ,a | 3   |     |     |
| -------------------------------------- | -------------- | --- | ------------- | --- | --- | --------- | --- | --- | --- |
| A (in                                  | the Supporting |     | Information). |     |     |           |     |     |     |
Atthispoint,wecouldconcludeanoracleresultinthewayofStädleretal.(2010).How-
|     |     |     |     |     |     |     |     | (cid:3)(cid:2)ˆ−(cid:2) (cid:3) |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------------------- | --- |
ever, we extend that result and present an oracle inequality involving 1 instead of
0
(cid:3)(cid:2)ˆ (cid:3) for the ` -penalized as well as the adaptive ` -penalized estimator.
| Sc  | 1   | 1   |     |     |     |     | 1   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
0
Theorem 2 (oracle result).Consider the weighted ` -penalized estimator (14). Suppose that for
1
some (cid:17)>0,
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

| ScandJStatist38 |     |     |     |     |     | High-dimensional |     |     | mixed-effects | models 205 |
| --------------- | --- | --- | --- | --- | --- | ---------------- | --- | --- | ------------- | ---------- |
(cid:5)
|     |     | ≤1/(cid:17), | k∈S |     |     |     |     |     |     |     |
| --- | --- | ------------ | --- | --- | --- | --- | --- | --- | --- | --- |
,
|     |     | w              |             | 0   |     |     |     |     |     |     |
| --- | --- | -------------- | ----------- | --- | --- | --- | --- | --- | --- | --- |
|     |     | k ≥1/(cid:17), | k(cid:18)∈S | .   |     |     |     |     |     |     |
0
Under assumptions 1, 2 and 3, and for (cid:7)≥2T(cid:17)(cid:7) , we have on the set J defined in (A.6),
0
|     |     | E¯ ((cid:6)ˆ |                                        |     | )(cid:3)(cid:2)ˆ |                                               |     |                |     |     |
| --- | --- | ------------ | -------------------------------------- | --- | ---------------- | --------------------------------------------- | --- | -------------- | --- | --- |
|     |     |              | |(cid:6) )+2((cid:7)/(cid:17)−T(cid:7) |     |                  | −(cid:2) (cid:3) ≤9((cid:7)/(cid:17)+T(cid:7) |     | )2c2(cid:14)2s | .   |     |
|     |     | weight       | 0                                      |     | 0 weight         | 0 1                                           |     | 0 0            | 0   |     |
The proof is given in appendix B. Application of theorem 2 with all weights equal to one
((cid:17)=1)givesanoracleresultforthe`
-penalizedestimator,whichwewilluseasinitialvalues
1
|     | for       | the adaptive         | Lasso     | procedure.                                  |     |     |     |     |     |     |
| --- | --------- | -------------------- | --------- | ------------------------------------------- | --- | --- | --- | --- | --- | --- |
|     | Corollary | 1.Let                |           |                                             |     |     |     |     |     |     |
|     |           | (cid:6)ˆ :=((cid:2)ˆ | ,(cid:4)ˆ | ):=argminQ1,...,1((cid:2),(cid:4),(cid:2)), |     |     |     |     |     |     |
,(cid:2)ˆ
|     |     | init | init init | init |     | (cid:7) init |     |     |     |     |
| --- | --- | ---- | --------- | ---- | --- | ------------ | --- | --- | --- | --- |
(cid:6)∈(cid:4)
betheinitialestimatorin(14)(i.e.theestimatorwithalltheweightsequalto1).Underassump-
|     |       |          |            | (cid:7) ≥2T(cid:7) |     |            | J,  |     |     |     |
| --- | ----- | -------- | ---------- | ------------------ | --- | ---------- | --- | --- | --- | --- |
|     | tions | 1, 2 and | 3, and for |                    | ,   | we have on |     |     |     |     |
|     |       |          |            | init               | 0   |            |     |     |     |     |
E¯ ((cid:6)ˆ |(cid:6) )+2((cid:7) −T(cid:7) )(cid:3)(cid:2)ˆ −(cid:2) (cid:3) ≤9((cid:7) +T(cid:7) )2c2(cid:14)2s . (18)
|     |     | init | 0 init | 0   | init | 0 1 | init | 0 0 | 0   |     |
| --- | --- | ---- | ------ | --- | ---- | --- | ---- | --- | --- | --- |
Itisclearthatthe` -estimationerrorboundimpliesaboundforthe` ∞estimationerroras
1
well.Whentheunderlyingtruecoefficients(cid:2) ,k∈S aresufficientlymuchlargerinabsolute
|     |     |     |     |     |     | 0,k | 0   |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
`
value than the ∞-estimation error bound, one can perfectly distinguish between the active
andnon-activesets.ThisargumentisappliedinthenextcorollarytotheadaptiveLassowith
|     | estimated | weights. |     |     |     |     |     |     |     |     |
| --- | --------- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
|     | Corollary | 2.Let    |     |     |     |     |     |     |     |     |
):=argminQw1,...,wp((cid:2),(cid:4),(cid:2)),
|     |     | (cid:6)ˆ :=((cid:2)ˆ | ,(cid:4)ˆ | ,(cid:2)ˆ |     |              |     |     |     |     |
| --- | --- | -------------------- | --------- | --------- | --- | ------------ | --- | --- | --- | --- |
|     |     | adap                 | adap adap | adap      |     | (cid:7) adap |     |     |     |     |
(cid:6)∈(cid:4)
be the adaptive estimator with weights w =1/|(cid:2)ˆ |, k=1,...,p as in (13). Assume that for
|     |     |       |     |     |     | k   | init,k |     |     |     |
| --- | --- | ----- | --- | --- | --- | --- | ------ | --- | --- | --- |
|     | all | k∈S , |     |     |     |     |        |     |     |     |
0
|     |     | |(cid:2) |≥2(cid:17) | ,    |     |     |     |     |     |     | (19) |
| --- | --- | -------------------- | ---- | --- | --- | --- | --- | --- | --- | ---- |
|     |     | 0,k                  | init |     |     |     |     |     |     |      |
where
|     |     | 9((cid:7)   | +T(cid:7)           | )2c2(cid:14)2s |                   |                  |     |     |     |     |
| --- | --- | ----------- | ------------------- | -------------- | ----------------- | ---------------- | --- | --- | --- | --- |
|     |     | (cid:17) := | init                | 0 0            | 0≥(cid:3)(cid:2)ˆ | −(cid:2) (cid:3) |     |     |     |     |
|     |     | init        |                     |                |                   | 1                |     |     |     |     |
|     |     |             | 2((cid:7) −T(cid:7) | )              | init              | 0                |     |     |     |     |
|     |     |             | init                | 0              |                   |                  |     |     |     |     |
is a bound of the ` -estimation error of the initial (cid:2)ˆ . Suppose moreover that assumptions 1,
|     |       |       | 1          |          |             |              | init   |     |     |     |
| --- | ----- | ----- | ---------- | -------- | ----------- | ------------ | ------ | --- | --- | --- |
|     |       |       |            | (cid:7)  | ≥2T(cid:17) | (cid:7)      |        | J,  |     |     |
|     | 2 and | 3 are | met. Then, | for adap |             | init 0 , and | on the | set |     |     |
E¯ ((cid:6)ˆ |(cid:6) )+2((cid:7) /(cid:17) −T(cid:7) )(cid:3)(cid:2)ˆ −(cid:2) (cid:3) ≤9((cid:7) /(cid:17) +T(cid:7) )2c2(cid:14)2s . (20)
|     |     | adap | 0 adap | init | 0   | adap 0 | 1   | adap init | 0 0 | 0   |
| --- | --- | ---- | ------ | ---- | --- | ------ | --- | --------- | --- | --- |
We call condition (19) a ‘betamin’ condition. It is clearly very restrictive, but allows for
an easy derivation of the oracle result. The ‘betamin’ condition can indeed be substantially
refined. In van de Geer et al. (2010), one can find similar oracle results, and in addition
variable selection results, for the adaptive Lasso in the linear model, without ‘betamin’ con-
ditions.Theseresultsrequireintroducingvariousversionsofrestrictedeigenvaluesandsparse
eigenvalues, and can be generalized to the current setting. Since a full presentation is rather
|     | involved, | we  | have confined | ourselves |     | to the simple(cid:3)st | case. |     |     |     |
| --- | --------- | --- | ------------- | --------- | --- | ---------------------- | ----- | --- | --- | --- |
Recallthatin(17),wechoose(cid:7) oforderlog2N log(p∨N)/N.Whenwealsochoose(cid:7)
0 init
of this order, we find, modulo the restricted eigenvalue (cid:14) and the constants T and c , that
0
the right-hand side of the oracle result (18) for the initial estimator is of order
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

| 206 | J. Schelldorfer |     | et al. |     |     |     |     | ScandJStatist38 |
| --- | --------------- | --- | ------ | --- | --- | --- | --- | --------------- |
log(p∨N)
|     | log4N |     | s , |     |     |     |     |     |
| --- | ----- | --- | --- | --- | --- | --- | --- | --- |
|     |       | N   | 0   |     |     |     |     |     |
and that
(cid:15)
log(p∨N)
|     | (cid:17) (cid:19)log2N |     | s . |     |     |     |     |     |
| --- | ---------------------- | --- | --- | --- | --- | --- | --- | --- |
|     | init                   |     | N 0 |     |     |     |     |     |
The tuning parameter for the adaptive Lasso can then be taken of order
log(p∨N)
|     | (cid:7) (cid:19)log4N |     | s . |     |     |     |     |     |
| --- | --------------------- | --- | --- | --- | --- | --- | --- | --- |
|     | adap                  |     | N 0 |     |     |     |     |     |
The right-hand side (20) of the oracle result for the adaptive estimator is then of the same
| order | as that | for the | initial estimator. |     |     |     |     |     |
| ----- | ------- | ------- | ------------------ | --- | --- | --- | --- | --- |
Assuming‘betamin’conditions,theresultsincorollaries1and2implythevariablescreen-
| ing property |     | motivated | already in | (4). |     |     |     |     |
| ------------ | --- | --------- | ---------- | ---- | --- | --- | --- | --- |
Corollary 3.
`
|     | (1) For | the 1 -penalized | (initial)        | estimator | (13),          | assume |            |     |
| --- | ------- | ---------------- | ---------------- | --------- | -------------- | ------ | ---------- | --- |
|     |         |                  | 9((cid:7)        | +T(cid:7) | )2c2(cid:14)2s |        |            |     |
|     |         |                  | =                | init      | 0              | 0.     |            |     |
|     |         | min|(cid:2)      | |>(cid:17)       |           | 0              |        |            |     |
|     |         | 0,k              | init             | 2((cid:7) | −T(cid:7) )    |        |            |     |
|     |         | k                |                  | init      | 0              |        |            |     |
|     | Then,   | under            | the assumptions  | of        | corollary      | 1, on  | the set J, |     |
|     |         | ⊂Sˆ              | ={1≤k≤p:(cid:2)ˆ |           | =/0}.          |        |            |     |
|     |         | S 0 init         |                  |           |                |        |            |     |
init,k
|     | (2) For | the adaptive | ` -penalized | estimator |     | in corollary | 2, assume |     |
| --- | ------- | ------------ | ------------ | --------- | --- | ------------ | --------- | --- |
1
|                  |          |             | 9((cid:7)        | /(cid:17) +T(cid:7) | )2c2(cid:14)2s |       |            |     |
| ---------------- | -------- | ----------- | ---------------- | ------------------- | -------------- | ----- | ---------- | --- |
|                  |          | min|(cid:2) | |> adap          | init                | 0 0            | 0.    |            |     |
|                  |          | 0,k         | 2((cid:7)        | /(cid:17)           | −T(cid:7)      |       |            |     |
|                  |          | k           |                  |                     | )              |       |            |     |
|                  |          |             | adap             | adap                | 0              |       |            |     |
|                  | Then,    | under       | the assumptions  | of                  | corollary      | 2, on | the set J, |     |
|                  |          | S ⊂Sˆ       | ={1≤k≤p:(cid:2)ˆ |                     | =/0}.          |       |            |     |
|                  |          | 0 adap      |                  | adap,k              |                |       |            |     |
| The              | proof of | corollary   | 3 is given       | in appendix         | B.             |       |            |     |
| 4. Computational |          | algorithm   |                  |                     |                |       |            |     |
The algorithm for the estimators in (9) and (11) is based on the Block Coordinate
GradientDescent(BCGD)methodfromTseng&Yun(2009).ThemainideasofourBCGD
algorithm are that we cycle through the coordinates and minimize the objective function
Q(cid:7)(·)
with respect to only one coordinate while keeping the other parameters fixed (i.e. a
Gauss–Seidel algorithm). In each such step, we approximate Q(cid:7)(·) by a strictly convex qua-
dratic function. Then, we calculate a descent direction and we employ an inexact line search
| to ensure | a decrease |     | in the objective | function. |     |     |     |     |
| --------- | ---------- | --- | ---------------- | --------- | --- | --- | --- | --- |
BCGD algorithms are used in Meier et al. (2008) for the group Lasso as well as in
Wu & Lange (2008) and Friedman et al. (2010) for the ordinary Lasso. We remark that
Meier et al. (2008) have a block structure because of the grouped variables whereas we
only focus on ungrouped covariates. Thus the word ‘block’ has no meaning in our context
andconsequently,weomititinthesubsequentdiscussion.Furthermore,theordinaryLasso
has only regression parameters to cycle through in contrast to our problem involving two
kinds of parameters: fixed regression and variance–covariance parameters.
Let us first introduce the notation and give an overview of the algorithm before prov-
ing that our optimization problem achieves numerical convergence. All the details as well as
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

| ScandJStatist38 |     |     |     |     |     | High-dimensional |     |     | mixed-effects | models 207 |
| --------------- | --- | --- | --- | --- | --- | ---------------- | --- | --- | ------------- | ---------- |
somecomputationalaspectsaredeferredtoappendixCintheSupportingInformationonthe
|     | journal | website. |     |     |     |     |     |     |     |     |
| --- | ------- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
Let (cid:6)T=((cid:2)T,(cid:7)T)∈Rp+q∗+1 be the parameterization introduced in the previous section.
|     | Define | the functions |     |     |     |     |     |     |     |     |
| --- | ------ | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
(cid:4)p
|     |              |     |             |              | 1                | 1                                      |     |     |     |     |
| --- | ------------ | --- | ----------- | ------------ | ---------------- | -------------------------------------- | --- | --- | --- | --- |
|     | P((cid:6)):= |     | |(cid:2) |, | g((cid:6)):= | log|V((cid:7))|+ | (y−X(cid:2))TV((cid:7))−1(y−X(cid:2)). |     |     |     |     |
k
|     |     |     |     |     | 2   | 2   |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
k=1
|     |     |     |     | (cid:6)ˆ | =argmin | Q(cid:7)((cid:6)):=g((cid:6))+(cid:7)P((cid:6)). |     |     |     |     |
| --- | --- | --- | --- | -------- | ------- | ------------------------------------------------ | --- | --- | --- | --- |
Now (9) can be written as (cid:7) (cid:6) Letting e j be the jth unit
|     | vector,   | the algorithm        |     | can be   | summarized | in the | following | way: |     |     |
| --- | --------- | -------------------- | --- | -------- | ---------- | ------ | --------- | ---- | --- | --- |
|     | Algorithm | 1 (coordinate        |     | gradient | descent).  |        |           |      |     |     |
|     | (0)       | Let (cid:6)0∈Rp+q∗+1 |     | be an    | initial    | value. |           |      |     |     |
For`=0,1,2,..., letS`betheindexcyclingthroughthecoordinates{1},{2},...,{p+q∗},
{p+q∗+1}
|     |     |             |             |                 |            | ∂2/∂((cid:12) | S`)2Q(cid:7)((cid:6)`)    |     | h`>0.   |     |
| --- | --- | ----------- | ----------- | --------------- | ---------- | ------------- | ------------------------- | --- | ------- | --- |
|     | (1) | Approximate | the         | second          | derivative |               |                           | by  |         |     |
|     | (2) | Calculate   | the descent |                 | direction  |               |                           |     |         |     |
|     |     |             |             | (cid:5)         |            |               |                           |     | (cid:6) |     |
|     |     |             |             |                 | ∂          |               | 1                         |     |         |     |
|     |     | d`:=arg     | m           | in g((cid:6)`)+ |            | g((cid:6)`)d+ | d2h`+(cid:7)P((cid:6)`+de |     | S`)     | .   |
∂(cid:12)
|     |     |     | d∈ R |     |     | S`  | 2   |     |     |     |
| --- | --- | --- | ---- | --- | --- | --- | --- | --- | --- | --- |
Chooseastepsize(cid:3)`>0andset(cid:6)`+1=(cid:6)`+(cid:3)`d`e
|     | (3) |     |     |     |     |     |     | suchthatthereisadecreaseinthe |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------------------------- | --- | --- |
S`
|     |     | objective | function; |     |     |     |     |     |     |     |
| --- | --- | --------- | --------- | --- | --- | --- | --- | --- | --- | --- |
until convergence.
The details of (0)–(3) and further computational issues are given in appendix C of the
online Supporting Information. An implementation of the algorithm can be found in the
Rpackagelmmlasso,whichisavailablefromR-Forge(http://lmmlasso.R-forge.R-project.org).
TheconvergencepropertiesoftheCGDalgorithmaredescribedinthefollowingtheorem.
((cid:6)`)`≥0
Theorem 3 (convergence of the CGD algorithm). If is chosen according to algorithm
|     | 1, then | every cluster | point | of  | {(cid:6)`} | is a stationary | point | of Q(cid:7)((cid:6)). |     |     |
| --- | ------- | ------------- | ----- | --- | ---------- | --------------- | ----- | --------------------- | --- | --- |
`≥0
|     | The | proof is | given | in appendix | C.  |     |     |     |     |     |
| --- | --- | -------- | ----- | ----------- | --- | --- | --- | --- | --- | --- |
Ingeneral,becauseofthenon-convexityoftheoptimizationproblem,theCGDalgorithm
|     | may not       | achieve | the global | optimum. |     |     |     |     |     |     |
| --- | ------------- | ------- | ---------- | -------- | --- | --- | --- | --- | --- | --- |
|     | 5. Simulation |         | study      |          |     |     |     |     |     |     |
Inthissection,weassesstheempiricalperformanceofthe` -penalizedmaximumlikelihood
1
estimators(9)and(11)indifferentkindsofsimulationexamples.Westudyseveralperformance
measures and compare the proposed method with Lasso and linear mixed-effects methods,
if possible. After some introductory remarks, we focus on high-dimensional examples. The
simulation study for the low-dimensional setting is provided in the online Supporting Infor-
mation. The application of the new procedure on a real data set is illustrated in the next
section.
Hereafter, we denote by lmmLasso the ` -penalized maximum likelihood estimator (9),
1
`
by lmmadLasso the adaptive 1 -penalized maximum likelihood estimator (11) and by lme
the classical linear mixed-effects model provided by the R package nlme (Pinheiro & Bates,
2000). Furthermore, let Lasso denote the standard Lasso (Efron et al., 2004) and adLasso
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

| 208 | J. Schelldorfer | et  | al. |     |     |     |     | ScandJStatist38 |
| --- | --------------- | --- | --- | --- | --- | --- | --- | --------------- |
the adaptive Lasso (Zou, 2006) where the regularization parameter is chosen by minimizing
the BIC.
As an overview, let us summarize the most important conclusions from the simulation
studies:
(a) The variability of the estimated fixed-effects parameters (cid:2)ˆ is much smaller if there
k
is no corresponding random effect (bˆ) for i=1,...,N, for all lme, lmmLasso and
i k
lmmadLasso.
(b) In the high-dimensional framework, the following aspects appear (and are virtually
|     | not observable | in  | the low-dimensional |     | setting): |     |     |     |
| --- | -------------- | --- | ------------------- | --- | --------- | --- | --- | --- |
1. Penalizing fixed-effects covariates which also incorporate a random effect causes
bias problems. To be more specific, let us assume that the penalized kth covari-
ate has a fixed and a random-effects coefficient, that is, (cid:2) and (b) , respectively.
|     |     |     |     |         |     |         | k i k |          |
| --- | --- | --- | --- | ------- | --- | ------- | ----- | -------- |
|     |     |     |     | (cid:7) |     | (cid:2) |       | (cid:2)ˆ |
If the regularization parameter is large and subject to penalization, then
|     |     |     |     |     |     | k   |     | k   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
is shrunken towards zero. Thereby, the estimate of the corresponding variance
parameter gets large and (bˆ) has a bias related to the amount of shrinkage in
|     |     |     |     | i k |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
(cid:2)ˆ
. As a consequence, covariates with fixed and random effect should no be sub-
k
|     | ject to | penalization. |     |     |     |     |     |     |
| --- | ------- | ------------- | --- | --- | --- | --- | --- | --- |
2. An adaptive procedure (11) with appropriate weights may reduce this adverse
effect,butitdoesnotovercometheaforementionedproblemcompletely.Thework
of Bondell et al. (2010) covers only the low-dimensional case and the authors do
|     | not present | any | parameter | estimates | in the | simulation | study. |     |
| --- | ----------- | --- | --------- | --------- | ------ | ---------- | ------ | --- |
3. The results are sensitive to the starting value. Nonetheless, choosing the starting
value as described in appendix C of the online Supporting Information performs
|     | well in | all simulation | examples. |     |     |     |     |     |
| --- | ------- | -------------- | --------- | --- | --- | --- | --- | --- |
Thereisaremarkablereductionoftheestimatederrorvariance(cid:5)ˆ2
|     | (c) |     |     |     |     |     | whenincorporating |     |
| --- | --- | --- | --- | --- | --- | --- | ----------------- | --- |
therandom-effectsstructureinlmmLasso,lmmadLassoandlmecomparedwithLasso
|     | and adLasso. |     |     |     |     |     |     |     |
| --- | ------------ | --- | --- | --- | --- | --- | --- | --- |
(d) ThevariabilityoftheLassoandadLassocoefficientestimatorsarelargerthanthecor-
|     | responding | variability | of the mixed-effects |     | model | approaches. |     |     |
| --- | ---------- | ----------- | -------------------- | --- | ----- | ----------- | --- | --- |
(e) Ifwefocusontheidentificationofrandom-effectscovariates,wesuggestusingadia-
gonal structure for (cid:2) and then eliminating those random-effects covariates with a
small variance. An elaborate discussion of the selection of the random-effects struc-
ture is beyond the scope of this article. In section 6, we suggest a strategy how to
|     | remedy this | problem. |     |     |     |     |     |     |
| --- | ----------- | -------- | --- | --- | --- | --- | --- | --- |
Inallsubsequentsimulationschemes,werestrictourselvestothecasewhereallgroupshave
|     |     |     |     |     | ≡n  | i=1,...,N. |     |     |
| --- | --- | --- | --- | --- | --- | ---------- | --- | --- |
the same number of observations, that is, we set n for Let the first column
i
ofX bethe(non-penalized)intercept.WeassignZ ⊂X suchthatthecolumnsofZ corres-
|     | i   |     |     |     | i   | i   |     | i   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
pond to the first q columns of X. i This means that the first q variables have both a fixed-
|     |     |     |     |     |     |     | i=1,...,N | k=1,...,q. |
| --- | --- | --- | --- | --- | --- | --- | --------- | ---------- |
effects coefficient (cid:2) and a random-effects coefficient (b) for and
|     |     | k   |     |     |     | i k |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
The covariates are generated from a multivariate normal distribution with mean zero and
covariancematrix(cid:6)withthepairwisecorrelation(cid:6) =(cid:15)|k−k(cid:20)| and(cid:15)=0.2.Denoteby(cid:2)
|     |     |     |     |     | kk(cid:20) |     |     | the |
| --- | --- | --- | --- | --- | ---------- | --- | --- | --- |
0
true fixed effects and by s :=#{1≤k≤p:(cid:2) =/0} the true number of non-zero coefficients.
|     |     |     | 0   | 0,k |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
Unlessotherwisestated,weset(cid:2)=(cid:13)2I.Inallsubsequenttables,anon-penalizedfixed-effects
| coefficient | is marked        | by      | an asterisk (∗). |     |     |     |     |     |
| ----------- | ---------------- | ------- | ---------------- | --- | --- | --- | --- | --- |
| 5.1.        | High-dimensional | setting |                  |     |     |     |     |     |
Westudyfourexamplesinthehigh-dimensionalsetting((cid:2) =1istheunpenalizedintercept).
0,1
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

ScandJStatist38 High-dimensional mixed-effects models 209
H : N=25, n=6, N =150, p=300, q=2, (cid:5)2=0.25, (cid:13)2=0.56 and s =5 with (cid:2) =
1 T 0 0
(1,2,4,3,3,0,...,0)T.
H : N=30, n=6, N =180, p=500, q=1, (cid:5)2=0.25, (cid:13)2=0.56 and s =5 with (cid:2) =
2 T 0 0
(1,2,4,3,3,0,...,0)T.
H : N=30, n=6, N =180, p=1000, q=3, (cid:5)2=0.25, (cid:13)2=0.56 and s =5 with (cid:2) =
3 T 0 0
(1,2,4,3,3,0,...,0)T.
H : N=25, n=6, N =150, p=300, (cid:5)2=0.25,
4 T
⎛ ⎞
3 0 0
(cid:2)=⎝
0 3 0
⎠
0 0 2
and s =5 with (cid:2) =(1,2,4,3,3,0,...,0)T. In contrast to the previous examples, we fit a
0 0
wrong model assuming that (cid:2) is diagonal with dimension 4.
Theresultsintheformofmeansandstandarddeviations(inparentheses)over100simula-
tion runs are depicted in Tables 2–4. Therein, |S((cid:2)ˆ)| denotes the cardinality of the estimated
active set and TP is the number of true positives.
Let us sum up the simulation results for the models H –H . As in the low-dimensional
1 4
setting (see appendix D), the estimated active set is sparse and all methods include the true
non-zero coefficients.
Table 2 reveals that lmmLasso and lmmadLasso reduce the error variance remarkably in
comparisonwithLassoandadLasso.Nevertheless,lmmLassooverestimatesthetruevalueof
(cid:5)2 whereaslmmadLassounderestimates(cid:5)2.Weobserve,inparticularforH ,thatamaximum
4
Table 2. Simulation results for H , H and H (an asterisk indicates that the fixed-effects coefficient is
1 2 3
not subject to penalization)
Method |S((cid:2)ˆ)| TP (cid:5)ˆ2 (cid:13)ˆ2 (cid:2)ˆ (cid:2)ˆ (cid:2)ˆ (cid:2)ˆ (cid:2)ˆ
1 2 3 4 5
Model True 5 5 0.25 0.56 1 2 4 3 3
H lmmLasso 6.70 5 0.29 0.52 1.01∗ 2.05∗ 3.86 2.90 2.88
1
(2.14) (0) (0.05) (0.12) (0.16) (0.16) (0.06) (0.06) (0.06)
lmmadLasso 6.59 5 0.22 0.52 1.01∗ 2.03∗ 3.98 2.99 3.00
(2.02) (0) (0.04) (0.12) (0.16) (0.16) (0.06) (0.05) (0.05)
Lasso 6.29 5 1.36 – 1.01∗ 2.07∗ 3.76 2.84 2.79
(1.46) (0) (0.27) – (0.17) (0.19) (0.10) (0.11) (0.10)
adLasso 6.29 5 1.16 – 1.01∗ 2.02∗ 3.98 3.00 2.99
(1.46) (0) (0.24) – (0.17) (0.18) (0.10) (0.11) (0.10)
H lmmLasso 6.65 5 0.28 0.56 1.00∗ 1.90 3.91 2.92 2.89
2
(1.71) (0) (0.04) (0.17) (0.15) (0.04) (0.05) (0.04) (0.05)
lmmadLasso 6.53 5 0.22 0.55 1.00∗ 2.00 3.99 3.00 2.99
(1.64) (0) (0.03) (0.17) (0.15) (0.04) (0.04) (0.04) (0.04)
Lasso 6.84 5 0.87 – 1.00∗ 1.84 3.88 2.88 2.83
(2.02) (0) (0.19) – (0.15) (0.08) (0.07) (0.09) (0.08)
adLasso 6.84 5 0.72 – 1.00∗ 2.00 4.00 3.00 2.98
(2.02) (0) (0.17) – (0.15) (0.07) (0.07) (0.08) (0.08)
H lmmLasso 6.17 5 0.29 0.52 1.02∗ 2.00∗ 4.04∗ 2.84 2.84
3
(1.74) (0) (0.05) (0.10) (0.15) (0.15) (0.15) (0.07) (0.06)
lmmadLasso 6.12 5 0.23 0.53 1.02∗ 2.00∗ 4.00∗ 2.99 2.99
(1.70) (0) (0.04) (0.10) (0.15) (0.15) (0.15) (0.07) (0.06)
Lasso 5.93 5 1.94 – 1.03∗ 2.02∗ 4.06∗ 2.70 2.70
(1.48) (0) (0.36) – (0.17) (0.18) (0.19) (0.11) (0.13)
adLasso 5.93 5 1.69 – 1.03∗ 2.02∗ 3.99∗ 2.98 2.97
(1.48) (0) (0.32) – (0.16) (0.17) (0.18) (0.12) (0.12)
TP, true positives; Lasso, least absolute shrinkage and selection operator.
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

| 210 J. Schelldorfer | et al. |     |     |     |     |     | ScandJStatist38 |
| ------------------- | ------ | --- | --- | --- | --- | --- | --------------- |
Table3. Simulationresultsfor H 4 (anasteriskindicatesthatthefixed-effectscoefficientisnotsubjectto
penalization)
Method |S((cid:2)ˆ)| TP (cid:5)ˆ2 (cid:2)ˆ (cid:2)ˆ (cid:2)ˆ (cid:2)ˆ (cid:2)ˆ
|                     |               |                    | 1             | 2         | 3      | 4      | 5      |
| ------------------- | ------------- | ------------------ | ------------- | --------- | ------ | ------ | ------ |
| True                | 5 5           | 0.25               | 1             | 2         | 4      | 3      | 3      |
| lmmLasso            | 5.56          | 5 0.26             | 0.95∗         | 1.99∗     | 3.97∗  | 3.04∗  | 2.82   |
|                     | (0.97) (0)    | (0.05)             | (0.31)        | (0.38)    | (0.31) | (0.07) | (0.07) |
|                     |               |                    | 0.95∗         | 1.99∗     | 3.97∗  | 3.00∗  |        |
| lmmadLasso          | 5.56          | 5 0.22             |               |           |        |        | 3.00   |
|                     | (0.97) (0)    | (0.04)             | (0.31)        | (0.38)    | (0.30) | (0.07) | (0.06) |
| Lasso               | 6.84          | 5 7.85             | 0.94∗         | 2.01∗     | 3.99∗  | 3.11∗  | 2.36   |
|                     | (12.18) (0)   | (1.81)             | (0.38)        | (0.47)    | (0.38) | (0.23) | (0.28) |
|                     |               |                    | 0.95∗         | 2.02∗     | 4∗     | 2.98∗  |        |
| adLasso             | 6.79          | 5 7.25             |               |           |        |        | 3.01   |
|                     | (11.68) (0)   | (1.76)             | (0.37)        | (0.47)    | (0.38) | (0.22) | (0.29) |
| TP, true positives; | Lasso, least  | absolute shrinkage | and selection | operator. |        |        |        |
|                     | Table 4. Mean | covariance         | estimates     | for H     |        |        |        |
4
|     |              | (cid:2)            | (cid:2) | (cid:2)             | (cid:2) |     |     |
| --- | ------------ | ------------------ | ------- | ------------------- | ------- | --- | --- |
|     | Method       | 11                 | 22      | 33                  | 44      |     |     |
|     | True         | 3                  | 3       | 2                   | 0       |     |     |
|     | lmmLasso     | 2.82               | 2.94    | 1.85                | 0.01    |     |     |
|     |              | (0.80)             | (0.88)  | (0.62)              | (0.02)  |     |     |
|     | lmmadLasso   | 2.81               | 2.94    | 1.84                | 0.01    |     |     |
|     |              | (0.79)             | (0.88)  | (0.62)              | (0.02)  |     |     |
|     | Lasso, least | absolute shrinkage | and     | selection operator. |         |     |     |
likelihood approach (in contrast to a restricted maximum likelihood approach) gives biased
variance–covariance estimators. It is possible to implement an REML-type approach (Ni
et al., 2010) in the high-dimensional setting to reduce the bias in the variance parameters.
However,wehaveobservedthat(i)thenumberof(Gauss–Seidel)cyclesincreasesand(ii)the
algorithmmayfailtoconverge.Inallmodels,wedonotpenalizethecovariateswithbotha
fixedandrandomeffect.Withoutdoingthis(notshownhere),thefixedeffectswouldbesetto
zero whereas the estimated between-subject variability (cid:13)ˆ2 would increase. As a consequence,
the predicted random effects are too large and are not centered at zero, but around the true
fixed effect. Hence this would result in a model which does not fulfill the assumptions in (5)
anymore.
Tables2and3revealthatthevariabilityofthefixedeffectswithnocorrespondingrandom
effect is approximately half of the non-penalized coefficients. This difference of estimation
variability is also observed in the classical linear mixed-effects framework (see lme in Tables
7and8inappendixD).Besides,lmmLassohasabiastowardszero,whichisnotablysmaller
than that from the Lasso. As expected, this bias can be reduced by lmmadLasso. Concern-
ingH ,itisworthpointingoutthatalthoughnotknowingthetruecovariancestructure,we
4
may use a diagonal structure for (cid:2) and then drop the variances which are close to zero. A
suggestion how to use this idea in a real data set is presented in the next section.
| 5.2. Within-group | prediction | performance |     |     |     |     |     |
| ----------------- | ---------- | ----------- | --- | --- | --- | --- | --- |
We now turn to consider the performance of the proposed methodology concerning within-
group prediction. We compare the predictive performance between six different Lasso
procedures. In doing so, denote by lmmLasso, lmmadLasso, Lasso and adLasso the pro-
cedures from the previous subsection. In addition, let cv-Lasso be a cross-validated Lasso
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

| ScandJStatist38 |     |       |     |              |            |       | High-dimensional     |     | mixed-effects | models 211 |
| --------------- | --- | ----- | --- | ------------ | ---------- | ----- | -------------------- | --- | ------------- | ---------- |
|                 |     | Table | 5.  | Mean squared | prediction | error | for three simulation |     | examples      |            |
|                 |     |       |     |              |            | lmmad |                      |     |               | cv-ad      |
(cid:13)2
|     |     | Model |     |     | lmmLasso | Lasso | Lasso | adLasso | cv-Lasso | Lasso |
| --- | --- | ----- | --- | --- | -------- | ----- | ----- | ------- | -------- | ----- |
(p=10)
|     |     | P   |     | 0   | 1.01 | 1.02 | 1.00 | 1.01 | 1.05 | 1.01 |
| --- | --- | --- | --- | --- | ---- | ---- | ---- | ---- | ---- | ---- |
1
|     |     |     |     | 0.25 | 1.33 | 1.29 | 1.76 | 1.84 | 1.81 | 1.84 |
| --- | --- | --- | --- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
|     |     |     |     | 1    | 1.66 | 1.55 | 3.74 | 3.74 | 3.88 | 3.77 |
|     |     |     |     | 2    | 1.67 | 1.80 | 5.92 | 6.25 | 5.94 | 6.25 |
(p=100)
|     |     | P   | 2       | 0    | 1.12 | 1.02 | 1.26 | 1.09 | 1.20 | 1.14 |
| --- | --- | --- | ------- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
|     |     |     |         | 0.25 | 1.51 | 1.38 | 1.75 | 1.75 | 2.06 | 1.75 |
|     |     |     |         | 1    | 1.94 | 1.86 | 4.35 | 4.53 | 4.61 | 4.23 |
|     |     |     |         | 2    | 2.49 | 1.95 | 7.04 | 7.02 | 7.09 | 6.98 |
|     |     | P   | (p=500) | 0    | 1.22 | 1.07 | 1.18 | 1.26 | 1.24 | 1.58 |
3
|     |     |        |       | 0.25     | 1.83      | 1.58          | 2.63      | 2.67 | 2.98 | 3.58  |
| --- | --- | ------ | ----- | -------- | --------- | ------------- | --------- | ---- | ---- | ----- |
|     |     |        |       | 1        | 2.00      | 1.85          | 4.35      | 3.78 | 4.14 | 4.85  |
|     |     |        |       | 2        | 2.54      | 2.04          | 10.30     | 8.26 | 9.47 | 11.28 |
|     |     | Lasso, | least | absolute | shrinkage | and selection | operator. |      |      |       |
(cid:7)-value
and cv-adLasso a cross-validated adaptive Lasso whose is chosen by 10-fold cross-
validation.
Wefixthefollowingscenario:N=25,n ≡6fori=1,...,N,q=3,s =5with(cid:2) =(1,1.5,
|     |     |     |     |     |     |     | i   |     | 0   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
1.2,1,2,0,...,0)T,(cid:5)2=1and(cid:15)=0.2.Weonlyalterthenumberoffixedcovariatespandthe 0
variance component (cid:13)2. For measuring the quality of prediction, we generate a test set with
50observationspergroupandcalculatethemeansquaredpredictionerror.Thethreemodels
|     | considered |        | are: |         |     |         |     |     |     |     |
| --- | ---------- | ------ | ---- | ------- | --- | ------- | --- | --- | --- | --- |
|     |            | :p=10, |      | :p=100, |     | :p=500. |     |     |     |     |
|     |            | P 1    |      | P 2     | P 3 |         |     |     |     |     |
(cid:13)2=0
The results are shown in Table 5. We see that the methods differ slightly for which
corresponds to no grouping structure. As (cid:13)2 increases, the mean squared prediction error
increaseslessforthelmmLassoandthelmmadLassothanfortheothermethods.Theseresults
highlight that we can indeed achieve prediction improvements using the suggested mixed-
|     | effects | model        | approach    |     | if the underlying |     | model is given | by  | (5). |     |
| --- | ------- | ------------ | ----------- | --- | ----------------- | --- | -------------- | --- | ---- | --- |
|     | 6.      | Application: | riboflavin  |     | data              |     |                |     |      |     |
|     | 6.1.    | Data         | description |     |                   |     |                |     |      |     |
WeillustratetheproposedprocedureonarealdatasetwhichisprovidedbyDSM(Switzerland).
ThegoalistogeneticallymodifythebacteriumBacillussubtilistoincreaseitsproductionrate
forriboflavin(vitaminB2).Afirststeptoachievethispurposeistoidentifygeneswhichare
most relevant for the production rate. A linear mixed-effects model is appropriate because
several observations at different time points are available (i.e. longitudinal data). The re-
sponsevariableisthelogarithmoftheriboflavinproductionrateandtherearep=4088cova-
riates(genes)measuringthegeneexpressionlevels.WehaveN=28groupswithn ∈{2,...,6}
i
andN =111observations.Westandardizeallcovariatestohavemeanzeroandvarianceone.
T
|     | 6.2. | Model | selection | strategy |     |     |     |     |     |     |
| --- | ---- | ----- | --------- | -------- | --- | --- | --- | --- | --- | --- |
Preliminarily, we address the issue of determining those covariates which have both a fixed
and a random-effects coefficient. In other words, we specify the matrices Z ⊂X. Since we
i i
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

212 J. Schelldorfer et al. ScandJStatist38
have to deal with high-dimensional, low sample size data, the various tools proposed in
Pinheiro & Bates (2000) for determining Z can hardly be applied. Instead, we suggest the
i
following strategy:
(i) Calculate an ordinary Lasso solution
(cid:2)ˆLasso
(with cross-validation) and define the
active set Sˆ :={1≤k≤p:(cid:2)ˆLasso=/0}.
init k
(ii) For each l∈Sˆ , fit a model in which only the lth covariate has a random-effects
init
coefficient. Denote the corresponding variance estimate by
(cid:13)ˆ2
.
l
(iii) Let(cid:13)ˆ2
[1]
≥(cid:13)ˆ2
[2]
≥···≥(cid:13)ˆ2
[|Sinit |]
betheorderedestimatedvariancesfrom(2).Thenfor(cid:14)>0
definethesetR (cid:14):={l∈S
init
:(cid:13)ˆ2
l
>(cid:14)}∩{l∈Sˆ
init
:BIC
(cid:13)ˆ2
≤BIC
0
},whereBIC
0
istheBIC
l
of the Lasso solution in (1).
(iv) Fit a model with Z
i
=X
i
R(cid:14) (where X
i
R(cid:14) consists of the variables included in R (cid:14)) and
(cid:2) being diagonal and keep the non-zero elements of (cid:2)ˆ.
Bydoingso(andsetting(cid:14)=0.05),itseemsreasonabletofitamodelwhereintwocovariates
have an additional random effect. Denoting these variables as k and k , the model can be
1 2
written as:
y =xT(cid:2)+b z +b z +(cid:16) , i=1,...,N, j=1,...,n (21)
ij ij ik1 ijk1 ik2 ijk2 ij i
with b ∼N(0,(cid:13)2 ), b ∼N(0,(cid:13)2 ) and (cid:16) ∼N(0,(cid:5)2).
ik1 k1 ik2 k2 ij
6.3. Results
WecomparetheresultsoflmmLassoandlmmadLassowithLassoandadLasso.Thevariance
component estimates, the cardinality of the active set and the rank R of five fixed-effects
coefficients are shown in Table 6. The ranking is determined by ordering the absolute values
of the fixed-effects coefficients.
FromTable6,weseethattheerrorvarianceoftheLassomaybeconsiderablyreducedby
thelmmLasso.Althoughthevariance(cid:13)ˆ2
issmall,theBICofthismodelissmallerthanthat
k2
of the model including only k as random covariate. It is noteworthy that 53 per cent of the
1
totalvariabilityinthedatasetisbecauseofthebetween-groupvariability.Thisstronglyindi-
cates that there is indeed some variability between the groups. As might have been expected
from the simulation results, the active set of lmmLasso and lmmadLasso is smaller than the
active set from Lasso and adLasso. The ranking indicates that there is one dominating co-
variate whereas the other coefficients differ only slightly between the four procedures (not
shown).
Table 6. Results for lmmLasso, lmmadLasso, Lasso and adLasso
of the riboflavin data set
lmmLasso lmmadLasso Lasso adLasso
(cid:5)ˆ2 0.18 0.15 0.30 0.20
(cid:13)ˆ2
0.17 0.08 – –
k1
(cid:13)ˆ2
0.03 0.03 – –
k2
|S((cid:2)ˆ)| 18 14 21 20
R 1 1 1 1
(cid:2)ˆ
1
R 2 2 4 6
(cid:2)ˆ
2
R 3 3 3 5
(cid:2)ˆ
3
R 4 13 – –
(cid:2)ˆ
4
R 5 6 6 7
(cid:2)ˆ
5
Lasso, least absolute shrinkage and selection operator.
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

ScandJStatist38 High-dimensional mixed-effects models 213
7. Discussion
Wepresentan` -penalizedmaximumlikelihoodestimatorforhigh-dimensionallinearmixed-
1
effects models. The proposed methodology copes with the difficulty of combining a non-
convexlossfunctionandan` -penalty.Thereby,wedealwiththeoreticalandcomputational
1
aspects which are substantially more challenging than in the linear regression setting. We
prove theoretical results concerning the consistency of the estimator and we present a non-
asymptotic oracle result for the adaptive ` -penalized estimator. Moreover, by developing a
1
coordinate gradient descent algorithm, we achieve provable numerical convergence of our
algorithm to at least a stationary point. Our simulation studies and real data example show
that the error variance can be remarkably reduced when incorporating the knowledge about
the cluster structure among observations.
Acknowledgements
The research is supported by the Swiss National Science Foundation (grant no. 20PA21-
120043/1). The authors thank the members of the DFG-SNF Forschergruppe 916 for many
stimulating discussions.
Supporting Information
Additional Supporting Information can be found in the online version of this article:
Appendix A. Proof of theorem 1 from section 3.
Appendix B. Proof of theorem 2 from section 3.
Appendix C. Computational details of algorithm 1 in section 4.
Appendix D. Simulations for the low-dimensional setting in section 5.
Pleasenote:Wiley-Blackwellarenotresponsibleforthecontentorfunctionalityofanysup-
porting materials supplied by the authors. Any queries (other than missing material) should
be directed to the corresponding author for the article.
References
Bickel, P., Ritov, Y. & Tsybakov, A. (2009). Simultaneous analysis of lasso and dantzig selector. Ann.
Statist.37,1705–1732.
Bondell,H.D.,Krishna,A.&Gosh,S.K.(2010).Jointvariableselectionoffixedandrandomeffects
inlinearmixed-effectsmodels.Biometrics 66,1069–1077.
Bühlmann,P.&vandeGeer,S.(2011).Statisticsforhigh-dimensionaldata:methodstheoryandapplica-
tions.Springer-Verlag,NewYork,Dordrecht,Heidelberg,London.
Bunea,F.,Tsybakov,A.&Wegkamp,M.(2007).Sparsityoracleinequalitiesforthelasso.Electron.J.
Statist.1,169–194.
Candes,E.&Tao,T.(2007).TheDantzigselector:statisticalestimationwhenpismuchlargerthann.
Ann.Statist.,35,2313–2351.
Demidenko,E.(2004).Mixedmodels,theoryandapplications.Wiley,Hoboken,NewJersey.
Efron, B., Hastie, T., Johnstone, I. & Tibshirani, R. (2004). Least angle regression. Ann. Statist. 32,
407–499.
Friedman,J.,Hastie,T.&Tibshirani,R.(2010).Regularizationpathsforgeneralizedlinearmodelsvia
coordinatedescent.J.Statist.Softw.33,1–22.
van de Geer, S. (2008). High-dimensional generalized linear models and the lasso. Ann. Statist. 36,
614–645.
van de Geer, S. & Bühlmann, P. (2009). On the conditions used to prove oracle results for the lasso.
Electron.J.Stat.3,1360–1392.
vandeGeer,S.,Bühlmann,P.&Zhou,S.(2010).Theadaptiveandthethresholdedlassoforpotentially
misspecifiedmodels.PreprintarXiv:1001.5176v3.
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.

214 J. Schelldorfer et al. ScandJStatist38
Greenshtein, E. & Ritov, Y. (2004). Persistence in high-dimensional linear predictor selection and the
virtueofoverparametrization.Bernoulli 10,971–988.
Huang,J.,Ma,S.&Zhang,C.-H.(2008).Adaptivelassoforsparsehigh-dimensionalregressionmodels.
Statist.Sinica18,1603–1618.
Ibrahim, J. G., Zhu, H., Garcia, R. I. & Guo, R. (2010). Fixed and random effects selection in mixed
effectsmodels.Biometrics,no.doi:10.1111/j.1541-0420.2010.01463.x.
Laird, N. M. & Ware, J. H. (1982). Random-effects models for longitudinal data. Biometrics 83,
1014–1022.
Meier,L.,vandeGeer,S.&Bühlmann,P.(2008).Thegrouplassoforlogisticregression.J.Roy.Statist.
Soc.Ser.BStatist.Methodol.70,53–71.
Meinshausen,N.&Bühlmann,P.(2006).High-dimensionalgraphsandvariableselectionwiththelasso.
Ann.Statist.34,1436–1462.
Meinshausen, N. & Yu, B. (2009). Lasso-type recovery of sparse representations for high-dimensional
data.Ann.Statist.,37,246–270.
Meinshausen, N. & Bühlmann, P. (2010). Stability selection (with discussion). J. Roy. Statist. Soc. Ser.
BStatist.Methodol.72,417–473.
Meinshausen, N., Meier, L. & Bühlmann, P. (2009). p-values for high-dimensional regression. J. Amer.
Statist.Assoc.104,1671–1681.
Ni, X., Zhang, D. & Zhang, H. H. (2010). Variable selection for semiparametric mixed models in
longitudinalstudies.Biometrics 66,79–88.
Osborne,M.R.,Presnell,B.&Turlach,B.(2000).Anewapproachtovariableselectioninleastsquares
problems.IMAJ.Numer.Anal.20,389–403.
Pinheiro,J.C.&Bates,D.M.(2000).Mixed-effectsmodelsinSandS-plus.Springer-Verlag,NewYork.
Städler,N.,Bühlmann,P.&vandeGeer,S.(2010).l -penalizationformixtureregressionmodels(with
1
discussion).TEST 19,209–285.
Tibshirani,R.(1996).Regressionshrinkageandselectionviathelasso.J.Roy.Statist.Soc.Ser.BStatist.
Methodol.58,267–288.
Tseng,P.&Yun,S.(2009).Acoordinategradientdescentmethodfornonsmoothseparableminimiza-
tion.Math.Program.117,387–423.
Verbeke, G. & Molenberghs, G. (2000). Linear mixed models for longitudinal data. Springer-Verlag,
NewYork.
Wasserman,L.&Roeder,K.(2009).High-dimensionalvariableselection.Ann.Statist.37,2178–2201.
Wu, T. & Lange, K. (2008). Coordinate descent algorithms for lasso penalized regression. Ann. Appl.
Stat.2,224–244.
Zhang,C.-H.&Huang,J.(2008).Thesparsityandbiasofthelassoselectioninhigh-dimensionallinear
regression.Ann.Statist.36,1567–1594.
Zhao,P.&Yu,B.(2006).Onmodelselectionconsistencyoflasso.J.Mach.Learn.Res.7,2541–2563.
Zou,H.(2006).Theadaptivelassoanditsoracleproperties.J.Amer.Statist.Assoc.101,1418–1429.
Zou,H.,Hastie,T.&Tibshirani,R.(2007).Onthe“degreesoffreedom”ofthelasso.Ann.Statist.35,
2173–2192.
Received October 2010, in final form February 2011
Jürg Schelldorfer, Seminar für Statistik, Department of Mathematics, ETH Zurich, CH-8092 Zurich,
Switzerland.
E-mail: schelldorfer@stat.math.ethz.ch
©2011BoardoftheFoundationoftheScandinavianJournalofStatistics.
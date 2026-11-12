TheAnnalsofStatistics
2016,Vol.44,No.3,907–927
DOI:10.1214/15-AOS1371
©InstituteofMathematicalStatistics,2016
EXACT POST-SELECTION INFERENCE, WITH APPLICATION
TO THE LASSO
BY JASON D. LEE
∗,1,
DENNIS L. SUN
+,2,
YUEKAI SUN
∗,3
AND JONATHAN E. TAYLOR ‡,4
∗ +
UniversityofCalifornia,Berkeley ,CaliforniaPolytechnicStateUniversity
andStanfordUniversity‡
Wedevelopageneralapproachtovalidinferenceaftermodelselection.
Atthecoreofourframeworkisaresultthatcharacterizesthedistributionofa
post-selectionestimatorconditionedontheselectionevent.Wespecializethe
approachtomodelselectionbythelassotoformvalidconfidenceintervals
fortheselectedcoefficientsandtestwhetherallrelevantvariableshavebeen
includedinthemodel.
1. Introduction. As a statistical technique, linear regression is both simple
and powerful. Not only does it provide estimates of the “effect” of each variable,
but it also quantifies the uncertainty in those estimates, allowing inferences to be
madeabouttheeffects.However,inmanyapplications,apractitionerstartswitha
largepoolofcandidatevariables,suchasgenesordemographicfeatures,anddoes
notknowaprioriwhicharerelevant.Thisisespeciallyproblematicwhenthereare
morevariablesthanobservations,sincethenthemodelisunidentifiable(atleastin
thesettingwherethepredictorsareassumedfixed).
In such settings, it is tempting to let the data decide which variables to include
inthemodel.Forexample,onecommonapproachwhenthenumberofvariablesis
nottoolargeistofitalinearmodelwithallvariablesincluded,observewhichones
aresignificantatlevel α,andthenrefitthelinear modelwithonlythosevariables
included.Theproblemwiththisisthatthep-valuescannolongerbetrusted,since
thevariablesthatareselectedwilltendtobethosethataresignificant.Intuitively,
weare“overfitting”toaparticularrealizationofthedata.
To formalize the problem, consider the standard linear regression setup, where
theresponsey∈Rn isgeneratedfromamultivariatenormaldistribution:
(cid:2) (cid:3)
(1.1) y∼N μ,σ2I
n
ReceivedJanuary2015;revisedSeptember2015.
1SupportedbyaNationalDefenseScienceandEngineeringGraduateFellowshipandaStanford
GraduateFellowship.
2SupportedbyaRicWeiland GraduateFellowshipandtheStanfordGenomeTraining Program
(SGTP;NIH/NHGRI).
3SupportedinpartbytheNIHGrantU01GM102098.
4SupportedbytheNSFGrantDMS-12-08857,andbyAFOSRGrant113039.
MSC2010subjectclassifications.Primary62F03,62J07;secondary62E15.
Keywordsandphrases.Lasso,confidenceinterval,hypothesistest,modelselection.
907

| 908 | LEE,SUN,SUNANDTAYLOR |     |     |
| --- | -------------------- | --- | --- |
where μ is modeled as a linear function of predictors x ,...,x ∈Rn, and σ2 is
1 p
assumedknown.(Weconsiderthemorerealisticcasewhereσ2isunknowninSec-
⊂{1,...,p}
tion 8.1.) We choose a subset M and ask for the linear combination
| ofthepredictorsinM | thatminimizestheexpectederror,thatis, |                 |     |
| ------------------ | ------------------------------------- | --------------- | --- |
|                    |                                       | (cid:4) (cid:4) |     |
|                    | ≡argminE(cid:4)                       | bM(cid:4)2=X    | +   |
| (1.2)              | βM                                    | y−X             | μ,  |
M M
bM
| + ≡(XT | −1XT |     |     |
| ------ | ---- | --- | --- |
where X X M ) is the pseudo-inverse of X M . Notice that (1.2) im-
| M   | M M |            |                   |
| --- | --- | ---------- | ----------------- |
|     | βM  | βM (cid:7) | (cid:8)=M (cid:7) |
plies that the targets and in different models M are in general dif-
|     | j   | j   |     |
| --- | --- | --- | --- |
ferent. This is simply a restatement of the well-known fact that a regression co-
efficient describes the effect of a predictor, adjusting for the other predictors in
the model. In general, the coefficient of a predictor cannot be compared across
differentmodels.
Thus, “inference after selection” is ambiguous in linear regression because the
targetofinferencechangeswiththeselectedmodel[Berketal.(2013)].Inthenext
section,wediscussseveralwaystoresolvethisambiguity.
2. Post-selection inference in linear regression. At first blush, the fact that
βM
the target changes with the model is deeply troubling, since it seems to im-
ply that the parameters are random. However, the randomness is actually in the
choice of which parameters to consider, not in the parameters themselves. Imag-
inethatthereareapriorip2p−1
well-definedpopulationparameters,oneforeach
coefficientinall2p
possiblemodels:
|     | (cid:5) |                    | (cid:6) |
| --- | ------- | ------------------ | ------- |
|     | βM      | :M ⊂{1,...,p},j ∈M | .       |
j
βM ˆ ˆ
We only ever form inferences for the parameters in the model M we select.
j
This adaptive choice of which parameters to consider can lead to inferences with
undesirablefrequencyproperties,asnotedbyBenjaminiandYekutieli(2005)and
Benjamini,HellerandYekutieli(2009).
ˆ ˆ
Tobeconcrete,supposewewantaconfidenceintervalCM foraparameterβM.
j j
ˆ
What frequency properties should CM have? By analogy to the classical setting,
j
wemightrequirethat
(cid:2) (cid:3)
|     |     | P βM ˆ ∈CM ˆ ≥1−α, |     |
| --- | --- | ------------------ | --- |
j j
βM
but the event inside the probability is not well-defined because is undefined
j
whenj ∈/M.TwowaysaroundthisissuearesuggestedbyBerketal.(2013):
Conditionalcoverage:SinceweformanintervalforβM
| 1.  |     |     | ifandonlyifmodel |
| --- | --- | --- | ---------------- |
j
ˆ =M,
M is selected, that is, M it makes sense to condition on this event. Hence,

POST-SELECTIONINFERENCEFORTHELASSO 909
| wemightrequirethatourconfidenceintervalCM |     |     |     |     | satisfy |     |
| ----------------------------------------- | --- | --- | --- | --- | ------- | --- |
j
|     |     |     | (cid:2)    | (cid:3)    |     |     |
| --- | --- | --- | ---------- | ---------- | --- | --- |
|     |     |     | P βM ∈CM|M | ˆ =M ≥1−α. |     |     |
(2.1)
|     |     |     | j j |     |     |     |
| --- | --- | --- | --- | --- | --- | --- |
The benefit of this approach is that we avoid ever having to compare coefficients
(cid:7)
| acrosstwodifferentmodelsM |     |     | (cid:8)=M | .   |     |     |
| ------------------------- | --- | --- | --------- | --- | --- | --- |
Anotherwaytounderstandconditioningonthemodelistoconsiderdatasplit-
ting [Cox (1975)], an approach to post-selection inference that most statisticians
would agree is valid. In data splitting, the data is divided into two halves, with
onehalfusedtoselectthemodelandtheotherusedtoconductinference.Fithian,
Sun and Taylor (2014) argues that inferences obtained by data splitting are only
validconditionalonthemodelthatwasselectedonthefirsthalfofthedata.There-
fore,conditionalcoverageisareasonablefrequencypropertytorequireofapost-
selectionconfidenceinterval.
2. Simultaneouscoverage:Italsomakessensetotalkabouteventsthatarede-
ˆ
fined simultaneously over all j ∈M . Berk et al. (2013) propose controlling the
familywiseerrorrate
|       |     |        | (cid:2) |              |     | (cid:3) |
| ----- | --- | ------ | ------- | ------------ | --- | ------- |
|       |     |        | ˆ       | ˆ            |     | ˆ       |
| (2.2) |     | FWER≡P | βM      | ∈/CM foranyj | ∈M  | ,       |
|       |     |        | j       | j            |     |         |
butthisisverystringentwhenmanypredictorsareinvolved.
Instead of controlling the probability of making any error, we can control the
expectedproportionoferrors—although“proportionoferrors”isambiguousinthe
eventthatweselectzerovariables.BenjaminiandYekutieli(2005)simplydeclare
ˆ|=0:
theerrortobezerowhen|M
|     |     |     | (cid:7) | ˆ ˆ        |     | (cid:8) |
| --- | --- | --- | ------- | ---------- | --- | ------- |
|     |     |     | |{j ∈M  | ˆ :βM ∈/CM | }|  |         |
ˆ|>0
| (2.3) |     | FCR≡E |     | j j | ;|M | ,   |
| ----- | --- | ----- | --- | --- | --- | --- |
ˆ|
|M
ˆ|>0:
whileStorey(2003)suggestsconditioningon|M
|     |     |     | (cid:7) |                  |           | (cid:8) |
| --- | --- | --- | ------- | ---------------- | --------- | ------- |
|     |     |     | |{j ∈M  | ˆ :β M ˆ ∈/C M ˆ | }|(cid:9) |         |
(cid:9)
| (2.4) |     | pFCR≡E |     | j j | (cid:9)|M ˆ|>0 | .   |
| ----- | --- | ------ | --- | --- | -------------- | --- |
ˆ|
|M
ˆ|>0),pFCRcon-
Thetwocriteriaarecloselyrelated.SinceFCR=pFCR·P(|M
trolimpliesFCRcontrol.
Thetwowaysabovearerelated:conditionalcoverage(2.1)impliespFCR(2.4)
(andhence,FCR)control.
|     |     |     |     | {C  | M} ˆ |     |
| --- | --- | --- | --- | --- | ---- | --- |
LEMMA 2.1. Consider a family of intervals ˆ that each have condi-
j j∈M
tional(1−α)coverage:
|     | (cid:2) |      | (cid:3) |            |      |     |
| --- | ------- | ---- | ------- | ---------- | ---- | --- |
|     |         | ˆ    | ˆ ˆ     |            |      |     |
|     | P βM    | ∈/CM | |M =M   | ≤α forallM | andj | ∈M. |
|     |         | j    | j       |            |      |     |
ThenFCR≤pFCR≤α.

910 LEE,SUN,SUNANDTAYLOR
ˆ
| PROOF. ConditiononM | anditerateexpectations: |     |          |                            |                        |
| ------------------- | ----------------------- | --- | -------- | -------------------------- | ---------------------- |
|                     | (cid:7) (cid:7)         | ˆ   | ˆ        | ˆ }|(cid:9) (cid:8)(cid:9) | (cid:8)                |
|                     | |{j                     | ∈M  | :β M ∈/C | M                          |                        |
| pFCR=E              | E                       |     | j        | j (cid:9) ˆ                | (cid:9) (cid:9)|M ˆ|>0 |
(cid:9)M
|M ˆ|
(cid:10)
|     | (cid:7) |       | ˆ       | ˆ ˆ )(cid:9) | (cid:8) |
| --- | ------- | ----- | ------- | ------------ | ------- |
|     |         | ˆ P(β | M ∈/C M | |M           |         |
|     | j∈M     |       | j j     | (cid:9) ˆ|>0 |         |
|     | =E      |       |         | (cid:9)|M    |         |
|M ˆ|
|     | (cid:7) |     | (cid:8) |     |     |
| --- | ------- | --- | ------- | --- | --- |
α|M ˆ|(cid:9)
(cid:9) ˆ|>0
|     | ≤E  | (cid:9)|M |     |     |     |
| --- | --- | --------- | --- | --- | --- |
ˆ|
|M
=α. (cid:2)
Theorem 2 in Weinstein, Fithian and Benjamini (2013) proves a special case
of Lemma 2.1 for a particular selection procedure, and Proposition 11 in Fithian,
Sun and Taylor (2014) provides a more general result, but this result is sufficient
for our purposes: to establish that conditional coverage is a sensible criterion to
considerinpost-selectioninference.
Although the criterion is easy to state, how do we construct an interval with
conditionalcoverage?Thisrequiresthatweunderstandtheconditionaldistribution
|     | (cid:5) | (cid:6) |     | (cid:2) | (cid:3) |
| --- | ------- | ------- | --- | ------- | ------- |
ˆ
|     | y| M (y)=M | ,   | y∼N | μ,σ2I | .   |
| --- | ---------- | --- | --- | ----- | --- |
One of the main contributions of this paper is to show that this distribution is
indeed possible to characterize, making valid post-selection inference feasible in
thecontextoflinearregression.
3. Outlineofourapproach. Wehavearguedthatpost-selectionintervalsfor
−
regression coefficients should have 1 α coverage conditional on the selected
model:
|     | (cid:2)    |     |      | (cid:3) |     |
| --- | ---------- | --- | ---- | ------- | --- |
|     | P βM ∈CM|M |     | ˆ =M | ≥1−α,   |     |
|     | j          | j   |      |         |     |
both because this criterion is interesting in its own right and because it implies
FCR control. To obtain an interval with this property, we study the conditional
distribution
ˆ
(3.1) ηT y|{M =M},
M
whichwillallow,moregenerally,conditionalinferenceforparametersoftheform
+
ηT μ.Inparticular,theregressioncoefficientsβM =eTX μcanbewritteninthis
| M   |     |     |     | j j | M   |
| --- | --- | --- | --- | --- | --- |
form,ascanmanyotherlinearcontrasts.
Our paper focuses on the specific case where the lasso is used to select the
| ˆ   |     |     |     |     | ˆ   |
| --- | --- | --- | --- | --- | --- |
model M . We begin in Section 4 by characterizing the event {M =M} for the
lasso.Asitturnsout,thiseventisaunionofpolyhedra.Moreprecisely,theevent

POST-SELECTIONINFERENCEFORTHELASSO 911
{M ˆ =M,sˆ =s }, that specifies the model and the signs of the selected vari-
M M
ables,isapolyhedronoftheform
(cid:5) (cid:6)
y∈Rn:A(M,s )y≤b(M,s ) .
M M
Therefore, if we condition on both the model and the signs, then we only need
tostudy
(3.2) ηTy|{Ay≤b}.
WedothisinSection5.Itturnsoutthatthisconditionaldistributionisessentially
a(univariate)truncatedGaussian.WeusethistoderiveastatisticFz(ηTy)whose
distributiongiven{Ay≤b}isUnif(0,1).
3.1. Related work. The resulting post-selection test has a similar structure to
the pathwise significance tests of Lockhart et al. (2014) and Taylor et al. (2014),
which also are conditional tests. However, the intended application of our test is
different. While their significance tests are specifically intended for the path con-
text, our framework allows more general questions about the model the lasso se-
lects: we can test the model at any value of λ or form confidence intervals for an
individualcoefficientinthemodel.
Thereisalsoaparallelliteratureonconfidenceintervalsforcoefficientsinhigh-
dimensionallinearmodelsbasedonthelassoestimator[JavanmardandMontanari
(2013), van de Geer et al. (2013), Zhang and Zhang (2014)]. The difference be-
tweentheirworkandoursisthattheydonotaddresspost-selectioninference;their
ˆ
target is β0, the coefficients in the true model, rather than βM, the coefficients in
ˆ
the selected model. The two will not be the same unless M happens to contain
all nonzero coefficients of β0. Although inference for β0 is appealing, it requires
assumptions about correctness of the linear model and sparsity of β0. Pötscher
and Schneider (2010) consider confidence intervals for the hard-thresholding and
soft-thresholdingestimatorsinthecaseoforthogonaldesign.Ourapproachinstead
regardstheselectedmodelasalinearapproximationtothetruth,aviewsharedby
Berketal.(2013)andMiller(2002).
The idea of post-selection inference conditional on the selected model appears
inPötscher(1991),althoughthenotionofinferenceconditionaloncertainrelevant
subsetsdatesbacktoFisher(1956);seealsoRobinson(1979).LeebandPötscher
(2005, 2006) obtained a number of negative results about estimating the distribu-
tion of a post-selection estimator, although they note their results do not neces-
sarilyprecludethepossibilityofpost-selectioninference.BenjaminiandYekutieli
(2005)alsoconsiderconditioning ontheselectionevent,althoughtheyarguethat
thisistooconservative.Tothecontrary,weshowthatconditioningontheselected
modelcanproducereasonableconfidenceintervalsinawidevarietyofsituations.
Inferenceconditionalonselectionhasalsoappearedinliteratureonthewinner’s
curse: Sampson and Sill (2005), Sill and Sampson (2009), Zhong and Prentice

| 912 | LEE,SUN,SUNANDTAYLOR |     |     |
| --- | -------------------- | --- | --- |
(2008), Zollner and Pritchard (2007). These works are not really associated with
model selection in linear regression, though they employ a similar approach to
inference.
4. The lasso and its selection event. In this paper, we apply our post-
selection inference procedure to the model selected by the lasso [Tibshirani
(1996)].Thelassoestimateisthesolutiontotheusualleastsquaresproblemwith
| anadditional(cid:6) penaltyonthecoefficients: |     |     |     |
| --------------------------------------------- | --- | --- | --- |
1
|       | ˆ         | 1                                        |     |
| ----- | --------- | ---------------------------------------- | --- |
| (4.1) | β ∈argmin | (cid:11)y−Xβ(cid:11)2+λ(cid:11)β(cid:11) | .   |
2 1
2
β
The (cid:6) penalty shrinks many of the coefficients to exactly zero, and the tradeoff
1
between sparsity and fit to the data is controlled by the penalty parameter λ≥0.
ˆ
However, the distribution of the lasso estimator β is known only in the less in-
n(cid:12)p
teresting case Knight and Fu (2000), and even then, only asymptotically.
Inferencebasedonthelassoestimatorisstillanopenquestion.
Becausethelassoproducessparsesolutions,wecandefinemodel“selected”by
thelassotobesimplythesetofpredictorswithnonzerocoefficients:
ˆ ˆ
|     | M   | ={j :β | (cid:8)=0}. |
| --- | --- | ------ | ----------- |
j
βM, {M ˆ =
Then post-selection inference seeks to make inferences about given
M},asdefinedin(1.2).
Therestofthissectionfocusesoncharacterizingthisevent{M ˆ =M}.Webegin
ˆ sˆ
by noting that in order for a vector of coefficients β and a vector of signs to be
solutions tothelassoproblem (4.1),itis necessaryand sufficientthattheysatisfy
theKarush–Kuhn–Tucker(KKT)conditions:
|     | XT(Xβ | ˆ −y)+λsˆ=0, |     |
| --- | ----- | ------------ | --- |
(4.2)
|     | sˆ =sign(β | ˆ ) | ifβ ˆ (cid:8)=0, |
| --- | ---------- | --- | ---------------- |
|     | i          | j   | j                |
(4.3)
|     | sˆ ∈ [−1,1] |     | ˆ =0. |
| --- | ----------- | --- | ----- |
|     | i           | ifβ | j     |
FollowingTibshirani(2013),weconsidertheequicorrelationset
|       | (cid:5)             |     | (cid:6) |
| ----- | ------------------- | --- | ------- |
|       | ˆ ≡ i∈{1,...,p}:|sˆ |     | |=1     |
| (4.4) | M                   |     | i .     |
ˆ
NoticethatwehaveimplicitlyidentifiedthemodelM withtheequicorrelationset.
ˆ
Since|sˆ |=1foranyβ (cid:8)=0,theequicorrelationsetdoesinfactcontainallpredic-
| i   | i   |     |     |
| --- | --- | --- | --- |
tors with nonzero coefficients, although it may also include some predictors with
zerocoefficients.However,foralmosteveryλ,theequicorrelationsetisprecisely
thesetofpredictorswithnonzerocoefficients.
{(M ˆ ,sˆ)=(M,s)}
It turns out that it is easier to first characterize and obtain
ˆ
{M =M}asacorollarybytakingaunionoverthepossiblesigns.Thenextresult
isanimportantfirststep.

POST-SELECTIONINFERENCEFORTHELASSO 913
LEMMA 4.1. Assume the columns of X are in general position [Tibshirani
(2013)]. Let M ⊂{1,...,p} and s∈{−1,1}|M| be a candidate set of variables
andtheirsigns,respectively.Definetherandomvariables
(cid:2) (cid:3) (cid:2) (cid:3)
(4.5) w(M,s):= XT X −1 XT y−λs ,
M M M
(4.6) u(M,s):=XT (cid:2) XT (cid:3) + s+ 1 XT (I −P )y,
−M M λ −M M
whereP ≡X (XT X ) −1X isprojectionontothecolumnspanofX .Then
M M M M M M
theselectionprocedurecanberewrittenintermsofwanduas
(cid:5) (cid:6) (cid:5) (cid:2) (cid:3) (cid:4) (cid:4) (cid:6)
(4.7) (M ˆ ,sˆ)=(M,s) = sign w(M,s) =s, (cid:4) u(M,s) (cid:4) <1 .
∞
PROOF. First, we rewrite the KKT conditions (4.2) by partitioning them ac-
cording to the equicorrelation set M ˆ , adopting the convention that −M ˆ means
ˆ
“variablesnotinM”:
X M T ˆ (X M ˆβ ˆ M ˆ −y)+λsˆ M ˆ =0,
X − T M ˆ (X M ˆβ ˆ M ˆ −y)+λsˆ −M ˆ =0,
sign(β ˆ ˆ)=sˆ ˆ,
M M
(cid:11)sˆ −M ˆ (cid:11) ∞<1.
Since the KKT conditions are necessary and sufficient for a solution, we obtain
that{(M ˆ ,sˆ)=(M,s)}ifandonlyifthereexistwandusatisfying
XT (X w−y)+λs=0,
M M
XT (X w−y)+λu=0,
−M M
sign(w)=s,
(cid:11)u(cid:11) ∞<1.
Wecansolvethefirsttwoequationsfor w and u toobtaintheequivalentsetof
conditions
(cid:2) (cid:3) (cid:2) (cid:3)
w= XT X −1 XT y−λs ,
M M M
u=XT (cid:2) XT (cid:3) + s+ 1 XT (I −P )y,
−M M λ −M M
sign(w)=s,
(cid:11)u(cid:11) ∞<1,
wherethefirsttwoarethedefinitions of w and u givenin(4.5)and(4.6),andthe
lasttwoaretheconditionsonwandugivenin(4.7). (cid:2)

914 LEE,SUN,SUNANDTAYLOR
Lemma 4.1 is remarkable because it says that the event {(M ˆ ,sˆ)=(M,s)} can
be rewritten as affine constraints on y. This is because w and u are already affine
functionsofy,andtheconstraintssign(·)=sand(cid:11)·(cid:11) ∞<1canalsoberewritten
intermsofaffineconstraints.Thefollowingpropositionmakesthisexplicit.
PROPOSITION 4.2. Letwandubedefinedasin(4.5)and(4.6).Then
(cid:11)(cid:12) (cid:13) (cid:12) (cid:13)(cid:14)
(cid:5) (cid:6) A (M,s) b (M,s)
(4.8) sign(w)=s,(cid:11)u(cid:11) ∞<1 = 0 y< 0 ,
A (M,s) b (M,s)
1 1
where A 0 ,b 0 encode the “inactive” constraints {(cid:11)u(cid:11) ∞ <1}, and A 1 ,b 1 encode
the“active”constraints{sign(w)=s}.Thesematriceshavetheexplicitforms
(cid:15) (cid:16)
A (M,s)= 1 X − T M (I −P M ) ,
0 λ −XT (I −P )
−M M
(cid:15) (cid:2) (cid:3) (cid:16)
1−XT XT + s
b (M,s)= −M (cid:2) M (cid:3) ,
0 1+XT XT + s
−M M
(cid:2) (cid:3)
A (M,s)=−diag(s) XT X −1 XT ,
1 M M M
(cid:2) (cid:3)
b (M,s)=−λdiag(s) XT X −1 s.
1 M M
PROOF. First,substitutingexpression(4.5)forw,werewritethe“active”con-
straintsas
(cid:5) (cid:6) (cid:5) (cid:6)
sign(w)=s = diag(s)w>0
(cid:5) (cid:2) (cid:3) (cid:2) (cid:3) (cid:6)
= diag(s) XT X −1 XT y−λs >0
M M M
(cid:5) (cid:6)
= A (M,s)y<b (M,s) .
1 1
Next, substituting expression (4.6) for u, we rewrite the “inactive” constraints
as
(cid:11) (cid:14)
(cid:5) (cid:11)u(cid:11) ∞<1 (cid:6) = −1<X
−
T
M
(cid:2) X
M
T (cid:3) + s+
λ
1 X
−
T
M
(I −P
M
)y<1
(cid:5) (cid:6)
= A (M,s)y<b (M,s) . (cid:2)
0 0
CombiningLemma4.1withProposition4.2,weobtainthefollowing.
(cid:2) (cid:3) (cid:2) (cid:3)
THEOREM 4.3. Let A(M,s)=
A
A0
1
(
(
M
M
,
,
s
s
)
)
and b(M,s)=
b
b0
1
(
(
M
M
,
,
s
s
)
)
, where A
i
andb aredefinedinProposition4.2.Then
i
(cid:5) (cid:6)
{M ˆ =M,sˆ=s}= A(M,s)y≤b(M,s) .

POST-SELECTIONINFERENCEFORTHELASSO 915
FIG.1. AgeometricpictureillustratingTheorem4.3forn=2andp=3.ThelassopartitionsRn
intopolyhedraaccordingtotheselectedmodelandsigns.
Asacorollary,{M ˆ =M}issimplytheunionoftheaboveeventsoverallpossi-
blesignpatterns.
(cid:17)
COROLLARY 4.4. {M ˆ =M}= s∈{−1,1}|M| {A(M,s)y≤b(M,s)}.
Figure 1 illustrates Theorem 4.3 and Corollary 4.4. The lasso partitions of Rn
into polyhedra according to the model it selects and the signs of the coefficients.
The shaded area corresponds to the event {M ˆ ={1,3}}, which is a union of two
polyhedra.Noticethatthesignpatterns{+,−}and{−,+}arenotpossibleforthe
model{1,3}.
5. Polyhedral conditioning sets. In order to obtain inference conditional on
themodel,weneedtounderstandthedistributionof
ηT y|{M ˆ =M}.
M
However,aswesawintheprevioussection,{M ˆ =M}isaunionofpolyhedra,so
itiseasiertoconditiononboththemodelandthesigns,
ηT y|{M ˆ =M,sˆ=s},
M
sincetheconditioningeventisasinglepolyhedron {A(M,s)y≤b(M,s)}.Notice
thatinferencesthatarevalidconditionalonthisfinereventwillalsobevalidcon-
ditionalon{M ˆ =M}.Forexample,ifaconfidenceintervalCM forβM has(1−α)
j j
coverageconditionalonthemodelandsigns
(cid:2) (cid:3)
P βM ∈CM|M ˆ =M,sˆ=s ≥1−α,
j j

| 916 |     |     | LEE,SUN,SUNANDTAYLOR |     |     |     |
| --- | --- | --- | -------------------- | --- | --- | --- |
it will also have (1−α) coverage conditional only on the model by the Law of
TotalProbability:
(cid:18)
| (cid:2)    |      | (cid:3) | (cid:2) |       |           | (cid:3)        |
| ---------- | ---- | ------- | ------- | ----- | --------- | -------------- |
| P βM ∈CM|M | ˆ =M | =       | P βM    | ∈CM|M | ˆ =M,sˆ=s | P(sˆ=s|M ˆ =M) |
| j          | j    |         | j       | j     |           |                |
s
(cid:18)
ˆ
|     |     | ≥   | (1−α)P(sˆ=s|M |     |     | =M) |
| --- | --- | --- | ------------- | --- | --- | --- |
s
=1−α.
Thissectionisdividedintotwosubsections.First,westudyhowtoconditionon
|     |     |     |     |     |     | {M ˆ =M,sˆ=s}. |
| --- | --- | --- | --- | --- | --- | -------------- |
a single polyhedron; this will allow us to condition on Then we
extendtheframeworktoconditiononaunionofpolyhedra,whichwillallowusto
conditiononlyonthemodel{M ˆ =M}.Theinferencesobtainedbyconditioningon
themodelwillingeneralbemoreefficient(i.e.,narrowerintervals,morepowerful
tests),atthepriceofmorecomputation.
5.1. Conditioningonasinglepolyhedron. Supposeweobservey∼N(μ,(cid:7)),
andη∈Rn issomedirectionofinterest.Tounderstandthedistributionof
| (5.1)  |     |     | ηTy|{Ay≤b}, |     |     |     |
| ------ | --- | --- | ----------- | --- | --- | --- |
| {Ay≤b} |     |     | ηTy         |     |     |     |
we rewrite in terms of and a component z which is independent of
ηTy.Thatcomponentis
|       |     |     | (cid:2) |      | (cid:3) |     |
| ----- | --- | --- | ------- | ---- | ------- | --- |
|       |     |     | z≡      | −cηT |         |     |
| (5.2) |     |     | I n     |      | y,      |     |
where
|       |     |     |            | (cid:2)    | (cid:3) −1 |     |
| ----- | --- | --- | ---------- | ---------- | ---------- | --- |
| (5.3) |     |     | c≡(cid:7)η | ηT(cid:7)η | .          |     |
ηTy.
It is easy to verify that z is uncorrelated with, and hence independent of,
Noticethatinthecasewhere (cid:7)=σ2I , z issimplytheresidual (I −P )y from
n n η
projectingyontoη.
Wecannowrewrite{Ay≤b}intermsofηTyandz.
LEMMA5.1. Letzbedefinedasin(5.2)andcasin(5.3).Thenthecondition-
ingsetcanberewrittenasfollows:
|     |         |     | (cid:5)       |     |             | (cid:6) |
| --- | ------- | --- | ------------- | --- | ----------- | ------- |
|     | {Ay≤b}= |     | V− (z)≤ηTy≤V+ |     | (z),V0(z)≥0 |         |
,
where
−(Az)
b
| (5.4) |     | V−  | (z)≡ max  |     | j    | j , |
| ----- | --- | --- | --------- | --- | ---- | --- |
|       |     |     | j:(Ac)j<0 |     | (Ac) |     |
j
b −(Az)
|       |     | V+  | (z)≡      |     | j    | j   |
| ----- | --- | --- | --------- | --- | ---- | --- |
| (5.5) |     |     | min       |     |      | ,   |
|       |     |     | j:(Ac)j>0 |     | (Ac) |     |
j
| (5.6) |     | V0(z)≡ | min     | b   | −(Az) | .   |
| ----- | --- | ------ | ------- | --- | ----- | --- |
|       |     |        |         | j   |       | j   |
|       |     |        | j:(Ac)j | =0  |       |     |
Note that V− , V+ , and V0 refer to functions. Since they are functions of z only,
(5.4)–(5.6)areindependentofηTy.

|     |     | POST-SELECTIONINFERENCEFORTHELASSO |     |     |     |     |     | 917 |
| --- | --- | ---------------------------------- | --- | --- | --- | --- | --- | --- |
{Ay ≤ b}
FIG. 2. A geometric interpretation of why the event can be characterized as
| {V− (z)≤ηTy≤V+ |     |     |     |     |     | V− V+ |     |     |
| -------------- | --- | --- | --- | --- | --- | ----- | --- | --- |
(z)}. Assuming (cid:7)=I and (cid:11)η(cid:11) =1, (z) and (z) are functions of z
2
only,whichisindependentofηTy.
Wecandecomposey=c(ηTy)+zandrewritethepolyhedronas
PROOF.
|     |         |     | (cid:5) (cid:2) (cid:2) | (cid:3) | (cid:3) (cid:6) |     |     |     |
| --- | ------- | --- | ----------------------- | ------- | --------------- | --- | --- | --- |
|     | {Ay≤b}= |     |                         | ηTy +z  | ≤b              |     |     |     |
A c
|     |     |     | (cid:5) (cid:2) | (cid:3) | (cid:6) |     |     |     |
| --- | --- | --- | --------------- | ------- | ------- | --- | --- | --- |
|     |     | =   | ηTy             | ≤b−Az   |         |     |     |     |
Ac
|     |     |     | (cid:5) | (cid:2) | (cid:3)  | (cid:6) |         |     |
| --- | --- | --- | ------- | ------- | -------- | ------- | ------- | --- |
|     |     | =   |         | ηTy     | ≤b −(Az) |         |         |     |
|     |     |     | (Ac)    | j       | j j      | forallj |         |     |
|     |     |     | ⎧       |         |          |         | ⎫       |     |
|     |     |     | ⎪⎪⎪⎪⎪⎪⎨ | b       | − ( A z) |         | ⎪⎪⎪⎪⎪⎪⎬ |     |
|     |     |     | ηTy≤    | j       | j        | :(Ac)   |         |     |
|     |     |     |         |         | , forj   | >0,     |         |     |
|     |     |     |         |         | ( A c )  | j       |         |     |
j
|     |     | =   |              | b   | −(Az)  |       | ,       |     |
| --- | --- | --- | ------------ | --- | ------ | ----- | ------- | --- |
|     |     |     | ⎪⎪⎪⎪⎪⎪⎩ ηTy≥ | j   | j      | :(Ac) | ⎪⎪⎪⎪⎪⎪⎭ |     |
|     |     |     |              |     | , forj | <0,   |         |     |
|     |     |     |              |     | (Ac)   | j     |         |     |
j
|     |     |     | 0≤b | −(Az) | , forj | :(Ac) =0 |     |     |
| --- | --- | --- | --- | ----- | ------ | -------- | --- | --- |
|     |     |     |     | j     | j      | j        |     |     |
where in the last step, we have divided the components into three categories de-
(cid:3)0,sincethisaffectsthedirectionoftheinequality(or
| pendingonwhether(Ac) |     |     | j   |     |     |     |     |     |
| -------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
ηTy
whether wecandivide atall). Since is thesamequantity forall j,itmustbe
V−
atleast the maximum ofthe lower bounds, whichis (z),and nomorethan the
| minimumoftheupperbounds,whichisV+ |     |     |     |     | (cid:2) |     |     |     |
| --------------------------------- | --- | --- | --- | --- | ------- | --- | --- | --- |
(z).
Lemma5.1tellsusthat
|       | (cid:26)   |           | (cid:27) | (cid:26)    | (cid:5)       |             | (cid:6)(cid:27) |       |
| ----- | ---------- | --------- | -------- | ----------- | ------------- | ----------- | --------------- | ----- |
|       | ηTy|{Ay≤b} |           | =d       | ηTy|        | V− (z)≤ηTy≤V+ | (z),V0(z)≥0 |                 |       |
| (5.7) |            |           |          |             |               |             | .               |       |
|       | V+ (z),V−  | (z),V0(z) |          |             | ηTy,          |             |                 |       |
| Since |            |           | are      | independent | of            | they behave | as “fixed”      | quan- |
tities. Thus, ηTy is conditionally like a normal random variable, truncated to be
| betweenV− | (z)andV+ |     |     |     |     |     |     |     |
| --------- | -------- | --- | --- | --- | --- | --- | --- | --- |
(z).Wewouldliketobeabletosay
|     |                |     |     |     | (cid:2)             |        | (cid:3) |     |
| --- | -------------- | --- | --- | --- | ------------------- | ------ | ------- | --- |
|     | “ηTy|{Ay≤b}∼TN |     |     |     | ηTμ,σ2ηT(cid:7)η,V− | (z),V+ |         |     |
|     |                |     |     |     |                     | (z)    | ,”      |     |
but this is technically incorrect, since the distribution on the right-hand side
changes with z. By conditioning on the value of z, ηTy|{Ay ≤ b,z = z } is a
0
truncated normal. We can then use the probability integral transform to obtain

918 LEE,SUN,SUNANDTAYLOR
a statistic Fz(ηTy) that has a Unif(0,1) distribution for any value of z. Hence,
Fz(ηTy) will also have a Unif(0,1) distribution marginally over z. We make this
preciseinthenexttheorem.
THEOREM 5.2. Let F
[a,b]
denote the CDF of a N(μ,σ2) random variable
μ,σ2
truncatedtotheinterval[a,b],thatis,
(5.8) F [a,b] (x)=
(cid:8)((x−μ)/σ)−(cid:8)((a−μ)/σ)
,
μ,σ2 (cid:8)((b−μ)/σ)−(cid:8)((a−μ)/σ)
where(cid:8)istheCDFofaN(0,1)randomvariable.Then
(5.9) F [V− (z),V+ (z)] (cid:2) ηTy (cid:3) |{Ay≤b}∼Unif(0,1),
ηTμ,ηT(cid:7)η
whereV− andV+
aredefinedin(5.4)and(5.5).Furthermore,
(cid:26) (cid:27) (cid:2) (cid:3)
ηTy|Ay≤b,z=z ∼TN ηTμ,σ2(cid:11)η(cid:11)2,V− (z ),V+ (z ) .
0 0 0
PROOF. First,applyLemma5.1:
(cid:26) (cid:27) (cid:26) (cid:27)
ηTy|Ay≤b,z=z =d ηTy|V− (z)≤ηTy≤V+ (z),V0(z)≥0,z=z
0 0
(cid:26) (cid:27)
=d ηTy|V− (z )≤ηTy≤V+ (z ),V0(z )≥0,z=z .
0 0 0 0
TheonlyrandomquantitiesleftareηTyandz.Nowwecaneliminatez=z from
0
theconditionusingindependence:
(cid:26) (cid:27) (cid:26) (cid:27)
ηTy|Ay≤b,z=z =d ηTy|V− (z )≤ηTy≤V+ (z )
0 0 0
(cid:2) (cid:3)
∼TN ηTμ,σ2(cid:11)η(cid:11)2,V− (z ),V+ (z ) .
0 0
Letting Fz(ηTy)≡F
[V−(z),V+(z)]
(ηTy), we can apply the probability integral
ηTμ,ηT(cid:7)η
transformtotheaboveresulttoobtain
(cid:26) (cid:2) (cid:3) (cid:27) (cid:26) (cid:2) (cid:3) (cid:27)
Fz ηTy |Ay≤b,z=z =d Fz0 ηTy |Ay≤b,z=z
0 0
∼Unif(0,1).
If we let p denote the density of a random variable X given {Ay≤b}, what we
X
havejustshownisthat
p (t,z )
p
Fz(ηTy)|z
(t|z
0
)≡ Fz(η
p
Ty
(
)
z
,z
)
0 =1[0,1](f)
z 0
foranyz .Thedesiredresultnowfollowsbyintegratingoverz :
0 0
(cid:28)
p (t)= p (t|z )p (z )dz
Fz(ηTy) Fz(ηTy)|z 0 z 0 0
(cid:28)
= 1[0,1](t)p
z
(z
0
)dz
0
=1[0,1](t). (cid:2)

|     |     | POST-SELECTIONINFERENCEFORTHELASSO |     |     |     | 919 |
| --- | --- | ---------------------------------- | --- | --- | --- | --- |
5.2. Conditioning on a union of polyhedra. We have just characterized the
|     |     | ηTy, |     |     | {Ay≤b}. |     |
| --- | --- | ---- | --- | --- | ------- | --- |
distribution of conditional on y falling into a single polyhedron
We obtain such a polyhedron if we condition on both the model and the signs
| ˆ   |     |     |     |     | ˆ   |     |
| --- | --- | --- | --- | --- | --- | --- |
{M =M,sˆ =s}. If we want to only condition on the model {M =M}, then we
ηTy,
will have to understand the distribution of conditional on y falling into a
unionofsuchpolyhedra,thatis,
(cid:9)(cid:29)
| (5.10) |     |     | ηTy (cid:9) | {A y≤b }. |     |     |
| ------ | --- | --- | ----------- | --------- | --- | --- |
s s
s
As Figure 3 makes clear, the argument proceeds exactly as before, except that
ηTy
is now truncated to a union of intervals, instead of a single interval. There is
a V− and a V+ for each possible sign pattern s, so we index the intervals by the
signs. This leads immediately to the next theorem, whose proof is essentially the
sameasthatofTheorem5.2.
FS N(μ,σ2)
| THEOREM |     | 5.3. Let | denote | the CDF of a | random | variable |
| ------- | --- | -------- | ------ | ------------ | ------ | -------- |
μ,σ2
truncatedtothesetS.Then
|        |     | (cid:17) −     | + (cid:2) (cid:3)(cid:9) | (cid:29)            |     |     |
| ------ | --- | -------------- | ------------------------ | ------------------- | --- | --- |
|        |     | [V             | (z),V (z)] ηTy (cid:9)   | {A y≤b }∼Unif(0,1), |     |     |
| (5.11) |     | F s s          | s                        |                     |     |     |
|        |     | ηTμ,ηT(cid:7)η |                          | s s                 |     |     |
s
| whereV− | (z)andV+ | (z)aredefinedin(5.4)and(5.5)andA=A |     |     | andb=b |     |
| ------- | -------- | ---------------------------------- | --- | --- | ------ | --- |
.
|     | s   | s   |     |     | s   | s   |
| --- | --- | --- | --- | --- | --- | --- |
6. Post-selection intervals for regression coefficients. In this section, we
combine the characterization of the lasso selection event in Section 4 with the
ηTy
FIG. 3. When we take the union over signs, the conditional distribution of is trun-
cated to a union of disjoint intervals. In this case, the Gaussian is truncated to the set
|       | +           | −           |     |     |     |     |
| ----- | ----------- | ----------- | --- | --- | --- | --- |
| (−∞,V | −,−}(z)]∪[V | +,+}(z),∞). |     |     |     |     |
|       | {           | {           |     |     |     |     |

920 LEE,SUN,SUNANDTAYLOR
resultsaboutthedistributionofaGaussiantruncatedtoapolyhedron(orunionof
polyhedra) in Section 5 to form post-selection intervals for lasso-selected regres-
sioncoefficients.Thekeylinkisthatthelassoselectioneventcanbeexpressedas
aunionofpolyhedra:
(cid:29)
{M ˆ =M}= {M ˆ =M,sˆ=s}
s∈{−1,1}|M|
(cid:29) (cid:5) (cid:6)
= A(M,s)y≤b(M,s) ,
s∈{−1,1}|M|
where A(M,s) and b(M,s) are defined in Theorem 4.3. Therefore, conditioning
onselectionisthesameasconditioningonaunionofpolyhedra,sowecanapply
theframeworkofSection5.
Recall that our goal is to form confidence intervals for βM = eTX + μ, with
j j M
(1 − α)-coverage conditional on {M ˆ = M}. Taking η = (X + )Te , we can use
M j
Theorem5.3toobtain
F (cid:17) s [V s − (z),V s + (z)] (cid:2) ηTy (cid:3) |{M ˆ =M}∼Unif(0,1).
βM,σ2(cid:11)η(cid:11)2
j
This gives us a test statistic for testing any hypothesized value of βM. We can
j
invertthistesttoobtainaconfidenceset
(cid:11) (cid:14)
(6.1) CM ≡ βM :
α
≤F
(cid:17)
s
[V
s
− (z),V
s
+ (z)] (cid:2)
ηTy
(cid:3)
≤1−
α
.
j j 2 βM,σ2(cid:11)η(cid:11)2 2
j
Infact,thesetCM isaninterval,asformalizedinthenextresult.
j
THEOREM 6.1. Letη=(X
M
+ )Te
j
.Let L and U bethe(unique)valuessatis-
fying
F
(cid:17)
s
[V
s
− (z),V
s
+ (z)] (cid:2)
ηTy
(cid:3)
=1−
α
, F
(cid:17)
s
[V
s
− (z),V
s
+ (z)] (cid:2)
ηTy
(cid:3)
=
α
.
L,σ2(cid:11)η(cid:11)2 2 U,σ2(cid:11)η(cid:11)2 2
Then [L,U] is a (1−α) confidence interval for βM, conditional on {M ˆ =M},
j
thatis,
(cid:2) (cid:3)
(6.2) P βM ∈[L,U]|M ˆ =M =1−α.
j
PROOF. Byconstruction,P
βM
(β
j
M ∈C
j
M|M ˆ =M)=1−α,whereC
j
M isde-
j
fined in (6.1). The claim is that the set CM is in fact the interval [L,U]. To see
j (cid:17)
this,weneedtoshowthattheteststatistic F s
[V
s
− (z),V
s
+ (z)]
(ηTy) ismonotonede-
L,σ2(cid:11)η(cid:11)2
creasinginβM sothatitcrosses1− α and α atuniquevalues.Thisfollowsfrom
j 2 2
the fact that the truncated Gaussian distribution has monotone likelihood ratio in
themeanparameter.SeetheAppendixfordetails. (cid:2)

POST-SELECTIONINFERENCEFORTHELASSO 921
Alternatively,wecouldhaveconditionedonthesigns,inadditiontothemodel,
so that we would only have to condition on a single polyhedron. We also showed
inSection5that
F [V s − (z),V s + (z)] (cid:2) ηTy (cid:3) |{M ˆ =M,sˆ=s}∼Unif(0,1).
βM,σ2(cid:11)η(cid:11)2
j
Invertingthisstatisticwillproduceintervalsthathave(1−α)coverageconditional
on {M ˆ =M,sˆ=s}, and hence (1−α) coverage conditional on {M ˆ =M}. How-
ever, these intervals will be less efficient; they will in general be wider. However,
one may be willing to sacrifice statistical efficiency for computational efficiency.
NoticethatthemaincostincomputingintervalsaccordingtoTheorem6.1isdeter-
mining the intervals [V− (z),V+ (z)] for each s∈{−1,1}|M| . The number of such
s s
signpatternsis2 |M| .Whilethismightbefeasiblewhen|M|issmall,itisnotfea-
sible whenweselect hundreds of variables. Conditioning onthe signs means that
weonlyhavetocomputetheinterval[V− (z),V+ (z)]forthesignpatternsthatwas
s s
actuallyobserved.
Figure4showsthetradeoffinstatisticalefficiency.Whenthesignalisstrong,as
intheleft-handplot,thereisvirtuallynodifferencebetweentheintervalsobtained
by conditioning on just the model, or the model and signs. On the other hand, in
theright-handplot,weseethatwecanobtainverywideintervalswhenthesignal
isweak.Thewidestintervalsareforactualnoisevariables,asexpected.
Tounderstandwhypost-selectionintervalsaresometimesverywide,noticethat
when a truncated Gaussian random variable Z is close to the endpoints of the
truncation interval [a,b], there are many means μ that would be consistent with
that observation—hence, the wide intervals. Figure 5 shows confidence intervals
for μ as a function of Z. When Z is far from the endpoints of the truncation
FIG. 4. Comparison of the confidence intervals by conditioning on the model only (statistically
moreefficient,butcomputationallymoreexpensive)andconditioningonboththemodelandsigns
(statistically less efficient, but computationally more feasible). Data were simulated for n=25,
p=50, and 5 true nonzero coefficients; only the first 20 coefficients are shown. (Variables with
nointervalsareincludedtoemphasizethatinferenceisonlyontheselectedvariables.)Conditioning
on the signs in addition to the model results in no loss of statistical efficiency when the signal is
strong(left)butisproblematicwhenthesignalisweak(right).

922 LEE,SUN,SUNANDTAYLOR
FIG.5. Upperandlowerboundsof90%confidenceintervalsforμbasedonasingleobservation
x/σ ∼TN(0,1,−3,3).Weseethataslongastheobservationx isroughly0.5σ awayfromeither
boundary,thesizeoftheintervalsiscomparabletotheunadjustedOLSconfidenceinterval.
interval, we basically recover the nominal OLS intervals (i.e., not adjusted for
selection).
The implications are clear. When the signal is strong, ηTy will be far from the
endpointsofthetruncationregion,soweobtainthenominalOLSintervals.Onthe
other hand, when a variable just barely entered the model, then ηTy will be close
totheedgeofthetruncationregion,andtheintervalwillbewide.
6.1. Optimality. WehavederivedaconfidenceintervalCM whoseconditional
j
coverage, given {M ˆ =M}, is at least 1−α. The fact that we have found such an
intervalisnotremarkable,sincemanysuchintervalshavethisproperty.However,
given two intervals with the same coverage, we generally prefer the shorter one.
This problem is considered in Fithian, Sun and Taylor (2014) where it is shown
thatCM is,withonesmalltweak,theshortestintervalamongallunbiasedintervals
j
with1−α coverage.
AnunbiasedintervalC foraparameterθ isonewhichcoversnootherparame-
terθ (cid:7) withprobabilitymorethan1−α,thati,
(cid:2) (cid:3)
(6.3) P θ (cid:7)∈C ≤1−α forallθ,θ (cid:7)(cid:8)=θ.
θ
Unbiasednessisacommonrestrictiontoensuretheexistenceofanoptimalinterval
[Lehmann and Romano (2005)]. The shortest unbiased interval for βM, among
j
all intervals with conditional 1−α coverage, resembles to the interval [L,U] in
Theorem 6.1. There, the critical values L and U were chosen symmetrically so
that the pivot has α/2 area in either tail. However, it may be possible to obtain a
shorter interval on average by allocating the a probability unequally between the
twotails.Theorem5ofFithian,SunandTaylor(2014)providesageneralformula
forobtainingshortestunbiasedintervalsinexponentialfamilies.

POST-SELECTIONINFERENCEFORTHELASSO 923
7. Data example. We apply our post-selection intervals to the diabetes data
setfromEfronetal.(2004).Sincep<nforthisdataset,wecanestimateσ2using
the residual sum of squares from the full regression model with all p predictors.
Afterstandardizingallvariables,wechoseλaccordingtothestrategyinNegahban
et al. (2012), λ=2E((cid:11)XTε(cid:11) ∞). This expectation was computed by simulation,
whereε∼N(0,σˆ2),resultinginλ≈190.Thelassoselectedfourvariables:BMI,
BP,S3andS5.
The post-selection intervals are shown in Figure 6, alongside the nominal con-
fidence intervals produced by fitting OLS to the four selected variables, ignoring
selection. The nominal intervals do not have (1−α) coverage conditional on the
model and are not valid post-selection intervals. Also depicted are the confidence
intervals obtained by data splitting, as discussed in Section 2. This is a competi-
tormethodthatalsoproducesvalidconfidenceintervalsconditionalonthemodel.
The lasso selected the same four variables on half of the data, and then nominal
intervalsforthesefourvariablesusingOLSontheotherhalfofthedata.
WecanmaketwoobservationsfromFigure6.
1. The adjusted intervals provided by our method essentially reproduces the
OLS interva√ls for the strong effects, whereas data splitting intervals are wider by
a factor of 2 (since only n/2 observations are used in the inference). For this
dataset, the POSI intervals are 1.36 times wider than the OLS intervals. For all
the variables, our method produces the shortest intervals among the methods that
controlselectivetype1error.
FIG. 6. Inferenceforthefourvariablesselectedbythelasso(λ=190)onthediabetesdataset.
ThepointestimateandadjustedconfidenceintervalsusingtheapproachinSection6areshownin
black.TheOLSintervals,whichignoreselection,areshowninred.Thegreenlinesshowtheintervals
producedbysplittingthedataintotwohalves,formingtheintervalbasedononlyhalfofthedata.
ThebluelinecorrespondstothePOSImethodofBerketal.(2013).

| 924 |     | LEE,SUN,SUNANDTAYLOR |     |     |     |     |
| --- | --- | -------------------- | --- | --- | --- | --- |
2. Onevariable,S3whichwouldhavebeendeemedsignificantusingtheOLS
intervals,isnolongersignificantafteraccountingforselection.Datasplitting,our
selection-adjustedintervals,andPOSIintervalsconcludethatS3isnotsignificant.
This demonstrates that taking model selection into account can have substantive
impactsontheconclusions.
8. Extensions.
Estimationofσ2. Theaboveresultsrelyonknowingσ2oratleasthaving
8.1.
a good estimate of it. If n>p, then the variance σˆ2 of the residuals from fitting
thefullmodelisaconsistentestimatorandingeneralcanbesubstitutedforσ2 to
yieldasymptoticallyvalidconfidenceintervals.Formally,theconditionisthatthe
pivot is smooth with respect to σ. Geometrically speaking, the upper and lower
|     | V+  | V−  |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- |
truncation limits and must be well-separated (with high probability). We
refertheinterestedreadertoSection2.3inTianandTaylor(2015)fordetails.
In the setting where p >n, obtaining an estimate of σ2 is more challenging,
but if the pivot satisfies a monotonicity property, plugging in an overestimate of
thevariance gives conservative confidence intervals. Wereferthereader toTheo-
rem11inTibshiranietal.(2015)fordetails.
8.2. Elasticnet. Oneproblemwiththelassoisthatittendstoselectonevari-
able out of a set of correlated variables, resulting in estimates that are unstable.
One way to stabilize them is to add an (cid:6) penalty to the lasso objective, resulting
2
intheelasticnet[ZouandHastie(2005)]:
|       |           | 1                                        |     |     | γ                     |     |
| ----- | --------- | ---------------------------------------- | --- | --- | --------------------- | --- |
|       | ˜ =argmin | (cid:11)y−Xβ(cid:11)2+λ(cid:11)β(cid:11) |     |     | + (cid:11)β(cid:11)2. |     |
| (8.1) | β         |                                          |     |     | 1                     |     |
|       |           | 2                                        |     | 2   | 2                     | 2   |
β
ˆ
Using a nearly identical argument to Lemma 4.1, we see that {M =M,sˆ=s} if
| andonlyifthereexistw˜ | andu˜ |     |     |     |     |     |
| --------------------- | ----- | --- | --- | --- | --- | --- |
satisfying
|     | (cid:2) |       | (cid:3) |         |     |     |
| --- | ------- | ----- | ------- | ------- | --- | --- |
|     | XT      | X +γI | w˜ −XT  | y+λs=0, |     |     |
|     | M       | M     |         | M       |     |     |
|     |         | XT    | (X w˜   | −y)+λu˜ | =0, |     |
−M M
sign(w˜)=s,
(cid:11)u˜(cid:11)
∞<1.
ThesefourconditionsdifferfromthoseofLemma4.1inonlyonerespect:XT X
M M
+γI.
in the first expression is replaced by XT X Continuing the argument of
M M
Section4,weseethattheselectioneventcanberewritten
|       |                | (cid:11)(cid:12) | ˜         | (cid:13) | (cid:12)˜ | (cid:13)(cid:14) |
| ----- | -------------- | ---------------- | --------- | -------- | --------- | ---------------- |
|       |                |                  | A (M,s)   |          | b (M,s)   |                  |
|       | {M ˆ =M,sˆ=s}= |                  | 0         |          | 0         |                  |
| (8.2) |                |                  |           | y<       | ˜         | ,                |
|       |                |                  | A ˜ (M,s) |          | b (M,s)   |                  |
|       |                |                  | 1         |          | 1         |                  |

POST-SELECTIONINFERENCEFORTHELASSO 925
˜ ˜
where A and b areanalogous to A and b inProposition4.2,exceptreplacing
k k k k
(XT X ) −1 by(XT X +γI) −1 everywhereitappears.Noticethat(XT X ) −1
M M M M M M
appears explicitly in A and b , and also implicitly in A and b , since P and
1 1 0 0 M
(XT ) + bothdependon(XT X ) −1.
M M M
Now that we have rewritten the selection event in the form {Ay≤b}, we can
once again apply the framework in Section 5 to obtain a test for the elastic net
conditionalonthisevent.
9. Conclusion. Model selection and inference have long been regarded as
conflictinggoalsinlinearregression.FollowingtheleadofBerketal.(2013),we
have proposed a framework for post-selection inference that conditions on which
modelwasselected,thatis,theevent{M ˆ =M}.Wecharacterizethiseventforthe
lasso and derive optimal and exact confidence intervals for linear contrasts ηTμ,
conditionalon{M ˆ =M}.Withthisgeneralframework,wecanformpost-selection
intervals for regression coefficients, equipping practitioners with a way to obtain
“valid”intervalsevenaftermodelselection.
APPENDIX:MONOTONICITYOFF
LEMMAA.1. LetF
μ
(x):=F
μ
[a
,σ
,b
2
] (x)denotethecumulativedistributionfunc-
tionofatruncatedGaussianrandomvariable,asdefinedasin(5.8).Then F (x)
μ
ismonotonedecreasinginμ.
PROOF. First, the truncated Gaussian distribution with CDF F
μ
:=F
μ
[a
,σ
,b
2
] is
a natural exponential family in μ, since it is just a Gaussian with a different base
measure.Therefore,ithasmonotonelikelihoodratioinμ.Thatis,forallμ >μ
1 0
andx >x :
1 0
f (x ) f (x )
μ1 1
>
μ1 0
,
f (x ) f (x )
μ0 1 μ0 0
where f :=dF denotes the density. (Instead of appealing to properties of ex-
μi μi
ponentialfamilies,thispropertycanalsobedirectlyverified.)
Thisimplies
f (x )f (x )>f (x )f (x ), x >x .
μ1 1 μ0 0 μ1 0 μ0 1 1 0
Therefore,theinequalityispreservedifweintegratebothsideswithrespecttox
0
on(−∞,x)forx<x .Thisyields
1
(cid:28) (cid:28)
x x
f (x )f (x )dx > f (x )f (x )dx , x<x ,
−∞
μ1 1 μ0 0 0
−∞
μ1 0 μ0 1 0 1
f (x )F (x)>f (x )F (x), x<x .
μ1 1 μ0 μ0 1 μ1 1
Nowweintegratebothsideswithrespecttox on(x,∞)toobtain
1
(cid:2) (cid:3) (cid:2) (cid:3)
1−F (x) F (x)> 1−F (x) F (x)
μ1 μ0 μ0 μ1
whichestablishesF (x)>F (x)forallμ >μ . (cid:2)
μ0 μ1 1 0

926 LEE,SUN,SUNANDTAYLOR
Acknowledgements. We thank Will Fithian, Sam Gross and Josh Loftus for
helpful comments and discussions. In particular, Will Fithian provided insights
thatledtothegeometricintuitionofourprocedureshowninFigure2.
REFERENCES
BENJAMINI,Y.,HELLER,R.andYEKUTIELI,D.(2009).Selectiveinferenceincomplexresearch.
Philos.Trans.R.Soc.Lond.Ser.AMath.Phys.Eng.Sci.3674255–4271.MR2546387
BENJAMINI, Y. and YEKUTIELI, D. (2005).Falsediscoveryrate-adjustedmultipleconfidencein-
tervalsforselectedparameters.J.Amer.Statist.Assoc.10071–93.MR2156820
BERK,R.,BROWN,L.,BUJA,A.,ZHANG,K.andZHAO,L.(2013).Validpost-selectioninference.
Ann.Statist.41802–837.MR3099122
COX,D.R.(1975).Anoteondata-splittingfortheevaluationofsignificancelevels.Biometrika62
441–444.MR0378189
EFRON,B.,HASTIE,T.,JOHNSTONE,I.andTIBSHIRANI,R.(2004).Leastangleregression.Ann.
Statist.32407–499.MR2060166
FISHER,R.(1956).OnatestofsignificanceinPearson’sBiometrikaTables(No.11).J.Roy.Statist.
Soc.Ser.B.1856–60.MR0082773
FITHIAN, W.,SUN, D.andTAYLOR, J.(2014).Optimalinferenceaftermodelselection.Preprint.
AvailableatarXiv:1410.2597.
JAVANMARD,A.andMONTANARI,A.(2013).Confidenceintervalsandhypothesistestingforhigh-
dimensionalregression.Preprint.AvailableatarXiv:1306.3171.
KNIGHT,K.andFU,W.(2000).Asymptoticsforlasso-typeestimators.Ann.Statist.281356–1378.
MR1805787
LEEB, H.andPÖTSCHER, B.M.(2005).Modelselectionandinference:Factsandfiction.Econo-
metricTheory2121–59.MR2153856
LEEB, H. and PÖTSCHER, B. M. (2006). Can one estimate the conditional distribution of post-
model-selectionestimators?Ann.Statist.342554–2591.MR2291510
LEHMANN,E.L.andROMANO,J.P.(2005).TestingStatisticalHypotheses,3rded.Springer,New
York.MR2135927
LOCKHART,R.,TAYLOR,J.,TIBSHIRANI,R.andTIBSHIRANI,R.(2014).Asignificancetestfor
thelasso(withdiscussion).Ann.Statist.42413–468.MR3210970
MILLER, A. (2002). SubsetSelection in Regression,2nded.Chapman &Hall/CRC, BocaRaton,
FL.MR2001193
NEGAHBAN, S. N.,RAVIKUMAR, P.,WAINWRIGHT, M. J. andYU, B. (2012).Aunifiedframe-
workforhigh-dimensionalanalysisofM-estimatorswithdecomposableregularizers.Statist.Sci.
27538–557.MR3025133
PÖTSCHER,B.M.(1991).Effectsofmodelselectiononinference.EconometricTheory7163–185.
MR1128410
PÖTSCHER,B.M.andSCHNEIDER,U.(2010).Confidencesetsbasedonpenalizedmaximumlike-
lihoodestimatorsinGaussianregression.Electron.J.Stat.4334–360.MR2645488
ROBINSON,G.K.(1979).Conditionalpropertiesofstatisticalprocedures.Ann.Statist.7742–755.
MR0532239
SAMPSON,A.R.andSILL,M.W.(2005).Drop-the-losersdesign:Normalcase.Biom.J.47257–
268.MR2145117
SILL,M.W.andSAMPSON,A.R.(2009).Drop-the-losersdesign:Binomialcase.Comput.Statist.
DataAnal.53586–595.MR2654594
STOREY,J.D.(2003).Thepositivefalsediscoveryrate:ABayesianinterpretationandtheq-value.
Ann.Statist.312013–2035.MR2036398

POST-SELECTIONINFERENCEFORTHELASSO 927
TAYLOR,J.,LOCKHART,R.,TIBSHIRANI,R.J.andTIBSHIRANI,R.(2014).Post-selectionadap-
tiveinferenceforleastangleregressionandthelasso.Preprint.AvailableatarXiv:1401.3889.
TIAN, X. and TAYLOR, J. (2015). Asymptotics of selective inference. Preprint. Available at
arXiv:1501.03588.
TIBSHIRANI,R.(1996).Regressionshrinkageandselectionviathelasso.J.Roy.Statist.Soc.Ser.B
58267–288.MR1379242
TIBSHIRANI, R. J. (2013). The lasso problem and uniqueness. Electron. J. Stat. 7 1456–1490.
MR3066375
TIBSHIRANI,R.J.,RINALDO,A.,TIBSHIRANI,R.andWASSERMAN,L.(2015).Uniformasymp-
toticinferenceandthebootstrapaftermodelselection.Preprint.AvailableatarXiv:1506.06266.
VAN DE GEER, S., BÜHLMANN, P., RITOV, Y. and DEZEURE, R. (2013). On asymptoti-
cally optimal confidence regions and tests for high-dimensional models. Preprint. Available at
arXiv:1303.0518.
WEINSTEIN,A.,FITHIAN,W.andBENJAMINI,Y.(2013).Selectionadjustedconfidenceintervals
withmorepowertodeterminethesign.J.Amer.Statist.Assoc.108165–176.MR3174610
ZHANG, C.-H.andZHANG, S. S.(2014).Confidenceintervalsforlowdimensionalparametersin
highdimensionallinearmodels.J.R.Stat.Soc.Ser.B.Stat.Methodol.76217–242.MR3153940
ZHONG,H.andPRENTICE,R.L.(2008).Bias-reducedestimatorsandconfidenceintervalsforodds
ratiosingenome-wideassociationstudies.Biostatistics9621–634.
ZOLLNER,S.andPRITCHARD,J.K.(2007).Overcomingthewinner’scurse:Estimatingpenetrance
parametersfromcase-controldata.Am.J.Hum.Genet.80605–615.
ZOU,H.andHASTIE,T.(2005).Regularizationandvariableselectionviatheelasticnet.J.R.Stat.
Soc.Ser.B.Stat.Methodol.67301–320.MR2137327
J.D.LEE D.L.SUN
UNIVERSITYOFCALIFORNIA,BERKELEY CALIFORNIAPOLYTECHNICSTATEUNIVERSITY
465SODAHALL BUILDING25,ROOM107D
BERKELEY,CALIFORNIA94720 SANLUISOBISPO,CALIFORNIA
USA USA
E-MAIL:jasondlee@berkeley.edu E-MAIL:dennisliusun@gmail.com
Y.SUN J.E.TAYLOR
UNIVERSITYOFCALIFORNIA,BERKELEY STANFORDUNIVERSITY
367EVANSHALL 390SERRAMALL
BERKELEY,CALIFORNIA94720 STANFORD,CALIFORNIA
USA USA
E-MAIL:yuekai@berkeley.edu E-MAIL:jonathan.taylor@stanford.edu
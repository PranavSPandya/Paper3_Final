Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Diagnostic and
https://doi.org/10.1186/s41512-020-00074-3
Prognostic Research
COMMENTARY Open Access
State of the art in selection of variables and
functional forms in multivariable
—
analysis outstanding issues
Willi Sauerbrei1*, Aris Perperoglou2, Matthias Schmid3, Michal Abrahamowicz4, Heiko Becher5, Harald Binder1,
Daniela Dunkler6, Frank E. Harrell Jr7, Patrick Royston8, Georg Heinze6 and for TG2 of the STRATOS initiative
Abstract
Background: How to selectvariablesand identify functional forms for continuous variables is a key concern when
creating a multivariable model.Adhoc ‘traditional’ approaches to variable selection have been in use for atleast 50
years. Similarly, methodsfor determining functional forms for continuous variables were first suggested many years
ago. Morerecently, many alternativeapproachesto address these two challenges have been proposed,but
knowledge of theirproperties and meaningful comparisons between them are scarce. To define a state ofthe art
and to provideevidence-supported guidance to researchers who have onlya basic level of statistical knowledge,
many outstanding issues inmultivariable modelling remain.Our main aims are to identify and illustrate such gaps
intheliteratureandpresentthematamoderatetechnicalleveltothewidecommunityofpractitioners,researchers
andstudentsofstatistics.
Methods:Webrieflydiscussgeneralissuesinbuildingdescriptiveregressionmodels,strategiesforvariableselection,
differentwaysofchoosingfunctionalformsforcontinuousvariablesandmethodsforcombiningtheselectionof
variablesandfunctions.Wediscusstwoexamples,takenfromthemedicalliterature,toillustrateproblemsinthe
practiceofmodelling.
Results:Ouroverviewrevealedthatthereisnotyetenoughevidenceonwhichtobaserecommendationsforthe
selectionofvariablesandfunctionalformsinmultivariableanalysis.Suchevidencemaycomefromcomparisons
betweenalternativemethods.Inparticular,wehighlightsevenimportanttopicsthatrequirefurtherinvestigationand
makesuggestionsforthedirectionoffurtherresearch.
Conclusions:Selectionofvariablesandoffunctionalformsareimportanttopicsinmultivariableanalysis.Todefinea
stateoftheartandtoprovideevidence-supportedguidancetoresearcherswhohaveonlyabasiclevelofstatistical
knowledge,furthercomparativeresearchisrequired.
Keywords:Descriptivemodelling,Methodsforvariableselection,Splineprocedures,Fractionalpolynomials,Categorisation,
Bias,Shrinkage,Empiricalevidence,STRATOSinitiative
*Correspondence:wfs@imbi.uni-freiburg.de
1InstituteofMedicalBiometryandStatistics,FacultyofMedicineandMedical
Center,UniversityofFreiburg,Freiburg,Germany
Fulllistofauthorinformationisavailableattheendofthearticle
©TheAuthor(s).2020OpenAccessThisarticleislicensedunderaCreativeCommonsAttribution4.0InternationalLicense,
whichpermitsuse,sharing,adaptation,distributionandreproductioninanymediumorformat,aslongasyougive
appropriatecredittotheoriginalauthor(s)andthesource,providealinktotheCreativeCommonslicence,andindicateif
changesweremade.Theimagesorotherthirdpartymaterialinthisarticleareincludedinthearticle'sCreativeCommons
licence,unlessindicatedotherwiseinacreditlinetothematerial.Ifmaterialisnotincludedinthearticle'sCreativeCommons
licenceandyourintendeduseisnotpermittedbystatutoryregulationorexceedsthepermitteduse,youwillneedtoobtain
permissiondirectlyfromthecopyrightholder.Toviewacopyofthislicence,visithttp://creativecommons.org/licenses/by/4.0/.

Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Page2of18
Introduction modelsforpredictionmaybeoptimisedforpredictiveaccur-
Progress in the theory of mathematical statistics and ex- acyandcanthenbemorecomplex(morevariablesincluded,
pansion of computational resources and technology have more complex functions allowed). With very complex and
led to rapid developments in statistical methodology, interrelated associations of covariates with the outcome and
resulting in many more complex and flexible statistical enoughdatatounravelsuchassociations,algorithmicmodel-
modelling techniques. Unfortunately, many of these ling approaches may become valuable modelling tools. No
methodological developments are ignored in the analysis matter if descriptiveness is important or not, biasses are in-
of medical data. Consequently, design and analysis of troduced by deriving the ‘final’ model data-dependently.
observational studies often exhibit serious weaknesses. However, the relevance of critical issues (such as biasses,
To help bridge the gap between recent methodological large variances, number of variables included and model
developments and applications, the STRengthening Ana- complexity)mustbeweighedagainstadvantageswithrespect
lytical Thinking for Observational Studies (STRATOS) totheintendedpurposeofmodelling.
initiative was launched in 2013 [98]. Currently, the ini- To obtain good descriptive models, the (interrelated)
tiative has nine topic groups working on various statis- challenges of selection of variables for inclusion and
tical issues in planning and analysis of observational choice of the functional forms for continuous variables
studies. Here we concentrate on issues relevant to topic must be tackled [50, 96], and this constitutes the main
group 2 (TG2) ‘selection of variables and functional aim of TG2. In general, the analyst is expected to con-
forms in multivariable analysis’, which focuses on identi- duct the analysis according to state of the art (SOTA)
fying influential variables and gaining insight into their methodology, which is defined in Wikipedia [124] as
individualandjointrelationships withtheoutcome. ‘State of the art refers to the highest level of general de-
Bydefinition,workinTG2isprimarilyconcernedwith velopment, as of a device, technique, or scientific field
statistical model building. In this respect, it should be achievedataparticulartime’.SOTAalsoplaysakeyrole
noted that STRATOS also has related topic groups in applications for funding of a research project, where a
working on prediction (TG6) and modelling issues in brief section summarising SOTA is often requested.
causal inference (TG7). In a thought-provoking paper, However, do we have enough evidence to define SOTA
Breiman [16] differentiated between a data modelling methodology forthe selection ofvariablesandfunctional
culture and an algorithmic modelling culture. In several forms forcontinuousvariables?
comments to this paper [26, 35], differences between About three decades ago, Picard and Cook [85] stated
possible ways of statistical modelling were discussed. ‘Exact distributional results [on maximum likelihood esti-
TG2 concentrates mainly on the data modelling culture. matesandteststatistics]arevirtuallyimpossibletoobtain
As the conflation and confusion between topics and ap- [because of data-dependent model building], even for the
proaches in modelling are common, we will clarify our simplest of common subset selection algorithms’. Al-
background and aim by referring to the paper ‘To Ex- thoughthereissubstantialprogress,currentdevelopments
plain or to Predict’ by Shmueli [106]. The latter author and empirical comparisons are inadequate to identify ad-
explains differences in three conceptual modelling vantages and disadvantages ofthe many variable selection
approaches: descriptive, predictive andexplanatorymod- techniques and to provide evidence-supported arguments
elling. Descriptive modelling is the most commonly used regardingSOTAstrategiesforvariableselection.
approach, and it mainly builds on the data modelling For more than 50years, suitable algorithms have been
culture. It does not directly aim at obtaining optimal available for various stepwise variable selection tech-
predictive performance, but at capturing the data struc- niques [37]. Triggered by the intention to derive suitable
ture parsimoniously. Nevertheless, a suitable descriptive ‘omics’ predictors (often called ‘gene signatures’) in
model is often also an acceptable predictive model. In high-dimensionaldata withmanymoreexplanatory vari-
some fields, the term explanatory modelling is used ables than observations, various techniques for selecting
exclusively for testing causal theory. As this paper con- variables have been proposed during the last two de-
centrates on issues in descriptive modelling, aspects of cades, adding to the long list of ‘traditional’ approaches.
causal modelling will be ignored as causal inferences Consequently,analystsmayhaveaccesstomanytoolkits,
cannot be drawn from models formulated using a de- but it is not straightforward which variable selection ap-
scriptiveapproach.SeeDorieetal.[31]andseveralcom- proach they should use and under what circumstances.
ments to this paper for a discussion of the large number Will the results be (seriously) influenced by the variable
ofissuesincausal inference. selectionmethodchosen?
The intended use of a model is a key consideration when Similar arguments apply to the methodology for deter-
choosingasuitableanalysisstrategy.Foradescriptivemodel, mining the functional form for continuous variables
interpretability, transportability and general usability are im- such as age, blood pressure, values of laboratory tests,
portant criteria. By contrast, if descriptiveness plays no role, exposure intensity or dose of a substance which often

Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Page3of18
play an important predictive or explanatory role. Assuming and/or modelling of a given variable may depend, some-
linear effects of such variables on the outcome is often the times critically, on whether and how some of the other
default choice and rarely questioned, but the reason for this variables are represented in the multivariable model.
isoftenignoranceandnottheresultofcarefullyconsidering The current paper focuses on popular multivariable re-
themostplausiblefunctionalform.Hence,thevariableselec- gression models, such as a normal-errors regression
tion problem needs to be combined with the selection of model for continuous outcomes, a logistic regression
suitable functional form(s) for continuous variables, i.e. the model for binary outcomes or the Cox proportional haz-
dose-responsefunction,substantiallyincreasingthecomplex- ards model for censored survival data. Arguably, these
ity of the modelling issues. For function selection, at least are the main types of regression models used in health
four general approaches, with several variations, are used in sciences applications. In health research, depending on
recent studies: assuming a priori a linear relationship, cat- the context, the terms risk factor, prognostic factor, pre-
egorisation,fractionalpolynomialsanddifferentspline-based dictor, exposure, covariate or confounder are often used
methods.Yet,whileallrelyonimportantexplicitorimplicit forvariables.Here wewillusetheminterchangeably.
assumptions and have some limitations, there is little guid- It is generally acknowledged that subject-matter know-
ance to choose between these approaches. Reasons for ledge should guide multivariable model-building. A study
selecting one or the other are rarely explained. Several should be carefully planned, guided by the research ques-
methods have been published, but the number of studies tionsandconsiderationofthemethodsenvisagedforana-
comparing alternative strategies is limited. Consequently, lysing the data. In randomised trials, a detailed analysis
therearestrongbarriersconcerningknowledgetransfer[86]. plan is written before the final data are collected and the
With a focus on applications in observational studies analysis starts. However, the situation is more complex
of human health, we provide a brief overview of existing with observational studies [96]. For example, when con-
methods for variable selection, identify some issues with sidering the association between a continuous exposure
each of the four approaches to represent the functional andtheprobabilityofdevelopingadisease,subject-matter
form for continuous variables and discuss topics requir- knowledgedoesnot alwaysgive clear advicefor the set of
ing further research. This is an important step on the potential confounders that the model should be adjusted
long way to provide evidence-supported arguments re- fornorinparticularforthefunctionalformsoftheirasso-
garding SOTA methodology for building multivariable ciationwiththeoutcome[10].Sincesubject-matterknow-
models with continuous variables. Experienced statisticians ledge is often limited or at best fragile, data-dependent
belonging to the STRATOS ‘level 2’ category (Table 1 in modelbuildingisnecessary[49].Pre-specifyingallaspects
[98])aretheintendedaudienceforthispaper. ofamodelisalmostinvariablyunrealisticinobservational
In the ‘General issues in building descriptive regres- studies. The gain of preventing bias by avoiding data-
sion models’ section, we discuss general issues in build- dependent model building is offset by the high cost of ig-
ing descriptive regression models. In the ‘Variable noring models which may fit the data much better than
selection strategies’ section, we briefly summarise the the pre-specified one. Also, what if assumptions under-
most popular methods of variable selection. Approaches lyingthepre-specifiedmodelareviolated?
to handle continuous variables are outlined in the ‘Con- A key issue of variable selection is which of the candi-
tinuous variables—to categorise or to model?’ section, date variables to include in the ‘final’ model. Some re-
and the combination of methods for variable and func- searchers argue that variables with ‘strong’ effects will be
tionalformselectionisdiscussedinthe‘Combiningvari- included by any sensible variable selection strategy and
able and function selection’ section. In the ‘Examples thatitislessimportanttoincludealargernumberofvari-
illustrating the problems’ section, we provide two exam- ableswithnoora‘small’ effect[99].Thepotentialcostof
ples of potentially suboptimal approaches to illustrate obtaining information on all selected variables also im-
weaknesses in analyses related to TG2 issues. In the ‘To- pingesonthegeneralusabilityofamodel.Iftheoriginally
wards state of the art—research required!’ section, we selected model indicates that a variable whose values are
identify some unsolved methodological issues that re- difficult to obtain has only a small effect on the outcome,
quire further research towards establishing SOTA meth- suchamodelwillbeinfrequentlyusedinpractice.
odology, before giving concluding remarks in the Breiman [14] states ‘When a regression problem con-
‘Discussion’section. tains many predictor variables, it is rarely wise to try to
fit the data by means of a least squares regression on all
General issues in building descriptive regression of the predictor variables. Usually, a regression equation
models based on a few variables will be more accurate and cer-
In most observational studies, a mix of continuous and tainly simpler.’
categorical variables are collected. Many of these vari- Variable selection methods aim to eliminate all un-
ablesarecorrelated, implyingthattheresultsofselection influential variables, at least at a defined evidential level

Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Page4of18
(e.g.anominalsignificancelevel).Data-dependentmodel Traditionalvariableselectionstrategies
building certainly introduces several types of bias and Traditional variable selection methods involve auto-
problems [49, 56, 108], including replication stability, se- mated iterative stepwise model building procedures that
lection bias, omitted variable bias, underestimation of rely on testing the statistical significance of the regres-
variance and overestimation of the predictive ability of a sion coefficients for all variables considered at a given
model. These are critically important for weak risk fac- step. One popular approach starts from a null model
tors, but ‘weak’ must be judged in the context of the containing no variables and adds one variable at a time,
sample size. The possible magnitude of these biasses corresponding to the most significant (lowest p value) of
must be weighed against the advantages of better inter- their contributions to improving model fit (forward se-
pretability ofsmallermodels. lection (FS)). Alternatively, a ‘full model’ including all
Another crucial issue for model building is the potentialexplanatoryvariablesisestimatedfirstandthen
functional form with which variables should enter the the least significant variables are eliminated one-by-one
variable selection procedure. In practice, continuous (backward elimination (BE)). The ‘stepwise’ approach
variables are often categorised before being subjected implemented in some software packages combines for-
to variable selection, although major weaknesses of ward selection with additional backward steps. The sig-
categorising continuous variables have been well- nificance level used as the stopping threshold is the
known for decades [3, 94]. Aside from categorisation tuning parameter that determines the size of the final
[105], assuming linearity is the norm. Flexible model- model[96].Thesmallerthelevel,thefewervariableswill
ling techniques based on various types of smoothers, beselected.
including fractional polynomials [93, 96] and several Biostatisticians widely agree that among the selection
types of splines [30, 38, 128], are available but are procedures just described, backward elimination, with or
still underused. Although selection of variables and without additional forward steps, is the preferable
functional forms for continuous variables both apply method as it already starts with a plausible model [73].
to many analyses, suitable methods that address both The backward elimination algorithm sets some regres-
issues are not often utilised. sion coefficients exactly to zero contrary to the actual
Of course, manymore analysis issues arise, such as the (unpenalised) maximum likelihood estimates of the re-
investigation of potential interactions between two or gression coefficients (which are usually never exactly
more predictors or interactions between a predictor and zero). This means that one intentionally moves away
follow-up time in a survival analysis (time-dependent ef- from the maximum likelihood solution by inducing bias.
fects). We do not consider them in what follows. Finally, Particularly for weak predictors, this bias may decrease
we stress that many decisions are required before model the variance because of an implicit shrinkage towards
building can start. For a discussion of several issues, we zero. However, if a weak predictor is ‘selected’ by the al-
refer to Chatfield [22], to the paper of Mallows [72] on gorithm, its corresponding regression coefficient may be
the ‘zeroth’ problem and to the first paper by the STRA seriously biassed away from zero [25, 79, 97]. The in-
TOS topic group TG3 (Initial data analysis), which dis- creased bias usually also increases the mean squared
cusses a conceptual framework to handle the large num- error (MSE) of the predicted value of the outcome, and
ber ofissues [63]. the random element contributed by an uncertain selec-
tion decision further contributes to MSE inflation. In a
Variable selection strategies recent review, Heinze et al. [56] proposed some
Virtually any statistical software package contains proce- resampling-based measures to estimate the bias condi-
dures for variable selection. This made their use very tional on selection and the inflation in (root) MSE
popular, particularly with end-users without a formal caused by the selection. Although intuitively appealing,
background in statistics. However, this wide availability their proposals are still to be validated in simulation
has been a breeding ground for common misapprehen- studies.
sions of the role and necessity for variable selection [56]. Backward elimination and other stepwise selection
In six subsections, we will briefly discuss key issues of methods are shortcuts to the computationally more ex-
traditional variable selection strategies, ‘change in esti- pensive best subset selection, where all possible models
mate’procedures,andmodernvariableselectionstrategies are estimated and their fit is compared using some infor-
basedonpenalisation,boostingandresampling.Shrinkage mation criterion. Different information criteria have been
methodswereproposedtocorrectforselectionbias,akey proposed, among which Akaike’s information criterion
issue caused by data-dependent modelling. This section (AIC) is in principle preferable for predictive models and
ends with a short summary of post-selection inference. Schwartz’s Bayesian information criterion (BIC) for de-
Two examples illustrating problems will be discussed in scriptive models [19]. The purpose of AIC is to approxi-
the‘Examplesillustratingtheproblems’section. mate the predictiveperformance, quantified by the model

Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Page5of18
deviance, which would be expected in validation inan in- change-in-estimate criterion evaluates if elimination of a
dependent sample drawn from the same population. By potentialconfounderfromthemodelwouldleadtoarele-
contrast,BICaimsatselectingthetruepredictorvariables vant change in the regression coefficients of the exposure
[87]. However, BIC cannot reach this goal unless the variable of interest. ‘Relevance’ is often defined as more
model space searched includes the ‘true data generating than,e.g.a10%changeintheregressioncoefficientofthe
model’ and the data set is large enough for such an ap- exposure of interest [66]. Hosmer, Lemeshow and col-
proximation to work. For comparison of two hierarchic- leaguesincorporatedthechange-in-estimatecriterioninto
ally nested models differing in only one model term with significance-based selection procedures, yielding their
one degree of freedom (df), AIC and BIC can be directly ‘purposeful selection’ [20, 61, 62]. This was later revisited
translated into significance tests of that model term. For by Dunkler et al. [33], who proposed modifying the
AIC, the corresponding threshold p value is 0.157. For change-in-estimate.Intheir‘augmentedbackwardelimin-
BIC,thethresholddependsonthesamplesize;thepenalty ation’procedure,non-significantvariablesarenotomitted
parameter is log(n) [111]. For example, sample sizes of from amodel if a standardised changeinestimatefollow-
100 or 400 correspond to significance levels of 0.032 or ing their elimination exceeds a certain pre-specified
0.014.Thus,whileAICwillincludemoreandmore(weak) threshold. They argue that their algorithm will generate
predictors with increasing sample size, selection by BIC final models that are close to the starting model and will
will become more and more strict. Originally, these cri- only eliminate really unnecessary variables. Therefore, the
teria were developed to compare a small number of pre- resulting bias is likely to be smaller than that induced by
specifiedmodels,nottoscreenalargemodelspace.How- theconventionalbackwardeliminationprocedure.
ever, nowadays, they are used more generally as a prag-
maticapproachtomodelselection. Modernvariableselectionstrategies
Best subset selection may not pose a big computa- Penalisedlikelihood
tional challenge in the era of parallel computing, but Ridge regression, proposed by Hoerl and Kennard [58],
even so, it may not be preferable to backward elimin- introduced a penalty term into the log-likelihood which
ation. The increased flexibility may engender a higher is proportional to the sum of squared regression coeffi-
probability of selecting ‘spurious’ predictors, i.e., to in- cients (L2-norm, L2 penalisation). While this approach
crease selection uncertainty. Furthermore, if variable se- provided shrinkage and solved issues of near-collinearity
lection is to be combined with selection of the and overfit, it did not yet address variable selection. Two
functional forms of continuous variables (see the ‘Com- approaches to combining variable selection with shrink-
bining variable and function selection’ section), a best age were proposed in the mid-1990s. The non-negative
subset selection procedure would increase the number garrottestarts withordinaryleastsquaresestimates from
of candidate models substantially. To the best of our the full model and estimates parameterwise shrinkage
knowledge,ithasnever been suggested. factors under a specified constraint [15]. For coefficients
‘Univariate selection’, i.e. selection of variables based on with a stronger effect, the shrinkage factor will be close
significanceinunivariableregressionmodels,isstillpopu- to1.Forvariablesthatareweakly associatedwith there-
lar, notably in high-dimensional studies in the fields of sponse, the least-squares estimate is likely to be small
bioinformatics and (epi-)genetics [44, 125]. For example, and consequently, the shrinkage factor will tend towards
the FDA-recommended CKD273 signature for diagno- zero, corresponding to variable elimination. As an esti-
sis of early kidney disease is based on univariate matefromthefullmodelisneeded,theapproachcannot
protein filtering followed by a machine learning algo- be used for the analysis of high-dimensional data. We
rithm applied to the filtered features [27, 46, 83]. consider this as one of the main reasons that the ap-
Among non-statisticians, many (seem to) believe that proach didnotbecomemorepopular.
univariate significance is a prerequisite for including a Shortly after the non-negative garrotte, Tibshirani
variable in a multivariable model [55]. In contrast, it [112] proposed the popular Lasso method, which con-
is generally accepted among statisticians that the dif- sists of penalising the log-likelihood of a model with a
ference between unadjusted and adjusted effects of a multiple of the sum of absolute regression coefficients
variable can go in either direction; therefore, that uni- (L1 penalisation). Consequently, some of the regression
variable selection may be misleading [109]. coefficients become exactly zero, and hence the method
providesavariableselection.Thestrengthofthepenalty,
Proceduresbasedon‘change-in-estimate’ i.e. the multiplier of the penalty term, often symbolised
Selection procedures based on the change-in-estimate are by λ, determines the size of the resulting model. Usually,
particularly popular in epidemiology, especially for the λ is estimated from the data. It can be determined in
situation where the effect of an exposure of main interest various ways, cross-validation being the most common.
should be adjusted for confounders [48, 66, 71]. The A practical problem with the Lasso penalty is that the

Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Page6of18
regression coefficients of different variables should all [76]foracomparison).Regardlessoftheirconceptualdif-
have the same scaling. This is usually achieved by work- ferences,bothapproachesmakeuseofthesamebasicidea
ing with standardised covariates, i.e. by first dividing for variable selection: starting with an empty model, only
each covariate by its empirical standard deviation. How- one regression coefficient is updated in each step of the
ever, different choices for standardisation may lead to boosting algorithm (‘component-wise’ updates). In con-
different results. Therefore, one should bear in mind trast to traditional forward selection, updates are done by
that the Lasso, unlike the traditional significance-based adding only small fractions (e.g. one tenth or one hun-
selection procedures, is not invariant to transformations dredth)oftheestimatedregressioncoefficientstotheesti-
of the covariates. Nowadays, the Lasso is widely access- mates obtained in previous steps (‘stagewise’ procedure).
ible because of many implementations in R (the glmnet Variable selection (i.e. selection of the regression coeffi-
package being the most popular [43] and in other soft- cienttoupdate)isdonebyevaluatingineachstepalluni-
ware packages. variableregressionmodelsconditionalontheestimatesof
The Lasso tends to screen variables rather than to se- the previous steps (used as offsets) and to select the vari-
lect them, meaning that it often includes variables with able corresponding to the best-fitting univariable model.
veryweakeffects.Furthermore, inthepresenceofcollin- Stopping the boosting algorithm before convergence
ear or grouped variables, the Lasso fails to select all vari- (‘early stopping’) results in variable selection and shrink-
ables in the group. For high-dimensional data where ‘p > age, like the Lasso. In fact, boosting and the LASSO are
n’, the Lasso can only select up to n variables. To ad- equivalent in specific settings and can even be shown to
dress these issues, modifications have been suggested in- be modifications of the same underlying algorithm (least
cluding the Elastic Net [129] and the Adaptive Lasso angleregression(LARS))[36],whichexplainstheirsimilar
[130]. The Elastic Net combines L1 (equivalent to the performance in many applications. The number of boost-
Lasso) and L2 (Ridge) penalisation, removing the limita- ing steps is the main tuning parameter of the procedure,
tion on the number of selected variables but also en- often optimised by cross-validation. Boosting algorithms
couraging grouped selection. An advantage of the Elastic are particularly useful in high-dimensional settings but
Net is that it includes L1 and L2 penalisation as special canalsobeappliedinthelow-dimensionalcase.
cases. The Adaptive Lasso penalises the log-likelihood
with λtimes a weightedsum of absolute regression coef- Resampling-basedvariableselectionprocedures
ficients, where the weights are determined in a pre- Since the mid-eighties of the last century, resampling
estimationstep, usually asthereciprocalabsoluteregres- procedures (usually the nonparametric bootstrap) have
sion coefficients from amaximum likelihood or ridge re- been proposed to assess model (in-)stability. The boot-
gression fit. The rationale for this is to down-weight strap inclusion frequencies (BIF) from a large number of
penalties of strong predictors and to up-weight weak resampling replications is used as a criterion for model
predictors in the penalty term. Usually, it results in selection [2, 23, 45]. These approaches are based on the
models withfewervariablesandstrongereffects. idea that variables with a ‘stronger effect’ are selected
Another popular modification with the same goal is with a high probability in each replication, whereas the
SmoothlyClippedAbsoluteDeviation(SCAD)[39],where selection of others may be a matter of chance. A BIF
coefficients larger in an absolute sense are penalised less thresholdneedstobechosenandonlyvariableswithlar-
thansmallerones.FurthergeneralisationsoftheLassoare gerBIFs areincluded inthemodel.
listedinTibshirani[113]andHastieetal.[54]. However, this simple ‘summary’ of the selected models
from resampling replications may result in selecting a
Boosting ‘bad’ model if the inclusion of two (or more) variables
Component-wise boosting is a forward stagewise regres- dependsoneachother.Oneimportantreasonisthecor-
sion procedure applicable to generalised linear models, relation structure of the candidate variables, which may
Cox models, quantile regression and many other types of strongly influence BIFs of some variables. It may happen
statistical regression models [11, 18, 115]. The method is that one of two variables is included in each of the repli-
rooted in the field of machine learning, where it was first cations, but the individual BIFs are not much higher
used for tree-based binary classification (AdaBoost algo- than 50%. Thus, based on its BIF, neither variable may
rithm) [40]. Based on work by Friedman et al. [42], who be judged important. To cope with such situations,
discovered the connection between boosting and logistic Sauerbrei and Schumacher [103] suggested considering
regression, many types of boosting algorithms have been dependencies among inclusion fractions. They defined
proposed. Today, two popular approaches are gradient two bootstrap variable selection procedures, one aiming
boosting [18, 41] and likelihood-based boosting [115], for a simpler model including strong factors only,
which coincide in the case of Gaussian regression but whereas the other including also weaker factors. The
differintheirapplicabilityandassumptionsotherwise(see BIFs and their dependencies are used as criteria to select

Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Page7of18
a final model. Recently, a large simulation study showed estimatesshouldbeaccompaniedbyconfidenceintervals
promising results [28], but more practical experience is and sometimes also by p values. For traditional selection
needed. However, the issue of dependencies among vari- procedures, virtually any statistical software reports con-
able inclusions seems to be widely ignored and further fidence intervals and p values of the final model, derived
issues need more consideration (such as the central role under the assumption that the model was given a priori.
of the originally used variable selection procedure and This ignores uncertainty in model predictions, estimates
theeffect ofinfluentialpoints). of effects and variance caused by model selection. Brei-
In the last decade, resampling-based variable selection man [14] called this a ‘quiet scandal’. Meanwhile, under-
procedures havebecome morepopular. Meinshausen and estimation of the uncertainty has been confirmed in
Bühlmann [78] introduced stability selection, which com- numerous simulation studies for different types of
bines subsampling (bootstrap without replacement) with models. Various approaches for coping with model un-
(high-dimensional) selection algorithms. The method is certainty have been proposed, starting with Chatfield
very general and is widely applicable. The authors state [21] and Draper [32]. Recently, Heinze et al. [56] pro-
that stability selection provides finite sample control for posedfor different settings:(1)Use thefullmodelforin-
some error rates offalsediscoveries. Recently, thespecific ference about regression coefficients, where the full
type of resampling procedure has become a topic of re- model is the model including all variables considered for
search.Somearguethatsubsamplingmaybepreferableto adjustment, and so each regression coefficient is ad-
thenonparametricbootstrapforinvestigationsinthecon- justed for all others. (2) If a small number of pre-
text of model building [29, 64, 92]. However, issues like specified competing models is evaluated, use model-
the most suitable sampling rate (0.632 seems to be the averaging as proposed by Burnham and Anderson [19].
mostcommon)needfurtherinvestigation. (3) If the full model is implausible and no evidence for a
small set of candidate variables is available, assess the
Biasandtheroleofshrinkagemethods variability of the regression coefficients around the full
The regularised procedures described in the ‘Procedures model estimates using the bootstrap, where in each
basedon‘change-in-estimate"sectionareso-calledshrink- bootstrap replication, the selection procedure is re-
age methods, as they introduce some bias towards zero peated. When comparing this variability with the stand-
intotheregressioncoefficientstotrytoreducethepredic- ard error in the full model, one often sees variance
tionerror.Shrinkagemethodscanalsobeappliedincom- inflation, even for strong predictors, and variance reduc-
bination with traditional variable selection methods, tion onlyforhighly non-influentialvariables[56].
where the use of shrinkage factors has been proposed to Although statistical inference after data-driven model
improve the accuracyofpredictions. In the lattercontext, selection has been deemed impossible [67], recent years
shrinkage factors may be estimated using resampling and have seen a couple of advances in that direction [110].
arethenmultipliedbytheregressioncoefficientstoobtain There are now even some R packages available with
shrunken coefficients. Either a common global shrinkage which confidence intervals for regression parameters se-
factor [118] or parameter-specific shrinkage factors [97] lected with the Lasso can be estimated [114]. However,
can beused for this purpose. vanHouwelingen and Sauer- given that these procedures were developed only re-
brei[117]revisitedtheseapproachesinthecontextoflinear cently, evidence of their performance in practice is still
regression models and found that backward elimination in limited.
combination with parameter-specific shrinkage factors Parameterwise or joint shrinkage factors [34, 97] have
yieldsmodelsthataresimilarlyorevenmoreaccuratethan been proposed in an attempt to reduce overestimation
those from the modern approaches. These shrinkage bias due to selectionof variables and functional forms. It
methodsmayalsoactasatoolto(partly)removetheover- is still unclear how a correction for the variance, e.g. by
estimationbiasinducedbyvariableselectionmethods(dis- using a sandwich variance estimator that is robust to
cussed in the ‘Traditional variable selection strategies’ model misspecification [122, 123], may help in achieving
section), even though their construction is not motivated approximately validconfidenceintervals.
bythegoalofbiascorrection.Asystematicinvestigationof
this‘sideeffect’isstilllacking.Moreover,theproposedesti- Continuous variables—to categorise or to model?
mation method by leave-one-out cross-validation could be Theeffectsofcontinuouspredictorsaretypicallymodelled
questioned; as in other contexts, other resampling proce- by either categorising them (which raises issues such as
dureshavebeenpreferred[107]. the number of categories, cutpoint values, implausibility
of the resulting step-function relationships, local biasses,
Post-selectioninference power loss or invalidity of inference due to data-
Since the main aim of descriptive models is the inter- dependentcutpoints)[47]orassuminglinearrelationships
pretation of the estimated regression coefficients, point with the outcome, possibly after a simple transformation

Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Page8of18
(e.g. logarithmic or quadratic). Often, however, the rea- contained in the data is not used, and the resulting risk
sons for choosing such conventional representations of function is a step function. From a biological perspec-
continuous variables are not discussed and the validity of tive, a step function may be unrealistic, since individuals
the underlying assumptions is not assessed [98]. Com- close to but on opposite sides of a cutpoint are charac-
monlyusedmethodsaresummarisedbyBecher[8]. terised as having very different risks or prognostic
To address limitations caused by categorisation or a scores. If the (unknown) underlying relationship with
questionable assumption of linearity, statisticians have the outcome is expected to be smooth but not necessar-
developed flexible modelling techniques based on vari- ily linear, interpretation of step functions is implausible.
ous types of smoothers, including fractional polynomials Furthermore, categorisation discards information, the
[93, 96] and several types of splines. The latter include greatest loss occurring when a variable is dichotomised.
restricted regression splines [30, 50], penalised regres- However, when interest centres on accurate prediction
sion splines [127] and smoothing splines. For multivari- at small or large values of a variable, van Houwelingen
able analysis, these smoothers have been incorporated in [116]producedarguments favouringgrouping.
generalised additive models [52]. Depending on personal Some analysts appear to believe that the severe infor-
preferences of the analyst, usually, one approach for the mation loss incurred by categorisation may be compen-
main analysis ischosen, sometimes complemented byal- sated by finding the ‘optimal’ cutpoint that defines two
ternative approaches as sensitivity analyses. Some prop- groups. Every possible cutpoint on x is considered and
erties of the approaches, which may lead to different the value of x which minimises the p value is chosen.
results,aregiven below. The cutpoint selected is to some extent due to chance
and is not reproducible. Altman et al. [3] called this pro-
Categorisation cedure the ‘minimum p value’ approach and stressed
Categorisationallowsresearcherstoavoidstrongassump- that the estimated effect describing the difference be-
tions about the functional relationship between the con- tween two groups is strongly overestimated and that if
tinuous variable and the outcome of interest. Some uncorrected, multiple testing increases the type I error
analysts incorrectly consider categorisation to be ‘model- toaround 40%instead ofanominal5%.
free’. It was often the method of choice in the past when Other methods of determining a cutpoint are to use
analysis was based on contingency tables. The approach recognised values (e.g. > 25kg/m2 to define ‘overweight’
has the advantage that it leads to results that seem to be based on body mass index), to use ‘round numbers’ such
easiertointerpretandisthereforeoftenfavouredbynon- asmultiplesoffiveorten,tousetheupperlimitofaref-
statisticians.Thefunctionalformfortheeffectofacovari- erence interval in healthy individuals or to apply cut-
ate is often unknown, and an analysis using a categorised points used in previous studies. These methods still
variableissimplerthanworkingwithcontinuousvariables incur information loss, but at least not an inflated type I
directly. In general, reporting is easier, and categorisation error probability. In the absence of predefined cutpoints,
allows graphical presentation, e.g. Kaplan-Meier curves epidemiological researchers often use three to five cat-
canbeproducedinsurvivalanalysis.However,ithassome egories based on quantiles of the empirical distribution,
seriousdrawbacks. while in clinical studies, the most common choice is
Categorisation raises several issues such as the number dichotomisation, often at the sample median. However,
of cutpoints, where to place them and how to code the different cutpoints are used in different studies, so the
resulting variable for the analysis. Obviously, the use of results can neither be easily compared nor summarised.
two groups makes it impossible to detect a non-linear re- For example, nineteen cutpoints were identified when
lationship.Itiswell-knownthattheresultsofanalysescan the prognostic value of S-phase fraction in breast cancer
vary if different cutpoints are used for splitting. Usually, patients was assessed [3]. Several of them resulted from
dummy variables are defined and different codings are an‘optimal’ cutpointanalysis.
possible. Alternatively, a coding scheme with a suitable Categorising a continuous variable into three or more
choiceofscoresimplyingametric(e.g.{1,2,3},{1,2,4}or groups reduces the loss of information. Several methods
scoresrepresentingthemedianofeachcategory),together of coding can be used for the categorised variable. Care
withatestforlineartrend,ispossible.Forvariableswitha is needed to choose the coding in a suitable way, specif-
spike at zero (see the ‘FP procedure to handle variables ically if variable selection is used in combination with
with a ‘spike at zero" section), a natural baseline category dummy variables (4, see the ‘Modern variable selection
istheunexposedgroup. strategies’ section). Despite the well-known problems
Many objections to categorisation have been raised causedbycategorisation,itisstillthepreferredapproach
during the last three decades. It is often stressed that in practice. Descriptive analysis of continuous covari-
categorisation should not be used to derive the final ables is often done with frequency tables for which some
model [80, 57, 3, 94, 119, 121]. The full information form of grouping is needed. In a recent review of cohort

Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Page9of18
studies in physical activity, the primary exposure was choosing nominal significance levels, which are the key
categorised in 21/30 (70%) of studies. In 51 dietary in- tuning parameters for determining the function’s com-
take studies, all variables were categorised in 27 (53%) plexityaccordingtotheaimofthestudy.
andatleastonevariablein50(98%) [105]. It is well-known that data-dependent model building
To summarise, categorisation of a continuous or semi- results in biassed estimates and incorrect p values. How-
continuousvariablemaybeusefulfordescriptivepresen- ever, the FSP uses the principle of a closed test proced-
tation of data, for initial analysis and for checking model ure which ensures that the overall type 1 error is close
assumptions. Furthermore, categorisation can help to to the nominal significance level [74]. For some simula-
simplifyfinalmodels,e.g. forpresentation, anditisoften tion results on type 1 error and power, see Royston and
required in clinical decision-making. However, it is un- Sauerbrei[96],section 4.10.5.
necessaryandoftenharmfulwhen usedtobuild thefinal
statistical model. Several modelling approaches have Splines
been proposed and should become the standard to as- Another common method of modelling nonlinear effects
sess the functional influence of a continuous variable, of continuous variables is spline regression. Generally, a
avoidingtheneedtocategorise. spline function is defined by a set of piecewise polyno-
mial functions of a continuous variable that are joined
Modellingnonlineareffectsofcontinuousvariables smoothly at a set of knots spread across the support of
In the following, we will briefly describe and discuss the the variable [128]. In contrast to fractional polynomials,
fractional polynomial and spline-based approaches. For the piecewise polynomial functions defining a spline all
moredetails,werefertothewebsupplementandthelit- have the same degree. For example, cubic splines are
eraturereferenced inthefollowingparagraphs. constructed from a set of piecewise polynomials each of
degree 3. Another conceptual difference between splines
Fractionalpolynomials and fractional polynomials is the range over which the
The class of fractional polynomial (FP) functions is an components of the two methods are defined. Whereas
extension of power transformations of a covariate. For splines are constructed from ‘local’ piecewise functions
most applications FP1 (β xp1) and FP2 (β xp1 + β xp2) (eachdefinedbetweentwoconsecutiveknots),thepower
1 1 2
functions are sufficient. For the exponents p and p , a functions involved in the construction of a fractional
1 2
set S = {−2, −1, −0.5, 0, 0.5, 1, 2, 3} with 0 = log x has polynomial are each defined over the whole range of the
been proposed. For p = p = p (‘repeated powers’), an continuousvariable.
1 2
FP2 function is defined as β xp + β xp log x. This defines Generalised additive models (GAMs) [52, 128] extend
1 2
8 FP1 and 36 FP2 models. The class of FP functions ap- generalised linear models by the inclusion of smooth
pears small, but it includes very different types of shapes nonlinear effects of continuous variables. Each nonlinear
[93]. General FPm functions are well-defined and effect is represented by a spline function (although other
straightforward but are rarely used in medical applica- smoothers are in principle possible). Estimation of the
tions. The main aim of FP modelling is the derivation of spline functions is usually carried out by writing splines
a suitable function which fits the data well, while being as a linear combination of spline basis functions and by
simple, interpretable and generally usable. Therefore, a estimating the weights in this combination via (possibly
linear function is the default and a more complex non- penalised) maximum likelihood optimisation. Generally,
linear function is only chosen if strongly supported (ac- GAMs support a huge number of modelling alternatives
cording to a chosen significance level) by the data. The and model fitting techniques. This is because splines
functional relationship is selected by a function selection come in many shapes and forms differing, e.g. in the de-
procedure (FSP) with up to three steps (if FP2 is the gree of the polynomial pieces and/or the number and
most complex functionconsidered) [96]. The test at step positionsoftheknots.Furthermore, itiscommontoim-
1 is of overall association of the variable with the out- pose restrictions on the spline functions, for example
come. The test at step 2 examines the evidence for non- linearity restrictions at the boundaries of the variables’
linearity. The test at step 3 chooses between a simpler supports (used, e.g. in natural splines [53]), complexity
FP1 or a more complex FP2 nonlinear model (for details restrictions imposed by lower-order approximations (e.g.
seethewebsupplement). in thin-plate regression splines [126]), smoothness re-
In the ‘General issues in building descriptive regres- strictions imposed by ‘wiggliness’ penalties (used, e.g. in
sion models’ section, we emphasised the need for a smoothing splines and in P-splines, which penalise the
model building procedure related to the main aim of the second- or higher-order differences of the basis function
analysis. For FPs, this can be done by pre-specifying the coefficients [38]) or imposing monotonicity [89]. If pen-
most complex FP functions allowed (often FP2, some- alties are used in GAMs, each spline function is usually
times FP1, occasionally FPm with m > 2) and by associated with a separate hyperparameter determining

Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Page10of18
the weight of the respective penalty in penalised max- context of parametric modelling of the association be-
imum likelihood estimation. In addition, the definition tween smoking intensity and lung cancer. Leffondre
of the basis functions is not unique, and there exist vari- et al. [68]demonstratedthatitallows researcherstosep-
ous possibilitieson how todefinethem,each with differ- arate (i) the ‘qualitative’ difference between ever-
ent numerical properties. For details, see the web smokers relative to non-smokers, from (ii) the ‘quantita-
supplement. Note that splines can also be used in boost- tive’ dose-response association estimated using data on
ing algorithms, see, e.g. Schmid and Hothorn [104]. Ob- smokers only.
viously, all the aforementioned modelling options affect Four closely related procedures have been proposed
the shapes of the spline functions, and hence also the ef- for model building with two (which can be extended to
fects and the interpretation of the respective variables in more) spike-at-zero variables [65]. Although it is rele-
a GAM. Perperoglou et al. [84] provide an overview of vant to the analysis of many studies, practical experience
the most widely used spline-based techniques and their islimited.
implementation inR.
In an investigation of the effect of alcohol intake as a Combining variable and function selection
risk factor for primary oral cancer, Rosenberg et al. [91] Variable selection in the presence of non-linear relation-
discussed several issues of spline modelling when deter- ships of covariates with the outcome is an even more
mining the functional form of a continuous variable in complicated exercise. In fact, decisions regarding the in-
practice. Abrahamowicz et al. [1] illustrated the practical clusion/exclusion of specific variables and modelling of
advantages of spline modelling, implemented with the the functional forms of both these variables and poten-
smoothing splines within GAMs, to detect and account tialconfoundersmaydependoneachotherinacomplex
fornonlinearassociationsinthe contextof cardiovascular way. Firstly, the ‘importance’ and/or statistical signifi-
epidemiology. They demonstrated how the flexibility of cance of a continuous variable may depend strongly on
thesplinesmayenhancetherobustnessoftheestimates. how its relationship with the outcome is modelled. For
example, whereas there was no evidence for an associ-
FPproceduretohandlevariableswitha‘spikeatzero’ ation of body mass index (BMI) with the logit of the
In epidemiology and in clinical research, variables often probability of coronary heart death (CHD) assuming a
have unusual distributions. Commonly in epidemio- linear effect, a GAM-based multivariable model with the
logical studies, a proportion of individuals have zero ex- same adjustment covariates revealed a non-monotone J-
posure to the risk factor of interest, whereas for the shaped association. CHD mortality increased for both
remainder, the distribution of the risk factor is continu- verylean andobese subjects[1].
ous. We call this a ‘spike at zero’ or a ‘semi-continuous
variable’. Examples are smoking, duration of breastfeed- Themultivariablefractionalpolynomialapproach
ing or alcohol consumption. In the first example, a part The multivariable fractional polynomial (MFP) approach
of the individuals are non-smokers with dose zero and is a pragmatic procedure to create a multivariable model
for smokers, the dose variable, e.g. average number of with the parallel aims of selecting important variables
cigarettesper day,iscontinuous.Furthermore,theempir- anddeterminingasuitablefunctionalformforcontinuous
ical distribution of laboratory values and other measure- predictors [96, 101]. To select a model, significance levels
ments may have a semi-continuous distribution because chosen for the two components (backward elimination
thelowerdetectionlimitofthemeasurementisassigneda (BE) and FP functions) are the key settings for determin-
value of zero. Such a variable cannot directly be analysed ing model complexity. If more or fewer variables are in-
with FPs (see the ‘Fractional polynomials’ section) since cluded, simple linear or more complex non-linear
some of the transformations needed are only defined for functions are selected. If an extremely low significance
positive values. An ad hoc but arguably unsatisfactory level (e.g. 0.00001) is used to select FP functions, usually
methodistoaddasmallconstanttoeachobservation. only linear functions are selected and MFP in effect be-
Spike at zero variables can be analysed by categorisa- comes just BE. Choosing 0.999 as a significance level in
tion, using the zero category as baseline. The method theBEcomponentensuresthataspecificvariableisguar-
has the same disadvantages as mentioned in the ‘Cat- anteedtoenter themodel.Althoughrelatively simpleand
egorisation’ section. Abetter approach isdescribed [8,9] easily understood by researchers familiar with the basics
and illustrated [70], using an extended version of frac- of regression models, the selected models often extract
tional polynomials. Briefly, a binary indicator variable Z most of the important information from the data. Based
(exposed/non-exposed) is generated, and the modelling onexperienceinpracticebut without providing empirical
involves both Z and the spike at zero variable X, where evidence, Sauerbrei et al. [102] give several recommenda-
the transformations are applied to the positive part of X tionsforMFPmodellingundersomeassumptions,e.g.the
only. A similar approach was proposed earlier in the sample size is not too small and there is no interaction

Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Page11of18
between covariates. Models derived are relatively easy to There also exists a special type of shrinkage smoothers,
interpret and toreport, a pre-requisite fortransportability basedoncubicregressionsplinesandthinplateregression
and general use in practice. Easy to use software in Stata, spline smoothers in which a modification of the smooth-
SAS and R is available [100]. Several extensions of MFP ing penalty would allow strong enough penalisations to
have been proposed. Only programs in Stata are available shrink all coefficients of the smooth term to zero [128].
fortheseextensions.Formoredetails,seehttp://mfp.imbi. Clearly, such penalisation methods are not easily imple-
uni-freiburg.de/. mented but rely on the availability of a software package
Because of data-dependent selection of variables and (such as mgcv) to provide the appropriate fitting routines
their functional forms, overestimation bias is likely to as well as methods for optimisation of the smoothing pa-
arise. As with the arguments in the context of variable rameters. Clearly, since penalisation techniques are rela-
selection (see the ‘Resampling-based variable selection tively new, further research is needed to compare their
procedures’ section), bias may be reduced by estimating performancewiththatofstepwiseproceduresinGAMs.
and applying parameter-specific shrinkage factors (see Other approaches include the component selection
the‘Resampling-basedvariableselectionprocedures’sec- and smoothing operator (COSSO) [69], SpAM [90] and
tion). In the context of MFP, an extension to this meth- the method of Meier et al. [77], all based on a penalised
odology was proposed by [34]. They suggested providing likelihood that reduces the problem to Lasso-type esti-
‘joint’ shrinkage factors for semantically related regres- mation [112]. Chouldechova and Hastie [24] introduced
sion coefficients, e.g. the components of a second-order generalised additive model selection (GAMSEL) that
FP. Systematic investigations of their proposal in the chooses between linear and non-linear fits for the com-
context of combined variable and functional form selec- ponent functions. Antoniadis et al. [5] discuss variable
tion havenotbeenreported. selection using P-splines, based on an extension of the
nonnegative garrotte. These methods have not been
Splineregression evaluated in practice and further research is needed to
‘Traditional’ selection techniques used in generalised understandtheirproperties.
linear models (GLMs) are also available for GAMs. We finally note that the variable selection procedure
Many R packages such as mgcv and gamlss imple- of the component-wise boosting algorithms described in
ment approaches to forward or backwards stepwise the ‘Boosting’ section also appliesto splineregression. In
regression based either on p values of the smooth fact, component-wise boosting can be used to fit a large
terms or on AIC/BIC-type criteria. These approaches variety of GAMs, allowing a forward stagewise selection
are intuitive and easy to use (and hence popular) but of nonlinear effects and an automated determination of
have the same weaknesses as GLMs. Additionally, theappropriate amount ofsmoothing[60,104,115].
since smoothness parameters are not fixed but esti- Royston and Sauerbrei proposed transferring the MFP
mated, p values associated with the smooth terms are approach to regression splines and smoothing splines
approximate and may be biassed. [95, 96]. The MFP algorithm provides a principled ap-
Alternatively, given a specific model structure, model proach for systematic selection of variables and FP func-
selection might be performed using prediction error cri- tions. In the multivariable regression splines (MVRS)
teria or likelihood-based methods such as generalised algorithm, they combined backward elimination with a
cross-validation, unbiassed risk estimator (UBRE) or search for a suitable restricted cubic spline function. In
REML with maximum likelihood for smoothness selec- the multivariable smoothing splines (MVSS) algorithm,
tion. Such methods, however, are unlikely to be success- they replace the FP components by cubic smoothing
fulandhaveknowndrawbacks[128]. splines. For more details and a comparison of results
More recent approaches consider penalisation of from MFP, MVRS and MVSS, we refer to Royston and
smooth terms to perform variable selection. A penalty Sauerbrei([96],chapter 9).
term on a regression spline penalises the range space of
the spline, controlling how wiggly the function is. For Examples illustrating the problems
example, increasing the weight of a second-order deriva- In this section, we illustrate by way of selected published
tive penalty to infinity will effectively force the term to analyses of observational studies that guidance on many
linearity. On the other hand, it will not remove the term aspects of multivariable modelling outlined above is ur-
from the model, as the null space of the spline remains gently needed.
unpenalised. Marra and Wood [75] therefore suggested
null space penalisation by adding an extra penalty for Acaseofpopularbuthighlyproblematicvariable
each smooth term to the log-likelihood. If all smoothing selection
parameters for the term tend to infinity, then it is pena- Ramaiola et al. [88] conducted linear regression analyses
lised to zero and is effectively dropped from the model. to identify prognostic factors of plasma prolifin-1 (Pfn-1)

Sauerbreietal.DiagnosticandPrognosticResearch            (2020) 4:3  Page12of18
levels in myocardial infarction patients with ST-segment Also,allotherhazardratiosofthecategorisedanalysisare
elevation. Their study sample comprised 86 patients. moreextremethanwouldbesuggestedbythesplineana-
Eleven explanatory variables were considered: duration of lysis. The paper contains no explanation of the discrep-
ischaemia from onset of pain to percutaneous coronary ancy. We suspect that the less extreme hazard ratios of
intervention, age, gender, diabetes, hypertension, obesity, the spline analysis could be caused by ignoring the spike
dyslipidaemia,tobacco,antithrombictreatmentsandlevels at zero in that analysis. For patient counselling, the cate-
of hsC-reactive protein and P-selectin. The authors first gorisedanalysisismisleadingasitsuggestsareducedhaz-
used bivariate correlation analysis or t tests to assess the ard of mortality (hazard ratio 0.8) already at very low
association between Pfn-1 and each of the potential ex- levels of MET (12min per week), which seems implaus-
planatory variables. Variables with a significant (α=0.05) ible. This is even more crucial as the paper contains the
misleadingconcludingstatement‘Thesefindings…provide
| association | with Pfn-1 | were | then taken | as  | the starting | set |     |     |     |     |
| ----------- | ---------- | ---- | ---------- | --- | ------------ | --- | --- | --- | --- | --- |
in a multivariable model to which backward elimination importantevidencetoinactiveindividualsbyshowingthat
(α=0.05) was applied. Finally, two variables, duration of modestamounts of activityprovide substantialbenefit for
‘remained postponingmortality’.Sincethetwoanalysesgivedifferent
| ischaemia | and patient | age |     | as independent |     | fac- |     |     |     |     |
| --------- | ----------- | --- | --- | -------------- | --- | ---- | --- | --- | --- | --- |
tors for Pfn-1 levels’, both with highly significant p values results, we must conclude that such a statement is not
lower than 0.001. Surprisingly, the time of ischaemia was fullysupportedbythedata,implyingthatatleastoneana-
not mentioned as a candidate variable in the statistical lysisisquestionable.
| methods | section. The | values | of the | estimated | regression |     |     |     |     |     |
| ------- | ------------ | ------ | ------ | --------- | ---------- | --- | --- | --- | --- | --- |
art—research
coefficients were reported, but not their standard errors, Towards state of the required!
and for interpretation purposes, no explicit reference was In the earlier sections, we have illustrated that many
madetothemeasurementscaleofthecorrespondingvari- variable selection procedures are available. Unfortu-
ables.Noassessmentofmodelassumptions,nonlinearities nately, for all of them, knowledge of their properties and
or interactions was mentioned. The stability of the model the number of informative comparisons are limited. In
wasneitherinvestigatednorquestioned. all sections, we raised many issues requiring further re-
search.Weidentifiedseveralpapersintheliteraturepro-
Exampleofconflictingresultsforavariablewithaspike viding recommendations for practice [49, 50, 51, 56,
| atzero |     |     |     |     |     |     | 102] or, | as expressed | by Royston and | Sauerbrei [96], |
| ------ | --- | --- | --- | --- | --- | --- | -------- | ------------ | -------------- | --------------- |
Aremetal.[6]reportonapooledanalysisof666,137par- ‘Towards recommendations…under the assumptions…’.
ticipants of 6 studies from the National Cancer Institute They state that clear guidance is almost always impos-
Cohort Consortium, investigating the dose-response rela- sible and stress that guidance can only be obtained
tionshipbetweenleisuretimephysicalactivity(LTPA)and under specific assumptions (e.g. large enough sample
mortality. LTPA is measured based on self-reported aver- size and absence of interactions). Based on the earlier
age hours per week spent on several physical activities sections, in Table 1, we summarise issues we consider as
over the prior year. These hours per week were then being the most relevant for further investigations. The-
transformed into metabolic equivalent (MET) hours per oretical results derived for specific ‘sub-problems’ and
week to adjust for different energy expended by the type under strong assumptions may supply important insight,
of activity. MET is a continuous variable with a spike at but in general, we need empirical evidence based on ex-
zero(8.0%).ThemainanalysisadjustsMETforseveralco- tensive simulation studies. Difficulties in conducting
| variates, | e.g. sex, smoking, |     | alcohol | (categorised |     | into | 4   |     |     |     |
| --------- | ------------------ | --- | ------- | ------------ | --- | ---- | --- | --- | --- | --- |
groups),educationallevel,maritalstatus,historyofcancer,
Table1Relevantissuesinderivingevidence-supportedstateof
| history of | heart disease | and | body mass | index | (categorised |     |     |     |     |     |
| ---------- | ------------- | --- | --------- | ----- | ------------ | --- | --- | --- | --- | --- |
theartguidanceformultivariablemodelling
| into 5 groups). | Age was         | used         | as the     | time scale       | in  | Cox re-  |                                                       |     |     |     |
| --------------- | --------------- | ------------ | ---------- | ---------------- | --- | -------- | ----------------------------------------------------- | --- | --- | --- |
|                 |                 |              |            |                  |     |          | No. Item                                              |     |     |     |
| gression        | analysis. While | the          | supplement | contains         |     | a figure |                                                       |     |     |     |
|                 |                 |              |            |                  |     |          | 1 Investigationandcomparisonofthepropertiesofvariable |     |     |     |
| in which        | MET entered     | the analysis |            | using restricted |     | cubic    |                                                       |     |     |     |
selectionstrategies
| splines, | the main paper | provides | results |     | for categorised |     |                                                    |     |     |     |
| -------- | -------------- | -------- | ------- | --- | --------------- | --- | -------------------------------------------------- | --- | --- | --- |
|          |                |          |         |     |                 |     | 2 Comparisonofsplineproceduresinbothunivariableand |     |     |     |
MET (7 categories including 0 as a category). Details of multivariablecontexts
thesplinespecificationarenotgiven.Bothanalyseswith0
|               |          |        |           |         |              |         | 3 Howtomodeloneormorevariableswitha‘spike-at-zero’?      |     |     |     |
| ------------- | -------- | ------ | --------- | ------- | ------------ | ------- | -------------------------------------------------------- | --- | --- | --- |
| MET hours     | per week | as the | reference | suggest | a            | benefit |                                                          |     |     |     |
|               |          |        |           |         |              |         | 4 Comparisonofmultivariableproceduresformodelandfunction |     |     |     |
| from physical | activity | but do | not agree | well    | numerically. |         |                                                          |     |     |     |
selection
Forexample,thehazardratioforphysicalactivitybetween
|                |             |        |          |        |      |          | 5 Roleofshrinkagetocorrectforbiasintroducedbydata-dependent |     |     |     |
| -------------- | ----------- | ------ | -------- | ------ | ---- | -------- | ----------------------------------------------------------- | --- | --- | --- |
| 12min          | and 7.5 MET | hours  | per week | is 0.8 | (95% | confi-   | modelling                                                   |     |     |     |
| dence interval | 0.78 to     | 0.83), | while    | in the | same | range of |                                                             |     |     |     |
|                |             |        |          |        |      |          | 6 Evaluationofnewapproachesforpost-selectioninference       |     |     |     |
physicalactivity,thesplineanalysissuggestsahazardratio
|     |     |     |     |     |     |     | 7 Adaptionofproceduresforverylargesamplesizesneeded? |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ---------------------------------------------------- | --- | --- | --- |
smoothlychangingfrom1toabout0.82at7.5hperweek.

Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Page13of18
unbiassed and informative simulation studies were dis- Issue4:Comparisonofmultivariableproceduresfor
cussed in a letter from the STRATOS simulation panel modelandfunctionselection
[13]. The need to conduct better designed and analysed Given the huge number of penalised and spline-based
simulationstudieshasbeen expressed[82]. approaches recently proposed (see the ‘Spline regression’
section), additional studies such as Binder et al. [12] are
needed to evaluate their performance. The emphasis
Issue1:Investigationandcomparisonofthepropertiesof
should be on accuracy, efficiency, transportability, ease
variableselectionstrategies
of implementation and interpretability of the resulting
Traditional and modern variable selection approaches
multivariablemodels.
need to be compared in a head-to-head manner in a
variety of explanatory modelling situations. To be
Issue5:Roleofshrinkagetocorrectforbiasintroduced
valuable for explanatory modelling, target parameters
should be those that influence the ‘correct’ inclusion bydata-dependentmodelling
The usefulnessofpost-selection shrinkage methodsin re-
and exclusion of variables, model stability, and model
moving overestimation bias in the regression coefficients
complexity. They should address the accuracy of the
and estimated functional forms in multivariable models
effects to be estimated, i.e. the regression coefficients.
needsfurtherinvestigation.Guidanceinselectingtheright
The number of candidate variables, their distributions,
type of shrinkage factors (parameterwise, joint or global)
the correlation structure, the strength of effects and
and cross-validation procedure (jackknife, bootstrap) to
the sample size should be the main meta-parameters
obtain stable shrinkage factors is needed. Comparison
to be varied.
with approaches combining variable selection and shrink-
age (see the ‘Penalised likelihood’ section) are needed.
Issue2:Comparisonofsplineproceduresinaunivariable Post-selection shrinkage can be generally used for models
andmultivariablecontext combining variable and functional form selection. This
In the univariable situation the important questions are contextneedstobeinvestigated.
whether the results derived with the many suggested
spline procedures differ (substantially) from the true
Issue6:Evaluationofnewapproachesforpost-selection
function, and how much that depends on relevant pa-
inference
rameters (e.g. number of knots). Furthermore, permitted
Recently, new procedures for obtaining confidence inter-
complexity of the function and usability of procedures
vals for regression coefficients after applying forward se-
for non-expertsarerelevant.Criteriainthemultivariable
lection, the Lasso or LARS have been proposed, but they
situation are similar, with an additional focus on correct
have not yet been evaluated in typical explanatory mod-
variable inclusion and exclusion. We should consider
elling situations. For traditional variable selection
modifying some of the procedures proposed in light of
methods,theperformance ofalternative varianceestima-
results from univariable investigations. The focus should
tors that are robust to model misspecification have not
lie on practical data modelling situations with multiple
yetbeen investigated.
variables of mixed types, with splines used for modelling
continuous variables. Different types of functions and
Issue7:Adaptionofproceduresforverylargesample
sample sizes should be the main meta-parameters in the
sizesneeded?
univariable situation. Additional parameters (as with
Sofar, nothing hasbeensaidabout buildingofinterpret-
issue 1)arerequiredinthemultivariable situation.
able explanatory models with large data sets. In recent
years, moreandmore enormous data sets, e.g.with sam-
Issue3:Howtomodeloneormorevariableswitha plesizen>100,000andnumberofpotentialexplanatory
‘spike-at-zero’? variablesp>1,000havebecomeavailable formedicalre-
For one variable, a two-step FP-based procedure (see the search, e.g. in pharmacoepidemiology, in studies with
‘FP procedure to handle variables with a ‘spike at zero" electronic health records or registries and in individual
section)hasbeenproposed.Usingsplines,aone-stepap- patient data meta-analyses. Procedures for multivariable
proach would be possible and comparisons of various model building were developed with much smaller num-
spline-based approaches with the FP approach are bers in mind, with respect to both n and p. Approaches
needed. Main criteria are similar to those mentioned for considering the natural or empirical grouping of vari-
the univariable situation in issue 2. The FP approach has ables (‘variable clustering’) may become more relevant
been extended for two spike-at-zero variables. Four here, while the usual settings for tuning parameters for
strategies have been suggested, but current knowledge is variable selection procedures need to be rethought. Al-
limited. ternative approaches that optimally combine subject-

Sauerbreietal.DiagnosticandPrognosticResearch            (2020) 4:3  Page14of18
matter knowledge with statistical learning need to bede- apply for researchers working with survival data (TG8)
| velopedandevaluated. |     |     |     |     |     |     | orhigh-dimensionaldata |     |     | (TG9). |     |     |     |     |
| -------------------- | --- | --- | --- | --- | --- | --- | ---------------------- | --- | --- | ------ | --- | --- | --- | --- |
Topics raised in Table 1 will keep our topic group It is difficult and still unusual to pre-specify a detailed
(and hopefully others) busy for several years, but what is analysis plan for observational studies, as is standard for
the alternative for developing evidence supported guid- the analysis of RCTs. Consequently, we must assume
ance for the selection of variables and functional forms that usually, several analyses are conducted, but that re-
inmultivariableanalysis? sults are presented only for some of them. It is well-
|     |     |     |     |     |     |     | known        | that final | models | derived | data-dependently |        |          | are at |
| --- | --- | --- | --- | --- | --- | --- | ------------ | ---------- | ------ | ------- | ---------------- | ------ | -------- | ------ |
|     |     |     |     |     |     |     | least partly | a result   | of     | chance. | It is still      | common | practice |        |
Discussion to base inference on a ‘conditional model’, as if the
| In a joint | effort, members |     | of TG2 | identified | seven | issues |       |          |           |     |         |          |     |      |
| ---------- | --------------- | --- | ------ | ---------- | ----- | ------ | ----- | -------- | --------- | --- | ------- | -------- | --- | ---- |
|            |                 |     |        |            |       |        | model | had been | specified | a   | priori. | However, | we  | must |
which we consider key to building a multivariable model realise that because the uncertainty of the model-
with continuous variables. The list could be extended, as building process is ignored, the parameter estimates may
other experts in the field may have different experiences be (heavily) biassed and their variances are usually
| and preferences | and        | may        | consider | other | issues   | more im- | underestimated. |                |     |       |     |           |          |     |
| --------------- | ---------- | ---------- | -------- | ----- | -------- | -------- | --------------- | -------------- | --- | ----- | --- | --------- | -------- | --- |
| portant.        | We welcome | discussion |          | and   | critique | as this  |                 |                |     |       |     |           |          |     |
|                 |            |            |          |       |          |          | With            | the increasing |     | power | of  | computing | environ- |     |
would trigger urgently needed research in one of the ments, it became easier to use Bayesian approaches or
most important areas of statistical analysis. We would resampling methods aimed at improving predictions and
alsobepleasedifotherexpertsandresearchgroupswere their variances by using model averaging approaches [7,
motivated by the ‘Towards state of the art—research re- 17, 21, 32, 59]. Attempts to quantify model uncertainty
| quired!’section | anddecidedtodofurtherresearchonis- |     |     |     |     |     |           |       |       |     |       |          |             |     |
| --------------- | ---------------------------------- | --- | --- | --- | --- | --- | --------- | ----- | ----- | --- | ----- | -------- | ----------- | --- |
|                 |                                    |     |     |     |     |     | have been | known | since | the | 1980s | [2, 23]. | Researchers |     |
sues we raised. Members of our group have considerable stress that data-dependent derivations of multivariable
expertise to guide the necessary research we outlined. models need to be complemented by such investigations
We consider this work an important step on the long [99]. Unfortunately, investigations of model stability are
journey towards evidence-supported guidance on the along way from becomingstandard practice.
state of the art. Following the general approach of STRA ‘Towards
|     |     |     |     |     |     |     | Regarding | issues | raised | in  | the |     | state | of the |
| --- | --- | --- | --- | --- | --- | --- | --------- | ------ | ------ | --- | --- | --- | ----- | ------ |
TOS, guidance for experienced analysts will later be art—research required!’ section, we emphasised that
adaptedtoresearchersatlevel1,whohavelessstatistical mathematical theory is unlikely to help and that appro-
training. priate simulation studies are the key tool to assess and
It is well-known that the aim of a study strongly af- comparethepropertiescompetingapproaches.However,
| fects the | choice of | a suitable | analysis. |     | Here | we concen- |                    |     |     |                 |     |         |           |     |
| --------- | --------- | ---------- | --------- | --- | ---- | ---------- | ------------------ | --- | --- | --------------- | --- | ------- | --------- | --- |
|           |           |            |           |     |      |            | itiswell-knownthat |     |     | many simulation |     | studies | comparing |     |
trate on models for description and mention that some a suggested new method with existing methods may be
things change when the main aim is prediction. That is (strongly) biassed in favour of the new method [13].
one of the reasons why STRATOS has a separate topic Morris et al. [82] provided empirical evidence that simu-
group for prediction (TG6). We also ignore the recent lation studies are often poorly designed, analysed andre-
| trend in | epidemiological |     | studies | to use | directed | acyclic |         |      |          |     |            |     |          |     |
| -------- | --------------- | --- | ------- | ------ | -------- | ------- | ------- | ---- | -------- | --- | ---------- | --- | -------- | --- |
|          |                 |     |         |        |          |         | ported. | They | provided | a   | structured |     | approach | to  |
graphs (DAG) for specifying and deriving confounders planning and reporting simulation studies, which in-
to enter regression models. It is a principled approach volves defining aims, data-generating mechanisms, esti-
(‘ADEMP’).
requiring critical decisions based on subject-matter mands, methods and performance measures
knowledge. Nevertheless, it may be difficult to handle STRATOS has a simulation panel which has started to
| when there | are many | variables |     | and | it does | not help in |         |          |     |             |         |     |               |     |
| ---------- | -------- | --------- | --- | --- | ------- | ----------- | ------- | -------- | --- | ----------- | ------- | --- | ------------- | --- |
|            |          |           |     |     |         |             | work on | guidance | for | the design, | conduct |     | and reporting |     |
dealing with selection of functionalforms for continuous of simulation studies. The corresponding authors of the
variables. While in general we do not discourage think- two papersjustmentionedaremembersofthispanel.
ing about a DAG to identify a meaningful working set of We outline the research needed to determine which
variables, the topic is perhaps more relevant for causal procedures could be considered SOTA. To use SOTA
| inference.       | Therefore, | we                     | leave | it for | STRATOS      | topic |              |             |                |     |           |           |          |       |
| ---------------- | ---------- | ---------------------- | ----- | ------ | ------------ | ----- | ------------ | ----------- | -------------- | --- | --------- | --------- | -------- | ----- |
|                  |            |                        |       |        |              |       | methodology, |             | an experienced |     | scientist | with      | deep     | know- |
| groupTG7(‘causal |            | inference’).Naturally, |       |        |              |       |              |             |                |     |           |           |          |       |
|                  |            |                        |       |        | therearemany |       | ledge of     | statistical | methodology    |     | is        | required. | However, |       |
other questions we have ignored because they are cov- mostanalysesareconductedbypeoplewithalowerlevel
ered by different topic groups. For example, each ana- of statistical knowledge who need assistance working
lysis is preceded by manydecisions in preparing the data with the more basic and straightforward methods. Many
| during an | initial | data analysis, |     | and | these decisions | can |             |            |     |        |        |            |     |     |
| --------- | ------- | -------------- | --- | --- | --------------- | --- | ----------- | ---------- | --- | ------ | ------ | ---------- | --- | --- |
|           |         |                |     |     |                 |     | analysesmay | bedonewith |     | basic, | simple | methodsnot |     | re- |
have an important influence on the results. For a de- quiring advanced methods regarded as SOTA. One im-
tailed discussion, see the paper of topic group TG3 (‘ini- portant aim of the STRATOS initiative is to formulate
analysis’)
tial data [63]. Nearly all the issues we discuss guidance for analysts with a lower level of statistical

Sauerbreietal.DiagnosticandPrognosticResearch            (2020) 4:3  Page15of18
knowledge. See Sauerbrei et al. [98] for an outline of the overestimates parameters. Improvements may be pos-
proposedstrategy. sible by using shrinkage approaches but their role is not
| During | the last | two | decades, | reporting | guidelines | have | well-investigated. |
| ------ | -------- | --- | -------- | --------- | ---------- | ---- | ------------------ |
been developed for many types of studies, with the Topic group 2 of the STRATOS initiative aims to de-
EQUATOR network acting as an umbrella. For some of velop guidance for the selection of variables and func-
theseguidelines,so-calledexplanationandelaborationpa- tional forms in multivariable analysis. In this paper, we
pers have been published. They include statements and provide a short overview of methods for variable and
some advice on statistical analysis, but they discuss some function selection and highlight seven important topics
more basic issues and aim more at analysts with a lower that require further investigation. Identifying weaknesses
level of statistical knowledge. The STROBE, REMARK of current knowledge is an important step on the long
and TRIPOD guidelines are probably the most pertinent way to derive guidance for this highly relevant, but also
| to issues          | discussed | in    | this paper | [4, 81, | 120].   | To avoid se- | complextopic. |
| ------------------ | --------- | ----- | ---------- | ------- | ------- | ------------ | ------------- |
| lective reporting, |           | which | gives      | rise to | biassed | results and  |               |
misleadinginterpretation,itisimportanttoreportallana- Supplementary information
lyses,preferablybygivingkeyinformationviaastructured Supplementaryinformationaccompaniesthispaperathttps://doi.org/10.
1186/s41512-020-00074-3.
display.Altmanetal.[4]proposedtheREMARKprofileas
| a suitable | means | of  | improving | reporting | of  | prognostic |     |
| ---------- | ----- | --- | --------- | --------- | --- | ---------- | --- |
Additionalfile1.Websupplement.
| marker studies. |     | Structured | displays | still | need | to be devel- |     |
| --------------- | --- | ---------- | -------- | ----- | ---- | ------------ | --- |
opedforothertypesofstudies.
Abbreviation
| The overarching |     | aim | of the | international |     | STRengthen- |     |
| --------------- | --- | --- | ------ | ------------- | --- | ----------- | --- |
ADEMP:Aims,data-generatingmechanisms,estimands,methodsand
performancemeasures;AIC:Akaike’sinformationcriterion;BE:Backward
| ing Analytical |     | Thinking | for | Observational | Studies | (STRA |     |
| -------------- | --- | -------- | --- | ------------- | ------- | ----- | --- |
TOS) initiative is to provide accessible and accurateguid- elimination;BIC:Bayesianinformationcriterion;BIF:Bootstrapinclusion
frequencies;BMI:Bodymassindex;CHD:Coronaryheartdeath;
ancedocumentsforrelevanttopicsinthedesignandana-
COSSO:Componentselectionandsmoothingoperator;df:Degreeof
lysis of observational studies. The topic group TG2 freedom;EQUATOR:Enhancingthequalityandtransparencyofhealth
working on guidance for the selection of variables and research;FDA:Foodanddrugadministration;FP:Fractionalpolynomial;
FPm:Fractionalpolynomialofdegreem(usually1or2);FS:Forward
functional forms has shown that many open issues exist selection;FSP:Functionselectionprocedure;GAMs:Generalisedadditive
and that much research is needed to fill the evidence gap models;GAMSEL:Generalisedadditivemodelselection;GLMs:Generalised
when trying to determine which approaches may be linearmodels;LARS:Leastangleregression;Lasso:Leastabsoluteshrinkage
termed‘stateoftheart’. andselectionoperator;LTPA:Leisuretimephysicalactivity;MET:Metabolic
equivalent;MFP:Multivariablefractionalpolynomialapproach;
MFPI:Multivariablefractionalpolynomialinteractions;MFPT:Multivariable
Conclusions fractionalpolynomialtimeapproach;MSE:Meansquarederror;
MVRS:Multivariableregressionsplines;MVSS:Multivariablesmoothing
| Selection | of variables |     | and | identification | of  | functional |     |
| --------- | ------------ | --- | --- | -------------- | --- | ---------- | --- |
splines;Omics:Termencompassingmultiplemoleculardisciplines;
| forms for | continuous |     | variables | is a | key concern | when |     |
| --------- | ---------- | --- | --------- | ---- | ----------- | ---- | --- |
RCT:Randomisedcontrolledtrial;REMARK:Reportingrecommendationsfor
tumourmarkerprognosticstudies;REML:Restrictedmaximumlikelihood;
| deriving | a multivariable |     | model. | Triggered |     | by high- |     |
| -------- | --------------- | --- | ------ | --------- | --- | -------- | --- |
SAS:Statisticalanalysissystem;SCAD:Smoothlyclippedabsolutedeviation;
| dimensional | data, | several | more | ‘modern’ | variable | selec- |     |
| ----------- | ----- | ------- | ---- | -------- | -------- | ------ | --- |
SOTA:Stateoftheart;SpAM:Sparseadditivemodel;STRA
tion strategies have been proposed. However, knowledge TOS:STRengtheningAnalyticalThinkingforObservationalStudies;
of their properties and the number of informative com- STROBE:STrengtheningtheReportingofOBservationalstudiesin
Epidemiology;TG2:Topicgroup2(selectionofvariablesandfunctional
| parison | studies, | ideally | based | on well-designed |     | and ana- |     |
| ------- | -------- | ------- | ----- | ---------------- | --- | -------- | --- |
formsinmultivariableanalysis);TG3:Topicgroup3(initialdataanalysis);
lysed simulation studies, are scarce. As data are often TG6:Topicgroup6(Evaluatingdiagnostictestsandpredictionmodels);
measured ona continuous scale, itis obviousthat the is- TG7:Topicgroup7(causalinference);TG8:Topicgroup8(survivalanalysis);
TG9:Topicgroup9(high-dimensionaldata);TRIPOD:Transparentreporting
sues of variable selection need to be combined with the ofamultivariablepredictionmodelforindividualprognosisordiagnosis;
selection of a suitable functional form. Assuming that an UBRE:Unbiassedriskestimator
| effect is | linear | or categorising |     | the data | and | estimating |     |
| --------- | ------ | --------------- | --- | -------- | --- | ---------- | --- |
Acknowledgements
| step functions |     | are the | most | popular approaches |     | but can |     |
| -------------- | --- | ------- | ---- | ------------------ | --- | ------- | --- |
ThisworkwassupportedbytheDeutscheForschungsgemeinschaft[SA580/
lead to seriously wrong conclusions. Spline-based ap- 10-1]toWilliSauerbrei,bytheEuropeanCommission’sprogramme
Erasmus+StaffMobilityforTrainingduringthefellowshipofGeorgHeinzein
| proaches | or fractional |     | polynomials | avoid | cutpoints, | use |     |
| -------- | ------------- | --- | ----------- | ----- | ---------- | --- | --- |
FreiburginNovember2018andbyUKMedicalResearchCouncilprogrammes
| the full | information | from | the | data and | can | model non- |     |
| -------- | ----------- | ---- | --- | -------- | --- | ---------- | --- |
MCtoPatrickRoyston[UU_12023/21,MC_UU_12023/29].WethankTim
| linear relationships. |     | However, |     | it is not | clear | which of the |     |
| --------------------- | --- | -------- | --- | --------- | ----- | ------------ | --- |
Haeussler,AndreasOttandChristineWallischforadministrativeassistance.
TheinternationalSTRengtheningAnalyticalThinkingforObservational
| spline-based | approaches |     | should | be  | recommended | for |     |
| ------------ | ---------- | --- | ------ | --- | ----------- | --- | --- |
Studies(STRATOS)initiativeaimstoprovideaccessibleandaccurate
| practice, | and | when | more | flexible | spline | approaches |     |
| --------- | --- | ---- | ---- | -------- | ------ | ---------- | --- |
guidanceforrelevanttopicsinthedesignandanalysisofobservational
should be preferred to simpler approaches like polyno- studies(http://stratos-initiative.org).
mials or fractional polynomials. In the context of de- MembersofTG2atthetimeoffirstsubmission:MichalAbrahamowicz,Heiko
Becher,HaraldBinder,DanielaDunkler,FrankHarrell,GeorgHeinze,Aris
| scriptive | modelling | discussed |     | here, determining |     | the final |     |
| --------- | --------- | --------- | --- | ----------------- | --- | --------- | --- |
Perperoglou,GeraldineRauch,PatrickRoyston,WilliSauerbreiandMatthias
| model data-dependently |     |     | causes | a selection |     | bias and | Schmid. |
| ---------------------- | --- | --- | ------ | ----------- | --- | -------- | ------- |

Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Page16of18
Authors’contributions 11. BinderH,SchumacherM.Allowingformandatorycovariatesinboosting
WSexpressedfirstthoughtsforsuchapaper.Allauthorssenttextand estimationofsparsehigh-dimensionalsurvivalmodels.BMCBioinform.
commentstovariouspartsofthepaper,whichwerecoordinatedbyWSand 2008;9:14.
GH.Allauthorsmadesubstantialcontributionstothepaperandhave 12. BinderH,SauerbreiW,RoystonP.Comparisonbetweensplinesandfractional
approvedthesubmittedversion.Theauthorsreadandapprovedthefinal polynomialsformultivariablemodelbuildingwithcontinuouscovariates:a
manuscript. simulationstudywithcontinuousresponse.StatMed.2013;32:2262–77.
13. BoulesteixAL,BinderH,AbrahamowiczM,SauerbreiW.Onthenecessity
Funding anddesignofstudiescomparingstatisticalmethods.BiometricalJ.2018;60:
Thefundingbodieshadnoinfluenceonanystatementinthepaper.
216–8.
14. BreimanL.Thelittlebootstrapandothermethodsfordimensionality
selectioninregression:X-fixedpredictionerror.JAmStatAssoc.1992;87:
Availabilityofdataandmaterials
738–54.
Datasharingisnotapplicabletothisarticleasnodatasetsweregenerated
15. BreimanL.Bettersubsetregressionusingthenon-negativeGarrote.
oranalysedduringthecurrentstudy.
Technometrics.1995;37:373–84.
16. BreimanL.StatisticalModeling:Thetwocultures.StatSci.2001;16:199–231.
Ethicsapprovalandconsenttoparticipate 17. BucklandST,BurnhamKP,AugustinNH.Modelselection:anintegralpartof
Notapplicable inference.Biometrics.1997;53:603–18.
18. BühlmannP.Hothorn.Boostingalgorithms:regularization,predictionand
Consentforpublication modelfitting.StatSci.2007;22:477–505.
Notapplicable 19. BurnhamKP,AndersonDR.Modelselectionandmultimodelinference:a
practicalinformation-theoreticapproach.NewYork:Springer;2002.
Competinginterests 20. BursacZ,GaussCH,WilliamsDK,HosmerDW.Purposefulselectionof
Theauthorsdeclarethattheyhavenocompetinginterests. variablesinlogisticregression.SourceCodeBiolMed.2008;3:17.
21. ChatfieldC.Modeluncertainty,dataminingandstatisticalinference(with
Authordetails
discussion).JRoyalStatSocSeriesB.1995;158:419–66.
1InstituteofMedicalBiometryandStatistics,FacultyofMedicineandMedical 22. ChatieldC.Confessionsofapragmaticstatistician.Statistician.2002;51:1–20.
Center,UniversityofFreiburg,Freiburg,Germany.2DataScienceandArtificial 23. ChenC,GeorgeSL.Thebootstrapandidentificationofprognosticfactors
IntelligenceAstraZeneca,Cambridge,UK.3DepartmentofMedicalBiometry, viaCox’sproportionalhazardsregressionmodel.StatMed.1985;4:39–46.
InformaticsandEpidemiology,FacultyofMedicine,UniversityofBonn,Bonn, 24. ChouldechovaA,HastieT.Generalizedadditivemodelselection.arXiv
Germany.4McGillUniversityHealthCentre,McGillUniversity,Montreal, preprint2015;arXiv:1506.03850.
Canada.5InstituteforMedicalBiometryandEpidemiology,UniversityMedical 25. CopasJB,LongT.Estimatingtheresidualvarianceinorthogonalregression
CenterHamburg-Eppendorf,Hamburg,Germany.6SectionforClinical withvariableselection.JournaloftheRoyalStatisticalSociety.SeriesD(The
Biometrics,CenterforMedicalStatistics,InformaticsandIntelligentSystems, Statistician).1991;40:51-59.
MedicalUniversityofVienna,Vienna,Austria.7DepartmentofBiostatistics, 26. CoxDR.CommentonBreiman,L.(2001).Statisticalmodeling:thetwo
SchoolofMedicine,VanderbiltUniversity,Nashville,TN,USA.8MRCClinical cultures.StatSci.2001;16:216–8.
TrialsUnitatUCL,InstituteofClinicalTrialsandMethodology,University 27. DaknaM,HarrisK,KalousiA,CarpentierS,KolchW,SchanstraJP,HaubitzM,
CollegeLondon,London,UK. VlahouA,MischakH,GirolamiM.Addressingthechallengeofdefiningvalid
proteomicbiomarkersandclassifiers.BMCBioinform.2010;11:594.
Received:6November2019Accepted:18March2020 28. deBinR,SauerbreiW.Handlingco-dependenceissuesinresampling-based
variableselectionprocedures:asimulationstudy.JStatComputSimul.
2018:8828–55.
References 29. deBinR,JanitzaS,SauerbreiW,BoulesteixAL.Subsamplingversus
1. AbrahamowiczM,duBergerR,GroverSA.Flexiblemodellingoftheeffects bootstrappinginresampling-basedmodelselectionformultivariable
ofserumcholesteroloncoronaryheartdiseasemortality.AmJEpidemiol.
regression.Biometrics.2016;72:272–80.
1997;145:714–29. 30. deBoorC.Apracticalguidetosplinesrevised.RevisedEdition.NewYork:
2. AltmanDG,AndersenPK.BootstrapinvestigationofthestabilityofaCox Springer;2001.
regressionmodel.StatMed.1989;8:771–83. 31. DorieV,HillJ,ShalitU,ScottM,CervoneD.Automatedversusdo-it-yourself
3. AltmanDG,LausenB,SauerbreiW,SchumacherM.Thedangersofusing methodsforcausalinference:lessonslearnedfromadataanalysis
‘optimal’cutpointsintheevaluationofprognosticfactors.JNatCancerInst. competition.StatSci.2019;34:43–68.
1994;86:829–35. 32. DraperD.Assessmentandpropagationofmodelselectionuncertainty
4. AltmanDG,McShaneLM,SauerbreiW,TaubeSE.Reporting
(with)discussion.JRoyalStatSocSeriesB.1995;57:45–97.
recommendationsfortumormarkerprognosticstudies(REMARK): 33. DunklerD,PlischkeM,LeffondréK,HeinzeG.Augmentedbackward
explanationandelaboration.PLoSMed.2012;9:e1001216. elimination:apragmaticandpurposefulwaytodevelopstatisticalmodels.
5. AntoniadisA,GijbelsI,VerhasseltA.Variableselectioninadditivemodels PLoSONE.2014;9:e113677.
usingP-splines.Technometrics.2012;54:425–38. 34. DunklerD,SauerbreiW,HeinzeG.Global,parameterwiseandjoint
6. AremH,MooreSC,PatelA,HartgeP,BerringtonDE,GonzalezA, shrinkagefactorestimation.JStatSoftw.2016;69:1–19.
VisvanathanK,CampbellPT,FreedmanM,WeiderpassE,AdamiHO,Linet 35. EfronB.CommentonBreiman,L.(2001).Statisticalmodeling:thetwo
MS,LeeIM,MatthewsCE.LeisureTimephysicalactivityandmortality.A cultures.StatSci.2001;16:218–9.
detailedpooledanalysisofthedose-responserelationship.JAMAIntern 36. EfronB,HastieT,JohnstoneI,TibshiraniR.Leastangleregression.Ann
Med.2015;175:959–67. Statist.2004;32:407–99.
7. AugustinN,SauerbreiW,SchumacherM.Thepracticalutilityof 37. EfroymsonMA.Multipleregressionanalysis.in:RalstonAandWilfHS(ed.).
incorporatingmodelselectionuncertaintyintoprognosticmodelsfor Mathematicalmethodsfordigitalcomputers.JohnWiley.NewYork;1960.
survivaldata.StatModel.2015;5:95–118. 38. EilersPHC,MarxBD.FlexiblesmoothingwithB-splinesandpenalties(with
8. BecherH.Analysisofcontinuouscovariatesanddose-effectanalysis.In: commentsandrejoinder).StatSci.1996;11:89–121.
AhrensW,PigeotI(Eds)Handbookofepidemiology.2ndedition. 39. FanJ,LiR.Variableselectionvianonconcavepenalizedlikelihoodandits
Heidelberg:SpringerVerlag;2014. oracleproperties.JAmStatAssoc.2001;96:1348–60.
9. BecherH,LorenzE,RoystonP,SauerbreiW.Analysingcovariateswithspike 40. FreundY,SchapireR.Experimentswithanewboostingalgorithm.In:
atzero.amodifiedFPprocedureandconceptualissues.BiometricalJ.2012; ProceedingsoftheThirteenthInternationalConferenceonMachine
54:686–700. LearningTheory.SanFrancisco,CA:MorganKaufmannPublishersInc;1996.
10. BenedettiA,AbrahamowiczM.Usinggeneralizedadditivemodelsto 41. FriedmanJH.Greedyfunctionapproximation:agradientboostingmachine.
reduceresidualconfounding.StatMed.2004;23:3781–801. AnnStat.2001;29:1189–232.

Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Page17of18
42. FriedmanJH,HastieT,TibshiraniR.Additivelogisticregression:astatistical 70. LorenzE,JenknerC,SauerbreiW,BecherH.Modelingvariableswithaspikeat
viewofboosting(withdiscussion).AnnStat.2000;28:337–407. zero.Examplesandpracticalrecommendations.AmJEpidemiol.2017;185:1–39.
43. FriedmanJ,HastieT,TibshiraniR.Regularizationpathsforgeneralizedlinear 71. MaldonadoG,GreenlandS.Simulationofconfounder-selectionstrategies.
modelsviacoordinatedescent.JStatSoftw.2010;33:1–22. AmJEpidemiol.1993;138:923–36.
44. FröhlichH.IncludingnetworkknowledgeintoCoxregressionmodelsfor 72. MallowsCL.Thezerothproblem.AmStat.1998;52:1–9.
biomarkersignaturediscovery.BiometricalJ.2014;56:287–306. 73. MantelN.Whystepdownproceduresinvariableselection?Technometrics.
45. GongG.Someideasonusingthebootstrapinassessingmodelvariability. 1970;12:621–5.
In:HeinerKW,SacherRS,WilkinsonJW,editors.ComputerScienceand 74. MarcusR,PeritzE,GabrielKR.Onclosedtestprocedureswithspecial
Statistics:Proceedingsofthe14thSymposiumontheInterface.NewYork: referencetoorderedanalysisofvariance.Biometrika.1976;76:655–60.
Springer;1982. 75. MarraG,WoodSN.Practicalvariableselectionforgeneralizedadditive
46. GoodDM,ZürbigP,ArgilésA,BauerHW,BehrensG,CoonJJ,DaknaM, models.ComputStatDataAnal.2011;55:2372–87.
DecramerS,DellesC,DominiczakAF,EhrichJHH.Naturallyoccurring 76. MayrA,BinderH,GefellerO,SchmidM.TheEvolutionofboosting
humanurinarypeptidesforuseindiagnosisofchronickidneydisease.Mol algorithms–frommachinelearningtostatisticalmodelling.MethodsInf
CellProteomic.2010;9:2424–37. Med.2014;53:419–27.
47. GreenlandS.Avoidingpowerlossassociatedwithcategorizationand 77. MeierL,vandeGeerS,BühlmannP.High-dimensionaladditivemodeling.
ordinalscoresindose-responseandtrendanalysis.Epidemiology.1995;6: AnnStat.2009;37:3779–821.
450–4. 78. MeinshausenN,BühlmannP.Stabilityselection.JStatSocSeriesBStat
48. GroenwoldRHH,KlungelOH,vanderGraafY,HoesAW,MoonsKGM. Methodol.2010;72:417–73.
Adjustmentforcontinuousconfounders:anexampleofhowtoprevent 79. MillerA.Selectionofsubsetsofregressionvariables.JournaloftheRoyal
residualconfounding.CanMedAssocJ.2013;185:401–6. StatisticalSociety.SeriesA(General).1984;147:389–425.
49. HarrellFE.Regressionmodelingstrategies.In: Withapplicationstolinear 80. MillerR,SiegmundD.Maximallyselectedchi-squarestatistics.Biometrics.
models,logisticandordinalregression,andsurvivalanalysis.NewYork: 1982;38:1011–6.
Springer;2001. 81. MoonsKG,AltmanKG,ReitsmaJB,IoannidisJP,MacaskillP,SteyerbergEW,
50. HarrellFE.Regressionmodelingstrategies:withapplicationstolinear VickersAJ,RansohoffDF,CollinsGGS.TransparentReportingofa
models,logisticandordinalregression,andsurvivalanalysis.2nded.New multivariablepredictionmodelforIndividualPrognosisOrDiagnosis
York:Springer;2015. (TRIPOD):ExplanationandElaboration.AnnInternMed.2015;162:W1–W73.
51. HarrellFE,LeeKL,MarkDB.Multivariableprognosticmodels:issuesin 82. MorrisT,WhiteIR,CrowtherMJ.Usingsimulationstudiestoevaluate
developingmodels,evaluatingassumptionsandadequacy,andmeasuring statisticalmethods.StatMed.2019;38:2074–102.
andreducingerrors.StatMed.1996;15:361–87. 83. Nkuipou-KenfackE,ZürbigP,MischakH.Thelongpathtowards
52. HastieT,TibshiraniR.Generalizedadditivemodels.NewYork:Chapman& implementationofclinicalproteomics:exemplifiedbasedonCKD273.
Hall/CRC;1990. ProteomicsClinAppl.2017;11:5–6.
53. HastieT,TibshiraniR,FriedmanJ.Theelementsofstatisticallearning.2nd 84. PerperoglouA,SauerbreiW,AbrahamowiczM,SchmidM,onbehalfofTG2
ed.NewYork:Springer;2009. oftheSTRATOSinitiative.AreviewofsplinefunctionproceduresinR.BMC
54. HastieT,TibshiraniR,WainwrightM.StatisticallearningwithSparsity:The MedResMethodol.2019;19:46.
lassoandgeneralizations.CRCPressLLC:BocaRaton.Monographson 85. PicardRP,CookRD.Cross-validationofregressionmodels.JAmStatAssoc.
statisticsandappliedprobability;2015. 1984;79:575–83.
55. HeinzeG,DunklerD.Fivemythsaboutvariableselection.TransplantInt. 86. PullenayegumEM,PlattRW,BarwickM,FeldmanBM,OffringaM,ThabaneL.
2017;30:6–10. Knowledgetranslationinbiostatistics:asurveyofcurrentpractices,
56. HeinzeG,WallischC,Dunkler D.Variableselection–areviewand preferences,andbarrierstothedisseminationanduptakeofnewstatistical
recommendationsforthepracticingstatistician.BiometricalJ.2018;60: methods.StatMed.2015;35:805–18.
431–49. 87. RafteryAE.Bayesianmodelselectioninsocialresearch.SociolMethodol.
57. HilsenbeckSG,ClarkGM,McguireW.Whydosomanyprognosticfactors 1995;25:111–63.
failtopanout?BreastCancerResTreat.1992;22:197–206. 88. RamaiolaI,PadróT,PeñaE,Juan-BabotO,CubedoJ,Martin-YusteV,Sabate
58. HoerlAE,KennardRW.RidgeRegression:biasedestimationfor M,BadimonL.Changesinthrombuscompositionandprofilin-1releasein
nonorthogonalproblems.Technometrics.1970;12:55–67. acutemyocardialinfarction.EurHeartJ.2015;36:965–75.
59. HoetingJA,MadiganD,RafteryAE,VolinskyCT.Bayesianmodelaveraging: 89. RamsayJO.Monotoneregressionsplinesinaction.StatSci.1988;3:425–41.
atutorial.StatSci.1999;14:382–417. 90. RavikumarP,LiuH,LaffertyJ,WassermanL.Spam.Sparseadditivemodels.
60. HofnerB,HothornT,KneibT,SchmidM.Aframeworkforunbiasedmodel InAdvancesinNeuralInformationProcessingSystems.Vol.20(edsJ.Platt,
selectionbasedonboosting.JComputGraphicalStat.2011;20:956–71. D.Koller,Y.SingerS.Roweis).Cambridge,MITPress;2008.
61. HosmerD,LemeshowS,MayS.Appliedsurvivalanalysis(2nded.).Wiley. 91. RosenbergPS,KatkiH,SwansonCA,Brown LM,WacholderS,Hoover
Hoboken,NJ;2008. RN.Quantifyingepidemiologicriskfactorsusingnon-parametric
62. HosmerD,LemeshowS,SturdivantRX.Appliedlogisticregression.3rded. regression:modelselectionremainsthegreatestchallenge.StatMed.
Hoboken:Wiley;2013. 2003;22:3369–81.
63. HuebnerM,leCessieS,SchmidtC,VachW,OnbehalfoftheTopicGroup 92. RospleszczS,JanitzaS,BoulesteixAL. Categoricalvariableswithmany
“InitialDataAnalysis”oftheSTRATOSInitiative.AContemporaryConceptual categoriesarepreferentiallyselectedinbootstrap-basedmodel
FrameworkforInitialDataAnalysis.ObservationalStudies.2018;4:171–92. selectionprocedures formultivariableregressionmodels.BiometricalJ.
64. JanitzaS,BinderH,BoulesteixAL.Pitfallsofhypothesistestsandmodel 2016;58:652–73.
selectiononboot-strapsamples:causesandconsequencesinbiometrical 93. RoystonP,AltmanDG.Regressionusingfractionalpolynomialsofcontinuous
applications.BiometricalJ.2016;58:447–73. covariates:parsimoniousparametricmodelling.ApplStat.1994;43:429–67.
65. JenknerC,LorenzE,BecherH,SauerbreiW.Modelingcontinuouscovariates 94. RoystonP,AltmanDG,SauerbreiW.Dichotomizingcontinuouspredictorsin
witha‘spike‘atzero:bivariateapproaches.BiometricalJ.2016;58:783–96. multipleregression:abadidea.StatMed.2006;25:127–41.
66. LeePH.Isacutoffof10%appropriateforthechange-in-estimatecriterion 95. RoystonP,SauerbreiW.Multivariablemodellingwithcubicregression
ofconfounderidentification?JEpidemiol.2014;24:161–7. splines:aprincipledapproach.StataJ.2007;7:45–70.
67. LeebH,PötscherBM.Modelselectionandinference:factsandfiction. 96. RoystonP,SauerbreiW.Multivariablemodel-building.apragmaticapproach
EconometricTheory.2005;21:21–59. toregressionanalysisbasedonfractionalpolynomialsforcontinuous
68. LeffondreK,AbrahamowiczM,SiemiatyckiJ, RachetB.Modeling variables.Wiley,Chichester;2008.
smokinghistory:acomparisonofdifferentapproaches.AmJEpidemiol. 97. SauerbreiW.Theuseofresamplingmethodstosimplifyregressionmodels
2002;156:813–23. inmedicalstatistics.ApplStat.1999;48:313–29.
69. LinY,ZhangHH.Componentselectionandsmoothinginmultivariate 98. SauerbreiW,AbrahamowiczM,AltmanDG,leCessieS,CarpenterJ,on
nonparametricAmericanJournalofEpidemiologyregression.AnnStat. behalfoftheSTRATOSinitiative.STRengtheningAnalyticalThinkingfor
2006;34:2272–97. ObservationalStudies:TheSTRATOSinitiative.StatMed.2014;33:5413–32.

Sauerbreietal.DiagnosticandPrognosticResearch (2020) 4:3 Page18of18
99. SauerbreiW,BuchholzA,BoulesteixAL,BinderH.Onstabilityissuesin 130. ZouH.TheadaptiveLASSOanditsoracleproperties.JAmStatAssoc.2006;
derivingmultivariableregressionmodels.BiometricalJ.2015:57531–55. 101:1418–29.
100. SauerbreiW,Meier-HirmerC,BennerA,RoystonP.Multivariableregression
modelbuildingbyusingfractionalpolynomials:descriptionofSAS,STATA Publisher’s Note
andRprograms.ComputStatDataAnal.2006;50:3464–85.
SpringerNatureremainsneutralwithregardtojurisdictionalclaimsin
101. SauerbreiW,RoystonP.Buildingmultivariableprognosticanddiagnostic
publishedmapsandinstitutionalaffiliations.
models:transformationofthepredictorsbyusingfractionalpolynomials.J
RoyalStatSocA.1999;162:71–94.
102. SauerbreiW,RoystonP,BinderH.Selectionofimportantvariablesand
determinationoffunctionalformforcontinuouspredictorsinmultivariable
modelbuilding.StatMed.2007;26:5512–28.
103. SauerbreiW,SchumacherM.Abootstrapresamplingprocedureformodel
building:applicationtothecoxregressionmodel.StatMed.1992;11:2093–109.
104. SchmidM,HothornT.BoostingadditivemodelsusingcomponentwiseP-
splines.ComputStatDataAnal.2008;53:298–311.
105. ShawPA,DeffnerV,DoddKW,FreedmanLS,KeoghR,KipnisV,Küchenhoff
H,ToozeJA,onbehalfofMeasurementErrorWorkinggroup(TG4)ofthe
STRATOSinitiative.Epidemiologicalanalyseswitherrorproneexposures:
reviewofcurrentpractiseandrecommendations.AnnEpidemiol.2018;28:
82–828.
106. ShmueliG.Toexplainortopredict?StatSci.2010;25:289–310.
107. SmithGCS,SeamanSR,WoodAM,RoystonP,WhiteIR.Correctingfor
OptimisticPredictioninSmallDataSets.AmJEpidemiol.2014;180:318–24.
108. SteinerM,KimY.TheMechanicsofomittedvariablebias:biasamplification
andcancellationofoffsettingbiases.JCausalInference.2016;4:20160009.
109. SunGW,ShookTL,KayGL.Inappropriateuseofbivariableanalysistoscreen
riskfactorsforuseinmultivariableanalysis.JClinEpidemiol.1996;49:907–16.
110. TaylorJ,TibshiraniRJ.Statisticallearningandselectiveinference.ProcNatl
AcadSciUSA.2015;112:7629–34.
111. TeräsvirtaT,MellinI.Modelselectioncriteriaandmodelselectiontestsin
regressionmodels.ScandJStat.1986;13:159–71.
112. TibshiraniR.RegressionshrinkageandselectionviatheLasso.JRoyalStat
SocSeriesBMethodol.1996;58:267–88.
113. TibshiraniR.Regressionshrinkageandselectionviathelasso:a
retrospective.JRoyalStatSocSeriesB.2011;73:273–82.
114. TibshiraniR,TaylorJ,LoftusJ,ReidS.Selectiveinference:toolsforselective
inference.ProcNatlAcadSciUSA.2017;112:7629–34.
115. TutzG,BinderH.Generalizedadditivemodellingwithimplicitvariable
selectionbylikelihoodbasedboosting.Biometrics.2016;62:961–71.
116. vanHouwelingenHC.Frommodelbuildingtovalidationandback:aplea
forrobustness.StatMed.2014;33:5223–38.
117. vanHouwelingenHC,SauerbreiW.Cross-validation,shrinkageandvariable
selectioninlinearregressionrevisited.OpenJStat.2013;3:79–102.
118. vanHouwelingenJC,leCessieS.Predictivevalueofstatisticalmodels.Stat
Med.1990;9:1303–25.
119. vanWalravenC,HartRG.Leave‘emalone-whycontinuousvariables
shouldbeanalyzedassuch.Neuroepidemiology.2008;30:138–9.
120. VandenbrouckeJP,vonElmE,AltmanDG,GotzschePC,MulrowCD,Pocock
SJ,PooleC,SchlesselmanJJ,EggerM.StrengtheningtheReportingof
ObservationalStudiesinEpidemiology(STROBE):Explanationand
Elaboration.Epidemiology.2007;18:805–35.
121. VickersAJ,LiljaH.Cutpointsinclinicalchemistry:timeforfundamental
reassessment.ClinChem.2009;55:15–7.
122. WhiteH.Usingleastsquarestoapproximateunknownregressionfunctions.
IntEconRev.1980a;21:149–70.
123. WhiteHA.Heteroskedasticity-consistentcovariancematrixestimatoranda
directtestforheteroskedasticity.Econometrica.1980b;48:817–38.
124. WikimediaFoundationInc;2019.Statisticalmodel.URLhttps://en.wikipedia.
org/wiki/State_of_the_art.Accessed1July2019.
125. WinterC,KristiansenG,KerstingS,RoyJ,AustD,KnöselT,RümmeleP,
JahnkeB,HentrichV,RückertF,NiedergethmannM,WeichertW,BahraM,
SchlittHJ,SettmacherU,FriessH,BüchlerM,SaegerH-D,SchroederM,
PilarskyC,GrützmannR.Googlegoescancer:improvingoutcome
predictionforcancerpatientsbynetwork-basedrankingofmarkergenes.
PLOSComputBiol.2012;8:e1002511.
126. WoodS.Thinplateregressionsplines.JRoyalStatSocSeriesB.2003;65:95–114.
127. WoodS.Generalizedadditivemodels.NewYork:Chapman&Hall/CRC;2006.
128. WoodS.Generalizedadditivemodels:anintroductionwithR.Second
Edition:CRCPress;2017.
129. ZouH,HastieT.Regularizationandvariableselectionviatheelasticnet.J
RoyalStatSocSeriesB(Methodological).2005;67:301–20.
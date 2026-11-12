Package ‘emmeans’
July15,2026
Type Package
Title EstimatedMarginalMeans,akaLeast-SquaresMeans
Version 2.0.4
Date 2026-07-15
Maintainer JuliaPiaskowski<julia.piask@gmail.com>
Depends R(>=4.1.0)
Imports estimability(>=1.4.1),graphics,methods,mvtnorm,numDeriv,
rlang,stats,utils
Suggests bayesplot,bayestestR,biglm,brms,car,coda(>=0.17),
compositions,ggplot2(>=4.0.0),knitr,lattice,lme4,
lmerTest(>=2.0.32),logspline,MASS,mediation,mgcv,
multcomp,multcompView,MuMIn,nlme,ordinal(>=2014.11-12),
pbkrtest(>=0.4-1),rmarkdown,robmixglm,rsm,sandwich,
scales,splines,testthat,tibble,xtable(>=1.8-2)
Enhances CARBayes,coxme,gee,geepack,MCMCglmm,MCMCpack,mice,
nnet,pscl,rstanarm,sommer,survival
URL https://rvlenth.github.io/emmeans/,
https://github.com/rvlenth/emmeans/
BugReports https://github.com/rvlenth/emmeans/issues
LazyData yes
ByteCompile yes
Description Obtainestimatedmarginalmeans(EMMs)formanylinear,generalized
linear,andmixedmodels.ComputecontrastsorlinearfunctionsofEMMs,
trends,andcomparisonsofslopes.Plotsandotherdisplays.
Least-squaresmeansarediscussed,andtheterm``estimatedmarginalmeans''
issuggested,inSearle,Speed,andMilliken(1980)Populationmarginalmeans
inthelinearmodel:Analternativetoleastsquaresmeans,TheAmerican
Statistician34(4),216-221<doi:10.1080/00031305.1980.10483031>.
License GPL-2|GPL-3
Encoding UTF-8
1

2 Contents
RoxygenNote 8.0.0
VignetteBuilder knitr
NeedsCompilation no
Author RussellV.Lenth[aut,cph],
JuliaPiaskowski[cre,aut],
BalazsBanfai[ctb],
BenBolker[ctb],
PaulBuerkner[ctb],
IagoGiné-Vázquez[ctb],
MaximeHervé[ctb],
MaartenJung[ctb],
JonathonLove[ctb],
FernandoMiguez[ctb],
HannesRiebl[ctb],
HenrikSingmann[ctb],
AlexisDerumigny[ctb],
PaulSchmidt[ctb]
Repository CRAN
Date/Publication 2026-07-1506:40:08UTC
Contents
emmeans-package . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 3
as.list.emmGrid . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 5
as.mcmc.emmGrid . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 6
auto.noise . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 8
cld.emmGrid . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 9
comb_facs . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
contrast . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
contrast-methods . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
eff_size . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
emm . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
emmeans . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
emmGrid-class . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
emmip . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
emmobj . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
emm_example . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
emm_list . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
emm_options . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
emtrends. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 43
extending-emmeans . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
feedlot . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 51
fiber . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
hpd.summary . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
joint_tests . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
lsmeans . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 58

emmeans-package 3
make.tran . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 59
MOats . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 62
models . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63
mvcontrast. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63
mvregrid. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 64
neuralgia . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 65
nutrition . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 66
oranges . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 67
pigs . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 68
plot.emmGrid . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 69
pwpm . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 72
pwpp . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 73
qdrg . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 75
rbind.emmGrid . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 78
ref_grid . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 80
regrid . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 87
str.emmGrid . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 89
summary.emmGrid . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 90
ubds . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 98
untidy . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 99
update.emmGrid . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 99
xtable.emmGrid . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 103
Index 105
emmeans-package Estimatedmarginalmeans(akaLeast-squaresmeans)
Description
This package provides methods for obtaining estimated marginal means (EMMs, also known as
least-squares means) for factor combinations in a variety of models. Supported models include
[generalized linear] models, models for counts, multivariate, multinomial and ordinal responses,
survivalmodels,GEEs,andBayesianmodels. Forthelatter,posteriorsamplesofEMMsarepro-
vided. The package can compute contrasts or linear combinations of these marginal means with
various multiplicity adjustments. One can also estimate and contrast slopes of trend lines. Some
graphicaldisplaysoftheseresultsareprovided.
Overview
Vignettes Anumberofvignettesareprovidedtohelptheusergetacquaintedwiththeemmeans
packageandseesomeexamples.
Concept Estimated marginal means (see Searle et al. 1980 are popular for summarizing linear
models that include factors. For balanced experimental designs, they are just the marginal
means. For unbalanced data, they in essence estimate the marginal means you would have
observed that the data arisen from a balanced experiment. Earlier developments regarding
these techniques were developed in a least-squares context and are sometimes referred to as

4 emmeans-package
“least-squares means”. Since its early development, the concept has expanded far beyond
least-squaressettings.
Referencegrids Theimplementationinemmeansreliesonourownconceptofareferencegrid,
which is an array of factor and predictor levels. Predictions are made on this grid, and esti-
mated marginal means (or EMMs) are defined as averages of these predictions over zero or
more dimensions of the grid. The function ref_grid explicitly creates a reference grid that
cansubsequentlybeusedtoobtainleast-squaresmeans. Theobjectreturnedbyref_gridis
ofclass"emmGrid",thesameclassasisusedforestimatedmarginalmeans(seebelow).
Our reference-grid framework expands slightly upon Searle et al.’s definitions of EMMs, in
thatitispossibletoincludemultiplelevelsofcovariatesinthegrid.
Modelssupported As is mentioned in the package description, many types of models are sup-
portedbythepackage.Seevignette("models","emmeans")forfulldetails.Somemodelsmay
requireotherpackagesbeinstalledinordertoaccessalloftheavailablefeatures. Formodels
notexplicitlysupported,itmaystillbepossibletodobasicposthocanalysesofthemviathe
qdrgfunction.
Estimatedmarginalmeans TheemmeansfunctioncomputesEMMsgivenafittedmodel(orapre-
viouslyconstructedemmGridobject),usingaspecificationindicatingwhatfactorstoinclude.
Theemtrendsfunctioncreatesthesamesortofresultsforestimatingandcomparingslopes
offittedlines. BothreturnanemmGridobject.
Summariesandanalysis Thesummary.emmGridmethodmaybeusedtodisplayanemmGridob-
ject. Special-purposesummariesareavailableviaconfint.emmGridandtest.emmGrid,the
latter of which can also do a joint test of several estimates. The user may specify by vari-
ables,multiplicity-adjustmentmethods,confidencelevels,etc.,andifatransformationorlink
functionisinvolved,mayreverse-transformtheresultstotheresponsescale.
Contrastsandcomparisons The contrast method for emmGrid objects is used to obtain con-
trastsamongtheestimates;severalstandardcontrastfamiliesareavailablesuchasdeviations
from the mean, polynomial contrasts, and comparisons with one or more controls. Another
emmGridobjectisreturned,whichcanbesummarizedorfurtheranalyzed. Forconvenience,
apairs.emmGridmethodisprovidedforthecaseofpairwisecomparisons.
Graphs The plot.emmGrid method will display side-by-side confidence intervals for the esti-
mates, and/or “comparison arrows” whereby the *P* values of pairwise differences can be
observed by how much the arrows overlap. The emmip function displays estimates like an
interaction plot, multi-paneled if there are by variables. These graphics capabilities require
thelatticepackagebeinstalled.
MCMCsupport WhenamodelisfittedusingMCMCmethods,theposteriorchains(s)ofparam-
eterestimatesareretainedandconvertedintoposteriorsamplesofEMMsorcontraststhereof.
These may then be summarized or plotted like any other MCMC results, using tools in, say
codaorbayesplot.
multcompinterface Theas.glhtfunctionandglhtmethodforemmGridsprovideaninterfaceto
theglhtfunctioninthemultcomppackage,thusprovidingformoreexactingsimultaneous
estimationortesting. Thepackagealsoprovidesanemmfunctionthatworksasanalternative
tomcpinacalltoglht.

| as.list.emmGrid |                                |     |     |     |     | 5   |
| --------------- | ------------------------------ | --- | --- | --- | --- | --- |
| as.list.emmGrid | ConverttoandfromemmGridobjects |     |     |     |     |     |
Description
These are useful utility functions for creating a compact version of an emmGrid object that may
|     |     |     | ref.grid | lsmobj |     | emmGrid |
| --- | --- | --- | -------- | ------ | --- | ------- |
be saved and later reconstructed, or for converting old or objects into
objects.
Usage
| ## S3 method        | for class       | 'emmGrid' |      |     |     |     |
| ------------------- | --------------- | --------- | ---- | --- | --- | --- |
| as.list(x,          | model.info.slot | = FALSE,  | ...) |     |     |     |
| as.emm_list(object, | ...)            |           |      |     |     |     |
| as.emmGrid(object,  | ...)            |           |      |     |     |     |
Arguments
| x   | AnemmGridobject |     |     |     |     |     |
| --- | --------------- | --- | --- | --- | --- | --- |
model.info.slot
|     | Logical | value: Include | the model.info | slot? Set | this to TRUE | if you want to |
| --- | ------- | -------------- | -------------- | --------- | ------------ | -------------- |
submodel
|     | preserve | the original | call and information | needed | by the | option. If |
| --- | -------- | ------------ | -------------------- | ------ | ------ | ---------- |
FALSE,onlythenestinginformation(ifany)issaved
... Inas.emmGrid,additionalargumentspassedtoupdate.emmGridbeforereturn-
Thisargumentisignoredinas.list.emmGrid
ingtheobject.
object ObjecttobeconvertedtoclassemmGrid.Itmaybealistreturnedbyas.list.emmGrid,
oraref.gridorlsmobjobjectcreatedbyemmeans’spredecessor,thelsmeans
Anerroristhrownifobjectcannotbeconverted.
package.
Details
AnemmGridobjectisanS4object,andassuchcannotbesavedinatextformatorsavedwithout
Byusingas.list,theessentialpartsoftheobjectareconvertedtoalistformat
alotofoverhead.
thatcanbeeasilyandcompactlysavedforuse,say,inanothersessionorbyanotheruser. Providing
thislistastheargumentsforemmobjallowstheusertorestoreaworkingemmGridobject.
Value
as.list.emmGridreturnsanobjectofclasslist.
as.emm_listreturnsanobjectofclassemm_list.
as.emmGridreturnsanobjectofclassemmGrid.However,infact,bothas.emmGridandas.emm_list
checkforanattributeinobjecttodecidewhethertoreturnanemmGridoremm_list)object.

| 6   |     |     |     |     | as.mcmc.emmGrid |     |
| --- | --- | --- | --- | --- | --------------- | --- |
SeeAlso
emmobj
Examples
| pigs.lm            | <- lm(log(conc)               | ~ source | + factor(percent), | data = | pigs) |     |
| ------------------ | ----------------------------- | -------- | ------------------ | ------ | ----- | --- |
| pigs.sav           | <- as.list(ref_grid(pigs.lm)) |          |                    |        |       |     |
| pigs.anew          | <- as.emmGrid(pigs.sav)       |          |                    |        |       |     |
| emmeans(pigs.anew, | "source")                     |          |                    |        |       |     |
as.mcmc.emmGrid
SupportforMCMC-basedestimation
Description
When a model is fitted using Markov chain Monte Carlo (MCMC) methods, its reference grid
containsapost.betaslot. Thesefunctionstransformthoseposteriorsamplestoposteriorsamples
ofEMMsorrelatedcontrasts. Theycanthenbesummarizedorplottedusing,e.g.,functionsinthe
codapackage.
Usage
| ## S3 method    | for class | 'emmGrid'        |         |             |     |     |
| --------------- | --------- | ---------------- | ------- | ----------- | --- | --- |
| as.mcmc(x,      | names =   | TRUE, sep.chains | = TRUE, | likelihood, |     |     |
| NE.include      | = FALSE,  | ...)             |         |             |     |     |
| ## S3 method    | for class | 'emm_list'       |         |             |     |     |
| as.mcmc(x,      | which =   | 1, ...)          |         |             |     |     |
| ## S3 method    | for class | 'emmGrid'        |         |             |     |     |
| as.mcmc.list(x, | names     | = TRUE,          | ...)    |             |     |     |
| ## S3 method    | for class | 'emm_list'       |         |             |     |     |
| as.mcmc.list(x, | which     | = 1,             | ...)    |             |     |     |
Arguments
| x   | AnobjectofclassemmGrid |     |     |     |     |     |
| --- | ---------------------- | --- | --- | --- | --- | --- |
names Logicalscalarorvectorspecifyingwhethervariablenamesareappendedtolev-
elsinthecolumnlabelsfortheas.mcmcoras.mcmc.listresult–e.g.,column
namesoftreatAandtreatBversusjustAandB.Whenthereismorethanone
variableinvolved,theelementsofnamesareusedcyclically.
| sep.chains |     |     | IfTRUE,andthereismorethanoneMCMCchainavailable, |     |     |     |
| ---------- | --- | --- | ----------------------------------------------- | --- | --- | --- |
Logicalvalue. an
|     | mcmc.list | object | is returned | by as.mcmc, with | separate EMMs | posteriors in |
| --- | --------- | ------ | ----------- | ---------------- | ------------- | ------------- |
eachchain.

| as.mcmc.emmGrid |     |     |     |     |     |     | 7   |
| --------------- | --- | --- | --- | --- | --- | --- | --- |
likelihood Character value or function. If given, simulations are made from the corre-
|     | spondingposteriorpredictivedistribution. |     |     | Ifnotgiven,weobtaintheposterior |     |     |     |
| --- | ---------------------------------------- | --- | --- | ------------------------------- | --- | --- | --- |
distributionoftheparametersinobject.
SeePredictionsectionbelow.
NE.include Logicalvalue. IfTRUE,non-estimablecolumnsarekeptbutreturnedascolumns
|     | of NA values | (this | may create errors | or warnings | in subsequent | analyses | using, |
| --- | ------------ | ----- | ----------------- | ----------- | ------------- | -------- | ------ |
FALSE,
|     | say, coda). | If  | non-estimable | columns | are dropped, | and a warning | is  |
| --- | ----------- | --- | ------------- | ------- | ------------ | ------------- | --- |
issued. (Ifallarenon-estimable,anerroristhrown.)
| ...   | argumentspassedtoothermethods |     |     |     |     |     |     |
| ----- | ----------------------------- | --- | --- | --- | --- | --- | --- |
| which | itemintheemm_listtouse        |     |     |     |     |     |     |
Value
Anobjectofclassmcmcormcmc.list.
Details
|                   | post.beta |         | as.mcmc      |      | mcmc      | mcmc.list |     |
| ----------------- | --------- | ------- | ------------ | ---- | --------- | --------- | --- |
| When the object’s |           | slot is | non-trivial, | will | return an | or        | ob- |
ject that can be summarized or plotted using methods in the coda package. In these functions,
post.betaistransformedbypost-multiplyingitbyt(linfct),creatingasamplefromtheposte-
Inas.mcmc,ifsep.chainsisTRUEandthereisinfactmorethanone
riordistributionofLSmeans.
chain,anmcmc.listisreturnedwitheachchain’sresults.Theas.mcmc.listmethodisguaranteed
toreturnanmcmc.list,evenifitcomprisesjustonechain.
Prediction
Whenlikelihoodisspecified,itisusedtosimulatevaluesfromtheposteriorpredictivedistribu-
tioncorrespondingtothegivenlikelihoodandtheposteriordistributionofparametervalues.Denote
thelikelihoodfunctionasf(y|θ,ϕ),whereyisaresponse,θistheparameterestimatedinobject,
Iflikelihoodisafunction,
andϕcompriseszeroormoreadditionalparameterstobespecified.
thatfunctionshouldtakeasitsfirstargumentavectorofθ values(eachcorrespondingtoonerow
ofobject@grid). Anyϕvaluesshouldbespecifiedasadditionalnamedfunctionarguments,and
| passedtolikelihoodvia.... |     | Thisfunctionshouldsimulatevaluesofy. |     |     |     |     |     |
| ------------------------- | --- | ------------------------------------ | --- | --- | --- | --- | --- |
Afewstandardlikelihoodsareavailablebyspecifyinglikelihoodasacharactervalue. Theyare:
"normal" Thenormaldistributionwithmeanθ andstandarddeviationspecifiedbyadditionalar-
gumentsigma
"binomial"
Thebinomialdistributionwithsuccessprobabilitytheta,andnumberoftrialsspeci-
fiedbytrials
| "poisson" ThePoissondistributionwithmeantheta(noadditionalparameters) |     |     |     |     |     |     |     |
| --------------------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
"gamma" Thegammadistributionwithscaleparameterθandshapeparameterspecifiedbyshape
Examples
if(requireNamespace("coda"))
emm_example("as.mcmc-coda")
| # Use emm_example("as.mcmc-coda", |     |     | list = TRUE) | # to see | just the | code |     |
| --------------------------------- | --- | --- | ------------ | -------- | -------- | ---- | --- |

8 auto.noise
auto.noise AutoPollutionFilterNoise
Description
Three-factorexperimentcomparingpollution-filternoisefortwofilters,threesizesofcars,andtwo
sidesofthecar.
Usage
data(auto.noise)
Format
Adataframewith36observationsonthefollowing4variables.
noise Noiselevelindecibels(butseenote)-anumericvector.
size Thesizeofthevehicle-anorderedfactorwithlevelsS,M,L.
type Typeofanti-pollutionfilter-afactorwithlevelsStdandOctel
side Thesideofthecarwheremeasurementwastaken–afactorwithlevelsLandR.
Details
The data are from a statement by Texaco, Inc., to the Air and Water Pollution Subcommittee of
theSenatePublicWorksCommitteeonJune26, 1973. Mr. JohnMcKinley, PresidentofTexaco,
citedanautomobilefilterdevelopedbyAssociatedOctelCompanyaseffectiveinreducingpollu-
tion. However, questions had been raised about the effects of filters on vehicle performance, fuel
consumption,exhaustgasbackpressure,andsilencing. Onthelastquestion,hereferredtothedata
includedhereasevidencethatthesilencingpropertiesoftheOctelfilterwereatleastequaltothose
ofstandardsilencers.
Note
While the data source claims that noise is measured in decibels, the values are implausible. I
believe that these measurements are actually in tenths of dB (centibels?). Looking at the values
in the dataset, note that every measurement ends in 0 or 5, and it is reasonable to believe that
measurementsareaccuratetothenearesthalfofadecibel.
Source
ThedatasetwasobtainedfromtheDataandStoryLibrary(DASL)atCarnegie-MellonUniversity.
Apparently it has since been removed. The original dataset was altered by assigning meaningful
names to the factors and sorting the observations in random order as if this were the run order of
theexperiment.

| cld.emmGrid |     |     |     |     |     |     | 9   |
| ----------- | --- | --- | --- | --- | --- | --- | --- |
Examples
| # (Based               | on belief that | noise/10    | is            | in decibel | units)             |     |     |
| ---------------------- | -------------- | ----------- | ------------- | ---------- | ------------------ | --- | --- |
| noise.lm               | <- lm(noise/10 | ~ size      | * type        | * side,    | data = auto.noise) |     |     |
| # Interaction          | plot of        | predictions |               |            |                    |     |     |
| emmip(noise.lm,        | type           | ~ size      | | side)       |            |                    |     |     |
| # Confidence           | intervals      |             |               |            |                    |     |     |
| plot(emmeans(noise.lm, |                | ~ size      | | side*type)) |            |                    |     |     |
cld.emmGrid
Compactletterdisplays
Description
Amethodformultcomp::cld()isprovidedforusersdesiringtoproducecompact-letterdisplays
(CLDs). This method uses the Piepho (2004) algorithm (as implemented in the multcompView
package) to generate a compact letter display of all pairwise comparisons of estimated marginal
means. The function obtains (possibly adjusted) P values for all pairwise comparisons of means,
usingthecontrastfunctionwithmethod="pairwise". WhenaPvalueexceedsalpha,thenthe
twomeanshaveatleastoneletterincommon.
Usage
| ## S3 method | for class       | 'emmGrid'  |                 |         |                    |          |     |
| ------------ | --------------- | ---------- | --------------- | ------- | ------------------ | -------- | --- |
| cld(object,  | details         | = FALSE,   | sort            | = TRUE, | by,                |          |     |
| alpha        | = 0.05, Letters | =          | c("1234567890", |         | LETTERS, letters), |          |     |
| reversed     | = decreasing,   |            | decreasing      | =       | FALSE, signif.sets | = FALSE, |     |
| delta        | = 0, ...)       |            |                 |         |                    |          |     |
| ## S3 method | for class       | 'emm_list' |                 |         |                    |          |     |
| cld(object,  | ..., which      | =          | 1)              |         |                    |          |     |
Arguments
| object | AnobjectofclassemmGrid |     |     |     |     |     |     |
| ------ | ---------------------- | --- | --- | --- | --- | --- | --- |
details Logical value determining whether detailed information on tests of pairwise
comparisonsisdisplayed
sort
LogicalvaluedeterminingwhethertheEMMsaresortedbeforethecomparisons
|     | areproduced. |     | WhenTRUE,theresultsaredisplayedaccordingtoreversed. |     |     |     |     |
| --- | ------------ | --- | --------------------------------------------------- | --- | --- | --- | --- |
by Charactervaluegivingthenameornamesofvariablesbywhichseparatefam-
|     | iliesofcomparisonsaretested. |     |     |     | IfNULL,allmeansarecompared. |     | Ifmissing, |
| --- | ---------------------------- | --- | --- | --- | --------------------------- | --- | ---------- |
theobject’sby.varssetting,ifany,isused.
alpha
Numericvaluegivingthesignificancelevelforthecomparisons

10 cld.emmGrid
Letters Character vector of letters to use in the display. Any strings of length greater
than1areexpandedintoindividualcharacters
reversed,decreasing
Logicalvalue(passedtomultcompView::multcompLetters.) IfTRUE,theor-
der of use of the letters is reversed. Either reversed or decreasing may be
specified,thusprovidingcompatibilitywithbothmultcompView::multcompLetters(...,
reversed,...)andmultcomp::cld(...,decreasing,...). Inaddition,if
bothsortandreversedareTRUE,thesortorderofresultsisreversed.
signif.sets Logical value. If FALSE (and delta=0), a ‘traditional’ compact-letter display
is constructed with groupings representing sets of estimates that are not statis-
ticallydifferent. IfTRUE,thecriteriaarereversedsothattwoestimatessharing
thesamesymboltestassignificantlydifferent. Seealsodelta.
delta Numericvaluepassedtotest.emmGrid.Ifthisispositive,itisusedasanequiv-
alence threshold in the TOST procedure for two-sided equivalence testing. In
theresultingcompactletterdisplay,twoestimatessharethesamegroupinglet-
teronlyiftheyarefoundtobestatisticallyequivalent–thatis,groupingsreflect
actualfindingsofequivalenceratherthanfailuretofindasignificantdifference.
Whendeltaisnonzero,signif.setsisignored.
... Argumentspassedtocontrast(forexample,anadjustmethod)
which Whichelementoftheemm_listobjecttoprocess(Iflengthexceedsone, only
thefirstoneisused)
Value
A summary_emm object showing the estimated marginal means plus an additional column labeled
.group(whensignif.sets=FALSE),.signif.set(whensignif.sets=TRUE),or.equiv.set
(whendelta>0).
Note
Wewarnthatthedefaultdisplayencouragesapoorpracticeininterpretingsignificancetests. Such
CLDs are misleading because they visually group means with comparisons P > alpha as though
theyareequal,wheninfactwehaveonlyfailedtoprovethattheydiffer. Abetteralternativeifone
wantstoshowgroupingsistospecifyanequivalencethresholddelta;thengroupingswillbebased
onactualfindingsofequivalence. Anotherwaytodisplayactualfindingsistosetsignif.sets=
TRUE, so that estimates in the same group are those found to be statistically different. Obviously,
thesedifferentoptionsrequiredifferentinterpretationsoftheresults;theannotationsandthelabel
giventhefinalcolumnhelpguidehowtoassesstheresults.
Asfurtheralternatives,considerpwpp(graphicaldisplayofPvalues)orpwpm(matrixdisplay).
References
Piepho, Hans-Peter (2004) An algorithm for a letter-based representation of all pairwise compar-
isons,JournalofComputationalandGraphicalStatistics,13(2),456-466.

comb_facs 11
Examples
if(requireNamespace("multcomp"))
emm_example("cld-multcomp")
| # Use emm_example("cld-multcomp", |     |                                   |     | list | = TRUE) | # to just | list | the code |     |
| --------------------------------- | --- | --------------------------------- | --- | ---- | ------- | --------- | ---- | -------- | --- |
| comb_facs                         |     | Manipulatefactorsinareferencegrid |     |      |         |           |      |          |     |
Description
These functions manipulate the levels of factors comprising a reference grid by combining factor
levels, splitting a factor’s levels into combinations of newly-defined factors, creating a grouping
factorinwhichfactor(s)levelsarenested,orpermutingtheorderoflevelsofafactor
Usage
| comb_facs(object,      |      | facs,    | newname  | = paste(facs, |            | collapse | = "."), |     |     |
| ---------------------- | ---- | -------- | -------- | ------------- | ---------- | -------- | ------- | --- | --- |
| drop = FALSE,          | ...) |          |          |               |            |          |         |     |     |
| split_fac(object,      |      | fac,     | newfacs, | ...)          |            |          |         |     |     |
| add_grouping(object,   |      | newname, |          | refname,      | newlevs,   | ...)     |         |     |     |
| add_submodels(object,  |      | ...,     | newname  |               | = "model") |          |         |     |     |
| permute_levels(object, |      |          | fac,     | pos)          |            |          |         |     |     |
Arguments
| object | AnobjectofclassemmGrid |     |     |     |     |     |     |     |     |
| ------ | ---------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
facs
|     | Charactervector. |     |     | Thenamesofthefactorstocombine |     |     |     |     |     |
| --- | ---------------- | --- | --- | ----------------------------- | --- | --- | --- | --- | --- |
newname
Characternameofgroupingfactortoadd(differentfromanyexistingfactorin
thegrid)
| drop |           |        |           | TRUE, |               |            |             |          |                    |
| ---- | --------- | ------ | --------- | ----- | ------------- | ---------- | ----------- | -------- | ------------------ |
|      | Logical   | value. |           | If    | any levels    | of the new | factor      | that are | dropped if all oc- |
|      | currences |        | in the    | newly | reconstructed | object     | have weight | zero.    | If FALSE, all      |
|      | levels    | are    | retained. | (This | argument      | is ignored | if there    | is no    | .wgt. column in    |
object@grid.)
| ... | argumentspassedtoothermethods               |     |     |     |     |     |     |     |     |
| --- | ------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
| fac | Thenameofafactorthatispartofthegridinobject |     |     |     |     |     |     |     |     |
newfacs A named list with the names of new factors and their levels. The names must
notalreadyexistintheobject,andtheproductofthelengthsofthelevelsmust
equalthenumberoflevelsoffac.
refname
Charactername(s)ofthereferencefactor(s)

12 comb_facs
newlevs Charactervectororfactorofthesamelengthasthatofthe(combined)levelsfor
refname. Thegroupingfactornewnamewillhavetheuniquevaluesofnewlevs
asitslevels. Theorderoflevelsinnewlevsisthesameastheorderofthelevel
combinationsproducedbyexpand.gridappliedtothelevelsofrefname–that
is,thefirstfactor’slevelschangethefastestandthelastone’svarytheslowest.
pos Integervectorconsistingofsomepermutationofthesequence1:k, wherekis
thenumberoflevelsoffac. Thisdetermineswhichpositioneachleveloffac
willoccupyafterthelevelsarepermuted;thus,ifthelevelsoffacareA,B,C,D,
andpos=c(3,1,2,4),thenthepermutedlevelswillbeB,C,A,D.
Value
AmodifiedobjectofclassemmGrid
Thecomb_facsfunction
comb_facs combines the levels of factors into a single factor in the reference grid (similar to
interaction). Thisnewfactorreplacesthefactorsthatcompriseit.
Additional note: The choice of whether to drop levels or not can make a profound difference. If
the goal is to combine factors for use in joint_tests, we advise against drop=TRUE because
that might change the weights used in deriving marginal means. If combining factors in a nested
structure,droppingunusedcasescanconsiderablyreducethestoragerequired.
Thesplit_facfunction
The levels in newfacs are expanded via expand.grid into combinations of levels, and the factor
facisreplacedbythosefactorcombinations. Unlikeadd_grouping,thiscreatesacrossed,rather
thananestedstructure. Notethattheorderoffactorcombinationsissystematicwiththelevelsof
firstfactorinnewfacsvaryingthefastest;andthosefactorcombinationsareassignedrespectively
tothelevelsoffacasdisplayedinstr(object).
Theadd_groupingfunction
This function adds a grouping factor to an existing reference grid or other emmGrid object, such
that the levels of one or more existing factors (call them the reference factors) are mapped to a
smaller number of levels of the new grouping factor. The reference factors are then nested in a
new grouping factor named newname, and a new nesting structure refname%in%newname. This
facilitatesobtainingmarginalmeansofthegroupingfactor,andcontraststhereof.
Additional notes: By default, the levels of newname will be ordered alphabetically. To dictate a
differentorderingoflevels,supplynewlevsasafactorhavingitslevelsinthedesiredorder.
When refname specifies more than one factor, this can fundamentally (and permanently) change
what is meant by the levels of those individual factors. For instance, in the gwrg example below,
therearetwolevelsofwoolnestedineachprod;andthatimpliesthatwenowregardtheseasfour
differentkindsofwool. Similarly,therearefivedifferenttensions(L,M,Hinprod1,andL,Min
prod2).

comb_facs 13
Theadd_submodelsfunction
Thisfunctionupdatesobjectwithanamedlistofsubmodelsspecifiedin.... Thesearerbinded
togetherandthecorrespondingrowsforeachsubmodelareassignedafactornamednewnamewith
....
levels equal to the names in This facilitates comparing estimates obtained from different
submodels. For this to work, the underlying model object must be of a class supported by the
submodelargumentofupdate.emmGrid.
Thepermute_levelsfunction
Thisfunctionpermutesthelevelsoffac. Thereturnedobjecthasthesamefactors, samebyvari-
ables, but with the levels of fac permuted. The order of the columns in object@grid may be
altered.
NOTE: fac must not be nested in another factor. permute_levels throws an error when fac is
nested.
NOTE: Permuting the levels of a numeric predictor is tricky. For example, if you want to dis-
play the new ordering of levels in emmip(), you must add the arguments style="factor" and
nesting.order=TRUE.
Examples
| mtcars.lm | <- lm(mpg            | ~ factor(vs)+factor(cyl)*factor(gear), |          |           |     |     | data = mtcars) |
| --------- | -------------------- | -------------------------------------- | -------- | --------- | --- | --- | -------------- |
| (v.c.g <- | ref_grid(mtcars.lm)) |                                        |          |           |     |     |                |
| (v.cg <-  | comb_facs(v.c.g,     |                                        | c("cyl", | "gear"))) |     |     |                |
# One use is obtaining a single test for the joint contributions of two factors:
joint_tests(v.c.g)
joint_tests(v.cg)
| # undo the      | 'comb_facs'     |             | operation: |                 |        |             |            |
| --------------- | --------------- | ----------- | ---------- | --------------- | ------ | ----------- | ---------- |
| split_fac(v.cg, |                 | "cyl.gear", | list(cyl   |                 | = c(4, | 6, 8), gear | = 3:5))    |
| IS.glm <-       | glm(count       | ~ spray,    | data       | = InsectSprays, |        | family      | = poisson) |
| IS.emm <-       | emmeans(IS.glm, |             | "spray")   |                 |        |             |            |
IS.new <- split_fac(IS.emm, "spray", list(A = 1:2, B = c("low", "med", "hi")))
str(IS.new)
| fiber.lm  | <- lm(strength     |     | ~ diameter | +         | machine, | data = | fiber) |
| --------- | ------------------ | --- | ---------- | --------- | -------- | ------ | ------ |
| ( frg <-  | ref_grid(fiber.lm) |     | )          |           |          |        |        |
| # Suppose | the machines       |     | are two    | different | brands   |        |        |
brands <- factor(c("FiberPro", "FiberPro", "Acme"), levels = c("FiberPro", "Acme"))
| ( gfrg <-     | add_grouping(frg, |           | "brand", |          | "machine", | brands)       | )   |
| ------------- | ----------------- | --------- | -------- | -------- | ---------- | ------------- | --- |
| emmeans(gfrg, | "machine")        |           |          |          |            |               |     |
| emmeans(gfrg, | "brand")          |           |          |          |            |               |     |
| ### More      | than one          | reference | factor   |          |            |               |     |
| warp.lm       | <- lm(breaks      | ~         | wool *   | tension, | data       | = warpbreaks) |     |

14 contrast
gwrg <- add_grouping(ref_grid(warp.lm),
"prod", c("tension", "wool"), c(2, 1, 1, 1, 2, 1))
# level combinations: LA MA HA LB MB HB
emmeans(gwrg, ~ wool * tension) # some NAs due to impossible combinations
emmeans(gwrg, "prod")
## Using 'add_submodels' to compare adjusted and unadjusted means
fibint.lm <- lm(strength ~ machine * diameter, data = fiber)
fibsub <- add_submodels(emmeans(fibint.lm, "machine"),
full = ~ ., additive = ~ . - machine:diameter, unadj = ~ machine)
emmeans(fibsub, pairwise ~ model | machine, adjust = "none")
# Permuting factor levels...
str(v.c.g)
str(permute_levels(v.c.g, "cyl", c(2,3,1)))
contrast ContrastsandlinearfunctionsofEMMs
Description
These methods provide for follow-up analyses of emmGrid objects: Contrasts, pairwise compar-
isons,tests,andconfidenceintervals. Theymayalsobeusedtocomputearbitrarylinearfunctions
ofpredictionsorEMMs.
Usage
contrast(object, ...)
## S3 method for class 'emmGrid'
contrast(object, method = "eff", interaction = FALSE, by,
offset = NULL, scale = NULL, name = "contrast",
options = get_emm_option("contrast"), type, adjust, simple,
combine = FALSE, ratios = TRUE, parens, enhance.levels = TRUE, wts,
...)
## S3 method for class 'emmGrid'
pairs(x, reverse = FALSE, ...)
## S3 method for class 'emmGrid'
coef(object, ...)
## S3 method for class 'emmGrid'
weights(object, ...)

| contrast |     |     |     |     |     |     |     |     |     | 15  |
| -------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Arguments
| object | AnobjectofclassemmGrid                  |     |     |     |     |     |     |     |     |     |
| ------ | --------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ...    | Additionalargumentspassedtoothermethods |     |     |     |     |     |     |     |     |     |
method Charactervaluegivingtherootnameofacontrastmethod(e.g. "pairwise"–
|     | see emmc-functions).               |              |      | Alternatively, |     | a function                         | of the    | same      | form, | or a named |
| --- | ---------------------------------- | ------------ | ---- | -------------- | --- | ---------------------------------- | --------- | --------- | ----- | ---------- |
|     | list of                            | coefficients | (for | a contrast     | or  | linear                             | function) | that must | each  | conform    |
|     | tothenumberofresultsineachbygroup. |              |      |                |     | Inamulti-factorsituation,thefactor |           |           |       |            |
levelsarecombinedandtreatedlikeasinglefactor.
interaction Character vector, logical value, or list. If this is specified, method is ignored.
Seethe“Interactioncontrasts”sectionbelowfordetails.
by
|     | Character | names | of variable(s) |     | to be | used for | “by” groups. |     | The | contrasts or |
| --- | --------- | ----- | -------------- | --- | ----- | -------- | ------------ | --- | --- | ------------ |
jointtestswillbeevaluatedseparatelyforeachcombinationofthesevariables.
|     | Ifobjectwascreatedwithbygroups,thoseareusedunlessoverridden. |     |     |     |     |     |     |     |     | Useby |
| --- | ------------------------------------------------------------ | --- | --- | --- | --- | --- | --- | --- | --- | ----- |
=NULLtousenobygroupsatall.
| offset,scale |           |               |        |            |          |            | by        |     | scale       |            |
| ------------ | --------- | ------------- | ------ | ---------- | -------- | ---------- | --------- | --- | ----------- | ---------- |
|              | Numeric   | vectors       | of the | same       | length   | as each    | group.    | The |             | values, if |
|              | supplied, | multiply      | their  | respective | linear   | estimates, | and       | any | offset      | values are |
|              | added.    | Scalar values | are    | also       | allowed. | (These     | arguments |     | are ignored | when       |
interactionisspecified.)
name Character name to use to override the default label for contrasts used in table
headingsorsubsequentcontrastsofthereturnedobject.
options Ifnon-NULL,anamedlistofargumentstopasstoupdate.emmGrid,justafter
theobjectisconstructed.
type Character: predictiontype(e.g.,"response")–addedtooptions
| adjust |     | adjustmentmethod(e.g.,"bonferroni")–addedtooptions |     |     |     |     |     |     |     |     |
| ------ | --- | -------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
Character:
| simple |                        |     |     | Specifythefactor(s)notinby,oralistthereof. |     |     |     |     |     |        |
| ------ | ---------------------- | --- | --- | ------------------------------------------ | --- | --- | --- | --- | --- | ------ |
|        | Charactervectororlist: |     |     |                                            |     |     |     |     |     | Seethe |
sectionbelowonsimplecontrasts.
combine Logical value that determines what is returned when simple is a list. See the
sectiononsimplecontrasts.
ratios
|     | Logical | value determining |     | how | log | and logit | transforms | are | handled. | These |
| --- | ------- | ----------------- | --- | --- | --- | --------- | ---------- | --- | -------- | ----- |
transformationsareexceptionalcasesinthatthereisavalidwaytoback-transform
contrasts:differencesoflogsarelogsofratios,anddifferencesoflogitsareodds
|     | ratios. If               | ratios=TRUE      |        | and                                      | summarized       | with     | type="response", |      |            | contrast   |
| --- | ------------------------ | ---------------- | ------ | ---------------------------------------- | ---------------- | -------- | ---------------- | ---- | ---------- | ---------- |
|     | results are              | back-transformed |        |                                          | to ratios        | whenever | we have          | true | contrasts  | (coef-     |
|     | ficients sum             | to               | zero). | For other                                | transformations, |          | there            | is   | no natural | way to     |
|     | back-transformcontrasts, |                  |        | soevenwhensummarizedwithtype="response", |                  |          |                  |      |            |            |
|     | contrasts                | are computed     |        | and displayed                            |                  | on the   | linear-predictor |      | scale.     | Similarly, |
ifratios=FALSE,logandlogittransformsaretreatedinthesamewayasany
othertransformation.
| parens |           | NULL. |      |           |        |     |            |        |       |            |
| ------ | --------- | ----- | ---- | --------- | ------ | --- | ---------- | ------ | ----- | ---------- |
|        | character | or    | If a | character | value, | the | labels for | levels | being | contrasted |
areparenthesizediftheymatchtheregularexpressioninparens[1](viagrep).
Thedefaultisemm_option("parens").Optionally,parensmaycontainsecond
andthirdelementsspecifyingwhattouseforleftandrightparentheses(default
|     | "(" and | ")"). Specify |     | parens=NULL |     | or parens="a^" |     | (which | won’t | match |
| --- | ------- | ------------- | --- | ----------- | --- | -------------- | --- | ------ | ----- | ----- |
anything)todisableallparenthesization.

16 contrast
enhance.levels character or logical. If character, the levels of the named factors that are con-
trasted are enhanced by appending the name of the factor; e.g., if a factor
named "trt" has levels A and B, a trt comparison is labeled trtA-trtB. If
enhance.levelsislogical,thenifTRUE(thedefault),onlyfactorswithnumeric
levelsareenhanced;andofcourseifFALSE,nolevelsareenhanced. Thelevels
ofbyvariablesarenotenhanced, andanynamesoffactorsthatdon’texistare
silentlyignored. Toenhancethelabelsbeyondwhatisdonehere,changethem
directlyvialevels<-.
wts The wts argument for some contrast methods. You should omit this argument
unless you want unequal wts. Otherwise we recommend specifying wts=NA
whichinstructsthatwtsbeobtainedfromobject,separatelyforeachbygroup.
If numerical wts are specified, they must conform to the number of levels in
eachbygroup,andthosesameweightsareusedineachgroup.
x AnemmGridobject
reverse Logicalvalue-determineswhethertouse"pairwise"(ifTRUE)or"revpairwise"
(ifFALSE).
Value
contrastandpairsreturnanobjectofclassemmGrid. Itsgridwillcorrespondtothelevelsofthe
contrastsandanybyvariables. Theexceptionisthatanemm_listobjectisreturnedifsimpleisa
listandcombineisFALSE.
coefreturnsadata.framecontainingthe"parent"object’sgrid,alongwithcolumnsnamedc.1,
c.2,...containingthecontrastcoefficientsusedtoproducethelinearfunctionsembodiedinthe
object. coef() only returns coefficients if object is the result of a call to contrast(), and the
parent object is the object that was handed to contrast. This is most useful for understanding
interactioncontrasts.
weights returns the weights stored for each row of object, or a vector of 1s if no weights are
saved.
Pairsmethod
Thecallpairs(object)isequivalenttocontrast(object,method="pairwise");andpairs(object,
reverse=TRUE)isthesameascontrast(object,method="revpairwise").
Interactioncontrasts
Wheninteractionisspecified,interactioncontrastsarecomputed. Specificallycontrastsaregen-
erated for each factor separately, one at a time; and these contrasts are applied to the object (the
firsttimearound)ortothepreviousresult(subsequently). (Anyfactorsspecifiedinbyareskipped.)
Thefinalresultcomprisescontrastsofcontrasts,or,equivalently,productsofcontrastsforthefac-
tors involved. Any named elements of interaction are assigned to contrast methods; others are
assignedinorderofappearanceinobject@levels. ThecontrastfactorsintheresultingemmGrid
objectareorderedthesameasininteraction.
interaction may be a character vector or list of valid contrast methods (as documented for the
methodargument). Ifthevectororlistisshorterthanthenumberneeded, itisrecycled. Alterna-
tively,iftheuserspecifiescontrast=TRUE,thecontrastspecifiedinmethodisusedforallfactors
involved.

contrast 17
Simplecontrasts
simpleisessentiallythecomplementofby: Whensimpleisacharactervector,byissettoallthe
factorsinthegridexceptthoseinsimple.Ifsimpleisalist,eachelementisusedinturnassimple,
andassembledinan"emm_list". Togenerateallsimplemaineffects,usesimple="each"(this
worksunlessthereactuallyisafactornamed"each"). Notethatanon-missingsimplewillcause
bytobeignored.
Ordinarily,whensimpleisalistor"each",thereturnvalueisanemm_listobjectwitheachentry
incorrespondencewiththeentriesofsimple. However,withcombine=TRUE,theelementsareall
combined into one family of contrasts in a single emmGrid object using rbind.emmGrid.. In that
case,theadjustargumentsetstheadjustmentmethodforthecombinedsetofcontrasts.
Note
Whenobjecthasanestingstructure(thiscanbeseenviastr(object)),thenanygroupingfactors
involvedareforcedintoserviceasbyvariables, andthecontrastsarethuscomputedseparatelyin
eachnest. ThisinturnmayleadtoanirregulargridinthereturnedemmGridobject,whichmaynot
bevalidforsubsequentemmeanscalls.
Examples
warp.lm <- lm(breaks ~ wool*tension, data = warpbreaks)
(warp.emm <- emmeans(warp.lm, ~ tension | wool))
contrast(warp.emm, "poly") # inherits 'by = "wool"' from warp.emm
### Custom contrast coefs (we already have wool as 'by' thus 3 means to contrast)
contrast(warp.emm, list(mid.vs.ends = c(-1,2,-1)/2, lo.vs.hi = c(1,0,-1)))
pairs(warp.emm)
# Effects (dev from mean) of the 6 factor combs, with enhanced levels:
contrast(warp.emm, "eff", by = NULL,
enhance.levels = c("wool", "tension"))
pairs(warp.emm, simple = "wool") # same as pairs(warp.emm, by = "tension")
# Do all "simple" comparisons, combined into one family
pairs(warp.emm, simple = "each", combine = TRUE)
## Not run:
## Note that the following are NOT the same:
contrast(warp.emm, simple = c("wool", "tension"))
contrast(warp.emm, simple = list("wool", "tension"))
## The first generates contrasts for combinations of wool and tension
## (same as by = NULL)
## The second generates contrasts for wool by tension, and for
## tension by wool, respectively.
## End(Not run)

18 contrast-methods
# An interaction contrast for tension:wool
tw.emm <- contrast(warp.emm, interaction = c(tension = "poly", wool = "consec"),
by = NULL)
tw.emm # see the estimates
coef(tw.emm) # see the contrast coefficients
# Use of scale and offset
# an unusual use of the famous stack-loss data...
mod <- lm(Water.Temp ~ poly(stack.loss, degree = 2), data = stackloss)
(emm <- emmeans(mod, "stack.loss", at = list(stack.loss = 10 * (1:4))))
# Convert results from Celsius to Fahrenheit:
confint(contrast(emm, "identity", scale = 9/5, offset = 32))
contrast-methods Contrastfamilies
Description
Functionswithanextensionof.emmcprovidefornamedcontrastfamilies.Oneofthestandardones
documentedheremaybeused,ortheusermaywritesuchafunction.
Usage
pairwise.emmc(levs, exclude = integer(0), include, ...)
revpairwise.emmc(levs, exclude = integer(0), include, ...)
tukey.emmc(levs, reverse = FALSE, ...)
poly.emmc(levs, max.degree = min(6, k - 1), ...)
opoly.emmc(levs, max.degree = min(6, k - 1), scores, exclude = integer(0),
include, ...)
trt.vs.ctrl.emmc(levs, ref = 1, reverse = FALSE, exclude = integer(0),
include, ...)
trt.vs.ctrl1.emmc(levs, ref = 1, ...)
trt.vs.ctrlk.emmc(levs, ref = length(levs), ...)
dunnett.emmc(levs, ref = 1, ...)
eff.emmc(levs, exclude = integer(0), include, wts = rep(1, length(levs)),
...)
del.eff.emmc(levs, exclude = integer(0), include, wts = rep(1,

| contrast-methods |      |     |     |     |     |     | 19  |
| ---------------- | ---- | --- | --- | --- | --- | --- | --- |
| length(levs)),   | ...) |     |     |     |     |     |     |
consec.emmc(levs, reverse = FALSE, exclude = integer(0), include, ...)
mean_chg.emmc(levs, reverse = FALSE, exclude = integer(0), include, ...)
| helmert.emmc(levs, | exclude | = integer(0), | include, | ...) |     |     |     |
| ------------------ | ------- | ------------- | -------- | ---- | --- | --- | --- |
| nrmlz.emmc(levs,   | family, | ...)          |          |      |     |     |     |
wtcon.emmc(levs, wts = rep(1, length(levs)), cmtype = "GrandMean", ...)
| identity.emmc(levs, | exclude | = integer(0), | include, | ...) |     |     |     |
| ------------------- | ------- | ------------- | -------- | ---- | --- | --- | --- |
Arguments
levs
Vectoroffactorlevels
exclude integervectorofindices,orcharactervectoroflevelstoexcludefromconsider-
|     | ation. Theselevelswillreceiveweight0inallcontrasts. |     |     |     |     | Characterlevelsmust |     |
| --- | --------------------------------------------------- | --- | --- | --- | --- | ------------------- | --- |
exactlymatchelementsoflevs.
include integer or character vector of levels to include (the complement of exclude).
Anerrorwillresultiftheuserspecifiesbothexcludeandinclude.
...
Additionalarguments,passedtorelatedmethodsasappropriate
reverse
Logicalvaluetodeterminethedirectionofcomparisons
max.degree
Integerspecifyingthemaximumdegreeofpolynomialcontrasts
scores Set of values of length length(levs) over which orthogonal polynomials are
|     | computed. | The default | scores are the | consecutive | integers | seq_along(levs). |     |
| --- | --------- | ----------- | -------------- | ----------- | -------- | ---------------- | --- |
(Ifexcludeorincludeareused,
thedefaultscoresaresubsettedaccordingly;
|     | and if scores | is specified, | its length | must be | the same as | that of the | subsetted |
| --- | ------------- | ------------- | ---------- | ------- | ----------- | ----------- | --------- |
levs).
ref
Integer(s)orcharacter(s)specifyingwhichlevel(s)touseasthereference.Char-
actervaluesmustexactlymatchelementsoflevs(includinganyenhancements
–seeexamples)
| wts |                  |                | eff.emmc   | del.eff.emmc |                |            |            |
| --- | ---------------- | -------------- | ---------- | ------------ | -------------- | ---------- | ---------- |
|     | Optional weights | to use         | with       | and          |                | contrasts. | These      |
|     | default to       | equal weights. | If exclude | or include   | are specified, |            | wts may be |
eitherthesamelengthaslevsorthelengthoftheincludedlevels.
Intheformer
|     | case,weightsforanyexcludedlevelsaresettozero. |     |     |     | wtshasnoimpactonthe |     |     |
| --- | --------------------------------------------- | --- | --- | --- | ------------------- | --- | --- |
resultsunlessthereareatleastthreelevelsincludedinthecontrast.
family
nameofcontrastfamilytouse
| cmtype | thetypeargumentpassedtocontrMat |     |     |     |     |     |     |
| ------ | ------------------------------- | --- | --- | --- | --- | --- | --- |
Details
Each standard contrast family has a default multiple-testing adjustment as noted below. These
adjustmentsareoftenonlyapproximate;foramoreexactingadjustment,usetheinterfacesprovided
toglhtinthemultcomppackage.

20 contrast-methods
pairwise.emmc,revpairwise.emmc,andtukey.emmcgeneratecontrastsforallpairwisecompar-
isons among estimated marginal means at the levels in levs. The distinction is in which direction
theyaresubtracted. ForfactorlevelsA,B,C,D,pairwise.emmcgeneratesthecomparisonsA-B,
A-C,A-D,B-C,B-D,andC-D,whereasrevpairwise.emmcgeneratesB-A,C-A,C-B,D-A,D-B,
andD-C.tukey.emmcinvokespairwise.emmcorrevpairwise.emmcdependingonreverse.The
defaultmultiplicityadjustmentmethodis"tukey", whichisonlyapproximatewhenthestandard
errorsdiffer.
poly.emmc and opoly.emmc generate orthogonal polynomial contrasts. poly.emmc uses equally-
spacedfactorlevels;coefficientsarederivedfromthepolyfunction,butanadhocalgorithmisused
toscalethemtointegercoefficientsthatare(usually)thesameasinpublishedtablesoforthogonal
polynomial contrasts. On the other hand, opoly.emmc’s coefficients are always normalized (sum
of squares equals 1), but allows the user to choose alternate reference points in scores, as in the
contr.polyfunction. Inbothcases,thedefaultmultiplicityadjustmentmethodis"none".
trt.vs.ctrl.emmc and its relatives generate contrasts for comparing one level (or the average
over specified levels) with each of the other levels. The argument ref should be the index(es)
(notthelabels)ofthereferencelevel(s). trt.vs.ctrl1.emmcisthesameastrt.vs.ctrl.emmc
withareferencevalueof1,andtrt.vs.ctrlk.emmcisthesameastrt.vs.ctrlwithareference
value of length(levs). dunnett.emmc is the same as trt.vs.ctrl. The default multiplicity
adjustmentmethodis"dunnettx",acloseapproximationtotheDunnettadjustment. Noteinallof
thesefunctions,itisillegaltohaveanyoverlapbetweenthereflevelsandtheexcludelevels. If
anyisfound,anerroristhrown.
consec.emmcandmean_chg.emmcareusefulforcontrastingtreatmentsthatoccurinsequence. For
afactorwithlevelsA,B,C,D,consec.emmcgeneratesthecomparisonsB-A,C-B,andD-C,while
mean_chg.emmcgeneratesthecontrasts(B+C+D)/3-A,(C+D)/2-(A+B)/2,andD-(A+B+C)/3.
Withreverse=TRUE,thesedifferencesgointheoppositedirection.
eff.emmcanddel.eff.emmcgeneratecontraststhatcompareeachlevelwiththeaverageoverall
levels (in eff.emmc) or over all other levels (in del.eff.emmc). These differ only in how they
are scaled. For a set of k EMMs, del.eff.emmc gives weight 1 to one EMM and weight -1/(k-
1)totheothers, whileeff.emmcgivesweights(k-1)/kand-1/krespectively, asinsubtractingthe
overall EMM from each EMM. The default multiplicity adjustment method is "fdr". This is a
Bonferroni-basedmethodandisslightlyconservative;seep.adjust.
nrmlz.emmc is a wrapper that can be used with any other .emmc function that will normalize the
contrast coefficients so that the sum of its squares equals 1. Just provide the root name of the
functioninfamily,alongwithanyotherargumentstopasstoit.
wtcon.emmc generates weighted contrasts based on the function contrMat function in the mult-
comppackage,usingtheprovidedtypeasdocumentedthere. Iftheuserprovideswts,theyhave
toconformtothelengthoflevs;however,ifwtsisnotspecified,contrastwillfill-inwhatisre-
quired,andusuallythisissafer(especiallywhenby!=NULLwhichusuallymeansthattheweights
aredifferentineachbygroup).
identity.emmcsimplyreturnstheidentitymatrix(asadataframe),minusanycolumnsspecified
inexclude. Itispotentiallyusefulincaseswhereacontrastfunctionmustbespecified,butnoneis
desired.
Value
A data.frame, each column containing contrast coefficients for levs. The "desc" attribute is used
tolabeltheresultsinemmeans,andthe"adjust"attributegivesthedefaultadjustmentmethodfor

contrast-methods 21
multiplicity.
Note
Cautionisneededincaseswheretheuseralterstheorderingofresults(e.g.,usingthethe"[...]"
operator),becausethecontrastsgenerateddependontheorderofthelevelsprovided. Forexample,
suppose trt.vs.ctrl1 contrasts are applied to two by groups with levels ordered (Ctrl, T1, T2)
and(T1,T2,Ctrl)respectively,thenthecontrastsgeneratedwillbefor(T1-Ctrl,T2-Ctrl)inthe
firstgroupand(T2-T1,Ctrl-T1)inthesecondgroup,becausethefirstlevelineachgroupisused
asthereferencelevel.
Examples
warp.lm <- lm(breaks ~ wool*tension, data = warpbreaks)
warp.emm <- emmeans(warp.lm, ~ tension | wool)
contrast(warp.emm, "poly")
contrast(warp.emm, "trt.vs.ctrl", ref = "M")
## Not run:
## Same when enhanced labeling is used:
contrast(warp.emm, "trt.vs.ctrl",
enhance.levels = "tension", ref = "tensionM")
## End(Not run)
# Comparisons with grand mean
contrast(warp.emm, "eff")
# Comparisons with a weighted grand mean
contrast(warp.emm, "eff", wts = c(2, 5, 3))
# Compare only low and high tensions
# Note pairs(emm, ...) calls contrast(emm, "pairwise", ...)
pairs(warp.emm, exclude = 2)
# (same results using exclude = "M" or include = c("L","H") or include = c(1,3))
# Same contrasts as above but with normalized contrast coefficients
contrast(warp.emm, "nrmlz", family = "pairwise", include = c(1, 3))
### Setting up a custom contrast function
revhelmert.emmc <- function(levs, ...) {
M <- as.data.frame(contr.helmert(levs)[rev(seq_along(levs)), ])
names(M) <- paste(rev(levs)[-1],"vs later")
attr(M, "desc") <- "reverse Helmert contrasts"
M
}
contrast(warp.emm, "revhelmert")
## Not run:
# See what is used for polynomial contrasts with 6 levels
emmeans:::poly.emmc(1:6)
## End(Not run)

22 eff_size
eff_size CalculateCoheneffectsizesandconfidenceboundsthereof
Description
Standardized effect sizes are typically calculated using pairwise differences of estimates, divided
bytheSDofthepopulationprovidingthecontextforthoseeffects. Thisfunctioncalculateseffect
sizesfromanemmGridobject,andconfidenceintervalsforthem,accountingforuncertaintyinboth
theestimatedeffectsandthepopulationSD.
Usage
eff_size(object, sigma, edf, method = "pairwise", ...)
Arguments
object anemmGridobject,typicallyonedefiningtheEMMstobecontrasted.Ifinstead,
class(object)=="emm_list",suchasisproducedbyemmeans(model,pairwise
~treatment), a message is displayed; the contrasts already therein are used;
andmethodisreplacedby"identity".
sigma numericscalar,valueofthepopulationSD.
edf numeric scalar that specifies the equivalent degrees of freedom for the sigma.
Thisisawayofspecifyingtheuncertaintyinsigma, inthatweregardoures-
timate of sigma^2 as being proportional to a chi-square random variable with
edfdegreesoffreedom. (edfshouldnotbeconfusedwiththedfargumentthat
maybepassedvia...tospecifythedegreesoffreedomtouseintstatisticsand
confidenceintervals.)
method thecontrastmethodtousetodefinetheeffects. Thisispassedtocontrastafter
theelementsofobjectarescaled.
... Additionalargumentspassedtocontrast
Details
Anybyvariablesspecifiedinobjectwillremaininforceinthereturnedeffects,unlessoverridden
intheoptionalarguments.
Formodelshavingasinglerandomeffect,suchasthosefittedusinglm;inthatcase,thestats::sigma
andstats::df.residualfunctionsmaybeusefulforspecifyingsigmaandedf. Formodelswith
morethanonerandomeffect,sigmamaybebasedonsomecombinationoftherandom-effectvari-
ances.
Specifyingedfcanberatherunintuitivebutisalsorelativelyuncritical; butthesmallerthevalue,
thewidertheconfidenceintervalsforeffectsize. Thevalueofsqrt(2/edf)canbeinterpretedas
therelativeaccuracyofsigma;forexample,withedf=50, (cid:112) (2/50)=0.2,meaningthatsigmais
accuratetoplusorminus20percent. Noteinanexamplebelow,wetriedtwodifferentedfvalues
askindofabracketing/sensitivity-analysisstrategy. AvalueofInfisallowable,inwhichcaseyou
areassumingthatsigmaisknownexactly. Obviously,thisnarrowstheconfidenceintervalsforthe
effectsizes–unrealisticallyifinfactsigmaisunknown.

eff_size 23
Value
anemmGridobjectcontainingtheeffectsizes
Computation
Thisfunctionusescallstoregridtoputtheestimatedmarginalmeans(EMMs)onthelogscale.
Then an extra element is added to this grid for the log of sigma and its standard error (where
sigma contrast
we assume that is uncorrelated with the log EMMs). Then a call to subtracts
log{sigma}fromeachofthelogEMMs,yieldingvaluesoflog(EMM/sigma). Finally,theresults
arere-griddedbacktotheoriginalscaleandthedesiredcontrastsarecomputedusingmethod. In
thelog-scalingpart,weactuallyrescaletheabsolutevaluesandkeeptrackofthesigns.
Note
Theeffectsarealwayscomputedonthescaleofthelinear-predictor;anyresponsetransformation
orlinkfunctioniscompletelyignored. Ifyouwishtobasetheeffectsizesontheresponsescale,it
isnotenoughtoreplaceobjectwithregrid(object),becausethisback-transformationchanges
theSDrequiredtocomputeeffectsizes.
Paireddata: Becarefulwithpaired-datasituations,whereCohen’sdistypicallyreferencedtothe
SDofthepaireddifferencesratherthantheresidualSD.Youmayneedtoenlargesigmabyafactor
ofsqrt(2)toobtaincomparableresultswithothersoftware.
Disclaimer: There is substantial disagreement among practitioners on what is the appropriate
sigma
to use in computing effect sizes; or, indeed, whether any effect-size measure is appropri-
ate for some situations. The user is completely responsible for specifying appropriate parameters
(orforfailingtodoso).
Coheneffectsizesdonotevenexistforgeneralizedlinearmodelsorothermodelslackinganaddi-
tiveresidualerrorterm.
Theexampleshereillustrateasoberingmessagethateffectsizesareoftennotnearlyasaccurateas
youmaythink.
Examples
| fiber.lm                 | <- lm(strength | ~ diameter         | + machine, data              | = fiber) |
| ------------------------ | -------------- | ------------------ | ---------------------------- | -------- |
| emm <- emmeans(fiber.lm, |                | "machine")         |                              |          |
| eff_size(emm,            | sigma          | = sigma(fiber.lm), | edf = df.residual(fiber.lm)) |          |
# or equivalently:
eff_size(pairs(emm), sigma(fiber.lm), df.residual(fiber.lm), method = "identity")
| ### Mixed          | model example:  |           |                  |     |
| ------------------ | --------------- | --------- | ---------------- | --- |
| if (require(nlme)) | withAutoprint({ |           |                  |     |
| Oats.lme           | <- lme(yield    | ~ Variety | + factor(nitro), |     |
|                    | random          | = ~ 1 |   | Block / Variety, |     |
|                    | data            | = Oats)   |                  |     |
| # Combine          | variance        | estimates |                  |     |
VarCorr(Oats.lme)
| (totSD | <- sqrt(214.4724 | + 109.6931 | + 162.5590)) |     |
| ------ | ---------------- | ---------- | ------------ | --- |

| 24                        |                          |            |           |         |               |     | emm |
| ------------------------- | ------------------------ | ---------- | --------- | ------- | ------------- | --- | --- |
| # I figure                | edf is somewhere         | between    | 5 (Blocks | df) and | 51 (Resid df) |     |     |
| emmV <- emmeans(Oats.lme, |                          | ~ Variety) |           |         |               |     |     |
| eff_size(emmV,            | sigma = totSD,           | edf        | = 5)      |         |               |     |     |
| eff_size(emmV,            | sigma = totSD,           | edf        | = 51)     |         |               |     |     |
| }, spaced = TRUE)         |                          |            |           |         |               |     |     |
| emm                       | Supportformultcomp::glht |            |           |         |               |     |     |
Description
These functions and methods provide an interface between emmeans and the multcomp::glht
functionforsimultaneousinferenceprovidedbythemultcomppackage.
Usage
emm(...)
| as.glht(object, | ...)      |           |     |     |     |     |     |
| --------------- | --------- | --------- | --- | --- | --- | --- | --- |
| ## S3 method    | for class | 'emmGrid' |     |     |     |     |     |
| as.glht(object, | ...)      |           |     |     |     |     |     |
Arguments
| ... | emm,     | specs,     | by, contr    |            |           |            |           |
| --- | -------- | ---------- | ------------ | ---------- | --------- | ---------- | --------- |
|     | In the   |            | and          | arguments  | you would | normally   | supply to |
|     | emmeans. | Only specs | is required. | Otherwise, | arguments | are passed | to other  |
Youmayalsoincludeawhichargument;seeDetails.
methods.
| object | AnobjectofclassemmGridoremm_list |     |     |     |     |     |     |
| ------ | -------------------------------- | --- | --- | --- | --- | --- | --- |
Value
emmreturnsanobjectofanintermediateclassforwhichthereisamultcomp::glhtmethod.
| as.glht |     | glht | glht_list |     |     | object |     |
| ------- | --- | ---- | --------- | --- | --- | ------ | --- |
returns an object of class or according to whether is of class
| emmGridoremm_list. | SeeDetailsbelowformoreonglht_lists. |     |     |     |     |     |     |
| ------------------ | ----------------------------------- | --- | --- | --- | --- | --- | --- |
Detailsforemm
emmismeanttobecalledonlyfrom"glht"asitssecond(linfct)argument. Itworkssimilarlyto
multcomp::mcp,exceptwithspecs(andoptionallybyandcontrarguments)providedasinacall
toemmeans.
Ifthespecificationsin...wouldresultinalist(i.e.,anemm_listobject),thenbydefault,onlythe
last element of that list is passed to glht. However, if ... contains a which argument consisting
of integer values, the list elements with those indexes are selected and combined and passed on
to glht. No checking is done on whether the indexes are valid, and the keyword which must be
spelled-out.

| emmeans |     |     |     |     |     | 25  |
| ------- | --- | --- | --- | --- | --- | --- |
Detailsforas.glht
Whennobyvariableisinforce, weobtainaglhtobject; otherwiseitisaglht_list.
Thelatter
is defined in emmeans, not multcomp, and is simply a list of glht objects. Appropriate con-
veniencemethodscoef,confint,plot,summary,andvcovareprovided,whichsimplyapplythe
correspondingglhtmethodstoeachmember.
Note
The multivariate-t routines used by glht require that all estimates in the family have the same
integerdegreesoffreedom. Incaseswherethatisnottrue,amessageisdisplayedthatshowswhat
dfisused. Theusermayoverridethisviathedfargument.
Examples
| if(require(multcomp, | quietly | = TRUE)) |     |     |     |     |
| -------------------- | ------- | -------- | --- | --- | --- | --- |
emm_example("glht-multcomp")
| # Use emm_example("glht-multcomp", |                                            |     | list = TRUE) # to | see just the | code |     |
| ---------------------------------- | ------------------------------------------ | --- | ----------------- | ------------ | ---- | --- |
| emmeans                            | Estimatedmarginalmeans(Least-squaresmeans) |     |                   |              |      |     |
Description
Computeestimatedmarginalmeans(EMMs)forspecifiedfactorsorfactorcombinationsinalinear
model; and optionally, comparisons or contrasts among them. EMMs are also known as least-
squaresmeans.
Usage
emmeans(object, specs, by = NULL, fac.reduce = function(coefs) apply(coefs,
2, mean), contr, options = get_emm_option("emmeans"), weights, offset, ...,
tran)
Arguments
| object |                             | emmGrid; |                                         |             |                    |     |
| ------ | --------------------------- | -------- | --------------------------------------- | ----------- | ------------------ | --- |
|        | An object                   | of class | or a fitted model                       | object that | is supported, such | as  |
|        | theresultofacalltolmorlmer. |          | Manyfitted-modelobjectsaresupported;see |             |                    |     |
vignette("models","emmeans")fordetails.
specs AcharactervectorspecifyingthenamesofthepredictorsoverwhichEMMs
|     | aredesired. | specsmayalsobeaformulaoralist(optionallynamed)ofvalid |     |     |     |     |
| --- | ----------- | ----------------------------------------------------- | --- | --- | --- | --- |
specs.
|     | UseofformulasisdescribedintheOverviewsectionbelow. |     |     |     | Specifying |     |
| --- | -------------------------------------------------- | --- | --- | --- | ---------- | --- |
.astheonlyfactornamecreatesalistofspecificationsforallmodelterms.
Note: Werecommendagainstusingtwo-sidedformulas;seethenotebelowfor
contr.
by
Acharactervectorspecifyingthenamesofpredictorstoconditionon.

26 emmeans
fac.reduce Afunctionthatcombinestherowsofamatrixintoasinglevector. Thisimple-
ments the “marginal averaging” aspect of EMMs. The default is the mean of
therows. Typicallyifitisoverridden,itwouldbesomekindofweightedmean
of the rows. If fac.reduce is nonlinear, bizarre results are likely, and EMMs
will not be interpretable. NOTE: If the weights argument is non-missing,
fac.reduceisignored.
contr A character value or list specifying contrasts to be added. See contrast.
Note: contr is ignored when specs is a formula. Note 2:: We recommend
against using this argument; obtaining means and obtaining contrasts are two
differentthings,anditisbesttodotheminseparatesteps,usingthecontrast
functionforthecontrasts.
options Ifnon-NULL,anamedlistofargumentstopasstoupdate.emmGrid,justafter
theobjectisconstructed.(Optionsmayalsobeincludedin...;seethe‘options’
sectionbelow.)
weights Character value, numeric vector, or numeric matrix specifying weights to use
in averaging predictions. See “Weights” section below. Also, if object is not
already a reference grid, weights (if it is character) is passed to ref_grid as
wt.nuis in case nuisance factors are specified. We can override this by spec-
ifying wt.nuis explicitly. This more-or-less makes the weighting of nuisance
factorsconsistentwiththatofprimaryfactors.
offset Numeric vector or scalar. If specified, this adds an offset to the predictions,
or overrides any offset in the model or its reference grid. If a vector of length
differing from the number of rows in the result, it is subsetted or cyclically
recycled.
... Whenobjectisnotalreadya"emmGrid"object,theseargumentsarepassedto
ref_grid. Common examples are at, cov.reduce, data, type, regrid, df,
nesting, and vcov.. Model-type-specific options (see vignette("models",
"emmeans")), commonly mode, may be used here as well. In addition, if the
modelformulacontainsreferencestovariablesthatarenotpredictors,youmust
provide a params argument with a list of their names. These arguments may
alsobeusedinlieuofoptions. Seethe‘Options’sectionbelow.
tran Placeholdertopreventitfrombeingincludedin.... Ifnon-missing,itisadded
to‘options‘. Seethe‘Options’section.
Details
Users should also consult the documentation for ref_grid, because many important options for
EMMsareimplementedthere,viathe...argument.
Value
Whenspecsisacharactervectororone-sidedformula, anobjectofclass"emmGrid". Anum-
berofmethodsareprovidedforfurtheranalysis,includingsummary.emmGrid,confint.emmGrid,
test.emmGrid, contrast.emmGrid, and pairs.emmGrid. When specs is a list or a formula
havingaleft-handside,thereturnvalueisanemm_listobject,whichissimplyalistofemmGrid
objects.

emmeans 27
Overview
EstimatedmarginalmeansorEMMs(sometimescalledleast-squaresmeans)arepredictionsfrom
alinearmodeloverareferencegrid;ormarginalaveragesthereof. Theref_gridfunctionidenti-
fies/createsthereferencegriduponwhichemmeansisbased.
For those who prefer the terms “least-squares means” or “predicted marginal means”, functions
lsmeansandpmmeansareprovidedaswrappers. Seewrappers.
Ifspecsisaformula,itshouldbeoftheform~specs,~specs|by,contr~specs,orcontr~
specs|by. Theformulaisparsedandthevariablesthereinareusedastheargumentsspecs,by,
andcontrasindicated. Theleft-handsideisoptional(andwedon’trecommendit),butifspecified
itshouldbethenameofacontrastfamily(e.g.,pairwise). Operatorslike*or:areneededinthe
formulatodelineatenames,butotherwiseareignored.
Wenowalsoallowusing.inspecs. Ifthisisdone,werunjoint_testsonthesidetodetermine
allrelevantmodelterms, thenreplace specswithacorrespondinglistofspecifications. Thisisa
convenience,butitcancreateasizeableemm_listobjectanditiscodedratherinefficiently. While
itispermissibletoincludecontrastsviaacontrargumentorformulaleft-hand-side,werecommend
instead doing this in a follow-up test with contrast.emm_list. Caution: In models with nested
fixed effects, using . creates results where nested factors interact with nesting factors; in those
cases,anycontrastsyouspecifywillgoacrossnests,whichislikelynotwhatisdesired.
In the special case where the mean (or weighted mean) of all the predictions is desired, specify
specsas~1or"1".
A number of standard contrast families are provided. They can be identified as functions having
namesendingin.emmc–seethedocumentationforemmc-functionsfordetails–includinghow
towriteyourown.emmcfunctionforcustomcontrasts.
Weights
Ifweightsisavector,itslengthmustequalthenumberofpredictionstobeaveragedtoobtaineach
EMM.Ifamatrix,eachrowofthematrixisusedinturn,wrappingbacktothefirstrowasneeded.
When in doubt about what is being averaged (or how many), first call emmeans with weights=
"show.levels".
Ifweightsisastring,itshouldpartiallymatchoneofthefollowing:
"equal" Useanequallyweightedaverage.
"proportional" Weightinproportiontothefrequencies(intheoriginaldata)ofthefactorcom-
binationsthatareaveragedover.
"outer" Weightinproportiontoeachindividualfactor’smarginalfrequencies. Thus,theweights
foracombinationoffactorsaretheouterproductoftheone-factormargins
"cells" Weightaccordingtothefrequenciesofthecellsbeingaveraged.
"flat" Giveequalweighttoallcellswithdata,andignoreemptycells.
"show.levels" Thisisaconveniencefeatureforunderstandingwhatisbeingaveragedover. In-
steadofatableofEMMs,thiscausesthefunctiontoreturnatableshowingthelevelsthatare
averagedover,intheorderthattheyappear.
Outer weights are like the ’expected’ counts in a chi-square test of independence, and will yield
thesameresultsasthoseobtainedbyproportionalaveragingwithonefactoratatime. Allexcept

| 28  |     |     |     |     | emmeans |
| --- | --- | --- | --- | --- | ------- |
"cells" uses the same set of weights for each mean. In a model where the predicted values are
thecellmeans,cellweightswillyieldtherawaveragesofthedataforthefactorsinvolved. Using
| "flat" | "cells", |     |     |     |     |
| ------ | -------- | --- | --- | --- | --- |
is similar to except nonempty cells are weighted equally and empty cells are
ignored.
Counterfactuals
Counterfactualreferencegrids(seethedocumentationforref_grid)containpairsofimputedand
actualfactorlevels,andarehandledinaspecialway. Forstarters,theweightsargumentisignored
andwealwaysuse"cells"weights.OurunderstandingisthatiffactorsA,Barespecifiedascoun-
terfactuals,themarginalmeansforAshouldstillbethesameasifAweretheonlycounterfactual.
Accordingly, incomputingthesemarginalmeans, weexcludeallcaseswhereB!=actual_B,be-
| A   |     | B   |     |     |     |
| --- | --- | --- | --- | --- | --- |
cause if were the only counterfactual, will stay at its actual level. We also take special pains
to "remember" information about actual and imputed levels of counterfactuals so that appropriate
resultsareobtainedwhenemmeansisappliedtoapreviousemmeansresult.
Offsets
ref_grid,
Unlike in an offset need not be scalar. If not enough values are supplied, they are
cyclicallyrecycled. Foravectorofoffsets,itisimportanttounderstandthattheorderingofresults
goes with the first name in specs varying fastest. If there are any by factors, those vary slower
butthefirstbyvariablevariesthefastestwithinthathierarchy.
| thanalltheprimaryones, |     |     |     |     | Seethe |
| ---------------------- | --- | --- | --- | --- | ------ |
examples.
Optionsand...
Argumentsthatcouldgoinoptionsmayinsteadbeincludedin...,typically,argumentssuchas
| type, infer, |     | summary.emmGrid. |     |     |     |
| ------------ | --- | ---------------- | --- | --- | --- |
etc. that in essence are passed to Arguments in both places are
overriddenbytheonesin....
|     | ... |     |     |     | ref_grid |
| --- | --- | --- | --- | --- | -------- |
There is a danger that arguments could partially match those used by both and
update.emmGrid,
|     | creating a conflict. | If these occur, | usually they | can be resolved | by providing |
| --- | -------------------- | --------------- | ------------ | --------------- | ------------ |
complete(oratleastlonger)argumentnames;orbyisolatingnon-ref_gridargumentsinoptions;
orbycallingref_gridseparatelyandpassingtheresultasobject.
Seeanot-runexamplebelow.
Also, when specs is atwo-sided formula, or contr is specified, there is potentialconfusion con-
cerningwhich...argumentsapplytothemeans,andwhichtothecontrasts. Whensuchconfusion
ispossible,wesuggestdoingthingsseparately(acalltoemmeanswithnocontrasts,followedbya
call to contrast). We treat adjust as a special case: it is applied to the emmeans results only if
therearenocontrastsspecified,otherwiseitispassedonlytocontrast.
SeeAlso
ref_grid,contrast,vignette("models","emmeans")
Examples
| warp.lm <- lm(breaks | ~ wool * tension, | data       | = warpbreaks) |     |     |
| -------------------- | ----------------- | ---------- | ------------- | --- | --- |
| emmeans (warp.lm,    | ~ wool | tension) |            |               |     |     |
| # or equivalently    | emmeans(warp.lm,  | "wool", by | = "tension")  |     |     |

emmGrid-class 29
# 'adjust' argument ignored in emmeans, passed to contrast part...
emmeans (warp.lm, poly ~ tension | wool, adjust = "sidak")
# 'adjust' argument NOT ignored ...
emmeans (warp.lm, ~ tension | wool, adjust = "sidak")
# Get all sets of EMMs for this model
( allsets <- emmeans(warp.lm, ".") )
contrast(allsets, "eff") # all effects
## Not run:
### Offsets: Consider a silly example:
emmeans(warp.lm, ~ tension | wool, offset = c(17, 23, 47)) @ grid
# note that offsets are recycled so that each level of tension receives
# the same offset for each wool.
# But using the same offsets with ~ wool | tension will probably not
# be what you want because the ordering of combinations is different.
## End(Not run)
emmGrid-class TheemmGridclass
Description
TheemmGridclassencapsulateslinearfunctionsofregressionparameters,definedoveragridofpre-
dictors. Thisincludesreferencegridsandgridsofmarginalmeansthereof(akaestimatedmarginal
means). Objects of class ‘emmGrid‘ may be used independently of the underlying model object.
Instancesarecreatedprimarilybyref_gridandemmeans,andseveralrelatedfunctions.
Slots
model.info list. Containstheelementscall(thecallthatproducedthemodel),terms(itsterms
object),andxlev(factor-levelinformation)
roles list. Contains at least the elements predictors, responses, and multresp. Each is a
charactervectorofnamesofthesevariables.
grid data.frame. Contains the combinations of the variables that define the reference grid. In
addition, there is an auxiliary column named ".wgt." holding the observed frequencies or
weights for each factor combination (excluding covariates). If the model has one or more
offset()calls,thereisananotherauxiliarycolumnnamed".offset.". Auxiliarycolumns
arenotconsideredpartofthereferencegrid.(However,anyvariablesincludedinoffsetcalls
areinthereferencegrid.)
levels list.Eachentryisacharactervectorwiththedistinctlevelsofeachvariableinthereference
grid. Notethatgridisobtainedbyapplyingthefunctionexpand.gridtothislist
matlevs list.Likelevelsbuthasthelevelsofanymatricesintheoriginaldataset.Matrixcolumns
arealwaysconcatenatedandtreatedasasinglevariableforpurposesofthereferencegrid

| 30  |     |     |     |     | emmip |
| --- | --- | --- | --- | --- | ----- |
linfct matrix.Eachrowconsistsofthelinearfunctionoftheregressioncoefficientsforpredicting
its corresponding element of the reference grid. The rows of this matrix go in one-to-one
correspondencewiththerowsofgrid,andthecolumnswithelementsofbhat.
bhat numeric. Theregressioncoefficients. Ifthereisamultivariateresponse,thematrixofcoef-
ficients is flattened to a single vector, and linfct and V redefined appropriately. Important:
bhatmustincludeanyNAvaluesproducedasaresultofcollinearityinthepredictors.
These
aretakencareoflaterintheestimabilitycheck.
nbasis matrix. The basis for the non-estimable functions of the regression coefficients. Every
linfct,
EMM will correspond to a linear combination of rows of and that result must be
orthogonaltoallthecolumnsofnbasisinordertobeestimable. Ifeverythingisestimable,
nbasisshouldbea1x1matrixofNA.
| V Thesymmetricvariance-covariancematrixofbhat |     |     |     |     |     |
| --------------------------------------------- | --- | --- | --- | --- | --- |
matrix.
dffun function having two arguments. dffun(k,dfargs) should return the degrees of freedom
forthelinearfunctionsum(k*bhat),orNAifunavailable
| dfargs | Usedtoholdanyadditionalinformationneededbydffun. |     |     |     |     |
| ------ | ------------------------------------------------ | --- | --- | --- | --- |
list.
| misc                                      |     |     |                                  |     | estName |
| ----------------------------------------- | --- | --- | -------------------------------- | --- | ------- |
| list. Additionalinformationusedbymethods. |     |     | Theseincludeatleastthefollowing: |     |         |
(thelabel fortheestimatesof linearfunctions), and thedefaultvaluesof infer, level, and
adjusttobeusedinthesummary.emmGridmethod. Elementsinthisslotmaybemodifiedif
desiredusingtheupdate.emmGridmethod.
post.beta matrix. A sample from the posterior distribution of the regression coefficients, if
MCMC methods were used; or a 1 x 1 matrix of NA otherwise. When it is non-trivial, the
| as.mcmc.emmGrid |        | post.beta%*%t(linfct), |     |                   |          |
| --------------- | ------ | ---------------------- | --- | ----------------- | -------- |
|                 | method | returns                |     | which is a sample | from the |
posteriordistributionoftheEMMs.
Methods
AllmethodsfortheseobjectsareS3methodsexceptforshow.Theyinclude[.emmGrid,as.glht.emmGrid,
as.mcmc.emmGrid,as.mcmc.list.emmGrid(seecoda),cld.emmGrid(seemultcomp),coef.emmGrid,
confint.emmGrid,contrast.emmGrid,pairs.emmGrid,plot.emmGrid,predict.emmGrid,print.emmGrid,
rbind.emmGrid,show.emmGrid,str.emmGrid,summary.emmGrid,test.emmGrid,update.emmGrid,
vcov.emmGrid,andxtable.emmGrid
| emmip | Interaction-styleplotsforestimatedmarginalmeans |     |     |     |     |
| ----- | ----------------------------------------------- | --- | --- | --- | --- |
Description
CreatesaninteractionplotofEMMsbasedonafittedmodelandasimpleformulaspecification.
Usage
| emmip(object, | formula, ...)  |              |              |     |     |
| ------------- | -------------- | ------------ | ------------ | --- | --- |
| ## Default    | S3 method:     |              |              |     |     |
| emmip(object, | formula, type, | CIs = FALSE, | PIs = FALSE, |     |     |

| emmip              |                                      |              |     |          |     |                 |        |            |        |     | 31  |
| ------------------ | ------------------------------------ | ------------ | --- | -------- | --- | --------------- | ------ | ---------- | ------ | --- | --- |
| style, engine      | = get_emm_option("graphics.engine"), |              |     |          |     |                 | plotit | =          | TRUE,  |     |     |
| nesting.order      | = FALSE,                             | abbr.len     |     | = c(0,   | 0), | ...)            |        |            |        |     |     |
| emmip_ggplot(emms, | style                                | = "factor",  |     | dodge    | =   | 0.2,            | xlab = | labs$xlab, |        |     |     |
| ylab = labs$ylab,  | tlab                                 | = labs$tlab, |     | facetlab |     | = "label_both", |        |            | scale, |     |     |
dotarg = list(shape = "circle"), linearg = list(linetype = "solid"),
CIarg = list(alpha = 0.4), PIarg = list(alpha = 0.25), col = NULL, ...)
emmip_lattice(emms, style = "factor", xlab = labs$xlab, ylab = labs$ylab,
| tlab = labs$tlab, | pch  | = c(1, | 2,  | 6, 7, | 9, 10, | 15:20), | lty | = 1, |     |     |     |
| ----------------- | ---- | ------ | --- | ----- | ------ | ------- | --- | ---- | --- | --- | --- |
| col = NULL,       | ...) |        |     |       |        |         |     |      |     |     |     |
Arguments
object An object of class emmGrid, or a fitted model of a class supported by the em-
meanspackage
| formula | Formulaoftheformtrace.factors~x.factors|by.factors. |     |     |     |     |     |     |     |     |     |     |
| ------- | --------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
TheEMMs
|     |              |         | x.factor    |               |          |          | trace.factors. |         |              | by.factors |         |
| --- | ------------ | ------- | ----------- | ------------- | -------- | -------- | -------------- | ------- | ------------ | ---------- | ------- |
|     | are plotted  | against |             |               | for each | level    | of             |         |              |            |         |
|     | is optional, | but     | if present, | it determines |          | separate |                | panels. | Each element |            | of this |
formulamaybeasinglefactorinthemodel,oracombinationoffactorsusing
the*operator.
... Additionalargumentspassedtoemmeans(whenobjectisnotalreadyanemmGrid
object),predict.emmGrid,emmip_ggplot,oremmip_lattice.
type Asinpredict.emmGrid,thisdetermineswhetherwewanttoinverse-transform
|     | the predictions |     | (type="response")  |     |     | or not | (any  | other choice). |                  | The default | is  |
| --- | --------------- | --- | ------------------ | --- | --- | ------ | ----- | -------------- | ---------------- | ----------- | --- |
|     | "link", unless  |     | the "predict.type" |     |     | option | is in | force;         | see emm_options. |             | In  |
addition,theusermayspecifytype="scale"tocreateatransformedscalefor
theverticalaxisbasedonobject’sresponsetransformationorlinkfunction.
CIs Logical value. If TRUE, confidence intervals (or HPD intervals for Bayesian
models)areaddedtotheplot(worksonlywithengine="ggplot").
| PIs |                        |         | TRUE,              |            |             |        |           |                   |            |           |       |
| --- | ---------------------- | ------- | ------------------ | ---------- | ----------- | ------ | --------- | ----------------- | ---------- | --------- | ----- |
|     | Logical value.         |         | If                 | prediction | intervals   |        | are added | to                | the plot   | (works    | only  |
|     | with engine="ggplot"). |         |                    | This       | is allowed  |        | only      | if the underlying |            | model     | fam-  |
|     | "gaussian".            |         |                    | CIs        |             | PIs    | TRUE,     |                   |            |           |       |
|     | ily is                 |         | If                 | both       | and         | are    |           | the prediction    |            | intervals | will  |
|     | be somewhat            | longer, |                    | lighter,   | and thinner | than   | the       | confidence        | intervals. |           | Addi- |
|     | tional parameters      |         | to predict.emmGrid |            |             | (e.g., | sigma)    | may               | be passed  | via       | ....  |
ForBayesianmodels,PIsrequirefrequentist=TRUEandavalueforsigma.
style
|     | Optionalcharactervalue.                                        |                                                          |       | Thishasaneffectonlywhenthehorizontalvariableis |          |         |            |     |            |       |        |
| --- | -------------------------------------------------------------- | -------------------------------------------------------- | ----- | ---------------------------------------------- | -------- | ------- | ---------- | --- | ---------- | ----- | ------ |
|     | asinglenumericvariable.                                        |                                                          |       | Ifstyleisunspecifiedor"numeric",thehorizontal  |          |         |            |     |            |       |        |
|     | scalewillbenumericandcurvesareplottedusinglines(andnosymbols). |                                                          |       |                                                |          |         |            |     |            |       | With   |
|     | style="factor",                                                |                                                          | the   | horizontal                                     | variable |         | is treated | as  | the levels | of a  | factor |
|     | (equally spaced                                                |                                                          | along | the horizontal                                 |          | scale), | and curves | are | plotted    | using | lines  |
|     | andsymbols.                                                    | Whenthehorizontalvariableischaracterorfactor,oracombina- |       |                                                |          |         |            |     |            |       |        |
tionofmorethanonepredictor,"factor"styleisalwaysused.
engine Character value matching "ggplot" (default), "lattice", or "none". The
|     | graphics                                 | engine | to be | used to | produce | the | plot.                        | These | require, | respectively, |     |
| --- | ---------------------------------------- | ------ | ----- | ------- | ------- | --- | ---------------------------- | ----- | -------- | ------------- | --- |
|     | theggplot2orlatticepackagetobeinstalled. |        |       |         |         |     | Specifying"none"isequivalent |       |          |               |     |
tosettingplotit=FALSE.

| 32  |     |     |     |     |     |     |     |     |     | emmip |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----- |
plotit Logicalvalue. IfTRUE,agraphicalobjectisreturned;ifFALSE,adata.frameis
returnedcontainingallthevaluesusedtoconstructtheplot.
nesting.order Logicalvalue. IfTRUE,factorsthatarenestedarepresentedinorderaccording
totheirnestingfactors,evenifthosenestingfactorsarenotpresentinformula.
IfFALSE,onlythevariablesinformulaareusedtoorderthevariables.
abbr.len Integer vector of length 1 or 2 used to specify that factor levels be abbrevi-
abbreviate.
|     | ated to the | specified | lengths, | using |     |     |     | Any values | less than | 1 are |
| --- | ----------- | --------- | -------- | ----- | --- | --- | --- | ---------- | --------- | ----- |
ignored. abbr.len[1]appliestoafactorplottedalongthehorizontalaxis,and
abbr.len[2](ifpresent)appliestotracefactors(showninalegend)orbyfac-
tors(showninfacetlabels).
emms Adata.framecreatedbycallingemmipwithplotit=FALSE.Certainvariables
|     | andattributesareexpectedtoexistinthisdataframe; |     |     |     |     |     |     | seethesectiondetailing |     |     |
| --- | ----------------------------------------------- | --- | --- | --- | --- | --- | --- | ---------------------- | --- | --- |
therenderingfunctions.
dodge Numericalamountpassedtoggplot2::position_dodgebywhichpointsand
intervalsareoffsetsotheydonotcollide.
xlab,ylab,tlab
|     | Character | labels        | for the | horizontal | axis,    | vertical | axis,     | and traces | (the          | different |
| --- | --------- | ------------- | ------- | ---------- | -------- | -------- | --------- | ---------- | ------------- | --------- |
|     | curves),  | respectively. |         | The emmip  | function |          | generates | these      | automatically | and       |
providesthermviathelabsattribute,buttheusermayoverridetheseifdesired.
facetlab Labellerforfacets(whenbyvariablesareinplay).Use"label_value"toshow
justthefactorlevels,or"label_both"toshowboththefactornamesandfactor
|     | levels; "label_context" |     |     | decides | which | based | on  | how many | by factors | there |
| --- | ----------------------- | --- | --- | ------- | ----- | ----- | --- | -------- | ---------- | ----- |
Seethedocumentationforggplot2::labellers.
are.
scale Ifnotmissing,anobjectofclassscales::transspecifyinga(usually)nonlin-
|     | earscalingfortheverticalaxis. |     |     |                                              | Forexample,scales=scales::log_trans() |     |     |     |     |     |
| --- | ----------------------------- | --- | --- | -------------------------------------------- | ------------------------------------- | --- | --- | --- | --- | --- |
|     | specifiesalogarithmicscale.   |     |     | Forfine-tuningpurposes,additionalargumentsto |                                       |     |     |     |     |     |
ggplot2::scale_y_continuousmaybeincludedin....
dotarg listofargumentspassedtogeom_pointtocustomizeappearanceofpoints.
If
thisincludesshapeanditisoflengthgreaterthan1,itisinterpretedasashape
paletteinstead.
| linearg | list          |           |        | geom_line |              |         |           |            |                |           |
| ------- | ------------- | --------- | ------ | --------- | ------------ | ------- | --------- | ---------- | -------------- | --------- |
|         | of            | arguments | passed | to        |              | to      | customize | appearance | of             | lines. If |
|         | this includes | linetype  |        | and it    | is of length | greater |           | than 1, it | is interpreted | as a      |
linetype.
CIarg,PIarg listsofargumentspassedtogeom_linerangetocustomizeappearanceofin-
thelinetypeaestheticdefaultsto"solid"underthehood)
tervals. (Note:
col Withemmip_ggplot,thisaddscolor=col(notcolour)toallofthe*arglists.
Thisisintendedforsettingacommoncolorforeverything,suchasablack-and-
whiteplot.Withemmip_lattice,colspecifiesthecolorstouseforeachgroup,
|     | recycledasneeded. |     | Ifnotspecified,thedefaulttrelliscolorsareused. |     |     |     |     |     |     |     |
| --- | ----------------- | --- | ---------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
pch (Latticeonly)Theplottingcharacterstouseforeachgroup(i.e.,levelsoftrace.factors).
Theyarerecycledasneeded.
lty (Latticeonly)Thelinetypestouseforeachgroup. Recycledasneeded.
Value
If plotit=FALSE, a data.frame (actually, a summary_emm object) with the table of EMMs that
|     |     |     |     |     | xvar | yvar, |     |     |     |     |
| --- | --- | --- | --- | --- | ---- | ----- | --- | --- | --- | --- |
would be plotted. The variables plotted are named and and the trace factor is named

emmip 33
tvar. This data frame has an added "labs" attribute containing the labels xlab, ylab, and tlab
fortheserespectivevariables. Theconfidencelimitsarealsoincluded,renamedLCLandUCL.
Ifplotit=TRUE,thefunctionreturnsanobjectofclass"ggplot"ora"trellis",dependingon
engine.
Details
Ifobjectisafittedmodel,emmeansiscalledwithanappropriatespecificationtoobtainestimated
marginalmeansforeachcombinationofthefactorspresentinformula(inaddition,anyarguments
in ... that match at, trend, cov.reduce, or fac.reduce are passed to emmeans). Otherwise, if
| object | emmGrid |     |     |     |     |     |     |     |
| ------ | ------- | --- | --- | --- | --- | --- | --- | --- |
is an object, its first element is used, and it must contain one estimate for each
combinationofthefactorspresentinformula.
Renderingfunctions
The functions emmip_ggplot and emmip_lattice are called when plotit==TRUE to render the
plotit=FALSE engine=
plots; but they may also be called later on an object saved via (or
"none"). Thefunctionsrequirethatemmscontainsvariablesxvar, yvar, andtvar, andattributes
"labs"and"vars". ConfidenceintervalsareplottedifvariablesLCLandUCLexist;andprediction
intervalsareplottedifLPLandUPLexist.Finally,itmustcontainthevariablesnamedinattr(emms,
"vars").
Inemmip_ggplot,colors,linetypes,andshapesareallassignedtogroups(accordingtotvar)unless
overridden. So,forexample,onemayhavedifferentsymbolsforeachgroupbysimplyspecifying
dotarg=list().
Note
Conceptually,thisfunctionisequivalenttointeraction.plotwherethesummarizationfunction
isthoughttoreturntheEMMs.
SeeAlso
emmeans,interaction.plot.
Examples
| #--- Three-factor |                  | example    |            |              |             |              |              |              |
| ----------------- | ---------------- | ---------- | ---------- | ------------ | ----------- | ------------ | ------------ | ------------ |
| noise.lm          | = lm(noise       | ~ size     | * type     | *            | side, data  | =            | auto.noise)  |              |
| # Separate        | interaction      |            | plots of   | size         | by type,    | for          | each side    |              |
| emmip(noise.lm,   |                  | type ~     | size |     | side)        |             |              |              |              |
| # Same using      | the              | "lattice"  | engine     |              |             |              |              |              |
| emmip(noise.lm,   |                  | type ~     | size |     | side,        | engine      | = "lattice") |              |              |
| # One interaction |                  | plot,      | using      | combinations |             | of size      | and side as  | the x factor |
| # ... with        | added            | confidence | intervals  |              | and some    | formatting   | changes      |              |
| emmip(noise.lm,   |                  | type ~     | side *     | size,        | CIs = TRUE, |              |              |              |
| CIarg             | = list(linewidth |            | = 1.5,     | alpha        | = 1,        | color        | = "orange"), |              |
| dotarg            | = list(size      |            | = 2, shape | =            | "square",   | color        | = "black"))  |              |

34 emmobj
# Same using legacy theme
with_emm_options(gg.theme = 1,
emmip(noise.lm, type ~ side * size, CIs = TRUE,
CIarg = list(linewidth = 1.5, alpha = 1, color = "orange"),
dotarg = list(size = 2, shape = "square", color = "black")))
# Create a black-and-white version of above with different linetypes
# (Let the linetypes and symbols default to the palette)
emmip(noise.lm, type ~ side * size, CIs = TRUE, col = "black",
linearg = list(), dotarg = list(size = 4), CIarg = list(alpha = 1)) +
ggplot2::theme_bw()
# One interaction plot using combinations of type and side as the trace factor
emmip(noise.lm, type * side ~ size)
# Individual traces in panels
emmip(noise.lm, ~ size | type * side)
# Example for the 'style' argument
fib.lm = lm(strength ~ machine * sqrt(diameter), data = fiber)
fib.rg = ref_grid(fib.lm, at = list(diameter = c(12, 14, 15, 25, 36)))
emmip(fib.rg, machine ~ diameter) # curves (because diameter is numeric)
emmip(fib.rg, machine ~ diameter, style = "factor") # points and lines
# For an example using extra ggplot2 code, see 'vignette("messy-data")',
# in the section on nested models.
### Options with transformations or link functions
neuralgia.glm <- glm(Pain ~ Treatment * Sex + Age, family = binomial(),
data = neuralgia)
# On link scale:
emmip(neuralgia.glm, Treatment ~ Sex)
# On response scale:
emmip(neuralgia.glm, Treatment ~ Sex, type = "response")
# With transformed axis scale and custom scale divisions
emmip(neuralgia.glm, Treatment ~ Sex, type = "scale",
breaks = seq(0.10, 0.90, by = 0.10))
emmobj ConstructanemmGridobjectfromscratch
Description
This allows the user to incorporate results obtained by some analysis into an emmGrid object, en-
ablingtheuseofemmGridmethodstoperformrelatedfollow-upanalyses.

emmobj 35
Usage
emmobj(bhat, V, levels, linfct = diag(length(bhat)), df = NA, dffun,
| dfargs = list(), | post.beta | = matrix(NA), | nesting | = NULL, se.bhat, |     |
| ---------------- | --------- | ------------- | ------- | ---------------- | --- |
| se.diff, ...)    |           |               |         |                  |     |
Arguments
| bhat | Numeric. | Vectorofregressioncoefficients |     |     |     |
| ---- | -------- | ------------------------------ | --- | --- | --- |
| V    |          | Covariancematrixofbhat         |     |     |     |
Squarematrix.
levels Named list or vector. Levels of factor(s) that define the estimates defined by
linfct. Ifnotalist,weassumeonefactornamed"level"
| linfct |     | Linearfunctionsofbhatforeachcombinationoflevels. |     |     |     |
| ------ | --- | ------------------------------------------------ | --- | --- | --- |
Matrix.
df Numeric value or function with arguments (x,dfargs). If a number, that is
|     | used for | the degrees of freedom. | If a function, | it should return | the degrees of |
| --- | -------- | ----------------------- | -------------- | ---------------- | -------------- |
freedomforsum(x*bhat),withanyadditionalparametersindfargs.
dffun Overridesdfifspecified. Thisisaconveniencetomatchtheslotnamesofthe
returnedobject.
| dfargs | Listcontainingargumentsfordf. |     |     |     |     |
| ------ | ----------------------------- | --- | --- | --- | --- |
Thisisignoredifdfisnumeric.
post.beta Matrixwhosecolumnscompriseasamplefromtheposteriordistributionofthe
regressioncoefficients(sothattypically,thecolumnaverageswillbebhat).
A
1x1matrixofNAindicatesthatsuchasampleisunavailable.
nesting Nestingspecificationasinref_grid.Thisisignoredifmodel.infoissupplied.
se.bhat,se.diff
AlternativewayofspecifyingV.Ifse.bhatisspecified,Visconstructedusing
|     | se.bhat, | thestandarderrorsofbhat, | andse.diffs, | thestandarderrorsofits |     |
| --- | -------- | ------------------------ | ------------ | ---------------------- | --- |
se.diffshouldbeavectoroflengthk*(k-1)/2wherek
pairwisedifferences.
isthelengthofse.bhat,anditselementsshouldbeintheorder12,13,...,1k,23,...2k,....
Ifse.diffismissing,Viscomputedasifthebhatareindependent.
| ... | Argumentspassedtoupdate.emmGrid |     |     |     |     |
| --- | ------------------------------- | --- | --- | --- | --- |
Details
Theargumentsmustbeconformable. Thisincludesthatthelengthofbhat,thenumberofcolumns
linfct, post.beta
of and the number of columns of must all be equal. And that the product of
lengthsinlevelsmustbeequaltothenumberofrowsoflinfct. Thegridslotofthereturned
objectisgeneratedbyexpand.gridusinglevelsasitsarguments. Sotherowsoflinfctshould
beincorrespondingorder.
Thefunctionsqdrgandemmobjareclosecousins,inthattheybothproduceemmGridobjects.When
|     |     |     | emmobj |     | qdrg |
| --- | --- | --- | ------ | --- | ---- |
starting with summary statistics for an existing grid, is more useful, while is more
usefulwhenstartingfromanunsupportedfittedmodel.
Value
AnemmGridobject

36 emm_example
SeeAlso
qdrg,analternativethatisusefulwhenstartingwithafittedmodelnotsupportedinemmeans.
Examples
# Given summary statistics for 4 cells in a 2 x 2 layout, obtain
# marginal means and comparisons thereof. Assume heteroscedasticity
# and use the Satterthwaite method
levels <- list(trt = c("A", "B"), dose = c("high", "low"))
ybar <- c(57.6, 43.2, 88.9, 69.8)
s <- c(12.1, 19.5, 22.8, 43.2)
n <- c(44, 11, 37, 24)
se2 = s^2 / n
Satt.df <- function(x, dfargs)
sum(x * dfargs$v)^2 / sum((x * dfargs$v)^2 / (dfargs$n - 1))
expt.emm <- emmobj(bhat = ybar, V = diag(se2),
levels = levels, linfct = diag(c(1, 1, 1, 1)),
df = Satt.df, dfargs = list(v = se2, n = n), estName = "mean")
( trt.emm <- emmeans(expt.emm, "trt") )
( dose.emm <- emmeans(expt.emm, "dose") )
rbind(pairs(trt.emm), pairs(dose.emm), adjust = "mvt")
### Create an emmobj from means and SEs
### (This illustration reproduces the MOats example for Variety = "Victory")
means = c(71.50000, 89.66667, 110.83333, 118.50000)
semeans = c(5.540591, 6.602048, 8.695358, 7.303221)
sediffs = c(7.310571, 9.894724, 7.463615, 10.248306, 4.935698, 8.694507)
foo = emmobj(bhat = means, se.bhat = semeans, se.diff = sediffs,
levels = list(nitro = seq(0, .6, by = .2)), df = 10)
plot(foo, comparisons = TRUE)
emm_example Runorlistadditionalexamples
Description
This function exists so as to provide cleaner-looking examples in help files when it must be run
conditionallyonanotherpackage. Typicallywewanttorunthecode(run=TRUEisthedefault),or
otherwisejustlistitontheconsole(list=TRUE).
Usage
emm_example(name, run = !list, list = FALSE, ...)

emm_list 37
Arguments
name ".R"
|     | Character | name of file to run. | We look | for a file with | this name (with |
| --- | --------- | -------------------- | ------- | --------------- | --------------- |
appended)inthesystemfilesprovidedwithemmeans.
| run | Logicalchoosingwhetherornottoruntheexamplecode |     |     |     |     |
| --- | ---------------------------------------------- | --- | --- | --- | --- |
list
Logicalchoosingwhetherornottolisttheexamplecode
| ... | Usedonlybythedeveloper |     |     |     |     |
| --- | ---------------------- | --- | --- | --- | --- |
Examples
| # List an                 | example |              |     |     |     |
| ------------------------- | ------- | ------------ | --- | --- | --- |
| emm_example("qdrg-biglm", |         | list = TRUE) |     |     |     |
| # Run an example          |         |              |     |     |     |
if (require(biglm))
emm_example("qdrg-biglm")
| emm_list |     | Theemm_listclass |     |     |     |
| -------- | --- | ---------------- | --- | --- | --- |
Description
emm_list emmGrid
An object is simply a list of objects. Such a list is returned, for example, by
emmeans with a two-sided formula or a list as its specs argument. Several methods for this class
are provided, as detailed below. Typically, these methods just quietly do the same thing as their
emmGrid methods, using the first element of the list. You can specify which to select a different
element,orjustrunthecorrespondingemmGridmethodonobject[[k]].
Usage
| ## S3 method     | for class  | 'emm_list'                 |     |     |     |
| ---------------- | ---------- | -------------------------- | --- | --- | --- |
| contrast(object, | ...,       | which = NULL)              |     |     |     |
| ## S3 method     | for class  | 'emm_list'                 |     |     |     |
| pairs(x,         | ..., which | = NULL)                    |     |     |     |
| ## S3 method     | for class  | 'emm_list'                 |     |     |     |
| test(object,     | ..., which | = seq_along(object))       |     |     |     |
| ## S3 method     | for class  | 'emm_list'                 |     |     |     |
| confint(object,  | ...,       | which = seq_along(object)) |     |     |     |
| ## S3 method     | for class  | 'emm_list'                 |     |     |     |
| plot(x, ...,     | which =    | 1)                         |     |     |     |
| ## S3 method     | for class  | 'emm_list'                 |     |     |     |

| 38               |            |                            |                   |     | emm_list |     |
| ---------------- | ---------- | -------------------------- | ----------------- | --- | -------- | --- |
| coef(object,     | ..., which | = NULL)                    |                   |     |          |     |
| ## S3 method     | for class  | 'emm_list'                 |                   |     |          |     |
| linfct(object,   | ...,       | which = seq_along(object)) |                   |     |          |     |
| ## S3 method     | for class  | 'emm_list'                 |                   |     |          |     |
| str(object,      | ...)       |                            |                   |     |          |     |
| ## S3 method     | for class  | 'emm_list'                 |                   |     |          |     |
| summary(object,  | ...,       | which = seq_along(object)) |                   |     |          |     |
| ## S3 method     | for class  | 'emm_list'                 |                   |     |          |     |
| print(x,         | ...)       |                            |                   |     |          |     |
| ## S3 method     | for class  | 'emm_list'                 |                   |     |          |     |
| as.data.frame(x, | ...)       |                            |                   |     |          |     |
| ## S3 method     | for class  | 'summary_eml'              |                   |     |          |     |
| as.data.frame(x, | row.names  | = NULL,                    | optional = FALSE, |     |          |     |
| which,           | ...)       |                            |                   |     |          |     |
Arguments
| object,x | anobjectofclassemm_list |     |     |     |     |     |
| -------- | ----------------------- | --- | --- | --- | --- | --- |
... additionalargumentspassedtocorrespondingemmGridmethod. Inaddition,the
usermayincludealogicalargumentdropthatisakintodropandtheargument
|     | ofthesamenameinsubscriptingmatricesanddataframes. |           |                 |           | WhendropisTRUE   |     |
| --- | ------------------------------------------------- | --------- | --------------- | --------- | ---------------- | --- |
|     |                                                   |           |                 | list      | list             |     |
|     | (the default),                                    | then when | the result is a | of length | 1, the structure | is  |
removed.
which integer vector specifying which elements to select; if NULL, we try to guess
|     | which                                                     | elements make sense. | Usually, | this is all elements | having names | that |
| --- | --------------------------------------------------------- | -------------------- | -------- | -------------------- | ------------ | ---- |
|     | startwith‘em’or‘ls’,orthefirstelementifnomatchesarefound. |                      |          |                      | However,in   |      |
coef.emm_list,thesearetheonesweexclude.
row.names,optional
Requiredargumentsofas.data.frame,ignored
Value
a list of objects returned by the corresponding emmGrid method (thus, often, another emm_list
However,ifwhichhaslength1,theoneresultisnotwrappedinalist.
object).
summary.emm_listreturnsanobjectofclasssummary_eml,whichisalistofsummary_emmobjects.
Theas.data.framemethodsreturnasingledataframeviaas.data.frame(rbind(x)).
Seealso
rbind.emm_listandas.data.frame.emmGrid
Note
Theplotmethodusesonlythefirstelementofwhich;theothersareignored.

emm_options 39
Noexportoptionisprovidedforprintinganemm_list(seeprint.emmGrid).Ifyouwishtoexport
theseobjects,youmustdososeparatelyforeachelementinthelist.
Examples
| mod <- lm(conc      | ~ source, | data = pigs) |     |     |     |
| ------------------- | --------- | ------------ | --- | --- | --- |
| obj <- emmeans(mod, | pairwise  | ~ source)    |     |     |     |
linfct(obj)
| coef(obj)     | # done only | for the contrasts         |                  |     |     |
| ------------- | ----------- | ------------------------- | ---------------- | --- | --- |
| contrast(obj, | "consec")   | # done only               | for the means    |     |     |
| contrast(obj, | "eff", drop | = FALSE)                  | # kept as a list |     |     |
| emm_options   |             | Setorchangeemmeansoptions |                  |     |     |
Description
Useemm_optionstosetorchangevariousoptionsthatareusedintheemmeanspackage. These
optionsaresetseparatelyfordifferentcontextsinwhichemmGridobjectsarecreated, inanamed
listofoptionlists.
Usage
| emm_options(...,      | disable) |                      |     |     |     |
| --------------------- | -------- | -------------------- | --- | --- | --- |
| get_emm_option(x,     | default  | = emm_defaults[[x]]) |     |     |     |
| with_emm_options(..., |          | expr)                |     |     |     |
emm_defaults
Arguments
...
Optionnamesandvalues(seeDetails)
disable Ifnon-missing,thiswillresetalloptionstotheirdefaultsifdisabletestsTRUE
|     | (but                            | first save them       | for possible later restoration).     | Otherwise,         | all previously |
| --- | ------------------------------- | --------------------- | ------------------------------------ | ------------------ | -------------- |
|     | saved                           | options are restored. | This is important                    | for bug reporting; | please see the |
|     | sectionbelowonreproduciblebugs. |                       | Whendisableisspecified,theotherargu- |                    |                |
mentsareignored.
| x       | Charactervalue-thenameofanoptiontobequeried |     |                                      |     |     |
| ------- | ------------------------------------------- | --- | ------------------------------------ | --- | --- |
| default | Valuetoreturnifxisnotfound                  |     |                                      |     |     |
| expr    |                                             |     | Ifmissing,thelastelementof...isused. |     |     |
Expressiontoevaluate.

40 emm_options
Details
emmeans’soptionsarestoredasalistinthesystemoption"emmeans". Thus,emm_options(foo=
bar)isthesameasoptions(emmeans=list(...,foo=bar))where...representsanyprevi-
ouslyexistingoptions.Thelistemm_defaultscontainsthedefaultvaluesincasethecorresponding
elementofsystemoptionemmeansisNULL.
Currently,thefollowingmainlistentriesaresupported:
ref_grid A named list of defaults for objects created by ref_grid. This could affect other
objectsaswell. Forexample,ifemmeansiscalledwithafittedmodelobject,itcallsref_grid
andthisoptionwillaffecttheresultingemmGridobject.
emmeans Anamedlistofdefaultsforobjectscreatedbyemmeansoremtrends.
contrast Anamedlistofdefaultsforobjectscreatedbycontrast.emmGridorpairs.emmGrid.
summary A named list of defaults used by the methods summary.emmGrid, predict.emmGrid,
test.emmGrid,confint.emmGrid,andemmip. Theonlyoptionthatcanaffectthelatterfour
is"predict.type".
allow.na.levs A logical value that if TRUE (the default), allows NA to be among the levels of a
factor. Olderversionsofemmeansdidnotallowthis.Soifproblemscomeup(sayinamessy
datasetthatincludesincompletecases),trysettingthistoFALSE.
sep A character value to use as a separator in labeling factor combinations. Such labels are po-
tentially used in several places such as contrast and plot.emmGrid when combinations of
factorsarecomparedorplotted. Thedefaultis"".
parens Charactervectorthatdetermineswhichlabelsareparenthesizedwhentheyarecontrasted.
The first element is a regular expression, and the second and third elements are used as left
and right parentheses. See details for the parens argument in contrast. The default will
parenthesizelabelscontainingthefourarithmeticoperators,usingroundparentheses.
cov.keep Thedefaultvalueofcov.keepinref_grid. Defaultsto"2",i.e.,two-levelcovariates
aretreatedlikefactors.
graphics.engine Acharactervaluematchingc("ggplot","lattice"), settingthedefaulten-
ginetouseinemmipandplot.emmGrid. Defaultsto"ggplot".
gg.theme Aninteger. Setitto1or2ifyouwanttheappearanceofplotsusedinemmeansversion
1.x.xor2.x.x. Orsetittotheactualthemethatyouwanttouse,e.g.,emm_options(gg.theme
=ggplot2::theme_dark())
msg.interaction Alogicalvaluecontrollingwhetherornotamessageisdisplayedwhenemmeans
averagesoverafactorinvolvedinaninteraction. Itisprobablynotappropriatetodothis,un-
lesstheinteractionisweak. DefaultstoTRUE.
msg.nesting Alogicalvaluecontrollingwhetherornottodisplayamessagewhenanestingstruc-
tureisauto-detected. TheexistenceofsuchastructureaffectscomputationsofEMMs. Some-
times, a nesting structure is falsely detected – namely when a user has omitted some main
effectsbutincludedthemininteractions. Thisdoesnotchangethemodelfit,butitproduces
adifferentparameterizationthatispickedupwhenthereferencegridisconstructed. Defaults
toTRUE.
rg.limit Anintegervaluesettingalimitonthenumberofrowsinanewlyconstructedreference
grid. This is checked based on the number of levels of the factors involved; but it excludes
thelevelsofanymultivariateresponsesbecausethosearenotyetknown. Thereferencegrid

emm_options 41
consists of all possible combinations of the predictors, and this can become huge if there
are several factors. An error is thrown if this limit is exceeded. One can use the nuisance
argumentofref_gridtocollapseonnuisancefactors,thusmakingthegridsmaller. Defaults
to10,000.
simplify.names A logical value controlling whether to simplify (when possible) names in the
modelformulathatrefertodatasets–forexample,shouldwesimplifyapredictornamelike
“data$trt”tojust“trt”? DefaultstoTRUE.
opt.digits Alogicalvaluecontrollingtheprecisionwithwhichsummariesareprinted. IfTRUE
(default), the number of digits displayed is just enough to reasonably distinguish estimates
fromtheendsoftheirconfidenceintervals;butalwaysatleast3digits. IfFALSE,thesystem
valuegetOption("digits")isused.
pval.digits Anintegerindicatingtheprecisionwithwhichp-valuesareprinted.Integersbetween
2 and 6 are acceptable; the default is 4. Floating point numbers are truncated. If a number
outsidetheacceptedrangeisused, thenearestacceptableintegerwillbeusedinstead. Non-
numericargumentsareignored.
back.bias.adj Alogicalvaluecontrollingwhetherwetrytoadjustbiaswhenback-transforming.
If FALSE, we use naive back transformation. If TRUE and sigma is available and valid, a
second-orderadjustmentisappliedtoestimatethemeanontheresponsescale. Awarningis
issuedifnovalidsigmaisavailable
enable.submodel Alogicalvalue. IfTRUE,enablessupportforselectedmodelclassestoimple-
ment the submodel option. If FALSE, this support is disabled. Setting this option to FALSE
couldsaveexcessmemoryconsumption.
Someotheroptionshavemorespecificpurposes:
estble.tol Tolerancefordeterminingestimabilityinrank-deficientcases. Ifabsent,thevaluein
emm_defaults$estble.tol)isused.
save.ref_grid LogicalvalueofTRUEifyouwishthelatestreferencegridcreatedtobesavedin
.Last.ref_grid. ThedefaultisFALSE.
Optionsforlme4::lmerModmodels Optionslmer.df,disable.pbkrtest,pbkrtest.limit,disable.lmerTest,
and lmerTest.limit optionsaffect howdegrees offreedom arecomputedfor lmerMod ob-
jectsproducedbythelme4package). Seethatsectionofthe"models"vignettefordetails.
post.ci.method method for estimating confidence intervals for Bayesian models. Options are
"HPD"(default)or"quantile".
Value
emm_optionsreturnsthecurrentoptions(sameastheresultof‘getOption("emmeans")’)–invis-
ibly,unlesscalledwithnoarguments.
get_emm_optionreturnsthecurrentlystoredoptionforx,oritsdefaultvalueifnotfound.
with_emm_options() temporarily sets the options in ..., then evaluates try(expr) and returns
theresult.
Reproduciblebugs
Mostoptionssetdisplayattributesandsuchthatarenotlikelytobeassociatedwithbugsinthecode.
However,someotheroptions(e.g.,cov.keep)areessentiallyconfigurationsettingsthatmayaffect

42 emm_options
how/whetherthecoderuns,andthesettingsfortheseoptionsmaycausesubtleeffectsthatmaybe
hardtoreproduce. Therefore,whensendingabugreport,pleasecreateareproducibleexampleand
make sure the bug occurs with all options set at their defaults. This is done by preceding it with
emm_options(disable=TRUE).
By the way, disable works like a stack (LIFO buffer), in that disable=TRUE is equivalent to
emm_options(saved.opts=emm_options())andemm_options(disable=FALSE)isequivalent
to options(emmeans=get_emm_option("saved.opts")). To completely erase all options, use
options(emmeans=NULL)
Startupoptions
emmeans’soptionsarekeptinthesystemoptionsinalistnamesemmeans. Thus,iftheuserwants
certain options set on startup, this can be arranged by setting the emmeans option in one’s startup
script. Forexample,theuser’s.Rprofilefilecouldcontain:
options(emmeans = list(summary = list(predict.type = "response"),
lmer.df = "satterthwaite"))
SeeAlso
update.emmGrid
Examples
## Not run:
emm_options(ref_grid = list(level = .90),
contrast = list(infer = c(TRUE,FALSE)),
estble.tol = 1e-6)
# Sets default confidence level to .90 for objects created by ref.grid
# AS WELL AS emmeans called with a model object (since it creates a
# reference grid). In addition, when we call 'contrast', 'pairs', etc.,
# confidence intervals rather than tests are displayed by default.
## End(Not run)
## Not run:
emm_options(disable.pbkrtest = TRUE)
# This forces use of asymptotic methods for lmerMod objects.
# Set to FALSE or NULL to re-enable using pbkrtest.
## End(Not run)
# See tolerance being used for determining estimability
get_emm_option("estble.tol")
## Not run:
# Set all options to their defaults
emm_options(disable = TRUE)
# ... and perhaps follow with code for a minimal reproducible bug,
# which may include emm_options() clls if they are pertinent ...

| emtrends                             |                  |                |            |                    |       |                  |           |     | 43  |
| ------------------------------------ | ---------------- | -------------- | ---------- | ------------------ | ----- | ---------------- | --------- | --- | --- |
| # restore                            | options that     | had existed    | previously |                    |       |                  |           |     |     |
| emm_options(disable                  |                  | = FALSE)       |            |                    |       |                  |           |     |     |
| ## End(Not                           | run)             |                |            |                    |       |                  |           |     |     |
| # Temporarily                        | alter            | the formatting | of         | labels             | in an | interaction      | contrast: |     |     |
| pigs.lm <-                           | lm(inverse(conc) | ~ source       |            | * factor(percent), |       | data             | = pigs)   |     |     |
| with_emm_options(parens              |                  | = c("\\-",     | "<",       | ">"),              | sep   | = ": ",          |           |     |     |
| contrast(contrast(ref_grid(pigs.lm), |                  |                |            | "consec",          |       | by = "percent"), |           |     |     |
| "consec",                            | by               | = NULL))       |            |                    |       |                  |           |     |     |
emtrends
Estimatedmarginalmeansoflineartrends
Description
Theemtrendsfunctionisusefulwhenafittedmodelinvolvesanumericalpredictorxinteracting
with another predictor a (typically a factor). Such models specify that x has a different trend
dependingona;thus,itmaybeofinteresttoestimateandcomparethosetrends. Analogoustothe
emmeanssetting,weconstructareferencegridofthesepredictedtrends,andthenpossiblyaverage
themoversomeofthepredictorsinthegrid.
Usage
emtrends(object, specs, var, delta.var = 0.001 * rng, max.degree = 1, ...)
Arguments
| object | Asupportedmodelobject(notareferencegrid) |     |     |     |     |     |     |     |     |
| ------ | ---------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
specs Specificationsforwhatmarginaltrendsaredesired–asinemmeans. Ifspecsis
missingorNULL,emmeansisnotrunandthereferencegridforspecifiedtrends
isreturned.
var
Charactervaluegivingthenameofavariablewithrespecttowhichadifference
|     | quotientofthelinearpredictorsiscomputed. |              |           |     |                | Inorderforthistobeuseful,var |          |            |           |
| --- | ---------------------------------------- | ------------ | --------- | --- | -------------- | ---------------------------- | -------- | ---------- | --------- |
|     | should                                   | be a numeric | predictor |     | that interacts | with                         | at least | one factor | in specs. |
TheninsteadofcomputingEMMs,wecomputeandcomparetheslopesofthe
|     | vartrendoverlevelsofthespecifiedotherpredictor(s). |     |     |     |     |     |     | AsinEMMs,marginal |     |
| --- | -------------------------------------------------- | --- | --- | --- | --- | --- | --- | ----------------- | --- |
averagesarecomputedforthepredictorsinspecsandby.
Seealsothe“Gener-
alizations”sectionbelow.
delta.var Thevalueofhtouseinformingthedifferencequotient(f(x+h)−f(x))/h.
Changingit(especiallychangingitssign)maybenecessarytoavoidnumerical
|     | problemssuchaslogsofnegativenumbers. |     |     |     |     | Thedefaultvalueis1/1000ofthe |     |     |     |
| --- | ------------------------------------ | --- | --- | --- | --- | ---------------------------- | --- | --- | --- |
rangeofvaroverthedataset.

44 emtrends
max.degree Integervalue. Themaximumdegreeoftrendstocompute(thisiscappedat5).
If greater than 1, an additional factor degree is added to the grid, with corre-
spondinglevelsfororders1,2,...,max.degree. Theestimatesatvar = x
0
are equal to the coefficients of (x˘x )degree based on interpolating over the
0
degree + 1 fitted values centered at x and spaced h apart. These are also
0
knownasNewtondivideddifferences.
... Additionalargumentspassedtoref_gridoremmeansasappropriate. SeeDe-
tails.
Details
The function works by constructing reference grids for object with various values of var, and
then calculating difference quotients of predictions from those reference grids. Finally, emmeans
iscalledwiththegivenspecs,thuscomputingmarginalaveragesasneededofthedifferencequo-
tients. Any ... arguments are passed to the ref_grid and emmeans; examples of such optional
arguments include optional arguments (often mode) that apply to specific models; ref_grid op-
tionssuchasdata, at, cov.reduce, mult.names, nesting, ortransform; andemmeansoptions
suchasweights(butpleaseavoidtrendoroffset.
Value
AnemmGridoremm_listobject,accordingtospecs. Seeemmeansformoredetailsonwhenalist
isreturned.
Generalizations
Instead of a single predictor, the user may specify some monotone function of one variable, e.g.,
var="log(dose)". Ifso,thechainruleisapplied. Notethat,inthisexample,ifobjectcontains
log(dose)asapredictor,wewillbecomparingtheslopesestimatedbythatmodel,whereasspec-
ifyingvar="dose"wouldperformatransformationofthoseslopes, makingthepredictedtrends
varydependingondose.
Note
In earlier versions of emtrends, the first argument was named model rather than object. (The
namewaschangedbecauseofpotentialmis-matchingwithamodeargument,whichisanoptionfor
severaltypesofmodels.) Forbackwardcompatibility,modelstillworksprovidedallargumentsare
named.
It is important to understand that trends computed by emtrends are not equivalent to polynomial
contrastsinaparallelmodelwherevarisregardedasafactor. Thatisbecausethemodelobject
hereisassumedtofitasmoothfunctionofvar, andtheestimatedtrendsreflectlocal behaviorat
particularvalue(s)ofvar; whereaswhenvarismodeledasafactorandpolynomialcontrastsare
computed,thosecontrastsrepresenttheglobalpatternofchangesoveralllevelsofvar.
See the pigs.poly and pigs.fact examples below for an illustration. The linear and quadratic
trends depend on the value of percent, but the cubic trend is constant (because that is true of a
cubicpolynomial,whichistheunderlyingmodel). Thecubiccontrastinthefactorialmodelhasthe
samePvalueasforthecubictrend,againbecausethecubictrendisthesameeverywhere.

extending-emmeans 45
SeeAlso
emmeans,ref_grid
Examples
fiber.lm <- lm(strength ~ diameter*machine, data=fiber)
# Obtain slopes for each machine ...
( fiber.emt <- emtrends(fiber.lm, "machine", var = "diameter") )
# ... and pairwise comparisons thereof
pairs(fiber.emt)
# Suppose we want trends relative to sqrt(diameter)...
emtrends(fiber.lm, ~ machine | diameter, var = "sqrt(diameter)",
at = list(diameter = c(20, 30)))
# Obtaining a reference grid
mtcars.lm <- lm(mpg ~ poly(disp, degree = 2) * (factor(cyl) + factor(am)), data = mtcars)
# Center trends at mean disp for each no. of cylinders
mtcTrends.rg <- emtrends(mtcars.lm, var = "disp",
cov.reduce = disp ~ factor(cyl))
summary(mtcTrends.rg) # estimated trends at grid nodes
emmeans(mtcTrends.rg, "am", weights = "prop")
### Higher-degree trends ...
pigs.poly <- lm(conc ~ poly(percent, degree = 3), data = pigs)
emt <- emtrends(pigs.poly, ~ degree | percent, "percent", max.degree = 3,
at = list(percent = c(9, 13.5, 18)))
# note: 'degree' is an extra factor created by 'emtrends'
summary(emt, infer = c(TRUE, TRUE))
# Compare above results with poly contrasts when 'percent' is modeled as a factor ...
pigs.fact <- lm(conc ~ factor(percent), data = pigs)
emm <- emmeans(pigs.fact, "percent")
contrast(emm, "poly")
# Some P values are comparable, some aren't! See Note in documentation
extending-emmeans Supportfunctionsformodelextensions
Description
Thisdocumentssomefunctionsandmethodsthatmaybeusefultopackagedeveloperswishingto
addsupportforemmeansfortheirmodelobjects.Auserorpackagedevelopermayaddemmeans
supportforamodelclassbywritingrecover_dataandemm_basismethodsforthatclass. (Users

46 extending-emmeans
inneedforaquickwaytoobtainresultsforamodelthatisnotsupportedmaybebetterservedbythe
qdrgfunction.) Thereareseveralotherexportedfunctionsthatmaybeuseful. Seethe"xtending"
vignetteformoredetails.
Usage
| recover_data(object,   |       | ...)         |            |          |         |     |
| ---------------------- | ----- | ------------ | ---------- | -------- | ------- | --- |
| ## S3 method           | for   | class 'call' |            |          |         |     |
| recover_data(object,   |       | trms,        | na.action, | data     | = NULL, |     |
| params =               | "pi", | frame, pwts, | addl.vars, | ...)     |         |     |
| emm_basis(object,      |       | trms, xlev,  | grid,      | ...)     |         |     |
| .emm_register(classes, |       | pkgname,     | qdrg       | = FALSE) |         |     |
| .std.link.labels(fam,  |       | misc)        |            |          |         |     |
.combine.terms(...)
| .aovlist.dffun(k,  |         | dfargs)             |           |           |              |             |
| ------------------ | ------- | ------------------- | --------- | --------- | ------------ | ----------- |
| .cmpMM(X,          | weights | = rep(1,            | nrow(X)), | assign    | = attr(X$qr, | "assign"))  |
| .get.excl(levs,    | exc,    | inc)                |           |           |              |             |
| .get.offset(terms, |         | grid)               |           |           |              |             |
| .my.vcov(object,   |         | vcov. = .statsvcov, |           | ...)      |              |             |
| .all.vars(expr,    | retain  | = c("\\$",          |           | "\\[\\[", | "\\]\\]",    | "'", "\""), |
...)
| .diag(x, nrow, | ncol) |     |     |     |     |     |
| -------------- | ----- | --- | --- | --- | --- | --- |
| .num.key(levs, | key)  |     |     |     |     |     |
.emm_vignette(css = system.file("css", "clean-simple.css", package =
| "emmeans"),          | highlight | =            | NULL, ...) |             |         |      |
| -------------------- | --------- | ------------ | ---------- | ----------- | ------- | ---- |
| .hurdle.support(cmu, |           | cshape,      | cp0,       | cmean, zmu, | zshape, | zp0) |
| .zi.support(zmu,     |           | zshape, zp0) |            |             |         |      |
Arguments
| object | Anobjectofthesameclassasissupportedbyanewmethod. |     |     |     |     |     |
| ------ | ------------------------------------------------ | --- | --- | --- | --- | --- |
...
Additionalparametersthatmaybesupportedbythemethod.

extending-emmeans 47
trms Thetermscomponentofobject(typicallywiththeresponsedeleted,e.g. via
delete.response)
na.action Integervectorofindicesofobservationstoignore;orNULLifnone
data Dataframe. Usually,thisisNULL.However,ifnon-null,thisisusedinplaceof
the reconstructed dataset. It must have all of the predictors used in the model,
andanyfactorlevelsmustmatchthoseusedinfittingthemodel.
params Character vector giving the names of any variables in the model formula that
are not predictors. For example, a spline model may involve a local variable
knots that is not a predictor, but its value is needed to fit the model. Names
of parameters not actually used are harmless, and the default value "pi" (the
onlynumericconstantinbaseR)isprovidedincasethemodelinvolvesit. An
example involving splines may be found at https://github.com/rvlenth/
emmeans/issues/180.
frame Optionaldata.frame. Manymodelobjectscontainthemodelframeusedwhen
fitting the model. In cases where there are no predictor transformations, this
modelframehasalltheoriginalpredictorvaluesandsoisusableforrecovering
the data. Thus, if frame is non-missing and data is NULL, a check is made
on trms and if there are no function calls, we use data=frame. This can be
helpfulbecauseitprovidesamodicumofsecurityagainstthepossibilitythatthe
originaldatausedwhenfittingthemodelhasbeenalteredorremoved.
pwts Optionalvectorofpriorweights. Typically,thismaybeobtainedfromthefitted
modelviaweights(model). Ifthisisprovided,itisusedtosetweightsaslong
asitisnon-NULLandthesamelengthasthenumberofrowsofthedata.
addl.vars Charactervalueorvectorspecifyingadditionalpredictorstoincludeintheref-
erence grid. These must be names of variables that exist, or you will get an
error. Thismaybeusefulifyouneedtodoadditionalcomputationslateronthat
dependonthesevariables;e.g.,biasadjustmentsforrandomslopesofvariables
notamongthefixedpredictors.
xlev Namedlistoffactorlevels(excludingonescoercedtofactorsinthemodelfor-
mula)
grid Adata.frame(providedbyref_grid)containingthepredictorsettingsneeded
inthereferencegrid
classes Character names of one or more classes to be registered. The package must
contain the functions recover_data.foo and emm_basis.foo for each class
foolistedinclasses.
pkgname Characternameofpackageprovidingthemethods(usuallyshouldbethesecond
argumentof.onLoad)
qdrg Logicalvalue. IfFALSE,therecover_dataandemm_basismethodsareregis-
tered. IfTRUE,theqdrgmethodforeachclassisregisteredinstead.
fam Resultofcalltofamily(object)
misc Alistintendedforthe@miscslotofanemmGridobject
k,dfargs Arguments to .aovlist.dffun, which is made available as a convenience to
developersprovidingsupportsimilartothatprovidedforaovlistobjects

| 48  |     |     |     |     |     |     |     |     | extending-emmeans |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------------- | --- | --- |
X,weights,assign
Argumentsfor.cmpMM,whichcompactsamodelmatrixXintoamuchsmaller
|     | matrix | that           | has the | same | row space. | Specifically, |     | it returns | the            | R portion | of  |
| --- | ------ | -------------- | ------- | ---- | ---------- | ------------- | --- | ---------- | -------------- | --------- | --- |
|     |        |                |         |      | X          |               | qr, |            |                | weights   |     |
|     | its QR | decomposition. |         | If   | is already | of class      |     | it is      | used directly. |           |     |
shouldbetheweightsusedinthemodelfit,andassignisusedforunravelling
anypivotingdonebyqr.
levs,key The.num.keyfunctionreturnsthenumericindicesofthelevelsinlevstothe
setofalllevelsinkey
exc,inc Argumentsfor .get.excl whichis usefulin writing .emmc functionsfor gen-
|     | erating | contrast | coefficients, |     | and | supports | arguments | exclude | or  | include | for |
| --- | ------- | -------- | ------------- | --- | --- | -------- | --------- | ------- | --- | ------- | --- |
excludingorspecifyingwhichlevelstouse.
| terms | Atermscomponent |     |     |     |     |     |     |     |     |     |     |
| ----- | --------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
vcov.
|     | Function   | or  | matrix | that returns    | a   | suitable | covariance |          | matrix. | The default | is     |
| --- | ---------- | --- | ------ | --------------- | --- | -------- | ---------- | -------- | ------- | ----------- | ------ |
|     | .statsvcov |     | which  | is stats::vcov. |     | The      | .my.vcov   | function | should  | be          | called |
inplaceofvcov,anditsupportstheuserbeingabletospecifyadifferentmatrix
orfunctionviatheoptionalvcov.argument.
expr,retain Argumentsfor.all.vars,whichisanalternativetoall.varsthathasspecial
|     | provisions | for | retaining | the | special | characters | in  | retain, | thus allowing |     | model |
| --- | ---------- | --- | --------- | --- | ------- | ---------- | --- | ------- | ------------- | --- | ----- |
specificationslikey~data$trt*df[["dose"]]
x,nrow,ncol Argumentsfor.diag,whichisanalternativetodiagthatlacksitsidiosyncrasy
ofreturninganidentitymatrixwhenxisoflength1.
css,package,highlight
Argumentsfor.emm_vignette,whichisacleanandsimplealternativetosuch
html_document
|     | as  |     |     | for use | as the | output style | of  | a Markdown | file. | All | the vi- |
| --- | --- | --- | --- | ------- | ------ | ------------ | --- | ---------- | ----- | --- | ------- |
gnettesintheemmeanspackageusethisoutputstyle.
cmu,zmu In.hurdle.supportand.zi.support,thesespecifyavectorofback-transformed
estimatesforthecountandzeromodel,respectively
cshape,zshape
Shapeparameterforthecountandzeromodel,respectively
| cp0,zp0 |          |     | (mu,shape) |     |               |     |        |      |               |     |      |
| ------- | -------- | --- | ---------- | --- | ------------- | --- | ------ | ---- | ------------- | --- | ---- |
|         | Function | of  |            |     | for computing |     | Prob(Y | = 0) | for the count | and | zero |
model,respectively
cmean Functionof(mu,shape)forcomputingthemeanofthecountmodel.Typically,
thisjustreturnsmu
Value
| recover_data |     |     |     | data.frame |     |     |     |     |     |     |     |
| ------------ | --- | --- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- |
The method must return a containing all the variables that appear
|               |               |     |            | "call", |     | "terms", | "predictors", |     |     | "responses". |     |
| ------------- | ------------- | --- | ---------- | ------- | --- | -------- | ------------- | --- | --- | ------------ | --- |
| as predictors | in the model, | and | attributes |         |     |          |               |     | and |              |     |
(recover_data.callwillprovidetheseattributes.)
Theemm_basismethodshouldreturnalistwiththefollowingelements:
X The matrix of linear functions over grid, having the same number of rows as grid and the
numberofcolumnsequaltothelengthofbhat.
ThisshouldincludeanyNAsthatresult
bhat Thevectorofregressioncoefficientsforfixedeffects.
fromrankdeficiencies.
nbasis Amatrixwhosecolumnsformabasisfornon-estimablefunctionsofbeta,ora1x1matrix
ofNAifthereisnorankdeficiency.

extending-emmeans 49
V Theestimatedcovariancematrixofbhat.
dffun A function of (k,dfargs) that returns the degrees of freedom associated with sum(k*
bhat).
dfargs Alistcontainingadditionalargumentsneededfordffun.
.std.link.llabelsreturnsamodifiedversionofmiscwiththeappropriateinformationincluded
correspondingtotheinformationinfam
combine.termsreturnsatermsobjectresultingfromcombiningallthetermsorformulasin....
.get.offsetreturnsthevalues,basedongrid,ofanyoffsetcomponentinterms
.hurdle.support returns a matrix with 3 rows containing the estimated mean responses and the
differentialswrtcmuandzmu,resp.
.zi.supportreturnsamatrixwith2rowscontainingtheestimatedprobabilitiesof0andthedif-
ferentialswrtmu. Seethesectiononhurdleandzero-inflatedmodels.
Details
To create a reference grid, the ref_grid function needs to reconstruct the data used in fitting the
model,andthenobtainamatrixoflinearfunctionsoftheregressioncoefficientsforagivengridof
predictorvalues. Thesetasksareperformedbycallstorecover_dataandemm_basisrespectively.
Avignettegivingdetailsandexamplesisavailableviavignette("xtending","emmeans")
Toextendemmeans’ssupporttoadditionalmodeltypes,oneneedonlywriteS3methodsforthese
two functions. The existing methods serve as helpful guidance for writing new ones. Most of
the work for recover_data can be done by its method for class "call", providing the terms
component and na.action data as additional arguments. Writing an emm_basis method is more
involved,buttheexistingmethods(e.g.,emmeans:::emm_basis.lm)canserveasmodels. Certain
recover_dataandemm_basismethodsareexportedfromemmeans.(Tofindout,domethods("recover_data").)
Ifyourobjectisbasedonanothermodel-fittingobject,itmaybethatallthatisneededistocallone
oftheseexportedmethodsandperhapsmakemodificationstotheresults. Contactthedeveloperif
youneedothersoftheseexported.
Ifthemodelhasamultivariateresponse,bhatneedstobe“flattened”intoasinglevector,andXand
Vmustbeconstructedconsistently.
In models where a non-full-rank result is possible (often, you can tell by seeing if there is a
singular.ok argument in the model-fitting function), summary.emmGrid and its relatives check
theestimabilityofeachprediction,usingthenonest.basisfunctionintheestimabilitypackage.
Themodelsalreadysupportedaredetailedinthe"models"vignette. Somepackagesmayprovide
additionalemmeanssupportforitsobjectclasses.
Communicationbetweenmethods
Iftherecover_datamethodgeneratesinformationneededbyemm_basis,thatinformationmaybe
incorporatedbycreatinga"misc"attributeinthereturnedrecovereddata. Thatinformationisthen
passedasthemiscargumentwhenref_gridcallsemm_basis.

50 extending-emmeans
Optionalhooks
Somemodelsmayneedsomethingotherthanstandardlinearestimatesandstandarderrors. Ifso,
customfunctionsmaybepointedtoviatheitemsmisc$estHook,misc$vcovHookandmisc$postGridHook.
Ifjustthenameofthehookfunctionisprovidedasacharacterstring,thenitisretrievedusingget.
TheestHookfunctionshouldhavearguments‘(object,do.se,tol,...)’whereobjectisthe
emmGrid object, do.se is a logical flag for whether to return the standard error, and tol is the
toleranceforassessingestimability. Itshouldreturnamatrixwith3columns: theestimates,stan-
dard errors (NA when do.se==FALSE), and degrees of freedom (NA for asymptotic). The number
of rows should equal ‘nrow(linfct(object)’. The vcovHook function should have arguments
‘(object,tol,...)’ as described. It should return the covariance matrix for the estimates. Fi-
nally, postGridHook, ifpresent, iscalledattheveryendofref_grid; ittakesoneargument, the
constructedobject,andshouldreturnasuitablymodifiedemmGridobject.
RegisteringS3methodsforamodelclass
The.emm_registerfunctionisprovidedasaconveniencetoconditionallyregisteryourS3meth-
odsforamodelclass,recover_data.fooandemm_basis.foo,wherefooistheclassname. Your
packageshouldimplementan.onLoadfunctionandcall.emm_registerifemmeansisinstalled.
Seetheexample.
SupportforHurdleandZero-inflatedmodels
Thefunctions.hurdle.supportand.zi.supporthelpfacilitatecalculationsneededtoestimate
the mean response (count model and zero model combined) of these models. .hurdle.support
returnsamatrixofthreerows. Thefirstistheestimatedmeanforahurdlemodel,andthe2ndand
3rd rows are differentials for the count and zero models, which needed for delta-method calcula-
tions. Tousethese,regardthe@linfctslotascomprisingtwosetsofcolumns, forthecountand
zeromodelsrespectively. Todothedeltamethodcalculations,multiplytherowsofthecountpart
byitsdifferentialstimeslink$mu.etaevcaluatedatthatpartofthelinearpredictor. Dothesame
forthezeropart,usingitsdifferentialsandmu.eta. IftheresultingmatrixisA,thenthecovariance
ofthemeanresponseisAVA’whereVisthe@Vslotoftheobject.
Thefunctionzi.supportworksthesameway,onlyitismuchsimpler,andisusedtoestimatethe
probabilityof0anditsdifferentialforeitherpartofazero-inflatedmodelorhurdlemodel.
Seethecodeforemm_basis.zeroinflandemm_basis.hurdleforhowtheseareusedwithmodels
fittedbythepsclpackage.
Note
Withoutanexplicitdataargument,recover_datareturnsthecurrentversionofthedataset. Ifthe
datasethaschangedsincethemodelwasfitted,thenthiswillnotbethedatausedtofitthemodel. It
isespeciallyimportanttoknowthisinsimulationstudieswherethedataarerandomlygeneratedor
permuted,andincaseswhereseveraldatasetsareprocessedinonestep(e.g.,usingdplyr).Inthose
cases,usersshouldbecarefultoprovidetheactualdatausedtofitthemodelinthedataargument.
SeeAlso
Vignetteonextendingemmeans

feedlot 51
Examples
## Not run:
#--- If your package provides recover_data and emm_grid methods for class 'mymod',
#--- put something like this in your package code -- say in zzz.R:
.onLoad <- function(libname, pkgname) {
if (requireNamespace("emmeans", quietly = TRUE))
emmeans::.emm_register("mymod", pkgname)
}
## End(Not run)
feedlot Feedlotdata
Description
Thisisanunbalancedanalysis-of-covarianceexample,whereonecovariateisaffectedbyafactor.
Feedercalvesfromvariousherdsenterafeedlot,wheretheyarefedoneofthreediets. Theweight
oftheanimalatentryisthecovariate,andtheweightatslaughteristheresponse.
Usage
data(feedlot)
Format
Adataframewith67observationsand4variables:
herd a factor with levels 9 16 3 32 24 31 19 36 34 35 33, designating the herd that a feeder calf
camefrom.
diet afactorwithlevelsLowMediumHigh: theenergylevelofthedietgiventheanimal.
swt anumericvector: theweightoftheanimalatslaughter.
ewt anumericvector: theweightoftheanimalatentrytothefeedlot.
Details
ThedataarisefromaWesternRegionalResearchProjectconductedatNewMexicoStateUniver-
sity. Calvesbornin1975incommercialherdsenteredafeedlotasyearlings. Bothdietsandherds
are of interest as factors. The covariate, ewt, is thought to be dependent on herd due to differ-
entgeneticbackgrounds,breedinghistory,etc. Thelevelsofherdorderedtosimilarityofgenetic
background.
Note: Therearesomeemptycellsinthecross-classificationofherdanddiet.
Source
UrquhartNS(1982)Adjustmentincovariateswhenonefactoraffectsthecovariate. Biometrics38,
651-660.

52 fiber
Examples
| feedlot.lm          | <- lm(swt       | ~ ewt      | + herd*diet, | data          | = feedlot) |               |
| ------------------- | --------------- | ---------- | ------------ | ------------- | ---------- | ------------- |
| # Obtain            | EMMs with       | a separate | reference    | value         | of ewt     | for each      |
| # herd.             | This reproduces |            | the last     | part of Table | 2 in       | the reference |
| emmeans(feedlot.lm, |                 | ~ diet     | | herd,      | cov.reduce    | = ewt      | ~ herd)       |
| fiber               |                 | Fiberdata  |              |               |            |               |
Description
FiberdatafromMontgomeryDesign(8thed.),p.656(Table15.10). Usefulasasimpleanalysis-of-
covarianceexample.
Usage
data(fiber)
Format
Adataframewith15observationsand3variables:
machine afactorwithlevelsABC.Thisistheprimaryfactorofinterest.
| strength | anumericvector. |     | Theresponsevariable. |     |     |     |
| -------- | --------------- | --- | -------------------- | --- | --- | --- |
diameter
|     | anumericvector. |     | Acovariate. |     |     |     |
| --- | --------------- | --- | ----------- | --- | --- | --- |
Details
The goal of the experiment is to compare the mean breaking strength of fibers produced by the
threemachines. Whentestingthis,thetechnicianalsomeasuredthediameterofeachfiber,andthis
measurementmaybeusedasaconcomitantvariabletoimproveprecisionoftheestimates.
Source
Montgomery, D. C. (2013) Design and Analysis of Experiments (8th ed.). John Wiley and Sons,
ISBN978-1-118-14692-7.
Examples
| fiber.lm | <- lm(strength |     | ~ diameter | + machine, | data=fiber) |     |
| -------- | -------------- | --- | ---------- | ---------- | ----------- | --- |
ref_grid(fiber.lm)
| # Covariate-adjusted |     | means    | and comparisons |     |     |     |
| -------------------- | --- | -------- | --------------- | --- | --- | --- |
| emmeans(fiber.lm,    |     | pairwise | ~ machine)      |     |     |     |

| hpd.summary |                                      |     |     |     | 53  |
| ----------- | ------------------------------------ | --- | --- | --- | --- |
| hpd.summary | SummarizeanemmGridfromaBayesianmodel |     |     |     |     |
Description
ThisfunctioncomputespointestimatesandHPD(orquantile)intervalsforeachfactorcombination
inobject@emmGrid. Whilethisfunctionmaybecalledindependently,itiscalledautomaticallyby
theS3methodsummary.emmGridwhentheobjectisbasedonaBayesianmodel. (Note: thelevel
argument,oritsdefault,ispassedasprob).
Usage
| hpd.summary(object, | prob, by,                           | type, point.est | = median, |      |     |
| ------------------- | ----------------------------------- | --------------- | --------- | ---- | --- |
| ci.method           | = get_emm_option("post.ci.method"), |                 | delta,    |      |     |
| bias.adjust         | = get_emm_option("back.bias.adj"),  |                 | sigma,    | ...) |     |
Arguments
| object | anemmGridobjecthavinganon-missingpost.betaslot |     |     |     |     |
| ------ | ---------------------------------------------- | --- | --- | --- | --- |
prob
|     | numeric probability | content for HPD | intervals (note: | when not | specified, the |
| --- | ------------------- | --------------- | ---------------- | -------- | -------------- |
currentleveloptionisused;seeemm_options)
| by   | factorstouseasbyvariables         |     |     |     |     |
| ---- | --------------------------------- | --- | --- | --- | --- |
| type | predictiontypeasinsummary.emmGrid |     |     |     |     |
point.est function to use to compute the point estimates from the posterior sample for
eachgridpoint
ci.method charactervaluematching"HPD"(default)or"quantile"(butactuallynotcase-
|     | sensitive). ThedefaultistouseHPDintervals(whicharetheshortestpossible |     |     |     |     |
| --- | --------------------------------------------------------------------- | --- | --- | --- | --- |
Alternatively,choosing"quantile"usesthequantilesoftheposte-
intervals).
riorhavingequaltailprobabilities.
delta Numericequivalencethreshold(onthelinearpredictorscaleregardlessoftype).
Seethesectionbelowonequivalencetesting.
bias.adjust Logicalvalueforwhethertoadjustforbiasinback-transforming(type="response").
Thisrequiresavalueofsigmatoexistintheobjectorbespecified.
sigma Error SD assumed for bias correction (when type="response". If not spec-
object@misc$sigma
|     | ified, | is used, | and a warning | if it is not found | or invalid. |
| --- | ------ | -------- | ------------- | ------------------ | ----------- |
sigmamaybeavector,aslongasitconformstothenumberofobserva-
Note:
tionsintheposteriorsample.
...
requiredbutnotused
Value
anobjectofclasssummary_emm

54 joint_tests
Equivalencetestingnote
If delta is positive, two columns labeled p.equiv and odds.eq are appended to the summary.
p.equivisthefractionofposteriorestimateshavingabsolutevalueslessthandelta. Theodds.eq
columnisjustp.equivconvertedtoanoddsratio;soitistheposterioroddsofequivalence.
A high value of p.equiv is evidence in favor of equivalence. It can be used to obtain something
equivalent(inspirit)tothefrequentistSchuirmann(TOST)procedure,wherebywewouldconclude
equivalenceatsignificancelevelαifthe(1−2α)confidenceintervalfallsentirelyintheinterval
[−δ,δ]. SimilarlyintheBayesiancontext,anequallystrongargumentforequivalenceisobtained
ifp.equivexceeds1−2α.
AcloselyrelatedquantityistheROPE(regionofpracticalequivalence),obtainableviabayestestR::rope(object,
range=c(-delta,delta)). Itsvalueisapproximately100*p.equiv/0.95ifthedefaultci=
0.95isused. SeealsobayestestR’sissue#567.
Finally, a Bayes factor for equivalence is obtainable by dividing odds.eq by the prior odds of
equivalence,assessedorelicitedseparately.
Note
HPDintervalsrequirethecodapackagetobeinstalledonyoursystem;otherwiseanerroristhrown.
(Soonewaytosidestepthaterroristospecifyci.method="quantile").
SeeAlso
summary.emmGrid
Examples
if(require("coda"))
emm_example("hpd.summary-coda")
# Use emm_example("hpd.summary-coda", list = TRUE) # to see just the code
joint_tests Computejointtestsofthetermsinamodel
Description
Thisfunctionproducesananalysis-of-variance-liketablebasedonlinearfunctionsofpredictorsin
a model or emmGrid object. Specifically, the function constructs, for each combination of factors
(orcovariatesreducedtotwoormorelevels),asetof(interaction)contrastsviacontrast,andthen
teststhemusingtestwithjoint=TRUE.Optionally,oneormoreofthepredictorsmaybeusedas
byvariable(s),sothatseparatetablesoftestsareproducedforeachcombinationofthem.

| joint_tests |     |     |     |     |     |     | 55  |
| ----------- | --- | --- | --- | --- | --- | --- | --- |
Usage
| joint_tests(object, |                    | by   | = NULL, show0df | = FALSE, | showconf | = TRUE, |     |
| ------------------- | ------------------ | ---- | --------------- | -------- | -------- | ------- | --- |
| cov.reduce          | = make.meanint(1), |      | ...)            |          |          |         |     |
| make.meanint(delta  |                    | = 1, | npts = 2)       |          |          |         |     |
meanint(x)
| make.symmint(ctr, |     | delta | = 1, npts = | 2)  |     |     |     |
| ----------------- | --- | ----- | ----------- | --- | --- | --- | --- |
symmint(ctr)
Arguments
object afittedmodel,emmGrid,oremm_list. Ifthelatter,itsfirstelementisused.
by characternamesofbyvariables. Separatesetsoftestsarerunforeachcombi-
nationofthese.
| show0df |         |        | TRUE,      |                    |     |            |                  |
| ------- | ------- | ------ | ---------- | ------------------ | --- | ---------- | ---------------- |
|         | logical | value; | if results | with zeronumerator |     | degrees of | freedom are dis- |
played,ifFALSEtheyareskipped
showconf logical value. When we have models with estimability issues (e.g., missing
|     | cells), | then | with showconf=TRUE, |     | we test any | remaining effects | that are not |
| --- | ------- | ---- | ------------------- | --- | ----------- | ----------------- | ------------ |
purelyduetocontrastsofasingleterm.Iffound,theyarelabeled(confounded).
Seevignette("xplanations")formoreinformation.
cov.reduce a function. If object is a fitted model, it is replaced by ref_grid(object,
|     | cov.reduce=cov.reduce,...). |     |     |     | Forthispurpose,thefunctionsmeanintand |     |     |
| --- | --------------------------- | --- | --- | --- | ------------------------------------- | --- | --- |
symmintareavailableforreturninganintervalaroundthemeanoraroundzero,
|     | respectively.                                 |     | Sethesectionbelowoncovariates. |     |     |     |     |
| --- | --------------------------------------------- | --- | ------------------------------ | --- | --- | --- | --- |
| ... | additionalargumentspassedtoref_gridandemmeans |     |                                |     |     |     |     |
delta,ctr argumentsformake.meanintandmake.symmint. deltasetsthedistanceeach
sideofthecenter,sothatthewidthoftheintervalis2*delta.
npts
numberofpointstoincludeintheinterval
| x   | argumentformeanintandsymmint |     |     |     |     |     |     |
| --- | ---------------------------- | --- | --- | --- | --- | --- | --- |
Details
In models with only factors, no covariates, these tests correspond to “type III” tests a la SAS, as
long as equal-weighted averaging is used and there are no estimability issues. When covariates
are present and they interact with factors, the results depend on how the covariate is handled in
constructing the reference grid. See the section on covariates below. The point that one must
alwaysrememberisthatjoint_testsalwaystestscontrastsamongEMMs, inthecontextofthe
referencegrid,whereasSAS’stypeIIItestsaretestsofmodelcoefficients–whichmayormaynot
haveanythingtodowithEMMsorcontrasts.
Value
a summary_emm object (same as is produced by summary.emmGrid). All effects for which there
are no estimable contrasts are omitted from the results. There may be an additional row named

56 joint_tests
(confounded) which accounts for additional degrees of freedom for effects not accounted for in
theprecedingrows.
The returned object also includes an "est.fcns" attribute, which is a named list containing the
linearfunctionsassociatedwitheachjointtest. Eachrowoftheseisstandardizedtohavelength1.
Noestimablefunctionsareincludedforconfoundedeffects.
make.meanintreturnsthefunctionfunction(x)mean(x)+delta*c(-1,1),andmake.symmint(ctr,
delta)returnsthefunctionfunction(x)ctr+delta*c(-1,1)(whichdoesnotdependonx).
Thecaseswithdelta=1,meanint=make.meanint(1)andsymmint(ctr)=make.symmint(ctr,
1)areretainedforback-compatibilityreasons. Thesefunctionsareavailableprimarilyforusewith
cov.reduce.
Dealingwithcovariates
Acovariate(oranyotherpredictor)musthavemorethanonevalueinthereferencegrid inorder
totestitseffectandbeincludedintheresults. Therefore, whenobjectisamodel, wedefaultto
cov.reduce=meanintwhichsetseachcovariateatasymmetricintervalaboutitsmean. Butwhen
objectisanexistingreferencegrid,itoftenhasonlyonevalueforcovariates,inwhichcasethey
areexcludedfromthejointtests.
Whilehavingtwopointsissufficientwhenthecovariatetermhasalineartrend,youneedmorethan
two when some kind of curved trend (polynomial, spline, etc.) is present – else joint_tests()
willnotshowenoughdegreesoffreedomfortermsinvolvingthecovariate. Youmayspecifythese
pointsmanuallyusingat,orbyincludingannptsargumentincov.reduce,viamake.meanintor
make.symmint(). Withsomekindsofcurvedtrends,thejointtestsofcovariatetermsmaybecome
somewhatmeaningless.
Covariatespresentfurthercomplicationsinthattheirvaluesinthereferencegridcanaffectthejoint
testsofothereffects. Whencovariatesarecenteredaroundtheirmeans(thedefault),thenthetests
weobtaincanbedescribedasjointtestsofcovariate-adjustedmeans; andthatisourintendeduse
here. However, some software such as SAS and car::Anova adopt the convention of centering
covariatesaroundzero;andforthatpurpose,onecanusecov.reduce=symmint(0)whencalling
withamodelobject(orinconstructingareferencegrid). However,adjustedmeanswithcovariates
set at or around zero do not make much sense in the context of interpreting estimated marginal
means,unlessthecovariatemeansreallyarezero.
Seetheexamplesbelowwiththetoydataset.
Note
joint_testsisflakywithmodelshavingnestedfixedeffects. Insomecases,termsthatcouldbe
relevantarenotidentified,orconfoundedwithunidentifiableterms.
SeeAlso
test
Examples
pigs.lm <- lm(log(conc) ~ source * factor(percent), data = pigs)
(jt <- joint_tests(pigs.lm)) ## will be same as type III ANOVA

joint_tests 57
### Estimable functions associated with "percent"
attr(jt, "est.fcns") $ "percent"
joint_tests(pigs.lm, weights = "outer") ## differently weighted
joint_tests(pigs.lm, by = "source") ## separate joint tests of 'percent'
### Comparisons with type III tests in SAS
toy = data.frame(
treat = rep(c("A", "B"), c(4, 6)),
female = c(1, 0, 0, 1, 0, 0, 0, 1, 1, 0 ),
resp = c(17, 12, 14, 19, 28, 26, 26, 34, 33, 27))
toy.fac = lm(resp ~ treat * factor(female), data = toy)
toy.cov = lm(resp ~ treat * female, data = toy)
# (These two models have identical fitted values and residuals)
# -- SAS output we'd get with toy.fac --
## Source DF Type III SS Mean Square F Value Pr > F
## treat 1 488.8928571 488.8928571 404.60 <.0001
## female 1 78.8928571 78.8928571 65.29 0.0002
## treat*female 1 1.7500000 1.7500000 1.45 0.2741
#
# -- SAS output we'd get with toy.cov --
## Source DF Type III SS Mean Square F Value Pr > F
## treat 1 252.0833333 252.0833333 208.62 <.0001
## female 1 78.8928571 78.8928571 65.29 0.0002
## female*treat 1 1.7500000 1.7500000 1.45 0.2741
joint_tests(toy.fac)
joint_tests(toy.cov) # female is regarded as a 2-level factor by default
## Treat 'female' as a numeric covariate (via cov.keep = 0)
## ... then tests depend on where we center things
# Center around the mean
joint_tests(toy.cov, cov.keep = 0, cov.reduce = make.meanint(delta = 1))
# Center around zero (like SAS's results for toy.cov)
joint_tests(toy.cov, cov.keep = 0, cov.reduce = make.symmint(ctr = 0, delta = 1))
# Center around 0.5 (like SAS's results for toy.fac)
joint_tests(toy.cov, cov.keep = 0, cov.reduce = range)
### Example with empty cells and confounded effects
low3 <- unlist(attr(ubds, "cells")[1:3])
ubds.lm <- lm(y ~ A*B*C, data = ubds, subset = -low3)
# Show overall joint tests by C:
ref_grid(ubds.lm, by = "C") |> contrast("consec") |> test(joint = TRUE)
# Break each of the above into smaller components:
joint_tests(ubds.lm, by = "C")

58 lsmeans
lsmeans WrappersforalternativenamingofEMMs
Description
These are wrappers for emmeans and related functions to provide backward compatibility, or for
userswhomayprefertouseotherterminologythan“estimatedmarginalmeans”–namely“least-
squaresmeans”. Thesefunctionsalsoprovidethefunctionalityformerlyprovidedbythelsmeans
package,whichisnowjustafront-endforemmeans.
Usage
lsmeans(...)
lstrends(...)
lsmip(...)
lsm(...)
lsmobj(...)
lsm.options(...)
get.lsm.option(x, default = emm_defaults[[x]])
Arguments
... Argumentspassedtothecorrespondingemxxxxfunction
x Characternameofdesiredoption
default defaultvaluetoreturnifxnotfound
Details
Foreachfunctionwithlsxxxxinitsname,thesamefunctionnamedemxxxxiscalled.Anyestimator
namesorlistitemsbeginningwith“em”arereplacedwith“ls”beforetheresultsarereturned
Value
Theresultofthecalltoemxxxx,suitablymodified.
get.lsm.option and lsm.options remap options from and to corresponding options in the em-
meansoptionssystem.
SeeAlso
emmeans,emtrends,emmip,emm,emmobj,emm_options,get_emm_option

make.tran 59
Examples
pigs.lm <- lm(log(conc) ~ source + factor(percent), data = pigs)
lsmeans(pigs.lm, "source")
make.tran Response-transformationextensions
Description
Themake.tranfunctioncreatestheneededinformationtoperformtransformationsoftheresponse
variable,includinginvertingthetransformationandestimatingvariancesofback-transformedpre-
dictions via the delta method. make.tran is similar to make.link, but it covers additional trans-
formations. Theresultcanbeusedasanenvironmentinwhichthemodelisfitted, orasthetran
argument in update.emmGrid (when the given transformation was already applied in an existing
model).
Usage
make.tran(type = c("genlog", "power", "boxcox", "sympower", "asin.sqrt",
"atanh", "bcnPower", "scale"), alpha = 1, beta = 0, param, y, inner, ...)
inverse(y)
Arguments
type Thenameofastandardtransformationsupportedbystat::make.link,orofa
specialtransformationdescribedunderDetails.
alpha,beta Numericparametersneededforspecialtransformations.
param If non-missing, this specifies either alpha or c(alpha,beta) (provided for
backwardcompatibility). Also,forthesamereason,ifalphaisoflengthmore
than1,itistakenasparam.
y A numeric response variable used (and required) with type="scale", where
scale(y)determinesalphaandbeta.
inner anothertransformation. Seethesectiononcompoundtransformations
... Additionalargumentspassedtootherfunctions/methods
Value
Alisthavingatleastthesameelementsasthosereturnedbymake.link.Thelinkfuncomponent
is the transformation itself. Each of the functions is associated with an environment where any
parametervaluesaredefined.
inversereturnsthereciprocalofitsargument. Itallowsthe"inverse"linktobeauto-detectedas
aresponsetransformation.

60 make.tran
Details
The make.tran function returns a suitable list of functions for several popular transformations.
Besidesbeingusablewithupdate,theusermayusethislistasanenclosingenvironmentinfitting
themodelitself,inwhichcasethetransformationisauto-detectedwhenthespecialnamelinkfun
(thetransformationitself)isusedastheresponsetransformationinthecall.Seetheexamplesbelow.
Theprimarypurposeofmake.tranistosupporttransformationsthatrequireadditionalparameters,
specified as alpha and beta; these are the onse shown in the argument-matching list. However,
standard transformations supported by stats::make.link are also supported. In the following
discussionofonesrequiringparameters,weuseαandβtodenotealphaandbeta,andytodenote
theresponsevariable. Thetypeargumentspecifiesthefollowingtransformations:
"genlog" Generalizedlogarithmictransformation:log (y+α),wherey >−α. Whenβ =0(the
β
default),weuselog (y+α)
e
"power" Powertransformation: (y−β)α,wherey >β. Whenα=0,log(y−β)isusedinstead.
"boxcox" The Box-Cox transformation (unscaled by the geometric mean): ((y − β)α − 1)/α,
wherey >β. Whenα=0,log(y−β)isused.
"sympower" Asymmetrizedpowertransformationonthewholerealline: |y−β|α·sign(y−β).
There are no restrictions on y, but we require α > 0 in order for the transformation to be
monotoneandcontinuous.
"asin.sqrt" Arcsin-square-roottransformation: sin−1(y/α)1/2. Typically, alphawillbeeither
1(default)or100.
"atanh" Arctanhtransformation:tanh−1(y/α). Typically,alphawillbeeither1(default)or100.
"bcnPower" Box-Cox with negatives allowed, as described for the bcnPower function in the car
package. It is defined as the Box-Cox transformation (zα −1)/α of the variable z = y +
(y2+β2)1/2. Notethatthisrequiresbothparametersandthatbeta>0.
"scale" Thisoneisalittledifferentthantheothers,inthatalphaandbetaareignored;instead,
theyaredeterminedbycallingscale(y,...).Theusershouldgiveasytheresponsevariable
inthemodeltobefittedtoitsscaledversion.
Notethatwiththe"power", "boxcox", or"sympower"transformations, theargumentbetaspec-
ifies a location shift. In the "genpower" transformation, beta specifies the base of the logarithm
– however, quirkily, the default of beta=0 is taken to be the natural logarithm. For example,
make.tran(0.5,10)setsupthelog (y+ 1)transformation. Inthe"bcnPower"transformation,
10 2
betamustbespecifiedasapositivevalue.
Forpurposesofback-transformation,the‘sqrt(y)+sqrt(y+1)’transformationistreatedexactly
√
thesamewayas‘2*sqrt(y)’,becausebothareregardedasestimatesof2 µ.
Caseswheremake.tranmaynotbeneeded
Forstandardtransformationswithnoparameters,weusuallydon’tneedtousemake.tran;justthe
nameofthetransformationisallthatisneeded.Thefunctionsemmeans,ref_grid,andrelatedones
automaticallydetectresponsetransformationsthatarerecognizedbyexaminingthemodelformula.
These are log, log2, log10, log1p, sqrt, logit, probit, cauchit, cloglog; as well as (for a
responsevariabley)asin(sqrt(y)),asinh(sqrt(y)),atanh(y),andsqrt(y)+sqrt(y+1). In
addition,anyconstantmultipleofthese(e.g.,2*sqrt(y))isauto-detectedandappropriatelyscaled
(seealsothetran.multargumentinupdate.emmGrid).

make.tran 61
Afewadditionaltransformationsmaybespecifiedascharacterstringsandareauto-detected:"identity",
"1/mu^2","inverse","reciprocal","log10","log2","asin.sqrt","asinh.sqrt",and"atanh".
Compoundtransformations
Atransformationthatisafunctionofanotherfunctioncanbecreatedbyspecifyinginnerforthe
√
otherfunction.Forexample,thetransformation1/ ycanbecreatedeitherbymake.tran("inverse",
| inner="sqrt") |     | make.tran("power",-0.5). |     |     |     |               |     |                 |             |
| ------------- | --- | ------------------------ | --- | --- | --- | ------------- | --- | --------------- | ----------- |
|               | or  | by                       |     |     |     | In principle, |     | transformations | can be com- |
poundedtoanydepth. Also,iftypeis"scale",yisreplacedbyinner$linkfun(y),becausethat
willbethevariablethatisscaled.
Note
Thegenlogtransformationistechnicallyunneeded,becausearesponsetransformationoftheform
log(y+c)isnowauto-detectedbyref_grid.
make.link
We modify certain results in transformations where there is a restriction on valid pre-
dictionvalues,sothatreasonableinversepredictionsareobtained,nomatterwhat. Forexample,if
asqrttransformationwasusedbutapredictedvalueisnegative,theinversetransformationiszero
rather than the square of the prediction. A side effect of this is that it is possible for one or both
confidencelimits,orevenastandarderror,tobezero.
Examples
| # Fit a model              | using                             | an oddball     | transformation:           |             |                     |         |                 |              |     |
| -------------------------- | --------------------------------- | -------------- | ------------------------- | ----------- | ------------------- | ------- | --------------- | ------------ | --- |
| bctran <-                  | make.tran("boxcox",               |                | 0.368)                    |             |                     |         |                 |              |     |
| warp.bc <-                 | with(bctran,                      |                |                           |             |                     |         |                 |              |     |
| lm(linkfun(breaks)         |                                   | ~              | wool * tension,           |             | data = warpbreaks)) |         |                 |              |     |
| # Obtain                   | back-transformed                  |                | LS means:                 |             |                     |         |                 |              |     |
| emmeans(warp.bc,           | ~                                 | tension        | | wool,                   | type =      | "response")         |         |                 |              |     |
| ### Using                  | a scaled                          | response...    |                           |             |                     |         |                 |              |     |
| # Case where               | it is                             | auto-detected: |                           |             |                     |         |                 |              |     |
| mod <- lm(scale(yield[,    |                                   | 1])            | ~ Variety,                | data        | = MOats)            |         |                 |              |     |
| emmeans(mod,               | "Variety",                        | type           | = "response")             |             |                     |         |                 |              |     |
| # Case where               | scaling                           | is not         | auto-detected             |             | -- and              | what to | do about        | it:          |     |
| copt <- options(contrasts  |                                   |                | = c("contr.sum",          |             | "contr.poly"))      |         |                 |              |     |
| mod.aov <-                 | aov(scale(yield[,                 |                | 1]) ~                     | Variety     | + Error(Block),     |         | data            | = MOats)     |     |
| emm.aov <-                 | suppressWarnings(emmeans(mod.aov, |                |                           |             | "Variety",          |         | type =          | "response")) |     |
| # Scaling                  | was not retrieved,                |                | but we                    | can do:     |                     |         |                 |              |     |
| emm.aov <-                 | update(emm.aov,                   |                | tran = make.tran("scale", |             |                     | y       | = MOats$yield[, | 1]))         |     |
| emmeans(emm.aov,           | "Variety",                        |                | type =                    | "response") |                     |         |                 |              |     |
| ### Compound               | transformations                   |                |                           |             |                     |         |                 |              |     |
| # The following            | amount                            | to             | the same                  | thing:      |                     |         |                 |              |     |
| t1 <- make.tran("inverse", |                                   |                | inner =                   | "sqrt")     |                     |         |                 |              |     |
| t2 <- make.tran("power",   |                                   |                | -0.5)                     |             |                     |         |                 |              |     |
options(copt)

62 MOats
## Not run:
### An existing model 'mod' was fitted with a y^(2/3) transformation...
ptran = make.tran("power", 2/3)
emmeans(mod, "treatment", tran = ptran)
## End(Not run)
pigs.lm <- lm(inverse(conc) ~ source + factor(percent), data = pigs)
emmeans(pigs.lm, "source", type = "response")
MOats Oatsdatainmultivariateform
Description
This is the Oats dataset provided in the nlme package, but it is rearranged as one multivariate
observationperplot.
Usage
data(MOats)
Format
Adataframewith18observationsand3variables
Variety afactorwithlevelsGoldenRain,Marvellous,Victory
Block anorderedfactorwithlevelsVI<V<III<IV<II<I
yield amatrixwith4columns,givingtheyieldswithnitrogenconcentrationsof0,.2,.4,and.6.
Details
Thesedataarisefromasplit-plotexperimentreportedbyYates(1935)andusedasanexamplein
PinheiroandBates(2000)andothertexts.Sixblocksweredividedintothreewholeplots,randomly
assigned to the three varieties of oats. The whole plots were each divided into 4 split plots and
randomizedtothefourconcentrationsofnitrogen.
Source
ThedatasetOatsinthenlmepackage.
References
Pinheiro,J.C.andBatesD.M.(2000)Mixed-EffectsModelsinSandS-PLUS,Springer,NewYork.
(AppendixA.15)
Yates,F.(1935)Complexexperiments,JournaloftheRoyalStatisticalSocietySuppl. 2,181-247

| models |     |     |     |     |     |     |     |     | 63  |
| ------ | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Examples
| MOats.lm          | <- lm (yield | ~ Block    | +          | Variety,  | data | = MOats) |     |     |     |
| ----------------- | ------------ | ---------- | ---------- | --------- | ---- | -------- | --- | --- | --- |
| MOats.rg          | <- ref_grid  | (MOats.lm, |            | mult.name | =    | "nitro") |     |     |     |
| emmeans(MOats.rg, | ~            | nitro      | | Variety) |           |      |          |     |     |     |
models
Modelssupportedinemmeans
Description
Documentationformodelshasbeenmovedtoavignette. Toaccessit, usevignette("models",
"emmeans").
| mvcontrast |     | Multivariatecontrasts |     |     |     |     |     |     |     |
| ---------- | --- | --------------------- | --- | --- | --- | --- | --- | --- | --- |
Description
Thisfunctiondisplaystestsofmultivariatecomparisonsorcontrasts. Thecontrastsareconstructed
at each level of the variable in mult.name, and then we do a multivariate test that the vector of
estimatesisequaltonull(zerobydefault).
TheFstatisticanddegreesoffreedomaredetermined
via the Hotelling distribution. that is, if there are m error degrees of freedom and multivariate
dimensionalityd,thentheresultingF statistichasdegreesoffreedom(d,m−d+1)asshownin
Hotelling(1931).
Usage
mvcontrast(object, method = "eff", mult.name = object@roles$multresp,
| null               | = 0, by = | object@misc$by.vars, |     |          | adjust | =    | c("sidak", |     |     |
| ------------------ | --------- | -------------------- | --- | -------- | ------ | ---- | ---------- | --- | --- |
| p.adjust.methods), |           | show.ests            |     | = FALSE, |        | ...) |            |     |     |
Arguments
| object | AnobjectofclassemmGrid              |     |     |     |     |     |     |     |     |
| ------ | ----------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
| method | Acontrastmethod,percontrast.emmGrid |     |     |     |     |     |     |     |     |
mult.name Character vector of names of the factors whose levels define the multivariate
|     | meanstocontrast. |     |     | Ifthemodelitselfhasamultivariateresponse,thatiswhatis |     |     |     |     |     |
| --- | ---------------- | --- | --- | ----------------------------------------------------- | --- | --- | --- | --- | --- |
Otherwise,mult.namemustbespecified.
used.
null
Scalarorconformablevectorofnull-hypothesisvaluestotestagainst
| by  |     | by           |     |       |        |     |         |                       |            |
| --- | --- | ------------ | --- | ----- | ------ | --- | ------- | --------------------- | ---------- |
|     | Any | variable(s). |     | These | should | not | include | the primary variables | to be con- |
by
|     | trasted. | For | convenience, |     | the | variable | is nulled-out | if it would | result in no |
| --- | -------- | --- | ------------ | --- | --- | -------- | ------------- | ----------- | ------------ |
primaryfactorsbeingcontrasted.
adjust Charactervalueofamultiplicityadjustmentmethod("none"fornoadjustment).
|     | The | available | adjustment |     | methods | are | more limited | that in contrast, | and any |
| --- | --- | --------- | ---------- | --- | ------- | --- | ------------ | ----------------- | ------- |
defaultadjustmentreturnedviamethodisignored.
show.ests
Logicalflagdeterminingwhetherthemultivariatemeansaredisplayed
| ... | Additionalargumentspassedtocontrast |     |     |     |     |     |     |     |     |
| --- | ----------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |

64 mvregrid
Value
Anobjectofclasssummary_emmcontainingthemultivariatetestresults;oralistoftheestimatesand
thetestsifshow.estsisTRUE.ThetestresultsincludetheHotellingT2 statistic,F ratios,degrees
| offreedom,andP | values. |     |     |     |     |     |
| -------------- | ------- | --- | --- | --- | --- | --- |
Note
If some interactions among the primary and mult.name factors are absent, the covariance of the
multivariatemeansissingular; thissituationisaccommodated, buttheresulthasreduceddegrees
offreedomandamessageisdisplayed.Ifthereareotherabnormalconditionssuchasnon-estimable
results,estimatesareshownasNA.
While designed primarily for testing contrasts, multivariate tests of the mean vector itself can be
implementedviamethod="identity")(seetheexamples).
References
Hotelling,Harold(1931)"ThegeneralizationofStudent’sratio",AnnalsofMathematicalStatistics
| 2(3),360–378. | doi:10.1214/aoms/1177732979 |     |     |     |     |     |
| ------------- | --------------------------- | --- | --- | --- | --- | --- |
Examples
| MOats.lm  | <- lm(yield          | ~ Variety | +   | Block,  | data =      | MOats) |
| --------- | -------------------- | --------- | --- | ------- | ----------- | ------ |
| MOats.emm | <- emmeans(MOats.lm, |           | ~   | Variety | | rep.meas) |        |
mvcontrast(MOats.emm, "consec", show.ests = TRUE) # mult.name defaults to rep.meas
| # Test                | each mean against |             | a specified | null  | vector       |           |
| --------------------- | ----------------- | ----------- | ----------- | ----- | ------------ | --------- |
| mvcontrast(MOats.emm, |                   | "identity", |             | name  | = "Variety", |           |
|                       | null =            | c(80, 100,  | 120,        | 140), | adjust       | = "none") |
# (Note 'name' is passed to contrast() and overrides default name "contrast")
| # 'mult.name'         | need | not refer              | to a | multivariate |     | response     |
| --------------------- | ---- | ---------------------- | ---- | ------------ | --- | ------------ |
| mvcontrast(MOats.emm, |      | "trt.vs.ctrl1",        |      | mult.name    |     | = "Variety") |
| mvregrid              |      | Multivariateregridding |      |              |     |              |
Description
Thisfunctionissimilartoregridexceptitperformsamultivariatetransformation. Thisisuseful,
forinstance,inmultivariatemodelsthathaveacompositionalresponse.
Usage
mvregrid(object, transform = "response", mult.name, newname = mult.name,
| newlevs, | fcn, | ...) |     |     |     |     |
| -------- | ---- | ---- | --- | --- | --- | --- |

neuralgia 65
Arguments
object AnemmGridobject
transform Thetransformationtouseinre-gridding. If"response",weapplytheinverse
ofthemultivariatetransformationinobject@misc$tran;otherwise,were-grid
as if transform had been applied to the multivariate response. (Note that this
willentailfirstre-griddingtotheresponsescaleifnecessary.)
mult.name The name of the multivariate factor to be transformed. If missing, we use
object@roles$multresp,andthrowanerrormessageifitisNULLorambigu-
ous;inthatcase,theusermustrepeatthecallwithmult.namespecified.
newname thenametobegiventothenewlytransformedvariable
newlevs levelsofthenewlycreatedfactor(mustconformtothenumberofcolumnscre-
atedbyfcn).Ifmissing,weusethecolumnnamesofthenewlycreatedvariable.
fcn Themultivariatefunctiontoapply. Ifcharacter,welookforitinthenamespace
ofthecompositionspackage.
... Additionalargumentspassedtofcn
Details
If a multivariate response transformation was used in fitting the model, its name is auto-detected,
andinthatcaseweneednotspecifyfcnaslongasitsinversecanbefoundinthenamespaceofthe
compositions package. (That package need not be installed unless fcn is a character value.) For
some such models, auto-detection process throws a warning message, especially if cbind is also
presentinthemodelformula.
Currently,nobias-adjustmentoptionisavailable.
Value
AnewemmGridobjectwiththenewlycreatedfactorasitslastfactor
Examples
if(requireNamespace("compositions"))
emm_example("mvregrid")
# Use emm_example("mvregrid", list = TRUE) # to see just the code
neuralgia Neuralgiadata
Description
Thesedataarisefromastudyofanalgesiceffectsoftreatmentsofelderlypatientswhohaveneu-
ralgia. Two treatments and a placebo are compared. The response variable is whether the patient
reportedpainornot.Researchersrecordedtheageandgenderof60patientsalongwiththeduration
ofcomplaintbeforethetreatmentbegan.

66 nutrition
Usage
data(neuralgia)
Format
Adataframewith60observationsand5variables:
| Treatment | Factorwith3levelsA,B,andP.Thelatterisplacebo |     |     |     |     |
| --------- | -------------------------------------------- | --- | --- | --- | --- |
Sex FactorwithtwolevelsFandM
Age Numericcovariate–patient’sageinyears
Duration
Numericcovariate–durationoftheconditionbeforebeginningtreatment
Pain BinaryresponsefactorwithlevelsNoandYes
Source
Cai,Weijie(2014)MakingComparisonsFair:HowLS-MeansUnifytheAnalysisofLinearModels,
http://support.sas.com/resources/
| SAS Institute, | Inc. | Technical | paper 142-2014, | page | 12, |
| -------------- | ---- | --------- | --------------- | ---- | --- |
papers/proceedings14/SAS060-2014.pdf
Examples
| # Model                      | and analysis | shown         | in the        | SAS report:  |                      |
| ---------------------------- | ------------ | ------------- | ------------- | ------------ | -------------------- |
| neuralgia.glm                | <-           | glm(Pain      | ~ Treatment   | * Sex + Age, | family = binomial(), |
| data                         | = neuralgia) |               |               |              |                      |
| pairs(emmeans(neuralgia.glm, |              |               | ~ Treatment,  | at =         | list(Sex = "F")),    |
| reverse                      | = TRUE,      | type          | = "response", | adjust =     | "bonferroni")        |
| nutrition                    |              | Nutritiondata |               |              |                      |
Description
Thisobservationaldatasetinvolvesthreefactors,butwhereseveralfactorcombinationsaremissing.
ItisusedasacasestudyinMillikenandJohnson,Chapter17,p.202. (Youmayalsofinditinthe
secondedition,p.278.)
Usage
data(nutrition)

oranges 67
Format
Adataframewith107observationsand4variables:
| age afactorwithlevels1,2,3,4. |     | Mother’sagegroup. |        |
| ----------------------------- | --- | ----------------- | ------ |
| group                         |     | FoodStamps,       | NoAid. |
a factor with levels Whether or not the family receives food stamp
assistance.
race afactorwithlevelsBlack,Hispanic,White. Mother’srace.
gain
anumericvector(theresponsevariable). Gainscore(posttestminuspretest)onknowledge
ofnutrition.
Details
Asurveywasconductedbyhomeeconomists“tostudyhowmuchlower-socioeconomic-levelmoth-
ers knew about nutrition and to judge the effect of a training program designed to increase their
| knowledgeofnutrition.” |     | Thisisamessydatasetwithseveralemptycells. |     |
| ---------------------- | --- | ----------------------------------------- | --- |
Source
Milliken, G. A. and Johnson, D. E. (1984) Analysis of Messy Data – Volume I: Designed Experi-
ments. VanNostrand,ISBN0-534-02713-7.
Examples
| nutr.aov        | <- aov(gain          | ~ (group + age | + race)^2, data = nutrition) |
| --------------- | -------------------- | -------------- | ---------------------------- |
| # Summarize     | predictions          | for age group  | 3                            |
| nutr.emm        | <- emmeans(nutr.aov, | ~ race         | * group, at = list(age="3")) |
| emmip(nutr.emm, | race                 | ~ group)       |                              |
# Hispanics seem exceptional; but this doesn't test out due to very sparse data
| pairs(nutr.emm, | by = | "group") |     |
| --------------- | ---- | -------- | --- |
| pairs(nutr.emm, | by = | "race")  |     |
oranges
Salesoforanges
Description
Thisexampledatasetonsalesoforangeshastwofactors,twocovariates,andtworesponses. There
isoneobservationperfactorcombination.
Usage
data(oranges)

68 pigs
Format
Adataframewith36observationsand6variables:
store afactorwithlevels123456.
Thestorethatwasobserved.
day afactorwithlevels123456. Thedaytheobservationwastaken(sameforeachstore).
price1
| anumericvector.        |     |     | Priceofvariety1. |     |     |     |
| ---------------------- | --- | --- | ---------------- | --- | --- | --- |
| price2 anumericvector. |     |     | Priceofvariety2. |     |     |     |
sales1
| anumericvector.        |     |     | Sales(percustomer)ofvariety1. |     |     |     |
| ---------------------- | --- | --- | ----------------------------- | --- | --- | --- |
| sales2 anumericvector. |     |     | Sales(percustomer)ofvariety2. |     |     |     |
Source
Thisis(oroncewas)availableasaSASsampledataset.
References
Littell,R.,StroupW.,Freund,R.(2002)SASForLinearModels(4thedition).
SASInstitute. ISBN
1-59047-023-0.
Examples
| # Example           | on p.244         | of Littell | et               | al.      |                                |              |
| ------------------- | ---------------- | ---------- | ---------------- | -------- | ------------------------------ | ------------ |
| oranges.lm          | <- lm(sales1     |            | ~ price1*day,    | data     | = oranges)                     |              |
| emmeans(oranges.lm, |                  | "day")     |                  |          |                                |              |
| # Example           | on p.246         | of Littell | et               | al.      |                                |              |
| emmeans(oranges.lm, |                  | "day",     | at = list(price1 |          | = 0))                          |              |
| # A more            | sensible         | model      | to consider,     | IMHO     | (see vignette("interactions")) |              |
| org.mlm <-          | lm(cbind(sales1, |            | sales2)          | ~ price1 | * price2 +                     | day + store, |
data = oranges)
pigs
Effectsofdietaryproteinonfreeplasmaleucineconcentrationinpigs
Description
Atwo-factorexperimentwithsomeobservationslost
Usage
data(pigs)

plot.emmGrid 69
Format
Adataframewith29observationsand3variables:
source Sourceofproteininthediet(factorwith3levels:fishmeal,soybeanmeal,driedskimmilk)
| percent | Proteinpercentageinthediet(numericwith4values: |     |     |     | 9,12,15,and18) |     |
| ------- | ---------------------------------------------- | --- | --- | --- | -------------- | --- |
conc Concentrationoffreeplasmaleucine,inmcg/ml
Source
Windels HF (1964) PhD thesis, Univ. of Minnesota. (Reported as Problem 10.8 in Oehlert G
(2000)AFirstCourseinDesignandAnalysisofExperiments,licensedunderCreativeCommons,
http://users.stat.umn.edu/~gary/Book.html.) Observations 7, 22, 23, 31, 33, and 35 have
beenomitted,creatingamorenotableimbalance.
Examples
| pigs.lm          | <- lm(inverse(conc) |                                  | ~ source + factor(percent), |     | data | = pigs) |
| ---------------- | ------------------- | -------------------------------- | --------------------------- | --- | ---- | ------- |
| emmeans(pigs.lm, | "source")           |                                  |                             |     |      |         |
| plot.emmGrid     |                     | PlotanemmGridorsummary_emmobject |                             |     |      |         |
Description
Methods are provided to plot EMMs as side-by-side CIs, and optionally to display “comparison
arrows”fordisplayingpairwisecomparisons.
Usage
| ## S3 method | for class       | 'emmGrid'     |               |         |          |            |
| ------------ | --------------- | ------------- | ------------- | ------- | -------- | ---------- |
| plot(x,      | y, type, CIs    | = TRUE,       | PIs = FALSE,  |         |          |            |
| comparisons  | = FALSE,        | colors,       | alpha         | = 0.05, | adjust = | "tukey",   |
| int.adjust   | = "none",       | intervals,    | ...)          |         |          |            |
| ## S3 method | for class       | 'summary_emm' |               |         |          |            |
| plot(x,      | y, horizontal   | = TRUE,       | CIs = TRUE,   | xlab,   | ylab,    |            |
| facetlab     | = "label_both", |               | layout, scale | = NULL, | colors,  | intervals, |
| plotit       | = TRUE, ...)    |               |               |         |          |            |
Arguments
| x   | ObjectofclassemmGridorsummary_emm |     |     |     |     |     |
| --- | --------------------------------- | --- | --- | --- | --- | --- |
y
(Requiredbutignored)

70 plot.emmGrid
type Charactervaluespecifyingthetypeofpredictiondesired(matching"linear.predictor",
"link",or"response"). Seedetailsundersummary.emmGrid. Inaddition,the
user may specify type="scale", in which case a transformed scale (e.g., a
log scale) is displayed based on the transformation or link function used. Ad-
ditionalcustomizationofthisscaleisavailablethroughincludingargumentsto
ggplot2::scale_x_continuousin....
CIs Logicalvalue. IfTRUE,confidenceintervalsareplottedforeachestimate.
PIs Logical value. If TRUE, prediction intervals are plotted for each estimate. If
objectisaBayesianmodel,thisrequiresthe...argumentstoincludefrequentist
=TRUEandsigma=(somevalue). NotethatthePIsoptionisnotavailablewith
summary_emmobjects–onlyforemmGridobjects. Also,predictionintervalsare
notavailablewithengine="lattice".
comparisons Logicalvalue.IfTRUE,“comparisonarrows”areaddedtotheplot,insuchaway
thatthedegreetowhicharrowsoverlapreflectsasmuchaspossiblethesignifi-
canceofthecomparisonofthetwoestimates. (Awarningisissuedifthiscan’t
bedone.) Notethatcomparisonarrowsarenotavailablewith‘summary_emm‘
objects.
colors Optionalcharactervectorofcolorstouseforestimates,CIs,PIs,andcomparison
arrows,respectively. Ifmissing,thesearederivedfromink,paper,andaccent
inthetheme’sgeomelement. inkisusedfortheestimates, accentisusedfor
comparisonarrows,andacontrastingcolortoaccentisblendedwithpaperfor
the intervals. If just one color is given, estimates and intervals are made from
variousblendsofthatcolorandpaper,andaccentcolorisusedforcomparison
arrows.
alpha Thesignificanceleveltouseinconstructingcomparisonarrows
adjust Charactervalue: Multiplicityadjustmentmethodforcomparisonarrowsonly.
int.adjust Charactervalue: Multiplicityadjustmentmethodfortheplottedconfidencein-
tervalsonly.
intervals If specified, it is used to set CIs. This is the previous argument name for CIs
andisprovidedforbackwardcompatibility.
... Additionalargumentspassedtoupdate.emmGrid,summary.emmGrid,predict.emmGrid,
ordotplot
horizontal Logicalvaluespecifyingwhethertheintervalsshouldbeplottedhorizontallyor
vertically
xlab Characterlabelforhorizontalaxis
ylab Characterlabelforverticalaxis
facetlab Characterorfunctionmethodusedtolabelfacetsinamulti-panelplot(withthe
ggplotengine). Defaultis"label_both",meaningthatbothfactornamesand
levelsareshown,Youcanuse"label_value"tosavespace,or"label_context"
todecideautomatically(oftenwrongly).Seethehelppageforggplot2::labellers
layout Numericvaluepassedtodotplotwhenengine=="lattice".
scale Objectofclasstrans(inthescalespackage)tospecifyanonlinearscale. This
isusedinlieuoftype="scale"whenplottingasummary_emmobjectcreated
withtype="response". Thisisignoredwithothertypesofsummaries.
plotit Logicalvalue. IfTRUE,agraphicalobjectisreturned;ifFALSE,adata.frameis
returnedcontainingallthevaluesusedtoconstructtheplot.

plot.emmGrid 71
Value
Ifplotit=TRUE,agraphicalobjectisreturned.
Ifplotit=FALSE,adata.framewiththetableofEMMsthatwouldbeplotted. Inthelattercase,
theestimatebeingplottedisnamedthe.emmean,andanyfactorsinvolvedhavethesamenamesas
in the object. Confidence limits are named lower.CL and upper.CL, prediction limits are named
lpl and upl, and comparison-arrow limits are named lcmpl and ucmpl. There is also a variable
namedpri.facwhichcontainsthefactorcombinationsthatarenotamongthebyvariables.
Details
Ifanybyvariablesareinforce,theplotisdividedintoseparatepanels.For"summary_emm"objects,
the...argumentsinplotarepassedonlytodotplot,whereasfor"emmGrid"objects,theobject
isupdatedusing...beforesummarizingandplotting.
In plots with comparisons=TRUE, the resulting arrows are only approximate, and in some cases
mayfailtoaccuratelyreflectthepairwisecomparisonsoftheestimates–especiallywhenestimates
havinglargeandsmallstandarderrorsareintermingledinjustthewrongway. Notethatthemaxi-
mumandminimumestimateshavearrowsonlyinonedirection,sincethereisnoneedtocompare
themwithanythinghigherorlower,respectively.Seethevignette("xplanations","emmeans")
fordetailsonhowthesearederived.
If adjust or int.adjust are not supplied, they default to the internal adjust setting saved in
pairs(x)andxrespectively(seeupdate.emmGrid).
Note
Inordertoplaynicewiththeplottingfunctions,anyvariablenamesthatarenotsyntacticallycorrect
(e.g.,containspaces)arealteredusingmake.names.
Examples
warp.lm <- lm(breaks ~ wool * tension, data = warpbreaks)
warp.emm <- emmeans(warp.lm, ~ tension | wool)
plot(warp.emm)
plot(warp.emm, PIs = TRUE, comparisons = TRUE)
with_emm_options(gg.theme = ggplot2::theme_dark(),
plot(warp.emm, PIs = TRUE, comparisons = TRUE))
plot(warp.emm, by = NULL, comparisons = TRUE, adjust = "none",
horizontal = FALSE, colors = "blue")
### Using a transformed scale (also demonstrating 'facetlab' argument)
pigs.lm <- lm(log(conc + 2) ~ source * factor(percent), data = pigs)
pigs.emm <- emmeans(pigs.lm, ~ percent | source)
plot(pigs.emm, type = "scale", breaks = seq(20, 100, by = 10),
facetlab = "label_value")
# Based on a summary.
# To get a transformed axis, must specify 'scale'; but it does not necessarily

| 72            |                   |                                            |        |             |                |           |     |     | pwpm |
| ------------- | ----------------- | ------------------------------------------ | ------ | ----------- | -------------- | --------- | --- | --- | ---- |
| # have to     | be the            | same as the                                | actual | response    | transformation |           |     |     |      |
| pigs.ci <-    | confint(pigs.emm, |                                            | type = | "response") |                |           |     |     |      |
| plot(pigs.ci, | scale             | = scales::log10_trans(),                   |        |             |                |           |     |     |      |
| facetlab      | = \(x)            | ggplot2::label_both(x,                     |        |             | sep            | = " = ")) |     |     |      |
| pwpm          |                   | PairwiseP-valuematrix(plusotherstatistics) |        |             |                |           |     |     |      |
Description
Thisfunctionpresentsresultsfromemmeansandpairwisecomparisonsthereofinacompactway. It
displaysamatrix(ormatrices)ofestimates,pairwisedifferences,andPvalues.Theusermayoptto
excludeanyoftheseviaargumentsmeans,diffs,andpvals,respectively.
Tocontrolthedirection
ofthepairwisedifferences,usereverse;andtocontrolwhatappearsintheupperandlowertrian-
gle(s),useflip. Optionalargumentsarepassedtocontrast.emmGridand/orsummary.emmGrid,
makingitpossibletocontrolwhatestimatesandtestsaredisplayed.
Usage
| pwpm(emm, | by, reverse | = FALSE,      | pvals   |     | = TRUE, | means | = TRUE, |     |     |
| --------- | ----------- | ------------- | ------- | --- | ------- | ----- | ------- | --- | --- |
| diffs     | = TRUE,     | flip = FALSE, | digits, |     | ...)    |       |         |     |     |
Arguments
| emm |     | AnemmGridobject |     |     |     |     |     |     |     |
| --- | --- | --------------- | --- | --- | --- | --- | --- | --- | --- |
by
|     |     | Character vector                                      | of  | variable(s) | in      | the grid | to condition       | on. These will    | create |
| --- | --- | ----------------------------------------------------- | --- | ----------- | ------- | -------- | ------------------ | ----------------- | ------ |
|     |     | differentmatrices,oneforeachlevelorlevel-combination. |     |             |         |          |                    | Ifmissing,byisset |        |
|     |     | to emm@misc$by.vars.                                  |     | Grid        | factors | not in   | by are the primary | factors:          | whose  |
levelsorlevelcombinationsarecomparedpairwise.
reverse Logical value passed to pairs.emmGrid. Thus, FALSE specifies "pairwise"
|       |     | comparisons(earliervs. |       | later),andTRUEspecifies"revpairwise"comparisons |          |             |             |              |     |
| ----- | --- | ---------------------- | ----- | ----------------------------------------------- | -------- | ----------- | ----------- | ------------ | --- |
|       |     | (latervs. earlier).    |       |                                                 |          |             |             |              |     |
| pvals |     |                        | TRUE, |                                                 |          |             |             |              |     |
|       |     | Logical value.         | If    | the                                             | pairwise | differences | of the EMMs | are included | in  |
eachmatrixaccordingtoflip.
means Logical value. If TRUE, the estimated marginal means (EMMs) from emm are
includedinthematrixdiagonal(s).
diffs Logical value. If TRUE, the pairwise differences of the EMMs are included in
eachmatrixaccordingtoflip.
| flip |     |     |     |     |     |     |     |     | FALSE |
| ---- | --- | --- | --- | --- | --- | --- | --- | --- | ----- |
LogicalvaluethatdetermineswherePvaluesanddifferencesareplaced.
placesthePvaluesintheuppertriangleanddifferencesinthelower,andTRUE
doesjusttheopposite.
digits
|     |     | Integer. Numberofdigitstodisplay. |     |     |     | Ifmissing,anoptimalnumberofdigitsis |     |     |     |
| --- | --- | --------------------------------- | --- | --- | --- | ----------------------------------- | --- | --- | --- |
determined.
... Additionalargumentspassedtocontrast.emmGridandsummary.emmGrid.You
shouldnotincludemethodhere,becausepairwisecomparisonsarealwaysused.

| pwpp |     |     |     |     |     |     |     |     |     | 73  |
| ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Value
Amatrixor‘list‘ofmatrices,oneforeach‘by‘level.
Note
IfemmistheresultofaBayesiananalysis,pwpmisbasedonafrequentistanalysis
SeeAlso
Agraphicaldisplayofessentiallythesameresultsisavailablefrompwpp
Examples
| warp.lm  | <- lm(breaks        | ~ wool | * tension, |         | data    | = warpbreaks) |     |     |     |     |
| -------- | ------------------- | ------ | ---------- | ------- | ------- | ------------- | --- | --- | --- | --- |
| warp.emm | <- emmeans(warp.lm, |        | ~          | tension | | wool) |               |     |     |     |     |
pwpm(warp.emm)
| # use dot      | options | to specify          | noninferiority |        |       | tests       |           |     |     |     |
| -------------- | ------- | ------------------- | -------------- | ------ | ----- | ----------- | --------- | --- | --- | --- |
| pwpm(warp.emm, |         | by = NULL,          | side           | = ">", | delta | = 5, adjust | = "none") |     |     |     |
| pwpp           |         | PairwiseP-valueplot |                |        |       |             |           |     |     |     |
Description
ConstructsaplotofPvaluesassociatedwithpairwisecomparisonsofestimatedmarginalmeans.
Usage
| pwpp(emm, | method | = "pairwise", |     | by, | sort | = TRUE, | values | = TRUE, |     |     |
| --------- | ------ | ------------- | --- | --- | ---- | ------- | ------ | ------- | --- | --- |
rows = ".", xlab, ylab, xsub = "", plim = numeric(0), add.space = 0,
aes, ...)
Arguments
| emm |     | AnemmGridobject |     |     |     |     |     |     |     |     |
| --- | --- | --------------- | --- | --- | --- | --- | --- | --- | --- | --- |
method Character or list. Passed to contrast, and defines the contrasts to be dis-
|     |     | played.                                                 | Any contrast |     | method | may be | used, | provided | that each contrast | in- |
| --- | --- | ------------------------------------------------------- | ------------ | --- | ------ | ------ | ----- | -------- | ------------------ | --- |
|     |     | cludesonecoefficientof1,onecoefficientof-1,andtherest0. |              |     |        |        |       |          | Thatis,calling     |     |
contrast(object,method)producesasetofcomparisons,eachwithonees-
timateminusanotherestimate.
by Character vector of variable(s) in the grid to condition on. These will create
|     |     | different  | panels, | one      | for each | level or     | level-combination. |              | Grid factors | not in   |
| --- | --- | ---------- | ------- | -------- | -------- | ------------ | ------------------ | ------------ | ------------ | -------- |
|     |     | by are the | primary | factors: |          | whose levels | or level           | combinations | are          | compared |
pairwise.

74 pwpp
sort Logical value. If TRUE, levels of the factor combinations are ordered by their
| marginalmeans. | IfFALSE,theyappearinorderbasedontheexistingordering |     |           |     |        |             |     |      |        |
| -------------- | --------------------------------------------------- | --- | --------- | --- | ------ | ----------- | --- | ---- | ------ |
| of the factor  | levels involved.                                    |     | Note that | the | levels | are ordered | the | same | way in |
allpanels,andinmanycasesthisimpliesthatthemeansinanyparticularpanel
willnotbeorderedevenwhensort=TRUE.
values Logicalvalue. IfTRUE,thevaluesoftheEMMsareincludedintheplot. When
by
| there are | several side-by-side |     | panels | due to | variable(s), |     | the | labels | showing |
| --------- | -------------------- | --- | ------ | ------ | ------------ | --- | --- | ------ | ------- |
valuesstartstealingalotofspacefromtheplottingarea;inthosecases,itmay
|              |            | FALSE |        | rows |         |      |        |                |     |
| ------------ | ---------- | ----- | ------ | ---- | ------- | ---- | ------ | -------------- | --- |
| be desirable | to specify |       | or use |      | so that | some | panels | are vertically |     |
stacked.
rows by
| Character | vector of which |     | variable(s) | are | used | to define | rows | of the | panel |
| --------- | --------------- | --- | ----------- | --- | ---- | --------- | ---- | ------ | ----- |
layout. Thosevariablesinbynotincludedinrowsdefinecolumnsinthearray
| of panels. | A "." indicates | that | only | one row | is used, | so  | all panels | are | stacked |
| ---------- | --------------- | ---- | ---- | ------- | -------- | --- | ---------- | --- | ------- |
side-by-side.
xlab CharacterlabeltouseinplaceofthedefaultfortheP-valueaxis.
ylab Characterlabeltouseinplaceofthedefaultfortheprimary-factoraxis.
xsub
Characterlabelusedascaptionatthelowerrightoftheplot.
plim numeric vector of value(s) between 0 and 1. These are included among the
observedpvaluessothattherangeoftickmarksincludesatleasttherangeof
plim. Choosingplim=c(0,1)willensurethewidestpossiblerange.
add.space
| Numeric         | value to adjust | amount      | of space  | used   | for  | value  | labels.   | Positioning | of        |
| --------------- | --------------- | ----------- | --------- | ------ | ---- | ------ | --------- | ----------- | --------- |
| value labels    | is tricky,      | and depends | on        | how    | many | panels | and the   | physical    | size      |
| of the plotting | region.         | This        | parameter | allows | the  | user   | to adjust | the         | position. |
Changingitbyoneunitshouldshiftthepositionbyaboutonecharacterwidth
(rightifpositive,leftifnegative).Notethatthisinteractswithaes$labelbelow.
aes optionalnamedlistoflists. Entriesconsideredarepoint,segment,andlabel,
andcontentsarepassedtotherespectiveggplot2::geom_xxx()functions.These
affectrenderingofpoints,linesegmentsjoiningthem,andvaluelabels.Defaults
arepoint=list(size=2),segment=list(),andlabel=list(size=2.5).
... Additionalargumentspassedtocontrastandsummary.emmGrid,aswellasto
geom_segmentandgeom_label
Details
Factorlevels(orcombinationsthereof)areplottedontheverticalscale,andPvaluesareplottedon
thehorizontalscale. EachPvalueisplottedtwice–atverticalpositionscorrespondingtothelevels
beingcompared–andconnectedbyalinesegment. Thus,itiseasytovisualizewhichPvaluesare
smallandlarge,andwhichlevelsarecompared. Inaddition,factorlevelsarecolor-coded,andthe
pointsandhalf-linesegmentsappearinthecoloroftheotherlevel. TheP-valuescaleisnonlinear,
so as to stretch-out smaller P values and compress larger ones. P values smaller than 0.0004 are
alteredandplottedinawaythatmakesthemmoredistinguishablefromoneanother.
Ifxlab,ylab,andxsubarenotprovided,reasonablelabelsarecreated.xsubisusedtonotespecial
features;e.g.,equivalencethresholdsorone-sidedtests.

qdrg 75
Note
If emm is the result of a Bayesian analysis, the plot is based on summaries with frequentist=
TRUE.
Theggplot2andscalespackagesmustbeinstalledinorderforpwpptowork.
Additionalplotaestheticsareavailablebyaddingthemtothereturnedobject;seetheexamples
SeeAlso
Anumericaldisplayofessentiallythesameresultsisavailablefrompwpm
Examples
| pigs.lm <-             | lm(log(conc) | ~ source  | * factor(percent), |     | data | = pigs) |
| ---------------------- | ------------ | --------- | ------------------ | --- | ---- | ------- |
| emm = emmeans(pigs.lm, |              | ~ percent | | source)          |     |      |         |
pwpp(emm)
| pwpp(emm,            | method         | = "trt.vs.ctrl1",                    | type         | = "response", | side  | = ">")     |
| -------------------- | -------------- | ------------------------------------ | ------------ | ------------- | ----- | ---------- |
| # custom aesthetics: |                |                                      |              |               |       |            |
| my.aes <-            | list(point     | = list(shape                         | = "square"), |               |       |            |
|                      | segment        | = list(linetype                      | =            | "dashed",     | color | = "red"),  |
|                      | label          | = list(family                        | = "serif",   | fontface      | =     | "italic")) |
| my.pal <-            | c("darkgreen", | "blue",                              | "magenta",   | "orange")     |       |            |
| pwpp(emm,            | aes = my.aes)  | + ggplot2::scale_color_manual(values |              |               |       | = my.pal)  |
| qdrg                 |                | Quickanddirtyreferencegrid           |              |               |       |            |
Description
Thisfunctionmaymakeitpossibletocomputeareferencegridforamodelobjectthatisotherwise
notsupported.
Usage
qdrg(formula, data, coef, vcov, df, mcmc, object, subset, weights, contrasts,
| link, qr,                        | ordinal,                     | ...)                    |        |                      |                     |     |
| -------------------------------- | ---------------------------- | ----------------------- | ------ | -------------------- | ------------------- | --- |
| ## Default                       | S3 method:                   |                         |        |                      |                     |     |
| qdrg(formula                     | =                            | stats::formula(object), |        |                      |                     |     |
| data =                           | try(recover_data.lm(object), |                         |        | silent               | = TRUE),            |     |
| coef =                           | stats::coef(object),         |                         | vcov = | stats::vcov(object), |                     |     |
| df = stats::df.residual(object), |                              |                         | mcmc,  | object,              | subset,             |     |
| weights                          | = stats::weights(object),    |                         |        | contrasts            | = object$contrasts, |     |
link = ifelse(!is.null(lnk <- object$family$link), lnk, object$link),
| qr = object$qr, |     | ordinal, | ...) |     |     |     |
| --------------- | --- | -------- | ---- | --- | --- | --- |

76 qdrg
Arguments
formula Formulaforthefixedeffects
data Datasetcontainingthevariablesinthemodel
coef Fixed-effectregressioncoefficients(mustconformtoformula)
vcov Variance-covariancematrixofthefixedeffects
df Errordegreesoffreedom
mcmc Posteriorsampleoffixed-effectcoefficients
object Optionalmodelobject. Thisrarelyworks!; butifprovided, wetrytosetother
arguments based on an expectation that ‘object‘ has a similar structure to ‘lm‘
objects. SeeDetails.
subset Subsetofdatausedinfittingthemodel
weights Weightsusedinfittingthemodel
contrasts Listofcontrastsspecifiedinfittingthemodel
link Linkfunction(characterorlist)used,ifageneralizedlinearmodel. (Note: re-
sponsetransformationsareauto-detectedfromformula)
qr QRdecompositionofthemodelmatrix;usedonlyifthereareNAsincoef.
ordinal listwithelementsdimandmode. ordinal$dim(integer)isthenumberoflev-
elsinanordinalresponse. Ifordinalisprovided,theintercepttermsaremodi-
fiedappropriatetopredictinganordinalresponse,asdescribedinvignette("models"),
SectionO,usingordinal$modeasthemodeargument(ifnotprovided,"latent"
isassumed). (Allmodesaresupportedexcept‘scale‘)Forthistowork,weex-
pect the first ordinal$dim-1 elements of coef to be the estimated threshold
parameters, followed by the coefficients for the linear predictor. Also, if mode
requiresback-transforming(e.g.,"prob"or"mean.class"),theusermayneed
tosupplythelinkforittoworkcorrectly.
... Optionalargumentspassedtoref_grid
Details
Usually,youneedtoprovideeitherobject;orformula,coef,vcov,data,andperhapsotherpa-
rameters.Itisoftenfairlystraightforwardtofigureouthowtogetthesefromthemodelobject;see
thedocumentationforthemodelclassthatwasfitted. Sometimesoneormoreofthesequantities
containsextraparameters,andifso,youmayneedtosubsetthemtomakeeverythingconformable.
Foragivenformulaanddata,youcanfindoutwhatisneededviacolnames(model.matrix(formula,
data)). (However, for an ordinal model, we expect the first ordinal.dim-1 coefficients to re-
place(Intercept). Andforamultivariatemodel, weexpectcoeftobeamatrixwiththeserow
names,andvcovtohaveasmanyrowsandcolumnsasthetotalnumberofelementsofcoef.)
Ifobjectisspecified,thisfunctionservesasagenericfordispatchingamethodforobject’sclass.
Seetheargumentsforqdrg.defaulttoseehowtheargumentsaredeterminedbydefault.Formany
lm-orglm-likemodels,itmaysufficeoverridejustoneortwoofthesedefaults. Thepossibilityof
acustomqdrgmethodalsoprovidesaminimalwayforpackagedeveloperstoprovideemmeans
support: itdoesn’tallowdirectlyapplyingemmeans()onthemodel,butatleasttheusercanobtain
a reference grid, and then go from there. Note that when using a ‘qdrg‘ method, it is best for the

qdrg 77
user to specify ‘object =‘ explicitly in the call, since ‘object‘ is not the first argument of ‘qdrg()‘.
However,ifthefirstargumentisnotaformula,thefunctionisretriedwithitasobject.
Thefunctionsqdrgandemmobjareclosecousins,inthattheybothproduceemmGridobjects.When
starting with summary statistics for an existing grid, emmobj is more useful, while qdrg is more
usefulwhenstartingfromafittedmodel.
Value
AnemmGridobjectconstructedfromthearguments
Rankdeficiencies
Differentmodel-fittingpackagestakedifferentapproacheswhenthemodelmatrixissingular, but
qdrg tries to reconcile them by comparing the linear functions created by formula to coefs and
vcov. Wemaythenusetheestimabilitypackagetodeterminewhatquantitiesareestimable. For
reconciling to work properly, coef should be named and vcov should have dimnames. To dis-
able this name-matching action, remove the names from coef, e.g., by calling unname(). No
reconciliationisattemptedinmultivariate-responsecases. Formoredetailsonestimability,seethe
documentationintheestimabilitypackage.
Note
Forbackwardscompatibility,anargumentordinal.dimisinvisiblysupportedaspartof...,and
ifpresent,setsordinal=list(dim=ordinal.dim,mode="latent")
SeeAlso
emmobjforanalternativewaytoconstructanemmGrid.
Examples
# In these examples, use emm_example(..., list = TRUE) # to see just the code
if (require(biglm, quietly = TRUE))
emm_example("qdrg-biglm")
if(require(coda, quietly = TRUE) && require(lme4, quietly = TRUE))
emm_example("qdrg-coda")
if(require(ordinal, quietly = TRUE))
emm_example("qdrg-ordinal")

78 rbind.emmGrid
| rbind.emmGrid |     | CombineorsubsetemmGridobjects |     |
| ------------- | --- | ----------------------------- | --- |
Description
|     |     | rbind | [ emmGrid |
| --- | --- | ----- | --------- |
These functions provide methods for and that may be used to combine objects
together, or to extract a subset of cases. The primary reason for doing this would be to obtain
multiplicity-adjustedresultsforsmallerorlargerfamiliesoftestsorconfidenceintervals.
Usage
| ## S3 method | for class     | 'emmGrid'   |                 |
| ------------ | ------------- | ----------- | --------------- |
| rbind(...,   | deparse.level | = 1, adjust | = "bonferroni") |
| ## S3 method | for class     | 'emmGrid'   |                 |
e1 + e2
| ## S3 method | for class     | 'emmGrid'       |      |
| ------------ | ------------- | --------------- | ---- |
| x[i, adjust, | drop.levels   | = TRUE,         | ...] |
| ## S3 method | for class     | 'emmGrid'       |      |
| head(x,      | n = 6, ...)   |                 |      |
| ## S3 method | for class     | 'emmGrid'       |      |
| tail(x,      | n = 6, ...)   |                 |      |
| ## S3 method | for class     | 'emmGrid'       |      |
| subset(x,    | subset, ...)  |                 |      |
| ## S3 method | for class     | 'emm_list'      |      |
| rbind(...,   | which, adjust | = "bonferroni") |      |
| ## S3 method | for class     | 'summary_emm'   |      |
| rbind(...,   | which)        |                 |      |
force_regular(object)
Arguments
... In rbind, object(s) of class emmGrid or summary_emm. In others, additional
argumentspassedtoothermethods
deparse.level
(requiredbutnotused)
| adjust         | Charactervaluepassedtoupdate.emmGrid |     |     |
| -------------- | ------------------------------------ | --- | --- |
| e1,e2,x,object | ObjectsofclassemmGrid                |     |     |
i
Integervectorofindexes

| rbind.emmGrid |     |     |     |     |     |     |     |     | 79  |
| ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
drop.levels Logical value. If TRUE, the "levels" slot in the returned object is updated to
holdonlythepredictorlevelsthatactuallyoccur
n
integernumberofentriestoinclude(orexcludeifnegative)
| subset |     | logicalexpressionindicatingwhichrowsofthegridtokeep |     |     |     |     |     |     |     |
| ------ | --- | --------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
which Integervectorofsubsetofelementstouse;ifmissing,weuseallelements.
Value
ArevisedobjectofclassemmGrid
Theresultofe1+e2isthesameasrbind(e1,e2)
Therbindmethodforemm_listobjectssimplycombinestheemmGridobjectscomprisingthefirst
element of .... Note that the returned object is not yet summarized, so any adjust parameters
applytothecombinedemmGrid.
| rbind |     |     | summary_emm |     |     |     |     | summary_emm |     |
| ----- | --- | --- | ----------- | --- | --- | --- | --- | ----------- | --- |
The method for objects (or a list thereof) returns a single ob-
ject. This combined object preserves any adjusted P values or confidence limits in the original
summaries,sincethosequantitieshavealreadybeencomputed.
| force_regular |     |            |             |      | emmGrid |     |                |              |           |
| ------------- | --- | ---------- | ----------- | ---- | ------- | --- | -------------- | ------------ | --------- |
|               |     | adds extra | (invisible) | rows | to an   |     | object to make | it a regular | grid (all |
combinations of factors). This regular structure is needed by emmeans. An object can become
irregularby,forexample,subsettingrows,orbyobtainingcontrastsofanestedstructure.
Note
rbind
throws an error if there are incompatibilities in the objects’ coefficients, covariance struc-
tures,etc. Buttheyareallowedtohavedifferentfactors;amissinglevel'.'isaddedtofactorsas
needed.
|     |     |     | by.vars |     | NULL; |     |     |     |     |
| --- | --- | --- | ------- | --- | ----- | --- | --- | --- | --- |
These functions generally reset to so if you want to keep any “by” variables, you
shouldfollow-upwithupdate.emmGrid.
Examples
| warp.lm                       | <- lm(breaks         |             | ~ wool * tension, |            | data = warpbreaks) |          |                |     |     |
| ----------------------------- | -------------------- | ----------- | ----------------- | ---------- | ------------------ | -------- | -------------- | --- | --- |
| warp.rg                       | <- ref_grid(warp.lm) |             |                   |            |                    |          |                |     |     |
| # Do all                      | pairwise             | comparisons | within            | rows       | or within          | columns, |                |     |     |
| # all considered              |                      | as one      | faily of          | tests:     |                    |          |                |     |     |
| w.t <- pairs(emmeans(warp.rg, |                      |             | ~                 | wool |     | tension))          |          |                |     |     |
| t.w <- pairs(emmeans(warp.rg, |                      |             | ~                 | tension    | | wool))           |          |                |     |     |
| rbind(w.t,                    | t.w,                 | adjust      | = "mvt")          |            |                    |          |                |     |     |
| update(w.t                    | + t.w,               | adjust      | = "fdr")          | ##         | same as above      | except   | for adjustment |     |     |
| # Show only                   | 3                    | of the      | 6 cases           |            |                    |          |                |     |     |
| summary(warp.rg[c(2,          |                      |             | 4, 5)])           |            |                    |          |                |     |     |
| # After-the-fact              |                      | 'at'        | specification     |            |                    |          |                |     |     |
| subset(warp.rg,               |                      | wool        | == "A") ##        | or warp.rg | |> subset(wool     |          | == "A")        |     |     |
| ### Working                   | with                 | 'emm_list'  | objects           |            |                    |          |                |     |     |

| 80                  |          |          |                  |          |           |         |          |             |     | ref_grid |     |
| ------------------- | -------- | -------- | ---------------- | -------- | --------- | ------- | -------- | ----------- | --- | -------- | --- |
| mod <- lm(conc      | ~ source | +        | factor(percent), |          | data      | = pigs) |          |             |     |          |     |
| all <- emmeans(mod, |          | list(src | =                | pairwise | ~ source, | pct     | = consec | ~ percent)) |     |          |     |
| rbind(all,          | which =  | c(2, 4), | adjust           | =        | "mvt")    |         |          |             |     |          |     |
| ### Irregular       | object   |          |                  |          |           |         |          |             |     |          |     |
tmp <- warp.rg[-1]
| ## emmeans(tmp,             | "tension") |                                      | #          | will fail | because | tmp  | is irregular |     |     |     |     |
| --------------------------- | ---------- | ------------------------------------ | ---------- | --------- | ------- | ---- | ------------ | --- | --- | --- | --- |
| emmeans(force_regular(tmp), |            |                                      | "tension") |           | # will  | show | some results |     |     |     |     |
| ref_grid                    |            | Createareferencegridfromafittedmodel |            |           |         |      |              |     |     |     |     |
Description
Using a fitted model object, determine a reference grid for which estimated marginal means are
defined. Theresultingref_gridobjectencapsulatesalltheinformationneededtocalculateEMMs
andmakeinferencesonthem.
Usage
| ref_grid(object, |                               | at, cov.reduce |     | =   | mean, |             |            |     |     |     |     |
| ---------------- | ----------------------------- | -------------- | --- | --- | ----- | ----------- | ---------- | --- | --- | --- | --- |
| cov.keep         | = get_emm_option("cov.keep"), |                |     |     |       | mult.names, | mult.levs, |     |     |     |     |
options = get_emm_option("ref_grid"), data, df, type, regrid, nesting,
offset, sigma, counterfactuals, nuisance = character(0), non.nuisance,
| wt.nuis | = "equal", | rg.limit |     | = get_emm_option("rg.limit"), |     |     |     | ...) |     |     |     |
| ------- | ---------- | -------- | --- | ----------------------------- | --- | --- | --- | ---- | --- | --- | --- |
Arguments
object An object produced by a supported model-fitting function, such as lm. Many
|     | modelsaresupported. |     |     |     | Seevignette("models","emmeans"). |     |     |     |     |     |     |
| --- | ------------------- | --- | --- | --- | -------------------------------- | --- | --- | --- | --- | --- | --- |
at
Optionalnamedlistoflevelsforthecorrespondingvariables
cov.reduce
|     | A   | function, | logical | value, | or formula; |     | or a named | list of these. | Each | covariate |     |
| --- | --- | --------- | ------- | ------ | ----------- | --- | ---------- | -------------- | ---- | --------- | --- |
notspecifiedincov.keeporatisreducedaccordingtothesespecifications.See
thesectionbelowon“Usingcov.reduceandcov.keep”.
cov.keep Character vector: names of covariates that are not to be reduced; these are
cov.keep
|     | treated | as  | factors | and | used in weighting |     | calculations. |     |     | may also | in- |
| --- | ------- | --- | ------- | --- | ----------------- | --- | ------------- | --- | --- | -------- | --- |
cludeintegervalue(s),andifso,themaximumoftheseisusedtosetathreshold
|     | such | that | any covariate |     | having | no more | than that | many unique | values | is  | auto- |
| --- | ---- | ---- | ------------- | --- | ------ | ------- | --------- | ----------- | ------ | --- | ----- |
maticallyincludedincov.keep.
mult.names Charactervalue: thename(s)togivetothepseudo-factor(s)whoselevelsdelin-
|     | eatetheelementsofamultivariateresponse. |     |     |     |     |     | Ifthisisprovided,itoverridesthe |     |     |     |     |
| --- | --------------------------------------- | --- | --- | --- | --- | --- | ------------------------------- | --- | --- | --- | --- |
class(object)
|     | default | name(s) |     | used | for |     | when it | has a multivariate |     | response |     |
| --- | ------- | ------- | --- | ---- | --- | --- | ------- | ------------------ | --- | -------- | --- |
(e.g.,thedefaultis"rep.meas"for"mlm"objects).
mult.levs A named list of levels for the dimensions of a multivariate response. If there
ismorethanoneelement,thecombinationsoflevelsareused,inexpand.grid
|     | order. | The | (total) | number | of levels | must | match the | number | of dimensions. |     | If  |
| --- | ------ | --- | ------- | ------ | --------- | ---- | --------- | ------ | -------------- | --- | --- |
mult.nameisspecified,thisargumentisignored.

ref_grid 81
options Ifnon-NULL,anamedlistofargumentstopasstoupdate.emmGrid,justafter
theobjectisconstructed.
data A data.frame to use to obtain information about the predictors (e.g. factor
levels). If missing, then recover_data is used to attempt to reconstruct the
data. Seethenotewithrecover_dataforanimportantprecaution.
df Numericvalue.Thisisequivalenttospecifyingoptions(df=df).Seeupdate.emmGrid.
type Charactervalue. Ifprovided,thisissavedasthe"predict.type"setting. See
update.emmGridandthesectionbelowonpredictiontypesandtransformations.
regrid Character,logical,orlist. Ifnon-missing,thereferencegridisreconstructedvia
regridwiththeargumenttransform=regrid. Seethesectionbelowonpre-
dictiontypesandtransformations. Note: Thisargumentwasnamedtransform
inversion1.7.2andearlier. Forcompatibilitywitholdcode,transformisstill
acceptediffoundamong...,aslongasitdoesn’tmatchtran.
nesting Ifthemodelhasnestedfixedeffects,thismaybespecifiedhereviaacharacter
vector or named list specifying the nesting structure. Specifying nesting
overrides any nesting structure that is automatically detected. See the section
belowonRecoveringorOverridingModelInformation.
offset Numeric scalar value (if a vector, only the first element is used). This may
be used to add an offset, or override offsets based on the model. A common
usage would be to specify offset=0 for a Poisson regression model, so that
predictions from the reference grid become rates relative to the offset that had
beenspecifiedinthemodel.
sigma Numeric value to use for subsequent predictions or back-transformation bias
adjustments. If not specified, we use sigma(object), if available, and NULL
otherwise. Note: This applies only when the family is "gaussian"; for other
families,sigmaissettoNAandcannotbeoverridden.
counterfactuals
counterfactualsspecifiescharacternamesofcounterfactualfactors. Ifthisis
non-missing,areferencegridiscreatedconsistingofcombinationsofcounter-
factual levels and the actual levels of those same factors. This grid is always
convertedtotheresponsetransformationscaleandaveragedovertheactualfac-
torlevels. Seethesectionbelowoncounterfactuals.
nuisance,non.nuisance,wt.nuis
Ifnuisanceisavectorofpredictornames,thosepredictorsareomittedfromthe
referencegrid.Instead,theresultwillbeasifwehadaveragedoverthelevelsof
thosefactors,witheitherequalorproportionalweightsasspecifiedinwt.nuis
(seetheweightsargumentinemmeans).Thefactorsinnuisancemustnotinter-
actwithotherfactors,notevenothernuisancefactors. Specifyingnuisancefac-
torscansaveconsiderablestorageandcomputationtime,andhelpavoidexceed-
ingthemaximumreference-gridsize(get_emm_option("rg.limit")). (Note:
Forcertainmodelswheretheemm_basismethodreturnsare-griddedparame-
terization,nuisancefactorscannotbeused,andanerroristhrown.)
rg.limit Integerlimitonthenumberofreference-gridrowstoallow(checkedbeforeany
multivariateresponsesareincluded).
... Optionalargumentspassedtosummary.emmGrid,emm_basis,andrecover_data,
suchasparams,vcov.(seeCovariancematrixbelow),oroptionssuchasmode
forspecificmodeltypes(seevignette("models","emmeans")).

82 ref_grid
Details
To users, the ref_grid function itself is important because most of its arguments are in effect
arguments of emmeans and related functions, in that those functions pass their ... arguments to
ref_grid.
The reference grid consists of combinations of independent variables over which predictions are
made. Estimated marginal means are defined as these predictions, or marginal averages thereof.
Thegridisdeterminedbyfirstreconstructingthedatausedinfittingthemodel(seerecover_data),
orbyusingthedata.frameprovidedindata.
By “independent variables,” we mean (in most cases) the results of all.vars() applied to the
fixed-effects part of the right-hand side of the model formula. Any random effects are excluded.
Thus,ifthemodelformulainanlme4::lmercallisyield~fert+seed*density+log(rain)+
(1|block/plot),theindependentvariablesarefert,seed,density,andrain(notlog(rain)).
Inmultivariatemodels,thedimensionofthemultivariateresponseisalsoconsideredanindependent
variable.
Thedefaultreferencegridisdeterminedbytheobservedlevelsofanyfactors,theorderedunique
valuesofcharacter-valuedpredictors,andtheresultsofcov.reducefornumericpredictors. These
maybeoverriddenusingat. Seealsothesectionbelowonrecovering/overridingmodelinforma-
tion.
Value
AnobjectoftheS4class"emmGrid"(seeemmGrid-class). Theseobjectsencapsulateeverything
needed to do calculations and inferences for estimated marginal means, and contain nothing that
dependsonthemodel-fittingprocedure.
Usingcov.reduceandcov.keep
Thecov.keepargumentwasnotavailableinemmeansversions1.4.1andearlier. Anycovariates
namedinthislistaretreatedasiftheyarefactors:alltheuniquelevelsarekeptinthereferencegrid.
Theusermayalsospecifyanintegervalue, inwhichcaseanycovariatehavingnomorethanthat
numberofuniquevaluesisimplicitlyincludedincov.keep. Thedefaultforcov.keepissetand
retrievedviatheemm_optionsframework, andthesystemdefaultis"2", meaningthatcovariates
having only two unique values are automatically treated as two-level factors. See also the Note
belowonbackwardcompatibility.
There is a subtle distinction between including a covariate in cov.keep and specifying its values
manually in at: Covariates included in cov.keep are treated as factors for purposes of weight-
ing, while specifying levels in at will not include the covariate in weighting. See the mtcars.lm
examplebelowforanillustration.
cov.reducemaybeafunction,logicalvalue,formula,oranamedlistofthese. Ifasinglefunction,
itisappliedtoeachcovariate.IflogicalandTRUE,meanisused.IflogicalandFALSE,itisequivalent
toincludingallcovariatesincov.keep. Useof‘cov.reduce=FALSE’isinadvisablebecauseitcan
resultinahugereferencegrid;itisfarbettertousecov.keep.
Ifaformula(whichmustbetwo-sided),thenamodelisfittedtothatformulausinglm;theninthe
referencegrid,itsresponsevariableissettotheresultsofpredictforthatmodel,withthereference
grid as newdata. (This is done after the reference grid is determined.) A formula is appropriate
herewhenyouthinkexperimentalconditionsaffectthecovariateaswellastheresponse.

ref_grid 83
Toallowforsituationswhereasimplelm()callasdescribedabovewon’tbeadequate,aformula
of the form ext~fcnname is also supported, where the left-hand side may be ext, extern, or
external (and must not be a predictor name) and the right-hand side is the name of an existing
function. The function is called with one argument, a data frame with columns for each variable
in the reference grid. The function is expected to use that frame as new data to be used to obtain
predictionsforoneormoremodels;anditshouldreturnanamedlistordataframewithreplacement
valuesforoneormoreofthecovariates.
If cov.reduce is a named list, then the above criteria are used to determine what to do with co-
variates named in the list. (However, formula elements do not need to be named, as those names
are determined from the formulas’ left-hand sides.) Any unresolved covariates are reduced using
"mean".
Anycov.reduceofcov.keepspecificationforacovariatealsonamedinatisignored.
Interdependentcovariates
Caremustbetakenwhencovariatevaluesdependononeanother. Forexample,whenapolynomial
modelwasfittedusingpredictorsx,x2(equaltox^2),andx3(equaltox^3),thereferencegridwill
bydefaultsetx2andx3totheirmeans,whichisinconsistent. Theusershouldinsteadusetheat
argumenttosetthesetothesquareandcubeofmean(x). Betteryet,fitthemodelusingaformula
involvingpoly(x,3)orI(x^2)andI(x^3);thenthereisonlyxappearingasacovariate;itwill
be set to its mean, and the model matrix will have the correct corresponding quadratic and cubic
terms.
Matrixcovariates
Support for covariates that appear in the dataset as matrices is very limited. If the matrix has but
one column, it is treated like an ordinary covariate. Otherwise, with more than one column, each
columnisreducedtoasinglereferencevalue–theresultofapplyingcov.reducetoeachcolumn
(averaged together if that produces more than one value); you may not specify values in at; and
theyarenottreatedasvariablesinthereferencegrid,exceptforpurposesofobtainingpredictions.
Recoveringoroverridingmodelinformation
Ability to support a particular class of object depends on the existence of recover_data and
emm_basis methods – see extending-emmeans for details. The call methods("recover_data")
willhelpidentifythese.
Data.Incertainmodels,(e.g.,resultsofglmer.nb),itisnotpossibletoidentifytheoriginaldataset.
Insuchcases,wecanworkaroundthisbysettingdataequaltothedatasetusedinfittingthemodel,
orasuitablesubset. Onlythecompletecasesindataareused, soitmaybenecessarytoexclude
some unused variables. Using data can also help save computing, especially when the dataset is
large. Inanycase,datamustrepresentallfactorlevelsusedinfittingthemodel. Itcannotbeused
asanalternativetoat. (Note: IfthereisapatternofNAsthatcausedoneormorefactorlevelstobe
excludedwhenfittingthemodel,thendatashouldalsoexcludethoselevels.)
Covariance matrix. By default, the variance-covariance matrix for the fixed effects is obtained
fromobject,usuallyviaitsvcovmethod. However,theusermayoverridethisviaavcov.argu-
ment, specifyingamatrixorafunction. Ifamatrix, itmustbesquareandofthesamedimension
andparameterorderofthefixedeffects.Ifafunction,mustreturnasuitablematrixwhenitiscalled
with arguments (object,...). Be careful with possible unintended conflicts with arguments in

84 ref_grid
...; for example, sandwich::vcovHAC() has optional arguments adjust and weights that may
beintendedforemmeans()butwillalsobepassedtovcov.().
Nestedfactors. Havinganestingstructureaffectsmarginalaveraginginemmeansinthatitisdone
separatelyforeachlevel(orcombinationthereof)ofthegroupingfactors. ref_gridtriestodiscern
whichfactorsarenestedinotherfactors,butitisnotalwaysobvious,andifitmissessome,theuser
must specify this structure via nesting; or later using update.emmGrid. The nesting argument
maybeacharactervector,anamedlist,orNULL.Ifalist,eachnameshouldbethenameofasin-
glefactorinthegrid,anditsentryacharactervectorofthename(s)ofitsgroupingfactor(s).nested
mayalsobeacharactervalueoftheform"factor1%in%(factor2*factor3)"(theparentheses
are optional). If there is more than one such specification, they may be appended separated by
commas,orasseparateelementsofacharactervector. Forexample,thesespecificationsareequiv-
alent: nesting=list(state="country",city=c("state","country"),nesting="state
%in%country,city%in%(state*country)",andnesting=c("state%in%country","city
%in%state*country").
Predictorswithsubscriptsanddata-setreferences
Whenthefittedmodelcontainssubscriptsorexplicitreferencestodatasets,thereferencegridmay
optionallybepost-processedtosimplifythevariablenames,dependingonthesimplify.namesop-
tion(seeemm_options),whichbydefaultisTRUE.Forexample,ifthemodelformulaisdata1$resp
~data1$trt+data2[[3]]+data2[["cov"]],thesimplifiedpredictornames(foruse,e.g.,inthe
specsforemmeans)willbetrt,data2[[3]],andcov.Numericalsubscriptsarenotsimplified;nor
arevariableshavingsimplifiednamesthatcoincide,suchasifdata2$trtwerealsointhemodel.
Pleasenotethatthissimplificationisperformedafterthereferencegridisconstructed. Thus,non-
simplifiednamesmustbeusedintheatargument(e.g.,at=list(`data2["cov"]`=2:4).
Ifyoudon’twantnamessimplified,useemm_options(simplify.names=FALSE).
Predictiontypesandtransformations
Transformationscanexistbecauseofalinkfunctioninageneralizedlinearmodel,orasaresponse
transformation,orevenboth.Inmanycases,theyareauto-detected,forexampleamodelformulaof
theformsqrt(y)~....Eventransformationscontainingmultiplicativeoradditiveconstants,such
as2*sqrt(y+pi)~...,areauto-detected. Aresponsetransformationofy+1~...isnotauto-
detected,butI(y+1)~...isinterpretedasidentity(y+1)~.... Awarningisissuedifitgets
toocomplicated. ComplextransformationsliketheBox-Coxtransformationarenotauto-detected;
butseethehelppageformake.tranforinformationonsomeadvancedmethods.
Thereisasubtledifferencebetweenspecifying‘type="response"’and‘regrid="response"’.
Whilethesummarystatisticsforthegriditselfarethesame,subsequentuseinemmeanswillyield
differentresultsifthereisaresponsetransformationorlinkfunction. With‘type="response"’,
EMMsarecomputedbyaveragingtogetherpredictionsonthelinear-predictorscaleandthenback-
transformingtotheresponsescale;whilewith‘regrid="response"’,thepredictionsarealready
ontheresponsescalesothattheEMMswillbethearithmeticmeansofthoseresponse-scalepre-
dictions. Toaddfurthertothepossibilities,geometricmeansoftheresponse-scalepredictionsare
obtainablevia‘regrid="log",type="response"’. Seealsothehelppageforregrid.
Order-of-processing issues: The regrid argument, if present, is acted on immediately after the
reference grid is constructed, while some of the ... arguments may be used to update the object
attheveryend. Thus,codelikeref_grid(mod,tran="sqrt",regrid="response")willnot

ref_grid 85
work correctly if the intention was to specify the response transformation, because the re-grid is
done before it processes tran="sqrt". To get the intended result, do regrid(ref_grid(mod,
tran="sqrt"),transform="response").
Counterfactuals
Ifcounterfactualsisspecified,therowsoftheentiredatasetbecomepartofthereferencegrid,
and the other reference levels are confined to those named in counterfactuals. In this type of
analysis(calledG-computation),wesubstitute(orimpute)eachcombinationofcounterfactuallev-
elsintotheentiredataset. Thus,predictionsfromthisgridarethoseofeachobservationundereach
ofthecounterfactuallevels. Forthistomakesense,werequireanassumptionofexchangeabilityof
theselevels.
Thisgridisalwaysconvertedtotheresponsescale,asG-computationonthelinear-predictorscale
produces the same results as ordinary weighted EMMs. If we have counterfactual factors A,B,
thereferencegridalsoincludesfactorsactual_A,actual_Bwhichareusedtotrackwhichobser-
vations originally had the A,B levels before they were changed by the counterfactuals code. We
average the response-scale predictions for each combination of actual levels and imputed levels
(andmultivariatelevels,ifany). Seeadditionaldiscussionofhowemmeanshandlescounterfactuals
underthatdocumentation.
Currently,counterfactualsarenotsupportedwhenthereferencegridrequirespost-processing(e.g.,
ordinalmodelswithmode="prob"). Caseswherewehavenestedfactorlevelscanbecomplicated
if mixed-in with counterfactuals, and we make no guarantees. Note that past implementations
includedargumentswt.counterandavg.counter,whicharenowdeprecatedandarejustignored
ifspecified.
Optionalsideeffect
Ifthesave.ref_gridoptionissettoTRUE(seeemm_options),Themostrecentresultofref_grid,
whethercalleddirectlyorindirectlyviaemmeans,emtrends,orsomeotherfunctionthatcallsone
of these, is saved in the user’s environment as .Last.ref_grid. This facilitates checking what
referencegridwasused,orreusingthesamereferencegridforfurthercalculations. Thisautomatic
savingisdisabledbydefault,butmaybeenabledvia‘emm_options(save.ref_grid=TRUE)’.
Note
Thesystemdefaultforcov.keepcausesmodelscontainingindicatorvariablestobehandleddiffer-
entlythaninemmeansversion1.4.1orearlier. Toreplicateolderanalyses,changethedefaultvia
‘emm_options(cov.keep=character(0))’.
Someearlierversionsofemmeansofferacovnestargument. Thisisnowobsolete;ifcovnestis
specified, it is harmlessly ignored. Cases where it was needed are now handled appropriately via
thecodeassociatedwithcov.keep.
SeeAlso
ReferencegridsareofclassemmGrid,andseveralmethodsexistforthem–forexamplesummary.emmGrid.
Referencegridsarefundamentaltoemmeans.Supportedmodelsaredetailedinvignette("models",
"emmeans"). Seeupdate.emmGridfordetailsofargumentsthatcanbeinoptions(orin...).

86 ref_grid
Examples
fiber.lm <- lm(strength ~ machine*diameter, data = fiber)
ref_grid(fiber.lm)
ref_grid(fiber.lm, at = list(diameter = c(15, 25)))
## Not run:
# We could substitute the sandwich estimator vcovHAC(fiber.lm)
# as follows:
summary(ref_grid(fiber.lm, vcov. = sandwich::vcovHAC))
## End(Not run)
# If we thought that the machines affect the diameters
# (admittedly not plausible in this example), then we should use:
ref_grid(fiber.lm, cov.reduce = diameter ~ machine)
### Model with indicator variables as predictors:
mtcars.lm <- lm(mpg ~ disp + wt + vs * am, data = mtcars)
(rg.default <- ref_grid(mtcars.lm))
(rg.nokeep <- ref_grid(mtcars.lm, cov.keep = character(0)))
(rg.at <- ref_grid(mtcars.lm, at = list(vs = 0:1, am = 0:1)))
# Two of these have the same grid but different weights:
rg.default@grid
rg.at@grid
### Using cov.reduce formulas...
# Above suggests we can vary disp indep. of other factors - unrealistic
rg.alt <- ref_grid(mtcars.lm, at = list(wt = c(2.5, 3, 3.5)),
cov.reduce = disp ~ vs * wt)
rg.alt@grid
# Alternative to above where we model sqrt(disp)
disp.mod <- lm(sqrt(disp) ~ vs * wt, data = mtcars)
disp.fun <- function(dat)
list(disp = predict(disp.mod, newdata = dat)^2)
rg.alt2 <- ref_grid(mtcars.lm, at = list(wt = c(2.5, 3, 3.5)),
cov.reduce = external ~ disp.fun)
rg.alt2@grid
# Multivariate example
MOats.lm = lm(yield ~ Block + Variety, data = MOats)
ref_grid(MOats.lm, mult.names = "nitro")
# Silly illustration of how to use 'mult.levs' to make comb's of two factors
ref_grid(MOats.lm, mult.levs = list(T=LETTERS[1:2], U=letters[1:2]))
# Comparing estimates with and without counterfactuals
neuralgia.glm <- glm(Pain ~ Treatment + Sex + Age + Duration,
family = binomial(), data = neuralgia)
emmeans(neuralgia.glm, "Treatment", type = "response")

| regrid                 |     |              |                 |     |     |                |     |     |     | 87  |
| ---------------------- | --- | ------------ | --------------- | --- | --- | -------------- | --- | --- | --- | --- |
| emmeans(neuralgia.glm, |     | "Treatment", | counterfactuals |     |     | = "Treatment") |     |     |     |     |
# Using 'params'
require("splines")
| my.knots | = c(2.5, 3, | 3.5) |     |     |     |     |     |     |     |     |
| -------- | ----------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
mod = lm(Sepal.Length ~ Species * ns(Sepal.Width, knots = my.knots), data = iris)
| ## my.knots   | is not | a predictor,  | so need | to name | it  | in 'params' |     |     |     |     |
| ------------- | ------ | ------------- | ------- | ------- | --- | ----------- | --- | --- | --- | --- |
| ref_grid(mod, | params | = "my.knots") |         |         |     |             |     |     |     |     |
regrid Reconstructareferencegridwithanewtransformationorsimulations
Description
The typical use of this function is to cause EMMs to be computed on a different scale, e.g., the
back-transformed scale rather than the linear-predictor scale. In other words, if you want back-
transformedresults, doyouwanttoaverageandthenback-transform, orback-transformandthen
average?
Usage
regrid(object, transform = c("response", "mu", "unlink", "none", "pass",
| links),     | inv.link.lbl                       | =   | "response", | predict.type, |     |        |        |     |     |     |
| ----------- | ---------------------------------- | --- | ----------- | ------------- | --- | ------ | ------ | --- | --- | --- |
| bias.adjust | = get_emm_option("back.bias.adj"), |     |             |               |     | sigma, | N.sim, |     |     |     |
| sim =       | mvtnorm::rmvnorm,                  |     | ...)        |               |     |        |        |     |     |     |
Arguments
| object | AnobjectofclassemmGrid |     |     |     |     |     |     |     |     |     |
| ------ | ---------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
transform Character, list, or logical value. If "response", "mu", or TRUE, the inverse
|     | transformation |     | is applied | to  | the estimates | in  | the grid | (but if | there is both | a   |
| --- | -------------- | --- | ---------- | --- | ------------- | --- | -------- | ------- | ------------- | --- |
linkfunctionandaresponsetransformation,"mu"back-transformsonlythelink
|     | part);          | if "none"   | or FALSE, | object     | is                   | re-gridded | so        | that its bhat | slot contains      |     |
| --- | --------------- | ----------- | --------- | ---------- | -------------------- | ---------- | --------- | ------------- | ------------------ | --- |
|     | predict(object) |             |           | linfct     |                      |            |           |               |                    |     |
|     |                 |             | and       | its        | slot                 | is the     | identity. | Any           | internal transfor- |     |
|     | mation          | information | is        | preserved. | If transform="pass", |            |           | the           | object is not      | re- |
griddedinanyway(thismaybeusefulinconjunctionwithN.sim).
Iftransformisacharactervalueinlinks(whichisthesetofvalidarguments
forthemake.linkfunction,excepting"identity"),oriftransformisalistof
thesameformasreturnedbymake.linksormake.tran,theresultsareformu-
latedasiftheresponsehadbeentransformedwiththatlinkfunction.
inv.link.lbl Charactervalue. Thisappliesonlywhentransformisinlinks,andisusedto
labelthepredictionsifsubsequentlysummarizedwithtype="response".

88 regrid
predict.type Charactervalue. Ifprovided,thereturnedobjectisupdatedwiththegiventype
to use by default by summary.emmGrid (see update.emmGrid). This may be
usefulif,forexample,whenonespecifiestransform="log"butdesiressum-
mariestobeproducedbydefaultontheresponsescale.
bias.adjust Logicalvalueforwhethertoadjustforbiasinback-transforming(transform=
"response"). This requires a valid value of sigma to exist in the object or be
specified.
sigma Error SD assumed for bias correction (when transform="response" and a
transformationisineffect). Ifnotspecified,object@misc$sigmaisused,anda
warningisissuedifitisnotfound.
N.sim Integervalue. Ifspecifiedandobjectisbasedonafrequentistmodel(i.e.,does
nothaveaposteriorsample),thenafakeposteriorsampleisgeneratedusingthe
functionsim.
sim Afunctionofthreearguments(nonamesareassumed).IfN.simissuppliedwith
a frequentist model, this function is called with respective arguments N.sim,
object@bhat, and object@V. The default is the multivariate normal distribu-
tion.
... Ignored.
Details
The regrid function reparameterizes an existing ref.grid so that its linfct slot is the identity
matrix and its bhat slot consists of the estimates at the grid points. If transform is TRUE, the
inversetransformisappliedtotheestimates.Outwardly,whentransform="response",theresult
ofsummary.emmGridafterapplyingregridisidenticaltothesummaryoftheoriginalobjectusing
‘type="response"’. But subsequent EMMs or contrasts will be conducted on the new scale –
whichisthereasonthisfunctionexists.
This function may also be used to simulate a sample of regression coefficients for a frequentist
modelforsubsequentuseasthoughitwereaBayesianmodel. Todoso,specifyavalueforN.sim
andasampleissimulatedusingthefunctionsim. Thegridmaybefurtherprocessedinaccordance
with the other arguments; or if transform="pass", it is simply returned with the only change
beingtheadditionofthesimulatedsample.
Value
AnemmGridobjectwiththerequestedchanges
Degreesoffreedom
Incaseswherethedegreesoffreedomdependedonthelinearfunctionbeingestimated(e.g.,Sat-
terthwaitemethod),thed.f. fromthereferencegridaresaved,andakindof“containment”method
is substituted in the returned object, whereby the calculated d.f. for a new linear function will be
the minimum d.f. among those having nonzero coefficients. This is kind of an ad hoc method,
and it can over-estimate the degrees of freedom in some cases. An annotation is displayed below
any subsequent summary results stating that the degrees-of-freedom method is inherited from the
previousmethodatthetimeofre-gridding.

str.emmGrid 89
Note
Anotherwaytouseregridistosupplyaregridargumenttoref_grid(eitherdirectlyofindirectly
via emmeans), in which case its value is passed to regrid as transform. This is often a simpler
approachifthereferencegridhasnotalreadybeenconstructed.
Examples
| pigs.lm | <- lm(log(conc) |     | ~ source | + factor(percent), |     | data = pigs) |
| ------- | --------------- | --- | -------- | ------------------ | --- | ------------ |
rg <- ref_grid(pigs.lm)
| # This will    | yield              | EMMs      | as GEOMETRIC  |                | means of concentrations: |            |
| -------------- | ------------------ | --------- | ------------- | -------------- | ------------------------ | ---------- |
| (emm1 <-       | emmeans(rg,        |           | "source",     | type           | = "response"))           |            |
| pairs(emm1)    | ##                 | We obtain | RATIOS        |                |                          |            |
| # This will    | yield              | EMMs      | as ARITHMETIC |                | means of concentrations: |            |
| (emm2 <-       | emmeans(regrid(rg, |           |               | transform      | = "response"),           | "source")) |
| pairs(emm2)    | ##                 | We obtain | DIFFERENCES   |                |                          |            |
| # Same result, |                    | useful    | if we         | hadn't already | created                  | 'rg'       |
| # emm2 <-      | emmeans(pigs.lm,   |           |               | "source",      | regrid = "response")     |            |
| # Simulate     | a sample           |           | of regression | coefficients   |                          |            |
set.seed(2.71828)
| rgb <- regrid(rg, |           | N.sim | = 200,                                | transform     | = "pass")  |         |
| ----------------- | --------- | ----- | ------------------------------------- | ------------- | ---------- | ------- |
| emmeans(rgb,      | "source", |       | type                                  | = "response") | ## similar | to emm1 |
| str.emmGrid       |           |       | MiscellaneousmethodsforemmGridobjects |               |            |         |
Description
MiscellaneousmethodsforemmGridobjects
Usage
| ## S3 method   |      | for class | 'emmGrid' |                        |     |     |
| -------------- | ---- | --------- | --------- | ---------------------- | --- | --- |
| str(object,    | ...) |           |           |                        |     |     |
| ## S3 method   |      | for class | 'emmGrid' |                        |     |     |
| print(x,       | ..., | export    | = FALSE)  |                        |     |     |
| ## S3 method   |      | for class | 'emmGrid' |                        |     |     |
| vcov(object,   |      | ...,      | sep =     | get_emm_option("sep")) |     |     |
| linfct(object, |      | ...)      |           |                        |     |     |
| ## Default     | S3   | method:   |           |                        |     |     |
| linfct(object, |      | ...)      |           |                        |     |     |

| 90  |     |     |     |     | summary.emmGrid |     |
| --- | --- | --- | --- | --- | --------------- | --- |
Arguments
| object |     | AnemmGridobject      |     |     |     |     |
| ------ | --- | -------------------- | --- | --- | --- | --- |
| ...    |     | (requiredbutnotused) |     |     |     |     |
| x      |     | AnemmGridobject      |     |     |     |     |
export Logicalvalue.IfFALSE,theobjectisprinted.IfTRUE,alistisinvisiblyreturned,
whichcontainscharacterelementsnamedsummaryandannotationsthatmay
besavedordisplayedastheuserseesfit.summaryisacharactermatrix(orlistof
suchmatrices,ifabyvariableisineffect).annotationsisacharactervectorof
theannotationsthatwouldhavebeenprintedbelowthesummaryorsummaries.
sep separatorforpastinglevelsincreatingrowandcolumnnamesforvcov()results
Value
Thevcovmethodreturnsasymmetricmatrixofvariancesandcovariancesforpredict.emmGrid(object,
type="lp")
Thelinfctfunctionandmethodreturnsthelinfctslotofobject.
Examples
| warp.lm               | <- lm(breaks        | ~ wool     | * tension, | data = warpbreaks) |     |     |
| --------------------- | ------------------- | ---------- | ---------- | ------------------ | --- | --- |
| warp.emm              | <- emmeans(warp.lm, |            | ~ tension  | | wool)            |     |     |
| vcov(warp.emm)        | |>                  | zapsmall() |            |                    |     |     |
| vcov(pairs(warp.emm), |                     | sep        | = "|") |>  | zapsmall()         |     |     |
summary.emmGrid Summaries,predictions,intervals,andtestsforemmGridobjects
Description
ThesearetheprimarymethodsforobtainingnumericalortabularresultsfromanemmGridobject.
| summary.emmGrid |     |                |          |                 | emmGrid     |                    |
| --------------- | --- | -------------- | -------- | --------------- | ----------- | ------------------ |
|                 |     | is the general | function | for summarizing | objects. It | also serves as the |
printmethodfortheseobjects;soforconvenience,summary()argumentsmaybeincludedincalls
tofunctionssuchasemmeansandcontrastthatconstructemmGridobjects. Notethatbydefault,
summariesforBayesianmodelsaredivertedtohpd.summary.
Usage
| ## S3 method    | for | class  | 'emmGrid'      |     |     |     |
| --------------- | --- | ------ | -------------- | --- | --- | --- |
| summary(object, |     | infer, | level, adjust, | by, |     |     |
cross.adjust = "none", type, df, calc, null, delta, side, frequentist,
| bias.adjust     | =   | get_emm_option("back.bias.adj"), |           |      | sigma, ...) |     |
| --------------- | --- | -------------------------------- | --------- | ---- | ----------- | --- |
| ## S3 method    | for | class                            | 'emmGrid' |      |             |     |
| confint(object, |     | parm, level                      | = 0.95,   | ...) |             |     |

| summary.emmGrid  |                                    |                     |          |           |               |          |      |      |     |     | 91  |
| ---------------- | ---------------------------------- | ------------------- | -------- | --------- | ------------- | -------- | ---- | ---- | --- | --- | --- |
| test(object,     | null, ...)                         |                     |          |           |               |          |      |      |     |     |     |
| ## S3 method     | for class                          | 'emmGrid'           |          |           |               |          |      |      |     |     |     |
| test(object,     | null = 0,                          | joint               | = FALSE, |           | verbose       | = FALSE, |      |      |     |     |     |
| rows, by,        | status = FALSE,                    |                     | ...)     |           |               |          |      |      |     |     |     |
| ## S3 method     | for class                          | 'emmGrid'           |          |           |               |          |      |      |     |     |     |
| predict(object,  | type,                              | interval            | =        | c("none", | "confidence", |          |      |      |     |     |     |
| "prediction"),   | level                              | = 0.95,             |          |           |               |          |      |      |     |     |     |
| bias.adjust      | = get_emm_option("back.bias.adj"), |                     |          |           |               | sigma,   |      | ...) |     |     |     |
| ## S3 method     | for class                          | 'emmGrid'           |          |           |               |          |      |      |     |     |     |
| as.data.frame(x, | row.names                          |                     | = NULL,  | optional, |               |          |      |      |     |     |     |
| check.names      | = TRUE,                            | destroy.annotations |          |           | = FALSE,      |          | ...) |      |     |     |     |
| ## S3 method     | for class                          | 'summary_emm'       |          |           |               |          |      |      |     |     |     |
| x[..., as.df     | = FALSE]                           |                     |          |           |               |          |      |      |     |     |     |
Arguments
| object | Anobjectofclass"emmGrid"(seeemmGrid-class) |     |     |     |     |     |     |     |     |     |     |
| ------ | ------------------------------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
infer Avectorofoneortwologicalvalues. Thefirstdetermineswhetherconfidence
intervalsaredisplayed,andtheseconddetermineswhetherttestsandPvalues
|     | aredisplayed. |     | Ifonlyonevalueisprovided,itisusedforboth. |     |     |     |     |     |     |     |     |
| --- | ------------- | --- | ----------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
level Numericalvaluebetween0and1. Confidencelevelforconfidenceintervals,if
infer[1]isTRUE.
adjust
Charactervaluenamingthemethodusedtoadjustpvaluesorconfidencelimits;
|     | or to adjust | comparison |     | arrows | in plot. | See | the | P-value | adjustments |     | section |
| --- | ------------ | ---------- | --- | ------ | -------- | --- | --- | ------- | ----------- | --- | ------- |
below.
by Character name(s) of variables to use for grouping into separate tables. This
affectsthefamilyoftestsconsideredinadjustedPvalues.
cross.adjust Character:p-valueadjustmentmethodtoadditionallyapplyacrossthebygroups.
SeethesectiononP-valueadjustmentsfordetails.
type Character: type of prediction desired. This only has an effect if there is a
"response"
|     | known transformation |     |             | or link | function. |               |     | specifies |     | that the   | inverse |
| --- | -------------------- | --- | ----------- | ------- | --------- | ------------- | --- | --------- | --- | ---------- | ------- |
|     | transformation       |     | be applied. |         | "mu" (or  | equivalently, |     | "unlink") |     | is usually | the     |
sameas"response",butinthecasewherethemodelhasbothalinkfunction
|     | and a response  |                  | transformation, |         | only     | the link            | part       | is back-transformed. |                 |         | Other   |
| --- | --------------- | ---------------- | --------------- | ------- | -------- | ------------------- | ---------- | -------------------- | --------------- | ------- | ------- |
|     | valid values    | are              | "link",         | "lp",   | and      | "linear.predictor"; |            |                      | these           | are     | equiva- |
|     | lent, and       | request          | that            | results | be shown | for                 | the linear | predictor,           |                 | with no | back-   |
|     |                 |                  |                 |         | "link",  |                     |            | "predict.type"       |                 |         |         |
|     | transformation. |                  | The             | default | is       | unless              | the        |                      |                 | option  | is      |
|     | in force;       | see emm_options, |                 |         | and also | the section         | below      | on                   | transformations |         | and     |
links.
df
|     | Numeric. | If non-missing, |     | a   | constant | number | of  | degrees | of freedom | to  | use in |
| --- | -------- | --------------- | --- | --- | -------- | ------ | --- | ------- | ---------- | --- | ------ |
constructingconfidenceintervalsandPvalues(NAspecifiesasymptoticresults).
calc Namedlistofcharactervalue(s)orformula(s).Theexpressionsincharareeval-
df
|     | uated and | appended | to  | the summary, |     | just after | the | column. |     | The expression |     |
| --- | --------- | -------- | --- | ------------ | --- | ---------- | --- | ------- | --- | -------------- | --- |

92 summary.emmGrid
mayincludeanynamesupthroughdfinthesummary,anyadditionalnamesin
object@grid(suchas.wgt.or.offset.),oranyearlierelementsofcalc.
null Numeric. Nullhypothesisvalue(s),onthelinear-predictorscale,againstwhich
estimatesaretested. Maybeasinglevalueusedforall,oranumericvectorof
lengthequaltothenumberoftestsineachfamily(i.e.,bygroupinthedisplayed
table).
delta Numeric value (on the linear-predictor scale). If zero, ordinary tests of signif-
icance are performed. If positive, this specifies a threshold for testing equiva-
lence (using the TOST or two-one-sided-test method), non-inferiority, or non-
superiority, depending on side. See Details for how the test statistics are de-
fined.
side Numeric or character value specifying whether the test is left-tailed (-1, "-",
"<", "left", or "nonsuperiority"); right-tailed (1, "+", ">", "right", or
"noninferiority");ortwo-sided(0,2,"!=","two-sided","both","equivalence",
or"="). Seethespecialsectionbelowformoredetails.
frequentist IgnoredexceptifaBayesianmodelwasfitted. IfmissingorFALSE,theobjectis
passedtohpd.summary. Otherwise,alogicalvalueofTRUEwillhaveitreturna
frequentistsummary.
bias.adjust Logicalvalueforwhethertoadjustforbiasinback-transforming(type="response").
Thisrequiresavalidvalueofsigmatoexistintheobjectorbespecified.
sigma Error SD assumed for bias correction (when type="response" and a trans-
formationisineffect),orforconstructingpredictionintervals. Ifnotspecified,
object@misc$sigma is used, and a warning is issued if it is not found or not
valid. Note: sigmamaybeavector,butbecarefulthatitcorrectlycorresponds
(perhapsafterrecycling)totheorderofthereferencegrid.
... Optional arguments such as scheffe.rank (see “P-value adjustments”). In
confint.emmGrid,predict.emmGrid,andtest.emmGrid,theseargumentsare
passed to summary.emmGrid. These arguments are also passed to mvregrid
whenwehaveamultivariatetransformation.
parm (Requiredargumentforconfintmethods,butnotused)
joint Logical value. If FALSE, the arguments are passed to summary.emmGrid with
infer=c(FALSE,TRUE). If joint=TRUE, a joint test of the hypothesis L beta
=nullisperformed,whereLislinfct(object)andbetaisthevectoroffixed
effects estimated by object@betahat. This will be either an F test or a chi-
square(Wald)testdependingonwhetherdegreesoffreedomareavailable. See
alsojoint_tests.
verbose Logical value. If TRUE and joint=TRUE, a table of the effects being tested is
printed.
rows Integervalues. TherowsofLtobetestedinthejointtest. Ifmissing,allrows
ofLareused. Ifnotmissing,byvariablesareignored.
status logical. IfTRUE,anotecolumnshowingstatusflags(forrankdeficienciesand
estimabilityissues)isdisplayedevenwhenempty. IfFALSE,thecolumnisin-
cludedonlyiftherearesuchissues.
interval Type of interval desired (partial matching is allowed): "none" for no inter-
vals, otherwise confidence or prediction intervals with given arguments, via

| summary.emmGrid |     |     |     |     |     | 93  |
| --------------- | --- | --- | --- | --- | --- | --- |
confint.emmGrid.Note:predictionintervalsarenotavailableunlessthemodel
familyis"gaussian".
x
objectofthegivenclass
| row.names   | passedtoas.data.frame                              |     |     |     |     |     |
| ----------- | -------------------------------------------------- | --- | --- | --- | --- | --- |
| optional    | requiredargument,butignoredinas.data.frame.emmGrid |     |     |     |     |     |
| check.names | passedtodata.frame                                 |     |     |     |     |     |
destroy.annotations
|     | Logical value.                        | If FALSE,    | an object         | of class summary_emm | is returned          | (which     |
| --- | ------------------------------------- | ------------ | ----------------- | -------------------- | -------------------- | ---------- |
|     | inherits from                         | data.frame), | but if displayed, | details              | like confidence      | levels, P- |
|     | valueadjustments,transformations,etc. |              |                   | arealsoshown.        | Butunliketheresultof |            |
summary,thenumberofdigitsdisplayedisobtainedfromgetOption("digits")
|     | ratherthanusingtheoptimaldigitsalgorithmweusuallyuse. |     |     |     | Thus,itisformat- |     |
| --- | ----------------------------------------------------- | --- | --- | --- | ---------------- | --- |
tedmorelikearegulardataframe,butwithanyannotationsandgroupingsstill
|     | intact. If | TRUE (not recommended), |     | a “plain vanilla” | data frame | is returned, |
| --- | ---------- | ----------------------- | --- | ----------------- | ---------- | ------------ |
basedonrow.namesandcheck.names.
| as.df |     | Withx[...,as.df=TRUE],theresultisobjectiscoercedtoa |     |     |     |     |
| ----- | --- | --------------------------------------------------- | --- | --- | --- | --- |
Logicalvalue.
|     | data.framebeforethesubscriptingisapplied. |     |     | Withas.df=FALSE,theresult |     |     |
| --- | ----------------------------------------- | --- | --- | ------------------------- | --- | --- |
isreturnedasasummary_emmobjectwhenpossible.
Details
| confint.emmGrid |               | summary.emmGridwithinfer=c(TRUE,FALSE). |     |     |     |           |
| --------------- | ------------- | --------------------------------------- | --- | --- | --- | --------- |
|                 | is equivalent | to                                      |     |     |     | The func- |
tion test.emmGrid, when called with joint=FALSE, is equivalent to summary.emmGrid with
infer=c(FALSE,TRUE).
| joint=TRUE, | test.emmGrid |            |          |                        | linfct%*%bhat= |     |
| ----------- | ------------ | ---------- | -------- | ---------------------- | -------------- | --- |
| With        |              | calculates | the Wald | test of the hypothesis |                |     |
null,wherelinfctandbhatrefertoslotsinobject(possiblysubsettedaccordingtobyorrows).
Anerroristhrownifanyrowoflinfctisnon-estimable.Itispermissiblefortherowsoflinfctto
belinearlydependent,aslongasnull==0,inwhichcaseareducedsetofcontrastsistested.Linear
dependence and nonzero null cause an error. The returned object has an additional "est.fcns"
attribute,whichisalistofthelinearfunctionsassociatedwiththejointtest.
Value
summary.emmGrid,confint.emmGrid,andtest.emmGridreturnanobjectofclass"summary_emm",
whichisanextensionofdata.framebutwithaspecialprintmethodthatdisplaysitwithcustom
formatting. For models fitted using MCMC methods, the call is diverted to hpd.summary (with
| prob level, |     |     |     |     |     |     |
| ----------- | --- | --- | --- | --- | --- | --- |
set to if specified); one may alternatively use general MCMC summarization tools
withtheresultsofas.mcmc.
predictreturnsavectorofpredictionsforeachrowofobject@grid.
Theas.data.framemethodreturnsanobjectthatinheritsfrom"data.frame".
Defaults
The misc slot in object may contain default values for by, calc, infer, level, adjust, type,
| null, side, | delta. |     |     |     |     |     |
| ----------- | ------ | --- | --- | --- | --- | --- |
and These defaults vary depending on the code that created the object. The
updatemethodmaybeusedtochangethesedefaults.Inaddition,anyoptionssetusing‘emm_options(summary
=...)’willtrumpthosestoredintheobject’smiscslot.

94 summary.emmGrid
Transformationsandlinks
Withtype="response", thetransformationassumedcanbefoundin‘object@misc$tran’, and
its label, for the summary is in ‘object@misc$inv.lbl’. Any t or z tests are still performed on
thescaleofthelinearpredictor,nottheinverse-transformedone. Similarly,confidenceintervalsare
computedonthelinear-predictorscale,theninverse-transformed.
Beawarethatonlyunivariatetransformationsandlinksaresupportedinthisway.Somemultivariate
transformationsaresupportedbymvregrid.
Biasadjustmentwhenback-transforming
Whenbias.adjustisTRUE,thenback-transformedestimatesareadjustedbyadding0.5h′′(u)σ2,
wherehistheinversetransformationanduisthelinearpredictor. Thisisbasedonasecond-order
Taylorexpansion. Therearebetterorexactadjustmentsforcertainspecificcases,andthesemaybe
incorporatedinfutureupdates.
Note: In certain models, e.g., those with non-gaussian families, sigma is initialized as NA, and so
by default, bias adjustment is skipped and a warning is issued. You may override this by spec-
ifying a value for sigma. However, with ordinary generalized linear models, bias adjustment is
inappropriateandyoushouldnottrytodoit. WithGEEsandGLMMs, youprobablyshouldnot
usesigma(model),andinsteadyoushouldcreateanappropriatevalueusingtheestimatedrandom
effects,e.g.,fromVarCorr(model). Anexampleisprovidedinthe“transformations”vignette.
Awordofcaution: Thisbias-adjustmentmethodismerelyaone-termcorrection,anditmultiplies
sigma^2. When sigma is reasonably small relative to the scale of the response, this is fine; but
when sigma is large, this bias adjustment can produce bizarre and out-of-range results. Consider
for example a logit or probit model where the back-transformed response is constrained to the
interval[0,1];ifsigmaismorethan1,theadjustmentcaneasilypulltheestimateoutsideofthese
constraints.
P-valueadjustments
The adjust argument specifies a multiplicity adjustment for tests or confidence intervals. This
adjustmentalwaysisappliedseparatelytoeachtableorsub-tablethatyouseeintheprintedoutput
(see rbind.emmGrid for how to combine tables). If there are non-estimable cases in a by group,
those cases are excluded before determining the adjustment; that means there could be different
adjustmentsindifferentgroups.
Thevalidvaluesofadjustareasfollows:
"tukey" UsestheStudentizedrangedistributionwiththenumberofmeansinthefamily. (Avail-
ablefortwo-sidedcasesonly.)
"scheffe" ComputespvaluesfromtheF distribution, accordingtotheScheffecriticalvalueof
(cid:112)
rF(α;r,d), where d is the error degrees of freedom and r is the rank of the set of linear
functionsunderconsideration. Bydefault,thevalueofriscomputedfromlinfct(object)
for each by group; however, if the user specifies an argument matching scheffe.rank, its
value will be used instead. Ordinarily, if there are k means involved, then r = k −1 for a
fullsetofcontrastsinvolvingallkmeans,andr =kforthemeansthemselves. (TheScheffe
adjustmentisavailablefortwo-sidedcasesonly.)
"sidak" Makes adjustments as if the estimates were independent (a conservative adjustment in
manycases).

summary.emmGrid 95
"bonferroni" Multipliespvalues,ordividessignificancelevelsbythenumberofestimates. This
isaconservativeadjustment.
"dunnettx" Uses our ownad hoc approximation to the Dunnett distribution for a family of esti-
mateshavingpairwisecorrelationsof0.5(asistruewhencomparingtreatmentswithacontrol
withequalsamplesizes). Theaccuracyoftheapproximationimproveswiththenumberofsi-
multaneousestimates,andismuchfasterthan"mvt". (Availablefortwo-sidedcasesonly.)
"mvt" Uses the multivariate t distribution to assess the probability or critical value for the max-
imum of k estimates. This method produces the same p values and intervals as the default
summary or confint methods to theresults of as.glht. In the context of pairwise compar-
isons or comparisons with a control, this produces “exact” Tukey or Dunnett adjustments,
respectively. However, the algorithm (from the mvtnorm package) uses a Monte Carlo
method, so results are not exactly repeatable unless the same random-number seed is used
(see set.seed). As the family size increases, the required computation time will become
noticeableorevenintolerable,makingthe"tukey","dunnettx",orothersmoreattractive.
"none" Makesnoadjustmentstothepvalues.
Fortests,notconfidenceintervals,theBonferroni-inequality-basedadjustmentmethodsinp.adjust
arealsoavailable(currently,theseinclude"holm","hochberg","hommel","bonferroni","BH",
"BY", "fdr", and"none"). Ifap.adjust.methodsmethodotherthan"bonferroni"or"none"
is specified for confidence limits, the straight Bonferroni adjustment is used instead. Also, if an
adjustmentmethodisnotappropriate(e.g.,using"tukey"withone-sidedtests,orwithresultsthat
arenotpairwisecomparisons),amoreappropriatemethod(usually"sidak")issubstituted.
In some cases, confidence and p-value adjustments are only approximate – especially when the
degreesoffreedomorstandarderrorsvarygreatlywithinthefamilyoftests. The"mvt"methodis
alwaysthecorrectone-stepadjustment,butitcanbeveryslow.Onemayuseas.glhtwithmethods
inthemultcomppackagetoobtainnon-conservativemulti-stepadjustmentstotests.
Warning: Non-estimable cases are included in the family to which adjustments are applied. You
maywishtosubsettheobjectusingthe[]operatortoworkaroundthisproblem.
Thecross.adjustargumentisawayofspecifyingamultiplicityadjustmentacrossthebygroups
(otherwise by default, each group is treated as a separate family in regards to multiplicity adjust-
ments). It applies only to p values. Valid options are one of the p.adjust.methods or "sidak".
This argument is ignored unless it is other than "none", there is more than one by group, and
they are all the same size. Under those conditions, we first use adjust to determine the within-
groupadjustedpvalues. Imagineeachgroup’sadjustedpvaluesarrangedinside-by-sidecolumns,
thus forming a matrix with the number of columns equal to the number of by groups. Then we
use the cross.adjust method to further adjust the adjusted p values in each row of this matrix.
NotethatanoverallBonferroni(orSidak)adjustmentisobtainablebyspecifyingbothadjustand
cross.adjustas"bonferroni"(or"sidak"). However,lessconservative(butyetconservative)
overall adjustments are available when it is possible to use an “exact” within-group method (e.g.,
adjust="tukey" for pairwise comparisons) and cross.adjust as a conservative adjustment.
[cross.adjust methods other than "none", "bonferroni", or "sidak" do not seem advisable,
butotherp.adjustmethodsareavailableifyoucanmakesenseofthem.]
Testsofsignificance,nonsuperiority,noninferiority,orequivalence
Whendelta=0,teststatisticsaretheusualtestsofsignificance. Theyareoftheform‘(estimate
-null)/SE’.Notationally:

96 summary.emmGrid
| Significance | H :θ =θ                | versus |     |     |
| ------------ | ---------------------- | ------ | --- | --- |
|              | 0                      | 0      |     |     |
| H            | :θ <θ (left-sided),or  |        |     |     |
| 1            | 0                      |        |     |     |
| H            | :θ >θ (right-sided),or |        |     |     |
| 1            | 0                      |        |     |     |
| H            | :θ ̸=θ (two-sided)     |        |     |     |
| 1            | 0                      |        |     |     |
Theteststatisticis
| t=(Q−θ | )/SE |     |     |     |
| ------ | ---- | --- | --- | --- |
0
whereQisourestimateofθ;thenleft,right,ortwo-sidedpvaluesareproduced,depending
onside.
Whendeltaispositive,theteststatisticdependsonsideasfollows.
| Left-sided(nonsuperiority) |        | H :θ | ≥θ +δversusH | :θ <θ +δ |
| -------------------------- | ------ | ---- | ------------ | -------- |
|                            |        | 0    | 0            | 1 0      |
| t=(Q−θ                     | −δ)/SE |      |              |          |
0
Thepvalueisthelower-tailprobability.
| Right-sided(noninferiority) |        | H 0 | :θ ≤θ 0 −δversusH | 1 :θ >θ 0 −δ |
| --------------------------- | ------ | --- | ----------------- | ------------ |
| t=(Q−θ                      | +δ)/SE |     |                   |              |
0
Thepvalueistheupper-tailprobability.
| Two-sided(equivalence) |         | H 0 :|θ−θ | 0 |≥δversusH | 1 :|θ−θ 0 |<δ |
| ---------------------- | ------- | --------- | ------------ | ------------- |
| t=(|Q−θ                | |−δ)/SE |           |              |               |
0
Thepvalueisthelower-tailprobability.
Notethattisthemaximumoft and−t . Thisisequivalenttochoosingtheless
|     |     |     | nonsup | noninf |
| --- | --- | --- | ------ | ------ |
significantresultinthetwo-one-sided-test(TOST)procedure.
Non-estimablecases
Whenthemodelisrank-deficient,eachrowxofobject’slinfctslotischeckedforestimability.
Ifsum(x*bhat)isfoundtobenon-estimable,thenthestringNonEstisdisplayedfortheestimate,
NA.
and associated statistics are set to The estimability check is performed using the orthonormal
basis N in the nbasis slot for the null space of the rows of the model matrix. Estimability fails
when||Nx||2/||x||2 exceedstol,whichbydefaultis1e-8. Youmaychangeitviaemm_options
bysettingestble.toltothedesiredvalue.
Seethewarningabovethatnon-estimablecasesarestillincludedwhendeterminingthefamilysize
forP-valueadjustments.
WarningaboutpotentialmisuseofPvalues
Someinthestatisticalandscientificcommunityarguethattheterm“statisticalsignificance”should
becompletelyabandoned,andthatcriteriasuchas“p<0.05”neverbeusedtoassesstheimportance
ofaneffect.Thesepracticescanbetoomisleadingandarepronetoabuse.Seethe“basics”vignette
formorediscussion.
Note
Indoingtestingandatransformationand/orlinkisinforce,anynulland/ordeltavaluesspecified
must always be on the scale of the linear predictor, regardless of the setting for ‘type‘. If type=
"response",thenullvaluedisplayedinthesummarytablewillbeback-transformedfromthevalue
supplied by the user. But the displayed delta will not be changed, because there (often) is not a
naturalwaytoback-transformit.

summary.emmGrid 97
Whenwehavetype="response",andbias.adj=TRUE,thenullvaluedisplayedintheoutput
is both back-transformed and bias-adjusted, leading to a rather non-intuitive-looking null value.
However, since the tests themselves are performed on the link scale, this is the response value at
whicha*P*valueof1wouldbeobtained.
ThedefaultshowmethodforemmGridobjects(withtheexceptionofnewlycreatedreferencegrids)
is print(summary()). Thus, with ordinary usage of emmeans and such, it is unnecessary to call
summaryunlessthereisaneedtospecifyotherthanitsdefaultoptions.
Ifadataframeisneeded,summary,confint,andtestservethisneed. as.data.frameroutesto
summarybydefault;callingitwithdestroy.annotations=TRUEisnotrecommendedforexactly
thatreason. Ifyouwanttoseemoredigitsintheoutput,useprint(summary(object),digits=
...);andifyoualwayswanttoseemoredigits,useemm_options(opt.digits=FALSE).
SeeAlso
hpd.summary
Examples
| warp.lm           | <- lm(breaks        |            | ~ wool  | * tension, | data   | = warpbreaks) |     |     |     |
| ----------------- | ------------------- | ---------- | ------- | ---------- | ------ | ------------- | --- | --- | --- |
| warp.emm          | <- emmeans(warp.lm, |            |         | ~ tension  | |      | wool)         |     |     |     |
| warp.emm          | #                   | implicitly | runs    | 'summary'  |        |               |     |     |     |
| confint(warp.emm, |                     | by         | = NULL, | level      | = .90) |               |     |     |     |
# --------------------------------------------------------------
| pigs.lm           | <- lm(log(conc)     |      | ~ source    | +            | factor(percent), |               | data     | = pigs)          |     |
| ----------------- | ------------------- | ---- | ----------- | ------------ | ---------------- | ------------- | -------- | ---------------- | --- |
| pigs.emm          | <- emmeans(pigs.lm, |      |             | "percent",   | type             | = "response") |          |                  |     |
| summary(pigs.emm) |                     |      | # (inherits | type         | = "response")    |               |          |                  |     |
| summary(pigs.emm, |                     | calc | = c(n       | = ".wgt."))  |                  | # Show        | sample   | size             |     |
| # For which       | percents            |      | is EMM      | non-inferior |                  | to 35,        | based on | a 10% threshold? |     |
# Note the test is done on the log scale even though we have type = "response"
| test(pigs.emm,            |     | null | = log(35), | delta | = log(1.10), |     | side = | ">") |     |
| ------------------------- | --- | ---- | ---------- | ----- | ------------ | --- | ------ | ---- | --- |
| con <- contrast(pigs.emm, |     |      | "consec")  |       |              |     |        |      |     |
test(con)
| test(con,        | joint   | = TRUE)    |             |          |           |              |     |              |       |
| ---------------- | ------- | ---------- | ----------- | -------- | --------- | ------------ | --- | ------------ | ----- |
| # default        | Scheffe | adjustment |             | - rank   | = 3       |              |     |              |       |
| summary(con,     | infer   | =          | c(TRUE,     | TRUE),   | adjust    | = "scheffe") |     |              |       |
| # Consider       | as      | some of    | many        | possible | contrasts | among        | the | six cell     | means |
| summary(con,     | infer   | =          | c(TRUE,     | TRUE),   | adjust    | = "scheffe", |     | scheffe.rank | = 5)  |
| # Show estimates |         | to         | more digits |          |           |              |     |              |       |
| print(test(con), |         | digits     | = 7)        |          |           |              |     |              |       |
# --------------------------------------------------------------
| # Cross-adjusting      |     | P   | values |          |             |     |             |         |     |
| ---------------------- | --- | --- | ------ | -------- | ----------- | --- | ----------- | ------- | --- |
| prs <- pairs(warp.emm) |     |     | #      | pairwise | comparisons |     | of tension, | by wool |     |

98 ubds
| test(prs,          | adjust = "tukey",      | cross.adjust |            | = "bonferroni") |               |
| ------------------ | ---------------------- | ------------ | ---------- | --------------- | ------------- |
| # Same comparisons | taken                  | as one       | big family | (more           | conservative) |
| test(prs,          | adjust = "bonferroni", |              | by =       | NULL)           |               |
ubds
Unbalanceddataset
Description
This is a simulated unbalanced dataset with three factors and two numeric variables. There are
truerelationshipsamongthesevariables. Thisdatasetcanbeusefulintestingorillustratingmessy-
data situations. There are no missing data, and there is at least one observation for every factor
combination;however,the"cells"attributemakesitsimpletoconstructsubsetsthathaveempty
cells.
Usage
data(ubds)
Format
Adataframewith100observations,5variables,andaspecial"cells"attribute:
A Factorwithlevels1,2,and3
B Factorwithlevels1,2,and3
C Factorwithlevels1,2,and3
x Anumericvariable
y Anumericvariable
Inaddition,attr(ubds,"cells")consistsofanamedlistoflength27withtherownumbersfor
eachcombinationofA,B,C.Forexample,attr(ubds,"cells")[["213"]]hastherownumbers
correspondingtolevelsA==2,B==1,C==3. Theentriesareorderedbylength,sothefirstentry
isthecellwiththelowestfrequency.
Examples
| # Omit the | three lowest-frequency |                | cells     |        |                       |
| ---------- | ---------------------- | -------------- | --------- | ------ | --------------------- |
| low3 <-    | unlist(attr(ubds,      | "cells")[1:3]) |           |        |                       |
| messy.lm   | <- lm(y ~ (x           | + A +          | B + C)^3, | data = | ubds, subset = -low3) |

untidy 99
| untidy |     | Daretobeun-"tidy"! |     |     |     |     |
| ------ | --- | ------------------ | --- | --- | --- | --- |
Description
Userswhouseemmeansfunctionsaspartofapipeline–orpost-processthoseresultsinsomeother
way–arelikelymissingsomeimportantinformation.
Details
That’sbecauseemmeans
Yourbestbetistodisplaytheactualresultswithoutanypost-processing.
anditsrelativeshavetheirownsummaryandprintmethodsthatdisplayannotationsthatmaybe
helpfulinexplainingwhatyouhave. Ifyoujustpipetheresultsintothenextstep,thoseannotations
arestrippedawayandyouneverseethem.Statisticalanalysisisnotjustaworkflow;itisadiscipline
thatinvolvescareininterpretingintermediateresults,andthinkingbeforemovingon.
Examples
| neur.glm | <- glm(Pain | ~ Treatment |     | + Sex + Age, | family | = binomial(), |
| -------- | ----------- | ----------- | --- | ------------ | ------ | ------------- |
data = neuralgia)
| ### The                        | actual | results with | annotations | (e.g.                  | ests | are on logit scale): |
| ------------------------------ | ------ | ------------ | ----------- | ---------------------- | ---- | -------------------- |
| emmeans(neur.glm,              |        | "Treatment") |             |                        |      |                      |
| ### Post-processed             |        | results      | lose        | the annotations        |      |                      |
| if(requireNamespace("tibble")) |        |              |             | {                      |      |                      |
| emmeans(neur.glm,              |        | "Treatment") |             | |> tibble::as_tibble() |      |                      |
}
| update.emmGrid |     | UpdateanemmGridobject |     |     |     |     |
| -------------- | --- | --------------------- | --- | --- | --- | --- |
Description
ObjectsofclassemmGridcontainseveralsettingsthataffectsuchthingsaswhatargumentstopass
tosummary.emmGrid.Theupdatemethodallowssafermanagementofthesesettingsthanbydirect
modificationofitsslots.
Usage
| ## S3 method      | for      | class       | 'emmGrid' |                 |     |     |
| ----------------- | -------- | ----------- | --------- | --------------- | --- | --- |
| update(object,    |          | ..., silent | =         | FALSE)          |     |     |
| ## S3 replacement |          | method      | for       | class 'emmGrid' |     |     |
| levels(x)         | <- value |             |           |                 |     |     |

| 100            |          |       |               |      |     |     |     |     | update.emmGrid |     |
| -------------- | -------- | ----- | ------------- | ---- | --- | --- | --- | --- | -------------- | --- |
| ## S3 method   | for      | class | 'summary_emm' |      |     |     |     |     |                |     |
| update(object, | by.vars, |       | mesg,         | ...) |     |     |     |     |                |     |
Arguments
| object | AnemmGridobject |     |     |     |     |     |     |     |     |     |
| ------ | --------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
... Optionstobeset. Thesemustmatchalistofknownoptions(seeDetails)
silent Logicalvalue. IfFALSE(thedefault),amessageisdisplayedifanyoptionsare
IfTRUE,nomessagesareshown.
notmatched.
| x     | anemmGridobject |     |             |         |     |                   |     |                |     |      |
| ----- | --------------- | --- | ----------- | ------- | --- | ----------------- | --- | -------------- | --- | ---- |
| value | list            |     |             |         |     |                   |     | update.emmGrid |     |      |
|       |                 | or  | replacement | levels. | See | the documentation |     | for            |     | with |
thelevelsargument,aswellasthesectionbelowon“Replacionglevels”
| by.vars,mesg | Attributesthatcanbealteredinupdate.summary_emm |     |     |     |     |     |     |     |     |     |
| ------------ | ---------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Value
anupdatedemmGridobject.
levels<-replacesthelevelsoftheobjectin-place.
Seethesectiononreplacinglevelsfordetails.
Details
Thenamesin...arepartiallymatchedagainstthosethatarevalid,andifamatchisfound,itadds
| orreplacesthecurrentsetting. |     |     | Thevalidnamesare |     |     |     |     |     |     |     |
| ---------------------------- | --- | --- | ---------------- | --- | --- | --- | --- | --- | --- | --- |
tran,tran2 (list or character) specifies the transformation which, when inverted, determines
theresultsdisplayedbysummary.emmGrid,predict.emmGrid,oremmipwhentype="response".
Thevaluemaybethenameofastandardtransformationfrommake.linkoradditionalones
supportedbyname,suchas"log2";or,foracustomtransformation,alistcontainingatleast
thefunctionslinkinv(theinverseofthetransformation)andmu.eta(thederivativethereof).
Themake.tranfunctionreturnssuchlistsforanumberofpopulartransformations. Seethe
helppageofmake.tranfordetailsaswellasinformationontheadditionalnamedtransfor-
mationsthataresupported. tran2isjustliketranexceptitisasecondtransformation(i.e.,a
responsetransformationinageneralizedlinearmodel).
tran.mult Multiple for tran. For example, for the response transformation ‘2*sqrt(y)’ (or
| ‘sqrt(y)+sqrt(y+1)’, |     |     |     |               |     |             | tran="sqrt" |     |     | tran.mult |
| -------------------- | --- | --- | --- | ------------- | --- | ----------- | ----------- | --- | --- | --------- |
|                      |     |     | for | that matter), | we  | should have |             |     | and |           |
=2. Ifabsent,amultipleof1isassumed.
tran.offset Additiveconstantbeforeatransformationisapplied. Forexample,aresponsetrans-
|           | log(y+pi) |     |     | tran.offset=pi. |     |       |          |          |           |         |
| --------- | --------- | --- | --- | --------------- | --- | ----- | -------- | -------- | --------- | ------- |
| formation | of        |     | has |                 |     | If no | value is | present, | an offset | of 0 is |
assumed.
estName (character)isthecolumnlabelusedfordisplayingpredictionsorEMMs.
inv.lbl (character))isthecolumnlabeltouseforpredictionsorEMMswhentype="response".
| by.vars (character) |     |        | NULL) |               |     |          |          |        |          |          |
| ------------------- | --- | ------ | ----- | ------------- | --- | -------- | -------- | ------ | -------- | -------- |
|                     |     | vector | or    | the variables |     | used for | grouping | in the | summary, | and also |
fordefiningsubfamiliesinacalltocontrast.
pri.vars (charactervector)arethenamesofthegridvariablesthatarenotinby.vars.Thus,the
combinationsoftheirlevelsareusedascolumnsineachtableproducedbysummary.emmGrid.

update.emmGrid 101
alpha (numeric)isthedefaultsignificancelevelfortests,insummary.emmGridaswellasplot.emmGrid
when ‘CIs=TRUE’. Be cautious that methods that depend on specifying alpha are prone to
abuse. Seethediscussioninvignette("basics","emmeans").
adjust (character))isthedefaultfortheadjustargumentinsummary.emmGrid.
cross.adjust (character))isthedefaultforthecross.adjustargumentinsummary.emmGrid
(usedforadjustingbetweengroups).
famSize (integer)isthenumberofmeansinvolvedinafamilyofinferences;usedinTukeyadjust-
ment
infer (logicalvectoroflength2)isthedefaultvalueofinferinsummary.emmGrid.
level (numeric) is the default confidence level, level, in summary.emmGrid. Note: You must
specifyallfivelettersof‘level’todistinguishitfromtheslotname‘levels’.
df (numeric)overridesthedefaultdegreesoffreedomwithaspecifiedsinglevalue.
calc (list)additionalcalculatedcolumns. Seesummary.emmGrid.
null (numeric)nullhypothesisforsummaryortest(takentobezeroifmissing).
side (numericorcharacter)sidespecificationforforsummaryortest(takentobezeroifmiss-
ing).
sigma (numeric)ErrorSDtouseinpredictionsandforbias-adjustedback-transformations
delta (numeric)deltaspecificationforsummaryortest(takentobezeroifmissing).
predict.typeortype (character)setsthedefaultmethodofdisplayingpredictionsinsummary.emmGrid,
predict.emmGrid,andemmip.Validvaluesare"link"(withsynonyms"lp"and"linear"),
or"response".
bias.adjust,frequentist (logical)Theseareusedbysummaryifthevalueofthesearguments
arenotspecified.
estType (character) is used internally to determine what adjust methods are appropriate. It
should match one of ‘c("prediction","contrast","pairs")’. As an example of why
thisisneeded,theTukeyadjustmentshouldonlybeusedforpairwisecomparisons(estType
="pairs");ifestTypeissomeotherstring,Tukeyadjustmentsarenotallowed.
avgd.over (character) vector) are the names of the variables whose levels are averaged over
inobtainingmarginalaveragesofpredictions,i.e.,estimatedmarginalmeans. Changingthis
mightproduceamisleadingprintout,butsettingittocharacter(0)willsuppressthe“aver-
agedover”messageinthesummary.
initMesg (character) is a string that is added to the beginning of any annotations that appear
belowthesummary.emmGriddisplay.
methDesc (character)isastringthatmaybeusedforcreatingnamesforalistofemmGridobjects.
nesting (Character or named list) specifies the nesting structure. See “Recovering or overrid-
ingmodelinformation”inthedocumentationforref_grid. Thecurrentnestingstructureis
displayedbystr.emmGrid.
levels named list of new levels for the elements of the current emmGrid. The list name(s) are
used as new variable names, and if needed, the list is expanded using expand.grid. These
results replace current variable names and levels. This specification changes the levels,
grid,roles,andmiscslotsintheupdatedemmGrid,andresetspri.vars,by.vars,adjust,
famSize, and avgd.over. In addition, if there is nesting of factors, that may be altered; a
warningisissuedifitinvolvessomethingotherthanmerenamechanges. Note: Allsixletters
oflevelsisneededinordertodistinguishitfromlevel.

102 update.emmGrid
submodel formula or character value specifying a submodel (requires this feature being sup-
ported by underlying methods for the model class). When specified, the linfct slot is re-
placed by its aliases for the specified sub-model. Any factors in the sub-model that do not
appearinthemodelmatrixareignored,asareanyinteractionsthatarenotinthemainmodel,
andanyfactorsassociatewithmultivariateresponses. Theestimatesdisplayedarethencom-
putedasifthesub-modelhadbeenfitted. (However,thestandarderrorswillbebasedonthe
errorvariance(s)ofthefullmodel.) Note: Theformulashouldreferonlytopredictornames,
excludinganyfunctioncalls(suchasfactororpoly)thatappearintheoriginalmodelfor-
mula. Seetheexample.
Thecharactervaluesallowedshouldpartiallymatch"minimal"or"type2".With"minimal",
the sub-model is taken to be the one only involving the surviving factors in object (the
ones averaged over being omitted). Specifying "type2" is the same as "minimal" except
only the highest-order term in the submodel is retained, and all effects not containing it are
orthogonalized-out. Thus,inapurelylinearsituationsuchasanlmmodel,thejointtestofthe
modifiedobjectisinessenceatype-2testasincar::Anova.
Pleasenotethatitispossible(orevenlikely)thattherewillbedisparitybetweenthegridand
linfctslotswhenasubmodelisused. Thisisbecausegridcontainstheclaimed valuesof
thepredictorsandlinfctcontainsaliasesofthemcomputedfromthesubmodel.
For some objects such as generalized linear models, specifying submodel will typically not
produce the same estimates or type-2 tests as would be obtained by actually fitting a sepa-
rate model with those specifications. The reason is that those models are fitted by iterative-
reweighting methods, whereas the submodel calculations preserve the final weights used in
fittingthefullmodel.
(anyotherslotname) IfthenamematchesanelementofslotNames(object)otherthanlevels,
that slot is replaced by the supplied value, if it is of the required class (otherwise an error
occurs).
Theusermustbeverycarefulinreplacingslotsbecausetheyareinterrelated;forexample,the
lengthsanddimensionsofgrid,linfct,bhat,andVmustconform.
Replacinglevels
The levels<- method uses update.emmGrid to replace the levels of one or more factors. This
methodallowsselectivelyreplacingthelevelsofjustonefactor(viasubsettingoperators),whereas
update(x,levels=list(...)) requires a list of all factors and their levels. If any factors are
toberenamed,wemustreplacealllevelsandincludethenewnamesinthereplacements. Seethe
examples.
Methodforsummary_emmobjects
This method exists so that we can change the way a summary is displayed, by changing the by
variablesortheannotations.
Note
Whenitmakessense,anoptionsetbyupdatewillpersistintofutureresultsbasedonthatobject.
Butsomeoptionsaredisabledaswell. Forexample,acalcoptionwillbenulled-outifcontrast
iscalled,becauseitprobablywillnotmakesensetodothesamecalculationsonthecontrastresults,
andinfactthevariable(s)neededmaynotevenstillexist. factor(percent).

xtable.emmGrid 103
SeeAlso
emm_options
Examples
| # Using              | an already-transformed       |              |              | response:          |          |            |                    |
| -------------------- | ---------------------------- | ------------ | ------------ | ------------------ | -------- | ---------- | ------------------ |
| pigs.lm              | <- lm(log(conc)              |              | ~ source     | * factor(percent), |          |            | data = pigs)       |
| # Reference          | grid                         | that         | knows about  | the transformation |          |            |                    |
| # and asks           | to include                   |              | the sample   | size in            | any      | summaries: |                    |
| pigs.rg              | <- update(ref_grid(pigs.lm), |              |              | tran               | = "log", |            |                    |
|                      |                              | predict.type |              | = "response",      |          |            |                    |
|                      |                              | calc         | = c(n        | = ~.wgt.))         |          |            |                    |
| emmeans(pigs.rg,     |                              | "source")    |              |                    |          |            |                    |
| # Obtain             | estimates                    | for          | the additive | model              |          |            |                    |
| # [Note              | that the                     | submodel     | refers       | to 'percent',      |          | not        | 'factor(percent)'] |
| emmeans(pigs.rg,     |                              | "source",    | submodel     | = ~                | source   | + percent) |                    |
| # Type II            | ANOVA                        |              |              |                    |          |            |                    |
| joint_tests(pigs.rg, |                              | submodel     | =            | "type2")           |          |            |                    |
| ## Changing          | levels                       | of           | one factor   |                    |          |            |                    |
| newrg <-             | pigs.rg                      |              |              |                    |          |            |                    |
| levels(newrg)$source |                              | <-           | 1:3          |                    |          |            |                    |
newrg
| ## Unraveling | a   | previously | standardized |     | covariate |     |     |
| ------------- | --- | ---------- | ------------ | --- | --------- | --- | --- |
zd = scale(fiber$diameter)
| fibz.lm  | <- lm(strength       |     | ~ machine | * zd,     | data = | fiber)  |                |
| -------- | -------------------- | --- | --------- | --------- | ------ | ------- | -------------- |
| (fibz.rg | <- ref_grid(fibz.lm, |     | at        | = list(zd | =      | -2:2))) | ### 2*SD range |
lev <- levels(fibz.rg)
| levels(fibz.rg) |                | <- list              | (   |                  |     |     |             |
| --------------- | -------------- | -------------------- | --- | ---------------- | --- | --- | ----------- |
| machine         | = lev$machine, |                      |     |                  |     |     |             |
| diameter        | =              | with(attributes(zd), |     |                  |     |     |             |
|                 |                | `scaled:center`      |     | + `scaled:scale` |     |     | * lev$zd) ) |
fibz.rg
| ### Compactify              |     | results | with a by          | variable     |     |         |     |
| --------------------------- | --- | ------- | ------------------ | ------------ | --- | ------- | --- |
| update(joint_tests(pigs.rg, |     |         | by                 | = "source"), | by  | = NULL) |     |
| xtable.emmGrid              |     |         | UsingxtableforEMMs |              |     |         |     |
Description
Thesemethodsprovidesupportforthextablepackage,enablingpolishedpresentationsoftabular
outputfromemmeansandotherfunctions.

104 xtable.emmGrid
Usage
| ## S3 method  | for class 'emmGrid'        |               |               |             |
| ------------- | -------------------------- | ------------- | ------------- | ----------- |
| xtable(x,     | caption = NULL,            | label = NULL, | align = NULL, |             |
| digits =      | 4, display =               | NULL, auto =  | FALSE, ...)   |             |
| ## S3 method  | for class 'summary_emm'    |               |               |             |
| xtable(x,     | caption = NULL,            | label = NULL, |               |             |
| align =       | NULL, digits =             | 4, display =  | NULL, auto =  | FALSE, ...) |
| ## S3 method  | for class 'xtable_emm'     |               |               |             |
| print(x, type | = getOption("xtable.type", |               | "latex"),     |             |
include.rownames = FALSE, sanitize.message.function = footnotesize, ...)
Arguments
| x       | ObjectofclassemmGrid             |     |     |     |
| ------- | -------------------------------- | --- | --- | --- |
| caption | PassedtoxtableList               |     |     |     |
| label   | PassedtoxtableList               |     |     |     |
| align   | PassedtoxtableList               |     |     |     |
| digits  | PassedtoxtableList               |     |     |     |
| display | PassedtoxtableList               |     |     |     |
| auto    | PassedtoxtableList               |     |     |     |
| ...     | Argumentspassedtosummary.emmGrid |     |     |     |
| type    | Passedtoprint.xtable             |     |     |     |
include.rownames
Passedtoprint.xtable
sanitize.message.function
Passedtoprint.xtable
Details
The methods actually use xtableList, because of its ability to display messages such as those
"xtable_emm"
for P-value adjustments. These methods return an object of class – an extension
| "xtableList". |     | xtable |     |     |
| ------------- | --- | ------ | --- | --- |
of Unlike other methods, the number of digits defaults to 4; and degrees
of freedom and t ratios are always formatted independently of digits. The print method uses
print.xtableList,andany...argumentsarepassedthere.
Value
Thextablemethodsreturnanxtable_emmobject,forwhichitsprintmethodisprint.xtable_emm
.
Examples
if(requireNamespace("xtable"))
emm_example("xtable")
| # Use emm_example("xtable", |     | list = TRUE) | # to just list | the code |
| --------------------------- | --- | ------------ | -------------- | -------- |

Index
∗datasets as.emm_list(as.list.emmGrid),5
auto.noise,8 as.emmGrid(as.list.emmGrid),5
feedlot,51 as.glht,4,95
fiber,52 as.glht(emm),24
MOats,62 as.glht.emmGrid,30
neuralgia,65 as.list.emmGrid,5
nutrition,66 as.mcmc.emm_list(as.mcmc.emmGrid),6
oranges,67 as.mcmc.emmGrid,6,30
pigs,68 as.mcmc.list.emm_list
ubds,98 (as.mcmc.emmGrid),6
+.emmGrid(rbind.emmGrid),78 as.mcmc.list.emmGrid,30
.all.vars(extending-emmeans),45 as.mcmc.list.emmGrid(as.mcmc.emmGrid),
.aovlist.dffun(extending-emmeans),45 6
.cmpMM(extending-emmeans),45 auto.noise,8
.combine.terms(extending-emmeans),45
.diag(extending-emmeans),45 cld.emm_list(cld.emmGrid),9
.emm_register(extending-emmeans),45 cld.emmGrid,9,30
.emm_vignette(extending-emmeans),45 coef.emm_list(emm_list),37
.get.excl(extending-emmeans),45 coef.emmGrid,30
.get.offset(extending-emmeans),45 coef.emmGrid(contrast),14
.hurdle.support(extending-emmeans),45 comb_facs,11
.my.vcov(extending-emmeans),45 confint.emm_list(emm_list),37
.num.key(extending-emmeans),45 confint.emmGrid,4,26,30,40,93
.std.link.labels(extending-emmeans),45 confint.emmGrid(summary.emmGrid),90
.zi.support(extending-emmeans),45 consec.emmc(contrast-methods),18
[,78 contr.poly,20
[.emmGrid,30 contrast,4,9,10,14,22,23,26,28,40,54,
[.emmGrid(rbind.emmGrid),78 73,90,100
[.summary_emm(summary.emmGrid),90 contrast-methods,18
contrast.emm_list,27
abbreviate,32 contrast.emm_list(emm_list),37
add_grouping(comb_facs),11 contrast.emmGrid,26,30,40,63,72
add_submodels(comb_facs),11 contrMat,19,20
all.vars,48
as.data.frame,93 data.frame,48,93
as.data.frame.emm_list(emm_list),37 del.eff.emmc(contrast-methods),18
as.data.frame.emmGrid,38 delete.response,47
as.data.frame.emmGrid diag,48
(summary.emmGrid),90 dotplot,70
as.data.frame.summary_eml(emm_list),37 drop,38
105

106 INDEX
dunnett.emmc(contrast-methods),18 joint_tests,27,54,92
eff.emmc(contrast-methods),18 levels<-.emmGrid(update.emmGrid),99
eff_size,22 linfct(str.emmGrid),89
emm,4,24,58 linfct.emm_list(emm_list),37
emm_basis,81 lm,22,82
emm_basis(extending-emmeans),45 lsm(lsmeans),58
emm_defaults(emm_options),39 lsmeans,58
emm_example,36 lsmip(lsmeans),58
emm_list,16,17,26,37 lsmobj(lsmeans),58
emm_options,31,39,53,58,82,84,85,91, lstrends(lsmeans),58
96,103
emmc-functions,15 make.link,59,61,87,100
emmc-functions(contrast-methods),18 make.meanint(joint_tests),54
emmeans,4,24,25,29,31,33,37,40,43–45, make.names,71
58,60,81,82,84,85,89,90,97,103 make.symmint(joint_tests),54
emmeans-package,3 make.tran,59,84,87,100
emmGrid,17,22,23,37,85 mcmc,7
emmGrid-class,29,91 mcmc-support(as.mcmc.emmGrid),6
emmip,4,30,40,58,100,101 mcmc.list,6,7
emmip_ggplot(emmip),30 mean_chg.emmc(contrast-methods),18
emmip_lattice(emmip),30 meanint(joint_tests),54
emmobj,5,6,34,35,58,77 MOats,62
emtrends,4,40,43,58,85 modelparm.emmwrap(emm),24
expand.grid,12,29,35,80 models,63
extending-emmeans,45,83 mvcontrast,63
mvregrid,64,94
feedlot,51
fiber,52 neuralgia,65
force_regular(rbind.emmGrid),78 nonest.basis,49
nrmlz.emmc(contrast-methods),18
get,50 nutrition,66
get.lsm.option(lsmeans),58
get_emm_option,58 Oats,62
get_emm_option(emm_options),39 offset,29
glht-support(emm),24 opoly.emmc(contrast-methods),18
glht.emmGrid(emm),24 oranges,67
glht.emmlf(emm),24
glmer.nb,83 p.adjust,20,95
grep,15 pairs.emm_list(emm_list),37
pairs.emmGrid,26,30,40,72
head.emmGrid(rbind.emmGrid),78 pairs.emmGrid(contrast),14
helmert.emmc(contrast-methods),18 pairwise.emmc(contrast-methods),18
hpd.summary,53,90,92,93,97 permute_levels(comb_facs),11
pigs,68
identity.emmc(contrast-methods),18 plot.emm_list(emm_list),37
interaction,12 plot.emmGrid,4,30,40,69,101
interaction.plot,33 plot.summary_emm(plot.emmGrid),69
inverse(make.tran),59 poly,20

INDEX 107
poly.emmc(contrast-methods),18 tukey.emmc(contrast-methods),18
predict,82
predict.emmGrid,30,31,40,70,100,101 ubds,98
predict.emmGrid(summary.emmGrid),90 untidy,99
print.emm_list(emm_list),37 update,93
print.emmGrid,30,39 update.emmGrid,5,13,15,26,30,35,42,59,
print.emmGrid(str.emmGrid),89 60,70,71,78,79,81,84,85,88,99
print.xtable,104 update.summary_emm(update.emmGrid),99
print.xtable_emm(xtable.emmGrid),103
print.xtableList,104
vcov,48,83
pwpm,10,72,75
vcov.emmGrid,30
pwpp,10,73,73
vcov.emmGrid(str.emmGrid),89
weights.emmGrid(contrast),14
qdrg,4,36,46,75,77
with_emm_options(emm_options),39
qr,48
wrappers,27
rbind,78
wrappers(lsmeans),58
rbind.emm_list,38
wtcon.emmc(contrast-methods),18
rbind.emm_list(rbind.emmGrid),78
xtable.emmGrid,30,103
rbind.emmGrid,17,30,78,94
xtable.summary_emm(xtable.emmGrid),103
rbind.summary_emm(rbind.emmGrid),78
xtableList,104
recover_data,81,82
recover_data(extending-emmeans),45
ref_grid,4,26–29,35,40,41,44,45,60,61,
76,80,89,101
regrid,23,64,81,84,87
revpairwise.emmc(contrast-methods),18
set.seed,95
split_fac(comb_facs),11
str.emm_list(emm_list),37
str.emmGrid,30,89,101
subset.emmGrid(rbind.emmGrid),78
summary.emm_list(emm_list),37
summary.emmGrid,4,26,28,30,40,49,53,
55,70,72,74,81,85,88,90,92,
99–101,104
summary_emm,10
symmint(joint_tests),54
tail.emmGrid(rbind.emmGrid),78
terms,47
test,54,56
test(summary.emmGrid),90
test.emm_list(emm_list),37
test.emmGrid,4,10,26,30,40
trt.vs.ctrl.emmc(contrast-methods),18
trt.vs.ctrl1.emmc(contrast-methods),18
trt.vs.ctrlk.emmc(contrast-methods),18
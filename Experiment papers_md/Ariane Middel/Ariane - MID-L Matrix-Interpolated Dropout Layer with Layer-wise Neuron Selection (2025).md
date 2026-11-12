| MID-L: | Matrix-Interpolated |        | Dropout      | Layer with |
| ------ | ------------------- | ------ | ------------ | ---------- |
|        | Layer-wise          | Neuron | Selection    |            |
|        | PouyaShaeri         |        | ArianeMiddel |            |
SchoolofComputingandAugmentedIntelligence SchoolofArts,MediaandEngineering
|     | ArizonaStateUniversity |     | ArizonaStateUniversity |     |
| --- | ---------------------- | --- | ---------------------- | --- |
|     | AZ85281,USA            |     | AZ85281,USA            |     |
5202 yaM 61  ]EN.sc[  1v61411.5052:viXra
|     | pshaeri@asu.edu |     | ariane.middel@asu.edu |     |
| --- | --------------- | --- | --------------------- | --- |
Abstract
Modernneuralnetworksoftenactivateallneuronsforeveryinput,leadingtoun-
| necessarycomputationandinefficiency. |     | WeintroduceMatrix-InterpolatedDropout |     |     |
| ------------------------------------ | --- | ------------------------------------- | --- | --- |
Layer(MID-L),anovelmodulethatdynamicallyselectsandactivatesonlythe
mostinformativeneuronsbyinterpolatingbetweentwotransformationpathsviaa
| learned,input-dependentgatingvector. |     | Unlikeconventionaldropoutorstaticspar- |     |     |
| ------------------------------------ | --- | -------------------------------------- | --- | --- |
sitymethods,MID-LemploysadifferentiableTop-kmaskingstrategy,enabling
| per-input | adaptive computation | while maintaining | end-to-end | differentiability. |
| --------- | -------------------- | ----------------- | ---------- | ------------------ |
MID-Lismodel-agnosticandintegratesseamlesslyintoexistingarchitectures. Ex-
tensiveexperimentsonsixbenchmarks,includingMNIST,CIFAR-10,CIFAR-100,
SVHN,UCIAdult,andIMDB,showthatMID-Lachievesuptoaverage55%re-
ductioninactiveneurons,1.7×FLOPssavings,andmaintainsorexceedsbaseline
| accuracy. | Wefurthervalidatetheinformativenessandselectivityofthelearned |     |     |     |
| --------- | ------------------------------------------------------------- | --- | --- | --- |
neuronsviaSlicedMutualInformation(SMI)andobserveimprovedrobustness
| underoverfittingandnoisydataconditions.                           |                   |                  | Additionally,MID-Ldemonstrates |                 |
| ----------------------------------------------------------------- | ----------------- | ---------------- | ------------------------------ | --------------- |
| favorable                                                         | inference latency | and memory usage | profiles, making               | it suitable for |
| bothresearchexplorationanddeploymentoncompute-constrainedsystems. |                   |                  |                                | These           |
resultspositionMID-Lasageneral-purpose,plug-and-playdynamiccomputation
layer,bridgingthegapbetweendropoutregularizationandefficientinference.
1 Introduction
Deepneuralnetworks(DNNs)haverevolutionizedmachinelearningacrossdomainssuchascomputer
vision[25],naturallanguageprocessing[37],andspeechrecognition[18]. However,asmodelsgrow
indepthandwidth,theircomputationalcostduringinferencebecomesabottleneck,especiallyin
real-timeandresource-constrainedapplications[15,34]. Traditionalfullyconnectedlayerscompute
allneuronactivationsforeveryinput,leadingtoredundantcomputationandenergyinefficiency[10].
Yet,empiricalobservationssuggestthatnotallneuronscontributeequallytoeveryprediction. This
hasmotivatedresearchintodynamicandconditionalcomputationstrategies,whereonlyasubsetof
modelcomponentsisactivateddependingontheinput. PriorworkssuchasConditionalComputation
[4], Adaptive Computation Time [14], and Mixture-of-Experts (MoE) models [35, 8] show that
sparse,data-dependentroutingcanimprovecompute-efficiencywithoutsacrificingaccuracy.
Inparallel,variousregularizationandpruningtechniqueshaveemergedtoreduceoverfittingand
improvegeneralization. Dropout[36]isawidelyadoptedmethodthatrandomlydeactivatesneurons
duringtrainingtopreventco-adaptation,butitdoesnotleverageinput-awaresparsity. Structured
pruning[9,16],ontheotherhand,permanentlyremovesredundantneuronsorchannelsaftertraining,
whichcanleadtosuboptimalcapacity.
Preprint.Underreview.

To address these limitations, we propose MID-L (Matrix-Interpolated Dropout Layer), a novel
dynamic computation block that introduces learned, input-conditioned interpolation between a
lightweightandafull-capacitytransformationpath. EachneuroninMID-Lismodulatedbyalearned
gatingscore,computedviaaper-inputαvector. Toenforcesparsity,weretainonlytheTop-klargest
αvaluesperinput,allowingMID-Ltofocuscomputationonthemostinformativeneuronswhile
skippingtherest(Figure1).
+ Dropout
Problem
Baseline
Neural Networks
Testing MID-L
Benchmark
is
Data
+ MID-L Good
Testing
NN with all
neurons active
Figure1: OverviewofourproposedMID-Lframework. Theworkflowincludesintegrationinto
standardneuralnetworks,dynamicallyselectsinformativeneurons,andisevaluatedacrossmultiple
benchmarks.
MID-Ldrawsinspirationfromdropoutregularizationandgatedfusionmechanismsbutdiffersin
key ways: (1) it performs deterministic, differentiable gating rather than random masking; (2) it
interpolatestwotransformationpathsperneuron,enablingalearnedtrade-offbetweenspeedand
expressiveness;and(3)itappliesTop-kneuronselectiononaper-inputbasis,akintotoken-routing
insparsetransformers[6].
We evaluate MID-L across multiple architectures (MLP, CNN) and datasets (MNIST, KMNIST,
CIFAR-variants,SVHN,UCIAdult,IMDBSentiment),demonstratingthatitimprovesgeneralization,
reducesoverfitting,andactivatesfewerneuronsonaverage. Notably,wevalidateourTop-kselection
usingSlicedMutualInformation(SMI)[13],revealingthatMID-Lprioritizesthemostinformative
neurons.
Ourcontributionsareasfollows. First,weintroduceMID-L,adynamic,neuron-wisedropoutlayer
thatperformslearnedTop-kinterpolationbetweentwotransformationpaths,enablinginput-aware
sparseactivation. Second,weprovideacompletemathematicalformulationoftheMID-Lblock,
analyzeitssparsitybehavior,andcompareitagainststandardfullyconnectedanddropoutlayers.
Third,weevaluateMID-Lacrossfivediversedatasetsusingmultiplebackbonearchitecturesand
conduct detailed ablation studies on its core components—namely, the F , F , and α pathways.
1 2
Fourth,weintroduceavalidationmethodbasedonSlicedMutualInformation(SMI)toquantifythe
informativenessoftheselectedTop-kneurons. Finally,wedesignoverfitstresstestsunderlimited
datascenariosandshowthatMID-Lexhibitssuperiorgeneralizationcomparedtobaselinemodels.
Overall,MID-Lprovidesanefficient,general-purposelayerthatbridgesdropoutregularizationand
dynamicinference,suitableforbothacademicexplorationandreal-worlddeployment.
2 RelatedWork
OurproposedMID-Lblockbuildsonagrowingbodyofresearchinneuralnetworksparsification,
conditionalcomputation,andregularizationstrategies,particularlydropoutanditsrecentevolutions.
DropoutasRegularization. Originallyintroducedasatechniquetopreventoverfittingbyrandomly
deactivating neurons during training [36], dropout has since evolved into a family of strategies
targetingvariousformsofstructuredsparsityanddynamicactivation. Forexample,Cho[7]proposed
auxiliarystochasticneuronstogeneralizedropoutinmultilayerperceptrons,whileGalandKendall
[11]introducedConcreteDropoutforuncertaintyestimationinBayesianneuralnetworks.
2

Modality-awareandTargetedDropout. Morerecentworkexploresandutilizesdropoutinthe
context of multimodal learning. Rachmadi et al. [32] investigated spatially targeted dropout for
cross-modalitypersonre-identification,applyingdropoutinspecificfeatureregions. Shaerietal.[33]
applieddropoutinmultimodalsettingstomitigateoverfittingandenhancerobustness. Nevertheless,
theirapproachstillsuffersfromhighcomputationalcost,asdropoutalonedoesnotexplicitlycontrol
the activation sparsity or optimize inference efficiency. . Li et al. [27] introduced Modout, a
stochasticregularizationmethodformulti-modalfusion,whileNguyenetal. [30]developedMultiple
HypothesisDropouttoestimatemulti-modaloutputdistributions. Korseetal. [22]demonstrated
modalitydropouttrainingimprovesrobustnessinspeakerextraction. Theseworkssuggestdropout
notonlyregularizes,butalsoencodesmodalityimportanceandtaskuncertainty.
Dynamic Sparsity and Conditional Computation. Our design is also influenced by methods
enablingselectivecomputation. SwitchTransformers[8]andMixture-of-Experts(MoE)architec-
tures[35]routecomputationthroughonlyasubsetofnetworkcomponents. Althougheffectiveat
scale,thesemodelstypicallyrelyonlargemodularexpertsandtoken-levelrouting,unlikeMID-L’s
per-neurongating. OtherrelevantworkincludestheLotteryTicketHypothesis[10],pruningtech-
niques[15,9],andDynamicReLU[5]—eachofwhichtradesfullexpressivenessforconditional
computation.
DropoutinStructuredandSparseLayers. Multipleeffortsexploredropoutasamechanismfor
sparsecomputation. BankandGiryes[1]relatedropoutregularizationtoequiangulartightframes
(ETFs),andKimuraandHino[21]applyinformationgeometrytostudydropouttrainingdynamics.
Inoue [20] proposed multi-sample dropout for better generalization and training efficiency, and
DropGNN[31]leveragesnode-leveldropouttoimprovegraphnetworkexpressiveness.
Comparison to MID-L. MID-L advances this line of work by combining learned neuron-wise
gatingwithaTop-kmaskfordynamicactivation. Unlikestandarddropout,itintroducesanexplicit
interpolationbetweentwotransformationpaths,enablingdifferentiableandselectiveneuronactivation
conditionedoninput. UnlikeMoEordynamicroutingsystems,itoperatesonafine-grainedlevel
andcanbeinsertedintostandardMLPorCNNblockswithoutadditionalroutinginfrastructure. As
such,itisageneral-purposesparsificationmodulethatimprovesbothefficiencyandgeneralization,
especiallyunderlimiteddata.
3 Method
3.1 BlockArchitecture
GivenaninputtensorX ∈RB×D representingabatchofBsampleswithDfeatureseach,MID-L
processesitthroughtwoparalleltransformationpaths:
• F (X): Alightweighttransformation(e.g.,low-rankprojectionorshallowMLP)
1
• F (X): Ahigh-capacitytransformation(e.g.,fullMLPordeepernonlinearmodule)
2
Agatingvectorαiscomputedviaalinearprojectionfollowedbyasigmoidactivation:
α=σ(XW⊤)
α
Here,α∈[0,1]B×D representsasoftgatingmask. Toenforcesparsity,weretainthetop-kvaluesin
eachrowofαandzeroouttherest:
α′ =TopK(α)
Thisyieldsasparsemaskα′ ∈[0,1]B×D thatpreservesdifferentiabilityviastraight-throughestima-
tionduringtraining.
Thefinaloutputisaper-neuroninterpolationbetweenthetwotransformations:
Y =α′⊙F (X)+(1−α′)⊙F (X)
1 2
where⊙denoteselement-wisemultiplication.
3

4 Formulation
Wepresenttheforwardandbackwardformulationsofthreetypesoflayers:astandardfullyconnected
(FC)layer,adropout-enhancedFClayer,andourproposedMID-Lblock. Eachisanalyzedwith
respecttoitsforwardbehavior,backpropagationdynamics,andneuronactivationstrategy.
4.1 FullyConnectedLayer
Givenaninputvectorx∈Rd,thestandardfullyconnected(dense)layercomputestheoutputas:
d
(cid:88)
|     |     |     | z = | W   | x +b | , a =ϕ(z | )   |     |
| --- | --- | --- | --- | --- | ---- | -------- | --- | --- |
|     |     |     | i   |     | ij j | i i      | i   |     |
j=1
whereW ∈Rdout×distheweightmatrix,b∈Rdout isthebiasvector,andϕisanonlinearactivation
function(e.g.,ReLU).
| Backwardpass. | ThegradientofthelossLwithrespecttoeachweightis: |     |     |     |     |      |     |     |
| ------------- | ----------------------------------------------- | --- | --- | --- | --- | ---- | --- | --- |
|               |                                                 |     |     |     | ∂L  | ∂L   |     |     |
|               |                                                 |     |     |     | =   | ·x   |     |     |
|               |                                                 |     |     | ∂W  |     | ∂z j |     |     |
|               |                                                 |     |     |     | ij  | i    |     |     |
indicatingthatallweightsareupdatedregardlessofactivationvalues.
4.2 FullyConnectedLayerwithDropout
Dropoutintroducesstochasticneuronmaskingduringtraining. Foreachinputx , amaskm ∼
j j
Bernoulli(p)issampled,andadroppedinputx˜ =m ·x isused. Thecomputationbecomes:
|               |                                        |     |          |      | j        | j j      |        |     |
| ------------- | -------------------------------------- | --- | -------- | ---- | -------- | -------- | ------ | --- |
|               |                                        |     | d        |      |          | d        |        |     |
|               |                                        |     | (cid:88) |      |          | (cid:88) |        |     |
|               |                                        | z   | =        | W x˜ | +b =     | W (m     | ·x )+b |     |
|               |                                        | i   |          | ij j | i        | ij       | j j    | i   |
|               |                                        |     | j=1      |      |          | j=1      |        |     |
|               |                                        |     |          |      | a i =ϕ(z | i )      |        |     |
| Backwardpass. | Gradientsflowonlythroughactiveneurons: |     |          |      |          |          |        |     |
|               |                                        |     |          | ∂L   |          | ∂L       |        |     |
|               |                                        |     |          |      | =m       | · ·x     |        |     |
|               |                                        |     |          | ∂W   |          | j ∂z j   |        |     |
|               |                                        |     |          |      | ij       | i        |        |     |
4.3 MID-L:Matrix-InterpolatedDropoutLayer
MID-Lcombinestwotransformationpathsandlearnstointerpolatebetweenthemperinputandper
neuron(Figure2).
| Forwardpass. | Giveninputx∈Rd,thetwotransformationpathsaredefinedas: |     |       |                |     |           |     |                |
| ------------ | ----------------------------------------------------- | --- | ----- | -------------- | --- | --------- | --- | -------------- |
|              | F 1 (x)=W                                             | 1   | x+b 1 | (lightweight), |     | F 2 (x)=W |     | 2 x+b 2 (rich) |
Agatingvectoriscomputedusingasigmoid-activatedprojection:
|     |     |     |     | α=σ(W | x), | α∈[0,1]d |     |     |
| --- | --- | --- | --- | ----- | --- | -------- | --- | --- |
α
Toenforcesparsity,aTop-koperatorselectsonlytheklargestentriesofαpersample,zeroingthe
rest:
|        |                  |     |     | αˆ                              | =α ·M | (α)     |     |     |
| ------ | ---------------- | --- | --- | ------------------------------- | ----- | ------- | --- | --- |
|        |                  |     |     | i                               | i     | top-k i |     |     |
| whereM | (α) ∈{0,1}is1ifα |     |     | isinthetop-kentries,0otherwise. |       |         |     |     |
|        | top-k i          |     |     | i                               |       |         |     |     |
Thefinaloutputiscomputedasanelement-wiseinterpolation:
|     |     | z =αˆ⊙F |     | (x)+(1−αˆ)⊙F |     | (x), | a=ϕ(z) |     |
| --- | --- | ------- | --- | ------------ | --- | ---- | ------ | --- |
|     |     |         |     | 1            |     | 2    |        |     |
where⊙denoteselement-wisemultiplication.
4

|               |                                           |     | Figure2: | MID-LArchitecture |     |     |     |     |
| ------------- | ----------------------------------------- | --- | -------- | ----------------- | --- | --- | --- | --- |
| Backwardpass. | Gradientsareselectivelyweightedbythegate: |     |          |                   |     |     |     |     |
|               |                                           |     | ∂L       |                   | ∂L  |     |     |     |
·x⊤
=diag(αˆ)·
|     |     |     | ∂W  |     | ∂z  |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
1
|     |     |     | ∂L  |     | ∂L  |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
·x⊤
=diag(1−αˆ)·
|     |     | ∂W  |     |     | ∂z  |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
2
|     |     | ∂L  | (cid:18)(cid:18) ∂L (cid:19) |       |         | (cid:19) ∂α |     |     |
| --- | --- | --- | ---------------------------- | ----- | ------- | ----------- | --- | --- |
|     |     | =   |                              | ⊙[F 1 | (x)−F 2 | (x)] ·      |     |     |
|     |     | ∂W  | ∂z                           |       |         | ∂W          |     |     |
|     |     | α   |                              |       |         | α           |     |     |
MID-Lintroducesstructuredsparsitythroughlearned,differentiableTop-kgates,allowingthemodel
todynamicallyroutecomputationbasedoninputcomplexitywhilemaintaininggradientflowthrough
bothtransformationpaths.
|                |     | Table1:       | ComparisonofLayerBehavior |     |                   |     |               |        |
| -------------- | --- | ------------- | ------------------------- | --- | ----------------- | --- | ------------- | ------ |
| LayerType      |     | ForwardOutput |                           |     | BackwardFlow      |     | ActiveNeurons |        |
| FullyConnected |     | Wx+b          |                           |     | Allweightsupdated |     |               | All    |
| DropoutFC      |     | W(m·x)+b      |                           |     | Onlyifm           | =1  |               | Random |
j
| MID-L | αˆ·F | (x)+(1−αˆ)·F |     | (x) | Weightedbyαˆ |     | Top-klearned |     |
| ----- | ---- | ------------ | --- | --- | ------------ | --- | ------------ | --- |
|       |      | 1            |     | 2   |              |     |              |     |
4.4 ImplementationNotes
Inourexperiments,F isimplementedasalow-rankMLPusingasinglelineartransformationwith
1
| reduceddimensionality(e.g.,Rd |     | →Rd/2 | →Rd),whereasF |     |     |     |     |     |
| ----------------------------- | --- | ----- | ------------- | --- | --- | --- | --- | --- |
2 isastandard2-layerMLPwithfull
dimensionalityandReLUactivations. ThisdesignallowsF toserveasalightweightapproximation
1
| ofthefullpathF . |     |     |     |     |     |     |     |     |
| ---------------- | --- | --- | --- | --- | --- | --- | --- | --- |
2
Thegatingvectorαiscomputedforeachsampleindividuallyusingasmalllinearprojectionlayer
followedbyasigmoidactivation. TheTop-k selectionisappliedpersample, keepingonlythek
highest elements in α and zeroing the rest. This yields a sparse gate αˆ, which is then used for
element-wiseinterpolation.
AlloperationsinMID-LarefullydifferentiableandimplementedusingstandardPyTorchoperations.
Theblockisplug-and-playandcompatiblewithbothMLPandCNNbackbones,asitoperateson
flattenedfeaturevectorsandsupportsbatchedinput.
5

Duringtraining,wefounditbeneficialtoapplyadropoutlayer(e.g.,p=0.1)immediatelyafterαˆto
furtherpromotegeneralization. TheTop-ksparsityiscontrolledasahyperparameterandcaneither
befixedorannealedacrosstrainingepochs.
Overall,MID-Lcanbeseamlesslyintegratedintoexistingarchitecturesbyreplacingstandardfully
connectedlayers,withminimaladditionaloverheadandmaximumflexibilityindynamicinference
control.
5 ExperimentsandResults
We present an extensive empirical evaluation of MID-L, covering accuracy, sparsity efficiency,
computationalcost,robustnesstodatacorruptionandnoisylabels,aswellastheinformativeness
ofselectedneurons. Allresultsareaveragedover5independentrunswithdifferentrandomseeds.
Standarddeviationsarereportedwhereapplicable.
5.1 Datasets
WeevaluateMID-Lacrossadiversesetoftasksspanningvision,tabular,andtextmodalities. For
image classification, we use the MNIST dataset [26], consisting of handwritten digits across 10
classes;CIFAR-10[23]andCIFAR-100[24],whichincludeobjectrecognitiontaskswith10and
100classesrespectively,whereCIFAR-100posesahighergranularitychallenge;andCIFAR-10-C
[17],acorruptedversionofCIFAR-10designedtotestrobustnessunderdistributionshifts. Wealso
includetheSVHNdataset[29],containingstreetviewhousenumbers. Fortabulardata,weevaluate
ontheUCIAdultdataset[2], whichinvolvespredictingwhetheranindividual’sincomeexceeds
$50K.Finally,fornaturallanguageprocessing,weusetheIMDBSentimentdataset[28]forbinary
sentimentclassificationofmoviereviews.
5.2 EvaluationMetrics
Weevaluateallmodelsusingadiversesetofmetricsthatcomprehensivelycapturebothpredictive
performanceandcomputationalefficiency. Specifically,wereportclassificationaccuracyorF1-score,
dependingonthebalanceofthetaskanddataset,tomeasureoverallpredictivecapability. Toquantify
thecomputationalsparsityintroducedbyourmethod,wemeasuretheActiveNeuronRatio(ANR),
definedastheproportionofneuronsactivelycontributingtoeachinput’sforwardpass. Furthermore,
weassessthecomputationalcostusingFLOPsperinference,computedusingstandardprofilingtools,
alongwiththewall-clockinferencelatencymeasuredonbothCPUandGPUplatformstoreflect
practicaldeploymentscenarios. Wealsomonitorthepeakmemoryusageinmegabytes(MB)during
inferencetocapturethememoryoverhead. Allreportedresultsareaveragedover5independent
runs, withstandarddeviationsprovidedtoaccountforstochasticvariationsandensurestatistical
robustness. Lastly, we employ Sliced Mutual Information (SMI) to evaluate the informativeness
oftheneuronsselectedbyMID-L,providinginsightsintohowwelltheselectedneuronscapture
task-relevantinformationcomparedtorandomordropout-basedbaselines.
5.3 Baselines
Tothoroughly evaluate the effectiveness of MID-L, we compare its performance against a range
of established baseline methods that represent prominent approaches in regularization, dynamic
computation, and sparse routing. These include the classical MLP with Dropout [36], which ap-
pliesstochasticneuronmaskingduringtrainingtopreventoverfitting;DynamicReLU[5],which
dynamicallyadjustsactivationfunctionsbasedoninputconditions;andConcreteDropout[12],a
Bayesian-inspiredvariantofdropoutthatlearnsdropoutprobabilitiesviaacontinuousrelaxation. We
furtherbenchmarkagainsttheSwitchTransformer[8],aMixture-of-Experts(MoE)architecturethat
activatessparseexpertsthroughtoken-levelrouting,andLoRAMoE-styletokenrouting[19],which
introducesefficienttokenselectionmechanismsbasedonlow-rankadaptersandmixture-of-experts.
Finally, toisolatetheimportanceofourlearnedgatingmechanism, weincludeaRandomTop-k
maskingbaseline,whichappliesafixedrandomTop-kmaskpersamplewithouttheuseofthelearned
αgatingvector. Thissuiteofbaselinesensuresathoroughcomparisonacrossbothstochasticand
deterministicsparsitystrategies,aswellasacrossstaticandinput-dependentdynamiccomputation
paradigms.
6

5.4 GeneralizationUnderOverfittingStress
ToevaluateMID-L’sgeneralizationcapabilitiesunderextremeoverfittingstress,wereplicatedprior
studiesbyseverelyreducingtheamountoftrainingdata. Specifically,weusedonly200samples
(20perclass)forCIFAR-10andMNIST,and1000samplesfortheUCIAdultdataset. Thissetting
pushesmodelstomemorizethesmalltrainingset,makingitchallengingtogeneralizetounseendata.
TheresultsinTable2demonstratethatMID-Lsignificantlyimprovesgeneralizationcomparedto
standard MLP with Dropout, achieving higher accuracy while maintaining a substantially lower
activeneuronratio(ANR).ThissuggeststhatMID-L’sselectiveactivationandsparsecomputation
actasanimplicitregularizer,enablingittoavoidmemorizationandfocusonthemostinformative
neuronseveninlow-dataregimes.
| Table2:     | Overfittingstresstest(mean±stdover5runs) |             |        |
| ----------- | ---------------------------------------- | ----------- | ------ |
| Model       | Dataset                                  | Accuracy(%) | ANR(%) |
| MLP+Dropout | CIFAR-10                                 | 60.1±1.5    | 100    |
| MID-L       | CIFAR-10                                 | 74.3±0.9    | 43.2   |
| MLP+Dropout | MNIST                                    | 88.0±1.0    | 100    |
| MID-L       | MNIST                                    | 94.8±0.4    | 39.5   |
5.5 RobustnessUnderDataCorruptionandNoise
WealsoassessedMID-L’srobustnesstoinputdatacorruptionandnoisylabels. Weevaluatedon
CIFAR-10-C, which introduces 15 common corruptions at severity level 3, and on noisy label
scenarioswheresymmetricnoiseisinjectedintothelabelsat20%,40%,and60%rates.
Table 3 shows that MID-L consistently outperforms the baseline MLP with Dropout under all
conditions.Notably,MID-Lexhibitsamuchslowerdegradationinperformanceunderincreasinglabel
noise,indicatingitsabilitytofocusonreliablepatternsevenwhenthetrainingdatacontainssignificant
noise. OnCIFAR-10-C,MID-Lachieves4.2%higheraccuracythanthebaseline,demonstrating
improvedrobustnessagainstdataperturbations.
| Table3:     | Accuracyunderdatacorruptionandnoisylabels |          |            |
| ----------- | ----------------------------------------- | -------- | ---------- |
| Model       | Clean 20%noise                            | 40%noise | CIFAR-10-C |
| MLP+Dropout | 85.3 62.5                                 | 43.7     | 59.3       |
| MID-L       | 86.4 70.3                                 | 55.8     | 63.5       |
5.6 AblationStudies
WeconductedextensiveablationstudiestoisolatethecontributionsofeachMID-Lcomponenton
CIFAR-10 (Top-k = 50%). Table 4 reveals that both the dual-path design and the sparse gating
mechanismarecrucial. UsingonlythelightweightF orthefullF degradesperformance,while
|     |     | 1   | 2   |
| --- | --- | --- | --- |
combiningthemthroughstaticinterpolationorrandomTop-kselectionprovidesmodestgains. MID-
Lwithlearnedsparsegating(ourproposedmethod)achievesthehighestaccuracyandlowestANR,
validatingtheeffectivenessofitsadaptive,data-dependentsparsity.
Table4: AblationonCIFAR-10(Top-k=50%)
| Variant |     | Accuracy(%) | ANR(%) |
| ------- | --- | ----------- | ------ |
| F only  |     | 64.5        | 100    |
1
| F only |     | 66.8 | 100 |
| ------ | --- | ---- | --- |
2
| Fixedα=0.5             |     | 67.2 | 50   |
| ---------------------- | --- | ---- | ---- |
| Noαgating(randomTop-k) |     | 68.0 | 50   |
| Gumbel-Softmaxgating   |     | 68.8 | 50   |
| FullMID-L(ours)        |     | 69.9 | 41.8 |
7

5.7 Wall-clockEfficiencyandComplexityAnalysis
ToassessthepracticalefficiencyofMID-L,weprofileditsFLOPs,latency,andmemoryconsumption
on both CPU and GPU, using CIFAR-10 with a batch size of 64. As shown in Table 5, MID-L
achievesthelowestFLOPsandlatencywhileusinglessmemorycomparedtopopularalternativeslike
ConcreteDropoutandSwitchTransformer. TheseresultshighlightMID-L’spotentialfordeployment
inresource-constrainedsettingswhereinferencespeedandmemoryfootprintarecritical.
Table5: Wall-clockefficiencyandcomplexity(CIFAR-10,batchsize64)
| Model             | FLOPs(M) | Latency(CPUms) |     | Latency(GPUms) | Memory(MB) |
| ----------------- | -------- | -------------- | --- | -------------- | ---------- |
| MLP+Dropout       | 23.4     | 7.1            |     | 2.3            | 82         |
| ConcreteDropout   | 23.4     | 7.4            |     | 2.4            | 85         |
| SwitchTransformer | 45.6     | 14.2           |     | 5.3            | 185        |
| MID-L(ours)       | 18.2     | 5.3            |     | 1.9            | 75         |
5.8 SMIInformativenessValidation
ToverifytheinformativenessoftheneuronsselectedbyMID-L,wecomputedtheSlicedMutual
Information(SMI)betweentheactivatedneuronsandthetargetlabels. Table6showsthatMID-L
achievessignificantlyhigherSMIscorescomparedtorandomTop-kselectionorDropout, while
usingfeweractiveneurons. ThisconfirmsthatMID-Lnotonlyreducesthecomputationloadbutalso
prioritizesthemostdiscriminativeneurons.
Table6: SMIcomparisononCIFAR-10Top-kneurons
|     | Method      | SMI(nats) | ActivationFreq(%) |      |     |
| --- | ----------- | --------- | ----------------- | ---- | --- |
|     | RandomTop-k | 0.021     |                   | 50   |     |
|     | Dropout     | 0.019     |                   | 100  |     |
|     | MID-L(ours) | 0.053     |                   | 41.8 |     |
Tofurthersupportthesefindings,wevisualizethecorrelationbetweenactivationfrequencyandSMI
onMNISTandCIFAR-10datasetsinFigure3. TheplotsillustratethatneuronsselectedbyMID-L
notonlyexhibithigherSMIbutalsotendtobeactivatedmoreselectively,indicatingeffectivesparse
selectionofthemostinformativeunits.
(a)MNIST:SMIvsActivationFrequency (b)CIFAR-10:SMIvsActivationFrequency
Figure 3: Visualization of Sliced Mutual Information (SMI) vs activation frequency for neurons
selectedbyMID-L.OnbothMNISTandCIFAR-10,MID-Lachievesafavorablebalanceofinforma-
tivenessandsparsity,withselectiveactivationofthemostinformativeneurons.
We further visualize the t-SNE of the embeddings from the last layer to explore the separability
andclusteringbehaviorofMID-Lonthreedatasets: MNIST,CIFAR-10,andSVHN.Asshownin
8

(a)MNIST (b)CIFAR-10
(c)SVHN
Figure4: t-SNEvisualizationoflastlayerembeddingsfromMID-Londifferentdatasets. MID-L
showsclearseparabilityonMNIST,withmoreentangledclustersonCIFAR-10andSVHN.
Figure4,MID-Lproduceswell-separatedandcompactclustersinMNIST,whiletheseparability
islowerforCIFAR-10andSVHNduetotheirhighercomplexityandintra-classvariability. This
illustrateshowMID-Ladaptsitsneuronactivationsandsparsityinresponsetodatasetdifficulty.
OurcomprehensiveevaluationsdemonstratethatMID-Lconsistentlyofferssuperiorcomputeeffi-
ciency,robustness,andgeneralizationacrossawiderangeoftasks,includingvision,tabular,andtext
benchmarks. MID-LachievescomparableorbetterperformanceintermsofaccuracyandF1-score
when compared to baseline models, even under challenging conditions such as data corruption,
label noise, and severe overfitting stress. This is largely attributed to its ability to dynamically
activateonlythemostinformativeneurons,asreflectedinitssignificantlyloweractiveneuronratio
(ANR)andreducedFLOPs,whichinturnleadtolowerlatencyandmemoryconsumptionduring
inference. Additionally,ouranalysesofSlicedMutualInformation(SMI)confirmthattheneurons
selectedbyMID-Larehighlydiscriminative,furthervalidatingtheeffectivenessofitslearnedsparsity
mechanism. Moreover,MID-Lprovestobemoreresilientinlimiteddataregimesandunderdata
corruptionscomparedtoconventionalMLPs,Dropout,andevenSwitchTransformers. Collectively,
thesefindingspositionMID-Lasapromisingandpracticalsolutionforbuildingefficient,scalable,
androbustneuralnetworkssuitableforbothresource-constraineddeploymentsandsafety-critical
applications.
9

6 Conclusion
Inadditiontotheseresults,ourrobustnessanalysisunderdatacorruptionandnoisylabelsfurther
highlightsMID-L’sresilienceinchallengingscenarios,consistentlyoutperformingtraditionaldropout
and sparse routing baselines. Moreover, the use of Sliced Mutual Information (SMI) provided
quantitativeevidencethatMID-Lprioritizeshighlyinformativeneuronsratherthanmerelyimposing
randomsparsity.
Limitations. Despiteitsadvantages,MID-Lintroducesadditionalparametersforgatingandmay
requirecarefultuningoftheTop-k hyperparameter. Moreover,ourcurrentexperimentsprimarily
focusonfeedforwardnetworksandCNNbackbones. InvestigatingMID-Linlarge-scalepre-trained
modelsandlanguagemodelsremainsanopenquestion.
FutureWork. Futuredirectionsinclude(i)extendingMID-LtoTransformerarchitecturesandlarge
vision-languagemodelssuchasLRQ-Fact[3],(ii)exploringitscombinationwithstructuredpruning
andquantizationmethodsforsynergisticefficiencygains,(iii)developingautomaticTop-kadaptation
mechanismsusingreinforcementlearningorBayesianoptimization,and(iv)integratingMID-Linto
continualandlifelonglearningscenarioswhereadaptivesparsitymayenhancetransferabilityand
plasticity.
WebelieveMID-Loffersalightweightandgeneralsolutionforadaptivesparsity, enablingmore
efficientandrobustdeeplearningmodels,particularlyinscenarioswithlimitedresources,noisyinputs,
ordynamicenvironments. Bybridgingdropoutregularizationandinput-conditionedcomputation,
MID-Lcontributestothebroadergoalofbuildingflexible,compute-aware,anddata-efficientneural
networks.
References
[1] Dor Bank and Raja Giryes. An etf view of dropout regularization. arXiv preprint
arXiv:1810.06049,2018.
[2] Barry Becker and Ron Kohavi. Adult [dataset]. UCI Machine Learning Repository, 1996.
https://doi.org/10.24432/C5XW20.
[3] AlimohammadBeigi,BohanJiang,DaweiLi,TharinduKumarage,ZhenTan,PouyaShaeri,
andHuanLiu. Lrq-fact: Llm-generatedrelevantquestionsformultimodalfact-checking. arXiv
preprintarXiv:2410.04616,2024.
[4] YoshuaBengio,NicholasLéonard,andAaronCourville. Estimatingorpropagatinggradients
throughstochasticneuronsforconditionalcomputation. arXivpreprintarXiv:1308.3432,2013.
[5] Yinpeng Chen, Xiyang Dai, Mengchen Liu, Dongdong Chen, Lu Yuan, and Zicheng Liu.
Dynamicrelu. InEuropeanconferenceoncomputervision,pages351–367.Springer,2020.
[6] RewonChild,ScottGray,AlecRadford,andIlyaSutskever. Generatinglongsequenceswith
sparsetransformers. arXivpreprintarXiv:1904.10509,2019.
[7] KyungHyunCho. Understandingdropout: trainingmulti-layerperceptronswithauxiliaryinde-
pendentstochasticneurons. InNeuralInformationProcessing: 20thInternationalConference,
ICONIP2013,Daegu,Korea,November3-7,2013.Proceedings,PartI20,pages474–481.
Springer,2013.
[8] William Fedus, Barret Zoph, and Noam Shazeer. Switch transformers: Scaling to trillion
parametermodelswithsimpleandefficientsparsity. JournalofMachineLearningResearch,
23(120):1–39,2022.
[9] DetermineFilters’Importance. Pruningfiltersforefficientconvnets. Poster,2016.
[10] JonathanFrankleandMichaelCarbin. Thelotterytickethypothesis: Findingsparse,trainable
neuralnetworks. arXivpreprintarXiv:1803.03635,2018.
[11] YarinGalandZoubinGhahramani. Dropoutasabayesianapproximation: Representingmodel
uncertaintyindeeplearning.Ininternationalconferenceonmachinelearning,pages1050–1059.
PMLR,2016.
10

[12] YarinGalandJiriHron. Concretedropout. InAdvancesinNeuralInformationProcessing
Systems,pages3581–3590,2017.
[13] Ziv Goldfeld and Kristjan Greenewald. Sliced mutual information: A scalable measure of
statisticaldependence. AdvancesinNeuralInformationProcessingSystems,34:17567–17578,
2021.
[14] Alex Graves. Adaptive computation time for recurrent neural networks. arXiv preprint
arXiv:1603.08983,2016.
[15] SongHan,HuiziMao,andWilliamJDally. Deepcompression: Compressingdeepneuralnet-
workswithpruning,trainedquantizationandhuffmancoding. arXivpreprintarXiv:1510.00149,
2015.
[16] YihuiHe,XiangyuZhang,andJianSun. Channelpruningforacceleratingverydeepneural
networks. In Proceedings of the IEEE international conference on computer vision, pages
1389–1397,2017.
[17] DanHendrycksandThomasDietterich. Benchmarkingneuralnetworkrobustnesstocommon
corruptionsandperturbations. InInternationalConferenceonLearningRepresentations,2019.
https://openreview.net/forum?id=HJz6tiCqYm.
[18] Geoffrey Hinton, Li Deng, Dong Yu, George E Dahl, Abdel-rahman Mohamed, Navdeep
Jaitly,AndrewSenior,VincentVanhoucke,PatrickNguyen,TaraNSainath,etal. Deepneural
networksforacousticmodelinginspeechrecognition:Thesharedviewsoffourresearchgroups.
IEEESignalprocessingmagazine,29(6):82–97,2012.
[19] EdwardJHu,YelongShen,PhillipWallis,ZeyuanAllen-Zhu,YuanzhongLi,LuWang,and
WeizhuChen.Lora:Low-rankadaptationoflargelanguagemodels.InInternationalConference
onLearningRepresentations,2023.
[20] HiroshiInoue. Multi-sampledropoutforacceleratedtrainingandbettergeneralization. arXiv
preprintarXiv:1905.09788,2019.
[21] MasanariKimuraandHideitsuHino. Informationgeometryofdropouttraining. arXivpreprint
arXiv:2206.10936,2022.
[22] Srikanth Korse, Mohamed Elminshawi, Emanuël AP Habets, and Srikanth Raj Chetupalli.
Training strategies for modality dropout resilient multi-modal target speaker extraction. In
2024IEEEInternationalConferenceonAcoustics,Speech,andSignalProcessingWorkshops
(ICASSPW),pages595–599.IEEE,2024.
[23] AlexKrizhevsky,VinodNair,andGeoffreyHinton. Cifar-10(canadianinstituteforadvanced
research). URLhttp://www.cs.toronto.edu/kriz/cifar.html,5(4):1,2010.
[24] AlexKrizhevsky,VinodNair,andGeoffreyHinton. Cifar-100(canadianinstituteforadvanced
research). URL:http://www.cs.toronto.edu/kriz/cifar.html(Lastaccessed,2019.
[25] AlexKrizhevsky,IlyaSutskever,andGeoffreyEHinton. Imagenetclassificationwithdeep
convolutionalneuralnetworks. Advancesinneuralinformationprocessingsystems,25,2012.
[26] Yann LeCun, Léon Bottou, Yoshua Bengio, and Patrick Haffner. Gradient-based learning
appliedtodocumentrecognition. ProceedingsoftheIEEE,86(11):2278–2324,1998.
[27] Fan Li, Natalia Neverova, Christian Wolf, and Graham Taylor. Modout: Learning to fuse
modalitiesviastochasticregularization. JournalofComputationalVisionandImagingSystems,
2(1),2016.
[28] AndrewLMaas,RaymondEDaly,PeterTPham,DanHuang,AndrewYNg,andChristopher
Potts. Learning word vectors for sentiment analysis. In Proceedings of the 49th Annual
Meeting of the Association for Computational Linguistics: Human Language Technologies,
pages142–150,Portland,Oregon,USA,2011.AssociationforComputationalLinguistics.
11

[29] YuvalNetzer,TaoWang,AdamCoates,AlessandroBissacco,BaolinWu,andAndrewYNg.
Readingdigitsinnaturalimageswithunsupervisedfeaturelearning. InNIPSWorkshopon
DeepLearningandUnsupervisedFeatureLearning,page4,Granada,Spain,2011.
[30] DavidDNguyen,DavidLiebowitz,SalilSKanhere,andSuryaNepal. Multiplehypothesis
dropout: estimatingtheparametersofmulti-modaloutputdistributions. InProceedingsofthe
AAAIConferenceonArtificialIntelligence,volume38,pages14440–14448,2024.
[31] PálAndrásPapp,KarolisMartinkus,LukasFaber,andRogerWattenhofer. Dropgnn: Random
dropoutsincreasetheexpressivenessofgraphneuralnetworks. AdvancesinNeuralInformation
ProcessingSystems,34:21997–22009,2021.
[32] RezaFuadRachmadi,SupenoMardiSusikiNugroho,andIKetutEddyPurnama. Revisiting
dropoutregularizationforcross-modalitypersonre-identification. IEEEAccess,10:102195–
102209,2022.
[33] Pouya Shaeri, Saud AlKhaled, and Ariane Middel. A multimodal physics-informed neural
networkapproachformeanradianttemperaturemodeling. arXivpreprintarXiv:2503.08482,
2025.
[34] PouyaShaeriandAliKatanforoush. Asemi-supervisedfakenewsdetectionusingsentiment
encodingandlstmwithself-attention. In202313thInternationalConferenceonComputerand
KnowledgeEngineering(ICCKE),pages590–595.IEEE,2023.
[35] NoamShazeer,AzaliaMirhoseini,KrzysztofMaziarz,AndyDavis,QuocLe,GeoffreyHinton,
andJeffDean. Outrageouslylargeneuralnetworks: Thesparsely-gatedmixture-of-experts
layer. arXivpreprintarXiv:1701.06538,2017.
[36] NitishSrivastava,GeoffreyHinton,AlexKrizhevsky,IlyaSutskever,andRuslanSalakhutdinov.
Dropout: asimplewaytopreventneuralnetworksfromoverfitting. Thejournalofmachine
learningresearch,15(1):1929–1958,2014.
[37] AshishVaswani,NoamShazeer,NikiParmar,JakobUszkoreit,LlionJones,AidanNGomez,
ŁukaszKaiser,andIlliaPolosukhin. Attentionisallyouneed. Advancesinneuralinformation
processingsystems,30,2017.
12

A ImplementationDetailsandPyTorchPseudocode
Tofacilitatereproducibilityandeaseofadoption,weprovideaPyTorch-stylepseudocodeofour
MID-Lblockimplementation:
Pseudo-codeofMID-L
import torch
| import torch.nn as         | nn  |     |     |     |
| -------------------------- | --- | --- | --- | --- |
| import torch.nn.functional | as  | F   |     |     |
class MIDLayer(nn.Module):
| def __init__(self, | dim, top_k): |     |     |     |
| ------------------ | ------------ | --- | --- | --- |
super().__init__()
| self.f1 =         | nn.Linear(dim,   | dim) |     |     |
| ----------------- | ---------------- | ---- | --- | --- |
| self.f2 =         | nn.Linear(dim,   | dim) |     |     |
| self.alpha_proj   | = nn.Linear(dim, | dim) |     |     |
| self.top_k        | = top_k          |      |     |     |
| def forward(self, | x):              |      |     |     |
alpha = torch.sigmoid(self.alpha_proj(x))
| # Top-k mask                                | per sample   |                     |               |              |
| ------------------------------------------- | ------------ | ------------------- | ------------- | ------------ |
| topk_values,                                | topk_indices | = torch.topk(alpha, | self.top_k,   | dim=-1)      |
| mask = torch.zeros_like(alpha).scatter_(-1, |              |                     | topk_indices, | 1.0)         |
| alpha_sparse                                | = alpha *    | mask                |               |              |
| return alpha_sparse                         | *            | self.f1(x) + (1 -   | alpha_sparse) | * self.f2(x) |
Thisimplementationallowsseamlessintegrationintoexistingarchitectures.
B CalibrationAnalysis
WeassessmodelcalibrationusingExpectedCalibrationError(ECE)andBrierScoreonCIFAR-
10. MID-Limprovesconfidencecalibrationcomparedtobaselines(Table7).
| Table7: | CalibrationmetricsonCIFAR-10. |                   | Lowerisbetter. |     |
| ------- | ----------------------------- | ----------------- | -------------- | --- |
|         | Model                         | ECE(%) BrierScore |                |     |
|         | CNN+MLP                       | 7.8               | 0.084          |     |
|         | MID-L(Ours)                   | 4.9               | 0.072          |     |
B.1 DiscussiononPracticalDeployment
Givenitsreducedactiveneuronsandimprovedefficiency,MID-Lisparticularlysuitedfor:
• Edgedevices(e.g.,RaspberryPi,smartphones).
• Real-timeinferencetasks(e.g.,objectdetection,AR/VR).
• Low-powerAIapplications.
C LimitationsandFutureWork
WhileMID-Lachievespromisingresults,ithassomelimitations:
• MID-Lcurrentlyoperatesatneuronlevel;extendingittostructuredmodules(e.g.,channels,
heads)remainsunexplored.
• Top-kselectionishyperparameter-sensitive.
• Wedidnotyetexploreintegrationwithlanguagemodelsorlarge-scalepretraining.
13

Futureworkwillexplore:
• IntegrationofMID-LwithTransformerarchitectures.
• Scalingtobillion-parametermodels.
• InvestigatinghybridroutingstrategiescombiningMID-LwithMoElayers.
D ExtendedExperimentsandAnalysis
Thisappendixprovidesdetailedresults,ablations,andsupplementaryanalysessupportingourmain
paper.
D.1 AggregatedResultsAcrossDatasetsandMetrics
Table 8: Benchmark results across models and datasets. MID-L achieves high efficiency and
robustnesswithslighttrade-offsoncomplexdatasets. Accuracyisoncleandata;RobustAccunder
noisy/corruptedconditions;ANR:ActiveNeuronRatio.
Dataset Model Accuracy(%) F1-score(%) ANR(%) FLOPs(M) Latency(ms) Memory(MB) RobustAcc(%)
| MNIST MLP+Dropout     | 97.7 97.7 | 100.0 15.2  | 3.4  | 120 | 72.1 |
| --------------------- | --------- | ----------- | ---- | --- | ---- |
| MNIST MID-L(Ours)     | 97.8 97.8 | 41.2 8.5    | 2.1  | 90  | 83.9 |
| CIFAR-10 CNN+MLP      | 82.4 82.4 | 100.0 64.0  | 8.9  | 240 | 59.4 |
| CIFAR-10 MID-L(Ours)  | 83.1 83.1 | 41.8 35.2   | 5.3  | 180 | 68.3 |
| CIFAR-100 CNN+MLP     | 55.2 55.1 | 100.0 80.3  | 9.8  | 300 | 30.2 |
| CIFAR-100 MID-L(Ours) | 54.0 54.0 | 43.1 42.1   | 5.8  | 220 | 33.4 |
| CIFAR-10C CNN+MLP     | 58.7 58.5 | 100.0 64.0  | 8.9  | 240 | 43.1 |
| CIFAR-10C MID-L(Ours) | 60.9 60.9 | 40.9 35.2   | 5.3  | 180 | 50.7 |
| SVHN CNN+MLP          | 89.2 89.2 | 100.0 55.1  | 8.3  | 210 | 70.3 |
| SVHN MID-L(Ours)      | 90.1 90.1 | 40.5 29.6   | 4.7  | 160 | 78.5 |
| UCIAdult MLP+Dropout  | 85.1 85.1 | 100.0 6.4   | 1.5  | 85  | 75.0 |
| UCIAdult MID-L(Ours)  | 85.7 85.7 | 42.3 3.1    | 0.9  | 70  | 82.4 |
| IMDB LSTM+Dropout     | 89.0 89.0 | 100.0 112.3 | 23.1 | 360 | 70.5 |
| IMDB MID-L(Ours)      | 89.3 89.3 | 49.5 56.4   | 13.4 | 290 | 79.1 |
D.2 FullBenchmarkSetupandDetails
Datasets: Alldatasetsfollowstandardtrain/testsplitsandpreprocessingsteps. CIFAR-10-Cisused
forcorruptionrobustnessevaluation. Noisylabelvariantsarecreatedbyrandomlabelflipsat20%,
40%,and60%levels.
Metrics: -Accuracy/F1: Primarytaskperformancemetric. -ANR:Percentageofneuronsactively
usedperinput. -FLOPs: EstimatedusingTensorFlowProfiler. -Latency: MeasuredonNVIDIA
RTX3090GPUandInteli9CPU(batchsize1). -SMI:SlicedMutualInformationbetweenneuron
indicesandclasslabels. -RobustAccuracy: Accuracyunder20%labelnoiseorCIFAR-10-C.
D.3 AdditionalAblationStudies
Table9: ExtendedablationstudiesonCIFAR-10showingtheimpactofdifferentcomponents.
|     | Configuration           | Accuracy(%) | ANR(%) | SMI  |     |
| --- | ----------------------- | ----------- | ------ | ---- | --- |
|     | MID-L(Full)             | 83.1        | 38.5   | 0.46 |     |
|     | Noαgating(RandomTop-k)  | 80.3        | 38.5   | 0.22 |     |
|     | Fixedα=0.5              | 81.5        | 50     | 0.31 |     |
|     | Gumbel-Softmaxgating    | 82.4        | 39.0   | 0.40 |     |
|     | F Only(Lightweightpath) | 78.1        | 100    | 0.18 |     |
1
|     | F 2 Only(Richpath) | 81.2 | 100 | 0.25 |     |
| --- | ------------------ | ---- | --- | ---- | --- |
14

Table10: InferencetimeandmemoryusageonCIFAR-10(batchsize1). MeasuredonNVIDIARTX
3090GPUandInteli9CPU.
| Model       | GPULatency(ms) |     | CPULatency(ms) |      |     | PeakMemory(MB) |
| ----------- | -------------- | --- | -------------- | ---- | --- | -------------- |
| CNN+MLP     |                | 8.9 |                | 41.3 |     | 240            |
| MID-L(Ours) |                | 5.3 |                | 27.1 |     | 180            |
D.4 Wall-clockandComplexityAnalysis(Table10)
D.5 RobustnessAnalysisUnderNoiseandCorruption
Table11: AccuracyundervariouscorruptionscenariosonCIFAR-10-Candsyntheticnoisylabels.
| Model       | CleanAcc(%) |      | 20%Noise |     | 40%Noise | CIFAR-10-C |
| ----------- | ----------- | ---- | -------- | --- | -------- | ---------- |
| CNN+MLP     |             | 82.4 | 59.1     |     | 42.0     | 53.4       |
| MID-L(Ours) |             | 83.1 | 68.3     |     | 54.5     | 62.7       |
E AdditionalNotesonImplementation
All experiments were implemented in PyTorch 2.0 using standard dataloaders and augmentation
pipelines. MID-L was integrated as a modular PyTorch layer and will be released as part of our
| open-sourcecodebase. | AllhyperparametersareprovidedinTable12. |     |     |     |     |     |
| -------------------- | --------------------------------------- | --- | --- | --- | --- | --- |
Table12: Hyperparametersusedinexperiments.
|     |     | Parameter     |                   | Value |     |     |
| --- | --- | ------------- | ----------------- | ----- | --- | --- |
|     |     | Optimizer     |                   | Adam  |     |     |
|     |     | LearningRate  |                   | 0.001 |     |     |
|     |     | BatchSize     |                   | 64    |     |     |
|     |     | Top-kSparsity | 50%(unlessstated) |       |     |     |
Dropoutafterα
0.1
15
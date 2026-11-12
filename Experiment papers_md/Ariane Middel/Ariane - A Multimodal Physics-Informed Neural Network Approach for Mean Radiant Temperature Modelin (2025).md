A Multimodal Physics-Informed Neural Network Approach for Mean Radiant
|     |     |     |     |     | Temperature |     | Modeling |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | ----------- | --- | -------- | --- | --- | --- | --- | --- | --- |
PouyaShaeri
SchoolofComputingandAugmentedIntelligence,ArizonaStateUniversity
pshaeri@asu.edu
5202 raM 11  ]VC.sc[  1v28480.3052:viXra SaudAlKhaled
CollegeofArchitecture,KuwaitUniversity
salkhaled@ku.edu.kw
ArianeMiddel
SchoolofArts,MediaandEngineering,ArizonaStateUniversity
ariane.middel@asu.edu
|     |     | Abstract |     |     |     |     | 1.Introduction |     |     |     |     |     |     |
| --- | --- | -------- | --- | --- | --- | --- | -------------- | --- | --- | --- | --- | --- | --- |
Climatechangeandrapidurbanizationareintensifyingheat
Outdoorthermalcomfortisacriticaldeterminantofurban
livability,particularlyinhotdesertclimateswhereextreme exposure in cities, exacerbating urban heat islands and in-
|     |     |     |     |     |     |     | creasing | the risk | of heat-related |     | health | issues, | energy con- |
| --- | --- | --- | --- | --- | --- | --- | -------- | -------- | --------------- | --- | ------ | ------- | ----------- |
heatposeschallengestopublichealth,energyconsumption,
andurbanplanning. MeanRadiantTemperature(T )is sumption, and infrastructure stress [18, 24, 37]. One of
mrt
|                 |     |            |     |         |         |          | the most | important | metrics | for | evaluating | thermal | expo- |
| --------------- | --- | ---------- | --- | ------- | ------- | -------- | -------- | --------- | ------- | --- | ---------- | ------- | ----- |
| a key parameter | for | evaluating |     | outdoor | thermal | comfort, |          |           |         |     |            |         |       |
sureinoutdoorenvironmentsisMeanRadiantTemperature
| especially | in urban | environments |     | where | radiation | dynam- |     |     |     |     |     |     |     |
| ---------- | -------- | ------------ | --- | ----- | --------- | ------ | --- | --- | --- | --- | --- | --- | --- |
ics significantly impact human thermal exposure. Tradi- (T ), whichquantifiesthecombinedeffectofshortwave
mrt
|                |     |            |       |      |          |          | and longwave |     | radiation | on a human | body | from | surround- |
| -------------- | --- | ---------- | ----- | ---- | -------- | -------- | ------------ | --- | --------- | ---------- | ---- | ---- | --------- |
| tional methods | of  | estimating | T mrt | rely | on field | measure- |              |     |           |            |      |      |           |
mentsandcomputationalsimulations,bothofwhicharere- ingsurfacesandatmosphericradiationsources[11,28]. In
sourceintensive. ThisstudyintroducesaPhysics-Informed urban settings, where complex interactions between solar
|     |     |     |     |     |     |     | radiation, | surface | reflectance, |     | shading | from | buildings and |
| --- | --- | --- | --- | --- | --- | --- | ---------- | ------- | ------------ | --- | ------- | ---- | ------------- |
NeuralNetwork(PINN)approachthatintegratesshortwave
andlongwaveradiationmodelingwithdeeplearningtech- vegetation, and thermal emissions from materials signifi-
|            |            |     |            |         |     |               | cantly affect | microclimate |     | conditions, |     | accurate | T esti- |
| ---------- | ---------- | --- | ---------- | ------- | --- | ------------- | ------------- | ------------ | --- | ----------- | --- | -------- | ------- |
| niques. By | leveraging | a   | multimodal | dataset |     | that includes |               |              |     |             |     |          | mrt     |
meteorologicaldata,builtenvironmentcharacteristics,and mation is crucial for designing sustainable cities and im-
fisheye image-derived shading information, our model en- provingpublichealthoutcomes[4,25].
hancespredictiveaccuracywhilemaintainingphysicalcon- TraditionalapproachestoestimatingT generallyfall
mrt
| sistency. | Our experimental |     | results | demonstrate |     | that the |          |             |        |       |              |     |          |
| --------- | ---------------- | --- | ------- | ----------- | --- | -------- | -------- | ----------- | ------ | ----- | ------------ | --- | -------- |
|           |                  |     |         |             |     |          | into two | categories: | direct | field | measurements |     | and com- |
proposed PINN framework outperforms conventional deep putational simulations. Field measurements rely on in-
learning models, with the best-performing configurations struments such as black globe thermometers, radiometers,
| achieving | an RMSE | of 3.50 | and | an R2 | of 0.88. | This ap- |                     |     |           |         |     |            |           |
| --------- | ------- | ------- | --- | ----- | -------- | -------- | ------------------- | --- | --------- | ------- | --- | ---------- | --------- |
|           |         |         |     |       |          |          | and six-directional |     | radiation | sensors |     | to capture | radiative |
proach highlights the potential of physics-informed ma- fluxes with high accuracy [26, 27]. Despite their reliabil-
| chine learning | in bridging |     | the gap | between | computational |     |            |         |     |             |     |             |          |
| -------------- | ----------- | --- | ------- | ------- | ------------- | --- | ---------- | ------- | --- | ----------- | --- | ----------- | -------- |
|                |             |     |         |         |               |     | ity, these | methods | are | impractical | for | large-scale | applica- |
modeling and real-world applications, offering a scalable tionsduetotheirdependenceoncostlyandlabor-intensive
and interpretable solution for urban thermal comfort as- equipment,makinglong-termorreal-timemonitoringcon-
sessments.
|     |     |     |     |     |     |     | siderably  | more        | difficult | [5, 12]. | On the       | other    | hand, com- |
| --- | --- | --- | --- | --- | --- | --- | ---------- | ----------- | --------- | -------- | ------------ | -------- | ---------- |
|     |     |     |     |     |     |     | putational | simulations |           | based    | on radiative | transfer | equa-      |
Keywords: MeanRadiantTemperature, Physics-Informed tions,suchasthoseimplementedinmodelslikeENVI-met
Neural Network, Outdoor Thermal Comfort, Urban Cli- andSOLWEIG,simulateshortwaveandlongwaveradiation
mate, Multimodal Deep Learning, Computer Vision Radi- fluxes based on urban geometry, atmospheric properties,
ationModeling. and material emissivity [11, 25]. While these models pro-

Figure1.OverviewoftheproposedPhysics-InformedNeuralNetwork(PINN)workflowforT estimation.
mrt
videphysicallyconsistentresults,theyrequireextensivepa- where sky obstruction varies significantly [29, 31]. Tradi-
rametertuning,highcomputationalresources,anddetailed tional T models struggle to capture the spatial hetero-
mrt
site-specific data, which limit their adaptability and scala- geneity of shading effects due to the complexity of urban
bilitytodynamic,large-scaleurbanenvironments. structures. By combining physics-informed deep learning
|     |     |     |     |     |     | with vision-based | urban | climate | modeling, | our | approach |
| --- | --- | --- | --- | --- | --- | ----------------- | ----- | ------- | --------- | --- | -------- |
Recentadvancementsindeeplearninghaveopenednew
|                       |     |                            |     |     |     | significantly | improves | the ability | to estimate | T   | in het- |
| --------------------- | --- | -------------------------- | --- | --- | --- | ------------- | -------- | ----------- | ----------- | --- | ------- |
| avenuesforestimatingT |     | usingmachinelearningmodels |     |     |     |               |          |             |             | mrt |         |
mrt
erogeneousurbanenvironments.
| trained on | meteorological | and | environmental | data | [4, 39]. |     |     |     |     |     |     |
| ---------- | -------------- | --- | ------------- | ---- | -------- | --- | --- | --- | --- | --- | --- |
Neural networks have demonstrated the ability to learn ResearchQuestions
complex spatial and temporal patterns of radiation expo- Thisstudyaimstoaddressthefollowingresearchquestions:
sure, allowingforfasterandpotentiallyscalableT mrt pre- RQ1: How does a Physics-Informed Neural Network
dictions. However, data-driven models often suffer from (PINN)comparetotraditionalmachinelearningandempir-
overfitting, lack physical interpretability, and fail to gen- icalmethodsintermsofaccuracyandphysicalconsistency
eralize effectively across diverse urban morphologies and forT estimation?
mrt
climaticconditions[20].
RQ2:Howdoestheincorporationoffisheyeimage-derived
To address these challenges, we propose a multimodal shading information impact the predictive performance of
| Physics-InformedNeuralNetwork(PINN)framework(Fig- |     |     |     |     |     | T mrt models? |     |     |     |     |     |
| ------------------------------------------------- | --- | --- | --- | --- | --- | ------------- | --- | --- | --- | --- | --- |
ure 1) that combines deep learning techniques with fun- RQ3: How generalizable is the multimodal deep learning
damental radiative transfer principles to enhance the accu- framework in integrating metadata, solar position parame-
racy, interpretability, and generalizability of T estima- ters, and computer vision-derived shading features across
mrt
tion,leveragingtheadvancedrepresentationsthatdeepneu- diverseurbansettings?
ral networks achieve through multimodal learning [6, 33]. RQ4: What are the key physical constraints that should
Unlike conventional machine learning approaches, PINNs beembeddedintheneuralnetworklossfunctiontoensure
incorporate governing physical equations directly into the thermodynamicconsistencyinT predictions?
mrt
neural network training process, ensuring that predictions RQ5: To what extent can our multimodal deep learning
adheretothermodynamicconstraints[1,8,35].Ourmethod
frameworkreducetheneedforextensivesensor-basedmea-
enhances predictive performance by incorporating the six- surementswhilemaintainingaccurateT estimation?
mrt
| directionalT | formulaintothelossfunctionwhilelever- |     |     |     |     |                 |     |     |     |     |     |
| ------------ | ------------------------------------- | --- | --- | --- | --- | --------------- | --- | --- | --- | --- | --- |
|              | mrt                                   |     |     |     |     | OurContribution |     |     |     |     |     |
aging multimodal data sources, including numeric mea- PreviousmethodsforT estimationhavereliedonmea-
mrt
| sured environmental |       | features    | (air temperature,     | humidity, |      |                  |                          |                  |             |           |         |
| ------------------- | ----- | ----------- | --------------------- | --------- | ---- | ---------------- | ------------------------ | ---------------- | ----------- | --------- | ------- |
|                     |       |             |                       |           |      | sured field      | data or simulation-based |                  | approaches. |           | We pro- |
| wind speed,         | solar | angles) and | fisheye image-derived |           | fea- |                  |                          |                  |             |           |         |
|                     |       |             |                       |           |      | pose a framework | that                     | reduces reliance | on          | expensive | sen-    |
tures (capturing the shading conditions and surrounding sors and field measurements by developing a validated
builtenvironmentfeatures).
modelcapableofmaintaininghighaccuracyevenwhencer-
Shadingandsolarexposureplayapivotalroleinoutdoor tain input features are removed. Using a PINN, our ap-
thermal comfort, particularly in densely built urban areas proach ensures thermodynamic consistency while improv-

ing generalizability across different environments. Addi- moresensitivetodatasetbiases. Xieetal.[40]introduced
tionally, we leverage computer vision techniques, specifi- ageneticalgorithm-optimizedbackpropagationneuralnet-
cally fisheye imagery, to dynamically extract spatial shad- work (GA-BPNN) for long-term T mrt prediction, achiev-
ing features, effectively capturing crucial environmental ing a mean absolute percentage error (MAPE) below 1%.
factorsthatinfluenceradiativeflux.Throughintelligentfea- Yet,theirrelianceonmeteorologicalparameterswithoutin-
tureselectionandmultimodalintegration,ourmodelserves tegrating environmental visual data limited their model’s
as a proxy for traditional methods, providing an adaptable adaptabilitytourbanmicroclimates.
| and physically |     | consistent | solution |     | for urban | thermal | com- |     |     |     |     |     |     |     |     |
| -------------- | --- | ---------- | -------- | --- | --------- | ------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
2.2.Physics-InformedNeuralNetworks(PINNs)
fortassessmentwithouttheneedforextensiveinstrumenta-
tion.
Physics-InformedNeuralNetworks(PINNs)haveemerged
|     |     |     |     |     |     |     |     | as a robust | framework |     | for embedding |     | domain | knowledge |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | --------- | --- | ------------- | --- | ------ | --------- | --- |
2.RelatedWork
|                                        |     |     |     |     |     |     |          | into deep | learning       | models[3, |      | 34]. PINNs    | combine |             | neural |
| -------------------------------------- | --- | --- | --- | --- | --- | --- | -------- | --------- | -------------- | --------- | ---- | ------------- | ------- | ----------- | ------ |
|                                        |     |     |     |     |     |     |          | network   | approximations |           | with | physics-based |         | constraints | to     |
| CalculatingtheMeanRadiantTemperature(T |     |     |     |     |     |     | )hasbeen |           |                |           |      |               |         |             |        |
mrt
a subject of extensive research in human biometeorology ensure physically consistent predictions [19, 35]. Various
|           |          |      |         |         |           |     |        | studies have | demonstrated |     | the | effectiveness |     | of PINNs | in  |
| --------- | -------- | ---- | ------- | ------- | --------- | --- | ------ | ------------ | ------------ | --- | --- | ------------- | --- | -------- | --- |
| and urban | climate, | with | various | methods | developed |     | to im- |              |              |     |     |               |     |          |     |
solvingcomplexdifferentialequations.
| prove accuracy |     | in heterogeneous |     |     | built environments. |     | Tra- |     |     |     |     |     |     |     |     |
| -------------- | --- | ---------------- | --- | --- | ------------------- | --- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
ditional approaches relied primarily on physical measure- Biswal et al.[7] applied PINNs to solve the Radia-
|     |     |     |     |     |     |     |     | tive Transfer | Equation |     | (RTE), | demonstrating |     | the method’s |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | -------- | --- | ------ | ------------- | --- | ------------ | --- |
mentsandempiricalmodels,whilemorerecentstudieshave
leveraged machine learning techniques to enhance predic- potential to handle computational complexities associated
withradiationmodelingandvalidatingitsaccuracyinsolv-
| tive performance. |         | However, |         | despite     | these | advances, | many   |                     |     |     |           |     |                |     |       |
| ----------------- | ------- | -------- | ------- | ----------- | ----- | --------- | ------ | ------------------- | --- | --- | --------- | --- | -------------- | --- | ----- |
|                   |         |          |         |             |       |           |        | ing one-dimensional |     | RTE | problems. |     | Their findings |     | high- |
| existing          | methods | have     | notable | limitations |       | in their  | adapt- |                     |     |     |           |     |                |     |       |
ability, computational efficiency, and robustness when ap- light the broader applicability of PINNs in radiative heat
|          |         |         |          |     |              |     |         | transfermodeling. |     | Firoozsalarietal.[16]appliedPINNsto |     |     |     |     |     |
| -------- | ------- | ------- | -------- | --- | ------------ | --- | ------- | ----------------- | --- | ----------------------------------- | --- | --- | --- | --- | --- |
| plied to | complex | outdoor | settings |     | with dynamic |     | shading |                   |     |                                     |     |     |     |     |     |
conditions. Inthissection,wereviewpriorstudiesinthree solveFokker–Planckequations,demonstratinghowphysics
|            |        |          |     |          |             |          |          | constraints | enhance         | convergence |            | and | accuracy. | Building   |     |
| ---------- | ------ | -------- | --- | -------- | ----------- | -------- | -------- | ----------- | --------------- | ----------- | ---------- | --- | --------- | ---------- | --- |
| key areas: | Urban  | Climate  | and | Heat     | Assessment, |          | Physics- |             |                 |             |            |     |           |            |     |
|            |        |          |     |          |             |          |          | on this,    | they introduced |             | DeepFDENet |     | [15],     | showcasing |     |
| Informed   | Neural | Networks |     | (PINNs), | and         | Computer | Vi-      |             |                 |             |            |     |           |            |     |
sionforRadiationEstimation. WealsodiscusstheMaRTy PINNs’adaptabilityinsolvingfractionaldifferentialequa-
|     |     |     |     |     |     |     |     | tions and | broader | applicability |     | in complex |     | physical | sys- |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ------- | ------------- | --- | ---------- | --- | -------- | ---- |
dataset,whichformsthebasisforourstudy.
tems.
2.1.UrbanClimateandHeatAssessment
|          |            |     |      |            |     |       |         | Krishnapriyan |         | et al.  | [23]     | explored | the effectiveness |             | of  |
| -------- | ---------- | --- | ---- | ---------- | --- | ----- | ------- | ------------- | ------- | ------- | -------- | -------- | ----------------- | ----------- | --- |
|          |            |     |      |            |     |       |         | PINNs in      | solving | complex | physical |          | systems,          | identifying |     |
| Accurate | estimation |     | of T | is crucial | for | urban | climate |               |         |         |          |          |                   |             |     |
mrt
research, sustainable city planning, and the development challenges in convergence and proposing strategies to im-
provetheiraccuracyinhigh-dimensionaldifferentialequa-
| of thermally | comfortable |     | public | spaces. | Traditional |     | meth- |     |     |     |     |     |     |     |     |
| ------------ | ----------- | --- | ------ | ------- | ----------- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
ods for estimating T generally fall into two categories. tions. Parand et al. [32] applied PINNs to solve nonlin-
mrt
eardifferentialequationsofLane–Emdentype,anapproach
Fieldmeasurementsrelyoninstrumentssuchasblackglobe
|               |     |              |     |     |                 |     |           | closely related | to  | our work, | as  | we employ | PINNs | to  | solve |
| ------------- | --- | ------------ | --- | --- | --------------- | --- | --------- | --------------- | --- | --------- | --- | --------- | ----- | --- | ----- |
| thermometers, |     | radiometers, |     | and | six-directional |     | radiation |                 |     |           |     |           |       |     |       |
sensors to provide direct measurements of thermal radia- radiativetransferequationsgoverningT mrt estimation.Ad-
|              |                  |                                         |     |        |              |     |            | ditionally,  | other | recent | works        | have applied | PINNs         | to  | ther-   |
| ------------ | ---------------- | --------------------------------------- | --- | ------ | ------------ | --- | ---------- | ------------ | ----- | ------ | ------------ | ------------ | ------------- | --- | ------- |
| tion[26,27]. |                  | Whilehighlyaccurate,thesemethodsrequire |     |        |              |     |            |              |       |        |              |              |               |     |         |
|              |                  |                                         |     |        |              |     |            | mal modeling | in    | urban  | and building |              | environments, |     | includ- |
| extensive    | instrumentation, |                                         |     | making | large-scale, |     | long-term, |              |       |        |              |              |               |     |         |
ingthermalcavityflowsimulations[2,17]andbuildingen-
| or real-time | applications |     | impractical. |     | Computational |     | sim- |     |     |     |     |     |     |     |     |
| ------------ | ------------ | --- | ------------ | --- | ------------- | --- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
ergymodeling[9].
ulationsbasedonradiativetransferequations,suchasthose
| used in | ENVI-met  | and | SOLWEIG, |           | estimate | T       | by sim- |                                          |     |     |     |     |     |     |     |
| ------- | --------- | --- | -------- | --------- | -------- | ------- | ------- | ---------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
|         |           |     |          |           |          | mrt     |         | 2.3.ComputerVisionforRadiationEstimation |     |     |     |     |     |     |     |
| ulating | shortwave | and | longwave | radiation |          | fluxes. | Despite |                                          |     |     |     |     |     |     |     |
theirprecision,thesemodelsarecomputationallyexpensive Computer vision has increasingly been applied in thermal
|             |           |     |             |     |                   |     |       | environment | monitoring |     | and radiation |     | estimation | [10]. | In- |
| ----------- | --------- | --- | ----------- | --- | ----------------- | --- | ----- | ----------- | ---------- | --- | ------------- | --- | ---------- | ----- | --- |
| and heavily | dependent |     | on detailed |     | input parameters, |     | often |             |            |     |               |     |            |       |     |
requiringextensivecalibrationandsite-specificdata[36]. frared (IR) imaging technology enables non-contact tem-
Recent studies have investigated machine learning ap- peraturemeasurementbydetectingthermalradiationemit-
proachesforT mrt estimation. Jiaetal.[20]comparedfive tedbyobjects, makingitparticularlyusefulforurbanheat
differentT estimationtechniques,includingdeepneural mappingandbuildingthermalassessments[21,41].
mrt
networks(DNNs),showingthatDNNsoutperformedtradi- Some studies have used thermal IR cameras to di-
tionalmethods. However,theirapproachfocusedonstatis- rectly measure skin temperature variations in human ther-
ticallearningwithoutincorporatingphysicalconstraintsor malstressanalysis[13]. Otherworkshaveexploredradia-
multimodal data sources, making it less interpretable and tive energy estimation using vision-based approaches, in-

cluding techniques for high-temperature surface measure- trian thermal comfort was analyzed. This work demon-
mentsinindustrialapplications[14]. strated MaRTy’s effectiveness in capturing fine-scale radi-
Forurbanapplications, researchershaveleveragedfish- ationvariationsacrossdifferenturbanmorphologies. Simi-
eyeimagestocalculatetheSkyViewFactor(SVF),anes- larly,WebMRT[4]leveragedMaRTydatatodevelopama-
sentialparameterforestimatinglocalshadingandradiation chinelearning-basedT estimationmodel,incorporating
mrt
fluxes[30]. Ourworkbuildsuponpreviousmethodologies solarpositioning,surfacematerials,andmeteorologicalpa-
byintegratingPhysics-InformedNeuralNetworks(PINNs) rameters. Ourstudybuildsupontheseworksbyintegrating
to enforce thermodynamic consistency while leveraging physics-informedlearningandcomputervisiontechniques
fisheye imagery to enhance spatial awareness of radiative intotheestimationframework.
fluxdistributions. ByextendingPINNstomultimodaldata DatasetSummary. TheMaRTydatasetusedinthisstudy
fusion,weincorporateenvironmentalmetadataandimage- consistsoftheattributesintable1.
derivedfeatures,improvingthepredictiveaccuracyofT
mrt
models. Thisintegrationenablesprecisespatialcharacteri- Attribute Details
| zationofshadingeffects,ensuringmorereliableT |     |     |     |     |     |     | esti- |                               |     |     |     |       |     |     |
| -------------------------------------------- | --- | --- | --- | --- | --- | --- | ----- | ----------------------------- | --- | --- | --- | ----- | --- | --- |
|                                              |     |     |     |     |     |     | mrt   | No.ofObservations(withimages) |     |     |     | 1,130 |     |     |
mationsinheterogeneousurbanenvironments.
|     |     |     |     |     |     |     |     | TimeRange |     |     |     | 07:30–20:30      |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | --- | --- | --- | ---------------- | --- | --- |
|     |     |     |     |     |     |     |     | DateRang  |     |     |     | June–August,2018 |     |     |
2.4.MaRTyDataset
|                                          |     |     |     |     |     |     |       | DataTypes          |     |     |     | Numeric,Nominal,Image |     |     |
| ---------------------------------------- | --- | --- | --- | --- | --- | --- | ----- | ------------------ | --- | --- | --- | --------------------- | --- | --- |
|                                          |     |     |     |     |     |     |       | AirTemperature(◦C) |     |     |     | 26.02–43.97           |     |     |
| WedevelopedourPINNbasedontheMaRTydataset |     |     |     |     |     |     | [31], |                    |     |     |     |                       |     |     |
|                                          |     |     |     |     |     |     |       | T (◦C)             |     |     |     | 15.54–76.22           |     |     |
mrt
providinghigh-resolutionmicroclimatemeasurementscol-
| lected during                          |     | nine field | campaigns |     | (2016–19) | at        | 159 loca- |                  |     |          |         |              |      |         |
| -------------------------------------- | --- | ---------- | --------- | --- | --------- | --------- | --------- | ---------------- | --- | -------- | ------- | ------------ | ---- | ------- |
|                                        |     |            |           |     |           |           |           | Table 1. Summary |     | of MaRTy | dataset | observations | used | in this |
| tionsinTempe,ArizonausingtheMaRTycart. |     |            |           |     |           | Developed |           |                  |     |          |         |              |      |         |
study.
| by Middel | et al. | [27], | the MaRTy |     | cart is an | advanced | mo- |     |     |     |     |     |     |     |
| --------- | ------ | ----- | --------- | --- | ---------- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
bileweatherstationdesignedspecificallyforurbanclimate
studies. Thehuman-biometeorologicalinstrumentplatform
3.Methodology
isequippedwiththreenetradiometersmeasuringshortwave
andlongwavefluxdensitiesinsixdirections(up,down,left, Our proposed workflow begins with data acquisition and
|               |              |       |           |         |        |                  |       | preprocessing                                     | using | the | MaRTy | dataset [27], | which | in-  |
| ------------- | ------------ | ----- | --------- | ------- | ------ | ---------------- | ----- | ------------------------------------------------- | ----- | --- | ----- | ------------- | ----- | ---- |
| right, front, | back),       | along | with      | sensors | for    | air temperature, |       |                                                   |       |     |       |               |       |      |
|               |              |       |           |         |        |                  |       | cludesmeteorologicaldataandsix-directionalimages. |       |     |       |               |       | Pre- |
| surface       | temperature, |       | humidity, | wind    | speed, | and GPS          | posi- |                                                   |       |     |       |               |       |      |
tion. Imagecubesofthesurroundingsarecapturedconcur- processinginvolvedhandlingmissingvalues,detectingsen-
|     |     |     |     |     |     |     |     | sor noise, | and deriving | solar | geometry | parameters |     | such as |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ------------ | ----- | -------- | ---------- | --- | ------- |
rently,enablingthecharacterizationofnearbytreecanopies
andshadingfeatures,makingitauniquelyvaluabledataset solar altitude, azimuth, and minutes from sunrise to track
radiativefluxvariations.Wetransformedthesix-directional
| forourmodel. |     | Thisrobustapproachprovidespreciseesti- |     |     |     |     |     |     |     |     |     |     |     |     |
| ------------ | --- | -------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
imagesintoanupward-viewfisheyeprojectiontoefficiently
| mates of | Mean | Radiant | Temperature |     | (T  | ) and | supports |     |     |     |     |     |     |     |
| -------- | ---- | ------- | ----------- | --- | --- | ----- | -------- | --- | --- | --- | --- | --- | --- | --- |
mrt
versatile, high-spatiotemporal-resolution microclimate as- captureskyexposure, shading, andsurroundingstructures.
SegFormer[38]wasusedforskymaskingandshadingesti-
sessments.
The data set consists of multimodal environmental ob- mation,whileResNet-50[22],extractedspatialfeaturesof
|     |     |     |     |     |     |     |     | the built environment |     | by  | unfreezing | the last | 30 layers | and |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------------- | --- | --- | ---------- | -------- | --------- | --- |
servations,including:
|                  |     |             |     |     |              |     |          | fine-tuning. | Theseextractedfeatures,combinedwithmeta- |     |     |     |     |     |
| ---------------- | --- | ----------- | --- | --- | ------------ | --- | -------- | ------------ | ---------------------------------------- | --- | --- | --- | --- | --- |
| • Meteorological |     | parameters: |     | Air | temperature, |     | relative |              |                                          |     |     |     |     |     |
data,wereintegratedintoaPINNtopredictshortwaveand
| humidity, | windspeed, |     | date, | time, | latitude, | longitudeand |     |          |           |            |     |                   |     |     |
| --------- | ---------- | --- | ----- | ----- | --------- | ------------ | --- | -------- | --------- | ---------- | --- | ----------------- | --- | --- |
|           |            |     |       |       |           |              |     | longwave | radiation | components |     | for T estimation. |     | The |
| altitude. |            |     |       |       |           |              |     |          |           |            |     | mrt               |     |     |
• Radiative flux measurements: Six-directional short- PINN framework leveraged the six-directional T mrt equa-
tiontoenforcethermodynamicconsistency,ensuringphys-
waveandlongwaveradiationreadingsfromnetradiome-
|     |     |     |     |     |     |     |     | ically realistic | predictions. |     | Model | performance | was | eval- |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | ------------ | --- | ----- | ----------- | --- | ----- |
ters.
R2
• Built environment descriptors: Surrounding surface uated using RMSE and for accuracy, alongside MAPE
andMBEtoassessrelativeerrorsandbiases1.
| materials, | tree | canopy | cover, | percentage |     | of surrounding |     |     |     |     |     |     |     |     |
| ---------- | ---- | ------ | ------ | ---------- | --- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- |
buildingsandpervious-impervioussurfaces.
3.1.PreprocessingoftheMaRTyData
| • Solargeometry-derivedparameters: |     |     |     |     | Solaraltitude,so- |     |     |     |     |     |     |     |     |     |
| ---------------------------------- | --- | --- | --- | --- | ----------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
larazimuth,andminutesfromsunrise. The preprocessing of MaRTy data involved cleaning, nor-
• Fisheye image-derived features: image-extracted fea- malization, and feature engineering. To ensure consis-
turesanddynamicshadeassessment. tency, missingvalueswereinterpolatedusingthetemporal
|       |          |           |     |     |            |         |         | nearest-neighborimputation. |     |     | Outliers,primarilycausedby |     |     |     |
| ----- | -------- | --------- | --- | --- | ---------- | ------- | ------- | --------------------------- | --- | --- | -------------------------- | --- | --- | --- |
| MaRTy | in Prior | Research. |     | One | of the key | studies | utiliz- |                             |     |     |                            |     |     |     |
ingMaRTyisthe“FiftyGradesofShade”studybyMiddel
1ThefullmethodologyandabatchofDatasetwillbemadepublicly
et al. [31], where the impact of urban shading on pedes- availableonGithubfollowingthepeer-reviewprocess.

sensorerrors,wereremovedbasedonastatisticalthreshold rated radiative heat transfer physics into its learning pro-
| of3standarddeviationsfromthemean. |        |          |       |      |       |      | cess. |     |     |     |     |     |     |     |     |
| --------------------------------- | ------ | -------- | ----- | ---- | ----- | ---- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
| The original                      | images | captured | along | with | MaRTy | mea- |       |     |     |     |     |     |     |     |     |
3.2.1.BaselineNeuralNetwork(NN)
| surements | were six-directional |     | cube | maps | (North, | East, |     |     |     |     |     |     |     |     |     |
| --------- | -------------------- | --- | ---- | ---- | ------- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Thebaselineneuralnetworkmodelwasdesignedasamulti-
South,West,Up,andDown).Tofacilitateamoreintegrated
modalfusionnetwork,combiningnumericalenvironmental
spatialrepresentation,wetransformedthesecubemapsinto
hemisphericalfisheyeprojections. Thistransformationwas metadata with fisheye-derived spatial features. The archi-
tectureincluded:
| performed | using | a spherical | warping | technique, |     | ensuring |     |       |           |        |     |            |           |     |        |
| --------- | ----- | ----------- | ------- | ---------- | --- | -------- | --- | ----- | --------- | ------ | --- | ---------- | --------- | --- | ------ |
|           |       |             |         |            |     |          | •   | Fully | connected | layers | for | processing | numerical |     | meteo- |
geometricconsistencyacrossdirectionalimages[30].
rologicalandbuiltenvironmentfeatures.
Theconversionfollowedthesesteps:
|     |     |     |     |     |     |     | •   | Convolutional |     | layers | (ResNet-50) |     | for extracting |     | shading |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- | ------ | ----------- | --- | -------------- | --- | ------- |
1. Normalizeeachdirectionalimagetomatchthesameex-
featuresfromfisheyeimages.
posureandintensitylevels.
|                                                   |     |     |     |     |     |     | •   | AfinalregressionlayerpredictingT |     |     |     |     |     | .   |     |
| ------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | -------------------------------- | --- | --- | --- | --- | --- | --- | --- |
| 2. Applyanequiangularprojectiontomapcubefacesonto |     |     |     |     |     |     |     |                                  |     |     |     |     | mrt |     |     |
TrainingwasconductedusingtheAdamoptimizerwitha
ahemisphericalsurface.
learningrateof0.001,minimizingtheMeanSquaredError
| 3. Stitch | overlapping | regions | to create | a   | seamless | fisheye |     |     |     |     |     |     |     |     |     |
| --------- | ----------- | ------- | --------- | --- | -------- | ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
(MSE)lossfunction.
representation.
4. Validate the projection using sky exposure ratios to 3.2.2.Physics-InformedNeuralNetwork(PINN)
maintainaccuracy.
|     |     |     |     |     |     |     | To  | enhance | model | interpretability |     |     | and accuracy, | we  | intro- |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | ----- | ---------------- | --- | --- | ------------- | --- | ------ |
Thesehemisphericalfisheyeimagesareusedforextracting duced a PINN framework that integrates domain-specific
shading features, sunlit area estimation, and built environ- physical constraints. The PINN model incorporated
mentfeaturesenablingamorepreciseassessmentofshort-
|     |     |     |     |     |     |     | physics-based |     |     | loss functions |     | derived | from | the T mrt | for- |
| --- | --- | --- | --- | --- | --- | --- | ------------- | --- | --- | -------------- | --- | ------- | ---- | --------- | ---- |
wave and longwave radiation exposure in the model. The mula(sixdirectionsapproach), enforcingconsistencywith
precisepositionofthesuniscomputedbasedongeographic
|           |           |           |            |       |     |          | thermodynamic |     |     | principles. |     | The key | radiative | heat | transfer |
| --------- | --------- | --------- | ---------- | ----- | --- | -------- | ------------- | --- | --- | ----------- | --- | ------- | --------- | ---- | -------- |
| metadata, | including | latitude, | longitude, | date, | and | time. To |               |     |     |             |     |         |           |      |          |
equationusedinthelossfunctionwas:
determinewhetheralocationissun-exposedorshaded,we
employ SegFormer to apply a sky mask to the fisheye im- (cid:18) Q (cid:19)0.25
total
|     |     |     |     |     |     |     |     |     | T   | mrt = |     |     | −273.15 |     | (1) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----- | --- | --- | ------- | --- | --- |
age, effectively removing the sky pixels and isolating sur- a σ
1
| rounding | urban structures |     | and vegetation. |     | This enables | us  |     |     |     |     |     |     |     |     |     |
| -------- | ---------------- | --- | --------------- | --- | ------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
to assess whether the sun is obstructed by nearby objects, whereQ isthetotalradiativefluxreceivedfromdiffer-
total
entenvironmentaldirections,computedas:
providinganimage-derivedshadingestimationwithoutre-
lyingonpredefinedurbanmorphologydatasets(Figure2).
|     |     |     |     |     |     |     |     |     | Q   | total =Q | (up,down) | +Q  | (others) |     | (2) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------- | --------- | --- | -------- | --- | --- |
Thedirectionalfluxcomponentsaregivenby:
(cid:88)
|     |     |     |     |     |     |     |     | Q   |           | =W  |           |     | (a S | +a L ) |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --------- | --- | --------- | --- | ---- | ------ | --- |
|     |     |     |     |     |     |     |     |     | (up,down) |     | (up,down) |     | k    | i l i  |     |
|     |     |     |     |     |     |     |     |     |           |     |           |     | i    |        | (3) |
i∈{up,down}
(cid:88)
|     |     |     |     |     |     |     |     |     | Q        | =W  |          |     | (a S | +a L ) |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | -------- | --- | -------- | --- | ---- | ------ | --- |
|     |     |     |     |     |     |     |     |     | (others) |     | (others) |     | k j  | l j    |     |
(4)
j
j∈{north,east,south,west}
|           |          |           |       |           |     |             |       | where | S and     | S represent |             | shortwave |     | radiation | compo-   |
| --------- | -------- | --------- | ----- | --------- | --- | ----------- | ----- | ----- | --------- | ----------- | ----------- | --------- | --- | --------- | -------- |
|           |          |           |       |           |     |             |       |       | i         | j           |             |           |     |           |          |
|           |          |           |       |           |     |             | nents | from  | different |             | directional | sources.  |     | L i and   | L j rep- |
| Figure 2. | Sky mask | generated | using | SegFormer | on  | the fisheye |       |       |           |             |             |           |     |           |          |
resentlongwaveradiationcomponentsfromcorresponding
| image,distinguishingsun-exposedandshadedareasbasedonsun |     |     |     |     |     |     |             |     | a   | a     |                |     |              |     |        |
| ------------------------------------------------------- | --- | --- | --- | --- | --- | --- | ----------- | --- | --- | ----- | -------------- | --- | ------------ | --- | ------ |
|                                                         |     |     |     |     |     |     | directions. |     | k   | and l | are absorption |     | coefficients | for | short- |
position
|     |     |     |     |     |     |     | wave | and | longwave |     | radiation, | respectively. |     | W   |     |
| --- | --- | --- | --- | --- | --- | --- | ---- | --- | -------- | --- | ---------- | ------------- | --- | --- | --- |
(up,down)
|     |     |     |     |     |     |     | and | W   |     | are weighting |     | factors | representing | the | frac- |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- | ------- | ------------ | --- | ----- |
(others)
|     |     |     |     |     |     |     | tionofradiativeexposurefromtherespectivedirections. |     |     |     |     |     |     |     | a 1 |
| --- | --- | --- | --- | --- | --- | --- | --------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
3.2.ArchitectureoftheDeepLearningModel
|     |     |     |     |     |     |     | isthemeanradiantabsorptivityofthehumanbody. |     |     |     |     |     |     |     | σisthe |
| --- | --- | --- | --- | --- | --- | --- | ------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | ------ |
Our approach involved training two types of neural net- Stefan-Boltzmannconstant.
works: a standard deep learning model and a Physics- Thephysics-informedlossfunctionpenalizesdeviations
InformedNeuralNetwork(PINN).Thestandardneuralnet- from these equations, ensuring that the model adheres to
work (NN) served as a baseline, while the PINN incorpo- fundamentalradiationbalanceprinciples.

|     |     |     | Figure3.Physics-InformedNeuralnetworkarchitectureforT |     |     |     |     |     | estimation. |     |     |     |
| --- | --- | --- | ----------------------------------------------------- | --- | --- | --- | --- | --- | ----------- | --- | --- | --- |
mrt
| 3.3.MultimodalPINNArchitecture |     |                   |     |          |              |     |                                 |     |                  | (R2) |                   |     |
| ------------------------------ | --- | ----------------- | --- | -------- | ------------ | --- | ------------------------------- | --- | ---------------- | ---- | ----------------- | --- |
|                                |     |                   |     |          |              |     | The Coefficient                 |     | of Determination |      | measures          | how |
|                                |     |                   |     |          |              |     | wellthemodelexplainsvarianceinT |     |                  |      | ,withvaluescloser |     |
| The multimodal                 |     | PINN architecture |     | consists | of a ResNet- |     |                                 |     |                  | mrt  |                   |     |
to1signifyingbetterpredictions:
| 50 backbone | for | image | feature | extraction, | where | the last |     |     |     |     |     |     |
| ----------- | --- | ----- | ------- | ----------- | ----- | -------- | --- | --- | --- | --- | --- | --- |
30layerswereunfrozenandfine-tunedtocaptureradiative (cid:80)n (y −yˆ)2
|     |     |     |     |     |     |     |     | R2  |     | i =1 i | i   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------ | --- | --- |
exposureandshadingfeaturesforeachdirectionalcompo- =1− (cid:80) (6)
|     |     |     |     |     |     |     |     |     |     | n (y −y¯ | )2  |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------- | --- | --- |
|     |     |     |     |     |     |     |     |     |     | i=1 i    |     |     |
nent.Additionally,fisheyeimagesarepaddedtoensurethat
spatialfeaturesaligneffectivelywithsolarangles,allowing The Mean Absolute Percentage Error (MAPE) expresses
themodeltobetterdistinguishregionsofsunexposureand therelativepredictionerrorasapercentage:
| shading in | relation | to the | computed | solar position. |     | It also |     |     |     |            |          |     |
| ---------- | -------- | ------ | -------- | --------------- | --- | ------- | --- | --- | --- | ---------- | -------- | --- |
|            |          |        |          |                 |     |         |     |     |     | n (cid:12) | (cid:12) |     |
includes two separate multilayer perceptrons (MLPs) for 100(cid:88)(cid:12) y i −yˆ i(cid:12)
|     |     |     |     |     |     |     |     | MAPE= |     | (cid:12) | (cid:12) | (7) |
| --- | --- | --- | --- | --- | --- | --- | --- | ----- | --- | -------- | -------- | --- |
predicting shortwave and longwave radiation. The Short- n (cid:12) y (cid:12)
i
i=1
| wave Radiation |     | MLP processes |     | concatenated | image | fea- |     |     |     |     |     |     |
| -------------- | --- | ------------- | --- | ------------ | ----- | ---- | --- | --- | --- | --- | --- | --- |
tures (2048 dimensions) and metadata features, consisting Lastly, the Mean Bias Error (MBE) identifies systematic
over-orunderestimationinpredictions:
| ofthreehiddenlayerswith128,256,and128neurons. |     |     |     |     |     | The |     |     |     |     |     |     |
| --------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
LongwaveRadiationMLPprocessesonlynumericalmeta-
1 n
data, consisting of three hidden layers with 128, 256, and (cid:88)
|             |                                       |     |     |     |     |     |     | MBE= |     | (y −yˆ) |     | (8) |
| ----------- | ------------------------------------- | --- | --- | --- | --- | --- | --- | ---- | --- | ------- | --- | --- |
|             |                                       |     |     |     |     |     |     |      | n   | i       | i   |     |
| 128neurons. | Amultimodalfusionlayercombiningnumer- |     |     |     |     |     |     |      |     |         |     |     |
i=1
icalandimage-basedfeaturestoensurecomprehensivera-
|                        |     |                                 |     |     |     |     | wherey i representsactualvalues,yˆ |     |     | i arepredictions,y¯isthe |     |     |
| ---------------------- | --- | ------------------------------- | --- | --- | --- | --- | ---------------------------------- | --- | --- | ------------------------ | --- | --- |
| diativefluxestimation. |     | Afinaloutputlayerpredictingsix- |     |     |     |     |                                    |     |     |                          |     |     |
meanofactualvalues,andnisthetotalnumberofsamples.
directionalshortwaveandlongwaveradiationcomponents,
whichareusedtocomputeT . Thesemetricsensureacomprehensiveevaluationofmodel
mrt
accuracy,reliability,andbias.
| To optimize  |        | model performance, |     | we employed       |         | Neural |     |     |     |     |     |     |
| ------------ | ------ | ------------------ | --- | ----------------- | ------- | ------ | --- | --- | --- | --- | --- | --- |
| Architecture | Search | (NAS)              | to  | explore different | network |        |     |     |     |     |     |     |
4.Results
configurationsandconductedarandomsearchforhyperpa-
rametertuning. Thetrainingprocesswasfurtherrefinedus- 4.1.ShadePredictionAccuracy
ingk=3foldcross-validationtoensurerobustnessandpre-
|                           |     |                                        |                            |     |     |     | A crucial        | component                          | of our | model is | the fisheye-derived |     |
| ------------------------- | --- | -------------------------------------- | -------------------------- | --- | --- | --- | ---------------- | ---------------------------------- | ------ | -------- | ------------------- | --- |
| ventoverfitting.          |     | Aschematicrepresentationofthearchitec- |                            |     |     |     |                  |                                    |        |          |                     |     |
|                           |     |                                        |                            |     |     |     | shadeprediction. | Tovalidateshadeaccuracy,wecompared |        |          |                     |     |
| tureispresentedinFigure3. |     |                                        | Thetrainingdatasetwassplit |     |     |     |                  |                                    |        |          |                     |     |
into80%fortrainingand20%forvalidation. thepredictedshadefeaturewiththegroundtruthshademea-
suredduringfielddatacollection.Theresultsshowanover-
3.4.EvaluationMetricsofthePredictionModel allaccuracyof94%,indicatingthatourmethodeffectively
distinguishessun-exposedandshadedareas.
| Model performance |     | was | assessed | using four | key metrics. |     |     |     |     |     |     |     |
| ----------------- | --- | --- | -------- | ---------- | ------------ | --- | --- | --- | --- | --- | --- | --- |
TheRootMeanSquaredError(RMSE)quantifiestheaver- CorrectlyPredictedShade
|     |     |     |     |     |     |     | Accuracy= |     |     |     | ×100%=94% |     |
| --- | --- | --- | --- | --- | --- | --- | --------- | --- | --- | --- | --------- | --- |
age prediction error magnitude, with lower values indicat- TotalInstances
ingbetteraccuracy:
|     |     |     |     |     |     |     | This high | accuracy | suggests | that our | sky mask | and sun |
| --- | --- | --- | --- | --- | --- | --- | --------- | -------- | -------- | -------- | -------- | ------- |
(cid:118)
(cid:117) position calculations reliably estimate shading conditions,
|     |                |     | (cid:117)1 (cid:88) n |            |     |     |                                                        |     |     |     |     |     |
| --- | -------------- | --- | --------------------- | ---------- | --- | --- | ------------------------------------------------------ | --- | --- | --- | --- | --- |
|     |                |     |                       | )2         |     |     | reinforcingtheeffectivenessoffisheyeimagesforradiation |     |     |     |     |     |
|     | RMSE=(cid:116) |     |                       | (y i −yˆ i |     | (5) |                                                        |     |     |     |     |     |
n
|     |     |     | i=1 |     |     |     | modeling. |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --------- | --- | --- | --- | --- | --- |

4.2.MachineLearningModelPerformance our approach, especially when conventional input features
areincompleteorunavailable.
Toestablishastrongbaseline,weevaluatedtraditionalma-
| chine learning | methods | and | tree-based | models | on MaRTy |     |     |     |     |     |     |     |
| -------------- | ------- | --- | ---------- | ------ | -------- | --- | --- | --- | --- | --- | --- | --- |
R2
data for the instances with available site images using the Model RMSE Features Images
WebMRT [4] feature set, including: air temperature, rel- NeuralNetwork 3.65 0.87 WebMRTSet ✗
|                 |          |        |          |     |           |       | NeuralNetwork | 6.33 0.63 |                           | Shade✗,Built✓ |     | ✗   |
| --------------- | -------- | ------ | -------- | --- | --------- | ----- | ------------- | --------- | ------------------------- | ------------- | --- | --- |
| ative humidity, | and wind | speed, | altitude |     | above sea | level |               |           |                           |               |     |     |
|                 |          |        |          |     |           |       | NeuralNetwork | 4.25 0.81 | Pred.Shade✓,Shade✗,Built✗ |               |     | ✗   |
and presence of shade at measurement, and built environ- Shade✗,Built✗ ✗
|                |                   |          |                |     |             |     | NeuralNetwork | 10.58 0.32 |                           |               |     |     |
| -------------- | ----------------- | -------- | -------------- | --- | ----------- | --- | ------------- | ---------- | ------------------------- | ------------- | --- | --- |
|                |                   |          |                |     |             |     | MultimodalNN  | 6.06 0.66  |                           | Shade✗,Built✗ |     | ✓   |
| ment prperties | such as           | sky view | factor         | and | percentages | of  |               |            |                           |               |     |     |
|                |                   |          |                |     |             |     | MultimodalNN  | 3.87 0.86  | Pred.Shade✓,Shade✗,Built✗ |               |     | ✓   |
| surrounding    | trees, buildings, |          | and impervious |     | surfaces,   | and |               |            |                           |               |     |     |
extracted features including time in minutes from sunrise, PINN 3.63 0.88 WebMRTSet ✗
|     |     |     |     |     |     |     |      |           |     | Shade✗,Built✓ |     | ✗   |
| --- | --- | --- | --- | --- | --- | --- | ---- | --------- | --- | ------------- | --- | --- |
|     |     |     |     |     |     |     | PINN | 6.02 0.65 |     |               |     |     |
sun azimuth angle, and sun altitude angle. These models PINN 9.80 0.34 Shade✗,Built✗ ✗
performedexceptionallywell,withXGBoostachievingthe PINN 3.67 0.88 Pred.Shade✓,Shade✗,Built✗ ✗
|                                            |     |     |     |     |     |     | MultimodalPINN | 3.46 0.89 |     | WebMRTSet     |     | ✓   |
| ------------------------------------------ | --- | --- | --- | --- | --- | --- | -------------- | --------- | --- | ------------- | --- | --- |
| lowestRMSE.TheresultsarepresentedinTable2. |     |     |     |     |     |     |                |           |     | Shade✗,Built✗ |     | ✓   |
|                                            |     |     |     |     |     |     | MultimodalPINN | 3.54 0.87 |     |               |     |     |
ExperimentalSetup: MultimodalPINN 3.50 0.88 Pred.Shade✓,Shade✗,Built✗ ✓
Ourexperimentswereconductedon
ahigh-performancecomputingsystemwith:
• GPU:NVIDIATeslaT4(16GBVRAM). Table 3. Performance of deep learning models across different
featuresets.
• RAM:16GBsystemmemory.
| • Processor: | IntelXeonCPU. |     |     |     |     |     |     |     |     |     |     |     |
| ------------ | ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
• OperatingSystem: Linux-basedenvironment. Table 3 shows that fisheye-derived shading enables PINN
modelstoachieveWebMRT-levelaccuracy(RMSE=3.50
|     |       |     |      | R2  |     |     | vs. 3.48). ThisconfirmsthatT |     | mrt | canbeestimatedwithout |     |     |
| --- | ----- | --- | ---- | --- | --- | --- | ---------------------------- | --- | --- | --------------------- | --- | --- |
|     | Model |     | RMSE |     |     |     |                              |     |     |                       |     |     |
relianceonthemeasuredurbanmetadata,improvingadapt-
|     | RidgeRegression |     | 5.48 | 0.771 |     |     |     |     |     |     |     |     |
| --- | --------------- | --- | ---- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
ability.
|     | LassoRegression |     | 5.56 | 0.762 |     |     |     |     |     |     |     |     |
| --- | --------------- | --- | ---- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
Tofurtheranalyzeperformance,wecomparekeymodels
|     | SVR |     | 4.01 | 0.875 |     |     |     |     |     |     |     |     |
| --- | --- | --- | ---- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
basedonRMSE,R2,MAPE,andMBE(Table4).
|     | DecisionTree |     | 4.72 | 0.821 |     |     |     |     |     |     |     |     |
| --- | ------------ | --- | ---- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
|     | RandomForest |     | 3.49 | 0.889 |     |     |     |     |     |     |     |     |
|     | LightGBM     |     | 3.48 | 0.891 |     |     |     |     |     |     |     |     |
R2
|     | XGBoost |     | 3.48 | 0.893 |     |     | Model         |     |     | RMSE       | MAPE | MBE  |
| --- | ------- | --- | ---- | ----- | --- | --- | ------------- | --- | --- | ---------- | ---- | ---- |
|     |         |     |      |       |     |     | NeuralNetwork |     |     | 3.65 0.879 | 6.2  | 0.24 |
Table 2. Performance of machine learning models on the MultimodalNeuralNetwork 3.87 0.863 7.47 0.31
WebMRTfeatureset. Physics-InformedNeuralNetwork 3.63 0.881 6.1 0.22
|     |     |     |     |     |     |     | MultimodalPhysics-InformedNeuralNetwork |     |     | 3.50 0.889 | 6.3 | 0.26 |
| --- | --- | --- | --- | --- | --- | --- | --------------------------------------- | --- | --- | ---------- | --- | ---- |
Table4.ComparisonofselectedmodelsusingRMSE,R2,MAPE,
| 4.3.AblationStudy: |     | ImpactofFeaturesandImages |     |     |     |     |     |     |     |     |     |     |
| ------------------ | --- | ------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
andMBEmetrics.
Toanalyzethecontributionsofdifferentinputfeatures,we
conducted an ablation study by testing various configura- ThiscomparisonhighlightsthatthePINNwithfisheye-
| tions of    | neural networks | (NNs) | and  | PINNs. | We      | exam-  |                  |               |             |          |        |       |
| ----------- | --------------- | ----- | ---- | ------ | ------- | ------ | ---------------- | ------------- | ----------- | -------- | ------ | ----- |
|             |                 |       |      |        |         |        | based features   | and predicted | shading     | achieves | nearly | the   |
| ined models | trained with    | the   | full | WebMRT | feature | set as |                  |               |             |          |        |       |
|             |                 |       |      |        |         |        | same performance | as the        | full WebMRT | feature  | set    | while |
a baseline, as well as variations where built environment eliminating the need for manually provided built environ-
featuressuchasskyviewfactor(SVF),surroundingbuild-
|     |     |     |     |     |     |     | ment attributes. | These results | validate | the effectiveness |     | of  |
| --- | --- | --- | --- | --- | --- | --- | ---------------- | ------------- | -------- | ----------------- | --- | --- |
ings, and trees were excluded. Additionally, we evaluated our approach in estimating T using image-derived ur-
mrt
theimpactofincorporatingfisheye-derivedpredictedshade
banfeatures,makingitscalableforlarge-scaleapplications
| features | and features | extracted | from | fisheye | images | using |     |     |     |     |     |     |
| -------- | ------------ | --------- | ---- | ------- | ------ | ----- | --- | --- | --- | --- | --- | --- |
wheredetailedmetadatamaynotbeavailable.
ResNet-50. Finally,wecomparedtheperformanceofstan- Thecomparativeperformanceofdifferentmodelsisvi-
| dard NNs | and PINNs | to assess | the | benefits | of embedding |     |                 |           |                 |      |            |     |
| -------- | --------- | --------- | --- | -------- | ------------ | --- | --------------- | --------- | --------------- | ---- | ---------- | --- |
|          |           |           |     |          |              |     | sually depicted | in Figure | 4, illustrating | RMSE | variations |     |
physicalconstraintsintothelearningprocess.
acrossdifferentconfigurations.
| The results | in Table    | 3 show    | that         | models | using the | full   |     |     |     |     |     |     |
| ----------- | ----------- | --------- | ------------ | ------ | --------- | ------ | --- | --- | --- | --- | --- | --- |
| WebMRT      | feature set | performed | consistently |        | well.     | In the |     |     |     |     |     |     |
5.Discussion
absenceofrichmetadata,thebest-performingPINNmodel
with fisheye images achieved an RMSE of 3.50, demon- Our findings demonstrate that incorporating PINNs into
strating its effectiveness. Additionally, models using pre- T estimationenhancesbothaccuracyandphysicalcon-
mrt
dicted shade instead of measured shade performed simi- sistencycomparedtodata-drivenmodelslikeWebMRT[4].
larly,confirmingtheaccuracyofourfisheye-basedshading Unlike empirical models such as ENVI-met and SOL-
estimation. These findings underscore the adaptability of WEIG [36], which require extensive computational re-

tions,validatingtheaccuracyoffisheye-basedshadingesti-
|     |     |     |     |     |     |     | mation.        | By integrating | these   | image-derived |         | features, | our     |
| --- | --- | --- | --- | --- | --- | --- | -------------- | -------------- | ------- | ------------- | ------- | --------- | ------- |
|     |     |     |     |     |     |     | model captured |                | dynamic | shading       | effects | without   | relying |
onpredefinedurbanmorphologydatasets,significantlyim-
|     |     |     |     |     |     |     | provingT | prediction. |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | -------- | ----------- | --- | --- | --- | --- | --- |
mrt
|     |     |     |     |     |     |     | Answer            | to RQ3: | Our model        | performed |           | well in   | desert ur-  |
| --- | --- | --- | --- | --- | --- | --- | ----------------- | ------- | ---------------- | --------- | --------- | --------- | ----------- |
|     |     |     |     |     |     |     | ban environments, |         | where            | shading   | and solar | radiation | play        |
|     |     |     |     |     |     |     | a crucial         | role in | thermal comfort. |           | However,  | its       | applicabil- |
itytotemperateandhumidclimatesrequiresadditionalval-
|     |     |     |     |     |     |     | idation, | as urban | materials, | vegetation | density, |     | and atmo- |
| --- | --- | --- | --- | --- | --- | --- | -------- | -------- | ---------- | ---------- | -------- | --- | --------- |
sphericconditionsdiffersignificantlyacrossregions.
|     |     |     |     |     |     |     | AnswertoRQ4:                           |     | ThePINNframeworkenforcesradiative |     |     |              |     |
| --- | --- | --- | --- | --- | --- | --- | -------------------------------------- | --- | --------------------------------- | --- | --- | ------------ | --- |
|     |     |     |     |     |     |     | energybalanceconstraints,ensuringthatT |     |                                   |     |     | estimatesad- |     |
mrt
|     |     |     |     |     |     |     | here to fundamental |     | thermodynamic |     | principles. |     | This pre- |
| --- | --- | --- | --- | --- | --- | --- | ------------------- | --- | ------------- | --- | ----------- | --- | --------- |
ventsphysicallyunrealisticpredictionscommonlyfoundin
purelydata-drivenmodelsandimprovesinterpretability.
Figure 4. Comparison of RMSE for different machine learning Answer to RQ5: By leveraging vision-based feature ex-
|     |     |     |     |     |     |     | traction, | ourframeworkreducesdependencyoncostlyand |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --------- | ---------------------------------------- | --- | --- | --- | --- | --- |
anddeeplearningmodels.
|     |     |     |     |     |     |     | labor-intensive | radiation |     | sensors. | Our | results | show that |
| --- | --- | --- | --- | --- | --- | --- | --------------- | --------- | --- | -------- | --- | ------- | --------- |
PINNwithfisheye-derivedshadingfeaturesachievesaccu-
sources, our PINN framework offers a transferable intel- racycomparabletomodelsusingfullenvironmentalmeta-
data,suggestingaviablealternativeforlarge-scale,sensor-
| ligence | that remains | robust | even | when | built environment |     |     |     |     |     |     |     |     |
| ------- | ------------ | ------ | ---- | ---- | ----------------- | --- | --- | --- | --- | --- | --- | --- | --- |
metadata and predifined shading info is unavailable. Ad- independentthermalassessments.
ditionally,unliketheGA-BPNNmodelproposedbyXieet
|           |       |           |             |         |             |     | Limitations:         | Despite | promising |         | results,      | our approach | has       |
| --------- | ----- | --------- | ----------- | ------- | ----------- | --- | -------------------- | ------- | --------- | ------- | ------------- | ------------ | --------- |
| al. [40], | which | relies on | statistical | feature | extraction, | our |                      |         |           |         |               |              |           |
|           |       |           |             |         |             |     | several limitations. |         | The       | dataset | was collected |              | in desert |
approachdirectlyintegratesradiativetransferequationsand
|     |     |     |     |     |     |     | regions, | meaning | the model | may | not generalize |     | well to |
| --- | --- | --- | --- | --- | --- | --- | -------- | ------- | --------- | --- | -------------- | --- | ------- |
extractedfeatures,ensuringthermodynamicconsistency.
|     |     |     |     |     |     |     | colder climates |     | without additional |     | data. | Additionally, | the |
| --- | --- | --- | --- | --- | --- | --- | --------------- | --- | ------------------ | --- | ----- | ------------- | --- |
Ourmethoddynamicallyinfersshadingfromfisheyeim-
|     |     |     |     |     |     |     | multimodal | PINN | framework | requires | significant |     | GPU re- |
| --- | --- | --- | --- | --- | --- | --- | ---------- | ---- | --------- | -------- | ----------- | --- | ------- |
agery,achieving94%agreementwithmeasureddata,prov-
|                                                  |     |     |     |     |     |      | sources, | which may | limit | real-time | deployment. |     | Finally, |
| ------------------------------------------------ | --- | --- | --- | --- | --- | ---- | -------- | --------- | ----- | --------- | ----------- | --- | -------- |
| ingitsreliabilityasafieldmeasurementalternative. |     |     |     |     |     | Com- |          |           |       |           |             |     |          |
furthervalidationindiverseurbanenvironmentswithvaried
pared to previous T mrt estimation models, such as those architecturalandvegetationlayoutsisnecessarytoenhance
| developed | by Jia | et al. | [20] and | Xie et | al. [40], which | of- |     |     |     |     |     |     |     |
| --------- | ------ | ------ | -------- | ------ | --------------- | --- | --- | --- | --- | --- | --- | --- | --- |
generalizability.
| ten struggle | with | dataset | biases, | our | approach combines |     |     |     |     |     |     |     |     |
| ------------ | ---- | ------- | ------- | --- | ----------------- | --- | --- | --- | --- | --- | --- | --- | --- |
computervisionandphysics-informedlearningtoimprove
6.Conclusion
| adaptabilityacrossdiverseurbansettings. |     |     |     |     | Furthermore,our |     |     |     |     |     |     |     |     |
| --------------------------------------- | --- | --- | --- | --- | --------------- | --- | --- | --- | --- | --- | --- | --- | --- |
workextendspriorstudieslike“FiftyGradesofShade”by Inthisstudy,weintroducedanovelPINNframeworkfores-
Middeletal.[31],whichemphasizedtheroleofshadingin timatingT ,integratingradiativetransferprincipleswith
mrt
| pedestrianthermalcomfort, |     |     | bydemonstratingthatfisheye- |     |     |     |               |                                       |     |     |     |     |     |
| ------------------------- | --- | --- | --------------------------- | --- | --- | --- | ------------- | ------------------------------------- | --- | --- | --- | --- | --- |
|                           |     |     |                             |     |     |     | deeplearning. | Ourapproachbridgesthegapbetweentradi- |     |     |     |     |     |
derivedfeaturescanaccuratelyestimateshadingconditions tionalphysics-basedmodelsanddata-drivenmachinelearn-
withoutrequiringdirectfieldobservations. ingmethodsbyleveragingmultimodalenvironmentaldata,
The following discussion revisits our research ques- includingfisheyeimagesandmetadata. Theresultsindicate
tions, highlighting how our framework improves accuracy, that our method successfully addresses key challenges in
| shading              | estimation, | and                               | generalizabilitywhile |     | maintaining |     |                                                       |     |              |     |             |      |        |
| -------------------- | ----------- | --------------------------------- | --------------------- | --- | ----------- | --- | ----------------------------------------------------- | --- | ------------ | --- | ----------- | ---- | ------ |
|                      |             |                                   |                       |     |             |     | T mrt estimation,particularlyinurbanenvironmentswhere |     |              |     |             |      |        |
| physicalconsistency. |             |                                   |                       |     |             |     | radiationdynamicsarehighlycomplex.                    |     |              |     |             |      |        |
| AnswertoRQ1:         |             | OurPINNframework,particularlywhen |                       |     |             |     |                                                       |     |              |     |             |      |        |
|                      |             |                                   |                       |     |             |     | Our framework                                         |     | demonstrates |     | that PINNs, | when | linked |
incorporating fisheye-derived shading, demonstrated supe- with fisheye-derived features, can achieve high accuracy
riorperformanceinscenarioswithincompletemetadata. It even in scenarios where complete environmental metadata
provided results comparable to traditional empirical mod- isunavailable. ThePINN modelprovedto bethe superior
elswhensufficientenvironmentaldatawasavailablewhile choice when direct shading or surrounding building data
maintainingphysicalconsistencythroughradiativebalance wasmissing. Thebest-performingconfiguration,whichin-
constraints. cluded fisheye-derived shading and surrounding informa-
AnswertoRQ2: Ourapproachachieveda94%agreement tion,achievedanRMSEof3.50,outperformingalternative
between predicted shading and measured shading condi- approaches in data-limited scenarios. This confirms that

fisheye images serve as a reliable proxy for capturing lo- works(pinns)forfluidmechanics: Areview. ActaMechan-
calshadingconditions,allowingthemodeltoinferradiative icaSinica,37(12):1727–1738,2021. 2
[9] YongbaoChen,QiguoYang,ZheChen,ChengchuYan,Shu
fluxvariationswithoutrequiringexplicitmetadatainput.
|     |     |     |     |     |     |     |     | Zeng,andMingkunDai. |     |     | Physics-informedneuralnetworks |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------- | --- | --- | ------------------------------ | --- | --- | --- |
FutureWork
forbuildingthermalmodelinganddemandresponsecontrol.
Future work will focus on optimizing the PINN archi- BuildingandEnvironment,234:110149,2023. 3
tecturetoimprovecomputationalefficiencyandenablesix- [10] Kaoutar Clero, Mohamed Nadour, Said Ed-Diny, Mo-
direction image input. Additionally, expanding the dataset hammed Achalhi, Mouhamed Cherkaoui, Hamd Ait Abde-
toincludeurbanenvironmentswithvaryingclimaticcondi- lali,SanaaElFkihi,IntissarBenzakour,SaidRziki,Hicham
tionswillhelpvalidatethemodel’sscalability.Investigating Tagemouati, etal. Areviewoftheuseofthermalimaging
|     |     |     |     |     |     |     |     | andcomputervisionforpatternrecognition. |     |     |     |     |     | ComputerSci- |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------------------------------- | --- | --- | --- | --- | --- | ------------ |
alternativedeeplearningarchitectures,suchastransformer-
|               |      |         |         |         |            |     |      | ence&InformationTechnology(CS&IT),13(21),2023. |     |     |     |     |     | 3   |
| ------------- | ---- | ------- | ------- | ------- | ---------- | --- | ---- | ---------------------------------------------- | --- | --- | --- | --- | --- | --- |
| based models, | will | enhance | spatial | feature | extraction |     | from |                                                |     |     |     |     |     |     |
fisheyeimages. Lastly, integratingthisframeworkintoex- [11] PeterJCrank,ArianeMiddel,MelissaWagner,DaniHoots,
|              |         |            |     |       |              |     |        | MartinSmith, |     | andAnthonyBrazel. |     |     | Validationofseasonal |     |
| ------------ | ------- | ---------- | --- | ----- | ------------ | --- | ------ | ------------ | --- | ----------------- | --- | --- | -------------------- | --- |
| isting urban | climate | simulation |     | tools | will provide |     | a more |              |     |                   |     |     |                      |     |
meanradianttemperaturesimulationsinhotaridurbancli-
| comprehensive |     | approach | to assessing |     | outdoor | human | ther- |        |                                               |     |     |     |     |     |
| ------------- | --- | -------- | ------------ | --- | ------- | ----- | ----- | ------ | --------------------------------------------- | --- | --- | --- | --- | --- |
|               |     |          |              |     |         |       |       | mates. | ScienceoftheTotalEnvironment,749:141392,2020. |     |     |     |     |     |
malexposureincities.
1
| By refining      |              | and extending |            | our    | approach,  |        | this re- |                                                    |                                              |           |        |            |             |             |
| ---------------- | ------------ | ------------- | ---------- | ------ | ---------- | ------ | -------- | -------------------------------------------------- | -------------------------------------------- | --------- | ------ | ---------- | ----------- | ----------- |
|                  |              |               |            |        |            |        |          | [12] Ahmed                                         | HM                                           | Eldesoky, | Nicola | Colaninno, |             | and Eugenio |
| search lays      | the          | foundation    | for        | a more | scalable   | and    | inter-   |                                                    |                                              |           |        |            |             |             |
|                  |              |               |            |        |            |        |          | Morello.                                           | High-resolutionairtemperaturemappinginadata- |           |        |            |             |             |
| pretable         | T estimation |               | framework, |        | ultimately | aiding | in       |                                                    |                                              |           |        |            |             |             |
|                  | mrt          |               |            |        |            |        |          | scarce,aridareabymeansoflow-costmobilemeasurements |                                              |           |        |            |             |             |
| climate-adaptive |              | urban         | planning   | and    | public     | health | strate-  |                                                    |                                              |           |        |            |             |             |
|                  |              |               |            |        |            |        |          | and                                                | machine                                      | learning. | In     | Journal    | of Physics: | Conference  |
gies.
|     |     |     |     |     |     |     |     | Series,page012045.IOPPublishing,2021.                   |     |     |     |     | 1   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------------------------------------------- | --- | --- | --- | --- | --- | --- |
|     |     |     |     |     |     |     |     | [13] VeronikaEngert,ArcangeloMerla,JoshuaAGrant,Daniela |     |     |     |     |     |     |
References
|                                         |     |     |     |     |     |                |     | Cardone,AnitaTusche,andTaniaSinger.            |     |     |     |     | Exploringtheuse |      |
| --------------------------------------- | --- | --- | --- | --- | --- | -------------- | --- | ---------------------------------------------- | --- | --- | --- | --- | --------------- | ---- |
|                                         |     |     |     |     |     |                |     | ofthermalinfraredimaginginhumanstressresearch. |     |     |     |     |                 | PloS |
| [1] AlirezaAfzalAghaeiandKouroshParand. |     |     |     |     |     | Hyperparameter |     |                                                |     |     |     |     |                 |      |
|                                         |     |     |     |     |     |                |     | one,9(3):e90782,2014.                          |     |     | 3   |     |                 |      |
optimizationoforthogonalfunctionsinthenumericalsolu-
|                              |     |     |     |                          |     |     |     | [14] AnnaFabijan´skaandDominikSankowski. |     |     |     |     | Computervision |     |
| ---------------------------- | --- | --- | --- | ------------------------ | --- | --- | --- | ---------------------------------------- | --- | --- | --- | --- | -------------- | --- |
| tionofdifferentialequations. |     |     |     | MathematicalMethodsinthe |     |     |     |                                          |     |     |     |     |                |     |
systemforhightemperaturemeasurementsofsurfaceprop-
| AppliedSciences,48(1):605–625,2025. |       |         |         |         | 2   |          |     |         |                                               |     |     |     |     |     |
| ----------------------------------- | ----- | ------- | ------- | ------- | --- | -------- | --- | ------- | --------------------------------------------- | --- | --- | --- | --- | --- |
|                                     |       |         |         |         |     |          |     | erties. | MachineVisionandApplications,20:411–421,2009. |     |     |     |     |     |
| [2] Alireza                         | Afzal | Aghaei, | Kourosh | Parand, | Ali | Nikkhah, | and |         |                                               |     |     |     |     |     |
4
| Shakila                | Jaberi. | Solving   | falkner-skan |         | type | equations | via      |          |         |               |              |         |             |             |
| ---------------------- | ------- | --------- | ------------ | ------- | ---- | --------- | -------- | -------- | ------- | ------------- | ------------ | ------- | ----------- | ----------- |
|                        |         |           |              |         |      |           |          | [15] Ali | Nosrati | Firoozsalari, |              | Hassan  | Dana        | Mazraeh,    |
| legendre               | and     | chebyshev | neural       | blocks. |      | arXiv     | preprint |          |         |               |              |         |             |             |
|                        |         |           |              |         |      |           |          | Alireza  | Afzal   | Aghaei,       | and          | Kourosh | Parand.     | deepfdenet: |
| arXiv:2308.03337,2023. |         |           | 3            |         |      |           |          |          |         |               |              |         |             |             |
|                        |         |           |              |         |      |           |          | A novel  | neural  | network       | architecture |         | for solving | fractional  |
[3] AlirezaAfzalAghaei,MahdiMovahedianMoghaddam,and
|         |         |           |     |              |                  |           |     | differential                                              |     | equations. | arXiv | preprint | arXiv:2309.07684, |     |
| ------- | ------- | --------- | --- | ------------ | ---------------- | --------- | --- | --------------------------------------------------------- | --- | ---------- | ----- | -------- | ----------------- | --- |
| Kourosh | Parand. | Pinnies:  |     | An efficient | physics-informed |           |     |                                                           |     |            |       |          |                   |     |
|         |         |           |     |              |                  |           |     | 2023.                                                     | 3   |            |       |          |                   |     |
| neural  | network | framework |     | to integral  | operator         | problems. |     |                                                           |     |            |       |          |                   |     |
|         |         |           |     |              |                  |           |     | [16] AliNosratiFiroozsalari,AlirezaAfzalAghaei,andKourosh |     |            |       |          |                   |     |
arXivpreprintarXiv:2409.01899,2024. 3 Parand. Amachinelearningframeworkforefficientlysolv-
[4] SaudRAlKhaled,ArianeMiddel,PouyaShaeri,IsaacBuo,
|                       |     |     |         |     |                       |     |     | ing                         | fokker–planck |     | equations. | Computational |     | and Applied |
| --------------------- | --- | --- | ------- | --- | --------------------- | --- | --- | --------------------------- | ------------- | --- | ---------- | ------------- | --- | ----------- |
| andFlorianASchneider. |     |     | Webmrt: |     | Anonlinetooltopredict |     |     |                             |               |     |            |               |     |             |
|                       |     |     |         |     |                       |     |     | Mathematics,43(6):389,2024. |               |     |            | 3             |     |             |
summertimemeanradianttemperatureusingmachinelearn-
|     |     |     |     |     |     |     |     | [17] Eric | Fowler, | Christopher |     | J McDevitt, | and | Subrata Roy. |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ------- | ----------- | --- | ----------- | --- | ------------ |
ing. SustainableCitiesandSociety,115:105861,2024. 1,2, Physics-informedneuralnetworksimulationofthermalcav-
| 4,7      |        |         |          |     |           |        |     |                                                          | ScientificReports,14(1):15203,2024. |     |     |     |     |     |
| -------- | ------ | ------- | -------- | --- | --------- | ------ | --- | -------------------------------------------------------- | ----------------------------------- | --- | --- | --- | --- | --- |
|          |        |         |          |     |           |        |     | ityflow.                                                 |                                     |     |     |     |     | 3   |
| [5] Reza | Rahimi | Azghan, | Nicholas | C   | Glodosky, | Ramesh | Ku- |                                                          |                                     |     |     |     |     |     |
|          |        |         |          |     |           |        |     | [18] GiselGuzma´n,NichollasRavanelli,ArianeMiddel,Kendra |                                     |     |     |     |     |     |
marSah,CarrieCuttler,RyanMcLaughlin,MichaelJCleve-
|     |     |     |     |     |     |     |     | Rentz, | Carson | Meltzer, | Mary | Munoz, | Melissa | Guardaro, |
| --- | --- | --- | --- | --- | --- | --- | --- | ------ | ------ | -------- | ---- | ------ | ------- | --------- |
land,andHassanGhasemzadeh. Cudle: Learningunderla- Jose-BenitoRosalesChavez,andJenniferVanos. Heatsuite
belscarcitytodetectcannabisuseinuncontrolledenviron- phoenixpilot:Assesingnon-lifethreateninghealthoutcomes
| ments. | arXivpreprintarXiv:2410.03211,2024. |     |     |     |     | 1   |     |                                                    |     |     |     |     |     |     |
| ------ | ----------------------------------- | --- | --- | --- | --- | --- | --- | -------------------------------------------------- | --- | --- | --- | --- | --- | --- |
|        |                                     |     |     |     |     |     |     | toextremeheatinolderadultslivinginphoenix,arizona. |     |     |     |     |     | In  |
[6] AlimohammadBeigi,BohanJiang,DaweiLi,TharinduKu-
|     |     |     |     |     |     |     |     | 105thAMSAnnualMeeting.AMS,2025. |     |     |     |     | 1   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------------------- | --- | --- | --- | --- | --- | --- |
marage, Zhen Tan, Pouya Shaeri, and Huan Liu. Lrq- [19] Quincy A Huhn, Mauricio E Tano, and Jean C Ragusa.
fact: Llm-generatedrelevantquestionsformultimodalfact- Physics-informed neural network with fourier features for
checking. arXivpreprintarXiv:2410.04616,2024. 2 radiationtransportinheterogeneousmedia. Nuclearscience
| [7] Pratibha | Biswal, | Jetnis | Avdijaj, | Alessandro |     | Parente, | and |                                       |     |     |     |     |     |     |
| ------------ | ------- | ------ | -------- | ---------- | --- | -------- | --- | ------------------------------------- | --- | --- | --- | --- | --- | --- |
|              |         |        |          |            |     |          |     | andengineering,197(9):2484–2497,2023. |     |     |     |     | 3   |     |
AxelCoussement. Radiationtransferequationinparticipat- [20] SiqiJia,YuhongWang,NyukHienWong,ChunLiangTan,
ingmedia:Solutionusingphysicsinformedneuralnetworks. Shisheng Chen, Qihao Weng, and Cheuk Ming Mak. Es-
JournalofFluidFlow,HeatandMassTransfer(JFFHMT), timation of mean radiant temperature across diverse out-
11(1):356–362,2024. 3 doorspaces: Acomparativestudyofdifferentmodelingap-
[8] ShengzeCai,ZhipingMao,ZhichengWang,MinglangYin, proaches. Energy and Buildings, 310:114068, 2024. 2, 3,
| andGeorgeEmKarniadakis. |     |     |     | Physics-informedneuralnet- |     |     |     | 8   |     |     |     |     |     |     |
| ----------------------- | --- | --- | --- | -------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

[21] ArtursKempelis,InesePolaka,AndrejsRomanovs,andAn- puterVisionandPatternRecognition,pages449–459,2024.
| tons | Patlins. | Computer | vision | and machine | learning-based |     | 2   |     |     |
| ---- | -------- | -------- | ------ | ----------- | -------------- | --- | --- | --- | --- |
predictiveanalysisforurbanagriculturalsystems.FutureIn-
[34] MaziarRaissi,ParisPerdikaris,andGeorgeEmKarniadakis.
ternet,16(2):44,2024. 3 Physics informed deep learning (part i): Data-driven so-
[22] BrettKoonceandBrettKoonce. Resnet50. Convolutional lutions of nonlinear partial differential equations. arXiv
neuralnetworkswithswiftfortensorflow:imagerecognition preprintarXiv:1711.10561,2017. 3
| anddatasetcategorization,pages63–72,2021. |     |     |     |     |     | 4   |     |     |     |
| ----------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
[35] MaziarRaissi,ParisPerdikaris,andGeorgeEKarniadakis.
[23] AditiKrishnapriyan, AmirGholami, ShandianZhe, Robert Physics-informedneuralnetworks: Adeeplearningframe-
Kirby, and Michael W Mahoney. Characterizing possible work for solving forward and inverse problems involving
failure modes in physics-informed neural networks. Ad- nonlinearpartialdifferentialequations.JournalofComputa-
vancesinneuralinformationprocessingsystems,34:26548– tionalphysics,378:686–707,2019. 2,3
26560,2021. 3 [36] TimSinsel,HelgeSimon,WanluOuyang,CarolinadosSan-
[24] XiaomaLi,YuyuZhou,GhassemRAsrar,MarcImhoff,and tosGusson,PaulaShinzato,andMichaelBruse. Implemen-
Xuecao Li. The surface urban heat island response to ur- tation and evaluation of mean radiant temperature schemes
banexpansion:Apanelanalysisfortheconterminousunited in the microclimate model envi-met. Urban Climate, 45:
|     |     |     |     |     |     |     | 101279,2022. | 3,7 |     |
| --- | --- | --- | --- | --- | --- | --- | ------------ | --- | --- |
states.ScienceoftheTotalEnvironment,605:426–435,2017.
| 1   |     |     |     |     |     |     | [37] JenniferVanos,GiselGuzman-Echavarria,JaneWBaldwin, |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------------------------------------------------------- | --- | --- |
[25] FLindberg,KFGOlofson,TingSun,CSBGrimmond,and CoenBongers,KristieLEbi,andOllieJay. Aphysiological
CFeigenwinter. Urbanstorageheatfluxvariabilityexplored approachforassessinghumansurvivabilityandliveabilityto
heatinachangingclimate. Naturecommunications,14(1):
| usingsatellite,meteorologicalandgeodata. |     |     |     |     | Theoreticaland |     |            |     |     |
| ---------------------------------------- | --- | --- | --- | --- | -------------- | --- | ---------- | --- | --- |
| AppliedClimatology,141:271–284,2020.     |     |     |     |     | 1              |     | 7653,2023. | 1   |     |
[26] Forrest Meggers, Alexander Kim, Sean Rucewicz, Cole- [38] EnzeXie,WenhaiWang,ZhidingYu,AnimaAnandkumar,
man Merchant, Kianwee Chen, and Eric Teitelbaum. Im- Jose M Alvarez, and Ping Luo. Segformer: Simple and
|         |      |         |              |         |       |          | efficient design | for semantic segmentation | with transform- |
| ------- | ---- | ------- | ------------ | ------- | ----- | -------- | ---------------- | ------------------------- | --------------- |
| proving | mean | radiant | temperatures | sensing | using | multidi- |                  |                           |                 |
rectional non-contacting temperature sensors to avoid con- ers. Advancesinneuralinformationprocessingsystems,34:
vective errors with globe thermometers. In 2022 IEEE In- 12077–12090,2021. 4
ternationalWorkshoponMetrologyforLivingEnvironment [39] Yuquan Xie, Wen Hu, Xilin Zhou, Shuting Yan, and
(MetroLivEn),pages18–22.IEEE,2022. 1,3 ChuanchengLi. Artificialneuralnetworkmodelingforpre-
[27] Ariane Middel and E Scott Krayenhoff. Micrometeoro- dictingandevaluatingthemeanradianttemperaturearound
logical determinants of pedestrian thermal exposure dur- buildingsonhotsummerdays. Buildings,12(5):513,2022.
| ingrecord-breakingheatintempe,arizona: |     |     |     |     | Introducingthe |     | 2   |     |     |
| -------------------------------------- | --- | --- | --- | --- | -------------- | --- | --- | --- | --- |
martyobservationalplatform. Scienceofthetotalenviron- [40] Yuquan Xie, Yasuyuki Ishida, Jialong Hu, and Akashi
ment,687:137–151,2019. 1,3,4 Mochida. A backpropagation neural network improved by
[28] Ariane Middel, Kathrin Ha¨b, Anthony J Brazel, Chris A ageneticalgorithmforpredictingthemeanradianttempera-
Martin, andSubhrajitGuhathakurta. Impactofurbanform turearoundbuildingswithinthelong-termperiodofthenear
anddesignonmid-afternoonmicroclimateinphoenixlocal future. In Building Simulation, pages 473–492. Springer,
2022. 3,8
| climatezones. |     | Landscapeandurbanplanning,122:16–28, |     |     |     |     |                                                     |     |     |
| ------------- | --- | ------------------------------------ | --- | --- | --- | --- | --------------------------------------------------- | --- | --- |
| 2014.         | 1   |                                      |     |     |     |     | [41] BinYang,ShuangYang,XinZhu,MinQi,HeLi,ZhihanLv, |     |     |
[29] Ariane Middel, Nancy Selover, Bjo¨rn Hagen, and Nalini XiaogangCheng,andFamingWang. Computervisiontech-
nologyformonitoringofindoorandoutdoorenvironments
| Chhetri.                           | Impact | of  | shade on | outdoor | thermal              | comfort—a |                   |                                    |     |
| ---------------------------------- | ------ | --- | -------- | ------- | -------------------- | --------- | ----------------- | ---------------------------------- | --- |
|                                    |        |     |          |         |                      |           | andhvacequipment: | areview. Sensors,23(13):6186,2023. |     |
| seasonalfieldstudyintempe,arizona. |        |     |          |         | Internationaljournal |           |                   |                                    |     |
3
| ofbiometeorology,60:1849–1861,2016. |           |       |                   |       | 2     |              |     |     |     |
| ----------------------------------- | --------- | ----- | ----------------- | ----- | ----- | ------------ | --- | --- | --- |
| [30] Ariane                         | Middel,   | Jonas | Lukasczyk,        |       | Ross  | Maciejewski, |     |     |     |
| Matthias                            | Demuzere, |       | and Matthias      | Roth. | Sky   | view factor  |     |     |     |
| footprints                          | for       | urban | climate modeling. |       | Urban | climate, 25: |     |     |     |
| 120–134,2018.                       |           | 4,5   |                   |       |       |              |     |     |     |
[31] ArianeMiddel,SaudAlKhaled,FlorianASchneider,Bjoern
| Hagen, | and | Paul Coseo. | 50 grades | of  | shade. | Bulletin of |     |     |     |
| ------ | --- | ----------- | --------- | --- | ------ | ----------- | --- | --- | --- |
theAmericanMeteorologicalSociety,102(9):E1805–E1820,
| 2021.          | 2,4,8   |       |         |          |          |        |     |     |     |
| -------------- | ------- | ----- | ------- | -------- | -------- | ------ | --- | --- | --- |
| [32] K Parand, | Alireza | Afzal | Aghaei, | S Kiani, | T Ilkhas | Zadeh, |     |     |     |
andZKhosravi.Aneuralnetworkapproachforsolvingnon-
| lineardifferentialequationsoflane–emdentype. |     |     |     |     |     | Engineer- |     |     |     |
| -------------------------------------------- | --- | --- | --- | --- | --- | --------- | --- | --- | --- |
| ingwithComputers,40(2):953–969,2024.         |     |     |     |     | 3   |           |     |     |     |
[33] YongquanQu,JuanNathaniel,ShuolinLi,andPierreGen-
| tine. | Deep generative                            |     | data assimilation |     | in multimodal | set- |     |     |     |
| ----- | ------------------------------------------ | --- | ----------------- | --- | ------------- | ---- | --- | --- | --- |
| ting. | InProceedingsoftheIEEE/CVFConferenceonCom- |     |                   |     |               |      |     |     |     |
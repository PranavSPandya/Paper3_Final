TOPICAL REVIEW • OPEN ACCESS You may also like
Cooling hot cities: a systematic and critical review -Efficacy of cool roofs at reducing
pedestrian-level air temperature during
projected 21st century heatwaves in
of the numerical modelling literature
Atlanta, Detroit, and Phoenix (USA)
Ashley M Broadbent, E Scott Krayenhoff
and Matei Georgescu
To cite this article: E Scott Krayenhoff et al 2021 Environ. Res. Lett. 16 053007 -Urban heat mitigation under realistic roof
and land area constraints
Harsh G Kamath, Tzu-Shun Lin, Naveen
Sudharsan et al.
-Different urban heat mitigation strategies
View the article online for updates and enhancements.
are optimal day versus night and for
distinct synoptic weather types
Sara V Hesse, E Scott Krayenhoff,
Abhishek Gaur et al.
This content was downloaded from IP address 104.28.195.136 on 31/10/2026 at 23:13

Environ.Res.Lett.16(2021)053007 https://doi.org/10.1088/1748-9326/abdcf1
TOPICAL REVIEW
Cooling hot cities: a systematic and critical review of the
OPENACCESS
numerical modelling literature
RECEIVED
17April2020 E Scott Krayenhoff1,2,3, Ashley M Broadbent2,3, Lei Zhao4, Matei Georgescu2,3, Ariane Middel2,5,6,
REVISED
JamesAVoogt7,AlbertoMartilli8,DavidJSailor2,3andEvyatarErell9,10
7January2021
1 SchoolofEnvironmentalSciences,UniversityofGuelph,Guelph,ON,Canada
1 AC 8 C J E a P n T u ED ar F y OR 2 P 0 U 2 B 1 LICATION 2 UrbanClimateResearchCenter,ArizonaStateUniversity,Tempe,AZ,UnitedStatesofAmerica
3 SchoolofGeographicalSciencesandUrbanPlanning,ArizonaStateUniversity,Tempe,AZ,UnitedStatesofAmerica
PUBLISHED 4 DepartmentofCivilandEnvironmentalEngineering,UniversityofIllinois,Urbana-Champaign,IL,UnitedStatesofAmerica
6May2021
5 SchoolofArts,MediaandEngineering,ArizonaStateUniversity,Tempe,AZ,UnitedStatesofAmerica
6 SchoolofComputing,Informatics,andDecisionSystemsEngineering,ArizonaStateUniversity,Tempe,AZ,UnitedStatesofAmerica
Originalcontentfrom 7 DepartmentofGeography,WesternUniversity,London,ON,Canada
t u h n i d s e w r o t r h k e m te a rm yb s e o u f s t e h d e 8 AtmosphericPollutionDivision,DepartmentofEnvironment,CIEMAT,Madrid,Spain
CreativeCommons 9 J.BlausteinInstitutesforDesertResearch,Ben-GurionUniversityoftheNegev,SedeBoqerCampus,SedeBoqer8499000,Israel
Attribution4.0licence. 10 DepartmentofGeographyandEnvironmentalDevelopment,Ben-GurionUniversityoftheNegev,SedeBoqerCampus,SedeBoqer
Anyfurtherdistribution 8499000,Israel
ofthisworkmust
maintainattributionto E-mail:skrayenh@uoguelph.ca
theauthor(s)andthetitle
ofthework,journal Keywords:Urbanheatmitigation,greeninfrastructure,reflectivity,albedo,temperaturereduction,simulation
citationandDOI.
Supplementarymaterialforthisarticleisavailableonline
Abstract
Infrastructure-basedheatreductionstrategiescanhelpcitiesadapttohightemperatures,but
simulationsoftheircoolingpotentialyieldwidelyvaryingpredictions.Wesystematicallyreview
146studiesfrom1987to2017thatconductphysicallybasednumericalmodellingofurbanair
temperaturereductionresultingfromgreen-blueinfrastructureandreflectivematerials.Studies
aregroupedintotwomodellingscales:neighbourhoodscale,building-resolving(i.e.microscale);
andcityscale,neighbourhood-resolving(i.e.mesoscale).Streettreecoolinghasprimarilybeen
assessedatthemicroscale,whereasmesoscalemodellinghasfavouredreflectiverooftreatments,
whichareattributedtomodelphysicslimitationsateachscale.Wedevelop25criteriatoassess
contextualizationandreliabilityofeachstudybasedonmetadatareportingandmethodological
quality,respectively.Studieshaveshortcomingswithrespecttoneighbourhoodcharacterization,
reportingarealcoveragesofheatmitigationimplementations,evaluationofbasecasesimulations,
andevaluationofmodelledphysicalprocessesrelevanttoheatreduction.Toaidcomparison
amongstudies,weintroducetwometrics:thealbedocoolingeffectiveness(ACE),andthe
vegetationcoolingeffectiveness(VCE).Asub-sampleof47higherqualitystudiessuggeststhat
highreflectivitycoatingsormaterialsoffer≈0.2 ◦ C–0.6 ◦ Ccoolingper0.10neighbourhoodalbedo
increase,andthattreesyield≈0.3 ◦ Ccoolingper0.10canopycoverincrease,forafternoon
clear-skysummerconditions.VCEoflowvegetationandgreenroofsvariesmorestronglybetween
studies.BothACEandVCEexhibitastrikingdependenceonmodelchoiceandmodelscale,
particularlyforalbedoandroof-levelimplementations,suggestingthatmuchofthevariationof
coolingmagnitudesbetweenstudiesmaybeattributedtomodelphysicsrepresentation.We
concludethatevaluationofthebasecasesimulationisnotasufficientprerequisiteforaccurate
simulationofheatmitigationstrategycooling.Weidentifyathree-phaseframeworkforassessment
ofthesuitabilityofanumericalmodelforaheatmitigationexperiment,whichemphasizes
assessmentofurbancanopylayermixingandofthephysicalprocessesassociatedwiththeheat
reductionimplementation.Basedonourfindings,weincluderecommendationsforoptimal
designandcommunicationofurbanheatmitigationsimulationstudies.
©2021TheAuthor(s).PublishedbyIOPPublishingLtd

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
1.Introduction scaleandspecificity,backgroundmeteorology,neigh-
bourhood context, numerical model construction
Urban areas tend to be hotter than their non- and application, type and intensity of heat mitig-
developed surrounds, and they are projected to fur- ation implementation, and air temperature defini-
ther warm over the 21st century due to global cli- tion (see table 1 for a summary of degrees of free-
mate change and urban development (Rosenzweig dom). As a result, the range of simulated cooling
et al 2015, Krayenhoff et al 2018, Zhao et al magnitudes induced by a given urban heat reduc-
2021). Without appropriate adaptation, high tem- tion strategy varies widely; a comprehensive review
peraturesinlowandmid-latitudecitiesarelikelyto reports cooling that spans a full two orders of
have increasingly adverse effects on health, thermal magnitude: <0.1 ◦C to >5 ◦C (Santamouris et al
comfort and energy consumption outcomes during 2017). Furthermore, key metadata, such as neigh-
warmer seasons. While these outcomes have mul- bourhood morphology, or the specific air volume
tiple causative factors, air temperature is strongly or location associated with the reported temperat-
implicated in all of them and has been widely ure difference, are often unreported. Consequently,
studied. methodological quality becomes uncertain, repeat-
Intentionalmodificationofurbanlandscapescan ability becomes challenging, and comparison of
reduce air temperature locally. Common cooling cooling effectiveness between studies, and therefore
strategies include green infrastructure (Bowler et al between different geographical contexts, is rendered
2010), bluespace and irrigation (Gunawardena et al unfeasible.
2017, Broadbent et al 2018a), and use of reflective In this context, the present review develops
materials or coatings (Taha et al 1988, Krayenhoff the first critical framework for evaluation of sim-
andVoogt2010).Greeninfrastructureincludesstreet ulation studies that assess urban heat reduction
trees,greenroofsandfacades,parks,lawnsandgar- (or heat mitigation) strategies. We evaluate both
dens,whilebluespaceconsistsofstaticanddynamic metadatareportingandmethodologicalquality.Bey-
surfacewaterssuchasponds,riversandlakes.These ondprovisionofappropriatecontextforinterpreta-
strategies generate cooling by reflecting solar radi- tionofmodelledresults,sufficientmetadatareport-
ationawayfromtheurbanenvironmentorredirect- ing permits inter-study comparison of the cooling
ingabsorbedsolarenergyfromsensibletolatentheat effectiveness of commonly proposed heat reduction
(figure1). strategies. Methodological quality gives an indica-
Aprioriassessmentofpotentialcoolingimpactsis tion of the reliability of the results. Reliability of
helpfultodecisionmakers.Numerousobservational results is enhanced by appropriate representation of
studieshavereportedcoolingfromurbanheatreduc- physical processes, suitable model evaluation and
tion strategies (Bowler et al 2010, Aleksandrowicz calibration, and optimal choices related to model
et al 2017, Santamouris et al 2017), each reflect- application. Critically, this review is comprehens-
ingthespecificcharacteristicsofthesitesmonitored ive and systematic, and it is the first review to
and the weather conditions during the measure- undertake an informal meta-analysis to derive typ-
ment period, therefore making generalization diffi- ical cooling efficacies for common heat reduction
cult.Numericalmodellingisgenerallylessdemand- strategiesfromstudiesthatmeetaminimumlevelof
ingthan insitu assessmentofcoolinginfrastructure reliability.
impacts and provides ease of experimental control. An individual heat mitigation simulation study
However, numerical modelling relies, by definition, tied to a particular place may be of practical rel-
onimperfectabstractionsofurbanatmosphericpro- evance to local planners and policy-makers. How-
cesses,anditisappliedatmultiplescalesandincludes ever, it must be situated among related studies if
widely varying methodological approaches, each of it is to inform the broader scientific understand-
whichhasreceiveddifferenttestingagainstmeasured ing of the local climate impacts of heat reduction
data. strategies. Hence, we propose that a central aim
The burgeoning literature focused on numerical of urban heat mitigation research, in addition to
simulationofmicro-to-regionalscaleclimateeffects assessment of local impacts, should be the determ-
ofurbanheatreductionstrategies,reportedinseveral ination of consensus cooling efficacies for common
recentliteraturesurveys(KrayenhoffandVoogt2010, heat reduction strategies, as well as their depend-
Gago et al 2013, Santamouris 2014, Aleksandrowicz ence on a limited number of factors (e.g. time of
etal2017,Gunawardenaetal2017,Santamourisetal day, meteorological conditions; see section 5.4). We
2017,Toparlaretal2017,Piselloetal2018,Tsokaetal further define new indices to aid assessment of the
2018b,Laietal2019,AmpatzidisandKershaw2020), cooling efficacy of albedo-based implementations
has so far failed to provide a consistent framework (albedocoolingeffectiveness(ACE))andvegetation-
for comparing results systematically. Existing simu- based strategies (vegetation cooling effectiveness
lation studies vary in terms of spatial and temporal (VCE))—seesection2.5.1.
2

| Environ.Res.Lett.16(2021)053007 |     |     |     |     | ESKrayenhoffetal |
| ------------------------------- | --- | --- | --- | --- | ---------------- |
Figure1.Urbanheatmitigationstrategiesandtheirimpactsondirectshortwaveradiation(a)andconvectivesensible(QH)and
latent(QE)heatfluxesandresultingairtemperature(b).
To establish consensus cooling efficacies, urban Theintentofthissystematicreviewisthreefold:
| heat mitigation | studies | must be reliable | and appro- |     |     |
| --------------- | ------- | ---------------- | ---------- | --- | --- |
priatelycontextualizedsoastobeinter-comparable. • to assess the urban heat mitigation modelling lit-
We define reliability as the trustworthiness of the erature in terms of methodological quality and
| results, based | on a scientifically | sound | and suffi- metadatareporting; |     |     |
| -------------- | ------------------- | ----- | ----------------------------- | --- | --- |
ciently documented modelling methodology. Com- • to derive a state-of-the-art consensus of cool-
parability relies initially on full reporting of context ing efficacies associated with implementation of
(e.g. meteorology, urban neighbourhood type) and common heat reduction strategies from existing
methodologicaldesign(e.g.implementationtypeand high-qualitystudiesintheliterature;
intensity),andultimatelyonconstraintofthemany • torecommendkeymethodologicalapproachesand
degrees of freedom inherent in urban heat reduc- the reporting of essential metadata for enhanced
tion simulation studies (table 1). The local climate reliability and comparability of urban heat mitig-
| zone scheme | (Stewart | and Oke 2012) represents | a ationstudies. |     |     |
| ----------- | -------- | ------------------------ | --------------- | --- | --- |
similarmethodologicaldevelopmentintheobserva-
tional urban heat island literature, aimed at enhan- The scope is limited to high albedo materials,
cing comparison between measurement sites and photovoltaicsandgreenandblueinfrastructure,and
| studies. |     |     | tostudiesthat | applynumerical | modelling; however, |
| -------- | --- | --- | ------------- | -------------- | ------------------- |
3

| Environ.Res.Lett.16(2021)053007 |     |     |     |     |     |     |     |     |     |     | ESKrayenhoffetal |     |
| ------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- |
Table1.Principaldegreesoffreedominnumericalsimulationofairtemperatureresponsetourbanheatmitigationimplementations.
| Degreeoffreedom |     |     |     | Explanationandexamples |     |     |     |     |     |     |     |     |
| --------------- | --- | --- | --- | ---------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
Context
Meteorological Maximumsolarangle,meanwindspeed,degreeofcloudiness,etc
Neighbourhood Characterofthelocalcover,structureandfabric(e.g.localclimatezone)
Toolandapplication
Numericalmodel Processesrepresented(scale),andcomplexity&accuracyoftheirtreatment
Modelapplication Simulationdevelopment,includinginitialandboundaryconditions,modelcalib-
ration,parametervaluesandotherchoicesmadebyresearcher
Surfaceperturbation
Choiceofheatmitigation Typeofsurfacemodification(seesupplementarytable2)
implementation
Areaandintensityof Spatialcoverageandintensity(e.g.degreeofalbedoorleafareaindexincrease)
implementation
| Locationofimplementation |     |     |     | Roof,walls,ground. |     |     |     |     |     |     |     |     |
| ------------------------ | --- | --- | --- | ------------------ | --- | --- | --- | --- | --- | --- | --- | --- |
Systemresponse
Verticalspecificity Specificlevelorlayeroverwhichaveragingisundertaken(e.g.2mairtemperature
orcanopylayerairtemperature)
Temporalspecificity Specifictimeoraveragingperiodcorrespondingtoresults(e.g.July21diurnal
maximum,June–July–Augustdiurnalmean,etc)
the criteria and guidelines herein may inform scale- urban heat mitigation (Martilli et al 2020). Urban
modelandobservationalwork. heat mitigation strategy implementations typic-
|     |     |     |     |     |     |     | ally include | one | or more | of the | following: | street |
| --- | --- | --- | --- | --- | --- | --- | ------------ | --- | ------- | ------ | ---------- | ------ |
trees,reflectivesurfaces,shortvegetation,permeable
2.Methodology
|     |     |     |     |     |     |     | surfaces,       | irrigation, | water     | features, | or photovoltaic |       |
| --- | --- | --- | --- | --- | --- | --- | --------------- | ----------- | --------- | --------- | --------------- | ----- |
|     |     |     |     |     |     |     | panels, applied |             | at ground | level,    | on rooftops,    | or on |
2.1.Defining‘urbanheatmitigation’
buildingwalls.
| Infrastructure-based |         | urban | heat             | mitigation |     | can    |     |     |     |     |     |     |
| -------------------- | ------- | ----- | ---------------- | ---------- | --- | ------ | --- | --- | --- | --- | --- | --- |
| include              | a broad | range | of modifications |            | to  | build- |     |     |     |     |     |     |
2.2.Literaturesampleinclusioncriteria
| ing envelopes, | building |     | and tree | configuration, |     | and |     |     |     |     |     |     |
| -------------- | -------- | --- | -------- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- |
landscape design. Here, we focus on several com- The literature sample was drawn from English
|                    |     |      |            |            |     |      | language, | peer-reviewed |     | journal | articles | published |
| ------------------ | --- | ---- | ---------- | ---------- | --- | ---- | --------- | ------------- | --- | ------- | -------- | --------- |
| monly investigated |     | heat | mitigation | strategies |     | that |           |               |     |         |          |           |
are relevant for both existing and newly-designed betweenJanuary1987andJune2017.WebofScience
|     |     |     |     |     |     |     | search terms | with | combinations |     | of words | related to |
| --- | --- | --- | --- | --- | --- | --- | ------------ | ---- | ------------ | --- | -------- | ---------- |
neighbourhoods.‘Gray’modificationstoneighbour-
hood configuration, including building morpho- cities, modelling, mitigation, and cooling and tem-
|          |        |             |     |            |     |       | perature | and related | searching |     | returned | 2414 art- |
| -------- | ------ | ----------- | --- | ---------- | --- | ----- | -------- | ----------- | --------- | --- | -------- | --------- |
| logy and | street | orientation | and | engineered |     | shade |          |             |           |     |          |           |
devices, are excluded from this review in order to icles (see supplementary methods (available online
|           |                |     |         |          |            |     | at stacks.iop.org/ERL/16/053007/mmedia)). |     |     |     |     | Assess- |
| --------- | -------------- | --- | ------- | -------- | ---------- | --- | ----------------------------------------- | --- | --- | --- | --- | ------- |
| constrain | the literature |     | sample; | although | alteration |     |                                           |     |     |     |     |         |
of the built configuration is more difficult in exist- ment of these articles by two reviewers was under-
|     |     |     |     |     |     |     | taken, qualifying |     | articles | for the | subsequent | review |
| --- | --- | --- | --- | --- | --- | --- | ----------------- | --- | -------- | ------- | ---------- | ------ |
ingneighbourhoods,itisparticularlyrelevanttothe
design and construction of new neighbourhoods. samplewhentheymetallofthefollowingcriteria:
| Thus, this | review | focuses | on non-structural |     |     | modi- |     |     |     |     |     |     |
| ---------- | ------ | ------- | ----------------- | --- | --- | ----- | --- | --- | --- | --- | --- | --- |
fications to urban land cover, and/or urban facet • utilizes a physically-based numerical modelling
| properties,thathavetheintendedpurposeofcooling |     |     |     |     |     |     | approach; |     |     |     |     |     |
| ---------------------------------------------- | --- | --- | --- | --- | --- | --- | --------- | --- | --- | --- | --- | --- |
local urban climate. All human-wrought changes to • employs a model that either yields a steady state
urbanlandscapes—synonymousherewiththe‘built’ solution, or has a prognostic temperature(s)—
series defined by Stewart and Oke (2012)—made purelystatisticalmodelsareexcluded;
•
withtheintentiontoreduceairtemperatureswithin simulates effects of urban cover or facet modific-
theurbancanopylayer(Oke1976)oratrooflevelare ation (including changes to tree cover) on urban
consideredtobeurbanheatmitigationimplementa- canopy or surface layer air temperature change—
tionsforthepurposesofthisreview.Theserequire- studies that exclusively report other temperatures
| ments help | define | the | relevant | conceptual |     | model | orindicesareexcluded; |     |     |     |     |     |
| ---------- | ------ | --- | -------- | ---------- | --- | ----- | --------------------- | --- | --- | --- | --- | --- |
andtherangeofoperationaltestsconsideredherein • uses experimental control—studies that do not
(Valiela 2001, Stewart 2011). In many cases, ‘urban include an appropriate ‘base case’ scenario are
| heatislandmitigation’studiesqualify,providedthat |       |         |             |     |          |     | excluded. |     |     |     |     |     |
| ------------------------------------------------ | ----- | ------- | ----------- | --- | -------- | --- | --------- | --- | --- | --- | --- | --- |
| absolute                                         | urban | cooling | is reported | in  | addition | to  |           |     |     |     |     |     |
relative cooling (e.g. reduction of urban heat island The resulting sample includes 146 articles,
intensity). However, we do not consider an urban employingmodelsthatvaryfromstreetscaletoglobal
heat island framing to be relevant for discussion of scale, from hourly to decadal time scales, and from
4

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
past to projected future climates. The articles are thatis,noothersourcesaresoughtandnocontactis
divided into two broad categories, namely micro- madewiththeauthor(s)atthisstage.Assuch,com-
neighbourhoodscale(hereafter‘microscale’)models pleteandeffectivescientificcommunicationisimpli-
andmeso-globalscalemodels(hereafter‘mesoscale’); citly included as a criterion in the grading scheme
theformertypicallyresolvebuildingsbutnotadvec- (Stewart2011).
tion between neighbourhoods or boundary-layer The supplementary methods provide additional
processes (domain size of 100–5000 m, with grid detail related to the definition of all criteria and
spacing 1–100 m), whereas the latter do not resolve sub-criteria, and table 2 provides an overview of
individual buildings but capture the full boundary- all criteria and sub-criteria and the associated point
layer and city and/or regional scale atmospheric allotments.Thereisnouniversallycorrectpointallot-
flows (domain size >100 km, with grid spacing ment, and this approach is motivated by a previ-
0.5–100km). The focus here on numerical model ouscriticalreviewoftheurbanheatislandobserva-
resultscomplementsreviewsofobservationalresults tionalliterature(Stewart2011).Sincethepointallot-
(e.g. Bowler et al 2010). Notably, while the critical ments are inherently subjective, the total scores for
and quantitative aspects of this review end in 2017, each criterion or set thereof represent value judg-
qualitativeresultsfromtheliteratureareincludedup mentsbytheauthors.Wechoosepointallocationsto
toandincluding2020(e.g.seesection5.3). reflect the relative importance of each sub-criterion
withregardstothecontextualizationandcomparab-
2.3.Criteriausedtoassessliterature ility(metadatacriteria1–4)andreliability(methodo-
Severalcriteriaaredevelopedtoevaluatethereliabil- logycriteria5–7)oftheheatmitigationcoolingmag-
ityandcomparabilityofurbanheatmitigationstud- nitudesreportedinthearticle.Sincebothreliability
ies in the sample. The following four criteria assess and contextualization of the results are essential for
metadatareporting,requiredforcontextualizationof meaningfulinterpretationofmodelledcoolingmag-
individualstudiesandeffectivecomparisonbetween nitudes, they are weighted equally. The total scores
studies. forthemethodologycriteria(criteria5–7),individu-
ally and collectively, are used to assess the suitabil-
(1) Sitemetadataareprovided. ityofindividualstudiesforinclusionintheinformal
(2) Forcingmeteorologyischaracterized. meta-analysis (see section 2.5). The total scores for
(3) Heat mitigation implementation metadata are metadatacriteria(criteria1–4)arenotexplicitlyused
provided. in this work, though associated point allotments in
(4) Air temperature is specified spatially and tem- table 2, which are based on considerable deliber-
porally. ation by the authors, are nevertheless provided as
additionalcontextandmaybeusefultotheresearch
Three subsequent criteria assess appropriateness community in future reviews. The combined scores
of the numerical model and its application, and provide an indication of overall quality of each
addressmethodologicalrigorandsubsequentreliab- study.
ilityofthemodellingresultsobtained. Inbrief,thesevencriteriaareasfollows:
(5) Model accurately represents relevant physical (1)Neighbourhoodmetadataareprovided
processes. (criterion1)
(6) Model evaluation is appropriately targeted and Theeffectivenessofheatmitigationimplementations
successful. is modulated by the land cover, morphology and
(7) Modelapplicationissound. materialsoftheneighbourhoodorareasurrounding
thesite.Hence,characterizationoftheurbanneigh-
These criteria (described below) are based on bourhoodprovidesimportantcontext.Forexample,
thecollectiveexperienceoftheauthors,whosetrain- implementation of high albedo roofs on tall vs.
ing includes building microclimate simulation and shortbuildingshasbeenfoundtostronglymodulate
atmospheric modelling at micro-to-global scales, pedestrian-levelcooling(Botham-Myintetal2015).
largelyinNorthAmericanandEuropeancontexts,as Suitablemetadataincludeurbanstructure,cover,and
well as development of numerical models of urban fabric (Oke 2006; supplementary table 1). Alternat-
atmospheres at micro-neighbourhood scales. Each ively,identificationofthelocalclimatezone(Stewart
criterion above is sub-divided into multiple sub- and Oke 2012) provides a confined range of these
criteria to assist scoring, and each study is assigned metadata.
a grade for each sub-criterion, which represents the
degree to which the study fulfils the sub-criterion (2)Forcingmeteorologyischaracterized
(table 2; supplementary methods). With the excep- (criterion2)
tionofsub-criteria5cand5d,gradingisbasedexclus- Meteorological conditions set the context for
ivelyoninformationprovidedineachpeer-reviewed the local climate sensitivity to a heat mitigation
article and associated supplementary information; implementation. Many heat mitigation strategies
5

| Environ.Res.Lett.16(2021)053007 |     |     |     | ESKrayenhoffetal |     |
| ------------------------------- | --- | --- | --- | ---------------- | --- |
Table2.Percentofarticlesreceivingapassinggradeforeachcriterionandsub-criterion,fornumericalmodellingstudiesofheat
mitigationimplementationeffectsonairtemperatureatboththemicroscaleandthemesoscale.Apassinggradeisdefinedasreceiptof
50%ormoreofpointsallottedtothe(sub)criterion.Shadingindicatesfailureofthe(sub-)criterion.
Criterion Sub-criterion Totalpointsallotted Microscale Mesoscale
Metadatareporting
| 1)Neighbourhooda |                           |     | 2   | 45% | 20% |
| ---------------- | ------------------------- | --- | --- | --- | --- |
|                  | 1a)Landcoverfractions     |     | 0.5 | 66% | 50% |
|                  | 1b)Urbanstructure         |     | 0.5 | 67% | 30% |
|                  | 1c)Thermalparameters      |     | 0.5 | 40% | 23% |
|                  | 1d)Radiativeparameters    |     | 0.5 | 59% | 58% |
| 2)Meteorology    |                           |     | 2   | 65% | 67% |
|                  | 2a)Originofmeteorological |     | 1   | 62% | 81% |
forcing
|                  | 2b)Characterizationofweather |     | 1   | 72% | 44%  |
| ---------------- | ---------------------------- | --- | --- | --- | ---- |
| 3)Heatmitigation |                              |     | 6   | 96% | 100% |
strategy
|               | 3a)Implementationtype       |     | 2   | 96% | 100% |
| ------------- | --------------------------- | --- | --- | --- | ---- |
|               | 3b)Planareaintensity        |     | 2   | 51% | 42%  |
|               | 3c)Locationofimplementation |     | 2   | 96% | 100% |
| 4)Temperature |                             |     | 8   | 90% | 91%  |
specification
|     | 4a)Horizontalspecification |     | 2   | 57% | 63% |
| --- | -------------------------- | --- | --- | --- | --- |
|     | 4b)Verticalspecification   |     | 2   | 83% | 73% |
|     | 4c)Diurnalspecification    |     | 3   | 93% | 97% |
|     | 4d)Temporalaveraging       |     | 1   | 99% | 30% |
Modellingmethodology
| 5)Modelphysics |                              |     | 6   | 76% | 86%  |
| -------------- | ---------------------------- | --- | --- | --- | ---- |
|                | 5a)Modelscaleappropriate     |     | 0.5 | 77% | 100% |
|                | 5b)Modelprocessesappropriate |     | 1.5 | 70% | 94%  |
|                | 5c)Completenessofmodel       |     | 2   | 85% | 55%  |
physics
|                   | 5d)Evaluationofmodelphysics    |     | 2   | 9%  | 20% |
| ----------------- | ------------------------------ | --- | --- | --- | --- |
| 6)Modelevaluation |                                |     | 6   | 48% | 58% |
|                   | 6a)Qualityofevaluationdata     |     | 1   | 49% | 56% |
|                   | 6b)Evaluation/mitigationscales |     | 1   | 60% | 61% |
match
|                    | 6c)Smallabsoluteerror   |     | 1   | 30% | 13% |
| ------------------ | ----------------------- | --- | --- | --- | --- |
|                    | 6d)Highcorrelation      |     | 1   | 26% | 5%  |
|                    | 6e)Subjectiveassessment |     | 2   | 39% | 69% |
| 7)Modelapplication |                         |     | 6   | 66% | 86% |
|                    | 7a)Boundaryconditions   |     | 2   | 49% | 84% |
|                    | 7b)Modelconfiguration   |     | 2   | 68% | 77% |
|                    | 7c)Initialconditions    |     | 2   | 43% | 64% |
| Total              |                         |     | 36  |     |     |
aFullmarksawardediflocalclimatezonereportedinlieuofsub-criteria.
function by reducing absorption of solar radiation Supplementary table 2 organizes heat mitigation
orredirectingabsorbedsolarradiationtoevapotran- implementationsbyscaleandprocess,anddetailsthe
spirationinsteadofsensibleheat;bothprocessesare metadata to report in each case. To enable compar-
influenced by ambient weather conditions—cloud ability between studies, it is essential to report the
cover, humidity and wind in particular. Choice of areaofsurfacemodifiedrelativetothetotalplanarea.
meteorological forcing to the model can modulate In a study of the cooling impacts of high reflectiv-
heatmitigationeffectivenessandshouldthereforebe ityroofs,forexample,theareaofroofsreceivingthe
characterized(i.e.descriptionofgeneralconditions, albedo treatment relative to the corresponding plan
anddetailsaboutthedatasource). area should be reported in addition to the actual
|     |     | roof albedo | increase | (see section 2.5.1). | Changes |
| --- | --- | ----------- | -------- | -------------------- | ------- |
(3)Heatmitigationimplementationmetadataare to pervious fraction or tree cover fraction should
provided(criterion3) be reported in similar fashion. It is furthermore
Characterization of the type, coverage, distribution, importanttoidentifythelocationorfacetwithinthe
and intensity of a surface modification provides urbanenvironmentthatismodified.Heatmitigation
vital context for interpretation of its local climate strategies such as irrigation incorporate a temporal
impactsandpermitscomparisonwithrelatedstudies. element,whichshouldbedescribedexplicitly.
6

| Environ.Res.Lett.16(2021)053007 |     |     |     |     |     |     |     |     |     |     | ESKrayenhoffetal |     |
| ------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- |
(4)Airtemperatureisspecifiedspatiallyand fairweatherwarmseasonconditions.However,their
temporally(criterion4) unintended consequences for other weather condi-
Airtemperatureisthefocusofthissystematicreview; tionsandseasonsdeserveattention(e.g.Krayenhoff
nevertheless, the ensuing discussion is largely relev- andVoogt2010,YangandBou-Zeid2018).Authors
ant to other climate response variables, such as sur- should be clear about the temporal context of their
| facetemperature. |     |     |     |     |     | results. |     |     |     |     |     |     |
| ---------------- | --- | --- | --- | --- | --- | -------- | --- | --- | --- | --- | --- | --- |
(4a)Horizontalspecification(sub-criterion4a)
(5)Modelrepresentsrelevantphysicalprocesses
Specificationoftheareaoverwhichairtemperature
(criterion5)
changesareassessedhelpscontextualizethereported
|     |     |     |     |     |     | A fit-for-purpose |     | numerical |     | model | represents | the |
| --- | --- | --- | --- | --- | --- | ----------------- | --- | --------- | --- | ----- | ---------- | --- |
impactofthesurfacemodification.Numericalmod-
|          |              |          |            |     |             | primary | physical         | processes |           | that | modulate | urban     |
| -------- | ------------ | -------- | ---------- | --- | ----------- | ------- | ---------------- | --------- | --------- | ---- | -------- | --------- |
| els that | are explicit | in three | dimensions |     | (e.g. ENVI- |         |                  |           |           |      |          |           |
|          |              |          |            |     |             | canopy  | air temperature, |           | including |      | key      | processes |
metandothercomputationalfluiddynamics(CFD)
|     |     |     |     |     |     | introduced | by  | the heat | mitigation |     | implementation |     |
| --- | --- | --- | --- | --- | --- | ---------- | --- | -------- | ---------- | --- | -------------- | --- |
models;seesupplementaryfigure1(a))permitprecise
|     |     |     |     |     |     | (figure 1). | Moreover, |     | such a | model | has been | eval- |
| --- | --- | --- | --- | --- | --- | ----------- | --------- | --- | ------ | ----- | -------- | ----- |
selectionofthehorizontalareaforassessmentofair
|     |     |     |     |     |     | uated at | the process | level | to  | ensure | that | perturba- |
| --- | --- | --- | --- | --- | --- | -------- | ----------- | ----- | --- | ------ | ---- | --------- |
temperatureimpactsduetoaheatmitigationimple-
|     |     |     |     |     |     | tions to | the system | introduced |     | by  | heat mitigation |     |
| --- | --- | --- | --- | --- | --- | -------- | ---------- | ---------- | --- | --- | --------------- | --- |
mentation.Theareaselectedmustbesufficientlycon-
|     |     |     |     |     |     | strategies | will | have realistic |     | impacts | on  | modelled |
| --- | --- | --- | --- | --- | --- | ---------- | ---- | -------------- | --- | ------- | --- | -------- |
strainedsoastofallwithinthezoneofinfluenceofthe
|                 |     |                 |     |           |        | energy exchanges |     | and | temperatures. |     | Representation |     |
| --------------- | --- | --------------- | --- | --------- | ------ | ---------------- | --- | --- | ------------- | --- | -------------- | --- |
| heat mitigation |     | implementation. |     | Mesoscale | numer- |                  |     |     |               |     |                |     |
offlowandturbulenttransportwithintheurbancan-
icalmodelsandone-dimensionalurbancanopymod-
opyandexchangewiththeboundary-layeraboveare
| els (e.g. | Erell and | Williamson |     | 2006, Krayenhoff | and |     |     |     |     |     |     |     |
| --------- | --------- | ---------- | --- | ---------------- | --- | --- | --- | --- | --- | --- | --- | --- |
particularlyimportantforairtemperature(figure1).
| Voogt 2010)  | include | implicit   |     | horizontal | averaging  |             |     |            |         |     |           |        |
| ------------ | ------- | ---------- | --- | ---------- | ---------- | ----------- | --- | ---------- | ------- | --- | --------- | ------ |
|              |         |            |     |            |            | Critically, | the | ability of | a model | to  | represent | exist- |
| at the local | scale.  | Therefore, |     | microscale | horizontal |             |     |            |         |     |           |        |
ingairtemperaturemaynotensurethatitiscapable
exchangesaffectingheatmitigationimplementation-
ofcapturingtemperatureimpactsofheatmitigation
| induced | impacts | are implicit |     | or ignored. | In these |                  |     |          |     |           |          |     |
| ------- | ------- | ------------ | --- | ----------- | -------- | ---------------- | --- | -------- | --- | --------- | -------- | --- |
|         |         |              |     |             |          | implementations. |     | Modelled |     | processes | expected | to  |
studies,itissufficienttoreportthegridsize,ifapplic-
respondtotheheatmitigationimplementation,such
able,andcritically,thesubsetofgridcellsassociated
|          |          |     |             |         |          | asenergy | partitioningat |     | urbansurfacesorradiative |     |     |     |
| -------- | -------- | --- | ----------- | ------- | -------- | -------- | -------------- | --- | ------------------------ | --- | --- | --- |
| with the | reported | air | temperature | change; | ideally, |          |                |     |                          |     |     |     |
interceptionbytrees(figure1),orrelatedimpactson
| both spatial | mean | and | variability | (e.g. | spatial max- |     |     |     |     |     |     |     |
| ------------ | ---- | --- | ----------- | ----- | ------------ | --- | --- | --- | --- | --- | --- | --- |
statevariablessuchassurfacetemperature,shouldbe
imum)ofimpactsarereported.
evaluatedorhavebeenevaluatedinapreviouspeer-
|     |     |     |     |     |     | reviewed | study, | e.g. in | the original |     | model | develop- |
| --- | --- | --- | --- | --- | --- | -------- | ------ | ------- | ------------ | --- | ----- | -------- |
(4b)Verticalspecification(sub-criterion4b)
|                   |     |        |     |          |               | ment study. | Authors | should |     | explicitly | defend | their |
| ----------------- | --- | ------ | --- | -------- | ------------- | ----------- | ------- | ------ | --- | ---------- | ------ | ----- |
| Many contemporary |     | models |     | of urban | areas vertic- |             |         |        |     |            |        |       |
choiceofmodelbyrelatingittotheirstudyobjective,
allyresolvethebetween-buildingcanopylayerasdis-
bothintermsofscaleandespeciallyintermsofthe
tinctfromtheabovebuildingboundary-layer.Some
degreetowhichitcanrepresentkeyprocessesrelated
modellingapproachesmayresolveseveralverticallay-
totheheatmitigationimplementationanditsimpact
ersbelowbuildingheight(supplementaryfigures1(a)
onairtemperature.Modellimitationsmustbestated
| and (b)). | To enhance |     | comparability |     | between stud- |     |     |     |     |     |     |     |
| --------- | ---------- | --- | ------------- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- |
andthestudyresultscontextualizedaccordingly.
| ies, the  | horizontal   | location | or     | area in  | sub-criterion   |     |     |     |     |     |     |     |
| --------- | ------------ | -------- | ------ | -------- | --------------- | --- | --- | --- | --- | --- | --- | --- |
| 4a should | be specified |          | in the | vertical | as a layer with |     |     |     |     |     |     |     |
specified height and thickness (e.g. the urban can- (6)Modelevaluationisappropriatelytargetedand
| opy layer), | or  | as a level | of specified | height | (e.g. air | successful(criterion6) |     |     |     |     |     |     |
| ----------- | --- | ---------- | ------------ | ------ | --------- | ---------------------- | --- | --- | --- | --- | --- | --- |
temperature at 2 m above ground level). Moreover, Model evaluation and calibration ensure that the
themodelmustbecapableofaccuratelyrepresenting model can represent the base case spatio-temporal
this level or layer, both in terms of the theory being meteorological variation. The magnitude and vari-
applied(criterion5)andevaluationofthemodel(cri- ationofsimulatedairtemperaturemustbeassessedat
| terion6). |     |     |     |     |     | aminimum.Anappropriatelytargetedmodelevalu- |     |     |     |     |     |     |
| --------- | --- | --- | --- | --- | --- | ------------------------------------------- | --- | --- | --- | --- | --- | --- |
ationisalsoconductedatspatialandtemporalscales
(4c&4d)Temporalspecification(sub-criteria4c andresolutionsthatcorrespondtothoseoftheinten-
| &4d) |     |     |     |     |     | dedmodelapplication.Modeloutputshouldbecom- |     |     |     |     |     |     |
| ---- | --- | --- | --- | --- | --- | ------------------------------------------- | --- | --- | --- | --- | --- | --- |
The cooling effectiveness of heat mitigation meas- paredtohighqualitymeasureddatawithinthemodel
uresvariesoverthediurnalcycleandwithseasonand domain, whose origin or metadata (where appro-
meteorological conditions. For example, most heat priate) are reported. A successful model evaluation
mitigation strategies provide far more daytime than demonstrates small model-observation differences,
nighttimecooling(Georgescu2015,Krayenhoffetal where mean absolute error is similar to, or smal-
2018). Therefore, it is critical that specific times or ler than, the maximum cooling magnitude attribut-
temporalrangescorrespondingtosimulatedairtem- able to the heat mitigation implementation. Stand-
peraturechangesarereported.Mostheatmitigation ard model evaluation procedures must be followed
studies will tend to uncover greater impacts during andarangeoferrorstatisticsreported(e.g.Willmott
7

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
1982, Moriasi, 2007), including a measure of abso- Assessment of the quality of a reported model
luteerror(e.g.meanabsoluteerror)andameasureof evaluation(criterion6)inherentlyrequiressubjective
correlation (e.g. coefficient of determination, R2, or judgment,sincemanyinterrelatedfactorsmustalign
Willmott’sd)ataminimum.Ultimately,thequality in order to achieve a convincing model evaluation.
of a model evaluation requires some degree of sub- Hence, we allot 1/3 of the model evaluation points
jectivejudgment. to a subjective assessment by the reviewer (cri-
terion 6e). Sub-criteria 5c and 5d entail assessment
(7)Modelapplicationissound(criterion7) of the completeness of each model’s representation
Properapplicationofnumericalmodelsoftheurban of heat mitigation-relevant physics and the degree
atmosphere requires attention to initial conditions, and/orqualityoftheirevaluationinallpreviouspeer-
the initial values of state variables, and to bound- reviewed articles, both of which require a level of
ary conditions, the time-dependent values of vari- subjectivejudgment.Torendertheselattertwosub-
ables at domain boundaries. Model spin up, that criteriaasobjectiveaspossible,theyareevaluatedby
is, model simulation prior to the period of interest, answeringthefollowingtwoquestions:
shouldbeatleastonefulliterationofthedominant
thermal forcing cycle of the system (i.e. one diurnal • 5c:Howfullyarethephysicsoftheprocessrepres-
cycle in most cases) to adjust subsurface temperat- ented?
ure profiles. At the microscale one diurnal cycle is • 5d: Has the model representation of the physical
typically a minimum. Steady-state microscale mod- processbeensuccessfullyevaluated(ordoesithave
els are an exception, and they should apply appro- astrongandvalidhistoryintheliterature)?
priateconvergencecriteria.Atmesoscales,withrep-
resentationofthecompletesurfaceandatmospheric Notethatevaluationofmodelrepresentationsis
hydrologiccycle(e.g.theWeatherResearchandFore- typically conducted in the relevant model develop-
casting,orWRF,model;Skamarocketal2005),sev- mentarticle,andforeachmodelinthesamplethese
eraldaysorweeksaretypicallyrequiredtoallowsoil originalarticlesandanyadditionalarticlesundertak-
moisture to adjust to ambient conditions, depend- ing process-level model evaluation (including those
ingonclimate,geographyandseason.Modeldomain thataddheatmitigationassessmentcapabilities)are
size must also be sufficient in both mesoscale and locatedandassessed.Forallheatmitigationstrategies
microscale simulations to allow full development of questions5cand5dareeachansweredwithrespectto
the atmosphere upstream of the zone of heat mit- twoconstellationsofphysicalprocessesthatarecrit-
igation implementation. In other words, the zone ical for determination of effects of heat mitigation
of heat mitigation impact (sub-criterion 4a) must strategies(e.g.Cranketal2018):
be outside of the zone of direct influence of the
boundary conditions. Ideally, models of urban can- • energy balance partitioning at the ‘surface’ of the
opy layer climate are coupled to a boundary-layer heatmitigationstrategy;and
oratmosphericmodel,becauselargechangestosur- • turbulent transport within the urban surface and
facepropertiestriggeratmosphericfeedbacks,whose canopy layers (which transports heat between the
impacts on air temperature cooling magnitudes can locationoftheheatmitigationimplementationand
besubstantial(KrayenhoffandVoogt2010).Finally, thelocationwhereairtemperaturecoolingisrepor-
numerical models of urban climate and meteoro- ted,e.g.2m).
logy require numerous choices that serve to config-
urethemodel(physicsandparameterchoices,model In the case of street trees, treatment of their
optionsandsettings).Theseshouldbereportedand impacts on shortwave and longwave radiation
justified. exchangeareadditionallyevaluated.
2.4.Criticalreviewmethodology 2.5.Informalmeta-analysismethodology
Eachofthe146articlesintheoverallsampledefined Subsequenttothecriticalreview,aninformalmeta-
in section 2.2 is evaluated against the 25 sub- analysisisundertakenbasedonthosestudiesfromthe
criteria,groupedintothesevencriteria,presentedin initialsamplethatexceedaminimumstandardwith
section 2.3, table 2, and the supplementary meth- respect to the methodological criteria. Studies were
ods. Metadata sub-criteria contain less subjectivity, assessed in terms of whether they exceed a score of
andformanyarticlesitisclearwhethereachitemof 50%onthefollowingsixconditions:
metadata is reported or not. The methodology sub-
criteriacontainsomedegreeofsubjectivity,because (a) theoverallmethodology(sumofcriteria5,6
theyevaluatetherigourorscientificappropriateness and7);
ofthemodellingmethodologyratherthanthepres- (b) criterion5(modelphysics);
enceorabsenceofareportedpieceofmetadata.We (c) criterion6(modelevaluation/calibration);
designourreviewmethodologyaccordingly(seesup- (d) criterion7(modelapplication);
plementarymethods). (e) criterion5c(completenessofmodelphysics);
8

| Environ.Res.Lett.16(2021)053007 |     |     |     |     |     |     |     |     |     |     | ESKrayenhoffetal |     |     |
| ------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- | --- |
(f) criterion 6e (subjective assessment of model they may occur with different intensities of albedo
| evaluation/calibration). |     |     |     |     |     |     | increase. |     |        |         |               |     |     |
| ------------------------ | --- | --- | --- | --- | --- | --- | --------- | --- | ------ | ------- | ------------- | --- | --- |
|                          |     |     |     |     |     |     | Second,   | to  | assess | cooling | effectiveness |     | of  |
Moreover, plan area fraction of the heat mitiga- vegetationstrategies,wedefineaVegetationCooling
tion implementation was required for each study to Effectiveness (VCE) which retains the area fraction
qualify; authors of studies that did not report this ofimplementationinthedenominatorbutomitsthe
| valuewerecontacted,andinmanycasestheinform- |     |     |     |     |     |     | ‘intensity’ofapplication: |     |     |     |     |     |     |
| ------------------------------------------- | --- | --- | --- | --- | --- | --- | ------------------------- | --- | --- | --- | --- | --- | --- |
ationwasprovidedandthestudywasincluded.The
∆T
final meta-analysis sample is comprised of 47 stud- VCE=− , (3)
λ
| ies that | met four | or      | more of | the above | conditions,   |     |         |          |       |         | s    |               |     |
| -------- | -------- | ------- | ------- | --------- | ------------- | --- | ------- | -------- | ----- | ------- | ---- | ------------- | --- |
| and for  | which    | we were | able    | to link   | air temperat- |     |         |          |       |         |      |               |     |
|          |          |         |         |           |               |     | where λ | s is the | added | surface | area | of vegetation |     |
urecoolingmagnitudetotheassociatedplanareaof dividedbytheassociatedplanarea.Notethatamore
implementation.
|     |     |     |     |     |     |     | sophisticated | version       | of  | equation    | (3)  | could include |      |
| --- | --- | --- | --- | --- | --- | --- | ------------- | ------------- | --- | ----------- | ---- | ------------- | ---- |
|     |     |     |     |     |     |     | a measure     | of vegetation |     | ‘intensity’ | such | as leaf       | area |
2.5.1.Coolingeffectiveness index (LAI), corresponding to the ∆α s in the ACE
The informal meta-analysis is designed to assess metric; however, so few of the studies in our liter-
the cooling effectiveness (or efficacy) of individual ature sample reported this value that we opt for a
heat mitigation strategies. Assessment of cooling simplified definition here. Moreover, air temperat-
effectiveness in place of absolute cooling removes a ure is less likely to respond linearly to increases of
primarydegreeoffreedomthatdiffersbetweenstud- LAI than it is to increases of albedo, because added
ies,andhelpsprogresstowardanobjectivestatedin leaf area is more likely to be shaded by existing leaf
section1—constraintofthemagnitudeofheatmitig- areaand different vegetationcovers providevarying
ationstrategyimpacts—byenhancingcomparability evapotranspirationcoolingdependingonspeciesand
ofstudies.Coolingeffectiveness(CE)isdefinedhere environmental context (e.g. Snir et al 2016). Tran-
| as: |     |     |     |     |     |     | spirativecoolingfromvegetationfurtherdependson |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ---------------------------------------------- | --- | --- | --- | --- | --- | --- |
accesstosoilmoisture,whichcanbehighlyspatially
∆T
CE=−
|     |     |     |     | ,   |     | (1) | andtemporallyvariable.Forirrigation,ametricsim- |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ----------------------------------------------- | --- | --- | --- | --- | --- | --- |
∆a
|     |     |     |     |     |     |     | ilar to VCE | could | be used, | or  | for certain | purposes |     |
| --- | --- | --- | --- | --- | --- | --- | ----------- | ----- | -------- | --- | ----------- | -------- | --- |
where T is air temperature, and a is a plan area- inclusionofwaterquantity and/orirrigationtiming
insuchametricmayalsobeuseful(e.g.Danieletal
| averaged | non-dimensional |     | variable |     | that quantifies |     |     |     |     |     |     |     |     |
| -------- | --------------- | --- | -------- | --- | --------------- | --- | --- | --- | --- | --- | --- | --- | --- |
the principal change associated with the heat mit- 2018,Broadbentetal2018b).
|         |                 |     |       |     |             |     | In equations |     | (1–3), | ∆T should | be  | defined | for a |
| ------- | --------------- | --- | ----- | --- | ----------- | --- | ------------ | --- | ------ | --------- | --- | ------- | ----- |
| igation | implementation. |     | Here, | we  | distinguish | two |              |     |        |           |     |         |       |
coolingefficacies.First,toassesscoolingeffectiveness particular layer or level, ideally at the 2 m level or a
|     |     |     |     |     |     |     | vertically-integrated |     | urban | canopy | layer | value | (sub- |
| --- | --- | --- | --- | --- | --- | --- | --------------------- | --- | ----- | ------ | ----- | ----- | ----- |
ofalbedoimplementations,wefollowthedefinition
usedbyKrayenhoffandVoogt(2010),whichweterm criterion 4b, section 2.3). Furthermore, implicit in
theseequationsisanassumptionthatairtemperature
theAlbedoCoolingEffectiveness(ACE):
respondslinearlytothearealfractionofsurfacemod-
|          |       |                   | ∆T  | ∆T     |      |       | ified, which                                   | is     | appropriate     | as  | an initial | assumption |        |
| -------- | ----- | ----------------- | --- | ------ | ---- | ----- | ---------------------------------------------- | ------ | --------------- | --- | ---------- | ---------- | ------ |
|          | ACE=− |                   | =−  |        |      |       |                                                |        |                 |     |            |            |        |
|          |       |                   |     |        | ,    | (2)   |                                                |        |                 |     |            |            |        |
|          |       |                   | ∆α  | ∆α     | ·λ   |       | andfurthermoreappearstobeapproximatelyaccur-   |        |                 |     |            |            |        |
|          |       |                   | N   | s      | s    |       |                                                |        |                 |     |            |            |        |
|          |       |                   |     |        |      |       | ate for roof                                   | albedo | implementations |     | (Li        | et al      | 2014). |
| where ∆α | is    | the neighbourhood |     | scale, | plan | area- |                                                |        |                 |     |            |            |        |
|          | N     |                   |     |        |      |       | Notethatforcoolingeffectivenesstobemeaningful, |        |                 |     |            |            |        |
averagedchangeinalbedoresultingfromtheimple- itisimportantthathorizontalscalesofheatmitiga-
| mentation | of high | reflectivity |     | building | coatings | or  |                      |     |     |     |             |          |     |
| --------- | ------- | ------------ | --- | -------- | -------- | --- | -------------------- | --- | --- | --- | ----------- | -------- | --- |
|           |         |              |     |          |          |     | tion implementations |     | and | air | temperature | response |     |
pavement,∆α isthechangeinalbedoofthemod- areappropriatelyrelated(e.g.sub-criterion4a).
s
| ified surface, | and | λ   | is the area | of  | modified | sur- |     |     |     |     |     |     |     |
| -------------- | --- | --- | ----------- | --- | -------- | ---- | --- | --- | --- | --- | --- | --- | --- |
s
facedividedbythecorrespondingoverallhorizontal 3.Criticalreviewofurbanheatmitigation
| plan area.  | The     | ACE      | value in | degrees | Celsius       | rep- | literature |     |     |     |     |     |     |
| ----------- | ------- | -------- | -------- | ------- | ------------- | ---- | ---------- | --- | --- | --- | --- | --- | --- |
| resents the | cooling | obtained | from     | a       | neighbourhood |      |            |     |     |     |     |     |     |
albedo increase from 0.0 to 1.0, assuming linear 3.1.Overviewoftheliteraturesample
temperature responses to albedo changes. Similarly, The vast majority of the 146 articles in the lit-
10% of the ACE value is the cooling obtained for erature sample were published after 2006, in the
a neighbourhood-wide albedo increase of 0.10. A final decade of the 30 year sample (figure 2). The
recent application of the ACE metric has been used trend is toward greater numbers of articles pub-
to distinguish those neighbourhood densities and lishedperyearatboththemicroscaleandmesoscale,
regional climates that enhance effectiveness of roof probably influenced by the increasing rate of art-
albedoimplementations(Broadbentetal 2020a).In iclepublicationin academia.Inaddition,the recent
effect,theACEmetricaccountsforthefactthaturban surge of urban heat mitigation simulations prob-
albedo applications may occur not only across dif- ably also relates to developments of key modelling
ferent portions of the urban surface, but also that toolsaroundtheturnofthemillennium.ENVI-met
9

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
Figure2.Numberofarticlespublishedbyyearintheliteraturesampleateachoftwomodellingscales.
(BruseandFleer1998)andWRF-urban(Chenetal cooling as a result of rooftop albedo or vegetation
2011; in particular when applied with the single- (greenroof)applications(Skelhornetal2014,Mid-
layer urban canopy model of Kusaka et al 2001, del et al 2015, Wang et al 2016); WRF-SLUCM,
i.e. WRF-SLUCM) are the most commonly-applied conversely, yields strong ‘2 m’ cooling as a function
models within the sample (figure 3). The devel- of rooftop implementations (Georgescu et al 2014,
opment of ENVI-met was first published in 1998, Georgescu 2015, Vahmani et al 2016), but surpris-
and the first widely-adopted urban canopy models inglymoderatecoolingatthisatmosphericlevelfrom
were documented shortly thereafter (Masson 2000, groundlevelstrategies(e.g.groundalbedo;Yangetal
Kusaka et al 2001, Martilli et al 2002). Moreover, 2016). Model physics formulations appear to play
the first version of WRF-SLUCM was released in a strong role in both cases (see section 5.1.3 for
late 2006, while ENVI-met version 3.1 was released discussion).
in 2004. The widespread application of both mod- Irrigation, permeable surface, and water bodies
elsaccountsforclosetohalfoftheliteraturesample received comparatively less attention in the literat-
(27% of articles use ENVI-met 3.1, and 15% use ure sample, and photovoltaic panels have received
WRF-SLUCM). virtually no physically-based treatment (figure 4).
Clear differentiation by model scale is apparent Most‘photovoltaic’treatmentsinthesamplesimply
in terms of the types of heat mitigation strategies entailedchangestorooftoporbulkalbedos,andthey
assessed in the sample (figure 4). Mesoscale mod- wererecordedassuchinfigure4.
els have tended to evaluate albedo strategies and
rooftop-basedstrategies,whereasmicroscalemodels 3.2.Criticalassessmentofurbanheatmitigation
havefocusedpreferentiallyonground-basedapplic- modellingstudies
ations,especiallyvegetationandtrees.Modelphysics Modelling studies in the sample demonstrate vari-
playsa strongrole in this divide. Forexample, until able performance with respect to the four metadata
very recently, street trees have not been integrated reportingandthreemodellingmethodologycriteria
into mesoscale implementations of urban canopy (table 2; figure 5). Articles at both scales typically
models, but their impacts on above-canopy climate report sufficient detail related to both heat mitiga-
have instead been included using the tile approach tiontypeandlocation(sub-criteria3a,c)andthetim-
(Krayenhoff et al 2020). This explains the dearth of ingandverticallevelofthereportedairtemperature
assessment of street trees at this scale, except via (sub-criteria4b,c),butfewerreportplanareaintens-
the bulk or tile approach, which cannot represent ityofheatmitigationimplementations(sub-criterion
effectsoftreesshadingimpervioussurfaces,andother 3b) or clearly specify the horizontal domain of the
important physical processes related to urban trees urban atmosphere that corresponds to the reported
(Krayenhoffetal2014,2015).Conversely,streettree temperaturechanges(sub-criterion4a;table2).Least
processes that impact the urban canopy layer, such wellreportedaresiteorneighbourhoodcharacterist-
as shading and drag, have been included with some ics, such as the local climate zone and/or informa-
degreeoffidelityinENVI-metandafewothermicro- tionrelatingtolandcover,builtstructure,orthermal
scalemodelsforseveralyears. orradiativecharacteristics(criterion1),particularly
We suspect that a bias exists within the research in the case of mesoscale models (e.g. data used in
community toward publishing results that include theurbaninputparameterfile).Meteorologicalfor-
larger cooling magnitudes, related to the particular cing(criterion2)isreasonablywelldescribedinthe
modelandmitigationstrategycombinationsthatare sample, except that mesoscale simulations do not
most common (figure 4). For example, ENVI-met typically describe the prevailing weather conditions
typicallyyieldsverysmallstreetlevelairtemperature duringtheirsimulations(sub-criterion2b).
10

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
Figure3.Numberofarticlesintheliteraturesamplebymodelscaleandtype.UCM=UrbanCanopymodel(uncoupled/offline);
CFD=computationalfluiddynamics;Noah=NCEP,OregonState,Airforceweatheragency,NOAAOfficeofhydrologyland
surfacemodel;SLUCM=Single-LayerUrbanCanopymodel(basedonKusakaetal2001);BEP=BuildingEffect
Parameterization(Martillietal2002);MM5=fifth-generationPennState/NCARmesoscalemodel;GCM=GlobalClimate
Model.
Figure4.Numberofarticlesthatassesscoolingresultingfromselectheatmitigationstrategies.Manyarticlesassessmorethan
oneheatmitigationstrategy,eitherappliedintandemorinseparatesimulations;hence,asinglearticlemaycontributetothetotal
articlesindicatedformorethanoneheatmitigationstrategy.‘Bulkurbanvegetation’and‘bulkurbanalbedo’arebulkapproaches
tourbanvegetationandalbedoenhancementateitherthesubgrid(tile)orgridscaleinmesoscalemodels.
At first glance, studies at both scales perform physical processes, most of which have been insuf-
moderately well with regard to model physics and ficiently evaluated in the peer-reviewed literature
model application, and more poorly in terms of (likely related to the proprietary nature of this soft-
their model evaluation or calibration procedures ware and unavailability of its source code). Few
(figure 5). Of particular note is the small number mesoscale models are as complete in their physical
of studies using a model with substantive evalu- representation of processes, partly because of the
ation of the physical processes related to the imple- computational requirements at this scale, but they
mented heat mitigation strategy (sub-criterion 5d; are somewhat better evaluated at the process level.
table2).Thelargediscrepancybetweencompleteness WRF-SLUCM generally fares better on sub-criteria
and evaluation of model physics (sub-criterion 5c 5c and 5d, but receives a lower score for physical
vs.5d)atthemicroscalederivesfromtheENVI-met representation of urban canopy turbulent transport
model, which includes an impressive breadth of (seesection5.1.3).
11

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
Figure5.Percentageofstudiesinthesampleateachoftwomodelscalesthatscoreabove50%oneachofthesevencriteria.
Boundarybetweenlighteranddarkerbarcolourforcriteria6and7representstheaveragescoreofsecondaryreviewersforthose
criteria(whichwaslowerineachcasecomparedwiththeprimaryreviewers;seesupplementarymethods).
Less encouraging is the performance of many 4.Coolingeffectivenessofheatmitigation
model evaluations in the sample (criterion 6), with strategies
very few achieving small errors relative to observa-
tionaldata.Justoverhalfofthesample,onaverage, The fractional area of heat mitigation implement-
used good quality observation data in their evalu- ation as well as the intensity of application at the
ation, and evaluated their model at the same scale neighbourhoodscalestronglycontrolthemagnitude
astheyapplieditintheirheatmitigationassessment of local cooling (see section 2.5.1). To remove this
(sub-criteria 6a,b; table 2). Moreover, model evalu- primary degree of freedom, normalized ‘cooling
ation was frequently unconvincing, especially at the effectiveness’ metrics ACE and VCE introduced in
microscaleandwithENVI-metstudiesinparticular section 2.5.1 are applied within an informal meta-
(sub-criterion 6e). Model application (criterion 7), analysis. Cooling is then more readily compared
includingboundaryandinitialconditionsandappro- betweenstudies,andageneralizedunderstandingof
priate model configuration, was conducted reason- the effectiveness of select heat mitigation strategies
ably well at the mesoscale. At the microscale, many maybeapproached.Approximateaprioriassessment
studies (in particular ENVI-met studies) failed to of cooling from potential heat mitigation strategies
includeabufferofsufficientsizebetweenthemodel mayultimatelybepossibleforurbancontextswithout
domainboundariesandthelocationofinterestforair recourse to labour- and computationally-intensive
temperature mitigation (sub-criterion 7a). Overall, simulations.
the mesoscale sample of articles passed more meth- Themeta-analysisconductedhereisinformalfor
odology criteria, whereas more microscale articles several reasons. First, we do not use effect size vari-
fared better in terms of the metadata reporting cri- ance (i.e. cooling effectiveness variance) to weight
teria(table2). the effect size reported by each study, as Bowler
Finally, individual heat mitigation modelling etal(2010)didforobservationalstudies,duetothe
studies that are worth emulating in terms of their substantialvariabilityinmethodologyandreporting
metadata reporting and/or modelling methodology betweennumericalmodellingstudies.Moreover,we
are selected based on their performance against the donotconductformalassessmentsofeffectsizehet-
seven criteria (see supplementary methods, supple- erogeneity.Second,severalknowndegreesoffreedom
mentaryresultsand supplementarytable3). All but are not fully controlled for: latitude, local geo-
oneofthepapersincludedinsupplementarytable3 graphy, mesoscale/synoptic variability, neighbour-
fall within the final 4 years of the literature sample, hood design and construction, and the height of
suggesting that both metadata reporting and mod- reportedairtemperature.Inthesubsequentanalysis,
elling methodology may have improved over the reported results are grouped by season and time of
sampleperiod. day to approximately control for these factors. The
12

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
remaining variation of reported cooling effective- equation (2). Two microscale studies increased the
ness from each individual study stems from uncer- albedo of all surfaces, while several mesoscale stud-
tainty in modelling or reporting of results and/or iesincreasedthealbedoofabulk(i.e.flat)represent-
fromsamplingacrossthoseremainingdegreesoffree- ationoftheurbansurface;medianACEacrossallof
dom(e.g.differentcitiesorneighbourhoods).Where thesestudiesis6.0◦Cforsummerafternooncondi-
appropriate,amediancoolingeffectivenessiscalcu- tions(figure6(b)),whichisvirtuallyidenticaltoACE
lated for each study, and a median of all studies is values from mesoscale roof albedo studies, perhaps
assessed for select temporal contexts (e.g. summer because similar model physics are involved in both
afternoons). cases.
4.1.AlbedoCoolingEffectiveness(ACE) 4.2.VegetationCoolingEffectiveness(VCE)
Roof albedo implementations are one of the most Trees affect pedestrian-level urban climate via mul-
common heat mitigation strategies investigated in tiple physical processes (Oke 1989, Krayenhoff et al
our sample, likely due to their ease of model- 2020), including shading, sheltering and evapotran-
ling implementation. Moreover, they already have spiration.Mostoftheseprocessesarerepresented,in
a degree of uptake in many jurisdictions. During somefashion,inthestudiesincludedinoursample.
summer afternoons, ACE ranges widely across the WeassesstheVCEdefinedinsection2.5.1acrossmul-
studies in our sample (figure 6(a)). Notably, ENVI- tiplestudiesthatincorporatetreesasurbanheatmit-
met 3.1 studies have a median ACE of 1.6 ◦C, or igationtools;notethatVCEcannotbedirectlycom-
0.16◦Ccoolingper0.10neighbourhood-scalealbedo paredtoACEvaluesinsection4.1(seesection2.5.1).
increase, whereas mesoscale studies have a median Most of these studies were performed at the micro-
ACE of 5.8 ◦C; moreover, the highest ACE of all scale,particularlybyENVI-met3.1,andtheyyielda
ENVI-met studies in our sample is lower than the mediansummerafternoonVCEof3.3◦C,or0.33◦C
lowestmedianACEofanymesoscalestudy.Thislarge ofcoolingper0.10increaseintreecanopycover(areal
discrepancyclearlysuggeststhatdifferencesinmodel fraction), although select studies find substantially
physicsand/orscalestronglyaffectmodelledcooling highervalues(figure7(a)).Thesolemesoscalestudy
magnitudes(seesection5.1.3fordiscussion).Meso- by Loughner et al (2012) finds a similar VCE mag-
scale studies in our sample have a median ACE of nitude, as does a recent CFD study (Toparlar et al
2.2 ◦C for summer nights, suggesting residual noc- 2018).Nighttimecoolingbytreesacrossthreemod-
turnalcoolingislessthanhalfofdaytimecoolingfor ellingstudiesisapproximately50%ofrespectiveday-
roofalbedoimplementations(figure6(a)).Asexpec- time cooling for each study (figure 7(a)); however,
ted, ACE derived from seasonal average or winter- nighttime results in ENVI-met 3.1 must be inter-
time results is smaller than episodic summer ACE, preted within the context of its very simple repres-
as a result of reduction of solar radiation reaching entationofurbanheatstorage(Huttner2012).Some
rooftopsduetocloudsandlargersolarzenithangles. observational studies report small nighttime cool-
Finally,urbanheatmitigationapplicationsarearea- ingfromstreettrees(e.g.Ziteretal2019),inagree-
limited by definition, and hence advection always ment with these simulation results, whereas others
servestoreducetheirlocalimpact.Thedifferencein findsmallnighttimewarming(e.g.Gillneretal2015),
ACE between a no-advection case and an advection orbothcoolingandwarmingdependingontimeof
case(whichresemblesthemedianacrossallmesoscale night(Couttsetal2016).
studies) reported by Krayenhoff and Voogt (2010) Vegetation more broadly is typically considered
suggeststhatfairweatheradvectionreducesthelocal to be an urban heat mitigation strategy, including
impact on air temperature of roof albedo by more greenroofsandground-levelvegetationsuchasgrass.
thanhalf(figure6(a),toprow). Moststudiesconsideringwithin-canyongrassinthe
High albedo surfaces or coatings may also be samplewereperformedbyENVI-met3.1.Microscale
applied at ground level, for example as ‘cool pave- model-derived VCE for grass varies widely between
ment’. Microscale models in our sample, primar- studies with VCE from about 1 ◦C to above 10 ◦C
ily ENVI-met 3.1, derive an ACE of approximately (figure7(b)).Theonlymesoscalestudythatincludes
5.7 ◦C for ground level albedo applications dur- within-canyon grass has a VCE of 3.3 ◦C–8.4 ◦C,
ing summer afternoons, albeit with large variation dependingonsoilmoisture.Evapotranspirationand
between studies (figure 6(b)). The only mesoscale associated thermal climate impacts of grass depend
studyofhigh albedopavementinour sampleyields strongly on moisture levels of upper soil layers, and
an ACE less than half as large. Again, model phys- thefactthatwedonotcontrolforthisdegreeoffree-
ics and/or scale likely play a role in this difference dommayexplainthelargevariationinVCEbetween
(seesection5.1.3).Increasesofbuildingwallalbedo thesestudies.
in conjunction with roof albedo add little cooling Coolingfromgreenroofsappearstodemonstrate
comparedtoroofalbedoalone,atbothmodelscales, a similar dependence on model scale and/or phys-
albeitforonlytwostudies(figure6(b);notethatACE ics as high albedo roofs. That is, summer afternoon
is calculated here without considering wall area in green roof VCE from available mesoscale studies
13

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
Figure6.Albedocoolingeffectiveness(ACE)fromroof(a)andother(b)albedoimplementationsfortwomodelscalesand
acrossseveralseasonsandapproximatetimesofday.Solidhorizontallinescorrespondingtoeachstudyindicatemaximumand
minimumreportedACEwithinastudy,andsymbolsindicatemedianACE(whereappropriate).Vertical,orangedashedlines
indicatemedianACEforsummerafternoonENVI-met3.1(roofalbedo)orallmicroscalemodel(roadalbedo)studyresults.
Mesoscalemodelsummerafternoonresultsareingreen,summernighttimemesoscaleresultsinblue,andcombinedmicro/
mesoscalesummerafternoonbulkalbedoresultsinblack.HighestvaluesreportedbyKrayenhoffandVoogt(2010)ineach
categoryarefora‘noadvection’case,andrepresentanestimateofmaximumpotentialACE(opencircles).Articlesindicatedbya
‘∗’metallsixconditionsoutlinedinsection2.5.The‘bulkalbedo’sectioncombinesbulktreatmentsoftheurbansurface
(mesoscale)anduniformtreatmentacrossallfacets(microscale).
is 1◦C–3◦C, several times higher than the VCE area application compared with trees and ground-
of ≈0.5 ◦C from microscale ENVI-met 3.1 stud- levelvegetation.
ies (figure 7(b)). Alternatively, different soil mois- Georgescu (2015) models evaporative (i.e. irrig-
ture and/or irrigation assumptions between studies ated) roofs, which represent an upper bound of
may play a role (Li et al 2014), particularly given evapotranspirative cooling achievable from green
the limited number of studies. In practice, green roofs, finding a summertime average VCE of about
roofsaretypicallydesignedtoreceiveminimalirrig- 5◦C.Whilefewstudiesofurbanirrigationorwater
ation beyond an initial plant rooting phase. One bodiesremaininthefinalmeta-analysissample,the
mesoscale study suggests that green roof cooling is two available studies (both at the mesoscale) yield
much reduced at night compared to daytime (Sun VCEofabout3◦Cforsummerafternoons,similarto
et al 2016); other evidence suggests that green roofs thevegetationimplementationsdiscussedpreviously.
mayactuallycausenocturnalwarming(Scherbaetal Notethattheamountandtimingofirrigationorthe
2011).Overall,availablehigh-qualitystudiessuggest temperatureofthewaterbodiesarenotcontrolledfor
that green roofs yield less canopy level cooling per duetoinsufficientsamplesize.
14

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
Figure7.Vegetationcoolingeffectiveness(VCE)fromstreettree(a)andother(b)vegetationimplementationsfortwomodel
scalesandacrossseveralseasonsandapproximatetimesofday.Symbolsareasinfigure6.Vertical,orangedashedlinesin
(a)indicatemedianACEforsummerafternoonmicroscalestudyresults.
Mostrecentmesoscalemodellingofurbanveget- Cui and De Foy 2012; Schubert and Grossman-
ation has used the tile approach, where surface- Clarke 2013, Li and Norford 2016), whereas the
atmosphere energy fluxes from impervious surfaces single study that integrates low vegetation within
and from soil-vegetation are computed by inde- an urban canopy model cools daytime air temper-
pendent models and then combined to assess a ature more than twice as much as nighttime air
near-surface (but effectively above-canopy) temper- temperature (figure 7(b); Lee et al 2016a). Recent
ature. While this approach is clearly inadequate for WRF-SLUCM tile-based modelling also shows pre-
assessmentofstreettreesbecauseitdoesnotrepres- dominantly nighttime cooling from urban vegeta-
ent processes such as tree shading and sheltering of tion(Jacobsetal 2018,Imranetal 2019),andthere
building and roads (Krayenhoff et al 2020), it may is some recent observational support for this res-
have more merit for low vegetation such as grass. ult (Hu and Li 2020). Nevertheless, it is unclear if
However, the sub-grid tile approach to vegetation this result is robust or if the tile approach needs to
appears to generate more nighttime compared to berevisitedforrepresentationofground-levelurban
daytime cooling in mesoscale models (figure 7(b); vegetation.
15

| Environ.Res.Lett.16(2021)053007 |     |     |     |     |              |         |                 |     | ESKrayenhoffetal |          |
| ------------------------------- | --- | --- | --- | --- | ------------ | ------- | --------------- | --- | ---------------- | -------- |
| 5.Discussion                    |     |     |     |     | (a) Evaluate | model   | representations |     | of               | physical |
|                                 |     |     |     |     | processes    | related | to both         | the | heat mitigation  |          |
5.1.Keyrecommendations implementationandtheurbancanopylayertur-
Severalrecommendationsarisefromthecriticalpor- bulenttransportthatgovernstheairtemperat-
tion of this review, particularly related to enhance- ureresponse(e.g.benchmarkmodelledvertical
ment of the reliability and comparability (con- turbulent exchange of heat in urban canopies,
textualization) of cooling magnitudes reported by compare measured and modelled street-level
heat mitigation studies. The large disagreements shadingbytreesasafunctionofleafarea,com-
in cooling effectiveness between model scales for pare soil moisture dynamics of modelled green
multiple heat mitigation strategies evident in the roofstoobservations).
informal meta-analysis (section 4) further reinforce (b) Conductanevaluationorcalibrationofthebase
the need for more reliable model representations casemodelusinghighqualitymeasureddata,for
of the physical processes that link heat mitiga- example, from networks of good quality, calib-
tion implementations to simulated air temperature rated,andappropriately-sitedinstruments(e.g.
| reductions. |     |     |     |     | WillmottandMatsuura1995,Rotachetal2005, |                   |     |       |           |         |
| ----------- | --- | --- | --- | --- | --------------------------------------- | ----------------- | --- | ----- | --------- | ------- |
|             |     |     |     |     | Oke                                     | 2006) distributed |     | among | the local | climate |
zonesorlocationswhereheatmitigationwillbe
5.1.1.Metadatareportingandstudycomparability
assessed.
| Sufficient    | context must be | provided | both   | to assess  |           |           |          |            |      |      |
| ------------- | --------------- | -------- | ------ | ---------- | --------- | --------- | -------- | ---------- | ---- | ---- |
|               |                 |          |        |            | (c) Match | the scale | of model | evaluation | data | with |
| the simulated | effectiveness   | of       | a heat | mitigation |           |           |          |            |      |      |
thescaleofheatmitigationcoolingassessment;
implementationandtocomparecoolingeffectiveness
|     |     |     |     |     | for | example, | through | evaluation | of  | building- |
| --- | --- | --- | --- | --- | --- | -------- | ------- | ---------- | --- | --------- |
betweenstudies.Oursampleindicatesthat,onaver-
|                |           |           |             |     | resolving | models              | with | measurements |             | that cap- |
| -------------- | --------- | --------- | ----------- | --- | --------- | ------------------- | ---- | ------------ | ----------- | --------- |
| age, mesoscale | modellers | have more | opportunity | to  |           |                     |      |              |             |           |
|                |           |           |             |     | ture      | micrometeorological |      | effects      | (microscale |           |
improvemetadatareportingthanmicroscalemodel-
|     |     |     |     |     | models), | and | with measurements |     | that | capture |
| --- | --- | --- | --- | --- | -------- | --- | ----------------- | --- | ---- | ------- |
lers.Basedonresultsfromthecriticalreview(table2;
|     |     |     |     |     | neighbourhood-scale |     |     | quantities | (e.g. | via tra- |
| --- | --- | --- | --- | --- | ------------------- | --- | --- | ---------- | ----- | -------- |
section3.2),werecommendthatparticularattention
versesorothermeasurementsthatintegrateover
bepaidtothereportingofthefollowingmetadata.
scalesofhundredsofmeterstoafewkilometers)
inmesoscalemodels.
(a) Characterizethemodelrepresentationofneigh-
|     |     |     |     |     | (d) Ensurereasonablebasecasemodelperformance |     |     |     |     |     |
| --- | --- | --- | --- | --- | -------------------------------------------- | --- | --- | --- | --- | --- |
bourhood(s)inwhichheatmitigationisapplied,
|             |              |     |           |         | before | proceeding, | for | example | by understand- |     |
| ----------- | ------------ | --- | --------- | ------- | ------ | ----------- | --- | ------- | -------------- | --- |
| for example | by reporting |     | the local | climate |        |             |     |         |                |     |
ingandaddressingtherootcausesofhighMAE
zone(s)orbuiltgeometryandmaterials(seesup-
orRMSE,orlowr2ord,beforeconductingheat
plementarytable1).
mitigationsimulations.
(b) Reporttheratioofheatmitigationimplementa-
|     |     |     |     |     | (e) Usesufficientdomainsizesuchthattheareaover |     |     |     |     |     |
| --- | --- | --- | --- | --- | ---------------------------------------------- | --- | --- | --- | --- | --- |
tionareatoplanarea,forexampletheplanarea
whichcoolingisassessed(section2.3.4.1.)isnot
ofroofsforcoolorgreenroofimplementations,
|     |     |     |     |     | impacted | by  | domain | boundaries, | e.g. | by test- |
| --- | --- | --- | --- | --- | -------- | --- | ------ | ----------- | ---- | -------- |
orcanopycoverfractionforstreettreeplanting.
ingtheinfluenceofalargerbufferbetweenthe
| (c) Characterize | prevailing | meteorological |     | condi- |     |     |     |     |     |     |
| ---------------- | ---------- | -------------- | --- | ------ | --- | --- | --- | --- | --- | --- |
upwinddomainboundaryandthezoneofcool-
| tions | during the numerical |     | experiment, | for |     |     |     |     |     |     |
| ----- | -------------------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
ingassessment(ifthebufferisalreadysufficient,
| example | solar zenith | angles | or day of | year and |     |     |     |     |     |     |
| ------- | ------------ | ------ | --------- | -------- | --- | --- | --- | --- | --- | --- |
increasingitwillnotappreciablychangeresults).
| latitude, | mean wind | and cloud | cover, | particu- |     |     |     |     |     |     |
| --------- | --------- | --------- | ------ | -------- | --- | --- | --- | --- | --- | --- |
larlyforshorterterm(non-climatescale)simu-
Improvementintheseareas,inparticular,should
lations.
|     |     |     |     |     | be priorities | in the | field of | urban | heat mitigation |     |
| --- | --- | --- | --- | --- | ------------- | ------ | -------- | ----- | --------------- | --- |
(d) Spatiallycontextualizethereportedairtemper-
modelling.Mostcritically,thepeer-reviewedcapabil-
aturecooling,forexample,indicatetheportion
ityoftheappliednumericalmodeltoaccuratelyrep-
ofthesimulationdomainthatcorrespondstothe
resentturbulenttransportofheatintheurbancanopy
reportedcoolingmagnitude.
andphysicalprocessesassociatedwiththeheatmitig-
(e) Reportthetemporalcontextforthecooling(e.g.
ationimplementationshouldbedemonstratedprior
diurnalaveragevs.noontimecooling).
toitsapplication.
5.1.2.Modellingmethodologyandreliabilityofresults 5.1.3.Modelrepresentationsofphysicalprocesses
Amodelwithwell-testedrepresentationsofallrelev- relevanttourbanheatmitigation
antphysicalprocesses,evaluatedandappliedappro- Theinformalmeta-analysisinsection4suggeststhat
priatelytoassesstheheatmitigationimplementation, differing representations of urban meteorological
is required to produce reliable cooling magnitudes. processes, especially those that modulate air tem-
Model application at the microscale, and numerical perature response to heat mitigation implementa-
model development at both scales, would particu- tions, are primary contributors to the variation of
larlybenefitfromthefollowingrecommendationsfor reported cooling magnitudes between studies. The
improvedreliabilityofresults. most notable differences appear between microscale
16

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
Figure8.Theimportanceofmodelphysicsrepresentationsofurbansurfacelayerexchangeonairtemperaturecoolingfrom
albedoenhancement.Adiurnalcompositeofcoolingduringa2006heatwaveinPhoenixstudiedbyBroadbentetal(2020a)is
plottedfortwourbancanopymodels(UCMs)embeddedintheWRFmesoscalemodel.ForeachUCM,thealbedoofroadand
roofareincreasedinseparatesimulationsto0.88.
(ENVI-met) and mesoscale models for roof-level assuming linear temperature responses to albedo
implementations(coolandgreenroofs;figures6and changes.Similarly,10%oftheACEvalueisthecool-
7). Typically, microscale models do not account for ing obtained for a 0.1 neighbourhood-wide albedo
local-scaleadvectionorboundary-layerscalevertical increase,anincreaseforwhichtheassumptionoflin-
mixing, and ENVI-met version 4 (and likely earlier earityismorelikelytohold.Anexampleofsuchan
versions) may have additional limitations in terms increaseisaresidentialneighbourhoodwithroofplan
ofaccuratelysimulatingverticalmixingintheurban area of 0.20, where all roofs receive a high albedo
canopy layer (Crank et al 2018). Mesoscale models coating that increases their albedo by 0.50 (e.g. to
omit or attempt to parameterize the effects of most 0.60–0.70). The predicted 0.58 ◦C median air tem-
microscale canopy layer processes and many cannot perature reduction based on the ACE derived from
readilydistinguishthepedestrian(2m)levelfromthe mesoscale modelling studies appears reasonable for
surface layer above roof level (e.g. the standard 2 m this scenario, whereas the 0.16 ◦C median cooling
temperaturereportedinmostWRF-SLUCMstudies from ENVI-met 3.1 studies would suggest that roof
does not). Moreover, our own simulations indicate albedo has negligible impact. Moreover, an ACE of
thatroofsurfacetemperaturesvarystronglybetween 5.8 ◦C more closely matches available observational
ENVI-metversion4andWRFcoupledwithitsmulti- data from area-limited albedo treatments in rural
layer urban canopy model building effect paramet- areas that have an ACE of ≈4 ◦C–9 ◦C (Rosenfeld
erization (BEP) (Martilli et al 2002) for identical et al 1995). The necessity for turbulent transport of
forcing conditions (not shown). Secondly, underly- the cooled air from rooftops to the pedestrian level
ing assumptions related to roof heat conduction as inanurbanarea,whichisexplicitlymodelledinthe
well as building construction and insulation char- ENVI-metstudiesbutisnotpresentintheruralarea
acteristics will also affect the extent to which roof reported by Rosenfeld et al, would serve to reduce
heatmitigationimpactsarepartitionedbetweendir- thisruralACEvalueinanurbancontext.Mostlikely,
ectcoolingoftheatmospherevs.storageheatintothe realistic clear sky summer daytime ACE values for
roof/building, and these may differ substantively by highalbedoroofsliesomewherebetweenthevalues
default between ENVI-met and commonly-applied reportedbythetwomodelscales,e.g.intherangeof
mesoscalemodels.Hence,modelphysicsdifferences 2◦C–6◦C.
acrossoneormorekeyprocessesmaybecontributing Importantly, these model physics-related issues
tothesubstantivedisagreementincoolingeffective- are not limited to differences between model scales.
nessofrooftopheatmitigationbetweenmodelscales. For example, the single-layer (SLUCM) and multi-
As noted above, the ACE value in degrees layer (BEP) urban canopy models, when coupled
Celsius represents the cooling obtained from a with the WRF mesoscale model (Chen et al 2011),
neighbourhood albedo increase from 0.0 to 1.0, show very different pedestrian-level air temperature
17

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
responsestohighalbedoroads,andtoalesserextent applications (see supplementary figure 4 and sup-
to high albedo roofs, for otherwise identical model plementaryresultsforanexampleusingENVI-met).
inputandforcingconditions(figure8).Thesediffer- In such applications, apparently successful model
ences in cooling between WRF-SLUCM and WRF- evaluation can often be the result of compensat-
BEPprobablyarisefromdifferentparameterizations ing errors. Comparison of simulated and measured
of urban canopy layer radiation exchange and tur- air temperature at multiple locations and at mul-
bulent mixing between the models, and relatedly, tiple points across the diurnal cycle often improves
from different approaches to the calculation of a assessment of the base case simulation and its abil-
‘2 m’ air temperature in WRF. BEP represents mul- ity to distinguish scale-appropriate spatio-temporal
tiple layers within the urban canopy (supplement- variabilityofairtemperature.However,evenasoph-
ary figure1(b)) and provides sourceand sink terms isticated model evaluation against high quality air
to the boundary-layer scheme in WRF, which pen- temperature measurements does not on its own
etrates to ground level. This approach means that indicate that the model is correctly representing
the output 2 m air temperature is calculated by the the processes relevant to a potential heat mitigation
WRFdynamicalcoreandboundary-layerschemeat implementation.
a height of approximately 2 m (provided sufficient Evaluation of the base case model configura-
verticalresolutionintheurbancanopyisprescribed, tion alone is thus not a sufficient prerequisite for
as is done for the simulations in figure 8). WRF- simulation of cooling from heat mitigation imple-
SLUCM, conversely, diagnoses a ‘2 m’ air temperat- mentations, principally because the model physics
ure based on the sensible heat flux from the entire that most strongly impact cooling magnitudes (e.g.
urban surface (including roofs), effectively using a a green roof or street tree sub-model) are not often
bulk flux-gradient relation that does not differenti- involved in the base case simulation, and therefore
atebetweencanopyandabove-canopylayers(supple- accurate simulation of base case air temperatures
mentary figure 1(c)), and it is therefore less able to does not indicate that heat mitigation cooling mag-
distinguishbetweenroofandroadinfluenceson‘2m’ nitudes will be accurately simulated. Model physics
air temperature (note, however, that SLUCM does associated with both canopy layer mixing and the
calculate a canopy air temperature which is rarely heat mitigation implementation itself must be eval-
used, which responds differentially to roof vs. road uated (section 2.4), and few models or model com-
albedotreatmentsbutdoesnotcompareasfavourably binations that are applied to assess urban heat mit-
tomeasurementsinourexperience).Asaresult,the igation cooling have done so (table 2; section 3.2).
WRF-BEP 2 m air temperature, which is 2 m above There are typically three phases of model develop-
themodifiedroads,demonstratesmuchhighersens- ment and application prior to assessment of heat
itivity to road albedo than the WRF-SLUCM ‘2 m’ mitigation strategy-induced cooling with numerical
airtemperature,whichiseffectivelyaboverooflevel experiments:(a)developmentandtestingofanurban
(figure8).Thebasecaseconfigurationsofbothurban climateormicrometeorologicalmodel;(b)develop-
canopy models in WRF have been widely evaluated ment and testing of sub-models that introduce new
(e.g.Salamancaetal2018),andtheyevaluatealmost physical processes required to represent an urban
identicallyagainstmultiplemeasurementstationsin heatmitigationstrategyintheurbanclimatemodel;
the Phoenix metropolitan area for the current case and (c) evaluation and calibration of the urban
(supplementaryfigures2and3).Nevertheless,their climate model base case simulation prior to con-
representationofphysicalprocesses,particularlythe ducting heat mitigation experiments (table 3). Each
physics associated with their coupling to WRF and phase should include testing against measured data
urban canopy layer mixing, have received less test- and/or accepted standards to ensure model reliabil-
ing,withclearimplicationsforreliableassessmentof ity.Phase1and2testscanbeundertakenoncedur-
coolingmagnitudesfromheatmitigationimplement- ing urban climate model (or heat mitigation sub-
ations(figure8).Whilemorecomplexmodelphysics model) development, using datasets from intensive
representationsdonotalwaysimprovereproduction field campaigns for specific sites. These sites do not
ofbasecaseobservations(Grimmondetal2011,Best needtoincludetheexactsitewheretheheatmitiga-
and Grimmond 2015, Karlicky et al 2018), our res- tionstrategywillbeapplied,buttheyideallyinclude
ultssuggestthattheiraddedcomplexityisimportant the range of conditions for which the heat mitiga-
toconsiderforaccurateassessmentofnovelforcingor tionrepresentationwillbeapplied.Modelevaluation
boundaryconditions,asinthecaseofheatmitigation and calibration during phase 3, alternatively, must
strategyimplementation. be conducted each time the model is applied, using
Incorrect or inadequate model physics can also data from the location where the strategy will be
persist when air temperature of the base case sim- implemented.
ulation is the only metric used to assess the suit- Our critical review suggests that there is oppor-
ability of a model for a heat mitigation experi- tunity for improvement in each of the three phases
ment,asisthecaseformanyheatmitigationmodel intable3(seesection3.2).Critically,testingismost
18

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
siecnadiuG.snoitatnemelpmiygetartsnoitagitimtaehmorfgniloocyfitnauqotdengisedsledomlaciremunfonoitacilppadnatnempolevedehtgniruddetaulaveyllaedieratahtselbairavetatsdnasessecorplacisyhpyeK.3elbaT
ledom-busygetartsnoitagitimtaeh)2(;tnempolevedledomlacigoloroetemorcimroetamilcnabru)1(:tnemssessanoitagitimtaehrofnoitacilppadnatnempolevedledomforedrolacigolonorhclacipytehtotgnidroccaderutcurts
.tnemirepxenoitagitimtaehagnitcudnocotroirpnoitarbilacdnanoitaulaveledomdetaicossadnanoitalumisesacesab)3(dna,)ledomeertteerts,ledomfoorneerg.g.e(tnempoleved
esahpnoitaulaveledomhcaetastsetdednemmoceR
noitagitimtaehfonoitalumisesacesaB.3
tnemirepxe
tnempolevedledom-busnoitagitimtaeH.2
atnempolevedledometamilcnabrU.1
ygetartsnoitagitimtaeH
-iravlaropmetdnalaitaps,etairporppaelacS
foxulftaehelbisnesro/dnaerutarepmetecafrusfoesnopseR
evobadnanihtiwtaehfotropsnartlacitreV
odeblA
-tarepmetria)m2∼(yponacnabrufonoita
begnahcodeblaotsecafrussuoivrepmi
:fonoitcnufasareyalyponacnabrueht
sfoorevitcelfeR
•
fonoituloserdednemmocermuminiM.eru
ytisnednabru
•
tnemevapevitcelfeR
•
:ataderutarepmetderusaem
deepsdniw
•
sllawgnidliubevitcelfeR
•
m001∼tanoitairavylruoh:elacsorciM
•
ytilibatscirehpsomta
•
-xamdnamuminimlanruid:elacsoseM
•
-repmetria)m2∼ro(reyalyponacnabrU
lacolnommoctsomehtneewtebmumi
ecafrusro/dnasexulftaehelbisneSeruta
-rusdna)s(aeranabruehtnisenozetamilc
,sfoor(secafruslaudividnifoserutarepmet
sdnuor
)sdaor,sllaw
-rut/dniw,noitaidarralosyponaceert-wolebfoesnopseR
seertteertS
tnetalllarevofodna,erutarepmetecafrusdaordnaecnelub
revoceertotxulftaeh
-irepgniyrddnanoitatipicerpoterutsiomliosfoesnopseR
noitategevwoL
-siomliosotsexulftaehtnetaldnaelbisnesfoesnopser;sdo
sfoorneerG
•
cticifederusserpruopavdnascitsiretcarahcnoitategev,erut
noitategevlevel-dnuorG
•
noitagirrI
•
erutsiomliosotsexulftaehtnetaldnaelbisnesfoesnopseR
seidobretawdnanoitagirrI
noitagirrioterutsiomliosfoesnopser;erutarepmetretawro lacigoloroetemoterutarepmetretawro,epytliosdnagnimit
gnicrof
taehelbisnesro/dnaerutarepmetecafruslenapfoesnopseR
slenapciatlovotohP
-oloroetemgniyravyllanruidotnoitarenegrewopdnaxulf sedisevitcatadedulcnisegnahcxeygrenehtiw,gnicroflacig
dslenapfo
taehmorfgniloocreyalyponacssessaotderiuqerscisyhpyekfosrotacidnitnatropmieraerehdetneserpstset;elacsdnaepytledomfonoitcnufasaseiravgnitsetlanoitiddatub,dednemmocersistsetfoytisrevidretaergAa
.seigetartsnoitagitim
.snoitatnemelpmidesab-odeblarofderiuqeryllacipytsiledom-buslanoitiddaonecnis,)tnempolevedledometamilcnabru(1petsfonoitropnoitaulaveledomehtfotrapasaeromtifoslayamstsetesehTb
fotnemssessA.)srorregnitasnepmocrofytinutroppoerom.e.i(ledom-busehtfotsetdecnaunsselasedivorptub,erusaemotrelpmissitahtsexulftaehtnetaldnaelbisnesotevitanretlanasaevresnacerutarepmetecafruSc
.elbareferpdnaledomehtfotsetregnortshcumasi,elbissoperehw,sexulfdelledom
,sesacesehtroF.)1202(lateregnisueHees—)ecafrustsohrehtoro(foorehtotesolcyrevronoyltceriddetnuomsiedisrednuehtsselnu,egnahcxetaehelbisnesotylgnortsetubirtnocyllacipytslenapciatlovotohpfosedishtoBd
.ycaruccadooghtiwerutarepmetecafruslenapfonoitairavlanruiderutpacotelbaebdluohsyehtdna,desuebdluohsslenapfosedishtobnoegnahcxe)noitaidarevawgnoldna(taehelbisnestneserpertahtsledom
19

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
often weak or absent in phases 1 and 2 (table 2; temporalandspatialscalesformodelevaluationsin
section3.2),duringwhichkeyphysicalprocessesthat all three phases, although sufficient data currently
controlairtemperatureresponsetotheimplementa- exists within the global scientific community for
tionofaheatmitigationstrategyareassessed.When most, if not all, of the recommendations in table 3.
thesephasesareskipped,thesekeyphysicalprocesses Development of open source databases containing
remainuntested,potentiallycontributingtothelarge highqualitymeasurementsforevaluationofnumer-
diversity of ACE and VCE values in figures 6 and 7. icalmodelrepresentationsofurbancanopyprocesses
Ideally, this type of evaluation is performed by the andprocessesrelatedtoheatmitigationimplement-
developersoftheoriginalurbanclimatemodelorthe ations is recommended, and will need to properly
developersofassociatedmodelextensionsrelatedto recognize the substantive efforts undertaken by the
heat mitigation strategies (e.g. green roof or street scientistsinvolvedincollectingtheseobservations.
treesub-modelsthatareaddedtoexistingurbancli-
matemodels).ENVI-metpresentsaparticularchal- 5.1.4.Combiningheatmitigationstrategies
lengeinthisregard,becauseitscodeisclosed-source, Several studies in our sample, particularly those
andtodatemanyofitsheatmitigation-relatedpro- applying ENVI-met, introduce multiple heat mitig-
cesseshavereceivedlittleornoevaluationinthepeer- ationstrategiesintoasingleheatmitigationsimula-
reviewedliterature. tionexperiment.Forexample,treesareplanted,grass
While rigorous evaluation of model physics in is added, and pavement albedo is increased. While
phases 1 and 2 is challenging, without it heat mit- suchstudiesmaybehelpfulforoptimizingthedesign
igation simulation results are not reliable and have of particular street or neighbourhood, they are less
limited utility. Critical to reliable simulation of heat useful for approaching a generalized understanding
reductionisevaluationofsurfacestatevariablesand ofurbanheatmitigationeffectiveness.Becausethese
fluxes directly modulated by each heat mitigation studiesdonotisolateindividualmitigationstrategies
strategy(i.e.phase2intable3).Forexample,assess- theywerenotincludedintheinformalmeta-analysis
ment of the temporal evolution of green roof soil insection4.Moreover,becausetheindividualeffect
moistureandheatfluxes(HeusingerandWeber2017, of a heat mitigation strategy is not accounted for,
Heusinger et al 2018), temperatures and heat fluxes place-basedprioritizationofwhatworksbestwithin
fromreflectivematerials(Rosadoetal2014,Kimetal a geographical context cannot occur (Georgescu
2020,Middeletal 2020),temperaturesofphotovol- et al 2014, Krayenhoff et al 2018). If computational
taic panels (Broadbent et al 2019b, Heusinger et al resources are available, we recommend assessment
2021), and temperatures of the road and associ- ofeachheatmitigationstrategyinisolationinaddi-
ated radiation fluxes underneath street trees (Kray- tion to the combined simulation, permitting assess-
enhoffetal2020),presentrealisticopportunitiesfor mentofcoolingmagnitudeandeffectivenessforeach
morerigorousassessmentofheatmitigation-related strategy independently. This approach also permits
model physics. Furthermore, phase 1 assessment of assessment of interactions between heat mitigation
simulated vertical turbulent (and dispersive) trans- strategies, which have not been fully explored in
port in the urban canopy layer and roughness sub- the literature. Evidence from Australia and the U.S.
layer as a function of ambient wind, stability and suggests these interactions may be largely antagon-
urbangeometryinastandardizedway,incomparison istic during daytime for both heat wave days (Jac-
withurbanlarge-eddysimulationresultsforexample obsetal2018))andthesummerseason(Krayenhoff
(Giometto et al 2016, Nazarian et al 2020), would et al 2018). Examples of assessment of interactions
promotemoreconsistentand realisticventilationof between urban climate processes with the Stein and
the street-level environment, as well as improved Alpert(1993)factorseparationmethodincludeMar-
transportofroof-levelairtemperaturereductionsto tilli(2002),RyuandBaik(2012)andKrayenhoffetal
street-level. If model physics are appropriately eval- (2018).
uated during model development phases 1 and 2,
then appropriate model evaluation against only air 5.2.Limitationsofthisreview
temperature during a heat mitigation study is more There are several limitations to the systematic and
justifiable (i.e. phase 3). During phase 3, evaluation criticalreviewandinformalmeta-analysisportionsof
of the ability of models to assess intra-urban air this work. In terms of the definition of our sample,
temperature variation at a model-appropriate scale we limit our literature sample to one database: Web
should be undertaken (table 3). Salamanca et al ofScience,andweexcludearticlesinlanguagesother
(2011)presentanexampleofintra-urban(i.e.inter- thanEnglish.Thecriticalportionofthisreviewrelies
neighbourhood or inter-local climate zone) evalu- on definition of 25 sub-criteria, which may not be
ation/calibration of a mesoscale model, while Roth fullycomprehensive.Inourview,themostsubstan-
and Lim (2017) evaluate a microscale model with tial limitations arise at the informal meta-analysis
intra-neighbourhood (i.e. ∼100 m) scale observa- stage; for most heat mitigation strategies, there are
tions. A key challenge more generally is the limited insufficient studies exhibiting satisfactory methodo-
availability of observational data at the appropriate logytoproperlyassessacentraltendencyofcooling
20

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
effectiveness. Second, the preponderance of WRF- reflective pavement (ACE ≈11) may be about twice
SLUCM and especially ENVI-met 3.1 in the meta- as effective as reflective roofs (ACE ≈4–5) at lower-
analysissamplemaybiasresults,giventhelikelihood ingpedestrian-levelairtemperature,evenforlowrise
thatthereissubstantialopportunityforimprovement neighbourhoods (figure 8; supplementary figure 5).
in the representations of physical processes of rel- However, recent simulation results find street-level
evance to certain heat mitigation strategies in these albedoACEof∼2◦C–3◦C(Moheghetal2017;Tsoka
models(seesection5.1.3).Moreover,availablestud- etal2018a),andrecentmeasurementsfromCalifor-
ies are unlikely to provide distributions of cooling nia cities yield roof albedo ACE of 2.5 ◦C–18.4 ◦C
magnitudes that are representative of the range of (Mohegh et al 2018). Few studies have examined
potential synoptic and mesoscale climates and local reflectivebuildingwallsinisolation,butrecentstud-
climate zones in which heat mitigation strategies ies indicate that they are substantially less effect-
maybeapplied.Manydegreesoffreedomareunac- ive at cooling air temperature compared to reflect-
counted for in the informal meta-analysis, such as iveroofs,atleastduringdaytime(Zhangetal2019),
weather conditions, leaf area density, simulated air and their impacts more strongly depend on factors
temperature height—contributing to its ‘informal’ such as urban density (Nazarian et al 2019). There-
nature. Importantly, informal meta-analysis results fore, the available evidence does not clearly distin-
focus on episodic summer scenarios when heat guishbetweenthecoolingeffectivenessofhighalbedo
mitigation implementations are likely to have the implementationswhenappliedongroundlevelsur-
greatest benefits, whereas guidance for practitioners faces vs. roofs (when applied on shorter, e.g. 1–2
(e.g. urban planners) should include assessment of storey buildings), but does suggest that high albedo
impactsthroughoutthewholeyear(Krayenhoffand building walls are less effective. Importantly, high
Voogt2010,YangandBou-Zeid2018). groundandwallalbedoscanhavesubstantialnegat-
iveconsequencesforpedestrians,drivers,andbuild-
5.3.Rankingeffectivenessofheatmitigation ings(Yaghoobianetal2010,Erelletal2014,Schrijvers
strategies etal2016),whichreflectiverooftopstypicallyavoid.
Sample sizes of high-quality studies for each heat Moreover, elevated ground-level albedos are diffi-
mitigation strategy in section 4 can provide ini- cult to maintain in practice and do not combine
tial guidance related to effectiveness of heat reduc- well with trees, while tree cover generally provides
tionoptions,particularlyincombinationwithrecent large radiative benefits to pedestrians instead of
evidence from the literature. In addition to limited the potential disbenefits associated with reflective
samplesize,assessmentofconsensusefficaciesofdif- pavement.
ferentheatmitigationstrategiesiscomplicatedbythe Urban vegetationhas been widelystudied; how-
strong modulation of heat mitigation effectiveness ever, unlike reflective coatings, which are applied
bymeteorologicalandneighbourhoodcontexts,even to engineered materials, model representation of
for clear sky, low wind, afternoon conditions. For urban vegetation typically requires complex soil-
example,lowvegetationwilltendtobemoreeffective vegetation schemes that must be combined with
indryconditionsthanmoistatmosphericconditions, ‘urban’modelsofbuildingandroadinteractionswith
androoftopstrategiesarelikelytosubstantivelyinflu- theatmosphere.Moreover,coolingfromurbanveget-
encethepedestrianlevelforlowriseneighbourhoods, ation, particularly low vegetation, is highly depend-
butlesssoforneighbourhoodswithtallerbuildings ent on soil moisture, and often LAI as well, both
(Botham-Myintetal2015). of which can exhibit strong variation spatiotempor-
Reflectivesurfacesandcoatingshavebeenwidely ally and between studies. Therefore, ranking veget-
studiedacrossbothmodelscales.Ourmeta-analysis ation strategy effectiveness based on the diversity
results yield ACE values for roofs of 1.6 ◦C–5.8 ◦C, of existing scenarios in the literature is a complex
where the upper limit is in agreement with a pre- task. Nevertheless, our informal meta-analysis sug-
vious review (Krayenhoff and Voogt 2010). How- geststhatgreenroofsexhibitlesscoolingeffectiveness
ever, our meta-analysis does not permit clear rank- comparedtoground-levelvegetationandstreettrees
ing of roof versus street-level albedo in terms of air (section4.2).Likewise,arecentreviewsuggeststhat
temperature reduction effectiveness, perhaps due to treesprovidemorecoolingthangreenroofs,andthat
the current status of canopy layer turbulent mixing lowvegetationatground-level,suchasgrass,mayfall
parameterizations (see section 5.1.3). Santamouris somewhereinbetween(Santamourisetal2017).De
et al (2017) report ACE values that generally agree Muncketal(2018)alsofindthatground-levelveget-
withourmeta-analysisresults(2.3–6.2forroofs,and ationismoreeffectivethangreenroofsforstreet-level
2.7–9.5forpavement),andtheyprovidesomeindic- cooling. There is observational evidence that trees
ation that reflective pavement may provide more providemorecoolingrelativetoground-levelvegeta-
pedestrian level cooling than reflective roofs. Our tionduringdaytime(Shashua-Baretal2009)butthe
currentPhoenix-basedmesoscalesimulationresults, opposite at night, that the combination of low and
using a multi-layer urban canopy model with very highvegetationisadditive,andthatgreenroofscan
detailedresolutionoftheurbancanopy,suggestthat providecoolinginsomecases(Bowleretal2010).If
21

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
weassumethatthecontrastbetweenurbanparksand VCE in figures 6 and 7 are approximately equival-
their built-up surroundings provides a reasonable ent).Observationalevidenceindicatesthatgreening
estimate of urban cooling from unirrigated vegeta- strategies are more effective than water bodies dur-
tion,themeta-analysisbyBowleretal(2010)suggests ingmid-summerforacityinatemperateclimate(Hu
aminimumdaytimeVCEvalueofapproximately1◦C andLi2020).Althoughnotthesubjectofthecurrent
(range from 0 ◦C to 2 ◦C–3 ◦C) for urban vegeta- review, vegetation and irrigation strategies applied
tion.TheirvaluerepresentsaminimumVCEbecause below roof level within the urban canopy have the
itassumesnearbyurbanareasthatserveastheurban advantage of improving rather than worsening the
referencefortheparkcoolingsignaldonothaveany radiation environment during hot conditions (e.g.
vegetation(λ =0),andthaturbanparksaredevoid Danieletal2018),unlikereflectivesurfaces.Treesare
s
ofimpervioussurfaces(λ =1),conditionsthatare particularlyeffectiveinthisregard(Couttsetal2016,
s
unlikelytobefullysatisfied.ThisresultfromBowler MiddelandKrayenhoff2019).
et al (2010) is in broad agreement with, or slightly
lowerthan,thesimulatedVCErangesreportedhere 5.4.ApplicationofACEandVCEmetricstoheat
fortrees(3.3◦C;figure7(a))andlow/bulkvegetation reductiondecision-making
(∼3◦C;figure7(b)). Decision making by urban policy makers and city
Urbanirrigationhasreceivedlessattentioncom- planners should start by establishing appropriate
paredwithvegetationandreflectivesurfaces(Gaoand objectives that can contribute to community well-
Santamouris2019).Bothirrigationandwaterbodies being,resilienceandsustainability(Sailoretal2016).
havethepotentialtocoolthedaytimeurbanenviron- These may include improving pedestrian thermal
ment,andavailableevidenceindicatesthatirrigation comfort, reducing energy demand in buildings,
may be particularly effective (Vahmani and Hogue improvingbuildingresilienceindoorsintheabsence
2015, Broadbent et al 2018a). However, recent sim- of air conditioning or improving urban air quality.
ulations suggest that irrigation is less effective than Airtemperaturecanbeanimportantfactorinallof
trees (Broadbent et al 2019a), and that it increases these, but a reduction in air temperature does not
nocturnal temperatures (Vahmani and Ban-Weiss necessarily indicate that the strategy applied is suc-
2016), as do water bodies during mid-summer (Hu cessful,noristhelackofatemperatureeffectadefin-
and Li 2020) and late summer (Theeuwes et al iteindicatorthataproposedstrategyisnoteffective.
2013, Steeneveld et al 2014), by virtue of their high Thefollowingexamplesillustratethispoint.
heat capacity. Simulation results also demonstrate
thedependenceofurbanirrigation-inducedcooling (a) Daytimeairtemperaturebeneathafabricshade
magnitudeonperviousfractionofurbanneighbour- canopymaybeslightlyhigherthanthetemper-
hoods(VahmaniandHogue2015),andrecentmod- atureinanadjacentunshadedspace(becauseof
elling work suggests pavement watering as a partic- reducedaerodynamicmixing),yetthermalcom-
ularly effective heat mitigation strategy in densely fortisenhancedsubstantiallyduetothereduc-
builturbanareasthatmaylackperviousarea(Daniel tionintheradiantload(Shashua-Baretal2011).
etal2018).Importantly,airtemperaturecoolingfrom (b) Replacing a concrete pavement with grass is
extensive evaporation also increases humidity, and unlikely to result in a substantial reduction in
thereforedoesnotnecessarilyimprovethermalcom- near-surfaceairtemperature,yetitcanprovidea
fort or reduce the thermal load on air condition- substantialreductioninmeanradianttemperat-
ing systems. Vegetation strategies in many climates ureadjacenttoit,andthusarealimprovementin
will not be effective without irrigation, and hence thermalcomforttopedestrians(Sniretal2016,
these two strategies are often strongly linked. For MiddelandKrayenhoff2019).
example,numericalmodellingsuggeststhatextensive (c) Urban densification will almost certainly
greenroofsofferlittletonocoolingwithoutsufficient intensify the nocturnal urban heat island, yet
soil moisture (Li et al 2014, Heusinger et al 2018), totalannualenergyconsumptionforaircondi-
which depends on irrigation in drier locations or tioning and heating buildings may be reduced,
seasons. eveninrelativelywarmclimateswithmildwin-
Overall, there is partial agreement that ground- ters and warm summers (Erell and Kalman
levelstrategiesprovidemorestreet-levelairtemperat- 2015).Thebalancewillbedeterminednotonly
urecooling,particularlyforgreeningstrategies.Com- by climate, but by the thermal characteristics
parison of reflective coatings with vegetation and of the building in question and by the effect of
irrigation strategies is complicated by the variation building massing on mutual shading and the
of cooling effectiveness of the latter with LAI and potentialfornaturalventilation.
especiallysoilmoistureand/orirrigationamountand (d) High albedo pavements and wall surfaces will
timing.Ourinformalmeta-analysisdoessuggestthat reduce daytime air temperature in urban street
their cooling potential is of the same order of mag- canyons,yetpedestrianthermalcomfortmaybe
nitude(e.g.assumingalbedotreatmentsincreaselocal adverselyaffectedduetoanincreaseintheradi-
surfacealbedoby0.50onaverage,medianACEand antload(Erelletal2014,Schrijversetal2016),
22

| Environ.Res.Lett.16(2021)053007 |     |     |     |     |     |     |     |     |     |     | ESKrayenhoffetal |     |
| ------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- |
andtheincreasedradiantloadonwindowsand Great caution should be exercised when using
otherglazedsurfacesmayincreasebuildingcool- these metrics because they are affected by several
ingdemand(Yaghoobianetal2010,Yaghoobian factors,includingneighbourhoodcharacteristicsand
| andKleissl2012). |     |     |     |     |     | ambientmeteorology.Thus,differentACEandVCE |     |          |     |           |                |     |
| ---------------- | --- | --- | --- | --- | --- | ------------------------------------------ | --- | -------- | --- | --------- | -------------- | --- |
|                  |     |     |     |     |     | values may                                 | be  | obtained | for | different | seasons/latit- |     |
Consequently, air temperature reduction per se udes, for compact and/or high rise neighbourhoods
should not be the be-all and end-all of strategies to vs. dispersed and/or low rise neighbourhoods, and
mitigate urban heat. Rather, it is important to be for different times of day (as in figures 6 and 7).
able to account for the effect of different mitigation Cooling from addition of trees may vary nonlin-
strategiesonairtemperature,becauseitisanessen- earlywithexistingtreecanopycoverovercertaincan-
tial input for assessing metrics relevant to each of opy cover ranges (Ziter et al 2019), indicating that
the objectives proposed above, if it is provided at VCE may need to be assessed a function of exist-
theappropriatespatialandtemporalscales.Because ing canopy cover. Given the large potential vari-
planners and engineers outside the research com- ation along several degrees of freedom, worthy ini-
munity will not generally have access to appropri- tialobjectivesincludeassessmentofACEandVCEfor
atemodellingtoolsandtheexpertiserequiredtouse eachheatmitigationimplementationforhotcondi-
them, this information should be generated by the tions in neighbourhood types that are most inhab-
urbanclimatemodellingcommunity,communicated ited worldwide, namely, for clear sky, light wind,
in formats that are accessible and useful (Mills et al summertimeafternoonconditionsinopenandcom-
| 2010). |     |     |     |     |     | pact residential |     | neighbourhoods, |     | and | for | both mid- |
| ------ | --- | --- | --- | --- | --- | ---------------- | --- | --------------- | --- | --- | --- | --------- |
Whatthenisthepracticalbenefitoftheconsensus latitude and (sub)tropical cities. Any reported ACE
values of ACE and VCE metrics generated in this or VCE magnitudes should be clearly contextual-
study after rigorous evaluation of the existing peer- ized with metadata describing their meteorological,
reviewed literature? They may be used as an initial neighbourhood,andtemporalcontext.Importantly,
guidelineforassessingpotentialoutcomesforagiven equations (4) and (5) are applicable at the neigh-
bourhoodscale(∼500mandlarger),andthecooling
heatmitigationstrategyattheneighbourhoodscale,
helpingtoavoidunrealisticexpectationsthatmaybe impactsofanysuchheatreductionapplicationacross
fosteredbyproponentsofparticulardesigninterven- aneighbourhoodwillinfluencedownwindareasand
| tions.               |     |     |                          |     |     | also be              | subject | to dilution |     | at upwind |     | edges (e.g. |
| -------------------- | --- | --- | ------------------------ | --- | --- | -------------------- | ------- | ----------- | --- | --------- | --- | ----------- |
| Foralbedostrategies, |     |     | the temperaturereduction |     |     | Broadbentetal2020a). |         |             |     |           |     |             |
achievableis:
6.Conclusions
|         |            | ∆T=−∆α      | ·λ          | ·ACE,       |              |                   |            |           |            |           |             |           |
| ------- | ---------- | ----------- | ----------- | ----------- | ------------ | ----------------- | ---------- | --------- | ---------- | --------- | ----------- | --------- |
|         |            |             | s s         |             | (4)          |                   |            |           |            |           |             |           |
|         |            |             |             |             |              | We systematically |            | and       | critically |           | review      | 146 stud- |
| where   | ∆α is      | the change  | in albedo   | of          | the modified |                   |            |           |            |           |             |           |
|         | s          |             |             |             |              | ies from          | the        | past      | three      | decades   | that        | conduct   |
| surface | (i.e.      | mean albedo | of original | roofs       | or pave-     |                   |            |           |            |           |             |           |
|         |            |             |             |             |              | physically-based  |            | numerical |            | modelling | of          | air tem-  |
| ment    | subtracted | from        | albedo      | of proposed | reflective   |                   |            |           |            |           |             |           |
|         |            |             |             |             |              | perature          | reductions |           | resulting  | from      | implementa- |           |
λ
| roofs | or pavement), |     | and s is | the area | of modified |         |                      |     |     |       |      |           |
| ----- | ------------- | --- | -------- | -------- | ----------- | ------- | -------------------- | --- | --- | ----- | ---- | --------- |
|       |               |     |          |          |             | tion of | infrastructure-based |     |     | urban | heat | reduction |
surfacedividedbythecorrespondingoverallplanarea
|     |     |     |     |     |     | strategies. | Studies | are | grouped | into | two | modelling |
| --- | --- | --- | --- | --- | --- | ----------- | ------- | --- | ------- | ---- | --- | --------- |
(e.g.theareafractionofrooforroadtobemodified,
scalesforcriticalassessment:microscale(e.g.ENVI-
derivedfromaerialimagery,forexample).Notethat
met),andmesoscale(e.g.WRF-SLUCM).Streettree
∆α
s willreduceovertimeformanyhighalbedocoat-
|     |     |     |     |     |     | cooling | has primarily |     | been | assessed | at  | the micro- |
| --- | --- | --- | --- | --- | --- | ------- | ------------- | --- | ---- | -------- | --- | ---------- |
ingsduetoweathering.
|     |     |     |     |     |     | scale, whereas |     | mesoscale | modelling |     | has | favoured |
| --- | --- | --- | --- | --- | --- | -------------- | --- | --------- | --------- | --- | --- | -------- |
VCEmaybeappliedanalogouslytoassesstemper-
|     |     |     |     |     |     | reflective | roof | treatments, |     | which | are attributed | to  |
| --- | --- | --- | --- | --- | --- | ---------- | ---- | ----------- | --- | ----- | -------------- | --- |
aturereductionpotentialofvegetationapplications:
|     |     |     |     |     |     | model physics |     | limitations | at  | each | scale. | We develop |
| --- | --- | --- | --- | --- | --- | ------------- | --- | ----------- | --- | ---- | ------ | ---------- |
∆T=−λ ·VCE. (5) 25sub-criteria,groupedintosevencriteria,thatassess
s
|     |     |     |     |     |     | contextualizationand |     |     | reliability | of  | each | study based |
| --- | --- | --- | --- | --- | --- | -------------------- | --- | --- | ----------- | --- | ---- | ----------- |
However,forlowvegetationandgreenroofs,tem- on metadata reporting and methodological qual-
peraturereductioncalculatedbasedonVCEislikely ity, respectively. Metadata criteria include reporting
tobeapplicableonlyforsoilmoistureconditionsthat of neighbourhood characteristics and meteorolo-
closely resemble those in the studies used to obtain gicalconditions,heatmitigationstrategyapplication,
VCE.Aninitialobjectiveshouldthereforebeassess- and spatio-temporal specification of the affected air
mentofVCEforseveraldifferentgreeninfrastructure temperature. Methodological criteria assess model
implementationswithsufficientrootzonesoilmois- physics, model evaluation, and model application.
tureandthereforeminimizedstomatalresistance(e.g. Studies most often fail to adequately characterize
irrigated vegetation). Trees have deeper roots and the neighbourhood(s) in which heat mitigation was
providecoolingadditionallyviashade,andtherefore applied, particularly at the mesoscale, or perform a
theirVCEislesslikelytobestronglyinfluencedbysoil suitable evaluation of the base case model config-
moisture. uration applied to assess cooling, particularly at the
23

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
microscale. Specific sub-criteria that most require ground-levelalbedocanradiativelyimpactpedestri-
improvementincludereportingthearealcoverageof ansanddrivers,renderinglargealbedoincreasesmore
the heat mitigation implementation, and evaluation feasibleonrooftops.
ofmodelphysicsrepresentationsofbothurbancan- The most striking finding from the informal
opylayerturbulenttransportandtheheatmitigation meta-analysis, however, is the strong apparent
implementations themselves. Example heat reduc- dependenceofACEandVCEonmodelscale,particu-
tionmodellingstudiesthatexemplifygoodmetadata larlyforroofalbedoandgreenroofimplementations.
reportingand/ormodellingmethodologyareselected WepresentfurtherevidencedemonstratingthatACE
basedontheirperformanceagainstthesevencriteria. (andlikelyVCE)canalsovarystronglybetweenmod-
Forty-seven studies that exhibit higher method- elsatthesamescaleforotherwiseidenticalsimulation
ological quality were identified for inclusion in an scenarios. These results suggest that current model
informal meta-analysis of cooling effectiveness for physics representations of heat mitigation strategies
selectheatmitigationstrategies.WedefinetheAlbedo playalargeroleinthevariationofcoolingmagnitudes
Cooling Effectiveness (ACE) and Vegetation Cool- betweenstudies.Importantly,evaluationofanurban
ing Effectiveness (VCE) metrics to control for a climate or micrometeorological model’s ability to
primary degree of freedom that generates variation reproduceobservedairtemperaturesdoesnotindic-
ofairtemperaturecoolingmagnitudebetweenstud- ate that the model is suitable for a heat mitigation
ies: the plan area fraction or intensity of the heat experiment, because the physics associated with the
mitigationimplementation.Highreflectivitycoatings heatmitigationstrategy(e.g.thegreenrooforstreet
or materials offer ≈0.2 ◦C–0.6 ◦C cooling per 0.10 treesub-model)isnotevaluatedinthebasecasesim-
neighbourhood albedo increase (i.e. ACE ≈2 ◦C– ulation.Weconcludethatevaluationofthebasecase
6◦C),andtreesyield≈0.3◦Ccoolingper0.10can- model configuration is not a sufficient prerequisite
opy cover increase (i.e. VCE ≈3 ◦C), for afternoon forsimulationofcoolingfromheatmitigationimple-
clear-sky summer conditions. VCE of low vegeta- mentations.
tion and green roofs varies more strongly between Inresponse,weidentifyathree-phaseframework
studies. As expected, ACE and VCE are generally forassessmentofthesuitabilityofanumericalmodel
smaller during nighttime and during winter, indic- foraheatmitigationexperiment.Phase1comprises
ating that these strategies generate more cooling for developmentandevaluationoftheurbanclimateor
daytime clear sky summer conditions. When com- micrometeorologicalmodel,includingtestingmodel
binedwithevidencefromtheliterature,ourinformal accuracy with respect to vertical convective trans-
meta-analysis suggests that: (a) albedo and veget- port of heat within and above the urban canopy.
ation strategies offer broadly similar magnitudes Phase2involvesdevelopmentandtestingofthemod-
of air temperature reduction per area application; elledphysicalprocessesassociatedwiththeheatmit-
(b) ground-level albedo implementations may offer igation implementation (e.g. a green roof or street
somewhat more pedestrian-level air temperature tree sub-model). Phases 1 and 2 will typically occur
reductionthanroof-levelalbedoperneighbourhood priortoaheatmitigationexperiment.Phase3occurs
average albedo increase; and (c) trees and ground- as part of a heat mitigation experiment and com-
level vegetation offer somewhat more pedestrian- prises evaluation and calibration of the base case
level cooling per area application compared with modelagainstairtemperaturemeasurementsatspa-
greenroofs.Morehigh-qualitystudiesarerequiredto tial and temporal scales of relevance to the inten-
assessandrefinethesepreliminaryconclusions,and ded numerical experiment. While there is oppor-
futuremeta-analysesarerecommended,particularly tunity to improve model testing at all three phases,
based on observations (e.g. Bowler et al 2010). Res- it is the testing portion of phase 2, that is, assess-
ults from vegetation strategies (i.e. VCE) are com- ment of the model representation of the heat mit-
plicated by the variation of soil moisture between igation strategy against measured data, that is least
studies, and other factors such as plant species and often performed yet critical for accurate simulation
LAI, whereas the ACE metric accounts for the vari- ofheatmitigationcooling.Moreover,phase1assess-
ation in the magnitude of albedo increase between ment of vertical heat transport is also critical for
studies. Although available high-quality simulation accuratesimulationofheatmitigationcoolingyetsel-
studies offer no clear ‘winner’ in terms of air tem- domundertakeninrigorousfashion.Rigorouseval-
perature cooling effectiveness, this is not unexpec- uation of model physics in phases 1 and 2 under-
ted since different heat mitigation strategies will pinsthereliabilityandutilityofheatmitigationsim-
be more adapted to different climates. Importantly, ulation results, but is hindered by the limited avail-
albedoandvegetationstrategieshavenumerousaddi- abilityofobservationaldataatappropriatetemporal
tionalbenefitsanddisbenefitsthatmustbefactored and spatial scales. Development of standardized
into decision making; for example, vegetation can measurement databases for evaluation of urban
increase humidity and associated disbenefits, while canopy processes and processes related to common
treesreducesolarradiationexposureandbenefitped- heat mitigation implementations is recommended
estriansandbuildingsduringhotweather,andhigh (seesection5.1.3).
24

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
Although model physics currently influences Science Foundation under Grant SES-1520803, and
numerical assessment of heat mitigation strategy SustainabilityResearchNetworkCooperativeAgree-
cooling effectiveness, many other factors modulate ment 1444758 (Urban Water Innovation Network).
actual cooling effectiveness. For example, different Additional funding was provided by a Natural Sci-
heatreductionstrategieswillbemoreadaptedtodif- ences and Engineering Research Council of Canada
ferentsynopticscaleclimatesorneighbourhoodcon- (NSERC)DiscoveryGranttoESKrayenhoff,andby
figurations.Moreover,severalstrategieshaveclimate- aRoskindArizonaStateUniversity-Ben-GurionUni-
relevant impacts that are not fully accounted for versityCollaborationGranttoEErell,MGeorgescu,
by their effects on air temperature, for example ESKrayenhoffandAMiddel.
shading by street trees, or the building insulation
benefits of green roofs. Ultimately, the underly- ORCIDiDs
ing objective of infrastructure-based heat mitiga-
tion strategies is not to reduce air temperature EScottKrayenhoffhttps://orcid.org/0000-0002-
alone, but rather to provide environments that are 4776-4353
healthier and more thermally comfortable and effi- LeiZhaohttps://orcid.org/0000-0002-6481-3786
cient. Each heat mitigation strategy additionally has MateiGeorgescuhttps://orcid.org/0000-0001-
numerous non-climatic benefits and/or drawbacks 7321-2483
related to aesthetics, habitat, function, hydrology, ArianeMiddelhttps://orcid.org/0000-0002-1565-
cost,historicalcontext,healthandsoon,whichmust 095X
be factored into choices among different strategies. JamesAVoogthttps://orcid.org/0000-0002-7975-
Implementation of heat reduction strategies must 0052
ultimately be place-based decisions that account DavidJSailorhttps://orcid.org/0000-0003-1720-
for the unique context of each city, neighbour- 8214
hood or street, and heat mitigation strategies, and
combinations thereof, should be chosen in order References
to maximize co-benefits and minimize potential
negative consequences. Moreover, near-term imple- AlchaparNLandCorreaEN2016Theuseofreflectivematerials
mentationofheatadaptationstrategiesshouldanti- asastrategyforurbancoolinginanarid“OASIS”city
Sustain.CitiesSoc.271–14
cipatefutureurbanclimates,sincelargeincreasesin
AleksandrowiczO,VuckovicM,KieselKandMahdaviA2017
heat exposure (Broadbent et al 2020b) and impacts
Currenttrendsinurbanheatislandmitigationresearch:
on liveability (Kusaka et al 2012) are projected observationsbasedonacomprehensiveresearchrepository
for scenarios without adaptation, and some adapt- UrbanClim.211–26
AmpatzidisPandKershawT2020Areviewoftheimpactofblue
ation options take time (e.g. street tree matura-
spaceontheurbanmicroclimateSci.TotalEnviron.730
tion). While the infrastructure-based air temperat-
139068
ure reduction strategies addressed in this work are BestMJandGrimmondCSB2015Keyconclusionsofthefirst
critical for decreasing the future heat burden in cit- internationalurbanlandsurfacemodelcomparisonproject
Bull.Am.Meteorol.Soc.96805–19
ies, maintenance of current warm season liveabil-
Botham-MyintD,RecktenwaldGWandSailorD2015Thermal
ity and health outcomes in cities globally addition-
footprinteffectofrooftopurbancoolingstrategiesUrban
ally requires substantive greenhouse gas emissions Clim.14268–77
reductions (Krayenhoff et al 2018) and street-scale BowlerDE,Buyung-AliL,KnightTMandPullinAS2010Urban
greeningtocooltownsandcities:asystematicreviewofthe
strategies, such as provision of shade, that help tar-
empiricalevidenceLandsc.UrbanPlan.97147–55
getheatexposuremorecomprehensively(Middeland
BroadbentAM,CouttsAM,NiceKA,DemuzereM,
Krayenhoff2019). KrayenhoffES,TapperNJandWoutersH2019aThe
air-temperatureresponsetogreen/blue-infrastructure
Dataavailabilitystatement evaluationtool(TARGETv1.0):anefficientand
user-friendlymodelofcitycoolingGeosci.ModelDev.
12785–803
The data that support the findings of this study are
BroadbentAM,CouttsAM,TapperNJandDemuzereM2018b
availableuponreasonablerequestfromtheauthors. Thecoolingeffectofirrigationonurbanmicroclimate
duringheatwaveconditionsUrbanClim.23309–29
BroadbentAM,CouttsAM,TapperNJ,DemuzereMand
Acknowledgments
BeringerJ2018aThemicroscalecoolingeffectsofwater
sensitiveurbandesignandirrigationinasuburban
IDStewartprovidedvaluablecommentsonanearly environmentTheor.Appl.Climatol.1341–23
BroadbentAM,KrayenhoffESandGeorgescuM2020aEfficacy
version of this work. The authors are grateful to
ofcoolroofsatreducingpedestrian-levelairtemperature
thefollowingcolleaguesforprovisionofmetadatain
duringprojected21stcenturyheatwavesinAtlanta,Detroit,
supportoftheinformalmeta-analysis:REmmanuel, andPhoenix(USA)Environ.Res.Lett.15084007
JFallman,DLi,X-XLi,T-PLin,MMakropoulou,K BroadbentAM,KrayenhoffESandGeorgescuM2020bThe
motleydriversofheatandcoldexposurein21stcenturyUS
Oleson, F Salamanca, S Schubert, J Song, T Sun, Z
citiesProc.NatlAcad.Sci.11721108–17
Tan,PVahmani,GBan-Weiss,JYang,andJZhang.
BroadbentAM,KrayenhoffES,GeorgescuMandSailorDJ
This research was supported by the US National 2019bTheobservedeffectsofutility-scalephotovoltaicson
25

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
near-surfaceairtemperatureandenergybalanceJ.Appl. GiomettoMG,ChristenA,MeneveauC,FangJ,KrafczykMand
Meteorol.Climatol.58989–1006 ParlangeMB2016Spatialcharacteristicsofroughness
BruseMandFleerH1998Simulatingsurface–plant–air sublayermeanflowandturbulenceoverarealisticurban
interactionsinsideurbanenvironmentswithathree surfaceBound.-LayerMeteorol.160425–52
dimensionalnumericalmodelEnviron.ModellingSoftw. GrimmondCSB,BlackettM,BestMJ,BaikJJ,BelcherSE,
13373–84 BeringerJandDandouA2011InitialresultsfromPhase2of
CaoM,RosadoP,LinZ,LevinsonRandMillsteinD2015Cool theinternationalurbanenergybalancemodelcomparison
roofsinGuangzhou,China:outdoorairtemperature Int.J.Climatol.31244–72
reductionsduringheatwavesandtypicalsummer GunawardenaKR,WellsMJandKershawT2017Utilisinggreen
conditionsEnviron.Sci.Technol.4914672–9 andbluespacetomitigateurbanheatislandintensitySci.
ChenF,KusakaH,BornsteinR,ChingJ,GrimmondCSB, TotalEnviron.584–51040–55
Grossman-ClarkeSandSailorD2011Theintegrated HamdiRandSchayesG2008Sensitivitystudyoftheurbanheat
WRF/urbanmodellingsystem:development,evaluation, islandintensitytourbancharacteristicsInt.J.Climatol.
andapplicationstourbanenvironmentalproblemsInt.J. 28973–82
Climatol.31273–88 HeusingerJ,BroadbentAM,KrayenhoffESandWeberS2021
ChowWTandBrazelAJ2012Assessingxeriscapingasa Adaptationofaphotovoltaicenergybalancemodelfor
sustainableheatislandmitigationapproachforadesertcity rooftopapplications.Build.Environ.192107628
Build.Environ.47170–81 HeusingerJ,SailorDJandWeberS2018Modelingthereduction
CouttsAM,WhiteEC,TapperNJ,BeringerJandLivesleySJ ofurbanexcessheatbygreenroofswithrespecttodifferent
2016Temperatureandhumanthermalcomforteffectsof irrigationscenariosBuild.Environ.131174–83
streettreesacrossthreecontrastingstreetcanyon HeusingerJandWeberS2017Surfaceenergybalanceofan
environmentsTheor.Appl.Climatol.12455–68 extensivegreenroofasquantifiedbyfullyear
CrankPJ,SailorDJ,Ban-WeissGandTaleghaniM2018 eddy-covariancemeasurementsSci.TotalEnviron.
EvaluatingtheENVI-metmicroscalemodelforsuitabilityin 577220–30
analysisoftargetedurbanheatmitigationstrategiesUrban HuLandLiQ2020Greenspace,bluespace,andtheirinteractive
Clim.26188–97 influenceonurbanthermalenvironmentsEnviron.Res.Lett.
CuiYYandDeFoyB2012Seasonalvariationsoftheurbanheat 15034041
islandatthesurfaceandthenear-surfaceandreductions HuszarP,HalenkaT,BeldaM,ZakM,SindelarovaKand
duetourbanvegetationinMexicoCityJ.Appl.Meteorol. MiksovskyJ2014Regionalclimatemodelassessmentofthe
Climatol.51855–68 urbanland-surfaceforcingovercentralEuropeAtmos.
DanielM,LemonsuAandViguieV2018Roleofwatering Chem.Phys.1412393–413
practicesinlarge-scaleurbanplanningstrategiestofacethe HuttnerS2012FurtherDevelopmentandApplicationofthe3D
heat-waveriskinfutureclimateUrbanClim.23287–308 MicroclimateSimulationENVI-metvol147(Mainz:
DeMunckC,LemonsuA,MassonV,LeBrasJandBonhommeM JohannesGutenberg-Universitat)
2018Evaluatingtheimpactsofgreeningscenarioson ImranHM,KalaJ,NgAWMandMuthukumaranS2019
thermalcomfortandenergyandwaterconsumptionsfor EffectivenessofvegetatedpatchesasGreenInfrastructurein
adaptingPariscitytoclimatechangeUrbanClim. mitigatingUrbanHeatIslandeffectsduringaheatwave
23260–86 eventinthecityofMelbourneWeatherClim.Extremes
EmmanuelRandFernandoHJ2007Urbanheatislandsinhumid 25100217
andaridclimates:roleofurbanformandthermalproperties JacobsSJ,GallantAJ,TapperNJandLiD2018Useofcoolroofs
inColombo,SriLankaandPhoenix,USAClim.Res. andvegetationtomitigateurbanheatandimprovehuman
34241–51 thermalstressinMelbourne,AustraliaJ.Appl.Meteorol.
ErellEandKalmanY2015Impactofincreasingthedepthof Climatol.571747–64
urbanstreetcanyonsonbuildingheatingandcoolingloads KarlickýJ,Husz´arP,HalenkaT,BeldaM,Ž´akM,PišoftPand
TelAviv,IsraelICUC9—The9thInt.Conf.UrbanClimate MikšovskýJ2018Multi-modelcomparisonofurbanheat
(Toulouse,France,20–24July2015) islandmodellingapproachesAtmos.Chem.Phys.
ErellE,PearlmutterD,BonehDandKutielPB2014Effectof 1810655–74
high-albedomaterialsonpedestrianheatstressinurban KimGA,SongBGandParkKH2020Long-termmonitoringfor
streetcanyonsUrbanClim.10367–86 comparisonofseasonaleffectsoncoolroofsinhumid
ErellEandWilliamsonT2006Simulatingairtemperatureinan subtropicalclimatesEnergyBuild.206109572
urbanstreetcanyoninallweatherconditionsusing KrayenhoffESetal2020Amulti-layerurbancanopy
measureddataatareferencemeteorologicalstationInt.J. meteorologicalmodelwithtrees(BEP-tree):streettree
Climatol.261671–94 impactsonpedestrian-levelclimateUrbanClim.32100590
FallmannJ,EmeisSandSuppanP2013Mitigationofurbanheat KrayenhoffES,ChristenA,MartilliAandOkeTR2014A
stress—amodellingcasestudyfortheareaofStuttgartDIE multi-layerradiationmodelforurbanneighbourhoodswith
ERDE–J.Geogr.Soc.Berlin144202–16 treesBound.-LayerMeteorol.151139–78
FallmannJ,ForkelRandEmeisS2016Secondaryeffectsofurban KrayenhoffES,MoustaouiM,BroadbentAM,GuptaVand
heatislandmitigationmeasuresonairqualityAtmos. GeorgescuM2018Diurnalinteractionbetweenurban
Environ.125199–211 expansion,climatechangeandadaptationinUScitiesNat.
GagoEJ,RoldanJ,Pacheco-TorresRandOrdóñezJ2013Thecity Clim.Change81097
andurbanheatislands:areviewofstrategiestomitigate KrayenhoffES,SantiagoJL,MartilliA,ChristenAandOkeTR
adverseeffectsRenew.Sustain.EnergyRev.25749–58 2015Parametrizationofdragandturbulenceforurban
GaoKandSantamourisM2019Theuseofwaterirrigationto neighbourhoodswithtreesBound.-LayerMeteorol.
mitigateambientoverheatinginthebuiltenvironment: 156157–89
recentprogressBuild.Environ.164106346 KrayenhoffESandVoogtJA2007Amicroscale
GeorgescuM2015Challengesassociatedwithadaptationto three-dimensionalurbanenergybalancemodelforstudying
futureurbanexpansionJ.Clim.282544–63 surfacetemperaturesBound.-LayerMeteorol.123433–61
GeorgescuM,MorefieldPE,BierwagenBGandWeaverCP2014 KrayenhoffESandVoogtJA2010Impactsofurbanalbedo
Urbanadaptationcanrollbackwarmingofemerging increaseonlocalairtemperatureatdaily–annualtimescales:
megapolitanregionsProc.NatlAcad.Sci.1112909–14 modelresultsandsynthesisofpreviousworkJ.Appl.
GillnerS,VogtJ,TharangA,DettmannSandRoloffA2015Role Meteorol.Climatol.491634–48
ofstreettreesinmitigatingeffectsofheatanddroughtat KusakaH,HaraMandTakaneY2012Urbanclimateprojection
highlysealedurbansitesLandsc.UrbanPlan.14333–42 bytheWRFmodelat3-kmhorizontalgridincrement:
26

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
dynamicaldownscalingandpredictingheatstressinthe MillsG,CleughH,EmmanuelR,EndlicherW,ErellE,
2070’sAugustforTokyo,Osaka,andNagoyametropolisesJ. McGranahanG,NgE,NicksonA,RosenthalJandSteemer
Meteorol.Soc.Japan9047–63 K2010Climateinformationforimprovedplanningand
KusakaH,KondoH,KikegawaYandKimuraF2001Asimple managementofmegacities(needsperspective)Proc.
single-layerurbancanopymodelforatmosphericmodels: Environ.Sci.1228–46
comparisonwithmulti-layerandslabmodelsBound.-Layer MillsteinDandMenonS2011Regionalclimateconsequencesof
Meteorol.101329–58 large-scalecoolroofandphotovoltaicarraydeployment
LaiD,LiuW,GanT,LiuKandChenQ2019Areviewof Environ.Res.Lett.6034001
mitigatingstrategiestoimprovethethermalenvironment MoheghA,LevinsonR,TahaH,GilbertH,ZhangJ,LiY,TangT
andthermalcomfortinurbanoutdoorspacesSci.Total andBan-WeissGA2018Observationalevidenceof
Environ.661337–53 neighborhoodscalereductionsinairtemperatureassociated
LeeH,MayerHandChenL2016bContributionoftreesand withincreasesinroofalbedoClimate698
grasslandstothemitigationofhumanheatstressina MoheghA,RosadoP,JinL,MillsteinD,LevinsonRand
residentialdistrictofFreiburg,SouthwestGermanyLandsc. Ban-WeissG2017Modelingtheclimateimpactsof
UrbanPlan.14837–50 deployingsolarreflectivecoolpavementsinCaliforniacities
LeeSH,LeeH,ParkSB,WooJW,LeeDIandBaikJJ2016a J.Geophys.Res.Atmos.1226798–817
Impactsofin-canyonvegetationandcanyonaspectratioon MoriasiDN,ArnoldJG,VanLiewMW,BingnerRL,
thethermalenvironmentofstreetcanyons:numerical HarmelRDandVeithTL2007Modelevaluationguidelines
investigationusingacoupledWRF-VUCMmodelQ.J.R. forsystematicquantificationofaccuracyinwatershed
Meteorol.Soc.1422562–78 simulationsTrans.ASABE50885–900
LeeSHandParkSU2008Avegetatedurbancanopymodelfor NazarianN,DumasN,KleisslJandNorfordL2019Effectiveness
meteorologicalandenvironmentalmodellingBound.-Layer ofcoolwallsoncoolingloadandurbantemperatureina
Meteorol.12673–102 tropicalclimateEnergyBuild.187144–62
LiD,Bou-ZeidEandOppenheimerM2014Theeffectivenessof NazarianN,KrayenhoffESandMartilliA2020A
coolandgreenroofsasurbanheatislandmitigation one-dimensionalmodelofturbulentflowthrough“urban”
strategiesEnviron.Res.Lett.9055002 canopies(MLUCMv2.0):updatesbasedonlarge-eddy
LiXXandNorfordLK2016Evaluationofcoolroofand simulationGeosci.ModelDev.13937–53
vegetationsinmitigatingurbanheatislandinatropicalcity, OkeTR1976Thedistinctionbetweencanopyand
SingaporeUrbanClim.1659–74 boundary-layerurbanheatislandsAtmosphere
LinBSandLinCT2016Preliminarystudyoftheinfluenceofthe 14268–77
spatialarrangementofurbanparksonlocaltemperature OkeTR1982TheenergeticbasisoftheurbanheatislandQ.J.R.
reductionUrbanFor.UrbanGreening20348–57 Meteorol.Soc.1081–24
LoughnerCP,AllenDJ,ZhangDL,PickeringKE,DickersonRR OkeTR1989ThemicrometeorologyoftheurbanforestPhil.
andLandryL2012Rolesofurbantreecanopyandbuildings Trans.R.Soc.B324335–49
inurbanheatislandeffects:parameterizationand OkeTR2006Instrumentsandobservingmethods:reportNo.81:
preliminaryresultsJ.Appl.Meteorol.Climatol. initialguidancetoobtainrepresentativemeteorological
511775–93 observationsaturbansitesWorldMeteorological
MaH,ShaoHandSongJ2014Modelingtherelativerolesofthe Organization,WMO/TD(1250)
foehnwindandurbanexpansioninthe2002Beijingheat OlesonKW,BonanGBandFeddemaJ2010Effectsofwhite
waveandpossiblemitigationbyhighreflectiveroofs roofsonurbantemperatureinaglobalclimatemodel
Meteorol.Atmos.Phys.123105–14 Geophys.Res.Lett.37
MakropoulouM2017Microclimateimprovementofinner-city PiselloAL,SaliariM,VasilakopoulouK,HadadSand
urbanareasinaMediterraneanCoastalCitySustainability SantamourisM2018Facingtheurbanoverheating:recent
9882 developments.Mitigationpotentialandsensitivityofthe
MartilliA2002Numericalstudyofurbanimpactonboundary maintechnologiesWileyInterdiscip.Rev.EnergyEnviron.
layerstructure:sensitivitytowindspeed,urban 7e294
morphology,andruralsoilmoistureJ.Appl.Meteorol. RazzaghmaneshM,BeechamSandSalemiT2016Theroleof
411247–66 greenroofsinmitigatingUrbanHeatIslandeffectsinthe
MartilliA,ClappierAandRotachMW2002Anurbansurface metropolitanareaofAdelaide,SouthAustraliaUrbanFor.
exchangeparameterisationformesoscalemodels UrbanGreening1589–102
Bound.-LayerMeteorol.104261–304 RosadoPJ,FaulknerD,SullivanDPandLevinsonR2014
MartilliA,KrayenhoffESandNazarianN2020Istheurbanheat Measuredtemperaturereductionsandenergysavingsfroma
Islandintensityrelevantforheatmitigationstudies?Urban cooltileroofonacentralCaliforniahomeEnergyBuild.
Clim.31100541 8057–71
MassonV2000Aphysically-basedschemefortheurbanenergy RosenfeldAH,AkbariH,BretzS,FishmanBL,KurnDM,
budgetinatmosphericmodelsBound.-LayerMeteorol. SailorDandTahaH1995Mitigationofurbanheatislands:
94357–97 materials,utilityprograms,updatesEnergyBuild.
MiddelA,ChhetriNandQuayR2015Urbanforestryandcool 22255–65
roofs:assessmentofheatmitigationstrategiesinPhoenix RosenzweigC,SoleckiWD,ParshallL,LynnB,CoxJ,GoldbergR
residentialneighborhoodsUrbanFor.UrbanGreening andDunstanF2009MitigatingNewYorkCity’sheatisland:
14178–86 integratingstakeholderperspectivesandscientific
MiddelA,HäbK,BrazelAJ,MartinCAandGuhathakurtaS evaluationBull.Am.Meteorol.Soc.901297–312
2014Impactofurbanformanddesignonmid-afternoon RosenzweigC,SoleckiW,Romero-LankaoP,MehrotraS,
microclimateinphoenixlocalclimatezonesLandsc.Urban DhakalS,BowmanTandAliIbrahimS2015ARC3.2
Plan.12216–28 summaryforcityleadersClimateChangeandCities:Second
MiddelAandKrayenhoffES2019Micrometeorological AssessmentReportoftheUrbanClimateChangeResearch
determinantsofpedestrianthermalexposureduring NetworkedCRosenzweig,WSolecki,PRomero-Lankao,
record-breakingheatinTempe,Arizona:introducingthe SMehrotra,SDhakalandSAliIbrahim(Cambridge:
MaRTyobservationalplatformSci.TotalEnviron. CambridgeUniversityPress)
687137–51 RotachMW,VogtR,BernhoferC,BatchvarovaE,ChristenA,
MiddelA,TurnerVK,SchneiderFA,ZhangYandStillerM2020 ClappierAandMitevV2005BUBBLE—anurban
Solarreflectivepavement—apolicypanaceatoheat boundarylayermeteorologyprojectTheor.Appl.Climatol.
mitigation?Environ.Res.Lett.15064016 81231–61
27

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
RothMandLimVH2017Evaluationofcanopy-layerairand Shashua-BarL,PearlmutterDandErellE2011Theinfluenceof
meanradianttemperaturesimulationsbyamicroclimate treesandgrassonoutdoorthermalcomfortinahot-arid
modeloveratropicalresidentialneighbourhoodBuild. environmentInt.J.Climatol.311498–506
Environ.112177–89 Shashua-BarL,PotchterO,BitanA,BoltanskyDandYaakovY
RyuYHandBaikJJ2012Quantitativeanalysisoffactors 2010Microclimatemodellingofstreettreespecieseffects
contributingtourbanheatislandintensityJ.Appl.Meteorol. withinthevariedurbanmorphologyintheMediterranean
Climatol.51842–54 cityofTelAviv,IsraelInt.J.Climatol.3044–57
RyuYH,Bou-ZeidE,WangZHandSmithJA2016Realistic SkamarockWC,KlempJB,DudhiaJ,GillDO,BarkerDM,
representationoftreesinanurbancanopymodel WangWandPowersJG2005Adescriptionoftheadvanced
Bound.-LayerMeteorol.159193–220 researchWRFversion2(No.NCAR/TN-468+STR)
SailorD,ShepherdM,SheridanS,StoneB,KalksteinL,RussellA, (Boulder,CO:NationalCenterForAtmosphericResearch)
VargoJandAndersenT2016Improvingheat-relatedhealth SkelhornC,LindleySandLevermoreG2014Theimpactof
outcomesinanurbanenvironmentwithscience-based vegetationtypesonairandsurfacetemperaturesina
policySustainability81015 temperatecity:afinescaleassessmentinManchester,UK
SalamancaF,GeorgescuM,MahalovA,MoustaouiMand Landsc.UrbanPlan.121129–40
MartilliA2016Citywideimpactsofcoolroofandrooftop SnirK,PearlmutterDandErellE2016Themoderatingeffectof
solarphotovoltaicdeploymentonnear-surfaceair water-efficientgroundcovervegetationonpedestrian
temperatureandcoolingenergydemandBound.-Layer thermalstressLandsc.UrbanPlan.1521–12
Meteorol.161203–21 SteeneveldGJ,KoopmansS,HeusinkveldBGandTheeuwesNE
SalamancaF,MartilliA,TewariMandChenF2011Astudyofthe 2014Refreshingtheroleofopenwatersurfaceson
urbanboundarylayerusingdifferenturban mitigatingthemaximumurbanheatislandeffectLandsc.
parameterizationsandhigh-resolutionurbancanopy UrbanPlan.12192–96
parameterswithWRFJ.Appl.Meteorol.Climatol. SteinUandAlpertP1993Factorseparationinnumerical
501107–28 simulationsJ.Atmos.Sci.502107–15
SalamancaF,ZhangY,BarlageM,ChenF,MahalovAandMiaoS StewartID2011Asystematicreviewandscientificcritiqueof
2018EvaluationoftheWRF-urbanmodelingsystem methodologyinmodernurbanheatislandliteratureInt.J.
coupledtoNoahandNoah-MPlandsurfacemodelsovera Climatol.31200–17
semiaridurbanenvironmentJ.Geophys.Res.Atmos. StewartIDandOkeTR2012Localclimatezonesforurban
1232387–408 temperaturestudiesBull.Am.Meteorol.Soc.931879–900
SalataF,GolasiI,PetittiD,deLietoVollaroE,CoppiMandde SunT,GrimmondCSBandNiGH2016Howdogreenroofs
LietoVollaroA2017Relatingmicroclimate,humanthermal mitigateurbanthermalstressunderheatwaves?J.Geophys.
comfortandhealthduringheatwaves:ananalysisofheat Res.Atmos.1215320–35
islandmitigationstrategiesthroughacasestudyinanurban TahaH1997Modelingtheimpactsoflarge-scalealbedochanges
outdoorenvironmentSustain.CitiesSoc.3079–96 onozoneairqualityintheSouthCoastAirBasinAtmos.
SantamourisM2014Coolingthecities–areviewofreflectiveand Environ.311667–76
greenroofmitigationtechnologiestofightheatislandand TahaH,AkbariH,RosenfeldAandHuangJ1988Residential
improvecomfortinurbanenvironmentsSol.Energy coolingloadsandtheurbanheatisland—theeffectsof
103682–703 albedoBuild.Environ.23271–83
SantamourisM,DingL,FioritoF,OldfieldP,OsmondP, TaleghaniM,SailorDandBan-WeissGA2016
PaoliniR,PrasadDandSynnefaA2017Passiveandactive Micrometeorologicalsimulationstopredicttheimpactsof
coolingfortheoutdoorbuiltenvironment–Analysisand heatmitigationstrategiesonpedestrianthermalcomfortin
assessmentofthecoolingpotentialofmitigation aLosAngelesneighborhoodEnviron.Res.Lett.11024003
technologiesusingperformancedatafrom220largescale TheeuwesNE,Solcerov´aAandSteeneveldGJ2013Modelingthe
projectsSol.Energy15414–33 influenceofopenwatersurfacesonthesummertime
SatoY,HiguchiA,TakamiA,MurakamiA,MasutomiY, temperatureandthermalcomfortinthecityJ.Geophys.Res.
TsuchiyaK,GotoDandNakajimaT2016Regional Atmos.1188881–96
variabilityintheimpactsoffuturelanduseonsummertime ToparlarY,BlockenB,MaiheuBVandvanHeijstGJF2018The
temperaturesinKantoregion,theJapanesemegacityUrban effectofanurbanparkonthemicroclimateinitsvicinity:a
For.UrbanGreening2043–55 casestudyforAntwerp,BelgiumInt.J.Climatol.38e303–22
ScherbaA,SailorDJ,RosenstielTNandWamserCC2011 ToparlarY,BlockenB,MaiheuBandVanHeijstGJF2017A
Modelingimpactsofroofreflectivity,integrated reviewontheCFDanalysisofurbanmicroclimateRenew.
photovoltaicpanelsandgreenroofsystemsonsensible Sustain.EnergyRev.801613–40
heatfluxintotheurbanenvironmentBuild.Environ. TsokaS,TheodosiouT,TsikaloudakiKandFlourentzouF2018a
462542–51 Modelingtheperformanceofcoolpavementsandtheeffect
SchrijversP,JonkerH,deRoodeSandKenjerešS2016Theeffect oftheiragingonoutdoorsurfaceandairtemperatures
ofusingahigh-albedomaterialontheuniversal Sustain.CitiesSoc.42276–88
temperatureclimateindexwithinastreetcanyonUrban TsokaS,TsikaloudakiAandTheodosiouT2018bAnalyzingthe
Clim.17284–303 ENVI-metmicroclimatemodel’sperformanceandassessing
SchubertSandGrossman-ClarkeS2013Theinfluenceofgreen coolmaterialsandurbanvegetationapplications–areview
areasandroofalbedosonairtemperaturesduringextreme Sustain.CitiesSoc.4355–76
heateventsinBerlin,GermanyMeteorol.Z.22131–43 VahmaniPandBan-WeissG2016Climaticconsequencesof
ShahidanMF,JonesPJ,GwilliamJandSallehE2012An adoptingdrought-tolerantvegetationoverLosAngelesasa
evaluationofoutdoorandbuildingenvironmentcooling responsetoCaliforniadroughtGeophys.Res.Lett.438240–9
achievedthroughcombinationmodificationoftreeswith VahmaniPandHogueTS2015Urbanirrigationeffectson
groundmaterialsBuild.Environ.58245–57 WRF-UCMsummertimeforecastskillovertheLosAngeles
Shashua-BarLandHoffmanME2000Vegetationasaclimatic metropolitanareaJ.Geophys.Res.Atmos.1209869–81
componentinthedesignofanurbanstreet:anempirical VahmaniP,SunF,HallAandBan-WeissG2016Investigatingthe
modelforpredictingthecoolingeffectofurbangreenareas climateimpactsofurbanizationandthepotentialforcool
withtreesEnergyBuild.31221–35 roofstocounterfutureclimatechangeinSouthern
Shashua-BarL,PearlmutterDandErellE2009Thecooling CaliforniaEnviron.Res.Lett.11124027
efficiencyofurbanlandscapestrategiesinahotdryclimate ValielaI2001DoingScience:Design,Analysis,andCommunication
Landsc.UrbanPlan.92179–86 ofScientificResearch(Oxford:OxfordUniversityPress)
28

Environ.Res.Lett.16(2021)053007 ESKrayenhoffetal
WangY,BerardiUandAkbariH2016Comparingtheeffectsof islands:amulti-scalemodelingcasestudyinPhoenixBuild.
urbanheatislandmitigationstrategiesforToronto,Canada Environ.108110–21
EnergyBuild.1142–19 YangSRandLinTP2016Anintegratedoutdoorspacesdesign
WillmottCJ1982Somecommentsontheevaluationofmodel proceduretorelieveheatstressinhotandhumidregions
performanceBull.Am.Meteorol.Soc.631309–13 Build.Environ.99149–60
WillmottCJandMatsuuraK1995Smartinterpolationof ZhangJ,LiY,TaoW,LiuJ,LevinsonR,MoheghAand
annuallyaveragedairtemperatureintheUnitedStatesJ. Ban-WeissG2019Investigatingtheurbanairqualityeffects
Appl.Meteorol.342577–86 ofcoolwallsandcoolroofsinSouthernCaliforniaEnviron.
YaghoobianNandKleisslJ2012Effectofreflectivepavementson Sci.Technol.537532–42
buildingenergyuseUrbanClim.225–42 ZhaoL,OlesonK,Bou-ZeidE,KrayenhoffES,BrayA,ZhuQ,
YaghoobianN,KleisslJandKrayenhoffES2010Modelingthe ZhengZ,ChenCandOppenheimerM2021Global
thermaleffectsofartificialturfontheurbanenvironmentJ. multi-modelprojectionsoflocalurbanclimatesNat.Clim.
Appl.Meteorol.Climatol.49332–45 Change(https://doi.org/10.1038/s41558-020-00958-8)
YangJandBou-ZeidE2018Shouldcitiesembracetheirheat ZhouX,OokaR,ChenH,KawamotoYandKikumotoH2016
islandsasshieldsfromextremecold?J.Appl.Meteorol. impactsofinlandwaterareachangesonthelocalclimateof
Climatol.571309–20 Wuhan,ChinaIndoorBuiltEnviron.25296–313
YangJ,LiuH,SunJ,ZhuY,WangX,XiongZandJiangW2015 ZhouYandShepherdJM2010Atlanta’surbanheatislandunder
Furtherdevelopmentoftheregionalboundarylayer extremeheatconditionsandpotentialmitigationstrategies
modeltostudytheimpactsofgreeneryontheurban Nat.Hazards52639–68
thermalenvironmentJ.Appl.Meteorol.Climatol. ZiterCD,PedersenEJ,KucharikCJandTurnerMG2019
54137–52 Scale-dependentinteractionsbetweentreecanopycoverand
YangJ,WangZH,KaloushKEandDyllaH2016Effectof impervioussurfacesreducedaytimeurbanheatduring
pavementthermalpropertiesonmitigatingurbanheat summerProc.NatlAcad.Sci.1167575–80
29
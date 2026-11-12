Geosci.ModelDev.,19,7389–7413,2026
https://doi.org/10.5194/gmd-19-7389-2026
©Author(s)2026.Thisworkisdistributedunder
theCreativeCommonsAttribution4.0License.
Model
description
paper
GLIDE-SOL: a GPU-accelerated global lightweight infrastructure
for diagnostic environmental modeling with SOLWEIG
AndreaZonato1,HarshG.Kamath2,NaveenSudharsan2,LucaMonaco1,JonasKittner3,LuiseWolf3,
MatthiasDemuzere4,5,ArianeMiddel6,7,BenjaminBechtel3,andMassimoMilelli1
1CIMAResearchFoundation,Savona,Italy
2JacksonSchoolofGeosciences,UniversityofTexasatAustin,Austin,TX,USA
3BochumUrbanClimateLab,RuhrUniversityBochum,Bochum,Germany
4B-KodeVOF,Ghent,Belgium
5GlobalFacilityforDisasterReductionandRecovery,WorldBankGroup,Washington,DC,USA
6TheGAMESchool,ArizonaStateUniversity,Tempe,AZ,USA
7SchoolofGeographicalSciencesandUrbanPlanning,ArizonaStateUniversity,Tempe,AZ,USA
Correspondence:AndreaZonato(andrea.zonato@cimafoundation.org)
Received:9February2026–Discussionstarted:17April2026
Revised:29July2026–Accepted:1August2026–Published:11August2026
Abstract. GLIDE-SOL is a fully scripted and globally re- serve radiative consistency across tile boundaries, enabling
deployablePythonworkflowthatoperationalizesSOLWEIG meter-scalesimulationsovertenstohundredsofsquarekilo-
forrapidandrepeatablethermal-comfortmappingacrossdi- meterswithoutsacrificingreproducibility.Dailyoutputs(24
verseurbanenvironments.GLIDE-SOLisbuiltontheSOL- radiativeandmeteorologicalfields)arestoredascompressed
WEIGradiativebalancelibraries,butrewritesthesurround- GeoTIFFs to reduce disk usage and accelerate downstream
ingsystem–includingautomatedinputgeneration,theexe- processing.
cutionengine,andpost-processing–sothatthemodelcanbe GLIDE-SOL is implemented through three reproducible
drivenbygloballyavailabledatasetsandexecutedefficiently components: an automated global-input generator; a SOL-
on GPUs. All inputs (terrain, building morphology, canopy WEIGexecutionenginewithcoordinatedtiling;andapost-
height, land cover, and meteorology) are automatically de- processing module for systematic sampling, time-series ex-
rived from global products, eliminating local preprocessing traction, and visualization. An operational demonstration in
while enabling consistent applications from neighborhood- Dortmund, using hourly measurements from 25 urban and
scale analyses to city-wide and multi-city experiments. In peri-urban stations and simulations run at 2m grid spac-
addition,GLIDE-SOLintroduceslightweightphysicaldiag- ing between August 2024 and December 2025, shows that
nostics to improve realism when driven by coarse meteo- incorporating wind attenuation and the diagnostic tempera-
rological forcing, targeting key urban controls on wind and ture corrections substantially improves UTCI performance
near-surfacetemperature. (RMSE reduced from 8.09 to 2.84°C), alongside improve-
The workflow incorporates two physical augmentations: mentsinT ,airtemperature,andwindspeedsimulations.
mrt
(i) roughness- and obstacle-based directional wind attenua- By integrating harmonized global inputs with physics-
tion to approximate near-surface ventilation; and (ii) diag- based diagnostics, GPU acceleration, and scalable tiling,
nostictemperatureadjustmentsthatcombineasimpleurban GLIDE-SOLsupportsapplicationssuchasoperationalUTCI
heat island (UHI) cycle with an elevation-based correction nowcasting,retrospectiveandclimatologicalanalysesofheat
using high-resolution DEM information, to better capture stress, sensitivity tests of urban morphology and greening
nocturnalwarmingandlocallapse-rateeffects. strategies, and coordinated multi-city experiments requiring
Toscaletolargemetropolitanareas,GLIDE-SOLusesex- consistentmodelingprotocols.
plicit domain tiling with cross-tile synchronization to pre-
PublishedbyCopernicusPublicationsonbehalfoftheEuropeanGeosciencesUnion.

7390 A.Zonatoetal.:GLIDE-SOL
1 Introduction els, building land cover, footprints and heights, vegetation
structure,andrepresentativemeteorologicalforcing(Jänicke
Fastandtransferableurbanthermal-comfortmodelingisin- et al., 2016; Zonato et al., 2020). These inputs are of-
creasingly required for climate-adaptation planning, oper- ten derived from local LiDAR campaigns, city-specific GIS
ational heat warnings, and systematic inter- and intra-city databases, or bespoke classifications, which are not uni-
assessments. Exposure to urban heat stress is shaped by formlyavailableacrossregions.Second,microscaleradiative
large-scale atmospheric conditions and fine-scale variations models can be computationally demanding when applied at
in radiation,wind, urban form,and surface cover,with pro- meter-scaleresolutionoverlargeurbandomainsorlongsim-
nounceddifferencesbetweenneighborhoods,streetcanyons, ulation periods (Toparlar et al., 2017; Briegel et al., 2024).
and open spaces (Emmanuel and Fernando, 2007; Mayer Third,near-surfacewindisfrequentlyprescribedfromsingle
et al., 2008). Urban heat islands, particularly at night, and meteorological stations or coarse reanalyses that do not ex-
uneven daytime exposure to high radiant loads and locally plicitlyaccountforbuilding-inducedshelteringandchannel-
reduced wind speeds contribute to elevated heat-stress risk ing, even though wind strongly modulates thermal comfort
(Oke et al., 2017). Radiant load, often expressed through (Cionco,1972;ChuandWang,2025).CFDmodelssuchas
meanradianttemperature(T ),isacrucialmeteorological ENVI-metandPALM-4Ucanresolvepedestrian-levelwind
mrt
driverofhumanenergybalanceandthermalcomfortduring andtemperaturefields(Simon,2016;Marongaetal.,2020),
warm, clear conditions (Mayer and Höppe, 1987; Thorsson but their computational cost generally restricts their use to
etal.,2007).T isakeyinputtobio-climaticindicessuch micro-scaledomainsorlimitedsimulationperiods.
mrt
asthePhysiologicalEquivalentTemperature(PET)andUni- In parallel, global geospatial and meteorological datasets
versal Thermal Climate Index (UTCI) (Höppe, 1999; Fiala haveadvancedtothepointwheretheycanserveasacommon
et al., 2012; Jendritzky et al., 2012), which combine radia- input backbone for urban climate applications. ESA World-
tion,airtemperature,humidity,andwindspeedintoasingle Cover provides 10m global land-cover classes suitable for
thermal-stressmetric(Chengetal.,2012). distinguishing major urban and vegetated surfaces (Zanaga
T arisesfromthenetshortwaveandlong-waveradiation et al., 2022). On the terrain side, MERIT DEM (Yamazaki
mrt
fluxesfromallsurroundingsurfacesandthesky.Whileintra- etal.,2017)offersharmonizedglobalelevationinformation
urbanair-temperaturedifferencesareoftenmodestduringthe at3arcsec(∼90m)resolution,formingaconsistentbasisfor
day,T canexhibitstrongspatialvariabilityoverdistances topographicinputs.
mrt
of only a few meters (Lindberg and Grimmond, 2011a, b; Complementingtheseterrain-onlyproducts,anewgener-
Thorssonetal.,2011;MiddelandKrayenhoff,2019).These ationofopenbuildingdatasetshasemerged,providingboth
microscale variations are primarily driven by shadow pat- footprintsand3Dattributesessentialforurbanclimatemod-
terns created by buildings, trees, and topography, as well eling.Microsoftglobalbuildingfootprints(Microsoft,2026),
as by differences in surface radiative and thermal proper- Overture Mapsbuilding footprints (OvertureMaps Founda-
ties such as albedo, emissivity, and heat capacity (Thorsson tion, 2026), and GlobalBuildingAtlas LoD1 buildings (Zhu
et al., 2007; Konarska et al., 2014; Lindberg et al., 2016). etal.,2025)provideapracticalmulti-sourcebasisforassem-
The SOLWEIG (SOlar and LongWave Environmental Irra- bling building footprints across regions with very different
diance Geometry) (Lindberg et al., 2008) model is widely input-data availability. Building-height attribution can then
used to estimate T and related thermal-comfort indices be supported by products such as GlobalBuildingAtlas and
mrt
in complex urban environments. It resolves shortwave and OpenBuildingMap(Oostwegeletal.,2025).
longwave radiation fluxes inthree dimensions and has been Atthesametime,globalcanopy-heightproductshavealso
applied to analyze the influence of urban geometry, ground maturedrapidly:very-high-resolution(1m)tree-heightmaps
surfaces,andvegetationonoutdoorthermalcomfortinava- derived from self-supervised deep learning trained on air-
riety of climates, and validated against ground observations borne LiDAR (Tolan et al., 2024), the global canopy height
(Lindberg and Grimmond, 2011a, b; Briegel et al., 2024; model by Lang et al. (2023) at 10m resolution, and the
Buo et al., 2023). SOLWEIG is also integrated in the Ur- GEDI-based Canopy Height Mapper (Potapov et al., 2021),
banMulti-scaleEnvironmentalPredictor(UMEP)(Lindberg which delivers canopy heights at 30m resolution through
etal.,2018),whichprovidesaQGIS-basedenvironmentfor a Google Earth Engine workflow, collectively provide con-
linkingurban-climatemodelswithgeospatialdatatosupport sistent estimates of vegetation height and distribution. To-
climate services, heat-risk assessments, and planning appli- gether, these resources supply a coherent global basis for
cations. Despite its strong theoretical foundation and broad representingnotonlyterrainandbuildingsbutalsothethree-
adoptionincasestudies,SOLWEIGhasnotyetmaturedinto dimensionaldistributionofurbanandperi-urbanvegetation.
agloballyoperationaltool. In dense urban settings, however, narrow streets, building
Several persistent barriers limit the wider deployment of shadows,andmixedpixelscanstillaffectcanopydetection.
SOLWEIGforcity-wideormulti-cityapplications.First,re- The resulting tree layer is therefore used here as a glob-
alistic setups typically require detailed, locally assembled ally consistent approximation of urban vegetation structure,
input data: high-resolution digital elevation/surface mod-
Geosci.ModelDev.,19,7389–7413,2026 https://doi.org/10.5194/gmd-19-7389-2026

A.Zonatoetal.:GLIDE-SOL 7391
while local mapping errors are treated as part of the input- tical reference point for the GPU-oriented design choices
datauncertainty. adoptedinGLIDE-SOL.
On the meteorological side, the ERA5 reanalysis pro- The goal of GLIDE-SOL (Global Lightweight Infras-
vides globally consistent, hourly atmospheric fields (Hers- tructure for Diagnostic Environmental modeling with SOL-
bachetal.,2020).However,itscoarseresolutioninherently WEIG) is to transform SOLWEIG from a case-specific re-
limitstherepresentationofmesoscaleand,especially,urban- search tool into a reproducible, globally deployable work-
scaleprocesses:evenwhendynamicallydown-scaled,ERA5 flow. GLIDE-SOL rests on three pillars. First, all required
tends to smooth local thermal gradients and fails to cap- input data are obtained from globally or regionally avail-
ture city-specific features and extreme conditions (Adinolfi able datasets – including ESA WorldCover (Zanaga et al.,
etal.,2023).PlatformssuchasGoogleEarthEngineenable 2022),MERITDEM(Yamazakietal.,2017),GlobalBuildin-
planetary-scale access and processing of these datasets in a gAtlas (Zhu et al., 2025), and ERA5 accessed and pro-
reproducible,scriptablemanner(Gorelicketal.,2017). cessedviaGoogleEarthEngine(Gorelicketal.,2017;Hers-
Recent studies demonstrate that city-wide, building- bach et al., 2020) – and automatically transformed into
resolving thermal-comfort mapping with SOLWEIG and SOLWEIG-readyrasters.Second,GLIDE-SOLincorporates
UMEP is now feasible using scripted workflows. Jänicke diagnosticphysicalmodulesdesignedtocompensateforlim-
etal.(2016)performedacity-wideanalysisofT atbuild- itations of coarse meteorological forcing in urban settings:
mrt
ing resolution, while more recent work has produced high- aRöckle-styledirectionalwind-attenuationscheme(Röckle,
resolutionthermalexposureandshademapstosupportcool- 1990;Bernardetal.,2023)andasimpleurbanheatislandad-
corridor planning (Buo et al., 2023). A key recent example justmentinformedbyurban-climatetheory(Theeuwesetal.,
isthestudybyLindbergetal.(2025),whoappliedUMEP– 2016). Third, GLIDE-SOL targets scalability and computa-
SOLWEIGat2mresolutionacrossStockholm,Gothenburg, tional efficiency through GPU-accelerated radiative geome-
and Malmö to quantify how building density, tree fraction, try and explicit domain tiling. Entire cities, including large
and ground cover shape PET, UTCI, T , and pedestrian metropolitanareasspanningtenstohundredsofsquarekilo-
mrt
windspeedduringheatwaves. meters,canthusbesimulatedatmeter-scaleresolution,with
At the same time, GPU-based approaches to urban heat daily outputs stored as compressed GeoTIFFs for efficient
mappinghaveshownthatlarge-domain,high-resolutionsim- downstreamanalysis.
ulationscanbesubstantiallyaccelerated.LiandWang(2021) Inthispaper,wedocumenttheGLIDE-SOLworkflowand
report over 99% speed-up in computing city-scale heat- demonstrate its capabilities in Dortmund, Germany, using a
exposure metrics from high-resolution surface data. Yang denseobservationalnetworkof25urbanandperi-urbansta-
et al. (2023) achieve near–real-time urban LES using a tionsbetweenAugust2024andDecember2025.Simulations
multi-GPUframeworkthatpreservesbuilding-resolvingde- areconductedat2mgridspacingoverthefullmetropolitan
tail.Similarly,themulti-scaleCity-LESv2.0model(Kusaka area.Wefirstdescribetheautomatedpre-processingpipeline
et al., 2024) exploits GPU clusters to efficiently couple and its use of global datasets, then outline the SOLWEIG
mesoscale and microscale LES, enabling long-duration, configuration,diagnosticwindandUrbanHeatIsland(UHI)
building-explicitsimulationswithfullradiativecalculations. modules,andGPUtilingstrategy,andfinallypresentaneval-
Likewise,Lietal.(2024)employsGPU-acceleratedcompu- uationofhourlyUTCI,T ,airtemperature,andwindspeed
mrt
tationtoassessheatsensitivityandvulnerabilityacrossmajor againstobservations.Beyondreportingskillmetrics,wedis-
U.S.cities,demonstratingthatlarge-scaleexposureanalyses cussoperationalaspectssuchaswall-clocktimeandmemory
cannowbecarriedoutwithoperationallyfeasibleruntimes. usage, and consider how a global-input, SOLWEIG-based
In addition, recent open-source work has demonstrated workflow can support operational heat-risk assessment, cli-
how the core SOLWEIG radiative-geometry and time- matologicalanalysis,urban-planningevaluation,andcoordi-
stepping calculations can be refactored for GPU execution. natedmulti-citymodelingexperiments.
SOLWEIG-GPUprovidesaPythonimplementationthatruns
SOLWEIG (v2022a) on GPUs via a simple API, CLI, or
GUI, and targets meter-scale, city-scale domains by com- 2 Materialsandmethods
bining domain tiling with GPU-parallelized computation of
SVF, T , shadows, and UTCI (while wall height and wall This section presents the end-to-end methodology of the
mrt
aspect remain CPU-side and are parallelized across cores) GLIDE-SOL framework. We first describe the SOLWEIG
(Kamathetal.,2026). Preprocessor,whichautomaticallybuildsaco-registeredspa-
Reported benchmarks show substantial acceleration for tial input stack (rasters and vectors) and harmonizes ERA5
theSVF+UTCIcore:fortilesizesof1000×1000,1500× meteorological forcing into SOLWEIG-ready formats. We
1500, and 2000×2000 cells, runtimes decrease from 1187, thenoutlinetheGPU-acceleratedexecutionstrategy,includ-
3322,and6487sonaCPUworkstationto47,105,and158s ingtiling,memorymanagement,andCPU/GPUresponsibil-
onanNVIDIAA6000GPU,correspondingtoapproximately ities for scalable hourly simulations. Finally, we detail the
25×,32×,and41×speed-ups.Thisworkservedasaprac- additionalphysicalparameterizationsintroducedinthiswork
https://doi.org/10.5194/gmd-19-7389-2026 Geosci.ModelDev.,19,7389–7413,2026

| 7392 |     |     |     |     |     |     |     |     |     |     | A.Zonatoetal.:GLIDE-SOL |     |     |     |
| ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------------------- | --- | --- | --- |
(diagnosticUHIcycle,elevationbiascorrection,andwindre- 2.2 AutomatedinputswithSOLWEIGPreprocessor
| duction | coefficients) | that | improve | realism |     | while | preserving |     |     |     |     |     |     |     |
| ------- | ------------- | ---- | ------- | ------- | --- | ----- | ---------- | --- | --- | --- | --- | --- | --- | --- |
a fully reproducible, script-driven workflow based on glob- The input builder assembles a reproducible stack of rasters
allyavailabledatasourcesandstandardizedprocessingsteps. and vectors from a latitude/longitude seed, relying on glob-
Figure1providesanoverviewofthecompletepipeline. ally accessible sources. The emphasis is to avoid bespoke
digitizationandtokeepdecisionstransparentandscriptable:
2.1 OverviewoftheSOLWEIGcore
|     |     |     |     |     |     |     |     | – Grid and | Coordinate | Reference |     | System | (CRS): | starting |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ---------- | --------- | --- | ------ | ------ | -------- |
SOLWEIG(SOlarandLongWaveEnvironmentalIrradiance from a target latitude–longitude pair, the script auto-
Geometry) is a three-dimensional radiative model devel- matically selects the appropriate UTM zone, builds a
opedtoestimatemeanradianttemperature(T mrt )andrelated geographic bounding box, and defines a regular met-
thermal-comfortquantitiesfromurbangeometry,vegetation, ric grid (square pixels). All subsequent rasters (land
cover,DEM,trees,buildings,windcoefficients)arere-
sunposition,andnear-surfacemeteorologicalforcing(Lind-
berg et al., 2008; Lindberg and Grimmond, 2011a, b; Lind- projectedandresampledontothiscommongrid,sothat
bergetal.,2018;Wallenbergetal.,2020,2023).Ateachtime masking, sampling, and spatial statistics are perfectly
| step,themodelcombinesdirect,diffuse,andreflectedshort- |     |               |     |          |      |      |         | co-registered. |     |     |     |     |     |     |
| ------------------------------------------------------ | --- | ------------- | --- | -------- | ---- | ---- | ------- | -------------- | --- | --- | --- | --- | --- | --- |
| wave radiation                                         |     | with longwave |     | exchange | from | sky, | ground, |                |     |     |     |     |     |     |
– Landcover,WorldCoverreclassification,andelevation:
| walls, and  | vegetation | to            | resolve | the        | radiative | environment |         |            |           |     |            |     |      |           |
| ----------- | ---------- | ------------- | ------- | ---------- | --------- | ----------- | ------- | ---------- | --------- | --- | ---------- | --- | ---- | --------- |
|             |            |               |         |            |           |             |         | the script | downloads | ESA | WorldCover |     | 2020 | version 2 |
| experienced | by         | a pedestrian, |         | from which |           | T and       | derived |            |           |     |            |     |      |           |
mrt
indicessuchasUTCIcanbecomputed.Thisrepresentation (Zanagaetal.,2022)forthestudyareaandreclassifies
|     |     |     |     |     |     |     |     | it into a | small set | of land-use |     | classes | tailored | to SOL- |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | --------- | ----------- | --- | ------- | -------- | ------- |
hasbeenwidelyusedinurban-climateandoutdoor-comfort
WEIG:
studies,includingintercomparisonswithothermicroclimate
| models | and evaluations |     | against | observations |     | (Aydin | et al., |     |     |     |     |     |     |     |
| ------ | --------------- | --- | ------- | ------------ | --- | ------ | ------- | --- | --- | --- | --- | --- | --- | --- |
1. urban(WorldCovercode50),
2019;Briegeletal.,2024).
InGLIDE-SOL,thislogicispreservedbutorganizedinto 2. vegetation(defaultclassforallothercodes),
an explicit, GPU-oriented execution sequence. The solver 3. water(WorldCovercodes80,70,90),
loadsthestaticmorphologylayers(Building_DSM,DEM,
Trees, Landuse, Walls, and Aspect), computes to- 4. bare&sand(WorldCovercode60).
| tal and directional |            | sky-view | factors |     | (SVF),   | evaluates | build- |                  |            |           |       |                 |           |        |
| ------------------- | ---------- | -------- | ------- | --- | -------- | --------- | ------ | ---------------- | ---------- | --------- | ----- | --------------- | --------- | ------ |
|                     |            |          |         |     |          |           |        | The reclassified |            | raster is | saved | as Landuse.tif. |           | In     |
| ing and             | vegetation | shadow   | masks,  |     | and then | advances  | the    |                  |            |           |       |                 |           |        |
|                     |            |          |         |     |          |           |        | parallel,        | the script | downloads |       | and clips       | a digital | eleva- |
hourlySOLWEIGradiationbalanceoneachtilebeforecom-
tionmodel(DEM),usingahigh-resolutionglobalprod-
| puting T | , air | temperature |     | adjustments, |     | wind speed, | and |                                            |     |     |     |     |     |     |
| -------- | ----- | ----------- | --- | ------------ | --- | ----------- | --- | ------------------------------------------ | --- | --- | --- | --- | --- | --- |
|          | mrt   |             |     |              |     |             |     | uctsuchasMERITDEM(Yamazakietal.,2017,90m), |     |     |     |     |     |     |
UTCI.ThisimplementationmirrorsthestandardSOLWEIG
|     |     |     |     |     |     |     |     | and resamples | it  | to the | same | grid | as DEM.tif. | The |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- | ------ | ---- | ---- | ----------- | --- |
radiativestructurewhileexposingthegeometryandradiation
|     |     |     |     |     |     |     |     | DEM is | later used | to apply | an  | elevation-based |     | correc- |
| --- | --- | --- | --- | --- | --- | --- | --- | ------ | ---------- | -------- | --- | --------------- | --- | ------- |
termsneededfortiledGPUexecutioninGLIDE-SOL.
tiontoERA52mairtemperature(Sect.2.4.2).
| For the  | Dortmund  | experiments |      | we              | used | the SOLWEIG |         |         |           |         |              |     |      |          |
| -------- | --------- | ----------- | ---- | --------------- | ---- | ----------- | ------- | ------- | --------- | ------- | ------------ | --- | ---- | -------- |
| v2022a   | radiative | core        | with | the anisotropic |      | sky         | schemes |         |           |         |              |     |      |          |
|          |           |             |      |                 |      |             |         | – Urban | form: the | current | preprocessor |     | uses | a multi- |
| for both | diffuse   | shortwave   |      | and longwave    |      | radiation.  | Dif-    |         |           |         |              |     |      |          |
sourcebuildingworkflow.Buildingfootprintscanbeas-
fuseshortwaveradiationisrepresentedwiththePerezetal.
sembledfromaconfigurablepriorityorderofMicrosoft
| (1993) sky-luminance |     | distribution |     | as  | implemented |     | in SOL- |                 |            |     |             |     |        |          |
| -------------------- | --- | ------------ | --- | --- | ----------- | --- | ------- | --------------- | ---------- | --- | ----------- | --- | ------ | -------- |
|                      |     |              |     |     |             |     |         | global building | footprints |     | (Microsoft, |     | 2026), | Overture |
WEIG: instead of assuming an equal diffuse radiance over Maps (Overture Maps Foundation, 2026), and Glob-
| the visible | sky, | the diffuse | component |     | is  | distributed | over |                 |      |     |             |     |              |       |
| ----------- | ---- | ----------- | --------- | --- | --- | ----------- | ---- | --------------- | ---- | --- | ----------- | --- | ------------ | ----- |
|             |      |             |           |     |     |             |      | alBuildingAtlas | (Zhu | et  | al., 2025). |     | The workflow | first |
sky-vaultpatchesaccordingtosolarposition,clearness,and
|     |     |     |     |     |     |     |     | cleans each | source, | builds | a   | non-duplicated |     | footprint |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ------- | ------ | --- | -------------- | --- | --------- |
brightness. This affects the directional shortwave load re- baseline by priority, and then assigns roof heights in-
ceivedbyapedestrian,particularlyinpartlyobstructedurban
dependentlyfromtheavailableheightproducts.Height
canyons.Longwaveirradianceistreatedwiththeanisotropic
|     |     |     |     |     |     |     |     | attribution | is sampled |     | in priority | order | from | Global- |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ---------- | --- | ----------- | ----- | ---- | ------- |
parameterizationintroducedforSOLWEIGv2022a,inwhich
BuildingAtlas(Zhuetal.,2025)andOpenBuildingMap
| sky longwave |     | emission | is also | resolved | over | sky | patches |     |     |     |     |     |     |     |
| ------------ | --- | -------- | ------- | -------- | ---- | --- | ------- | --- | --- | --- | --- | --- | --- | --- |
(Oostwegeletal.,2025);remaininggapsarefilledwith
rather than prescribed as a spatially uniform hemispheric thedomainmedianroofheight,andasmalllowerbound
| term (Wallenberg |     | et al., | 2020, | 2023). | The | human | receiver |     |     |     |     |     |     |     |
| ---------------- | --- | ------- | ----- | ------ | --- | ----- | -------- | --- | --- | --- | --- | --- | --- | --- |
of2misenforcedtoavoidunrealisticallylowbuildings.
| is represented |     | as a cylinder, | consistent |     | with | the SOLWEIG |     |     |     |     |     |     |     |     |
| -------------- | --- | -------------- | ---------- | --- | ---- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
Theresultingfootprintandheightvectorsarerasterized
| configurationusedforpedestrianT |     |     |     | mrt | .   |     |     |     |     |     |     |     |     |     |
| ------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
onthecommongridandstackedwithland-useinforma-
|     |     |     |     |     |     |     |     | tion, yielding | Buildings.tif |     |     | (building |     | footprints) |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------- | ------------- | --- | --- | --------- | --- | ----------- |
andBuilding_DSM.tif,computedasDEM+roof
height.
Geosci.ModelDev.,19,7389–7413,2026 https://doi.org/10.5194/gmd-19-7389-2026

| A.Zonatoetal.:GLIDE-SOL |     |     |     |     |     |     |     | 7393 |
| ----------------------- | --- | --- | --- | --- | --- | --- | --- | ---- |
Figure1.WorkflowoftheGLIDE-SOLframework.
– Trees: a high-resolution tree-canopy DSM is down- clipped to the SOLWEIG domain to avoid artifacts
| loaded via       | Google Earth                   | Engine from   | global   | canopy-   | (Sect.2.4.3).  |                |         |               |
| ---------------- | ------------------------------ | ------------- | -------- | --------- | -------------- | -------------- | ------- | ------------- |
| height products, | trying                         | three sources | in order | of prior- |                |                |         |               |
|                  |                                |               |          |           | – Meteorology: | meteorological | forcing | is harmonized |
| ity: (i) Meta    | Forest Monitoring/CanopyHeight |               |          | (Tolan    |                |                |         |               |
fromERA5reanalysis(Hersbachetal.,2020),retrieved
etal.,2024,1m),(ii)ETHGlobalCanopyHeight2020
viaGoogleEarthEngine(Gorelicketal.,2017).Inthe
(Langetal.,2023,10m),and(iii)aGEDI-basedprod-
currentGLIDE-SOLworkflow,ERA5issampledatthe
| uct (Potapov | et al., 2021, | 30m). The | selected | canopy |     |     |     |     |
| ------------ | ------------- | --------- | -------- | ------ | --- | --- | --- | --- |
centreofthemodeldomainandconvertedintoasingle
| DSM is mosaicked | and | rasterized | on the common | grid |     |     |     |     |
| ---------------- | --- | ---------- | ------------- | ---- | --- | --- | --- | --- |
city-scalebackgroundtimeseries.Theforcingincludes
| to produce | Trees.tif, | representing | tree and | woody |     |     |     |     |
| ---------- | ---------- | ------------ | -------- | ----- | --- | --- | --- | --- |
near-surfaceairtemperatureandhumidity,surfacepres-
vegetationcoverandheightacrossthedomain.
|     |     |     |     |     | sure, 10m | wind components, | aerodynamic | roughness |
| --- | --- | --- | --- | --- | --------- | ---------------- | ----------- | --------- |
length,surfacealtitude,anddownwardshortwaveradi-
– Wind coefficients: using Buildings.tif, ation at the surface; from these, a diagnostic UHI cy-
Trees.tif, the script computes 12 directional cle is derived (Sect. 2.4.1). ERA5 accumulated down-
wind-sheltering rasters WindCoeff_dirXXX.tif ward shortwave radiation is converted to Wm−2 and
(one for each 30° sector) based on a Röckle-style di- used as global horizontal shortwave irradiance. Sepa-
rectionalwind-reductionmodel.The30°discretization ratedirectanddiffuseshortwavecomponentswerenot
was selected as a pragmatic compromise: it is fine taken from ERA5. Instead, the global shortwave irra-
enough to represent the main directional anisotropy diance was partitioned within SOLWEIG into direct
of the street and building layout while keeping pre- anddiffusecomponentsusingclearness-index-basedat-
processing cost and storage moderate. For each wind mospheric transmissivity and the Reindl et al. (1990)
direction, the sheltering effect of buildings and trees is relations. ERA5 downward longwave radiation is re-
representedthroughupwindanddownwindattenuation tainedintheprocessedforcingdatasetforreproducibil-
zones, then smoothed (e.g. via Gaussian filtering) and ity and optional experiments, but it was not prescribed
https://doi.org/10.5194/gmd-19-7389-2026 Geosci.ModelDev.,19,7389–7413,2026

| 7394 |     |     |     |     |     |     |     |     |     |     | A.Zonatoetal.:GLIDE-SOL |     |     |     |     |
| ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------------------- | --- | --- | --- | --- |
intheDortmundsimulationspresentedhere;longwave 2.3.3 CPUI/Oanddeferredre-compression
| exchangewas |     | computedbySOLWEIG |     |     | anddistributed |     |     |     |     |     |     |     |     |     |     |
| ----------- | --- | ----------------- | --- | --- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
withtheanisotropiclongwavescheme.Thefinaloutput All writing and compression duties remain on the CPU. In-
termediateGeoTIFFsarewrittenwithlightZSTDcompres-
| is a | NetCDF | file ready | to be | used | as forcing | for | SOL- |     |     |     |     |     |     |     |     |
| ---- | ------ | ---------- | ----- | ---- | ---------- | --- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
WEIG,suchthatthedownstreampipelineremainsiden- sion and marked as “ready” once all tiles for a given day
andvariablehavearrived.Adedicatedrepackingthreadthen
ticalregardlessoftheoriginalmeteorologicalsource.
usesGDALCreateCopytoconverteachreadyfiletothe
2.3 GPUaccelerationandparallelization LERC+ZSTD codec. LERC (Limited Error Raster Com-
pression)isthelossyraster-compressionstageusedonlydur-
| The GPU | strategy | in GLIDE-SOL |     | was | informed |     | by the |                     |     |              |     |           |     |           |      |
| ------- | -------- | ------------ | --- | --- | -------- | --- | ------ | ------------------- | --- | ------------ | --- | --------- | --- | --------- | ---- |
|         |          |              |     |     |          |     |        | ing post-processing |     | of completed |     | GeoTIFFs, |     | after the | sci- |
open-source SOLWEIG-GPU implementation described by entific fields have already been computed. The LERC step
| Kamath | et al. | (2026), which | provided |     | a valuable | reference |     |               |      |                   |     |         |     |          |     |
| ------ | ------ | ------------- | -------- | --- | ---------- | --------- | --- | ------------- | ---- | ----------------- | --- | ------- | --- | -------- | --- |
|        |        |               |          |     |            |           |     | is configured | with | variable-specific |     | maximum |     | absolute | er- |
pointforGPU-orientedrefactoringofSOLWEIG’sradiative rors (MAX_Z_ERROR): 0.15°C for UTCI, 0.10°C for T ,
mrt
geometry and time-stepping. GLIDE-SOL builds upon this 0.005ms−1 for V , and a 2Wm−2 default for radia-
10m
practicalfoundationwhileredesigningtheoverallworkflow,
|     |     |     |     |     |     |     |     | tive terms. | After | successful | repacking, | a   | hidden | “repacked” |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ----- | ---------- | ---------- | --- | ------ | ---------- | --- |
specificallyinareassuchasglobalinputgeneration,coordi- marker is written. GPU workers wait at day boundaries un-
natedtiling,andpost-processing.
tilthesemarkersappear,ensuringI/Oneverlagsbehindthe
computetasks.
2.3.1 GPU/CPUsplitandtiling
|     |     |     |     |     |     |     |     | 2.3.4 Memorystability |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------------- | --- | --- | --- | --- | --- | --- | --- |
Themostintensivegeometricandradiativecomputationsrun
entirelyontheGPU:shadowcasting,sky-viewfactor(SVF)
Overall,memoryusageremainstightlycontrolled:theGPU
estimation,thehourlySOLWEIGradiationbalance,andthe never holds more than one (or a few) tiles at a time plus
UTCIcalculationalltakeadvantageoffast,auto-castedGPU
|     |     |     |     |     |     |     |     | the 3D shadow |     | and SVF | buffers, | while | CPU | RAM | is sta- |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- | ------- | -------- | ----- | --- | --- | ------- |
math.TheCPUisresponsibleforcoordinatingtheworkflow.
|     |     |     |     |     |     |     |     | bilized through |     | one-time | raster loads, | periodic |     | cleanup, | and |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- | -------- | ------------- | -------- | --- | -------- | --- |
Before each run, GDAL splits the full spatial domain into deferredheavycompression.Theresultisapipelineinwhich
| tiles – typically |     | around one | megapixel |     | each – | so that | every |     |     |     |     |     |     |     |     |
| ----------------- | --- | ---------- | --------- | --- | ------ | ------- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
GPUcomputationandCPUI/Ooverlapsmoothly,maximiz-
piececomfortablyfitswithintheavailableVRAM.Crucially, ing throughput without ever exceeding VRAM or system
| to reduce              | edge | effects during | the          | simulation | (particularly |              | in  | memorylimits. |     |     |     |     |     |     |     |
| ---------------------- | ---- | -------------- | ------------ | ---------- | ------------- | ------------ | --- | ------------- | --- | --- | --- | --- | --- | --- | --- |
| neighborhood-dependent |      |                | calculations | such       | as            | the sky-view |     |               |     |     |     |     |     |     |     |
factor), a 10-cell padding is added to the perimeter of each 2.4 Physicalparameterizations
tile.Atthe2mgridspacingusedherethiscorrespondstoa
|     |     |     |     |     |     |     |     | We summarize |     | the three | added | parameterizations |     | that | im- |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | --- | --------- | ----- | ----------------- | --- | ---- | --- |
20mhalo,whichissufficienttocomputetheSVFcorrectly
at tile edges and avoid boundary effects in the simulations. proveonthebaselineSOLWEIGformulation.
EachGPUprocessesitsassignedtilesdaybyday.Oncethe
|     |     |     |     |     |     |     |     | 2.4.1 DiagnosticUHIcycle |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------------ | --- | --- | --- | --- | --- | --- | --- |
geometricandradiativecalculationsarecomplete,theadded
paddingisremovedduringthefinalGeoTIFFclippingphase
TorepresentnocturnalwarmingthatisnotresolvedinERA5
toensuretheoutputrasterpreciselymatchestheoriginalspa-
near-surfacemeteorology,weimposeadiagnosticUHIcycle
| tial domain, | eliminating |     | any boundary |     | artifacts. | One | CPU |     |     |     |     |     |     |     |     |
| ------------ | ----------- | --- | ------------ | --- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
thatperturbsthebackgroundairtemperaturebeforetheSOL-
processorchestratestheflowperdevice.
WEIGrun.ThedailymaximumUHIamplitudeisestimated
|     |     |     |     |     |     |     |     | using the | analytical | formulation |     | of Theeuwes |     | et al. (2016), |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ---------- | ----------- | --- | ----------- | --- | -------------- | --- |
2.3.2 Minimizinghost–devicetransfers
evaluateddirectlyfromERA5variables.Foreachdayd,the
DatamovementbetweenCPUandGPUisdeliberatelykept maximumUHIintensityis
small.Foreachtile,onlythetileitselfanditshaloaretrans-
|     |     |     |     |     |     |     |     |     | (cid:16) |     | (cid:17) | 1/4 |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --------- | --- | -------- | ---- | --- | --- | --- |
ferredfromhosttodevice.Afterthecomputationofanhour, SWDOWNd ·DTR3
|     |     |     |     |     |     |     |     |     |     | ρcp |     | d   |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
the outputs – UTCI, mean radiant temperature, air temper- UHI (d)= , (1)
|     |     |     |     |     |     |     |     | max |    |     | ∗   |    |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
W
ature, wind speed, and optionally shadows – are sent back 10,d
| to the CPU | as  | float32 arrays. | At  | the end | of every | simulated |     |     |     |     |     |     |     |     |     |
| ---------- | --- | --------------- | --- | ------- | -------- | --------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
hour,bothGPUandCPUmemoryarecleaned(CUDAcache, whereSWDOWN isthedaily-meanincomingshortwavera-
d
Pythongarbagecollection,malloc_trim)sothatthememory diation, DTR d the daily temperature range, ρ the air den-
∗
footprintstaysflatevenoverlongruns. sity, c the heat capacity of air, and W the daily mean
|     |     |     |     |     |     |     |     | p   |     |     |     |     | 10,d |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---- | --- | --- |
10mwindspeedusedfortheUHInormalization.Inthepre-
|     |     |     |     |     |     |     |     | processor, | W   | is computed | from | the ERA5 | wind | compo- |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | --- | ----------- | ---- | -------- | ---- | ------ | --- |
10
|     |     |     |     |     |     |     |     | nents as | (U2 +V2)1/2 |     | before the | urban | roughness |     | rescal- |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ----------- | --- | ---------- | ----- | --------- | --- | ------- |
10 10
|     |     |     |     |     |     |     |     | ing, because | the | formulation | of  | Theeuwes | et  | al. (2016) | is  |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | --- | ----------- | --- | -------- | --- | ---------- | --- |
Geosci.ModelDev.,19,7389–7413,2026 https://doi.org/10.5194/gmd-19-7389-2026

A.Zonatoetal.:GLIDE-SOL 7395
based on wind speed in non-urban surroundings rather than 2.4.2 Elevationbiascorrection
oncanopy-reducedurbanwind.Theintra-nightevolutionis
prescribedusinganasymmetricsine-shapedfunctionwhose Before forcing SOLWEIG, 2m air temperature is adjusted
timing follows observed UHI behavior. Rather than using from the ERA5 surface altitude to match the local DEM
fixed clock times, the night window is diagnosed directly elevation. The height difference is defined as (cid:49)H(x,y)=
fromERA5shortwaveradiation.Nightisdefinedasthepe- H ERA5 −H DEM (x,y), so positive values correspond to ter-
riodaroundthedailyzero-shortwaveinterval,extendedfrom rain below the ERA5 surface and negative values to terrain
four hours before SWDOWN=0 until the first two hours aboveit.Theimplementedcorrectioniswrittendirectlyasan
withSWDOWN>0aftersunrise.Withinthisnightwindow, elevation-dependenttemperatureadjustmentratherthanasa
theadditiveperturbationappliedtoairtemperatureis separate profile operator. For terrain below the ERA5 sur-
face, and for terrain above it but still below the lifting con-
densationlevel(LCL),thecorrectionisdryadiabatic:
UHI (t,x,y)=
d,L T (x,y)=T +(cid:48) (cid:49)H(x,y),
(cid:2) 2−SVF(x,y)−f (x,y) (cid:3) 2m,corr 2m d
 ·UHI (d)sin (cid:16) π veg s(t) (cid:17) , t∈nightwindow, (2) (cid:49)H(x,y)≥0 or 0<−(cid:49)H(x,y)≤z LCL , (3)
max L
0, daytime. where (cid:48) d =g/c p ≈9.8Kkm−1. For upward displacements
above the LCL, the temperature is first lifted dry adiabati-
cally to z and then continued along a saturated pseudo-
LCL
where SVF(x,y) is the sky-view factor used for the UHI adiabaticprofile:
modulation, f (x,y) is a local vegetation indicator on the
veg T (x,y)=T (−(cid:49)H(x,y);T −(cid:48) z ,p ),
2m,corr sat 2m d LCL LCL
common SOLWEIG grid, s(t) is the elapsed time since the
−(cid:49)H(x,y)>z , (4)
night-windowstart,andLitsduration.TheSVFiscomputed LCL
from buildings, terrain, and tree-canopy obstructions simul-
whereT (z)isobtainedbyintegratingthesaturatedpseudo-
sat
taneously; low-lying vegetation is not included in the SVF
adiabaticprofilefromtheLCLtothetargetheight.TheLCL
because it does not obstruct the sky at pedestrian level. In
height z is diagnosed from T , relative humidity RH,
LCL 2m
theDortmundimplementation,f =1fortree-canopycells
veg andthepressurevariablepusedbytheforcingmetfile.Inthe
and vegetated land-use cells, and f =0 for built, water,
veg code, p is read from the metfile in kPa and converted inter-
andbarecells.
nally to Pa before the thermodynamic calculation. The dew
The modulation term (2−SVF−f ) is therefore a di-
veg point is estimated following Bolton (1980) and the closed-
agnostic, theory-guided proxy rather than a coefficient fit-
formLCLexpressionofRomps(2017).AbovetheLCL,the
tedtolocalobservationsorafullyparameterizedvegetation-
saturatedpseudo-adiabaticprofileisintegratedbycoupling
energy-balancescheme.ItattenuatestheappliedUHIinopen
or highly vegetated areas, where nocturnal cooling is more dT = R d T +L v r s , (5)
effective. Because horizontal turbulent diffusion and advec- dp p (cid:2) c +L2r (cid:15)/(R T2) (cid:3)
p v s d
tion are not represented in this local modulation, the actual
2m air-temperature response would be expected to be spa- withthehydrostaticrelation
tiallysmootherthanthediagnosticfield.Directlyusingspa-
dp pg
tially and temporally varying modeled radiation and wind =− , (6)
dz R T
within the local UHI modulation would be more physically d v
complete,andisthereforeretainedasafutureextension.
where r is the saturation mixing ratio, L the latent heat
s v
The resulting adjusted air-temperature field is evaluated of vaporization, (cid:15)=R /R , and T the virtual temperature.
d v v
and written on the same 2m grid as the SOLWEIG radia-
Thiscorrectionisappliedateverytimestepbeforecomput-
tive fields, because SOLWEIG requires co-registered mete-
ingT andUTCI,usingthesameformulationduringday-
mrt
orologicalinputsforeachtile.Thisshouldbeinterpretedas
time and night-time. We do not derive a time-varying lapse
a limited diagnostic downscaling of a city-scale daily UHI
rate from ERA5 pressure-level or model-level fields in this
amplitudeaccordingtolocalmorphology,notasaclaimthat
implementation,becausetheobjectiveisalightweightforc-
atmosphericUHIvariabilityisphysicallyresolvedatexactly
ing correction that can be applied consistently in the auto-
2m.
matedglobalworkflow.
This diagnostic scheme provides a computationally effi-
cientwaytointroduceanapproximateUHIeffect–typically 2.4.3 Windreductioncoefficients
absentinERA5becauseofitscoarseresolutionandlackof
anurbanland-surfacerepresentation–whileremainingcom- We first harmonize the large-scale wind field from ERA5
patiblewiththeglobal,automatednatureoftheGLIDE-SOL and then derive directional, morphology-based wind reduc-
workflow. tioncoefficientsC(x,θ).
https://doi.org/10.5194/gmd-19-7389-2026 Geosci.ModelDev.,19,7389–7413,2026

| 7396 |     |     |     |     |     |     |     |     |     |     | A.Zonatoetal.:GLIDE-SOL |     |     |     |     |
| ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------------------- | --- | --- | --- | --- |
2.4.4 Referencewind box in the wind-aligned coordinate system, and H is the
|     |     |     |     |     |     |     |     | mean positive | rasterized |     | building | or  | canopy | height | inside |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | ---------- | --- | -------- | --- | ------ | ------ | ------ |
ERA5providesnear-surfacewindcomponentsat10mheight the connected component. These dimensions are then used
| (U ,V | ) together | with | a   | roughness | length | z   | . The |     |     |     |     |     |     |     |     |
| ----- | ---------- | ---- | --- | --------- | ------ | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
10 10 0,ERA5 to define upwind and leeward attenuation zones. For com-
script estimates a domain-average urban roughness length pactness, the detailed side-by-side comparison with the full
| z from        | buildings |          | and trees, | and | rescales            | the 10m | wind |                                               |     |     |     |     |     |     |     |
| ------------- | --------- | -------- | ---------- | --- | ------------------- | ------- | ---- | --------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
| 0,city        |           |          |            |     |                     |         |      | Röckle/URockmethodologyisreportedinAppendixA. |     |     |     |     |     |     |     |
| from z 0,ERA5 | to        | z 0,city | assuming   | a   | neutral logarithmic |         | wind |                                               |     |     |     |     |     |     |     |
profile. The implemented estimate is an area-weighted do- 2.4.6 Verticaluniformityassumption
mainmean:
|     |     |     |     |     |     |     |     | In the present | implementation, |     |     | the upwind | deceleration |     | and |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------- | --------------- | --- | --- | ---------- | ------------ | --- | --- |
z 0,city =f b z 0,b +f t z 0,t +f o z 0,o , (7) leeward attenuation formulations are applied assuming that
thewindreductioncoefficientisverticallyuniformfromthe
| where f | , f , and | f   | are the | plan-area | fractions | of  | build- |                                                       |     |     |     |     |     |     |     |
| ------- | --------- | --- | ------- | --------- | --------- | --- | ------ | ----------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
|         | b t       | o   |         |           |           |     |        | grounduptotheobstacleheight,i.e.uptothebuildingheight |     |     |     |     |     |     |     |
ing cells, tree cells, and all remaining cells, respectively. or the canopy top in the case of trees. The reduction is also
Buildingcellsareidentifiedwherethebuilding-heightraster uniform across each affected obstacle column in the wind-
| is positive. | Tree | cells | are identified |     | where | the tree-height |     |     |     |     |     |     |     |     |     |
| ------------ | ---- | ----- | -------------- | --- | ----- | --------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
alignedlateraldirectionbeforethefinalsmoothingstep.This
rasterispositiveandnobuildingispresent,sobuildingcells differs from Röckle/URock implementations that use ellip-
take precedence where the two rasters overlap. The rough- soidalorotherwisetaperedshapesinthelateralandvertical
|                 |     |         | z   | =0.1H | z       | =0.1H |         |             |     |     |     |     |     |     |     |
| --------------- | --- | ------- | --- | ----- | ------- | ----- | ------- | ----------- | --- | --- | --- | --- | --- | --- | --- |
| ness components |     | are set | to  | 0,b   | b , 0,t |       | t , and | directions. |     |     |     |     |     |     |     |
z =0.03m,whereH andH arethemeanpositivebuild- This assumption is consistent with the conceptual frame-
| 0,o |     |     | b   | t   |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
ingandtree-canopyheightsovertheirrespectivemasks.Thus
|     |     |     |     |     |     |     |     | work of | simplified | urban | wind-reduction |     | models, | where | the |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | ---------- | ----- | -------------- | --- | ------- | ----- | --- |
buildings and trees enter the same area-weighted roughness dominant effect of buildings and vegetation on the mean
estimator,butasseparatemaskswithseparatemeanheights. flowisrepresentedthroughverticallyintegrateddraganddis-
| A tree patch | is  | not represented |     | by  | its maximum | height | in  |           |         |        |      |         |         |          |      |
| ------------ | --- | --------------- | --- | --- | ----------- | ------ | --- | --------- | ------- | ------ | ---- | ------- | ------- | -------- | ---- |
|              |     |                 |     |     |             |        |     | placement | effects | rather | than | through | a fully | resolved | ver- |
this step; its contribution uses the mean positive tree-DSM tical structure, especially in dense urban canopies. Several
heightofallnon-buildingtreecellsinthedomain.Theresult-
|     |     |     |     |     |     |     |     | studies have | shown | that, | for practical |     | urban-scale |     | applica- |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | ----- | ----- | ------------- | --- | ----------- | --- | -------- |
isclippedtotheinterval10−4–10mfornumerical
ingz 0,city tions, the bulk momentum deficit induced by buildings and
stability. canopies can be reasonably approximated as vertically ho-
Foreachwindcomponentweapply
|     |     |         |        |         |     |     |     | mogeneous  | within    | the roughness |           | sub-layer, | up    | to the | obsta- |
| --- | --- | ------- | ------ | ------- | --- | --- | --- | ---------- | --------- | ------------- | --------- | ---------- | ----- | ------ | ------ |
|     |     |         |        |         |     |     |     | cle height | (Santiago | and           | Martilli, | 2010;      | Cheng | and    | Porté- |
|     |     | (cid:0) |        | (cid:1) |     |     |     |            |           |               |           |            |       |        |        |
|     |     | ln 10/z | 0,city |         |     |     |     |            |           |               |           |            |       |        |        |
U city=UERA5 , Agel,2015;Zonatoetal.,2023).Giventheobjectivesofthe
| 10  | 10  | (cid:0) |     | (cid:1) |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | ------- | --- | ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
ln 10/z 0,ERA5 presentstudyandthespatialresolutionconsidered,thissim-
(cid:0) (cid:1) plification offers a robust compromise between physical re-
ln 10/z
| city=VERA5 |     |         | 0,city |           |     |     |     |                                  |     |     |     |     |     |     |     |
| ---------- | --- | ------- | ------ | --------- | --- | --- | --- | -------------------------------- | --- | --- | --- | --- | --- | --- | --- |
| V          |     | (cid:0) |        | (cid:1) . |     |     | (8) | alismandcomputationalefficiency. |     |     |     |     |     |     |     |
| 10         | 10  | ln 10/z |        |           |     |     |     |                                  |     |     |     |     |     |     |     |
0,ERA5
|               |     |             |     |       |      |          |     | 2.4.7 Upwinddeceleration |     |     |     |     |     |     |     |
| ------------- | --- | ----------- | --- | ----- | ---- | -------- | --- | ------------------------ | --- | --- | --- | --- | --- | --- | --- |
|               |     |             |     | city  | city |          |     |                          |     |     |     |     |     |     |     |
| The resulting |     | time series | (U  | (t),V | (t)) | are used | as  |                          |     |     |     |     |     |     |     |
|               |     |             |     | 10    | 10   |          |     |                          |     |     |     |     |     |     |     |
Upwindofeachobstacle,themodelprescribesamonotonic
| a spatially | uniform, | domain-consistent |     |     | background |     | canopy |     |     |     |     |     |     |     |     |
| ----------- | -------- | ----------------- | --- | --- | ---------- | --- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
wind.InSOLWEIGthisbackgroundwindislatermultiplied rampfromfullwindtoareducedvalueoveracharacteristic
bythespatiallyvaryingcoefficientsC(x,θ)describedbelow. displacement-zonelength
1.5W
| 2.4.5 Directionalwind-reductionmodel |     |     |     |     |     |     |     | L = |     | .   |     |     |     |     | (9) |
| ------------------------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
f
1+0.8(W/H)
| Directional | wind–reduction |     |     | coefficients | C(x,θ) | are | com- |          |             |      |     |             |     |             |     |
| ----------- | -------------- | --- | --- | ------------ | ------ | --- | ---- | -------- | ----------- | ---- | --- | ----------- | --- | ----------- | --- |
|             |                |     |     |              |        |     |      | We treat | this upwind | ramp | as  | a pragmatic | 2-D | attenuation |     |
putedwithasimplified,one-stepattenuationschemeinspired
proxyratherthanasafullRöckledisplacement-zonegeom-
| by Röckle-type |     | models | such | as those | described | in  | Röckle |     |     |     |     |     |     |     |     |
| -------------- | --- | ------ | ---- | -------- | --------- | --- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
etry.
| (1990) and | Bernard | et  | al. (2023). |     | The resulting | flow | is not |     |     |     |     |     |     |     |     |
| ---------- | ------- | --- | ----------- | --- | ------------- | ---- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
Forbuildings,thealong-windprofileisparameterizedas
massbalancedandshouldthereforebeinterpretedasadiag-
n o st ic a t te n u a ti on fi e ld , n o ta s a d y n am ic a l ly c o m p l e te w i n d (cid:18) (cid:19)pf
|     |     |     |     |     |     |     |     |     | +(cid:0) |     | (cid:1) x |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | -------- | --- | --------- | --- | --- | --- | --- |
si m u la ti o n . F o r ea c h w i n d d ir ec t io n θ ( 1 2 d i re c ti o n s w i t h C (x)=C 1−C , 0≤x≤L , (10)
|     |     |     |     |     |     |     |     | f   | min | min | L   |     |     | f   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
f
| 30° spacing), | the | building | and | tree | fields are | rotated | into |     |     |     |     |     |     |     |     |
| ------------- | --- | -------- | --- | ---- | ---------- | ------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
wind-aligned coordinates so that the flow effectively comes where x is the upwind distance from the wall (against the
|     |     |     |     |     |     |     |     |     |     | =1.5, |     | =0.1 |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----- | --- | ---- | --- | --- | --- |
from west. In this rotated grid, each connected building (or mean wind), p f and C min is a lower bound en-
tree cluster) is characterized by an effective obstacle width forcedduringpost-processing.Veryclosetothebuilding,C
f
W, depth D (along-wind), and height H. Here W and D approachesC ,whilefartherupwinditgraduallyrelaxesto
min
| are the dimensions |     | of  | the obstacle’s |     | axis-aligned | bounding |     | 1.  |     |     |     |     |     |     |     |
| ------------------ | --- | --- | -------------- | --- | ------------ | -------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Geosci.ModelDev.,19,7389–7413,2026 https://doi.org/10.5194/gmd-19-7389-2026

A.Zonatoetal.:GLIDE-SOL 7397
2.4.8 Leewardattenuation canopyroughnesslengthz =0.1H,followingstandard
0,tree
canopy-flowparameterizations.Thebaseattenuationcoeffi-
Downwind of buildings, the leeward attenuation length L r cient k (denoted α in the implementation) is then modeled
is then set to three times the cavity length, following the as
Röckle/Kaplan–DinarconventionadoptedinURock(Kaplan
andDinar,1996;Bernardetal.,2023): k=a +a LAI . (14)
0 1 eff
3×1.8W witha =0.5anda =0.2.Thebasecanopyreductionfac-
L = . (11) 0 1
r (cid:0)D(cid:1)0.3(cid:2) 1+0.24 (cid:0)D(cid:1)(cid:3) toratheightz isthendefinedpiecewise.LetH bethelocal
H H canopyheight(fromthetreeDSM),d=0.7H thedisplace-
Alongtheleewardcenterline,therecoveryisassumedlin- mentheight,andz =0.1H thecanopyroughnesslength
0,tree
earwithdistance: (with a small lower bound to avoid singularities). Denoting
x the reference roughness by z 0,ERA5 (taken from the meteo-
C b (x)= , 0≤x≤L r , (12) rologicaldataset),wefirstdefinethereferenceneutralwind-
L
r
profiledenominator
with C (x) truncated to the range [C ,1] and C →1 as
b min b (cid:18) (cid:19)
x→L r . Immediately downstream of the wall, C b tends to- D (z)=ln z , (15)
ref
wards C min , representingthe recirculationzone. The imple- z 0,ERA5
mentation applies this recovery profile along each obstacle
andweboundtheargumentsofthelogarithmsinthenumer-
columninthewind-alignedgrid.Wheremultiplebuildingat-
atorsothattheyremainlargerthan1.
tenuationzonesoverlap,theirlocalreductionfactorsaremul-
Forpointsaboveorjustatthecanopytop(z≥H),thebase
tiplied and then clipped to [C ,1], so overlapping zones
min
reductionfactorispurelylogarithmic:
strengthen attenuation without spuriously increasing wind
speed. ln (cid:0) (z−d)/z (cid:1)
C (z≥H)=
0,tree
. (16)
t,base
2.4.9 Trees D ref (z)
Forpointsinsidethecanopy(z<H),themodelassumesthat
Trees are treated with the same geometric description
thewindspeedatthecanopytopfollowsthesamelogarith-
(W,D,H), but as porous obstacles. This differs from
micscaling,butdecaysexponentiallytowardsthegroundac-
URock,wherevegetationdragisrepresentedwithoutadding
cordingtotheattenuationcoefficientk:
thesamebuilding-likeupwindandleewardattenuationzones
u ag se n d os h t e ic re G .T L h ID ea E d - d S i O ti L on e a x l t u e p n w si i o n n d , a m nd ot l i e v e a w te a d rd by zo t n h e e s p a h re ys a ic d a i- l C t,base (z<H)= ln (cid:0) (H−d)/z 0,tree (cid:1) exp (cid:104) −k (cid:16) 1− z (cid:17)(cid:105) , (17)
D (z) H
expectation that porous tree canopies induce upstream ad- ref
justmentandcoherentdownstreamsheltering,asalsoshown so that C →ln (cid:0) (H−d)/z (cid:1) /D (z) at the canopy
t,base 0,tree ref
inisolated-treewakemodellingandexperiments(Margairaz top (z→H) and decreases towards exp(−k) near the
et al., 2022; Grandoni et al., 2026). QES-Winds simi- ground.
larly treats isolated-tree wakes with a dedicated tree-flow Given C at the obstacle location, we apply the same
t,base
model, applied outside building cavity and street-canyon diagnostic wind-reduction geometry adopted for buildings.
zones (Margairaz et al., 2022). This supports represent- Accordingly,theupwindinfluencelengthL andtheleeward
f
ing tree-induced sheltering separately from building wakes, attenuationlengthL arecomputedusingEqs.(9)and(11),
r
while also highlighting that the GLIDE-SOL treatment re- respectively.
mains a simplified diagnostic approximation rather than a Upwindofthecanopyedge(x measuredagainstthemean
full isolated-tree flow solver. For each grid cell containing wind), the coefficient is ramped from C to 1 using the
t,base
canopy,alocal,height-dependentwindreductioncoefficient samefunctionalformasEq.(10),
C is first computed at the evaluation height (z=10m
t,base
in this study) using a canopy-flow parameterization follow- C (x)=C +(cid:0) 1−C (cid:1)
(cid:18)
x
(cid:19)pf
,
ingBernardetal.(2023).Themodeldependsonaneffective t,up t,base t,base L
f
leafareaindex
0≤x≤L , (18)
f
LAI =LAIλ , (13)
eff p withp =1.5.
f
where LAI is the leaf area index (expressed as m2m−2 and Downwind, the profile recovers linearly from C t,base to 1
overtheleewardattenuationlengthL ,
set to LAI=5) and λ is the canopy plan-area fraction. In r
p
e D a S c M h , g a ri n d d c w el e l, d t e h fi e n c e a a no d p is y pl h a e c i e g m ht en H th i e s ig ta h k t e d n = fr 0 o . m 7H the an t d ree a C t,down (x)=C t,base +(cid:0) 1−C t,base (cid:1) x , 0≤x≤L r . (19)
L
r
https://doi.org/10.5194/gmd-19-7389-2026 Geosci.ModelDev.,19,7389–7413,2026

7398 A.Zonatoetal.:GLIDE-SOL
2.4.10 Combinationandsmoothing posureandguidedata-drivenadaptationmeasures.Withfew
exceptions,stationsaremountedonlampposts3.3mabove
Foreachdirectionθ,buildingandtreeattenuationfieldsare groundand50cmawayfromthepole.Theblackglobesen-
computedonthewind-alignedgridandthenrotatedbackto sor always faces south, and this way avoids shading by the
the original grid. Within each contribution, overlapping re- pole. In some cases (seven in total) where this is not possi-
duction factors are multiplied and clipped to the prescribed ble due to other obstructions, it is precisely documented in
coefficient range. At each grid point, the final building and the metadata (Hüser et al., 2026), where also each station
treecontributionsarethencombinedmultiplicatively, setupiscarefullydescribed.Measuredrawdataistransmit-
ted by individual sensors every five minutes via LoRaWAN
C(x,θ)=C (x,θ)C(x,θ), (20)
b t (LongRangeWideAreaNetwork)andsensordataarethen
The resulting 2-D field is first Gaussian-smoothed at a combined during postprocessing, allowing for computation
short spatial scale and then with an effective kernel of ofderivedbiometeorologicalparameterssuchasmeanradi-
about 40m to blend overlapping reduction zones and sup- anttemperature(T mrt )followingInternationalElectrotechni-
press blocky artifacts caused by rasterized obstacle edges calCommission(2021)andthecommonthermalcomfortin-
and directional rotation. The 40m value was selected as dicesUTCI(Jendritzkyetal.,2012),PET(Höppe,1999)and
a small neighborhood-scale smoother rather than as a cal- heatindex(HI)(Steadman,1979;Rothfusz,1990).Themax-
ibrated physical influence length. It also regularizes the imumallowedtemporaloffsetbetweensensormeasurements
simplifiedplan-viewattenuationfootprintsbecauseGLIDE- (black globe and all-in-one sensor) is 5min, labeling the
SOL does not prescribe an ellipsoidal lateral/vertical wake combined station-measurement with the all-in-one sensor’s
envelope as in fuller Röckle/URock implementations. Fi- original timestamp since the expected response time of the
nally, C(x,θ) is clipped to the interval [C ,1] and stored blackglobesensorismuchslower.Theblack-globe-derived
min
as WindCoeff_dirXXX.tif (one file per direction). In T mrt measurementswerenotindependentlycalibratedagainst
SOLWEIG,thecanopywindspeedisobtainedbymultiply- 3-Dnetradiometerswithinthisstudy;hence,nocalibration
ingthedomain-consistentbackgroundwind(U city ,V city )by correctionwasappliedtotheT mrt observations.
10 10 For this study, observations and metadata from 25 sta-
these directional coefficients C(x,θ). For the computation
ofUTCI,aminimumwindspeedof0.5ms−1 isimposedto tions (more than 250000 valid station–hour records) were
derived via the public API (Application Programming
avoidunrealisticallylowvalues.
Interface) which provides near-realtime data (https://api.
2.5 Casestudy:Dortmund data2resilience.de,lastaccess:29July2026).Stationcoordi-
natesareprovidedinWGS84bytheAPI,andtheDortmund
ThecityofDortmund(51°30(cid:48)N,7°28(cid:48)E),Germany,wasse- domain is defined in UTM 32N (EPSG:32632) at 2m grid
lected as a case study area due to the large city-wide urban spacing,coveringtheurbancoreandadjacentdistricts(tens
biometeorologicalweatherstationnetwork.Dortmundislo- of km2). Simulations span the period from 6 August 2024
catedinthelargermetropolitanRuhrregionandwasselected to31December2025.Forstation-levelLCZcontext,weuse
as a case study area in the ICLEI Action Fund 2.0 with the thefield-basedLCZclassesreportedinthestationmetadata
Data2Resilience project, which supported the implementa- ratherthanLCZvaluessampledfromtheglobalrastermap,
tion of data-driven services to enhance the resilience to ex- becausethefieldassignmentbetterrepresentstheimmediate
treme heat. Following the approach in Freiburg, Germany surroundings of each sensor location. Two model configu-
(Pleinetal.,2024),alargeweatherstationnetworkwasde- rations are evaluated: a baseline run driven by unmodified
ployed. It consists of 51 stations measuring air-temperature ERA5forcing(Sol_STD)andaconfigurationthatactivates
and relative humidity using a Decentlab DL-SHT35 sen- boththemorphology-basedwindcorrectionandthediagnos-
sor in the manufacturer’s small, naturally ventilated radia- ticUHIcycle(Sol_WC_UHI).
tion shield, as well as 25 additional stations equipped with
biometeorological sensors, specifically a black globe tem-
3 Results
perature sensor (Decentlab DL-BLG with 125mm diame-
ter)andanall-in-oneweatherstationsensor(DecentlabDL-
Wereportcomputationalperformanceandoutputvolumefor
ATM41),providingadditionalparametersbesidesairtemper-
theDortmundcasestudy,illustratethespatialimprintofthe
atureandrelativehumiditysuchasblackglobetemperature,
wind and UHI diagnostics, and evaluate station-based skill
downwardshortwaveradiation,windspeedandwinddirec-
using aggregate statistics, distributions, and temporal and
tion, and precipitation. The stations are located throughout
seasonalthermalstressmetrics.
the city and cover a wide variety of urban structures based
onLocalClimateZones.Biometeorologicalstationsarede-
liberatelyplacedatlocationsofpublicinterest,suchasmain
squares,urbanparksanddistrictswithcombinedvulnerabil-
ities, to enable the local government to assess the heat ex-
Geosci.ModelDev.,19,7389–7413,2026 https://doi.org/10.5194/gmd-19-7389-2026

| A.Zonatoetal.:GLIDE-SOL |     |     |     |     |     |     |     |     |     | 7399 |
| ----------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---- |
Figure2.Dortmundmodeldomain:landuse,buildings,trees,andstationpointsannotatedwiththeirrespectiveIDonthecommonUTM32N
grid.Generatedduringtheinput-buildphase.StationmarkersandlabelsarecoloredaccordingtotheobservedLocalClimateZone(LCZ)
classreportedinthestationmetadata,usingthestandardLCZcolorscheme.
3.1 Computationalperformance is lowest within dense blocks, tree-covered areas, and lee-
wardattenuationzones(C(cid:28)1),whilemajoropencorridors
To quantify the practical impact of GPU acceleration, we preserve higher effective wind speeds (C≈1). The yellow
benchmarkedasingle-dayGLIDE-SOLrunoverDortmund
|     |     |     |     |     |     | tree-height | overlay helps identify | areas where | canopy | shel- |
| --- | --- | --- | --- | --- | --- | ----------- | ---------------------- | ----------- | ------ | ----- |
3129×3113
on a reduced grid (2m spacing). Using one teringcontributestolocallylowcoefficientsoutsidethedens-
NVIDIA A100 (40GB) GPU, the 24h simulation (saving estbuildingblocks.Valuescloseto1shouldbeinterpretedas
| UTCI,T | ,T ,andV | )completedin254s(10.6spersim- |     |     |     |     |     |     |     |     |
| ------ | -------- | ----------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
mrt a 10m weakattenuationrelativetothebackgroundwindratherthan
ulatedhour).ThesameconfigurationexecutedinCPU-only as explicit acceleration, because the model does not solve a
| mode on | the same node | required 1285s | (53.5s | per | simu- |     |     |     |     |     |
| ------- | ------------- | -------------- | ------ | --- | ----- | --- | --- | --- | --- | --- |
mass-conservingflowfield.Somesmoothcorridor-likestruc-
latedhour),correspondingtoawall-clockspeed-upofabout tures in Fig. 3 therefore reflect the combination of overlap-
5.1.FortheGPUrun,PyTorchCPUthreadingwasrestricted ping attenuation zones, rotation back to the native grid, and
tonum_threads=1toavoidhost-sideoversubscription;in
Gaussiansmoothing,andlocalanomaliesaroundindividual
CPU-onlymodealllogicalCPUthreadswereavailable. buildingsortreepatchesshouldbeinterpretedrelativetothe
Inadditiontocomputeacceleration,deferredrepackingto rasterizedinputgeometryratherthanasvalidatedrecircula-
LERC+ZSTD
reduces I/O and storage requirements. For tion patterns. Although Reynolds-averaged and large-eddy
theDortmundcase-studygrid,anuncompresseddailyUTCI CFD simulations provide higher-fidelity representations of
| stack would | occupy about | 3.3GB, whereas |     | the repacked |     |              |                   |                |     |            |
| ----------- | ------------ | -------------- | --- | ------------ | --- | ------------ | ----------------- | -------------- | --- | ---------- |
|             |              |                |     |              |     | shear layers | and recirculation | (Chu and Wang, |     | 2025), the |
GeoTIFF is 251MB (∼13× smaller; 92% reduction), us- morphology-basedC(x,θ)providesacomputationallyinex-
ingthecompressionerrorvaluesdescribedinSect.2.3. pensive surrogate that retains the main anisotropy imposed
byurbanform.Thisisthephysicalmechanismbywhichthe
3.2 Diagnosticsofthewindandtemperature Sol_WC_UHIconfigurationcompensatesforthelackofex-
corrections
pliciturbandragincoarsemeteorologicalforcing.
|     |     |     |     |     |     | The diagnostic | UHI cycle | acts on the background |     | mete- |
| --- | --- | --- | --- | --- | --- | -------------- | --------- | ---------------------- | --- | ----- |
The diagnostic wind module generates a directional atten- orologicalforcingratherthanproducingastandalonespatial
| uation coefficient | field | C(x,θ) that converts |     | the domain- |     |     |     |     |     |     |
| ------------------ | ----- | -------------------- | --- | ----------- | --- | --- | --- | --- | --- | --- |
field:itappliesanight-timewarmingperturbationmodulated
| consistent | 10m wind to | a morphology-dependent |     | ventila- |     |     |     |     |     |     |
| ---------- | ----------- | ---------------------- | --- | -------- | --- | --- | --- | --- | --- | --- |
bySVFandvegetation(Eq.2).Itseffectisthereforeassessed
| tion proxy. | For θ =240° | (south-westerly | flow; | Fig. | 3), C |     |     |     |     |     |
| ----------- | ----------- | --------------- | ----- | ---- | ----- | --- | --- | --- | --- | --- |
https://doi.org/10.5194/gmd-19-7389-2026 Geosci.ModelDev.,19,7389–7413,2026

7400 A.Zonatoetal.:GLIDE-SOL
Figure3.Examplewind-reductioncoefficientfieldC(x,θ)forθ=240°(south-westerlyflow)overDortmund.Dark-blueregionsindicate
strongwindattenuationindenseurbanfabric,tree-coveredareas,andleewardattenuationzones;warmcolorshighlightventilationcorridors
withlimitedreduction.Theyellowoverlaylabelled“Trees”markspositivetree-heightpixelsfromthetree-heightraster,withadarkhalo
addedforreadability,andtheyellowarrowindicatestheinflowdirectionusedtocomputethedirectionalattenuationfield.
throughthestation-basedskillmetricsandseasonaldiagnos- Table 1. Aggregate performance against observations. Bias and
ticspresentedbelow. RMSEarein°CforUTCI/Tmrt/Ta andinms −1 forcanopywind
Figure4summarizesJJAmeanfieldsfromSol_WC_UHI speedVcan.Boldvaluesindicatethebest-performingconfiguration
for central Dortmund. Station symbols report observed (left foreachvariableandmetric.
semicircle)andmodeled(rightsemicircle)summermeansat
Variable–configuration Bias RMSE
each location. Air temperature exhibits only modest spatial
gradientsandagreeswellatstationpoints.Windspeedshows UTCI–Sol_STD −7.07 8.09
strongmorphology-drivenheterogeneity,withlowvaluesin UTCI–Sol_WC_UHI −0.85 2.84
densebuilt-upareasandhighervaluesinopencorridorsand
Tmrt–Sol_STD −3.86 6.91
peripheral zones; this pattern is consistent with the direc-
Tmrt–Sol_WC_UHI −2.76 6.29
tional wind-reduction model and with the improved wind-
speed statistics (Sect. 3.3). T displays pronounced small- Ta–Sol_STD −1.00 1.78
mrt
scale variability due to shading and land cover, and the re-
Ta–Sol_WC_UHI 0.14 1.30
maining differences at station locations are consistent with Vcan–Sol_STD 2.18 2.56
the residual T
mrt
errors in Table 1. UTCI integrates these Vcan–Sol_WC_UHI 0.03 0.77
driversandshowscloseagreementofsummermeansatsta-
tion points, indicating that the diagnostic corrections trans-
lateintorealisticwarm-seasonthermal-stresslevels.
3.3 Aggregateskillacrossallstations cold bias from −7.07 to −0.85°C and cut RMSE from
8.09to2.84°C(65%reduction).Improvementsarealsoev-
Model skill is evaluated against hourly measurements from ident for T (RMSE 6.91°C→6.29°C) and canopy air
mrt
25 stations with heterogeneous but overlapping tempo- temperature(RMSE1.78°C→1.30°C).Thelargestdynam-
ral coverage between August 2024 and December 2025 ical gain occurs for canopy wind speed V , where the
can
(more than 250000 station–hour records). We compare strong positive bias in Sol_STD is largely removed (bias
two configurations: a baseline run driven by unmodified 2.18→0.03ms−1;RMSE2.56→0.77ms−1).
ERA5 meteorology (Sol_STD) and a run that activates Theall-hourT statisticsinTable1combinedaytimeand
a
the morphology-based wind correction and the diagnostic night-timeconditions.Thisaggregationisusefulfortheover-
UHI cycle (Sol_WC_UHI). Table 1 summarizes the ag- all UTCI evaluation, but it partly masks the mechanism of
gregate performance against the station observations used thediagnostictemperaturecorrection:duringdaytime,T is
a
in this paper. The combined corrections reduce the UTCI affectedprimarilybyERA5forcingandtheelevation-based
Geosci.ModelDev.,19,7389–7413,2026 https://doi.org/10.5194/gmd-19-7389-2026

| A.Zonatoetal.:GLIDE-SOL |     |     |     |     |     |     |     |     |     |     |     |     |     |     | 7401 |
| ----------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---- |
Figure4.Summer(JJA)meanfieldsfortheSol_WC_UHIconfiguration.Panelsshow(topleft)airtemperature,(topright)windspeed,
(bottomleft)meanradianttemperature(Tmrt),and(bottomright)UTCI.Circlesdenotestationlocations;foreachstation,thelefthalfofthe
symbolrepresentsobservedvalues,whiletherighthalfshowsthecorrespondingmodeledsummermean.
correction,whereasatnightitisadditionallyaffectedbythe 3.4 Scatteranddistributionaldiagnostics
UHIcycle.
| Figure | 5 reports | station-level |     | UTCI | errors (RMSE | and |     |         |       |        |       |            |           |     |         |
| ------ | --------- | ------------- | --- | ---- | ------------ | --- | --- | ------- | ----- | ------ | ----- | ---------- | --------- | --- | ------- |
|        |           |               |     |      |              |     | The | scatter | plots | (Figs. | 6 and | 7) provide | a compact |     | view of |
meanbias,MB)forSol_STDandSol_WC_UHI,withsites
systematicerrorsandconditionalbiases.ForUTCI(Fig.6),
| sorted by      | sky-viewfactor |           | (SVF) | as a                | compactproxy | for lo-  |           |         |            |              |       |                    |        |            |       |
| -------------- | -------------- | --------- | ----- | ------------------- | ------------ | -------- | --------- | ------- | ---------- | ------------ | ----- | ------------------ | ------ | ---------- | ----- |
|                |                |           |       |                     |              |          | Sol_STD   |         | exhibits   | a pronounced |       | cold               | bias,  | consistent | with  |
| cal enclosure  | and            | radiative |       | exposure.           | The figure   | provides |           |         |            |              |       |                    |        |            |       |
|                |                |           |       |                     |              |          | excessive |         | convective | cooling      |       | from overestimated |        | winds      | and   |
| a first visual | stratification |           | along | an open-to-enclosed |              | urban    |           |         |            |              |       |                    |        |            |       |
|                |                |           |       |                     |              |          | with      | missing | nocturnal  |              | urban | warming            | in the | forcing.   | Acti- |
gradient,whiletheexactnumericvaluesareretainedinAp-
vatingwindattenuationandtheUHIadjustmenttightensthe
| pendix B. | Differences |     | between | observed | and modeled | SVF |     |     |     |     |     |     |     |     |     |
| --------- | ----------- | --- | ------- | -------- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
scatterandshiftsthecloudtowardsthe1:1line.InFig.7,the
| at individual                                      | stations |     | mainly | reflect | representativeness: | the |                                          |     |     |     |     |     |     |     |        |
| -------------------------------------------------- | -------- | --- | ------ | ------- | ------------------- | --- | ---------------------------------------- | --- | --- | --- | --- | --- | --- | --- | ------ |
|                                                    |          |     |        |         |                     |     | strongestimprovementisincanopywindspeedV |     |     |     |     |     |     |     | ,where |
| modelsamplesa2mgridcellfromgloballyderivedbuilding |          |     |        |         |                     |     |                                          |     |     |     |     |     |     | can |        |
Sol_WC_UHIlargelyremovesthepositivebias.Forcanopy
andvegetationdata,whereastheobservedSVFcharacterizes
airtemperature,thecorrectionreducesbothbiasandRMSE,
| the exact         | sensor     | surroundings,   |          | including     | small trees    | and fa-   |                    |             |                       |             |           |             |             |            |          |
| ----------------- | ---------- | --------------- | -------- | ------------- | -------------- | --------- | ------------------ | ----------- | --------------------- | ----------- | --------- | ----------- | ----------- | ---------- | -------- |
|                   |            |                 |          |               |                |           | whileT             |             | improvesmoremodestly. |             |           |             |             |            |          |
| cade details      | that       | are not         | always   | present       | in the input   | rasters.  |                    | mrt         |                       |             |           |             |             |            |          |
|                   |            |                 |          |               |                |           | The                | probability |                       | density     |           | functions   | (Fig.       | 8) provide | a        |
| Open-source       | morphology |                 | datasets | are           | also uncertain | at this   |                    |             |                       |             |           |             |             |            |          |
|                   |            |                 |          |               |                |           | distribution-level |             |                       | evaluation  |           | of the main | UTCI        | drivers    | and      |
| scale, especially |            | for vegetation; |          | discrepancies | can            | therefore |                    |             |                       |             |           |             |             |            |          |
|                   |            |                 |          |               |                |           | confirm            | that        | the                   | corrections | primarily |             | act through |            | wind and |
| be larger         | in urban   | canyons         | with     | street        | trees or small | vege-     |                    |             |                       |             |           |             |             |            |          |
near-surfaceairtemperatureforcing.
tationelementswherethelocalobstructionseenbythesen-
|             |      |                |     |          |                |      | For  | air | temperature |          | (top-left),   | both | configurations |            | repro- |
| ----------- | ---- | -------------- | --- | -------- | -------------- | ---- | ---- | --- | ----------- | -------- | ------------- | ---- | -------------- | ---------- | ------ |
| sor differs | from | the rasterized |     | building | and vegetation | lay- |      |     |             |          |               |      |                |            |        |
|             |      |                |     |          |                |      | duce | the | broad       | observed | distribution, |      | while          | Sol_WC_UHI |        |
ers.InSol_STD,themeanbiasisuniformlynegativeacross
shiftsthePDFclosertotheobservations,consistentwiththe
thenetwork(between−5.4and−8.4°C)andRMSEremains
|     |     |     |     |     |     |     | reducedT |     | bias.ThecanopywindspeedV |     |     |     |     | PDF(top-right) |     |
| --- | --- | --- | --- | --- | --- | --- | -------- | --- | ------------------------ | --- | --- | --- | --- | -------------- | --- |
high (6.2–9.4°C) across the full SVF range, indicating that a can
revealsthemajordeficiencyofSol_STD:astrongshiftto-
uncorrectedforcingdominatestheerror(inparticular,exces-
|     |     |     |     |     |     |     | wards | higher | wind | speeds | and | an unrealistically |     | long | high- |
| --- | --- | --- | --- | --- | --- | --- | ----- | ------ | ---- | ------ | --- | ------------------ | --- | ---- | ----- |
sivewindcooling).WithSol_WC_UHI,RMSEdecreasesat
|               |             |     |     |        |                  |      | wind  | tail | (up to    | ∼10–12ms−1). |     | Sol_WC_UHI   |     | largely  | re-  |
| ------------- | ----------- | --- | --- | ------ | ---------------- | ---- | ----- | ---- | --------- | ------------ | --- | ------------ | --- | -------- | ---- |
| every station | (1.7–4.5°C) |     | and | biases | collapse towards | zero |       |      |           |              |     |              |     |          |      |
|               |             |     |     |        |                  |      | moves | this | artifact, | recovering   |     | the observed |     | low-wind | peak |
(range−3.7to1.6°C).
anddampingthetail.
Consistently,theUTCIPDF(bottom-left)inSol_STDis
|     |     |     |     |     |     |     | shifted | towards |            | lower | values | and exhibits | an           | amplified | cold     |
| --- | --- | --- | --- | --- | --- | --- | ------- | ------- | ---------- | ----- | ------ | ------------ | ------------ | --------- | -------- |
|     |     |     |     |     |     |     | tail,   | while   | Sol_WC_UHI |       | moves  | the          | distribution |           | back to- |
wardstheobservedmodeandreducesthespuriouscoldtail.
https://doi.org/10.5194/gmd-19-7389-2026 Geosci.ModelDev.,19,7389–7413,2026

| 7402 |     |     |     |     |     |     | A.Zonatoetal.:GLIDE-SOL |     |     |     |
| ---- | --- | --- | --- | --- | --- | --- | ----------------------- | --- | --- | --- |
Figure 5. Station-level UTCI errors, sorted by observed SVF. Panels summarize RMSE and mean bias (MB) for Sol_STD and
Sol_WC_UHI along the open-to-enclosed urban gradient; LCZ classes are shown as contextual descriptors of the observed station sur-
roundings.ExactnumericvaluesarereportedinAppendixB.
|     |     |     |     | Incontrast,T | PDFs(bottom-right)showonlylimitedsen- |     |     |     |     |     |
| --- | --- | --- | --- | ------------ | ------------------------------------- | --- | --- | --- | --- | --- |
mrt
|     |     |     |     | sitivity to | the applied | corrections, |     | indicating | that | remaining |
| --- | --- | --- | --- | ----------- | ----------- | ------------ | --- | ---------- | ---- | --------- |
errorsaredominatedbyradiativeforcing,surfaceproperties,
andinputuncertaintiesratherthanbyaerodynamicexposure.
3.5 Temporalbehaviorandthermalstresscategories
|     |     |     |     | To assess    | whether | the improvements |     | are     | persistent | rather   |
| --- | --- | --- | --- | ------------ | ------- | ---------------- | --- | ------- | ---------- | -------- |
|     |     |     |     | than limited | to mean | statistics,      | we  | examine | the        | temporal |
evolutionofspatiallyaveragedconditionsacrossallstations
(Figs.9and10)andtheresultingUTCIcategoryfrequencies
|     |     |     |     | (Fig. 11).       | Because | the series | are aggregated |                      | over | the entire |
| --- | --- | --- | --- | ---------------- | ------- | ---------- | -------------- | -------------------- | ---- | ---------- |
|     |     |     |     | station network, | they    | primarily  | reflect        | synoptic-to-seasonal |      |            |
variability,soremainingoffsetsoramplitudeerrorsindicate
systematicbias.
|                    |                  |                  |            | The V        | can time series | (Fig.         | 9) highlights |               | the dominant | de-       |
| ------------------ | ---------------- | ---------------- | ---------- | ------------ | --------------- | ------------- | ------------- | ------------- | ------------ | --------- |
|                    |                  |                  |            | ficiency     | of the baseline | configuration |               | (Sol_STD,     |              | ERA5-     |
|                    |                  |                  |            | driven winds | without         | local         | urban         | diagnostics): |              | winds are |
| Figure 6. Observed | vs. modeled UTCI | for all stations | and hours. |              |                 |               |               |               |              |           |
The baseline Sol_STD shows a systematic cold bias, whereas systematically too strong for the urban canopy and exhibit
Sol_WC_UHIconcentratesclosertothe1:1line,consistentwith frequent high-wind excursions that are not present in the
Sol_STD,
improvedwindandtemperatureforcing. observations. In wind speeds repeatedly spike
∼8–12ms−1,
|     |     |     |     | above        |        | whereas | observed |         | winds at | the sta- |
| --- | --- | --- | --- | ------------ | ------ | ------- | -------- | ------- | -------- | -------- |
|     |     |     |     | tion network | remain | mostly  | below    | ∼2ms−1. |          | The com- |
binedroughnessrescalinganddirectionalwind-reductionin
Geosci.ModelDev.,19,7389–7413,2026 https://doi.org/10.5194/gmd-19-7389-2026

A.Zonatoetal.:GLIDE-SOL 7403
Figure 7. Observed vs. modeled (left) Tmrt, (center) canopy wind speed Vcan, and (right) air temperature for all stations and hours. The
baseline run (Sol_STD; labeled Sol_STD in the panel titles) shows large wind-speed overestimation and a cold bias in Ta, while the
diagnosticwindandUHIcorrectionsinSol_WC_UHIreducebiasandRMSE,particularlyforVcan.
Figure8.Probabilitydensityfunctionsforcanopyairtemperature,canopywindspeedVcan,UTCI,andTmrt.Modelcurvesarecompared
withobservations(black).ThecombinedwindandUHIcorrectionsinSol_WC_UHIsuppressthespurioushigh-windtailandremovemost
oftheUTCIcoldshiftpresentinSol_STD.
Sol_WC_UHIsuppresstheseexcursionsandconstrainsim- tiallyreducesthisoffsetandreproducestheseasonalprogres-
ulatedwindstotheobservedenvelopewhilepreservingsyn- sion and much of the event-to-event variability. Periods of
optic variability. This correction is critical because UTCI is largestdisagreementinSol_STDcoincidewithintervalsof
highlysensitivetonear-surfacewindundercoldandmoder- excessivewindsinFig.9,indicatingthatunrealisticaerody-
ateconditions. namicexposuretoERA5windsisakeydriverofthebaseline
Consistent with the wind behavior, the UTCI time series UTCIbias.ThenocturnalUHIadjustmentprovidesanaddi-
(Fig.10)showsapersistentcoldbiasinSol_STDthrough- tionalcontributionunderstablenight-timeconditions.
outtheevaluationperiod,includingexaggeratednegativeex- The improved continuous UTCI signal translates into
cursionsduringcold-seasonoutbreaksanddampedsummer a more realistic partitioning into thermal stress categories
peaks. The corrected configuration Sol_WC_UHI substan- (Fig. 11). In the baseline case, the systematic cold shift re-
https://doi.org/10.5194/gmd-19-7389-2026 Geosci.ModelDev.,19,7389–7413,2026

| 7404 |     |     |     |     |     |     | A.Zonatoetal.:GLIDE-SOL |     |     |
| ---- | --- | --- | --- | --- | --- | --- | ----------------------- | --- | --- |
Figure9.TimeseriesofspatiallyaveragedcanopywindspeedVcanoverallstations.ThebaselineSol_STDshowsfrequentunrealistically
highwinds,whereasSol_WC_UHIlargelyalignswithobservedmagnitudesafterroughnessrescalinganddirectionalwind-reduction.
Figure 10. Time series of spatially averaged UTCI over all stations. Sol_STD remains systematically colder than observations, while
Sol_WC_UHIreducestheoffsetandbetterreproducestheseasonalcycleandevent-to-eventvariability.
distributes hours from “no thermal stress” into cold-stress tionsymbolsreinforcethispattern,withinner-citysitesmov-
classes: Sol_STD overestimates moderate and strong cold ingtowardobservedfrequencieswhileperipheralsitesretain
| stress by | +23.1 and +2.5 | percentage | points, | and underesti- | lowerfractions. |     |     |     |     |
| --------- | -------------- | ---------- | ------- | -------------- | --------------- | --- | --- | --- | --- |
mates“nothermalstress”by−22.5percentagepoints.With Insummer(JJA),“moderateheatstress”(26–32°CUTCI)
Sol_WC_UHI,categorybiasesarewithinafewpercentage
showsastrongspatialcontrasttiedtourbanformandventi-
pointsacrossthespectrum(e.g.,slightcoldstress+2.8per- lation(Fig.13).InSol_STD,moderateheat-stressfrequen-
centagepoints,moderatecoldstress+2.0percentagepoints, cies are muted and relatively flat, consistent with the ten-
and no thermal stress −4.6 percentage points), and warm- dency to damp warm-season stress through excessive wind
seasonheatstressfrequenciesaligncloselywiththeobserva- speedsevenindenseneighborhoods.WithSol_WC_UHI,a
tions. Beyond station-based aggregation, the impact of the center-to-outskirtsgradientbecomesvisible:higherfractions
diagnostics is reflected in the spatial mapping of category emergeovercompact,wind-shelteredurbanfabricandheav-
frequenciesacross theDortmunddomain (Figs.12 and13), ily built corridors, while parks, green areas, and the outer
whichdetermineswherecoldandheatstressexposureaccu- suburban fringe retain low values. Station symbols indicate
mulates. thatthecorrectedconfigurationbettercapturesboththeele-
In winter (DJF), the fraction of hours in the “slight cold vatedinner-cityfrequenciesandthelowerperipheralvalues
stress”category(0–9°CUTCI)providesasensitivediagnos- withoutoverstatingtheoveralloccurrence.
| tic of the    | model’s cold shift:     | if UTCI     | is systematically | un-          |     |     |     |     |     |
| ------------- | ----------------------- | ----------- | ----------------- | ------------ | --- | --- | --- | --- | --- |
| derestimated, | hours are redistributed |             | from this         | intermediate |     |     |     |     |     |
| class into    | moderate and strong     | cold-stress | categories.       | Fig-         |     |     |     |     |     |
4 Discussion
| ure 12 shows | that Sol_STD | assigns | uniformly | low frac- |     |     |     |     |     |
| ------------ | ------------ | ------- | --------- | --------- | --- | --- | --- | --- | --- |
tions across the domain, masking the expected center-to- TheDortmundevaluationdemonstratesthattwolightweight
| periphery | contrast. With Sol_WC_UHI, |     | a clear | urban-core |             |               |                  |       |           |
| --------- | -------------------------- | --- | ------- | ---------- | ----------- | ------------- | ---------------- | ----- | --------- |
|           |                            |     |         |            | diagnostics | – directional | wind attenuation | and a | nocturnal |
signal emerges, with higher slight-cold frequencies over UHI adjustment – substantially reduce the cold bias that
dense city fabric and lower values over parks, open areas, ariseswhenSOLWEIGisforceddirectlywithcoarsereanal-
| and the peri-urban | fringe where | ventilation | is  | stronger. Sta- |              |                 |               |            |       |
| ------------------ | ------------ | ----------- | --- | -------------- | ------------ | --------------- | ------------- | ---------- | ----- |
|                    |              |             |     |                | ysis fields. | In the baseline | configuration | (Sol_STD), | near- |
Geosci.ModelDev.,19,7389–7413,2026 https://doi.org/10.5194/gmd-19-7389-2026

A.Zonatoetal.:GLIDE-SOL 7405
Figure 11. Hours per UTCI category across all stations. Bars show observed and simulated fractions; numbers above model bars indi-
catemodel–observationdifferencesinpercentagepoints.Sol_WC_UHImarkedlyimprovesthecategorydistributionrelativetoSol_STD,
particularlybyreducingspuriouscold-stressfrequenciesandrestoringtheobserveddominanceof“nothermalstress”.
Figure12.Fractionofhoursclassifiedas“slightcoldstress”(UTCI)inDJF,consideringallhours.Left:Sol_STD.Right:Sol_WC_UHI.
Circlesdenotestationlocations;foreachstation,thelefthalfofthesymbolrepresentsobservedfrequencies,whiletherighthalfshowsthe
correspondingmodelvalue.
surfacewindsaretoostrongfortheurbancanopyandnight- calexposureandrepresentativeness(e.g.,site-specificshield-
time air temperature is underestimated, producing a persis- ing)stillmatter,buttoamuchlesserextentthantheforcing
tentcoldoffsetandanexaggeratedcoldtailinUTCI(Figs.10 bias.
and 8). The temporal and category analyses indicate that ThediagnosticUHIcycleprovidesacomplementarycor-
the corrections improve not only mean skill but also event- rection that is most relevant under stable nocturnal condi-
scalevariabilityandthepartitioningofhoursintocold-and tions, particularly in winter. It shifts the distributions of air
heat-stress classes, which is essential for exposure assess- temperatureandUTCItowardstheobservationsandreduces
ments. Because the workflow is driven by globally avail- extreme cold-stress episodes (Figs. 8 and 10). Its simple
able inputs and standardized preprocessing, these gains are structure keeps computational cost low and enables consis-
achieved without bespoke local data assembly, supporting tent application across regions, but the residual positive T
a
consistentmulti-cityapplications. biasinSol_WC_UHI(Table1)indicatesthatasinglediag-
The wind diagnostic is the dominant contributor to the nosticparametersetcannotcapturethefullrangeofsynoptic
UTCI improvement. By imprinting building and tree mor- regimes and advective effects. The local vegetation term in
phologyontothecanopywindthroughthecoefficientfields the present UHI parameterization is another simplification,
C(x,θ)(Fig.3),Sol_WC_UHIremovesthespurioushigh- and future versions should replace it with a stability-aware
windtail(Fig.8)andnearlyeliminatesthewind-speedbias neighborhood representation of vegetation cooling. Wind is
(Table1),consistentwithRöckle-styleconceptualizationsof thedominantcontributortotheall-hourUTCIimprovement,
urban flow (Röckle, 1990). The resulting spatial gradients whilefutureworkshouldfurtherimprovethereproductionof
align with dense urban cores and more ventilated outskirts, airtemperature.
reinforcingthephysicalconsistencyoftheapproach.There- T improvements are comparatively modest (Table 1;
mrt
mainingstation-to-stationspreadsuggeststhatunresolvedlo- Figs.7and8),consistentwithT beingdrivenprimarilyby
mrt
https://doi.org/10.5194/gmd-19-7389-2026 Geosci.ModelDev.,19,7389–7413,2026

7406 A.Zonatoetal.:GLIDE-SOL
Figure13.Fractionofhoursclassifiedas“moderateheatstress”(UTCI)inJJA,consideringallhours.Left:Sol_STD.Right:Sol_WC_UHI.
Circlesdenotestationlocations;foreachstation,thelefthalfofthesymbolrepresentsobservedfrequencies,whiletherighthalfshowsthe
correspondingmodelvalue.
radiativeforcingandurbangeometry.BecausetheDortmund Limitations of the present demonstration include uncer-
simulations use the SOLWEIG v2022a anisotropic diffuse- tainty in open building and tree-height products, a simpli-
shortwave and longwave sky schemes (Wallenberg et al., fied diagnostic representation of urban heat storage, and re-
2020, 2023), the remaining T bias cannot be attributed liance on coarse ERA5 forcing that omits mesoscale circu-
mrt
simply to an omitted isotropic-sky approximation. Air tem- lationsandcity-wideadvection(Kittneretal.,2025).Addi-
perature (T ) influences T mostly indirectly: it modu- tional limitations are the absence of an urban modification
a mrt
lates atmospheric longwave emission (through sky emissiv- torelativehumidity,thelackofanthropogenicheatcontribu-
ity) and, in SOLWEIG, it is used to parameterize surround- tions from building heating/cooling and traffic, and the use
ingsurfacetemperatures,includingwalltemperature(T ), ofasimplifiedurbanwind-reductionmodelthatcannotfully
wall
whichinturnaffectsthelongwaveradiationreceivedbythe capturelocalchannelingorsheltering,doesnotenforcemass
pedestrian.Remainingdiscrepancieslikelyreflectuncertain- conservation, and does not include terrain-following wind
ties in morphology and surface properties and missing pro- coordinates. Several numerical choices in the current wind
cesses such as anthropogenic heat and its effect on surface implementation–includingthenumberofwindsectors,the
temperaturesandlong-waveemission,especiallyduringthe wake-lengthmultipliers,andtheGaussiansmoothinglength
heatingseason(Liuetal.,2023;Wallenbergetal.,2026).In – were selected pragmatically for robustness and compu-
aglobalcontext,improvingcanopyandsurfacecharacteriza- tational efficiency rather than calibrated independently. Fu-
tionlayersisthereforeakeypathtofurthergainsinradiative ture versions should introduce a stability-dependent repre-
skill. sentation of intra-urban UHI variability, because the phys-
The T observations should also be interpreted in the ically relevant blending scale depends on atmospheric sta-
mrt
contextofthemeasurementsetup.IntheDortmundnetwork, bility, turbulence, and advection, as shown experimentally
T is derived from black-globe temperature and accompa- for urban green-space cooling by Haeffelin et al. (2024).
mrt
nying meteorological measurements following International Stability-dependentspatialsmoothingorneighborhood-scale
Electrotechnical Commission (2021) using Decentlab DL- vegetationmetricsremainimportantsensitivitytests.Future
BLGsensors.Theseobservationswerenotcalibratedinthis work should therefore evaluate the diagnostics across mul-
study against 3-D net radiometers, so no calibration-based tiple cities and climates, quantify sensitivity to morphol-
adjustmentwasappliedbeforemodelevaluation. ogy and roughness assumptions, test alternative directional
Fromamodelingandreproducibilitystandpoint,GLIDE- andsmoothingsettings,performcomponent-ablationexperi-
SOL addresses scalability constraints that often limit city- mentsforwind,elevation,andUHIcorrections,andexplore
scale, meter-scale applications. GPU acceleration reduces couplingtheUHIsignaltomesoscalepredictors,modeledra-
wall-clock time by about a factor of five for the Dortmund diationandwind,urbancanopyschemes,orterrain-awaredi-
benchmark.DeferredLERC+ZSTDrepackingreducesout- agnosticwindformulationssuchasterrain-followingQUIC-
put volumes by about 92% while enforcing explicit er- URB/QUIC-Firecoordinatesystems(Robinsonetal.,2023),
ror budgets per variable, producing lightweight GeoTIFF withattentiontoregionalvariabilityinglobalinputquality.
archivesthatreduceI/Oandstoragepressure.Togetherwith
the global input pipeline, these features enable multi-year,
city-scale UTCI mapping without prohibitive compute or
storagerequirementsandmakecoordinatedmulti-cityexper-
imentsoperationallyfeasible.
Geosci.ModelDev.,19,7389–7413,2026 https://doi.org/10.5194/gmd-19-7389-2026

| A.Zonatoetal.:GLIDE-SOL |     |     |     |     |     |     |     | 7407 |
| ----------------------- | --- | --- | --- | --- | --- | --- | --- | ---- |
Onthetechnicalside,a24hbenchmarkona3129×3113
5 Conclusions
|     |     |     |     | grid completes | in 254s | on a single NVIDIA | A100 | GPU |
| --- | --- | --- | --- | -------------- | ------- | ------------------ | ---- | --- |
GLIDE-SOLextendsSOLWEIGintoascripted,globallyde- (about 5× faster than CPU-only), and daily outputs can
| ployable | workflow that (i) | builds the full set | of SOLWEIG |            |             |                 |      |     |
| -------- | ----------------- | ------------------- | ---------- | ---------- | ----------- | --------------- | ---- | --- |
|          |                   |                     |            | be reduced | by over 90% | using LERC+ZSTD | with | ex- |
inputs from global data sources with standardized prepro- pliciterrorbudgets.ThecombinationoffastGPUexecution
| cessing, | (ii) adds computationally | cheap diagnostics | to mit- |                 |         |                  |          |        |
| -------- | ------------------------- | ----------------- | ------- | --------------- | ------- | ---------------- | -------- | ------ |
|          |                           |                   |         | and lightweight | GeoTIFF | storage supports | routine, | meter- |
igate known biases in coarse meteorological forcing over resolution UTCI mapping at city scale over multi-year pe-
cities,and(iii)enablesscalablesimulationsthroughGPUac- riods,enablingconsistentmulti-citybenchmarking,scenario
celerationandbounded-erroroutputcompressionthatyields
|     |     |     |     | testing, | and evaluation | of heat-mitigation | strategies | at re- |
| --- | --- | --- | --- | -------- | -------------- | ------------------ | ---------- | ------ |
lightweight GeoTIFF archives for long-term analyses. The gionaltoglobalscales.
automateddata-engineandconfiguration-drivenpipelineare
| key novelties | that make city-scale | UTCI | mapping repro- |     |     |     |     |     |
| ------------- | -------------------- | ---- | -------------- | --- | --- | --- | --- | --- |
ducibleandtransferablewithoutbespokelocaldatasets.
| For Dortmund | (25 stations; | more than 250000 | station– |     |     |     |     |     |
| ------------ | ------------- | ---------------- | -------- | --- | --- | --- | --- | --- |
hourrecords),theenhancedconfigurationSol_WC_UHIre-
ducesUTCIRMSEfrom8.09to2.84°Candthemeanbias
from−7.07to−0.85°C.Theimprovementisdrivenprimar-
2.18→0.03ms−1),
| ily by correcting | the wind   | speed (bias       |             |     |     |     |     |     |
| ----------------- | ---------- | ----------------- | ----------- | --- | --- | --- | --- | --- |
| with additional   | gains from | the nocturnal UHI | adjustment. |     |     |     |     |     |
Beyondmeanskill,thecorrectionsrestorethetemporalevo-
| lution of | UTCI, reduce spurious | cold-stress | hours, and re- |     |     |     |     |     |
| --------- | --------------------- | ----------- | -------------- | --- | --- | --- | --- | --- |
coverrealisticspatialcontrastsinwintercoldstressandsum-
| mer heat-stress | hotspots, indicating | that globally | driven di- |     |     |     |     |     |
| --------------- | -------------------- | ------------- | ---------- | --- | --- | --- | --- | --- |
agnosticscanreproducebothtemporalandspatialexposure
signatures.
https://doi.org/10.5194/gmd-19-7389-2026 Geosci.ModelDev.,19,7389–7413,2026

7408 A.Zonatoetal.:GLIDE-SOL
AppendixA: Wind-modelcomparison
TableA1.ComparisonbetweenthediagnosticwindtreatmentimplementedinGLIDE-SOLandthefullRöckle/URockmethodology.
Modelcomponent URock(Röckle-based) GLIDE-SOL
Winddirections Continuouswinddirectionthroughdomainrotation 12precomputedwindsectors(30°spacing).
andgeometrytransformation
Flowsolution Initialempiricalwindfieldfollowedbyaniterative Single-passattenuationmodel;nomass-conservation
mass-conservationsolver correction.
Buildingwake 3-DRöcklezoneswithellipsoidaldisplacement, Onlyupwindandleewardattenuationalongthe
geometry cavity,wake,rooftopandcornerregions wind-alignedxdirection;noexplicit3-Dwake
geometry.
Zoneinteractions ExplicittreatmentofoverlappingRöcklezones, Overlappingreductionscombinedthroughraster
backwardwakesandpriorityrules operationsandGaussiansmoothing.
Streetcanyons Explicitstreet-canyoncirculationmodel Notrepresented.
Vegetation Dedicatedvegetationzones(openandbuilt-up Vegetationtreatedasporousobstacleswithcanopy
canopies)withspecificwind-factorformulations,but attenuationandbuilding-likeupwind/leewardinfluence
withoutthebuilding-likeupwind/leewardinfluence zones.
zonesusedinGLIDE-SOL
Terrain Noterrain-followingcoordinatetransformation. Noterrain-followingcoordinatetransformation.
Computationalcost 3-Dvoxelmodelwithiterativesolver 2-Drasterdiagnosticmodeldesignedforfast
computation.
Geosci.ModelDev.,19,7389–7413,2026 https://doi.org/10.5194/gmd-19-7389-2026

A.Zonatoetal.:GLIDE-SOL 7409
AppendixB: Station-levelUTCIerrors
TableB1.UTCIerrorsbystation(sortedbySVFobs).LCZclassesaretakenfromthefield-basedstationmetadataandarereportedhereas
contextualdescriptorsoftheobservedstationsurroundings.Boldindicateslowesterrorforeachstationandmetric.
| Station LCZ | SVFobs SVFmod | RMSE(°C)           |         | MB(°C)     |
| ----------- | ------------- | ------------------ | ------- | ---------- |
|             |               | Sol_STD Sol_WC_UHI | Sol_STD | Sol_WC_UHI |
−7.51
| BHS | 5 – 0.03    | 8.09 | 2.82       | −0.86 |
| --- | ----------- | ---- | ---------- | ----- |
| GAS | 9 0.20 0.20 | 7.85 | 2.27 −6.92 | −1.02 |
| WEP | B 0.22 0.43 | 8.18 | 2.11 −7.30 | −0.60 |
| OHS | 6 0.23 0.64 | 8.67 | 2.63 −7.56 | −1.06 |
| BRS | 2 0.23 0.34 | 9.43 | 1.70 −8.37 | −0.24 |
−7.37 −0.97
| CLA | 5 0.32 0.33 | 8.16 | 2.28       |       |
| --- | ----------- | ---- | ---------- | ----- |
| BOL | 9 0.36 0.34 | 8.17 | 3.16 −6.61 | −1.48 |
| SBA | 4 0.38 0.70 | 7.73 | 2.11 −6.57 | −0.06 |
| HAP | 5 0.38 0.86 | 8.84 | 3.44 −7.42 | −1.06 |
| DKP | 6 0.43 0.43 | 8.73 | 2.53 −8.04 | −1.22 |
−6.31
| HKS | 6 0.45 0.75 | 7.40 | 2.48       | 0.14  |
| --- | ----------- | ---- | ---------- | ----- |
| DOU | 4 0.46 0.47 | 7.09 | 3.48 −6.01 | 1.59  |
| NOM | 6 0.46 0.47 | 9.00 | 2.91 −8.23 | −1.95 |
| GWS | 6 0.47 0.73 | 8.37 | 2.13 −7.34 | 0.16  |
| HAN | 4 0.51 0.79 | 8.43 | 2.48 −7.11 | 0.11  |
−5.44
| MSP | 5 0.58 0.58 | 6.21 | 2.67       | 1.18  |
| --- | ----------- | ---- | ---------- | ----- |
| PSW | 5 0.62 0.87 | 8.67 | 2.50 −7.64 | −1.21 |
| WFP | B 0.64 0.90 | 7.90 | 4.27 −7.10 | −3.55 |
| DHS | 6 0.64 0.87 | 8.19 | 2.49 −7.13 | −0.96 |
| KPW | 5 0.65 0.65 | 8.33 | 2.83 −7.46 | −1.01 |
| WFH | 5 0.65 0.65 | 7.30 | 2.44 −6.53 | −0.46 |
−6.14
| FRP    | 5 0.66 0.92 | 7.08 | 2.74       | −0.80 |
| ------ | ----------- | ---- | ---------- | ----- |
| HBF    | 2 0.71 0.93 | 7.94 | 3.32 −6.96 | −1.98 |
| SPS 10 | 0.71 0.72   | 7.10 | 2.93 −5.81 | −0.57 |
| PHX    | 5 0.71 0.95 | 8.27 | 4.45 −7.37 | −3.66 |
https://doi.org/10.5194/gmd-19-7389-2026 Geosci.ModelDev.,19,7389–7413,2026

| 7410 |     |     |     |     |     |     |     |     |     |     | A.Zonatoetal.:GLIDE-SOL |     |     |     |
| ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------------------- | --- | --- | --- |
Codeanddataavailability. The GLIDE-SOL source code is DortmundstationnetworkwasfundedbyICLEIEuropethroughthe
archived on Zenodo (Zonato et al., 2026) and is available at ICLEIActionFund2.0,supportedbyGoogle.org,undertheproject
https://doi.org/10.5281/zenodo.18671813.TheZenodoarchivepro- “Data2Resilience”(D2R);theimplementationwasfundedthrough
videsacitablerelease,whileongoingusersupport,bugreports,and SmartCityDortmund.
communityinteractionareintendedtobehandledthroughtheas-
sociatedpubliccoderepositoryandissuetracker.Theobservational
datasetusedfortheDortmundevaluationisavailableonZenodoat Reviewstatement. This paper was edited by Dalei Hao and re-
https://doi.org/10.5281/zenodo.18221203(Hüseretal.,2026).The
|                    |     |       |     |                 |     |             |     | viewed by | Fredrik | Lindberg, | Jérémy | Bernard, | and | Ferdinand |
| ------------------ | --- | ----- | --- | --------------- | --- | ----------- | --- | --------- | ------- | --------- | ------ | -------- | --- | --------- |
| GPU implementation |     | draws | on  | the open-source |     | SOLWEIG-GPU |     |           |         |           |        |          |     |           |
Briegel.
| project and | the | implementations |     | discussed | in  | this paper | are also |     |     |     |     |     |     |     |
| ----------- | --- | --------------- | --- | --------- | --- | ---------- | -------- | --- | --- | --- | --- | --- | --- | --- |
availableathttps://github.com/nvnsudharsan/SOLWEIG-GPU/tree/
main(lastaccess:29July2026).
References
Adinolfi,M.,Raffa,M.,Reder,A.,andMercogliano,P.:Investiga-
| Authorcontributions. |     | A.Z. | developed |     | and integrated |     | the GLIDE- |     |     |     |     |     |     |     |
| -------------------- | --- | ---- | --------- | --- | -------------- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- |
tiononpotentialandlimitationsofERA5Reanalysisdownscaled
SOLworkflow,implementedthesoftware,conductedthecomputa-
tionalexperiments,andwrotetheoriginaldraft.M.D.contributedto on Italy by a convection-permitting model, Clim. Dynam., 61,
theconceptualizationandmethodologyandco-developedthesoft- 4319–4342,https://doi.org/10.1007/s00382-023-06803-w,2023.
|     |     |     |     |     |     |     |     | Aydin, Y., | Janke, | J., and Middleton, |     | R.: A comparative |     | review |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ------ | ------------------ | --- | ----------------- | --- | ------ |
wareandexperiments.H.G.K.andN.S.contributedtotheGPUand
|          |                |     |               |     |                   |     |         | of microclimate |     | and thermal | comfort | models: | RayMan, | ENVI- |
| -------- | -------------- | --- | ------------- | --- | ----------------- | --- | ------- | --------------- | --- | ----------- | ------- | ------- | ------- | ----- |
| software | implementation |     | and supported |     | the computational |     | experi- |                 |     |             |         |         |         |       |
met,SOLWEIG,andSTEVE,Sustain.CitiesSoc.,46,101–126,
| ments. L.M. | contributed |     | to the | software | and workflow |     | implemen- |     |     |     |     |     |     |     |
| ----------- | ----------- | --- | ------ | -------- | ------------ | --- | --------- | --- | --- | --- | --- | --- | --- | --- |
tationandsupportedthecomputationalexperiments.J.K.andL.W. https://doi.org/10.1016/j.scs.2018.12.019,2019.
contributedtothemethodologyandpaperorganization,curatedand Bernard, J., Lindberg, F., and Oswald, S.: URock 2023a:
|           |                   |     |           |     |             |        |           | an open-source  |     | GIS-based |       | wind model | for | complex    |
| --------- | ----------------- | --- | --------- | --- | ----------- | ------ | --------- | --------------- | --- | --------- | ----- | ---------- | --- | ---------- |
| processed | the observational |     | datasets, |     | contributed | to the | analysis, |                 |     |           |       |            |     |            |
|           |                   |     |           |     |             |        |           | urban settings, |     | Geosci.   | Model | Dev.,      | 16, | 5703–5727, |
andcontributedsubstantiallytothewritingofthetextandfigures.
https://doi.org/10.5194/gmd-16-5703-2023,2023.
B.B.contributedtothecurationandprocessingoftheobservational
datasets.A.M.andM.M.contributedtotheinterpretationofthere- Bolton, D.: The computation of equivalent po-
sultsandtherevisionofthemanuscript.Allauthorsreviewedand tential temperature, Mon. Weather Rev.,
|     |     |     |     |     |     |     |     | 108, | 1046–1053, |     |     | https://doi.org/10.1175/1520- |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---- | ---------- | --- | --- | ----------------------------- | --- | --- |
approvedthefinalmanuscript.
0493(1980)108<1046:TCOEPT>2.0.CO;2,1980.
|     |     |     |     |     |     |     |     | Briegel, F., | Wehrle, | J., Schindler, |     | D., and Christen, |     | A.: High- |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | ------- | -------------- | --- | ----------------- | --- | --------- |
resolutionmulti-scalingofoutdoorhumanthermalcomfortand
| Competinginterests. |     | Thecontactauthorhasdeclaredthatnoneof |     |     |     |     |     |                 |             |     |       |            |           |         |
| ------------------- | --- | ------------------------------------- | --- | --- | --- | --- | --- | --------------- | ----------- | --- | ----- | ---------- | --------- | ------- |
|                     |     |                                       |     |     |     |     |     | its intra-urban | variability |     | based | on machine | learning, | Geosci. |
theauthorshasanycompetinginterests.
|     |     |     |     |     |     |     |     | Model Dev., | 17, | 1667–1688, | https://doi.org/10.5194/gmd-17- |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | --- | ---------- | ------------------------------- | --- | --- | --- |
1667-2024,2024.
|              |             |                   |       |            |              |        |            | Buo, I.,   | Sagris,   | V., Jaagus, | J., | and Middel,  |      | A.: High- |
| ------------ | ----------- | ----------------- | ----- | ---------- | ------------ | ------ | ---------- | ---------- | --------- | ----------- | --- | ------------ | ---- | --------- |
| Disclaimer.  | Publisher’s |                   | note: | Copernicus | Publications |        | remains    |            |           |             |     |              |      |           |
|              |             |                   |       |            |              |        |            | resolution | thermal   | exposure    |     | and shade    | maps | for cool  |
| neutral with | regard      | to jurisdictional |       | claims     | made         | in the | text, pub- |            |           |             |     |              |      |           |
|              |             |                   |       |            |              |        |            | corridor   | planning, | Sustain.    |     | Cities Soc., | 93,  | 104499,   |
lishedmaps,institutionalaffiliations,oranyothergeographicalrep-
https://doi.org/10.1016/j.scs.2023.104499,2023.
resentationinthispaper.Theauthorsbeartheultimateresponsibil-
|     |     |     |     |     |     |     |     | Cheng, W.-C. | and | Porté-Agel, | F.: | Adjustment | of  | Turbulent |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | --- | ----------- | --- | ---------- | --- | --------- |
ityforprovidingappropriateplacenames.Viewsexpressedinthe
|     |     |     |     |     |     |     |     | Boundary-Layer |     | Flow to | Idealized | Urban | Surfaces: | A Large- |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------- | --- | ------- | --------- | ----- | --------- | -------- |
textarethoseoftheauthorsanddonotnecessarilyreflecttheviews Eddy Simulation Study, Bound.-Lay. Meteorol., 155, 249–270,
ofthepublisher.
https://doi.org/10.1007/s10546-015-0004-1,2015.
|     |     |     |     |     |     |     |     | Cheng, Y., | Niu, J.,  | and Gao,       | N.: Thermal | comfort          | models: | A re-      |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | --------- | -------------- | ----------- | ---------------- | ------- | ---------- |
|     |     |     |     |     |     |     |     | view and   | numerical | investigation, |             | Build. Environ., |         | 47, 13–22, |
Financialsupport. Contributions from A.Z. and L.M. were sup- https://doi.org/10.1016/j.buildenv.2011.05.011,2012.
ported by the RETURN project (Multi-risk Science for Resilient Chu,R.andWang,K.:CFDinUrbanWindResourceAssessments:
| Communities | under   | a Changing |     | Climate), | part     | of the | Extended |           |           |     |                                     |     |     |     |
| ----------- | ------- | ---------- | --- | --------- | -------- | ------ | -------- | --------- | --------- | --- | ----------------------------------- | --- | --- | --- |
|             |         |            |     |           |          |        |          | A Review, | Energies, | 18, | https://doi.org/10.3390/en18102626, |     |     |     |
| Partnership | program | funded     |     | by the    | European | Union  | through  |           |           |     |                                     |     |     |     |
2025.
NextGenerationEUunderItaly’sNationalRecoveryandResilience Cionco,R.M.:Awind-profileindexforcanopyflow,Bound.-Lay.
Plan (NRRP), Mission 4, Component 2, Investment 1.3 (De- Meteorol., 3, 255–263, https://doi.org/10.1007/BF02033923,
| cree No. | 341 of | 15 March | 2022, | Project | Code | PE00000005, |     | 1972. |     |     |     |     |     |     |
| -------- | ------ | -------- | ----- | ------- | ---- | ----------- | --- | ----- | --- | --- | --- | --- | --- | --- |
CUPD53C22002510002).ContributionsfromA.Z.andL.C.were
Emmanuel,R.andFernando,H.J.S.:Urbanheatislandsinhumid
| also partially | supported |     | by Agenzia |     | ItaliaMeteo. | Contributions |     |     |     |     |     |     |     |     |
| -------------- | --------- | --- | ---------- | --- | ------------ | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
andaridclimates:roleofurbanformandthermalpropertiesin
from M.D. were supported by the European Union’s HORI- Colombo, Sri Lanka and Phoenix, USA, Clim. Res., 34, 241–
ZONResearchandInnovationActionsundergrantagreementNo. 251,https://doi.org/10.3354/cr00694,2007.
101137851–CARMINE.ContributionsfromA.M.weresupported Fiala, D., Havenith, G., Bröde, P., Kampmann, B., and Jen-
| by the U.S. | National | Science |     | Foundation, | grant | number | CMMI- |     |     |     |     |     |     |     |
| ----------- | -------- | ------- | --- | ----------- | ----- | ------ | ----- | --- | --- | --- | --- | --- | --- | --- |
dritzky,G.:UTCI-Fialamulti-nodemodelofhumanheattrans-
| 1942805 | (CAREER: | Human | Thermal |     | Exposure | in Cities | – Novel |     |     |     |     |     |     |     |
| ------- | -------- | ----- | ------- | --- | -------- | --------- | ------- | --- | --- | --- | --- | --- | --- | --- |
ferandtemperatureregulation,Int.J.Biometeorol.,56,429–441,
SensingandModelingtoBuildHeat-Resilience).Thedesignofthe https://doi.org/10.1007/s00484-011-0424-7,2012.
Geosci.ModelDev.,19,7389–7413,2026 https://doi.org/10.5194/gmd-19-7389-2026

A.Zonatoetal.:GLIDE-SOL 7411
Gorelick, N., Hancher, M., Dixon, M., Ilyushchenko, S., Thau, of single urban trees – application for outdoor thermal
D., and Moore, R.: Google Earth Engine: Planetary-scale comfort modelling, Theor. Appl. Climatol., 117, 363–376,
geospatial analysis, Remote Sens. Environ., 202, 18–27, https://doi.org/10.1007/s00704-013-1000-3,2014.
https://doi.org/10.1016/j.rse.2017.06.031,2017. Kusaka, H., Ikeda, R., Sato, T., Iizuka, S., and Boku, T.: De-
Grandoni, L., Michard, M., Grosjean, N., and Salizzoni, P.: The velopment of a Multi-Scale Meteorological Large-Eddy Simu-
dynamics of a wake behind an isolated model tree within an lation Model for Urban Thermal Environmental Studies: The
atmospheric boundary layer, Bounda.-Lay. Meteorol., 192, 26, “City-LES” Model Version 2.0, J. Adv. Model. Earth Sy.,
https://doi.org/10.1007/s10546-026-00971-y,2026. 16, e2024MS004367, https://doi.org/10.1029/2024MS004367,
Haeffelin,M.,Ribaud,J.-F.,Céspedes,J.,Dupont,J.-C.,Lemonsu, 2024.
A., Masson, V., Nagel, T., and Kotthaus, S.: Impact of bound- Lang, N., Jetz, W., Schindler, K., and Wegner, J. D.: A high-
arylayerstabilityonurbanparkcoolingeffectintensity,Atmos. resolutioncanopyheightmodeloftheEarth,Nat.Ecol.Evol.,7,
Chem.Phys.,24,14101–14122,https://doi.org/10.5194/acp-24- 1778–1789,https://doi.org/10.1038/s41559-023-02206-6,2023.
14101-2024,2024. Li, X. and Wang, G.: GPU parallel computing for map-
Hersbach, H., Bell, B., Berrisford, P., Hirahara, S., Horányi, A., ping urban outdoor heat exposure, Theor. Appl. Climatol.,
Muñoz-Sabater, J., Nicolas, J., Peubey, C., Radu, R., Schep- https://doi.org/10.1007/s00704-021-03692-z,2021.
ers, D., Simmons, A., Soci, C., Abdalla, S., Abellan, X., Bal- Li, X., Wang, G., Zaitchik, B., Hsu, A., and Chakraborty, T. C.:
samo,G.,Bechtold,P.,Biavati,G.,Bidlot,J.,Bonavita,M.,De Sensitivity and vulnerability to summer heat extremes in ma-
Chiara,G.,Dahlgren,P.,Dee,D.,Diamantakis,M.,Dragani,R., jorcitiesoftheUnitedStates,Environ.Res.Lett.,19,094039,
Flemming,J.,Forbes,R.,Fuentes,M.,Geer,A.,Haimberger,L., https://doi.org/10.1088/1748-9326/ad6c64,2024.
Healy,S.B.,Hogan,R.J.,Hólm,E.,Janisková,M.,Keeley,S., Lindberg, F. and Grimmond, C. S. B.: The influence of veg-
Laloyaux, P., Lopez, P., Lupu, C., Radnóti, G., de Rosnay, P., etation and building morphology on shadow patterns and
Rozum, I., Vamborg, F., Villaume, S., and Thépaut, J.-N.: The mean radiant temperatures in urban areas: model develop-
ERA5 global reanalysis, Q. J. Roy. Meteor. Soc., 146, 1999– ment and evaluation, Theor. Appl. Climatol., 105, 311–323,
2049,https://doi.org/10.1002/qj.3803,2020. https://doi.org/10.1007/s00704-010-0382-8,2011a.
Höppe, P.: The physiological equivalent temperature – a Lindberg, F. and Grimmond, C. S. B.: Nature of vegetation and
universal index for the biometeorological assessment of building morphology characteristics across a city: Influence on
the thermal environment, Int. J. Biometeorol., 43, 71–75, shadowpatternsandmeanradianttemperaturesinLondon,Ur-
https://doi.org/10.1007/s004840050118,1999. banEcosyst.,14,617–634,https://doi.org/10.1007/s11252-011-
Hüser, C., Wolf, L., Gottschalk, N., Kittner, J., Kraas, B., Mittel- 0184-5,2011b.
städt,C.,Reinhart,V.,Sismanidis,P.,Wawrzyniak,N.,andBech- Lindberg,F.,Holmer,B.,andThorsson,S.:SOLWEIG1.0–Mod-
tel,B.:Data2Resilience–ABiometeorologicalWeatherStation elling spatial variations of 3D radiant fluxes and mean radiant
Network in Dortmund: Station Documentation, Zenodo [data temperatureincomplexurbansettings,Int.J.Biometeorol.,52,
set],https://doi.org/10.5281/zenodo.18221203,2026. 697–713,https://doi.org/10.1007/s00484-008-0162-7,2008.
InternationalElectrotechnicalCommission:Ergonomicsofthether- Lindberg, F., Onomura, S., and Grimmond, C. S. B.: Influence
malenvironment–Instrumentsformeasuringphysicalquantities of ground surface characteristics on the mean radiant tem-
(ISO7726:1998),DINENISO7726:2021-03,Germanversion perature in urban areas, Int. J. Biometeorol., 60, 1439–1452,
ENISO7726:2001,2021. https://doi.org/10.1007/s00484-016-1135-x,2016.
Jänicke, B., Meier, F., Lindberg, F., Schubert, S., and Scherer, Lindberg, F., Grimmond, C. S. B., Gabey, A., Huang, B., Kent,
D.: Towards city-wide, building-resolving analysis of C.W.,Sun,T.,Theeuwes,N.E.,Järvi,L.,Ward,H.C.,Capel-
mean radiant temperature, Urban Climate, 15, 83–98, Timms,I.,Chang,Y.,Jonsson,P.,Krave,N.,Liu,D.,Meyer,D.,
https://doi.org/10.1016/j.uclim.2015.11.003,2016. Olofson, K. F. G., Tan, J., Wästberg, D., Xue, L., and Zhang,
Jendritzky, G., de Dear, R., and Havenith, G.: UTCI – Why Z.:UrbanMulti-scaleEnvironmentalPredictor(UMEP):Anin-
another thermal index?, Int. J. Biometeorol., 56, 421–428, tegrated tool for city-based climate services, Environ. Modell.
https://doi.org/10.1007/s00484-011-0513-7,2012. Softw.,99,70–87,https://doi.org/10.1016/j.envsoft.2017.09.020,
Kamath, H. G., Sudharsan, N., Singh, M., Wallenberg, N., Lind- 2018.
berg, F., and Niyogi, D.: SOLWEIG-GPU: GPU-Accelerated Lindberg,F.,Wallenberg,N.,Thorsson,S.,Haeger-Eugensson,M.,
Thermal Comfort Modeling Framework for Urban Digi- Lönn,J.,Holmberg,B.,Frid,M.,andFahlström,J.:Micro-scale,
tal Twins, Journal of Open Source Software, 11, 9535, city-wideanalysisofoutdoorthermalcomfortduringheatwaves
https://doi.org/10.21105/joss.09535,2026. inhighlatitudecities:influenceofbuildinggeometryandvege-
Kaplan, H. and Dinar, N.: A Lagrangian dispersion model for tation,Int.J.Biometeorol.,https://doi.org/10.1007/s00484-025-
calculatingconcentrationdistributionwithinabuilt-updomain, 03030-2,2025.
Atmos. Environ., 30, 4197–4207, https://doi.org/10.1016/1352- Liu, Y., Luo, Z., and Grimmond, S.: Impact of build-
2310(96)00144-6,1996. ing envelope design parameters on diurnal building an-
Kittner, J., Fenner, D., Demuzere, M., and Bechtel, B.: thropogenic heat emission, Build. Environ., 234, 110134,
Analysis of nocturnal urban heat advection using crowd https://doi.org/10.1016/j.buildenv.2023.110134,2023.
weather stations, Q. J. Roy. Meteor. Soc., 151, e5065, Margairaz, F., Eshagh, H., Nemati Hayati, A., Pardyjak, E. R.,
https://doi.org/10.1002/qj.5065,2025. and Stoll, R.: Development and Evaluation of an Isolated-Tree
Konarska, J., Lindberg, F., Larsson, A., Thorsson, S., and FlowModelforNeutral-StabilityConditions,UrbanClimate,42,
Holmer, B.: Transmissivity of solar radiation through crowns 101083,https://doi.org/10.1016/j.uclim.2022.101083,2022.
https://doi.org/10.5194/gmd-19-7389-2026 Geosci.ModelDev.,19,7389–7413,2026

7412 A.Zonatoetal.:GLIDE-SOL
Maronga, B., Banzhaf, S., Burmeister, C., Esch, T., Forkel, R., Röckle, R.: Bestimmung der Strömungsverhältnisse im Bereich
Fröhlich, D., Fuka, V., Gehrke, K. F., Geleticˇ, J., Giersch, S., komplexerBebauungsstrukturen,Tech.rep.,Fraunhofer-Institut
Gronemeier, T., Groß, G., Heldens, W., Hellsten, A., Hoff- fürBauphysik,1990.
mann, F., Inagaki, A., Kadasch, E., Kanani-Sühring, F., Ke- Romps,D.M.:Exactexpressionfortheliftingcondensationlevel,J.
telsen,K.,Khan,B.A.,Knigge,C.,Knoop,H.,Krcˇ,P.,Kurppa, Atmos.Sci.,74,3891–3900,https://doi.org/10.1175/JAS-D-17-
M., Maamari, H., Matzarakis, A., Mauder, M., Pallasch, M., 0102.1,2017.
Pavlik, D., Pfafferott, J., Resler, J., Rissmann, S., Russo, E., Rothfusz, L. P.: The heat index equation (or, more than you ever
Salim,M.,Schrempf,M.,Schwenkel,J.,Seckmeyer,G.,Schu- wantedtoknowaboutheatindex),FortWorth,Texas:National
bert,S.,Sühring,M.,vonTils,R.,Vollmer,L.,Ward,S.,Witha, OceanicandAtmosphericAdministration,NationalWeatherSer-
B., Wurps, H., Zeidler, J., and Raasch, S.: Overview of the vice, Office of Meteorology, 9023, 640, https://www.weather.
PALMmodelsystem6.0,Geosci.ModelDev.,13,1335–1372, gov/media/ffc/ta_htindx.PDF(lastaccess:29July2026),1990.
https://doi.org/10.5194/gmd-13-1335-2020,2020. Santiago, J. L. and Martilli, A.: A Dynamic Urban Canopy
Mayer, H. and Höppe, P.: Thermal comfort of man in differ- Parameterization for Mesoscale Models Based on Computa-
ent urban environments, Theor. Appl. Climatol., 38, 43–49, tional Fluid Dynamics Reynolds-Averaged Navier–Stokes Mi-
https://doi.org/10.1007/BF00866252,1987. croscale Simulations, Bound.-Lay. Meteorol., 137, 417–439,
Mayer, H., Holst, J., Dostal, P., Imbery, F., and Schindler, https://doi.org/10.1007/s10546-010-9538-4,2010.
D.: Human thermal comfort in summer within an urban Simon, H.: Modeling urban microclimate: development, im-
street canyon in Central Europe, Meteorol. Z., 17, 241–250, plementation and evaluation of new and improved calcula-
https://doi.org/10.1127/0941-2948/2008/0285,2008. tion methods for the urban microclimate model ENVI-met,
Microsoft: Microsoft Global ML Building Footprints, https:// PhD thesis, Johannes Gutenberg-Universität Mainz, Mainz,
planetarycomputer.microsoft.com/dataset/ms-buildings (last ac- https://doi.org/10.25358/openscience-4042,2016.
cess:23June2026),2026. Steadman, R. G.: The assessment of sultriness. Part I: A
Middel, A. and Krayenhoff, E. S.: Micrometeorological de- temperature-humidity index based on human physiology and
terminants of pedestrian thermal exposure during record- clothingscience,J.Appl.Meteorol.Clim.,18,861–873,1979.
breaking heat in Tempe, Arizona: Introducing the MaRTy Theeuwes,N.E.,Steeneveld,G.-J.,Ronda,R.J.,andHoltslag,A.
observational platform, Sci. Total Environ., 659, 129–143, A.M.:Adiagnosticequationforthedailymaximumurbanheat
https://doi.org/10.1016/j.scitotenv.2018.12.166,2019. islandeffectforcitiesinnorthwesternEurope,Int.J.Climatol.,
Oke, T. R., Mills, G., Christen, A., and Voogt, 37,443–454,https://doi.org/10.1002/joc.4717,2016.
J. A.: Urban Climates, Cambridge University Press, Thorsson, S., Lindqvist, M., and Lindberg, F.: Different meth-
https://doi.org/10.1017/9781139016476,2017. ods for estimating the mean radiant temperature in an
Oostwegel, L. J. N., Schorlemmer, D., and Guéguen, P.: From outdoor urban setting, Int. J. Climatol., 27, 1983–1993,
Footprints to Functions: A Comprehensive Global and Se- https://doi.org/10.1002/joc.1537,2007.
mantic Building Footprint Dataset, Sci. Data, 12, 1699, Thorsson,S.,Lindberg,F.,Björklund,J.,Holmer,B.,andRayner,
https://doi.org/10.1038/s41597-025-06132-z,2025. D.: Potential changes in outdoor thermal comfort condi-
OvertureMapsFoundation:OvertureMapsBuildingsGuide,https: tions in Gothenburg, Sweden due to climate change: the in-
//docs.overturemaps.org/guides/buildings/ (last access: 23 June fluence of urban geometry, Int. J. Climatol., 31, 324–335,
2026),2026. https://doi.org/10.1002/joc.2231,2011.
Perez, R., Seals, R., and Michalsky, J.: All-weather model for Tolan, J., Yang, H.-I., Nosarzewski, B., Couairon, G., Vo, H. V.,
sky luminance distribution: preliminary configuration and vali- Brandt, J., Spore, J., Majumdar, S., Haziza, D., Vamaraju, J.,
dation,Sol.Energy,50,235–245,https://doi.org/10.1016/0038- Moutakanni,T.,Bojanowski,P.,Johns,T.,White,B.,Tiecke,T.,
092X(93)90017-I,1993. andCouprie,C.:Veryhighresolutioncanopyheightmapsfrom
Plein, M., Kersten, F., Zeeman, M., and Christen, A.: RGBimageryusingself-supervisedvisiontransformerandcon-
Street-Level Weather Station Network in Freiburg, Ger- volutionaldecodertrainedonaeriallidar,RemoteSens.Environ.,
many: Station Documentation, Tech. rep., Zenodo, 300,113888,https://doi.org/10.1016/j.rse.2023.113888,2024.
https://doi.org/10.5281/zenodo.12732551,2024. Toparlar,Y.,Blocken,B.,Maiheu,B.,andvanHeijst,G.:Areview
Potapov, P., Li, X., Hernandez-Serna, A., Tyukavina, A., Hansen, ontheCFDanalysisofurbanmicroclimate,Renew.Sust.Energ.
M.C.,Kommareddy,A.,Pickens,A.,Turubanova,S.,Tang,H., Rev.,80,1613–1640,https://doi.org/10.1016/j.rser.2017.05.248,
Silva,C.E.,Armston,J.,Dubayah,R.,Blair,J.B.,andHofton, 2017.
M.:Mappingglobalforestcanopyheightthroughintegrationof Wallenberg,N.,Lindberg,F.,Holmer,B.,andThorsson,S.:Thein-
GEDI and Landsat data, Remote Sens. Environ., 253, 112165, fluenceofanisotropicdiffuseshortwaveradiationonmeanradi-
https://doi.org/10.1016/j.rse.2020.112165,2021. anttemperatureinoutdoorurbanenvironments,UrbanClimate,
Reindl,D.T.,Beckman,W.A.,andDuffie,J.A.:Diffusefraction 31,100589,https://doi.org/10.1016/j.uclim.2020.100589,2020.
correlations,Sol.Energy,45,1–7,https://doi.org/10.1016/0038- Wallenberg, N., Lindberg, F., Holmer, B., and Rayner, D.: An
092X(90)90060-P,1990. anisotropicparametrizationschemeforlongwaveirradianceand
Robinson, D., Brambilla, S., Brown, M. J., Conry, P., Quaife, itsimpactonradiantloadinurbanoutdoorsettings,Int.J.Biome-
B., and Linn, R. R.: QUIC-URB and QUIC-Fire exten- teorol.,https://doi.org/10.1007/s00484-023-02441-3,2023.
sion to complex terrain: Development of a terrain-following Wallenberg, N., Holmer, B., Lindberg, F., Lönn, J., Maesel, E.,
coordinate system, Environ. Modell. Softw., 159, 105579, and Rayner, D.: A simple step heating approach for wall sur-
https://doi.org/10.1016/j.envsoft.2022.105579,2023. face temperature estimation in the SOlar and LongWave En-
Geosci.ModelDev.,19,7389–7413,2026 https://doi.org/10.5194/gmd-19-7389-2026

A.Zonatoetal.:GLIDE-SOL 7413
vironmental Irradiance Geometry (SOLWEIG) model, Geosci. Zonato, A., Martilli, A., Di Sabatino, S., Zardi, D., and
Model Dev., 19, 1321–1336, https://doi.org/10.5194/gmd-19- Giovannini, L.: Evaluating the performance of a novel
1321-2026,2026. WUDAPT averaging technique to define urban morphol-
Yamazaki, D., Ikeshima, D., Tawatari, R., Yamaguchi, T., ogy with mesoscale models, Urban Climate, 31, 100584,
O’Loughlin, F., Neal, J. C., Sampson, C. C., Kanae, https://doi.org/10.1016/j.uclim.2020.100584,2020.
S., and Bates, P. D.: A high-accuracy map of global Zonato, A., Martilli, A., Santiago, J. L., Zardi, D., and Giovan-
terrain elevations, Geophys. Res. Lett., 44, 5844–5853, nini,L.:Onanewone-dimensionalk−εturbulenceclosurefor
https://doi.org/10.1002/2017GL072874,2017. building-induced drag, Q. J. Roy. Meteorol. Soc., 149, 1674–
Yang, M., Oh, G., Xu, T., Kim, J., Kang, J.-H., and 1689,https://doi.org/10.1002/qj.4476,2023.
Choi, J.-I.: Multi-GPU-based real-time large-eddy simula- Zonato, A., Kamath, H. G., Sudharsan, N., Monaco, L.,
tions for urban microclimate, Build. Environ., 245, 110856, Kittner, J., Wolf, L., Demuzere, M., Middel, A., Bech-
https://doi.org/10.1016/j.buildenv.2023.110856,2023. tel, B., and Milelli, M.: GLIDE-SOL: A GPU-accelerated
Zanaga, D., Van De Kerchove, R., Daems, D., De Keersmaecker, Global Lightweight Infrastructure for Diagnostic Environmen-
W.,Brockmann,C.,Kirches,G.,Wevers,J.,Cartus,O.,Santoro, tal Modeling with SOLWEIG, version v1, Zenodo [code],
M.,Fritz,S.,Lesiv,M.,Herold,M.,Tsendbazar,N.-E.,Xu,P., https://doi.org/10.5281/zenodo.18671813,2026.
Ramoino,F.,andArino,O.:ESAWorldCover10m2021v200,
versionv200,Zenodo,https://doi.org/10.5281/zenodo.7254221,
2022.
Zhu, X. X., Chen, S., Zhang, F., Shi, Y., and Wang, Y.: Global-
BuildingAtlas: an open global and complete dataset of build-
ing polygons, heights and LoD1 3D models, Earth Syst.
Sci.Data,17,6647–6668,https://doi.org/10.5194/essd-17-6647-
2025,2025.
https://doi.org/10.5194/gmd-19-7389-2026 Geosci.ModelDev.,19,7389–7413,2026
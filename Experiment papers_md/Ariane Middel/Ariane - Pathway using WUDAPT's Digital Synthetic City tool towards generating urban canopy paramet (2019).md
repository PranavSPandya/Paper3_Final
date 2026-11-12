| Pathway    | using WUDAPT’s |             | Digital    | Synthetic | City tool   | towards |
| ---------- | -------------- | ----------- | ---------- | --------- | ----------- | ------- |
| generating | urban          | canopy      | parameters | for       | multi-scale | urban   |
|            |                | atmospheric |            | modeling  |             |         |
Jason Ching, Daniel Aliaga, Gerald Mills, Valéry Masson, Linda See, Marina
Neophytou, Ariane Middel, Alexander Baklanov, Chao Ren, Edward Ng, et al.
| To cite | this version: |     |     |     |     |     |
| ------- | ------------- | --- | --- | --- | --- | --- |
JasonChing,DanielAliaga,GeraldMills,ValéryMasson,LindaSee,etal.. PathwayusingWUDAPT’sDigital
SyntheticCitytooltowardsgeneratingurbancanopyparametersformulti-scaleurbanatmosphericmodeling.
UrbanClimate,2019,28,pp.100459. ⟨10.1016/j.uclim.2019.100459⟩. ⟨hal-04921059⟩
|     |     | HAL Id: | hal-04921059 |     |     |     |
| --- | --- | ------- | ------------ | --- | --- | --- |
https://hal.science/hal-04921059v1
Submittedon20May2025
HAL is a multi-disciplinary open access archive L’archiveouvertepluridisciplinaireHAL,estdes-
for the deposit and dissemination of scientific re- tinée au dépôt et à la diffusion de documents scien-
searchdocuments,whethertheyarepublishedornot. tifiquesdeniveaurecherche,publiésounon,émanant
Thedocumentsmaycomefromteachingandresearch des établissements d’enseignement et de recherche
institutionsinFranceorabroad,orfrompublicorpri- français ou étrangers, des laboratoires publics ou
| vateresearchcenters. |     |     | privés. |     |     |     |
| -------------------- | --- | --- | ------- | --- | --- | --- |
DistributedunderaCreativeCommonsCCBY-NC-ND4.0-Attribution-Non-commercialuse-No
DerivativeWorks-InternationalLicense

Pathway using WUDAPT's Digital
Synthetic City tool towards generating
urban canopy parameters for multi-scale
urban atmospheric modeling
Article
Accepted Version
Creative Commons: Attribution-Noncommercial-No Derivative Works 4.0
Ching, J., Aliaga, D., Mills, G., Masson, V., See, L.,
Neophytou, M., Middel, A., Baklanov, A., Ren, C., Ng, E.,
Fung, J., Wong, M., Huang, Y., Martilli, A., Brousse, O.,
Stewart, I., Zhang, X., Shehata, A., Miao, S., Wang, X., Wang,
W., Yamagata, Y., Duarte, D., Li, Y., Feddema, J., Bechtel, B.,
Hidalgo, J., Roustan, Y., Kim, Y., Simon, H., Kropp, T., Bruse,
M., Lindberg, F., Grimmond, S. ORCID: https://orcid.org/0000-
0002-3166-9415, Demuzure, M., Chen, F., Li, C., Gonzales-
Cruz, J., Bornstein, B., He, Q., Tzu-Ping, P., Hanna, A., Erell,
E., Tapper, N., Mall, R.K. and Niyogi, D. (2019) Pathway using
WUDAPT's Digital Synthetic City tool towards generating
urban canopy parameters for multi-scale urban atmospheric
modeling. Urban Climate, 28. 100459. ISSN 2212-0955 doi:
https://doi.org/10.1016/j.uclim.2019.100459 Available at
https://centaur.reading.ac.uk/84385/
It is advisable to refer to the publisher’s version if you intend to cite from the
work. See Guidance on citing .
To link to this article DOI: http://dx.doi.org/10.1016/j.uclim.2019.100459

Publisher: Elsevier
All outputs in CentAUR are protected by Intellectual Property Rights law,
including copyright law. Copyright and IPR is retained by the creators or other
copyright holders. Terms and conditions for use of this material are defined in
the End User Agreement .
www.reading.ac.uk/centaur
CentAUR
Central Archive at the University of Reading
Reading’s research outputs online

Ching et al. 2019: Urban Climate https://doi.org/10.1016/j.uclim.2019.100459
Pathway using WUDAPT's Digital Synthetic City tool
towards generating urban canopy parameters for multi-scale urban atmospheric modeling
Jason Ching, Dan Aliaga, Gerald Mills, Valery Massond, Linda See, Marina Neophytou, Ariane Middel, Alexander Baklanov, Chao
Ren, Ed Ng, Jimmy Fung, Michael Wong, Yuan Huang, Alberto Martilli, Oscar Brousse, Iain Stewart, Xiaowei Zhang, Aly Shehata,
Shiguang Miao, Xuemei Wang, Weiwen Wang, Yoshiki Yamagata, Denise Duarte, Yuguo Liu, Johan Feddema, Benjamin Bechtel,
Julia Hidalgo, Yelva Roustan, YoungSeob Kim, Helge Simon, Tim Kropp, Michael Bruse, Fredrik Lindberg, Sue Grimmond, Matthias
Demuzure, Fei Chen, Chen Li, Jorge Gonzales-Cruz, Bob Bornstein, Qiaodong He, Tzu-Ping, Adel Hanna, Evyatar Erell, Nigel
Tapper, R.K. Mall, Dev Niyogi
Abstract
The WUDAPT (World Urban Database and Access Portal Tools project goal is to capture consistent information on urban form and function
for cities worldwide that can support urban weather, climate, hydrology and air quality modeling. These data are provided as urban canopy parameters
(UCPs) as used by weather, climate and air quality models to simulate the effects of urban surfaces on the overlying atmosphere. Information is stored
with different levels of detail (LOD). With higher LOD greater spatial precision is provided. At the lowest LOD, Local Climate Zones(LCZ) with
nominal UCP ranges is provided (order 100 m or more). To describe the spatial heterogeneity present in cities with great specificity at different urban
scales we introduce the Digital Synthetic City (DSC) tool to generate UCPs at any desired scale meeting the fit-for-purpose goal of WUDAPT. 3D
building and road elements of entire city landscapes are simulated based on readily available data. Comparisons with real-world urban data are very
encouraging. It is customized (C-DSC) to incorporate each city's unique building morphologies based on unique types, variations and spatial
distribution of building typologies, architecture features, construction materials and distribution of green and pervious surfaces. The C-DSC uses
crowdsourcing methods and sampling within city Testbeds from around the world. UCP data can be computed from synthetic images at selected grid
sizes and stored such that the coded string provides UCP values for individual grid cells.
1. Introduction
Cities are unique and important to climate science for a number of reasons. While geographically occupying only a small proportion of
the planet's available land area, they house most of humanity and are the focus of resource usage and waste-products. The
profound landscape change that accompanies urbanization radically alters local environments, creating urban heat islands and
exacerbating weather extremes such as urban flooding and heat waves (Revi et al., 2014, Li and Bou-Zeid, 2013, Siu and Hart,
2013, Niyogi et al. 2017 and Hunt et al. 2018). Sustaining cities requires the transfer of resources (water, materials, energy, etc.), some
of which are stored for a period of time but most of which are returned as wastes to the environment, resulting in poor air quality at
local/regional scales and modifying the chemical composition of their atmosphere at regional and global scales. Cities also tend to be
located in places that are exposed to natural hazards (such as coastal flooding); their risks will be accentuated in global climate
change scenarios. To summarize: cities affect (and are impacted by) climate at a hierarchy of scales; the nature of this relationship
depends on the city-specific urban form and function, and the outcome varies depending on the city's geographic and topographic
situation, their climate and weather regime. It follows then that addressing climate-driven mitigation and adaptation at urban scales
requires a scientific framework that includes models capable of responding to the unique characteristics of individual cities. Such
models are needed to support current and emerging climate and environment policy and action plans that have immense socio-
economic and political implications (Ng, 2010; Ren et al., 2011, Ren et al., 2018; Masson et al., 2014; Ng and Ren, 2018; Baklanov et
al., 2016; Ching et al., 2018; Creutzig et al., 2018; See et al., 2015b; Brown, 2000, Zhang et al. 2010b).
In the past few decades, urban climate science has made substantive progress towards meeting these needs. The infrastructure of this
science has been constructed through the judicious application of atmospheric physics appropriate to urban micro- and meso-scale,
carefully designed field experiments (Grimmond et al. 2010) to test and evaluate the application of boundary-layer theory to the
complex and heterogeneous urban environment (Fig. 1) and numerical descriptions of the urban landscape referred to hereafter
as urban canopy parameters or UCPs (Brown and Williams, 1998; Brown, 2000;Chen et al., 2010; Jackson et al., 2010; Feddema et al.,
2015; Ching et al., 2016). Available now are a suite of advanced modeling systems, many are publicly available and have common
characteristics: universal availability; upgrades and support; solid foundation in science process descriptions and applicability to a
range of urban simulations. A prominentexample is the Weather Research and Forecasting model WRF (Chen et al., 2010) and its
extensions that incorporate atmospheric chemistry such as CMAQ (https://www.cmascenter.org, WRF Chem
(https://www2.acom.ucar.edu/wrf-chem) (Dirce et al., 2018 and Dai et al., 2018) and urban landscapes. Another is the Urban Multi-
scale Environmental Predictor (UMEP), which is a climate service tool designed for researchers and service providers (e.g. architects,
climatologists, energy, health and urban planners Lindberg et al., 2017, Lindberg et al., 2018. The need for improved models that can
be integrated into decision-making action oriented activities at urban scales will continue to grow e.g., (Masson et al. 2014), and also
given the recent WMO mandate and urgency for integrated urban weather, climate, hydrology and related environment services
(Baklanov et al., 2015, Baklanov et al., 2018, WMO The 17th World Meteorological Congress, 2015).
Despite the advances in urban climate science, gaps remain. Notably much of our knowledge is based on a few places with model
simulations evaluated by even more limited observations. Generally, we know little worldwide on city form and functions or the
UCP model inputs (Table 1) needed for state-of-the-art science models. A major obstacle to the general application of the accumulated
knowledge that is available in modern models is the absence of UCP and observations; such data should be relevant, consistent and
coherent so that city landscapes can be compared. The WUDAPT project strives to improve coverage and quality datadescribing the
underlying urban surface, so as to improve modeling and understanding of urban processes (Mills et al., 2015, Mills et al., 2017a, Mills
et al., 2017b; See et al., 2015a; Ching, 2013,Ching et al., 2015, Ching et al., 2016, Ching et al., 2017a, Ching et al., 2017b;Ching et al.,
2018).
In this paper, we address the need for a common set of model parameters to adequately describe the urban canopy layer (Fig. 1) and
therefore support several important categories of science-based models and their corresponding ‘fitness for purpose’ applications.
Within the WUDAPT methodology to acquire and structure data we employ bold heuristic approaches and innovations within a
community-based framework. This paper concludes with examples of progress and future expectations and activities (Ren et al., 2013).
1

Ching et al. 2019: Urban Climate  https://doi.org/10.1016/j.uclim.2019.100459
Fig. 1. Schematic of Urban Boundary Layer (from Oke et al., 2017, ‘Urban Environments’ in W.G. Bailey, T.R. Oke and W. R. Rouse (eds) The
Surface Climates of Canada, McGill-Queens's University Press, Montreal, 303–327).
Table 1. Urban canopy parameters (UCP) commonly used across a wide
range of modern urban -atmosphere process models. Different metrics (*)
may be of interest for example: mean, standard deviation, maximum,
variance, distribution. Some UCP (+) are not fundamental and therefore
have more assumption within them.
| Land Cover                     | Typology                                           | UCPs                      |
| ------------------------------ | -------------------------------------------------- | ------------------------- |
| Impervious Fraction Buildings  |                                                    | Building height*          |
|  Buildings                     | Typology class, age                                | Building width*           |
|  Roads                         | Building Types, age                                | Street width *            |
|  Other                         | Number of Floors                                   | Mean Aspect Ratio         |
| Pervious Fraction              | HVAC                                               | SVF (bldg. only) *+       |
|  Lawn                          | Glazing Ratio                                      | SVF (w/trees) *+          |
|  Trees and Shrubs              | Anthropogenic heating Dominant street orientation  |                           |
|  Bare area                     | Roof Material                                      | Building Volume to Area*  |
|  Recreation                    | Wall material                                      | Frontal Area Density      |
|   Water                        | Reflectance/Albedo                                 | Plan area density         |
|                                | Thermal admittance                                 | Roughness length+         |

|     | Vegetative Class   | D  isplacement height+  |
| --- | ------------------ | ----------------------- |
|     | Trees (Tall >2 m)  |                         |
  Shrubs
|     |     |     |
| --- | --- | --- |
Irrigation
2.1. Urban climate and environmental models and their data needs
Current models for boundary layer flows over horizontally relative uniform surfaces use Monin-Obukhov Similarity Theory (MOST),
with roughness (z0) and stability (L) length scales to describe surface impacts on momentum, heat, and other surface
to atmosphere gas and aerosol exchanges. However, urban surfaces are often highly spatially heterogeneous with natural and
constructed features commingled with anthropogenic sources of heat, vapor, and chemicals. This heterogeneity produces immense
varieties and distributions of microclimates within the urban canopy layer (Fig. 1) and controls the temporal and spatial structure of the
overlying boundary layer and vertical exchanges of momentum (i.e., drag), sensible, latent, radiant heat(Grimmond and Oke
1999,Grimmond et al., 2010) and of chemical species of pollutants and GHGs (Mouzourides et al. 2018) (Fig. 2). To capture the
essence of these processes, the urban landscape is described using UCPs and relevant land cover and typological features for running
and applying urban models (Table 1). This was accomplished using the paradigm of Local Climate Zones and their
corresponding lookup tables for UCPs (Stewart and Oke, 2012) in Level 0, and the more general grid specific approach to be describe
herein in Level 1 and 2.
Fig. 2. Models embodying urban climate knowledge.

The UCP inform the modeling of climatic impacts of various
morphological elements of the urban landscape, classified by scale
from facets, blocks and neighborhoods (Fig. 3). Facets, at their most
detailed, are surfaces (fixed orientationand slope) comprised of the
same material (natural or manufactured). Building envelopes are
composed of individual facets. Buildings and trees are the primary 3-D
objects. Streets and blocks describe the layout of facets, buildings and
trees that make up the urban land cover. Neighborhoods are the typical
layouts that characterize different urban land uses, such as residential
or commercial. Each building, street, block and neighbourhood is linked with a range of functions(transport, heating/cooling, lighting,
manufacturing, etc.) that generates waste heat, energy, water and materials into the overlying atmosphere. Taken together these
attributes can be classified into urban form and function related UCP. They distill the aerodynamic characteristics of site, which get
these variables into numerical values representing roughness, impervious land cover, thermal admittance, albedo, etc. that are
employed in climate models (Grimmond and Oke, 1999; Oleson et al., 2008). In WUDAPT, we consider the set of parameters listed
in Table 1 that are practical to generate, and sufficient and adequate for a wide range and “fit-for most purposes” applications,
hopefully, refined treatments and other combinations and perturbations of this set of UCPs are possible.
Comprehensive discussions and explanations about such parameters and their implementation in models can be found in Brown and
Williams (1998), Brown (2000), Jarvi et al. (2011),Masson (2000), Martilli et al. (2002); Kusaka et al., 2001, Kusaka and Kimura,
2004, Dupont et al. (2004), Otte et al. (2004), Baklanov et al. (2009), Jackson et al. (2010), Lemonsu et al. (2012),Chen et al.
(2012),Chan et al. (2013), Garuma (2018), Oke et al. (2017), Pigeon et al. (2014),Schoetter et al. (2017),Yang et al. (2012) and Shi et
al. (2018). Already, we anticipate its utility as an infrastructure that can support the goals outlined in the recently issued WMO Guide
for Integrated Urban Services (WMO, 2018), a global program of integrated urban weather, water, environment and climate services
using various fit-for-purpose models by stakeholders for cities towards their sustainable development, considering general
requirements for observations, data, databases and data sharing for urban modeling and prediction capabilities for different urban
service applications. Such services should assist cities in facinghazards as varied as storm surges, flooding, heat waves, and air
pollution episodes, especially in changing climates, while making the best use of science and technology and considering the challenge
of delivering such services to end-users. Their aim is to build services that meet the special needs of cities through a combination of
dense observation networks, high-resolution forecasts, multi-hazard early warning systems, and climate services
for mitigation and adaptation strategiesthat will enable the creation of resilient and sustainable cities in different regionsaround
the world. WUDAPT's goal is to achieve worldwide coverage for any and all major cities of these UCPs to support their atmospheric
modeling needs at varying scales in timely fashion, globally. A variety of model applications are presented in Section 3.4 utilizing
W1&2 data, in Appendix A and Table 4.
2

Ching et al. 2019: Urban Climate https://doi.org/10.1016/j.uclim.2019.100459
Fig. 3. Form-based Urban Canopy Parameters (from Oke
et al., 2017).
2.2. WUDAPT data
Table 2 depicts WUDAPT's hierarchical approach to
generating UCPs. Level 0 (L0) data are based
on satellite imagery, which are categorized into Local
Climate Zone (LCZ) types, based upon combinations of
building height, packing of roughness elements (building
and trees), perviousness of surrounding morphology
elements and materials. Each LCZ class has associated
lookup tables of UCPs (Stewart and Oke, 2012).
The methodology for generating LCZ maps has been
developed, tested by Bechtel and Daneke, 2012, Bechtel et
al., 2015, Bechtel et al., 2017a, Bechtel et al., 2017b)
and Zheng et al. (2018), and a summary of the approach is
described in Mills et al. (2015) and Ching et al. (2018). There are 17 basic LCZ types that include 10 urban and 7 natural types - each
type is associated with a tabulated range of appropriate UCP values. The WUDAPT process relies on urban experts to provide the
training areas needed to create L0 data, which consists of a grid map of the city and its surrounds in which each cell is classified into
an LCZ type. These maps can be converted into matrices of UCP values that can be used in models (Ching et al., 2018). However, this
approach has its limits, for example, the LCZ scheme provides associated ranges of UCP values for each LCZ type. Subsequently,
the user can assign either LCZ default values to each LCZ type or some other prescriptive means for the modeling domain. The
objective of the higher levels in the WUDAPT scheme is designed to provide explicit multiscale gridded values for each and all UCPs
based on a consistent and standardized framework. Level 1 (L1) data may be acquired by spatial sampling, using L0 (LCZ) data as a
frame to ensure that the urban landscapes within the modeling domain are sampled appropriately. Level 2 (L2) data can be described
as complete coverage based on information gathered across the entire domain. Fundamental to both is information on the
basic elements (buildings, trees, roads, etc.) of urbanized landscapes. For mesoscale urban models, the goal is the generation of specific
UCP values to support the full suite of ‘fit for purpose’ block-to-meso scale weather and climate models. As a template, historically,
the National Urban Database Access Tools (NUDAPT) project provides L2 information for parts of a number of North American cities
where detailed municipal data are available on individual building footprints, heights and materials; see, for example, Ching et al.
(2009). However, this type and level of information is not generally available and is still currently relatively expensive and difficult to
generate with currently available methods.
In contrast to NUDAPT, WUDAPT is developing an innovative approach to generate L1/L2 data that are consistent and universally
applicable, practical, pragmatic and timely to implement, relies on freely and readily available data and satisfies the modeling
requirements discussed earlier. These include a suite of tools to generate different UCPs and Testbeds, sets of cities where
independently derived data can be used to evaluate and improve these tools. Specific elements and issues of this approach towards the
goal of producing, testing establishing and making available a community based data generating methodology and protocol is outlined
and described in the next section. This is followed by some preliminary results and a discussion of next steps.
Table 2. WUDAPT Levels 0, 1 & 2 features and their potential applications.
Product Level 0 Level 1 Level 2
Coverage Over 120 cities and regions Data gathering methods; and testing to refine Level 0 based on Any city by using our new 3-D
crowdsourcing APPS and Buidling Typology approaches as in MApUCE mapping technology, DSC
Data source Landsat + Google Earth + local data & Landsat + Google Earth + local data & expert evaluation World-view Stereo Data + Terra-
expert evaluation SAR data
Resolution 100–500 m 100–500 m 2 m
Format kml, tiff GIS shapefiles GIS shapefiles
Applications Environment and Energy (Weather Environment and Energy (weather and climate, urban air flows, urban Environment and Energy (building
Research and Forecasting (WRF) Modeling, radiation, mean radiant temperature, urban energy consumption, air energy cost)
Urban heat island) pollution, CO2 and GHG emission) Building and community design
Urban and Regional planning (population Ecology (biodiversity) (visibility analysis, building
density) Urban and Regional planning (master plan, land use plan, green master development)
plan, new town plan) Disaster and risk management
(Flooding, heatwave)
Pedestrian and citizen's mobility
(walkability, thermal comfort)
Public health (polluted areas)
3. Conceptual framework for deriving level 1&2 data
3.1. Overview
Where detailed municipal data on buildings, roads, vegetation, etc. exist (e.g. NUDAPT information), UCPs can be calculated at a
selected level of precision. However, our objective is to generate equivalent urban scale UCP data ab initio, that is generated on a
consistent basis anywhere in the world, with readily available data that can be generated by the urban community in a practical and
useful timeframe for actionable science-policy utility, and whose output is of known quality, unrestricted, and publicly available. The
approach taken in WUDAPT Level 1 and 2 is designed to meet these challenges. The conceptual framework for deriving WUDAPT
Level 1&2 data is shown in Fig. 4. At its core is the Digital Synthetic City(DSC) tool, which simulates the spatial heterogeneity that
characterizes urban landscapes at an urban block scale. The generic DSC has the capacity and will be “customized” to include the
types of buildings (and materials) associated with cultural and historical practices that distinguish places. It is proposed that these
building-scale parameters could be acquired using a combination of architectural typologies linked to crowdsourced methods that
would sample neighborhoods. The goal is the creation of UCP data that reflect the unique form and function of individual cities and
permits scalar variation to meet the needs of different models. As these form-based features of the imagery are digitized,
3

Ching et al. 2019: Urban Climate https://doi.org/10.1016/j.uclim.2019.100459
all morphological formbased UCPs can be computer generated and to any grid size (Fig. 5). Details are provided in the following
sections.
Fig. 4. Schematic: An overview of Level 1 and 2.
Fig. 5. Computing scale dependent Urban Canopy Parameters (UCP)s given
digitized urban morphology from high-resolution satellite imagery. UCPs can
be computed for each and every grid. Grid size is user choice.
Fig. 6. Digital Synthetic City pipeline showing
visual summary of the DSC workflow.
Fig. 7. Intermediate products of DSC processing
3.2. The digital synthetic city (DSC) tool
Among other synthetic techniques (Aliaga et al., 2013), the DSC is a heuristic-based computer-assisted means of generating,
from high-resolution satellite imagery, digital synthetic buildings that capture the essence of building dimensions and layout for cities
with sufficient accuracy for many climate modeling applications. There are many techniques for creating 3D urban models of which
procedural modeling (e.g., Vanegas et al., 2009a, Garcia-Dorado et al., 2017) and urban reconstruction (e.g., Musialski et al., 2013) are
commonly used. Procedural modeling defines a set of rules and parameters to generate content and it has been successfully applied
to urban spaces (e.g. Parish and Müller, 2001; Vanegas et al., 2009b; Vanegas et al., 2012a). The DSC automatically produces a 3D
city model. At its core is an inverse procedural modeling algorithm (e.g., Vanegas et al., 2012b) that is fully automatic and produces a
3D approximation of an urban area from satelliteimagery and global scale data that include a road network, population, and
coarse elevation data (Fig. 6, Fig. 7). The DSC tool ‘builds’ the city by analyzing the data on parcels, buildings and their setbacks,
population, and terrain elevation.
Briefly, the DSC's main steps are demonstrated in Fig. 6: procedural model generation component, parcel area estimation component,
and procedural model optimization component. While a detailed formulation of the DSC framework, algorithm, and initial prototype
are described in Aliaga et al. (2018, under review), we provide a summary.
The procedural model generation component takes as input a geo-registered segmented and labeled satellite image and the
corresponding geo-registered OSM road network. For the DSC, we assume the labels of building, ground cover, and roads in the
satellite images. Individual city blocks are extracted from the satellite imagery and an initial geography of building parcels is created
using the freely available geo registered global elevation JAXA dataset (30-m mesh, accuracy about 5 m) and ORNL's LANDSCAN
Global Population Data (latest version is for 2016). The building generator computes for each parcel inside a synthetic city block,
the building type, building height, and setback values, and subsequently the initial 3D building geometry. An appropriate
building geometry is assigned based on the building's height and the setbacks associated with the building's type. To create a
building geometry model, the generator uses both global-scale population and global-scale elevation data to compute the building type
within each parcel. It also uses per-building-type triple typical setback ranges (front, rear, and side setback ranges) (Figure3b). Then,
the elevation data, building type, and setback ranges are used to create an appropriately sized procedural building model. The
estimated building height is scaled to the range [0, Hmax] where Hmax is, by default, the maximum building height of a typical city,
or is a single number provided as input for a target urban area. Our method uses six procedural building types based on the LCZ
classification. We use population data to estimate the density of a parcel. Thus, our six types are all combinations of low/mid/high rise
4

Ching et al. 2019: Urban Climate https://doi.org/10.1016/j.uclim.2019.100459
with a dense/sparse component, i.e.: 1) Low Rise Sparse, 2) Low Rise Dense, 3) Mid Rise Sparse, 4) Mid Rise Dense, 5) High Rise
Sparse, and 6) High Rise Dense. Further, we define a typical front, rear, and side setback range for each building type. To determine
the building type ti,j for a parcel, we split the building height range into three percentiles corresponding to: Low Rise, Mid Rise,
and High Rise Buildings. Using the population data of a parcel, we further split each percentile into two percentiles to define sparse vs.
dense areas. The result is the classification scheme for the listed six building types. Finally, we compute an appropriate building
geometry model based on the building's height and the setbacks associated with the building's type.
• The parcel estimation component, used during model generation, makes use of an analysis of the typical parcel sizes and building
sizes in a city in order to traina neural network for robustly producing a set of parcel area networks. The neural network ingests the
noisy and error-prone segmentation of a satellite image of a city block and produces crisp and reasonable parcel areas as output. Thus,
our approach does not rely on a perfect satellite image segmentation but instead is able to cope with
typical occlusions and misclassifications errors which in turn make the tool very robust in practice.
• The procedural optimization component iteratively executes the generation process to increase the similarity between the
synthetically created building outlines and a small calibration dataset comprised of actual building footprint areas. By making use of
the calibration dataset (e.g., a few percent of ground truth building footprint areas), the system parameters are tuned to produce a
significant improvement in the overall accuracy in the end.
Altogether, the DSC tool can automatically generate a complete fully optimized 3D model of a city (with parcels, buildings, and roads)
using just a satellite image and OSM in 5 min to two hours depending on the size of the urban area. The final procedural model output
can be visually compared to Google Earth. For our multiple test cities, Fig. 8 compares various views of our 3D urban model to
corresponding views obtained from Google Earth. Here we can see that from a distance, there is similitude. This similitude will
diminish when individual buildings are considered.
Fig. 8. Example DSC outputs. Left column: Views of cities using
Google Earth. Right column: Similar views using automatically
generated procedural model from DSC. Top row, Chicago, Bottom
row, San Francisco.
Although the DSC has limitations (e.g. limited building types,
block subdivisions, and accuracy), it is a very practical and
expedient approach to create a digital urban landscape with
similar physical properties to the actual city. In other words, the
DSC captures the spatial heterogeneity of building geometry in
cities and allows unique UCPs to be generated at appropriate
model grid sizes. Moreover, it has the capacity to integrate
other information (e.g. building materials and architectural
features) to greatly enhance the product. For example, the DSC
tool has two provisions: (1) the Building Type Refinement
(BTR) to handle inputs of building properties such
as albedo, heat capacities, and
thermal admittances as probability distribution functions or
other formats and (2) Partial Building Knowledge (PBK) to
accommodate architectural variations based on additional data
including materials. The BTR and PBK are being developed as
either tools of the portal-based DSC or as part of downloadable software (Fig. 9. These tools of the DSC make it feasible and possible
to customize (Section 3.3) to specific cities with data based on crowdsourcing Apps (CSAPPS) which will be implemented using the
city-specific Testbeds described in Section 3.4.
Fig. 9. Schematic: Tools to customize the DSC.
3.3. Enhancing DSC to generate building-scale parameters and properties
The acquisition of model relevant information on buildings (e.g., type and pattern of
use, dimensions, roof shape, and material properties of the envelope) poses a major
challenge for WUDAPT. Although many of the UCP parameters associated with
building heights and layout can be obtained from the DSC, building information would
provide UCP data on thermal and radiative properties (Table 1) and on
anthropogenic heat flux. These data can be used to support modeling that links decision-
making at the building scale to atmospheric outcomes.
Currently, the only global building database designed for climate modeling was developed by Jackson et al. (2010) using a ‘top-down’
approach. Thirty-three global regions with relatively homogeneous climate and housing characteristics were created and for each,
thermal and radiative properties were assigned to four urban landscape types comprised of low, medium and high building
densities and high-rise. This database distinguishes among urban classes but it has limited information on building use (e.g. residential,
industrial and commercial), which regulates the timing and intensity of emissions. The WUDAPT approach is based on a pseudo
‘bottom-up’ approach, which relies on building archetypes (Fig. 10) that characterize the building stock in each city. The model for
this approach is based on two related projects. TABULA developed national residential building typologies for 25 EU counties that
consisted of: a classification according to age, size, etc.; a set of example buildings with typical energy consumption values and;
associated information on building insulation and energy supply systems. The MAPUCE project used the French architectural database
to extract generic building types based on dimensions, age, use and geographic area (Tornay et al., 2017). These types were then used
5

Ching et al. 2019: Urban Climate https://doi.org/10.1016/j.uclim.2019.100459
to create urban surface cover and derive UCP values on roof and wall properties that included roof pitch and the material properties
of facets and HVAC use. These data have been used in the Town Energy Budget (TEB) model that simulates building energy use
in response to climate drivers and building properties.
Fig. 10. Customizing the DSC based on building typology to generate information on Building
material and properties.
The WUDAPT approach is still being designed but it will have three elements:
1. A building archetype database to capture the variation within and between cities at
different scales (Fig. 11). The database will contain information on characteristic
building use, date of construction, material, surface cover; glazed wall fraction,
etc (Masson et al., 2017a, Masson et al., 2017b).
Fig. 11. (a) illustrating within country (France) variability of
building's architecturefor low buildings and houses built before
1948. Each color on the map corresponds to a typical building's
architectures and wall/roof materials. (source: MAPUCE project
(Masson et al., 2015)). (b) Illustration of worldwide variability of
building's architecture for mid-rise buildings (6 pictures on the
left) and low-rise buildings and houses (6 pictures on the right).
2. A sampling methodology for gathering these data for a
selected city. One approach would be to use the Level 0
(LCZ) map as a sampling frame however,
different strategies may be appropriate for individual
cities.
3. A process for linking building level data to the DSC.
This would be based on a probabilistic assessment of the
likely archetype associated with the simulated urban
landscape based on matching similar shapes and heights,
population data and LCZ type.
Creating the WUDAPT building archetype database relies
on the expertise of architects from about two dozen countries, coordinated by the School of Architecture and Urbanism at
the University of Sao Paolo, along with efforts being devised by each of the Testbeds. In developing the archetype database,
WUDAPT will gather a library of geocoded images of the international building stock and rely on local experts to extract relevant
properties. Each photo will be annotated with radiative and thermal properties using ‘look-up’ tables.
Acquiring the actual building data in each city will rely on a variety of methods including crowd-source applications that would be
available on mobile phoneplatforms and permit classification into an archetype. Much of this infrastructure is still in development and
will rely on the expertise of architects and the contribution of Testbed cities. The enhanced DSC would allow WUDAPT to generate
UCP data on thermal/radiative properties and would provide the opportunity to link building energy demand (and indoor human
comfort) to climate models. We envision that the Testbeds will be critical in testing and evaluating the efficacy of the approach
outlined and improve it for wider application.
3.4. Design implementation approach utilizing city specific testbeds
The WMO Guide for Integrated Urban Services (WMO, 2018) recommends the concept of Testbeds for development, testing and
evaluation of Urban Integrated Hydro-Meteorological, Climate and Environmental Services. A Testbed is a city that includes all
essential information needed for providing Urban Integrated Services, as well as information on the measures taken as a result of the
Services, on the behavior of people, on the target parameters, etc. (WMO, 2018). The purpose of a Testbed is to develop the models,
perform diagnostic and statistical evaluation but most importantly, to co-design, co-develop and build relationships with partners.
Testbeds with data from all fields relevant for the target parameters and variables (e.g., flooded area, soil water content, human
behavior) are needed for model development, for diagnostic evaluation and quantitative user evaluation. These will need independent
data sets for initialization, assimilation and evaluation to allow for robust testing and development.
WUDAPT will initially adopt a city-specific Testbeds prototype for “proof of concept” testing as the strategic approach, employing
a heuristic, community-based means towards customization of the DSC, ensuring that each city and regions in the world will have their
unique morphological structures, building construction materials and cultural features captured in the generation of UCPs (Fig. 10).
For this, urban experts will discern their cities' unique features and provide samples of such features using crowdsourcing APPS and
sampling approaches described above to collect and incorporate such data into the DSC. These Testbeds will typically already have a
rich set of data as a basis and urban climate expertise. Each participating city would follow the essential steps listed below:
1. Create a DSC using the requisite high-resolution input satellite data, population and terrain elevation data. Evaluate the DSC
by comparison with available baseline data such as 3D building models and against a unique set of Sky View Factor (SVF) data
(Middel et al., 2018) described in the Appendix.
6

Ching et al. 2019: Urban Climate https://doi.org/10.1016/j.uclim.2019.100459
2. Access very high resolution Google type visual imagery, photographs from Google Street View and Mapillary, and where possible
data from OpenStreetMap (OSM).
3. Develop the CSAPP sampling strategy and deploy the CSAPPs to gather details on the buildings via the approach based on the
Building Typology strategy.
4. Incorporate the CSAPP data into the DSC model to enrich the annotated Building Typology photo catalog.
5. Generate the UCPs from the C-DSC outputs.
6. Perform, assess and evaluate a wide variety of model applications (see table of model types) using the computed C-DSC-based
UCP data to ensure usefulness and adequacy of the WUDAPT Level 1&2 data.
7. Prepare and codify the resulting UCP database and upload to the WUDAPT Portal.
8. Design and implement a QA plan.
The shared experience from these Testbeds from this stage will provide the bases for the protocols of the final recommended approach.
As this is a portal-based approach, the results will become part of WUDAPT's global urban database and contribute to the
dissemination of urban climate knowledge.
4. Results and discussion
At least a dozen Testbed cities (Table 4 in the Appendix) are currently engaged and others are being considered. Initial, albeit limited,
results are described below to illustrate the current state of the methodology development.
4.1. Preliminary results of the DSC
Initial results from the use of the DSC tool to generate 3D models of several test cities shown earlier in Fig. 8) visually contrasts the
simulated and actual urban landscapes for comparison. From a distance, there is remarkable similitude, but a careful, close-in look will
reveal differences, primarily with respect to details of individual building elements as anticipated. Fig. 12 compares DSC output with
measured building height and footprint area for several cities around the world. Overall, the mean absolute error (MAE) is just 5.8%.
We can anticipate this error to be reduced further as the planned additional data to customize the DSC is implemented. The optimized
column is the result of using a sample (5–10%) of building footprint areas measured across the study area – these data are available for
many cities or can be easily generated. Using the DSC, the SVF can be obtained in a straightforward manner by sampling
sky visibility along the centerline of the roadvectors. Fig. 13 compares the SVF values for Hong Kong, Toulouse, and Dublin
computed using the automatic output of DSC to the method of Middel et al. (2018), which is based on an analysis of
Google Street View images. While our results are not identical, they are similar enough to be used as a starting point for SVF usage.
Fig. 12. Output Accuracy. We show the average of building footprint area error
and building height error for several test cities using automatically produced
DSC procedural output. The right column (orange) for each city is the output
after the use of our procedural model optimization component.
Fig. 13. Sky View Factors. Left: SVF computed using Middel et al., 2018 and
Google Earth Street View images. Right: SVF computed using automatically
generated procedural model from DSC. Some discrepancies are because
DSC computes SVF for a denser set of roads and DSC does not compute SVF
correctly over water bodies.
As an example of UCP computation, we computed the area-weighted building height (Ah) and building surface plan area ratio (λb)
for Hong Kong. The approximate 11 × 11 km test area of Hong Kong is divided into a grid of 110 × 115 cells, with each cell spanning
100 × 100 m. Within each cell an aggregated area weighted building height (Ah) is computed based on DSC values. Fig. 14 shows the
result of using a Kolmogorov-Smirnov test (ks-test) to measure the similarity of the distribution of DSC-based Ah's values to ground
truth. In particular, the horizontal axis represents into how many bins is the UCP value range divided. The vertical axis is the result of
the ks-test and it measures the similarity of the distribution of DSC-based values to the distribution of ground truth values from the
same bins. We highlight two typical significance value thresholds (i.e., α = 0.05 and α = 0.01). For example, the graph shows that for
area-weighted building height DSC-based values yield a distribution of values similar to ground truth at a significance value of
α = 0.05 when using approximately 60 bins. The bin size in this case is 6.8 m which can be interpreted as an Ah accuracy of +/− 0.83%
(i.e., 100/60 × 0.5). Similarly, for building surface plan area ratio, the ratios using DSC outputs vs ground truth are similar at a
significance value of α = 0.05 when using approximately 75 bins (i.e. a granularity of 0.18 or ±0.67%). Hence, for reasonable cell and
bin sizes, the automatically produced DSC output can be used to compute fairly accurate UCP values.
7

Ching et al. 2019: Urban Climate https://doi.org/10.1016/j.uclim.2019.100459
Fig. 14. Example UCP for Hong Kong. To quantify how accurate our DSC
produced output can obtain typical UCP values, we analyze building surface-to-
plan area ratioand area weighted buiding height. For both UCP types, the
distribution of values is not statistically different than ground truth at either 0.05 or
0.01 significance values. (see text for more details).
The DSC will be customized by adding local information. Fig. 15a shows raw output from generic DSC for the Kowloon Peninsula of
Hong Kong. It can be seen that the building footprints are generally very well recognized, even if the exact shape of buildings may not
match. For the whole domain, the error of building area detected is as low as 5%. Moreover, despite the relatively highly
dense property, there is some vegetation cover existing in the urban area in Hong Kong (mainly parks or trees), which
requires customization from local vegetation data to achieve verisimilitude. Another approach is to incorporate NDVI (Normalized
Difference Vegetation Index) data to ensure that green areas are included in the DSC. Results of the customization of the DSC
applying local vegetation data derived from Google satellite images are shown in Fig. 15b. Fig. 15c & 15d show scatter plots of results
of raw DSC and customized DSC, which are gridded values at a 100 m resolution for two example UCPs (plan area ratio, λp, and area
weighted building height, Ah) based on actual building data, respectively. The correlation coefficient is as high as 0.68 for λp and 0.54
for Ah, which indicates promising results from the C-DSC approach despite the heterogeneity of the Hong Kong landscape.
Fig. 15. Top: Customizing the DSC; using DSC tool to replace
building in areas that are tree covered. a) Raw DSC product
(yellow = building, red = vegetation), b) Customized DSC
by vegetation data, Bottom: Scatter plot of (c) λ and (d) A derived
p h
from NUDAPT-type actual building data and DSC. (For interpretation
of the references to color in this figure legend, the reader is referred to
the web version of this article.)
4.2. Current and ongoing testbed activities
4.2.1. Current Testbed activities
1. Methods developments: The implementation and development of the customized DSC prototype tool capable of ingesting city-
specific building material and the annotated building thermal and radiative properties of building matter from the geotagged photo-
catalogues of building typology generated from the CSAPPS has been initiated and led by the Dublin Testbed (cf Section 2.3). Other
Testbeds will then apply this C-DSC tool in their respective cities. Initial accuracy checks of the DSC based on the availability of
actual building data for the entire city have been conducted for Hong Kong, Dublin, and Toulouse.
2. Initial model testing and applications using WRF; e.g., WRF modeling using bootstrapping approaches have begun. For Hong Kong
and other cites of the Pearl River Delta (PRD), (Wong et al., 2018), studies of the historical evolution of urbanization in the
PRD Region including Hong Kong using WUDAPT (Cai et al., 2018; Wang, 2018) and WRF modeling (Zhang et al. 2010a, Ren et al.
2017, Tse et al. 2018), linking WUDAPT to ENVI-met, development of urban climate maps(Xu et al., 2017) and development
and deployment of real-time street-level air-quality models. At the outset, Testbeds for Chengdu, Guangzhou, Hong Kong, Beijing,
Sao Paolo, Toulouse, and Hamburg will be engaged similarly, beginning with accuracy checks using actual data, each examining the
efficacy of various crowdsourcing approaches to generating the inputs for customizing the DSCs and examining and
assessing tradeoff issues between the C-DSC accuracy as a function of grid size (see next section). They will be engaged in a variety of
model testing activities, evaluating the use of C-DSC UCP outcomes. A wide variety of modeling studies under consideration will be
useful for determining the efficacy of C-DSC generated UCPs. Model testing and applications including using WRF, CMAQ, ENVI-
met and LES techniques focusing on the use of advanced LCZ-based UCPs (WUDAPT Level 1) are planned (See Appendix and Fig.
18). There is the potential for exploring using the C-DSC as a platform for fine grid model applications for street level air quality
exposure modeling (Shi et al., 2018) and Street-in-Grid air quality modeling; e.g., Kim et al. (2018), and one such study has already
begun for Guangzhou (Wu and Wang, 2018). We seek to engage these Testbeds and to invite others around the world to ensure broad
world experience and consistency in the C-DSC, and to begin initial linkages to the Urban Multi-scale Environmental Predictor
(UMEP) system (Lindberg et al., 2017, Lindberg et al., 2018). A strategic effort to map, generate and analyze GHG emissions is the
focus of the Tokyo Testbed. We anticipate efforts to extending this Testbed's current capability with the WUDAPT LCZ approach to
perform enhanced temporal and spatial carbon mapping and characterizations in WUDAPT using the WUDAPT DSC framework and
CSAPP sampling (Table A.2).
4.3. Storing and transmitting UCPs
8

Ching et al. 2019: Urban Climate https://doi.org/10.1016/j.uclim.2019.100459
Following the approach of NUDAPT, WUDAPT L1/L2 processes will generate unique UCPs for each model grid cell (Table 1). The
implication is that each grid can have a distinct effect on model simulations of airflow, radiation exchanges,
the turbulence energy budget, pollutant deposition velocity, etc. It is possible and useful to describe the WUDAPT output for a city
using a unique combination of key UCPs; this data string is akin to an urban DNA code (Fig. 16) and coded either in bar or QR code
(for maximum resolution) as shown in the figure. WUDAPT intends to produce a protocol for coding UCP data to provide model
applications with fit-for-purpose data appropriate to the project. The DSC is capable of generating form based UCPs according to
any user specified grid raster size. The utility of formatting (codifying) the data may provide a means for examining and studying the
UCP set as DNA for such considerations as to the UCP-related factors that make a city more sustainable or resilient, providing
urban planners with a tool for optimizing sustainability and resiliency. For a simplified code, we can start with each UCP such as was
utilized to generate the LCZs. Each value in the code sequence of UCPs could represent a preselected range of values shown in Fig.
16 as suggested by Stewart and Oke (2012). Alternatively, we could further discretize to decile values such as binning from 1 to 10
with bins of different decile ranges assigned an ordinate value 0–9 as shown in Fig. 16.
Fig. 16. Schematic showing DNA-like coding for UCP from
WUDAPT 1&2.
At this point, it is also important to bear in mind that for numerical modeling of urban thermal fluid dynamics for a range
of weather and climate applications, UCPs should be appropriately defined and derived for the corresponding scale (and therefore
nature) of the application considered. This is illustrated schematically in the bottom row of Fig. 16. The Level 0 map is extracted in
rasterized form into a gridded format. The 17 classes used in the LCZ mapping (as per Stewart and Oke, 2012) are decoded and
summarized into 6 two-dimensional (2-D) pixelated data sets of the fundamental, independent UCPs. These are considered the
fundamental parameters, in the sense that all the 17 classes in the standard LCZ mapping can be reproduced as a combination of these
6 fundamental parameters (Mouzourides et al., 2018). The decoding into fundamental UCPs at the Level 0 (after the
initial extraction in gridded format) is required in order to enable the deduction of the corresponding quantitative values of the
fundamental UCPs (and thereby more composite UCPs) later on at the appropriate scale or cell size required for the application, based
on rigorous methodologies (Mouzourides et al., 2013, Mouzourides et al., 2014, Mouzourides et al., 2017).
There are underlying issues to be worked out to implement these innovations towards accommodating the wide range of urban-centric
type applications. In practice, the “coded DNA” set we propose here is inherently scale dependent. First, it is well recognized that there
is no “universal, one-size fits all grid size”. Second, especially for microscale modeling, the accuracy of UCPs from the C-DSC system
will diminish with decreasing grid size. The level of acceptable accuracy by grid size is an outcome to be investigated in this “Work in
Progress” stage and established, knowing that one can aggregate the coding to larger grid sizes. Additionally, studies will be
undertaken to characterize UCPs in more fundamental contexts (a) consistent with the Stewart and Oke (2012) LCZ paradigm and (b)
similar to “the chromosome category” in the DNA analogy characterized by representative subsets of other UCPs or urban indicators
consistent with Fig. 16. This can set the stage for the development of a scale dependent coding protocol by the WUDAPT community.
Finally, information in Table 1 on building typologies will require building scale information to be generated by means outlined
in Section 3.3. Here tools such as LZW compression might serve as an efficient means to convey this type information. This can then
be decompressed for model or analyses applications.
4.4. Summary and path-forward activities
We propose a strategic and practical means to generate urban canopy data at WUDAPT Level 1 and 2 using a portal-based customized
C-DSC tool. The data for the customization will be facilitated by applying the MaPUCE and crowdsourcing paradigms implemented
by ad hoc activities of urban experts in their respective urban Testbeds currently being established and now underway. The
recommendations based on the synthesizing of the experience and best practicefrom these Testbeds will constitute the final
methodology protocol. The coverage of Testbeds will be worldwide to adequately represent regional variations. They each have
specific guidance but yet sufficient flexibility to encourage diverse utility of the database. In addition, given that the useable lifetime of
morphological structures spans at least 2 generations, it is of strategic benefit that WUDAPT is available for design and urban
planning and other uses by the urban community, setting a two to three year horizon, and a rollout of the prototype at the next triennial
IAUC conference, which seems to be a reasonable timeframe. Also noteworthy, WUDAPT Level 1 and 2 data can be created at regular
intervals going backward in time, permitting the development of a consistent time series and analysis of urbanizationof any cities or
regions on earth. Based on the extracted and developed historical urban morphological information, future land use patterns can be
predicted as a reference for local planners and government officials especially for those in developing countries and regions under fast
urbanization but which lack urban data. This developed data can also allow climatologists to run complex climate models to gauge the
impact of urbanization on climate at local, city, and regional scales. The modeled results, when properly formatted and presented, may
allow policy makers and industry stakeholders to draw up climate maps for their cities so as to guide better city planning decision
9

Ching et al. 2019: Urban Climate  https://doi.org/10.1016/j.uclim.2019.100459
making at various design scales (Ng and Ren, 2015; Ren et al., 2017). The WUDAPT Portal will provide the platform for hosting the
UCP outputs, as multiscale codified gridded sets. Moreover, the Portal, as infrastructure, will host tools derived during Testbed
modeling activities to promote the utility of the database.
Already, informal interests have been expressed by organizations including Passive Low Energy Architecture (PLEA),
the International Association for Urban Climate, (IAUC), and the World Meteorological Organization (WMO), to engage in the
development and implementation. Given the overriding principle of WUDAPT to be community-based, the development and
implementation activities are open and unrestricted to the world community, self-regulating, and on a volunteer base.
Thus, participation in any and all activities leading to full implementation and eventual utilization is encouraged and facilitated by
all interested parties and communities around the world.
Acknowledgements: Partial Support for Linda See comes from the FP7 ERC CrowdLand project (617754), NSFCBET 1250232, and NSFCHS
1816514. Co-authors V. Masson and J. Hidalgo thank the collaborators of the project applied Modeling and urbAn Planning laws: Urban Climate and
Energy (MApUCE), especially E. Bocher, G. Petit and N. Tornay, and the support from the French National Agency of Research (reference ANR-13-
VBDU-0004). Support for Denise Duarte and Luciana Schwandner Ferreira comefrom Grants #2016/02825-5, #2015/17360-5, São Paulo Research
Foundation(FAPESP) and Grant #309669/2015-4, National Council for Scientific and Technological Development (CNPq).
Appendix A. Appendix
A.1. Sky view factor database in WUDAPT portal
In addition to likely availability of baseline building data, these Testbeds will benefit from a unique SVF database (60 cities currently
processed through Jan 2019) shown in Table A.1 and now being made available on the WUDAPT portal based on the efforts
and methodology described in Middel et al., 2018. These SVF datasets are developed using image-based ‘big data’ methods which can
automatically calculate SVFs from Google Street View (GSV). GSV images in cities are acquired every 5–20 m on the
street network and can provide a detailed sample of the urban landscape. The method projects acquired image cubes into hemispheric
fisheye photos, the sky is detected using a modified Sobel filter and a flood-fill algorithm (Sobel and Feldman, 1968; Lindberg et al.,
2017, Lindberg et al., 2018), and the SVF is calculated using a modified Steyn method (Middel et al., 2017). The SVF can be linked to
both daytime radiation receipt at walls and street surfaces and nighttime radiation losses; for example, it is an important regulator of
the magnitude of the urban heat island. Although natural areas, parks, backyards, etc. are under-sampled, comparisons with WUDAPT
L0 data (Wang et al., 2018a, Wang et al., 2018b; Middel et al., 2018; Bechtel et al., 2017a, Bechtel et al., 2017b) show good agreement
with urban LCZ parameter ranges. Moreover, this method can be expanded to extract information on trees, impervious surfaces, etc.
within the urban canopy layer (Middel et al., 2019; Gong et al., 2018). SVF data generated by this method are available for a growing
number of cities around the world in WUDAPT (Table A.1); apart from their intrinsic value, (and planned use in C-DSC) these data
will also provide a valuable urban resource for testing other data products.
Table A.1. Processing status of SVF calculations for cities around the globe. (Courtesy Middel 2019)
Urban area  Country # of GSV Locations  SVF (mean)  Lyon  FR  179,821  0.682
| Atlanta, GA  | US  541,962  | 0.689  | Madrid  | ES  827,932  | 0.751  |
| ------------ | ------------ | ------ | ------- | ------------ | ------ |
Baltimore, MD  US  523,709  0.786  Manhattan, NY  US  143,183  0.545
Bangkok  TH  1,779,185  0.764  Miami, FL  US  1,005,440  0.835
| Barcelona  | ES  602,645  | 0.709  | Nantes  | FR  203,440  | 0.812  |
| ---------- | ------------ | ------ | ------- | ------------ | ------ |
Be'er Sheva  IL  57,608  0.898  New Orleans, LA  US  631,122  0.846
Belgrade  RS  346,661  0.807  Orlando, FL  US  872,359  0.809
| Bogotá  | CO  694,329  | 0.776  | Paris  | FR  304,823  | 0.586  |
| ------- | ------------ | ------ | ------ | ------------ | ------ |
Bonn  DE  93,188  0.746  Philadelphia, PA  US  936,231  0.723
Boston  US  466,158  0.705  Phoenix metro area, AZ  US  3,124,529  0.954
Brussels  BE  285,059  0.698  Richmond, VA  US  318,243  0.702
| Bucharest  | RO  321,145  | 0.777  | Rome  | IT  700,481  | 0.739  |
| ---------- | ------------ | ------ | ----- | ------------ | ------ |
Buffalo, NY  US  349,676  0.824  Salt Lake City, UT  US  689,701  0.907
Cleveland, OH  US  352,365  0.757  San Antonio, TX  US  1,117,303  0.904
Denver, CO  US  1,109,871  0.879  San Francisco, CA  US  233,281  0.797
| Dubai        | IE  609,301  | 0.921  | San Jose, CA  | US  771,094    | 0.840  |
| ------------ | ------------ | ------ | ------------- | -------------- | ------ |
| Dublin       | IE  427,071  | 0.835  | São Paolo     | BR  2,559,340  | 0.787  |
| El Paso, TX  | US  827,718  | 0.962  | Seoul         | KR  613,971    | 0.68   |
| Frankfurt    | DE  83,573   | 0.738  | Singapore     | SG  948,674    | 0.685  |
| Fresno, CA   | US  499,908  | 0.906  | Sofia         | BG  311,971    | 0.786  |
| Ghent        | BE  271,079  | 0.821  | Tampa, FL     | US  693,181    | 0.772  |
Gothenburg  SE  171,691  0.825  Tel Aviv  IL  156,353  0.763
| Hamburg    | DE  253,958  | 0.702  | Tokyo     | JP  3,736,082  | 0.693  |
| ---------- | ------------ | ------ | --------- | -------------- | ------ |
| Hong Kong  | HK  625,136  | 0.548  | Toulouse  | FR  368,855    | 0.836  |
Istanbul  TR  1,629,574  0.714  Tucson, AZ  US  565,825  0.956
Johannesburg  AF  472,900  0.804  Vancouver, BC  CA  693,193  0.781
Kampala  UG  145,989  0.873  Victoria, BC  CA  152,985  0.761
| Kiev  | RU  450,163  | 0.764  | Warsaw  | PL  601,920  | 0.755  |
| ----- | ------------ | ------ | ------- | ------------ | ------ |
Kuala Lumpur  MY  429,877  0.720  W  ashington, DC  U  S  516,448  0 .705
| Las Vegas, NV            | US  1,073,711  | 0.938  |     | 60,604,277  |     |
| ------------------------ | -------------- | ------ | --- | ----------- | --- |
| London                   | UK  2,396,172  | 0.774  |     |             |     |
| Los Angeles metro area,  | US  9,354,005  | 0.889  |     |             |     |
CA

10

Ching et al. 2019: Urban Climate  https://doi.org/10.1016/j.uclim.2019.100459
A.2. Current set of Testbeds
Table A.2. Current list of active Testbeds in different regions and continents and their likely modeling emphases. Tentative Testbeds (T) .
| Asia         | Africa, Mid East  | Europe       | Americas     | Other regions  |
| ------------ | ----------------- | ------------ | ------------ | -------------- |
| Bangalore M  | Dakar M           | Dublin M, U  | NYC M, L, U  | Moscow (T)     |
Beijing M  Kampala M  Hamburg M  Sao Paolo M,A, E  Melbourne (T)
| Chengdu E, M  | Cairo (T)  | Madrid M,  | Phoenix H  | Nanjing (T)  |
| ------------- | ---------- | ---------- | ---------- | ------------ |
Guangzhou M, S, A  Jeddah  Paris M, S,  San Francisco (T)  S eoul (T)
Hong Kong M, E, A  T el Aviv (T)  Toulouse M,  Victoria (T)
| Shanghai (T) M        |     | Vienna (T) U  | Toronto (T)       |     |
| --------------------- | --- | ------------- | ----------------- | --- |
| Taipei M, A           |     | L ondon (T)   | Minas Gerais (T)  |     |
| Tokyo G               |     |               | Medellin (T)      |     |
| Mumbai (T)            |     |               | Santiago (T)      |     |
|                       |     |               |                   |     |
| New Delhi (T)         |     |               | L ima (T)         |     |
|                       |     |               |                   |     |
| Bhubaneshwar/Roukela  |     |               |                   |     |
| Pune                  |     |               |                   |     |
| Trivandrum            |     |               |                   |     |
| Ahmedabad             |     |               |                   |     |
Banaras
Modeling and other applications keys for  (S) Link to Street in Grid.  (G) Greenhouse Gas.
| confirmed cities,  | (U) Link to UMEP.  |     | (H) Urban Health.  |     |
| ------------------ | ------------------ | --- | ------------------ | --- |
(M) Mesoscale, e.g., WRF or.  (A) Urban air quality.  (T) Tentative.
(E) Link to ENVIMet.  (L) Link to LES, CFD.

A.3. Brief Summary of Examples of current modeling systems to be utilized in W1&2 Testbeds modeling studies
A.3.1. Urbanized WRF
WUDAPT provides model parameter inputs to environmental models such as the WRF so as to be able to study and perform surface
energy budget, weather, climateand air quality model applications for urban areas and anywhere in the world in consistent manner. A
tool W2W (www.wudapt.org) has been developed and in the WUDAPT Portal linking the outputs of WUDAPT Level 0 into an
urbanized version of a modeling system called “Weather Research and Forecasting” or WRF. WRF (Skamarock et al., 2008) is a
community and science-based atmospheric modelingsystem in widespread use (currently ~ 20,000 code downloads) throughout the
world. The W2W tool provides prospective users, the information and detailed instructions to enable the running of both urban canopy
multi-layer versions in WRF (BEP by Martialli et al., 2002, and BEP-BEM Salamanca et al. (2009) and by using the accompanying
form and function data tables of WUDAPT level “0” data based on the Local Climate Zone (LCZ) classification scheme by Stewart
and Oke (2012). Fig. 17 is a summary of the methodology; an initial implementation for Madrid is in Brousse et al. (2016). Testbeds
will modify and test the current W2W tool for linking the Level 1 and 2 database to running and applying urbanized WRF. This allows
model application extensions to air quality simulations in systems such as WRF-Chem or WRF-CMAQ.

Fig. 17. Scheme for using WUDAPT Level 0 (W2W) in multi-layer urban canopyversions of WRF
Based on Brousse et al. (2016).
A.3.2. ENVI-met
ENVI-met is a prognostic, three-dimensional, high-resolution microclimate model.
With its physical fundamentals that are based on the principles of fluid
mechanics, thermodynamics and the laws of atmospheric physics it is able to calculate
three-dimensional wind fields, turbulence, air temperature and humidity, radiative
fluxes and pollutant dispersion (Bruse and Fleer, 1998). Microclimate models such as
ENVI-met have the advantage that, thanks to their high spatial resolution,
little parameterization is needed to represent objects of the urban environment: Trees, building materials, and complex structures can
be directly reproduced within the model. The ENVI-met model has been evaluated and applied in many studies assessing the
urban microclimate in various climatic regions (Nikolova et al., 2011; Yang et al., 2012; Simon, 2015) and has been previously used to
assess LCZs in urban areas (Middel et al., 2014; Middel et al., 2015).
A current version of the portal tool WUDAPT2ENVI-met uses WUDAPT Level 0 data to generate model areas for the high-
resolution microclimate model ENVI-met. It links level 0 data with the high resolution model thus offering a fast and easy way to
digitize large urban areas in a worldwide consistent manner, the differences in spatial resolution generate issues (Fig. 18) Using higher
level data featuring a city's unique morphologies including the geometry, variations and spatial distribution of buildings, architectural
features, construction materials and green and pervious surfaces actual building as well as vegetation, the linkage between WUDAPT
and ENVI-met offers a huge potential to simulate the urban microclimatein great detail. The combination of WUDAPT's DSC tool
with ENVI-met should allow to analyze, develop and quantify different urban heat island mitigationstrategies in a fast and comparable
way.
11

Ching et al. 2019: Urban Climate https://doi.org/10.1016/j.uclim.2019.100459
Fig. 18. Representation of the Standard LCZ tiles 1–3 and 4–6 gridded in 1 m resolution (they differ in building height only).
A.3.3. W12 and the urban multi-scale environmental predictor (UMEP)
Based on the UMEP workshop description on the ICUC10 website link: Exploring urban planning strategies and their effect on
mitigating heat waves - examples from New York City https://www.ametsoc.org/index.cfm/ams/meetings-events/ams-meetings/10th-
international-conference-on-urban-climate-14th-symposium-on-the-urban-environment/practical-workshop-the-urban-multi-scale-
environmental-predictor-umep/
“UMEP is a versatile open source climate services tool for researchers, architects, urban planners, climatologists, and meteorologists,
which can be used for a variety of applications related to outdoor thermal comfort, urban energy consumption, climate
change mitigation (Lindberg et al., 2017, Lindberg et al., 2018). UMEP is developed as a plugin for QGIS a cross-platform, a free and
open source desktop geographic information system (GIS) application. UMEP consists of a coupled modeling system
which combines state-of-the-art 1-D and 2-D models with systems to input data from multiple sources, formats and at different
temporal and spatial scales, and to generate output as data, graphs and maps. The tool also includes capabilities to connection to
various databases such as WUDAPT (spatial) and WATCH (meteorology)”
Given such ongoing links, the W12 Testbeds will actively collaborate with the developers of the UMEP tool engaging in efforts to
enhance the links to WUDAPT Level 1 and 2 database likely via the WIUDAPT Portal system.
A.3.4. Street–in-Grid (SinG) modeling studies
Studies and models at urban to local street level air pollution, climate change, and their impacts on population exposure and human
health are becoming of increased interest and attention. Several state-of-the-science models have been recently developed for
urban/local street-level air pollution modeling. The innovative modeling framework “SinG” (Kim et al., 2018) has recently be
developed. The SinG system incorporates the street-network “Model of Urban Network of Intersecting Canyons and Highways” (or
MUNICH) and the 3-D Eulerian chemical-transportmodel (CTM), Polair3D. Both models aim to incorporate detailed representations
of gas-phase chemistry and secondary aerosol formation pathways. The WUDAPT Testbeds will be engaged with the SinG to develop
linkages especially between the MUNICH system and the UCPs generated by the WUDAPT DSC tool.
References
D. Aliaga, C. Vanegas, M. Lei, D. Niyogi Visualization-based Decision Tool for Urban Meteorological Modeling Environ. Plan. B: Plan. Des. (EPB), 40 (2) (2013), pp. 271-
288
A. Baklanov, S. Grimmond, A. Mahura, M. AthanassiadouMeteorological and Air Quality Models for Urban Areas Springer (2009) 10.1007/978-3-642-00298-4
A. Baklanov, C.S.B. Grimmond, D. Carlson, D. Terblanche, X.V. Bouchet, B. Lee, G. Langendijk From Urban Meteorology, Climate and Environment Research to Urban
Integrated Services 9th International Conference on Urban Climate w/12th Symposium on the Urban Environment, Toulouse, Fr (2015)
A. Baklanov, L.T. Molina, M. GaussMegacities, air quality and climate Atmos. Environ., 126 (2016), pp. 235-249, 10.1016/j.atmosenv.2015.11.059
A. Baklanov, C.S.B. Grimmond, D. Carlson, D. Terblanche, X. Tang, V.Bouchet, B. Lee, G. Langendijk, R.K. Kolli, A. Hovsepyan From urban meteorology, climate and
environment research to integrated city services Urban Clim., 23 (2018), pp. 330-341
B. Bechtel, C. DanekeClassification of local climate zones based on multiple earth observation data IEEE J.Sel. Top. Appl. Earth Obs. Remote Sens., 5 (4) (2012), pp. 1191-
1202, 10.1109/JSTARS.2012.2189873
B. Bechtel, P. Alexander, J. Böhner, J. Ching, O. Conrad, J. Feddema, G.Mills, L. See, I. Stewart Mapping local climate zones for a worldwide database of form and
function of cities Int J. Geogr. Inf., 4 (1) (2015), pp. 199-219, 10.3390/ijgi4010199
B. Bechtel, M. Demuzere, Y. Xu, M. Verdonck, P. Lopes, L. See, C. Ren, et al. Beyond the Urban Mask: Local Climate Zones as a Generic Descriptor of Urban Areas –
Potential and Recent Developments Joint Urban Remote Sensing Event (JURSE), Dubai (2017)(5-7 March, 2017)
B. Bechtel, Matthias Demuzere, Panagiotis Sismanidis, Daniel Fenner, Oscar Brousse, Christoph Beck, et al. Quality of Crowdsourced Data on Urban Morphology—The
Human Influence Experiment (HUMINEX) Urban Sci., 1 (2) (2017), p. 15 O. Brousse, A. Martilli, M. Foley, G. Mills, B. Bechtel WUDAPT, an efficient land use
producing data tool for mesoscale models: integration of urban LCZ in WRF over Madrid Urban Clim., 17 (2016), pp. 116-134
M. Brown Urban parameterizations for mesoscale meteorological models Z. Boybeyi (Ed.), Mesoscale Atmospheric Dispersion, WIT Press (2000), pp. 193-255
M. Brown, M. Williams An Urban Canopy Parameterization for Mesoscale Meteorological Models 2nd AMS Urban Env. Symp., Albuquerque, NM, U.S.A. (1998)
M. Bruse, H. Fleer Simulating surface-plant-air interactions inside urban environments with a 3-d numerical model Environ. Model. Softw., 13 (1998), 373-384
M. Cai, et al. Investigating the relationship between local climate zone and land surface temperature using an improved WUDAPT methodology – a case study of Yangtze
River Delta, China Urban Clim., 24 (2018) (2018), pp. 485-502
A. Chan, J.C.H. Fung, A.K.H. Lau Influence of urban morphometric modification on regional air pollutant transport J. Geophys. Res., 118 (2013), 10.1002/jgrd. 50263
F. Chen, H. Kusaka, R. Bornstein, J. Ching, C.S.B. Grimmond, S. GrossmanClarke, T. Loridan, K.W. Manning, A. Martilli, S. Miao, D. Sailor, F.P. Salamanca, H.Taha, M.
Tewari, X. Wang, A.A. Wyszogrodzki, C. Zhang The integrated WRF urban modeling system: development, evaluation, and applications to urban environmental
problems Int. J. Climatol., 31 (2010), 273-288
L. Chen, E. Ng, X. An, C. Ren, M. Lee, U. Wang, Z. HeSky view factor analysis of street canyons and its implications for daytime intra-urban air temperature differentials in
high-rise, high-density urban areas of Hong Kong: a GIS-based simulation approach Int. J. Climatol., 32 (1) (2012), pp. 121-136
J.K.S. ChingA perspective on urban canopy modeling for weather climate and air quality applications Urban Clim., 3 (2013), pp. 13-39
J. Ching, M. Brown, S. Burian, F. Chen, R. Cionco, A. Hanna, T. Hultgren, T.McPherson, D. Sailor, H. Taha, D. Williams National urban database and access portal tool
Bull. Amer. Meteor. Soc (2009), 10.1175/2009BAMS2675.1
J. Ching, G. Mills, L. See, B. Bechtel, J. Feddema, A. Hanna, G. Milcinski, V.Masson, M. Neophytou, A. Martilli, O. Brousse, F. Chen, S. Grimmond, I. Stewart, X.Wang, C
. Mitra The Portal component, strategic perspectives and review of tactical plans for full implementation of WUDAPT 9th International Conference on Urban Climate
W/12th Symposium on the Urban Environment, Toulouse, Fr (2015)
J. Ching, G. Mills, L. See, B. Bechtel, J. Feddema, I. Stewart, A. HannaWUDAPT (world urban database and access portal tools) an international collaborative project for
climate relevant physical geography data for the world's cities 96th AMS Annual Meeting, New Orleans, LA (2016)
J. Ching, L. See, C. Ren, V. Masson, J. Hildalgo, X. Wang, G. Mills, J.FeddemaThe WUDAPT framework to generating urban morphology, material composition and
activity data for modeling 13th Urban Environment, 97th AMS Annual Meeting, Jan 22-26, 2017, Seattle WA (2017)
J. Ching, G. Mills, L. See, V. Masson, J. Hidalgo, X. Wang, B. Bechtel, O.Brousse, A. Hanna, D. Niyogi, Dan AliagaEnvironmental Modeling Using WUDAPT for
Addressing Climate Change Issues Impacting Urban Areas, Forum 11: Cool Cities and Urban Heat Islands (UHI), PLEA 2017, July 3–5, 2017, Edinburgh, Scotland
(2017)
12

Ching et al. 2019: Urban Climate https://doi.org/10.1016/j.uclim.2019.100459
J. Ching, G. Mills, B. Bechtel, L. See, J. Feddema, X. Wang, C. Ren, O.Brousse, A. Martilli, M. Neophytou, P. Mouzourides, I. Stewart, A. Hanna, E. Ng, M.Foley, P. Alexa
nder, D. Aliaga, D. Niyogi, A. Shreevastava, P. Bhalachandran, V. Masson, J.Hidalgo, J. Fung, M. Andrade, A. Baklanov, W. Dai, G. Milcinski, M. Demuzere, N.Bruns
ell, M. Pesaresi, S. Miao, Q. Mu, F. Chen, N. Theeuwes 2018: World urban database and access portal tools (WUDAPT), an urban weather, climate and environmental
modeling infrastructure for the Anthropocene Bull. Am. Meteorol. Soc. (2018), 10.1175/BAMS-D-16-0236.1
F. Creutzig, S. Lohrey, X. Bai, A. Baklanov, R. Dawson, S. Dhakal, W.F.Lamb, T. McPhearson, J. Minx, E. Munoz, B. Walsh Upscaling urban data science for global
climate solutions Global Sustainability (2018) (in press)
J. Dai, X. Wang, W. Dai, M. Chang, L. Zhang Investigate the sensitivities of urban canopy parameters in PRD (PRD-UCPs) to meteorological conditions and surface ozone
(2018) (submitted to urban climate WUDAPT virtual special issue)
M. Dirce, M.F. Andrade, J. Ching Effect of Local Climate Zone (LCZ) Classification on Ozone Chemical Transport Model Simulations in Sao Paulo, Brazil (2018)
(Submitted to Urban Climate WUDAPT Virtual Special Issue)
S. Dupont, T. Otte, J. Ching Simulation of meteorological fields within and above urban and rural canopies with a mesoscale model (MM5) Bound.-Layer
Meteorol., 113 (2004), pp. 111-158
J. Feddema, G. Mills, J. Ching Demonstrating the added value of WUDAPT for urban climate modelling Proceedings, 9th International Conference on Urban Climate
(jointly with 12th Symposium on the Urban Environment), July 2015,Toulouse, France. (2015)
I. Garcia-Dorado, D. Aliaga, P. Bhalachandran, P. Schmid, D. NiyogiFast Weather Simulation for Inverse Procedural Design of 3D Urban Models ACM Trans. Grap.
(TOG), 36 (2) (2017) #21, 19 pages
G.F. Garum Review of urban surface parameterizations for numerical climate models Urban Climate, 24 (2018), pp. 830-885
F.Y. Gong, Z.C. Zeng, F. Zhang, X. Li, E. Ng, L.K. NorfordMapping sky, tree, and building view factors of street canyons in a high-density urban environment Build.
Environ., 134 (2018), pp. 155-167
C.S.B. Grimmond, T.R. Oke Aerodynamic properties of urban areas derived from analysis of surface form J. Appl. Meteorol., 38 (9) (1999), pp. 1262-1292, 10.1175/1520-
0450(1999)038<1262:APOUAD>2.0.CO;2
C.S.B. Grimmond, M. Blackett, M.J. Best, J. Barlow, J.J. Baik, S.E.Belcher, S.I. Bohnenstengel, I. Calmet, F. Chen, A Dandou, K Fortuniak et al. The international urban
energy balance models comparison project: first results from phase 1 J. Appl. Meteorol. Climatol., 49 (6) (2010), pp. 1268-1292
J.C.R. Hunt, Y.D. Aktas, A. Mahalov, et al. Climate change and growing megacities: hazards and vulnerability Proceedings of the Institution of Civil Engineers –
Engineering Sustainability, 171 (6)(2018), pp. 314-326, 10.1680/jensu.16.00068
T.L. Jackson, J. Feddema, K. Oleson, G. Bonan, J.T. BauerParameterization of urban characteristics for global climate modeling Ann. Assoc. Am. Geogr., 100 (4) (2010),
pp. 848-865
L. Järvi, C.S.B. Grimmond, A. ChristenThe surface urban energy and water balance scheme (SUEWS): evaluation in Los Angeles and Vancouver J. Hydrol., 411 (2011),
pp. 219-237
Y. Kim, Y. Wu, C. Seigneur, Y. RoustanMulti-scale modeling of urban air pollution: development and application of a Street-in-Grid model (v1.0) by coupling MUNICH
(v1.0) and Polair3D (v1.8.1)Geosci. Model Dev., 11 (2018), pp. 611-629 https://doi.org/10.5194/gmd-11-611-2018
H. Kusaka, F. KimuraCoupling a single-layer urban canopy model with a simple atmospheric model: impact on urban heat island simulation for an idealized case J. Meteor.
Soc. Japan, 82 (2004), pp. 67-80, 10.2151/jmsj.82.67
H. Kusaka, Y. Kikegawa Kondo, F. KimuraA simple single-layer urban canopy model for atmospheric models: comparison with multi-layer and slab models Bound.-Layer
Meteorol., 101 (2001), pp. 329-358, 10.1023/A:1019207923078
A. Lemonsu, V. Masson, L. Shashua-Bar, E. Erell, D. PearlmutterInclusion of vegetation in the town energy balance model for modeling urban green areas Geosci. Model
Dev., 5 (2012), pp. 1377-1393
D. Li, E. Bou-Zeid Synergistic interactions between urban heat islands and heat waves: the impact in cities is larger than the sum of its parts J. Appl. Meteorol.
Climatol., 52 (9) (2013), pp. 2051-2064
F. Lindberg, C.S.B. Grimmond, A. Gabey, B. Huang, C.W. Kent, T. Sun, N.Theeuwes, L. Järvi, H. Ward, I. CapelTimms, Y.Y. Chang, P. Jonsson, N. Krave, D. Liu, D.Mey
er, F. Olofson, J.G. Tan, D. Wästberg, L. Xue, Z. ZhangUrban multi-scale environmental predictor (UMEP) - An integrated tool for city-based climate services Environ.
Model. Softw. (2017), 10.1016/j.envsoft.2017.09.020
F. Lindberg, C.S.B. Grimmond, A. Gabey, L. Jarvi, C.W. Kent, N. Krave, T.Sun, N. Wallenberg, H.C. WardUrban Multiscale Environmental Predictor (UMEP) Manual
University of Reading UK, University of Gothenburg Sweden, SIMS China (2018) https://umepdocs.readthedocs.io/
A. Martilli, A. Clappier, M. RotachAn urban surface exchange parameterization for mesoscale models Bound.-Layer Meteorol., 104 (2002), pp. 261-304
A. Martilli, O. Bousse, J. ChingWUDAPT to WRF www.wudapt.org (2002)
Valery Masson A physically based scheme for the urban energy budget in atmospheric models Bound.-Layer Meteorol., 94 (357–397) (2000), p. 2000
V. Masson, et al. Urban Climate, Human behavior &Energy consumption: from LCZ mapping to simulation and urban planning (the MapUCE project) 9th International
Conference on Urban Climate w/12th Symposium on the Urban Environment, July 2016, Toulouse, Fr (2015)
V. Masson, C. Marchadier, L. Adolphe, R. Aguejdad, P. Avner, M.Bonhomme, G. Bretagne, X. Briottet, B. Bueno, C. de MunckAdapting cities to climate change: a
systemic modeling approach Urban Clim., 10 (2014), pp. 407-429
V. Masson, F. Bonhomme, J. Hidalgo, N. Thornay, S. Faraut, R. SchotterArchitectural archetypes database propositions for WUDAPT 13th Urban Environment, 97th AMS
Annual Meeting, Jan 22-26, 2017, Seattle WA (2017)
V. Masson, M. Bonhomme, J. Hidalgo, N. Thornay, S. Faraut, R.Schoetter, L. See, J. Ching, G. Mills, E. Ng, C. RenArchitectural Archetypes Database Propositions for
WUDAPT, Forum 11: Cool Cities and Urban Heat Islands (UHI), PLEA 2017, July 3–5, 2017, Edinburgh, Scotland (2017)
A. Middel, et al. Impact of urban form and design on mid-afternoon microclimate in Phoenix local climate zones Landsc. Urban Plan., 122 (2014), pp. 16-28
A. Middel, N. Chhetri, R. Quay Urban forestry and cool roofs: assessment of heat mitigation strategies in Phoenix residential neighborhoods Urban For. Urban
Green., 14 (1) (2015), pp. 178-186
A. Middel, J. Lukasczyk, R. Maciejewski Sky view factors from synthetic fisheye photos for thermal comfort routing—a case study in Phoenix, Arizona Urban Plan.
Forum, 2 (1) (2017), pp. 19-30
A. Middel, J. Lukasczyk, R. Maciejewski, M. Demuzere, M. Roth Sky view factor footprints for urban climate modeling Urban Clim., 25 (2018), pp. 120-134
A. Middel, J. Lukasczyk, S. Zakrzewski, M. Arnold, R. MaciejewskiUrban form and composition of street canyons: A human-centric big data and deep learning approach
Landsc. Urban Plan., 183 (2019), pp. 122-132
G. Mills, J. Ching, L. See, B. Bechtel, J. Feddema, V. Masson, I. Stewart, M.Neophytou, M. O'Connor, F. Chen, A. Martilli, S. Grimmond, P. Alexander, M. Foley, T.Gal, X.
Wang, C. Mitra, N. Pereira, G.-J. Steeneveld Introduction to the WUDAPT project Proceedings, 9th International Conference on Urban Climate (Jointly with 12th
Symposium on the Urban Environment), Toulouse, France, July, 2015 (2015)
G. Mills, B. Bechtel, M. Foley, J. Ching, L. See, J. Feddema WUDAPT project: status of database and portal tools 13th Urban Environment, 97th AMS Annual Meeting, Jan
22–26, 2017, Seattle WA (2017)
G. Mills, et al. Using WUDAPT to explore urban exposure to climate risks in selected cities Forum 11: Cool Cities and Urban Heat Islands (UHI), PLEA 2017, July 3–5,
2017, Edinburgh, Scotland (2017)
P. Mouzourides, A. Kyprianou, M.-A. NeophytouA scale-adaptive approach for spatially varying urban morphology characterization in boundary layer parametrization using
multi-resolution analysis. Bound Layer Meteorol., 149 (2013), pp. 455-481
P. Mouzourides, A. Kyprianou, M.J. Brown, B. Carissimo, R.Choudhary, M.K.-A. NeophytouSearching for the distinctive signature of a city in atmospheric modeling: could
the multi-resolution analysis (MRA) provide the DNA of a city? Urban Clim., 10 (2014), pp. 447-475
P. Mouzourides, A. Kyprianou, R. Choudhary, J. Ching, M.Neophytou Multi-scale analysis of urban-scale building-energy demands for smart energey management
Energy (2017) (submitted and revised ??)
P. Mouzourides, A. Eleftheriou, M. Neophytou, J. Ching, A.Kyprianou An investigation of the association between urban micro-climate and CO2 emissions: an example
from metropolitan London within the WUDAPT framework (2018)(Submitted to Urban Climate Special WUDAPT Issue)
P. Musialski, P. Wonka, D. Aliaga, M. Wimmer, L. van Gool, W.Purgathofer A Survey of Urban Reconstruction Computer Graphics Forum (CGF), earlier version in
Eurographics 2012 STAR (2013), p. 28
E. Ng Towards a planning and practical understanding for the need of meteorological and climatic information for the Design of High Density Cities – a case based study of
Hong Kong Int. J. Climatol., 32 (2010), pp. 582-598 (2012) https://doi.org/10.1002/joc.2292
E. Ng, C. Ren (Eds.), Urban Climatic Map – A Methodology for Sustainable Urban Planning, 978-1-84971-376-4, Earthscan-Routledge, London, UK (2015)
E. Ng, C. Ren China’s adaptation to climate & urban climatic changes: A critical review Urban Climate, 23 (2018), pp. 352-372, 10.1016/j.uclim.2017.07.006
I. Nikolova, S. Janssen, P. Vos, K. Vranken, V. Mishra, P. BerghmansDispersion modelling of traffic induced ultrafine particles in a street canyon in Antwerp, Belgium and
comparison with observations Sci. Total Environ., 412-413 (2011), pp. 336-343
D. Niyogi, S. Bhalachandran, O. Brousse, M. Jain, A. Shreevastava, A.P.DimriInvestigation of the impact of urbanization under the 2015 Delhi heat wave scenario 13th
Symposium of the Urban Environment, American Meteorological Society 97th Annual Meeting. Jan, 2017, Seattle, WA (2017)
T. Oke, G. Mills, A. Christen, J.A. Voogt Urban Climates Cambridge University Press (2017)
13

Ching et al. 2019: Urban Climate https://doi.org/10.1016/j.uclim.2019.100459
K.W. Oleson, G.B. Bonan, J. Feddema, M. Vertenstein, C.S.B. GrimmondAn urban parameterization for a global climate model. Part I: formulation and evaluation for two
cities J. Appl. Meteorol. Climatol., 15588432, 47 (4) (2008), p. 10381060, 10.1175/2007JAMC1597.1
T. Otte, A. Lacser, S. Dupont, J. Ching Implementation of an urban canopy parameterization in a mesoscale meteorological model J. Appl. Meteorol., 43 (2004), pp. 1648-
1665
Y. Parish, P. Müller Procedural modeling of cities In Proceedings of the 28th annual conference on Computer graphics and interactive techniques (SIGGRAPH
'01), ACM, New York, NY, USA (2001), pp. 301-308, 10.1145/383259.383292
G. Pigeon, K. Zibouche, B. Bueno, J. Le Bras, V. Masson Evaluation of building energy simulations with the TEB model against EnergyPlus for a set of representative
buildings in Paris Energy Build., 76 (2014), pp. 1-14, 10.1016/j.enbuild.2013.10.038
C. Ren, E. Ng, Y.Y., and Katzchner, L. Urban climatic map studies: a review Int. J. Climatol., 31 (15) (2011), pp. 2213-2333
Chao Ren, L.A.U. Ka Lun, Y.I.P. Kam-po, N.G. Yan Yung The Application of Urban Climatic Mapping to the Urban Planning of High-Density Cities: The Case of
Kaohsiung, Taiwan. Cities 31 (2013), pp. 1-16 2013https://doi.org/10.1016/j.cities.2012.12.005
C. Ren, J. Fung, J. Tse, Y. Xu Implementing WUDAPT product into urban development impact analysis by using WRF simulation result - A case study of the pearl river
delta region (1980-2010) 13th Urban Environment, 97th AMS Annual Meeting, Jan 22-26, 2017, Seattle WA (2017)
C. Ren, R. Yang, C. Cheng, P. Xing, X. Fang, S. Zhang, H. Wang, Y. Shi, X. Zhang, Y.T. Kwok, E. NgCreating breathing cities by adopting urban ventilation assessment
and wind corridor plan – the implementation from Chinese cities J. Wind Eng. Ind. Aerodyn. (2018) SI: Wind-related Disasters (under review)
A. Revi, D.E. Satterthwaite, F. Aragón-Durand, et al. Urban areas
C.B. Field et al. (Eds.), Climate Change 2014: Impacts, Adaptation, and Vulnerability. Part A: Global and Sectoral Aspects. Contribution of Working Group II to the Fifth
Assessment Report of the Intergovernmental Panel on Climate Change, Cambridge University Press, Cambridge, United Kingdom (2014), pp. 535-612 and New York,
NY, USA
F. Salamanca, A. Krpo, A. Martilli, A. Clappier A new building energy model coupled with an urban canopy parameterization for urban climate simulations—part I.
Formulation, verification, and sensitivity analysis of the model Theor. Appl. Climatol., 99 (3) (2009), pp. 331-344, 10.1007/s00704-009-0142-9
R. Schoetter, V. Masson, A. Bourgeois, M. Pellegrino, J.-P. LévyParametrisation of the variety of human behaviour related to building energy consumption in TEB
(SURFEX v. 8.2) Geosci. Model Dev., 10 (2017), pp. 2801-2831, 10.5194/gmd-10-2801-2017
L. See, G. Mills, J. Ching Community initiative tackles urban heat NATURE, 526 (2015), p. 43
L. See, J. Ching, V. Masson, J. Feddema, G. Mills, M. Neophytou, M. Foley, M. O'Connor, C. Perger, M. Duerauer, S. Fritz, B. BechtelGenerating WUDAPT's specific
scale-dependent urban modeling and activity parameters: collection of level 1 and level 2 data Proceedings, 9th International Conference on Urban Climate (Jointly with
12th Symposium on the Urban Environment), Toulouse, France, July, 2015 (2015)
Y. Shi, X.L. Xie, J.C.H. Fung, E. Ng Identifying critical building morphological design factors of street-level air pollution dispersion in high-density built environment using
mobile monitoring Build. Environ., 128 (2018), pp. 248-259, 10.1016/j.buildenv.2017.11.043
H. Simon Modeling urban microclimate Development, Implementation and Evaluation of New and Improved Calculation Methods for the Urban Microclimate Model ENVI-
Met, Johannes Gutenberg Universität-Mainz, Dissertation (2015)
L.W. Siu, M.A. Hart Quantifying urban heat island intensity in Hong Kong SAR, China Environ. Monit. Assess., 185 (5) (2013), pp. 4383-4398
I. Sobel, G. Feldman A 3x3 isotropic gradient operator for image processing presented at the Stanford Artificial Intelligence Project (SAIL) in (1968)
I. Stewart, T. Oke Local climate zones for urban temperature studies Bull. Amer. Meteor. Soc., 93 (12) (2012), pp. 1880-1900 https://doi.org/10.1175/BAMS-D-11-00019
J.W.P. Tse, P.S. Yeung, J.C.H. Fung, C. Ren, R. Wang, M.F. Wong, M. CaiInvestigation of the meteorological of urbanization in recent decades: A case study of major cities
in Pearl River Delta Urb Clim., 26 (2018), pp. 174-187
N. Tornay, R. Schoetter, M. Bonhomme, S. Faraut, A. Lemonsu, V. MassonGENIUS : a methodology to define a detailed description of buildings for urban climate and
building energy consumption simulations Urban Clim., 10 (2017), pp. 75-93, 10.1016/j.uclim.2017.03.002
C. Vanegas, D. Aliaga, P. Wonka, P. Müller, P. Waddell, B. WatsonModeling the appearance and behavior of urban spaces Comp. Graph. Forum (CGF) Eurographics
STAR (2009), p. 17
C. Vanegas, D. Aliaga, B. Benes, P. Waddell Interactive design of urban spaces using geometrical and behavioral modeling ACM Trans. Graph. (TOG) ACM SIGGRAPH
Asia, 28 (5) (2009), p. 10
C. Vanegas, T. Kelly, B. Weber, D. Aliaga, P. Mueller Procedural generation of parcels in urban modeling Proc. EUROGRAPHC Comp. Graph. Forum S., 31 (2) (2012),
p. 15 (pg)
C. Vanegas, D. Aliaga, B. Bedrich, P. Waddell Inverse design of urban procedural models. Proceedings ACM Trans. Graph., 31 (6) (2012), p. 11
C. Wang, A. Middel, S.W. Myint, A.J. Brazel, S. Kaplan, J. LukasczykLocal climate zones in Arid Desert cities – An assessment for Phoenix, Arizona and Las Vegas,
Nevada, USA ISPRS J. Photogramm. Remote Sens., 141 (2018), pp. 59-71, 10.1016/j.isprsjprs.2018.04.009
R. Wang et al. Mapping the local climate zones of urban areas by GIS-based and WUDAPT methods: a case study of Hong Kong. Urban Climate 24 (2018), 567-576
WMO Guide for urban integrated hydro-meteorological, climate and environmental services Part 1: Concept and Methodology, World Meteorological Organization (2018)
endorsed by WMO EC-70 on 21 June 2018, EC-70/Doc. 4.3(2)
https://www.wmo.int/pages/prog/arep/gaw/documents/UrbanIntegratedServicesPart1aConceptandMethodologyEC-70.pdf
WMO The 17th World Meteorological Congress Resolution 68(CG-17): Establishing WMO Cross-cutting Urban Focus
https://www.wmo.int/aemp/sites/default/files/wmo_1157_en.pdf (2015)
M. Wong, J. Fung, J. Ching, P. Yeung, J. Tse, C. Ren, Ren Wang, M. CaiEvaluation of uWRF Performance and Modeling Guidance Based on WUDAPT and NUDAPT
UCP Datasets for Hong Kong, Submitted to Urban Climate WUDAPT VSI (2018)
L. Wu, X. Wang Development of a high-spatial and temporal on-road emission inventory based on the traffic data and its impact on air quality in Guangzhou International
conference on ABaCAS and CMAS-Asia-Pacific, May 22-23 (2018) (2018, Beijing)
Y. Xu, et al. Urban morphology detection and computation for urban climate research Landsc. Urban Plan., 167 (Supplement C) (2017), pp. 212-224
X. Yang, L. Zhao, M. Bruse, Q. Meng An integrated simulation method for building energy performance assessment in urban environments Energ. Build., 54 (243) (2012),
pp. 243-251
N. Zhang, Z. Gao, X. Wang, Y. Chen Modeling the impact of urbanization on the local and regional climate in Yangtze River Delta China. Theor. Appl.
Climatol., 102 (2010), pp. 331-342
Y. Zhang, X. Wen, C. Jang Simulating chemistry-aerosol-cloud-radiation climate feedback over the continental U.S. using online-coupled weather research forecasting
model with chemistry (WRF/Chem) Atmos. Environ., 44 (2010), pp. 3568-3582
Y. Zheng, C. Ren, Yong Xu, R. Wang, J. Ho, Kevin Lau, E. Ng GIS-based mapping of Local Climate Zone in the high-density city of Hong Kong, Urban Climate vol
24 (2018), pp. 243-251, 10.1016/j.uclim.2017.05.008
14
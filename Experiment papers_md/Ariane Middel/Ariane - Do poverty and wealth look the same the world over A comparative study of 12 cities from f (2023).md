Sueletal.
RESEARCH
| Do poverty  |               | and       | wealth |     |       | look |     | the    | same   |         | the  | world |      |
| ----------- | ------------- | --------- | ------ | --- | ----- | ---- | --- | ------ | ------ | ------- | ---- | ----- | ---- |
| over?       | A comparative |           |        |     | study |      | of  | 12     | cities |         | from |       | five |
| high-income |               | countries |        |     | using |      |     | street |        | images. |      |       |      |
Suel1,2,3*, Muller2,3, Bennett2,3, Blakely4, Doyle5, Lynch6,7,
| Esra        | Emily        |                 | James       | E.  |      |            | Tony |       | Yvonne       |     |         | John |     |
| ----------- | ------------ | --------------- | ----------- | --- | ---- | ---------- | ---- | ----- | ------------ | --- | ------- | ---- | --- |
|             | Mackenbach8, |                 | Middel9,12, |     |      | Mizdrak10, |      |       | Nathvani2,3, |     |         |      |     |
| Joreintje   | D.           |                 | Ariane      |     | Anja |            |      | Ricky |              |     | Michael |      |     |
| Brauer11,13 | and Majid    | Ezzati2,3,14,15 |             |     |      |            |      |       |              |     |         |      |     |
*Correspondence:e.suel@ucl.ac.uk
| 1CentreforAdvancedSpatial |     |     | Abstract |     |     |     |     |     |     |     |     |     |     |
| ------------------------- | --- | --- | -------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Analysis(CASA),University
|     |     |     | Urbanization | and | inequalities |     | are two | of  | the major | policy | themes | of our | time, |
| --- | --- | --- | ------------ | --- | ------------ | --- | ------- | --- | --------- | ------ | ------ | ------ | ----- |
CollegeLondon,London,UK
|     |     |     | intersecting | in  | large cities | where | social | and | economic | inequalities |     | are | particularly |
| --- | --- | --- | ------------ | --- | ------------ | ----- | ------ | --- | -------- | ------------ | --- | --- | ------------ |
Fulllistofauthorinformationis
availableattheendofthearticle pronounced. Large scale street-level images are a source of city-wide visual
|     |     |     | information | and | allow | for comparative |     | analyses | of  | multiple | cities. | Computer |     |
| --- | --- | --- | ----------- | --- | ----- | --------------- | --- | -------- | --- | -------- | ------- | -------- | --- |
vision methods based on deep learning applied to street images have been shown
to successfully measure inequalities in socioeconomic and environmental features,
|     |     |     | yet existing       | work         | has     | been within |         | specific    | geographies   | and        | have           | not looked    | at      |
| --- | --- | --- | ------------------ | ------------ | ------- | ----------- | ------- | ----------- | ------------- | ---------- | -------------- | ------------- | ------- |
|     |     |     | how visual         | environments |         | compare     |         | across      | different     | cities     | and countries. |               | In this |
|     |     |     | study, we          | aim to       | apply   | existing    | methods |             | to understand |            | whether,       | and           | to what |
|     |     |     | extent,            | poor and     | wealthy | groups      | live    | in visually | similar       |            | neighborhoods  |               | across  |
|     |     |     | cities and         | countries.   | We      | present     | novel   | insights    | on            | similarity | of             | neighborhoods |         |
|     |     |     | using street-level |              | images  | and         | deep    | learning    | methods.      | We         | analyzed       | 7.2           | million |
images from 12 cities in five high-income countries, home to more than 85 million
|     |     |     | people: | Auckland | (New | Zealand), |     | Sydney | (Australia), | Toronto |     | and Vancouver |     |
| --- | --- | --- | ------- | -------- | ---- | --------- | --- | ------ | ------------ | ------- | --- | ------------- | --- |
(Canada), Atlanta, Boston, Chicago, Los Angeles, New York, San Francisco, and
|     |     |     | Washington      | D.C. | (United    | States | of           | America), | and          | London | (United | Kingdom). |              |
| --- | --- | --- | --------------- | ---- | ---------- | ------ | ------------ | --------- | ------------ | ------ | ------- | --------- | ------------ |
|     |     |     | Visual features |      | associated | with   | neighborhood |           | disadvantage |        | are     | more      | distinct and |
unique to each city than those associated with affluence. For example, from what
|     |     |     | is visible    | from street |               | images, | high         | density | poor neighborhoods |            |               | located | near the |
| --- | --- | --- | ------------- | ----------- | ------------- | ------- | ------------ | ------- | ------------------ | ---------- | ------------- | ------- | -------- |
|     |     |     | city center   | (e.g.,      | in London)    |         | are visually |         | distinct from      | poor       | suburban      |         |          |
|     |     |     | neighborhoods |             | characterized |         | by lower     | density | and                | lower      | accessibility | (e.g.,  | in       |
|     |     |     | Atlanta).     | This        | suggests      | that    | differences  | between |                    | two cities | is also       | driven  | by       |
historical factors, policies, and local geography. Our results also have implications
|     |     |     | for image-based    |               | measures     | of                | inequality  | in    | cities especially |              | when              | trained      | on data   |
| --- | --- | --- | ------------------ | ------------- | ------------ | ----------------- | ----------- | ----- | ----------------- | ------------ | ----------------- | ------------ | --------- |
|     |     |     | from cities        | that          | are visually |                   | distinct    | from  | target cities.    | We           | showed            | that         | these are |
|     |     |     | more prone         | to            | errors       | for disadvantaged |             | areas | especially        |              | when transferring |              | across    |
|     |     |     | cities, suggesting |               | more         | attention         | needs       | to    | be paid           | to improving |                   | methods      | for       |
|     |     |     | capturing          | heterogeneity |              | in poor           | environment |       | across            | cities       | around            | the          | world.    |
|     |     |     | Keywords:          | street        | images;      | visual            | similarity; |       | computer          | vision;      | urban             | inequalities |           |
|     |     | 1   | Introduction       |               | and          | background        |             |       |                   |              |                   |              |           |
Inequalitiesareontherisegloballyandincreasinglyrecognizedasasocial,political,
and ethical problem [1, 2, 3]. Cities are fundamental in addressing inequalities as
they account for 55% of the global population, and 81% in high-income countries
where rich and poor are side by side (United Nations, 2019). The COVID-19 pan-

Sueletal. Page2of13
demic and recent extreme weather events have exposed spatial and environmental
inequalities in cities and their impacts on health and wellbeing [4, 5, 6]. For exam-
ple, poor and wealthy areas of a city can differ in access to green spaces and tree
canopy, walking and cycling infrastructure, safety, density, overcrowding and qual-
ityofhousing,andtypesofservicesandshops[7,8,9,10,11,12].Citygovernments
have the tools to influence such features to help provide solutions to spatial and
social inequalities. Many of these features are visible yet, there are no data on sim-
ilarities or differences in the urban environments, and their visual representation,
experiencedbythewealthiestandpoorestcitydwellersaroundtheglobe.Suchcom-
parative understanding is crucial to cities globally to design effective interventions
suited to local needs.
Visualinformationfromstreetscapeshavebeenusedtostudyurbaninequalitiesat
leastasfarbackasCharlesBooth’s‘InquiryintotheLifeandLabourofthePeople
in London’ in the 1880s [13]. Urban ground-level visuals provide a rich perspective
on the environment that people experience: they contain information on types,
materialsandconditionofbuildings;extentandsafetyofroadsandsidewalks;types
and density of vehicles, people, cyclists, shops, public spaces, and other amenities;
green and blue space; and sources of pollution [7, 9, 14, 15]. Photography projects
have also captured stark visual differences of rich and poor neighborhoods [16, 17,
18] and change associated with gentrification [9].
Booth and much of the early work on visual features of cities relied on in-
person site visits which restricted the areas of the city that they could study. Large
scale street-level images are a source of city-wide visual information and allow for
comparative analyses of multiple cities [19]. Computer vision methods can infer
socioeconomic and environmental features from a large number of street images
[20,7,21,9,22].Worktodateinusingimagestoinfersocioeconomicmeasureshas
been within specific geographies and have not looked at how they compare across
different cities and countries. In this study, we aim to understand whether poor
and wealthy groups live in visually similar environments across cities and countries
using deep learning methods applied to street-level images. A comparative under-
standing of streetscapes, and their inequalities, in cities around the world can also
guide how we envision, develop, and design equitable, inclusive, and resilient cities.
This is also crucial for evaluating whether image-based measurements using deep
learning methods, that have become increasingly popular over the past few years
[20, 7, 9, 21, 22], are biased when trained on data from cities that are visually
distinct from target cities.
Westudiedsimilaritiesofvisualfeaturesanddistinctnessofurbanenvironmentsof
themostandleastadvantagedcommunitiesacross12citiesinfivecountries,hometo
morethan85millionpeople:Auckland(NewZealand),Sydney(Australia),Toronto
and Vancouver (Canada), Atlanta, Boston, Chicago, Los Angeles, New York, San
Francisco, and Washington D.C. (United States of America), and London (United
Kingdom) (Figure 1). These cities are located in “English speaking” high-income
countries where income inequalities are pronounced [23, 24]. We obtained images
and data on household income at census tract level for all cities for comparative
analyses.Wedividedcensustractsintodecilesofhouseholdincome,withdecileone
corresponding to the worst-off 10% and decile ten to the best-off 10% of each city.

Sueletal. Page3of13
We analyzed a total of 7.2 million publicly available street images where we sam-
pled a fixed number of street image locations for each census tract from Google
Street View. Images were geotagged and assigned to the decile class of the corre-
spondingcensustract(SeeMaterialsandMethodsforfurtherdetails).Weevaluated
similarityinvisualfeaturesbetweencitiesbymeasuringhowwellamodeltrainedin
onecityperformedwhenmakingincomedecilepredictionsusingimagesfromother
cities [25]. We use the mean absolute error (MAE), defined based on the difference
between predicted deciles and ground truth deciles, to measure the performance of
the models.
We used a deep learning method to automatically recognize, i.e. learn, visual
features from street images that are associated with different levels of income [20,
26, 27, 7, 28, 9, 29, 30, 22, 31]. First, we trained our network using all image-
label pairs from one ‘source’ city and the remaining cities were withheld. We then
used the withheld images from ‘target’ cities to evaluate the transferability of the
model.Meanabsoluteerror(MAE)valueswerecomputedseparatelyforeachtarget
city. We repeated this process 12 times using a different city as the ‘source’ each
timesothatweincludedallpairsofcities.Inadditiontointer-citycomparisons,we
testedthenetworkwithineachcity.Forintracityperformances,wetrainednetworks
separately for each city using five-fold cross validation. In each fold, image-output
pairs for 80% of census tracts from one city were used for training our model and
the remaining 20% were withheld. (samples stratified by deciles). Repeating this
process five times holding out a different 20% of tracts each time, we computed the
average MAE across the hold-out samples to evaluate intracity performance. We
evaluatedpredictionperformancesforthebest-off10%andworst-off10%tractsfor
each city, which represents extremes of inequality.
2 Data and methods
2.1 Definition of city boundaries and census tracts
Countries differ in how city boundaries are defined based on population size and
density, as well as city history, urban function, and administrative and political or-
ganization. We used definitions by national statistical offices in each of the respec-
tive countries as follows (see SI Appendix for detailed definitions). For Auckland,
we used urban area (UA) boundaries as defined by Statistics New Zealand. For
Sydney, we used significant urban area (SUA) boundary as defined by Australian
BureauofStatistics.ForTorontoandVancouver,weusedcensusmetropolitanarea
(CMA) boundaries as defined by Statistics Canada. For US cities in this study, we
used urbanized area (UA) boundaries as defined by the US Census Bureau. For
London, we used built-up area (BUA) (previously called urban areas) boundaries
asdefinedbyUKOfficeofNationalStatistics.FigureS2showseachboundarywith
an underlying base map for each city.
For each of our study cities, we used the smallest standard geographic area i.e.,
census tract definition for which income data was available. We use Census Blocks
forUS,LowerLayerSuperOutputAreasforUK,DisseminationAreasforCanada,
Statistical Areas Level 1 for Australia, and Statistical Area 1 for New Zealand
(see SI Appendix for detaileddefinitions). Average census tract population and the
number of census tracts for each city are presented in Table S1.

Sueletal. Page4of13
| 2.2 Image | data |     |     |     |     |     |
| --------- | ---- | --- | --- | --- | --- | --- |
A total of 7,233,320 images from 15 cities were accessed using the Google Street
View Application Programming Interface (API). We first created a 50m grid for
each of the cities using city boundary shape files. We then used the API to retrieve
the unique panorama ids (‘panoid’) of images near each grid point acquired by
Google for the years 2007-2019. A fixed number of panoids for each census tract
were used prioritizing images taken in recent years. Census tracts are defined to
have a similar population size for each country, yet their sizes vary across countries
depending on how they are defined by statistical agencies in respective countries.
Wewantedoursamplednumberofimagestoberoughlyproportionaltothecensus
tracts’ population. Therefore, we used 20 images from census tracts with smaller
population sizes (i.e., Auckland, Sydney, Toronto, and Vancouver) and 30 images
from census tracts from all other cities that have larger census tract populations
(see SI Appendix Table 1). We used 30 images per census tract for all other cities
that have larger census tract populations. Census tracts within the city boundaries
thatdidnothavetherequirednumbersofimages,constituting1%ofalltracts,were
excluded from our analysis. For each sampled panoid location, we used four images
|              |                   |     |      | 360°     | (0°, 90°, 180°, | 270°)       |
| ------------ | ----------------- | --- | ---- | -------- | --------------- | ----------- |
| representing | four orientations |     | of a | panorama |                 | to estimate |
all directions within view. Table S1 shows the number of and average populations
of census tracts for each city as well as the number of images obtained per census
| tract and | in total. |               |     |     |     |     |
| --------- | --------- | ------------- | --- | --- | --- | --- |
| 2.3 Data  | on income | and education |     |     |     |     |
Detailed data sources and metadata from national statistics offices for income and
education for each of the cities are given in SI Appendix. For each outcome for
each city, we calculated deciles of census tracts, with decile 1 corresponding to the
| worst-off | 10% and decile | 10         | to the | best-off 10%. |     |     |
| --------- | -------------- | ---------- | ------ | ------------- | --- | --- |
| 2.4 Deep  | learning-based | assignment |        | to deciles    |     |     |
Following [22], we used pre-trained VGG16 [32] weights (trained on ImageNet [33]
for object detection and classification i.e., not focusing on street images) as a fixed
feature extractor to convert street view images to 4096 dimensional codes. We use
the same network structure and loss function used by [22], where the inputs to the
network are four images from one location and the output is an outcome decile
(Figure S7). We trained for the weights of the fully connected layers using image-
label pairs described in the previous section in all cities in our sample. The true
labels used during training were the decile classes associated with the census tracts
fromwhichtheimagesweresampledfrom.ThenetworkwastrainedusingPyTorch
in Python. For all experiments, we used the Adam optimizer with a learning rate
0.0001 and a batch size of 20 training the network for 30 epochs. The network that
| yielded         | the best validation |            | error was   | kept as the | final model. |     |
| --------------- | ------------------- | ---------- | ----------- | ----------- | ------------ | --- |
| 2.5 Measurement | of                  | prediction | performance |             |              |     |
Fortransferabilityperformances,i.e.,multicityexperiments,alldatafromthesource
(i.e.,training)citywereusedfortraining.Wemeasuredhowwellthetrainednetwork
usesimagestopredictoutcomesinallothertarget(i.e.,prediction)citiesthatwere

Sueletal. Page5of13
not used in training [22]. We evaluated the performance using mean absolute error
(MAE).
For evaluating how well models performed when making predictions for commu-
nities within the same city, i.e., single city experiments, we used five-fold cross
validation. The census tracts of a city were randomly allocated to five equally sized
groups of 20%. In each fold, 80% of census tracts (all images in these tracts) were
used for training the network and the remaining 20% were withheld. We then mea-
sured how well the trained network uses images to predict outcomes for census
tracts that were not used in training. We repeated this process five times for each
of the cities holding out a different 20% of census tracts each time.
2.6 Data on population density and distances to the city center
Foracomparativemeasureofpopulationdensity,wecomputedthenumberofpeople
per km2 for each census tract. For distances to CBDs, we used coordinates for
the CBD for each city from OpenStreetMaps and computed distances between the
centroid point of each census tract and the CBD in kilometers.
Distributionsofthewealthiestandpoorestcensustractsoverspaceweresubstan-
tially different for Canadian cities and most American cities compared to London,
Sydney, and Auckland. Figure S5 and Figure S6 show comparisons in population
densityanddistancestotheCBDineachcitybetweenthehighestandlowestincome
neighborhoods. North American cities are characterized by highest income groups
living in car-dependent low-density suburbs whereas the lower income groups live
nearthecenterwithhighpopulationdensity.Thepoortendtoliveclosetothecity
center as highlighted by the right-skewed distributions in Figure S5. Most of the
highest income groups live farther away from the center as they have access to cars
and ability to afford costs of private transport, and hence can afford to live farther
fromthecenter.Populationdensitydistributions(FigureS6)forhighincomegroups
are much narrower, which is intuitive as they have more opportunities to choose
their neighborhoods to live in their preferred density. This is consistent with the
suburbanization and car-oriented development history of American and Canadian
cities,wherehighincomepeoplewhocanaffordcarschosetomoveoutsidethecity
toconsumemoreland[34]alongsidetheso-called“whiteflight”phenomenon([35]).
These patterns, which will also have visual signs captured by street-level images,
are reversed for London, Sydney, and Auckland where it is mostly the high-income
groups that live closer to CBDs and the lower income groups father away from the
center. Land near CBDs is valuable, and it is mostly the rich who can afford to
live there as affordable housing in the center of these cities are scarce. The distri-
butions of population density for the best-off 10% and worst-off 10%, as shown in
FigureS6,aremostlyoverlappingwherebothincomesegmentsliveinsimilarareas
with respect to their density. In these cities, especially for London, dense, walka-
ble, transit-oriented neighborhoods are also attractive for high-income segments of
thepopulation.SanFranciscoandNewYorkhadsomewhatdifferentpatternsfrom
other US cities, and similar to London, where instead many high-income neigh-
borhoods are located near the center, populated by people who prefer to live near
well-paying jobs and urban amenities.

Sueletal. Page6of13
2.7 Regression analysis for predictors of similarity
Wetestedwhetherwithincitydifferencesinpopulationdensityanddistancetocity
center as experienced by the wealthiest and poorest deciles would explain poorer
transferability performance between city pairs. To do this, we needed a quantita-
tive metric to summarize ‘the difference in differences’, comparing the difference
in density and distance to CBD between the richest and poorest deciles for each
city. We used the test-statistic of a two-sample t-test for each city and each metric;
large positive or negative values of the test-statistic indicate strong evidence of a
difference between richest and poorest deciles in that city, smaller values indicate
weak or no evidence for a difference.
We then carried out a regression analysis (Eq. 1) using the absolute difference
betweenthetest-statisticsinthetwocitiesforeachofthemetricsascovariates.We
also included city-specific intercepts (constants) as well as an indicator variable for
intra-country transfer. We ran separate estimations for the best-off and worst-off
deciles (Table 1).
MEA =CSC +β ∗I +β ∗ddensity +β ∗ddistance (1)
st t 1 intra 2 st 3 st
where s and t are source and target cities respectively. CSC is the city specific
constant to be estimated, β are parameters to be estimated. ddensity is the differ-
ence between source and target city t-statistics computed for population density.
ddistance is the difference between source and target city t-statistics computed for
distance to CBD. I is the indicator variable for intra-country transfer.
intra
3 Results
3.1 Visual similarity between wealthiest areas compared to poorest areas
Tolstoy famously said “Happy families are all alike; every unhappy family is un-
happy in its own way [36].” In the context of different neighborhoods in cities,
higher-income residents have more opportunities to choose their neighborhoods to
live in their favored neighborhoods aligned with their preferences across many di-
mensions(e.g.,proximitytoservices,accesstogreenspaceandparks,density,qual-
ity of infrastructure). Conversely, lower-income residents face significant trade-offs
when deciding where to reside, often having to make do with what is available and
affordable, which can vary greatly between cities. As a result of these influences,
wehypothesizedthatwell-offresidentswouldliveinvisuallysimilarneighborhoods,
while deprived neighborhoods would be more heterogenous. Indeed, when we use
street-level images, we found that well-off neighborhoods look relatively alike while
deprived neighborhoods are more distinctive, especially in different cities using a
similarity metric based on transferability performance of our deep learning model.
Specifically,meanabsoluteerrorvalueswereconsistentlylowerwhenpredictingthe
best-off 10% than predicting the worst-off 10% as shown in Figure 2 and Table
S2 (67% of transfer city pairs). This was consistent for within-city and across city
transferability experiments, being more pronounced in the latter. There was a sig-
nificant difference in across city MAEs for best-off (mean = 2.44, median = 2.19)
and worst-off (mean = 2.69, median = 2.68) deciles using the t-test on two related
samples of scores (p<0.001). When we only look at within city comparisons using

Sueletal. Page7of13
cross-validation, the MAEs of best-off (mean = 1.10, median = 1.10) were lower
than MAEs of worst-off (mean = 1.26, median = 1.18) deciles, but this difference
was not significant. Significant differences between cross-city MAEs suggest that
visual features associated with poorer areas are distinct and unique to each city
compared to wealthier areas that share more visual features across countries.
Poorareasinallcitiesdisplaysignsofdisrepairandpoorconditionofpavements,
roads, homes, and gardens, but differ in other features such as building design.
As examples, Figure 3 shows images from poorest and wealthiest communities in
different cities. Images of poorly maintained social housing and tower blocks are
symbolsofovercrowdingandpovertyinLondonandToronto(MAEof2.22and3.10
where Toronto and London are target cities respectively), in contrast to Atlanta’s
poor living in low-density suburbs (MAE of 4.6 and 3.72 for Toronto and London
astargetandAtlantaassourcecities).Carsarethedominantmodeoftravelforall
segments of population in cities such as Auckland and Atlanta with low population
density, in contrast to cities like San Francisco and London where public transport
is widely accessible. Trees and green space are visible in images of low-density
neighborhoods of cities like Atlanta but are also of different character (e.g., large
areas of greenspace containing gravel roads and nature paths) compared to urban
parks and trees visible in higher density neighborhoods of London or New York
(average MAE of 4.06 and 3.67 respectively for London and New York as target
and Atlanta as source cities).
Wealthier residents can afford to live in neighborhoods with better amenities [8],
as a result of which higher quality spaces look visually similar even in different
countries. Another potential driver for higher similarity of higher-income neighbor-
hoods may be related to there being a generic aspirational vision of what a well-off
neighborhood looks like (e.g., new and well-maintained homes, low disorder) that
may be in part shaped by media. There is nonetheless between-city heterogeneity,
albeit to a lesser extent, in what constitutes a wealthy neighborhood. For example,
wealthy communities where people live in apartment buildings in London and New
York contrast to houses in most other American cities. Luxury apartment build-
ings in financial districts of New York and London with access to urban parks are
visuallydistinctfromtheluxurymansionsofLosAngeleswithwell-maintainedpri-
vategardens(SeeFigureS4forpredictionmapsforLondonwhentransferringfrom
different target cities).
3.2 Comparisons between cities within the same country and across different countries
Poorandrichcommunitieslookedmoresimilartotheircounterpartsinothercities
in the same country, than to those in cities in different countries. Models trained
on data from an US city made better predictions in other US cities than in non-
US cities, as was the case for Canadian cities. The same pattern was observed
between Sydney and Auckland, which are in the pacific region although not in
the same country. These cities share similarities in their climates, cultures, social
andpoliticalhistory,andarchitecture.Wealsohypothesizedthatneighborhoodsin
big cities with populations of more than 5 million each (New York, Los Angeles,
London, Chicago, Toronto, Sydney) would be more similar. However, we did not
observe this from our results.

Sueletal. Page8of13
In addition, poor prediction performances for Auckland, Sydney, London, and
Atlantawhentransferringfromothersourcecities(averageMAEof3.42,3.10,2.87
and 2.85 respectively as target cities) are consistent with observed differences in
spatial patterns described in Section 2.7. It mirrors local differences, for example,
that the well-off residents of London live in areas characterized by high building
density and are hence visually distinct from the well-off suburbs in Los Angeles.
3.3 Predictors of similarity
Weconsidereddifferencesacrosscitiesbetweenthehighestandlowestincomedeciles
intwowell-definedandquantifiablefeaturesdescribedabove:theirpopulationden-
sity and distances to the city’s central business district (CBD), as predictors of
inter-city similarity. Both features have direct visual signs, such as more buildings,
cars,andlessskyview,thatarecapturedbystreetimages.Tosummarizeandquan-
tify the role of differences and similarities observed in Figure S5 and Figure S6, we
conducted regression analyses (Figure 4). Indeed, we find that the magnitude and
direction of differences in population density and distance to city center between
poor and wealthy neighborhoods partially explain their visual similarities between
cities.
BetweencityMAEswereregressedagainstanindicatorforwhetherthepredicted
and training cities were in the same country, and differences in population density
and distances to city center between the corresponding two cities (Eq. 1). The
test-statistic corresponds to a two-sample t-test where large positive or negative
valuesofthetest-statisticindicatestrongevidenceofadifferenceinthemetric(e.g.,
population density) between tracts in lowest and highest income deciles within the
same city, and smaller values indicate weak or no evidence for a difference. The
absolute difference between the test statistics computed for two cities were then
used as the co-variate in the regression model as a measure of relative difference
in distribution of each metric across these two cities. The differences in t-statistics
computed between two cities ranged between 0.02 and 44.89.
Regression results revealed that a moderate share of variation in transferability
errors (R2 = 0.39 for best-off and R2 = 0.57 for worst-off deciles) is explained by
variablesincludedasshowninFigure4includingcityspecificintercepts.Theintra-
countrytransferindicatorscoefficientswerenegativeasitishardertotransferacross
countriesthanwithincountry.Itshowedthat,comparedtowithin-countrytransfer,
cross country would have 0.32 and 0.27 more error on average (p-values = 0.04 and
0.06, respectively) for allocation to the best-off and worst-off deciles. Coefficients
for differences in population density and distances to the center between rich and
poorcommunitieswerepositive:thebiggerthedifferencebetweensourceandtarget
cities, the harder it is to transfer. Observed distributions of population density and
distance to CBDs are related to how cities developed over time, physically and
administratively,includingdecentralizationpatternsandcar-orienteddevelopment.
3.4 Comparison with similarities of communities based on educational attainment
Correlationsbetweeneducationalattainmentandhouseholdincome(bothmeasured
at the census tract level) varied across cities ranging from r = 0.17 for Vancouver
to r = 0.81 for London and Atlanta (Figure S3). In Canada, many highly educated

Sueletal. Page9of13
immigrantscannotgethighpayingjobsastheircredentialsarenotrecognized(Picot
etal.,2008).SimilaryetlesspronounceddynamicsareinplayforbothSydneyand
Auckland. When we repeated the same set of analyses with street images using
educational attainment instead of income, we found even higher visual similarity
betweenareaswithhighesteducationalattainment.Lowesteducationalattainment
tracts were even more different from each other (Figure 2). For 80% of transfer
city pairs, MAE were lower when predicting the best-off 10% than predicting the
worst-off 10%. Differences between MAEs of best-off (mean = 1.90) and worst-off
(mean = 2.83) deciles (p<0.001) were larger.
Greater visual similarity between highest education neighborhoods is consistent
with evidence that amenity levels (which will have stronger visual signals) have
moreofaninfluenceonhigh-skillworkers’decisionsofwheretheylivecomparedto
low-incomeworkerswherethepriorityisonrentsandwages[37,38].Transferability
performances were particularly poor for predicting lowest education decile areas in
New York. Higher dissimilarity between lowest education neighborhoods is consis-
tentwithevidenceofhighersegregationofhigh-andlow-skillworkersintodifferent
cities.Certainlargercitiesbypopulation(e.g.,NewYork),forinstance,attractboth
higher-andlower-skilledworkersincreasinginequalitieswhereassmallercitieshave
thinner tails in skill distribution [39] potentially leading to distinct visual features
we observe in our work.
4 Discussion and limitations
Plato’s statement from more than 2300 years ago, that “any city, however small, is
in fact divided into two, one the city of the poor, the other of the rich,” still holds
truetodayasneighborhoodexperiencesofthewealthiestandpoorestresidentsdiffer
widelyevenwhentheyliveinthesame city[40, 41].Toprobethecharacteristics of
this feature in multiple cities, we asked: do the environments of the rich (and the
poor) look similar in different cities across the world? Using transferable models,
we showed that visual indicators of wealth across cities are more similar than those
of poverty.
In previous work, visual elements in street images, including window and roof
styles, number and types of cars, store signs, trees, fire escapes, and road widths,
were found to be correlated with socioeconomic variables in city or country specific
studies [20, 7, 21, 9]. Parallel to this, computer vision methods can also identify
distinct architectural elements for different cities (e.g. lampposts, doors, balconies,
windows with railings) [42]. Taken together, this body of work shows that poverty
and affluence in different cities have distinct as well as related features. We did
not extract pre-defined features so that we are not limited by the type of visual
features we can extract i.e., for which sufficient labeled datasets or pre-trained
models exist. Instead, we let the model learn visual features associated with wealth
or poverty in a city, and test whether it predicts the same social phenomenon
elsewhere. It enables the networks to make use of all features visible from images
that potentially impact people including but not limited to types and conditions of
buildings, vehicles, people, shops, pedestrian and cycling infrastructure, green and
blue space, aesthetics, and trash on streets. This approach is akin to how humans
intuitively identify where a poor or wealthy neighborhood may be, even in a city

Sueletal. Page10of13
that they have not been to before. The limitation with this approach, however, is
that post-hoc analysis is needed to identify which visual features, that are ideally
policy amenable, are driving the differences.
We find that, only some visual elements associated with poverty or wealth in
onecityonlygeneralizetoothers.Similaritiesaswellasdifferencesacrosscitiesare
drivenbyhistoricalfactors,policies,andlocalgeography.Car-orienteddevelopment
often results in lower density especially when geography allows for city expansion.
Poorsuburbanneighborhoodsoftenhavegreenspacevisiblefromimages.However,
in such cities, poor neighborhoods often lack access to sufficient levels of urban
amenities, affordable and sustainable transport options. On the other hand, cities
that have higher shares of public transit use are often higher in density. From what
is visible from street-level images, high-density poor neighborhoods lack trees or
greenspaceinproximity.Inaddition,residentsinsuchneighborhoodsmaybemore
exposed to hazards related to traffic such as higher levels of pollution, and road
collisions. They may also suffer from poorer municipal services including waste col-
lection. Further, residents of such neighborhoods may enjoy higher levels of access
to urban amenities, but the type and quality of amenities may be poor and inade-
quateforthepopulationdensity(i.e.,overcrowding).Whileweusedthefulldataset
containingalldecilesfromallcitiesduringtraining,weusedthebest-offandworst-
off deciles for our evaluations relating to the wealthiest and poorest areas in each
city in line with the focus of the paper. Similarities or differences in other deciles
and their transferability across cities and countries, which are arguably harder to
interpret, are not part of our analysis.
Cities are dynamic and their visuals change with poor and rich residents moving
inandoutofneighborhoods,cityinvestmentsandregulations.Historyofmigration
and gentrification also affect visual similarities, where new social groups settle into
existing neighborhoods changing their social fabric and environmental quality. For
example,landownershipchangesovertimewherethewealthymigrateaccordingto
changing opportunities (e.g., new developments near particularly attractive areas
newwaterfronts),sometimespushingoutthepoor[43].Featureslikecars,buildings,
shops,andaestheticsalsochangeovertime.Suchdynamicsarenotcapturedinour
cross-sectional analysis yet are visible from time-varying street images that are
increasingly available.
Methodologically,wefoundthattransferabilityerrorswerehigherforpovertycom-
paredtothatofwealth.Thisfindingraisestheneedforcautioninusingimageryfor
measurements of socioeconomic status for data-poor geographies [44]. Specifically,
greater error when predicting deprived areas can have serious implications. For ex-
ample, if used for resource allocation, there has to be effort in additional data to
understand the real nexus of where the poor are.
Inhigh-incomecountries,inequalitiesareincreasinglyconcentratedinurbanareas
[6,45].Whilecitygovernmentshavelimitedinfluenceonnationaleconomicpolicies,
they can influence and change cities’ built environment to benefit disadvantaged
residents. Examples of feasible actions include allocation of land for parks and
nature, public spaces, car free zones, higher quality homes, improving foodscapes,
civicspacesforallagegroups,improvingpublictransitnetworksandstopsincluding
public transit only lanes, better infrastructure for walking and cycling. The focus

Sueletal. Page11of13
on ‘building back better’ and post-pandemic cities offers the chance to remedy
our cities. Data-driven empirical findings enabled by our work and methods will
support generation of novel and strategically relevant hypotheses to help identify
urban policy and planning actions.
Availabilityofdataandmaterials
AlldatasetsusedinthispaperarepubliclyavailableandsourcesareprovidedinthemainmanuscriptandSIsection.
Uponpublication,thecodewillbeavailableat.
Competinginterests
Theauthorsdeclarethattheyhavenocompetinginterests.
Author’scontributions
E.S.andM.E.designedthestudyconceptwithinputfromM.B.andE.M..E.S.andE.M.obtaineddata.E.S.
conductedanalysisandpreparedresultswithinputfromE.M.,J.E.B,T.B.,J.L.,J.D.M.,A.M.,A.M.,R.N.,M.B.,
andM.E.E.S.andM.E.wrotethefirstdraftofthepaper.E.M.,J.E.B,T.B.,J.L.,J.D.M.,A.M.,A.M.,R.N.,M.B.,
Y.D.contributedtothefinalpaper.
Funding
ThisworkwassupportedbytheHealthDataResearchUKfundedbytheUKMedicalResearchCouncil(grant
MR/S003983/1),thePathwaystoEquitableHealthyCitiesgrantfromtheWellcomeTrust(209376/Z/17/Z).For
thepurposeofOpenAccess,theauthorhasappliedaCCBYpubliccopyrightlicensetoanyAuthorAccepted
Manuscriptversionarisingfromthissubmission.
Authordetails
1CentreforAdvancedSpatialAnalysis(CASA),UniversityCollegeLondon,London,UK. 2Departmentof
EpidemiologyandBiostatistics,ImperialCollegeLondon,London,UK. 3MRCCenterforEnvironmentandHealth,
ImperialCollegeLondon,London,UK. 4MelbourneSchoolofPopulationandGlobalHealth,Universityof
Melbourne,Melbourne,Australia. 5PublicHealthEngland,London,UK. 6SchoolofPublicHealth,Universityof
Adelaide,Adelaide,Australia. 7BristolMedicalSchoolPopulationHealthSciences,UniversityofBristol,Bristol,
UK. 8DepartmentofEpidemiologyandDataScience,AmsterdamUMC–VrijeUniversiteit,Amsterdam,The
Netherlands. 9SchoolofArts,MediaandEngineering,ArizonaStateUniversity,USA. 10DepartmentofPublic
Health,UniversityofOtago,Wellington,NewZealand. 11SchoolofPopulationandPublicHealth,TheUniversityof
BritishColumbia,Vancouver,BritishColumbia,Canada. 12SchoolofComputingandAugmentedIntelligence,
ArizonaStateUniversity,USA. 13InstituteforHealthMetricsandEvaluation,UniversityofWashington,Seattle
WA,USA. 14AbdulLatifJameelInstituteforDiseaseandEmergencyAnalytics,ImperialCollegeLondon,London,
UK. 15RegionalInstituteforPopulationStudies,UniversityofGhana,Accra,Ghana.
References
1. Atkinson,A.B.:Inequality.In:Inequality.HarvardUniversityPress,???(2015)
2. Piketty,T.:Capitalinthetwenty-firstcentury.In:CapitalintheTwenty-firstCentury.HarvardUniversityPress,
???(2014)
3. Stiglitz,J.E.:ThePriceofInequality:HowToday’sDividedSocietyEndangersOurFuture.WWNorton&
Company,???(2012)
4. Badger,E.:Theyearinequalitybecamelessvisible,andmorevisiblethanever.TheNewYorkTimes.Accessed
2022-03-12
5. Marmot,M.,Allen,J.:Covid-19:exposingandamplifyinginequalities.JEpidemiolCommunityHealth74(9),
681–682(2020)
6. Tonkiss,F.:Citygovernmentandurbaninequalities.City24(1-2),286–301(2020)
7. Gebru,T.,Krause,J.,Wang,Y.,Chen,D.,Deng,J.,Aiden,E.L.,Fei-Fei,L.:Usingdeeplearningandgoogle
streetviewtoestimatethedemographicmakeupofneighborhoodsacrosstheunitedstates.Proceedingsofthe
NationalAcademyofSciences114(50),13108–13113(2017)
8. Leahy,Y.I.;Serkez:Sincewhenhavetreesexistedonlyforrichamericans?TheNewYorkTimes.Accessed
2022-03-12
9. Naik,N.,Kominers,S.D.,Raskar,R.,Glaeser,E.L.,Hidalgo,C.A.:Computervisionuncoverspredictorsof
physicalurbanchange.ProceedingsoftheNationalAcademyofSciences114(29),7571–7576(2017)
10. Economist,T.:Richorrotten?kensingtonandchelsea:awealthybutdeeplydividedborough.TheEconomist
11. Salam,A.Erum;Uteuova:Howamerica’streelessstreetsarefuelinginequality.TheGuardian
12. Ro,C.:Willcovid-19makeurbancyclingmoreinclusive?TheBBC
13. Booth,C.:LifeandLabourofthePeopleinLondon.MacmillanandCompany,limited,???(1902)
14. Rundle,A.G.,Bader,M.D.,Richards,C.A.,Neckerman,K.M.,Teitler,J.O.:Usinggooglestreetviewtoaudit
neighborhoodenvironments.Americanjournalofpreventivemedicine40(1),94–100(2011)
15. Seiferling,I.,Naik,N.,Ratti,C.,Proulx,R.:Greenstreets-quantifyingandmappingurbantreeswith
street-levelimageryandcomputervision.LandscapeandUrbanPlanning165,93–101(2017)
16. Miller,J.:Thedronevideothatsumsupglobalinequality.TheGuardian
17. Rickard,D.:ANewAmericanPicture—NewPhotography2011.Accessed:2022-10-30(2011).
https://www.moma.org/interactives/exhibitions/2011/newphotography/doug-rickard/
18. Ronnlund,R.:DollarStreet.Accessed:2022-10-30(2018).https://www.gapminder.org/dollar-street
19. Anguelov,D.,Dulong,C.,Filip,D.,Frueh,C.,Lafon,S.,Lyon,R.,Ogale,A.,Vincent,L.,Weaver,J.:Google
streetview:Capturingtheworldatstreetlevel.Computer43(6),32–38(2010)

Sueletal. Page12of13
20. Arietta,S.M.,Efros,A.A.,Ramamoorthi,R.,Agrawala,M.:Cityforensics:Usingvisualelementstopredict
non-visualcityattributes.IEEEtransactionsonvisualizationandcomputergraphics20(12),2624–2633(2014)
21. Glaeser,E.L.,Kominers,S.D.,Luca,M.,Naik,N.:Bigdataandbigcities:Thepromisesandlimitationsof
improvedmeasuresofurbanlife.EconomicInquiry56(1),114–137(2018)
22. Suel,E.,Polak,J.W.,Bennett,J.E.,Ezzati,M.:Measuringsocial,environmentalandhealthinequalitiesusing
deeplearningandstreetimagery.Scientificreports9(1),1–10(2019)
23. Stand,D.W.,Rising,W.I.K.:Anoverviewofgrowingincomeinequalitiesinoecdcountries:mainfindings.
Dividedwestand:Whyinequalitykeepsrising(2011)
24. Roser,M.,Ortiz-Ospina,E.:Incomeinequality.OurWorldinData(2013)
25. Zhang,F.,Zhou,B.,Ratti,C.,Liu,Y.:Discoveringplace-informativescenesandobjectsusingsocialmedia
photos.RoyalSocietyopenscience6(3),181375(2019)
26. Belfield,C.,Chandler,D.,Joyce,R.:Housing:TrendsinPrices,CostsandTenure.InstituteforFiscalStudies,
???(2015)
27. Dubey,A.,Naik,N.,Parikh,D.,Raskar,R.,Hidalgo,C.A.:Deeplearningthecity:Quantifyingurban
perceptionataglobalscale.In:EuropeanConferenceonComputerVision,pp.196–212(2016).Springer
28. Law,S.,Paige,B.,Russell,C.:Takealookaround:usingstreetviewandsatelliteimagestoestimatehouse
prices.ACMTransactionsonIntelligentSystemsandTechnology(TIST)10(5),1–19(2019)
29. Naik,N.,Philipoom,J.,Raskar,R.,Hidalgo,C.:Streetscore-predictingtheperceivedsafetyofonemillion
streetscapes.In:ProceedingsoftheIEEEConferenceonComputerVisionandPatternRecognitionWorkshops,
pp.779–785(2014)
30. Salesses,P.,Schechtner,K.,Hidalgo,C.A.:Thecollaborativeimageofthecity:mappingtheinequalityof
urbanperception.PloSone8(7),68400(2013)
31. Zhou,B.,Liu,L.,Oliva,A.,Torralba,A.:Recognizingcityidentityviaattributeanalysisofgeo-taggedimages.
In:EuropeanConferenceonComputerVision,pp.519–534(2014).Springer
32. Simonyan,K.,Zisserman,A.:Verydeepconvolutionalnetworksforlarge-scaleimagerecognition.arXivpreprint
arXiv:1409.1556(2014)
33. Russakovsky,O.,Deng,J.,Su,H.,Krause,J.,Satheesh,S.,Ma,S.,Huang,Z.,Karpathy,A.,Khosla,A.,
Bernstein,M.,etal.:Imagenetlargescalevisualrecognitionchallenge.Internationaljournalofcomputervision
115(3),211–252(2015)
34. Champion,T.:Urbanization,suburbanization,counterurbanizationandreurbanization.Handbookofurban
studies160(1),143–161(2001)
35. Frey,W.H.:Centralcitywhiteflight:Racialandnonracialcauses.AmericanSociologicalReview,425–448
(1979)
36. Tolstoy,L.:AnnaKarenina.Lulu.com,???(2016)
37. Couture,V.,Gaubert,C.,Handbury,J.,Hurst,E.:Incomegrowthandthedistributionaleffectsofurbanspatial
sorting.Technicalreport,NationalBureauofEconomicResearch(2019)
38. Diamond,R.:Thedeterminantsandwelfareimplicationsofusworkers’diverginglocationchoicesbyskill:
1980-2000.AmericanEconomicReview106(3),479–524(2016)
39. Eeckhout,J.,Pinheiro,R.,Schmidheiny,K.:Spatialsorting.JournalofPoliticalEconomy122(3),554–620
(2014)
40. Bennett,J.E.,Li,G.,Foreman,K.,Best,N.,Kontis,V.,Pearson,C.,Hambly,P.,Ezzati,M.:Thefutureoflife
expectancyandlifeexpectancyinequalitiesinenglandandwales:Bayesianspatiotemporalforecasting.The
Lancet386(9989),163–170(2015)
41. Yu,J.,Dwyer-Lindgren,L.,Bennett,J.,Ezzati,M.,Gustafson,P.,Tran,M.,Brauer,M.:Aspatiotemporal
analysisofinequalitiesinlifeexpectancyand20causesofmortalityinsub-neighbourhoodsofmetrovancouver,
britishcolumbia,canada,1990–2016.Health&place72,102692(2021)
42. Doersch,C.,Singh,S.,Gupta,A.,Sivic,J.,Efros,A.:Whatmakesparislooklikeparis?ACMTransactionson
Graphics31(4)(2012)
43. Beauregard,R.A.:Capitalrestructuringandthenewbuiltenvironmentofglobalcities:Newyorkandlos
angeles1.InternationalJournalofUrbanandRegionalResearch15(1),90–105(1991)
44. Jean,N.,Burke,M.,Xie,M.,Davis,W.M.,Lobell,D.B.,Ermon,S.:Combiningsatelliteimageryandmachine
learningtopredictpoverty.Science353(6301),790–794(2016)
45. Glaeser,E.L.,Resseger,M.,Tobio,K.:UrbanInequality.Routledge,???(2015)
Figures
Figure1 Overviewofcitiesusedintheanalysis.Mapsofdecilesofincome,withredindicating
poorerareasandblueindicatingmorewell-offareas,alongwithexamplesofstreetimagesare
shownforselectedcities.WeusedimagesfromGoogleforouranalyses;imagesshownhereare
courtesyofMapillary.
AdditionalFiles
Additionalfile1—Supplementaryinformation

Sueletal. Page13of13
Figure2 Measurementperformancesforallcitypairs.Meanabsoluteerrors(MAE)achieved
whenpredictingworst-offandbest-offdecilesby(A)incomeand(B)educationalattainmentfor
allsource(training)andtarget(prediction)citypairs.Diagonalentriesshowresultsusingdata
fromasinglecityasdescribedinthetext.Randomallocationofcensustractstodecilesinthe
targetcitywouldresultinanMAEvaluecloseto5(darkred),whereasperfectpredictionwould
correspondtoaMAEvalueof0(darkblue).Shadesofbluedepictbetterpredictionperformances
comparedtoshadesofred.
Figure3 Exampleimages.Street-levelimageexamplesfrom(A)poorestand(B)wealthiest
communitiesineachcity.ImagescourtesyofMapillary.
Figure4 Multivariableregressionofpredictionerrors(MAE).BetweencityMAEswere
regressedagainstanindicatorforwhetherthepredictedandtrainingcitieswereinthesame
country,differencesinpopulationdensityanddistancestocitycenter.Separateregressionswere
carriedoutforthebest-offandworst-offdeciles.Coefficientsof‘differencesindistancestoCBD’
and‘differencesinpopulationdensity’showchangeinerrorforeachunitofdifferenceint-values.
(SeeMaterialsandMethodsforfurtherdetailsofvariablesincludedandhowthedifferencein
t-valueswerecomputed).
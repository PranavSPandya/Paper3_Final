Climate and urban form explain shade patterns in
U.S. cities

V. Kelly Turner

University of California Los Angeles, California, USA

Isaac Buo

Arizona State University

Ariane Middel

Arizona State University  https://orcid.org/0000-0002-1565-095X

Jean Claude Iradukunda

University of California Los Angeles

Article

Keywords: Heat, Cities, Trees, Local Climate Zones, Köppen climate classiﬁcations

Posted Date: August 3rd, 2026

DOI: https://doi.org/10.21203/rs.3.rs-10298361/v1

License:   This work is licensed under a Creative Commons Attribution 4.0 International License.
Read Full License

Additional Declarations: There is NO Competing Interest.

Page 1/18

Abstract

Cities lack systematically measured shade data to guide heat planning, even though shade is more

effective at reducing radiant heat load than greening and high-albedo surfaces, interventions for which
data is widespread. Here, we treat shade as a measurable environmental service shaped by land-
systems characteristics, analogous to how land systems science treats NDVI or albedo. Drawing from a
national-scale, 1m resolution shade analysis across 330 + U.S. cities, analyzed at the census block group

scale at 12:00 h, 15:00 h, and 18:00 h, we ﬁnd that climate sets the ﬂoor for shade by constraining
vegetative potential, and urban form sets the ceiling through building shade that dominates late-day
shade production. Shade disparities are greatest at noon, but equalize later in the day as building shade
increases. These predictable, generalizable patterns position shade for integration into land systems

models and heat planning frameworks alongside temperature-based metrics.

1. Introduction

Shade is essential infrastructure for keeping cities livable in a hotter future. Heat is already widely
recognized as a leading climate-related public health crisis because it threatens human survivability
under extreme conditions. Yet, heat also undermines livability under more common, moderately hot
conditions, when personal heat exposure renders routine daily activities unsafe (Vanos et al. 2023).
Personal heat exposure is fundamentally a process of energy transfer to the human body. Outdoors,
solar radiation (sunlight) is the primary modiﬁable source of heat gain, and often the largest additional

load under warm conditions (Jay et al. 2021). Shade interrupts that process, enabling people to remain
safely active outdoors for longer periods of time and at higher temperatures before reaching
“uncompensable” heat stress: the point at which the human body can no longer effectively cool itself
(Vanos et al. 2023). This ability to slow the rate of heating and delay critical thermophysiological
thresholds makes shade especially effective compared to other outdoor cooling interventions.

For decades, climate science has generated large-scale, high-resolution, accessible data on air and land
surface temperatures, supporting a body of research largely focused on urban-rural temperature
differences, referred to as the Urban Heat Island effect (Stewart et al. 2011). This data and framing make
it relatively easy for local governments to use UHI as a benchmark for cooling, despite known conceptual
limitations (Martilli et al. 2020). Surface and air temperature data sets quantify background
environmental conditions but do not capture radiant heat, the most salient temperature metric for

measuring solar exposure relevant to human heat gain (Middel and Krayenhoff 2019). Variables such as
Mean Radiant Temperature (MRT), which capture radiant heat, currently require sophisticated,
computationally intensive modeling methods that can limit their regular use in local policy and planning
(Schneider et al. 2024). As scholars work toward automating methods for modeling radiant heat
exposure (AlKhaled et al. 2024), governments lack a systematically measured and mapped dataset to
assess it or integrate targets into policy and plans.

Page 2/18

This gap in the ability to use shade or radiant heat to guide local heat planning has negative
consequences for heat-health management. In practice, cities have prioritized interventions that align
with air and surface temperature variables that are already integrated into decision-support systems.
These variables align with outdoor cooling strategies such as urban greening and high-albedo surfaces
that produce only modest beneﬁts to human health through ~ 1°C reductions in air temperature and
primarily act on surfaces (Wong et al. 2021). Shade, by contrast, directly reduces radiant heat load from

solar exposure and can lower MRT by tens of degrees (Middel and Krayenhoff 2019, Middel 2021). The
resulting reduction in physiological heat stress is far greater under shade cast by any green or
engineered physical element of the environment than through greening or high-albedo surface
treatments (Middel 2021). In the absence of reliable, scalable metrics to quantify shade, cities lack the
capacity to plan for its intentional delivery, leaving substantial potential to reduce heat exposure
unrealized.

While the cooling beneﬁts of shade are delivered directly to individuals where shadows are cast, “shade
infrastructure”--the combined set of green and gray physical features that block or ﬁlter direct sunlight
from reaching people and surfaces, and the institutions that support delivery on developed lands (Turner
et al. 2023)--describes broader patterns that shape when and where those beneﬁts are delivered. At local
scales, the amount of shade depends on the composition and arrangement of vertical elements such as

buildings and vegetation, as well as solar geometry at different times of day or seasons of the year
(Middel et al. 2014, Chen et al. 2025). At regional scales, heterogeneity in shade patterns across and
among urban regions with different urban morphology has been detected (Zhou et al. 2009,
Alexandrowicz 2022, Buo et al. 2023). Separately, at regional scales, it is also well established that
climatic regimes constrain vegetative potential and, by extension, the feasibility of vegetation-based
shade in water-limited environments (e.g., Roebroek et al. 2025, Nitschke et al. 2017). What is not fully
established is whether and how shade infrastructure varies systematically across regions in relation to
urban form patterns and climate systems. In the absence of systematic, cross-regional evidence, shade
infrastructure is diﬃcult to integrate into scientiﬁc and planning frameworks that rely on generalizable,

spatially comparable metrics, with the same rigor as urban greening or albedo.

Here, we position shade as an environmental service that can be measured at scale and generalized as a

land-system outcome shaped by the characteristics that govern its delivery. This framing supports a
conceptual advancement in which shade is treated as a comparable environmental service, with
properties that can be systematically characterized across land and climate contexts, on par with urban
greening or high-albedo materials. Drawing insight from site and regional-scale shade studies, we focus
on two key explanatory variables, urban form and climate, to explain urban shade infrastructure based on

their impacts on built features and vegetation. Speciﬁcally, we hypothesize that urban form determines

the distribution of shade infrastructure and timing of its delivery, while climate constrains the mix of
shade-casting features that can be sustained. We further hypothesize that total shade infrastructure is

structured by urban form within the constraints imposed by regional climate.

Page 3/18

To test these hypotheses, we draw from a high-resolution (1m), national-scale shade map encompassing

more than 330 U.S. cities. We conduct a comparative analysis of shade delivery attributes–total shade,
vegetation versus built shade, and shade at noon (minimum), 3 pm, and 6 pm (maximum)–at the census

block group scale. We relate these shade attributes to urban form and climate using Local Climate
Zones and Köppen climate classiﬁcations as indicators (Stewart and Oke 2012, Peel et al 2007). Data

are analyzed at the Census Block Groups (CBGs) scale to compare patterns in the amount, type (built
versus vegetative), and diurnal delivery of shade.

2. Results

2.1 Shade availability varies across and within cities over
the diurnal cycle

Shade availability varies widely across and within U.S. cities over the course of a day (Fig. 1). Within

cities, minimum CBG total shade at noon ranges from less than 1% to more than 50% across cities,
indicating substantial differences in baseline shade availability during peak solar exposure. By 18:00 h,

CBG shade could exceed 95%, indicating large differences in the maximum shading capacity. Cities also
differ in how shade changes over the diurnal cycle. Some have relatively stable shade availability, with

modest (less than 10%) differences between 12:00 and 18:00 h. While others experience large diurnal

increases, exceeding baseline shade by more than 2x at maximum capacity. Of the stable shade cities,
some remain consistently low-shade (less than 15%) throughout the day, whereas others maintain high

shade (above 70%) coverage.

Within all cities, median CBG total shade increases from approximately 25% at 12:00 h to 60% by late
afternoon. At 12:00 h, nearly all total shade is vegetative (98%), but by 18:00 h, building shade increases

substantially. Nearly all of this diurnal increase (99%) is attributable to building shade as solar angles
shift, producing longer building shadows later in the day. By contrast, vegetative shade remains

comparatively stable across time, with tree canopy providing a consistent shade footprint throughout the
day. From 12:00 to 18:00 h, increases in total shade are strongly associated with increases in building

shade (r = 0.93), indicating that urban form plays a dominant role in shaping late-day shade capacity.

Within cities, shade availability also varies substantially across CBGs. The range of unevenness is
highest at 12:00 h, where the median Gini index is 0.13, meaning that midday shade heterogeneity varies

a lot between cities. By 18:00 h, the median Gini index drops mean shade disparity drops (0.08), meaning

shade heterogeneity varies less between cities later in the day. The magnitude of shade disparity differs
by city. In cities with the largest disparity in shade availability, the difference between the most and least

shady CBGs can exceed 80% at all times of the day. Cities with the least disparity have a difference of
less than 20% in shade availability between the most and least shady CBGs only at 12:00 h.
2.2 Climate region sets the ﬂoor for shade, urban form sets
the ceiling

Page 4/18

Köppen climate classiﬁcations (Fig. 2) explain substantial variation in midday shade across CBGs,

primarily through differences in vegetative shade. Arid and semi-arid regions (BWh, BSh, BSk) have the
lowest median shade at 12:00 h, typically 15–20%, almost all of which is produced by vegetation

(median shade for BWh, BSh, and BSk is 16%,18%, and 21%, respectively). Vegetation shade increases
across temperate dry-summer (Csa, Csb), temperate no-dry-season (Cfa, Dfa), and cold-summer (Dsc,

Dsb) climates, with median values approaching 30% in several categories (median shade for Csa, Csb,
Cfa, and Dfa is 22%, 31%, 32%, and 31%, respectively). Tropical rainforest climates (Af) exhibit relatively

high vegetation shade but do not exceed the highest temperate or cold-summer classes in this dataset.
Building shade shows relatively little variation across climate regions and remains a small contributor at

midday (less than 1%). These patterns indicate that climate places an upper limit on the extent of

vegetative shade, effectively deﬁning minimum shade availability across U.S. cities.

Urban form (Fig. 3) determines the potential for additional shade beyond any climate baseline. Building

shade at midday is low across all Local Climate Zones (LCZs), but differences emerge later in the day

and could account for more than 90% of total shade in any given CBG. Most CBGs fall within open
lowrise LCZs, which account for more than 80% of the sample and produce among the lowest amounts

of building shade at 18:00 h (median building shade is less than 20%). Large lowrise areas exhibit
building shade levels similar to open lowrise areas across all times of day and tend to have lower

vegetative shade (median vegetation shade around 20%). Compact high-rise areas produce the most
building shade at 18:00 h (76%), but these areas are rare in the dataset (~ 1%) and show wide variability

in building shade (minimum building shade of 2%, maximum building shade of 99% ) and tend to have
the lowest vegetation shade (median vegetation shade less than 14%). Compact midrise, open highrise,

and compact lowrise areas provide moderate (roughly 70%) shade at 18:00 h. These patterns indicate

that building height and, in some instances, compactness, deﬁne potential additional building shade
beyond the baseline established by climate by virtue of vegetation.

Table 1 presents the results for the Type I two-way ANOVA test conducted on the dataset to evaluate the

inﬂuence of regional and urban climate types on shading coverages. The results indicate that both
variables (KPG and LCZ) inﬂuence shade coverage at both times with statistical signiﬁcance (P_value <

0.001). The regional climate variable, KPG has a dominant inﬂuence on the shade coverage at both times
compared to the local climate variable (LCZ), as suggested by the sums of squares and the F_values.

Furthermore, the interaction effect between the two variables (C(KPG):C(KPG)) at solar noon (F_value =
15.48) is more than twice as high as that observed during maximum shade conditions at 18:00 (F_value

= 6.72).

Page 5/18

Figure 4 shows how maximum shade coverage at 18:00 h varies across urban form and across climate

regimes. Across all climate zones, the ranking of LCZs is similar. Compact high-rise and dense trees
have the highest shade potential, followed by compact midrise and open high-rise, with the lowest shade

potential in open lowrise and large lowrise. This suggests that urban form structures shade potential,

regardless of climate, but climate raises or lowers the baseline conditions for shade.

The role of form, establishing the shade ceiling, and climate, strongly inﬂuencing the shade ﬂoor, is
reinforced in Fig. 4b, which shows how much shade is possible at 18:00 h during peak shade production
for each LCZ-Köppen pairing. The ordering of shade potential for LCZ and climate baselines remains

consistent to the trends in Fig. 4b. Figure 4a describes the shade ﬂoor across LCZ-Köppen pairings, and
while differences between LCZs are less pronounced at 12:00 h, form still generates differences in
shade. Of all LCZs, only dense trees remain consistently high shade producers midday, highlighting the
role of trees in producing consistent shade across the diurnal cycle. Compact high-rise, the other large

shade producer late in the day, provides far less shade across climate conditions midday.
3. Discussion and conclusion

Our analysis provides the ﬁrst national-scale, cross-regional evidence that shade infrastructure can be
systematically assessed and characterized as an environmental outcome patterned by land
characteristics. Urban climate science has established that shade patterns at individual sites result from

local permutations of urban form, vegetation, and sun angle (Middel et al. 2021). Computational
approaches have enabled scaling of shade mapping to regional and national extents (Zhou et al. 2009,

Page 6/18

Alexandrowicz 2022, Buo et al. 2023). Our study builds on these computational advances, revealing that
shade patterns are not merely idiosyncratic to speciﬁc sites. Instead, climate and urban form interact to
create predictable patterns in the magnitude, composition, and timing of shade production across
census blocks in 330 U.S. cities.

Speciﬁcally, we found that climate establishes the ﬂoor for vegetative shade that can be sustained in a
region, and urban form sets the ceiling for how much additional shade can be produced from engineered
structures, while solar geometry determines when shade from different climate-form combinations is

cast. As we expected, climate is a key factor in differentiating vegetation availability (e.g., Roebroek et al.
2025, Nitschke et al. 2017). We found that cities in arid climates begin with structurally lower vegetative
shade baselines. Also, as expected, we found that engineered features in the environment contributed
distinctly to shade availability over the course of the day (Middel et al. 2014, Chen et al. 2025). Compact

and higher-rise areas provided substantial late-afternoon shade, although midday shading was limited.
This ﬁnding builds on the observation that urban cores tend to produce more shade from buildings, while
suburbs derive more shade from trees (Saud and Richter 2026). Urban core sites likely produce more

shade from buildings due to larger concentrations of compact and high-rise LCZs. The decline in shade
disparity later in the day suggests that building shade can equalize access spatially, but only at speciﬁc
times. This ﬁnding underscores the importance of accounting for both timing and the mechanism of
delivery in assessments. These, along with the overall ﬁnding that shade exhibits regular and predictable

patterns, set the stage to generalize about its causes, consequences, and connect to environmental
theory broadly.

In this study, we connected shade to land systems science, a research tradition that treats land

composition and conﬁguration as drivers of environmental services, often using data derived from
remote sensing at large spatial extents (Dong et al. 2019). This tradition has relied heavily on surface-
based observations of state variables such as NDVI and albedo, which characterize horizontal land

cover. These variables are linked to thermal states such as LST and air temperature, and the associated
Urban Heat Island index (Turner et al. 2022; Li et al., 2023). This omission is consequential because
blocking incoming shortwave radiation is among the most metabolically signiﬁcant determinants of
human heat exposure (Middel et al. 2016, Vanos et al. 2023). By conceptualizing shade as a land-

systems outcome, we introduce a pathway for integrating vertical structure, shade, and thermal state
variables (e.g., MRT) with salience to human health in land systems science frameworks. This path holds
promise for bridging the existing gap between surface-based assessments of temperature used in land

systems science and site-level understanding of heat exposure in urban climate and public health
research.

Incorporating shade into land systems models also improves the ability of planning, policy, and public

health practitioners to target radiant heat exposure directly. Most municipalities consume whatever heat-
related data products, largely air temperature and surface temperature products, are available to them to
direct resources to heat-related concerns (Meerow and Keith 2022). Studies ﬁnd that planning and
resource direction mirror this emphasis: managing acute heat events or mitigation of the Urban Heat

Page 7/18

Island are repeatedly cited as priorities (Keith et al. 2019, Turner et al. 2022). While not all cities have
access to shade data, those that do have integrated shade targets into heat-planning (City of Phoenix
2024, Los Angeles County 2026). Making more data available is not suﬃcient to guarantee its use
(Findlater et al. 2021); however, in the case of shade, a whole class of data is missing from practitioners’

heat-related decision-set. This study draws from data developed for the American Forests Tree Equity
Score, a widely used and free, online user-oriented decision support tool (American Forests 2026).
Making shade data more widely available and usable to cities through standard geospatial products is,
therefore, a critical step in expanding access.

Our study has some key limitations for fully integrating shade data into land systems models and local
practitioner decisions. Foremost, our data is aggregated at the census block scale, while shade varies at
hyper-local scales, as do its beneﬁts, including reducing radiant heat exposure. Future research should

examine if and how higher resolution data sets augment the dynamics related to urban form and climate
examined in this study. Additionally, modeled shade is not a direct analog to experienced heat burden.
Shade coverage reﬂects the interruption of direct solar radiation, a key but partial determinant of heat

burden that operates alongside air temperature, humidity, and individual physiology. Linking shade
patterns to relevant metrics such as MRT or physiological outcomes will strengthen understanding of the
public health beneﬁts derived from them and forge stronger links to particular heat exposure settings
(e.g., home, labor, school) and their governance (Ahmed et al., 2026). Of particular importance to cities

may be deriving place-speciﬁc shade targets based on realistic ﬂoor-to-ceiling parameters, as well as
reductions in metabolic work based on how space is used. The relationship between shade distribution
and social vulnerability also warrants dedicated analysis; the diurnal role of building shade in densely

populated, less-vegetated urban areas complicates straightforward interpretation and merits its own
investigation (Gu et al., 2026). While this research establishes regional climate as a more dominant
driver of shade abundance than the local urban climate, it does not consider key underlying factors. We
do not examine how regional underlying variables such as precipitation and growing season lengths, or

local variables such as building heights and impervious surface fractions inﬂuence shade availability.
Future research should investigate these underlying mechanisms within regional and local climate zones
to better understand how they drive shade abundance.

Finally, our study examines patterns based on a diurnal cross-section of one summer day from different
years because of data constraints.This research was limited to using the best available open LiDAR
dataset available for each city. A true panel data set of patterns over time would enable causal analysis

of key drivers of change, including planning and policy interventions in urban form and forestry, as well
as climate change impacts.

4. Materials and Methods

4.1 Surface modeling

Page 8/18

Accurate representation of the physical urban space is critical to mapping shade distribution. We utilized
highly detailed LiDAR point cloud data from the United States Geological Survey (USGS) 3D Elevation
Program. The data is hosted on an Amazon Web Services server in Entwine Point tiles format. We
developed a Python-based workﬂow to send getRequests to the server and fetch points intersecting

each city's limits, which we obtained from America Forests. The workﬂow generates three (3) surface
models on-the-ﬂy after ﬁltering points classiﬁed as noise and writes them to a ﬁle. These surface models
are a full digital surface model (FDSM), which captures the height of all features above the earth's
surface and the ground. The other two surface models are a Digital Elevation Model-DEM (ground points

only) and a Full canopy height model- FCHM (the above-ground height of all features). We develop the
ﬁnal input surface models for SOLWEIG in a quality control process that follows this step.

We provide a table summarizing the acquisition dates for the point cloud as a supplementary material to

this work.

SOLWEIG requires 2 surface models: a surface model of buildings and ground alone (BSM), and a

vegetation canopy model (CDSM) to estimate the shadows from trees and buildings at a given time. We
followed the approach of (Buo et al., 2023) to generate BSM by masking the FDSM with building
footprints from the Microsoft building database and ﬁlling areas outside the buildings with their
respective pixel values in the DEM. We performed a reverse masking operation on the FCHM using the

building footprints to get vegetation canopies only and set areas covered by buildings to zero (0). In
addition, we set the pixel values less than 1.3 m in the CDSM to zero because we do not consider them
high enough to provide shading for the average person when standing.
4.2 Shade modeling

We determined the shade provided by buildings and trees using the shadowing function in SOLWEIG,
applying a transmissivity value of 3% (Eq. 1). We generated the shadows for the summer solstice of
2023 (21/06/2023) at three key timestamps (12:00, 15:00, and 18:00 h) of the day to get a general

progression of shading during the day. All simulations reﬂect conditions at local times for all cities while
accounting for their time zones. The summer solstice and these speciﬁc times guarantee that the sun
will be above the horizon in all cities while ensuring conditions at solar noon are captured.

Each city had 9 sets of rasters, vegetation, buildings, and total shade for the different timestamps.
Simulating shadows with SOLWEIG is an iterative process in which a surface model continuously shifts,
reducing its height at each step according to the solar altitude to determine the shadow volume
(Lindberg & Grimmond, 2011). SOLWEIG resolves the total shade for a pixel by accounting for building

and vegetation shade in the equation below (Lindberg & Grimmond, 2011).

Shi = Shbuilding − (1 − Shcanopy) ∗ (1 − τ)

(1)

Page 9/18

Shi

Shbuilding

 indicate,

 indicates transmissivity.

where
τ
4.3 Shade scoring and disparity

 indicates shade from building,

Shcanopy

indicates shade from trees, and

We aimed to calculate a single score for each shade type and the CBG scale for each city. We
determined the total outdoor space for each block group by performing an overlay operation using the
building footprints and the boundaries of the CBGs. We proceeded to calculate the fraction of the total
outdoor space covered by shade from buildings and vegetation at the selected times of the day. We also

determined the percentage of total shade. Each census block group had a shade coverage score for
total, building, and vegetation shade at 12:00, 15:00, and 18:00 h. We further determined the evenness of
shading quality across the block groups in each city by calculating a Gini index for each city at these

times.
4.4 Evaluating urban form, climate zone, and shade
distribution

We investigated the effect of climate and urban form on the distribution of shade cities. We employed
the Köppen-Geiger (KPG) climate classiﬁcation system to evaluate the effects of climate on the shading
quality. The KPG system groups regions into 5 main groups with 30 subgroups based on temperature
and seasonal precipitation patterns (Beck et al., 2018; Köppen, 1936). We used the Local Climate Zone

(LCZ) classiﬁcation proposed by Stewart & Oke (2012), which categorizes urban areas according to the
geometric conﬁguration of features and land cover types. The LCZ scheme has six (6) and ten (10)
classes governed by landcover properties and geometric conﬁgurations, respectively (Oke et al., 2017;
Stewart & Oke, 2012). We used the version produced for the United States by (Bechtel et al., 2019). We

analyzed the distribution of shade types across climate categories. We further investigated how both
classiﬁcations affect the shading quality of a city and their signiﬁcance using a Type I two-way ANOVA
analysis. In the ANOVA analysis, we set KPG as the main effect variable to account for underlying

environmental variables, latitudinal variations in solar angles, and vegetation types.

Declarations

Funding

This work was supported by the Robert Wood Johnson Foundation (grant no. 20235061 to V.K.T.)

Author Contributions

All authors conceived and designed the study. V.K.T led study design, analysis, and drafting. I.B.
generated the data set, performed the analysis, and contributed to drafting. A.M. contributed to study

design, analysis, and drafting. J.C.I contributed to analysis and drafting. All authors reviewed and edited
the manuscript and approved the ﬁnal version.

Page 10/18

Data Availability

The derived shade datasets generated in this study are available from the corresponding author (V.K.T.)
upon reasonable request.

References

1. J. Vanos et al., A physiological approach for assessing human survivability and liveability to heat in a

changing climate. Nature communications 14, 7653 (2023).

2. O. Jay et al., Reducing the health effects of hot weather and heat extremes: from personal cooling

strategies to green cities. The Lancet 398, 709–724 (2021).

3. J. Vanos et al., A physiological approach for assessing human survivability and liveability to heat in a

changing climate. Nature Communications 14 (2023).

4. I. D. Stewart, T. R. Oke, Local Climate Zones for Urban Temperature Studies. Bulletin of the American

Meteorological Society 93, 1879–1900 (2012).

5. A. Martilli, E. S. Krayenhoff, N. Nazarian, Is the Urban Heat Island intensity relevant for heat

mitigation studies? Urban Clim 31, 100541 (2020).

6. A. Middel, E. S. Krayenhoff, Micrometeorological determinants of pedestrian thermal exposure

during record-breaking heat in Tempe, Arizona: Introducing the MaRTy observational platform. Sci

Total Environ 687, 137–151 (2019).

7. F. A. Schneider, E. Epel, A. Middel, A disconnect in science and practitioner perspectives on heat

mitigation. npj Urban Sustainability 4 (2024).

8. S. R. AlKhaled, A. Middel, P. Shaeri, I. Buo, F. A. Schneider, WebMRT: An online tool to predict

summertime mean radiant temperature using machine learning. Sustain Cities Soc 115, 105861
(2024).

9. N. H. Wong, C. L. Tan, D. D. Kolokotsa, H. Takebayashi, Greenery as a mitigation and adaptation

strategy to urban heat. Nature Reviews Earth & Environment 2, 166–181 (2021).

10. A. Middel, S. Alkhaled, F. A. Schneider, B. Hagen, P. Coseo, 50 Grades of Shade. Bulletin of the

American Meteorological Society 102, E1805–E1820 (2021).

11. V. K. Turner, A. Middel, J. K. Vanos, Shade is an essential solution for hotter cities. Nature 619, 694–

697 (2023).

12. A. Middel, K. Häb, A. J. Brazel, C. A. Martin, S. Guhathakurta, Impact of urban form and design on

mid-afternoon microclimate in Phoenix Local Climate Zones. Landscape Urban Plan 122, 16–28

(2014).

13. B. Chen et al., Advancing urban shade mapping for planning: Integrating shade demand and

greening potential. Urban for Urban Gree 111, 128888 (2025).

14. W. Zhou, G. Huang, A. Troy, M. L. Cadenasso, Object-based land cover classiﬁcation of shaded areas
in high spatial resolution imagery of urban areas: A comparison study. Remote Sens Environ 113,

Page 11/18

1769–1777 (2009).

15. O. Aleksandrowicz, "Chapter 1 - Mapping and management of urban shade assets: a novel approach
for promoting climatic urban action" in Global Urban Heat Island Mitigation, A. Khan, H. Akbari, F.
Fiorito, S. Mithun, D. Niyogi, Eds. (Elsevier, 2022), https://doi.org/10.1016/B978-0-323-85539-

6.00003-2, pp. 1–27.

16. I. Buo, V. Sagris, J. Jaagus, A. Middel, High-resolution thermal exposure and shade maps for cool

corridor planning. Sustain Cities Soc 93, 104499 (2023).

17. C. T. J. Roebroek et al., Potential tree cover under current and future climate scenarios. Sci Data 12

(2025).

18. C. R. Nitschke et al., The inﬂuence of climate and drought on urban tree growth in southeast

Australia and the implications for future growth under climate change. Landscape Urban Plan 167,
275–287 (2017).

19. M. C. Peel, B. L. Finlayson, T. A. Mcmahon, Updated world map of the Köppen-Geiger climate

classiﬁcation. Hydrology and Earth System Sciences 11, 1633–1644 (2007).

20. R. Saud, S. M. Richter, LiDAR-based shade mapping: Decomposition and multi-resolution analysis in

a 3D digital twin. Remote Sensing Applications: Society and Environment 41, 101918 (2026).

21. J. Dong, G. Metternicht, P. Hostert, R. Fensholt, R. R. Chowdhury, Remote sensing and geospatial

technologies in support of a normative land system science: status and prospects. Current Opinion
in Environmental Sustainability 38, 44–52 (2019).

22. V. Kelly Turner et al., More than surface temperature: mitigating thermal exposure in hyper-local land

system. Journal of Land Use Science 17, 79–99 (2022).

23. L. Li et al., Divergent urbanization-induced impacts on global surface urban heat island trends since

1980s. Remote Sens Environ 295, 113650 (2023).

24. A. Middel, N. Selover, B. Hagen, N. Chhetri, Impact of shade on outdoor thermal comfort—a seasonal

ﬁeld study in Tempe, Arizona. International Journal of Biometeorology 60, 1849–1861 (2016).

25. S. Meerow, L. Keith, Planning for Extreme Heat. Journal of the American Planning Association 88,

319–334 (2022).

26. L. Keith, S. Meerow, T. Wagner, Planning for Extreme Heat: A Review. Journal of Extreme Events 06,

2050003 (2019).

27. C. o. Phoenix (2024) Shade Phoenix: An action plan for Trees and Build shade. (City of Phoenix).

28. L. A. County (2026) Los Angeles County Heat Action Plan. (Los Angeles County Chief Sustainability

Oﬃce).

29. K. Findlater, S. Webber, M. Kandlikar, S. Donner, Climate services promise better decisions but

mainly focus on better data. Nature Climate Change 11, 731–737 (2021).

30. A. Forest (2025) Tree Equity Score.

31. F. Lindberg, C. S. B. Grimmond, The inﬂuence of vegetation and building morphology on shadow
patterns and mean radiant temperatures in urban areas: model development and evaluation.

Page 12/18

Theoretical and applied climatology 105, 311–323 (2011).

32. H. E. Beck et al., Present and future Köppen-Geiger climate classiﬁcation maps at 1-km resolution.

Sci Data 5, 180214 (2018).

33. W. Koppen, Das geographische system de klimate. Handbuch der klimatologie (1936).

34. T. R. Oke, G. Mills, A. Christen, J. A. Voogt, Urban climates (Cambridge university press, 2017).

35. B. Bechtel et al., SUHI analysis using Local Climate Zones—A comparison of 50 cities. Urban Clim 28,

100451 (2019).

Figures

Page 13/18

Figure 1

Summary of shade characteristics across CBGs in 330 U.S. Cities at 12:00, 15:00, and 18:00 h, including
(a) total shade, (b) building shade, (c) vegetation shade, and (d) Gini index as a measure of disparity in
total shade between CBGs within cities.

Page 14/18

Figure 2

Percent building and vegetation shade by Köppen climate classiﬁcation (KPG) at 12:00 h.

Page 15/18

Figure 3

Percent total, building, and vegetation shade by Local Climate Zone (LCZ) at 18:00 h.

Page 16/18

Figure 4

Interaction between Local Climate Zones (LCZ) and Köppen climate classiﬁcation (KPG) at 12:00 h
(minimum shade coverage) and 18:00 h (maximum shade coverage).

Supplementary Files

Page 17/18

This is a list of supplementary ﬁles associated with this preprint. Click to download.

Turneretal.NatureCitiesSubmissionappendices.docx

Page 18/18


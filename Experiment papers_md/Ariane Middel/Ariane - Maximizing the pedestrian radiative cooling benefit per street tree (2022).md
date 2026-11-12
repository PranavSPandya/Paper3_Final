LandscapeandUrbanPlanning230(2023)104608
Contents lists available at ScienceDirect
Landscape and Urban Planning
journal homepage: www.elsevier.com/locate/landurbplan
Research Paper
Maximizing the pedestrian radiative cooling benefit per street tree
Jacob A. Lachapellea, E. Scott Krayenhoffa,*, Ariane Middelb,c, Paul Coseod, Jon Warlanda
aSchool of Environmental Sciences, University of Guelph, Guelph, Ontario, Canada
bSchool of Arts, Media and Engineering, Arizona State University, Tempe, AZ, USA
cSchool of Computing and Augmented Intelligence, Arizona State University, Tempe, AZ, USA
dThe Design School, Arizona State University, Tempe, AZ, USA
H I G H L I G H T S
•Efficiency of street tree radiative cooling depends on tree placement.
•TUF-Pedestrian model quantifies impact of sidewalk tree spacing on pedestrian TMRT.
•Spatial variation of directional longwave radiation loading on pedestrians captured.
•More sidewalk tree cover increases TMRT reduction with modestly diminishing returns.
•Equally-spaced trees among warm season sun-exposed pedestrian routes optimize cooling.
A R T I C L E I N F O A B S T R A C T
Keywords: Outdoor heat stress is a growing problem in cities during hot weather. City planners and designers require more
Pedestrian thermal comfort pedestrian-centered approaches to understand sidewalk microclimates. Radiation loading, as quantified by mean
Urban forestry radiant temperature (TMRT), is a key factor driving poor thermal comfort. Street trees provide shade and
Microclimate modelling
Radiative heat exposure
consequently reduce pedestrian TMRT. However, placement of trees to optimize the cooling they provide is not
yet well understood. We apply the newly-developed TUF-Pedestrian model to quantify the impacts of sidewalk
Green infrastructure design
Sidewalk shade
tree coverage on pedestrian TMRT during summer for a lowrise neighbourhood in a midlatitude city. TUF-
Pedestrian captures the detailed spatio-temporal variation of direct shading and directional longwave radia-
tion loading on pedestrians resulting from tree shade. We conduct 190 multi-day simulations to assess a full
range of sidewalk street tree coverages for five high heat exposure locations across four street orientations. We
identify street directions that exhibit the largest TMRT reductions during the hottest periods of the day as a result
of tree planting. Importantly, planting a shade tree on a street where none currently exist provides approximately
1.5–2 times as much radiative cooling to pedestrians as planting the same tree on a street where most of the
sidewalk already benefits from tree shade. Thus, a relatively equal distribution of trees among sun-exposed
pedestrian routes and sidewalks within a block or neighbourhood avoids mutual shading and therefore opti-
mizes outdoor radiative heat reduction per tree during warm conditions. Ultimately, street tree planting should
be a place-based decision and account for additional environmental and socio-political factors.
1. Introduction encouraging people to walk more to reduce greenhouse gas emissions
and reach other sustainability and health objectives. For example,
Pedestrians in many cities experience excessive daytime heat in the thermally uncomfortable outdoor urban spaces may contribute to
summertime or warm season (Oke et al., 1991; Oke et al., 2017). More making cities obesogenic. In addition, pedestrian spaces, such as side-
worrisome, episodes of excessive heat are expected to increase with walks, are critical infrastructure that support a public commons of
more frequent and intense heat waves due to climate change (Dosio, informal social contact, helping maintain societal understandings of
Mentaschi, Fischer, & Wyser, 2018). At the same time, many cities are diverse social structures – knowing about others and their challenges
* Corresponding author at: 50 Stone Road East, Guelph, Ontario N1G 2W1, Canada.
E-mail addresses: jlachape@uoguelph.ca (J.A. Lachapelle), skrayenh@uoguelph.ca (E. Scott Krayenhoff), ariane.middel@asu.edu (A. Middel), paul.coseo@asu.
edu (P. Coseo), jwarland@uoguelph.ca (J. Warland).
https://doi.org/10.1016/j.landurbplan.2022.104608
Received 15 June 2022; Received in revised form 5 October 2022; Accepted 7 October 2022
Availableonline21October2022
0169-2046/©2022TheAuthor(s).PublishedbyElsevierB.V.ThisisanopenaccessarticleundertheCCBYlicense(http://creativecommons.org/licenses/by/4.0/).

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
(Duneier, 2001; Gehl, 1987; Jacobs, 1961). Walkability goals aim to Ban-Weiss, 2016). Tree shade alone provides a strong cooling benefit,
make neighbourhoods more walkable and social through compact and TMRT may be reduced by as much as 20–40 ◦C (Ali-Toudert &
development with traversable, enjoyable, and safe pedestrian infra- Mayer, 2007; Gulya´s, Unger, & Matzarakis, 2006; K´antor, Chen, & G´al,
structure (e.g. sidewalks, street trees, benches) (Forsyth, 2015). Even 2018; Middel & Krayenhoff, 2019; Middel, Alkhaled, Schneider,
lower density communities are investing in transitions to more walkable Hagen, & Coseo, 2021).
pedestrian infrastructure (McGreevy, Musolino, Udell, & Baum, 2021). While trees typically produce daytime cooling effects in city streets,
Yet, an increasing societal push toward walking combined with specific configurations of street trees may help optimize reductions of
increasing heat may make pedestrians more prone to heat stress without excessive heat, for example, by focusing on street locations most in need
sufficient optimization of sidewalk microclimate design (Dzyuban et al., of tree shade (Ali-Toudert & Mayer, 2006; Coutts, White, Tapper,
2022). To improve pedestrian thermal comfort, city officials, planners, Beringer, & Livesley, 2016; Johansson, 2006; Thorsson et al., 2011).
and designers require guidance on management of pedestrian over- Several recent studies help clarify optimal tree shapes and placements to
heating that accounts for three-dimensional street design (including best reduce urban heat and TMRT as a function of urban geometry
shading effects), building wall and pavement materials, and vegetation (Gillner, Vogt, Tharang, Dettmann, & Roloff, 2015; Millward, Torchia,
type and placement. Laursen, & Rothman, 2014; Morakinyo, Ouyang, Lau, Ren, & Ng, 2020;
A key contributor to overheating of pedestrians in cities is the large Park et al., 2019; Smithers et al., 2018; Zheng, Bedra, Zheng, & Wang,
coverage of impermeable surfaces, which, unlike permeable surfaces, 2018). Although these studies use different metrics, including surface
can divert little of their high warm season radiant loads to latent heat, temperature, air temperature, and thermal comfort indices, they
and instead warm the air, the subsurface, and radiate strongly (Oke, generally conclude that clusters of trees with high leaf area indexes
Johnson, Steyn, & Watson, 1991). Even more impactfully, high solar (LAIs, or tree canopy density) and high transpiration rates should be
(shortwave) radiation loading and consequently elevated temperatures planted in broad streets with short buildings to help keep pedestrians
during these times of year mean that pedestrians in cities often experi- cool during hot conditions.
ence a high mean radiant temperature (TMRT). TMRT is a summary metric Zheng et al. (2018), Park et al. (2019) and Morakinyo et al. (2020)
that encompasses all shortwave and longwave radiation absorbed by a focused on tree configurations in different street geometries and pro-
pedestrian (Ashrae, 2001). It is becoming increasingly important to vided useful guidance regarding optimal tree species choice and
reduce excessive TMRT in urban areas, particularly because global configuration for reducing thermal exposure. Zheng et al. (2018)
climate change and urban development are likely to increase summer air assessed the use of trees to mitigate heat on the north side of an East-
temperature beyond the cooling capabilities of existing heat reduction West canyon at different building height-to-street width (H/W) ratios
strategies even when applied with high intensity and in tandem and found that denser trees with little space in between them are pref-
(Krayenhoff, Moustaoui, Broadbent, Gupta, & Georgescu, 2018). erable for cooling pedestrians, especially at low canyon H/W ratios. Park
Moreover, TMRT is usually the best predictor of the spatial variation of et al. (2019) also assessed trees in an East-West canyon, focusing on tree
heat exposure and potential heat stress in urban environments during size and spacing. However, they used a two-dimensional model and
summertime fair weather (Lee, Mayer, & Schindler, 2014; Middel & therefore did not explicitly represent tree spacing and associated in-
Krayenhoff, 2019), particularly in hot dry climates. Therefore, reduction teractions in the along-canyon dimension. Regardless, Park et al. (2019)
of TMRT is typically an effective approach for reducing outdoor heat found that pedestrian TMRT was optimally reduced with either larger
exposure at the microscale. trees, or many small trees with little space between them. They also
Reducing excessive heat in cities can be addressed through urban found that the magnitude of TMRT reduction dropped exponentially for
design strategies that target either the microscale radiation environment small trees, but linearly for large trees, as tree spacing increased. Mor-
(Lai, Liu, Gan, Liu, & Chen, 2019; Oke, 1989), or neighbourhood-scale akinyo et al. (2020), tested the cooling effect of different tree types
air temperature (Krayenhoff et al., 2021). Since the ability to offset (different trunk and tree heights, foliage density, and canopy width) in
climate change-induced increases of air temperature is limited streets of varying H/W ratios. They found that, although trees in the
(Krayenhoff et. al. 2018), microscale radiative cooling approaches are of hottest street canyons (low H/W) should be denser and shorter and
increasing importance (Middel & Krayenhoff, 2019). At the microscale, wider, the trees planted in narrow and tall canyons should be sparser
these design strategies often focus on increasing the amount of shade to and taller.
reduce the radiant load at the street level (Ali-Toudert and Mayer, 2006; It is important to determine the best use of tree planting resources
Ali-Toudert and Mayer, 2007; Johansson, 2006; Ka´ntor et al., 2016; for heat amelioration, since most municipalities have limited space
Ka´ntor et al., 2018; Lindberg & Grimmond, 2011; Shashua-Bar, Pearl- and funds for tree planting and maintenance. However, only a few
mutter, & Erell, 2011; Thorsson, Lindberg, Bjo¨rklund, Holmer, & Ray- studies have attempted to address this issue (Morakinyo et al., 2020;
ner, 2011). This strategy has the benefit of reducing TMRT not only by Park et al., 2019; Zheng et al., 2018). In addition, apart from the Park
decreasing the shortwave radiation absorbed by pedestrians, but also by et al. (2019) study with a two-dimensional model, no studies to our
keeping street-level surfaces cooler, so they emit less longwave knowledge have assessed whether pedestrian TMRT reductions (or
radiation. cooling more generally) per planted tree changes as a function of
One such urban design strategy that has received much attention in existing tree cover. For example, additional tree planting may radia-
the past few decades is street tree planting (Turner et al., 2022). Trees tively cool pedestrians more effectively due to a synergistic effect,
impact thermal exposure not only by directly shading pedestrians, but similar to that observed for air temperature cooling by urban trees
also by 1) shading street-level and building surfaces, keeping them (Ziter, Pedersen, Kucharik, & Turner, 2019), or it may offer consistent
cooler and resulting in less longwave radiation emitted towards pe- (Middel, Chhetri, & Quay, 2015) or diminishing benefits as tree cover
destrians; 2) emitting more longwave radiation toward pedestrians increases. The dearth of tools suited to addressing questions related to
than the cooler sky above; 3) slowing down the wind and altering optimal tree placement probably underlies the lack of study of this
turbulent heat and moisture transfer; and 4) transpiring, thereby topic.
reducing sensible heat flux, cooling the air, and increasing latent heat We use a new model of pedestrian thermal exposure, TUF-Pedestrian
flux and humidifying the air (Krayenhoff et al., 2020; Picot, 2004; (Lachapelle et al., 2022), to investigate the effect of sidewalk street tree
Shashua-Bar et al., 2011). Although the impacts of trees on longwave coverage on pedestrian TMRT. TUF-Pedestrian is a microscale model that
radiation and wind will tend to increase heat exposure, the reduction of captures the radiative impacts of trees and explicitly calculates short-
heat exposure caused by shading and transpiration typically dominate wave and longwave radiation incident on each urban surface (e.g.,
during daytime, resulting in a strong cooling effect from trees (Ka´ntor, streets and building walls, separated into sub-facet scale “patches”) and
Kova´cs, & Taka´cs, 2016; Smithers et al., 2018; Taleghani, Sailor, & on a pedestrian, including multiple reflections of both longwave and
2

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
shortwave as well as longwave emission. The energy balance of each 2. Methodology
sub-facet scale patch is solved for a unique surface temperature at each
time step. As a result, the urban surface temperature distribution is To investigate these objectives, we apply the TUF-Pedestrian model
represented at high spatial resolution, providing a detailed representa- to a suite of scenarios. TUF-Pedestrian has been shown to accurately
tion of the longwave radiative environment experienced by a pedestrian reproduce the impacts of buildings and street trees on pedestrian TMRT
over the diurnal period as a function of the presence of trees. The rela- (Lachapelle et al., 2022) compared to a unique high resolution dataset
tively high spatial resolution of TUF-Pedestrian allows for an in-depth acquired with the MaRTy human-biometeorological platform (Middel &
analysis of different tree placements and their impacts on pedestrians Krayenhoff, 2019). Importantly, this model evaluation demonstrated
for a selection of urban geometries. Moreover, TUF-Pedestrian uses a that TUF-Pedestrian is additionally able to capture the directional
vertically explicit pedestrian consistent with the six directional shortwave and longwave fluxes that compose TMRT across the diurnal
approach to measuring TMRT, permitting insight into the breakdown of cycle with good accuracy.
TMRT into its directional radiative components. This attribution of the Here, the ‘base case’ simulation is representative of an Open Lowrise
TMRT signal aids identification of those surfaces that most need to be residential area (Stewart & Oke, 2012) with a relatively tall pedestrian
cooled. located at one side of the street (Fig. 1f; Supplementary Table 1). All
Our overall objective is to understand the relative effectiveness of patches in the model domain (which compose the building roofs and
different coverages of street trees for the reduction of daytime pedes- walls, and street surfaces) are square and have sides 2 m in length.
trian radiation exposure during fair weather in a residential area (e.g., Building wall and street surface albedos are 0.25 and 0.21, respectively.
Open Lowrise local climate zone with relatively low H/W ratio). Our Pedestrians and varying coverages of street trees are placed between the
specific objective is to quantify the relation between sidewalk tree building and the row of street trees, immediately adjacent to the tree
coverage and pedestrian TMRT reduction for different times of day during canopy in locations typically occupied by sidewalks (Fig. 1a-e; location
the summer at midlatitudes, and for different street orientations. In B in Supplementary Fig. 1).
addition, we compare the effects of street trees on longwave versus Upper boundary conditions for the model simulations were provided
shortwave contributions to pedestrian TMRT. by meteorological forcing data measured at the top of a 28 m tower
Fig. 1. Excerpts of the simulation domains
for simulations with a) 25% sidewalk tree
coverage, b) 33% sidewalk tree coverage, c)
50% sidewalk tree coverage, d) 67% side-
walk tree coverage, e) 100% sidewalk tree
coverage, and f) 0% sidewalk tree coverage
(i.e. base case). Green patches represent the
spaces above which the tree foliage is
placed, and red sub-patch scale pedestrians
show all pedestrian placements required to
equally sample the smallest replicable unit
of repeated street tree coverage. Here, the
“NW” pedestrian location and building
orientation are illustrated (assuming North
is toward the top of the figure); however,
the same relative locations of pedestrians,
trees and buildings apply to all other side-
walk pedestrian locations. (For interpreta-
tion of the references to colour in this figure
legend, the reader is referred to the web
version of this article.)
3

J.A. Lachapelle et al.                                                                                                                                                                              L a  n  d  s c  a p  e  a  n  d   U  r  b a  n   P  l a n  n  i n  g  230(2023)104608
Table 1
Results from linear regressions for each set of simulations in early and late summer during key time periods (peak Ta and peak TMRT), where all p-values <0.05.
Direction  Season  Time  Intercept (◦C)  Slope  R2  MAD (◦C)  RMSD (◦C)
|     |        |      | (cid:0) | (cid:0) |        |        |       |
| --- | ------ | ---- | ------- | ------- | ------ | ------ | ----- |
| N   | Early  | Ta   | 1.03    | 12.05   | 0.96   | 0.64   | 0.73  |
N  Early  TMRT   (cid:0) 0.83   (cid:0) 18.50   0.99   0.49   0.56
N  Late  Ta   (cid:0) 1.79   (cid:0) 18.90   0.96   1.04   1.17
|     |        |        | (cid:0) | (cid:0) |        |        |       |
| --- | ------ | ------ | ------- | ------- | ------ | ------ | ----- |
| N   | Late   | TMRT   | 0.69    | 20.28   | 0.99   | 0.41   | 0.47  |
|     |        |        | (cid:0) | (cid:0) |        |        |       |
| NW  | Early  | Ta     | 0.40    | 4.41    | 0.96   | 0.23   | 0.28  |
NW  Early  TMRT   (cid:0) 0.60   (cid:0) 18.28   >0.99   0.35   0.41
NW  Late  Ta   (cid:0) 0.39   (cid:0) 5.61   0.97   0.25   0.29
|     |       |        | (cid:0) | (cid:0) |        |        |       |
| --- | ----- | ------ | ------- | ------- | ------ | ------ | ----- |
| NW  | Late  | TMRT   | 0.77    | 21.66   | 0.99   | 0.46   | 0.52  |
NE  Early  Ta   (cid:0) 0.70   (cid:0) 17.04   0.99   0.42   0.48
NE  Early  TMRT   (cid:0) 0.54   (cid:0) 17.88   >0.99   0.31   0.37
|     |       |        | (cid:0) | (cid:0) | >0.99   |        |       |
| --- | ----- | ------ | ------- | ------- | ------- | ------ | ----- |
| NE  | Late  | Ta     | 0.53    | 17.41   |         | 0.34   | 0.39  |
|     |       |        | (cid:0) | (cid:0) | >0.99   |        |       |
| NE  | Late  | TMRT   | 0.46    | 18.82   |         | 0.27   | 0.32  |
E  Early  Ta   (cid:0) 0.46   (cid:0) 15.15   >0.99   0.27   0.31
E  Early  TMRT   (cid:0) 0.80   (cid:0) 16.93   0.99   0.47   0.54
|     |       |      | (cid:0) | (cid:0) |        |        |       |
| --- | ----- | ---- | ------- | ------- | ------ | ------ | ----- |
| E   | Late  | Ta   | 0.74    | 15.50   | 0.99   | 0.42   | 0.48  |
E  Late  TMRT   (cid:0) 1.58   (cid:0) 21.25   0.98   0.96   1.06
W  Early  Ta   (cid:0) 0.42   (cid:0) 4.43   0.96   0.24   0.28
|     |        |        | (cid:0) | (cid:0) |        |        |       |
| --- | ------ | ------ | ------- | ------- | ------ | ------ | ----- |
| W   | Early  | TMRT   | 0.72    | 19.22   | 0.99   | 0.43   | 0.49  |
|     |        |        | (cid:0) | (cid:0) |        |        |       |
| W   | Late   | Ta     | 0.37    | 4.01    | 0.96   | 0.21   | 0.25  |
W  Late  TMRT   (cid:0) 1.13   (cid:0) 21.72   0.99   0.68   0.76
| Mean  |     |     | ¡0.75  | ¡15.45   | 0.98   | 0.45   | 0.51   |
| ----- | --- | --- | ------ | -------- | ------ | ------ | ------ |
located at a latitude of 49.2261◦ and a longitude of (cid:0) 123.0784◦ in  These pedestrians are centered on the building face in the along street
Vancouver (Christen et al., 2010) during early summer (June 27–28,  direction. Results from different pedestrian placements for each tree
2008) and late summer (September 5–7, 2011). For each case, the first  coverage are averaged together to obtain overall TMRT results for each
day of simulations were considered to be spin-up and were not consid- tree coverage. For the 0 % tree coverage case, four pedestrian place-
ered in later analysis. For the late summer simulations, results are a  ments are used even though only one is needed for the smallest repli-
diurnal average of the two subsequent days. Simulations from early  cable unit, because the four pedestrians allow for provision of an exact
summer (~solstice) and late summer (~equinox) at a single location  base case comparison for each corresponding pedestrian location asso-
(Vancouver) show the effects of street trees for different diurnal pro- ciated with the different tree coverage simulations.
gressions of solar zenith and azimuth angles, and hence yield insight into  Results were examined over the diurnal cycle, with a focus on spe-
effects of street tree planting as a function of latitude in addition to day  cific times of interest: during peak air temperature (Ta), or peak TMRT.
of year (e.g., results from late summer in Vancouver give an indication of  These times of day were determined by examining the times of peak
how trees impact TMRT differently at higher latitudes close to the  TMRT and peak Ta in the base case simulation without street trees for
solstice).  each of the street orientations. These results indicated peak Ta was
There are eight different sidewalk locations among streets oriented  14–18 h in early summer and 14–17 h in late summer, and consistent for
toward the cardinal directions (N-S and E-W) and additionally rotated  all street orientations. Conversely, the daytime period exhibiting peak
45◦
relative to cardinal (NE-SW and NW-SE). Simulations were con- TMRT was earlier in the day and changed with street orientation and
ducted for five of these sidewalk locations, targeting pedestrian loca- pedestrian location (see Supplementary Fig. 2).
tions that are likely to experience high radiative exposure. In the “N”
The difference between TMRT averaged over all pedestrian locations
simulations, the pedestrian is placed on the north side of an E-W street  for each tree coverage and the average of the corresponding pedestrian
canyon. Similarly, in the “NW” simulations, the pedestrian is placed on  locations without trees (0 % coverage) quantifies the effect of tree
the north-west side of a NE-SW canyon (45◦
street orientation), while  coverage on pedestrian TMRT. This TMRT difference is then plotted
the pedestrian placement in the “NE” simulations is on the north-east  against fractional sidewalk tree coverage for each diurnal period of in-
side of a NW-SE street (oriented 45◦ from N-S and E-W streets).  terest (peak TMRT and peak Ta), and both linear and non-linear re-
Finally, for a N-S canyon, simulations were performed with the pedes- gressions are performed to assess the shape of the curve as well as the
trian on the east side (“E” simulations), and on the west side (“W”  relative contribution to radiative cooling of street tree planting as a
simulations) of the canyon. The following locations were excluded  function of existing tree cover (see Sect. 3.1). The form of the equations
because pedestrians are substantively shaded by buildings: the south  for the linear and non-linear regressions are as follows:
side of an E-W street, the southwest side of a NW-SE street, and the  ΔT =m×x+b
|     |     |     |     | MRT |     |     | (1)   |
| --- | --- | --- | --- | --- | --- | --- | ----- |
southeast side of a NE-SW street.
The suite of simulations also includes different sidewalk tree cover- ΔT =c×ln(x+1)
|     |     |     |     | MRT |     |     | (2)   |
| --- | --- | --- | --- | --- | --- | --- | ----- |
ages for each pedestrian location: 0 %, 25 %, 33 % 50 %, 67 % and 100
%, corresponding to tree spacings of ∞, 16 m, 12 m, 8 m, 6 m and 4 m,  where ×is the sidewalk street tree coverage fraction, m is the slope, b is
respectively (Fig. 1). Individual trees are 8 m tall, 4 m wide, with canopy
the y-intercept, and c is a coefficient. Note that Eq. (2) has a y-intercept
depth of 6 m (trunk height of 2 m), which are the equivalent of a 5-inch
of 0 by definition. The performance of these two regressions is compared
caliper tree from the American Nursery Stock Standards. Individual trees  using the coefficient of determination (R2), and by quantifying the bias,
for the 25 % and 33 % tree coverage cases are slimmer than the trees in
mean absolute difference (MAD), and root mean square difference
other cases out of necessity given the resolution of the model. The 50 %
(RMSD), between the regression and the data output by TUF-Pedestrian.
coverage case was tested with both the normal “square” trees and the
Importantly, TUF-Pedestrian can also determine the relative contri-
slimmer trees found in the 25 % and 33 % coverage cases to ensure the  butions of different radiative fluxes to the overall radiant cooling effect
use of slimmer trees yielded consistent results. For each tree coverage,  of trees as expressed by changes to pedestrian TMRT. As such, the dif-
different pedestrian placements are used to sample the smallest repli- ference in radiative fluxes absorbed by the pedestrian from the base case
cable unit of tree-covered and uncovered sidewalk (i.e., the combined  are visualized. The absorbed radiative fluxes are directionally weighted
width of one tree and the gap between it and an adjacent tree; Fig. 1).  as for the six-directional approach to TMRT calculation (Ho¨ppe, 1992),
4

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
with lateral fluxes from each cardinal direction being weighted by 0.22 3. Results
and upward and downward fluxes being weighted by 0.06. This
distinction of contributions to TMRT yields insight into which fluxes most 3.1. Effect of tree coverage on TMRT
strongly control changes in TMRT as a function of tree cover by ac-
counting for the larger area of vertical pedestrian surface (relative to From an urban design standpoint, planners and designers need to
horizontal). know whether or not the addition of trees to shade the sidewalk where
Fig. 2. Difference in TMRT from the base case (without trees) with increasing fractional sidewalk tree coverage for two times of day during two times of year.
Logarithmic regressions are shown as the line of best fit.
5

J.A. Lachapelle et al.                                                                                                                                                                              L a  n  d  s c  a p  e  a  n  d   U  r  b a  n   P  l a n  n  i n  g  230(2023)104608
pedestrians walk provides the same added cooling benefit irrespective of  Ta ” radiative cooling effectiveness for each pedestrian location, as
existing tree cover. A range of sidewalk tree cover fractions are tested in  quantified by the coefficient in the logarithmic fit averaged across both
terms of their ability to reduce pedestrian TMRT. During the two “hot”  seasons, are: (cid:0) 24.4 (NE), –23.7 (N), (cid:0) 21.8 (E), (cid:0) 7.5 (NW), (cid:0) 6.5 (W)
| afternoon periods of interest (i.e., “peak Ta |     |     | ”, “peak TMRT ”), the rela- |     |     |     |     |     |
| --------------------------------------------- | --- | --- | --------------------------- | --- | --- | --- | --- | --- |
(Table 2). This means that during times of day characterized by high air
tionship between sidewalk tree coverage and associated TMRT reduction  temperature trees have a greater radiative cooling effect on pedestrians
is approximately linear as indicated by an R2 >0.95 for all simulations
for the NE, N and E pedestrians (in that order of priority), while trees
(Table 1). However, the associated best fit equations indicate, based on  have smaller effect on pedestrian TMRT for the pedestrians located in the
the y-intercept (i.e., no tree cover), that the case without tree cover  NW and W locations, which are shaded by buildings during afternoon
1 ◦C difference in TMRT (Table 1), when it must be 0 ◦C by
results in a (cid:0) hours. A “peak heat” period that is the combination of “peak TMRT ” and
definition. In addition, the residuals from the linear regression shows a  “peak Ta ” periods similarly differentiates the pedestrian locations in
clear parabolic pattern, suggesting a non-linear relationship (Supple- terms of tree planting effectiveness (Supplementary Fig. 4). Conversely,
mentary Fig. 3). As such, it is likely that the relationships are slightly  all pedestrian locations exhibit similarly high TMRT reductions during
non-linear, at least across certain tree coverages. Forcing a logarithmic  midday and early afternoon (i.e., “peak TMRT ”; Fig. 2).
regression through the origin provides a very good fit, as indicated an R2
>0.99 for all times of day, as well as a lower MAD and RMSD than for
|     |     |     |     | 3.2. Effects of trees on pedestrian radiative fluxes  |     |     |     |     |
| --- | --- | --- | --- | ----------------------------------------------------- | --- | --- | --- | --- |
the linear regression (Fig. 2, Table 2). Notably, the derivative of this
logarithmic fit equation (i.e. Eq. (2)) indicates that planting a tree in a   ◦
street devoid of trees (x =0) is about twice as effective at reducing TMRT  P e d e st r i a n   T  d u ri n g  th e  d a y  p e a k s   n e a r   7 0 C  i n  t h e  a b s e n c e   o f
M R T
|     |     |     |     | stre e t  | t re e s   b u t   dr o p | s  b e lo w  6 0  ◦ C   w | h e n   t r e e s   a re   ad d | e d   (F ig .   3 ) .  F o r   |
| --- | --- | --- | --- | --------- | ------------------------- | ------------------------- | ------------------------------- | ------------------------------ |
as planting a tree in a street with nearly full sidewalk street tree coverage
sidewalks with 100 % tree coverage, maximum TMRT drops to approxi-
(x ≈1.0):
mately 50 ◦C or less. The trees assessed here (canopies of 4 m width, 6 m
∂(ΔT ) c height, and leaf area density 0.5 m2/m (cid:0) 3) are capable of lowering TMRT
| MRT = |     |     |     | (3)  |     |     |     |     |
| ----- | --- | --- | --- | ---- | --- | --- | --- | --- |
∂x x+1 by up to approximately 20 ◦C at particular times of day if trees cover the
That is, by substituting x  =0 and x  =1 into Eq. (3), it is apparent  entire length of the sidewalk (Fig. 4). However, even with 50 % sidewalk
coverage, trees can reduce pedestrian TMRT by up to 10–12 ◦C on average
that the rate of change of ΔTMRT with added tree density x predicted by
this simple mathematical model is twice as large for x  =0 compared to  during the middle part of the day. Also notable in Figs. 3 and 4 is that
x  =1.  trees are also best at reducing pedestrian TMRT during peak TMRT hours.
TUF-Pedestrian also allows assessment of the directional radiative
The relationships in Fig. 2 are only slightly non-linear, and as a
result, a linear fit also gives good predictive power with R2 > components contributing to TMRT (Fig. 5 for the N pedestrian, with
0.95
similar results for other simulations). This makes it possible to examine
(Table 1). The magnitude of the coefficient in the logarithmic regression
which fluxes contribute most to pedestrian TMRT and which fluxes the
(Eq. (2)) and the magnitude of the slope in the linear relationship (Eq.
trees modify most strongly in cooling the pedestrian. The lateral long-
(1)) both provide an estimate of the sensitivity of TMRT to differing tree
wave fluxes (i.e., those incident on the sides of the pedestrian) are the
coverages. These slopes and coefficients during peak TMRT are greater
than the corresponding magnitudes for the peak Ta period later in the  largest fluxes and contribute most to TMRT (Fig. 5), in agreement with
&
afternoon. Thus, TMRT shows higher sensitivity to tree coverage during  recent  observational  findings  for  summertime  cases  (Middel
peak TMRT hours, or, in other words, trees are more effective at reducing  Krayenhoff, 2019). However, the increase in TMRT during the day for the
pedestrian TMRT during peak TMRT hours (peak hours of shortwave ra- base (no tree) case (Fig. 3) is largely attributable to the lateral shortwave
fluxes on the sides of the pedestrian facing the sun at a given time of day
diation loading on the pedestrian).
(Fig. 5). The reflected shortwave radiation and surface temperature
Across both seasons the pedestrians in the N, NE, and E locations
distribution across streets and building walls for the 50 % sidewalk tree
show the highest TMRT sensitivity (i.e., radiative cooling effectiveness) to
cover case at 1430 LST for the late summer case illustrates the detailed
| the sidewalk tree coverages during mid-late afternoon (“peak Ta |     |     |     | ”),  |     |     |     |     |
| --------------------------------------------------------------- | --- | --- | --- | ---- | --- | --- | --- | --- |
spatial distribution of the shortwave and longwave radiation environ-
based on the magnitude of slopes for these scenarios (Fig. 2). The NW
ment captured by the TUF-Pedestrian model (Fig. 6). In particular, the
and W pedestrians show much less TMRT sensitivity at this time. “Peak
shading of the hot south-facing wall by the trees at this time and season
Table 2
Results from logarithmic regressions for each set of simulations in early and late summer during key time periods (peak Ta and peak TMRT), where all p-values <0.05.
|            |         |       | Intercept (◦C)  |              | R2  | Bias (◦C)  | MAD (◦C)  | RMSD (◦C)  |
| ---------- | ------- | ----- | --------------- | ------------ | --- | ---------- | --------- | ---------- |
| Direction  | Season  | Time  |                 | Coefficient  |     |            |           |            |
N  Early  Ta   0.00   (cid:0) 18.31   >0.99   (cid:0) 0.08   0.26   0.39
N  Early  TMRT   0.00   (cid:0) 26.51   >0.99   0.06   0.20   0.26
|     |       |        |        | (cid:0) | >0.99   | (cid:0) |        |       |
| --- | ----- | ------ | ------ | ------- | ------- | ------- | ------ | ----- |
| N   | Late  | Ta     | 0.00   | 29.09   |         | 0.18    | 0.44   | 0.63  |
|     |       |        |        | (cid:0) | >0.99   |         |        |       |
| N   | Late  | TMRT   | 0.00   | 28.58   |         | 0.12    | 0.32   | 0.41  |
NW  Early  Ta   0.00   (cid:0) 6.75   >0.99   (cid:0) 0.04   0.09   0.16
NW  Early  TMRT   0.00   (cid:0) 25.72   >0.99   0.11   0.31   0.39
|     |       |      |        | (cid:0) | >0.99   | (cid:0) |        |       |
| --- | ----- | ---- | ------ | ------- | ------- | ------- | ------ | ----- |
| NW  | Late  | Ta   | 0.00   | 8.34    |         | 0.02    | 0.09   | 0.13  |
NW  Late  TMRT   0.00   (cid:0) 30.60   >0.99   0.12   0.32   0.42
NE  Early  Ta   0.00   (cid:0) 24.29   >0.99   0.07   0.21   0.27
|     |        |        |        | (cid:0) | >0.99   |        |        |       |
| --- | ------ | ------ | ------ | ------- | ------- | ------ | ------ | ----- |
| NE  | Early  | TMRT   | 0.00   | 25.06   |         | 0.12   | 0.34   | 0.43  |
|     |        |        |        | (cid:0) | >0.99   |        |        |       |
| NE  | Late   | Ta     | 0.00   | 24.41   |         | 0.12   | 0.32   | 0.40  |
NE  Late  TMRT   0.00   (cid:0) 26.15   >0.99   0.15   0.42   0.51
E  Early  Ta   0.00   (cid:0) 21.24   >0.99   0.10   0.28   0.35
|     |        |        |        | (cid:0)  | >0.99   |        |        |       |
| --- | ------ | ------ | ------ | -------- | ------- | ------ | ------ | ----- |
| E   | Early  | TMRT   | 0.00   | 24.34    |         | 0.04   | 0.19   | 0.24  |
| E   | Late   | Ta     | 0.00   | –22.31   | >0.99   | 0.03   | 0.16   | 0.19  |
E  Late  TMRT   0.00   (cid:0) 31.80   >0.99   (cid:0) 0.09   0.26   0.37
|     |        |        |        | (cid:0) | >0.99   | (cid:0) |        |       |
| --- | ------ | ------ | ------ | ------- | ------- | ------- | ------ | ----- |
| W   | Early  | Ta     | 0.00   | 6.82    |         | 0.04    | 0.10   | 0.16  |
|     |        |        |        | (cid:0) | >0.99   |         |        |       |
| W   | Early  | TMRT   | 0.00   | 27.25   |         | 0.09    | 0.26   | 0.35  |
W  Late  Ta   0.00   (cid:0) 6.16   >0.99   (cid:0) 0.04   0.09   0.14
W  Late  TMRT   0.00   (cid:0) 31.45   >0.99   0.03   0.18   0.22
|       |     |     |       | –22.26   | >0.99   |        |        |        |
| ----- | --- | --- | ----- | -------- | ------- | ------ | ------ | ------ |
| Mean  |     |     | 0.00  |          |         | 0.03   | 0.24   | 0.32   |
6

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
Fig. 3. TMRT over 24 h for early and late summer for different sidewalk tree coverages. Results are shown for each pedestrian location.
(Fig. 6) explains the larger reduction of longwave by trees on the north the decreases in absorbed shortwave radiative fluxes due to tree shading
side of the pedestrian compared to other sides (Fig. 7). are found predominantly on the sides of the pedestrian facing towards
The differences in radiative fluxes incident on the pedestrian as a the sun as well as at the top of the pedestrian. Whereas the pedestrian in
result of each level of sidewalk tree cover implementation are shown in the N location is affected by direct shortwave radiation for the entire
Figs. 7-11 for the N, NW, NE, E and W pedestrian locations, respectively. day, the pedestrians in the NW and W location becomes shaded by the
Most of the radiative cooling from trees is caused by reduction of building earlier in the afternoon (near 15 h and 12 h respectively), and
shortwave radiation fluxes absorbed by the pedestrian, and in all cases the pedestrian in the NE and E simulations is shaded by the building
7

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
Fig. 4. Difference in TMRT from the case without trees in early and late summer for five different sidewalk tree coverages. Results are shown for the N, NW, NE, E, and
W cases.
through most of the morning (until near 10 h and 12 h respectively). The of radiation absorbed by the pedestrian (Figs. 7-11). Due to the lower
surfaces around the pedestrian are cooled due to the presence of trees (e. sun elevation, trees provide more TMRT reduction over the course of the
g. Fig. 6), which during sunlit periods provides approximately 25 % of day for the late summer period compared to the early summer period for
the cooling experienced by the pedestrian via reductions in absorbed the N, NE and NW pedestrian locations. However, the reverse is true for
longwave radiation (Figs. 7-11), increasing to 50 % of cooling during the E and W pedestrian locations because building shade renders tree
periods of the day when the pedestrian is shaded (Supplementary Fig. 5). shade irrelevant for a greater portion of the day during late summer.
During daytime periods when the pedestrian is not in the sun, longwave Trees decrease longwave fluxes absorbed by the pedestrian
absorption reductions account for more than half of the total reduction throughout the day. For each street orientation, longwave absorption on
8

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
Fig. 5. Weighted radiative fluxes absorbed by the pedestrian for the N pedestrian location (north side of E-W street) for different sidewalk tree coverages and seasons.
Kd are shortwave fluxes and Ld are longwave fluxes. Top, Bot, N, S, E, and W represent the six directions: top, bottom, north, south, east, and west, respectively, and
the building is directly north of the pedestrian.
the side of the pedestrian facing the building is most affected by the all sides of the pedestrian during the day. At night, longwave radiative
presence of trees, particularly during late summer. The trees provide fluxes to pedestrians are only slightly affected by trees, in part as a result
shade to the otherwise hot building walls facing the pedestrians, which of two processes that offset each other to different degrees on different
absorb and reflect less shortwave radiation as a result (Fig. 6). The sides of the pedestrian. For the pedestrian in the N location (Fig. 7), the
building walls therefore remain cooler (Fig. 6) and emit less longwave north side of the pedestrian receives less longwave radiation at night,
radiation towards the pedestrian. Similarly, the ground immediately while the south side of the pedestrian receives an increased amount, as a
surrounding the pedestrian is also cooled by tree shade and therefore result of tree cover. The building has been cooled by tree shade during
emits less longwave radiation, decreasing longwave radiative fluxes to the day, resulting in less daytime heat storage and release toward the
9

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
Fig. 6. Reflected shortwave radiation (a) and surface temperature (b) at impervious surfaces at 1430 LST for the late summer simulation with 50% sidewalk street
tree coverage (i.e. Fig. 1c). North is toward the upper left, aligned with the street direction.
north side of the pedestrian in the form of longwave emissions at night. 4. Discussion
In contrast, the south side of the pedestrian, which faces the street and
the tree cover, sees less cool sky due to the tree cover, and therefore We investigated the effect of street trees on pedestrian TMRT using the
absorbs more longwave radiation as the trees replace the cold sky as TUF-Pedestrian model. Our goal was to assist planners and designers
primary longwave emitters from this direction. further understand how specific sidewalk tree coverages influence
pedestrian TMRT to help optimize the use of street trees for TMRT
10

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
Fig. 7. Difference in weighted radiative fluxes absorbed by the pedestrian from the base case (i.e., no trees) for the N pedestrian location with different sidewalk tree
coverages and at two times of year. Kd represents shortwave fluxes and Ld represents longwave fluxes. Top, Bot, N, E, S, and W represent the six directions: top,
bottom, north, east, south, and west, respectively, and the building is north of the pedestrian.
reduction, since municipalities often have limited space and funding for 4.1. Radiative cooling effectiveness as a function of sidewalk tree cover
planting and maintaining street trees (Salmond et al. 2016). Urban
forestry decision-makers need to understand how many trees need to be Our simulations indicate that more tree cover is better at radiatively
planted to best cool pedestrians, and to account for limitations and costs cooling pedestrians in a detached residential area with a low canyon H/
associated with street tree planting and maintenance, to optimize their W ratio where shade from urban form is sparse. The TMRT reduction
impacts on pedestrian thermal comfort in city streets. Even if plantable effect of trees is a slightly non-linear function of sidewalk tree coverage,
space and funding for street trees were not of concern, high tree cover in and a logarithmic equation indicating monotonically decreasing radia-
streets reduces ventilation and has potentially negative consequences tive cooling effectiveness of street trees with increasing total sidewalk
for air quality at the pedestrian level (Karttunen, Kurppa, Auvinen, tree cover provides a good fit to the available simulation data (Eq. (2),
Hellsten, & Ja¨rvi, 2020; Norton et al., 2015; Vos, Maiheu, Vankerkom, & Fig. 2). However, we hypothesize that the diminishing TMRT reduction
Janssen, 2013). Moreover, equity-based justifications for tree planting returns as tree cover increases simulated here results from mutual
investments are important. Therefore, there are multiple reasons to shading between trees, which is unlikely to play a substantive role for
better understand the effectiveness of different tree coverages for low tree coverages (individual trees are equally spaced in all scenarios
reducing pedestrian TMRT. we consider here). It is more likely that cooling is relatively linear (i.e.,
effectiveness per tree is constant) up to a certain sidewalk tree coverage,
and thereafter increasingly diminishes as mutual shading plays an
11

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
Fig. 8. Same as Fig. 7 except for the NW pedestrian location. Top, Bot, N, E, S, and W represent the six simulated sides of the pedestrian, where N indicates the side
facing the building, to the north-west of the pedestrian.
increasing role. Notably, TMRT reduction per tree coverage increase is reduction. Using a 2-D model that does not explicitly represent tree
about 1.5–2 times as large for the increase in tree coverage from 0.00 to spacing and associated interactions in the along-canyon direction, they
0.25 as it is for the increase in tree coverage from 0.67 to 1.00 (not suggest that TMRT drops exponentially with increasing tree coverage.
shown). Similarly, the logarithmic fit (Eq. (2), Fig. 2) indicates a Their results for tree sizes that approximate the current work show a
doubling of radiative cooling per street tree for a street without trees different relationship between sidewalk tree coverage and TMRT reduc-
compared to a street approaching full sidewalk tree coverage. Regard- tion (Fig. 12). Both our TUF-Pedestrian results and the Park et al. (2019)
less, the results presented here clearly indicate that space between in- results show the intuitive result that more trees give more radiative
dividual street trees should be maximized to optimize radiative cooling cooling, yet unlike the Park et al. (2019) study, TUF-Pedestrian indicates
per tree. Many municipalities space street trees at 8 m (25ft) on center that effectiveness of tree planting for TMRT reduction decreases much
based on decades old prescriptive guidance and tradition (Whyte, 1980). more slowly with increased tree coverage (Fig. 12). The current simu-
A question for future research for improved pedestrian cooling per street lations improve on the work of Park et al. (2019) by explicitly repre-
tree is determination of the degree of sidewalk street tree coverage (and senting tree spacing and associated interactions in the along-canyon
the associated tree spacing) at which mutual shading begins to sub- dimension by using a 3-D model. Nevertheless, both our study and Park
stantially decrease radiative cooling effectiveness as a function of sea- et al. (2019) clearly indicate that a higher percentage of sidewalk tree
son, latitude, and tree characteristics. cover will help further reduce pedestrian TMRT in hot weather, and more
A linear function also captures the dependence of TMRT reduction on study is needed to better quantify these relations. In addition to mutual
sidewalk street tree cover reasonably well. Park et al. (2019) have also shading, street tree planting decisions will also need to consider funding,
addressed the relationship between tree coverage and pedestrian TMRT available space, street ventilation, and related factors.
12

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
Fig. 9. Same as Fig. 7 except for the NE pedestrian location. Top, Bot, N, E, S, and W represent the six simulated sides of the pedestrian, where N indicates the side
facing the building, to the north-east of the pedestrian.
4.2. Radiative cooling effectiveness as a function of street orientation and those that are most exposed to the sun and have little shade from
pedestrian location buildings during summer afternoons: e.g., the north side of an E-W
canyon with relatively short buildings. Additionally, neighbourhoods
The afternoon period when TMRT and/or Ta peak is likely the most where sidewalks are not directly adjacent to buildings (i.e., there are
important period to provide radiative cooling to pedestrians. However, setbacks) would also benefit from more tree cover to decrease pedestrian
trees exhibit larger or smaller cooling effects at these times of day TMRT. These findings advance a more nuanced planning and design
depending on the street orientation. Trees have little cooling effect on approach to strategically prioritize the diurnal pedestrian comfort needs
pedestrians located on the north-west side of a NE-SW canyon during the for specific sidewalk segments and activities. This more refined
afternoon period because the proximity of the pedestrian to the building approach is helpful for transportation planning related to transit stops
provides ample shade at that time. In contrast, trees will have a greater and critical pathways used by pedestrians during their daily necessary
cooling effect on pedestrians located on the north side of an E-W canyon, (e.g., work), optional (e.g., stroll), and social (e.g., walking club) ac-
or on pedestrians located on the north-east side of a NW-SE canyon. tivities (Gehl, 1987).
Pedestrians located on the west side of a N-S canyon are also less
effectively cooled by trees due to the building shade in the afternoon.
Conversely, trees have a greater cooling effect on a pedestrian on the
4.3. Directional radiative fluxes and contributions to TMRT
east side of a N-S canyon in the afternoon. Therefore, ceteris paribus, the
By quantifying directional shortwave and longwave fluxes incident
planting of trees should be focused on locations where trees have a
on pedestrians with TUF-Pedestrian, we can also indicate the surfaces
greater effect during the hot afternoon period. These locations would be
that most strongly modulate TMRT. For the current midlatitude
13

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
Fig. 10. Same as Fig. 7 except for the E pedestrian location. Top, Bot, N, E, S, and W represent the six simulated sides of the pedestrian, where N indicates the side
facing the building, to the east of the pedestrian.
simulations, we find that longwave lateral fluxes dominate pedestrian 4.4. Assumptions, limitations, and future work
TMRT (Fig. 5), and that cooling nearby building walls could substantively
lower TMRT, in agreement with Middel and Krayenhoff (2019). However, Our simulations focused on the effects of street tree cover on
trees primarily reduce TMRT by reducing the shortwave fluxes incident pedestrian TMRT and its radiative fluxes, and they assumed that pedes-
on a pedestrian, particularly the lateral shortwave fluxes (e.g., Fig. 7). trian walkways were situated a certain distance from the buildings and
TUF-Pedestrian shows a smaller effect on longwave radiative fluxes as a immediately adjacent to the edge of the canopy of street trees (e.g.,
result of tree planting, especially at night (e.g., Figs. 4 and 7). This effect Fig. 1). To assess the impact of the location of pedestrians relative to
on longwave emissions at night is smaller than the 5 ◦C increase of TMRT trees and buildings (i.e. laterally across the street), we simulated several
found by Middel and Krayenhoff (2019), which may be due in part to the pedestrian locations for the N, NW and NE cases, that is, locations
relatively low leaf area density used in the current TUF-Pedestrian ranging from directly underneath the center of the row of street trees, to
simulations. It may be beneficial to use cooling methods other than locations in the space between the tree canopy and the building (Sup-
trees to lower longwave radiative fluxes on pedestrians during the day, plementary Fig. 1). These simulations reveal that the relationship be-
such as altering material radiative and/or thermal properties. A better tween the placement of the pedestrian walkway in relation to the row of
understanding of vertical surfaces provides much needed guidance to street trees and the reduction of TMRT is complex, where the coolest
pedestrian level design guidance to improve thermal comfort. However, pedestrian locations at the hottest times of day depend on street orien-
surface temperatures and resulting longwave radiative fluxes can be tation and solar angle (Supplementary Fig. 6 and Supplementary Dis-
difficult to reduce in hot weather. Thus, reducing shortwave fluxes (i.e., cussion). TMRT differences as a function of cross-street pedestrian
shade provision) is likely to be the best method to reduce TMRT. location reach ~5 ◦C, much of which probably results from the shape of
14

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
Fig. 11. Same as Fig. 7 except for the W pedestrian location. Top, Bot, N, E, S, and W represent the six simulated sides of the pedestrian, where N indicates the side
facing the building, to the west of the pedestrian.
the trees and their position relative to the pedestrian, which controls the therefore slightly reduce effectiveness of street tree planting for TMRT
degree of attenuation of direct shortwave radiation through the tree reduction. Finally, the current analyses use specific dimensions and
canopy. The cross-street pedestrian location at the edge of the tree diurnal sequences of solar angles, which may not be generalizable to
canopy crowns chosen for the main numerical experiments in this work different canyon or tree dimensions or latitude-season combinations.
achieves a relatively high level of TMRT reduction across street directions Ultimately, results from this type of study should be non-
and seasonal periods tested (i.e., “1.33 m” location in Supplementary dimensionalized to be more widely applicable.
Fig. 6).
More study on the relationship between the placement of trees in 5. Conclusions
relation to pedestrians and the reduction in TMRT is still needed. The
experiments performed here could be expanded to include simulations The practice of heat management in cities is an emerging 21st cen-
with other canyon H/W ratios and different street tree dimensions to tury trend, but it’s underdeveloped (Hamstead & Coseo, 2019). As our
increase the range of neighbourhoods captured in the analysis. Addition study illustrates, communities of practice could benefit from more so-
of overlapping tree crowns could be added in the model (i.e., by phisticated guidance related to the cooling of pedestrian spaces that goes
increasing the leaf area density in areas of overlap). In addition, results beyond traditional metrics such as satellite-based surface temperature or
may change for ground and wall surface albedos that differ from those air temperature. Stone (2019) challenges planners to think of heat as an
assumed here (0.21 and 0.25, respectively). For example, lower street invisible, non-episodic, and city-amplified challenge. A key reframe
surface albedo (e.g. 0.10–0.15, more typical of asphalt), would decrease Stone makes is that heat challenges do not necessarily subside with the
shortwave reflection incident on pedestrians for the ‘no tree’ case and heat wave. Air temperatures can be within a ‘comfortable’ range, but
15

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
Fig. 12. Reduction of TMRT as a function of
increasing fractional sidewalk tree coverage
on the north side of an E-W street for the
early summer TUF-Pedestrian simulation
(trees are 8.0 m tall, 4.0 m wide, LAD =0.5
m2/m (cid:0)3), compared to simulated summer-
time data from Park et al. (2019) for their “S”
(5.9 m tall, 3.0 m wide, LAD =1.0 m2/m (cid:0)3)
and “M” (9.5 m tall, 5.0 m wide, LAD =1.0
m2/m (cid:0)3) trees. Attempted logarithmic fits
(gray and orange lines) for Park et al. (2019)
data are included to demonstrate the
different shape of the relation they derive.
(For interpretation of the references to colour
in this figure legend, the reader is referred to
the web version of this article.)
solar radiation loading on pedestrians due to a lack of shade can create adjacent to and directly underneath urban tree cover (Lachapelle et al.,
excessive heat conditions in city streets in many bioclimatic regions. The 2022). Simulations presented here demonstrate that optimal imple-
approach taken here integrates TMRT to evaluate three-dimensional mentation of street trees to reduce pedestrian TMRT can be complex and
thermal impacts on sidewalk spaces including wall and pavement ma- depend on several factors. The specific focus here is the placement of
teriality, solar orientation and shade patterns, vegetation, and radia- different coverages of evenly-spaced trees along the sidewalk and
tional dynamics, emphasizing the importance of radiation to measuring associated radiative impacts on pedestrians. A key result of the current
what matters – comfort and health. An approach which integrates TMRT simulations is that while more sidewalk street trees provide greater TMRT
as a key component of the heat experience in cities begins to more ho- reduction, once a certain level of tree cover is reached they do so with
listically capture the thermal-radiative life in which we inhabit. Ulti- modest reductions of radiative cooling effectiveness per tree. Analysis of
mately, more complete metrics that capture the complete pedestrian the current simulation results indicates that tree planting on a street
experience of heat, such as the Universal Thermal Climate Index (UTCI; with ≈100 % existing sidewalk street tree coverage is approximately
Jendritzky, de Dear, & Havenith, 2012), should be used. TMRT is a key 50–70 % as effective as planting on a street without trees. We hypoth-
component of UTCI, and typically controls most of its spatial variation in esize that reductions of radiative cooling effectiveness result from
urban areas during hot conditions. mutual shading between individual trees, which is not expected to play a
Here, the TUF-Pedestrian energy balance, radiation and thermal substantive role until a certain sidewalk street tree coverage is reached;
exposure model is applied to quantify the effectiveness of sidewalk street provided this hypothesis is accurate, the TMRT reduction per tree is ex-
tree radiative cooling. Recent model evaluation demonstrates that TUF- pected to remain approximately constant below this tree coverage and
Pedestrian accurately captures both shortwave and longwave direc- decrease for higher tree coverages.
tional radiation fluxes absorbed by pedestrians and the resulting mean A second key result is that specific pedestrian locations in specific
radiant temperature (TMRT) for pedestrian locations that are both street orientations (i.e., north side of east-west street, east side of north-
16

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
south street, and northeast side of northwest-southeast street) exhibit Coutts, A. M., White, E. C., Tapper, N. J., Beringer, J., & Livesley, S. J. (2016).
larger TMRT reductions during the hottest periods of the day as a result of T
co
e
n
m
tr
p
a
e
s
r
t
a
in
tu
g
r e
s t
a
re
n
e
d
t
h
ca
u
n
m
y
a
o
n
n
t
e
h
n
e
v
r
i
m
ro
a
n
l
m
co
e
m
nt
f
s
o
.
r
T
t
h
e
e
f
o
fe
r
c
e
t
ti
s
c a
o
l
f
a
s
n
tr
d
e e
A
t
p
t
p
r
l
e
ie
e
d
s a
C
c
li
r
m
os
a
s
t o
t
l
h
o
r
g
e
y
e
, 124,
tree planting. Alongside recent evidence that trees reduce air tempera- 55–68. https://doi.org/10.1007/s00704-015-1409-y
ture more effectively as tree canopy coverage increases (Ziter et al., Dosio, A., Mentaschi, L., Fischer, E. M., & Wyser, K. (2018). Extreme heat waves under
2019), the current results suggest that, while more trees provide both 1.5 C and 2 C global warming. Environmental Research Letters, 13(5), Article 054006.
Duneier, M. (2001). Sidewalk. Macmillan.
more air temperature and TMRT reductions, a relatively evenly-spaced
Dzyuban, Y., Hondula, D. M., Vanos, J. K., Middel, A., Coseo, P. J., Kuras, E. R., &
distribution of sidewalk street trees across all sun-exposed street loca- Redman, C. L. (2022). Evidence of alliesthesia during a neighborhood thermal walk
tions in a block or neighbourhood may be optimal from the perspective in a hot and dry city. Science of the Total Environment, 834, Article 155294.
Forsyth, A. (2015). What is a walkable place? The walkability debate in urban design.
of reducing outdoor heat exposure during warm conditions (i.e., it Urban design international, 20(4), 274–292.
would maximize both air temperature cooling and radiative cooling). Gehl, J. (1987). Life between buildings (Vol. 23). New York: Van Nostrand Reinhold.
Additional considerations may alter this conclusion for any particular Gillner, S., Vogt, J., Tharang, A., Dettmann, S., & Roloff, A. (2015). Role of street trees in
mitigating effects of heat and drought at highly sealed urban sites. Landscape and
neighbourhood, such as air quality considerations, or the number of
Urban Planning, 143, 33–42. https://doi.org/10.1016/j.landurbplan.2015.06.005
pedestrians frequenting any particular street, and their relative vulner- Gulya´s, A ´ ., Unger, J., & Matzarakis, A. (2006). Assessment of the microclimatic and
ability to heat. human comfort conditions in a complex urban environment: Modelling and
measurements. Building and Environment, 41(12), 1713–1722. https://doi.org/
Simulation results indicate that trees affect TMRT during daytime
10.1016/j.buildenv.2005.07.001
primarily by reducing shortwave radiative fluxes incident on pedes- Hamstead, Z., & Coseo, P. (2019). Critical Heat Studies: Making Meaning of Heat for
trians. Trees also cool surrounding street and building wall surfaces, Management in the 21st Century—Special Issue of the Journal of Extreme Events
reducing longwave fluxes towards pedestrians. Notably, reduction of Dedicated to Heat-as-Hazard.Journal of Extreme Events,6(03n04), 2003001.
Ho¨ppe, P. (1992). A new procedure to determine the mean radiant temperature outdoors.
longwave emission from surfaces shaded by trees contributes approxi- Wetter Und Leben, 44, 147–151.
mately 25 % of the total reduction of radiation absorbed by the pedes- Jacobs, J. (1961). The Death and Life of Great American Cities. Random House.
trian when the pedestrian would otherwise be exposed to full sunlight. Jendritzky, G., de Dear, R., & Havenith, G. (2012). UTCI—why another thermal index?
International journal of biometeorology, 56(3), 421–428.
For the midlatitude summer conditions studied here, longwave radiative
Johansson, E. (2006). Influence of urban geometry on outdoor thermal comfort in a hot
fluxes make up the majority of the daytime radiation (and 100 % of dry climate : A study in Fez, Morocco. Building and Environment, 41, 1326–1338.
nighttime radiation) absorbed by the pedestrian as encapsulated by the https://doi.org/10.1016/j.buildenv.2005.05.022
K´antor, N., Chen, L., & Ga´l, C. V. (2018). Human-biometeorological significance of
TMRT metric. However, contributions of absorbed shortwave radiation to shading in urban public spaces—Summertime measurements in P´ecs, Hungary.
TMRT are most readily altered by tree planting (or building shade). Landscape and Urban Planning, 170, 241–255. https://doi.org/10.1016/j.
Nevertheless, implementation of design strategies other than trees that landurbplan.2017.09.030
K´antor, N., Kova´cs, A., & Taka´cs, A ´ . (2016). Small-scale human-biometeorological
reduce longwave emissions (such as changing surface materials) may
impacts of shading by a large tree. Open Geosciences, 8, 231–245. https://doi.org/
additionally help reduce pedestrian TMRT during hot periods. We suggest 10.1515/geo-2016-0021
further study into the specific implementation of street trees in different Karttunen, S., Kurppa, M., Auvinen, M., Hellsten, A., & J¨arvi, L. (2020). Large-eddy
simulation of the optimal street-tree layout for pedestrian-level aerosol particle
urban geometries, latitudes and seasons to best understand how to
concentrations – A case study from a city-boulevard. Atmospheric Environment, X, 6
maximize the cooling effects of trees on pedestrians. (December 2019), Article 100073. https://doi.org/10.1016/j.aeaoa.2020.100073
Krayenhoff, E. S., Broadbent, A. M., Zhao, L., Georgescu, M., Middel, A., Voogt, J. A., …
Erell, E. (2021). Cooling hot cities: A systematic and critical review of the numerical
Declaration of Competing Interest
modelling literature. Environmental Research Letters, 16(5). https://doi.org/10.1088/
1748-9326/abdcf1
The authors declare that they have no known competing financial Krayenhoff, E. S., Jiang, T., Christen, A., Martilli, A., Oke, T. R., Bailey, B. N., …
Crawford, B. R. (2020). A multi-layer urban canopy meteorological model with trees
interests or personal relationships that could have appeared to influence
(BEP-Tree): Street tree impacts on pedestrian-level climate. Urban Climate, 32(July
the work reported in this paper. 2019), Article 100590. https://doi.org/10.1016/j.uclim.2020.100590
Krayenhoff, E. S., Moustaoui, M., Broadbent, A. M., Gupta, V., & Georgescu, M. (2018).
Data availability Diurnal interaction between urban expansion, climate change and adaptation in US
cities. Nature Climate Change, 8(12), 1097–1103. https://doi.org/10.1038/s41558-
018-0320-9
Data will be made available on request. Lachapelle, J. A., Krayenhoff, E. S., Middel, A., Meltzer, S., Broadbent, A. M., &
Georgescu, M. (2022). A microscale three-dimensional model of urban outdoor
thermal exposure (TUF-Pedestrian). International Journal of Biometeorology, 66(4),
Acknowledgements 833–848. https://doi.org/10.1007/s00484-022-02241-1
Lai, D., Liu, W., Gan, T., Liu, K., & Chen, Q. (2019). A review of mitigating strategies to
Thanks are due to Claudia Wagner-Riddle for providing comments improve the thermal environment and thermal comfort in urban outdoor spaces.
Science of the Total Environment, 661, 337–353. https://doi.org/10.1016/j.
on an early version of this manuscript. Funding was provided by an
scitotenv.2019.01.062
NSERC Discovery Grant to ESK. Lee, H., Mayer, H., & Schindler, D. (2014). Importance of 3-D radiant flux densities for
outdoor human thermal comfort on clear-sky summer days in Freiburg. Southwest
Germany. Meteorologische Zeitschrift, 23(3), 315–330. https://doi.org/10.1127/0941-
Appendix A. Supplementary data
2948/2014/0536
Lindberg, F., & Grimmond, C. S. B. (2011). The influence of vegetation and building
Supplementary data to this article can be found online at https://doi. morphology on shadow patterns and mean radiant temperatures in urban areas:
Model development and evaluation. Theoretical and Applied Climatology, 105,
org/10.1016/j.landurbplan.2022.104608.
311–323. https://doi.org/10.1007/s00704-010-0382-8
McGreevy, M., Musolino, C., Udell, T., & Baum, F. (2021). The Feasibility of
References Transitioning Low-density Suburbs into Healthy Walkable Neighbourhoods: The
Case of Adelaide. South Australia. Urban Policy and Research, 39(4), 377–396.
Middel, A., Alkhaled, S., Schneider, F. A., Hagen, B., & Coseo, P. (2021). 50 Grades of
Ali-Toudert, F., & Mayer, H. (2006). Numerical study on the effects of aspect ratio and
Shade. E1820 Bulletin of the American Meteorological Society., 102(9), E1805. https://
orientation of an urban street canyon on outdoor thermal comfort in hot and dry
climate. Building and Environment, 41, 94–108. https://doi.org/10.1016/j. doi.org/10.1175/bams-d-20-0193.1.
Middel, A., Chhetri, N., & Quay, R. (2015). Urban forestry and cool roofs: Assessment of
buildenv.2005.01.013
heat mitigation strategies in Phoenix residential neighborhoods. Urban Forestry and
Ali-Toudert, F., & Mayer, H. (2007). Effects of asymmetry, galleries, overhanging façades Urban Greening, 14(1), 178–186. https://doi.org/10.1016/j.ufug.2014.09.010
and vegetation on thermal comfort in urban street canyons. Solar Energy, 81,
742–754. https://doi.org/10.1016/j.solener.2006.10.007 Middel, A., & Krayenhoff, E. S. (2019). Micrometeorological determinants of pedestrian
thermal exposure during record-breaking heat in Tempe, Arizona : Introducing the
Ashrae. (2001). ASHRAE Fundamentals Handbook 2001 ((SI Edition)). American Society MaRTy observational platform. Science of the Total Environment, 687, 137–151.
of Heating, Refrigerating, and Air- Conditioning Engineers.
Christen, A., Coops, N., Kellett, R., Crawford, B., Heyman, E., Olchovski, I., … van der https://doi.org/10.1016/j.scitotenv.2019.06.085
Millward, A. A., Torchia, M., Laursen, A. E., & Rothman, L. D. (2014). Vegetation
Laan, M. (2010). A LiDAR-based urban metabolism approach to neighbourhood scale
placement for summer built surface temperature moderation in an urban
energy and carbon emissions modelling. University of British Columbia supported by
Natural Resources Canada.
17

J.A. Lachapelle et al. L a n d s c a p e a n d U r b a n P l a n n i n g 230(2023)104608
microclimate. Environmental Management, 53(6), 1043–1057. https://doi.org/ urban environment. Urban Ecosystems, 21(5), 851–862. https://doi.org/10.1007/
10.1007/s00267-014-0260-8 s11252-018-0761-y
Morakinyo, T. E., Ouyang, W., Lau, K. K. L., Ren, C., & Ng, E. (2020). Right tree, right Stewart, I. D., & Oke, T. R. (2012). Local climate zones for urban temperature studies.
place (urban canyon): Tree species selection approach for optimum urban heat Bulletin of the American Meteorological Society, 93(12), 1879–1900. https://doi.org/
mitigation – Development and evaluation. Science of the Total Environment, 719, 10.1175/BAMS-D-11-00019.1
Article 137461. https://doi.org/10.1016/j.scitotenv.2020.137461 Stone, B., Jr (2019). Policy Nook: Heat Waves as Hurricanes: A Comment. Journal of
Norton, B. A., Coutts, A. M., Livesley, S. J., Harris, R. J., Hunter, A. M., & Extreme Events, 6(03n04), 2071001.
Williams, N. S. G. (2015). Planning for cooler cities: A framework to prioritise green Taleghani, M., Sailor, D., & Ban-Weiss, G. A. (2016). Micrometeorological simulations to
infrastructure to mitigate high temperatures in urban landscapes. Landscape and predict the impacts of heat mitigation strategies on pedestrian thermal comfort in a
Urban Planning, 134, 127–138. https://doi.org/10.1016/j.landurbplan.2014.10.018 Los Angeles neighborhood. Environmental Research Letters, 11(2), Article 024003.
Oke, T. R. (1989). The micrometeorology of the urban forest. Philosophical Transactions – https://doi.org/10.1088/1748-9326/11/2/024003
Royal Society of London, B, 324(1223), 335–349. https://doi.org/10.1098/ Thorsson, S., Lindberg, F., Bjo¨rklund, J., Holmer, B., & Rayner, D. (2011). Potential
rstb.1989.0051 changes in outdoor thermal comfort conditions in Gothenburg, Sweden due to
Oke, T. R., Johnson, G. T., Steyn, D. G., & Watson, I. D. (1991). Simulation of surface climate change: The influence of urban geometry. International Journal of
urban heat islands under “ideal” conditions at night Part 2: Diagnosis of causation. Climatology, 31(2), 324–335. https://doi.org/10.1002/joc.2231
Boundary-Layer Meteorology, 56, 339–358. https://doi.org/10.1007/BF00119211 Turner, V. K., French, E. M., Dialesandro, J., Middel, A., Hondula, D. M., Ban-Weiss, G., &
Oke, T. R., Mills, G., Christen, A., & Voogt, J. A. (2017). Urban climates. Cambridge: Abdellati, H. (2022). How are cities planning for heat? Analysis of United States
Cambridge University Press. municipal plans. Environmental Research Letters, 17, Article 064054.
Park, C. Y., Lee, D. K., Krayenhoff, E. S., Heo, H. K., Hyun, J. H., Oh, K., & Park, T. Y. Vos, P. E. J., Maiheu, B., Vankerkom, J., & Janssen, S. (2013). Improving local air quality
(2019). Variations in pedestrian mean radiant temperature based on the spacing and in cities: To tree or not to tree? Environmental Pollution, 183, 113–122. https://doi.
size of street trees. Sustainable Cities and Society, 48(March), 1–9. https://doi.org/ org/10.1016/j.envpol.2012.10.021
10.1016/j.scs.2019.101521 Whyte, W. H. (1980). The social life of small urban spaces.
Picot, X. (2004). Thermal comfort in urban spaces: Impact of vegetation growth. Case Zheng, B., Bedra, K. B., Zheng, J., & Wang, G. (2018). Combination of tree configuration
study: Piazza della Scienza, Milan. Italy. Energy and Buildings, 36, 329–334. https:// with street configuration for thermal comfort optimization under extreme summer
doi.org/10.1016/j.enbuild.2004.01.044 conditions in the urban center of Shantou City. China. Sustainability, 10(11), 4192.
Shashua-Bar, L., Pearlmutter, D., & Erell, E. (2011). The influence of trees and grass on https://doi.org/10.3390/su10114192
outdoor thermal comfort in a hot-arid environment. International Journal of Ziter, C. D., Pedersen, E. J., Kucharik, C. J., & Turner, M. G. (2019). Scale-dependent
Climatology, 31, 1498–1506. https://doi.org/10.1002/joc.2177 interactions between tree canopy cover and impervious surfaces reduce daytime
Smithers, R. J., Doick, K. J., Burton, A., Sibille, R., Steinbach, D., Harris, R., … urban heat during summer. Proceedings of the National Academy of Sciences, 116(15),
Blicharska, M. (2018). Comparing the relative abilities of tree species to cool the 7575–7580. https://doi.org/10.1073/pnas.1817561116
18
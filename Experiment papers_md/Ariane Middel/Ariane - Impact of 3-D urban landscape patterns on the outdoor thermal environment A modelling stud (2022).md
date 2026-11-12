Impact of 3-D urban landscape patterns
on the outdoor thermal environment: a
modelling study with SOLWEIG
Article
Accepted Version
Kong, F., Chen, J., Middel, A., Yin, H., Li, M., Sun, T. ORCID:
https://orcid.org/0000-0002-2486-6146, Zhang, N., Huang, J.,
Liu, H., Zhou, K. and Ma, J. (2022) Impact of 3-D urban
landscape patterns on the outdoor thermal environment: a
modelling study with SOLWEIG. Computers, environment and
urban systems, 94. 101773. ISSN 0198-9715 doi:
10.1016/j.compenvurbsys.2022.101773 Available at
https://centaur.reading.ac.uk/103830/
It is advisable to refer to the publisher’s version if you intend to cite from the
work. See Guidance on citing .
To link to this article DOI: http://dx.doi.org/10.1016/j.compenvurbsys.2022.101773
Publisher: Elsevier
All outputs in CentAUR are protected by Intellectual Property Rights law,
including copyright law. Copyright and IPR is retained by the creators or other
copyright holders. Terms and conditions for use of this material are defined in
the End User Agreement .

www.reading.ac.uk/centaur
CentAUR
Central Archive at the University of Reading
Reading’s research outputs online

Title Page (with Author Details)
Impact of 3-D urban landscape patterns on the outdoor thermal environment：A
modelling study with SOLWEIG
Fanhua KONG*,1, Jianyu CHEN2, Ariane Middel3, Haiwei YIN4, Manchun LI1, Ting
SUN5, Ning Zhang6, Jing HUANG1, Hongqing LIU1, Kejing ZHOU1, Jinsong MA1
1 School of Geography and Ocean Science, Nanjing University, Xianlin Ave.163, 210023,
Nanjing, China
2 SPIC Energy Technology& Engineering Co., LTD, Tianlin Ave. 888#7, 200233, Shanhai,
China
3 School of Arts, Media and Engineering, Arizona State University, 950 S. Forest Mall,
Stauffer B258, 85281 Tempe, Arizona, USA
4 School of Architecture and Urban Planning, Nanjing University, No. 22, Hankou Road,
210093, Nanjing, China
5 Department of Meteorology, University of Reading, Reading RG6 6ET, UK
6 School of Atmospheric Sciences, Nanjing University, Xianlin Ave.163, 210023, Nanjing,
China

Manuscript (without Author Details) Click here to view linked References
1
2
3
4
5 1 Impact of 3-D urban landscape patterns on the outdoor thermal environment：A
6
7
2 modelling study with SOLWEIG
8
9
10
3 Abstract: With global warming and rapid urban growth, cities get warmer, which poses
11
12
13 4 additional stress on human thermal comfort and health. Complex three-dimensional (3D)
14
15
5 urban forms change radiation fluxes and shade patterns in cities, but most studies that link
16
17
18 6 urban form to thermal exposure have traditionally investigated the horizontal, two-
19
20 7 dimensional composition and configuration of urban landscapes. Supported by high-
21
22
8 precision airborne LiDAR data and IKONOS satellite data, this study calculates 3D urban
23
24
25 9 landscape metrics for central Nanjing, China, including vegetation above ground biomass
26
27
28 10 (AGB), building volume (V B ), standard deviation of building and vegetation heights (HSD B ,
29
30 11 HSD V ), the building normalized compactness radio (nCR), sky view factor (SVF), surface
31
32
12 roughness (SR), and shadow patterns (SP). Diurnal hourly mean radiant temperature (T mrt ) is
33
34
35 13 simulated using the UMEP (Urban Multi-scale Environmental Predictor) tool forced with
36
37 14 fixed-point observation data for a typical hot summer day. Correlation and multiple
38
39
40 15 regression analyses are conducted to investigate the relationship between the 3D form metrics
41
42 16 and T mrt and to identify key factors that influence the thermal environments. T mrt varies
43
44
17 spatially and diurnally and is strongly related to SP during the day, revealing the importance
45
46
47 18 of solar access for modulating the thermal environment. AGB is negatively, but SVF, SP, and
48
49
50 19 building nCR are positively correlated with daytime T mrt . At night, T mrt is more homogeneous
51
52 20 across space and mainly impacted by the urban fabric’s ability to lose heat. Open areas cool
53
54
21 faster than areas with low SVF and complex urban forms with high building nCR. Findings
55
56
57 22 from this study have great scientific and practical significance for optimizing urban landscape
58
59 23 patterns from a human-centered heat exposure perspective and will guide planning and
60
61
62
63
64
65
1

1
2
3
4 24 design strategies to promote thermally comfortable urban environments.
5
6
7 25 Keywords: Three-dimensional urban landscape metrics, urban thermal environment, mean
8
9
26 radiant temperature, LiDAR, UMEP
10
11
12 27
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
2

1
2
3
4 28 1. Introduction
5
6
7 29 Livability, health, and sustainable development of cities are key issues of the
8
9
30 Anthropocene in the face of climate change. Urbanization converts natural spaces into man-
10
11
12 31 made impervious spaces and meanwhile, building density and height increase continuously
13
14
32 as urban areas develop and expand. Changes in the composition and configuration of urban
15
16
17 33 landscapes directly affect the urban thermal environment, resulting in significant
18
19
34 intensification of the urban heat island (UHI) (Oke et al., 1981; Santamouris et al., 2014;
20
21
22 35 Solcerova et al., 2017). Additionally, with climate change, the intensity, duration, and
23
24 36 frequency of heat waves in cities increase, leading to a decrease in outdoor thermal comfort
25
26
37 and added heat stress on urban dwellers (Patz et al., 2005; Perkins et al., 2012; Li et al., 2020).
27
28
29
38 The main incoming energy source in the urban canopy layer is the solar radiation
30
31
32 39 received at the surface. The composition and configuration of three-dimensional (3D) urban
33
34
40 landscape patterns affect how much direct radiation enters an urban canyon, how it is
35
36
37 41 reflected, and how much heat is stored and emitted (Bonan, 2015, Zhu et al., 2020). In cities,
38
39
42 buildings are major urban landscape elements. Building volumes and materials and their
40
41
42 43 arrangement affect the thermal storage capacity and energy transmission processes of the city
43
44 44 (Salata et al., 2015). Differences in building height and density can cause multiple reflections
45
46
47 45 of sunlight irradiated on the building surface, causing reabsorption (Yang & Li, 2015; Ronchi
48
49 46 et al., 2020). Street morphology, especially the ratio of building height to street width (H/W
50
51
47 ratio), typically affects the radiative environment (Park et al., 2021). At night, heat is trapped
52
53
54 48 in narrow streets, thereby increasing air temperature, but more surface shading during the
55
56
49 day leads to cooling (Aboelata, 2020). Studies have also shown that the normalized
57
58
59 50 compactness ratio (nCR) (Bonczak & Kontokosta, 2019), sky view factor (SVF) (Middel et
60
61
62
63
64
65
3

1
2
3
4 51 al., 2018), urban shade (Hwang et al., 2011; Peters, 2016), and surface roughness
5
6
52 (Maragkogiannis et al., 2014; Zhang et al., 2018) affect the thermal environment.
7
8
9
53 Urban green spaces play a critical role in mitigating the UHI and regulating the thermal
10
11
12 54 environment. Previous studies have demonstrated that two-dimensional (2D) green space
13
14
55 metrics, such as area and shape of vegetation, affect the urban thermal environment; generally,
15
16
17 56 the larger the area is, the more pronounced the cooling effect (Kong et al., 2014; Motazedian
18
19
57 et al., 2020). Additionally, the three-dimensional (3D) characteristics of vegetation also
20
21
22 58 affect the thermal environment, creating a specific local microclimate (Chun & Guldmann,
23
24
59 2018; Zellweger et al., 2019; Zhang et al., 2019). Research has shown that the aboveground
25
26
27 60 biomass (AGB) of vegetation affects cooling (Chun & Guldmann, 2014). Leaves absorb part
28
29
61 of the incident solar radiation and convert a small part of the radiation energy into chemical
30
31
32 62 energy through photosynthesis, thereby reducing the ambient temperature (Rahman et al.,
33
34 63 2020). In addition, most of the radiant energy absorbed by vegetation is used for transpiration,
35
36
37 64 which cools the environment and increases humidity (Hsieh et al., 2018). Moreover, the
38
39 65 vegetation canopy shades ground surfaces and building façades, which reduces the
40
41
66 absorption of solar radiation in the urban fabric (Wong & Yu, 2005; Bowler et al., 2010;
42
43
44 67 Norton et al., 2015).
45
46
47 68 Outdoor human activities and health are mainly affected by urban near-surface
48
49
69 temperature and radiant flux densities the human body is exposed to. The mean radiation
50
51
52 70 temperature (T mrt ) refers to the shortwave and longwave radiation that irradiates a person
53
54
71 from all directions, including direct and reflected radiation. It is one of the most important
55
56
57 72 meteorological parameters regulating the human energy balance and human thermal comfort
58
59 73 (Thorsson et al., 2007; Middel et al., 2021). T mrt considers the radiative influence of ground
60
61
62
63
64
65
4

1
2
3
4 74 surfaces, building façades, and vegetation. It characterizes how a person perceives thermal
5
6
75 conditions more comprehensively than surface temperature or air temperature, especially
7
8
9 76 under hot conditions (Middel & Krayenhoff, 2019).
10
11
12 77 Most studies that investigate the impact of urban landscapes on temperatures are limited
13
14
78 to 2D (Amiri et al., 2009; Li et al., 2016). However, 2D urban landscape patterns fail to
15
16
17 79 represent the spatial heterogeneity of complex 3D structures, which may impact the thermal
18
19
80 capacity, thermal conductivity, and thermal radiation in complex built environments.
20
21
22 81 Additionally, it is difficult to scientifically guide real-world urban planning and development
23
24 82 based on research conclusions drawn from a 2D landscape perspective (Chen et al., 2014).
25
26
83 Therefore, 3D landscape patterns must be scientifically quantified to comprehensively assess
27
28
29 84 the impact of urban form on outdoor thermal environments.
30
31
32 85 In recent years, the rapid development of multisource remote sensing data, especially
33
34
86 LiDAR remote sensing technology, has provided important support for obtaining and
35
36
37 87 quantifying 3D urban landscape elements at fine scales. At the same time, advances in
38
39
88 numerical simulation models for multiscale thermal environments facilitate comprehensive
40
41
42 89 analyses of 3D urban morphological impacts on the thermal environment. Past LiDAR-based
43
44 90 urban form studies investigated vertical characteristics of urban landscapes by creating
45
46
47 91 metrics such as the average, minimum, and maximum height of buildings (Zimble et al., 2003;
48
49 92 Petras et al., 2017). At present, land cover composition and configuration studies that
50
51
93 consider height metrics still cannot fully reveal the impact of 3D urban form on the ability of
52
53
54 94 urban surfaces to receive and emit radiation, because they lack information on radiant fluxes
55
56
95 and shade. In addition, most studies focus on remotely sensed land surface temperature,
57
58
59 96 because fine-scale radiant flux densities are not readily available for cities. There is a lack of
60
61
62
63
64
65
5

1
2
3
4 97 research that investigates the influence of 3D urban landscape patterns on the thermal
5
6
98 environment from the perspective of outdoor thermal comfort.
7
8
9
99 This research gap has great scientific and practical significance for optimizing urban
10
11
12 100 landscape patterns from a human-centered heat exposure perspective. The present study
13
14
101 constructs 3D urban landscape metrics retrieved from high-resolution airborne LiDAR point
15
16
17 102 clouds coupled with numerical simulations of the radiant environment and shade to assess
18
19
103 the impact of 3D urban form on the summer thermal environment for central Nanjing, China.
20
21
22 104 Based on micrometeorological data from fixed-point observations, radiative fluxes and shade
23
24 105 patters are simulated with the urban multiscale environmental predictor (UMEP) model to
25
26
106 explore the thermal spatial heterogeneity and investigate its relationship with 3D urban form.
27
28
29 107 This study will guide the optimization of urban planning and development patterns to
30
31
108 alleviate urban heat.
32
33
34
109 2. Data and methods
35
36
37
110 2.1. Study area
38
39
40
111 The study was conducted in Nanjing, capital of the Jiangsu Province in China in the
41
42
43 112 west of the Yangtze Delta (Fig. 1). Nanjing has a subtropical monsoon climate with four
44
45
113 seasons and a hot and humid summer. The mean daily maximum temperature between June
46
47
48 114 and August is 31 °C (Nanjing Meteorological Bureau). The number of hot days per year and
49
50 115 the frequency of heat waves have been increasing, with 112 summer heat wave events
51
52
116 (defined as three consecutive days with temperature ≥35 °C) between 1951 and 2009 (Xu et
53
54
55 117 al., 2011; Kong et al., 2016). Nanjing has an urban built-up area of 971.62 km2 and a
56
57
118 population of 6,959,900. Spatial urbanization patterns are constantly changing due to
58
59
60 119 continuous horizontal and vertical urban growth. Nanjing has experienced outward
61
62
63
64
65
6

1
2
3
4 120 expansion at unprecedented rates along with vertical growth from infill development and
5
6
121 neighborhood transformations. As a result, building density (compactness) and height
7
8
9 122 variability have increased significantly and intensified the UHI effect.
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36 Fig.1 Land use /land cover, main parks and locations of the study area in Nanjing
37
38
39 123 2.2 UMEP tool and data processing
40
41
42 124 The UMEP tool is a plug-in for QGIS that can be used for various urban applications,
43
44
125 such as outdoor thermal comfort, energy consumption, and climate change adaptation on an
45
46
47 126 urban scale (Lindberg et al., 2018; Gabey et al., 2019). UMEP allows for interacting with
48
49
127 QGIS-based spatial information and using different data sources (Abbasabadi & Ashayeri,
50
51
52 128 2019; Fernández et al., 2021). This study uses the UMEP Urban Geometry module and the
53
54
129 Outdoor Thermal Comfort module to calculate SVF, SP, and T mrt for Nanjing. Based on the
55
56
57 130 2-m resolution DEM, high resolution T mrt maps are generated using SOLWEIG (SOlar and
58
59 131 LongWave Environmental Irradiance Geometry model). SOLWEIG is part of UMEP and
60
61
62
63
64
65
7

1
2
3
4 132 estimates shortwave and longwave radiation fluxes based on the urban geometry (eg. SVF)
5
6
133 (Lindberg et al., 2008; Ratti et al., 2006), vegetation, geographic information (latitude,
7
8
9 134 longitude, and elevation), and meteorological forcing data (direct and diffuse radiation,
10
11
135 global radiation, air temperature, and relative humidity).
12
13
14
15 136 To understand the spatiotemporal variation of T mrt in central Nanjing, this study selected
16
17 137 August 7, 2013 as simulation date, because weather conditions were typical of a clear, hot
18
19
138 summer day in Nanjing. Statistical analyses were conducted for six hours of the day: 10:00h,
20
21
22 139 12:00h, 14:00h, 16:00h, 20:00h, and 22:00h. To analyze the impact of 3D urban form on T mrt ,
23
24 140 the 2-m resolution UMEP output is aggregated to a 120-m grid. SPSS 26.0 was used to
25
26
141 conduct bivariate correlation analyses and stepwise multivariate linear regressions for the 3D
27
28
29 142 urban landscape metrics and T mrt to identify the key factors affecting the thermal environment.
30
31
32 143 2.3 Data sources and preprocessing
33
34
35 144 This study uses four data sources to determine 3D urban landscape metrics and T mrt for
36
37
145 central Nanjing: fixed-point weather station data, airborne LiDAR data, a national vector
38
39
40 146 dataset with detailed building footprints and land use/cover information (the second national
41
42
147 land resource survey was conducted between 2007 and 2009), and IKONOS remote sensing
43
44
45 148 images. The airborne LiDAR data were acquired by the City of Nanjing in April 2009 as part
46
47 149 of a municipal effort to build a geospatial database. The LiDAR data were pre-processed and
48
49
150 analyzed using the LiDAR360 software (GreenValley International Ltd 2019, Berkeley,
50
51
52 151 California). A high-resolution urban normalized digital surface model (nDSM) and digital
53
54
152 elevation model (DEM) were derived from the point cloud as basis for the 3D urban
55
56
57 153 landscape metrics. The national vector dataset was used as mask to extract the 3D urban
58
59
154 landscape metrics from LIDAR at 2-m resolution. High spatial resolution IKONOS remote
60
61
62
63
64
65
8

1
2
3
4 155 sensing images from 2009 served as virtual reference data to check the urban landscape
5
6
156 classification.
7
8
9
157 The UMEP model requires air temperature, relative humidity, and direct and diffuse
10
11
12 158 solar radiation to simulate T mrt . For meteorological forcing, hourly observations were
13
14
159 obtained from a weather station in Downtown Nanjing (Table 1) for 24 hours on August 7,
15
16
17 160 2013—a typical hot summer day with clear skies.
18
19
20 Table 1 Hourly meteorological observations to force the UMEP model, corresponding
21
22
sensors, and installation height.
23
24
25 Parameters Instruments Installation
26 Height (m)
27
pyranometer (4-Component net radiometer,
28 Net Radiation 1.5
CNR4, Campbell Scientific Inc., USA)
29
Long-wave pyranometer (4-Component net radiometer,
30
1.5
31 Radiation CNR4, Campbell Scientific Inc., USA)
32 EC150, Campbell
33 Latent Heat 1.5
Scientific Inc., USA
34
Relative temperature and RH probe (HMP155A, Scientific
35 4,9,18,36,72
36 Humidity Inc., USA)
37 2-D sonic Anemometers (010C and 020C,
Wind Speed 4,9,18,36,72
38
Campbell Scientific Inc., USA)
39
temperature and RH probe (HMP155A, Scientific
40 Air Temperature 4,9,18,36,72
41 Inc., USA)
42 Precipitation rain gage (TE525WS-L, Campbell, USA) 1
43
44 161
45
46
47 162 2.4 Three-dimensional urban landscape metrics
48
49
50 163 The IKONOS classified land cover data was intersected with the high-resolution nDSM
51
52 164 to generate a separate building nDSM (nDSM-B) and vegetation nDSM (nDSM-V) of central
53
54
55 165 Nanjing. The two surface models form the basis to calculate four 3D urban landscape metrics
56
57 166 on a 2-m × 2-m grid. Additional metrics are calculated using UMEP at a 2-m resolution. The
58
59
167 3D urban landscape metrics are then used in statistical analyses to assess the impact of 3D
60
61
62
63
64
65
9

1
2
3
4 168 urban form on the thermal environment.
5
6
7 169 2.4.1. Sky view factor (SVF)
8
9
10 170 The SVF, which is defined as the amount of visible sky in the upper hemisphere
11
12
171 (Johnson and Watson, 1984; Middel et al., 2018), is an important metric to quantify urban
13
14
15 172 morphology, because it modulates how much solar radiation enters and leaves an urban street
16
17
173 canyon. The SVF has been shown to impact air temperature (Oke, 1988; Chen et al., 2012),
18
19
20 174 ventilation (Grimmond and Oke, 1999), solar radiation, and T mrt (Lindberg & Grimmond,
21
22
175 2011; Middel et al., 2018). Kidd and Chapman (2012) were the first to propose generating
23
24
25 176 single-point and continuous SVFs based on high-resolution LiDAR data. In traditional SVF
26
27 177 calculations, vegetation information is either omitted, or simple models (e.g., rectangular
28
29
178 columns and ellipsoids) are used to replace trees, thereby posing a challenge to quantify the
30
31
32 179 impact of vegetation in detail. An et al. (2014) analyzed the impact of vegetation canopy on
33
34
180 SVF based on high-precision 3D point cloud (3DPC) data. The direct use of 3DPC to obtain
35
36
37 181 SVF can be computationally intensive, but derived products (DEM and DSM) can be used
38
39
182 instead (Zakšek et al., 2011). Continuous SVFs can be calculated using the preprocessing
40
41
42 183 module of the UMEP tool, which implements a shadow casting algorithm based on raster
43
44 184 data (Ratti and Richens, 1999). In this study, SVF data at 2-m resolution are obtained using
45
46
47 185 the high-resolution DSM of Nanjing.
48
49
50 186 2.4.2. Standard deviations for building and vegetation height
51
52
187 The vertical variability of an urban area can be quantified using the standard deviation
53
54
55 188 of the average building height (HSD B ) and vegetation height (HSD V ). Building height directly
56
57
189 influences the solar radiation received by an urban canyon, as it impacts SVF. Areas with
58
59
60 190 taller buildings and lower SVF have been shown to increase the nocturnal UHI (Oke, 1981;
61
62
63
64
65
10

1
2
3
4 191 Unger, 2009) but improve daytime thermal conditions due to shading (Ali-Toudert and Mayer,
5
6
192 2007; Middel et al., 2014; Mirzaee et al., 2018). Taller and larger trees increase canopy
7
8
9 193 coverage and shading of ground surfaces, thereby reducing the solar radiation absorbed by
10
11
194 the ground during the day and reducing surface temperature (Bowler et al., 2010).
12
13
14 195 Heterogeneous vertical urban forms increase roughness in the urban canopy layer, resulting
15
16
196 in more complex reflection and absorption of solar radiation. Considering the scale difference
17
18
19 197 of individual buildings and vegetation and the relatively large plane area of building roofs,
20
21
198 HSD B is calculated using a grid of 120-m with a resampling resolution of 2-m, and 𝐻𝑆𝐷 𝐵(𝑉) is
22
23
24 199 calculated as follows:
25
26
27 (𝐻 −𝐻̅ )2
28 200 HSD 𝐵(𝑉) = √∑𝑛 𝑖=1 𝐵(𝑉)𝑖 𝑛 𝐵(𝑉) （1）
29
30
31 201 where 𝐻𝑆𝐷 𝐵(𝑉) is the standard deviation of building and vegetation height, respectively;
32
33 202 𝐻 is the height of the sample within the unit area; 𝐻̅ is the average height of the unit
34 𝐵(𝑉)𝑖 𝐵(𝑉)
35
36 203 area; and n is the number of samples within the unit area.
37
38
39 204 2.4.3. Building volume (V B ) and aboveground biomass (AGB)
40
41
42 205 The building volume V B is correlated to the height and envelope of a structure. Tall
43
44 206 buildings are less likely to be shaded by other surrounding structures, thus they absorb more
45
46
47 207 solar radiation and have increased roof surface temperatures (Sharmin et al., 2012; Perini &
48
49 208 Magliocco, 2014; Shareef & Abu-Hijleh, 2020). Similarly, the size of the building envelope
50
51
209 affects the heat capacity of a building and determines the amount of heat it can store during
52
53
54 210 the day, affecting the UHI at night (Givoni, 1998). In turn, the AGB of vegetation impacts
55
56
57 211 evapotranspiration and shading (Michiles & Gielow, 2008). V B and AGB within the unit area
58
59 212 of a 2-m grid are calculated using the following equations:
60
61
62
63
64
65
11

 1
 2
 3
 4
| 213  |     |     |     | 𝑉 = 𝐻 | ×𝑆  |     |
| ---- | --- | --- | --- | ----- | --- | --- |
|  5   |     |     |     | 𝐵𝑖    | 𝐵𝑖  |     |
 6
|  7   |                                            |     |     |     | ×𝑆                                         （2）  |     |
| ---- | ------------------------------------------ | --- | --- | --- | ----------------------------------------------- | --- |
| 214  |                                        𝐴𝐺𝐵 |     |     | = 𝐻 |                                                 |     |
|  8   |                                            |     |     | 𝑖   | 𝑉𝑖                                              |     |
 9
215  where 𝑉  and 𝐴𝐺𝐵  are the V  and AGB within the ith unit area, 𝐻  is the raster elevation
| 10  | 𝐵𝑖  | 𝑖   | B   |     |     | 𝐵(𝑉)𝑖 |
| --- | --- | --- | --- | --- | --- | ----- |
11
12
216  of buildings (or vegetation) within the ith unit area, and  𝑆 is the base area of the unit area
13
14
| 15  217  (2-m × 2-m).  |     |     |     |     |     |     |
| ---------------------- | --- | --- | --- | --- | --- | --- |
16
17
| 18  218  2.4.4. Building compactness ratio (CR)  |     |     |     |     |     |     |
| ------------------------------------------------ | --- | --- | --- | --- | --- | --- |
19
20
21  219  The building compactness ratio (CR) is the ratio of building surface area to V B  within a
22
23
220  unit area and is a metric in building morphology that describes the complexity of building
24
25
26  221  structures. Subsequently, the normalized CR (nCR) is defined as the envelope surface area
27
28  222  per unit building volume. As a metric characterizing the complexity of building surface
29
30
31  223  structure, nCR is mostly applied in large-scale urban studies and rarely used as a landscape
32
| 33  224  metric parameter in urban thermal studies.  |     |     |     |     |     |     |
| ---------------------------------------------------- | --- | --- | --- | --- | --- | --- |
34
35
36  225   Thus far, the impact of compact development on the urban thermal environment has
37
38
226  been mostly studied in the context of land surface temperature (Li et al., 2016) but not with
39
40
41  227  respect to T . The normalized CR (nCR) is calculated based on CR using the following
mrt
42
43
| 228  equation (Bonczak & Kontokosta, 2019):  |     |     |     |     |     |     |
| -------------------------------------------- | --- | --- | --- | --- | --- | --- |
44
45
46
                                              （3）
| 229  |     | 𝐶𝑅  | = 𝑆  | ÷𝑉  |     |     |
| ---- | --- | --- | ---- | --- | --- | --- |
| 47   |     |     | 𝑖 𝑒𝑖 | 𝐵𝑖  |     |     |
48
| 49   |     |     |       | 𝐶𝑅         | 𝑆                     |     |
| ---- | --- | --- | ----- | ---------- | --------------------- | --- |
| 230  |     | 𝑛𝐶𝑅 | =     | 𝑖          | = 𝑒𝑖             （4）  |     |
|      |     |     | 𝑖 ((3 | 2          | (3 2                  |     |
| 50   |     |     |       | √𝑉 ) ×5)÷𝑉 | √𝑉 ) ×5               |     |
|      |     |     |       | 𝐵𝑖         | 𝐵𝑖 𝐵𝑖                 |     |
51
52
231  Where 𝐶𝑅  is the building compactness ratio and  𝑛𝐶𝑅  is normalized within the ith 120-m
| 53  | 𝑖   |     |     |     | 𝑖   |     |
| --- | --- | --- | --- | --- | --- | --- |
54
55  232  grid respectively;  𝑆  is the building envelope surface area and V Bi  is V B  within the ith 120-
𝑒𝑖
56
57
233  m grid; building envelope surface area of each 2-m × 2-m grid 𝑆  was computed using the
| 58  |     |     |     |     |     | 𝑒2  |
| --- | --- | --- | --- | --- | --- | --- |
59
| 60  234  following equation:  |     |     |     |     |     |     |
| ----------------------------- | --- | --- | --- | --- | --- | --- |
61
62
63
64
65
12

1
2
3
4 235 𝑆 = 𝑆 (5)
5 𝑒2 ⁄ cos([𝑆𝑙𝑜𝑝𝑒]× 𝜋 ⁄ )
180
6
7
8 236 Where S is the area of the 2-m grid, and 𝑠𝑙𝑜𝑝𝑒 can be computed based on nDSM-B using the
9
10
237 ArcGIS 3D Analyst extension (Vers. 10.5) (ESRI, Redlands, CA, USA) and the 𝑆 then be
11 𝑒𝑖
12
13 238 statistically computed using the “zonal statistics” (Zhang et al., 2011; Jenness, 2004).
14
15
16 239 2.4.5. Daily Shadow Patterns (SP)
17
18
19 240 The daily shadow pattern (SP) is a shade metric that changes with the position of the
20
21
241 sun in the sky (azimuth and zenith angles). The shadow patterns on the ground originate from
22
23
24 242 DSM of buildings, topography, trees and bushes using the Shadow generator plugin, and the
25
26 243 position of the sun is calculated using PySolar, a python library for various sun related
27
28
244 applications (Lindberg & Grimmond, 2011; Lindberg et al., 2018). The SP characterizes the
29
30
31 245 direct solar radiation received by an area at a specific time of day, day of the year, and
32
33
246 geographic location depending on the surrounding urban form. The amount of direct
34
35
36 247 incoming solar radiation is a main driver of T mrt during the day (Middel & Krayenhoff, 2019;
37
38
248 Peeters et al., 2020). SP can have three transmittance values: 0 (completely shaded, e.g., by
39
40
41 249 a building), 1 (completely sun-exposed), and 0.03 (shaded by vegetation). In this study, a SP
42
43 250 map is produced in the UMEP SOLWEIG Analyzer using the 2-m resolution DSM.
44
45
46 251 2.4.6. Surface roughness (SR)
47
48
49 252 Buildings and vegetation create a rough surface in the urban canopy layer (Oke, 1989).
50
51
253 Heterogeneous vertical urban forms increase surface roughness (SR), which impacts
52
53
54 254 turbulence and ventilation (Barlow, 2014). The SR is an index to measure the surface
55
56
255 (including building and vegetation) texture or fluctuation, which has been used in air quality
57
58
59 256 and meteorological models to account for enhanced mixing and the drag effects of the
60
61
62
63
64
65
13

1
2
3
4 257 underlying surface and measured in different way (Duan & Takemi, 2021; Nield et al., 2013;
5
6
258 Grimmond & Oke, 1999). The higher SR, the greater the resistance to wind, which impedes
7
8
9 259 the flow of energy. SR is calculated as the ratio of the surface area per unit building or
𝑖
10
11
260 vegetation envelope surface area 𝑆 to the corresponding vertical projected area (𝑆 ) (unit
12 𝑒𝑖 𝑝𝑖
13
14 261 area size 120-m × 120-m):
15
16
17 𝑆
262 𝑆𝑅 = 𝑒𝑖 （6）
18 𝑖 𝑆
𝑝𝑖
19
20
21 263 Where 𝑆𝑅 is the surface roughness, 𝑆 is the envelope surface area which can be computed
𝑖 𝑒𝑖
22
23
264 according to equation (5), and 𝑆 is vertical projected planimetric area within the ith 120-m
24 𝑝𝑖
25
26 265 grid.
27
28
29 266 3. Results
30
31
32 267 3.1 Urban landscape pattern characteristics
33
34
35 268 3.1.1 Three-dimensional characteristics of vegetation and buildings
36
37
38 269 The AGB of vegetation in central Nanjing varies significantly (Fig 2(a)). Areas with
39
40
270 high AGB are mainly clustered in parks (Fig 2(a), ①-⑤), especially at Purple Mountain (Fig
41
42
43 271 2(a), ①), a remnant hilly landscape with high vegetation cover and dense forest. In contrast,
44
45
46 272 the southwestern Hexi New District—a newly urbanized area with little vegetation—has
47
48
273 much lower AGB (Fig 2(a), I). Areas with high AGB also exhibit greater vertical variability.
49
50
51 274 HSD is largest at the park area, which are natural forest areas in the city with diverse
𝑉
52
53
275 vegetation, mixed forest, shrubs, and grass (Fig 2(b), ①-⑤). HSD is also large on both sides
54 𝑉
55
56 276 of the streets in the Xinjiekou-Laomendong area (Fig 2(b), II- IV), which is the Old Town of
57
58
277 Nanjing. Street trees are dominated by Platanus orientalis Linn trees and well-growing
59
60
61
62
63
64
65
14

1
2
3
4 278 shrubs and grasses. The Hexi New District (Fig 2(b), I) encompasses new residential and
5
6
7 279 commercial areas in the southwestern part of the study area that generally have low HSD 𝑉 .
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
Fig 2 Aboveground biomass AGB and standard deviation of vegetation height 𝐻𝑆𝐷 across
29 𝑉
30
31 Nanjing; a) Purple Mountain Park①, Jubao Mountain Park②, Shitoucheng Park ③,
32
33
34 Qingliang Mountain Park④, Yuhuatai Scenic area⑤; b) Hexi new district(I), Xinjiekou-
35
36
Laomendong(II- IV).
37
38
39
40 280 V B gradually decreases from the city center to the periphery of the study area. V B is
41
42 281 highest in the central business district (CBD) of Nanjing between Xinjiekou (II) and
43
44
282 Fuzimiao-Laomendong (Fig 3(a), III-IV). The CBD further exhibits a large variability in
45
46
47 283 building heights (Fig. 3(b), II-IV). HSD is also elevated in commercial areas and in newly
𝐵
48
49
284 developed areas, such as the Hexi New Town area (Fig. 3(b), I), which is currently the
50
51
52 285 subcenter of Nanjing.
53
54
55 286 The downtown area near the Qinhuai River, Xuanwu Lake, and Purple Mountain Park
56
57 287 are dense areas with high nCR (Fig. 3(c)). These districts have experienced constant urban
58
59
288 redevelopment and infill over time. Buildings with various uses and styles lead to complex
60
61
62
63
64
65
15

1
2
3
4 289 urban morphology and high nCR. SR is larger in the urban center Xinjiekou (Fig. 3(d), II)
5
6
290 and Fuzimiao-Laomendong (Fig. 3(d), III-IV) than in the surrounding areas and smaller in
7
8
9 291 natural areas and over water bodies (Fig. 3(d)), consistent with the distribution of dense built-
10
11
292 up areas.
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
Fig 3 a) Distribution of building volume 𝑉 , Xinjiekou (II) and Fuzimiao-Laomendong (III-
54 𝐵
55
56 IV); b) standard deviation of building height 𝐻𝑆𝐷 , Hexi New District (I), Xinjiekou-
𝐵
57
58
Laomendong (II- IV); c) Building compactness ratio, 𝑛𝐶𝑅(c) and d) Surface roughness, 𝑆𝑅 .
59
60
61
62
63
64
65
16

1
2
3
4 293 3.1.2 Sky view factor (SVF)
5
6
294 The study area has an average SVF of 0.59. Open water bodies such as the Yangtze River
7
8
9 295 and Xuanwu Lake have a SVF of 1, while forested areas such as Purple Mountain Park①
10
11
12 296 and Jubao Mountain Park②, Yuhuatai Scenic Area ⑤, and the Nanjing Green Expo Park⑥
13
14
297 (Fig. 4) have a SVF of 0 or near 0 due to dense tree cover. The Old Town of Nanjing has
15
16
17 298 dense buildings and a reduced SVF of generally less than 0.6, such as the Laomendong area
18
19
299 (Fig. 4, IV). The SVF value of building roof varies with the height of the surrounding
20
21
22 300 buildings in the area. In areas with similar building heights, the roof SVF is close to 1, while
23
24
301 in areas with high HSD , the roof SVF is less than 1, e.g., in Xinjiekou (Fig. 4, II).
25 𝐵
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53 Fig. 4 Pattern of the SVF calculated using the UMEP model, Purple Mountain Park① and
54
55
Jubao Mountain Park②, Yuhuatai Scenic Area⑤, and the Nanjing Green Expo Park⑥,
56
57
58 Laomendong area (IV), Xinjiekou (II)
59
60
61
62
63
64
65
17

1
2
3
4 302 3.2 Spatiotemporal shadow patterns (SP)
5
6
7 303 Hourly shadow simulations for August 7, 2013 illustrate how shade travels throughout
8
9
304 the day. Minimum shading occurs at noon when the solar elevation angle is largest. Tree-
10
11
12 305 covered areas such as Purple Mountain Park are shaded throughout the day independent of
13
14
306 the sun’s position. In built-up areas, SP changes with solar elevation angle and building
15
16
17 307 arrangement (Fig. 5). At 10:00h, shadows are to the west; at 12:00h, shadows are to the north;
18
19
308 and at 14:00h and 16:00h, shadows are to the northeast and east, respectively. A comparison
20
21
22 309 of SP maps at 10:00h and 14:00h reveals an asymmetrical shade pattern. Despite similar solar
23
24 310 elevation angles, the heterogeneous urban form results in 30% shade coverage at 10:00h and
25
26
311 22% at 14:00h.
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
18

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37 Fig. 5: Shadow pattern (SP) maps of the Xinjiekou area (II) for select times of day: 10:00h,
38
39
12:00h, 14:00h, and 16:00h local time. Pixels denote shaded areas (0), sun-exposed areas (1),
40
41
42 and areas shaded by vegetation (0.03).
43
44
45
46
47 312 3.3 Spatiotemporal T mrt patterns and characteristics
48
49 313 Simulated T mrt that is spatially averaged over the study area peaks at 61.4 ℃ at 14:00h
50
51
52 314 and then decreases gradually (Fig. 6, Table 2). The highest T mrt value across space and time
53
54 315 is found at 12:00h (78.57 ℃). The standard deviation of T mrt decreases as the day progresses,
55
56
316 and stabilizes at around 2.3 ℃ after sunset, indicating that the thermal environment becomes
57
58
59 317 more homogeneous across sites.
60
61
62
63
64
65
19

 1
 2
 3
 4
318  The Purple Mountain Park and surrounding areas maintain relatively stable thermal patterns
 5
 6
319  with low T  values in green spaces. During the day, built-up areas experience a T  increase
|  7  | mrt |     |     |     | mrt |
| --- | --- | --- | --- | --- | --- |
 8
 9  320  between 10:00h and 12:00h when shade is minimal. In contrast, impervious surfaces are
10
11
321  mostly shaded by buildings in the afternoon, which reduces direct solar radiation and heat
12
13
14  322  storage (e.g., in the Xinjiekou area (II)). However, over extensive impervious surfaces with
15
16
little vegetation such as parking lots and wide streets with low-rise buildings, T  is elevated,
| 323  |     |     |     |     | mrt |
| ---- | --- | --- | --- | --- | --- |
17
18
19  324  e.g.,  in  the  Purple  Mountain  to  the  northeast  and  Hexi  New Town  to  the  southwest.
20
21  Neighborhoods with forest cover exhibit lower T  in the afternoon.
| 325  |     |     |     | mrt |     |
| ---- | --- | --- | --- | --- | --- |
22
23
326  The minimum and maximum nocturnal T  is 29.8 °C and 38.5 °C respectively (Table
| 24  |     |     | mrt |     |     |
| --- | --- | --- | --- | --- | --- |
25
26  2). The nocturnal average T  varies slightly. The T  is lower for areas with high SVF (open
| 327  |     | mrt |     | mrt |     |
| ---- | --- | --- | --- | --- | --- |
27
28
328  areas) than for densely built-up and vegetated areas. This is inverse to the thermal daytime
29
30
31  pattern. At night, the longwave radiation emitted from the ground is trapped in densely built-
329
32
33
330  up areas, which results in elevated T  after sunset. At the same time, thermal patterns are
| 34  |     |     | mrt |     |     |
| --- | --- | --- | --- | --- | --- |
35
more homogeneous and T  differences are smaller across space due to the absence of
| 36  331  |     | mrt |     |     |     |
| -------- | --- | --- | --- | --- | --- |
37
38
| 332  incoming shortwave radiation.  |     |     |     |     |     |
| ----------------------------------- | --- | --- | --- | --- | --- |
39
40
41
|     | Table 2  Differences in simulated T |            |  at different times of day.  |          |          |
| --- | ----------------------------------- | ---------- | ---------------------------- | -------- | -------- |
| 42  |                                     |            | mrt                          |          |          |
| 43  | Time                                | Mean (°C)  | Max (°C)                     | Min(°C)  | SD (°C)  |
44
|     |        |        | 72.97  | 37.73  | 12.05  |
| --- | ------ | ------ | ------ | ------ | ------ |
| 45  | 10:00  | 56.53  |        |        |        |
46
|     | 12:00  | 60.90  | 78.57  | 39.97  | 12.06  |
| --- | ------ | ------ | ------ | ------ | ------ |
47
| 48  | 14:00  | 61.39  | 77.68  | 41.62  | 11.79  |
| --- | ------ | ------ | ------ | ------ | ------ |
49
|     |        |        | 69.09  | 41.32  | 9.45  |
| --- | ------ | ------ | ------ | ------ | ----- |
|     | 16:00  | 55.53  |        |        |       |
50
| 51  | 20:00  | 33.28  | 38.49  | 30.70  | 2.29  |
| --- | ------ | ------ | ------ | ------ | ----- |
52
|     |        |        | 37.59  | 29.82  | 2.28  |
| --- | ------ | ------ | ------ | ------ | ----- |
| 53  | 22:00  | 32.39  |        |        |       |
54
| 55  333  |     |     |     |     |     |
| -------- | --- | --- | --- | --- | --- |
56
57
| 334  |     |     |     |     |     |
| ---- | --- | --- | --- | --- | --- |
58
59
| 60  335  |     |     |     |     |     |
| -------- | --- | --- | --- | --- | --- |
61
62
63
64
65
20

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
Fig. 6 T distribution (2-m resolution) in central Nanjing for August 7, 2013 at 10:00h,
32 mrt
33
34 12:00h, 14:00h, 16:00h, 20:00h and 22:00h.
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56 Fig. 7 Distribution of T differences (ΔT ) (a) difference in 14:00h - 20:00h and (b)
mrt mrt
57
58
difference in 20:00h - 22:00h to indicate cooling rates.
59
60
61
62
63
64
65
21

1
2
3
4 336 Fig. 7 shows the distribution of T mrt differences (a) difference in 14:00h - 20:00h and (b)
5
6
7 337 difference in 20:00h - 22:00h to indicate cooling rates. ΔT mrt is largest between 14:00h and
8
9 338 20:00h with a temperature difference of 45.3°C. Locations covered with water or vegetation
10
11
12 339 showed a slightly lower change compared with built-up areas. The change in T mrt after sunset
13
14 340 is minimal (<1 °C), because T mrt variability is mainly driven by solar radiation, which is
15
16
341 absent at night. Radiative cooling rates after sunset are mainly driven by longwave radiation
17
18
19 342 emitted from hot surfaces that retained heat.
20
21
22 343 3.4 Impact of 3-D urban landscape patterns on mean radiant temperature (T mrt )
23
24
25 344 A bivariate correlation analysis is performed to investigate the correlation between each
26
27 345 metric and T mrt (Table 3). After investigating multicollinearity, a stepwise multiple regression
28
29
30 346 analysis is conducted to identify key factors that affect T mrt (Table 4). Results from the
31
32 347 bivariate correlation analysis show that all landscape indices have a significant relationship
33
34
35 348 with T mrt (p < 0.01) (Table 3). During the day, all vegetation metrics (AGB, HSD v ) are
36
37 349 negatively correlated with T mrt , while at night, the relationship is reversed. In contrast, all
38
39
350 building metrics (V , HSD , nCR) and the vegetation and building-related integrated metrics
40 B B
41
42 351 ( n CR, SR, SVF) show positive correlations with T mrt , while at night, the reverse applies. The
43
44 352 SP is positively correlated with T mrt during the day; there is no SP at night.
45
46
47 353 The negative daytime correlation between vegetation metrics and T mrt indicates cooling
48
49
354 benefits of green infrastructure. The correlation is strongest at 12:00h and 14:00h when
50
51
52 355 incoming solar radiation is near its peak and average T mrt is largest (Table 2). The positive
53
54
55 356 correlation of vegetation metrics and T mrt at night combined with low SVF values in densely
56
57 357 forested areas illustrates longwave radiation trapping as found by several authors (Oke, 1989;
58
59
358 Colter et al., 2019; Middle et al., 2021)
60
61
62
63
64
65
22

 1
 2
 3
 4
359  The correlation between building-related landscape metrics (V , HSD , nCR) and T mrt  is
B B
 5
 6
360  strongest at peak T (at 12:00h and 14:00h). nCR is most significantly correlated with T .
|  7  |     | mrt  |     |     |     |     | mrt |
| --- | --- | ---- | --- | --- | --- | --- | --- |
 8
 9  361  Among the vegetation and building-related integrated metrics, SP shows a very strong
10
11
362  positive correlation with T during daytime; SR is positively and negatively correlated with
| 12  |     |     | mrt  |     |     |     |     |
| --- | --- | --- | ---- | --- | --- | --- | --- |
13
14  363  T  during the day and at night, respectively. SVF and SP have the highest correlation with
mrt
15
16
T  among all landscape metrics, because they characterize how much direct solar radiation
| 364  | mrt |     |     |     |     |     |     |
| ---- | --- | --- | --- | --- | --- | --- | --- |
17
18
| 19  365  | an urban surface can receive.  |     |     |     |     |     |     |
| -------- | ------------------------------ | --- | --- | --- | --- | --- | --- |
20
21
22  Table 3 Bivariate correlations between 3D landscape indices and T mrt
23
Data  T _1000D  T _1200D  T _1400D  T _1600D  T _2000N  T _2200N
| 24  |     | mrt | mrt | mrt | mrt | mrt | mrt |
| --- | --- | --- | --- | --- | --- | --- | --- |
25
AGB  -0.550**  -0.452**  -0.484**  -0.529**  0.579**  0.579**
26
27
HSD v   -0.286**  -0.157**  -0.200**  -0.293**  0.307**  0.307**
28
|     | V   | 0.199**  | 0.398**  | 0.334**  | 0.146**  | -0.178**  | -0.178**  |
| --- | --- | -------- | -------- | -------- | -------- | --------- | --------- |
| 29  | B   |          |          |          |          |           |           |
30
HSD   0.184**  0.377**  0.313**  0.132**  -0.175**  -0.175**
| 31  | B    |          |          |          |          |           |            |
| --- | ---- | -------- | -------- | -------- | -------- | --------- | ---------- |
|     |      | 0.349**  | 0.552**  | 0.489**  | 0.310**  | -0.311**  | -0. 311**  |
| 32  | nCR  |          |          |          |          |           |            |
33
|     | SR  | 0.188**  | 0.412**  | 0.338**  | 0.125**  | -0.155**  | -0.155**  |
| --- | --- | -------- | -------- | -------- | -------- | --------- | --------- |
34
35  SVF  0.786**  0.577**  0.650**  0.766**  -0.851**  -0.851**
36
|     | SP_1000D  | 0.875**  | /   | /   | /   | /   | /   |
| --- | --------- | -------- | --- | --- | --- | --- | --- |
37
38
|     | SP_1200D  | /   | 0.693**  | /   | /   | /   | /   |
| --- | --------- | --- | -------- | --- | --- | --- | --- |
39
| 40  | SP_1400D  | /   | /   | 0.744**  | /   | /   | /   |
| --- | --------- | --- | --- | -------- | --- | --- | --- |
41
|     | SP_1600D  | /   | /   | /   | 0.818**  | /   | /   |
| --- | --------- | --- | --- | --- | -------- | --- | --- |
42
| 43  366  | Note: Significance level: ** p < 0.01  |     |     |     |     |     |     |
| -------- | -------------------------------------- | --- | --- | --- | --- | --- | --- |
44
45
46  367  SP is collinear with SVF with a variance inflation factor (VIF) greater than 10 (with
47
48
368  n  >  10000). At the same time, shade only existed during the day, so the SP variable is
49
50
subsequently  excluded  from  the  multiple  regression  analysis.  Table  4  summarizes  the
51  369
52
53
370  regression standardized coefficients between the 3-D urban landscape metrics and T
mrt
54
55
|          | showing a significant relationship (P < 0.01, except HSD |     |     |     | at 10:00h).  |     |     |
| -------- | -------------------------------------------------------- | --- | --- | --- | ------------ | --- | --- |
| 56  371  |                                                          |     |     |     | v            |     |     |
57
58
372  SVF, building nCR, and AGB are three important time-invariant factors governing
59
60
61
62
63
64
65
23

1
2
3
4 373 outdoor T mrt . SVF and building nCR have a significant warming effect on the local thermal
5
6
374 environment in areas with high metric values that affect the radiation received and emitted
7
8
9 375 by urban surfaces during the day.
10
11
12 376 SVF as a vegetation and building-related metric has the strongest positive daytime and
13
14
15 377 negative nighttime impact on T mrt . During the day, increasing building or vegetation height
16
17 378 increases shade, therefore reducing heat storage of surfaces in the urban canyon. However, it
18
19
379 also leads to more trapping of outgoing radiation at night. Open areas have a stronger ability
20
21
22 380 to lose heat and lower T mrt . Lastly, areas with little obstruction to air circulation also have
23
24 381 lower T mrt due to faster heat loss. The daytime vs. nighttime impacts of SVF require further
25
26
382 investigation by considering the diurnal microclimate and solar altitude.
27
28
29
383 Higher nCR indicates compact buildings and larger building envelopes per volume. The
30
31
32 384 building envelope, when its outer surface is heated by solar radiation to exceed the air
33
34
385 temperature of the surrounding environment, will exchange heat with the environment
35
36
37 386 through convection and longwave radiation, causing the surrounding temperature and T mrt to
38
39
387 rise (Givoni, 1998). After sunset, T mrt decreases with increasing nCR, indicating that areas
40
41
42 388 with complex building morphology cool faster than areas with low nCR values.
43
44
45 389 AGB is negatively correlated with T mrt, during the day, revealing that urban green spaces
46
47 390 play an important role in regulating the outdoor thermal environment. AGB affects T mrt during
48
49
391 the day by converting sensible heat into latent heat and by preventing the ground from
50
51
52 392 absorbing solar radiation, resulting in lower temperatures in areas with high metric values,
53
54
393 however, at night, higher AGB will contribute to heat trapping, which produces a mild
55
56
57 394 warming effect and leads to a positive correlation with T mrt .
58
59
60
61
62
63
64
65
24

 1
 2
 3
 4
Table 4 Results of the multi-variate linear stepwise regression between urban multi-
 5
 6
dimensional landscape indices and T  after eliminating collinear variables.
|  7  |     |     | mrt |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
 8
|  9  |        |     | Unstandardized  |     | Standardized  |     |       |
| --- | ------ | --- | --------------- | --- | ------------- | --- | ----- |
| 10  |        |     | Coefficients    |     | Coefficients  |     |       |
|     | Model  |     |                 |     |               | t   | Sig.  |
11
|     |     |     | B   | Std. Error  | Beta  |     |     |
| --- | --- | --- | --- | ----------- | ----- | --- | --- |
12
Dependent Variable:  (Constant)  38.140  0.171  --  223.599  0.000
13
|     | T _1000D  | AGB  | -0.120  | 0.008  | -0.095  | -15.569  | 0.000  |
| --- | --------- | ---- | ------- | ------ | ------- | -------- | ------ |
| 14  | mrt       |      |         |        |         |          |        |
15  Adjusted R2=0.809  HSD   0.074  0.032  0.013  2.320  0.020
v
16
|     |     | nCR  | 4.011  | 0.065  | 0.343  | 61.941  | 0.000  |
| --- | --- | ---- | ------ | ------ | ------ | ------- | ------ |
| 17  |     | SR   | 1.197  | 0.089  | 0.114  | 20.230  | 0.000  |
18
|     |     | SVF  | 22.087  | 0.154  | 0.788  | 143.045  | 0.000  |
| --- | --- | ---- | ------- | ------ | ------ | -------- | ------ |
19
Dependent Variable:  (Constant)  38.954  0.315  --  123.555  0.000
20
|     | T _1200D  | AGB  | -0.157  | 0.011  | -0.104  | -14.773  | 0.000  |
| --- | --------- | ---- | ------- | ------ | ------- | -------- | ------ |
| 21  | mrt       |      |         |        |         |          |        |
Adjusted R2=0.744
| 22  |     | HSD v   | 0.300  | 0.044  | 0.043  | 6.868  | 0.000  |
| --- | --- | ------- | ------ | ------ | ------ | ------ | ------ |
| 23  |     | V       | 0.025  | 0.006  | 0.046  | 4.030  | 0.000  |
B
| 24  |     | nCR  | 6.260  | 0.089  | 0.453  | 70.173  | 0.000  |
| --- | --- | ---- | ------ | ------ | ------ | ------- | ------ |
| 25  |     | SR   | 3.634  | 0.232  | 0.195  | 15.658  | 0.000  |
26
|     |     | SVF  | 20.404  | 0.213  | 0.614  | 95.763  | 0.000  |
| --- | --- | ---- | ------- | ------ | ------ | ------- | ------ |
27
Dependent Variable:  (Constant)  40.808  0.292  --  139.787  0.000
28
|     | T _1400D           | AGB   | -0.140  | 0.010  | -0.098  | -14.269  | 0.000  |
| --- | ------------------ | ----- | ------- | ------ | ------- | -------- | ------ |
| 29  | mrt                |       |         |        |         |          |        |
|     | Adjusted R2=0.754  | HSD   | 0.215   | 0.041  | 0.032   | 5.270    | 0.000  |
| 30  |                    | v     |         |        |         |          |        |
| 31  |                    | V     | 0.023   | 0.006  | 0.044   | 3.940    | 0.000  |
B
|     |     | nCR  | 5.543  | 0.083  | 0.424  | 67.107  | 0.000  |
| --- | --- | ---- | ------ | ------ | ------ | ------- | ------ |
32
| 33  |     | SR   | 2.687   | 0.215  | 0.153  | 12.503   | 0.000  |
| --- | --- | ---- | ------- | ------ | ------ | -------- | ------ |
| 34  |     | SVF  | 21.213  | 0.197  | 0.676  | 107.523  | 0.000  |
35  Dependent Variable:  (Constant)  42.645  0.123  --  346.541  0.000
| 36  | T _1600D  | AGB  | -0.096  | 0.007  | -0.092  | -14.613  | 0.000  |
| --- | --------- | ---- | ------- | ------ | ------- | -------- | ------ |
mrt
37
|     | Adjusted R2=0.737  | HSD   | 0.040  | 0.005  | 0.048  | 7.933   | 0.000  |
| --- | ------------------ | ----- | ------ | ------ | ------ | ------- | ------ |
| 38  |                    | B     |        |        |        |         |        |
|     |                    | nCR   | 3.343  | 0.057  | 0.349  | 58.928  | 0.000  |
39
|     |     | SVF  | 17.219  | 0.146  | 0.749  | 118.103  | 0.000  |
| --- | --- | ---- | ------- | ------ | ------ | -------- | ------ |
40
41  Dependent Variable:  (Constant)  36.874  0.037  --  990.239  0.000
| 42  | T _2000N  | AGB  | 0.025  | 0.001  | 0.096  | 20.870  | 0.000  |
| --- | --------- | ---- | ------ | ------ | ------ | ------- | ------ |
mrt
Adjusted R2=0.889
| 43  |     | HSD v   | -0.028  | 0.005  | -0.024  | -5.716  | 0.000  |
| --- | --- | ------- | ------- | ------ | ------- | ------- | ------ |
| 44  |     | V       | 0.005   | 0.001  | 0.058   | 6.431   | 0.000  |
B
45
|     |     | HSD   | -0.029  | 0.002  | -0.140  | -15.160  | 0.000  |
| --- | --- | ----- | ------- | ------ | ------- | -------- | ------ |
| 46  |     | B     |         |        |         |          |        |
|     |     | nCR   | -0.744  | 0.010  | -0.316  | -74.391  | 0.000  |
47
|     |     | SR  | -0.111  | 0.029  | -0.035  | -3.869  | 0.000  |
| --- | --- | --- | ------- | ------ | ------- | ------- | ------ |
48
|     |     | SVF  | -4.797  | 0.024  | -0.850  | -201.526  | 0.000  |
| --- | --- | ---- | ------- | ------ | ------- | --------- | ------ |
49
Dependent Variable:  (Constant)  35.927  0.037  --  968.860  0.000
50
T _2200N
| 51  | mrt | AGB  | 0.025  | 0.001  | 0.096  | 20.869  | 0.000  |
| --- | --- | ---- | ------ | ------ | ------ | ------- | ------ |
52  Adjusted R2=0.889  HSD   -0.028  0.005  -0.024  -5.715  0.000
v
53
|     |     | V   | 0.005  | 0.001  | 0.058  | 6.430  | 0.000  |
| --- | --- | --- | ------ | ------ | ------ | ------ | ------ |
B
54
|     |     | HSD   | -0.029  | 0.002  | -0.140  | -15.160  | 0.000  |
| --- | --- | ----- | ------- | ------ | ------- | -------- | ------ |
| 55  |     | B     |         |        |         |          |        |
|     |     | nCR   | -0.742  | 0.010  | -0.316  | -74.389  | 0.000  |
56
| 57  |     | SR   | -0.111  | 0.029  | -0.035  | -3.868    | 0.000  |
| --- | --- | ---- | ------- | ------ | ------- | --------- | ------ |
| 58  |     | SVF  | -4.784  | 0.024  | -0.850  | -201.561  | 0.000  |
59
| 395  |     |     |     |     |     |     |     |
| ---- | --- | --- | --- | --- | --- | --- | --- |
60
61
62
63
64
65
25

1
2
3
4 396 4. Discussion
5
6
7 397 4.1 Advancing urban thermal management and planning by coupling 3-D morphology
8
9
398 with numerical model
10
11
12
399 Urban morphology created by buildings, vegetation, and other urban landscape elements
13
14
15 400 influences the thermal environment (Oke, 1989). Areas with high AGB and HSD V values are
16
17
401 mostly located in parks and natural areas. In the city, 3-D vegetation patterns follow the age
18
19
20 402 of urban developments, with higher AGB and HSD V values in the Old Town of Nanjing and
21
22
403 lower AGB and HSD V values in new developments. High-density built-up areas are mainly
23
24
25 404 located near the Qinhuai River-Xuanwu Lake-Purple Mountain with high V B and HSD B
26
27 405 values. College Town and Old Town in the city center exhibit high building nCR; the
28
29
406 university and Old Town mostly have old, low-rise buildings, but new higher buildings have
30
31
32 407 been added for infill development. The distribution of SR is consistent with that of densely
33
34
408 built-up urban areas. The areas with low SVF (smaller than 0.6) are mainly distributed in the
35
36
37 409 densely built-up Xinjiekou-Laomendong areas (Fig 1, Fig 4), where both the compact
38
39
410 building arrangement and large building height reduce the SVF in street canyons. The SVF
40
41
42 411 of highly vegetated areas is also relatively low. The SVF of building roofs is high in areas
43
44 412 with low HSD B . Shadow patterns are influenced by the solar elevation angle and building
45
46
47 413 arrangement, and since most of the buildings in the study area face southwest and are
48
49 414 arranged more compactly in the south-north direction than in the east-west direction, the
50
51
415 shadow patterns in the southwest-northeast and southeast-northwest directions exhibit clear
52
53
54 416 characteristics of temporal gradient changes (Fig. 5).
55
56
57 417 The spatial distribution of hourly T mrt varies significantly in the central urban area of
58
59
418 Nanjing. During the day, the southwestern part exhibits higher T mrt than other areas, and T mrt
60
61
62
63
64
65
26

1
2
3
4 419 of extensive impervious surfaces is elevated. In contrast, the Purple Mountain and
5
6
7 420 surrounding areas covered with green spaces or water bodies maintain a relatively low T mrt .
8
9 421 However, after sunset, open areas in the center have a lower T mrt and cooled faster than the
10
11
422 densely built-up areas, vegetation-covered areas, and water bodies (Fig. 6, 7).
12
13
14
423 The statistical and correlation analyses of the 3-D urban landscape pattern metrics and
15
16
17 424 T mrt show that solar access of urban surfaces is an important factor affecting the daytime
18
19
425 thermal environment (Table 3, 4). The SVF and building nCR are significantly positively
20
21
22 426 correlated with T mrt . Reducing solar access (increasing shade) during the day can effectively
23
24 427 improve the urban thermal environment. At night, the cooling capacity of urban surfaces
25
26
428 becomes the main factor that affects the urban thermal environment. The high correlation
27
28
29 429 with nCR suggests that improving the thermal performance of the building envelope is one
30
31
430 important way to increase thermal comfort outside and inside of buildings (Natephra et al.,
32
33
34 431 2017). Considering the cooling effects of green building envelopes (vertical or roof greening)
35
36
432 shown by previous studies (Perini et al., 2011; Zheng et al., 2021; Yin et al., 2017), greening
37
38
39 433 the exterior of buildings (living building envelope) may have great potential as nature -based
40
41 434 solutions to increase urban thermal comfort (Kim et al., 2016).
42
43
44 435 4.2 Current Limitations and Future Directions
45
46
47 436 The rapid development of LiDAR and other remote sensing techniques and
48
49
437 advancements in computing power have facilitated the development of 3-D city models and
50
51
52 438 derived 3-D landscape metrics to quantify the complex geometric structure of urban areas
53
54
439 (Bonczak & Kontokosta, 2019). Linking these metrics with numerical model output yields
55
56
57 440 more precise and accurate results on the urban thermal environment. Current models cannot
58
59
441 directly calculate 3-D landscape metrics, which is a limitation that led to the use of SVF and
60
61
62
63
64
65
27

1
2
3
4 442 SP from UMEP, while other metrics had to be calculated from different data sources.
5
6
7 443 Since LiDAR data and meteorological forcing data used in this study are historical data,
8
9
10 444 synchronously measured T mrt data could not be obtained, resulting in an insufficient model
11
12 445 validation. While real-world T mrt values may deviate from simulations, the fundamental
13
14
446 relationships discovered in the correlation and regression analyses are expected to remain
15
16
17 447 valid. Previous studies have investigated the close relationship between urban building
18
19
448 volume and population (Biljecki et al., 2016; et al., 2016; Maroko et al., 2019; Chen et al.,
20
21
22 449 2021), which provided a novel approach to estimate population patterns for areas that do not
23
24 450 have demographic information available. Based on this relationship, further assumptions can
25
26
451 be made about the amount of anthropogenic heat due to increased population size and the
27
28
29 452 number of people who are potentially experience increased heat load on their body outdoors
30
31
32 453 due to elevated T mrt .
33
34
454 The study illustrates how knowledge related to coupling 3-D urban morphology with
35
36
37 455 numerical modeling can be used to moderate the undesirable consequences of urban
38
39
456 development and help create more livable and resilient cities. T mrt spatial patterns combined
40
41
42 457 with population information will also be helpful to evaluate inequities of who is exposed to
43
44 458 excessive heat and how heat impacts the quality of life and wellbeing. Finally, this approach
45
46
47 459 has great potential to be used for building energy modeling and multi-scenario designs that
48
49 460 consider building envelope greening to mitigate heat and improve outdoor and indoor thermal
50
51
461 comfort.
52
53
54
462 5. Conclusions
55
56
57
463 This study investigated the impacts of 3-D urban landscape patterns on the outdoor
58
59
60 464 thermal environment at an urban scale by coupling the 3-D urban landscape metrics
61
62
63
64
65
28

1
2
3
4 465 calculated from LiDAR point-clouds and the UMEP tool. Using LiDAR point-clouds, this
5
6
466 study constructed an innovative building compactness measure (nCR) and implemented
7
8
9 467 urban shadow pattern metrics and high-resolution SVF maps derived from UMEP output to
10
11
468 facilitate a more realistic characterization of the 3-D urban landscape and promote an in-
12
13
14 469 depth investigation of 3-D landscape patterns that affect the urban thermal environment.
15
16
17 470 By coupling the 3-D metrics with the UMEP integrated tool, T mrt was simulated in the
18
19
471 urban area using observed meteorological data as forcing. A bivariate correlation analysis
20
21
22 472 showed that all 3-D urban landscape metrics are significantly correlated with T mrt , indicating
23
24 473 that 3D urban form plays an important and crucial role in shaping urban T mrt . The results of
25
26
474 a multi-variate linear stepwise regression analysis highlight that the 3-D urban morphology
27
28
29 475 parameters AGB, nCR, and SVF are key variables governing the urban thermal environment.
30
31
32 476 During the day, AGB is negatively correlated with T mrt, while SVF and building nCR are
33
34 477 positively correlated with T mrt , an inverse relationship exists at night.
35
36
37 478 Our results provide a new perspective on managing urban form to help create thermally
38
39
479 comfortable and livable environments based on fully considering the impact of 3-D urban
40
41
42 480 landscape patterns, which can be quantified by the 3-D metrics derived from LiDAR. Results
43
44 481 also highlight the offset effects and tradeoffs of these 3D metrics related to T mrt, which
45
46
47 482 requires further investigation in various localities to optimize urban form for improved
48
49 483 outdoor thermal comfort.
50
51
52 484 Acknowledgments
53
54
55 485 This study was funded by the National Key R&D Program of China (No. 2017YFE0196000)
56
57
486 and the National Natural Science Foundation of China (No. 51878328, 31670470).
58
59
60
61
62
63
64
65
29

1
2
3
4 487 References
5
6
7 488 Abbasabadi, N., & Ashayeri, M. (2019). Urban energy use modeling methods and tools: A
8
9 489 review and an outlook. Building and Environment, 161, 106270.
10
11
12 490 Aboelata, A. (2020). Vegetation in different street orientations of aspect ratio (H/W 1: 1) to
13
491 mitigate UHI and reduce buildings’ energy in arid climate. Building and Environment,
14
15
492 172, 106712.
16
17
18 493 Ali-Toudert, F., & Mayer, H. (2007). Thermal comfort in an east-west oriented street
19
20 494 canyon in Freiburg (Germany) under hot summer conditions. Theoretical and Applied
21
22 495 Climatology, 87(1-4), 223-237.
23
24
496 Amiri, R., Weng, Q., Alimohammadi, A., & Alavipanah, S. K. (2009). Spatial-temporal
25
26 497 dynamics of land surface temperature in relation to fractional vegetation cover and
27
28 498 land use/cover in the Tabriz urban area, Iran. Remote Sensing of Environment,
29
30 499 113(12), 2606–2617.
31
32
500 An, S. M., Kim, B. S., Lee, H. Y., Kim, C. H., Yi, C. Y., Eum, J. H., & Woo, J. H. (2014).
33
34
501 Three-dimensional point cloud based sky view factor analysis in complex urban
35
36 502 settings. International Journal of Climatology, 34(8), 2685–2701.
37
38
39 503 Barlow, J. F. (2014). Progress in observing and modelling the urban boundary layer. Urban
40
41 504 Climate, 10, 216-240.
42
43
505 Biljecki, F., Arroyo Ohori, K., Ledoux, H., Peters, R., & Stoter, J. (2016). Population
44
45
506 estimation using a 3D city model: A multi-scale country-wide study in the
46
47 507 Netherlands. PloS one, 11(6), e0156808.
48
49
50 508 Bonan, G. (2015). Ecological climatology: concepts and applications. Cambridge
51
52 509 University Press.
53
54
510 Bonczak, B., & Kontokosta, C. E. (2019). Large-scale parameterization of 3D building
55
56 511 morphology in complex urban landscapes using aerial LiDAR and city administrative
57
58 512 data. Computers, Environment and Urban Systems, 73, 126-142.
59
60
61
62
63
64
65
30

1
2
3
4 513 Bowler, D. E., Buyung-Ali, L., Knight, T. M., & Pullin, A. S. (2010). Urban greening to
5
6 514 cool towns and cities: A systematic review of the empirical evidence. Landscape and
7
8 515 Urban Planning, 97(3), 147–155.
9
10
516 Chen, H., Wu, B., Yu, B., Chen, Z., Wu, Q., Lian, T., ... & Wu, J. (2021). A New Method
11
12
517 for Building-Level Population Estimation by Integrating LiDAR, Nighttime Light,
13
14 518 and POI Data. Journal of Remote Sensing, 2021.
15
16
17 519 Chen, L., Ng, E., An, X., Ren, C., Lee, M., Wang, U., & He, Z. (2012). Sky view factor
18
19 520 analysis of street canyons and its implications for daytime intra‐ urban air temperature
20
521 differentials in high‐ rise, high‐ density urban areas of Hong Kong: a GIS‐ based
21
22
522 simulation approach. International Journal of Climatology, 32(1), 121–136.
23
24
25 523 Chen, Y.-C., Lin, T.-P., & Matzarakis, A. (2014). Comparison of mean radiant temperature
26
27 524 from field experiment and modelling: a case study in Freiburg, Germany. Theoretical
28
29 525 and Applied Climatology, 118(3), 535–551.
30
31
526 Chun, B., & Guldmann, J. M. (2014). Spatial statistical analysis and simulation of the urban
32
33
527 heat island in high-density central cities. Landscape and urban planning, 125, 76-88.
34
35
36 528 Chun, B., & Guldmann, J. M. (2018). Impact of greening on the urban heat island: Seasonal
37
38 529 variations and mitigation strategies. Computers, Environment and Urban Systems, 71,
39
40 530 165-176.
41
42
531 Colter, K. R., Middel, A. C., & Martin, C. A. (2019). Effects of natural and artificial shade
43
44 532 on human thermal comfort in residential neighborhood parks of Phoenix, Arizona,
45
46 533 USA. Urban Forestry and Urban Greening, 44.
47
48
49 534 Darmanto, N. S., Varquez, A. C., & Kanda, M. (2017). Urban roughness parameters
50
535 estimation from globally available datasets for mesoscale modeling in megacities.
51
52
536 Urban Climate, 21, 243-261.
53
54
55 537 Duan, G., & Takemi, T. (2021). Predicting urban surface roughness aerodynamic
56
57 538 parameters using random forest. Journal of Applied Meteorology and Climatology,
58
59 539 999-1018.
60
61
62
63
64
65
31

1
2
3
4 540 Fernández, M. E., Picone, N., Gentili, J. O., & Campo, A. M. (2021). Analysis of the Urban
5
6 541 Energy Balance in Bahía Blanca (Argentina). Urban Climate, 37, 100856.
7
8
9 542 Gabey, A. M., Grimmond, C. S. B., & Capel-Timms, I. (2019). Anthropogenic heat flux:
10
543 advisable spatial resolutions when input data are scarce. Theoretical and applied
11
12
544 climatology, 135(1), 791-807.
13
14
15 545 Givoni, B. (1998). Climate Considerations in Building and Urban Design. John Wiley &
16
17 546 Sons
18
19
547 Grimmond, C. S. B., & Oke, T. R. (1999). Aerodynamic Properties of Urban Areas Derived
20
21
548 from Analysis of Surface Form. Journal of Applied Meteorology, 38(9), 1262–1292.
22
23
24 549 Grimmond, C. S. B., & Oke, T. R. (1999). Aerodynamic properties of urban areas derived
25
26 550 from analysis of surface form. Journal of Applied Meteorology and Climatology,
27
28 551 38(9), 1262-1292.
29
30
552 Hsieh, C. M., Li, J. J., Zhang, L., & Schwegler, B. (2018). Effects of tree shading and
31
32
553 transpiration on building cooling energy use. Energy and Buildings, 159, 382-397.
33
34
35 554 Hwang, R. L., Lin, T. P., & Matzarakis, A. (2011). Seasonal effects of urban street shading
36
37 555 on long-term outdoor thermal comfort. Building and environment, 46(4), 863-870.
38
39
556 Jenness, J. S. (2004). Calculating landscape surface area from digital elevation models.
40
41
557 Wildlife Society Bulletin, 32(3), 829-839.
42
43
44 558 Johnson, G. T., & Watson, I. D. (1984). The determination of view-factors in urban
45
46 559 canyons. Journal of Climate and Applied Meteorology, 23(2), 329–335.
47
48
49 560 Kidd, C., & Chapman, L. (2012). Derivation of sky-view factors from lidar data.
50
561 International Journal of Remote Sensing, 33(11), 3640–3652.
51
52
53 562 Kim, J., Hong, T., Jeong, J., Koo, C., & Jeong, K. (2016). An optimization model for
54
55 563 selecting the optimal green systems by considering the thermal comfort and energy
56
57 564 consumption. Applied Energy, 169, 682-695.
58
59
60
61
62
63
64
65
32

1
2
3
4 565 Kong, F., Yan, W., Zheng, G., Yin, H., Cavan, G., Zhan, W., ... & Cheng, L. (2016).
5
6 566 Retrieval of three-dimensional tree canopy and shade using terrestrial laser scanning
7
8 567 (TLS) data to analyze the cooling effect of vegetation. Agricultural and forest
9
10 568 meteorology, 217, 22-34.
11
12
569 Kong, F., Yin, H., James, P., Hutyra, L. R., & He, H. S. (2014). Effects of spatial pattern of
13
14 570 greenspace on urban cooling in a large metropolitan area of eastern China. Landscape
15
16 571 and Urban Planning, 128, 35–47.
17
18
19 572 Li, X., Li, W., Middel, A., Harlan, S. L., Brazel, A. J., & Turner, B. L. (2016). Remote
20
573 sensing of the surface urban heat island and land architecture in Phoenix, Arizona:
21
22
574 Combined effects of land composition and configuration and cadastral demographic
23
24 575 economic factors. Remote Sensing of Environment, 174, 233–243.
25
26
27 576 Li, Y., Schubert, S., Kropp, J. P., & Rybski, D. (2020). On the influence of density and
28
29 577 morphology on the Urban Heat Island intensity. Nature communications, 11(1), 1-9.
30
31
578 Lidar360 User Guide. GreenValley International Ltd, Berkeley, California. Available at the
32
33
579 following (accessible on Oct. 2, 2021)
34
35 580 website:https://greenvalleyintl.com/static/upload/file/20210817/1629190611196646.p
36
37 581 df
38
39
40 582 Lindberg, F., & Grimmond, C. S. B. (2011). Nature of vegetation and building morphology
41
583 characteristics across a city: influence on shadow patterns and mean radiant
42
43
584 temperatures in London. Urban Ecosystems, 14(4), 617-634.
44
45
46 585 Lindberg, F., Grimmond, C. S. B., Gabey, A., Huang, B., Kent, C. W., Sun, T., ... & Zhang,
47
48 586 Z. (2018). Urban Multi-scale Environmental Predictor (UMEP): An integrated tool for
49
50 587 city-based climate services. Environmental Modelling & Software, 99, 70-87.
51
52
588 Lindberg, F., Holmer, B., & Thorsson, S. (2008). SOLWEIG 1.0–Modelling spatial
53
54 589 variations of 3D radiant fluxes and mean radiant temperature in complex urban
55
56 590 settings. International journal of biometeorology, 52(7), 697-713.
57
58
59
60
61
62
63
64
65
33

1
2
3
4 591 Maragkogiannis, K., Kolokotsa, D., Maravelakis, E., & Konstantaras, A. (2014).
5
6 592 Combining terrestrial laser scanning and computational fluid dynamics for the study
7
8 593 of the urban thermal environment. Sustainable Cities and Society, 13, 207-216.
9
10
594 Maroko, A., Maantay, J., Pérez Machado, R. P., & Barrozo, L. V. (2019). Improving
11
12
595 population mapping and exposure assessment: three-dimensional dasymetric
13
14 596 disaggregation in New York City and São Paulo, Brazil. Applied Geography, 5(1-2),
15
16 597 45-57.
17
18
19 598 Michiles, A. A. dos S., & Gielow, R. (2008). Above-ground thermal energy storage rates,
20
599 trunk heat fluxes and surface energy balance in a central Amazonian rainforest.
21
22
600 Agricultural and Forest Meteorology, 148(6–7), 917–930.
23
24
25 601 Middel, A., & Krayenhoff, E. S. (2019). Micrometeorological determinants of pedestrian
26
27 602 thermal exposure during record-breaking heat in Tempe, Arizona: Introducing the
28
29 603 MaRTy observational platform. Science of the Total Environment, 687.
30
31
604 Middel, A., AlKhaled, S., Schneider, F. A., Hagen, B., & Coseo, P. (2021). 50 Grades of
32
33
605 Shade. Bulletin of the American Meteorological Society, 1–35.
34
35
36 606 Middel, A., Häb, K., Brazel, A. J., Martin, C. A., & Guhathakurta, S. (2014). Impact of
37
38 607 urban form and design on mid-afternoon microclimate in Phoenix Local Climate
39
40 608 Zones. Landscape and Urban Planning, 122, 16–28.
41
42
609 Middel, A., Lukasczyk, J., Maciejewski, R., Demuzere, M., & Roth, M. (2018). Sky View
43
44 610 Factor footprints for urban climate modeling. Urban climate, 25, 120-134.
45
46
47 611 Middel, A., Selover, N., Hagen, B., & Chhetri, N. (2016). Impact of shade on outdoor
48
49 612 thermal comfort—a seasonal field study in Tempe, Arizona. International journal of
50
613 biometeorology, 60(12), 1849-1861.
51
52
53
614 Motazedian, A., Coutts, A. M., & Tapper, N. J. (2020). The microclimatic interaction of a
54
55 615 small urban park in central Melbourne with its surrounding urban environment during
56
57 616 heat events. Urban Forestry & Urban Greening, 126688.
58
59
60
61
62
63
64
65
34

1
2
3
4 617 Mirzaee, S., Özgun, O., Ruth, M., & Binita, K. C. (2018). Neighborhood-scale sky view
5
6 618 factor variations with building density and height: A simulation approach and case
7
8 619 study of Boston. Urban climate, 26, 95-108.
9
10
620 Natephra, W., Motamedi, A., Yabuki, N., & Fukuda, T. (2017). Integrating 4D thermal
11
12
621 information with BIM for building envelope thermal performance analysis and
13
14 622 thermal comfort evaluation in naturally ventilated environments. Building and
15
16 623 Environment, 124, 194-208.
17
18
19 624 Nield, J. M., King, J., Wiggs, G. F., Leyland, J., Bryant, R. G., Chiverrell, R. C., ... &
20
625 Washington, R. (2013). Estimating aerodynamic roughness over complex surface
21
22
626 terrain. Journal of Geophysical Research: Atmospheres, 118(23), 12-948.
23
24
25 627 Norton, B. A., Coutts, A. M., Livesley, S. J., Harris, R. J., Hunter, A. M., & Williams, N. S.
26
27 628 G. (2015). Planning for cooler cities: A framework to prioritise green infrastructure to
28
29 629 mitigate high temperatures in urban landscapes. Landscape and Urban Planning, 134,
30
630 127–138.
31
32
33
631 Oke, T. R. (1981). Canyon geometry and the nocturnal urban heat island: comparison of
34
35 632 scale model and field observations. Journal of Climatology, 1(3), 237–254.
36
37
38 633 Oke, T. R. (1989). The micrometeorology of the urban forest. Philosophical Transactions of
39
40 634 the Royal Society of London. B, Biological Sciences, 324(1223), 335-349.
41
42
635 Oke, T. R. "Street design and urban canopy layer climate." Energy and buildings 11.1
43
44 636 (1988): 103-113.
45
46
47 637 Park, Y., Guldmann, J. M., & Liu, D. (2021). Impacts of tree and building shades on the
48
49 638 urban heat island: Combining remote sensing, 3D digital city and spatial regression
50
639 approaches. Computers, Environment and Urban Systems, 88, 101655.
51
52
53
640 Patz, J. A., Campbell-Lendrum, D., Holloway, T., & Foley, J. A. (2005). Impact of regional
54
55 641 climate change on human health. Nature 2005 438:7066, 438(7066), 310–317.
56
57
58
59
60
61
62
63
64
65
35

1
2
3
4 642 Peeters, A. (2016). A GIS-based method for modeling urban-climate parameters using
5
6 643 automated recognition of shadows cast by buildings. Computers, Environment and
7
8 644 Urban Systems, 59, 107-115.
9
10
645 Peeters, A., Shashua-Bar, L., Meir, S., Shmulevich, R. R., Caspi, Y., Weyl, M., ... & Angel,
11
12
646 N. (2020). A decision support tool for calculating effective shading in urban streets.
13
14 647 Urban Climate, 34, 100672.
15
16
17 648 Perini, K., & Magliocco, A. (2014). Effects of vegetation, urban density, building height,
18
19 649 and atmospheric conditions on local temperatures and thermal comfort. Urban
20
650 Forestry & Urban Greening, 13(3), 495-506.
21
22
23
651 Perini, K., Ottelé, M., Fraaij, A. L. A., Haas, E. M., & Raiteri, R. (2011). Vertical greening
24
25 652 systems and the effect on air flow and temperature on the building envelope. Building
26
27 653 and Environment, 46(11), 2287-2294.
28
29
30 654 Perkins, S. E., Alexander, L. V., & Nairn, J. R. (2012). Increasing frequency, intensity and
31
655 duration of observed global heatwaves and warm spells. Geophysical Research
32
33
656 Letters, 39(20), 20714.
34
35
36 657 Petras, V., Newcomb, D. J., & Mitasova, H. (2017). Generalized 3D fragmentation index
37
38 658 derived from lidar point clouds. Open Geospatial Data, Software and Standards, 2(1),
39
40 659 1–14.
41
42
660 Rahman, M. A., Stratopoulos, L. M., Moser-Reischl, A., Zölch, T., Häberle, K. H., Rötzer,
43
44 661 T., ... & Pauleit, S. (2020). Traits of trees for cooling urban heat islands: A meta-
45
46 662 analysis. Building and Environment, 170, 106606.
47
48
49 663 Ratti, C., & Richens, P. (1999). Urban texture analysis with image processing techniques.
50
664 In Computers in Building (pp. 49-64). Springer, Boston, MA.
51
52
53
665 Ratti, C., Di Sabatino, S., & Britter, R. (2006). Urban texture analysis with image
54
55 666 processing techniques: winds and dispersion. Theoretical and applied climatology,
56
57 667 84(1), 77-90.
58
59
60
61
62
63
64
65
36

1
2
3
4 668 Ronchi, S., Salata, S., & Arcidiacono, A. (2020). Which urban design parameters provide
5
6 669 climate-proof cities? An application of the Urban Cooling InVEST Model in the city
7
8 670 of Milan comparing historical planning morphologies. Sustainable Cities and Society,
9
10 671 63, 102459.
11
12
672 Salata, F., Golasi, I., de Lieto Vollaro, A., & de Lieto Vollaro, R. (2015). How high albedo
13
14 673 and traditional buildings’ materials and vegetation affect the quality of urban
15
16 674 microclimate. A case study. Energy and Buildings, 99, 32-49.
17
18
19 675 Santamouris, M. (2014). On the energy impact of urban heat island and global warming on
20
676 buildings. Energy and Buildings, 82, 100–113.
21
22
23
677 Sato, Y., Higuchi, A., Takami, A., Murakami, A., Masutomi, Y., Tsuchiya, K., ... &
24
25 678 Nakajima, T. (2016). Regional variability in the impacts of future land use on
26
27 679 summertime temperatures in Kanto region, the Japanese megacity. Urban Forestry &
28
29 680 Urban Greening, 20, 43-55.
30
31
681 Shareef, S., & Abu-Hijleh, B. (2020). The effect of building height diversity on outdoor
32
33
682 microclimate conditions in hot climate. A case study of Dubai-UAE. Urban Climate,
34
35 683 32, 100611.
36
37
38 684 Sharmin, T., Kabir, S., & Rahaman, M. (2012). A study of thermal comfort in outdoor
39
40 685 urban spaces in respect to increasing building height in Dhaka. AIUB Journal of
41
686 Science and Engineering, 11(1).
42
43
44 687 Solcerova, A., van de Ven, F., Wang, M., Rijsdijk, M., & van de Giesen, N. (2017). Do
45
46 688 green roofs cool the air? Building and Environment, 111, 249–255.
47
48
49 689 Thorsson, S., Lindberg, F., Eliasson, I., & Holmer, B. (2007). Different methods for
50
690 estimating the mean radiant temperature in an outdoor urban setting. International
51
52
691 Journal of Climatology: A Journal of the Royal Meteorological Society, 27(14), 1983-
53
54 692 1993.
55
56
57
58
59
60
61
62
63
64
65
37

1
2
3
4 693 Tomás, L., Fonseca, L., Almeida, C., Leonardi, F., & Pereira, M. (2016). Urban population
5
6 694 estimation based on residential buildings volume using IKONOS-2 images and lidar
7
8 695 data. International Journal of Remote Sensing, 37(sup1), 1-28.
9
10
696 Unger, J. (2009). Connection between urban heat island and sky view factor approximated
11
12
697 by a software tool on a 3D urban database. International Journal of Environment and
13
14 698 Pollution, 36(1–3), 59–80.
15
16
17 699 Wong, N. H., & Yu, C. (2005). Study of green areas and urban heat island in a tropical city.
18
19 700 Habitat International, 29(3), 547–558.
20
21
701 Wonorahardjo, S., Sutjahja, I. M., Mardiyati, Y., Andoni, H., Thomas, D., Achsani, R. A.,
22
23
702 & Steven, S. (2020). Characterising thermal behaviour of buildings and its effect on
24
25 703 urban heat island in tropical areas. International Journal of Energy and Environmental
26
27 704 Engineering, 11(1), 129-142.
28
29
30 705 Xu, X.Z., Zheng, Y.F., Yin, J.F., Wu, R.J., 2011. Characteristics of high temperature and
31
706 heat wave in Nanjing City and their impacts on human health. Chin. J. Ecol.30 (12),
32
33
707 2815–2820 (in Chinese).
34
35
36 708 Yang, X., & Li, Y. (2015). The impact of building density and building height
37
38 709 heterogeneity on average urban albedo and street surface temperature. Building and
39
40 710 Environment, 90, 146-156.
41
42
711 Yin, H., Kong, F., Middel, A., Dronova, I., Xu, H., & James, P. (2017). Cooling effect of
43
44 712 direct green façades during hot summer days: An observational study in Nanjing,
45
46 713 China using TIR and 3DPC data. Building and Environment, 116, 195-206.
47
48
49 714 Zakšek, Klemen, Oštir, Kristof, & Kokalj, Žiga. (2011). Sky-view factor as a relief
50
715 visualization technique. Remote Sensing, 3(2), 398-415.
51
52
53
716 Zellweger, F., De Frenne, P., Lenoir, J., Rocchini, D., & Coomes, D. (2019). Advances in
54
55 717 microclimate ecology arising from remote sensing. Trends in Ecology & Evolution,
56
57 718 34(4), 327-341.
58
59
60
61
62
63
64
65
38

1
2
3
4 719 Zhang, Y., Middel, A., & Turner, B. L. (2019). Evaluating the effect of 3D urban form on
5
6 720 neighborhood land surface temperature using Google Street View and
7
8 721 geographically weighted regression. Landscape Ecology, 34(3), 681–697.
9
10
722 Zhang, Y., Sun, C., Bao, Y., & Zhou, Q. (2018). How surface roughness reduces heat
11
12
723 transport for small roughness heights in turbulent Rayleigh–Bénard convection.
13
14 724 Journal of Fluid Mechanics, 836, R2.
15
16
17 725 Zhang, Y., Zhang, L. N., Yang, C. D., Bao, W. D., & Yuan, X. X. (2011). Surface area
18
19 726 processing in GIS for different mountain regions. Forestry Studies in China, 13(4),
20
727 311-314.
21
22
23
728 Zheng, X., Kong, F., Yin, H., Middel, A., Liu, H., Wang, D., ... & Lensky, I. (2021).
24
25 729 Outdoor thermal performance of green roofs across multiple time scales: A case study
26
27 730 in subtropical China. Sustainable Cities and Society, 70, 102909.
28
29
30 731 Zhu, R., Wong, M. S., You, L., Santi, P., Nichol, J., Ho, H. C., ... & Ratti, C. (2020). The
31
732 effect of urban morphology on the solar capacity of three-dimensional cities.
32
33
733 Renewable Energy, 153, 1111-1126.
34
35
36 734 Zimble, D. A., Evans, D. L., Carlson, G. C., Parker, R. C., Grado, S. C., & Gerard, P. D.
37
38 735 (2003). Characterizing vertical forest structure using small-footprint airborne LiDAR.
39
40 736 Remote sensing of Environment, 87(2-3), 171-182.
41
42
737
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
39
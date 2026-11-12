Full Paper 173
Strategies for Enhancing Courtyard Thermal
Comfort in Hot Arid Phoenix:
The Secret Garden on ASU Campus
Muge Unal1, Ariane Middel2
1Fırat University, Landscape Architecture Department, Elazig/Türkiye ꞏ mugeunal@firat.edu.tr
2Arizona State University, School of Arts, Media and Engineering (AME), Tempe, Arizona/USA
Abstract: Courtyards possess unique geometric features that regulate sun exposure, wind, and humidity
in hot climates. This study examines how surface materials and shading affect thermal comfort in court-
yards in the hot arid climate of Phoenix, Arizona, through human-biometeorological observations and
microclimate modeling. The Herberger Institute for Design and the Arts Hall (Secret Garden) on Ari-
zona State University’s main campus were selected as case studies. The thermal environment of these
courtyards was first evaluated for a typical hot and dry summer day in June 2023 using the ENVI-met
5.0.1 microclimate model. On-site measurements of key microclimatic variables, including air temper-
ature (Ta), relative humidity (RH), wind speed (WS), and mean radiant temperature (MRT), were col-
lected using the MaRTy platform to validate the model. Two scenario groups were then developed: the
first tested various surface materials (concrete, grass, and water), and the second explored the impact
of 3D vegetation configurations (central and bordered planting). Statistical analyses, including ANOVA
and Tukey’s HSD tests, were conducted to compare the spatial differences in thermal exposure and
comfort across the scenarios.
Keywords: Courtyard design, microclimate, MaRTy, ENVI-met, heat mitigation strategies
1 Introduction
In recent years, meteorological studies have increasingly focused on micro-scale evaluations,
highlighting the critical influence of urban design on thermal conditions (GELETIČ et al. 2019,
HU et al. 2019). Courtyards, historically used to enhance thermal comfort, are valued for
modulating airflow, providing shade, and reducing heat retention. Their design has tradition-
ally reflected local climatic and cultural needs, and today, they remain integral to residential,
educational, and healthcare architecture for their passive cooling benefits (GHAFFARIAN-
HOSEINI et al. 2015).
Research on courtyards often explores their morphology, geometry, surface materials, and
shading effects, employing tools like ENVI-met, Ray-Man, and EnergyPlus to evaluate ther-
mal performance in diverse climates (GHAFFARIANHOSEINI et al. 2015, CRANK et al.2020).
CFD models, calibrated with field data, are particularly effective in simulating urban micro-
climates, including wind and temperature variations (MIDDEL et al. 2014, TALEGHANI et al.
2014). ENVI-met is a high-resolution non-hydrostatic microclimate model developed by Mi-
chael Bruse, which is widely used for analyzing microclimates and thermal comfort indices.
Recent studies have employed ENVI-met to assess how urban physical characteristics impact
thermal comfort, particularly in hot-arid and hot-humid areas (UNAL CILEK & CILEK 2021,
UNAL & USLU 2022). The model is frequently utilized to examine how courtyard attributes
like orientation, aspect ratio, SVF, building height, shade, surface cover, and vegetation in-
fluence outdoor thermal comfort (AKBARI et al. 2021, BERKOVIC et al. 2012, LIU et al. 2024,
MARCHI et al. 2023, SÖZEN & ORAL 2019, TALEGHANI et al. 2014). Studies also highlight the
Journal of Digital Landscape Architecture, 10-2025, pp. 173-180. © Wichmann Verlag, VDE VERLAG GMBH ꞏ
Berlin ꞏ Offenbach. ISBN 978-3-87907-754-0, ISSN 2367-4253, e-ISSN 2511-624X, doi:10.14627/537754016.
This article is an open access article distributed under the terms and conditions of the Creative Commons
Attribution license (http://creativecommons.org/licenses/by-nd/4.0/).

174 Journal of Digital Landscape Architecture ꞏ 10-2025
benefits of material selection, lawns (MUSHTAHA et al. 2021, SALUR 2016, SOFLAEI et al.
2017), and trees or shading elements on thermal conditions (AKBARI et al. 2021, DIZ-
MELLADO et al. 2021, SOFLAEI et al. 2020). However, model validation remains limited, with
RMSE often exceeding ±5 °C (WU et al. 2023). Validation with in-situ data is essential for
accurate interpretation (CRANK et al. 2020).
This study’s originality lies in the detailed examination of the thermal performance of court-
yards in hot arid climate regions such as Phoenix, Arizona. The literature on micro-climate
dynamics and design interventions specific for Arizona remains limited. Furthermore, our
integrated methodological approach, supported by both advanced modelling and field meas-
urements, provides a significant methodological contribution to existing re-search. This study
aims to evaluate the microclimate performance of selected courtyards using the ENVI-met
5.0.1 model and MaRTy platform by analyzing key microclimate variables, including air
temperature, relative humidity, wind speed, and mean radiant temperature. Additionally, it
investigates the impact of different surface materials (concrete, grass, and water) and 3D
vegetation configurations (central and bordered planting) on thermal comfort. The strength
of our methodology, particularly in the use of scenario-based analysis, ANOVA, and Tukey’s
HSD tests. These approaches allow for a robust statistical comparison of thermal exposure
and comfort variations across different design scenarios. It aims to provide guidelines for
enhancing outdoor thermal comfort.
2 Materials and Methods
2.1 Study Area
This study was conducted on the Arizona State University (ASU) main campus in Tempe,
Arizona, located in Maricopa County (33°26'54″N, 112°04'26″W). Covering 2.7 km² near
downtown Tempe, the area features a tropical and subtropical desert climate (BWh) per the
Köppen-Geiger classification, with low annual rainfall (203.2 mm), hot summers (41-53°C
in July-August), and mild winters (6–13°C in January–February) (AZMET 2023, CILEK et al.
2024). Vegetation includes drought-resistant species and irrigated lawns. The ASU campus
was selected for its accessible measurement facilities and similarly designed courtyards. The
courtyard at the Herberger Institute for Design and the Arts Hall (Secret Garden) is north-
south oriented and enclosed by a 54 × 64 m² building with an 8 m height. It contains trees,
shrubs, cacti, succulents, and grass, with a courtyard width of 36 m, length of 62 m, and a
low height-to-width (H/W) ratio of 0.22 for both East-West and South-North orientations.
Sky View Factor (SVF) ranges from 0.09-0.18 in vegetated areas and 0.54-0.63 at courtyard
centers (Fig. 1).

M. Unal, A. Middel: Strategies for Enhances Courtyard Thermal Comfort in Hot Arid Phoenix 175
Fig. 1: Herberger Institute for Design and the Arts Hall
2.2 Methods
Table 1: Matrix of 18 scenarios combining of courtyard with changes in ground cover, veg-
etation configuration, and plant placement strategies
100% grass 85% grass 100% concrete 85% concrete 15% grass 45% concrete
15% water 15% water 85% concrete 40% grass
15% water
No 3D plants
3D plants
centered
3D plants
border
The study employed a five-step methodology. First, micrometeorological stations (MaRTy
human-biometeorological instrument platforms, MIDDEL & KRAYENHOFF 2019) were in-
stalled in and outside courtyards to monitor air temperature (Ta), wind speed (WS), wind
direction (WD), relative humidity (RH), and mean radiant temperature (MRT). These hourly
observations, recorded at 2-second intervals and averaged by location, were used to initialize
and evaluate ENVI-met simulations modeling a 158 m x 97 m area with a 2 x 2 m grid. Data

| 176  |     | Journal of Digital Landscape Architecture ꞏ 10-2025  |     |     |
| ---- | --- | ---------------------------------------------------- | --- | --- |
were collected on June 20, 2023, from 6:00 to 20:00. Second, the ENVI-met model was val-
idated using RMSE analysis. Third, 18 scenarios were created to test heat-mitigation strate-
gies, including changes to surface materials (grass, water, concrete) and 3D vegetation (Table
1). Fourth, thermal comfort was assessed using Physiological Equivalent Temperature (PET)
and MRT. Lastly, ANOVA and Tukey’s HSD tests identified key courtyard features influ-
encing thermal comfort, informing actionable design recommendations.
3  Results
3.1  Model Validation
The validation results from June 20, 2023, comparing ENVI-met (modeled) and MaRTy (ob-
served) data for the Herberger Institute reveal varying accuracies. MRT shows strong align-
ment (R² = 0.95, RMSE = 6.2, MBE = -4.1), and Ta also performs strong alignment with
observed values, showcasing high accuracy (R² = 0.90, d = 0.98) and minimal error (RMSE
= 1.2, MBE = 0.7). RH has moderate accuracy with a weaker correlation (R² = 0.49) but
acceptable accuracy (d = 0.74). The model tends to overestimate RH (MBE = 7.9). WS shows
Limited reliability due to low correlation (R² = 0.05) and significant error despite a small
RMSE (0.4). MBE suggests a slight underestimation (-0.3), while Tsurface performs strongly
(R² = 0.88, RMSE = 4.7, MBE = 1.4). The ENVI-met model effectively predicts MRT, Ta,
and Tsurface but requires further calibration for RH and WS.
Table 2:  Validation results for June 20, 2023, modeled/ENVI-met vs observed/MaRTy for
the Herberger Institute
|            | Herberger Institute for Design and the Arts Hall  |       |       |       |
| ---------- | ------------------------------------------------- | ----- | ----- | ----- |
| Variables  | RMSE                                              | R2    | d     | MBE   |
| MRT        | 6.2                                               | 0.95  | 0.95  | -4.1  |
| Ta         | 1.2                                               | 0.90  | 0.98  | 0.7   |
| RH         | 8.8                                               | 0.49  | 0.74  | 7.9   |
| WS         | 0.4                                               | 0.05  | 0.61  | -0.3  |
| Tsurface   | 4.7                                               | 0.88  | 0.91  | 1.4   |
3.2  Impact of Surface Materials and Vegetation on MRT
The effect of surface materials on MRT was assessed across various courtyard scenarios,
revealing that grass surfaces, either alone or with water, were most effective at reducing
MRT, while concrete surfaces were less effective at minimizing heat retention. The open
grass scenario (S1) achieved the most significant MRT reductions, especially in the morning
and evening, with MRT values ranging from 14.7°C at 06:00 h to 58.5-61.2°C at 14:00 h.
Adding water (S2) provided only marginal improvements. Concrete scenarios resulted in
higher MRT values. Combining concrete with grass (S5) or grass with water (S6) provided
moderate cooling but remained less effective than grass alone. The full concrete scenario (S3)
had the poorest thermal performance, with MRT peaking between 59.2-63.5°C. In conclu-
sion, grass surfaces were the most effective at reducing MRT, especially when combined

M. Unal, A. Middel: Strategies for Enhances Courtyard Thermal Comfort in Hot Arid Phoenix 177
with water. Concrete, even in combination with grass or water, offered minimal heat mitiga-
tion. Vegetation placement also influenced MRT. Central vegetation (S7, S9, S13) provided
more significant MRT reductions compared to border vegetation (S13-S15), particularly in
the early morning, with reductions of 1-3°C. Grass was more effective than concrete, but
some water features caused higher midday MRT. Central vegetation was more effective at
reducing MRT throughout the day, while border vegetation maintained lower MRT in the
evening (Table 3).
Table 3: MRT of the courtyard model comparing different heat mitigation strategies
1st scenario group: Effects of materials
Scenarios 6:00 7:00 8:00 9:00 10:00 11:00 12:00 13:00 14:00 15:00 16:00 17:00 18:00 19:00 20:00
S0_Existing Situation 18.57 24.08 30.70 36.71 40.75 43.33 46.17 49.99 52.33 51.21 48.03 40.77 36.76 31.23 28.73
S1_FullGrass_No 3D plant 14.74 27.81 41.48 49.38 52.21 53.19 54.06 57.44 61.23 62.44 61.01 52.21 40.28 32.42 26.67
S2_Grass_Water_No 3D plant 14.70 27.77 41.47 49.38 52.21 53.19 54.06 57.44 61.21 62.40 60.96 52.16 40.22 32.34 26.62
S3_FullConcrete_No 3D plant 14.48 27.67 41.58 49.77 52.80 53.95 54.94 58.39 62.09 63.13 61.51 52.56 40.49 32.47 26.67
S4_Concrete_Water_No 3D plant 14.48 27.67 41.55 49.69 52.68 53.80 54.76 58.20 61.90 62.94 61.36 52.43 40.37 32.37 26.59
S5_Concrete_Grass_No 3D plant 14.52 27.70 41.56 49.69 52.68 53.80 54.77 58.21 61.94 63.01 61.42 52.50 40.45 32.46 26.67
S6_Concrete_Water_Grass_No 3D plant 14.57 27.74 41.61 49.74 52.69 53.80 54.76 58.19 61.87 62.91 61.34 52.40 40.33 32.35 26.62
2nd scenario group: Effects of 3D plants with a centered location
S7_FullGrass_Center_3D plant 17.87 22.10 26.76 33.83 39.44 43.70 47.77 51.52 53.42 52.96 50.32 44.13 39.06 34.30 29.68
S8_Grass_Water_Center_3D plant 14.70 27.77 27.98 35.23 45.58 50.29 54.06 57.44 61.21 62.40 62.40 52.16 40.22 32.34 26.62
S9_FullConcrete_Center_3D plant 17.64 21.98 26.83 34.16 39.93 44.35 48.55 52.40 54.31 53.75 50.88 44.51 39.27 34.35 29.62
S10_Concrete_Water_Center_3D plant 17.63 21.97 26.82 34.14 39.91 44.32 48.51 52.35 54.26 53.66 50.82 44.44 39.19 34.28 29.46
S11_Concrete_Grass_Center_3D plant 17.68 22.00 26.82 39.84 44.23 48.41 52.24 54.14 53.59 50.78 44.44 39.23 34.35 29.62 25.60
S12_Concrete_Water_Grass_Center_3D plant 17.71 22.01 26.80 34.03 39.73 44.10 48.24 52.05 53.95 53.43 50.63 44.33 39.14 34.28 29.53
2nd scenario group: Effects of 3D plants with bordered location
S13_FullGrass_Border_3D plant 18.37 22.60 27.70 34.75 39.57 43.19 47.58 51.34 52.75 52.00 49.50 44.08 39.29 34.69 30.14
S14_Grass_Water_Border_3D plant 18.33 22.57 27.70 34.78 39.60 43.21 47.60 51.36 52.76 51.98 49.50 44.06 39.25 34.62 30.06
S15_FullConcrete_Border_3D plant 18.13 22.47 27.77 35.08 40.07 43.85 48.35 52.20 53.61 52.75 50.04 44.43 39.48 34.72 30.08
S16_Concrete_Water_Border_3D plant 18.13 22.47 27.76 35.05 40.00 43.75 48.20 52.03 53.44 52.59 49.92 44.33 39.38 34.63 29.96
S17_Concrete_Grass_Border_3D plant 18.18 22.50 27.76 35.02 39.97 43.72 48.19 52.02 53.45 52.62 49.94 44.36 39.44 34.71 30.08
S18_Concrete_Water_Grass_Border_3D plant 17.92 22.33 27.96 36.23 41.11 44.65 48.58 52.32 54.12 53.32 50.48 44.29 39.19 34.45 29.73
3.3 ANOVA for PET
We examined the influence of courtyard design features on thermal comfort during peak PET
levels (14:00). To assess statistically significant differences in PET across various scenarios,
an ANOVA Tukey HSD test was performed (Figure 2). A comparison of PET levels at the
Herberger Institute for Design and the Arts Hall demonstrated notable variations in thermal
comfort, shaped by factors such as surface materials and the strategic placement of 3D veg-
etation. The first group of scenarios showed no substantial impact on PET values, whereas
the second group revealed statistically significant differences based on vegetation placement-
centralized or bordered. Vegetation reduced PET by 1–2°C, with statistically significant re-
sults.
The effect of surface materials (S1–S6) on PET showed considerable variability. At the Her-
berger Institute, changes in surface materials moderately increased PET, with scenario S5
resulting in the highest rise of +4.9°C compared to the base case. Scenarios involving 3D
vegetation (S7–S18) consistently reduced PET across all locations, with centralized vegeta-
tion (S7–S12) generally achieving greater reductions than bordered vegetation (S13–S18).
Specifically, centralized vegetation at the Herberger Institute reduced PET by up to 4.5°C,
while bordered vegetation achieved a reduction of 1.7°C.

| 178  |     |     |     | Journal of Digital Landscape Architecture ꞏ 10-2025  |     |     |     |
| ---- | --- | --- | --- | ---------------------------------------------------- | --- | --- | --- |
C1: Herberger Institute for Design and the Arts Hall
| 1st set of scenario         |     |                    |     | 2nd set of scenario |                     |     |     |
| --------------------------- | --- | ------------------ | --- | ------------------- | ------------------- | --- | --- |
| Effect of surface materials |     | Centered 3D plants |     |                     | Boardered 3D plants |     |     |
S1 S2 S3 S4 S5 S6 S7 S8 S9 S10 S11 S12 S13 S14 S15 S16 S17 S18
-4.6 -4.5 -4.9 -4.8 -4.9 -4.8 -2.1 -4.5 -2.4 -2.3 -2.3 -2.2 -1.2 -1.1 -1.7 -1.5 -1.6 -1.7 S0 Existing situation
0.1 -0.3 -0.2 -0.3 -0.1 2.5 0.1 2.2 2.3 2.3 2.4 3.4 3.5 2.9 3.1 3.0 2.9 S1  ecaf oiranecs fo tes ts1
-0.4 -0.2 -0.4 -0.2 2.4 0.0 2.1 2.2 2.3 2.3 3.3 3.4 2.8 3.0 2.9 2.8 S2
r u s l
0.1 0.0 0.2 2.8 0.4 2.5 2.6 2.6 2.7 3.7 3.8 3.2 3.4 3.3 3.2 S3 s  f a ir e
-0.1 0.0 2.7 0.2 2.4 2.4 2.5 2.6 3.6 3.7 3.1 3.3 3.2 3.1 S4 o  t ta
ceffE m
|     | 0.2 | 2.8 0.4 | 2.5 2.6   | 2.6 2.7   | 3.7 3.8 | 3.2 3.4   | 3.3 3.2 S5                        |
| --- | --- | ------- | --------- | --------- | ------- | --------- | --------------------------------- |
|     |     | 2.7 0.2 | 2.4 2.4   | 2.5 2.5   | 3.5 3.6 | 3.1 3.3   | 3.2 3.0 S6                        |
|     |     | -2.4    | -0.3 -0.2 | -0.2 -0.1 | 0.9 1.0 | 0.4 0.6   | 0.5 0.4 S7 stnalp D3 deretneC     |
|     |     |         | 2.1 2.2   | 2.3 2.3   | 3.3 3.4 | 2.8 3.0   | 2.9 2.8 S8                        |
|     |     |         | 0.1       | 0.1 0.2   | 1.2 1.3 | 0.7 0.9   | 0.8 0.7 S9                        |
|     |     |         |           | 0.1 0.1   | 1.1 1.2 | 0.6 0.8   | 0.7 0.6 S10 oiranecs fo tes dn2   |
|     |     |         |           | 0.1       | 1.1 1.2 | 0.6 0.8   | 0.7 0.6 S11                       |
|     |     |         |           |           | 1.0 1.1 | 0.5 0.7   | 0.6 0.5 S12                       |
|     |     |         |           |           | 0.1     | -0.5 -0.3 | -0.4 -0.5 S13 stnalp D3 deredraoB |
|     |     |         |           |           |         | -0.6 -0.4 | -0.5 -0.6 S14                     |
|     |     |         |           |           |         | 0.2       | 0.1 0.0 S15                       |
Red numbers shows significantly different (p<0.0 -0.1 -0.2 S16
| Column PET is higher than row. |     |     |     |     |     |     | -0.1 S17 |
| ------------------------------ | --- | --- | --- | --- | --- | --- | -------- |

| Column PET is lower than row. |     |     |     |     |     |     | S18 |
| ----------------------------- | --- | --- | --- | --- | --- | --- | --- |
Fig. 2:  Tukey-HSD comparison matrix for all scenarios, where the blue and red grids show
the differences in the mean PET at 14:00 h
4  Conclusion and Outlook
This study highlights the critical role of integrating green spaces and shading structures to
improve thermal comfort in courtyard settings. Surface materials – such as grass, concrete,
and water – significantly influenced Mean Radiant Temperature (MRT), though shading
structures had a stronger impact. Among surface materials, grass proved the most effective,
reducing MRT by 1–2°C compared to concrete. Scenarios combining grass and water demon-
strated marginal improvements, while water features alone offered limited enhancements to
thermal comfort. Vegetation, particularly trees, reduced MRT by 4–5°C and Physiological
Equivalent Temperature (PET) by 1–2°C across various scenarios. However, the effective-
ness of vegetation varied depending on its placement and the surface materials used.
Central vegetation was more beneficial during cooler hours but contributed to heat retention
during peak midday temperatures. In contrast, perimeter vegetation provided consistent shad-
ing without obstructing airflow, making it a more reliable strategy for long-term MRT reduc-
tion. Scenarios combining grass, water, and perimeter vegetation consistently delivered the
best thermal performance. Conversely, dense central vegetation paired with large concrete
surfaces heightened MRT during midday, underscoring the importance of strategic vegeta-
tion placement and material selection.
These findings align with previous research emphasizing the need for integrated design strat-
egies that leverage vegetation and surface materials to optimize thermal comfort (BERKOVIC
et al. 2012, GHAFFARIANHOSEINI et al. 2015, LIU et al. 2024, LOPEZ-CABEZA 2022, MARCHI
et al. 2023). While vegetation consistently demonstrated effectiveness in reducing MRT and
PET, the performance of other strategies, such as high-albedo materials and water features,
was more context-specific. This study unde
rscores the necessity of tailoring design approaches to the unique microclimatic and spatial
characteristics of courtyards to achieve optimal thermal comfort. As global temperatures rise
and urban heat island effects intensify, there is an urgent need for urban planners, architects,

M. Unal, A. Middel: Strategies for Enhances Courtyard Thermal Comfort in Hot Arid Phoenix 179
and landscape designers to create outdoor spaces that enhance thermal comfort while mini-
mizing energy use and environmental impact. The insights from this study provide valuable
guidance for designing courtyards in Phoenix and other hot-arid cities worldwide, where ad-
dressing extreme heat is increasingly critical for public health and well-being.
References
AKBARI, H., CHERATI, S. M., MONAZAM, N. H. & NOGUCHI, M. (2021), Effect of courtyards’
geometrical parameters on climate adaptability and shading performance in hot-arid cli-
mate of Yazd (Iran). Sustainable Energy Technology and Assessments, 48, 101594.
https://doi.org/https://doi.org/10.1016/j.seta.2021.101594.
AZMET (2023), Arizona Climate Data.
https://ag.arizona.edu/azmet/az-data.htm (09.08.2023).
BERKOVIC, S., YEZIORO, A. & BITAN, A. (2012), Study of thermal comfort in courtyards in a
hot arid climate. Solar Energy, 86, 1173-1186.
https://doi.org/10.1016/j.solener.2012.01.010.
CILEK, A., UNAL, M. & MIDDEL, A. (2024), The effects of 2-D and 3-D urban landscape met-
rics on mean radiant temperature in hot-arid Phoenix and Tempe, Arizona, USA. Sustain-
able Cities and Society, 101, 105116.
CRANK, P. J., MIDDEL, A., WAGNER, M., HOOTS, D., SMITH, M. & BRAZEL, A. (2020), Vali-
dation of seasonal mean radiant temperature simulations in hot arid urban climates. Sci-
ence of the Total Environment, 749, 141392.
https://doi.org/10.1016/j.scitotenv.2020.141392.
DIZ-MELLADO, E., LOPEZ-CABEZA, V. P., RIVERA-GOMEZ, C., GALAN-MARIN, C., ROJAS-
FERNANDEZ, J. & NIKOLOPOULOU, M. (2021), Extending the adaptive thermal comfort
models for courtyards. Building and Environment, 203, 108094.
https://doi.org/10.1016/j.buildenv.2021.108094.
GELETIČ, J., LEHNERT, M., SAVIĆ, S. & MILOŠEVIĆ, D. (2019), Inter-/intra-zonal seasonal var-
iability of the surface urban heat island based on local climate zones in three central Eu-
ropean cities. Building and Environment, 156 (December 2018), 21-32.
https://doi.org/10.1016/j.buildenv.2019.04.011.
GHAFFARIANHOSEINI, A., BERARDI, U. & GHAFFARIANHOSEINI, A. (2015), Thermal perfor-
mance characteristics of unshaded courtyards in hot and humid climates. Building and
Environment, 87, 154-168. https://doi.org/10.1016/j.buildenv.2015.02.001.
HU, J., YANG, Y., PAN, X., ZHU, Q., ZHAN, W., WANG, Y., MA, W. & SU, W. (2019), Analysis
of the Spatial and Temporal Variations of Land Surface Temperature Based on Local
Climate Zones: A Case Study in Nanjing, China. IEEE Journal of Selected Topics in
Applied Earth Observations and Remote Sensing, 12 (11), 4213-4223.
https://doi.org/10.1109/JSTARS.2019.2926502.
LIU, S., MIDDEL, A., FANG, X. & WU, R. (2024), Urban Climate ENVI-met model perfor-
mance evaluation for courtyard simulations in hot-humid climates. Urban Clim. 2024, 55,
101909.
LOPEZ-CABEZA, V. P., ALZATE-GAVIRIA, S., DIZ-MELLADO, E., RIVERA-GOMEZ, C. & GA-
LAN-MARIN, C, (2022), Albedo influence on the microclimate and thermal comfort of
courtyards under Mediterranean hot summer climate conditions. Sustainable Cities and
Society, 81, 103872. https://doi.org/10.1016/j.scs.2022.103872.

180 Journal of Digital Landscape Architecture ꞏ 10-2025
MARCHI, L., GASPARI, J. & FABBRI, K. (2023), Outdoor Microclimate in Courtyard Buildings:
Impact of Building Perimeter Configuration and Tree Density. Buildings, 13, 2687.
https://doi.org/https://doi.org/10.3390/buildings13112687.
MIDDEL, A., HÄB, K., BRAZEL, A. J., MARTIN, C. & GUHATHAKURTA, S. (2014), Impact of
urban form and design on mid-afternoon microclimate in Phoenix Local Climate Zones.
Landscape and Urban Planning, 122, 16-28.
https://doi.org/10.1016/j.landurbplan.2013.11.004.
MIDDEL, A. & KRAYENHOFF, E. S. (2019), Micrometeorological determinants of pedestrian
thermal exposure during record-breaking heat in Tempe, Arizona: Introducing the
MaRTy observational platform. The Science of the total environment, 687, 137-151.
https://doi.org/10.1016/j.scitotenv.2019.06.085.
MUSHTAHA, E., SHAREEF, S., ALSYOUF, I., MORI, T., KAYED, A., ABDELRAHIM, M. & ALBAN-
NAY, S. (2021), A study of the impact of major Urban Heat Island factors in a hot climate
courtyard : The case of the University of Sharjah, UAE. Sustainable Cities and Society,
69, 102844. https://doi.org/10.1016/j.scs.2021.102844.
SALUR, H. (2016), Avlulu Yapılarda Termal Konfor Analizi: Kayseri Köşk Medrese Örneği.
Erciyes Üniversitesi, Fen Bilimleri Enstitüsü, Mimarlık Anabilim Dalı, Doktora Tezi,
Kayseri, 106.
SOFLAEI, F., SHOKOUHIAN, M., ABRAVESHDAR, H. & ALIPOUR, A. (2017), The impact of
courtyard design variants on shading performance in hot- arid climates of Iran. Energy
and Buildings, 143, 71-83.
https://doi.org/http://dx.doi.org/10.1016/j.enbuild.2017.03.027.
SOFLAEI, F., SHOKOUHIAN, M., TABADKANI, A., MOSLEHI, H. & BERARDI, U. (2020), A sim-
ulation-based model for courtyard housing design based on adaptive thermal comfort.
Journal of Building Engineering, 31, 101335.
https://doi.org/10.1016/j.jobe.2020.101335.
SÖZEN, İ. & ORAL, G. K. (2019), Outdoor thermal comfort in urban canyon and courtyard in
hot arid climate: A parametric study based on the vernacular settlement of Mardin. Sus-
tainable Cities and Society, 48, 101398.
https://doi.org/https://doi.org/10.1016/j.scs.2018.12.026.
TALEGHANI, M., TENPIERIK, M., VAN DEN DOBBELSTEEN, A. & SAILOR, D. J. (2014), Heat in
courtyards : A validated and calibrated parametric study of heat mitigation strategies for
urban courtyards in the Netherlands. Solar Energy, 103, 108-124.
https://doi.org/http://dx.doi.org/10.1016/j.solener.2014.01.033.
UNAL CILEK, M. & CILEK, A. (2021), Analyses of land surface temperature (LST) variability
among local climate zones (LCZs) comparing Landsat-8 and ENVI-met model data. Sus-
tainable Cities and Society, 69, 102877. https://doi.org/10.1016/j.scs.2021.102877.
UNAL, M. & USLU, C. (2022), Modeling the relationship between the geometric characteris-
tics of urban green spaces and thermal comfort: The case of Adana city. Sustainable Cities
and Society, 79, 103748. https://doi.org/10.1016/j.scs.2022.103748.
WU, R., FANG, X., LIU, S. & MIDDEL, A. (2023), A fast and accurate mean radiant temperature
model for courtyards: Evidence from the Keyuan Garden in central Guangdong, China.
Building and Environment, 229, 109916.
https://doi.org/10.1016/j.buildenv.2022.109916.
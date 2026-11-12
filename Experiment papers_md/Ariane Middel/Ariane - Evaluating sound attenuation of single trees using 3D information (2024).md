Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
Evaluating sound attenuation of single trees using 3D information
Jian Lua, Fanhua Konga, *, Haiwei Yinb, Ariane Middelc, Jian Kangd, Zhihao Wena, Hongqing Liua
a School of Geography and Ocean Science, Nanjing University, Xianlin Ave.163, 210023, Nanjing, China
b School of Architecture and Urban Planning, Nanjing University, No. 22, Hankou Road, 210093, Nanjing,
China
c School of Arts, Media and Engineering, Arizona State University, 950 S. Forest Mall, Stauffer B258, 85281
Tempe, Arizona, USA
d Institute for Environmental Design and Engineering, University College London, United Kingdom
Abstract
Urban tree belts reduce noise pollution, but limited research has focused on the
mitigation potential of single trees. Identifying individual tree characteristics that influence
noise propagation can assist in selecting trees to improve urban soundscapes at multiple
scales. This study introduces a methodology to evaluate and predict the sound attenuation
of single trees using 3D tree morphology data and sound observations. We extracted
structural characteristics for 26 trees on Nanjing University’s Xianlin campus from
handheld terrestrial LiDAR. Second, the sound attenuation of each sample tree was
quantified systematically using a sound source and a receiver. The sound level meter was
placed in front of and behind each sample tree to record the received sound levels. The
sound source was positioned 1.5m above ground to emit white noise, ensuring the front
receiver recording sound levels of 55, 60, and 68 dBA. We established a support vector
regression (SVR) with a linear (LN) kernel to predict the sound attenuation of single trees
based on their 3D characteristics. Single trees yielded an insertion loss of 2-3 dBA,
effectively eliminating sound above 500 Hz and increasing with the frequency. It is also
interesting to note that the insertion loss increases with increasing source sound levels.
Regression analysis revealed that an increase in crown leaf area index (β = 0.332, p < 0.01)
and average leaf inclination (β = 0.168, p < 0.01) reduced sound significantly, indicating
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
the tree canopy's predominant role in impeding sound propagation. The SVR-LN model,
established using standardized parameters with statistical significance, exhibited strong
predictive sound attenuation performance using tree characteristics (R2=0.74, RMSE=0.38,
and MSE=0.15). This study addresses a research gap in the acoustic effects of single trees
and provides a framework for accurately evaluating and predicting sound attenuation based
on 3D characteristics. The findings can assist urban planners and policymakers in
strategically planting trees to foster healthier and quieter living spaces for residents.
Keywords: sound attenuation, single trees, LiDAR, 3D tree characteristics, support vector
machine prediction
* Corresponding author. School of Geography and Ocean Science, Nanjing University,
Xianlin Ave.163, 210023, Nanjing, China.
E-mail address: fanhuakong@nju.edu.cn (F. Kong).
Received 29 July 2023
Received in revised form 18 August 2024
Accepted 23 September 2024
Available online 11 October 2024
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
1 Introduction
In recent decades, noise pollution, as one of the primary environmental threats to
public health, has increased in magnitude and distribution. According to the European
Environment Agency (EEA, 2020), an estimated 113 million people were affected by long-
term daily noise levels of at least 55 dB, while 79 million people were exposed to night-
time noise levels of at least 50 dB. Accumulating evidence has confirmed prolonged noise
exposure can lead to various adverse health outcomes, such as high blood pressure,
cardiovascular disease, and suppressed immune function (Manuella Lech Cantuaria, 2023).
Moreover, noise pollution can cause cognitive impairment, induce stress responses, and
further alter the behavior of animals (Nelson-Olivieri et al., 2024). For example, animals
living in areas exposed to anthropogenic noise suffer from reduced reproductive success
and increased mortality (Lehnardt et al., 2024).
Multiple solutions are required to tackle this issue to achieve WHO's recommended
standards, which suggest maximum noise levels of 53 dB during the day and evening and
45 dB at night (WHO, 2018). Additionally, one of the zero pollution targets for 2030 is to
achieve a 30% reduction in the proportion of people chronically disturbed by transport
noise compared to levels observed in 2017 (EC, 2021). Therefore, strategies for noise
reduction have become increasingly and continuously important. Many technological
approaches to noise attenuation, such as synthetic noise barriers and sound-absorbing
materials, have been developed but can adversely impact urban ecosystems (Mitrus and
Zbyryt, 2018). In recent years, urban green infrastructure (UGI) has emerged as an
innovative and sustainable solution to alleviate noise. The acoustic effects of UGI can be
divided into ground interference, sound absorption, and sound redirection (Van
Renterghem et al., 2015). Specifically, porous surfaces beneath plants absorb and scatter
incident sound and destructively interfere with direct and ground-reflected sound
(Attenborough et al., 2016); vegetation absorbs noise by converting sound energy to heat
energy via mechanical vibrations of plant elements and air particles (Romanova et al.,
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
2019); and vegetation redirects sound propagation through reflection, scattering, and
diffraction (Yang et al., 2013a). In addition, UGI-based noise abatement solutions that
introduce natural sounds and pleasant landscapes can eliminate noise annoyance (Kong et
al., 2007) and improve public health (Buxton et al., 2021). Therefore, UGI is a viable noise
abatement strategy for urban soundscape management.
An essential requirement for using UGI for noise reduction is identifying the
vegetation parameters influencing acoustic effects. The normalized difference vegetation
index (NDVI) is an indicator widely applied to monitoring vegetation coverage at regional
scales and has been used to estimate noise levels in urban areas. Liu et al. (2020)
demonstrated that noise levels decreased with increased NDVI. However, NDVI is a two-
dimensional indicator commonly used to assess the qualitative relationship between noise
levels and green spaces rather than a morphological parameter required to evaluate the
impact of the three-dimensional (3D) vegetation structure on noise levels at small scales.
Several studies focused on morphological parameters that determine the acoustic
performance of UGI (Fang and Ling, 2003; Horoshenkov et al., 2013; Zhang et al., 2015;
Zhao et al., 2021). A soil experiment with acoustic impedance tubes indicated that key
parameters characterizing the acoustic effects of soils included porosity, pore size
distribution, flow resistivity, and moisture content (Horoshenkov and Mohamed, 2006; Van
Renterghem et al., 2021). It is worth noting that the ground effect is negligible when the
sound source and receiver are close (Attenborough et al., 2014). Horoshenkov et al. (2013)
used an equivalent fluid model to simulate sound propagation and revealed that the leaf
inclination, total area and weight of leaves, and leaf area density of trees influence the
thermoviscous absorption of sound. Fang and Ling (2003) investigated the noise reduction
capacity of 35 tree belts and found that visibility, width, height, and length of tree belts are
important noise reduction factors. However, traditional methods to sample vegetation
morphology, such as image processing (Zhu and Chen, 2023), usually cannot capture
detailed 3D information, leading to low accuracy in characterizing vegetation structures.
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
Light Detection and Ranging (LiDAR) has emerged as a novel and powerful
technique to accurately extract 3D vegetation characteristics (Newnham et al., 2015).
Various studies have used LiDAR for forestry surveying (Huang et al., 2022; Kong et al.,
2021), such as the assessment of above-ground biomass (Gonzalez de Tanago et al., 2018),
estimation of forest carbon stocks (Saatchi et al., 2011), exploration of vegetation cooling
effects (Kong et al., 2022; Kong et al., 2016), and investigation of forest phenology (Nunes
et al., 2022). Although LiDAR point clouds provide detailed information on plant structure,
they have received little attention in the study of the acoustic effects of vegetation. Existing
research primarily concentrates on tree belts rather than single trees (STs) that form the
belts. Understanding how STs impact sound propagation based on their 3D characteristics
will aid in selecting and arranging appropriate plants for effective noise abatement.
Therefore, more detailed and precise structural measurements are needed.
With the support of 3D vegetation information obtained from a handheld scanning
LiDAR point clouds and in-situ measured sound pressure level (SPL), this study aims to
examine how tree structure impacts sound attenuation. We then established a model
considering the fine-scale structural characteristics of trees to enhance the accuracy of
existing noise prediction models. The results of this study will be helpful to manage and
select trees to reduce noise pollution effectively (Fig. 1). The study was conducted in three
phases. First, we investigated the acoustic effects of STs in A-weighted decibels (dBA) and
SPL at different frequencies. Second, we extracted morphological parameters of STs from
point cloud data to assess the impacts of tree characteristics on sound attenuation. Lastly,
we used support vector regression (SVR) to predict the sound attenuation using 3D tree
characteristics.
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
Fig. 1. Flowchart for assessing and predicting the sound attenuation of single trees
using accurate 3D tree characteristics derived from a handheld scanning LiDAR.
2 Methods
2.1 Study site and tree selection
This study was conducted at the Xianlin Campus of Nanjing University (Lat:
32°6′53″N, Lon: 118°57′24″E) in Nanjing, Jiangsu Province, China. The Xianlin Campus
is adjacent to Yuanhua Road in the east, Metro Line 2 and Xianlin Avenue in the south,
Nanjing Bypass Highway and Jiuxianghe East Road in the west, and Weidi Road in the
north (Fig. 2a). Enclosed by transportation nodes, the acoustic environment on campus is
a complex mix of traffic and other anthropogenic noise. To find the time of day with
minimal background noise for our controlled experiment, we monitored the ambient noise
in an area with a high concentration of people for 24 hours on September 21 and 22, 2022
(the red star in Fig. 2a). The average daytime noise level (L ) reached 57.1 dBA (Fig. 2b),
day
exceeding the 55 dBA threshold permitted by the Ministry of Ecology and Environment of
the People's Republic of China (2008). The nighttime noise level (L ) was 45.9 dBA with
night
an average SPL of 51.7 dBA from 22:00h to 00:00h and 44.0 dBA from 00:00h to 06:00h
(Fig. 2c). Based on these measurements, we chose the 00:00h to 06:00h period to conduct
the field experiment.
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
Noise measurements were conducted near 26 trees distributed across six plots on
campus. All sample trees were street trees, planted in the soil near the roads and away from
buildings, ensuring as consistent experimental conditions as possible. To eliminate the
impacts of neighboring trees on the experimental results, we sampled trees with canopy
edges away from each other. Sampled species include Deodar Cedar (Cedrus deodara),
Chinese Hackberry (Celtis sinensis), cherry blossoms (Prunus subg. Cerasus), camphor
tree (Camphora officinarum), Chinese horse chestnut (Aesculus chinensis), Japanese
Zelkova (Zelkova serrata), and fragrant olive (Osmanthus fragrans) (the red circles in Fig.
2a and Appendix A).
Fig. 2. Study area and background noise. (a) The study area is surrounded by five roads
and a subway; the star represents the sampling point for background noise, while the circles
represent the field measurement locations. (b) L was measured from 06:00h to 22:00h
day
on September 21, 2022. (c) L was measured from 22:00h on September 21, 2022, to
night
06:00h on September 22, 2022.
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
2.2 Experimental design and field measurements
2.2.1 Noise field measurements
Given the varying sizes and shapes of the sample trees, we developed a flexible plan
for noise measurements. The sound source was placed 1.5 m above the ground at a distance
equivalent to the tree height (point S in Fig. 3a). The sound level meters were positioned
n
on the source-tree line in front of and behind the sample tree at the height of the crown
centroid to measure SPL in dBA and SPL in 1/1 octave bands (point 𝑅1 and 𝑅2 in Fig. 3a).
𝑛 𝑛
White noise was used to specifically analyze sound attenuation at different
frequencies attributed to a single tree. A wireless loudspeaker (Marshall Kilburn II, Zound
Industries Services Shenzhen Ltd.) was adjusted to produce constant white noise at each
sound source point S . The sound receiver points 𝑅1 were positioned in front of the sample
n 𝑛
tree to record SPLs of 55 dBA (Environmental Quality Standard for Noise in China (2008)
and Environmental noise in Europe (2020)), 60dBA, and 68 dBA (Annual Report on China
Environmental Noise Prevention and Control (2008)). White noise was generated with the
Adobe Audition CC2018 software (Adobe Systems Incorporated). At the sound receiver
points 𝑅1 and 𝑅2 , the SPL was measured with a sound level meter (AWA6292-1,
𝑛 𝑛
Hangzhou Aihua Instruments Co., Ltd). Successive measurements took 15 s at each point.
Noise measurements were conducted at three different directions around each tree (Fig.
3b). Accordingly, nine noise field measurements were conducted for each tree.
To prevent external sound interference, we conducted the field measurements between
00:00h and 06:00h am calm days (Appendix B). A total of 468 training datasets were
collected on six days from September 30 to October 22, 2022 (i.e., Sep.30, Oct.1, Oct.2,
Oct.12, Oct.20, and Oct.22, 2022), and 60 testing datasets were collected on two days (i.e.,
Jun.25 and 27, 2023). During our observations, temperatures and relative humidity
remained stable, except for lower temperatures on Oct. 12, Oct.20, and Oct.22, 2022.
2.2.2 Calculation for sound attenuation
Atmospheric absorption and sound reflection were not discussed in this study
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
Atmospheric absorption of sound depends on the frequency, temperature, humidity, and air
pressure (ISO9613-1, 1993). During our observations, temperatures and relative humidity
remained stable (Appendix B). Moreover, the effect of ground reflection was offset by
sound attenuation determined by the difference between SPLs in front of and behind the
tree. The sound reflection from buildings has also been neglected due to the significant
distance between trees and buildings. Consequently, we did not consider the atmospheric
absorption and the sound reflection under similar atmospheric conditions and planting
environments (Attenborough, 2007; Yang et al., 2013b).
The total sound attenuation (∆𝑆𝑃𝐿) by a single tree can be divided into two aspects:
insertion loss (IL) and sound attenuation resulting from geometric spreading (∆𝐿 )
𝐷
(Equation 1). Through observations, the ∆𝑆𝑃𝐿 can be obtained by the SPL difference in
front of (𝑆𝑃𝐿1 ) and behind (𝑆𝑃𝐿2 ) the sample tree (Equation 2). Therefore, the IL
𝑛 𝑛
generated by the tree itself, compared with the open ground (free field), can be estimated
by the difference between ∆𝑆𝑃𝐿 and ∆𝐿 (Equation 3). ∆𝐿 follows the inverse square law
𝐷 𝐷
(Equation 4) (Lee et al., 2008).
∆𝑆𝑃𝐿 = 𝐼𝐿+∆𝐿 (1)
𝐷
∆𝑆𝑃𝐿 = 𝑆𝑃𝐿1 − 𝑆𝑃𝐿2 (2)
𝑛 𝑛
𝐼𝐿 = ∆𝑆𝑃𝐿− ∆𝐿 (3)
𝐷
𝐷2
𝑛
∆𝐿 = 20lg( ) (4)
𝐷 𝐷1
𝑛
where 𝐷1 and 𝐷2 refers to the distances from the sound source to the front and back
𝑛 𝑛
receiver points (Fig.3b), respectively; n represents the nth measurement. In this study, the
D is the canopy width of each single tree, and the average width of the canopy is 5.25 m.
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
Fig. 3. Experimental design and field measurements: (a) layout plan of sound source point
S and sound receiver points 𝑅1 and 𝑅2; (b) noise measurements were conducted at three
n 𝑛 𝑛
different directions around each tree. Note that 𝐷1 and 𝐷2 are the distances between the
𝑛 𝑛
sound source and sound receiver points 𝑅1 and 𝑅2, respectively; H refers to the tree height;
𝑛 𝑛
H and H are the height of the trunk and canopy, respectively; W is the width of the canopy;
t c c
and n represents the nth measurement.
2.3 Morphological measurements of sample trees
2.3.1 3D laser scanning and point cloud data preprocessing
A handheld scanning LiDAR (LiGrip H120, GreenValley Co. Ltd) obtained the point
cloud data at six plots. The TSL device has a 360° horizontal and 280° vertical scanning
angle, a detection range of 120 m, and a scanning speed of 320,000 pts/s, enabling the
collection of high-accuracy point cloud data (≤3 cm). The scans were conducted on sunny
days with calm winds (September 12 and 13, 2022, Appendix B).
Since the point cloud data contained information about all objects near a sampling site,
including buildings and other vegetation, the target tree points were extracted manually and
then imported into the LiDAR360 software (GreenValley Co. Ltd) for preliminary data
preprocessing (i.e., denoising, ground point normalization). Leaf-wood separation was
conducted using the LoWoS method by Wang et al. (2020). The processed data were used
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
to calculate tree characteristic parameters.
2.3.2 Vegetation information extraction
We calculated nine tree characteristics for the 26 sample trees (Table 1). Crown height
(H ), crown width (W ), diameter at breast height (DBH), and trunk height (H) were
c c t
calculated using LiDAR360; Leaf area index of the crown (LAI ), average leaf inclination
c
of the crown (ALI), living vegetation volume of low-growing plants below the tree (LVV ),
L
crown volume (V ), and LAI of the low-growing plants (LAI ) were determined using a
c L
Python program.
Table 1. Description of tree characteristics.
Vegetation Morphological
Description
element parameters
Tree crown height is defined as the distance from
Height (H )
c the lowest branches to the top of the tree.
Canopy width is defined as the distance from one
Width (W ) edge to the other, passing through the center of the
c
crown.
LAI is a biophysical parameter representing half
Canopy
Leaf area index (LAI ) the total green leaf area per unit of the horizontal
c
ground surface.
Average leaf inclination ALI refers to the mathematical description of the
(ALI) angular orientation of plant leaves.
Canopy volume is a quantitative parameter used to
Volume (V )
c document the 3D size of a tree canopy.
Diameter at breast height DBH is the diameter of a tree trunk measured at
(DBH) breast height.
Trunk Trunk height is the vertical distance from the base
Height (H) of a tree to the point at which its stem meets the
t
first branch.
Living vegetation LVV refers to the total amount of space occupied
Low-growing L
volume (LVV ) by low-growing plants.
plant L
Leaf area index (LAI ) Same as the LAI mentioned above.
L
2.3.2.1 Leaf area index
The LAI of the sample trees was identified using the voxel-based canopy profiling
(VCP) approach developed by Hosoi and Omasa (2006). The pre-processed point cloud
was divided into i × j × k grids using Equation (5-7). Grids containing at least one point
were labeled 1; the remaining grids were labeled 0. The LAI was then determined by
calculating the ratio of the grids labeled 1 to the total number of grids for each plane and
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
then summarizing the results for all planes, as depicted by Equation (8).
𝑋 −𝑋
𝑖 = Int( 𝑚𝑖𝑛 ) (5)
∆𝑖
𝑌−𝑌
𝑚𝑖𝑛
𝑗 = Int( ) (6)
∆𝑗
𝑍−𝑍
𝑘 = Int( 𝑚𝑖𝑛 ) (7)
∆𝑘
𝑧=𝑘
𝑛 (𝑧)
𝐿𝐴𝐼 = 1.1× ∑ 1 (8)
𝑛 (𝑧)+𝑛 (𝑧)
0 1
𝑧=1
Where (i, j, k) refers to the voxel coordinates within the grids, and (X, Y, Z) represents
the point cloud coordinates of the LiDAR points. The minimum point cloud values in the
x, y, and z directions are denoted by 𝑋 , 𝑌 and 𝑍 , respectively, while (∆𝑖, ∆𝑗, ∆𝑘)
𝑚𝑖𝑛 𝑚𝑖𝑛 𝑚𝑖𝑛
signifies the voxel size. 𝑛 (𝑧) and 𝑛 (𝑧) are the grids labeled 1 and 0 at layer k,
1 0
respectively.
2.3.2.2 Leaf inclination
The ball-pivoting algorithm (BPA) was utilized to generate a triangle mesh that
approximates the curved surface of the leaf blade (Bernardini et al., 1999). BPA operates
by keeping a ball of radius ρ in contact with two neighboring points and pivoting the ball
until it touches the third point to form a triangle (i.e., three points (σ, σ, σ )), in which the
i j k
ball contains no additional points except those three points. Next, we computed the normal
vector n (x, y, z) of each triangle in the mesh using the function “triangle_normals” derived
from Open3D for calculating the angle between the normal vector and the z-axis (Zhou et
al., 2018), i.e., leaf inclination. The angle corresponding to the leaf inclination between
normal vector n (x, y, z) and z-axis (0, 0, 1) is determined using the following equation:
𝑎⃗ ×𝑏⃗⃗
𝜃 = arc cos (9)
|𝑎⃗|×|𝑏⃗⃗|
where 𝑎⃗ refers to the normal vector n (x, y, z) and 𝑏⃗⃗ represents the vector (0, 0, 1)
corresponding to the z-axis.
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
2.3.2.3 Vegetation volume
We employed a novel approach named the Layered Area Integral Method (LAIM) to
estimate the vegetation volume of the point cloud data (Kong et al., 2016). This method
slices the point cloud into equidistant horizontal layers along the z-axis. Each data layer is
then projected onto the x-y plane and transformed into a binary image (blank cells are
assigned 0, and others are assigned 1). We then calculate the point cloud area for each layer
by summarizing non-empty cells. Finally, the areas of all layers are integrated to obtain the
vegetation volume (Equation 10):
𝑛
𝑉 = ∑(𝑆 ×ℎ) (10)
𝑖
1
where ℎ is the height of each layer and 𝑆 is the area of each horizontal point cloud
𝑖
layer.
2.4 Multiple regression
Multiple regression is a statistical technique to analyze the relationship between a
single dependent variable and several independent variables. We used multiple regression
analysis to investigate how various 3D characteristics of STs impact their acoustic
performance. The total sound attenuation for each tree is the dependent variable, and the
independent variables are the 3D tree characteristics derived from point cloud data, i.e., H ,
c
W , LAI , ALI, V , DBH, H, LVV , and LAI .
c c c t L L
2.5 Sound attenuation prediction based on support vector regression
2.5.1 Principles of support vector regression
Support vector machine (SVM), a machine learning algorithm rooted in statistical
learning theory, has gained widespread popularity across various fields, including pattern
recognition, regression analysis, and time series prediction (Kim, 2003; Noble, 2006).
SVM can effectively handle high-dimensional data and provide reliable classifications. We
utilized Support vector regression (SVR), a highly versatile algorithm based on the concept
of SVM, to forecast the sound attenuation potential of STs. SVR aims to find a function
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
f(x) that does not deviate more than ε from a target value  y for all the training data while
i
remaining as flat as possible, as illustrated below (Smola and Schölkopf, 2004):
|     | 𝑓(𝑥) | =< 𝑤·𝑥 | > +𝑏  |     | (11)  |
| --- | ---- | ------ | ----- | --- | ----- |
where 𝑤  denotes the weighted vector, 𝑥  is the input data point, and 𝑏  is the bias.
Flatness in Equation (11) is a result of a small 𝑤. One optimization method is as follows:
1
|     |     | minimize  | ‖𝑤‖2  |     |     |
| --- | --- | --------- | ----- | --- | --- |
(12)
2
|     |     | subject to |𝑦 | −𝑓(𝑥 | )| ≤ ε  |     |
| --- | --- | ------------- | ---- | ------- | --- |
𝑖 𝑖
The slack variables 𝜉   and 𝜉∗  are introduced to allow 𝑦   to deviate within a given
|     | 𝑖   | 𝑖   |     | 𝑖   |     |
| --- | --- | --- | --- | --- | --- |
range. Equation (12) can be rewritten as follows:
1
| minimize  |     | ‖𝑤‖2 +𝐶∑𝑛 |     | (𝜉 +𝜉∗)  |     |
| --------- | --- | --------- | --- | -------- | --- |
|           |     |           | 𝑖=1 | 𝑖 𝑖      |     |
2
|     |     | −𝑓(𝑥 | )     |             |       |
| --- | --- | ---- | ----- | ----------- | ----- |
|     |     | 𝑦    | ≤ ε+𝜉 | ,𝑖 = 1,2…,𝑛 |       |
|     |     | 𝑖    | 𝑖     | 𝑖           | (13)  |
ε+𝜉∗,𝑖
| subject to {𝑓(𝑥 |     | )−𝑦 | ≤   | = 1,2…,𝑛  |     |
| --------------- | --- | --- | --- | --------- | --- |
|                 |     | 𝑖   | 𝑖   | 𝑖         |     |
,𝜉∗
|     |     | 𝜉   | ≥ 0,𝑖 | = 1,2…,𝑛   |     |
| --- | --- | --- | ----- | ---------- | --- |
𝑖 𝑖
The constant C > 0 determines the trade-off between the flatness of the function f(x)
and the amount up to which deviations greater than ε are tolerated. SVR can finally be
expressed using the Lagrange Multiplier Method as follows:
𝑛
| 𝑓(𝑥) | = ∑(𝛼 | −𝛼∗)𝐾(𝑥 |     | ,𝑥)+𝑏  | (14)  |
| ---- | ----- | ------- | --- | ------ | ----- |
|      |       | 𝑖       | 𝑖 𝑖 |        |       |
𝑖=1
 and 𝛼∗ are Lagrange multipliers, and 𝐾(𝑥 ,𝑥) refers to the kernel function.
Where 𝛼
| 𝑖 𝑖 |     |     |     | 𝑖   |     |
| --- | --- | --- | --- | --- | --- |
2.5.2 Selection of kernel function
The type of kernel function directly impacts the prediction accuracy and is a critical
step in the SVR algorithm. Commonly used kernels include linear (LN), sigmoid (SIG),
polynomial (PL), and radial basis functions (RBF) (Tehrany et al., 2015). Accordingly, we
evaluated four kernel functions to find the one with the highest prediction accuracy: SVR-
LN, SVR-SIG, SVR-PL, and SVR-RBF.
2.5.3 Training and testing datasets
SVR requires training and testing data to implement and evaluate a predictive model.
To illustrate the universality of the developed model, we constructed the training dataset
using the 3D characteristics and sound attenuation of the 26 sample trees. We collected
additional  testing  data  on  five  common  street  trees:  southern  magnolia  (Magnolia
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
grandiflora), Japanese maple (Acer palmatum), fragrant olive (Osmanthus fragrans),
cherry blossoms (Prunus subg. Cerasus), and camphor tree (Camphora officinarum)
(Appendix C).
The point cloud and noise data for the testing trees were collected on June 25th and
27th, 2023 (Appendix B). Since the sound of crickets during the summer might interfere
with the accuracy of the results, we increased the source sound levels to 60 dBA and 68
dBA. All subsequent data processing followed the methods described in Section 2.3. Data
on tree characteristics was standardized for training and testing, which eliminates the
effects of differences in scales and units.
3 Results
First, this section provides an overview of the sample tree characteristics extracted
from the point cloud data. Next, we summarize descriptive statistics on the sound
attenuation performance of all sample trees by tree species, frequency, and source sound
levels. Third, multiple regression results are presented to investigate the main drivers of
sound attenuation among 3D tree characteristics. Lastly, we show support vector regression
results on predicting sound attenuation induced by STs using their 3D characteristics.
3.1 Sample tree characteristics
The morphological structure of the 26 sample trees varied widely (Table 2), with
canopies ranging in height from 3.02 (Tree #17, fragrant olive (Osmanthus fragrans)) to
9.67 m (Tree #5, Chinese Hackberry (Celtis sinensis)) and width from 3.37 (Tree #18,
fragrant olive (Osmanthus fragrans)) to 7.29 m (Tree #8, Chinese horse chestnut (Aesculus
chinensis). Trees also exhibited varying leaf morphologies, with LAI ranging from 0.47
c
(Tree #16, camphor tree (Camphora officinarum)) to 4.57 (Tree #12, fragrant olive
(Osmanthus fragrans)) and ALI around 90° (+ 8.37°). The largest tree had a canopy volume
of 64.67 m3 (Tree #7, camphor tree (Camphora officinarum)), and the smallest was 2.82
m3 (Tree #18, fragrant olive (Osmanthus fragrans)). Meanwhile, the DBH ranged from 0.11
to 0.39 m, and the maximum trunk height was 3.09 m (Tree #16, camphor tree (Camphora
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
officinarum)). The varying leaf density affected the transmissivity of the trees, resulting in
vegetation variations underneath, with LVV ranging from 0 (Tree #19 and #20, Deodar
L
Cedar (Cedrus deodara)) to 2.83 m3 (Tree #7, camphor tree (Camphora officinarum)), and
LAI ranging from 0 (Tree #19 and #20, Deodar Cedar (Cedrus deodara)) to 2.58 (Tree
L
#10, Chinese horse chestnut (Aesculus chinensis)).
Table 2. Statistical information regarding tree characteristics of 26 sample trees.
Number Canopy Trunk Low-growing plant
Tree species
(#)
Hc (m) Wc (m) LAIc ALI (°) Vc (m3) DBH (m) Ht (m) LVVL (m3) LAIL
Deodar Cedar
1 7.02 5.30 1.21 93.65 14.59 0.20 0.83 0.78 1.63
(Cedrus deodara)
Deodar Cedar
2 5.81 4.84 2.14 98.37 20.01 0.20 0.87 0.69 1.96
(Cedrus deodara)
Chinese
3 Hackberry (Celtis 6.71 6.73 2.56 93.89 10.86 0.22 1.65 0.64 2.08
sinensis)
cherry blossoms
4 (Prunus subg. 4.59 5.53 1.57 92.88 15.92 0.26 1.29 1.60 2.39
Cerasus)
Chinese
5 Hackberry (Celtis 9.67 6.53 1.56 93.32 37.05 0.22 2.52 0.65 2.26
sinensis)
camphor tree
6 (Camphora 6.40 6.89 1.66 93.97 22.17 0.29 1.66 1.44 2.29
officinarum)
camphor tree
7 (Camphora 7.58 5.38 2.44 93.16 64.67 0.27 2.42 2.83 1.60
officinarum)
Chinese
horse chestnut
8 7.10 7.29 1.23 94.16 25.37 0.25 2.12 1.00 1.85
(Aesculus
chinensis)
Japanese Zelkova
9 7.42 6.23 0.76 97.00 44.25 0.29 1.70 0.27 0.89
(Zelkova serrata)
Chinese horse
10 chestnut (Aesculus 7.02 4.53 2.44 93.89 50.90 0.18 1.19 0.28 2.58
chinensis)
fragrant olive
11 (Osmanthus 4.14 5.10 3.48 92.35 10.94 0.21 1.82 0.49 1.52
fragrans)
fragrant olive
12 (Osmanthus 5.76 5.96 4.57 92.20 17.54 0.23 1.56 0.42 1.32
fragrans)
camphor tree
13 (Camphora 4.84 5.01 1.03 91.18 15.91 0.21 2.46 0.11 2.04
officinarum)
camphor tree
14 (Camphora 3.57 5.01 1.02 92.02 9.59 0.21 2.70 0.12 2.05
officinarum)
camphor tree
15 (Camphora 6.49 6.54 0.84 91.09 59.93 0.23 2.75 0.07 1.15
officinarum)
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
camphor tree
16 (Camphora 6.85 7.09 0.47 90.97 30.81 0.26 3.09 0.00 0.87
officinarum)
fragrant olive
17 (Osmanthus 3.02 3.46 1.03 91.35 7.55 0.11 0.92 0.12 1.02
fragrans)
fragrant olive
18 (Osmanthus 3.51 3.37 0.69 91.30 2.82 0.11 0.80 0.86 0.94
fragrans)
Deodar Cedar
19 5.14 3.99 0.56 91.32 8.50 0.33 0 0 0
(Cedrus deodara)
Deodar Cedar
20 5.23 3.87 1.29 91.38 20.02 0.39 0 0 0
(Cedrus deodara)
fragrant olive
21 (Osmanthus 4.00 4.48 0.83 91.86 16.26 0.23 1.24 0.15 0.88
fragrans)
fragrant olive
22 (Osmanthus 3.20 4.49 0.72 91.78 15.12 0.27 1.49 0.11 0.85
fragrans)
fragrant olive
23 (Osmanthus 5.13 4.89 1.12 91.67 14.48 0.31 1.31 0.11 1.02
fragrans)
fragrant olive
24 (Osmanthus 3.22 4.04 0.86 91.59 12.21 0.24 1.18 0.21 0.99
fragrans)
fragrant olive
25 (Osmanthus 3.94 4.63 0.82 91.51 17.60 0.34 0.82 0.13 0.73
fragrans)
fragrant olive
26 (Osmanthus 4.53 5.30 1.30 91.33 23.94 0.31 0.97 0.20 0.80
fragrans)
3.2 Sound attenuation of single trees
The average IL generated by a single tree was approximately 2-3 dBA, while the
total sound attenuation ranged from 6 to 8 dBA when integrating the contribution of
geometric spreading within the canopy. We calculated the average SPL at each frequency
for three source sound gradients to investigate the sound attenuation at different
frequencies in front of and behind trees. The variations of SPL in 1/1 octave bands
revealed that sound attenuation was positively correlated with frequency (Fig. 4). The
sampled trees reduced sound above 31.5 Hz, with sound attenuation ranging from 3.1 to
12.7 dB, 4.3 to 12.8 dB, and 5.0 to 12.6 dB for frequencies ranging from 500 to 16000
Hz, respectively. The sound attenuation effectiveness varied among the 26 tree samples,
but the trees yielded a similar sound attenuation across frequencies (Fig. 5).
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
Table 3. Sound attenuation of 26 sample trees.
|     |     | ΔSPL (dBA)  |     | IL (dBA)  |     |
| --- | --- | ----------- | --- | --------- | --- |
Number
|      | Tree species  | 55  60    | 68       | 55  60    | 68       |
| ---- | ------------- | --------- | -------- | --------- | -------- |
| (#)  |               |           | Average  |           | Average  |
|      |               | dBA  dBA  | dBA      | dBA  dBA  | dBA      |
Deodar Cedar (Cedrus
| 1   |     | 5.1  5.5  | 5.8  5.5  | 1.0  1.4  | 1.7  1.3  |
| --- | --- | --------- | --------- | --------- | --------- |
deodara)
Deodar Cedar (Cedrus
| 2   |     | 7.3  8.2  | 8.3  7.9  | 2.9  3.8  | 3.9  3.5  |
| --- | --- | --------- | --------- | --------- | --------- |
deodara)
Chinese Hackberry
| 3   |     | 5.1  6.3  | 6.1  5.8  | 0.4  1.6  | 1.4  1.2  |
| --- | --- | --------- | --------- | --------- | --------- |
(Celtis sinensis)
cherry blossoms
| 4   |     | 5.8  6.4  | 6.8  6.3  | 0.4  1.0  | 1.4  0.9  |
| --- | --- | --------- | --------- | --------- | --------- |
(Prunus subg. Cerasus)
Chinese Hackberry
| 5   |     | 5.8  5.8  | 6.6  6.1  | 2.6  2.6  | 3.4  2.8  |
| --- | --- | --------- | --------- | --------- | --------- |
(Celtis sinensis)
camphor tree
| 6   |     | 6.3  6.3  | 6.6  6.4  | 1.4  1.4  | 1.7  1.5  |
| --- | --- | --------- | --------- | --------- | --------- |
(Camphora officinarum)
camphor tree
| 7   |     | 5.6  6.2  | 6.7  6.2  | 2.3  2.9  | 3.4  2.9  |
| --- | --- | --------- | --------- | --------- | --------- |
(Camphora officinarum)
Chinese horse chestnut
| 8   |     | 6.7  8.3  | 8.5  1.8  | 2.2  3.8  | 4.0  3.3  |
| --- | --- | --------- | --------- | --------- | --------- |
(Aesculus chinensis)
Japanese Zelkova
| 9   |     | 5.8  6.2  | 6.5  6.2  | 1.7  2.1  | 2.4  2.1  |
| --- | --- | --------- | --------- | --------- | --------- |
(Zelkova serrata)
Chinese horse chestnut
| 10  |     | 5.3  5.8  | 6.0  5.7  | 1.8  2.3  | 2.5  2.2  |
| --- | --- | --------- | --------- | --------- | --------- |
(Aesculus chinensis)
fragrant olive
| 11  |     | 7.4  9.0  | 9.1  8.5  | 2.5  4.1  | 4.2  3.6  |
| --- | --- | --------- | --------- | --------- | --------- |
(Osmanthus fragrans)
fragrant olive
| 12  |     | 8.4  10.2  | 10.8  9.8  | 3.7  5.5  | 6.1  5.1  |
| --- | --- | ---------- | ---------- | --------- | --------- |
(Osmanthus fragrans)
camphor tree
| 13  |     | 7.8  8.0  | 8.5  8.1  | 3.8  4.0  | 4.5  4.1  |
| --- | --- | --------- | --------- | --------- | --------- |
(Camphora officinarum)
camphor tree
| 14  |     | 6.1  6.6  | 7.4  6.7  | 1.6  2.1  | 2.9  2.2  |
| --- | --- | --------- | --------- | --------- | --------- |
(Camphora officinarum)
camphor tree
| 15  |     | 6.3  7.1  | 7.4  6.9  | 2.2  3.0  | 3.3  2.9  |
| --- | --- | --------- | --------- | --------- | --------- |
(Camphora officinarum)
camphor tree
| 16  |     | 6.8  7.0  | 7.3  7.0  | 2.7  2.9  | 3.2  3.0  |
| --- | --- | --------- | --------- | --------- | --------- |
(Camphora officinarum)
fragrant olive
| 17  |     | 10.6  11.7  | 12.0  11.4  | 5.3  6.4  | 6.7  6.1  |
| --- | --- | ----------- | ----------- | --------- | --------- |
(Osmanthus fragrans)
fragrant olive
| 18  |     | 7.0  7.6  | 7.7  7.4  | 2.2  2.8  | 2.9  2.6  |
| --- | --- | --------- | --------- | --------- | --------- |
(Osmanthus fragrans)
Deodar Cedar (Cedrus
| 19  |     | 7.0  7.6  | 8.4  7.7  | 2.1  2.7  | 3.5  2.8  |
| --- | --- | --------- | --------- | --------- | --------- |
deodara)
Deodar Cedar (Cedrus
| 20  |     | 7.4  7.5  | 8.1  7.7  | 2.7  2.8  | 3.4  3.0  |
| --- | --- | --------- | --------- | --------- | --------- |
deodara)
fragrant olive
| 21  |     | 7.0  7.5  | 7.4  7.3  | 2.0  2.5  | 2.4  2.3  |
| --- | --- | --------- | --------- | --------- | --------- |
(Osmanthus fragrans)
fragrant olive
| 22  |     | 7.9  9.0  | 8.9  8.6  | 2.4  3.5  | 3.4  3.1  |
| --- | --- | --------- | --------- | --------- | --------- |
(Osmanthus fragrans)
fragrant olive
| 23  |     | 9.1  9.6  | 9.8  9.5  | 4.6  5.1  | 5.3  5.0  |
| --- | --- | --------- | --------- | --------- | --------- |
(Osmanthus fragrans)
fragrant olive
| 24  |     | 7.1  7.6  | 7.6  7.4  | 1.7  2.2  | 2.2  2.0  |
| --- | --- | --------- | --------- | --------- | --------- |
(Osmanthus fragrans)
fragrant olive
| 25  |     | 7.6  8.6  | 8.7  8.3  | 1.9  2.9  | 3.0  2.6  |
| --- | --- | --------- | --------- | --------- | --------- |
(Osmanthus fragrans)
fragrant olive
| 26  |     | 8.1  8.8  | 9.2  8.7  | 2.5  3.2  | 3.6  3.1  |
| --- | --- | --------- | --------- | --------- | --------- |
(Osmanthus fragrans)

Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
Fig. 4. Overall sound attenuation for 26 sample trees: (a) average sound attenuation
corresponding to three source sound levels, and (b) sound attenuation at various
frequencies.
The sound gradient measurements averaged by tree species showed sound
attenuation differently (Deodar Cedar (Cedrus deodara), 7.2 ± 0.5 dBA, Chinese
Hackberry (Celtis sinensis), 6.1 ± 0.6 dBA, camphor tree (Camphora officinarum), 6.9
± 0.4 dBA, Chinese horse chestnut (Aesculus chinensis), 7.1 ± 1.0 dBA, fragrant olive
(Osmanthus fragrans), 9.0 ± 1.0 dBA, and others (including cherry blossoms (Prunus
subg. Cerasus) and Japanese Zelkova (Zelkova serrata)), 6.3 ± 0.5 dBA) (Fig. 5a). The
SPL in the 1/1 octave bands for all tree species showed a consistent pattern, increasing
with frequency and following the overall trend. Sound attenuation levels peaked at
around 125 Hz, then slightly decreased until 500 Hz before resuming their upward trend
at higher frequencies (Fig. 5b-5g).
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
Fig. 5. Sound attenuation by tree species: (a) sound attenuation for all tree species, (b)
Deodar Cedar (Cedrus deodara), (c) Chinese Hackberry (Celtis sinensis), (d) camphor tree
(Camphora officinarum), (e) Chinese horse chestnut (Aesculus chinensis), (f) fragrant olive
(Osmanthus fragrans), and (g) others (including cherry blossoms (Prunus subg. Cerasus)
and Japanese Zelkova (Zelkova serrata)).
STs provide consistent effectiveness in sound attenuation, determined by their 3D
characteristics rather than sound exposure levels. We calculated the sound attenuation
proportional for each source sound level (55dBA, 60dBA, and 68dBA) by dividing the
respective attenuation values by the sum of all attenuation values obtained from the three
sound gradient measurements. Our findings show that the reduction proportion for each
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
tree was approximately 33% (Tree #12, fragrant olive (Osmanthus fragrans) has a
maximum of 37%, and Tree #8, Chinese horse chestnut (Aesculus chinensis), has a
minimum of 28%) (Fig. 6). Combining the results from Fig. 4 to Fig. 6, there seems to be
greater sound attenuation by STs at higher exposure levels. This phenomenon could be
attributed to foliage absorbing sound by converting sound energy into heat energy through
the mechanical vibration of leaves (Li and Kang, 2020). Exposed to higher SPLs
corresponding to increased sound pressures, there are more mechanical vibrations of
foliage and enhanced sound absorption, resulting in greater sound attenuation.
Fig. 6. The sound attenuation for each tree corresponding to the three source sound levels.
3.3 Correlations between tree characteristics and sound attenuation
Using multiple linear regression analysis, we investigated the statistical relationship
between sample tree characteristics (independent variables) and the total sound attenuation
(dependent variable). All variables in the study passed the hypothesis test, with a Durbin
Watson (DW) value of 1.753 and variance inflation factors (VIF) below 5. The regression
analysis revealed that H , LAI , ALI, and LAI are the main drivers of sound attenuation
c c L
(Table 4). LAI
c
has a strongly positive coefficient (β = 0.332, p < 0.01), suggesting that it
is the most important sound attenuation factor, with ALI of the canopy also having an
advantageous effect (β = 0.168, p < 0.01). LAI and H , conversely, have negative
L c
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
correlations with sound attenuation (β = -0.438, p < 0.01, and β = -0.295, p < 0.01,
respectively). Other tree characteristics are not statistically significant, implying these
morphological characteristics do not strongly influence sound attenuation.

Table 4. Multiple linear regression results for sound attenuation as dependent variable and
tree characteristics as independent variables.
|           |     | Unstandardized  |     |     | Standardized  |     | (n=234, R2=0.663,  |       |      |
| --------- | --- | --------------- | --- | --- | ------------- | --- | ------------------ | ----- | ---- |
| Variable  |     | Coefficients    |     |     | Coefficients  |     |  DW=1.753)         |       | VIF  |
|           |     |                 | B   |     |               | β   | t                  | Sig.  |      |

| Constant  |       |     | 1.093   |     |         |     | 0.354   | 0.723  |        |
| --------- | ----- | --- | ------- | --- | ------- | --- | ------- | ------ | ------ |
|           | H **  |     | -0.278  |     | -0.295  |     | -2.849  | 0.005  | 4.297  |
c
|     |  W  |     | 0.040  |     | 0.028  |     | 0.255  | 0.799  | 4.788  |
| --- | --- | --- | ------ | --- | ------ | --- | ------ | ------ | ------ |
c
|  LAI | **  |     | 0.547  |     | 0.332  |     | 5.841  | 0.000  | 1.288  |
| ---- | --- | --- | ------ | --- | ------ | --- | ------ | ------ | ------ |
c
|  ALI**  |        |     | 0.100   |     | 0.168   |     | 3.046   | 0.003  | 1.222  |
| ------- | ------ | --- | ------- | --- | ------- | --- | ------- | ------ | ------ |
|         |  V c   |     | -0.014  |     | -0.163  |     | -1.874  | 0.062  | 3.041  |
|         |  DBH   |     | -3.167  |     | -0.127  |     | -1.850  | 0.066  | 1.888  |
|         | H  t   |     | 0.282   |     | 0.143   |     | 1.518   | 0.130  | 3.533  |
|         | LVV    |     | 0.249   |     | -0.100  |     | -1.623  | 0.106  | 1.530  |
L
| LAI | **  |     | -0.989  |     | -0.438  |     | -5.578  | 0.000  | 2.460  |
| --- | --- | --- | ------- | --- | ------- | --- | ------- | ------ | ------ |
L
*Indicates statistical significance at the 5% level (two-tailed).
*Indicates statistical significance at the 1% level (two-tailed).

3.4 Prediction for sound attenuation using relevant tree characteristics
SVR  was  used  to  predict  the  total  sound  attenuation  considering  statistically
significant tree characteristics, i.e., H , LAI , ALI, and LAI . The four kernels SVR-LN,
|     |     |     |     |     | c   | c   |     | L   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
SVR-SIG, SVR-PL, and SVR-RBF yielded a confidence of 77.2%, 44.7%, 15.4%, and
58.3%, respectively (Table 5). SVR-LN had the highest confidence, indicating it is the most
appropriate model for accurately predicting sound attenuation by STs.

Table 5. Confidences of four SVR kernel types.
|     | Kernel      |     |     | Linear  |     | Sigmoid  |     | Polynomial  | RBF    |
| --- | ----------- | --- | --- | ------- | --- | -------- | --- | ----------- | ------ |
|     | Confidence  |     |     | 77.2%   |     | 44.7%    |     | 15.4%       | 58.3%  |

Comparing predicted and observed values of the testing dataset (Table 6) shows a
good model fit (R2=0.74, RMSE=0.38, and MSE=0.15), which suggests that predicting the
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
sound attenuation based on 3D tree characteristics is feasible. The predictive SVR-LN
model has the potential to predict the sound attenuation of trees in various urban settings,
providing valuable information for urban planners and policymakers when making
decisions related to the management and maintenance of urban soundscapes.
Table 6. Detailed information regarding sound attenuation and 3D characteristics of five
trees (testing data).
Total sound attenuation (dBA)
Tree species H (m) LAI ALI (°) LAI
c c L
Actual values Predicted values
southern magnolia
(Magnolia 6.43 1.44 89.97 0.32 9.5 9.4
grandiflora)
Japanese maple
2.30 1.30 95.80 1.52 8.0 8.1
(Acer palmatum)
fragrant olive
2.84 2.97 93.52 0.17 10.2 10.5
(Osmanthus fragrans)
cherry blossoms
(Prunus subg. 3.23 1.64 96.72 0.50 8.6 9.3
Cerasus)
camphor tree
(Camphora 5.32 2.49 90.67 0.61 9.3 9.6
officinarum)
4 Discussion
4.1 The contributions of single trees to urban noise reduction
Trees play an important role in urban soundscapes, and single trees can provide an IL
of 2-3 dBA and a total sound attenuation of 6-8 dBA, attributed to their 3D characteristics.
Similar outcomes have been achieved when considering a single tree as a tree belt with a
restricted depth of approximately 5-6 m. For example, a pioneering study by Kragh (1981)
on the acoustic effects of tree belts revealed that a 3 m deep tree belt exhibited an IL of 0-
1 dBA, while a dense, mature coniferous tree belt achieved an IL of 3-5 dBA. Fang and
Ling (2005) reported a noise reduction of approximately 3 dBA for a Casuarina
equisetifolia tree belt with a depth of 3 m. Furthermore, Ow and Ghosh (2017) found a
noise reduction of 2 dBA for a sparsely to moderately planted tree belt compared to open
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
ground. Our findings are in line with other studies’ results that trees are more effective at
attenuating sound waves with middle to high frequencies (>500Hz) than low-frequency
sound waves (Gaudon et al., 2022; Pal et al., 2000; Tyagi et al., 2006; Yang, 2013). We
observed a sound attenuation pattern that starts at 31.5 Hz, peaks locally between 125 and
250 Hz, slightly decreases until 500 Hz, and then displays a progressive increase (Fig.4
and 5). Our experimental results highlight the significant contribution of individual trees
to localized noise reduction, e.g., planting single trees in front of apartment windows,
particularly for areas consistently exposed to high-frequency noise; however, since a single
tree is the smallest element of tree belts and other green spaces, the evaluation of the
effectiveness and characteristics of a single tree is essential for comprehensive noise
reduction strategies through the implementation of vegetation belts in places where the
acoustic environment cannot meet the noise standard, e.g., in residential areas, at schools,
hospitals, etc. Therefore, our observations suggest that strategic tree planting could
potentially reduce average traffic noise levels from 68 dBA to meet the recommended
threshold of 60 dBA set by the “China Environmental Noise Prevention and Control
(2008)”.
4.2 Increasing sound attenuation of single trees through denser canopy
Tree canopy plays a predominant role in sound attenuation, and the LAI is the most
c
crucial parameter that determines the acoustic performance of STs. The above-ground part
of a single tree includes a trunk and the canopy comprising branches and abundant foliage.
Compared to tree belts composed of numerous trees, contributions from the canopy on
sound attenuation are more significant than those from trunks and forest floors. A study by
Yang et al. (2013b) who quantified scattered sound energy from a single tree in field
experiments using reverberation time also highlighted the importance of the tree crown.
The interaction between sound waves and vegetation elements is a complex process that is
affected by multiple factors. Our findings suggest that H , LAI , ALI, and LAI are the main
c c L
determinants in reducing noise. These results are supported by prior observations that
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
increased LAI and ALI of trees reduce noise (Horoshenkov et al., 2013; Karbalaei et al.,
c
2015; Xu et al., 2022). The leaf inclination determines the effective path length through
which the incident sound waves propagate. Larger leaf inclination means that more leaves
are perpendicular to the direction of the incident sound waves, resulting in greater sound
absorption by leaves due to thermo-viscous effects and damped vibrations. LAI, defined as
the one-sided leaf area per unit of horizontal ground surface area (Weiss et al., 2004),
quantifies the leaf amount in a canopy. Canopies with higher LAI typically have more
leaves and fewer gaps through which incident sound waves can propagate. In contrast,
regression results indicated a negative impact of canopy height on the acoustic effects of
STs. A higher canopy usually exhibits more gaps through which more sound waves
penetrate while the leaf area index remains constant. Lastly, we found that trees with greater
leaf inclination are more effective in reducing noise. However, controlling leaf inclination
in street trees is challenging, as it depends on plant physiology and is determined by plant
hormones regulated by environmental stresses (Xu et al., 2021). Noise reduction policies
on street trees should focus on the leaf area density instead, which is easier to control.
4.3 Limitations and prospects
Our work has several limitations concerning the data collection, analysis, and
interpretation of results. First, our tree sampling protocol restricted the number of trees
eligible for the study. Sample trees had to have canopies apart from neighboring trees and
be located away from the residential areas on campus due to nighttime noise measurement
requirements. These restrictions resulted in a smaller sample size of the STs. We selected
different tree species commonly planted in Nanjing to explore the influence of tree structure
characteristics on sound attenuation. However, limited by the number of samples for each
species (e.g., Osmanthus fragrans has ten samples, and Prunus subg. Cerasus has one
sample), we cannot provide recommendations on the best species for noise reduction.
Future studies should assess the typical sound attenuation of various tree species using
larger sample sizes and further investigate the enhanced sound attenuation by STs at higher
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
exposure levels, also considering the sensitivity or tolerance to other urban stressors (e.g.,
heat and drought). Second, our study did not investigate seasonal effects. Our findings
revealed that most of the sound attenuation by STs stems from the canopy, and leaves play
a crucial role in acoustic performance due to interactions between the leaves and sound
waves. However, deciduous trees exhibit variations in leaf biomass across different seasons,
leading to inevitable changes in sound attenuation from the peak foliage to the leaf-off
season. Further research is needed to investigate the seasonal acoustic performance of STs
under varying leaf biomass conditions to develop more accurate and effective noise
regulation strategies. Third, we found a statistically significant inverse relationship
between LAI and sound attenuation. This result contradicts findings from another study
L
reporting that shrubs enable trees to provide better sound attenuation (Fang and Ling, 2003;
Van Renterghem et al., 2012) and requires further data collection and study.
5 Conclusions
The findings of this study show that the 3D morphological characteristics of a single
tree influence sound propagation, and a single tree can reduce urban noise. Handheld
LiDAR scans and acoustic field measurements were conducted to explore the sound
attenuation of STs and the driving morphological and foliage characteristics. The impact
of tree characteristics on sound attenuation varied, resulting in IL and total sound
attenuation ranging from 2 to 3 dBA and 6 to 8 dBA, respectively. The most significant
reduction was observed above 500 Hz. Of interest here was that sound attenuation by STs
slightly increased with higher source sound levels. Regression analysis showed that trees
with higher LAI provided more sound attenuation benefits, which has practical
c
implications as it directly informs the choice of appropriate tree species to alleviate urban
noise problems and improve urban soundscapes. Utilizing trees to reduce noise is
constrained by the requirement for more extensive spaces compared with rigid noise
barriers, which creates a trade-off with available space in rights-of-way. Therefore, it is
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
recommended to use small trees with high leaf density for effective and comprehensive
noise abatement.
The SVR-LN model based on tree morphology and foliage characteristics predicted
sound attenuation induced by STs well (R2=0.74, RMSE=0.38, and MSE=0.15). Our
prediction approach facilitates the evaluation of urban soundscapes at pedestrian-relevant
scales and can guide environmental noise management in diverse urban contexts. The
developed predictive model, if integrated into comprehensive noise mapping strategies,
will be helpful for urban planning and policymaking to evaluate, manage, and mitigate
urban noise pollution.
CRediT authorship contribution statement
Jian Lu: Writing – review & editing, Writing – original draft, Methodology,
Investigation, Formal analysis, Data curation. Fanhua Kong: Writing – original draft,
Supervision, Software, Resources, Project administration, Methodology, Investigation,
Conceptualization. Haiwei Yin: Writing – review & editing, Resources, Methodology, Data
curation. Ariane Middel: Writing – review & editing. Jian Kang: Writing – review & editing.
Zhihao Wen: Investigation. Hongqing Liu: Investigation.
Data availability
Data will be made available on request.
Acknowledgments
The study was supported by the National Natural Science Foundation of China (No.
32171571), the National Key R&D Program of China (No. 2022YFF1303102), and Global
Engagement for Strategic Partnership Project of Nanjing University.
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
Declaration of competing interest
The authors declare that they have no known competing financial interests or personal
relationships that could have appeared to influence the work reported in this paper
Appendix A. Supplementary data Supplementary data to this article can be found online
at https://doi. org/10.1016/j.jenvman.2024.122818.
References
Attenborough, K., 2007. Sound Propagation in the Atmosphere, Springer Handbooks, pp. 113-147.
Attenborough, K., Bashir, I., Hill, T.J., Taherzadeh, S., Defrance, J., Jean, P., 2014. Noise reduction using
surface roughness. Environmental methods for transport noise reduction, 121-154
Attenborough, K., Bashir, I., Taherzadeh, S., 2016. Exploiting ground effects for surface transport noise
abatement. Noise Mapping 3, https://doi.org/10.1515/noise-2016-0001.
Bernardini, F., Mittleman, J., Rushmeier, H., Silva, C., Taubin, G., 1999. The ball-pivoting algorithm for
surface reconstruction. IEEE Trans Visual Comput Graphics 5, 349-359,
https://doi.org/10.1109/2945.817351.
Buxton, R.T., Pearson, A.L., Allou, C., Fristrup, K., Wittemyer, G., 2021. A synthesis of health benefits of
natural sounds and their distribution in national parks. Proceedings of the National Academy of Sciences of
the United States of America 118, https://doi.org/10.1073/PNAS.2013097118.
EC, 2021. Communication from the Commission to the European Parliament, the Council, the European
Economic and Social Committee and the Committee of the Regions: Pathway to a Healthy Planet for All, EU
Action Plan: 'Towards Zero Pollution for Air, Water and Soil’, report available from: https://eur-
lex.europa.eu/legal-content/EN/TXT/HTML/?uri=CELEX:52021DC0400&from=EN.
EEA, 2020. Environmental noise, report available from: https://www.eea.europa.eu/publications/soer-
2020/chapter-11_soer2020-environmental-noise. European Environment Agency.
European Environment Agency, 2020. Environmental noise in Europe-2020, report available from:
http://courthousenews.com/wp-content/uploads/2020/03/Environment-noise-in-europe-2020_TH-AL-20-
003-EN-N.pdf. European Environment Agency.
Fang, C.-F., Ling, D.-L., 2003. Investigation of the noise reduction provided by tree belts. Landscape and
Urban Planning 63, 187-195, https://doi.org/10.1016/s0169-2046(02)00190-1.
Fang, C.F., Ling, D.L., 2005. Guidance for noise reduction provided by tree belts. Landscape and Urban
Planning 71, 29-34, https://doi.org/10.1016/j.landurbplan.2004.01.005.
Gaudon, J.M., McTavish, M.J., Hamberg, J., Cray, H.A., Murphy, S.D., 2022. Noise attenuation varies by
interactions of land cover and season in an urban/peri-urban landscape. Urban Ecosystems 25, 811-818,
https://doi.org/10.1007/s11252-021-01194-4.
Gonzalez de Tanago, J., Lau, A., Bartholomeus, H., Herold, M., Avitabile, V., Raumonen, P., Martius, C.,
Goodman, R.C., Disney, M., Manuri, S., Burt, A., Calders, K., 2018. Estimation of above-ground biomass of
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
large tropical trees with terrestrial LiDAR. Methods Ecol. Evol. 9, 223-234, https://doi.org/10.1111/2041-
210X.12904.
Horoshenkov, K.V., Khan, A., Benkreira, H., 2013. Acoustic properties of low growing plants. Journal of the
Acoustical Society of America 133, 2554-2565, https://doi.org/10.1121/1.4798671.
Horoshenkov, K.V., Mohamed, M.H.A., 2006. Experimental investigation of the effects of water saturation
on the acoustic admittance of sandy soils. Journal of the Acoustical Society of America 120, 1910-1921,
https://doi.org/10.1121/1.2338288.
Hosoi, F., Omasa, K., 2006. Voxel-based 3-D modeling of individual trees for estimating leaf area density
using high-resolution portable scanning lidar. IEEE Transactions on Geoscience and Remote Sensing 44,
3610-3618, https://doi.org/10.1109/TGRS.2006.881743.
Huang, J., Kong, F., Yin, H., Middel, A., Liu, H., Zheng, X., Wen, Z., Wang, D., 2022. Transpirational cooling
and physiological responses of trees to heat. Agricultural and Forest Meteorology 320,
https://doi.org/10.1016/j.agrformet.2022.108940.
ISO9613-1, 1993. Acoustics: Attenuation of Sound During Propagation Outdoors. International Organization
for Standardization.
Karbalaei, S.S., Karimi, E., Naji, H.R., Ghasempoori, S.M., Hosseini, S.M., Abdollahi, M., 2015.
Investigation of the Traffic Noise Attenuation Provided by Roadside Green Belts. Fluctuation Noise Lett. 14,
https://doi.org/10.1142/S0219477515500364.
Kim, K.J., 2003. Financial time series forecasting using support vector machines. Neurocomputing 55, 307-
319, https://doi.org/10.1016/S0925-2312(03)00372-2.
Kong, F., Chen, J., Middel, A., Yin, H., Li, M., Sun, T., Zhang, N., Huang, J., Liu, H., Zhou, K., Ma, J., 2022.
Impact of 3-D urban landscape patterns on the outdoor thermal environment: A modelling study with
SOLWEIG. Computers, Environment and Urban Systems 94,
https://doi.org/10.1016/j.compenvurbsys.2022.101773.
Kong, F., Wang, D., Yin, H., Dronova, I., Fei, F., Chen, J., Pu, Y., Li, M., 2021. Coupling urban 3-D
information and circuit theory to advance the development of urban ecological networks. Conserv. Biol. 35,
1140-1150, https://doi.org/10.1111/cobi.13682.
Kong, F., Yan, W., Zheng, G., Yin, H., Cavan, G., Zhan, W., Zhang, N., Cheng, L., 2016. Retrieval of three-
dimensional tree canopy and shade using terrestrial laser scanning (TLS) data to analyze the cooling effect
of vegetation. Agricultural and Forest Meteorology 217, 22-34,
https://doi.org/10.1016/j.agrformet.2015.11.005.
Kong, F., Yin, H., Nakagoshi, N., 2007. Using GIS and landscape metrics in the hedonic price modeling of
the amenity value of urban green space: A case study in Jinan City, China. Landscape and Urban Planning
79, 240-252, https://doi.org/10.1016/j.landurbplan.2006.02.013.
Kragh, J., 1981. Road traffic noise attenuation by belts of trees. Journal of Sound and Vibration 74, 235-241,
https://doi.org/10.1016/0022-460X(81)90506-X.
Lee, S.W., Chang, S.I., Park, Y.M., 2008. Utilizing noise mapping for environmental impact assessment in a
downtown redevelopment area of Seoul, Korea. Applied Acoustics 69, 704-714,
https://doi.org/10.1016/j.apacoust.2007.02.009.
Lehnardt, Y., Barber, J.R., Berger-Tal, O., 2024. Effects of wind turbine noise on songbird behavior during
nonbreeding season. Conserv. Biol. 38, https://doi.org/10.1111/cobi.14188.
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
Li, M., Kang, J., 2020. Influence of Leaf Physical Properties on Single-Leaf Vibrational Response to Sound.
Forests 11, https://doi.org/10.3390/f11010115.
Liu, Y., Goudreau, S., Oiamo, T., Rainham, D., Hatzopoulou, M., Chen, H., Davies, H., Tremblay, M.,
Johnson, J., Bockstael, A., Leroux, T., Smargiassi, A., 2020. Comparison of land use regression and random
forests models on estimating noise levels in five Canadian cities. Environmental Pollution 256,
https://doi.org/10.1016/j.envpol.2019.113367.
Manuella Lech Cantuaria, E.R.P., Aslak Harbo Poulsen, Ole Raaschou-Nielsen, Ulla Arthur Hvidtfeldt,
Gregor Levin, Steen Solvang Jensen, Jesper Hvass Schmidt, and Mette Sørensen, 2023. Transportation Noise
and Risk of Tinnitus: A Nationwide Cohort Study from Denmark. Environmental Health Perspectives 131(2),
https://doi.org/10.1289/EHP11248.
Ministry of Ecology and Environment of the People's Republic of China, 2008. Environmental quality
standard of noise, report available from:
https://www.mee.gov.cn/ywgz/fgbz/bz/bzwb/wlhj/shjzlbz/200809/W020111121351590491445.pdf.
Mitrus, C., Zbyryt, A., 2018. Reducing avian mortality from noise barrier collisions along an urban roadway.
Urban Ecosystems 21, 351-356, https://doi.org/10.1007/s11252-017-0717-7.
Nelson-Olivieri, J.R., Layden, T.J., Antunez, E., Khalighifar, A., Lasky, M., Laverty, T.M., Sanchez, K.A.,
Shannon, G., Starr, S., Verahrami, A.K., Bombaci, S.P., 2024. Inequalities in noise will affect urban wildlife.
Nature Ecology and Evolution 8, 163-174, https://doi.org/10.1038/s41559-023-02257-9.
Newnham, G.J., Armston, J.D., Calders, K., Disney, M.I., Lovell, J.L., Schaaf, C.B., Strahler, A.H., Danson,
F.M., 2015. Terrestrial laser scanning for plot-scale forest measurement. Current Forestry Reports 1, 239-251,
https://doi.org/10.1007/s40725-015-0025-5.
Noble, W.S., 2006. What is a support vector machine? Nat. Biotechnol. 24, 1565-1567,
https://doi.org/10.1038/nbt1206-1565.
Nunes, M.H., Camargo, J.L.C., Vincent, G., Calders, K., Oliveira, R.S., Huete, A., Mendes de Moura, Y.,
Nelson, B., Smith, M.N., Stark, S.C., Maeda, E.E., 2022. Forest fragmentation impacts the seasonality of
Amazonian evergreen canopies. Nat. Commun. 13, https://doi.org/10.1038/s41467-022-28490-7.
Ow, L.F., Ghosh, S., 2017. Urban cities and road traffic noise: Reduction through vegetation. Applied
Acoustics 120, 15-20, https://doi.org/10.1016/j.apacoust.2017.01.007.
Pal, A.K., Kumar, V., Saxena, N.C., 2000. Noise attenuation by green belts. Journal of Sound and Vibration
234, 149-165, https://doi.org/10.1006/jsvi.2000.2863.
Romanova, A., Horoshenkov, K.V., Hurrell, A., 2019. An application of a parametric transducer to measure
acoustic absorption of a living green wall. Applied Acoustics 145, 89-97,
https://doi.org/10.1016/j.apacoust.2018.09.020.
Saatchi, S.S., Harris, N.L., Brown, S., Lefsky, M., Mitchard, E.T.A., Salas, W., Zutta, B.R., Buermann, W.,
Lewis, S.L., Hagen, S., Petrova, S., White, L., Silman, M., Morel, A., 2011. Benchmark map of forest carbon
stocks in tropical regions across three continents. Proceedings of the National Academy of Sciences of the
United States of America 108, 9899-9904, https://doi.org/10.1073/pnas.1019576108.
Smola, A.J., Schölkopf, B., 2004. A tutorial on support vector regression. Stat. Comput. 14, 199-222,
https://doi.org/10.1023/B:STCO.0000035301.49549.88.
Tehrany, M.S., Pradhan, B., Mansor, S., Ahmad, N., 2015. Flood susceptibility assessment using GIS-based
support vector machine model with different kernel types. Catena 125, 91-101,
Journal of Environmental Management
Volume 370, November 2024, 122818

Jian Lu, Fanhua Kong, Haiwei Yin, Ariane Middel, Jian Kang, Zhihao Wen & Hongqing Liu
https://doi.org/10.1016/j.jenvman.2024.122818
https://doi.org/10.1016/j.catena.2014.10.017.
Tyagi, V., Kumar, K., Jain, V.K., 2006. A study of the spectral characteristics of traffic noise attenuation by
vegetation belts in Delhi. Applied Acoustics 67, 926-935, https://doi.org/10.1016/j.apacoust.2005.09.002.
Van Renterghem, T., Botteldooren, D., Verheyen, K., 2012. Road traffic noise shielding by vegetation belts
of limited depth. Journal of Sound and Vibration 331, 2404-2425, https://doi.org/10.1016/j.jsv.2012.01.006.
Van Renterghem, T., Forssén, J., Attenborough, K., Jean, P., Defrance, J., Hornikx, M., Kang, J., 2015. Using
natural means to reduce surface transport noise during propagation outdoors. Applied Acoustics 92, 86-101,
https://doi.org/10.1016/j.apacoust.2015.01.004.
Van Renterghem, T., Huyghe, F., Verheyen, K., 2021. Effect of tree species and season on the ability of forest
floors to abate environmental noise. Applied Acoustics 184, https://doi.org/10.1016/j.apacoust.2021.108349.
Wang, D., Momo Takoudjou, S., Casella, E., 2020. LeWoS: A universal leaf-wood classification method to
facilitate the 3D modelling of large tropical trees using terrestrial LiDAR. Methods Ecol. Evol. 11, 376-389,
https://doi.org/10.1111/2041-210X.13342.
Weiss, M., Baret, F., Smith, G.J., Jonckheere, I., Coppin, P., 2004. Review of methods for in situ leaf area
index (LAI) determination: Part II. Estimation of LAI, errors and sampling. Agricultural and Forest
Meteorology 121, 37-53, https://doi.org/https://doi.org/10.1016/j.agrformet.2003.08.001.
WHO, 2018. Environmental noise guidelines for the European Region, report available from:
https://www.who.int/europe/publications/i/item/9789289053563.
Xu, C., Han, B., Lu, F., Wu, T., 2022. Assessing the Traffic Noise Reduction Effect of Roadside Green Space
Using LiDAR Point Cloud Data in Shenzhen, China. Forests 13, https://doi.org/10.3390/f13050765.
Xu, J., Wang, J.J., Xue, H.W., Zhang, G.H., 2021. Leaf direction: Lamina joint development and
environmental responses. Plant Cell and Environment 44, 2441-2454, https://doi.org/10.1111/pce.14065.
Yang, H.S., 2013. Outdoor noise control by natural/sustainable materials in urban areas. University of
Sheffield.
Yang, H.S., Kang, J., Cheal, C., 2013a. Random-incidence absorption and scattering coefficients of
vegetation. Acta Acustica united with Acustica 99, 379-388, https://doi.org/10.3813/AAA.918619.
Yang, H.S., Kang, J., Cheal, C., Renterghem, T.V., Botteldooren, D., 2013b. Quantifying scattered sound
energy from a single tree by means of reverberation time. Journal of the Acoustical Society of America 134,
264-274, https://doi.org/10.1121/1.4808175.
Zhang, J., Guo, X., Zhao, C., 2015. Nonlinear prediction model of noise reduction by greenbelts. Urban
Forestry and Urban Greening 14, 282-285, https://doi.org/10.1016/j.ufug.2015.01.007.
Zhao, N., Prieur, J.F., Liu, Y., Kneeshaw, D., Lapointe, E.M., Paquette, A., Zinszer, K., Dupras, J., Villeneuve,
P.J., Rainham, D.G., Lavigne, E., Chen, H., van den Bosch, M., Oiamo, T., Smargiassi, A., 2021. Tree
characteristics and environmental noise in complex urban settings – A case study from Montreal, Canada.
Environmental Research 202, https://doi.org/10.1016/j.envres.2021.111887.
Zhou, Q.-Y., Park, J., Koltun, V., 2018. Open3D: A modern library for 3D data processing. arXiv preprint
arXiv:1801.09847,
Zhu, Y., Chen, Y., 2023. A study of noise exposure of traffic-type pocket parks in old urban districts based on
audio-visual interaction. Applied Acoustics 213, https://doi.org/10.1016/j.apacoust.2023.109628.
Journal of Environmental Management
Volume 370, November 2024, 122818
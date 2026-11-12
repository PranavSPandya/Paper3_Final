Article 1
What you see is what you breathe? Estimating air pollution
2
spatial variation using street level imagery
3
Esra Suel 1, 2, *, Meytar Sorek-Hamer3,4, Izabela Moise, Michael von Pohle3,4, Adwait Sahasrabhojanee3,4, Ata Akbari 4
Asanjan3,4, Raphael E. Arku5, Abosede S Alli5, Benjamin Barratt 1, Sierra N Clark1, Ariane Middel6, Emily 5
Deardorff3,4,7, Violet Lingenfelter3,4,8; Nikunj Oza4; Nishant Yadav3,4; Majid Ezzati1,9; and Michael Brauer10,11 6
1 Imperial College London; 7
2 ETH Zurich 8
3 Universities Space Research Association (USRA) 9
4 NASA Ames Research Center 10
5 University of Massachusetts Amherst 11
6 Arizona State University 12
7 San Diego State University 13
8 UC Berkeley 14
9 University of Ghana 15
10 University of British Columbia 16
11 University of Washington 17
* Correspondence: sesra@ethz.ch 18
Abstract: High spatial resolution information on urban air pollution levels is unavailable in many 19
areas globally, partially due to high input data needs of existing estimation approaches. Here we 20
introduce a computer vision method to estimate annual means for air pollution levels from street 21
level images. We used annual mean estimates of NO2 and PM2.5 concentrations from locally 22
calibrated models as labels from London, New York, and Vancouver to allow for compilation of a 23
sufficiently large dataset (~250k images for each city). Our experimental setup is designed to 24
quantify intra and intercity transferability of image-based model estimates. Performances were high 25
and comparable to traditional land-use regression (LUR) and dispersion models when training and 26
testing on images from the same city (R2 values between 0.51 and 0.95 when validated on data from 27
ground monitoring stations). Like LUR models, transferability of models between cities in different 28
Citation: Lastname, F.; Lastname, F.;
geographies is more difficult. Specifically, transferability between the three cities i.e., London, New 29
Lastname, F. Title. Remote Sens. 2022,
York, and Vancouver, which have similar pollution source profiles were moderately successful (R2 30
14, x. https://doi.org/10.3390/xxxxx
values between zero and 0.67). Comparatively, performances when transferring models trained 31
Academic Editor: on these cities with very different source profiles i.e., Accra in Ghana and Hong Kong were lower 32
(R2 between zero and 0.21) suggesting the need for local calibration with local calibration using 33
Received: date
additional measurement data from cities that share similar source profiles. 34
Accepted: date
Published: date
Keywords: Computer vision, deep learning, street images, air pollution, data science, 35
Publisher’s Note: MDPI stays
transferability, urban pollution 36
neutral with regard to jurisdictional
37
claims in published maps and
institutional affiliations.
1. Introduction 38
Air pollution has significant and widely accepted implications on health outcomes 39
Copyright: © 2022 by the authors.
[1]–[4]. Advances in spatial estimation of air pollution concentrations have been 40
Submitted for possible open access
publication under the terms and instrumental both in establishing health effects and impact on the burden of disease [5], 41
conditions of the Creative Commons [6]. Yet, we currently lack information on air pollution levels in many areas globally [7] 42
Attribution (CC BY) license especially at sufficiently high spatial resolution to inform local planning and air quality 43
(https://creativecommons.org/license management strategies. Limited spatial and temporal resolution of air quality models 44
s/by/4.0/). partially results from input data requirements of existing estimation approaches 45
Remote Sens. 2022, 14, x. https://doi.org/10.3390/xxxxx www.mdpi.com/journal/remotesensing

Remote Sens. 2022, 14, x FOR PEER REVIEW 2 of 17
including physically based e.g., dispersion models, and geostatistical e.g., land use 46
regression (LUR) models [8]. High quality air pollution measurements from ground 47
measurement campaigns are required for development and calibration of city-wide air 48
pollution models, yet they are very costly to implement and therefore not available for 49
most cities around the world. Advances in deep learning methods and their success in 50
computer vision applications has led to a growing interest in using images for estimating 51
air pollution levels [8]–[16]. The rationale behind this interest is that information on 52
pollution sources and common predictor variables used in traditional approaches (e.g., 53
land use, traffic, built and natural environment features [17]) is, at least partially, visible 54
from street level and satellite images. If utilized effectively, this approach has the potential 55
for reducing input data requirements and scaling up to global coverage at low cost. 56
Increasing availability of images in cities makes feasible the extraction of visual 57
information at high spatial resolution. In contrast, spatially detailed air pollutant 58
concentration levels are typically not readily available. This is a substantial challenge for 59
application of deep learning methods as they require very large numbers of labeled data 60
(i.e., images and their corresponding air pollution levels) for training. One proposed 61
solution [9], [13], [16], [18] is to collect images when conducting air pollution monitoring 62
campaigns. However, such data are rarely available and costly to collect at the scale 63
necessary for generalizing to unseen locations. A second approach is to extract 64
intermediate user defined features from images that are known to be important predictors 65
of air pollution (e.g., trees, buildings, cars, buses, roads) and to use them as explanatory 66
variables to estimate pollutant levels with traditional regression methods [16]. This 67
process, however, requires separate training on databases that may not contain crucial 68
categories of interest or be publicly available. Further, deep learning methods that 69
automatically learn relevant features commonly outperform methods based on hand- 70
crafted features in visual recognition tasks [19]. In this study, we propose a third 71
approach, to estimate pollution levels from raw images without extracting intermediate 72
user defined features. As the numbers of monitoring locations (in hundreds) from ground 73
measurement campaigns are insufficient for training deep learning models, we propose 74
to use annual mean estimates of air pollutant concentrations from locally calibrated 75
models as labels for training. These local models provide continuous surfaces of pollution 76
estimates at high spatial resolution. Use of LUR or dispersion-based estimates matched 77
with street level images allows for compilation of a large dataset of image-label pairs 78
required for training deep learning models. Different types of images (e.g., street-level, 79
aerial, and satellite images) will contain visual information captured from different 80
viewpoints. Local, especially near-road, information (e.g., cars, building heights, built and 81
natural environmental features) is more visible from street-images, while high resolution 82
satellite and aerial images will contain more information on the spatial context (e.g., 83
proximity to parks, forests, ocean that are not necessarily visible from street-level) [20]. 84
Here, we use street-level images only to test whether locally rich information can be used 85
to estimate spatial variation at high-resolution. Variation in NO2 is higher and influenced 86
more by local sources likely visible from street images. PM2.5, on the other hand, is 87
influenced by regional levels and secondary production which is less likely visible from 88
street-images. LUR models, for NO2 especially, indicate that the variables describing the 89
near-road environment explain much of the spatial variability within urban areas and we 90
hypothesize that street-level imagery would be useful in NO2 modelling but less relevant 91
for estimation of variability in PM2.5. However, even for PM2.5 while overall variability is 92
harder to explain, some is explained by near-road predictors, and we hypothesize that 93
imagery may provide a richer dataset for estimation than geospatial predictors that had 94
been identified a prior. 95
Here, we describe the application of a deep learning approach to estimate air 96
pollution spatial variation using street level images for PM2.5 and NO2. Our deep learning 97
models work by automatically learning visual features associated with different levels of 98
pollution to describe variation over space. These features may correspond to sources of 99

Remote Sens. 2022, 14, x FOR PEER REVIEW 3 of 17
pollution or pollution haze when visible from street images. First, we test how transferable 100
i.e., similar these visual features are within (intracity) and across (intercity) cities where 101
we have good data from city-wide models and ground monitoring stations. For training 102
the models, we used annual mean NO2 and PM2.5 estimates from three cities in three 103
different countries selected for their varying levels of pollution and the availability of high 104
resolution concentration estimates: London (UK), New York (USA), and Vancouver 105
(Canada) [21]–[26]. A disadvantage of this approach, however, is that the performance of 106
the image-based models will be influenced by the performance of the source models 107
whose outputs are treated as the truth during training phase. Here, we used previously 108
published models from all three cities; we include their performances against measured 109
concentrations. Second, we make estimates for two additional large cities: Accra (Ghana) 110
and Hong Kong (PRC), as examples of locations where spatially resolved ground 111
measurements are available. In Accra and Hong Kong, our estimates were based merely 112
on street level images with no additional information on the spatial context (e.g., regional 113
pollution levels or proximity to parks, ocean etc.). Our selection of cities from different 114
geographies, countries, and source profiles is deliberate to make the task of transferability 115
particularly difficult to better understand transferability capabilities of image based 116
models in three different settings that vary in their level of expected difficulty for 117
transferability performance: within the same-city and country, across cities with similar 118
source profiles but different countries and geographies, and across cities with different 119
source profiles and different geographies. 120
2. Materials and Methods 121
2.1 Land use regression and dispersion model outputs 122
We obtained annual mean NO2 (200m resolution raster) and PM2.5 (100m resolution 123
raster) estimates for 2010 from three cities: London, New York, and Vancouver using 124
existing most recent local models developed for these cities [21]–[28]. Land use regression 125
(LUR) models were available for New York and Vancouver and an atmospheric 126
dispersion model for London. Land use regression and dispersion models are the two 127
main model types used for estimating spatial variability, and we selected three cities 128
where we had access to images and high-resolution annual estimates of both pollutants. 129
A dispersion model is available that is maintained to which we had access whereas there 130
is no recent LUR for London for both pollutants. For other cities, LUR models were used 131
and were available to us. The New York LUR models (r=0.69 for PM2.5 and r=0.79 for NO2 132
computed using ground measurements) included traffic density, proximity to bus routes, 133
percentage of impervious surface, interior building space, proximity to industrial sites, 134
proximity to heat and hot water boilers as geospatial predictor variables. For Vancouver 135
(r=0.33 for PM2.5 and r=0.86 for NO2) the model included vehicle density, proximity to 136
commercial areas, elevation, and population density as predictor variables. The model in 137
London (r=0.65 for PM2.5 and r=0.49 for NO2) used distance to roads by type, street canyon 138
type, and meteorological inputs as key input variables. Distributions of annual estimates 139
for both pollutants were distinct and almost non-overlapping for each of the study cities 140
(Figure 1). The differences in absolute levels of pollution across cities is by design for our 141
experiments and makes intercity transferability challenging, as discussed in Section 3. 142
NO2 estimates demonstrated a clear spatial trend following roads as the main source, 143
PM2.5 are more heterogeneously spread reflecting the diversity of sources, the impact of 144
regional factors and secondary production (Figures 2). Vancouver is characterized by low 145
levels of NO2 and PM2.5 concentrations. Areas near downtown and the Vancouver 146
International Airport show relatively higher levels of air pollution, whereas large park 147
and mountainous areas have low pollution levels (Figure 2). This resulted in a bimodal 148
distribution for both PM2.5 and NO2 in Vancouver with a distinct local peak at the lower 149
end in Figure 1. A similar bimodal distribution is observed for New York especially for 150
NO2, whereas London estimates showed unimodal distributions for both pollutants. Both 151

Remote Sens. 2022, 14, x FOR PEER REVIEW 4 of 17
New York and London are right skewed. In New York, densely populated Manhattan as 152
well as Queens and Brooklyn Heights stand out with their high levels of pollution. In 153
London, similarly, the densely populated city center as well as areas near the major roads 154
have high levels of pollution. London contained the highest estimates for both pollutants. 155
156
157
Figure 1. Distributions of annual mean NO2 and PM2.5 estimates from local land use regression and 158
dispersion models. Figures show a clear distinction of air pollutant levels between the three study 159
cities. These values are used as labels when training deep learning models using street level images. 160
2.2 Street level images 161
To obtain images, a 100m grid for London, New York, and Vancouver was created 162
using the boundary shape files covering the model output domains. 100m grids for Accra 163
and Hong Kong were created using the city boundary shape files. For each of the grid 164
centroid points, we used the nearest street level panorama image location available from 165
Google Street View that was captured from years 2008 to 2012 (+/- 2 years from the model 166
year) for London, New York, and Vancouver. For each image location, four images of size 167
224x224 pixels were accessed specifying the camera direction (i.e., 0°, 90°, 180°, 270°) 168
relative to the Street View vehicle to cover a 360° view. These images were then 169
concatenated resulting in a single image of size 224x896 pixels used as input to the 170
network as explained in Section 2.4. Nearly 820,000 street level images, (378,856 images 171
for London, 198,300 for New York, and 242,248 for Vancouver) were matched with NO2 172
and PM2.5 model estimates (see Section 2.1) as outcome labels. For Accra and Hong Kong, 173
we obtained the most recent panorama image for each of the grid centroid points 174
corresponding to years 2018 to 2019 resulting in, respectively, 250,460 and 265,308 images 175
in total. 176
177
2.3 Ground monitoring stations 178
Site measurement data were obtained from ground-based air monitoring stations 179
from each of the three study cities for evaluating the image-based air pollution estimates. 180
More information about stations and data collection protocols used are available from 181
[23], [29]–[32]. Stations were included for evaluations where a street image (and 182
consequently an image-based estimate) was available within 50 meters. For London, daily 183
station data from [31] was used to calculate annual means of measured pollution over 184
ground stations that had at least one measured value every month for 2010. For Vancouver 185
and New York, annual means of measured data from [23], [29], [30], [32] were used for 186
stations that had collected data for more than half of the year during 2010. We used a total 187
of 59 ground NO2 sites with eight, four, and 47 sites in London, New York, and Vancouver 188

Remote Sens. 2022, 14, x FOR PEER REVIEW 5 of 17
respectively. For PM2.5, a total of 15 stations were used with nine, two, and four sites, 189
respectively. London had the highest average pollutant values for NO2 and PM2.5 (63.4 190
and 16.3 µg/m3, respectively), followed by New York (54.1 and 11.3 µg/m3) and 191
Vancouver with the lowest (11.0 and 4.0 µg/m3) levels. Unfortunately, the numbers of 192
available ground monitoring stations were very low. More data from ground monitoring 193
stations are needed for evaluations to generalize from our analysis from comparisons 194
between image based predictions and ground truth measurements. We report our 195
findings in the following section. 196
The metrics used for evaluations in Table 1 need to be interpreted carefully for cities 197
with small numbers of ground station data. Ground monitoring station data offered an 198
evaluation based upon a measured (ground truth) dataset in addition to the evaluations 199
done on modelled data. Since the models developed for New York, Vancouver, and 200
London were not calibrated using ground monitoring station data, these measurements 201
can be used as an independent test set for these cities. We used ground measurement data 202
from Accra and Hong Kong collected through previous spatial monitoring field 203
campaigns. For Hong Kong, we used data from 97 NO2 sites and 52 PM2.5 sites collected 204
in 2014 as detailed elsewhere [33]. For Accra, data was available from 35 NO2 sites and 32 205
PM2.5 sites collected from 2019 to 2020 [18], [34], [35]. 206
207
2.4 Modelling approach 208
We used a ResNet [36] architecture where outputs are continuous pollutant levels (a 209
regression task as opposed to classification) to train separate deep learning models for 210
estimating NO2 and PM2.5 concentrations. We selected ResNet as it has a global average 211
pooling at the end, which allowed us to generate post-hoc model visualizations 212
highlighting most relevant areas in the image for estimates using class activation maps 213
(CAMs) [37]. Specifically, we used the ResNet18 architecture with pre-trained weights on 214
ImageNet available in PyTorch [38]. We added a fully connected layer at the end with a 215
single output value suited for the regression task, replacing the soft-max layer after Layer 216
4. We fixed pre-trained weights up to Layer 4, and fine-tuned and trained weights for 217
Layer 4 as well as the fully connected layer at the end (Figure S1). 218
We first evaluate intracity performances of image-based deep learning models for 219
estimating air pollution. For labels, annual mean pollutant levels from the city-wide 220
models were used for London, New York, and Vancouver. Networks were trained and 221
tested on image-label pairs from the same city using four-fold cross validation. The results 222
show how well models perform in capturing visual features associated with pollution 223
levels at the local level. 224
Second, we explored how trained models transfer across cities. Transferability of 225
LUR models across space was previously evaluated and found to perform poorly without 226
local calibration [39]–[41]. In this study, the networks trained on combined data from two 227
cities were tested on the held-out city. This process was repeated three times holding out 228
a different city each time. The results show how well identified features associated with 229
different pollution levels transfer across cities. 230
Third, we focused on the transferability of deep learning models to Accra and Hong 231
Kong. The most appealing promise of using street imagery for air pollution estimation is 232
its potential for scaling globally at low cost, especially to the very large number of cities 233
which lack local air pollution measurements or models (e.g., cities from different 234
countries, development trajectories, pollution sources, and climates) [7]. To test the 235
viability of such an application, we selected Accra and Hong Kong as test cities where we 236
had access to spatially distributed air pollution measurements collected through field 237
campaigns. Note also that these settings differ geographically and with respect to 238
development level, climate and pollution sources from all of the training cities. 239
The root-mean-squared-error (RMSE), normalized RMSE (NRMSE), mean error 240
(ME), and Pearson correlation coefficient (r), and coefficient of determination (R2) were 241

Remote Sens. 2022, 14, x FOR PEER REVIEW 6 of 17
computed using hold-out sets for each of the cities and experiments. R2 value for predicted 242
vs. observed concentration were used to allow for quantitative comparisons with earlier 243
work that focused on intercity transferability of LUR models, with results ranging 244
between R2 = 0.33 and 0.51 [41]. We generated estimation maps for each city to assess how 245
well spatial variations were captured. Finally, we evaluated performance using ground 246
monitoring stations data. 247
248
3. Results and Discussion 249
3.1 Intracity performance for London, Vancouver, and New York 250
Labelled images, separately for NO2 and PM2.5, were prepared for each of the three 251
cities. Each of these images were matched with labels available from city-wide pollution 252
rasters using the coordinate information for each image. We trained separate models for 253
each city using four-fold cross validation. In each fold, 75% of data (i.e., randomly selected 254
image-outcome pairs for 75% of grid points) were used for training the network and the 255
remaining 25% were withheld. We then measured how well the trained network uses 256
images to estimate outcomes at locations that were not used in training from the same 257
city. We repeated this process four times holding out a different 25% of data each time. 258
Full results are available in Table 1. For NO2, intracity models achieved r values of 259
0.79, 0.87, and 0.73 (R2= 0.58, 0.75, and 0.52) respectively for London, New York, and 260
Vancouver. Lower performances were observed for PM2.5 where r values were 0.79, 0.85, 261
and 0.60 (R2= 0.59, 0.71, 0.33). This was expected and consistent with previous work, as 262
local variation for NO2 is higher and influenced more by local (mobile) sources compared 263
with PM2.5 that is influenced by regional levels and secondary production which is 264
unlikely to be closely related to micro-scale spatial patterns of sources. Average RMSE 265
values across cities were 4.3 µg/m3 for NO2 and 1.0 µg/m3 for PM2.5. Best performances 266
were achieved for New York and poorest performance was observed for Vancouver 267
particularly for areas of low pollution. 268
Figure 2 shows that the spatial patterns of pollution are better captured for NO2 269
compared to PM2.5 by image based deep learning models. Similar patterns over space are 270
observed for both label and prediction maps even though predictions are only based on 271
street level images, i.e., no spatial information or smoothing method was used for 272
generating prediction maps. Image-based deep learning models identify major roads and 273
distinguish them from smaller streets and associate them to higher levels of pollution 274
concentration. City centers characterized by higher building and population density are 275
also identified and predicted as high-pollution areas. These results are consistent with 276
inputs to LUR and dispersion models used as labels described in Section 1.1. Prediction 277
errors for all cities were particularly high for low pollution areas. Spatial patterns in errors 278
reflect the impact of features such as geography (e.g., proximity to the coast and 279
mountains in Vancouver). This may, in part, reflect that street level images are 280
predominantly collected from streets by driving cars and availability is limited for low 281
pollution areas such as parks, forests and coastal areas. The models use images only for 282
predictions with no additional information on the spatial context (e.g., proximity to parks, 283
mountains, ocean etc.). Data from other sources (e.g., satellite images, built environment 284
datasets) can be used to provide information about the spatial context within a multi- 285
model learning framework can help improve performances in the future [20]. 286
We used class activation maps (CAMs) for additional insights to image regions that 287
are used by the model for making pollution predictions, [42], [43]. CAMs offer a post-hoc 288
visualization method using the average pooling layer at the end of ResNet18. Figure 3 289
shows some examples from locations where both the label and predicted pollution values 290
were very high from each city. The areas of the image that substantially contribute 291
positively to the final prediction value are highlighted in red. We observe that roads, cars, 292
and high building density is being highlighted in these images. Interpretation of CAM 293

Remote Sens. 2022, 14, x FOR PEER REVIEW 7 of 17
visualizations become harder and less appealing for areas having mid- or low-range 294
pollution levels (see more examples in SI). This could be related to the general difficulty 295
of interpretability of deep learning models and associated inadequacies in the proposed 296
CAM methods but could also potentially be explained by the fact that no specific image 297
region is identified as a major source of pollution, which also correctly results in lower 298
pollution estimates. 299
300
Figure 2. Comparison of labels and prediction maps of mean NO2 and PM2.5 levels for London, New 301
York, and Vancouver. The label column displays the base map and the extent of the shapefiles used. 302
We adjusted the color bar scale to visualize the spatial patterns for each city and pollutant where 303
red areas correspond to high pollution and green to low pollution. Intracity model predictions show 304
results from experiments where networks were trained and tested on images from the same city 305
using four-fold cross validation. Intercity model predictions where the models were trained on two 306
cities and tested on the third hold out city. Relative errors (absolute error divided by the magnitude 307
of the label value) are also displayed where darker red colors indicate higher error rates. 308

Remote Sens. 2022, 14, x FOR PEER REVIEW 8 of 17
309
Figure 3. Examples of class activation maps from (A) London, (B) New York, and (C) Vancouver. 310
These examples were selected from locations where both the label and prediction NO2 values were 311
high as follows: 53.3 µg/m3 and 76 µg/m3 for (A), 20.8 µg/m3 and 16.7 µg/m3 for (B), 63.5 µg/m3 312
and 61.3 µg/m3 for (C). Red areas indicate parts of the image that the network considers as positively 313
influencing pollution levels. The visualizations show the network identifies cars, roads, and high 314
density building as major sources of pollution. More examples are available in SI that are less 315
appealing and harder to interpret especially from areas of low- and mid- range pollution levels. 316
We analyzed the association between the model estimates results and ground 317
monitoring site measurements separately for each study city. Sites that had co-located 318
model estimates within a distance of less than 50 m were included. It was not possible to 319
compute r for PM2.5 in Vancouver as we only had two qualifying measurement sites. 320
Correlations between estimated values and annual mean concentrations were high: NO2 321
models achieved r values of 0.90, 0.76, and 0.97 (R2 = 0.81, 0.58, 0.95, N = 8, 47, 4) 322
respectively for London, New York, and Vancouver; PM2.5 models achieved r values of 323
0.72 for London and 0.86 for New York (R2 = 0.51, 0.74, N = 9, 4). The number of available 324
monitoring stations for evaluations were limited, so results should be interpreted with 325
caution. These values are comparable to performances of the underlying models whose 326
outputs were used for training, suggesting that images can capture a substantial part of 327
pollution sources often used as inputs for model for training. In our current setting, we 328
are unable to generate daily or hourly estimates of pollution as we were restricted by 329
image availability. 330
3.2. Intracity performance for London, Vancouver, and New York 331
For evaluating transferability of learning, we trained three separate models using 332
three-fold cross validation. In each fold, combined data from two cities were used for 333
training the network and the third city was withheld. We then measured how well the 334
trained network uses images to predict outcomes in the holdout city not used for training. 335
Resulting performance metrics can be compared with intracity results presented in the 336
previous section. In regression tasks, it is well known that deep-learning models do not 337
generalize well to previously unseen values. This was, by design, a specifically 338
challenging setting as label data distributions used for the selected three cities were almost 339

Remote Sens. 2022, 14, x FOR PEER REVIEW 9 of 17
non-overlapping for NO2 and PM2.5 (Figure 1). For example, when training on combined 340
NO2 data from Vancouver and New York, labels used in training were mostly ranged 341
between 0 to 40 µg/m3. Accordingly, predictions were also in this range when making 342
predictions in London. Yet, target data NO2 concentrations were much higher in London 343
mostly ranging between 20 to 60 µg/m3 resulting in large RMSEs. As a result, estimation 344
of absolute levels was poor. We also wanted to understand if there is a way to shift 345
estimation distributions to match the target distributions to achieve lower levels of 346
absolute error and whether our models were successful in capturing spatial variation and 347
relative pollutant levels. For this purpose, we transform and adjust estimation 348
distributions using the mean and standard deviation of the labels (𝑥̅ and 𝜎 𝑥 ) from the 349
target city using the following equation: 𝑦′=𝑥̅ +(𝑦−𝑦̅)∗(𝜎 𝑥 /𝜎 𝑦 ) where 𝑦′ and 𝑦 are, 350
respectively, the adjusted and pre-adjusted estimation values. This post-hoc adjustment 351
step influences RMSE and NRMSE values, but not r and R2values. In practice, some prior 352
information on means and variation of air pollution levels from the target city will be 353
required for this post-hoc adjustment step. We reported performances from the adjusted 354
model estimates in Table 1 and Figure 2 (results from non-adjusted model estimates are 355
provided in the SI). 356
When the network trained on two source cities was used to make predictions in the 357
hold out target city, the performances were much lower. Pearson correlation between true 358
(label) and predicted values were 0.42, 0.60, and 0.28 (R2 = 0.18, 0.36, 0.08) for London, 359
New York, and Vancouver for NO2`, and 0.37, 0.47, and 0.06 for PM2.5 (R2 = 0.14, 0.22, 0). 360
These correlations were lower, and the errors were larger, than those for intracity results 361
(Section 2.1). Correlations between estimated values and annual mean concentrations 362
from ground monitoring stations were also lower with r values ranging between 0.51 (R2 363
= 0.00, N=4) for Vancouver and New York (R2 = 0.26, N=47) to 0.82 (R2 = 0.67, N=8) in 364
London for NO2, and 0.29 (R2 = 0.09, N=4) in New York and 0.46 (R2 = 0.22, N=9) in London 365
for PM2.5. This is consistent with previous work where transferability of LUR models were 366
evaluated [39]–[41] and found low performances for NO2. Specifically, previous work 367
reported transferability performances of a LUR modeled trained on Vancouver was R2 = 368
0.51 (N=40) for Victoria (another city in Canada) and R2 = 0.33 (N=26) for Seattle (a city in 369
another country). We observe similar performances from intercity NO2 models R2= 0.67 370
(N=8) for London, R2=0.26 for New York (N=47) and R2 = 0.00 (N=4) for Vancouver. We 371
use less data input, yet our evaluation set is limited since we had limited numbers of 372
available monitoring stations in London and Vancouver. Figure 2 shows that spatial 373
variation for NO2 can be captured to a limited degree. It is, however, much harder to 374
transfer across cities to estimate spatial variability of PM2.5. This likely results from 375
differences in important PM2.5 sources between cities, in regional (e.g., topographic, 376
geographic) influences on PM2.5 spatial patterns and on meteorological impacts on 377
dispersion and secondary PM2.5 production. For example, Vancouver is both mountainous 378
and with sea breeze influences that will not be identified by street level images, while 379
New York City is downwind of industrial emissions sources and power generation 380
facilities that were located outside of the imagery domain. Even though it is possible to 381
transfer image-based deep learning models between cities, success will depend not only 382
on visual similarity of features associated with pollution levels but also differences in 383
absolute levels and distributions of pollution between source and target cities. Some of 384
this information would be available from global models [44]. Further research is needed 385
to investigate the most efficient approaches to local calibration to help produce models 386
that are as predictive as their performances in training cities [41], [45]. 387
Finally, we wanted to understand if image-based estimates also perform better in 388
locations where local LUR and dispersion models had lower error. For a comparative 389
analysis of image-based prediction errors and locally calibrated models (originally used 390
as labels in training), we computed relative errors for each ground monitoring station 391
location. The numbers of monitoring stations available for evaluations were, 392
unfortunately, too low to generalize our findings. Still, as expected, for NO2, intracity 393

Remote Sens. 2022, 14, x FOR PEER REVIEW 10 of 17
image-based errors were highly correlated with local LUR/dispersion model errors with 394
correlations of r=0.62 (N=8), 0.72 (N=47), 0.99 (N=4) for London, New York, and 395
Vancouver. When transferring between cities for NO2, we got a much lower correlations 396
for New York at 0.08 where we had the largest number of data points N=47. For other 397
cities the correlations remained relatively high at r=0.60 for London and r = 0.98 for 398
Vancouver. For PM2.5, within city correlations between relative errors from intracity 399
image-based estimates were r=0.51 for London (N=9) and r=0.21 for New York (N=4); we 400
could not include Vancouver with N=2. Intercity image-based transfer was even more 401
difficult for PM2.5, in line with other findings, where the correlations were very low or in 402
the wrong direction with r=0.35 and r=-0.77. These findings are in line with our main 403
results where we showed that image-based models can learn local features when trained 404
on image-label pairs from the same city. It is, however, much harder to transfer across 405
cities. 406
407
3.3 Evaluation of transferability to Accra and Hong Kong 408
We evaluated how well a model trained on combined (pooled) data from all three 409
source cities i.e., London, New York, and Vancouver, performed in estimating pollution 410
levels in Accra and Hong Kong. Evaluation of transferability performance is difficult for 411
cities where city-wide estimates of annual pollutant levels are scarce. Here, we used 412
monitoring station data from field campaigns carried out for Hong Kong [33] and for 413
Accra [18]. In Hong Kong, measurements were collected in two sampling campaigns 414
during the warm and cool seasons. Roadside measurements of NO2 were made for 2-3 415
week periods with Ogawa passive samplers at 97 locations. PM2.5 was measured with the 416
TSI SidePak personal aerosol monitors at 84 sites for 24 hrs. Both the NO2 and PM2.5 417
measurements at the above sites were adjusted for day-to-day variation with continuous 418
measurements made at a subset of four monitoring sites. A similar protocol was employed 419
in Accra (10 yearlong sites and 136 weeklong sites). Sites with street level images available 420
within a 50m distance threshold were included for evaluations in Table 1. 421
Estimation maps shown in Figure 4 associate major roads and city centers with high 422
pollution. However, when we evaluate performances with ground monitoring stations, 423
the performances were poor (r = 0.46, R2 = 0.21 (Hong Kong) and 0.21, R2 = 0.06 (Accra) for 424
NO2 in and, r = 0.02, R2 = 0.02 (Hong Kong) and 0.12, R2 = 0.01 (Accra) for PM2.5). In Hong 425
Kong, higher pollution levels near China, as expected, also are not captured as the images 426
do not contain information on proximity to high pollution regions. The city center, 427
however, is successfully identified as a relatively high pollution area. 428
429

Remote Sens. 2022, 14, x FOR PEER REVIEW 11 of 17
430
Figure 4. Prediction maps for NO2 and PM2.5 for Accra and Hong Kong. Prediction maps of mean 431
NO2 and PM2.5 levels for Accra and Hong Kong. Models were trained on combined data from 432
London, New York, and Vancouver and tested on images for Accra and Hong Kong. We adjusted 433
the color bar scale to visualize the spatial patterns for each city and pollutant where red areas 434
correspond to high pollution and green to low pollution. 435
. 436

| Remote Sens. 2022, 14, x FOR PEER REVIEW  |     |     |     |     | 12 of 17  |     |
| ----------------------------------------- | --- | --- | --- | --- | --------- | --- |

| 437  | Table 1. Summary of model performances for all experiments.  |     |     |     |     |     |
| ---- | ------------------------------------------------------------ | --- | --- | --- | --- | --- |

438
|     |   City-wide LUR based estimates of air pollution  |         |     |           |     |            |
| --- | ------------------------------------------------- | ------- | --- | --------- | --- | ---------- |
|     |                                                   | London  |     | New York  |     | Vancouver  |
r  RMSE  NRMSE  R2  ME  r  RMSE  NRMSE  R2  ME  r  RMSE  NRMSE  R2  ME
| NO2   |     | N = 94714  |     | N = 49575  |     | N = 60562  |
| ----- | --- | ---------- | --- | ---------- | --- | ---------- |
Intracity   0.79  7.31  0.20  0.62  -0.19  0.87  3.83  0.18  0.75  0.34  0.73  1.81  0.19  0.52  0.11
Intercity   0.42  21.38  0.58  0.18  18.80  0.60  12.83  0.59  0.36  -8.66  0.28  17.57  1.81  0.08  -16.69
Adj. intercity   12.07  0.32  0.00  6.89  0.31  0.00  3.12  0.32  0.00
| PM2.5   |     |     |     |     |     |     |
| ------- | --- | --- | --- | --- | --- | --- |
Intracity   0.79  0.88  0.06  0.59  0.04  0.85  0.61  0.06  0.71  0.069  0.60  1.63  0.49  0.33  0.14
Intercity   0.37  5.77  0.40  0.14  5.52  0.47  4.06  0.42  0.22  -2.21  0.06  9.10  2.73  0.00  -8.80
Adj. intercity   1.55  0.11  0.00  1.17  0.12  0.00  2.75  0.82  0.00
|     |   Ground monitoring stations  |         |     |           |     |            |
| --- | ----------------------------- | ------- | --- | --------- | --- | ---------- |
|     |                               | London  |     | New York  |     | Vancouver  |
r  RMSE  NRMSE  R2  ME  r  RMSE  NRMSE  R2  ME  r  RMSE  NRMSE  R2  ME
| NO2   |     | N = 8  |     | N = 47  |     | N = 4  |
| ----- | --- | ------ | --- | ------- | --- | ------ |
Intracity   0.90  17.71  0.27  0.81  13.47  0.76  27.97  0.49  0.58  26.29  0.97  2.63  0.24  0.95  1.65
Intercity   0.82  46.22  0.71  0.67  41.91  0.51  22.30  0.39  0.26  17.90  0.51  13.70  1.23  0.00  -12.14
Adj. intercity   13.52  0.21  0.00  14.38  0.25  0.00  4.81  0.43  0.00
| PM2.5   |     | N = 9  |     | N = 4  |     | N = 2  |
| ------- | --- | ------ | --- | ------ | --- | ------ |
Intracity   0.72  2.19  0.13  0.51  -0.34  0.86  1.15  0.10  0.74  1.56  -  1.04  0.25  -  0.70
Intercity   0.46  8.03  0.48  0.22  7.54  0.29  5.26  0.47  0.09  -4.41  -  8.81  2.15  -  -8.7
Adj. intercity   2.72  0.16  0.00  0.65  0.06  0.00  0.78  0.19  0.00

| Remote Sens. 2022, 14, x FOR PEER REVIEW  |     |     |     |     |     |     |     | 13 of 17  |     |     |
| ----------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --------- | --- | --- |

|     |     | Hong Kong  |     |     | Accra  |     |     |     |     |     |
| --- | --- | ---------- | --- | --- | ------ | --- | --- | --- | --- | --- |
r  RMSE  NRMSE  R2  ME  r  RMSE  NRMSE  R2  ME
|       |     |         |     |     |         |     |     |     |     |     |
| ----- | --- | ------- | --- | --- | ------- | --- | --- | --- | --- | --- |
| NO2   |     | N = 97  |     |     | N = 35  |     |     |     |     |     |
|       |     |         |     |     |         |     |     |     |     |     |
Intercity   0.46  63.30  0.58  0.21  51.63  0.25  38.55  0.63  0.06  30.19
|                  |        |       |         |        |         |       |     |     |     |     |
| ---------------- | ------ | ----- | ------- | ------ | ------- | ----- | --- | --- | --- | --- |
| Adj. intercity   | 42.42  | 0.39  |   0.00  | 28.65  | 0.47    | 0.00  |     |     |     |     |
|                  |        |       |         |        |         |       |     |     |     |     |

| PM2.5   |     | N = 52  |     |     | N = 32  |     |     |     |     |     |
| ------- | --- | ------- | --- | --- | ------- | --- | --- | --- | --- | --- |

Intercity   0.02  8.35  0.36  0.00  3.90  -0.12  13.02  0.61  0.01  8.09
|     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

| Adj. intercity                               | 9.76  | 0.42  |   0.00  | 11.91  | 0.56  |   0.00  |     |     |     |     |
| -------------------------------------------- | ----- | ----- | ------- | ------ | ----- | ------- | --- | --- | --- | --- |
| * ME and RMSE values are reported in µg/m3.  |       |       |         |        |       |         |     |     |     |     |
439

440
4. Conclusions 441
The focus of this work was to understand whether and to what extent information 442
contained in street level images only, with limited no or limited information on the local 443
conditions, can predict spatial variation in annual pollution levels. Performances of 444
image-based models, when trained and tested on the same city, for estimating mean 445
annual levels of air pollution were high. Model performances of these deep learning 446
models using only images as input were comparable to performances of traditional 447
models that require substantially higher levels input data. This suggests that images can 448
capture a substantial part of pollution sources often used as inputs for model for training 449
along with additional insights from post-hoc visualizations highlighting image regions 450
that are used by these models. 451
Like LUR models, transferability of models between cities in different geographies is 452
more difficult. Specifically, we found that transferability to Hong Kong and Accra was 453
much more difficult than transferability between London, Vancouver, and New York. 454
Image-based estimation models work better when transferring between cities that share 455
similar source of pollution. It is however a much larger challenge to transfer models 456
calibrated in cities with fundamentally different sources of pollution (e.g., type of cars, 457
biomass burning [46]). In other words, models’ ability is dependent on the similarity of 458
underlying sources of pollution that can be captured by images only. Hence, their ability 459
to scale up to global coverage is also dependent on availability of label data from cities 460
with similar source profiles. 461
Our findings suggest several open questions for future work. Would locally 462
calibrated LUR model outputs, where and when available, for a city like Accra transfer 463
well to other West African cities (e.g., in Nigeria) with similar sources of pollution? Would 464
images based only models transfer well to cities within the same country and over time? 465
Can active learning approaches of machine learning be utilized for effective local 466
calibration where the measurement points in target cities are sample in an optimal way? 467
Can images be combined with other globally available local sources of information (e.g., 468
satellite-based air quality estimates, aerial images satellite data on proximity to parks, 469
oceans, roads, OpenStreetMaps) to make better predictions for scaling up globally? How 470
can we modify data collection protocols to better utilize images and image-based 471
predictions? Can daily or hourly estimates be generated if images are available at high 472
temporal resolution? We hope that future research, based on this study, can help address 473
these questions and enable better models of pollutant levels with global coverage to 474
support global efforts to reduce pollutant levels and establish health effects. 475
Supplementary Materials: Supporting information can be downloaded at: www.mdpi.com/xxx/s1. 476
Author Contributions: Conceptualization, Esra Suel, Meytar Sorek-Hamer and Michael Brauer; 477
Data curation, Esra Suel, Meytar Sorek-Hamer, Michael Von Pohle, Adwait Sahasrabhojanee, Ata 478
Asanjan, Raphael Arku, Abosede Alli, Benjamin Barratt, Sierra Clark, Ariane Middel, Emily 479
Deardorff, Violet Lingenfelter, Majid Ezzati and Michael Brauer; Formal analysis, Esra Suel, Izabela 480
Moise and Michael Brauer; Funding acquisition, Esra Suel, Meytar Sorek-Hamer, Nikunj Oza, Majid 481
Ezzati and Michael Brauer; Methodology, Esra Suel, Meytar Sorek-Hamer, Izabela Moise, Michael 482
Von Pohle, Adwait Sahasrabhojanee, Ata Asanjan and Michael Brauer; Writing – original draft, Esra 483
Suel and Michael Brauer; Writing – review & editing, Esra Suel, Meytar Sorek-Hamer, Izabela 484
Moise, Michael Von Pohle, Adwait Sahasrabhojanee, Ata Asanjan, Raphael Arku, Abosede Alli, 485
Benjamin Barratt, Sierra Clark, Ariane Middel, Emily Deardorff, Violet Lingenfelter, Nikunj Oza, 486
Nishant Yadav, Majid Ezzati and Michael Brauer. 487
Funding: This work was supported by the Health Data Research UK funded by the UK Medical 488
Research Council (grant MR/S003983/1) and the Pathways to Equitable Healthy Cities grant from 489
the Wellcome Trust (209376/Z/17/Z). For the purpose of Open Access, the author has applied a CC 490
Remote Sens. 2022, 14, x. https://doi.org/10.3390/xxxxx www.mdpi.com/journal/remotesensing

Remote Sens. 2022, 14, x FOR PEER REVIEW  2 of 17

BY  public  copyright  licence  to  any  Author  Accepted  Manuscript  version  arising  from  this    491
| submission.  |     |   492 |
| ------------ | --- | ----- |
Data Availability Statement: All datasets used in this paper are publicly available and the URLs    493
are  provided  in  the  Data  section.  Upon  publication,  the  code  will  be  available  at    494
| https://github.com/esrasuel/sview-pollution.  |     |     |
| --------------------------------------------- | --- | --- |
495
Conflicts of Interest: The authors declare no conflict of interest.    496
|     |     |     |
| --- | --- | --- |
497

Remote Sens. 2022, 14, x FOR PEER REVIEW 3 of 17
References 498
1. P. J. Landrigan et al., “The Lancet Commission on pollution and health,” Lancet, vol. 391, no. 10119, pp. 462–512, 2018. 499
2. A. J. Cohen et al., “Estimates and 25-year trends of the global burden of disease attributable to ambient air pollution: an 500
analysis of data from the Global Burden of Diseases Study 2015,” Lancet, vol. 389, no. 10082, pp. 1907–1918, May 2017, doi: 501
10.1016/S0140-6736(17)30505-6. 502
3. G. Hoek et al., “Long-term air pollution exposure and cardio-respiratory mortality: A review,” Environmental Health: A 503
Global Access Science Source, vol. 12, no. 1. Environ Health, 2013, doi: 10.1186/1476-069X-12-43. 504
4. D. E. Schraufnagel et al., “Air Pollution and Noncommunicable Diseases: A Review by the Forum of International 505
Respiratory Societies’ Environmental Committee, Part 1: The Damaging Effects of Air Pollution,” Chest, vol. 155, no. 2. 506
Chest, pp. 409–416, Feb. 01, 2019, doi: 10.1016/j.chest.2018.10.042. 507
5. M. Brauer et al., “Exposure assessment for estimation of the global burden of disease attributable to outdoor air pollution,” 508
Environ. Sci. Technol., vol. 46, no. 2, pp. 652–660, 2012. 509
6. R. PH and L. GK, “A review of land-use regression models for characterizing intraurban air pollution exposure,” Inhal. 510
Toxicol., vol. 19 Suppl 1, no. Suppl 1, pp. 127–133, 2007, doi: 10.1080/08958370701495998. 511
7. R. V. Martin, M. Brauer, A. van Donkelaar, G. Shaddick, U. Narain, and S. Dey, “No one knows which city has the highest 512
concentration of fine particulate matter,” Atmos. Environ. X, vol. 3, p. 100040, Jul. 2019, doi: 10.1016/j.aeaoa.2019.100040. 513
8. S. Weichenthal, M. Hatzopoulou, and M. Brauer, “A picture tells a thousand… exposures: opportunities and challenges of 514
deep learning image analyses in exposure science and environmental epidemiology,” Environ. Int., vol. 122, pp. 3–10, 2019. 515
9. J. S. Apte et al., “High-Resolution Air Pollution Mapping with Google Street View Cars: Exploiting Big Data,” Environ. Sci. 516
Technol., vol. 51, no. 12, pp. 6999–7008, Jun. 2017, doi: 10.1021/acs.est.7b00891. 517
10. K. P. Messier et al., “Mapping air pollution with google street view cars: Efficient Approaches with mobile monitoring and 518
land use regression,” Environ. Sci. Technol., vol. 52, no. 21, pp. 12563–12572, 2018. 519
11. K. Hong, S. Weichenthal, and others, “A New Method of Estimating Global PM2. 5 Concentrations using Satellite Images,” 520
Environ. Epidemiol., vol. 3, p. 432, 2019. 521
12. A. Ganji, L. Minet, S. Weichenthal, and M. Hatzopoulou, “Predicting Traffic-Related Air Pollution Using Feature Extraction 522
from Built Environment Images,” Environ. Sci. Technol., vol. 54, no. 17, pp. 10688–10699, 2020. 523
13. K. Y. Hong, P. O. Pinheiro, and S. Weichenthal, “Predicting outdoor ultrafine particle number concentrations, particle size, 524
and noise using street-level images and audio data,” Environ. Int., vol. 144, p. 106044, 2020. 525
14. M. Sorek-Hamer, A. C. Just, and I. Kloog, “The Use of Satellite Remote Sensing in Epidemiological Studies,” Curr. Opin. 526
Pediatr., vol. 28, no. 2, p. 228, 2016. 527
15. E. Suel, J. W. Polak, J. E. Bennett, and M. Ezzati, “Measuring social, environmental and health inequalities using deep 528
learning and street imagery,” Sci. Rep., vol. 9, no. 1, pp. 1–10, 2019. 529
16. M. Qi and S. Hankey, “Using Street View Imagery to Predict Street-Level Particulate Air Pollution,” Environ. Sci. Technol., 530
Feb. 2021, doi: 10.1021/acs.est.0c05572. 531
17. G. Hoek et al., “A review of land-use regression models to assess spatial variation of outdoor air pollution,” Atmos. 532
Environ., vol. 42, no. 33, pp. 7561–7578, Oct. 2008, doi: 10.1016/J.ATMOSENV.2008.05.057. 533
18. S. N. Clark et al., “High-resolution spatiotemporal measurement of air and environmental noise pollution in Sub-Saharan 534
African cities: Pathways to Equitable Health Cities Study protocol for Accra, Ghana,” BMJ Open, vol. 10, no. 8, p. 35798, 535
Aug. 2020, doi: 10.1136/bmjopen-2019-035798. 536
19. Y. LeCun, Y. Bengio, and G. Hinton, “Deep learning,” Nature, vol. 521, no. 7553, pp. 436–444, May 2015, doi: 537
10.1038/nature14539. 538
20. E. Suel, S. Bhatt, M. Brauer, S. R. Flaxman, and M. Ezzati, “Multimodal learning for combining satellite data with street- 539
level images to measure socioeconomic status,” 2020. 540
21. K. de Hoogh et al., “Development of West-European PM2. 5 and NO2 land use regression models incorporating satellite- 541
derived and chemical transport modelling data,” Environ. Res., vol. 151, pp. 1–10, 2016. 542
22. R. Beelen et al., “Development of NO2 and NOx land use regression models for estimating air pollution exposure in 36 543
study areas in Europe--the ESCAPE project,” Atmos. Environ., vol. 72, pp. 10–23, 2013. 544
23. I. Kheirbek et al., “The New York City community air survey: Neighborhood air quality 2008--2014.” 2017. 545
24. S. B. Henderson, B. Beckerman, M. Jerrett, and M. Brauer, “Application of land use regression to estimate long-term 546
concentrations of traffic-related nitrogen oxides and fine particulate matter,” Environ. Sci. Technol., vol. 41, no. 7, pp. 2422– 547
2428, 2007. 548
25. M. J. Bechle, D. B. Millet, and J. D. Marshall, “National spatiotemporal exposure surface for NO2: monthly scaling of a 549
satellite-derived land-use regression, 2000--2010,” Environ. Sci. Technol., vol. 49, no. 20, pp. 12297–12305, 2015. 550
26. R. B. Smith et al., “Impact of London’s road traffic air and noise pollution on birth weight: Retrospective population based 551
cohort study,” BMJ, vol. 359, p. 5299, Dec. 2017, doi: 10.1136/bmj.j5299. 552
27. Clean Air for London, “London Atmospheric Emissions Inventory (LAEI) 2010,” 2010. . 553
28. R. Wang, S. B. Henderson, H. Sbihi, R. W. Allen, and M. Brauer, “Temporal stability of land use regression models for 554
traffic-related air pollution,” Atmos. Environ., vol. 64, pp. 312–319, Jan. 2013, doi: 10.1016/j.atmosenv.2012.09.056. 555

Remote Sens. 2022, 14, x FOR PEER REVIEW 4 of 17
29. U. S. EPA, “US EPA air quality download data,” aqs.epa.gov. 2020, [Online]. Available: 556
https://aqs.epa.gov/aqsweb/airdata/download_files.html. 557
30. G. of Canada, “Environment and Climate Change Canada Data.” 2020, [Online]. Available: 558
http://data.ec.gc.ca/data/?lang=en. 559
31. Imperial College, “London Air Quality Network.” 2020, [Online]. Available: 560
https://www.londonair.org.uk/london/asp/reportdetail.asp?ReportID=lars2010. 561
32. P. E. Lang, D. C. Carslaw, and S. J. Moller, “A trend analysis approach for air quality network data,” Atmos. Environ. X, 562
vol. 2, p. 100030, Apr. 2019, doi: 10.1016/j.aeaoa.2019.100030. 563
33. M. Lee et al., “Land use regression modelling of air pollution in high density high rise cities: A case study in Hong Kong,” 564
Sci. Total Environ., vol. 592, pp. 306–315, Aug. 2017, doi: 10.1016/j.scitotenv.2017.03.094. 565
34. A. S. Alli et al., “Spatial-temporal patterns of ambient fine particulate matter (PM2.5) and black carbon (BC) pollution in 566
Accra,” Environ. Res. Lett., vol. 16, no. 7, p. 074013, Jun. 2021, doi: 10.1088/1748-9326/AC074A. 567
35. J. Wang et al., “Nitrogen oxides (NO and NO2) pollution in the Accra metropolis: Spatiotemporal patterns and the role of 568
meteorology,” Sci. Total Environ., vol. 803, p. 149931, Jan. 2022, doi: 10.1016/J.SCITOTENV.2021.149931. 569
36. K. He, X. Zhang, S. Ren, and J. Sun, “Deep residual learning for image recognition,” in Proceedings of the IEEE conference 570
on computer vision and pattern recognition, 2016, pp. 770–778. 571
37. B. Zhou, A. Khosla, A. Lapedriza, A. Oliva, and A. Torralba, “Learning deep features for discriminative localization,” in 572
Proceedings of the IEEE conference on computer vision and pattern recognition, 2016, pp. 2921–2929. 573
38. Torch Contributors, “Torchvision models,” 2017. https://pytorch.org/vision/stable/models.html. 574
39. D. J. Briggs et al., “A regression-based method for mapping traffic-related air pollution: Application and testing in four 575
contrasting urban environments,” Sci. Total Environ., vol. 253, no. 1–3, pp. 151–167, May 2000, doi: 10.1016/S0048- 576
9697(00)00429-0. 577
40. M. Jerrett et al., “A review and evaluation of intraurban air pollution exposure models,” Journal of Exposure Analysis and 578
Environmental Epidemiology, vol. 15, no. 2. Nature Publishing Group, pp. 185–204, Mar. 04, 2005, doi: 579
10.1038/sj.jea.7500388. 580
41. K. Poplawski et al., “Intercity transferability of land use regression models for estimating ambient concentrations of 581
nitrogen dioxide,” J. Expo. Sci. Environ. Epidemiol., vol. 19, no. 1, pp. 107–117, Jan. 2009, doi: 10.1038/jes.2008.15. 582
42. K. Simonyan, A. Vedaldi, and A. Zisserman, “Deep Inside Convolutional Networks: Visualising Image Classification 583
Models and Saliency Maps,” Dec. 2013, Accessed: Oct. 14, 2017. [Online]. Available: http://arxiv.org/abs/1312.6034. 584
43. B. Zhou, A. Khosla, A. Lapedriza, A. Oliva, and A. Torralba, “Learning Deep Features for Discriminative Localization,” in 585
The IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2016, pp. 2921–2929, doi: 586
10.1109/CVPR.2016.319. 587
44. E. E. McDuffie et al., “Source sector and fuel contributions to ambient PM2.5 and attributable mortality across multiple 588
spatial scales,” Nat. Commun. 2021 121, vol. 12, no. 1, pp. 1–12, Jun. 2021, doi: 10.1038/s41467-021-23853-y. 589
45. E. Suel, J. W. Polak, J. E. Bennett, and M. Ezzati, “Measuring social, environmental and health inequalities using deep 590
learning and street imagery,” Sci. Rep., vol. 9, no. 1, pp. 1–10, Dec. 2019, doi: 10.1038/s41598-019-42036-w. 591
46. K. Dionisio, R. Arku, A. Hughes, and J. Vallarino, “Air Pollution in Accra Neighborhoods: Spatial, Socioeconomic, and 592
Temporal Patterns,” Environ. Sci. Technol., vol. 44, no. 7, pp. 2270–2276, Apr. 2010, doi: 10.1021/es903276s.. 593
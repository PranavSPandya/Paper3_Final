SustainableCitiesandSociety96(2023)104695
Contents lists available at ScienceDirect
Sustainable Cities and Society
journal homepage: www.elsevier.com/locate/scs
How does the visual environment influence pedestrian physiological stress?
Evidence from high-density cities using ambulatory technology and spatial
machine learning
Meng Caia,b,1, Luyao Xiangc,*,1, Edward Ngb,c
aSchool of Urban Design, Wuhan University, Wuhan, 430072, PR China
bInstitute of Future Cities, The Chinese University of Hong Kong, Hong Kong
cSchool of Architecture, The Chinese University of Hong Kong, Hong Kong
A R T I C L E I N F O A B S T R A C T
Keywords: Revealing the phased impacts of the visual environment on physiological stress in outdoor environments can
Skin conductance level facilitate accurate and practical planning strategies towards healthy and sustainable living environments. This
Ambulatory technology study adopted ambulatory sensing to monitor high spatiotemporal physiological stress from skin conductance
Street view
level (SCL) and analyzed the association between the visual environment and the SCL in high-density environ-
Isovist
ments. The multi-level visual environment was quantified from isovist and street view images. The most influ-
Geographical random forest
Moving window ential lags for each visual exposure factor were identified. Furthermore, multiple linear regression (MLR) and
geographical random forest (GRF) were established to examine the effects of the lagged visual exposure factors
on SCL. Particularly, the GRF can explore spatial nonstationary and complex relationships. The MLR (R2 =0.466)
suggests that exposure to trees, sky, and sign symbols can relieve stress. The GRF with 5 visual exposure factors
can explain 87.4% of the spatial variance of SCL. This study confirms the effectiveness of monitoring pedestrians’
stress in high-density cities and the phased and non-instantaneous impacts of the visual environment. The results
have practical implications in urban design at both district and site levels for a sustainable and psychologically
friendly urban environment.
1. Introduction Goals (SDGs) of the United Nations (SDG 3.4 and 11.3).
1.1. Background
1.2. State of the art
World Health Organization recently noted that the needs for
Understanding the interaction between people and the environment
improving mental health are high but responses are inadequate world-
is fundamental to urban planning strategies to promote healthy and
wide, and predicted that one in five people have suffered a mental dis-
sustainable living environments. Advances in wearable technology
order in the last decade (World Health Organization, 2022). The
enable psychophysiological sensors to accurately and stably record in-
outbreak of COVID-19 is causing further negative psychological impacts
on people (Grover et al., 2020; Saladino, Algeri & Auriemma, 2020; dividuals’ physiological responses, thus further fostering the under-
standing of the effects of urban spaces on people’s psychological
Serafini et al., 2020). Furthermore, rapid and intense urbanization ex-
experiences and people-oriented design strategies.
poses urban residents to more stress (Lederbogen et al., 2011; Weich,
Based on wearable devices, the first idea of visualizing and mapping
2002). Therefore, it is essential to create a sustainable and healthy living
emotional data comes from an artist (Nold, 2009), and many scholars
environment to minimize the negative impacts on the mental health of
conducted a series of outdoor experiments to seek opportunities to
urban residents. Promoting mental health and creating healthy cities
reduce human stress levels in urban environments (Griego, Buff, Hayoz,
have become the indicators and targets of the Sustainable Development
Moise & Pournaras, 2017; Hijazi et al., 2016; Javadi et al., 2017; X. Li
* Corresponding author.
E-mail address: XIANG.Luyao@link.cuhk.edu.hk (L. Xiang).
1 Both authors contributed equally to this work and should be considered co-first authors.
https://doi.org/10.1016/j.scs.2023.104695
Received 12 January 2023; Received in revised form 30 March 2023; Accepted 28 May 2023
Availableonline2June2023
2210-6707/©2023ElsevierLtd.Allrightsreserved.

M. Cai et al. S u s t a in a b l e C i t i e s a n d S o c i e ty96(2023)104695
et al., 2016; Mavros, Austwick & Smith, 2016; Neale et al., 2020) (W. essential for establishing a deep understanding of how the built envi-
Lin et al., 2020; Mangone, Capaldi, van Allen & Luscuere, 2017; Rog- ronment visually influences physiological stress.
erson, Gladwell, Gallagher & Barton, 2016; Xiang, Cai, Ren & Ng, 2021). In terms of the outdoor measurement of SCL, the majority of studies
These studies proved the effectiveness and stability of wearable devices stayed at comparing of the differences between before and after expe-
application in outdoor spaces and laid the theoretical and empirical riencing various types of urban or greening spaces or various types of
foundation for further studies. human behaviors (Kim, Yadav, Chaspari & Ahn, 2020; Mavros, J W¨alti,
In addition, vision is the major source of the external information Nazemi, Ong & Ho¨lscher, 2022; Mir et al., 2023). According to the
that people typically acquire, which largely affects human perception definition of SCL and the findings from interior experiments, it is
(Brakus, Schmitt & Zarantonello, 2009) and subsequent experience essential to fully explore the spatiotemporal variations of SCL within
(Kalat, 2015). A series of experiments conducted outdoors have verified urban environments. Furthermore, those outdoor experiments rarely
the impact of various visual characteristics on psychological percep- consider the long-term effect of the visual environment. Besides, SCL
tions, such as isovist (De Silva, Warusavitharana & Ratnayake, 2017; responses to specific visual elements in urban areas, such as roads,
Hijazi et al., 2016; X. Li et al., 2016; Marianne & Kno¨ll, 2017; Winz et al., buildings, and sky, have not been analyzed or quantified. Those limi-
2022), architectural variation (Lindal & Hartig, 2013), the low or tations of the current outdoor studies bring challenges to the accurate
high-rise of the buildings (Mazumder, Spiers & Ellard, 2022) and the understanding of the effect of the visual environment and effective
streetscape (X. Li et al., 2016; F.-C. Lin, She, Ngo, Dow & Hsu, 2021; spatial planning strategies to improve the mental health of pedestrians.
Xiang et al., 2021; Zheng Chen, Sebastian Schulz, Xiaofan He & Yifan
Chen, 2016). The visual environment is therefore an important diver of 1.4. Analytical methods for exploring the relationship between visual
physiological stress. It is essential to understand its effects on physio- environment and physiological data
logical stress to facilitate urban planning strategies toward a psycho-
logically friendly urban environment. As for the methods to associate the visual environment with physi-
ological data, laboratory studies commonly adopted pathway or corre-
1.3. Literature review on physiological stress: insights from laboratory lation analysis. For outdoor conditions, the environment is more
studies and drawbacks of current outdoor studies complicated with unknown, diverse, and unstable changes. More
advanced methods are thereby required to reveal the environmental
A number of studies have analyzed the interaction between physio- impacts timely and spatially. In the outdoor environment, previous
logical stress and visual environment. In particular, physiological stress studies generally adopted global statistical models such as multiple
can be quantified by the general tonic skin conductance level (SCL). SC linear regression (MLR) (Millar et al., 2021; Xiang et al., 2021) and
has been considered to constitute an objective assessment of sympa- machine learning (X. Li et al., 2016). Compared with the linear model,
thetic activity through the electric impulses on the surface of skin and machine learning methods can consider nonlinear and complex re-
sweat glands, which are affected only by the sympathetic nervous sys- lationships. However, those models regard the relation as instantaneous
tem (Jesper J. Alvarsson, Stefan Wiens & Mats E. Nilsson, 2010). SC and spatially stationary for each point. Physiological stress can not only
contains phasic skin conductance response (SCR) and skin conductance be affected by the environment at the specific locations but also the
level (SCL); the former refers to the faster changing of the signal, and the previous experience that happened in the surroundings. The effects of
latter relates to the slower-acting ones. SCL can be computed as an the visual environment can be continuous and spatially variant, while
average across longer intervals that typically range from tens of seconds few studies have attempted to account for spatial heterogeneity when
to tens of minutes, depending on the environment and time. The higher modeling stress as a function of geographical data. Hence, considering
the SCL, the greater the stress. the spatially non-stationary impacts of the visual environment in the
Therefore, SCL has been frequently used as a measure of physiolog- statistical model is significant for a more accurate understanding of the
ical stress to understand the effects of the visual environment. The effect of the environment. Spatial machine learning that can consider
empirical studies focused on SCL are mainly from interior spaces and the spatial non-stationary, nonlinear, and complex relationship, is
laboratories. Roger S. Ulrich et al. (1991) continuously monitored a therefore suitable for analyzing the impacts of visual environment on
series of physiological measures, including 10-minute changes in SCL physiological stress.
response, and found that individuals who viewed natural settings
experienced more rapid and complete recovery compared to the built 1.5. Objectives
settings. Stress recovery from nature views happened remarkably
fast—in about 4 min. Huang, Yang, Jane, Li and Bauer (2020) found that In order to address the above research gaps, this study aims to un-
stress levels showed different tendencies in the 7th minute after viewing derstand the impact of multi-level visual environments on physiological
concrete, grass, and tree landscapes. Yin, Zhu, MacNaughton, Allen and stress in outdoor environments using ambulatory technology and spatial
Spengler (2018) identified the different physiological stress perfor- machine learning. The application and utility of the findings of this
mances from the same stress stimulus by evaluating time cost. Labora- study are anticipated to contribute to spatial optimization schemes and
tory research verified that the changes in SCL are not instant responses planning strategies to achieve healthier and more sustainable cities and
to visual scenes and also noise (J. J. Alvarsson, S. Wiens & M. E. Nilsson, communities.
2010). Its fluctuation depends on different types of landscapes and is a The objectives of this study are as below:
long-term effect of the stimulus.
Since these studies were conducted in controlled laboratories, the 1 To monitor the spatiotemporal variations of SCL in an outdoor urban
results can be different from those in the real built environment and environment.
have limitations to guide the real urban planning practice. Nevertheless, 2 To quantity the visual environment using both street view images
the characteristic of SCL from experiments in laboratories can still and isovist.
inspire the hypothesis that the earlier events (what subjects have seen in 3 To conduct a sensitivity test to identify the most influential lag dis-
this study) can influence the current SCL within different scales and tance for each visual impact factor.
periods. For example, pedestrians will gain good physiological stress 4 To gain a quantitative understanding of the effects of various visual
conditions after touring an urban park, and the effect will maintain for a exposure factors on SCL using linear regression and spatial machine
while. After leaving the site and entering the street environment of learning.
hundreds of meters, this effect will be weakened. Therefore, taking the 5 To provide urban planning recommendations to promote the mental
influential spatial lag of the physical elements into consideration is health of pedestrians.
2

M. Cai et al. S u s t a in a b l e C i t i e s a n d S o c i e ty96(2023)104695
2. Materials and methods empirically proved that it has a strong relationship with human behavior
and psychological interaction with the environment (Appleton, 1975;
2.1. Study area Dawes & Ostwald, 2014a, 2014b; Dosen & Ostwald, 2016; Fish-
er-Gewirtzman, Burt & Tzamir, 2003; Fisher-Gewirtzman & Wagner,
Situated on the southeast coast of China, Hong Kong has the third 2003; Yu, Gu & Ostwald, 2016).
highest population density globally (The World Bank, 2018). The We calculated 2D isovist and 3D isovist in Rhino 6, Grasshopper
confined living conditions caused by the high-density development are Decoding Spaces Toolbox developed by the team of Computer Science in
detrimental to the mental health of local residents. Hong Kong Mental Architecture at Bauhaus University (https://toolbox.decodingspaces.
Morbidity Survey shows that one in six of the local residents has a net/). The building models used for calculation were adopted from a
mental disorder, like anxiety or depression. This number increased to previous study (Ren, Cai, Li, Shi & See, 2020). The maximum visual
one in two in 2016 (The Mental Health Association of Hong Kong, 2016). length is determined as 500 m, the visual height was 1.6 m, The basic
Approximately 60% of the citizens claimed to have mental health issues settings of isovist calculation are summarized in Table 1.
in 2020 (MHA 2020). The 2D isovists describe the characteristics of the visual area on a 2D
Tsim sha tsui (TST) and Hung hom (HH), two districts on the Hong floor plan, the parameters include isovist area, perimeter, compactness,
Kong Kowloon Peninsula with the highest building volume density, are circularity, occlusivity, the length of the visual radial line, the angle
chosen for the field trip. TSTS is a bustling commercial district, whereas between the direction facing occupant and the mass center of an isovist
HH is a residential community. TST is well known for its commercial polygon, etc. The 3D-volumetric isovists describe the proportion of each
vibe and draws a sizable number of tourists every day. TST is one of the factor, including sky, object, ground, and visual volume (total length of
busiest areas in Hong Kong and has few trees because of the vibrant all visual lines).
business climate there. The majority of the initial section of the HH route
is made up of undeveloped area, with only a few structures. Because 2.2.2. Street view factors
there are few commercial activities along this route, it is calm and Apart from isovist, the street view factor (VF) is another important
sparsely populated. The second part of the HH route is typical of the way to quantify the physical streetscape. Isovist reveals the geometric
urban environment, featuring food markets, communal facilities, and characteristics of the visual areas, but the accuracy of the calculation
high-rise residential buildings. The big stars in Fig. 1 indicate the relies on the precision of the building model. Furthermore, models of
gathering points for the pre-walk test. The lengths of the routes are 1.1 other urban elements, such as greenery, are hard to obtain and built.
km and 1.3 km for TST and HH, respectively. At the black point, the data Street view images can compensate for the drawbacks of isovist,
begin to be recoyrded. The location of the mid-walk test is also indicated providing additional information about the visual content. Therefore,
by a small star on the map. this study combined the isovist and street view factors together to build
Table 1
2.2. Visual exposure data
The basic settings of isovist calculation in Decoding.
2.2.1. Isovist Visual height 1.6 m
Viewing range 500m
Isovist has a long history in architecture and geography, as well as Horizontal Viewing angle 60 ◦
mathematics (Turner, Doxa, O’Sullivan & Penn, 2001). The definition of Vertical viewing angle 55 ◦
isovist is ‘the set of all points visible from a given vantage point in space Vertical angle offset (cid:0) 2.5 ◦
(Larry S. Davis & L.Benedikt, 1979). Isovist has been theoretically and
Fig. 1. Study area and experimental routes: (a) TST route, (b) HH route.
3

M. Cai et al. S u s t a in a b l e C i t i e s a n d S o c i e ty96(2023)104695
a multi-level visual environment. 2.4. Mobile data collection
VF was determined as the percentage of the class pixels and the total
pixels of the street view image. We adopted a pre-trained network based A dedicated GPS device (Garmin GPSmap 62 s) was attached to the
on the Cambridge-driving Labeled Video Database (CamVid) (Brostow, shoulder of the participant at a frequency of 1 Hz. It collected the
Fauqueur & Cipolla, 2009) and the Deeplab v3+network (Chen, Zhu, geographic coordinates of the participant and the corresponding time-
Papandreou, Schroff & Adam, 2018) with weights initialized from a stamps as they walked the predetermined route. The real-time SC data,
pre-trained Resnet-18 network. The view factor of the seven most street views, and isovist data were then combined with the locational
common and basic elements in urban areas, namely, sky, building, road, data.
sign symbol, car, people, and tree were extracted from the images. This study used clinical devices for the acquisition of the psycho-
We divided experimental routes with 4 m intervals, and there were logical stress data owing to the high accuracy of the raw data and the
548 sample points in total. 28 visual exposure factors were finally professional post-processing system. The Shimmer 3 GSR+ device
retrieved for each point, of which 21 were from isovist and seven were (Shimmer, www.shimmersensing.com/) is used to measure skin
from street view images. The detailed definition and spatial distribution conductance. It has been clinically tested and demonstrated high val-
of the visual exposure factors can be found in Table S1 and Figure S1 in idity and accuracy (Gatti, Calzolari, Maggioni & Obrist, 2018).
the supplementary information (SI).
2.5. Physiological data processing
2.3. Experimental details
Ledalab 4.8.3 toolbox (www.ledalab.de) was used to analyze each
2.3.1. Subject enrollment and experiment time recording. Based on the default parametric parameter, we used contin-
An online announcement with a 60 HKD reward for each person was uous deconvolution analysis (CDA) to separate the SCL and SCR from the
used to recruit participants. The range of ages was set at 18 to 35. There raw data. The Event-Related-Activation tool in Ledalab calculates and
were 103 participants in total (M = 51, F = 52). The participants’ exports the average SCL for each sample every four seconds.
average age is 26 (SD =5). Experimental routes were assigned to the We standardized SCL after separating the raw SC data to exclude
participants at random. Lastly, 51 people took the TST route and 48 individual differences. The baseline and the range for each individual
people took the HH route, respectively. Four individuals ended the are relative, that is, 15muS can be an extremely high SCL for one indi-
experiment midway due to personal reasons. vidual, but only the baseline SCL for another. There is no universally
Taking into account the extreme weather in Hong Kong, the exper- agreed method. The study adopted the range-corrected scores intro-
iment was carried out from December 2018 to May 2019, when the duced by Dawson, Anne M. SCHELL and FILION (2001), computing the
weather was relatively pleasant (minimum air temperature =17.67 ◦C, minimum SCL during the baseline (or rest period) and the maximum SCL
standard deviation =3.99 ◦C, maximum air temperature = 24.08 ◦C, during the most arousing period. The SCL of the participants at any other
standard deviation =4.28 ◦C; data source: HKO, available at https:// time, in this study, can be delineated as a proportion/percentage of their
www.hko.gov.hk/en/index.html). Two time periods, 10:00 to 12:00 maximum range of individual psychophysiological response using (Eq.
am and 2:00 to 4:00 pm, were chosen for experiments on weekdays. (1)):
2.3.2. Experiment design SCLj′ = SCL j (cid:0) SCL baseline (1)
SCL (cid:0) SCL
Three people participated simultaneously in the experiment on each Max baselinemin
environmental day. Each participant made their own way to the gath- where SClj ’ is the standardized SCL score at the aggregation point j. SCLj
ering spots. After receiving an overview of the experiment upon arrival, is the extracted value at point j, SCLbaselinemin refers to one’s minimum
the participants were asked to sign a written consent form for their SCL during baseline recording, SCLmax refers to one’s maximum SCL
voluntary participation.
level during the whole experiment.
The experiment began with 100 s of standing posture relaxation
retreatment (Chatterjee et al., 2018), this value is used as the SC baseline
2.6. Statistical analysis
for subsequent data processing. In the first ten minutes, the participants
viewed the corresponding landscapes from a seated position. After that,
We aggregated the data by combining the visual exposure factors and
an experimental instructor led the participants on a walk that lasted for
physiological data of 99 participants, with an interval of 4 m for further
forty minutes. statistical analysis. All participants’ SCL values were averaged for the
The SC was recorded continuously at a frequency of 10 HZ
same geo-coordinate point, which would be regarded as the response
throughout the experiment. Additionally, self-reports of perceived
variables. Meanwhile, the 28 visual exposure factors from both street
valence and arousal conditions were collected three times throughout
view images and isovist at the corresponding geo-coordinate would be
the experiment—at the beginning, middle, and end. The experiment
used as potential predictor variables.
takes about 90 min to complete. Fig. 2 provides an overview of the
experimental procedure.
2.6.1. Identifying the most influential lag distance
SCL relates to the slower-acting components, showing phased
changing over long intervals according to different environments
Fig. 2. overview of the experimental procedure in the real urban environment.
4

M. Cai et al. S u s t a in a b l e C i t i e s a n d S o c i e ty96(2023)104695
stimuli, typically ranging from tens of seconds to tens of minutes, which 2.6.2. Multiple linear regression
can be further reflected in distances from dozens to hundreds of meters. The multiple linear regression equation is shown as (Eq. (3):
T di h s e ta re n f c o e r e o , f i t e i a s c e h s s v e i n su ti a a l l e to x p e o v s a u lu re a t f e a c th to e r m to o s e t x i c n l fl u u d e e n t t h ia e l i t m im p e a c in t t o e f r v l a o l n o g r - SCL′j=α 1 VE 1 +α 2 VE 2 +…+α n VE n +γ+ε (3)
term environmental signals on stress and acquire visual sensitivity. To
detect the most influential distance and verify the hypothesis of time lag, where SCL’ j is the averaged physiological stress across all participants at
the aggregation point j. VE denotes the lagged visual exposure factors.
we conducted a sensitivity test of different lag distances inspired by the
α1…, αn are the coefficient estimates of the metrics VE1, VEn at point j. γ
‘space for time’ concept (Y. Li et al., 2023; Shi, Ren, Lau & Ng, 2019)
is the model intercept, and ε is the residual. The MLR model was con-
(Fig. 3). The maximum scale of the lag distance was set as 500 m and the
structed based on the visual exposure factors with the most influential
interval as 20 m, which corresponded to the scale of the general com-
lag distance retrieved from section 3.5.1. We used stepwise linear
munity and buildings in Hong Kong, respectively. There were 26 lag
regression. The least correlated variable is eliminated from each itera-
distances in total including zero (no lag). The mean value of all the vi-
tion of multiple regression, and all significant variables are included in
sual exposure factors within each lag distance was calculated. The same
the resultant model. In order to include significant and non-collinear
factor calculated within different lag distances was regarded as different
factors, we refined the independent variables by adopting the
variables. For example, tree view factors calculated using 20 m and 40 m
following rules: p-value <0.05 and VIF <5.
lags were regarded as two different factors in this study. The 28 visual
exposure factors needed to be calculated using the 26 different lags.
2.6.3. Geographical random forest
Correlation analysis was conducted to gain the correlation coeffi-
Random forest (RF) is a classical and popular machine-learning al-
cient (r) between the mean visual exposure factor within the 26 lags and
gorithm that consists of multiple decision trees (Breiman, 2001).
the SCL’ at the pedestrian point to detect the most influential lag dis-
tance. For point j, the largest R2 for each lagged visual exposure factor Compared with other machine learning techniques such as K-Nearest
Neighbors, Naive Bayes, and Support Vector Machines, RF has the
can be expressed as (Eq. (2):
{[ (∑ )] } ability to handle mixed data types and missing data, non-linear decision
n VE 2 boundaries, and provide feature importance ranking. Besides, since the
Rmax2=Max r i= n 1 ij, SCL j (2) RF makes predictions based on multiple decision trees, it generally
shows high accuracy levels (Chung, Xie & Ren, 2021) and rarely has the
overfitting issue. Therefore, the RF is a suitable machine learning
where r refers to the correlation coefficient, n means the number of in-
approach for modeling and interpreting SCL based on the
tervals that range from 0 to 25, VEij represents the ith visual exposure
multi-dimensional visual exposure dataset in this study.
factor contained in the lag distance since point j, SCLj is the average of all
participants’ physiological stress at point j. When the Rmax2 of each The original RF regression is a global model that conducts regression
for the entire data domain. Recently, a geographical RF (GRF) model has
visual exposure factor was identified, the corresponding lag was regar-
been developed as an extension of the RF to incorporate spatial non-
ded as the most influential lag distance for the factor.
It can be assumed that the Rmax2 can be low for some visual expo- stationarity, which is similar to Geographically Weighted Regression
(GWR) (Fotheringham, Brunsdon & Charlton, 2003) that decomposes
sure factors. To only include influential visual exposure factors in further
modeling, this study set 0.1 as the threshold, and factors with Rmax2 the global OLS model to local computation. Therefore, GRF is a bridge
between machine learning and geographical models, taking advantage
lower than this value were excluded. A spatial moving window approach
of the predictive power of the RF and the spatial non-stationarity of the
was then performed on each remaining factor and the most influential
GWR. We adopted the GRF in this study to consider the effect of sur-
lag distances were regarded as the window size (Fig. 4). For each visual
rounding visual environments as well as the non-linear relationship.
exposure factor, only the mean value within the lag distance corre-
sponding to the Rmax2 was selected as the potential predictive variable The GRF was developed based on the decomposition of the RF to
several local sub-models (Eq. (4)). This means that for each position i, a
and included in the next stage of the statistical analysis (Shi et al., 2019).
local RF is calculated, including n nearby observations. Therefore, each
Fig. 3. Workflow of identifying the most influential lag distance. The red arrow represents the walking direction of participants.
5

M. Cai et al. S u s t a in a b l e C i t i e s a n d S o c i e ty96(2023)104695
Fig. 4. Spatial moving window approach to acquire the lagged visual exposure.
local RF model has its own performance, predictive power, and variable curious about the routes to some extent and did not quickly lose interest
importance at each training data point. Accordingly, the model is during the walk.
evaluated locally for each observation. Participants did not feel much stress due to wearing Shimmer devices
when walking (Mean=2.04, SD=1.06), and the feeling of discomfort
Y i = a(u i , v i )x i + e,i = 1: n (4) from just looking ahead was slightly greater (Mean=2.64, SD=1.36).
This indicates that the rules of the experiment did not significantly in-
where a(ui, vi)x is the prediction of an RF model calibrated on location i,
fluence the participants.
and (ui, vi) are the coordinates. A sub-model is built for each data
location, considering only nearby observations.
First, the observations were randomly divided into training sets and 3.2. The SCL scale statistics
validation sets in a ratio of 80% to 20%. The model was developed using
the training data sets. The GRF was performed using the ‘SpatialML’ The results of the paired t-test showed, as expected, that walking in
package in R (Georganos et al., 2018); “SpatialML.” R Foundation for an urban environment significantly affected the SCL of the participants
Statistical Computing. This model contains two sets of necessary pa- (Mpre-walk =3.44, Mmid-walk =5.706, Mpost-walk =6.375, p<.001). The
rameters. The first set comes from the original RF, including the number arousal increased after walking in the experimental routes. It can be
of trees, the number of predictors to sample as candidates at each split, noted that the increasing trends are the same for the two routes between
and the minimum leaf size. These parameters were tuned using a pre-walk and mid-walk, but different between mid-walk and post-walk.
Bayesian optimization from the global RF model and the parameter The SCL of the participants in the TST group decreased after the second
values from the optimization were used to train the local models. part, while for the HH group, the SCL increased gradually (Table S2 in
The second set is geographical parameters, including coordinates of SI).
the observations, and the area in which the sub-model covers (kernel) As expected, the SCL baselines for the two routes showed no signif-
(Kalogirou, 2016). In this study, the kernel was defined by a circle with a icant differences (MTST =4.267, SD=3.464, MHH =4.708, SD=4.223, F
distance of maximum distance (bandwidth) (Brunsdon, Fotheringham & (1,97)=0.325, p>.1). After the standardization of the SCL, the data can
Charlton, 1998; Fotheringham et al., 2003). In this study, we tuned the be compared between different groups. The results of the ANOVA t-test
kernel from 20 m to 300 m with a 20 m interval and determined the revealed that the participants had significantly higher SCL’ on the TST
optimal kernel value based on the R2 and MSE of the local model. route compared to the HH route (F(1,97)=10.869, p<.01). The mid-
Finally, the optimal GRF model can be established from the optimal points separated the routes into two parts. There is evidence that the
parameters, and the validation data were fed into the retrieved trained major difference between the two routes came from the first part (MTST
model to acquire the predictive value. The retrieved predictive model =0.74, SD=0.15, MHH =0.45, SD=0.27, F(1,97)=39.75, p<.01). The
was evaluated by R2, RMSE, and MAE for both the trained data and second part of each route has similar effects on SCL’, in which the mean
validation data. value did not show significant differences (MTST =0.68, SD=0.14,
MHH =0.62, SD=0.35, F(1,97)=1.624, p>.1) (Table S2 in SI).
3. Results Fig. 5 indicates the spatial distribution of the SCL for both routes. The
participants showed significantly higher SCL’ at the end of the experi-
3.1. Basic information about the participants ment, compared to the beginning of the walk. This indicates that
walking around the city can increase the arousal of pedestrians. How-
For the TST route, there were 51 participants, including 22 were ever, the spatiotemporal variations of SCL’ for the two routes are
males and 29 females. The average age is 25.80 (SD=4.75). For the HH different, which can be explained by different urban elements and
route, 48 people participated, including 25 males and 23 females. The morphological characteristics of the streets.
average age is 26.27 (SD=5.35). The overall mean familiarity of two
routes is 3.53 (SD=1.57), which is located within the Likert scale
3.3. Influential lag distance
(ranging from extremely not familiar 1 to extremely familiar 7). The
mean familiarity is 3.69 for TST (SD=1.62) and 3.35 for HH (SD=1.51). Although the relationship between each predictor and SCL’ main-
The participants were not very familiar with the study area. They were tains the same direction for all lag distances throughout the process, R2
6

M. Cai et al. S u s t a in a b l e C i t i e s a n d S o c i e ty96(2023)104695
Fig. 5. Spatial distribution of SCL for (a) TST and (b) HH.
shows evident fluctuations. Taking the Road view factor (RVF) from the route were reported finally. Table 3 shows the results of the MLR model.
street view images as an example, R2 increases along with the expansion After the stepwise regression, five lagged visual exposure factors are
of the distance, however, after the 160-meter threshold, it decreases significant and are non-collinear (VIF<5). The residual conforms to the
rapidly (Fig. 6). When the average for predictors was calculated for a normal distribution; therefore, the final model is effective and stable.
longer distance, R2 gradually increases and reached the maximum. The model already explains almost 46.6% variation in the measured
Correlation analysis shows that the values of the R2 of all visual SCL’. The results indicate the significance of street view and isovist in
exposure factors from 2D isovist are low, therefore, they are excluded in explaining the spatial variation of SCL’.
the further MLR and GRF analysis. The 2D isovist is mainly about the The increasing order of the effectiveness of the remaining visual
very detailed information of geometric characteristics of the visible area. exposure factors of the MLR model is: TVF, RVF, SSVF, sky proportion,
The complicated information passes from sensory memory to short-term and object proportion. Among the five predictors, three of them influ-
memory and long-term memory, and the number of perceptual details ence SCL’ in a negative way, which are Sky3D, SSVF, TVF. TVF has the
stored decreases (Brady, Konkle, Alvarez & Oliva, 2008), which was largest St. coefficients ((cid:0) 0.260) while Sky3D has the lowest ((cid:0) 0.181)
reflected by the relatively lower R2 of 2D isovist. one. The remaining two predictors, Obj3D and road view factor (RVF)
For the rest visual exposure factors from 3D isovist and street view, are all positively related to SCL’.
nine visual exposure factors remain with R2 larger than 0.1. The most
influential lag distance and the corresponding R2 of the remaining fac- 3.4.2. Geographical random forest
tors (Table 2). Among all the factors, the sky view factor of 50 m lag has Based on the selected five predictors, the optimal set of parameters
the largest R2 of 0.55, whereas the object proportion from 3D isovist has was determined through the tuning process. The number of trees is 80,
the lowest one. the minimum leaf size is one, and the number of predictors to sample is
one. In the optimal global model, the R2 is 0.840, RMSE is 0.024, and
MAE is 0.017. the values of the parameters were further used to train the
3.4. Resultant models local models of the GRF.
In the GRF model, the bandwidth was tuned, and the 160 m band-
3.4.1. Multiple linear regression width is associated with the highest R2 and smallest MSE (Fig. 7). We
A total of 136 points for the HH route and 143 points for the TST
7

M. Cai et al. S u s t a in a b l e C i t i e s a n d S o c i e ty96(2023)104695
Fig. 6. Example of R2 variation of RVF.
Local R2 reflects the accuracy of the model. Fig. 9 shows the map of
Table 2
its distribution. For the HH route, the value varies from 53.73% to
Influential lag distance and corresponding R2 for each predictor/. 95.79% (M =85.29, SD=7.09), for the TST route, the value varies from
Predictor Influential lag distance (m) R2 57.89% to 95.30% (M =84.85%, SD=7.49).
3D isovist It can be seen that the high and low values occur at different loca-
Sky proportion (Sky3D) 300 0.381 tions for TST and HH routes. For the HH route, high R2 is located cen-
Object proportion (Obj3D) 400 0.131 trally at the beginning stage of Tak on St, and at the end of the whole
Ground proportion 220 0.265
route. These two locations are mainly commercial areas compared to
Visual volume 280 0.442
Street view other sections. For the TST route, high R2 is located more concentrated
Sky view factor (SkyVF) 200 0.550 in the middle of the route, with a moderate commercial atmosphere. The
Building view factor (BVF) 40 0.486 first part of this stage is with a narrow and quiet environment, while the
Road view factor (RVF) 160 0.464 second part is the main road. Local R2 shows different patterns in resi-
Sign symbol view factor (SSVF) 100 0.254
Tree view factor (TVF) 80 0.477 dential and commercial areas. For the commercial areas, visual elements
with commercial characteristics, such as sign symbols, play an impor-
tant role in increasing the R2. In terms of residential areas, the locations
with more trees and sky proportion have larger R2.
Table 3
The resultant MLR model for interpreting the visual effects on SCL’. In terms of the importance of the predictors, for the HH route, it can
be noticed that all predictors are relatively more important in the second
predictor variables standardized coefficients Sig. VIF
stage of Tak On St than other streets. The highest values of incMSE of
Beta
SSVF, SkyVF, Obj3D_400 m appear on it, which ranges from 21%(cid:0) 26%.
intercept .000 Especially, for the Obj3D_isovist, the values of other streets are much
Sky3D_300m (cid:0) 0.181 .002 2.259
lower than Tak On St. The highest value occurs after the biggest cross-
Obj3D_400m .176 .004 2.365
RVF_160 m .242 .000 2.598 roads along the route. For RVF and TVF, the highest incMSE value ap-
SSVF_100 m (cid:0) 0.232 .000 2.009 pears on the starting stage of dyer ave, where the participants turn right
TVF_80 m (cid:0) 0.260 .001 4.227 and enter an uphill road. It can be noticed that the importance of TVF is
higher at this location from Fig. 10. Compared with the HH route, the
distribution of high incMSE value of the TST route is more scattered for
thereby determined the 160 m distance as the optimal kernel value.
each predictor. The beginning of the route has a relatively lower value
Based on the five predictors and optimal hyperparameters, the
geographical RF model can be therefore established. The global mean R2 for all predictors. For the RVF, the highest value exists at the corner of
Mody Rd and Nathan Rd, where the environment changes a lot, from the
of the trained geographical RF is 0.874 and MSE is 0.001, which shows
narrow street to the wide main city road surroundings. Similar to RVF,
higher predictive ability than the MLR and the global RF model.
the highest incMSE of TVF also occurs at the corner of two roads. For
The established model was further applied to the validation dataset.
other predictors, the high value is located on Hankow Rd.
By comparing the predicted and the actual SCL in the validation dataset,
R2, RMSE, and MSE were identified to be 0.869, 0.036, and 0.001 With the variation of the incMSE values, it could be noticed that the
two routes keep a similar level that the average. The mean value of TST
respectively, indicating a satisfying accuracy of the established model
is 2.949, while the mean value of HH 2 is 3.182. Among all the variables,
and the potential of predicting SCL for new subjects by only using five
RVF and SVF have a relatively larger variation of incMSE than other
visual exposure factors (Sky3D_300 m, Obj3D_400 m, RVF_160 m,
variables. The large variation of incMSE of RVF is caused by the
SSVF_100 m, TVF_80 m) (Fig. 8).
8

M. Cai et al. S u s t a in a b l e C i t i e s a n d S o c i e ty96(2023)104695
Fig. 7. the R2 and MSE at different bandwidths scale.
Fig. 8. predicted and true physiological stress response from the final predictive model.
complicated and various conditions of road within the experimental 4. Discussion
routes, which contain different human activities and traffic conditions.
Table 4 shows the statistical results of incMSE’s of each predictor. 4.1. Model interpretation
Sky3D has the largest incMSE, while SSVF has the smallest for both
routes. It indicates that Sky3D_300 m is the most important predictor The MLR interprets 46.6% of the variation of the SCL. 2D isovist
that influences SCL’ in this model, and SSVF_100 m is the least important factors are not influential and are excluded from the resultant model.
one. Followed by Sky3D_300 m, TVF_80 m is the second most important Only predictors from 3D isovist and street view factors remain in the
one with the incMSE of 17.846 and 17.425 for the two routes final model, and it can be noticed that the predictors from 3D isovist and
respectively. street view factors share some overlapping information, therefore, the
3D isovist ground factor is replaced by RVF. Among all predictors, TVF is
9

M. Cai et al. S u s t a in a b l e C i t i e s a n d S o c i e ty96(2023)104695
Fig. 9. Local R-squared value of HH (a) and TST (b) route.
the most important one that influences physiological stress. More trees with incMSE distribution maps, we can propose evidence-based urban
within the visual area can be helpful to relieve physiological stress. design recommendations for better psychological experience and less
Together with TVF, Sky3D, and SSVF also negatively affect stress. Pe- physiological stress at the street level.
destrians feel less stressed when their visual fields are more open to the
sky or natural landscapes, which is in line with the previous studies in a
4.2. Comparison with previous studies
high-density city such as Hong Kong (Xiang et al., 2021). The open sky in
the crowded street is a kind of natural source that can provide ‘soft
fascination’, which draws people’s attention relatively effortlessly and is Combined with previous studies worldwide, the effects of visual
compatible with people’s needs. It is interesting to see that SSVF helps environment on long-term stress (SCL) and short-term emotion (SCR)
are summarized in Table 5 (Hijazi et al., 2016; Kno¨ll, Neuheuser, Cleff &
relieve physiological stress, this could be understood from the perspec-
tive of attention restorative theory (Kaplan & Kaplan, 1989; Stephen Rudolph-Cleff, 2017; X. Li et al., 2016; Xiang et al., 2021). Visual
exposure factors play different roles in promoting emotion and relive
Kaplan, 1983), that the sign symbols on the street are fascinating and
allows ‘effortless attention’. They may have sufficient scope to maintain long-term physiological stress. It can be noticed that TVF, sky propor-
tion, object proportion, and SSVF are the three common factors that
interaction so that pedestrians are not bored, or they may simply be
more in tune with people’s interests. influence both emotion and physiological stress. Sky proportion, object
The GRF model has a R2 of 0.874 and shows a strong ability in the proportion, and TVF play the same role in promoting pedestrians’ psy-
prediction of physiological stress. The distribution map of local R2 shows chological experience, while SSVF affects SCL and SCR in different ways.
RVF has no significant effect on emotion but is positively correlated with
the model has good performance in some parts of the routes, which
SCL. The higher the RVF, the more likely it is to trigger physiological
means the results of GRF have better reference meaning for urban design
stress. The common findings from existing studies confirmed the validity
at these locations. In terms of the importance of each predictor, Sky3D is
the most important predictor that influences SCL’ and SSVF is the least of the results of this study.
important one in this regression case. By combining the R2 distribution Apart from the common findings from previous studies, this study
determines the most influential lags of different visual exposure factors
10

M. Cai et al.                                                                                                                                                                                              S  u s  t a  in  a  b  l e  C  i t i e  s  a  n d   S  o  c i e ty96(2023)104695
|     |     | Fig. 10. incMSE distribution maps of the five selected variables for HH and TST routes.   |     |
| --- | --- | ----------------------------------------------------------------------------------------- | --- |
complement existing policies at both district and site levels.
Table 4
At the district level, the influential lag distance provides the quan-
incMSE statistical results.
titative reference of design scales of each factor. The designers should
HH  TST  pay more attention to the factors with smaller influential lags since
M  SD  M  SD  pedestrians are more sensitive to them. In this study, TVF and SSVF have
the most influential lag distance of fewer than 100 m, so priority should
| Sky3D_300m  | 19.767  | 3.328  19.935  | 3.248  |
| ----------- | ------- | -------------- | ------ |
be given to their design and optimization. Additionally, the lag distance
| Obj3D_400m  | 17.299  | 2.553  17.263  | 2.615  |
| ----------- | ------- | -------------- | ------ |
RVF_160 m  18.005  3.311  17.719  3.550  value can be a practical reference of the basic spatial unit for urban
SSVF_100 m  17.178  2.484  16.997  2.419  design. For example, as the positive effects from exposure to trees and
TVF_80 m  17.846  3.067  17.425  3.080   sky have the most influential lag distances of 80 m and 300 m, beyond
these distances, the positive effects would decrease. Therefore, it is
suggested to adopt the spatial grid of 80 m and 300 m to achieve the
Table 5
most effective visibility of trees and sky, respectively, so as to maximize
Summary of the effects of visual exposure on SCL and SCR.
the relief effect from trees and sky (Fig. 11). Besides, urban designers can
Emotion (SCR)  Physiological stress (SCL)  refer to the results from MLR and GRF models to identify the dominant
visual factors and adopt corresponding design strategies to adjust the
| Sky3D                    | Positive correlation  | Negative correlation   |     |
| ------------------------ | --------------------- | ---------------------- | --- |
| Obj3D                    | Negative correlation  | Positive correlation   |     |
| Visual volume            | Positive correlation  | N.A.                   |     |
| Tree view factor         | Positive correlation  | Negative correlation   |     |
| Sign symbol view factor  | Negative correlation  | Negative correlation   |     |
| Road view factor         | N.A.                  | Positive correlation   |     |
and identifies that pedestrians’ SCL is more sensitive to TVF and SSVF.
Besides, this study more adequately models the impact of the visual
environment using spatial machine learning techniques and considers
the spatial non-stationary, and indicates that the local models in com-
mercial land use are stronger than those of residential land use.
4.3. Implications to urban design at district and site levels
The 6.2.34–6.2.48 sections in Chapter 11 of the Hong Kong Planning
Standard and Guidelines (Department, 2015) fail to provide detailed and
Fig. 11. Basic spatial grid to adjust TVF and SkyVF. The red points are random
quantitative standards to promote mental health. This study can partly  points on the street to ensure psychological comfort from one to another.
11

M. Cai et al. S u s t a in a b l e C i t i e s a n d S o c i e ty96(2023)104695
values of the factors. Moreover, the GRF model provides information
about the spatial difference in importance ranking of visual exposure
factors, which is helpful when solving the problem at any specific
location. For instance, designing or optimizing RVF is more effective in
the corner of Mody and Nathan Road in the HH route.
At the site level, to increase the sky proportion within visual areas for
increase psychological comfort, it is critical to take design methods to
optimize the building layout, podium, and façade, such as creating
concave spaces on the building façade to increase visual volume, when
appropriate, a terraced podium design can be adopted to decrease the
obstacle from podium parts (Fig. 12).
4.4. Limitations and further study
Several limitations exist in this study. First, this study was conducted
for a certain group of people in a controlled environment. The partici-
pants in the experiments were all young, healthy adults. Besides, as our
experiment was conducted on a real urban street, we attempted to
optimize the experimental condition to obtain more ideal results. To be
specific, we selected a specific period under stable and similar weather
conditions and limited the desire of the participants to a certain extent
Fig. 12. An example to increase sky proportion.
during the walk. Therefore, the results of this study may not be appli-
cable to other people groups in different urban environments. Moreover,
and object proportion incite more psychological stress. 4. The GRF
the statistical models were established based only on visual exposure
model demonstrates a strong ability to predict pedestrian physiological
factors. Other potential influences, such as sound, air pollution, and
stress and can explain 87.4% of the spatial variance of pedestrian psy-
nighttime situation have not yet been taken into account.
chological stress using only five visual exposure variables. The R2 be-
There are several future research plans based on the current study.
tween the predicted SCL and the true values of the validation dataset is
First, we plan to adopt more advanced ways to acquire other psycho-
0.869. 5. The proportion of sky, road, and trees has the largest impact on
physiological data, such as the EEG and EOG for a more comprehen-
physiological stress. 6. The effects of the visual environment are
sive understanding of how stress changes over space and time.
spatially non-stationary, and the local models in commercial land use
Furthermore, in order to make up for the incomplete variables in the
are stronger than those of residential land use.
current statistical model, control variables including sound, air pollu-
This study confirms that the physiological stress can be effectively
tion, time, weather, etc., will be considered in future work. We also plan
monitored with wearable sensors in outdoor built environments. It can
to adopt video clips to more comprehensively reflect the urban envi-
provide urban planners, architects, and decision-makers with quantified
ronment as they can provide dynamic urban elements, such as crowd
and practicable reference to jointly foster good health and well-being,
and traffic flow, whereas street view images can only reflect static
eventually contributing to a psychologically friendly future and sus-
conditions.
tainable urban environment for humans.
5. Conclusion
CRediT authorship contributor statement
To contribute to building a more psychologically friendly urban
M.C and L.X. contributed equally to this work and should be
environment, this study focuses on analyzing the impact of visual
considered co-first authors.
exposure on pedestrian psychological stress in a high-density context.
Considering the long-term effects of the visual environment on physio-
logical stress, we used the lagged visual exposure factors to build the Declaration of Competing Interest
regression models to demonstrate the relationship between SCL and the
previous visual environments. There are several innovations in this The authors declare that they have no known competing financial
study. First, it attempts to quantitatively understand the SCL responses interests or personal relationships that could have appeared to influence
to various visual elements in an outdoor urban environment. Second, the work reported in this paper.
this study determines the most influential lags of different visual expo-
sure factors to better understand the effects of the visual environment, Data availability
since SCL changes slowly over time and space according to different
environmental stimuli. Besides, this study more adequately models the The data that has been used is confidential.
impact of the visual environment using spatial machine learning tech-
niques and considers the spatial non-stationary.
The following conclusions can be drawn from the present study: 1. Acknowledgments
Our results are in line with the stress recovery theory that the trees in
visual areas are helpful to relieve physiological stress. 2. The influential The study is supported by a PGS studentship from The Chinese
lags have wide ranges (from 40 m to 400 m), which is in line with the University of Hong Kong. It is also supported by the Fundamental
definition of SCL, where the visual impacts are lagged and the distances Research Funds for the Central Universities (No. 2042023kf0004). The
vary with different elements. The tree view factor has the smallest lag research gains ethics approval from The Chinese University of Hong
(80 m) and the objective proportion has the largest one (400 m) among Kong (Certificate No. S24601960).
all predictors. 3. The MLR models have an R2 value of 0.466 and suggest
that in a high-density environment, exposure to a larger tree view factor, Supplementary materials
sky proportion, and sign symbol view factor is associated with less
psychological stress. Conversely, areas with the view of road view factor Supplementary material associated with this article can be found, in
12

M. Cai et al. S u s t a in a b l e C i t i e s a n d S o c i e ty96(2023)104695
the online version, at doi:10.1016/j.scs.2023.104695. Kalogirou, S. (2016). Destination Choice of Athenians: An Application of Geographically
Weighted Versions of Standard and Zero Inflated Poisson Spatial Interaction Models.
Geographical Analysis, 48(2), 191–230. https://doi.org/10.1111/gean.12092
Reference Kaplan, R., & Kaplan, S. (1989). The experience of nature: A psychological perspective. CUP
Archive.
Alvarsson, J. J., Wiens, S., & Nilsson, M. E. (2010a). Stress recovery during exposure to Kim, J., Yadav, M., Chaspari, T., & Ahn, C. R. (2020). Saliency detection analysis of
nature sound and environmental noise. International journal of environmental research collective physiological responses of pedestrians to evaluate neighborhood built
and public health, 7(3), 1036–1046. https://doi.org/10.3390/ijerph7031036 environments. Advanced Engineering Informatics, 43, Article 101035. https://doi.org/
Alvarsson, J. J., Wiens, S., & Nilsson, M. E. (2010b). Stress recovery during exposure to 10.1016/j.aei.2020.101035
nature sound and environmental noise. International journal of environmental research Kno¨ll, M., Neuheuser, K., Cleff, T., & Rudolph-Cleff, A. (2017). A tool to predict perceived
and public health, 7(3), 1036–1046. urban stress in open public spaces. Environment and Planning B: Urban Analytics and
Appleton, J. (1975). The experience of landscape. London: John Wiley and Sons. City Science. , Article 026581351668697. https://doi.org/10.1177/
Brady, T. F., Konkle, T., Alvarez, G. A., & Oliva, A. (2008). Visual long-term memory has 0265813516686971
a massive storage capacity for object details. Proceedings of the National Academy of Davis, Larry S., & L Benedikt, M (1979). Computational Models of Space Isovists and
Sciences, 105(38), 14325. https://doi.org/10.1073/pnas.0803390105 Isovist Fields. Computer Graphic and Image Procssing, 11.
Brakus, J. J., Schmitt, B. H., & Zarantonello, L. (2009). Brand experience: What is it? Lederbogen, F., Kirsch, P., Haddad, L., Streit, F., Tost, H., Schuch, P., ..., et al. (2011).
How is it measured? Does it affect loyalty? Journal of marketing, 73(3), 52–68. %@ City living and urban upbringing affect neural social stress processing in humans.
0022-2429. Nature, 474(7352), 498–501. https://doi.org/10.1038/nature10190
Breiman, L. (2001). Random Forests. Machine Learning, 45(1), 5–32. https://doi.org/ Li, X., Hijazi, I., Koenig, R., Lv, Z., Zhong, C., & Schmitt, G. (2016). Assessing Essential
10.1023/A:1010933404324 Qualities of Urban Space with Emotional and Visual Data Based on GIS Technique.
Brostow, G. J., Fauqueur, J., & Cipolla, R. (2009). Semantic object classes in video: A ISPRS International Journal of Geo-Information, 5(11), 218. https://doi.org/10.3390/
high-definition ground truth database. Pattern Recognition Letters, 30(2), 88–97. %@ ijgi5110218
0167-8655. Li, Y., Li, Z.-L., Wu, H., Zhou, C., Liu, X., Leng, P., ..., et al. (2023). Biophysical impacts of
Brunsdon, C., Fotheringham, S., & Charlton, M. (1998). Geographically weighted earth greening can substantially mitigate regional land surface temperature
regression. Journal of the Royal Statistical Society: Series D (The Statistician), 47(3), warming. NATURE COMMUNICATIONS, 14(1), 121. https://doi.org/10.1038/
431–443. s41467-023-35799-4
Chatterjee, S. A., Daly, J. J., Porges, E. C., Fox, E. J., Rose, D. K., McGuirk, T. E., ..., et al. Lin, F.-C., She, S.-J., Ngo, H.-H., Dow, C.-R., & Hsu, F.-R. (2021). A wearable embedded
(2018). Mobility Function and Recovery After Stroke: Preliminary Insights From system for assisting cognition of visually impaired people by street scene description.
Sympathetic Nervous System Activity. Journal of neurologic physical therapy : JNPT, Journal of Computers (Taiwan), 32(1), 102–119.
42(4), 224–232. https://doi.org/10.1097/NPT.0000000000000238 Lin, W., Chen, Q., Jiang, M., Tao, J., Liu, Z., Zhang, X., ..., et al. (2020). Sitting or
Chen, L.-C., Zhu, Y., Papandreou, G., Schroff, F., & Adam, H. (2018). Encoder-decoder Walking? Analyzing the Neural Emotional Indicators of Urban Green Space Behavior
with atrous separable convolution for semantic image segmentation. Paper presented at with Mobile EEG. Journal of Urban Health, 97(2), 191–203. https://doi.org/10.1007/
the REAL CORP 2017. s11524-019-00407-8
Chung, L. C. H., Xie, J., & Ren, C. (2021). Improved machine-learning mapping of local Lindal, P. J., & Hartig, T. (2013). Architectural variation, building height, and the
climate zones in metropolitan areas using composite Earth observation data in restorative quality of urban residential streetscapes. Journal of Environmental
Google Earth Engine. Building and Environment, 199, Article 107879. Psychology, 33, 26–36. https://doi.org/10.1016/j.jenvp.2012.09.003
Dawes, M. J., & Ostwald, M. J. (2014a). Prospect-Refuge theory and the textile-block Mangone, G., Capaldi, C. A., van Allen, Z. M., & Luscuere, P. G. (2017). Bringing nature
houses of Frank Lloyd Wright: An analysis of spatio-visual characteristics using to work: Preferences and perceptions of constructed indoor and natural outdoor
isovists. Building and Environment, 80, 228–240. https://doi.org/10.1016/j. workspaces. Urban Forestry & Urban Greening, 23, 1–12. https://doi.org/10.1016/j.
buildenv.2014.05.026 ufug.2017.02.009
Dawes, M. J., & Ostwald, M. J. (2014b). Testing the ‘Wright Space’: Using isovists to Marianne, H.M., & Kno¨ll, M. (2017). The relationship between visual fields and perceived
analyse prospect-refuge characteristics in Usonian architecture. The Journal of stress in a public. Paper presented at the 11th International Space Syntax Symposium,
Architecture, 19(5), 645–666. https://doi.org/10.1080/13602365.2014.965722 Lisbon.
Dawson, M., SCHELL, Anne M., & FILION, D. L (2001). The Electrodermal System. In Mavros, P., Austwick, M. Z., & Smith, A. H. (2016). Geo-EEG: Towards the Use of EEG in
J. T. Cacioppo, L. G. Tassinary, & G. B. Bernston (Eds.), Handbook of psychophysiology the Study of Urban Behaviour. Applied Spatial Analysis and Policy, 9(2), 191–212.
(2nd Ed). Cambridge: Cambridge Press. https://doi.org/10.1007/s12061-015-9181-z
De Silva, C. S., Warusavitharana, E. J., & Ratnayake, R. (2017). An examination of the Mavros, P., J Wa¨lti, M., Nazemi, M., Ong, C. H., & Ho¨lscher, C (2022). A mobile EEG
temporal effects of environmental cues on pedestrians’ feelings of safety. Computers, study on the psychophysiological effects of walking and crowding in indoor and
Environment and Urban Systems, 64, 266–274. https://doi.org/10.1016/j. outdoor urban environments. Nature, 12(1), 18476. https://doi.org/10.1038/
compenvurbsys.2017.03.006 s41598-022-20649-y
Department, P. (2015). Hong Kong planning standards and guidelines. Urban Design Mazumder, R., Spiers, H. J., & Ellard, C. G. (2022). Exposure to high-rise buildings
Guidelines. negatively influences affect: Evidence from real world and 360-degree video. Cities &
Dosen, A. S., & Ostwald, M. J. (2016). Evidence for prospect-refuge theory: A meta- Health, 6(6), 1081–1093. https://doi.org/10.1080/23748834.2020.1839302
analysis of the findings of environmental preference research. City, territory and Millar, G. C., Mitas, O., Boode, W., Hoeke, L., de Kruijf, J., Petrasova, A., et al. (2021).
architecture, 3(1), 1–14. Space-time analytics of human physiology for urban planning. Computers,
Fisher-Gewirtzman, D., Burt, M., & Tzamir, Y. (2003). A 3-D Visual Method for Environment and Urban Systems, 85. https://doi.org/10.1016/j.
Comparative Evaluation of Dense Built-up Environments. Environment and Planning compenvurbsys.2020.101554
B: Planning and Design, 30(4), 575–587. https://doi.org/10.1068/b2941 Mir, M., Nasirzadeh, F., Bereznicki, H., Enticott, P., Lee, S., & Mills, A. (2023).
Fisher-Gewirtzman, D., & Wagner, I. A. (2003). Spatial Openness as a Practical Metric for Construction noise effects on human health: Evidence from physiological measures.
Evaluating Built-up Environments. Environment and Planning B: Planning and Design, Sustainable Cities and Society, 91, Article 104470. https://doi.org/10.1016/j.
30(1), 37–49. https://doi.org/10.1068/b12861 scs.2023.104470
Fotheringham, A. S., Brunsdon, C., & Charlton, M. (2003). Geographically weighted Neale, C., Aspinall, P., Roe, J., Tilley, S., Mavros, P., Cinderby, S., ..., et al. (2020). The
regression: The analysis of spatially varying relationships. John Wiley & Sons. impact of walking in different urban environments on brain activity in older people.
Gatti, E., Calzolari, E., Maggioni, E., & Obrist, M. (2018). Emotional ratings and skin Cities & Health, 4(1), 94–106. https://doi.org/10.1080/23748834.2019.1619893
conductance response to visual, auditory and haptic stimuli. Scientific data, 5, Article Nold, C. (2009). EmotionalCartography: Technologies of the self.
180120. https://doi.org/10.1038/sdata.2018.120 Ren, C., Cai, M., Li, X., Shi, Y., & See, L. (2020). Developing a rapid method for 3-
Georganos, S., Grippa, T., Vanhuysse, S., Lennert, M., Shimoni, M., Kalogirou, S., et al. dimensional urban morphology extraction using open-source data. Sustainable Cities
(2018). Less is more: Optimizing classification performance through feature and Society, 53, Article 101962. %@ 102210-106707.
selection in a very-high-resolution remote sensing object-based urban application. Ulrich, Roger S., Simons, Robert F., Losito, Barbara D., Fiorito, Evelyn, Mile, Mark A., &
GIScience & remote sensing, 55(2), 221–242. Zelson, M. (1991). Stress recovery during exposure to natural and urban
Griego, D., Buff, V., Hayoz, E., Moise, I., & Pournaras, E. (2017). Sensing and Mining environments. Journal of Environmental Psychology, 11.
Urban Qualities in Smart Cities. Paper presented at the IEEE 31st. Rogerson, M., Gladwell, V. F., Gallagher, D. J., & Barton, J. L. (2016). Influences of Green
Grover, S., Sahoo, S., Mehra, A., Avasthi, A., Tripathi, A., Subramanyan, A., ..., et al. Outdoors versus Indoors Environmental Settings on Psychological and Social
(2020). Psychological impact of COVID-19 lockdown: An online survey from India. Outcomes of Controlled Exercise. International journal of environmental research and
Indian journal of psychiatry, 62(4), 354–362. public health, 13(4). https://doi.org/10.3390/ijerph13040363
Hijazi, I. H., Koenig, R., Schneider, S., Li, X., Bielik, M., Schmit, G. N. J., et al. (2016). Saladino, V., Algeri, D., & Auriemma, V. (2020). The psychological and social impact of
Geostatistical Analysis for the Study of Relationships between the Emotional Covid-19: New perspectives of well-being. Frontiers in psychology, 2550.
Responses of Urban Walkers to Urban Spaces. International Journal of E-Planning Serafini, G., Parmigiani, B., Amerio, A., Aguglia, A., Sher, L., & Amore, M. (2020). The
Research, 5(1), 1–19. https://doi.org/10.4018/ijepr.2016010101 psychological impact of COVID-19 on the mental health in the general population.
Huang, Q., Yang, M., Jane, H.-a., Li, S., & Bauer, N. (2020). Trees, grass, or concrete? The QJM: An International Journal of Medicine, 113(8), 531–537. https://doi.org/
effects of different types of environments on stress reduction. Landscape and Urban 10.1093/qjmed/hcaa201
Planning, 193. https://doi.org/10.1016/j.landurbplan.2019.103654 Shi, Y., Ren, C., Lau, K. K.-L., & Ng, E. (2019). Investigating the influence of urban land
Javadi, A. H., Emo, B., Howard, L. R., Zisch, F. E., Yu, Y., Knight, R., ..., et al. (2017). use and landscape pattern on PM2.5 spatial variation using mobile monitoring and
Hippocampal and prefrontal processing of network topology to simulate the future. WUDAPT. Landscape and Urban Planning, 189, 15–26. https://doi.org/10.1016/j.
Nature Commun, 8, 14652. https://doi.org/10.1038/ncomms14652 landurbplan.2019.04.004
Kalat, J. W. (2015). Biological psychology. Cengage Learning.
13

M. Cai et al. S u s t a in a b l e C i t i e s a n d S o c i e ty96(2023)104695
Kaplan, Stephen (1983). A model of person-environment compatibility. Environment and Health & place, 75, Article 102762. https://doi.org/10.1016/j.
Behavior, 15(3), 22. healthplace.2022.102762
The Mental Health Association of Hong Kong. (2016). Hong Kong Mental Morbidity Survey World Health Organization. (2022). World mental health report: Transforming mental
Retrieved from. health for all. Retrieved from.
The World Bank. (2018). Population density (people per sq. km of land area) - Hong Xiang, L., Cai, M., Ren, C., & Ng, E. (2021). Modeling pedestrian emotion in high-density
Kong SAR, China. Retrieved from https://data.worldbank.org/indicator/EN.POP.DN cities using visual exposure and machine learning: Tracking real-time physiology
ST?locations=HK. and psychology in Hong Kong. Building and Environment, 205, Article 108273.
The Mental Health Association of Hong Kong. (2020). Territory-wide Mental Health Index https://doi.org/10.1016/j.buildenv.2021.108273
Index Survey 2020. Yin, J., Zhu, S., MacNaughton, P., Allen, J. G., & Spengler, J. D. (2018). Physiological and
Turner, A., Doxa, M., O’Sullivan, D., & Penn, A. (2001). From Isovists to Visibility cognitive performance of exposure to biophilic indoor environment. Building and
Graphs: A Methodology for the Analysis of Architectural Space. Environment and Environment, 132, 255–262. https://doi.org/10.1016/j.buildenv.2018.01.006
Planning B: Planning and Design, 28(1), 103–121. https://doi.org/10.1068/b2684 Yu, R., Gu, N., & Ostwald, M. (2016). The mathematics of spatial transparency and
Weich, S. (2002). Mental health and the built environment: Cross-sectional survey of mystery: Using syntactical data to visualise and analyse the properties of the Yuyuan
individual and contextual risk factors for depression. The British Journal of Psychiatry, Garden. Visualization in Engineering, 4(1). https://doi.org/10.1186/s40327-016-
180(5), 428–433. https://doi.org/10.1192/bjp.180.5.428 0033-y
Winz, M., So¨derstro¨m, O., Rizzotti-Kaddouri, A., Visinand, S., Ourednik, A., Küster, J., Zheng Chen, Sebastian Schulz, Xiaofan He, & Yifan Chen. (2016). A Pilot Experiment on
et al. (2022). Stress and emotional arousal in urban environments: A biosocial study Affective Multiple Biosensory Mapping for Possible Application to Visual Resource
with persons having experienced a first-episode of psychosis and persons at risk. Analysis and Smart Urban Landscape Design. Paper presented at the REAL CORP
2016.
14
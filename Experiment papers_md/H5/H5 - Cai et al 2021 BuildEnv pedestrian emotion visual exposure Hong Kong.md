BuildingandEnvironment205(2021)108273
Contents lists available at ScienceDirect
Building and Environment
journal homepage: www.elsevier.com/locate/buildenv
Modeling pedestrian emotion in high-density cities using visual exposure
and machine learning: Tracking real-time physiology and psychology in
Hong Kong
Luyao Xianga, Meng Caia,*, Chao Renb,c, Edward Nga,c,d
aSchool of Architecture, The Chinese University of Hong Kong, Hong Kong
bFaculty of Architecture, The University of Hong Kong, Hong Kong
cInstitute of Future Cities, The Chinese University of Hong Kong, Hong Kong
dInstitute of Environment, Energy and Sustainability, The Chinese University of Hong Kong, Hong Kong
A R T I C L E I N F O A B S T R A C T
Keywords: People’s mental health has been deteriorating as a result of urban living, which also causes disability, pain, or
Ambulatory pedestrian emotion track even death among metropolitan residents. Understanding the interaction between human emotions and the built
Environment perception environment is therefore essential for developing strategies towards a psychologically friendly and socially
Street view
resilient environment. This study aims to model the pedestrian emotion in high-density urban areas of Hong
Isovist
Kong using machine learning based on environmental visual exposure, which is one of the most significant
Random forest
factors affecting emotions. Using ambulatory sensing and portable technologies, two-dimensional emotional data
Deep learning
from 99 pedestrians are retrieved from coupled data with respect to wearable arousal, subjective report pref-
erence, and the location at a high spatiotemporal resolution (4 m). The visual environment is quantified by
isovist and street view factors. This study examines the impact of visual exposures using two multiple linear
regression (MLR) models and establishes a predictive model using random forest (RF) (N = 548). The MLR
models have R2 values around 0.5 and suggest that in the high-density environment, exposure to more trees,
visual volume, and drift magnitude can cause positive emotions. Conversely, areas with a view of sign symbols,
object proportion, min-radial, and occlusivity can cause negative emotions. The resultant predictive model with
nine visual exposure variables can explain 79% of the spatial variance of pedestrian emotion. Furthermore, the
methodological framework provides opportunities for spatial, data-driven approaches to portable sensing and
urban planning research. The findings are also applicable to optimize the infrastructure design of outdoor en-
vironments for more psychologically friendly experiences.
residents.
1. Introduction
1.1. Background of emotion
Good mental health contributes to social and psychological well-
being. Determinants of mental health and mental disorders include Emotion is an essential element of mental health and can be
not only individual attributes but also social, cultural, economic, polit- conceptualized by categorical [4] and dimensional [5] approaches. The
ical, and environmental factors, such as national policies, social pro- categorical approach assumes that emotions are the basic and discrete
tection, living space, working conditions, and community social support components hard-wired in our brain and can be measured by self-report
[1]. A group of neuroscientists [2,3] have identified two typical urban methods [6]. However, Bastiaansen, et al. [7] asserted that emotion can
environments that affect mental health: 1. an environment that features develop continuously over time, which may not be demonstrated by the
high complexity, high heterogeneity, and a high rate of change; 2. the categorical approach. In contrast, the dimensional models suggest that a
shortened social distance and invasion of personal space. They thereby common and interconnected neurophysiological system is responsible
call for interdisciplinary cooperation to enhance the built environments for all affective states [8]. It means that in everyday interactions, people
and improve the deteriorating mental health conditions of metropolitan tend to show non-basic, subtle, and quite complex affective states. This
* Corresponding author.
E-mail address: caimeng@link.cuhk.edu.hk (M. Cai).
https://doi.org/10.1016/j.buildenv.2021.108273
Received 14 May 2021; Received in revised form 16 August 2021; Accepted 17 August 2021
Availableonline27August2021
0360-1323/©2021ElsevierLtd.Allrightsreserved.

L. Xiang et al. B u i l d i n g a n d E n v ir o n m e n t 205(2021)108273
Nomenclature CamVid Cambridge-driving Labeled Video Database
FOV Fields of Vision
PAD Pleasure – Arousal – Dominance SkyVF Sky View Factor
VAD Valence-Arousal-Dominance BVF Building View Factor
SC Skin Conductance RVF Road View Factor
EEG electroencephalography SSVF Sign symbol View Factor
GEMA Geographic Ecological Momentary Assessment CVF Car View Factor
MLR Multiple Linear Regression PVF People View Factor
RF Random Forest TVF Tree View Factor
TST Tsim Sha Tsui OOB Out-of-Bag
HH Hong Hum MSE Mean Squared Error
SD Standard Deviation IoU Intersection over Union
GPS Global Positioning System RMSE Root Mean Square Error
SCR Skin Conductance Response MAE Mean absolute error
CDA Continuous Deconvolution Analysis
dimensional perspective is the foundation for the measurement of verbal laboratories and outdoor environments.
self-report: Pleasure – Arousal – Dominance (PAD) (or Parametric studies conducted in the laboratories have achieved the
valence-arousal-dominance, VAD) scale. The valence dimension ranges best results by combining the methods of subjective questionnaires and
from negative to positive, and the arousal dimension ranges from calm showing the scenes with different techniques. Stamps [18] focused on
to excitement. The dimensional model can locate discrete emotions visual responses to openness, and in the following studies [19,20], he
without a specific category definition, so it has been widely used in considered four visual properties of the physical environment and
emotion recognition experiments [9]. established the correlation between isovists parameters and psycho-
The valence data can be obtained through subjective questionnaires logical feelings based on the prospect refuge theory [21]. Lindal and
or more advanced sensors, i.e., electroencephalography (EEG). The Hartig [22,23] performed a parametric study to examine the effects of
arousal dimension of emotion is often measured by skin conductance streetscapes entropy, building height, and arrangement of trees on the
(SC), an unbiased and continuous measure of sympathetic activity via evaluation of restoration possibilities. Other characteristics, such as
the electric impulses on the skin surface and sweat glands, which are orientation [24,25], and shape complexity [26], had also been examined
innervated only by the sympathetic nervous system and is related to the in previous studies. Moreover, some studies adopted virtual reality
increase in the arousal of a subject. The construction of valence and techniques to simulate the real environment for better immersive feel-
arousal dimensions can provide a more sufficient explanation for the ings and easier control of the variables [27–29].
structure of emotions [10,11]. The development of mobile sensors, such as ambulatory sensing and
portable technologies, has enabled researchers to measure emotions
1.2. Visual exposure outdoors under moving conditions [29,30]. Field surveys, such as the
Geographic Ecological Momentary Assessment (GEMA) [31–33], can
The human living environment is an important source of stimuli that link physiological measures of arousal with geographical location for a
can evoke different emotional responses [12]. Cognitive science more realistic and comprehensive analysis of the interaction between
research shows that human beings acquire external information mostly humans and the environment [34–36]. The interest in emotion mapping
through vision [14], which is the main driver behind human perception has since grown within urban spatial analytics [29,30,35,37–43]. Most
[13] and consequent experience [14]. As human cognitive responses to of these studies were based on urban walking experiences, and the
urban space and form are closely related to their behaviors, visual measured data were usually interpreted in terms of proximity to urban
exposure to urban space, therefore, is one of the most important factors features. In addition, the cycling experience has been examined in some
that affect their perceived quality and wellbeing [13]. studies with similar methods [30,44].
The concept of isovist has been widely used to describe and quantify Further to mapping the emotion data, several studies [29,30,39–41]
visual exposure. Generally, it can be defined as “the set of all points explored the statistical relationship between visual exposure and emo-
visible from a given vantage point in space” [15]. However, isovist re- tions. However, most of the statistical analysis of visual environment
quires detailed 3D models of trees, buildings, and pedestrians, which are and emotion only measured the arousal dimension of emotions with the
often unavailable or difficult to acquire. The recent development of ambulatory assessment SC technique but did not include the measure-
street sensing techniques has made it possible to describe the visual ment of valence, posing a limitation on their further implication because
environment by open-source street view images that are easily acces- of the lack of positive/negative emotion information. Moreover, visual
sible. The necessary visual exposure information can be extracted from exposure has been considered an important source of emotion. While
these images using certain photographic or deep learning techniques both the concept of isovist [29,39,40] and street views [30] can quantify
[16,17]. Thus, both isovist and street view images have been frequently visual exposure, the former emphasizes the geometric characteristics of
adopted to quantify visual exposure. the visual area while the latter contains information on the visible
content. However, none of the previous studies have simultaneously
1.3. Literature review applied the two concepts, leading to an incomplete understanding of the
visual contents and a low R2 value of the resultant model. In addition,
Understanding the effects of the visual environment on human most of them adopted multiple linear regression (MLR) to model emo-
emotions is essential for developing strategies towards psychologically tions from visual exposure but the present study proposes the adoption
friendly and socially resilient environments. Besides, prior knowledge of of a more complicated model because their relationship may not be
pedestrian emotion can facilitate informed control decisions of urban linear. Therefore, a machine learning algorithm, i.e., the random forest
design. Accordingly, several studies have been carried out to analyze (RF), is used to model emotion. Finally, most of the previous studies
and predict the emotions of people from visual exposure in both were carried out in medium- and low-density cities and data from
2

L. Xiang et al. B u i l d i n g a n d E n v ir o n m e n t 205(2021)108273
high-density cities have been rare.
1.4. Objectives
Based on the research gaps, this study aims to understand the effects
of visual environment on emotion in high-density environments more
comprehensively and accurately, by quantifying two-dimensional
emotion, using multi-level visual exposures from isovist and street
view images, and modeling with machine learning. This study can
inform practitioners across multiple disciplines, including urban plan-
ners, architects, psychologists, decision-makers, with cutting-edge and
accurate urban planning schemes for a psychologically friendly
environment.
2. Materials and methods
This study contains four steps. First, subtle and controlled experi-
ments are conducted in high-density urban areas to collect two-
dimensional emotion data in real-time with the ambulatory technique. Fig. 2. Density situation of Kowloon.
Second, visual exposure variables from isovist and street view images
are collected and calculated to characterize the visual environment that been selected for this study. The first district is Tsim Sha Tsui (TST),
the participants see along the pre-defined routes. MLR is then used to which is famous for its commercial atmosphere and attracts a huge
examine how environmental visual exposure affects the emotions of volume of visitors every day because of the abundance of restaurants
pedestrians. Finally, a data-driven prediction model is established for and fashion retailers. Trees can hardly be found on the streets and the
pedestrian emotion estimation using random forest. The framework of rich business atmosphere of TST makes it one of the most crowded
this study is shown in Fig. 1. places in Hong Kong. The other district is Hung Hom (HH), a residential
area with a local living atmosphere. The first part of the HH route
2.1. Study area comprises mainly natural landscapes with just a few buildings. The at-
mosphere of this route is quiet and sparsely populated because there are
Hong Kong is located on the southeastern coast of China and has a no commercial activities. The second part of the HH route is of typical
population density of more than 7000 people per square kilometer, urban style with high-density and high-rise residential buildings, food
ranking the third highest in the world [45]. Only 24% of the total land markets, and communal facilities. The TST route is 1.1 km and the HH
area of Hong Kong has been developed. The high-density planning route is 1.3 km (Fig. 3).
makes the living environment cramped and impedes urban ventilation,
generating heat islands and air pollution. In addition, the deteriorating 2.2. Experimental details
living environment can affect mental health. Nearly 60% of the popu-
lation has poor mental health according to the results of the 2.2.1. Participant recruitment
Territory-wide Mental Health Index Survey 2020 [46]. Participants were recruited via an online announcement detailing a
Located in the central part of Hong Kong, the Kowloon Peninsula has reward of 60 HKD for each participant. Participants should be between
the highest building density in the entire city (Fig. 2). Two representa- 18 and 35 years old, should have resided in Hong Kong for no longer
tive districts with the highest building volume density of Kowloon have than five years, and have not been involved in severe accidents in the
Fig. 1. The framework of this study.
3

L. Xiang et al. B u i l d i n g a n d E n v ir o n m e n t 205(2021)108273
Fig. 3. (a&d) are route maps in TST and HH, respectively. The big star is the gathering point where the pre-walk test takes place. The data starts to be recorded at the
black point. There is also a small star on the map, indicating the location for the mid-walk test; (b&c) are the representative scenes for the TST route - first and second
part, respectively; (e&f) are the representative scenes for the HH route - first and second part, respectively.
past six months. A total of 103 participants enrolled, including 51 males help of the instructor. The pretreatment started with 100 s of relaxation,
and 52 females. The average age of the participants is 26 (Standard during which the SC baseline of the participant in the standing posture
Deviation (SD) =5). The participants were randomly allocated to the was recorded [47]. The first 10 min were spent standing quietly near the
different experimental routes. Finally, 51 and 48 people took part in the gathering points. The participants viewed the corresponding landscapes
TST route and HH route, respectively. 4 people terminated the experi- while the SC was recorded at the frequency of 10 Hz. The participants
ment midway because of personal reasons. were then accompanied by an experimental instructor on a 40-min walk.
At the outset, the instructor explained that conversation should be
2.2.2. Experiment time minimized to ensure consistency across subjects. To avoid distraction
The weather in Hong Kong can be extremely uncomfortable during from the nearby participants, the participants were told to keep a 5-m
the mid-summer months, i.e., from May to August, when the weather is distance from each other. The instructor led the participants by
hot and humid, and thus, no experiments were conducted during these walking 10 m ahead of them at a slow pace. SC was recorded continu-
periods. The current study lasted from December 2018 to May 2019. The ously during the entire course of the walk. Participants used their mobile
weather for all experimental days was relatively comfortable, and the phones to express their preference for the visual scenes along the street
mean of the minimum air temperature was 17.67 ◦C, SD =3.99 ◦C, the whenever they were emotional because of the streetscapes. Thereafter,
maximum was 24.08 ◦C, SD =4.28 ◦C (data source: HKO, https://www. they turned back to the starting points as the routes were designed as a
hko.gov.hk/en/index.html). In addition, experiments were only con- circle and finished the post-test. The experimental procedure is sum-
ducted on weekdays taking into account the differences in the street marized in Fig. 4.
crowdedness and human activities on weekdays and weekends. Rush
hours were also avoided to minimize the effects of crowding and
2.3. Mobile data collection
congestion, such as by car horns. Therefore, the periods of 10:00–12:00
a.m. and 2:00–4:00 p.m. were chosen for conducting the experiments.
2.3.1. Locational data
The experiment would be canceled under rainy weather.
The geographic coordinates of the participants and the correspond-
ing timestamps throughout their walk on the predefined route were
2.2.3. Experiment design
collected by a dedicated Global Positioning System (GPS) device
On each experimental day, a maximum of three participants took
(GARMIN GPSmap 62s) attached to their shoulders with 1 Hz frequency.
part in the experiment at the same time. No participants walked along
The locational data were then combined with the real-time SC data,
the same route twice, and even for those who took both routes, the
street views, and urban form data.
combination of the participants was different each time. The partici-
pants were sent an SMS reminder the night before each experimental
2.3.2. Arousal
day. All participants arrived at the gathering points by themselves. Upon Shimmer 3 GSR + device (Shimmer, www.shimmersensing.com/)
arrival, the participants were given an introduction of the experiment
was used to measure SC (Appendix, Fig. A1). The main parts of the
after which they were asked to sign a written consent for their voluntary
devices were worn on the wrist of the participants, attached by
participation. The participants wore the devices to measure SC with the
comfortable bands, comprising two 8-mm snap style finger type
4

BuildingandEnvironment205(2021)108273
Ag–AgCl dry electrodes (GSR electrodes, Shimmer Sensing), with a
constant voltage (0.5 V) attached to the intermediate phalanges of their
left middle and index fingers, and GSR sampling at 10 Hz. The device has
been clinically tested and has shown high validity and accuracy [48].
2.3.3. Subjective preference
The participants installed a mobile application provided in advance.
At the very beginning of the experiment, the participants were given the
following instructions: ‘if you like the viewing scenery in front of you
and you feel pleased, please push the green button on your mobile phone
screen/if you dislike the viewing scenery in front of you and you feel
displeased, please push the yellow button on your mobile phone screen/
if you have no feeling of both above choices, please push the grey button
on your mobile phone screen. Please make a choice enthusiastically
whenever you have any above feelings along the route’. Accordingly,
both the preference and information on the level of pleasure of the
participants were obtained, which can be used to describe valence.
The green button (like/pleased) was marked as 1, the grey button
(neutral) as 0, and the yellow button (dislike/displeased) as (cid:0) 1. The
participants were required to maintain a high-frequency reporting
rhythm.
2.4. Emotional data processing
2.4.1. Extract skin conductance response (SCR) with ledalab, continuous
deconvolution analysis (CDA) method
Each record was analyzed using the MATLAB 2020b, Ledalab V3.4.8
toolbox (www.ledalab.de). Before importing the raw SC data into
Ledalab, a moving window of 10 s was applied on the unprocessed SC
data to identify potential motion artifacts defined as three standard
deviations or more. To visually inspect whether the deviations failed to
confirm a standard, physiologically plausible shape for an SCR (a decline
that lasted at least 3 or more seconds after a peak) was replaced with
linear interpolation. Using Ledalab, the data was first downsampled to 1
Hz and high and low filters were used to reduce the results caused by
motion artifacts. Ledalab implements the method of CDA to separate the
phasic and tonic components of the raw data. The default setting of CDA
was used to export the event-related activation with an SCR window of
1–4 s (start–end) with 4-s intervals. The minimum amplitude criterion of
SCRs was set as 0.04 mμS, larger than the default setting (0.01 mμS), to
achieve a balance between the sensitive detection of SCRs and to
minimize the effects of movement artifacts [49].
2.4.2. Spatial, temporal, and emotional aggregative data
2.4.2.1. Standardize SCR data. We obtained SCR data every 4 s. The raw
SCR data need to be transformed into a standardized and corrected form
that can facilitate individual-difference analysis. This study adopted the
most common method that assumes the minimum value to be zero and
the maximum value to be the result of some stimulus. Each SCR was
standardized for individual differences by dividing it by the participant’s
maximum SCR [49].
2.4.2.2. Fill in the missing subjective preference data. Since the partici-
pants reported preference at random incidences along the routes, the
dataset built at 4 m resolution may contain some points with no data
because no participants made any choice at that place. 0 was assigned as
the preference value assuming they felt neutral about those points when
they did not make a choice.
2.4.2.3. Combine the SCRs and subjective preference data into emotional
data. In order to distinguish the different states of valence and arousal,
we quantified emotion based on the vector model [50] by multiplying
the SCR and subjective preference for each participant at each point
(Equation (1)) to obtain two-dimensional emotional responses,
5
.erudecorp
tnemirepxE
.4 .giF
L. Xiang et al.

L. Xiang et al. B u i l d i n g a n d E n v ir o n m e n t 205(2021)108273
assuming that there is always an underlying arousal dimension, and that weights initialized from a pre-trained Resnet-18 network (https://www.
valence determines the direction in which a particular emotion lies. mathworks.com/supportfiles/vision/data/deeplabv3plusResnet18Cam
Previous studies [29,51] also used the method of multiplying these two Vid.mat). The pre-trained Deeplab v3+network was applied to the 548
dimensions to obtain the emotion value for further analysis. In this street view photos to classify them into 32 classes of the CamVid.
model, high arousal states are differentiated by their valence, whereas Thereafter, the photos in 32 classes were reclassified into seven classes
low arousal states are more neutral and are represented near the meeting that include the most common and basic elements in urban areas,
point of the vectors. namely, sky, building, road, sign symbol, car, people, and tree.
The view factor of each class was determined as the percentage of the
Emotionij =SCRij * Preferenceij (1)
class pixels and the total pixels of the picture (1260*840). Finally, 15 out
where i refers to the participants, j refers to the location points. of 548 photos were used to validate the segmentation results. We
manually labeled 15 photos as independent ground-truth with three
classes, i.e., tree, sky, and urban (an aggregation of the other five clas-
2.5. Semantic segmentation of street view images by deep learning
ses), and cross-compared the labeled photos with the corresponding
segmentation images. The semantic segmentation and accuracy assess-
To obtain the street view photos at 4–m intervals, a Canon 6D-mark2,
ment were performed on the platform of MATLAB 2020b.
EF 24–70 mm f/2.8L II USM was used. The average focal length of each
photo is 43 mm, which is the closest to the human eyes. There were 548
street view photos in total. 2.6. Isovist calculation
Semantic segmentation with deep learning has been widely adopted
to extract information from images [52]. In this study, the semantic The 2D and 3D-volumetric isovists were calculated in Rhino 6,
segmentation technique is applied to the 548 street view photos for the Grasshopper Decoding Spaces Toolbox developed by the team of Com-
extraction of visual exposure information such as the exposure to trees, puter Science in Architecture at Bauhaus University (Fig. 6). The
buildings, and sign symbols (Fig. 5). First, the photos were resampled building models used for calculation were adopted from a previous
from 6240*4160 pixels to 1260*840 pixels to reduce computation time study [55].
while retaining the maximum spectral information. Second, we adopted The first step was to determine the length of the visual line and the
a pre-trained network based on the Cambridge-driving Labeled Video standard visual height. The maximum visual line length is also used to
Database (CamVid) [53] and the Deeplab v3+ network [54] with determine the calculation limit. There is no strict standard for this
Fig. 5. Semantic segmentation workflow.
6

L. Xiang et al. B u i l d i n g a n d E n v ir o n m e n t 205(2021)108273
Fig. 6. (a) An example of 2D-isovist calculation point; (b) an example of 2D-isovist calculation point; (c) the basic setting for calculation 2D-isovsit; (d) the basic
setting for calculation 3D-isovsit.
number [56]. The size of the blocks in the study areas varied from 50 direction’ that describes the movement of the participants was also
m*200 m–250 m*250 m, and the maximum length of the experimental incorporated as a potential predictor since it may influence the visual
route was 500 m. Considering these aspects, the study adopted 500 m as environment as well as the emotions of the participants. Finally, the 29
the maximum visual length. The visual height adopted was 1.6 m, which potential predictors were geo-referenced and matched with the aver-
is close to the average height of the participants. aged emotion for each point.
The attention and perception of people were related to different
fields of vision (FOV), and for both 2D and 3D isovist calculation, we set
2.8. Statistical analysis
FOVvertical as 60◦, which is the center field of FOV. The standard sightline
is horizontally forward, and the normal sight line while standing is 10◦
2.8.1. Identifying the effects of visual exposure using multiple linear
downwards. regression
The statistical analysis is based on a classic MLR model (Equation
2.7. Building the dataset of human movement, physiology, psychology & (3)):
environment Emotionj =α 1 Vαr1 +α 2 Vαr2 +… +α n Vαrn +γ +ε (3)
By combining the spatial and emotional data of 99 participants, the where Emotionj is the averaged Emotion value of all participants at the
emotionally evocative points in the streets were identified. The streets aggregation point j. The model includes n visual exposure metrics as the
were divided into segments with a 4 m resolution to analyze the data. predictor variables. α1 …, αn are the coefficient estimates of the metrics
There were 211 points for the TST and 337 points for the HH route (548 Vαr1, Vαrn at the aggregation point j. γ is the model intercept, and ε is
points in total). For each point, we calculated the average emotion value the residual. The MLR model was constructed based on 29 candidate
of all participants (Equation (2)). variables subset in Table 1, among which ‘change direction’ is the
∑ control variable, the other 28 visual exposure variables from street view
99 Emotion
Emotion j i=1 99 ij (2) and isovist categories are explanatory variables. The current study was
conducted MLR in SPSS 16.0. Stepwise linear regression was applied. It
The visual exposure variables from isovist and street view are sum- performs multiple regression several times, removing the weakest
marized in Table 1 as potential predictors. The variable ‘change correlated variable each time, and at the end, all significant variables are
7

L. Xiang et al.                                                                                                                                                                                               B  u  i l d  i n g   a  n d   E  n  v  ir  o n  m   e n  t 205(2021)108273
Table 1  coordinate of the nearest radial intersection, ‘Xm and Ym’ are the coordinates of
The potential predictors in statistical analysis.   ‘M’, ‘Xv and Yv’ are the coordinates of ‘V’, ‘Si’ is the number of visual lines
reaching the sky, ‘Oi’ is the number of visual lines reaching the objects, ‘Gi’ is the
| Variable  | Theoretical meaning  |     | Calculation methoda  |     |     |     |     |     |     |
| --------- | -------------------- | --- | -------------------- | --- | --- | --- | --- | --- | --- |
number of visual lines reaching the ground.
| Change direction  | whether the participants change  |     | 1 for change, 0 for no  |     |            |              |                   |            |                    |
| ----------------- | -------------------------------- | --- | ----------------------- | --- | ---------- | ------------ | ----------------- | ---------- | ------------------ |
|                   | direction                        |     | change                  |     |            |              |                   |            |                    |
|                   |                                  |     |                         |     | included.  | We  refined  | the  independent  | variables  | by  adopting  the  |
Street view
following rules: p-value <0.05 and VIF <5 to include significant and
| Sky view factor  | percentage of sky pixels of the street  |     | SkyVF=SkyPixel |     |     |     |     |     |     |
| ---------------- | --------------------------------------- | --- | -------------- | --- | --- | --- | --- | --- | --- |
(SkyVF)  view image  P   non-collinear variables. To include as many variables as possible in the
| Building view  | percentage of building pixels of the  |     | BVF=BldgPixel |     |     |     |     |     |     |
| -------------- | ------------------------------------- | --- | ------------- | --- | --- | --- | --- | --- | --- |
MLR model, collinear variables would be put into separate models to run
| factor (BVF)  | street view image  |     |     | P   |     |     |     |     |     |
| ------------- | ------------------ | --- | --- | --- | --- | --- | --- | --- | --- |
the MLR.
| Road view factor  | percentage of road pixels of the  |     | RVF=RoadPixel |     |     |     |     |     |     |
| ----------------- | --------------------------------- | --- | ------------- | --- | --- | --- | --- | --- | --- |
| (RVF)             | street view image                 |     |               | P   |     |     |     |     |     |
Sign symbol view  percentage of sign symbol pixels of  SSVF=SSPixel 2.8.2. Establishing a predictive model for pedestrian emotion using random
| factor (SSVF)  | the street view image  |     |     | P   | forest  |     |     |     |     |
| -------------- | ---------------------- | --- | --- | --- | ------- | --- | --- | --- | --- |
Car view factor  percentage of car pixels of the street  CVF=CarPixel The RF model [57], an ensemble statistical algorithm composed of
| (CVF)  | view image  |     |     | P   |     |     |     |     |     |
| ------ | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
multiple decision trees, was utilized to establish the emotion prediction
| Pe o p le   v iew factor  | p e r c e n t a g e  | o f p e o ple pixels of the  | PVF=Peopl | e P ivel |     |     |     |     |     |
| ------------------------- | -------------------- | ---------------------------- | --------- | -------- | --- | --- | --- | --- | --- |
model. It is superior to linear and other machine learning algorithms in
| ( P V F )   | st r e e t  v i e w |   im ag e   |     | P     |     |     |     |     |     |
| ----------- | ------------------- | ----------- | --- | ----- | --- | --- | --- | --- | --- |
Tr e e  v i e w factor  p e r ce n ta g e  o f tree pixels of the street  =Tree P i xel s e v e r a l  a s p e c t s.   F i r s t ,  i t  i s  su i ta b le   f o r   d e a li n g   w it h   a   l ar g e   n u m b e r  o f
TVFi
( T V F )   vi e w   im a g e   P     v a r ia b l e s  b e c a u s e   i t s  r a n d o m  f e a tu r e   se l e c t io n   p r op e r t y   m a k e s  i t  re li a b le
2d_isovist
and robust against correlated predictors. A random subset of predictors
| Isovist area (Sv)  | the area of visual polygon area  |     | N.A.  |     |     |     |     |     |     |
| ------------------ | -------------------------------- | --- | ----- | --- | --- | --- | --- | --- | --- |
Isovist perimeter  the total length of the visual  N.A.  is used as split candidates for each tree. Second, the problem of over-
(Pv)  boundary  fitting is rare because it conducts bagging where multiple trees are
Cv=4πAv
Compactness (Cv)  describes the compact and simple  generated using bootstrap samples and the majority votes are taken.
|                  | degree of the visual area  |                             | P2  |         |                                                                          |     |     |     |     |
| ---------------- | -------------------------- | --------------------------- | --- | ------- | ------------------------------------------------------------------------ | --- | --- | --- | --- |
|                  |                            |                             |     | V       | Besides, RF can generate unbiased estimates without cross-validating or  |     |     |     |     |
| Circularity(Ci)  | d es c r i b e s  h        | o w   w e l l   a   s pace  |     | π |r |2 |                                                                          |     |     |     |     |
Circularity = using an independent test set. It can be evaluated internally so that
|                         | ap p r o x i m a    | t e s  a  c i r c l e .               |     | A v    |                    |                          |                           |                             |                                    |
| ----------------------- | ------------------- | ------------------------------------- | --- | ------ | ------------------ | ------------------------ | ------------------------- | --------------------------- | ---------------------------------- |
|                         |                     |                                       | v2  |        | u n b i a s e d  e | s t i m a t e s   o f  e | r ro rs   c a n   b e   e | s t a b li s h e d   d u ri | n g   t h e   g e n e ra t i o n   |
| Co n v e x  Deficiency  | T h e   r a t io  o | f   t h e   a re a  of the dent over  | =P  |        |                    |                          |                           |                             |                                    |
( C d )   th e   a r e a  o f   t h e   h u ll   Cd A    pr o c e s s .  T h e   o u t- o f - b a g  ( O O B )   e rr o r   is   t h e  p r e d i c t io n  e r r o r   b a s e d  o n   t h e
Elongation (ψ)   the ratio of the radius of an idealized  Av1/2 trees that do not use a specific sample for training. Moreover, the results
circle associated with the actual  ψ = π are relatively easier to explain because it can provide the importance of
|     | area of the isovist to the radius of an  |     | Pv  |     |     |     |     |     |     |
| --- | ---------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
idealized perimeter from the actual  2π   each variable. The RF regression is therefore a reliable, convenient, and
perimeter  ⃒ moderately interpretable model that is suitable for the pedestrian
|     |     |     |     | ∑ ⃒ ∑2 |     |     |     |     |     |
| --- | --- | --- | --- | ------ | --- | --- | --- | --- | --- |
Occlusivity (Ov)  t h e   d if f e r e n c e   b e tw e e n   i s o v i s t   = k n ⃒ emo t io n   p re d i c t io n   i n  t h i s   st u d y .
|     | p e r i m e t e r   a   | n d   th e   o v e r a l l   l e n g th  of  | Ov   | ⃒ ⃒ Li     |              |                          |                                                    |     |     |
| --- | ----------------------- | -------------------------------------------- | ---- | ---------- | ------------ | ------------------------ | -------------------------------------------------- | --- | --- |
|     |                         |                                              | n Pv | i= 1 i occ | T o   e s ta | b li s h   t h e   p r e | d i c t io n   model based on the visual exposure  |     |     |
|     | t h e   s o l i d   b o | u n d a r i e s   w i t h i n   t h e        |      |            |              |                          |                                                    |     |     |
variables, all 548 observations were used to train the RF. First, the
isovist area
Min-radial  the minimum visual radial line  N.A.  variable selection was performed using an RF-based approach to remove
Max-radial  the maximum of visual radial line  N.A.  redundancy and determine the appropriate split predictor [58]. The
∑
Mean-radial  the mean of visual radial line  =1 n s e l e c t io n   p r o c es s  r a n k s   th e   im p o rt a n ce  o f   a l l  th e   v a r ia b l e s  a n d  a d d s  t h e
Qv Li
|            |                               |     | n     | i= 1 | v a r i a b le s   | o n e  b y  o n e   b a s | ed   o n  th e i r  im | p o r t a n c e  t o   re | a c h   th e   a cc u r ac y   o f  |
| ---------- | ----------------------------- | --- | ----- | ---- | ------------------ | ------------------------- | ---------------------- | ------------------------- | ----------------------------------- |
| SD-radial  | the SD of visual radial line  |     | N.A.  |      |                    |                           |                        |                           |                                     |
the full model. The importance is measured by the incremental mean
| variance-radial  | the mean of the square of deviation  |     |     |     |     |     |     |     |     |
| ---------------- | ------------------------------------ | --- | --- | --- | --- | --- | --- | --- | --- |
= squared error (MSE) because of the permuting OOB observations across
|     | between all radial lengths and  |     | Tv  |     |     |     |     |     |     |
| --- | ------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
average radial length of an isovist
√ √ ̅ ̅̅̅̅ ̅ ̅ ̅̅ ⃒̅̅̅ ̅ ̅̅̅ ̅̅ ̅̅̅̅̅ ̅̅̅ ̅̅ ̅̅ ̅̅ e a c h   in p u t  v a r i a b l e .   A ll   2 9  v a ri a b l e s   w e r e   s e l e c t e d   f o r  e a c h  s p li t  t o   a v o id
√ ∑ n ⃒
|     |     |     | √2 1 | ⃒ ⃒ (cid:0) | 2 | u n d e r e s t i m | a t i n g   t h e   im p | o r ta n c e  o f   s o | m e   v a r i a b l e s .   |     |
| --- | --- | --- | ---- | --------------- | ------------------- | ------------------------ | ----------------------- | --------------------------- | --- |
|     |     |     |      | ⃒ L i Q v       |                     |                          |                         |                             |     |
n i = 1 B a se d   o n   t h e   s e l e c t e d   p r e d i c t o r   v a r i a b l e s   i n   t h i s  s t u d y ,  t h e   s e t  o f
| Skewness  | the mean of the cube of deviation  |     |     |     |     |     |     |     |     |
| --------- | ---------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
parameters of the RF was tuned using Bayesian Optimization to identify
|     | between all radial lengths and  |     | sv = |     |     |     |     |     |     |
| --- | ------------------------------- | --- | ---- | --- | --- | --- | --- | --- | --- |
the optimal model that minimizes the upper confidence interval of the
|     | a v e r a g e   r a d | ia l   l e n gt h   o f   a n   i so v is | t   √ ̅ ̅ ̅̅̅ ̅ ̅ ̅̅ ̅̅ ⃒̅ | ̅ ̅̅ ̅ ̅ ̅ ̅̅̅ ̅̅ ̅̅̅ ̅̅ ̅̅ ̅̅ |     |     |     |     |     |
| --- | --------------------- | ----------------------------------------- | -------------------------- | ------------------------------ | --- | --- | --- | --- | --- |
√ ⃒ M S E   t a r g e t   m o d e l .   I n   t h e   t u n i n g   p r o c e s s ,   t h e   m i n i m u m   t e r m i n a l   n o d e
√ √ 1 ∑ n ⃒
3 ⃒ L (cid:0) Q | 3 ra n g e d   f r o m   1   t o   2 7 4   ( h a l f   o f   th e   5 4 8   o b s e r v a t io n s ) .  T h e   n u m b e r   o f
|             |                       |                                          | n                 | ⃒ i v     |                    |                              |                            |                            |                                          |
| ----------- | --------------------- | ---------------------------------------- | ----------------- | --------- | ------------------ | ---------------------------- | -------------------------- | -------------------------- | ---------------------------------------- |
|             |                       |                                          | i = 1             |           | p r e d ic t o r s |   t o   s a m p l e   a t  e | a c h   n o d e  s t a r t | e d   f r o m   1  t h r o | u g h   a l l  t h e   s e l e c t e d   |
| Dispersion  | th e   d i ff e r e n | c e   b e t w e e n   t h e   v a lu e s |  o f  D v   = M v | - S D v   |                    |                              |                            |                            |                                          |
predictors. The number of trees started from 50 and increased by 50
the mean and the standard deviation
of the isovist radial lengths  each time until it reached 500. Moreover, 10-fold cross-validation was
Drift-magnitude  the distance between the  MV⃒ = conducted for the observations to protect against overfitting. The pre-
∑ ⃒ ∑
|     | o b se r v a t i o n |   p o i n t s   a n d  t h e  m ass  | ( n ⃒ ⃒L2 ⋅Ri | )/( n L2 ) |     |     |     |     |     |
| --- | -------------------- | ------------------------------------ | ------------- | ---------- | --- | --- | --- | --- | --- |
ce n te r   o f   a n   is o v i s t   p o ly g o n   i i dictive model can be therefore established using the knowledge of the
|     |     |     | i = 1 | i = 1 |     |     |     |     |     |
| --- | --- | --- | ----- | ----- | --- | --- | --- | --- | --- |
Drift-angle  the angle between the direction  N.A.  predictors and optimal parameter values. The RF regression was per-
facing occupant and the mass center  formed on the platform of MATLAB 2020b.
of an isovist polygon
3d_isovist
3. Results
| Sky proportion     | the proportion of visual lines to the  |     | Sky3D =Si |     |     |     |     |     |     |
| ------------------ | -------------------------------------- | --- | --------- | --- | --- | --- | --- | --- | --- |
|                    | sky and all visual lines               |     |           | n   |     |     |     |     |     |
| Object proportion  | the proportion of visual lines to the  |     | Obj3D =Oi |     |     |     |     |     |     |
3.1. Descriptive statistics
|                    | objects and all visual lines           |     |           | n   |     |     |     |     |     |
| ------------------ | -------------------------------------- | --- | --------- | --- | --- | --- | --- | --- | --- |
| Ground proportion  | the proportion of visual lines to the  |     | Grd3D =Gi |     |     |     |     |     |     |
3.1.1. Emotional data: SCR and preference
|     | ground and all visual lines  |     |     | n   |     |     |     |     |     |
| --- | ---------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
Visual volume  the total length of all visual lines  ∑n In total, there were 99 trials of SC raw data, 23930 times of SC re-
Vv = Li
|                    |                                       |     | i=       |          | cords, and 30067 times of self-report preference data from all partici- |     |     |     |     |
| ------------------ | ------------------------------------- | --- | -------- | -------- | ----------------------------------------------------------------------- | --- | --- | --- | --- |
| Log visual volume  | The base 10 logarithms of the visual  |     | LogVv =1 | Lg​Vv    |                                                                         |     |     |     |     |
pants. After processing the raw data through the method mentioned in
volume
section 2.4, the emotional dataset included 54252 (99*548) processed
a ‘Li’ provides radial length, ‘n’ is the total number of radials sampled, ‘k’ is
data. Finally, there were 548 emotion datasets after aggregating all data
the number of samples in one 360-degree cycle, ‘Ei_occ’ is the fraction of
from participants at each point.
occluded edge detected, ‘Qv’ the average radial length from V, ‘Ri’ is the
The distribution of the SCR and preference levels can be visualized
8

L. Xiang et al. B u i l d i n g a n d E n v ir o n m e n t 205(2021)108273
for each route through violin plots (Fig. 7). The ranges of data density tower, and other points have significant differences compared to this
are different between the two routes. Data are more concentrated be- part of the route. For the HH route (Fig. 10 (f)), the simplest area is
tween 0.3 and 0.5, and two relatively dense ranges are identified be- identified near the sea. These conditions are in line with reality, which
tween 0.8-1.0 and 1.2–1.4 for the TST route. For the HH route, data is highlights the reliability of our calculated results. In terms of 3D isovist,
more concentrated from 0 to 0.2 and relatively uniform from 0.4 to 1.0. we visualized visual volume data in Fig. 10(g)&(h). It refers to the de-
In terms of preference, the means for both routes lie in the interval of gree of visual openness of the points. For both routes, the broadest areas
0–0.08 (F (1,97) =1.424, p <0.01), while the standard deviations are in are near the parks and the HH routes have significantly higher visual
the range 0.205–0.228. For the TST route, data are located most densely volume than TST.
between 0 and 0.2, and the rest of the data are evenly distributed on both
sides. For the HH route, data are located relatively scattered.
3.2. Multiple linear regression model results
The distribution of emotion data (Fig. 8 (a)) shows that there are
three points with frequent negative emotions for the TST route. The
According to the VIF test for the 29 candidate variables, collinearity
negative emotions in HH mainly occur at the big street crossings with
is identified between occlusivity and drift magnitude. We put these two
heavy traffic. The positive emotions in the TST route mainly appear near
variables in separate models to run the MLR and keep both models when
the man-made park. The photos of the participants during the experi-
reporting the results to incorporate as many variables as possible. The
ment are shown in Fig. 8(b–d).
residuals conform to the normal distribution. The final models are
therefore effective and stable.
3.1.2. Street view and isovist
Table 2 shows the resultant MLR models. Model 1 (with occlusivity)
The street view images were categorized into seven classes using
already explains almost 44.5% of the variation in the measured emotion
semantic segmentation with deep learning (Fig. 9). Accuracy assessment
while model 2 (with drift magnitude) explains almost 47.6% of the
from independent validation samples indicates an accuracy of 88.9%,
variation. In both models, emotions are regressed on eight visual
95.7%, and 87.7% for the sky, tree, and urban classes, respectively. The
exposure variables while also statically accounting for the effect of
mean Intersection over Union (IoU) is 0.820. The validation results
change direction. The results indicate the significance of street view and
demonstrate that the semantic segmentation method adopted in this
isovist in explaining the spatial variation of emotion. Both models have
study is reliable and sufficient to detect necessary information from
eight common predictors, three of which influence emotion in a positive
street view photos, especially for tree extraction.
way, namely Tree View Factor, visual volume, and change direction. The
Fig. 10 shows the selected predictors from street view and isovist for
remaining 5 predictors are all related to negative emotion. Occlusivity
each point in TST and HH, including Tree View Factor, compactness,
has the largest standardized coefficient ((cid:0) 0.433) while the change di-
min-radial, and visual volume. For the Tree View Factor maps (Fig. 10
rection has the lowest one (0.107) in model 1. In model 2, drift-
(a)&(b)), the points in HH generally have a higher tree proportion
magnitude has the largest standardized coefficient ((cid:0) 0.554) while the
compared to those in TST, indicating greater exposure to trees along this
isovist area has the lowest one ((cid:0) 0.075).
route. The majority of the points in TST have a tree proportion lower
than 10%. Only the points close to the park are exposed to a high tree
coverage. For the min-radial maps (Fig. 10 (c)&(d)), the variation of HH 3.3. Random forest model results and evaluation
points is larger than the ones in TST. Min-radial always has a strong
fluctuation on each corner where the participants change their walking To minimize the prediction time, it is necessary to create a predictive
direction. Compactness, which describes the compact and simple degree model using as few predictors as possible. Therefore, the variable se-
of the visual area, is another important 2D isovist variable. For the TST lection was performed based on the importance ranking of all the pre-
route (Fig. 10 (e)), the smallest points are located beside a huge high-rise dictors using an RF model with 50 trees. According to the variable
importance (Fig. 11), the Tree View Factor is the most important
Fig. 7. Violin Plots showing the distribution of gathered responses.
9

L. Xiang et al. B u i l d i n g a n d E n v ir o n m e n t 205(2021)108273
Fig. 8. (a) Visualization maps of the final emotion results for the two experimental routes; (b,c) the participants were finishing the tasks; (d) the participants were
relaxing, and the SC baselines were recorded during this period.
Fig. 9. Overlay of a classified image and the original street view image in HH
Sky:2.5%; Tree:19.2%; Car:4.2%; Building:42.8%.
predictor variable, followed by drift angle, and sky proportion. It is Ground Proportion, Object Proportion, Convex Deficiency, and BVF are
identified that the nine variables with the highest importance, i.e., in sufficient to predict the pedestrian emotion since the reduced model
order, Tree View Factor, Drift Angle, Sky Proportion, Min Radial, Area, containing only the nine variables has an R2 value of 0.776, which
10

L. Xiang et al. B u i l d i n g a n d E n v ir o n m e n t 205(2021)108273
Fig. 10. Visualized maps of selected predictors, (a) Tree View Factor in TST route; (b) Tree View Factor in HH route; (c) 2D_isovist min-radial in TST route; (d)
2D_isovist min-radial in HH route; (e) 2D_isovist compactness in TST route; (f) 2D_isovist compactness in HH route; (g) 3D_isovist visual volume in TST route; (h)
3D_isovist visual volume in HH route.
11

L. Xiang et al. B u i l d i n g a n d E n v ir o n m e n t 205(2021)108273
Table 2
The performance and structure of the resultant MLR models of emotion states.
Model 1(R2 =0.445) Model 2 (R2 =0.476)
Predictor variables standardized coefficients VIF Predictor variables standardized coefficients VIF
Tree View Factor .145*** 1.569 Tree View Factor .196*** 1.473
Object proportion (3D) -.248*** 2.276 Sign Symbol View Factor -.219 *** 1.296
Occlusivity (2D) -.433 *** 4.997 Object proportion (3D) -.228 *** 2.109
Visual volume (3D) .419 *** 4.047 Drift magnitude (2D) .554 *** 3.297
Min-radial (2D) -.230 *** 1.619 Visual volume (3D) .430 *** 3.912
SSVF -.231 *** 1.295 Min-radial (2D) -.292 *** 1.588
Compactness (2D) -.209 *** 3.482 Compactness (2D) -.226 *** 2.869
change direction .107 *** 1.131 change direction .128 *** 1.059
Isovist area (2D) -.124* 2.834 Isovist area (2D) -.075* 4.417
Note: Significance * P <0.05, **P <0.01, ***P <0.001. The descriptions of the variables can refer to Table 1.
pedestrian emotion. These two models have advantages in distinct as-
pects. The MLR has stricter requirements for the raw data that all vari-
ables in the final model should not be collinear, while the RF model does
not require specific input data types. MLR can reveal whether the in-
dependent variable has a negative or positive effect on the dependent
variable, while RF can only show the importance of each variable.
Therefore, the results from MLR were used to obtain a basic under-
standing of the linear relationship between visual exposure and
emotion, and the RF was then used to build the predictive model.
According to the MLR, visual exposure from 2D_isovist, 3D_isovist,
and street view influences emotion simultaneously, and thus, none of
them have been completely excluded in the final model. The findings
indicate that the method of including these three aspects of visual
exposure is effective in explaining the variations of emotion. As a result
of including all visual exposure elements and distinguishing the positive
and negative emotions, the R2 values (0.445 and 0.476) in the developed
MLR models are higher than in previous studies [29]. Therefore, it is
suggested that isovists and street view factors should be considered at
the same time for further studies.
Moreover, all 2D_isovist variables, including occlusivity, min-radial,
Fig. 11. Unbiased predictor importance estimates. compactness, and isovist area, in the resultant MLR models have a
negative influence on emotion. Visual volume, as a comprehensive
already exceeds the accuracy of the full model containing all the 29 variable from 3D_isovist calculation, remains in both final MLR models
potential variables (R2 =0.767). Moreover, the nine selected variables and has a positive influence on emotion with the largest standardized
were reused to conduct the experimentation to determine the parameter coefficient among all the variables. Objective proportion and min-radial
values of the RF model. The tuning results reveal that in the optimal are the other two variables from 3D_isovist which show a moderately
model, the minimum terminal node is 1, the number of predictors to negative relationship with emotion.
sample is 6, and the number of trees is 400. The street view factors can be divided into two types: stationary
The final predictive model includes 9 predictors and 400 trees. It has (tree, sign symbol, sky, building, road) and dynamic (car and people).
an R2 value of 0.790, a Root Mean Square Error (RMSE) of 0.022, and a Two stationary variables (Tree View Factor and Sign Symbol View
Mean Absolute Error (MAE) of 0.015. The final model can explain 79.0% Factor) remained in the resultant models, providing more detailed in-
of the spatial variance of pedestrian emotion in Hong Kong. The model formation on the real environment that cannot be reflected by isovist
has demonstrated a stronger ability to predict pedestrian emotion in calculations. This indicates the isovist and street view factors are com-
Hong Kong compared to the MLR model in section 3.2. Besides, the plementary and compensate for the shortcomings of each other. For
results show that the final RF model has achieved good precision and instance, the isovist supplements the geometric characteristics of a vi-
stability. Therefore, the established model with the visual exposure sual area, whereas the street view factor provides extra data that are
features identified with predictive potential can be applied to predict difficult to model in the isovist calculation. Car View Factor and People
pedestrian emotion for new subjects with a satisfactory accuracy of over View Factor have been excluded because the raw street view photos
79%. were taken after the experiments all at once, and can hardly reflect the
real-time dynamic state on the street when the participants were
4. Discussions walking.
The RF model has a better prediction ability (79.0%) than the MLR
4.1. Model interpretation model (R2 =0.476). Also, it is slightly higher than the predictive models
of Bielik et al. [29] (R2 =0.67, R2 =0.79 for their two tested routes,
The understanding of the effects of the visible environment on the respectively). The nine most important variables consist of visual
emotional experiences of an individual during his/her high-density exposure factors from both isovist and street view. The Tree View Factor
urban walking is essential for creating a psychologically friendly built is the most important variable to predict emotion, followed by two
environment. In this study, a multiple linear regression model is used to variables (drift angle and min-radial) from 2D_isovist. Besides, Building
determine the relationship between different visual exposures and View Factor also ranks the top among all the variables. The predictive
emotions. A more complicated model that can consider the non-linear model has the highest prediction ability when the emotion value is in the
relationship – random forest modeling – is also for predicting range of 0–0.05 and becomes less predictive when the observation value
12

L. Xiang et al. B u i l d i n g a n d E n v ir o n m e n t 205(2021)108273
extends to the two extremes (Fig. 12). Therefore, it is proposed that the relationship between visual simple
There are some common variables of the final resultant models of the degree and emotion may be curvilinear rather than linear. Moreover, the
MLR and RF. The TVF, min-radial, isovist area, and object proportion are visual perception of complexity is not only determined by the geometric
the overlapping variables that exist in both the final MLR models and the characteristics of the visual area but also relevant to the specific context.
RF model. The RF also demonstrates the non-linear relationship between Lastly, object proportion (highly related to the BVF) and TVF show a
emotion and drift angle, sky proportion, ground proportion, BVF, significant correlation with emotion, which is in line with [30].
convex deficiency. The effects of these variables require further inves-
tigation to quantify the non-linear correlations. 4.3. Implications for city design
4.2. Comparison with relevant studies The urban environment, particularly in the high-density city, is
found to be associated with a series of physical and mental diseases [57].
The current study was conducted in a real outdoor environment. Data-driven and evidence-based approaches are indispensable to
When compared to those that were strictly controlled in laboratories, the healthy city development intending to enhance the quality of life and
current results are more representative of the real conditions in terms of reduce the adverse effects of urban living [57]. Therefore, the method-
the environment and how the people move. When compared to the ological framework, statistical model, and the data-driven approach
previous field studies, such as the GEMA [31–33], which often have provided in this study demonstrate new opportunities to evaluate and
longer experiment periods (always from days to weeks), the current implement a healthy city for planners and decision-makers. Moreover,
results are likely more accurate because the participants were guided by the variable selection can inform researchers and urban designers on the
an instructor during the whole experiment process to ensure that they environmental factors critical for mental health. The current study
walked the pre-defined route, and the visual exposure data were recognized the importance of visual exposure on emotion and recom-
consistent with the real condition. mends the consideration of street-view factors and isovists in creating
There are several common grounds and different results when healthy cities.
comparing the current MLR results with previous studies conducted in In this study, Visual Volume (3D), also expressed as Spatial Openness
different countries. First, in model 1, occlusivity is negatively correlated Index [56], shows the positive influence on triggering a positive
with emotion in all the studies that mentioned isovist [39–41]. Second, emotion. Therefore, the designers could control the visual volume value
occlusivity was excluded in model 2 because of collinearity while the from the pedestrians’ visual height of the neighborhoods at the district
drift magnitude takes a heavy share in a positive influence on emotion. and building levels. Efficient methods to increase visual volume value
This result is in line with a previous study in Hong Kong [39], which include controlling the total building volume rate at the district level,
indicated that open space with a visual target set at a distance is the designing the setback spaces at the building podium, adopting different
dominant factor in creating positive emotions. Third, compactness is building forms and arrangements, and decreasing the obstacle area by
another variable significant in all the studies. However, it has different setting up holes at proper locations at the building level.
associations with emotions from the previous studies. Results from Refs. In addition, Drift-magnitude, which refers to the distance between the
[39–41] indicated that the simpler the visual area, the more likely it led testing point and the mass center of the isovist polygon, has the most
to positive emotions. Kno¨ll et al. [59] contradicted that visual positive relationship with emotion value. Therefore, setting a visual
complexity would contribute to less stress and more positive states. The target at a proper distance can be helpful in increasing the emotion
current study gives the same results as the latter. It is hard to draw a value. Also relating to this strategy, occlusivity shows the most negative
definite conclusion on the relationship between visual complexity and influence on emotion. It offers implications for the design of some
emotion because compactness could have opposite results even for important urban nodes that it is better to guide the visual sight to the
studies conducted in similar environments and cultural contexts. target with boundary.
Fig. 12. Predicted and the actual pedestrian emotion from the final predictive model.
13

L. Xiang et al. B u i l d i n g a n d E n v ir o n m e n t 205(2021)108273
Moreover, the tree view factor and sign symbol view factor can view factor, visual volume, and drift magnitude can cause positive
significantly influence emotion. Previous studies [60–65] have shown emotions. Conversely, areas with the view of sign symbols and object
that trees or greening can increase the restorative capability and psy- proportion, min-radial, and occlusivity incite negative emotions; 3. the
chological friendliness of the landscape. Setting up street trees at proper RF model demonstrates a strong ability to predict pedestrian emotion
locations and decreasing the number of billboards will contribute to and can explain 79.0% of the spatial variance of the pedestrian emotion
triggering better emotional states. using only nine visual exposure variables; 4. TVF, drift angle, and min-
Therefore, the effects of the visual exposure variables explored in this radial are the dominant influential variables in the RF model.
study could be referred to in urban design practice. With such infor- This study demonstrates the potential and effectiveness of moni-
mation, urban planners and policymakers can perform better environ- toring the emotions of pedestrians with wearable sensors in high-density
mental control and intervention to optimize the spatial planning scheme built environments. The regression models built based on this approach
of each factor and design a healthy city from a psychologically friendly can be adopted to better understand human emotions over space and
environment perspective. time under different visual exposure. Such provides urban planners and
designers with accurate, concrete, quantifiable, and actionable insights
4.4. Limitations and future studies and evidence that can be used to make decisions and investments that
aim at transforming our environment into not only a more beautiful
The current study has several limitations, mostly stemming from the place to be visited and traveled through but also a functional space that
technical complexity and precision of the data collection over space and contributes to emotional and physical well-being.
time. First, the time of the street view photo is different from the
experiment. Therefore, the exposure to moving objects, such as cars and Declaration of competing interest
people during the experiment may not be truthfully reflected by the
street view images. This limitation has already been reflected in the The authors declare that they have no known competing financial
results that no dynamic factors from street view factors were included interests or personal relationships that could have appeared to influence
within the final models. Although these dynamic factors (cars, crowding, the work reported in this paper.
etc.) are important elements in an urban outdoor space, they are not
related directly to the visual urban form and are difficult to be controlled Acknowledgments
in the urban design of stationary elements, i. e. the shapes and layout of
buildings and streets. Therefore, this limitation does not jeopardize the The study is supported by a PGS studentship from The Chinese
practical implications of this study. Second, the building model for the University of Hong Kong. The research gains ethics approval from The
isovist calculation is primitive, containing only the basic information of Chinese University of Hong Kong (Certificate No. S24601960). The au-
the massing, but not other information from the calculation model (such thors thank Miss Kwok Yu Ting and Mr. Cyrus Wong for proofreading.
as billboards, semi-outdoor spaces, and main holes in the building fa-
çades). The missing information has been supplemented by real street Appendix A. Supplementary data
view images in this study. Finally, the participants in the experiments
were all young, healthy adults, which would lead to selection bias and Supplementary data to this article can be found online at https://doi.
model deviation. The sample bias has been minimized by standardizing org/10.1016/j.buildenv.2021.108273.
the SCR.
Several future research plans can be listed based on the current References
study. First, different models can be developed based on the current
data. Factors from the environment and individuals, such as spatial [1] WHO, Comprehensive Mental Health Action Plan 2013–2020, 2013.
[2] F. Lederbogen, P. Kirsch, L. Haddad, F. Streit, H. Tost, P. Schuch, S. Wust, J.
variations and the fixed effects from different participants can be
C. Pruessner, M. Rietschel, M. Deuschle, A. Meyer-Lindenberg, City living and
considered using geographically weighted models or panel data. Time- urban upbringing affect neural social stress processing in humans, Sci. Rep. 474
series analysis can also be conducted to investigate the dynamic of (7352) (2011) 498–501.
[3] H. Tost, City living marks the brain, Nat. Newslett. 474 (2011).
emotion over time. Second, we plan to further explore and quantify the
[4] C.E. Izard, Human Emotions, Plenum Press, New York, 1977.
effects of the visual environment for urban design implications, for [5] A. Mehrabian, J.A. Russell, An Approach to Environmental Psychology, the MIT
example, the exact interval of each visual target, the proper amount of Press, 1974.
[6] P. Ekman, Basic emotions, in: Handbook of Cognition and Emotion, Wiley, UK,
street trees, the effects of different building forms on emotion, etc. in
1999.
underway. Finally, more advanced ways to acquire valence, such as the [7] M. Bastiaansen, X.D. Lub, O. Mitas, T.H. Jung, M.P. Ascença˜o, D.-I. Han,
EEG, can be adopted to improve the accuracy of self-report data. T. Moilanen, B. Smit, W. Strijbosch, Emotions as core building blocks of an
experience, Int. J. Contemp. Hospit. Manag. 31 (2) (2019) 651–668.
[8] J. Posner, J.A. Russell, B.S. Peterson, The circumplex model of affect: an integrative
5. Conclusion approach to affective neuroscience, cognitive development, and psychopathology,
Dev. Psychopathol. 17 (3) (2005) 715–734.
To facilitate informed control decisions of urban design, this study [9] I.B. Mauss, M.D. Robinson, Measures of emotion: a review, Cognit. Emot. 23 (2)
(2009) 209–237.
analyzed the impact of visual exposure on pedestrian emotion using [10] J. Wirtz, J.E. Bateson, Consumer satisfaction with services: integrating the
MLR and established a predictive model using RF. The current approach environment perspective in services marketing into the traditional disconfirmation
is novel in four aspects. First, it is the first to incorporate and quantify paradigm, J. Bus. Res. 44 (1) (1999) 55–66.
[11] J.A. Russell, A circumplex model of affect, J. Pers. Soc. Psychol. 39 (6) (1980)
multiple levels of environmental exposure from isovist (2D and 3D) and
1161.
street view factors for a complete visual environment. Besides, it at- [12] K. Kirillova, X. Fu, X. Lehto, L. Cai, What makes a destination beautiful?
tempts to quantify two-dimensional emotion by combining subjective Dimensions of tourist aesthetic judgment, Tourism Manag. 42 (2014) 282–293.
[13] J.J. Brakus, B.H. Schmitt, L. Zarantonello, Brand experience: what is it? How is it
self-report data and ambulatory arousal assessment simultaneously. In measured? Does it affect loyalty? J. Market. 73 (3) (2009) 52–68.
addition, this study more adequately models the emotion from envi- [14] J.W. Kalat, Biological Psychology, Cengage Learning, 2015.
ronmental factors with machine learning techniques. Furthermore, it [15] L.S. Davis, M.L. Benedikt, Computational models of space: isovists and isovist
fields, Comput. Graph. Image Process. 11 (1) (1979) 49–72.
compensates for the lack of reference data in high-density cities.
[16] X. Li, C. Ratti, I. Seiferling, Quantifying the shade provision of street trees in urban
The following conclusions can be drawn from the present study: 1. landscape: a case study in Boston, USA, using Google Street View, Landsc. Urban
both street view and isovist show a significant correlation with pedes- Plann. 169 (2018) 81–91.
trian emotions; 2. the MLR models have an R2 value of around 0.5 and
suggest that in a high-density environment, exposure to a larger tree
14

L. Xiang et al. B u i l d i n g a n d E n v ir o n m e n t 205(2021)108273
[17] F.-Y. Gong, Z.-C. Zeng, F. Zhang, X. Li, E. Ng, L.K. Norford, Mapping sky, tree, and [42] Y.S. Noam Shoval, Maya Tamir, Real-time measurement of tourists’ objective and
building view factors of street canyons in a high-density urban environment, Build. subjective emotions in time and space, J. Trav. Res. 57 (1) (2018) 3–16.
Environ. 134 (2018) 155–167. [43] C. Ellard, C. Montgomery, TESTING, TESTING! A Psychological Study on Ciy
[18] A.E. Stamps, Advances in Visual Diversity and Entropy, Environ. Plann. B: Plann. Spaces and How They Affect Our Bodies and Minds, 2013.
Design 30 (3) (2003) 449–463. [44] M. Schmidkunz, O. Schroth, P. Zeile, U. Kias, Road Safety from Cyclist’s
[19] E. Stamps, Isovists, enclosure, and permeability theory, Environ. Plann. Plann. Des. Perspective, REAL CORP 2019– IS THIS the REAL WORLD? Perfect Smart Cities vs,
32 (2005). Real Emotional Cities, 2019, pp. 597–604.
[20] A.E. Stamps 3rd, Some findings on prospect and refuge theory: II, Percept. Mot. [45] The World Bank, Population Density (People Per Sq. Km of Land Area) - Hong Kong
Skills 107 (1) (2008) 141–158. SAR, 2018. China, https://data.worldbank.org/indicator/EN.POP.DNST?location
[21] D.E. Berlyne, Attention, perception and behavior theory, Psychol. Rev. 58 (2) s=HK.
(1951) 137. [46] Working Group of the Preparatory Committee for Mental Health Month 2020,
[22] P.J. Lindal, T. Hartig, Effects of urban street vegetation on judgments of restoration Territory-wide Mental Health Index Index Survey 2020, 2020.
likelihood, Urban For. Urban Green. 14 (2) (2015) 200–209. [47] S.A. Chatterjee, J.J. Daly, E.C. Porges, E.J. Fox, D.K. Rose, T.E. McGuirk, D.
[23] P.J. Lindal, T. Hartig, Architectural variation, building height, and the restorative M. Otzel, K.A. Butera, D.J. Clark, Mobility function and recovery after stroke:
quality of urban residential streetscapes, J. Environ. Psychol. 33 (2013) 26–36. preliminary insights from sympathetic nervous system Activity, J. Neurol. Phys.
[24] R.C. Dalton, The secret is to follow your nose: route path selection and angularity, Ther. 42 (4) (2018) 224–232.
Environ. Behav. 35 (1) (2003) 107–131. [48] E. Gatti, E. Calzolari, E. Maggioni, M. Obrist, Emotional ratings and skin
[25] J.M. Wiener, S. Ho¨lscher C Fau - Büchner, L. Büchner S Fau - Konieczny, L. conductance response to visual, auditory and haptic stimuli, Sci. Data 5 (2018)
Konieczny, Gaze Behaviour during Space Perception and Spatial Decision Making, 180120.
(1430-2772 (Electronic)). [49] D.G.W. Jason, J. Braithwaite, Robert Jones, Mickey Rowe, A guide for analysing
[26] G. Franz, J.M. Wiener, From space syntax to space semantics: a behaviorally and electrodermal activity (EDA) & skin conductance responses (SCRs) for
perceptually oriented methodology for the efficient description of the geometry psychological experiments (revised version: 2.0), in: S.o.P. Behavioural Brain
and topology of environments, Environ. Plann. Plann. Des. 35 (4) (2008) 574–592. Sciences Centre, University of Birmingham, UK, 2015.
[27] J. Yin, S. Zhu, P. MacNaughton, J.G. Allen, J.D. Spengler, Physiological and [50] M.M. Bradley, M.K. Greenwald, M.C. Petry, P.J. Lang, Remembering pictures:
cognitive performance of exposure to biophilic indoor environment, Build. pleasure and arousal in memory, J. Exp. Psychol. Learn. Mem. Cogn. 18 (2) (1992)
Environ. 132 (2018) 255–262. 379.
[28] Q. Huang, M. Yang, H.-a. Jane, S. Li, N. Bauer, Trees, grass, or concrete? The effects [51] Z. Chen, S. Schulz, M. Qiu, W. Yang, X. He, Z. Wang, L. Yang, Assessing affective
of different types of environments on stress reduction, Landsc. Urban Plann. 193 experience of in-situ environmental walk via wearable biosensors for evidence-
(2020). based design, Cognit. Syst. Res. 52 (2018) 970–977.
[29] M. Bielik, S. Schneider, S. Kuliga, D. Griego, V. Ojha, R. Ko¨nig, G. Schmitt, [52] A. Garcia-Garcia, S. Orts-Escolano, S. Oprea, V. Villena-Martinez, J. Garcia-
D. Donath, Examining trade-offs between social, psychological, and energy Rodriguez, A Review on Deep Learning Techniques Applied to Semantic
potential of urban form, ISPRS Int. J. Geo-Inf. 8 (2) (2019). Segmentation, 2017 arXiv preprint arXiv:1704.06857.
[30] G.C. Millar, O. Mitas, W. Boode, L. Hoeke, J. de Kruijf, A. Petrasova, H. Mitasova, [53] G.J. Brostow, J. Fauqueur, R. Cipolla, Semantic object classes in video: a high-
Space-time analytics of human physiology for urban planning, Comput. Environ. definition ground truth database, Pattern Recogn. Lett. 30 (2) (2009) 88–97.
Urban Syst. 85 (2021). [54] L.-C. Chen, Y. Zhu, G. Papandreou, F. Schroff, H. Adam, Encoder-decoder with
[31] J. Mennis, M. Mason, A. Ambrus, Urban greenspace is associated with reduced Atrous Separable Convolution for Semantic Image Segmentation, 2018,
psychological stress among adolescents: a geographic ecological momentary pp. 801–818.
assessment (GEMA) analysis of activity space, Landsc. Urban Plann. 174 (2018) [55] C. Ren, M. Cai, X. Li, Y. Shi, L. See, Developing a rapid method for 3-dimensional
1–9. urban morphology extraction using open-source data, Sustain. Cities Soc. 53
[32] T.R. Kirchner, S. Shiffman, Spatio-temporal determinants of mental health and (2020) 101962.
well-being: advances in geographically-explicit ecological momentary assessment [56] D. Fisher-Gewirtzman, I.A. Wagner, Spatial openness as a practical metric for
(GEMA), Soc. Psychiatr. Psychiatr. Epidemiol. 51 (9) (2016) 1211–1223. evaluating built-up environments, Environ. Plann. Plann. Des. 30 (1) (2003)
[33] L. Kou, Y. Tao, M.-P. Kwan, Y. Chai, Understanding the relationships among 37–49.
individual-based momentary measured noise, perceived noise, and psychological [57] L. Breiman, Random forests, Mach. Learn. 45 (1) (2001) 5–32.
stress: a geographic ecological momentary assessment (GEMA) approach, Health [58] R. Genuer, J.-M. Poggi, C. Tuleau-Malot, Variable selection using random forests,
Place 64 (2020) 102285. Pattern Recogn. Lett. 31 (14) (2010) 2225–2236.
[34] C. Nold, EmotionalCartography: Technologies of the Self, 2009. [59] M. Kno¨ll, K. Neuheuser, T. Cleff, A. Rudolph-Cleff, A tool to predict perceived
[35] P. Zeile, S. Ho¨ffken, G. Papastefanou, Mapping people – the measurement of urban stress in open public spaces, Environ. Plann. B: Urban Anal. City Sci. 45 (4)
physiological data in city areas and the potential benefit for urban planning, (2017) 797–813.
REALCORP 2009 (2009). [60] C. Ward Thompson, J. Roe, P. Aspinall, R. Mitchell, A. Clow, D. Miller, More green
[36] G. Sagl, B. Resch, T. Blaschke, Contextual Sensing: Integrating Contextual space is linked to less stress in deprived communities: evidence from salivary
Information with Human and Technical Geo-Sensor Information for Smart Cities, cortisol patterns, Landsc. Urban Plann. 105 (3) (2012) 221–229.
Sensors, Basel, Switzerland, 2015, pp. 17013–17035. [61] G.N. Bratman, J.P. Hamilton, K.S. Hahn, G.C. Daily, J.J. Gross, Nature experience
[37] A. Birenboim, K.H. Reinau, N. Shoval, H. Harder, High-resolution measurement reduces rumination and subgenual prefrontal cortex activation, Proc. Natl. Acad.
and analysis of visitor experiences in time and space: the case of Aalborg zoo in Sci. U. S. A. 112 (28) (2015) 8567–8572.
Denmark, Prof. Geogr. 67 (4) (2015) 620–629. [62] Hartig Terry, Marlis Mang, Gary W. Evans, Restorative Effects of Natural
[38] Linda Do¨rrzapf, Zeile Peter, Günther Sagl, Sudmanns Martin, Anja Summa, Environment Experiences, Environ. Behav. 23 (1) (1991) 24.
Bernd Resch, Urban Emotions - an Interdisciplinary Interface between [63] T.H. Kim, G.W. Jeong, H.S. Baek, G.W. Kim, T. Sundaram, H.K. Kang, S.W. Lee, H.
Geoinformatics and Urban Planning, Planning Support Systems and Smart Cities, J. Kim, J.K. Song, Human brain activation in response to visual stimulation with
2015. rural and urban scenery pictures: a functional magnetic resonance imaging study,
[39] L. Xiang, G. Papastefanou, E. Ng, Isovist Indicators as a Means to Relieve Sci. Total Environ. 408 (12) (2010) 2600–2607.
Pedestrian Psycho-Physiological Stress in Hong Kong, Environment and Planning [64] R. Kaplan, S. Kaplan, The Experience of Nature: A Psychological Perspective, CUP
B: Urban Analytics and City Science, 2020. Archive, 1989.
[40] X. Li, I. Hijazi, R. Koenig, Z. Lv, C. Zhong, G. Schmitt, Assessing essential qualities [65] R.S. Ulrich, R.F. Simons, B.D. Losito, E. Fiorito, M.A. Miles, M. Zelson, Stress
of urban space with emotional and visual data based on GIS technique, ISPRS Int. J. recovery during exposure to natural and urban environments, J. Environ. Psychol.
Geo-Inf. 5 (11) (2016) 218. 11 (3) (1991) 201–230.
[41] I.H. Hijazi, R. Koenig, S. Schneider, X. Li, M. Bielik, G.N.J. Schmit, D. Donath,
Geostatistical analysis for the study of relationships between the emotional
responses of urban walkers to urban spaces, Int. J. E Plann. Res. 5 (1) (2016) 1–19.
15
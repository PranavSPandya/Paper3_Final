Chrisinger and King Int J Health Geogr (2018) 17:17 International Journal of
https://doi.org/10.1186/s12942-018-0140-1
Health Geographics
METHODOLOGY Open Access
Stress experiences in neighborhood
and social environments (SENSE): a pilot study
to integrate the quantified self with citizen
science to improve the built environment
and health
Benjamin W. Chrisinger1* and Abby C. King1,2
Abstract
Background: Identifying elements of one’s environment—observable and unobservable—that contribute to chronic
stress including the perception of comfort and discomfort associated with different settings, presents many methodo-
logical and analytical challenges. However, it also presents an opportunity to engage the public in collecting and analyz-
ing their own geospatial and biometric data to increase community member understanding of their local environments
and activate potential environmental improvements. In this first-generation project, we developed a methodology to
integrate geospatial technology with biometric sensing within a previously developed, evidence-based “citizen science”
protocol, called “Our Voice.” Participants used a smartphone/tablet-based application, called the Discovery Tool (DT), to
collect photos and audio narratives about elements of the built environment that contributed to or detracted from their
well-being. A wrist-worn sensor (Empatica E4) was used to collect time-stamped data, including 3-axis accelerometry,
skin temperature, blood volume pressure, heart rate, heartbeat inter-beat interval, and electrodermal activity (EDA).
Open-source R packages were employed to automatically organize, clean, geocode, and visualize the biometric data.
Results: In total, 14 adults (8 women, 6 men) were successfully recruited to participate in the investigation. Partici-
pants recorded 174 images and 124 audio files with the DT. Among captured images with a participant-determined
positive or negative rating (n 131), over half were positive (58.8%, n 77). Within-participant positive/negative
= =
rating ratios were similar, with most participants rating 53.0% of their images as positive (SD 21.4%). Significant spatial
clusters of positive and negative photos were identified using the Getis-Ord Gi* local statistic, and significant associa-
tions between participant EDA and distance to DT photos, and street and land use characteristics were also observed
with linear mixed models. Interactive data maps allowed participants to (1) reflect on data collected during the neigh-
borhood walk, (2) see how EDA levels changed over the course of the walk in relation to objective neighborhood
features (using basemap and DT app photos), and (3) compare their data to other participants along the same route.
Conclusions: Participants identified a variety of social and environmental features that contributed to or detracted
from their well-being. This initial investigation sets the stage for further research combining qualitative and quantita-
tive data capture and interpretation to identify objective and perceived elements of the built environment influence
our embodied experience in different settings. It provides a systematic process for simultaneously collecting multiple
*Correspondence: bchris@stanford.edu
1 Stanford Prevention Research Center, Department of Medicine, School
of Medicine, Stanford University, 1070 Arastradero Road, Suite 100, Palo
Alto, CA 94304, USA
Full list of author information is available at the end of the article
© The Author(s) 2018. This article is distributed under the terms of the Creative Commons Attribution 4.0 International License
(http://creat iveco mmons .org/licen ses/by/4.0/), which permits unrestricted use, distribution, and reproduction in any medium,
provided you give appropriate credit to the original author(s) and the source, provide a link to the Creative Commons license,
and indicate if changes were made. The Creative Commons Public Domain Dedication waiver (http://creat iveco mmons .org/
publi cdoma in/zero/1.0/) applies to the data made available in this article, unless otherwise stated.

Chrisinger and King Int J Health Geogr (2018) 17:17 Page 2 of 13
kinds of data, and lays a foundation for future statistical and spatial analyses in addition to more in-depth interpreta-
tion of how these responses vary within and between individuals.
Keywords: Citizen science, Quantified self, Chronic stress, Allostatic load, Electrodermal activity, Built environment,
Sensors, Leaflet
Background as cortisol or allostatic load allow for a consideration of
Living and working in chronically stressful environments the cumulative effects of stress, they are not as well suited
are thought to contribute to a wide range of adverse to understanding the relative influence of different stress-
health outcomes. While the body’s stress response sys- ors, or how individual and environmental characteristics
tems (e.g., “fight-or-flight”) may be helpful in adapting to intersect to yield different stress outcomes.
acute environmental stimuli, major life events, or trauma, In response to this challenge, Roe and colleagues
the continual triggering of these mechanisms may dimin- have spearheaded a new generation of interdiscipli-
ish an individual’s biological capacity to respond to nary research that measures direct biological responses
stressors [1]. With the impairment of this biological sys- to different types of built environments. Using a head-
tem, chronic stress can increase an individual’s risk of worn device, the Emotiv EPOC, Roe et al. [10] explored
experiencing adverse health outcomes, including chronic changes in brain activity (measured via electroencepha-
diseases such as obesity and type II diabetes [1–3]. logram, or EEG) as laboratory participants were exposed
Emerging research is also beginning to help us conceptu- to images of urban and natural landscape scenes. These
alize and document the causal pathways, including stress, findings informed later EEG studies with free-moving
related to built environments that may explain the well- participants walking in different types of environments.
documented burden of chronic disease in disadvantaged For instance, Aspinall et al. [11] found EEG changes as
communities [4–6]. participants moved into and out of urban green spaces
Many studies exploring connections between stress and other environments.
and health have used levels of blood or salivary cortisol, Complicating the identification of environmental con-
a steroid hormone produced as part of the body’s stress tributors to chronic stress is the role of individual percep-
response. Most cortisol research attempts to describe tion [12]. For instance, environmental health researchers
cumulative stress effects, though additional attention to have found that individuals living in objectively noisy
the different types of stressors—events, structural cir- neighborhoods do not, in general, exhibit the same ele-
cumstances, or daily routines—is needed to understand vated stress responses to noise as those that do not. That
possible pathways to poor health [7]. For example, prior is, individuals may become habituated to or learn to alter
studies often have found limited or conflicting evidence their perceptions of such chronically stressful environ-
about the nature of the relationship between cortisol and ments [13], although resident selection factors may also
socioeconomic status [7]. McEwen and colleagues pro- be at work, at least to some extent (e.g., individuals who
posed a broad framework for measuring chronic stress are particularly sensitive to high noise levels may move
that included a set of ten biometric markers, includ- out of or avoid such neighborhoods) [14–19]. Based
ing cortisol, a steroid hormone produced as part of the on such research, studies aimed at investigating physi-
body’s stress response. Called “allostatic load” (AL), the ological responses to stress in differing environments
measure was intended as a proxy measure for overall are challenged to integrate perception-based measures
“wear and tear” on the body’s stress response systems within their built environment assessments. For example,
[1]. Other researchers have found relationships between Aspinall et al. [11] also asked participants to rate scenes
AL and adverse mental and behavioral health outcomes, across several subjective criteria (e.g., pleasure/displeas-
including cognition [2, 8]. ure, calm/excitement), adding a dimension of personal
The concept of allostatic load has been applied to preference and underlying attitudes toward certain types
chronic environmental stressors, especially those related of built environments.
to workplace or neighborhood environments [8, 9]. One relatively untested arena that may help us under-
Theall et al. [8] found that a significant amount of AL stand both individual characteristics and perceptions
variance among adolescents in the National Health that matter for chronic stress is the quantified self. This
and Nutrition Examination Survey was attributable to sensor-oriented movement encompasses a range of self-
neighborhood-level factors, such as poverty, crime, and monitoring technologies, especially those that can be
density of alcohol retailers, even after controlling for integrated into smartphones as mobile applications [20].
household-level characteristics. While biomarkers such Users typically collect and review biometric (e.g., weight,

Chrisinger and King Int J Health Geogr (2018) 17:17 Page 3 of 13
heart rate) and/or behavioral (e.g., diet, sleep, exercise) inspection and interpretation, with some possible appli-
data out of curiosity or an interest in self-improvement cations for future testing with additional spatial data.
[20–22]. While quantified self applications may focus on The primary goals of this pilot study were to: (1) test
individual or group-level changes in behavior through the feasibility of including biometric data collection via
biofeedback or goal-setting, there is great potential to wrist-worn sensors as part of the objective and perceived
develop relevant insights on population-level outcomes built environment data collection capabilities of the Dis-
given sufficiently large datasets [23, 24]. For instance, a covery Tool mobile app being employed to obtain resi-
recent smartphone-derived “big data” study found city- dent-collected information on local built environments;
level correlations between objective walkability metrics (2) test the acceptability of different biometric data visu-
and device-based walking outcomes measured from over alization styles; and (3) explore possible options for test-
700,000 smartphone users across 111 countries [24]. ing relationships between documented elements of the
Aside from proprietary wearable datasets, some uni- built environment and biometric changes/outcomes.
versity-sponsored projects aim to crowd-source place-
Methods
based biometric data. One example is the Personal
Activity Location Monitoring System (PALMS), which Participant recruitment
provides validated tools and methodologies for collecting To be eligible for the study, prospective participants had
geo-located biometric data to track behavior across space to be healthy adult volunteers living in or around San
and time, especially individual and group-level dynam- Francisco, California, and able to complete a relatively
ics of physical activity [25–27]. Another suite of projects easy 20- to 25-min walk. Participants were recruited as
employ “People as Sensors” methodologies that crowd- a convenience sample in San Francisco through the net-
source a variety of objective and perceived data, includ- works of our San Francisco Bay Area community part-
ing biometrics, in order to deliver relevant feedback to ner, an urban planning and design nonprofit called Place
urban designers and planners [28–30]. For example, Zeile Lab, and through members of the research team. Walk
and colleagues used a biosensor-oriented approach to appointments were scheduled for one of two days in July
track how and why stress responses changed over space and September 2017.
and time among a cohort of bicyclists in Cambridge,
Massachusetts. Importantly, they found participants’ Biometric sensor
mapped stress data corresponded to individual experi- A wrist-worn biometric sensor, the Empatica E4, was
ences, as measured with video recordings [30]. selected for this study because it provides a commercially
Our pilot study builds upon earlier biometric built available, easy-to-use means of continuously collecting
environment assessments by integrating dimensions of time-stamped biometric data, including stress response
the quantified self movement. First, we utilized a biom- and other possible measures that could be used in sub-
etric measure of stress involving electrodermal activity sequent feature identification algorithms. Data collected
(EDA), which has been shown to be an effective means of by the E4 include 3-axis accelerometry (which measures
differentiating between different kinds of stress environ- gravitational force on three spatial dimensions, allow-
ments and situations (e.g., driving in traffic vs. highway ing for a three-dimensional understanding of participant
driving), and can be collected with relatively low impact movement), skin temperature, blood volume pressure,
on participant experience compared to head- or chest- heart rate, heartbeat inter-beat interval, and electroder-
worn devices [31]. Second, we embedded our biomet- mal activity (EDA). Once participants signed the study
ric data collection within an existing successful “citizen consent form, which was approved by the Stanford Uni-
science”-based community activation model, called “Our versity Institutional Review Board, they were asked to
Voice”, which includes a mobile application, referred to put on and activate the sensor, which they wore during
as the “Discovery Tool,” that allows community members a 10-min pre-walk period. The purpose of this approxi-
to collect objective and perceived neighborhood data mately 10-min pre-walk data collection was two-fold: (1)
[32, 33], providing a systematic and technology-assisted to allow for the sensor to make appropriate contact with
enhancement to existing community-based qualitative the skin surface, and (2) to collect baseline electrodermal
research methods, such as Photovoice [34, 35]. By creat- activity data for subsequent data analysis.
ing a simple and reliable method of collecting geolocated
stress data while participants use the Discovery Tool in Mobile built environment audit tool application
the field, we aim to amplify the known strengths of this This investigation was intended to determine the initial
type of citizen science model. Finally, we introduce open- feasibility and utility of adding biometric sensor data to
source methods for visualizing and sharing perceived the built environment data collected with the DT app,
and objective participant data with participants for their which is typically embedded within a broader citizen

Chrisinger and King Int J Health Geogr (2018) 17:17 Page 4 of 13
science community engagement research method called and tablet (if borrowed) to the investigators. Five groups
Our Voice. This method has been used successfully to participated over two separate days in August and Octo-
study built and social environments in a variety of set- ber 2017, and group sizes ranged from one to four par-
tings [32], and features the simple DT mobile application ticipants, depending on participant availability.
to capture photos, audio narratives, and participant- Application stability issues related to the large quan-
assigned valences for the specific built environment tity of photos and audio recordings taken by some par-
elements being captured (“Is this [built environment ele- ticipants caused the DT app images from several walks
ment] good or bad for the community?”). The DT app (n 6) to be lost, though for two walks where audio files
=
also captures the geocoordinates of the user’s walking were recovered, the research team was able re-create the
route and a short demographic survey upon completion image in Google Street View by using the approximate
of a walk. It additionally collects latitude and longitude location and subject being described in the audio file.
coordinates every second while participants use it, and all For one of the participants without photo/audio data, the
photos taken with the app has geo-coordinates embedded research team was also unable to recover biometric data.
in their metadata. A web portal for viewing DT partici- Biometric data were successfully downloaded and pro-
pant data allows the research team to download sum- cessed for the remaining participants (n 13).
=
mary data for each walk, including the walk route and
locations of all photos and audio recordings. The full Our Data processing
Voice process (not included in this pilot study) involves Each participant’s EDA data were normalized by sub-
collection of geo-tagged photos and audio narratives with tracting the minimum value and dividing by the range
the DT mobile app, followed by facilitated community from their baseline data values, consistent with prior
meetings to identify shared themes and build community research using EDA data from the Empatica E4 biosensor
consensus, in partnership with identified stakeholders, [31]. To assist with comparisons between participants,
around how to address environmental issues negatively each participant’s normalized EDA data were also cen-
impacting resident health and well-being and [32, 33, tered (subtracting the mean) and scaled (dividing by the
36–39]. standard deviation of the centered data). To help identify
Depending on their preference, participants down- sudden changes, or “peaks,” in EDA, a proprietary algo-
loaded the DT from the Apple App Store or Google Play rithm from the company was applied to help remove
Store [40, 41], or used electronic tablets (Samsung Gal- erroneous readings, or “noise,” possibly caused by sudden
axy Tab E Lite 7”) that were made available to them and motions or other non-EDA-related issues with the sensor.
already contained the required DT app [42]. Participants Skin temperature, 3-axis accelerometry, and EDA data
were verbally instructed on how to use the DT app, and files were provided as algorithm inputs; outputs included
prompted to take photos and describe aspects of this time-stamped peaks in EDA with characteristics such as
neighborhood environment that they felt influenced their peak amplitude and wavelengths.
well-being or the functioning of these public spaces. Simple text processing was performed on participant
audio narrative transcriptions using functions from the
Neighborhood walks tm (“text mining”) package in R. To prepare the text for
Based on our community partner’s interest in existing review, all letters were shifted to lowercase, very com-
and future public space projects in a specific neighbor- mon words were removed, and a word frequency table
hood of San Francisco, California, an approximately was generated [43, 44]. This table was further grouped by
20-min walking route (0.9 miles) was predetermined nouns and adjectives, and words with a frequency greater
to take participants through a variety of different envi- than five were included in a visualization to compare the
ronments, including a small public green space, back most prevalent terms across all participants.
alleys, and busy commercial streets. Participants were
instructed to document anything along the route that Data visualization
they believed influenced their well-being or the function- Visualizations of each individual participant’s walking
ing of these public spaces. A researcher accompanied route while using the DT app were generated with leaf-
groups of up to four participants at a time to direct them let, an open-source JavaScript visualization library, which
along the route and help troubleshoot any difficulties we deployed within the R software environment [45–47].
with the app or wearable sensor. Participants were also Markers indicating the location of photos/audio narra-
encouraged not to talk to one another during the neigh- tives taken were added to these maps, and two-dimen-
borhood walks. Following the neighborhood walk, partic- sional binned kernel density estimates were calculated to
ipants completed a short demographic survey embedded visualize clusters of positive and negative photos (using
within the DT app, and returned the biometric sensor the bkde2D function of the KernSmooth package) [48,

Chrisinger and King Int J Health Geogr (2018) 17:17 Page 5 of 13
49]. The walking route was color-coded by participants’ highly-clustered cell, location within 10 m of a street
relative EDA levels during their walk, with peaks illus- intersection, one/two-way traffic pattern and classifi-
trated as additional markers of sizes according to their cation of street, land use of the nearest parcel, age of
amplitude. These web-based visualizations were shared building on the nearest parcel, and the observation’s
with participants via email, and their feedback was solic- time during the walk. A random intercept was specified
ited with an open-ended web-based survey. Interactive to account for grouping of the study design: biometric
data maps were generated for participant feedback, but observations within individuals (14 participants) within
were not specifically analyzed as part of this study. These groups (5 walk groups). To illustrate possible within-sub-
maps allowed participants to (1) reflect on data collected ject variations, simple linear regression models were fit
during the neighborhood walk; (2) see how EDA levels for three participants for EDA outcomes and whether the
changed over the course of the walk in relation to objec- observation was taken in positive or negative DT cluster.
tive neighborhood features (e.g., basemap and DT app
photos); and 3) compare their data to other participants
along the same route. An example data map is shown in Results
Fig. 1, and an interactive example is provided as Addi- In total, 14 adults (8 women and 6 men) who lived in the
tional file 1. San Francisco Bay Area were recruited to participate as
a convenience sample. Participants recorded 181 images
Spatial and statistical analyses (mean 15.1, SD 8.4) and 146 audio files (mean 12.2, SD
8.6) with the DT app, and 5416 geo-located biometric
The database underlying the participant walk map visu-
data observations were collected from 13 participants
alizations described above was imported to a geographic
(approximately 416 observations per participant). Fig-
information system software, ArcMap 10.5.1 [50], where
ure 2 illustrates the spatial distribution of photographs
a variety of spatial data (listed below) from the City of
taken with the DT app by the positive/negative valence
San Francisco had been pre-assembled [51, 52]. Spatial
assigned by participants for the built environment fea-
joins were performed to assign each walking route GPS
tures being captured.
coordinate several fields from these local data, in addi-
Among captured images that were tagged with a partic-
tion to the biometric data used in the visualizations:
ipant-coded valence (n 131), just over half were positive
distance to the nearest positive- and negative-rated DT =
(n 77). Within-participant positive/negative valence
photo, distance to the nearest street intersection (as pos- =
ratios were similar, with most participants rating 53.0% of
sible points of interest in terms of high traffic/activity),
their images as positive (SD 21.4%). The average distance
parcel characteristics (e.g., current land use, age of build-
to a positive DT photo during a walk was 11.9 m, while
ings), and street characteristics (e.g., name, one/two-way
the average distance to a negative photo was 14.7 m. In
traffic pattern, classification as a highway, major, second-
terms of the narratives participants used to explain their
ary, or local street).
photographs in the DT app, several words were repeated
In addition to summary statistics of participants’ EDA
frequently. The most common nouns used by partici-
data by different spatial characteristics, two additional
pants in their audio narratives included “street” (n 35),
analyses were performed. First, the significance of spa- =
“building” (n 29), and “people” (n 25), while “nice”
tial clustering of positive and negative DT photos was = =
(n 22), “safe” (n 11), and “good” (n 10) were the
assessed with the Optimized Hot Spot Analysis tool, = = =
most common adjectives. Figure 3 provides a visualiza-
which calculates the Getis-Ord Gi* local statistic (Gi*),
tion of all nouns and adjectives used by participants with
a standardized measure of clustering for specified areal
an overall frequency greater than five.
units (here, set as 5-m grid cells along the walk path)
Based on the Getis-Ord Gi* local statistic (estimated
[53–55]. For this pilot, the top quintile of Gi* statistics
at a 95% confidence level), two significant clusters of
were selected as the most highly clustered cells; this pro-
positive DT photos comprised approximately 4.3% of
cedure was performed separately for positive and nega-
the walk route (by distance), while negative photo clus-
tive DT photos. A subsequent spatial join between these
ters represented 2.7% of the route, also in two significant
highly clustered cells and the participant walk data cre-
clusters. Both of the significant positive clusters occurred
ated a binary variable for observations inside or outside
within the first half of the walk route, and both significant
of a clustered cell.
negative clusters occurred within the second half, though
Second, a linear mixed model was fit on geo-located
both negative and positive DT photos were taken on all
biometric data observations using R (via lmer in the lme4
except one street during the course of the walk. Table 1
package) to identify associations between the main out-
summarizes the frequency of walk observations by a vari-
come, participant EDA, with contextual walk measures
ety of environmental characteristics, including presence
as fixed effects [56, 57]: location inside or outside of a

Chrisinger and King Int J Health Geogr (2018) 17:17 Page 6 of 13
Fig. 1 Example of an interactive webpage built for participants to view and interpret their data. The red and blue markers show where this specific
participant took photographs with the DT app. The participant’s path is color-coded by their EDA level, from dark purple to yellow (low to high). The
complete html file and underlying R code has been uploaded as Additional files 1 and 2
inside of a positive or negative cluster, and Fig. 4 displays older buildings seeing higher observations, compared to
summary statistics for electrodermal activity across these the most recent buildings. All models, 95% confidence
characteristics. intervals, and coefficients are displayed in Table 2.
Based on the linear mixed model, statistically signifi- Exploratory linear regression models for three indi-
cant positive associations were found between partici- vidual participants also showed significant relationships
pant EDA and positive photo clusters (B 0.14, p < 0.001), for presence in a positive or negative DT photo cluster,
=
and significant negative associations were found between though they were of varying magnitudes and directions
participant EDA and negative photo clusters (B 0.17, (see Table 3). Additionally, these regressions indicated
=−
p < 0.001). This suggests that, on average, participants’ that positive and negative clusters had far better explana-
EDA was higher in areas where many participants docu- tory value for some participants’ EDA than for others
mented more favorable features of the environment, and (e.g., R2 0.076 for Participant A3, vs. R2 0.263 for Par-
= =
lower in areas where they documented less favorable fea- ticipant B3).
tures. Other significant associations between EDA and
Discussion
walk characteristics were also observed, including the
street type (significantly lower for highway, major, and In this first-generation pilot investigation, we success-
secondary streets compared to local streets, p < 0.001), fully assembled diverse technologies to collect and visu-
and land uses compared to parcels designated as “open alize objective, perceived, and biometric data in an urban
space” (significantly higher near mixed/residential neighborhood context. These data collection methods
[p < 0.001] and residential [p 0.033]; significantly lower provide researchers with a means of investigating both
=
near office [p 0.003] and vacant buildings [p < 0.001]). group and individual-level responses to different envi-
=
The age of buildings also was associated with EDA, with ronmental conditions.

Chrisinger and King Int J Health Geogr (2018) 17:17 Page 7 of 13
+ Density of All Positive and Negative Photos
− from the Discovery Tool App
Discovery Tool
Photos
Positive
Negative
Unknown
Significant Cluster
N
BBllaack & White
OOppen Street Map
SSaattellite N
PPoositive Clusters 100 meters
NNeegative Clusters
SSiiggnificant Clusters
WWaalk Path
DDiisscovery Tool Data 100 meters
Leaflet | Tiles © Esri — Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community
Fig. 2 Heat map of positive and negatively-rated photographs taken with the DT app. Colors indicate if clusters of photographs were rated as
positive (blue shading) and negative (red shading) by participants using the DT app. Darker shading indicates a higher density, and yellow cells
indicate clustering of positive/negative photos per the Getis-Ord Gi* local statistic (top quintile)
In the case of the urban neighborhood walked by our document similar built environment features, this did
participants, common perceptions of the built envi- not mean that their interpretations were identical. For
ronment were observed, both in terms of the repeated example, as shown in Fig. 5, two participants on the same
terms captured in DT narratives and the significant walk captured images of a particular intersection that
clustering of positive and negative DT photos. At the did not allow pedestrians to cross on all sides. For one
group level, linear mixed model testing confirmed that participant, this represented a barrier, while the other
the average participant EDA levels observed inside a rated it as a positive feature. While this was not a com-
positive cluster were significantly higher than those mon occurrence, it is possible that future studies with
observed elsewhere on the walk. Conversely, EDA additional participants, better measures of participant
observations inside negative DT photo clusters were demographics (e.g., age, gender, length of residence in/
significantly lower than those from outside them. Fur- around the city, etc.) or a focus on a narrower geographic
ther exploration is needed to understand the dimen- area will find similar discrepancies between individual
sions of this relationship, though these preliminary assessments of the same feature. Furthermore, as Table 3
statistical associations suggest that participants’ rat- illustrated, the strength of the relationship between EDA
ings of the built environment were reflected in their and participant-rated DT photos may not be consistent
stress responses. Additionally, significant correlations across all participants. Ultimately, this example under-
between objective measures of the built environment, scores the importance of combining both objective and
such as land use and street type, and EDA also high- perceived built environment information in assessments.
light potentially influential relationships that could be
more carefully tested with additional participant walks. Limitations
These data also illustrated the value of multi-dimen- Another study limitation was the small number of resi-
sional measurement at individual and group levels. While dents included in this initial feasibility study to develop
at least some participants may have been motivated to a systematic process for collecting and analyzing diverse

Chrisinger and King Int J Health Geogr (2018) 17:17 Page 8 of 13
Fig. 3 Visualization of nouns and adjectives with an overall frequency greater than five in all audio narratives
types of data geo-located data. Though the participant thematic saturation when identifying positive and nega-
sample is small, these individuals produced a relatively tive features of a particular built environment [32]. Addi-
large database of qualitative data in terms of photo tionally, the fine-grained biometric data collection adds
(n 181) and audio narratives (n 146). Similar studies thousands of additional data points in which these photos
= =
using the Discovery Tool application have found even and audio narratives can be contextualized. The methods
small groups of participants (e.g., 8–10) are able to reach we have described are easily scalable to accommodate

Chrisinger and King Int J Health Geogr (2018) 17:17 Page 9 of 13
Table 1 Summary of walk observations by environmental likely—and was observed by some participants—that
characteristics individuals felt more inclined to take photographs when
n obs. % Total obs. they observed others in their group doing so. One par-
ticipant described this circumstance in an audio narra-
DT clusters
tive about a small church building along the route: “I find
Inside positive 1122 21
that when the person I’m on a walk with takes a photo of
Inside negative 1107 20
something, I want to take a photo of the same thing. But
Street features
it’s true, this blue building is pretty excellent” (see Addi-
Intersection 416 8
tional file 3).
One-way 3608 67
Another methodological question relates to the use
Two-way 1804 33
of the Empatica E4 sensor. While we used a 10-min
Local 2182 40
pre-walk period to obtain a reasonable baseline meas-
Secondary 155 3
urement, it is possible that longer time periods or data
Major 2619 48
collected under different circumstances (e.g., walk-
Highway 456 8
ing vs. standing or sitting) may yield more complete
Land use
or interpretable measures for participants outside of
Open space 315 6 laboratory environments. Other researchers using
Culture/education 357 7 the Empatica sensor may find additional utility in the
Mixed use 312 6 multi-dimensional data it creates to identify “signals”
Mixed use/residential 1241 23 within the EDA data, versus “noise” possibly caused by
Office 1716 32 a participant’s motions, perspiration due to exertion, or
Industrial 329 6 other factors. The availability of such resources as the
Residential 514 9 “EDA Explorer,” which integrates the sensor’s 3-axis
Retail/entertainment 248 5 accelerometry, skin temperature, and EDA data to more
Vacant 286 5 precisely estimate EDA changes, suggest that device
Building age developers are considering the implications of collect-
Post-1976 1604 30 ing electrodermal data in ambulatory settings, perhaps
1951–1975 196 4 a sign of future guidance on this topic [58, 59].
1926–1950 1261 23 The neighborhood walk route was also the subject
Pre-1925 1737 32 of methodological deliberations. While having partici-
pants walk the same route allowed for a more direct
comparison between participants’ DT app and biom-
etric data, it also imposed a relatively arbitrary con-
many more participants, should future researchers desire
straint on what has often been a more free-form built
to integrate them into crowd-sourcing initiatives, as in
environment assessment in other Our Voice projects
other quantified self projects [27].
[32]. Additionally, this pilot study allowed participants
In terms of logistical challenges, we encountered issues
to investigate a variety of urban spaces, though future
with mobile app stability during some walks because of
iterations may pursue a more in-depth exploration of a
the amount of image/audio data being collected, which
single, specific space, such as a park or plaza. Quanti-
resulted in the loss of photo and audio data for some
fied self researchers may also find utility in collecting
participants. Our research team was able to retrieve or
individual geo-tagged biometric stress data over several
recreate some photos with Google Street View, and par-
hours or days in future “n-of-1” studies or interventions
ticipant experiences informed subsequent developer
[60]. Importantly, the method described here is suffi-
updates to the DT app (e.g., enabling reliable capture of
ciently flexible to be tailored to the research questions
larger quantities of images and audio narratives) along
of new projects, but provides key capabilities for col-
with an accompanying troubleshooting guide for new
lecting and visualizing different kinds of objective and
users.
perceived participant data.
Several methodological questions were also raised dur-
Ultimately, the questions raised during the study
ing the course of the pilot, and should be considered in
may also prompt deeper qualitative analyses. As a par-
future research. First, the potential effects of having par-
ticipant eloquently summarized in one of her audio
ticipants walk in groups, as undertaken in this study, ver-
narratives:
sus independently, are worth further consideration. It is

Chrisinger and King  Int J Health Geogr  (2018) 17:17  Page 10 of 13
|     |     |     |     |     |     |     | Table 2 Linear  |     | mixed  | model  | of  | participant  | EDA  |
| --- | --- | --- | --- | --- | --- | --- | --------------- | --- | ------ | ------ | --- | ------------ | ---- |
Participant EDA Characteristics in
|     |     |     |     |     |     |     | observations  |     | with  | group  and  | participant-level  |     | random  |
| --- | --- | --- | --- | --- | --- | --- | ------------- | --- | ----- | ----------- | ------------------ | --- | ------- |
Different Walk Environments
intercepts
|     |     | Mean  |     | Median  |     |     |     |     |     |     |     |     |     |
| --- | --- | ----- | --- | ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Electrodermal activity (EDA)
| DT        |     |           | Positive  |     |     |     |     |     |     |     |     |     |     |
| --------- | --- | --------- | --------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Clusters  |     | Negative  |           |     |     |     |     |     |     | B   | CI  |     | p   |
Intersection
Fixed parts
1.Local_Street
|     | 2.Secondary_Street  |     |     |     |     |     | Time on walk |     |     | 0.20 | 0.17 to 0.24 |     | < .001 |
| --- | ------------------- | --- | --- | --- | --- | --- | ------------ | --- | --- | ---- | ------------ | --- | ------ |
Street  3.Major_Street  Positive photo cluster 0.14 0.06 to 0.23 < .001
Features
4.Highway
|     |     |         |     |     |     |     | Negative photo cluster   |     |     |  0.17 |  0.25 to      |  0.09 | < .001 |
| --- | --- | ------- | --- | --- | --- | --- | ------------------------ | --- | --- | ----- | ------------- | ----- | ------ |
|     |     | One-Way |     |     |     |     |                          |     |     | −     | −             | −     |        |
|     |     |         |     |     |     |     | Intersection             |     |     | 0.05  |  0.04 to 0.15 |       | .284   |
|     |     | Two-Way |     |     |     |     |                          |     |     |       | −             |       |        |
|     |     |         |     |     |     |     | 2-way street (ref:1-way) |     |     | 0.15  | 0.07 to 0.23  |       | < .001 |
1.Open Space
|     | 2.Culture/Education  |              |     |     |     |     | Street type (ref:Local) |     |     |       |           |       |        |
| --- | -------------------- | ------------ | --- | --- | --- | --- | ----------------------- | --- | --- | ----- | --------- | ----- | ------ |
|     |                      | 3.Mixed Use  |     |     |     |     | Secondary               |     |     |  0.49 |  0.72 to  |  0.27 | < .001 |
|     |                      |              |     |     |     |     |                         |     |     | −     | −         | −     |        |
4.Mixed Use/Resid.
|        |     |               |           |     |     |     | Major   |     |     |  0.17 |  0.24 to  |  0.11 | < .001 |
| ------ | --- | ------------- | --------- | --- | --- | --- | ------- | --- | --- | ----- | --------- | ----- | ------ |
| Land   |     |               | 5.Office  |     |     |     |         |     |     | −     | −         | −     |        |
| use    |     |               |           |     |     |     | Highway |     |     |  0.47 |  0.61 to  |  0.34 | < .001 |
|        |     | 6.Industrial  |           |     |     |     |         |     |     | −     | −         | −     |        |
Land use (ref: open space)
7.Residential
|            |     |                      |     |     |     |       | Cultural             |     |     |  0.11 |  0.31 to 0.08 |       | .244   |
| ---------- | --- | -------------------- | --- | --- | --- | ----- | -------------------- | --- | --- | ----- | ------------- | ----- | ------ |
|            |     | 8.Retail/Entertain.  |     |     |     |       |                      |     |     | −     | −             |       |        |
|            |     |                      |     |     |     |       | Mixed                |     |     | 0.10  |  0.11 to 0.30 |       | .365   |
|            |     | 9.Vacant             |     |     |     |       |                      |     |     |       | −             |       |        |
|            |     | 1.Post-1976          |     |     |     |       | Mixed/residential    |     |     | 0.29  | 0.12 to 0.47  |       | < .001 |
| Building   |     | 2.1951-1975          |     |     |     |       | Office               |     |     |  0.24 |  0.40 to      |  0.08 | .003   |
|            |     |                      |     |     |     |       |                      |     |     | −     | −             | −     |        |
| Year       |     | 3.1926-1950          |     |     |     |       |                      |     |     |       |               |       |        |
|            |     |                      |     |     |     |       | Industrial           |     |     | 0.09  |  0.09 to 0.28 |       | .329   |
|            |     | 4.Pre-1925           |     |     |     |       |                      |     |     |       | −             |       |        |
|            |     |                      | -2  | -1  | 0   | 1  2  | Residential          |     |     | 0.18  | 0.01 to 0.35  |       | .033   |
|            |     |                      |     |     |     |       | Retail/entertainment |     |     | 0.01  |  0.18 to 0.20 |       | .924   |
Electrodermal Activity (EDA)
−
|     |     |     |     |     |     |     | Vacant |     |     |  0.38 |  0.55 to  |  0.21 | < .001 |
| --- | --- | --- | --- | --- | --- | --- | ------ | --- | --- | ----- | --------- | ----- | ------ |
Fig. 4 Average and median EDA level observed by different walk  − − −
|                                     |     |     |     |     |     |     | Missing |     |     |  0.08 |  0.32 to 0.16 |     | .498 |
| ----------------------------------- | --- | --- | --- | --- | --- | --- | ------- | --- | --- | ----- | ------------- | --- | ---- |
| environments (SD shown in brackets) |     |     |     |     |     |     |         |     |     | −     | −             |     |      |
Building age (ref: 1976–present)
|     |     |     |     |     |     |     | 1951–1975 |     |     | 0.15 |  0.03 to 0.33 |     | .107 |
| --- | --- | --- | --- | --- | --- | --- | --------- | --- | --- | ---- | ------------- | --- | ---- |
−
|     |     |     |     |     |     |     | 1926–1950 |     |     | 0.10 | 0.01 to 0.18 |     | .030 |
| --- | --- | --- | --- | --- | --- | --- | --------- | --- | --- | ---- | ------------ | --- | ---- |
There’s this interesting dichotomy that I don’t know
|     |     |     |     |     |     |     | Pre-1925 |     |     | 0.09 | 0.02 to 0.17 |     | .011 |
| --- | --- | --- | --- | --- | --- | --- | -------- | --- | --- | ---- | ------------ | --- | ---- |
how to express in a photograph which is the pleas-
|     |     |     |     |     |     |     | Unknown |     |     | 0.32 | 0.16 to 0.48 |     | < .001 |
| --- | --- | --- | --- | --- | --- | --- | ------- | --- | --- | ---- | ------------ | --- | ------ |
ure of being in a complex urban environment bal-
anced with a serenity and beauty. Both are pleas- (Intercept) 0.01  0.19 to 0.20 .932
−
Random parts
ing, one is more intense which maybe might make
 σ2
| you…                                                 | maybe  | my  | biometrics  | feel  | aggravated  | or  |                         |     |     | 0.854 |     |     |     |
| ---------------------------------------------------- | ------ | --- | ----------- | ----- | ----------- | --- | ----------------------- | --- | --- | ----- | --- | --- | --- |
|                                                      |        |     |             |       |             |     |  N                      |     |     | 14    |     |     |     |
| disoriented in some ways but that is one of the rea- |        |     |             |       |             |     | partid:(partgroup:time) |     |     |       |     |     |     |
|                                                      |        |     |             |       |             |     |  N                      |     |     | 5     |     |     |     |
| sons we love cities so we should not optimize out a  |        |     |             |       |             |     | partgroup:time          |     |     |       |     |     |     |
| sense of complexity and chaos because that too is    |        |     |             |       |             |     |  N                      |     |     | 2     |     |     |     |
time
|     |     |     |     |     |     |     |  Observations |     |     | 5412 |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------------- | --- | --- | ---- | --- | --- | --- |
beautiful.
R2/Ω2
|     |     |     |     |     |     |     | 0   |     |     | .119/.119 |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --------- | --- | --- | --- |
Italic values are significant at p < 0.05
Table 3 Linear models of participant EDA observations showing within-subject correlations with positive/negative DT
clusters
|     |     | Participant A3 |     |     |     | Participant B3 |     |     |     | Participant E3 |     |     |     |
| --- | --- | -------------- | --- | --- | --- | -------------- | --- | --- | --- | -------------- | --- | --- | --- |
|     |     | B              | CI  |     | p   | B              | CI  |     | p   | B              | CI  |     | p   |
(Intercept) 0.03  0.11 to 0.16 .680  0.23  0.35 to   0.11 < .001 0.30 0.18 to 0.42 < .001
|     |     |     | −   |     |     | −   | −   | −   |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Positive cluster 0.35 0.10 to 0.60 .007 1.15 0.93 to 1.38 < .001  0.50  0.74 to   0.26 < .001
|     |     |     |     |     |     |     |     |     |     | −   | −   | −   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Negative cluster  0.47  0.71 to   0.22 < .001  0.17  0.40 to 0.06 .147  1.00  1.22 to   0.77 < .001
|              |     | −         | −   | −   |     | −         | −   |     |     | −         | −   | −   |     |
| ------------ | --- | --------- | --- | --- | --- | --------- | --- | --- | --- | --------- | --- | --- | --- |
| Observations |     | 362       |     |     |     | 347       |     |     |     | 397       |     |     |     |
| R2/adj.  R2  |     | .076/.071 |     |     |     | .263/.259 |     |     |     | .164/.159 |     |     |     |
Italic values are significant at p < 0.05

Chrisinger and King Int J Health Geogr (2018) 17:17 Page 11 of 13
Fig. 5 Participant data maps. While these two participants also documented the same feature, they gave it different ratings and descriptions in
terms of it being a positive or negative aspect of the built environment
These pilot data provide a starting point for research- biometric data are also of interest to community mem-
ers and citizen scientists to “triangulate” between the bers, and our open-source mapping technology (R code
objective, perceived, and embodied experiences of provided as Additional file 2) allows for easier replica-
built environment spaces in ways that could lead to tion in different settings and projects. It sets the stage
new insights, including the beauty of “complexity and for additional research aimed at better understanding—
chaos.” both qualitatively and quantitatively—how objective
and perceived elements of the built environment influ-
ence our “lived” experience in different settings, which
Conclusion may impact people’s stress as well as well-being and
Identifying elements of one’s environment—both quality of life.
observable and unobservable—that contribute to allo-
Additional files
static load presents new opportunities to engage com-
munity residents in collecting and analyzing their
Additional file 1. Interactive Data Map. Geospatial visualization of partici-
personal data to mobilize potential environmental
pant data as an html file, suitable for viewing in a web browser.
improvements. The current investigation provides a
Additional file 2. R code. Sample R code for processing and visualizing
systematic process of collecting these three types of participant Discovery Tool and biometric data.
data, and lays a foundation for future spatial and statis-
Additional file 3. Example participant data maps. These two participants
tical analyses in addition to more in-depth interpreta- were on the same walk and took photographs of the same building. One
tion of how these responses vary within and between (at right) observed that they noticed this influence: “I find that when the
person I’m on a walk with takes a photo of something, I want to take a
participants. This type of multi-dimensional data col-
photo of the same thing. But it’s true, this blue building is pretty excellent.”
lection procedure could be integrated into future built
environment or quantified self research projects where

Chrisinger and King Int J Health Geogr (2018) 17:17 Page 12 of 13
Abbreviations Publisher’s Note
AL: allostatic load; DT: Discovery Tool; EDA: electrodermal activity; EEG: electro- Springer Nature remains neutral with regard to jurisdictional claims in pub-
encephalogram; SD: standard deviation. lished maps and institutional affiliations.
Received: 29 January 2018 Accepted: 1 June 2018
Authors’ information
Benjamin W. Chrisinger, Ph.D. is a Postdoctoral Research Fellow with the
Stanford Prevention Research Center. With a background in urban planning
and environmental sciences, Dr. Chrisinger uses his research to explore con-
nections between the built environment and human health, especially health References
disparities. Abby C. King, Ph.D. is a Professor of Health Research and Policy 1. McEwen BS, Stellar E. Stress and the individual: mechanisms leading to
and of Medicine with the Stanford University School of Medicine. Dr. King is disease. Arch Intern Med. 1993;153:2093–101.
a Recipient of the Outstanding Scientific Contributions in Health Psychology 2. Juster R-P, McEwen BS, Lupien SJ. Allostatic load biomarkers of chronic
Award from the American Psychological Association. Her research focuses on stress and impact on health and cognition. Neurosci Biobehav Rev.
the development, evaluation, and translation of public health interventions 2010;35:2–16.
to reduce chronic disease. These research directions include expanding the 3. Lovallo WR. Stress and health: biological and psychological interactions.
reach and generalizability of evidence-based interventions through use of Thousand Oaks: SAGE Publications; 2015.
state-of-the-art communication technologies, community-based participa- 4. McCormack GR, Shiell A. In search of causality: a systematic review of the
tory research perspectives to address health disparities among disadvantaged relationship between the built environment and physical activity among
populations, and citizen science and policy-level approaches to health adults. Int J Behav Nutr Phys Act. 2011;8:125.
promotion. 5. Drewnowski A, Aggarwal A, Tang W, Hurvitz PM, Scully J, Stewart O, et al.
Obesity, diet quality, physical activity, and the built environment: the
Author details need for behavioral pathways. BMC Public Health. 2016;16:1153.
1 Stanford Prevention Research Center, Department of Medicine, School 6. Juarez PD, Matthews-Juarez P, Hood DB, Im W, Levine RS, Kilbourne BJ,
of Medicine, Stanford University, 1070 Arastradero Road, Suite 100, Palo Alto, et al. The public health exposome: a population-based, exposure science
CA 94304, USA. 2 Department of Health Research and Policy, School of Medi- approach to health disparities research. Int J Environ Res Public Health.
cine, Stanford University, Palo Alto, USA. 2014;11:12866–95.
7. Dowd JB, Simanek AM, Aiello AE. Socio-economic status, cortisol and allo-
Authors’ contributions static load: a review of the literature. Int J Epidemiol. 2009;38:1297–309.
BC and AK conceptualized and designed the study. BC executed the study 8. Theall KP, Drury SS, Shirtcliff EA. Cumulative neighborhood risk of
and wrote the methodological code, and drafted the manuscript. AK provided psychosocial stress and allostatic load in adolescents. Am J Epidemiol.
detailed feedback on the manuscript. Both authors read and approved the 2012;176:S164–74.
final manuscript. 9. Keene DE, Geronimus AT. “Weathering” HOPE VI: the importance of evalu-
ating the population health impact of public housing demolition and
Acknowledgements displacement. J Urban Health Bull N Y Acad Med. 2011;88:417–35.
The authors would like to acknowledge our community partner, Brooke Ray 10. Roe JJ, Aspinall PA, Mavros P, Coyne R. Engaging the brain: the impact of
Rivera, Executive Director of Place Labs (formerly known as Build Public), for natural versus urban scenes using novel EEG methods in an experimental
her collaborative spirit and assistance in recruiting and engaging participants setting. Environ Sci. 2013;1:93–104.
in this study. We are also grateful to those community members who served 11. Aspinall P, Mavros P, Coyne R, Roe J. The urban brain: analysing outdoor
as citizen scientists for this project. Finally, we would like to acknowledge physical activity with mobile EEG. Br J Sports Med 2013;49:272–6.
several anonymous reviewers who provided constructive and insightful 12. Honold J, Beyer R, Lakes T, van der Meer E. Multiple environmental
feedback. burdens and neighborhood-related health of city residents. J Environ
Psychol. 2012;32:305–17.
Competing interests 13. Hammer MS, Swinburn TK, Neitzel RL. Environmental noise pollution
The authors declare that they have no competing interests. in the United States: developing an effective public health response.
Environ Health Perspect. 2014;122:115–9.
Availability of data and materials 14. Cohen S, Krantz DS, Evans GW, Stokols D. Community noise, behavior,
The datasets used and/or analyzed during the current study are available from and health: the Los Angeles noise project. In: Baum A, Singer JE, editors.
the corresponding author on reasonable request. Adv Environ Psychol [Internet]. Hillsdale, NJ: Erlbaum; 1982. p. 295–317.
http://www.psy.cmu.edu/~scohe n/LAnoi sepro ject.pdf. Accessed 23 Jan
Consent for publication 2018.
As part of our participation consent form, all participants also gave consent for 15. Evans GW, Hygge S, Bullinger M. Chronic noise and psychological stress.
the images, audio transcripts, and other non-identifiable data collected during Psychol Sci. 1995;6:333–8.
this study to be published online (though only non-identifiable participant 16. Paneto GG, de Alvarez CE, Zannin PHT. Relationship between urban noise
information was included in this manuscript). and the health of users of public spaces—a case study in Vitoria, ES,
Brazil. J Build Constr Plan Res. 2017;5:45.
Ethics approval and consent to participate 17. Stansfeld S, Haines M, Brown B. Noise and health in the urban environ-
This study was performed in accordance with the Declaration of Helsinki and ment. Rev Environ Health. 2011;15:43–82.
was approved on June 27, 2017 by the Stanford University Institutional Review 18. Paunović K, Jakovljević B, Belojević G. Predictors of noise annoyance in
Board (Protocol #: 39736, IRB Assurance #: FWA00000935). noisy and quiet urban streets. Sci Total Environ. 2009;407:3707–11.
19. Kono S, Sone T. Residents’ response to environmental and neighborhood
Funding noise. J Sound Vib. 1988;127:573–81.
This work was supported by the Stanford Clinical and Translational Science 20. Swan M. Sensor mania! The internet of things, wearable computing,
Award (CTSA) to Spectrum (UL1 TR001085). The CTSA program is led by the objective metrics, and the quantified self 2.0. J Sens Actuator Netw.
National Center for Advancing Translational Sciences (NCATS) at the National 2012;1:217–53.
Institutes of Health (NIH). The content is solely the responsibility of the authors 21. Whooley M, Ploderer B, Gray K. On the integration of self-tracking data
and does not necessarily represent the official views of the NIH. Dr. Chrisinger amongst quantified self members. In: Proceedings of the 28th interna-
was also supported by an NIH/NHLBI institutional postdoctoral training grant tional BCS human computer interaction conference HCI 2014-Sand Sea
(T32 HL007034). Sky-Holiday HCI. BCS; 2014. p. 151–60.

Chrisinger and King Int J Health Geogr (2018) 17:17 Page 13 of 13
22. Shull PB, Jirattigalachote W, Hunt MA, Cutkosky MR, Delp SL. Quantified 40. Szeto I. Our voice discovery tool [Internet]. Irvin Szeto; 2017. https ://play.
self and human movement: a review on the clinical impact of wearable googl e.com/store /apps/detai ls?id edu.stanf ord.ourvo ice.disco veryt
=
sensing and feedback for gait analysis and intervention. Gait Posture. ool&hl en. Accessed 2 June 2018.
=
2014;40:11–9. 41. Discovery tool our voice on the app store [Internet]. App store. https ://
23. Barrett MA, Humblet O, Hiatt RA, Adler NE. Big data and disease itune s.apple .com/us/app/disco very-tool-our-voice /id117 19357 66?mt 8.
=
prevention: from quantified self to quantified communities. Big Data. Accessed 7 Jan 2018.
2013;1:168–75. 42. Galaxy Tab E Lite 7.0ʺ 8 GB (Wi-Fi) Tablets—SM-T113NDWAXAR | Sam-
24. Althoff T, Sosič R, Hicks JL, King AC, Delp SL, Leskovec J. Large-scale sung US [Internet]. Samsung Electron. Am. http://www.samsu ng.com/us/
physical activity data reveal worldwide activity inequality. Nature. mobil e/table ts/all-other -table ts/samsu ng-galax y-tab-e-lite-7-0-8gb-wi-fi-
2017;547:336. white -sm-t113n dwaxa r/. Accessed 7 Jan 2018.
25. Carlson JA, Jankowska MM, Meseck K, Godbole S, Natarajan L, Raab F, 43. Feinerer I, Hornik K, Artifex Software, Inc. tm: text mining package
et al. Validity of PALMS GPS scoring of active and passive travel compared [Internet]. 2017. https ://cran.r-proje ct.org/web/packa ges/tm/index .html.
to SenseCam. Med Sci Sports Exerc. 2015;47:662–7. Accessed 2 June 2018.
26. Ellis K, Godbole S, Kerr J, Lanckriet G. Multi-sensor physical activity rec- 44. Lang D, Chien G. wordcloud2: create word cloud by “htmlwidget” [Inter-
ognition in free-living. In: Proceedings of ACM international conference net]. 2018. https ://cran.r-proje ct.org/web/packa ges/wordc loud2 /index
ubiquitous computing; 2014. P. 431–40. .html. Accessed 2 June 2018.
27. UCSD-PALMS-Project—home [Internet]. https ://ucsd-palms -proje ct.wikis 45. Cheng J, Karambelkar B, Xie Y, Wickham H, Russell K, Johnson K, et al.
paces .com/. Accessed 24 Apr 2018. Leaflet: create interactive web maps with the JavaScript “Leaflet” Library
28. Resch B. People as sensors and collective sensing-contextual observa- [Internet]. 2017. https ://cran.r-proje ct.org/web/packa ges/leafl et/index
tions complementing geo-sensor network measurements. In: Krisp J, .html. Accessed 8 Jan 2018.
editors. Progress in location-based services. Berlin: Springer; 2013. p. 46. Leaflet for R—introduction [Internet]. https ://rstud io.githu b.io/leafl et/.
391–406. Accessed 15 Mar 2018.
29. Zeile P, Resch B, Exner JP, Sagl G. Urban emotions: benefits and risks 47. Leaflet—an open-source JavaScript library for interactive maps [Internet].
in using human sensory assessment for the extraction of contextual http://leafl etjs.com/. Accessed 15 Mar 2018.
emotion information in urban planning. In: Geertman S, Ferreira Jr. J, 48. Wand M, updates) BR (R port and. KernSmooth: functions for kernel
Goodspeed R, Stillwell J, editors. Planning support systems and smart smoothing supporting Wand & Jones (1995) [Internet]. 2015. https ://
cities. Cham: Springer; 2015. p. 209–25 cran.r-proje ct.org/web/packa ges/KernS mooth /index .html. Accessed 2
30. Zeile P, Resch B, Loidl M, Petutschnig A, Dörrzapf L. Urban emotions and June 2018.
cycling experience—enriching traffic planning for cyclists with human 49. Ruginski I. Visualizing interactive topographic maps using kernel density
sensor data. GI_Forum 2016. 2016;1:204–16. in leaflet [Internet]. 2017. http://www.ianru ginsk i.com/visua lizin gtopo
31. Healey JA, Picard RW. Detecting stress during real-world driving tasks graph icmap s_tutor ial.html. Accessed 25 Jan 2018.
using physiological sensors. IEEE Trans Intell Transp Syst. 2005;6:156–66. 50. ESRI. ArcMap 10.5.1. Redlands, CA: ESRI; 2017.
32. King AC, Winter SJ, Sheats JL, Rosas LG, Buman MP, Salvo D, et al. Leverag- 51. San Francisco Basemap Street Centerlines | DataSF | City and County of
ing citizen science and information technology for population physical San Francisco [Internet]. https ://data.sfgov .org/Geogr aphic -Locat ions-
activity promotion. Transl J Am Coll Sports Med. 2016;1:30–44. and-Bound aries /San-Franc isco-Basem ap-Stree t-Cente rline s/7hfy-8sz8/
33. Buman MP, Winter SJ, Sheats JL, Hekler EB, Otten JJ, Grieco LA, et al. The about . Accessed 2 May 2018.
Stanford Healthy Neighborhood Discovery Tool: a computerized tool to 52. Land Use | DataSF | City and County of San Francisco [Internet]. San Franc.
assess active living environments. Am J Prev Med. 2013;44:e41–7. Data. https ://data.sfgov .org/Housi ng-and-Build ings/Land-Use/us3s-fp9q.
34. Wang CC, Cash JL, Powers LS. Who knows the streets as well as the Accessed 2 May 2018.
homeless? Promoting personal and community action through photo- 53. Getis A, Ord JK. The analysis of spatial association by use of distance
voice. Health Promot Pract. 2000;1:81–9. statistics. Geogr Anal. 1992;24:189–206.
35. Belon AP, Nieuwendyk LM, Vallianatos H, Nykiforuk CIJ. Perceived commu- 54. Ord JK, Getis A. Local spatial autocorrelation statistics: distributional issues
nity environmental influences on eating behaviors: a photovoice analysis. and an application. Geogr Anal. 1995;27:286–306.
Soc Sci Med. 1982;2016(171):18–29. 55. How Hot Spot Analysis (Getis-Ord Gi*) works—ArcGIS Pro | ArcGIS
36. Winter SJ, Rosas LG, Romero PP, Sheats JL, Buman MP, Baker C, et al. Using Desktop [Internet]. http://pro.arcgi s.com/en/pro-app/tool-refer ence/
citizen scientists to gather, analyze, and disseminate information about spati al-stati stics /h-how-hot-spot-analy sis-getis -ord-gi-spati al-stati .htm.
neighborhood features that affect active living. J Immigr Minor Health. Accessed 27 Apr 2018.
2015;18(5):1126–38. 56. Bates D, Mächler M, Bolker B, Walker S. Fitting linear mixed-effects
37. Buman MP, Bertmann F, Hekler EB, Winter SJ, Sheats JL, King AC, et al. A models using lme4. ArXiv14065823 Stat [Internet]. 2014; http://arxiv .org/
qualitative study of shopper experiences at an urban farmers’ market abs/1406.5823. Accessed 2 June 2018.
using the Stanford Healthy Neighborhood Discovery Tool. Public Health 57. Bates D, Mächler M, Bolker B, Walker S. Fitting linear mixed-effects models
Nutr. 2015;18:994–1000. using lme4. J Stat Softw [Internet]; 067. https ://ideas .repec .org/a/jss/jstso
38. Sheats JL, Winter SJ, Romero PP, King AC. FEAST (Food Environment f/v067i 01.html. Accessed 1 Feb 2018.
Assessment using the Stanford Tool): development of a mobile applica- 58. Taylor S, Jaques N, Chen W, Fedor S, Sano A, Picard R. Automatic identifi-
tion to crowdsource resident interactions with the food environment. cation of artifacts in electrodermal activity data. In: EMBC. 2015.
Ann Behav Med. 2014;47:(abstract). 59. EDA Explorer [Internet]. http://eda-explo rer.media .mit.edu/. Accessed 10
39. Chrisinger BW, Ramos A, Shaykis F, Martinez T, Banchoff AW, Winter SJ, Jan 2018.
King AC. Leveraging citizen science for healthier food environments: a 60. Cushing CC, Walters RW, Hoffman L. Aggregated N-of-1 randomized con-
pilot study to evaluate corner stores in Camden, New Jersey. Front Public trolled trials: modern data analytics applied to a clinically valid method of
Health. 2018;6:89. intervention effectiveness. J Pediatr Psychol. 2014;39:138–50.
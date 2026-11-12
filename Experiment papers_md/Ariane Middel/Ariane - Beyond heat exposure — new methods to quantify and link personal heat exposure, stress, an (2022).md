Temperature
ISSN: 2332-8940 (Print) 2332-8959 (Online) Journal homepage: www.tandfonline.com/journals/ktmp20
Beyond heat exposure — new methods to
quantify and link personal heat exposure, stress,
and strain in diverse populations and climates:
The journal Temperature toolbox
Gisel Guzman-Echavarria, Ariane Middel & Jennifer Vanos
To cite this article: Gisel Guzman-Echavarria, Ariane Middel & Jennifer Vanos (2023) Beyond
heat exposure — new methods to quantify and link personal heat exposure, stress, and strain
in diverse populations and climates: The journal Temperature toolbox, Temperature, 10:3,
358-378, DOI: 10.1080/23328940.2022.2149024
To link to this article: https://doi.org/10.1080/23328940.2022.2149024
View supplementary material
Published online: 18 Dec 2022.
Submit your article to this journal
Article views: 3945
View related articles
View Crossmark data
Citing articles: 30 View citing articles
Full Terms & Conditions of access and use can be found at
https://www.tandfonline.com/action/journalInformation?journalCode=ktmp20

TEMPERATURE
2023, VOL. 10, NO. 3, 358–378
https://doi.org/10.1080/23328940.2022.2149024
RESEARCH PAPER
Beyond heat exposure — new methods to quantify and link personal heat
exposure, stress, and strain in diverse populations and climates:
The journal Temperature toolbox
Gisel Guzman-Echavarria a, Ariane Middel b,c, and Jennifer Vanos d
aSchool of Geographical Sciences and Urban Planning, Arizona State University, Tempe, AZ, USA; bSchool of Arts, Media and Engineering,
Arizona State University, Tempe, AZ, USA; cSchool of Computing and Augmented Intelligence, Arizona State University,Tempe, AZ, USA;
dSchool of Sustainability, Arizona State University, Tempe, AZ, USA
ABSTRACT ARTICLE HISTORY
Fine-scale personal heat exposure (PHE) information can help prevent or minimize weather-related Received 04 August 2022
deaths, illnesses, and reduced work productivity. Common methods to estimate heat risk do not Revised 31 Oct 2022
simultaneously account for the intensity, frequency, and duration of thermal exposures, nor do they Accepted 12 November
2022
include inter-individual factors that modify physiological response. This study demonstrates new
whole-body net thermal load estimations to link PHE to heat stress and strain over time. We apply
KEYWORDS
a human-environment heat exchange model to examine how time-varying net thermal loads differ Personal heat exposure;
across climate contexts, personal attributes, and spatiotemporal scales. First, we investigate summer- human heat balance;
time climatic PHE impacts for three US cities: Phoenix, Miami, and New York. Second, we model body partitional calorimetry;
morphology and acclimatization for three profiles (middle-aged male/female; female >65 years). thermal stress; thermal
Finally, we quantify model sensitivity using representative data at synoptic and micro-scales. For all strain; mean radiant
temperature; extreme heat;
cases, we compare required and potential evaporative heat losses that can lead to dangerous thermal
thermal stress index;
exposures based on (un)compensable heat stress. Results reveal misclassifications in heat stress or
situated knowledge
strain due to incomplete environmental data and assumed equivalent physiology and activities
between people. Heat strain is most poorly represented by PHE alone for the elderly, non-
acclimatized, those engaged in strenuous activities, and when negating solar radiation. Moreover,
humid versus dry heat across climates elicits distinct thermal responses from the body. We outline
criteria for inclusive PHE evaluations connecting heat exposure, stress, and strain while using physio-
logical-based methods to avoid misclassifications. This work underlines the value of moving from
“one-size-fits-all” thermal indices to “fit-for-purpose” approaches using personalized information.
GRAPHICAL ABSTRACT
Introduction exposure (PHE) implies evaluating heat exchanges
between people and their micro-environments within
Advancing personal heat research
the spaces they live, work, and play, indoors and out-
Hot weather can lead to a loss of productivity and doors [2]. Numerous studies converge on the need to
heat-related illnesses and deaths, yet these issues are enhance existing heat risk management strategies,
preventable or can be minimized with more indivi- monitoring methods, and modeling at finer scales,
dual-level exposure data[1]. Assessing personal heat emphasizing exposures to vulnerable groups [1–4].
CONTACT Gisel Guzman-Echavarria gguzma20@asu.edu
This article has been corrected with minor changes. These changes do not impact the academic content of the article.
Supplemental data for this article can be accessed online at https://doi.org/10.1080/23328940.2022.2149024
© 2022 Informa UK Limited, trading as Taylor & Francis Group

TEMPERATURE 359
In particular, a link between heat load and social risk environmental heat fluxes to maintain a stable
is required to assess PHE with physiological indicators internal temperature [1,11,12]. However, the
[5]. Finally, PHE research is fundamental to avoid body may or may not compensate during heat
misclassifications in heat-related health outcomes stress to return to thermal equilibrium (Figure 1).
that are expected to increase with climate change Compensable heat stress (CHS) occurs when heat
and urban growth [6–8]. loss to the environment is balanced with heat gain;
Interdisciplinary work is needed to analyze the hence, a steady-state core temperature can be sus-
source-to-effect continuum from a hazardous expo- tained [13]. Conversely, uncompensable heat stress
sure (e.g. high heat) to an ensuing health effect (e.g. (UHS) occurs when evaporative cooling require-
death). Exposure sciences bridge environmental and ments are not supported due to environmental or
health sciences by addressing whether humans come other conditions (including low sweat production)
into contact with a toxicant or hazard [9]. Extreme that impede the body’s ability to cool [13]. In
heat is a physical hazard that people experience in UHS, the internal body temperature rises, which
various “doses” (intensity, frequency, and duration). can result in hyperthermia. Generally, hyperther-
Heat stress is any thermal change (net heat load) that mia is divided by degree of severity into heat
disturbs the balance between an organism and its cramps, heat exhaustion, and potentially fatal heat-
thermal environment, and thermal strain is the over- stroke, either classic or exertional [1].
all physiological response to thermal stress [10]. Under varying environmental heat loads, both
Building on these definitions, PHE quantifies signif- inter- and intra-individual (i.e. features that
icant doses of heat that lead to a particular heat strain a person can change over time) human factors
(Table 1). This distinction is essential for distinguish- may predispose a person to various levels of heat
ing relevant PHE for short-term or long-term heat- stress and related health outcomes [14–16]
related health outcomes [6]. As the same environ- (Figures 1 and 2). In cities, for instance, higher
ment can add different doses of heat to the body thermal exposures arise at the landscape level,
based on activity and physiological constraints, the transferred to buildings, and finally to individuals
use of PHE in research must fully address heat stress [7]. Personal factors such as physical characteris-
over time and include the human body as a heat tics (i.e. mass and surface corporal area) and activ-
source (i.e. metabolic heat production (H )) as ities [17,18] determine the metabolic rate and,
prod
well as clothing parameters. thus, internal heat production, while clothing
Therefore, we extend PHE, which focuses on affects heat loss. Moreover, age, sex, aerobic fit-
environmental heat loads, to allow for the estima- ness, acclimatization, medical and neurological
tion of heat stress and strain over time that can disorders (i.e. diabetes, Alzheimer’s), physical dis-
cause a rise in core temperature, dehydration, and abilities, alcohol use, certain medications, and
cardiovascular strain. This extension is documented drugs also modify susceptibility to heat [15,19–
in Figure 1, which outlines the new modeling cap- 24]. Other considerations affecting heat risk may
abilities demonstrated in the current paper, wherein include socio-demographic and behavioral factors,
area “A” defines PHE (i.e. temperature, humidity, such as infrastructure access and housing insecur-
wind speed, and radiation over time), “B” adds cloth- ity [25–27], cultural practices [15,16], digital visi-
ing and internal heat production to estimate heat bility [28], or occupation (e.g. outdoor workers
stress, and “C” determines whether said heat stress [16,29–36]).
is compensable or not based on physiologic factors, Because of these differences, a critical per-
and thus whether or not heat strain will occur. The spective in PHE research involves explaining
relevant definitions are listed in Table 1. who is affected by heat exposure and how over-
exposure that leads to UHS occurs by connecting
environmental data with an individual’s physio-
Intra and inter-individual assessments of heat
logical, behavioral, or subjective responses [4].
stress and strain based on PHE
However, PHE research is highly heterogeneous,
Physiologically, the thermoregulatory system bal- and current methods are not consistent in quan-
ances the internal heat production and external tifying PHE to account for the three dimensions

360 G. GUZMAN-ECHAVARRIA ET AL.
Table 1. Connecting personal heat exposure (PHE), which focuses on quantifying environmental heat load, with heat stress and
strain to demonstrate the modeling goals within the current study. By leveraging the scope and definition of PHE to assess
compensability under heat stress, we show how heightened PHE can lead to a rise in core temperature, dehydration, and
cardiovascular strain over time.
PHE “The realized contact between a person and an indoor or outdoor environment that poses a risk of increases in body core temperature,
Definition perceived discomfort, or both.” (Kuras et al.[2] p. 2)
Environmentalheatload!PHE!fðT ;H;W;R;PÞdt
air s
*Note: Exposure itself implies intensity, duration, and frequency.
PHE is inherently linked to thermal stress and strain due to the coupling of exposure with duration and frequency to result in
a meaningful exposure-response relationship.[9]
Heat Stress The net heat load on a person resulting from the combined thermal effects of the environment (air temperature, radiant temperature,
humidity, and wind), metabolic heat production, and clothing.[68]
Heat Stress→f(T , H, W, R, P, M, I )dt= PHE + M & I
air s clo clo
Heat Strain Effects on body physiology that occur as a consequence of heat stress[13]; can lead to a rise in body temperature due to
body heat storage, dehydration from non-replenished sweat losses, and cardiovascular strain, such as heart rate increases to
maintain blood pressure (Vanos et al[6]).
- Incorporates physiologic factors to determine if heat stress is compensable or uncompensable over time
Heat Strain→(T , H, W, R, P, M, I , T , , SR) = Heat stress + T , , & SR
air s clo sk sk
temperature (T ), humidity (H), wind speed (W), radiation (R), atmospheric pressure (P), metabolic rate (M), clothing Insolation (I ), skin temperature
air s clo
ðT Þ, skin wettedness (ω), and sweat rate (SR).
sk
Figure 1. Environmental and inter-individual factors influencing a) personal heat exposure (PHE), b) heat stress, and c) heat strain. See .
Table 1 for definitions. To determine heat strain in individuals over time (t, dt) we must know the spatial-temporal evolution of
temperature (t), humidity (h), wind speed (W), radiation (r), atmospheric pressure (p) of the surrounding environment, their metabolic
s
rate (m), clothing insolation (I ), skin temperature ðT Þ, skin wettedness (ω), and sweat rate (SR). Relevant definitions are listed in
clo sk
Table 1
of exposure (intensity, duration, and frequency); sionality and context-specific nature of PHE. It
most PHE research has focused on the intensity is also evident that geographic gaps in PHE
dimension [5]. Hence, there is a need to create research exist (mainly in Latin-American and
standardized practices to obtain accurate expo- African countries), as well as socioeconomic
sures while recognizing the higher multidimen- knowledge gaps [2,4,37,38].

|     |     |     |     |     |     | TEMPERATURE | 361 |
| --- | --- | --- | --- | --- | --- | ----------- | --- |
Figure 2. Relationships between the need for heat loss (positive values) or heat gain (negative values) to reach thermal equilibrium
(E , x-axis) against the potential evaporative heat losses given a set of environmental conditions and clothing insulation (E ,
| req |     |     |     |     |     |     | max |
| --- | --- | --- | --- | --- | --- | --- | --- |
y-axis). The ratio of E req -to- E max  relates the degree of thermal stress to heat exerted on the body (skin wettedness, ω req ). Critical
values of ω are represented with black lines: 0.5 for low-efficient heat loss (thick line) and 1 to limit compensable/uncompensable
req
heat stress (thin line). The purple lines represent values of E for the young/acclimatized and elderly/non-acclimatized when
max sweat
the liquid sweat loss is non-replenished. The vertical gray line at E = 0 indicates thermal equilibrium. Therefore, the numbered
req
Þ, 4)
zones correspond to 1) cold stress, 2) compensable heat stress (CHS), 3) CHS with low sweating efficiency (CHS + Low S eff
uncompensable heat stress (UHS), 5) CHS with limited sweat rate (CSH + LS), and 6) CHS + Low S + LS.
eff
Misrepresentations in PHE research data  for  decision-making  at  specific  scales  [47].
For example, Hass et al [48], found a wider range
Misrepresentations across diverse individuals (per-
|     |     |     | of  temperature  |     | variations  | in  individual  | experi- |
| --- | --- | --- | ---------------- | --- | ----------- | --------------- | ------- |
sonal profiles and behaviors) and scales in PHE
enced temperature (IET) collected with wearable
research may be caused by neglecting the hetero-
|     |     |     | sensors  | compared  | to  data  | from  fixed  | synoptic  |
| --- | --- | --- | -------- | --------- | --------- | ------------ | --------- |
geneous nature of personal experiences and using
| observations that are not representative of an indi- |     |     | weather stations. |     |     |     |     |
| ---------------------------------------------------- | --- | --- | ----------------- | --- | --- | --- | --- |
To overcome these misrepresentations, cutting-
| vidual’s situation [5,6,39–42].  |     | 340 thermal stress  |                 |     |            |                |             |
| -------------------------------- | --- | ------------------- | --------------- | --- | ---------- | -------------- | ----------- |
|                                  |     |                     | edge  research  | is  | conducted  | in  different  | scientific  |
indicators exist, of which 187 can be mathemati-
|                    |              |                 | fields  with  | diverse  | measures    | and  settings.   | For   |
| ------------------ | ------------ | --------------- | ------------- | -------- | ----------- | ---------------- | ----- |
| cally  calculated  | using  only  | meteorological  | data          |          |             |                  |       |
|                    |              |                 | instance,     | thermal  | physiology  | often  assesses  | heat  |
[43]. However, meteorology-based indicators only
partially explain the variance in physiological heat  strain  experienced  by  healthy  people  in  response
strain  [44].  For  example,  many  thermal  indices  to  the  intensity,  duration,  and  frequency  of  heat
describe  heat/cold  exposure  from  a  generalized  exposure  under  controlled-laboratory  settings
while using medical-grade equipment for physiolo-
thermal experience, i.e. “average humans” wearing
|     |     |     | gical  measurements  |     | (e.g.  | to  assess  cardiovascular  |     |
| --- | --- | --- | -------------------- | --- | ------ | --------------------------- | --- |
the same clothing under specific activities (often
low metabolic rate) and climates [3]. The use of  and renal strain [12,20,49–51]). Lately, a “receptor-
thermal indices to address PHE in which certain  oriented” approach has been adopted using nonin-
individuals  are  underrepresented  (e.g.  women,  vasive wearable sensors to capture the three expo-
children, pregnant women) neglects the inherent  sure  dimensions  in  free-living  conditions  within
physiological vulnerability in some groups of con- IET studies [5,42,48,52–54] and occupational health
cern – the most critical being older adults who face  studies  [34,39,52,55–57].  This  paradigm  shift  is
a reduced capacity to sweat and thus limited eva- aligned  with  the  call  from  the  health  geography
porative heat loss [45,46]. Finally, misrepresenta- field  to  investigate  dynamic  environmental  expo-
tion  due  to  the  use  of  sparse  stationary  sures rather than static approaches [58]. However,
measurements  can  cause  incongruence  in  heat  more methodological and applied work is needed to

362 G. GUZMAN-ECHAVARRIA ET AL.
address the context-specific heat experiences, espe- where S represents the rate of internal heat accu-
cially  for  the  most  vulnerable,  harmonizing  and  mulation (or storage); M is the production of heat
improving methods and techniques among scienti- by metabolism; W is external work rate (or the
k
fic disciplines. heat produced by the human body) while perform-
|     |     |     |     |     |     |     | ing  activities;  |     | R,  | C,  and  | K   | represent  | dry  | heat  |
| --- | --- | --- | --- | --- | --- | --- | ----------------- | --- | --- | -------- | --- | ---------- | ---- | ----- |
transfer by radiation, convection, and conduction,
respectively; and E is the heat exchange by eva-
Study purpose and objectives
|     |     |     |     |     |     |     | porative  | heat  | dissipation.  |     | However,  |     | the  internal  |     |
| --- | --- | --- | --- | --- | --- | --- | --------- | ----- | ------------- | --- | --------- | --- | -------------- | --- |
We advance PHE research beyond heterogeneous
|                                                         |     |     |     |     |     |     | heat production (H   |     |     | Þ    | corresponds to the differ- |     |     |     |
| ------------------------------------------------------- | --- | --- | --- | --- | --- | --- | -------------------- | --- | --- | ---- | -------------------------- | --- | --- | --- |
| environmental heat loads toward quantifying com-        |     |     |     |     |     |     |                      |     |     | prod |                            |     |     |     |
|                                                         |     |     |     |     |     |     | ence between M and W |     |     |      | . Further, as the surface  |     |     |     |
| pensability in heat stress (and thus the potential for  |     |     |     |     |     |     |                      |     |     |      | k                          |     |     |     |
area of skin in direct contact with solid surfaces
heat strain) across diverse individuals, climates, and
|          |     |        |                       |     |     |       | tends  | to  | be  | minor,  | conduction  |     | (K)  can  | be  |
| -------- | --- | ------ | --------------------- | --- | --- | ----- | ------ | --- | --- | ------- | ----------- | --- | --------- | --- |
| scales.  | We  | apply  | a  human-environment  |     |     | heat  |        |     |     |         |             |     |           |     |
neglected. As a result, equation 1 takes the follow-
| exchange  | model  |     | to  improve  |     | PHE  assessments  |     |     |     |     |     |     |     |     |     |
| --------- | ------ | --- | ------------ | --- | ----------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
based on thermal load calculations. Our modeling  ing form (equation 2):
framework leverages 1) long-term, large-scale cli-
mate data from three cities and short-term micro- ¼ (cid:0) R(cid:0) C(cid:0) ðWÞ
|     |     |     |     |     |     |     |     | S   | H prod |     |     | E   |     | (2)  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ------ | --- | --- | --- | --- | ---- |
climate data for one city ; and 2) personal attributes
for three profiles (a middle-aged male, a middle-aged  The body heat accumulation (S) (cumulative whole-
female, and a female >65 years) to estimate instanta-
body thermal load change) is estimated by integrating
neous thermal loads. Emphasis is placed on ther-
Equation 1 over an interval of time (dt) as follows:
| mally  | compensable  |     | versus  | uncompensable  |     | heat  |     |         |     |     |     |     |     |     |
| ------ | ------------ | --- | ------- | -------------- | --- | ----- | --- | ------- | --- | --- | --- | --- | --- | --- |
|        |              |     |         |                |     |       |     | (cid:0) |     |     |     |     | �   |     |
S¼(cid:242)t 1
stress conditions based on evaporative heat losses.  H prod (cid:0) R skin (cid:0) C skin (cid:0) C res (cid:0) E res (cid:0) H evapskin :dt ðJÞ
t 0
| We hypothesize that 1) equivalent thermal loads will  |     |     |     |     |     |     |     |     |     |     |     |     |     | (3)  |
| ----------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---- |
lead to different instances of compensability depend-
|     |     |     |     |     |     |     | As  environmental  |     |     | heat  | exchanges  | occur  |     | on  the  |
| --- | --- | --- | --- | --- | --- | --- | ------------------ | --- | --- | ----- | ---------- | ------ | --- | -------- |
ing on personal profile, 2) the climate context will
skin surface and through respiration, equation 3
alter the frequency of CHS and UHS, with hot and
is divided into the convective exchange and eva-
humid  creating  the  most  dangerous  conditions;  porative heat loss associated with skin and respira-
and  3)  fine-scale  microclimate  data  will  facilitate  tion. Thus, convective fluxes include C and C ,
|     |     |     |     |     |     |     |     |     |     |     |     |     | skin  | res |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----- | --- |
a better understanding of an individual’s net heat
|     |     |     |     |     |     |     | while evaporative losses include H |     |     |     |     |      | and E | .   |
| --- | --- | --- | --- | --- | --- | --- | ---------------------------------- | --- | --- | --- | --- | ---- | ----- | --- |
|     |     |     |     |     |     |     |                                    |     |     |     |     | evap | skin  | res |
load over time.
To evaluate thermal compensability, we investi-
|     |     |     |     |     |     |     | gate                        | the  | relation  | of  the  | heat  | loss               | required  | to  |
| --- | --- | --- | --- | --- | --- | --- | --------------------------- | ---- | --------- | -------- | ----- | ------------------ | --------- | --- |
|     |     |     |     |     |     |     | achieve the heat balance (E |      |           |          |       | ) and the maximum  |           |     |
req
Materials and methods: evaporative capacity (E max ) based on the ambient
|     |     |     |     |     |     |     | environment  |     | and  | clothing  |     | (i.e.  equation  |     | 16  in  |
| --- | --- | --- | --- | --- | --- | --- | ------------ | --- | ---- | --------- | --- | ---------------- | --- | ------- |
Human-environment heat exchange models to
Cramer and Jay [18]). In equation 1, if we assume
address personal heat exposure
|     |     |     |     |     |     |     | that heat stress  |     |     | is  compensable  |     | via  | heat loss  | by  |
| --- | --- | --- | --- | --- | --- | --- | ----------------- | --- | --- | ---------------- | --- | ---- | ---------- | --- |
Here, we use the Partitional Calorimetry approach  sweat evaporation and a rate of body storage (S)
outlined by Cramer and Jay [18], which allows sepa- equal to zero, E can be expressed as:
req
| rate  calculation  |     | of  | each  | heat  | transfer  component  |     |     |     |     |     |     |     |     |     |
| ------------------ | --- | --- | ----- | ----- | -------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
based on the fundamental laws governing dry and
| latent  | heat  | transfer.  |     | Unlike  | other  methods,  |     |     |     |      |                   |      |                   |       |     |
| ------- | ----- | ---------- | --- | ------- | ---------------- | --- | --- | --- | ---- | ----------------- | ---- | ----------------- | ----- | --- |
|         |       |            |     |         |                  |     | E   | ¼   | H    | (cid:0) R (cid:0) | C    | (cid:0) C (cid:0) | E ðWÞ |     |
|         |       |            |     |         |                  |     | req |     | prod | skin              | skin | res               | res   |     |
Partitional Calorimetry is physiologically based but
(4)
not numerically demanding, facilitating easy model-
| ing  of  | numerous  |     | environmental  |     | and  behavioral  |     |     |     |     |     |     |     |     |     |
| -------- | --------- | --- | -------------- | --- | ---------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
For the current study, we quantify PHE as the
hypotheses. Human heat exchange models are based
|     |     |     |     |     |     |     | instantaneous  |     |     | thermal  | load  | (equation  |     | 4)  to  |
| --- | --- | --- | --- | --- | --- | --- | -------------- | --- | --- | -------- | ----- | ---------- | --- | ------- |
on the fundamental human heat balance equation:
account for the potential net heat exchange in an
| S ¼ | M(cid:0) | W (cid:0) | R(cid:0) C(cid:0) | K   | (cid:0) E ðWÞ | (1)  |                                                   |     |     |     |     |     |     |     |
| --- | -------- | --------- | ----------------- | --- | ------------- | ---- | ------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
|     |          | k         |                   |     |               |      | instant of time and determine CHS versus UHS. If  |     |     |     |     |     |     |     |

|     |     |     |     |     |     |     |     |     |     |     | TEMPERATURE |     | 363 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------- | --- | --- |
uncompensable  (i.e.  UHS:  E � E )  at  one  atmospheric  pressure.  In  the  given  paper,  city
|     |     |     |     | req | max |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
instant,  the  thermal  load  will  be  positive  over  comparisons are representative of the typical cli-
a longer time and the body will likely gain heat,  mate at the synoptic scale, and microclimate data
and vice-versa (Figure 2, equation 5). CHS occurs  represent a localized scale.
when enough heat can be lost to the environment  For  climate  data,  weather  observations  for
a “Typical Meteorological Year” (TMY) are used
so that the body is not in a continuous state of heat
based on the warm season (June to September) in
gain or (S<0) assuming a steady-state core tem-
|     |     |     |     |     |     |     | Phoenix,  | Miami,  | and  | New  | York:  | Phoenix-Sky  |     |
| --- | --- | --- | --- | --- | --- | --- | --------- | ------- | ---- | ---- | ------ | ------------ | --- |
perature, then:
Harbor International airport (33.45°N, −111.983°
W, 337 m.a.s.l), Miami International airport (25.8°
E
|     |         |       |     | req |     |      | N, −80.3°W, 11 m.a.s.l), and New York Central  |     |     |     |     |     |     |
| --- | ------- | ----- | --- | --- | --- | ---- | ---------------------------------------------- | --- | --- | --- | --- | --- | --- |
| CHS | : E � E | ðWÞor |     | ¼ ω |     |      |                                                |     |     |     |     |     |     |
|     | req     | max   | E   |     | req |      |                                                |     |     |     |     |     |     |
|     |         |       |     | max |     |      | Park Observatory (40.7793°N, −73.9691°W,40 m.  |     |     |     |     |     |     |
|     | � 1ðNDÞ |       |     |     |     | (5)  |                                                |     |     |     |     |     |     |
a.s.l). These cities allow for the inclusion of differ-
ent types of heat: hot-dry, hot-humid, and a mix,
In equation 5, the skin wettedness “required” for heat
respectively. Climate data correspond to TMY ver-
balance (ω req ) is thus based on the ratio of E req  to  sion 3 (TMY3) [62] data, often used for building
E [18]. Skin wettednes is also a measure of the
| max  |     |     |     |     |     |     | energy design and performance modeling. |     |     |     |     |     |     |
| ---- | --- | --- | --- | --- | --- | --- | --------------------------------------- | --- | --- | --- | --- | --- | --- |
proportion of wet skin at any given time [59]. When
|     |     |     |     |     |     |     | We  | also  | collected  | microclimate  |     | data  | with  |
| --- | --- | --- | --- | --- | --- | --- | --- | ----- | ---------- | ------------- | --- | ----- | ----- |
ω is close to 0.5, the efficiency of sweat declines
| req         |             |         |         |        |       |     | a high-end human-biometeorological station that  |       |               |     |               |      |       |
| ----------- | ----------- | ------- | ------- | ------ | ----- | --- | ------------------------------------------------ | ----- | ------------- | --- | ------------- | ---- | ----- |
| indicating  | high  heat  | stress  | (thick  | black  | line  | in  |                                                  |       |               |     |               |      |       |
|             |             |         |         |        |       |     | measures                                         | T air | ,  humidity,  |     | wind  speed,  | and  | six-  |
Figure 2) and also indicates the effectiveness of eva- directional  short-wave  and  long-wave  radiation
porative heat loss from the skin surface (H ).  (to estimate MRT) – also known as MaRTy [63].
|     |     |     |     |     | evap | skin |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | ---- | ---- | --- | --- | --- | --- | --- | --- | --- |
Throughout this paper, we use ω to help assess  Diurnal data were collected during the first sum-
req
compensability and degree of thermal stress in com- mer heatwave of 2022 in the southwest US, result-
bination with sweat limits and efficiency, resulting in  ing  in  a  heat  warning  [64]  for  Phoenix  from
June 8–12th. The measurements were taken from
five zones of heat stress (Figure 2).
June 9–11th, 2022, in a single-family home back-
In addition to environmental and clothing fac-
tors, evaporative heat loss also depends on physio- yard located in an open low-rise (Local Climate
logical  factors,  such  as  maximum  wettedness  Zone 6) neighborhood in Phoenix, Arizona. We
(ω ), which is affected by acclimatization, and  chose  to  observe  the  microclimate  in  an  open
max
|     |     |     |     |     |     |     | space  | (the  sky  | view  | factor  | at  that  | location  | is  |
| --- | --- | --- | --- | --- | --- | --- | ------ | ---------- | ----- | ------- | --------- | --------- | --- |
the maximum sweat rate. Here, to include accli-
|              |               |     |      |       |            |     | 0.909)  | to  be  | consistent  | with  | the  | measurements  |     |
| ------------ | ------------- | --- | ---- | ----- | ---------- | --- | ------- | ------- | ----------- | ----- | ---- | ------------- | --- |
| matization,  | we  multiply  |     | E    | by  ω | (fraction  |     |         |         |             |       |      |               |     |
|              |               |     | max  | max   |            |     |         |         |             |       |      |               |     |
from weather stations.
| between  | 0  and  1)  | based  | on  | the  given  | profile  |     |     |     |     |     |     |     |     |
| -------- | ----------- | ------ | --- | ----------- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
(Table 2). Second, we calculate the maximum eva-
porative heat loss linked with the maximum sweat
Personal profiles: Physiological inputs
| rate (E max | sweat ) for each profile (purple lines and  |     |     |     |     |     |          |            |           |     |            |              |     |
| ----------- | ------------------------------------------- | --- | --- | --- | --- | --- | -------- | ---------- | --------- | --- | ---------- | ------------ | --- |
|             |                                             |     |     |     |     |     | We  set  | up  three  | personal  |     | profiles:  | middle-aged  |     |
Zones 5 and 6 in Figure 2). Hence, we assume
|              |     |                               |     |     |     |     | females,  | middle-aged  |     | males,  | and  | females  | above  |
| ------------ | --- | ----------------------------- | --- | --- | --- | --- | --------- | ------------ | --- | ------- | ---- | -------- | ------ |
| a constant E |     | (equation 9 in Morris et al.  |     |     |     |     |           |              |     |         |      |          |        |
max sweat
65 years (Table 2) to incorporate inter-individual
[60] Suppl. Material) based on the assumption that
|             |              |            |     |             |     |        | factors  | such  | as  anthropometrics  |     |     | (consequently,  |     |
| ----------- | ------------ | ---------- | --- | ----------- | --- | ------ | -------- | ----- | -------------------- | --- | --- | --------------- | --- |
| all  sweat  | evaporates,  | therefore  |     | neglecting  |     | sweat  |          |       |                      |     |     |                 |     |
metabolic demand and sex), acclimatization, and
efficiency. Finally, as assumed in partitional calori-
sweat rate (to add aging differences). We did not
metry, we fix mean skin temperature at 35°C [61].
|     |     |     |     |     |     |     | consider  | intra-individual  |       |       | factors  | and  do        | not  |
| --- | --- | --- | --- | --- | --- | --- | --------- | ----------------- | ----- | ----- | -------- | -------------- | ---- |
|     |     |     |     |     |     |     | address   | changes           | over  | time  | in  the  | given  paper.  |      |
The middle-aged male profile corresponds to the
Environmental input data
average personal profile in the UTCI-Fiala model
Environmental data needed for the model includes  [65], with a mass of 73.4 kg and a surface area (A )
d
air temperature (T ), mean radiant temperature  of 1.85 m2. All profiles have equivalent effective
air
(MRT),  relative  humidity,  wind  speed,  and  radiative  body  area,  emissivity,  and  clothing

364 G. GUZMAN-ECHAVARRIA ET AL.
Table 2. Personal profiles used as examples in the current study. Specific parameters are provided for middle-aged male/female and
elderly female. Personal variables needed within the model include body mass, effective body radiative area, the area-weighted
emissivity of the clothed body surface, clothing insulation value, maximum skin wettedness, and maximum sweat rate.
|                                              |     |     |     |     | Middle-aged female |      |     | Middle-aged male |      |     | Elderly female |      |
| -------------------------------------------- | --- | --- | --- | --- | ------------------ | ---- | --- | ---------------- | ---- | --- | -------------- | ---- |
| Mass (kg)                                    |     |     |     |     |                    | 56.2 |     |                  | 73.4 |     |                | 73.9 |
| Height (m)                                   |     |     |     |     |                    | 1.64 |     |                  | 1.71 |     |                | 1.62 |
| A : Dubois-Dubois surface corporal area (m2) |     |     |     |     |                    | 1.60 |     |                  | 1.85 |     |                | 1.78 |
d
| Effective body radiative area (ND) |     |     |     |     |     | 0.70 |     |     | 0.70 |     |     | 0.70 |
| ---------------------------------- | --- | --- | --- | --- | --- | ---- | --- | --- | ---- | --- | --- | ---- |
Area-weighted emissivity of the clothed body surface (ND) 0.98 0.98 0.98
| Insulation value (I | ) (clo) |     |     |     |     | 0.57 |     |     | 0.57 |     |     | 0.57 |
| ------------------- | ------- | --- | --- | --- | --- | ---- | --- | --- | ---- | --- | --- | ---- |
clo
Maximum skin wettedness (ω ) (ND) fully acclimatized (1.0) fully acclimatized (1.0) Unacclimatized (0.85)
max
| Maximum sweat rate linked to E |     |     | (L/h) |     |     | 0.75 |     |     | 0.75 |     |     | 0.51 |
| ------------------------------ | --- | --- | ----- | --- | --- | ---- | --- | --- | ---- | --- | --- | ---- |
max sweat
insulation values (Table 2). We assume standing  thetic MRT values. Only daytime data (6:00
individuals with a clothing level of 0.57 I (trou- to 18:59 local time) were assessed.
clo
sers, short-sleeved shirt). The effect of aging on
thermoregulation  in  the  model  is  accounted  for  For Case 4, we estimated synthetic MRT values
with a reduction in the maximum sweat rate [45]  from TMY3 data using an offset value to increase
and the ω max  of an unacclimatized person [66]. As  the hourly T based on normalized solar radia-
air
the variability in the heat experienced between sex  tion  values  (S ).  This  criterion  was  chosen  to
in
|     |     |     |     |     |     | simulate  | realistic  |     | MRT  | daytime  | variability.  |     |
| --- | --- | --- | --- | --- | --- | --------- | ---------- | --- | ---- | -------- | ------------- | --- |
in this study is expressed with changes in anthro-
pometrics, we choose to address the aging effects  Hence, we include only the short-wave radiation
with  just  one  of  the  two  sex  profiles  to  reduce  portion of MRT. To obtain the normalized values,
redundancy in the results. we take global radiation from TMY data and scale
them to maximum solar radiation of 1366 W/m
We ran the human-environment heat exchange
|     |     |     |     |     |     | [2] (the solar constant, S |     |     |     | ). We offset T |     | values  |
| --- | --- | --- | --- | --- | --- | -------------------------- | --- | --- | --- | -------------- | --- | ------- |
model for the three personal profiles and cities to  con air
compare the following situations: for partly cloudy conditions in a range from 0 and
TMY summertime climate: +15°C and clear sky from 0 to +30°C. The 15°C
|     |     |     |     |     |     | and  | 30°C  thresholds  |     | were  | chosen  | based  | on  T |
| --- | --- | --- | --- | --- | --- | ---- | ----------------- | --- | ----- | ------- | ------ | ----- |
air
|         |                                         |     |     |     |     | and  | MRT  | differences  | in  | microclimate  |     | measure- |
| ------- | --------------------------------------- | --- | --- | --- | --- | ---- | ---- | ------------ | --- | ------------- | --- | -------- |
| ● Case  | 1:  Walking (3.5 metabolic equivalents  |     |     |     |     |      |      |              |     |               |     |          |
ments (Figure 10 c) during a partly cloudy day
| (METs)),  |     | emulating  | indoor  | conditions  |     |     |     |     |     |     |     |     |
| --------- | --- | ---------- | ------- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
(2022–06-09) and a clear sky day (2022–06-11) in
| (MRT  | =   | T ),  | and  facing  | calm  | winds  |     |     |     |     |     |     |     |
| ----- | --- | ----- | ------------ | ----- | ------ | --- | --- | --- | --- | --- | --- | --- |
air
Phoenix. Figure 4 displays the MRT values for the
(0.5 m/s).
hottest day in the TMY from Phoenix used to test
● Case 2: Climate data same as Case 1, still assum-
Case 4.
| ing MRT = T |     | and calm winds, but varying  |     |     |     |     |     |     |     |      |     |     |
| ----------- | --- | ---------------------------- | --- | --- | --- | --- | --- | --- | --- | ---- | --- | --- |
|             |     | air                          |     |     |     |     |     |     |     | �� � | �   |     |
S
| METs  | to  estimate  |     | H prod :  resting  | 1.8  | METs  |     |                  |     |       | in  | ð�CÞ |       |
| ----- | ------------- | --- | ------------------ | ---- | ----- | --- | ---------------- | --- | ----- | --- | ---- | ----- |
|       |               |     |                    |      |       |     | MRT partlycloudy | ¼T  | air þ |     | �15  | (6)   |
S
| (standing, fidgeting), walking 3.5 METs (walk- |     |     |     |     |     |     |     |     |     | con |     |     |
| ---------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
ing, 3.0 mph, moderate speed, not carrying any-
thing), jogging 7 METs (jogging, general) [67].
|     |     |     |     |     |     |     |     |     | ��  | �   | �   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
S
● Case 3: Walking (3.5 METs), MRT = T , but  ¼T þ in �30 ð�CÞ
|     |     |     |     | air |     |     | MRT | clearsky | air |     |     | (7)   |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | --- | --- | --- | ----- |
S con
| varying  | wind  | speed.  | Sensitivity  | test,  | with  |     |     |     |     |     |     |     |
| -------- | ----- | ------- | ------------ | ------ | ----- | --- | --- | --- | --- | --- | --- | --- |
wind speed according to the Beaufort wind
scale of calm (0.5 m/s), light breeze (3 m/s),  Case 5) Microclimate Data – Summer Heatwave in
and moderate breeze (7 m/s). Phoenix:  Heat  load  estimates  are  calculated  on
●
Case  4:  Walking  (3.5  METs),  facing  calm  extreme heat days using varying degrees of personal
winds (0.5 m/s), with variable radiation levels:  acclimatization (Table 2). Individuals are assumed to
Indoor (MRT = T ) versus partly and fully  be walking (3.5 METs); variable outdoor wind speeds
air
outdoor  sun-exposed  conditions  using  syn- and MRT stem from collected microclimate data and

|     |     |     |     |     |     |     |     |     |     |     |     | TEMPERATURE |     | 365 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------- | --- | --- |
are compared to climate data for the hottest day in the  Typical summertime climates in three cities
Phoenix TMY file.
|     |     |     |     |     |     |     | Case 1: Figure 5 displays differences in E |     |     |     |     |     |     | , E ,  |
| --- | --- | --- | --- | --- | --- | --- | ------------------------------------------ | --- | --- | --- | --- | --- | --- | ------ |
|     |     |     |     |     |     |     |                                            |     |     |     |     |     | req | max    |
Case 1 is the control case for climate summertime
|                                           |     |     |     |     |     |        | and ω |      | between permutations of three personal  |     |     |     |     |     |
| ----------------------------------------- | --- | --- | --- | --- | --- | ------ | ----- | ---- | --------------------------------------- | --- | --- | --- | --- | --- |
| analyses (Cases 2, 3, and 4) with MRT = T |     |     |     |     |     | , and  |       | req  |                                         |     |     |     |     |     |
air
|     |     |     |     |     |     |     | profiles  |     | and  | climates.  | The  | elderly  |     | female  |
| --- | --- | --- | --- | --- | --- | --- | --------- | --- | ---- | ---------- | ---- | -------- | --- | ------- |
a fixed wind speed of 0.5 m/s, while reference climate
(Figure 5c,f,i, right column) is the most likely to
results for Case 5 correspond to the model results from
be under high thermal stress. This profile shows
TMY data with variable wind speed and estimated
a high percentage of time within Zone 3 (CHS +
| MRT  | Therefore, Figure 10 has a reference to  |     |     |     |     |     |     |     |     |     |     |     |     |     |
| ---- | ---------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
clear sky.
control ω (yellow line in Figure 10b) as acontrol case  Low S ), Zone 4 (UHS), and Zone 6 (CHS+ Low
|     | req  |     |     |     |     |     |     | eff |     |     |     |     |     |     |
| --- | ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
because ω is estimated using Case 1 data. S eff + LS) within the Phoenix and Miami summer-
req
|     |     |     |     |     |     |     | time:     | 43.8%,         | 14.0%,   | and         | 36.4%,     | respectively,  |       | in     |
| --- | --- | --- | --- | --- | --- | --- | --------- | -------------- | -------- | ----------- | ---------- | -------------- | ----- | ------ |
|     |     |     |     |     |     |     | Phoenix,  |                | summing  | to          | 94%,  and  | 63%,           | 37%,  | and    |
|     |     |     |     |     |     |     | 0%,       | respectively,  |          | in  Miami,  | summing    |                | to    | 100%.  |
Analysis
New York results were lower at 48%, 4.6%, and
All  results  are  displayed  within  diagrams  akin  to  0.4%,  respectively.  These  zones  depict  low  effi-
Figure 2 using bivariate histograms that illustrate data  ciency in evaporative heat loss and thus a danger
counts over the ratio of E req  (x-axis) and E max  (y-axis).  in rising core temperatures for the older female
This visualization shows the required skin wettedness
profile if behavioral actions to lower their thermal
(ω req ), also known as Heat Stress Index, HSI [68]. The  load are not taken.
Figure 5 shows the different nature of the physio-
color intensity in the bivariate histograms represents
the percent of hours during summertime for E =E logical constraints caused by thermal stress between
req max
combinations. Thus, each pixel is interpreted as the  climate types, as evidenced by the summertime pre-
percentage of time in a city during which its summer  dominance in each of the zones for E /E com-
req max
climate requires people to lose/gain a specific heat flux  binations. For instance, on average for Miami and all
|     |     |     |     |     |     |     | personal  |     | profiles  | (Figure  | 5d-f),  |     | more  | than  |
| --- | --- | --- | --- | --- | --- | --- | --------- | --- | --------- | -------- | ------- | --- | ----- | ----- |
(E ) to achieve thermal equilibrium, and the potential
req
for heat loss ðE and E ), with results falling  86% percent of the summertime weather conditions
|     |     | max  | max sweat |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | ---- | --------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
lead to low efficiency in sweat evaporation but are
into one of six zones (Figure 2). The histograms display
still compensable via evaporative heat loss (Zone 3).
the number of observations in discrete bins, equally
|     |     |     |     |     |     |     | However,  |     | if  an  | elderly  | person  | is  walking  |     | during  |
| --- | --- | --- | --- | --- | --- | --- | --------- | --- | ------- | -------- | ------- | ------------ | --- | ------- |
separated based on a 25 W range.
summertime, they would remain in Zone 3 for 62%
of the time, and under UHS (Zone 4) 37% of the time
(compared to 0.01% for a middle-aged female).
Results
In contrast, the heat stress exerted on people in
New York and Phoenix summer (higher tempera-
Overview
tures than Miami, yet drier) is more variable and,
Results reveal three critical advancements in mod-
most of the time, compensable. In those cities, heat
eling capabilities that are missing in PHE assess-
|              |     |         |              |     |         |     | stress                   | can  | either  | be  linked  | to                  | low  | efficiency  | in      |
| ------------ | --- | ------- | ------------ | --- | ------- | --- | ------------------------ | ---- | ------- | ----------- | ------------------- | ---- | ----------- | ------- |
| ments  from  |     | common  | approaches.  |     | First,  | we  |                          |      |         |             |                     |      |             |         |
|              |     |         |              |     |         |     | evaporative heat loss (ω |      |         |             | req  >0.5, or low S |      | eff         | zones)  |
demonstrate the ability to model diverse popula-
or demand for sweating that exceeds the sweat rate
tions using PHE information. Second, we under-
|            |               |     |          |     |      |        | of  | a  person,  | which  | is  | more  | likely  | to  occur  | in  |
| ---------- | ------------- | --- | -------- | --- | ---- | ------ | --- | ----------- | ------ | --- | ----- | ------- | ---------- | --- |
| line  the  | differential  |     | impacts  | on  | PHE  | among  |     |             |        |     |       |         |            |     |
elderly people. Phoenix (Figure 3a-c) is character-
| different  | “types”  | of  heat  | (e.g.  | humid  |     | hot,  dry  |     |     |     |     |     |     |     |     |
| ---------- | -------- | --------- | ------ | ------ | --- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
ized by very low humidity and very high tempera-
| hot);  these            | thermal  | load  | signatures             |     | are  | missed  |        |         |      |          |     |         |         |      |
| ----------------------- | -------- | ----- | ---------------------- | --- | ---- | ------- | ------ | ------- | ---- | -------- | --- | ------- | ------- | ---- |
|                         |          |       |                        |     |      |         | tures  | during  | the  | summer,  |     | except  | during  | the  |
| when merely assessing T |          |       | or using temperature-  |     |      |         |        |         |      |          |     |         |         |      |
air
monsoon season with higher humidity and some
humidity indices. Third, we quantify how PHE can
|     |     |     |     |     |     |     | precipitation.  |     | In  | response,  | a   | pedestrian  |     | would  |
| --- | --- | --- | --- | --- | --- | --- | --------------- | --- | --- | ---------- | --- | ----------- | --- | ------ |
be misrepresented if using sparse weather station
data that does not correspond to actual microcli- experience  CHS  with  low  S (Zone  3)  during
eff
| mate data where people are exposed. |     |     |     |     |     |     | 66% of the summer. |     |     |     |     |     |     |     |
| ----------------------------------- | --- | --- | --- | --- | --- | --- | ------------------ | --- | --- | --- | --- | --- | --- | --- |

366 G. GUZMAN-ECHAVARRIA ET AL.
Figure 3. The MaRTy human-biometeorological station located in a single-family home backyard in an open low-rise Local Climate
Zone (LCZ 6, SVF: 0.909) neighborhood in Phoenix, Arizona. The portable station monitors net radiation in three directions to provide
highly accurate MRT values, air temperature, relative humidity, and wind velocity.
Figure 4. Simulated MRT hourly data for the hottest day in the TMY file from Phoenix (July 16th, 2022). Control corresponds to
indoor conditions e.g. MRT equal to air temperature.
Case 2: Figure 6 displays the variability of to achieve thermal equilibrium increases with
E /E combinations when the activity level varies exercise intensity, thus shifting histograms to
req max
for the middle-aged female profile for three climate the right with intensity moving from fully
types. Results for the remaining profiles are in Suppl. CHS for resting to high UHS frequencies
material SS1. when running (i.e. 100% of the time for
This sensitivity test indicates how people can Miami, 79% for Phoenix, and 48% for
fall into UHS while performing vigorous activ- New York).
ities during summertime in dry or humid heat. Case 3: The effect of wind speed changes on
The rate of whole-body heat loss required (E ) whole-body heat exchanges for the middle-aged
req

TEMPERATURE 367
Figure 5. Case 1 scenarios – Two-dimensional histograms of the rate of required whole-body heat loss, E (x-axis), and the
req
maximum potential evaporative rate, E (y-axis,) for three personal profiles (columns) – Middle-aged female; Middle-aged male;
max
Elderly female––while walking in the summertime in Phoenix, Miami, and New York (rows). Black diagonal lines: ω = 0.5 (thick)
req
and 1 (thin). Purple lines: values of E for the young/acclimatized and elderly/non-acclimatized (lighter shade) when liquid
max sweat
sweat loss is not replenished. Vertical gray line at E = 0 indicates thermal equilibrium.
req
Figure 6. Case 2 scenarios – Two-dimensional histogram for the rate of required whole-body heat loss, E (x-axis), and the
req
maximum potential evaporative rate, E (y-axis), for the middle-aged female profile performing different activities (blue =resting,
max
grey =walking, pink =jogging). The model was run using hourly TMY summertime data for Phoenix, Miami, and New York. Black
diagonal lines: ω = 0.5 (thick) and 1 (thin). Purple lines: values of E for the young/acclimatized when the liquid sweat loss
req max sweat
is non-replenished. Vertical gray line at E = 0 indicates thermal equilibrium.
req

368 G. GUZMAN-ECHAVARRIA ET AL.
Figure 7. Case 3 scenarios – Two-dimensional histogram for the rate of required whole-body heat loss, E (x-axis), and the
req
maximum potential evaporative rate, E (y-axis), for the middle-aged female personal profile walking while facing different
max
constant wind speeds at human height (gray = calm winds (0.5 ms−[1]), light blue = light breeze (3 ms−[1]), dark blue = moderate
breeze (7 ms−[1]). The model was run using hourly TMY summertime data from Phoenix, Miami, and New York. Black diagonal lines:
ω = 0.5 (thick) and 1 (thin). Purple lines: values of E for the young/acclimatized when the liquid sweat loss is non-
req max sweat
replenished. Vertical gray line at E = 0 indicates thermal equilibrium.
req
woman is displayed in Figure 7. Results for the wind speeds, the potential heat losses in Phoenix
remaining profiles are in Suppl. Material SS2. are compromised by 14% (Zone 5) due to sweat
As wind speed increases, E max also increases, rate limitations.
which is depicted by the vertical displacement in Case 4: The results of changing daytime radia-
the histograms. However, if the maximum sweat tion levels (comparing indoor, partly cloudy, and
rate is exceeded (points above purple lines or clear sky conditions) for a middle-aged female
Zones 5 (CSH + LS) and 6 (CSH + LS + Low walking are shown in Figure 8. Results for middle-
S eff )), the maximum amount of sweat, E max sweat , aged males and elderly females are in Suppl.
will not be enough to maintain thermal equili- Material SS3.
brium. This type of thermal stress also exacer- The net effect of heat stress under increased
bates the risk of dehydration. The convective radiative fluxes is akin to adding heat via meta-
loss/gain of heat (C ) also increases, yet the bolic energy (Figure 6). With higher radiation
skin
direction (gain or loss) depends on the air-to- increasing the thermal load, more whole-body
skin temperature gradient. For example, convec- heat loss is required to achieve heat balance
tion is often a heat gain in the Phoenix summer (E ), which is demonstrated by the rightward
req
due to the prevalence of temperatures above the displacement of the histograms moving from
skin temperature assumed in the model (>35°C), CHS (Zone 2) to CHS + Low S (Zone 3) and
eff
which is reflected by the upward histogram even into UHS (Zone 4) under clear-sky condi-
shifts in Phoenix (Figure 7a). However, in tions. In Miami, under conditions where
New York and Miami, histograms shift left MRT = T , the heat loss through evaporation
air
with higher winds due to convective cooling of sweat, although compensable, is inefficient for
(Figure 7b-c). At higher wind speeds, the ther- most of the summer (CHS: 14%, CHS + Low
mal environment in Miami and New York S : 86%, UHS: 0%). These results show that
eff
results in lower ω values, and during cooler CHS can quickly turn uncompensable with
req
New York nights in a TMY summer, the mod- increased solar radiation. For clear sky condi-
erate winds can feel cold. In contrast, during the tions in Miami, CHS conditions are infrequent
dry Phoenix summer, a middle-aged female (10%), while conditions become compensable
experiences CHS at a ω < 0.5 (Zone 2 and 5) (yet with Low S (Zone 3)), 60% of the time,
req eff
33% of the time under calm winds and 89% and are within UHS 30% of the time if no
under a moderate breeze. However, with higher adaptative measures are taken.

|     |     |     |     |     |     |     | TEMPERATURE | 369 |
| --- | --- | --- | --- | --- | --- | --- | ----------- | --- |
Figure 8. Case 4 scenarios – Two-dimensional histogram for the rate of required whole-body heat loss, E (x-axis), and the maximum
req
potential evaporative rate, E (y-axis), for the middle-aged female personal profile walking in indoor, partly cloudy, and clear sky
max
conditions (histogram colors). The model was forced with hourly TMY summertime data from Phoenix, Miami, and New York. Black, gray,
and purple lines as in .Figure 2
estimates for the hottest day in the TMY file from Phoenix (July 16th). Results for the middle-aged
| Figure 9. Case 4 – Hourly ω |     | req  |     |     |     |     |     |     |
| --------------------------- | --- | ---- | --- | --- | --- | --- | --- | --- |
female profile. Each color corresponds to ω req  for model 1 (Control), 2, 3, and 4. The horizontal lines delimite  ω: 0.5 and 1.
Figure 9 displays the ω req  hourly variation dur- Microclimate data vs. weather station data
| ing  the  | hottest  day  | in  the  TMY  | of  Phoenix  | to  |     |     |     |     |
| --------- | ------------- | ------------- | ------------ | --- | --- | --- | --- | --- |
Case 5 demonstrates the difference between using
group model results for all scenarios with climate
fine-scale microclimate data versus large-scale cli-
representative data. The model representation of
mate data for each personal profile (Figure 10) and
| each term in equations 2 and 4 (H |     |     | , CþR |       |     |     |     |     |
| --------------------------------- | --- | --- | ----- | ----- | --- | --- | --- | --- |
|                                   |     |     | prod  | skin; |     |     |     |     |
the same comparison for individuals performing
| C ;E    | ; E and E | ) for the same day is pro- |     |     |                        |           |         |                 |
| ------- | --------- | -------------------------- | --- | --- | ---------------------- | --------- | ------- | --------------- |
| res res | req       | max                        |     |     |                        |           |         |                 |
|         |           |                            |     |     | different  activities  | (Figures  | 6  and  | 11).  Although  |
vided in Supplementary material SS4 and SS5.
stationary microclimate data do not precisely fit
For a middle-aged female in Phoenix, the high-
|            |         |                  |         |         | the  experienced  | heat  of  | a  person  | in  their  daily  |
| ---------- | ------- | ---------------- | ------- | ------- | ----------------- | --------- | ---------- | ----------------- |
| est  heat  | stress  | is  experienced  | during  | a  hot  |                   |           |            |                   |
routine, this example demonstrates how the loca-
summer day when performing a vigorous activity
lized, high-end data (i.e. high-accuracy MRT) cap-
| (Case  | 2)  and  under  | high  solar  | radiation  | levels  |     |     |     |     |
| ------ | --------------- | ------------ | ---------- | ------- | --- | --- | --- | --- |
(Case 4) (Figure 9). In both cases, the instanta- ture  better  the  heat  flux  source  areas  and  their
neous  heat  load  reaches  conditions  of  UHS.  In  time  variability  than  standard  weather  observa-
contrast, lower PHEs occur while resting or walk- tions.  The  20-minute  rolling  mean  of  ω req
ing at higher wind speeds. (Figure  10a),  shows  people  experiencing  UHS

370 G. GUZMAN-ECHAVARRIA ET AL.
Figure 10. Case 5 – From top to bottom: (a,b) modeled ω (or HSI) for the three personal profiles (Middle-aged Female/Male
req
andElderly female, all assumed to be walking); (c, d) air temperature and mean radiant temperature; (e, f) relative humidity; and (g, h)
wind speed. The left panel corresponds to 1-minute microclimate data during a June 9–11th, 2022 heatwave in Phoenix, AZ, and the right
panel to the hourly data for the hottest day in the TMY in Phoenix, AZ (July 16th). Graph a represent ω as 20-minute rolling means. In
req
(a, b), the horizontal lines delimitω : 0.5 and 1, and the yellow line in b) corresponds to the control run (gray line) in Figure 9.
req
during the daytime while merely walking across are not directly comparable because the TMY
three extreme heat days in Phoenix. T , MRT, H, dataset has windier and drier weather conditions
air
and wind speed that lead to these ω values are (Figure 10 f and h) than the microclimate data
req
also shown in Figure 10. In contrast, for a similar (Figure 10 e and g), as already discussed for
summer day, a regional weather station estimates Cases 1 (Figures 5 and 3, 7), yet provide
UHS at 8:00 am only (Figure 10b). The datasets a helpful case study for advancing PHE research.

TEMPERATURE 371
Figure 11. Case 5 – Two-dimensional histogram for the rate of required whole-body heat loss, E (x-axis), and the maximum
req
potential evaporative rate, E (y-axis), for the three personal profiles performing different activities (histogram colors) during a heat
max
wave (June 9–11th of 2022) in Phoenix, Arizona. The model was run using the 1-minute average of data collected with MaRTy in the
backyard of a single-family home. Black diagonal lines: ω = 0.5 (thick) and 1 (thin). Purple line: values of E for the young/
req max sweat
acclimatized when the liquid sweat loss is not replenished. Vertical gray line at E = 0 indicates thermal equilibrium.
req
Figure 11 displays the thermal load differences [44]. underlines the need for future research that
and potential heat loss for all profiles performing describes heat stress and strain in non-occupational
different activities using microclimate data. Similar populations performing various activities in a wide
to Cases 1 and 2 (Figure SS1), the elderly female (or range of environmental settings considering inter-
a non-acclimatized person) shows a higher probabil- and intra-individual factors. Grundstein and Vanos
ity of being under high thermal stress (Figure 11c) [3] caution the misuse of thermal indices and provide
because of low sweat loss (CHS + Low S ; Zone 3), applicability notes and scenarios for numerous ther-
eff
UHS (Zone 4), limited sweat rate (Zones 5 and 6), mal indices, including UTCI, PET, mPET, and the
and a combination of the three factors. For instance, WBGT index. By utilizing CHS and UHS zones
performing a vigorous activity, such as jogging, dur- (Figure 2) through modeling, we illustrate the extent
ing a heat wave would result in UHS not only for the and type of thermal stress estimated given personal
elderly, but would yield UHS 90% of the time in characteristics/population diversity, activity, climate
a middle-aged female, 98% of the time in a middle- type, solar exposure, and scale of data. Sensitivity
aged male, and 100% of the time in an elderly female. tests exhibit how these factors impact heat stress or
Additionally, comparing Phoenix results using the strain and the consequences of misrepresenting an
two meteorological forcing methods, the microcli- environment or the person’s physiology in PHE
mate exposure results in problems arising in heat research. The ability to model these factors to assess
dissipation if water is not well replenished even CHS and UHS is largely based upon the dynamic
when resting (seen by comparing Zone 5 (CHS relationship between convective heat and vapor trans-
+LS) and Zone 6 (CHS + Low S +LS) in Figure 11 fers linked to personal and environmental inputs [69].
eff
For example, the distinction between males and
a,b,c and Figure 6 a,b,c).
females is expressed by a higher mass and surface
corporal area in the male’s profile. The dimension of
Discussion
the body surface area (A ) is the interface that med-
d
Contextual findings and relationships iates heat exchanges with the external environment:
both E and E are proportional to A .
This work extends PHE research by linking heat req max d
Simultaneously, body mass has two roles from
exposure with the ability to estimate heat stress and
a thermodynamic perspective: working as an internal
strain over time. We also highlight pitfalls that can be
heat sink, thus contributing to thermal inertia, and
incurred when considering homogeneous heat
experiences for people with different biophysical char- regulating the energy expenditure cost of weight-
acteristics. For instance, related work by Ioannou et al bearing exercise [69]. Therefore, a higher mass

372 G. GUZMAN-ECHAVARRIA ET AL.
assumes  higher  internal  metabolic  heat  and  more  studies),  then  convective,  radiative,  or  evaporative
intense  external  heat  exchanges,  thus  demanding  heat fluxes (and thus heat stress) cannot be deter-
more heat loss (E ). As a result, the middle-aged  mined. Notably, T , although most easily measured,
|     | req |     |     |     |     |     | air |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
male profile remains within the CHS area more fre- cannot be taken as a complete indicator of heat stress,
as indicated by McGregor and Vanos [73] and Kuras
quently, even with limited sweat (i.e. Zone 5) than the
et al [2]. Results here show the significance of includ-
middle-aged female profile (Figure 5 a,b and Figure 11
ing solar radiation in PHE work to assess outdoor heat
| a,b). However, a higher E |     | implies that, due to the  |     |     |     |     |     |     |     |     |
| ------------------------- | --- | ------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
max
stress and strain, which, if ignored, can cause gross
higher surface area, the male group would have to
misrepresentation of actual thermal loads, even under
sweat more to compensate for the heat and would
|     |     |     |     |     | equivalent T | air , humidity, and wind speed (Figure 8).  |     |     |     |     |
| --- | --- | --- | --- | --- | ------------ | ------------------------------------------- | --- | --- | --- | --- |
dehydrate faster than other groups.
Numerous studies show that MRT is a more appro-
| This  work  | also  exemplifies  | the  | compounding  |     |                         |     |     |                             |     |     |
| ----------- | ------------------ | ---- | ------------ | --- | ----------------------- | --- | --- | --------------------------- | --- | --- |
|             |                    |      |              |     | priate indicator than T |     |     | for thermal comfort in sum- |     |     |
air
effects of sweat impairments through modeling pro-
|     |     |     |     |     | mertime  | conditions  | [63,74,75].  |     | The  high  | thermal  |
| --- | --- | --- | --- | --- | -------- | ----------- | ------------ | --- | ---------- | -------- |
files with low efficiency in evaporative sweat loss (see
loads under clear-sky conditions also show the impor-
| CHS + Low S | + LS zone in Figure 5c). Low sweat  |     |     |     |     |     |     |     |     |     |
| ----------- | ----------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
eff
tance of strategic urban design and green infrastruc-
efficiency affects the elderly and people who take
ture to mitigate heat, where radiation (e.g. MRT) is
| medications  | such  as  anticholinergics,  |     | antidepres- |     |     |     |     |     |     |     |
| ------------ | ---------------------------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
easily modified through design [76–78].
sants, and opioids (for further information see Ebi
The reduction within Miami in evaporative effi-
et al [1].). Additionally, the inter-individual variabil-
ciency , which is the body’s most efficient way to
ity (by age and body surface area) in heat stress
|     |     |     |     |     | dissipate  | heat  [79],  | was  | represented  | by  | the  high  |
| --- | --- | --- | --- | --- | ---------- | ------------ | ---- | ------------ | --- | ---------- |
obtained with this modeling approach is in accor-
proportion of results within UHS or CHS + Low
dance with the most susceptible groups to heat stress
|                                               |     |     |     |     | S . Physiological research also points to the impor- |     |     |     |     |     |
| --------------------------------------------- | --- | --- | --- | --- | ---------------------------------------------------- | --- | --- | --- | --- | --- |
| described in direct calorimetry studies [23]. |     |     |     |     | eff                                                  |     |     |     |     |     |
tance of humidity and skin wettedness as critical
We also demonstrate the importance of including
factors for comfort, heat stress, and heat strain [80].
people’s activity in PHE assessments. Changes in meta-
Understanding the impact of humidity at high tem-
| bolic heat production (H |     | Þ lead to different E |     | to   |     |     |     |     |     |     |
| ------------------------ | --- | --------------------- | --- | ---- | --- | --- | --- | --- | --- | --- |
|                          |     | prod                  |     | req  |     |     |     |     |     |     |
peratures is paramount when choosing methods to
achieve heat balance, even among people with similar
physiological features in the same environment (see E address PHE in the tropics, where the gap in PHE
req
variations in Figures 6 and 11). H rises with exercise  research and heat mortality studies is large[81].
prod
|            |               |                 |             |     | Lastly,  | the  modeling  |     | scenarios  | highlight  | the  |
| ---------- | ------------- | --------------- | ----------- | --- | -------- | -------------- | --- | ---------- | ---------- | ---- |
| intensity  | and  depends  | on  mechanical  | efficiency  | or  |          |                |     |            |            |      |
twofold role of wind speed in improving or wor-
| movement economy [20,70]. Hence, H |     |     | is a critical  |     |     |     |     |     |     |     |
| ---------------------------------- | --- | --- | -------------- | --- | --- | --- | --- | --- | --- | --- |
prod
sening PHE (Case 3). Wind speed increases the
factor for understanding potential exertional heatstroke
|     |     |     |     |     | convective  | and  | evaporative  |     | heat  | exchanges  |
| --- | --- | --- | --- | --- | ----------- | ---- | ------------ | --- | ----- | ---------- |
[13] and heat-related illnesses among highly vulnerable
|     |     |     |     |     | through  | the  skin  | clothing  | surface  | [20],  | yet  the  |
| --- | --- | --- | --- | --- | -------- | ---------- | --------- | -------- | ------ | --------- |
groups such as outdoor workers and athletes [1,71,72].
|     |     |     |     |     | convective  | impact  | of  | wind  | (gain  or  | loss)  also  |
| --- | --- | --- | --- | --- | ----------- | ------- | --- | ----- | ---------- | ------------ |
E increases with activity level, increasing the required
| req                      |     |                           |     |     | depends on the body-to-air temperature gradient     |     |     |     |     |     |
| ------------------------ | --- | ------------------------- | --- | --- | --------------------------------------------------- | --- | --- | --- | --- | --- |
| skin wettedness (HSI orE |     | : E ) and is thus linked  |     |     |                                                     |     |     |     |     |     |
|                          |     | req max                   |     |     | [82]. For instance, Phoenix was the only city with  |     |     |     |     |     |
to UHS and maintaining a stable internal temperature,
|     |     |     |     |     | a large increase in E |     |     | via incoming convective  |     |     |
| --- | --- | --- | --- | --- | --------------------- | --- | --- | ------------------------ | --- | --- |
req
which is a livability factor (ability to work, exercise, etc.)
|     |     |     |     |     | heat,  while  | higher  | wind  | speeds  | in  Miami  | and  |
| --- | --- | --- | --- | --- | ------------- | ------- | ----- | ------- | ---------- | ---- |
that PHE assessments can also undertake [6].
New York alleviate PHE (Figure 7).
An additional bias unveiled in this research is the  Finally,  many  studies  have  shown  that  sparse
incomplete representation of various types of envir- weather station data can misrepresent people’s IET
onmental heat in PHE assessments. The contrasting  [5,39,48,52]. The microclimate data allow for the ana-
thermal exposures between the summertime PHE of
lysis of thermal compensability during a heatwave at
Phoenix (dry-heat prevalence), Miami (humid-heat
a finer scale. As in Hass et al [48], we found that PHE
prevalence), and New York (mix-type) demonstrate  is more variable using microclimatic data and that
stark differences in CHS and UHS zones by profile. If  UHS  prevalence  is  higher  with  increasing  activity
a  PHE  assessment  relies  solely  on  T (i.e.  IET  level. In general, PHE could be misrepresented by
air

TEMPERATURE 373
weather station data when people modify their beha- (because PHE requires individual travel patterns [2])
vior during peak heat, thus underestimating their heat and the lack of measured or estimated thermal strain.
stress or strain. For instance, Sugg et al [52] indicated We indirectly address the misclassification through
that under high air temperatures there is a decrease in instantaneous thermal load and the compensability of
the agreement between the heat index estimated with heat stress instead of estimating heat storage over time
data from wearables and weather stations, concluding (i.e. heat load for different time intervals and frequen-
that in situ weather stations provide an approximate cies). As we focused on the instantaneous thermal load,
yet imprecise measurement of heat exposure for out- we considered fixed values of time for clothing insula-
door workers. tion, skin temperature, and metabolic rate, which
implies we are also neglecting the behavioral mechan-
isms of thermoregulation to alleviate physiological heat
Advancing future PHE research
strain. Future work should include observational stu-
PHE analyses based on “source-oriented” assess- dies to validate the heat load variability of free-living
ments and population-level thermal indices are people moving through environments. Estimations of
“one-size-fits-all approaches” [83]. In this work, net heat load and heat storage instead of IET will also
we promote a “fit-for-purpose” approach by apply- advance this area of research (e.g. applying thermal
ing fine-scale observations and individualized exposure metrics introduced in Hondula et al [5],
human-environment heat exchange modeling to with heat load, along with heat strain measurements,
estimate CHS and UHS. Analyzing people’s varying as in Sugg et al [52]).
space-time heat transfer informed by their physiol- Future research can go beyond exposure intensity
ogy and particular environmental context provides or only using past data or short time periods to
a more dynamic understanding of thermal load. consider variable exposure doses and expected beha-
Individualized assessments of PHE provide a vioral adaptations. For example, the proposed
more thorough understanding of how people experi- method allows one to estimate minimum thresholds
ence thermal limitations on a daily basis. Holistic of thermal load to develop specific thermal illnesses
PHE assessments will increase personal adaptative (see Cramer and Jay [18]). Since the temporal reso-
capacity and improve monitoring methods at the lution of the input data is important for the whole-
population level. The main challenges for obtaining body heat accumulation over time, sub-hourly
reliable assessments are the availability of accurate observations are required to analyze exertional heat
input data––including adequate physiological inputs stroke, yet epidemiological models of heat deaths
and microclimate physics––and applying an asser- apply 24-h data [6]. In general, future PHE research
tive and empathetic communication method. should strengthen the representation of groups of
According to Krayenhoff et al [84], an assessment concern for adaptation and resilience plans, also
based on modeled results is trustworthy when repre- helping with input information to understand cog-
sentative input is validated. Here, geographical fem- nitive impacts [87], productivity [30], and sleep [88],
inist theories can be adopted [85,86] to incorporate and to further implement evidence-based cooling
multiple viewpoints to improve objectivity and strategies at personal (e.g. clothing), population
recognize knowledge as context-specific. Finally, an (e.g. occupational health policies), and the built
empathetic communication model is relevant environment level (e.g. shade infrastructure) [7].
because PHE research involves working with the
community, which is an opportunity to empower
Conclusions
people with knowledge of their own thermoregula-
tory system and provide them with tools to prevent This study extends heat exposure research by linking
or cope with dangerous heat exposures. PHE to thermal stress and strain over time, incorpor-
ating personal attributes rather than focusing solely
on environmental heat loads. The scope and defini-
Study limitations
tion of PHE were applied to assess compensability
The main limitations of this study are linked to the use under heat stress using a human-environment heat
of stationary measurements in a Lagrangian problem exchange model. We demonstrate how to consider

374 G. GUZMAN-ECHAVARRIA ET AL.
| the  time-space  | variability  | of  whole-body  | net  heat  | Abbreviations |     |     |
| ---------------- | ------------ | --------------- | ---------- | ------------- | --- | --- |
loads, including inter-individual physiologic features
and metabolic heat production, to advance PHE mod-
els. The novel methodology and visualizations illus-
trate the extent and type of heat stress utilizing CHS
|     |     |     |     | Abbreviation | Definition |     |
| --- | --- | --- | --- | ------------ | ---------- | --- |
and UHS zones.
|     |     |     |     | A d | Dubois-Dubois corporal surface area |     |
| --- | --- | --- | --- | --- | ----------------------------------- | --- |
Our results reveal misclassifications of heat stress
|     |     |     |     | C   | Dry heat transfer by convection |     |
| --- | --- | --- | --- | --- | ------------------------------- | --- |
and strain due to an inaccurate differentiation of dry
|     |     |     |     | C resp | Convective exchange by respiratory system |     |
| --- | --- | --- | --- | ------ | ----------------------------------------- | --- |
or humid heat in PHE research. We also demon- C Convective exchange at skin surface
skin
strate the importance of including people’s activity in  CHS Compensable heat stress
PHE  assessments  and  microclimate  data  that  are  E Heat exchange by evaporative heat dissipation
representative  of  people’s  daily  routines.  Criteria  E maxsweat Maximum evaporative heat loss based on
maximum sweat rate
are outlined to provide reliable, accurate, and inclu-
|     |     |     |     | E   | Rate of evaporation given by the atmosphere and  |     |
| --- | --- | --- | --- | --- | ------------------------------------------------ | --- |
max
sive  PHE  evaluations  connecting  exposure,  heat  wettedness limitation of the body
stress, and strain, while using physiological-based  E req Required heat loss to achieve heat balance
methods  to  avoid  misclassifications  of  health  E Evaporative heat loss from respiration
res
| impacts within groups of concern. |              |                     |          | H        | Humidity                                    |     |
| --------------------------------- | ------------ | ------------------- | -------- | -------- | ------------------------------------------- | --- |
|                                   |              |                     |          | H        | Evaporative heat loss from the skin surface |     |
| Our  work                         | initializes  | a  paradigm  shift  | in  PHE  | evapskin |                                             |     |
|                                   |              |                     |          | H prod   | Metabolic heat production                   |     |
research from traditional, instantaneous heat load
|     |     |     |     | I   | Clothing insulation |     |
| --- | --- | --- | --- | --- | ------------------- | --- |
clo
assessments toward dynamic exposure modeling by
|               |                    |       |           | IET   | Individual experienced temperature |       |
| ------------- | ------------------ | ----- | --------- | ----- | ---------------------------------- | ----- |
| employing     | human-environment  | heat  | exchange  |       |                                    |       |
|               |                    |       |           | K     | Dry heat transfer by conduction    |       |
| observations  | and  simulations.  | The   | dynamic   |       |                                    |       |
|               |                    |       |           | Low S | Low sweat efficiency (ω            | >0.5) |
|               |                    |       |           | eff   |                                    | req   |
approach does not separate exposure from health  LS Limited sweat to achieve the required evaporative
loss
outcomes when studying heat contact and recog-
|     |     |     |     | M   | Metabolic rate |     |
| --- | --- | --- | --- | --- | -------------- | --- |
nizes the potential for future work to increase indi-
|     |     |     |     | METs | Metabolic equivalents |     |
| --- | --- | --- | --- | ---- | --------------------- | --- |
vidual adaptative capacity with a focus on vulnerable
|     |     |     |     | mPET | Modified Physiological Equivalent Temperature |     |
| --- | --- | --- | --- | ---- | --------------------------------------------- | --- |
and underrepresented groups in heat risk research.
|     |     |     |     | MRT | Mean radiant temperature                         |     |
| --- | --- | --- | --- | --- | ------------------------------------------------ | --- |
|     |     |     |     | MRT | Mean radiant temperature in clear sky conditions |     |
clearsky
Acknowledgments MRT partlycloudy Mean radiant temperature in partly cloudy
conditions
|     |     |     |     | P   | Atmospheric pressure |     |
| --- | --- | --- | --- | --- | -------------------- | --- |
The authors would like to thank Dr. Ollie Jay for insightful
discussions on the application of the partitional calorimetry  PET Physiological Equivalent Temperature
method  for  the  city  and  person-specific  estimates  in  the  PHE Personal heat exposure
current  paper.  We  would  also  like  to  thank  Dr.  David  R Dry heat transfer by radiation
Hondula for providing important insight into the theoretical  S Rate of internal heat accumulation, heat storage, or
cumulative whole-body thermal load change
framing for this work and Dr. David Sailor for the generous
feedback on the earlier stages of this research. S max Maximum sweat rate
|     |     |     |     | S   | Solar constant |     |
| --- | --- | --- | --- | --- | -------------- | --- |
con
|                      |     |     |     | S in  | Solar incoming radiation |     |
| -------------------- | --- | --- | --- | ----- | ------------------------ | --- |
| Disclosure statement |     |     |     | SR    | Sweat rate               |     |
|                      |     |     |     | T air | Air temperature          |     |
No potential conflict of interest was reported by the author(s).
|     |     |     |     | TMY  | Typical meteorological year                |     |
| --- | --- | --- | --- | ---- | ------------------------------------------ | --- |
|     |     |     |     | TMY3 | Typical meteorological year data version 3 |     |
|     |     |     |     | UHS  | Uncompensable heat stress                  |     |
Funding
|     |     |     |     | UTCI | Universal Thermal Climate Index |     |
| --- | --- | --- | --- | ---- | ------------------------------- | --- |
GEG  and  JKV  acknowledge  funding  from  the  National  UTCI-Fiala  UTCI-Fiala mathematical model of human
Science  Foundation  Award  #CMMI-2045663;  AM  also  model temperature regulation
acknowledges funding from NSF Award #CMMI-1942805.  WBGT Wet bulb globe temperature
During this time, GEG was also funded by an ASU graduate  W External work rate
k
college  Graduate  College,  Arizona  State  University  ω max Maximum skin wettedness
Interdisciplinary Enrichment Research Fellowship. ωreq Skin wettedness

TEMPERATURE 375
ORCID [14] Gagge AP, Gonzalez RR. Mechanisms of Heat Exchange:
Biophysics and Physiology. Handbook of Physiology,
Gisel Guzman-Echavarria http://orcid.org/0000-0002-
Environmental Physiology. American Physiological
4953-8587
Society. 1996: 45–84. doi:10.1002/cphy.cp040104
Ariane Middel http://orcid.org/0000-0002-1565-095X
[15] Ioannou LG, Gkikas G, Mantzios K Risk assessment for
Jennifer Vanos http://orcid.org/0000-0003-1854-9096
heat stress during work and leisure Tsatsakis, Aristides
M, et al. Chapter 32: Toxicological Risk Assessment
and Multi-System Health Impacts from Exposure 1st.
References Academic Press. 2021;373–385. doi:10.1016/B978-
0-323-85215-9.00004-0.
[1] Ebi KL, Capon A, Berry P, et al. Hot weather and heat [16] Ioannou LG, Foster J, Morris NB, et al. Occupational heat
extremes: health risks. Lancet. 2021;398(10301):698– strain in outdoor workers: A comprehensive review and
708. doi:10.1016/S0140-6736(21)01208-3. meta-analysis. Temperature. 2022;9(1):67–102.
[2] Kuras E, Richardson MB, Calkins MM, et al. doi:10.1080/23328940.2022.2030634.
Opportunities and challenges for personal heat expo- [17] Jetté M, Sidney K, Blümchen G. Metabolic equivalents
sure research. Environ Health Perspect. 2017;125 (METS) in exercise testing, exercise prescription, and
(8):085001. doi:10.1289/EHP556.. evaluation of functional capacity. Clin Cardiol. 1990;13
[3] Grundstein A, Vanos J. There is no ’swiss army knife’of (8):555–565. doi:10.1002/clc.4960130809.
thermal indices: the importance of considering [18] Cramer MN, Jay O. Cores of reproducibility in phy-
’why?’and ’for whom?’when modelling heat stress in siology partitional calorimetry. J Appl Physiol.
sport. Br J Sports Med. 2021;55(15):822–824. 2019;126(2):267–277. doi:10.1152/
doi:10.1136/bjsports-2020-102920. japplphysiol.00191.2018.
[4] Nazarian N, Lee JKW. Personal assessment of urban [19] Cheshire WP. Thermoregulatory disorders and illness
heat exposure: a systematic review. Environ Res Lett. related to heat and cold stress. Auton Neurosci Basic
2021;16(3):033005. doi:10.1088/1748-9326/abd350. Clin. 2016;196:91–104. doi:10.1016/j.
[5] Hondula DM, Kuras ER, Betzel S, et al. Novel metrics autneu.2016.01.001.
for relating personal heat exposure to social risk factors [20] Kenny GP, Jay O. Thermometry, calorimetry, and
and outdoor ambient temperature. Environ Int. mean body temperature during heat stress. Compr
2021;146:106271. doi:10.1016/j.envint.2020.106271. Physiol. 2013;3(4):1689–1719. doi:10.1002/cphy.
[6] Vanos JK, Baldwin JW, Jay O, et al. Simplicity lacks c130011.
robustness when projecting heat-health outcomes in [21] Kovats RS, Hajat S. Heat stress and public health: a critical
a changing climate. Nat Commun. 2020;11(1):10–14. review. Annu Rev Public Health. 2008;29(1):41–55.
doi:10.1038/s41467-020-19994-1. doi:10.1146/annurev.publhealth.29.020907.090843.
[7] Jay O, Capon A, Berry P, et al. Reducing the health [22] Foster J, Hodder SG, Lloyd AB, et al. Individual
effects of hot weather and heat extremes: from personal responses to heat stress: implications for hyperthermia
cooling strategies to green cities. Lancet. 2021;398 and physical work capacity. Front Physiol. 2020;11
(10301):709–724. doi:10.1016/S0140-6736(21)01209-5. (541483). doi:10.3389/fphys.2020.541483.
[8] Tuholske C, Caylor K, Funk C, et al. Global urban [23] Flouris AD, McGinn R, Poirier MP, et al. Screening
population exposure to extreme heat. Proc Natl Acad criteria for increased susceptibility to heat stress during
Sci U S A. 2021;118(41):e2024792118. doi:10.1073/ work or leisure in hot environments in healthy indivi-
pnas.2024792118. duals aged 31–70 years. Temperature. 2018;5(1):86–99.
[9] Lioy PJ. Exposure science: a view of the past and mile- doi:10.1016/j.autneu.2016.01.001.
stones for the future. Environ Health Perspect. [24] Vanos JK. Children’s health and vulnerability in out-
2010;118(8):1081–1090. doi:10.1289/ehp.0901634. door microclimates: a comprehensive review. Environ
[10] Bligh J, Johnson KG. Glossary of terms for thermal Int. 2015;76:1–15. doi:10.1016/j.envint.2014.11.016.
physiology. J Appl Physiol. 1973;35(6):941–961. [25] Ramsay EE, Fleming GM, Faber PA, et al. Chronic heat
doi:10.1152/jappl.1973.35.6.941. stress in tropical urban informal settlements. iScience.
[11] Oke TR, Mills G, Christen A, et al. Urban climates. 1st 2021;24(11):103248. doi:10.1016/j.isci.2021.103248.
ed. Cambridge: Cambridge University Press; 2017. [26] Samuelson H, Baniassadi A, Lin A, et al. Housing as
doi:10.1017/9781139016476. a critical determinant of heat vulnerability and health.
[12] Kenny GP, Poirier MP, Metsios GS, et al. Sci Total Environ. 2020;720. doi:10.1016/j.
Hyperthermia and cardiovascular strain during an scitotenv.2020.137296.
extreme heat exposure in young versus older adults. [27] Escandón R, Suárez R, Alonso A, et al. Is indoor over-
Temperature. 2017;4(1):79–88. doi:10.1080/ heating an upcoming risk in southern Spain social
23328940.2016.1230171. housing stocks? Predictive assessment under a climate
[13] Leon LR, Bouchama A. Heat stroke. Compr Physiol. change scenario. Build Environ. 2022;207. doi:10.1016/
2015;5(2):611–647. doi:10.1002/cphy.c140017. j.buildenv.2021.108482.

376 G. GUZMAN-ECHAVARRIA ET AL.
[28] Longo J, Kuras E, Smith H, et al. Technology use, transportation policy under climate change.
exposure to natural hazards, and being digitally invisi- J Transp Heal. 2015;2(4):451–459. doi:10.1016/j.
ble : implications for policy analytics. Policy & Internet. jth.2015.10.001.
2017;9(1):76–108. doi:10.1002/poi3.144. [42] Kuras ER, Hondula DM. Heterogeneity in individually
[29] Nerbass FB, Pecoits-Filho R, Clark WF, et al. experienced temperatures (IETs) within an urban
Occupational heat stress and kidney health: from neighborhood : insights from a new approach to mea-
farms to factories. Kidney Int Reports. 2017;2(6):998– suring heat exposure. Int J Biometeorol. 2015;59
1008. doi:10.1016/j.ekir.2017.08.012. (10):1363–1372. doi:10.1007/s00484-014-0946-x.
[30] Flouris AD, Dinas PC, Ioannou LG, et al. Workers’ health [43] Ioannou LG, Mantzios K, Tsoutsoubi L, et al.
and productivity under occupational heat strain: Indicators to assess physiological heat strain–Part 1:
a systematic review and meta-analysis. Lancet Planet Systematic review. Temperature. 2022; 9(3) :227–262.
Heal. 2018;2(12):e521–e531. doi:10.1016/S2542-5196(18) doi:10.1080/23328940.2022.2037376.
30237-7. [44] Ioannou LG, Tsoutsoubi L, Mantzios K, et al.
[31] Kjellstrom T, Briggs D, Freyberg C, et al. Human Indicators to assess physiological heat strain–Part 3:
performance, and occupational health: a key issue for Multi-country field evaluation and consensus recom-
the assessment of global climate change impacts. Annu mendations. Temperature. 2022;9(3) :274–291.
Rev Public Health. 2016;37(1):97–112. doi:10.1146/ doi:10.1080/23328940.2022.2044739.
annurev-publhealth-032315-021740. [45] Dufour A, Candas V. Ageing and thermal responses
[32] Castillo F, Mora AM, Kayser GL, et al. Environmental during passive heat exposure: sweating and sensory
health threats to latino migrant farmworkers. Annu aspects. Eur J Appl Physiol. 2007;100(1):19–26.
Rev Public Health. 2020;42(1):257–276. doi:10.1146/ doi:10.1007/s00421-007-0396-9.
annurev-publhealth-012420-105014. [46] Inoue Y, Nakao M, Araki T, et al. Regional differences
[33] Moohialdin A, Trigunarsyah B, Islam MS, et al. in the sweating responses of older and younger men.
Physiological impacts on construction workers under J Appl Physiol. 1991;71(6):2453–2459. doi:10.1152/
extremely hot and humid weather. Int Arch Occup jappl.1991.71.6.2453.
Environ Health. 2022;95(2):315–329. doi:10.1007/ [47] Solís P, Vanos JK, Forbis RE. The decision-making/
s00420-021-01785-w. accountability spatial incongruence problem for research
[34] Runkle JD, Cui C, Fuhrmann C, et al. Evaluation of linking environmental science and policy. Geogr Rev.
wearable sensors for physiologic monitoring of indivi- 2017;107(4):680–704. doi:10.1111/gere.12240.
dually experienced temperatures in outdoor workers in [48] Hass AL, McCanless K, Cooper W, et al. Heat exposure
southeastern U.S. Environ Int. 2019;129(August misclassification : do current methods of classifying
2019):229–238. doi:10.1016/j.envint.2019.05.026citat. diurnal range in individually experienced temperatures
[35] Ioannou LG, Mantzios K, Tsoutsoubi L, et al. and heat indices accurately reflect personal exposure ?
Occupational heat stress: multi-country observations Int J Biometeorol. 2022;66(7):1339–1348. doi:10.1007/
and interventions. Int J Environ Res Public Health. s00484-022-02280-8.
2021;18(12):6303. doi:10.3390/ijerph18126303. [49] Ioannou LG, Mantzios K, Tsoutsoubi L, et al. Effect of
[36] Jay O, Brotherhood JR. Occupational heat stress in a simulated heat wave on physiological strain and
Australian workplaces. Temperature. 2016;3(3):394– labour productivity. Int J Environ Res Public Health.
411. doi:10.1080/23328940.2016.1216256. 2021;18(6):3011. doi:10.3390/ijerph18063011.
[37] Cheng W, Li D, Liu Z, et al. Approaches for identifying [50] González-alonso J, Crandall CG, Johnson JM. The car-
heat-vulnerable populations and locations: a systematic diovascular challenge of exercising in the heat.
review. Sci Total Environ. 2021;799:149417. J Physiol. 2008;586(1):45–53. doi:10.1113/
doi:10.1016/j.scitotenv.2021.149417. jphysiol.2007.142158.
[38] Brimicombe C, Di Napoli C, Cornforth R, et al. [51] Périard JD, Racinais S, Sawka MN. Adaptations and
Borderless heat hazards with bordered impacts. mechanisms of human heat acclimation: applications
Earth’s Futur. 2021;9(9). doi: 10.1029/2021EF002064. for competitive athletes and sports. Scand J Med Sci
[39] Bernhard MC, Kent ST, Sloan ME, et al. Measuring Sports. 2015;25(S1):20–38. doi:10.1111/sms.12408.
personal heat exposure in an urban and rural [52] Sugg MM, Runkle JD, Dow K , et al. Individually
environment. Environ Res. 2015;137:410–418. experienced heat index in a coastal Southeastern US
doi:10.1016/j.envres.2014.11.002. city among an occupationally exposed population.
[40] Harlan SL, Brazel AJ, Prashad L, et al. Neighborhood Int J Biometeorol. 2022;66(8):1665–1681. doi:10.1007/
microclimates and vulnerability to heat stress. Soc Sci s00484-022-02309-y.
Med. 2006;63(11):2847–2863 doi:10.1016/j. [53] Hass AL, Ellis KN. Using wearable sensors to assess how
socscimed.2006.07.030. a heatwave affects individual heat exposure, perceptions,
[41] Karner A, Hondula DM, Vanos JK. Heat exposure and adaption methods. Int J Biometeorol. 2019;63
during non-motorized travel: implications for (12):1585–1595. doi:10.1007/s00484-019-01770-6.

TEMPERATURE 377
[54] Sugg MM, Fuhrmann CM, Runkle JD. Temporal and [68] Brotherhood JR. Heat stress and strain in exercise and
spatial variation in personal ambient temperatures for sport. J Sci Med Sport. 2008;11(1):6–19. doi:10.1016/j.
outdoor working populations in the southeastern USA. jsams.2007.08.017.
Int J Biometeorol. 2018;62(8):1521–1534. doi:10.1007/ [69] Cramer MN, Jay O. Biophysical aspects of human
s00484-018-1553-z. thermoregulation during heat stress. Auton Neurosci
[55] Ioannou LG, Tsoutsoubi L, Mantzios K, et al. The Basic Clin. 2016;196:3–13. doi:10.1249/MSS.0b013e31
impacts of sun exposure on worker physiology and 821ece12.
cognition: multi-country evidence and interventions. [70] Havenith G, Fiala D. Thermal indices and thermophy-
Int J Environ Res Public Health. 2021;18(14):7698. siological modeling for heat stress. Compr Physiol.
doi:10.3390/ijerph18147698. 2016;6(1):255–302. doi:10.1002/cphy.c140051.
[56] Sulzer M, Christen A, Matzarakis A. A low-cost sensor [71] Flouris AD, Schlader ZJ. Human behavioral ther-
network for real-time thermal stress monitoring and com- moregulation during exercise in the heat. Scand
munication in occupational contexts. Sensors. 2022;22 J Med Sci Sports. 2015;25(S1):52–64. doi:10.1111/
(5):1828. Published online 2022. doi:10.3390/s22051828. sms.12349.
[57] Hwang S, Lee SH. Wristband-type wearable health [72] Hosokawa Y, Adams WM, Casa DJ, et al. Roundtable on
devices to measure construction workers’ physical preseason heat safety in secondary school athletics: environ-
demands. Autom Constr. 2017;83(June):330–340. mental monitoring during activities in the heat. J Athl Train.
doi:10.1016/j.autcon.2017.06.003. 2021;56(4):362–371. doi:10.4085/1062-6050-0067.20.
[58] Campbell M, Marek L, Hobbs M. Reconsidering move- [73] McGregor GR, Vanos JK. Heat: a primer for public
ment and exposure: towards a more dynamic health health researchers. Public Health. 2018;161:138–146.
geography. Geogr Compass. 2021;15(6):e12566. doi:10.1016/j.puhe.2017.11.005.
doi:10.1111/gec3.12566. [74] Middel A, AlkhaLed S, Schneider FA, et al. 50 Grades
[59] Winslow C-EA, Herrington LP, Gagge AP. of Shade. Bull Am Meteorol Soc. 2021;102(9) :E1805–
Physiological reactions of the human body to varying E1820. doi:10.1175/BAMS-D-20-0193.1.
environmental temperatures. Am J Physiol Content. [75] Middel A, Selover N, Hagen B, et al. Impact of shade on
1937;120(1):1–22. doi:10.1152/ajplegacy.1937.120.1.1. outdoor thermal comfort—a seasonal field study in Tempe,
[60] Morris NB, Chaseling GK, English T, et al. Electric fan Arizona. Int J Biometeorol. 2016;60(12):1849–1861.
use for cooling during hot weather: a biophysical mod- doi:10.1007/s00484-016-1172-5.
elling study. Lancet Planet Heal. 2021;5(6):e368–e377. [76] Tsunematsu N, Yokoyama H, Honjo T, et al.
doi:10.1016/S2542-5196(21)00136-4. Relationship between land use variations and spatiotem-
[61] Drinkwater BL, Bedi JF, Loucks AB, et al. Sweating poral changes in amounts of thermal infrared energy
sensitivity and capacity of women in relation to age. emitted from urban surfaces in downtown Tokyo on
J Appl Physiol. 1982;53(3):671–676. doi:10.1152/ hot summer days. Urban Clim. 2016;17 September 2016
jappl.1982.53.3.671. :67–79. doi:10.1016/j.uclim.2016.03.002.
[62] Wilcox S, Marion W. Users Manual for TMY3 Data [77] Brown RD, Gillespie TJ. Microclimate landscape
Sets. NREL/TP-581-43156. NREL. 2008. design: creating thermal comfort and energy efficiency.
[63] Middel A, Krayenhoff ES. Micrometeorological deter- New York: John Wiley & Sons; 1995.
minants of pedestrian thermal exposure during [78] Lachapelle JA, Krayenhoff ES, Middel A, et al.
record-breaking heat in Tempe, Arizona: introducing Landscape and Urban Planning Maximizing the pedes-
the MaRTy observational platform. Sci Total Environ. trian radiative cooling benefit per street tree. Landsc
2019;687:137–151. doi:10.1016/j.scitotenv.2019.06.085. Urban Plan. 2023;230(June 2022):104608. doi:10.1016/
[64] NWS. NWS Phoenix Heat Page. Historical heat warn- j.landurbplan.2022.104608.
ing dates. Published 2022. Cited 2022 Oct 5. https:// [79] Vecellio DJ, Wolf ST, Cottle RM, et al. Evaluating the
www.weather.gov/psr/heat 35°C wet-bulb temperature adaptability threshold for
[65] Fiala D, Havenith G, Bröde P, et al. UTCI-Fiala young, healthy subjects (PSU HEAT Project). J Appl
multi-node model of human heat transfer and tempera- Physiol. 2022;132(2):340–345. doi:10.1152/
ture regulation. Int J Biometeorol. 2012;56(3):429–441. japplphysiol.00738.2021.
doi:10.1007/s00484-011-0424-7. [80] Vargas NT, Chapman CL, Ji W, et al. Increased skin
[66] ISO. ISO 7933:2004 ergonomics of the thermal envir- wetness independently augments cool-seeking beha-
onment - analytical determination and interpretation viour during passive heat stress. J Physiol. 2020;598
of heat stress using calculation of the predicted heat (13):2775–2790. doi:10.1113/JP279537.
strain.2nd. Geneva: International Organization for [81] Green H, Bailey J, Schwarz L, et al. Impact of heat on
Standardization.2004. pp. 34. mortality and morbidity in low and middle income
[67] Ainsworth BE, Haskell WL, Herrmann SD, et al. 2011 countries: a review of the epidemiological evidence
compendium of physical activities: a second update of and considerations for future research. Environ Res.
codes and MET values. Med Sci Sports Exerc. 2011;43 2019;171(September 2018):80–91. doi:10.1016/j.
(8):1575–1581 doi:10.1249/MSS.0b013e31821ece12. envres.2019.01.010.

378 G. GUZMAN-ECHAVARRIA ET AL.
[82] Morris NB, English T, Hospers L, et al. The effects of [85] Haraway D. Situated knowledges: the science question in
electric fan use under differing resting heat index con- feminism and the privilege of partial perspective. Feminist
ditions: a clinical trial. Ann Intern Med. 2019;171 Studies. 1988;14(3):575–599. doi:10.2307/3178066.
(9):675–677. doi:10.7326/M19-0512. [86] Harding SG. The feminist standpoint theory reader: intel-
[83] Nazarian N, Krayenhoff ES, Bechtel B, et al. Integrated lectual and political controversies. New York: Routledge;
assessment of urban overheating impacts on human 2004.
life. Earth’s Future. 2022(10):8. ISSN:23284277. [87] Piil JF, Christiansen L, Morris NB, et al. Direct expo-
doi:10.1029/2022EF002682. https://agupubs.onlineli sure of the head to solar heat radiation impairs
brary.wiley.com/doi/abs/10.1029/2022EF002682 motor-cognitive performance. Sci Rep. 2020;10
[84] Krayenhoff ES, Broadbent AM, Zhao L, et al. Cooling (1):7812. doi:10.1038/s41598-020-64768-w.
hot cities: a systematic and critical review of the [88] Minor K, Bjerre-Nielsen A, Jonasdottir SS, et al. Rising
numerical modelling literature. Environ Res Lett. temperatures erode human sleep globally. One Earth.
2021;16(5):053007. doi:10.1088/1748-9326/abdcf1. 2022;5(5):534–549. doi:10.1016/j.oneear.2022.04.008.
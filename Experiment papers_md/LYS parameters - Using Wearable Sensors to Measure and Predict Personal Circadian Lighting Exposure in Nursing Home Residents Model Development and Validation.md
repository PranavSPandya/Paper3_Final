JMIR AGING Beiglary et al
Original Paper
Using Wearable Sensors to Measure and Predict Personal
Circadian Lighting Exposure in Nursing Home Residents:
Model Development and Validation
Shevvaa Beiglary1, MS; Yanxiao Feng2, PhD; Nan Wang3, PhD; Neda Ghaeili1, MS; Ying-Ling Jao4, PhD; Yo-Jen
Liao4, PhD; Yuxin Li1, BAE; Julian Wang1, EngD, PhD
1Department of Architectural Engineering, Pennsylvania State University, University Park, PA, United States
2School of Applied Engineering and Technology, New Jersey Institute of Technology, Newark, NJ, United States
3Department of Civil and Environmental Engineering, Northwestern University, Evanston, IL, United States
4Ross and Carol Nese College of Nursing, Pennsylvania State University, University Park, PA, United States
Corresponding Author:
Julian Wang, EngD, PhD
Department of Architectural Engineering
Pennsylvania State University
556 White Course Drive
University Park, PA 16802
United States
Phone: 1 814-865-6394
Email: jqw5965@psu.edu
Abstract
Background: Lighting, especially circadian lighting, significantly affects people with dementia, influencing sleep patterns,
daytime alertness, and behavioral symptoms such as agitation. Since individuals experience and respond to light differently,
measuring personal lighting exposure is essential for understanding its impact on health. Without individual data, the connec-
tion between lighting and health outcomes remains unclear. Wearable sensors provide a practical way to track personal light
exposure, helping researchers better assess its effects on circadian rhythms and overall well-being.
Objective: This study aims to develop and validate both calibration and predictive models using wearable lighting sensors
to assess individual circadian lighting exposure accurately. By leveraging machine learning techniques and empirical data, we
seek to establish a reliable method for health care researchers and practitioners to investigate and optimize lighting conditions
for improved circadian health in nursing homes, especially for residents with dementia.
Methods: A combination of controlled laboratory experiments and on-site data collection was conducted using professional
spectrophotometer measurements as ground truth. Calibration models were developed for photopic lux and correlated color
temperature, while predictive models estimated circadian metrics such as circadian stimulus. The sensors and the developed
models were implemented in a real-world health care research project about bright light therapy intervention at 2 assisted-liv-
ing facilities.
Results: The calibration models for photopic lux and correlated color temperature demonstrated strong accuracy, with an
adjusted R² of 0.858 and 0.982, respectively, ensuring reliable sensor measurements. Predictive models for circadian stimulus
were developed using both simple regression and machine learning techniques. The random forest model outperformed linear
regression, achieving an adjusted R² of 0.915 and a cross-validation R² of 0.857, demonstrating high generalization capability.
Upon the implementation of these models, significant individual variations in circadian light exposure were found in the study,
highlighting the significance of customized lighting evaluations. These results confirm the effectiveness of wearable sensors,
combined with the developed calibration and predictive modeling, in accurately assessing personal circadian light exposure
and supporting lighting-related health care research.
Conclusions: This study introduces an effective and scalable approach to circadian light assessment using wearable sensors
and predictive modeling. By replacing labor-intensive and costly spectrometer measurements, the proposed methodology
enables continuous, cost-effective monitoring in health care environments. However, challenges related to sensor wearability,
durability, and user compliance were identified, underscoring the need for further sensor design refinements. Future research
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 1
(page number not for citation purposes)

| JMIR AGING |     |     |     |     |     |     |     |     |     |     |     |     | Beiglary et al |
| ---------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------------- |
should focus on refining sensor integration, expanding case studies, and developing adaptive lighting interventions to enhance
circadian health in vulnerable populations.
JMIR Aging 2025;8:e72338; doi: 10.2196/72338
Keywords:  circadian;  lighting;  wearable  sensors;  long-term  care  facilities;  predictive  modeling;  personalized  lighting
assessment; dementia; Alzheimer disease
| Introduction |     |     |     |     |     |     |     | Personal Circadian Lighting Exposure |     |     |     |     |     |
| ------------ | --- | --- | --- | --- | --- | --- | --- | ------------------------------------ | --- | --- | --- | --- | --- |
Assessing individual circadian lighting exposure has become
Background of Circadian Lighting and
|     |     |     |     |     |     |     |     | increasingly  | vital  in  the  | health  | care  | sector,  | especially |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --------------- | ------- | ----- | -------- | ---------- |
Health in  long-term  care  facilities,  where  individuals’  circadian
|             |            |     |         |        |          |            |     | rhythms  | can  be  profoundly  |     | affected  | by  | their  lighting |
| ----------- | ---------- | --- | ------- | ------ | -------- | ---------- | --- | -------- | -------------------- | --- | --------- | --- | --------------- |
| The  human  | circadian  |     | system  | is  a  | complex  | biological |     |          |                      |     |           |     |                 |
conditions. In recent years, there has been an increasing focus
mechanism that regulates various physiological and behav-
on the advancement of wearable sensor technologies capable
| ioral  processes,  |     | including  | sleep-wake  |     | cycles,  | hormone |     |                |                    |     |              |     |                  |
| ------------------ | --- | ---------- | ----------- | --- | -------- | ------- | --- | -------------- | ------------------ | --- | ------------ | --- | ---------------- |
|                    |     |            |             |     |          |         |     | of  precisely  | and  conveniently  |     | quantifying  |     | an  individual’s |
secretion, and cognitive function [1]. This system is primarily
|     |     |     |     |     |     |     |     | light  exposure  | throughout  | the  | day.  | This  | is  crucial  for |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | ----------- | ---- | ----- | ----- | ---------------- |
entrained by light-dark cycles, with exposure to light during
comprehending the effects of lighting on circadian rhythms,
the day and darkness at night being crucial for maintaining
hormonal balance, and overall health and wellness.
a healthy circadian rhythm [2,3]. Disruption of the circadian
system, commonly known as circadian rhythm disruption, The  significance  of  precisely  quantifying  individual
has been associated with a wide range of adverse health circadian lighting exposure in nursing homes is paramount.
outcomes,  including  sleep  disorders,  metabolic  disorders, Multiple studies have underscored the significant impact of
cardiovascular  diseases,  and  even  certain  types  of  cancer lighting on the physical and mental health of older adults,
especially those with dementia. A study by Figueiro et al
[1,4].
[15] demonstrated that customized lighting interventions in
| Lighting  | plays  | a  crucial  | role  | in  | the  entrainment  |     | of  |            |                   |           |     |          |              |
| --------- | ------ | ----------- | ----- | --- | ----------------- | --- | --- | ---------- | ----------------- | --------- | --- | -------- | ------------ |
|           |        |             |       |     |                   |     |     | long-term  | care  facilities  | resulted  | in  | notable  | enhancements |
the circadian system. Exposure to light, particularly blue-
in sleep, depression, and agitation among individuals with
enriched short-wavelength light, during the biological night
|     |     |     |     |     |     |     |     | dementia.  | This  highlights  | the  | necessity  | for  | precise  and |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ----------------- | ---- | ---------- | ---- | ------------ |
can suppress the production of melatonin, a key hormone
individualized lighting exposure data to guide the design and
| involved  | in  the  | regulation  | of  | the  sleep-wake  |     | cycle  | [5,6]. |     |     |     |     |     |     |
| --------- | -------- | ----------- | --- | ---------------- | --- | ------ | ------ | --- | --- | --- | --- | --- | --- |
execution of these interventions.
| This  suppression  |     | can  lead  | to  | disruptions  | in  | the  circadian |     |               |                |     |                     |     |         |
| ------------------ | --- | ---------- | --- | ------------ | --- | -------------- | --- | ------------- | -------------- | --- | ------------------- | --- | ------- |
|                    |     |            |     |              |     |                |     | Nonetheless,  | the  existing  |     | spectrometer-based  |     | methods |
rhythm and associated health problems. Conversely, exposure
to appropriate lighting during the day can help maintain a for  quantifying  individual  circadian  lighting  exposure  are
healthy circadian rhythm and promote various physiological frequently  unfeasible  for  extensive  application  in  nursing
and cognitive benefits [7]. homes and other health care environments. These devices
are generally cumbersome, expensive, and labor-intensive,
In the context of nursing homes, residents often experience
rendering them inappropriate for prolonged monitoring and
disruptions in their circadian rhythms due to a variety of
|     |     |     |     |     |     |     |     | ongoing  | data  collecting.  | Markvart  | et  | al  [16]  | underscored |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ------------------ | --------- | --- | --------- | ----------- |
factors, including reduced exposure to natural light, irregu-
the difficulties in calibrating and rectifying the output from
| lar  sleep-wake  |     | patterns,  | and  the  | use  | of  artificial  | lighting |     |     |     |     |     |     |     |
| ---------------- | --- | ---------- | --------- | ---- | --------------- | -------- | --- | --- | --- | --- | --- | --- | --- |
wearable light exposure devices, stressing the necessity for
that may not be optimized for circadian entrainment [8,9].
more efficient but effective measuring technology.
These disruptions can have significant negative impacts on
Proposed Work
the health and well-being of nursing home residents, leading
| to  an  increased  |     | risk  of  | sleep  | disorders,  | cognitive  | impair- |     |           |                        |     |             |         |            |
| ------------------ | --- | --------- | ------ | ----------- | ---------- | ------- | --- | --------- | ---------------------- | --- | ----------- | ------- | ---------- |
|                    |     |           |        |             |            |         |     | In  this  | study,  we  developed  |     | predictive  | models  | to  assess |
ment, and other chronic health conditions [9]. Recent studies
personal circadian lighting exposure using wearable lighting
have further highlighted the importance of circadian-effective
|     |     |     |     |     |     |     |     | sensors.  | These  sensors  | measured  | key  | lighting  | parameters, |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | --------------- | --------- | ---- | --------- | ----------- |
lighting interventions in improving sleep quality, circadian
including correlated color temperature (CCT), photopic lux,
| rhythms,  | and  | depression  | in  older  | adults  | with  | dementia |     |                  |             |      |                 |     |               |
| --------- | ---- | ----------- | ---------- | ------- | ----- | -------- | --- | ---------------- | ----------- | ---- | --------------- | --- | ------------- |
|           |      |             |            |         |       |          |     | and  irradiance  | levels  at  | the  | RGB  channels.  |     | The  calibra- |
[10-12].
|     |     |     |     |     |     |     |     | tion  of  | these  measurements  |     | was  meticulously  |     | conducted |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | -------------------- | --- | ------------------ | --- | --------- |
Moreover,  researchers  have  emphasized  the  need  for through  controlled  laboratory  experiments  under  various
tailored lighting solutions that consider the specific needs and electrical lighting conditions, supplemented by on-site data
characteristics of the nursing home population. For exam- collection using professional instruments to ensure accuracy.
ple, Figueiro et al [13,14] have discussed the importance The predictive models, built upon these calibrated lighting
of circadian lighting for older adults with dementia, as well
|     |     |     |     |     |     |     |     | parameters,  | were  designed  | to  | predict  | circadian  | melanopic |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | --------------- | --- | -------- | ---------- | --------- |
as explored the role of light and circadian rhythms in this lux, melanopic equivalent daylight illuminance, and circadian
population. stimulus (CS) values. To demonstrate the practical applica-
tion of these wearable sensors and the developed models,
we employed them in a bright light therapy project within
2 nursing homes. Here, we analyzed variations in circadian
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 2
(page number not for citation purposes)

| JMIR AGING |     |     |     |     |     |     |     |     |     |     |     |     |     | Beiglary et al |
| ---------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------------- |
lighting exposure across different individuals, showcasing the measurement of light exposure is not feasible, such as in
models’ effectiveness in capturing personal circadian light large-scale studies or in environments where spectroradiome-
(CL) environments and their potential impact on health and ters are not available.
well-being.
|     |     |     |     |     |     |     |     | In  the  | context  | of  nursing  | homes,  |     | the  use  | of  wearable |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | -------- | ------------ | ------- | --- | --------- | ------------ |
Scientific Contributions sensors and predictive modeling techniques can be particu-
larly valuable for assessing the CL exposure of residents.
| This  work  | makes  |     | significant  | scientific  | contributions  |     | by  |     |     |     |     |     |     |     |
| ----------- | ------ | --- | ------------ | ----------- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
By combining these methods with the data obtained from
| introducing  | calibration  |     | and  | predictive  | models  | built  | upon |     |     |     |     |     |     |     |
| ------------ | ------------ | --- | ---- | ----------- | ------- | ------ | ---- | --- | --- | --- | --- | --- | --- | --- |
spectroradiometers, researchers and health care professionals
| machine  | learning  | algorithms  |     | and  rigorous  |     | datasets,  | which |     |     |     |     |     |     |     |
| -------- | --------- | ----------- | --- | -------------- | --- | ---------- | ----- | --- | --- | --- | --- | --- | --- | --- |
can gain a more comprehensive understanding of the lighting
effectively  replace  the  costly  and  complex  processes  of conditions in nursing homes and develop targeted interven-
| spectrometer  | measurement  |     |     | and  circadian  | lighting  |     | calcula- |                      |     |            |              |     |      |              |
| ------------- | ------------ | --- | --- | --------------- | --------- | --- | -------- | -------------------- | --- | ---------- | ------------ | --- | ---- | ------------ |
|               |              |     |     |                 |           |     |          | tions  to  optimize  |     | circadian  | entrainment  |     | and  | improve  the |
tions. These models enable accurate prediction of circadian
health and well-being of residents [17,23].
melanopic lux and CS values via basic lighting measures,
Wearable Sensors for Circadian Lighting
making long-term monitoring of personal circadian lighting
Measurements
exposure feasible with wearable sensors.
| Furthermore,  |     | by  | showcasing  | the  | application  | of  | these |                |       |            |     |              |     |              |
| ------------- | --- | --- | ----------- | ---- | ------------ | --- | ----- | -------------- | ----- | ---------- | --- | ------------ | --- | ------------ |
|               |     |     |             |      |              |     |       | Recent  years  | have  | witnessed  |     | initiatives  | to  | create  more |
models  in  real-world  settings,  the  study  highlights  the compact,  cost-effective,  and  user-friendly  wearable  sensor
significant  variability  in  CL  exposure  among  individu- devices  for  tracking  personal  circadian  lighting  exposure.
| als,  underscoring  |     | the  | importance  | of  | personalized  |     | lighting |                 |       |     |          |      |               |          |
| ------------------- | --- | ---- | ----------- | --- | ------------- | --- | -------- | --------------- | ----- | --- | -------- | ---- | ------------- | -------- |
|                     |     |      |             |     |               |     |          | These  devices  | seek  | to  | address  | the  | shortcomings  | of  con- |
assessments. ventional spectrometer-based solutions, offering a practical
Finally,  by  facilitating  wearable  technology  for  CL and accessible method for evaluating an individual’s light
exposure throughout the day.
| assessment,  | this  | study  | paves  | the  way  | for  | more  accessi- |     |     |     |     |     |     |     |     |
| ------------ | ----- | ------ | ------ | --------- | ---- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- |
ble and practical approaches to understanding and optimiz-
|     |     |     |     |     |     |     |     | A  primary  | difficulty  |     | in  the  | development  |     | of  wearable |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ----------- | --- | -------- | ------------ | --- | ------------ |
ing light environments for individual circadian health and sensor  systems  is  the  compromise  between  measurement
well-being, particularly in contexts such as nursing homes precision and user comfort. Figueiro et al [17] evaluated the
where continuous monitoring is crucial.
efficacy of 3 practical field devices for measuring individual
light exposures and activity levels, underscoring the necessity
Literature Review: Current Circadian
Lighting Measurement Methods for more adaptable and precise wearable sensor technolo-
|     |     |     |     |     |     |     |     | gies.  The  | contemporary  |     | generation  | of  | spectrometer-based |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ------------- | --- | ----------- | --- | ------------------ | --- |
systems frequently compromises wearability because of their
| Accurate  | measurement  |     | of  | CL  exposure  | is  | essential  | for |     |     |     |     |     |     |     |
| --------- | ------------ | --- | --- | ------------- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
understanding the impact of lighting on the human circa- dimensions and measurement principles, in addition to being
expensive and labor-intensive to operate.
dian system and for developing effective lighting interven-
tions. One of the primary instruments used for measuring
|               |     |          |                     |     |        |     |         | Researchers  | are  | investigating  |     | alternate  |     | methods  for |
| ------------- | --- | -------- | ------------------- | --- | ------ | --- | ------- | ------------ | ---- | -------------- | --- | ---------- | --- | ------------ |
| CL  exposure  |     | is  the  | spectroradiometer,  |     | which  | is  | capable |              |      |                |     |            |     |              |
measuring human circadian illumination exposure to tackle
| of  providing  |     | detailed  | spectral  | information  |     | about  the  | light |     |     |     |     |     |     |     |
| -------------- | --- | --------- | --------- | ------------ | --- | ----------- | ----- | --- | --- | --- | --- | --- | --- | --- |
these problems. A recent work by Wang et al [24] intro-
environment [17,18].
|     |     |     |     |     |     |     |     | duced  an  | innovative  | wearable  |     | sensor  | device  | that  integra- |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ----------- | --------- | --- | ------- | ------- | -------------- |
tes a tiny light sensor with a microcontroller and wireless
Spectroradiometers are sophisticated instruments that can
measure the spectral power distribution (SPD) of light, which communication features, facilitating continuous and discreet
monitoring of an individual’s light exposure. This integra-
is the relative energy of the different wavelengths of light
present in a given environment. This information can be used ted sensor system has the potential to address the shortcom-
to calculate various metrics related to CL exposure, such as ings of conventional spectrometer-based solutions, facilitating
broader implementation in nursing homes and other health
the CL adjusted (CLA) and the CS [19,20].
care environments.
In addition to spectroradiometers, other instruments such
Kubicki et al [25] created a wearable sensor platform that
as wearable light sensors and calibrated digital cameras have
also been used to measure CL exposure [17,18,21]. These integrates  numerous  light  sensors  and  a  machine  learn-
|     |     |     |     |     |     |     |     | ing  algorithm  | to  | assess  | circadian-effective  |     | light  | exposure, |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- | ------- | -------------------- | --- | ------ | --------- |
methods offer the advantage of being able to capture light
exposure data over an extended period, providing a more offering a more precise and user-friendly option than current
comprehensive understanding of an individual’s CL exposure systems.  This  advanced  sensor  technology,  together  with
predictive modeling and data analysis, enables health care
patterns.
providers to comprehend the correlation between lighting and
Predictive modeling approaches have also been developed
the health and well-being of nursing home residents more
to estimate CL exposure based on various environmental and
effectively.
personal factors. For example, models have been proposed
|     |     |     |     |     |     |     |     | Emerging  | sensor  | technologies  |     | may  | provide  | exciting |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ------- | ------------- | --- | ---- | -------- | -------- |
that use information about the location, time of day, and
weather conditions to predict the spectral composition and opportunities to assist people with dementia and their carers
intensity  of  light  in  a  given  environment  [7,22].  These in the context of an aging population. Lu et al [26] provi-
ded an in-depth examination of how wearable health devices
models can be particularly useful in situations where direct
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 3
(page number not for citation purposes)

| JMIR AGING |     |     |     |     |     |     |     |     |     |     | Beiglary et al |
| ---------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------------- |
can noninvasively measure vital signs, activity, and sleep in a  US  $25  gift  card  per  visit.  All  hard  copy  documents
people  with  vulnerabilities,  such  as cognitive  impairment. containing  identifiable  information  were  stored  in  locked,
Such technologies offer the advantage of being passive (ie, secure cabinets accessible only to institutional review board–
no active engagement necessary on the part of the person with approved research team members. Electronic research data
dementia) and are capable of continuous data collection. On were deidentified and stored on a secure research drive at
this basis, Tiersen et al [27] used user-centered design to Penn State, accessible only to authorized members of the
| design smart home sensing solutions for dementia house- |                   |     |       |                    |     |            | research team. |     |     |     |     |
| ------------------------------------------------------- | ----------------- | --- | ----- | ------------------ | --- | ---------- | -------------- | --- | --- | --- | --- |
| holds,                                                  | highlighting the  |     | need  | for  personalized  |     | monitoring |                |     |     |     |     |
Experiments and Data Collection
solutions that address the issues both patients and caregivers
Procedure
face in their day-to-day life.
To obtain comprehensive and sufficient datasets (Multime-
| Furthermore,  |     | Rose  | et  al  | [28]  addressed  | the  | emotional |     |     |     |     |     |
| ------------- | --- | ----- | ------- | ---------------- | ---- | --------- | --- | --- | --- | --- | --- |
and  psychological  consequences  of  the  introduction  of dia Appendix 1) for subsequent calibration and modeling,
|                     |     |      |           |         |              |         | we  conducted  | both  laboratory  |     | experiments  | and  field  data |
| ------------------- | --- | ---- | --------- | ------- | ------------ | ------- | -------------- | ----------------- | --- | ------------ | ---------------- |
| such  technologies  |     | and  | reported  | family  | caregivers’  | overall |                |                   |     |              |                  |
acceptability of using digital technology to record stress, but collection  in  2  assisted-living  facilities.  The  laboratory
significant concerns were expressed about privacy invasion experiments and data collection were completed at the Penn
State Architectural Engineering Lighting Laboratory.
and technical complexity. Taking these concerns head-on,
Berridge et al [29] created a new self-administered deci-
|     |     |     |     |     |     |     | Using  a  | professional  | spectrophotometer,  |     | we  obtained |
| --- | --- | --- | --- | --- | --- | --- | --------- | ------------- | ------------------- | --- | ------------ |
sion  support  tool  to  facilitate  early  advance planning  for ground truth data by placing 3 randomly selected wearable
| technology  | use  | in  dementia  |     | care,  allowing  | people  | in  the |     |     |     |     |     |
| ----------- | ---- | ------------- | --- | ---------------- | ------- | ------- | --- | --- | --- | --- | --- |
sensors and the spectrophotometer in the same position in
early stages of cognitive impairment to continue to com-
the laboratory under various electrical lighting conditions.
| municate  | their  | preferences  |     | about  future  | monitoring  | and |     |     |     |     |     |
| --------- | ------ | ------------ | --- | -------------- | ----------- | --- | --- | --- | --- | --- | --- |
Moreover, to ensure the accuracy and reliability of using
assistance technologies before declining to more advanced
such models in assisted living facilities, we also conducted
impairment. Together, these studies provide evidence that, a similar procedure and setup in 2 selected nursing homes.
albeit advantages of sensor technologies for monitoring and
In the laboratory, we simulated relatively more controlla-
providing services to individuals with dementia, implementa-
ble lighting scenarios compared with the field, where we
tion should take into account user preferences, safeguarding
|     |     |     |     |     |     |     | conducted  | several  site  | visits  | on  different  | days  to  capture |
| --- | --- | --- | --- | --- | --- | --- | ---------- | -------------- | ------- | -------------- | ----------------- |
the patient’s privacy, and integrating sensors in existing care
|     |     |     |     |     |     |     | variations  | related  to  | weather,  | room  conditions,  | and  inte- |
| --- | --- | --- | --- | --- | --- | --- | ----------- | ------------ | --------- | ------------------ | ---------- |
practices. rior setup. The same set of instruments, wearable sensors,
methods, and experimental setup was used for both labora-
Methods
tory and field measurements. Figure 1 shows the diagram
of the major instruments used in this study. The spectropho-
Ethical Considerations tometer (CL500) output for photopic lux and CCT served
as the reference for calibrating the wearable sensors through
The study was approved by the institutional review board at
|     |     |     |     |     |     |     | regression  | models.  Additionally,  |     | the  spectrophotometer’s |     |
| --- | --- | --- | --- | --- | --- | --- | ----------- | ----------------------- | --- | ------------------------ | --- |
The Pennsylvania State University (hereinafter referred to as SPD data were used to calculate CLA and CS, which then
“Penn State”) (STUDY00020216). Resident participants were
acted as ground truth data for building predictive models
assessed for their capacity to provide informed consent using based  on  the  wearable  sensor  data.  Detailed  information
the evaluation to sign consent form. Informed consent was on the instruments, experimental setup, lighting conditions,
obtained from all residents who were deemed capable. For all
and metrics is provided in the subsequent sections. It is of
residents, regardless of their ability to consent, consent was importance to note that both laboratory lighting scenarios and
also obtained from their legally authorized representatives.
real-world lighting scenarios included daylighting, due to its
Resident participants did not receive compensation. How- direct impact on human biology as one of the main themes for
| ever, nursing home staff who contributed information related |       |      |             |              |     |          | our experiment. |     |     |     |     |
| ------------------------------------------------------------ | ----- | ---- | ----------- | ------------ | --- | -------- | --------------- | --- | --- | --- | --- |
| to  residents’                                               | mood  | and  | behavioral  | assessments  |     | received |                 |     |     |     |     |
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 4
(page number not for citation purposes)

JMIR AGING Beiglary et al
Figure 1. Diagram for experiments and data collection. CCT: correlated color temperature; CS: circadian stimulus; IR: infrared; SPD: spectral power
distribution.
Wearable Light Sensor LYS Button can track various parameters including photopic
illuminance, color temperature, irradiance at R (465 nm), G
In this study, we adopted the LYS Button as one of our data
(525 nm), B (615 nm), and infrared (IR) (1100 nm) channels,
collection tools. The LYS Button is incorporated with the
and motion. The key features of this wearable sensor are
LYS app, enabling users to collect data on individual daily
shown in Table 1. One of the drawbacks of the LYS Button
CL exposure. The LYS wearable button is a compact and
is that it does not directly output circadian lighting levels,
lightweight device and is ideal for individuals such as our
such as melanopic lux and CS. The availability of light data
human participants and assisted-living residents impacted by
through the R, G, and B channels using the LYS device,
mild to moderate dementia, who tend to not respond well to
which can be converted to melanopic data, was of importance
large objects hanging off their clothing. The wearable sensor
and value, hence why it was selected for this study.
is an ideal tool when optimizing lighting environments. The
Table 1. LYS Button: key features.
Feature Specification
Illuminance measurement 0.1-100,000 lux
Color temperature measurement 1800-10,000 K
Continuous monitoring and data logging Enabled
Connectivity Bluetooth to mobile app
Battery life Up to 7 days per charge
Design Compact, discreet, and wearable
Companion mobile app Data visualization and analysis
Spectrophotometer many other color or light parameters. Also, the instrument
uses a silicon photodiode array and a diffraction grating to
CL500A Illuminance Spectrophotometer (Konica Minolta)
provide full SPD data, which can be then computed to obtain
was used In this study, as the tool to obtain the ground
CLA and CS. The other key features of CL500A are listed in
truth data for developing calibration and predictive models
Table 2.
(Multimedia Appendix 2) from the wearable sensor data. It
can measure illuminance, CCT, color-rendering index, and
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 5
(page number not for citation purposes)

JMIR AGING Beiglary et al
Table 2. CL500A Spectroradiometer: key features.
Feature Specification
Spectral measurement range 360-780 nm, 1-nm resolution
Illuminance measurement range 0.01-100,000 lx
Calculated parameters Chromaticity coordinates, CCTa, and CRIb
Display Large, easy-to-read color liquid crystal display
Data transfer USB interface to a computer
Design Compact and lightweight, portable
Calibration Traceable to national standards
aCCT: correlated color temperature.
bCRI: color-rendering index.
Laboratory Data Collection ranged from 10 to 10,000, and CCT values spanned a broad
range between 1500 to 10,500 K. The CCT distribution was
Overview
achieved using 4 primary indoor light sources with CCT of
1500 K, 3000 K, 4200 K, and 6500 K. These sources were
We conducted our experiment at the Penn State University
used individually or in combination, and—along with natural
Architectural Engineering Lighting Laboratory, adhering to
daylight entering through windows—they enabled coverage
specified standards to ensure the precision and dependabil-
of the broad CCT range. Illuminance levels were similarly
ity of our results. Our methods conform to relevant interna-
generated using these 4 dimmable light sources, allowing
tional standards, including ISO 17025 for laboratory quality
fine control over light intensity. Higher data density was
management. The laboratory is equipped with NIST-traceable
intentionally designed and collected around 2 key illuminance
luminaires, which allowed us to create a variety of electrical
ranges: one representing typical indoor artificial lighting and
lighting conditions. Photopic lux levels ranged from 10 to
another corresponding to daylight-accessible conditions. As
10,000, and CCT values spanned a broad range between 1500
a result, we generated 100 different lighting scenarios by
to 10,500 K. The CCT distribution was achieved using 4
combining various lighting intensities and CCT conditions
primary indoor light sources with CCT of 1500 K, 3000 K,
in the lighting laboratory. For each scenario, we waited
4200 K, and 6500 K. These sources were used individually
approximately 10 minutes to ensure stability before logging 5
or in combination, and—along with natural daylight entering
data points. The LYS Button wearable sensors automatically
through windows—they enabled coverage of the broad CCT
documented and uploaded the measured data to a central
range. Illuminance levels were similarly generated using these
cloud, while the CL500A’s data were transmitted directly to a
4 dimmable light sources, allowing fine control over light
computer via cable connection.
intensity. Higher data density was intentionally designed and
collected around 2 key illuminance ranges: one representing We affixed 3 randomly selected wearable sensors to the
typical indoor artificial lighting and another corresponding CL500A spectrophotometer at the same position within the
to daylight-accessible conditions. As a result, we generated laboratory, enabling the study team to obtain concurrent
100 different lighting scenarios by combining various lighting readings from both instruments. This method facilitated a
intensities and CCT conditions in the lighting laboratory. direct comparison of the measurements and the detection
For each scenario, we waited approximately 10 minutes to of any inconsistencies between the 2 sensors (Figure 2).
ensure stability before logging 5 data points. The LYS Button The CL500A’s output for photopic lux and CCT served as
wearable sensors automatically documented and uploaded the reference points to calibrate the wearable sensors through
measured data to a central cloud, while the CL500A’s data regression models. Additionally, the CL500A’s SPD data
were transmitted directly to a computer via cable connection. were used to calculate CS and melanopic lux, which then
acted as ground truth data for building predictive models
National Institute of Standards and Technology
based on the wearable sensor data.
NIST-traceable luminaires, which allowed us to create a
variety of electrical lighting conditions. Photopic lux levels
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 6
(page number not for citation purposes)

JMIR AGING Beiglary et al
Figure 2. Data collection at Penn State University lighting laboratory.
On-Site Data Collection angles, ranging from 0°, directly facing the window, to 270°
to assess their effectiveness across diverse orientations. The
The on-site data collection with the CL500A and LYS
primary light sources in the 2 nursing homes consisted of 3
Buttons was executed in different residential rooms of
different CCT types: 1800 K, 2700 K, and 4000 K. Through
2 assisted-living facilities located in Pennsylvania. We
controlled switching of these sources and adjustment of blinds
intentionally visited the nursing homes under varying
to modulate daylight access, a broad range of illuminance
conditions, such as different weather, times of day, weekdays
and CCT variations was achieved. Similar to the laboratory
and weekends, and room types (resident rooms, hallway,
settings, illuminance levels were primarily concentrated in
dining hall, and activity rooms). Furthermore, in each
lower ranges typical of dim indoor environments without
room, the measurements were conducted at various distan-
daylight and in moderate ranges when daylight was present.
ces from the windows, spanning from 0 to 9 feet, to evalu-
CCT values were predominantly in the lower spectrum due to
ate the devices’ reactions to varying amounts of daylight.
the warm indoor lighting but extended to higher levels when
The electrical lights were also modulated to form different
daylight contributed to the scene. All these steps and setups
daylight-electrical light combination scenarios. The window
aimed to capture sufficient variations in lighting conditions
blinds were positioned at 4 distinct slat angles, 135°, 45°,
from the window zone (Figure 3A) and the main bed area
and 90°, as well as the fully retracted position, to evalu-
(Figure 3B) for subsequent calibration and prediction as
ate the effect of window shade on illumination conditions.
displayed.
The measurement stations were arranged at multiple viewing
Figure 3. On-site data collection in the window area (A) and the living area (B) by authors at the assisted-living facility.
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 7
(page number not for citation purposes)

JMIR AGING Beiglary et al
Circadian Metrics Used for Data
Sλ Vλ
Processing CLA=1548 McλEλdλ+ab−y Eλdλ−k Eλdλ −
mpλ mpλ
−∫vλEλdλ
arod 1−e RodSat , b−y>0
CS, closely associated with CLA, is a metric that directly
quantifies the extent of circadian system activation resulting (1)
1548 McλEλdλ, b−y≤0
from specific light exposure [20]. Because neither spectro-
wℎere,
photometers (CL500A) nor wearable sensors (LYS Button)
Sλ Vλ
can output CS directly, we had to extract the raw spectral b−y= Eλdλ−0.2616 Eλdλ
mpλ mpλ
data from CL500A and then input them into the CS calculator
developed by Rensselaer Polytechnic Institute [19,30-32] as
seen in equation 1. CS [33], shown in equation 2, is derived CS=0.7∗ 1− CL 1 A 1.1026 (2)
from the CLA value. 1+ 355.7
Equation values and parameters are shown in Textbox 1.
Textbox 1. Equation values and parameters.
CLA: circadian light adjusted.
E λ: light source spectral irradiance.
Mc λ: melanopsin sensitivity (corrected for crystalline lens transmittance) [34].
k=0.2616
S λ: S-cone fundamental.
ab–y=0.7
mp λ: macular pigment transmittance.
a rod = 3.3
V λ: photopic luminous efficiency function [35].
RodSat = 6.5 Wm−2
V λ′: scotopic luminous efficiency function [35].
Calibration and Predictive Modeling mathematical formula used for each of the implemented
Methods evaluation metrics.
Calibration Modeling of Photopic Lux and CCT
N
1
The calibration process was implemented to ensure the MAE= yi−y (3)
Ni=1
measurement accuracy for the parameters of photopic lux and
CCT from LYS. Simple regression calibration was applied
N
first using the data obtained from the reference devices. The MSE= 1 yi−y 2 (4)
original data can be found in Multimedia Appendix 2. The
Ni=1
candidate parameters from the reference devices included red,
2
green, and blue (RGB) value, IR light, illuminance, and color 2 ∑(yi−y)
R =1− 2 (5)
temperature. ∑(yi−y¯)
where is the predicted value of , and is the mean.
The photopic lux was calibrated based on the illuminance
measurements from CL500A and the measurements from y y y¯
Predictive Modeling of CS
LYS about illuminance, RGB, IR, and CCT. The measure-
ment accuracy of LYS was calibrated for its performance The prediction models were developed based on the available
under different lighting conditions. Similarly, CCT from LYS parameters’ information for the CS from CL500A. The
was also calibrated based on the CCT measurements from original data can be found in Multimedia Appendix 2. The
CL500A. The data screening process was first conducted to calculation of CS has been studied in diverse ways for
check the negative values that were invalid and to enhance quick and efficient computation. The LRC Circadian Light
the data quality. The feature selection of these candidate Combined Calculator was applied in the study in section
parameters for the simple regression model was based on “Circadian Metrics Used for Data Processing.” The calculator
their significant test results. The models were developed was programmed to enable the output of CS by the input
and evaluated using a train-test split for the assessment of of SPD for a lighting source. The spectral lighting with the
modeling metrics. In the train-test split method, 70% of the wavelength from 360 to 780 nm could be obtained from the
total data were used as a training set to train the model, and CL500A and thus the values of CS were obtained using the
30% were used as test data to value the model’s perform- CS calculator. The spectral lighting data with a 1-nm interval
ance. Evaluation metrics including R², mean squared error were first integrated into a 5-nm increment for an efficient
(MSE), and mean absolute error (MAE) were used to indicate computation in the calculator.
the goodness of fit of the model. Equations 3-5 show the
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 8
(page number not for citation purposes)

JMIR AGING Beiglary et al
After the calculation of the CS, a CL prediction model was decision trees during training and output the mean prediction
developed based on the measured values from LYS including for regression of the individual trees. This bagging technique,
RGB value, IR light, illuminance, and color temperature. where different subsets of the dataset are used to train each
The simple regression model was applied first based on decision tree, made the overall model more robust and less
the train-test split to check the prediction accuracy using prone to overfitting. Compared with a linear regression, it
evaluation metrics of R2, MAE, and MSE. To better evaluate could provide a comparison of the feature importance which
the reliability of a prediction model, especially for the data can contribute to the understanding of the influence of the
collected under different lighting environments, the 5-fold input variables on the output.
cross-validation shown in equation 6 was further used to
identify the optimal simple regression model.
Results
Calibration Model for Photopic Lux
n
1
CV(k)= errori (6) Figure 4 shows the distribution of photopic lux measurements
ki=1
collected from our experiments at both the laboratory and
where the error can refer to evaluation metrics such as MAE,
on-site. The data covered a range from ultra-low to high
MSE, and R².
lighting levels, corresponding to 2 main locations. The first
To achieve high and satisfactory prediction accuracy, a peak (at lower lux values) likely represented interior spaces
random forest model was used for predictive analysis if the illuminated by artificial lighting, while the second peak (at
simple regression model did not meet the desired perform- higher lux values) corresponded to areas near windows with
ance criteria. A random forest model enabled a multitude of natural daylight exposure.
Figure 4. Photopic lux distribution during data measurement.
For the photopic lux calibration, a simple regression model Where CCT’, IR, and lux’ refer to the original output
with acceptable accuracy was obtained. The input param- from the LYS Button—CCT (Kelvin), irradiance of near-
eters, including the LYS Button’s output, which include IR wavebands at the peak of 1100 nm (W/m²), and illu-
CCT (Kelvin), IR channel irradiance, and illuminance (lux), minance level (lux), respectively—the comma differentiates
were selected during the modeling analysis. The calibration the final calibrated parameters, CCT, and lux. This may be
function is shown in equation 7. This calibration function due to small changes in solar light or daylight, which can
adjusts the original measurements from the LYS Button significantly boost the lux measurement, as near-IR sources
(CCT’, IR, and lux’) to more accurately reflect true pho- are primarily from daylight. In contrast, the original lux’
topic lux (Y). The coefficients (0.0596, 1.6064, and 0.8432) measurement has a smaller coefficient, suggesting that it
represent the contribution of each parameter to the final was initially less accurate and thus required a substantial
calibrated value. adjustment. The CCT’ shows a minor but necessary adjust-
ment. Together, these coefficients correct the original sensor
outputs to better match the true photopic lux values. The
Y Photopiclux =0.0596∗CCT′+1.6064∗IR+0.8432∗lux (7)
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 9
(page number not for citation purposes)

JMIR AGING Beiglary et al
overall adjusted R² and MAE for this calibration model fitted values. However, at the higher fitted value range, there
are 0.858 and 355, respectively. The goodness-of-fit plot is is a clear pattern, possibly suggesting model misspecifica-
shown in Figure 5 (A), indicating that the predicted values tion on the presence of nonlinear relationships. However,
generally correspond to the measured values. Plot (B) in for general indoor lighting conditions, the calibration model
Figure 5 shows the residuals against the fitted values, in shows a general trend of aligning with the measured values.
which the residuals are widely dispersed especially at lower
Figure 5. Calibration results for photopic lux: (A) Predicted versus measured values. (B) Residuals versus fitted values.
Calibration Model for CCT artificial interior lighting with a warmer color temperature,
while the subsequent distribution (around 4000‐5000 K) may
Figure 6 illustrates the distribution of CCT values recorded
represent areas near windows with daylight, featuring a cooler
during the data collection procedure. Similar to the distri-
color temperature.
bution of photopic lux, it represents 2 key environments.
The initial peak (around 3000‐4000 K) likely corresponds to
Figure 6. Correlated color temperature distribution during data measurement. CCT: correlated color temperature.
Similar to the calibration model of photopic lux, for the again during the CCT calibration model development. The
CCT calibration, a simple regression model with satisfac- calibration equation is shown in equation 8:
tory accuracy was also obtained. The input parameters,
including the LYS Button’s output—CCT (Kelvin), IR
channel irradiance, and illuminance (Lux)—were selected Y(CCT)=1.048×CCT′−0.5427×IR+0.1761×lux′ (8)
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 10
(page number not for citation purposes)

JMIR AGING Beiglary et al
In the calibration model, the Kelvin component, with a particularly from daylight sources. Together, these coeffi-
coefficient of 1.025, shows a strong correlation with the true cients adjust the original sensor outputs to better match the
CCT, indicating that the original CCT values are quite close true CCT values. The overall adjusted R² and MAE for
but require a slight adjustment. The IR component has a this calibration model are 0.982 and 342, respectively. The
relatively strong negative influence on the CCT, highlighting goodness-of-fit plot is shown in Figure 7A, and the model
the significant impact of solar IR on the calibration process, bias and variance patterns in Figure 7B.
likely due to its effect on perceived color temperature,
Figure 7. Calibration for correlated color temperature. (A) Predicted versus measured values. (B) Residuals versus fitted values.
Evaluation of Predictive Models for CL A zones near windows with natural daylight, which contribute
more significantly to CLA exposure. The remaining distribu-
Figure 8 represents the distribution of CLA values collected,
tion tail illustrates sporadic occurrences of very high CLA
which also reflects 2 major lighting conditions. The first
values, likely in brightly lit areas with substantial daylight,
peak (at lower CLA values) likely corresponds to areas with
which is also aligned with the photopic lux data distribution.
artificial lighting, providing minimal circadian stimulation.
The second peak (at higher CLA values) likely represents
Figure 8. Circadian light adjusted (CLA) distribution during data measurement.
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 11
(page number not for citation purposes)

JMIR AGING Beiglary et al
Based on the modeling procedure illustrated in section higher value indicates greater importance, while IncNodePur-
“Laboratory Data Collection,” we obtained both simple ity is based on the total decrease in node impurities contrib-
regression models and machine learning–based models. As uted by a variable across all the trees in the forest. As shown
shown in Table 3, the machine learning–based model shows in this context, the IR value has the highest in both metrics
much more accurate performance relative to the linear consistently, which is similar to the calibration model results
regression model, with an adjusted R2 of 0.86. in CCT and photopic Lux calibration—the potential daylight
effects on indoor IR levels drive the variations of circadian
Regarding the machine learning models, we also conduc-
lighting level changes. The sensor’s original CCT value had
ted the importance feature ranking analysis. Figure 9 shows
a strong direct impact on the model’s predictive accuracy,
the variable importance ranking results using 2 metrics
while it might not be crucial for creating pure or homogenous
%IncMSE (percentage increase in MSE) and IncNodePurity
nodes, meaning it did not contribute much to the structure of
(increase in Node Purity). %IncMSE measures the increase
the decision trees.
in the model’s prediction error when a particular variable
is randomly permuted while all others are kept constant. A
Table 3. Model comparison.
Modeling techniques Performance MAEa RMSEb
Random forest 0.8567 (cross-validation R2) 180.53 645
Linear regression 0.645 (adjusted R2) 491.5 1050
aMAE: mean absolute error.
bRMSE: root-mean-square error.
Figure 9. Variable importance.
Applications in Circadian Lighting Health attachment. Additionally, the LYS device supports real-time
Research in Nursing Homes remote monitoring. We implement automated algorithms on
the cloud to detect potential nonwear or malfunction events
To understand the functionality and usage of the wearable (eg, no change in light and motion data readings for more
sensors with calibrated and predicted models, we applied than 2 hours during the daytime and 4 hours during the
the sensors to 29 older adults with dementia in 2 assisted- nighttime). When such events were identified, alerts would
living facilities as part of a National Institutes of Health– be sent to the research team who would follow up with on-site
supported project. A post hoc power analysis using GPower verification and resolution as needed.
3.1 [36] indicated that with a total sample size of 29 and
The sensor data for each individual was automatically
α=.05, the study had 87 % power [37] to detect a medium
uploaded to a central computer (Mac Mini) located in
effect size (Cohen d=0.53), as reported in the previous
the dining hall of the nursing homes to ensure Bluetooth
studies [14,15]. During the personalized data collection from
connectivity to all participant residents and then retrieved
residents, the LYS device was pendant-worn or clipped on the
through a remote connection. By using the calibrated and
upper body area (eg, upper chest, shirt collar, and shoulder)
predicted sensor measurement methods developed in this
to more closely approximate eye light exposure. Staff and
work, we were able to analyze each resident’s circadian
nurses have been guided to make sure that the attachment
lighting exposure, enabling more rigorous and effective
of devices is in secure positions as well as constant monitor-
intervention analysis.
ing of the residents to ensure that the device has not been
accidentally removed from the human participant. Research-
ers also visited sites twice a week to ensure the sensor
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 12
(page number not for citation purposes)

JMIR AGING Beiglary et al
We then selected specific residents with the widest range Resident 1’s room faced south, and resident 2’s faced east.
of variabilities and differences to demonstrate the applicabil- Resident 1 had mild dementia, and resident 2 had moder-
ity of our developed methods within the following sections. ate dementia. It was also observed that resident 1 benefited
It is important to note that any analysis shown in this section from the facility’s activities such as spending several hours
is of exploratory value; the relatively small focus of the study during the day in the sun-lit dining area and having sched-
in this section was to illustrate the measurement methodology uled outdoor visits more frequently than resident 2. Table
for potential use in future studies on circadian lighting health. 4 denotes key differences between the 2 residents selected
for detailed analysis in this study, providing context for the
Intervariability of Residents’ Lighting
observed variations in CS, lux, and CCT measurements in the
Exposures
subsequent sections.
Understanding the intervariability of residents’ lighting Figures 10–12 are the detailed comparisons in terms of
exposures is crucial for accurately analyzing the effects of their variations in CS, Lux, and CCT based on our calibra-
interventions, as it accounts for the differences in physical ted and predicted measurement models, using a total of 268
environments and personal factors among individuals. These data points collected across 5 project weeks and processed
2 residents were particularly selected due to their differen- using the machine learning and regression models in section
ces in the dementia stages, the room’s window orientation “Calibration and Predictive Modeling Methods” in R Studio
direction, and daily routine and schedules. To do this, we [Posit] and visualized using Python features (the main coding
particularly extracted 2 residents’ hourly sensor data and then information used in this work can be found in Multimedia
calculated weekly averages of photopic lux, CCT, and CS. Appendix 1).
Table 4. Comparative characteristics of selected study residents.
Characteristic Resident 1 Resident 2
Dementia stage Mild Moderate
Room orientation South-facing East-facing
Activity level High; regular participation Limited; infrequent participation
Outdoor access Frequent scheduled visits Minimal exposure
Daily routine Structured; time in sun-lit areas Less structured; more time in
room
Sleep pattern Generally stable Erratic; disrupted
Light exposure Consistent throughout day Morning-dominant
Daytime behavior Alert; minimal sundowning Variable alertness; evening
agitation
Figure 10. Hourly circadian stimulus intravariability. CS: circadian stimulus.
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 13
(page number not for citation purposes)

| JMIR AGING |     |     |     |     |     |     | Beiglary et al |
| ---------- | --- | --- | --- | --- | --- | --- | -------------- |
Figure 11. Hourly illuminance intravariability.
Figure 12. Hourly daytime correlated color temperature variations. CCT: correlated color temperature.
CS Intervariability Both residents have higher CS levels during the daytime
compared with nighttime throughout the period. Compara-
Multimedia Appendix 3 visualizes the weekly daytime and tively, across those weeks, resident 1 with moderate dementia
| nighttime  | CS  value  variations  | of  the  selected  | 2  residents |     |     |     |     |
| ---------- | ---------------------- | ------------------ | ------------ | --- | --- | --- | --- |
generally had higher daytime CS levels and lower nighttime
| across  the  | project.  When  | comparing  nighttime  | CS  levels |     |     |     |     |
| ------------ | --------------- | --------------------- | ---------- | --- | --- | --- | --- |
CS levels than resident 2 in most weeks, with the highest
| between  resident  | 1  (mean  | 0.196,  variance  | 0.00223)  and |     |     |     |     |
| ------------------ | --------- | ----------------- | ------------- | --- | --- | --- | --- |
average daytime CS of 0.5 for resident 1 during week 5
| resident  2  | (mean  0.228,  variance  | 0.00167),  | the  paired  | t          |                           |                |              |
| ------------ | ------------------------ | ---------- | ------------ | ---------- | ------------------------- | -------------- | ------------ |
|              |                          |            |              | and  0.38  | for  resident  2  during  | week  2,  and  | the  highest |
test analysis revealed no statistically significant difference average nighttime CS of 0.29 for resident 2 during week
between the 2 residents (2-tailed t4=−1.01; P=.368). Although
5 and 0.24 for resident 1 during week 4. The differences
resident 2 showed a slightly higher mean nighttime CS value,
|     |     |     |     | in  both  daytime  | and  nighttime  | CS  levels  | between  the  2 |
| --- | --- | --- | --- | ------------------ | --------------- | ----------- | --------------- |
this difference was not substantial enough to reach statisti-
residents can be attributed to several factors, in particular
cal significance at the α level of .05. Analysis of daytime
|     |     |     |     | their  different  | dementia  stages,  | different  daytime  | activity |
| --- | --- | --- | --- | ----------------- | ------------------ | ------------------- | -------- |
CS  levels  revealed  that  resident  1  (mean  0.414,  variance participation levels, and bedroom orientations as pointed out
0.00418) demonstrated marginally higher values than resident
in section “Intervariability of Residents’ Lighting Exposures.”
2 (mean 0.326, variance 0.00113). This difference approached
|     |     |     |     | Resident  | 2  with  moderate  | dementia  (reported  | erratic |
| --- | --- | --- | --- | --------- | ------------------ | -------------------- | ------- |
statistical significance in the paired t test (2-tailed t4=2.43;
P=.072). While not meeting the conventional P<.05 threshold nighttime behaviors and activities) living in an east-facing
room and lower daytime CS levels had less participation in
for statistical significance, this trend suggested that resident
1  potentially  experienced  greater  circadian-effective  light the  facility’s  activities  and  as  a  result  had  reduced  day-
exposure during daytime hours than resident 2. light  exposure.  As  expected,  resident  2  displayed  higher
|     |     |     |     | nighttime  | CS  due  to  disrupted  | sleep.  Their  | east-facing |
| --- | --- | --- | --- | ---------- | ----------------------- | -------------- | ----------- |
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 14
(page number not for citation purposes)

JMIR AGING Beiglary et al
orientation provided less consistent and intense daylight than CCT Intervariability: Accuracy Challenges of
the south-facing room of resident 1, impacting the overall CCT Measurements in Dim Conditions
daytime and nighttime CS-level variations between the two.
A primary obstacle in quantifying CCT in low-light condi-
Lux Intervariability tions is the intrinsic difficulty in precisely measuring the
SPD of the light source. Rea and Freyssinier [38] empha-
With regard to weekly daytime and nighttime illuminance
size that under low-light situations, the spectral sensitivity
level comparisons, there were notable differences between
of the human eye alters, resulting in possible disparities
the 2 residents. For nighttime illumination levels, statistical
between the measured CCT and the perceived CCT. This
analysis revealed a significant difference between resident
may lead to mistakes when using conventional colorimetric
1 (mean 141.58 lux, variance 2558.22) and resident 2
systems, which are calibrated for elevated light levels. Chen
(mean 233.58 lux, variance 4042.12), with the paired t test
et al [39] examined the efficacy of different CCT measure-
showing statistical significance (2-tailed t4=−2.78; P=.050).
ment methods in low-light conditions, showcasing that these
This finding indicates that resident 2 experienced signifi-
challenges are especially evident in low-light conditions,
cantly higher illumination levels during nighttime hours than
where the signal-to-noise ratio of the measurement may be
resident 1, which aligns with observations of resident 2’s
considerably diminished. Li et al [40] assert that conventional
reported sleep disturbances and increased nighttime activity.
CCT calculation methods may be inadequate for these light
For daytime illumination levels, data analysis comparing
sources, as they can display intricate SPDs that may result in
resident 1 (mean 422.24 lux, variance 4438.70) and resident
erroneous CCT estimations. Owing to these constraints, we
2 (mean 376.36 lux, variance 493.39) showed no statisti-
exclusively examined the daytime CCT to align more closely
cally significant difference (2-tailed t4=1.32; P=.258). While
with reality.
resident 1 experienced somewhat higher average daytime
illumination levels, the considerable variance in resident 1’s Analysis of nighttime CCT levels revealed a notable
measurements and the relatively small sample size likely difference between resident 1 (mean 2098.10 K, variance
contributed to the nonsignificant finding. This suggests that 515642.97) and resident 2 (mean 3733.34 K, variance
both residents received comparable amounts of light exposure 1760014.09), with results approaching statistical significance
during daytime hours despite their different room orientations (2-tailed t4=−2.26; P=.086). This trend suggests that resident
and activity patterns. 2 was exposed to lighting with a substantially cooler color
temperature during nighttime hours compared with resident 1,
As seen in Multimedia Appendix 3, resident 1, who had
which may help explain some of the observed differences in
a milder dementia stage than resident 2 and resided in a
nighttime behavior and sleep quality, as cooler (bluer) light is
south-facing bedroom, was exposed to a sufficient amount of
known to potentially disrupt circadian rhythms and melatonin
daytime light exposure. This abundance of natural light not
production during evening hours. Examination of daytime
only supported resident 1’s circadian rhythms, as discussed
CCT values revealed no statistically significant difference
in section “Intervariability of Residents’ Lighting Exposures,”
between resident 1 (mean 4219.44 K, variance 226319.65)
but also had the potential to positively impact their mood,
and resident 2 (mean 3880.88 K, variance 520702.89)
alertness, and overall well-being according to the observa-
according to the paired t test analysis (2-tailed t4=0.81;
tions. In contrast, resident 2, who had a moderate demen-
P=.465). While resident 1 experienced slightly higher color
tia stage and an east-facing bedroom, experienced slightly
temperature exposure during daytime hours, suggesting some
lower daytime lux levels than resident 1. However, it is
exposure to cooler, more bluish light that typically enhan-
important to note that resident 2’s room would still receive
ces alertness, the substantial variance in measurements and
natural light exposure, particularly during the early morning
small sample size resulted in a nonsignificant finding. This
hours when the direct sunrise exposure provides a high level
indicates that both residents generally experienced compara-
of illumination, as both residents ultimately had sufficient
ble light spectral qualities during daytime, despite differences
average amounts of lux close to 400 per recommendations
in room orientation and activity patterns.
and standards.
With regard to the CCT variations seen in Multimedia
It is worth mentioning that the differences in daytime
Appendix 3, resident 1 tended to experience a slightly higher
lux levels between the 2 residents can also be attributed to
daytime CCT than resident 2. This can be primarily attrib-
their varying levels of participation in daily activities and
uted to the consistent natural light exposures that resident
programs. Resident 1, with a lower dementia stage, was likely
1 receives for a longer duration throughout the day, due
more engaged in general activities scheduled by the facility,
to the south-facing orientation of their room. The increased
which made a further contribution to their increased exposure
exposure to this cooler, bluer-toned light can have benefi-
to daytime light, due to the activity area being sun-lit from
cial effects on the resident’s circadian rhythms, cognitive
morning to afternoon. In contrast, resident 2, with a moder-
function, and overall well-being.
ate dementia stage, may have had reduced participation in
activities and programs, leading to slightly lower daytime In contrast, resident 2’s east-facing room receives less
lux levels. Resident 2 also had significantly higher nighttime direct sunlight exposure throughout the day, leading to a
illuminance exposure due to erratic sleep patterns. relatively lower daytime weekly average CCT. While resident
2’s daytime CCT levels are lower than those of resident 1, it
is important to note that the early morning sunlight coming
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 15
(page number not for citation purposes)

JMIR AGING Beiglary et al
from the east, even with a lower CCT, can still help entrain data were not processed due to the constraints mentioned in
the resident’s sleep-wake cycle and promote better synchroni- section “CCT Intervariability.”
zation with the natural light-dark cycle. It is seen that resident
The detailed analysis of this resident’s lighting exposure
1’s higher average levels of CCT are also partly due to their
and daily activities highlights the significant role of factors
participation in outdoor activities, while resident 2 did not
such as room orientation, daily routines, and engagement in
participate as frequently.
facility programs in shaping their overall circadian rhythms
In sum, the analysis of lighting exposure intervariability and well-being. The data collected showcased the poten-
among residents, using the regression and machine learning tial benefits of optimizing lighting and daily schedules for
models developed in this study, may provide help to identify residents with mild dementia to promote better engagement
moderating factors that may influence the effectiveness of and awareness, and the data processing with the models we
lighting interventions across different residents. developed in this study provided insights into the relationship
between their circadian lighting exposure and engagement in
Intravariability of Residents’ Lighting
daily activities. These results can help health care provid-
Exposures
ers, nurses, and families of older adults with dementia to
ensure that they are making the necessary lighting and routine
Examining the intravariability of each resident’s light
adjustments for these residents.
exposure provides insights into the daily fluctuations and
consistency of their lighting environments. Especially for Summary of Application Findings
circadian lighting intervention studies, this understanding
allows researchers to understand individual characteristics The application here demonstrated the effectiveness of
and adjust lighting interventions to ensure that target wearable sensors, combined with calibration and predictive
conditions are maintained. From a long-term application models, in assessing individual circadian lighting exposure.
perspective, this can also enable lighting system adjustments By capturing personal light exposure data, these models
and personalization to maintain optimal circadian lighting enabled a detailed analysis of how factors such as room
exposure. As such, we particularly select 1 resident who orientation, daily routines, and activity engagement influence
exhibits a mild stage of dementia, with intermittent reports circadian rhythms. This approach highlights the significant
of midnight roaming behaviors. variability in lighting experiences among individuals, which
traditional group-level assessments may overlook.
The hourly data shown in Figures 10-12 were obtained
from this resident on 1 weekend day in October with partly The small focus of the study was to validate the meas-
cloudy sky conditions. Their room was oriented toward the urement methodology for use in future studies of health
east, which allows for direct sunshine exposure from sunrise impacts. We recognize that additional validated research will
until approximately 9 AM. During the afternoon hours, this be needed to perform robust effect analyses in larger and
resident tended to spend more time in their bedroom, where more diverse populations and to determine the broader impact
they received minimal sunshine exposure. In particular, this on health. Such efforts can greatly enhance circadian lighting
specific room orientation and the resident’s daily routine help research, enabling more targeted interventions and improving
explain the observed surge in CS, lux, and CCT measure- data-driven decision-making in health care environments.
ments during the morning hours.
Discussion
This resident’s CS levels can be explained by their
room orientation (east-facing window) as well as their daily
schedule on the specific day of data collection. During the Principal Findings
lunch and early dinner hours (before 11 AM and around 4
PM), the resident was seated in the dining room, which has Despite its contributions, this study encountered several
large windows and receives abundant natural light throughout challenges related to sensor wearability, durability, and
the day (Figure 10). Throughout the night, they had low CCT data collection. In the application projects, some demen-
levels, which points to their uninterrupted sleep that evening. tia residents found the sensors uncomfortable, reducing
adherence, while others unintentionally removed or misplaced
As the sun rises, it shines directly through this resident’s
them, leading to a 40% loss or damage rate in that project.
east-facing room, contributing to a high level of illumination.
This highlights the need for more discreet, lightweight, and
Later in the day, around 4 PM, the resident was exposed
tamper-resistant sensor designs that seamlessly integrate into
to the direct, lower-angle rays of the setting sun on the
daily wear. Data collection also faced limitations, as site-
western side of the building (Figure 11). During the evening,
specific environmental conditions and seasonal variations
illuminance remained at a low level and it was in accordance
may have influenced results. The study’s reliance on a
with the observation of their normal sleep.
single type of sensor raises concerns about generalizabil-
The daytime CCT for this resident seems to plummet ity, particularly in RGB and IR channel sensitivity. Future
between 4 PM and 5 PM. This occurrence was likely due to research should include multisite, long-term studies across
the resident stepping outside briefly scheduled by their daily diverse lighting conditions and validate models using multiple
routine and then going back to the interior where there were sensor types to improve accuracy and applicability.
much lower CCT conditions (Figure 12). Nighttime CCT
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 16
(page number not for citation purposes)

JMIR AGING Beiglary et al
To recapitulate, although the use of LYS Button weara- and lux, which helped account for variations due to daylight
ble sensors enabled us to collect continuous personal CL influence. With an adjusted R² of 0.982 and an MAE of 342,
exposure data, factors such as sensor placement variability, the calibration effectively corrects the sensor outputs to match
individual characteristics, and environmental complexities the true CCT observed in various lighting environments.
inherent in nursing homes might affect the generalizability
Predictive models were then developed to forecast
of the developed measurement method. We stress that these
CS levels based on the calibrated lighting factors, with
issues are common when pioneering new methodologies
the random forest model outperforming linear regression,
in real-world settings. By advancing sensor design, expand-
achieving an adjusted R² (test) of 0.915 and a cross-vali-
ing case studies, and integrating adaptive lighting solutions,
dation R² of 0.857. The IR value was identified as the
future research can enhance the scalability and effective-
most influential factor in predicting circadian lighting levels,
ness of personalized circadian lighting assessments. These
further reinforcing the reliability of the model. These results
improvements will support more precise data-driven health
demonstrate the robustness of data-driven modeling for CL
care interventions, ultimately contributing to better sleep,
assessment, providing a highly accurate and scalable method
cognitive function, and overall well-being in long-term care
for personal circadian exposure evaluation.
residents.
We then implemented wearable sensors and developed
Conclusions and Future Work
models in a bright light therapy project in 2 assisted-liv-
Using wearable lighting sensors, we developed and valida- ing facilities to demonstrate how these models can be
ted calibration and predictive models to evaluate individ- used practically. These field applications in 2 assisted-liv-
ual lighting exposure in terms of photopic lux, CCT, and ing facilities revealed notable interindividual variations in
circadian lighting levels. Controlled laboratory studies and CL exposure, with room orientation, daily routines, and
on-site data collection were conducted to calibrate sensor engagement in facility activities playing key roles. For
values, as follows: To adjust the raw data from the LYS instance, residents with higher daytime light exposure,
Button and improve its accuracy, we developed a simple particularly from natural sources, demonstrated more stable
regression calibration using key sensor outputs—CCT (CCT circadian patterns, whereas those with limited exposure
in Kelvin), IR channel irradiance, and raw illuminance (lux). exhibited signs of disrupted rhythms. Similarly, the residents
The regression analysis generated coefficients that reflect who have increased engagement in everyday routines, and
each parameter’s contribution to estimating true photopic activities, and availability to steady daylight in the south-fac-
lux, with the IR measurement showing a particularly strong ing orientation also had relatively high and stable circa-
influence likely due to its sensitivity to daylight variations. dian lighting exposure. When assessed individually only, a
Overall, the calibration model, with an adjusted R² of specific resident with mild dementia, an east-facing room,
0.858 and with reasonable MAE, shows that although some and reported nighttime wandering were selected for study
deviations remain (especially under low light conditions), it on 1 weekend day for 24 hours, and their lighting exposure
reliably aligns the sensor’s outputs with the measured lux data were very much in accordance with their behavior and
values in general indoor lighting scenarios. activity patterns within that period. These findings underscore
the importance of the lighting assessments at the individual
As with photopic lux calibration, a simple regression
resident level in investigating and optimizing environmental
model was developed for CCT using the raw outputs (CCT,
conditions for residents with dementia and related health
IR, and lux) from the LYS Button. The model adjusted the
conditions.
raw CCT values by attributing a strong positive weight to
the original CCT output and incorporating the effects of IR
Acknowledgments
Research reported in this work was supported by the National Institutes of Health/National Institute of Aging (number
1R21AG078544-01: The Effect of Smart Ambient Bright Light for Nursing Home Residents with Alzheimer’s Disease and
Related Dementias).
Authors’ Contributions
SB contributed to conceptualization, writing, original draft, formal analysis, review and editing, data collection, analysis, and
visualization; YF contributed to writing, data modeling, and visualization; NW and NG contributed to data collection and
data processing; YLJ participated in writing, review, and editing, and worked as co-corresponding author (yuj15@psu.edu);
YJL contributed to data collection, review, and editing; YL participated in data collection; and JW participated in project
administration, methodology, investigation, and writing.
Conflicts of Interest
None declared.
Multimedia Appendix 1
Datasets used.
[XLSX File (Microsoft Excel File), 1076 KB-Multimedia Appendix 1]
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 17
(page number not for citation purposes)

JMIR AGING Beiglary et al
Multimedia Appendix 2
Model codes.
[DOCX File (Microsoft Word File), 14 KB-Multimedia Appendix 2]
Multimedia Appendix 3
Weekly daytime and nighttime lighting condition variations.
[DOCX File (Microsoft Word File), 702 KB-Multimedia Appendix 3]
References
1. Czeisler CA. Perspective: casting light on sleep deficiency. Nature New Biol. May 23, 2013;497(7450):S13-S13. [doi:
10.1038/497S13a]
2. Duffy JF, Czeisler CA. Effect of light on human circadian physiology. Sleep Med Clin. Jun 2009;4(2):165-177. [doi: 10.
1016/j.jsmc.2009.01.004] [Medline: 20161220]
3. Berson D. Strange vision: ganglion cells as circadian photoreceptors. Trends Neurosci. Jun 2003;26(6):314-320. [doi: 10.
1016/S0166-2236(03)00130-9]
4. Boudreau P, Dumont GA, Boivin DB. Circadian adaptation to night shift work influences sleep, performance, mood and
the autonomic modulation of the heart. PLoS One. 2013;8(7):e70813. [doi: 10.1371/journal.pone.0070813] [Medline:
23923024]
5. Turley K, Rafferty J, Bond R, Mulvenna M, Ryan A, Crawford L. Evaluating the Impact of a daylight-simulating
luminaire on mood, agitation, rest-activity patterns, and social well-being parameters in a care home for people with
dementia: cohort study. JMIR Mhealth Uhealth. Nov 29, 2024;12:e56951. [doi: 10.2196/56951] [Medline: 39611803]
6. Brainard GC, Hanifin JP, Greeson JM, et al. Action spectrum for melatonin regulation in humans: evidence for a novel
circadian photoreceptor. J Neurosci. Aug 15, 2001;21(16):6405-6412. [doi: 10.1523/JNEUROSCI.21-16-06405.2001]
[Medline: 11487664]
7. Figueiro MG, Steverson B, Heerwagen J, et al. The impact of daytime light exposures on sleep and mood in office
workers. Sleep Health. Jun 2017;3(3):204-215. [doi: 10.1016/j.sleh.2017.03.005]
8. Shochat T, Cohen-Zion M, Tzischinsky O. Functional consequences of inadequate sleep in adolescents: a systematic
review. Sleep Med Rev. Feb 2014;18(1):75-87. [doi: 10.1016/j.smrv.2013.03.005]
9. Ancoli-Israel S, Gehrman P, Martin JL, et al. Increased light exposure consolidates sleep and strengthens circadian
rhythms in severe Alzheimer’s disease patients. Behav Sleep Med. Feb 2003;1(1):22-36. [doi: 10.1207/
S15402010BSM0101_4]
10. Figueiro MG. Light, sleep and circadian rhythms in older adults with Alzheimer’s disease and related dementias.
Neurodegener Dis Manag. Apr 2017;7(2):119-145. [doi: 10.2217/nmt-2016-0060] [Medline: 28534696]
11. Figueiro MG, Plitnick B, Roohan C, Sahin L, Kalsher M, Rea MS. Effects of a tailored lighting intervention on sleep
quality, rest-activity, mood, and behavior in older adults with Alzheimer disease and related dementias: a randomized
clinical trial. J Clin Sleep Med. Dec 15, 2019;15(12):1757-1767. [doi: 10.5664/jcsm.8078] [Medline: 31855161]
12. Jao YL, Wang J, Liao YJ, et al. Effect of Ambient Bright Light on Behavioral and Psychological Symptoms in People
With Dementia: A Systematic Review. Innov Aging. May 6, 2022;6(3):igac018. [doi: 10.1093/geroni/igac018]
13. Figueiro MG, Pedler D, Plitnick B, Zecena E, Leahy S. Tailored lighting intervention (TLI) for improving sleep-wake
cycles in older adults living with dementia. Front Physiol. 2023;14:1290678. [doi: 10.3389/fphys.2023.1290678]
[Medline: 38169838]
14. Figueiro MG, Sahin L, Kalsher M, Plitnick B, Rea MS. Long-term, all-day exposure to circadian-effective light
improves sleep, mood, and behavior in persons with dementia. J Alzheimers Dis Rep. Aug 4, 2020;4(1):297-312. [doi:
10.3233/ADR-200212] [Medline: 33024938]
15. Figueiro MG, Plitnick BA, Lok A, et al. Tailored lighting intervention improves measures of sleep, depression, and
agitation in persons with Alzheimer’s disease and related dementia living in long-term care facilities. Clin Interv Aging.
2014;9:1527-1537. [doi: 10.2147/CIA.S68557] [Medline: 25246779]
16. Markvart J, Hansen ÅM, Christoffersen J. Comparison and correction of the light sensor output from 48 wearable light
exposure devices by using a side-by-side field calibration method. LEUKOS. Jul 3, 2015;11(3):155-171. [doi: 10.1080/
15502724.2015.1020948]
17. Figueiro MG, Hamner R, Bierman A, Rea MS. Comparisons of three practical field devices used to measure personal
light exposures and activity levels. Light Res Technol. Aug 2013;45(4):421-434. [doi: 10.1177/1477153512450453]
[Medline: 24443644]
18. Bierman A, Klein TR, Rea MS. The Daysimeter: a device for measuring optical radiation as a stimulus for the human
circadian system. Meas Sci Technol. Nov 1, 2005;16(11):2292-2299. [doi: 10.1088/0957-0233/16/11/023]
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 18
(page number not for citation purposes)

JMIR AGING Beiglary et al
19. Lewis P, Christoforou R, Ha PP, Wild U, Schweiker M, Erren TC. Architecture, light, and circadian biology: A scoping
review. Science of The Total Environment. Dec 2024;955:177212. [doi: 10.1016/j.scitotenv.2024.177212]
20. Rea MS, Figueiro MG, Bierman A, Bullough JD. Circadian light. J Circadian Rhythms. Feb 13, 2010;8(1):2. [doi: 10.
1186/1740-3391-8-2] [Medline: 20377841]
21. Khademagha P, Aries MBC, Rosemann ALP, van Loenen EJ. Implementing non-image-forming effects of light in the
built environment: a review on what we need. Build Environ. Nov 2016;108:263-272. [doi: 10.1016/j.buildenv.2016.08.
035]
22. Figueiro MG, Rea MS. A working threshold for acute nocturnal melatonin suppression from “white” light sources used
in architectural applications. J Carcinog Mutagen. 2013;4(3). [doi: 10.4172/2157-2518.1000150]
23. Shochat T, Barker DH, Sharkey KM, Van Reen E, Roane BM, Carskadon MA. An approach to understanding sleep and
depressed mood in adolescents: person-centred sleep classification. J Sleep Res. Dec 2017;26(6):709-717. [doi: 10.1111/
jsr.12550] [Medline: 28573658]
24. Wang Y, Zhang X, Chen H. From needs to control: a review of indicators and sensing technologies for occupant-centric
smart lighting systems. Energy Build. Jul 2025;339:115740. [doi: 10.1016/j.enbuild.2025.115740]
25. Kubicki M, Ryan JT, Shaw JM, Depner CM. Overview: wearable devices for monitoring sleep and circadian physiology.
In: Kushida CA, editor. Encyclopedia of Sleep and Circadian Rhythms. 2nd ed. Academic Press; 2023:1-5. [doi: 10.
1016/b978-0-12-822963-7.00198-5] ISBN: 9780323910941
26. Lu L, Zhang J, Xie Y, et al. Wearable health devices in health care: narrative systematic review. JMIR Mhealth Uhealth.
Nov 9, 2020;8(11):e18907. [doi: 10.2196/18907] [Medline: 33164904]
27. Tiersen F, Batey P, Harrison MJC, et al. Smart home sensing and monitoring in households with dementia: user-centered
design approach. JMIR Aging. Aug 11, 2021;4(3):e27047. [doi: 10.2196/27047] [Medline: 34383672]
28. Rose L, Saha S, Flowers E, et al. Family caregiver perspectives on digital methods to measure stress: qualitative
descriptive study. J Med Internet Res. Apr 24, 2025;27:e66034. [doi: 10.2196/66034] [Medline: 40273447]
29. Berridge C, Turner NR, Liu L, et al. Advance planning for technology use in dementia care: development, design, and
feasibility of a novel self-administered decision-making tool. JMIR Aging. Jul 27, 2022;5(3):e39335. [doi: 10.2196/
39335] [Medline: 35896014]
30. Lighting Research Center. CS calculator. URL: https://www.lrc.rpi.edu/cscalculator [Accessed 2025-07-18]
31. Rea MS, Figueiro MG, Bierman A, Hamner R. Modelling the spectral sensitivity of the human circadian system. Light
Res Technol. Dec 2012;44(4):386-396. [doi: 10.1177/1477153511430474]
32. Rea MS, Figueiro MG, Bierman A, Hamner R. Corrigendum. Light Res Technol. Dec 2012;44(4):516. [doi: 10.1177/
1477153512467607]
33. Rea MS, Nagare R, Figueiro MG. Modeling circadian phototransduction: quantitative predictions of psychophysical
data. Front Neurosci. 2021;15:615322. [doi: 10.3389/fnins.2021.615322] [Medline: 33613181]
34. Wyszecki G, Stiles WS. Color Science: Concepts and Methods, Quantitative Data and Formulae. John Wiley & Sons;
1982.
35. Commission Internationale de l’Éclairage. Light as a true visual quantity: principles of measurement. Report number CIE
041‐1978. 1994.
36. Faul F, Erdfelder E, Buchner A, Lang AG. Statistical power analyses using G*Power 3.1: tests for correlation and
regression analyses. Behav Res Methods. Nov 2009;41(4):1149-1160. [doi: 10.3758/BRM.41.4.1149]
37. Cohen J. Statistical Power Analysis for the Behavioral Sciences. 2nd ed. Lawrence Erlbaum Associates; 1988.
38. Rea MS, Freyssinier JP. Color rendering: beyond pride and prejudice. Color Research & Application. Dec
2010;35(6):401-409. [doi: 10.1002/col.20562]
39. Chen Z, Yu X, Wang C, Khanh TQ, Liu Q. Limitations of correlated colour temperature in visual perception and its
implications for evaluating the colour rendition quality of indoor lighting. Build Environ. Feb 2025;269:112436. [doi:
10.1016/j.buildenv.2024.112436]
40. Li C, Cui G, Melgosa M, et al. Accurate method for computing correlated color temperature. Opt Express.
2016;24(13):14066. [doi: 10.1364/OE.24.014066]
Abbreviations
CCT: correlated color temperature
CL: circadian light
CLA: circadian light adjusted
CS: circadian stimulus
IR: infrared
MAE: mean absolute error
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 19
(page number not for citation purposes)

JMIR AGING Beiglary et al
MSE: mean squared error
RGB: red, green, and blue
SPD: spectral power distribution
Edited by Haley LaMonica; peer-reviewed by Arijit Ghosh, Xin Zhang; submitted 07.02.2025; final revised version received
11.05.2025; accepted 12.06.2025; published 11.09.2025
Please cite as:
Beiglary S, Feng Y, Wang N, Ghaeili N, Jao YL, Liao YJ, Li Y, Wang J
Using Wearable Sensors to Measure and Predict Personal Circadian Lighting Exposure in Nursing Home Residents: Model
Development and Validation
JMIR Aging 2025;8:e72338
URL: https://aging.jmir.org/2025/1/e72338
doi: 10.2196/72338
© Shevvaa Beiglary, Yanxiao Feng, Nan Wang, Neda Ghaeili, Ying-Ling Jao, Yo-Jen Liao, Yuxin Li, Julian Wang. Originally
published in JMIR Aging (https://aging.jmir.org), 11.09.2025. This is an open-access article distributed under the terms of
the Creative Commons Attribution License (https://creativecommons.org/licenses/by/4.0/), which permits unrestricted use,
distribution, and reproduction in any medium, provided the original work, first published in JMIR Aging, is properly cited. The
complete bibliographic information, a link to the original publication on https://aging.jmir.org, as well as this copyright and
license information must be included.
https://aging.jmir.org/2025/1/e72338 JMIR Aging 2025 | vol. 8 | e72338 | p. 20
(page number not for citation purposes)
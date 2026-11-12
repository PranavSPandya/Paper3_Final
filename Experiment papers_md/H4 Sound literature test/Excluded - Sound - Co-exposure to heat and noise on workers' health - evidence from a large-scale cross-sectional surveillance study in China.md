Li et al. BMC Public Health (2025) 25:3533 BMC Public Health
https://doi.org/10.1186/s12889-025-24592-1
RESEARCH Open Access
Co-exposure to heat and noise on workers’
health: evidence from a large-scale cross-
sectional surveillance study in China
Minhua Li1,2†, Yilin Zhang1,2†, Chuancheng Wu1,2, Yu Jiang1,2, Li Jing1,2, Jing Wu1,2, Jinfeng Lin3* and Jianjun Xiang1,2*
Abstract
Objectives This study aimed to investigate the synergistic effects of co-exposure to occupational heat and noise on
multi-system health outcomes among Chinese workers, and to examine the mediating role of systemic inflammation,
indicated by white blood cell (WBC) count.
Methods A cross-sectional analysis was conducted using data from the Fujian Workplace Occupational Hazards
Comprehensive Surveillance Program (2020–2022), encompassing 10,275 workers from the manufacturing,
petrochemical, mining, and construction industries. Multivariate logistic regression, relative excess risk due to
interaction (RERI), random forest with SHAP values, and mediation analysis were used to explore interaction effects
and mediating pathways.
Results Co-exposure to heat and noise in the workplace was associated with increased risks of hypertension
(OR = 1.94, 95%CI:1.61–2.36; RERI = 0.26, P interaction <0.001) and abnormal ECG (OR = 1.81, 95%CI:1.48–2.12;
RERI = 0.16, P interaction <0.001), indicating synergistic effects beyond individual exposures. WBC partially mediated
the effects of occupational heat and noise exposure on hypertension (heat: 9.2%; noise: 7.4%; co-exposure: 15.3%),
liver dysfunction (heat: 5.4%; noise: 13.2%; co-exposure: 11.5%), and abnormal ECG findings (heat: 7.0%; noise: 6.4%;
co-exposure: 8.7%). Machine learning models further confirmed that interaction between heat and noise was a
stronger predictor of adverse health outcomes than either exposure alone.
Conclusion Co-exposure to occupational heat and noise significantly exacerbates health risks across multiple
organ systems, with systemic inflammation playing a partial mediating role. These findings highlight the importance
of integrated occupational hazard assessments and targeted interventions that consider multiple concurrent
occupational hazards.
Keywords Occupational health, Heat exposure, Noise exposure, Co-exposure, Interaction
†Yilin Zhang and Minhua Li contributed equally to this work. 1Department of Preventive Medicine, School of Public Health, Fujian
Medical University, 1 North Xue-Fu Road, Fuzhou 350122, Fujian Province,
*Correspondence: China
Jinfeng Lin 2Key Laboratory of Environment and Health of Fujian Higher Education
ljf9804002@163.com Institutes, School of Public Health, Fujian Medical University,
Jianjun Xiang Fuzhou 350122, Fujian Province, China
jianjun.xiang@fjmu.edu.cn 3Fujian Center for Prevention and Control of Occupational Diseases and
Chemical Poisoning, Fuzhou 350025, Fujian Province, China
© The Author(s) 2025. Open Access This article is licensed under a Creative Commons Attribution-NonCommercial-NoDerivatives 4.0
International License, which permits any non-commercial use, sharing, distribution and reproduction in any medium or format, as long as you
give appropriate credit to the original author(s) and the source, provide a link to the Creative Commons licence, and indicate if you modified the
licensed material. You do not have permission under this licence to share adapted material derived from this article or parts of it. The images or
other third party material in this article are included in the article’s Creative Commons licence, unless indicated otherwise in a credit line to the
material. If material is not included in the article’s Creative Commons licence and your intended use is not permitted by statutory regulation or
exceeds the permitted use, you will need to obtain permission directly from the copyright holder. To view a copy of this licence, visit h t t p : / / c e r a t i
v e c o m m o n .s o r g / l i c e n s e s / y b - n c - n d / 4 . 0. /

Li et al. BMC Public Health (2025) 25:3533 Page 2 of 15
Introduction
findings suggest that WBC count may play an important
With the intensification of ongoing climate change, the role in the biological pathways linking occupational heat
risk of heat exposure in occupational environments has or noise exposure to health impairments. However, most
become increasingly prominent, while the continuous existing evidence comes from studies of single-exposure
advancement of industrialization has also made noise settings, and few large-scale investigations have exam-
pollution an occupational health threat that cannot be ined the mediating role of WBCs in multiple health out-
ignored. As the most representative physical hazards in comes under combined heat and noise exposures in the
industrial settings, occupational heat and noise exposure workplace.
have been proven to be closely associated with adverse To address this research gap, we analyzed the data
effects on workers’ health, safety, and labor productiv- obtained from the Fujian Workplace Occupational Haz-
ity [1–4]. A systematic review encompassing multiple ards Comprehensive Surveillance Program in China. We
industries, including agriculture, construction, mining, assessed the individual and joint effects of occupational
and manufacturing, demonstrated that extreme heat heat and noise exposure on cardiovascular, respiratory,
exposure can negatively impact health outcomes such as hepatic, and renal functions, using relative excess risk
the cardiovascular, nervous, and respiratory systems [5]. due to interaction (RERI) and machine learning mod-
Similarly, a systematic review and meta-analysis covering els. Furthermore, we conducted mediation analysis to
30 countries and 447 million workers also confirmed the explore the potential mediating role of systemic inflam-
impact of occupational heat exposure on workers’ health mation, as indicated by WBC count, in these associa-
[6]. Likewise, the health effects of occupational noise tions. Our findings will provide novel insights into the
exposure have been well documented. A UK-based pro- health effects of co-exposure to heat and noise in the
spective cohort study revealed a significant association workplace and inform integrated strategies for occupa-
between workplace noise exposure and the incidence of tional hazard management.
atrial fibrillation [7]. In addition, the WHO/ILO Joint
Methods
Estimates of the Work-related Burden of Disease and
Injury also identified occupational noise exposure as a Study design and participants
contributing factor to ischemic heart disease, stroke, and This cross-sectional study was conducted in accordance
hypertension [8]. However, it is noteworthy that in real- with the “2021 Occupational Disease Prevention and
world industrial environments, heat and noise exposures Control Implementation Plan” issued by the General
often occur simultaneously. Most existing studies focus Office of China’s National Health Commission. Data for
on the effects of these hazards in isolation or examine this analysis were derived from the Fujian Workplace
single health outcomes. The potential synergistic effects Occupational Hazards Comprehensive Surveillance Pro-
of combined heat and noise exposure on multiple body gram, which collected occupational health monitoring
systems remain underexplored, creating a critical gap in data from workers across multiple industries in Fujian
our understanding of complex occupational risk profiles Province between January 1, 2020, and December 31,
[9, 10]. 2022. Coordinated by the Fujian Center for Prevention
White blood cell (WBC) count, a sensitive biomarker and Control of Occupational Diseases and Chemical
of systemic inflammation, has emerged as a potential Poisoning, monitoring activities covered all prefecture-
mediator in the relationship between environmental level cities and the Pingtan Comprehensive Experimental
stressors and adverse health outcomes [11–13]. Elevated Zone of Fujian Province. Data collection encompassed
WBC counts have been linked to various occupational various sectors, including the service sector, petrochemi-
exposures and may serve as an early predictor of inflam- cal, mining, cement, construction, and other manufac-
matory responses. For instance, foundry workers in Iran turing industries such as metal processing and thermal
exhibited higher WBC levels in association with elevated power generation. The dataset included demographic
Wet Bulb Globe Temperature (WBGT) index values [14]. and occupational information such as age, gender, work
A cohort study showed that immune parameters, includ- duration, income level, company size, protective mea-
ing WBC count, can reflect the physiological impact of sures (e.g., cooling vests, earplugs, helmets, gloves, etc.),
heat exposure [15]. A literature review incorporating occupational exposure profiles, as well as workers’ health
studies from multiple countries revealed that firefighters monitoring results, including routine biochemical tests,
exposed to extreme heat exhibited significantly elevated hypertension monitoring, blood glucose tests, electrocar-
hematological parameters and inflammatory mark- diograms, pulmonary function parameters, liver function
ers [16]. Similarly, a case-control study conducted in an indices, and renal function markers.
insulation material factory in Iran showed that noise- Participants meeting the following criteria were
exposed production workers had significantly higher included in the analysis: workers who participated in the
WBC counts compared to administrative staff [17]. These Fujian Workplace Occupational Hazards Comprehensive

Li et al. BMC Public Health (2025) 25:3533 Page 3 of 15
Surveillance Program between January 1, 2020, and Personal Sound Exposure Meter. At each point, steady-
December 31, 2022, with complete occupational records state and non-steady-state noise were measured using
and at least one year of work experience in industries. A-weighting, while impulse noise was measured using
Exclusion criteria consisted of individuals with pre-exist- C-weighting. For steady-state and non-steady-state noise,
ing severe cardiovascular diseases, chronic respiratory the equivalent continuous A-weighted sound pressure
diseases, liver failure, chronic kidney disease, malignan- level (LAeq, T) was recorded, and for impulse noise, the
cies, mental disorders, or physical disabilities at the time peak C-weighted sound pressure level (LC, Peak) was
of pre-employment health screening. obtained. Monitoring was carried out over five consecu-
tive typical workdays to ensure coverage of daily noise
Heat exposure assessment and definition variations.
Occupational heat exposure assessment employs por- Based on national occupational health criteria [19],
table WBGT monitors (3 M QUESTemp°34) for on-site workers were classified as noise-exposed if their 8-hour
measurements using the WBGT index as the core met- equivalent continuous A-weighted sound pressure level
ric. The measurement procedures adhere to the technical (LEX, 8h) was ≥ 80 dB(A).
requirements specified in GBZ/T 224–2010 “Techni-
cal Specifications for Occupational Hazard Monitoring,” Health outcomes
with monitoring point arrangements considering work- Hypertension
ing posture and heat exposure uniformity. For stand- Blood pressure was measured using an OMRON elec-
ing postures, the baseline measurement height is 1.5 m tronic sphygmomanometer (Model: HEM-7121), follow-
(respiratory zone height), while for sitting postures, it ing the protocol recommended by the American Heart
is 1.1 m. Monitoring points comprehensively cover key Association [20–22]. The specific protocol included:
areas, including core production zones, auxiliary work
areas, and boundary locations. In the absence of pro- (1) Participants refrained from vigorous physical activity,
duction-related heat sources, three monitoring points caffeine intake, and smoking for at least 30 min prior
are established, whereas 3 to 5 points are set when heat to the measurement.
sources are present, with the average value of all points (2) Participants were required to rest in a seated position
taken as the final result. For mobile workers, relatively for at least 5 min before measurement. During
fixed working points within their activity range are measurement, they remained seated with their back
selected for measurement, and the time-weighted WBGT straight, feet flat on the floor, and arm supported at
index is calculated. heart level.
Regarding measurement timing, when the heat source (3) The measurements were repeated 3 times with
in the work environment is stable, measurements are a1-minute interval and the average of 3 readings was
conducted three times daily: 0.5 h after work begins, 0.5 used for analysis.
h before work ends, and once during the middle of the (4) During the first measurement, blood pressure
work shift, with the average value taken as the final result. was recorded in both arms, and subsequent
If the heat sources in the work environment are unstable measurements were taken on the arm with the
and the production process undergoes significant peri- higher reading. If the difference between the two
odic variations, the time-weighted average WBGT index arms was ≤ 10 mmHg, the right arm was used for all
is measured and calculated separately. Data collection subsequent measurements.
spanned five consecutive typical workdays to ensure cov-
erage of the operational cycle. Hypertension was diagnosed according to the WHO/ISH
Workers were categorized as “exposed” to heat if the criteria: systolic blood pressure ≥ 140 mmHg or diastolic
measured WBGT values were ≥ 25 °C, in line with rele- blood pressure ≥ 90 mmHg [23].
vant national standards [18].
Diabetes
Noise exposure assessment and definition Diabetes can be diagnosed if any one of the following cri-
Occupational noise exposure assessment was conducted teria is met [24]:
in accordance with the Chinese National Standard
GBZ/T 229.4–2012 “Measurement of Physical Agents in (1) Fasting plasma glucose (FPG) ≥ 7.0 mmol/L (126 mg/
the Workplace – Part 4: Noise.” A preliminary rapid scan dL).
was conducted to identify peak noise areas across dif- (2) 2-hour plasma glucose during an oral glucose
ferent work environments. Fixed-point measurements tolerance test (OGTT) ≥ 11.1 mmol/L (200 mg/dL).
were then performed at ear height (approximately 1.5 (3) Glycated hemoglobin (HbA1c) ≥ 6.5% (48 mmol/
m) at representative locations using a Cirrus ASV5910 mol).

Li et al. BMC Public Health (2025) 25:3533 Page 4 of 15
(4) Random plasma glucose ≥ 11.1 mmol/L (200 mg/dL). accuracy. Each ECG tracing was independently inter-
preted by two cardiologists to guarantee consistency and
Renal dysfunction reliability in the assessments.
Renal dysfunction can be diagnosed if either of the fol-
lowing criteria is met [25, 26]: WBC count measurement
Estimated glomerular filtration rate (eGFR) < 60 mL/ Blood samples were collected in the morning following
min/1.73 m². an 8–12-hour overnight fast. Venous blood was drawn
Urinary albumin-to-creatinine ratio (UACR) ≥ 30 mg/g. into EDTA-anticoagulated tubes and analyzed within 2 h
using an automated hematology analyzer (e.g., Mindray
Pulmonary dysfunction BS-2000 M) to ensure sample integrity. All testing labo-
Pulmonary function tests, including forced vital capacity ratories involved in this study were accredited by relevant
(FVC), forced expiratory volume in 1 s (FEV₁), and the authorities such as the National Center for Clinical Labo-
FEV₁/FVC ratio, were performed by trained technicians ratories (NCCL) of China and operated under standard-
following standardized protocols. Abnormal pulmonary ized protocols with routine internal and external quality
function tests was defined according to the American control procedures to ensure measurement accuracy and
Thoracic Society/European Respiratory Society (ATS/ consistency across sites.
ERS) guidelines based on the following criteria for venti-
latory impairment: for an obstructive ventilatory defect, Statistical analysis
FEV₁/FVC < 0.7 (fixed ratio) or < lower limit of normal Descriptive statistics were used to summarize the char-
(LLN) plus FEV₁ < 80% predicted; for a restrictive venti- acteristics of study participants by exposure group. Con-
latory defect, FVC < 80% predicted plus FEV₁/FVC ≥ LLN tinuous variables were expressed as means (± SD) or
plus total lung capacity (TLC) < 80% predicted; and medians (IQR), and categorical variables as frequencies
for a mixed ventilatory defect, FEV₁/FVC < LLN plus and percentages. Group comparisons were performed
FVC < 80% predicted [27, 28]. In this study, pulmonary using the chi-square tests or Fisher’s exact tests for cat-
dysfunction was defined as meeting any one of the above egorical variables, and independent t-tests or Mann–
criteria. Whitney U tests for continuous variables for two-group
comparisons; one-way ANOVA was used for multi-group
Liver dysfunction comparison.
Liver dysfunction was defined as any of the follow- Multivariable logistic regression models were used to
ing biomarkers exceeding the normal range: ALT, AST, estimate the independent and joint associations of occu-
ALP, GGT, or TBIL. The reference values for these bio- pational heat and noise with various health outcomes,
markers are as follows: AST: 0–37 U/L in men and 0–31 reporting OR with 95% confidence intervals (CI). The
U/L in women; ALT: 0–40 U/L for males, 0–31 U/L for relative excess risk due to interaction (RERI) was calcu-
females; ALP: Male 40–129 U/L, female 35–104 U/L; lated to assess potential synergistic effects between occu-
GGT: Male 11–51 U/L, female 7–33 U/L; TBIL: 1.0 mg/ pational exposures. To capture complex interactions that
dL(17.1µmol/L) [29]. might be overlooked by conventional regression models,
we employed a random forest machine learning algo-
Abnormal ECG rithm. Predictive contributions of variables were further
Abnormal electrocardiograms (ECGs) were defined as analyzed using SHAP values via the fastshap package.
any findings other than normal sinus rhythm and were Finally, a counterfactual framework was used for media-
coded according to the Minnesota Code (MC) [30, 31]. tion analysis to quantify the proportion of the effect of
These included, but were not limited to, the following heat and noise exposure on health outcomes mediated by
MC classifications: Q-QS wave abnormalities (MC 1–1 WBC count.
to 1-2-8), left ventricular hypertrophy (MC 3 − 1), Wolff- All statistical analyses were conducted using R (ver-
Parkinson-White (WPW) syndrome (MC 6-4-1 or 6-4- sion 4.2.2) and Python (version 3.9). A two-sided
2), complete bundle branch block or intraventricular p-value < 0.05 was considered statistically significant.
conduction delay (MC 7-1-1, 7-2-1, 7 − 4, or 7–8), atrial
fibrillation or atrial flutter (MC 8 − 3), major ST-T seg- Ethics approval and consent to participate
ment abnormalities (MC 4 − 1, 4 − 2, 5 − 1, or 5 − 2), and This study and its protocol were ethically approved by
minor ST-T segment changes (MC 4 − 3, 4–4, 5 − 3, or Fujian Medical University's Biomedical Research Eth-
5 − 4). All ECGs were recorded using standard 12-lead ics Committee (Approval No. 2022-111). The monitor-
configurations (leads I, II, III, aVR, aVL, aVF, and V1– ing activities were conducted across all 9 prefecture-level
V6), with participants resting in the supine position for cities in Fujian Province and the Pingtan Comprehensive
at least 20 min prior to measurement to ensure data Experimental Zone, covering all subordinate counties

Li et al. BMC Public Health         (2025) 25:3533  Page 5 of 15
| and districts. The Fujian Provincial Center for Occupa- |     |     | Results |     |     |     |
| ------------------------------------------------------- | --- | --- | ------- | --- | --- | --- |
Characteristics of study participants
tional Disease and Chemical Poisoning Prevention and
Control was responsible for assigning workplace occu- This study assessed the health effects of occupational
pational hazard monitoring tasks across the province,  heat  and  noise  exposure  among  10,275  workers.  As
with  local  governments  clearly  communicating  these  shown in Table 1, compared to the non-heat-exposed
to relevant manufacturing entities. The leading depart- group  (N=6,233),  workers  in  the  heat-exposed  group
ment of each manufacturing enterprise was tasked with  (N=4,042) were significantly older (41.29 ± 9.70 vs. 40.34
obtaining  informed  written  consent  from  all  partici- ± 10.31, p < 0.001), had a higher proportion of males
pants. Participation in health monitoring was voluntary,  (86.2% vs. 82.9%, p < 0.001), and longer employment
and individuals retained the right to refuse or withdraw  duration (13.44 ± 9.87 vs. 11.12 ± 9.80 years, p < 0.001).
from the survey at any time based on their personal cir- Regarding health status, workers exposed to heat in the
cumstances. Throughout the data collection process and  workplace exhibited higher prevalence rates of hyper-
the entire duration of the investigation, all participant  tension (35.1% vs. 24.2%), renal dysfunction (20.6% vs.
information was kept strictly confidential. Furthermore,  16.5%), liver dysfunction (31.2% vs. 25.4%), pulmonary
all methods employed in this study strictly adhere to the  dysfunction (26.9% vs. 23.6%), and abnormal ECG find-
principles outlined in the Declaration of Helsinki. ings (32.2% vs. 26.3%) (all p < 0.05) compared to those
Table 1 Participant characteristics by heat or noise exposure status
Variables Overall Non-heat Heat P-value Non-noise Noise P-value
|     | N = 10,275 | N = 6233 | N = 4042 | N = 6437 | N = 3838 |     |
| --- | ---------- | -------- | -------- | -------- | -------- | --- |
Age(years) 40.71 ± 10.08 40.34 ± 10.31 41.29 ± 9.70 < 0.001 40.52 ± 10.21 41.03 ± 9.86 0.013
Employment duration (years) 12.03 ± 9.89 11.12 ± 9.80 13.44 ± 9.87 < 0.001 11.87 ± 10.14 12.30 ± 9.46 0.033
| Gender, n (%) |     |     |     | < 0.001 |     | 0.005 |
| ------------- | --- | --- | --- | ------- | --- | ----- |
  Male 8,652 (84.2%) 5,166 (82.9%) 3,486 (86.2%) 5,370 (83.4%) 3,282 (85.5%)
  Female 1,623 (15.8%) 1,067 (17.1%) 556 (13.8%) 1,067 (16.6%) 556 (14.5%)
| Income level, n (%) |     |     |     | < 0.001 |     | 0.018 |
| ------------------- | --- | --- | --- | ------- | --- | ----- |
  Low 8,696 (84.6%) 5,308 (85.2%) 3,388 (83.8%) 5,454 (84.7%) 3,242 (84.5%)
  Medium 1,231 (12.0%) 679 (10.9%) 552 (13.7%) 744 (11.6%) 487 (12.7%)
  High 348 (3.4%) 246 (3.9%) 102 (2.5%) 239 (3.7%) 109 (2.8%)
| Company size, n (%) |     |     |     | 0.613 |     | 0.015 |
| ------------------- | --- | --- | --- | ----- | --- | ----- |
  Small 4,592 (45.4%) 2,798 (45.6%) 1,794 (45.0%) 2,827 (44.4%) 1,765 (46.9%)
  Large 5,533 (54.6%) 3,343 (54.4%) 2,190 (55.0%) 3,537 (55.6%) 1,996 (53.1%)
| Protect measure, n (%) |     |     |     | < 0.001 |     | 0.720 |
| ---------------------- | --- | --- | --- | ------- | --- | ----- |
  No 4,225 (41.1%) 2,318 (37.2%) 1,907 (47.2%) 2,656 (41.3%) 1,569 (40.9%)
  Yes 6,050 (58.9%) 3,915 (62.8%) 2,135 (52.8%) 3,781 (58.7%) 2,269 (59.1%)
| Hypertension, n (%) |     |     |     | < 0.001 |     | < 0.001 |
| ------------------- | --- | --- | --- | ------- | --- | ------- |
  No 7,347 (71.5%) 4,724 (75.8%) 2,623 (64.9%) 4,763 (74.0%) 2,584 (67.3%)
  Yes 2,928 (28.5%) 1,509 (24.2%) 1,419 (35.1%) 1,674 (26.0%) 1,254 (32.7%)
| Diabetes, n (%) |     |     |     | 0.313 |     | 0.128 |
| --------------- | --- | --- | --- | ----- | --- | ----- |
  No 7,904 (92.7%) 4,341 (93.0%) 3,563 (92.4%) 4,979 (93.1%) 2,925 (92.2%)
|   Yes                    | 620 (7.3%) | 327 (7.0%) | 293 (7.6%) | 371 (6.9%) | 249 (7.8%) |       |
| ------------------------ | ---------- | ---------- | ---------- | ---------- | ---------- | ----- |
| Renal dysfunction, n (%) |            |            |            | < 0.001    |            | 0.448 |
  No 6,826 (81.8%) 4,115 (83.5%) 2,711 (79.4%) 4,294 (82.1%) 2,532 (81.4%)
  Yes 1,514 (18.2%) 812 (16.5%) 702 (20.6%) 936 (17.9%) 578 (18.6%)
| Liver dysfunction, n (%) |     |     |     | < 0.001 |     | 0.237 |
| ------------------------ | --- | --- | --- | ------- | --- | ----- |
  No 6,198 (72.1%) 3,590 (74.6%) 2,608 (68.8%) 3,952 (72.5%) 2,246 (71.3%)
  Yes 2,402 (27.9%) 1,222 (25.4%) 1,180 (31.2%) 1,498 (27.5%) 904 (28.7%)
| Pulmonary dysfunction, n (%) |     |     |     | 0.004 |     | 0.035 |
| ---------------------------- | --- | --- | --- | ----- | --- | ----- |
  No 4,993 (75.2%) 3,297 (76.4%) 1,696 (73.1%) 3,078 (76.2%) 1,915 (73.8%)
  Yes 1,643 (24.8%) 1,020 (23.6%) 623 (26.9%) 964 (23.8%) 679 (26.2%)
| Abnormal ECG, n (%) |     |     |     | < 0.001 |     | < 0.001 |
| ------------------- | --- | --- | --- | ------- | --- | ------- |
  No 7,297 (71.0%) 4,595 (73.7%) 2,702 (66.8%) 4,778 (74.2%) 2,519 (65.6%)
  Yes 2,978 (29.0%) 1,638 (26.3%) 1,340 (33.2%) 1,659 (25.8%) 1,319 (34.4%)
Note: Table 1 presents the characteristics of workers grouped by their exposure status to either heat or noise. Specifically, the heat-exposed group may include
participants with or without noise exposure, and similarly, the noise-exposed group may include participants with or without heat exposure

Li et al. BMC Public Health (2025) 25:3533 Page 6 of 15
without heat exposure. Similar patterns were observed significantly poorer health status than the no-exposure
among those exposed to noise, who were older, more group but were better than the dual-exposure group.
likely to be male, had longer employment duration, and These findings suggest that heat and noise exposure, par-
significantly increased prevalence of hypertension, pul- ticularly their co-exposure, may exert adverse effects on
monary dysfunction, and abnormal ECG compared to workers' health.
those without noise exposure.
Table 2 further categorized participants into four Association between heat/noise exposure and health
groups based on co-exposure status: no-exposure group outcomes
(N=4,330), heat-only group (N=2,107), noise-only group Figure 1 presents the results of multivariable logistic
(N=1,903), and dual-exposure group (N=1,935). Results regression models. Model 1 is the unadjusted model, esti-
demonstrated that the dual-exposure group had the mating crude associations between occupational expo-
worst health outcomes, with significantly higher preva- sures and health outcomes. Model 2 further adjusts for
lence rates of hypertension (38.2%), liver dysfunction potential confounders, including age, gender, work dura-
(32.3%), pulmonary dysfunction (28.1%), and abnormal tion, income level, protective measures, and company
ECG findings (37.8%) among the four groups. Addition- size. The findings were generally consistent across mod-
ally, both the heat-only and noise-only groups exhibited els. After adjustment, occupational heat exposure was
Table 2 Participant characteristics stratified by combined exposure categories
Variables Overall None Heat only Noise only Heat and noise P-value
N = 10,275 N = 4330 N = 2107 N = 1903 N = 1935
Age(years) 40.71 ± 10.08 40.14 ± 10.45 41.30 ± 9.65 40.78 ± 9.96 41.27 ± 9.75 < 0.001
Employment duration (years) 12.03 ± 9.89 10.86 ± 9.83 13.96 ± 10.46 11.72 ± 9.73 12.87 ± 9.16 < 0.001
Gender, n (%) < 0.001
Male 8,652 (84.2%) 3,571 (82.5%) 1,799 (85.4%) 1,595 (83.8%) 1,687 (87.2%)
Female 1,623 (15.8%) 759 (17.5%) 308 (14.6%) 308 (16.2%) 248 (12.8%)
Income level, n (%) < 0.001
Low 8,696 (84.6%) 3,689 (85.2%) 1,765 (83.8%) 1,619 (85.1%) 1,623 (83.9%)
Medium 1,231 (12.0%) 481 (11.1%) 263 (12.5%) 198 (10.4%) 289 (14.9%)
High 348 (3.4%) 160 (3.7%) 79 (3.7%) 86 (4.5%) 23 (1.2%)
Company size, n (%) < 0.001
Small 4,592 (45.4%) 1,757 (41.1%) 1,070 (51.2%) 1,041 (55.8%) 724 (38.2%)
Large 5,533 (54.6%) 2,518 (58.9%) 1,019 (48.8%) 825 (44.2%) 1,171 (61.8%)
Protect measure, n (%) < 0.001
No 4,225 (41.1%) 1,664 (38.4%) 992 (47.1%) 654 (34.4%) 915 (47.3%)
Yes 6,050 (58.9%) 2,666 (61.6%) 1,115 (52.9%) 1,249 (65.6%) 1,020 (52.7%)
Hypertension, n (%) < 0.001
No 7,347 (71.5%) 3,336 (77.0%) 1,427 (67.7%) 1,388 (72.9%) 1,196 (61.8%)
Yes 2,928 (28.5%) 994 (23.0%) 680 (32.3%) 515 (27.1%) 739 (38.2%)
Diabetes, n (%) 0.309
No 7,904 (92.7%) 3,081 (93.4%) 1,898 (92.6%) 1,260 (92.1%) 1,665 (92.2%)
Yes 620 (7.3%) 219 (6.6%) 152 (7.4%) 108 (7.9%) 141 (7.8%)
Renal dysfunction, n (%) < 0.001
No 6,826 (81.8%) 2,919 (83.8%) 1,375 (78.7%) 1,196 (82.8%) 1,336 (80.2%)
Yes 1,514 (18.2%) 563 (16.2%) 373 (21.3%) 249 (17.2%) 329 (19.8%)
Liver dysfunction, n (%) < 0.001
No 6,198 (72.1%) 2,551 (74.0%) 1,401 (69.9%) 1,039 (76.0%) 1,207 (67.7%)
Yes 2,402 (27.9%) 894 (26.0%) 604 (30.1%) 328 (24.0%) 576 (32.3%)
Pulmonary dysfunction, n (%) 0.006
No 4,993 (75.2%) 2,101 (77.2%) 977 (74.1%) 1,196 (75.0%) 719 (71.9%)
Yes 1,643 (24.8%) 622 (22.8%) 342 (25.9%) 398 (25.0%) 281 (28.1%)
Abnormal ECG, n (%) < 0.001
No 7,297 (71.0%) 3,280 (75.8%) 1,498 (71.1%) 1,315 (69.1%) 1,204 (62.2%)
Yes 2,978 (29.0%) 1,050 (24.2%) 609 (28.9%) 588 (30.9%) 731 (37.8%)
Note: Table 2 presents the characteristics of workers stratified by combined heat and noise exposure, categorized into four groups: no exposure, heat only, noise
only, and dual exposure

Li et al. BMC Public Health (2025) 25:3533 Page 7 of 15
Fig. 1 Logistic regression analysis of exposures to heat and noise on different health outcomes. A: The association between heat and health outcomes.
B: The association between noise and health outcomes. Model 1 was unadjusted; Model 2 was adjusted for age, gender, work duration, income level,
protective measure, and company size. ***P< 0.001, **P< 0.01, *P < 0.05.

Li et al. BMC Public Health (2025) 25:3533 Page 8 of 15
significantly associated with increased risks of hyperten- the excess relative risk due to interaction was 0.26 for
sion (OR = 1.58, 95% CI: 1.39–1.75), renal dysfunction hypertension and 0.16 for abnormal ECG. Furthermore,
(OR = 1.20, 95% CI: 1.06–1.34), liver dysfunction (OR the analysis revealed that combined exposure was associ-
= 1.62, 95% CI: 1.44–1.78), pulmonary dysfunction (OR ated with increased risks of liver dysfunction (OR=1.58,
= 1.47, 95% CI: 1.29–1.67), and abnormal ECG (OR = 95%CI: 1.31-1.92; RERI=0.18) and pulmonary dysfunc-
1.23, 95% CI: 1.10–1.38). No significant association was tion (OR=1.38, 95%CI: 1.15-1.68; RERI=0.14), however,
observed with diabetes. Similarly, noise exposure was sig- the interaction did not reach statistical significance.
nificantly associated with hypertension (OR = 1.21, 95% These results suggest that while concurrent heat and
CI: 1.04–1.35) and abnormal ECG (OR = 1.35, 95% CI: noise exposure may adversely affect multiple health out-
1.19–1.49), but not with diabetes or renal dysfunction. comes, the synergistic effects are particularly evident in
cardiovascular outcomes.
Interaction effects of heat and noise exposure
Figure 2 presents the results of RERI analysis examin- Prediction performance of random forest model for health
ing the combined effects of heat and noise exposure outcomes
on various health outcomes. The findings show that The predictive performance of the random forest model
co-exposure to heat and noise significantly increased varied across different health outcomes, as shown in
the risks of hypertension (OR=1.94, 95%CI: 1.61-2.36; Table S1 and Figure S1. In terms of discriminative abil-
RERI=0.26) and abnormal ECG (OR=1.81, 95%CI:1.48- ity, all models achieved AUC values above 0.75, indicat-
2.12; RERI=0.16), with statistically significant interac- ing good predictive performance. Pulmonary dysfunction
tion effects (P interaction < 0.001). RERI values of 0.26 (AUC=0.839, 95% CI: 0.819–0.860) and liver dysfunction
and 0.16 suggest synergistic interactions, indicating that (AUC=0.807, 95% CI: 0.786–0.827) demonstrated the
Fig. 2 Assessment of interaction effects between occupational heat and noise on health outcomes using RERI Analysis. The RERI was calculated as:
RERI = OR11 - OR10 - OR01 + 1, where OR11 represents the odds ratio for joint exposure, OR10 and OR01 denote odds ratios for single exposures. A RERI
>0 suggests synergistic interaction (combined effect exceeds sum of individual effects), RERI = 0 indicates no additive interaction, and RERI < 0 implies
antagonistic interaction (combined effect weaker than individual effects sum). The model was adjusted for age, gender, employment duration, income
level, protective measure, and company size

Li et al. BMC Public Health (2025) 25:3533 Page 9 of 15
highest discriminative power, followed by renal dysfunc- the model demonstrated robust predictive performance
tion (AUC=0.784, 95% CI: 0.753–0.815) and abnormal across the evaluated health outcomes.
ECG (AUC=0.771, 95% CI: 0.750–0.792). Classification
metrics revealed that the model for renal dysfunction Analyzing the contribution of factors on occupational
exhibited high accuracy (0.759), while liver dysfunction health outcomes using random forest and SHAP methods
had the highest sensitivity (0.847), and renal dysfunc- Figure 3 and Table S2 show the mean absolute SHAP val-
tion exhibited the highest specificity (0.771). Overall, ues derived from the random forest model, highlighting
Fig. 3 Analysis of determinant factors for health outcomes using random forest and SHAP methods. A: SHAP Variable Importance for Hypertension. B:
SHAP Variable Importance for Diabetes. C: SHAP Variable Importance for Renal dysfunction. D: SHAP Variable Importance for Pulmonary dysfunction. E:
SHAP Variable Importance for Liver dysfunction. F: SHAP Variable Importance for Abnormal ECG. Random forest models (constructed using the R package
randomForest) and SHAP (SHapley Additive exPlanations) methods were used to analyze determinants of health outcomes. SHAP values were computed
using the R package fastshap, reflecting the marginal contribution of each feature to the model's predictive outcomes (based on the means of absolute
SHAP values).

Li et al. BMC Public Health (2025) 25:3533 Page 10 of 15
Table 3 Mediation of the association between occupational exposure and health outcomes by WBC
Exposure Health outcome Direct effect Indirect effect Total effect Proportion
of mediation
Heat Hypertension 0.0579 (0.0360, 0.0802)*** 0.0059 (0.0034, 0.0090)*** 0.0638 (0.0418, 0.0869)*** 9.2%
Heat Diabetes 0.0033 (−0.0154, 0.0209) 0.0003 (−0.0004, 0.0012) 0.0036 (−0.0149, 0.0215) 8.3%
Heat Renal dysfunction 0.0335 (0.0117, 0.0605)** 0.001 (−0.0009, 0.0017) 0.0345 (0.0131, 0.0608)** 2.9%
Heat Pulmonary 0.0523 (0.0169, 0.0875)*** 0.0028 (−0.0003, 0.0065) 0.0550 (0.0220, 0.0888)*** 5.1%
dysfunction
Heat Liver dysfunction 0.0573 (0.0337, 0.0821)*** 0.0033 (0.0015, 0.0053)*** 0.0606 (0.0366, 0.0854)*** 5.4%
Heat Abnormal ECG 0.0526 (0.0199, 0.0819)*** 0.0039 (0.0018, 0.0064)*** 0.0565 (0.0239, 0.0861)*** 7.0%
Noise Hypertension 0.0225 (0.0032, 0.0291)*** 0.0018 (0.0009, 0.0025)*** 0.0243 (0.0036, 0.0316)*** 7.4%
Noise Diabetes 0.0041 (−0.0105, 0.0198) 0.0007 (−0.0014, 0.0027) 0.0048 (−0.0087, 0.0196) 14.6%
Noise Renal dysfunction 0.0097 (−0.0173, 0.0344) 0.0004 (−0.0006, 0.0013) 0.0101 (−0.0266, 0.0364) 3.9%
Noise Pulmonary 0.0169 (−0.0205, 0.0512) 0.0002 (−0.0016, 0.0007) 0.0171 (−0.0213, 0.0505) 1.2%
dysfunction
Noise Liver dysfunction 0.0217 (−0.0090, 0.0547) 0.0033 (0.0013, 0.0057)*** 0.0250 (−0.0059, 0.0585) 13.2%
Noise Abnormal ECG 0.0726 (0.0517, 0.0952)*** 0.0049 (0.0025, 0.0078)*** 0.0775 (0.0561, 0.1006)*** 6.4%
Heat and noise Hypertension 0.0791 (0.0497, 0.1087)*** 0.0143 (0.0105, 0.0185)*** 0.0934 (0.0660, 0.1220)*** 15.3%
Heat and noise Diabetes 0.0085 (−0.0052, 0.0231) 0.0003 (−0.0004, 0.0009) 0.0088 (−0.0052, 0.0234) 3.4%
Heat and noise Renal dysfunction 0.0123 (−0.0108, 0.0387) 0.0010 (−0.0034, 0.0054) 0.0133 (−0.0092, 0.0386) 7.6%
Heat and noise Pulmonary 0.0603 (0.0178, 0.1052)* 0.0054 (−0.0047, 0.0163) 0.0657 (0.0248, 0.1083)** 8.2%
dysfunction
Heat and noise Liver dysfunction 0.0631 (0.0367, 0.0919)*** 0.0082 (0.0041, 0.0116)*** 0.0713 (0.0449, 0.0998)*** 11.5%
Heat and noise Abnormal ECG 0.0744 (0.0449, 0.0951)*** 0.0071 (0.0027, 0.0109)*** 0.0815 (0.0563, 0.1065)*** 8.7%
Note: Mediation analysis was performed using R’s mediation package to assess WBC’s role in occupational exposure and health outcomes. All models were adjusted
for age, gender, employment duration, income level, company size and protect measure. Effects were estimated via 10,000 Monte Carlo simulations, with direct
effects (ADE), indirect effects (ACME), total effects, and mediation proportions reported
*p < 0.05, **p < 0.01, ***p < 0.001
the relative contribution of key predictors across vari- (11.33±4.79×10⁹/L) and abnormal ECG findings
ous health outcomes. Age and employment duration (10.23±4.65×10⁹/L) in the co-exposure group exceeded
consistently emerged as the two most influential predic- normal WBC ranges (4-10.0×10⁹/L) and showed signifi-
tors, ranking highest for hypertension (SHAP: 0.048 and cantly higher values than single-exposure or non-expo-
0.052, respectively), liver dysfunction (0.058 and 0.042) sure groups (all P<0.001).
and abnormal ECG (0.037 and 0.039). A noteworthy find- Mediation analysis in Table 3 further elucidates the
ing was the synergistic effect of combined heat and noise Mediating role of WBC between occupational expo-
exposure, which demonstrated a greater contribution sures and health outcomes. For single heat exposure,
than single exposure alone across all health outcomes, WBC significantly mediated associations with hyper-
underscoring the importance of evaluating interactive tension (mediation proportion 9.2%), liver dysfunction
effects in occupational health assessments. (5.4%), and abnormal ECG findings (7.0%) (all P<0.001).
Under single noise exposure, WBC also demonstrated
Mediation analysis of WBC's role in occupational exposures significant mediation effects for hypertension (7.4%)
and health outcomes and abnormal ECG findings (6.4%) (P<0.001). Remark-
Table S3 systematically compares the distribution char- ably, during heat and noise co-exposure, the mediating
acteristics of WBC across different occupational expo- role of WBC was enhanced, with mediation proportions
sure combinations. The data reveal a significant exposure increasing to 15.3% for hypertension and 8.7% for abnor-
gradient in WBC levels: the non-exposure group showed mal ECG findings (all P<0.001). Meanwhile, WBC also
the lowest values (6.38±2.80×10⁹/L), followed by single- has a mediating effect on liver dysfunction in the co-
exposure groups (heat-only: 6.76±2.62×10⁹/L; noise-only: exposure group (11.5%, P<0.001). These findings demon-
6.63±1.80×10⁹/L), while the heat and noise co-exposure strate that inflammation-related changes, as represented
group exhibited the highest levels (8.32±4.34×10⁹/L, by WBC count, play quantitatively distinct roles in con-
P<0.001). Notably, WBC levels were further elevated necting occupational exposures with adverse health out-
in patients with various chronic diseases compared to comes under different exposure conditions.
healthy individuals, with the most pronounced increases
observed in the co-exposure group. For instance, patients
with hypertension (10.17±4.90×10⁹/L), liver dysfunction

Li et al. BMC Public Health (2025) 25:3533 Page 11 of 15
Sensitivity analysis addressing healthy worker effect bias during fire suppression activities, further corroborating
To assess the potential bias of the Healthy Worker Effect the cardiovascular risks of occupational heat exposure
(HWE), we additionally included data from 311 workers [34]. From a pathophysiological perspective, the mecha-
who left employment with complete health examination nisms underlying heat-induced multi-system damage
records and occupational exposure profiles during 2020- may involve several pathways. Heat stress can activate
2022. After inclusion, the prevalence rates of all health the sympathetic nervous system, leading to increased
outcomes increased: hypertension rose from 28.5% to cardiac output and peripheral vascular resistance, which
29.6%, diabetes from 7.3% to 7.6%, renal dysfunction subsequently induces sustained blood pressure elevation
from 18.2% to 19.1%, pulmonary dysfunction from 24.8% and myocardial remodeling. Additionally, heat-related
to 25.4%, liver dysfunction from 27.9% to 29.2%, and dehydration may trigger the renin-angiotensin-aldoste-
abnormal ECG from 29.0% to 30.3%. The sensitivity anal- rone system (RAAS), simultaneously increasing cardio-
ysis results in Table S4 revealed increases in OR across vascular load and causing direct structural damage to
most exposure categories compared to the original analy- renal tubules [35–37]. These complex pathophysiological
sis in Table 1. For instance, the OR of for hypertension mechanisms collectively form the scientific basis for heat
for single heat exposure increased from 1.51 (1.30-1.70) exposure-induced multi-system dysfunction.
to 1.64 (1.38-2.02), for single noise exposure increased Noise exposure is a well-recognized occupational haz-
from 1.17 (1.06-1.29) to 1.28 (1.13-1.49), while for heat ard affecting both auditory and non-auditory systems.
and noise co-exposure rose from 1.94 (1.61-2.36) to 2.11 Chronic noise exposure can lead to a spectrum of health
(1.76-2.83), similar patterns were observed for abnor- impairments ranging from sleep disturbances and cog-
mal ECG, renal dysfunction, pulmonary dysfunction and nitive dysfunction to metabolic disorders and increased
liver dysfunction. These findings confirm the existence diabetes risk [38, 39]. Our findings further substanti-
of HWE. Nevertheless, the statistical significance of the ate this body of evidence, demonstrating that occupa-
association between combined heat and noise expo- tional noise exposure elevates risks of hypertension and
sure and health outcomes remained unchanged or even abnormal ECG findings. These results align with global
increased, indicating that the overarching conclusion on epidemiological data, including comprehensive reviews
occupational health risks remains robust. reporting multifactorial and complex relationships
between built environments and increased cardiovas-
Discussion
cular disease risk with poor prognosis [40, 41]. Further-
This study, based on a multi-industry cross-sectional more, a systematic review and meta-analysis examining
survey covering all prefecture-level cities in Fujian Prov- cardiovascular health effects of noise exposure docu-
ince, China, investigated the effects of combined work- mented impacts on blood pressure, hypertension, heart
place heat and noise exposure on multi-system health rate, arrhythmias, vascular resistance, and cardiac out-
outcomes among Chinese occupational populations. The put at higher exposure levels [42]. The pathophysiologi-
results not only reaffirmed the health risks associated cal mechanisms underlying these noise-induced health
with single exposures but also revealed synergistic effects effects likely involve multiple biological pathways, includ-
of combined heat and noise exposure and their underly- ing oxidative stress activation, induction of systemic
ing inflammatory mediation mechanisms. These findings inflammatory responses, and prothrombotic state forma-
provide important evidence for workplace hazard risk tion [43, 44].
assessment and the development of protective measures, This study advances current knowledge by revealing
and hold significant implications for mitigating heat- significant synergistic effects of combined heat and noise
related health burdens in the context of climate warming exposure through both traditional and machine learn-
[32]. ing models. Specifically, logistic regression analyses and
This study identified significant associations between RERI analysis demonstrated more pronounced hyper-
occupational heat exposure and multiple health risks, tension and ECG abnormality risks under dual exposure
including hypertension, abnormal ECG findings, renal compared to single exposures. This synergistic effect is
dysfunction, liver dysfunction, and pulmonary dysfunc- supported by experimental evidence: Dehghan et al.[45]
tion. These findings are consistent with previous inter- confirmed in climate chamber studies that heat exposure
national studies. For instance, a cohort study of Costa significantly exacerbates noise-induced blood pressure
Rican rice farmers demonstrated that chronic heat expo- elevation. Other studies have documented similar wors-
sure led to decreased estimated glomerular filtration rate ening trends in blood pressure variability under com-
(eGFR), suggesting that heat stress may cause irreversible bined exposure conditions [46]. An experimental study
kidney damage [33]. Similarly, an observational study of involving 216 elderly male participants in Iran further
U.S. firefighters revealed significantly increased inci- showed that while heart rate increased with rising noise
dence of coronary syndrome and abnormal ECG findings levels, this effect became significantly more pronounced

Li et al. BMC Public Health (2025) 25:3533 Page 12 of 15
at higher ambient temperatures, even with relatively fibrosis, ultimately resulting in disease onset [52]. Mean-
low noise levels [47]. Similarly, a simulation of neuro- while, noise exposure can stimulate the proliferation of
physiological responses to combined noise and heat in inflammatory cells such as WBC through mechanisms
indoor environments revealed that elevated temperatures involving the hypothalamic-pituitary-adrenal axis [53].
amplified neurophysiological responses more substan- Therefore, when both factors act together, they may pro-
tially when accompanied by high noise levels, with more duce an additive inflammatory activation effect, which
marked combined effects on heart rate and respiratory could explain the higher mediating proportion of WBC
frequency than either factor alone [48]. under coexposure conditions. In this study, although the
Subsequently, our random forest machine learning WBC levels in the single-exposure group did not exceed
model identified the interaction between heat and noise the normal range, they were still significantly higher than
exposure as a more significant predictor of adverse health those in the non-exposed group. Such an elevation within
outcomes than either exposure alone. These findings the normal range remains epidemiologically meaningful,
reinforce the importance of addressing combined occu- suggesting that some workers may already exhibit a sub-
pational hazards rather than managing them in isolation clinical inflammatory state, characterized by low-grade
and have practical implications for workplace interven- systemic inflammation despite the absence of overt clini-
tions. First, priority should be given to identifying and cal symptoms. A meta-analysis has indicated that even
mitigating risks in work environments where simultane- within the normal range, WBC levels maintain a statis-
ous heat and noise exposures are prevalent. This includes tically significant association with disease incidence [54].
implementing joint monitoring systems for temperature, Similarly, multiple previous studies have demonstrated
humidity, and noise levels to enable real-time hazard that even modest increases in WBC within the normal
assessment. Engineering controls—such as installing range can still mediate the relationship between expo-
soundproof cooling equipment, optimizing ventilation, sure and disease [55–63]. Therefore, these subtle changes
and using noise-absorbing materials alongside local- in WBC may reflect early subclinical damage, serving as
ized cooling—can help reduce dual exposure levels. an early warning sign for intervention in occupational
Operational strategies should also consider reschedul- health monitoring.
ing high-noise tasks to cooler periods of the day to mini- Furthermore, although the mediating proportion of
mize combined stress. Additionally, occupational safety WBC in some single-exposure outcomes was numerically
training programs should incorporate the risks associ- small, its public health significance should not be over-
ated with co-exposure to heat and noise, aiming to raise looked. These “small effects” may be part of a broader,
worker awareness and improve the effectiveness of pro- multifactorial pathogenic network. Occupational expo-
tective behaviors. These integrated measures offer a more sures often impact health through multiple, interacting
robust framework for safeguarding worker health in pathways, and even modest mediation effects can con-
complex exposure scenarios. tribute substantially when considered cumulatively [64–
Through mediation analysis, this study found that 66]. Beyond systemic inflammation reflected by WBC
WBC plays a mediating role in the relationship between counts, other biological pathways may also mediate the
occupational exposure and multiple health outcomes. association between heat or noise exposure and disease.
Although the effect sizes varied, these results highlight Animal studies have shown that heat stress can induce
the critical role of systemic inflammation as a common respiratory diseases through various mediators, includ-
underlying mechanism for cardiovascular, hepatic, and ing serum immune markers (Total-IgE, OVA-sIgE, and
respiratory dysfunction [49–51]. In the study, we strati- IL-4), pro-inflammatory cytokines (IL-6 and TNF-α), and
fied the population’s WBC levels based on coexposure oxidative stress markers (8-OHdG, ROS, and MDA) [67].
status and disease conditions, revealing that in cases Meanwhile, a Mendelian randomization study exam-
where coexposure and disease coexisted, WBC levels ining noise as the exposure, 91 inflammatory factors as
not only exceeded the normal range but were also sig- mediators, and 26 diseases as outcomes revealed that
nificantly higher than those in the non-exposed group noise exposure could contribute to disease development
or single-exposure group. Combined with the media- through multiple inflammatory mediators, including
tion analysis results, WBC exhibited a higher mediating cytokines, chemokines, and prostaglandins [68]. Under
proportion in the association between coexposure and conditions of co-exposure, these mechanisms interact,
disease, suggesting that the synergistic effect of com- collectively forming a complex pathogenic network in
bined exposure may amplify inflammatory responses and occupational settings. These findings not only deepen
exacerbate disease progression. Mechanistically, long- our understanding of the mechanisms underlying occu-
term heat exposure may lead to persistent immune acti- pational exposure-related diseases but, more importantly,
vation, triggering elevated WBC counts, which in turn provide a solid theoretical foundation for developing
contribute to endothelial dysfunction and myocardial

Li et al. BMC Public Health (2025) 25:3533 Page 13 of 15
multi-target intervention strategies centered on modulat- factors and strengthen the biological plausibility of
ing inflammatory responses. observed associations.
Finally, although this study was conducted in Fujian
Conclusion
Province, China, the findings offer valuable reference
points for other regions and countries. As a major coastal This study provides evidence that concurrent exposure
industrial province in southeastern China, Fujian shares to occupational heat and noise exerts synergistic effects,
comparable industrial structures (e.g., manufactur- significantly amplifying multi-system health risks in the
ing and mining) with many industrialized regions glob- Chinese working population. Systemic inflammation, as
ally, supporting the broader applicability of the results indicated by WBC count, appears to be a key mediat-
[69, 70]. The occupational exposure limits used in this ing mechanism. These findings challenge the adequacy
study are based on national standards in China, while of traditional single-exposure assessment models and
the diagnostic criteria for major health outcomes adhere underscore the urgent need for integrated evaluation of
to internationally recognized guidelines—both of which combined occupational hazards. Our results offer a sci-
strengthen the external validity of our findings. None- entific foundation for developing more precise, inflam-
theless, we acknowledge that variations in climate con- mation-focused occupational health prevention and
ditions, worker acclimatization, and occupational health intervention strategies.
policies may influence the degree to which our conclu-
Supplementary Information
sions apply elsewhere. For example, workers in tropical
The online version contains supplementary material available at h t t p s : / / d o i . o r
climates may develop physiological adaptations to heat,
g / 1 0 . 1 1 8 6 / s 1 2 8 8 9 - 0 2 5 - 2 4 5 9 2 - 1.
whereas those in temperate or colder environments may
exhibit increased vulnerability to thermal stress [71–73]. Supplementary Material 1.
Furthermore, differences in occupational safety stan-
Supplementary Material 2.
dards, enforcement, and access to protective measures
Supplementary Material 3.
must be considered when applying these findings in other
settings. Such contextual factors should be carefully eval- Supplementary Material 4.
uated to ensure appropriate interpretation and imple-
mentation of our results across diverse occupational Acknowledgements
The authors would like to express their gratitude to the Fujian Center for
environments.
Prevention and Control of Occupational Diseases and Chemical Poisoning for
the provision of the surveillance data.
Limitations
Authors’ contributions
This study has several limitations. First, its cross-sec-
M.L., Y.Z. and J.X. designed the study. Y.Z., C.W., Y.J., and J.L. in collected the
tional design allows for the identification of associations data. M.L., J.X. and J.L. analysed the data. Y.Z.,C.W. and Y.J. contributed to the
between exposures and health outcomes but precludes interpretation of results. M.L., J.X. and J.L. wrote and reviewed the manuscript.
All authors discussed the results and commented on the manuscript. All
any inference of causality. Second, although data from
authors read and approved the final manuscript.
workers who left employment during the survey period
were included in sensitivity analyses, the lack of detailed Funding
This work was supported by the Minjiang Scholar Start-up Research Fund of
information regarding their specific reasons for leaving
Fujian Province (Grant No. 2019-9202001001).
may introduce residual HWE bias. Third, while major
confounders were adjusted, unmeasured lifestyle factors Data availability
The datasets used in this study are available from the corresponding author
like smoking status, alcohol consumption, and dietary
upon reasonable request.
patterns may still affect results. Furthermore, the lack
of specific inflammatory biomarkers (e.g., hs-CRP, IL-6,
Declarations
TNF-α, and fibrinogen) limits mechanistic insights.
To address these limitations, future research should Ethics approval and consent to participate
This study was approved by the Ethics Committee of Fujian Medical University
consider adopting longitudinal cohort designs to track
(Approval No. 2022 − 111).
changes in exposure and health outcomes over time.
Complementary controlled experiments (e.g., interven- Consent for publication
Not applicable.
tion or quasi-experimental studies) could provide further
causal validation. Moreover, improvements in occupa- Competing interests
tional health recordkeeping—particularly regarding job The authors declare no competing interests.
exit reasons—would help refine assessments of the HWE.
Received: 13 June 2025 / Accepted: 25 August 2025
Finally, systematic collection of lifestyle data and relevant
biomarkers would enhance adjustment for confounding

Li et al. BMC Public Health (2025) 25:3533 Page 14 of 15
References 22. Ma H, Liu F, Li J, Chen J, Cao J, Chen S, et al. Sex differences in associations
1. He J, Smith LM, Shkembi A, Neitzel RL. Evaluating the impact of occupa- between socioeconomic status and incident hypertension among Chinese
tional noise exposure on workplace fatal and nonfatal injuries in the U.S. adults. Hypertension. 2023;80(4):783–91.
(2006–2020). Int J Hyg Environ Health. 2025;263:114468. 23. McCarthy CP, Bruno RM, Rahimi K, Touyz RM, McEvoy JW. What is new and
2. Zhang Y, Chen Y, Su Q, Huang X, Li Q, Yang Y, et al. The use of machine and different in the 2024 European society of cardiology guidelines for the
deep learning to model the relationship between discomfort temperature management of elevated blood pressure and hypertension?? Hypertension.
and labor productivity loss among petrochemical workers. BMC Public 2025;82(3):432–44.
Health. 2024;24(1):3269. 24. ElSayed NA, Aleppo G, Aroda VR, Bannuru RR, Brown FM, Bruemmer D, Collins
3. Han S, Dong L, Weng Y, Xiang J. Heat exposure and productivity loss among BS, Cusi K, Das SR, Gibbons CH, et al. Summary of revisions: standards of care
construction workers: a meta-analysis. BMC Public Health. 2024;24(1):3252. in Diabetes-2023. Diabetes Care. 2023;46(Suppl 1):S5–9.
4. Gedik Toker Ö, Tas Elibol N, Kuru E, Görmezoğlu Z, Görener A, Toker K. Indus- 25. Levey AS, Eckardt KU, Tsukamoto Y, Levin A, Coresh J, Rossert J, et al.
trial noise: impacts on workers’ health and performance below permissible Definition and classification of chronic kidney disease: a position state-
limits. BMC Public Health. 2025;25(1):1615. ment from kidney disease: improving global outcomes (KDIGO). Kidney Int.
5. Xu NS. Z: Heat and health of occupational workers: a short summary of 2005;67(6):2089–100.
literature. J Occup Health. 2024;66(1):uiae018. 26. Levey AS, Atkins R, Coresh J, Cohen EP, Collins AJ, Eckardt KU, et al. Chronic
6. Flouris AD, Dinas PC, Ioannou LG, Nybo L, Havenith G, Kenny GP, Kjellstrom T. kidney disease as a global public health problem: approaches and initiatives
Workers’ health and productivity under occupational heat strain: a systematic - a position statement from kidney disease improving global outcomes.
review and meta-analysis. Lancet Planet Health. 2018;2(12):e521–31. Kidney Int. 2007;72(3):247–59.
7. Li W, Zhu J, Hao X, Chen Z, Wang D. Noise exposure in the workplace, genetic 27. Graham BL, Steenbruggen I, Miller MR, Barjaktarevic IZ, Cooper BG, Hall GL,
susceptibility, and incidence of atrial fibrillation: a prospective cohort study. J Hallstrand TS, Kaminsky DA, McCarthy K, McCormack MC, et al. Standardiza-
Am Heart Assoc. 2024;13(21):e036543. tion of spirometry 2019 update. An official American thoracic society and
8. Teixeira LR, Pega F, Dzhambov AM, Bortkiewicz A, da Silva DTC, de Andrade European respiratory society technical statement. Am J Respir Crit Care Med.
CAF, Gadzicka E, Hadkhale K, Iavicoli S, Martínez-Silveira MS, et al. The effect 2019;200(8):e70–88.
of occupational exposure to noise on ischaemic heart disease, stroke and 28. Quanjer PH, Stanojevic S, Cole TJ, Baur X, Hall GL, Culver BH, et al. Multi-ethnic
hypertension: A systematic review and meta-analysis from the WHO/ILO reference values for spirometry for the 3-95-yr age range: the global lung
joint estimates of the Work-Related burden of disease and injury. Environ Int. function 2012 equations. Eur Respir J. 2012;40(6):1324–43.
2021;154:106387. 29. Xu J, Xu ZX, Yang QF, Zhuang J, Zhu X, Yao J. Association between the
9. López-Bueno JA, Padrón-Monedero A, Díaz J, Navas-Martín MA, Linares C. sarcopenia index and abnormal liver function in the adult population in the
Short-term impact of air pollution, noise and temperature on emergency United States: a cross-sectional study. Front Med. 2023;10:1266253.
hospital admissions in Madrid (Spain) due to liver and gallbladder diseases. 30. Kim WD, Lee Y, Kim BS, Kim HJ, Shin JH, Park JK, et al. Electrocardiogra-
Environ Res. 2024;249:118439. phy score based on the Minnesota code classification system predicts
10. Blaustein JR, Quisel MJ, Hamburg NM, Wittkopp S. Environmental cardiovascular mortality in an asymptomatic low-risk population. Ann Med.
impacts on cardiovascular health and biology: an overview. Circ Res. 2023;55(2):2288306.
2024;134(9):1048–60. 31. Kligfield P, Gettes LS, Bailey JJ, Childers R, Deal BJ, Hancock EW, et al. Recom-
11. Guo J, Garshick E, Si F, Tang Z, Lian X, Wang Y, et al. Environmental toxicant mendations for the standardization and interpretation of the electrocar-
exposure and depressive symptoms. JAMA Netw Open. 2024;7(7):e2420259. diogram: part I: the electrocardiogram and its technology: a scientific
12. Wang Y, Meng Z, Wei S, Li X, Su Z, Jiang Y, et al. Urinary volatile organic com- statement from the American Heart Association Electrocardiography and
pound metabolites and COPD among US adults: mixture, interaction and Arrhythmias Committee, Council on Clinical Cardiology; the American Col-
mediation analysis. Environ Health. 2024;23(1):45. lege of Cardiology Foundation; and the Heart Rhythm Society: endorsed by
13. Fu Z, Zhou S, Weng Z, Liang G, Gu A. Association between nickel and the International Society for Computerized Electrocardiology. Circulation.
multiple metabolic outcomes: the mediating roles of lipid metabolism and 2007;115(10):1306–24.
inflammation. Ecotoxicol Environ Saf. 2025;298:118274. 32. Ensuring safety. and health at work in a changing climate [ h t t p s : / / w w w . i l o . o r
14. Jafari MJ, Pirposhteh EA, Dehghan SF, Khodakarim S, Jafari M. Relationship g / p u b l i c a t i o n s / e n s u r i n g - s a f e t y - a n d - h e a l t h - w o r k - c h a n g i n g - c l i m a t e]
between heat stress exposure and some immunological parameters among 33. Crowe J, Rojas-Valverde D, Rojas-Garbanzo M, Gutiérrez-Vargas R, Ugalde-
foundry workers. Int J Biometeorol. 2020;64(5):853–61. Ramírez JA, Ledezma-Rojas JP, Cabrera-Alpizar W, Salazar-Salazar M, Mauricio-
15. Gao Y, Liu Y, He J, Zhang Y, Wang T, Wu L, Sun N, Fang T, Mao H, Tang NJ, et al. La Torre R, Valera-Amador L et al. Kidney function in rice workers exposed
Effects of heat waves and cold spells on blood parameters: a cohort study of to heat and dehydration in Costa Rica. Int J Environ Res Public Health.
blood donors in tianjin, China. Environ Health Prev Med. 2024;29:25. 2022;19(9):4962.
16. Barros B, Oliveira M, Morais S. Firefighters’ occupational exposure: con- 34. Al-Zaiti S, Rittenberger JC, Reis SE, Hostler D. Electrocardiographic responses
tribution from biomarkers of effect to assess health risks. Environ Int. during fire suppression and recovery among experienced firefighters. J
2021;156:106704. Occup Environ Med. 2015;57(9):938–42.
17. Mohammadi H, Alimohammadi I, Roshani S, Pakzad R, Abdollahi MB, Deh- 35. Inoue Y, Ichinose-Kuwahara T, Nakamura S, Ueda H, Yasumatsu H, Kondo N,
ghan SF. The effect of occupational noise exposure on blood and biochemi- et al. Cutaneous vasodilation response to a linear increase in air temperature
cal parameters: a case study of an insulator manufacturer in Iran. Electron from 28 degrees C to 40 degrees C in prepubertal boys and young men. J
Physician. 2016;8(1):1740–6. Physiol Anthropol. 2009;28(3):137–44.
18. China, MoHotPsRo. GBZT189.7-2007-Measurement of physical factors in the 36. Cheng X, Su H. Effects of climatic temperature stress on cardiovascular
workplace part 7: high temperature. In. Beijing: China Standard; 2007. diseases. Eur J Intern Med. 2010;21(3):164–7.
19. National Health Commission of the People’s Republic of China. Classification 37. Shan R, Liu N, Yan Y, Liu B. Apoptosis, autophagy and atherosclerosis: relation-
of occupational hazards at workplaces – Part 4: Occupational exposure to ships and the role of Hsp27. Pharmacol Res. 2021;166:105169.
noise. Beijing: National Health Commission of the People’s Republic of China; 38. Hammer MS, Swinburn TK, Neitzel RL. Environmental noise pollution in the
2012. United States: developing an effective public health response. Environ Health
20. Currie KD, Schultz MG, Millar PJ, Pescatello LS. The role of exercise blood pres- Perspect. 2014;122(2):115–9.
sure in hypertension: measurement, mechanisms, and management. Med Sci 39. Passchier-Vermeer W, Passchier WF. Noise exposure and public health. Envi-
Sports Exerc. 2025;57(2):425–33. ron Health Perspect. 2000;108(Suppl 1):123–31.
21. Pickering TG, Hall JE, Appel LJ, Falkner BE, Graves J, Hill MN, et al. Recom- 40. Noorali AA, Hussain Merchant AA, Afzal N, Sen R, Junaid V, Khoja A, et al. Built
mendations for blood pressure measurement in humans and experimental environment and cardiovascular diseases - insights from a global review. Curr
animals: Part 1: blood pressure measurement in humans: a statement for Atheroscler Rep. 2025;27(1):36.
professionals from the subcommittee of professional and public education 41. Liu M, Meijer P, Lam TM, Timmermans EJ, Grobbee DE, Beulens JWJ, et al.
of the American heart association Council on high blood pressure research. The built environment and cardiovascular disease: an umbrella review and
Circulation. 2005;111(5):697–716. meta-meta-analysis. Eur J Prev Cardiol. 2023;30(16):1801–27.
42. Sivakumaran K, Ritonja JA, Waseem H, AlShenaibar L, Morgan E, Ahmadi SA,
Denning A, Michaud DS, Morgan RL. Impact of noise exposure on risk of

Li et al. BMC Public Health (2025) 25:3533 Page 15 of 15
developing Stress-Related health effects related to the cardiovascular system: 58. Liu F, Li Y, Li W, Feng R, Zhao H, Chen J, et al. The role of peripheral white
A systematic review and Meta-Analysis. Noise Health. 2022;24(114):107–29. blood cell counts in the association between central adiposity and glycemic
43. Münzel T, Sørensen M, Gori T, Schmidt FP, Rao X, Brook FR, et al. Environmen- status. Nutr Diabetes. 2024;14(1):30.
tal stressors and cardio-metabolic disease: part II-mechanistic insights. Eur 59. Meng X, Han L, Fu J, Hu C, Lu Y. Associations between metabolic syndrome
Heart J. 2017;38(8):557–64. and depression, and the mediating role of inflammation: based on the
44. Herzog J, Schmidt FP, Hahad O, Mahmoudpour SH, Mangold AK, Garcia NHANES database. J Affect Disord. 2025;375:214–21.
Andreo P, et al. Acute exposure to nocturnal train noise induces endothelial 60. La R, Yin Y, Ding W, He Z, Lu L, Xu B, et al. Is inflammation a missing link
dysfunction and pro-thromboinflammatory changes of the plasma pro- between relative handgrip strength with hyperlipidemia? Evidence from a
teome in healthy subjects. Basic Res Cardiol. 2019;114(6):46. large population-based study. Lipids Health Dis. 2024;23(1):159.
45. Dehghan H, Bastami MT, Mahaki B. Evaluating combined effect of noise and 61. Li C, Xiang S. Adverse childhood experiences, inflammation, and depressive
heat on blood pressure changes among males in climatic chamber. J Educ symptoms in late life: a population-based study. J Gerontol B Psychol Sci Soc
Health Promot. 2017;6:39. Sci. 2023;78(2):220–9.
46. Jafari MJ, Khosrowabadi R, Khodakarim S, Khodagholi F, Mohammadian F. The 62. Wan Z, Song L, Hu L, Lei X, Huang Y, Lv Y, et al. The role of systemic inflam-
effects of combined exposure to noise and heat on human salivary cortisol mation in the association between serum 25-hydroxyvitamin D and type 2
and blood pressure. Int J Occup Saf Ergon. 2021;27(3):831–9. diabetes mellitus. Clin Nutr. 2021;40(6):3661–7.
47. Tohidi M, Fatahi K, Beigi M. Investigating the effect of ambient temperature, 63. Sun X, Zhu J, Qian Z, Chen X, Zhang J, Ji C, et al. A population-based study
sound type, and noise level on the heart rate of the elderly. Exp Gerontol. of the mediating role of WBC, NEUT and PLT in the relationship between
2025;208:112829. Triglyceride-Glucose index and urinary albumin excretion. J Inflamm Res.
48. Abbasi AM, Motamedzade M, Aliabadi M, Golmohammadi R, Tapak L. Com- 2024;17:10613–26.
bined effects of noise and air temperature on human neurophysiological 64. Hanahan D, Weinberg RA. Hallmarks of cancer: the next generation. Cell.
responses in a simulated indoor environment. Appl Ergon. 2020;88:103189. 2011;144(5):646–74.
49. Farrell SW, Leonard D, Shuval K, DeFina LF, Barlow CE, Pavlovic A, et al. Cardio- 65. Böhnke JR. Explanation in causal inference: methods for mediation and
respiratory fitness, white blood cell count, and mortality in men and women. interaction. Q J Exp Psychol (Hove). 2016;69(6):1243–4.
J Sport Health Sci. 2022;11(5):605–12. 66. Chen Y, Wu Y, Lv J, Zhou S, Lin S, Huang S, et al. Overall and individual associa-
50. Verma N, Roy A, Valsan A, Garg P, Ralmilay S, Girish V, et al. Liver dysfunction tions between per- and polyfluoroalkyl substances and liver function indices
and systemic inflammation drive organ failures in acute decompensation of and the metabolic mechanism. Environ Int. 2024;183:108405.
cirrhosis: a multicentric study. Am J Gastroenterol. 2025;120(1):182–93. 67. Lu C, Liu Q, Deng M, Liao H, Yang X, Ma P. Interaction of high temperature
51. Yang HF, Kao TW, Wang CC, Peng TC, Chang YW, Chen WL. Serum white and NO(2) exposure on asthma risk: in vivo experimental evidence of inflam-
blood cell count and pulmonary function test are negatively associated. Acta mation and oxidative stress. Sci Total Environ. 2023;869:161760.
Clin Belg. 2015;70(6):419–24. 68. Ma J, Zhang J, Zhang Y, Wang Z. Causal effects of noise and air pollution on
52. Zhang Y, Hong S, Zhang Q, Su Z, Hu G, Wang T, Yu S, Yuan F, Zhu X, Jia G. multiple diseases highlight the dual role of inflammatory factors in ambient
Relationship between systemic inflammation and lung injury induced by exposures. Sci Total Environ. 2024;951:175743.
chromate exposure: A cross-sectional study in workers. J Hazard Mater. 69. [ h t t p : / / w w w . s t a t s . g o v . c n / s j / n d s j /]
2023;452:131294. 70. Labor, Markets. [ h t t p s : / / w w w . w o r l d b a n k . o r g / e n / t o p i c / l a b o r m a r k e t s]
53. She X, Gao X, Wang K, Yang H, Ma K, Cui B, et al. Effects of noise and low- 71. Morris NB, Jay O, Flouris AD, Casanueva A, Gao C, Foster J, Havenith G, Nybo
concentration carbon monoxide exposure on rat immunity. J Occup Health. L. Sustainable solutions to mitigate occupational heat strain - an umbrella
2021;63(1):e12235. review of physiological effects and global health perspectives. Environ
54. Raya-Cano E, Vaquero-Abellán M, Molina-Luque R, Molina-Recio G, Guzmán- Health. 2020;19(1):95.
García JM, Jiménez-Mérida R, et al. Association between metabolic syndrome 72. Achebak H, Rey G, Lloyd SJ, Quijal-Zamorano M, Fernando Méndez-Turrubi-
and leukocytes: systematic review and meta-analysis. J Clin Med. 2023. h t t p s : / ates R, Ballester J. Drivers of the time-varying heat-cold-mortality association
/ d o i . o r g / 1 0. 3 3 9 0 / j c m 1 2 2 2 7 0 4 4. in spain: A longitudinal observational study. Environ Int. 2023;182:108284.
55. Liu Y, Lai X, Guo W, Ma L, Li W, Fang Q, et al. Total white blood cell count 73. Sinha P, Coville RC, Hirabayashi S, Lim B, Endreny TA, Nowak DJ. Variation in
mediated the association between increased arterial stiffness and risk of estimates of heat-related mortality reduction due to tree cover in U.S. cities. J
type 2 diabetes mellitus in Chinese adults. Arterioscler Thromb Vasc Biol. Environ Manage. 2022;301:113751.
2020;40(4):1009–15.
56. Xu B, Wu Q, La R, Lu L, Abdu FA, Yin G, et al. Is systemic inflammation a miss-
ing link between cardiometabolic index with mortality? Evidence from a Publisher’s Note
large population-based study. Cardiovasc Diabetol. 2024;23(1):212. Springer Nature remains neutral with regard to jurisdictional claims in
57. Torrungruang K, Vathesatogkit P, Mahanonda R, Thienpramuk L. Periodontitis published maps and institutional affiliations.
and hypertension are linked through systemic inflammation: a 5-year longi-
tudinal study. J Clin Periodontol. 2024;51(5):536–46.
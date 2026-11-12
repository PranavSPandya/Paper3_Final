Environmental Impact Assessment Review 122 (2027) 108642
Contents lists available at ScienceDirect
Environmental Impact Assessment Review
journal homepage: www.elsevier.com/locate/eiar
Multiple pathways of restorative responses to environmental exposures
during urban walking: Evidence from a crossover field trial
Ruoxiang Tua,b, Yonghong Xua,b, Leyuan Zhonga,b, Wen Dongc, Yiqiang Xiaoa,b, Shi Yina,b,*
aState Key Laboratory of Subtropical Building and Urban Science, South China University of Technology, Guangzhou, China
bSchool of Architecture, South China University of Technology, Guangzhou, China
cSchool of Architecture, Harbin Institute of Technology (Shenzhen), Shenzhen, China
A R T I C L E I N F O A B S T R A C T
Keywords: Nature-based walking, as an effective non-pharmacological health-promoting intervention, is associated with
Green space restorativeness. However, the influence of multiple physical environmental factors on restorative responses re-
Walking environment mains insufficiently understood under real-world, equivalent contexts. This randomized crossover field experi-
Built environment
ment examined how pedestrian-level physical environmental variability during walking relates to subjective and
Nature-based walking
physiological restorative responses. Thirty-six participants completed walking sessions in all combinations of two
Pedestrian health
Physical activity seasons and two environmental contexts (green-urban and dense-urban). Wearable sensors continuously recor-
ded thermal, acoustic, and air pollution parameters as well as physiological signals, with perceived restor-
ativeness and affect assessed at multiple experimental stages. Partial least squares structural equation modeling
(PLS-SEM) and linear mixed-effects models were applied jointly to examine exposure–response pathways.
Results demonstrate that heterogeneous environmental exposures within the same urban walking context
elicit differentiated short-term restorative responses through multiple parallel exposure–response pathways.
Affective and physiological components showed partial independence, with no significant mediation effects.
Specifically, trafficand pollution-related stressors, e.g., PM2.5 (p =0.007) and O3 (p =0.029), were primarily
associated with electrodermal arousal. Perceptual and experiential factors, e.g., visual satisfaction (p <0.001)
and ventilation (p = 0.045), predominantly influenced positive and negative affect. A significant interaction
between dense-urban walking and PM2.5 (p =0.015) further indicated context-dependent modulation of elec-
trodermal responses. Scale-dependent effects were observed, with thermal conditions operating at broader
contextual levels and traffic-related stressors acting more directly at the pedestrian scale. Together, these find-
ings highlight the importance of incorporating exposure management into urban design.
1. Introduction between health outcomes and urban living environments, which support
physical activity and social interaction (Mazumdar et al., 2018; Sallis
With continued global urban expansion and population growth et al., 2016), thereby influencing residents' daily experiences and
(United Nations, 2024), urban living environments are facing increasing mental health (Bratman et al., 2019; Pandya et al., 2025), including
pressures and challenges. These trends have increasingly emerged as those arising from routine mobility and outdoor walking environments
major public health concerns, accompanied by a rising burden of mental (Frank et al., 2019).
health disorders documented in global health reports and epidemio- Attention Restoration Theory and Stress Recovery Theory provide
logical studies (GBD 2019 Mental Disorders Collaborators, 2022; World complementary perspectives on the mental benefits of urban natural
Health Organization, 2024). Extensive research has established links spaces. Attention Restoration Theory emphasizes recovery from
Abbreviations:Rh, Relative Humidity; V, Wind Velocity; Ta, Air Temperature; Tmrt, Mean Radiant Temperature; UTCI, Universal Thermal Climate Index; PLS-
SEM, Partial Least Squares Structural Equation Modeling; LMM, Linear Mixed-effects Model; AIC, Akaike Information Criterion; EDA, Electrodermal Activity;
SCL, Skin Conductance Level; SCR, Skin Conductance Response; Tsk, Skin Temperature; Leq, Equivalent Continuous Sound Pressure Level; PANAS, Positive and
Negative Affect Schedule; PRS, Perceived Restorativeness Scale; PRND, Participant's Residential Neighborhood Density.
* Corresponding author at: School of Architecture, South China University of Technology, Wushan Road 381, Tianhe District, Guangzhou 510640, China.
E-mail addresses: arxuyh@mail.scut.edu.cn(Y. Xu), arzhongly@mail.scut.edu.cn(L. Zhong), dongwen@stu.hit.edu.cn(W. Dong), yqxiao@scut.edu.cn(Y. Xiao),
archyinshi@scut.edu.cn(S. Yin).
https://doi.org/10.1016/j.eiar.2026.108642
Received 3 March 2026; Received in revised form 5 July 2026; Accepted 27 July 2026
Available online 30 July 2026
0195-9255/© 2026 Elsevier Inc. All rights are reserved, including those for text and data mining, AI training, and similar technologies.

R. Tu et al. E n v i r o n m e n t a l I m p a c t A s s e s s m e n t R e v i e w 122 (2027) 108642
attentional fatigue through nature exposure (Kaplan and Kaplan, 1989; related environmental exposures across space, time, and scale, sug-
Kaplan, 1995), whereas Stress Recovery Theory highlights physiological gesting that restorative experiences unfold within complex and uneven
stress reduction and affective responses elicited by non-threatening environmental contexts (Frank et al., 2019, Tu et al., 2026b).
natural environments (Ulrich, 1983; Ulrich et al., 1991). Despite these Existing research on walking-based restorativeness is paradoxically
different emphases, both theories converge on the assumption that na- constrained by overly broad conceptualizations of restorative environ-
ture exposure produces restorative benefits, which have been robustly ments. Many studies predominantly employ simplified environmental
supported by empirical evidence (Bratman et al., 2019, Markevych typologies (e.g., “green” vs. “urban”) to represent restorative contexts,
et al., 2017). While these frameworks primarily focus on environ- without further differentiation of environmental characteristics within
mental features, they also incorporate behavioral factors such as phys- these categories (Tu et al., 2026b). Such simplifications implicitly as-
ical activity, providing a foundation for nature-based interventions sume that environmental exposures along a given route remain spatially
(Hartig et al., 2014). Nevertheless, these frameworks are largely homogeneous. Although a few recent studies have begun to quantify
grounded in a simplified urban–nature dichotomy, which limits their fine-grained environmental exposures during walking—such as traffic
ability to account for the dynamic and heterogeneous exposure patterns noise (Schaupp et al., 2025), thermal conditions (Song et al., 2024), and
of real-world urban environments, leaving the underlying mechanisms visual attributes (Luo et al., 2024, Zhang et al., 2022)—such approaches
of restorative responses insufficiently explained. remain scarce within walking-based restorativeness research, particu-
Walking ranks among the most feasible physical activity modes, larly in simultaneous multi-dimensional assessment. In addition, many
characterized by simplicity, self-paced participation, and broad acces- prior studies rely predominantly on self-reported restorativeness,
sibility (Kelly et al., 2018; Morris and Hardman, 1997), and also serves although objective physiological indicators are increasingly emerging as
as a key pathway for environmental exposure in daily life. Consequently, complementary measures (Kabisch et al., 2021, Tu et al., 2026b). This
it is recognized as a low-cost and scalable public health intervention dichotomy precludes the quantitative characterization of concurrent
(World Health Organization, 2020). Walking interventions across environmental exposures during walking, leaving their effects on psy-
varying durations have demonstrated diverse health outcomes, chological and physiological responses, as well as underlying restorative
including reductions in stress, depressive symptoms, and cardiovascular processes insufficiently understood.
risk (Hanson and Jones, 2015, Kelly et al., 2018). During walking, While previous studies have provided valuable insights into indi-
exposure to urban greenery may generate different restorative responses vidual environmental factors in walking-based restorativeness, most
depending on environmental context and exposure duration (Hunter related studies have examined these factors in isolation as covariates or
et al., 2019; Tu et al., 2026b). Synthesized evidence consistently sup- moderators, leaving their joint influences and relative strengths on
ports the mental health benefits of nature-based walking, particularly restorative responses unclear. To date, only a few studies have consid-
for anxiety reduction and affective improvement (Chen et al., 2025, Tu ered multiple concurrent environmental stressors during walking, such
et al., 2026b). Walking in greener environments enables the dual benefit as thermal variables, noise, and air pollution, to examine their relative
of physical activity and nature exposure (Lee et al., 2024; Olafsdottir effects on restorative responses. However, these efforts have generally
et al., 2020), thereby producing cumulative health gains through required mobile sensing approaches to measure multi-exposure envi-
every step. ronments during walking. Among the limited studies, Lanki et al. (2017)
Walking inherently involves multi-domain, spatiotemporally dy- linked cardiovascular indicators with traffic-related stressors (i.e., noise
namic environmental exposures along its routes, rather than a simplified and particulate matter), and Tu et al. (2026a)demonstrated that adverse
urban–nature dichotomy or steady-state environmental contact. These thermal and air pollution exposures modified restorative responses.
exposures are typically understood as spanning multiple sensory and Existing evidence remains largely fragmented, as co-occurring
environmental domains, including visual, thermal, acoustic, and air environmental exposures have yet to be analyzed within an integrated
quality dimensions (Tu et al., 2026b). Built environment characteristics framework (Li et al., 2026). At the same time, emerging but limited
and visual elements—such as urban landscapes, greenery, and street- evidence suggests joint and context-dependent effects on restorative
scape features—have been associated with restorative outcomes, with responses. For example, a recent study on static restorative environ-
effects differing across specific attributes (Celikors and Wells, 2022; Luo ments showed that neural responses are enhanced by greenery com-
et al., 2024; Mahia et al., 2025b; Xiang et al., 2021). Beyond visual bined with multisensory stimuli—such as soundscapes and volatile
factors, thermal conditions further modulate restorative responses organic compounds—through synergistic effects (Li et al., 2026). Simi-
(Dong et al., 2025; Tu et al., 2026a), and certain acoustic conditions may larly, in nature-based walking studies, Song et al. (2024) found that
facilitate restorativeness (Jeon et al., 2021), whereas traffic-related environmental context significantly modulated thermal perception
noise and air pollutants tend to attenuate these benefits (Dzhambov under equivalent exposure conditions. Schaupp et al. (2025)examined
et al., 2018; Schaupp et al., 2025). This suggests that restorative re- the interaction between environmental context and traffic noise in
sponses during walking are not driven solely by natural elements, but relation to restorative responses, but observed no significant effect.
emerge from multi-sensory environmental exposures encountered along Broadly, empirical evidence on interactions among environmental ex-
walking routes (Frank et al., 2019; Wang et al., 2016). posures and context remains scarce.
Exposure to walking environments is spatiotemporally heteroge- Overall, key limitations of existing research include: (1) the meth-
neous across diverse built environments and multiple scales, while being odological reliance on simplified environmental categorizations and
further driven by dynamic and self-determined walking behaviors with homogeneous exposure assumptions, (2) the predominant focus on
variable timing. For example, at the urban scale, larger cities (>100 single environmental factors with limited consideration of their in-
km2) exhibit stronger heat island effects and higher thermal stress than teractions and context-dependent effects, and (3) the dependence on
smaller towns (<10 km2) (Chen et al., 2026b), while at the neighbor- subjective measures. As a result, integrated, multi-factor, real-time
hood level, heat vulnerability varies substantially (Chen et al., 2026a). characterization of heterogeneous environmental exposures during
At the pedestrian scale, buildings and street trees shape sunlight and walking, as well as their combined and context-dependent effects on
shade distribution, modifying solar radiation and thermal perception both physiological and perceptual restorative responses, remains lack-
(Lai et al., 2023; Zhao et al., 2026), thereby elevating pedestrians' local ing. Additionally, a previous literature review indicates that global
skin temperature and stress levels (Mahia et al., 2025a). Similarly, studies on walking-based restorativeness have been predominantly
variations in built environment, traffic intensity, and individual walking conducted in temperate regions, while evidence from subtropical and
behavior generate heterogeneous traffic-related air pollutant exposures tropical urban contexts remains relatively limited (Tu et al., 2026b).
(Armengol et al., 2024; Dhondt et al., 2012). Collectively, such layered Guangzhou, as a megacity with a population exceeding ten million, is
variations highlight the spatiotemporal heterogeneity of walking- characterized by high-density built environments, serving as a
2

R. Tu et al. E n v i r o n m e n t a l I m p a c t A s s e s s m e n t R e v i e w 122 (2027) 108642
representative subtropical urban context. 2. Methods
Building on the identified research gaps, this study goes beyond
merely confirming the restorative benefits of nature-based walking 2.1. Experimental design
compared with dense-urban environments. Instead, it adopts a multi-
factor environmental exposure framework integrating simultaneous 2.1.1. Experimental settings
physiological and perceptual measurements to examine relationships The experiment was conducted in Guangzhou, China, which has a
between environmental exposures and short-term restorative responses warm temperate with dry winter and hot summer (Cwa) climate under
during walking. Accordingly, two research questions are proposed: the Ko¨ppen–Geiger climate classification system (Peel et al., 2007). To
(1) Within a single walking session, how do multiple concurrently examine exposure–response relationships within conventional restor-
occurring physical environmental exposures—such as air quality, ative environment categorizations, two walking routes with contrasting
acoustic conditions, and microclimatic characteristics—relate to short- environmental characteristics were selected. Both routes were located
term restorative responses? How do their effects differ in direction within 2 km of each other in Guangzhou's central Tianhe District,
and magnitude? providing a comparable urban background.
(2) Within conventional restorative environment categorizations (e. The green-urban route, located on the campus of South China Uni-
g., green-urban versus dense-urban in this study), do the exposure- versity of Technology, featured abundant vegetation, with half of the
response relationships between physical environmental exposures and route along a lake (Fig. 1a), representing a walking environment with
short-term restorative responses remain consistent across environmental comprehensive natural elements. In contrast, the dense-urban route near
contexts, or do they exhibit potentially interactive, context-dependent Tianhebei Road traversed a high-density residential area and was
differences? flanked by roadways. One half of the route was adjacent to a primary
To address these questions, a randomized crossover experiment was arterial road, and the other half to a secondary arterial road (Fig. 1b),
conducted across two different walking environments in two seasons. representing a typical traffic-influenced urban walking environment.
Multiple environmental exposure data were simultaneously collected The experiment was conducted on rain-free days during two separate
using a wearable mobile sensing platform and temporally aligned with periods, thereby encompassing a wider range of environmental condi-
restorative measures during walking. This integrated design enables tions: from December 13 to December 29, 2024 (winter session), and
synchronous assessment of co-occurring exposure-response relation- from April 14 to June 4, 2025 (summer session). Experiments were
ships within a single walking session under a unified research rescheduled in case of rainfall to ensure consistent outdoor conditions.
framework. Differences in seasonal study duration were primarily driven by weather
constraints and participant availability under field conditions. All trials
were conducted within fixed daytime windows (9:30–11:00 and
14:30–16:30) under relatively moderate solar radiation to avoid exces-
sive thermal stress on participants. These designs accommodated
Fig. 1. a. Route map of the green-urban walking route; b. route map of the dense-urban walking route; c. representative segment of the green-urban route showing
blue-space features; d. representative segment of the green-urban route without blue-space features; e. experimental procedure illustrating participants walking with
a guide while physical environment measurements were recorded; f. representative segment of the dense-urban route adjacent to a secondary arterial road; g.
representative segment of the dense-urban route adjacent to a primary arterial road. (For interpretation of the references to colour in this figure legend, the reader is
referred to the web version of this article.)
3

R. Tu et al. E n v i r o n m e n t a l I m p a c t A s s e s s m e n t R e v i e w 122 (2027) 108642
naturally occurring environmental variation while preserving compa- Table 1
rability across repeated measurements within the same environmental Participant demographic characteristics (n =37).
contexts in a field-based setting. Variable Mean (SD) Variable N (%)
Age 24.2 (1.9) Gender (% female) 51.4%
2.1.2. Study population
BMI (females) 19.3(2.4) Alcohol use: Non-abuser (%) 100%
The experiment employed a convenience sampling strategy, BMI (males) 23.0(2.3) Smoking status: Non-smoker (%) 94.6%
recruiting participants through university advertisements and online Main living environment in the past 3 years (%)
recruitment. Eligible participants were healthy young adults aged Suburban 8.1% Low-density urban 48.6%
18–35 years who were free from serious physical or mental health issues Medium-density urban 29.7% High-density urban 13.5%
and capable of sustaining continuous walking for at least 30 min. Note: BMI indicates Body Mass Index.
Considering the proximity of the walking routes to the university
campus, university-based participants were selected to ensure feasibility 2.1.3. Experimental protocol
and facilitate protocol adherence during repeated field sessions, while In this crossover trial, participants completed both the green-urban
also reducing inter-individual variability in physiological and percep- and dense-urban walking routes once in each of the two seasons. For
tual responses during walking to improve the stability of exposur- the first session (winter), they were randomly assigned to start with one
e–response estimation. The study protocol was approved by the Ethics route, walking 2.0 km at a self-selected pace with guidance, before
Committee of the Second Affiliated Hospital of South China University completing the other route at least one week later (Fig. 2). The second
of Technology (approval number: K-2023-056-01), and complied with session (summer) followed the same protocol. Allocation sequence and
the ethical standards for human research. All participants provided walking direction (clockwise or counterclockwise) were randomized to
written informed consent and received monetary compensation after balance potential order effects across repeated measurements and
each session. identical route-direction combinations. A one-week interval between
A total of 37 participants (19 females, 18 males), mainly graduate routes, commonly adopted as a washout period in crossover studies,
students from universities in Guangzhou, were recruited. Baseline together with the seasonal interval between sessions, was intended to
health status and physical activity levels were assessed via self-reported reduce potential carryover and familiarity effects. No more than two
questionnaires prior to recruitment. Given prior evidence linking urban participants were arranged to walk together. Prior to each walking
land density to mental health (Sui et al., 2022; Xu et al., 2023), partic- session, participants were reminded by the experimenter to avoid non-
ipants' residential neighborhood density (PRND; past 3 years) was self- essential conversation and were briefly informed about the procedures.
reported and included as a covariate. All participants met the pre- The 2.0 km walking distance was based on previous review sug-
defined inclusion criteria and were free from physical or mental health gesting that nature-based walking exposures of approximately 1.5–2.5
conditions. Individuals with professional athletic training were excluded km are associated with relatively effective psychological benefits (Tu
to reduce potential bias in physiological responses. The sample was et al., 2026b), while restorative outcomes in young adults have been
characterized by generally low levels of smoking and no reported reported to peak around a 2.0 km exposure distance (Tu et al., 2026a).
alcohol abuse. Participants were instructed to abstain from alcohol and The intermediate observation points at 1.0 km (resting points in Fig. 1),
caffeinated beverages before each session. One participant withdrew corresponding to the predefined boundary between environmentally
during the summer session, while the remaining participants completed heterogeneous route segments, were incorporated to assess restorative
all four walking interventions (Fig. 2). Detailed demographics are pro- responses contrasts across walking environments. The walking pace was
vided in Table 1. self-selected without control to preserve ecological validity and reflect
real-world walking conditions. Walking time was recorded, with a mean
pace of 14.151 ±1.191 min per km in this study.
The procedure followed a pretest-posttest design identical across
environments (Fig. 3). Upon arrival, participants entered a resting stage
(T1), during which physiological devices were attached and baseline
health (SF-12) and subjective measures were collected. This was fol-
lowed by a stress induction stage (T2), in which participants completed
two 5-min tasks, including reading and Sudoku. The two tasks involved
different cognitive processes with moderate difficulty, and task versions
varied across sessions. This stage was designed to induce mild cognitive
load prior to walking, following established protocols in restoration
research (Stevenson et al., 2018). The second round of subjective mea-
sures was administered immediately afterward (T3).
Participants then began the walking intervention. During the first
half (T4), they walked 1.0 km along the assigned route. This was fol-
lowed by an intermediate transition stage (T5), consisting of a 5-min
break for restorative response assessment, including the third round of
subjective measures and brief hydration, before the second walking
segment. During the second half (T6), participants completed the
remaining 1.0 km. Physiological and environmental data were contin-
uously recorded during T4 and T6, and subjective satisfaction ratings
were collected at designated points. The post-walk stage (T7) included
the final subjective measures and removal of all monitoring devices. The
rest and transition stages (T1 and T5) were conducted at designated
shaded locations along each walking route, where participants remained
stationary.
Fig. 2. Study design of the trial.
4

R. Tu et al. E n v i r o n m e n t a l I m p a c t A s s e s s m e n t R e v i e w 122 (2027) 108642
Fig. 3. Experimental procedure. (Note: Subjective questionnaires administered at T3, T5, and T7 were analyzed as T2-, T4-, and T6-stage responses, respectively, to
align with the corresponding environmental and physiological measurements.)
2.2. Measurements shin—following the ISO 9886 standard. Mean skin temperature was
calculated as a weighted average of these four sites, with weighting
2.2.1. Subjective measurements coefficients of 0.28 each for the neck, scapula, and shin, and 0.16 for the
Subjective restorative responses were repeatedly assessed across four hand (summing to 1.00) (International Organization for
stages during each walking intervention: the resting stage (T1), post- Standardization, 2004).
stress induction (T2), after the first half of walking (T4), and after the Electrodermal activity, commonly indexed by skin conductance to
second half of walking (T6). Although the analytic subjective measures assess emotional changes and sympathetic arousal (Kreibig, 2010;
were administered at T3, T5, and T7, they assessed responses to the Veeranki et al., 2026), consists of a tonic component—skin conductance
immediately preceding primary analytical stages and were therefore level (SCL)—and a phasic component—skin conductance responses
labeled as T2-, T4-, and T6-stage measures to align with the corre- (SCRs) (Greco et al., 2016). Owing to their established validity and
sponding environmental and physiological data. Perceived restorative- reliability, previous walking-related restorativeness studies have widely
ness was measured using the Perceived Restorativeness Scale (PRS; 22 employed both SCL and SCR (Luo et al., 2024, Tu et al., 2026a, Zhang
items, 7-point Likert scale) (Hartig et al., 1997). Affective dimensions et al., 2022). Skin conductance was recorded using a wearable elec-
were measured using the Positive and Negative Affect Schedule (PANAS; trode system (Shimmer 3 GSR+, Shimmer) to derive EDA measures
20 items, 5-point Likert scale) (Watson et al., 1988). To minimize during walking. Following clinical validation, the device was shown to
participant burden associated with repeated assessments, only these two highly accurate measurements (Gatti et al., 2018). Electrodes were
primary instruments were administered across the walking stages (42 placed on participants' wrists, and data were recorded at 51.2 Hz.
items in total, approximately 2 min). In addition, baseline general health
status was assessed once at resting stage (T1) using the 12-Item Short 2.2.3. Physical environmental measurements
Form Survey (SF-12) (Ware et al., 1996). Physical environmental indicators during walking were measured
During walking, perceived environmental quality—including ther- using the same backpack-mounted monitoring system as in our previous
mal, visual, and acoustic satisfaction—was assessed at fixed locations experiments (Tu et al., 2026a). This system recorded radiation, wind
along the routes (5-point Likert scale). Assessments were collected at velocity (V), air temperature (Ta), relative humidity (Rh), sound levels,
approximately 100 m intervals (19 assessment points per route), with and air pollutants. The integrated system included multiple sensors and
locations generally aligned with pedestrian crossings or route land- instruments, with detailed specifications, measurement ranges, and ac-
marks. At each location, participants briefly paused under experimenter curacy provided in Appendix A, Table A.1. All sensors were operated
guidance to complete the assessment ratings, which typically required and calibrated according to manufacturer specifications. The same de-
approximately 10 s. vices were used across sessions, and device synchronization and func-
tionality were checked prior to each experimental session.
2.2.2. Physiological measurements During the walking stages, the backpack was carried by an experi-
Physiological responses included skin temperature (Tsk) and elec- menter, who followed the participant at a distance of 2–3 m to minimize
trodermal activity (EDA), continuously recording from participants' visual interference (Fig. 1e). Shortwave and longwave radiation were
arrival until the completion of the entire experiment. Skin temperature recorded at 10-s intervals to calculate mean radiant temperature (Tmrt,
was recorded with iButton temperature loggers (DS1922L, Maxim In- ◦C). These parameters, together with synchronously measured Ta, Rh,
tegrated), sampled at 30-s intervals. The loggers were attached to four and V (sampled every 10 s), were used to compute the Universal Ther-
body locations—neck, right scapula, left hand, and right mal Climate Index (UTCI), a widely adopted comprehensive indicator of
5

R. Tu et al. E n v i r o n m e n t a l I m p a c t A s s e s s m e n t R e v i e w 122 (2027) 108642
human thermal comfort (Jendritzky et al., 2012). During walking, air Benjamini–Hochberg false discovery rate procedure (α =0.05), which is
pollutants—including PM2.5, NO2, and O3 —were continuously moni- suitable for numerous correlated comparisons (Benjamini and
tored (sampled every 60 s), and the equivalent continuous sound pres- Hochberg, 1995).
sure level (Leq) was recorded by a handheld sound level meter. (2) Partial Least Squares Structural Equation Modeling (PLS-SEM)
was utilized as an exploratory analytical framework to disentangle the
2.3. Statistical analysis intervention-based pathways of restorative change. To evaluate multi-
exposure restorative dynamics, PLS-SEM enables the simultaneous
2.3.1. Electrodermal activity signal analysis assessment of effect direction and magnitude within a unified multi-
Ledalab was used to analyze the calibrated skin conductance signal, variate analytical framework, as well as the identification of key
which reflected electrodermal activity (Benedek and Kaernbach, 2010). exposure-response pathways and interaction-relevant structures for
Following Ledalab recommended preprocessing procedures and the further analysis. (3) Linear mixed-effects models (LMMs) were then
suggestions of Greco et al. (2016), a first-order low-pass Butterworth applied to cross-validate the exposure-response pathways identified in
filter with a 5 Hz cutoff was applied to reduce high-frequency noise and PLS-SEM, and to further examine interaction effects between walking
motion-related artifacts prior to signal decomposition. The data were environment type and environmental indicators on restorative responses
downsampled to 32 Hz to limit signal fluctuations, smooth the overall (i.e., T4 and T6), using the “lme4” package (Bates et al., 2015).
waveform, and reduce computational load while preserving relevant As a subclass of structural equation modeling (SEM), PLS-SEM uses
electrodermal activity signal characteristics, following the example ordinary least squares regression to maximize the explained variance of
preprocessing settings provided in Ledalab. Continuous deconvolution target endogenous latent variables (Hair et al., 2019). Rather than
analysis allowed the decomposition of the signal into tonic (mean SCL) validating predefined theoretical models, it is particularly suited to
and phasic components (mean SCR amplitude and SCR counts) (Greco exploring and identifying underlying variable structures within complex
et al., 2016). In addition, SCR rate was defined as the average number field-based systems. In the present study, PLS-SEM was applied to
of significant SCRs per minute, which reflected stimulus-evoked activity. disentangle the multivariate relationships among environmental expo-
Across the two experimental sessions, one participant dropped out of sures and multilevel restorative responses within real-world walking
the summer session (146 completed observations). During EDA signal contexts, reflecting the assumption of multi-factor environmental ef-
quality and stability assessment, one participant exhibited extreme fects. Methodologically, the method demonstrates robustness under
outliers and substantial signal instability across sessions; therefore, these conditions of non-normality and limited sample sizes, under which it can
EDA observations were invalidated and treated as invalid. Additionally, provide stable parameter estimates and valid significance testing (Hair
skin conductance signals from three other participants were not suc- et al., 2012). Although frequently used in secondary data, PLS-SEM is
cessfully recorded for one walking intervention each due to experi- also applicable to controlled experimental and intervention-based de-
mental issues. In total, seven EDA observations were considered missing signs (Singleton et al., 2023).
in subsequent analyses.
2.3.4. Statistical power
2.3.2. Universal thermal climate index calculation The minimum sample size for the within-subject (paired) design was
Mean radiant temperature (Tmrt, ◦C) was calculated using measured calculated using G*Power 3.1 (Faul et al., 2009). Assuming a medium
longwave (Li) and shortwave (Ki) radiation flux densities in six di- effect size (Cohen's d =0.50), α =0.05, and power =0.85, the calcu-
rections (upward, downward, front, back, left, and right). As shown in lation indicated that 32 participants were required. A total of 37 par-
Eq. (1), angular weighting factors (Wi =0.06 for upward and downward ticipants were recruited, with one withdrawal. For PLS-SEM, the inverse
sensors; 0.22 for front, back, left, and right sensors) and absorption square root method was applied (Hair Jr et al., 2021; Kock and Hadaya,
coefficients (αl =0.97 for longwave radiation and αk =0.70 for short- 2018), and path significance was assessed via bootstrapping with 10,000
wave radiation) were applied to compute Tmrt for an upright reference resamples. Assuming α =0.05 and a minimum path coefficient of 0.25,
pedestrian (Ho¨ppe, 1992). the estimated minimum sample size was 99.
A logarithmic wind profile was applied to convert the wind velocity Each completed experimental session was treated as an independent
measured at the sensor height (1.9 m) to the standard height of 10 m observation, yielding 146 observations for analysis. All questionnaire
(V10), as required for the UTCI calculation. In this conversion, Z =1.9 m and environmental variables were complete, whereas seven EDA ob-
represented the height of the wind velocity sensor, ZR = 10 m repre- servations were identified as missing or invalid. Missing EDA values
sented the reference height, and Z0 =0.01 m represented the roughness were imputed using the mean values of the corresponding experimental
length, as detailed in Eq. (2)(Havenith et al., 2012). condition prior to subsequent analyses. Analyses requiring complete
√ √ ̅[̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅]̅̅ / ̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅̅ paired data were conducted using 144 paired observations due to the
Tmrt = √ √4 ∑
i=
6
1
wi (aiKi +aiLI ) (ai σ) (cid:0) 273.15K(◦ C) (1) w ob it s h er d v r a a t w io a n l s o . f one participant, whereas other analyses retained all 146
V10m =V1.9m ×log(Z∕Z0 )×log(ZR ∕Z0 )(cid:0)1 (2) 2.3.
I
5
n
.
th
P
e
L S
P
-
L
S
S
E
-
M
SE
s
M
pe
,
c
p
ifi
h
c
y
a
s
t
i
i
c
o
a
n
l
a
e
n
n
d
v i
m
ro
o
n
d
m
el
e
v
n
a
t
l
a
id
l
a
v
t
a
io
ri
n
ables were modeled as
UTCI values were derived from Tmrt along with corresponding Ta, exogenous single-indicator constructs, whereas subjective and physio-
Rh, and V10 using the pythermalcomfort Python package (Tartarini and logical responses were specified as endogenous reflective latent con-
Schiavon, 2020). structs. Analyses were based on within-walk T6–T4 pairwise difference
values, with physical environmental exposures and restorative response
2.3.3. Analytical methods variables represented as between-segment contrasts within each
Data analysis was conducted in RStudio (R Core Team, 2025) and walking session to ensure observation independence and isolate
SmartPLS 4 (Ringle et al., 2024). (1) Stage-level differences (T1–T6) intervention-related effects. Given the moderate correlation between O3
within each experiment were assessed using the Wilcoxon signed-rank and NO2 (Spearman's ρ = 0.526, p < 0.001), only one representative
test for paired samples, separately for season and walking environ- gaseous pollutant indicator of was retained in the primary model to
ment comparisons. The approach provides robust, distribution-free maintain model parsimony. To better reflect the acute walking exposure
inference for ordinal and non-Gaussian data in field-based settings investigated in this study, O3 was retained in the primary PLS-SEM
(Hollander et al., 2013). To control for false positives from multiple model, consistent with the shorter averaging exposure time commonly
comparisons, p-values were additionally adjusted using the adopted for O3 than for NO2 in current epidemiological evidence
6

R. Tu et al.                                                                                                                                                                             E  n  v i r o  n  m   e n  t a  l   I m  p  a  c t   A   s s e  s s m   e n  t   R  e  v i e  w  122 (2027) 108642
| (Orellano et al., 2020; World Health Organization, 2021). In addition,  |     |     |     | Table 2  |     |     |     |     |
| ----------------------------------------------------------------------- | --- | --- | --- | -------- | --- | --- | --- | --- |
sensitivity analyses using NO2 in place of O3 were conducted to assess  Summary of physical environmental measures and subjective satisfaction during
the robustness of the results (Appendix Table C.4). walking across experiment sessions (T4 +T6).
The structural model included three reflective latent constructs, each  Variable  Winter Summer
Mean (±SD)
measured by two indicators: Positive Subjective Outcomes (PRS and
|     |     |     |     |     | Green-urban | Dense-urban | Green-urban | Dense-urban |
| --- | --- | --- | --- | --- | ----------- | ----------- | ----------- | ----------- |
PANAS-Positive), Electrodermal Arousal (SCL and SCR amplitude), and
Physical Environmental Measures
| Perceived Environmental Quality (environmental satisfaction rating).  |     |     |     | UTCI (◦C) |          |          |          |          |
| --------------------------------------------------------------------- | --- | --- | --- | --------- | -------- | -------- | -------- | -------- |
|                                                                       |     |     |     |           | 13.660 ± | 15.189 ± | 28.281 ± | 30.896 ± |
Conceptually independent outcomes (Thermal Satisfaction, SCR rate,
|     |     |     |     |     | 2.817 | 2.429 | 2.478 | 3.010 |
| --- | --- | --- | --- | --- | ----- | ----- | ----- | ----- |
and PANAS-Negative) were modeled as single-indicator reflective con- Ta(◦C) 17.020 ± 18.177 ± 27.538 ± 29.668 ±
structs. Skin Temperature, Thermal Satisfaction, and Perceived Envi- 2.243 2.183 2.525 2.290
|                     |                  |                 |               |        | 38.007 ± | 42.466 ± | 58.036 ± | 62.657 ± |
| ------------------- | ---------------- | --------------- | ------------- | ------ | -------- | -------- | -------- | -------- |
| ronmental  Quality  | were  specified  | as  endogenous  | intermediary  | Rh (%) |          |          |          |          |
constructs linking physical environmental exposures to restorative re- 10.322 9.583 15.185 11.671
|     |     |     |     | V (m/s) | 1.416 ± | 1.179 ± | 1.218 ±0.  | 1.086 ± |
| --- | --- | --- | --- | ------- | ------- | ------- | ---------- | ------- |
sponses. Individual-level covariates (age, BMI, gender, and PRND) were
|     |     |     |     |     | 0.241 | 0.136 | 173 | 0.136 |
| --- | --- | --- | --- | --- | ----- | ----- | --- | ----- |
included as single-indicator exogenous control variables with direct  57.459 ± 65.936 ± 59.328 ± 67.108 ±
Leq (dBA)
|     |     |     |     |     | 1.311 | 1.086 | 1.164 | 1.133 |
| --- | --- | --- | --- | --- | ----- | ----- | ----- | ----- |
paths to endogenous constructs.
|                                                                     |     |     |     | PM2.5 (mg/  | 0.001 ± | 0.003 ± | 0.001 ± | 0.000 ± |
| ------------------------------------------------------------------- | --- | --- | --- | ----------- | ------- | ------- | ------- | ------- |
| Confirmatory assessments were performed for multi-indicator latent  |     |     |     | m3)         |         |         |         |         |
|                                                                     |     |     |     |             | 0.001   | 0.001   | 0.001   | 0.001   |
variables to evaluate measurement model quality, including outer  O₃ (ppm) 0.053 ± 0.067 ± 0.082 ± 0.076 ±
loadings, composite reliability (CR), average variance extracted (AVE), and  0.008 0.007 0.016 0.017
the heterotrait-monotrait ratio (HTMT). These metrics were not applicable  Perceived Environmental Satisfaction Rating
|                                                                         |     |     |     |             | 3.684 ± | 3.116 ± | 3.571 ± | 3.088 ± |
| ----------------------------------------------------------------------- | --- | --- | --- | ----------- | ------- | ------- | ------- | ------- |
| to formative indicators, which were all single-indicator formative con- |     |     |     | Visual Sat. |         |         |         |         |
|                                                                         |     |     |     |             | 0.367   | 0.417   | 0.495   | 0.365   |
structs in this study.
|     |     |     |     | Acoustic Sat. | 3.342 ± | 2.764 ± | 3.251 ± | 2.709 ± |
| --- | --- | --- | --- | ------------- | ------- | ------- | ------- | ------- |
|     |     |     |     |               | 0.397   | 0.402   | 0.505   | 0.429   |
2.3.6. LMM specification and model evaluation Thermal Sat. 4.023 ± 4.232 ± 3.581 ± 3.570 ±
Given that the PLS-SEM examined the effects of between-segment  0.749 0.706 0.706 0.886
environmental contrasts during walking (T6–T4), which may compress
variation in absolute exposure levels, LMMs were further used to cross-  Within-condition stage differences (|T6 (cid:0) T4|) are reported in Appendix
validate significant pathways identified in the PLS-SEM. Stage-level
A, Table A.2. Further, Table 3presents descriptive statistics for restor-
repeated observations during walking (T4 and T6) were used in the  responses—including
|     |     |     |     | ative  |     | subjective  | and  | physiological  |
| --- | --- | --- | --- | ------ | --- | ----------- | ---- | -------------- |
LMMs,  with  restorative  responses  calculated  as  baseline-corrected  measures—across the walking interventions (T4 and T6), and 95%
changes relative to T2 (i.e., T4–T2 and T6–T2) to isolate within-
confidence intervals were provided in Appendix A, Table A.3.
person restorative changes during walking. In the LMMs, participant
The SF-12 questionnaire was administered once at T1 in each
identity was specified as a random intercept to control for repeated
experimental session to assess baseline health status. No significant
measurements. Environment type (green-urban vs. dense-urban) was
|     |     |     |     | differences  | were  observed  | between  | sessions  (all  | p-values  = |
| --- | --- | --- | --- | ------------ | --------------- | -------- | --------------- | ----------- |
treated as a fixed factor. Individual-level covariates and cumulative
0.269–0.967), indicating stable physical and psychological health con-
| walking  duration  | were  included  | as  control  variables.  | Restorative  |     |     |     |     |     |
| ------------------ | --------------- | ------------------------ | ------------ | --- | --- | --- | --- | --- |
ditions throughout the study period. The five PANAS items with the
response variables were subjected to inverse normal transformation
highest mean scores for each affective dimension (Positive and Negative
followed by z-score standardization prior to model estimation to satisfy  Affect, 10 items respectively) were then presented within each condition
| distributional assumptions regarding random effects  |     |     | and residuals  |     |     |     |     |     |
| ---------------------------------------------------- | --- | --- | -------------- | --- | --- | --- | --- | --- |
and stage, arranged according to the circumplex model of affect pro-
(Laird and Ware, 1982).
posed by Russell (1980), with spatial positions based on Schaupp et al.
Consistent with the study objective of identifying the physical  (2025)(Fig. 5a–h); detailed statistics are in Appendix A. A Tables A.4
environmental factors underlying restorative responses, season was not
and A.5.
included as a primary covariate in the main models. This was primarily
because season is inherently associated with multiple physical envi-
ronmental exposures, and adjustment for season could potentially alter  3.2. Results of the Wilcoxon signed-rank tests
the interpretation of their independent effects. Therefore, season-
adjusted models were used as sensitivity analyses to evaluate the
3.2.1. Subjective measures
robustness of the findings (Appendix C). Diagnostic residual and Q–Q
PRS: No significant changes were observed during stress induction
(T2) across seasons or environments (all p >0.05). After walking, green-
plots are provided in Appendix D. VIF diagnostics indicated low multi-
collinearity among predictors in both the PLS-SEM and LMM models  urban routes showed significant PRS increases relative to baseline
(maximum VIF =4.337).
(T6–T2) in both winter and summer (p <0.001; p =0.039), whereas no
For each dependent variable, a stepwise modeling strategy was  effects were detected at midpoint (T4–T2; all p >0.05). In dense-urban
applied, including: (1) a baseline model with environment type, walking  settings, winter walking produced significant improvements at both T4
duration, and individual-level covariates; (2) models adding predictors  and T6 (both p <0.001). Summer dense-urban walking showed a sig-
identified as significant or near-significant in the PLS-SEM; (3) a com- nificant increase only at midpoint (T4–T2: p =0.007), with no end-stage
bined main-effects model; and (4) a full interaction model testing pre- effect (T6–T2: p =0.072). Across seasons, PRS was consistently higher in
defined Dense-urban walking × Predictor terms, as well as identified  green-urban than dense-urban environments at both T4 and T6 (all p ≤
interactions among physical environmental indicators. Model perfor-
0.008) (Fig. 4a).
mance was evaluated using Akaike Information Criterion (AIC) and  PANAS-Positive:  During  stress  induction  (T2),  positive  affect
marginal R2 to assess improvements in explanatory power.
decreased significantly in all conditions except summer green-urban
walking (p =
0.609). After walking onset, only winter dense-urban
3. Results walking showed a significant increase at midpoint (T4–T2: p =0.037),
whereas other conditions exhibited no significant changes (all p >0.05).
3.1. Descriptive statistics At T6, positive affect was highest under winter green-urban walking and
was significantly higher than both winter and summer dense-urban
Descriptive statistics for physical environmental variables and sub- conditions (p =0.005; p <0.001) (Fig. 4b).
jective satisfaction during walking (T4 and T6) are presented in Table 2.  At the item level, Interested consistently ranked among the top
7

R. Tu et al. E n v i r o n m e n t a l I m p a c t A s s e s s m e n t R e v i e w 122 (2027) 108642
Table 3
Physiological and subjective measures across experimental stages.
Variable Winter Summer
Mean (±SD)
Green-urban Dense-urban Green-urban Dense-urban
T4 (1 km) T6 (2 km) T4 (1 km) T6 (2 km) T4 (1 km) T6 (2 km) T4 (1 km) T6 (2 km)
PRS 4.756 ±0.794 4.997 ±0.806 4.228 ±1.148 3.841 ±1.066 4.587 ±0.835 4.722 ±0.856 4.058 ±0.969 3.885 ±0.889
30.028 ± 31.278 ± 28.639 ± 28.444 ± 28.500 ± 29.028 ± 27.667 ± 27.694 ±
PANAS-Positive
5.398 5.952 6.567 6.500 6.423 7.263 6.254 7.110
15.750 ± 14.583 ± 15.611 ± 15.528 ± 15.306 ± 14.889 ± 16.000 ± 15.778 ±
PANAS-Negative
6.207 6.282 6.460 6.287 4.818 5.049 5.442 5.740
Mean SCL (μS) ± 4 3 .3 .1 3 6 4 0 5.668 ±3.766 3.235 ±2.359 4.575 ±3.101 2.739 ±1.924 4.124 ±2.584 2.602 ±2.375 3.912 ±3.252
Mean SCR ( μ a S m ) plitude 0.497 ±0.540 0.594 ±0.638 0.634 ±0.655 0.601 ±0.555 0.365 ±0.260 0.514 ±0.382 0.390 ±0.419 0.483 ±0.433
13.921 ± 13.704 ± 14.011 ± 13.902 ± 14.777 ± 14.737 ± 14.685 ± 15.374 ±
SCR rate
1.744 2.268 2.303 1.949 2.337 1.946 1.892 1.528
Tsk (◦C) 30.817 ± 30.901 ± 31.380 ± 31.430 ± 33.445 ± 33.669 ± 33.715 ± 33.661 ±
1.302 1.290 1.092 1.087 0.985 0.803 0.914 0.804
Baseline Status:
14.820 ± 14.201 ± 13.689 ± 13.553 ± 14.506 ± 14.534 ± 13.773 ± 14.163 ±
Cumulative Time (min)
1.461 0.889 0.939 0.412 1.257 1.099 1.092 1.392
SF-12(T1) 42.752 ±6.842 43.316 ±7.616 44.444 ±7.240 43.446 ±7.618
Note: T4 =first half of the walking stage (1 km); T6 =second half of the walking stage (remaining 1 km). PRS range: 1–7; PANAS range: 10–50; SF-12 range: 0–100.
Fig. 4. Boxplots of stage-level restorative responses of subjective measures with Wilcoxon test results across experiments and stages: a. Perceived Restorativeness
Scale; b. PANAS (Positive and Negative Affect Schedule)-Positive; c. PANAS-Negative. (Note: Thin curved lines outside the boxplots indicate statistically significant
pairwise differences between stages within the same experiment. Thick gradient-colored arcs within the central circle indicate statistically significant differences
between experiments at the same stage. Connected groups indicate significant pairwise comparisons, whereas the absence of connecting arcs indicates non-significant
between-group comparisons. Significance levels are denoted as p <0.05: *, p <0.01: **, p <0.001: ***.)
positions across stages, with Active and Strong more frequently items (e.g., Excited, Attentive) generally stayed within the top five across
advancing into leading ranks from T2 to T6 (Fig. 5a–h). The remaining conditions. The only exception was winter green-urban walking, where
8

R. Tu et al. E n v i r o n m e n t a l I m p a c t A s s e s s m e n t R e v i e w 122 (2027) 108642
Fig. 5. Distribution of the top-rated PANAS items before and after the walking stage in the circumplex model of affect: a. Winter Green-urban (T2); b. Winter Green-
urban (T6); c. Winter Dense-urban (T2); d. Winter Dense-urban (T6); e. Summer Green-urban (T2); f. Summer Green-urban (T6); g. Summer Dense-urban (T2); h.
Summer Dense-urban (T6). T2 represents the baseline stress induction stage and T6 the post-walking stage. From the 20 PANAS items (10 Positive Affect and 10
Negative Affect items), the five items with the highest mean scores were selected separately for each affective dimension within each condition and stage. Items are
arranged following circumplex model of affect proposed by Russell (1980). Spatial positioning of PANAS items is based on Schaupp et al. (2025). Values represent
mean ratings on a 5-point Likert scale (1–5). Green =Positive Affect; orange =Negative Affect; darker shades indicate higher mean scores. (For interpretation of the
references to colour in this figure legend, the reader is referred to the web version of this article.)
high-arousal, moderately pleasant items—including Excited, Enthusi- indicating a stable composition of negative affect before and after
astic, and Active—showed a noticeable increase (Fig. 5b). Collectively, walking (Fig. 5a–h). The low-arousal, highly unpleasant item Distressed
green-urban walking showed observable but non-significant improve- was particularly salient following dense-urban walking in both seasons
ments in positive affect, with a stable configuration of core items. (Fig. 5d & h). In contrast, high-arousal negative items—such as Nervous
PANAS-Negative: No significant changes were observed during stress and Jittery—as well as moderately unpleasant items including Upset and
induction (T2), and no baseline differences were detected between Ashamed, showed notable reductions after walking. Overall, walking
conditions (all p > 0.05). Walking was associated with significant re- exerted a robust and consistent effect in reducing negative affect
ductions in negative affect at both T4 and T6 across all environments regardless of condition, particularly among high-arousal items (Fig. 4c).
and seasons (all p < 0.05). Between-condition comparisons further
showed lower negative affect after winter green-urban walking (T6) 3.2.2. Physiological measures
compared with summer dense-urban walking (p =0.048). SCL: Significant stage-to-stage increases were observed across all
At the item level, Distressed, Upset, and Nervous consistently ranked stages and conditions (all p <0.001). At baseline (T2), SCL was highest
highest at T2 and remained prominent at T6 across all trial conditions, in the winter green-urban condition compared with all others (all p ≤
9

R. Tu et al. E n v i r o n m e n t a l I m p a c t A s s e s s m e n t R e v i e w 122 (2027) 108642
0.001). During walking, SCL in winter green-urban remained signifi- 3.2.3. Interpretation of Wilcoxon signed-rank tests
cantly higher than all other conditions at T4 (all p <0.001) and higher Taken together, green-urban walking generally produced more
than both winter and summer dense-urban conditions at T6 (p =0.020; favorable restorative responses, with winter green-urban walking
p =0.005). In summer, green-urban walking showed higher SCL than yielding the highest PRS and the lowest Negative affect at the end of the
dense-urban only at T4 (p =0.048), with no difference at T6 (Fig. 6a). walking stages (T6). Positive affect did not increase consistently across
SCR amplitude: SCR amplitude did not change significantly during conditions but remained relatively higher after winter green-urban
stress induction (T2–T1; all p > 0.100), but increased significantly walking. Notably, a greater presence of high-arousal, moderately
during walking across all conditions (T4–T2 and T6–T2; all p <0.001). pleasant items was observed under this condition.
At baseline (T2), the summer dense-urban condition showed signifi- For physiological measures, winter green-urban walking was char-
cantly lower SCR amplitude than all other conditions (all p < 0.05). acterized by higher tonic SCL and relatively lower phasic SCR activity at
During walking, only winter dense-urban walking exhibited higher SCR T6, accompanied by higher PRS and PANAS-Positive scores and lower
amplitude at T4 compared with both summer walking conditions (all p PANAS-Negative scores. These concurrent changes indicate elevated
< 0.05). No other between-condition differences were observed physiological arousal alongside improved perceived restorativeness and
(Fig. 6b). positive affect, and reduced negative affect. At the midpoint of winter
SCR Rate: Except for winter dense-urban walking (p =0.004), SCR dense-urban walking (T4), participants exhibited partial short-term
rate showed no significant change during stress induction (T2–T1; all p restorative responses even in highly urbanized environments: PRS and
>0.500). At baseline (T2), SCR rate was lower in winter green-urban positive affect increased, negative affect decreased, and SCL and SCR
than winter dense-urban (p =0.010). Walking induced significant SCR amplitudes were higher.
rate increases across all conditions (T4–T2 and T6–T2; all p <0.001). At
T4, winter green-urban showed lower SCR rates than both summer
walking conditions (all p < 0.050). At T6, SCR rates were higher in 3.3. Partial least squares structural equation modeling analysis
summer than in winter across both environments (all p <0.010), while
no within-season environmental differences were observed (Fig. 6c). 3.3.1. Measurement model assessment
The results of the measurement model evaluation are presented in
Table 4. Indicator reliability was evaluated using outer loadings, with
values above 0.708 explaining >50% of the variance and considered
Fig. 6. Boxplots of stage-level restorative responses of physiological measures with Wilcoxon test results across experiments and stages: a. Mean Skin Conductance
Level; b. Mean Skin Conductance Response Amplitude; c. Skin Conductance Response Rate. (Note: Thin curved lines outside the boxplots indicate statistically
significant pairwise differences between stages within the same experiment. Thick gradient-colored arcs within the central circle indicate statistically significant
differences between experiments at the same stage. Connected groups indicate significant pairwise comparisons, whereas the absence of connecting arcs indicates
non-significant between-group comparisons. Significance levels are denoted as p <0.05: *, p <0.01: **, p <0.001: ***.)
10

R. Tu et al.                                                                                                                                                                             E  n  v i r o  n  m   e n  t a  l   I m  p  a  c t   A   s s e  s s m   e n  t   R  e  v i e  w  122 (2027) 108642
Table 4  ranged from 0.039 to 0.302, suggesting that all constructs met the
Reliability and convergent validity of the measurement model. discriminant validity criteria (see Appendix B Table B.1).
| Dependent variable  |     | Outer  Composite  |     | Average variance  |     |     |     |     |     |     |     |
| ------------------- | --- | ----------------- | --- | ----------------- | --- | --- | --- | --- | --- | --- | --- |
(Latent constructs) loadings reliability  extracted (AVE) 3.3.2. Structural model assessment
(CR) Path coefficients (β) and their statistical significance (p-values), co-
efficients of determination (R2), and effect sizes (f2) were calculated to
| Positive Subjective  |     | – 0.756 |     | 0.622 |     |     |     |     |     |     |     |
| -------------------- | --- | ------- | --- | ----- | --- | --- | --- | --- | --- | --- | --- |
Outcomes evaluate the structural relationships. The initial model included control
Δ PRS
0.952 variables (age, BMI, gender, and PRND) with direct paths to all endog-
| Δ PANAS-Positive      |     | 0.580   |     |       |     |                                       |     |     |                        |     |       |
| --------------------- | --- | ------- | --- | ----- | --- | ------------------------------------- | --- | --- | ---------------------- | --- | ----- |
|                       |     |         |     |       |     | enous constructs. Most controls were  |     |     | non-significant. Only  |     | PRND  |
| Electrodermal Arousal |     | – 0.743 |     | 0.614 |     |                                       |     |     |                        |     |       |
Δ SCL showed a significant path to Negative Affect (p = 0.018), and BMI
0.512
Δ SCR Amplitude 0.983 showed marginally significant paths to Positive Subjective Outcomes
Perceived  and Negative Affect (p =0.072 and 0.079, respectively). Non-significant
environmental  – 0.877 0.782 paths were removed from the final model. The path coefficients among
quality the constructs are summarized in Fig. 7, with full details in Appendix B,
| Δ Visual Sat. |     | 0.856 |     |     |     |     |     |     |     |     |     |
| ------------- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Δ Acoustic Sat. 0.911 Table B.2, including bootstrapped path coefficients, 95% confidence
| Δ  in |     |     | (cid:0) |     |     | intervals, and p-values. |     |     |     |     |     |
| ----- | --- | --- | ------- | --- | --- | ------------------------ | --- | --- | --- | --- | --- |
N o t e :  d i c a t e s  b a s e li n e -c o rr e c t e d   v a l u e s   (T 6   T 4 ) .  M ea s u re m e n t  q u a l i t y   R2 values indicated the model explained 23.1% of variance in Skin
>
| cr it e r ia  w | er e   s a t is fi e d   w | h e n  o u te r   l o a d i n g s   | w e re   0 | .7 0 8 ,  co m | p o s ite   re li a b il i t y |               |        |               |             |            |            |
| --------------- | -------------------------- | ----------------------------------- | ---------- | -------------- | ------------------------------ | ------------- | ------ | ------------- | ----------- | ---------- | ---------- |
|                 |                            |                                     |            |                |                                | Temperature,  | 19.7%  | in  Positive  | Subjective  | Outcomes,  | 15.8%  in  |
values ranged from 0.70 to 0.90, and AVE values exceeded 0.50, indicating
adequate indicator reliability, internal consistency reliability, and convergent  Perceived Environmental Quality, and 12.1% in Electrodermal Arousal,
validity. with lower proportions for Thermal Satisfaction (R2 =0.078), Negative
Affect (R2 =0.079), and SCR Rate (R2 =0.034). Effect sizes (f2) quan-
tified the relative contribution of each exogenous construct to the
satisfactory (Hair Jr et al., 2021). Indicators with loadings between 0.40
explained variance of endogenous constructs. Following guidelines, f2 =
and 0.708, such as PANAS-Positive and ΔSCL (0.580 and 0.512,
0.02, 0.15, and 0.35 indicate weak, moderate, and strong effects, while
| respectively,  | Table  | 4),  were  retained  | if  internal  | consistency  | and  |     |     |     |     |     |     |
| -------------- | ------ | -------------------- | ------------- | ------------ | ---- | --- | --- | --- | --- | --- | --- |
values below 0.02 are negligible (Cohen, 2013, Hair et al., 2012). As
convergent validity were not compromised.
Internal consistency reliability was evaluated using composite reli- shown in Table 5, most significant predictors had weak effects, sug-
ability (CR), with values between 0.70 and 0.90 indicating satisfactory to  gesting  limited  but  non-negligible  contributions  to  the  explained
| good reliability (Hair Jr et al., 2021). Convergent validity was assessed  |     |     |     |     |     | variance. |     |     |     |     |     |
| -------------------------------------------------------------------------- | --- | --- | --- | --- | --- | --------- | --- | --- | --- | --- | --- |
via average variance extracted (AVE), with a minimum acceptable
threshold of 0.50, meaning the construct accounts for at least 50% of its  3.3.3. Pathways from physical environment to restorative responses
After model specification, path coefficients (β), p-values, and effect
indicators' variance (Hair Jr et al., 2021). In this study, composite reli-
sizes (f2) were jointly considered to evaluate both statistical and prac-
ability ranged from 0.743 to 0.877 and average variance extracted from
tical contributions to variance explained (Fig. 7and Table 5).
| 0.614  to  | 0.782,  confirming  | acceptable  | internal  | consistency  | and  |          |              |       |               |                    |      |
| ---------- | ------------------- | ----------- | --------- | ------------ | ---- | -------- | ------------ | ----- | ------------- | ------------------ | ---- |
|            |                     |             |           |              |      | Walking  | environment  | type  | (green-urban  | vs.  dense-urban)  | was  |
convergent validity (Table 4).
|     |     |     |     |     |     | significantly associated with Positive Subjective Outcomes (β =(cid:0) |     |     |     |     | 0.605,  |
| --- | --- | --- | --- | --- | --- | ---------------------------------------------------------------------- | --- | --- | --- | --- | ------- |
Discriminant validity of reflective constructs was assessed using the
p <0.001), with a small-to-moderate effect (f2 =0.110). This indicates
heterotrait-monotrait ratio (HTMT), which compares each construct with
all others. Values below 0.85 indicate satisfactory discriminant validity  that environment type accounted for a meaningful portion of the vari-
(Henseler et al., 2015). The observed heterotrait-monotrait ratio values  ance  in  perceived  restorativeness  and  positive  affect.  Ventilation
Fig. 7. Results of the PLS-SEM structural model. (Note: Solid lines with asterisks denote statistically significant standardized path coefficients, whereas dashed lines
represent non-significant paths. PRND: Participant's residential neighborhood density.)
11

R. Tu et al. E n v i r o n m e n t a l I m p a c t A s s e s s m e n t R e v i e w 122 (2027) 108642
Table 5 <0.001; β =0.367, p <0.001, respectively), with moderate to weak
Effect sizes (f2 ≥0.02) for predictors, mediators, and covariates in the PLS-SEM effect sizes (UTCI: f2 =0.294; V: f2 =0.127). Their effects on Thermal
model. Satisfaction were weaker (UTCI: β =(cid:0) 0.355, p =0.001, f2 =0.076; V: β
Predictor / Covariate Dependent Variable (DV) f- =(cid:0) 0.202, p =0.028, f2 =0.028), suggesting only small contributions to
square explained variance.
Physical Environmental Restorative responses Despite small effect sizes from Perceived Environmental Quality to
Conditions Positive Subjective Outcomes (f2 =0.022) and from Skin Temperature to
Environment Type Positive Subjective Outcomes 0.110* Electrodermal Arousal (f2 = 0.029), no statistically significant paths
Ventilation (V) Negative Affect 0.041* were observed among the endogenous constructs or to restorative re-
Gaseous Air Pollution (O3) SCR Rate 0.024*
sponses (Fig. 7). Consistent with results of bootstrapped indirect effects
Gaseous Air Pollution (O3) Electrodermal Arousal 0.026*
Particulate Matter (PM2.5) Electrodermal Arousal 0.049* used to assess mediation (Appendix B, Table B.3), all indirect pathways
Physical Environmental Potential Mediation linking physical environmental conditions to restorative responses were
Conditions Indicators non-significant. In addition, two-tailed bootstrapping revealed no sig-
Thermal Environment (UTCI) Skin Temperature 0.294**
nificant direct association between Positive Subjective Outcomes and
Ventilation (V) Skin Temperature 0.127*
Gaseous Air Pollution (O3) Perceived Environmental 0.114* Electrodermal Arousal (β =0.090, p =0.377, f2 =0.009).
Quality
Acoustic Environment (Leq) Perceived Environmental 0.080* 3.4. Linear mixed-effects models analysis
Quality
Thermal Environment (UTCI) Thermal Satisfaction 0.076*
The structure and performance of the LMMs for restorative re-
Ventilation (V) Thermal Satisfaction 0.028*
Potential Mediation Indicators Restorative responses sponses, including both best-fitting and alternative models, are pre-
Perceived Environmental Quality Positive Subjective Outcomes 0.022* sented in Table 6. However, due to singular matrix issues in the best-
Skin Temperature (Tsk) Electrodermal Arousal 0.029* fitting models based on PLS-SEM for PRS and SCR counts, these results
Covariates Restorative responses
were ultimately omitted. The stepwise results of the LMMs, including the
BMI Negative Affect 0.025*
BMI Positive Subjective Outcomes 0.024* baseline model AIC and R2 as well as changes in model performance, are
PRND Negative Affect 0.025* provided in Appendix C Tables C.1. Season-adjusted sensitivity analyses
Note: Effect sizes (f2) quantify the relative contribution of each exogenous (Appendix C Tables C.2-C.3) generally improved model fit while pre-
construct (predictor or covariate) to the explained variance of the endogenous serving the overall pattern of environmental associations. The inde-
construct (dependent variable), reflecting effect magnitude only as a variance- pendent O3 effect was attenuated after adjustment for season, consistent
based measure and not indicating directionality. PRND: participant's residen- with the pronounced seasonal variation of ambient O3 driven by
tial neighborhood density. Effect sizes: f2 <0.02: no effect; 0.02–0.15: * (weak); photochemical formation (Orellano et al., 2020). The remaining envi-
0.15–0.35: ** (moderate); ≥0.35: *** (strong). ronmental associations were largely preserved, suggesting that the in-
fluence of seasonal adjustment was largely confined to the O3
conditions (V) during walking were significantly linked to Negative association.
Affect (β =(cid:0) 0.196, p =0.013), although the effect size was small (f2 = In the PANAS-Positive models, visual and acoustic satisfaction were
0.041), suggesting only modest contribution to explained variance. included stepwise for the modest contribution of Perceived Environ-
For physiological measures, PM2.5 and gaseous air pollution (O3) mental Quality in the PLS-SEM model (f2 = 0.022), with visual satis-
showed significant effects on Electrodermal Arousal (β = 0.217, p = faction (Visual Sat.) showing superior performance. For Electrodermal
0.007; β = 0.159, p = 0.029, respectively), with weak but detectable Arousal, skin temperature (f2 =0.029), PM2.5 (f2 =0.049), and O3 (f2 =
effect sizes (PM2.5: f2 =0.049; O3: f2 =0.026), indicating statistically 0.026) were sequentially added to SCL and SCR amplitude models. Skin
significant yet practically modest contributions. Marginal associations temperature, as a physiologically adaptive measure partially regulated
were observed between SCR rate and O3 or acoustic environment (Leq) by individual thermoregulatory processes, was treated as a continuous
(β =(cid:0) 0.154, p =0.050; β =0.123, p =0.052), with corresponding f2 covariate and not applied for environment × predictor interaction
values of 0.024 and 0.015, suggesting minimal incremental explanatory analyses.
value. Consistent with the Wilcoxon results that SCR rates were gener-
ally higher during dense-urban walking, these findings imply that part of 3.4.1. Subjective restorative responses
SCR activity likely reflected traffic-related environmental influences. Including Visual Sat. increased the baseline R2 for PANAS-Positive
Therefore, SCR rates cannot be interpreted solely as a physiological from 0.107 to 0.186. Visual Sat. had a significant favorable effect (β
arousal indicator linked to restorative responses. =0.258, p <0.001), whereas covariates were not significant. The Dense-
Overall, although several physical environmental variables reached urban walking ×Visual Sat. interaction was non-significant (p =0.672),
statistical significance, their effect sizes remained small, implying that and adding it did not improve model fit (R2 and AIC remaining largely
these predictors primarily provided incremental improvements to model unchanged). This indicates that the positive effect of visual satisfaction
R2 rather than serving as dominant explanatory drivers of restorative occurs regardless of environment type.
responses. For PANAS-Negative, adding ventilation (V, f2 = 0.041) slightly
increased R2 from 0.132 to 0.138. Wind velocity had a significant in-
3.3.4. Assessment of endogenous constructs and potential mediation verse effect (β = (cid:0) 0.075, p = 0.045). The Dense-urban walking × V
pathways interaction was non-significant (p =0.166) and did not improve model
Potential mediation pathways were examined by evaluating path fit, with R2 and AIC both increasing slightly, suggesting that ventilation
coefficients (β) and effect sizes (f2) between physical environmental reduces negative affect independently of environment. Although
variables and the three endogenous constructs. walking duration was marginally non-significant (β = (cid:0) 0.065, p =
The acoustic environment (Leq) and O3 were significantly associated 0.056), the trend aligns with stage-level Wilcoxon results, indicating
with Perceived Environmental Quality (β = (cid:0) 0.266, p = 0.002; β = potential attenuation of negative affect with longer walking within the
0.321, p < 0.001, respectively), with weak effect sizes for variance range of this study.
explained (Leq: f2 = 0.080; O3: f2 = 0.114), indicating limited incre-
mental influence on overall R2. Thermal environment (UTCI) and 3.4.2. Physiological restorative responses
ventilation (V) were strongly linked to Skin Temperature (β =0.560, p For SCL, adding O3 and skin temperature increased R2 from 0.091 to
0.116. Walking duration positively affected SCL (β =0.252, p <0.001),
12

R. Tu et al.                                                                                                                                                                             E  n  v i r o  n  m   e n  t a  l   I m  p  a  c t   A   s s e  s s m   e n  t   R  e  v i e  w  122 (2027) 108642
Table 6  0.677) and did not improve model fit (R2 remaining similar and AIC
Linear mixed-effects models structure and results for restorative responses. increasing). Additionally, directional differences between the PLS-SEM
pathways and subsequent LMM estimates were observed for associa-
| Restorative responses/  |     | β (95% CI) |     |     | β (95% CI) |     |     |     |     |     |     |     |     |     |
| ----------------------- | --- | ---------- | --- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Fixed Effect tions between physiological restorative responses and air pollution in-
PANAS-Positive Best-fitting model (R2:  Alternative model (R2:  dicators (O3, and PM2.5), and are further discussed in the Discussion
|     |     | 0.186, AIC: 606.011)   |     |     | 0.187, AIC: 607.831)   |     |     | section. |     |     |     |     |     |     |
| --- | --- | ---------------------- | --- | --- | ---------------------- | --- | --- | -------- | --- | --- | --- | --- | --- | --- |
|     |     | (cid:0) 0.036 ((cid:0) |     |     | (cid:0) 0.027 ((cid:0) |     |     |          |     |     |     |     |     |     |
Dense-urban walking 0.190, 0.119) 0.187, 0.133) To further examine the interactive effects among physical environ-
|     |     | 0.302 ((cid:0) |     |     | 0.301 ((cid:0) |     |     |     |     |     |     |     |     |     |
| --- | --- | -------------- | --- | --- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Gender 0.325, 0.929) 0.326, 0.928) mental exposures during walking, additional interaction analyses were
| Age |     | 0.200 ((cid:0) | 0.056, 0.455) |     | 0.200 ((cid:0) | 0.055, 0.455) |     |     |     |     |     |     |     |     |
| --- | --- | -------------- | ------------- | --- | -------------- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
conducted based on the PLS-SEM findings. As only PM2.5 and O3 showed
| BMI |     | (cid:0) 0.032 ((cid:0) | 0.320, 0.255) |     | (cid:0) 0.033 ((cid:0) | 0.320, 0.255) |     |     |     |     |     |     |     |     |
| --- | --- | ---------------------- | ------------- | --- | ---------------------- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
0.086 ((cid:0) 0.087 ((cid:0) significant pathways to electrodermal arousal (Fig. 7), an interaction
| PRND |     |     | 0.158, 0.330) |     |     | 0.158, 0.331) |     |     |     |     |     |     |     |     |
| ---- | --- | --- | ------------- | --- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
Walking Duration 0.015 ((cid:0) 0.051, 0.081) 0.014 ((cid:0) 0.052, 0.080) term between these two pollutants was further incorporated into the
Visual Sat. 0.258 (0.177, 0.340) *** 0.287 (0.132, 0.441) *** best-fitting LMMs for SCL and SCR amplitude. As shown in Table 7, the
|     |     |     |     |     | (cid:0) | (cid:0) |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | ------- | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
D e n s e- u r b a n   w a l king  – 0 .0 3 6  ( 0 .2 0 1 ,  0 . 13 0 ) P M × O i n te r a c ti o n  t e r m  sh o w e d  a  m a r g in a l l y  s i g n i fi c a n t   a s s o c i a t i o n
| ×   |     |     |     |     |     |     |     | 2. 5   | 3   |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------ | --- | --- | --- | --- | --- | --- |
V i s u a l   S a t . o n ly   i n  t he   S C R   a m p l it u d e  m o d el   (p  = 0 . 0 7 0 ) ,   w h e r e a s   n o   s t a t is t i c a l l y
| PA N A S - N | e g a t i v e | Best-fitting m |     | odel (R2:  | A l | te r n at iv e |  m o d e l  ( R 2:   |     |     |     |     |     |     |     |
| ------------ | ------------- | -------------- | --- | ---------- | --- | -------------- | -------------------- | --- | --- | --- | --- | --- | --- | --- |
0.138, AIC: 621.134) 0.141, AIC: 621.212) significant effect was observed for SCL. In addition, sensitivity analyses
|     |     | (cid:0) 0.042 ((cid:0) |     |     | (cid:0) 0.055 ((cid:0) |     |     |     |     |     |     |     |     |     |
| --- | --- | ---------------------- | --- | --- | ---------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Dense-urban walking 0.195, 0.112) 0.208, 0.099) replacing O3 with NO2 (Appendix C Table C.4) showed higher explan-
| G en der |     | 0 . 6 | 7 3   ( (cid:0) 0 . | 0 2 5 ,   1 . 3 7 2 ) | 0 . 6 | 7 4   ( (cid:0) 0 . 0 | 2 3 ,   1 . 3 7 1 ) |     |     |     |     |     |     |     |
| -------- | --- | ----- | ------------------- | --------------------- | ----- | --------------------- | ------------------- | --- | --- | --- | --- | --- | --- | --- |
atory power than the primary O3-based models, while the overall pattern
| Ag e |     | 0 . 2 | 0 9   ( (cid:0) 0 . | 0 7 5 ,   0 . 4 9 4 ) | 0 . 2 | 0 7   ( (cid:0) 0 . 0 | 7 7 ,   0 . 4 9 1 ) |     |     |     |     |     |     |     |
| ---- | --- | ----- | ------------------- | --------------------- | ----- | --------------------- | ------------------- | --- | --- | --- | --- | --- | --- | --- |
(cid:0) 0.204 ((cid:0) (cid:0) 0.206 ((cid:0) of associations remained highly consistent. O3 was retained in the pri-
| BMI |     |     | 0.524, 0.116) |     |     | 0.525, 0.114) |     |     |     |     |     |     |     |     |
| --- | --- | --- | ------------- | --- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
(cid:0) 0.091 ((cid:0) (cid:0) 0.093 ((cid:0) mary analyses based on the predefined model selection strategy. The
| PRND |     |     | 0.363, 0.182) |     |     | 0.365, 0.178) |     |     |     |     |     |     |     |     |
| ---- | --- | --- | ------------- | --- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
Walking Duration (cid:0) 0.065 ((cid:0) 0.131, 0.001) (cid:0) 0.063 ((cid:0) 0.129, 0.003) comparable findings indicate that NO2 can also serve as a reasonable
V ¡0.075 (¡0.147,  ¡0.152 (¡0.283,  alternative indicator of gaseous air pollution.
|                      |     | ¡0.002) * |     |     | ¡0.021) *      |               |     |     |     |     |     |     |     |     |
| -------------------- | --- | --------- | --- | --- | -------------- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
| Dense-urban walking  |     |           |     | –   | 0.106 ((cid:0) | 0.044, 0.256) |     |     |     |     |     |     |     |     |
3.4.3. Integrated interpretation of LMMs
×V
Best-fitting model (R2:  Alternative model (R2:  LMM results corroborated the PLS-SEM and stage-based analyses.
SCL
Individual-level covariates were generally non-significant, highlighting
|                     |     | 0.117, AIC: 629.852)   |               |     | 0.118, AIC: 631.238)   |               |     |     |     |     |     |     |     |     |
| ------------------- | --- | ---------------------- | ------------- | --- | ---------------------- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
| Dense-urban walking |     | (cid:0) 0.139 ((cid:0) | 0.306, 0.027) |     | (cid:0) 0.133 ((cid:0) | 0.300, 0.035) |     |     |     |     |     |     |     |     |
that environmental and perceptual factors drove observed effects. For
| Gender |     | (cid:0) 0.294 ((cid:0) | 1.002, 0.414) |     | (cid:0) 0.294 ((cid:0) | 1.003, 0.415) |     |     |     |     |     |     |     |     |
| ------ | --- | ---------------------- | ------------- | --- | ---------------------- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
(cid:0) 0.099 ((cid:0) (cid:0) 0.100 ((cid:0) subjective measures, visual satisfaction was the strongest predictor of
| Age |     |     | 0.388, 0.190) |     |     | 0.389, 0.189) |     |     |     |     |     |     |     |     |
| --- | --- | --- | ------------- | --- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
BMI 0.104 ((cid:0) 0.221, 0.430) 0.105 ((cid:0) 0.221, 0.431) positive  affect  across  environments.  Ventilation  modestly  reduced
PRND 0.052 ((cid:0) 0.224, 0.329) 0.051 ((cid:0) 0.226, 0.327) negative affect regardless of environmental context. In physiological
Walking Duration 0.252 (0.180, 0.324) *** 0.252 (0.181, 0.324) *** measures, walking duration consistently elevated tonic and phasic
|     |     |     | (cid:0) |     |     | (cid:0) |     |     |     |     |     |     |     |     |
| --- | --- | --- | ------- | --- | --- | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
T s k 0.0 7 9  ( 0 . 0 0 7 ,  0 . 1 66) 0.0 8 2  ( 0 . 0 0 4 ,  0 . 1 69) el e c tr o d e r m a l  a r o u s a l.   G a s eo u s   a ir   p o ll u t i o n   (O )   s u p p re s s e d  S C L   i n d e -
O ¡ 0 . 1 6 1   ( ¡ 0 . 2 4 0 ,   ¡ 0 . 2 0 4   ( ¡ 0 . 3 3 6 ,   3
3 p e n d e n tl y   o f  t h e   e n v i r o n m en t .   P a r t ic u l a t e   m a t t e r   (P M )  n e g a t i v el y
|     |     | ¡   | 0 . 0 8 2 )   * * | *   | ¡   | 0 . 0 7 1 )   * * |     |     |     |     |     |     |     | 2 . 5 |
| --- | --- | --- | ----------------- | --- | --- | ----------------- | --- | --- | --- | --- | --- | --- | --- | ----- |
– 0.062 ((cid:0) affected SCR amplitude, with a significantly stronger effect observed in
| Dense-urban walking  |     |     |     |     |     | 0.092, 0.215) |     |     |     |     |     |     |     |     |
| -------------------- | --- | --- | --- | --- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
×O3 dense-urban settings. However, no clear interaction effects among
SCR Amplitude Best-fitting model (R2:  Alternative model (R2:  physical environmental exposures were observed in the present study.
|                     |     | 0.053, AIC: 678.027)   |               |     | 0.054, AIC: 679.854)   |               |     |               |     |     |     |     |     |     |
| ------------------- | --- | ---------------------- | ------------- | --- | ---------------------- | ------------- | --- | ------------- | --- | --- | --- | --- | --- | --- |
|                     |     | 0.121 ((cid:0)         |               |     | 0.115 ((cid:0)         |               |     |               |     |     |     |     |     |     |
| Dense-urban walking |     |                        | 0.072, 0.314) |     |                        | 0.080, 0.310) |     |               |     |     |     |     |     |     |
| Gender              |     | (cid:0) 0.311 ((cid:0) | 1.008, 0.386) |     | (cid:0) 0.312 ((cid:0) | 1.008, 0.385) |     | 4. Discussion |     |     |     |     |     |     |
| Age                 |     | (cid:0) 0.015 ((cid:0) | 0.299, 0.269) |     | (cid:0) 0.014 ((cid:0) | 0.298, 0.270) |     |               |     |     |     |     |     |     |
|                     |     | 0.058 ((cid:0)         |               |     | 0.058 ((cid:0)         |               |     |               |     |     |     |     |     |     |
BMI 0.262, 0.378) 0.262, 0.378) Using a randomized crossover design across two seasons, this study
| PRND             |     | 0.061 ((cid:0)           | 0.211, 0.333) |     | 0.062 ((cid:0)           | 0.209, 0.334) |     |            |                    |     |               |          |     |                  |
| ---------------- | --- | ------------------------ | ------------- | --- | ------------------------ | ------------- | --- | ---------- | ------------------ | --- | ------------- | -------- | --- | ---------------- |
|                  |     |                          |               |     |                          |               |     | initially  | demonstrated that  |     | nature-based  | walking  |     | produced higher  |
| Walking Duration |     | 0.152 (0.072, 0.232) *** |               |     | 0.151 (0.071, 0.231) *** |               |     |            |                    |     |               |          |     |                  |
0.085 ((cid:0) 0.083 ((cid:0) perceived restorativeness than dense-urban walking, consistent with
| Tsk |     |     | 0.010, 0.181) |     |     | 0.013, 0.179) |     |     |     |     |     |     |     |     |
| --- | --- | --- | ------------- | --- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
¡0.243 (¡0.457,  ¡0.235 (¡0.452,  prior evidence (Chen et al., 2025, Ma et al., 2024, Tu et al., 2026b). In
PM2.5
|     |     | ¡0.029) *              |               |     | ¡0.018) *              |               |     |     |     |     |     |     |     |     |
| --- | --- | ---------------------- | ------------- | --- | ---------------------- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
| O3  |     | (cid:0) 0.067 ((cid:0) | 0.154, 0.021) |     | (cid:0) 0.041 ((cid:0) | 0.189, 0.107) |     |     |     |     |     |     |     |     |
Table 7
| Dense-urban walking  |     | 0.285 (0.057, 0.514) * |     |     | 0.275 (0.042, 0.508) * |     |     |     |     |     |     |     |     |     |
| -------------------- | --- | ---------------------- | --- | --- | ---------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
×PM2.5 Linear mixed-effects models for potential interactions among physical environ-
| Dense-urban walking  |     |     |     | –   | (cid:0) 0.037 ((cid:0) | 0.209, 0.136) |     | mental indicators. |     |     |     |     |     |     |
| -------------------- | --- | --- | --- | --- | ---------------------- | ------------- | --- | ------------------ | --- | --- | --- | --- | --- | --- |
×O3
|     |     |     |     |     |     |     |     | Restorative responses/ |     | β (95% CI) |     | β (95% CI) |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------------- | --- | ---------- | --- | ---------- | --- | --- |
Note: PRND: participant's residential neighborhood density. Significance levels  Fixed Effect SCL (R2: 0.118, AIC:  SCR Amplitude (R2: 0.059,
are indicated as follows: p <0.05: *, p <0.01: **, and p <0.001: ***.
|                                                       |     |     |     |     |                         |     |     |                     |     | 631.202)               |         | AIC: 676.775)  |               |     |
| ----------------------------------------------------- | --- | --- | --- | --- | ----------------------- | --- | --- | ------------------- | --- | ---------------------- | ------- | -------------- | ------------- | --- |
|                                                       |     |     |     |     |                         |     |     | Dense-urban walking |     | (cid:0) 0.139 ((cid:0) | 0.306,  | 0.104 ((cid:0) | 0.088, 0.297) |     |
| while O3 had a significant inverse effect (β =(cid:0) |     |     |     |     | 0.161, p <0.001). This  |     |     |                     |     |                        |         |                |               |     |
0.027)
|     |     |     |     |     |     |     |     |     |     | (cid:0) 0.291 ((cid:0) |     | (cid:0) 0.309 ((cid:0) |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------------------- | --- | ---------------------- | --- | --- |
indicates that walking elevates SCL, but gaseous air pollution suppresses  Gender 1.000,  1.009, 0.391)
i t .  T h e   D e n se - u r b a n  w a lk in g   × O  i n t e r a ct i o n   w a s   n o n - s ig n ifi c a n t   ( p  = 0 . 4 1 8 )
3 Age (cid:0) 0 . 1 0 0 ((cid:0) 0.389,  (cid:0) 0.019 ((cid:0) 0.304, 0.266)
| 0 . 4 3 4 )   an | d   d i d   n | o t  im p ro | v e   m od | e l   fi t .  R | 2   r e m a i | n e d   s i m | i la r,   a n d   A I C  |     |     |     |     |     |     |     |
| ---------------- | ------------- | ------------ | ---------- | --------------- | ------------- | ------------- | ------------------------ | --- | --- | --- | --- | --- | --- | --- |
0.189)
increased slightly, suggesting that the effect of O3 is independent of  0.103 ((cid:0) 0.057 ((cid:0)
|     |     |     |     |     |     |     |     | BMI |     |     | 0.223, 0.429) |     | 0.265, 0.379) |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- | ------------- | --- |
environment type. PRND 0.049 ((cid:0) 0.228, 0.326) 0.053 ((cid:0) 0.220, 0.327)
For SCR amplitude, inclusion of Tsk, O3, PM2.5, and the Dense-urban  Walking Duration 0.250 (0.178, 0.322)  0.148 (0.068, 0.228) ***
walking ×PM2.5 interaction increased marginal R2 from 0.036 to 0.053  * * *
|     |     |     |     |     |     |     |     |     |     |      | 76 ((cid:0)   | 0.074 ((cid:0) |               |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---- | ------------- | -------------- | ------------- | --- |
|     |     |     |     |     |     |     |     | Tsk |     | 0 .0 | 0.010, 0.163) |                | 0.022, 0.169) |     |
a n d   d e c r e a se d   A IC   f ro m   6 79 . 8 2 5   t o   6 7 8 . 0 2 7 .   W a lk in g   d u r a t io n   O3 (cid:0) 0 . 1 5 0   ( (cid:0) 0 .233,  (cid:0) 0.034 ((cid:0) 0.128, 0.059)
|     |     |     | β  = | <   |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
in c r ea s e d   S C R  a m p li tu d e  ( 0 . 1 5 2 ,  p   0 . 0 0 1 ) ,   w hi le  P M 2 .5   h a d   a n   (cid:0) 0 . 0 6 8 )  * * *
inverse effect (β = (cid:0) 0.243, p = 0.027). The Dense-urban walking × – (cid:0) 0.194 ((cid:0) 0.413, 0.024) †
PM2.5
 = D e n s e - u r b a n walking  – 0 . 2 5 6   ( 0. 0 2 7 ,  0 . 4 8 5 )  *
| P M 2 .5  i n t | e r a c ti o n  w | a s   s i g | n i fi c a n | t   (p 0 . 0 1 | 5 ),  in d | i c a t in g |  t h a t  t h e   e ff e c t  |     |     |     |     |     |     |     |
| --------------- | ----------------- | ----------- | ------------ | -------------- | ---------- | ------------ | ----------------------------- | --- | --- | --- | --- | --- | --- | --- |
× P M
o f  P M 2 . 5  o n   S C R   am p l i t u d e   d i ff e r e d  b y e n v i ro n m e n t  c o n t ex t ,  w i t h  a   m o r e   × 2 . 5 0.042 ((cid:0) (cid:0) ) †
|     |     |     |     |     |     |     |     | PM 2 . 5   O | 3   |     | 0. 061, 0.145) | 0 . | 1 0 9   ( 0 . | 0 0 9 ,  0 . 2 2 7 |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | --- | --- | -------------- | --- | ------------- | ------------------ |
pronounced effect observed in the dense-urban walking environment.
The Dense-urban walking × O3 interaction was non-significant (p = N o t e :  P R N D :  p a r t i c i p a n t 's   re si d e n t i a l  ne ig h b o r h o o d  d e n s i t y .   S ig n i fi ca n c e  l e v e ls
|     |     |     |     |     |     |     |     | ar e  i n d i ca | t ed   as   f o l l o | w s :  p   < | 0 . 1 0 :  † ,  p  < 0 .0 | 5 :  * ,  p   < 0 | .0 1 :   * * , |   a n d  p   < 0 .0 0 1 :  * * * . |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --------------------- | ------------ | ------------------------- | ----------------- | -------------- | ---------------------------------- |
13

R. Tu et al. E n v i r o n m e n t a l I m p a c t A s s e s s m e n t R e v i e w 122 (2027) 108642
contrast, regardless of environment type, negative affect decreased 2024). ART primarily emphasizes cognitive and affective processes
across all walking conditions, indicating a general mood-regulating ef- involved in attentional recovery (Kaplan and Kaplan, 1989; Kaplan,
fect of walking itself. This pattern was supported by LMM results 1995), whereas SRT focuses on the reduction of psychophysiological
showing a marginal inverse association between walking duration and stress, including autonomic stress regulation and associated negative
negative affect (β = (cid:0) 0.065, p = 0.056), aligning with meta-analytic affect (Ulrich, 1983, Ulrich et al., 1991). Although both processes may
findings on walking-related mental health benefits (Hanson and Jones, be concurrently activated by the same environmental exposure, their
2015; Xu et al., 2024). responses are not necessarily coupled in magnitude or timing, as they
Within the green-urban condition, lower temperatures were associ- may involve multiple restorative mechanisms and regulatory dynamics.
ated with stronger restorative responses. Although seasonal differences
at T6 were negligible, winter green-urban walking showed enhanced 4.2. Interaction and independent effects of environmental exposure during
restorativeness. This was reflected in higher PRS and PANAS-Positive walking
scores, as well as relatively elevated SCL. This pattern is consistent
with prior findings from the same region indicating diminished visual The effect of environmental context on exposure-response relation-
restorative benefits when air temperature exceeds 33 ◦C (Dong et al., ships was generally limited, with most identified local environmental
2025), supporting a moderating role of thermal conditions. Although exposures independently eliciting measurable restorative responses,
summer temperatures in this study were moderate (28.6 ±2.7 ◦C) and subsequently confirmed through LMM analyses.
below the 33 ◦C threshold, winter green-urban walking still showed Among the exposure variables identified by the PLS-SEM, only one
slightly stronger restorative effects, consistent with earlier trends. significant interaction between urban walking and PM2.5 was detected in
the LMM analysis. In particular, dense-urban walking ×PM2.5 was sig-
4.1. Multiple exposure-response pathways influencing restorative nificant (β =0.285, p =0.015) for SCR amplitude, suggesting a stronger
responses PM2.5-related suppression of phasic EDA in dense-urban settings. Com-
parable findings have been reported in a virtual reality experiment,
During urban walking, restorative responses appeared to arise where natural environments produced stronger restorative outcomes
through multiple parallel pathways. Rather than reflecting a unified and lower physiological stress indicators (e.g., SCL) than urban settings
recovery process, affective and physiological responses showed partially under equivalent noise exposure (Kawai et al., 2024). Together, these
distinct associations with perceived environmental quality and physical results suggest that, under comparable mild or localized adverse envi-
environmental stressors. ronmental exposures, nature-based settings may directly mitigate
Affective restoration was primarily associated with visual satisfac- autonomic stress responses to specific factors.
tion and environmental perception. Although walking environment type Nevertheless, no other significant environment interactions were
significantly influenced perceived restorativeness and positive affect in detected for the other exposure-response pathways identified by the
the PLS-SEM analysis, the LMM results further indicated that visual PLS-SEM. Independent effects emerged along specific dimensions: O3
satisfaction was strongly associated with positive affect across both modulated physiological responses (e.g., SCL and SCR amplitude),
walking contexts. This pattern suggests that the emotional benefits of whereas perceptual and experiential factors (e.g., perceived visual
natural settings may depend on how the environment is perceptually quality and ventilation) influenced affective responses independently of
appraised during walking rather than on environment type per se. En- environmental context. These findings suggest that the majority of
vironments perceived as pleasant may reduce emotional strain and restorative effects from environmental exposure operate largely
facilitate short-term affective restoration, broadly consistent with Stress regardless of the surrounding context.
Recovery Theory (Ulrich et al., 1991). Ventilation also modestly reduced Correspondingly, winter dense-urban walking produced limited
negative affect, possibly because improved airflow influences thermal short-term restorative effects in this study. Specifically, SCR amplitude
sensation and heat storage during walking (Zhang et al., 2020), thereby was significantly higher during the first 1 km in winter than in summer,
alleviating prolonged environmental discomfort. Together, these find- accompanied by improvements in perceived restorativeness and positive
ings suggest that affective restoration may be closely linked to percep- affect. These observations complement the pathway analysis, indicating
tual and sensory experience. that restorative responses are not exclusive to natural environments, but
In contrast to the affective pathways, PLS-SEM did not identify sig- can also occur in built settings under favorable climatic conditions.
nificant associations between subjective restorative measures and air Similar effects have been reported in historic urban areas with limited
pollution exposure, whereas physiological pathways showed significant natural elements (Stigsdotter et al., 2017) or specific built scenes
associations with air pollution exposure. Across both analytical ap- (Collado and Manrique, 2020). However, these effects diminished at 2
proaches, PM2.5 and O3 were associated with electrodermal responses, km, suggesting that such benefits are transient, season-dependent, and
while LMM indicated reduced tonic skin conductance and SCR ampli- unlikely to persist without supportive environmental contexts.
tude. This suggests a direct influence of air pollution on autonomic The observed independent effects of major environmental exposures
arousal regulation, and aligns with evidence that traffic-related air reveal that restorative responses are shaped not only by environmental
pollutants can affect physiological stress regulation during pedestrian context but also by the combination of exposures, highlighting that
activity (Cavalcante de S´a et al., 2016; Du et al., 2022). One possible increasing green space alone may be insufficient. These findings provide
explanation is that, given the relatively short exposure duration and empirical support for managing key physical environmental factors to
moderate pollution levels in the present study, pollutant exposure dur- enhance restorative potential in built urban areas with limited oppor-
ing walking may not always be consciously perceived or sufficiently tunities for greening.
integrated into stable perceptual experience. In parallel, EDA, as an
index of sympathetic nervous system activation, remains sensitive to 4.3. Temporal scale differences in environmental exposure effects
subtle environmental stressors (Kreibig, 2010) and reflects concurrent
physiological responses that may not be reported by subjective Environmental effects on restorative responses operate over different
measures. temporal scales. Although winter green-urban conditions produced
Collectively, these findings suggest that affective and physiological measurable restorative benefits, short-term variations in thermal in-
restoration may operate as partially distinct regulatory processes within dicators (UTCI, skin temperature, thermal satisfaction) did not show
urban walking environments, broadly corresponding to the comple- significant pathways to subjective or physiological responses in the PLS-
mentary yet not fully integrated relationship between Attention Resto- SEM analysis. Stage-level thermal fluctuations were small (ΔT4–T6:
ration Theory (ART) and Stress Recovery Theory (SRT) (Joye et al., 0.853–1.250 ◦C), below typical perceptual thresholds for discomfort
14

R. Tu et al. E n v i r o n m e n t a l I m p a c t A s s e s s m e n t R e v i e w 122 (2027) 108642
(Battistel et al., 2023; Du et al., 2014). Thus, micro-scale variations were response pathways were modeled using PLS-SEM to explore multi-
insufficient to trigger noticeable psycho-physiological changes. exposure, multi-pathway mechanisms within a unified framework.
The lack of stage-level thermal effects may also reflect a mismatch in These models were subsequently validated using LMMs, which also
temporal scale. Thermal comfort depends on ~35 s of exposure history assessed potential environmental interactions. However, several limi-
(Xie et al., 2022) and short-term thermal sensation is based on ~2–3 min tations should be noted.
accumulated experience (Lau et al., 2019). The stage aggregation win- As a field-based experiment, the results were inevitably influenced
dow (15 min) likely missed both immediate fluctuations and the 15–20 by real-world environmental variability, which limited the contrast
min needed for steady-state subjective responses (Goto et al., 2006, between conditions. For example, the seasonal sessions were conducted
Greco et al., 2016). Still, stronger responses in winter green-urban in a fixed, non-counterbalanced order, such that seasonal and session-
conditions suggest thermal effects operate at broader contextual or order confounding could not be fully disentangled. Consistent with
seasonal scales, not micro-scale stage fluctuations. In contrast, air this design structure, modest restorative responses were observed even
pollution stressors (PM2.5 and O3) showed short-term, even immediate, during the first half of winter dense-urban walking, likely due to the
pedestrian-level effects on physiological responses. presence of street greenery and relatively high environmental quality
Likewise, variations across stages in acoustic indicators (Leq and along the selected routes. Although these factors may have diminished
acoustic satisfaction) were not associated with significant restorative the distinctiveness between dense-urban and green-urban conditions,
response pathways in the PLS-SEM analysis (Leq on SCR: p =0.052; all the exposure-response pathways identified in the analyses remained
other pathways were non-significant). Both walking environments were detectable, indicating that the affective benefits of green-urban walking
characterized by moderate-to-high noise exposure (Leq: green-urban were still present but less pronounced in comparison.
58.37 ± 1.81 dBA; dense-urban 66.52 ± 1.68 dBA). Although the Methodologically, several limitations arise from the analytical
green-urban route exhibited comparatively lower noise levels, this dif- strategy, which is primarily associated with differences in exposure
ference may have been insufficient to produce distinct restorative effects representation and temporal aggregation between modeling frame-
within the model. Consistent with recent findings, perceptual evalua- works. The discrepancy in the direction of several coefficients is mainly
tions in moderate-noise (≈60 dBA) and high-noise (≈70 dBA) settings attributable to the application of pairwise differences in PLS-SEM, which
tend to resemble each other more closely than those in low-noise envi- may compress variability in exposure levels. In addition, within the PLS-
ronments (≈50 dBA) (Lu et al., 2020), suggesting limited perceptual SEM framework, thermal (UTCI) and acoustic (Leq) indicators showed
differentiation under the exposure levels observed in this study. limited variability and no significant pathways to restorative responses,
Additionally, the partial discrepancy in coefficient direction between differing from associations reported in previous single-factor studies
the PLS-SEM and LMM findings for PM2.5 and O3 associations with (Schaupp et al., 2025, Song et al., 2024). This discrepancy may reflect
electrodermal responses likely reflects differences in exposure repre- temporal aggregation effects, as thermal and acoustic responses can
sentation and temporal aggregation between the two analytical frame- operate over accumulation windows shorter or longer than the 15-min
works. The PLS-SEM was based on T6–T4 pairwise differences derived stage intervals applied here. Future studies using finer temporal seg-
from independent within-participant observations, reflecting middle-to- mentation may better capture these scale-sensitive associations.
post walking changes in physical environmental conditions and corre- Several measurement-related limitations should also be acknowl-
sponding intervention-related restorative responses across walking edged. Although missing EDA data were limited and randomly distrib-
stages. Although the pairwise difference preserved relative exposur- uted, mean imputation may have introduced a conservative bias by
e–response variation patterns, it may have compressed stage-level reducing physiological variability, thereby attenuating effect sizes and
exposure variability and attenuated information related to absolute limiting the detection of marginal effects in the PLS-SEM results. To
environmental exposure levels. By contrast, the LMM analyses retained minimize participant burden, the satisfaction assessment was simplified,
absolute exposure conditions together with stage-level within-person and some sensory dimensions (e.g., olfaction) were not included. This
restorative response fluctuations. The differing coefficient directions may have limited the representation of multidimensional environmental
may therefore suggest that electrodermal responses to air pollutants are perceptions and partly explained the lack of significant mediation effects
not strictly linear across exposure ranges, as also reported in previous involving satisfaction variables. Accordingly, the role of integrated
cross-sectional studies (Di et al., 2017; Hua et al., 2025), such that perceived environmental quality in restorative processes warrants
relative pairwise-difference-based associations and stage-level absolute further investigation.
exposure effects may not necessarily exhibit identical directional pat- Finally, limitations related to sample characteristics and external
terns. Consequently, the PLS-SEM and LMM may reflect different aspects validity should be considered. Healthy young adults were recruited to
of the exposure–response relationship, emphasizing relative environ- reduce potential physiological bias, which may be associated with the
mental contrasts within the multivariate restorative-response system non-significant sex differences observed across analyses. Furthermore,
and stage-level physiological fluctuations under specific exposure con- this sampling strategy limits the generalizability of the findings to other
ditions, respectively. age and health groups. The same walking workload may correspond to
Overall, different environmental exposure effects appear to operate different physical intensity and physiological burden in middle-aged and
over distinct temporal windows, with pollutants showing short-term older adults, as well as in populations with clinical conditions, poten-
physiological associations, whereas thermal conditions are more tially resulting in different restorative responses. Future research could
evident at broader contextual or seasonal scales. include more diverse population groups to improve external validity.
4.4. Strength and limitations 5. Conclusion
This study investigates the multi-pathway mechanisms underlying This study confirms that nature-based walking produces stronger
restorative walking and offers several key strengths. Conceptually, short-term restorative responses than dense-urban walking. Notably, the
building upon environmental comparisons and adopting a preliminary PLS-SEM results indicate that these responses are driven by multiple
exploratory approach, the research treats restorativeness as a system parallel pathways rather than a single integrated route. Specifically,
simultaneously shaped by multiple environmental factors. Methodo- perceptual and experiential factors predominantly influence affective
logically, it synchronously captured pedestrian-level environmental responses, whereas environmental stressors such as air pollutants act
exposures and corresponding restorative responses across multiple di- directly on physiological responses (e.g., EDA), with minimal evidence
mensions within the same participants under equivalent measurement of cross-pathway mediation. These parallel pathways suggest that
scales, enabling direct comparability. Analytically, parallel exposure- restorative processes operate through multidimensional mechanisms
15

R. Tu et al. E n v i r o n m e n t a l I m p a c t A s s e s s m e n t R e v i e w 122 (2027) 108642
and cannot be reduced to a single factor. runners. J. Breath Res. 10, 046018. https://doi.org/10.1088/1752-7163/10/4/
The LMM analyses tested a limited number of interaction effects and 046018.
Celikors, E., Wells, N.M., 2022. Are low-level visual features of scenes associated with
identified a significant interaction between dense-urban walking and perceived restorative qualities? J. Environ. Psychol. 81, 101800. https://doi.org/
PM2.5 on SCR amplitude. This indicates that particulate exposure effects 10.1016/j.jenvp.2022.101800.
may be amplified under compounded dense-urban environmental Chen, L., Yan, R., Hu, Y., 2025. City walk or nature walk? Evidence-based psychological
and physiological outcomes – a systematic review and meta-analysis. Urban For.
stressors. Although contextual moderation was limited overall, this
Urban Green. 106, 128726. https://doi.org/10.1016/j.ufug.2025.128726.
finding suggests that environmental exposures do not operate as simple Chen, T., Hua, J., Wang, S., Yin, S., 2026a. Heat vulnerability and resilience-oriented
linear additions, but may interact under certain environmental condi- solutions for diverse urban residential communities in Guangzhou, China. Environ.
Impact Assess. Rev. 117, 108150. https://doi.org/10.1016/j.eiar.2025.108150.
tions. Most other exposure-response relationships remained stable and
Chen, Y., Dong, Q., Yuan, C., Zhang, L., Sun, C., 2026b. Warming amidst depopulating:
independent across walking environments, providing empirical support insights from surface urban heat island in China’s shrinking cities. Habitat Int. 170,
for environmental planning and management strategies that target 103758. https://doi.org/10.1016/j.habitatint.2026.103758.
Cohen, J., 2013. Statistical Power Analysis for the Behavioral Sciences, 2nd Edition ed.
specific physical indicators to enhance restorative potential.
Routledge, New York. https://doi.org/10.4324/9780203771587.
Scale-dependent effects were observed, with thermal conditions Collado, S., Manrique, H.M., 2020. Exposure to Awe-Evoking Natural and Built Scenes
operating primarily at broader contextual or seasonal levels, whereas Has Positive Effects on Cognitive Performance and Affect, 52, pp. 1105–1132.
https://doi.org/10.1177/0013916519868733.
traffic-related pollutants exerted more immediate influences at the
Dhondt, S., Beckx, C., Degraeuwe, B., Lefebvre, W., Kochan, B., Bellemans, T., et al.,
pedestrian exposure scale. This differentiation across spatial and tem- 2012. Health impact assessment of air pollution using a dynamic exposure profile:
poral scales highlights that environmental stressors should not be implications for exposure and health impact estimates. Environ. Impact Assess. Rev.
treated in isolation. These findings underscore the need to consider 36, 42–51. https://doi.org/10.1016/j.eiar.2012.03.004.
Di, Q., Wang, Y., Zanobetti, A., Wang, Y., Koutrakis, P., Choirat, C., et al., 2017. Air
perceived quality, micro-environmental exposures, and broader pollution and mortality in the medicare population. N. Engl. J. Med. 376,
contextual factors together when designing and managing urban 2513–2522. https://doi.org/10.1056/NEJMoa1702747.
walking environments. Dong, W., Dai, D., Liu, M., Wang, Y., Li, S., Shen, P., 2025. Combined effects of the visual-
thermal environment on restorative benefits in hot outdoor public spaces: a case
Overall, the findings indicate that even within the same walking
study in Shenzhen, China. Build. Environ. 272, 112690. https://doi.org/10.1016/j.
context, heterogeneous environmental exposures can produce differen- buildenv.2025.112690.
tiated short-term restorative outcomes. Importantly, this highlights that Du, X., Li, B., Liu, H., Yang, D., Yu, W., Liao, J., et al., 2014. The response of human
thermal sensation and its prediction to temperature step-change (cool-neutral-cool).
restorative walking environments arise from integrated exposure-
PLoS One 9, e104320. https://doi.org/10.1371/journal.pone.0104320.
response processes involving both psychological and physiological Du, X., Zhang, Q., Jiang, Y., Li, H., Zhu, X., Zhang, Y., et al., 2022. Dynamic molecular
pathways, rather than being attributed to greenery alone. choreography induced by traffic exposure: a randomized, crossover trial using multi-
omics profiling. J. Hazard. Mater. 424, 127359. https://doi.org/10.1016/j.
jhazmat.2021.127359.
Declaration of competing interest Dzhambov, A.M., Markevych, I., Tilov, B., Arabadzhiev, Z., Stoyanov, D., Gatseva, P.,
et al., 2018. Pathways linking residential noise and air pollution to mental ill-health
in young adults. Environ. Res. 166, 458–465. https://doi.org/10.1016/j.
The authors declare that they have no known competing financial
envres.2018.06.031.
interests or personal relationships that could have appeared to influence Faul, F., Erdfelder, E., Buchner, A., Lang, A.-G., 2009. Statistical power analyses using
the work reported in this paper. G*power 3.1: tests for correlation and regression analyses. Behav. Res. Methods 41,
1149–1160. https://doi.org/10.3758/BRM.41.4.1149.
Frank, L.D., Iroz-Elardo, N., MacLeod, K.E., Hong, A., 2019. Pathways from built
Acknowledgements environment to health: a conceptual framework linking behavior and exposure-
based impacts. J. Transp. Health 12, 319–335. https://doi.org/10.1016/j.
This study is funded by the National Natural Science Foundation of jth.2018.11.008.
Gatti, E., Calzolari, E., Maggioni, E., Obrist, M., 2018. Emotional ratings and skin
China (No. 52478017 and No. 52308020). conductance response to visual, auditory and haptic stimuli. Sci. Data 5, 180120.
https://doi.org/10.1038/sdata.2018.120.
Appendix A. Supplementary data GBD 2019 Mental Disorders Collaborators, 2022. Global, regional, and national burden
of 12 mental disorders in 204 countries and territories, 1990–2019: a systematic
analysis for the Global Burden of Disease Study 2019. Lancet Psychiatry 9, 137–150.
Supplementary data to this article can be found online at https://doi. https://doi.org/10.1016/S2215-0366(21)00395-3.
org/10.1016/j.eiar.2026.108642. Goto, T., Toftum, J., de Dear, R., Fanger, P.O., 2006. Thermal sensation and
thermophysiological responses to metabolic step-changes. Int. J. Biometeorol. 50,
323–332. https://doi.org/10.1007/s00484-005-0016-5.
Data availability Greco, A., Valenza, G., Scilingo, E.P., 2016. Advances in Electrodermal Activity
Processing with Applications for Mental Health. Springer. https://doi.org/10.1007/
978-3-319-46705-4.
Data will be made available on request.
Hair, J.F., Sarstedt, M., Ringle, C.M., Mena, J.A., 2012. An assessment of the use of
partial least squares structural equation modeling in marketing research. J. Acad.
References Mark. Sci. 40, 414–433. https://doi.org/10.1007/s11747-011-0261-6.
Hair, J.F., Risher, J.J., Sarstedt, M., Ringle, C.M., 2019. When to use and how to report
´ the results of PLS-SEM. Eur. Bus. Rev. 31, 2–24. https://doi.org/10.1108/EBR-11-
Armengol, J.M., Carnerero, C., Rames, C., Criado, A., Borge-Holthoefer, J., Soret, A.,
2018-0203.
et al., 2024. City-scale assessment of pedestrian exposure to air pollution: a case
Hair Jr., J.F., Hult, G.T.M., Ringle, C.M., Sarstedt, M., Danks, N.P., Ray, S., 2021. Partial
study in Barcelona. Urban Clim. 58, 102183. https://doi.org/10.1016/j.
Least Squares Structural Equation Modeling (PLS-SEM) Using R: A Workbook, 1 ed.
uclim.2024.102183.
Bates, D., M¨achler, M., Bolker, B., Walker, S., 2015. Fitting linear mixed-effects models Springer Nature. https://doi.org/10.1007/978-3-030-80519-7.
Batti u s s te in l, g L l . m , V e4 il . a J rd . i S , t A at . . , S Z o a f m tw p . i n 6 i 7 , , M 1 . – , 4 P 8 a . r i h n t , t p R s . : , / 2 /d 0 o 2 i 3 .o . r A g n / 1 i 0 n . v 1 e 8 s 6 ti 3 g 7 a / ti j o ss n . v o 0 n 6 7 h . u i0 m 1 a . ns’ Hans A o n sy , s S t . e , m Jo a n ti e c s r , e A v . i , e 2 w 0 1 a 5 n . d I m s t e h t e a r -a e n e a v l i y d s e is n . c B e r t . h J a . t S w po a r lk ts i n M g e g d r . o 4 u 9 p , s 7 h 1 a 0 v – e 7 h 1 e 5 a . l t h h t t b p e s: n / e / fi d t o s i ? .
org/10.1136/bjsports-2014-094157.
sensitivity to environmental temperature. Sci. Rep. 13, 21353. https://doi.org/
Hartig, T., Kaiser, F.G., Bowler, P.A., 1997. Further Development of a Measure of
10.1038/s41598-023-47880-5. Perceived Environmental Restorativeness. Institutet fo¨r bostads-och urbanforskning,
Benedek, M., Kaernbach, C., 2010. A continuous measure of phasic electrodermal
activity. J. Neurosci. Methods 190, 80–91. https://doi.org/10.1016/j. Uppsala, Sweden.
Hartig, T., Mitchell, R., de Vries, S., Frumkin, H., 2014. Nature and health. Annu. Rev.
jneumeth.2010.04.028. Public Health 35, 207–228. https://doi.org/10.1146/annurev-publhealth-032013-
Benjamini, Y., Hochberg, Y., 1995. Controlling the false discovery rate: a practical and
powerful approach to multiple testing. J. R. Stat. Soc. B. Methodol. 57, 289–300. Have 1 n 8 i 2 th 4 , 4 G 3. ., Fiala, D., Błazejczyk, K., Richards, M., Bro¨de, P., Holm´er, I., et al., 2012.
https://doi.org/10.1111/j.2517-6161.1995.tb02031.x. The UTCI-clothing model. Int. J. Biometeorol. 56, 461–470. https://doi.org/
Bratman, G.N., Anderson, C.B., Berman, M.G., Cochran, B., de Vries, S., Flanders, J.,
10.1007/s00484-011-0451-4.
et al., 2019. Nature and mental health: an ecosystem service perspective. Sci. Adv. 5,
Henseler, J., Ringle, C.M., Sarstedt, M., 2015. A new criterion for assessing discriminant
eaax0903. https://doi.org/10.1126/sciadv.aax0903.
Cavalcante de Sa´, M., Nakagawa, N.K., Saldiva de Andr´e, C.D., Carvalho-Oliveira, R., de v 1 a 1 l 5 id –1 it 3 y 5 i . n h v tt a p r s ia :/ n / c d e o -b i. a o s r e g d / 1 s 0 tr . u 1 c 0 t 0 u 7 r / a s l 1 e 1 q 7 u 4 a 7 ti - o 0 n 1 4 m -0 o 4 d 0 e 3 li - n 8 g . . J. Acad. Mark. Sci. 43,
Santana Carvalho, T., Nicola, M.L., et al., 2016. Aerobic exercise in polluted urban
environments: effects on airway defense mechanisms in young healthy amateur
16

R. Tu et al. E n v i r o n m e n t a l I m p a c t A s s e s s m e n t R e v i e w 122 (2027) 108642
Hollander, M., Wolfe, D.A., Chicken, E., 2013. Nonparametric Statistical Methods. John Morris, J.N., Hardman, A.E., 1997. Walking to health. Sports Med. (Auckland, NZ). 23,
Wiley & Sons. https://doi.org/10.1002/9781119196037. 306–332. https://doi.org/10.2165/00007256-199723050-00004.
Ho¨ppe, P., 1992. A new procedure to determine the mean radiant temperature outdoors. Olafsdottir, G., Cloke, P., Schulz, A., van Dyck, Z., Eysteinsson, T., Thorleifsdottir, B.,
Wetter und Leben. 44, 147–151. et al., 2020. Health Benefits of Walking in Nature: A Randomized Controlled Study
Hua, Q., Meng, X., Gong, J., Qiu, X., Shang, J., Xue, T., et al., 2025. Ozone exposure and under Conditions of Real-life Stress, 52, pp. 248–274. https://doi.org/10.1177/
cardiovascular disease: a narrative review of epidemiology evidence and underlying 0013916518800798.
mechanisms. Fundam. Res. 5, 249–263. https://doi.org/10.1016/j. Orellano, P., Reynoso, J., Quaranta, N., Bardach, A., Ciapponi, A., 2020. Short-term
fmre.2024.02.016. exposure to particulate matter (PM10 and PM2.5), nitrogen dioxide (NO2), and
Hunter, M.R., Gillespie, B.W., Chen, S.Y.-P., 2019. Urban nature experiences reduce ozone (O3) and all-cause and cause-specific mortality: systematic review and meta-
stress in the context of daily life based on salivary biomarkers. Front. Psychol. analysis. Environ. Int. 142, 105876. https://doi.org/10.1016/j.envint.2020.105876.
https://doi.org/10.3389/fpsyg.2019.00722. Volume 10–2019. Pandya, P., Llaguno-Munitxa, M., Edwards, M.G., Lacroix, E., Manoli, G., Middel, A.,
International Organization for Standardization, 2004. Ergonomics-evaluation of Thermal 2025. Environmental, neuropsychological, and physiological factors in urban
Strain by Physiological Measurements. International Organization for outdoor thermal comfort assessments: a systematic review. Int. J. Biometeorol. 69,
Standardization. https://www.iso.org/standard/34110.html. 1819–1841. https://doi.org/10.1007/s00484-025-02942-3.
Jendritzky, G., de Dear, R., Havenith, G., 2012. UTCI—why another thermal index? Int. Peel, M.C., Finlayson, B.L., McMahon, T.A., 2007. Updated world map of the Koppen-
J. Biometeorol. 56, 421–428. https://doi.org/10.1007/s00484-011-0513-7. Geiger climate classification. Hydrol. Earth Syst. Sci. 11, 1633–1644. https://doi.
Jeon, J.Y., Jo, H.I., Lee, K., 2021. Potential restorative effects of urban soundscapes: org/10.5194/hess-11-1633-2007.
personality traits, temperament, and perceptions of VR urban environments. Landsc. R Core Team, 2025. The R project for statistical computing R version 4.5.2. Foundation
Urban Plan. 214, 104188. https://doi.org/10.1016/j.landurbplan.2021.104188. for Statistical Computing [Computer software]. https://www.r-project.org/.
Joye, Y., Ko¨ster, M., Lange, F., Fischer, M., Moors, A., 2024. A goal-discrepancy account Ringle, C., M., W., S., Becker, J.-M., 2024. SmartPLS 4. SmartPLS [Computer software].
of restorative nature experiences. J. Environ. Psychol. 93, 102192. https://doi.org/ https://www.smartpls.com/company.
10.1016/j.jenvp.2023.102192. Russell, J.A., 1980. A circumplex model of affect. J. Pers. Soc. Psychol. 39, 1161–1178.
Kabisch, N., Püffel, C., Masztalerz, O., Hemmerling, J., Kraemer, R., 2021. Physiological https://doi.org/10.1037/h0077714.
and psychological effects of visits to different urban green and street environments in Sallis, J.F., Cerin, E., Conway, T.L., Adams, M.A., Frank, L.D., Pratt, M., et al., 2016.
older people: a field experiment in a dense inner-city area. Landsc. Urban Plan. 207, Physical activity in relation to urban environments in 14 cities worldwide: a cross-
103998. https://doi.org/10.1016/j.landurbplan.2020.103998. sectional study. Lancet 387, 2207–2217. https://doi.org/10.1016/S0140-6736(15)
Kaplan, R.S.-W., Kaplan, S., 1989. The Experience of Nature: A Psychological 01284-2.
Perspective. Cambridge University Press, New York. Schaupp, J., Sch¨affer, B., Wunderli, J.-M., Hediger, K., Tobias, S., Heimer, J., et al., 2025.
Kaplan, S., 1995. The restorative benefits of nature: toward an integrative framework. Psychophysiological effects of walking in forests and urban built environments with
J. Environ. Psychol. 15, 169–182. https://doi.org/10.1016/0272-4944(95)90001-2. disparate road traffic noise exposure: a randomized controlled trial. J. Environ.
Kawai, C., Georgiou, F., Pieren, R., Tobias, S., Mavros, P., Scha¨ffer, B., 2024. Psychol. 105, 102662. https://doi.org/10.1016/j.jenvp.2025.102662.
Investigating effect chains from cognitive and noise-induced short-term stress build- Singleton, H., Porter, S., Beavis, J., Falconer, L., Hernandez, J.P., Holley, D., 2023.
up to restoration in an urban or nature setting using 360◦VR. J. Environ. Psychol. Accounting for complexity in critical realist trials: the promise of PLS-SEM. J. Crit.
100, 102466. https://doi.org/10.1016/j.jenvp.2024.102466. Realism 22, 384–403. https://doi.org/10.1080/14767430.2023.2217652.
Kelly, P., Williamson, C., Niven, A.G., Hunter, R., Mutrie, N., Richards, J., 2018. Walking Song, S., Xiao, Y., Tu, R., Yin, S., 2024. Effects of thermal perception on restorative
on sunshine: scoping review of the evidence for walking and mental health. Br. J. benefits by green space exposure: a pilot study in hot-humid China. Urban Clim. 53,
Sports Med. 52, 800–806. https://doi.org/10.1136/bjsports-2017-098827. 101767. https://doi.org/10.1016/j.uclim.2023.101767.
Kock, N., Hadaya, P., 2018. Minimum Sample Size Estimation in PLS-SEM: The Inverse Stevenson, M.P., Schilhab, T., Bentsen, P., 2018. Attention restoration theory II: a
Square Root and Gamma-exponential Methods, 28, pp. 227–261. https://doi.org/ systematic review to clarify attention processes affected by exposure to natural
10.1111/isj.12131. environments. J. Toxicol. Environ. Health B Crit. Rev. 21, 227–268. https://doi.org/
Kreibig, S.D., 2010. Autonomic nervous system activity in emotion: a review. Biol. 10.1080/10937404.2018.1505571.
Psychol. 84, 394–421. https://doi.org/10.1016/j.biopsycho.2010.03.010. Stigsdotter, U.K., Corazon, S.S., Sidenius, U., Kristiansen, J., Grahn, P., 2017. It is not all
Lai, D., Liu, Y., Liao, M., Yu, B., 2023. Effects of different tree layouts on outdoor thermal bad for the grey city – a crossover study on physiological and psychological
comfort of green space in summer Shanghai. Urban Clim. 47, 101398. https://doi. restoration in a forest and an urban environment. Health Place 46, 145–154. https://
org/10.1016/j.uclim.2022.101398. doi.org/10.1016/j.healthplace.2017.05.007.
Laird, N.M., Ware, J.H., 1982. Random-effects models for longitudinal data. Biometrics Sui, Y., Ettema, D., Helbich, M., 2022. Longitudinal associations between the
38, 963–974. https://doi.org/10.2307/2529876. neighborhood social, natural, and built environment and mental health: a systematic
Lanki, T., Siponen, T., Ojala, A., Korpela, K., Pennanen, A., Tiittanen, P., et al., 2017. review with meta-analyses. Health Place 77, 102893. https://doi.org/10.1016/j.
Acute effects of visits to urban green environments on cardiovascular physiology in healthplace.2022.102893.
women: a field experiment. Environ. Res. 159, 176–185. https://doi.org/10.1016/j. Tartarini, F., Schiavon, S., 2020. Pythermalcomfort: a Python package for thermal
envres.2017.07.039. comfort research. SoftwareX 12, 100578. https://doi.org/10.1016/j.
Lau, K.K.-L., Shi, Y., Ng, E.Y.-Y., 2019. Dynamic response of pedestrian thermal comfort softx.2020.100578.
under outdoor transient conditions. Int. J. Biometeorol. 63, 979–989. https://doi. Tu, R., Bai, Y., Xu, Y., Liang, Y., Xiao, Y., Yin, S., 2026a. Dose-response relationship
org/10.1007/s00484-019-01712-2. between green walking distance and pedestrians’ restorative outcomes: a pilot study
Lee, C., Park, A.H., Lee, H., Bratman, G.N., Hankey, S., Li, D., 2024. Measuring urban with microclimate measurements. Build. Environ. 290, 114124. https://doi.org/
nature for pedestrian health: systematic review and expert survey. Landsc. Urban 10.1016/j.buildenv.2025.114124.
Plan. 250, 105129. https://doi.org/10.1016/j.landurbplan.2024.105129. Tu, R., Xiao, Y., Huang, J., Zhou, J., Yin, S., Song, S., 2026b. Health effects of exposure to
Li, Z., Sun, Y., Song, J., Wang, Y., Wei, Y., 2026. Neurophysiological assessment of different urban walking environments: a systematic review and meta-analysis.
restorative benefits in forest-rural landscapes: EEG responses to real-world and J. Transp. Health 47, 102246. https://doi.org/10.1016/j.jth.2025.102246.
virtual environments. Environ. Impact Assess. Rev. 119, 108346. https://doi.org/ Ulrich, R.S., 1983. Aesthetic and affective response to natural environment. In:
10.1016/j.eiar.2026.108346. Altman, I., Wohlwill, J.F. (Eds.), Behavior and the Natural Environment. Springer
Lu, X., Tang, J., Zhu, P., Guo, F., Cai, J., Zhang, H., 2020. Spatial variations in pedestrian US, Boston, MA, pp. 85–125. https://doi.org/10.1007/978-1-4613-3539-9_4.
soundscape evaluation of traffic noise. Environ. Impact Assess. Rev. 83, 106399. Ulrich, R.S., Simons, R.F., Losito, B.D., Fiorito, E., Miles, M.A., Zelson, M., 1991. Stress
https://doi.org/10.1016/j.eiar.2020.106399. recovery during exposure to natural and urban environments. J. Environ. Psychol.
Luo, W., Chen, C., Li, H., Hou, Y., 2024. How do residential open spaces influence the 11, 201–230. https://doi.org/10.1016/S0272-4944(05)80184-7.
older adults’ emotions: a field experiment using wearable sensors. Landsc. Urban United Nations, 2024. Revision of World Population Prospects New York, NY, USA. http
Plan. 251, 105152. https://doi.org/10.1016/j.landurbplan.2024.105152. s://population.un.org/wpp/.
Ma, J., Lin, P., Williams, J., 2024. Effectiveness of nature-based walking interventions in Veeranki, Y.R., Rao, N.K., Posada-Quintero, H.F., Swaminathan, R., 2026. Recent trends
improving mental health in adults: a systematic review. Curr. Psychol. 43, in electrodermal activity signal processing and deep learning methods for emotion
9521–9539. https://doi.org/10.1007/s12144-023-05112-z. recognition. Neuroscience 602, 12–30. https://doi.org/10.1016/j.
Mahia, L., Berkouk, D., Bouzir, T.A.K., Pigliautile, I., Pisello, A.L., 2025a. Exploring the neuroscience.2026.03.009.
relationship between elderly women responses, multi-domain factors, and street Wang, Y., Chau, C.K., Ng, W.Y., Leung, T.M., 2016. A review on the effects of physical
geometry indicators: a case study in a Mediterranean context. Build. Environ. 273, built environment attributes on enhancing walking and cycling activity levels within
112647. https://doi.org/10.1016/j.buildenv.2025.112647. residential neighborhoods. Cities 50, 1–15. https://doi.org/10.1016/j.
Mahia, L., Berkouk, D., Bouzir, T.A.K., Pigliautile, I., Pisello, A.L., 2025b. Investigating cities.2015.08.004.
the relationship between spatial morphology, meteorological factors, and elderly Ware, J.E., Kosinski, M., Keller, S.D., 1996. A 12-item short-form health survey:
people well-being in a traditional algerian village. Sustain. Cities Soc. 121, 106212. construction of scales and preliminary tests of reliability and validity. Med. Care 34,
https://doi.org/10.1016/j.scs.2025.106212. 220–233. https://doi.org/10.1097/00005650-199603000-00003.
Markevych, I., Schoierer, J., Hartig, T., Chudnovsky, A., Hystad, P., Dzhambov, A.M., Watson, D., Clark, L.A., Tellegen, A., 1988. Development and validation of brief
et al., 2017. Exploring pathways linking greenspace to health: theoretical and measures of positive and negative affect: the PANAS scales. J. Personal. Soc. Psychol.
methodological guidance. Environ. Res. 158, 301–317. https://doi.org/10.1016/j. 54 (6), 1063–1070. https://doi.org/10.1037/0022-3514.54.6.1063.
envres.2017.06.028. World Health Organization, 2020. WHO guidelines on physical activity and sedentary
Mazumdar, S., Learnihan, V., Cochrane, T., Davey, R., 2018. The built environment and behaviour. Geneva, p. 93. https://www.who.int/publications/i/item/9789
social capital: a systematic review. Environ. Behav. 50, 119–158. https://doi.org/ 240015128.
10.1177/0013916516687343. World Health Organization, 2021. WHO Global Air Quality Guidelines: Particulate
Matter (PM2. 5 and PM10), Ozone, Nitrogen dioxide, Sulfur dioxide and Carbon
17

R. Tu et al. E n v i r o n m e n t a l I m p a c t A s s e s s m e n t R e v i e w 122 (2027) 108642
monoxide. World Health Organization. https://www.who.int/publications/i/item/ Xu, Z., Zheng, X., Ding, H., Zhang, D., Cheung, P.M., Yang, Z., et al., 2024. The effect of
9789240034228/. walking on depressive and anxiety symptoms: systematic review and meta-analysis.
World Health Organization, 2024. World health statistics 2024: monitoring health for the JMIR Public Health Surveill. 10, e48355. https://doi.org/10.2196/48355.
SDGs, sustainable development goals. Geneva, p. 86. https://www.who.int/publicati Zhang, Y., Liu, J., Zheng, Z., Fang, Z., Zhang, X., Gao, Y., et al., 2020. Analysis of thermal
ons/i/item/9789240094703. comfort during movement in a semi-open transition space. Energ. Buildings 225,
Xiang, L., Cai, M., Ren, C., Ng, E., 2021. Modeling pedestrian emotion in high-density 110312. https://doi.org/10.1016/j.enbuild.2020.110312.
cities using visual exposure and machine learning: tracking real-time physiology and Zhang, Z., Amegbor, P.M., Sigsgaard, T., Sabel, C.E., 2022. Assessing the association
psychology in Hong Kong. Build. Environ. 205, 108273. https://doi.org/10.1016/j. between urban features and human physiological stress response using wearable
buildenv.2021.108273. sensors in different urban contexts. Health Place 78, 102924. https://doi.org/
Xie, Y., Wang, X., Wen, J., Geng, Y., Yan, L., Liu, S., et al., 2022. Experimental study and 10.1016/j.healthplace.2022.102924.
theoretical discussion of dynamic outdoor thermal comfort in walking spaces: effect Zhao, H., Zhao, L., Ou, J., Meng, Q., Niu, J., Brown, R.D., 2026. Summer shading
of short-term thermal history. Build. Environ. 216, 109039. https://doi.org/ strategies for urban sidewalks: shade-layout control metrics oriented to pedestrian
10.1016/j.buildenv.2022.109039. whole-trip thermal comfort. Sustain. Cities Soc. 136, 107019. https://doi.org/
Xu, J., Liu, N., Polemiti, E., Garcia-Mondragon, L., Tang, J., Liu, X., et al., 2023. Effects of 10.1016/j.scs.2025.107019.
urban living environments on mental health in adults. Nat. Med. 29, 1456–1467.
https://doi.org/10.1038/s41591-023-02365-w.
18
Building and Environment 300 (2026) 114679
Contents lists available at ScienceDirect
Building and Environment
journal homepage: www.elsevier.com/locate/buildenv
Do we all feel the city the same way? A proof-of-concept framework linking
physiological wellbeing to neighborhood-scale resilience through
multi-domain environmental sensing
Christos Grapasa, Marcel Schweikerb,c , Anna Laura Piselloa,d,* ,
Ilaria Pigliautilea , Roberta Jacoby Cureaud
aEnvironmental Applied Physics Laboratory (EAPLAB), Interuniversity Research Centre on Pollution and Environment Mauro Felli (CIRIAF), University of Perugia, via
G. Duranti, 67, 06125 Perugia, Italy
bHealthy Living Spaces Lab, Institute for Occupational, Social and Environmental Medicine, Medical Faculty, RWTH Aachen University, Aachen, Germany
cChair of Healthy Living Spaces, Faculty of Architecture, RWTH Aachen University, Aachen, Germany
dEngineering Department, University of Perugia, via G. Duranti, 93, 06125 Perugia, Italy
A R T I C L E I N F O A B S T R A C T
Keywords: Outdoor comfort and climate adaptation studies usually focus on thermal-only investigations, typically relying
Human-urban resilience on straightforward heat stress metrics. Human-centered validation frameworks to confirm whether built envi-
Multi-domain comfort ronment interventions reduce actual physiological stress versus predicted discomfort from population-averaged
Human Centred digital twins
models still lack. To fill this gap, this proof-of-concept addresses three questions: (1) Do multi-domain envi-
Multisensory urban design
ronmental models explain physiological variance that thermal indices alone cannot capture? (2) Do individuals
Well-being
exhibit heterogeneous resilience to identical landscapes? (3) How can individual physiological data aggregate
Climate Change Adaptation
into neighborhood-scale resilience zones? Using synchronized wearable sensors (heart rate, electrodermal ac-
tivity) and multi-domain environmental monitoring (Universal Thermal Climate Index, Particulate Matter, CO₂,
Acoustic Spectrum), we tested eight participants through contrasting Roman urban typologies such as exposed
piazzas, tree-canopied riverbanks, enclosed gardens. Thermal comfort indices alone failed to predict stress, yet
multi-domain models integrating thermal, air quality, and acoustic parameters explained up to 43% of physio-
logical variance. Individuals with similar characteristics (age 28–38) and lifestyle exhibited markedly different
physiological responses to identical microclimates, suggesting that the city is not felt the same way by everyone,
and that population-averaged vulnerability models may not reliably predict individual-level stress outcomes. We
operationalized three resilience metrics: Toughness, Recovery Capacity, Adaptation Duration, derived through
generalized logistic growth modeling capturing nonlinear threshold dynamics in physiological stress responses.
K-means clustering identified five statistically distinct adaptation zones corresponding to landscape typologies,
demonstrating that individual wearable data enables neighborhood-scale resilience mapping. This framework
establishes a preliminary methodological infrastructure for integrating physiological sensing with urban digital
twins, enabling validation of whether landscape configurations reduce stress for inhabitants rather than relying
on demographic prediction alone.
1. Introduction 68% by 2050 [1], intensifying challenges in designing built environ-
ments that maintain thermal comfort, air quality, and acoustic perfor-
Urban areas house 55% of the world's population, projected to reach mance under changing climatic conditions. While initiatives like C40
Abbreviation:UTCI, Universal Thermal Climate Index; CCA, Climate Change Adaptation; T, Toughness; AC, Ability to Cope; RC, Recovery Capacity; PM, Par-
ticulate Matter; BPM, Beats per Minute; EDA, Electrodermal Activity; UAQI, Universal Air Quality Index; UHI, Urban Heat Island Effect; LST, Land Surface Tem-
perature; ART, Attention Restoration Theory; SRT, Stress Recovery Theory; GIS, Geographic Information System; IoT, Internet of Things; LOPO, Leave-One-
Participant-Out; CV, Coefficient of Variation; RMS, Root Mean Square.
* Corresponding author.
E-mail address: anna.pisello@unipg.it(A.L. Pisello).
https://doi.org/10.1016/j.buildenv.2026.114679
Received 4 December 2025; Received in revised form 2 April 2026; Accepted 29 April 2026
Available online 1 May 2026
0360-1323/© 2026 Published by Elsevier Ltd.

C. Grapas et al. B u i l d i n g a n d E n v i r o n m e n t 300 (2026) 114679
Cities [2] and the EU Covenant of Mayors [3] emphasize Climate Change individual-level physiological monitoring to validate whether in-
Adaptation (CCA) planning, current building science approaches lack terventions reduce measured stress for actual inhabitants. Our meth-
methods to validate whether environmental interventions actually odological contribution lies in integrating continuous multi-domain
reduce physiological stress for individual occupants versus predicted environmental sensing (thermal, acoustic, air quality) with
discomfort from population-averaged models. individual-level physiological monitoring to: (1) validate whether
Simplified threshold-based approaches, while scalable, cannot cap- multi-domain models predict acute stress responses significantly better
ture real-time physiological adaptation dynamics determining actual than single-domain thermal comfort indices, (2) quantify heterogeneous
health risk [4]. Emerging evidence shows that compound environmental resilience profiles among physically similar individuals, examining
stressors such as heat combined with air pollution and noise can produce whether person-specific physiological response patterns exist even after
interaction effects unpredictable from single-stressor models, necessi- controlling for environmental variation, and (3) develop a framework
tating integrated multi-domain approaches [5,6]. Structural equation for aggregating individual sensing data into neighborhood-scale resil-
modeling reveals that audio-visual interactions (β =0.57) of environ- ience zones that can inform spatially-targeted built environment
mental satisfaction, with thermal, acoustic, and visual domains oper- interventions.
ating through bidirectional sensory influences rather than independent This proof-of-concept study addresses a critical gap: the absence of
channels [7 ]. Yet conventional building design treats thermal condi- individualized physiological data in validating outdoor environmental
tioning, ventilation, and acoustic control as independent systems rather performance of built environments. Resilience operates across temporal
than synergistic determinants of occupant wellbeing. The resulting built scales. For example, dynamic recovery [21] quantifies acute physio-
environments may satisfy individual performance standards while logical restoration rates post-exposure, allostatic load (long--
failing to support actual physiological resilience, a contradiction unde- term-exposure [22]) captures cumulative regulatory system
tectable without measuring inhabitant stress responses. Multi-domain dysregulation, and adaptation time measures thermoregulatory stabili-
resilience operates through parallel analytical scales and physiological zation periods. While vulnerability assessments typically focus on
regulatory systems responding to different environmental stressors, extreme thermal conditions, we examine resilience under non-extreme
which interact synergistically rather than additively [8,9]. exposure where multisensory interventions can support physiological
Recent advances in wearable sensor integration with urban IoT restoration [23]. Three research questions guide this investigation. First,
networks enable continuous, synchronized collection of individual do multi-domain environmental models integrating thermal, acoustic,
physiological data alongside hyperlocal environmental conditions, and air quality parameters predict individual physiological stress re-
providing unprecedented resolution for linking personal stress responses sponses significantly better than single-domain thermal comfort
to specific urban microclimates [10]. Wearable technologies measuring indices? This question addresses whether the integrated sensing
heart rate and electrodermal activity (EDA) [11] transform climate approach provides superior explanatory power compared to conven-
resilience assessment by enabling real-time validation of design in- tional thermal-only assessment, validating the multi-domain frame-
terventions. In a recent study, researchers used EDA wristbands to track work's added value. Second, do individuals exhibit heterogeneous
students' skin conductance during math tasks under varying classroom resilience profiles to identical landscape conditions, challenging the
microclimates (temperature, CO2, PM). Higher CO2 and temperatures validity of demographic vulnerability assumptions in building perfor-
correlated with increased EDA features like Conductance Level (CL), mance assessment? This examines whether person-specific physiological
indicating stress; machine learning confirmed temperature and air response patterns exist even after controlling for environmental varia-
quality's role in physiological well-being and thermal comfort [12]. tion, establishing the necessity of individualized rather than
However, population-targeted urban sensing approaches perpetuate the population-averaged approaches. Third, how can neighborhood-scale
limitation of treating vulnerability as spatially uniform rather than resilience zones be identified through aggregated individual sensing
recognizing heterogeneous exposure risks across population subgroups data? This bridges from individual-level heterogeneity to spatial plan-
[13,14]. Landscape spatial patterns within 175-meter radius buffers ning applications, demonstrating how personalized physiological
exert greater influence on soundscape perception than on-site compo- monitoring can inform area-based intervention strategies. Using syn-
sition [15]. While urban morphology represents relatively fixed con- chronized wearable physiological sensors and multi-domain environ-
straints amenable to Geographical Information System (GIS)-based mental monitoring, we developed a framework integrating
thermal comfort modeling and soundscape mapping [16,17], human individual-level resilience metrics that can be aggregated to neighbor-
physiological adaptation remains highly flexible and individualized, hood scale, demonstrating how these insights inform human-centered
necessitating integration of population-scale landscape interventions urban digital twins and evidence-based multisensory design strategies
with person-scale physiological sensing. The present study advances [24] for the built environment [25].
beyond existing individual-level outdoor comfort research in three
critical dimensions. First, while recent walking experiments have suc- 2. Methodology
cessfully employed wearable sensors to measure physiological responses
to environmental sequences and demonstrated the restorative effects of This proof-of-concept framework examines individual physiological
green exposure [18], these studies typically focus on route-level or resilience to multi-domain environmental stressors through synchro-
scenario-level comparisons rather than quantifying individual-specific nized wearable sensing and hyperlocal monitoring during structured
resilience profiles across multiple environmental domains. Second, urban transect walks. Data collected during these walks were analyzed
although emerging frameworks integrate multi-domain urban features through four stages (Fig. 1): (1) correlation analysis quantifying re-
including visual, acoustic, and microclimatic variables to predict lationships between physiological indicators (heart rate, EDA) and
neighborhood-scale comfort indices using explainable AI [19]), these environmental parameters (thermal, acoustic, air quality domains) to
approaches aggregate population-level perceptual data rather than establish baseline associations and inter-individual variability; (2)
measuring individual physiological stress responses that determine generalized logistic growth modeling fitted to physiological time-series
actual health risk. Third, smartwatch-based interventions have demon- under single-domain and multi-domain (thermal + acoustic + air
strated behavioral nudging potential for thermal and acoustic comfort quality) configurations to compare explanatory power; (3) trans-
[20], yet these implementations assess perceived usefulness and formation of model parameters into three resilience metrics: Toughness
behavior change rather than validating whether interventions actually (resistance to stressors), Recovery Capacity (speed of baseline return),
reduce physiological stress burden as measured through dynamic re- and Adaptation Duration (stabilization period), operationalizing
covery or cumulative allostatic markers. No framework currently in- Schweiker's resilience framework [26]; and (4) K-means clustering on
tegrates continuous multi-domain environmental sensing with temporally-weighted, recovery-coupled environmental features to
2

C. Grapas et al. B u i l d i n g a n d E n v i r o n m e n t 300 (2026) 114679
Fig. 1. Methodology.
identify spatially distinct adaptation zones. This framework enables 2.1. Data collection
direct comparison of thermal-only versus integrated environmental
models, characterizes individual-specific adaptation profiles, and dem- 2.1.1. Experimental design
onstrates aggregation of personalized physiological data into Data collection took place through a multi-domain comfort walk,
neighborhood-scale resilience maps corresponding to measurable urban intentionally conducted during non-heatwave conditions, as existing
typologies. literature suggests that extreme heat often mask subtle multi-domain
effects and interactions between environmental factors, making
Fig. 2. Case study area and overview of the multi-domain comfort walk and key variables per domain retrieved during the experimental campaign.
3

C. Grapas et al. B u i l d i n g a n d E n v i r o n m e n t 300 (2026) 114679
humans less sensitive to non-thermal stimuli such as acoustics or visual 2.1.2. Environmental measures
[27–30]. During each session of the comfort walks, two researchers The wearable monitoring system was designed and developed at the
carried wearable environmental monitoring backpacks [31], while two University of Perugia as a backpack to ensure ergonomic comfort while
participants wore Empatica medical devices to measure heart rate, EDA, allowing comprehensive environmental data collection on a hyperlocal
and skin temperature [32]. Each session followed a structured route microclimate scale [31]. The backpacks housed a modular array of
(Fig. 2), where one participant and one researcher commenced their sensors, including a BME280 for air temperature (accuracy: ±1 ◦C),
walk from an area characterized by elevated thermal discomfort and relative humidity (±3 %), and atmospheric pressure (±0.25 %), a CV7-V
higher pollution levels, progressing toward an environment with more ultrasonic anemometer for wind velocity and direction, and an
favourable environmental conditions, while the other participant and upward-looking (sp-510-SS ) pyranometer for global solar radiation (±5
researcher walked in the opposite direction. The initial selection of %). It also featured a TDS0037 NDIR CO2 sensor and a PMS5003
transect start and end points (A and B in Fig. 2) was informed by Land laser-scattering particulate matter (PM) sensor for PM1.0, PM2.5, and
Surface Temperature (LST) data derived from Landsat 8 and the Uni- PM10. A NEO-M8 GPS unit was integrated to provide high-resolution
versal Air Quality Index (UAQI) obtained from the Google Air Quality spatial mapping of the collected data. The sensors were protected with
API. This methodological design facilitated the examination of spatio- custom 3D-printed ventilated enclosures, except for those requiring
temporal variations in environmental exposure and human perception direct exposure, ensuring accurate measurements. The control unit,
across distinct urban microclimates. powered by a rechargeable battery with over two hours of autonomy,
The one-hour lasting comfort walk was performed in Rome, Italy, wirelessly transmitted real-time data of 5 s frequency to a user-friendly
with a hot-summer Mediterranean climate (Csa) according to the dashboard accessible via Wi-Fi, making the system ideal for monitoring
Ko¨ppen climate classification [33] between July 1st and 2nd of 2024. dynamic urban environments. In addition to the above, two micro-
The " comfort walk" protocol [34,35] instructed participants to maintain phones were used to account for basic acoustic recordings such as
their natural, self-selected walking pace typical of urban pedestrian relative sound level and frequency. Zoom H1n compact stereo recorder
movement, without running or prolonged standing. All participants featuring a unidirectional condenser microphone was used in a 90◦XY
completed the one-hour route covering approximately 2.5 km under stereo format, ensuring directional sound capture with reduced side
researcher supervision to ensure comparable pacing. The starting and noise.
ending points of the transect are represented in Fig. 2. Point B, located in
St. Peter’s Square, Vatican City, is an open, highly exposed environment 2.1.3. Subjective measures
with minimal vegetation, with LST =43.9 ◦ C and UAQI=135.37, while Questionnaires administered at four urban settings (Points A, B, C, D)
Point A, situated at Ponte Cestio across the Tiber River, features a denser captured subjective comfort across thermal, air quality, and acoustic
and taller tree canopy, offering greater thermal buffering with LST=37.9 domains (Supplementary Materials, Table S1) Given limited sample size,
◦C and UAQI=126.40 on average during the previous week before the subjective data served as secondary validation for physiological obser-
experimental campaign. In the midpoint of the route participants vations rather than primary analytical endpoints. Perceived adaptive
crossed a garden fenced with brick walls of 4 m and dense vegetation capacity was assessed through standardized inquiry: "In case you would
(Fig. 2, Point C) and a ‘transitional space’ (Fig. 2, Point D) which in the experience exhaustion from extreme climate conditions, how accessible
case of this experiment was a ‘loggia: a room or gallery with one or more would you find suitable environments for thermal relief?" (5-point Likert
open sides, especially one that forms part of a house and has one side open to scale: not at all (0) to fully accessible (+5)). This metric quantified
the garden’ [36] to account for similar architectural typologies that are participants' perception of available thermal refuge options, tested for
often present in the case study area. correlation with measured physiological stress responses, and provided
The study participants comprised university students and academic insight into psychological modulation of physiological adaptation
personnel aged 28–38 years, representing diverse international back- (perceived control).
grounds. This sample was selected to ensure a relatively homogeneous
sample, excluding individuals from recognized vulnerable populations 2.2. Data processing
[37]. The narrow age range (28–38) and similar educational/occupa-
tional backgrounds minimize confounding from major demographic Universal Thermal Climate Index (UTCI) calculations were per-
factors, though residual variability from unmeasured covariates (sleep formed using the wearable sensor data combining air temperature,
quality, caffeine intake, recent stress exposure, menstrual cycle phase) relative humidity, solar radiation and wind speed and processed in Py-
remains a limitation of within-subject models. thon via the ‘pythermalcomfort’ library [38] with a metabolic rate of 1.3
Each session followed four phases. First, pre-walk preparation (~15 met (light walking activity) and clothing insulation of 0.36 clo (standard
min) included informed consent, wristband equipment, and walking for shorts and t-shirt attire) [39].
instructions. Second, stationary assessment periods (5–10 min) occurred The relative sound level in dBFS was calculated using the root mean
at Points A, B, C, D where participants paused within 5 m of the envi- square (RMS) of the audio signal, which measures its effective amplitude
ronmental backpack, acclimatized for 15 min, then completed ques- [40]. This value was then converted into a logarithmic scale relative to
tionnaires via their smartphones. Third, walk segments consisted of the maximum possible amplitude of the digital audio. A higher RMS
natural-pace walking with the researcher carrying the environmental value results in a dBFS level closer to zero, indicating a louder sound,
backpack maintaining ≤2 m proximity and continuous monitoring. while lower RMS values produce more negative dBFS levels, repre-
Fourth, session completion involved final questionnaires. Bidirectional senting quieter sounds. This approach provides a standardized way to
design enabled one pair to walk A→C→D→B while another walked assess and compare sound intensity in digital audio analysis. To enhance
B→C→D→A simultaneously. The two-day experimental period was the reliability of the analysis, data preprocessing includes outlier
designed as a proof-of-concept validation study to test whether multi- removal and signal smoothing. Outliers are identified using the Inter-
domain models predict physiological responses better than thermal quartile Range (IQR) method, where values falling below Q1 (cid:0) 1.5 ×
indices alone, and whether physically similar individuals exhibit het- IQR or above Q3 +1.5 ×IQR are considered extreme and excluded. This
erogeneous resilience profiles. The short timeframe enabled controlled procedure prevents anomalous values from skewing the analysis,
comparison across contrasting urban typologies under stable meteoro- ensuring a more accurate representation of the underlying trends. Next,
logical conditions, minimizing confounding variables for initial frame- time-series data is smoothed using a low-pass Butterworth filter to
work validation. reduce high-frequency noise, with a carefully chosen cutoff frequency
relative to the Nyquist frequency to preserve relevant trends [41]. This
filtering is crucial for accurate relevant peak detection and subsequent
4

C. Grapas et al. B u i l d i n g a n d E n v i r o n m e n t 300 (2026) 114679
modelling. Peaks in the data, which signify environmental stressors and
physiological responses, are then identified using prominence-based
algorithm [42] that detect significant changes in signal amplitude. The
detection process is governed by two key parameters: prominence,
which defines the minimum relative importance of a peak, and distance,
which sets the minimum time interval between successive peaks to avoid
redundant detections. This step ensures that only meaningful peaks,
corresponding to significant environmental or physiological events, are
included in the analysis.
2.3. Correlation analysis
Initial correlation analysis quantified bivariate relationships be-
tween physiological indicators (BPM, EDA) and environmental param-
eters across thermal, acoustic, and air quality domains. Pearson
correlation assessed linear relationships for normally distributed vari-
ables, while Spearman rank correlation captured monotonic associa-
tions for non-normal distributions [43]. This exploratory analysis
addressed two objectives: (1) establishing baseline
environmental-physiological associations, and (2) quantifying
inter-individual variability to justify subsequent resilience modeling. All
correlations were evaluated for statistical significance (p <0.05), with | Fig. 3. Generalized Logistic Growth Model of Human Physiological Resilience.
r| >0.2 serving as an exploratory screening threshold to identify po- The diagram illustrates how physiological responses (y-axis) change with
tential relationships warranting investigation through subsequent environmental stressors (x-axis), characterized by parameters A (baseline), K
generalized logistic growth modeling, consistent with similar (upper limit), B (growth rate, where 1/B =toughness), M (inflection point), and
individual-level studies reporting r = 0.15–0.20 as meaningful [44]. ν (shape parameter). Recovery capacity (1/B) ×ν) and adaptation duration are
This liberal threshold accounts for expected weak correlations in key resilience metrics quantifying the system's ability to respond and return to
equilibrium.
individual-level physiological data due to high inter-individual vari-
ability and complex regulatory mechanisms. The logistic growth models
(Section 2.4) and clustering analysis (Section 2.5) represent the primary nonlinear dynamics of human adaptation to stress and is expressed as:
analytical approaches where relationship strength is properly quantified (K (cid:0) A)
through R² and validated through statistical testing. y(x) = A + 1
(1 + e(cid:0)B(x(cid:0) M))ν
2.4. Logistic growth model for resilience dynamics
Where: y(x) is the physiological response as a function of environmental
stress; A is the lower asymptote, representing the baseline response
By combining signal processing techniques, peak detection, and
under normal conditions; K is the upper asymptote, representing the
nonlinear modelng, this study analyzes the adaptive physiological re-
physiological limit; B is the growth rate, quantifying sensitivity to
sponses of each participant to urban environmental stressors. The
changes in environmental stress; M is the inflection point, indicating the
generalized logistic growth function was selected to operationalize
stress level at which the response is most pronounced; and ν is a shape
Schweiker's theoretical resilience framework [26] through three key
parameter controlling the steepness and symmetry of the response
advantages over alternative approaches. We employed the generalized
curve.
logistic growth function [45,46] because it captures nonlinear threshold
To account for multi-domain relationships across multiple environ-
dynamics in physiological adaptation while providing mechanistically
interpretable parameters (B =sensitivity, M =threshold, ν =recovery mental domains [49,50] the general logistic growth function was
modified for the second part of this analysis as follows:
modulation) that can be extended to multi-domain stressor interactions
unlike linear models (Fig. 3). Critically, the model enables multi-domain (K(cid:0) A)
extension that preserves individual parameter interpretation while
y(x1 ,x2 )=A+
1
(1+Q⋅e(cid:0)(B1(x1(cid:0)M1)+B2(x2(cid:0)M2)))ν
revealing interaction effects, allowing quantification of how thermal
stress modulates air quality sensitivity, or how acoustic load influences
Where: y(x1,x2) represents physiological response as a function of two
thermal adaptation capacity, through coupled environmental terms
environmental variables pertaining to different environmental domains,
rather than forcing additive assumptions. This mathematical frame- e.g., CO₂ concentration (x1) and sound level (x2); A and K are the lower
work, originally developed by Richards in 1959 to model plant growth
and upper limits of the physiological response; B1 and B2 are growth
rates and later widely applied in ecological modelling [46], operation-
rates relative to each environmental stressor; M1 and M2 are inflection
alizes parameters that can be derived from empirical physiological time
points (threshold values where significant physiological signal changes
series, compared across individuals to quantify inter-personal resilience
occur, for each environmental stressor); and Q is an asymmetry factor.
differences, and aggregated to neighborhood scales to map spatial pat-
The fitted parameters of the function such as A (lower asymptote), K
terns in collective adaptation capacity. Specifically, with particular (upper asymptote), B (growth rate), M (inflection point), and ν (shape
emphasis on how fluctuations in air temperature, air quality, and noise
parameter), are used to derive three key resilience metrics: toughness
levels affect BPM and EDA [47,48], the human response to increases or
(T), capacity to recover (RC), and ability to cope (AC) (Table 1). The
decreases in environmental stress can be modeled to reveal how multi-
fitting parameters and resilience metrics were first calculated for a
ple stressors simultaneously affect distinct physiological systems such as
reference participant to illustrate the general logistic growth model. To
thermoregulation and autonomic stress response, which interact syner-
evaluate collective physiological resilience, the study then applied the
gistically rather than independently.
same analytical approach across multiple participants. This process
To model the relationship between a single environmental stressor allowed for a systematic assessment of the multi-domain model’s per-
and physiological responses, a generalized logistic growth function as
formance and the categorization of resilience parameters into distinct
mentioned by Schweiker [26] is employed. This model captures the
5

C. Grapas et al. B u i l d i n g a n d E n v i r o n m e n t 300 (2026) 114679
Table 1
Resilience Metrics calculated from the fitting parameters of the general logistic growth function for both single and multi-domain approach.
Resilience Metric Definition Formula
Toughness (T) Toughness quantifies the resistance of the system to change and is inversely proportional to the growth rate (B). τ =1 / B
Recovery Capacity (RC) Recovery capacity combines resistance (τ) with the shape parameter (ν) to describe the ability of the system to recover from RC =ν τ =ν /
stress. B
Adaptation Duration or Ability to The duration of the ability to cope is determined as the time difference (Δt =t₉₅ % - tpeak) between the occurrence of the first Δt =t₉₅ % -
Cope (AC) peak in physiological response and the point where the response reaches 95% of the asymptotic range between the lower tpeak
asymptote (A) and upper asymptote (K). This approach assumes the complete development of ability to cope, which was
ensured in our experimental design as participants' behaviour was controlled, preventing adaptive actions such as hydration or
clothing adjustments that might otherwise truncate the thermal stress response before reaching upper asymptotic levels.
groups. systematically excluding each participant, with stability assessed
These resilience metrics (Table 1) provide mechanistic links between through the range of LOPO mean predictions (<0.15 considered robust)
environmental design and physiological outcomes, operationalizing [53]. Coefficient of variation (CV) was calculated for full sample and
Schweiker's [26] three-phase resilience framework. Toughness (T = each LOPO iteration to confirm heterogeneity (CV>50%) persisted
1/B) quantifies resistance to initial environmental stress, describing how across participant subsets. R² values represent within-participant model
slowly physiological responses escalate as stressors increase. Higher fit, not population-level variance. This individual-specific approach was
toughness values indicate individuals who maintain baseline function required to: (1) quantify individual heterogeneity (our primary research
despite rising thermal stress requiring fewer immediate interventions. question), (2) extract mechanistically interpretable resilience metrics
However, excessive toughness may delay recognition of accumulating (Toughness = 1/B and Recovery Capacity = ν/B) from
strain, particularly in vulnerable populations who may report thermal participant-specific parameters, and (3) avoid unstable nonlinear
conditions as acceptable despite associated health risks [51]. Recovery mixed-effects estimation with limited sample size (n = 8). The
Capacity (RC = ν/B) measures the speed of return to homeostatic within-subject modeling inherently accounts for repeated measures
equilibrium after peak stress exposure ends. This metric directly informs clustering.
urban cooling infrastructure design: populations with low recovery ca-
pacity require more frequent spatial access to thermal refuges, as they 2.5. Individual spatial resilience analysis and adaptation zone
cannot efficiently restore physiological equilibrium between exposures. classification
Adaptation Duration (AC =t₉₅ % - tpeak) quantifies the time required for
physiological stabilization after stress peaks, representing what We performed K-means clustering on T/RC/R²-weighted environ-
Schweiker describes as the "ability to cope" phase. This metric estab- mental features to identify spatial resilience zones, as our normalized
lishes minimum exposure thresholds for intervention effectiveness. If composite features exhibit compact distributions suitable for this
cool spots or green spaces provide relief periods shorter than an in- approach rather than requiring density-based methods. Each environ-
dividual's adaptation duration, the physiological system cannot com- mental feature was assigned a weight proportional to its temporal
plete its recovery process, leaving residual strain that accumulates contribution (T), recovery coupling (RC), and explained variance (R²),
across repeated exposures. Critically, these person-specific metrics derived from prior model evaluation. For each domain (air, acoustic,
enable identification of low-resilience individuals who may be missed by thermal), normalized composite weights were computed as:
demographic vulnerability indices, while simultaneously aggregating to (cid:0) )
n
[5
e
2
ig
]
h
.
borhood scales for spatial mapping of collective adaptive capacity wi =∑ T (cid:0)
T
i +
+
R
R
C
C
i +
+
R2 i
R2
)
Single-domain models (5 parameters: A, K, B, M, ν) tested seven
environmental predictors independently: UTCI, CO₂, average PM, Where: Tᵢ represents the temporal persistence of the environmental
signal; RCᵢ denotes its coupling with recovery capacity; and R²ᵢ quan-
overall sound level (dBFS), and three frequency-specific acoustic mea-
sures (low-frequency: <500 Hz representing traffic and mechanical tifies its explanatory strength within the environmental–physiological
noise; mid-frequency: 500–2000 Hz capturing human voices and urban model. The numerator therefore reflects the combined influence of
activity; high-frequency: >2000 Hz indicating birds, wind, and high- temporal relevance and physiological linkage, while normalization by
the summed contributions across all domains ensures that weights sum
pitched mechanical sounds). Multi-domain models (8 parameters: A,
K, B₁, B₂, M₁, M₂, Q, ν) tested eleven pairwise combinations: UTCI paired to one. These weights were then used to scale each standardized envi-
with CO₂, PM, and each acoustic frequency band; CO₂ paired with each ronmental variable, producing empirically grounded composite multi-
domain features prior to clustering. All variables were z-score normal-
acoustic frequency band; and PM paired with each acoustic frequency
ized prior to analysis. Cluster validity was evaluated across k = 2–9
band. Each configuration was fitted separately for BPM and EDA across
all participants, with only models achieving R² > 0.20 reported in using silhouette coefficient (measuring within-cluster cohesion versus
Tables 4–5. between-cluster separation) and Calinski–Harabasz index (ratio of
between-cluster to within-cluster variance). The optimal k was selected
Generalized logistic growth models were fitted as within-participant
balancing compactness and interpretability. Post-clustering stability
models to account for repeated measurements collected during each
was assessed through bootstrap resampling: 1000 iterations of sampling
individual's transect walk (multiple time points per participant across
with replacement, refitting K-means models, and calculating the per-
varying environmental exposures). Models were then fitted indepen-
centage of iterations each observation was assigned to its modal cluster.
dently for each participant using nonlinear least squares optimization.
Post-clustering, the resilience index, a normalized indicator of the
This participant-specific approach enabled individual heterogeneity
adaptation metrics calculated (Section 2.4) and the average physiolog-
quantification as required by the theoretical framework, while the small
sample size (n = 8) precluded reliable mixed-effects modeling across ical stress deriving from HR and EDA data entries were compared across
zones using one-way ANOVA. Zones were then ranked by mean resil-
participants. Model performance was assessed through adjusted R² ac-
ience to represent a gradient from optimal adaptive environments to
counting for differing predictor numbers between single-domain (5 pa-
low-capacity, personalized stress-prone zones.
rameters) and multi-domain (8 parameters) configurations. Leave-one-
participant-out (LOPO) validation ensured findings were not driven by
outliers. We recalculated R² values and resilience metrics after
6

C. Grapas et al. B u i l d i n g a n d E n v i r o n m e n t 300 (2026) 114679
3. Results 0.53 to r =0.98 across all participants. However, other environmental
parameters demonstrated notable variability in their associations. Hu-
The design of the transect route was subsequently validated using midity exhibited inconsistent correlations, ranging from moderately
subjective comfort vote data. Point A was characterized as warm and negative (r = (cid:0) 0.49) to slightly positive (r = 0.22), suggesting that
humid based on thermal sensation metrics and was perceived as slightly contextual factors may modulate its influence on UTCI. Particularly
to extremely uncomfortable in terms of thermal and air quality condi- noteworthy were the divergent correlations with air quality parameters.
tions by 87.5% of participants. In contrast, Point B exhibited similar While some participants UTCI showed strong positive correlations with
warm and humid conditions but was reported as thermally more un- PM (e.g., Participant 3: r ≈0.60–0.66), others demonstrated moderate
comfortable by 62.5% of participants. During each session, thermal negative correlations (e.g., Participant 4: r ≈ (cid:0) 0.31 to (cid:0) 0.35). BPM
conditions were monitored through UTCI readings, ranging from 24.84 correlations revealed marked individual differences in physiological
±0.88 ◦C to 30.20 ±0.67 ◦C. Physiological responses were tracked via responses to environmental stimuli.
heart rate (BPM: 86.93 ±13.24 to 100.61 ±16.64 bpm) and EDA (2.82 Relative sound levels demonstrated reliably negative associations
± 1.04 to 47.08 ± 17.91 µS). Environmental quality parameters with BPM (r =(cid:0) 0.28 to (cid:0) 0.45). Moreover, the relationship between air
included PM measurements at three levels (PM1.0: 4.25–13.70 μg/m³, quality metrics and heart rate varied substantially between participants,
PM2.5: 7.02–16.69 μg/m³, PM10: 6.91–17.28 μg/m³), carbon dioxide with both positive and negative correlations observed. EDA demon-
levels (354.39–438.31 ppm), and solar radiation via pyranometer strated the highest degree of inter-individual variability among the
readings (0.04–1704.91 W/m²). Acoustic environment was character- measured physiological parameters. Temperature correlations ranged
ized through sound level measurements ((cid:0) 59.37 to (cid:0) 61.36 dBFS) and from moderately positive (r =0.42) to negative (r =(cid:0) 0.29). Humidity
frequency analysis across low, mid, and high ranges. Local microclimate showed relatively consistent correlations with EDA. Particulate matter
conditions comprised temperature (25.46–30.04 ◦C) and relative hu- correlations were inconsistent, indicating that air quality may not have a
midity (49.17–52.18 %RH) readings. uniform influence on electrodermal activity across individuals. A
consistent negative correlation emerges between adaptation access and
various physiological and environmental variables. Specifically, partic-
3.1. Preliminary correlation analysis
ipants who perceived easier access to spaces for heat stress relief,
assessed at different points of interest (A, B, C, D), tended to exhibit
Correlation analysis was conducted for each participant individually,
lower BPM. The strongest negative correlations are observed with BPM,
examining relationships between target variables (UTCI, BPM, and EDA) averaging (cid:0) 0.44, with this effect being most pronounced in 4 out of 8
and environmental parameters across all domains (thermal, acoustic, air
participants (Fig. 4). This trend suggests that improved adaptation ac-
quality), one physiological parameter (skin temperature), and one sub-
cess may help reduce physiological responses, as indicated by negative
jective measure (perceived adaptation access). The analysis demon- correlations with BPM ((cid:0) 0.29 to (cid:0) 0.44) and EDA ((cid:0) 0.44 to (cid:0) 0.20).
strated varying degrees of association with environmental factors,
These physiological changes likely reflect both direct environmental
suggesting predominantly individualized response patterns with a few
effects and significant psychological components, including higher
consistent correlations observed across multiple participants (Fig. 4).
perceived levels of control and reduced perceived heat risk when
Specifically, as expected, UTCI exhibited the most consistent relation-
adaptation options such as accessible heat shelters are available [54].
ship with air temperature, with correlation coefficients ranging from r =
Fig. 4. Average and individual correlation coefficients of physiological responses (BPM and EDA) and UTCI to multiple environmental stressors during the
experimental campaign. Annotated correlations indicate key values discussed in text: UTCI-air temperature, UTCI-humidity, UTCI-particulate matter for Participant 3
and Participant 4, BPM-sound level, BPM-adaptation access for 4 participants, EDA-air temperature, and EDA-adaptation access. Bubble size represents correlation
magnitude; color indicates direction (red =positive, blue =negative) and marked are the key data discussed within Section 4.1.
7

C. Grapas et al. B u i l d i n g a n d E n v i r o n m e n t 300 (2026) 114679
This variability suggests physiological stress is modulated by factors higher recovery capacity (1.498), indicating greater physiological
beyond single-domain conditions and demographic categories alone. sensitivity but enhanced resilience over time. The combination of CO₂
This highlights the limitations of current approaches and highlights the with acoustic stressors reveals also interesting patterns. When CO₂ is
need for a more comprehensive framework to accurately quantify paired with high-frequency sounds, the model predicts moderate
human vulnerability to the combined effects of multiple environmental toughness (0.099) and high recovery capacity (1.469), suggesting that
stressors. this multi-domain interaction initially challenges physiological stability
but allows for robust recovery. However, with mid-frequency sounds,
3.2. Single domain approach the same CO₂ levels yield a lower recovery capacity (0.278), indicating
frequency-specific physiological responses that would be missed in
Taking as an example a random reference participant, in single- single-domain analyses. Particularly noteworthy is the average PM
domain analysis (Fig. 5), environmental variables such as CO₂ concen- interaction with high-frequency sounds, which shows the highest
tration, sound levels, and average particulate matter concentration toughness (0.259) and recovery capacity (3.348) values among all
display varying degrees of impact on heart rate, as reflected by tough- combinations. This finding indicates that this pairing creates a more
ness, recovery capacity, and adaptation duration summarized in Table 2. resilient physiological response compared to other environmental
Single-domain analysis revealed variable resilience patterns: CO₂ combinations, potentially indicating an adaptive combined effect
showed moderate toughness (0.212) with good recovery (0.794), while unique to this pairing.
PM exhibited lower toughness (0.129) with no recovery capacity. Surface plots from these models reveal how heart rate responds to
Acoustic stressors demonstrated frequency-dependent responses combined environmental stressors (Fig. 6). The R² values vary consid-
(Table 2). These results indicate that different environmental factors erably (0.036–0.345), indicating that different environmental pairings
affect physiological responses through distinct resilience patterns. Mid affect physiology in distinct ways. UTCI emerges as the dominant
and high-frequency sounds have the most consistent impact on this modulator across most interactions. The strongest predictor of physio-
participant (R² =0.13 and 0.18 respectively), suggesting that auditory logical response is the UTCI–particulate matter pairing (R² = 0.345).
stimuli may be a key determinant of physiological stress. Notably, UTCI, Temperature–PM interactions (R² =0.34) show poor initial tolerance (T
low-frequency sounds and relative sound level measurements did not =0.010) but moderate recovery (RC =0.160), suggesting adaptive ca-
produce reliable resilience models for this participant, indicating a lack pacity despite vulnerability. In contrast, temperature–CO₂ pairing
of direct physiological response to these variables using the single- demonstrates strong initial resistance (T =0.294) but complete recovery
domain approach. failure, indicating a brittle response under prolonged exposure. In-
teractions involving high-frequency sound show notably robust recov-
ery: CO₂–sound pairings achieve RC = 1.469 with T = 0.099, while
3.3. Multi-domain approach
PM–sound interactions produce the most resilient profile overall (T =
0.259; RC =3.348).
Taking the same reference participant as an example for our multi-
domain model (Table 3), when UTCI is paired with CO₂ concentration, The relatively high R² values for CO₂ paired with sound frequencies
(0.238, 0.210, 0.117) compared to UTCI with sound frequencies (0.036,
BPM response shows relatively high toughness (0.294) but zero recovery
0.077, 0.191) suggest that CO₂ may have more consistent interactive
capacity, suggesting that while this combination resists initial changes
effects with acoustic stressors than thermal conditions do. This profile
in heart rate, it severely compromises the system's ability to recover.
suggests the participant may function best in environments where PM
This pairing represents a form of multi-domain overload where the
levels and acoustic factors are carefully managed, as these combinations
thermoregulatory system maintains initial stability but cannot adapt
trigger their most resilient physiological responses, while showing
over time. In contrast, when UTCI interacts with average low frequency
greater vulnerability to thermal-CO₂ interactions despite initial
sounds, we observe a much lower toughness (0.098) but significantly
Fig. 5. Resilience Analysis of Physiological Response for the reference participant. Time series (top) and logistic growth modelling (bottom) of BPM responses to
environmental stimuli. Peaks indicate stress events.
8

C. Grapas et al.                                                                                                                                                                                             B  u  i l d i n  g    a n  d    E  n  v i r o  n  m   e n  t 300 (2026) 114679
Table 2
Resilience metrics – single domain analysis for the reference participant.
| Variable        | T RC      | AC   | R2 A       | K     | B    | M ν         |
| --------------- | --------- | ---- | ---------- | ----- | ---- | ----------- |
| UTCI            | - -       | -    | - -        | -     | -    | - -         |
| CO₂             | 0.21 0.79 | 39   | 0.18 11.44 | 16.42 | 4.72 | 357.31 3.75 |
| PM              | 0.12 0    | 59.5 | 0.06 14.40 | 16.80 | 7.77 | 17.90 0     |
| Sound Level     | - -       | -    | - -        | -     | -    | - -         |
| Low freq Sounds | - -       | -    | - -        | -     | -    | - -         |
Mid freq Sounds 0.13 0.73 42.83 0.12 18.34 14.36 7.46 (cid:0) 1.52 5.47
Hight freq Sounds 0.18 0.45 42.50 0.16 16.68 13.78 5.44 (cid:0) 25.49 2.47
Note: The relationship between various environmental stressors and human resilience, as measured by Toughness (T), Recovery Capacity (RC), and Ability to Cope
(AC) in relation to the selected participant' BPM. Each variable's resilience metrics are summarized alongside the R² value, indicating the goodness of fit for the model,
and the fitting parameters (A, K, B, M, ν), which describe the underlying mathematical model. Note: Dashes (-) indicate where values were not available or were
extremely large, indicating overfitting or lack of direct response.
Table 3
Resilience metrics – multi-domain analysis for the reference participant.
| Domains     | T RC   | AC R²      | A K     | B1 B2   | M1 M2     | Q Nu |
| ----------- | ------ | ---------- | ------- | ------- | --------- | ---- |
| UTCI vs CO2 | 0.29 0 | 61.33 0.19 | - 87.62 | 3.396 0 | 0.38 0.43 | 0 0  |
UTCI vs PM 0.01 0.16 61.33 0.34 91.01 114.62 0 99.94 0 0.73 15.96 0.05
UTCI vs Low f Sounds 0.09 1.49 61.33 0.03 92.60 102.29 0 10.25 0.53 0.62 15.36 2.09
UTCI vs Mid f Sounds 0.01 0.09 61.33 0.07 92.16 100.91 0 52.21 0.51 0.37 4.90 0.01
UTCI vs High f Sounds 0.29 0 61.33 0.19 - 86.99 3.19 0.23 0.29 0.33 0 0.02
CO2 vs Low f Sounds 0.01 0.75 61.16 0.23 91.28 116.56 0 54.95 0.69 0.47 41.25 0
CO2 vs Mid f Sounds 0.07 0.27 61.16 0.21 82.27 121.10 0.90 13.03 0.97 0.79 3.87 3.17
CO2 vs High f Sounds 0.25 3.34 59.66 0.13 88.07 138.62 0 3.85 0.52 0.53 12.90 1.53
PM vs avg_low_freq 0.19 2.42 59.66 0.09 87.04 121.31 0 5.22 0.56 0.57 12.68 1.98
PM vs avg_mid_freq 0.21 1.91 59.66 0.16 82.10 122.87 0 4.56 0.55 0.56 8.71 2.48
PM vs avg_high_freq 0.25 3.34 59.66 0.13 88.07 138.62 0n 3.85 0.52 0.53 12.90 1.53
Note: The relationship between various environmental stressors and human resilience, as measured by Toughness (T), Recovery Capacity (RC), and Ability to Cope
(AC) in relation to the selected participants' BPM (beats per minute). Each variable's resilience metrics are summarized alongside the R-squared value, indicating the
goodness of fit for the model, and the fitting parameters (A, K, B, M, ν), which describe the underlying mathematical model.
Fig. 6. Three-dimensional response surfaces showing heart rate (BPM) as a function of paired environmental stressors for the reference participant. Surfaces fitted
using generalized logistic growth models; scatter points represent observed data.
9

C. Grapas et al. B u i l d i n g a n d E n v i r o n m e n t 300 (2026) 114679
resistance to these stressors. This finding highlights the importance of 0.405, acoustic stress, mean BPM=101.9). Fig. 7visualizes this multi-
considering also environmental pairings beyond thermal comfort in scale resilience framework. The top-left panel shows contrasting heart
multi-domain comfort assessment. rate trajectories with stable toughness (T ≈0.055) but variable recovery
capacity (RC=0.283 vs 0.957), validating T as an individual trait and RC
as environmentally sensitive. Red trajectory (Point D, Zone 5) shows
3.4. Personalized adaptation zone classification
dysregulated elevation; blue trajectory (Point C) shows homeostatic
recovery. The top-right panel confirms within-individual variation (T
Using 164 multi-domain observations, we applied k-means clus- range=0.001, RC range=0.257) across all zones. The bottom panel
tering to five T/RC/R²-weighted environmental features (weighted_air, presents the 3D spatial map with zones ranked by resilience (1 >2 >3 >
weighted_acoustic, weighted_thermal, UTCI ×PM, CO₂ ×low-freq, CO₂ 4 >5). Zone 5′s elevated heart rate reflects dysregulated stress responses
× mid-freq), integrating each domain's temporal persistence (T), re-
where resilience measures regulatory control and recovery efficiency,
covery coupling (RC), and explanatory strength (R²). Cluster validation
not activation magnitude. Within-individual comparison validated the
confirmed a stable five-zone solution (Silhouette = 0.42; Cal- person-environment model: toughness remained stable (range=0.001),
inski–Harabasz =60.4), ranked by resilience from Zone 1 (R =0.657, while recovery capacity varied substantially (range=0.257). Two
balanced conditions: CO₂=426 ppm, UTCI=30.1 ◦C) to Zone 5 (R =
Fig. 7. Environmental and physiological resilience across clustered zones (k =5).
Multi-scale resilience framework integrating spatial and temporal dynamics.
10

C. Grapas et al. B u i l d i n g a n d E n v i r o n m e n t 300 (2026) 114679
Table 4
An overview of the influence of environmental domain pairs on the resilience metrics across all the participants tested.
Domain Pair Participants with Significant Model Average R² (±SD) T (Avg ±SD) RC (Avg ±SD) AC (Avg ±SD)
UTCI & PM 4/8 0.40 ±0.25 0.01 ±0 0.06 ±0.07 62.92 ±11.65
UTCI & CO₂ 4/8 0.20 ±0.18 0.12 ±0.13 0 ±0 62.92 ±10.97
CO₂ & High Freq Sounds 6/8 0.32 ±0.13 0.05 ±0.03 0.36 ±0.55 63.40 ±10.26
PM & High Freq Sounds 8/8 0.22 ±0.09 0.07 ±0.08 0.59 ±1.19 61.71 ±9.58
CO₂ & Low Freq Sounds 6/8 0.26 ±0.13 0.03 ±0.02 0.21 ±0.27 63.20 ±9.89
CO₂ & Mid Freq Sounds 6/8 0.25 ±0.13 0.04 ±0.03 0.18 ±0.16 63.20 ±9.89
PM & Low Freq Sounds 7/8 0.23 ±0.15 0.05 ±0.06 0.47 ±0.90 62.70 ±9.34
Note: The pairs depicted in this table are those with R² values exceeding 0.2, representing a minimum threshold of statistical importance in explaining variance in BPM regulation.
Table 5
An overview of the influence of environmental domain pairs on the resilience metrics across all the participants tested.
Domain Pair Participants with Significant Model Average R² (±SD) T (Avg ±SD) RC (Avg ±SD) AC (Avg ±SD)
UTCI & PM 5/8 0.43 ±0.20 0.05 ±0.04 0.16 ±0.20 61.66 ±11.05
UTCI & CO₂ 5/8 0.32 ±0.22 0.05 ±0.04 0.14 ±0.15 61.66 ±11.05
CO₂ & High Freq Sounds 8/8 0.21 ±0.12 0.06 ±0.08 0.09 ±0.23 63.62 ±9.75
PM & High Freq Sounds 8/8 0.21 ±0.17 0.03 ±0.01 0.14 ±0.25 63.12 ±9.04
CO₂ & Low Freq Sounds 8/8 0.25 ±0.15 0.09 ±0.14 0.25 ±0.59 63.62 ±9.75
CO₂ & Mid Freq Sounds 8/8 0.25 ±0.14 0.05 ±0.04 0.12 ±0.19 63.62 ±9.75
PM & Mid Freq Sounds 8/8 0.20 ±0.21 0.02 ±0.01 0.13 ±0.23 63.12 ±9.04
Note: The pairs depicted in this table are those with R² values exceeding 0.2, representing a minimum threshold of statistical importance in explaining variance on
EDA.
consecutive trajectories illustrate this: high-recovery (Point C, consistent relationships with acoustic stressors across all participants,
RC=0.957) showed efficient baseline return (90→70 BPM), while low- though with varying strengths. The sound frequency pairings with CO₂
recovery (Point D, Zone 5, RC=0.283) showed sustained elevation and PM demonstrate universal significance across all participants for
(100–107 BPM) despite similar toughness. Environmental quality EDA (8/8 participants for all frequency ranges), suggesting that these
modulates adaptive responses through recovery mechanisms, with environmental combinations reliably trigger electrodermal responses
urban microenvironments directly shaping physiological regulation regardless of individual differences. The PM-low frequency sound
capacity. combination shows particularly high recovery capacity for EDA (0.894),
indicating robust adaptation potential for this specific environmental
pairing. This dual-measure approach reveals complementary aspects of
3.5. Multi-domain collective resilience
human physiological adaptation to multi-domain environmental
stressors, with cardiovascular responses (BPM) showing strongest cor-
The following section presents the results of this multi-domain
relations to UTCI-PM interactions, while electrodermal responses (EDA)
assessment, highlighting patterns and differences in physiological re-
demonstrate stronger associations with both thermal-air quality and
sponses among all the participants aiming to summarize the resilience
thermal-acoustic domain pairs. These findings highlight the importance
metrics collectively. Findings reveal that the combination of PM con-
of considering integrated multi-domain environmental quality assess-
centration with high frequency sounds shows the most consistent re-
lationships to BPM (present in all 8/8 participants, R² = 0.220) ments aligned with recent studies supported by crowdsourced data on
human perception.
(Table 4), while the pairing of UTCI with PM produces the highest
Leave-one-participant-out (LOPO) validation confirmed robustness
average R² (0.400 across 4/8 participants). These relationships
of these multi-domain relationships (Supplementary Table S2). Multi-
demonstrate varying resilience patterns: the UTCI-PM domain pairing
domain superiority persisted across all iterations. For heart rate re-
shows relatively low toughness (0.016) but measurable recovery ca-
pacity (0.066), while CO₂ paired with high frequency sounds shows sponses, five of seven domain pairs (71 %) showed LOPO stability <0.15
(meaning the predictive strength remained consistent when each
more moderate toughness (0.057) and higher recovery capacity (0.369)
participant was systematically excluded, considered robust for this
with an R² of 0.323 observed in 6/8 participants. This finding suggests
study), with PM-acoustic combinations demonstrating particularly
that environmental variables influence human physiological responses
robust findings (stability: 0.03–0.06) and CO₂-acoustic pairings showing
through different mechanisms, with thermal domain (UTCI) playing a
consistent predictive power (stability: 0.11–0.12). EDA demonstrated
central moderating role in the most significant relationships.
higher between-participant variability, with UTCI-PM (stability: 0.18)
While BPM demonstrates robust relationships with multiple envi-
ronmental domains, particularly when UTCI interacts with PM (R² = and UTCI-CO₂ (stability: 0.19) showing moderate variability, yet both
0.400) and when CO₂ interacts with sound frequencies (R² =0.323 for EDA domain pairs still substantially outperformed single-domain ther-
mal models.
high frequency), EDA exhibits even stronger associations (Table 5),
To justify the heterogeneity finding statistically, we ran Kruskal-
especially with thermal-air quality domains. For EDA, the UTCI-PM
Wallis tests across all 18,815 observations. Both BPM (H =1358.1, p
pairing exhibits the highest average R² (0.434 across 5/8 participants)
<0.001) and EDA (H =13,937.7, p <0.001) showed significant dif-
with moderate toughness (0.055) and recovery capacity (0.168). Simi-
larly, the UTCI-CO₂ combination shows meaningful correlations (R² = ferences between participants. EDA means ranged from 2.68 to 44.18 µS
0.328) with comparable resilience metrics (toughness =0.050, recovery (CV=89.6 %), and Cohen's d reached 0.96 for BPM and 3.15 for EDA,
capacity =0.145). This differential response pattern suggests a hierar- both large effects (Table S3). Crucially, these differences persisted even
when comparing participants within the same CO₂ exposure range
chical physiological adaptation mechanism in outdoor environments,
(330–450 ppm), where individual mean BPM still spanned 89.1–100.9
where EDA appears particularly attuned to thermal and air quality pa-
bpm. This suggests the differences reflect actual physiological variability
rameters, showing higher correlation strengths than cardiovascular re-
between individuals, not differences in environmental exposure. These
sponses for these specific domain pairs.
effect sizes are consistent with literature showing that individual
Notably, both physiological measures (BPM and EDA) show
11

C. Grapas et al. B u i l d i n g a n d E n v i r o n m e n t 300 (2026) 114679
variability in thermal comfort is on the order of 3◦C in neutral temper- temperature-PM combination producing high toughness (T =0.294) but
ature, often comparable or exceeding reported differences between de- zero recovery in one participant generated low toughness (T =0.010)
mographic groups [55]. with moderate recovery (RC=0.160) in another. To check whether
findings depend on a single day's conditions, we stratified analyses by
4. Discussion session (Table S4). The two days differed slightly. Day 2 was approxi-
mately 2.7 ◦C cooler with lower PM2.5 but CO₂ exposure was compa-
4.1. Multi-Domain environmental interactions override single-stressor rable and both days fell within the same UTCI range. Physiological
predictions heterogeneity was statistically significant within each day indepen-
dently, confirming the finding is not an artifact of either day's specific
Vulnerability is not a static spatial pattern: it varies across in- conditions. While this small-sample observation cannot validate
dividuals, across time of day, and across sensory combinations, a fact whether demographic categorization fails broadly, it demonstrates that
that aggregate indices obscure and that only person-scale physiological at least within this homogeneous group, population-averaged assump-
monitoring can recover. Our findings confirm the multi-domain frame- tions did not predict individual stress responses, supporting the rationale
work's explanatory superiority established in the results. This challenges for personalized physiological monitoring in larger validation studies.
Attention Restoration Theory (ART) and Stress Recovery Theory (SRT), While GIS-based modeling remains essential for spatial patterns [16,17],
which traditionally emphasize visual nature exposure as the primary it cannot predict individual health risk without wearable physiological
restoration mechanism. Our results demonstrate that UTCI functions as a monitoring. Perceived adaptive capacity showed consistent negative
moderator of other stressors rather than an independent driver, correlations with stress (BPM: r=(cid:0) 0.44), indicating that both environ-
revealing multi-domain synergies absent from classical single-domain mental conditions and psychological factors (perceived control, risk
restoration frameworks. Temperature-PM interactions showed the assessment) modulate adaptation.
strongest correlations (BPM: R²=0.40; EDA: R²=0.43), while CO₂-
acoustic frequency pairings demonstrated universal electrodermal re- 4.3. Temporal dynamics and spatial aggregation for design validation
sponses across all participants. These compound effects extend beyond
visual-natural restoration pathways emphasized in traditional theory Extended adaptation durations demonstrate that complex multi-
[21]. PM-acoustic pairings succeeded where UTCI alone failed, indi- domain environments require substantial physiological stabilization
cating cross-domain interactions, not singular thermal or visual drivers, time, with direct implications for thermal refuge design where brief
determine adaptive outcomes. These findings partially align with sen- exposure may provide insufficient adaptive benefit. PM-low frequency
sory and cognitive load theories suggesting that urban overload from sound combinations showed particularly high recovery capacity (EDA:
noise, density, and pollution does elevate stress through autonomic 0.894), representing frequency-specific responses missed by single-
activation. But the patterns observed go beyond that: EDA responded domain assessment yet actionable for landscape interventions. The hi-
more strongly to thermal-air quality interactions than cardiovascular erarchical adaptation mechanism, cardiovascular responses showing
measures did, suggesting that different physiological systems handle broad sensitivity while electrodermal activity exhibits stronger thermal-
different environmental loads, and these loads interact synergistically air quality coupling, confirms that climate-resilient design requires
rather than additively. Optimal resilience emerged from balanced orchestrating thermal, acoustic, and air quality interventions as inte-
multi-domain conditions (Zone 1: CO₂=426 ppm, UTCI=30.1 ◦C with grated systems. Spatial clustering identified five statistically distinct
low-to-mid frequency acoustic dominance and minimal high-frequency adaptation zones (ANOVA: F₅,₁₅₈=9.42, p < 0.001) corresponding to
intrusion) rather than maximizing single factors like vegetation extent measurable urban typologies. Optimal zones (resilience=0.66±0.17)
or minimizing thermal exposure alone. Tree-canopied areas with poor exhibited balanced air quality (CO₂≈426 ppm), moderate acoustics
circulation showed elevated discomfort undermining recovery despite [58], and thermal stability (UTCI≈30 ◦C), while stress-prone zones (0.41
visual-natural qualities [56], demonstrating that greenery alone is not ±0.11) showed elevated CO₂ and broadband acoustic loads. This dem-
sufficient to ensure improved physiological outcomes. This contributes onstrates that aggregating multidimensional urban features enables
to explaining mixed evidence in existing density and greenery research neighborhood-scale comfort mapping identifying where physiological
[23]further framing that previous studies capturing single-domain ef- adaptation manifests versus where demographic models merely predict
fects (visual greenery, thermal relief) may have missed the compound quality of life [59].
thermal-air quality-acoustic interactions that actually determine physi-
ological outcomes, leading to inconsistent restoration findings across 4.4. Limitations and future directions
contexts. Hong and Jeon [7] showed that pleasantness and visual quality
together contributed similarly to perceived environmental harmony This study presents three primary limitations. First, the small sample
(standardized path coefficients of 0.37 and 0.34 respectively), yet size (eight participants) establishes proof-of-concept but constrains
climate adaptation planning continues to optimize what sensors can generalizability. However, the observed physiological heterogeneity
measure remotely rather than validating what bodies experience locally. within this homogeneous group validates individual-level monitoring as
Our results confirm that landscape-mediated comfort emerges from in- necessary rather than reflecting inadequate statistical power. Unmea-
tegrated thermal-air quality-acoustic conditions shaped by vegetation sured covariates (sleep quality, caffeine, stress levels, menstrual phase)
placement, spatial configuration, and material selection, not tempera- may contribute to observed heterogeneity alongside inherent physio-
ture reduction, greenery extent, or density alone [11,57]. logical differences. Future work should incorporate ecological momen-
tary assessment to partition person-specific traits from contextual
4.2. Individual heterogeneity modulators. Second, the two-day experimental period limits assessment
of temporal stability in resilience metrics. We cannot validate whether
In this pilot sample, individuals with similar observable character- observed patterns persist across diurnal cycles or seasonal acclimatiza-
istics (age 28–38, healthy adults, similar educational backgrounds) tion. However, the short timeframe achieves the primary objective:
exhibited markedly different physiological responses to identical mi- demonstrating that multi-domain models outperform single-domain
croclimates. Kruskal-Wallis tests suggest highly significant inter- indices in predicting acute physiological responses. Day-stratified ana-
individual differences in both BPM and EDA across all 18,815 observa- lyses suggested that physiological heterogeneity was statistically sig-
tions, with large effect sizes persisting within identical CO₂ exposure nificant within each session independently (Section 3.5, Table S4),
ranges (Section 3.5, Table S3), consistent with Wang et al. and their indicating the temporal limitation of this study applies to seasonal
review on inter-individual thermal comfort variability [55]. The same generalisability rather than to the internal validity of the core findings.
12

C. Grapas et al. B u i l d i n g a n d E n v i r o n m e n t 300 (2026) 114679
Despite these limitations, this study establishes that multi-domain the missing validation layer connecting building-scale performance to
monitoring predicts physiological stress better than thermal indices neighborhood-scale climate outcomes.
alone, a finding unlikely to reverse with extended observation, though Future scaling of this methodology and the integration of validated
magnitude and individual stability require longitudinal verification. physiological stress models with physics-informed digital twins that
combine building energy simulation and urban microclimate modeling
5. Conclusion would enable pre-deployment validation: testing whether coordinated
building innovations (material assemblages, transitional space config-
Do we all feel the city the same way? This study suggests we do not urations, cooperative energy management) aggregate to measurable
by establishing a methodological infrastructure for outdoor environ- pedestrian comfort improvements before construction begins. This re-
mental resilience assessment by integrating individual physiological quires scaling from proof-of-concept validation (n =8) to population-
sensing with spatial analysis to validate whether building and landscape level inference, from two-day acute response to seasonal acclimatiza-
interventions successfully reduce stress for actual occupants [60]. tion monitoring, and resolution of technical barriers regarding sensor
Despite sample and temporal constraints detailed in Section 4.4, this network scalability, real-time data processing infrastructure, and pri-
investigation demonstrates technical feasibility and addresses three vacy governance frameworks [62]. Applications of the validated
foundational questions: proof-of-concept framework include green infrastructure placement
strategies informed by measured recovery capacity, thermal refuge
1. Multi-Domain Superiority (RQ1): Multi-domain models combining network design calibrated to adaptation duration requirements, and
thermal, acoustic, and air quality parameters explained up to 43% of evidence-based evaluation of whether densification interventions
physiological variance, while heat stress index (UTCI) alone pro- maintain or improve physiological resilience. The fundamental question
duced no predictive power. This demonstrates that UTCI functions as remains: will climate adaptation continue relying on predicted comfort
a moderator of other stressors rather than an independent driver, from population-averaged models, or begin validating interventions
fundamentally challenging single-domain building performance through measured physiological outcomes of actual inhabitants expe-
frameworks. riencing urban space?
2. Individual Heterogeneity (RQ2): In this pilot sample, individuals
with similar characteristics showed statistically significant differ- CRediT authorship contribution statement
ences in physiological stress responses, with effect sizes large enough
to be detectable at this sample size. While n =8 does not allow broad Christos Grapas: Writing – original draft, Visualization, Validation,
generalisation, the results demonstrate that meaningful physiolog- Methodology, Investigation, Formal analysis, Data curation, Conceptu-
ical heterogeneity exists even within a homogeneous group, sup- alization. Marcel Schweiker: Writing – review & editing, Supervision,
porting the need for larger studies to validate whether personalised Methodology, Investigation, Funding acquisition, Formal analysis,
monitoring improves vulnerability assessment beyond population- Conceptualization. Anna Laura Pisello: Writing – review & editing,
averaged models. Supervision, Resources, Project administration, Methodology, Investi-
3. Spatial Aggregation (RQ3): K-means clustering identified five sta- gation, Funding acquisition, Conceptualization. Ilaria Pigliautile:
tistically distinct adaptation zones (p < 0.001) corresponding to Writing – review & editing, Supervision, Investigation. Roberta Jacoby
measurable urban typologies, demonstrating that personalized Cureau: Writing – review & editing, Supervision, Methodology,
wearable data can be aggregated into neighborhood-scale resilience Investigation.
maps. This enables evidence-based validation of where interventions
improve physiological adaptation versus where demographic models Declaration of competing interest
merely predict vulnerability.
The authors declare that they have no known competing financial
The three resilience metrics (Table 1) revealed extended physiolog- interests or personal relationships that could have appeared to influence
ical stabilization periods, with direct implications for thermal refuge the work reported in this paper.
design where brief exposure may provide insufficient adaptive benefit.
The hierarchical adaptation mechanism, for example cardiovascular Acknowledgements
responses showing broad sensitivity while EDA exhibits stronger
thermal-air quality coupling, confirms that climate-resilient building Christos Grapas received financial support from the European
design requires coordinating multisensory interventions as integrated Union's 'MuSIC' Marie Skłodowska-Curie program (Grant Agreement No.
systems. Yet current practice lacks methods to validate whether these 101073357). Marcel Schweiker’s contribution is facilitated by the
strategies improve resilience for actual inhabitants versus theoretical project‘ Profilbildung Built and Lived Environment’(PB22-062). The
models. project ‘Profilbildung Built and Lived Environment’ is receiving funding
This framework provides a methodological pathway for closing the from the programme ‘Profilbildung 2022’, an initiative of the Ministry of
validation loop between building intervention and individual response. Culture and Science of the State of North Rhine-Westphalia. Addition-
The three-resilience metrics: Toughness, Recovery Capacity, and ally, Marcel Schweiker was funded from VILLUM FONDEN by research
Adaptation Duration, translate individual measurements into actionable grant (21055). Roberta Jacoby Cureau acknowledges the financial
planning parameters that complement demographic indices and GIS support under the National Recovery and Resilience Plan (NRRP) for the
modeling, enabling empirical assessment of where population- project "AFRODITE - Adaptive solutions For Radiative cOoling and heat
calibrated design assumptions fail and which landscape configurations mitigation through Dynamic Innovative TEmporary urban shading and
produce measurable stress reduction for actual inhabitants. By inte- clothing strategies", funded by the European Union - Next Generation
grating physiological sensing with spatial analysis, this proof-of-concept EU, Mission 4 Component 2 (Italian Ministry of University and Research
framework demonstrates how individual-level measurements can vali- - MUR) CUP J93C25000480001. Anna Laura Pisello acknowledges the
date whether landscape interventions produce measurable stress financial support under the National Recovery and Resilience Plan
reduction at neighborhood scale. This approach addresses a critical gap (NRRP), Mission 4, Component 2, Investment 1.1, Call for tender No.
in current practice: while building science optimizes thermal perfor- 104 published on 2.2.2022 by the Italian Ministry of University and
mance and urban planning maps demographic vulnerability, neither Research (MUR), funded by the European Union – NextGenerationEU –
validates whether implemented designs actually reduce stress for people Project Title: THE-UNKNOWN – Equivalent THErmo-physical properties
inhabiting those spaces [61]. Human physiological responses provide for UNKNOWN composition of building walls (Project code:
13

C. Grapas et al. B u i l d i n g a n d E n v i r o n m e n t 300 (2026) 114679
P2022NM5L7) – CUP J53D230157600001, Grant assignment Decree No [20] C. Miller, Y.X. Chua, M. Quintana, B. Lei, F. Biljecki, M. Frei, Make yourself
1207 adopted on 28/07/2023 by the Italian Ministry of University and comfortable: nudging urban heat and noise mitigation with smartwatch-based just-
in-time Adaptive interventions (JITAI), Build. Environ. 284 (2025) 113388,
Research (MUR). https://doi.org/10.1016/j.buildenv.2025.113388.
[21] M. Hedblom, B. Gunnarsson, B. Iravani, I. Knez, M. Schaefer, P. Thorsson, J.
Supplementary materials N. Lundstro¨m, Reduction of physiological stress by urban green space in a
multisensory virtual experiment, Sci. Rep. 9 (2019) 10113, https://doi.org/
10.1038/s41598-019-46099-7.
Supplementary material associated with this article can be found, in [22] A.I. Egorov, S.M. Griffin, R.R. Converse, J.N. Styles, E.A. Sams, A. Wilson, L.
the online version, at doi:10.1016/j.buildenv.2026.114679. E. Jackson, T.J. Wade, Vegetated land cover near residence is associated with
reduced allostatic load and improved biomarkers of neuroendocrine, metabolic
and immune functions, Environ. Res. 158 (2017) 508–521, https://doi.org/
Data availability 10.1016/j.envres.2017.07.009.
[23] X. Fan, D. Hu, Y. Fan, J. Yang, H. Liang, T. Gao, L. Qiu, Urban restorative
environments: the critical role of building density, vegetation structure, and multi-
Data will be made available on request.
sensory stimulation in psychophysiological recovery, Build. Environ. 281 (2025)
113190, https://doi.org/10.1016/j.buildenv.2025.113190.
References [24] K. Kavee, K.A. Flanigan, Encoding experience: quantifying multisensory perception
of urban form through a systematic review, Comput. Environ. Urban. Syst. 122
(2025) 102349, https://doi.org/10.1016/j.compenvurbsys.2025.102349.
[1] United Nations, Department of Economic and Social Affairs, link: https://www.un.
[25] C. Grapas, A.L. Pisello, I. Pigliautile, C. Guattari, E. De Cristo, Multisensory urban
org/uk/node/81254, 2025. accessed: 1/4/2025.
climate zones (MUCZ): a framework for mapping dynamic multidomain Human
[2] C40 Cities, C40 Cities - A global network of mayors taking urgent climate action,
comfort in complex urban fabrics beyond urban morphology, Sustain. Cities. Soc.
C40 Cities, https://www.c40.org/, 2023. Accessed 19 Feb 2025.
131 (2025) 106673, https://doi.org/10.1016/j.scs.2025.106673.
[3] European Commission. Joint Research Centre. Covenant of mayors: 2023
[26] M. Schweiker, Rethinking resilient thermal comfort within the context of human-
assessment : 15 years of climate action at local level in Europe, Publications Office,
building resilience, in: J.F. Nicol, S. Roaf, H.B. Rijal (Eds.), Routledge Handbook of
LU, 2024.
Resilient Thermal Comfort, Routledge, 2022.
[4] J. Vanos, G. Guzman-Echavarria, J.W. Baldwin, C. Bongers, K.L. Ebi, O. Jay,
[27] A. Chiucchiu, I. Misuraca, E. Brembilla, I. Pigliautile, M. Tenpierik, A.L. Pisello,
A physiological approach for assessing human survivability and liveability to heat
Influence of Daylight Transmitted Through Blue Coloured Glazings on Human
in a changing climate, Nat. Commun. 14 (2023) 7653, https://doi.org/10.1038/
Response to Temperature and Glare, Gate Conference, Seville, Spain, 2024.
s41467-023-43121-5.
[28] A. Chiucchiù, V.M. Gnecco, I. Pigliautile, A.L. Pisello, The role of personality in
[5] S.H. Park, P.J. Lee, Effects of noise on health-related quality of life: the roles of
multi-domain environmental perception: An occupant-centric approach, Building
outdoor noise, indoor noise, and noise sensitivity, J. Expo Sci. Environ. Epidemiol.
(2025) 1–11, https://doi.org/10.1038/s41370-025-00816-9. and Environment 290 (2026) 114140, https://doi.org/10.1016/j.
buildenv.2025.114140.
[6] M. Schweiker, E. Ampatzi, M.S. Andargie, R.K. Andersen, E. Azar, V.M. Barthelmes,
[29] M. Bavaresco, R.J. Cureau, I. Pigliautile, M. Schweiker, V.M. Gnecco, G. Chinazzo,
C. Berger, L. Bourikas, S. Carlucci, G. Chinazzo, L.P. Edappilly, M. Favero,
E. Barna, Z.D. Belafi, L. Belussi, A. Chiucchiù, L. Danza, Z. Deng, B. Dong, N.
S. Gauthier, A. Jamrozik, M. Kane, A. Mahdavi, C. Piselli, A.L. Pisello, A. Roetzel,
H. Gapski, L. Garlet, X. Guo, P.P. Ha, H. Karimian, R. Lamberts, S. Liu, B.d.
A. Rysanek, K. Sharma, S. Zhang, Review of multi-domain approaches to indoor
C. Loeser, C. Massucci, A.P. Melo, B.V. Nagy, M.M. Ouf, F. Salamone, A.L. Pisello,
environmental perception and behaviour, Build. Environ. 176 (2020) 106804, Beyond hue and heat: A multi-site experimental study of lighting–thermal
https://doi.org/10.1016/j.buildenv.2020.106804.
interactions in human perceptions, Building and Environment 292 (2026) 114264,
[7] J.Y. Hong, J.Y. Jeon, Influence of urban contexts on soundscape perceptions: a
structural equation modeling approach, Landsc. Urban. Plan. 141 (2015) 78–87, https://doi.org/10.1016/j.buildenv.2026.114264.
[30] C. Grapas, M. Llaguno-Munitxa, A.L. Pisello, A. Irajpour, Urban chronotypes as
https://doi.org/10.1016/j.landurbplan.2015.05.004.
climate vulnerability indicators: Safety-modulated bioclimatic responses and
[8] A.P. Santos, J.M. Rodriguez Lopez, Y. Peng, J. Scheffran, Integrating broad and
adaptive behavior across diurnal urban contexts (2026) Urban Climate, 67, art, no
deep multiple-stressor research: a framework for translating across scales and
disciplines, One Earth. 7 (2024) 1713–1726, https://doi.org/10.1016/j. 102906 (2026), https://doi.org/10.1016/j.uclim.2026.102906.
[31] R.J. Cureau, I. Pigliautile, A.L. Pisello, A new wearable system for sensing outdoor
oneear.2024.09.006.
environmental conditions for monitoring hyper-microclimate, Sensors 22 (2022)
[9] K. Burwell-Naney, S.M. Wilson, S.T. Whitlock, R. Puett, Hybrid resiliency-stressor
502, https://doi.org/10.3390/s22020502.
conceptual framework for informing decision support tools and addressing
[32] A. Costantino, M. Ferrara, M. Arnesano, E. Fabrizio, Off-the-shelf wearable sensing
environmental injustice and health inequities, Int. J. Environ. Res. Public Health 16
devices for personalized thermal comfort models: a systematic review on their use
(2019) 1466, https://doi.org/10.3390/ijerph16081466.
in scientific research, J. Build. Eng. 70 (2023) 106379, https://doi.org/10.1016/j.
[10] G.M. Dimitri, L. Parri, E. Vitanza, A. Pozzebon, A. Fort, C. Mocenni, WeAIR:
wearable swarm sensors for air quality monitoring to foster citizens’ Awareness of jobe.2023.106379.
[33] U. Lohmann, R. Sausen, L. Bengtsson, U. Cubasch, J. Perlwitz, E. Roeckner, The
climate change, Comput. Stand. Interfaces. 94 (2025) 104004, https://doi.org/ Ko¨ppen climate classification as a diagnostic tool for general circulation models,
10.1016/j.csi.2025.104004. Clim. Res. 3 (1993) 177–193.
[11] O. Baumann, B. Brooks-Cederqvist, Multimodal assessment of effects of urban
[34] R.J. Cureau, C. Balocco, I. Pigliautile, C. Piselli, C. Fabiani, F. Cotana, C. Carletti,
environments on psychological wellbeing, Heliyon. 9 (2023) e16433, https://doi.
F. Sciurpi, A.L. Pisello, On urban microclimate spatial-temporal dynamics:
org/10.1016/j.heliyon.2023.e16433.
evidence from the integration of fixed and wearable sensing and mapping
[12] K.Y.T. Lim, M.T. Nguyen Thien, M.A. Nguyen Duc, H.F. Posada-Quintero,
techniques, Environ. Res. 262 (2024) 119795, https://doi.org/10.1016/j.
Application of DIY electrodermal activity wristband in detecting stress and
envres.2024.119795.
affective responses of students, Bioengineering 11 (2024) 291, https://doi.org/
[35] M.S. Engel, B. Paas, C. Schneider, C. Pfaffenbach, J. Fels, Perceptual studies on air
10.3390/bioengineering11030291. quality and sound through urban walks, Cities. 83 (2018) 173–185, https://doi.
[13] M. Huang, X. Li, M. Yang, X. Kuai, Intelligent coverage and cost-effective
org/10.1016/j.cities.2018.06.020.
monitoring: bus-based mobile sensing for city air quality, Comput. Environ. Urban.
[36] Oxford, Rloggia Lexico powered by Oxford, Available at: https://www.oxfordl
Syst. 108 (2024) 102073, https://doi.org/10.1016/j.
earnersdictionaries.com/definition/english/loggia, 2025.
compenvurbsys.2024.102073.
[37] Y. Kang, J. Park, D.-H. Jang, Compound impact of heatwaves on vulnerable groups
[14] Y.-Q. Hou, X.-J. Chen, Z. Huang, X. Peng, Y. Liu, Advancing population-targeted
considering age, income, and disability, Sci. Rep. 14 (2024) 24732, https://doi.
urban sensing: a comparative study on mobile and static sensing paradigms,
org/10.1038/s41598-024-75224-4.
Comput. Environ. Urban. Syst. 119 (2025) 102288, https://doi.org/10.1016/j.
[38] F. Tartarini, S. Schiavon, Pythermalcomfort: a Python package for thermal comfort
compenvurbsys.2025.102288.
research, SoftwareX 12 (2020) 100578, https://doi.org/10.1016/j.
[15] J. Liu, J. Kang, H. Behm, T. Luo, Effects of landscape on soundscape perception:
soundwalks in city parks, Landsc. Urban. Plan. 123 (2014) 30–40, https://doi.org/ softx.2020.100578 [online].
[39] Z. Wei, J.K. Calautit, S. Wei, P.W. Tien, Real-time clothing insulation level
10.1016/j.landurbplan.2013.12.003.
classification based on model transfer learning and computer vision for PMV-based
[16] J.Y. Hong, J.Y. Jeon, Exploring spatial relationships among soundscape variables
heating system optimization through piecewise linearization, Build. Environ. 253
in urban areas: a spatial statistical modelling approach, Landsc. Urban. Plan. 157
(2017) 352–364, https://doi.org/10.1016/j.landurbplan.2016.08.006. (2024) 111277, https://doi.org/10.1016/j.buildenv.2024.111277.
[40] T.P. McAlexander, R.R. Gershon, R.L. Neitzel, Street-level noise in an urban setting:
[17] J. Lin, R. Cromley, C. Zhang, Using Geographically Weighted Regression to Solve
the Areal Interpolation Problem, Annals of GIS 17 (2011) 1–14, https://doi.org/ assessment and contribution to personal exposure, Environ. Heal. 14 (2015) 18,
https://doi.org/10.1186/s12940-015-0006-y.
10.1080/19475683.2010.540258.
[41] Front Matter, in: L.F. Chaparro, A. Akan (Eds.), Signals and Systems Using
[18] S. Cheng, B. Lei, K. Fujiwara, C. Miller, F. Biljecki, J. van Ameijde, Walking through MATLAB, 3rd Edition, Academic Press, 2019, pp. i–iii, https://doi.org/10.1016/
green and grey: exploring sequential exposure and multisensory environmental
B978-0-12-814204-2.00002-8.
effects on psychological restoration, Build. Environ. 287 (2026) 113748, https://
[42] J. Emrich, A. Gargano, T. Koka, M. Muma, Physiology-informed ECG delineation
doi.org/10.1016/j.buildenv.2025.113748.
based on peak prominence, in: 2024 32nd European Signal Processing Conference
[19] Y. Lei, Construct a deep meta-learning model for accurate outdoor thermal comfort
(EUSIPCO). Presented at the 2024 32nd European Signal Processing Conference
p 1 r 1 e 1 d 7 i 3 ct – i 1 o 1 n 1 a 9 n 4 d , h it t s t p a s p :/ p / li d c o a i t . i o o r n g , / I 1 n 0 t . . 1 J 0 . 0 E 7 n / v s i 1 r 3 o 7 n 6 . 2 S - c 0 i 2 . 4 T - e 0 c 6 h 0 n 9 o 9 l. - 1 2 . 2 (2025) (EUSIPCO), IEEE, Lyon, France, 2024, pp. 1402–1406, https://doi.org/10.23919/
EUSIPCO63174.2024.10715353.
14

C. Grapas et al. B u i l d i n g a n d E n v i r o n m e n t 300 (2026) 114679
[43] M. Jain, A. Dimri, D. Niyogi, Land-air interactions over urban-rural transects using [54] Qian, W., Rao, F., Li, X., Lai, D., 2025. Mapping priority zones for urban heat
satellite observations: analysis over Delhi, India from 1991 to 2016, Remote Sens. 9 mitigation in Shanghai: heat risk vs. shelter provision. Computers, Environment
(12) (2017) 1283, https://doi.org/10.3390/rs9121283. and Urban Systems 121, 102330. https://doi.org/10.1016/j.compenvurbsys.20
[44] R. Zhu, X. Zhang, L. Yang, Y. Liu, Y. Cong, W. Gao, Correlation analysis of thermal 25.102330.
comfort and physiological responses under different microclimates of urban park, [55] Z. Wang, R. de Dear, M. Luo, B. Lin, Y. He, A. Ghahramani, Y. Zhu, Individual
Case Stud. Therm. Eng. 34 (2022) 102044, https://doi.org/10.1016/j. difference in thermal comfort: a literature review, Build. Environ. 138 (2018)
csite.2022.102044. 181–193, https://doi.org/10.1016/j.buildenv.2018.04.040.
[45] F.J. Richards, A flexible growth function for empirical use, J. Exp. Bot. 10 (2) [56] C. Liu, L. Tang, J. Yan, J. Ouyang, Direct and indirect effects of multisensory
(1959) 290–301 [online]. modalities on visitor’ s thermal comfort in an urban park in a humid-hot climate,
[46] J.H.M. Thornley, J. France, An open-ended logistic-based growth function, Ecol. Int. J. Sustain. Dev. World Ecol. 30 (2023) 319–328, https://doi.org/10.1080/
Modell. 184 (2–4) (2005) 257–261, https://doi.org/10.1016/j. 13504509.2022.2142692.
ecolmodel.2004.10.007. [57] Y. Zhao, D. Li, Multi-domain indoor environmental quality in buildings: a review of
[47] S.A. Mansi, G. Barone, C. Forzano, I. Pigliautile, M. Ferrara, A.L. Pisello, their interaction and combined effects on occupant satisfaction, Build. Environ.
M. Arnesano, Measuring human physiological indices for thermal comfort 228 (2023) 109844, https://doi.org/10.1016/j.buildenv.2022.109844.
assessment through wearable devices: a review, Measurement 183 (2021) 109872, [58] R.J. Cureau, P. Domenighini, I. Pigliautile, F. Cotana, A.L. Pisello, A multi-domain
https://doi.org/10.1016/j.measurement.2021.109872. comfort walk: cross-modal interactions on acoustic perception, in: Proceedings of
[48] T. Johnson, DigitalExposome: A dataset for wellbeing classification using the 10th Convention of the European Acoustics Association Forum Acusticum
environmental air quality and human physiological data, Data in Brief 59 (2025) 2023. Presented at the 10th Convention of the European Acoustics Association
111442, https://doi.org/10.1016/j.dib.2025.111442. Forum Acusticum 2023, European Acoustics Association, Turin, Italy, 2024,
[49] N.P.A. Nitidara, J. Sarwono, S. Suprijanto, F.X.N. Soelami, The multisensory pp. 255–262, https://doi.org/10.61782/fa.2023.1153.
interaction between auditory, visual, and thermal to the overall comfort in public [59] B. Lei, P. Liu, X. Liang, Y. Yan, F. Biljecki, Developing the urban comfort index:
open space: a study in a tropical climate, Sustain. Cities. Soc. 78 (2022) 103622, advancing liveability analytics with a multidimensional approach and explainable
https://doi.org/10.1016/j.scs.2021.103622. artificial intelligence, Sustain. Cities. Soc. 120 (2025) 106121, https://doi.org/
[50] I. Pigliautile, S. Casaccia, N. Morresi, M. Arnesano, A.L. Pisello, G.M. Revel, 10.1016/j.scs.2024.106121.
Assessing occupants’ personal attributes in relation to human perception of [60] S. Zorita, K. Milde, N. Pen˜a Cerezo, A. Aguirre-Such, D. Lückerath, E. Feliu Torres,
environmental comfort: Measurement procedure and data analysis, Building and Extending from adaptation to resilience pathways: perspectives from the
Environment 177 (2020) 106901, https://doi.org/10.1016/j. conceptual framework to key insights, Environ. Manag. (2025), https://doi.org/
buildenv.2020.106901. 10.1007/s00267-025-02115-3.
[51] T. Williamson, L. Daniel, A new adaptive thermal comfort model for homes in [61] F. Rosso, A.L. Pisello, F. Cotana, M. Ferrero, On the thermal and visual pedestrians’
temperate climates of Australia, Energy Build. 210 (2020) 109728, https://doi. perception about cool natural stones for urban paving: a field survey in summer
org/10.1016/j.enbuild.2019.109728. conditions, Build. Environ. 107 (2016) 198–214, https://doi.org/10.1016/j.
[52] C. Grapas, M. Llaguno-Munitxa, A.L. Pisello, A. Irajpour, Urban chronotypes as buildenv.2016.07.028.
climate vulnerability indicators: Safety-modulated bioclimatic responses and [62] S.J. Birchall, S. Kehler, S. Weissenberger, Sometimes, I just want to scream”:
adaptive behavior across diurnal urban contexts, Urban Clim. 67 (2026) 102906, institutional barriers limiting adaptive capacity and resilience to extreme events,
https://doi.org/10.1016/j.uclim.2026.102906. Glob. Environ. Change 91 (2025) 102967, https://doi.org/10.1016/j.
[53] G.I. Austin, I. Pe’er, T. Korem, Distributional bias compromises leave-one-out gloenvcha.2025.102967.
cross-validation, Sci. Adv. 11 (2025) eadx6976, https://doi.org/10.1126/sciadv.
adx6976.
15
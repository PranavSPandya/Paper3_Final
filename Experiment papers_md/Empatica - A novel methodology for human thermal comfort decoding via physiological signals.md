BuildingandEnvironment222(2022)109385
Contents lists available at ScienceDirect
Building and Environment
journal homepage: www.elsevier.com/locate/buildenv
A novel methodology for human thermal comfort decoding via
physiological signals measurement and analysis
Silvia Angela Mansia, Ilaria Pigliautileb,c, Marco Arnesanoa, Anna Laura Pisellob,c,d,*
aUniversita` Telematica eCampus, Novedrate, CO, Italy
bCIRIAF, Interuniversity Research Center on Pollution and Environment “Mauro Felli”, University of Perugia, Perugia, PG, Italy
cDepartment of Engineering Department, University of Perugia, Italy
dDepartment of Civil and Environmental Engineering, Princeton University, Princeton, NJ, United States
A R T I C L E I N F O A B S T R A C T
Keywords: Personal comfort models (PCM) represent the most promising paradigm for human-centric thermal comfort in
Thermal comfort buildings. Several data sources can be used to generate a PCM: environmental data, physiological data, occu-
Physiological measurements pants’ response. Advances in wearable sensing suggest that the use of physiological data for real time comfort
Wearables
measurement can be the start-up of the next generation of building design and operation with PCMs. However,
EEG
proof of evidence about the adoption of non-invasive but accurate measurement methods and about correlations
HRV
between physiological features and thermal sensation, are still required. This study presents the results from a
EDA
Thermal sensation large original experimental campaign aiming at human thermal comfort decoding via physiological signal. Two
Energy efficiency in buildings non-invasive wearables were used to simultaneously measure four key physiological signals (electroencepha-
Personal comfort model lography (EEG), Heart Rate Variability (HRV), electrodermal activity (EDA) and skin temperature (ST) on 52
subjects exposed to three different thermal conditions (namely cold, warm, and neutral) in a controlled envi-
ronment. Data acquired from 219 tests were therefore analysed to determine the statistical importance of
physiological features. Results showed that cold and warm thermal sensations can be uniquely identified by each
physiological signal; while neutral sensation is the less distinguishable. More specifically, statistical differences
(p-value <0.01) between cold and warm conditions were detected for the first time among EEGs features (Beta
TP10, Gamma TP10 relative alpha TP9), time- and frequency-domain features of HRV, EDA tonic component and
mean ST. Experimental results finally demonstrated that physiological measurements can identify specific
thermal sensation, of crucial importance for the most advanced PCMs and for disclosing novel energy saving
opportunities, accounting for people’s diversities.
actual building operation [9] and to minimize the energy consumption
of building systems [10,11], while maximizing the Indoor Environ-
1. Introduction mental Quality (IEQ) and occupants’ comfort perception, satisfaction
[12,13], and well-being [14,15]. To comprehensively address the indi-
Human beings are continuously exposed to a variety of environ- vidual perception of the surroundings, it is mandatory to explore
mental stimuli, which affect their health condition and potential in-depth the mechanism behind human environmental perception ac-
behaviour [1], including personal and social interactions [2] with their counting for simultaneous occurrences of multiple stimuli belonging to
surroundings and their capability of coping with specific social [3], different domains of comfort [16], and the human reaction to these
personal, or working tasks [4] influencing building energy demand and stimuli resulting from individual psychological and physiological re-
not only [5]. The strong bonds between human health status and envi- sponses. All these individual differences lead to diversity in environ-
ronmental stressors are already recognized in different domains [6]. mental perception as highlighted in the review by Schweiker at al.
Recent findings in building physics highlight the role of human envi- specifically focusing on thermal perception diversities [17]. All this
ronmental perception as a key driver in occupants’ behaviour and considered, it is almost impossible to find out a model capable of
interaction with building systems [7,8]. Introducing the human interpreting the needs and preferences of all the occupants, especially in
dimension in the building management system is crucial in determining
* Corresponding author. CIRIAF, Interuniversity Research Center on Pollution and Environment “Mauro Felli”, University of Perugia, Perugia, PG, Italy.
E-mail address: anna.pisello@unipg.it (A.L. Pisello).
https://doi.org/10.1016/j.buildenv.2022.109385
Received 21 April 2022; Received in revised form 7 June 2022; Accepted 7 July 2022
Availableonline11July2022
0360-1323/©2022TheAuthors.PublishedbyElsevierLtd.ThisisanopenaccessarticleundertheCCBYlicense(http://creativecommons.org/licenses/by/4.0/).

S.A. Mansi et al. B u i l d i n g a n d E n v i r o n m e n t 222(2022)109385
Abbreviations HVAC Heating Ventilation and Air Conditioning
IBI Inter Beat Interval
Ag silver IEQ Indoor Environmental Quality
ANS Autonomic Nervous System LED Light Emitting Diode
BLE Bluetooth Low Energy LF Low Frequency Power
BP Blood Pressure LF/HF Low to High frequency ratio
BVP Blood Volume Pulse NASPE North American Society of Pacing and Electrophysiology
CNS Central Nervous System PCM Personal Comfort Model
CO2 Carbon Dioxide PNS Parasympathetic Nervous System
DSP Digital Signal Processing PPG Photoplethysmography
ECG Electrocardiogram PSD Power Spectral Density
EDA Electrodermal activity RGB Red-Green-Blue
EEG Electroencephalography SC Skin Conductance
ESC European Society of Cardiology SCL Skin Conductance Level
FFT Fast Fourier Transform SCR Skin Conductance Response
GSR Galvanic Skin Response SNS Sympathetic Nervous System
GUM Guide to the expression of uncertainty in measurement ST Skin Temperature
HF High Frequency Power TS Thermal Sensation
HRV Heart Rate Variability VLF Very Low Frequency Power
HR Heart Rate
high-quality new constructions where minor environmental stresses are measurements. The agreement between PPG and ECG-based HR-HRV
expected [18]. has been demonstrated in several studies [33,34]. When attached to the
Personal Comfort Models (PCMs) have the potential of solving this skin, the PPG sensor measures the change in blood volume caused by the
issue. As reported by Joyce et al. [19], PCMs rely upon the individual as heart’s pumping by transmitting infrared light signals and measuring
the unit of the analysis, taking advantage directly of the individual’s the absorption of the reflected light by the blood [35]. This method al-
feedback (sensation, preference, and acceptability), physiological sig- lows the calculation of the rate of blood flow as controlled by the
nals records [20], or personal comfort systems control behaviour [21] heartbeats, also called Blood Volume Pulse (BVP), and the detection of a
and relevant information (mainly personal, environmental, and building peak in that pulse. The interval distance between those peaks is known
systems technical specifics) to train a data-driven model. Nevertheless, as Inter Beat Interval (IBI) which defines the HR. Several studies
still most of the PCM analyses are performed by taking into account confirmed the rule of HRV to guide the heart’s adaptation to physio-
environmental-only variables as measured individually or perceived. logical and environmental events, (e.g., breathing, exercise, physical
At the same time, the recent development of non-invasive wearable and mental stress, and metabolic alteration) [36] and the Autonomic
sensing technologies highlights the potential of monitoring specific Nervous System (ANS) activity Experimental studies on HRV and human
human physiological signals throughout daily life [22], having, there- thermal perception have mainly focused on how time and frequency
fore, more reliable signals which can be correlated to human preference domain features vary as participants were exposed to different envi-
and perception, rather than potentially biased surveys-only data sour- ronmental thermal conditions. The results from Yao et al. [37] and
ces. Electroencephalography (EEG), Heart Rate Variability (HRV), Skin Weiwei et al. [38] study showed higher values of low to high-frequency
Temperature (ST), and Electrodermal Activity (EDA) have been identi- ratio (LF/HF) in extreme (hot and cold) thermal environments and lower
fied as the main responsiveness physiological signals reflecting the values in the neutral condition. Other studies [39,40] revealed value of
thermoregulatory system activity [22]. LF/HF near revealed a value of LF/HF near 1 in comfortable thermal
EEG is a non-invasive method to record the electrical potential dif- conditions and a higher value when subject perceived thermal
ference between electrodes attached to a subject’s scalp [23] according discomfort.
to the International 10–20 system [24], (range of 10 μV–100 μV of ST and EDA can be defined as indicators of the thermal homeostasis
amplitude) resulting in the so-called “brainwaves”. EEGs can be ana- actions occurring at the skin surface. Measuring both of those signals, by
lysed through delta, theta, alpha, beta, and gamma waves, each of these applying a proper sensor directly on the skin surface, can contribute to
brain waves corresponds to different states of thought or experience investigating some processes linked to the thermoregulation system
[25]. Experimental studies on brainwaves and human thermal percep- activities. While ST represents the pure measure of the temperature of
tion predominately investigated the Power Spectrum Densities (PSDs) the skin, EDA is the change in sweat gland activity [41]. EDA reflects the
variation related to the different ambient temperature exposure of par- intensity of the human emotional state; stimulation of the sweat gland
ticipants. In general, results revealed that different environmental can in turn increase the electrical conductivity of the skin. In the field of
temperatures correspond to an increase or decrease of power in partic- thermal comfort investigation using skin physiological signals, it is
ular brain frequency bands [26–28]. Son and colleagues [29] showed a indicated that both ST and EDA showed a strict correlation with the
significant increase in the relative theta when the subject felt pleasure thermal sensation of subjects. In Refs. [20,42] studies a linear rela-
thermal sensation. Other studies revealed that participants showed tionship between ST and environmental temperature changes has been
higher values of alpha power in pleasant thermal environments, while demonstrated. Also, for EDA and thermal comfort studies, the results
beta power has lower values [30,31]. revealed a positive degree of correlation between thermal comfort and
Conventionally, electrocardiogram (ECG) is the method used to re- EDA signal, and its dependency on the environmental conditions
cord the heart’s electrical activity, from which the Heart Rate (HR) and [43–45].
HRV can be derived [32]. HRV represents the physiological phenome- Within this framework, this study represents an experimentally
non of the variation, in the time interval, between consecutive heart- driven original contribution towards the holistic and quantitative
beats in milliseconds. With the advent of wearable devices, decoding of human comfort in the built environment through physio-
photoplethysmography (PPG) has recently gained interest in HR-HRV logical measurements, which are basically driven by comfort-related
2

S.A. Mansi et al. B u i l d i n g a n d E n v i r o n m e n t 222(2022)109385
perception. The proposed procedure consists of the simultaneous that detect pressure, HR, and hormones in the heart. The neural signal,
collection of multiple physiologic signals, such as (i) EEG, (ii) HRV, (iii) from the intrinsic cardiac nervous system, propagates to the brain via
ST, and (iv) EDA for investigating the thermal sensations. Recruited afferent (ascending) pathways in both the spinal column and vagus
subjects were thus exposed to preliminary designed thermal boundaries nerves, reaching the cerebral cortex. In addition, the intrinsic cardiac
(representative of neutral, warm, and cold conditions, clearly distinct) nervous system has both short-term and long-term memory functions
within an environmentally controlled and monitored laboratory facility. and can operate independently of central neuronal command. The
The experimental campaign took advantage of mostly commercial biochemical communication occurs via the heart’s hormones. The heart
wearable systems already available in the market and characterized by contains cells that synthesize and release catecholamines (norepineph-
low invasiveness bias on the tested subjects, for their physiological rine, epinephrine, and dopamine), which are neurotransmitters once
monitoring: the Muse2-Bundle, a commercial headband designed as a thought to be produced only by neurons in the brain and ganglia. More
meditation-aiding device, collected 4-channels EEG [46]; the Empatica recently, it was discovered the heart also secretes the same range of
E4, a medical-grade wearable wristband device, measured HRV, ST and oxytocin produced in the brain, commonly referred to as the love or
EDA signals [47]. Pre-processing and statistical analysis procedures social bonding hormone [50].
were applied to identify the main physiological indicators of the human
thermal perception, useful to improve the existing PCMs. 2.2. Physiology of the brain - skin interactions
The structure of this paper is organized as follows. Section 2 reports
about the physiological background. Section 3 refers to the novel pro- Several studies have demonstrated how strictly brain activities and
posed research methodology. Section 4 presents the study results, skin functions are connected [51]. The skin is associated to the periph-
highlighting the main physiological differences of human thermal eral sensory nervous system, i.e. ANS, and the central nervous system
perception related to different environmental temperatures. Section 5 (CNS). The CNS communicates with the skin directly via efferent nerves
discusses the limits of the presented methodology and future develop- and indirectly via adrenal glands [52]. Sensory as well as autonomic
ment, and Section 6 concludes this study. (sympathetic) nerves influence a variety of physiological functions
(embryogenesis, vasocontraction, vasodilatation, body temperature,
2. Theoretical background barrier function, secretion, growth, differentiation, cell nutrition, nerve
growth). Fig. 1A illustrates brain-heart-skin nervous communication.
2.1. Physiology of the brain–heart interactions
2.3. Thermoregulatory system
The interaction between brain and heart activities has been largely
studied, especially for a better understanding of mutual physiological The human body is homeothermic, which means that the core tem-
mechanisms. The scientific field dedicated to brain-heart communica- perature, in healthy and comfortable conditions, is kept nearly constant
tion, named neuroradiography [48], outlines the physiological by physiological mechanisms [53]. The pivotal role in the thermoreg-
networking of the nervous and cardiovascular systems [49]. Brain-heart ulatory balance is represented by the hypothalamus, defined as the
communication is dynamic and two-way interactive; it occurs in four ‘‘body’s thermostat’‘. Changes in body internal temperature are recog-
major ways: neurologically (through the transmission of nervous im- nized by thermoreceptors (central and peripheral) on the skin, which in
pulses), biochemically (via hormones and neurotransmitters), bio- turn transmit thermal afferent information to the CNS, where the ther-
physically (through pressure waves), and energetically (through mal integration occurs. At this point, CNS sends the appropriate
electromagnetic field interactions). The efferent (descending) pathway response via ANS (efferent pathway) to the target organs (e.g., skeletal
from the brain in the ANS, thought SNS and PNS, is integrated into the muscle, skin vasculature, sweat glands), by triggering the thermal
heart’s intrinsic nervous system parallel to sensory neurons activities adaptation mechanisms. Heat conserving/generating or heat-dissipating
Fig. 1. (A) Brain-heart-skin communication pathways. (B) Physiological circuit of the thermoregulatory system.
3

S.A. Mansi et al. B u i l d i n g a n d E n v i r o n m e n t 222(2022)109385
reflexes to restrict or enhance heat loss. Heat-conserving is the main 3.1. Experimental environment and equipment
thermal mechanism to compensate for the reductions in the skin and/or
body core temperature via peripheral vasoconstriction. During this The experimental sessions took place in the environmentally condi-
process, blood vessels at the skin surface become narrowed to reduce tioned volume (4 ×4x2.7 m) of the NEXT.ROOM (Fig. 2A), a human
heat dissipation throughout the skin. Shivering is the physical reaction multidomain comfort test room built at the Environmental Applied
during heat-conserving process, which consist of involuntary contrac- Physics Lab (eaplab.net) at the University of Perugia (Italy) [54,55]. The
tion of muscles. Cells’ respiration releases heat to give energy for muscle test room is a laboratory facility specifically designed for addressing
contraction, which is used to warm up the body. When exposed to hot gaps in human-comfort theories where environmental stimuli belonging
temperatures, the body temperature increases. In this case, the triggered to different comfort spheres are completely controlled and monitored
thermal adaptation mechanism is the heat loss by vasodilation of blood [54]. The environmental monitoring setup is summarized in Table 1.
vessels. Heat loss occurs by convection and radiation. The quantity of This highly controlled environment guarantees to limit the envi-
heat dissipated by the body is proportional to the amount of blood flow ronmental variations among the three series of tests only to the ambient
propagated through the skin. Vasodilation speeds up the heat loss pro- temperature while keeping constant other environmental stimuli like
cess, the capillaries close to the most external layer of the skin dilate, and the illuminance level and the artificial lighting colour temperature, the
therefore more blood propagates, and the related transported heat CO2 concentration, and the background noise level (only due to the
power is dissipated. However, to enhance the amount of blood circu- conditioning systems operation). The internal layout consists of a table
lating via the superficial skin, the HR increases. Hence, the heart beats positioned in the middle of the room and a wheeling chair representing
faster, which helps to increase the rate of heat loss from the body. an office-like environment. The environmental conditions in the facility
Simultaneously, vasodilation reduces blood pressure. Then to restore are controlled by means of combined conditioning systems (a radiative-
normal blood pressure, the heart vehicles more blood through the blood and an air-based system), two artificial lighting systems - four light
vessels. Fig. 1B illustrates the physiological circuit of the thermoregu- emitted diode (LED) panels, and two red-green-blue (RGB) reflectors -
latory system.
Table 1
3. Materials and methods
Environmental monitoring equipment installed in the NEXT.ROOM.
The designed experimental protocol aimed at clearly identifying the Measured Technical Position
parameter specifications
contribution of thermal comfort and sensation on physiological re-
sponses by exposing recruited subjects, individually taking part to the Air temperature Accuracy: ±0.1 ◦C Height: 0.10/0.60/1.10/1.60 m
experiment, to three thermal environments (namely, neutral, cold, and Relative humidity Accuracy: ±1.5% (in 0 Height: 1.10 m
÷90%)
warm) while being monitored through dedicated wearables in terms of Globe temperature Accuracy: ±0.1 ◦C Height: 1.10 m
their EEG, HRV, EDA, and ST signals. The three-test series differ in terms Superficial Accuracy: ±0.1 ◦C Four probes for each internal
of internal operative temperature that was designed to be constant temperature surface
during each test and equal to the operative temperature recognized for Net radiation Sensitivity: 10 μV/(W/ Orthogonal to the three
m2) dimensions of the test room
thermally neutral environment, according to standards, and for signifi-
cantly divergent thermal scenarios (almost 10 ◦C lower and higher with S 1 p 0 e 0 c μ tr m al range: 0.2 ÷
respect to the standard neutral one). The same procedure was replicated Air velocity Accuracy: ±(0.2 m/s Height: 1.10 m
in both summer and winter 2021 and both multidomain effects and +3%)
possible artifacts generally affecting EEG and HRV signals records were Heat flux Sensitivity: 60⋅10(cid:0)6 V/ One for each internal surface
(W/m2)
carefully controlled and limited throughout tests. Materials, experi- Illuminance Range: 20 ÷2000 lx On the desk surface
mental procedure, data processing, and statistical analysis implemented CO2 concentration Accuracy: ±(50 ppm Height: 1.10 m
for achieving such goal are specified in the following subsections. +2%)
Fig. 2. (A) Building Information Modelling (BIM) representation of the climate chamber ‘‘NEXT.ROOM’‘. (B) Measurements of physiological signals with Muse 2-
Bundle and Empatica E4 during the experimental campaign.
4

S.A. Mansi et al. B u i l d i n g a n d E n v i r o n m e n t 222(2022)109385
and a mechanical ventilation system. The internal parameters, which are
continuously monitored with a 5-min frequency rate, are the following:
air temperature, relative humidity, globe temperature, superficial tem-
perature, air velocity, CO2 concentration, and illuminance level. A
previous work by the authors presents more specifics about the facility
microclimate control and environmental monitoring systems [55].
Despite its internal position, the NEXT.ROOM has a window aligned to
the laboratory openings to provide an external view from inside the test
room and to let natural daylight reach out the internal space. This
window was closed during all the tests performed in this study in order
not to expose subjects to different conditions in terms of natural
daylight, local radiant asymmetry, or to provide them with diversified
and uncontrolled visual stimuli. The four LED panels on the ceiling
provided a uniform illuminance level on the desk surface of about 570
lx. The desired ambient temperature values were reached and kept
constant throughout the whole duration of each test, thanks to the
combined contribution of the installed Heating Ventilation and Air
Fig. 4. Empatica E4 wristband, an overview of sensors.
Conditioning (HVAC) and radiant systems. Moreover, the test room was
always conditioned at least 2 h prior the experiments begin to verify the
to store data collected and streaming capacity through a BLE. The sen-
assumption of air temperature equal to the mean radiant temperature,
sors are placed at the bottom of the device, in firm contact with the skin.
and thus to the operative temperature that is the referring parameter for
Empatica E4 can register the following physiological signals:
the identification of thermally neutral conditions in ISO 7730 [56]. Once
in the NEXT.ROOM, each participant was asked to wear the two devices
• BVP: PPG polycarbonate (LG-SC1004A) technology captures the
selected for the physiological signals recording: the Muse 2-Bundle
variation of volume of arterial blood under the skin resulting from
(InterAxon Inc.), and the E4-wristband (Empatica) (Fig. 2B).
the heart cycle. Two LEDs generate light at different wavelengths
(Green and Red) and two photodiodes calculate the reflected light.
3.2. Physiological measurements
BVP sampling frequency is 64 Hz. Sensor output resolution 0.9 nW/
Digit, sensitive area: 14 mm2.
A commercial, low invasive, EEG sensor (Muse 2-Bundle, InterAxon
• IBI: The IBI sequence is obtained from the processing of the BVP
Inc.) [46] was used for the electroencephalographic (EEG) recording.
signal, with a process that removes incorrect peaks due to noise in
Several studies validated the usage of this low-cost portable device for
the BVP signal.
continuous recording of EEG data [57,58]. In particular, a preliminary
• EDA: Two electrodes snap-on silver (Ag) plated with metallic core
study was conducted [28] to validate the presented experimental pro-
measure the constantly fluctuating changes of skin electrical prop-
tocol and the MUSE’s capability of performing thermal comfort assess-
erties. The EDA signal is captured at sampling frequency of 4 Hz,
ment. The study demonstrated the accuracy of the device in collecting
with a resolution of 1 digit ~900 pSiemens.
the EEG and its low invasiveness. Among the measuring points of the
• ST: An infrared Thermopile reads peripheral ST at 4 Hz sampling
International 10/20 system of the electrode placement [24], the device frequency. Its resolution is 0.02 ◦C and the accuracy ±0.2 ◦C.
acquires brain activity from 4 measurement points. The reference elec-
trode FPz (CMS/DRL) is located on the forehead, the two input elec-
trodes are in front (left and right of the reference: AF7, AF8, silver made) 3.3. Experimental procedure
and the other two are posterior, above each ear (TP9 and TP10,
conductive silicone -rubber, Fig. 3). The device acquires signals at 256 Before starting the whole measurement campaign, the calculation of
Hz sampling frequency. The applicability of the EEG sensor is quick and the effective sample size was performed using the G*Power3 statistical
simple, due to the presence of dry electrodes. EEG data were collected test [60]. In a priori power analysis of G*Power3, the sample size was
using the MUSE application [59], paired with a smartphone through computed setting the required power level (1- β, i.e., Type II error
Bluetooth Low Energy (BLE). probability of falsely retaining an incorrect null hypothesis H0) equal to
The Empatica E4 [47] (Fig. 4) is a multi-sensor bracelet for contin- 0.95, the prespecified significant level (α, i.e., Type I error probability)
uous monitoring of physiological signals. It has an internal flash memory equal to 0.05, the effect size f (which is the degree of deviation from H0
Fig. 3. (A) MUSE 2 headband sensors overview. (B) Top-down view of the EEG electrode positions on the subject’s head.
5

S.A. Mansi et al. B u i l d i n g a n d E n v i r o n m e n t 222(2022)109385
in the underlying population H1) equal to 0.25, and statistical test on 3.4.1. EEG pre-processing and features extraction
repeated measures - within factor ANOVA and test Wilcoxon signed-rank A variety of tailored procedures were put in place for data collection,
test. The obtained sample size was 43 and 47 for the parametric and signal pre-processing, and feature extraction of the three main collected
non-parametric tests, respectively. physiological signals. Concerning the EEG, an on-board Digital Signal
The recruited sample group was made by 52 volunteers, 29 females Processing (DSP) module of Muse allowed noise filtering (0.1–45
(Table 2). Twenty-one volunteers involved in the experimental bandpass and notch at 60Hz), eye blink, and jaw clench artifacts
campaign repeated the same test by three times per season (for a total of removal. Fast Fourier Transform (FFT) was applied to the raw data using
126 significant tests), and thirty-one subjects repeated the test by three a 256-samples window, with a step of 22 samples. The PSD of five fre-
times in a single season (for a total of 93 significant tests). The three tests quency bands was obtained, each of those corresponding to a particular
were designed with three different and pre-defined operative tempera- mental state. Delta waves (0.5–4 Hz) are related to the deep sleep state,
tures, as follows: (i) 25 ◦C and 23 ◦C, in summer and winter, respec- theta waves (4–8 Hz) are associated with deeply relaxed and inward-
tively, as representative of the thermally neutral scenario in accordance focused states, alpha waves (8–12 Hz) are dominant in very relaxed
with ISO 7730:2005 [56] by assuming a clothing resistance level typical and passive attention, beta waves (12–35 Hz) correspond to an active
for each season (i.e., 0.5 and 1 for summer and winter seasons, respec- mind and external attention states, and gamma waves are prominent in
tively), and a low metabolic rate (i.e., equal to 58 W/m2 for sedentary concentration and problem solving conditions [61]. The average power
activities); (ii) 16 ◦C and 18 ◦C during the winter and summer tests in these bands is real-time computed in hardware and sent alongside an
representative of the cold scenario; (iii) 33 ◦C and 35 ◦C during the indicator of data quality from each sensor. In addition, for each of the
winter and summer tests representative of the warm scenario. These five-frequency bands, across the 4 considered channels (AF7, AF8, TP9,
operative temperature extremes guaranteed that most of the partici- TP10) the relative power was calculated using equation (1), where B
pants would feel cold or warm during the tests so that variations in represents the power of the signal in a specific frequency band and T
measured physiological signals with respect to the neutral benchmark represents the total power:
could be reasonably associated to changes in thermal sensation and not /
∑i ∑i
to other confounding factors. RelativeEEGbandpower= B T (1)
Each subject took part in the experiment individually. Tests were 0 0
scheduled from 10:00 a.m. to 1:00 p.m., and from 3:00 p.m. to 6:30 p.m.
Besides the relative power calculation, the band ratio (delta/beta;
Subjects were instructed not to smoke, perform any physical intense
delta/gamma; theta/beta; theta/gamma; alpha/beta; alpha/gamma),
effort, not to eat or drink coffee since at least 1 h before their scheduled
and alpha per beta in each channel was also calculated. Measures of
tests. Each test duration corresponds to 20 min (Fig. 5).
frontal (2) and temporal (3) asymmetry of each band were computed
Before entering the test room, one of the authors explained to the
separately by subtracting band power in the left hemisphere from power
participant the broad scope of the experiment, i.e., to enhance our
at homologous sites in the right hemisphere [25]:
knowledge on human comfort, so that each subject provided a written
informed consent and thus filled up a general survey on personal in- Frontal asymmetry =BAF8 – BAF7 (2)
formation including age, gender, height, and weight. Once positioned in
the NEXT.ROOM, each subject has been spending 15 min for personal Temporal Asymmetry =B TP10 – BTP9 (3)
acclimatization before starting the 5-min physiological signals
The total number of calculated EEG features was 78.
recording. During the 5-min physiological recording, the subject was
instructed to stay as quiet as possible, without performing any specific
3.4.2. HR and HRV pre-processing and features extraction
task, just sitting in the middle of the room, and relaxing to keep their
Improper wear of the HRV-sensing bracelet and movement of sub-
metabolic rate constant and reduce measurement artifacts due to body
jects are the main sources of artifacts in heart activity signals recorded
movements. At the end of the test, the subjects filled out a second survey
by the device. The HRV analysis [62] (python module for HRV analysis)
providing their thermal environment evaluation on a 5-points Likert
was used for processing the heart activity signal. This package was
scale ranging from +2, meaning warm sensation, down to (cid:0) 2, meaning
useful to remove outliers and ectopic beats from the inter beat interval
cold sensation, where the 0 represents neutrality. The scale was (IBI) signal. Sixteen HR-HRV’s time-domain and seven
designed in accordance with the purpose of the study that aimed at
frequency-domain features from free-artifacts IBI were calculated.
stressing individuals on extreme sensations achievable indoors to clearly
Time-domain variables express the variability in HR or the intervals
distinguish the three main conditions of thermal neutrality, or warm/
between recurring normal cardiac cycles. PSD analysis instead, provides
cold sensation. Despite each thermal scenario was experimentally
evidence of how power distributes as a function of frequency [63]. The
designed to be clearly perceivable as neutral, cold, or warm, the filling
most representative features extracted were selected from literature,
out of the survey allowed to account for subjects’ diversity in perceiving
according to Refs. [64,65] Table 3.
the thermal environment.
3.4.3. Skin parameters pre-processing and features extraction
3.4. Physiological signals processing
As regards EDA, it is worth mentioning that the skin conductance
(SC) signal is hypersensitive to physical activity and temperature vari-
Collected physiological signals were processed to extract a total of
ations. In this view, it is essential to filter them out from signals. EDA
110 features (85 in the frequency-domain, and 25 in the time-domain;
toolkit 11 [66] for artifacts detection was used. Portions of data iden-
summarized in Table 3 and Table 4).
tified by this toolkit as artifacts were manually removed from the sig-
nals. Eight EDA features (Table 4) were obtained from artifact-free
signals. They are extracted from both the phasic and tonic components
of the EDA signal. The phasic signal of EDA or skin conductance
Table 2
response (SCR) represents the change in the wetness level of the skin in
Recruited sample group description.
response to a presentation of a stimulus. On the contrary, the tonic
Variable Average ±standard Minimum Maximum
component or skin conductance level (SCL) is the average of conduc-
deviation
tivity given by sweat production during a time interval. The cvxEDA tool
Age [years old] 28.6 ±3.9 20 39
13 [67] was used to decompose the EDA signal into its two components.
Body Mass Index [kg/ 22.1 ±3.6 16.8 31.3
m2] This tool uses convex optimization to predict the activity of the ANS by
6

S.A. Mansi et al.                                                                                                                                                                                           B  u  i l d  i n  g  a  n  d  E  n  v  i r o  n m   e  n t 222(2022)109385
Fig. 5. Single test procedure.
| Table 3  |     |     | Table 4  |     |     |     |
| -------- | --- | --- | -------- | --- | --- | --- |
HR time domain, HRV time and frequency-domain measures. EDA features of  Skin parameters: ST and EDA tonic and phasic features.
tonic and phasic components.
|            |                  |                                    |                  | Features      | Units  Description                 |     |
| ---------- | ---------------- | ---------------------------------- | ---------------- | ------------- | ---------------------------------- | --- |
|            | Features  Units  | Description                        |                  |               |                                    |     |
|            |                  |                                    | Tonic component  | Mean Tonic    | mS  Mean value of tonic component  |     |
|            |                  |                                    |                  | Tonic perc25  | mS  20th percentile                |     |
| HRV time-  | NNI  ms          | The mean of normal-to-normal beat  |                  |               |                                    |     |
domain  Mean  intervals (R-R intervals).  Tonic perc75  mS  75th percentile
SDNN  ms  The standard deviation of the time  Tonic perc80  mS  80th percentile
|     |           |                                     |                   | Tonic SD        | mS  Standard deviation  |     |
| --- | --------- | ----------------------------------- | ----------------- | --------------- | ----------------------- | --- |
|     | index     | interval between successive normal  |                   |                 |                         |     |
|     |           | heartbeats                          |                   | Tonic quartdev  | mS  Quartile deviation  |     |
|     | SDSD  ms  | Standard deviation of differences   |                   |                 |                         |     |
|     |           |                                     | Phasic component  | Phasic Perc20   | mS  20th percentile     |     |
between adjacent NN intervals
|     |            |                                            |     | Max Peak  | mS  Max Peak of phasic component  |     |
| --- | ---------- | ------------------------------------------ | --- | --------- | --------------------------------- | --- |
|     | RMSSD  ms  | The square root of the mean of the sum of  |     |           |                                   |     |
the squares of differences between  Tsk  Mean ST  ◦C  Mean skin temperature
adjacent NN intervals
|     | NNI  ms  | Median Absolute values of the successive  |     |     |     |     |
| --- | -------- | ----------------------------------------- | --- | --- | --- | --- |
Median  differences between the RR-intervals  performed. The physiological features, calculated from measured data,
NNI 50  ms  Number of interval differences of  were classified according to the thermal sensation (TS) expressed by the
successive RR-intervals greater than 50  subjects in the questionnaires. Categories corresponded to C: cold (TS <
ms
0), N: neutral (TS =0), and W: warm (TS >0) groups. Data points with
|     | NNI 20  ms  | Number of interval differences of  |     |     |     |     |
| --- | ----------- | ---------------------------------- | --- | --- | --- | --- |
successive RR-intervals greater than 20  Z-score higher than 2 were considered outliers and removed from the
ms  dataset. Mean (f) and standard uncertainty of the mean (uf) of each
|     | Range  | Difference between the maximum and  |     |     |     |     |
| --- | ------ | ----------------------------------- | --- | --- | --- | --- |
feature was then calculated according to the Guide to the expression of
|     | NNI   | minimum NNI interval  |     |     |     |     |
| --- | ----- | --------------------- | --- | --- | --- | --- |
uncertainty in measurement (GUM) [68]. The normality and the ho-
|     | CVNNI  ms  | Coefficient of variation equal to the ratio  |     |     |     |     |
| --- | ---------- | -------------------------------------------- | --- | --- | --- | --- |
of SDNN divided by NNI Mean
mogeneity of variance, for each group of features, were evaluated with
|     | pNN50  %  | The proportion derived by dividing NNI  |     |     |     |     |
| --- | --------- | --------------------------------------- | --- | --- | --- | --- |
the Shapiro test [69] and Bartlett test [70], respectively. The repeated
50 (The number of interval differences of
measures ANOVA model [71] was used to compare means of physio-
successive RR-intervals greater than 50
ms) by the total number of RR-intervals  logical features across variables based on repeated observations in
pNN20  %  The proportion derived by dividing NNI  different conditions, when the features satisfied the assumptions of
20 (The number of intervals differences of  normality and homogeneity of variance (in this case: Alpha beta ratio
successive
TP10, Beta TP10, Beta TP9, Relative delta TP10, Relative gamma TP9,
RR-intervals greater than 20 ms) by the
|     |     |     | CVSD,  HFnorm,  | LFnorm,  HR  | Mean,  RMSSD,  SDSD),  | in  opposite  |
| --- | --- | --- | --------------- | ------------ | ---------------------- | ------------- |
total number of RR-intervals
Kruskal-Wallis non-parametric test [72] was performed (Gamma TP10,
|     | CVSD  ms  | Coefficient of variation of successive  |     |     |     |     |
| --- | --------- | --------------------------------------- | --- | --- | --- | --- |
differences equal to the RMSSD divided  Relative alphaTP9, Relative gamma TP10, HF, LF/HF, HR Mean, NNI
by NNI Mean  Mean, NNI Median, HR min, pNN20, pNN50, SDNN, Tonic mean, Tonic
HR time-  HR Max  bpm  Max HR  perc25 and the skin feature Mean ST). The capability of the features to
domain  HR Min  bpm  Min HR  discriminate between C–N, C–W, and N–W thermal sensations was
|     | HR Mean  bpm  | Mean HR                   |                        |          |                     |                 |
| --- | ------------- | ------------------------- | ---------------------- | -------- | ------------------- | --------------- |
|     |               |                           | further  investigated  | with  a  | post-hoc  analysis  | based  on  the  |
|     | STD HR        | Standard deviation of HR  |                        |          |                     |                 |
Dwass-Steel-Critchlow-Fligner pairwise comparison test [73]. There-
| HRV  |     | Analysis of short-term recordings (5  |     |     |     |     |
| ---- | --- | ------------------------------------- | --- | --- | --- | --- |
fore, we pointed out statistically significant variations of each feature
| frequency-  |     | min)  |     |     |     |     |
| ----------- | --- | ----- | --- | --- | --- | --- |
depending on personal thermal perception. The above-described statis-
| domain    | VLF   | Power in VLF range (≤0.04 Hz)  |     |     |     |     |
| --------- | ----- | ------------------------------ | --- | --- | --- | --- |
Power in LF range (0,04–0,15 Hz)  tical analysis was performed before and after the cross-validation test.
LF
LFnorm  nu  LF power in normalized units LF/(total  This specific test was designed to solve ambiguities in subjects’ thermal
power-VLF) ×100  evaluation since 6 subjects exposed to the cold temperature and 19
ms2
HF  Power in HF range (0.15–0.4 Hz)  subjects exposed to the warm temperature expressed TS =0 (neutrality).
HFnorm
nu  HF power in normalized units HF/(total  For simplicity, X(C(cid:0)N) was used to label the group of subjects who
power-VLF) ×100
LF/HF   Ratio LF (ms2)/HF (ms2)  expressed a feeling of thermal neutrality during the cold test and X(N(cid:0)W)
ms2
Total  Total power density spectral   for those who expressed a feeling of thermal neutrality during the warm
power
test. Gamma TP10, normalized low frequency (LFnorm), low to high fre-
quency ratio (LF/HF), and normalized (HFnorm) were used for the vali-
dation, being the most statistically significant features, assessed by the
means of Bayesian statistics. The mean value of skin temperature was
first computation of the Dwass-Steel-Critchlow-Fligner test - Gamma
also calculated.
TP10 in C–N contrasts, and LFnorm, LF/HF, and HFnorm in N–W contrasts.
Considering the non-gaussian distribution of the selected features, the
3.5. Statistical analysis  Mann-Whitney U non-parametric t-test between [X(C(cid:0)N)- N], [X(C(cid:0)N)- C],
[X(N(cid:0)W)- W] and [X(N(cid:0)W)
- N] groups were implemented. The results
To establish the correlation between physiological features and the
revealed that there is a statistical difference between the group X(C(cid:0)N)
thermal sensations of participants, a dedicated statistical analysis was
7

S.A. Mansi et al. B u i l d i n g a n d E n v i r o n m e n t 222(2022)109385
and C, and between X(N(cid:0)W)and W groups. The corresponding features of prominent in active mind, concentration, and problem-solving tasks.
those subjects were then categorized as N. Table 5 summarizes the Previously conducted studies, aimed at highlighting the potential cor-
cross-validation results. relation between the prevalence of a specific EEG frequency band and
the perceived thermal sensations, revealed that EEG alpha waves
4. Results increased while beta waves decreased with a pleasant thermal state,
others showed that high values of alpha power correspond to a high state
Regarding the indoor environmental condition during the experi- of arousal level and vice versa. The outcomes of this study showed that
mental sessions, the standard deviation of the observed air temperature relative alpha increased when subjects felt warm thermal sensation.
data was always below 0.4 ◦C during each test. Additionally, the internal Therefore, when subjects are exposed to a warm environment, they were
CO2 concentration (also continuously monitored) was always kept observed to be better relaxed, less focused, and unable to keep their
below 500 ppm thanks to the mechanical ventilation operation. Statis- attention. On the contrary, in cold conditions, there is an increase in the
tical results of physiological responses are summarized in Table 6 and activity of beta and gamma bands (>35 Hz), which are the main brain
Table 7, and shown in Fig. 6A and Fig. 7. waves connected to intense mental activity, as clearly depicted in
Regarding the EEG physiological domain, the results partially Fig. 8A (referring to a single subject selected as representative of the
confirmed what was found in the previous study [28]. In general, EEG tested sample). As confirmation of our method reliability, these out-
measurements showed a correlation with the thermal sensation in terms comes are in line with previous results in literature as summarized in the
of increase or decrease of power of brain waves. The warm sensation review by the same authors [27].
could be correlated to an increase of relative alpha. On the other hand, In addition, it was found that, while the HR of the human body in-
cold sensation is correlated to an increase of beta and gamma power. creases under warm temperature due to the thermoregulatory mecha-
Beta and Gamma TP10, Relative alpha TP9 and Relative gamma TP10 nism working for heat dissipation, consequently, the NNI intervals
showed a statistical difference between cold and warm sensations; decrease. Among the frequency domain features derived by PSD analysis
Gamma TP10 also showed a difference between cold and neutral ther- (Fig. 7B), HF was found to be higher when subjects felt cold than warm
mal sensations. Considering the HRV domain results, the time-domain sensation. In the meantime, higher values of LF and LF/HF were found
HRV features related to the normal-to-normal beat intervals (NNI) when subjects were exposed to a higher temperature. In general, HF, or
were higher in warm than in cold scenarios. Among the HRV the respiratory band, is affected by breathing from 9 to 24 bpm and
frequency-domain features, HF and HFnormvalues were larger under reflects the PNS activity, which is involved in the relaxing phase, it al-
lower temperatures. On the contrary, normalized LFnorm showed an in- lows the body to rest and recover, decreasing the HR. LF band, instead, is
crease of power under higher temperatures. LF/HF was higher in warm produced by PNS and SNS and blood pressure (BP) regulation via
than cold conditions. All the HRV investigated features present signifi- baroreceptors. In the resting state, the LF band manifests baroreflex
cant differences between cold and warm thermal sensation. HFnorm, activity and not cardiac SNS drive. The LF/HF power was originally
LFnorm, and LF/HF showed also differences between neutral and warm defined as the expression of the “PNS-SNS balance”. However, many
sensations. The tonic component of the EDA signal and the mean ST studies [74] suggest that LF/HF cannot be the indicator of the PNS-SNS
were identified as the most statistically significant skin features. High balance, considering that PNS and SNS interaction is complex,
values of mean ST and EDA tonic perc25 were found in the warm state. nonlinear, and non-reciprocal, and the LF power is not a pure index of
The skin features showed significant differences between cold and warm SNS activity.
sensation, the EDA Tonic perc25 also between cold and neutral, the In this view, showing higher values of LF and lower values of HF in
mean ST also between neutral and warm. Among the four measured warm conditions could be explained by different characteristics in ANS
physiological signals, Gamma TP10, LF/HF and the tonic component of and PNS excitation. The sympathetic branch of the ANS got excited
EDA present the strongest significant and consistent differences between under cold environments to constrict the blood vessels in the skin, and
cold and warm thermal sensation. Their combination can be therefore therefore reducing personal heat dissipation. Under hot environments,
used to uniquely identify cold or warm personal thermal states (Fig. 6B) however, it is excited to make the body sweat, dissipating the extra heat.
as never done before. Normally, the intensity of the excitation of the sympathetic nerve is
Now, the observed findings are interpreted according to human much higher when the human body sweats. Consequently, the LF/HF
physiology described in Section 2. As the brain, heart, and skin are had higher values when the human body was exposed to warm
physiologically connected by ANS communication, the combination of environments.
EEG, HRV, EDA, and ST signals analysis is a reasonable approach to Moreover, also the mean ST tends to increase as the environmental
uniquely identify the thermal sensations of the subjects. The dominance temperature increases. Nevertheless, a meaningful difference between
of an EEG frequency band is correlated to a certain mental state. In cold and neutral states is not clearly detectable (Fig. 8). Physiological
general, low-frequency bands such as delta, theta, and alpha correspond response of the skin, measured by EDA, revealed information about the
to deep sleep, deeply relaxed, and very relaxed conditions, respectively. electrical conductance of the skin, itself, which varies with emotion and
On the other hand, high frequency bands (beta and gamma) are thermal changes. Sweat glands are controlled by the sympathetic ner-
vous system, in this view the skin conductance can be informative about
the psychological or physiological arousal level of the human body. The
Table 5 moisture level depends on the sweat glands and blood flow, which are
The Mann-Whitney U non-parametric t-test results (*for p-value <0.05). A non- regulated by the SNS. The results showed that subjects under warm
parametric test was implemented since the used features showed a non-gaussian conditions present a higher value of the tonic component of EDA
distribution. because of high activation of the SNS (Fig. 8D), responsible for the
Features Groups t-value p-value activation of sweat glands during heat dissipation mechanism.
Nevertheless, results do not provide clear information about which
Gamma TP10 X X ( ( C C (cid:0) (cid:0) N N ) ) - - N C 8 10 6 1 0 0 . . 0 0 6 1 * physiological features combination clearly distinguish the neutral
LFnorm X(N(cid:0)W)- N 577 0.5 thermal sensation. This outcome could be justified by differences in
X(N(cid:0)W)- W 410 0.004* individual subjects’ thermal preferences. In fact, it is recognized that
LF/HF X(N(cid:0)W)- N 550 0.4 under the same environmental conditions different people can perceive
X(N(cid:0)W)- W 452 0.01* different thermal sensations [17]. In the presented study we classified
HFnorm X(N(cid:0)W)- N 578 0.6 data according to the thermal sensation expressed by subjects, and by
X(N(cid:0)W)- W 412 0.003*
using cross-validation method we reorganized the data redirecting the
8

S.A. Mansi et al.                                                                                                                                                                                           B  u  i l d  i n  g  a  n  d  E  n  v  i r o  n m   e  n t 222(2022)109385
Table 6
Repeated measured ANOVA - Kruskal-Walli’s test results. The mean feature (f), the standard uncertainty of the mean (uf), H-statistic, and the significant p-value (p-
value <0.01) are reported for each statistically significant feature extracted by the retrieved physiological signals.
|     | Features  | f±uf(C) | f±uf (N) | f±uf(W) | H-statistics  | p-value  |
| --- | --------- | ------- | -------- | ------- | ------------- | -------- |
EEG  Alpha beta ratio TP10  1,2 ±0,06  1,3 ±0,06  1,3 ±0,06  7,2  <0,001
|     |             | 0,6 ±0,03  | 0,5 ±0,03  | 0,5 ±0,03  |       | <0,001  |
| --- | ----------- | ---------- | ---------- | ---------- | ----- | ------- |
|     | Beta TP10   |            |            |            | 12,6  |         |
|     |             | 0,5 ±0,04  | 0,5 ±0,03  | 0,5 ±0,04  |       | <0,001  |
|     | Beta TP9    |            |            |            | 6,9   |         |
|     | Gamma TP10  | 0,2 ±0,04  | 0,1 ±0,03  | 0,1 ±0,04  | 17,6  | <0,001  |
Relative alpha TP9  0,3 ±0,01  0,3 ±0,01  0,3 ±0,01  16,0  <0,001
|     |                      | 0,2 ±0,01  | 0,2 ±0,01  | 0,2 ±0,02  |      | <0,001  |
| --- | -------------------- | ---------- | ---------- | ---------- | ---- | ------- |
|     | Relative delta TP10  |            |            |            | 6,7  |         |
Relative gamma TP10  0,1 ±0,02  0,1 ±0,01  0,1 ±0,01  11,8  <0,001
Relative gamma TP9  0,1 ±0,02  0,0 ±0,02  0,0 ±0,02  5,7  <0,001
|      |           | 0,1 ±0,03     | 0,1 ±0,003    | 0,0 ±0,03     |       | <0,001  |
| ---- | --------- | ------------- | ------------- | ------------- | ----- | ------- |
| HRV  | CVSD      |               |               |               | 26,2  |         |
|      | HF        | 608,1 ±73,14  | 507,1 ±66,91  | 393,4 ±57,34  | 18,6  | <0,001  |
|      | HFnorm    | 39,3 ±3,8     | 36,9 ±3,27    | 27,9 ±2,64    | 26,1  | <0,001  |
|      | LF/HF     | 1,7 ±0,23     | 2,1 ±0,38     | 3,1 ±0,43     | 26,0  | <0,001  |
|      |           | 60,7 ±3,8     | 63,1 ±3,27    | 72,1 ±2,64    |       | <0,001  |
|      | LFnorm    |               |               |               | 26,1  |         |
|      | HR Max    | 85,4 ±2,27    | 90,2 ±2,54    | 91,1 ±2,55    | 10,5  | <0,001  |
|      | HR Mean   | 68,6 ±2,26    | 71,7 ±2,34    | 74,4 ±2,18    | 11,0  | <0,001  |
|      |           | 896,6 ±30,18  | 843,3 ±29,41  | 813,4 ±24,74  |       | <0,001  |
|      | NNI Mean  |               |               |               | 13,9  |         |
NNI Median  900,3 ±30,86  843,8 ±29,91  812,9 ±24,97  15,4  <0,001
|     | HR Min  | 56,1 ±1,85  | 59,9 ±1,94  | 61,1 ±2,06  | 9,8   | <0,001  |
| --- | ------- | ----------- | ----------- | ----------- | ----- | ------- |
|     | pNN20   | 64,4 ±2,72  | 58,7 ±3,31  | 56,1 ±2,68  | 15,4  | <0,001  |
|     |         | 27,9 ±3,54  | 20,7 ±2,81  | 16,1 ±2,69  |       | <0,001  |
|     | pNN50   |             |             |             | 24,1  |         |
|     | RMSSD   | 53,4 ±3,93  | 45,5 ±3,10  | 40,7 ±3,04  | 25,1  | <0,001  |
|     | SDNN    | 62,4 ±4,19  | 55,9 ±3,82  | 53,3 ±3,12  | 10,7  | 0,005   |
|     |         | 53,4 ±3,92  | 45,5 ±3,10  | 40,7 ±3,04  |       | <0,001  |
|     | SDSD    |             |             |             | 25,1  |         |
EDA  Tonic mean  (cid:0) 1,0 ±0,22  (cid:0) 0,6 ±0,12  (cid:0) 0,5 ±0,08  9,5  0,009
Tonic perc25  (cid:0) 1,6 ±0,22  (cid:0) 1,2 ±0,12  (cid:0) 1,0 ±0,08  24,5  <0,001
|      |          | 31,3 ±0,33  | 32,1 ±0,48  | 33,2 ±0,51  |       | <0,001   |
| ---- | -------- | ----------- | ----------- | ----------- | ----- | -------- |
| Tsk  | Mean ST  |             |             |             | 27,2  |          |
data the neutral sensation.
Table 7
Dwass-Steel-Critchlow-Fligner pairwise comparison results. Statistical p-values
5. Discussion
obtained by contrast between C–N, CW, N–W (* for p-value <0.01).
Features  C–N (p-  C–W (p-  N–W (p-  We developed and experimentally demonstrated the use of physio-
value)  value)  value)
logical measurements for thermal comfort decoding, in different sea-
| EEG  Alpha beta ratio TP10  | 0,2  | 0,01  0,8  |     |     |     |     |
| --------------------------- | ---- | ---------- | --- | --- | --- | --- |
sonal and thermal microclimate conditions. Combining synchronous
| Beta TP10  | 0,02  | 0,003*  0,7  |     |     |     |     |
| ---------- | ----- | ------------ | --- | --- | --- | --- |
analysis of four physiological signals, EEG, HRV, ST, and EDA for the
| Beta TP9  | 0,02  | 0,02  0,9  |     |     |     |     |
| --------- | ----- | ---------- | --- | --- | --- | --- |
Gamma TP10  0,003*  0,001*  0,7  first time, we provided a novel approach in the PCM field. Using low
Relative alpha TP9  0,01  0,001*  0,5  invasive wearable devices for acquiring physiological signals, and ana-
Relative delta TP10  0,8  0,1  0,4  lysing data with ad hoc processing procedure, we uniquely identified
Relative gamma TP10  0,03  0,003*  0,6  cold and warm individual thermal sensation based only on physiological
| Relative gamma TP9  | 0,1  | 0,02  0,8  |     |     |     |     |
| ------------------- | ---- | ---------- | --- | --- | --- | --- |
measurements. We believe the presented methodological approach can
HRV  CVSD  0,02  0,001*  0,04  massively improve the implementation of a more robust personalized
HF  0,1  0,001*  0,04  thermal comfort modelling and measurement, pointing at the optimi-
| HF norm  | 0,6  | 0,001*  0,001*  |     |     |     |     |
| -------- | ---- | --------------- | --- | --- | --- | --- |
zation of buildings’ energy consumption for HVAC operation. The out-
| LF/HF  | 0,7  | 0,001*  0,001*  |     |     |     |     |
| ------ | ---- | --------------- | --- | --- | --- | --- |
LF norm  0,6  0,001*  0,001*  comes of this study will be strategic in the field of thermal comfort
| HR Mean  | 0,2  | 0,002*  0,3  |     |     |     |     |
| -------- | ---- | ------------ | --- | --- | --- | --- |
investigations in different types of indoor environments and for several
| NNI Mean  | 0,04  | 0,001*  0,5  |     |     |     |     |
| --------- | ----- | ------------ | --- | --- | --- | --- |
scopes, as human-building interaction decoding. To this aim, known
| NNI Median  | 0,03  | 0,001*  0,4  |     |     |     |     |
| ----------- | ----- | ------------ | --- | --- | --- | --- |
limitations should be considered and overcome. As a matter of fact, the
| pNN20  | 0,1  | 0,001*  0,3  |     |     |     |     |
| ------ | ---- | ------------ | --- | --- | --- | --- |
pNN50  0,01  0,001*  0,1  implemented experimental procedure was specifically designed for
RMSSD  0,01  0,001*  0,1  reducing the impact of non-thermal stimuli and body’s movement arti-
SDNN  0,04  0,004*  0,8  facts in physiological signals measurement. The experiments were car-
| SDSD  | 0,01  | 0,001*  0,1  |     |     |     |     |
| ----- | ----- | ------------ | --- | --- | --- | --- |
ried out in an environmentally controlled multidomain test room and
EDA  Tonic mean  0,03  0,01  0,9  with behaviourally controlled participants, while real-life scenarios
Tonic perc25  0,006*  0,001*  0,1  would imply subjects performing a variety of activities being exposed to
Tsk  Mean ST  0,1  0,001*  0,003*   a simultaneous combination of a variety of physical boundaries (i.e.,
thermal, visual, acoustic, air quality stimuli). Therefore, the data
acquisition scenario adopted for this work could be assumed as repre-
subjects with ambiguities (e.g., expressed warm thermal sensation under
sentative but a particular case of the real-life conditions. Nevertheless,
neutral thermal conditions to the group where their physiological fea-
different data analysis procedures to increase signal-noise-ratio are
tures statistically belong. Such procedure resulted in more data classi-
available, but further data processing is required for deep investigation.
fied as warm or cold with respect to those classified as neutral. Only a
Among the acquisition tools limitations there are the invasiveness of
few physiological features better distinguish the neutrality from cold or
wearable devices, and their accuracy. This is the reason why wearable
warm thermal sensation (e.g., Gamma TP10, Tonic perc25 in C–N
devices have been selected to be easy-to-wear. Despite that, the EEG
contrast, LFnorm, HFnorm, LF/HF and Mean ST in N–W), which could mean
headband may cause headaches, which means that it is not suitable for a
that they are not sufficient to clearly describe in terms of physiological
long period of acquisition. In addition, the presence of dry electrodes,
9

S.A. Mansi et al. B u i l d i n g a n d E n v i r o n m e n t 222(2022)109385
Fig. 6. (A) The mean (f), and the standard uncertainty of the mean (uf) of the main statistically significant features, (*P <0.001). (B) Warm, neutral, and cold
sensations as described by the combination of the most representative features extracted by EEG (Gamma TP10), HRV (LF/HF), EDA (Tonic perc25), and
ST processing.
make the device more prone to wear out under particular conditions or addition, Beta and Gamma TP10, Relative alpha TP9 and Relative
after a certain time, risking compromising the data collection if the gamma TP10 has a statistical difference between cold and warm sen-
metrological characteristics are not periodically verified by the experi- sations. Considering the HRV results, the time-domain HRV features
ment manager. Finally, it should be mentioned that physiological signal were higher when subject felt warm than cold sensation. Among the
characteristics are associated to personal factors. In fact, individual HRV frequency-domain features, HF and HFnorm values showed greater
psychophysiological conditions and personal feelings can influence the values when participants felt cold thermal sensation; on the contrary,
thermal perception. Therefore, additional surveys to collect emotional LFnorm showed an increase of power for warm thermal sensation. LF/HF
states of participants could be useful to obtain an accurate analysis of the was higher in warm than cold conditions. In general, all the HRV fea-
perceived thermal sensations in relation to a larger set of control vari- tures has significant differences between warm and cold states. Among
ables. In conclusion, moving from this research outcomes, further in- skin measurements, the results demonstrated that high values of mean
vestigations about the neutral state estimation and the quantitative ST and EDA tonic component were related to the warm state. Both ST
correlation between physiological features and individual thermal and EDA features has differences between cold and warm sensations, the
sensation need to be conducted. A possible solution to address the high EDA Tonic perc25 also between cold and neutral, and the mean ST also
individual variability issue could be the employment of data normali- between neutral and warm thermal sensations.
zation methods by using, for example, the physiological data recorded in Furthermore, data processing and cross-validation test suggest that
resting and thermally neutral state as a reference. Additionally, to human thermal sensation can be detected with higher precision relying
further refine our ability in decoding human thermal perception, it could upon physiological signals, aside from the environmental boundaries.
be valuable to continuously monitor subjects’ physiological response Research outcomes support the idea for the development of personal
also under thermal gradients thus verifying human physiology respon- control systems for the built environment mainly (if not solely) driven by
siveness to environmental changes. the single-occupant physiology in a human-centric perspective. Moni-
tored environmental parameters seem not to add any information on
6. Conclusions people indoor comfort that cannot be already detected via personal
human-centered parameters. Individuals, even if belonging to the same
The presented research aimed at clearly identify individual thermal climate region and presenting similar cultural background, present a
perception through physiological signal processing. A new laboratory- variety of thermal comfort thresholds leading to different perceptions
based experimental protocol was developed and conducted to expose within the same environmental boundaries while their physiological
recruited subjects (52 people in total) to three thermal boundaries as response associated with cold and warm thermal perception is the same.
representative of neutral, cold, and warm conditions in both summer This discovery therefore opens the doors toward fully personalized
and winter. Physiological data collection was pursued through environmental comfort models really tailored to each one’s expecta-
commercially available wearables providing multiple signals (i.e., EEG, tions, attitudes, and other temporary or permanent individual charac-
ECG, EDA, and ST). Results only partially confirm previous research teristics. The decoding of human thermal perceptions discloses the
outcomes in the field of thermal perception, highlighting the importance massive potential of triggering human subjects toward their personal
of collecting all the physiological signals, here simultaneously analysed wellbeing through dedicated tailored low-energy and low-cost strategies
for the very first time. In fact, each signal provides features whose based on building interfaced control algorithms.
combination supports the detection of extreme thermal sensation, i.e.,
cold and warm. For the EEG measurements, the results showed that the CRediT authorship contribution statement
warm sensation is correlated to an increase of relative alpha, and the
cold sensation is correlated to an increase of beta and gamma powers. In Silvia Angela Mansi: Writing – review & editing, Writing – original
10

S.A. Mansi et al. B u i l d i n g a n d E n v i r o n m e n t 222(2022)109385
Fig. 7. Histograms of the Repeated measured ANOVA - Kruskal-Wallis test results. (A) The mean (f)and standard uncertainty of the mean (uf )of the statistical
results concerning the EEG features (B) The mean (f)and standard uncertainty of the mean (uf )of the statistical results concerning the HRV features. *P <0.001.
(Bar colours: blue stands for C; green stands for N and red stands for W thermal sensations). (For interpretation of the references to colour in this figure legend, the
reader is referred to the Web version of this article.)
11

S.A. Mansi et al. B u i l d i n g a n d E n v i r o n m e n t 222(2022)109385
Fig. 8. Detailed results extracted from the analysis of the physiological signals measured on the same subject under three different thermal sensations: C, N and W.
(A) PSD responses across all the EEG channels at 40 Hz. The scalp maps were generated using a ’’topoplot’’ function of EEGLAB (B) Welch’ periodogram with PSD
trends of HRV classified according to VLF, LF, and HF frequency bands. (C) Mean ST signal. (D) EDA signal.
draft, Visualization, Methodology, Investigation, Formal analysis, Data the work reported in this paper.
curation, Conceptualization. Ilaria Pigliautile: Writing – original draft,
Visualization, Methodology, Investigation, Formal analysis, Data cura- Data availability
tion, Conceptualization. Marco Arnesano: Writing – review & editing,
Validation, Supervision, Project administration, Methodology, Investi- The data that has been used is confidential.
gation, Funding acquisition, Formal analysis, Data curation, Conceptu-
alization. Anna Laura Pisello: Writing – review & editing, Validation, Acknowledgments
Supervision, Project administration, Methodology, Investigation,
Funding acquisition, Formal analysis, Data curation, Conceptualization. The authors wish to thank the Italian Ministry of research for sup-
porting the young researcher PRIN project NEXT.COM
(20172FSCH4_002). Additionally, Ilaria Pigliautile acknowledges the
Declaration of competing interest
PON project (D.M. 1062 PON Ricerca e Innovazione) “Red-To-Green”,
and Anna Laura Pisello acknowledges the Horizon Europe ERC Grant
The authors declare that they have no known competing financial
HELIOS (GA 101041255).
interests or personal relationships that could have appeared to influence
12

S.A. Mansi et al. B u i l d i n g a n d E n v i r o n m e n t 222(2022)109385
References [24] U. Herwig, P. Satrapi, C. Scho¨nfeldt-Lecuona, Using the international 10-20 EEG
system for positioning of transcranial magnetic stimulation, Brain Topogr. 16
(2003) 95–99, https://doi.org/10.1023/B:BRAT.0000006333.93597.9D.
[1] A. Heydarian, C. McIlvennie, L. Arpan, S. Yousefi, M. Syndicus, M. Schweiker,
[25] K.J. Mathewson, A. Hashemi, B. Sheng, A.B. Sekuler, P.J. Bennett, L.A. Schmidt,
F. Jazizadeh, R. Rissetto, A.L. Pisello, C. Piselli, C. Berger, Z. Yan, A. Mahdavi,
Regional electroencephalogram (EEG) alpha power and asymmetry in older adults:
What drives our behaviors in buildings? A review on occupant interactions with
a study of short-term test-retest reliability, Front. Aging Neurosci. 7 (2015) 177,
building systems from the lens of behavioral theories, Build. Environ. (2020),
https://doi.org/10.3389/FNAGI.2015.00177/BIBTEX.
https://doi.org/10.1016/j.buildenv.2020.106928.
[26] B. Lv, C. Su, L. Yang, T. Wu, Effects of stimulus mode and ambient temperature on
[2] X. Xu, J.E. Taylor, A.L. Pisello, Network synergy effect: Establishing a synergy
cerebral responses to local thermal stimulation: an EEG study, Int. J.
between building network and peer network energy conservation effects, Energy
Psychophysiol. 113 (2017) 17–22, https://doi.org/10.1016/j.
Build. (2014), https://doi.org/10.1016/j.enbuild.2013.09.017.
ijpsycho.2017.01.003.
[3] Y.S. Tsay, R. Chen, C.C. Fan, Study on thermal comfort and energy conservation
[27] J.R. Lim, G.H. Baek, E.S. Jeon, Analysis of the correlation between thermal
potential of office buildings in subtropical Taiwan, Build. Environ. 208 (2022),
sensations and brain waves via EEG measurements, Int. J. Appl. Eng. Res. 13
108625, https://doi.org/10.1016/J.BUILDENV.2021.108625.
(2018) 6069–6075. http://www.ripublication.com. (Accessed 1 April 2022).
[4] Y. Al Horr, M. Arif, A. Kaushik, A. Mazroei, M. Katafygiotou, E. Elsarrag, Occupant
[28] S.A. Mansi, I. Pigliautile, C. Porcaro, A.L. Pisello, M. Arnesano, Application of
productivity and office indoor environment quality: a review of the literature,
Build. Environ. 105 (2016) 369–389, https://doi.org/10.1016/J. wearable EEG sensors for indoor thermal comfort measurements, Acta IMEKO 10
(2021) 214–220, https://doi.org/10.21014/acta_imeko.v10i4.1180.
BUILDENV.2016.06.001.
[29] Y.J. Son, C. Chun, Research on electroencephalogram to measure thermal pleasure
[5] A.L. Pisello, C. Piselli, F. Cotana, Influence of human behavior on cool roof effect
for summer cooling, Build. Environ. 88 (2015) 116–128, https://doi.org/10.1016/ in thermal alliesthesia in temperature step-change environment, Indoor Air 28
(2018) 916–923, https://doi.org/10.1111/INA.12491.
J.BUILDENV.2014.09.025.
[30] Research in physiology signal change of thermal-comfort evaluation by air
[6] J. Wu, C. Liu, H. Wang, Analysis of Spatio-temporal patterns and related factors of
conditioner temperature change, Korea Science, (n.d.), Journal of Fisheries and
thermal comfort in subtropical coastal cities based on local climate zones, Build.
Marine Sciences Education (2022), https://www.koreascience.kr/article/JAKO2
Environ. 207 (2022), https://doi.org/10.1016/J.BUILDENV.2021.108568.
[7] F. Stazi, F. Naspi, M. D’Orazio, A literature review on driving factors and 00610103441292.page. (Accessed 1 April 2022).
contextual events influencing occupants’ behaviours in buildings, Build. Environ. [31] J.R. Lim, G.H. Baek, E.S. Jeon, Analysis of the correlation between thermal
118 (2017) 40–66, https://doi.org/10.1016/J.BUILDENV.2017.03.021. sensations and brain waves via EEG measurements, Int. J. Appl. Eng. Res. 13
(2018) 6069–6075.
[8] X. Zhang, X. Chao, L. Lou, J. Fan, Q. Chen, B. Li, L. Ye, D. Shou, Personal thermal
[32] A. Gautam, ECG analysis using continuous wavelet Transform (CWT), IOSR J. Eng.
management by thermally conductive composites: a review, Compos. Commun. 23
(2012) 632–635, https://doi.org/10.9790/3021-0204632635, 02.
(2021), 100595, https://doi.org/10.1016/J.COCO.2020.100595.
[9] E. Delzendeh, S. Wu, A. Lee, Y. Zhou, The impact of occupants’ behaviours on [33] B.J. Singstad, N. Azulay, A. Bjurstedt, S.S. Bjørndal, M.F. Drageseth, P. Engeset,
K. Eriksen, M.Y. Gidey, E.O. Granum, M.G. Greaker, A. Grorud, S.O. Hewes, J. Hou,
building energy analysis: a research review, Renew. Sustain. Energy Rev. 80 (2017)
1061–1071, https://doi.org/10.1016/J.RSER.2017.05.264. A.M. Llop Recha, C. Matre, A. Seputis, S.E. Sørensen, V. Thøgersen, V.M. Joten,
C. Tronstad, Ø.G. Martinsen, Estimation of heart rate variability from finger
[10] L. Lou, D. Shou, H. Park, D. Zhao, Y.S. Wu, X. Hui, R. Yang, E.C. Kan, J. Fan,
photoplethysmography during rest, mild exercise and mild mental stress, J. Electr.
Thermoelectric air conditioning undergarment for personal thermal management
Bioimpedance. 12 (2021) 89, https://doi.org/10.2478/JOEB-2021-0012.
and HVAC energy saving, Energy Build. 226 (2020), 110374, https://doi.org/
[34] Z. Zhang, Z. Pi, B. Liu, TROIKA: a general framework for heart rate monitoring
10.1016/J.ENBUILD.2020.110374.
[11] M.V. Bavaresco, S. D’Oca, E. Ghisi, R. Lamberts, Technological innovations to using wrist-type photoplethysmographic signals during intensive physical exercise,
IEEE Trans. Biomed. Eng. 62 (2015) 522–531, https://doi.org/10.1109/
assess and include the human dimension in the building-performance loop: a
TBME.2014.2359372.
review, Energy Build. 202 (2019), 109365, https://doi.org/10.1016/J.
[35] A.A. Alian, K.H. Shelley, Photoplethysmography, Best Pract. Res. Clin.
ENBUILD.2019.109365.
Anaesthesiol. 28 (2014) 395–406, https://doi.org/10.1016/J.BPA.2014.08.006.
[12] V.L. Castaldo, I. Pigliautile, F. Rosso, F. Cotana, F. De Giorgio, A.L. Pisello, How
subjective and non-physical parameters affect occupants’ environmental comfort [36] L. Carlos, M. Vanderlei, C.M. Pastre, R.A. Hoshi, T. Dias De Carvalho, M. Fernandes
perception, Energy Build. 178 (2018) 107–129, https://doi.org/10.1016/J. De Godoy, M.V. Rua Bela, Basic notions of heart rate variability and its clinical
applicability, Rev. Bras. Cir. Cardiovasc. 24 (2009) 205–217.
ENBUILD.2018.08.020.
[37] Y. Yao, Z. Lian, W. Liu, Q. Shen, Experimental study on physiological responses and
[13] M. Franke, C. Nadler, Towards a holistic approach for assessing the impact of IEQ
on satisfaction, health, and productivity, Build. Res. Inf. (2020) 1–28, https://doi. thermal comfort under various ambient temperatures, Physiol. Behav. 93 (2008)
310–321, https://doi.org/10.1016/J.PHYSBEH.2007.09.012.
org/10.1080/09613218.2020.1788917, 0.
[14] W. O’Brien, A. Wagner, M. Schweiker, A. Mahdavi, J. Day, M.B. Kjærgaard, [38] W. Liu, Z. Lian, Y. Liu, Heart rate variability at different thermal comfort levels,
Eur. J. Appl. Physiol. 103 (2008) 361–366, https://doi.org/10.1007/S00421-008-
S. Carlucci, B. Dong, F. Tahmasebi, D. Yan, T. Hong, H.B. Gunay, Z. Nagy, C. Miller,
0718-6.
C. Berger, Introducing IEA EBC annex 79: key challenges and opportunities in the
[39] Y. Yao, Z. Lian, W. Liu, C. Jiang, Y. Liu, H. Lu, Heart rate variation and
field of occupant-centric building design and operation, Build. Environ. 178
electroencephalograph - the potential physiological factors for thermal comfort
(2020), https://doi.org/10.1016/J.BUILDENV.2020.106738.
study, Indoor Air 19 (2009) 93–101, https://doi.org/10.1111/J.1600-
[15] W.S. Suen, G. Huang, Z. Kang, Y. Gu, J. Fan, D. Shou, Development of wearable air-
0668.2008.00565.X.
conditioned mask for personal thermal management, Build. Environ. 205 (2021),
[40] H. Zhu, H. Wang, Z. Liu, D. Li, G. Kou, C. Li, Experimental study on the human
108236, https://doi.org/10.1016/J.BUILDENV.2021.108236.
thermal comfort based on the heart rate variability (HRV) analysis under different
[16] M. Schweiker, E. Ampatzi, M.S. Andargie, R.K. Andersen, E. Azar, V.M. Barthelmes,
environments, Sci. Total Environ. (2018), https://doi.org/10.1016/j.
C. Berger, L. Bourikas, S. Carlucci, G. Chinazzo, L.P. Edappilly, M. Favero,
scitotenv.2017.10.208.
S. Gauthier, A. Jamrozik, M. Kane, A. Mahdavi, C. Piselli, A.L. Pisello, A. Roetzel,
[41] G. Turpin, T. Grandfield, Electrodermal activity, Encycl. Stress (2007) 899–902,
A. Rysanek, K. Sharma, S. Zhang, Review of multi-domain approaches to indoor
https://doi.org/10.1016/B978-012373947-6.00139-2.
environmental perception and behaviour, Build. Environ. (2020), https://doi.org/
[42] J.H. Choi, D. Yeom, Study of data-driven thermal sensation prediction model as a
10.1016/j.buildenv.2020.106804.
function of local body skin temperatures in a built environment, Build. Environ.
[17] M. Schweiker, G.M. Huebner, B.R.M. Kingma, R. Kramer, H. Pallubinsky, Drivers of
diversity in human thermal perception – a review for holistic comfort models, 121 (2017) 130–147, https://doi.org/10.1016/J.BUILDENV.2017.05.004.
Temperature 5 (2018) 308–342, https://doi.org/10.1080/ [43] Office thermal comfort state analysis based on physiological signal from wearable
device – Fingerprint, Yonsei University, (n.d.), https://yonsei.pure.elsevier.com/
23328940.2018.1534490.
en/publications/office-thermal-comfort-state-analysis-based-on-physiological-s
[18] Y. Geng, W. Ji, Z. Wang, B. Lin, Y. Zhu, A review of operating performance in green ign/fingerprints/?sortBy=alphabetically. (Accessed 1 April 2022).
buildings: energy use, indoor environmental quality and occupant satisfaction,
Energy Build. 183 (2019) 500–514, https://doi.org/10.1016/J. [44] B. Kobas, S.C. Koth, K. Nkurikiyeyezu, G. Giannakakis, T. Auer, Y. Yamamoto,
Effect of exposure time on thermal behaviour: a psychophysiological approach, 2,
ENBUILD.2018.11.017.
2021, Signals 2 (2021) 863–885, https://doi.org/10.3390/SIGNALS2040050,
[19] S. Liu, S. Schiavon, H.P. Das, M. Jin, C.J. Spanos, Personal thermal comfort models
863–885.
with wearable sensors, Build. Environ. (2019), https://doi.org/10.1016/j.
[45] Q. Xu, L. Chen, H. Chen, B.J. Dewancker, Exercise thermal sensation: physiological
buildenv.2019.106281.
response to dynamic-static steps at moderate exercise, Int. J. Environ. Res. Publ.
[20] T. Chaudhuri, Y.C. Soh, H. Li, L. Xie, Machine learning driven personal comfort
Health 18 (2021), https://doi.org/10.3390/IJERPH18084239.
prediction by wearable sensing of pulse rate and skin temperature, Build. Environ.
[46] O.E. Krigolson, C.C. Williams, A. Norton, C.D. Hassall, F.L. Colino, Choosing MUSE:
170 (2020), 106615, https://doi.org/10.1016/J.BUILDENV.2019.106615.
validation of a low-cost, portable EEG system for ERP research, Front. Neurosci. 11
[21] J. Kim, Y. Zhou, S. Schiavon, P. Raftery, G. Brager, Personal comfort models:
predicting individuals’ thermal preference using occupant heating and cooling (2017), https://doi.org/10.3389/FNINS.2017.00109.
behavior and machine learning, Build. Environ. 129 (2018) 96–106, https://doi. [47] M. Garbarino, M. Lai, S. Tognetti, R. Picard, D. Bender, Empatica E3 - a wearable
wireless multi-sensor device for real-time computerized biofeedback and data
org/10.1016/J.BUILDENV.2017.12.011.
acquisition. https://doi.org/10.4108/icst.mobihealth.2014.257418, 2014, 39-42.
[22] S.A. Mansi, G. Barone, C. Forzano, I. Pigliautile, M. Ferrara, A.L. Pisello,
[48] E.E. van der Wall, The brain-heart connection; a round trip, Undefined 19 (2011)
M. Arnesano, Measuring human physiological indices for thermal comfort
269–270, https://doi.org/10.1007/S12471-011-0161-X.
assessment through wearable devices: a review, Meas. J. Int. Meas. Confed. 183
[49] K. Ritz, M.A. van Buchem, M.J. Daemen, The heart-brain connection: mechanistic
(2021), 109872, https://doi.org/10.1016/j.measurement.2021.109872.
insights and models, Neth. Heart J. 21 (2013) 55–57, https://doi.org/10.1007/
[23] P.A. Abhang, B.W. Gawali, S.C. Mehrotra, Technological basics of EEG recording
S12471-012-0348-9.
and operation of apparatus, introd. To EEG- speech-based emot, Recognit (2016)
19–50, https://doi.org/10.1016/B978-0-12-804490-2.00002-6.
13

S.A. Mansi et al. B u i l d i n g a n d E n v i r o n m e n t 222(2022)109385
[50] Chapter 01: heart-brain communication, HeartMath Institute, (n.d.), https://www. [63] M. Malik, A. John Camm, J. Thomas Bigger, G. Breithardt, S. Cerutti, R.J. Cohen,
heartmath.org/research/science-of-the-heart/heart-brain-communication/. P. Coumel, E.L. Fallen, H.L. Kennedy, R.E. Kleiger, F. Lombardi, A. Malliani, A.
(Accessed 17 January 2022). J. Moss, J.N. Rottman, G. Schmidt, P.J. Schwartz, D.H. Singer, Heart rate
[51] R. Paus, Exploring the “brain-skin connection”: leads and lessons from the hair variability: standards of measurement, physiological interpretation, and clinical
follicle, Curr. Res. Transl. Med. 64 (2016) 207–214, https://doi.org/10.1016/J. use, Circulation 93 (1996) 1043–1065, https://doi.org/10.1161/01.cir.93.5.1043.
RETRAM.2016.10.003. [64] J. Sztajzel, Heart rate variability: a noninvasive electrocardiographic method to
[52] D. Roosterman, T. Goerge, S.W. Schneider, N.W. Bunnett, M. Steinhoff, Neuronal measure the autonomic nervous system, Swiss Med. Wkly. 134 (2004) 514–522,
control of skin function: the skin as a neuroimmunoendocrine organ, Physiol. Rev. https://doi.org/2004/35/smw-10321.
86 (2006) 1309–1379, https://doi.org/10.1152/PHYSREV.00026.2005/ASSET/ [65] M. Malik, A. John Camm, J. Thomas Bigger, G. Breithardt, S. Cerutti, R.J. Cohen,
IMAGES/LARGE/Z9J0040624160008. JPEG. P. Coumel, E.L. Fallen, H.L. Kennedy, R.E. Kleiger, F. Lombardi, A. Malliani, A.
[53] A.A. Romanovsky, The thermoregulation system and how it works, Handb. Clin. J. Moss, J.N. Rottman, G. Schmidt, P.J. Schwartz, D.H. Singer, Heart rate
Neurol. 156 (2018) 3–43, https://doi.org/10.1016/B978-0-444-63912-7.00001-1. variability: standards of measurement, physiological interpretation, and clinical
[54] A.L. Pisello, I. Pigliautile, M. Andargie, C. Berger, P.M. Bluyssen, S. Carlucci, use, Circulation 93 (1996) 1043–1065, https://doi.org/10.1161/01.
G. Chinazzo, Z. Deme Belafi, B. Dong, M. Favero, A. Ghahramani, G. Havenith, CIR.93.5.1043.
A. Heydarian, D. Kastner, M. Kong, D. Licina, Y. Liu, A. Luna-Navarro, A. Mahdavi, [66] S. Taylor, N. Jaques, W. Chen, S. Fedor, A. Sano, R. Picard, Automatic
A. Nocente, M. Schweiker, M. Touchie, M. Vellei, F. Vittori, A. Wagner, A. Wang, identification of artifacts in electrodermal activity data, 2015-Novem, in: Proc.
S. Wei, Test rooms to study human comfort in buildings: a review of controlled Annu. Int. Conf. IEEE Eng. Med. Biol. Soc. EMBS., 2015, pp. 1934–1937, https://
experiments and facilities, Renew. Sustain. Energy Rev. 149 (2021), 111359, doi.org/10.1109/EMBC.2015.7318762.
https://doi.org/10.1016/J.RSER.2021.111359. [67] A. Greco, G. Valenza, A. Lanata, E.P. Scilingo, L. Citi, CvxEDA: a convex
[55] F. Vittori, C. Chiatti, I. Pigliautile, A.L. Pisello, The NEXT.ROOM: design principles optimization approach to electrodermal activity processing, IEEE Trans. Biomed.
and systems trials of a novel test room aimed at deepening our knowledge on Eng. 63 (2016) 797–804, https://doi.org/10.1109/TBME.2015.2474131.
human comfort, Build. Environ. 211 (2022), 108744, https://doi.org/10.1016/J. [68] ISO, Evaluation of Measurement Data — Guide to the Expression of Uncertainty in
BUILDENV.2021.108744. Measurement, vol. 50, Int. Organ. Stand, Geneva, 2008, p. 134. http://www.bipm.
[56] ISO - ISO 7730, Ergonomics of the Thermal Environment — Analytical org/en/publications/guides/gum.html.
Determination and Interpretation of Thermal Comfort Using Calculation of the [69] M. Brzezinski, The Chen-Shapiro test for normality, STATA J. 12 (2012) 368–374,
PMV and PPD Indices and Local Thermal Comfort Criteria, 2005 (n.d.), https://doi.org/10.1177/1536867X1201200302.
https://www.iso.org/standard/39155.html. (Accessed 24 February 2022). [70] H. Arsham, M. Lovric, Bartlett’s test, Int. Encycl. Stat. Sci. (2011) 87–88, https://
[57] E. Ratti, S. Waninger, C. Berka, G. Ruffini, A. Verma, Comparison of medical and doi.org/10.1007/978-3-642-04898-2_132.
consumer wireless EEG systems for use in clinical trials, Front. Hum. Neurosci. 11 [71] P.A. Games, Alternative analyses of repeated-measure designs by ANOVA and
(2017), https://doi.org/10.3389/FNHUM.2017.00398. MANOVA, Stat. Methods Longitud. Res. (1990) 81–121, https://doi.org/10.1016/
[58] O.E. Krigolson, C.C. Williams, A. Norton, C.D. Hassall, F.L. Colino, Choosing MUSE: B978-0-12-724960-5.50008-1.
validation of a low-cost, portable EEG system for ERP research, Front. [72] E. Ostertagov´a, O. Ostertag, J. Kova´ˇc, Methodology and application of the Kruskal-
InNeuroscience. 11 (2017), https://doi.org/10.3389/fnins.2017.00109. Wallis test, Appl. Mech. Mater. 611 (2014) 115–120, https://doi.org/10.4028/
[59] (n.d.), https://mind-monitor.com/. WWW.SCIENTIFIC.NET/AMM.611.115.
[60] F. Faul, E. Erdfelder, A.G. Lang, A. Buchner, G*Power 3: a flexible statistical power [73] D.E. Critchlow, M.A. Fligner, On distribution-free multiple comparisons in the one-
analysis program for the social, behavioral, and biomedical sciences, Behav. Res. way analysis of variance. https://doi.org/10.1080/03610929108830487, 2007,
Methods 39 (2007) 175–191, https://doi.org/10.3758/BF03193146. 20,127-139.
[61] EEG-Signal Processing Lecture Notes for BSP, Chapter 5 Master Program Data [74] W. von Rosenberg, T. Chanwimalueang, T. Adjei, U. Jaffer, V. Goverdovsky, D.
Engineering, (n.d.). P. Mandic, Resolving ambiguities in the LF/HF ratio: LF-HF scatter plots for the
[62] hrv-analysis ⋅ PyPI (n.d.), https://pypi.org/project/hrv-analysis/. (Accessed 29 categorization of mental and physical stress from HRV, Front. Physiol. 8 (2017),
October 2021). https://doi.org/10.3389/FPHYS.2017.00360/FULL.
14
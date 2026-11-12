Downloaded from orbit.dtu.dk on: Jul 07, 2026
Physiological sensing for thermal comfort assessment
Bogatu, Dragos-Ioan; Shinoda, Jun; Aguilera, José Joaquín; Olesen, Bjarne W.; Watanabe, Futa ;
Kaneko, Yosuke ; Kazanci, Ongun B.
Published in:
Proceedings of 43rd AIVC Conference
Publication date:
2023
Document Version
Publisher's PDF, also known as Version of record
Link back to DTU Orbit
Citation (APA):
Bogatu, D.-I., Shinoda, J., Aguilera, J. J., Olesen, B. W., Watanabe, F., Kaneko, Y., & Kazanci, O. B. (2023).
Physiological sensing for thermal comfort assessment. In Proceedings of 43rd AIVC Conference: Ventilation,
IEQ and health in sustainable buildings (pp. 856-866). Article 117 https://www.aivc.org/resource/physiological-
sensing-thermal-comfort-assessment?volume=39582
General rights
Copyright and moral rights for the publications made accessible in the public portal are retained by the authors and/or other copyright
owners and it is a condition of accessing publications that users recognise and abide by the legal requirements associated with these rights.
 Users may download and print one copy of any publication from the public portal for the purpose of private study or research.
 You may not further distribute the material or use it for any profit-making activity or commercial gain
 You may freely distribute the URL identifying the publication in the public portal
If you believe that this document breaches copyright please contact us providing details, and we will remove access to the work immediately
and investigate your claim.

Physiological sensing for thermal comfort assessment
Dragos-Ioan Bogatu*1, Jun Shinoda1, José Joaquín Aguilera2, Bjarne W. Olesen1,
Futa Watanabe3, Yosuke Kaneko3, and Ongun B. Kazanci1
1 International Centre for Indoor Environment and 2 Section of Thermal Energy, Department Civil and
Energy – ICIEE, Department of Environmental and Mechanical Engineering, Technical University of
Resource Engineering, Technical University of Denmark
Denmark Nils Koppels Allé, Building 403,
Nils Koppels Allé, Building 402 2800 Kgs. Lyngby, Denmark
2800 Kgs. Lyngby, Denmark
*Corresponding author: drabo@dtu.dk
3 Mitsubishi Electric Corporation
5-1-1 Ofuna, Kamakura
Kanagawa 247-8501, Japan
ABSTRACT
Accounting for inter- and intra-personal differences requires individual and cohort comfort models. For their
development, emulators for thermal sensation of occupants are needed. Physiological signals can be acquired using
both wearable and contactless devices. However, due to the widespread availability of sensing methods it is
difficult to select the proper measuring method for the application. The objective of this study is to provide an
overview of the capabilities of contemporary devices that measure physiological indicators used in literature and
identify their capabilities and limitations. The analysis was made on a dataset of reviewed thermal comfort research
studies that employed physiological sensing devices in experimental and field test campaigns. The physiological
indicators investigated in literature were derived from the human thermoregulation mechanism. The physiological
indicators measured were neural activity (brainwave frequency bands), heartbeat (heart rate and heart rate
variability), blood flow (blood pressure, blood oxygen saturation, skin blood flow), activity (metabolic rate,
activity, calorie consumption), temperature (core and skin), sweat (relative humidity, skin conductance, skin
hardness, and amount of sweat). The wrist is the most investigated body part as it is a convenient area for acquiring
multiple physiological indicators i.e., all physiological measurements except for ECG and EEG measurements.
However, most devices are not “plug-and-play” solutions for thermal comfort assessment. As contact devices,
smartbands acquire an extensive set of indicators but present 3rd party data privacy protocols which may limit their
applicability. Cameras (RGB and infrared) can only be used to acquire skin temperature and heart rate but can be
deployed in the space by the building owner. Further studies are required on the sensing accuracy and signal
variability as a function of thermal sensation to determine the optimal measurement method.
KEYWORDS
Thermal comfort, sensing strategies, physiological indicators, wearable/contactless, sensing performance
1 INTRODUCTION
In order to deal with inter- and intra-personal differences, personal and cohort thermal comfort
models were proposed (Kim, Schiavon, and Brager 2018; Quintana et al. 2022). However, these
models require input from or representative of the occupant in question (Deng and Chen 2020;
Laftchiev and Nikovski 2017). As thermal comfort is a function of thermoregulatory aspects,
emulators such as physiological signals could be used to distinguish between thermal sensation
of different people and for the same person over time (Bogatu et al. 2023; Lee and Ham 2021).

Further studies are though required on the set of indicators and their variability as a function of
thermal sensation across people with different anthropometric characteristics and behaviour.
With economically feasible physiological sensing methods emerging, wearable sensing devices
become widespread and monitoring physiological indicators becomes simpler in both
experiments and field studies. However, with a market under constant change it is difficult to
select the proper measuring method for the application. The objective of this study is to provide
an overview of the capabilities of current physiological indicator measuring devices used in
literature and identify their benefits and limitations.
2 METHODS
The objective was to identify current physiological indicator measuring techniques in thermal
comfort studies. The analysis was made on an existing dataset (Bogatu et al. 2023) where the
objective was to determine relevant indicators for data driven thermal comfort prediction for
HVAC control. The dataset was generated using Google Scholar, Scopus, and Web of Science,
and the “reference by reference” method.
For finding relevant research studies permutations, combinations, and specific keywords such
as physiological, physiology, wearable, contactless, smart control, control, smart building,
thermal comfort, sensing were used. The database consisted of 94 articles that measured
physiological indicators, used either physiological, environmental, behavioural, or
anthropometric measurements in personal comfort model development, or integrated occupant
feedback or physiological indicators in the HVAC control.
3 RESULTS
3.1 Physiological indicators
Physiological indicators used in thermal comfort studies are derived from human
thermoregulation mechanism (Bogatu et al. 2023). Thermoregulation is controlled by the
central nervous system, which sends nerve impulses based on signals received at skin level.
The nervous system regulates blood flow through the heart and through the constriction and
dilation of vessels, perspiration, and metabolic rate to regulate body temperature. Therefore,
physiological indicators can be obtained from:
• Neural activity: brainwave frequency bands.
• Heartbeat: heart rate (HR) and heart rate variability (HRV).
• Blood flow: blood pressure (BP), blood oxygen saturation (SpO ), skin blood flow (BF).
2
• Activity: metabolic rate (MET), activity, calorie consumption.
• Temperature: core (T ), skin temperature (T ).
CORE SK
• Sweat: skin relative humidity (RH ), skin conductance (SC), skin hardness, and
SK
amount of sweat.
3.2 Physiological indicator sensing
Figure 1 shows the frequency of investigated body parts and the corresponding indicators. Most
measurements were made at the wrist level, followed by the forehead, hand, upper arm, cheek,
chest, forearm, thigh, ankle, neck, abdomen, waist, ankle, and calf. A collection of the sensors
employed in literature and their characteristics can be found in the Appendix.
Neural activity can be recorded at the head level by an electroencephalogram (EEG) instrument
consisting of electrodes which measure brain electrical activity (Pigliautile et al. 2020).
Advanced instruments are available where the electrodes are attached to a headset (Kim and
Hong 2020; Pigliautile et al. 2020). Although portable, these devices must be in contact with

the subject during the measurement and require dedicated software to analyse the obtained
information. The analysis of the brainwaves power spectrum is made with a fast Fourier
transform method to obtain the distribution of the magnitude of signals within particular
frequency bands, such as Alpha, Beta, Delta, Theta, and Gamma ranges (Shan and Yang 2020).
Recent devices are convenient, becoming light and easy to set up but highly intrusive if intended
for long term use (Pigliautile et al. 2020; Shan and Yang 2020).
HR can be derived from HRV which can be obtained by measuring the heart’s electrical activity
(Chaudhuri et al. 2018; Nkurikiyeyezu, Suzuki, and Lopez 2018). Error! Reference source
not found.The HRV is usually measured at the chest level or a combination of chest, arm, wrist,
thigh, and ankle through electrodes placed on the skin (Gwak et al. 2016; Zhu et al. 2018). Since
the electrodes are in contact with the skin, electrocardiogram (ECG) devices must be in
occupant proximity. Although intrusive, wearable devices (medical and commodity sensors)
for chest placement are available (Liu et al. 2019; Pigliautile et al. 2020). If other indicators
than HR must be obtained, these devices are no longer “plug and play” and may require
additional data processing.
Figure 1. Frequency of physiological measurements across the human body.
Photoplethysmography (PPG) measures blood volume changes in the vessels, where light
transmitted from a source onto the skin tissue is being either absorbed or reflected. The increase
in blood volume is obtained based on the relative change in the light captured by the
photodetector (Jung and Jazizadeh 2018b). PPG measurements can be made at the skin level,
e.g., on the face where there is a high density of blood vessels (Ghahramani et al. 2016), at the
wrist (Laftchiev and Nikovski 2017), or finger (Chaudhuri et al. 2020). Wrist measurements
usually make use of smartbands or smartwatches equipped with a PPG sensor (Lee and Ham
2021). Blood volume changes measured at the face level are usually contactless and are
obtained using Red Green Blue (RGB) cameras that track tiny colour changes in the reflected
light of the region of interest (Dabiri and Jazizadeh 2014; Jung and Jazizadeh 2018a). Blood
flow can be measured through laser Doppler flowmeters - similar principle to PPG using
different light frequencies (Cheng, Lee, and Huang 2018). This technology was mainly used
for measuring the microvascular blood flow at the finger (Cheng et al. 2018) or foot (Song et
al. 2016) level. Blood pressure was measured by using a sphygmomanometer (inflatable cuff
coupled to a manometer) and was rarely employed most likely due to the difficulty of obtaining
a continuous measurement. SpO can also be obtained through PPG at the finger level
2
(Chaudhuri et al. 2018, 2020). An indirect measurement of blood oxygen intake, respiration,

was measured contactless using Doppler radar sensors through the motion of the chest and
abdomen areas (Jung and Jazizadeh 2018a). BF, BP, and SpO were investigated using medical
2
and research grade sensors where devices were placed in contact with the skin.
The MET can be measured with a cardiopulmonary tester (Song et al. 2016). This involves a
spiroergometer device where a mask is used to analyse the oxygen and carbon dioxide in the
inhaled and exhaled air. Although portable products exist, they cannot be worn in daily life due
to their intrusiveness. Activity level, representative of the MET, is usually measured instead
(Lee and Ham 2021). Motion-based activity was measured using either wrist or chest connected
tri-axial accelerometer devices. These sensors are relatively cheap and are usually integrated in
smartwatches and smartbands (Laftchiev and Nikovski 2017). Other approaches involved the
use of weight and calorie consumption estimation (Huang, Yang, and Newman 2015).
T is approximately measurable from the oesophagus, rectum, gastro-intestinal tract, mouth,
CORE
tympanum, auditory canal regions (CEN 2021). Other options are radio-pills (Wang et al. 2007)
or predicting it from heart rate measurements with high accuracy (Nazarian et al. 2021). The
inner eye is also a suitable measurement point, obtainable using thermal cameras (Metzmacher
et al. 2018). However, certain studies considered the eye temperature as the T (Cosma and
SK
Simha 2019a, 2019b). A wireless non-invasive thermometer which estimates T based on
CORE
T and heat flux is also available, though costly (Ajčević et al. 2022).
SK
T can be obtained using both wearable and contactless devices (Hwang et al. 2019; Salehi,
SK
Ghanbaran, and Maerefat 2020). Except for measurements on the eye, T represents the most
SK
investigated indicator for each human body part. The standard way of measuring T involves
SK
the use of low-cost thermocouples (Jung and Jazizadeh 2018b; Liu et al. 2020) and resistance
temperature detectors (Lopez et al. 2016) which are wired to a logging system. This method is
highly intrusive and makes it difficult to perform daily activities. Wireless T sensors are also
SK
available, consisting of button sized devices (Liu et al. 2019), which can be attached to the skin
through e.g., medical tape. These devices cannot transfer data in real-time though, making them
impractical for smart system integration. Smartwatches and smartbands were previously
reported throughout literature as useful for measuring T in the wrist area due to the convenient
SK
placement of the sensors (Barrios and Kleiminger 2017; Deng and Chen 2020; W. Li, Zhang,
and Zhao 2019; Yoshikawa et al. 2019). Still, few newer smartwatch/smartband devices make
available T as a signal. The facial area has also drawn extensive attention due to the
SK
appearance of low-cost contactless monitoring technologies (Ranjan and Scott 2016;
Warthmann et al. 2018). T was obtained through thermal infrared cameras generally pointed
SK
at the face, a feasible non-intrusive method (Cosma and Simha 2019b; Li et al. 2020; Lu et al.
2019; Pavlin et al. 2017), or through infrared lasers which must be close to the skin level for a
continuous measurement of the point of interest (Luo et al. 2018). An innovative solution was
found in literature where infrared sensors were attached to a pair of glasses (Ghahramani et al.
2016). The main advantage of contactless T measurements is that the measurement is not
SK
influenced by the sensor covering the skin area under investigation (Metzmacher et al. 2018).
Skin relative humidity (RH ) was measured using button sized sensors in studies involving
SK
high physical activity (Priego-Quesada et al. 2020). Sweat rate was also directly measured with
an innovative sensor (watch-type device with a capacitive humidity sensor) with low operation
power and weight (Sim, Yoon, and Cho 2018). SC, or electrodermal activity (EDA), can be
obtained through electrodes connected to the fingers (Pigliautile et al. 2020) or at the wrist level
through smartbands (Lee and Ham 2021). Only one mention of skin hardness was found in the
literature measured using a durometer (not designed for skin hardness measurements) which
was placed at the skin level of the arm or wrist (Yoon et al. 2018).
3.3 Capabilities and limitations of current sensing strategies

A summary of capabilities and limitations of the physiological measurement strategies are
given in Table 1. The analysis was made by comparing wearable and contactless devices.
Wearable devices represent relatively cheap and mature products. They can be wired or
wireless. Device examples are probes, telemetry devices, smartwatches/smartbands, and
headsets. Contactless examples found in literature are RGB cameras, infrared thermal cameras,
and devices employing laser Doppler velocimetry.
Table 1: Capabilities and limitations of measuring devices for physiological indicators.
Device Capabilities Limitations
Wearable • May be integrated in a device • Measurement length dependent on the battery life and data
attached to an occupant storage capacity of the equipment
• May measure multiple parameters • Could be intrusive and invasive (e.g., chest strap)
• Clothing does not interfere with • Accuracy issues (improper use, movement, fastening option)
the measurement • Sensor accuracies may be unknown
• Mature products • Covers body area where measurement is made
• May be relatively cheap • Narrow operating ranges
• Can be placed directly on the skin • Single point measurement
• Can be placed on different and • Influenced by physical pressure, insulation from fitting
multiple body areas material and thermal inertia of the sensor
• Can be connected via cloud-based • Inconvenient if wired
solutions
Contactless • Can gather data on body areas not • May require a complex system consisting of multiple nodes
covered by clothing, e.g. face (e.g. depth and thermal image camera)
• Non-invasive and non-intrusive • Privacy concerns
• Can capture a bigger surface area • Little flexibility regarding placement
• Can detect changes from the skin • Correction regarding clothing might be required
naturally and directly impacted by • May not be suitable for multi-occupancy spaces due to the
the surrounding environment limited field of view
• Error in detecting area of interest for measurements
• Can be difficult to implement in building due to size and
compatibility issues (e.g. in Building Management Systems).
• Higher cost compared to wearable sensors
4 DISCUSSION
As wearables, devices designed for measuring certain physiological indicators, e.g., HRV,
brainwave frequency bands, SpO , can be found though lacking wireless connectivity. Few
2
commodity health monitoring telemetry devices designed to acquire multiple physiological
indicators were observed (Chaudhuri et al. 2018). Smartbands/smartwatches were the most
complete devices, being able to measure multiple indicators, such as T , HR, SpO , and
SK 2
activity simultaneously. However, just as chest bands, they are commodity devices lacking
standardized datasheets with information on the device’s accuracy, resolution, and range.
Extracting real-time data from these devices may also not be possible or would require specific
knowledge. On the other hand, medical and research-grade devices are costly and usually
designed for measuring specific physiological indicators, e.g., SC and brainwave sensors.
For quantifying physiological indicators in real-time, RGB and infrared thermal cameras could
be feasible. RGB cameras are cheaper and usually available at the workspace. Although privacy
measures such as discarding images after data collection must be taken into account when
employing cameras (D. Li, Menassa, and Kamat 2019), these systems also enable pose tracking
(Qian et al. 2020; Yang et al. 2019), age, and clothing estimation (Rida et al. 2023), which may
complement T and HR measurements. Infrared thermal cameras present a wider working
SK
range than contact measurements (e.g., thermocouples) but have a slightly worse correlation
with the thermal sensation (Wu et al. 2019). When compared to resistance temperature sensors
(usually with an accuracy of ±0.2 °C) only a maximum of 0.5 to 0.7 K difference was observed
(Metzmacher et al. 2018). Low-cost options present low image resolution, which may lead to
difficulties in detecting the human profile, but information from the surrounding pixels

surrounding could reduce noise and thus improve stability. Combining RGB and infrared
thermal cameras may even increase measurement accuracy as the influence of light is reduced
generating clearer contours (Metzmacher et al. 2018). However, both solutions require
additional data processing for obtaining the desired parameters (Dabiri and Jazizadeh 2014).
From a practicality point of view, wearable devices are connected to the occupant which makes
it difficult to determine ownership, operation, and maintenance responsibility. Contactless
devices are deployed in the space. Although requiring the consent of the occupants, ownership,
operation, and maintenance can be performed by the building owner.
5 CONCLUSIONS
Acquiring physiological indicators in real-time still represents a difficult task and thus further
development of current sensing devices is required. Not all devices measuring physiological
indicators present real-time data access while “plug-and-play” solutions specifically designed
for thermal comfort assessment are lacking.
Contactless devices (e.g., RGB and infrared cameras) can only be used to acquire skin
temperature and heart rate and require extensive data processing. Wearable devices can be used
to acquire an extensive range of indicators, with the wrist area being the most versatile.
Smartwatches and smartbands are mature devices used to acquire multiple physiological
indicators (T , HR, SpO , and activity) simultaneously. Since they are mostly consumer
SK 2
products protected through 3rd party data privacy protocols, these devices cannot be deployed
in buildings with ease. Measurement accuracy represents a limitation for low cost contactless
solutions, which requires further investigation.
ACKNOWLEDGEMENTS
This study was financially supported by Mitsubishi Electric Corporation and by the
International Centre for Indoor Environment and Energy (ICIEE), Technical University of
Denmark (DTU).
REFERENCES
Ajčević, Miloš, Alex Buoite Stella, Giovanni Furlanis, Paola Caruso, Marcello Naccarato,
Agostino Accardo, and Paolo Manganotti. 2022. “A Novel Non-Invasive Thermometer
for Continuous Core Body Temperature: Comparison with Tympanic Temperature in an
Acute Stroke Clinical Setting.” Sensors 22(13):4760. doi: 10.3390/s22134760.
Barrios, Liliana, and Wilhelm Kleiminger. 2017. “The Comfstat - Automatically Sensing
Thermal Comfort for Smart Thermostats.” 2017 IEEE International Conference on
Pervasive Computing and Communications, PerCom 2017 257–66. doi:
10.1109/PERCOM.2017.7917872.
Bogatu, Dragos-Ioan, Jun Shinoda, Bjarne W. Olesen, Futa Watanabe, Yosuke Kaneko, and
Ongun B. Kazanci. 2023. “Human Physiology for Personal Thermal Comfort-Based
HVAC Control – A Review.” 240(April). doi: 10.1016/j.buildenv.2023.110418.
CEN. 2021. “EN ISO 9886 Ergonomics - Evaluation of Thermal Strain by Physiological
Measurements.”
Chaudhuri, Tanaya, Yeng Chai Soh, Hua Li, and Lihua Xie. 2020. “Machine Learning Driven
Personal Comfort Prediction by Wearable Sensing of Pulse Rate and Skin Temperature.”
Building and Environment 170(November 2019):106615. doi:
10.1016/j.buildenv.2019.106615.
Chaudhuri, Tanaya, Deqing Zhai, Yeng Chai Soh, Hua Li, and Lihua Xie. 2018. “Random
Forest Based Thermal Comfort Prediction from Gender-Specific Physiological

Parameters Using Wearable Sensing Technology.” Energy and Buildings 166:391–406.
doi: 10.1016/j.enbuild.2018.02.035.
Cheng, Chin Chi, Dashang Lee, and Bi Song Huang. 2018. “Estimated Thermal Sensation
Models by Physiological Parameters during Wind Chill Stimulation in the Indoor
Environment.” Energy and Buildings 172:337–48. doi: 10.1016/j.enbuild.2018.05.005.
Cosma, Andrei Claudiu, and Rahul Simha. 2019a. “Machine Learning Method for Real-Time
Non-Invasive Prediction of Individual Thermal Preference in Transient Conditions.”
Building and Environment 148(November 2018):372–83. doi:
10.1016/j.buildenv.2018.11.017.
Cosma, Andrei Claudiu, and Rahul Simha. 2019b. “Using the Contrast within a Single Face
Heat Map to Assess Personal Thermal Comfort.” Building and Environment
160(May):106163. doi: 10.1016/j.buildenv.2019.106163.
Dabiri, Sina, and Farrokh Jazizadeh. 2014. “Exploring Video Based Thermal Perception
Identification.”
Deng, Zhipeng, and Qingyan Chen. 2020. “Development and Validation of a Smart HVAC
Control System for Multi-Occupant Offices by Using Occupants’ Physiological Signals
from Wristband.” Energy and Buildings 214:109872. doi:
10.1016/j.enbuild.2020.109872.
Ghahramani, Ali, Guillermo Castro, Burcin Becerik-Gerber, and Xinran Yu. 2016. “Infrared
Thermography of Human Face for Monitoring Thermoregulation Performance and
Estimating Personal Thermal Comfort.” Building and Environment 109:1–11. doi:
10.1016/j.buildenv.2016.09.005.
Gwak, Jongseong, Motoki Shino, Kazutaka Ueda, and Minoru Kamata. 2016. “Effects of
Changes in the Thermal Factor on Arousal Level and Thermal Comfort.” Proceedings -
2015 IEEE International Conference on Systems, Man, and Cybernetics, SMC 2015
923–28. doi: 10.1109/SMC.2015.169.
Huang, Chuan Che Jeff, Rayoung Yang, and Mark W. Newman. 2015. “The Potential and
Challenges of Inferring Thermal Comfort at Home Using Commodity Sensors.”
UbiComp 2015 - Proceedings of the 2015 ACM International Joint Conference on
Pervasive and Ubiquitous Computing 1089–1100. doi: 10.1145/2750858.2805831.
Hwang, Jongmin, Jun Kim, Kee Joon Choi, Min Soo Cho, Gi Byoung Nam, and You Ho
Kim. 2019. “Assessing Accuracy of Wrist-Worn Wearable Devices in Measurement of
Paroxysmal Supraventricular Tachycardia Heart Rate.” Korean Circulation Journal
49(5):437–45. doi: 10.4070/KCJ.2018.0323.
Jung, Wooyoung, and Farrokh Jazizadeh. 2018a. “Towards Non-Intrusive Metabolic Rate
Evaluation for HVAC Control.” Icccbe 2018.
Jung, Wooyoung, and Farrokh Jazizadeh. 2018b. “Vision-Based Thermal Comfort
Quantification for HVAC Control.” Building and Environment 142(May):513–23. doi:
10.1016/j.buildenv.2018.05.018.
Kim, Hakpyeong, and Taehoon Hong. 2020. “Determining the Optimal Set-Point
Temperature Considering Both Labor Productivity and Energy Saving in an Office
Building.” Applied Energy 276(June):115429. doi: 10.1016/j.apenergy.2020.115429.
Kim, Joyce, Stefano Schiavon, and Gail Brager. 2018. “Personal Comfort Models – A New
Paradigm in Thermal Comfort for Occupant-Centric Environmental Control.” Building
and Environment 132(January):114–24. doi: 10.1016/j.buildenv.2018.01.023.
Laftchiev, Emil, and Daniel Nikovski. 2017. “An IoT System to Estimate Personal Thermal
Comfort.” 2016 IEEE 3rd World Forum on Internet of Things, WF-IoT 2016 672–77.
doi: 10.1109/WF-IoT.2016.7845401.
Lee, Jeehee, and Youngjib Ham. 2021. “Physiological Sensing-Driven Personal Thermal
Comfort Modelling in Consideration of Human Activity Variations.” Building Research
and Information 49(5):512–24. doi: 10.1080/09613218.2020.1840328.

Li, Da, Carol C. Menassa, and Vineet R. Kamat. 2019. “Robust Non-Intrusive Interpretation
of Occupant Thermal Comfort in Built Environments with Low-Cost Networked
Thermal Cameras.” Applied Energy 251(May). doi: 10.1016/j.apenergy.2019.113336.
Li, Da, Carol C. Menassa, Vineet R. Kamat, and Eunshin Byon. 2020. “HEAT - Human
Embodied Autonomous Thermostat.” Building and Environment 178(March). doi:
10.1016/j.buildenv.2020.106879.
Li, Wei, Jili Zhang, and Tianyi Zhao. 2019. “Indoor Thermal Environment Optimal Control
for Thermal Comfort and Energy Saving Based on Online Monitoring of Thermal
Sensation.” Energy and Buildings 197:57–67. doi: 10.1016/j.enbuild.2019.05.050.
Liu, Kuixing, Ting Nie, Wei Liu, Yiqing Liu, and Dayi Lai. 2020. “A Machine Learning
Approach to Predict Outdoor Thermal Comfort Using Local Skin Temperatures.”
Sustainable Cities and Society 59(March):102216. doi: 10.1016/j.scs.2020.102216.
Liu, Shichao, Stefano Schiavon, Hari Prasanna Das, Ming Jin, and Costas J. Spanos. 2019.
“Personal Thermal Comfort Models with Wearable Sensors.” Building and Environment
162(July):106281. doi: 10.1016/j.buildenv.2019.106281.
Lopez, Guillaume, Takahiro Tokuda, Naoya Isoyama, Hiroshi Hosaka, and Kiyoshi Itao.
2016. “Development of a Wrist-Band Type Device for Low-Energy Consumption and
Personalized Thermal Comfort.” 2016 11th France-Japan and 9th Europe-Asia
Congress on Mechatronics, MECATRONICS 2016 / 17th International Conference on
Research and Education in Mechatronics, REM 2016 209–12. doi:
10.1109/MECATRONICS.2016.7547143.
Lu, Siliang, Weilong Wang, Shihan Wang, and Erica Cochran Hameen. 2019. “Thermal
Comfort-Based Personalized Models with Non-Intrusive Sensing Technique in Office
Buildings.” Applied Sciences (Switzerland) 9(9). doi: 10.3390/app9091768.
Luo, Maohui, Edward Arens, Hui Zhang, Ali Ghahramani, and Zhe Wang. 2018. “Thermal
Comfort Evaluated for Combinations of Energy-Efficient Personal Heating and Cooling
Devices.” Building and Environment 143(April):206–16. doi:
10.1016/j.buildenv.2018.07.008.
Metzmacher, Henning, Daniel Wölki, Carolin Schmidt, Jérôme Frisch, and Christoph van
Treeck. 2018. “Real-Time Human Skin Temperature Analysis Using Thermal Image
Recognition for Thermal Comfort Assessment.” Energy and Buildings 158:1063–78.
doi: 10.1016/j.enbuild.2017.09.032.
Nazarian, Negin, Sijie Liu, Manon Kohler, Jason K. W. Lee, Clayton Miller, Winston T. L.
Chow, Sharifah Badriyah Alhadad, Alberto Martilli, Matias Quintana, Lindsey Sunden,
and Leslie K. Norford. 2021. “Project Coolbit: Can Your Watch Predict Heat Stress and
Thermal Comfort Sensation?” Environmental Research Letters 16(3). doi:
10.1088/1748-9326/abd130.
Nkurikiyeyezu, Kizito N., Yuta Suzuki, and Guillaume F. Lopez. 2018. “Heart Rate
Variability as a Predictive Biomarker of Thermal Comfort.” Journal of Ambient
Intelligence and Humanized Computing 9(5):1465–77. doi: 10.1007/s12652-017-0567-4.
Pavlin, Boris, Giovanni Pernigotto, Francesca Cappelletti, Paolo Bison, Renato Vidoni, and
Andrea Gasparella. 2017. “Real-Time Monitoring of Occupants’ Thermal Comfort
through Infrared Imaging: A Preliminary Study.” Buildings 7(1). doi:
10.3390/buildings7010010.
Pigliautile, Ilaria, Sara Casaccia, Nicole Morresi, Marco Arnesano, Anna Laura Pisello, and
Gian Marco Revel. 2020. “Assessing Occupants’ Personal Attributes in Relation to
Human Perception of Environmental Comfort: Measurement Procedure and Data
Analysis.” Building and Environment 177(March):106901. doi:
10.1016/j.buildenv.2020.106901.
Priego-Quesada, Jose Ignacio, Alvaro S. Machado, Marina Gil-Calvo, Irene Jimenez-Perez,
Rosa Ma Cibrian Ortiz de Anda, Rosario Salvador Palmer, and Pedro Perez-Soriano.

2020. “A Methodology to Assess the Effect of Sweat on Infrared Thermography Data
after Running: Preliminary Study.” Infrared Physics and Technology 109(April):103382.
doi: 10.1016/j.infrared.2020.103382.
Qian, Junpeng, Xiaogang Cheng, Bin Yang, Zhe Li, Junchi Ren, Thomas Olofsson, and Haibo
Li. 2020. “Vision-Based Contactless Pose Estimation for Human Thermal Discomfort.”
Atmosphere 11(4). doi: 10.3390/ATMOS11040376.
Quintana, Matias;, Stefano; Schiavon, Tartarini; Federico, Kim; Joyce, and Miller Clayton.
2022. “Cohort Comfort Models - Using Occupant’s Similarity to Predict Personal
Thermal Preference with Less Data.” Building and Environment 227:109685. doi:
10.1016/j.buildenv.2022.109685.
Ranjan, Juhi, and James Scott. 2016. “ThermalSense: Determining Dynamic Thermal
Comfort Preferences Using Thermographic Imaging.” UbiComp 2016 - Proceedings of
the 2016 ACM International Joint Conference on Pervasive and Ubiquitous Computing
1212–22. doi: 10.1145/2971648.2971659.
Rida, Mohamad;, Mohamed; Abdelfatth, Alexandre; Alahi, and Dolaana Khovalyg. 2023.
“Non-Intrusive Physiological Parameters Sensing for Personalized Human Thermal
Comfort Prediction.” in Healthy Buildings Europe 2023.
Salehi, Behrouz, Abdul Hamid Ghanbaran, and Mehdi Maerefat. 2020. “Intelligent Models to
Predict the Indoor Thermal Sensation and Thermal Demand in Steady State Based on
Occupants’ Skin Temperature.” Building and Environment 169(November
2019):106579. doi: 10.1016/j.buildenv.2019.106579.
Shan, Xin, and En Hua Yang. 2020. “Supervised Machine Learning of Thermal Comfort
under Different Indoor Temperatures Using EEG Measurements.” Energy and Buildings
225:110305. doi: 10.1016/j.enbuild.2020.110305.
Sim, Jai Kyoung, Sunghyun Yoon, and Young Ho Cho. 2018. “Wearable Sweat Rate Sensors
for Human Thermal Comfort Monitoring.” Scientific Reports 8(1):1–11. doi:
10.1038/s41598-018-19239-8.
Song, W. F., C. J. Zhang, D. D. Lai, F. M. Wang, and K. Kuklane. 2016. “Use of a Novel
Smart Heating Sleeping Bag to Improve Wearers’ Local Thermal Comfort in the Feet.”
Scientific Reports 6(January):1–10. doi: 10.1038/srep19326.
Wang, Danni, Hui Zhang, Edward Arens, and Charlie Huizenga. 2007. “Observations of
Upper-Extremity Skin Temperature and Corresponding Overall-Body Thermal
Sensations and Comfort.” Building and Environment 42(12):3933–43. doi:
10.1016/j.buildenv.2006.06.035.
Warthmann, Alexander, Daniel Wölki, Henning Metzmacher, and Christoph van Treeck.
2018. “Personal Climatization Systems-a Review on Existing and Upcoming Concepts.”
Applied Sciences (Switzerland) 9(1). doi: 10.3390/app9010035.
Wu, Yuxin, Hong Liu, Baizhan Li, and Risto Kosonen. 2019. “Prediction of Thermal
Sensation Using Low-Cost Infrared Array Sensors Monitoring System.” IOP Conference
Series: Materials Science and Engineering 609(3). doi: 10.1088/1757-
899X/609/3/032002.
Yang, Bin, Xiaogang Cheng, Dengxin Dai, Thomas Olofsson, Haibo Li, and Alan Meier.
2019. “Real-Time and Contactless Measurements of Thermal Discomfort Based on
Human Poses for Energy Efficient Control of Buildings.” Building and Environment
162(July):106284. doi: 10.1016/j.buildenv.2019.106284.
Yoon, Sunghyun, Jai Kyoung Sim, Noeul Park, and Young Ho Cho. 2018. “Evaluation of
Skin Hardness as a Physiological Sign of Human Thermal Status.” Scientific Reports
8(1):1–6. doi: 10.1038/s41598-018-30206-1.
Yoshikawa, Hiroki, Akira Uchiyama, Yuki Nishikawa, and Teruo Higashino. 2019.
“Combining a Thermal Camera and a Wristband Sensor for Thermal Comfort
Estimation.” 2019 ACM International Symposium 238–41. doi:

10.1145/3341162.3343813.
Zhu, Hui, Hanqing Wang, Zhiqiang Liu, Duanru Li, Guangxiao Kou, and Can Li. 2018.
“Experimental Study on the Human Thermal Comfort Based on the Heart Rate
Variability (HRV) Analysis under Different Environments.” Science of the Total
Environment 616–617:1124–33. doi: 10.1016/j.scitotenv.2017.10.208.

APPENDIX
Table 2. Characteristics of sensors employed in literature (T: temperature, RH: relative humidity, HR: heart rate,
EDA: electrodermal activity, SC: skin conductance, ACC: accelerometer, ECG: electrocardiogram, SpO 2 : blood
oxygen saturation, EEG: electroencephalogram).
| Type        | Model              |                  | Measurable parameters  | Details     |
| ----------- | ------------------ | ---------------- | ---------------------- | ----------- |
| Smartwatch  | Microsoft Band 2   | HR, T, EDA, ACC  |                        | Smartwatch  |
| or          |                    |                  |                        |             |
| Smartband   | LG Watch R (W110)  | HR               |                        | Smartwatch  |

Hesvit S3  HR, T (Acc. ±0.3 °C, Res. 0.1 °C), RHSK  Smartband
Empatica E4  HR, T (Range -40 to +85 °C), ACC (± 2g), EDA (Range  Smartband
0.01 to 100 µS)
T (Acc. ±0.1 °C, Range 0 to 50 °C)
| Temperature  | Exacon D-S18JK  |     |     | Temperature  |
| ------------ | --------------- | --- | --- | ------------ |
| sensor or    |                 |     |     | probe        |
probe  TT-K-30-SLE  T (Acc. ±1.1 °C or ±0.4 %, Range 0-350 °C)  Thermocouple
iButton DS1923  T (Acc. ±0.5 °C, Res. 0.5 °C, Range -10 to 65 °C), RH  Temperature and
|     |             | (Acc. ±5%, Range 0 to 100%, Res. 0.6% or 0.04%)  |     | RH probe     |
| --- | ----------- | ------------------------------------------------ | --- | ------------ |
|     | muRata NTC  | -                                                |     | Thermistor   |
|     | WZYCH4      | T (Sens. 0.1 °C)                                 |     | Temperature  |
probe
|     | SBS-BTA         | T (Acc. ±0.5 °C, Res. 0.03 °C)          |     | Thermistor       |
| --- | --------------- | --------------------------------------- | --- | ---------------- |
|     | Gigarise SG900  | T (Acc. ±0.2 °C, Range -50 to +180 °C)  |     | -                |
|     | MLX90614        | T (Acc. ±0.5 °C, Res. 0.02 °C)          |     | Infrared sensor  |
Beurer FT70  T: ear (Acc. ±0.2 °C, Range 34-43 °C), forehead (Acc. ±0.2  Medical device
°C, Range 34-43 °C), object (Acc. ±1.5 °C, Range 0-100 °C)
CORE  T (Acc. ±0.05 °C from 20 °C to 42 °C), TCORE (± 0.28 (1σ) ±  Body
|     |     | 0.21 (MAD) – chest)  |     | temperature  |
| --- | --- | -------------------- | --- | ------------ |
sensor
Heart rate  Zephyr HXM-08L  HR (Acc. ±3%, Range 0-200 bpm)  Telemetry device
sensor
|     | Polar H7  | ECG, HR (Acc. ±4%)      |     | Chestband  |
| --- | --------- | ----------------------- | --- | ---------- |
|     | HER-BTA   | HR (Freq. 5 kHz ±10 %)  |     |            |
  HRV101  ECG (SRate 250 Hz and 400 Hz, BW 0.05-40Hz)  ECG Holter
  BioHarness 3.0  HR (Acc. ±1 bpm, Range 25-240 bpm), ECG, respiration  Physiological
|     |     | rate, body orientation, ACC  |     | monitoring  |
| --- | --- | ---------------------------- | --- | ----------- |
telemetry device
Health  MySignals, Libelium  HR (Acc. ±5%, Range 25 to 250 bpm), SpO2 (Acc. ±2%,  Pulse oximeter,
monitoring  CO.  Range 35 to 100%, SC (Acc. ±5%, Range 0-20 μS), BP  Sphygmomanom
| device  |     | (Acc. ±3 mmHg, Range 0 – 300 mmHg)  |     | eter  |
| ------- | --- | ----------------------------------- | --- | ----- |
Laser  moorVMS-LDF1  Blood flow (Acc. ± 10%, Range: 0-1000AU)  Deeper tissue
| Doppler  |     |     |     | blood flow and  |
| -------- | --- | --- | --- | --------------- |
temperature
monitoring
Neural  EPOC+  14 ch. EEG (Res. 14 bits, DRange 8400 µV, BW 0.2-45 Hz,  14 channel EEG
| headset  |     | BL 12 h)  |     |     |
| -------- | --- | --------- | --- | --- |
B-Alert X10, ABM  9 ch. EEG (Res. 16 bit, DRange ±1000 µV, BL 8+ h)  9 channel EEG
Camera  Yukai USB  Sweat area/sweat pore diameter  Digital camera
with microscope
  Microsoft Kinect  RGB-DT camera (Acc. ±4 cm at 5 m, depth range 0.8-5 m,  RGB-Depth
|     |     | $48)  |     | Temperature  |
| --- | --- | ----- | --- | ------------ |
  FLIR A35  TSK (Acc. ±5 °C or ±5 % of reading, Range -23 to 135 °C/- Infrared
40 to 550 °C, Sens. < 0.05 °C)
  FLIR A655sc  TSK (Acc. ±2 °C or ±2 % of reading, $22000)  Infrared
  FLIR T540  TSK (Acc. ±2 °C or ±2% of reading, Range -20 to 120 °C,  Infrared
Res. 464x348 px)
|     | FLIR B8400  | TSK (Range -20 to 120 °C)  |     | Infrared  |
| --- | ----------- | -------------------------- | --- | --------- |
  FLIR Lepton  TSK (Acc. ±0.5 °C, Res. 0.1 °C, $250)  Infrared

FLIR Lepton 2.5 TSK (Acc. ±5 °C or ±5 % of reading, Range -10 °C to 65 Infrared
°C, Sens. < 50 mK, $200)
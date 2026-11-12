Journal of Physics:
Conference Series
PAPER • OPEN ACCESS You may also like
Cozie Apple: An iOS mobile and smartwatch -One Line Soft Keyboard with T9-keys
Layout Proposal on Smartwatch Touch
Screen Device
application for environmental quality satisfaction
Eka Prakarsa Mandyartha, Pratama Wirya
Atmaja, Henni Endah Wahanani et al.
and physiological data collection
-Validation of the ECTemp™ algorithm in
construction workers: a comparison of
photoplethysmography smartwatch and
To cite this article: Federico Tartarini et al 2023 J. Phys.: Conf. Ser. 2600 142003 chest strap heart rate monitors
Maxime Jeanovitch Lignier, Erica Tourula,
Jennifer M Raef et al.
-Porous Enzymatic Membrane for
Nanotextured Glucose Sweat Sensors with
View the article online for updates and enhancements. High Stability Towards Reliable
Noninvasive Health Monitoring
Yuanjing Lin, Jiangqi Zhao, Zhiyong Fan
et al.
This content was downloaded from IP address 81.164.22.24 on 02/11/2026 at 17:46

| CISBAT 2023 |     |     |     |     |     | IOP Publishing |     |
| ----------- | --- | --- | --- | --- | --- | -------------- | --- |
Journal of Physics: Conference Series 2600 (2023) 142003 doi:10.1088/1742-6596/2600/14/142003
| Cozie         | Apple:   | An iOS            | mobile | and     | smartwatch   |          |     |
| ------------- | -------- | ----------------- | ------ | ------- | ------------ | -------- | --- |
| application   |          | for environmental |        | quality | satisfaction |          | and |
| physiological |          | data collection   |        |         |              |          |     |
|               |          | Tartarini1,2,     |        | Frei3,  | Schiavon4,   |          |     |
|               | Federico |                   | Mario  | Stefano |              | Yun Xuan |     |
|               | Chua3,   | Clayton Miller3,∗ |        |         |              |          |     |
1 SinBerBEST, Berkeley Education Alliance for Research in Singapore, Singapore
2 Heat and Health Research Incubator, Faculty of Medicine and Health, The University of
|     | Sydney, | Australia |     |     |     |     |     |
| --- | ------- | --------- | --- | --- | --- | --- | --- |
3
College of Design and Engineering, National University of Singapore (NUS), Singapore
4 Center for the Built Environment (CBE), University of California, Berkeley, CA, USA
|     | E-mail: | ∗clayton@nus.edu.sg |     |     |     |     |     |
| --- | ------- | ------------------- | --- | --- | --- | --- | --- |
Abstract. Collecting feedback from people in indoor and outdoor environments is
traditionally challenging and complex to achieve in a reliable, longitudinal, and non-intrusive
way. This paper introduces Cozie Apple, an open-source mobile and smartwatch application
for iOS devices. This platform allows people to complete a watch-based micro-survey and
provide real-time feedback about environmental conditions via their Apple Watch. It leverages
the inbuilt sensors of the smartwatch to collect physiological (e.g., heart rate, activity)
and environmental (sound level) data. This paper outlines data collected from 48 research
participantswhousedtheplatformtoreportperceptionsofurban-scaleenvironmentalcomfort
(noise and thermal) and contextual factors such as who they were with and what activity they
were doing. The results of 2,400 micro-surveys across various urban settings are illustrated in
thispaper,showingthevariabilityofnoise-relateddistractions,thermalcomfort,andassociated
context. The results show that participants experienced at least a little noise distraction 58%
of the time, with people talking being the most common reason (46%). This effort is novel
due to its focus on spatial and temporal scalability and the collection of noise, distraction, and
associated contextual information. These data set the stage for larger deployments, deeper
analysis,andmorehelpfulpredictionmodelstowardbetterunderstandingtheoccupants’needs
andperceptions. Theseinnovationscouldresultinreal-timecontrolsignalstobuildingsystems
|     | or  | nudges for people to | change their | behavior. |     |     |     |
| --- | --- | -------------------- | ------------ | --------- | --- | --- | --- |
1. Introduction
Most buildings cannot learn and adjust their operations based on occupants’ feedback,
preferences, and needs. Instead, environmental sensors (e.g., illuminance, thermostats,
occupancy, and CO ) are designed to control lighting, heating, ventilation, and cooling systems.
2
As a result, occupants are limited to adjusting what they can control, for example, their
clothing[1], orcanraisecomplaints[2]. Noiseanditseffectonproductivityandmentalhealthis
also a significant issue in the built environment [3, 4]. According to a survey conducted on over
90,000 individuals in approximately 900 office buildings, the primary sources of dissatisfaction
among occupants were sound privacy, with 54% of respondents expressing dissatisfaction,
| followed | by temperature | at 39%, and | noise | level at 34% [5]. |     |     |     |
| -------- | -------------- | ----------- | ----- | ----------------- | --- | --- | --- |
ContentfromthisworkmaybeusedunderthetermsoftheCreativeCommonsAttribution3.0licence.Anyfurtherdistribution
ofthisworkmustmaintainattributiontotheauthor(s)andthetitleofthework,journalcitationandDOI.
PublishedunderlicencebyIOPPublishingLtd
1

CISBAT 2023 IOP Publishing
Journal of Physics: Conference Series 2600 (2023) 142003 doi:10.1088/1742-6596/2600/14/142003
Researchers and practitioners have been installing increasing numbers of sensors in buildings
andurbanenvironmentstocharacterizehumanexposure. However,aspreviouslynoted,sensors’
dataarerarelycoupledwithoccupants’feedback[6]. Inaddition,researchersaremovingtowards
using personal comfort models, also referred to as occupant-centric control. Personal thermal
comfort modeling is a new approach that aims to predict the thermal comfort responses of each
person instead of aggregating data from a large population [7, 8]. Personal comfort models can
be based on environmental measurements (e.g., air temperature, location, relative humidity),
occupant feedback (e.g., online voting), occupant behavior (e.g., thermostat setpoints), and
physiological parameters (e.g., skin temperature, heart rate) [9]. In addition, acoustic comfort
continues to be overlooked, despite some efforts made to monitor noise pollution levels in urban
environments. However, these initiatives fail to capture the subjective aspect of whether the
sound levels actually act as distractions [10, 11]. These challenges face the issue that collecting
data from people is not trivial and poses several challenges. These include but are not limited
to obtaining written consent, handling confidential information, reliably delivering the surveys,
and finding the optimal balance between the quality and quantity of data collected. Long
surveysdeliveredfrequentlyoftenleadtosurveyfatigue, increasingthelikelihoodofparticipants
dropping out from the study and collecting unbalanced datasets [12].
1.1. Development of an open-source interface for watch-based data collection
To overcome all the issues mentioned above, the open-source Cozie smartwatch platform
was developed to change how people can provide feedback about their environment and how
investigators collect physiological data. Many people are already wearing a smartwatch daily;
henceCozieusersarenotrequiredtowearadditionalsensorsordevices(e.g., heartratemonitor,
pedometer). Withasmartwatch-basedplatform, occupantsnolongerneedtouseeitherpenand
paper, phone, or web applications to provide feedback, as done in previous studies [13]. This
methodreducesinefficienciesanddowntime,likegettingthephone,unlockingit,andloadingthe
application. This method enhances and improves Ecological Momentary Assessments (EMA), a
typeofexperiencesamplingmethodusedinpsychology[14]. EcologicalMomentaryAssessments
aim to take measurements and ask for real-time subjective assessments when a defined behavior
occurs.
The Cozie platform was originally developed for the Fitbit smartwatch ecosystem [15]. This
paper focuses on subsequent Cozie’s development and deployment for the Apple iOS ecosystem.
Cozie Apple extends and improves the capabilities of the Fitbit version, allowing researchers
to deliver right-here-right-now surveys to a large group of users without compromising data
quality. The companion app on the phone can be used to complete eligibility and onboarding
surveys and the signed consent form, making it scalable to the large community of Apple Watch
users. The platform also allows push notifications and reminders to be sent to participants,
and users can access data in real time. Additionally, the framework uses the iOS HealthKit
API to access physiological and environmental data with user consent. The code for the project
is open-sourced, and released official documentation and video tutorials can be accessed at
cozie-apple.app. This manuscript outlines the results of an urban-scale deployment to collect
data in a longitudinal field study to investigate people’s perceptions of noise and distraction in
the urban context. This deployment aims to capture whether a person experiences distractions
due to noise and, if they exist, what contextual dimensions are co-occurring [16]. These
contextual elements include whether the person is wearing earphones, if thermal comfort issues
arise simultaneously, what type of space they are in, whether they are with others, and what
type of activity the person is doing.
2

CISBAT 2023 IOP Publishing
Journal of Physics: Conference Series 2600 (2023) 142003 doi:10.1088/1742-6596/2600/14/142003
2. Methodology
Cozie comprises an iOS App (companion application) and a WatchOS App (smartwatch
application) built using Swift. It is backward compatible with iOS 14 and Apple Watches Series
3ornewer. TheapplicationcanbedownloadedfromtheAppleStoreordeployedusingtheopen-
sourcecodebasethatisatgithub.com/cozie-app/cozie-apple. Researcherscan, therefore, usethe
open-sourcecodetodeploytheirownapplicationstoenablethecustomizationoftheapplication
based on specific research objectives and requirements. Cozie offers several functionalities which
investigators can modify and edit to suit their needs better. Changes must be implemented
directly in the source code, and a new version of the application needs to be deployed each time
a change has to be made.
An example of some of the questions that can be added to the smartwatch survey is shown
in Figure 1. The Back and Abort buttons at the end of each survey question allow users to
edit their answers or to stop and discard the complete survey, respectively. Surveys completed
on the smartwatch application are sent to a cloud database via the phone. The Cozie platform
can also facilitate sending push notifications to users to encourage choices related to comfort
or satisfaction. The push notification logic can be as simple as sending a notification at a
predefined time using a time-based job scheduler or sending them as a function of the user’s
location, physiological variable, or environmental parameters. Location data are gathered using
the GPS module in the watch, while physiological data are queried from the iOS Health Store
after obtaining consent from the user. The GPS location is obtained in real-time each time a
survey is completed. In addition, the following parameters are logged in the background: heart
rate, resting heart rate, blood oxygen saturation, step count, walking distance, stand time, and
noise. The timing of when these samples are transmitted to the database is inconsistent since
iOS manages them and relies on variables such as battery charge level, connectivity, iPhone
usage, and other factors. More physiological (e.g., sleep quality) and personal data (e.g., race,
marital status, education level) can be obtained by querying the Apple Health Store, if need be.
Current development efforts include one-click onboarding, embedding watch surveys without
changing the source code, increased reporting frequency of physiological data, and offline data
logging.
2.1. Micro-survey question flow development and experimental deployment
Figure 1 shows an example of an Apple Watch clock face with the Cozie icon (also known as
a complication when on the watch home screen) and a subset of questions used in this study.
Figure 1. ExampleofanAppleWatchclockfacewiththeCoziehomescreenicon(farleftwatch
face) and examples of several watch survey questions used in the experimental deployment.
3

CISBAT 2023 IOP Publishing
Journal of Physics: Conference Series 2600 (2023) 142003 doi:10.1088/1742-6596/2600/14/142003
Complications are small icons that can be added to almost all Apple Watch faces. Tapping on
the complication will start a watch survey on the Apple watch. This feature reduces the effort
and the required time for the user to access the survey.
Follow-up questions are possible, i.e., the investigator can determine which question is shown
next based on the response given to the previous question. The question flow used in this
deployment consisted of a total of nine questions that focus on capturing noise distraction and
contextual information [16]. There is no limit on the number of questions that can be included
in each question flow, but a range of 4-9 questions is recommended.
The deployment of Cozie for this paper involved 48 participants between October 2022 and
January 2023. These participants are primarily staff and students of the National University
of Singapore, as they were recruited through an internal website where research studies are
posted. However, people from the general public who satisfied the criteria were also included.
The selection criteria were that the participants must be 21 to 65 years old, fluent in English,
and willing to wear the watch for 2-4 weeks and answer the micro-surveys at regular intervals.
Participantswererequiredtocompleteaminimumof100surveysinanylocation,eachcompleted
atleastonehourapart, anduponcompletion, weregivenSG$100incompensation. Moredetails
about the methodology of this deployment can be found in an associated manuscript related
to the nudging aspect of the study [16]. This analysis comprises 2,400 micro-survey responses
collected by 48 participants who each completed 50 individual surveys. This analysis is designed
to show the platform’s potential and initial results and sets the stage for future work.
3. Results and discussion
Figure 2 shows the geographical diversity of where participants provided responses about
whether noise distractions were present and the noise levels recorded by the watch sensor in
differentpartsofSingapore. MostresponseswereconcentratedinthecentralregionofSingapore
and near the National University of Singapore campus. Figure 3 gives an overview of the data
collectedfromthe48participantsinthisdeployment. Theresultsshowthattheparticipantswere
experiencing noise distraction a slight majority of the time (58%), with 11% of the time being
significant distractions (a lot). Almost half (46%) of the distractions were due to other people
talking andtraffic andappliance noisebeingthefollowingtwohighestdistractionsources. When
noise distractions were experienced, the participants most often were not wearing earphones or
headphones (88%). Thermal preference data showed that the participants preferred no change
a majority of the time (60%) and preference for being cooler otherwise dominated (31%) as
compared to the preference for being warmer (9%).
Noise Level [dBA]
110
100
90
80
70
60
50
40
30
Figure 2. Spatial urban-scale context of the data collected for whether noise distraction is
present (left) and the sound levels recorded by the watch sensor (right).
4

CISBAT 2023 IOP Publishing
Journal of Physics: Conference Series 2600 (2023) 142003 doi:10.1088/1742-6596/2600/14/142003
Figure 3. Results breakdown from 48 participants - the bars on the left side contain responses
from all 2,400 surveys, while those on the right are data that are only collected based on the
responses from previous questions (the chart segment that they are connected to by a line).
In addition to the subjective environmental experiences, data was collected about additional
contextualinformationthatcouldbeusefultocharacterizeenvironmentalquality. Theresultsof
these questions showed that participants were in indoor spaces a vast majority of the time, most
often at home (42%) or the office (17%). When they were in an office, the most common types
of spaces were small shared (37%), large open office (24%), and individual offices (23%). The
participants indicated that they were alone a majority of the time (65%) or within a group of
people(33%)andonlyseldominanonlinegroup suchasavideoconferencingmeeting. Thisdata
analysis forms the preliminary foundation for future work that dissects the responses according
tothecharacteristicsofthegeographiclocation,theindividualcategories,thedemographicsfrom
the onboarding survey, and the measured variables of heart rate, step count, and environmental
noise levels recorded by the watch.
In this deployment, Cozie enabled gathering feedback from people in real-time in a scalable
way. It also enabled us to couple environmental sensor data, physiological data, and users’
feedback data seamlessly, indicating that the app can be a valuable tool for collecting data in
future studies worldwide. Cozie was built on the previous knowledge that our team gained from
developing Cozie for Fitbit [15, 8] and a web application to log people’s preferences [12]. The
Apple platform helps mitigate the limitations of the Fitbit platform, such as the limitation of a
maximum of four answers, the lack of choice of a preferred watch face, and the lack of ability to
send push notifications to the users. Cozie also has several applications which extend beyond
research settings, including integration into the systems control logic, interventional messages
foroccupants,andspaceutilizationstudies. Consequently,theplatformisopen-sourcedtoreach
a broader audience so other researchers, developers, and practitioners can use it.
5

CISBAT 2023 IOP Publishing
Journal of Physics: Conference Series 2600 (2023) 142003 doi:10.1088/1742-6596/2600/14/142003
4. Conclusions
This paper outlines the open-source development of the Cozie application for the Apple Watch
and iPhone. This platform allows people to provide real-time feedback about their surroundings
while seamlessly logging physiological, environmental, and behavioral data. The analysis
summarizes2,400micro-surveyresponsesfrom48researchparticipantsgivinghigh-levelinsights
into how people experience indoor and outdoor spaces in a scalable way. These data will be
further analyzed in combination with other parts of a more extensive methodology that will be
| covered | in future |     | publications. |     |     |     |     |     |     |
| ------- | --------- | --- | ------------- | --- | --- | --- | --- | --- | --- |
Acknowledgments
This research was supported by the following Singapore Ministry of Education (MOE) Tier
1 Grants: A-0008305-01-00, A-0008301-01-00, and A-8000139-01-00, and by the Singapore
National Research Foundation through a grant to the Berkeley Education Alliance for Research
in Singapore (BEARS) for the Singapore-Berkeley Building Efficiency and Sustainability in the
Tropics(SinBerBEST)Program. Apple,AppleWatch,iPhone,andiOSaretrademarksofApple
| Inc., | registered | in  | the U.S. | and | other | countries | and | regions. |     |
| ----- | ---------- | --- | -------- | --- | ----- | --------- | --- | -------- | --- |
References
[1] F.Tartarini,P.Cooper,R.Fleming,Thermalperceptions,preferencesandadaptivebehavioursofoccupants
|     | of nursing | homes, | Building |     | and Environment |     | 132 (2018). |     |     |
| --- | ---------- | ------ | -------- | --- | --------------- | --- | ----------- | --- | --- |
[2] T. Parkinson, S. Schiavon, J. Kim, G. Betti, Common sources of occupant dissatisfaction with workspace
|     | environments |     | in 600 | office buildings, |     | Build. | Cities 4 (1) | (2023) 17–35. |     |
| --- | ------------ | --- | ------ | ----------------- | --- | ------ | ------------ | ------------- | --- |
[3] J. Kim, R. de Dear, Workspace satisfaction: The privacy-communication trade-off in open-plan offices, J.
|     | Environ. | Psychol. | 36  | (2013) | 18–26. |     |     |     |     |
| --- | -------- | -------- | --- | ------ | ------ | --- | --- | --- | --- |
[4] L. Bergefurt, R. Appel-Meulenbroek, C. Maris, T. Arentze, M. Weijs-Perr´ee, Y. de Kort, The influence of
distractionsofthehome-workenvironmentonmentalhealthduringtheCOVID-19pandemic,Ergonomics
|     | 66 (1) | (2023) | 16–33. |     |     |     |     |     |     |
| --- | ------ | ------ | ------ | --- | --- | --- | --- | --- | --- |
[5] L. Graham, T. Parkinson, S. Schiavon, Lessons learned from 20 years of CBE’s occupant surveys, Buildings
|     | and Cities | 2 (1) | (2021) | 166–184. |     |     |     |     |     |
| --- | ---------- | ----- | ------ | -------- | --- | --- | --- | --- | --- |
[6] P.Li,T.Parkinson,S.Schiavon,T.M.Froese,R.deDear,A.Rysanek,S.Staub-French,Improvedlong-term
thermal comfort indices for continuous monitoring, Energy and Buildings 224 (2020) 110270.
[7] M. Quintana, S. Schiavon, F. Tartarini, J. Kim, C. Miller, Cohort comfort models — using occupant’s
similarity to predict personal thermal preference with less data, Building and Environment 227 (2023)
109685.
[8] F. Tartarini, S. Schiavon, M. Quintana, C. Miller, Personal comfort models based on a 6-month experiment
|     | using environmental |     |     | parameters | and | data from | wearables, | Indoor Air | 32 (2022). |
| --- | ------------------- | --- | --- | ---------- | --- | --------- | ---------- | ---------- | ---------- |
[9] J.Kim,S.Schiavon,G.Brager,Personalcomfortmodels–Anewparadigminthermalcomfortforoccupant-
|     | centric | environmental |     | control, | Building | and | Environment | 132 (2018) | 114–124. |
| --- | ------- | ------------- | --- | -------- | -------- | --- | ----------- | ---------- | -------- |
[10] L. Zipf, R. B. Primack, M. Rothendler, Citizen scientists and university students monitor noise pollution in
|     | cities and | protected |     | areas with | smartphones, |     | PLoS One | 15 (9) (2020) | e0236785. |
| --- | ---------- | --------- | --- | ---------- | ------------ | --- | -------- | ------------- | --------- |
[11] F.Al´ıas,R.M.Alsina-Pag`es,Reviewofwirelessacousticsensornetworksforenvironmentalnoisemonitoring
|     | in smart | cities, | Journal | of Sensors | 2019 | (2019). |     |     |     |
| --- | -------- | ------- | ------- | ---------- | ---- | ------- | --- | --- | --- |
[12] J.Kim,F.Tartarini,T.Parkinson,P.Cooper,R.deDear,Thermalcomfortinamixed-modebuilding: Are
|     | occupants | more | adaptive?, |     | Energy | and Buildings | 203 | (2019) 109436. |     |
| --- | --------- | ---- | ---------- | --- | ------ | ------------- | --- | -------------- | --- |
[13] T.Sood,P.Janssen,C.Miller,Spacematch: Usingenvironmentalpreferencestomatchoccupantstosuitable
|     | activity-based |     | workspaces, |     | Frontiers | in Built | Environment | 6 (2020) 113. |     |
| --- | -------------- | --- | ----------- | --- | --------- | -------- | ----------- | ------------- | --- |
[14] S. Shiffman, A. A. Stone, M. R. Hufford, Ecological momentary assessment, Annual Review of Clinical
|     | Psychology | 4   | (1) (2008) | 1–32. |     |     |     |     |     |
| --- | ---------- | --- | ---------- | ----- | --- | --- | --- | --- | --- |
[15] P. Jayathissa, M. Quintana, T. Sood, N. Nazarian, C. Miller, Is your clock-face cozie? A smartwatch
methodology for the in-situ collection of occupant comfort data, Journal of Physics: Conference Series
|     | 1343 (1) | (2019) | 012145. |     |     |     |     |     |     |
| --- | -------- | ------ | ------- | --- | --- | --- | --- | --- | --- |
[16] C.Miller,Y.X.Chua,M.Frei,M.Quintana,Towardssmartwatch-drivenjust-in-timeadaptiveinterventions
(jitai) for building occupants, in: Proceedings of the 9th ACM International Conference on Systems
for Energy-Efficient Buildings, Cities, and Transportation, BuildSys ’22, Association for Computing
|     | Machinery, | New | York, | NY, | USA, 2022, | p. 336–339. |     |     |     |
| --- | ---------- | --- | ----- | --- | ---------- | ----------- | --- | --- | --- |
6
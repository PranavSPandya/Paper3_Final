d
1 Eye tracking measures of bicyclists’ behavior and perception: a systematic
e
2 review
w
3 Shiyu Maa, Wenwen Zhanga, Robert B. Nolanda, Clinton J. Andrewsa
e
4 a Edward J. Bloustein School of Planning and Public Policy, Rutgers University, New Brunswick,
i
5 NJ, the United States
v
6 e
7 Shiyu Ma: shiyu.ma@rutgers.edu ORCID: 0009-0001-899r9-8203
8 Wenwen Zhang (corresponding author): wenwen.zhanrg@ejb.rutgers.edu ORCID: 0000-0002-
9 2517-8601 e
e
10 Robert B. Noland: rnoland@rutgers.edu ORCID: 0000-0003-0775-0624
p
11 Clinton J. Andrews: CJA1@rutgers.edu ORCID: 0000-0002-2989-8091
t
o
n
t
n
i
r
p
e
r
P
1
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
12 Eye tracking measures of bicyclists’ behavior and perception: a systematic
e
13 review
w
14 Abstract
e
15 With improved portability and affordability, eye tracking devices have facilitated an
i
16 expanding range of cycling experiments, offering valuable insights vinto cycling gaze behaviors
17 and states of mind. Given the complexity of cyclists’ visual beehavior and gaze measurements, the
18 field would benefit from a comprehensive review. We aim to bridge this gap with three key
r
19 focuses: 1) the adoption and interpretations of various gaze metrics derived from cycling
r
20 experiments, 2) a summary of the findings of thoese experiments, and 3) identifying areas for
21 future research. A systematic review of three databases yielded thirty-five articles that met our
e
22 inclusion criteria. The review results show eye tracking technology aided cycling experiments
p
23 can provide cyclist-center perspectives to understand the impact of factors, including built
24 environment, human factors, modet comparison, and methodology assessment, on navigation
o
25 behavior and mental workload and/or stress levels. The results suggest the selection of eye-
n
26 tracking devices, cycling experiment design, and gaze metrics adoption/interpretation vary by
27 research objectives. A variety of general gaze metrics and gaze measurements related to Areas of
t
n
28 Interest (AOI) are applied to infer cyclists’ mental workload/stress levels and attention allocation
29 respectivelyi. The diversity in gaze metrics design and interpretation, however, highlights the
r
30 needp for standardization to facilitate cross-study comparisons. Areas for future research,
31 especially potential integration with latest computer vision and digital twin technologies, are also
e
32 discussed.
r
P
33 Keywords: eye-tracking, cycling experiments, gaze metric, safety, stress
2
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
34 1. Introduction
e
35 Mobile eye tracking devices are a powerful tool to capture cyclists’ vision in naturalistic
w
36 cycling experiments. Cyclists are subject to many external stimuli while cycling, such as motor-
e
37 vehicles, pedestrians, potholes, and other things that may be a safety hazard. But they are also
38 sensitive to positive features of the road environment that make cyclingi more pleasant and safer.
v
39 Mobile eye-tracking devices are one technique for capturing what features of their environment
e
40 cyclists are watching as they ride. Our objective is to review the literature on eye-tracking device
r
41 instrumented cycling experiments to determine how these devices have been used, what metrics
r
42 are typically analyzed, and how this information can be used to improve the cycling
e
43 environment.
e
44 Visual cues trigger emotions and how people look at objects in their environment has
p
45 been used as a way to decipher emotional responses (Strange & Dolan, 2006; Lu & Pesarakli,
46 2023). Eye tracking devices provide information on what cyclists look at, which can be linked to
t
47 various biomarkers, for examople galvanic skin response and heart rate, to measure feelings and
48 stress. Cyclists’ perceptinons of safety and comfort (PSC) is a major determinant of travel
49 satisfaction and a key component in evaluating low-stress bicycling facilities (Mekuria et al.,
t
50 2012). Perceived safety and comfort are mainly measured by stated preference (SP) and revealed
n
51 preference (RP) surveys, which are subject to response biases and challenges in data resolution
i
r
52 (Bigazzi et al., 2022). To address this limitation, collecting data eye tracking devices, have been
p
53 proposed as objective, in situ, and high-resolution alternatives for cyclists’ stress.
e
54 Eye tracking devices have been applied in domains such as psychology, marketing,
r
55 Human Computer Interaction (HCI), and transportation. Eye tracking devices in general detect
P
56 three types of eye movements: fixations, saccades, and others (King et al., 2019). Fixations are
57 periods when eyes are relatively stationary, with the retina stabilized over objects of interest.
3
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
58 Saccades refer to rapid movements of the eye during which fixations are repositioned on
e
59 different objects. Other gaze patterns include pupil size and blinks. Quantitative measurements
w
60 are developed to describe and interpret eye movement patterns. Fixation-based metrics, such as
e
61 fixation count and fixation duration, could infer cognitive processing and attention engagement
i
62 (Duchowski, 2017). Metrics on fixation variability correlate to workload, stress level, and
v
63 emotions (Shiferaw et al., 2019). Saccade metrics, such as saccade velocity and scan path, reveal
e
64 changing focuses of attention and the amount of processed information (Berto et al., 2008).
r
65 Changes in pupil sizes are used to verify stress reactions to visual stimuli (Pedrotti et al., 2014),
r
66 and blink counts to infer cognitive load (Siegle et al., 2008).
e
67 Early eye tracking devices are screen-based and can only be used in indoor stationary
e
68 settings. Using mobile eye tracking devices in naturalistic cycling experiments is a relatively new
p
69 method. The first study of this kind dated to 2013 in Belgium (Vansteenkiste et al.). Over the
70 past decade, the field has witnessed significant growth in both quantity and diversity. Owing to
t
o
71 the complexity of gaze patterns and the quantification power of eye tracking devices, a
72 proliferation of gaze mentrics has been adopted different studies. The selection and interpretations
73 of gaze metrics are es sential parts of data analysis that affect the understanding of cyclist’s
t
74 behavior and perception. To the best of our knowledge, there has not been a systematic review of
n
75 eye tracking cycling experiments. Our aim is to answer the following three research questions:
i
r
76 (1) What gaze metrics are used to interpret bicyclists’ behavior and perception? (2) What are the
p
77 findings of the eye-tracking cycling experiments? (3) Where are the needs for further research?
e
78 The remainder of our paper is organized as follows: In the “Search method” section we
r
79 describe the eligibility criteria, search procedures, and search results to refine our literature
P
80 review. In the “Experiment characteristics” section we summarize key features of the experiment
4
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
81 designs, including the eye tracking devices, routes, and participants based on our review of the
e
82 literature. In the “Gaze metrics” section we present a systematic and critical review of gaze
w
83 metrics, examining how they are defined and interpreted and used. We then synthesize
e
84 experimental findings grouped by four major research topics. Finally, we discuss the limitations
i
85 and identify areas that merit future research.
v
e
86 2. Search method
87 We specify four criteria for inclusion in our review.r Firstly, they need to be peer-
88 reviewed journal papers published in English. Secondly, the cycling experiment must involve
r
e
89 participants actively riding a bike such that participants’ sight and motion are synchronized to
90 emulate a natural cycling experience. Studiees that only investigate cyclists’ gaze behavior from
91 watching videos on screens are excludepd from the review. Thirdly, mobile eye-tracking devices,
92 either head-mounted or integrated with glasses, must be utilized for data collection. Finally,
t
93 quantitative gaze metrics must be employed to describe eye movements. Studies that discuss
o
94 gaze location heatmaps without incorporating quantitative analysis are excluded.
n
95 We combined phrases incorporating two key search terms to search for pertinent studies.
96 The first key term its "cycling", “bicycling”, "cyclist", or “bicyclist” to state the topic of cycling-
n
97 related studies. The second key term is "eye tracking" or "gaze” to filter the search to studies that
i
98 used eye tracking devices.
r
p
99 The search was conducted in January 2024 using three databases. The first database is the
100 eTransportation Research International Documentation (TRID), which specializes in
r
P
5
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
101 transportation research literature covering all modes of transportation1. The initial search using
e
102 our specific phrases yielded 60 articles, of which 12 met the inclusion criteria. The second
w
103 database is ScienceDirect, which provides scientific, technical, and medical research literature.
e
104 We narrowed down the search to transportation-related journals and reviewed 432 articles. After
i
105 screening titles and abstracts, 14 additional articles were included. The third database is Google
v
106 Scholar, which covers scholarly literature across various disciplines. The search generated
e
107 64,420 results, and we screened the first 400 records sorted by relevance. Eight more articles
r
108 were added for review. Finally, the reference lists of the included full-text studies were screened,
r
109 and one additional article was identified to be included. In total, 35 articles were selected for this
e
110 review.
e
111 The earliest study we identified was conducted in 2013 in Belgium. As eye-tracking
p
112 devices became more available and more affordable in subsequent years, the field witnessed
113 consistent growth from 2013 to 2020 and rapid growth after the COVID-19 pandemic. Eleven
t
o
114 studies were published in 2023, indicating increased research interest. Most early studies were
115 conducted in Western annd Northern Europe, especially Belgium and Sweden. Studies in Eastern
116 Asia and the United S tates are more recent. As the geographic diversity of studies increases,
t
117 researchers will be able to assess how different visual cues associated with different road
n
118 characteristics, built environments, and cultural perceptions interact and affect bicycling
i
r
119 behavior.
p
e
r
P
1 https://trid.trb.org
6
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
120 3. Experiment characteristics
e
121 Studies in our review have a variety of different designs and characteristics associated
w
122 with the eye-tracking devices used, the selected routes, and the sample of participants. We
e
123 summarize these differences in this section.
i
v
124 3.1 Eye tracking devices
125 A total of six brands (SMI, ASL, Tobii, Pupil, HoloLenes, and FOVE) and 12 models of
126 eye tracking devices are employed in the reviewed studies, ramong which eight models are used
127 for naturalistic cycling experiments, three models for Virtual Reality experiments, and one model
r
128 for an Augmented Reality experiment. These aree listed in Appendix I along with specifications
129 for each instrument. Six models are currentley available on the market, two have been updated to
130 newer versions, and four have been discontinued. Older eye tracking devices are mounted on
p
131 headwear or glasses frame, whereas more recent devices increasingly resemble regular glasses.
t
132 All the devices track eyes with three key components: infrared illuminators, eye cameras, and a
o
133 scene camera. The infrared illuminators emit infrared light which generates corneal reflections.
n
134 Pupils are rendered dark due to the reflections and pupil locations are recorded by eye cameras.
135 The scene camera is positioned to face forward and records the road scene. These data are
t
n
136 processed in proprietary software with varied eye movement detection algorithms that add
i
137 fixation points onto the scene video. Figure 1 is an example of an eye tracking device (a) and a
r
138 frampe of processed video showing the fixation in the red point and saccade path in the red line
139 e(b).
r
P
7
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
e
w
e
i
v
e
140 r
r
141 Figure 1 Example of an eye tracking device and a processed video frame
e
142
e
143 Critical specifications that affect device reliability include accuracy rate, number of
144 illuminators and eye cameras, and campera sampling rate. Most of the manufacturer-reported
145 accuracy rates have a deviation of le ss than 1.5 degrees from the real fixation points. These
t
146 reported accuracy rates are tested during indoor sedentary tasks, the precise accuracy rates
o
147 remain untested for outdoor and motion-based tasks (Onkhar & Dodou, 2023). Having at least
n
148 two sets of illuminators and eye cameras and recording the movements of both eyes reduces the
149 likelihood of data ltoss. Regarding the eye camera, a higher sampling rate enables the capture of
n
150 shorter-duration fixations and reduces errors in the detected fixation time. As for the scene
i
151 camera, the sampling rate determines the length of frame duration and the number of frames used
r
p
152 for subsequent frame-by-frame fixation analysis. Currently available or upgraded devices offer
153 eeye camera sampling rates above 100 Hz and scene camera sampling rates above 50 Hz. The
154rdiscontinued devices have eye cameras below 60 Hz and scene cameras below 30 Hz. Prior
P
155 literature suggests that the eye trackers’ sampling frequency should be twice the speed of the
156 particular eye movement, ideally reaching 120 Hz for studying fixation and approximately 600
8
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
157 Hz for micro-saccade (Andersson et al., 2010). When a high-frequency eye tracker is
e
158 unavailable, quadrupling the collected data is equivalent to doubling the device sampling
w
159 frequency (Andersson et al., 2010).
e
160 Other factors that influence experiment implementation are calibration method, battery
i
161 life, and weight of the head unit. Due to the natural variations in the shape of each person’s eye
v
162 and various other properties, eye tracking devices require calibration to optimize gaze estimation
e
163 for each user. During the calibration procedure, the participant views a card with a varying
r
164 number of points, and the eye tracking device collects da ta on participant’s gaze at those points.
r
165 The number of calibration points varies across devices, ranging from 10 to 15 points to zero
e
166 points. Most devices are calibrated at the start of the experiment, while studies utilizing SMI
e
167 iView ETG reported calibrating the device at the beginning, during the middle of the ride, and
p
168 after the completion. Simplifying the calibration process can expedite the experiment and
169 minimize sample exclusion due to calibration failure. Battery life limits the length of routes and
t
o
170 duration of the experiments. The ASL device offers a recording time of 1 hour, while SMI, Pupil,
171 and Tobii devices providne 2 hours and more recording time, enhancing flexibility for more
172 extended experiments . The device’s comfort is crucial for participants to cycle naturally during
t
173 the experiments. Most eye tracking devices are designed to be lightweight, with the headset
n
174 weighing approximately 50g. Pupil Core features a no-lens design, which weighs only 22.75g
i
r
175 but also looks different from conventional glasses. When combined with VR or AR headsets, the
p
176 overall weight of the device increases to about 500g, posing challenges for prolonged experiment
e
177 duration.
r
178 Based on the specifications mentioned above, devices with higher sampling frequency,
P
179 more eye cameras and illuminators, a streamlined calibration procedure, longer battery life, and
9
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
180 lighter weight tend to reduce data loss and capture shorter fixations. This likely improves
e
181 experimental implementation and the ecological validity of results. While the data collection
w
182 device is critical, successful research also requires a good experimental design, sufficient
e
183 recruitment of participants, and the valid interpretation of gaze metrics. We discuss these issues
i
184 next.
v
e
185 3.2 Experimental settings and route selection
186 The reviewed studies showcased five types of experriment settings: indoor, naturalistic
187 without routes, naturalistic with routes, immersive virtual environment (IVE), Virtual Reality,
r
e
188 and Augmented Reality. Three early experiments were conducted inside a gymnasium. Among
189 the 19 experiments that had participants cycele in a naturalistic outdoor environment, 16 assigned
190 specific cycling routes and three withoupt routes. Six studies adopted the IVE setting, where
191 participants ride on a stationary bike simulator facing a big screen on which the virtual cycling
t
192 scenes are projected and synchronized with motion. Virtual Reality experiments have people
o
193 wearing VR headsets while riding a bike simulator. Compared to projected videos onto large
n
194 screens, the VR headset provides 360-degree views, facilitating information sampling from
195 peripheral vision. Atugmented Reality experiments have participants wear AR headsets while
n
196 cycling in the real world. Six studies used VR and one used AR.
i
197 The routes of early experiments conducted inside gymnasiums and the latest Augmented
r
p
198 Reality experiment were under 60 meters in length. In the naturalistic experiments, the routes
199 etypically ranged from 2.5 to 5 kilometers or 15 to 30 minutes in duration. Routes for young
200rcyclists were generally shorter, around 1.5 to 2 kilometers, to accommodate their energy levels
P
201 and cycling capabilities. These route lengths and durations are comparable to typical real-world
202 trips, which average 16 minutes or 1 mile (National Household Travel Survey, 2017) and provide
10
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
203 sufficient time for participants to become familiar with the experimental settings and apparatus.
e
204 Those studies that examined built environment features required route lengths long enough to
w
205 encompass a diverse range of features, such as a variety of different intersections, pavement
e
206 conditions, and bike infrastructure. Those focusing on the impact of phone use and detection of
i
207 hazards required longer durations. In these latter studies participants would ride the same route
v
208 multiple times and were instructed to carry out multiple distraction or hazard detection tasks.
e
209 Each cycling session in IVE, VR, and AR settings lasted under 10 minutes, with short breaks
r
210 between sessions to reduce motion sickness.
r
211 In addition to the use of eye tracking devices, the reviewed cycling experiments also
e
212 applied other instruments, including cycling behavior detection sensors, such as speed, braking,
e
213 and head movement, as well as physiological signal sensors, such as heart rate and Galvanic Skin
p
214 Response (GSR). It is also common to supplement objective sensor data with stated preference
215 surveys to understand cyclists’ subjective perceptions of safety and comfort.
t
o
216 3.3 Participant recruitment and sample sizes
n
217 Convenience sampling is the most common recruiting method used in the research
218 reported in the revitewed studies. Eligibility criteria generally include some level of cycling
n
219 competence to ensure the participant can safely ride a bicycle during an on-road experiment. If
i
220 participants are put in more challenging situations a higher level of self-reported cycling
r
p
221 experience are required (von Stülpnagel, 2020). Secondly, participants must have normal or
222 ecorrected-to-normal vision (e.g., wearing contact lenses) to ensure compatibility with the eye
223rtracking devices. The convenience sampling method and the eligibility criteria introduce
P
224 sampling biases. University students, university affiliated personnel, and experienced cyclists are
225 likely overrepresented. Framed lenses are incompatible with the eye tracking glasses and people
11
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
226 who wear them are excluded from the sample. The challenges of calibrating the device with
e
227 seniors’ eyes, combined with the difficulty of recruiting senior cyclists, result in a lower
w
228 representation of this group.
e
229 The number of participants recruited is dependent on experimental design. Notably,
i
230 experiments with IVE and VR that mitigate real-world riding risks while maintaining the
v
231 authenticity of naturalistic cycling experiences, recruited the most participants. Generally, recent
e
232 studies have recruited more than 20 participants for naturalistic experiments and 40 participants
r
233 for experiments with IVE and VR settings. Larger and m ore diverse groups of participants can
r
234 help reduce bias, increase generalizability, and enhance statistical power of any analyses
e
235 (Stelling-Konczak et al., 2018; von Stülpnagel, 2020). However, many studies need to omit some
e
236 participants due to failure of calibration, low eye tracking rates, and withdrawal due to motion
p
237 sickness, a particular problem with VR.
238 The studies we reviewed recruited participants of different genders and a range of ages,
t
o
239 though most studies focused on adults, a few recruited young children. Twenty-eight studies on
240 adult cyclists reported mnean ages mostly under 30 years, with an age range to up to 75 years
241 (Scott-Deeter et al., 2 023). Seven studies of child cyclists report participant mean ages around 10
t
242 years old, with an age range between 6 to 18 years. Twenty-seven studies reported participants’
n
243 gender distribution, half of which have male-to-female ratios between 0.75 and 1.25.
i
r
p
244 4. Gaze metrics
245 eVarious measures are used for the metrics collected by eye-tracking devices. We explain
246rthese metrics and summarize them based on our review sample. A summary table of the
P
247 category, type, definition, and interpretations of gaze metrics can be found in the Appendix II.
248
12
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
249 4.1 General metrics
e
250 After identifying eye movement types, descriptive statistics on general gaze metrics are
w
251 generated directly by software provided with the eye-tracking glasses. General metrics, also
e
252 known as global measures (K. N. van Paridon et al., 2019), are gaze indicators that offer an
253 overall description of visual behaviors without specifying the objects beiing observed. Thirteen
v
254 studies utilized general metrics before specifying the targets of fixations, and three studies used
e
255 general metrics only.
r
256 Fixation duration and fixation dispersion are the two most commonly used metrics to
r
257 infer workload and stress, which are essential proxies for cyclists’ travel satisfaction and
e
258 comfort. Measurements of fixation duration and fixation dispersion are applied to a wide range
e
259 of research topics, such as the impact of different bike infrastructure, pavement quality,
p
260 intersection layout, lane width, experimental settings, and the influence of listening to music
261 while cycling. Regarding measurements of fixation duration, four studies used mean fixation
t
262 duration (i.e., the average duroation of all fixations) (Guo et al., 2023; Mantuano et al., 2017;
263 Stelling-Konczak et al., n2018; von Stülpnagel, 2020) and three used percentage of fixation time
264 (i.e., the percentage of summed fixation time to the total trip duration) (Mantuano et al., 2017;
t
265 Vansteenkiste et al., 2013; Vansteenkiste, Cardon, & Lenoir, 2015). Interpretations of fixation
n
266 duration measurements are consistent: shorter mean fixation durations and a larger percent of
i
r
267 total fixation time are associated with higher cognitive workload and higher levels of stress.
p
268 Fixation dispersion refers to the variability and randomness of gaze locations. Five studies
e
269 measured fixation dispersion using horizontal or vertical fixation variability (i.e., the standard
r
270 deviation of gaze locations on the X or Y axis) (Guo et al., 2023; Ryerson et al., 2021;
P
271 Vansteenkiste et al., 2013; Vansteenkiste, Zeuwts, et al., 2014; L. Zeuwts et al., 2016), two
272 studies applied entropy measurements (i.e., Stationary Gaze Entropy and Gaze Transition
13
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
273 Entropy) (Guo et al., 2023; K. N. van Paridon et al., 2019), and another two studies used gaze
e
274 angular velocity (i.e., the angular degree of fixations between frames) (Ryerson et al., 2021; G.
w
275 Zhao et al., 2023). There are different interpretations of fixation dispersion measurements. For
e
276 example, less horizontal variability is explained as increased workload on low-quality pavement
i
277 and narrow lanes (Vansteenkiste, Cardon, & Lenoir, 2015; Vansteenkiste et al., 2017), but also
v
278 explained as decreased workload when cycling on more protected bike facilities (Guo et al.,
e
279 2023). We elaborate on these contradictions in our discussion section.
r
280 Other types of general metrics used less frequentl y are fixation counts, saccade counts,
r
281 fixation angle, and fixation distance. Fixation and saccade counts are used to describe visual
e
282 search patterns, such as scanning a smartphone and switching to look at a cycling lane.
e
283 Researchers also normalize the total counts by time to calculate fixation or saccade frequency.
p
284 These measurements are often used to compare between transportation modes or different
285 experimental settings to demonstrate different visual behaviors (Gay et al., 2023; Mantuano et
t
o
286 al., 2017; Pashkevich et al., 2022). In particular, one study uses saccade frequency to examine
287 how using a phone influnences cyclists’ scan of the environment (Jiang et al., 2021). Fixation
288 distance and fixation angle are used to infer the difficulty of detecting hazards on the road.
t
289 Unlike the previous measurements generated from software programs, these entail manual
n
290 estimations of the distance and angle between cyclists’ current body location and their fixation
i
r
291 location, as illustrated in Figure 2. The hypothesis is that longer fixation distances and larger
p
292 fixation angles are associated with the increasing need to detect safety `hazards from further
e
293 away and in varied directions (von Stülpnagel, 2020; G. Zhao et al., 2023). Fixation distance and
r
294 angle are less commonly applied, as these can introduce subjective variation and require manual
P
295 estimation.
14
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
e
w
e
i
v
e
296 r
r
297 Figure 2 Diagrams of fixation distance and fixation angle
e
298 4.2 Area-Of-Interest (AOI) related metrics
e
299 Compared with general gaze measurements, AOI-related gaze measurements require the
p
300 specification of fixation targets, which is crucial for understanding where attention is allocated.
301 AOI-related metrics are also more commonly used than general metrics, thirty-two of the thirty-
t
o
302 five reviewed papers employed gaze metrics related to specific AOIs. This section will first
n
303 review AOI annotations and the metrics applied.
304 AOIs are iden tified based on research objectives and could be specific objects or zones of
t
305 sight. Studies nwith object-based AOIs usually extract only the objects of interest, such as traffic
306 signal lights (Rupi & Krizek, 2019), other road users (Zeuwts et al., 2021), and pavement issues
i
r
307 (Gadsby et al., 2022). Identifying objects that are small in size and short in fixation duration
p
308 require higher precision of AOI labelling. Zone-based AOIs are demarcated under the hypothesis
e
309 that each zone provides different information needed for cycling. The most frequently applied
r
310 AOI zones include "path" as the cycling track for lane keeping and pavement monitoring; "goal"
P
311 or “focus of expansion” as the intersection of cycling trajectory and the horizon for navigation
15
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
312 and wayfinding; "sides" as areas next to the cycling track with potential hazards from other road
e
313 users; "external" as areas outside the cycling path with little cycling-related information; "behind
w
314 left" and "behind right" as indications of cyclists checking over shoulders; and “phones” when
e
315 smartphone tasks were assigned. The number of zones varies from three (Nygårdhs et al., 2018)
i
316 to seven (Kircher & Ahlström, 2020). The more zones and smaller zone sizes, the more a zone
v
317 resembles an object. It is also possible to combine zones of AOI and objects of AOI. For
e
318 instance, van Paridon et al. (2019) annotated both “path” to indicate general pavement areas and
r
319 “pothole” to identify the specific pavement problem. In a ddition to objects and zones, Kircher &
r
320 Ahlström (2023) argued that AOI annotations should be more purposefully related to the
e
321 required attention needed for the cycling task, and categorized the fixated areas into “necessary”,
e
322 “useful”, and “not required”.
p
t
o
n
t
n
i
323
r
p
324 Figure 3 Examples of object based AOI and Zone based AOI
325 e
326rIn most studies AOIs are delineated and annotated manually. Six studies reported
P
327 recruiting two raters for AOI annotation and validated their reliability on a selected portion of the
328 data. Cohen’s kappa (Kircher & Ahlström, 2020; Stelling-Konczak et al., 2018) and Pearson
16
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
329 correlation (K. N. van Paridon et al., 2019; Vansteenkiste et al., 2013; Vansteenkiste, Zeuwts, et
e
330 al., 2014; Vansteenkiste, Cardon, & Lenoir, 2015) are calculated to indicate agreements between
w
331 raters. Only one study applied computer vision techniques to automate the process (Aasvik &
e
332 Fyhri, 2022). The reliability concerns of the AOI annotation method are discussed further in
i
333 Section 6.
v
334 Fixation count and fixation duration are the most commonly used AOI-related metrics for
e
335 indicating attention. Some researchers used the term “dwell time” to sum up both fixations and
r
336 saccades over AOIs to infer attention (Gay et al., 2023; K . van Paridon et al., 2021;
r
337 Vansteenkiste et al., 2017; Vansteenkiste, Hamme, et al., 2014). Their interpretations remain
e
338 consistent: more fixation counts and longer fixation durations on a specific AOI are associated
e
339 with more attention paid to the AOI. Measurements of fixation counts include the percentage of
p
340 fixation counts per AOI and the number of fixations per minute per AOI. Measurements of
341 fixation duration include the percentage of fixation time per AOI, mean or median fixation
t
o
342 duration per AOI, and total fixation time per AOI. Especially, the percentage of fixation time per
343 AOI is the mostly used mnetrics of all. Nineteen out of the thirty-five studies used this metric,
344 indicating its acceptan ce and reliability. When the AOIs are related to traffic hazards that need to
t
345 be observed to ensure safety, such as crossing pedestrians and door-openings of parked cars,
n
346 researchers apply the measurement fixation rate (i.e., the percentage of AOIs being fixated on to
i
r
347 the total number of safety-related AOIs) to describe hazard detection capabilities (Bishop et al.,
p
348 2023; Gadsby et al., 2022; L. H. R. H. Zeuwts et al., 2023). In addition, one study used
e
349 maximum fixation duration on smartphones to indicate how well-prepared cyclists are to perform
r
350 secondary tasks at preferred locations (Ahlstrom et al., 2016).
P
17
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
351 Fixation distance is another type of AOI-related metric less commonly applied. Fixation
e
352 distance is measured both in terms of the physical distance between the cyclist and the first
w
353 fixation of an AOI and the time difference between the first fixation of an AOI and the cyclist
e
354 arriving at the AOI. Selected AOIs to apply fixation distance include traffic lights, pavement
i
355 issues, and traffic hazards. Interpretations of fixation distance are less consistent. In some studies
v
356 it was stated that AOIs fixated from a longer fixation distance lead to more caution and require
e
357 longer reaction times (Rupi & Krizek, 2019; L. H. R. H. Zeuwts et al., 2021, 2023), others
r
358 ascribe it to how prominent the AOI is to the cyclist inste ad of how urgent it is (Gadsby et al.,
r
359 2022).
e
e
360 5 Findings by research topic
p
361 5.1 Built environment features
362 The built environment is the physical surroundings that cyclists encounter when riding,
t
o
363 such as bike facilities, pavement quality, lane characteristics, and intersection layouts. Its
364 composition, design, andn quality can directly impact cyclists. Eighteen studies investigated the
365 impact of built enviro nment features.
t
366 Studies on bike facilities compared cycling in mixed traffic with various features of bike
n
367 lanes, such as painted bike lanes, bike lanes protected from vehicles by bollards or flowerpots,
i
r
368 and raised bike lanes alongside sidewalks. Cycling on painted and separated bike lanes,
p
369 compared with mixed traffic, is associated with less dispersion in horizontal gazes, less dispersed
e
370 fixations, longer mean fixation duration, and higher percentage of fixation count on the road
r
371 center, implying an increased focus on the area directly ahead rather than lateral eye movements
P
372 to the side (Guo et al., 2023). Cyclists on bike lanes protected by bollards are also found to have
373 a higher percentage of fixation time on distractions such as street furniture and buildings, likely
18
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
374 due to reduced task difficulty when using more protected bike lanes (Jang & Kim, 2019). When
e
375 cycling in mixed traffic, debris and potholes are noticed less, with medium fixation duration, and
w
376 shorter fixation time to arrival, indicating the chance of missing safety cues in a less protected
e
377 cycling environment (Gadsby et al., 2022).
i
378 Pavement conditions were investigated for their general surface quality and specific
v
379 pavement problems. Compared to high-quality surfaces, cycling on low-quality surfaces is
e
380 associated with significantly higher fixation frequency, a larger percentage of fixation time on
r
381 areas surrounding the cycle lane, lower mean fixation du ration on the distant environment, and
r
382 less dispersed horizontal gaze distributions. These gaze metrics reflect cyclists’ adaptation to the
e
383 increased task demands when riding on low-quality pavement, but an increased attention to the
e
384 road is at the expense of fewer visual searches for safety hazards in the surrounding area
p
385 (Vansteenkiste et al., 2017; Vansteenkiste, Zeuwts, et al., 2014). Uneven pavements tend to have
386 higher fixation rate than potholes and debris on the road. This implies that uneven pavements
t
o
387 attract greater attention from cyclists. The researchers surveyed their participants and found that
388 uneven pavement is ratend less harmful to cycling safety and suggested that the significance of
389 attention to unevenne ss revealed in gaze metrics is likely due to it being very visible and
t
390 noticeable to cyclists (Gadsby et al., 2022).
n
391 Studies on lane characteristics examined cycling lane width, cycling lane curvature, truck
i
r
392 loading zone marking type, and loading zone width. Cyclists riding on wider lanes have a larger
p
393 percentage of fixation time on the end of lanes and external regions and less on the near pathway,
e
394 suggesting that decreased task demand on steering allows for looking more on non-task-relevant
r
395 areas (Vansteenkiste 2013, 2015). When riding on a curvy path, cyclists adjust where they look
P
396 to have better steering control. The inside and the center of the curvy lane received a higher
19
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
397 percentage of fixation time when entering the curve and a lower percentage of fixation time
e
398 when leaving the curve (Vansteenkiste, Hamme, et al., 2014). Examining the effects of different
w
399 pavement markings of the truck loading zone (i.e., a designated marked area next to the cycling
e
400 lane where trucks park), cyclists have a longest total fixation duration on dashed green markings
i
401 compared with white lane markings and solid green markings, showing that dashed green
v
402 markings are more successful in arousing attention (Abadi et al., 2022). Compared with a wide
e
403 truck loading zone, cyclists passing by trucks in a no-loading zone and a minimal loading zone
r
404 have a longer total fixation duration on the truck, indicati ng more alertness (Jashami et al.,
r
405 2023).
e
406 Features associated with intersection layouts include bike lane treatments at intersections
e
407 and intersection openness. Cyclists entering intersections without continuous bike lanes fixate on
p
408 traffic lights further ahead due to the increased need to anticipate risks (Rupi & Krizek, 2019).
409 Comparing the effect of bike signals and bike box (i.e., a designated area at the head of a traffic
t
o
410 lane at a signalized intersection that allows cyclists to get ahead of queuing traffic during the red
411 light), both treatments shnorten cyclist’s total fixation time on turning vehicles that pose a
412 potential conflict for t he cyclists. This could be explained by the increased ratings of perceived
t
413 safety, but cyclists’ lowered attention may increase crash risk for errant drivers not yielding
n
414 (Scott-Deeter et al., 2023). Cyclists riding at spatially complex intersections with larger visibility
i
r
415 exhibit shorter fixation durations, longer fixation distances, and larger angular differences
p
416 between gaze and motion direction, interpreted as an increase in perceived risk (von Stülpnagel,
e
417 2020).
r
P
20
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
418 5.2 Human factors
e
419 Human factors refer to cyclists’ characteristics, capabilities, and interactions with
w
420 secondary tasks. Seventeen studies involving human factors examined the impact of age, gender,
e
421 cycling experience, route familiarity, cycling speed, mental fatigue, and smartphone distractions.
422 Cyclist age is studied by comparing children and adults and chilidren of different ages.
v
423 When tested over short indoor routes, children show similar gaze patterns as adults on medium
e
424 and wide lanes when asked to cycle at their personal preferable and high cycling speeds,
r
425 demonstrating that children are able to adopt a similar visual-motor strategy as adults for simple
r
426 precision steering tasks (Vansteenkiste, Cardon, & Lenoir, 2015). In outdoor naturalistic settings,
e
427 children are found to have more fixations per second and a larger percentage of dwell time on
e
428 areas not related to the cycling task such as objects along the side of the road and the surrounding
p
429 area. These gaze patterns reveal children’s lower capability to prioritize safety cues and process
430 information from peripheral sight (Vansteenkiste et al., 2017). Comparing child cyclists aged
t
431 between 6 to 12 years old ando 13 to 19 years old, the fixation distribution across AOIs does not
432 vary between age groupns, and both age groups manage to monitor more than 80% of the safety
433 targets (Kircher & Ahlström, 2023).
t
434 Two studies examined the impact of gender on cyclists’ visual behavior. One found no
n
435 gender difference when riding on different bike facilities (Guo et al., 2023). Another found that
i
r
436 men exhibit longer total fixation duration on the pavement markings of truck loading zones, but
p
437 both genders show a similar amount of attention on trucks (Abadi et al., 2022). Cyclists more
e
438 familiar with the route and with higher levels of skill have longer mean fixation duration, longer
r
439 fixation distance, and more gazes to all sides when riding in challenging locations, such as the
P
440 end of a cycling track and a complex intersection (von Stülpnagel, 2020). Experienced cyclists
441 also exhibit longer total fixation duration on traffic lights when crossing intersections (Rupi &
21
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
442 Krizek, 2019). Cyclists with mental fatigue fixate on hazards 1.5 seconds later, indicating
e
443 attention deterioration and increased danger (Zeuwts et al., 2021). Cyclists rating the test location
w
444 as more dangerous present shorter mean fixation duration, shorter fixation distances, and larger
e
445 fixation angles (von Stülpnagel, 2020).
i
446 Cycling speed also affects where cyclists fixate on. When asked to cycle at a speed lower
v
447 than their personal preference, they had a higher percent of dwell time on the near path and road
e
448 canter (Vansteenkiste et al., 2013; Vansteenkiste, Zeuwts, et al., 2014). When cycling at higher
r
449 speeds, a higher percent of fixation time is placed on the distant cycling trajectory when the lane
r
450 is straight (Vansteenkiste et al., 2013; Vansteenkiste, Cardon, & Lenoir, 2015) and the inside of
e
451 the road when riding on a curvy path (Vansteenkiste, Hamme, et al., 2014).
e
452 Studies of secondary tasks provided an analysis of the influence of music, phone calls,
p
453 texting, searching websites, checking bike computers, and user interface displays. One study
454 found that listening to music slightly reduces fixations in the front road area and left area of sight
t
o
455 (Jiang et al., 2021), while three others found no significant influence of listening to music on
456 cyclists’ visual behaviorns (Ahlstrom et al., 2016; Nygårdhs et al., 2018; Stelling-Konczak et al.,
457 2018). When engaged in phone calls, texting, and web-searching tasks, cyclists allocate fixations
t
458 to the phone mainly at the expense of reduced fixations on the regions less relevant to safety
n
459 (Ahlstrom et al., 2016) and decreased saccades frequency (Jiang et al., 2021). Tasks initiated by
i
r
460 cyclists themselves result in longer total fixation duration on the phone and maximum fixation
p
461 duration on the phone compared to receiving tasks, as cyclists have more time to plan and choose
e
462 preferable locations to interact with their phones (Ahlstrom et al., 2016). Higher complexity in
r
463 texting tasks is associated with fewer fixations on the road ahead (Jiang et al., 2021). Using a
P
464 bike computer to monitor power output and cadence does not significantly reduce the percentage
22
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
465 of dwell time on traffic, suggesting little influence on traffic hazard detection (Pfeifer et al.,
e
466 2023). Compared with reading messages from a smartphone mounted on the handlebar, using
w
467 AR interfaces that display the message in a fixed location of the sight or snapped onto moving
e
468 objects reduces gaze angular velocity and angular differences between fixation and cycling
i
469 directions, indicating calmer gaze patterns and higher chances to detect safety hazards in the
v
470 front (G. Zhao et al., 2023).
e
r
471 5.3 Mode comparison
472 Attention demand and gaze patterns differ across transportation modes. Two studies
r
e
473 compared the gaze behaviors of cyclists to that of drivers, pedestrians, and E-scooter riders.
474 Comparing how cyclists and drivers eattend to safety-related visual cues at urban
475 intersections, cyclists have a significanptly lower percentage of fixation counts on the road ahead
476 and a higher percentage to the sides, suggesting that cyclists have place more attention on
t
477 monitoring traffic than drivers. (Kircher & Ahlström, 2020). Comparing the fixation distribution
o
478 of pedestrians, cyclists, and E-scooter riders on a shared road, pedestrians frequently look at the
n
479 sides (40.3% of fixation counts, compared to 14.6% for cyclists and 15.3% for e-scooter riders),
480 and cyclists observte the road ahead more (42.5% of fixation counts, compared to 25.2% for
n
481 pedestrians and 38.6% for e-scooter riders). This indicates a comparable amount of effort put
i
482 into visual attention for cycling and e-scooter riding (Pashkevich et al., 2022).
r
p
483 5.4 Methodology assessment
e
484 Studies on methodology assessed the robustness and validity of using eye-tracking for
r
485 assessing cyclist behavior. One study compared two AOI annotation methods, and four studies
P
486 investigated the ecological validity of experiment settings.
23
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
487 AOI annotation is a critical step in gaze data analysis requiring labour-intensive manual
e
488 labelling. Comparing annotating AOIs frame-by-frame and fixation-by-fixation, it is found that
w
489 the latter can reduce the analysis time by a factor of nine while maintaining high consistency
e
490 with the classic frame-by-frame method. However, AOIs that are small in size, not frequently
i
491 focused on, or inconsistently specified exhibited larger discrepancies between the two methods
v
492 (Vansteenkiste, Cardon, Philippaerts, et al., 2015). For instance, when identifying fixations on
e
493 the curb, which is narrow and can be specified as part of the sidewalk or part of the bike lane by
r
494 different people, the traditional frame by frame method is suggested as more appropriate.
r
495 Ecological validity examines whether the simulated environments resemble naturalistic
e
496 cycling. Three experiment settings are examined: watching a cycling video (i.e., riding a
e
497 stationary bike and facing a big screen, motion, and sight unsynchronized), immersive virtual
p
498 environment (IVE) (i.e., riding a stationary bike and facing a big screen, syncing motion and
499 sight), and Virtual Reality (i.e., riding a stationary bike with VR glasses, syncing motion and
t
o
500 sight). Compared to naturalistic cycling, participants watching a cycling video showed less
501 vertical fixation dispersinon and less dwell time on other pedestrians and cyclists, reflecting
502 decreased visual searc h when watching a video. Increasing the cycling task complexity, such as
t
503 watching a video of or cycling on low-quality pavement paths, reduces the discrepancy between
n
504 the two experiment settings (Zeuwts et al., 2016). Compared with the real world, cyclists in an
i
r
505 immersive virtual environment (IVE) presented longer mean fixation duration and less vertical
p
506 fixation dispersion. These less attentive gaze behaviors are likely due to the perceived safety of
e
507 cycling in simulated environments (Acerra et al., 2023; Gay et al., 2023). When cycling past a
r
508 parked bus, cyclists in VR settings fixated on the bus for 20% longer than naturalistic cycling,
P
509 albeit the traffic volumes were not controlled for in the two scenarios (van Paridon et al., 2021).
24
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
510 Although there is no previous study that directly compares these three experiment settings with
e
511 each other, all use stationary bikes to eliminate the risks of cycling in real traffic, which increase
w
512 perceived safety of the cycling task. While the effect of less attentive visual search can be
e
513 reduced by increasing cycling task complexity (e.g., cycling in more complex traffic),
i
514 researchers should also be careful about other aspects of restrictions, including the limited use of
v
515 peripheral vision when using the screen, the fidelity of virtual environments and the impact of
e
516 motion sickness in VR experiments.
r
517 6. Discussion r
e
518 The increasing use of eye tracking devices in cycling experiments has demonstrated their
519 usefulness and effectiveness at deciphering ecyclist attention and perception. However, we also
520 uncovered inconsistencies and limitatiopns which we focus on now.
521 Detecting and describing fixations is the shared foundation of eye-tracking studies.
t
522 However, parameters set to define a fixation are not always reported, and the influence of setting
o
523 different fixations parameters has not been explored. Four studies define a fixation as a gaze on
n
524 an identical location for at least three consecutive frames. However, due to the sampling rates of
525 different devices, twto studies set the minimum fixation duration at 120ms (Vansteenkiste,
n
526 Cardon, & Lenoir, 2015; Vansteenkiste et al., 2013) and the other two at 100ms (Mantuano et al.,
i
527 2017; Rupi & Krizek, 2019). Three studies cited the same literature on the relationship between
r
p
528 fixation duration and attentive processing (Velichkovsky et al., 2002, 2003) but adopted different
529 evalues. One study set the minimum fixation duration at 200ms to infer extensive processing
530r(Stelling-Konczak et al., 2018), another used 150ms to indicate hazard perception (Gadsby et al.,
P
531 2022), and the third adopted 90ms to include shorter fixations in the pre-attentive processing
532 phases (Zeuwts et al., 2021). These discrepancies in fixation parameters pose challenges when
25
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
533 comparing findings quantitively between studies. With the increased sampling rating of newer
e
534 eye tracking devices, there is an opportunity to capture shorter fixations defined at smaller
w
535 minimum durations and compare them with fixations defined at a higher threshold. Future
e
536 studies could address this gap by examining the influence of different fixation parameters on the
i
537 analysis results.
v
538 Secondly, the assumption that fixation indicates attention, albeit widely accepted,
e
539 deserves careful investigation. Attention is a cognitive process that can be conceptualized from
r
540 multiple perspectives. Overt attention refers to directing fixations toward the AOI, whereas
r
541 covert attention indicates processing information from peripheral vision without making
e
542 accompanying eye movements (Posner, 1980). Evidence from driver studies suggests that
e
543 peripheral vision without direct fixation is sufficient for lane-keeping and velocity estimation
p
544 (Lamble et al., 1999). Studies of smartphone treatments also discuss the role of peripheral vision
545 in navigation when cyclists fixate on phones (Ahlstrom et al., 2016; Nygårdhs et al., 2018). The
t
o
546 excessive focus on fixations, neglecting insights from peripheral visual information, overlooks
547 chances to explore covenrt attention. Additionally, attention can be classified as bottom-up or top-
548 down. Bottom-up atte ntion corresponds to the object’s salience (i.e., the quality of being visible
t
549 or noticeable), and top-down attention refers to conscious deliberations affected by subjective
n
550 experience and evaluations (Aasvik & Fyhri, 2022; Connor et al., 2004). This distinction affects
i
r
551 how gaze metrics are interpreted. For instance, pavement unevenness is fixated on earliest and
p
552 for the longest time compared to potholes and cracks, which is explained by the size and
e
553 visibility of unevenness instead of higher perceived danger (Gadsby et al., 2022). One method to
r
554 assess fixation and top-down attention allocation is adopting the thinking-aloud verbal protocol
P
555 (Ericsson & Simon, 1980), asking the participants to articulate their thoughts during cycling. The
26
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
556 downside of the thinking-aloud method is that it lengthens cyclists’ fixation duration and
e
557 deviates from the natural riding experience (Hertzum et al., 2009). Future research may also
w
558 address this research gap by extending the focus of fixation to the effect of visual salience, the
e
559 role of peripheral vision, and the influence of saccade patterns and gaze sequences.
i
560 The third issue is the lack of clarity in terminologies such as workload and stress. This
v
561 can be noted from the inconsistencies of gaze metrics interpretations. When cycling on low-
e
562 quality pavement and narrow lanes, less horizontal variability is explained as increased workload
r
563 (Vansteenkiste, Cardon, & Lenoir, 2015; Vansteenkiste e t al., 2017). When cycling on more
r
564 protected bike facilities, less horizontal variability is explained as decreased workload (Guo et
e
565 al., 2023). While both findings could be valid, the conflicted interpretations of horizontal fixation
e
566 variability result from lack of distinctions on workload types. Cycling related tasks can be
p
567 categorized into navigation, guidance, and control; the complexity and demand of the tasks are
568 affected by varying factors (i.e., route familiarity affects navigation demand, traffic complexity
t
o
569 affects guidance demand, and pavement smoothness affects the demand for control) (Bigazzi et
570 al., 2022). As different cnycling tasks have different attentional requirements, increased workload
571 in control and decreas ed workload in guidance could lead to the same gaze pattern (i.e.,
t
572 increased concentration on the road). Future studies would benefit from precise distinctions on
n
573 workload types when interpreting gaze metrics. Furthermore, workload is sometimes used
i
r
574 interchangeably with stress in the reviewed studies (Guo et al., 2023; Ryerson et al., 2021).
p
575 Workload and stress are two related concepts derived from different theoretical frameworks.
e
576 Stress refers to a state of a disorganized physiological system that hinders well-being, but high
r
577 workload and increased arousal could also be associated with enhanced task performance
P
578 (Gaillard, 1993). According to the Task Capacity Interface (TCI) model (Fuller, 2005; Fuller et
27
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
579 al., 2008), cyclist behavior is related to a balance between task demand and cyclist’s capabilities.
e
580 Cyclists adapt their mental workload to cope with task complexity change. When the task
w
581 demand is low (e.g., cycling on protected facilities in low traffic environment), cyclists’
e
582 capability exceeds the task demand, and the spared capacity allows for conducting secondary
i
583 tasks (e.g., using smartphones or enjoying the surrounding scenery). When the task complexity
v
584 rises to a point where cycling task demands exceed the cyclist’s capacity, stress is triggered as an
e
585 emotional response. One possible solution to better infer stress is to combine multiple gaze
r
586 metrics. For example, complex traffic situations put a hig her demand on traffic monitoring,
r
587 which could be quantified as both shorter mean fixation durations and higher horizontal fixation
e
588 dispersions. In addition, future studies could consider triangulating eye-tracking data with
e
589 additional physiological sensors, such as Galvanic Skin Response (GSR), Skin Temperature
p
590 (ST), Heart Rate (HR), and Heart Rate Variability (HRV) (Bigazzi et al., 2022; Caviedes &
591 Figliozzi, 2018; Cobb et al., 2021; Lim et al., 2022). By triangulating data from eye-tracking,
t
o
592 physiological sensors, and self-reported surveys, researchers can better understand cyclists’
593 emotions and perceptionns.
594 Fourthly, optim ization of AOI analysis is needed to address the time-consuming and
t
595 reliability challenges regarding the current manual annotation method. Due to the large amount
n
596 of data collected by eye-tracking devices, assigning fixation to AOIs remains a labor-intensive
i
r
597 and time-consuming task despite efforts to streamline the process. The stake of reliability is
p
598 especially high when labelling AOIs that are small in size, short in fixation durations, and
e
599 intertwined with proximate AOIs (Vansteenkiste et al., 2013). The reliability concern is also
r
600 evident in distance-related metrics, as raters subjectively estimated the distance between the
P
601 participants' location and the fixated objects based on scene videos and reference maps (von
28
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
602 Stülpnagel, 2020). Optimization in analysis techniques is needed to address these concerns.
e
603 Computer vision algorithms in image segmentation, such as PSPNET and Segment Anything
w
604 (Kirillov et al., 2023; H. Zhao et al., 2017), prove to be of great potential to automate AOI
e
605 annotation. The automation process not only saves time but also increases reliability. When
i
606 applying one algorithm to specify fixation targets, the AOIs are specified based on the same
v
607 method without subjective viewpoints. In addition to annotating the targets of fixations, these
e
608 algorithms could also be applied to the whole scene video to recognize all objects appearing in
r
609 sight, which opens new opportunities to study peripheral vision.
r
610 Lastly, future research could explore innovative ways to leverage the data collected from
e
611 the eye-tracking devices. One promising approach involves transforming the existing 2D gaze
e
612 metrics analysis into 3D analysis by combining gaze data with other sensor inputs, such as GPS
p
613 and gyro sensor data with ground-based LiDAR data. Moreover, as digital twins become
614 increasingly detailed and realistic, there is a pressing need to incorporate human agents for better
t
o
615 simulations (Fotheringham, 2023). Researchers can utilize the comprehensive cyclists’ gaze and
616 behavioral data to addrenss this gap and create more lifelike cycling agents. Furthermore, the data
617 could be utilized to de velop generative artificial intelligence models capable of generating new,
t
618 realistic cycling behavior data based on input information. These innovations can potentially
n
619 enhance cycling behavior modelling and improve cycling satisfaction.
i
r
620 This review has its limitations. Despite the efforts to conduct a thorough search, some
p
621 articles may be missed, given the extensive and multidisciplinary nature of the literature. In
e
622 addition, this review only included peer-reviewed journal articles published in English, which
r
623 may have excluded relevant articles published in other venues and languages. Although caution
P
29
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
624 is exercised during the extraction and summary of descriptive information, reviewer bias and
e
625 errors may still be present.
w
626 7. Conclusions e
627 Using eye tracking devices in cycling experiments to study cyclists’ behavior and
i
v
628 perceptions is a relatively new method. How researchers choose and interpret the gaze metrics
e
629 are critical to generating new insights that can inform measures to improve safety and for bicycle
630 infrastructure planning. We reviewed 35 peer-reviewed studries and summarized the use of
631 general gaze metrics and AOI-related gaze metrics. We examined results around four areas: built
r
e
632 environment features, human factors, mode comparisons, and methodology assessment. We
633 identified five research gaps that merit futuree endeavors: investigating fixation-defining
634 parameters, cautious interpretations of pfixation and attention, clarifying terminologies on
635 workload and stress, optimizing the AOI annotation method, and applying cyclists’ eye tracking
t
636 data in innovative fields.
o
637 With raising awareness on inclusion and technological advancement, some eye-tracking
n
638 devices have been developed to be compatible with prescriptive lenses for people in need of
639 vision correction, atnd to be customized for vulnerable demographic groups including children
n
640 and seniors. We look forward to learning from studies that embrace these advancements to
i
641 improve the inclusiveness of cycling experiments for more equitable findings.
r
p
e
r
P
30
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
643 Disclosure statement
e
644 No potential conflict of interest was reported by the author(s).
w
645 Acknowledgements
e
646 This work is partially supported by Rutgers Research Council.
i
v
647
e
r
r
e
e
p
t
o
n
t
n
i
r
p
e
r
P
31
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
648 References
e
649 Aasvik, O., & Fyhri, A. (2022). Distracting or informative? Examining signage for cyclists using
w
650 eye-tracking. Traffic Safety Research, 2, 000013–000013.
e
651 https://doi.org/10.55329/wxcy5694
652 Abadi, M. G., Maloney, P., & Hurwitz, D. (2022). Exploring Bicyclists’i Visual Attention during
v
653 Conflicts with Truck Traffic. Transportation Research Record, 2676(11), 137–144.
e
654 https://doi.org/10.1177/03611981221091709
r
655 Acerra, E. M., Shoman, M., Imine, H., Brasile, C., Lantieri, C., & Vignali, V. (2023). The Visual
r
656 Behavior of the Cyclist: Comparison between Simulated and Real Scenarios.
e
657 Infrastructures, 8(5), Article 5. https://doi.org/10.3390/infrastructures8050092
e
658 Ahlstrom, C., Kircher, K., Thorslund, B., & Adell, E. (2016). Bicyclists’ visual strategies when
p
659 conducting self-paced vs. System-paced smartphone tasks in traffic. Transportation
660 Research Part F: Traffic Psychology and Behavior, 41, 204–216.
t
661 https://doi.org/10.101o6/j.trf.2015.01.010
662 Andersson, R., Nyströmn, M., & Holmqvist, K. (2010). Sampling frequency and eye-tracking
663 measures: How speed affects durations, latencies, and more. Journal of Eye Movement
t
664 Research, 3(3), Article 3. https://doi.org/10.16910/jemr.3.3.6
n
665 Berto, R., Massaccesi, S., & Pasini, M. (2008). Do eye movements measured across high and
i
r
666 low fascination photographs differ? Addressing Kaplan’s fascination hypothesis. Journal
p
667 of Environmental Psychology, 28(2), 185–191.
e
668 https://doi.org/10.1016/j.jenvp.2007.11.004
r
669 Bigazzi, A., Ausri, F., Peddie, L., Fitch, D., & Puterman, E. (2022). Physiological markers of
P
670 traffic-related stress during active travel. Transportation Research Part F: Traffic
671 Psychology and Behavior, 84, 223–238. https://doi.org/10.1016/j.trf.2021.12.003
32
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
672 Bishop, D. T., Daylamani-Zad, D., Dkaidek, T. S., Fukaya, K., & Broadbent, D. P. (2023). A
e
673 brief gamified immersive intervention to improve 11–14-year-olds’ cycling-related
w
674 looking behavior and situation awareness: A school-based pilot study. Transportation
e
675 Research Part F: Traffic Psychology and Behavior, 97, 17–30.
i
676 https://doi.org/10.1016/j.trf.2023.06.019
v
677 Caviedes, A., & Figliozzi, M. (2018). Modeling the impact of traffic conditions and bicycle
e
678 facilities on cyclists’ on-road stress levels. Transportation Research Part F: Traffic
r
679 Psychology and Behavior, 58, 488–499. https://do i.org/10.1016/j.trf.2018.06.032
r
680 Cobb, D. P., Jashami, H., & Hurwitz, D. S. (2021). Bicyclists’ behavioral and physiological
e
681 responses to varying roadway conditions and bicycle infrastructure. Transportation
e
682 Research Part F: Traffic Psychology and Behavior, 80, 172–188.
p
683 https://doi.org/10.1016/j.trf.2021.04.004
684 Connor, C. E., Egeth, H. E., & Yantis, S. (2004). Visual Attention: Bottom-Up Versus Top-
t
o
685 Down. Current Biology, 14(19), R850–R852. https://doi.org/10.1016/j.cub.2004.09.041
686 Duchowski, A. T. (2017n). Eye Tracking Methodology. Springer International Publishing.
687 https://doi.org /10.1007/978-3-319-57883-5
t
688 Ericsson, K. A., & Simon, H. A. (1980). Verbal reports as data. Psychological Review, 87(3),
n
689 215–251. https://doi.org/10.1037/0033-295X.87.3.215
i
r
690 Fotheringham, A. S. (2023). Digital twins: The current “Krays” of urban analytics? Environment
p
691 and Planning B: Urban Analytics and City Science, 50(4), 1020–1022.
e
692 https://doi.org/10.1177/23998083231169159
r
693 Fuller, R. (2005). Towards a general theory of driver behavior. Accident Analysis & Prevention,
P
694 37(3), 461–472. https://doi.org/10.1016/j.aap.2004.11.003
33
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
695 Fuller, R., McHugh, C., & Pender, S. (2008). Task difficulty and risk in the determination of
e
696 driver behavior. European Review of Applied Psychology, 58(1), 13–21.
w
697 https://doi.org/10.1016/j.erap.2005.07.004
e
698 Gadsby, A., Tsai, J., & Watkins, K. (2022). Understanding the Influence of Pavement Conditions
i
699 on Cyclists’ Perception of Safety and Comfort Using Surveys and Eye Tracking.
v
700 Transportation Research Record, 03611981221090936.
e
701 https://doi.org/10.1177/03611981221090936
r
702 Gay, N., Trefzger, M., Sawilla, S., & Schlegel, T. (2023) . How realistic is the gaze behavior in a
r
703 cycling simulator? A comparative study between lab and field. Transportation Research
e
704 Procedia, 72, 1061–1068. https://doi.org/10.1016/j.trpro.2023.11.536
e
705 Guo, X., Tavakoli, A., Angulo, A., Robartes, E., Chen, T. D., & Heydarian, A. (2023). Psycho-
p
706 physiological measures on a bicycle simulator in immersive virtual environments: How
707 protected/curbside bike lanes may improve perceived safety. Transportation Research
t
o
708 Part F: Traffic Psychology and Behavior, 92, 317–336.
709 https://doi.org/10n.1016/j.trf.2022.11.015
710 Healey, P. (1992). Pla nning through debate: The communicative turn in planning theory. Town
t
711 Planning Review, 63(2), 143. https://doi.org/10.3828/tpr.63.2.422x602303814821
n
712 Hertzum, M., Holmegaard, K., & c, H. (2009). Scrutinizing usability evaluation: Does thinking
i
r
713 aloud affect behavior and mental workload? Behavior & Information Technology, 28.
p
714 https://doi.org/10.1080/01449290701773842
e
715 Jang, G., & Kim, S. (2019). Investigating the effect of a raised cycle track, physical separation,
r
716 land use and number of pedestrian on cyclists’ gaze behavior. Journal of Architecture
P
717 and Urbanism, 43(1), Article 1. https://doi.org/10.3846/jau.2019.3786
34
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
718 Jashami, H., Cobb, D., Sinkus, I., Liu, Y., McCormack, E., Goodchild, A., & Hurwitz, D. (2023).
e
719 Evaluation of bicyclist physiological response and visual attention in commercial vehicle
w
720 loading zones. Journal of Safety Research. https://doi.org/10.1016/j.jsr.2023.11.018
e
721 Jiang, K., Yang, Z., Feng, Z., Sze, N. N., Yu, Z., Huang, Z., & Chen, J. (2021). Effects of using
i
722 mobile phones while cycling: A study from the perspectives of manipulation and visual
v
723 strategies. Transportation Research Part F: Traffic Psychology and Behavior, 83, 291–
e
724 303. https://doi.org/10.1016/j.trf.2021.10.010
r
725 King, A. J., Bol, N., Cummins, R. G., & John, K. K. (201 9). Improving Visual Behavior
r
726 Research in Communication Science: An Overview, Review, and Reporting
e
727 Recommendations for Using Eye-Tracking Methods. Communication Methods and
e
728 Measures, 13(3), 149–177. https://doi.org/10.1080/19312458.2018.1558194
p
729 Kircher, K., & Ahlström, C. (2020). Attentional requirements on cyclists and drivers in urban
730 intersections. Transportation Research Part F: Traffic Psychology and Behavior, 68,
t
o
731 105–117. https://doi.org/10.1016/j.trf.2019.12.008
732 Kircher, K., & Ahlströmn, C. (2023). Children and youngster’s gaze behavior when cycling in
733 familiar enviro nments. Journal of Cycling and Micromobility Research, 1, 100006.
t
734 https://doi.org/10.1016/j.jcmr.2023.100006
n
735 Kirillov, A., Mintun, E., Ravi, N., Mao, H., Rolland, C., Gustafson, L., Xiao, T., Whitehead, S.,
i
r
736 Berg, A. C., Lo, W.-Y., Dollár, P., & Girshick, R. (2023). Segment Anything
p
737 (arXiv:2304.02643). arXiv. https://doi.org/10.48550/arXiv.2304.02643
e
738 Lamble, D., Laakso, M., & Summala, H. (1999). Detection thresholds in car following situations
r
739 and peripheral vision: Implications for positioning of visually demanding in-car displays.
P
740 Ergonomics, 42(6), 807–815. https://doi.org/10.1080/001401399185306
35
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
741 Lim, T., Kalra, A., Thompson, J., Caldwell Odgers, J., & Beck, B. (2022). Physiological
e
742 measures of bicyclists’ subjective experiences: A scoping review. Transportation
w
743 Research Part F: Traffic Psychology and Behavior, 90, 365–381.
e
744 https://doi.org/10.1016/j.trf.2022.09.007
i
745 Lu, Z., & Pesarakli, H. (2023). Seeing Is Believing: Using Eye-Tracking Devices in
v
746 Environmental Research. HERD: Health Environments Research & Design Journal,
e
747 16(1), 15–52. https://doi.org/10.1177/19375867221130806
r
748 Mantuano, A., Bernardi, S., & Rupi, F. (2017). Cyclist ga ze behavior in urban space: An eye-
r
749 tracking experiment on the bicycle network of Bologna. Case Studies on Transport
e
750 Policy, 5(2), 408–416. https://doi.org/10.1016/j.cstp.2016.06.001
e
751 Mekuria, M. C., Furth, P. G., & Nixon, H. (2012). Low-Stress Bicycling and Network
p
752 Connectivity. San Jose, CA: Mineta Transportation Institute.
753 Nygårdhs, S., Ahlström, C., Ihlström, J., & Kircher, K. (2018). Bicyclists’ adaptation strategies
t
o
754 when interacting with text messages in urban environments. Cognition, Technology &
755 Work, 20(3), 377n–388. https://doi.org/10.1007/s10111-018-0478-y
756 Onkhar, V., & Dodou , D. (n.d.). Evaluating the Tobii Pro Glasses 2 and 3 in static and dynamic
t
757 conditions.
n
758 Pashkevich, A., Burghardt, T. E., Puławska-Obiedowska, S., & Šucha, M. (2022). Visual
i
r
759 attention and speeds of pedestrians, cyclists, and electric scooter riders when using shared
p
760 road – a field eye tracker experiment. Case Studies on Transport Policy, 10(1), 549–558.
e
761 https://doi.org/10.1016/j.cstp.2022.01.015
r
762 Pedrotti, M., Mirzaei, M. A., Tedesco, A., Chardonnet, J.-R., Mérienne, F., Benedetto, S., &
P
763 Baccino, T. (2014). Automatic Stress Classification With Pupil Diameter Analysis.
36
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
764 International Journal of Human–Computer Interaction, 30(3), 220–236.
e
765 https://doi.org/10.1080/10447318.2013.848320
w
766 Pfeifer, C., Leinen, P., Puhl, J., & Panzer, S. (2023). Visual behavior and road traffic hazard
e
767 situations when using a bike computer on a racing bike: An eye movement study. Applied
i
768 Ergonomics, 112, 104070. https://doi.org/10.1016/j.apergo.2023.104070
v
769 Posner, M. I. (1980). Orienting of Attention. Quarterly Journal of Experimental Psychology,
e
770 32(1), 3–25. https://doi.org/10.1080/00335558008248231
r
771 Rupi & Krizek. (2019). Visual Eye Gaze While Cycling: Analyzing Eye Tracking at Signalized
r
772 Intersections in Urban Conditions. Sustainability, 11(21), 6089.
e
773 https://doi.org/10.3390/su11216089
e
774 Ryerson, M. S., Long, C. S., Fichman, M., Davidson, J. H., Scudder, K. N., Kim, M., Katti, R.,
p
775 Poon, G., & Harris, M. D. (2021). Evaluating cyclist biometrics to develop urban
776 transportation safety metrics. Accident Analysis & Prevention, 159, 106287.
t
o
777 https://doi.org/10.1016/j.aap.2021.106287
778 Scott-Deeter, L., Hurwitnz, D., Russo, B., Smaglik, E., & Kothuri, S. (2023). Assessing the
779 impact of thre e intersection treatments on bicyclist safety using a bicycling simulator.
t
780 Accident Analysis & Prevention, 179, 106877. https://doi.org/10.1016/j.aap.2022.106877
n
781 Shiferaw, B., Downey, L., & Crewther, D. (2019). A review of gaze entropy as a measure of
i
r
782 visual scanning efficiency. Neuroscience & Biobehavioral Reviews, 96, 353–366.
p
783 https://doi.org/10.1016/j.neubiorev.2018.12.007
e
784 Siegle, G. J., Ichikawa, N., & Steinhauer, S. (2008). Blink before and after you think: Blinks
r
785 occur prior to and following cognitive load indexed by pupillary responses.
P
786 Psychophysiology, 45(5), 679–687. https://doi.org/10.1111/j.1469-8986.2008.00681.x
37
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
787 Stelling-Konczak, A., Vlakveld, W. P., van Gent, P., Commandeur, J. J. F., van Wee, B., &
e
788 Hagenzieker, M. (2018). A study in real traffic examining glance behavior of teenage
w
789 cyclists when listening to music: Results and ethical considerations. Transportation
e
790 Research Part F: Traffic Psychology and Behavior, 55, 47–57.
i
791 https://doi.org/10.1016/j.trf.2018.02.031
v
792 Strange, B. A., & Dolan, R. J. (2006). Anterior medial temporal lobe in human cognition:
e
793 Memory for fear and the unexpected. Cognitive Neuropsychiatry, 11(3), 198–218.
r
794 https://doi.org/10.1080/13546800500305096
r
795 van Paridon, K. N., Leivers, H. K., Robertson, P. J., & Timmis, M. A. (2019). Visual search
e
796 behavior in young cyclists: A naturalistic experiment. Transportation Research Part F:
e
797 Traffic Psychology and Behavior, 67, 217–229. https://doi.org/10.1016/j.trf.2019.10.014
p
798 van Paridon, K., Timmis, M. A., & Sadeghi Esfahlani, S. (2021). Development and Evaluation of
799 a Virtual Environment to Assess Cycling Hazard Perception Skills. Sensors, 21(16),
t
o
800 5499. https://doi.org/10.3390/s21165499
801 Vansteenkiste, P., Cardonn, G., D’Hondt, E., Philippaerts, R., & Lenoir, M. (2013). The visual
802 control of bicy cle steering: The effects of speed and path width. Accident Analysis &
t
803 Prevention, 51, 222–227. https://doi.org/10.1016/j.aap.2012.11.025
n
804 Vansteenkiste, P., Cardon, G., & Lenoir, M. (2015). Visual guidance during bicycle steering
i
r
805 through narrow lanes: A study in children. Accident Analysis & Prevention, 78, 8–13.
p
806 https://doi.org/10.1016/j.aap.2015.02.010
e
807 Vansteenkiste, P., Cardon, G., Philippaerts, R., & Lenoir, M. (2015). Measuring dwell time
r
808 percentage from head-mounted eye-tracking data – comparison of a frame-by-frame and
P
38
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
809 a fixation-by-fixation analysis. Ergonomics, 58(5), 712–721.
e
810 https://doi.org/10.1080/00140139.2014.990524
w
811 Vansteenkiste, P., Hamme, D. V., Veelaert, P., Philippaerts, R., Cardon, G., & Lenoir, M.
e
812 (2014). Cycling around a Curve: The Effect of Cycling Speed on Steering and Gaze
i
813 Behavior. PLOS ONE, 9(7), e102792. https://doi.org/10.1371/journal.pone.0102792
v
814 Vansteenkiste, P., Zeuwts, L., Cardon, G., Philippaerts, R., & Lenoir, M. (2014). The
e
815 implications of low quality bicycle paths on gaze behavior of cyclists: A field test.
r
816 Transportation Research Part F: Traffic Psycholo gy and Behavior, 23, 81–87.
r
817 https://doi.org/10.1016/j.trf.2013.12.019
e
818 Vansteenkiste, P., Zeuwts, L., van Maarseveen, M., Cardon, G., Savelsbergh, G., & Lenoir, M.
e
819 (2017). The implications of low quality bicycle paths on the gaze behavior of young
p
820 learner cyclists. Transportation Research Part F: Traffic Psychology and Behavior, 48,
821 52–60. https://doi.org/10.1016/j.trf.2017.04.013
t
o
822 Velichkovsky, B. M., Rothert, A., Kopf, M., Dornhöfer, S. M., & Joos, M. (2002). Towards an
823 express-diagnostnics for level of processing and hazard perception. Transportation
824 Research Part F: Traffic Psychology and Behavior, 5(2), 145–156.
t
825 https://doi.org/10.1016/S1369-8478(02)00013-X
n
826 Velichkovsky, B. M., Rothert, A., Miniotas, D., Dornhöfer, S. M., Joos, M., & Pannasch, S.
i
r
827 (n.d.). Visual Fixations as a Rapid Indicator of Hazard Perception.
p
828 von Stülpnagel, R. (2020). Gaze behavior during urban cycling: Effects of subjective risk
e
829 perception and vista space properties. Transportation Research Part F: Traffic
r
830 Psychology and Behavior, 75, 222–238. https://doi.org/10.1016/j.trf.2020.10.007
P
39
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
831 Zeuwts, L. H. R. H., Iliano, E., Smith, M., Deconinck, F., & Lenoir, M. (2021). Mental fatigue
e
832 delays visual search behavior in young cyclists when negotiating complex traffic
w
833 situations: A study in virtual reality. Accident Analysis & Prevention, 161, 106387.
e
834 https://doi.org/10.1016/j.aap.2021.106387
i
835 Zeuwts, L. H. R. H., Vanhuele, R., Vansteenkiste, P., Deconinck, F. J. A., & Lenoir, M. (2023).
v
836 Using an immersive virtual reality bicycle simulator to evaluate hazard detection and
e
837 anticipation of overt and covert traffic situations in young bicyclists. Virtual Reality,
r
838 27(2), 1507–1527. https://doi.org/10.1007/s10055 -023-00746-7
r
839 Zeuwts, L., Vansteenkiste, P., Deconinck, F., van Maarseveen, M., Savelsbergh, G., Cardon, G.,
e
840 & Lenoir, M. (2016). Is gaze behavior in a laboratory context similar to that in real-life?
e
841 A study in bicyclists. Transportation Research Part F: Traffic Psychology and Behavior,
p
842 43, 131–140. https://doi.org/10.1016/j.trf.2016.10.010
843 Zhao, G., Orlosky, J., Gabbard, J., & Kiyokawa, K. (2023). HazARdSnap: Gazed-based
t
o
844 Augmentation Delivery for Safe Information Access while Cycling. IEEE Transactions
845 on Visualization nand Computer Graphics, 1–10.
846 https://doi.org /10.1109/TVCG.2023.3333336
t
847 Zhao, H., Shi, J., Qi, X., Wang, X., & Jia, J. (2017). Pyramid Scene Parsing Network. 2881–
n
848 2890.
i
r
849 https://openaccess.thecvf.com/content_cvpr_2017/html/Zhao_Pyramid_Scene_Parsing_C
p
850 VPR_2017_paper.html
e
r
P
40
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
e
w
Appendices
e
Appendix I. Summary of eye tracking devices, their specifications, and the studies that used them i
v
|         |     |           |          | Eye     | Scene   |              |           |     |                 |
| ------- | --- | --------- | -------- | ------- | ------- | ------------ | --------- | --- | --------------- |
| ET      |     | Accuracy  | No. eye  |         |         | Calibration  | Weight    |     |                 |
|         | Use | Status    |          | camera  | camera  |              | eSoftware |     | Studies applied |
| devices |     | (degree)  | camera   |         |         | (point)      | (g)       |     |                 |
|         |     |           |          | (Hz)    | (fps)   |              |           |     |                 |
r
Aasvik & Fyhri, 2022;
|             |              |     |     |     |     |     |      | Pupil Player  |                      |
| ----------- | ------------ | --- | --- | --- | --- | --- | ---- | ------------- | -------------------- |
| Pupil Labs  |              |     |     |     |     |     |      |               | Gadsby et al., 2022; |
|             | Naturalistic | O 4 | 2   | 200 | 60  | 0r  | 46.9 | & Pupil       |                      |
| Invisible   |              |     |     |     |     |     |      |               | Kircher & Ahlström,  |
e
Capture
2023
|     |     |     |     |     | e   |     |     | Pupil Player  |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- |
Pupil Core Naturalistic O 0.6 2 200 30/60/120 5 22.75 & Pupil
|             |     |     |     | p   |     |     |     | Capture       | Acerra et al., 2023 |
| ----------- | --- | --- | --- | --- | --- | --- | --- | ------------- | ------------------- |
| Pupil Labs  |     |     |     |     |     |     |     | Pupil Player  |                     |
|             |     |     |     |     |     |     |     |               | Zeuwts et al.,      |
| + HTC       | VR  | O 1 | 2   | 120 | 90  | 8   | 470 | & Pupil       |                     |
|             |     |     |     | t   |     |     |     |               | 2021&2023           |
| Vive        |     |     |     |     |     |     |     | Capture       |                     |
o
Bishop et al., 2023;
Tobii Pro
|        |     |           | n   |     |     |     |     | Tobii Unity  | Guo et al., 2023;       |
| ------ | --- | --------- | --- | --- | --- | --- | --- | ------------ | ----------------------- |
| + HTC  | VR  | O 0.5-1.1 | 4   | 120 | 90  | 1   | 550 |              |                         |
|        |     |           |     |     |     |     |     | SDK          | Ramirez Juarez et al.,  |
Vive

2023
t
| HoloLens  |     |        |     |     |     |         |     | Python and  |                   |
| --------- | --- | ------ | --- | --- | --- | ------- | --- | ----------- | ----------------- |
|           | AR  | O n1.5 | 2   | 30  |     | several | 566 |             |                   |
| 2 HMD     |     |        |     |     |     |         |     | Unity       | Zhao et al., 2023 |
| FOVE VR   |     |        |     |     |     |         |     | FOVE        |                   |
i
|         | VR  | r O 1.15 | 2   | 120 | 70  | 1   | 520 |            |                          |
| ------- | --- | -------- | --- | --- | --- | --- | --- | ---------- | ------------------------ |
| Headset |     |          |     |     |     |     |     | Univty SDK | van Paridon et al., 2021 |
p
Pupil Player
Stelling-Konczak et al.,
| Pupil Pro | Naturalistic | U 0.6 | 1   | 30  | 30  | 9   | 22.75 | & Pupil  |      |
| --------- | ------------ | ----- | --- | --- | --- | --- | ----- | -------- | ---- |
|           | e            |       |     |     |     |     |       |          | 2018 |
Capture
r
P
41
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
e
wGay et al., 2023;
Jang & Kim, 2019;
| Tobii Pro  |              |      |       |     |     | Teobii Pro  | Jiang et al., 2021;      |
| ---------- | ------------ | ---- | ----- | --- | --- | ----------- | ------------------------ |
|            | Naturalistic | U NA | 4 100 | 25  | 1   | 45          |                          |
| Glasses 2  |              |      |       |     |     | Lab         | Pashkevich et al., 2022; |
i
Pfeifer et al., 2023
v
Ryerson et. al, 2021;
|      |     |     |     |     |     | e   | Abadi et al., 2022;   |
| ---- | --- | --- | --- | --- | --- | --- | --------------------- |
| ASL  |     |     |     |     |     |     | Jashami et al., 2023; |
r
Mobile  Naturalistic D 0.5-1 1 30 30 10/15 76 EyeVision Mantuano et al., 2017;

| Eye-XG |     |     |     |     |     |     | Rupi & Krizek, 2019; |
| ------ | --- | --- | --- | --- | --- | --- | -------------------- |
r
Scott-Deeter et al., 2023
e
| SMI    |              |       |      |      |     |           | van Paridon et al.,    |
| ------ | ------------ | ----- | ---- | ---- | --- | --------- | ---------------------- |
| iView  | Naturalistic | D 0.5 | 2 60 | 30 e | 3   | 47 BeGaze | 2019&2021;             |
| ETG v1 |              |       |      |      |     |           | von Stülpnagel, 2020;  |
|        |              |       | p    |      |     |           | Ahlstrom et al., 2016; |
Kircher & Ahlström,

| SMI  |     |     |     |     |     |     | 2020; |
| ---- | --- | --- | --- | --- | --- | --- | ----- |
t
iView  Naturalistic D 0.5 2 50/60 30 5 47 BeGaze  Nygårdhs et al., 2018;
o
| ETG v2 |     |     |     |     |     |     | Vansteenkiste et al.,  |
| ------ | --- | --- | --- | --- | --- | --- | ---------------------- |
|        |     |     | n   |     |     |     | 2017;                  |
Zeuwts et al., 2016;

| SMI  |     |     |     |     |     |     | Vansteenkiste et al.,  |
| ---- | --- | --- | --- | --- | --- | --- | ---------------------- |
t
iViewX  Naturalistic D 1 1 50 25 5 79 BeGaze 2013, 2014a, 2014b,
n
| HED |     |     |     |     |     |     | 2015a & 2015b |
| --- | --- | --- | --- | --- | --- | --- | ------------- |
i
r
p
e
r
P
42
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
e
| Appendix II. Summary of gaze metrics |     |     |     |     | w   |
| ------------------------------------ | --- | --- | --- | --- | --- |
e
Category Type Measure Definition Interpretation Studies applied
i
v
Total number of  The total number of  Compared between participants to examine  (Mantuano et al., 2017; Pashkevich et
fixations fixations during a ride different visual search strategy. al., 2022)
e
Fixation
|     | Count |            |                              | Compared between diffrerent modes of  |     |
| --- | ----- | ---------- | ---------------------------- | ------------------------------------- | --- |
|     |       | Number of  | The number of fixations per  |                                       |     |
(Gay et al., 2023; Pashkevich et al.,
|     |     | fixations per  | minute or per second during  | travellers or differe nt experiment settings to  |     |
| --- | --- | -------------- | ---------------------------- | ------------------------------------------------ | --- |
2022)
|     |     | minute/second | a ride | examine visualr search strategy. |     |
| --- | --- | ------------- | ------ | -------------------------------- | --- |
e
|     |     | Total fixation  | The sum of fixation time,  | Compared with total saccade time to examine  |                         |
| --- | --- | --------------- | -------------------------- | -------------------------------------------- | ----------------------- |
|     |     |                 |                            | e                                            | (Mantuano et al., 2017) |
|     |     | time            | measured in seconds        | visual search strategy.                      |                         |
p
The average duration of all  (Guo et al., 2023; Mantuano et al.,
|     | Fixation  | Mean fixation  |     | Shorter fixation durations infer increased  |     |
| --- | --------- | -------------- | --- | ------------------------------------------- | --- |
fixations, measured in  2017; Stelling-Konczak et al., 2018;
Duration duration  visual tasks and higher hazard estimations.
|     |     |     | seconds |     | von Stülpnagel, 2020) |
| --- | --- | --- | ------- | --- | --------------------- |
t
General  o Higher total fixation percentage infers  (Mantuano et al., 2017; Vansteenkiste
The percentage of fixation
metrics % Fixation time increased cognitive processes and visual  et al., 2013; Vansteenkiste, Cardon, &
time to the total trip time
|     |     |     | n   | workload. | Lenoir, 2015) |
| --- | --- | --- | --- | --------- | ------------- |
(Guo et al., 2023; Ryerson et al., 2021;
|     |     | Horizontal and                         |  The standard deviation of  |                                             |                                          |
| --- | --- | -------------------------------------- | --------------------------- | ------------------------------------------- | ---------------------------------------- |
|     |     |                                        |                             | Varied explanations associated with mental  | Vansteenkiste et al., 2013;              |
|     |     | vertical  tthe X and Y coordinates of  |                             |                                             |                                          |
|     |     |                                        |                             | workload and stress.                        | Vansteenkiste, Zeuwts, et al., 2014; L.  |
|     |     | variability                            | gaze locations              |                                             |                                          |
|     |     | n                                      |                             |                                             | Zeuwts et al., 2016)                     |
i
|     |     | r                | Defined on uncertainties of  | Larger entropy indicates greater randomness  |                                          |
| --- | --- | ---------------- | ---------------------------- | -------------------------------------------- | ---------------------------------------- |
|     |     | Stationary gaze  |                              |                                              | (Guo et al., 2023; K. N. van Paridon et  |
Fixation
|     | pentropy |     | choices and calculated with  | in the transition behavior and higher task  |     |
| --- | -------- | --- | ---------------------------- | ------------------------------------------- | --- |
al., 2019)
Dispersion Shannon's entropy equation complexity in visual information acquisition.
e
A conditional entropy
r
|     |     | Gaze transition  | considering the temporal  | Increased values from the optimal indicate  |     |
| --- | --- | ---------------- | ------------------------- | ------------------------------------------- | --- |
(Guo et al., 2023)
| P   |     | entropy | dependency between  | stress and anxiety.  |     |
| --- | --- | ------- | ------------------- | -------------------- | --- |
different fixations
43
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
e
w
The angular degree of
Rapid eye movements reflect high cognitive
Gaze angular  fixations between frames,  (Ryerson et al., 2021; G. Zhao et al.,
workload which could lead to stress and
|     |     | velocity | measured in degrees per  |     | e2023) |
| --- | --- | -------- | ------------------------ | --- | ------ |
error.
second
i
v
|     |     |     | The distance between  | Longer fixation distances indicate cyclists’  |     |
| --- | --- | --- | --------------------- | --------------------------------------------- | --- |
Fixation  Sight vector  cyclists’ current body  capability of hazards anticipation. Shorter
e (von Stülpnagel, 2020)
Distance length location and their gaze  fixation distances indicate cyclists' focus on
|     |     |     | location, measured in meters | immediate surroundings. |     |
| --- | --- | --- | ---------------------------- | ----------------------- | --- |
r

The angular degree between  r
Fixation  Gaze angle from  Larger gaze angles indicate higher needs of  (von Stülpnagel, 2020; G. Zhao et al.,
e
fixation direction and travel
|     | Angle | travel |     | hazard detection from various directions. | 2023) |
| --- | ----- | ------ | --- | ----------------------------------------- | ----- |
direction/face-forward.
e
|     |          | Number of  | pScanning frequency reflects cyclists' visual  |     |     |
| --- | -------- | ---------- | ---------------------------------------------- | --- | --- |
|     | Saccade  |            | The number of saccades per                     |     |     |
saccades per  search strategies and is influenced by  (Jiang et al., 2021)
|     | Count |        | second during a task |                                    |     |
| --- | ----- | ------ | -------------------- | ---------------------------------- | --- |
|     |       | second |                      | different distraction treatments.  |     |

t
o
|     | Saccade  | Total saccade  | The sum of saccade time,  | Compared with the total fixation time to  |     |
| --- | -------- | -------------- | ------------------------- | ----------------------------------------- | --- |
(Mantuano et al., 2017)
|     | Duration | time | measured in seconds | reflect cyclists' visual search strategy. |     |
| --- | -------- | ---- | ------------------- | ----------------------------------------- | --- |
n
|     |     | Number of  | The number of fixations per  |     |     |
| --- | --- | ---------- | ---------------------------- | --- | --- |
  AOIs receiving more fixation counts capture  (Pashkevich et al., 2022; Vansteenkiste
|     |     | fixations per  | second or minute on a  |                 |               |
| --- | --- | -------------- | ---------------------- | --------------- | ------------- |
|     |     |                | t                      | more attention. | et al., 2017) |
|     |     | s/min per AOI  | specific AOI           |                 |               |
n
(Ahlstrom et al., 2016; Jiang et al.,
2021; Kircher & Ahlström, 2020;
i
r The percentage of fixation  Mantuano et al., 2017; Nygårdhs et al.,
AOI- % fixation counts  AOIs with higher percentage of fixation
Fixationp/dwell  on an AOI to the total  2018; Pashkevich et al., 2022; Rupi &
| related  |     | per AOI |     | counts capture more attention |     |
| -------- | --- | ------- | --- | ----------------------------- | --- |
Count number of fixations Krizek, 2019; K. N. van Paridon et al.,
metrics
2019; Vansteenkiste, Zeuwts, et al.,
e
2014; L. H. R. H. Zeuwts et al., 2021)
r
|     |     |     | The percentage of AOIs  | Participants with higher fixation rates show  |     |
| --- | --- | --- | ----------------------- | --------------------------------------------- | --- |
(Bishop et al., 2023; Gadsby et al.,
P
|     |     | Fixation rate | being fixated on to the total  | higher safety awareness and better hazard  |     |
| --- | --- | ------------- | ------------------------------ | ------------------------------------------ | --- |
2022; L. H. R. H. Zeuwts et al., 2023)
|     |     |     | number of AOIs. | detection skills. |     |
| --- | --- | --- | --------------- | ----------------- | --- |
44
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
e
(Abawdi et al., 2022; Acerra et al., 2023;
The sum of fixation time on  Ahlstrom et al., 2016; Gay et al., 2023;
|     | Total fixation  |     | AOIs with longer summed fixation time  |     |
| --- | --------------- | --- | -------------------------------------- | --- |
a specific AOI, measured in  Jashami et al., 2023; Rupi & Krizek,
|     | time per AOI |     | capture more attention |     |
| --- | ------------ | --- | ---------------------- | --- |
e
|     |     | seconds  |     | 2019; Scott-Deeter et al., 2023; L. H.  |
| --- | --- | -------- | --- | --------------------------------------- |
R. H. Zeuwts et al., 2021)
i
(Aasvik & Fyhri, 2022; Acerra et al.,
v
2023; Ahlstrom et al., 2016; Gadsby et
al., 2022; Guo et al., 2023; Jang &
e
Kim, 2019; Mantuano et al., 2017;
r Pfeifer et al., 2023; Ramirez Juarez et
al., 2023; Rupi & Krizek, 2019;
The percentage of fixation
% of fixation  AOIs with higher percentage of fixation time  Vansteenkiste et al., 2013;
time on an AOI to the total
time per AOI capture more attention r Vansteenkiste, Hamme, et al., 2014;
|     |     | fixation time | e   |     |
| --- | --- | ------------- | --- | --- |
Vansteenkiste, Cardon, & Lenoir,
2015; Vansteenkiste, Cardon,
| Fixation/dwell  |     |     | e   | Philippaerts, et al., 2015;  |
| --------------- | --- | --- | --- | ---------------------------- |
Duration
Vansteenkiste et al., 2017; L. H. R. H.
|     |     | p   |     | Zeuwts et al., 2021; G. Zhao et al.,  |
| --- | --- | --- | --- | ------------------------------------- |
2023)
  (Ahlstrom et al., 2016; Gadsby et al.,
t 2022; Gay et al., 2023; Jashami et al.,
|     | Mean/ median       | o                        |                                             | 2023; Nygårdhs et al., 2018;            |
| --- | ------------------ | ------------------------ | ------------------------------------------- | --------------------------------------- |
|     |                    | The average duration of  | AOIs with longer mean/median fixation time  |                                         |
|     | fixation duration  |                          |                                             | Pashkevich et al., 2022; K. van         |
|     |                    | fixations on an AOI      | capture more attention                      |                                         |
|     | per AOI            | n                        |                                             | Paridon et al., 2021; Vansteenkiste et  |
al., 2017; L. Zeuwts et al., 2016; L. H.
|     |     |     |     | R. H. Zeuwts et al., 2023) |
| --- | --- | --- | --- | -------------------------- |
t
|     | Maximnum  |     | Longer maximum fixation durations (on the  |     |
| --- | --------- | --- | ------------------------------------------ | --- |
The maximum duration of
fixation duration  phone) indicate cyclists' possibility to prepare  (Ahlstrom et al., 2016)
fixations on an AOI
|     | peir AOI |     | and plan ahead. |     |
| --- | -------- | --- | --------------- | --- |
r
p
The distance between the
Fixation  cyclist and the first fixation  AOIs with longer fixation distances indicate  (Pashkevich et al., 2022; Rupi &
eFixation distance
Distance of an AOI, measured in  higher demand on safety concerns. Krizek, 2019)
meters
r
P
45
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007

d
e
w
The duration between the AOIs with longer time to arrival indicate its
(Gadsby et al., 2022; L. H. R. H.
Time to arrival first fixation of an AOI and visual salience or cyclists' needs for longer
eZeuwts et al., 2021, 2023)
arrival, measured in seconds reaction time.
i
The total number of v
Saccade Total number of AOIs receiving more saccade counts capture
saccades on an AOI during (Ramirez Juarez et al., 2023)
Count saccades per AOI more attention.
a ride e
r
r
e
e
p
t
o
n
t
n
i
r
p
e
r
P
46
This preprint research paper has not been peer reviewed. Electronic copy available at: https://ssrn.com/abstract=4769007
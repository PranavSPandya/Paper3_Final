Electrodermal Activity as a Unimodal Signal for
Aerobic Exercise Detection in Wearable Sensors
1st Rena Krishna 2nd Ramya Sankar 3rd Shadi Ghiasi
Odle Middle School
ImagineQ Labs ImagineQ Labs Cambridge Center for International
Bellevue, WA, USA B e l levue, WA, USA R e s e a r ch, United Kingdom
ORCID 0009-0005-7145-491X
Abstract—Electrodermal Activity (EDA) is a non-invasive prior work has demonstrated the sensitivity of EDA to
physiological signal widely available in wearable devices and changes in sympathetic tone across cognitive, affective, and
reflects sympathetic nervous system (SNS) activation. Prior physiological states, establishing it as a robust indicator of
multi-modal studies have demonstrated robust performance in SNS activity [7], [8], [9], [10].
distinguishing stress and exercise states when EDA is combined
with complementary signals such as heart rate and Recent wearable studies have increasingly adopted
accelerometry. However, the ability of EDA to independently multimodal approaches that combine EDA with
distinguish sustained aerobic exercise from low-arousal states cardiovascular and motion-based signals to improve
under subject-independent evaluation remains insufficiently classification performance. Large-scale studies by Hongn et
characterized. al., demonstrated strong discrimination among stress, aerobic,
anaerobic, and rest when EDA was integrated with heart rate
This study investigates whether features derived exclusively and accelerometry [11]. While these results highlight the
from EDA can reliably differentiate rest from sustained aerobic effectiveness of multimodal sensing, they do not isolate the
exercise. Using a publicly available dataset collected from thirty specific contribution of EDA itself. Thus, it remains unclear
healthy individuals, EDA features were evaluated using
which aspects of activity-state discrimination arise from the
benchmark machine learning models with leave-one-subject-out
sympathetic sudomotor responses versus complementary
(LOSO) validation.
contributions from cardiovascular dynamics or movement
patterns.
Across models, EDA-only classifiers achieved moderate
subject-independent performance, with phasic temporal Other notable work by Posada-Quintero et al., has
dynamics and event timing contributing to class separation. characterized how spectral shifts in EDA vary across rest,
Rather than proposing EDA as a replacement for multimodal walking, and running [12]. While such studies provide
sensing, this work provides a conservative benchmark of the
important physiological insight into EDA responses to
discriminative power of EDA alone and clarifies its role as a
physical exertion, they do not assess whether these changes
unimodal input for wearable activity-state inference.
alone are sufficient to reliably classify activity states or
generalize across individuals using subject-independent
I. INTRODUCTION
evaluation.
Aerobic exercise is a physiological state characterized by
Evaluating EDA as a standalone signal therefore enables
sustained cardiovascular, respiratory, and metabolic
direct assessment of how reliably sympathetic sudomotor
regulation that supports continuous adenosine triphosphate
responses alone differentiate sustained aerobic exercise from
(ATP) production through mitochondrial oxidative
low-arousal states. By analyzing EDA independently of
phosphorylation [1], [2]. It is typically performed at moderate
cardiovascular and motion-based cues, this approach clarifies
intensities at or below the ventilatory threshold (VT), where
EDA’s role within wearable sensing frameworks, especially
oxygen supply is sufficient to meet muscular metabolic
those that prioritize low power consumption, robustness to
demand, and is accompanied by elevated heart rate,
sensor dropout, or minimal sensing configurations.
ventilation, and muscle perfusion [3]. During aerobic exercise,
skeletal muscle glucose uptake increases driven by both While modalities such as functional near-infrared
insulin-dependent and insulin-independent pathways, spectroscopy (fNIRS) and electroencephalography (EEG)
resulting in a net reduction in circulating blood glucose levels have been explored for related assessments, their limited
[4], [5]. This metabolic profile distinguishes aerobic exercise portability restricts use in wearable systems [13]. In contrast,
from anaerobic exercise and stress, which elicit acute EDA can be acquired with low-power, wrist-worn sensors.
sympathetic responses without sustained glucose utilization. Compared with wearable signals like blood volume pulse
In aerobic exercise, physical arousal is regulated and (BVP) and heart rate variability (HRV), EDA is less directly
proportional to workload, whereas psychological stress influenced by motion, hydration, or fitness-related
induces rapid and often disproportionate arousal, and cardiovascular adaptations. For example, fitness level does
anaerobic exercise elicits brief, high-intensity sympathetic not directly modulate sympathetic sudomotor firing but
responses. Accurate identification of aerobic exercise is substantially alters HRV and BVP though long-term
therefore relevant for wearable health monitoring systems and cardiovascular and autonomic adaptations [8] [14].
for applications in which prolonged physical exertion has
distinct physiological or metabolic implications. Accordingly, the objective of this study is not to
outperform multimodal activity recognition systems, but to
Electrodermal Activity (EDA) is a non-invasive conservatively assess whether EDA alone contains
physiological signal governed by sudomotor activation and reproducible, subject-independent signatures of sustained
reflects changes in skin conductance driven by eccrine sweat aerobic exercise. Using a publicly available wearable dataset,
glands [6]. Because EDA is not directly modulated by this work establishes a benchmark characterization of the
parasympathetic input, it has been widely studied as a marker strengths and limitations of EDA-only models and informs
of autonomic arousal, particularly in the context of real-world extensions.
psychological stress and emotional activation [4]. Extensive

II.  MATERIALS AND METHODS  not be sustained. The protocol commenced with a 3-minute
|     |     |     |     |     |     | warm-up  | during  | which  | the  | participants  | pedaled  | without  |
| --- | --- | --- | --- | --- | --- | -------- | ------- | ------ | ---- | ------------- | -------- | -------- |
A. Dataset Description   resistance. Following the warm up, the exercise began at low
| This  study  | utilized  | a   | publicly  | available,  | multimodal  |     |     |     |     |     |     |     |
| ------------ | --------- | --- | --------- | ----------- | ----------- | --- | --- | --- | --- | --- | --- | --- |
resistance (20% of maximum) and progressed through three
dataset of physiological signals collected from 30 subjects  3-minute  stages  at  60,  70,  and  75  rpm,  with  resistance
during a structured aerobic exercise session [15][16]. Table  gradually increasing to a medium level (30% of maximum).
2.1 summarizes the demographic characteristics of the thirty  The protocol then included four additional stages of increasing
subjects  that  completed  the  aerobic  protocol.  From  this  resistance: the first two lasting 3 minutes each and the second
dataset,  Subjects  S03  and  S07  were  removed  due  to  two lasting 2 minutes each. The final stage was performed at
incomplete protocol completion, and S11 due to data quality  a  fixed  medium-high  resistance  (50%  of  maximum)  and
issues. The remaining 27 subjects were included in this study.  consisted of three 2-minute periods at 100, 105, and 110 rpm.
It is noteworthy that the study population consisted of healthy  Upon completion of this exercise protocol, the participants
young adults, which may limit generalization to pediatric,  completed a 4-minute cooldown period with no resistance,
geriatric, or clinical populations.   and then 2 minutes of standing still [15].
TABLE 2.1  From this dataset, the EDA signal was extracted for the 27
subjects, while all other physiological signals were excluded
DATASET DEMOGRAPHIC CHARACTERISTICS
from analysis. To streamline signal processing, a windowing
approach was applied [7], [18]. A 120-second rest window (0-
|           |         |      | Height  | Weight  | Exercises  |     |     |     |     |     |     |     |
| --------- | ------- | ---- | ------- | ------- | ---------- | --- | --- | --- | --- | --- | --- | --- |
| Subject   | Gender  | Age  |         |         |            |     |     |     |     |     |     |     |
(cm)  (kg)  regularly  120s)  was  extracted  from  the  warm-up  phase  to  ensure
consistent sensor contact and minimize movement transition.
S01  m  21  192  84  Yes  A 180-second aerobic window (1560-1740s) was extracted,
S02  m  20  185  95  No  spanning  the  final  120  seconds  of  cycling  at  110  rpm
|      |     |     |      |     |      | (medium-high  |     | resistance)  |     | and  the  | first  | 60  seconds  of  |
| ---- | --- | --- | ---- | --- | ---- | ------------- | --- | ------------ | --- | --------- | ------ | ---------------- |
| S03  | m   | 20  | 175  | 62  | Yes  |               |     |              |     |           |        |                  |
cooldown. Aerobic segments were intentionally extended into
| S04  | m   | 21  | 174  | 70  | Yes  |     |     |     |     |     |     |     |
| ---- | --- | --- | ---- | --- | ---- | --- | --- | --- | --- | --- | --- | --- |
early recovery to capture sustained sympathetic activation,
| S05  | m   | 21  | 173  | 72  | Yes  |     |     |     |     |     |     |     |
| ---- | --- | --- | ---- | --- | ---- | --- | --- | --- | --- | --- | --- | --- |
which persists beyond mechanical cessation of activity in
S06  m  21  172  70  Yes  EDA.  Overall,  the  selected  windows  represented  stable
S07  m  19  184  88  Yes  physiological states with minimal transition effects, reducing
|      |     |     |      |     |      | label                      | ambiguity  | and  | enabling  | conservative  |     | evaluation  of  |
| ---- | --- | --- | ---- | --- | ---- | -------------------------- | ---------- | ---- | --------- | ------------- | --- | --------------- |
| S08  | m   | 20  | 174  | 67  | Yes  |                            |            |      |           |               |     |                 |
| S09  | m   | 19  | 174  | 63  | Yes  | EDA-based classification.  |            |      |           |               |     |                 |
| S10  | m   | 21  | 180  | 80  | Yes  |                            |            |      |           |               |     |                 |
S11  m  21  183  64  Yes  3 min  9 min  6 min   4 min  6 min  4  2
| S13  | m   | 21  | 175  | 65  | Yes  |       |                  |          |             |         |              | min  min     |
| ---- | --- | --- | ---- | --- | ---- | ----- | ---------------- | -------- | ----------- | ------- | ------------ | ------------ |
|      |     |     |      |     |      | Warm  | Low resistance   |          | Low-medium  |         | Medium-high  | Cool  Still  |
| S14  | m   | 19  | 182  | 85  | Yes  |       |                  |          |             |         |              |              |
|      |     |     |      |     |      | up    |                  |          | resistance  |         | resistance   | down         |
| S15  | m   | 21  | 176  | 77  | Yes  |       |                  |          |             |         |              |              |
|      |     |     |      |     |      |       | 60               | 70   75  | 80  85      | 90  95  | 100  105     | 110          |
| S16  | m   | 20  | 168  | 61  | Yes  |       |                  |          |             |         |              |              |
rpm units
| S17  | m   | 22  | 173  | 78  | Yes  |     |     |     |     |     |     |     |
| ---- | --- | --- | ---- | --- | ---- | --- | --- | --- | --- | --- | --- | --- |

S18  m  21  183  80  Yes  Fig. 2.1 Aerobic Exercise Protocol Stages
| f01  | f   | 25  | 152  | 61  | No   |     |     |     |     |     |     |     |
| ---- | --- | --- | ---- | --- | ---- | --- | --- | --- | --- | --- | --- | --- |
| f02  | f   | 29  | 164  | 80  | No   |     |     |     |     |     |     |     |
| f03  | f   | 26  | 160  | 61  | Yes  |     |     |     |     |     |     |     |
| f04  | f   | 29  | 168  | 56  | No   |     |     |     |     |     |     |     |
| f05  | f   | 21  | 165  | 55  | Yes  |     |     |     |     |     |     |     |
| f06  | f   | 21  | 169  | 58  | No   |     |     |     |     |     |     |     |
| f07  | f   | 21  | 163  | 47  | No   |     |     |     |     |     |     |     |
| f08  | f   | 22  | 158  | 50  | No   |     |     |     |     |     |     |     |
| f09  | f   | 21  | 170  | 56  | Yes  |     |     |     |     |     |     |     |
| f10  | f   | 21  | 172  | 65  | Yes  |     |     |     |     |     |     |     |
| f11  | f   | 31  | 170  | 84  | No   |     |     |     |     |     |     |     |
| f12  | f   | 30  | 158  | 97  | No   |     |     |     |     |     |     |     |
| f13  | f   | 29  | 154  | 56  | No   |     |     |     |     |     |     |     |

The physiological signals were collected using a wearable
| Empatica E4  | wristband  | with  | EDA  | sampled at  | 4Hz. The  |     |     |     |     |     |     |     |
| ------------ | ---------- | ----- | ---- | ----------- | --------- | --- | --- | --- | --- | --- | --- | --- |
aerobic exercise session followed the Storer-Davis maximal
bicycle protocol, consisting of approximately 35 minutes of
continuous stationary cycling [15], [17].
For each participant, the maximum resistance was first
determined as the highest workload at which pedaling could

Fig. 2.2 Electrodermal activity signal before and after pre-processing
B. Pre-processing ripple artifacts that distort EDA dynamics [20], [21].
Butterworth filtering was therefore chosen as the most
The EDA signals were preprocessed to attenuate baseline
conservative approach for pre-processing to isolate EDA and
drift and high frequency noise. For each subject, the full EDA
minimize distortion. A representative example of the signals
recording was filtered using a zero-phase fourth-order
before and after preprocessing are shown in Figure 2.2.
Butterworth bandpass filter (0.01-1.0Hz) [19], where the
lower cutoff attenuates slow drift, while the upper cutoff C. Feature Extraction
suppresses high-frequency noise and motion-related artifacts.
Following pre-processing, for each subject, two feature
The band-limited signals were then normalized using min– vectors were generated: one corresponding to the rest
max scaling prior to feature extraction. This normalization condition (first 120 seconds of the recording), and the other
reduces inter-subject amplitude variability arising from corresponding to the aerobic exercise condition (1560-1740
differences in skin properties, sensor contact, or sweat gland seconds of the recording). This resulted in two labelled
density, and emphasizes relative temporal dynamics and event
observations per subject, representing rest and aerobic state
structure for subject-independent evaluation. All tonic (low-
respectively, using which a feature matrix was constructed at
frequency), phasic (SCR-related), and spectral features were
the subject level.
computed from the band-limited, normalized EDA signal,
A total of twenty-three initial candidate features were
yielding scale-invariant features suitable for subject-
extracted from both the time domain and the frequency
independent evaluation.
domain. A three-step process was followed to extract
In this study, tonic activity is operationally defined as the features. Firstly, a time-series analysis of the pipeline was
low-frequency component of the band-limited EDA signal used to extract both statistical measures and EDA-specific
obtained with a low-pass filter with a cutoff of 0.05Hz. Phasic signal characteristics from the time-domain. Tonic features
activity is operationally defined as SCR-related dynamics were extracted with a low-pass filter and phasic with a
within higher frequency bands (0.1-0.5Hz) of the band-limited secondary band-pass filter (see Pre-processing).
EDA signal and characterized through event timing, recovery
Secondly, frequency analysis was performed using the
dynamics, and relative amplitude rather than explicit tonic
power spectral density of the signal, obtained using Welch’s
subtraction.
method. Welch’s method estimates power spectral density by
The Butterworth filter was selected due to its maximally averaging windowed periodograms across overlapping signal
flat frequency response, which avoids passband and stopband segments, providing a robust and low variance spectral
ripples and preserves relative signal amplitudes [19]. This estimate. Frequency features helped capture sustained
property is especially important for EDA where distortion of oscillatory activation associated with prolonged exertion.
low-frequency dynamics can affect tonic and phasic Welch’s PSD estimate is formally represented below [22].
characterization. In contrast, filtering approaches like the
Savitzky-Golay perform polynomial smoothing without
explicit frequency selectivity, and Chebyshev filters introduce

|        | 𝐾         |              |     | PSD band power    |     | Frequency band power        |     |
| ------ | --------- | ------------ | --- | ----------------- | --- | --------------------------- | --- |
|        | 1 1       |              |     | Tonic mean slope  |     | Tonic trajectory/sequence   |     |
| 𝑃̂(𝑓)= | ∑  |𝐷𝐹𝑇{𝑥 | (𝑛)⋅𝑤(𝑛)}|2  |     |                   |     |                             |     |
𝑘
|          | 𝐾 𝑓𝑠 𝑈 |     |     | Tonic ratio up       |     | Tonic trajectory/sequence   |     |
| -------- | ------ | --- | --- | -------------------- | --- | --------------------------- | --- |
|          | 𝑘=1    |     |     | Activation duration  |     | Tonic trajectory/sequence   |     |
| Where:   |        |     |     |                      |     |                             |     |
Pˆ(f) represents the estimated power spectral density at
D. Feature Selection
frequency f,
|     |     |     |     | To  reduce  | feature  redundancy  | and  multi-collinearity,  |     |
| --- | --- | --- | --- | ----------- | -------------------- | ------------------------- | --- |
U is the window normalization factor
K is the number of segments   several visualization and data mining techniques were used.
x (n) denotes the kth signal segment in time domain   After an initial data-quality validation, several features like
k
Mean Raw EDA, Mean Phasic EDA, Tonic variance, Phasic
w(n) is a Hann window
Variance, Tonic Ratio Up and Activation Duration were
| Welch’s  | method  was  selected  | over  direct  | FFT-based  |     |     |     |     |
| -------- | ---------------------- | ------------- | ---------- | --- | --- | --- | --- |
spectral estimation due to its improved variance reduction  removed because they exhibited near-zero or constant values,
and robustness to noise, which is desirable for low-frequency   due  to  signal  normalization  and  windowing  constraints.
|     |     |     |     | These  features  | were  excluded  | prior  to  applying  | more  |
| --- | --- | --- | --- | ---------------- | --------------- | -------------------- | ----- |
physiological signals such as EDA.
Thirdly, tonic trajectory (sequence) features were initially  sophisticated data mining techniques to prevent numerical
explored using sliding window summaries (e.g., tonic slope  instability  or  introducing  a  protocol-specific  bias  in  the
pipeline.
representing overall trend, activation duration representing
how long the trend was sustained) following prior work  A correlation analysis was performed across all remaining
emphasizing the benefits of segmentation for downstream  features using pairwise correlation coefficients. As a result,
highly correlated features such as Peak density, SCR Interval
systems [23]. However, these sequence-based features were
Mean, SCR Interval RMSSD, 2nd Amplitude, Frequency 2nd
excluded from the final model set because they behaved as
protocol-dependent  proxies  under  fixed-window  Amplitude, and PSD Band power were removed. Feature
segmentation (see Feature Selection and Limitations).  selection  was  then  performed  using  Recursive  Feature
Elimination (RFE) with a logistic regression classifier as the
In addition to standard statistical features extracted using
Python’s standard scipy, pandas, biosppy libraries, custom  base estimator to rank features based on their contribution to
frequency  features  were  also  developed  to  characterize  the classifier’s decision boundary and their informative value
[24], [25]. Prior to RFE, missing values were imputed using
spectral structure. Specifically, the number of local maxima
or spectral peaks in the PSD was computed by identifying the  the  median  and  features  standardized  to  ensure
frequency bins where spectral slope changed from positive to  comparability. After RFE ranking, the top eight features were
|                          |                      |     |                 | taken  into  modeling.  | SCR  | Interval  Max  and  | Freq  Peak  |
| ------------------------ | -------------------- | --- | --------------- | ----------------------- | ---- | ------------------- | ----------- |
| negative.  Furthermore,  | the  second-largest  |     | spectral  peak  |                         |      |                     |             |
Amplitude were removed as they were ranked lower than the
amplitude was also extracted by masking the dominant peak
in the PSD and computing the maximum of the remaining  other features. Tonic mean slope was initially included but
spectrum.  These  features  were  designed  to  uniquely  eventually  removed  during  LOSO  validation  due  to
overfitting concerns. The remaining features were used in
distinguish the repeated, sustained sympathetic activation
during  aerobic  activity  and  differentiate  both  spectral  model development.
complexity and energy distribution between rest and aerobic  A limitation of this approach was that RFE was applied as
a global feature ranking step rather than nested within cross-
conditions. A summary of extracted features is shared in
Table 2.3.    validation,  which  may  introduce  an  optimistic  bias;
  accordingly reported feature rankings are indicative rather
than definitive. This limitation was partially addressed by
TABLE 2.3
INITIAL CANDIDATE FEATURES   subject-independent  LOSO  validation  during  model

evaluation to mitigate overfitting and assess generalization to
Feature Name  Feature Type  unseen individuals. Principal Component Analysis (PCA)
Mean Raw EDA  Raw signal, Time-domain   was not included in the final modelling pipeline to retain
| Kurtosis  | Raw signal, Time-domain   |     |     |     |     |     |     |
| --------- | ------------------------- | --- | --- | --- | --- | --- | --- |
feature-level interpretability. The formulas for all selected
| Skewness  | Raw signal, Time-domain   |     |     |     |     |     |     |
| --------- | ------------------------- | --- | --- | --- | --- | --- | --- |
features are shown in Table 2.4. A visual representation of
IQR  Raw signal, Time-domain  the correlation matrix with features selected by RFE and used
| Mean Tonic EDA  | Tonic characteristic  |     |     |     |     |     |     |
| --------------- | --------------------- | --- | --- | --- | --- | --- | --- |
in model development is shown in Fig. 2.4 [24].
| Tonic Variance   | Tonic characteristic    |     |     |               |           |                      |              |
| ---------------- | ----------------------- | --- | --- | ------------- | --------- | -------------------- | ------------ |
|                  |                         |     |     | In  addition  | to  data  | mining  techniques,  | statistical  |
| Mean Phasic EDA  | Phasic characteristic   |     |     |               |           |                      |              |
distribution analysis was performed using boxplots to assess
| Phasic Variance  | Phasic characteristic  |     |     |     |     |     |     |
| ---------------- | ---------------------- | --- | --- | --- | --- | --- | --- |
Phasic Mean Rise Time  Phasic temporal dynamics  the quality of RFE-selected features to be used in modeling.
The boxplot analysis of these selected features is shown in
| Phasic Mean Recovery Time  | Phasic temporal dynamics  |     |     |     |     |     |     |
| -------------------------- | ------------------------- | --- | --- | --- | --- | --- | --- |
Fig. 2.5.
| Peak density            | Phasic event timing         |     |     |     |     |     |     |
| ----------------------- | --------------------------- | --- | --- | --- | --- | --- | --- |
| SCR Peaks per min       | Phasic event timing         |     |     |     |     |     |     |
| SCR Interval Mean       | Phasic event timing         |     |     |     |     |     |     |
| SCR Interval Max        | Phasic event timing         |     |     |     |     |     |     |
| SCR Interval RMSSD      | Phasic event timing         |     |     |     |     |     |     |
| Peak Amplitude          | Phasic characteristic       |     |     |     |     |     |     |
| Second_Amplitude        | Phasic characteristic       |     |     |     |     |     |     |
| Freq Peak Amplitude     | Frequency-domain structure  |     |     |     |     |     |     |
| Freq 2ndPeak Amplitude  | Frequency-domain structure  |     |     |     |     |     |     |

TABLE 2.4
FORMULAS FOR SELECTED FEATURES
Feature Name Computation
Mean Tonic EDA Mean Tonic EDA represents the statistical mean of the low frequency (0.05Hz) component of the band-pass filtered
and normalized EDA signal. This metric captures the sustained low-frequency sympathetic activation patterns while
remaining invariant to absolute conductance scaling across subjects [7], [12], [13], [26].
Skewness Skew measures the asymmetry in the EDA signal distribution. Positive skew indicates longer right tail while
negative skew indicates longer left tail [7], [12], [17].
In EDA physiology, skewness increases when sympathetic events create occasional large positive excursions. The
Scipy skew formula used in this analysis is based on the third standardized central moment:
Skew (𝑥)=𝜇3
𝜎3
where 𝜇 is the third central moment and 𝜎 is the standard deviation.
3
Kurtosis Kurtosis measures extreme values in distribution. A normal distribution has a kurtosis of 0, while positive kurtosis
indicates heavier tails and negative kurtosis indicates lighter tails (fewer outliers) [7], [12], [17].
Kurtosis (𝛽)=𝜇4
𝜎4
where 𝜇 is the fourth central moment and 𝜎 is the standard deviation.
4
IQR IQR measures the spread of the middle 50% of values in the signal. In EDA, it reflects whether the signal is tightly
clustered (low arousal) versus more dispersed (higher arousal and variability) and robust to outliers [7], [12], [14],
[30].
𝐼𝑄𝑅=𝑄(𝑥)−𝑄(𝑥)
𝑖 𝑗
Where i and j are the 75th and 25th percentiles, respectively.
Phasic Mean Rise Time Phasic mean rise time estimates how long it takes for an SCR to rise from onset (baseline/threshold) to its peak. The
onset is defined as the earliest time index before the peak 𝑝 at which the signal exceeds 50% of the peak amplitude
𝑘
above the baseline, using a backward search window [7], [12], [17].
1 𝑀
𝑡̅ ={ ∑ 𝑡 (𝑝 )
𝑟𝑖𝑠𝑒 𝑀 𝑟𝑖𝑠𝑒 𝑘
𝑘=1
Where 𝑡 is rise time defined as:
𝑟𝑖𝑠𝑒
𝑝 −𝑜
𝑡 (𝑝)= 𝑘 𝑘
𝑟𝑖𝑠𝑒 𝑓
𝑠
Where 𝑝 is the sample index of the k-th detected phasic peak, 𝑜 is the onset index of the corresponding SCR
𝑘 𝑘
immediately preceding 𝑝 , and 𝑓 is the sampling rate. Note, that 𝑡̅ = 0 when M=0.
𝑘 𝑠 𝑟𝑖𝑠𝑒
Meaning: Shorter rise times indicate sharper, more rapid sympathetic responses (i.e., aerobic or stress).
Phasic Mean Recovery Time Phasic mean recovery time estimates how long it takes for an SCR to decay after reaching its peak. It is defined as
the time from peak until the phasic signal falls to below 50% of the peak amplitude above the baseline, within a
forward search window (120s) [7], [12], [17].
For M>0, phasic mean recovery time is defined as:
1 𝑀
𝑡̅ ={ ∑ 𝑡 (𝑝 )
𝑎 𝑀 𝑎 𝑘
𝑘=1
Where 𝑡 is recovery time defined as:
𝑎
𝑗 −𝑝
𝑡 (𝑝 )= 𝑘 𝑘
𝑎 𝑘 𝑓
𝑠
Where 𝑗 is the first time after 𝑝 where the signal falls below 50% of peak amplitude above the baseline. Note, that
𝑘 𝑘
𝑡̅ = 0 when M=0.
𝑎
Meaning: Longer recovery times indicate more sustained sympathetic activation (i.e., aerobic or stress).
Peak Amplitude Peak amplitude is the largest phasic peak amplitude in a segment, calculated using the Scipy find_peaks() function to
find the largest magnitude. Peaks are detected in the phasic component using a prominence threshold set to one
phasic standard deviation [1], [10], [12], [17].
Peak amplitude is mathematically equal to the maximum difference between the phasic signal peak and its baseline
(mean).
Peak Amplitude |(𝑃)|=Peak −Onset
𝑖 𝑖 𝑖
SCR Peaks per min SCR peaks per minute are measures of SCR event rate calculated using the Scipy find_peaks() function and counting
the number of peaks per minute where amplitude is greater than standard deviation [7]. [11], [12], [14].
Peaks are detected in the phasic component using a prominence threshold set to one phasic standard deviation. The
count is normalized by segment duration to yield peaks per minute.
SCR peaks per minute S, is defined as:
|𝑃| 60|𝑃|
𝑆= =
𝑇∕60 𝑇
Where |P| is the number of detected peaks.

Fig. 2.4 Feature Heatmap of RFE-Selected Features used in modeling
Fig. 2.5 Boxplots of RFE-selected Features used in modeling

E. Machine Learning Model Development   Other models like CatBoost were considered but not
|     |     |     |     |     |     |     |     | included  | in  the  | final  | model  set  | due  | to  performance  |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | -------- | ------ | ----------- | ---- | ---------------- | --- |
To evaluate the suitability of EDA-based features for
wearable and safety-critical applications, a curated set of  redundancy with existing boosting models and its primary
advantages for categorical features which were not present in
supervised machine learning (ML) models was selected to
the dataset.
balance interpretability, nonlinear modelling capacity, and
robustness to correlated physiological features. The chosen
|                  |              |     |          |     |           |           |     |     |     | III.  | RESULTS   |     |     |     |
| ---------------- | ------------ | --- | -------- | --- | --------- | --------- | --- | --- | --- | ----- | --------- | --- | --- | --- |
| models  reflect  | constraints  |     | typical  | of  | wearable  | systems,  |     |     |     |       |           |     |     |     |
including limited data availability, inter-subject variability,  A. Model Results and Evaluation Metrics
and need for generalization to unseen individuals [26].
All models were trained and evaluated using Stratified 5-
Linear Discriminant Analysis (LDA) was employed as
|     |     |     |     |     |     |     |     | fold  Cross  | Validation  |     | (CV)  and  | Leave-one-subject-out  |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | ----------- | --- | ---------- | ---------------------- | --- | --- |
transparent linear baseline to assess whether rest and aerobic  (LOSO)  cross-validation.  Stratified  5-fold  CV  assessed
exercise states could be separated using simple combinations
|                      |     |                |     |      |            |           |     | within-dataset  | generalization  |                      | under  | random  | splits,      | while  |
| -------------------- | --- | -------------- | --- | ---- | ---------- | --------- | --- | --------------- | --------------- | -------------------- | ------ | ------- | ------------ | ------ |
| of  physiologically  |     | interpretable  |     | EDA  | features.  | Gaussian  |     |                 |                 |                      |        |         |              |        |
|                      |     |                |     |      |            |           |     | LOSO            | assessed        | subject-independent  |        |         | performance  | with   |
Naïve Bayes (Gaussian NB) served as a probabilistic and  unseen  individuals.  Preprocessing  steps,  including
computationally efficient baseline under the assumption of  imputation and scaling were performed within each training
conditional feature independence. Logistic Regression (LR)
fold to prevent data leakage [7], [28].
was included as a low-variance, interpretable baseline model  Classification  performance  was  quantified  using
to  benchmark  the  performance  gains  of  more  complex,  accuracy, balanced accuracy, precision, recall, and F1 score.
nonlinear classifiers. A single Decision Tree Classifier was
|     |     |     |     |     |     |     |     | Confusion  | matrices  | were  | inspected  | to  | confirm  | balanced  |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | --------- | ----- | ---------- | --- | -------- | --------- |
included as a highly interpretable baseline to examine if
|                                                            |       |          |     |               |      |             |     | classification  | performance  |     | across  | both  | rest  and  | aerobic  |
| ---------------------------------------------------------- | ----- | -------- | --- | ------------- | ---- | ----------- | --- | --------------- | ------------ | --- | ------- | ----- | ---------- | -------- |
| simple hierarchical rules could separate rest and aerobic  |       |          |     |               |      |             |     | classes.        |              |     |         |       |            |          |
| states,  while                                             | also  | serving  | as  | a  reference  | for  | tree-based  |     |                 |              |     |         |       |            |          |
Under LOSO evaluation, the models achieved moderate
ensemble methods [27].
mean performance with substantial inter-subject variability,
Additional models were evaluated like the Multi-layer  reflecting  individual  differences  in  EDA  responses  or
Perceptron (MLP) to assess the performance of a shallow  sensor/contact effects. The LDA model performed best with
neural network architecture on engineered EDA features.
an F1 score of 91% (0.91+/- 0.22) and LOSO precision of
Distance-based methods such as k-Nearest Neighbors (kNN)  89% (0.89 +/-0.25) and LOSO recall of 96% (0.96 +/- 0.19).
were  evaluated  to  test  whether  local  similarity  in  the  Table  4.1  shows  LOSO  results  and  Fig.  4.1  shows  the
| engineered  | feature  | space  | provides  | reliable  | discrimination  |     |     |     |     |     |     |     |     |     |
| ----------- | -------- | ------ | --------- | --------- | --------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
confusion matrix for the LOSO performance of LDA.
| under  subject-independent  |     |     | evaluation.  |     | Notably  |     | kNN  |     |     |     |     |     |     |     |
| --------------------------- | --- | --- | ------------ | --- | -------- | --- | ---- | --- | --- | --- | --- | --- | --- | --- |
Under 5-fold stratified validation, kNN model with k=5
demonstrated  competitive  performance  indicating  that  performed best achieving an F1 score of 91% (0.91 +/- 0.11)
meaningful class separation exists in the feature space despite
and precision of 90% (0.90 +/-0.15) and recall of 92% (0.92
inter-subject variability.
+/- 0.11). Figure 4.2 shows the confusion matrix for the LDA
Support Vector  Machines (SVM) with a radial basis  model in 5-fold validation.
function  kernel  (RBF)  was  selected  to  model  nonlinear  Overall, these results show that multiple model families
decision boundaries arising from the complex interactions
(linear, distance-based, kernel, and ensemble methods) can
between tonic, phasic, and spectral components in EDA while  achieve  comparable  performance  when  using  EDA-only
maintaining strong generalization on the small dataset.   datasets to differentiate between rest and aerobic exercise.
Tree-based ensemble models were included due to their
TABLE 4.1
robustness  to  noise,  feature  correlation,  and  non-linear  LOSO CROSS VALIDATION RESULTS

interactions commonly observed in wearable bio signals.
Bagging models like Random Forest classifiers were used as  F1 Score  Precision  Recall
Model
a bagging ensemble to reduce variance through feature and
|     |     |     |     |     |     |     |     |     | Mean  |     | SD  Mean  | SD  | Mean  | SD  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ----- | --- | --------- | --- | ----- | --- |
sample averaging, providing improved generalization and  LDA  0.91  0.22  0.89  0.25  0.96  0.19
| stable  performance  |     | across  | subjects,  |     | and  | resistance  | to  |              |     |       |             |       |       |       |
| -------------------- | --- | ------- | ---------- | --- | ---- | ----------- | --- | ------------ | --- | ----- | ----------- | ----- | ----- | ----- |
|                      |     |         |            |     |      |             |     | Extra Trees  |     | 0.89  | 0.28  0.87  | 0.30  | 0.93  | 0.27  |
overfitting. Extra Trees classifiers were also included as
|     |     |     |     |     |     |     |     | LR  |     | 0.88  | 0.32  0.87  | 0.33  | 0.89  | 0.32  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----- | ----------- | ----- | ----- | ----- |
highly randomized tree ensemble to assess whether increased
|     |     |     |     |     |     |     |     | kNN  |     | 0.86  | 0.32  0.85  | 0.33  | 0.89  | 0.32  |
| --- | --- | --- | --- | --- | --- | --- | --- | ---- | --- | ----- | ----------- | ----- | ----- | ----- |
randomization in feature selection and split thresholds ness
improves robustness and generalization in noisy, correlated  SVM  0.85  0.32  0.83  0.34  0.89  0.32
feature sets [28].
|     |     |     |     |     |     |     |     | MLP  |     | 0.83  | 0.36  0.81  | 0.37  | 0.85  | 0.36  |
| --- | --- | --- | --- | --- | --- | --- | --- | ---- | --- | ----- | ----------- | ----- | ----- | ----- |
Gradient-boosted  decision  trees  were  implemented  to  XG Boost  0.83  0.36  0.81  0.37  0.85  0.36
capture higher-order nonlinear dependencies with improved
|     |     |     |     |     |     |     |     | Light GBM  |     | 0.81  | 0.36  0.80  | 0.37  | 0.85  | 0.36  |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | --- | ----- | ----------- | ----- | ----- | ----- |
data efficiency. Scikit Learn’s Gradient Boost Classifier was
|     |     |     |     |     |     |     |     | Gaussian NB  |     | 0.81  | 0.32  0.78  | 0.35  | 0.89  | 0.32  |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | --- | ----- | ----------- | ----- | ----- | ----- |
selected as a conservative and stable baseline suitable for
Random
LOSO validation. LightGBM was included as a memory- 0.79  0.39  0.78  0.40  0.81  0.40
Forest
efficient gradient boosting model optimized for fast training,
|     |     |     |     |     |     |     |     | Grad Boost  |     | 0.77  | 0.39  0.74  | 0.40  | 0.81  | 0.40  |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | --- | ----- | ----------- | ----- | ----- | ----- |
while XGBoost was evaluated as a high-capacity boosting
|     |     |     |     |     |     |     |     | Decision Tree  |     | 0.70  | 0.44  0.69  | 0.44  | 0.74  | 0.45  |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------- | --- | ----- | ----------- | ----- | ----- | ----- |
model with strong regularization mechanisms and robustness
to noise and correlated features [27], [28]. These models
allowed trade-off assessments between boosting capacity and
overfitting in small datasets.

|     |     |     |     |     |     |     | interpretation  | of  | model  | behavior.  | Feature  | relevance  |     | was  |
| --- | --- | --- | --- | --- | --- | --- | --------------- | --- | ------ | ---------- | -------- | ---------- | --- | ---- |
assessed using RFE within a linear modeling framework.
Model interpretability studies such as SHAP analysis [30]
|     |     |     |     |     |     |     | were  not  | applied  | as  | the  primary  | aim  | was  | to  establish  |     |
| --- | --- | --- | --- | --- | --- | --- | ---------- | -------- | --- | ------------- | ---- | ---- | -------------- | --- |
conservative subject-independent performance benchmarks.
To further examine feature behavior across conditions,
box plot analysis was used to visualize the distribution of
|     |     |     |     |     |     |     | selected  | features  | across  | rest  | and  aerobic  | states.  |     | These  |
| --- | --- | --- | --- | --- | --- | --- | --------- | --------- | ------- | ----- | ------------- | -------- | --- | ------ |
visualizations showed consistent shifts in magnitude and
variability for key tonic and phasic features during aerobic
exercise, reflecting increased sympathetic activation.
|     |     |     |     |     |     |     | The  | physiologically  |     | interpretable  |     | EDA  | features  |     |
| --- | --- | --- | --- | --- | --- | --- | ---- | ---------------- | --- | -------------- | --- | ---- | --------- | --- |
exhibiting class-wise separation are shown in Figure 2.5
Phasic amplitude features (e.g., Peak amplitude) and event
timing (e.g., SCR peaks per minute) contributed the most

Fig. 4.1 Confusion Matrix for LDA model in LOSO validation  discriminative  information.  These  feature  importance
  patterns should be interpreted as indicative of general trends
TABLE 4.2   rather  than  definitive  rankings,  given  the  global  feature
5-FOLD CROSS VALIDATION RESULTS
selection strategy and subject-independent evaluation.

|     |           |     |     |            |         |     |     |     | IV.  | DISCUSSION   |     |     |     |     |
| --- | --------- | --- | --- | ---------- | ------- | --- | --- | --- | ---- | ------------ | --- | --- | --- | --- |
|     | F1 Score  |     |     | Precision  | Recall  |     |     |     |      |              |     |     |     |     |
Model
|     | Mean  | SD  | Mean  | SD  | Mean  | SD  |     |     |     |     |     |     |     |     |
| --- | ----- | --- | ----- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
This study demonstrates that EDA, when conservatively
| kNN  | 0.91  | 0.11  | 0.90  | 0.15  | 0.92  | 0.11  |           |              |       |           |          |              |     |      |
| ---- | ----- | ----- | ----- | ----- | ----- | ----- | --------- | ------------ | ----- | --------- | -------- | ------------ | --- | ---- |
|      |       |       |       |       |       |       | filtered  | and  paired  | with  | targeted  | feature  | extraction,  |     | can  |
Extra Trees  0.89  0.09  0.88  0.11  0.92  0.18  distinguish between rest and aerobic exercise under subject-
LDA  0.88  0.08  0.83  0.12  0.96  0.09  independent evaluation [7], [8]. Using a publicly available
LR  0.86  0.17  0.90  0.09  0.88  0.27  dataset, a fixed protocol-based segmentation strategy was
MLP  0.86  0.18  0.93  0.10  0.84  0.26  applied to isolate rest and aerobic exercise windows. After
SVM  0.84  0.11  0.87  0.13  0.85  0.20  data  quality  validation,  twenty-three  time-domain,  tonic,
Random  0.84  0.19  0.82  0.12  0.88  0.27  phasic, and frequency-domain EDA features were extracted
Forest
and systematically evaluated.
Gaussian NB  0.83  0.10  0.80  0.05  0.88  0.18  Several candidate features, including Mean raw EDA,
Gradient
0.80  0.19  0.80  0.13  0.81  0.25  Mean phasic EDA, Tonic and Phasic variance, Tonic ratio up,
Boost
|            |       |       |       |       |       |       | and  Activation     |     | duration,  | exhibited  | near-zero  |           | values  | or  |
| ---------- | ----- | ----- | ----- | ----- | ----- | ----- | ------------------- | --- | ---------- | ---------- | ---------- | --------- | ------- | --- |
| Light GBM  | 0.77  | 0.27  | 0.78  | 0.18  | 0.81  | 0.35  |                     |     |            |            |            |           |         |     |
|            |       |       |       |       |       |       | protocol-dependent  |     | behavior   |            | across     | subjects  | due     | to  |
| XG Boost   | 0.72  | 0.41  | 0.67  | 0.39  | 0.80  | 0.45  |                     |     |            |            |            |           |         |     |
normalization and fixed windowing [12], [31], [32]. These
| Decision Tree  | 0.62  | 0.35  | 0.63  | 0.38  | 0.62  | 0.35  |     |     |     |     |     |     |     |     |
| -------------- | ----- | ----- | ----- | ----- | ----- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
features were excluded to reduce sparsity, prevent numerical
  instability,  and  avoid  introducing  bias  tied  to  the
|     |     |     |     |     |     |     | experimental  | structure  |     | rather  | than  physiological  |     |     | signal  |
| --- | --- | --- | --- | --- | --- | --- | ------------- | ---------- | --- | ------- | -------------------- | --- | --- | ------- |
content.
Both correlation analysis and RFE ranking were applied
to enhance model stability and interpretability while reducing
the risk of overfitting under subject-independent validation.
Correlation analysis was first applied to remove redundant
features, including Peak density, SCR Interval Mean, SCR
Interval RMSSD, 2nd Amplitude, Frequency 2nd Amplitude,
and PSD Band power. RFE further refined the feature set by
removing SCR Interval Max and Freq Peak Amplitude. The
final set of eight features captured complementary aspects of
sympathetic sudomotor activity, including sustained low-
frequency activation (Mean tonic EDA), signal distribution
(Kurtosis, Skewness, and IQR) and phasic dynamics (Mean
rise time, Mean recovery time, Peak amplitude, Peaks per

minute).
Fig. 4.2 Confusion Matrix for kNN model in 5-fold  Observed performance across models indicate that EDA
validation  alone captures limited but reproducible information about
B. Model Explainability   aerobic  activity,  with  LOSO  validation  highlighting
|     |     |     |     |     |     |     | meaningful  | inter-subject  |     | variability  |     | rather  | than  | model  |
| --- | --- | --- | --- | --- | --- | --- | ----------- | -------------- | --- | ------------ | --- | ------- | ----- | ------ |
Model Interpretability in this study was addressed through
instability [32].
| physiologically  | grounded  |     | feature  | design,  | conservative  |     |     |     |     |     |     |     |     |     |
| ---------------- | --------- | --- | -------- | -------- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
The performance of LDA and kNN indicates that rest and
| feature  selection,  |     | and  statistical  |     | analysis.  | All  extracted  |     |     |     |     |     |     |     |     |     |
| -------------------- | --- | ----------------- | --- | ---------- | --------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
aerobic exercise states can be effectively separated using
| features  were  | explicitly  | derived  |     | from  tonic,  | phasic,  | and  |     |     |     |     |     |     |     |     |
| --------------- | ----------- | -------- | --- | ------------- | -------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
simple, physiologically interpretable EDA features, without
spectral components of EDA, enabling direct physiological
requiring high-capacity nonlinear models. Under subject-

independent evaluation, LDA consistently exhibited high Because EDA signals were normalized prior to extraction,
sensitivity to aerobic exercise suggesting potential utility as a tonic-related features reflect relative, low-frequency
conservative screening or contextual signal in health-related activation patterns rather than absolute skin conductance
or safety-critical applications where minimizing missed level. Thus, caution is advised when extending these findings
detections is prioritized. However, the substantial inter- to clinical or free-living contexts that rely on absolute skin
subject variability observed under LOSO suggests that conductance magnitude. Phasic features derived from the
downstream calibration or multimodal integration would be normalized signal, such as peak amplitude, represent relative
required for reliable deployment across individuals. prominence within the segment-specific dynamic range
From a modeling perspective, no single classifier family rather than absolute sympathetic output. Accordingly,
dominated across evaluation protocols, indicating that the amplitude-based features should be interpreted as scale-
engineered EDA feature space can support multiple decision invariant descriptors of activation structure. Timing-based
paradigms. Among other linear models, GNB shows phasic features like phasic mean recovery time remain more
comparatively weaker performance under LOSO, while LR directly comparable across conditions.
and kNN performed more robustly. The MLP model Feature selection was performed globally rather than
demonstrated moderate performance under LOSO, indicating within nested cross-validation, prioritizing interpretability
that a shallow neural network architecture can capture over feature stability estimates. In addition, while tonic
meaningful nonlinear structure in EDA features despite sequence analysis was initially explored to understand how
limited sample size. Kernel-based methods like SVM sympathetic activation evolves over time, the sequence-based
demonstrated consistently competitive performance across features (e.g. tonic slope, activation duration, ratios) were
both LOSO and stratified 5-fold validation suggesting that excluded from the final analysis because they increased the
carefully regularized nonlinear models can generalize with risk of overfitting under the fixed windowing protocol [24],
reasonable consistency when paired with conservative [29].
feature engineering. Model interpretability studies such as SHAP analysis [30]
Collectively, these results highlight the trade-off between were not applied as the primary aim was to establish
model complexity and generalization in small biomedical conservative subject-independent performance benchmarks.
datasets and reinforce the value of selecting moderate- Instead, interpretability was addressed through distribution
complexity models for wearable physiology applications. visualization and summary statistics.
Importantly, these findings support the use of EDA as a Finally, the primary analysis focused on binary rest-
contextual signal in early-stage wearable system designs, aerobic classification. Extension to multi-class or intensity-
particularly in scenarios where sensing constraints limit the aware scenarios was intentionally deferred to isolate EDA as
reliability of motion or cardiovascular signals. Potential an independent physiological signal relevant to fitness and
applications include monitoring training load in endurance glucose related state detection. Prior studies have
athletes, distinguishing prolonged physical exertion from demonstrated that classification performance can be
acute stress in safety-critical occupations such as firefighting improved with the integration of complementary wearable
or emergency response [9], [10] and providing aerobic-aware modalities such as heart rate or accelerometry [11], [15].
rules tied to glucose-uptake for safer insulin dosing strategies
B. Future Work
in artificial pancreas systems [1], [4], [16]. In such
applications, EDA is not intended to replace multimodal Future work will extend this framework beyond binary
rest-aerobic exercise to a three-class classification problem
sensing but supply complementary sympathetic activation to
distinguishing stress, aerobic, anaerobic activity. Preliminary
improve robustness and situational awareness.
results for this extension are included in Appendix B. These
Overall, this work provides evidence that carefully
results address the limitation of fixed aerobic intensity and
processed EDA signals can serve as a viable, non-invasive
enable finer-grained characterization of sympathetic patterns
input for activity-state detection in wearable health systems,
associated with physiologically distinct workloads. Such
while emphasizing the need for subject-independent
differentiation is particularly relevant in active occupational
validation and conservative interpretation when translating
settings, where elevated EDA activity might arise from either
wearable bio-signals to real-world use.
physical exertion or cognitive stress, and accurate context
discrimination is critical for safety and workload assessment
V. CONCLUSION
[10], [34].
A. Limitations
In addition, the proposed EDA-based approach will be
This study is limited by the small number of subjects, evaluated with synchronized glycemic measurements to
which constrained statistical power and necessitated enable joint analysis of electrodermal activity and continuous
conservative model selection. Exercise and rest segments glucose measurements. This integration will support
were defined using fixed protocol-based time windows rather investigation of sympathetic activation during physical and
than automatically detected transitions. Because windows are cognitive loads, how they modulate glucose trajectories,
protocol-based, some discriminative power may reflect time- inform activity-aware safety constraints for closed-loop
dependent sweating and thermoregulation rather than insulin delivery, and improve hypoglycemia risk prediction in
workload alone [33]. Additionally, only a single aerobic artificial pancreas systems [35], [36].
intensity was evaluated, and model performance across While multimodal sensing may further increase
varying aerobic workloads was not assessed, limiting performance, such extensions were not prioritized as the main
generalization to free-living conditions. objective of this study was to isolate the contribution of EDA
and provide a principled foundation for subject-independent

sympathetic state awareness in wearable health and safety- of phasic responses common in anaerobic activity, and tonic
critical applications. window ramp computed from monotonic increases in tonic
trajectory across consecutive 120s windows.
VI. APPENDIX
Following correlation analysis and RFE-ranking, the top
A. Stress vs. Rest (EDA-only) Classification Pipeline ten features used in model development were: tonic variance,
phasic variance, phasic mean risetime, SCR interval max,
Stress vs. Rest classification using EDA has been
SCR interval RMSSD, SCR Peaks per min, IQR, SCR Burst
extensively demonstrated in prior work and is therefore not
fraction, Freq Peak Amplitude, and Tonic Win Ramp
presented here as a novel contribution [9], [12], [18]. Rather,
Benchmark classifiers were trained and evaluated with
this analysis serves as a validation of the preprocessing and
LOSO validation. LDA achieved the highest overall
feature-engineering pipeline used in the present study and
performance (0.70 +/- 0.32 accuracy, 0.64 +/- 0.36 F1, and
provides a physiological reference point for interpreting
0.70 +/- 0.32 recall). False negative rates (FNR) ranged from
performance on the more challenging rest vs. aerobic
0.27 to 0.42 across the models, indicating systematic class
discrimination task.
overlaps especially between aerobic vs anaerobic and stress
To evaluate EDA-only discrimination of stress vs rest, a
vs anaerobic.
parallel analysis pipeline was implemented with the same
Collectively, these results suggest that EDA alone
preprocessing and feature engineering methodology, with
supports coarse multi-state classification but is insufficient
modifications limited to window selection and class labeling.
for reliable fine-grained intensity classification without
For each subject in the stress dataset folder of the publicly
personalization or multimodal integration.
available wearable dataset [1], two labeled segments were
extracted from the same recording session: Rest segment
corresponding to the first 120 seconds of the recording (0-
120s), and the Stress segment extracted from a protocol-
defined window spanning 630-750 seconds of the recording.
Feature selection was performed using correlation
analysis followed by RFE using an LR base estimator. The
top ranked features selected by RFE were: Mean Tonic EDA,
SCR Interval Max, Kurtosis, Skewness, SCR Peaks per min,
Peak Amplitude, Freq Peak Amplitude and PSD Band power.
The same set of benchmark classifiers was trained and
evaluated with LOSO validation. Across models, the mean
accuracy ranged from 0.83 to 0.91, with corresponding F1
scores between 0.79 to 0.91. Gaussian NB achieved the
highest sensitivity to stress with a mean F1 score of 91%
(0.91 +/- 0.21) and recall of 97% (0.97 +/- 0.17). Logistic
Regression and Extra Trees achieved the highest mean
accuracy of 91% (0.91 +/- 0.19).
Fig. 6.1 Confusion Matrix for Linear Discriminant Analysis (LDA)
Performance variability across folds (std. dev. between model in LOSO validation (3-way classification)
0.19-0.30) reflects inter-subject differences in electrodermal
responsiveness rather than systematic model overfitting.
VII. AUTHOR CONTRIBUTIONS
Overall, these results indicate that physiologically [1] Rena Krishna : Conceptualization, data analysis, ML modeling,
interpretable EDA features are sufficient for subject- manuscript drafting
independent stress discrimination without requiring high- [2] Ramya Sankar : Technology review, methodological guidance,
manuscript review
capacity nonlinear models.
[3] Shadi Ghiasi : Scientific advising, domain experience, manuscript
B. Three-class (Stress-Aerobic-Anaerobic) EDA-only review
Classification Pipeline
VIII. REFERENCES
To extend the binary analyses, a three-class classification
[1] J. H. McArdle, F. I. Katch, V. L. Katch, “Exercise Physiology:
pipeline was implemented to evaluate whether EDA can Nutrition, Energy, and Human Performance”, 9th ed. Philadelphia,
discriminate among stress, aerobic, and anaerobic states. The PA, USA: Wolters Kluwer, 2019.
pipeline followed the same preprocessing and feature- [2] E. A. Richter and M. Hargreaves, “Exercise, GLUT4, and skeletal
muscle glucose uptake,” Physiological Reviews, vol. 93, no. 3, pp.
engineering framework as the main study, with the expanded
993–1017, Jul. 2013.
label set and analysis applied to the full recordings.
[3] A. C. Guyton and J. E. Hall, Textbook of Medical Physiology, 13th ed.
EDA recordings were loaded from three class-specific
Philadelphia, PA, USA: Elsevier, 2016.
folders within the wearable dataset, with each file
[4] F. Doyle, B. Kovatchev, “Artificial Pancreas Control Algorithms:
corresponding to a single subject session, under a single Challenges and Opportunities”, Diabetes Care, 2019
condition. Class labels were encoded as Stress=0, Aerobic=1, [5] B. Buckingham, “Exercise and Stress Impact on Glucose Control in
Anaerobic=2. Tonic, phasic, and frequency-domain features T1DM”, J. Diabetes Sci Technol, 2020
were computed within the feature extraction function using [6] S. Ghiasi, A. Greco, R. Barbieri, E. Scilingo, G. Valenza, V. G.
Macefield, and B. G. Wallin, “The discharge behaviour of single
standardized Butterworth filtering operations applied directly
sympathetic neurones supplying human sweat glands”, Journal of the
to each input segment. autonomic nervous system, vol. 61, no. 3, 1996
Two additional features were defined: SCR Burst [7] S. Ghiasi, A. Greco, R. Barbieri, E. Scilingo, G. Valenza, “Assessing
fraction, which quantifies the degree of temporal clustering Autonomic Function from Electrodermal Activity and Heart Rate

Variability During Cold-Pressor Test and Emotional Challenge”, periodograms, IEEE Transactions on Audio and Electroacoustics,
Scientific Reports, vol. 10, no. 1, 2020 15(2), 70–73. 1967
[8] D. Hernando, S. Roca, J. Sancho, A. Alesanco, R. Bailón, “Validation [23] Stržinar, Z., Sanchis, A., Ledezma, A., Sipele, O., Pregelj, B, Škrjanc,
of the Apple Watch for heart rate variability measurements during relax I., “Stress Detection Using Frequency Spectrum Analysis of Wrist-
and mental stress sensors”, 2018 Measured Electrodermal Activity”, 2023
[9] L. Zhu, P. C. Ng, Y. Yu, Y. Wang, P. Spachos, D. Hatzinakos, K. N. [24] Ibrahim, S., Nazir, S., Velastin, S., Feature Selection Using Correlation
Plataniotis, Feasibility study of Stress Detection with Machine Analysis and Principal Component Analysis for Accurate Breast
Learning through EDA from Wearable Devices, IEEE, 2022 Cancer Diagnosis, PMCID: PMC8625715, 2021
[10] Ishikawa, Y., Electrodermal activity and skin temperature [25] Chen, X.-w., Jeong, J. C., Enhanced recursive feature elimination,
characteristics related to stress and depression: A 4-week observational Sixth International Conference on Machine Learning and Applications,
study of office workers, 2025 IEEE, 2007
[11] A. Hongn, F. Bosch, L. Prado, M. P. Bonomini, “Wearable [26] Faust, O., Deep learning for healthcare applications based on
Physiological Signals under acute Stress and Exercise Conditions”, physiological signals: A review, Computer methods and programs in
Scientific Data, vol. 12, no. 1, 2025 biomedicine, 2018
[12] H. F. Posada-Quintero and K. H. Chon, “Innovations in electrodermal [27] Ke, G., Meng, Q., Finley, T., Wang, T., Chen, W., Ma, W., ... & Liu,
activity data collection and signal processing: A systematic review,” T. Y. (2017). Lightgbm: A highly efficient gradient boosting decision
Sensors, vol. 20, no. 2, p. 479, 2020 tree. Advances in Neural Information Processing Systems, 30.
[13] J. Birjandtalab, D. Cogan, M. B. Pouyan, and M. Nourani, “A non- [28] Pedregosa, F., Varoquaux, G., Gramfort, A., Michel, V., Thirion, B.,
eeg biosignals dataset for assessment and visualization of neurological Grisel, O., ... & Duchesnay, E., Scikit-learn: Machine learning in
status,” in 2016 IEEE International Workshop on Signal Processing Python. Journal of Machine Learning Research, 12(Oct), 2825-2830,
Systems (SiPS), pp. 110–114, IEEE, 2016 2011
[14] Kim, H., “Soft Wireless Bioelectronics and Differential Electrodermal [29] Bent, B., Investigating sources of inaccuracy in wearable optical heart
Activity for Home Sleep Monitoring”, 2021 rate sensors, NPJ Digital Medicine, 3, article 18, 2020
[15] A. Hongn, F. Bosch, L. E. Prado, J. M. Ferrandez, M. P. Bonomini, [30] Lundberg, S., Lee, S., A Unified Appraoch to Interpreting Model
“Wearable Device Dataset from Induced Stress and Structured Predictions, Neurips, 2017
Exercise Sessions”, version 1.0.1, PhysioNet RFID: SCR_007435, [31] Chen, T., & Guestrin, C. (2016, August). Xgboost: A scalable tree
2025 boosting system. In Proceedings of the 22nd acm sigkdd international
[16] A. Goldberger, L. Amaral, L. Glass, J. Hausdorff, P. C. Ivanov, R. conference on knowledge discovery and data mining (pp. 785-794).
Mark, H. E. Stanley, et al, “PhysioBank, PhysioToolkit, and [32] Raschka, S., Mirjalili, V., Python Machine Learning: Machine
PhysioNet: Components of a new research resource for complex Learning and Deep Learning with Python, scikit-learn, and
physiologic signals”, 2023, pp. e215–e220. RRID:SCR_007345 TensorFlow 2 (3rd ed.), 2019
[17] Harris GD. Exercise stress testing for primary care and sports medicine. [33] S. Boettger, C. Puta, V. K. Yeragani, L. Donath, H.-J. Mueller, H. H.
In: Evans CH, White RD, editors. 1st ed. New York (NY): Springer; Gabriel, and K.-J. Baer, “Heart rate variability, qt variability, and
2009. p. 45-54. doi: 10.1007/978-0-387-76597-6. electrodermal activity during exercise,” Med Sci Sports Exerc, vol. 42,
[18] A. Putta, Classifying Physical Stress from Relaxation Stage Using no. 3, pp. 443–8, 2010.
Electrodermal Activity Signal, unpublished, 2025 [34] S. Buckingham, K. Morrisey, A. Williams, L. Price, J. harrison, The
[19] S. Butterworth et al., “On the theory of filter amplifiers,” Wireless Physical Activity Wearables in the Police Force (PAW-Force) study:
Engineer, vol. 7, no. 6, pp. 536–541, 1930. acceptability and impact, Springer, 2020
[20] S. W. Smith, Digital Signal Processing: A Practical Guide for [35] P. Cho, J. Kim, B. Bent, J. Dunn, BIG IDEAs Lab Glycemic
Engineers and Scientists. Elsevier. Chapter 20 "Chebyshev Filters". Variability and Wearable Device Data, Physionet, version 1.1.2, 2023
2003 [36] N. Khan, N. Deshpande, P. Kadam, A review of AI-based health
[21] R. W. Schafer, What is a Savitzky-Golay filter?. IEEE Signal prediction using apple watch and fitbit data, Springer, 2025
Processing Magazine, 28(4), 111-117, 2011
[22] P. D. Welch, The use of fast Fourier transform for the estimation of
power spectra: A method based on time averaging over short, modified
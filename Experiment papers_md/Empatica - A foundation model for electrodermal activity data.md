| A foundation |     |     | model | for electrodermal |     |     |     | activity |
| ------------ | --- | --- | ----- | ----------------- | --- | --- | --- | -------- |
data
|     |     | Leonardo | Alchieri |     |     | Matteo | Garzon |     |
| --- | --- | -------- | -------- | --- | --- | ------ | ------ | --- |
Università della Svizzera Italiana (USI) Università della Svizzera Italiana (USI)
|     |      | Via     | la Santa 1  |     |     | Via          | la Santa    | 1   |
| --- | ---- | ------- | ----------- | --- | --- | ------------ | ----------- | --- |
|     | 6962 | Lugano, | Switzerland |     |     | 6962 Lugano, | Switzerland |     |
6202 beF 02  ]GL.sc[  1v87861.3062:viXra
leonardo.alchieri@usi.ch
|     |     | Lidia | Alecci |     | Francesco | Bombassei |     | De Bona |
| --- | --- | ----- | ------ | --- | --------- | --------- | --- | ------- |
Università della Svizzera Italiana (USI) Università della Svizzera Italiana (USI)
|     |      | Via     | la Santa 1  |     |     | Via          | la Santa    | 1      |
| --- | ---- | ------- | ----------- | --- | --- | ------------ | ----------- | ------ |
|     | 6962 | Lugano, | Switzerland |     |     | 6962 Lugano, | Switzerland |        |
|     |      | Martin  | Gjoreski    |     |     | Giovanni     | De          | Felice |
Università della Svizzera Italiana (USI) Università della Svizzera Italiana (USI)
|     |      | Via     | la Santa 1  |     |     | Via          | la Santa    | 1   |
| --- | ---- | ------- | ----------- | --- | --- | ------------ | ----------- | --- |
|     | 6962 | Lugano, | Switzerland |     |     | 6962 Lugano, | Switzerland |     |
Silvia Santini
|     |     |     | Università | della Svizzera           | Italiana | (USI) |     |     |
| --- | --- | --- | ---------- | ------------------------ | -------- | ----- | --- | --- |
|     |     |     |            | Via la Santa             | 1        |       |     |     |
|     |     |     |            | 6962 Lugano, Switzerland |          |       |     |     |
|     |     |     |            | March 19,                | 2026     |       |     |     |
Abstract
Foundationmodelshaverecentlyextendedbeyondnaturallanguageandvisiontotimeseries
domains,includingphysiologicalsignals. However,progressinelectrodermalactivity(EDA)
modeling is hindered by the absence of largescale, curated, and openly accessible datasets.
EDAreflectssympatheticnervoussystemactivityandiswidelyusedtoinfercognitiveload,
stress, and engagement. Yet very few wearable devices provide continuous, unobtrusive
sensing, and the only largescale archive to date is proprietary. To address this gap, we
compile EDAMAME, a collection of EDA traces from 24 public datasets, comprising more
than 25,000 hours from 634 users. Using this resource, we train UME, the first dedicated
foundation model for EDA. In eight out of ten scenarios, UME outperforms baselines and
matches generalist timeseries foundation models while using 20× fewer computational re-
sources. Our findings, however, also highlight the intrinsic challenges of EDA modeling,
motivating further research to unlock its full potential. All datasets, model weights, and
| code | are released |     | to support further | research. |     |     |     |     |
| ---- | ------------ | --- | ------------------ | --------- | --- | --- | --- | --- |
1 Introduction
Thankstotheirabilitytolearngeneralpatternsfrombroad,diversedataandtoadaptthemtoawiderange
of downstream tasks, foundation models have attracted attention beyond their traditional applications in
natural language processing and computer vision. In particular, generalist foundation models for time
series, like Mantis [35] or Chronos [8, 9], have been proposed recently. Trained on cross-domain dataset

A foundation model for electrodermal activity data
collections,thesemodelsachieveremarkableperformanceonadiverserangeofdownstreamtasks. Emerging
foundation models for physiological time series data – e.g., for photoplethysmogram (PPG) [1, 72, 81, 32,
62], electrocardiogram (ECG) [1, 66, 59], and electroencephalogram (EEG) data [84] – show compelling
performance, too. Yet their training remains constrained by the absence of largescale, curated, and open
datasetsforphysiologicalsignals. AshighlightedbyAbbaspourazadetal.[1]withrespecttotimeseriesdata
in the medical domain, “datasets are usually small in comparison to other domains, which is an obstacle for
developing neural network models for biosignals”.
This paucity of data is particularly acute for electrodermal activity (EDA) signals. EDA refers to changes
in the skins electrical conductance caused by variations in sweat gland activity, which is itself regulated by
the sympathetic branch of the autonomic nervous system. Alongside more commonly used physiological sig-
nals, EDA has numerous applications in personal informatics systems. Specifically, because EDA increases
with physiological arousal, it is commonly used to assess cognitive load [52, 79], stress [39, 73], and engage-
ment [36, 38, 19]. Yet EDA sensors are not (yet) commonplace on wearable devices and only few (such
as, e.g., the Empatica E4 wristband) feature the unobtrusive, continuous measurement modality necessary
to collect longitudinal traces of EDA in real-world settings. The only large-scale archive of EDA data is a
proprietary dataset collected using the Fitbit Sense 2 [65]. This lack of (open) data has, to date, hampered
the development of foundation models for EDA.
To cope with this challenge, we first constructed a large-scale archive of EDA data that integrates records
from 24 different publicly available datasets and a total of more than 25’000 hours of data of 634 different
users. We curated this collection of datasets, to which we refer to as EDAMAME (EDA Multi-dataset
Archive for Model training and Evaluation), to train a foundation model for EDA data. The model, called
UME(foUndationModelforElectrodermalactivitydata),hasbeentrainedonapproximately275millionof
60-second windows of EDA data and it is, to best of our knowledge, the first EDAspecific foundation model
reported in the literature. We evaluated UME on several downstream tasks and found that it surpasses
baseline models trained on both generic and EDA-specific handcrafted features in 8 out of 10 tests and
matches the performance of generalist time series foundation models, while requiring at least 20× less
computational resources. Our results, however, also highlight the intrinsic difficulty of working with EDA
signals: balanced accuracy scores rarely exceed 0.7 and exhibit substantial variability. Further research is
thereforeneededtofullyharnessthepotentialofEDAforbothunimodalandmultimodalubiquitoussensing.
To enable further research, we make all artifacts produced as part of this work publicly available. The
EDAMAME dataset collection can be obtained upon signing a single data sharing agreement, in accordance
with the provisions of the individual datasets. UME’s weights and the entire codebase used to produce the
model is available for download: [Link to the repository anonymized]1.
2 Background & related work
In this section, we provide an overview of the background and relevant related work. We discuss the
relevant background associated with wearable devices and EDA data. Then, we describe existing research
on foundation models for physiological data, with a focus on signals collected from wearable devices. We
also present work on the use of self-supervised learning applied to EDA data, since self-supervised learning
is one of the main building blocks for training foundation models.
Background Foundationmodelsrequirelargescaledatasetstobetrained[14]. Researchershaveobtained
state-of-the-art results in the NLP domain thanks in part to the availability of large scale textual corpora,
e.g., [10, 17]. Researchers create textual corpora by, for example, crawling websites and gathering all avail-
able text, e.g., as done by the Common Crawl dataset2. On the other hand, collecting physiological signals
requirestheuseofspecializedequipmentaswellassignificanthumanandtimeresources[60,83]. Researchers
have explored foundation models for physiological data through the use of large scale clinical corpora [58].
Only recent work, e.g., [1], explores the use of foundation models trained from real-world wearable physio-
logicalsignals. Thisisduetosignificantlyhigheroperationaldifficultiesingatheringhigh-qualitydatawhen
collectingwearabledata,comparedtoclinicalstudies[13]. Additionally,EDA,evenifusedinthehealthcare
domain to detect seizures [21], is not as commonly collected in clinical settings as PPG or ECG [25, 74].
1The link to the repository will be made available upon completion of the reviewing process
2https://commoncrawl.org
2

|     |     |     | A   | foundation | model for | electrodermal | activity | data |     |
| --- | --- | --- | --- | ---------- | --------- | ------------- | -------- | ---- | --- |
Table 1: Overview of selected foundation models for physiological data and the datasets used to train them.
|     | Foundation | model |     |     |     | train | data |     |     |
| --- | ---------- | ----- | --- | --- | --- | ----- | ---- | --- | --- |
Ref. Signal(s) Params. Avail. Dataset(s) Data type Hours (k) Users Avail.
Clinical data
|     |     |     |     |     | VitalDB [57] | Clinical | ∼ 17 | ∼ 6k | 3   |
| --- | --- | --- | --- | --- | ------------ | -------- | ---- | ---- | --- |
[72] PPG ∼ 30 - 150 M Open source MIMIC-III [50] Clinical ∼ 20 ∼ 6k 3
|      |     |       |      |      |               |          | ∼   | ∼    | 3   |
| ---- | --- | ----- | ---- | ---- | ------------- | -------- | --- | ---- | --- |
|      |     |       |      |      | MESA [94]     | Clinical | 20  | 2k   |     |
|      |     | ∼     |      |      |               |          | ∼   | ∼    | 3   |
| [32] | PPG | 1-8 M | Code | only | [32]          | Clinical | 300 | 29k  |     |
|      |     |       |      |      |               |          | ∼   | ∼    | 3   |
|      |     |       |      |      | MIMIC IV [51] | Clinical | 140 | 160k |     |
|      |     | ∼     |      |      |               |          | ∼   |      | 3   |
[66] ECG 300 M Open source PhysioNet2021 [78] Clinical 14 N/A
|      |     |     |             |     |              |          | ∼     | ∼    | 3   |
| ---- | --- | --- | ----------- | --- | ------------ | -------- | ----- | ---- | --- |
|      |     |     |             |     | UHN-ECG [66] | Clinical | 100   | 180k |     |
|      |     | ∼   |             |     |              |          | ∼     | ∼    | 3   |
| [59] | ECG | 30M | Open source |     | HEEDB [54]   | Clinical | 1,000 | 2M   |     |
[84] EEG not stated Open source curated collection Clinical ∼ 350 ∼ 9 73
| Wearable | data        |        |             |     |            |          |        |      |     |
| -------- | ----------- | ------ | ----------- | --- | ---------- | -------- | ------ | ---- | --- |
|          |             | ∼      |             |     |            |          | ∼      | ∼    | 7   |
|          | PPG         | 3M     | Private     |     |            |          | 300    | 141k |     |
| [1]      |             | ∼      |             |     | AHMS [88]  | Wearable | ∼      | ∼    | 7   |
|          | ECG         | 3M     | Private     |     |            |          | 30     | 106k |     |
|          |             | ∼      |             |     |            |          | ∼      | ∼    | 7   |
| [68]     | multi-modal | 1-100M | Private     |     | [68]       | Wearable | 40,000 | 165k |     |
|          |             | ∼      |             |     |            |          | ∼      | ∼    | 7   |
| [81]     | PPG         | 30M    | Open source |     | MOODS [69] | Wearable | 40     | 120  |     |
Other
|     |     | ∼   |     |     |     |     | ∼   |     | 73  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
[62] multi-modal 140M Open source curated collection Mixed 15 N/A
Ours
| Ours | EDA | ∼ 1M | Open source |     | EDAMAME | Wearable | ∼ 25 | ∼ 630 | 3   |
| ---- | --- | ---- | ----------- | --- | ------- | -------- | ---- | ----- | --- |
Foundation models for physiological data In Table 1 we provide an overview of a selected set of
existing foundation models for physiological data, their size, their availability and information about the
data used to train them. Current research focuses on PPG, ECG, or multi-modal approaches. A majority
of the selected foundation models relies on clinical data, given its abundance. To the best of our knowledge,
Saha et al. [81]’s work is the only one using exclusively wearable physiological data to train an open source
| foundation | model. |     |     |     |     |     |     |     |     |
| ---------- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
Researchers have explored foundation models for physiological data using both clinical and wearable data.
Abbaspourazad et al. [1] were the first to use a large scale, private, dataset of wearable data to train
foundation models on PPG and ECG data. Their results show that features from foundation models can
be used to perform multiple downstream tasks, with performance on par to existing approaches. Following
these results, other researchers, e.g., [81, 72, 32, 66, 59], have trained foundation models for either PPG or
ECG data. However, most of the existing approaches rely on clinical PPG and ECG signals, with limited
work on real-world physiological data collected from wearable devices [81], and, especially, no work on EDA
data.
Multi-modal approaches have also recently been proposed. Narayanswamy et al. [68] trained a family of
multimodal foundation models on data aggregated over 1 minute. They compute aggregated features from
PPG (e.g., mean heart rate), EDA (e.g., mean EDA values), and other physiological and behavioral signals.
They find that their foundation model significantly outperforms (up to 50% improvement) over baseline
methods. However, their approach relies on proprietary data and the authors released neither the code nor
the weights for their model. Using publicly available data, Luo et al. [62] trained a multi-modal foundation
modelforphysiologicaldata,e.g.,PPG,ECG,EDA,fromacuratedcollectionofdatasetswithabout15’000
hoursofdata. Intheirexperimentalsetup,theyshowpromisingzero-shotdownstreamperformancefortheir
foundation model. However, the authors’ focus was not on EDA data, which means that their collection
of datasets only contained a limited amount of EDA, compared to other physiological signals. Overall, a
curated EDA dataset collection has not yet been made available to the wider research community.
Self-supervised learning for EDA data Researchershavealsoexploredtheuseofself-supervisedlearn-
ingonwearabledata,includingEDA.Dissanayakeetal.[33]trainedaself-supervisedlearningmodel,through
contrastive learning, for emotion estimation using PPG, EDA and skin temperature. Saeed et al. [80] sim-
ilarly used a multi-modal self-supervised approach in a federated learning settings. Recently, Matton et al.
3Individual
|     | datasets | available, but | not the curated | collection. |     |     |     |     |     |
| --- | -------- | -------------- | --------------- | ----------- | --- | --- | --- | --- | --- |
3

A foundation model for electrodermal activity data
[64] trained a self-supervised learning model on EDA data to perform stress classification. They used con-
trastivelearninganddataaugmentationtechniquestoachievestate-of-the-artperformanceonin-distribution
downstream tasks.
Overall, existing work suggests that foundation models for physiological data can be trained and used on a
diverse set of downstream tasks when using PPG, ECG or multi-modal approaches. However, a large part
of publicly available physiological foundation models rely on clinical data, and there is limited evidence that
featuresfromthesemodelscanbeusedwithdatafromwearabledevicesandreal-lifesettings. Recentworkon
multi-modal[62]andPPG [81]foundationmodelsshowsthat, evenwithout large-scaleproprietarydatasets,
researchers are able to train open source foundation models. However, recent work does not provide a
readily available collection of datasets for researchers to build upon their results, hindering the development
of wearable foundation models. Given promising work on self-supervised learning for EDA data [64], we
create a collection of datasets, EDAMAME, which we make available to the research community and, with
it,wetrainanopensourcefoundationmodelforEDAdata,UME,whosecodeandweightswemakeavailable
to the research community.
3 EDAMAME: a collection of electrodermal activity datasets
In this section, we describe how we address the availability of large scale datasets containing wearable EDA
data through EDAMAME (EDA Multi-dataset Archive for Model training and Evaluation). EDAMAME
is a collection of existing, smaller scale, datasets prepared and pre-processed in a unified manner. The goal
of EDAMAME is to enable researchers to train foundation models for wearable EDA data.
3.1 Description of the collection of datasets
Our goal is to create a large-scale and diverse corpus to address the scarcity of EDA-specific collections. To
this end, we first identify a set of scenarios that are relevant for EDA data through relevant literature [47].
The scenarios are: sleep monitoring, stress/emotion induction, engagement, real-world stress, workplace
analysis, daily living. Then, we select and search datasets from the literature using the following criteria:
1. datasets have to contain raw EDA data from wearable devices;
2. theindividual datasetshaveto beeither opensource oravailabletoresearchersuponsigning a data
sharing agreement;
3. datasets have to contain data collected during tasks or moments that influence EDA signals;
4. the collection has to contain datasets collected using different protocols. e.g., lab environment or
in-the-wild collection;
5. the collection needs to contain at least one dataset from each one of the six scenarios defined;
6. in order to limit the search size, we also add a saturation criterion: once we reach the threshold of
100 users and 1000 hours for one of the six scenarios, we stop searching for additional data;
7. the total size of EDAMAME has to be more than 15’000 hours and more than 100 users, which is
a size similar to that of datasets used to train existing open source foundation models for wearable
data [81, 62].
In order to satisfy the first criterion, we collect data only from datasets using Empatica E4 devices4. We
choose to use only Empatica E4 data since it is one of the few research-grade wearable devices that allow to
continuously collect wearable EDA.
We search datasets through open source databases containing physiological data, specifically PhysioNet5,
Zotero6, Kaggle7. We also search for dataset information using databases of scientific articles, e.g., Google
Scholar8, ACM Digital Library9. Finally, we also search through the online databases of scientific journals
4https://www.empatica.com/research/e4/
5https://physionet.org/
6https://zenodo.org/
7https://www.kaggle.com
8https://scholar.google.com
9https://dl.acm.org
4

|     |     |     |     | A   | foundation | model |     | for electrodermal |     | activity data |
| --- | --- | --- | --- | --- | ---------- | ----- | --- | ----------------- | --- | ------------- |
Table 2: Summary of the datasets included in the training split. The collection spans diverse physiological
| scenarios | and environments. |     |          |     |       |       |            |            |     |             |
| --------- | ----------------- | --- | -------- | --- | ----- | ----- | ---------- | ---------- | --- | ----------- |
| Dataset   | Name              |     | Duration |     | (h) # | Users | Scenario   |            |     | Environment |
| APSync    | [38]              |     |          |     | 168   | 27    | Real-world | Stress     |     | Wild        |
| BIG IDEAS | [11]              |     |          |     | 2607  | 16    | Daily      | Living     |     | Wild        |
| BiHeartS  | [3]               |     |          |     | 2911  | 11    | Sleep      | Monitoring |     | Wild        |
| DREAMT    | [92]              |     |          |     | 882   | 100   | Daily      | Living     |     | Wild        |
Dynamics in the workplace [61] 1813 42 Workplace Analysis Wild
| EmpaticaE4Stress |         | [20] |     |        | 5    | 29  | Stress/Emotion |            | Induction | Lab  |
| ---------------- | ------- | ---- | --- | ------ | ---- | --- | -------------- | ---------- | --------- | ---- |
| EPM-E4           | [37]    |      |     |        | 22   | 47  | Engagement     |            |           | Wild |
| HeartS           | [2]     |      |     |        | 886  |     | 5 Sleep        | Monitoring |           | Wild |
| HHISS            | [42]    |      |     |        | 3166 | 46  | Real-world     | Stress     |           | Wild |
| LAUREATE         | [55]    |      |     |        | 1406 | 46  | Engagement     |            |           | Wild |
| M2Sleep          | [40]    |      |     |        | 8403 | 16  | Sleep          | Monitoring |           | Wild |
| MEFAR            | [28]    |      |     |        | 27   | 23  | Stress/Emotion |            | Induction | Lab  |
| Nurses’          | Stress  | [48] |     |        | 800  | 18  | Workplace      | Analysis   |           | Wild |
| PPG-Dalia        | [77]    |      |     |        | 38   | 15  | Daily          | Living     |           | Wild |
| SEED             | [29]    |      |     |        | 340  | 31  | Engagement     |            |           | Wild |
| SEED-II-Lab      | [29]    |      |     |        | 29   | 25  | Engagement     |            |           | Lab  |
| SEED-II-Wild     |         | [29] |     |        | 156  |     | 6 Engagement   |            |           | Wild |
| Stress           | Predict | [49] |     |        | 32   | 35  | Stress/Emotion |            | Induction | Lab  |
| ToadStool        | [85]    |      |     |        | 10   | 10  | Stress/Emotion |            | Induction | Lab  |
| USILaughs        | [30]    |      |     |        | 1.5  | 30  | Stress/Emotion |            | Induction | Lab  |
| WEEE             | [41]    |      |     |        | 17   | 17  | Daily          | Living     |           | Lab  |
| WESAD            | [82]    |      |     |        | 29   | 15  | Stress/Emotion |            | Induction | Lab  |
| WESD             | [75]    |      |     |        | 123  | 10  | Real-world     | Stress     |           | Wild |
| Workplace        | [31]    |      |     |        | 830  | 14  | Workplace      | Analysis   |           | Wild |
| Total            |         |      |     | 24’735 |      | 634 |                |            |           |      |
|                  |         |      |     |        |      |     |                | Data10,    | IMWUT11.  |      |
that publish datasets containing physiological data, e.g., Nature Scientific We identify a
potential37datasets. Throughtheaforementionedcriteria, weselectatotalof 24datasetsforEDAMAME.
We report in Table 2 an overview of the 24 datasets. In total, EDAMAME contains approximately 25’000
hours of EDA data from 634 users. The size of EDAMAME is in line, as outlined by our seventh selection
criterion, withcollectionsof datasetsusedbySahaetal. [81],Luoetal.[62]totrainopensourcefoundation
| models for | wearable | physiological | data. |     |     |     |     |     |     |     |
| ---------- | -------- | ------------- | ----- | --- | --- | --- | --- | --- | --- | --- |
The EDA signal in all 24 datasets is sampled at 4 Hz, since this is the default sampling rate for EDA from
the Empatica E412. All timestamps are converted to UTC time. Whenever timestamps are missing, we
| assign unix-time |             | 0 to the start | of a timeseries |     | of EDA | data. |     |     |     |     |
| ---------------- | ----------- | -------------- | --------------- | --- | ------ | ----- | --- | --- | --- | --- |
| 3.2 Data         | variability | in             | EDAMAME         |     |        |       |     |     |     |     |
In this section, we show the data variability in the EDAMAME collection of datasets. We highlight the
diversityofEDAdatainEDAMAMEtohighlightitsfeasibilityintrainingfoundationmodelsforEDAdata.
Inparticular,wediscusstheEDAdatadistributionandthedistributionofusersanddataperuseracrossthe
datasets. Figure1showssixexampleEDAsignalsfromdifferentdatasets,representingsixdistinctscenarios:
sleep monitoring, stress/emotion induction, engagement, real-world stress, workplace analysis, daily living.
Data distribution Figure 2 shows the distribution of raw EDA values across the 24 datasets in
EDAMAME. We highlight how data distribution is similar across datasets that are collected in similar
scenarios. We highlight that higher EDA values are associated with stronger ANS arousal activation [15].
For example, datasets in the Stress/Emotion Induction scenario have longer tails, in their distribution, com-
pared to others. On the other hand, datasets in the Real-world Stress scenario have lower tails and more
10https://www.nature.com/sdata/
11https://dl.acm.org/journal/imwut
12https://www.empatica.com/blog/decoding-wearable-sensor-signals-what-to-expect-from-your-e4-data
5

|     |     |     |     |              |     | A   | foundation | model | for | electrodermal     |     | activity data |
| --- | --- | --- | --- | ------------ | --- | --- | ---------- | ----- | --- | ----------------- | --- | ------------- |
|     |     |     |     | Daily Living |     |     | Engagement |       |     | Real-world Stress |     |               |
|     |     |     |     | (WEEE)       |     |     | (SEED)     |       |     | (APSYNC)          |     |               |
0.8
0.86
|     |     | 0.84 |     |     |     | 0.18 |     |     |     | 0.7 |     |     |
| --- | --- | ---- | --- | --- | --- | ---- | --- | --- | --- | --- | --- | --- |
0.6
|     |     | )S( ADE 0.82 |     |     |     | )S( ADE 0.16 |     |     | )S( ADE | 0.5 |     |     |
| --- | --- | ------------ | --- | --- | --- | ------------ | --- | --- | ------- | --- | --- | --- |
0.80
|     |     |      |     |     |     | 0.14 |     |     |     | 0.4 |     |     |
| --- | --- | ---- | --- | --- | --- | ---- | --- | --- | --- | --- | --- | --- |
|     |     | 0.78 |     |     |     |      |     |     |     | 0.3 |     |     |
0.12
|     |     | 0.76 |     |     |     |      |     |     |     | 0.2 |     |     |
| --- | --- | ---- | --- | --- | --- | ---- | --- | --- | --- | --- | --- | --- |
|     |     | 0.74 |     |     |     | 0.10 |     |     |     | 0.1 |     |     |
|     |     |      |     |     |     | 0.08 |     |     |     | 0.0 |     |     |
0.72
|     |     | 0    | 10               | 20 Time (s) 30 | 40 50 |      | 0 10 20 Time (s)         | 30 40 50 |       | 0 10 20 Time (s)   | 30 40 50 |     |
| --- | --- | ---- | ---------------- | -------------- | ----- | ---- | ------------------------ | -------- | ----- | ------------------ | -------- | --- |
|     |     |      | Sleep Monitoring |                |       |      | Stress/Emotion Induction |          |       | Workplace Analysis |          |     |
|     |     |      |                  | (BiHeartS)     |       |      | (CLUES)                  |          |       | (Workplaces)       |          |     |
|     |     | 1.51 |                  |                |       | 0.98 |                          |          | 10.00 |                    |          |     |
1.50
|     |     |              |     |     |     | 0.96    |     |     | 9.75    |     |     |     |
| --- | --- | ------------ | --- | --- | --- | ------- | --- | --- | ------- | --- | --- | --- |
|     |     | )S( ADE 1.49 |     |     |     | )S( ADE |     |     | )S( ADE |     |     |     |
|     |     |              |     |     |     | 0.94    |     |     | 9.50    |     |     |     |
|     |     | 1.48         |     |     |     | 0.92    |     |     | 9.25    |     |     |     |
|     |     | 1.47         |     |     |     | 0.90    |     |     | 9.00    |     |     |     |
|     |     | 1.46         |     |     |     |         |     |     | 8.75    |     |     |     |
0.88
|     |     | 1.45 |     |     |     |     |     |     | 8.50 |     |     |     |
| --- | --- | ---- | --- | --- | --- | --- | --- | --- | ---- | --- | --- | --- |
0.86
|     |     | 0   | 10  | 20 30    | 40 50 |     | 0 10 20  | 30 40 50 |     | 0 10 20  | 30 40 50 |     |
| --- | --- | --- | --- | -------- | ----- | --- | -------- | -------- | --- | -------- | -------- | --- |
|     |     |     |     | Time (s) |       |     | Time (s) |          |     | Time (s) |          |     |
Figure 1: Example of six EDA signals (randomly drawn). Each signal is from a different dataset, each for
| one of the | six | scenarios. |     |     |     |     |     |     |     |     |     |     |
| ---------- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
EDA values close to 0 µS. These two distinct patterns highlight the challenges of real-world EDA data: a
lowerdistributionofEDAvaluesintheReal-world Stress scenariosuggeststhatduringdailylifelessarousal-
associatedmomentsarepresent. Overall,EDAMAMEcontainsdiversedata,acrossbothscenariosandEDA
values. This diversity is important when training foundation models, since it exposes the model to a wide
| range of | EDA | data. |     |     |     |     |     |     |     |     |     |     |
| -------- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Number of users and data per user Figure 3 shows the number of users compared to the data density
peruser,foreachdatasetinEDAMAME.Theplotshowsthestructuraltopologyofthecollectionofdatasets.
Specifically, the collection contains two types of datasets: datasets that contain less users but more data
per user (longitudinal depth); and datasets that contain more users, but less data per user (high population
diversity). The first set of datasets in which multiple days of data for each user are present contains more
intra-personal variability information, i.e., how people’s data changes over time, compared to the second set.
Thesecondset,ontheotherhand,containsmoreinter-personalvariabilityinformation,i.e.,howdatadiffers
| between | different | participants, |     | compared |     | to the | first one. |     |     |     |     |     |
| ------- | --------- | ------------- | --- | -------- | --- | ------ | ---------- | --- | --- | --- | --- | --- |
EDAMAMEcontainsdatafromadiverserangeofscenariosandusers. Thecollectionalsobalancesdatasets
with longitudinal depth and datasets with high population diversity. This diversity and variability is in line
| with recent | literature |      | on foundation |            | model | train | data  | [23, 18]. |      |     |     |     |
| ----------- | ---------- | ---- | ------------- | ---------- | ----- | ----- | ----- | --------- | ---- | --- | --- | --- |
| 4 UME:      |            | open | source        | foundation |       |       | model | for EDA   | data |     |     |     |
In this section, we describe UME (A foUndation Model for Electrodermal activity data), the first open
source foundation model trained on wearable EDA data. In particular, we explain the data pre-processing,
the training criteria, the model architecture and additional information about training the model. With
UME, our objective is to obtain a model whose internal representations encode key characteristics of the
input EDA signal, such that these representations can be extracted and used as substitutes for domain-
informed features in downstream tasks. To achieve this objective, as common for foundation models for
physiological data, e.g., [1, 72, 81], we rely on self-supervised learning with a contrastive learning objective.
To train UME we use a subset of the EDAMAME collection of datasets, consisting of around 19’000 hours
of EDA data and approximately 400 users. We open source the code and the weights for the model, and the
EDAMAME collection of datasets is available to researchers (see section 8 for additional details). We show
| in Figure | 4 an           | overview | of  | the pipeline |             | used | to train and | evaluate | UME. |     |     |     |
| --------- | -------------- | -------- | --- | ------------ | ----------- | ---- | ------------ | -------- | ---- | --- | --- | --- |
| 4.1 Data  | pre-processing |          |     | and          | preparation |      |              |          |      |     |     |     |
Data split We divide EDAMAME into two parts: a train and a downstream evaluation parts. For
simplicity, we call the first EDAMAME-train and the second EDAMAME-test. We use EDAMAME-train
to train our foundation model for wearable EDA data, while EDAMAME-test to perform evaluation on
6

|     |                |     |           |     | A   | foundation             | model          | for    | electrodermal |                        | activity data       |
| --- | -------------- | --- | --------- | --- | --- | ---------------------- | -------------- | ------ | ------------- | ---------------------- | ------------------- |
|     | Datasets (A-H) |     |           |     |     | Datasets (H-T)         |                |        |               | Datasets (T-W)         |                     |
|     |                |     | APSYNC    |     |     |                        |                | HeartS |               | Stress Predict Dataset |                     |
|     |                |     | BIG IDEAS |     |     |                        | LAUREATE       |        |               |                        | ToadStool           |
|     |                |     | BiHeartS  |     |     |                        | M2Sleep        |        |               |                        | USILaughs           |
|     |                |     | CLUES     |     |     |                        | MEFAR          |        |               |                        | WEEE                |
|     |                |     | Dreamt    |     |     | Nurses' Stress Dataset |                |        |               |                        | WESAD               |
|     |                |     | Dynamics  |     |     |                        | PPG_FieldStudy |        |               |                        | WESD                |
|     |                |     | EPM       |     |     |                        |                | SEED   |               |                        | Workplaces          |
|     |                |     |           |     |     |                        |                | 0.00   | 0.25          | 0.50 0.75 1.00         | 1.25 1.50 1.75 2.00 |
EDA Value (S)
|           |               | EmpaticaE4Stress |                    |      |           |               | SEED-II-Lab  |           |                   | Scenarios |                          |
| --------- | ------------- | ---------------- | ------------------ | ---- | --------- | ------------- | ------------ | --------- | ----------------- | --------- | ------------------------ |
|           |               |                  |                    |      |           |               |              |           | Daily Living      |           | Sleep Monitoring         |
|           |               |                  |                    |      |           |               |              |           | Engagement        |           | Stress/Emotion Induction |
|           |               |                  | HHISS              |      |           |               | SEED-II-Wild |           | Real-world Stress |           | Workplace Analysis       |
| 0.00 0.25 | 0.50 0.75     | 1.00 1.25        | 1.50 1.75 2.000.00 | 0.25 | 0.50 0.75 | 1.00          | 1.25 1.50    | 1.75 2.00 |                   |           |                          |
|           | EDA Value (S) |                  |                    |      |           | EDA Value (S) |              |           |                   |           |                          |
Figure 2: Ridgeline plot with distribution of EDA values from each dataset. The colors represent the six
scenarios each dataset was collected in. The plot has been truncated, for visualization’s sake, in the range
| 0−2.5 |     |     |     | 0−40 |     |     |     |     |     |     |     |
| ----- | --- | --- | --- | ---- | --- | --- | --- | --- | --- | --- | --- |
µS. The original range was µS (the E4’s max theoretical value is 100 µS).
Scenarios
Daily Living
Engagement
Real-world Stress
|     |     |     | )sruoh( resU rep noitaruD egarevA |     |     |     |     |     | Sleep Monitoring         |     |     |
| --- | --- | --- | --------------------------------- | --- | --- | --- | --- | --- | ------------------------ | --- | --- |
|     |     |     | 102                               |     |     |     |     |     | Stress/Emotion Induction |     |     |
Workplace Analysis
|     |     |     | 101 |     |     |     |     |     | Total Dataset Size |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------------ | --- | --- |
10h
100h
500h
1000h
100
|     |     |     | 1   | 2   | 5   | 10  | 20  | 50 70 |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----- | --- | --- | --- |
Number of Users
Figure 3: Number of users and data per user across the EDAMAME collection of datasets. Marker size is
| proportional | to the | size | of the dataset | (in | terms | of hours | of EDA | data). |     |     |     |
| ------------ | ------ | ---- | -------------- | --- | ----- | -------- | ------ | ------ | --- | --- | --- |
a set of downstream classification tasks. We select 17 datasets for EDAMAME-train and 7 datasets for
EDAMAME-test. We perform this split to allow models to be tested on data never seen during training,
containing new users, locations, and protocols as well. We select the datasets in the downstream task in
order to have a diverse set of labels relevant for EDA data. We report in Table 3 the binary task from each
| dataset in | the downstream |     | evaluation | part. |     |     |     |     |     |     |     |
| ---------- | -------------- | --- | ---------- | ----- | --- | --- | --- | --- | --- | --- | --- |
Pre-processing We pre-process the data from both EDAMAME-train and EDAMAME-test parts follow-
ingrelatedworkonEDAdata[4,30,39,46]. First, weapplyaButterworthlow-passfilter(cutoff0.4Hz)to
removehigh-frequencynoise. Then,wedecomposetheEDAsignalsintophasicandtoniccomponents,using
the cvxEDA method from Greco et al. [45]. This is a common procedure applied when working with EDA
data. The phasic component is associated with short-term changes, e.g., momentary stress, while the tonic
component with longer term variations [15]. To train the UME foundation model, we use both the phasic
and tonic components, as well as the non-decomposed EDA signal. Using all three signals, i.e., phasic, tonic
7

|     |     |     | A foundation | model for | electrodermal | activity data |
| --- | --- | --- | ------------ | --------- | ------------- | ------------- |
3-Channel EDA Input
Training (Contrastive Learning)
Original EDA
Low-pass filter
|                | (0.4 Hz cutoff) |                  |     | Augmentation 1 | EfficientNet |          |
| -------------- | --------------- | ---------------- | --- | -------------- | ------------ | -------- |
| Raw EDA Signal |                 | Phasic Component |     |                |              | InfoNCE  |
(60s window @ 4 Hz)
|     |     |     |     |     | Shared weights | Loss |
| --- | --- | --- | --- | --- | -------------- | ---- |
Maximize
cvxEDA
Similarity
|     | Decomposition | Tonic Component |     |                             |              |     |
| --- | ------------- | --------------- | --- | --------------------------- | ------------ | --- |
|     |               |                 |     | Augmentation 2              | EfficientNet |     |
|     | EfficientNet  |                 |     | Evaluation (Linear Probing) |              |     |
Stacked MBConv1D Blocks
|        |     | D1vnoC gnilooP noitcejorP |     |              |                     |     |
| ------ | --- | ------------------------- | --- | ------------ | ------------------- | --- |
| D1vnoC |     | raeniL                    |     | EfficientNet | Logistic Regression |     |
conv. operations
e.g., Stress / Relax
x L
|     |     |     |     | = trainable parameters | = frozen parameters |     |
| --- | --- | --- | --- | ---------------------- | ------------------- | --- |
Figure 4: Overview of the train and downstream evaluation process we used for the UME foundation model.
For reference, we report a sketch of the EfficientNet architecture, which we use as backbone for UME.
andoriginalEDAsignal,isacommonprocedureinclassification-basedtasksusingEDAdata,sinceitallows
| models to | learn both short | and long-term | effects in the | data [4, 5]. |     |     |
| --------- | ---------------- | ------------- | -------------- | ------------ | --- | --- |
Datasegmentation Afterpre-processingthedata,wesegmenttheEDAsignalsintofixed-lengthwindows
of 60 seconds. We use the same window length as Matton et al. [64] and Schmidt et al. [82], who highlight
how this length allows to capture both short and long-term changes in the EDA data. To train UME, on
EDAMAME-trainweselectmaximumoverlappingwindows,i.e.,withanoverlapstepof0.25s(thesampling
rate). We implement this approach as done by Matton et al. [64], on self-supervised learning for EDA data,
and Ansari et al. [8], Goswami et al. [43], Feofanov et al. [35], on generalist time series foundation models
for other physiological signals. With this approach, we obtain a train set consisting of approximately 275
| million windows | of EDA | data. |     |     |     |     |
| --------------- | ------ | ----- | --- | --- | --- | --- |
We also apply the same 60-second segmentation on the data used for evaluation, i.e., EDAMAME-test. For
evaluation, we assign to each window a binary label, corresponding to the associated task: we refer to
Table 3 for an overview of the binary downstream tasks used. Whenever a dataset contains EDA collected
simultaneously from both sides of the body, for evaluation we use only the data from the body side most
associated with the task, following guidelines by Alchieri et al. [4], e.g., right-side EDA signals for cognitive
load classification. On EDAMAME-test, we use non-overlapping windows, since the literature shows how
testing on either overlapping or non-overlapping windows leads to similar results [26, 87].
Discussion on rescaling the data We do not apply any normalization or standardization, e.g., min-
max normalization, on the prepared windows of EDA data. Researchers working with EDA data collected
in lab-controlled environments apply per-user min-max normalization to reduce inter-personal variability
and improve classification performance significantly, e.g., [67, 82, 7]. However, EDA data is affected by both
inter-personalvariability,whichmin-maxnormalizationaddresses,andintra-personalvariability,i.e.,auser’s
datachangesovertime. Afixcalibration,liketheoneappliedbymin-maxnormalization,isrenderedinvalid
over time if a user’s signal morphology changes [91, 12]. Moreover, “cold-start” approaches, i.e., a machine
learning model is applied directly on a new user, are the preferred approach for wearable physiological
data [93]. Normalization approaches cannot be implemented directly in “cold-start” scenarios.
| 4.2 Model | training | task & architecture |     |     |     |     |
| --------- | -------- | ------------------- | --- | --- | --- | --- |
Training objective WeadoptcontrastivelearningtotrainUME.Contrastivelearningisusedbymultiple
researchers to train foundation models for wearable physiological data, e.g., [1, 72]. This approach has also
beenusedforgeneralisttimeseriesfoundationmodelsspecializedinclassificationtasks,e.g.,[35]. Contrastive
learningisaself-supervisedlearningmethodthatconsistsintraininganencoder-onlymodeltolearnalatent
embedding space where representations of similar data pairs — typically created via augmentations of the
8

|     |     |           |        |            | A foundation    |            | model          | for     | electrodermal | activity data |
| --- | --- | --------- | ------ | ---------- | --------------- | ---------- | -------------- | ------- | ------------- | ------------- |
|     |     | Table     | 3:     | Summary    | of Datasets     |            | and Associated | Binary  | Tasks         |               |
|     |     | Dataset   |        | Binary     | Tasks           |            |                |         |               |               |
|     |     | APSync    |        | Low/High   |                 | Engagement |                |         |               |               |
|     |     | HeartS    |        | Sleep/Wake |                 |            |                |         |               |               |
|     |     | USILaughs |        | Cog.       | Load/Relaxation |            |                |         |               |               |
|     |     | WESAD     |        | High/Low   |                 | Arousal,   | High/Low       | Valence | (self-report) |               |
|     |     | Nurses’   | Stress | Low/High   |                 | Stress     |                |         |               |               |
|     |     | DREAMT    |        | Sleep/Wake |                 |            |                |         |               |               |
|     |     | HHISS     |        | Low/High   |                 | Stress     |                |         |               |               |
same signal — are attracted to each other, while representations of dissimilar pairs are repelled. The latent
embeddingsoftencontaininformationwhichallowsthemtobeusedeffectivelyindownstreamtasks[56]. We
also experiment with an additional self-supervised learning method: masked reconstruction. This method
consists in training an encoder-decoder to reconstruct the whole signal from a masked version of it, i.e., a
signalwhichismissingsomeparts. WereportinAppendixBdetailsaboutthisadditionalexperimentwhich,
| however, failed | to learn | useful | representations |     | of  | our EDA | data. |     |     |     |
| --------------- | -------- | ------ | --------------- | --- | --- | ------- | ----- | --- | --- | --- |
Model architecture We choose the architecture for our foundation model from similar work in the lit-
erature [1, 68, 72, 35]. Our choice reflects the decision to implement a generalist time series foundation
model on EDA data. This choice is in line with research on the first PPG and ECG-specific foundation
models [1, 68]: our objective is to showcase how features computed from EDA-specific foundation models
perform, as well to provide weights and code to the research community. Each physiological signal, from
PPG to ECG and EDA, has morphological elements specific to them. It is possible to define architectures
forfoundationmodelsthatadapttothesemorphologicalelements,asrecentworkfromSahaetal.[81]show.
| However, | this implementation |     | goes | beyond | the | scope of | the current | work. |     |     |
| -------- | ------------------- | --- | ---- | ------ | --- | -------- | ----------- | ----- | --- | --- |
We chose an EfficientNet [86] architecture, as Abbaspourazad et al. [1], since it is computationally less
expensive than traditional CNN backbones. We consider this choice also in light of the fact that foundation
models for wearable data have the potential to be used on wearable devices themselves [1]. We adapt the
EfficientNet for our input data, i.e., 1-dimensional time series data of 240 values (60 s at 4 Hz) with 3
channels (tonic, phasic and original EDA signal). We report in Appendix B ablation studies on the model
size and hyperparameters. We implement a version of EfficientNet with approximately 1M parameters and
| a latent representation |         | of d=64. |     |     |     |     |     |     |     |     |
| ----------------------- | ------- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
| 4.3 Training            | process |          |     |     |     |     |     |     |     |     |
Train loss Using the contrastive learning training objective and EfficientNet architecture defined in sub-
section 4.2, wetrain UME using the InfoNCE loss [89]. Formally, for a givenpair of embeddings (z ,z ), the
i j
| loss is defined | as: |     |     |          |     |           |           |         |     |     |
| --------------- | --- | --- | --- | -------- | --- | --------- | --------- | ------- | --- | --- |
|                 |     |     |     |          |     | exp(sim(z | i ,z j    | )/τ)    |     |     |
|                 |     |     |     | L =−logP |     |           |           |         |     | (1) |
|                 |     |     |     | i,j      | 2   | N ⊮       |           |         |     |     |
|                 |     |     |     |          |     | [k̸=i]    | exp(sim(z | ,z )/τ) |     |     |
|                 |     |     |     |          | k   | =1        |           | i k     |     |     |
where sim(·,·) denotes the cosine similarity, τ = 0.1 is a temperature hyperparameter, N is the batch size,
and⊮istheindicatorfunction. Thisobjectivemaximizesthesimilaritybetweenrepresentationsofthesame
| underlying | signal while | minimizing |     | agreement | with | unrelated | samples. |     |     |     |
| ---------- | ------------ | ---------- | --- | --------- | ---- | --------- | -------- | --- | --- | --- |
Pairs of EDA data We generate positive pairs of EDA signals by applying two distinct stochastic aug-
mentationstothesameEDAsignalsegment(ananchorsegment). Weemploythesetofdataaugmentations
optimizedforEDAsignalsproposedbyMattonetal.[64]. Negativepairsconsistofcomparisonsbetweenthe
anchor segment and all other segments in the mini-batch. This set combines both standard data augmenta-
tion techniques (e.g., signal warping) and augmentations specific to EDA data (e.g., loose sensor artifact).
We report the complete list of augmentations and additional details about the training in Appendix A
(Table A.5).
9

A foundation model for electrodermal activity data
5 Evaluation of UME
In this section, we report the results of the evaluation procedure of UME on the selected downstream
tasks from EDAMAME-test. We use linear probing with frozen weights to evaluate the performance on the
selected classification tasks, as frequently done to evaluate performance of foundation models [1, 81, 72, 95].
We compare the UME feature set to various baseline features, including generic handcrafted features, a set
of EDA-specific features, and features computed from generalist time series foundation models. Finally, we
also evaluate the computation complexity of the UME foundation model in extracting features, computed
to the other baseline methods.
5.1 Experimental evaluation setup
Evaluation through linear probing We evaluate the features computed from the UME foundation
model using linear probing on the downstream tasks from EDAMAME-test. For each dataset, we freeze the
trained weights from the foundation model to compute features on the EDA data. Then, we train a logistic
regressionclassifieronthecomputedfeatureset. Theusageoffrozenweightsandlinearprobingiscommonly
done in similar work on foundation models for physiological data [1, 72, 81]. We use the same evaluation
procedure for UME and the other baseline features sets. We use a linear model for all approaches since we
aregaugingtherepresentativenessofthefeaturessetsonclassificationtasks,andnotthatofthedownstream
model itself. Linear probing also allows to estimate the linear separability of the different feature sets.
Cross-validation protocols for the downstream tasks We evaluate the linear probing using two
distinct cross-validation methods. The first method is Leave-One-Participant-Out (LOPO) cross-validation.
LOPO cross-validation is used by researchers to evaluate how machine learning models generalize to new
users[76]. Withthismethod, wetestrobustnesstointer-personalvariability. Thesecondvalidationmethod
is Time-Aware (TA) cross-validation [6], which we use to evaluate the model’s ability to generalize to data
fromusersalreadyseeninthetrainset,andthiswetestrobustnesstointra-personalvariability. Wepartition
users into N folds: the model trains on all external groups plus the first chronological 2/3 of the target fold,
reservingthefinal1/3ofdatastrictlyfortesting. Thisapproachsimulatesarealisticscenariowhereamodel
uses a specific participant’s historical data to predict their future states. In our experimental setup, we use
N =5.
Inbothvalidationmethods,weperformhyperparametertuningforthelogisticregressionattrainset,i.e.,at
each cross-validation iteration. We perform hyperparameter selection using a 3-fold “inner” cross-validation
with grid search. We report in Appendix A information about the hyperparameter grid used.
Baseline feature sets We compare the performance using linear probing on the features computed from
UME and using other baseline methods. Specifically, to follow the same experimental setup of similar work
on foundation models for physiological data [1, 72, 68], we define a set of baseline, generic, handcrafted
features. These features are: the mean, the standard deviation, the minimum and the maximum of a 60 s
EDAsignal. WecomputethesefeaturesforallthreeEDAcomponents, i.e., phasic, tonicandoriginalsignal.
In total, the dimensionality of this feature set is d=12.
However,theaforementionedgenerichandcraftedfeaturesetdoesnotrepresentthestate-of-the-artapproach
for EDA-based classification tasks [4, 39, 63]. To this end, we also implement a second handcrafted feature
set, which we call EDA-specific handcrafted features. This feature set includes both statistics, e.g., average
of the first derivative, as well as feature specific to EDA data, e.g., number of EDA peaks and their average
amplitude. As with the generic handcrafted feature set, we compute these features on 60 s windows and for
all three EDA components. In total, the EDA-specific handcrafted features are d=45.
We also compare the performance using linear proving of the feature set from UME with other generalist
timeseriesfoundationmodels. Wecomparewiththefollowing: Chronos[8],MOMENT[43]andMantis[35].
We select these three foundation models since Alchieri et al. [5] show how they achieve performance similar
to the EDA-specific handcrafted features when using EDA data. Saha et al. [81] also show that Chronos [8]
and MOMENT [43] achieve, on average, performance similar to their PPG-specific foundation model on the
downstream tasks selected by the authors. We also select the recent foundation model Mantis [35] since it
is trained specifically for classification tasks on time series data.
Mantis takes time series of length 512 as input: we oversample our time series, which have length of 240, to
match this desired length. From a single time series, Mantis computes a set of embeddings, similarly to our
foundation model. Mantis has a feature set size of d = 768 (embedding size of 256 across three channels).
10

A foundation model for electrodermal activity data
1.0
0.9
0.8
0.7
0.6
0.5
0.5 0.6 0.7 0.8 0.9 1.0
Balanced Acc.
Generic Handcrafted Features
.ccA
decnalaB
serutaeF
EMAMADE
Dataset + task (marker)
APSYNC: Low/high engagement
Dreamt: Deep Sleep/REM
Dreamt: Sleep/Wake
HeartS: Sleep/Wake
WESAD: Low/High Valence
USILaughs: Cognitive load/relaxation
WESAD: Low/High (Self-Reported) Arousal
HHISS: Stress/calm
Validation method
TAcv
LOPO
Figure 5: Pairplot with comparison between UME and the baseline features for the selected downstream
tasks. Colors represent the two validation methods, TA and LOPO.
The embedding size of MOMENT is d=1024. However, Chronos computes embeddings (d=512) for each
timepoint in the series. This leads, with our input, to high dimensionality of the data. To address the
highdimensionalityproblem,weaverageacrossthetimeaxistheembeddingsextractedfromeachtimepoint.
Overall, the feature set from Chronos is of size d=1536 (embedding size of 512 across three channels).
Reporting and task selection information Wereportallresultsintermsofbalanced accuracy. Weuse
thismetricsincethedownstreamevaluationdatasetsweusecontainbinarylabelswhich,inasubsetofcases,
are imbalanced. Balanced accuracy accounts for class imbalance, reporting results which are more represen-
tative of the real performance on a specific task [16, 70]. At the same time, compared to other metrics for
imbalanceddata,e.g.,Matthew’scorrelationcoefficient(MCC),balancedaccuracyismoreinterpretable[44].
In addition to the results from the identified feature sets, we also report results from a dummy classifier.
The dummy classifier reported is the one achieving the highest balanced accuracy in each given task, among
the following: most frequent, which predicts always the most frequent class set; uniform, which predicts the
binary labels by drawing randomly from a uniform distribution; and prior, which predicts the binary labels
by drawing randomly from the distribution of labels in the train set.
We report in this section results from tasks that are solvable, i.e., at least one feature set achieves balanced
accuracyhigherthanthedummyclassifier. Ifnomodelachievesbalancedaccuracyhigherthan,forexample,
random chance, we conclude that it is not due to issues with the feature sets, but with the task itself, e.g.,
the task is not solvable with the given constraints.
5.2 Comparison with generic handcrafted feature set
We present in Figure 5 the comparison when performing linear probing on the selected downstream tasks,
between the feature set from our UME foundation model and the generic handcrafted features. We show
results for both validation methods, i.e., LOPO and TA. The results show that the features from our foun-
dation model outperform the generic handcrafted features in 9 out of 10 tasks. The improvement holds true
regardless of the scenario and the task selected. We conclude from these findings that the UME foundation
model learns features useful for EDA data in performing downstream predictions. Our findings are in line
with works on foundation models for PPG, when comparing to generic handcrafted feature sets [1, 72, 68].
11

A foundation model for electrodermal activity data
5.3 Comparison with other baseline feature sets
We report in Table 4 the results for the evaluation of our UME foundation model, in terms of balanced
accuracy and for two distinct validation methods, i.e., Time-Aware (TA) cross-validation and Leave-One-
Participant-Out (LOPO) cross-validation. We compare the feature set computed using UME to the fol-
lowing feature sets: a set of generic handcrafted features; a set of EDA-specific handcrafted features; and
features computed using generalist time series foundation models, specifically Mantis [35], Chronos [8] and
MOMENT [43].
Results using TA The TA method tests the intra-personal generalizability of models trained using the
different feature sets, i.e., the ability to generalize to new data from users already seen in the train data.
Our first finding is that, using linear probing, models trained using features from UME always outperform
non-foundation model methods, i.e., both generic and EDA-specific handcrafted features. We conclude that
the embeddings from UME capture user-specific dynamics, which allow to obtain a balanced accuracy on
par,orhigher,thanhandcrafted-basedmethods. Wealsofindthatmodelstrainedusingthefeaturesetfrom
Mantis[35],whichistrainedtosolvegenericclassificationtasks,performsimilarlytothosetrainedusingthe
featuresetfromUME.Wenoticehowtheothertwofoundationmodels,MOMENT[43]andChronos[8],have
lower performance, on a majority of tasks, than both the two handcrafted feature sets and the foundation
models (UME and Mantis [35]).
Results using LOPO The LOPO cross-validation method tests the inter-personal generalizability of
models trained using the different feature sets, i.e., the ability to generalize to data from new users not seen
inthetrainset. WefindthatmodelstrainedfromtheUMEfeatureshavesimilarbalancedaccuracytomodels
trained from either the EDA-specific handcrafted features and the embeddings computed using Mantis [35].
Featuresfromtheotherfoundationmodelshavesimilarorlowerperformanceaswell. Generalizationtonew
users is a known issue when working with EDA data [39]. While features from foundation models, both our
model and others, achieve performance similar to that of EDA-specific handcrafted features, they do not
solve the “cold-start” problem.
Additional remarks on standard errors We highlight how, regardless of the feature set used, the
standard error associated with all results leads to overlapping confidence intervals. In other words, while
there are trends, e.g., models trained using features from UME outperforming models trained using EDA-
specifichandcraftedfeaturesinamajorityoftasks,thereisnostatisticaldifferencebetweenresultsobtained
usingthedifferentfeaturesets. However,allresultsarestatisticallyhigher(t-testcorrectedwithBonferroni)
compared to the results obtained using the dummy classifier.
Result analysis using Friedman-Nemenyi test We perform the Friedman test, followed by the post-
hocNemenyitest,tocomparemodelperformanceacrossallexperiments[27]. Weconsidereachcombination
of dataset-validation method as a single sample for the statistical analysis. The Friedman test is used to
determine whether any statistical difference is present across all models and experiments. For the Friedman
test, we find a p-value of approximately 0.0001, which is below the reference threshold of α = 0.05. We
conclude from this result that, across all experiments, there are statistically significant differences. In
particular, we attribute this finding to the difference between all methods, i.e., both handcrafted- and
foundation model-based, and the dummy classifier baseline. We use the post-hoc Nemenyi test to perform
pair-wise statistical comparisons, from the model rankings provided by the Nemenyi test. We report the
findings with respect to our UME foundation model only. We refer to the Appendix B to additional results.
First, we find that our method achieves performance statistically higher than the dummy classifier baseline
(p =0.02 <α =0.05). Secondly, we find that the performance difference in linear probing between feature
sets computed using UME and Mantis [35] is not statistically different (p ≃ 0.9 > α > 0.05). Finally,
we also find no statistical difference between using our UME and the EDA-specific handcrafted features
(p≃0.9>α=0.05).
From the Friedman-Nemenyi test findings, we conclude that both our UME and Mantis [35] capture time
series dynamics which allow to achieve, on average, performance similar to the EDA-specific handcrafted
feature sets. Our EDA-trained foundation model performs on-par with a large-scale generalist time series
foundationmodel,Mantis[35],eveniftrainedonarelativelysmallerdatasetandwithfewerparameters(1M
ours vs 8M Mantis).
12

|     |     |     |     | A   | foundation | model | for | electrodermal |     | activity | data |
| --- | --- | --- | --- | --- | ---------- | ----- | --- | ------------- | --- | -------- | ---- |
Table 4: Results of binary classification experiments across datasets and tasks, in terms of balanced accu-
racy standard error . Reported are results for both TA and LOPO cross-validation methods. Acronyms: Gen.
HC stands for generic handcrafted features; EDA HC stands for EDA-specific handcrafted features.
|     |     |     |     | Handcrafted |     | (HC) |     | Generalist | Foundation |     | Ours |
| --- | --- | --- | --- | ----------- | --- | ---- | --- | ---------- | ---------- | --- | ---- |
Dummy
| Dataset | Binary |     |     | Gen. | EDA-spec. |     | Mantis | MOMENT |     | Chronos | UME |
| ------- | ------ | --- | --- | ---- | --------- | --- | ------ | ------ | --- | ------- | --- |
Task
|            |                  |     |      |     |     | Balanced | accuracy |          |       |     |     |
| ---------- | ---------------- | --- | ---- | --- | --- | -------- | -------- | -------- | ----- | --- | --- |
|            |                  |     |      |     |     |          |          | standard | error |     |     |
| Time-Aware | cross-validation |     | (TA) |     |     |          |          |          |       |     |     |
| APSYNC     | Low/High         |     | .45  | .80 |     | .80      | .86      |          | .47   | .61 | .89 |
.20 .10 .10 .07 16 .20 .11
engagement
| Dreamt | Deep |     | .48 | .55 |     | .59 | .64 |     | .65 | .63 | .63 |
| ------ | ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
.02 .05 .04 .03 01 02 .05
Sleep/REM
| Dreamt | Sleep/Wake |     | .50 | .65 |     | .69 | .73 |     | .69 | .73 | .70 |
| ------ | ---------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
.01 .02 .01 .01 01 01 .01
| HeartS | Sleep/Wake |     | .49 | .66 |     | .72 | .75 |     | .69 | .74 | .73 |
| ------ | ---------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
.00 .04 .07 .09 06 06 .09
WESAD Low/High .51 .03 .55 .10 .54 .10 .61 .04 .64 05 .45 .06 .63 .06
Valence
| Leave-one-participant-out |            |     | (LOPO) | cross-validation |     |     |     |     |     |     |     |
| ------------------------- | ---------- | --- | ------ | ---------------- | --- | --- | --- | --- | --- | --- | --- |
| Dreamt                    | Sleep/Wake |     | .48    | .70              |     | .74 | .76 |     | .73 | .78 | .75 |
.00 .01 .01 01 01 01 .01
| USILaughs | Cog. |     | .50 | .66 |     | .70 | .72 |     | .60 | .67 | .71 |
| --------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
.00 .03 .04 .05 .05 .03 .05
load/relax
| HeartS | Sleep/Wake |     | .50 | .66 |     | .70 | .74 |     | .70 | .73 | .72 |
| ------ | ---------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
.00 .04 .03 .03 .02 .03 .03
| WESAD | Low/High |     | .58 | .61 |     | .63 | .56 |     | .66 | .66 | .61 |
| ----- | -------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
.05 .04 .04 .04 .04 .05 .05
Arousal
| HHISS | Stress/calm |     | .50 | .56 |     | .64 | .63 |     | .55 | .59 | .60 |
| ----- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
.00 .02 .01 .02 .01 .01 .02
| 5.4 Computational |     | complexity | analysis |     |     |     |     |     |     |     |     |
| ----------------- | --- | ---------- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
We compare the computational complexity of the different feature extraction methods, i.e., the handcrafted-
based approaches, our UME foundation model, and the other baseline foundation models. We compare the
methods using both CPU execution time and FLOPs [22]. We choose this dual approach since handcrafted
featurescannotbecomparedusingFLOPsalone. WeperformallcalculationsusinganAppleM1MaxCPU.
To get CPU execution time, we use a random subset of twenty 60 s windows from the downstream part of
the UME collection. We also use additionally three samples per experiment as warm-up runs. We perform
FLOPs computation using the fvcore Python library. We report in Figure 6 the results. We find that
the handcrafted feature extraction methods have the lowest CPU execution time, as expected. We also
find that our UME foundation model is significantly faster than all other foundation models, both with
respect to CPU execution time and FLOPs. We conclude that our model, which is trained specifically only
on EDA data, achieves performance on-par with larger, general purpose, foundation models on a set of
downstream tasks using EDA data, as detailed in subsection 5.3. However, it does so with a fraction of the
computation resources needed, while also eliminating the need for expert-designed or handcrafted features,
| unlike traditional | feature-based |             | pipelines |        |      |     |     |     |     |     |     |
| ------------------ | ------------- | ----------- | --------- | ------ | ---- | --- | --- | --- | --- | --- | --- |
| 6 Discussion,      |               | limitations | and       | future | work |     |     |     |     |     |     |
Summary of results Through this paper, we provide the research community with the EDAMAME
collection of datasets, which enabled the development of UME, the first open-source foundation model for
wearable EDA. We find that UME, trained on a subset of the EDAMAME collection using contrastive
13

|     |     |     |     |     | A foundation | model for | electrodermal | activity | data |
| --- | --- | --- | --- | --- | ------------ | --------- | ------------- | -------- | ---- |
CPU Time per Sample (mean ± SE)
Computational Complexity: GFLOPs per Sample (60s)
MOMENT (128M)
|     |     |     |     |     |     | MOMENT (128M) |     |     | 59.80 |
| --- | --- | --- | --- | --- | --- | ------------- | --- | --- | ----- |
Chronos (28M)
|     |     |     |     |     |     | Chronos (28M) | 11.27 |     |     |
| --- | --- | --- | --- | --- | --- | ------------- | ----- | --- | --- |
Mantis (8M)
Mantis (8M) 0.85
EDAMAME (1M)
| EDA-specific hc |      |         |               |      |      | EDAMAME (1M)0.04 |                                         |       |     |
| --------------- | ---- | ------- | ------------- | ---- | ---- | ---------------- | --------------------------------------- | ----- | --- |
| 0               | 1000 | 2000    | 3000          | 4000 | 5000 | 0                | 10 20 30                                | 40 50 | 60  |
|                 |      |         | CPU Time (ms) |      |      |                  | GFLOPs (Giga Floating Point Operations) |       |     |
|                 |      | (a) CPU | Time          |      |      |                  | (b) Model GFLOPs                        |       |     |
Figure6: Computationalcomplexityanalysis. (a)Average(across20samples)per-samplecomputationtime
for a 60-second window of EDA data for all three components (phasic, tonic, and original signal). Note: hc
stands for handcrafted; generic handcrafted features are not shown as they require negligible computation
| time. (b) | GFLOPs | for the | different | foundation | models. |     |     |     |     |
| --------- | ------ | ------- | --------- | ---------- | ------- | --- | --- | --- | --- |
learning, surpasses the performance obtainable using both generic and EDA-handcrafted features in 8 out
of 10 downstream tasks. Further, UME matches the performance of larger and much less computationally
efficient generalist foundation models for time series data. By relying on publicly available data only and
by releasing all artifacts produced as part of this work, we aim at fostering further research on foundation
models for wearable EDA as well as other research related to unimodal and multimodal EDA sensing and
modelling.
Discussion Overall, we observe that features computed using UME, generalist time-series foundation
models, and EDA-specific handcrafted features lead to comparable downstream performance. It can be
argued that other methodologies, in particular the use of domain-specific architectures elements, may yield
superior performance. However, we believe that our results are not bound to UME’s specific characteristics,
becauseUME’sperformancesnotonlymatchesthoseofgeneralistfoundationmodels,butalsooftensurpasses
results obtained relying on EDA-specific handcrafted features. This suggests that other methodological
| approaches | alone | may yield | incremental | rather | than substantial | gains. |     |     |     |
| ---------- | ----- | --------- | ----------- | ------ | ---------------- | ------ | --- | --- | --- |
Instead, webelievethatthereportedresults, obtainedbyUMEandothermethods, areclosetotheintrinsic
upper limit reachable for the considered downstream tasks, due to the arguably limited information in
the input signal that is predictive of the label. Potential additional gains can however be obtained by
coping with the significant label noise and signal noise of EDA data. Wearable EDA is noisy, strongly
affectedbymotion/contactartifactsandlowsignal-to-noiseratio,inparticularwhencollectedinthewild[39].
Additionally, high-level constructs (e.g., stress, engagement, valence) might only be weakly identifiable from
EDAaloneresolutionwithoutadditionalcontext. Webelievethatthisrepresentsanimportantdirectionfor
future work, e.g., by quantifying the impact of signal quality filtering, label reliability, and more.
AfurtherelementtohighlightisthatUME,whichisspecializedforEDAdata,requiresfarfewerparameters
tomatchtheperformanceondownstreamtasksoflargergeneralistmodels. AshighlightedbyAbbaspourazad
et al. [1], developing foundation models for wearable data includes considering the usage of these models
on actual wearable devices, which are resource constrained. We speculate that our results showcase how
specializing foundation models for EDA data limit their size and, consequently, prospect their usage on
| wearable | devices. |     |     |     |     |     |     |     |     |
| -------- | -------- | --- | --- | --- | --- | --- | --- | --- | --- |
Limitations & future work We create the EDAMAME collection leveraging data collected exclusively
using the Empatica E4 device. Considering data collected from a specific device removes hardware-specific
domainshifts,ensuringthatfoundationmodelscanlearnphysiologicalpatternsratherthansensordifferences.
Nonetheless,futureworkcouldfocusonexpandingEDAMAMEwithdatafromotherdevices,e.g.,thenewer
| Empatica | Embrace | Plus13. |     |     |     |     |     |     |     |
| -------- | ------- | ------- | --- | --- | --- | --- | --- | --- | --- |
13https://www.empatica.com/embraceplus
14

A foundation model for electrodermal activity data
In our pre-processing approach, we apply standard low-pass filtering and decomposition of the EDA signals
using the cvxEDA method [45]. Alternative filtering or decomposition techniques [90] can be explored in
future research.
Lastly, we acknowledge that the EDAMAME collection of datasets is affected by the same user and domain
bias associated with the individual datasets.
7 Conclusions
In conclusion, in this work we present EDAMAME, a large scale collection of datasets containing wearable
EDA data. EDAMAME, which is composed of 24 datasets, contains approximately 25’000 hours of EDA
data from about 630 users. With its diversity and variability, it enables the training of foundation models
for EDA data, as we show with the training of UME, the first foundation model for wearable EDA. We also
make EDAMAME available to other researchers, to spur development of further foundation models.
Through a comprehensive set of experiments, we show that the latent representations obtained using UME
outperformasetofgenerichandcraftedfeatureswhenusinglinearprobingon9outof10downstreamtasks,
asdoneinsimilarworkintheliterature[1,72]. WealsofindthatUME’sfeaturesachieveperformanceon-par
with specialized EDA features and large-scale generalist foundation models, in the same set of downstream
tasks. However, compared to generalist models like Chronos [8] or Mantis [35], UME is computationally
lighter, e.g., 20× less demanding than the smallest generalist foundation model tested, enabling its possible
usage on real-world wearable devices.
We hope that this work enables researchers to further develop EDA, a sensor not (yet) as common as others
like PPG on wearable devices, through both the EDAMAME collection of datasets and the open source and
weights UME foundation model for wearable EDA data.
8 Dataset and code availability
WemaketheEDAMAMEavailabletootherresearchers,upon completion of the review process underway. 11
datasetshaveanopensourcelicensewhichallowsforre-sharingofthedataundertheoriginalconditions: we
re-share them, prepared in a unified format, following the original license. 11 datasets need a data sharing
agreement to be accessed: we contacted the original authors, who all agreed to re-sharing under a single
data sharing agreement, which includes all of the original limitations. Finally, two datasets can only be
accessed through their authors: we provide the code to process them in the same format as we did. We
report information about the original licenses in Appendix A (Table A.1). We will also share the code to
process these datasets after the ongoing review process.
We also make the code to train and evaluate the UME foundation model available as open source to other
researchers, as well as the model weights. The link will be provided after the ongoing review process.
15

A foundation model for electrodermal activity data
References
[1] Salar Abbaspourazad, Oussama Elachqar, Andrew C Miller, Saba Emrani, Udhyakumar Nallasamy,
and Ian Shapiro. Large-scale Training of Foundation Models for Wearable Biosignals. In International
Conference on Learning Representations, Vienna, Austria, 2024. International Conference on Learning
Representations (ICLR).
[2] Nouran Abdalazim, Joseba Aitzol Arbilla Larraza, Leonardo Alchieri, Lidia Alecci, Silvia Santini, and
Shkurta Gashi. Heart Rate During Sleep Measured Using Finger-, Wrist- and Chest-Worn Devices: A
Comparison Study. In Athanasios Tsanas and Andreas Triantafyllidis, editors, Pervasive Computing
Technologies for Healthcare, pages 18–32, Cham, 2023. Springer Nature Switzerland. ISBN 978-3-031-
34586-9. doi: 10.1007/978-3-031-34586-9_2.
[3] Nouran Abdalazim, Leonardo Alchieri, Lidia Alecci, Pietro Barbiero, and Silvia Santini. The Impact
of Domain Shift on Predicting Perceived Sleep Quality from Wearables. Sensors, 25(13):4012, January
2025. ISSN 1424-8220. doi: 10.3390/s25134012.
[4] LeonardoAlchieri,NouranAbdalazim,LidiaAlecci,ShkurtaGashi,MartinGjoreski,andSilviaSantini.
Lateralization Effects in Electrodermal Activity Data Collected Using Wearable Devices. Proc. ACM
Interact. Mob. Wearable Ubiquitous Technol., 8(1):2:1–2:30, March 2024. doi: 10.1145/3643541.
[5] Leonardo Alchieri, Lino Candian, Nouran Abdalazim, Lidia Alecci, Giovanni De Felice, and Silvia
Santini. Exploring Generalist Foundation Models for Time Series of Electrodermal Activity Data. In
Companion of the 2025 ACM International Joint Conference on Pervasive and Ubiquitous Comput-
ing, UbiComp Companion ’25, pages 885–892, New York, NY, USA, December 2025. Association for
Computing Machinery. ISBN 979-8-4007-1477-1. doi: 10.1145/3714394.3756186.
[6] Leonardo Alchieri, Vittoria Scocco, Nouran Abdalazim, Lidia Alecci, and Silvia Santini. Improving
Human Behavior Recognition Using Bilateral Electrodermal Activity Data Collected From Wearable
Devices. In 2025 International Conference on Activity and Behavior Computing (ABC),pages1–10, Al
Ain, United Arab Emirates, April 2025. IEEE. doi: 10.1109/ABC64332.2025.11118532.
[7] Ahmad Almadhor, Gabriel Avelino Sampedro, Mideth Abisado, Sidra Abbas, Ye-Jin Kim, Muham-
mad Attique Khan, Jamel Baili, and Jae-Hyuk Cha. Wrist-Based Electrodermal Activity Monitoring
for Stress Detection Using Federated Learning. Sensors, 23(8):3984, January 2023. ISSN 1424-8220.
doi: 10.3390/s23083984.
[8] Abdul Fatir Ansari, Lorenzo Stella, Ali Caner Turkmen, Xiyuan Zhang, Pedro Mercado, Huibin Shen,
Oleksandr Shchur, Syama Sundar Rangapuram, Sebastian Pineda Arango, Shubham Kapoor, Jasper
Zschiegner, Danielle C. Maddix, Hao Wang, Michael W. Mahoney, Kari Torkkola, Andrew Gordon
Wilson, Michael Bohlke-Schneider, and Bernie Wang. Chronos: Learning the Language of Time Series.
Transactions on Machine Learning Research, May 2024. ISSN 2835-8856.
[9] Abdul Fatir Ansari, Oleksandr Shchur, Jaris Küken, Andreas Auer, Boran Han, Pedro Mercado,
SyamaSundarRangapuram,HuibinShen,LorenzoStella,XiyuanZhang,MononitoGoswami,Shubham
Kapoor, Danielle C. Maddix, Pablo Guerron, Tony Hu, Junming Yin, Nick Erickson, Prateek Mutalik
Desai, Hao Wang, Huzefa Rangwala, George Karypis, Yuyang Wang, and Michael Bohlke-Schneider.
Chronos-2: From Univariate to Universal Forecasting, October 2025.
[10] Project Apertus, Alejandro Hernández-Cano, Alexander Hägele, Allen Hao Huang, Angelika Romanou,
Antoni-Joan Solergibert, Barna Pasztor, Bettina Messmer, Dhia Garbaya, Eduard Frank Ďurech, Ido
Hakimi, Juan García Giraldo, Mete Ismayilzada, Negar Foroutan, Skander Moalla, Tiancheng Chen,
Vinko Sabolčec, Yixuan Xu, Michael Aerni, Badr AlKhamissi, Inés Altemir Mariñas, Mohammad Hos-
sein Amani, Matin Ansaripour, Ilia Badanin, Harold Benoit, Emanuela Boros, Nicholas Browning,
Fabian Bösch, Maximilian Böther, Niklas Canova, Camille Challier, Clement Charmillot, Jonathan
Coles, Jan Deriu, Arnout Devos, Lukas Drescher, Daniil Dzenhaliou, Maud Ehrmann, Dongyang Fan,
Simin Fan, Silin Gao, Miguel Gila, María Grandury, Diba Hashemi, Alexander Hoyle, Jiaming Jiang,
Mark Klein, Andrei Kucharavy, Anastasiia Kucherenko, Frederike Lübeck, Roman Machacek, Theofi-
los Manitaras, Andreas Marfurt, Kyle Matoba, Simon Matrenok, Henrique Mendonça, Fawzi Roberto
Mohamed, Syrielle Montariol, Luca Mouchel, Sven Najem-Meyer, Jingwei Ni, Gennaro Oliva, Matteo
Pagliardini, EliaPalme, AndreiPanferov, LéoPaoletti, MarcoPasserini, IvanPavlov, AugustePoiroux,
KaustubhPonkshe,NathanRanchin,JaviRando,MathieuSauser,JakhongirSaydaliev,MuhammadAli
Sayfiddinov, Marian Schneider, Stefano Schuppli, Marco Scialanga, Andrei Semenov, Kumar Shridhar,
Raghav Singhal, Anna Sotnikova, Alexander Sternfeld, Ayush Kumar Tarun, Paul Teiletche, Jannis
Vamvas, Xiaozhe Yao, Hao Zhao, Alexander Ilic, Ana Klimovic, Andreas Krause, Caglar Gulcehre,
16

A foundation model for electrodermal activity data
David Rosenthal, Elliott Ash, Florian Tramèr, Joost VandeVondele, Livio Veraldi, Martin Rajman,
Thomas Schulthess, Torsten Hoefler, Antoine Bosselut, Martin Jaggi, and Imanol Schlag. Apertus:
Democratizing Open and Compliant LLMs for Global Language Environments, December 2025.
[11] Brinnae Bent, Peter J. Cho, Maria Henriquez, April Wittmann, Connie Thacker, Mark Feinglos,
Matthew J. Crowley, and Jessilyn P. Dunn. Engineering digital biomarkers of interstitial glucose
from noninvasive smartwatches. npj Digital Medicine, 4(1):89, June 2021. ISSN 2398-6352. doi:
10.1038/s41746-021-00465-w.
[12] Andrew Beten, Luna Lococco, Ayaan Baig, and Thilini Karunarathna. Systematic Analysis of Dis-
tribution Shifts in Cross-Subject Glucose Prediction Using Wearable Physiological Data. Engineering
Proceedings, 118(1):88, 2025. ISSN 2673-4591. doi: 10.3390/ECSA-12-26583.
[13] Andrea Bizzego, Giulio Gabrieli, Cesare Furlanello, and Gianluca Esposito. Comparison of Wearable
andClinicalDevicesforAcquisitionofPeripheralNervousSystemSignals. Sensors(Basel, Switzerland),
20(23):6778, November 2020. ISSN 1424-8220. doi: 10.3390/s20236778.
[14] Rishi Bommasani, Drew A. Hudson, Ehsan Adeli, Russ Altman, Simran Arora, Sydney von Arx,
Michael S. Bernstein, Jeannette Bohg, Antoine Bosselut, Emma Brunskill, Erik Brynjolfsson, Shyamal
Buch, Dallas Card, Rodrigo Castellon, Niladri Chatterji, Annie Chen, Kathleen Creel, Jared Quincy
Davis, Dora Demszky, Chris Donahue, Moussa Doumbouya, Esin Durmus, Stefano Ermon, John
Etchemendy, Kawin Ethayarajh, Li Fei-Fei, Chelsea Finn, Trevor Gale, Lauren Gillespie, Karan Goel,
Noah Goodman, Shelby Grossman, Neel Guha, Tatsunori Hashimoto, Peter Henderson, John Hewitt,
DanielE.Ho,JennyHong,KyleHsu,JingHuang,ThomasIcard,SaahilJain,DanJurafsky,Pratyusha
Kalluri, Siddharth Karamcheti, Geoff Keeling, Fereshte Khani, Omar Khattab, Pang Wei Koh, Mark
Krass, Ranjay Krishna, Rohith Kuditipudi, Ananya Kumar, Faisal Ladhak, Mina Lee, Tony Lee, Jure
Leskovec, Isabelle Levent, Xiang Lisa Li, Xuechen Li, Tengyu Ma, Ali Malik, Christopher D. Manning,
Suvir Mirchandani, Eric Mitchell, Zanele Munyikwa, Suraj Nair, Avanika Narayan, Deepak Narayanan,
Ben Newman, Allen Nie, Juan Carlos Niebles, Hamed Nilforoshan, Julian Nyarko, Giray Ogut, Lau-
rel Orr, Isabel Papadimitriou, Joon Sung Park, Chris Piech, Eva Portelance, Christopher Potts, Aditi
Raghunathan,RobReich,HongyuRen, FriedaRong,YusufRoohani, CamiloRuiz,JackRyan,Christo-
pher Ré, Dorsa Sadigh, Shiori Sagawa, Keshav Santhanam, Andy Shih, Krishnan Srinivasan, Alex
Tamkin, Rohan Taori, Armin W. Thomas, Florian Tramèr, Rose E. Wang, William Wang, Bohan Wu,
Jiajun Wu, Yuhuai Wu, Sang Michael Xie, Michihiro Yasunaga, Jiaxuan You, Matei Zaharia, Michael
Zhang, Tianyi Zhang, Xikun Zhang, Yuhui Zhang, Lucia Zheng, Kaitlyn Zhou, and Percy Liang. On
the Opportunities and Risks of Foundation Models, July 2022.
[15] Wolfram Boucsein. Electrodermal Activity. Electrodermal Activity, 2nd Ed. Springer Science + Busi-
ness Media, New York, NY, US, 2012. ISBN 978-1-4614-1125-3 978-1-4614-1126-0. doi: 10.1007/
978-1-4614-1126-0.
[16] Kay Henning Brodersen, Cheng Soon Ong, Klaas Enno Stephan, and Joachim M. Buhmann. The
Balanced Accuracy and Its Posterior Distribution. In 2010 20th International Conference on Pattern
Recognition, pages 3121–3124, Istanbul, Turkey, August 2010. IEEE. doi: 10.1109/ICPR.2010.764.
[17] TomBrown,BenjaminMann,NickRyder,MelanieSubbiah,JaredDKaplan,PrafullaDhariwal,Arvind
Neelakantan, Pranav Shyam, Girish Sastry, Amanda Askell, Sandhini Agarwal, Ariel Herbert-Voss,
Gretchen Krueger, Tom Henighan, Rewon Child, Aditya Ramesh, Daniel Ziegler, Jeffrey Wu, Clemens
Winter, Chris Hesse, Mark Chen, Eric Sigler, Mateusz Litwin, Scott Gray, Benjamin Chess, Jack Clark,
Christopher Berner, Sam McCandlish, Alec Radford, Ilya Sutskever, and Dario Amodei. Language
Models are Few-Shot Learners. In Advances in Neural Information Processing Systems, volume 33,
pages 1877–1901, Online, 2020. Curran Associates, Inc.
[18] AlexanderBukharin,ShiyangLi,ZhengyangWang,JingfengYang,BingYin,XianLi,ChaoZhang,Tuo
Zhao,andHaomingJiang. DataDiversityMattersforRobustInstructionTuning. InYaserAl-Onaizan,
MohitBansal, andYun-NungChen, editors, Findings of the Association for Computational Linguistics:
EMNLP 2024, pages 3411–3425, Miami, Florida, USA, November 2024. Association for Computational
Linguistics. doi: 10.18653/v1/2024.findings-emnlp.195.
[19] Maritza Bustos-Lopez, Nicandro Cruz-Ramirez, Alejandro Guerra-Hernandez, Laura Nely Sánchez-
Morales, Nancy Aracely Cruz-Ramos, and Giner Alor-Hernandez. Wearables for engagement detection
in learning environments: A review. Biosensors, 12(7):509, 2022.
[20] Sara Campanella, Ayham Altaleb, Alberto Belli, Paola Pierleoni, and Lorenzo Palma. A Method for
Stress Detection Using Empatica E4 Bracelet and Machine-Learning Techniques. Sensors, 23(7):3565,
January 2023. ISSN 1424-8220. doi: 10.3390/s23073565.
17

|     |     |     |     | A foundation | model for | electrodermal | activity data |
| --- | --- | --- | --- | ------------ | --------- | ------------- | ------------- |
[21] MartaCasanovasOrtega,ElisaBruno,andMarkP.Richardson. Electrodermalactivityresponseduring
seizures: A systematic review and meta-analysis. Epilepsy & Behavior: E&B, 134:108864, September
| 2022. ISSN | 1525-5069. | doi: | 10.1016/j.yebeh.2022.108864. |     |     |     |     |
| ---------- | ---------- | ---- | ---------------------------- | --- | --- | --- | --- |
[22] Jierun Chen, Shiu-hong Kao, Hao He, Weipeng Zhuo, Song Wen, Chul-Ho Lee, and S.-H. Gary Chan.
Run, Don’tWalk: ChasingHigherFLOPSforFasterNeuralNetworks. In2023 IEEE/CVF Conference
on Computer Vision and Pattern Recognition (CVPR), pages 12021–12031, Vancouver, BC, Canada,
June 2023. IEEE. ISBN 979-8-3503-0129-8. doi: 10.1109/CVPR52729.2023.01157.
[23] Zhengyu Chen, Siqi Wang, Teng Xiao, Yudong Wang, Shiqi Chen, Xunliang Cai, Junxian He, and
Jingang Wang. Revisiting Scaling Laws for Language Models: The Role of Data Quality and Training
Strategies. In Wanxiang Che, Joyce Nabende, Ekaterina Shutova, and Mohammad Taher Pilehvar,
editors, Proceedings of the 63rd Annual Meeting of the Association for Computational Linguistics (Vol-
ume 1: Long Papers), pages 23881–23899, Vienna, Austria, July 2025. Association for Computational
| Linguistics. | ISBN 979-8-89176-251-0. |     |     | doi: 10.18653/v1/2025.acl-long.1163. |     |     |     |
| ------------ | ----------------------- | --- | --- | ------------------------------------ | --- | --- | --- |
[24] Davide Chicco and Giuseppe Jurman. The advantages of the Matthews correlation coefficient (MCC)
over F1 score and accuracy in binary classification evaluation. BMC Genomics, 21(1):6, January 2020.
| ISSN 1471-2164. | doi: | 10.1186/s12864-019-6413-7. |     |     |     |     |     |
| --------------- | ---- | -------------------------- | --- | --- | --- | --- | --- |
[25] Donna L. Coffman, Xizhen Cai, Runze Li, and Noelle R. Leonard. Challenges and Opportunities in
Collecting and Modeling Ambulatory Electrodermal Activity Data. JMIR biomedical engineering, 5(1):
| e17106, | 2020. ISSN | 2561-3278. | doi: | 10.2196/17106. |     |     |     |
| ------- | ---------- | ---------- | ---- | -------------- | --- | --- | --- |
[26] Akbar Dehghani, Omid Sarbishei, Tristan Glatard, and Emad Shihab. A Quantitative Comparison
of Overlapping and Non-Overlapping Sliding Windows for Human Activity Recognition Using Inertial
Sensors. Sensors, 19(22):5026, January 2019. ISSN 1424-8220. doi: 10.3390/s19225026.
[27] Janez Demšar. Statistical Comparisons of Classifiers over Multiple Data Sets. J. Mach. Learn. Res., 7:
| 1–30, December | 2006. | ISSN | 1532-4435. |     |     |     |     |
| -------------- | ----- | ---- | ---------- | --- | --- | --- | --- |
[28] Seyma Derdiyok, Fatma Patlar Akbulut, and Cagatay Catal. Neurophysiological and biosignal data for
investigating occupational mental fatigue: MEFAR dataset. Data in Brief, 52:109896, February 2024.
| ISSN 2352-3409. | doi: | 10.1016/j.dib.2023.109896. |     |     |     |     |     |
| --------------- | ---- | -------------------------- | --- | --- | --- | --- | --- |
[29] Elena Di Lascio, Shkurta Gashi, and Silvia Santini. Unobtrusive Assessment of Students’ Emotional
EngagementduringLecturesUsingElectrodermalActivitySensors. Proc.ACMInteract.Mob.Wearable
Ubiquitous Technol., 2(3):103:1–103:21, September 2018. doi: 10.1145/3264913.
[30] ElenaDiLascio,ShkurtaGashi,andSilviaSantini. LaughterRecognitionUsingNon-invasiveWearable
Devices. InProceedings of the 13th EAI International Conference on Pervasive Computing Technologies
for Healthcare, PervasiveHealth’19, pages 262–271, New York, NY, USA, May 2019. Association for
Computing Machinery. ISBN 978-1-4503-6126-2. doi: 10.1145/3329189.3329216.
[31] Elena Di Lascio, Shkurta Gashi, Maike E. Debus, and Silvia Santini. Automatic Recognition of Flow
During Work Activities Using Context and Physiological Signals. In 2021 9th International Conference
on Affective Computing and Intelligent Interaction (ACII), pages 1–8, Nara, Japan, September 2021.
| IEEE. | doi: 10.1109/ACII52823.2021.9597434. |     |     |     |     |     |     |
| ----- | ------------------------------------ | --- | --- | --- | --- | --- | --- |
[32] ChengDing,ZhichengGuo,ZhaoliangChen,RandallJLee,CynthiaRudin,andXiaoHu. SiamQuality:
A ConvNet-based foundation model for photoplethysmography signals. Physiological Measurement, 45
| (8):085004, | August | 2024. ISSN | 0967-3334. | doi: 10.1088/1361-6579/ad6747. |     |     |     |
| ----------- | ------ | ---------- | ---------- | ------------------------------ | --- | --- | --- |
[33] Vipula Dissanayake, Sachith Seneviratne, Rajib Rana, Elliott Wen, Tharindu Kaluarachchi, and
Suranga Nanayakkara. SigRep: Toward Robust Wearable Emotion Recognition With Contrastive Rep-
resentation Learning. IEEE Access, 10:18105–18120, 2022. ISSN 2169-3536. doi: 10.1109/ACCESS.
2022.3149509.
[34] Alexey Dosovitskiy, Lucas Beyer, Alexander Kolesnikov, Dirk Weissenborn, Xiaohua Zhai, Thomas Un-
terthiner, Mostafa Dehghani, Matthias Minderer, Georg Heigold, Sylvain Gelly, Jakob Uszkoreit, and
Neil Houlsby. An Image is Worth 16x16 Words: Transformers for Image Recognition at Scale. In Inter-
national Conference on Learning Representations, Addis Ababa, Ethiopia, October 2020. International
| Conference | on Learning | Representations |     | (ICLR). |     |     |     |
| ---------- | ----------- | --------------- | --- | ------- | --- | --- | --- |
[35] Vasilii Feofanov, Songkang Wen, Marius Alonso, Romain Ilbert, Hongbo Guo, Malik Tiomoko, Lujia
Pan, Jianfeng Zhang, and Ievgen Redko. Mantis: Lightweight Calibrated Foundation Model for User-
| Friendly | Time Series | Classification, |     | February 2025. |     |     |     |
| -------- | ----------- | --------------- | --- | -------------- | --- | --- | --- |
18

A foundation model for electrodermal activity data
[36] Nan Gao, Wei Shao, Mohammad Saiedur Rahaman, and Flora D. Salim. N-Gage: Predicting in-class
Emotional, Behavioural and Cognitive Engagement in the Wild. Proc. ACM Interact. Mob. Wearable
Ubiquitous Technol., 4(3):79:1–79:26, September 2020. doi: 10.1145/3411813.
[37] Francisco M. Garcia-Moreno and Marta Badenes-Sastre. EmoPulse Moments E4 Dataset (EPM-E4):
An Exhaustive Collection of Emotion-Related Data from Empatica E4 Wearable, September 2020.
[38] Shkurta Gashi, Elena Di Lascio, and Silvia Santini. Using Unobtrusive Wearable Sensors to Measure
the Physiological Synchrony Between Presenters and Audience Members. Proc. ACM Interact. Mob.
Wearable Ubiquitous Technol., 3(1):13:1–13:19, March 2019. doi: 10.1145/3314400.
[39] Shkurta Gashi, Elena Di Lascio, Bianca Stancu, Vedant Das Swain, Varun Mishra, Martin Gjoreski,
and Silvia Santini. Detection of Artifacts in Ambulatory Electrodermal Activity Data. Proc. ACM
Interact. Mob. Wearable Ubiquitous Technol., 4(2):44:1–44:31, June 2020. doi: 10.1145/3397316.
[40] Shkurta Gashi, Lidia Alecci, Elena Di Lascio, Maike E. Debus, Francesca Gasparini, and Silvia Santini.
TheRoleofModelPersonalizationforSleepStageandSleepQualityRecognitionUsingWearables.IEEE
Pervasive Computing, 21(2):69–77, April 2022. ISSN 1558-2590. doi: 10.1109/MPRV.2022.3164334.
[41] ShkurtaGashi,ChulhongMin,AlessandroMontanari,SilviaSantini,andFahimKawsar. Amultidevice
and multimodal dataset for human energy expenditure estimation using wearable devices. Scientific
Data, 9(1):537, September 2022. ISSN 2052-4463. doi: 10.1038/s41597-022-01643-5.
[42] Martin Gjoreski, Tine Kolenik, Timotej Knez, Mitja Luštrek, Matjaž Gams, Hristijan Gjoreski, and
VeljkoPejović. DatasetsforCognitiveLoadInferenceUsingWearableSensorsandPsychologicalTraits.
Applied Sciences, 10(11):3843, January 2020. ISSN 2076-3417. doi: 10.3390/app10113843.
[43] Mononito Goswami, Konrad Szafer, Arjun Choudhry, Yifu Cai, Shuo Li, and Artur Dubrawski. MO-
MENT: A family of open time-series foundation models. In Proceedings of the 41st International Con-
ference on Machine Learning, volume 235 of ICML’24, pages 16115–16152, Vienna, Austria, July 2024.
JMLR.org.
[44] Margherita Grandini, Enrico Bagli, and Giorgio Visani. Metrics for Multi-Class Classification: An
Overview, August 2020.
[45] Alberto Greco, Gaetano Valenza, Antonio Lanata, Enzo Pasquale Scilingo, and Luca Citi. cvxEDA: A
ConvexOptimizationApproachtoElectrodermalActivityProcessing.IEEETransactionsonBiomedical
Engineering, 63(4):797–804, April 2016. ISSN 1558-2531. doi: 10.1109/TBME.2015.2474131.
[46] Md-BillalHossain,YoungsunKong,HugoF.Posada-Quintero,andKiH.Chon. ComparisonofElectro-
dermalActivityfromMultipleBodyLocationsBasedonStandardEDAIndices’QualityandRobustness
against Motion Artifact. Sensors, 22(9):3177, January 2022. ISSN 1424-8220. doi: 10.3390/s22093177.
[47] Md. Billal Hossain, Youngsun Kong, Hugo Posada-Quintero, and Ki Chon. Electrodermal Activity:
Applications and Challenges, pages 475–496. Cambridge University Press, November 2024. ISBN 978-
1-316-51855-7. doi: 10.1017/9781009000796.022.
[48] Seyedmajid Hosseini, Raju Gottumukkala, Satya Katragadda, Ravi Teja Bhupatiraju, Ziad Ashkar,
Christoph W. Borst, and Kenneth Cochran. A multimodal sensor dataset for continuous stress
detection of nurses in a hospital. Scientific Data, 9(1):255, June 2022. ISSN 2052-4463. doi:
10.1038/s41597-022-01361-y.
[49] Talha Iqbal, Andrew J. Simpkin, Davood Roshan, Nicola Glynn, John Killilea, Jane Walsh, Gerard
Molloy, Sandra Ganly, Hannah Ryman, Eileen Coen, Adnan Elahi, William Wijns, and Atif Shahzad.
Stress Monitoring Using Wearable Sensors: A Pilot Study and Stress-Predict Dataset. Sensors, 22(21):
8135, January 2022. ISSN 1424-8220. doi: 10.3390/s22218135.
[50] Alistair E. W. Johnson, Tom J. Pollard, Lu Shen, Li-wei H. Lehman, Mengling Feng, Mohammad
Ghassemi, Benjamin Moody, Peter Szolovits, Leo Anthony Celi, and Roger G. Mark. MIMIC-III, a
freely accessible critical care database. Scientific Data, 3(1):160035, May 2016. ISSN 2052-4463. doi:
10.1038/sdata.2016.35.
[51] AlistairE.W.Johnson,LucasBulgarelli,LuShen,AlvinGayles,AyadShammout,StevenHorng,TomJ.
Pollard,SichengHao,BenjaminMoody,BrianGow,Li-weiH.Lehman,LeoA.Celi,andRogerG.Mark.
MIMIC-IV, a freely accessible electronic health record dataset. Scientific Data, 10(1):1, January 2023.
ISSN 2052-4463. doi: 10.1038/s41597-022-01899-x.
[52] Daniel Kahneman, Bernard Tursky, David Shapiro, and Andrew Crider. Pupillary, heart rate, and skin
resistance changes during a mental task. Journal of experimental psychology, 79(1p1):164, 1969.
19

A foundation model for electrodermal activity data
[53] Diederik P. Kingma and Jimmy Ba. Adam: A Method for Stochastic Optimization, 2017.
[54] Zuzana Koscova, Valdery Moura Junior, Matthew Reyna, Shenda Hong, Aditya Gupta, Manohar
Ghanta, Reza Sameni, Aaron Aguirre, Qiao Li, Sahar Zafar, Gari Clifford, and M Brandon Westover.
Harvard-Emory ECG Database, 2025.
[55] Matias Laporte, Martin Gjoreski, and Marc Langheinrich. LAUREATE: A Dataset for Supporting Re-
searchinAffectiveComputingandHumanMemoryAugmentation. Proc.ACMInteract.Mob.Wearable
Ubiquitous Technol., 7(3):106:1–106:41, September 2023. doi: 10.1145/3610892.
[56] Phuc H. Le-Khac, Graham Healy, and Alan F. Smeaton. Contrastive Representation Learning: A
FrameworkandReview. IEEE Access, 8:193907–193934, 2020. ISSN2169-3536. doi: 10.1109/ACCESS.
2020.3031549.
[57] Hyung-ChulLee,YoonsangPark,SooBinYoon,SeongMiYang,DongnyeokPark,andChul-WooJung.
VitalDB, a high-fidelity multi-parameter vital signs database in surgical patients. Scientific Data, 9(1):
279, June 2022. ISSN 2052-4463. doi: 10.1038/s41597-022-01411-5.
[58] Simon Lee and Kai Akamatsu. Foundation Models for Physiological Signals: Opportunities and Chal-
lenges, August 2025.
[59] JunLi,AaronD.Aguirre,ValderyMoura,JiaruiJin,CheLiu,LanhaiZhong,ChenxiSun,GariClifford,
M. Brandon Westover, and Shenda Hong. An Electrocardiogram Foundation Model Built on over 10
Million Recordings. Nejm Ai, 2(7):AIoa2401033, July 2025. ISSN 2836-9386. doi: 10.1056/aioa2401033.
[60] Yu Liu, María-Itatí Palacio, Taha Bikki, Cesar Toledo, Yu Ouyang, Zhongzheng Li, Zhengyi Wang,
Francisco Toledo, Hong Zeng, and María-Trinidad Herrero. Machine Learning, Physiological Signals,
and Emotional Stress/Anxiety: Pitfalls and Challenges. Applied Sciences, 15(21):11777, January 2025.
ISSN 2076-3417. doi: 10.3390/app152111777.
[61] JunošLukan,MartinGjoreski,HeidiMauersberger,AnnekatrinHoppe,UrsulaHess,andMitjaLuštrek.
Analysing Physiology of Interpersonal Conflicts Using a Wrist Device. In Achilles Kameas and Kostas
Stathis, editors, Ambient Intelligence, pages 162–167, Cham, 2018. Springer International Publishing.
ISBN 978-3-030-03062-9. doi: 10.1007/978-3-030-03062-9_13.
[62] Yunfei Luo, Yuliang Chen, Asif Salekin, and Tauhidur Rahman. Toward Foundation Model for Multi-
variate Wearable Sensing of Physiological Signals, May 2025.
[63] Erika Lutin, Ryuga Hashimoto, Walter De Raedt, and Chris Van Hoof. Feature Extraction for Stress
Detection in Electrodermal Activity:. In Proceedings of the 14th International Joint Conference on
Biomedical Engineering Systems and Technologies, pages 177–185, Online Streaming, — Select a Coun-
try —, 2021. SCITEPRESS - Science and Technology Publications. ISBN 978-989-758-490-9. doi:
10.5220/0010244601770185.
[64] KatieMatton,RobertLewis,JohnGuttag,andRosalindPicard. ContrastiveLearningofElectrodermal
Activity Representations for Stress Detection. In Proceedings of the Conference on Health, Inference,
and Learning, pages 410–426, Cambridge, MA, USA, June 2023. PMLR.
[65] Daniel McDuff, Seamus Thomson, Samy Abdel-Ghaffar, Isaac R. Galatzer-Levy, Ming-Zher Poh, Jake
Sunshine, Andrew Barakat, Conor Heneghan, and Lindsey Sunden. What Does Large-scale Electroder-
mal Sensing Reveal?, February 2024.
[66] Kaden McKeen, Sameer Masood, Augustin Toma, Barry Rubin, and Bo Wang. ECG-FM: An open
electrocardiogram foundation model. JAMIA open, 8(5):ooaf122, October 2025. ISSN 2574-2531. doi:
10.1093/jamiaopen/ooaf122.
[67] Varun Mishra, Sougata Sen, Grace Chen, Tian Hao, Jeffrey Rogers, Ching-Hua Chen, and David Kotz.
Evaluating the Reproducibility of Physiological Stress Detection Models. Proc. ACM Interact. Mob.
Wearable Ubiquitous Technol., 4(4):147:1–147:29, December 2020. doi: 10.1145/3432220.
[68] Girish Narayanswamy, Xin Liu, Kumar Ayush, Yuzhe Yang, Xuhai Xu, Shun Liao, Jake Garrison,
Shyam Tailor, Jake Sunshine, Yun Liu, Tim Althoff, Shrikanth Narayanan, Pushmeet Kohli, Jiening
Zhan, Mark Malhotra, Shwetak Patel, Samy Abdel-Ghaffar, and Daniel McDuff. Scaling Wearable
Foundation Models, October 2024.
[69] SameerNeupane,MithunSaha,NasirAli,TimothyHnat,ShahinAlanSamiei,AnandatirthaNandugudi,
David M. Almeida, and Santosh Kumar. Momentary Stressor Logging and Reflective Visualizations:
ImplicationsforStressManagementwithWearables. InProceedings of the 2024 CHI Conference on Hu-
man Factors in Computing Systems, CHI ’24, pages 1–19, New York, NY, USA, May 2024. Association
for Computing Machinery. ISBN 979-8-4007-0330-0. doi: 10.1145/3613904.3642662.
20

A foundation model for electrodermal activity data
[70] Michael Owusu-Adjei, James Ben Hayfron-Acquah, Twum Frimpong, and Gaddafi Abdul-Salaam. Im-
balanced class distribution and performance evaluation metrics: A systematic review of prediction ac-
curacyfordeterminingmodelperformanceinhealthcaresystems. PLOS Digital Health,2(11):e0000290,
November 2023. ISSN 2767-3170. doi: 10.1371/journal.pdig.0000290.
[71] Adam Paszke, Sam Gross, Francisco Massa, Adam Lerer, James Bradbury, Gregory Chanan, Trevor
Killeen, ZemingLin, NataliaGimelshein, LucaAntiga, AlbanDesmaison, AndreasKöpf, EdwardYang,
Zach DeVito, Martin Raison, Alykhan Tejani, Sasank Chilamkurthy, Benoit Steiner, Lu Fang, Junjie
Bai, and Soumith Chintala. PyTorch: An Imperative Style, High-Performance Deep Learning Library,
pages 8026–8037. Curran Associates Inc., Red Hook, NY, USA, 2019.
[72] Arvind Pillai, Dimitris Spathis, Fahim Kawsar, and Mohammad Malekzadeh. PaPaGei: Open Founda-
tion Models for Optical Physiological Signals, February 2025.
[73] Anuja Pinge, Vinaya Gad, Dheryta Jaisighani, Surjya Ghosh, and Sougata Sen. Detection and moni-
toring of stress using wearables: a systematic review. Frontiers in Computer Science, 6:1478851, 2024.
[74] Ming-Zher Poh, Tobias Loddenkemper, Claus Reinsberger, Nicholas C. Swenson, Shubhi Goyal,
Mangwe C. Sabtala, Joseph R. Madsen, and Rosalind W. Picard. Convulsive seizure detection us-
ingawrist-wornelectrodermalactivityandaccelerometrybiosensor. Epilepsia,53(5):e93–97,May2012.
ISSN 1528-1167. doi: 10.1111/j.1528-1167.2012.03444.x.
[75] Md.RafiulAmin, DilranjanS.Wickramasuriya, andRoseT.Faghih. AWearableExamStressDataset
for Predicting Grades using Physiological Signals. In 2022 IEEE Healthcare Innovations and Point of
Care Technologies (HI-POCT), pages 30–36, Houston, TX, USA, March 2022. IEEE. doi: 10.1109/
HI-POCT54491.2022.9744065.
[76] SaeedUrRehman,AnwarAli,AdilMehmoodKhan,andCynthiaOkpala. HumanActivityRecognition:
A Comparative Study of Validation Methods and Impact of Feature Extraction in Wearable Sensors.
Algorithms, 17(12):556, December 2024. ISSN 1999-4893. doi: 10.3390/a17120556.
[77] Attila Reiss, Ina Indlekofer, Philip Schmidt, and Kristof Van Laerhoven. Deep PPG: Large-Scale Heart
Rate Estimation with Convolutional Neural Networks. Sensors, 19(14):3079, January 2019. ISSN 1424-
8220. doi: 10.3390/s19143079.
[78] Matthew A Reyna, Nadi Sadr, Erick A Perez Alday, Annie Gu, Amit J Shah, Chad Robichaux,
Ali Bahrami Rad, Andoni Elola, Salman Seyedi, Sardar Ansari, Hamid Ghanbari, Qiao Li, Ashish
Sharma, and Gari D Clifford. Will Two Do? Varying Dimensions in Electrocardiography: The Phys-
ioNet/Computing in Cardiology Challenge 2021. In 2021 Computing in Cardiology (CinC), volume 48,
pages 1–4, Brno, Czech Republic, September 2021. IEEE. doi: 10.23919/CinC53138.2021.9662687.
[79] William L Romine, Noah L Schroeder, Josephine Graft, Fan Yang, Reza Sadeghi, Mahdieh Zabihi-
mayvan, Dipesh Kadariya, and Tanvi Banerjee. Using machine learning to train a wearable device
for measuring students cognitive load during problem-solving activities based on electrodermal activ-
ity, body temperature, and heart rate: Development of a cognitive load tracker for both personal and
classroom use. Sensors, 20(17):4833, 2020.
[80] Aaqib Saeed, Flora D. Salim, Tanir Ozcelebi, and Johan Lukkien. Federated Self-Supervised Learning
of Multisensor Representations for Embedded Intelligence. IEEE Internet of Things Journal, 8(2):
1030–1040, January 2021. ISSN 2327-4662. doi: 10.1109/JIOT.2020.3009358.
[81] Mithun Saha, Maxwell A. Xu, Wanting Mao, Sameer Neupane, James M. Rehg, and Santosh Kumar.
Pulse-PPG: An Open-Source Field-Trained PPG Foundation Model for Wearable Applications across
Lab and Field Settings. Proc. ACM Interact. Mob. Wearable Ubiquitous Technol., 9(3):126:1–126:35,
September 2025. doi: 10.1145/3749494.
[82] Philip Schmidt, Attila Reiss, Robert Duerichen, Claus Marberger, and Kristof Van Laerhoven. In-
troducing WESAD, a Multimodal Dataset for Wearable Stress and Affect Detection. In Proceedings
of the 20th ACM International Conference on Multimodal Interaction, ICMI ’18, pages 400–408, New
York, NY, USA, October 2018. Association for Computing Machinery. ISBN 978-1-4503-5692-3. doi:
10.1145/3242969.3242985.
[83] Christopher Slade, Yinan Sun, Wei Cheng Chao, Chih-Chun Chen, Roberto M. Benzo, and Peter
Washington. Current challenges and opportunities in active and passive data collection for mobile
health sensing: A scoping review. JAMIA open, 8(4):ooaf025, August 2025. ISSN 2574-2531. doi:
10.1093/jamiaopen/ooaf025.
21

A foundation model for electrodermal activity data
[84] JamiyanSukhbaatar, Satoshi Imamura, Ibuki Inoue, ShoyaMurakami, Kazi MahmudulHassan, Seung-
woo Han, Ingon Chanpornpakdi, and Toshihisa Tanaka. SingLEM: Single-Channel Large EEG Model,
September 2025.
[85] Henrik Svoren, Vajira Thambawita, Pål Halvorsen, Petter Jakobsen, Enrique Garcia-Ceja, Farzan Ma-
jeed Noori, Hugo L. Hammer, Mathias Lux, Michael Alexander Riegler, and Steven Alexander
Hicks. Toadstool: A dataset for training emotional intelligent machines playing Super Mario Bros.
In Proceedings of the 11th ACM Multimedia Systems Conference, MMSys ’20, pages 309–314, New
York, NY, USA, May 2020. Association for Computing Machinery. ISBN 978-1-4503-6845-2. doi:
10.1145/3339825.3394939.
[86] Mingxing Tan and Quoc Le. Efficientnet: Rethinking model scaling for convolutional neural networks.
InInternationalconferenceonmachinelearning,pages6105–6114,LongBeach,CA,USA,2019.PMLR,
PMLR.
[87] Andrés Tello, Victoria Degeler, and Alexander Lazovik. Too good to be true: Accuracy overestimation
in(re)currentpracticesforhumanactivityrecognition. In2024 IEEE International Conference on Per-
vasive Computing and Communications Workshops and Other Affiliated Events (PerCom Workshops),
pages 511–517, Biarritz, France, 2024. IEEE.
[88] James Truslow, Angela Spillane, Huiming Lin, Katherine Cyr, Adeeti Ullal, Edith Arnold, Ron Huang,
LauraRhodes,JenniferBlock,JamieStark,JamesKretlow,AlexisL.Beatty,AndreasWerdich,Deepali
Bankar, MattBianchi, IanShapiro, JaimeVillalpando, SharonRavindran, IridaMance, AdamPhillips,
John Earl, Rahul C. Deo, Sumbul A. Desai, and Calum A. MacRae. Understanding activity and
physiology at scale: The Apple Heart & Movement Study. npj Digital Medicine, 7(1):242, September
2024. ISSN 2398-6352. doi: 10.1038/s41746-024-01187-5.
[89] AaronvandenOord,YazheLi,andOriolVinyals. RepresentationLearningwithContrastivePredictive
Coding, January 2019.
[90] Yedukondala Rao Veeranki, Nagarajan Ganapathy, Ramakrishnan Swaminathan, and Hugo F. Posada-
Quintero. Comparison of Electrodermal Activity Signal Decomposition Techniques for Emotion Recog-
nition. IEEE Access, 12:19952–19966, 2024. ISSN 2169-3536. doi: 10.1109/ACCESS.2024.3361832.
[91] Miguel Viana-Matesanz and Carmen Sánchez-Ávila. Adaptive Normalization and Feature Extraction
for Electrodermal Activity Analysis. Mathematics, 12(2):202, January 2024. ISSN 2227-7390. doi:
10.3390/math12020202.
[92] KeWang, JiamuYang, AyushShetty, andJessilyn Dunn. DREAMT:Dataset forReal-timesleep stage
EstimAtion using Multisensor wearable Technology, 2024.
[93] Rongjie Yi, Ting Cao, Ao Zhou, Xiao Ma, Shangguang Wang, and Mengwei Xu. Boosting DNN Cold
Inference on Edge Devices. In Proceedings of the 21st Annual International Conference on Mobile
Systems, Applications and Services, MobiSys ’23, pages 516–529, New York, NY, USA, June 2023.
Association for Computing Machinery. ISBN 979-8-4007-0110-8. doi: 10.1145/3581791.3596842.
[94] Guo-Qiang Zhang, Licong Cui, Remo Mueller, Shiqiang Tao, Matthew Kim, Michael Rueschman, Sara
Mariani, Daniel Mobley, and Susan Redline. The National Sleep Research Resource: Towards a sleep
data commons. Journal of the American Medical Informatics Association, 25(10):1351–1358, October
2018. ISSN 1527-974X. doi: 10.1093/jamia/ocy064.
[95] Yuwei Zhang, Kumar Ayush, Siyuan Qiao, A. Ali Heydari, Girish Narayanswamy, Maxwell A. Xu,
Ahmed A. Metwally, Shawn Xu, Jake Garrison, Xuhai Xu, Tim Althoff, Yun Liu, Pushmeet Kohli,
Jiening Zhan, Mark Malhotra, Shwetak Patel, Cecilia Mascolo, Xin Liu, Daniel McDuff, and Yuzhe
Yang. SensorLM: Learning the Language of Wearable Sensors, June 2025.
22

|     |     |     |     |     | A   | foundation | model | for electrodermal | activity data |
| --- | --- | --- | --- | --- | --- | ---------- | ----- | ----------------- | ------------- |
Table A.1: Summary of datasets with their corresponding data-sharing agreements. This table includes all
datasets, including citations and the "Reshareable" column, for inclusion in the appendix.
| Dataset   | Name   |           |      | License |          |           |         |     |     |
| --------- | ------ | --------- | ---- | ------- | -------- | --------- | ------- | --- | --- |
| BiHeartS  | [3]    |           |      | 3- data | share    | agreement |         |     |     |
| BIG IDEAS | [11]   |           |      | 3- with | original | license   | (ODC-BY | 1)  |     |
| Dynamics  | in the | workplace | [61] | 3- data | share    | agreement |         |     |     |
3-
| EmpaticaE4Stress |     | [20] |     | (CCBY |     | 4) with original | license |     |     |
| ---------------- | --- | ---- | --- | ----- | --- | ---------------- | ------- | --- | --- |
3-
| EPM-E4    | [37] |     |     | (CCBY    |       | 4) with original | license |     |     |
| --------- | ---- | --- | --- | -------- | ----- | ---------------- | ------- | --- | --- |
| LAUREATE  | [55] |     |     | 3- data  | share | agreement        |         |     |     |
| MEFAR     | [28] |     |     | 3- (CCBY |       | 4) with original | license |     |     |
| M2Sleep   | [40] |     |     | 3- data  | share | agreement        |         |     |     |
| PPG-Dalia | [77] |     |     | 3- (CCBY |       | 4) with original | license |     |     |
3-
| SEED [29] |     |     |     | data | share | agreement |     |     |     |
| --------- | --- | --- | --- | ---- | ----- | --------- | --- | --- | --- |
3-
| SEED-II-Lab    | [29] |      |     | data     | share | agreement        |         |     |     |
| -------------- | ---- | ---- | --- | -------- | ----- | ---------------- | ------- | --- | --- |
| SEED-II-Wild   |      | [29] |     | 3- data  | share | agreement        |         |     |     |
| Stress Predict |      | [49] |     | 3- (MIT) | with  | original         | license |     |     |
| ToadStool      | [85] |      |     | 3- (CCBY |       | 4) with original | license |     |     |
3-
| WEEE | [41] |     |     | (CCBY |     | 4) with original | license |     |     |
| ---- | ---- | --- | --- | ----- | --- | ---------------- | ------- | --- | --- |
3-
| WESD      | [75] |     |     | with    | original | license   | (ODC-BY | 1)  |     |
| --------- | ---- | --- | --- | ------- | -------- | --------- | ------- | --- | --- |
| Workplace | [31] |     |     | 3- data | share    | agreement |         |     |     |
| APSync    | [38] |     |     | 3- data | share    | agreement |         |     |     |
| HeartS    | [2]  |     |     | 3- data | share    | agreement |         |     |     |
| USILaughs | [30] |     |     | 3- data | share    | agreement |         |     |     |
3-
| WESAD | [82] |     |     | (CCBY |     | 4) with original | license |     |     |
| ----- | ---- | --- | --- | ----- | --- | ---------------- | ------- | --- | --- |
3-
| Nurses’ | Stress | [48] |     | (ODbL |     | 1) with original | license |     |     |
| ------- | ------ | ---- | --- | ----- | --- | ---------------- | ------- | --- | --- |
DREAMT [92] 7- PhysioNet Restricted Health Data Use Agreement 1.5.0
| HHISS | [42] |     |     | 7- no | license | specified |     |     |     |
| ----- | ---- | --- | --- | ----- | ------- | --------- | --- | --- | --- |
A Methodology, Evaluation, Transparency, and Availability (META)
Appendix
| A.1 Additional |     | dataset | information |     |     |     |     |     |     |
| -------------- | --- | ------- | ----------- | --- | --- | --- | --- | --- | --- |
We report in Table A.1 information about the original license associated with the datasets making up the
EDAMAME collection. The datasets that we re-share are all under their original license, if so required. For
the datasets that require a data sharing agreement to be signed, we contacted the original authors, which
all agreed to for re-sharing under the conditions in the original data sharing agreement.
| A.2 Baseline |     | feature | sets |     |     |     |     |     |     |
| ------------ | --- | ------- | ---- | --- | --- | --- | --- | --- | --- |
Insection5.1weexplainhowweusetwohandcraftedfeaturesetsasbaselinetoevaluatetheembeddingsfrom
our UME foundation model. The first feature set, which we call generic handcrafted feature set, consists
of four statistics, i.e., mean, minimum, maximum and standard deviation, computed for both the phasic
and tonic EDA components, as well as the original non-decomposed EDA signal. This feature set emulates
baseline used by related work to evaluate foundation models for physiological data [1, 72]. The second
set of features, which we call EDA-specific handcrafted feature set, is a broader set of features commonly
used in EDA classification pipelines [4, 39]. In addition to the generic statistics, this set incorporates
signal dynamics (e.g., slopes and derivatives), morphological peak characteristics, and frequency-domain
components. This set consists of 15 base features, resulting in a total of 45 features per window (15 features
×
3 EDA components).
Table A.3 details the exact mathematical formulations for all 15 base features and specifies their inclusion
| in the respective |     | baseline | sets. |     |     |     |     |     |     |
| ----------------- | --- | -------- | ----- | --- | --- | --- | --- | --- | --- |
We report in Table A.2 the feature size of the feature extraction methods used in this work.
23

|     |     |     | A   | foundation | model | for electrodermal | activity data |
| --- | --- | --- | --- | ---------- | ----- | ----------------- | ------------- |
Table A.2: Overview of the models and feature sets used in the experimental evaluation. We report the
model size (number of trainable parameters) and the dimensionality of the feature space (d) used for linear
probing.
|     |     | Model        | / Feature Set | Model  | Size Feature | Dim. (d) |     |
| --- | --- | ------------ | ------------- | ------ | ------------ | -------- | --- |
|     |     | Handcrafted  | Methods       |        |              |          |     |
|     |     | Generic      | HC            | N/A    |              | 12       |     |
|     |     | EDA-specific | HC            | N/A    |              | 45       |     |
|     |     | Generalist   | Foundation    | Models |              |          |     |
|     |     | Mantis       | [35]          | ∼ 8    | M            | 768      |     |
∼
|     |     | Chronos | [8] | 200 | M   | 1536 |     |
| --- | --- | ------- | --- | --- | --- | ---- | --- |
∼
|     |     | MOMENT | [43] | 385 | M   | 1024 |     |
| --- | --- | ------ | ---- | --- | --- | ---- | --- |
Ours
∼
|                    |     | UME  |                  | 1          | M   | 64  |     |
| ------------------ | --- | ---- | ---------------- | ---------- | --- | --- | --- |
| A.3 Hyperparameter |     | grid | for the logistic | regression |     |     |     |
In Table A.4 we report the hyperparameter grid we used with the logistic regression. We used a 3-fold inner
cross-validationtosearchforthebestconfigurationofhyperparameterduringourfeatureevaluationthrough
linear probing.
| A.4 Training | details |     |     |     |     |     |     |
| ------------ | ------- | --- | --- | --- | --- | --- | --- |
We train the UME foundation model using the Adam optimizer [53] (learning rate 0.001 and weight decay
0.01). We also use a learning rate scheduler, Reduce On Plateau (factor 0.5), to decrease the learning rate
during training. We train the model for a maximum of 400 epochs, with early stopping, with a batch size of
GPU14.
512. In total, we train our model for approximately 5 days, using an Nvidia A6000 We implement
the foundation model in Python, using the Pytorch [71] and Pytorch-Lightning libraries.
| A.5 Data | augmentations |     | for EDA data |     |     |     |     |
| -------- | ------------- | --- | ------------ | --- | --- | --- | --- |
We report in Table A.5 the list of data augmentations used to train our UME foundation model with
contrastive learning. We use the same set proposed by Matton et al. [64], which contains EDA-specific
augmentations.
14https://www.nvidia.com/en-us/products/workstations/rtx-a6000/
24

|     |     |     |     |     | A foundation |     | model | for electrodermal |     | activity | data |
| --- | --- | --- | --- | --- | ------------ | --- | ----- | ----------------- | --- | -------- | ---- |
TableA.3: Mathematicalformulationsforthe15basehand-craftedfeaturesextractedfromEDAtimeseries
signals (x) of length N. All features are computed independently for the tonic, phasic, and original EDA
components. The "Feature Set(s)" column indicates whether the feature was used in the Generic baseline
| (12 total | features) | or the | EDA-specific | baseline     |     | (45 total | features). |     |     |         |        |
| --------- | --------- | ------ | ------------ | ------------ | --- | --------- | ---------- | --- | --- | ------- | ------ |
| Feature   |           |        |              | Mathematical |     | Notation  | or Formula |     |     | Feature | Set(s) |
Time-domain
P
| Mean    |     |     |     | 1     | N x           |     |     |     | Generic | & EDA-specific |     |
| ------- | --- | --- | --- | ----- | ------------- | --- | --- | --- | ------- | -------------- | --- |
|         |     |     |     | N     | i=1 i         |     |     |     |         |                |     |
| Minimum |     |     |     | min(x | ,x ,...,x     | )   |     |     | Generic | & EDA-specific |     |
|         |     |     |     |       | 1 2           | N   |     |     |         |                |     |
| Maximum |     |     |     | max(x | 1 ,x 2 ,...,x | N ) |     |     | Generic | & EDA-specific |     |
q
P
| Standard | Deviation |     |     |     | 1 N | (x −x¯)2 |     |     | Generic | & EDA-specific |     |
| -------- | --------- | --- | --- | --- | --- | -------- | --- | --- | ------- | -------------- | --- |
|          |           |     |     | N−1 | i=1 | i        |     |     |         |                |     |
Dynamic Range max(x ,x ,...,x )−min(x ,x ,...,x ) EDA-specific only
|     |     |     |     |     | 1 2 | N   | 1 2 | N   |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
xN −x1
| Slope |     |     |     |             |          |     |     |     | EDA-specific |     | only |
| ----- | --- | --- | --- | ----------- | -------- | --- | --- | --- | ------------ | --- | ---- |
|       |     |     |     | (cid:12)N−1 | (cid:12) |     |     |     |              |     |      |
|       |     |     |     | (cid:12)    | (cid:12) |     |     |     |              |     |      |
Absolute Value of Slope (cid:12)xN −x1(cid:12) EDA-specific only
N−1
P
| Mean of | the First | Derivative |     | 1    | N−1(x | −x    | )   |     | EDA-specific |     | only |
| ------- | --------- | ---------- | --- | ---- | ----- | ----- | --- | --- | ------------ | --- | ---- |
|         |           |            |     | qN−1 | i=1   | i+1 i |     |     |              |     |      |
P
N−1((x
Std. Dev. of the First Derivative 1 −x )−x¯′)2 EDA-specific only
|     |     |     |     | N−2 | i=1 | i+1 | i   |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Number of EDA Peaks Count of local maxima in the window EDA-specific only
Amplitude of EDA Peaks Mean amplitude of local maxima in the window EDA-specific only
| Frequency      | Domain | (Fast | Fourier | Transform) |     |     |     |     |              |     |      |
| -------------- | ------ | ----- | ------- | ---------- | --- | --- | --- | --- | ------------ | --- | ---- |
| Direct Current |        | (DC)  |         | X          |     |     |     |     | EDA-specific |     | only |
0
P
|        |           |              |     | N   | |X | |     |     |     |              |     |      |
| ------ | --------- | ------------ | --- | --- | ---- | --- | --- | --- | ------------ | --- | ---- |
| Sum of | Frequency | Coefficients |     |     | k    |     |     |     | EDA-specific |     | only |
k=1
P
| Information | Entropy |     |     | −   | N P(X | )log (P(X | ))  |     | EDA-specific |     | only |
| ----------- | ------- | --- | --- | --- | ----- | --------- | --- | --- | ------------ | --- | ---- |
|             |         |     |     |     | k=1   | k 2       | k   |     |              |     |      |
P
| Spectral | Energy |     |                | N                   | |X |2    |      |              |            | EDA-specific |     | only |
| -------- | ------ | --- | -------------- | ------------------- | -------- | ---- | ------------ | ---------- | ------------ | --- | ---- |
|          |        |     |                | k=1                 | k        |      |              |            |              |     |      |
|          |        |     | Table          | A.4: Hyperparameter |          | Grid | for Logistic | Regression |              |     |      |
|          |        |     | Hyperparameter |                     |          |      | Values       |            |              |     |      |
|          |        |     | Regularization |                     | strength | (C)  | 0.01,        | 0.1, 1, 10 |              |     |      |
|          |        |     | Solver         |                     |          |      | lbfgs,       | liblinear  |              |     |      |
|          |        |     | Penalty        |                     |          |      | L2           |            |              |     |      |
|          |        |     | Max            | iterations          |          |      | 10000        |            |              |     |      |
|          |        |     | Class          | weight              |          |      | balanced     |            |              |     |      |
25

A foundation model for electrodermal activity data
Table A.5: Summary of Electrodermal Activity (EDA) Data Augmentations used to train the UME founda-
tion model. The table details both EDA-specific transforms designed to isolate physiological components or
simulate artifacts, and generic time series transforms. The set is the same proposed by Matton et al. [64].
Augmentation Type Description Parameter Range
Frequency Domain & Component Isolation
Low-Pass Filter EDA-Specific Extracts tonic component; removes Cutoff f ∈[0.25,1.0] Hz
high-freq noise.
High-Pass Filter EDA-Specific Extracts phasic component; removes Cutoff f ∈[0.05,0.25] Hz
slow drifts.
Band-Pass Filter EDA-Specific Isolates information-rich EDA fre- Pass f ∈[0.05,0.25] Hz
quency bands.
Band-Stop Filter EDA-Specific Rejects specific frequency bands. Reject f ∈[0.75,1.0] Hz
High Freq. Noise EDA-Specific AddsGaussiannoiseonlytofrequencies Noise σ ∈[0,0.5]
>1Hz.
Artifact Simulation
Jump Artifact EDA-Specific Simulates abrupt sensor move- Jump ∈[0.01,0.2]µS
ment/displacement.
Loose Sensor EDA-Specific Simulates electrode contact loss (signal Duration t∈[5,20] s
drop).
Thermoregulation Simulation
Tonic Const. Scale EDA-Specific Scales tonic component (simulates con- Factor s∈[0.25,2]
stant temp).
Tonic Amp. Warp EDA-Specific Time-varying scale of tonic component Spline σ ∈[0.01,0.05]
(changing conditions).
Generic Time Series
Amp. Const. Scale Generic Applies constant scaling factor to the Factor s∈[0.25,2]
raw signal.
Amplitude Warp Generic Appliessmooth,time-varyingscalingto Spline σ ∈[0.01,0.05]
raw signal.
Gaussian Noise Generic AddsrandomGaussiannoisetotheraw σ ∈[0,0.5]
signal.
Time Shift Generic Shifts the signal window forward or Shift t∈[5,45] s
backward.
Temporal Cutout Generic Masks/zeroes out a random sub- Cutout t∈[5,15] s
window of the signal.
Time Warp Generic Perturbs temporal dimension (local Spline σ ∈[0.01,0.1]
stretch/compress).
Permutation Generic Slicessignalandrandomlyreorderssub- Segments n∈[2,6]
windows.
Signal Flip Generic Inverts the signal over its amplitude di- N/A
mension.
26

|               |     |        |            |      |         | A foundation |        | model          | for electrodermal | activity | data |
| ------------- | --- | ------ | ---------- | ---- | ------- | ------------ | ------ | -------------- | ----------------- | -------- | ---- |
|               |     | Figure |            | B.1: | Example | of EDA       | signal | reconstruction | using MAE.        |          |      |
| B Sensitivity |     | &      | additional |      | model   | studies      |        |                |                   |          |      |
WeperformsensitivityandadditionalstudiestofindtheconfigurationofourUMEfoundationmodel. Inthis
section, we report details for: implementation of an additional NN architecture, i.e., a Masked Autoencoder
(MAE); studies on model size and hyperparameters for the EfficientNet architecture chosen for the UME
| foundation | model, | trained | using | contrastive |     | learning. |     |     |     |     |     |
| ---------- | ------ | ------- | ----- | ----------- | --- | --------- | --- | --- | --- | --- | --- |
We perform all training in this section using a subset (about 15% of the total data) of the train part
of the EDAMAME collection of datasets. We do this to speed-up experimentation since, as reported in
subsection 4.3, the complete model training takes about 5 days in total with a single A6000 NVIDIA GPU,
| due to          | the large | scale of | the    | train | set.         |     |        |     |     |     |     |
| --------------- | --------- | -------- | ------ | ----- | ------------ | --- | ------ | --- | --- | --- | --- |
| B.1 Experiments |           | with     | Masked |       | Autoencoders |     | (MAEs) |     |     |     |     |
We train a reconstructive-based masked autoencoder (MAE), based on vision transformer (ViT) [34].
Narayanswamy et al. [68] also used a masked-autoencoder to train a foundation model for physiological
∈ RT×C
data. We train the model using the following loss: let x denote the input EDA signal, partitioned
intoN non-overlappingpatchesofsizeP, andletxˆ andx denotethereconstructedandoriginali-thpatch,
|     |     |     |     |     |     |     | i   | i   |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
respectively. Givenabinarymaskm∈{0,1}N,wherem =1indicatesamaskedpatchandm =0avisible
|          |                |     |      |            |      |        |         | i       |     | i   |     |
| -------- | -------------- | --- | ---- | ---------- | ---- | ------ | ------- | ------- | --- | --- | --- |
| one, the | reconstruction |     | loss | is defined | as   |        |         |         |     |     |     |
|          |                |     |      |            | L=αL |        | +(1−α)L |         |     |     |     |
|          |                |     |      |            |      |        |         |         | ,   |     | (2) |
|          |                |     |      |            |      | masked |         | visible |     |     |     |
with
XN
1
|     |     |     |     | L      |     | = P | m   | ℓ(xˆ ,x ), |     |     | (3) |
| --- | --- | --- | --- | ------ | --- | --- | --- | ---------- | --- | --- | --- |
|     |     |     |     | masked |     | m   |     | i i i      |     |     |     |
i
|     |     |     |     |     |     | i   | i=1 |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
XN
1
|     |     |     |     | L   |         | = P  |     | (1−m )ℓ(xˆ | ,x ), |     | (4) |
| --- | --- | --- | --- | --- | ------- | ---- | --- | ---------- | ----- | --- | --- |
|     |     |     |     |     | visible | (1−m | )   | i          | i i   |     |     |
i
|     |     |     |     |     |     | i   |     | i=1 |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
where ℓ(·,·) denotes either the mean absolute error (MAE) computed within each patch, and α ∈ [0,1]
controls the relative importance of masked versus visible patch reconstruction.
We experiment with the following configurations: m ∈ {0,0.1,0.4} and α ∈ {0.1,0.5}. In Figure B.2 we
report the validation loss during training curve for the configurations tested, and in Figure B.1 we show
an example of a signal reconstruction at train end, over a validation sample. We also perform downstream
evaluation on the BiHeartS dataset: however, no configuration leads to performance, in terms of balanced
| accuracy, | above | that of | the Dummy |     | classifier. |     |     |     |     |     |     |
| --------- | ----- | ------- | --------- | --- | ----------- | --- | --- | --- | --- | --- | --- |
Giventhesefindings,webelievethatmaskedautoencodersarenotoptimalforthespecificEDAdatapresent
| in the EDAMAME   |     | collection |     | of datasets. |     |     |     |     |     |     |     |
| ---------------- | --- | ---------- | --- | ------------ | --- | --- | --- | --- | --- | --- | --- |
| B.2 EfficientNet |     | ablation   |     | studies      |     |     |     |     |     |     |     |
We adopt an EfficientNet architecture for our UME foundation model, which we train using contrastive
learning on EDA data. We perform ablation studies using different configurations of hyperparameters,
which affect the model size. We compare the performance of the different models with respect to two
criteria: validation loss and performance on a selected set of downstream tasks. We leave about 10% of the
27

|     |     |     |     | A   | foundation | model | for electrodermal | activity data |
| --- | --- | --- | --- | --- | ---------- | ----- | ----------------- | ------------- |
Figure B.2: Validation loss during training for different configurations of masking and masking weight.
Train vs Val Loss by Kernel Size
5.5
5.0
4.5
Train (kernel=9)
4.0
|     |     | ssoL |     |     |     |     | Train (kernel=3) |     |
| --- | --- | ---- | --- | --- | --- | --- | ---------------- | --- |
Val (kernel=9)
3.5
Val (kernel=3)
3.0
2.5
2.0
|     |     |     | 0 10 | 20  | 30  | 40 50 | 60 70 |     |
| --- | --- | --- | ---- | --- | --- | ----- | ----- | --- |
Epoch
|     |     |     |     |     | Figure B.3: |     |     |     |
| --- | --- | --- | --- | --- | ----------- | --- | --- | --- |
train dataset for validation during training, to also stop the training using early stopping (patience set to
30). We acknowledge that this selection may introduce bias in reporting the final results.
We do not select all possible hyperparameters. In particular, we set as fixed the following: loss temperature
| τ =0.1 | (see loss definition | in  | Equation | 1); weights | dropout | at 50%. |     |     |
| ------ | -------------------- | --- | -------- | ----------- | ------- | ------- | --- | --- |
We perform the hyperparameter selection through multiple experiments. We list the experiments in order
| of which | we perform them. |     |     |     |     |     |     |     |
| -------- | ---------------- | --- | --- | --- | --- | --- | --- | --- |
Kernelsize Wecomparethefollowingkernelsizes: 9and3. Wechoose9sincethereactiontimeassociated
with EDA changes in approximately 2 seconds (9 samples with a sampling rate of 4 Hz is about 2.25 s) [15];
we choose 3 since the minimum rise time of an EDA signal is between 0.25s and 0.5 s [39].
We report in Figure B.3 the train and validation loss. We notice how the loss depends on the set in which
it is computed, hence it cannot be directly compared between train and validation; however, given the same
set and two models, the comparison can be performed, since we made sure to use the same splits for all
| experiments. | Given these | results, | we select | a kernel | size | of 3. |     |     |
| ------------ | ----------- | -------- | --------- | -------- | ---- | ----- | --- | --- |
Model size The second set of experiments are related to the model size. In order to determine the size of
themodel,wemodifythefollowinghyperparameters: thestemchannels[64,32],thenumberofconvolutional
channels [8, 16, 32, 64, 92], the total number of convolutional blocks [2, 4, 8, 12, 16]; the head channels [32,
| 64]; and | the final embeddings |     | dimensionality | [32, | 64]. |     |     |     |
| -------- | -------------------- | --- | -------------- | ---- | ---- | --- | --- | --- |
28

|     |     | A foundation | model | for electrodermal | activity data |
| --- | --- | ------------ | ----- | ----------------- | ------------- |
(a) Train loss for different model sizes (b) Validation loss for different model sizes
WereportthetrainandvallossesinFigureB.4aandFigureB.4brespectively. Fromthecomparisonbetween
thetrainandvallosses, weconcludethatthereisanimpact, inlearningrepresentation, fromthemodelsize.
| However, after | about 1M parameters, | the validation | loss remains | similar. |     |
| -------------- | -------------------- | -------------- | ------------ | -------- | --- |
We select a model with about 1M parameters for our final training. The model contains the following
parameters:
| • stem      | channels: 64      |     |     |     |     |
| ----------- | ----------------- | --- | --- | --- | --- |
| • mbconv    | channels: 64      |     |     |     |     |
| • num       | mbconv blocks: 16 |     |     |     |     |
| • head      | channels: 248     |     |     |     |     |
| • embedding | dim: 64           |     |     |     |     |
| • kernel    | size: 9           |     |     |     |     |
29

|              |              |            | A               | foundation | model      | for | electrodermal |           | activity data |
| ------------ | ------------ | ---------- | --------------- | ---------- | ---------- | --- | ------------- | --------- | ------------- |
|              |              | Table C.1: | CPU Performance |            | Comparison | of  | Extractors    |           |               |
|              | Extractor    |            | CPU Time        | (mean)     | [ms]       | CPU | Time          | (SE) [ms] |               |
|              | MOMENT       | (128M)     |                 |            | 4823.53    |     |               | 161.11    |               |
|              | Chronos      | (28M)      |                 |            | 721.34     |     |               | 28.91     |               |
|              | Mantis       | (8M)       |                 |            | 350.23     |     |               | 39.06     |               |
|              | UME          | (1M)       |                 |            | 184.56     |     |               | 3.12      |               |
|              | EDA-specific | hc         |                 |            | 35.39      |     |               | 1.40      |               |
|              | generic      | hc         |                 |            | 0.09       |     |               | 0.01      |               |
| C Additional |              | results    |                 |            |            |     |               |           |               |
Computational analysis complexity We report in Table C.1 the detailed performance metrics for the
| computation | complexity | analysis. | This table mirrors |     | the results | in Figure | 6.  |     |     |
| ----------- | ---------- | --------- | ------------------ | --- | ----------- | --------- | --- | --- | --- |
Complete results for the downstream evaluation WereportinTableC.2andTableC.3thecomplete
results for our experimental evaluation. Specifically, we report the results in terms of balanced accuracy,
Matthew’s Correlation Coefficient (MCC) [24] and F1-score. We report the results for both validation
methods used, i.e., LOPO and TA cross-validations. Results are reported for all tasks in both validation
methods. FortheTAcross-validation,wedonotreporttheresultsforcognitive-load/relaxation classification
on the USILaughs dataset [30], since there was not enough data for each user to perform the temporal split.
30

|     |     |     | A foundation | model for | electrodermal | activity data |
| --- | --- | --- | ------------ | --------- | ------------- | ------------- |
Table C.2: Results of binary classification experiments, using the Leave One Participant Out (LOPO) cross-
| validation. | Results shown | as metric | ± standard error. |     |     |     |
| ----------- | ------------- | --------- | ----------------- | --- | --- | --- |
Metrics
| Dataset | Binary | Task | Model |           |            |           |
| ------- | ------ | ---- | ----- | --------- | ---------- | --------- |
|         |        |      |       | Balanced  | Acc. MCC   | F1        |
|         |        |      |       | 0.73±0.05 | −0.01±0.01 | 0.16±0.06 |
Dummy
|     |     |     |     | 0.64±0.07 | 0.00±0.03 | 0.10±0.06 |
| --- | --- | --- | --- | --------- | --------- | --------- |
Gen. HC
|        |      |           |              | 0.54±0.05 | 0.02±0.03 | 0.19±0.07 |
| ------ | ---- | --------- | ------------ | --------- | --------- | --------- |
|        |      |           | EDA-spec. HC |           |           |           |
| Dreamt | Deep | Sleep/REM |              | 0.59±0.05 | 0.02±0.04 | 0.18±0.07 |
Mantis
|     |     |     |     | 0.64±0.03 | 0.06±0.03 | 0.21±0.07 |
| --- | --- | --- | --- | --------- | --------- | --------- |
MOMENT
|     |     |     |     | 0.64±0.04 | 0.03±0.03 | 0.19±0.07 |
| --- | --- | --- | --- | --------- | --------- | --------- |
Chronos
|     |     |     |     | 0.56±0.05 | 0.04±0.04 | 0.17±0.06 |
| --- | --- | --- | --- | --------- | --------- | --------- |
UME
|     |     |     |     | 0.50±0.00 | 0.00±0.00 | 0.49±0.01 |
| --- | --- | --- | --- | --------- | --------- | --------- |
Dummy
|     |     |     |     | 0.70±0.03 | 0.40±0.05 | 0.68±0.04 |
| --- | --- | --- | --- | --------- | --------- | --------- |
Gen. HC
|        |            |     |              | 0.74±0.02 | 0.48±0.04 | 0.72±0.03 |
| ------ | ---------- | --- | ------------ | --------- | --------- | --------- |
|        |            |     | EDA-spec. HC |           |           |           |
| Dreamt | Sleep/Wake |     |              | 0.77±0.02 | 0.52±0.04 | 0.74±0.03 |
Mantis
|     |     |     |     | 0.72±0.02 | 0.44±0.03 | 0.71±0.03 |
| --- | --- | --- | --- | --------- | --------- | --------- |
MOMENT
|     |     |     |     | 0.78±0.02 | 0.55±0.03 | 0.75±0.03 |
| --- | --- | --- | --- | --------- | --------- | --------- |
Chronos
|     |     |     |     | 0.75±0.02 | 0.50±0.04 | 0.73±0.03 |
| --- | --- | --- | --- | --------- | --------- | --------- |
UME
|     |     |     |     | 0.50±0.00 | −0.00±0.01 | 0.24±0.03 |
| --- | --- | --- | --- | --------- | ---------- | --------- |
Dummy
|     |     |     |     | 0.56±0.03 | 0.12±0.07 | 0.44±0.06 |
| --- | --- | --- | --- | --------- | --------- | --------- |
Gen. HC
|       |             |     |              | 0.64±0.03 | 0.28±0.07 | 0.55±0.04 |
| ----- | ----------- | --- | ------------ | --------- | --------- | --------- |
|       |             |     | EDA-spec. HC |           |           |           |
| HHISS | Stress/calm |     |              | 0.63±0.03 | 0.26±0.06 | 0.53±0.04 |
Mantis
|     |     |     |     | 0.55±0.02 | 0.09±0.05 | 0.44±0.03 |
| --- | --- | --- | --- | --------- | --------- | --------- |
MOMENT
|     |     |     |     | 0.59±0.03 | 0.17±0.06 | 0.48±0.04 |
| --- | --- | --- | --- | --------- | --------- | --------- |
Chronos
|     |     |     |     | 0.59±0.03 | 0.19±0.06 | 0.49±0.05 |
| --- | --- | --- | --- | --------- | --------- | --------- |
UME
|     |     |     |     | 0.50±0.00 | 0.00±0.00 | 0.08±0.02 |
| --- | --- | --- | --- | --------- | --------- | --------- |
Dummy
|     |     |     |     | 0.66±0.09 | 0.28±0.16 | 0.32±0.11 |
| --- | --- | --- | --- | --------- | --------- | --------- |
Gen. HC
|        |            |     |              | 0.70±0.05 | 0.32±0.13 | 0.36±0.11 |
| ------ | ---------- | --- | ------------ | --------- | --------- | --------- |
|        |            |     | EDA-spec. HC |           |           |           |
| HeartS | Sleep/Wake |     |              | 0.74±0.06 | 0.37±0.14 | 0.41±0.13 |
Mantis
|     |     |     |     | 0.70±0.04 | 0.27±0.06 | 0.33±0.09 |
| --- | --- | --- | --- | --------- | --------- | --------- |
MOMENT
|     |     |     |     | 0.73±0.06 | 0.34±0.11 | 0.39±0.12 |
| --- | --- | --- | --- | --------- | --------- | --------- |
Chronos
|     |     |     |     | 0.71±0.06 | 0.30±0.10 | 0.35±0.10 |
| --- | --- | --- | --- | --------- | --------- | --------- |
UME
|     |     |     |     | 0.58±0.05 | −0.02±0.03 | 0.05±0.03 |
| --- | --- | --- | --- | --------- | ---------- | --------- |
Dummy
|     |     |     |     | 0.61±0.09 | 0.10±0.14 | 0.26±0.13 |
| --- | --- | --- | --- | --------- | --------- | --------- |
Gen. HC
|       |          |         |              | 0.63±0.08 | 0.13±0.11 | 0.33±0.13 |
| ----- | -------- | ------- | ------------ | --------- | --------- | --------- |
|       |          |         | EDA-spec. HC |           |           |           |
| WESAD | Low/High | Arousal |              | 0.56±0.08 | 0.06±0.13 | 0.27±0.14 |
Mantis
|     |     |     |     | 0.51±0.06 | 0.03±0.10 | 0.22±0.12 |
| --- | --- | --- | --- | --------- | --------- | --------- |
MOMENT
|     |     |     |     | 0.56±0.09 | 0.07±0.14 | 0.28±0.10 |
| --- | --- | --- | --- | --------- | --------- | --------- |
Chronos
|     |     |     |     | 0.58±0.09 | 0.03±0.13 | 0.26±0.12 |
| --- | --- | --- | --- | --------- | --------- | --------- |
UME
|     |     |     |     | 0.51±0.06 | 0.07±0.07 | 0.80±0.10 |
| --- | --- | --- | --- | --------- | --------- | --------- |
Dummy
|     |     |     |     | 0.55±0.15 | 0.01±0.17 | 0.66±0.18 |
| --- | --- | --- | --- | --------- | --------- | --------- |
Gen. HC
|           |          |            |              | 0.58±0.13 | 0.10±0.13  | 0.72±0.17 |
| --------- | -------- | ---------- | ------------ | --------- | ---------- | --------- |
| WESAD     | Low/High | Valence    | EDA-spec. HC |           |            |           |
|           |          |            | Mantis       | 0.55±0.13 | 0.07±0.16  | 0.76±0.16 |
|           |          |            | MOMENT       | 0.63±0.07 | 0.03±0.07  | 0.76±0.14 |
|           |          |            | Chronos      | 0.56±0.10 | 0.05±0.11  | 0.77±0.15 |
|           |          |            | UME          | 0.59±0.13 | 0.08±0.12  | 0.77±0.13 |
|           |          |            | Dummy        | 0.46±0.06 | −0.09±0.11 | 0.29±0.16 |
|           |          |            | Gen. HC      | 0.61±0.13 | 0.14±0.25  | 0.53±0.26 |
|           |          |            | EDA-spec. HC | 0.63±0.16 | 0.18±0.31  | 0.52±0.27 |
| APSYNC    | Low/High | engagement |              |           |            |           |
|           |          |            | Mantis       | 0.62±0.11 | 0.30±0.19  | 0.48±0.29 |
|           |          |            | MOMENT       | 0.60±0.20 | 0.24±0.39  | 0.61±0.21 |
|           |          |            | Chronos      | 0.48±0.16 | −0.02±0.31 | 0.43±0.25 |
|           |          |            | UME          | 0.54±0.13 | 0.10±0.29  | 0.49±0.30 |
|           |          |            | Dummy        | 0.50±0.00 | 0.00±0.00  | 0.80±0.00 |
|           |          |            | Gen. HC      | 0.66±0.06 | 0.32±0.13  | 0.72±0.04 |
|           |          |            | EDA-spec. HC | 0.70±0.09 | 0.40±0.19  | 0.70±0.11 |
| USILaughs | Cog.     | load/relax |              |           |            |           |
|           |          |            | Mantis       | 0.72±0.09 | 0.43±0.19  | 0.76±0.10 |
|           |          |            | MOMENT       | 0.60±0.09 | 0.20±0.18  | 0.61±0.11 |
|           |          |            | Chronos      | 0.68±0.07 | 0.35±0.14  | 0.57±0.12 |
|           |          |            | UME          | 0.71±0.11 | 0.42±0.22  | 0.76±0.10 |
31

|     |     | A foundation | model for | electrodermal | activity data |
| --- | --- | ------------ | --------- | ------------- | ------------- |
TableC.3: ResultsofbinaryclassificationexperimentsforTime-Aware(TA)cross-validation. Resultsshown
as metric ± standard error. Experiments whose result is reported as OoM (out of memory) means that
the required memory size for the embeddings computation exceeded the computational resources available.
Metrics
| Dataset | Binary Task         | Model        |           |            |           |
| ------- | ------------------- | ------------ | --------- | ---------- | --------- |
|         |                     |              | Balanced  | Acc. MCC   | F1        |
|         |                     | Dummy        | 0.51±0.01 | 0.01±0.01  | 0.20±0.06 |
|         |                     | Gen. HC      | 0.55±0.10 | 0.09±0.20  | 0.28±0.13 |
|         |                     | EDA-spec. HC | 0.59±0.08 | 0.16±0.13  | 0.37±0.13 |
| Dreamt  | Deep Sleep/REM      |              |           |            |           |
|         |                     | Mantis       | 0.64±0.07 | 0.22±0.11  | 0.40±0.12 |
|         |                     | MOMENT       | 0.65±0.04 | 0.24±0.07  | 0.42±0.10 |
|         |                     | Chronos      | 0.64±0.04 | 0.23±0.08  | 0.41±0.10 |
|         |                     | UME          | 0.63±0.09 | 0.20±0.13  | 0.38±0.11 |
|         |                     | Dummy        | 0.50±0.01 | −0.01±0.01 | 0.58±0.04 |
|         |                     | Gen. HC      | 0.65±0.04 | 0.32±0.11  | 0.69±0.06 |
|         |                     | EDA-spec. HC | 0.69±0.01 | 0.38±0.03  | 0.72±0.02 |
| Dreamt  | Sleep/Wake          |              |           |            |           |
|         |                     | Mantis       | 0.73±0.02 | 0.46±0.03  | 0.76±0.02 |
|         |                     | MOMENT       | 0.69±0.01 | 0.39±0.02  | 0.72±0.01 |
|         |                     | Chronos      | 0.73±0.01 | 0.47±0.02  | 0.76±0.01 |
|         |                     | UME          | 0.70±0.02 | 0.41±0.03  | 0.74±0.02 |
|         |                     | Dummy        | 0.50±0.00 | −0.00±0.00 | 0.23±0.09 |
|         |                     | Gen. HC      | 0.45±0.04 | −0.10±0.07 | 0.34±0.04 |
|         |                     | EDA-spec. HC | 0.55±0.05 | 0.09±0.11  | 0.45±0.07 |
| HHISS   | Stress/calm         |              |           |            |           |
|         |                     | Mantis       | 0.51±0.02 | 0.20±0.03  | 0.50±0.03 |
|         |                     | MOMENT       | OoM       | OoM        | OoM       |
|         |                     | Chronos      | OoM       | OoM        | OoM       |
|         |                     | UME          | 0.49±0.06 | −0.02±0.12 | 0.38±0.07 |
|         |                     | Dummy        | 0.49±0.00 | −0.01±0.01 | 0.08±0.02 |
|         |                     | Gen. HC      | 0.71±0.06 | 0.35±0.11  | 0.39±0.08 |
|         |                     | EDA-spec. HC | 0.72±0.14 | 0.36±0.25  | 0.41±0.20 |
| HeartS  | Sleep/Wake          |              |           |            |           |
|         |                     | Mantis       | 0.75±0.16 | 0.40±0.28  | 0.45±0.23 |
|         |                     | MOMENT       | 0.69±0.12 | 0.24±0.16  | 0.31±0.12 |
|         |                     | Chronos      | 0.74±0.13 | 0.35±0.21  | 0.40±0.19 |
|         |                     | UME          | 0.73±0.17 | 0.32±0.25  | 0.38±0.18 |
|         |                     | Dummy        | 0.55±0.05 | 0.08±0.07  | 0.15±0.07 |
|         |                     | Gen. HC      | 0.56±0.15 | 0.08±0.22  | 0.26±0.11 |
|         |                     | EDA-spec. HC | 0.59±0.20 | 0.08±0.31  | 0.32±0.14 |
| WESAD   | Low/High Arousal    |              |           |            |           |
|         |                     | Mantis       | 0.58±0.11 | 0.13±0.19  | 0.32±0.13 |
|         |                     | MOMENT       | OoM       | OoM        | OoM       |
|         |                     | Chronos      | 0.56±0.18 | 0.07±0.28  | 0.28±0.20 |
|         |                     | UME          | 0.56±0.12 | 0.08±0.18  | 0.28±0.15 |
|         |                     | Dummy        | 0.51±0.03 | 0.01±0.04  | 0.66±0.06 |
|         |                     | Gen. HC      | 0.54±0.20 | 0.08±0.33  | 0.76±0.12 |
|         |                     | EDA-spec. HC | 0.54±0.19 | 0.04±0.30  | 0.62±0.22 |
| WESAD   | Low/High Valence    |              |           |            |           |
|         |                     | Mantis       | 0.61±0.08 | 0.18±0.13  | 0.71±0.13 |
|         |                     | MOMENT       | OoM       | OoM        | OoM       |
|         |                     | Chronos      | 0.45±0.12 | −0.10±0.20 | 0.59±0.21 |
|         |                     | UME          | 0.63±0.13 | 0.18±0.18  | 0.73±0.13 |
|         |                     | Dummy        | 0.45±0.20 | 0.13±0.13  | 0.13±0.13 |
|         |                     | Gen. HC      | 0.81±0.20 | 0.32±0.32  | 0.72±0.29 |
|         |                     | EDA-spec. HC | 0.81±0.20 | 0.32±0.32  | 0.72±0.29 |
| APSYNC  | Low/High engagement |              |           |            |           |
|         |                     | Mantis       | 0.86±0.15 | 0.41±0.43  | 0.82±0.19 |
|         |                     | MOMENT       | 0.48±0.32 | −0.05±0.10 | 0.33±0.30 |
|         |                     | Chronos      | 0.61±0.40 | 0.18±0.86  | 0.70±0.32 |
|         |                     | UME          | 0.89±0.22 | 0.49±0.57  | 0.83±0.33 |
32
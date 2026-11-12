3202
nuJ
21
]VC.sc[
1v68170.6032:viXra
JOURNALOFLATEXCLASSFILES,VOL.18,NO.9,SEPTEMBER2020 1
CD-CTFM: A Lightweight CNN-Transformer
Network for Remote Sensing Cloud Detection
Fusing Multiscale Features
Wenxuan Ge, Xubing Yang, Li Zhang
Abstract—Clouds in remote sensing images inevitably affect tree, support vector machine, and Bayesian classification,
information extraction, which hinder the following analysis of identifycloudby learningfromtrainingdata, whichimproves
satellite images. Hence, cloud detection is a necessary prepro-
the performance of cloud detection [2]. However, machine-
cessingprocedure.However,theexistingmethodshavenumerous
learning-based methods are highly affected by the hand-craft calculations and parameters. In this letter, a lightweight CNN-
Transformer network, CD-CTFM, is proposed to solve the features, which is highly dependenton expert knowledge and
problem. CD-CTFM is based on encoder-decoder architecture experience.
and incorporates the attention mechanism. In the decoder part,
weutilizealightweightnetworkcombingCNNandTransformer
as backbone, which is conducive to extract local and global
With the advance in deep learning, methods based on
featuressimultaneously.Moreover,alightweightfeaturepyramid
module is designed to fuse multiscale features with contextual convolutional neural networks have achieved great success in
information. In the decoder part, we integrate a lightweight thefieldofcomputervision,overwhelminglysurpassingtradi-
channel-spatial attention module into each skip connection be- tional algorithms [4]. Scholars have applied deep learning to
tween encoder and decoder, extracting low-level features while
optical satellite imagery, including cloud detection. Francis et
suppressing irrelevant information without introducing many
al.proposedCloudFCN,whichisbasedonfullyconvolutional
parameters. Finally, the proposed model is evaluated on two
cloud datasets, 38-Cloud and MODIS. The results demonstrate networks, to extract multiscale spectral features of remote
thatCD-CTFMachievescomparableaccuracyasthestate-of-art sensingimages[5].Moreover,theattentionmechanismwasin-
methods. At the same time, CD-CTFM outperforms state-of-art corporatedtoimproveaccuracy[6],[7].However,thesecloud
methods in terms of efficiency.
detection methods have a large number of parameters and
Index Terms—lightweight network, cloud detection, vision computations.To alleviate this problem,Yao et al. designeda
transformer, attention mechanism, deep learning. light-weightchannelattentionmodulein their CD-AttDLV3+,
which was based on DeepLabV3+ architecture, to strengthen
the learning of significant channels and reduce computations
I. INTRODUCTION
[8]. However, there are still two problems in these cloud
REMOTE sensing images collected from satellites are
detection methods. On the one hand, existing methods only
widely used in various fields, including land cover
utilize the stack of convolutionallayers to obtain local spatial
mapping, weather forecasting, and other fields [1]. However,
features, ignoring global semantic information of image. On
opticalremotesensingimagesareinevitablyaffectedbycloud
theotherhand,existingmodelswithattentionmechanismstill
appearing on them, resulting in attenuation or loss of image
have much room for improvement in both performance and
information. Therefore, to improve the utilization of images
efficiency.
with cloud, it is necessary to detect cloud before analyzing
images.
Over the years, researchers have proposed a multitude
In this letter, we propose a lightweight encoder-decoder
of approaches from different perspectives. Traditional cloud
architecture with attention mechanism, CD-CTFM, for cloud
detection methods can be broadly divided into two cate-
detection. To summarize, the main contributions of this work
gories, threshold-based and machine-learning-based methods.
arelistedasfollows:1)CD-CTFMutilizesalightweightCNN-
Threshold-based methods are implemented using a threshold
Transformer network as backbone. Compared to traditional
of different image parameters [2]. Among threshold-based
ConvolutionalNeuralNetwork(CNN),CNN-Transformernet-
algorithms, the Function of mask (Fmask) is a widely used
work can extract both local and global features, which is
cloud detection approach [3]. But threshold-based methods
conducivetoimproveaccuracyandreducecomputations.2)A
have poor universality in that thresholds vary as per the
lightweightfeaturepyramidmoduleenablesCD-CTFMtofuse
location. Machine-learning-based methods, such as decision
multiscalefeatureswithglobalfeatures.3)CD-CTFMdesigns
a lightweight channel-spatial attention module to suppress
Wenxuan Ge, Xubing Yang, Li Zhang are with the College of Informa-
tion Science and Technology, Nanjing 210037, China (gwx@njfu.edu.cn, invalid information and highlight discriminative features in a
xbyang@njfu.edu.cn, lizhang@njfu.edu.cn) lightweight way. Finally, two cloud datasets, 38-Cloud and
This work is supported by Innovation and Entrepreneurship Training
MODIS, were used to to validate the effectiveness of our
Program for college students in Jiangsu Province(No. 202210298120Y).
(Corresponding author: LiZhang.) proposed model.

JOURNALOFLATEXCLASSFILES,VOL.18,NO.9,SEPTEMBER2020 2
Fig. 1. Overall framework of CD-CTFM. The encoder contains a lightweight backbone and LWFPM while the decoder is based on depthwise separable
| convolutions     | (DSC).TheLWAMfiltersinformation |       |           | propagated | throughtheskipconnections. |                     |            |     |     |     |
| ---------------- | ------------------------------- | ----- | --------- | ---------- | -------------------------- | ------------------- | ---------- | --- | --- | --- |
| H ×W             | ×C1 H ×W                        | ×C2   | H ×W      | ×C3        | H ×W ×C4                   |                     |            |     |     |     |
| 2                | 2 4                             | 4     | 8         | 8          | 1 6 16                     |                     |            |     |     |     |
|                  | L=2                             |       | L=2       | L=4        |                            |                     |            |     |     |     |
|                  | MF                              | MF    |           | MF         |                            |                     |            |     |     |     |
|                  | Block                           | Block |           | Block      |                            |                     |            |     |     |     |
| Fig.2. Thedetail | ofthelightweight                |       | backbone. |            |                            |                     |            |     |     |     |
|                  |                                 |       |           |            |                            | Fig.3. Thestructure | ofSDblock. |     |     |     |
II. METHODOLOGY Followed by the backbone is the lightweight feature pyramid
A. Overview of CD-CTFM module (LWFPM), fusing high-level multiscale features with
|     |     |     |     |     |     | global interaction | information. |     | In the decoder | part, deep fea- |
| --- | --- | --- | --- | --- | --- | ------------------ | ------------ | --- | -------------- | --------------- |
TheCD-CTFMexploitstheencoder-decoderarchitecture,as
|          |               |         |       |           |               | turescomingfromLWFPM |     | are | up-sampledlayerbylayer.To |     |
| -------- | ------------- | ------- | ----- | --------- | ------------- | -------------------- | --- | --- | ------------------------- | --- |
| shown in | Fig 1. In the | encoder | part, | we deploy | a hybrid net- |                      |     |     |                           |     |
compensatefortheattenuatedorlostlow-levelfeatures,wein-
workofCNNandTransformerasbackbone,asshowninFig2,
|          |                        |     |       |      |                 | troduce | skip connectionand | integrated | a lightweightchannel- |     |
| -------- | ---------------------- | --- | ----- | ---- | --------------- | ------- | ------------------ | ---------- | --------------------- | --- |
| which is | based on Mobile-Former |     | block | [9]. | A convolutional |         |                    |            |                       |     |
3×3 spatial attention module (LWAM) into each skip connection,
| layer with | kernel     | size        | is first | adopted    | in the backbone |                |            |           |             |               |
| ---------- | ---------- | ----------- | -------- | ---------- | --------------- | -------------- | ---------- | --------- | ----------- | ------------- |
|            |            |             |          |            |                 | which suppress | irrelevant | low-level | information | and highlight |
| to adjust  | the number | of channels | and      | downsample | the feature     |                |            |           |             |               |
maps. Then the feature maps are forwarded to a sequence of discriminative features.
| Mobile-Former | block, | which | contains | four | parts. The Mobile |     |     |     |     |     |
| ------------- | ------ | ----- | -------- | ---- | ----------------- | --- | --- | --- | --- | --- |
sub-block consists of a bottleneck block, and the former sub- B. Lightweight Feature Pyramid Module (LWFPM)
blockisthe stackingof multi-headattentionandfeed-forward Tofurtherextractfeaturespropagatedthroughbackbone,we
network. Besides, Mobile2Former and Former2Mobile are designed LWFPM, which consists of five parallel paths (see
lightweight cross attention gates utilized to forward local and Fig1).Exceptforoneglobalaveragepooling(GAP)pathand
global features. In the backbone, local spatial features and one pointwise convolution (PW) path, the rest of the paths
global context information are extracted simultaneously and all consist of a novel shared and dilation block (SDblock), of
fused bidirectionally, resulting in more representation power. whichthe dilatedrate is6,12,and18,respectively.Asshown

JOURNALOFLATEXCLASSFILES,VOL.18,NO.9,SEPTEMBER2020 3
The 38-Cloud dataset is first released in [13]. The dataset
contains 18 LandSat-8 images for training and 20 images
for testing. Due to the large size of images, it is difficult to
directly use theses images as inputs. Therefore, each image
is cropped into 384 × 384 non-overlapping patches. After
cropping,the trainingsetcontains8400patcheswhile the test
set contains 9201 patches. Each patch has 4 corresponding
spectral channels: Red (band 4), Green (band 3), Blue (band
2), and Near Infrared (band 5).
MODIS dataset contains 1422 remote sensing images,
which are separated into 1272 training images and 150 test
images [14]. After cropping them into 512 x 512 patches,
the training set and test set contain 19080 and 2250 non-
overlapping patches, respectively. Each patch consists of ten
spectralchannels:band1, 3,4,18,20,23,28,29,31,and32.
2) EvaluationMetrics: Intheexperiment,thegroundtruths
and prediction results are divided into cloud and non-cloud
classes at pixel level. The performance of CD-CTFM is eval-
Fig.4. Thedetail ofLightweight Channel-Spatial Attention Module
uatedbyfivequantitativemetrics,includingmeanintersection-
over-union (mIoU), precision, recall, F1-score, and overall
inFig 3,SDblock,basedonresidualstructure,containsa PW, accuracy (OA). These metrics are defined as follows:
a shared convolution (SC) and a dilated convolution (DC).
TP
The effect of the PW is dimensionality reduction while the mIoU= (1)
TP + FN + FP
purpose of SC is deep features extraction, both of which are
TP
conducive to decrease parameters and computations. To fuse Precision= (2)
TP + FP
high-levelmultiscalefeatureswithcontextinformation,dilated TP
convolutions with different dilated rate are added. Inspired Recall= (3)
TP + FN
by ESPNet [10], LWFPM deploys hierarchical feature fusion 2×TP
F1-score= (4)
to solve the gridding effect caused by dilated convolutions 2×TP + FP + FN
without introducing extra parameters. TP + TN
OA= (5)
TP + TN + FP + FN
C. Lightweight Channel-Spatial Attention Module (LWAM) where TP, TN, FP, and FN represent the total number of
true positive, true negative, false positive and false negative
By the skip connections, CD-CTFM has more information
pixels,respectively.Besides, we utilizetwo metrics,including
to detect cloud. However, some feature channels contains too
giga floating-point operations per second (GFLOPS) and the
much invalid or irrelevant information, affecting the accuracy
number of model parameters, to measure the efficiency of
of the model. Similarly, in each feature map, each pixel
models.
contributes differently to the semantic segmentation task. To
3) Implementation Details: Our experiments are based on
alleviate this problem, a lightweight channel-spatial attention
the Pytorch framework and Ubuntu 20.04 equipped with an
module is proposed, which is based on channel attention
NVIDIA 3090 24G GPU. All models are optimized by the
module (CAM) and spatial attention module (SAM) [11]. As
stochastic gradient descent (SGD) algorithm and the learning
shown in Fig 4, the CAM and SAM are cascaded directly.
ratedecaysfrom0.001to 0.Besides, thebatchsizes, momen-
In CAM, the input feature maps are processed by using LP
tum, and epochs are 32, 0.9, and 50, respectively.
pooling [12]. In this letter, the number of pooling layers and
thep-valueofeachpathissetas2,1,and2.Afterthepooling
operations, we forward both feature maps to a shared multi- B. Ablation Studies
layer perceptrons (MLP), generating the attention map. Then In this section, we utilize 38-Cloud dataset to verify the
the feature maps are summed at the element level. Similarly, effectiveness of the key modules in CD-CTFM, which are
the input feature maps are pooled in the same way as CAM. LWFPM and LWAM. To begin with, we train and test the
Then the outputs of pooling operations are concatenated, CD-CTFM without LWFPM and LWAM in order to eval-
followed by a convolution layer with 3×3 kernel size. uate the performance and efficiency of backbone. Subse-
quently,weconductedexperimentsonbackbonewithLWFPM
III. EXPERIMENTS ANDRESULTS and LWAM, respectively. In particular, in backbone+LWFPM
method, the low-level feature maps from encoder are sent
A. Experimental Settings
directly to decoder. Also, in backbone+LWAM method, the
1) Datasets: To train and test the CD-CTFM, we conduct LWFPMmoduleisreplacedwithapointwiseconvolution.Ta-
experiments on two cloud detection datasets: 38-Cloud and ble I shows the performanceand efficiency of CD-CTFM un-
MODIS datasets. derdifferentsettings.Obviously,whenequippedwithLWFPM

JOURNALOFLATEXCLASSFILES,VOL.18,NO.9,SEPTEMBER2020 4
TABLEI
ABLATIONSTUDYOFLWAMANDLWFPMON38-CLOUDTESTSET
|     |     |     | Method |     |     | Performance |     |     |     | Efficiency |     |     |
| --- | --- | --- | ------ | --- | --- | ----------- | --- | --- | --- | ---------- | --- | --- |
F
|     |     |                     |          |     | mIoU Precision | Recall | 1-Score | OA    | params(M) |     | GFLOPS |     |
| --- | --- | ------------------- | -------- | --- | -------------- | ------ | ------- | ----- | --------- | --- | ------ | --- |
|     |     |                     | Backbone |     | 83.07 88.66    | 90.26  | 89.45   | 95.03 | 2.31      |     | 0.31   |     |
|     |     | Backbone+LWFPM      |          |     | 83.72 90.07    | 89.63  | 89.85   | 95.19 | 2.77      |     | 0.39   |     |
|     |     | Backbone+LWAM       |          |     | 83.17 90.32    | 88.76  | 89.53   | 94.99 | 2.31      |     | 0.32   |     |
|     |     | Backbone+LWFPM+LWAM |          |     | 84.13 91.09    | 89.22  | 90.15   | 95.45 | 2.77      |     | 0.40   |     |
TABLEII
CLOUDDETECTIONPERFORMANCECOMPARISONSANDEFFICIENCYCOMPARISONSON38-CLOUDANDMODISDATASETS
|     |     | Dataset | Method |     |     | Performance |     |     | Efficiency |     |     |     |
| --- | --- | ------- | ------ | --- | --- | ----------- | --- | --- | ---------- | --- | --- | --- |
F
|     |     |          |             |     | mIoU Precision | Recall | 1-Score | OA    | params(M) |     | GFLOPS |     |
| --- | --- | -------- | ----------- | --- | -------------- | ------ | ------- | ----- | --------- | --- | ------ | --- |
|     |     |          | DeepLabv3+  |     | 81.64 87.72    | 88.36  | 88.04   | 95.03 | 41.04     |     | 13.24  |     |
|     |     |          | UNet        |     | 83.82 89.68    | 89.85  | 89.76   | 95.75 | 31.05     |     | 42.02  |     |
|     |     |          | CloudFCN    |     | 83.31 88.81    | 89.61  | 89.21   | 95.66 | 11.44     |     | 40.53  |     |
|     |     | 38-Cloud | CloudAttU   |     | 84.73 90.62    | 89.95  | 90.28   | 95.92 | 40.45     |     | 64.21  |     |
|     |     |          | MobileNetV2 |     | 82.37 90.97    | 87.31  | 89.10   | 94.90 | 3.31      |     | 5.65   |     |
|     |     |          | CD-AttDLV3+ |     | 81.24 88.85    | 87.58  | 88.21   | 94.49 | 3.54      |     | 1.33   |     |
|     |     |          | CD-CTFM     |     | 84.13 91.09    | 89.22  | 90.15   | 95.45 | 2.77      |     | 0.40   |     |
|     |     |          | DeepLabv3+  |     | 81.57 90.13    | 88.62  | 88.67   | 92.53 | 42.15     |     | 13.26  |     |
|     |     |          | UNet        |     | 86.01 92.82    | 91.44  | 91.65   | 94.67 | 31.05     |     | 42.19  |     |
|     |     |          | CloudFCN    |     | 85.65 92.04    | 91.79  | 91.45   | 94.36 | 11.47     |     | 42.04  |     |
|     |     | MODIS    | CloudAttU   |     | 86.04 92.93    | 91.42  | 91.66   | 94.71 | 40.45     |     | 64.39  |     |
|     |     |          | MobileNetV2 |     | 82.19 90.59    | 88.75  | 89.14   | 92.87 | 3.32      |     | 5.67   |     |
|     |     |          | CD-AttDLV3+ |     | 82.28 90.87    | 88.80  | 89.14   | 92.93 | 3.39      |     | 1.36   |     |
|     |     |          | CD-CTFM     |     | 84.77 91.96    | 90.52  | 90.90   | 94.17 | 2.77      |     | 0.42   |     |
False-color image Ground truth UNet DeepLabv3+ CloudFCN CloudA U MobileNetV2 CD-A DLV3+ CD-CTFM
|     |     |     |     |     |     |     |     | (cid:1) |     |     | (cid:1) |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | --- | --- | ------- | --- |
Fig. 5. Comparison between the results of different methods in 38-Cloud dataset. White area represents cloud, black area represents non-cloud, red area
| represents false-positive |     | detection | andgreenarearepresents |     | false-negative | detection. |     |     |     |     |     |     |
| ------------------------- | --- | --------- | ---------------------- | --- | -------------- | ---------- | --- | --- | --- | --- | --- | --- |
0.6%
and LWAM, the model obtain the best evaluation on perfor- dataset, the mIoU index of CD-CTFM is lower than
mance. The results of this section manifestthat both LWFPM CloudAttU, which has the highest value in mIoU, but the
and LWAM improvethe performancea lotwhile decrease the parameters and computations of CloudAttU are very large,
efficiency a little bit. In particular, LWFPM and LWAM help whichare14.6and160.5timesaslargeasCD-CTFM,respec-
a lot to increase mIoU. tively.Comparedtoothermethods,CD-CTFMachievesbetter
|               |      |       |         |     |     | or        | similar | performance.  | The            | results | are similar     | in MODIS |
| ------------- | ---- | ----- | ------- | --- | --- | --------- | ------- | ------------- | -------------- | ------- | --------------- | -------- |
|               |      |       |         |     |     | datasets. |         | Fig 5 and Fig | 6 demonstrates |         | the qualitative | results  |
| C. Comparison | with | Other | Methods |     |     |           |         |               |                |         |                 |          |
ofcomparedmethodson38-CloudandMODISdatasets.Fig5
Tofurthervalidatetheeffectivenessofourproposedmodel,
containsflatlandswithcomplicatedtextureandbrokenclouds.
we compare CD-CTFM with two common semantic segmen- CD-CTFM can not only clearly detect correct cloud regions,
tation model (UNet [15] and DeepLabV3+ [16]), two cloud but also exclude surface with complex texture, which are like
detection model (CloudFCN and CloudAttU), one common clouds in terms of color and shape. Fig 6 shows snow and
lightweight model (MobileNetV2 [17]), and one lightweight ice surfacewith thin clouds. CD-CTFM is able to identifyice
| cloud detection | model |     | (CD-AttDLV3+) | on  | MODIS and | 38- |      |               |         |           |            |          |
| --------------- | ----- | --- | ------------- | --- | --------- | --- | ---- | ------------- | ------- | --------- | ---------- | -------- |
|                 |       |     |               |     |           | and | snow | surfaces with | complex | textures, | benefiting | from its |
Cloud datasets. The quantitativeresults are shown in Table II, powerful representation learning capability. In addition, CD-
from which we can see that CD-CTFM outperforms,in terms CTFMcandistinguishcloudfromthecloud-likeiceandsnow
| of efficiency, | MobileNetV2 |     | and CD-AttDLV3+. |     | In 38-Cloud |     |     |     |     |     |     |     |
| -------------- | ----------- | --- | ---------------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |

| JOURNALOFLATEXCLASSFILES,VOL.18,NO.9,SEPTEMBER2020 |     |     |     |     |     |     |     |                |     |     |     |                  |     |     | 5   |
| -------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | -------------- | --- | --- | --- | ---------------- | --- | --- | --- |
|                                                    |     |     |     |     |     |     |     | CloudA(cid:1)U |     |     |     | CD-A(cid:1)DLV3+ |     |     |     |
False-colorimage Groundtruth UNet DeepLabv3+ CloudFCN MobileNetV2 CD-CTFM
Fig. 6. Comparison between the results of different methods in MODIS dataset. White area represents cloud, black area represents non-cloud, red area
| represents false-positive |     | detection | andgreenarearepresents |     |         | false-negative |     | detection.    |         |     |          |        |        |                |      |
| ------------------------- | --- | --------- | ---------------------- | --- | ------- | -------------- | --- | ------------- | ------- | --- | -------- | ------ | ------ | -------------- | ---- |
| with the help             | of  | global    | background             |     | scenes. |                |     |               |         |     |          |        |        |                |      |
|                           |     |           |                        |     |         |                |     | [7] L. Zhang, | J. Sun, | X.  | Yang, R. | Jiang, | and Q. | Ye, “Improving | deep |
learning-basedclouddetectionforsatelliteimageswithattentionmech-
IV. CONCLUSION anism,”IEEEGeoscienceandRemoteSensingLetters,vol.19,pp.1–5,
2021.
| In this         | letter, | we         | propose    | a lightweight |                 | cloud         | detection |                |                                  |          |                      |         |                 |              |         |
| --------------- | ------- | ---------- | ---------- | ------------- | --------------- | ------------- | --------- | -------------- | -------------------------------- | -------- | -------------------- | ------- | --------------- | ------------ | ------- |
|                 |         |            |            |               |                 |               |           | [8] X. Yao,    | Q. Guo,                          | and      | A. Li, “Light-weight |         | cloud           | detection    | network |
| model, CD-CTFM, |         | to         | reduce     | parameters    | and             | computations. |           |                |                                  |          |                      |         |                 |              |         |
|                 |         |            |            |               |                 |               |           | for optical    | remote                           | sensing  | images               | with    | attention-based | deeplabv3+   |         |
|                 |         |            |            |               |                 |               |           | architecture,” | RemoteSensing,vol.13,no.18,2021. |          |                      |         |                 |              |         |
| To enable       | our     | model      | to extract | local         | and             | global        | feature   |                |                                  |          |                      |         |                 |              |         |
|                 |         |            |            |               |                 |               |           | [9] Y. Chen,   | X. Dai,                          | D. Chen, | M.                   | Liu, X. | Dong,           | L. Yuan, and | Z. Liu, |
| simultaneously, |         | we utilize |            | a lightweight | CNN-Transformer |               |           |                |                                  |          |                      |         |                 |              |         |
“Mobile-former:Bridgingmobilenetandtransformer,”inProceedingsof
networkasthebackbone.Also,wedesignalightweightfeature
theIEEE/CVFConferenceonComputerVisionandPatternRecognition,
2022,pp.5270–5279.
| pyramid           | module | to fuse | multiscale    |     | features        | with | global con- |                |           |            |           |           |              |        |             |
| ----------------- | ------ | ------- | ------------- | --- | --------------- | ---- | ----------- | -------------- | --------- | ---------- | --------- | --------- | ------------ | ------ | ----------- |
|                   |        |         |               |     |                 |      |             | [10] S. Mehta, | M.        | Rastegari, | A. Caspi, | L.        | Shapiro,     | and H. | Hajishirzi, |
| text information. |        | Then    | a lightweight |     | channel-spatial |      | attention   |                |           |            |           |           |              |        |             |
|                   |        |         |               |     |                 |      |             | “Espnet:       | Efficient | spatial    | pyramid   | ofdilated | convolutions | for    | semantic    |
module is integrated between the encoder and the decoder segmentation,” inProceedingsoftheeuropeanconferenceoncomputer
vision(ECCV),2018,pp.552–568.
| through skip | connection. |     | Experimental |      | results | on  | 38-Cloud |              |          |       |          |       |        |                      |     |
| ------------ | ----------- | --- | ------------ | ---- | ------- | --- | -------- | ------------ | -------- | ----- | -------- | ----- | ------ | -------------------- | --- |
|              |             |     |              |      |         |     |          | [11] S. Woo, | J. Park, | J.-Y. | Lee, and | I. S. | Kweon, | “Cbam: Convolutional |     |
| and MODIS    | datasets    |     | demonstrate  | that | CD-CTFM |     | achieves |              |          |       |          |       |        |                      |     |
blockattentionmodule,”inProceedingsoftheEuropeanConferenceon
betterorsimilarperformancewhiledecreasingparametersand Computer Vision(ECCV),September2018.
|     |     |     |     |     |     |     |     | [12] P.Sermanet,S.Chintala,andY.LeCun,“Convolutionalneuralnetworks |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------------------------------------------------------ | --- | --- | --- | --- | --- | --- | --- |
computations,comparedtostate-of-artmethods.Wewillintro-
appliedtohousenumbersdigitclassification,”inProceedingsofthe21st
duceknowledgedistillationandmodelcompressiontechniques InternationalConferenceonPatternRecognition(ICPR2012),2012,pp.
| to further | improve | the | accuracy | and | reduce | computations | of  | 3288–3291. |     |     |     |     |     |     |     |
| ---------- | ------- | --- | -------- | --- | ------ | ------------ | --- | ---------- | --- | --- | --- | --- | --- | --- | --- |
our model. [13] S.Mohajerani, T.A.Krammer,andP.Saeedi, “ACloudDetection Al-
|     |     |     |     |     |     |     |     | gorithm    | forRemoteSensingImagesUsingFullyConvolutional |               |     |               |          |               | Neural |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | --------------------------------------------- | ------------- | --- | ------------- | -------- | ------------- | ------ |
|     |     |     |     |     |     |     |     | Networks,” | in                                            | 2018 IEEE20th |     | International | Workshop | on Multimedia |        |
REFERENCES
SignalProcessing(MMSP),Aug2018,pp.1–5.
[1] K.Anderson, B.Ryan, W.Sonntag, A.Kavvada, andL.Friedl, “Earth [14] X.Li,X.Yang, X.Li,S.Lu,Y.Ye,andY.Ban, “Gcdb-unet: Anovel
observationinserviceofthe2030agendaforsustainabledevelopment,” robustclouddetectionapproachforremotesensingimages,”Knowledge-
BasedSystems,vol.238,p.107890,2022.
| Geo-spatial    | Information |              | Science, | vol.20,no.2,pp.77–96,2017. |                |     |          |                                                                     |     |     |     |     |     |     |     |
| -------------- | ----------- | ------------ | -------- | -------------------------- | -------------- | --- | -------- | ------------------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
|                |             |              |          |                            |                |     |          | [15] O.Ronneberger,P.Fischer,andT.Brox,“U-net:Convolutionalnetworks |     |     |     |     |     |     |     |
| [2] S. Mahajan | and         | B. Fataniya, | “Cloud   | detection                  | methodologies: |     | variants |                                                                     |     |     |     |     |     |     |     |
and development—a review,” Complex & Intelligent Systems, vol. 6, for biomedical image segmentation,” in Medical Image Computing
no.2,pp.251–261,2020. and Computer-Assisted Intervention–MICCAI 2015: 18th International
[3] S. Qiu, Z. Zhu, and B. He, “Fmask 4.0: Improved cloud and cloud Conference,Munich,Germany,October5-9,2015,Proceedings,PartIII
|                       |           |     |                        |         |            |           |        | 18.                                                             | Springer, | 2015,pp.234–241. |     |     |     |     |     |
| --------------------- | --------- | --- | ---------------------- | ------- | ---------- | --------- | ------ | --------------------------------------------------------------- | --------- | ---------------- | --- | --- | --- | --- | --- |
| shadow                | detection | in  | landsats               | 4–8 and | sentinel-2 | imagery,” | Remote |                                                                 |           |                  |     |     |     |     |     |
|                       |           |     |                        |         |            |           |        | [16] L.-C.Chen,Y.Zhu,G.Papandreou,F.Schroff,andH.Adam,“Encoder- |           |                  |     |     |     |     |     |
| SensingofEnvironment, |           |     | vol.231,p.111205,2019. |         |            |           |        |                                                                 |           |                  |     |     |     |     |     |
[4] Y.LeCun,Y.Bengio,andG.Hinton,“Deeplearning,”nature,vol.521, decoderwithatrousseparable convolution forsemanticimagesegmen-
no.7553,pp.436–444, 2015. tation,”inProceedingsoftheEuropeanConferenceonComputerVision
[5] A. Francis, P.Sidiropoulos, and J.-P.Muller, “Cloudfcn: Accurate and (ECCV),September2018.
|     |     |     |     |     |     |     |     | [17] M. Sandler, | A.  | Howard, | M. Zhu, | A.  | Zhmoginov, | and L.-C. | Chen, |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- | ------- | ------- | --- | ---------- | --------- | ----- |
robustclouddetectionforsatelliteimagerywithdeeplearning,”Remote
“Mobilenetv2:Invertedresidualsandlinearbottlenecks,”inProceedings
| Sensing, | vol.11,no.19,2019. |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
| -------- | ------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
[6] Y. Guo, X. Cao, B. Liu, and M. Gao, “Cloud detection for of the IEEE conference on computer vision and pattern recognition,
| satellite | imagery   | using | attention-based |        | u-net | convolutional | neural     | 2018,pp.4510–4520. |     |     |     |     |     |     |     |
| --------- | --------- | ----- | --------------- | ------ | ----- | ------------- | ---------- | ------------------ | --- | --- | --- | --- | --- | --- | --- |
| network,” | Symmetry, |       | vol. 12,        | no. 6, | 2020. | [Online].     | Available: |                    |     |     |     |     |     |     |     |
https://www.mdpi.com/2073-8994/12/6/1056
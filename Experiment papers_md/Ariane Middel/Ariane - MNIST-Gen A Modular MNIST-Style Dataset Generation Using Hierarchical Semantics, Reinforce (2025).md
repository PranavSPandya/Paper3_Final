MNIST-Gen: A Modular MNIST-Style Dataset
Generation Using Hierarchical Semantics,
Reinforcement Learning, and Category Theory
Pouya Shaeri Arash Karimi Ariane Middel
School of Computing and Augmented Intelligence Department of Mathematics School of Arts, Media and Engineering
Arizona State University Florida State University Arizona State University
Tempe, AZ, USA Tallahassee, FL, USA Tempe, AZ, USA
pshaeri@asu.edu akarimi@fsu.edu ariane.middel@asu.edu
Abstract—Neuralnetworksareoftenbenchmarkedusingstan- legallyconstrained,ortechnicallyprohibitive,especiallywhen
dard datasets such as MNIST, FashionMNIST, or other variants the target classes are niche or rapidly changing [7], [8].
of MNIST, which, while accessible, are limited to generic classes
To address this gap, we introduce MNIST-Gen, an auto-
such as digits or clothing items. For researchers working on
mated and modular framework for generating MNIST-style
domain-specific tasks, such as classifying trees, food items,
or other real-world objects, these data sets are insufficient image classification datasets based on user-specified hierar-
and irrelevant. Additionally, creating and publishing a custom chical category definitions. MNIST-Gen enables researchers
dataset can be time consuming, legally constrained, or beyond to rapidly create compact grayscale datasets using keyword-
the scope of individual projects. We present MNIST-Gen, an
driven image retrieval, hierarchical semantic categorization
automated, modular, and adaptive framework for generating
with CLIP-based understanding, and multiple intelligent pro-
MNIST-style image datasets tailored to user-specified categories
usinghierarchicalsemanticcategorization.Thesystemcombines cessing modes adapted to different dataset sizes and accuracy
CLIP-basedsemanticunderstandingwithreinforcementlearning requirements. Inspired by principles from category theory,
and human feedback to achieve intelligent categorization with the system treats each stage of the pipeline (e.g., cropping,
minimal manual intervention. Our hierarchical approach sup-
grayscaleconversion,resizing,andsemanticanalysis)ascom-
ports complex category structures with semantic characteristics,
posablemorphisms,allowingclearabstraction,reuse,andrea-
enabling fine-grained subcategorization and multiple processing
modes: individual review for maximum control, smart batch soning about transformations. To make the process adaptive,
processingforlargedatasets,andfastbatchprocessingforrapid we integrate reinforcement learning with human feedback
creation. Inspired by category theory, MNIST-Gen models each to optimize sample selection and categorization based on
datatransformationstageasacomposablemorphism,enhancing
semantic understanding and user preferences.
clarity, modularity, and extensibility. As proof of concept, we
The key innovation lies in our hierarchical semantic ap-
generate and benchmark two novel datasets—Tree-MNIST and
Food-MNIST—demonstratingMNIST-Gen’sutilityforproducing proach that models categorization as a structured process
task-specific evaluation data while achieving 85% automatic where main categories (e.g., ”Food”) contain semantically
categorization accuracy and 80% time savings compared to meaningful subcategories (e.g., ”Dairy Products” → ”Milk
manual approaches.
and Liquid Dairy,” ”Cheese,” ”Yogurt and Cream”) with rich
Index Terms—hierarchical categorization, semantic under-
semantic characteristics that guide CLIP-based classification.
standing, CLIP, category theory, automated pipelines, human-
This enables the system to understand complex visual and
in-the-loop.
semantic relationships while supporting multiple processing
modes: individual review for maximum control, smart batch
I. INTRODUCTION
processing that auto-categorizes confident predictions, and
Benchmark datasets such as MNIST [1] and Fashion- fast batch processing for rapid dataset creation. Users may
MNIST [2] have become foundational tools for evaluating search keywords that trigger API requests to copyright-free
the performance of image classification models. While these image sources or use existing public datasets from Kaggle.
datasets are widely adopted due to their simplicity and ac- Additionally,userscanincorporatetheirownunlabeledimage
cessibility, they are inherently limited in scope. They mostly datasets into the pipeline. Moreover, MNIST-Gen allows full
focusondigitsorfashionitemsanddonotreflectthediversity controloverannotationschemes:forinstance,anexistingfood
of real-world classification tasks [3]. Researchers developing dataset with ingredient-based classes (such as dairy, meat,
models for domain-specific applications, such as recognizing grains)canbereorganizedintoentirelynewcategoriessuchas
types of food, vegetation, or vehicles, often lack small, clean, meal timing (e.g., ”breakfast,” ”lunch,” ”pre-training fitness,”
and task-relevant datasets to validate their models [4]–[6]. and ”post-training recovery).” This empowers researchers to
Creating custom datasets from scratch is time-consuming, annotate their data in whatever way best suits the target task,
5202
luJ
61
]GL.sc[
1v12811.7052:viXra

Fig.1. OverviewoftheMNIST-Genworkflow.Thepipelineincludeskeyword-basedimageretrieval,hierarchicalsemanticclusteringviaCLIPembeddings,
threeprocessingmodes(Individual,SmartBatch,FastBatch),andreinforcementlearningforadaptivecategorization.
without being limited by the original class definitions. B. Dataset Generation and Labeling Frameworks
| As a | demonstration | of  | MNIST-Gen’s | capabilities, |     | we  | con- |         |       |               |      |      |          |     |         |
| ---- | ------------- | --- | ----------- | ------------- | --- | --- | ---- | ------- | ----- | ------------- | ---- | ---- | -------- | --- | ------- |
|      |               |     |             |               |     |     |      | Several | tools | and libraries | have | been | proposed | for | dataset |
struct two new datasets: Tree-MNIST, targeting classifica- generation,preprocessing,andweaksupervision.Snorkel[17]
| tion of           | tree species | or             | forms;          | and Food-MNIST, |            | focused    | on    |               |                |          |            |      |              |             |          |
| ----------------- | ------------ | -------------- | --------------- | --------------- | ---------- | ---------- | ----- | ------------- | -------------- | -------- | ---------- | ---- | ------------ | ----------- | -------- |
|                   |              |                |                 |                 |            |            |       | introduced    | a programmatic |          | approach   |      | for labeling |             | data us- |
| differentiating   | between      |                | food categories |                 | using a    | comprehen- |       |               |                |          |            |      |              |             |          |
|                   |              |                |                 |                 |            |            |       | ing heuristic | rules,         | while    | tools      | such | as Label     | Studio      | [18]     |
| sive 10-category, |              | 30-subcategory |                 | hierarchical    | structure. |            | These |               |                |          |            |      |              |             |          |
|                   |              |                |                 |                 |            |            |       | and CVAT      | provide        | flexible | interfaces |      | for manual   | annotation. |          |
datasetshighlighttheframework’sabilitytogeneratefocused,
|     |     |     |     |     |     |     |     | Google’s | AutoML | Vision | [19] | and NVIDIA |     | TAO [20] | offer |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | ------ | ------ | ---- | ---------- | --- | -------- | ----- |
lightweight benchmarks for use in academic publications, limited forms of dataset curation, but they are often tied
particularlyincaseswherepublishinganentirecustomdataset
|                  |     |           |      |          |             |     |     | to proprietary |      | ecosystems. | Recent | works   | have  | also       | explored |
| ---------------- | --- | --------- | ---- | -------- | ----------- | --- | --- | -------------- | ---- | ----------- | ------ | ------- | ----- | ---------- | -------- |
| is not feasible. |     | MNIST-Gen | thus | empowers | researchers |     | to  |                |      |             |        |         |       |            |          |
|                  |     |           |      |          |             |     |     | automatic      | data | collection  | from   | the web | using | a keyword- |          |
tailor validation datasets to their models and novel neural based search [21], though few offer integrated pipelines for
| network | blocks | [9], [10] | while | retaining | the simplicity |     | and |     |     |     |     |     |     |     |     |
| ------- | ------ | --------- | ----- | --------- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
preprocessing,annotation[22],andformattingintolightweight
| reproducibility      | of    | the MNIST |      | format, achieving |           | 85%       | auto- | datasets.  |            |             |                   |     |          |              |        |
| -------------------- | ----- | --------- | ---- | ----------------- | --------- | --------- | ----- | ---------- | ---------- | ----------- | ----------------- | --- | -------- | ------------ | ------ |
| matic categorization |       | accuracy  | with | 80%               | reduction | in manual |       |            |            |             |                   |     |          |              |        |
|                      |       |           |      |                   |           |           |       | Recent     | advances   | in          | vision-language   |     | models,  | particularly |        |
| annotation           | time. |           |      |                   |           |           |       |            |            |             |                   |     |          |              |        |
|                      |       |           |      |                   |           |           |       | CLIP [23], | have       | opened      | new possibilities |     | for      | semantic     | under- |
|                      |       |           |      |                   |           |           |       | standing   | in dataset | generation. | However,          |     | existing | approaches   |        |
II. RELATEDWORK typically use CLIP for simple filtering rather than structured
|              |          |     |           |                |     |     |     | hierarchical | categorization. |     | MNIST-Gen |                 | builds | upon     | this di- |
| ------------ | -------- | --- | --------- | -------------- | --- | --- | --- | ------------ | --------------- | --- | --------- | --------------- | ------ | -------- | -------- |
| A. Benchmark | Datasets |     | for Image | Classification |     |     |     |              |                 |     |           |                 |        |          |          |
|              |          |     |           |                |     |     |     | rection by   | providing       | a   | modular   | and open-source |        | pipeline | tai-     |
loredtotheMNIST-styleformat,withsupportforhierarchical
| The MNIST |                | dataset | [1] has | long served    | as     | a standard |        |            |                 |     |                      |                |     |           |          |
| --------- | -------------- | ------- | ------- | -------------- | ------ | ---------- | ------ | ---------- | --------------- | --- | -------------------- | -------------- | --- | --------- | -------- |
|           |                |         |         |                |        |            |        | semantic   | categorization, |     | CLIP-based           | understanding, |     |           | multiple |
| benchmark | for evaluating |         | image   | classification | models |            | due to |            |                 |     |                      |                |     |           |          |
|           |                |         |         |                |        |            |        | processing | modes,          | and | reinforcement-guided |                |     | filtering | with     |
itssimplicityandcompactformat.Subsequentdatasetssuchas
|              |     |     |        |           |          |      |      | human feedback. |     |     |     |     |     |     |     |
| ------------ | --- | --- | ------ | --------- | -------- | ---- | ---- | --------------- | --- | --- | --- | --- | --- | --- | --- |
| FashionMNIST | [2] | and | EMNIST | [11] have | extended | this | for- |                 |     |     |     |     |     |     |     |
mattoclothingitemsandhandwrittencharacters,respectively.
|     |     |     |     |     |     |     |     | C. Category | Theory |     | and Reinforcement |     | Learning |     | in ML |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ------ | --- | ----------------- | --- | -------- | --- | ----- |
However,thesedatasetsremainlimitedindiversityanddonot
Pipelines
| addressmany | domain-specificneeds |     |     | inapplied | research[12]– |     |     |     |     |     |     |     |     |     |     |
| ----------- | -------------------- | --- | --- | --------- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
[14]. As a result, there has been growing interest in tools that Category theory has recently gained attention in machine
support the creation of task-specific benchmarks, particularly learning as a formal framework for reasoning about com-
in low-resource or specialized domains such as agriculture, positional structures and data transformations [24], [25]. By
food, or environmental monitoring [15], [16]. modeling each transformation as a morphism and the pipeline

as a composition of morphisms, category-theoretic principles 2) CLIP-Based Semantic Analysis: For each image I, we
enable rigorous abstraction and modularity in dataset work- extractcomprehensivesemanticfeaturesusingCLIPandcom-
| flows. | In         | parallel, | reinforcement |      | learning  | (RL)  | has    | been ap- | puter | vision: |                |     |       |     |     |
| ------ | ---------- | --------- | ------------- | ---- | --------- | ----- | ------ | -------- | ----- | ------- | -------------- | --- | ----- | --- | --- |
| plied  | to various | aspects   | of            | data | selection | [26], | sample | weight-  |       |         |                |     |       |     |     |
|        |            |           |               |      |           |       |        |          |       |         | Features(I)={f |     | ,f ,f | }   | (3) |
ing [27], and annotation recommendation [28]. In MNIST- clip visual objects
| Gen, | we integrate |     | these | ideas | to form | an adaptive |     | controller |       |     |        |            |      |                   |     |
| ---- | ------------ | --- | ----- | ----- | ------- | ----------- | --- | ---------- | ----- | --- | ------ | ---------- | ---- | ----------------- | --- |
|      |              |     |       |       |         |             |     |            | Where | f   | ∈ R512 | represents | CLIP | image embeddings, |     |
clip
that learns which samples to include or discard based on f captures visual attributes (brightness, contrast, edge
visual
| reward | signals | tied | to semantic |     | understanding, |     | class | balance, |           |     |              |     |                 |        |      |
| ------ | ------- | ---- | ----------- | --- | -------------- | --- | ----- | -------- | --------- | --- | ------------ | --- | --------------- | ------ | ---- |
|        |         |      |             |     |                |     |       |          | density), | and | f represents |     | object presence | scores | from |
and human feedback, while maintaining the compositional objects
|           |         |     |                    |             |                |     |     |     | CLIP          | zero-shot  | classification.  |            |     |                     |     |
| --------- | ------- | --- | ------------------ | ----------- | -------------- | --- | --- | --- | ------------- | ---------- | ---------------- | ---------- | --- | ------------------- | --- |
| structure | through |     | category-theoretic |             | formalization. |     |     |     |               |            |                  |            |     |                     |     |
|           |         |     |                    |             |                |     |     |     | GivenanimageI |            | andasubcategorys |            | i,j | withcharacteristics |     |
|           |         |     | III.               | METHODOLOGY |                |     |     |     | A ,           | we compute | semantic         | similarity | as: |                     |     |
i,j
| MNIST-Gen |     | is      | a modular | pipeline |                | that transforms |             | a user- |     |           |     |                |     |     |     |
| --------- | --- | ------- | --------- | -------- | -------------- | --------------- | ----------- | ------- | --- | --------- | --- | -------------- | --- | --- | --- |
|           |     |         |           |          |                |                 |             |         |     | Score(I,s | )=  | α·TextSim(I,s  |     | )   | (4) |
|           |     |         |           |          |                |                 |             |         |     |           | i,j |                |     | i,j |     |
| specified |     | keyword | prompt    | into     | a ready-to-use |                 | MNIST-style |         |     |           |     |                |     |     |     |
|           |     |         |           |          |                |                 |             |         |     |           |     | +β·CharSim(I,A |     | )   |     |
image classification dataset using hierarchical semantic cat- i,j
egorization1. The system consists of six main components: +γ·VisualSim(I,s )
i,j
| (1)          | keyword-driven |            | image      | retrieval | from          | multiple | sources,         | (2)       |              |         |                |                |                  |         |           |
| ------------ | -------------- | ---------- | ---------- | --------- | ------------- | -------- | ---------------- | --------- | ------------ | ------- | -------------- | -------------- | ---------------- | ------- | --------- |
|              |                |            |            |           |               |          |                  |           | Where        | TextSim | measures       | CLIP           | similarity       | between | image     |
| hierarchical |                | category   | definition |           | with semantic |          | characteristics, |           |              |         |                |                |                  |         |           |
|              |                |            |            |           |               |          |                  |           | and category |         | text prompts,  | CharSim        | evaluates        | how     | well im-  |
| (3)          | CLIP-based     | semantic   |            | analysis  | and           | feature  | extraction,      | (4)       |              |         |                |                |                  |         |           |
|              |                |            |            |           |               |          |                  |           | age features |         | match semantic |                | characteristics, | and     | VisualSim |
| intelligent  |                | processing | modes      | adapted   | to            | dataset  | size,            | (5) rein- |              |         |                |                |                  |         |           |
|              |                |            |            |           |               |          |                  |           | assesses     | visual  | attribute      | compatibility. |                  |         |           |
forcementlearningwithhumanfeedbackforadaptivefiltering,
| and            | (6) transformation |        | pipeline   |     | (cropping,  | resizing, |        | grayscale, |             |     |                         |     |             |     |     |
| -------------- | ------------------ | ------ | ---------- | --- | ----------- | --------- | ------ | ---------- | ----------- | --- | ----------------------- | --- | ----------- | --- | --- |
|                |                    |        |            |     |             |           |        |            | B. Pipeline |     | as a Category-Theoretic |     | Composition |     |     |
| binarization). |                    | Figure | 1 provides |     | an overview |           | of the | process.   |             |     |                         |     |             |     |     |
The primary objective is to produce compact grayscale Wemodelthetransformationpipelineusingprinciplesfrom
|          |        |       |     |       |             |     |      |           | category | theory. | Let D | represent | the category | of raw | images, |
| -------- | ------ | ----- | --- | ----- | ----------- | --- | ---- | --------- | -------- | ------- | ----- | --------- | ------------ | ------ | ------- |
| datasets | (e.g., | 28×28 | or  | 64×64 | resolution) |     | that | mimic the |          |         |       |           |              |        |         |
simplicityandstructureofMNIST,whilesupportingarbitrary, and let T i be the morphism representing transformation step
|     |     |     |     |     |     |     |     |     | i. A single | image | x∈D | undergoes | a sequence | of transforma- |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ----- | --- | --------- | ---------- | -------------- | --- |
user-definedhierarchicalcategorieswithsemanticunderstand-
tions:
| ing | (e.g., | “Food” | → “Dairy | Products” |     | → “Cheese”). |     | MNIST- |     |     |     |     |     |     |     |
| --- | ------ | ------ | -------- | --------- | --- | ------------ | --- | ------ | --- | --- | --- | --- | --- | --- | --- |
Genenablesbothexperimentationandreproducibleevaluation T(x)=T ◦T ◦···◦T (x) (5)
|            |     |       |             |     |          |     |            |      |     |     |     | n n−1 |     | 1   |     |
| ---------- | --- | ----- | ----------- | --- | -------- | --- | ---------- | ---- | --- | --- | --- | ----- | --- | --- | --- |
| in domains |     | where | no standard |     | datasets | are | available, | with |     |     |     |       |     |     |     |
Where:
| multiple | processing |     | modes | to balance |     | automation |     | and human |     |     |     |     |     |     |     |
| -------- | ---------- | --- | ----- | ---------- | --- | ---------- | --- | --------- | --- | --- | --- | --- | --- | --- | --- |
T
|     |     |     |     |     |     |     |     |     | 1 : | CLIP-based | semantic | analysis |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------- | -------- | -------- | --- | --- | --- |
oversight.
|     |     |     |     |     |     |     |     |     | T : | Hierarchical | categorization |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------ | -------------- | --- | --- | --- | --- |
2
A. Hierarchical Semantic Categorization T : Resize to fixed dimension
3
1) CategoryStructureDefinition: Wemodelthecategoriza- T : Background Removal using U2-Net [29]
4
tion problem as a hierarchical structure H=(C,S,A) where: T : Center crop
5
• C ={c ,c ,...,c } represents main categories T : Grayscale conversion
|     |     | 1 2 | n   |     |     |     |     |     | 6   |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
S = {s ,s ,...,s } represents subcategories for T : Binarization or normalization
| •   | i   | i,1 | i,2 | i,ki |     |     |     |     | 7   |     |     |     |     |     |     |
| --- | --- | --- | --- | ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
category c ; 1≤i≤n This compositional view ensures modularity and flexibility.
i
A ={a ,a ,...,a } represents semantic characteris- AnytransformationT canbereplacedwithanothermorphism
| •   | i,j | 1   | 2   | m   |     |     |     |     |     |     | i   |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
ofthesametypewithoutaffectingthestructureofthepipeline,
|     | tics for | subcategory |     | s i,j ; 1≤i≤n, |     | 1≤j | ≤k  | i   |     |     |     |     |     |     |     |
| --- | -------- | ----------- | --- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
EachcategoryisdefinedthroughaJSONconfigurationthat enabling the easy insertion of alternative techniques (e.g.,
|     |     |     |     |     |     |     |     |     | different | semantic | models, | histogram | equalization, |     | or contrast |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --------- | -------- | ------- | --------- | ------------- | --- | ----------- |
specifies:
enhancement).
|     |     | Category(c | )={name,description, |     |     |     |     | (1) |     |     |     |     |     |     |     |
| --- | --- | ---------- | -------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
i
|     |     |     |     | subcategories:[S |     |     | ]}  |     | C. Functorial |     | Structure | and Dataset | Mapping |     |     |
| --- | --- | --- | --- | ---------------- | --- | --- | --- | --- | ------------- | --- | --------- | ----------- | ------- | --- | --- |
i
ToformalizeMNIST-Gen’stransformationpipelinecategor-
|     | Subcategory(s |     | i,j | )={name,description, |     |     |     | (2) |         |           |                 |     |     |     |     |
| --- | ------------- | --- | --- | -------------------- | --- | --- | --- | --- | ------- | --------- | --------------- | --- | --- | --- | --- |
|     |               |     |     |                      |     |     |     |     | ically, | we define | two categories: |     |     |     |     |
characteristics:[A i,j ]} I: the category of raw image datasets with hierarchical
•
The semantic characteristics A include visual attributes semantic annotations, where objects are image sets with
i,j
|         |        |           |     |          |             |     |         |        | metadata, |     | and morphisms |     | are preprocessing | operations. |     |
| ------- | ------ | --------- | --- | -------- | ----------- | --- | ------- | ------ | --------- | --- | ------------- | --- | ----------------- | ----------- | --- |
| (color, | shape, | texture), |     | semantic | descriptors |     | (object | types, |           |     |               |     |                   |             |     |
contexts),anddomain-specificfeaturesthatenableCLIP-based • M: the category of MNIST-style datasets, where ob-
semantic matching. jects are labeled grayscale image sets, and morphisms
|      |            |     |                 |     |           |                     |     |       | are        | dataset-level | transformations |     | preserving   | format | (e.g., |
| ---- | ---------- | --- | --------------- | --- | --------- | ------------------- | --- | ----- | ---------- | ------------- | --------------- | --- | ------------ | ------ | ------ |
| 1The | anonymized |     | code repository | is  | available | at (mnist-gen-code) |     | along |            |               |                 |     |              |        |        |
|      |            |     |                 |     |           |                     |     |       | resolution |               | normalization,  |     | relabeling). |        |        |
withalinktoBatchVolume1ofthedataset(data-batch1).Thedatasetwill
bemadepubliclyavailableuponcompletionofthepeer-reviewprocess. We define a functor F :I →M such that:

• ForeveryobjectX ∈I (asetofkeyword-retrievedRGB F. Keyword-Driven Retrieval
images with hierarchical semantic labels), F(X) is the
For each class c ∈ C (e.g., c = ”Dairy Products”, c =
i 1 2
corresponding MNIST-style grayscale dataset.
”Cactus”),weretrievek imagesusingakeyword-basedsearch
• Foreverymorphismf :X →Y inI (e.g.,semanticcat- viatheUnsplash2 APIorKaggledatasets.Theresultingimage
egorization, resize, grayscale, binarize), F(f):F(X)→
set I = {xi,xi,...,xi} is stored and tagged with the
F(Y) is the induced transformation in MNIST-space. i 1 2 k
corresponding hierarchical label.
By functoriality, we guarantee:
Topreventdomainnoiseandoutliers,thesystemusesCLIP-
F(id )=id (6) based semantic filtering and optional human-in-the-loop veri-
X F(X)
fication, and similar batching options. This verification stage
F(f ◦g)=F(f)◦F(g) (7)
becomes part of the adaptive design through reinforcement
This ensures compositionality and consistency across trans- learning feedback.
formations, allowing any subsequence of operations in the
preprocessing pipeline to be treated as a single morphism. G. Intelligent Processing Modes
Moreover, this abstraction supports replacement or reordering
MNIST-Gen supports three processing modes adapted to
of compatible morphisms without altering the overall dataset
different dataset sizes and requirements:
semantics.
a) IndividualReviewMode: Formaximumcontrol,each
D. Endofunctors and Self-Mapping Transformations image is reviewed with AI predictions, confidence scores,
and comprehensive category suggestions. Suitable for small
Whenweextendthepipelinetoincludetransformationsthat
datasets or when high accuracy is critical.
mapMNIST-styledatasetstootherMNIST-styledatasets(e.g.,
rotation, contrast enhancement), we operate within M itself. b) Smart Batch Processing: For large datasets (>1000
Inthiscase,eachtransformationismodeledasanendofunctor images),imagesareautomaticallycategorizedbasedonconfi-
G : M → M. These endofunctors preserve the structure of dence thresholds: high confidence (>0.85) for automatic cat-
egorization, medium confidence (0.4-0.85) for human review,
the dataset category while enriching the feature space (e.g.,
and low confidence (<0.4) for automatic removal.
through data augmentation or rebalancing).
Let T represent a sequence of label-preserving augmen- c) Fast Batch Processing: For rapid dataset creation,
aug
tations. Then, for a dataset D ∈M: similar images are clustered using CLIP embeddings, and
users make decisions for entire clusters rather than individual
G(D)=T (D) (8)
aug images, reducing human decision points by 90%.
and G composing naturally with other functors F :I →M;
H. Preprocessing and Formatting
G◦F :I →M (9)
Each retrieved image is passed through the transformation
provides a generalized view of data enrichment. chainT(x)tomatchMNISTformatting.Letx ∈RH×W×3
rgb
be the input image. The transformation stages include:
E. Natural Transformations and RL Feedback
Let F and F be two functors representing different trans- x =SemanticAnalysis(x ) (11)
1 2 semantic rgb
formationpipelines—e.g.,withandwithoutRL-basedfiltering x =Resize(x ,64,64) (12)
resized rgb
or different semantic categorization approaches. A natural
x =CenterCrop(x ,28,28) (13)
transformationη :F ⇒F representsawaytocompareeach crop resized
1 2
1
dataset transformation at every stage in a structure-preserving x = (xR +xG +xB ) (14)
gray 3 crop crop crop
way.
x =I[x >θ] (15)
Formally, for each object X ∈I: binary gray
η :F (X)→F (X) (10) Where θ is a manually set or RL-learned binarization
X 1 2
threshold, and x represents the hierarchical semantic
is a morphism in M such that for any morphism f :X →Y semantic
categorization result. The final result is stored in a NumPy or
in I, the following diagram commutes:
‘.idx‘ format, along with hierarchical label metadata, suitable
for PyTorch or TensorFlow pipelines.
F (X)
F1(f)
F (Y)
1 1
I. Reinforcement Learning for Adaptive Sample Selection
ηX ηY
F (X)
F2(f)
F (Y)
To enhance the dataset’s quality and diversity, we use a
2 2
reinforcement learning (RL) agent to optimize which samples
Thisstructureallowsustoreasonabouttheeffectivenessof to retain or discard based on semantic understanding, task
RL-based adaptation versus static pipelines, as well as differ- performance, and user-specified goals.
ent semantic categorization approaches, in a mathematically
grounded way. 2https://unsplash.com/developers

a) Environment: Each image x
i
is an environment state IV. EXPERIMENTS
s , with features combining:
i To evaluate the effectiveness of MNIST-Gen, we construct
• CLIP-based semantic features twodomain-specificMNIST-styledatasets:Food-MNISTand
• Visual attributes (brightness, edge density, contrast) Tree-MNIST. Each dataset is generated using our auto-
• Hierarchical categorization confidence mated hierarchical semantic categorization pipeline, followed
• Class label and current class frequency by comprehensive evaluation using both classical machine
• Similarity to existing categorized samples learning algorithms and deep neural networks. The primary
b) Actions: The agent can choose: goals are to (1) demonstrate the feasibility of using MNIST-
• a 1 : Keep sample in predicted category Gentogeneratedomain-specificbenchmarkswithhierarchical
• a 2 : Discard sample semantic understanding, (2) validate the utility of reinforce-
• a 3 : Send sample to human review ment learning for adaptive dataset filtering, and (3) evaluate
the efficiency of different processing modes.
c) Reward Function: We define a reward R(s,a) as:
R(s,a)= λ ·SemanticConf(s) (16) A. Food-MNIST Classes
1
+λ 2 ·Entropy(ClassDist) The Food-MNIST dataset uses a comprehensive hierarchi-
+λ ·ModelAcc cal structure with 10 main categories and 30 subcategories,
3
designed to test various aspects of food understanding:
−λ ·Redundancy
4
• Bread – Sliced Bread, Whole Loaves, Rolls and Buns
Where SemanticConf is CLIP-based semantic confidence
• Dairy Product – Milk and Liquid Dairy, Cheese, Yogurt
score, ClassDist is current class distribution entropy, Mod-
and Cream
elAccisaccuracyfromalightweightmodeltrainedoncurrent
• Dessert – Cakes and Pastries, Ice Cream and Frozen,
batch, and Redundancy is the Visual similarity to already-
Cookies and Small Sweets
selected samples.
• Egg – Whole Eggs, Fried and Scrambled, Egg Dishes
We use Deep Q-Learning (DQN) for policy learning and • Fried Food – Fried Chicken and Poultry, French Fries
periodically retrain the lightweight classifier for reward esti-
and Chips, Other Fried Foods
mation. • Meat – Raw Meat, Grilled and Roasted, Processed Meat
• Noodles-Pasta – Long Pasta and Noodles, Short Pasta
J. Case Studies: Tree-MNIST and Food-MNIST
Shapes, Asian Noodle Soups
TodemonstrateMNIST-Gen’sflexibility,wepresenttwouse • Rice – Plain Cooked Rice, Fried Rice, Rice Dishes
cases: • Seafood – Fish Fillets and Steaks, Shellfish and Crus-
a) Tree-MNIST: Four user-specified tree taceans, Whole Fish
categories—”Broadleaf Tree”, ”Cactus”, ”Coniferous • Vegetable-Fruit – Fresh Vegetables, Fresh Fruits,
Tree”, ”Palm”—are queried and transformed into a 4- Cooked Vegetables
class MNIST-style dataset using our hierarchical semantic
Each subcategory includes detailed semantic characteristics
categorization system. Each main category contains three
(e.g.,”ovalshape,””whiteshell,””creamytexture”)forCLIP-
specialized subcategories: for instance, Broadleaf Trees
based understanding. For the comprehensive evaluation, we
include Deciduous Broadleaf, Evergreen Broadleaf, and
retrieved 5,000 images from the Kaggle Food-11 dataset
Flowering Broadleaf varieties. The hierarchical semantic
providedby[30]tocompareandvalidatesubcategorylabeling.
system analyzes visual characteristics like foliage density,
Thepipelineprocessedeachimageusinghierarchicalsemantic
trunk structure, leaf shapes, and growth patterns. The RL
categorizationinto28×28grayscaleformat.Wealsoremoved
agentisusedtodiscardoverexposedoroverlysimilarsamples
visually ambiguous images that contained multiple food types
based on semantic understanding while maintaining botanical
from different categories (e.g., eggs and fries on the same
diversity across subcategories.
plate), to avoid labeling conflicts.
b) Food-MNIST: We generate a comprehensive dataset
using a 10-category, 30-subcategory hierarchical structure en-
B. Tree-MNIST Classes
compassing common food types across various cultural and
nutritional domains. Each subcategory includes 5-7 semantic The Tree-MNIST dataset comprises four main tree cate-
characteristics for CLIP-based matching. Visual balancing gories selected for botanical diversity and visual distinction:
ensures classes are diverse in color, shape, and texture while • Broadleaf Tree – Deciduous Broadleaf, Evergreen
maintaining semantic coherence. Broadleaf, Flowering Broadleaf
Eachdatasetisvalidatedbytrainingmultiplemachinelearn- • Cactus – Columnar Cactus, Barrel and Round Cactus,
ingmodelsincludingclassicalalgorithmsandneuralnetworks. Branching and Pad Cactus
The classification performance serves as a downstream signal • ConiferousTree–PineandFirTrees,SpruceandCedar,
used by the RL reward function to improve future dataset Juniper and Cypress
iterations. • Palm–FanPalm,FeatherPalm,CoconutandDatePalm

Eachmaincategorycontainsthreespecializedsubcategories
TABLEII
CLASSIFICATIONPERFORMANCEONTREE-MNIST(4CLASSES)
| that capture | distinct | morphological |     | and | botanical | characteris- |     |     |     |     |     |     |     |     |     |
| ------------ | -------- | ------------- | --- | --- | --------- | ------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- |
tics.Thehierarchicalsemanticsystemanalyzesvisualfeatures
including foliage density, trunk structure, leaf shapes, growth Model Acc.(%) Precision Recall F1Score
|           |              |          |             |              |            |             |         | CNN(2ConvLayers)        |     | 86.51 |     | 0.8742 | 0.8651 | 0.8693 |     |
| --------- | ------------ | -------- | ----------- | ------------ | ---------- | ----------- | ------- | ----------------------- | --- | ----- | --- | ------ | ------ | ------ | --- |
| patterns, | and          | seasonal | variations. | Similar      | to         | Food-MNIST, |         |                         |     |       |     |        |        |        |     |
|           |              |          |             |              |            |             |         | RandomForest            |     | 82.73 |     | 0.8394 | 0.8273 | 0.8328 |     |
| around    | 400 images   | per      | main        | class were   | collected, |             | prepro- |                         |     |       |     |        |        |        |     |
|           |              |          |             |              |            |             |         | GradientBoosting        |     | 81.95 |     | 0.8287 | 0.8195 | 0.8235 |     |
|           |              |          |             |              |            |             |         | K-NearestNeighbors      |     | 79.84 |     | 0.8103 | 0.7984 | 0.8038 |     |
| cessed,   | and filtered | using    | the         | hierarchical | semantic   |             | system  |                         |     |       |     |        |        |        |     |
|           |              |          |             |              |            |             |         | FullyConnected(2-layer) |     | 78.62 |     | 0.7945 | 0.7862 | 0.7897 |     |
and RL agent to eliminate low-contrast or redundant samples. DecisionTree 75.18 0.7634 0.7518 0.7569
The final Tree-MNIST dataset contains 1500 labeled images MLP(ShallowNN) 73.45 0.7492 0.7345 0.7412
|     |     |     |     |     |     |     |     | AdaBoost |     | 70.83 |     | 0.7218 | 0.7083 | 0.7144 |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | --- | ----- | --- | ------ | ------ | ------ | --- |
across four main classes with balanced representation across SVM 67.29 0.6856 0.6729 0.6786
| subcategories. |     |                 |     |     |     |     |     | LogisticRegression |     | 63.92 |     | 0.6518 | 0.6392 | 0.6449 |     |
| -------------- | --- | --------------- | --- | --- | --- | --- | --- | ------------------ | --- | ----- | --- | ------ | ------ | ------ | --- |
|                |     |                 |     |     |     |     |     | GaussianNB         |     | 58.74 |     | 0.6103 | 0.5874 | 0.5981 |     |
| C. Processing  |     | Mode Evaluation |     |     |     |     |     |                    |     |       |     |        |        |        |     |
TABLEIII
| We evaluated |     | three processing |     | modes | on the | Food-MNIST |     |     |     |     |     |     |     |     |     |
| ------------ | --- | ---------------- | --- | ----- | ------ | ---------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
CLASSIFICATIONPERFORMANCEONFOOD-MNIST(10CLASSES)
dataset:
|     |     |     |     |     |     |     |     | Model |     | Acc.(%) |     | Precision | Recall | F1Score |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----- | --- | ------- | --- | --------- | ------ | ------- | --- |
TABLEI
|     |     |     |     |     |     |     |     | CNN(2ConvLayers) |     | 73.84 |     | 0.7521 | 0.7384 | 0.7441 |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- | ----- | --- | ------ | ------ | ------ | --- |
PROCESSINGMODECOMPARISONONFOOD-MNIST(5,000IMAGES)
|     |     |     |     |     |     |     |     | RandomForest            |     | 68.92 |     | 0.7103 | 0.6892 | 0.6985 |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------------------- | --- | ----- | --- | ------ | ------ | ------ | --- |
|     |     |     |     |     |     |     |     | FullyConnected(2-layer) |     | 67.45 |     | 0.6834 | 0.6745 | 0.6782 |     |
Mode Auto% Review% Time(hrs) Accuracy% GradientBoosting 64.73 0.6612 0.6473 0.6535
|        |     |     |     |     |      |      |     | K-NearestNeighbors |     | 62.18 |     | 0.6341 | 0.6218 | 0.6273 |     |
| ------ | --- | --- | --- | --- | ---- | ---- | --- | ------------------ | --- | ----- | --- | ------ | ------ | ------ | --- |
| Manual |     | 0   | 100 |     | 25.0 | 92.3 |     | AdaBoost           |     | 58.35 |     | 0.5967 | 0.5835 | 0.5894 |     |
Individual 20 80 18.5 91.1 DecisionTree 56.92 0.5834 0.5692 0.5751
SmartBatch 85 15 5.2 89.7 MLP(ShallowNN) 54.67 0.5621 0.5467 0.5535
| FastBatch      |       | 75                | 25   |            | 3.1      | 86.4          |      | SVM                |     | 51.23  |             | 0.5287 | 0.5123  | 0.5196 |        |
| -------------- | ----- | ----------------- | ---- | ---------- | -------- | ------------- | ---- | ------------------ | --- | ------ | ----------- | ------ | ------- | ------ | ------ |
|                |       |                   |      |            |          |               |      | LogisticRegression |     | 49.86  |             | 0.5142 | 0.4986  | 0.5056 |        |
|                |       |                   |      |            |          |               |      | GaussianNB         |     | 42.35  |             | 0.4487 | 0.4235  | 0.4347 |        |
| The smart      | batch | processing        | mode | achieved   |          | 85% automatic |      |                    |     |        |             |        |         |        |        |
| categorization |       | while maintaining |      | high       | accuracy | (89.7%),      | rep- |                    |     |        |             |        |         |        |        |
| resenting      | a 79% | reduction         | in   | annotation | time     | compared      |      | to                 |     |        |             |        |         |        |        |
|                |       |                   |      |            |          |               |      | patterns essential | for | visual | recognition | tasks. | Second, |        | ensem- |
manual approaches. ble methods (Random Forest and Gradient Boosting) show
strongperformance,rankingsecondandthirdrespectively,due
| D. Model | Architecture |     | and Training |     |     |     |     |                   |     |        |         |         |              |     |     |
| -------- | ------------ | --- | ------------ | --- | --- | --- | --- | ----------------- | --- | ------ | ------- | ------- | ------------ | --- | --- |
|          |              |     |              |     |     |     |     | to their capacity | to  | handle | complex | feature | interactions |     | and |
Forcomprehensiveevaluation,wetrainedmultiplemachine reduce overfitting. Third, the performance gap between Tree-
| learning | models | ranging | from | classical | algorithms |     | to deep |          |          |                |     |     |          |            |     |
| -------- | ------ | ------- | ---- | --------- | ---------- | --- | ------- | -------- | -------- | -------------- | --- | --- | -------- | ---------- | --- |
|          |        |         |      |           |            |     |         | MNIST (4 | classes) | and Food-MNIST |     | (10 | classes) | highlights |     |
neural networks. The CNN architecture used for both datasets the increased complexity of multi-class food categorization,
consisted of: where inter-class visual similarities pose greater challenges.
Conv1: 3×3, 16 filters, ReLU, max pooling Wecomparedthreeversionsofeachdataset:(1)arandomly
•
Conv2: 3×3, sampledsetof300imagesperclass,(2)asemanticallyfiltered
| •   |     | 32  | filters, ReLU, | max | pooling |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | -------------- | --- | ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
• FC: 64 units, ReLU set using CLIP-based analysis, and (3) a version filtered with
Output: Softmax over K classes (K = 10 for Food- both hierarchical semantic analysis and a DQN reinforcement
•
MNIST, K =4 for Tree-MNIST) learning agent. The RL + Semantic version showed a 5–8%
|              |      |          |           |        |                 |          |         | improvement  | in classification |       | accuracy   |     | by removing |            | noisy |
| ------------ | ---- | -------- | --------- | ------ | --------------- | -------- | ------- | ------------ | ----------------- | ----- | ---------- | --- | ----------- | ---------- | ----- |
| Training     | used | the Adam | optimizer |        | with a          | learning | rate of |              |                   |       |            |     |             |            |       |
|              |      |          |           |        |                 |          |         | or ambiguous | images            | while | preserving |     | semantic    | coherence. |       |
| 0.001, batch | size | of 32,   | and 10    | epochs | per experiment. |          | The     |              |                   |       |            |     |             |            |       |
dataset was split 80/20 for training and validation. Classical Additionally, it maintained near-optimal class distribution en-
tropyandreducedimageredundancybasedonCLIPsimilarity
| machine         | learning         | models        | were | implemented        | using | scikit-learn |     |                |         |     |     |     |     |     |     |
| --------------- | ---------------- | ------------- | ---- | ------------------ | ----- | ------------ | --- | -------------- | ------- | --- | --- | --- | --- | --- | --- |
| with standard   | hyperparameters. |               |      |                    |       |              |     | scores.        |         |     |     |     |     |     |     |
| E. Quantitative |                  | Results       |      |                    |       |              |     |                |         |     |     |     |     |     |     |
|                 |                  |               |      |                    |       |              |     | F. Qualitative | Results |     |     |     |     |     |     |
| Tables          | II and           | III summarize |      | the classification |       | performance  |     |                |         |     |     |     |     |     |     |
of various machine learning algorithms on the Tree-MNIST Figure 2 and Figure 3 illustrate sample outputs from each
and the more challenging 10-class Food-MNIST datasets, dataset. Visually, the datasets reflect high intra-class consis-
respectively. tencyandinter-classseparabilitydespiteresolutionconstraints,
The results demonstrate several key findings. First, CNNs with clear semantic relationships preserved in the hierarchical
consistentlyoutperformclassicalmachinelearningapproaches structure.TheTree-MNISTsamplesshowdistinctmorphologi-
on both datasets, achieving 86.51% accuracy on Tree-MNIST calcharacteristicsacrossthefourmaincategories,whileFood-
and 73.84% on Food-MNIST. This superior performance re- MNIST samples demonstrate successful capture of diverse
flects CNNs’ ability to capture spatial hierarchies and local culinary presentations within each hierarchical category.

V. LIMITATIONSANDCHALLENGES
While MNIST-Gen presents a flexible and modular frame-
work for generating user-specified MNIST-style datasets with
hierarchical semantic categorization, it also comes with sev-
eral limitations and challenges that highlight directions for
futurework.First,thesystemoutputslow-resolutiongrayscale
images (typically 28 × 28), which are well-suited for rapid
prototyping but insufficient for tasks that require high visual
fidelity,colordistinctions,orfine-graineddetail.Extendingthe
pipeline to support configurable resolutions and color formats
Fig.2. SampleimagesfromtheTree-MNISTdataset,illustratingmorpho-
would broaden its applicability.
logicalvariations.
Anothersignificantchallengeliesinthesemanticambiguity
of keyword-driven image retrieval. Queries such as ”apple”
may return irrelevant results such as company logos, and
terms like ”maple” can include both trees and syrup prod-
ucts. While our CLIP-based semantic filtering significantly
reduces these issues compared to simple keyword matching,
semantic inconsistencies can still propagate into the final
dataset.Thehierarchicalcategorizationapproachwithdetailed
semantic characteristics helps mitigate this, but human-in-the-
loop (HITL) verification remains important for edge cases,
Fig. 3. Sample images from the Food-MNIST dataset, illustrating visual introducing a trade-off between automation and annotation
diversityacrosscategories. effort.
Visual variability across samples is also a challenge. Real-
world classes such as ”pizza,” ”oak tree,” or ”sushi” exhibit
G. Discussion wide variations in appearance due to lighting, angle, and
context. Normalizing such data into a consistent MNIST-style
format through preprocessing steps—cropping, resizing, and
MNIST-Gen successfully enabled the creation of
binarization—may result in reduced inter-class separability
lightweight, publication-ready datasets for two distinct
or loss of informative features. Our hierarchical semantic
visual domains using hierarchical semantic categorization.
approach addresses this by capturing multiple visual and
The comprehensive evaluation across multiple machine
semantic aspects, but some information loss is inevitable in
learning paradigms validates the quality and utility of the
the MNIST transformation.
generated datasets. CNNs’ superior performance confirms
Furthermore,whileMNIST-Gensupportsarbitrarynumbers
that the spatial information preservation during the MNIST
of user-defined hierarchical categories, the current demonstra-
transformation process maintains sufficient visual features for
tions focus on datasets with 5–10 main categories. Scaling
effective classification. The strong performance of ensemble
to broader multi-class scenarios may require improved sam-
methods suggests that the datasets contain rich feature
pling,filtering,andclassbalancingmechanisms.Thesemantic
representations suitable for traditional machine learning
characteristic design also requires some domain expertise to
approaches.
achieve optimal results, though our JSON-based configuration
Thehierarchicalcategorizationapproachprovesparticularly system makes this more accessible than previous approaches.
valuable for Food-MNIST, where the semantic structure helps The RL module enhances sample selection by optimizing
distinguish between visually similar categories such as differ- for dataset quality based on metrics such as semantic un-
ent types of bread or dairy products. For Tree-MNIST, the derstanding, class balance, and model accuracy. However, its
botanical hierarchy successfully captures the morphological effectiveness is sensitive to the design of the reward function
diversitywithineachtreefamilywhilemaintainingclearinter- and the quality of semantic features. Sparse feedback, noisy
class boundaries. labels, or domain shifts can result in unstable training or
The modular design, compositional pipeline, and adaptive suboptimal selection policies. Moreover, policies learned on
RL filtering offer clear advantages over manual curation or onedatasetdonotyetgeneralizeperfectlytoothers,thoughthe
staticdatasets.TheintegrationofCLIP-basedsemanticunder- semanticfoundationprovidesbettertransferabilitythanpurely
standing with category-theoretic formalization provides both visual approaches.
practical effectiveness and theoretical rigor. In future work, Finally, since MNIST-Gen relies on public image repos-
we plan to extend the framework with multi-label support, itories rather than curated, annotated datasets, there is no
text-to-image guidance, and transformer-based RL agents for definitive ground truth against which to benchmark perfor-
richer policy modeling. mance. Evaluation must rely on downstream model accu-

racy, semantic consistency metrics, or qualitative inspection, interfaces for dataset debugging and annotation refinement,
which can obscure labeling errors or visual inconsistencies. enabling seamless human-in-the-loop collaboration.
Our multi-modal evaluation approach, combining accuracy, The framework’s modular design facilitates easy integra-
semantic coherence, and human feedback, helps address this tion of new semantic understanding models, categorization
limitation. approaches, and processing modes as they become available.
|     |     |     |     |     |     |     |     | We envision | MNIST-Gen |     | evolving |     | into a flexible |     | foundation |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | --------- | --- | -------- | --- | --------------- | --- | ---------- |
VI. CONCLUSION forreproducible,intelligent,anddomain-awaredatasetgenera-
|     |     |     |     |     |     |     |     | tion in machine |     | learning | workflows, |     | ultimately | democratizing |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------- | --- | -------- | ---------- | --- | ---------- | ------------- | --- |
In this work, we introduced MNIST-Gen, an automated access to high-quality, task-specific datasets for researchers
| and modular    | framework |     | for      | generating        | MNIST-style |            | image |                |     |          |     |     |     |     |     |
| -------------- | --------- | --- | -------- | ----------------- | ----------- | ---------- | ----- | -------------- | --- | -------- | --- | --- | --- | --- | --- |
|                |           |     |          |                   |             |            |       | across diverse |     | domains. |     |     |     |     |     |
| classification | datasets  |     | tailored | to user-specified |             | categories | us-   |                |     |          |     |     |     |     |     |
inghierarchicalsemanticcategorization.BycombiningCLIP- REFERENCES
| based semantic |     | understanding, |     | category-theoretic |     |     | formulation |     |     |     |     |     |     |     |     |
| -------------- | --- | -------------- | --- | ------------------ | --- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
[1] Y.LeCun,L.Bottou,Y.Bengio,andP.Haffner,“Gradient-basedlearning
of the transformation pipeline, and reinforcement learning applied to document recognition,” Proceedings of the IEEE, vol. 86,
for adaptive filtering, MNIST-Gen provides a lightweight yet no.11,pp.2278–2324,1998.
extensible solution for researchers in need of small, task- [2] H. Xiao, K. Rasul, and R. Vollgraf, “Fashion-mnist: a novel image
datasetforbenchmarkingmachinelearningalgorithms,”arXivpreprint
specific validation datasets. The hierarchical approach enables arXiv:1708.07747,2017.
complex category structures with semantic characteristics, [3] C.Sun,A.Shrivastava,S.Singh,andA.Gupta,“Revisitingunreasonable
effectivenessofdataindeeplearningera,”inProceedingsoftheIEEE
| supporting | fine-grained |     | subcategorization |     |     | while | maintaining |     |     |     |     |     |     |     |     |
| ---------- | ------------ | --- | ----------------- | --- | --- | ----- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
internationalconferenceoncomputervision,2017,pp.843–852.
| practical | efficiency | through |     | multiple | intelligent |     | processing |                 |     |                |     |            |                        |     |      |
| --------- | ---------- | ------- | --- | -------- | ----------- | --- | ---------- | --------------- | --- | -------------- | --- | ---------- | ---------------------- | --- | ---- |
|           |            |         |     |          |             |     |            | [4] L. Bossard, |     | M. Guillaumin, |     | and L. Van | Gool, “Food-101–mining |     | dis- |
modes. criminative components with random forests,” in European conference
|     |               |     |               |     |      |     |         | oncomputervision. |     |     | Springer,2014,pp.446–461. |     |     |     |     |
| --- | ------------- | --- | ------------- | --- | ---- | --- | ------- | ----------------- | --- | --- | ------------------------- | --- | --- | --- | --- |
| Our | comprehensive |     | demonstration |     | with | two | example |                   |     |     |                           |     |     |     |     |
[5] N.Su¨nderhauf,C.McCool,B.Upcroft,andT.Perez,“Fine-grainedplant
| datasets—Food-MNIST |     |     | using | a 10-category, |     | 30-subcategory |     |     |     |     |     |     |     |     |     |
| ------------------- | --- | --- | ----- | -------------- | --- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
classificationusingconvolutionalneuralnetworksforfeatureextraction.”
hierarchicalstructureandTree-MNIST—showcasestheframe- inCLEF(Workingnotes),2014,pp.756–762.
|                |     |              |            |     |             |     |              | [6] P. Shaeri |      | and A.     | Middel, | “Mid-l:     | Matrix-interpolated |           | dropout    |
| -------------- | --- | ------------ | ---------- | --- | ----------- | --- | ------------ | ------------- | ---- | ---------- | ------- | ----------- | ------------------- | --------- | ---------- |
| work’s ability |     | to construct | practical, |     | publishable |     | datasets for |               |      |            |         |             |                     |           |            |
|                |     |              |            |     |             |     |              | layer         | with | layer-wise | neuron  | selection,” | 2025.               | [Online]. | Available: |
domains not served by standard benchmarks such as MNIST https://arxiv.org/abs/2505.11416
or FashionMNIST. The system achieves 85% automatic cat- [7] A. Joulin, L. Van Der Maaten, A. Jabri, and N. Vasilache, “Learning
egorization accuracy while reducing manual annotation time visualfeaturesfromlargeweaklysuperviseddata,”inEuropeanconfer-
|     |     |     |     |     |     |     |     | enceoncomputervision. |     |     | Springer,2016,pp.67–84. |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------------- | --- | --- | ----------------------- | --- | --- | --- | --- |
by 80%, demonstrating significant practical value for dataset [8] P.ShaeriandA.Katanforoush,“Asemi-supervisedfakenewsdetection
generation workflows. using sentiment encoding and lstm with self-attention,” in 2023 13th
|         |               |     |     |           |          |     |             | International |                       | Conference | on  | Computer | and Knowledge |     | Engineering |
| ------- | ------------- | --- | --- | --------- | -------- | --- | ----------- | ------------- | --------------------- | ---------- | --- | -------- | ------------- | --- | ----------- |
| The key | contributions |     | of  | MNIST-Gen | include: |     | (1) a novel |               |                       |            |     |          |               |     |             |
|         |               |     |     |           |          |     |             | (ICCKE).      | IEEE,2023,pp.590–595. |            |     |          |               |     |             |
hierarchical semantic categorization approach that integrates [9] A. A. Aghaei, A. G. Nejad, S. Yousefi, and K. Parand, “A new
CLIP understanding with structured domain knowledge, (2) chebyshevoperationalmatrixformulationofleast-squaressupportvector
regressionforsolvingfractionalintegro-differentialequations,”Journal
category-theoreticformalizationensuringmodularityandcom-
ofComputationalandAppliedMathematics,p.116816,2025.
| positionality, | (3) | multiple | processing |     | modes | adapted | to differ- |     |     |     |     |     |     |     |     |
| -------------- | --- | -------- | ---------- | --- | ----- | ------- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
[10] A.N.Firoozsalari,A.A.Aghaei,andK.Parand,“Amachinelearning
|     |     |     |     |     |     |     |     | framework | for | efficiently | solving | fokker–planck |     | equations,” | Computa- |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | --- | ----------- | ------- | ------------- | --- | ----------- | -------- |
entdatasetsizesandaccuracyrequirements,(4)reinforcement
tionalandAppliedMathematics,vol.43,no.6,p.389,2024.
| learning | with human |     | feedback | for | adaptive | filtering, | and (5) |     |     |     |     |     |     |     |     |
| -------- | ---------- | --- | -------- | --- | -------- | ---------- | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
[11] G.Cohen,S.Afshar,J.Tapson,andA.vanSchaik,“Emnist:Extending
| comprehensive |     | evaluation | demonstrating |     |     | both effectiveness |     |     |     |     |     |     |     |     |     |
| ------------- | --- | ---------- | ------------- | --- | --- | ------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- |
mnisttohandwrittenletters,”in2017InternationalJointConferenceon
and efficiency gains over manual approaches. NeuralNetworks(IJCNN). IEEE,2017,pp.2921–2926.
|           |     |        |     |         |            |            |     | [12] P. Shaeri, | Y.  | Mohammadpour, |         | A. Beigi, | A.      | Middel,   | and H. Liu, |
| --------- | --- | ------ | --- | ------- | ---------- | ---------- | --- | --------------- | --- | ------------- | ------- | --------- | ------- | --------- | ----------- |
| MNIST-Gen |     | lowers | the | barrier | to dataset | generation |     | in              |     |               |         |           |         |           |             |
|           |     |        |     |         |            |            |     | “Sentiment      |     | and social    | signals | in the    | climate | crisis: A | survey on   |
low-resource or exploratory research settings, particularly for analyzing social media responses to extreme weather events,” 2025.
applications where data sharing is limited or costly. It also [Online].Available:https://arxiv.org/abs/2504.18837
opens up new possibilities for treating dataset construction as [13] A.Beigi,B.Jiang,D.Li,Z.Tan,P.Shaeri,T.Kumarage,A.Bhattachar-
jee,andH.Liu,“Canllmsimprovemultimodalfact-checkingbyasking
a learnable and compositional process, paving the way for relevantquestions?”arXivpreprintarXiv:2410.04616,2024.
future integration of more advanced vision-language models, [14] P.Shaeri,S.AlKhaled,andA.Middel,“Amultimodalphysics-informed
|             |          |        |     |        |      |             |       | neural | network | approach | for | mean | radiant temperature |     | modeling,” |
| ----------- | -------- | ------ | --- | ------ | ---- | ----------- | ----- | ------ | ------- | -------- | --- | ---- | ------------------- | --- | ---------- |
| interactive | feedback | loops, | and | formal | data | engineering | meth- |        |         |          |     |      |                     |     |            |
2025.[Online].Available:https://arxiv.org/abs/2503.08482
ods. MNIST-Gen represents a significant step toward more [15] S. R. AlKhaled, A. Middel, P. Shaeri, I. Buo, and F. A. Schneider,
adaptive, transparent, and user-centered approaches to dataset “Webmrt:Anonlinetooltopredictsummertimemeanradianttempera-
tureusingmachinelearning,”SustainableCitiesandSociety,vol.115,
| creation | in machine | learning. |     |     |     |     |     |     |     |     |     |     |     |     |     |
| -------- | ---------- | --------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
p.105861,2024.
| Future | work | on MNIST-Gen |     | will | focus | on expanding | the |     |     |     |     |     |     |     |     |
| ------ | ---- | ------------ | --- | ---- | ----- | ------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- |
[16] A.Middel,J.Lukasczyk,S.Zakrzewski,M.Arnold,andR.Maciejew-
|             |              |     |     |            |     |               |      | ski, | “Urban | form and | composition | of  | street canyons: | A human-centric |     |
| ----------- | ------------ | --- | --- | ---------- | --- | ------------- | ---- | ---- | ------ | -------- | ----------- | --- | --------------- | --------------- | --- |
| framework’s | capabilities |     | in  | both scope | and | intelligence. | This |      |        |          |             |     |                 |                 |     |
bigdataanddeeplearningapproach,”LandscapeandUrbanPlanning,
| includes | support | for | higher-resolution |     | and | color | image for- |     |     |     |     |     |     |     |     |
| -------- | ------- | --- | ----------------- | --- | --- | ----- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
vol.183,pp.122–132,2019.
mats, integration of more advanced vision-language models [17] A.Ratner,S.Bach,H.Ehrenberg,J.Fries,S.Wu,andC.Re´,“Snorkel:
for enhanced semantic filtering, and more sophisticated rein- Rapidtrainingdatacreationwithweaksupervision,”TheVLDBJournal,
vol.29,no.2,pp.709–730,2020.
| forcement | learning | strategies |     | that adapt | to  | user feedback | and |               |        |         |             |     |               |        |          |
| --------- | -------- | ---------- | --- | ---------- | --- | ------------- | --- | ------------- | ------ | ------- | ----------- | --- | ------------- | ------ | -------- |
|           |          |            |     |            |     |               |     | [18] Heartex, | “Label | studio: | Open-source |     | data labeling | tool,” | https:// |
domain characteristics. We also plan to develop interactive labelstud.io/,2020.

E.Bisong,“Googleautoml:cloudvision,”inBuildingMachineLearning
[19]
andDeepLearningModelsonGoogleCloudPlatform:AComprehen-
| siveGuideforBeginners. |               | Springer,2019,pp.581–598.                 |     |     |     |          |
| ---------------------- | ------------- | ----------------------------------------- | --- | --- | --- | -------- |
| [20] “Nvidia           | tao toolkit,” | https://developer.nvidia.com/tao-toolkit, |     |     |     | accessed |
July2025.
[21] H.Kaur,A.Malhi,andS.Kumar,“Asurveyofdatacollectionmethods
| for | machine learning,” | Journal | of Big | Data, vol. | 8, no. | 1, pp. 1–32, |
| --- | ------------------ | ------- | ------ | ---------- | ------ | ------------ |
2021.
[22] A.Mohammadshirazi,A.N.Firoozsalari,M.Zhou,D.Kulshrestha,and
| R. Ramnath, | “Docparsenet: | Advanced |     | semantic | segmentation | and ocr |
| ----------- | ------------- | -------- | --- | -------- | ------------ | ------- |
embeddingsforefficientscanneddocumentannotation,”arXivpreprint
arXiv:2406.17591,2024.
| [23] A. Radford, | J. W. | Kim, C. Hallacy, |     | A. Ramesh, | G. Goh, | S. Agarwal, |
| ---------------- | ----- | ---------------- | --- | ---------- | ------- | ----------- |
G.Sastry,A.Askell,P.Mishkin,J.Clarketal.,“Learningtransferable
| visual                           | models from | natural    | language                       | supervision,” | in         | International |
| -------------------------------- | ----------- | ---------- | ------------------------------ | ------------- | ---------- | ------------- |
| conferenceonmachinelearning.     |             |            | PmLR,2021,pp.8748–8763.        |               |            |               |
| [24] B. Fong                     | and D. I.   | Spivak, An | Invitation                     | to Applied    | Category   | Theory:       |
| SevenSketchesinCompositionality. |             |            | CambridgeUniversityPress,2019. |               |            |               |
| [25] S. Karimi,                  | A. Karimi,  | and A.     | Vahidi,                        | “Level-k      | reasoning, | deep rein-    |
forcementlearning,andmontecarlodecisionprocessforfastandsafe
automatedlanechangeandspeedmanagement,”IEEETransactionson
IntelligentVehicles,vol.8,no.6,pp.3556–3571,2023.
[26] M.Ren,W.Zeng,B.Yang,andR.Urtasun,“Learningtoreweightex-
amplesforrobustdeeplearning,”InternationalConferenceonMachine
Learning(ICML),2018.
| [27] L. Jiang, | L. Mou, | Z. Li, and | G. Neubig, | “Deliberate | practice | in data |
| -------------- | ------- | ---------- | ---------- | ----------- | -------- | ------- |
selectionforefficientlearning,”NeurIPS,2021.
[28] T.Wu,S.Ma,D.Dey,H.Zhang,T.Mitra,X.Geng,andZ.Yu,“Adaptive
dataselectionforlabelingviareinforcementlearning,”ACL,2023.
[29] X.Qin,Z.Zhang,C.Huang,M.Dehghan,O.R.Zaiane,andM.Jager-
| sand, | “U2-net: Going | deeper | with nested | u-structure | for | salient object |
| ----- | -------------- | ------ | ----------- | ----------- | --- | -------------- |
detection,”Patternrecognition,vol.106,p.107404,2020.
| [30] A. Singla, | L. Yuan,                | and T. Ebrahimi, |       | “Food/non-food | image     | classifi-  |
| --------------- | ----------------------- | ---------------- | ----- | -------------- | --------- | ---------- |
| cation          | and food categorization |                  | using | pre-trained    | googlenet | model,” in |
Proceedingsofthe2ndinternationalworkshoponmultimediaassisted
dietarymanagement,2016,pp.3–11.

APPENDIX TABLEV
SEMANTICCATEGORIZATIONACCURACYBYSUBCATEGORY
A. Implementation Details (FOOD-MNIST)
A.1 System Architecture and Dependencies: MNIST-Gen MainCategory Subcategory CLIPScore Accuracy(%)
is implemented in Python 3.8+ using OpenAI’s CLIP model
SlicedBread 0.782 91.2
(ViT-B/32) for semantic understanding, PIL and OpenCV Bread WholeLoaves 0.756 87.8
for image processing, PyTorch for deep learning models RollsandBuns 0.734 85.3
and the RL agent, scikit-learn for classical machine learning MilkandLiquid 0.812 93.5
algorithms, and NumPy/Pandas for data manipulation. The Dairy Cheese 0.789 89.7
YogurtandCream 0.723 82.1
framework retrieves images through Unsplash and Kaggle
CakesandPastries 0.767 88.4
APIs.
Dessert IceCream 0.798 90.6
The system follows a modular architecture comprising five Cookies 0.742 84.9
core components. The Retrieval Module handles keyword-
based image collection from multiple sources. The Semantic
ModuleperformsCLIP-basedanalysisandhierarchicalcatego-
B.3 Reinforcement Learning Performance: The RL agent
rizationusingourstructuredapproach.TheProcessingModule
demonstrated significant improvement during training across
implementsthreeintelligentmodesadaptedtodifferentdataset
both datasets. For Tree-MNIST, the agent achieved 89.3%
sizes and accuracy requirements. The Transformation Module
decision accuracy with an average episode reward of 0.67
executes the category-theoretic pipeline for image preprocess-
after 1000 training episodes. Food-MNIST training reached
ing. Finally, the RL Module contains the Deep Q-Learning
85.1% accuracy with an average reward of 0.54, reflecting
agent for adaptive filtering based on semantic understanding
the increased complexity of the 10-class problem. The reward
and human feedback.
function successfully balanced semantic confidence, class dis-
A.2 Hyperparameter Configuration: The CLIP model uses tribution entropy, model accuracy, and redundancy reduction
the ViT-B/32 architecture with 512-dimensional embeddings, throughout training.
text prompt templates “A photo of {category}” and “This is a
{subcategory}”, and a similarity threshold of 0.3 for filtering.
C. Category Theory Formalization Details
Thereinforcementlearningagentemploysa3-layerMLPwith
256, 128, and 64 hidden units, trained using Adam optimizer C.1 Morphism Composition Proofs: Following the defini-
with learning rate 0.001, epsilon-greedy exploration (ϵ=0.1, tions in III-C, we formally verify the functorial properties of
decayrate0.995),experiencereplaybufferof10,000samples, our transformation pipeline. Let T : D → D be the i-th
i i i+1
batch size 32, and target network updates every 100 steps. transformation morphism.
Reward function weights are set to λ 1 =0.4, λ 2 =0.3, λ 3 = Identity Preservation:
0.2, λ =0.1.
4
The image processing pipeline initially resizes images to F(id )=id (17)
X F(X)
224×224forCLIPprocessing,thentransformstofinalMNIST
sizeof28×28(configurableto64×64).Grayscaleconversion
For any image x∈X, applying the identity transformation
uses weighted RGB averaging (0.299R+0.587G+0.114B), and then the functor F yields the same result as applying F
binarization applies Otsu’s method or RL-learned adaptive
first and then the identity in the target category.
thresholds, and normalization scales to [0,1] range with µ =
Composition Preservation:
0.5, σ =0.5.
F(g◦f)=F(g)◦F(f) (18)
B. Detailed Experimental Results
To justify functoriality in our context, without loss of
generality, assume that the two composable preprocessing
TABLEIV
morphisms f :X →Y and g :Y →Z are given by Resize
CONFUSIONMATRIXFORTREE-MNISTUSINGCNNMODEL
and Grayscale morphisms in I. Then, by the definition
Predicted of F this equality holds because our preprocessing functions
Actual
Broadleaf Cactus Coniferous Palm are implemented as pure, deterministic transformations with
consistent domain and codomain types. Therefore, the com-
Broadleaf 296 19 25 10
Cactus 10 308 5 10 position law of functors is preserved in practice within our
Coniferous 25 10 298 15 system.Moregenerally,thisensuresthatcomposinganygiven
Palm 15 21 6 314 pair of transformations f′ : X′ → Y′ and g′ : Y′ → Z′ in
the source category I and then applying F is equivalent to
B.1 Confusion Matrices: applyingF toeachtransformationandcomposinginthetarget
B.2 Hierarchical Categorization Performance: category M. □

C.2 Natural Transformation Examples: Consider two func- foliage, glossy leaves, dense canopy), and flowering species
tors F and F representing different preprocessing pipelines: (visible blooms, ornamental features, colorful appearance).
1 2
• F 1 : Standard grayscale conversion Cacti encompass columnar forms (tall vertical stems, ribbed
• F 2 : Adaptive histogram equalization followed by surface, minimal branching), barrel/round shapes (compact
grayscale spherical form, clustered spines), and branching/pad varieties
(segmented structure, flat surfaces, complex growth).
Any natural transformation η : F ⇒ F provides a
1 2
Coniferoustreesspanpine/firspecies(needleleaves,conical
systematic way to compare these approaches across all input
shape, pyramid form), spruce/cedar varieties (dense clusters,
datasets while preserving the categorical structure.
drooping branches, aromatic wood), and juniper/cypress types
D. Computational Analysis (varied needles, irregular shape, drought tolerance). Palm cat-
The computational complexity scales predictably with the egories include fan palms (radiating fronds, palmate structure,
size of the dataset and the component of the model. Image umbrella canopy), feather palms (pinnate leaves, graceful
retrievaloperateslinearlywiththenumberofrequestedimages arching, flowing appearance), and coconut/date palms (tall
O(n). CLIP embedding computation requires O(n·k) time curved trunks, fruit clusters, coastal adaptation).
wherek representsembeddingcomputationoverhead.Seman-
ticanalysisdominatesthepipelinewithO(n·m·s)complexity, F. Error Analysis and Edge Cases
where m denotes main categories and s subcategories. RL F.1 Common Misclassification Patterns: Analysis of classi-
decision-making adds O(n·d) overhead for decision network fication errors reveals systematic patterns:
forward passes, while image transformation requires O(n·p)
• Visual Similarity: Fried chicken vs. fried fish (both
for pixel operations. The total pipeline complexity becomes
golden, crispy)
O(n·(k+m·s+d+p)), dominated by semantic analysis
• Context Confusion: Trees in pots vs. houseplants
operations.
• Preparation Variations: Raw vs. cooked food items
Memory requirements scale with dataset size and model
• Scale Issues: Close-up food shots vs. full-plate presenta-
complexity.TheCLIPmodelconsumesapproximately400MB
tions
GPU memory, image buffers require n×h×w×c bytes for
batch processing, RL replay buffer uses roughly 50MB for
TABLEVI
10,000experiences,andsemanticfeaturesdemandn×512×4
SEMANTICFILTERINGRESULTSBYERRORTYPE
bytes for float32 storage. These requirements remain manage-
able for typical dataset generation scenarios while enabling ErrorType BeforeFiltering AfterFiltering Improvement
efficient batch processing of large image collections.
WrongObject 23.4% 8.7% 62.8%
PoorQuality 18.9% 4.2% 77.8%
E. Complete Hierarchical Structure Specifications ContextMismatch 15.6% 6.1% 60.9%
AmbiguousCategory 12.3% 7.8% 36.6%
E.1 Food-MNIST Hierarchy Summary: The Food-MNIST ScaleIssues 9.8% 3.9% 60.2%
datasetemploysacomprehensive10-category,30-subcategory TotalErrorRate 80.0% 30.7% 61.6%
structure. Bread categories include sliced bread (rectangu-
lar slices, uniform thickness), whole loaves (crusty exterior,
F.2 Semantic Filtering Effectiveness:
round/oval shape), and rolls/buns (individual portions, soft
texture). Dairy products encompass milk/liquid dairy (white G. Reproducibility Guidelines
liquid, containers), cheese (yellow/white blocks, slices), and
G.1 Experimental Configuration: All experimental param-
yogurt/cream (thick consistency, creamy texture). Desserts
eters are specified through JSON configuration files to ensure
span cakes/pastries (frosted layers, colorful icing), ice cream
reproducible results across different computing environments.
(frozen scoops, cold treats), and cookies/sweets (bite-sized,
Thehierarchicalcategorydefinitions,semanticcharacteristics,
chocolate pieces).
and processing parameters are fully documented and version-
Egg preparations include whole eggs (oval shape, visible
controlled.
shells),fried/scrambledvarieties(yellowyolk,cookedtexture),
G.2 Implementation Notes: The MNIST-Gen framework
and complex egg dishes (omelets, prepared mixtures). Fried
is implemented as a modular system with clear separation
foods categorize chicken/poultry (golden coating, crispy tex-
between image retrieval, semantic analysis, hierarchical cat-
ture), fries/chips (stick shape, potato color), and other fried
egorization, and transformation components. Each module
items (crispy batter, oil-cooked). Meat classifications cover
can be independently configured and tested, facilitating both
rawmeat(redcolor,butchercuts),grilled/roastedpreparations
reproduction and extension of the work.
(brown cooked, grill marks), and processed varieties (sausage
shape, deli cuts).
H. Evaluation Metrics
E.2 Tree-MNIST Botanical Structure: Tree-MNIST im-
plements a 4-category, 12-subcategory botanical hierarchy. To evaluate the performance of our models on the multi-
Broadleaftreesincludedeciduousvarieties(seasonalleafdrop, class classification task, we used the following standard met-
broad canopy, autumn colors), evergreen types (year-round rics:

• Accuracy: The overall proportion of correct predictions:
(cid:80)N
TP
Accuracy= i=1 i
(cid:80)N
(TP +FP +FN )
i=1 i i i
• Precision(Weighted):Theweightedaverageofper-class
precision scores:
N
Precision =
(cid:88)n
i ·
TP
i
weighted n TP +FP
i i
i=1
where n is the number of true samples in class i, and
i
n=
(cid:80)N
n is the total number of samples.
i=1 i
• Recall (Weighted): The weighted average of per-class
recall scores:
N
Recall =
(cid:88)n
i ·
TP
i
weighted n TP +FN
i i
i=1
• F1 Score (Weighted):Theweightedaverageofper-class
F1 scores:
N
F1 =
(cid:88)n
i ·
2·Precision
i
·Recall
i
weighted n Precision +Recall
i i
i=1
Here,TP ,FP ,andFN denotethenumberoftruepositives,
i i i
false positives, and false negatives, respectively, for class i.
Weighted averaging ensures that metrics are not biased by
class imbalance, assigning more importance to classes with
more true samples.
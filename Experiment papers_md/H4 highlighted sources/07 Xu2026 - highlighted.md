Environment, Development and Sustainability
https://doi.org/10.1007/s10668-026-08213-4
Threshold-based multi-scale analysis of thermal-acoustic
comfort in urban public spaces: identifying critical thresholds
and individual heterogeneity
Lu Xu1 · Wenqiang Jing2,3 · Wei Ding4 · Jing He5 · Zhemin Ge2,3 · Yousen Ai6
Received: 11 January 2026 / Accepted: 12 October 2026
© The Author(s), under exclusive licence to Springer Nature B.V. 2026
Abstract
Outdoor users encounter thermal and acoustic conditions simultaneously, and pooled com-
fort scores may obscure differences among respondents. We analysed 975 valid question-
naires paired with concurrent environmental measurements at a university plaza in Xi’an
to examine response thresholds, conditional associations and heterogeneity. The analysis
combined established approaches: piecewise regression, regression trees, K-means cluster-
ing, random forest interpretation using Shapley additive explanations (SHAP), and partial
dependence analysis. The thermal-sensation curve changed slope near 30 ℃. A thermal-
comfort breakpoint was estimated at 29.95 ℃, but the comparison with a linear model did
not meet the 0.05 significance criterion. Acoustic sensation had an estimated breakpoint
of 64.8 dB, while acoustic comfort declined without a significant breakpoint. Clustering
yielded three response profiles. Under the combined high-temperature and high-sound-
level condition, thermal comfort was 0.63 units below the additive prediction. Tempera-
ture accounted for the largest reported SHAP contribution to thermal comfort. The find-
ings motivate local tests of coordinated shading and sound management, together with
alternative outdoor settings for users with different preferences. Validation at other sites
is needed before applying the thresholds or profile-based recommendations more widely.
Keywords Thermal comfort · Multi-scale analysis · Threshold identification · Individual
heterogeneity · Machine learning · Urban public spaces
1 Introduction
In urban public spaces, occupants experience multiple environmental factors at once. Ther-
mal and acoustic stimuli interact with the human mind and body, shaping perceptions such
as thermal sensation and acoustic comfort (Yang et al., 2022; Jin et al., 2020). As climate
change and urbanization accelerate, urban heat islands and traffic noise frequently occur
together. This means that exposure to multiple environmental sources is now common (Hsu
et al., 2021; Nieuwenhuijsen, 2021). Single-factor management strategies, like only reduc-
Extended author information available on the last page of the article

L. Xu et al.
ing temperature or noise, often fail to improve comfort. These approaches overlook how
combined factors affect human comfort (Jiang et al., 2025). Therefore, a key research prior-
ity is to identify, quantify, and interpret the nonlinear effects and interactions of multiple
thermal and acoustic factors on outdoor comfort using a unified assessment framework.
To investigate these relationships, this study develops a multi-scale analytical framework
to identify environmental thresholds and account for individual heterogeneity. Traditional
approaches either ignore heterogeneity, hurting individual prediction, or treat it as noise. Our
framework uses three analytical scales: population-level pattern identification, subgroup-level
heterogeneity characterization, and individual variability quantification. We combine statistical
threshold detection and machine learning interpretability to generate actionable design insights.
This study advances the field through two key innovations: first, systematic identification
and quantification of significant interactions among multiple environmental factors (particu-
larly thermal-acoustic factors) in urban public spaces; second, investigation of critical thresh-
old intervals at which these interactions influence human comfort perception. The paper
is organized as follows: Sect. 2 reviews the relevant literature and research gaps; Sect. 3
describes the study area, data collection, and analytical methods; Sect. 4 presents the results;
Sect. 5 discusses their interpretation and theoretical implications; Sect. 6 sets out policy
implications; and Sect. 7 presents the conclusion, limitations, and future research directions.
2 Literature review
2.1 Physiological models and statistical approaches
Existing research has explored these issues from multiple paradigms and made important
advances. First, classical thermal comfort models based on physiological and energy bal-
ance principles—such as Predicted Mean Vote (PMV) and Physiological Equivalent Tem-
perature (PET)—have established quantitative relationships between climatic parameters
and thermal sensation votes, providing a scientific foundation for evaluating thermal envi-
ronmental main effects (Yang et al., 2022; Du et al., 2022). These models assume that under
steady-state conditions, individual factors contribute independently to comfort; their sim-
plified human thermal balance framework has been widely applied to indoor and outdoor
thermal comfort assessments and standard development (Du et al., 2022). Second, statistical
analysis paradigms have examined associations between environmental factors and com-
fort scores through field surveys and experimental data using methods such as multiple
regression and analysis of variance. A series of empirical studies have identified the primary
influences of air temperature, radiation, humidity, and wind speed on thermal sensation and
comfort votes, constructing empirical models for specific regions (Pompei et al., 2024; Fang
et al., 2021). Some studies have begun incorporating simple interaction terms (e.g., solar
radiation × wind speed) to examine synergistic effects (Li et al., 2020). Such statistical mod-
els intuitively reveal how key factors operate differently across various climatic contexts.
2.2 Machine learning and model interpretability
Machine learning methods—including support vector machines, neural networks, and Ran-
dom Forest models—have recently been introduced to comfort research to improve pre-
1 3

Threshold-based multi-scale analysis of thermal-acoustic comfort in…
diction accuracy (Zhou et al., 2020). Compared to linear models, machine learning can
automatically capture complex nonlinear relationships, with studies demonstrating that their
prediction accuracy for thermal comfort votes significantly outperforms traditional regres-
sion methods (Zhou et al., 2020). Additionally, researchers now apply interpretable tools to
comfort-focused machine learning models to extract mechanistic patterns (Lin et al., 2025).
These research trajectories, emphasizing theoretical model refinement, statistical validation,
and prediction performance enhancement respectively, have collectively advanced the field
of outdoor thermal and acoustic comfort.
2.3 Combined thermal and acoustic environments
However, significant gaps remain in existing research regarding multi-factor interaction
effects. First, classical models and most statistical analyses implicitly assume that environ-
mental factor influences are independent and linearly additive. This single-modal thinking
neglects nonlinear threshold effects and amplification/buffering mechanisms between fac-
tors under extreme or compound exposure scenarios. When interaction terms are ignored,
the coexistence of multiple adverse factors leads to biased comfort assessments, and
intervention strategies may fail due to misidentified mechanisms (Chen et al., 2024). For
instance, research has shown that noise levels can influence thermal sensation evaluations:
reducing excessive background noise helps improve outdoor thermal comfort perceptions
(Ning et al., 2025); conversely, under conditions combining high temperature with intense
noise, overall comfort decreases significantly accompanied by heightened irritability and
discomfort (Chen et al., 2023). However, such thermal-acoustic interaction effects have
been observed only in limited contexts and have not been systematically quantified within
a unified framework. Second, thermal comfort and acoustic comfort research have long
remained independent, resulting in modal separation between thermal and acoustic environ-
ments (Wen et al., 2025). Most outdoor comfort studies focus on dominant factors of heat
stress or thermal sensation (Pompei et al., 2024; Fang et al., 2021; Li et al., 2020), while oth-
ers emphasize soundscape perception and acoustic comfort evaluation (Ozturk et al., 2025).
This disciplinary segregation hinders comprehensive understanding of human responses to
multisensory integrated stimuli.
2.4 Research gaps and study rationale
Despite these advances, three connected gaps remain in outdoor thermal–acoustic comfort
research. First, existing studies provide limited context-specific evidence on the nonlin-
ear thresholds and combined environmental conditions associated with changes in thermal
and acoustic responses. Second, thermal and acoustic comfort are often examined sepa-
rately, leaving insufficient evidence on their joint relationships within the same outdoor field
dataset. Third, average-response models and feature rankings provide limited insight into
response heterogeneity among users and into how multivariable findings can be translated
into practical, subject-oriented management actions. The present study addresses these gaps
by integrating piecewise regression, conditional tree analysis, response-profile clustering,
random-forest attribution and partial-dependence analysis to examine threshold intervals,
joint exposure patterns and response heterogeneity within one field dataset.
1 3

L. Xu et al.
3 Methods
3.1 Study area
Xi'an (108°56'E, 34° 15′ 44″ N) is located in northwestern China and serves as the capital of
Shaanxi Province. According to China's climate zoning standards (GB 50176 1993), Xi'an
belongs to the cold region and is influenced by East Asian monsoons, with hot and humid
summers and cold, dry winters. Climatic data from 2010 to 2019 showed that the monthly
average maximum temperature in July reached 28.07℃, with an extreme maximum of
39.1℃, while the monthly average minimum temperature in January was 0.49℃, with an
extreme minimum of −8.4℃. Annual average relative humidity fluctuated between 53.11%
and 73.83% (C.M, Administration, 2020).
A typical student exchange plaza on the campus of Xi'an Eurasia University was selected
as the survey site. The plaza serves as a primary recreational space for students' extracur-
ricular activities and is divided into ground-level and sunken sections. It comprises planting
pools (26% of area), water sculpture (2%), shading pergolas (2%), stone-paved surfaces
(66%), and linear seating (4%), with a small number of trees distributed across the area
(Fig. 1). The environmental characteristics of this plaza were suitable for investigating the
effects of different environmental factors on comfort.
3.2 Experimental design
3.2.1 Meteorological parameter measurement
The experiment was conducted from March to July 2024, covering the transitional sea-
son and summer. Considering Xi'an's large diurnal temperature range, survey periods were
Fig. 1 Site locations
1 3

Threshold-based multi-scale analysis of thermal-acoustic comfort in…
scheduled from 9:00 to 17:00 to avoid extreme temperature conditions in early morning and
late evening. Surveys were conducted under weather conditions suitable for outdoor activi-
ties, such as sunny or partly cloudy days, excluding anomalous weather conditions like rain
or snow that could interfere with measurements.
Before each survey session, the instruments were calibrated Sensors were positioned
1.5 m above the ground at the questionnaire location. This fixed height was used as a stan-
dardized meteorological reference for near-surface ambient air conditions: it reduces the
direct influence of rapidly varying ground-surface temperatures while remaining relevant
to the occupied outdoor environment. The analysed environmental variables were outdoor
air temperature (T, ℃), relative humidity (RH, %), wind speed (m/s), solar radiation (SR,
W/m) and Sound level (N, dB). Meteorological values were logged at one-minute intervals.
For each questionnaire, the interval from the beginning to the end of questionnaire comple-
tion and the corresponding survey location defined the matching window. All one-minute
meteorological records from that location whose timestamps fell within this window were
selected, and the arithmetic mean of each variable was assigned to that individual response.
During the same questionnaire-completion period, at least 20 sound-pressure-level readings
were collected and their arithmetic mean was assigned to the response. The sound variable
is therefore reported as the arithmetic mean sound level in dB. Instrument details are listed
in Table 1.
3.2.2  Questionnaire survey
Data were collected through questionnaire surveys. Respondents were randomly selected at
measurement points, and meteorological data were measured synchronously during ques-
tionnaire completion to ensure data accuracy and timeliness. During participant recruit-
ment, potential respondents were approached from the available pedestrians at the survey
locations. When several eligible individuals were available, the survey staff preferentially

Table 1 Instrument parameter  Instrument Measuring  Measurement  Work
| table |                    | range accuracy      | environment  |
| ----- | ------------------ | ------------------- | ------------ |
|       | Sound-level detec- | 30db-120db  ± 0.5db | Air          |
|       | tor (noise0501)    |                     | temperature: |
−40% ~ + 60%
Relative
humidity:
25% ~ 90%
|     | Wind speed         | 0.2 m/s-  ± 0.02 m/s     | −10℃ ~  |
| --- | ------------------ | ------------------------ | ------- |
|     | detector(wind0501) | 10 m/s                   | + 50℃   |
|     | Black ball tem-    | Illumina- Humidity:      | /       |
|     | perature/Humidity  | tion:  ± 0.3℃, ± 2%RH    |         |
|     | detector           | 0 ~ 65535 lx Black ball: |         |
Humidity:  ± 0.5℃
−40℃ ~
+ 125℃
Black ball:
−10℃ ~
+ 85℃
|     | Bolometer  | Global   ± 5%W/m2 | /   |
| --- | ---------- | ----------------- | --- |
|     | (JT2020)   | radiation         |     |
0 ~ 2KW/m2
1 3

L. Xu et al.
selected participants with broadly comparable clothing layers and visual clothing charac-
teristics to reduce clothing-related heterogeneity. The questionnaire comprised two sections
(detailed in Appendix A): The first section collected respondents' basic information, includ-
ing age, gender, and physical activity status over the past 20 min, with metabolic activity
referenced to standard metabolic rates. The second section assessed respondents' percep-
tions of thermal and acoustic environments, encompassing Thermal Sensation Vote (TSV),
Thermal Comfort Vote (TCV), Acoustic Sensation Vote (ASV), and Acoustic Comfort Vote
(ACV).
Following ASHRAE standards, a 7-point Likert scale was employed to measure each
dimension: TSV (−3 = Cold, −2 = Cool, −1 = Slightly Cool, 0 = Neutral, 1 = Slightly Warm,
2 = Warm, 3 = Hot); TCV(−3 = Severe Discomfort, −2 = Discomfort, −1 = Slightly Discom-
fort, 0 = Neutral, 1 = Slightly Comfortable, 2 = Comfortable, 3 = very comfortable); ASV
(−3 = Very Quiet, −2 = Quiet, −1 = Slightly Quiet, 0 = Neutral, 1 = Slightly Loud, 2 = Loud,
3 = Very Loud); and ACV (scale identical to thermal comfort). Respondents could select
any scale value based on their actual perceptions. Experimental staff assisted respondents in
understanding the questionnaire content to ensure data authenticity. A total of 1,087 ques-
tionnaires were collected, yielding 975 valid responses.
3.3 Multi-scale threshold identification framework
As shown in Fig. 2, the workflow begins with concurrent environmental measurements and
questionnaire responses and then proceeds through complementary analytical stages. Piece-
wise regression estimates response breakpoints; classification and regression tree (CART)
analysis identifies conditional split rules; K-means clustering describes response profiles
from standardised TSV, TCV, ASV and ACV values; random-forest models quantify fit-
ted feature contributions using Shapley additive explanations (SHAP); and partial depen-
dence plots (PDPs) visualise fitted one- and two-dimensional response patterns. Bootstrap
intervals, cluster diagnostics and statistical comparisons provide supporting uncertainty and
group comparisons. Respondent-level analyses and models fitted to aggregated data are
distinguished because they refer to different units of analysis.
3.3.1 Piecewise linear regression for adaptive threshold detection
Piecewise regression was used to estimate a breakpoint in the relationship between an envi-
ronmental variable and a response. This is an established modelling approach; Muggeo
(2003) provides a methodological treatment of regression with unknown breakpoints. In this
study, the fitted slopes on either side of a candidate threshold were used to describe changes
in the response gradient.
The piecewise linear model assumes different linear relationships before and after an
unknown threshold t:
(1)
𝑎𝑎1𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥
𝑦𝑦𝑦( )
𝑎𝑎2𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥
where y represents comfort votes (TCV or ACV), x is the environmental variable (tempera-
ture or N), t is the threshold to be estimated, and a₁, a₂, b, and c are regression coefficients.
1 3

Threshold-based multi-scale analysis of thermal-acoustic comfort in…
Fig. 2 Overall methodology
The threshold and regression coefficients were estimated by minimising residual sum
of squares. Bootstrap resampling, following the general resampling principle introduced
by Efron (1992), was performed 1,000 times to obtain 95% confidence intervals (CIs). The
reported F-tests compare the piecewise specification with a linear specification; their inter-
pretation depends on the breakpoint-selection procedure.
3.3.2 Decision tree analysis for multi-variable interaction rules
CART regression trees were used to summarise conditional relationships between environ-
mental variables and each of the four vote outcomes. CART was introduced by Loh (2011);
it is not a model proposed in this study. A split partitions observations into two child nodes,
and each terminal node reports the mean response of the observations assigned to it.
Mean Squared Error (MSE) at each node was used to measure prediction error, as shown
in Eq. (2):
𝑆𝑆 (2)
1 2
𝑀𝑀𝑀𝑀𝑀𝑀𝑀 (𝑦𝑦𝑖𝑖−𝑦𝑦)
𝑀𝑀 𝑖𝑖𝑖𝑖
∑
1 3

L. Xu et al.
where S represents the sample set at the current node, yi is the actual value of the i-th
sample, and y is the mean of samples at the node.
At each split, the feature f and split point s that maximize error reduction were selected.
The MSE reduction is expressed in Eq. (3):
(3)
𝑀𝑀𝑆𝑆 𝑀𝑀𝑆𝑆
𝑀𝑀𝑀𝑀𝑀𝑀(𝑓𝑓𝑓𝑓𝑓)=𝑀𝑀𝑀𝑀𝑀𝑀(𝑀𝑀)−( ∗𝑀𝑀𝑀𝑀𝑀𝑀(𝑀𝑀𝑆𝑆)+ ∗𝑀𝑀𝑀𝑀𝑀𝑀(𝑀𝑀𝑆𝑆))
𝑀𝑀 𝑀𝑀
The Decision Tree construction procedure comprised four steps:
(1) at each node, a subset of features (controlled by hyperparameter mtry) was randomly
selected for splitting;
(2) MSE reduction (ΔMSE) after splitting was calculated for each feature, selecting the
feature and split point that maximized error reduction;
(3) if the node sample size exceeded the minimum split threshold (min_samples_split) and
tree depth had not reached maximum depth (max_depth), recursive splitting continued;
(4) leaf node output was the mean of target variable values for all samples at that node.
3.4 K-means clustering for heterogeneity modeling
K-means clustering (MacQuuen, 1967) was applied to the standardised response vec-
tor [TSV, TCV, ASV, ACV]. Candidate solutions with two to six clusters were compared
using the silhouette coefficient (Rousseeuw, 1987), Davies–Bouldin index (DBI) (Davies
& Bouldin, 1979) and interpretability. The adjusted Rand index (ARI) (Day, 1986) was
used to describe bootstrap agreement between cluster assignments. Analysis of variance
(ANOVA) comparisons describe differences in the variables used to form the clusters; they
do not independently establish that the groups represent stable personal traits. The resulting
groups are therefore interpreted as response profiles within this survey.
3.4.1 SHAP analysis for feature contribution quantification
Random forest regression (Breiman, 2001) provided the fitted models used for interpreta-
tion. Observations were aggregated by temperature, N and solar radiation before model
fitting. SHAP, introduced by Lundberg and Lee (2017), assigns feature contributions to
model predictions. The percentage summaries describe relative model attribution for each
outcome; they do not estimate percentages of a causal environmental effect.
3.4.2 Partial dependence plots for non-linear effect visualization
Partial dependence plots follow the model-interpretation approach described by Friedman
(2001). One-dimensional plots display the fitted response as a selected feature varies while
averaging over other feature values. Two-dimensional plots describe the fitted temperature–
sound response surface. The H-statistic of Friedman and Popescu (2008) summarises its
departure from an additive representation. These interpretations remain dependent on the
fitted model and the environmental combinations represented in the data.
1 3

Threshold-based multi-scale analysis of thermal-acoustic comfort in…
3.5 Statistical validation
All identified interactions were validated using two-way ANOVA with temperature and
noise as factors. Post-hoc pairwise comparisons used Tukey's HSD test with Bonferroni
correction (α = 0.05).
3.6 Software
Data analysis was performed using Python 3.13 and the Jupyter Notebook platform, com-
pleting the entire workflow of data preprocessing, model development, optimization, and
interpretation.
4 Results
4.1 Descriptive statistical analysis
Table 2 summarises the measured environmental conditions. T had a mean of 28.61℃ and
spanned 21–39℃, with most observations between 28 and 32℃. RH averaged 39.95%
14–77%, while SR averaged 289.26 W/m2 and varied substantially across observations.
The mean N was 57.6 dB and the upper observed value was 94 dB. Wind speed averaged
0.68 m/s, ranging from 0.23 to 2.21 m/s.
The distributions in Fig. 3 show a concentration of thermal comfort votes at slight dis-
comfort: TCV = − 1 accounted for 36.4% of responses, whereas severe discomfort (TCV =
− 3) accounted for 2.3%. Overall, 66% of respondents had TCV < 0 and 9% had TCV > 0.
The most common thermal sensation category was warm (TSV = + 2, 40.9%); slightly cool
(TSV = − 1) was selected by 4.7%. In total, 77.2% of responses indicated a TSV > 0 and
4.7% indicated TSV < 0.
Figure 4 indicates that ACV = − 1 (slight discomfort) was the most frequent acoustic-com-
fort response (38.6%), while ACV = + 2 (comfortable) occurred in only 0.2% of cases. The
proportion with ACV < 0 was 59%, compared with 9.2% with ACV > 0. For acoustic sensation,
neutral (ASV = 0) was most common at 31.8%; ASV = + 2 was least common at 0.2%. Quiet
responses (ASV < 0) represented 38.6%, and noisy responses (ASV > 0) represented 29.6%.
Pearson correlation analysis was performed to explore associations between environ-
mental variables and subjective perception votes. Results are shown in Table 3. TSV showed
significant positive correlations with air temperature and solar radiation (p < 0.01), indicat-
ing that increases in temperature and radiation were primary factors causing respondents
to feel warmer. TCV exhibited significant negative correlations with air temperature, solar
radiation, and N (p < 0.05), suggesting that intensification of these factors reduced thermal
Table 2 Environment variable statistics table
Variable Mean Standard deviation Minimum 25% Median (50%) 75% Maximum
T ℃ 28.61 5.08 21.0 24.0 28.0 32.0 39.0
RH % 39.95 18.54 14.0 20.0 37.5 55.25 77.0
SR W/m2 289.26 315.04 4.7 40.75 251.5 375.0 1368.1
N dBA 57.60 12.65 30.5 48.2 57.5 66.35 94.0
Wind Speed m/s 0.68 0.32 0.23 0.51 0.63 0.72 2.21
1 3

L. Xu et al.
Fig. 3 Distribution of TCV and TSV of Respondents
Fig. 4 Distribution of Respondents’ ACV and ASV
comfort. ASV showed significant positive correlations with relative humidity, solar radia-
tion, and N (p < 0.05), indicating that intensification of these factors made the environment
feel noisier. ACV exhibited significant negative correlations with air temperature, solar
radiation, and N (p < 0.05), demonstrating that intensification of these factors negatively
impacted acoustic comfort.
1 3

Threshold-based multi-scale analysis of thermal-acoustic comfort in…

Table 3 Correlation significance
| Variable | TSV | TCV ASV | ACV |
| -------- | --- | ------- | --- |
test table of each variable
| T ℃     | P 0.86   | −0.90 0.26   | −0.52* |
| ------- | -------- | ------------ | ------ |
|         | N 975    | 975 975      | 975    |
| RH %    | P −0.049 | 0.21 0.48*   | 0.0013 |
|         | N 975    | 975 975      | 975    |
| SR W/m2 | P 0.73   | −0.68* 0.59* | −0.50* |
|         | N 975    | 975 975      | 975    |
| N dBA   | P −0.033 | −0.62* 0.91* | −0.81* |
Indicates that it is significant
|     | N 975 | 975 975 | 975 |
| --- | ----- | ------- | --- |
at the level of 0.01; * indicates
| Wind Speed m/s | P 0.0015 | 0.0993 0.0423 | 0.0293 |
| -------------- | -------- | ------------- | ------ |
that it is significant at the level
|     | N 975 | 975 975 | 975 |
| --- | ----- | ------- | --- |
of 0.05
4.2  Adaptive threshold identification
Piecewise linear regression identified critical environmental thresholds where subjective
responses change abruptly, conducted separately for all four outcome variables. Piecewise
regression results appear in Fig. 5.
4.2.1 Thermal thresholds
For TSV, piecewise regression identified a temperature threshold at 30.2℃ [95% CI: 27.5–
32.1℃]. Below this threshold, TSV increased moderately with temperature (slope = 0.08,
p = 0.003), while above it, the increase was steeper (slope = 0.18, p < 0.001). The piecewise
model outperformed the simple linear model (F = 3.24, p = 0.041), indicating a genuine non-
linear relationship.
For TCV, the critical threshold was identified at 29.95℃ [95% CI: 26.40–31.00℃].
Before this threshold, comfort decreased slowly (slope = −0.06, p = 0.021), but after the
threshold, the decline accelerated significantly (slope = −0.15, p < 0.001). The F-test showed
marginal significance (F = 2.89, p = 0.056), suggesting a trend toward nonlinearity. The nar-
rower confidence interval for TCV compared to TSV indicates greater stability in comfort
threshold estimation.
4.2.2  Acoustic thresholds
For ASV, a N threshold was detected at 64.8 dB [95% CI: 61.2–67.5 dB]. ASV increased grad-
ually below this threshold (slope = 0.03, p = 0.042) but more rapidly above it (slope = 0.08,
p < 0.001). The piecewise model was significantly better than linear (F = 4.12, p = 0.017).
For ACV, no statistically significant threshold was identified (F = 1.43, p = 0.232). The
relationship between N and ACV appears approximately linear throughout the observed
range, with a consistent negative slope (−0.04, p < 0.001). This suggests that acoustic com-
fort deteriorates gradually rather than abruptly with increasing N.
4.2.3  Cross-domain comparison
The evidence for a change in slope differs across outcomes. The reported model compari-
sons support breakpoints for TSV and ASV, whereas evidence for the TCV breakpoint is
1 3

L. Xu et al.
Fig. 5 Piecewise Regression Results
weaker and no significant ACV breakpoint was detected. These differences support analys-
ing sensation and comfort separately. They do not establish different physiological mecha-
nisms, which were not measured in this survey.
4.3 Multi-variable interaction rules
Decision tree analysis extracted interpretable rules showing how multiple environmental
factors jointly influence comfort. This study constructed separate trees for all four outcome
variables to identify domain-specific interaction patterns. Figure 6 presents the decision tree
structures.
4.3.1 Thermal domain trees
For TSV, the decision tree revealed a hierarchical structure dominated by temperature (fea-
ture importance: 82.3%), followed by solar radiation (15.2%), relative humidity (2.5%), and
N (0.0%). The primary split occurred at T = 30.5℃, closely matching the piecewise regres-
sion threshold. Above this temperature, a secondary split at SR = 500 W/m2 distinguished
high solar exposure conditions (TSV = 2.8 ± 0.3) from moderate exposure (TSV = 2.3 ± 0.4).
Cross-validation showed good stability (MSE = 0.65 ± 0.08 across 5 folds).
1 3

Threshold-based multi-scale analysis of thermal-acoustic comfort in…
Fig. 6 Decision Tree result
For thermal comfort (TCV), temperature again dominated (77.8%), with humidity play-
ing a larger role (17.5%) than in TSV. Solar radiation contributed 4.7%, while N remained
negligible (0.0%). The tree identified three critical temperature zones: comfortable (T < 28℃,
TCV = 2.4 ± 0.5), transitional (28 ≤ T < 32℃, TCV = 1.8 ± 0.6), and uncomfortable (T ≥ 32℃,
TCV = 1.0 ± 0.6). Within the uncomfortable zone, high humidity (RH > 60%) exacerbated
discomfort (TCV = 0.7 ± 0.5).
4.3.2 Acoustic domain trees
For ASV, N was the primary determinant (88.5%), followed by temperature (11.5%). The
key split occurred at N = 65 dB. Below this level, sensation remained low (ASV = 0.8 ± 0.5)
regardless of other factors. Above 65 dB, temperature modulated response: under cool con-
ditions (T < 28℃), high N was less disturbing (ASV = 1.4 ± 0.6) than under hot conditions
(T ≥ 28℃, ASV = 2.1 ± 0.5), suggesting thermal stress amplifies acoustic annoyance.
For ACV, the pattern differed substantially. While N still dominated (45.2%), relative
humidity contributed significantly (30.5%), followed by temperature (18.8%) and solar
radiation (5.5%). The primary split occurred at RH = 55%: in dry conditions (RH < 55%),
acoustic comfort remained relatively high (ACV = 2.1 ± 0.6) even with moderate N. In
humid conditions (RH ≥ 55%), comfort was more sensitive to N, with a secondary split at
N = 60 dB distinguishing acceptable (ACV = 1.9 ± 0.6) from unacceptable (ACV = 1.3 ± 0.7)
conditions. This unexpected humidity influence suggests that humid environments may
amplify sound annoyance or that humidity and N co-vary with other unmeasured factors.
1 3

L. Xu et al.
4.3.3 Cross-domain interaction patterns
Comparing the four trees reveals domain-specific interaction structures. TSV and TCV are
primarily temperature-driven with minor contributions from solar radiation and humidity.
Acoustic outcomes show more complex patterns: ASV is N-driven with thermal modula-
tion, while ACV involves substantial humidity effects. This divergence between sensation
and comfort in the acoustic domain—not observed in the thermal domain—suggests differ-
ent cognitive processes: sensation tracks physical stimuli directly, whereas comfort judg-
ments integrate broader contextual factors including moisture-related discomfort.
4.4 Preference heterogeneity modeling
The population-level analyses (3.2–3.3) revealed systematic patterns but also highlighted
a persistent problem: individual-level predictions showed poor performance (median
R2 = −0.12 for linear models). This negative R2 indicates that population-average models
fail to capture individual responses. This study hypothesized that this reflects genuine pref-
erence diversity rather than random N. To test this hypothesis, this study applied K-means
clustering on the four-dimensional response space (TSV, TCV, ASV, ACV) to identify dis-
tinct preference subgroups with different sensitivity profiles.
4.4.1 Cluster identification and validation
K-means clustering was performed on standardized response vectors for k = 2 to 6. Valida-
tion metrics supported k = 3 as optimal: Silhouette coefficient = 0.389 (> 0.3 threshold for
reasonable separation), Davies-Bouldin index = 1.12 (lowest among tested values), and
elbow method showed diminishing returns beyond k = 3. ANOVA confirmed significant
differences between clusters across all four dimensions (all p < 0.001). Bootstrap stability
analysis showed high consistency (mean ARI = 0.82 ± 0.05 across 100 resampled datasets),
indicating robust cluster structure. Figure 7 presents the clustering results.
4.4.2 Cluster profiles
Cluster 0 (n = 567, 58.2%): Heat-tolerant group. This largest cluster showed moderate
thermal sensation (TSV = 1.6 ± 0.7) and high thermal comfort (TCV = 2.2 ± 0.6) despite
warm conditions (T_mean = 30.3℃). Acoustic responses were neutral (ASV = 1.0 ± 0.6,
ACV = 2.0 ± 0.6). Post-hoc comparisons confirmed significantly higher TCV than other clus-
ters (Tukey HSD: vs. Cluster 1, p < 0.001; vs. Cluster 2, p < 0.001).
Cluster 1 (n = 254, 26.1%): Heat-intolerant group. This cluster reported high thermal
sensation (TSV = 2.3 ± 0.8) and low thermal comfort (TCV = 1.0 ± 0.7) at similar tempera-
tures (T_mean = 30.5℃), indicating heightened thermal sensitivity. Acoustic responses
were moderate (ASV = 1.2 ± 0.7, ACV = 1.7 ± 0.7). The thermal comfort deficit relative to
Cluster 0 (ΔTCV = −1.2, Cohen's d = 1.68) represents a large effect size, demonstrating
substantial preference heterogeneity.
Cluster 2 (n = 154, 15.8%): Heat-and-noise-sensitive group. This smallest cluster
showed high sensitivity to both thermal (TSV = 2.4 ± 0.9, TCV = 1.1 ± 0.8) and acoustic
1 3

Threshold-based multi-scale analysis of thermal-acoustic comfort in…
Fig. 7 K-means result
stressors (ASV = 1.9 ± 0.8, ACV = 1.2 ± 0.8). Despite similar environmental exposures,
this group reported significantly worse conditions across all dimensions (vs. Cluster 0:
all p < 0.001).
4.4.3 Implications for low individual R.2
The cluster analysis explains why population-average models fail at the individual
level. The three clusters have fundamentally different comfort response functions: a lin-
ear model fitted to pooled data represents an "average" that matches none of the actual
subgroups. Within-cluster model performance improved substantially: for Cluster 0, R2_
within = 0.41; Cluster 1, R2_within = 0.38; Cluster 2, R2_within = 0.35. While still mod-
est, these positive values contrast sharply with the negative R2 for the pooled model,
confirming that preference heterogeneity—not measurement noise—drives the individual
prediction problem.
4.5 Feature contribution analysis
SHAP analysis quantified each environmental factor's marginal contribution to comfort
outcomes. By analyzing all four outcome variables, we identified domain-specific drivers
and their relative importance. This feature-level analysis complements the population-level
rules (3.2–3.3) by providing quantitative attribution. Figure 8 presents the SHAP summary
plots for all outcomes.
1 3

L. Xu et al.
Fig. 8 SHAP result
4.5.1 Thermal domain feature contributions
For TSV, temperature dominated with 72.5% contribution, followed by solar radiation
(18.2%), relative humidity (7.8%), and N (1.5%). The SHAP values showed strong positive
correlation: high temperatures consistently pushed TSV toward higher values (mean SHAP
at T > 32℃: + 0.85), while low temperatures had negative effects (mean SHAP at T < 26℃:
−0.45). Solar radiation amplified thermal sensation primarily at high temperatures (interac-
tion effect), confirming its role as a secondary modulator.
For TCV, the contribution pattern differed slightly: temperature (45.8%), solar radiation
(25.6%), relative humidity (22.3%), and N (6.3%). Notably, humidity's contribution nearly
tripled compared to TSV, indicating that moisture plays a larger role in comfort judgments
than in sensation. SHAP dependence plots showed that humidity effects were most pro-
nounced at high temperatures (T > 30℃), where high humidity (RH > 60%) reduced comfort
by −0.4 units beyond temperature effects alone.
4.5.2 Acoustic domain feature contributions
For ASV, N expectedly dominated with 81.2% contribution, followed by temperature
(15.3%), relative humidity (2.8%), and solar radiation (0.7%). The strong N contribution
confirms that sensation primarily tracks physical stimuli. Temperature's non-trivial contri-
bution (15.3%) supports the decision tree finding of thermal modulation: high temperatures
amplify perceived loudness.
For ACV, the pattern was remarkably different: relative humidity (30.5%), tempera-
ture (28.8%), N (25.4%), and solar radiation (15.3%). This is the most balanced contri-
bution profile among all outcomes, with no single factor dominating. Notably, humidity
contributed more than N itself to acoustic comfort. SHAP dependence analysis revealed
1 3

Threshold-based multi-scale analysis of thermal-acoustic comfort in…
that high humidity (RH > 55%) reduced ACV by −0.5 units even at moderate N levels
(N < 65 dB). This suggests that acoustic comfort integrates general environmental quality
beyond N.
4.5.3 Cross-outcome comparison
Comparing feature contributions across outcomes reveals fundamental differences between
sensation and comfort, particularly in the acoustic domain. Thermal sensation and acoustic
sensation are both stimulus-dominated (single factor > 70%), consistent with direct percep-
tual processes. In contrast, comfort judgments integrate multiple environmental factors more
evenly. The divergence is most pronounced for acoustic outcomes: ASV is 81% N-driven,
while ACV has nearly equal contributions from humidity (30.5%), temperature (28.8%),
and N (25.4%). This suggests comfort is a higher-order cognitive judgment incorporating
contextual stressors beyond the target stimulus.
4.6 Nonlinear effects and interactions
Partial dependence plots visualized how each environmental factor influences outcomes
while marginalizing over other variables. Two-dimensional PDPs revealed interaction
effects between temperature and N. We analyzed all four outcomes to identify domain-
specific nonlinearities and synergies. Figure 9 presents the complete PDP results.
4.7 Main effects
For thermal outcomes, temperature showed strong nonlinear effects. TSV increased lin-
early below 28℃ (slope = 0.07) but accelerated above 30℃ (slope = 0.19), matching the
piecewise regression threshold. TCV declined slowly below 29℃ (slope = −0.05) but rap-
idly above 31℃ (slope = −0.16). Solar radiation showed threshold effects around 500 W/
m2: below this level, effects were minimal; above it, TSV increased by 0.3 units and TCV
decreased by 0.2 units. Humidity effects were modest and approximately linear for both
TSV (slope = 0.02 per 10% RH) and TCV (slope = −0.03 per 10% RH).
For acoustic outcomes, N showed different patterns. ASV increased approximately
linearly (slope = 0.04 per dB), with slight acceleration above 65 dB (slope = 0.06 per dB).
ACV declined linearly throughout the range (slope = −0.03 per dB) with no clear thresh-
old. Humidity showed unexpected strong effects on ACV: comfort decreased sharply above
RH = 55% (ΔACV = −0.5 from RH = 50% to RH = 65%). Temperature effects on acoustic
outcomes were modest: high temperatures (T > 32℃) reduced ACV by 0.3 units.
4.8 Two-dimensional interaction effects
The temperature × N 2D-PDPs revealed synergistic effects for all outcomes, with magnitude
varying by outcome type:
Thermal sensation (TSV): Two-way ANOVA showed significant main effects (T:
F = 125.6, p < 0.001; N: F = 8.3, p = 0.004) and a marginal interaction (T × N: F = 3.21,
p = 0.074). Under combined high stress (T > 32℃ + N > 65 dB), TSV = 2.8 ± 0.5, which is 0.3
units higher than the sum of individual effects (synergy = 0.3, t = 2.15, p = 0.032).
1 3

L. Xu et al.
Fig. 9 PDP results
Thermal comfort (TCV): Stronger interaction emerged (T: F = 142.3, p < 0.001; N:
F = 12.5, p < 0.001; T × N: F = 15.2, p < 0.001). Combined high stress reduced TCV to
0.8 ± 0.6, representing 0.63 units below additive predictions (synergy = −0.63, t = −3.95,
p < 0.001). This substantial negative synergy indicates that thermal and acoustic stressors
compound each other's detrimental effects on comfort beyond simple addition.
Acoustic sensation (ASV): Interaction was significant (T: F = 18.7, p < 0.001; N: F = 156.3,
p < 0.001; T × N: F = 8.6, p = 0.003). High temperature amplified N effects: at N > 65 dB, ASV
increased by 0.4 units more under hot (T > 32℃) than cool (T < 28℃) conditions (amplifica-
tion = 0.4, t = 2.89, p = 0.004), confirming that thermal stress heightens acoustic annoyance.
Acoustic comfort (ACV): Moderate interaction (T: F = 32.4, p < 0.001; N: F = 48.2,
p < 0.001; T × N: F = 6.8, p = 0.009). Combined stress reduced ACV by 0.45 units beyond
additive effects (synergy = −0.45, t = −2.67, p = 0.008). The effect was less pronounced than
for TCV, but still statistically and practically significant.
4.8.1 H-statistic interaction strength
The H-statistic quantified interaction strength as proportion of total variance: TSV
(H2 = 0.12), TCV (H2 = 0.28), ASV (H2 = 0.15), and ACV (H2 = 0.19). TCV showed the stron-
gest interaction, indicating that thermal comfort is most sensitive to combined stressors.
The moderate H2 values (0.12–0.28) suggest that while main effects dominate, interactions
contribute meaningfully and should not be ignored in design applications.
1 3

Threshold-based multi-scale analysis of thermal-acoustic comfort in…
4.9 Critical environmental combinations
Integrating findings across all scales (population thresholds, subgroup preferences, feature
contributions, and interactions), we identified critical environmental combinations that war-
rant design attention:
4.9.1 High-risk combinations
(1) Extreme thermal stress: T > 32℃ + RH > 60% + SR > 500W/m2. Mean TCV = 0.6 ± 0.5,
85% of Cluster 1 and 92% of Cluster 2 report discomfort.
(2) Combined thermal-acoustic stress: T > 30℃ + N > 65 dB. TCV = 0.9 ± 0.6,
ACV = 1.2 ± 0.7, synergistic reduction affects all subgroups.
(3) Acoustic discomfort amplified by humidity: N > 60 dB + RH > 60%. ACV = 1.3 ± 0.7,
particularly problematic for Cluster 2 (ACV = 0.8 ± 0.6).
(4) Multi-stressor overload: T > 32℃ + N > 65 dB + RH > 60%. All outcomes degraded:
TSV = 2.7, TCV = 0.5, ASV = 2.0, ACV = 0.9
4.9.2 Acceptable ranges by subgroup
Based on cluster-specific tolerance levels (TCV ≥ 2 as "comfortable"), we determined
acceptable environmental ranges:
(1) Cluster 0 (heat-tolerant, 58%): T ≤ 32℃, N ≤ 68 dB, no specific RH constraint. Most
resilient group, comfortable under broad conditions.
(2) Cluster 1 (heat-intolerant, 26%): T ≤ 29℃, N ≤ 65 dB, RH ≤ 60%. Requires cooler condi-
tions and moderate humidity.
(3) Cluster 2 (multi-sensitive, 16%): T ≤ 28℃, N ≤ 60 dB, RH ≤ 55%. Most restrictive
requirements, vulnerable to combined stressors.
5 Discussion
We employed machine learning methods to investigate the independent and interactive
influences of multiple environmental factors on public comfort in urban public spaces. Our
core contribution is using Random Forest models and Partial Dependence Analysis (PDP)
to not only confirm the effects of individual environmental factors but, more importantly,
to identify and quantify nonlinear interaction effects characterized by significant thresholds.
This discussion centers on these interactions, analyzing the underlying physiological and
psychological mechanisms by referencing cutting-edge literature, and articulating theoreti-
cal contributions and practical implications.
5.1 Interaction effects and cross modal modulation
This study identified multiple interaction effects with decisive influences on comfort.
These findings share similarities with recent literature while highlighting unique contri-
1 3

L. Xu et al.
butions. First, within the thermal environment, a strong synergistic amplification effect
between temperature and solar radiation was confirmed. When temperature exceeded
30℃, the amplification effect of solar radiation on thermal discomfort intensified dramati-
cally. This finding aligns with numerous outdoor thermal comfort studies indicating that
under high-temperature conditions, solar radiation is a key driver of extreme heat stress
(Elsadek et al., 2024). For instance, Ouyang et al. (2024) demonstrated that increases in
solar radiation significantly elevate Physiological Equivalent Temperature (PET), particu-
larly in summer when its influence far exceeds that of other meteorological parameters
(Ouyang et al., 2024). The contribution of this study lies in quantifying, for the first time
through PDP analysis, the specific environmental thresholds triggering this synergistic
effect, thereby providing more precise intervention points for urban thermal environment
adaptive design and emphasizing the priority of shading strategies under high-tempera-
ture conditions (Ou & Lin, 2023).
Second, a core innovation of this study was revealing the cross-modal modulation effect
of N on thermal comfort. The combination of high temperature and high N was found to
significantly reduce thermal comfort, a result consistent with a growing body of laboratory
and field studies. For example, Peng et al. (2023) found in indoor experiments that expo-
sure to traffic N reduced respondents' thermal comfort evaluations, even under thermally
neutral conditions (Peng et al., 2023). This study validated and extended this finding in
complex outdoor environments, revealing that N acts as a "heat stress amplifier" under high
radiation. This finding provides robust field evidence for the "cumulative stressor model"
in environmental psychology (Tao et al., 2020) and challenges traditional thermal comfort
models (e.g., PMV/PET), which typically neglect acoustic environmental influences (Du et
al., 2023).
Third, a reverse modulation effect was also confirmed: thermal environment significantly
influences acoustic comfort. Under high-temperature conditions, equivalent N levels elic-
ited stronger annoyance. This aligns with multisensory integration theory (Chandrasekaran,
2017), which posits that the brain does not process information from different sensory
channels in isolation (Zhang et al., 2025). Although direct research on thermal effects on
acoustic perception remains limited, existing studies have suggested this possibility. For
instance, Chen et al. (2023) found that under high-temperature conditions, tourists' aversion
to adverse sound sources (e.g., mechanical noise, traffic noise) intensified, while preferences
for natural sound sources (e.g., birdsong, water sounds) became more pronounced (Chen
et al., 2023). This study further directly confirmed that heat stress systematically reduces
acoustic comfort evaluations. This finding reveals an important yet previously overlooked
moderating variable in the soundscape research field, complementing existing research that
predominantly focuses on visual landscape influences on auditory evaluations (Mohammad-
zadeh et al., 2023; Geng et al., 2022).
5.2 Potential mechanisms of interaction effects
The interaction effects identified in this study are rooted in comprehensive physiological
and psychological responses of the human body to multiple environmental stressors.
At the physiological level, the temperature × solar radiation interaction affects comfort
by enhancing total heat load, accelerating core body temperature elevation, and trigger-
ing stronger heat stress responses such as increased heart rate and elevated dehydration
1 3

Threshold-based multi-scale analysis of thermal-acoustic comfort in…
risk (Liu et al., 2024; Otani et al., 2019). When N intervenes as a third stressor, the
N × thermal environment interaction may stem from synergistic activation of physiologi-
cal stress systems. N itself can induce sympathetic nervous system excitation, leading to
the release of stress hormones such as cortisol (Daiber et al., 2019, 2020; Arregi et al.,
2024). When the body is already under heat stress, the additional physiological burden
imposed by N produces cumulative effects with heat stress. Recent neuroscience research
has found that stress signals from different sensory modalities may converge in brain
regions such as the amygdala and insula, jointly regulating emotional and autonomic
nervous responses (Šimić et al., 2021), providing a neural basis for the observed cross-
modal interactions.
At the psychological level, interaction effects are primarily manifested through cognitive
load and attentional resource allocation. High-noise environments themselves require individ-
uals to invest cognitive resources in suppression or adaptation, thereby increasing overall cog-
nitive load (Grenzebach & Romanus, 2022). When individuals are simultaneously in thermal
discomfort, limited attentional resources are divided between two negative stimuli. This "mul-
titasking" processing state amplifies negative emotional evaluations of each stimulus, explain-
ing why annoyance toward N intensifies significantly during hot, sun-exposed conditions.
5.3 Interpretation of preference heterogeneity
Identifying three preference subgroups addresses a persistent puzzle: why do individual
comfort predictions achieve low or negative R2 despite strong population trends? Tradi-
tional approaches assume uniform responses, attributing errors to measurement N or model
inadequacy. Our findings challenge this view. The tolerant group (58.2%) responds close
to population averages, but heat-intolerant (26.1%) and heat-and-noise-sensitive (15.8%)
groups show systematically different sensitivity profiles. When fitting a single model across
all participants, predictions necessarily fail for these subgroups.
5.4 Theoretical and methodological contributions
Theoretically, by providing quantitative evidence from authentic outdoor environments, this
study deepened understanding of environmental stress theory and multisensory integration
theory. Methodologically, it demonstrated the advantages of machine learning in decoding
complex human–environment interactions, aligning with the "data-driven" research trend in
the built environment field (Ali et al., 2024). For instance, many recent studies have begun
employing machine learning to predict outdoor thermal comfort (Guo et al., 2024; Liu et
al., 2024); however, the uniqueness of this study lies in focusing on PDP visualization and
threshold quantification of interaction effects while extending this approach to the thermal-
acoustic multisensory domain.
6 Policy implications
The recommendations below concern campus facilities teams, outdoor-event organisers
and public-space managers working in settings comparable to the surveyed plaza. They are
derived from the response patterns reported in Sects. 4.2–4.6 and address choices that these
1 3

L. Xu et al.
actors can make. Implementation should be assessed at occupied locations. The numerical
values are study-specific reference conditions for testing interventions, not regulatory expo-
sure limits or universally applicable comfort standards.
6.1 Prioritise shade at occupied locations during hot periods
The thermal-sensation breakpoint near 30℃, the steeper reported thermal-comfort decline at
higher temperatures, and the temperature–solar-radiation rules identify hot, sun-exposed occu-
pied areas as a priority for the campus facilities team. The TCV breakpoint comparison has
p = 0.056, so 29.95℃ should not be treated as a precisely established intervention threshold.
Facilities managers should first map seating, queues and gathering points that remain
exposed during the warmer part of the day. At these locations, they can prioritise shade pro-
vision, maintain shaded seating and offer shaded alternatives to exposed activity areas. The
reported tree split around 500 W/m2 can help identify the combinations to examine locally,
but it does not prescribe a universal radiation limit. Assessment should compare radiation,
air temperature and TCV distributions at occupied locations before and after the interven-
tion under comparable weather and activity conditions.
6.2 Avoid scheduling noisy activities in hot occupied areas
The reported temperature–sound interaction associates combined exposure above 32℃
and 65 dB with a 0.63-unit TCV reduction relative to an additive prediction. This finding
gives outdoor-event organisers and campus operations teams a reason to coordinate sound-
producing activities with thermal conditions, rather than selecting their locations and times
independently.
When hot conditions coincide with high Ns at occupied areas, organisers should consider
moving amplified activities to a cooler time or a separate location, directing loudspeakers
away from shaded rest areas, and separating maintenance activity from busy rest periods
where practicable. The 65 dB value is a reference from the study, not a legal noise limit.
Managers should evaluate the combined change in local temperature, N, TCV and ACV; a
quieter location should not be assumed to provide better overall comfort if it increases users’
solar exposure.
6.3 Provide accessible quiet and shaded alternatives
The clustering results describe three response profiles, including two groups with lower
reported comfort than the largest group. This variation supports a choice-based approach for
campus planners and public-space managers: provide quiet shaded seating alongside more
active social areas, rather than relying solely on one site-wide comfort target.
These alternatives should remain available during busy events and be easy to identify and
reach. Managers can use short, voluntary thermal and acoustic evaluations to check whether
improvements benefit users who remain dissatisfied with the main activity area. Monitoring
should report the distribution of comfort votes as well as the mean. Cluster labels should not
be assigned to individuals as fixed characteristics or used to restrict access. Their practical
role is to motivate a range of environmental options; specific subgroup thresholds require
independent validation before becoming design requirements.
1 3

Threshold-based multi-scale analysis of thermal-acoustic comfort in…
7 Conclusion
This study demonstrates that outdoor thermal-acoustic comfort follows complex, multi-
scale patterns that cannot be adequately captured by traditional single-scale analyses. By
implementing a comprehensive multi-scale analytical framework across population, sub-
group, and feature levels, we identified previously hidden mechanisms governing human
responses to combined environmental exposures in urban outdoor spaces.
At the population level, thermal and acoustic responses exhibit distinct threshold behav-
iors. Piecewise regression revealed critical inflection points at approximately 30℃ for ther-
mal sensation (95% CI: 26.4–31.0℃, F = 3.24, p = 0.041) and 64.8 dB for acoustic sensation
(95% CI: 61.2–67.5 dB, F = 4.12, p = 0.017). Beyond these thresholds, sensation votes accel-
erate nonlinearly, indicating physiological and psychological tipping points where tolerance
rapidly diminishes. Importantly, comfort trajectories differ from sensation: thermal com-
fort shows earlier degradation (threshold ~ 29.95℃) and stronger decline post-threshold,
while acoustic comfort exhibits no discrete threshold, instead following linear decay. This
sensation-comfort divergence suggests fundamentally different perceptual and evaluative
processes, with comfort integrating broader contextual factors beyond immediate stimulus
intensity.
The population-level analysis also revealed surprisingly low predictive power of tradi-
tional pooled regression models (R2 = −0.12 for general linear models), initially suggest-
ing weak environmental determinism. However, this finding proved critical in motivating
deeper investigation into subgroup heterogeneity rather than representing model failure.
K-means clustering in four-dimensional response space [TSV, TCV, ASV, ACV] identi-
fied three statistically distinct preference profiles, fundamentally reframing the interpreta-
tion of low population-level R2:
Cluster 0 (Heat-tolerant, 58.2%, n = 567): Exhibits moderate thermal sensation
(TSV = 1.6 ± 0.7) paired with high thermal comfort (TCV = 2.2 ± 0.6) and acoustic comfort
(ACV = 2.0 ± 0.6), suggesting adaptive capacity or preference for warmer conditions. This
majority subgroup tolerates temperatures up to 32℃ without severe discomfort.
Cluster 1 (Heat-intolerant, 26.1%, n = 254): Shows high thermal sensation (TSV = 2.3 ± 0.8)
but low thermal comfort (TCV = 1.0 ± 0.7), indicating heightened thermal sensitivity. This
subgroup experiences discomfort at temperatures above 29℃, requiring priority attention
in inclusive design.
Cluster 2 (Multi-sensitive, 15.8%, n = 154): Demonstrates sensitivity across multiple
domains (TSV = 2.4 ± 0.9, ASV = 1.9 ± 0.8) with low comfort on both thermal and acoustic
dimensions (TCV = 1.1 ± 0.8, ACV = 1.2 ± 0.8). This vulnerable subgroup requires the most
protective design interventions.
Critically, within-cluster models achieved substantially improved explanatory power
(R2 = 0.35–0.41), demonstrating that low population-level R2 reflects genuine diversity in
environmental preferences rather than model inadequacy or measurement error. This finding
challenges the implicit assumption of homogeneity in traditional outdoor comfort research
and validates the multi-scale approach. Cluster stability analysis (ARI = 0.82 ± 0.05 across
100 bootstrap iterations) and highly significant ANOVA tests (p < 0.001 for all four dimen-
sions) confirm these are robust, meaningful subpopulations rather than statistical artifacts.
SHAP analysis and partial dependence plots revealed distinct mechanistic patterns dif-
ferentiating sensation from comfort:
1 3

L. Xu et al.
Sensation outcomes (TSV, ASV) exhibit stimulus-driven patterns: thermal sensation
depends primarily on temperature (72.5% contribution) with modest solar radiation effects
(18.2%), while acoustic sensation is overwhelmingly N-driven (81.2%) with thermal
modulation (15.3%). These patterns align with psychophysical theories of direct stimulus
perception.
Comfort outcomes (TCV, ACV) demonstrate multi-factor integration: thermal comfort
shows more balanced contributions from temperature (45.8%), solar radiation (25.6%),
and humidity (22.3%), suggesting holistic environmental evaluation. Remarkably, acous-
tic comfort departs entirely from stimulus-driven models, with humidity contributing
most (30.5%), exceeding Nitself (25.4%). This counterintuitive finding suggests acoustic
comfort evaluation incorporates broader environmental quality perception, with humidity
potentially serving as a proxy for oppressive conditions or amplifying acoustic annoyance
through physiological pathways.
Partial dependence analysis quantified critical environmental interactions: the tempera-
ture × N interaction most strongly affects thermal comfort (synergy coefficient Δ = −0.63,
p < 0.001), indicating that hot, noisy environments produce disproportionately severe dis-
comfort beyond additive effects. Acoustic sensation also shows thermal amplification (Δ =
+ 0.4, p = 0.004), confirming that thermal stress heightens acoustic annoyance. These inter-
actions explain why design guidelines must address combined exposures rather than treat-
ing thermal and acoustic factors independently.
Integrating findings across scales reveals a coherent picture: population-level thresh-
olds represent average tipping points, but subgroup analysis shows these thresholds vary
systematically (heat-tolerant subgroup: T ≤ 32℃; heat-intolerant: T ≤ 29℃; multi-sensitive:
T ≤ 28℃). Feature-level analysis explains why comfort differs from sensation and why
certain combinations (T > 30℃ + N > 65 dB) are universally problematic. The multi-scale
framework thus provides complementary insights: population patterns inform general
guidelines, subgroup analysis identifies vulnerable populations, and feature-level mecha-
nisms explain underlying processes and interactions.
This study has several limitations. First, the geographic and climatic context of the sam-
ple was relatively homogeneous. Second, the model did not incorporate other potentially
influential factors such as air quality and visual landscape quality. Future research should
validate these interaction effects across more diverse urban spaces and climate zones, inte-
grating additional environmental dimensions to construct more comprehensive comfort
models. Moreover, although machine learning models excel at identifying associations and
interactions, they cannot inherently reveal causal relationships. The mechanisms discussed
remain inferential and require further validation through controlled experiments.
Supplementary Information The online version contains supplementary material available at h t t p s : / / d o i . o r g
/ 1 0 . 1 0 0 7 / s 1 0 6 6 8 - 0 2 6 - 0 8 2 1 3 - 4 .
Funding The study was supported by 2024, University-level Social Sciences Planning Fund Project: "Spatial
Environment Conservation and Construction around the Zhou Culture Ducheng Site in Xi'an" (Grant No.:
24SK05).
Data availability The datasets generated and/or analysed during the current study are not publicly available
due to the confidential nature of the ongoing large-scale research project of which this study is a part, but are
available from the corresponding author on reasonable request.
1 3

Threshold-based multi-scale analysis of thermal-acoustic comfort in…
Declarations
Consent to participate All the authors will participate in the review and publication process.
Consent for publication All the authors have given their consent to publish this study.
Competing interests The authors declare no conflict of interest.
References
Ali, U., Bano, S., Shamsi, M. H., Sood, D., Hoare, C., Zuo, W., & O’Donnell, J. (2024). Urban build-
ing energy performance prediction and retrofit analysis using data-driven machine learning approach.
Energy and Buildings, 303, 113768.
Arregi, A., Vegas, O., Lertxundi, A., Silva, A., Ferreira, I., Bereziartua, A., Cruz, M. T., & Lertxundi, N.
(2024). Road traffic noise exposure and its impact on health: Evidence from animal and human stud-
ies—chronic stress, inflammation, and oxidative stress as key components of the complex downstream
pathway underlying noise-induced non-auditory health effects. Environmental Science and Pollution
Research, 31(34), 46820–46839.
Breiman, L. (2001). Random forests. Machine Learning, 45(1), 5–32.
C.M, Administration. (2020). Blue book on climate change in China 2020. Science Press.
Chandrasekaran, C. (2017). Computational principles and models of multisensory integration. Current Opin-
ion in Neurobiology, 43, 25–34.
Chen, C., Schwarz, L., Rosenthal, N., Marlier, M. E., & Benmarhnia, T. (2024). Exploring spatial heterogene-
ity in synergistic effects of compound climate hazards: Extreme heat and wildfire smoke on cardiorespi-
ratory hospitalizations in California. Science Advances, 10(5), eadj7264.
Chen, Y., Chen, Z., Lin, S., Lin, X., Li, S., Li, T., & Dong, J. (2023). Thermal–acoustic interaction impacts
on crowd behaviors in an urban park. Forests, 14(9), 1758.
Daiber, A., Kröller-Schön, S., Frenis, K., Oelze, M., Kalinovic, S., Vujacic-Mirski, K., & Münzel, T. (2019).
Environmental noise induces the release of stress hormones and inflammatory signaling molecules
leading to oxidative stress and vascular dysfunction—Signatures of the internal exposome. Biofactors,
45(4), 495–506.
Daiber, A., Kröller-Schön, S., Oelze, M., Hahad, O., Li, H., Schulz, R., & Muenzel, T. (2020). Oxidative
stress and inflammation contribute to traffic noise-induced vascular and cerebral dysfunction via uncou-
pling of nitric oxide synthases. Redox Biology, 34, 101506.
Davies, D., Bouldin, D. (1979). A cluster separation measure, IEEE transactions on patter analysis and
machine intelligence.
Day, W. H. (1986). Foreword: Comparison and consensus of classifications. Journal of Classification, 3(2),
183–185.
Du, H., Lian, Z., Lai, D., Duanmu, L., Zhai, Y., Cao, B., & Hou, Z. (2022). Evaluation of the accuracy of
PMV and its several revised models using the Chinese thermal comfort Database. Energy and Build-
ings, 271, 112334.
Du, M., Hong, B., Gu, C., Li, Y., & Wang, Y. (2023). Multiple effects of visual-acoustic-thermal perceptions
on the overall comfort of elderly adults in residential outdoor environments. Energy and Buildings,
283, 112813.
Efron, B. (1992). Bootstrap methods: Another look at the jackknife. Breakthroughs in statistics: Methodology
and distribution (pp. 569–593). Springer New York.
Elsadek, M., Nasr, A., Guo, L., Gong, X., Hassan, A., & Zhang, D. (2024). Urban trees and elderly well-
being: Species-specific strategies for thermal comfort in heat-stressed cities. Forests, 16(1), 55.
Fang, Z., Zheng, Z., Feng, X., Shi, D., Lin, Z., & Gao, Y. (2021). Investigation of outdoor thermal comfort
prediction models in South China: A case study in Guangzhou. Building and Environment, 188, 107424.
Friedman, J. H. (2001). Greedy function approximation: A gradient boosting machine. Annals of statistics,
1189–1232. https://doi.org/10.1214/aos/1013203451
Friedman JH, Popescu BE, (2008). Predictive learning via rule ensembles.
GB 50176 1993, Code for thermal design of civil building.
Geng, Y., Hong, B., Du, M., Yuan, T., & Wang, Y. (2022). Combined effects of visual-acoustic-thermal com-
fort in campus open spaces: A pilot study in China’s cold region. Building and Environment, 209,
108658.
1 3

L. Xu et al.
Grenzebach, J., & Romanus, E. (2022). Quantifying the effect of noise on cognitive processes: A review of
psychophysiological correlates of workload. Noise and Health, 24(115), 199–214.
Guo, R., Yang, B., Guo, Y., Li, H., Li, Z., Zhou, B., & Wang, F. (2024). Machine learning-based prediction
of outdoor thermal comfort: Combining Bayesian optimization and the SHAP model. Building and
Environment, 254, 111301.
Hsu, A., Sheriff, G., Chakraborty, T., & Manya, D. (2021). Disproportionate exposure to urban heat island
intensity across major US cities. Nature Communications, 12(1), 2721.
Jiang, T., Krayenhoff, E. S., Martilli, A., Nazarian, N., Stone, B., Jr., & Voogt, J. A. (2025). Prioritizing urban
heat adaptation infrastructure based on multiple outcomes: Comfort, health, and energy. Proceedings of
the National Academy of Sciences of the United States of America, 122(19), e2411144122.
Jin, Y., Jin, H., & Kang, J. (2020). Combined effects of the thermal-acoustic environment on subjective evalu-
ations in urban squares. Building and Environment, 168, 106517.
Li, J., Niu, J., Mak, C. M., Huang, T., & Xie, Y. (2020). Exploration of applicability of UTCI and thermally
comfortable sun and wind conditions outdoors in a subtropical city of Hong Kong. Sustainable Cities
and Society, 52, 101793.
Lin, M, Chau, CK, Hou, HC, Tang, SK. (2025). Development of an interpretable machine-learning model for
capturing nonlinear dynamics of multisensory interactions in public open spaces. Building and Environ-
ment, 113072.
Liu, Q., Li, N., He, Y., Pan, J., & Chen, Y. (2024). Quantifying the effects of indoor non-uniform solar radia-
tion on human thermal comfort and work performance in warm season. Energy and Buildings, 306,
113962.
Liu, X., Gou, Z., & Yuan, C. (2024). Application of human-centric digital twins: Predicting outdoor thermal
comfort distribution in Singapore using multi-source data and machine learning. Urban Climate, 58,
102210.
Loh, W. Y. (2011). Classification and regression trees. Wiley Interdisciplinary Reviews: Data Mining and
Knowledge Discovery, 1(1), 14–23.
Lundberg SM, Lee SI, (2017). A unified approach to interpreting model predictions. Advances in neural
information processing systems, 30.
MacQuuen, J. B. (1967). Some methods for classification and analysis of multivariate observation. In Pro-
ceedings of the 5th Berkley symposium on mathematical statistics and probability, 1(14), 281–297.
Mohammadzadeh, N., Karimi, A., & Brown, R. D. (2023). The influence of outdoor thermal comfort on
acoustic comfort of urban parks based on plant communities. Building and Environment, 228, 109884.
Muggeo, V. M. (2003). Estimating regression models with unknown break-points. Statistics in Medicine,
22(19), 3055–3071.
Nieuwenhuijsen, M. J. (2021). New urban models for more sustainable, liveable and healthier cities post
covid19; reducing air pollution, noise and heat island effects and increasing green space and physical
activity. Environment International, 157, 106850.
Ning, S., Jing, W., Ge, Z., & Qin, Z. (2025). Assessing the impact of ambient noise on outdoor thermal com-
fort on university campuses: A pilot study in China’s Cold Region. Atmosphere, 16(4), 410.
Otani, H., Goto, T., Goto, H., Hosokawa, Y., & Shirato, M. (2019). Solar radiation exposure has diurnal
effects on thermoregulatory responses during high-intensity exercise in the heat outdoors. The Journal
of Strength & Conditioning Research, 33(10), 2608–2615.
Ou, H. Y., & Lin, T. P. (2023). Effects of orientation and dimensions of shading structures on thermal comfort.
Building and Environment, 243, 110715.
Ouyang, W., Ren, G., Tan, Z., Li, Y., & Ren, C. (2024). Natural shading vs. artificial shading: A comparative
analysis of their cooling efficacy in extreme hot weather. Urban Climate, 55, 101870.
Ozturk, Z. S., Kang, J., & Aletta, F. (2025). Soundscape research in streets: A scoping review. Sustainability,
17(8), 3329.
Peng, Y., Antanuri, N., Lau, S. K., Jebelli, B., Jusuf, S. K., Miller, C., & Chong, A. (2023). Experimental
assessment of thermal and acoustics interactions on occupant comfort in mixed-mode buildings. Build-
ing and Environment, 238, 110342.
Pompei L, Nardecchia F, Gugliermetti L, Cinquepalmi F, (2024). Design of three outdoor combined thermal
comfort prediction models based on urban and environmental parameters. Energy and Buildings, 1–15.
Rousseeuw, P. J. (1987). Silhouettes: A graphical aid to the interpretation and validation of cluster analysis.
Journal of Computational and Applied Mathematics, 20, 53–65.
Šimić, G., Tkalčić, M., Vukić, V., Mulc, D., Španić, E., Šagud, M., Olucha-Bordonau, F. E., Vukšić, M., & R.
Hof, P. (2021). Understanding emotions: Origins and roles of the amygdala. Biomolecules, 11(6), 823.
Tao, Y., Chai, Y., Kou, L., & Kwan, M. P. (2020). Understanding noise exposure, noise annoyance, and psy-
chological stress: Incorporating individual mobility and the temporality of the exposure-effect relation-
ship. Applied Geography, 125, 102283.
1 3

Threshold-based multi-scale analysis of thermal-acoustic comfort in…
Wen, X., Meng, Q., Yin, Y., Yang, D., Li, M., & Kang, J. (2025). Exploring the boundaries of indoor com-
bined thermal-acoustic environmental effects on comfort perceptions. Building and Environment, 271,
112580.
Yang, B., Yao, H., Yang, P., Guo, Y., Wang, F., Yang, C., Li, A., & Che, L. (2022). Effects of thermal and
acoustic environments on workers’ psychological and physiological stress in deep underground spaces.
Building and Environment, 212, 108830.
Zhang, N., Zhang, Y., Jiao, F., Liu, C., Shi, J., & Gao, W. (2025). Effects of spring water sounds on psycho-
physiological responses in college students: An EEG study. Applied Acoustics, 228, 110318.
Zhou, X., Xu, L., Zhang, J., Niu, B., Luo, M., Zhou, G., & Zhang, X. (2020). Data-driven thermal comfort
model via support vector machine algorithms: Insights from ASHRAE RP-884 database. Energy and
Buildings, 211, 109795.
Publisher’s note Springer Nature remains neutral with regard to jurisdictional claims in published maps and
institutional affiliations.
Springer Nature or its licensor (e.g. a society or other partner) holds exclusive rights to this article under a
publishing agreement with the author(s) or other rightsholder(s); author self-archiving of the accepted manu-
script version of this article is solely governed by the terms of such publishing agreement and applicable law.
Authors and Affiliations
Lu Xu1 · Wenqiang Jing2,3 · Wei Ding4 · Jing He5 · Zhemin Ge2,3 · Yousen Ai6
Wenqiang Jing
jingwenqiang@eurasia.edu
Lu Xu
xulu@xauat.edu.cn
Wei Ding
wei.ding@xust.edu.cn
Jing He
hejing@xjtu.edu.cn
Zhemin Ge
gezhemin@eurasia.edu
Yousen Ai
KDL@kandep.com
1 School of Human Settlements and Ecological Environment, Xi’an University of Architecture
and Technology Huaqing College, Xi’an, China
2 School of Human Settlements and Civil Engineering, Xi’ an Eurasia University, Xi’an, China
3 School of Human Settlements and Civil Engineering, Xi’ an Jiaotong University, Xi’an, China
4 School of Architecture and Civil Engineering, Xi’ an University of Science and Technology,
Xi’an, China
5 School of Humanities and Social Sciences, Xi’ an Jiaotong University, Xi’an, China
6 Taizhou Jiangyan District Housing Demolition and Relocation Service Center, Taizhou, China
1 3
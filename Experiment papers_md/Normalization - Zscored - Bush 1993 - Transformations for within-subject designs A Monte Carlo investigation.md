Psychological Bulletin Copyright 1993 by the American Psychological Association, Inc
1993, Vol. !13, No. 3. 566-579 0033-2909/93/S3.00
Transformations for Within-Subject Designs: A Monte Carlo Investigation
Lauren K. Bush, Ursula Hess, and George Wolford
We explored the use of transformations to improve power in within-subject designs in which
multiple observations are collected for each S in each condition, such as reaction time and psycho-
physiological experiments. Often, the multiple measures within a treatment are simply averaged to
yield a single number, but other transformations have been proposed. Monte Carlo simulations
were used to investigate the influence of those transformations on the probabilities of Type I and
Type II errors. With normally distributed data, Z and range correction transformations led to
substantial increases in power over simple averages. With highly skewed distributions, the optimal
transformation depended on several variables, but Z and range correction performed well across
conditions. Correction for outliers was useful in increasing power, and trimming was more effective
than eliminating all points beyond a criterion.
Psychologists are fond of transforming their data, occasion- levels of the independent variable and in which each subject
ally with good reason. The most common reason for transform- yields multiple observations at every level. The three types of
ing data is either that the transformed measure more closely transformations are interrelated in their effects. For instance,
reflects the psychological process of interest (Levey, 1980) or eliminating outliers tends to normalize the distributions and
that the data do not meet the assumptions for the desired analy- equate variances. In the present investigation, we concentrated
sis (Winer, 1971). In the latter case, two assumptions that are on the third type of transformation (equating reactivity), but in
often violated are the homogeneity of variance across cells and several situations we used these transformations in concert with
the degree to which the data are approximated by a normal the other types of transformations.
distribution. These two problems are related, and a transfor- Two examples illustrate the paradigms in which the reactiv-
mation that addresses one often improves the other. The appro- ity transformations apply (both are somewhat simplified from
priate transformation depends on the shape of the underlying
their usual implementation). In the first example, subjects view
distribution. Various transformations have been proposed for
two different videotapes, one depicting a humorous situation
specific cases, including log, reciprocal, square root, and arc-
and one depicting a neutral situation. During the showing of
sine transformations. Kruskal (1968) and Smith (1976) have
each videotape, heart rate is recorded every few seconds. In the
provided excellent overviews of these transformations and
second example, subjects participate in the cuing paradigm de-
when to use them. veloped by Posner (1978). On each trial, subjects try to detect a
A second, and related, reason for transforming data is to
target as rapidly as possible. On some trials, the probable loca-
lessen the impact of outliers. Two common techniques are
tion of the target is cued in advance; on other trials, it is not
trimming and eliminating all points beyond a certain criterion.
cued. Latencies are recorded on numerous trials of each of the
Wilcox (1992) has provided a nice overview of trimming as a
two conditions, cued versus uncued.
technique for dealing with outliers.
In both paradigms, each subject contributes, several observa- A third reason for transforming data is to eliminate differ-
tions to each of the two conditions. Prior to analyzing the data,
ences in reactivity or variability across subjects. These transfor-
most researchers collapse those several numbers into a single
mations apply only to designs in which each subject receives all
number for each condition. The most common procedure is to
use the mean of all of the numbers within a condition as the
score for that condition. In the present article, we examined
Lauren K. Bush (now at Department of Psychology and Counseling,
several alternatives to the simple mean to determine whether
Dartmouth College); Ursula Hess (now at Department of Psychology,
any are superior.
University of Quebec, Montreal, Quebec, Canada); and George Wol-
ford, Department of Psychology, Dartmouth College. Most of the transformations performed to eliminate differ-
This work was supported in part by National Institute of Mental ences in reactivity scale the effect of an independent variable
Health Grant 5-T32-MH18931 to Lauren K. Bush and by National for a given subject in terms of that subject's variability. The logic
Science Foundation Grant BNS-8820653 to George Wolford. We behind such transformations is that subjects differ substantially
would like to thank Arvid Kappas for his help during all phases of the in variance or reactivity and that a change of n units from Con-
project; James Townsend for his comments on foundational measure- dition 1 to Condition 2 might imply more or less of an effect for
ment and meaningfulness; and Gershon Ben-Shakhar, Richard Gon-
different subjects. Such transformations would be successful if
zales, David Lykken, Victor McGee, Gregory McHugo, and Glen
the transformed data more accurately reflected the influence
Shafer for their extremely helpful comments.
of the independent variable. Our measure of success was the
Correspondence concerning this article should be addressed to
George Wolford, Department of Psychology, Dartmouth College, statistical power of the various transformations as determined
Hanover, New Hampshire 03755. in Monte Carlo simulations.
566
.srehsilbup
deilla
sti
fo
eno
ro
noitaicossA
lacigolohcysP
naciremA
eht
yb
dethgirypoc
si
tnemucod
sihT
.yldaorb
detanimessid
eb
ot
ton
si
dna
resu
laudividni
eht
fo
esu
lanosrep
eht
rof
ylelos
dednetni
si
elcitra
sihT

WITHIN-SUBJECT TRANSFORMATIONS 567
Before describing the transformations we examined, we want such transformations often justify the loss of basal-level infor-
to emphasize that there are situations in which it would be mation by arguing that basal levels usually reflect individual
inappropriate to use them (Townsend & Ashby, 1984). For ex- difference variance unrelated to the psychological process of
ample, if the experimenter has reason to believe that the depen- interest and that transformation enhances their analysis's sensi-
dent measure achieves a ratio-level scale of measurement and tivity to "real" treatment effects (e.g., within-subject Z transfor-
that the ratios are of theoretical interest, then the only transfor- mation, Ben-Shakhar, 1985; range correction, Lykken & Ven-
mation that would be permissible is a multiplicative transfor- ables, 1971).
mation, because that is the only one that preserves meaningful Many researchers favor transformations that enhance sensi-
ratios (Townsend, 1992). The transformations that we discuss tivity to "real" effects (Levey, 1980), but not all agree that these
would be inappropriate because they would destroy the mean- transformations enhance power (cf. Ben-Shakhar, 1985,1987;
ingfulness of the ratios. If, however, the experimenter was inter- Stemmler, 1987a, 1987b). Recently, Stemmler (1987a) suggested
ested in whether two treatments were significantly different that within-subject standardization could actually reduce an
and not in the exact ratios, then our transformations would be analysis's sensitivity to "real" treatment effects by dispropor-
appropriate. A readable treatment of measurement theory has tionately reducing the contributions of the more reactive sub-
been provided by Roberts (1979). We return to the issue of jects. He used an artificially constructed data set to illustrate
meaningfulness in the Discussion section. his concern. Our goal in the present investigation was to exam-
There are other reasons to be wary of transformations be- ine systematically the effect of these transformations on statis-
sides loss of meaningfulness. It is essential to remember that tical power.
when data are transformed, some information is removed, and Researchers who use reaction time paradigms (e.g., cognitive
a different question is addressed than was addressed with the psychologists) have worried less than psychophysiologists
raw data.1 A transformation might make it more difficult to about techniques for combining the multiple measures within a
communicate the results if it were contrary to normal conven- condition into a single number. The vast majority of such re-
tion. It might also make it difficult to compare the data with searchers take the mean of all the reaction times within a cell
previous data (Cacioppo, Tassinary, & Fridlund, 1990). In the for a subject and carry out subsequent analyses on those means.
present analysis, we judged the success of our transformations On rare occasions, the reaction times are subjected to a log or
solely on the basis of statistical power. If a transformation im- square root transformation, or medians are used rather than
proved statistical power but was contrary to normal conven- means. Researchers who use reaction time paradigms do worry
tion, it would be easy to report both the transformed and the about outliers, however, and often perform some procedure to
raw data. eliminate deviant reaction times. The most common procedure
The two paradigms illustrated earlier—psychophysiology is to eliminate all data points more than k standard deviations
and information processing—diverge in their concern over ap- from the mean of a subject's condition. We examined the effect
propriate transformations. We discuss each paradigm in turn. of outliers and the procedures for dealing with them in con-
In psychophysiology, the recommended procedure varies junction with the various transformations.
somewhat with the dependent measure. The transformations Previous researchers (e.g., Ben-Shakar, 1985) have examined
that have been used with skin conductance include range- the power of various transformations by taking an empirically
corrected scores, ratio-corrected scores, within-subject stan- obtained data set, carrying out several different transforma-
dardization, and log and square root transformations. Range- tions, and determining which transformation yielded the high-
correction transformations (Lykken, 1972; Lykken, Rose, est F value for that data set. This method has advantages and
Luther, & Maley, 1966) express an individual's response to a disadvantages. The advantage is that the data are guaranteed to
particular stimulus as a proportion of his or her range of re- be realistic (the underlying distributions are correct, the values
sponsivity and presumably reduce variance due to individual are appropriate, etc.). The disadvantage is that because the true
differences in basal level. Ratio-correction transformations outcome is necessarily unknown, the transformation that max-
(Paintal, 1951) express a particular skin conductance measure imizes the F value may not be the best one; it may be yielding a
as the ratio of that response to the subject's maximal response. Type I error. In addition, it is difficult to draw conclusions from
The within-subject Z transformation expresses each individ- a small number of data sets.
ual's responses relative to his or her mean and standard devia- We examined the power of the various within-subject trans-
tion (e.g., Ben-Shakhar, 1985,1987). Log and square root trans- formations by using Monte Carlo simulations. We generated
formations have been proposed specifically for the purpose of hundreds of thousands of data sets with and without real ef-
normalizing the sample distribution (Venables & Christie, fects, employed each of the recommended transformations,
1980). and recorded the probabilities of Type I and Type II errors for
The decision to represent data in a particular way depends each transformation. We varied the shape of the underlying
not only on the sensitivity of that representation to treatment distribution, the way in which effects were added, the number
effects, but also on the specific process that one is trying to of subjects, the number of observations per subject, the effect
study (for detailed discussions of the processes that underlie size, and the presence or absence of outliers.
skin conductance responses, see Edelberg, 1972; Fowles, 1986).
When the range correction and within-subject 7. transforma-
tion methods are used, information about individual differ- 1 It should be pointed out that any procedure for reducing the multi-
ences is lost, and for this reason some researchers do not favor ple observations to a single number per condition, including a simple
their use (Stemmler, 1987a). Researchers who favor the use of average, is a transformation and removes some of the information.
.srehsilbup
deilla
sti
fo
eno
ro
noitaicossA
lacigolohcysP
naciremA
eht
yb
dethgirypoc
si
tnemucod
sihT
.yldaorb
detanimessid
eb
ot
ton
si
dna
resu
laudividni
eht
fo
esu
lanosrep
eht
rof
ylelos
dednetni
si
elcitra
sihT

568
L. BUSH, U. HESS, AND G. WOLFORD
Overview of the Approach
subjects (10 vs. 20), the number of observations per subject (10 vs. 20),
and the procedure for generating effects. The individual responses
A description of the general flow of the Monte Carlo pro-
were drawn from normal distributions.
gram will allow a better appreciation of the procedures and
results. For purposes of description, we used heart rate as the
dependent measure. For a given set of parameters, we carried Computations
out either 1,000 or 10,000 experiments. We used a two-stage
The simulations were carried out on two different computers: a Mac-
sampling procedure. In the first stage, we chose n subjects and
intosh II and a Convex super minicomputer. The simulations were
the sampling parameters for those subjects. We assumed that
programmed in BASIC on the Macintosh and in FORTRAN on the
each subject had his or her own heart rate distribution and that
Convex. Both languages and machines make use of high-precision
those individual distributions differed in both mean and vari-
numbers (10-byte representation on the Macintosh and 8-byte represen-
ance. For each subject, then, we chose that subject's mean heart tation on the Convex). With identical parameters, the two machines
rate from a normal distribution and his or her standard devia- yielded highly similar results; the advantage of the Convex was a mani-
tion of heart rate from a chi-square distribution.2 In the second fold increase in speed.
sampling stage, we chose m observations for each of two condi- Random numbers were generated using the built-in random-num-
tions from a normal distribution using that subject's mean and ber generators with random seeds at the beginning of each run. We
standard deviation. Next, we added an effect to each of the then converted the random numbers to normal deviates using an algo-
rithm developed by Box and Muller (1958).
observations in the second condition. This process was re-
peated for all n subjects. We reduced the m observations for
each subject in each condition to a single number for that con- Raw Data Generation
dition using each of the transformations. The resulting pairs of
numbers were analyzed with / tests, and the number of signifi- For the first set of simulations, we used data from normal distribu-
cant results was recorded. We measured Type I errors by setting tions. The parameters for the normal distributions were chosen to
the effect size to zero. reflect the type of distribution obtained for heart rate data (Siddle &
Turpin, 1980). Likewise, heart rate data from our laboratory have been
We generated data using both normal and positively skewed
approximately normal in all studies (although a slight positive skew
distributions, because both have been reported in the psycho- was occasionally evident). The following parameters were derived
physiological and reaction time literature (Venables & Christie,
from several studies in our laboratory using college-age students. Each
1980). Specific parameters for the distributions were chosen to subject's mean heart rate was chosen from a normal distribution with a
approximate the distributions that have been reported for skin mean of 69 beats per minute (bpm) and a standard deviation of 12
conductance and heart rate (Graham, 1980; Siddle & Turpin, bpm; each subject's standard deviation of heart rate was chosen from a
1980; Venables & Christie, 1980) and found in data from our chi-square distribution with 4 degrees of freedom. (A chi-square distri-
laboratory. We compared five different transformations in the bution with 4 degrees of freedom has a mean of 4 and a standard
initial simulations: means of the raw scores, means of the logs of deviation of 2.83.)
We chose the mean and standard deviation for each of the subjects the raw scores, Z scores, range-corrected scores, and ratio
and then, using those parameters, chose the given number of observa-
scores for repeated measures data. All of these transformations
tions from normal distributions. In the first simulation, the indepen-
have been recommended for one situation or another. In later
dent variables were number of subjects (10 vs. 20), number of observa- simulations, we added medians and the Z transformation of log
tions per condition (10 vs. 20), and the size and nature of the effect size.
scores to the set of transformations, and we examined the influ- For each subject in each cell, there were two sets of numbers: one
ence of outliers. intended to serve as the control or neutral condition and the other as
We had some concern about the procedures for choosing ef- the experimental condition.
fects. Most Monte Carlo simulations set the effect size at some We added an effect to the scores in the experimental condition in
fraction of the standard deviation. In our case, there were a one of three ways. In the absolute case, we added either 0, Vt, Vi, or % of
couple of different possibilities for the standard deviation. One the mean of the chi-square distribution. In the relative case, we added
0, Vt, Vi, or % of that subject's standard deviation (which had been possibility was the mean of the chi-square distribution from
chosen from the chi-square distribution). In the distributional case, we
which each subject's standard deviation was chosen, and the
added a number from a normal distribution that had a mean equal to
other was the particular subject's standard deviation. In the
0, Vt, '/2, or % of the mean of the chi-square distribution. In the absolute
former case, every subject would have the same absolute effect
case, the same number was added to every score in the experimental
size; in the latter case, every subject would have the same rela- condition for every subject, but the number represented a different
tive effect size. It also seemed possible that effects are not con- fraction of each subject's standard deviation. In the relative case, dif-
stant but are random variables from a distribution. Because all ferent numbers were added to different subjects' scores in the experi-
of these possibilities seemed reasonable, we carried out the mental condition, but those numbers represented the same fraction of
initial simulations adding effects in three different ways. each subject's standard deviation. The distributional case was similar
to the absolute case, except that the effects were not a constant but were
Simulation 1: Normally Distributed Data drawn from a distribution with the same mean as the constant. The
Method
Design 2 Differences in mean heart rate did not affect any of our analyses,
because all of the statistics that we carried out were within-subject
Simulation 1 consisted of 1,000 experiments per cell. We varied the analyses. We varied mean heart rate so that the numbers we generated
effect size (0, Vt, '/2, or % of the standard deviation), the number of appeared reasonable. This was useful in debugging the simulations.
.srehsilbup
deilla
sti
fo
eno
ro
noitaicossA
lacigolohcysP
naciremA
eht
yb
dethgirypoc
si
tnemucod
sihT
.yldaorb
detanimessid
eb
ot ton
si
dna
resu
laudividni
eht
fo
esu
lanosrep
eht
rof
ylelos
dednetni
si
elcitra
sihT

WITHIN-SUBJECT TRANSFORMATIONS 569
expected value of the effects for a particular size effect (e.g., 'A of the ence. The log transformation was ineffective, as expected with
standard deviation) was the same in all three cases. normally distributed data.
None of the transformations led to spurious Type 1 errors.
Notice, however, that the Type 1 errors were always less than .05
Transformations
for the means of raw scores. The standard error of that cell was
Once the data for each of the subjects were generated, we applied about 0.7% when the binomial distribution was used. In several
each of the transformations to those data. Each transformation re- cases, then, the probability of a Type 1 error was significantly
sulted in a single number for each condition. Those 10 or 20 pairs of below .05 for the means of raw scores, and certainly in compos-
numbers were then analyzed with a t test for correlated scores, and the
ite there were too few Type 1 errors with the simple means. This
number of significant outcomes using an apha of .05 was recorded.
implies that the t test was overly conservative for the untrans-
Means of raw scores. This transformation was accomplished by
formed data in the paradigm that we used. The probabilities of
computing the mean of all the observations in each cell for each sub-
Type 1 errors occurred in approximately correct frequencies for
ject. Each subject was left with two scores: the mean of the observa-
tions in the neutral condition and the mean of the observations in the the most effective transformations, that is, Z and range correc-
experimental condition. tion.
Means of log scores. This transformation was accomplished by We believe that within-subject transformations improve
computing the mean of the logs of the observations in each condition power by scaling effects relative to a subject's own variability or
for each subject. Log transformations have been recommended to re- reactivity (see Simulation 2). The slight superiority of the Z
duce the impact of deviant scores, particularly if the underlying distri- transformation over the range-corrected transformation was
bution is likely to be skewed.
probably due to the fact that the standard deviation is a more
Z scores. This transformation was accomplished by first finding
stable estimate of dispersion than is the range. Estimates of the
the mean and standard deviation of all of the scores for a given subject
minimum and the maximum are influenced strongly by out- across the two conditions. The raw scores were then transformed to Z
scores by subtracting the mean and dividing by the subject's standard liers. Range-corrected scores, however, may have a more natu-
deviation. The mean of the Z scores within each condition was then ral interpretation in some cases because the transformed cell
computed to represent the single number for each condition.3 means represent a particular fraction of the available range.
Range-correction scores. This transformation involved finding the The ratio transformation improved power over the simple aver-
minimum score in either condition and then subtracting that score age but did not fare as well as the Z and range transformations.
from each of the subject's responses; this difference was then divided
by the range of scores across the two conditions (maximum response
minus minimum response).4 Reversals of Effect Direction
Ratio scores. This transformation involved finding the maximum
Several investigators have expressed concern that transfor- score for each subject across the two conditions and then dividing all
mations of the type we examined might distort the pattern of
the scores by that maximum. Finally, the mean of those ratios was
effects. For example, Cacioppo et al. (1990) illustrated how a computed for each condition.
Simplified calculation. Using a t test for correlated measures, the different pattern may be obtained with raw means than with Z
last three transformations are equivalent to computing the mean dif- means. Such reversals occur when a small number of subjects
ference between conditions for a particular subject and then dividing have both high variance and effects in the opposite direction
the mean difference by that subject's standard deviation, range, or from the other subjects. Because of this possibility, Cacioppo et
maximum. al. recommended caution in using transformations and making
comparisons across studies in which different transformations
Analysis were used.
All the transformations that we considered are monotonic
The result of each of the transformations was a pair of scores for each within a single subject. That is, if the mean of Condition 2 is
subject. We analyzed those pairs (10 or 20, depending on the number of
larger than the mean of Condition 1 for a given subject, all the
subjects) using a / test for correlated observations (Winer, 1971). The
transformations preserve that ordering. However, the transfor-
result was considered significant if the absolute value of the obtained t
mations are not necessarily monotonic with respect to group
value exceeded the critical value (i.e., a two-tailed decision rule) with a
pof.05. means. They change the relative weighting of a subject in the
group and can change the ordering of the group means. Is this
Results and Discussion
The results of Simulation 1 are presented in Tables 1-3. The 3 One reviewer suggested that it might be more appropriate to com-
numbers in the tables refer to the percentages of significant / pute the standard deviation within each condition and then pool those
values from the 1,000 experiments in each cell. Table 1 contains estimates rather than compute the standard deviation across all scores.
the results for absolute effect size, Table 2 the results for relative We tried both methods in Simulation 1, but they led to similar results.
effect size, and Table 3 the results for effects chosen from a Whenever there was a difference, it was in favor of computing the
distribution. The pattern of results is clear. In all the condi- standard deviation across conditions, which is the method that we
report.
tions, the Z transformation and the range-corrected transfor-
4 In developing the range correction transformation, Lykken (1972)
mation were superior in statistical power to the other transfor-
measured the range for a subject in a separate session and then used
mations, often by 20% or more. Although the Z and range-
that range to transform the scores from the experimental sessions. For
corrected transformations led to similar results, the Z
purposes of symmetry and convenience, we did not use a separate set
transformation was slightly superior when there was a differ- of scores to estimate the minimum and maximum.
.srehsilbup
deilla
sti
fo
eno
ro
noitaicossA
lacigolohcysP
naciremA
eht
yb
dethgirypoc
si
tnemucod
sihT
.yldaorb
detanimessid
eb
ot
ton
si
dna
resu
laudividni
eht
fo
esu
lanosrep
eht
rof
ylelos
dednetni
si
elcitra
sihT

570
|     |     | L. BUSH, U. HESS, AND G.  |     | WOLFORD |     |
| --- | --- | ------------------------- | --- | ------- | --- |
Table 1
|     | Percentage of Significant  | Results With Normal Distribution and Constant  |     |     | Effect |
| --- | -------------------------- | ---------------------------------------------- | --- | --- | ------ |
Effect size
|     |                | 10 observations per subject |              | 20 observations per subject |              |
| --- | -------------- | --------------------------- | ------------ | --------------------------- | ------------ |
|     | Transformation | 1/4                         | 1/2 3/4 Null | 1/4                         | 1/2 3/4 Null |
10 subjects per sample
|     | Mean raw | 34.2 | 78.5 93.6 3.0 | 53.2 | 93.3 99.0 3.8 |
| --- | -------- | ---- | ------------- | ---- | ------------- |
|     | Z score  | 56.2 | 92.4 99.3 4.9 | 75.0 | 98.9 100 5.0  |
|     | Ratio    | 36.7 | 81.0 95.1 3.4 | 56.8 | 94.6 99.4 4.6 |
|     | Range    | 54.8 | 91.2 98.4 5.0 | 72.2 | 97.5 100 5.0  |
|     | Mean log | 33.1 | 77.3 92.8 2.8 | 52.7 | 92.5 98.7 4.0 |
.yldaorb detanimessid eb ot ton si dna resu laudividni eht fo esu lanosrep eht rof ylelos dednetni si elcitra sihT
  .srehsilbup deilla sti fo eno ro noitaicossA lacigolohcysP naciremA eht yb dethgirypoc si tnemucod sihT 20 subjects per sample
|     | Mean raw | 57.4     | 95.2 99.5 4.0 | 79.0 | 99.6 100 4.2 |
| --- | -------- | -------- | ------------- | ---- | ------------ |
|     | Z score  | 89.6 100 | 100 4.9       | 98.2 | 100 100 5.8  |
|     | Ratio    | 60.6     | 96.9 99.6 3.5 | 82.3 | 99.9 100 4.3 |
|     | Range    | 88.9 100 | 100 5.0       | 97.9 | 100 100 5.4  |
|     | Mean log | 55.3     | 94.0 98.8 3.1 | 76.7 | 99.2 100 4.1 |
really a problem? We addressed this question in two ways. First, subjects or observations. In many reaction time experiments,
in all our simulations, we recorded the direction of every signifi- there are hundreds of observations per condition per subject.
cant result. In all the simulations reported  herein (approxi- To test this possibility, we carried out one simulation with 10
mately 500,000 experiments), every significant finding was in subjects and 100 observations and a second simulation with 100
the correct direction (i.e., the mean of the experimental group subjects and 10 observations.  With these larger numbers, we
was greater than the mean of the control group.)5
used an effect size of 5/100 of the standard deviation to prevent
Second, we further examined the direction of mean differ- ceiling effects. In both cases, we found the same ordering of
ences for the data in the first column of Table 1 (i.e., 10 subjects, transformations as shown in Tables 1-3. For example, with 10
10 observations, V* of the standard deviation, and absolute ef- subjects and 100 observations, 16.8% of the results were signifi-
cant with raw means, and 31.0% of the results were significant
fect). The data represent 1,000 experiments; the results of 342
were significant using raw means, and the results of 562 were with Z means. With 100 subjects and 10 observations, 13.5% of
significant using the Z transformation. We examined the direc- the results were significant with raw means, and 44.9% of the
tion of the effect for those experiments without regard to signifi- results were significant with Z means. The effectiveness of us-
cance. The expanded results for the raw and Z means appear in ing the Z transformation, therefore, did not appear to diminish
with large numbers of subjects or observations provided that
Table 4. In the vast majority of cases (927 of 1,000), the means
had the correct  ordering (i.e., the experimental mean was ceiling effects were avoided.
greater than the control mean) for both procedures. In 9 other
| cases,  both  | transformations  | yielded  an  incorrect  | ordering. |     |     |
| ------------- | ---------------- | ----------------------- | --------- | --- | --- |
Procedure for Choosing  Effects
There were, however, 64 cases in which the raw means yielded
an ordering different from that yielded by the Z means. In 63 of We used three procedures for adding effects to the experimen-
those cases, the Z means were in the correct direction and the tal condition: absolute, relative, and distributional. The rank
raw means were in the incorrect direction. In short, the trans- ordering of the effectiveness of the different transformations
formations that we considered  occasionally reversed the pat- was identical in all three cases. The numerical results from the
tern of effects seen with raw means, but the reversal was almost absolute case and the distributional case were nearly identical,
always advantageous  in  this situation  where we knew the although that similarity would probably diminish if we in-
correct answer. Furthermore, such reversals never occurred creased the variance of the effect distribution for the distribu-
with significant effects. tional case. The relative case yielded lower power for small
effect sizes but higher power for larger effect sizes compared
with the other cases. The relative and distributional cases were
| Numbers of Subjects  | and Observations |     |     |     |     |
| -------------------- | ---------------- | --- | --- | --- | --- |
probably more realistic than the absolute case. Because the pro-
We varied the number of subjects and the number of observa- cedure for adding effects never influenced the ordering of the
tions  in  Simulation  1.  Increasing  either  number  increased effectiveness of the transformations and because most paramet-
power as expected, with a slight advantage for number of sub-
jects. Although we found the same ordering of transformation
effectiveness when numbers of subjects and observations were 5 This was not true for the null case, in which no effect was added to
varied, a colleague expressed concern that the usefulness of either group. In this situation, there was no "correct" direction, and the
transformations might diminish if we used large numbers of significant results split approximately equally in the two directions.

|     | WITHIN-SUBJECT  | TRANSFORMATIONS |     |     | 571 |
| --- | --------------- | --------------- | --- | --- | --- |
Table 2
| Percentage of Significant  | Results With Normal Distribution and Relative  |     |     | Effect |     |
| -------------------------- | ---------------------------------------------- | --- | --- | ------ | --- |
Effect size
|                | 10 observations per subject |          | 20 observations per subject |               |     |
| -------------- | --------------------------- | -------- | --------------------------- | ------------- | --- |
| Transformation | 1/4 1/2                     | 3/4 Null | 1/4                         | 1/2 3/4 Null  |     |
| Mean raw       | 22.4 71.6                   | 94.3 3.7 | 42.1                        | 90.8 98.5 4.3 |     |
| Z score        | 35.0 88.4                   | 99.7 5.4 | 59.2                        | 99.2 100 5.5  |     |
| Ratio          | 23.4 74.3                   | 95.7 3.9 | 43.7                        | 93.5 99.7 4.7 |     |
| Range          | 34.6 87.7                   | 99.7 5.4 | 59.1                        | 99.1 100 4.8  |     |
89.7 98.4 4.5
| Mean log | 22.1 69.3 | 92.0 3.8 | 40.0 |     |     |
| -------- | --------- | -------- | ---- | --- | --- |
20 subjects per sample
.yldaorb detanimessid eb ot ton si dna resu laudividni eht fo esu lanosrep eht rof ylelos dednetni si elcitra sihT
  .srehsilbup deilla sti fo eno ro noitaicossA lacigolohcysP naciremA eht yb dethgirypoc si tnemucod sihT Mean raw 48.7 96.2 99.9 4.6 79.8 100 100 4.2
| Z score  | 64.0 99.6 | 100 4.5  | 92.7 | 100 100 5.8  |     |
| -------- | --------- | -------- | ---- | ------------ | --- |
|          |           |          | 81.8 | 100 100 4.3  |     |
| Ratio    | 51.2 97.0 | 99.9 5.1 |      |              |     |
| Range    | 63.7 99.2 | 100 4.4  | 91.6 | 100 100 5.4  |     |
| Mean log | 47.3 95.9 | 99.9 5.3 | 77.7 | 99.8 100 4.1 |     |
ric tests assume the absolute case, we used it in all subsequent terms of an individual's variability, then they should have little effect in
simulations. Simulation 2 because all subjects had the same expected variance. The
results of Simulation 2 appear in Table 5. As is shown, none of the
transformations was superior to taking a simple average when all sub-
Simulation 2: Equal-Variance Case
jects had the same variability. This supports the conclusion that the Z
Method and range-corrected transformations achieved their additional power
in Simulation 1 by scaling effects in terms of each subject's variability.
We hypothesized that the success of the Zand range-corrected trans- Do real subjects differ in variability? Certainly. We based the param-
formations resulted from scaling a subject's effect size in terms of that eters in Simulation 1 on the data of subjects from our previous research.
subject's dispersion. As a check on this hypothesis, we repeated one Those individual subjects differed substantially in the standard devia-
quadrant of Table 1 (i.e., 10 subjects and 10 observations), assigning tion of their heart rate distributions, and our impression is that the
every subject the same standard deviation. All of the details were the differences are also pronounced for reaction time and skin conduc-
same as in Simulation 1, except that instead of choosing each subject's tance. For example, in Hess, Kappas, McHugo, Lanzetta, and Kleck's
standard deviation from a chi-square distribution, we assigned the (1992) study, each subject's heart rate was measured 20 times, and the
mean of that chi-square distribution to every subject. The individual standard deviation of heart rate within a subject ranged from a low of
subject distributions thus differed in mean but not in variability. If the 1.76 bpm to a high of 6.66 bpm. Typical effect sizes were on the order
Z and range-corrected transformations succeed by scaling effects in of 3 bpm. In a reaction time study involving speech recognition,
Table 3
| Percentage of Significant  | Results With Normal Distribution and Distributional  |     |     | Effect |     |
| -------------------------- | ---------------------------------------------------- | --- | --- | ------ | --- |
Effect size
10 observations per subject
20 observations per subject
| Transformation | 1/4 1/2 | 3/4 Null | 1/4 | 1/2 3/4 Null |     |
| -------------- | ------- | -------- | --- | ------------ | --- |
10 subjectsper sample
| Mean raw | 35.3 75.1 | 92.2 3.9 | 55.0 | 91.1 98.5 3.0 |     |
| -------- | --------- | -------- | ---- | ------------- | --- |
| Z score  | 55.0 89.4 | 97.8 6.5 | 75.5 | 98.4          |     |
99.8 4.9
| Ratio    | 35.9 76.2 | 92.8 4.1 | 56.2 | 91.7 98.9 3.2 |     |
| -------- | --------- | -------- | ---- | ------------- | --- |
| Range    | 54.8 89.8 | 97.8 6.3 | 75.8 | 97.8 99.8 4.6 |     |
| Mean log | 34.9 75.5 | 91.8 4.1 | 54.9 | 91.0 98.3 3.1 |     |
20 subjects per sample
| Mean raw | 56.2 94.0 | 99.3 5.2 | 80.2 | 98.9 100 5.2 |     |
| -------- | --------- | -------- | ---- | ------------ | --- |
| Z score  | 87.1 99.8 | 100 5.5  | 97.6 | 100 100 5.4  |     |
| Ratio    | 57.7 94.7 | 99.3 5.3 | 82.2 | 99.3 100 5.3 |     |
| Range    | 86.9 99.8 | 100 5.8  | 97.3 | 100          |     |
100 5.1
| Mean log | 55.9 93.8 | 99.3 5.1 | 80.4 | 98.8 100 5.1 |     |
| -------- | --------- | -------- | ---- | ------------ | --- |

572 L. BUSH, U HESS, AND G. WOLFORD
Table 4 in most statistics texts for dealing with skewed distributions.
Reversals in the Pattern of Effects With Transformations The Z, range, and ratio transformations were modestly superior
to the mean of the raw scores. On the basis of the initial results
Z transformation
of Simulation 3, we tried several additional transformations.
Experimental Namely, we applied the Z, range, and ratio transformations to
Raw means > control Control > experimental the logs of the individual scores. Those transformations gener-
ally yielded a small but consistent improvement over the use of
Experimental > control 927 1 logs alone. We found in Simulation 5 that these results with
Control > experimental 63 9
skewed distributions were affected substantially by outliers.
Simulation 4: Outliers, Corrections, and Medians With
Fowler, Treiman, and Gross (in press) had subjects contribute Normal Distribution
hundreds of reaction times. The standard deviation of the reaction
Method
times within a subject ranged from a low of 109 ms to a high of 729 ms.
Typical effect sizes were on the order of 125 ms.
Both reaction time and psychophysiological measures occasionally
yield scores that appear to be outliers. These deviant data points result
Simulation 3: Skewed Distribution from numerous sources: faulty equipment, shifting electrodes, inatten-
tive subjects, and so forth. Investigators often use some technique to
Method eliminate these outliers. We considered three common techniques: me-
dians, trimming, and the elimination of all points beyond some crite-
In Simulation 3, we examined the efficacy of the various transfor- rion. Medians are sensitive only to the ordering of the data and are
mations with a skewed distribution. Dependent variables such as reac- therefore less affected than means by extreme outliers. Medians, how-
tion time and skin conductance often yield skewed distributions. For
ever, are insufficient estimators because they do not use all of the data,
example, several investigators have suggested that reaction times are namely, the magnitude of the numbers. Miller (1988) has also criticized
well fit by a gamma distribution. The gamma distribution is equiva-
medians as being biased, with the magnitude of the bias being a func-
lent to the sum of r exponentials, each having the intensity parameter
tion of the number of subjects.
lambda (X). Researchers have often modeled reaction times by assum-
We considered two other techniques for dealing with outliers; both
ing that some number of synapses intervene between the stimulus and
consist of eliminating some of the data points. Winer (1971) described
the response and that the transmission time of any one synapse is
the use of trimming for dealing with outliers (see also Wilcox, 1992). In
distributed as an exponential. The chi-square distribution is a special our version of trimming, we eliminated the highest and lowest score
case of the gamma distribution in which r= v/2 (where v represents the
for each subject in each condition. The final, and perhaps most popu-
degrees of freedom for the chi-square distribution) and X = 0.5. We
lar, technique is to eliminate all data points beyond some criterion. In
used the chi-square distribution in our simulations because it is an informal poll of several colleagues, the most common criterion was
slightly easier to work with than the generalized gamma distribution. ±3 standard deviations from a subject's condition mean. In the same
A chi-square distribution can be generated as the sum of v squared
informal poll, we asked colleagues what percentage of their data were
normal distributions. eliminated with this procedure. The modal response was "around 2%."
Unlike the normal distribution, the mean, variance, and skew of a In Simulation 4, then, we generated the data as in the upper right
chi-square distribution are interrelated (all three are functions of v). For quadrant of Table 1 (i.e., 10 subjects, 20 observations, and normally
that reason, it is not possible to have those parameters vary indepen- distributed data). There were two new variables in this simulation, and
dently. Their interdependence is shown empirically in most reaction their orthogonal combination yielded six cells. The first variable was
time experiments by a positive correlation between the mean and vari- the presence or absence of outliers, and the second variable was the
ance. procedure for dealing with outliers: doing nothing, trimming, or elimi-
In Simulation 3, then, we began each experiment by randomly nating scores exceeding 3 standard deviations. In the conditions with
choosing a v for each of the n subjects from a uniform distribution outliers, we chose 4% of the data points at random and added±5 stan-
ranging from 3 to 14. We chose m observations for each condition from dard deviations to those data points. We chose the frequency and the
a chi-square distribution with that subject's value of v. As in Simulation
1, we varied the number of subjects (10 vs. 20) and the number of
observations per condition (10 vs. 20). We added effect sizes of 0, lk, Vi,
or 3A of the average standard deviation to each of the observations in Table 5
the experimental condition. With v ranging from 3 to 14, the expected Percentage of Significant Results With Normal Distribution,
value of standard deviation across subjects was 4.03. Constant Effect, and Equal Variance Among Subjects
Effect size
Results
Transformation 1/4 1/2 3/4 Null
The results of Simulation 3 are presented in Table 6. For the
smallest effect size, the overall power was similar to that shown Mean raw 36.9 87.9 99.6 5.1
for normally distributed data (see Table 1), but with larger effect Z score 36.8 88.0 99.7 4.7
sizes more significant differences were found with the skewed Ratio 36.1 87.2 99.6 4.1
Range 36.6 87.7 99.7 5.0
distributions. The log transformation led to a benefit over the
Mean log 35.8 86.2 99.5 4.3
raw scores and was superior in every case to the other transfor-
mations as applied to the raw scores. The advantage of the log Note. Percentages are based on 10 observations per subject and 10
transformation is consistent with the recommendation found subjects per sample.
.srehsilbup
deilla
sti
fo
eno
ro noitaicossA
lacigolohcysP
naciremA
eht
yb
dethgirypoc
si
tnemucod
sihT
.yldaorb
detanimessid
eb
ot
ton
si
dna
resu
laudividni
eht
fo
esu
lanosrep
eht
rof
ylelos
dednetni
si
elcitra
sihT

573
WITHIN-SUBJECT TRANSFORMATIONS
Table 6
| Percentage of Significant  | Results With Skewed Distribution |     |     |     |     |
| -------------------------- | -------------------------------- | --- | --- | --- | --- |
Effect size
|                | 10 observations per subject |      | 20 observations per subject |         |      |
| -------------- | --------------------------- | ---- | --------------------------- | ------- | ---- |
| Transformation | 1/4 1/2                     | Null | 1/4                         | 1/2 3/4 | Null |
3/4
10 subjects per sample
| Mean raw | 35.9 87.1 | 98.8 4.6 | 61.7 | 98.8 100 | 5.0 |
| -------- | --------- | -------- | ---- | -------- | --- |
|          |           |          |      | 100      | 5.2 |
| Z score  | 40.4 89.9 | 99.6 5.2 | 65.9 | 99.4     |     |
|          | 40.3 89.3 | 99.7 5.2 | 66.0 | 99.1 100 | 5.1 |
Ratio
| Range    | 39.6 88.7 | 99.5 5.3 | 65.7 | 99.2 100 | 5.1 |
| -------- | --------- | -------- | ---- | -------- | --- |
| Mean log | 44.9 93.2 | 99.9 5.4 | 72.7 | 99.7 100 | 5.1 |
.yldaorb detanimessid eb ot ton si dna resu laudividni eht fo esu lanosrep eht rof ylelos dednetni si elcitra sihT Z score log 45.3 93.3 99.9 5.7 73.9 99.7 100 5.3
  .srehsilbup deilla sti fo eno ro noitaicossA lacigolohcysP naciremA eht yb dethgirypoc si tnemucod sihT
20 subjects per sample
| Mean raw    | 64.1 99.3 | 100 5.7 | 92.0 | 100 100 | 4.3 |
| ----------- | --------- | ------- | ---- | ------- | --- |
| Z score     | 70.8 99.7 | 100 5.1 | 94.0 | 100 100 | 5.1 |
| Ratio       | 70.2 99.7 | 100 5.8 | 93.7 | 100 100 | 4.9 |
| Range       | 70.9 99.7 | 100 5.7 | 93.5 | 100 100 | 4.9 |
| Mean log    | 76.2 99.8 | 100 6.0 | 96.2 | 100 100 | 4.7 |
| Z score log | 77.8 99.7 | 100 5.4 | 96.0 | 100 100 | 5.2 |
centages of outliers eliminated with the 3-SD technique are
magnitude of the outliers to yield approximately 2% outliers as re-
vealed by the 3-standard-deviation (3-SD) elimination procedure. Be- listed at the bottom of Table 7.)
cause outliers affect the mean and standard deviation of the sample, When 4% outliers were added to the data, the trimming pro-
the 3-SD procedure does not identify all outliers. We also added me- cedure was clearly superior to doing nothing and to the 3-SD
dians to the list of transformations. technique. The 3-SD technique yielded little change from doing
nothing.7 Note that even though 4% outliers were added to the
Results
data, the 3-SD technique generally eliminated fewer than 2%.
This is because the outliers influenced the mean and standard
The results of Simulation 4 appear in Table 7. We expected
deviation of a condition and therefore affected the criterion for
outliers to reduce the power of the various tests because they
elimination.
add to the error variance. In this simulation with normally
distributed data, outliers did reduce the power of all the tests,
in some cases by as much as 10%-15%. Note that with outliers,
Simulation 5: Outliers, Corrections, and Medians
the probability of a Type 1 error is less than .05 in most cases. With Skewed Distribution
The ordering of the effectiveness of the different transforma-
tions was the same as in the previous simulations with normally
Method
| distributed data. The Z transformation  | remained  | optimal, |     |     |     |
| --------------------------------------- | --------- | -------- | --- | --- | --- |
yielding the highest number of significant results. Simulation 5 was similar to Simulation 4 except that we generated
the raw data usinga skewed distribution, as in Simulation 3. The proce-
dure we used to add outliers also differed from that used in Simulation
Medians
4. If highly deviant points were added equidistantly above and below
the mean, the skew would change substantially. As a practical example,
Medians were affected minimally by outliers, as expected,
consider reaction times. In a simple cuing experiment, the mean reac-
but were quite low in power compared with the other transfor-
tion times might be around 300 ms, with a standard deviation of 75-
mations (with or without the presence of outliers). Given the
100 ms. Data points more than 5 standard deviations above the mean
lack of power and the bias problems cited earlier, it is hard to
can occur in such experiments, but data points more than 5 standard
imagine a justification for using medians with normally distrib-
deviations below the mean are physically impossible. In Simulation 5,
uted data.6
Corrections for Outliers
6 In all the present simulations, we assumed that the level of measure-
ment of the dependent variable was at least interval. If the data were
When no outliers were added to the data, neither technique
ordinal, medians would be the appropriate transformation, and the
for correcting outliers had much effect on power compared
parametric tests and other transformations would be inappropriate.
with not using a correction. Surprisingly, the trimming tech-
7 In Simulation 4, the outliers were ±5 standard deviations from
nique was slightly superior to 3-SD elimination, even though
the population mean of each condition. If more extreme outliers are
trimming always eliminated 10% of the data points (2 of 20) and
used, then the 3-SD technique is superior to doing nothing at all but is
the 3-SD correction eliminated very few data points. (The per-
still worse than trimming.

| 574 |     |     | L. BUSH, U. HESS, AND  |     | G.  WOLFORD |     |     |
| --- | --- | --- | ---------------------- | --- | ----------- | --- | --- |
Table 7
|     | Percentage of Significant  |     | Results With Normal Distribution and Effect  |     |     | of Outliers |     |
| --- | -------------------------- | --- | -------------------------------------------- | --- | --- | ----------- | --- |
Effect size
|     |                |     | No outliers |     |          | Outliers |          |
| --- | -------------- | --- | ----------- | --- | -------- | -------- | -------- |
|     | Transformation |     | 1/4 1/2     | 3/4 | Null 1/4 | 1/2      | 3/4 Null |
No correction
|     | Mean raw |     | 54.4 93.3 | 98.7 | 3.6 40.8 | 82.8 | 96.1 3.2 |
| --- | -------- | --- | --------- | ---- | -------- | ---- | -------- |
|     | Z score  |     | 75.9 99.2 | 100  | 4.9 62.4 | 96.2 | 99.6 4.6 |
|     | Ratio    |     | 55.8 94.1 | 99.2 | 3.7 42.7 | 85.6 | 97.0 3.2 |
|     | Range    |     | 72.0 98.5 | 99.9 | 4.6 57.4 | 92.3 | 98.8 4.0 |
|     | Mean log |     | 54.6 93.3 | 98.7 | 3.4 40.8 | 83.1 | 95.8 3.4 |
|     | Medians  |     | 42.5 86.7 | 97.6 | 3.5 41.2 | 83.0 | 96.3 4.1 |
.yldaorb detanimessid eb ot ton si dna resu laudividni eht fo esu lanosrep eht rof ylelos dednetni si elcitra sihT
  .srehsilbup deilla sti fo eno ro noitaicossA lacigolohcysP naciremA eht yb dethgirypoc si tnemucod sihT
Trimming highest and lowest score
|     | Mean raw |     | 56.2 90.9 | 99.0 | 4.1 46.2 | 84.5 | 97.6 3.1 |
| --- | -------- | --- | --------- | ---- | -------- | ---- | -------- |
|     |          |     | 78.0 98.8 | 100  | 6.5 68.2 | 96.5 | 100 5.5  |
Z score
|     | Ratio    |     | 57.3 91.6 | 99.1 | 4.5 47.9 | 86.2 | 98.0 3.5 |
| --- | -------- | --- | --------- | ---- | -------- | ---- | -------- |
|     | Range    |     | 75.9 98.5 | 100  | 6.2 66.4 | 95.2 | 99.6 5.3 |
|     | Mean log |     | 56.3 91.0 | 99.0 | 4.1 46.4 | 84.4 | 97.1 3.4 |
|     | Medians  |     | 45.7 83.6 | 97.7 | 4.2 42.1 | 82.2 | 96.5 3.6 |
Eliminating all scores beyond ±3 standard deviations
|     | Mean raw   |      | 54.3 90.7 | 98.5 | 3.0 41.8 | 83.0 | 96.0 3.5 |
| --- | ---------- | ---- | --------- | ---- | -------- | ---- | -------- |
|     | Z score    |      | 15.2 98.5 | 99.9 | 4.9 64.0 | 95.7 | 99.8 4.7 |
|     | Ratio      |      | 56.1 91.5 | 98.6 | 3.0 43.8 | 85.1 | 96.7 4.0 |
|     |            |      |           |      | 4.4 58.4 |      | 99.4 5.3 |
|     | Range      |      | 71.8 97.4 | 99.8 |          | 93.1 |          |
|     | Mean log   |      | 54.2 90.3 | 98.5 | 3.0 41.6 | 82.5 | 96.1 3.4 |
|     | Medians    | 41.8 | 84.0      | 96.7 | 4.1 37.7 | 81.1 | 96.0 3.7 |
|     | % rejected |      | 0.08 0.08 | 0.08 | 0.07 1.7 | 1.7  | 1.7 1.7  |
Medians
therefore, we added 2% outliers that were 3 standard deviations below
the mean and 1% outliers that were 6 standard deviations above the
In the absence of outliers, medians were consistently low in
mean. This procedure preserved the expected mean of the distribu-
power, as with the normally distributed data in Simulation 4.
tions, did not affect the skew too much, and led to just more than 2% of
the data points' being eliminated using the 3-S£> procedure.8 The presence of outliers did not affect the power of the me-
dians, but because it reduced the power of the other transfor-
mations, the medians fared relatively well. In several cases with
outliers, medians yielded more significant  results than any
Results
other transformation. Corrections for outliers had a limited ef-
fect on medians but large effects on other transformations. Any
The results of Simulation 5 appear in Table 8. The results
advantage of medians over other transformations was reduced
differed from those obtained with normally distributed data in or eliminated by the use of corrections for outliers.
several ways. Outliers drastically reduced the power of the dif-
ferent procedures, especially the use of the raw means. With Corrections for Outliers
| outliers,  the transformations             |     | were especially  | important,       | in  |                                                           |     |     |
| ------------------------------------------ | --- | ---------------- | ---------------- | --- | --------------------------------------------------------- | --- | --- |
|                                            |     |                  |                  |     | Corrections  for outliers were more important with skewed |     |     |
| some cases leading to three- and fourfold  |     |                  | improvement. The |     |                                                           |     |     |
data than with normal data, and the effect of the correction
rank ordering of the effectiveness of the different transforma-
tions varied with condition. For instance, the log transforma-
8 We tried various procedures for adding outliers in both the normal
tion yielded better results than the Z transformation in the
and the skewed case. With normally distributed data, the effectiveness
absence of outliers or in the presence of outliers when no correc-
of the different analysis procedures was not affected by the procedure
tion for outliers was used, but it yielded worse results than Z
for adding outliers. More frequent or more distant outliers reduced
when there were outliers and outlier correction was used. Out-
overall power more, but the Z transformation was always best, trim-
liers and the two corrections for outliers reduced the skew in the
ming always helped, and so on. With skewed data, the outcomes were
| distributions, rendering the log a less appropriate  |     |     | transforma- |     |     |     |     |
| ---------------------------------------------------- | --- | --- | ----------- | --- | --- | --- | --- |
more sensitive to the technique for adding noise. In particular, the
tion. The range transformation was similar to Z, that is, slightly relative effectiveness of medians and logs varied markedly with differ-
better in some cases and slightly worse in others. The combina- ent procedures. The procedure that we report met the overall proper-
tion of the log and Z transformations performed quite well, ties that we wanted to satisfy and seemed reasonable to us based on the
| often yielding the highest power. |     |     |     |     | data from our laboratory. |     |     |
| --------------------------------- | --- | --- | --- | --- | ------------------------- | --- | --- |

575
|     | WITHIN-SUBJECT  | TRANSFORMATIONS |     |     |
| --- | --------------- | --------------- | --- | --- |
Table 8
| Percentage of Significant  | Results With Normal Distribution and Effect  |     | of Outliers |     |
| -------------------------- | -------------------------------------------- | --- | ----------- | --- |
Effect size
|                | No outliers |          | Outliers |          |
| -------------- | ----------- | -------- | -------- | -------- |
| Transformation | 1/4 1/2     | 3/4 Null | 1/4 1/2  | 3/4 Null |
No correction
| Mean raw | 58.3 98.8 | 100 5.9 | 13.5 35.1 | 65.2 4.9 |
| -------- | --------- | ------- | --------- | -------- |
| Z score  | 62.2 99.1 | 100 5.0 | 21.5 54.8 | 82.2 4.8 |
| Ratio    | 61.5 99.2 | 100 5.1 | 21.4 52.9 | 79.4 4.7 |
| Range    | 60.8 99.2 | 100 5.5 | 21.6 54.7 | 79.8 4.9 |
| Mean log | 69.1 99.6 | 100 5.3 | 34.9 84.8 | 99.5 4.5 |
|          |           | 99.7    | 93.2      |          |
.yldaorb detanimessid eb ot ton si dna resu laudividni eht fo esu lanosrep eht rof ylelos dednetni si elcitra sihT Medians 47.2 94.8 5.5 43.5 99.8 4.5
  .srehsilbup deilla sti fo eno ro noitaicossA lacigolohcysP naciremA eht yb dethgirypoc si tnemucod sihT LogZ 69.5 99.4 100 5.3 40.5 89.2 99.7 5.0
Trimming highest and lowest score
| Mean raw | 60.8 98.5 | 100 5.0 | 13.7 29.4 | 43.8 1.7 |
| -------- | --------- | ------- | --------- | -------- |
| Z score  | 65.4 99.0 | 100 5.3 | 44.4 84.1 | 96.5 4.6 |
|          | 65.0 99.0 | 100 5.0 | 78.2      | 93.6 4.4 |
| Ratio    |           |         | 41.4      |          |
| Range    | 64.6 98.8 | 100 5.2 | 45.5 86.2 | 96.9 4.6 |
| Mean log | 69.3 99.6 | 100 5.4 | 41.5 83.1 | 97.3 3.2 |
| Medians  | 50.9 96.3 | 100 5.7 | 48.3 92.5 | 99.7 3.7 |
| LogZ     | 70.2 99.7 | 100 5.4 | 52.7 94.9 | 99.5 4.8 |
Eliminating all scores beyond ±3 standard deviations
| Mean raw   | 56.6 98.4 | 100 5.0   | 8.7 23.1  | 37.7 1.5  |
| ---------- | --------- | --------- | --------- | --------- |
| Z score    | 60.0 98.9 | 100 5.0   | 37.9 77.5 | 93.3 5.4  |
| Ratio      | 60.6 98.9 | 100 5.2   | 32.9 66.8 | 86.9 5.0  |
| Range      | 60.8 98.9 | 100 5.2   |           |           |
|            |           |           | 38.8 78.6 | 94.0 5.3  |
| Mean log   | 65.9 99.3 | 100 5.1   | 33.1 69.8 | 92.3 4.4  |
| Medians    | 44.5 93.5 | 99.8 5.8  | 41.5 92.8 | 99.8 5.9  |
| LogZ       | 67.9 99.3 | 100 5.0   | 47.7 91.9 | 99.0 5.3  |
| % rejected | 0.59 0.59 | 0.57 0.59 | 2.22 2.22 | 2.23 2.20 |
interacted with the type of transformation. The corrections for
significant differences in the two baselines and apply a correction only
if there is a significant difference.
outliers decreased the power obtained with raw means, had
little effect on medians or logs, and considerably increased the In Simulation 6, we looked at the effect of the various transforma-
power of the other transformations. As with normally distrib- tions in a design with four cells: two conditions (experimental and
uted data, trimming was superior to 3-SD elimination. We control), each preceded by a baseline. In this simulation, we modeled
strongly recommend that researchers interested in using the Z an experiment in which there was no difference in the expected values
or range transformation consider trimming. Trimming has lit- of the two baselines. Except for the use of four cells rather than two, we
used the same parameters as in Simulation 1. After choosing each
tle effect in the absence of outliers but a beneficial effect in the
subject's mean from a normal distribution and standard deviation
presence of outliers. In some case, trimming increased the
from a chi-square distribution, we chose m (10 vs. 20) observations for
power of the Z and range transformations by a factor of 2.
each of the four cells. Effects were added only to the one cell, the
experimental condition. Effects were added as in the absolute case in
Simulation 1. The results were based on 10,000 rather than 1,000 exper-
Simulation 6: Baseline Measures iments per condition, and the simulation was executed on the Convex.
We used two sets of transformations. In both sets, the parameters
used in the calculation of the range, ratio, and Z transformations were
Method
calculated by using all four cells. In other words, the mean and stan-
dard deviation for the Z transformation were calculated using the
The designs used in the first five simulations were somewhat simpli- scores from all four cells; likewise for the minimum, maximum, and
fied from their normal implementation. In psychophysiology, in partic- range used in the other transformations. In one set, we applied the
ular, researchers are interested in changes in the baselines of the transformations only to the neutral and experimental conditions, ig-
various dependent measures. As a result, many experimenters take
noring the baseline conditions. In the other set, we applied the trans-
baseline measures prior to each condition. The measures for each con-
formations to the difference scores for the neutral and experimental
dition are corrected for any change in baseline. Several procedures
conditions from their respective baselines. We have omitted the log
have been used for those corrections. One procedure is to calculate
transformation from the report of thissimulation. As in the other simu-
difference scores consisting of the value for a condition minus the
lations in which normal distributions were used, logs were slightly
value for that condition's baseline. A second procedure is to test for
worse than the simple mean of the raw scores.

576
L. BUSH, U. HESS, AND G. WOLFORD
Table 9
Percentage of Significant  Results With Normal Distribution and Baseline and Difference  Scores
Effect size
|                | 10 observations per subject |          | 20 observations per subject |          |
| -------------- | --------------------------- | -------- | --------------------------- | -------- |
| Transformation | 1/4 1/2                     | 3/4 Null | 1/4 1/2                     | 3/4 Null |
10 subjects per sample
| Mean raw           | 29.1 73.3 | 93.5 5.0 | 48.3 92.3 | 99.0 4.8 |
| ------------------ | --------- | -------- | --------- | -------- |
| Z score            | 41.4 85.8 | 98.3 5.1 | 64.5 97.8 | 100 5.0  |
| Ratio              | 31.3 74.0 | 94.7 5.4 | 51.4 93.4 | 100 4.6  |
| Range              | 40.1 84.4 | 98.1 5.0 | 63.4 97.8 | 100 5.1  |
| Mean difference    | 19.7 50.4 | 78.7 5.1 | 30.9 74.9 | 94.5 3.8 |
| Z score difference | 29.5 67.1 | 90.1 6.2 | 45.7 87.3 | 98.1 5.0 |
.yldaorb detanimessid eb ot ton si dna resu laudividni eht fo esu lanosrep eht rof ylelos dednetni si elcitra sihT
  .srehsilbup deilla sti fo eno ro noitaicossA lacigolohcysP naciremA eht yb dethgirypoc si tnemucod sihT Ratio difference 19.2 52.3 79.2 4.9 32.5 76.4 96.3 4.6
| Range difference | 28.1 66.5 | 89.0 5.0 | 44.9 87.1 | 98.7 5.2 |
| ---------------- | --------- | -------- | --------- | -------- |
20 subjects per sample
| Mean raw | 51.5 95.3 | 99.9 5.0 | 77.4 100 | 100 4.7 |
| -------- | --------- | -------- | -------- | ------- |
| Z score  | 75.3 99.5 | 100 4.9  | 95.8 100 | 100 5.8 |
| Ratio    | 53.9 96.1 | 100 5.5  | 80.4 100 | 100 5.3 |
| Range    | 73.9 99.6 | 100 5.2  | 94.6 100 | 100 5.1 |
4.3
| Mean difference    | 30.1 78.7 | 97.7 5.0 | 53.5 95.3 | 100     |
| ------------------ | --------- | -------- | --------- | ------- |
| Z score difference | 54.4 95.2 | 100 4.9  | 80.2 100  | 100 5.1 |
| Ratio difference   | 32.9 80.6 | 97.3 5.4 | 56.0 97.7 | 100 4.6 |
| Range difference   | 52.5 94.1 | 100 5.2  | 78.5 99.9 | 100 5.4 |
Results therefore, we would have to subtract those cases in which the baselines
were significantly different. That would be equivalent, on average, to
The results of Simulation 6 are shown in Table 9. As in Simu-
reducing the number of significant results by 5% for each of the cases
lation 1, the use of the Z and range transformations led to sub-
that did not involve difference scores. For cases with large effect sizes
stantial increases in power, with the Z transformation slightly (e.g., 20 subjects, 20 observations, and of the standard deviation 3A
superior. The use of difference scores lowered power, but this effect), difference scores actually would yield higher power than the
was expected because difference scores have a higher expected baseline test technique because of the 5% artificial loss with the latter.
standard error. The expected variance of a set of  difference To illustrate the problem of not using difference scores, we simu-
scores is equal to the sum of the variances of the two sets of lated a case in which the baseline drifted in the direction opposite the
scores used in computing the differences. Assuming that the effect. Simulation 7 was identical to Simulation 6 except that the base-
line was reduced by the appropriate effect size, and that effect size was
baseline and condition scores have the same variance, the dif-
added back to the experimental condition.
ference scores will have twice the variance of either the baseline
The results are presented in Table 10. Because of the baseline drift,
or condition scores. The standard error of the difference scores
comparisons of the conditions that do not use difference scores have
will be the square root of the variance (i.e., it will be 1.414 times
essentially zero power. The baseline drift causes only a small loss of
as large as the standard error of either condition). Notice that
power with difference scores. This is obviously a contrived situation,
the power for the difference scores was reduced by approxi-
but it illustrates the danger of not taking difference scores. We did not
mately that ratio for the smallest effect sizes. apply the baseline drift to the null condition. If we had, the failure to
take difference scores would have resulted in a substantial number of
Simulation 7: Baseline With Drift
Type I errors.
The question of how to interpret change scores from different base-
Method
lines remains a controversial topic. Subjects who exhibit different base-
lines may be experiencing different psychological states, making it
Judging only from the data in Table 9, it appears disadvantageous to
impossible to interpret the effect of a treatment. We agree that the
use difference scores. Most investigators who recommend against us-
situation is problematic and that change scores do not solve the prob-
ing difference scores either try to allow baselines to stabilize at prestim-
lem. We feel that the use of change scores is superior to not using
ulus levels (the closed-loop baseline procedure; see McHugo & Lan-
change scores for the reasons just described, but the problem of the
zetta, 1983) or begin by carrying out a significance test comparing the
changing baseline is probably best solved through experimental design
two baseline measures. Only if this test fails to reach significance do
they carry out the test comparing the two conditions. We did not fol- rather than data analysis. The closed-loop baseline procedure de-
low that latter procedure in Simulation 6. If we had, 5% of the baseline scribed by McHugo and Lanzetta (1983) is one design procedure that
tests would have been significant. This follows from the fact that the addresses the problem of unequal baselines.
baselines were generated from the same distributions as the conditions
Discussion
and that a test comparing the baselines is equivalent to the test com-
paring the conditions when the effect size is 0. In calculating the num- We examined the effect of various transformations in a par-
ber of significant results obtained without using difference  scores, ticular paradigm, namely, one in which several observations are

WITHIN-SUBJECT TRANSFORMATIONS 577
Table 10
| Percentage of Significant  | Results With Normal Distribution and Baseline Drift |     |     |     |     |     |
| -------------------------- | --------------------------------------------------- | --- | --- | --- | --- | --- |
Effect size
|                | 10 observations per subject |     |      | 20 observations per subject |     |      |
| -------------- | --------------------------- | --- | ---- | --------------------------- | --- | ---- |
| Transformation | 1/4 1/2                     |     | Null | 1/4                         | 1/2 | Null |
|                |                             | 3/4 |      |                             |     | 3/4  |
10 subjects per sample
| Mean raw           | 4.6 5.8   | 4.6  | 5.0 | 5.6  | 4.7  | 5.3 4.4  |
| ------------------ | --------- | ---- | --- | ---- | ---- | -------- |
| Z score            | 5.0 5.6   | 5.7  | 5.1 | 5.4  | 5.6  | 5.8 5.9  |
|                    | 4.0 5.1   | 4.0  | 4.9 | 4.7  |      | 5.1 4.6  |
| Ratio              |           |      |     |      | 5.5  |          |
| Range              | 5.5 4.9   | 5.4  | 5.0 | 5.3  | 5.3  | 4.4 5.9  |
| Mean difference    | 16.3 46.5 | 73.1 | 5.1 | 28.2 | 70.3 | 92.1 4.3 |
| Z score difference | 23.1 58.2 | 83.5 | 4.9 | 38.0 | 82.3 | 97.0 5.0 |
.yldaorb detanimessid eb ot ton si dna resu laudividni eht fo esu lanosrep eht rof ylelos dednetni si elcitra sihT
  .srehsilbup deilla sti fo eno ro noitaicossA lacigolohcysP naciremA eht yb dethgirypoc si tnemucod sihT Ratio difference 17.3 48.0 75.4 4.7 29.4 73.9 93.3 4.8
| Range difference | 22.6 57.9 | 83.2 | 5.0 | 37.9 |     | 97.1 5.2 |
| ---------------- | --------- | ---- | --- | ---- | --- | -------- |
82.0
20 subjects per sample
| Mean raw | 5.4 4.7 | 5.2 | 5.0 | 5.3 | 5.1 | 4.2 4.7 |
| -------- | ------- | --- | --- | --- | --- | ------- |
| Z score  | 5.3 5.0 | 5.5 | 4.6 | 4.8 | 5.4 | 5.3 5.2 |
4.4 5.7
| Ratio              | 4.3       | 5.8  |     | 4.5  | 4.7  | 5.7 5.5 |
| ------------------ | --------- | ---- | --- | ---- | ---- | ------- |
| Range              | 5.9 4.3   | 5.6  | 5.1 | 5.0  | 5.5  | 5.5 4.9 |
| Mean difference    | 28.5 74.6 | 95.7 | 5.1 | 49.2 | 94.8 | 100 4.7 |
| Z score difference | 43.9 90.7 | 99.8 | 5.9 | 69.3 | 99.6 | 100 4.9 |
| Ratio difference   | 30.6 76.8 | 96.8 | 5.1 | 52.7 | 96.8 | 100 5.1 |
| Range difference   | 42.6 90.4 | 99.1 | 5.3 | 68.5 | 99.1 | 100 5.4 |
collected for each subject in each condition. Such designs are 10 subjects or 100 subjects or 10 observations per subject or 100
common  in psychophysiological and  reaction time experi- observations per subject.
ments. Although several different transformations have been In several of the simulations, we varied both the number of
suggested for these paradigms, most investigators compute a subjects and the number of observations between 10 and 20. In
simple mean for each subject in each condition and then ana- every case, power was increased more by increasing the number
lyze those means, often after performing some correction for of subjects than by increasing the number of observations, but
outliers, such as 3-SD elimination. Our simulations show that the difference between the two was not large. In most experi-
the most common analysis procedures are far from the most
ments, it is easier and cheaper to increase the number of obser-
powerful. In almost every situation that we examined, there vations than the number of subjects. Of course, in the present
were transformations that yielded higher power than simple simulations we assumed that subjects were independent of one
means. That increase in power was often substantial, in some another and that observations were independent of one an-
cases a three- to fourfold increase. In no case did those transfor- other. The latter assumption may be harder to justify in prac-
mations adversely affect the probability of a Type I error. Cor- tice.
rections for outliers were often quite influential, but, contrary
to popular practice, trimming was more effective than 3-SD
|     |     |     |     |     | Types of  | Effect |
| --- | --- | --- | --- | --- | --------- | ------ |
elimination.
In situations in which baselines might change over time, we We added three different types of effects to the experimental
examined the effect of the transformations using difference conditions: absolute, relative, and distributional. The rank or-
scores between baseline and treatments. The transformations
dering of the effectiveness of the various transformations did
had the same effect with difference scores that they did with not differ as a function of effect type. Most parametric tests
raw scores. Logically, if baselines are likely to change, differ- assume that effects are absolute (i.e., a constant is added to every
ence scores offer a more accurate picture of the effect of the score in a particular condition). We believe that some combina-
independent variable. tion of relative and distributional effects is the most realistic,
but the distinction does not appear important for our present
purpose.
Number of Subjects and Observations
|     |     |     |     | Why Transformations  |     | Help |
| --- | --- | --- | --- | -------------------- | --- | ---- |
The rank ordering of the effectiveness of the various transfor-
mations did not differ as a function of the number of subjects or Parametric tests, such as the t test, assume that the scores are
the number of observations per subject, provided the effect size identically distributed random variables. One aspect of that
did not yield ceiling effects. For instance, the Z transformation
assumption is that each subject is assumed to have the same
was optimal with normally distributed data whether there were
variance. As long as each subject contributes only one observa-

578 L. BUSH, U. HESS, AND G. WOLFORD
tion, or one observation per condition, there is no way of exam- Weak Scales
ining the equality of variance across subjects. In our simula-
In some experiments, the data may not meet the assumptions
tions, we explicitly manipulated the variance across subjects.
for an interval scale. Perhaps only the ordinal information is
When variability differed across subjects, the transformations
valid. In that case, any monotonic transformation would pre-
had a positive and, often, large effect. When all subjects were
serve the meaningfulness of the data, and the transformations
assigned the same variance, none of the transformations had
discussed herein are monotonic, at least within a subject. Unfor-
any effect (see Simulation 2 in Table 5). The Z, ratio- and range-
tunately, because it is inappropriate to use parametric tests with
correction transformations scale each subject's effect in terms
such data, none of the results of the present simulations would
of that subject's dispersion, thereby equating variance across
apply. Furthermore, there are only a few distribution-free tests
subjects. The log transformation tends to equate variance
available for within-subject data, and our transformations
across subjects and across conditions, but only if the data have a
would not affect those tests. For example, a sign test is affected
particular underlying distribution. Thus, if the data are nor-
only by the ordering of each subject's two scores. All the trans-
mally distributed, logs do not increase the homogeneity of vari-
formations that we examined in the present simulations would
ance, but if the data follow a gamma distribution, logs do in-
preserve the ordering of the two scores and leave the sign test
crease the homogeneity of variance.
unchanged.
On the basis of all the data that we have examined (from our
laboratory and elsewhere), subjects do differ in variability in
most tasks, often substantially. We believe that these differ- Convention
ences are the rule rather than the exception.
Another reason for not choosing some transformation is the
desire or need to compare the results with results in the litera-
ture. Differences in magnitude across similar studies might
Reasons for Not Transforming One's Data
signal important procedural differences that had been over-
Although in almost every case the appropriate transforma- looked. There is a danger, though, in choosing an analysis pro-
tion yields a substantial increase in power, there are several cedure solely on the basis of convention. It is possible that some
reasons for not transforming the data. null results in the literature arose from a lack of power rather
than a lack of effect and that an appropriate transformation
might have uncovered those effects. An obvious solution to this
Strong Scales and Strong Inference problem is for the researcher to analyze his or her data using
both the conventional procedure and the most powerful proce-
Sometimes the experimenter has reason to believe that the
dure based on the results of our simulations. Both analyses
data represent an absolute, ratio, or interval scale and is inter-
could be reported, and differences in outcomes could be high-
ested in those absolute magnitudes, ratios, or intervals. There lighted. Differences between analyses could provide useful in-
are some experiments in which the absolute magnitudes of the
formation about individual differences.
dependent measure are of interest for theoretical or logical rea-
sons. For instance, a researcher might be interested in estimat-
ing nerve conduction rates in humans using a reaction time Distortion of Pattern
procedure. In that case, the investigator would wish to deter- As we described earlier, many investigators shy away from
mine the absolute magnitude of the estimated time. Any trans- transformations, such as Z, because they worry that such trans-
formation would destroy those absolute magnitudes. In a simi- formations might distort the pattern of results. It is true that
lar fashion, Townsend (1992) argued that there are situations in one can obtain a different ordering of conditions with raw
which reaction times can be demonstrated to lie on a ratio scale means versus the Z transformation. However, as shown in Ta-
and the ratios are of theoretical interest. Again, any transforma- ble 4, when there is a difference in ordering, the Z transforma-
tion other than simple multiplication would destroy the mean- tion is more likely than raw means to yield the correct ordering.
ingful ratios. Finally, reversals of orderings never occurred for significant ef-
In our opinion, though, many experimenters are primarily fects.
interested in whether an independent variable produces a signif-
icant effect and not in the absolute magnitudes, ratios, or inter-
Recommendations
vals that were obtained. The values that are obtained are a
function of the measuring instrument that is chosen and there On occasion, theory or logic requires the preservation of ab-
often is not a compelling reason to choose one instrument over solute magnitudes, and transformations should be avoided. On
another. For example, in a maze experiment, the experimenter other occasions, convention dictates a particular form of data
might measure motivation by measuring the time to reach the analysis (but see earlier section on convention). In the absence
goal. Those reaction times could be converted to speeds by of either of those circumstances, we recommend the following.
taking reciprocals. This is a nonlinear transformation and
would certainly change the magnitudes, ratios, and so on. How-
Normally Distributed Data
ever, the experimenter could have measured speed in the first
place with a radar gun. Because there might be no a priori basis For normally distributed data, the Z transformation yielded
for choosing between reaction time and speed, it is hard to the highest power, followed closely by the range-correction
know which one is correct. transformation. Winer's (1971) trimming procedure enhanced
.srehsilbup
deilla
sti
fo
eno
ro
noitaicossA
lacigolohcysP
naciremA
eht
yb
dethgirypoc
si
tnemucod
sihT
.yldaorb
detanimessid
eb
ot
ton
si
dna
resu
laudividni
eht
fo
esu
lanosrep
eht
rof
ylelos
dednetni
si elcitra
sihT

WITHIN-SUBJECT TRANSFORMATIONS 579
power in the presence of outliers and did not reduce power in In I. Martin & P. H. Venables (Eds.), Techniques in psychophysiology
the absence of outliers. Therefore, we recommend the use of (pp. 139-246). New York: Wiley.
Hess, U, Kappas, A., McHugo, G. J., Lanzetta, J. X, & Kleck, R. E.
trimming in the type of design that we employed. The 3-SD
(1992). The facilitative effect of facial expression on the self-regula-
elimination procedure was inferior to trimming in every way
tion of emotion. InternationalJournal of Psychophysiology, 12, 251-
and should be avoided. Logs and medians reduced power with
265.
normally distributed data and should be avoided.
Kruskal, J. B. (1968). Statistical analysis: Transformations of data. In
International Encyclopedia of the Social Sciences (pp. 182-193). New
Skewed Data York: Macmillan.
Levey, A. B. (1980). Measurement units in psychophysiology. In I. Mar-
For skewed data, the optimal transformation varies accord- tin & P. Venables (Eds.), Techniques in psychophysiology (pp. 597-
ing to circumstance in complex ways. For instance, medians 628). New York: Wiley.
Lykken, D. T. (1972). Range correction applied to heart rate and GSR
yielded the highest power with outliers but the lowest power
data. Psychophysiology, 9, 373-379.
without outliers. Furthermore, it is impossible to determine
Lykken, D. X, Rose, B., Luther, B., & Maley, M. (1966). Correcting
conclusively with real data whether extreme points are outliers psychophysiological measures for individual differences in range.
or not. Therefore, we recommend the use of trimming coupled
Psychological Bulletin, 66, 481-484.
with the Z or range-correction transformation. This combina- Lykken, D. X, & Venables, P. (1971). Direct measurement of skin con-
tion did not yield the highest power in many cases with skewed ductance: A proposal for standardization. Psychophysiology, 8,656-
data, but it worked well in every case, was far superior to raw 672.
means, and is easy to employ and understand. We do not recom- McHugo, G. J., & Lanzetta, J. T. (1983). Methodological decisions in
mend the use of the combination of log and Z, even though it social psychophysiology. In J. T. Cacioppo & R. E. Petty (Eds.), Social
generally yielded the highest power, because the advantage over psychophysiology: A sourcebook (pp. 630-655). New York: Guilford
Press. the Z transformation alone (provided trimming was used) was
Miller, J. (1988). A warning about median reaction time. Journal of
too small to justify the additional complexity. A final advantage
Experimental Psychology: Human Perception and Performance, 14,
of our recommendation to use the Z transformation with
539-543.
skewed data is that it is the same as our recommendation for
Paintal, A. S. (1951). A comparison of the galvanic skin responses of
normally distributed data. This consideration is potentially im- normals and psychotics. Journal of Experimental Psychology, 41,
portant. For our simulations with skewed data, we chose distri- 425-428.
butions that were highly skewed. As the degree of skew dimin- Posner, M. I. (1978). Chronometric explorations of 'mind. Hillsdale, NJ:
ishes, the results converge on the results from the normally Erlbaum.
distributed data. Roberts, F. (1979). Measurement theory with applications to decision
making, utility, and social sciences. Reading, MA: Addison-Wesley.
Siddle, D., & Turpin, G. (1980). Measurement, quantification, and anal-
References ysis of cardiac activity. In I. Martin & P. Venables (Eds.), Techniques
in psychophysiology (pp. 139-246). New York: Wiley.
Ben-Shakhar, G. (1985). Standardization within individuals: A simple Smith, J. E. K. (1976). Data transformations in analysis of variance.
method to neutralize individual differences in skin conductance. Journal of Verbal Learning and Verbal Behavior, 15, 339-346.
Psychophysiology, 22, 292-299. Stemmler, G. (1987a). Implicit measurement models in methods for
Ben-Shakhar, G. (1987). The correction of psychophysiological mea- scoring physiological reactivity. Journal of Psychophysiology, 1,113-
sures for individual differences in responsivity should be based on 125.
typical response parameters: A reply to Stemmler. Psychophysio- Stemmler, G. (1987b). Standardization within subjects: A critique of
logy, 24, 247-249. Ben-Shakhar's conclusions. Psychophysiology, 24, 243-246.
Box, G. E. P., & Muller, M. E. (1958). A note on the generation of Townsend, J. T. (1992). On the proper scales for reaction time. In H.
random normal deviates. Annals of Mathematical Statistics, 29, Geissler, S. Link, & J. Townsend (Eds.), Cognition, information pro-
610-611. cessing, andpsychophysics:Basicissues(pp.\Q5-\2Q). Hillsdale, NJ:
Cacioppo, J. X, Tassinary, L. G., & Fridlund, A. J. (1990). The skeleto- Erlbaum.
motor system. In J. T. Cacioppo & L. G. Tassinary (Eds.), Principles Townsend, J. X, & Ashby, F. G. (1984). Measurement scales and statis-
of psychophysiology: Physical, social and inferential elements (pp. tics: The misconception misconceived. Psychological Bulletin, 96,
325-384). Cambridge, England: Cambridge University Press. 394-401.
Edelberg, R. (1972). Electrical activity of the skin: Its measurement Venables, P., & Christie, M. (1980). Electrodermal activity. In I. Martin
and uses in psychophysiology. In N. S. Greenfield & R. A. Sternbach & P. Venables (Eds.), Techniques in psychophysiology (pp. 3-68). New
(Eds.), Handbook of psychophysiology (pp. 367-418). New York: York: Wiley.
Holt, Rinehart & Winston. Wilcox, R. R. (1992). Why can methods for comparing means have
Fowler, C. A., Treiman, R., & Gross, J. (in press). The structure of relatively low power and what can you do to correct the problem?
English syllables and polysyllables. Journal of Memory and Lan- Current Directions in Psychological Science, 1, 101-105.
guage. Winer, B. J. (1971). Statistical principles in experimental design (2nd
Fowles, D. C. (1986). The eccrine system and electrodermal activity. In ed.). New York: McGraw-Hill.
M. G. H. Coles, E. Donchin, & S. W Porges (Eds.), Psychophysiology:
Systems, processes, and applications (pp. 51-96). New \fork: Guil- Received December 18,1990
ford Press. Revision received September 17,1992
Graham, F. K. (1980). Representing cardiac activity in relation to time. Accepted September 18,1992 •
.srehsilbup
deilla
sti
fo
eno
ro
noitaicossA
lacigolohcysP
naciremA
eht
yb
dethgirypoc
si
tnemucod
sihT
.yldaorb
detanimessid
eb
ot
ton
si
dna
resu
laudividni
eht
fo
esu
lanosrep
eht
rof
ylelos
dednetni
si
elcitra
sihT
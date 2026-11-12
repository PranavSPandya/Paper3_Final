Article
Adaptive Design of Solar-Powered Energy Systems Based on
Daily Clearness State Evolution
Dong Liang 1,*, Long Ma 1, Peng Wang 1, Yuanxia Li 1 and Yiping Luo 2
1 State Grid Gansu Electric Power Company Linxia Power Supply Company, Linxia 731100, China;
qiongma2022@163.com (L.M.); wzuohao@163.com (P.W.); shangzp0829@163.com (Y.L.)
2 State Key Laboratory of Eco-Hydraulic in Northwest Arid Region, Xi’an University of Technology,
Xi’an 710048, China; luoyiping1117@163.com
* Correspondence: liangdong0310@163.com
Abstract: The optimal designing of the hybrid energy system (HES) is a challenging task due to the
multiple objectives and various uncertainties. Especially for HES, primarily powered by solar en-
ergy, the reference solar radiation data directly impact the result of the optimization design. To
incorporate the stochastic characteristics of solar radiation into the sizing process, a data-driven sto-
chastic modeling method for solar radiation is proposed. The method involves two layers of sto-
chastic processes that capture the intraday variation and daily evolution of solar radiation. First, the
clearness index (CI) is introduced to describe the radiation intensity at different times. Then, the
daily clearness state (DCS) is proposed, based on the statistical indicators of the intraday CI. The
Markov model is used to describe the stochastic evolutionary characteristics between different
DCSs. The probabilistic distribution of the CI under different DCS is obtained based on the diffusion
kernel density estimation (DKDE), which is used for the stochastic generation of the CI at various
times of the day. Finally, the radiation profile required for the optimal design is obtained by the
stochastic generation of the DCS sequences and the intraday clearness index under corresponding
states. A case study of an off-grid solar-powered HES is provided to illustrate this methodology.
Keywords: solar radiation; hybrid energy system; optimal design; Markov model; diffusion-based
kernel density estimation
Citation: Liang, D.; Ma, L.; Wang,
P.; Li, Y.; Luo, Y. Adaptive Design
of Solar-Powered Energy Systems 1. Introduction
Based on Daily Clearness State The global drive towards environmental protection and energy sustainability has led
Evolution. Energies 2024, 17, 2328. to the increasing deployment of hybrid energy systems (HESs), which leverage the com-
https://doi.org/10.3390/en17102328
plementarity of various energy sources to improve system performance and enable the
Academic Editor: Jesús Polo integration of renewable energy sources [1–4]. Among these, photovoltaic (PV) systems
have emerged as a leading technology, with rapidly decreasing costs and maturing auxil-
Received: 27 March 2024
iary devices contributing to explosive growth in the global installed capacity [5–7]. How-
Revised: 4 May 2024
ever, the inherent uncertainty of solar power poses significant challenges to the photovol-
Accepted: 9 May 2024
taic-based HESs, particularly in the optimal design phase, when the predictive infor-
Published: 11 May 2024
mation is hard to get, making it challenging to achieve an optimal configuration that bal-
ances load demand, minimizes cost, and meets other performance indices [8–10]. It is nec-
essary to identify a reasonable method for the HES optimization design to quantitatively
Copyright: © 2024 by the authors.
analyze the uncertainty of solar radiation.
Licensee MDPI, Basel, Switzerland.
In outdoor application scenarios, the uncertainty of solar power generation is caused
This article is an open access article
by factors such as temperature, efficiency, and variations in the radiance received by the
distributed under the terms and
panel. Radiation is the direct source of solar energy, making it the main factor contributing
conditions of the Creative Com-
mons Attribution (CC BY) license to the volatility of PV systems. Typically, researchers construct physical models of PV
(https://creativecommons.org/li- modules to evaluate the effects of radiation changes on the final energy output of HES
censes/by/4.0/). [11–14]. Radiation data is usually based on typical days (weeks, months, or years) or on
Energies 2024, 17, 2328. https://doi.org/10.3390/en17102328 www.mdpi.com/journal/energies

Energies 2024, 17, 2328 2 of 17
historical measured sequences. While one could track the total global solar spectrum on
an inclined plane using satellite datasets [15], this approach may provide valuable insights
into solar radiation dynamics, but it demands significant computational resources and
data processing efforts. In addition, even if analytical methods potentially offer determin-
istic results for specific scenarios, they will not fully address the variability inherent in
real-world HES conditions [16]. For example, optimizing HES includes complex interac-
tions between multiple energy sources, diverse optimization objectives, and the need for
comprehensive uncertainty-containing radiation information. Therefore, we opted for a
stochastic modeling approach, which we integrated into our HES optimization frame-
work. This helps provide complementary benefits in addressing uncertainties, thus im-
proving decision-making effectiveness. To this end, some researchers use stochastic sam-
pling to incorporate radiation uncertainty into the optimal design of HES [17]. Li et al.
used Monte Carlo simulation and sensitivity analysis to quantify the uncertainties associ-
ated with the optimal design of solar heating systems [18]. Cho et al. used the scenario-
based approach to represent solar radiation uncertainty and time variability in the optimal
design of HES [19]. The scenarios are randomly chosen from twelve years of Typical Me-
teorological Year data. Liu proposed an uncertainty-based multi-objective design method
by generating uncertainty distributions for load prediction and RESs production based on
Monte Carlo simulation [20]. The impact of the degree of uncertainty and scenario settings
was analyzed simultaneously.
In addition, another effective method for addressing radiation uncertainty is to gen-
erate simulate sequences using stochastic modeling of cloud cover [21]. The radiation out-
side of the atmosphere at any given location on earth can be determined based on its rel-
ative position to the sun. However, the radiation received on land is weakened due to
atmospheric transmittance and induced fluctuation caused by stochastic cloud motion,
and this rate varies dynamically as air mass and cloud motion change over time [22–24].
To describe various weather states, the clearness index is introduced and widely used in
solar radiation stochastic modeling. Ngoko et al. proposed a probabilistic model for the
synthetic generation of 1 min global solar radiation data based on the second-order Mar-
kov model [25]. The model was validated by confirming the reasonable agreement be-
tween the synthetic and observed datasets. Bouabdallah et al. simulated solar radiation
with hour-level stochastic cloud cover sequences, which are generated based on Markov
transition matrices (MTM) and used for the sizing optimization of stand-alone PV systems
[26]. Although the studies mentioned above consider uncertain solar radiation sequences,
for HES optimal design, the radiation must satisfy its rationality as random time series,
which is expressed as the rational variation in daily and intraday radiation intensity. Few
studies have considered both stochastic processes of the daily and intraday radiation tran-
sition, which directly determine the temporal change characteristics of the final radiation
sequences.
In the present study, the daily clearness states (DCSs) are introduced, based on the
intraday clearness index (CI) distribution, to describe the daily radiation intensity. The
stochastic evolution characteristics in DCSs is then modeled using the Markov model. The
obtained model is verified based on the Markov property and stationarity. Moreover, dif-
fusion-based kernel density estimation (DKDE) is applied to fit the intraday CI distribu-
tion at different DCS. By integrating the two stochastic processes of the daily clearness
states and the intraday clearness index, the stochastic model for solar radiation is estab-
lished. A total number of 2000 radiation scenarios are generated for optimal sizing of an
HES consisting of a PV, storage battery, and backup diesel generator. Half are used to
solve the optimization problem, with the objective of minimizing the COE, to obtain the
variation range of the optimal size of each component. The other half is used to perform a
techno-economic analysis of the candidate size combinations to determine the final HES
configuration.
This paper is organized as follows: Section 2 focuses on the stochastic modeling of
solar radiation. The mathematical modeling of an off-grid PV-based HES is described in

Energies 2024, 17, 2328  3 of 17

Section 3. Section 4 presents the results of the case study used to demonstrate our method.
The conclusions are drawn in Section 5.
2. Stochastic Model Description
The total solar radiation Gtot received on the ground can be divided into three parts
consisting of direct Gdir, diffused Gdif, and reflected Gr irradiation, as follows:
|     |     |     |     | =G +G   | +G  |     |     |     |
| --- | --- | --- | --- | ------- | --- | --- | --- | --- |
|     |     |     | G   |         |     |     |     | (1) |
|     |     |     | tot | dir dif | r   |     |     |     |
The Hay–Davies–Klucher–Reindl (HDKR) anisotropic model provides a method that
considers the effect of clouds on terrestrial radiation through the clearness index and the
diffuse fraction. The clearness index is defined as the ratio between the solar radiation
received on the horizontal surface Gh and the horizontal component of the extraterrestrial
radiation G0:
|     |     |     |     | k =G /G |     |     |     | (2) |
| --- | --- | --- | --- | ------- | --- | --- | --- | --- |
|     |     |     |     | t h     | 0   |     |     |     |
The horizontal component of the extraterrestrial radiation G0 can be calculated as:
|     |     |      |              | (         |     | )       |     |     |
| --- | --- | ---- | ------------ | --------- | --- | ------- | --- | --- |
|     |     | =G   |  1+0.033cos | 360N/365 |     |  cos(θ |     |     |
|     | G   |      |              |           |     | )       |     | (3) |
|     |     | 0 sc |             |           |     |  z     |     |     |
where θz is the zenith angle, N is the Nth day of the year, and Gsc is the solar constant, set
to 1367 W/m2 in this paper. Note that there are minor fluctuations in the solar constant,
primarily due to variations in solar activity, such as changes in the number and activity
level of sunspots over the solar cycle [27]. While these variations may cause some fluctu-
ations in the solar constant, they are relatively small and typically fall within acceptable
ranges. Therefore, the solar constant is generally regarded as an approximately constant
value.
A generic piecewise function of the diffuse fraction f(kt) is proposed by Bouabdallah
et al., expressed as [28]:
|     |     | 1−0.13k |     | ≤0.22 |     |     |     |     |
| --- | --- | -------- | --- | ----- | --- | --- | --- | --- |
,k
|     |     |     | t   | t   |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |

|     | f(k )= | 0.58+3.7k |     | −10.4k2+6.4k3,0.22≤k |     | ≤0.78  |     | (4) |
| --- | ------ | ---------- | --- | -------------------- | --- | ------ | --- | --- |
|     | t      |            | t   | t                    | t   | t      |     |     |

|     |     | 0.27−0.09k |     | ,k >0.78 |     |     |     |     |
| --- | --- | ---------- | --- | -------- | --- | --- | --- | --- |
|     |     |           |     | t t      |     |     |     |     |
Then, the three components of the radiation can be expressed as:
|     |     |       |       | =G [ 1− | ]   |              |     |     |
| --- | --- | ----- | ----- | ------- | --- | ------------ | --- | --- |
|     |     |       | G     | f(k     | ) R |              |     | (5) |
|     |     |       | dir   | h       | t b |              |     |     |
|     |     | {     |       |         |     |              | }   |     |
|     | =G  |       | +(1−A | 1+      | 1−  | )sin3(0.5β) |     |     |
| G   |     | f(k ) | A R   | )R     |     | f(k          |     | (6) |
| dif | h   | t     | i b   | i dif  |     | t            |    |     |
|     |     |       |       | G =ρG R |     |              |     |     |
|     |     |       |       | r h     | r   |              |     | (7) |
where Rb is the ratio of direct radiation between the tilted and horizontal plane, Rdif is the
tilt factor of the diffused component, Rr is the tilt factor for the reflected component, ρ is
the albedo, and Ai is the anisotropic index. The detailed calculation process of the HDKR
model can be found in the relative literature [29–31].
A dataset of one year of measured solar radiation is adopted in this paper, which was
measured in Yulin, China, with a longitude of 109.16° E, and a latitude of 38.29° N. The
measured radiation data covers a complete year from 1 January 2021 to 31 December 2021,
with a time interval of 1 h, and was provided by the electric power department of Shaanxi
Province, in which Yulin is located. The intention of the proposed stochastic model is to
generate the stochastic CI sequence and then bring it into the HDKR model to obtain the
corresponding Gtot. In this paper, the stochastic CI sequences are obtained by constructing
daily and intraday stochastic models, which are based on Markov models and DKDE,
respectively.

Energies 2024, 17, 2328 4 of 17
2.1. Daily Clearness State
A fundamental constraint in the optimal design of an energy system is the energy
balance between supply and demand, as the daily radiation intensity transition will di-
rectly affect the size configuration. For instance, continuous daily low radiation increases
the potential PV capacity for more power generation. Therefore, the stochastic radiation
sequences must consider the daily radiation intensity transition for an optimal design. As
described in Equation (2), the clearness index represents the extent to which extraterres-
trial radiation is attenuated by the atmosphere and clouds at a given time.
Considering this, the daily clearness states (DCSs) are introduced according to the
intraday CIs distribution to represents the daily radiation intensity. The median of intra-
day CIs is used to classify DCSs, given its ability to reflect the concentrated trend and
avoid the effects of extreme outliers. A total of nine DCSs are defined in this paper, uni-
formly distributed between 0 and 1, with a step of 0.1, as shown in Table 1. Note that
intervals [0.8, 0.9] and [0.9, 1] both are classified as s9, due to the existence of atmospheric
transmittance, which will inevitably weaken the radiation received on the ground.
Table 1. Daily clearness state classification.
The Median of Intraday CIs Daily Clearness State
[0.0, 0.1] s1
[0.1, 0.2] s2
… …
[0.7, 0.8] s8
[0.8, 1.0] s9
Figure 1 shows the statistical information for the intraday clearness index (CI) values
at different DCS, along with the corresponding normalized radiation curves. Note that the
DCSs reflect the overall daily state of radiation intensity, independent of its intraday fluc-
tuations. Although the range of intraday CIs in some states, like states 5 and 6, are dis-
persed and span multiple state intervals, the difference in radiation intensity can still be
distinguished from the Gh area diagram. The dispersion of intraday CI values represents,
to some extent, the fluctuating state of radiation, which is considered by the intraday CI
stochastic model.
Figure 1. The boxplots of the clearness index at different daily clearness states and the normalized
curve of corresponding extraterrestrial radiation and measured radiation.
2.2. State Transition Matrix
The Markov model is capable of describing the transition probability of a finite state
in a stochastic process through the Markov transition matrices (MTMs). In general,
k
xedni
ssenraelC
t
Normalized
solar
radiation

Energies 2024, 17, 2328 5 of 17
weather-related parameters, including the DCS proposed in this paper, are highly com-
plex and nonlinear, and do not fully conform to the Markov properties. However, in cer-
tain simplified models or specific circumstances, the transition of weather phenomena can
be approximated as Markov processes, which has been applied and validated in many
studies [24,25,32]. In this paper, the Markov model is employed for stochastic modeling
of the DCSs transition, which provides transition probabilities between any two DCSs, as
illustrated in Figure 2. The frequency counting method is used to estimate the transition
probabilities, based on observed frequencies of events in the historical dataset. Specifi-
cally, the estimated transition probability can be calculated by:
A
pˆ = ij
ij M (8)
A
ij
j=1
where Aij is the number of observed transitions from state i to state j; M is the number of
the states.
Figure 2. The Markov transition matrices (MTM) of the daily clearness states.
To ensure the validity of the model, the Markov chain property and stationarity of
the DCS sequence must be statistically tested. The Markov chain properties can be evalu-
ated by assessing the dependence of successive events. Based on the null hypothesis that
successive events are independent, the statistic α is asymptotically distributed as χ2, with
(N − 1)2 degrees of freedom. This statistic is defined as:
N ( )
α=2n ln p p (9)
ij ij j
i,j
where N is the total number of states, and nij and pij are the frequency and probability of
state j transfer from state i, respectively.
If the transition probabilities of a Markov process remain independent over time, the
process is considered stationary, and the statistic β has a χ2 distribution with N(N − 1)(T −
1) degrees of freedom.
T N
β=2n ij (t)ln  p ij (t) p ij   (10)
t i,j
where T is the number of subintervals and is set to four here. Each subinterval represents
about one season of the total 365 days.

Energies 2024, 17, 2328  6 of 17

As summarized in Table 2, the value of α is larger than the χ2, with 64 df at the 5%
level, which means we can reject the null hypothesis and conclude that the transition of
DCS possesses the first-order Markov chain property. Meanwhile, the stationary property
has been proven, as the value of β is smaller than the χ2 at the 5% level, with 216 df.
Table 2. Markov chain property and stationarity.
| α         | χ2 with 64 df  |     |     | β         | χ2 with 216 df  |     |
| --------- | -------------- | --- | --- | --------- | --------------- | --- |
| 284.7373  | 83.6753        |     |     | 216.4788  | 251.2864        |     |
Figure 3 shows the construction method for the DCS sequences, where v refers to
random variables uniformly distributed in the interval [0, 1], and p is the corresponding
transition probability from the obtained Markov transition matrices. Note that the proba-
bility vector used on the first day is calculated by the stationary distribution of the pro-
posed Markov model. For the rest of the sequence, the probability vector is the corre-
sponding transition vector of the previous state.
Cumulative Probability
1
...
p  + p  + p
1 2 3
 v
p  + p
1 2
p
1
|     |              |                                | ... | DCS |     |     |
| --- | ------------ | ------------------------------ | --- | --- | --- | --- |
|     | s          s |         s                    s |     |     |     |     |
|     | 1            | 2 3                            |     | 9   |     |     |

Figure 3. Construction method of the DCS sequences using the Markov model, and the red arrow
highlights the DCS corresponding to the stochastic variable v.
2.3. Distribution Fitting of Intraday CIs
The CIs at each time of the day are treated as stochastic variables, satisfying a certain
distribution that can be fitted based on the CI sets at different DCSs from the samples. The
diffusion-based kernel density estimator (DKDE) has been shown to be superior in distri-
bution fitting, as it addresses traditional KDE concerns regarding boundary bias and op-
timal bandwidth, while also improving computational speed [33–35].
|     |     |     |     | { } |     |     |
| --- | --- | --- | --- | --- | --- | --- |
Given one-dimensional n sample feature space  x ,x ,...,x , the estimated probabil-
|     |     |     |     | 1 2 n |     |     |
| --- | --- | --- | --- | ----- | --- | --- |
ity density function (PDF) obtained by KDE is:
|     |     |          | 1 n | x−x  |     |      |
| --- | --- | -------- | --- | ------ | --- | ---- |
|     |     | fˆ(x,w)= |    | K i    |     |      |
|     |     |          |     |      |     | (11) |
|     |     |          | nw  |  w   |     |      |
i=1
where K(·) is the kernel function, and w is the bandwidth.
The Gaussian kernel function is commonly used in KDE, which can be expressed as:
−1
1 x2
|     |     | φ(x)= |     | e 2   |     | (12) |
| --- | --- | ----- | --- | ----- | --- | ---- |
2π
The Gaussian kernel density estimator (GKDE) is the only solution to the diffusion
partial differential equation, as shown in Equation (12).

Energies 2024, 17, 2328  7 of 17

|     |     |     | ∂   | 1 ∂2                      |     |     |     |
| --- | --- | --- | --- | ------------------------- | --- | --- | --- |
|     |     |     |     | fˆ(x;t)= fˆ(x;t),x∈R,t>0  |     |     |     |
(13)
|     |     |     | ∂t  | 2∂x2 |     |     |     |
| --- | --- | --- | --- | ---- | --- | --- | --- |
By defining the domain R belong to [0, 1], the initial and boundary condition can be
expressed as:
|     |     |     |     | 1 n               |     |     |     |
| --- | --- | --- | --- | ----------------- | --- | --- | --- |
|     |     |     |     | fˆ(x,0)= δ(x−x)  |     |     |     |
(14)
|     |     |     |     | n   | i   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
i=1
|     |     |     |     | ∂ ∂      |          |     |      |
| --- | --- | --- | --- | -------- | -------- | --- | ---- |
|     |     |     |     | fˆ(x;t)| | fˆ(x;t)| |     |      |
|     |     |     |     | =        |          | =0  | (15) |
|     |     |     | ∂x  | x=0 ∂x   | x=1      |     |      |
where δ(·) is Dirac function.
Substituting the CI sets under each DCS, the estimated PDFs can be obtained by solv-
ing the diffusion partial differential equation in Equation (12). The obtained PDFs and
corresponding CDFs by DKDE at different DCSs are shown in Figure 4. Due to the uni-
form [0, 1] property of the CDF, the stochastic CI can be obtained from the inverse CDF
by generating a random variable of uniform [0, 1], as shown in Equation (15).
|     |     |     |     | kˆ =F−1(v), i=1,2,...,N  |     |     |     |
| --- | --- | --- | --- | ------------------------ | --- | --- | --- |
(16)
|     |     |     |     | t i |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
where v is the random variable, and Fi is the CDF at i-th DCS.
Daily Clearness State (DCS)
| s   | s   | s s | s   | s s | s   | s   |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1   | 2   | 3 4 | 5   | 6 7 | 8   | 9   |     |
| 12  |     |     |     | 1   |     |     |     |
Estimated distribution
10
|     | Statistical distribution |     |     | 0.8 |     |     |     |
| --- | ------------------------ | --- | --- | --- | --- | --- | --- |
8
0.6
6
0.4
4
0.2
2
0
0
| 0 0.2 | 0.4              | 0.6 0.8 | 1   | 0 0.2 | 0.4              | 0.6 0.8 1 |     |
| ----- | ---------------- | ------- | --- | ----- | ---------------- | --------- | --- |
|       | Clearness indexk |         |     |       | Clearness indexk |           |     |
|       |                  | t       |     |       |                  | t         |     |

Figure 4. The estimated PDFs and CDFs of the clearness index at different daily clearness states.
2.4. Stochastic Solar Radiation
The final solar radiation sequences are determined by generating stochastic DCS
transition chains, with their corresponding intraday CIs. Figure 5 shows an annual hourly
stochastic solar radiation curve; as the stochastic model is based on a clear-sky model, the
simulated radiation data changes are consistent with the quarterly trend.

Energies 2024, 17, 2328 8 of 17
Figure 5. Simulated stochastic solar radiation.
3. Optimization Model of HES
The optimal design of a residential off-grid photovoltaic-based HES is used to illus-
trate the methodology proposed in this paper. The configuration of the hybrid system, as
shown in Figure 6, comprises a PV-battery system with a backup diesel generator. This
configuration is particularly useful for remote areas where the grid is difficult to reach,
and solar power is sufficient. The battery smooths out fluctuation in the PV output and
improves the efficiency of the system, with a backup diesel generator ensuring an unin-
terrupted power supply.
PV Panels Battery bank
DC
AC/DC Converter
AC
Diesel
Generator
Loads
Figure 6. Configuration of the hybrid system.
3.1. Objective Function
The cost of the energy (COE) is used to evaluate the performance of the HES config-
uration, which is usually composed of equipment depreciation cost Cdep, fuel cost Cfuel,
emission cost Cemi, maintenance cost Cmai, and auxiliary equipment depreciationCdep in
aux
terms of the per unit energy converted to load demand.
( )
T I Cdep +Cemi +Cfuel +Cdep +Cmai
COE= t=1 i=1 i,t i,t i,t aux
(17)
T d
t=1 t
where T is the number of discretized times, I is the number of components in the proposed
system, and d is the load demands.
The depreciation cost can be calculated from two aspects: the life lost over time (phys-
ical time) and the life lost due to operation (lifetime throughput), which can be expressed
by Equations (17) and (18), respectively.
2
)
m/W(
noitaidar
raloS

Energies 2024, 17, 2328  9 of 17

Δt
|     | Cdep | =wccap   |     |     |      |
| --- | ---- | -------- | --- | --- | ---- |
|     | phy  |          |     |     | (18) |
tphy
p
|     | C d ep | =wccap   |     |     |      |
| --- | ------ | -------- | --- | --- | ---- |
|     | o p    |          |     |     | (19) |
plife
where w is size of the component; note that the units of w for each component in this paper
are kW, kWh, and m2, corresponding to diesel generator, battery, and PV, respectively.
Δt is the time step,  ccap is the cost of the per unit size of the component, tphy is the physical
lifetime, p is the energy supply from the component per time step, and plife represents the
energy lifetime throughput of the component.
Considering the time overlap, the depreciation cost at each time is set as the higher
value between the two methods.
=max(Cdep,Cdep)
|     | Cdep |     |     |     | (20) |
| --- | ---- | --- | --- | --- | ---- |
phy op
The fuel cost is determined as:
p
|     | Cfuel | =cfuel   |     |     |      |
| --- | ----- | -------- | --- | --- | ---- |
|     |       | qη       |     |     | (21) |
v
where  cfuel  is the fuel price,  q   is the heat value of the fuel, and  η   refer to the effi-
v
ciency.
In this paper, the cost of emission only considers the damage caused by the CO2,
which can be calculated by the following equation:
p
|     | Cemi =cemi | femi      |     |     |      |
| --- | ---------- | --------- | --- | --- | ---- |
|     |            |           |     |     | (22) |
|     |            | CO2 CO2 η |     |     |      |
where  c em i  is the emission cost of the CO2 per kilogram, and  f e m i is the emission factor.
C O C O
| 2   |     |     |     | 2   |     |
| --- | --- | --- | --- | --- | --- |
To simplify the complexity of the model, the auxiliary equipment depreciation cost
is assumed to be calculated based on the initial investment cost.
I ( )
|     | Cdep=fdep | wccap |     |     |      |
| --- | ---------- | ----- | --- | --- | ---- |
|     |            |       |     |     | (23) |
|     | aux aux    | i i   |     |     |      |
i=1
where  fdep is the depreciate coefficient of the auxiliary equipment.
aux
The optimal design of the HES aims to find the size configuration to meet the power
demand with the lowest COE within a given timeframe. The final optimization objective
can be written as:
|             | (          | )           |              |        |      |
| ----------- | ---------- | ----------- | ------------ | ------ | ---- |
| T I max | Cdep ,Cdep | +Cemi       | +Cfuel+Cdep | +Cmai |      |
|            |            |             |              |       |      |
| t=1 i=1    | phy(i,t)   | op(i,t) i,t | i,t         | aux    |      |
| min        |            |             |              |       | (24) |
|             |            | T d        |              |        |      |
|            |            |             |              |       |      |
|            |            | t=1 t       |              |       |      |
3.2. Constraints
The HES should satisfy the energy balance constraint between energy supply and
demand:
I
|     | p =d     | =1,2,...,T |     |     |      |
| --- | --------- | ---------- | --- | --- | ---- |
|     |   where t |            |     |     | (25) |
i,t t
i=1
p d
where   represent the power generation of component i at time t, and   is the power
i,t t
demand at time t.
The energy supply of each component needs to meet its capacity constraints:

Energies 2024, 17, 2328  10 of 17

| 0≤ p ≤w Δt |     |     |     |
| ----------- | --- | --- | --- |
DG,t DG

| 0≤ p ≤η Rw | Δt  |     |     |
| ---------- | --- | --- | --- |

| PV,t PV t PV                       |     |               |      |
| ---------------------------------- | --- | ------------- | ---- |
|  0≤ ≤min(VdischargeIdischargeΔt,w |     | ηdischarge)   | (26) |
p
|  BT,t                           | MAX | BT BT     |     |
| -------------------------------- | --- | --------- | --- |
|  0≥ p ≥max(−VchargeIchargeΔt,−w |     | /ηcharge) |     |

| BT,t | MAX | BT BT |     |
| ---- | --- | ----- | --- |
For the battery, the constraints of state of charge (SOC) should also be satisfied, which
can be expressed as:
|           | p                |       |      |
| ---------- | ---------------- | ----- | ---- |
| 0≤SOC =SOC | + B T            | ,t ≤1 |      |
|  t        | t−1 ηdischa r ge |       |      |
|           |                  | w     |      |
|            | BT               | BT    |      |
|           |                  |       | (27) |
η ch argep
|  0≤SOC =SOC | + B T | BT,t ≤1 |     |
| ------------ | ----- | ------- | --- |
|             | t−1   |         |     |
t w
|    | BT  |     |     |
| --- | --- | --- | --- |
Note that the depreciation cost is represented as a maximum value function; an aux-
iliary variable is set to linearize this as:
 z ≥ x
 ≥
z y

z ≤ x+M(1−u )
1
|  ≤ y+M(1−u |     |     | (28) |
| ----------- | --- | --- | ---- |
z )
 2
 u +u ≥1
 1 2
 u ,u ∈{0,1}
1 2
where z is the auxiliary variable, x and y refer to the life lost over time and the life lost due
to operation, respectively; M is a sufficiently large constant.
4. Experimental Results
A total of 2000 sets of annual hourly stochastic solar radiation scenarios are generated
by the proposed stochastic model. The data are equally divided into two blocks of 1000
sets, with half used for the optimal design of the proposed HES and the other half used
for analysis of operational performance of the candidate sizes. The size of the PV panel,
diesel generator, and battery are treated as decision variables in the optimal design pro-
cess. The optimization models are solved using the Python 3.9 optimization package
RSOME with Gurobi version 10.0.
The load profiles are randomly generated based on the typical load profile for a local
village at the same location as the solar radiation data. Note that the study area consists
of the simple hybrid energy systems of remote mountain villages. Their loads are mainly
determined by essential production and living needs, and fluctuations due to changes in
seasons, temperatures, etc., are typically small. Figure 7 illustrates the typical load profile,
and the load variation rate is set as 0.2.

Energies 2024, 17, 2328  11 of 17

Figure 7. Daily typical load profile of the local village.
Technical data employed in the computations are provided in Table 3. These data
cover the efficiency of each component, the costs, and other necessary parameters for the
calculation process. Note that the estimates of some parameters may deviate from the ac-
tual scenarios, which, due to the costs, efficiency, reliability, and durability of the system
devices, are intricately linked to their origin, manufacturer, and the current stage of de-
velopment. Additionally, prices often include not only the cost of the equipment itself, but
also the associated expenses, such as those related to installation and transportation, es-
pecially for the remote rural household users studied in this paper. The results obtained
from the proposed optimization model only represent the optimal configuration under
the set conditions. However, this framework is universal and replicable.
Table 3. Technical data employed in the computations.
| Components        | Description   | Data                           | Source  |
| ----------------- | ------------- | ------------------------------ | ------- |
| PV array          | Capital cost  | USD 285.3/m2                   | e       |
|                   | Efficiency    | 17.12%                         | [7]     |
|                   | Lifetime      | 20 years                       | a       |
| Diesel generator  | Capital cost  | USD 405.82/kW                  | [13]    |
|                   | Efficiency    | 0.3                            | e       |
|                   | Fuel price    | USD 1.29/L                     | e       |
|                   | Lifetime      | 15 years (or 50,000 operation  | a       |
hour)
|           | Emission factor           | 7.05 × 10−5 kg/kJ            | e     |
| --------- | ------------------------- | ---------------------------- | ----- |
| Battery   | Capital cost              | USD 135.8/kWh                | [11]  |
|           | Life cycles               | 1200                         | a     |
|           | Lifetime                  | 10 years                     | a     |
|           | Maximum charge rate       | 0.3 C                        | e     |
|           | Maximum discharge rate    | 3 C                          | e     |
|           | Minimum state-of-charge   | 0.4                          | e     |
|           | Charge efficiency         | 0.9                          | e     |
|           | Discharge efficiency      | 0.9                          | e     |
| Others    | Load variation            | 0.2                          | a     |
|           | System maintenance cost   | USD 0.015/h                  | a     |
|           | Auxiliary equipment cost  | 30% of initial capital cost  | a     |
|           | System lifetime           | 15 years                     | a     |
Note: a—assumed values; e—estimated values.
Battery aging paths are determined by nonlinear functions of the state of charge
(SOC), depth of discharge (DOD), C-rate (defined as the charge or discharge current di-
vided by the battery’s capacity to store an electrical charge, with the unit h − 1), tempera-
ture, etc. Commonly, battery aging models adopted in microgrid assessment and control

Energies 2024, 17, 2328 12 of 17
references are mainly simplified to be linearly related with DOD and cycle amounts [36].
In this paper, we have separately defined the lifetime and life cycles of the battery, repre-
senting the lifespan under standby conditions and its cycle lifespan, respectively.
The cost of auxiliary equipment depreciation, including the system controller, battery
chargers, enclosures, switch gear, fuses, wiring, etc., was taken into account in the calcu-
lation. Note that the cost of the inverter, a key component of the HES, is not explicitly
calculated in the optimization model, but is considered along with the cost of the auxiliary
equipment. As a matter of fact, the selection of inverters is directly related to the capacity
of the generating devices; once the capacity of generating devices is determined, compat-
ible inverters can be determined. The cost of emissions was also considered; this is the
responsibility of the user and is not always considered in some countries.
4.1. Optimal Sizing
The time horizon of one year is chosen for the optimal design of the HES, as it en-
compasses a full cycle of solar motion. The results of the optimization are summarized in
Figure 8, which shows a clear correspondence between the yearly total radiation and the
annual COE. Specifically, the optimal sizing of the HES tends to involve a larger battery
and a smaller diesel generator capacity for scenarios with higher yearly total radiation,
resulting in a smaller annual COE. Conversely, scenarios with lower yearly total radiation
require a larger diesel generator capacity to meet the load demand, resulting in a higher
annual COE. The maximum and minimum yearly total radiation are 1874.6 kW/m2 and
1607.4kW/m2, resulting in a difference of 14.25%, which corresponds to a COE of USD
0.372/kWh and USD 0.388/kWh, respectively, which represents a difference of 4.3%. This
result underscores the sensitivity of the optimal sizing of the HES to variations in yearly
total radiation levels and highlights the importance of the radiation uncertainty in the de-
sign of HES. Meanwhile, the optimal sizes in different radiation scenarios are maintained
within a certain range, with PV in [10.58, 13.86] m2, battery in [7.3, 15.1] kWh, and diesel
generator in [1.54, 2.22] kW.
Figure 8. Results of the optimal design with stochastic radiation.
Additionally, the obtained operation schedule for each component in the HES over
the entire simulation period is the optimal scheduling strategy for minimizing the COE.
Figure 9 shows an example of the power dispatch schedule, with two time periods taken
from winter and summer, respectively. The scenario of the example has the max yearly
total radiation of 1874.6 kW/m2, with the sizes of PV of 13.07 m2, battery of 14.51 kWh, and
diesel generator of 1.67 kW, resulting in an annual COE of USD 0.372/kWh.

Energies 2024, 17, 2328 13 of 17
(a)
(b)
Figure 9. The power dispatch schedule of the optimal size under the scenario with yearly total radi-
ation is 1874.6 kW/m2. (a) January 1st to 5th; (b) July 1st to 5th.
From Figure 9, as the demand is low during the daytime and high after sunset; excess
power generated by the PV panel is stored in batteries and used along with the diesel
generators for the night load. In the winter, the low intensity of solar radiation makes it
necessary to combine with a diesel generator to meet the load supply during the daytime.
Conversely, during the summer months, the increased generation of solar power allows
for greater flexibility in the deployment of energy storage, resulting in a reduced reliance
on diesel generators. As shown in Figure 9b, sufficient PV power generation causes the
battery to undergo a full charge/discharge cycle per day, within the feasible SOC. Addi-
tionally, it is worth noting that during the winter months, all the PV power is utilized for
the load supply or battery charge, whereas there is PV power curtailment during the sum-
mer months.
4.2. Techno-Economic Analysis
The obtained 1000 sets of optimal sizes are only used for the respective radiation sce-
narios to acquire the minimum COE by optimal energy scheduling. However, the range
of optimal sizes obtained for each component in the optimal design, with sufficient radi-
ation scenarios, provides a reference for sizing configurations of systems under radiation
uncertainty. In this section, five candidate sizes are selected from the optimal range, while
the techno-economic analysis is performed based on the remaining 1000 sets of radiation
scenarios. Respectively, sizes (1), (2), and (3) are the minimum, maximum, and mean sizes
from the optimal size range of each component, and sizes (4) and (5) are the optimal sizes
of the maximum/minimum yearly total radiation scenario.
)hWk(
noitareneg
rewoP
)hWk(
noitareneg
rewoP
)COS(
egrahc
fo
etatS
)COS(
egrahc
fo
etatS

| Energies 2024, 17, 2328  |     |     |     |     |     | 14 of 17  |
| ------------------------ | --- | --- | --- | --- | --- | --------- |

Table 4 gives the statistical index for each size of the HES, including the specific size
information, initial capital cost, annual COE, average energy supply, average PV power
generation, etc. Overall, the main difference between the various size combinations comes
from the battery capacity, which also creates a gap in their initial investment. The annual
COE fluctuated within USD 0.0157 to 0.0194/kWh for each HES in the random scenario,
with a difference of USD 0.0284/kWh between the maximum and minimum COE for all
HES. The smallest COE occurs at the size (5) of USD 0.3821/kWh, and since it is taken from
the smallest yearly total radiation scenario, a larger diesel generator capacity must be con-
figured to meet the load demand. The largest COE occurs under size (2), with USD
0.4105/kWh; the size consists of the maximum sizes from the optimal size range of each
component, leading to the highest initial capital cost of USD 6909.8. Only size (1) shows a
loss of energy supply, with a yearly average of 12.03 kWh and a loss probability of 0.15%.
The average proportion of PV generation is positively correlated to its capacity, with a
maximum of 64.1% for size (2), while the average curtailment rate is correlated to battery
capacity, with a minimum of 13.17% for size (4) (752.17kWh/year). Size (4) is the most
notable among all candidate size combinations, with average COE of USD 0.3931/kWh,
which is only USD 0.0041/kWh higher than the minimum, yet it exhibits the second-high-
est PV proportion and the smallest curtailment rate.
Table 4. Statistical results of chosen size combination.
| Parameter  | Description  | (1)     | (2)  | (3)  | (4)  | (5)  |
| ---------- | ------------ | ------- | ---- | ---- | ---- | ---- |
|            | Min.         | 1590.0  |      |      |      |      |
|            | Max.         | 1894.8  |      |      |      |      |
Yearly total radiation (kW/m2)
|       | Mean                   | 1746.0  |         |         |         |         |
| ----- | ---------------------- | ------- | ------- | ------- | ------- | ------- |
|       | Range                  | 304.8   |         |         |         |         |
|       | PV (m2)                | 10.58   | 13.86   | 12.37   | 13.07   | 11.25   |
| Size  | Battery (kWh)          | 7.27    | 15.1    | 11.27   | 14.51   | 7.98    |
|       | Diesel generator (kW)  | 1.54    | 2.23    | 1.84    | 1.67    | 2.09    |
|       | Total                  | 4483.6  | 6909.8  | 5806.3  | 6377.0  | 5142.8  |
|       | PV                     | 3018.5  | 3954.3  | 3529.2  | 3728.9  | 3209.6  |
Initial capital (USD)
|     | Battery           | 986.6   | 2050.6  | 1530.5  | 1970.5  | 1083.8  |
| --- | ----------------- | ------- | ------- | ------- | ------- | ------- |
|     | Diesel generator  | 626.6   | 905.0   | 746.7   | 677.7   | 849.4   |
|     | Min.              | 0.3822  | 0.3911  | 0.3856  | 0.3842  | 0.3821  |
|     | Max.              | 0.4013  | 0.4105  | 0.4035  | 0.4053  | 0.3978  |
COE (USD/kWh)
|     | Mean        | 0.3908  | 0.3996  | 0.3933  | 0.3931  | 0.389   |
| --- | ----------- | ------- | ------- | ------- | ------- | ------- |
|     | Range       | 0.0191  | 0.0194  | 0.0179  | 0.0211  | 0.0157  |
|     | Loss (kWh)  | 12.03   | 0       | 0       | 0       | 0       |
Power supply (Mean)
|     | Loss probability (%)  | 0.15    | 0       | 0       | 0       | 0       |
| --- | --------------------- | ------- | ------- | ------- | ------- | ------- |
|     | Curtailment (kWh)     | 933.03  | 880.47  | 916.83  | 752.17  | 1034.8  |
PV Power (Mean)  Curtailment Rate (%)  20.19  14.54  16.97  13.17  21.06
|     | Proportion (%)  | 45.7  | 64.1  | 55.59  | 61.42  | 48.06  |
| --- | --------------- | ----- | ----- | ------ | ------ | ------ |
Specifically, the COE composition for each size of HES is shown in Figure 10. The
fuel and emission costs of diesel generators comprise the largest share for each size com-
bination, followed by the depreciation cost of auxiliary equipment, which is directly re-
lated to the initial capital cost of the system. The depreciation cost of the PV and diesel
generators is not sensitive to the HES size, while the depreciation cost of the battery shows
a significant increase with the increase in battery capacity. Meanwhile, higher battery de-
preciation costs mean that the battery meets the flexible take-up of PV power through
more frequent charging and discharging, which reduces the fuel costs of the diesel gener-
ator. The main advantage of distributed HES is the flexibility to meet the load demand, as
well to express the environmental friendliness of the renewable energy it contains. The
COE composition of both size (2) and size (4) exhibit high battery depreciation costs and
low fuel costs, echoing the high PV proportion of both in Table 4. Nevertheless, size (4) is

Energies 2024, 17, 2328 15 of 17
better than size (2) in terms of the cost of the initial investment, the COE, and the PV cur-
tailment rate, and seems to be the best choice in terms of both economic and environmen-
tal considerations.
Figure 10. Proportion of COE compositions for sizes (1)–(5). (1) PV-10.58 m2, battery-7.27 kWh,
diesel generator-1.54 kW; (2) PV-13.86 m2, battery-15.1 kWh, diesel generator-2.23 kW; (3) PV-12.37
m2, battery-11.27 kWh, diesel generator-1.84 kW; (4) PV-13.07 m2, battery-14.51 kWh, diesel gener-
ator-1.67 kW; (5) PV-11.25 m2, battery-7.98 kWh, diesel generator-2.09 kW.
5. Conclusions
A novel method for the stochastic modeling of solar radiation is proposed, with con-
sideration of both intraday variation and daily stochastic evolution. By introducing the
clearness index, the daily radiation intensity is divided into nine states, and the evolution
characteristics are modeled based on the Markov model. Diffusion-based kernel density
estimation is used to obtain the probabilistic distributions of the intraday clearness index
at different daily clearness states. The use of the clear sky radiation model naturally en-
sures that the obtained radiation data comply with the local solar seasonality and varia-
tions in sunlight duration. Meanwhile, the two-layer stochastic model ensures the ration-
ality of daily variations and intraday fluctuations in radiation intensity, providing a data
foundation for the optimization of the designing of solar-powered hybrid energy systems.
A methodology for the application of the proposed stochastic radiation model is illus-
trated by optimal sizing in the case of a solar-powered hybrid energy system. The main
conclusions are presented below.
(1) The proposed generation model can effectively reflect variations in solar radiation,
providing a reliable data foundation for the optimization of the designing of solar-
powered hybrid energy systems (HES).
(2) The optimal size range for each device in the hybrid energy system under random
solar radiation variations can be obtained based on the proposed model.
(3) The size combination in the maximum total yearly radiation scenario exhibits a better
overall performance. Compared to the worst-case scenario, its PV curtailment rate
decreases by 7.02%, and the COE is only USD 0.0041/kWh higher than the current
minimum.

Energies 2024, 17, 2328 16 of 17
This work considers a simple off-grid PV-battery-diesel generator system, but it can
be easily extended to more complex architectures, including other renewable energy
sources and grid connections.
Author Contributions: Conceptualization, D.L.; Methodology, L.M. and Y.L. (Yiping Luo); Software,
L.M.; Validation, P.W.; Investigation, P.W.; Data curation, Y.L. (Yuanxia Li); Writing—original draft,
D.L.; Writing—review & editing, Y.L. (Yiping Luo); Supervision, Y.L. (Yuanxia Li) All authors have
read and agreed to the published version of the manuscript.
Funding: This work was supported by the China Postdoctoral Science Foundation (No.
2020M683526).
Data Availability Statement: Data are contained within the article.
Conflicts of Interest: D.L., L.M., P.W. and Y.L. (Yuanxia Li) were employed by State Grid Gansu
Electric Power Company Linxia Power Supply Company. The remaining authors declare that the
research was conducted in the absence of any commercial or financial relationships that could be
construed as a potential conflict of interest.
References
1. Fodstad, M.; del Granado, P.C.; Hellemo, L.; Knudsen, B.R.; Pisciella, P.; Silvast, A.; Bordin, C.; Schmidt, S.; Straus, J. Next
frontiers in energy system modelling: A review on challenges and the state of the art. Renew. Sustain. Energy Rev. 2022, 160,
112246. https://doi.org/10.1016/j.rser.2022.112246.
2. Yoro, K.O.; Daramola, M.O.; Sekoai, P.T.; Wilson, U.N.; Eterigho-Ikelegbe, O. Update on current approaches, challenges, and
prospects of modeling and simulation in renewable and sustainable energy systems. Renew. Sustain. Energy Rev. 2021, 150,
111506. https://doi.org/10.1016/j.rser.2021.111506.
3. Sorrenti, I.; Rasmussen TB, H.; You, S.; Wu, Q. The role of power-to-X in hybrid renewable energy systems: A comprehensive
review. Renew. Sustain. Energy Rev. 2022, 165, 112380. https://doi.org/10.1016/j.rser.2022.112380.
4. Niknam, T.; Azizipanah-Abarghooee, R.; Narimani, M.R. An efficient scenario-based stochastic programming framework for
multi-objective optimal micro-grid operation. Appl. Energy 2012, 99, 455–470. https://doi.org/10.1016/j.apenergy.2012.04.017.
5. Temiz, M.; Dincer, I. Development of solar and wind based hydrogen energy systems for sustainable communities. Energy
Convers. Manag. 2022, 269, 116090. https://doi.org/10.1016/j.enconman.2022.116090.
6. Zhang, C.; Xia, J.; Guo, X.; Huang, C.; Lin, P.; Zhang, X. Multi-optimal design and dispatch for a grid-connected solar photovol-
taic-based multigeneration energy system through economic, energy and environmental assessment. Sol. Energy 2022, 243, 393–
409. https://doi.org/10.1016/j.solener.2022.08.016.
7. Chen, Z.; Xie, Y.L.; Zhang, H.X.; Gu, Y.J.; Zhang, X.W. Optimal design and performance assessment for a solar powered elec-
tricity, heating and hydrogen integrated energy system. Energy 2023, 262, 125453. https://doi.org/10.1016/j.energy.2022.125453.
8. El-Baz, W.; Tzscheutschler, P.; Wagner, U. Day-ahead probabilistic PV generation forecast for buildings energy management
systems. Sol. Energy 2018, 171, 478–490. https://doi.org/10.1016/j.solener.2018.06.100.
9. Lasemi, M.A.; Arabkoohsar, A.; Hajizadeh, A.; Mohammadi-Ivatloo, B. A comprehensive review on optimization challenges of
smart energy hubs under uncertainty factors. Renewable and Sustainable Energy Rev. 2022, 160, 112320.
https://doi.org/10.1016/j.rser.2022.112320.
10. Rauf, A.; Kassas, M.; Khalid, M. Data-driven optimal battery storage sizing for grid-connected hybrid distributed generations
considering solar and wind uncertainty. Sustainability 2022, 14, 11002. https://doi.org/10.3390/su141711002.
11. Guo, X.; Zhang, S.; Wang, D.; Peng, N.; Zhang, X. Techno-economic feasibility study of an electric-thermal coupling integrated
energy system for commercial buildings in different latitudes. Int. J. Energy Res. 2020, 44, 7789–7806.
https://doi.org/10.1002/er.5517.
12. Zhang, X.; Li, M.; Ge, Y.; Li, G. Techno-economic feasibility analysis of solar photovoltaic power generation for buildings. Ap-
plied Thermal Engineering 2016, 108, 1362–1371. https://doi.org/10.1016/j.applthermaleng.2016.07.199.
13. Li, M.; Zhang, X.; Li, G.; Jiang, C. A feasibility study of microgrids for reducing energy use and GHG emissions in an industrial
application. Appl. Energy 2016, 176, 138–148. https://doi.org/10.1016/j.apenergy.2016.05.070.
14. Güven, A.F.; Yörükeren, N.; Samy, M.M. Design optimization of a stand-alone green energy system of university campus based
on Jaya-Harmony Search and Ant Colony Optimization algorithms approaches. Energy 2022, 253, 124089.
https://doi.org/10.1016/j.energy.2022.124089.
15. Schuster, C.S. Analytical framework for the assessment and modelling of multi-junction solar cells in the outdoors. Renew.
Energy 2020, 152, 1367–1379. https://doi.org/10.1016/j.renene.2020.01.002.
16. Hassan, Q.; Algburi, S.; Sameen, A.Z.; Salman, H.M.; Jaszczur, M. A review of hybrid renewable energy systems: Solar and
wind-powered solutions: Challenges, opportunities, and policy implications. Results Eng. 2023, 20, 101621.
https://doi.org/10.1016/j.rineng.2023.101621.

Energies 2024, 17, 2328 17 of 17
17. Di Somma, M.; Graditi, G.; Heydarian-Forushani, E.; Shafie-khah, M.; Siano, P. Stochastic optimal scheduling of distributed
energy resources with renewables considering economic and environmental aspects. Renew. Energy 2018, 116, 272–287.
https://doi.org/10.1016/j.renene.2017.09.074.
18. Li, H.; Zhao, J.; Li, M.; Zhong, S.; Wang, F.; He, F.; Zhu, J. Determining the economic design radiation for a solar heating system
through uncertainty analysis. Sol. Energy 2020, 195, 54–63. https://doi.org/10.1016/j.solener.2019.11.061.
19. Cho, D.; Valenzuela, J. A scenario-based optimization model for determining the capacity of a residential off-grid PV-battery
system. Sol. Energy 2022, 233, 478–488. https://doi.org/10.1016/j.solener.2022.01.058.
20. Liu, Z.; Cui, Y.; Wang, J.; Yue, C.; Agbodjan, Y.S.; Yang, Y. Multi-objective optimization of multi-energy complementary inte-
grated energy systems considering load prediction and renewable energy production uncertainties. Energy 2022, 254, 124399.
https://doi.org/10.1016/j.energy.2022.124399.
21. Biencinto, M.; González, L.; Valenzuela, L. Using time-windowed solar radiation profiles to assess the daily uncertainty of solar
thermal electricity production forecasts. J. Clean. Prod. 2022, 379, 134821. https://doi.org/10.1016/j.jclepro.2022.134821.
22. Zhang, X. A statistical approach for sub-hourly solar radiation reconstruction. Renew. Energy 2014, 71, 307–314.
https://doi.org/10.1016/j.renene.2014.05.038.
23. Hocaoğlu, F.O. Stochastic approach for daily solar radiation modeling. Sol. Energy 2011, 85, 278–287.
https://doi.org/10.1016/j.solener.2010.12.003.
24. Torres, J.L.; de Blas, M.; Torres, L.M.; García, A.; de Francisco, A. Synthetic generation of standard sky types series using Markov
Transition Matrices. Renew. Energy 2014, 62, 731–736. https://doi.org/10.1016/j.renene.2013.08.022.
25. Ngoko, B.O.; Sugihara, H.; Funaki, T. Synthetic generation of high temporal resolution solar radiation data using Markov mod-
els. Sol. Energy 2014, 103, 160–170. https://doi.org/10.1016/j.solener.2014.02.026.
26. Bouabdallah, A.; Olivier, J.C.; Bourguet, S.; Machmoum, M.; Schaeffer, E. Safe sizing methodology applied to a standalone
photovoltaic system. Renew. Energy 2015, 80, 266–274. https://doi.org/10.1016/j.renene.2015.02.007.
27. Pauluhn, A.; Huber, M.C.E.; Smith, P.L.; Colina, L. Spectroradiometry with space telescopes. Astron. Astrophys. Rev. 2015, 24, 3.
https://doi.org/10.1007/s00159-015-0086-2.
28. Bouabdallah, A.; Bourguet, S.; Olivier, J.C.; Machmoum, M. Photovoltaic energy for the fixed and tracking system based on the
modeling of solar radiation. In Proceedings of the IECON 2013-39th Annual Conference of the IEEE Industrial Electronics So-
ciety, Vienna, Austria, 10–13 November 2013; pp. 1821–1826. https://doi.org/10.1109/IECON.2013.6699408.
29. Duffie, J.A.; Beckman, W.A. Solar Engineering of Thermal Processes, 4th ed.; John Wiley & Sons, Inc.: Hoboken, NJ, USA, 2013.
30. Reindl, D.T.; Beckman, W.A.; Duffie, J.A. Evaluation of hourly tilted surface radiation models. Sol. Energy 1990, 45, 9–17.
https://doi.org/10.1016/0038-092X(90)90061-G.
31. Loutzenhiser, P.G.; Manz, H.; Felsmann, C.; Strachan, P.A.; Frank, T.H.; Maxwell, G.M. Empirical validation of models to com-
pute solar radiation on inclined surfaces for building energy simulation. Sol. Energy 2007, 81, 254–267.
https://doi.org/10.1016/j.solener.2006.03.009.
32. Carpinone, A.; Giorgio, M.; Langella, R.; Testa, A. Markov chain modeling for very-short-term wind power forecasting. Electr.
Power Syst. Res. 2015, 122, 152–158.
33. Che, Y.; Wang, X.; Lv, X.; Hu, Y.; Teng, Y. Study on probability distribution of electrified railway traction loads based on kernel
density estimator via diffusion. Int. J. Electr. Power Energy Syst. 2019, 106, 383–391. https://doi.org/10.1016/j.ijepes.2018.10.021.
34. Qin, Z.; Li, W.; Xiong, X. Estimating wind speed probability distribution using kernel density method. Electr. Power Syst. Res.
2011, 81, 2139–2146. https://doi.org/10.1016/j.epsr.2011.08.009.
35. Botev, Z.I.; Grotowski, J.F.; Kroese, D.P. Kernel density estimation via diffusion. Ann. Stat. 2010, 38, 2916–2957.
https://doi.org/10.1214/10-AOS799.
36. Seger, P.V.H.; Rigo-Mariani, R.; Thivel, P.X.; Riu, D. A storage degradation model of Li-ion batteries to integrate ageing effects
in the optimal management and design of an isolated microgrid. Appl. Energy 2023, 333, 120584. https://doi.org/10.1016/j.apen-
ergy.2022.120584.
Disclaimer/Publisher’s Note: The statements, opinions and data contained in all publications are solely those of the individual au-
thor(s) and contributor(s) and not of MDPI and/or the editor(s). MDPI and/or the editor(s) disclaim responsibility for any injury to
people or property resulting from any ideas, methods, instructions or products referred to in the content.
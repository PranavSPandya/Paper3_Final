Energy&Buildings312(2024)114218
Contents lists available at ScienceDirect
&
Energy Buildings
journal homepage: www.elsevier.com/locate/enb
Advancing sustainable construction through comprehensive analysis of
thermal, acoustic, and environmental properties in prefabricated panels
with recycled PET materials
Silvia Cavagnolia, Claudia Fabiania,b,*, Fabiana Frota de Albuquerque Landia,c, Anna
Laura Piselloa,b,*
aEAPLAB at CIRIAF - Interuniversity Research Centeron on Pollution and Environment “Mauro Felli”, University of Perugia, Via G. Duranti 67, Perugia, 06125, Italy
bDepartment of Engineering, University of Perugia, Via G. Duranti 93, 06125 Perugia, Italy
cNorwegian Institute for Sustainability Research (NORSUS), Stadium 4, 1671 Kråkerøy
A R T I C L E I N F O A B S T R A C T
Keywords: Acoustic and thermal insulation materials play a crucial role in the construction industry as they ensure high-
Waste material performance applications. This study analyzes three recycled insulations (two derived from PET and one is
Prefabricated EPS with graphite additives) for innovative prefabricated panels. A multiphysics, multiscale, and multiobjective
Thermal property
approach was developed to analyze the performance of the individual materials and three prototype pre-
Acoustic property
fabricated panels incorporating them, combined with numerical analysis enabling the thermal transmittances
Numerical analysis
assessment of a full-scale panel. Thermal investigations were conducted at both small and large scales to assess
Life Cycle Assessment
Sustainability their performance. Additionally, acoustic sound insulation measurements at both scales and a LCA analysis were
PET carried out. Thermal conductivity of the insulation layer ranges from 0.026 to 0.043 Wm
(cid:0)1K (cid:0)1.
Furthermore, the
sound transmission loss exhibits a positive trend with increasing frequencies, reaching approximately 10 dB after
1600 Hz for the 15 cm thick PET insulation. EPS performs exceptionally well at low frequencies, with sound
insulation peaks reaching almost 40 dB around 400 Hz. At the large scale, the weighted sound reduction index
showed a 3.5 dB increase compared to the reference. The environmental assessment emphasized that 80 % of
global warming potential comes from material extraction, stressing the importance of using recycled materials.
1. Introduction about 39 % of the total carbon dioxide emissions and for about 36 % of
the total energy use worldwide. In this view, the building sector is
In recent times, global temperatures have risen year by year, leading constantly trying to develop new strategies to achieve very high per-
to radical changes in our environment. One of the main causes of these formance with minimal consumption and emissions. Materials’ selection
phenomena is global warming triggered by the increase of greenhouse and optimization, in particular, is of paramount importance in building
gases in the atmosphere, which have a negative effect on both the energy design and should be carried out by choosing the most appropriate so-
balance of our planet and human life on earth. Because of climate lutions to meet at the same time the demands of low energy consumption
change, different types of phenomena have developed such as melting also affected by final energy uses [73], low impact on the environment,
glaciers and thawing permafrost with an estimated loss of several billion and high performance especially in thermal, acoustic, and sustainability
tonnes of ice in recent decades and rising sea level, which is estimated to terms. To this end, there are different studies that analyze the thermal
increase progressively in the future. and acoustic properties of materials or panels in order to meet indoor
In addition to these interconnected natural phenomena, anthropo- wellness requirements. Some of these studies aim at evaluating the
genic activities also have a negative effect on the environment and, in performance of panels characterized by reinforcing materials with
particular, the construction activity is one of countless causes of the nonwoven fabrics [3], panels made of wood with an inner layer made of
environmental decline [1]: the global status report for buildings and polyurethane [4], or panels made of recycled waste materials [5,6].
construction [2] states that the construction sector is responsible for Indeed, the use of recycled materials offers numerous benefits, such as
* Corresponding authors at: CIRIAF - Interuniversity Research Center, University of Perugia, Via G. Duranti 67, 06125 Perugia, Italy.
E-mail addresses: claudia.fabiani@unipg.it (C. Fabiani), anna.pisello@unipg.it (A.L. Pisello).
https://doi.org/10.1016/j.enbuild.2024.114218
Received 20 December 2023; Received in revised form 23 April 2024; Accepted 27 April 2024
Availableonline28April2024
0378-7788/©2024TheAuthors.PublishedbyElsevierB.V.ThisisanopenaccessarticleundertheCCBY-NC-NDlicense(http://creativecommons.org/licenses/by-
nc-nd/4.0/).

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
minimizing the amount of waste sent to landfills, mitigating environ- characteristics, several studies are aimed at detailed analysis to identify
mental impacts, and lowering expenses associated with their disposal. A the greatest potential of prefabricated construction. The great func-
study conducted by Hossain et al. shows how some materials from tionality of precast has also allowed this technology to be used for un-
construction and demolition (C&D) waste can actually be reused in derground stations, particularly in China [42] where precast is heavily
different ways with a significant reduction in greenhouse gas emissions used. A study by Lu et al [43] on the design of a hundred high-rise
and nonrenewable energy consumption [7]. Indeed, there is the poten- buildings in Hong Kong estimated a reduction of more than 15 % in
tial to discover new applications for various materials like discarded waste production by simply using prefabricated construction. In addi-
tires [8], roof tiles [9], glass [10], plastic [11], and even manure [12]. tion, prefabrication has further advantages: the assembly and disas-
These materials can be repurposed effectively in the construction of sembly of components is simpler and faster, site costs are reduced, there
concrete elements, for paving, infrastructure development, and various is more control during the design phase, CO2 emissions are lower, and it
other engineering applications [12]. Specifically, the production of is easier to recycle elements or materials. This type of construction al-
plastic has witnessed a significant rise in recent times owing to its lows different types of materials to be implemented to produce building
convenience and widespread usage in daily life. Everyday items such as partitions. Indeed, it is possible to produce prefabricated wood com-
plastic bags at supermarkets, plastic bottles, toys, and food containers posite panels [44], use sandwich panels with PCM [45], or even natural
exemplify this trend. However, this progressive surge in production has fibers such as bamboo [46] as a reinforcing material. Despite the
also resulted in a corresponding increase in plastic waste, posing a numerous studies carried out on prefabricated elements, only a few
considerable environmental challenge. Indeed, researchers are studying focus on thermo-acoustic properties, which are essential parameters for
methods to reinsert this waste into production processes. For instance, achieving high levels of comfort in a structure. However, O’Hegarty’s
the use of these materials for road construction [11], improving the research examined the thermal characteristics of a slim premanufac-
viscoelastic behavior of bitumen [13], and also for the construction of tured panel composed of two concrete layers, which included a high-
concrete sidewalks has shown promise [14]. Multiple studies have performance insulating slab. The study found that this panel exhibited
examined concrete mixtures that incorporate plastic waste as aggre- a lower thermal transmittance compared to a traditional precast panel
gates. In particular, Thorneycroft’s study proposes new concrete mix- [47]. On the other hand, research conducted by Peng et al. offers a
tures by replacing 10 % of the sand with recycled plastic [15] while the comprehensive examination of a prefabricated composite panel,
work presented by Agyeman et al. explores the use of plastic material as including thermal and acoustic analyses, revealing a heat transfer co-
a binder for the production of concrete paving blocks [16]. Notably, efficient of 0.55 W/m2K and a weighted sound pressure difference of 42
polyethylene terephthalate (PET) plastic waste, commonly found in dB [48].
plastic bottles from the food industry, is a key component of plastic The predominant focus of existing research has centered on the
waste. Various studies in the literature have explored innovative ap- fundamental structural properties of PET panels, crucial for their
proaches to reintegrate PET in different fields [17] but also in con- application in construction. However, beyond these structural consid-
struction contexts, particularly in brick and concrete production. erations, addressing thermal, acoustic, and environmental sustainability
Hassan et al. [18] conducted a comprehensive review of potential aspects is equally vital, playing a pivotal role in enhancing building
integration solutions for PET, examining its incorporation into the comfort and promoting energy conservation. Functional buildings must
production of clay bricks or concrete bricks. Their studies primarily effectively control external thermal and acoustic phenomena [49],
delved into the physical and mechanical properties of these novel ma- irrespective of their specific use [50,51].
terials, encompassing compressive strength, flexural strength, density, Considering the limited scientific literature on the thermal and
and water absorption. Similarly Limami et al. [19] conducted tests to acoustic properties of prefabricated panels, this study introduces an
assess the impact of introducing PET into a clay mixture, considering innovative approach that amalgamates the benefits of prefabricated
variations in proportions based on weight and grain size. Their analyses construction with plastic recycling, addressing the imperative to reduce
focused on the porosity of the resulting bricks, coupled with density carbon emissions in the construction sector. The objective is to unveil a
analysis, capillary water absorption coefficient, and compressive novel prefabricated panel design incorporating recycled materials,
strength. Comparable analyses have been performed in the literature on thereby optimizing interior comfort levels and minimizing resource
different types of bricks incorporating PET [20–25]. Furthermore, PET waste. The aim is to develop an efficient structure with a production
waste has been explored for its application in PET foams used in com- chain in which environmentally friendly materials and recycled mate-
posite sandwich panels. Studies have involved various tests, including rials are favored and with innovative design and technology.
DMA, DSC/TGA, and Iosipescu tests [26], as well as assessments of In this context, a widespread waste is reintroduced into a production
bending [27], shear stiffness, thermal stability, and humidity [28]. cycle to produce a high-performance building product in all fields. In
Additionally, PET waste has been used to produce unsaturated polyester particular, an insulation using polyester fibers derived from recycled
resin [29,30] acting as reinforcement for precast concrete [31] or as an plastic bottles is analyzed in detail. In addition, an alternative type of
additive in the production mix for precast concrete panels, with analyses EPS insulation is presented, enriched with graphite additives to improve
focusing on rupture strength and impact resistance [32]. The versatility performance. The resulting panel is ready to use and easy to install in a
of PET materials extends to green roofs, where whole PET bottles are very short time.
utilized in the stratigraphy of the roof [33] and [34], and in the pro- To evaluate the properties of such panels comprehensively, a mul-
duction of panels [35], prefabricated slabs [36], and interior walls [37], tiphysics, multiscale, and multiobjective approach was implemented.
accompanied by thermal tests. Furthermore, in order to follow a sus- This approach involved analyzing both functional properties and envi-
tainable approach, reference can be made to the Life Cycle Assessment ronmental performance, encompassing individual components and
(LCA) study [38,39], from which different strategies and solutions can prototype panels consisting of three distinct insulation types. The study
be compared in order to seek the most appropriate and sustainable one. presents thermal and acoustic results at both small and large scales,
Indeed, some literature articles developed an LCA analysis on PET supplemented by a numerical analysis using the Finite Element Method
panels to evaluate their environmental and ecological impacts [40,41]. (FEM) to assess a panel with real dimensions under different boundary
In this context, in addition to the continuous search for new strate- conditions.
gies to recycle materials, prefabricated constructions are becoming more Concurrently, a Life Cycle Assessment (LCA) study was conducted to
and more popular due to new technologies that allow a lower impact on evaluate emissions throughout the panel’s production cycle. This anal-
the environment. Prefabricated construction can be used in different ysis considered the impact of each material and explored alternative
types of buildings and reduce construction time and, consequently, en- materials, contributing a holistic understanding of the environmental
ergy consumption and environmental pollution. Due to these implications associated with the panel’s life cycle. This comprehensive
2

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
approach distinguishes our work by offering a nuanced exploration of 2.1.1. Small-scale samples
the multifaceted aspects of prefabricated panels, emphasizing innova- Two types of small-scale samples were prepared for investigating the
tion in design, material selection, and environmental considerations. thermal and acoustic performance of the single layers constituting the
precast composite. Samples were made of PET, EF_PET and I_EPS and 3
2. Materials and methods samples per type were produced. Thermal analyses were conducted on
5-cm thick sheets with a square area of 20 cm x 20 cm (Fig. 1, left panel).
This study focuses on the production of an innovative prefabricated As for the acoustic tests, cylindrical samples with a diameter of 10 cm
panel for building applications. A multiscale investigation procedure were produced and tested (Fig. 1, right panel).
was carried out to evaluate the most important thermal and acoustic
properties of the panel: individual components were analyzed at the 2.1.2. Multilayered precast panels
small-scale while the multilayer prefabricated panel was tested at the Three multilayered precast panels were produced and tested at the
large-scale under real-world conditions. Additionally, advanced nu- large scale. Each panel features two concrete slabs. The outer slab is 5
merical analyses were used to better evaluate the in-filed thermal per- cm thick while the inner one is 6 cm thick. Between them, a 19 cm thick
formance of the panel and quantify the associated environmental layer of the three insulation materials described in section 2.1 was
impact. interposed. Fig. 2.a shows the panel with PET insulation (MP-PET),
Fig. 2.b shows the panel with I_EPS insulation (MP-EPS) and Fig. 2.c
shows the panel with EF_PET insulation (MP-EFEPS). All panels have a
total thickness of 30 cm and a surface area of about 1.90 m2.
2.1. Materials and samples
Each panel was mounted on the outer wall of a test room building
located at University of Perugia (Fig. 3.a,b) in place of the security door
The proposed new precast panels consist of an insulating material
on the North side. The test room has a square floor plan with a side of
sandwiched between two concrete slabs. Three different prototypes are
approximately 3 m (Fig. 3.c) and has an access door on the North side
produced by changing the interposed insulating material and later
and a rectangular double-hung window on the South side.
tested:
1. I_EPS: Expanded Sintered Polystyrene with graphite additive; 3. Investigation methodology
2. PET: Polyester fiber insulation from recycled plastic bottles made of
polyester fiber (85 % recycled from pet); This paper develops a multiphysics, multiscale, and multiobjective
3. EF_PET: Insulation characterized by the same properties as the pre- investigation procedure. In particular, the proposed panel for building
vious one with evolved fibers and different density. applications is analyzed both from an acoustic and thermal point of
view. These analyses were performed both on small-scale samples
Specifically, I_EPS is a product that improves the performance of (small-scale investigation) and on the prototype panel with larger di-
regular EPS and has a density of almost 17 kgm (cid:0) 3. Indeed, graphite mensions making use of a test room building for in-field testing (large-
particles play a crucial role in mitigating the impact of heat radiation by scale investigation). Additionally, a numerical thermal analysis was also
actively impeding its transmission. Through the dual mechanisms of conducted to evaluate the performance of the precast panels considering
absorption and reflection of infrared radiation, these particles effec- different boundary conditions and the environmental impact of the
tively enable the containment and reduction of heat-related effects, panels was assessed in a life cycle perspective according to the LCA
enhancing radiative trapping within the pores. Moreover, since it is a methodology, presented in Section 5.
material of natural origin, helps make the final product recyclable and
environmentally friendly. On the other hand, PET has a density of about 3.1. Methods for acoustic characterization
40 kgm (cid:0) 3 and EF_PET about 25 kgm (cid:0) 3. EF_PET is composed of a specific
selection of advanced fibers to improve insulation properties. Literature In the construction sector, the choice of specific materials is impor-
studies have shown that to obtain PET with better performance, pre- tant for optimal sound insulation of a structure/building. To achieve a
crystallized chips are heated to remove traces of volatiles [52]. Both high level of acoustic intelligibility, it is important to protect the
have the advantage that they can be entirely reused if not nicked or building from external noise (such as road and rail traffic or even just the
damaged by external substances. chattering of people) with proper acoustic design, which consequently
Fig. 1. (a) PET, (b) EF_PET, (c) I_EPS: Small-scale thermal test samples (left), small-scale acoustic test sample (right).
3

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
Fig. 2. MP-PET (a), MP-EPS (b), MP-EFPET (c) panels.
Fig. 3. a) Test room, b) removal stage of one of the panels, and c) facades and plan of the testroom (pictures from [53]).
4

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
leads to a positive influence on the daily life of the occupants. Table 1
Environmental parameters.
3.1.1. Small-scale investigation Material Temperature (◦C) Relative Humidity (%) Pressure (hPa)
The small-scale characterization of the insulation materials is aimed
I_EPS 27.0 59 980
at evaluating the acoustic insulation capability, primarily measured
EF_PET 27.4 54 982
through achieved transmission loss (TL). This parameter was evaluated PET 27.5 54 982
using the “two-load” transfer function method (utilizing 4 microphones)
in accordance with the ASTM E2611-17 [54] and ISO 10534-2 [55]
standard, by using a Brüel & Kjӕr impedance tube model 4206. measuring the airborne sound insulation of facade elements in situ and it
also complies with ISO 354:2003 [57], UNI EN ISO 3382-2:2008 [58],
The impedance tube, illustrated in Fig. 4.a, consists of a loudspeaker
and UNI EN ISO 717-1:2021 [59]. By means of the in situ measurement
that emits the sound wave and a sample holder where the material under
of facade airborne sound insulation, it is possible to determine the
examination is positioned. The loudspeaker produces plane sound waves
evaluation index of normalized facade sound insulation with respect to
that collide with the sample and are partially reflected or absorbed by
the material, and partially penetrate through the material, ultimately
reverberation time by calculating D2m,nT which is the standardized level
difference with respect to a reference value of reverberation time in the
reaching the receiving tube. Microphones, calibrated and placed both
receiving room calculated by the following Equation (1):
upstream and downstream of the sample, record the sound pressure
levels. The upstream microphones capture the sound field’s pressure D 2m,nT =L 1,2m (cid:0) L 2 +10log(T/T 0 ) [dB] (1)
level impacting the sample, whereas the downstream microphones
gauge the pressure level on the opposite side of the sample. As part of the With:
procedure, a background noise calibration measurement is conducted.
This process involves utilizing an anechoic environment coupled with a • L1,2m =average sound pressure level in the outdoor environment at
rigid termination of the tube. Subsequently, after the insertion of the 2 m from the facade;
material sample, signal measurements are carried out under similar • L2 =average indoor sound pressure level;
conditions, using both the anechoic and empty end of the tube, mir- • T =reverberation time in the receiving environment;
roring the prior setup. The process culminates in the calculation of the • T0 = reference value of the reverberation time in the receiving
transfer function, enabling the quantification of the material’s trans- environment, T0 =0.5 s.
mission loss. The testing employed a large tube configuration with 10
cm diameter samples, covering frequencies from 100 to 1700 Hz. The following instruments were used to perform the tests (Fig. 5.a-e):
Concurrently, the testing environment’s temperature (◦C), relative hu-
midity (%), and atmospheric pressure (hPa) were monitored. Trans- • Acquisition system consisting of the Sinus Soundbook with the
mission loss assessments were carried out on samples of 5 cm, 10 cm, Samurai software to manage the various measurement phases;
and 15 cm thickness. The profiles presented in Section 4.1 are averages • Two microphones consisting of a Random Incidence microphone
derived from three separate tests on each sample under consistent capsule from GRAS and a preamplifier from 01 dB-Stell with a fre-
conditions. This method was adopted to minimize potential errors quency scale of 1–20 Hz;
stemming from individual measurements. • Electroacoustic calibrator capable of generating a 1000 Hz signal
Table 1 shows the environmental conditions in which tests were with a sound pressure level of 94 Hz;
performed for the 5-cm thickness. The environmental parameters during • LookLine omnidirectional sound source consisting of 12 speakers
the tests for the other thicknesses did not deviate much from those listed. used for reverberation time measurements;
• Directional sound source for facade sound insulation measurements
3.1.2. Large-scale investigation consisting of an 8″ high-efficiency loudspeaker.
The large-scale acoustic characterization was carried out following
the ISO 16283-3:2016 [56]. This standard prescribes the method for To better quantify the sound insulation performance of the precast
Fig. 4. a) Impedance tube, b) samples tested from left: PET, EF_PET, and I_EPS.
5

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
Fig. 5. a) Microphone capsule and preamplifier, b) omnidirectional sound source, c) sinus soundbook, d) electroacoustic calibrator, e) directional sound source, f)
absorption test setup, and g) facade sound insulation test setup.
panel, the standardized level difference of the same test room was 3.2.1. Small-scale investigation
analyzed before and after its installation in similar local boundary The small-scale thermal measurements were carried out using a Hot
conditions. Disk 2500 S equipment and the Transient Plane Source (TPS) method
First, the temperature and relative humidity inside the test room and following the ISO 22007-2 standard [60]. The Hot Disk 2500 S (Fig. 6.a)
in the outdoor environment were assessed with two Trimtec Sistemi performs a non-destructive thermal testing and characterizes each
model Fisher 35004 thermo-hygrometers. Secondly, the reverberation sample in terms of thermal conductivity, thermal diffusivity, and volu-
time inside the room was measured by using a dodecahedral source and metric specific heat. To perform the test, a double spiral sensor/heat
a calibrated microphone. During the test, the source emits a pink sound, source is placed between two pieces of the same material characterized
and the microphone detects its decay once the source is switched off. by a smooth surface to allow adequate thermal contact. When the test is
The test was carried out by varying the position and height of both the started, the sensor generates heat that radiates into the material, causing
sound source and the microphone. the system temperature to rise. By analyzing this change in temperature
After conducting this test, the assessment of the sound insulation of as a function of time, the main thermal properties of the material are
the facades was carried out. In order to do so, it was necessary to remove calculated. Before the testing process, the samples were placed in the
the dodecahedral source from inside the test room, leaving only the laboratory near the instrument for one day to allow them to reach out
microphone. A directional sound source positioned outside the test stationary ambient condition. This ensured that the samples remained
chamber and facing the specific facade with the angle of sound incidence stable without experiencing any temperature fluctuations during the
equal to 45◦ ±5◦ was utilized. During the test, the microphone inside test. Three measurements were carried out for each sample with the bulk
the test chamber changed its position and height with each stress applied Isotropic module by moving the sensor to three different positions. The
to the source, while another microphone was placed outside at a fixed obtained results were later averaged, and the standard deviation was
position and height. Upon completion of the test, sophisticated software calculated. Each test was conducted using a Kapton Hot Disk 8563 probe
and a dedicated Excel sheet were employed to calculate the standardized with a radius of 9.868 mm. Fig. 6.b-d shows the samples tested.
level difference. The same procedure was then followed once the panel
was placed in place of the entrance door on 20th July 2022 to evaluate 3.2.2. Large-scale investigation
any differences obtained in the two test configurations (Fig. 5.f,g). Large-scale characterization allows to evaluate the performance of
Table 2 shows the temperature and relative humidity conditions of the the multilayered precast panel when exposed to a real environment to
environments in which the tests were carried out. reproduce the actual performance in a real application. In this study, the
large-scale thermal characterization was conducted through a thermo-
fluximetric campaign on each panel’s stratigraphy, as described in
3.2. Experimental methods for thermal characterization
Section 2.1.2, following ISO 9869-1 [61] guidelines. The Thermozig
BLE, which features two measuring nodes allowing simultaneous mea-
In this work small and large-scale thermal analyses are used to
surements, was used to perform the thermo-fluximetric analysis. To
evaluate the performance of the proposed multilayered precast panel.
achieve this, temperature and fluxmeter sensors were employed. To be
Small-scale analyses allowed to evaluate the performance of the
precise in our measurements, we placed four surface temperature sen-
different insulating layers while the large-scale investigations aimed at
sors on the panel: two on the inner side and two on the outer side,
evaluating the overall behavior of the panel.
allowing us to calculate the average and obtain more accurate results.
Additionally, to avoid any interference from external climatic effects,
Table 2
the heat flow sensor was strategically installed on the inner side of the
Environmental conditions during acoustic test.
panel. By continuously monitoring the data collected over a significant
INDOOR ENVIRONMENT OUTDOOR ENVIRONMENT period, we calculate the thermal transmittance (U) using Eq. (2):
Temperature Relative Temperature Relative ∑n ∑n (cid:0) )
(◦C) Humidity (◦C) Humidity U= q j / Ti j (cid:0) Te j (2)
(%) (%) j=1 j=1
Standard 19 54 26 33
test room where j represents the number of measurements, q denotes the heat flux,
Test room 27 26 33 14 Ti is the internal temperature, and Te is the external temperature. This
with panel
analysis required maintaining a temperature difference between the
6

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
Fig. 6. a) Hot Disk 2500 s, b) PET, c) EF_PET, and d) I_EPS.
interior and exterior of the test room within the range of 1 to 20 ◦C. To 3.2.3. Numerical investigation
achieve this, we conditioned the environment inside the test room to a A comprehensive numerical simulation was employed to analyze the
◦
fixed temperature of 18 C, which represents the lowest possible tem- behavior of panels in a validated numerical environment, incorporating
perature setting in the cooling system. Meanwhile, outside the test room, experimental data. This simulation allowed us to replicate and study the
temperature fluctuations were allowed to occur naturally due to the panels under various boundary conditions, significantly reducing the
alternation between day and night. Throughout the entire testing pro- duration and complexity of certain experimental tests. Three prototype
cess, the internal temperature of 18 ◦C was consistently maintained to panels, as discussed in previous sections, were carefully modeled, and
ensure reliable and consistent results. To commence the measurements, validated. The main objective of this modeling and validation was to
two nodes were employed to measure the relevant parameters on both assess the thermal transmittance of real panels used in construction. To
the inner and outer sides of the panel. All sensors were carefully posi- achieve this, the Finite Element Method (FEM) was utilized to accurately
tioned in a central area of the panel, meticulously adhered to ensure simulate the behavior of the panels as observed in the physical test
precise data collection. The tests started on June 7, 2022, utilizing room. The aim was to precisely determine the thermal properties of the
panels with dimensions of 91 cm x 209 cm and a thickness of 30 cm. actual panels within the virtual environment. The modeling process
Fig. 7 illustrates one of the three panels used in this study, showcasing began by replicating the geometry and characteristics of the panels,
the arrangement of sensors for the thermo-fluximetric analysis. considering the dimensions described in section 2.1.2 (209 cm x 91 cm).
To expedite the simulations, only half of the panel was modeled,
employing a symmetry plane. Additionally, each modeled element was
Fig. 7. External (a) and internal (b) view of one of the three panels tested with the sensors highlighted in the box.
7

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
assigned specific materials with their corresponding properties, as out- mass-related expectations. This unconventional behavior can potentially
lined in Table 3. The initial step involved validating the numerical be attributed to the unique structural composition of I_EPS. Being the
model to ensure its accuracy, aiming to obtain comparable results with lightest and most rigid material among the trio, I_EPS diverges from the
the experimental data collected during the monitoring in the test room. conventional characteristics of massive materials. Consequently, even
The finite element calculation was carefully configured to consider with heightened sample thickness, the overall transmission loss does not
two main aspects: heat transfer by conduction through the modeled increase as anticipated. Nevertheless, it’s important to note that I_EPS
solid materials and heat exchange by convection and radiation on the outperforms the other materials in terms of transmission loss, show-
panel walls in direct contact with the internal and external air volume. casing values nearing 40 dB around 400 Hz for the thickest sample.
For the boundary conditions, we took into account the specific days and Looking more specifically at the other two insulators, the sound
times of the large-scale thermal monitoring of the three panels, as insulation of EF_PET is lower than PET. Also in this case, this could be
explained in Section 4.4. The parameters considered for each panel are due to their different density: PET has a density of about 40 kgm (cid:0) 3 while
the internal air temperature in the test room and the external outdoor EF_PET has a density of about 25 kgm (cid:0) 3. Indeed, analyzing the structure
temperature, as well as the internal and external average adduction of the material, EF_PET is composed of less dense fibers than the other
coefficients equal to 10 Wm (cid:0) 2K (cid:0) 1 and 45 Wm (cid:0) 2K (cid:0) 1 respectively. Using one, resulting in a softer material. Curiously, while I_EPS demonstrates a
these parameters, a first transient study was conducted based on the progressive enhancement in transmission loss performance as thickness
experimental thermal profiles mentioned earlier, after a stationary spin- escalates, especially within lower frequency ranges, EF_PET and PET
up. This allowed us to map the thermal distribution across the entire display their strengths in higher frequencies. Furthermore, as frequency
volume of the panels and determine the heat flux passing through them. increases, both EF_PET and PET demonstrate an amplified performance,
To validate the accuracy of the model, we compared the internal and leading to prominent peaks in their transmission loss profiles. Notably,
external surface temperature profiles, along with the conductive heat EF_PET attains peaks of nearly 9 dB, whereas PET reaches around 11 dB.
flow, with the experimentally obtained data. By leveraging the simula- This phenomenon accentuates the materials’ ability to effectively miti-
tion results, we calculated the thermal transmittance of each panel using gate sound transmission, especially at specific frequencies.
Eq. (2). This comparison between experimentally derived transmittance
values and those from the virtual model confirmed the validity of the 4.2. Large-scale acoustic analysis results
panel models tested in the experimental setup.
Afterwards, a second study was conducted to evaluate the thermal Moving on to our investigation of acoustic characteristics on a larger
transmittance of the three panels based on their actual dimensions, scale, the acoustic tests were conducted on both the standard test room
thereby enabling an assessment of their in-field thermal attributes. The configuration and the configuration with the added panel. In the stan-
simulation methodology paralleled the aforementioned description, yet dard test room conditions, the facade sound insulation evaluation index
encompassed panels measuring 815 cm ×249 cm with a 30 cm thick- D2m,nT was determined equal to 41.7 ((cid:0) 2;(cid:0) 5) dB with C100-5000 =(cid:0) 1 dB
ness. Noteworthy features comprised a 5 cm insulation layer spanning and Ctr100-5000 =(cid:0) 4 dB. Conversely, the introduction of the panel led to
the entire height (except for the final 35 cm), supplemented by alter- a notable increase in this value, reaching 45.2((cid:0) 1;(cid:0) 3) dB with C100-5000
nating 14 cm insulation and 15 cm concrete layers. Refer to Fig. 8 for a =0 dB and Ctr100-5000 =(cid:0) 3 dB. This data is visually presented in Fig. 10,
visual representation of these panel configuration. This additional sta- offering a graphical representation of both test room setups. The
tionary analysis was conducted to simulate a more substantial temper- graphical depiction provides clear insight into the effectiveness of the
ature difference between the indoor and outdoor environments than panel in significantly enhancing sound insulation when compared to the
what was experienced in the large-scale tests. Specifically, we estab- standard test room setup. This enhancement is particularly evident
lished a temperature difference of 20 ◦C between the inside and outside across the entire frequency spectrum, prominently in the lower fre-
conditions. Finally, the thermal transmittance was determined to assess quencies. Noteworthy is the observation that between the frequency
the panel’s overall thermal performance. range of 315 Hz and 1250 Hz, there is a discernible rise in sound insu-
lation efficacy within the standard test room configuration, maintaining
4. Results and discussion from the experimental investigations a consistent level of around 40 dB.
At higher frequencies, the installation of the panel contributes to a
This section presents and comments on the results obtained from the substantial augmentation in sound insulation performance. This
analyses discussed in the above. enhancement culminates in a distinct peak, registering an approximate
value of 60 dB at 4000 Hz. The convergence of these findings un-
derscores the considerable advancement in sound insulation achieved
4.1. Small-scale acoustic analysis results through the integration of the panel.
Fig. 9 displays the transmission loss value profiles for the I_EPS,
4.3. Small-scale thermal analysis results
EF_PET, and PET samples. In the results obtained for I_EPS insulation, a
less regular trend can be seen than those obtained for the other two types
Table 4 shows the results obtained from measurements performed on
of insulation. Notably, across the three thickness variations, a pro-
each type of small-scale sample using Hot Disk 2500 S. For each test, the
nounced enhancement is evident within the initial frequency range up to values of thermal conductivity (Wm (cid:0) 1K (cid:0) 1), thermal diffusivity
approximately 600 Hz. However, an intriguing departure from mass- (mm2s (cid:0) 1), and volumetric specific heat (MJm (cid:0) 3K (cid:0) 1) of the three tests
related behavior is observed between 600 and 1000 Hz. Here, despite
performed are shown, along with the corresponding average and stan-
escalating thickness, the transmission loss does not uniformly follow
dard deviation.
These assessments were conducted within a laboratory environment
Table 3 at approximately 28 ◦C. Upon comparing the thermal conductivity
Values obtained from experimental tests carried out on small samples. values derived from the three insulation types, the optimal performer in
Thermal conductivity Heat capacity Density stationary conditions emerges as I_EPS, boasting the lowest thermal
(Wm(cid:0)1K¡1) (J kg(cid:0)1K¡1) (kgm¡3) conductivity value of 0.026 Wm (cid:0) 1K (cid:0) 1. It is followed by EF_PET and PET
Concrete 1.72 800 2442.5 with values of 0.0395 Wm (cid:0) 1K (cid:0) 1 and 0.043 Wm (cid:0) 1K (cid:0) 1 respectively.
PET 0.043 894 39.15 Turning attention to thermal diffusivity, describing a material’s pro-
EF_PET 0.0395 936.9 24.55 pensity for heat propagation, I_EPS possesses superior resistance to
I_EPS 0.026 1916.2 16.7
thermal wave propagation compared to the other materials, showcasing
8

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
Fig. 8. Geometry panel with real dimensions.
Fig. 9. Transmission loss results.
9

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
Fig. 10. Sound insulation in large-scale acoustic tests.
the lowest thermal diffusivity value of 0.81 mm2s (cid:0) 1. In contrast, EF_PET temperature exceeded the internal temperature of the test room.
has the lowest volumetric specific heat value while PET and I_EPS have Consequently, heat flowed from the warmer outdoor environment to the
similar values. cooler indoor space, resulting in a negative sign as detected by the flow
sensor.
4.4. Large-scale thermal analysis results Regarding the results for thermal transmittance values, all panels
demonstrate commendable insulation levels. Notably, MP-EPS presents
This section presents the outcomes of the thermal investigation the most promising performance, with a thermal transmittance value of
conducted using thermo-fluxmetric analysis. The analysis encompassed 0.19 Wm (cid:0) 2K (cid:0) 1, signifying the lowest value among the panels. Following
three panels: MP-PET, MP-EPS, and MP-EFPET. Each panel’s installation suit are MP-EFPET and MP-PET. Collectively, these findings point to
and monitoring timeline is as follows: MP-PET was placed in the test I_EPS as the superior material for minimizing heat transfer within a
room on June 6, 2022, with thermal monitoring spanning from June 7 to stratigraphy. Furthermore, the congruence of these results with those
June 14. Subsequently, on June 16, 2022, MP-EPS was introduced and derived from Hot Disk analysis lends credence to their consistency. This
monitored until June 20. The final panel, MP-EFPET, was installed on convergence underscores the reliability and robustness of the conclu-
June 21, 2022, and monitoring occurred from June 22 to June 29. The sions drawn from the thermal analysis, reinforcing the material’s effi-
findings for each panel are summarized in Table 5. cacy in reducing heat transfer.
Given that the tests were conducted during summer, the external
10

S. Cavagnoli et al.                                                                                                                                                                                                   E  n  e r  g y   &   B  u  i l d  i n g  s 312(2024)114218
Table 4  the lower part of the panel shown in Fig. 11c), due to the presence of the
Hot Disk results.    insulation there is a reduction in heat transfer compared to the upper
part. In the image for MP-EPS, the red arrows indicating heat flow are
| Measurement  | Thermal  | Thermal  | Volumetric  |     |     |     |
| ------------ | -------- | -------- | ----------- | --- | --- | --- |
conductivity  diffusivity  Specific Heat  much smaller than the other two. This is consistent with all the analyses
|     | (Wm(cid:0)1K¡1)  | (mm2s¡1)  | (MJm(cid:0)3K¡1)  |     |     |     |
| --- | ---------------- | --------- | ----------------- | --- | --- | --- |
described in the previous sections, in which I_EPS insulation was always
| PET  1   | 0.0432   | 1.2788   | 0.0338  | found to be the best.  |     |     |
| -------- | -------- | -------- | ------- | ---------------------- | --- | --- |
2   0.0431   1.1914   0.0361  In conclusion, the monitoring of the prototype panels aimed at
3   0.0427   1.2460   0.0343  obtaining thermal transmittance was carried out correctly. The data
| Average   | 0.0430   | 1.24   | 0.035  |     |     |     |
| --------- | -------- | ------ | ------ | --- | --- | --- |
obtained from the numerical model for real-size panels are the most
| St. Dev.   | 0.0002   | 0.04   | 0.001   |     |     |     |
| ---------- | -------- | ------ | ------- | --- | --- | --- |
representative as they were simulated with a temperature difference
between inside and outside of 20 ◦C. The difference obtained between
| EF_PET  1   | 0.0395   | 1.7139   | 0.0230  |     |     |     |
| ----------- | -------- | -------- | ------- | --- | --- | --- |
the transmittances is therefore mainly due to a different geometric
| 2   | 0.0393   | 1.7917   | 0.0219  |     |     |     |
| --- | -------- | -------- | ------- | --- | --- | --- |
configuration of the panels both in terms of size and cross section and
| 3   | 0.0396   | 1.5858   | 0.0250  |     |     |     |
| --- | -------- | -------- | ------- | --- | --- | --- |
from different boundary conditions.
| Average    | 0.0395   | 1.7   | 0.023   |     |     |     |
| ---------- | -------- | ----- | ------- | --- | --- | --- |
| St. Dev.   | 0.0002   | 0.1   | 0.002   |     |     |     |
5. Life cycle assessment
| I_EPS  1   | 0.0260   | 0.7772   | 0.0335  |     |     |     |
| ---------- | -------- | -------- | ------- | --- | --- | --- |
| 2          | 0.0263   | 0.8114   | 0.0324  |     |     |     |
When it comes to developing projects, it’s crucial to consider the
| 3   | 0.0258   | 0.8421   | 0.0306  |     |     |     |
| --- | -------- | -------- | ------- | --- | --- | --- |
environmental implications of the chosen solution. This study is rooted
| Average   | 0.0260   | 0.81   | 0.032  |     |     |     |
| --------- | -------- | ------ | ------ | --- | --- | --- |
in actual production data from an Italian mid-sized panel manufacturer.
| St. Dev.   | 0.0002   | 0.03   | 0.001   |     |     |     |
| ---------- | -------- | ------ | ------- | --- | --- | --- |
The company operates from two different sites: one in Bastia Umbra
(PG) and the other in Aprilia (LT), both for the year 2020. The calcu-
4.5. Numerical investigation results  lations were performed using SimaPro 9.3.0.2 and the ecoinvent v.3.8
database. The life cycle assessment (LCA) was carried out in compliance
This section shows the results obtained from the validation of the
with recognized standards, including UNI EN ISO 14021: 2016 [62], EN
prototype panel and the transmittance values obtained for the panels in
ISO 14020:2001 [63], UNI EN ISO 14040:2006 [64], UNI EN ISO
real size. In particular, the first two columns of Table 6 shows the  14044:2021 [65], UNI EN 15804:2012+A2:2019 [66]. These standards
thermal transmittance values obtained in the experimental phase, i.e., in
collectively provide a comprehensive framework for evaluating the
a real environment (RE), and those obtained from the validated model, i.
ecological ramifications of the solution, ensuring a holistic and rigorous
e., virtual environment (VE). By comparing the trends of heat flow and
assessment.
internal and external temperature of each panel of the RE and the VE, it
is possible to confirm the validation of the model given the same profile
5.1. Goal and scope definition
trends. Based on this validation, the thermal transmittance of the actual
panels was evaluated. The last two columns in Table 6 show the thermal
This section reports the environmental impact analysis through Life
transmittance values evaluated with a transient study (TS) and with the
Cycle Assessment (LCA) methodology. The primary goal was to scruti-
additional stationary study (SS) simulated with a temperature difference
◦ nize the panel’s emissions across its complete life cycle, spanning from
of 20 C. Again, the panel MP-EPS is found to be the best performing one,
raw material sourcing for production to its ultimate disposal.
followed by MP-EFPET and MP-PET. Also in this case, these results are
For LCA analysis, the processes considered as boundaries were
consistent with those obtained from small- and large-scale analyses.
selected according to the Product Category Rules (PCR) for construction
Fig. 11a) shows a graphic comparison of the results obtained for the
materials. The cradle-to-gate approach with modules from C1 to C4 +D
three panels in the upper part consisting of the first 35 cm without
includes production (A1 – raw materials, A2 – transports, A3 – manu-
insulation. Indeed, the heat flow (red arrows) tends to pass over the top
facture), end of life phase (C1 – demolition, C2 – transports, C3 – waste
of the panel, while at the bottom the arrows are more muted, indicating  treatment, C4 – disposal), and recovery phase (D – potential for reuse,
a lower heat flow passage. Even in the central part of the panel shown in
recovery, and recycling). Production and disassembly processes were
Fig. 11b), the influence of the insulation can be evaluated. Indeed,
considered under the manufacturer’s direct influence and the use phase
despite the presence of concrete that interrupts part of the insulation
does not require water or energy.
layer of 14 cm thick, it allows minimal heat loss. On the other hand, in
The impact categories evaluated according to the PCR are as follows:
Table 5
Thermo-flowmetric analysis results.
Average difference temperature  Average thermal flux  Thermal transmittance  dU
|         | 6.8 ◦C          |     |         | 3.32 Wm(cid:0)2  | 0.49 Wm(cid:0)2K(cid:0)1   |         |
| ------- | --------------- | --- | ------- | ---------------- | -------------------------- | ------- |
| MP-PET  | (cid:0)         |     | (cid:0) |                  |                            | 1.99 %  |
|         | (cid:0) 7.6 ◦C  |     | (cid:0) | 1.46 Wm(cid:0)2  | 0.19 Wm(cid:0)2K(cid:0)1   |         |
MP-EPS  1.41 %
MP-EFPET  (cid:0) 10.7 ◦C  (cid:0) 3.86 Wm(cid:0)2  0.36 Wm(cid:0)2K(cid:0)1   0.12 %
Table 6
Thermal transmittance values in RE, VE, TS, and SS.
|     | PANEL INSERTED IN TEST ROOM  |     |     |     | PANEL WITH REAL DIMENSIONS  |     |
| --- | ---------------------------- | --- | --- | --- | --------------------------- | --- |
Thermal transmittance  Thermal transmittance  Thermal transmittance  Thermal transmittance
(Wm(cid:0)2K¡1) – RE  (Wm(cid:0)2K¡1) – VE  (Wm(cid:0)2K¡1) – TS  (Wm(cid:0)2K¡1) – SS
with ΔT ¼20 ◦C
| MP-PET     | 0.49   |     | 0.43   |     | 0.87   | 0.57   |
| ---------- | ------ | --- | ------ | --- | ------ | ------ |
| MP-EFPET   | 0.36   |     | 0.40   |     | 0.67   | 0.55   |
| MP-EPS     | 0.19   |     | 0.18   |     | 0.41   | 0.45   |
11

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
Fig. 11. Heat flow trend.
climate change (GWP – total), ozone depletion (ODP), photochemical
ozone formation (POCP), acidification (AP), eutrophication – freshwater Table 7
(EP – freshwater), eutrophication – marine (EP – marine), eutrophica- Main panel components percentage.
tion – terrestrial (EP – terrestrial), water use (WDP), resource use – TH20 – B TH30 – B TH20 – A TH30 – A
fossils (ADP fossil), resource use – minerals and metals (ADP minerals & Steel 2.91 % 3.45 % 3.64 % 4.82 %
metals), climate change – fossil (GWP – fossil), climate change – Dismantling oil 0.04 % 0.03 % 0.04 % 0.03 %
biogenic (GWP – biogenic), climate change – land use, and LU change Cement 91.56 % 90.26 % 94.93 % 93.40 %
(GWP – luluc). Filler 4.51 % 4.37 % – –
Fluidifier 0.22 % 0.21 % 0.14 % 0.14 %
PET 0.76 % 1.68 % 0.99 % 1.36 %
5.1.1. Study object description Accelerator – – 0.26 % 0.26 %
Two types of pre-stressed reinforced concrete panels filled with Total 100 % 100 % 100 % 100 %
recycled polyester fibers were investigated. At least 85 % of the insu-
lation comes from recycled plastic bottles (PET), which implies that the
5.1.2. Declared unit and allocation criteria
impacts for the raw materials were not considered according to the
The declared unit corresponds to the material and energy flows
polluters pay criteria. This analysis studies the panel in 20 cm (TH20) required to produce 1 m2 of each type of panel TH20-B, TH20-A, TH30-
and 30 cm (TH30) thickness realized in the Bastia Umbra (B) and Aprilia
B, and TH30-A and the processes selected correspond to Cut-off, Unit
(A) sites. Specifically, Table 7 highlights the main components in per-
model.
centages of these panels. The allocation of inputs and outputs were based on the m3 and m2
12

S. Cavagnoli et al.                                                                                                                                                                                                   E  n  e r  g y   &   B  u  i l d  i n g  s 312(2024)114218
| produced in the two sites for each model analyzed, according to the  |     |     | Table 8  |     |     |     |     |
| -------------------------------------------------------------------- | --- | --- | -------- | --- | --- | --- | --- |
formula:  Total emissions results for the four panels analyzed.
|             | [(       | )] [(cid:0) )]  |              |            |         |                 |         |
| ----------- | -------- | --------------- | ------------ | ---------- | ------- | --------------- | ------- |
|             |          |                 |              | Unit       | TH20 –  | TH30 –  TH20 –  | TH30 –  |
| Allocation= | Data ×m3 | /m3 × 1/m3      |              |            |         |                 |         |
|             | product  | pannTHx tot tot |              |            | B       | B  A            | A       |
|             |          |                 | GWP – total  | kg CO2 eq  | 7.62E + | 9.44E + 7.93E + | 1.09E + |
|             |          |                 |              |            | 01      | 01  01          | 02      |
5.2. Life cycle inventory
|     |     |     | ODP  | kg CFC11  | 1.11E-  | 2.07E-  1.25E-  | 2.05E-  |
| --- | --- | --- | ---- | --------- | ------- | --------------- | ------- |
|     |     |     |      | eq        | 05      | 05  05          | 05      |
The production phase includes modules A1, A2 and A3. Module A1  POCP  kg NMVOC  2.61E-  3.38E-  2.68E-  3.86E-
refers to the supply of raw materials needed to produce the panel, i.e.,  eq  01  01  01  01
mol H +eq
steel, electrowelded mesh, dismantling oil, cement, gravel, sand, water,  AP  3.08E-  3.76E-  2.99E-  4.24E-
|     |     |     |     |     | 01  | 01  01  | 01  |
| --- | --- | --- | --- | --- | --- | ------- | --- |
filler, fluidifier, PET, and accelerator. In detail, steel was considered
|     |     |     | EP – freshwater  | kg P eq  | 1.50E-  | 1.92E-  1.55E-  | 2.32E-  |
| --- | --- | --- | ---------------- | -------- | ------- | --------------- | ------- |
with 100 %, 98 %, 97 % and ND (0 %) recycled amount. Specifically, the  03  03  03  03
EP – marine
inputs are the same between the two sites, except for filler and accel- kg N eq  7.83E-  9.51E-  8.04E-  1.12E-
|     |     |     |     |     | 02  | 02  02  | 01  |
| --- | --- | --- | --- | --- | --- | ------- | --- |
erant, used at B and A respectively. Technical data was sourced from the
|     |     |     | EP – terrestrial  | mol N eq  | 8.64E-  | 1.05E + 8.92E-  | 1.25E + |
| --- | --- | --- | ----------------- | --------- | ------- | --------------- | ------- |
material data sheets: fluidifier has a density of 1.06 g/ml, the accelerant
|     |     |     |     |     | 01  | 00  01  | 00  |
| --- | --- | --- | --- | --- | --- | ------- | --- |
of 1.1 g/ml and the disarming oil of 0.86 g/cc. The total raw materials  WDP  m3 depriv.  1.99E + 2.43E + 1.77E + 2.66E +
processed to produce 1 m2 of panel in B for the 20 cm thick panel is  01  01  01  01
|     |     |     |     |     | 6.52E + | 8.40E + 6.59E + | 9.64E + |
| --- | --- | --- | --- | --- | ------- | --------------- | ------- |
344.5 kg and 381.9 kg for the 30 cm thick panel. In A, the total quantity  ADP fossil  MJ
is 315.9 kg for the 20 cm thick panel and 420.5 kg for the 30 cm thick  02  02  02  02
|     |     |     | ADP minerals &  | kg Sb eq  | 3.15E-  | 5.67E-  4.48E-  | 7.18E-  |
| --- | --- | --- | --------------- | --------- | ------- | --------------- | ------- |
panel.
|     |     |     | metals  |     | 04  | 04  04  | 04  |
| --- | --- | --- | ------- | --- | --- | ------- | --- |
Module A2 includes transportation of the supply materials used for  GWP – fossil  7.41E + 9.16E + 7.71E + 1.06E +
kg CO2 eq
|     |     |     |     |     | 01  | 01  01  | 02  |
| --- | --- | --- | --- | --- | --- | ------- | --- |
the panels production. Using kgkm as the unit of measurement, dis-
|     |     |     | GWP – biogenic  | kg CO2 eq  | 1.47E + | 2.35E + 1.57E + | 2.47E + |
| --- | --- | --- | --------------- | ---------- | ------- | --------------- | ------- |
tances between the supplying companies were then multiplied by the
purchased quantity of each material required to produce 1 m2 of panel.  0 0   0 0   0 0   0 0
GWP – luluc
|     |     |     |     | kg CO2 eq  | 5 .2 1E-  | 4 .7 0E-  5 .1 5E-  | 5 .5 0E-  |
| --- | --- | --- | --- | ---------- | --------- | ------------------- | --------- |
The transport considered for the routes is an articulated lorry.  01  01  01  01
In module A3 are included the energy consumption with local market
energy mix selected (medium voltage) and fuel for in-site transportation,
while the 30-cm-thick panel made at A impacts 11 % more than the same
the atmospheric emissions (particulates), and the waste treatment to
produce panels.  one made at B. Indeed, for the 20 cm panel, the quantities of gravel,
The end-of-life phase corresponds to modules C1 to C4. In C1, the  sand, water, and fluidifier used for A are lower. On the other hand, for
panel demolition scenario is modelled considering 2.5 l of diesel (0.835  the 30 cm panel, the quantities of recycled steel, electrowelded mesh,
kg/l density [67]) consumption by a demolition machine per m3 of  disarming oil, cement, gravel, sand, and water are greater for the A site
than for the B site. This therefore justifies the resulting impacts of A1 for
panel. This estimation was obtained from a previous study conducted by
| the producer. The fuel needed per m3 was divided by the area of panels  |     |     | the panels.  |     |     |     |     |
| ----------------------------------------------------------------------- | --- | --- | ------------ | --- | --- | --- | --- |
Fig. 12.a shows the impacts of the various modules in terms of kg CO2
produced at each production site.
eq, which is the representative and most important category for
Module C2 considers the transportation to a hypothetical recipient
expressing the impact on global warming. To analyze the impacts of this
company to which materials from demolition of each site is to be sent. A
phase in more detail, each component in A1 was analyzed in terms of kg
distance of 20 km is assumed for both sites and the transportation mean
CO2 eq emitted for each kg of material considered to understand which
is a lorry [68].
Module C3 examines the treatment of waste obtained from demoli- material has the greatest impact (Fig. 12.b).
tion services. Waste is processed according to percentages indicated in  The analysis showed that, individually, the most harmful material is
the literature [68] for construction and demolition. Therefore, recycling  the dismantling oil, with 3.86 kg CO2 eq emitted for each kg of product.
reaches 100 % for concrete, 89.3 % for steel, and 36.4 % for plastic  Given the small quantity used in the production (Fig. 13.a), the emission
of this product corresponds to less than 1 % of the total emissions for
polyethylene terephthalate (PET).
each 1 m2 of panel. On the other hand, cement with an emission com-
Module C4 deals with the processing of materials demolished that
parable to 0.8 kg CO2 eq per kg and corresponding to 15–17 % of total
were not treated in the previous module according literature [69]:
panel weight, cement accounts for about 50–60 % of the final emissions
remaining waste materials is destined partly to landfill (51.1 %) and
per m2 of panel (Fig. 13.b).
partly to incineration (48.9 %).
On the other hand, the recovery phase considers module D, which
represents an assumed scenario of possible benefits of net flows in the
5.4. Sensitivity analysis
end-of-life phase. In this case, recycled items were used as substitutes for
raw materials for new products. Thus, impacts for production were
Considering the contribution of cement, sensitivity analysis was
considered as avoided.
performed proposing an alternative material changing the input from
|     |     |     | “Cement,  alternative  | constituents  |     | 6–20  %  {Europe  | without  |
| --- | --- | --- | ---------------------- | ------------- | --- | ----------------- | -------- |
5.3. Results and discussion  Switzerland}| production| Cut-off, U” to “Cement, limestone 6–20 %
{RoW}| cement production | Cut-off, U” from the ecoinvent v.3.8
database.
After entering the inputs explained in the previous section, presented
Results obtained from limestone cement, with emission of 0.74 kg
in detail in the Annex, impacts were characterized using the EN
15804+A2 method as stablished by the PCR. Table 8 shows the total
CO2 eq per kg, corresponds to approximately 6.8 % less in comparison to
impact given by the panels for each of the 13 impact categories listed in  the previous cement. Therefore, the substitution of this material could
lead to a reduction in emissions of about 4 % per m2 of panel.
Section 5.1.
Module A1 was accessed separately as it contributes to more than 80
% in GWP to the impact in all models. Furthermore, comparing the  6. Discussion and conclusions
production of the 20-cm-thick panel from site B and A, in terms of
climate change, the panel from A impacts 3 % less than the one from B,  The following work proposes a multi-objective, multi-scale and
13

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
Fig. 12. a) Indicators of climate change factors in production sites for each stage, b) Material emissions for kg of each product.
Fig. 13. a) Materials used to produce 1 m2 of panel, b) Emissions in kg CO2 eq for each material.
multi-approach analysis on innovative panels made of components The investigated panel comprises a concrete slab-insulation layer-
derived from recycled materials. Indeed, in this work selected materials concrete slab configuration, which allows the use of various types of
were chosen to produce a new efficient, sustainable, and functional materials available for the insulation layer, further improving its sus-
prefabricated panel. tainability. In this context, the use of wood-wool-cement composite
In particular, small-scale sound insulation tests were conducted on panels (WWCP) for precast walls can improve sustainability by offering
three types of insulation produced from waste materials: two derived environmental benefits and structural integrity [70]. Furthermore, the
from plastic fibers (PET and EF_PET) and one graphite-added EPS construction of prefabricated timber structures is also a sustainable
(I_EPS). From the results obtained, it was assessed that the two plastic- option, promoting environmental merits and market competitiveness
derived insulators perform less well than the I_EPS insulation, prob- [71], as well as modular construction systems with solid wood panels
ably due to the material structure. Sound insulation tests were also also further emphasise sustainability by emphasising renewable and
conducted on a large scale in test rooms by installing precast concrete recyclable resources [44].
panels with the interposition of the three types of insulation (MP-PET, In the pursuit of sustainability, selecting eco-friendly materials for
MP-EFPET, MP-EPS). Their performance was evaluated by comparing the insulation layer is also crucial. Innovative solutions, such as biomass-
the facade sound insulation rating index of the test room with and based composite materials derived from sawdust and geopolymers,
without the panel, obtaining promising results with an increase in sound provide effective insulation while minimizing environmental impact,
insulation that highlights their potential. contributing to greener construction practices [72]. The realm of pre-
Small-scale thermal tests showed that all insulation materials tested fabricated systems offers diverse approaches and technologies to
(I_EPS, PET and EF_PET) have good insulation properties, i.e., always enhance sustainability, ranging from material selection to composition
below 0.065 Wm (cid:0) 1K (cid:0) 1. These properties were also confirmed by the considerations, enabling optimization of environmental impact. It
large-scale thermal analyses involving the installation of the 3 precast should be noted that the performance of precast panels varies with
concrete panels in test room. Indeed, the thermal transmittance results design, emphasizing the importance of understanding their properties
were consistent with the values obtained from the small-scale thermal and selecting the most suitable option based on climatic conditions.
tests, confirming I_EPS as the best insulator, followed by EF_PET and Furthermore, during the manufacturing and installation of pre-
PET. Moreover, based on this thermal monitoring, a numerical analysis fabricated panels, various factors can impact their performance,
was carried out to assess the transmittance of the panel with real sections including construction and installation methods. Practical elements may
and dimensions, reporting results consistent with those obtained from influence performance, leading to issues like water absorption, rising
the other analyses. damp, or thermal bridging. Introducing moisture barriers into panels
In addition to material testing, the life cycle of panel production with can address these challenges by incorporating layers or treatments that
PET was analyzed in terms of environmental impact, following a act as robust barriers against water and moisture migration. Options
“cradle-to-gate” approach. The study found that concrete contributes include waterproof coatings or materials resistant to moisture infiltra-
the greatest impact, no doubt due to the significant total weight on the tion. Therefore, attention to design and installation processes is vital to
panel. However, replacing the type of concrete could lead to lower im- mitigate thermal bridging risks, possibly through specific construction
pacts, improving the performance of this new system. details, thermal breaks, or additional insulation at critical points.
14

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
Implementing regular monitoring and maintenance protocols is crucial, Writing – review & editing, Validation, Supervision, Methodology,
involving routine inspections for timely issue identification and neces- Investigation, Data curation, Conceptualization. Fabiana Frota de
sary repairs or component replacements. Exploring innovative materials Albuquerque Landi: Writing – review & editing, Formal analysis, Data
with enhanced properties, such as high-performance insulation or curation. Anna Laura Pisello: Writing – review & editing, Supervision,
advanced coatings, offers further avenues. For example, aerogels, known Resources, Project administration, Methodology, Investigation, Funding
for their lightweight and insulating properties, can significantly enhance acquisition, Conceptualization.
thermal efficiency and comfort in buildings. Incorporating aerogel
sheets into prefabricated panels can reduce heat transfer and mitigate
thermal bridging, while their moisture resistance is beneficial in chal- Declaration of competing interest
lenging environmental conditions. Moreover, prefabricated panels offer
significant cost advantages in building construction. Their efficient The authors declare that they have no known competing financial
production processes reduce labor and site management costs, while interests or personal relationships that could have appeared to influence
minimizing material waste enhances resource utilization and lowers the work reported in this paper.
production costs. Furthermore, their superior thermal and acoustic
properties contribute to long-term cost savings by reducing reliance on Data availability
heating and cooling systems.
In conclusion, the innovative proposal of this prefabricated panel Data will be made available on request.
seems to be technically and environmentally promising and, although
this study focused on the Mediterranean climate of Perugia, its meth- Acknowledgments
odology remains solid and applicable to different urban contexts with
the understanding that considering meteorological, spatial and S.C. and F.L.’s acknowledgements are due to the PhD school in En-
geomorphological factors is fundamental to ensure the methodology’s ergy and Sustainable Development, University of Perugia, Italy. All au-
relevance in different geographical contexts. For material selection, in- thors thank Manini Prefabbricati S.p.A. for supplying and installing the
sulators derived from plastic have good properties, but not at the level of materials and prefabricated panels and supporting the R&D project. This
I_EPS. Therefore, it could be considered to improve the production of work was partly funded by the Italian Ministry of Research through the
such insulators by achieving higher thermal and acoustic properties. THE-UNKNOWN (ProtP2022NM5L7) “equivalent THErmo-physical
Substituting cement type could contribute to further reducing the properties for UNKNOWN composition of building walls” project, and
environmental impact. This study could then be implemented by the LIGNOCAP (Prot2022M8EEFF) “Bio-based insulation panels in
selecting several promising recycled materials to be included in the building envelope and cooling systems for improving acoustic and
production cycle of prefabricated panels, as today’s goal is to reduce thermal comfort and mitigating urban heat islands” project, within the
environmental pollution and make efficient buildings. PRIN 2022 program, as well as the Fondazione Cassa di Risparmio di
Perugia through the project “LONG-LIFE - Innovative technoLOgies for
CRediT authorship contribution statement enhanciNG LIFE-cycle sustainability of reinforced concrete structures”
project (Project Code: 21071 (2022.0400). The authors also thank RSE
Silvia Cavagnoli: Writing – original draft, Visualization, Method- S.p.A. for supporting the dissemination of this and other initiatives by
ology, Investigation, Formal analysis, Data curation. Claudia Fabiani: EAPLAB.
Annex
PRODUCTS Input Unit
Accelerant 1 kg
Materials/fuels
Plasticiser, for concrete, based on sulfonated melamine formaldehyde {GLO}| plasticiser production, for concrete, based on sulfonated melamine 1 kg
formaldehyde | Cut-off, U
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 597 kgkm
Products
Recycled 0 steel (ND) Aprilia 1 kg
Materials/fuels
raw_materials_Steel, low-alloyed {RER}| steel production, converter, low-alloyed | Cut-off, U 1 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 586 kgkm
Products
Recycled 0 steel (ND) Bastia Umbra 1 kg
Materials/fuels
raw_materials_Steel, low-alloyed {RER}| steel production, converter, low-alloyed | Cut-off, U 1 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 420 kgkm
Products
100% recycled steel Aprilia 1 kg
Materials/fuels
Steel, low-alloyed {EU without Switzerland and Austria}| steel production, electric, low-alloyed | Cut-off, U – 100% 1 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 411.79 kgkm
Products
100% recycled steel Bastia Umbra 1 kg
Materials/fuels
(continued on next page)
15

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
(continued)
PRODUCTS Input Unit
100_Steel, low-alloyed {EU without Switzerland and Austria}| steel production, electric, low-alloyed | Cut-off, U – 100% 1 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 492.14 kgkm
Products
Water 1 kg
Materials/fuels
Tap water {EU without Switzerland}| market for tap water | Cut-off, U 1 kg
Products
Dismantling oil Aprilia 1 kg
Materials/fuels
Alkyd resin, long oil, without solvent, in 70% white spirit solution state {RER}| alkyd resin production, long oil, product in 70% white spirit 1 kg
solution state | Cut-off, U
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 39 kgkm
Products
Dismantling oil Bastia Umbra 1 kg
Materials/fuels
Alkyd resin, long oil, without solvent, in 70% white spirit solution state {RER}| alkyd resin production, long oil, product in 70% white spirit 1 kg
solution state | Cut-off, U
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 250 kgkm
System description
Products
cement 42,5 R II A Aprilia 1 kg
Materials/fuels
Cement, CEM II/A {EU without Switzerland}| cement production, CEM II/A | Cut-off, U 1 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 154 kgkm
Products
cement 42,5 R II A Bastia Umbra 1 kg
Materials/fuels
Cement, CEM II/A {EU without Switzerland}| cement production, CEM II/A | Cut-off, U 1 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 56 kgkm
Products
cement 42,5 R II A_module_C3 1 kg
Materials/fuels
Cement, CEM II/A {EU without Switzerland}| cement production, CEM II/A | Cut-off, U 0 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 0 kgkm
Final waste flows
Waste to treatment
Waste cement in concrete and mortar {EU without Switzerland}| treatment of waste cement in concrete and mortar, collection for final disposal | 1 kg
Cut-off, U
Products
cement 42,5 R II A_module_C4 1 kg
Materials/fuels
Cement, CEM II/A {EU without Switzerland}| cement production, CEM II/A | Cut-off, U 0 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 0 kgkm
Final waste flows
Waste to treatment
Waste concrete {EU without Switzerland}| treatment of waste concrete, inert material landfill | Cut-off, U 0 kg
Waste cement-fibre slab, dismantled {RoW}| treatment of waste cement-fibre slab, municipal incineration | Cut-off, U 0 kg
Products
cement_SENS 1 kg
Materials/fuels
Cement, CEM II/A {EU without Switzerland}| cement production, CEM II/A | Cut-off, U 1 kg
Cement, limestone 6-20% {RoW}| cement production, limestone 6-20% | Cut-off, U 1 kg
Products
Filler Aprilia 1 kg
Materials/fuels
Acrylic filler {RER}| acrylic filler production | Cut-off, U 1 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 114 kgkm
Products
Filler Bastia Umbra 1 kg
Materials/fuels
Acrylic filler {RER}| acrylic filler production | Cut-off, U 1 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 55 kgkm
System description
Products
Fluidifier Aprilia 1 kg
Materials/fuels
(continued on next page)
16

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
(continued)
PRODUCTS Input Unit
Plasticiser, for concrete, based on sulfonated melamine formaldehyde {GLO}| plasticiser production, for concrete, based on sulfonated melamine 1 kg
formaldehyde | Cut-off, U
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 597 kgkm
Products
Fluidifier Bastia Umbra 1 kg
Materials/fuels
Plasticiser, for concrete, based on sulfonated melamine formaldehyde {GLO}| plasticiser production, for concrete, based on sulfonated melamine 1 kg
formaldehyde | Cut-off, U
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 420 kgkm
Products
Gravel Aprilia 1 kg
Materials/fuels
Gravel, round {CH}| gravel and sand quarry operation | Cut-off, U 1 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 50.34 kgkm
Products
Gravel Bastia Umbra 1 kg
Materials/fuels
Gravel, round {CH}| gravel and sand quarry operation | Cut-off, U 1 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 22.4 kgkm
Products
Panel_TH20_Aprilia 1 m2
Materials/fuels
TH20_Aprilia 1 m2
Electricity/heat
Electricity, medium voltage {IT}| market for electricity, medium voltage | Cut-off, U 7.51 kWh
Electricity, low voltage {IT}| electricity production, photovoltaic, 570kWp open ground installation, multi-Si | Cut-off, U 10.67 kWh
Electricity, medium voltage {IT}| market for electricity, medium voltage | Cut-off, U -5.42 kWh
Diesel {EU without Switzerland}| market for diesel | Cut-off, U 0.054*0.844 kg
Transport, freight, lorry 3.5-7.5 metric ton, EURO4 {RER}| market for 1316.96 kgkm
Heat, central or small-scale, natural gas {EU without Switzerland}| heat production, natural gas, at boiler atmospheric non-modulating <100kW | 0.228 kWh
Cut-off, U – just combustion
Natural gas, high pressure {IT}| market for natural gas, high pressure | Cut-off, U 0.025 m3
Diesel, burned in building machine {GLO}| processing | Cut-off, U 42.8*0.0456 MJ
Particulates, <10 um 0.312 mg
Hazardous waste, for incineration {EU without Switzerland}| treatment of hazardous waste, hazardous waste incineration | Cut-off, U 0.034 kg
Scrap steel {EU without Switzerland}| treatment of scrap steel, inert material landfill | Cut-off, U 2.26 kg
Waste bitumen {EU without Switzerland}| treatment of waste bitumen, sanitary landfill | Cut-off, U 0.25 kg
Waste cement, hydrated {EU without Switzerland}| treatment of waste cement, hydrated, residual material landfill | Cut-off, U 25.15 kg
Inert waste, for final disposal {RoW}| treatment of inert waste, inert material landfill | Cut-off, U 0.11 kg
Waste wood, untreated {RoW}| treatment of waste wood, untreated, municipal incineration | Cut-off, U 0.22 kg
Waste polyethylene {IT}| market for waste polyethylene | Cut-off, U – no transport 0 kg
Waste plastic, mixture {IT}| market for waste plastic, mixture | Cut-off, U – no transport 0.04+0.01 kg
Waste electric and electronic equipment {GLO}| treatment of waste electric and electronic equipment, shredding | Cut-off, U 0.01 kg
Products
Panel_TH20_Bastia Umbra 1 m2
Materials/fuels
TH20_Bastia Umbra 1 m2
Electricity/heat
Electricity, medium voltage {IT}| market for electricity, medium voltage | Cut-off, U 4.49 kWh
Electricity, low voltage {IT}| electricity production, photovoltaic, 570kWp open ground installation, multi-Si | Cut-off, U 3.86 kWh
Electricity, medium voltage {IT}| market for electricity, medium voltage | Cut-off, U -1.35 kWh
Diesel {EU without Switzerland}| market for diesel | Cut-off, U 0.063*0.844 kg
Transport, freight, lorry 3.5-7.5 metric ton, EURO4 {RER}| market for 1746.42 kgkm
Heat, central or small-scale, natural gas {EU without Switzerland}| heat production, natural gas, at boiler atmospheric non-modulating <100kW | 2.75 kWh
Cut-off, U – just combustion
Natural gas, high pressure {IT}| market for natural gas, high pressure | Cut-off, U 0.307 m3
Diesel, burned in building machine {GLO}| processing | Cut-off, U 42.8*0.0532 MJ
Particulates, <10 um 1.61 mg
Waste to treatment 0.005 kg
Hazardous waste, for incineration {EU without Switzerland}| treatment of hazardous waste, hazardous waste incineration | Cut-off, U
Scrap steel {EU without Switzerland}| treatment of scrap steel, inert material landfill | Cut-off, U 3.64 kg
Waste bitumen {EU without Switzerland}| treatment of waste bitumen, sanitary landfill | Cut-off, U 0.14 kg
Waste cement, hydrated {EU without Switzerland}| treatment of waste cement, hydrated, residual material landfill | Cut-off, U 47.52 kg
Inert waste, for final disposal {RoW}| treatment of inert waste, inert material landfill | Cut-off, U 0.34 kg
Waste wood, untreated {RoW}| treatment of waste wood, untreated, municipal incineration | Cut-off, U 0.18 kg
Waste polyethylene {IT}| market for waste polyethylene | Cut-off, U – no transport 0.02 kg
Products
Panel_TH30_Aprilia 1 m2
Materials/fuels
TH30_Aprilia 1 m2
Electricity/heat
Electricity, medium voltage {IT}| market for electricity, medium voltage | Cut-off, U 11.27 kWh
(continued on next page)
17

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
(continued)
PRODUCTS Input Unit
Electricity, low voltage {IT}| electricity production, photovoltaic, 570kWp open ground installation, multi-Si | Cut-off, U 16.01 kWh
Electricity, medium voltage {IT}| market for electricity, medium voltage | Cut-off, U -8.13 kWh
Diesel {EU without Switzerland}| market for diesel | Cut-off, U 0.081*0.844 kg
Transport, freight, lorry 3.5-7.5 metric ton, EURO4 {RER}| market for 1975.4 kgkm
Heat, central or small-scale, natural gas {EU without Switzerland}| heat production, natural gas, at boiler atmospheric non-modulating <100kW | 0.342 kWh
Cut-off, U – just combustion
Natural gas, high pressure {IT}| market for natural gas, high pressure | Cut-off, U 0.038 m3
Diesel, burned in building machine {GLO}| processing | Cut-off, U 42.8*0.0684 MJ
Particulates, <10 um 0.47 mg
Final waste flows
Waste to treatment
Hazardous waste, for incineration {EU without Switzerland}| treatment of hazardous waste, hazardous waste incineration | Cut-off, U 0.051 kg
Scrap steel {EU without Switzerland}| treatment of scrap steel, inert material landfill | Cut-off, U 3.39 kg
Waste bitumen {EU without Switzerland}| treatment of waste bitumen, sanitary landfill | Cut-off, U 0.38 kg
Waste cement, hydrated {EU without Switzerland}| treatment of waste cement, hydrated, residual material landfill | Cut-off, U 37.73 kg
Inert waste, for final disposal {RoW}| treatment of inert waste, inert material landfill | Cut-off, U 0.17 kg
Waste wood, untreated {RoW}| treatment of waste wood, untreated, municipal incineration | Cut-off, U 0.32 kg
Waste polyethylene {IT}| market for waste polyethylene | Cut-off, U – no trasport 0 kg
Waste plastic, mixture {IT}| market for waste plastic, mixture | Cut-off, U – no trasport 0.06+0.01 kg
Waste electric and electronic equipment {GLO}| treatment of waste electric and electronic equipment, shredding | Cut-off, U 0.02 kg
Products
Panel_TH30_Bastia Umbra 1 m2
Materials/fuels
TH30_Bastia Umbra 1 m2
Electricity/heat
Electricity, medium voltage {IT}| market for electricity, medium voltage | Cut-off, U 6.74 kWh
Electricity, low voltage {IT}| electricity production, photovoltaic, 570kWp open ground installation, multi-Si | Cut-off, U 5.79 kWh
Electricity, medium voltage {IT}| market for electricity, medium voltage | Cut-off, U -2.02 kWh
Diesel {EU without Switzerland}| market for diesel | Cut-off, U 0.095*0.844 kg
Transport, freight, lorry 3.5-7.5 metric ton, EURO4 {RER}| market for 2619.47 kgkm
Heat, central or small-scale, natural gas {EU without Switzerland}| heat production, natural gas, at boiler atmospheric non-modulating <100kW | 4.12 kWh
Cut-off, U – just combustion
Natural gas, high pressure {IT}| market for natural gas, high pressure | Cut-off, U 0.461 m3
Diesel, burned in building machine {GLO}| processing | Cut-off, U 42.8*0.0802 MJ
Particulates, <10 um 2.42 mg
Final waste flows
Waste to treatment
Hazardous waste, for incineration {EU without Switzerland}| treatment of hazardous waste, hazardous waste incineration | Cut-off, U 0.008 kg
Scrap steel {EU without Switzerland}| treatment of scrap steel, inert material landfill | Cut-off, U 5.47 kg
Waste bitumen {EU without Switzerland}| treatment of waste bitumen, sanitary landfill | Cut-off, U 0.21 kg
Waste cement, hydrated {EU without Switzerland}| treatment of waste cement, hydrated, residual material landfill | Cut-off, U 71.27 kg
Inert waste, for final disposal {RoW}| treatment of inert waste, inert material landfill | Cut-off, U 0.51 kg
Waste wood, untreated {RoW}| treatment of waste wood, untreated, municipal incineration | Cut-off, U 0.27 kg
Waste polyethylene {IT}| market for waste polyethylene | Cut-off, U – no transport 0.03 kg
Products
Electrowelded mesh Aprilia 1 kg
Materials/fuels
Reinforcing steel {EU without Austria}| reinforcing steel production | Cut-off, U – 97% 1 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 570 kgkm
Products
Electrowelded mesh Bastia Umbra 1 kg
Materials/fuels
Reinforcing steel {EU without Austria}| reinforcing steel production | Cut-off, U – 97% 1 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 380 kgkm
Products
Electrowelded mesh_module_C3 1 kg
Materials/fuels
Reinforcing steel {EU without Austria}| reinforcing steel production | Cut-off, U – 97% 0 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 0 kgkm
Final waste flows
Waste to treatment
Steel and iron (waste treatment) {GLO}| recycling of steel and iron | Cut-off, U 0.893 kg
Products
Electrowelded mesh_module_C4 1 kg
Materials/fuels
Reinforcing steel {EU without Austria}| reinforcing steel production | Cut-off, U – 97% 0 kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for 0 kgkm
Final waste flows
Waste to treatment
Scrap steel {EU without Switzerland}| treatment of scrap steel, inert material landfill | Cut-off, U 0.055 kg
Steel in car shredder residue {RoW}| treatment of steel in car shredder residue, municipal incineration | Cut-off, U 0.052 kg
Products
(continued on next page)
18

S. Cavagnoli et al.                                                                                                                                                                                                   E  n  e r  g y   &   B  u  i l d  i n  g s 312(2024)114218
(continued)
| PRODUCTS      | Input  | Unit  |
| ------------- | ------ | ----- |
| Sand Aprilia  | 1      | kg    |
Materials/fuels
Silica sand {RoW}| silica sand production | Cut-off, U  1  kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for  57  kgkm
Products
| Sand Bastia Umbra  | 1   | kg  |
| ------------------ | --- | --- |
Materials/fuels
Silica sand {RoW}| silica sand production | Cut-off, U  1  kg
Electricity/heat
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for  26.7  kgkm
Products
| PET Aprilia  | 1   | kg  |
| ------------ | --- | --- |
Materials/fuels
Polyethylene terephthalate, granulate, amorphous, recycled {EU without Switzerland}| polyethylene terephthalate production, granulate,  0.75  kg
amorphous, recycled | Cut-off, U
Polyethylene terephthalate, granulate, bottle grade {RER}| polyethylene terephthalate production, granulate, bottle grade | Cut-off, U  0.25  kg
Electricity/heat
| Polymer foaming {RER}| polymer foaming | Cut-off, U  | 1   | kg  |
| ---------------------------------------------------- | --- | --- |
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for  347  kgkm
Products
| PET Bastia Umbra  | 1   | kg  |
| ----------------- | --- | --- |
Materials/fuels
Polyethylene terephthalate, granulate, amorphous, recycled {EU without Switzerland}| polyethylene terephthalate production, granulate,  0.75  kg
amorphous, recycled | Cut-off, U
Polyethylene terephthalate, granulate, bottle grade {RER}| polyethylene terephthalate production, granulate, bottle grade | Cut-off, U  0.25  kg
Electricity/heat
| Polymer foaming {RER}| polymer foaming | Cut-off, U  | 1   | kg  |
| ---------------------------------------------------- | --- | --- |
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for  184  kgkm
Products
| PET_module_C3  | 1   | kg  |
| -------------- | --- | --- |
Materials/fuels
Polyethylene terephthalate, granulate, amorphous, recycled {EU without Switzerland}| polyethylene terephthalate production, granulate,  0  kg
amorphous, recycled | Cut-off, U
Polyethylene terephthalate, granulate, bottle grade {RER}| polyethylene terephthalate production, granulate, bottle grade | Cut-off, U  0  kg
Electricity/heat
| Polymer foaming {RER}| polymer foaming | Cut-off, U  | 0   | kg  |
| ---------------------------------------------------- | --- | --- |
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for  0  kgkm
Final waste flows
Waste to treatment
PET (waste treatment) {GLO}| recycling of PET | Cut-off, U  0.364  kg
System description
Products
| PET_module_C4  | 1   | kg  |
| -------------- | --- | --- |
Materials/fuels
Polyethylene terephthalate, granulate, amorphous, recycled {EU without Switzerland}| polyethylene terephthalate production, granulate,  0  Kg
amorphous, recycled | Cut-off, U
Polyethylene terephthalate, granulate, bottle grade {RER}| polyethylene terephthalate production, granulate, bottle grade | Cut-off, U  0  Kg
Electricity/heat
| Polymer foaming {RER}| polymer foaming | Cut-off, U  | 0   | kg  |
| ---------------------------------------------------- | --- | --- |
Transport, freight, lorry 16-32 metric ton, EURO4 {RER}| market for  0  kgkm
Final waste flows
Waste to treatment
Waste polyethylene {RoW}| treatment of waste polyethylene, sanitary landfill | Cut-off, U  0.325  kg
Waste polyethylene {RoW}| treatment of waste polyethylene, municipal incineration | Cut-off, U  0.311  kg
Products
| TH20_Aprilia  | 1   | m2  |
| ------------- | --- | --- |
Materials/fuels
| 100 recycled steel Aprilia     | 6.75           | kg  |
| ------------------------------ | -------------- | --- |
| Recycled 0 steel (ND) Aprilia  | 0.3            | kg  |
| Electrowelded mesh Aprilia     | 3.59           | kg  |
| Dismantling oil Aprilia        | 0.134*0.86     | kg  |
| cement 42,5 R II A Aprilia     | 52.283         | kg  |
| Gravel Aprilia                 | 11.149+74.323  | kg  |
| Sand Aprilia                   | 139.549        | kg  |
| Water                          | 23.707         | kg  |
| Fluidifier Aprilia             | 0.378*1.06     | kg  |
| Filler Aprilia                 | 0              | kg  |
| PET Aprilia                    | 2.88           | kg  |
| Accelerator                    | 0.769*1.10     | kg  |
Products
| TH20_Bastia Umbra  | 1   | m2  |
| ------------------ | --- | --- |
Materials/fuels
| 100% Recycled Steel Bastia Umbra    | 3.506+1.650+0.174  | kg  |
| ----------------------------------- | ------------------ | --- |
| Recycled 0 steel (ND) Bastia Umbra  | 0.051+0.173+0.004  | kg  |
| Electrowelded mesh Bastia Umbra     | 3.751              | kg  |
(continued on next page)
19

S. Cavagnoli et al.                                                                                                                                                                                                   E  n  e r  g y   &   B  u  i l d  i n  g s 312(2024)114218
(continued)
| PRODUCTS                         | Input       | Unit  |
| -------------------------------- | ----------- | ----- |
| Dismantling oil Bastia Umbra     | 0.134*0.86  | kg    |
| cement 42,5 R II A Bastia Umbra  | 49.461      | kg    |
62.521+38.513
| Gravel Bastia Umbra     |                 | kg  |
| ----------------------- | --------------- | --- |
| Sand Bastia Umbra       | 119.319+23.202  | kg  |
| Water                   | 24.453          | kg  |
| FluidifierBastia Umbra  | 0.662*1.06      | kg  |
| Filler Bastia Umbra     | 14.449          | kg  |
| PET Bastia Umbra        | 2.443           | kg  |
| Accelerator             | 0               | kg  |
Products
| TH30_Aprilia  | 1   | m2  |
| ------------- | --- | --- |
Materials/fuels
| 100% recycled steel Aprilia    | 12.52         | kg  |
| ------------------------------ | ------------- | --- |
| Recycled 0 steel (ND) Aprilia  | 0.556         | kg  |
| Electrowelded mesh Aprilia     | 5.68          | kg  |
| Dismantling oil Aprilia        | 0.13*0.86     | kg  |
| cement 42,5 R II A Aprilia     | 68.36         | kg  |
| Gravel Aprilia                 | 14.949+97.42  | kg  |
| Sand Aprilia                   | 182.919       | kg  |
| Water                          | 31.07         | kg  |
| Fluidifier Aprilia             | 0.496*1.06    | kg  |
| Filler Aprilia                 | 0             | kg  |
| PET Aprilia                    | 5.28          | kg  |
| Accelerator                    | 1.008*1.1     | kg  |
Products
| TH30_Bastia Umbra  | 1   | m2  |
| ------------------ | --- | --- |
Materials/fuels
5.077+2.388+0.252
| 100% recycled steel Bastia Umbra    |                    | kg  |
| ----------------------------------- | ------------------ | --- |
| Recycled 0 steel (ND) Bastia Umbra  | 0.074+0.005+0.250  | kg  |
| Electrowelded mesh Bastia Umbra     | 4.21               | kg  |
| Dismantling oil Bastia Umbra        | 0.11*0.86          | kg  |
| cement 42,5 R II A Bastia Umbra     | 53.86              | kg  |
| Gravel Bastia Umbra                 | 62.531+48.471      | kg  |
130.251+25.827
| Sand Bastia Umbra        |             | kg  |
| ------------------------ | ----------- | --- |
| Water                    | 26.325      | kg  |
| Fluidifier Bastia Umbra  | 0.716*1.06  | kg  |
| Filler Bastia Umbra      | 15.538      | kg  |
| PET Bastia Umbra         | 5.97        | kg  |
| Accelerator              | 0           | kg  |
Project Input parameters
| consumption_fuel_demolition_TH20  | 0.5   | Undef.   |
| --------------------------------- | ----- | -------- |
| consumption_fuel_demolition_TH30  | 0.75  | Undef.   |
References  [9] M.Y. Durgun, Experimental research on gypsum-based mixtures containing
recycled roofing tile powder at ambient and high temperatures, Constr. Build.
Mater. 285 (2021) 122956, https://doi.org/10.1016/j.conbuildmat.2021.122956.
[1] J. Hong, G.Q. Shen, Y. Feng, W.S.T. Lau, C. Mao, Greenhouse gas emissions during
[10] D. Robert, E. Baez, S. Setunge, A new technology of transforming recycled glass
the construction phase of a building: A case study in China, J. Clean. Prod. 103  waste to construction components, Constr. Build. Mater. 313 (2021) 125539,
(2015) 249–259, https://doi.org/10.1016/j.jclepro.2014.11.023.
https://doi.org/10.1016/j.conbuildmat.2021.125539.
[2] Global Alliance for Buildings and Construction, International Energy Agency,  [11] A. Arulrajah, E. Yaghoubi, Y.C. Wong, S. Horpibulsuk, Recycled plastic granules
United Nations Environment Programme. 2019 Global Status Report for Buildings
and demolition wastes as construction materials: Resilient moduli and strength
and Construction: Towards a zero-emissions, efficient and resilient buildings and  characteristics, Constr. Build. Mater. 147 (2017) 639–647, https://doi.org/
construction sector. 2019.
10.1016/j.conbuildmat.2017.04.178.
[3] N.M. Aly, H.S. Seddeq, K. Elnagar, T. Hamouda, Acoustic and thermal performance
[12] Bolden, Utilization of recycled and waste materials in various construction
of sustainable fiber reinforced thermoplastic composite panels for insulation in  applications, Am. J. Environ. Sci. 9 (2013) 14–24, https://doi.org/10.3844/
buildings, J. Build. Eng. (2021) 40, https://doi.org/10.1016/j.jobe.2021.102747.
ajessp.2013.14.24.
[4] P. Santos, L. Sousa, L. Godinho, J.R. Correia, A.M.P.G. Dias, Acoustic and thermal
behaviour of cross-insulated timber panels, J. Build. Eng. (2021) 44, https://doi.  [13] J.K. Appiah, V.N. Berko-Boateng, T.A. Tagbor, Use of waste plastic materials for
road construction in Ghana, Case Stud. Constr. Mater. 6 (2017) 1–7, https://doi.
org/10.1016/j.jobe.2021.103309.
org/10.1016/j.cscm.2016.11.001.
[5] C. Buratti, E. Belloni, E. Lascaro, F. Merli, P. Ricciardi, Rice husk panels for  [14] A. Mohammadinia, Y.C. Wong, A. Arulrajah, S. Horpibulsuk, Strength evaluation of
building applications: Thermal, acoustic and environmental characterization and
utilizing recycled plastic waste and recycled crushed glass in concrete footpaths,
comparison with other innovative recycled waste materials, Constr. Build. Mater.  Constr. Build. Mater. 197 (2019) 489–496, https://doi.org/10.1016/j.
171 (2018) 338–349, https://doi.org/10.1016/j.conbuildmat.2018.03.089.
conbuildmat.2018.11.192.
[6] M. Ouakarrouch, S. Bousshine, A. Bybi, N. Laaroussi, M. Garoum, Acoustic and
[15] J. Thorneycroft, J. Orr, P. Savoikar, R.J. Ball, Performance of structural concrete
thermal performances assessment of sustainable insulation panels made from  with recycled plastic waste as a partial replacement for sand, Constr. Build. Mater.
cardboard waste and natural fibers, Appl. Acoust. 199 (2022) 109007, https://doi.
161 (2018) 63–69, https://doi.org/10.1016/j.conbuildmat.2017.11.127.
org/10.1016/j.apacoust.2022.109007.
[7] M.U. Hossain, C.S. Poon, I.M.C. Lo, J.C.P. Cheng, Comparative environmental  [16] S. Agyeman, N.K. Obeng-Ahenkora, S. Assiamah, G. Twumasi, Exploiting recycled
plastic waste as an alternative binder for paving blocks production, Case Stud.
evaluation of aggregate production from recycled waste materials and virgin
sources by LCA, Resour. Conserv. Recycl. 109 (2016) 67–77, https://doi.org/  Constr. Mater. 11 (2019) e00246.
[17] E. Tian, J. Mo, Toward energy saving and high efficiency through an optimized use
10.1016/j.resconrec.2016.02.009.
of a PET coarse filter: The development of a new electrostatically assisted air filter,
[8] E. Ganjian, M. Khorami, A.A. Maghsoudi, Scrap-tyre-rubber replacement for  Energ. Build. 186 (2019) 276–283, https://doi.org/10.1016/j.
aggregate and filler in concrete, Constr. Build. Mater. 23 (2009) 1828–1836,
enbuild.2019.01.021.
https://doi.org/10.1016/j.conbuildmat.2008.09.020.
[18] M.I.H. Hassan, A.A. Kadir, I.S.I. Arzlan, M.R.M. Tomari, N.A. Mardi, M.F. Hassan,
et al., Recycling of PET bottles into different types of building materials: A review,
Arch. Metall. Mater. (2023), https://doi.org/10.24425/amm.2022.137488.
20

S. Cavagnoli et al. E n e r g y & B u i l d i n g s 312(2024)114218
[19] H. Limami, I. Manssouri, K. Cherkaoui, A. Khaldoun, Study of the suitability of [44] S. Lehmann, Low carbon construction systems using prefabricated engineered solid
unfired clay bricks with polymeric HDPE & PET wastes additives as a construction wood panels for urban infill to significantly reduce greenhouse gas emissions,
material, J. Build. Eng. 27 (2020) 100956, https://doi.org/10.1016/j. Sustain. Cities Soc. 6 (2013) 57–67, https://doi.org/10.1016/j.scs.2012.08.004.
jobe.2019.100956. [45] A. Carbonari, M. De Grassi, C. Di Perna, P. Principi, Numerical and experimental
[20] J.O. Akinyele, U.T. Igba, B.G. Adigun, Effect of waste PET on the structural analyses of PCM containing sandwich panels for prefabricated walls, Energ. Build.
properties of burnt bricks, Sci. Afr. 7 (2020) e00301, https://doi.org/10.1016/j. 38 (2006) 472–483, https://doi.org/10.1016/j.enbuild.2005.08.007.
sciaf.2020.e00301. [46] V. Puri, P. Chakrabortty, S. Anand, S. Majumdar, Bamboo reinforced prefabricated
[21] F.I. Aneke, B.O. Awuzie, M.M.H. Mostafa, C. Okorafor, Durability assessment and wall panels for low cost housing, J. Build. Eng. 9 (2017) 52–59, https://doi.org/
microstructure of high-strength performance bricks produced from PET waste and 10.1016/j.jobe.2016.11.010.
foundry sand, Materials (Basel) 14 (2021) 5635, https://doi.org/10.3390/ [47] R. O’Hegarty, A. Reilly, R. West, O. Kinnane, Thermal investigation of thin precast
ma14195635. concrete sandwich panels, J. Build. Eng. 27 (2020) 100937, https://doi.org/
[22] A.F. Ikechukwu, C. Shabangu, Strength and durability performance of masonry 10.1016/j.jobe.2019.100937.
bricks produced with crushed glass and melted PET plastics, Case Stud. Constr. [48] L. Peng, L. Xiaoyong, C. Ying, Y. Zhiwu, Y. Dayou, Thermodynamic and acoustic
Mater. 14 (2021) e00542, https://doi.org/10.1016/j.cscm.2021.e00542. behaviors of prefabricated composite wall panel, Structures 28 (2020) 1301–1313,
[23] J.A. Paschoalin Filho, J.H. Storopoli, A.J. Guerner Dias, Evaluation of compressive https://doi.org/10.1016/j.istruc.2020.09.069.
strength and water absorption of soilcement bricks manufactured with addition of [49] G.K. Oral, A.K. Yener, N.T. Bayazit, Building envelope design with the objective to
pet (polyethylene terephthalate) wastes, Acta Sci. (2016) 38. ensure thermal , visual and acoustic comfort conditions 39 (2004) 281–287.
[24] K. Nov´akov´a, K. S ˇ eps, H. Achten, Experimental development of a plastic bottle https://doi.org/10.1016/S0360-1323(03)00141-0.
usable as a construction building block created out of polyethylene terephthalate: [50] L. Huang, Y. Zhu, Q. Ouyang, B. Cao, A study on the effects of thermal, luminous,
Testing PET(b)rick 1.0, J. Build. Eng. 12 (2017) 239–247, https://doi.org/ and acoustic environments on indoor environmental comfort in offices, Build.
10.1016/j.jobe.2017.05.015. Environ. 49 (2012) 304–309, https://doi.org/10.1016/j.buildenv.2011.07.022.
[25] C. Jm, M. Di, R. Sm, PET bottles for eco-friendly building in sustainable [51] E.L. Krüger, P.H.T. Zannin, Acoustic, thermal and luminous comfort in classrooms,
development, Int. J. Curr. Trends Eng. Res. 2 (2016) 318–326. Build. Environ. 39 (2004) 1055–1063, https://doi.org/10.1016/j.
[26] M. Garrido, J.R. Correia, T. Keller, Effects of elevated temperature on the shear buildenv.2004.01.030.
response of PET and PUR foams used in composite sandwich panels, Constr. Build. [52] R. Hufenus, Y. Yan, M. Dauner, T. Kikutani, Melt-spun fibers for textile
Mater. 76 (2015) 150–157, https://doi.org/10.1016/j.conbuildmat.2014.11.053. applications, Materials (Basel) 13 (2020) 4298, https://doi.org/10.3390/
[27] H. Xie, C. Shen, H. Fang, J. Han, W. Cai, Flexural property evaluation of web ma13194298.
reinforced GFRP-PET foam sandwich panel: Experimental study and numerical [53] A.L. Pisello, F. Cotana, A. Nicolini, C. Buratti, Effect of dynamic characteristics of
simulation, Compos. B Eng. 234 (2022) 109725, https://doi.org/10.1016/j. building envelope on thermal-energy performance in winter conditions: In field
compositesb.2022.109725. experiment, Energ. Build. 80 (2014) 218–230, https://doi.org/10.1016/j.
[28] M. Xanthos, R. Dhavalikar, V. Tan, S. Dey, U. Yilmazer, Properties and applications enbuild.2014.05.017.
of sandwich panels based on PET foams, J. Reinf. Plast. Compos. (2001). [54] ASTM E2611-17: Standard Test Method for Normal Incidence Determination of
[29] K.S. Rebeiz, Time-temperature properties of polymer concrete using recycled PET, Porous Material Acoustical Properties Based on the Transfer Matrix Method. n.d.
Cem. Concr. Compos. 17 (1995) 119–124, https://doi.org/10.1016/0958-9465 [55] International Organization for Standardization. ISO 10534-2: 2001: Acoustics-
(94)00004-I. Determination of Sound Absorption Coefficient and Impedance in Impedance
[30] B. Sarde, Y. Patil, B. Dholakiya, V. Pawar, Effect of calcined kaolin clay on Tubes. 2001.
mechanical and durability properties of pet waste-based polymer mortar [56] ISO 16283-3:2016: Acoustics — Field measurement of sound insulation in
composites, Constr. Build. Mater. 318 (2022) 126027, https://doi.org/10.1016/j. buildings and of building elements — Part 3: Façade sound insulation. n.d.
conbuildmat.2021.126027. [57] ISO 354:2003: Acoustics — Measurement of sound absorption in a reverberation
[31] K.S. Rebeiz, Precast use of polymer concrete using unsaturated polyester resin room. n.d.
based on recycled PET waste, Constr. Build. Mater. 10 (1996) 215–220, https:// [58] ISO 3382-2:2008: Acoustics — Measurement of room acoustic parameters — Part
doi.org/10.1016/0950-0618(95)00088-7. 2: Reverberation time in ordinary rooms. n.d.
[32] S. Fadhil, M. Yaseen, The production of economical precast concrete panels [59] UNI EN ISO 717-1:2021: Acoustics - Rating of sound insulation in buildings and of
reinforced by waste plastic fibers, Am. J. Civ. Eng. Arch. 3 (2015) 80–85, https:// building elements - Part 1: Airborne sound insulation. n.d.
doi.org/10.12691/ajcea-3-3-4. [60] ISO 22007-2: Plastics — Determination of thermal conductivity and thermal
[33] H. Sharma, Innovative and sustainable application of PET bottle a green diffusivity — Part 2: Transient plane heat source (hot disc) method. 2015.
construction overview, Indian J. Sci. Technol. 10 (2017) 1–6, https://doi.org/ [61] ISO 9869-1:2014: Thermal insulation -Building elements - In-situ measurement of
10.17485/ijst/2017/v10i16/114307. thermal resistance and thermal transmittance - Part 1: Heat flow meter method. n.
[34] A. Munir, M. Irfandi, Abdullah, A preliminary study on the use of PET bottle waste d.
as the green roof drainage layer for thermal insulator, IOP Conf. Ser. Earth Environ. [62] ISO 14021:2016: Environmental labels and declarations - Self-declared
Sci. (2021) 881, https://doi.org/10.1088/1755-1315/881/1/012054. environmental claims (Type II environmental labelling). n.d.
[35] A. Briga-Sa´, L. Ferreira, B. Paulo, I. Bentes, C.A. Teixeira, Energy and [63] EN ISO 14020:2001: Environmental labels and declarations - General principles. n.
environmental performance assessment of reused PET bottles panels for building d.
thermal insulation solutions, Energ. Build. 298 (2023) 113529, https://doi.org/ [64] ISO 14040:2006: Environmental management — Life cycle assessment —
10.1016/j.enbuild.2023.113529. Principles and framework. n.d.
[36] A. Vargas, B.V. Silva, M.R. Rocha, F. Pelisser, Precast slabs using recyclable [65] ISO 14044:2021: Environmental management - Life cycle assessment -
packaging as flooring support elements, J. Clean. Prod. 66 (2014) 92–100, https:// Requirements and guidelines n.d.
doi.org/10.1016/j.jclepro.2013.10.059. [66] EN 15804:2012+A2:2019: Sustainability of construction works - Environmental
[37] I.A. Santana, D. Susanto, W. Widyarko, Pet plastic bottle waste with reuse product declarations - Core rules for the product category of construction products.
approach as interior pre-fabrication modules for interior wall, Insist 2 (2017) 26, n.d.
https://doi.org/10.23960/ins.v2i1.29. [67] A. Gupta, and R. Sharma, “A New Method for Estimation of Automobile Fuel
[38] A.F. Abd Rashid, S. Yusoff, A review of life cycle assessment method for building Adulteration”, in Air Pollution. London, United Kingdom: IntechOpen, 2010
industry, Renew. Sustain. Energy Rev. 45 (2015) 244–248, https://doi.org/ [Online]. Available: https://www.intechopen.com/chapters/11778 doi: 10.5772/
10.1016/j.rser.2015.01.043. 10054 n.d.
[39] M. Bahramian, K. Yetilmezsoy, Life cycle assessment of the building industry: An [68] Fondazione per lo sviluppo sostenibile, FISE UNICIRCULAR - Unione Imprese
overview of two decades of research (1995–2018), Energ. Build. (2020) 219, Economia Circolare. L’Italia del Riciclo 2020. 2020.
https://doi.org/10.1016/j.enbuild.2020.109917. [69] ISPRA. Rapporto Rifiuti Urbani - Edizione 2021. n.d.
[40] C. Ingrao, A. Lo Giudice, C. Tricase, R. Rana, C. Mbohwa, V. Siracusa, Recycled- [70] M.S.M. Noh, Z. Ahmad, A. Ibrahim, P. Walker, Development of new prefabricated
PET fibre based panels for building thermal insulation: Environmental impact and wall constructed using wood-wool cement composite panel, Procedia Environ. Sci.
improvement potential assessment for a greener production, Sci. Total Environ. 34 (2016) 298–308, https://doi.org/10.1016/j.proenv.2016.04.027.
493 (2014) 914–929, https://doi.org/10.1016/j.scitotenv.2014.06.022. [71] R. Garay, F. Pfenniger, M. Castillo, C. Fritz, Quality and Sustainability indicators of
[41] F. Intini, S. Kühtz, Recycling in buildings: an LCA case study of a thermal insulation the prefabricated wood housing industry—A Chilean case study, Sustainability 13
panel made of polyester fiber, recycled from post-consumer PET bottles, Int. J. Life (2021) 8523, https://doi.org/10.3390/su13158523.
Cycle Assess. 16 (2011) 306–315, https://doi.org/10.1007/s11367-011-0267-9. [72] S. Zou, H. Li, S. Wang, R. Jiang, J. Zou, X. Zhang, et al., Experimental research on
[42] X. Yang, M. Huang, F. Lin, Research strategies on new prefabricated technology for an innovative sawdust biomass-based insulation material for buildings, J. Clean.
underground metro stations, Urban Rail Transit. 5 (2019) 145–154, https://doi. Prod. 260 (2020) 121029, https://doi.org/10.1016/j.jclepro.2020.121029.
org/10.1007/s40864-019-0106-z. [73] A.L. Pisello, C. Piselli, F. Cotana, Influence of human behavior on cool roof effect
[43] W. Lu, W.M.W. Lee, F. Xue, J. Xu, Revisiting the effects of prefabrication on for summer cooling, Build. Environ. (2015), https://doi.org/10.1016/j.
construction waste minimization: A quantitative study using bigger data, Resour. buildenv.2014.09.025.
Conserv. Recycl. 170 (2021) 105579, https://doi.org/10.1016/j.
resconrec.2021.105579.
21
EVALUATION OF HOURLY SOLAR RADIATION
MODELS TO ESTIMATE RADIATION ON INCLINED
SURFACES IN DRY ZONE OF SRI LANKA
Abeyrathna A.R.M.U.E.
128352L
Degree of Master of Engineering
Department of Mechanical Engineering
University of Moratuwa
Sri Lanka
December 2017

EVALUATION OF HOURLY SOLAR RADIATION
MODELS TO ESTIMATE RADIATION ON INCLINED
SURFACES IN DRY ZONE OF SRI LANKA
Abeyrathna A.R.M.U.E.
128352L
Thesis submitted in partial fulfillment of the requirements for the degree
Master of Engineering
Department of Mechanical Engineering
University of Moratuwa
Sri Lanka
December 2017

DECLARATION
I declare that this is my own work and this thesis does not incorporate without
acknowledgement any material previously submitted for a degree or diploma in any
other University or institute of higher learning and to the best of my knowledge and
belief it does not contain any material previously published or written by another
person except where the acknowledgement is made in the text.
Also, I hereby grant to University of Moratuwa the non-exclusive right to reproduce
and distribute my thesis, in whole or part in print, electronic or other medium. I retain
the right to use this content in whole or part in future works (such as articles or books).
Signature: .............................. Date: ..............................
Abeyrathna A.R.M.U.E.
The above candidate has carried out research for the Masters Thesis under my
supervision
Signature: .............................. Date: ..............................
Prof. R.A Attalage
Page i

ABSTRACT
An analysis of global, beam and diffuse solar radiation on horizontal and 7° tilt about east west
axis and facing due south orientation at Hambanthota was carried out to assess the solar
resource potential in dry zone of Sri Lanka. The calculated monthly averaged daily insolation
for dry zone was found to be varying between 16.30 MJ/m2/day to 22.75 MJ/m2/day with the
annually averaged daily insolation of 20.07 MJ/m2/day. Calculated annually averaged beam
horizontal radiation was 10.87 MJ/m2/day and diffuse horizontal radiation was found to be
9.19 MJ/m2/day while 0.56 was the annual average clearness index indicating that partly
cloudy sky throughout the year. Horizon brightness coefficients of Perez et al (1990) was
modified using diffuse radiation data of Hambanthota. Modified model was used for the
estimation of titled radiation on due south faced surfaces. Diffuse tilted daily insolation and
global tilted insolation for -45° to +45° inclined surfaces with 1° increments was estimated
and monthly and annual optimum tilt angles were derived. The calculated monthly optimum
tilt angle varied between -26° to +27° while having annual optimum tilt angle of -2°. Hence,
tilting towards due south by same angle as latitude is not the recommended optimum
tilt for fixed axis systems. Optimum tilt angle for beam radiation was derived and it was
found that annual optimum tilt angle for beam radiation is 6° facing towards the due south.
The derived maximum solar resource potential was 2068 kWh/m2 per annum for fixed system
at -2° tilt angle and 2169 kWh/m2 per annum for monthly tracking system which is 5% higher
than the horizontal potential. It is proposed to assess the solar resource potential for tilted
surfaces with different surface azimuth angles by using modified Perez et al (1990) model in
future. It is also possible to modify the coefficients of circumsolar brightness components of
Perez et al (1990) model for better results.
Key Words: Diffuse Solar Radiation, Isotropic Models, Anisotropic Models, Optimum Tilt
angle, Hambanthota.
Page ii

ACKNOWLEDGEMENT
I am very much grateful to Prof. R.A Attalage, Deputy Vice Chancellor of the
University of Moratuwa for giving me his utmost support and guidance for this
research. I am very much grateful to the course coordinator of M.Eng/PG Diploma on
Energy Technology Dr. Himan Punchihewa, Senior lecturer, Department of
Mechanical Engineering, University of Moratuwa, for giving his fullest support in
every stage of this research. This research was carried out under the supervision of
Prof. R.A Attalage, senior professor, Department of Mechanical Engineering,
University of Moratuwa. I am indebted to him for the valuable guidance, and kind
hearted co-operation and encouragement extended throughout the research. I would
like to extend my sincere thanks to Mr. M.M.R. Pathmasiri, Director General (SEA),
Mr. H.A. Vimal Nadeera, Deputy Director General - Operatins (SEA), who gave their
co-operation and utmost support by giving access to radiation data of Hambanthota
Solar Park. It is a great pleasure to remember the kind co-operation extended by the
colleagues in the post graduate programme who helped me to continue the studies from
start to end. Finally, I appreciate everybody, who helped me in numerous ways at
different stages of the study, which was of utmost importance in bringing out this effort
a success.
Page iii

TABLE OF CONTENTS
DECLARATION .......................................................................................................... i
ABSTRACT ................................................................................................................. ii
ACKNOWLEDGEMENT .......................................................................................... iii
TABLE OF CONTENTS ............................................................................................ iv
LIST OF FIGURES ................................................................................................... vii
LIST OF TABLES ....................................................................................................... x
LIST OF APPENDICESS ........................................................................................... xi
LIST OF NOMENCLATURE ................................................................................... xii
LIST OF ABBREVIATIONS ................................................................................... xvi
1 INTRODUCTION ........................................................................................... 1
1.1 Background .......................................................................................... 1
1.2 Present status of solar energy applications in Sri Lanka ...................... 2
1.3 Problem statement ................................................................................ 3
1.4 Aim and objectives .............................................................................. 4
1.5 Outcomes ............................................................................................. 5
1.6 Scope of the study ................................................................................ 5
1.7 Outline of the study .............................................................................. 5
2 REVIEW OF THE LITRATURE .................................................................... 6
2.1 FUNDAMENTALS OF SOLAR RADIATION ................................. 6
2.1.1 The Sun and Earth .................................................................... 6
2.2 Solar Geometry .................................................................................... 7
2.2.1 Sun-Earth angles ...................................................................... 8
2.2.2 Solar angles ............................................................................ 11
2.2.3 Angles for tracking surfaces .................................................. 14
2.3 Reckoning of time .............................................................................. 16
2.4 Extra-terrestrial and Terrestrial Solar Radiation ................................ 17
2.4.1 Definitions .............................................................................. 17
2.4.2 Extra-terrestrial solar radiation .............................................. 18
Page iv

2.4.3 Earth’s Atmosphere ............................................................... 20
2.4.4 Atmospheric attenuation ........................................................ 21
2.4.5 Terrestrial Solar Radiation ..................................................... 25
2.4.6 Solar radiation on the tilted surface ....................................... 26
2.5 Measuring of Solar Radiation ............................................................ 28
2.5.1 Pyranometers .......................................................................... 28
2.5.2 Pyrheliometers ....................................................................... 29
2.5.3 Sunshine recorders ................................................................. 29
2.6 Methods of solar radiation estimation ................................................ 30
2.6.1 Parametric Models ................................................................. 30
2.6.2 Decomposition Models .......................................................... 36
2.6.3 Estimation of Hourly Irradiance from Daily Irradiance Data 44
2.7 Estimation of Radiation on Tilted Surfaces ....................................... 46
2.7.1 Isotropic sky hourly radiation models .................................... 48
2.7.2 Anisotropic sky hourly radiation models ............................... 49
2.7.3 Daily radiation and averaged radiation models ..................... 54
3 RESEARCH METHODOLOGY ................................................................... 59
3.1 Analysis of existing diffuse radiation models .................................... 59
3.2 Development of new model suitable for dry zone in Sri Lanka ........ 60
3.3 Estimation of solar radiation potential on horizontal surfaces in dry
zone in Sri Lanka ............................................................................... 63
3.4 Estimation of solar radiation potential on tilted surfaces in dry zone in
Sri Lanka ............................................................................................ 63
3.5 Estimation of optimum tilt angle for dry zone in Sri Lanka .............. 63
4 RESULTS AND DISCUSSION .................................................................... 64
4.1 Analysis of existing diffuse radiation models .................................... 64
4.1.1 Isotropic models ..................................................................... 64
4.1.2 Anisotropic models ................................................................ 66
Page v

4.1.3 Summary of Analysis of existing diffuse radiation models ... 68
4.2 Development of new diffuse radiation model suitable for dry zone in
Sri Lanka ............................................................................................ 72
4.3 Estimation of solar radiation potential on horizontal surfaces in dry
zone in Sri Lanka ............................................................................... 75
4.3.1 Estimation of Annually averaged hourly radiation ................ 75
4.3.2 Estimation of monthly averaged hourly radiation ................. 76
4.3.3 Estimation of monthly averaged clearness index ................... 80
4.3.4 Estimation of monthly averaged daily radiation .................... 82
4.4 Estimation of solar radiation potential on tilted surfaces in dry zone in
Sri Lanka ............................................................................................ 83
4.4.1 Annual averaged insolation on tilted surfaces ....................... 83
4.4.2 Monthly averaged daily insolation on tilted surfaces ............ 84
4.5 Estimation of optimum tilt angle for dry zone in Sri Lanka .............. 92
5 CONCLUSIONS AND RECOMMENDATIONS ........................................ 98
References ................................................................................................................ 100
Appendix A Monthly averaged hourly global horizontal insolation .................... 105
Appendix B Monthly averaged hourly beam horizontal insolation ..................... 106
Appendix C Monthly averaged hourly diffuse horizontal insolation ................... 107
Appendix D Monthly averaged hourly global tilted (β = 7°) insolation .............. 108
Appendix E Monthly averaged hourly beam tilted (β = 7°) insolation ................ 109
Appendix F Monthly averaged hourly diffuse tilted (β = 7°) insolation ............. 110
Appendix G Monthly averaged hourly beam normal insolation .......................... 111
Appendix H Monthly averaged daily global insolation ........................................ 112
Appendix I Monthly averaged daily beam insolation ......................................... 116
Appendix J Monthly averaged daily diffuse insolation....................................... 120
Page vi

LIST OF FIGURES
Page
Figure 2.1 - The Sun-Earth relationship ...................................................................... 7
Figure 2.2 - Relative position of the earth on 21st of June and 21st of December ........ 8
Figure 2.3 - Declination angles in equinoxes and solstices ......................................... 9
Figure 2.4 - Variation of the declination angle .......................................................... 10
Figure 2.5 - Basic Sun-Earth angles .......................................................................... 10
Figure 2.6 - Basic Solar angles on tangential plane ................................................... 12
Figure 2.7 - Basic Solar angles on tilted plane .......................................................... 13
Figure 2.8 - Various tracking surfaces ....................................................................... 14
Figure 2.9 - Layers and Temperature profile of the earth's atmosphere .................... 20
Figure 2.10 - Total atmospheric absorption at sea level ............................................ 22
Figure 2.11 - Rayleigh and Mie Scattering ................................................................ 23
Figure 2.12 - Beam, diffuse and ground reflected solar radiation ............................. 28
Figure 2.13 - Annual variations of Ground Albedo in China .................................... 47
Figure 3.1 - Variations of percentage variations of predicted diffuse radiation with
hourly clearness index ........................................................................... 60
Figure 3.2 - Variations of percentage variations of predicted diffuse radiation with
daily clearness index ............................................................................. 61
Figure 3.3 - Variations of Percentage variations of predicted diffuse radiation with
declination angle ..................................................................................... 62
Figure 4.1 - Annual average hourly diffuse insolation from isotropic models .......... 64
Figure 4.2 - Percentage variation of hourly diffuse insolation from isotropic models
bbbbbbbbbb ................................................................................................................ 65
Figure 4.3 - Annual average hourly diffuse insolation from anisotropic models ...... 66
Figure 4.4 - Percentage variation of hourly insolation from anisotropic models ...... 67
Figure 4.5 - Prediction of monthly averaged daily total diffuse tilted insolation ...... 69
Figure 4.6 - Percentage variations of predicted monthly averaged daily diffuse tilted
insolation ............................................................................................... 70
Figure 4.7 - Comparison of diffuse radiation models using statistical parameters .... 71
Page vii

Figure 4.8 - Normal probability plot of modified Perez model ................................. 73
Figure 4.9 - Residual plot of modified Perez model .................................................. 73
Figure 4.10 - Residual observation order of modified Perez model .......................... 74
Figure 4.11 - Histogram for modified Perez et al (1990) model ................................ 74
Figure 4.12 - Annually averaged hourly insolation ................................................... 76
Figure 4.13 - Monthly averaged hourly global horizontal insolation ....................... 77
Figure 4.14 -Monthly averaged hourly beam horizontal insolation.......................... 77
Figure 4.15 - Monthly averaged hourly diffuse horizontal insolation ...................... 78
Figure 4.16 - Monthly averaged hourly tilted insolation (at β = 7°) ......................... 78
Figure 4.17 - Monthly averaged hourly beam tilted insolation (at β = 7°) ............... 79
Figure 4.18 - Monthly averaged hourly diffuse tilted insolation (at β = 7°) ............. 79
Figure 4.19 - Monthly averaged hourly beam normal insolation ............................. 80
Figure 4.20 - Monthly averaged hourly clearness index ............................................ 81
Figure 4.21 - Monthly averaged daily insolation ....................................................... 82
Figure 4.22 - Variation of annual average daily insolation on tilted surfaces ........... 84
Figure 4.23 - Variation of monthly averaged daily global insolation on tilted surfaces
bbbbbbbbbbb .............................................................................................................. 85
Figure 4.24 - Variation of monthly averaged daily insolation on tilted surfaces for
January ................................................................................................. 86
Figure 4.25 - Variation of monthly averaged daily insolation on tilted surfaces for
February ............................................................................................... 86
Figure 4.26 - Variation of monthly averaged daily insolation on tilted surfaces for
March ................................................................................................... 87
Figure 4.27 - Variation of monthly averaged daily insolation on tilted surfaces for April
bbbbbbbbbbb .............................................................................................................. 87
Figure 4.28 - Variation of monthly averaged daily insolation on tilted surfaces for May
bbbbbbbbbbb .............................................................................................................. 88
Figure 4.29 - Variation of monthly averaged daily insolation on tilted surfaces for June
bbbbbbbbbbb .............................................................................................................. 88
Figure 4.30 - Variation of monthly averaged daily insolation on tilted surfaces for July
bbbbbbbbbbb .............................................................................................................. 89
Page viii

Figure 4.31 - Variation of monthly averaged daily insolation on tilted surfaces for
August ................................................................................................ 89
Figure 4.32 - Variation of monthly averaged daily insolation on tilted surfaces for
September .......................................................................................... 90
Figure 4.33 - Variation of monthly averaged daily insolation on tilted surfaces for
October ............................................................................................... 90
Figure 4.34 - Variation of monthly averaged daily insolation on tilted surfaces for
November ........................................................................................... 91
Figure 4.35 - Variation of monthly averaged daily insolation on tilted surfaces for
December ........................................................................................... 91
Figure 4.36 - Daily variation of optimum tilt angle ................................................... 93
Figure 4.37 - Monthly averaged daily maximum insolation and optimum tilt angle 94
Figure 4.38 - Percentage variations of Monthly averaged daily insolation with tracking
systems .................................................................................................. 96
Page ix

LIST OF TABLES
Page
Table 1.1 - Solar energy utilization in Sri Lanka ......................................................... 3
Table 2.1 - Day number and recommended average day for each month ................. 19
Table 2.2 - Hottlel correlations factors for different climate types ........................... 34
Table 2.3 - ASHRAE (1985) clear sky radiation model coefficients ........................ 36
Table 2.4 - Classification of the sky types according to the clearness index ............. 37
Table 2.5 - Perez et al brightness coefficients ........................................................... 53
Table 4.1 - Comparison of isotropic models using statistical parameters ................. 65
Table 4.2 - Comparison of anisotropic models using statistical parameters .............. 68
Table 4.3 - Comparison of modified Perez model using statistical parameters ......... 72
Table 4.4 - Modified Brightness coefficient of Perez et al ........................................ 72
Table 4.5 - Annually averaged hourly Insolation ...................................................... 75
Table 4.6 - Monthly averaged hourly clearness index K
T
....................................... 81
Table 4.7 - Monthly averaged daily insolation .......................................................... 83
Table 4.8 - Maximum monthly averaged insolation and optimum tilt angles ........... 92
Table 4.9 - Maximum solar resource potential with tracking (about E-W axis) systems
bbbbbbbbb .................................................................................................................. 95
Page x

LIST OF APPENDICESS
Appendix Description Page
Appendix A Monthly averaged hourly global horizontal insolation .................... 105
Appendix B Monthly averaged hourly beam horizontal insolation ..................... 106
Appendix C Monthly averaged hourly diffuse horizontal insolation ................... 107
Appendix D Monthly averaged hourly global tilted (β = 7°) insolation .............. 108
Appendix E Monthly averaged hourly beam tilted (β = 7°) insolation ................ 109
Appendix F Monthly averaged hourly diffuse tilted (β = 7°) insolation ............. 110
Appendix G Monthly averaged hourly beam normal insolation .......................... 111
Appendix H Monthly averaged daily global insolation ........................................ 112
Appendix I Monthly averaged daily beam insolation ......................................... 116
Appendix J Monthly averaged daily diffuse insolation....................................... 120
Page xi

LIST OF NOMENCLATURE
Roman Letters
A  =  Apparent solar irradiation at zero air mass, Anisotropy index, Altitude
of the location in kilometres, Apparent solar irradiation at zero air mass
| B  =   | Atmospheric extinction coefficient  |     |     |
| ------ | ----------------------------------- | --- | --- |
| C  =   | Diffuse radiation factor            |     |     |
| c   =  | Cloud cover index                   |     |     |
ω
| c̅̅̅  =  | Monthly averaged daily cloud cover index  |     |     |
| -------- | ----------------------------------------- | --- | --- |
ω
| F 1   =  | circumsolar brightness factor  |     |     |
| -------- | ------------------------------ | --- | --- |
| F   =    | horizon brightness factor      |     |     |
2
| F'  =  | Klucher’s modified clearness index                     |     |     |
| ------ | ------------------------------------------------------ | --- | --- |
| G  =   | Total scattered intensity, Total horizontal radiation  |     |     |
| G   =  | Incident intensity                                     |     |     |
0
| G   =  | Beam radiation on horizontal surface  |     |     |
| ------ | ------------------------------------- | --- | --- |
b
| G bn  =   | Beam normal radiation                    |     |     |
| --------- | ---------------------------------------- | --- | --- |
| G bt   =  | Beam radiation on tilted surface         |     |     |
| G   =     | Diffuse radiation on horizontal surface  |     |     |
d
| G   =  | Diffuse radiation on tilted surface   |     |     |
| ------ | ------------------------------------- | --- | --- |
dt
| G   =  | Ground reflected radiation on horizontal surface  |     |     |
| ------ | ------------------------------------------------- | --- | --- |
g
| G   =  | Ground reflected radiation on tilted surface   |     |     |
| ------ | ---------------------------------------------- | --- | --- |
gt
| G   =  | Extra-terrestrial radiation on horizontal surface  |     |     |
| ------ | -------------------------------------------------- | --- | --- |
o
| G on   =  | Extra-terrestrial normal radiation  |     |     |
| --------- | ----------------------------------- | --- | --- |
| G sc   =  | Solar Constant                      |     |     |
| G  =      | Total radiation on tilted surface   |     |     |
t
| G   =  | Monochromatic intensity at x=0  |     |     |
| ------ | ------------------------------- | --- | --- |
λ,0
| H  =   | Daily total horizontal radiation            |     |     |
| ------ | ------------------------------------------- | --- | --- |
| H   =  | Daily beam radiation on horizontal surface  |     |     |
b
| H =       | Daily beam normal radiation                    |     |     |
| --------- | ---------------------------------------------- | --- | --- |
| bn        |                                                |     |     |
| H bt   =  | Daily Beam radiation on tilted surface         |     |     |
| H d   =   | Daily diffuse radiation on horizontal surface  |     |     |
| H   =     | Daily diffuse radiation on tilted surface      |     |     |
dt
Page xii

H   =  Daily ground reflected radiation on horizontal surface
g
| H gt   =  | Daily ground reflected radiation on tilted surface       |     |
| --------- | -------------------------------------------------------- | --- |
| H o   =   | Daily extra-terrestrial radiation on horizontal surface  |     |
| H   =     | Daily Extra-terrestrial normal radiation                 |     |
on
| H  =  | Daily Total radiation on tilted surface  |     |
| ----- | ---------------------------------------- | --- |
t
| H̅  =  | Monthly averaged daily total horizontal radiation   |     |
| ------ | --------------------------------------------------- | --- |
H̅̅̅̅
=  Monthly averaged daily beam radiation on horizontal surface
b
H̅̅̅
| =   | Monthly averaged clear day radiation on horizontal surface  |     |
| --- | ----------------------------------------------------------- | --- |
c
| H̅̅̅̅̅ =  | Monthly averaged daily beam normal radiation |     |
| --------- | -------------------------------------------- | --- |
| bn        |                                              |     |
H̅̅̅̅̅  =  Monthly averaged daily Beam radiation on tilted surface
bt
H̅̅̅̅
=  Monthly averaged daily diffuse radiation on horizontal surface
d
H̅̅̅̅̅
| =   | Monthly averaged daily diffuse radiation on tilted surface   |     |
| --- | ------------------------------------------------------------ | --- |
dt
H̅̅̅̅  =  Monthly  averaged  daily  ground  reflected  radiation  on  horizontal
g
surface
H̅̅̅̅
=  Monthly averaged daily ground reflected radiation on tilted surface
gt
H̅̅̅̅
=  Monthly averaged daily extra-terrestrial radiation on horizontal surface
o
H̅̅̅̅̅
| =   | Monthly averaged daily Extra-terrestrial normal radiation  |     |
| --- | ---------------------------------------------------------- | --- |
on
H̅̅̅  =  Monthly averaged daily Total radiation on tilted surface
t
| I  =   | Hourly total horizontal radiation            |     |
| ------ | -------------------------------------------- | --- |
| I   =  | Hourly beam radiation on horizontal surface  |     |
b
| I =  | Hourly beam normal radiation |     |
| ---- | ---------------------------- | --- |
bn
| I bt   =  | Hourly Beam radiation on tilted surface         |     |
| --------- | ----------------------------------------------- | --- |
| I   =     | Hourly diffuse radiation on horizontal surface  |     |
d
| I   =  | Hourly diffuse radiation on tilted surface   |     |
| ------ | -------------------------------------------- | --- |
dt
I   =  Hourly ground reflected radiation on horizontal surface
g
| I   =  | Hourly ground reflected radiation on tilted surface   |     |
| ------ | ----------------------------------------------------- | --- |
gt
I   =  Hourly extra-terrestrial radiation on horizontal surface
o
| I   =  | Hourly Extra-terrestrial normal radiation  |     |
| ------ | ------------------------------------------ | --- |
on
| I  t =   | Hourly Total radiation on tilted surface   |     |
| -------- | ------------------------------------------ | --- |
| k T   =  | Hourly clearness index                     |     |
| K   =    | Daily clearness index                      |     |
T
Page xiii

K̅̅̅̅ = Monthly average daily cleanness index
T
K = Monochromatic extinction co-efficient
λ
L = Latitude angle
m = Air mass
h
n = Julian day of the year
r = Radius of the particle
r = Hourly beam radiation tilt factor
b
r = Diffuse radiation tilt factor
d
r = Daily global irradiance to hourly global irradiance conversion ratio
t
R = Distance between the molecule and the point of observation
R = Daily beam radiation tilt factor
b
R = Relative humidity
h
R̅̅̅̅ = Monthly averaged daily beam radiation tilt factor
b
R̅̅̅̅ = Monthly averaged daily relative humidity
h
S = Averaged hours of sunshine
S = Averaged maximum possible hours of sunshine
0
S̅ = Monthly averaged daily hours of sunshine
S̅̅̅ = Monthly averaged daily maximum possible hours of sunshine
0
t = Midpoint of the hour
T = Temperature
T = Daily maximum temperature
max
T = Daily maximum temperature
min
T̅ = Monthly averaged daily temperature
T̅̅̅̅̅̅ = Monthly averaged daily maximum temperature
max
T̅̅̅̅̅̅ = Monthly averaged daily maximum temperature
min
x = Size of the scattering particle
Greek Letters
α = Altitude angle, Polarisability of the particle
β = Tilt angle
γ = Solar azimuth angle
γ = Surface azimuth angle
p
Page xiv

Γ = Day angle
δ = Declination angle
Δ = Brightness
ε = Sky clearness
θ = Incident angle
θ = Zenith angle
z
λ = Wave length
ρ = Ground albedo
g
τ = Monochromatic transmittance
λ
ω = Hour angle
ω = Sunshine/sunset angle
s
ω = Sunrise angle on tilted surface
sr
ω = Sunset angle on tilted surface
ss
Page xv

LIST OF ABBREVIATIONS
Abbreviation Description
ASHRAE American Society of Heating, Refrigerating and Air-Conditioning
Engineers
AST Apparent Solar Time
LST Local Solar Time
PV Photovoltaic
SLSEA Sri Lanka Sustainable Energy Authority
WMO World Metrological Organization
Page xvi

1 INTRODUCTION
1.1 Background
Out of all renewable energy sources, solar energy is one of the most feasible sources
of sustainable energy. Solar energy is environment and nature friendly and does not
contribute in damaging the ecological system. Small scale solar systems are
practicable at remote areas where grid systems are not available and large scale thermal
systems are more beneficial with current energy and environment crisis. But major
design drawback is the unpredictable nature of solar irradiance. Existing Solar
radiation data are the best source of information for estimating the average incident
radiation required for the planning and evaluation of suitable solar energy systems.
Prediction of the availability of solar radiation is difficult, since its availability is
dependent on weather and climate conditions. The availability of complete data of
solar radiation is invaluable for planning and evaluation of conversion systems based
on solar energy.
There are different forms of data on solar radiation, which are suitable to be used for
variety of purposes in the design and development of solar energy systems. Often solar
radiation data are available as hourly, daily and monthly averaged daily data. Most of
the solar radiation models found in the literature for the estimation of radiation is
mainly based on the data collected at weather stations in the United States, Canada,
Australia and the countries of the northern Europe.
In Sri Lanka, the solar radiation databases for areas of interest are not readily available.
Sri Lanka Metrological Department recodes sunshine hours at few weather stations
and total radiation in Colombo station. Sri Lanka Sustainable Energy Authority
(SLSEA) recodes solar radiation data in Hambanthota solar park and Kilinochchi since
2011. These data can be used for deriving relevant solar radiation models to predict
the hourly, daily and averaged solar radiation availability of the dry zone in Sri Lanka.
Page 1

1.2 Present status of solar energy applications in Sri Lanka
SLSEA has been commissioned and operates Sri Lanka’s first solar power plant at
Hambanthota with the capacities of 500 kW and 737 kW since 2010 as pilot project
and these two plants has operated with annual plat factors of 17.69 and 17.91
respectively (Sri Lanka Energy Balence 2015, 2017). 10 MW solar plant at Welikanda
with single axis hourly tracking system (about north south axis) was commissioned in
December, 2016. A total of 39,312 solar photovoltaic modules has been installed in a
land extend of 19.95Ha in Welikanda having generation capacity of 23 GWH per
annum. (windforce, 2017). Another 10 MW solar plant at Hambanthota was
commissioned in December, 2016 without tracking system. A total of 48,000
polycrystalline solar panels with construction costs of 2.5 billion rupees has been
installed (Sri Lanka commissions 10MW solar power plant, 2017). Ceylon electricity
board has commissioned 60 kW hybrid power plat with solar, wind and diesel in
Eluwathivu island. With all these new addition Sri Lanka has total of 21.36 MW grid
connected solar system apart from net metering systems. Another solar photovoltaic
(PV) plants with total capacities of 50 MW is also under consideration.
Net metering in Sri Lanka which was introduced in 2010 has reached 30 MW with
4200 roof top installations providing approximately 38.8 GWh per annum to the
national grid by the end of 2015 (Sri Lanka Energy Balence 2015, 2017).
Since, the solar energy is mostly used in non-commercial forms, the total usage of
energy is not yet quantified properly. However, solar energy is the most frequently
used in day to day life and drying, heating and electricity production are the most
common uses of solar energy in the country. Solar energy utilization in Sri Lanka by
end of year 2015 is given in Table 1.1
Page 2

Table 1.1 - Solar energy utilization in Sri Lanka
Typical User Groups Typical Applications Scale of use by end 2012
Net-metering 4,200 installation
Solar photovoltaic
Household lighting About 120,000 units
Grid connected PV For sale to utility 4 power plants
Hot water systems
Solar Thermal (Commercial and widespread
domestic scale)
Household and
Informal use widespread
agricultural use
Source: (Sri Lanka Energy Balence 2015, 2017)
By the end of year 2015, it is generated 1.9 GWh of energy had been generated by 1.4
MW of installed capacity at three solar power plants. It is about 0.1% of the total non-
conventional renewable energy generation of year 2015 (Sri Lanka Energy Balence
2015, 2017).
1.3 Problem statement
Although the earth’s extra-terrestrial radiation is held at a constant about 1367 W/m2,
the amount of energy available in the terrestrial region is highly varied due to several
factors. The porous atmosphere around the earth is consists of various gases such as
CO , CO, O , N , O , atmospheric water vapour and dust. Due to the presence of these
2 3 2 2
components in the atmosphere, the amount of solar energy received by the earth
surface is reduced and due to the variation of these components from location to
location, the net amount of solar energy availability at the ground level is also varied
accordingly. There are two distinct models developed to assess the horizontal radiation
on the given surface called parametric models and decomposition models. Parametric
models asses the global horizontal radiation and decomposition models quantify the
amount of diffuse radiation on horizontal surface. But there are some site specific
parameters incorporated into those models which are needed to be derived by
performance measurements in the site in which the solar radiation is to be assessed.
However, in solar energy applications it is essential to estimate the solar radiation on
tilted surfaces to maximise the energy harnessing by using optimum tilt angels.
However, estimating of the diffuse radiation components on the tilted plane is
Page 3

complicated even though estimating of beam and ground components are straight
forward. Amount of the diffuse radiation is defend on the sky clouds pattern and there
are two distinct types of sky models available on literature called isotropic and
anisotropic to estimate the diffuse radiation components on tilted planes depend on the
nature of the sky. Isotropic models have been developed by assuming that intensity of
the sky diffuse radiation is uniform over the entire sky dome and anisotropic models
have been developed by dividing sky radiation component into three components as
circumsolar, sky dome and horizon brightening components. However, most of these
models are location based and has been developed by countries in temperate zone and
none of these models have validated with measured Sri Lankan solar radiation data.
Hence, solar resource availability estimations of Sri Lankan locations based these
models may not present the actual solar radiation potential in Sri Lanka. Therefore,
development of new model using measured data for Sri Lanka is important and such
model can be used in future for estimation of solar resource availability new solar
energy applications
1.4 Aim and objectives
The aim of this research is to identify best fit model/s to predict the availability of solar
radiation availability in the dry zone of Sri Lanka. Therefore, the objectives set for this
study are;
 Identify the different parameters affecting the Global Solar Radiation
 Identify the existing models to predict global solar radiation for different sky
conditions
 Identify most appropriate model(s) to estimate the global radiation for dry zone
 Develop new model (modify an existing model) for dry zone
 Estimate monthly and annually averaged hourly and daily global, beam and
diffuse horizontal solar resource potential in Dry zone of Sri Lanka
 Estimate monthly and annually averaged hourly and daily global, beam and
diffuse solar resource potential on tilted surface in Dry zone of Sri Lanka
 Estimate of monthly and annual optimum tilt angle for dry zone of Sri Lanka
Page 4

1.5 Outcomes
 Mathematical model to predict hourly diffuse radiation on tilted surface in dry
zone of Sri Lanka
 Estimation of monthly and annually averaged hourly and daily global, beam
and diffuse horizontal solar resource potential in Dry zone of Sri Lanka
 Estimation monthly and annually averaged hourly and daily global, beam and
diffuse solar resource potential on tilted surface in Dry zone of Sri Lanka
 Estimation of monthly and annual optimum tilt angle for dry zone of Sri Lanka
1.6 Scope of the study
The scope of this study is limited to analyse hourly radiation data on horizontal and
tilted surfaces in order to drive suitable diffuse radiation model for dry zone of Sri
Lanka. In addition to that, estimation of monthly and annually averaged hourly and
daily global, beam and diffuse radiation on both horizontal and tilted surfaces and
driving the annual, monthly and daily optimum surface tilt angles for dry zone of Sri
Lanka is presented as outcomes of this study.
1.7 Outline of the study
In the first chapter of this study, describes the solar energy utilization characteristics
of Sri Lanka and the potential for solar energy harnessing, particularly in dry zone.
The fundamentals of solar radiation are described in Chapter 2 which includes solar
geometry such as solar angles and sun earth angles, extra-terrestrial radiation,
terrestrial radiation and atmospheric attenuation. In addition to that basic formulas of
solar radiation on horizontal and tilted surfaces, parametric solar radiation models,
solar radiation decomposition models, solar insolation estimation methods on tilted
surfaces are also discussed in Chapter 2. The research methodology is described in
details in Chapter 3. The results of the study are discussed in Chapter 4 and finally
Chapter 5 is dedicated to present the findings and conclusions of this study.
Page 5

2 REVIEW OF THE LITRATURE
2.1 FUNDAMENTALS OF SOLAR RADIATION
2.1.1 The Sun and Earth
The sun is the star in our solar system. The sun is almost spherical with average
diameter of 1.393 × 109 m (about 109 times with respect to Erath) and mass of 1.989
× 1030 kg (330,000 times the Earth). It is believed that Sun formed 4.6 billion years
ago due to gravitational collapse of a molecular cloud. Sun is classified as G-type star
(G2V) where G2 stands for surface temperature (5777 K) and V stands for energy is
generated by nuclear fusion. Generated energy is transmitted to the earth by radiation.
The earth is an almost spherical planet with a diameter of 1.27 × 107 m. The average
period of rotation of the earth about its axis is 24 hours and average period of
revolution around the sun is 365.25 days. The mean distance between sun and earth is
known as one astronomical unit and equals to 1.495 ×1011 m. However, Earth’s orbit
is not symmetrical and estimated to have ± 1.7 % annual variation. Minimum distance
between sun and earth occurs at 21st of December and maximum distance occurs at 21st
of June. Therefore, earth receives 7% more radiant energy in December than in June.
However, the local climate of the earths is not only dependent on the mean distance
but also on the angle of the incidence solar radiation at the particular location.
Sun subtends only 0° 32' angle at earth surface due to the large distance between sun
and earth. Therefore, solar radiation at earth surface can be considered as parallel and
with a travelling speed of 3.8 ×108 ms-1 in the vacuum it takes 8 min and 20 seconds
to receive solar radiation by earth. Even though brightness of sun varies from its centre
to outside it is assumed that brightness is uniform with an energy output of 63 MW/m2
constituting a total energy output of 3.8 ×108 MW. The radiation outside the earth
atmosphere is known as extra-terrestrial radiation and within the atmosphere is known
as terrestrial radiation. The radiation received on the unit area of surface perpendicular
to the direction of the propagation of sun at one astronomic unit distance outside the
atmosphere is known as Solar Constant I and has value of 1367 W/m2. Figure 2.1
SC
shows relationship of sun and earth schematically.
Page 6

Sun
Earth
m
9
0
1
× 5777 K 0° 32' 1.27 × 107 m
3
9
3 .1 I sc = 1367 W/m2
1.495 × 1011 m
Figure 2.1 - The Sun-Earth relationship
(Source: Soteris, 2009)
2.2 Solar Geometry
Radiant energy received on earth surface from the sun varies with location, day of the
year, time of the day and other metrological conditions. However extra-terrestrial
radiation varies only with the location and time. Therefore, clear understanding on
solar geometry is necessary in the estimation of solar energy. The earth’s rotation axis
is 23.45° inclined to the ecliptic axis which is normal to the ecliptic plane. Earth transits
through the orbit keeping this inclined angle constant throughout the year. This result
the changes in relative distance on a point on the earth’s surface with respect to the
sun. Figure 2.2 shows the relative position of the earth on 21st of June and 21st of
December. Radiation incident angle on southern hemisphere in June and northern
hemisphere in December is lower than to northern hemisphere in June and southern
hemisphere in December. Further, Arctic circle in June and Antarctic circle in
December receive 24 hours sun rays while Antarctic circle in June and Arctic circle in
December doesn’t receive at all. This variation of the solar incident angle on earth
leads to make seasonal climatic variation on earth.
Page 7

June 21st December 21st
Figure 2.2 - Relative position of the earth on 21st of June and 21st of December
(Source: “The Sun as a Source of energy: Part 1: Solar Astronomy”. n.d.)
The earth’s surface has been divided in to five climatic zones due to climatic effects
caused by its tilt angle. The zone between the latitudes of 23.45° either sides of equator
is known as tropical zone where the sun is overhead at least once a year. The zones
between latitudes of 23.45° to 66.55° (90°-23.45°) in both hemispheres are known as
temperate zones where the sun appears above the horizon each day. The zones beyond
the 66.55° in both hemispheres are known as frigid zones where the sun appears
below/above at least one full day.
2.2.1 Sun-Earth angles
In order to identify the position of the point on earth’s surface three basic sun earth
angles have been defined as declination angle δ, Latitude angle L and hour angle ω.
Angle between solar radiation and earth’s rotational axis varies from -23.45° to
+23.45° throughout the year and this angle is known as solar declination angle δ. The
earth’s axis is tilted towards (north pole towards the sun and south pole outwards the
sun) the sun on the 21st of June making +23.45° declination angle and tilted away
(north pole outwards the sun and south pole towards the sun) the sun on the 21st of
December making -23.45° declination angle. Figure 2.3 shows schematic
representation of earth’s orbit and declination angles in equinoxes and solstices.
Page 8

March 21
δ = 0°
Vernal Equinox δ = -23.45°
December 21
δ = +23.45° Winter Solstice
September 21
Autumnal Equinox
June 21
δ = 0°
Summer Solstice
Figure 2.3 - Declination angles in equinoxes and solstices
This cyclic variation of solar declination causes seasonal weather changes in the earth.
Even though solar declination angle varies all over the time it can be considered as
constant during any given day for engineering calculations. Equation suggested by
Cooper in 1969 for calculating declination angle is given in Equation 2.1.
284+n
δ = 23.45sin[360×( )] 2.1
365
Where,
n : Julian day of year
Another equation called Spencer formula was introduced by Spencer in 1971 to
calculate the declination angle which is given in Equation 2.2
180
δ = (0.006918−0.399912cosΓ+0.070257sinΓ
π
2.2
−0.006758cos2Γ
+0.000907sin2Γ−0.002697cos3Γ+0.00148sin3Γ)
Where,
Γ : day angle given in Equation 2.3
360(n−1)
Γ = 2.3
365
However, American Society of Heating, Refrigerating and Air-Conditioning
Engineers ASHRAE in 2007 recommended Cooper (1969) equation to calculate
Declination angle. Variation of the declination angle throughout the year is shown in
Figure 2.4 which is calculated using cooper (1969) equation.
Page 9

Variation of the declination angle
e 23.45°
| lg  |          |     | June 21           | September 21 |     |
| --- | -------- | --- | ----------------- | ------------ | --- |
| n   | March 21 |     | (Summer Solstice) |              |     |
| A   |          |     |                   | (Autumnal    |     |
 n
|     | (Vernal equinox) |     |     | equinox) |     |
| --- | ---------------- | --- | --- | -------- | --- |
o 0.00°
| it  |             | May |         | Aug     |         |
| --- | ----------- | --- | ------- | ------- | ------- |
| a   | Jan Feb Mar | Apr | Jun Jul | Sep Oct | Nov Dec |
n
| ilc |     |     |     |     | December 21       |
| --- | --- | --- | --- | --- | ----------------- |
| e   |     |     |     |     | (Winter Solstice) |
D
-23.45°
Day of the year

Figure 2.4 - Variation of the declination angle
Solar radiation receiving angle of the any point of the earth is varying on the position
of the point in earth. Any point of the earth can be described using latitude L and
longitude angle of the point. Latitude describes the angle between point on the earth’s
surface and the equatorial plane. Rotational speed of the earth is 15° per hour and hour
angle ω defined as angle which earth has to rotate to bring meridian plane of any point
to face the sun. Figure 2.5 describes the latitude angle L, hour angle ω and declination
angle δ for a point P on the northern hemisphere.
23.45°
N

Sun’s Rays
P
|     | Equator  |     |     |     |     |
| --- | -------- | --- | --- | --- | --- |

L
ω
δ

Figure 2.5 - Basic Sun-Earth angles
Value of the hour angle at solar noon is considered as zero. Therefore, value of the
hour angle indicates the time of the day with respect to the solar noon. As convention
morning hour angles are considered as negative and afternoon angles are considered
as positive.
Page 10

2.2.2 Solar angles
The solar angles are defined with respect to an observer on a tangential plane at a given
point on the earth’s surface. These solar angles are derived using basic sun earth
angles. There are three basic solar angles called zenith angle θ , Altitude angle α and
z
solar azimuth angle γ. In addition to those three, additional two angles have been
introduced for a tilted surface as incident angle θ and surface azimuth angle γ .
p
The zenith angle θ is defined as angle of incident of solar radiation on the tangential
z
plane at a point on the earth. Altitude angle α is the angle between the solar radiation
incident and its projection on the earth. Altitude angle goes from 0° at sunrise through
a maximum value at solar noon and again to 0° at sunset. Negative altitude angle
indicates that sun is below the horizon. The negative altitude angles are used in
defining on twilights which indicate the time period between complete darkness to
sunrise in the morning and sunset to complete darkness in evening. Morning twilight
is defined as the time period between altitude angle of -18° to 0° in morning and
evening twilight is defined as altitude angle of 0° to -18° in evening. Twilights are
again dived into tree periods as civil twilight (altitude angle -6° to 0°), nautical twilight
(altitude angle -12° to -6°) and astronomical twilight (altitude angle -18° to -12°). The
altitude angle and zenith angle are complementary by its definition. Therefore, altitude
angle could be expressed as Equation 2.4,
π
θ +α = 2.4
z 2
Solar azimuth angle γ is the angle on the tangential plane between the direction of due
south and the projection of the solar rays on the plane. Eastwards values of azimuth
are considered as negative as convention. Figure 2.6 shows the definition of zenith
angle, altitude angle and solar azimuth angle with reference to the tangential plane.
Page 11

W
Sun
γ
θ
z
N
α
γ
S
E
Figure 2.6 - Basic Solar angles on tangential plane
Zenith angle, altitude angle and solar azimuth angle are varies with the time and
location of the earth surface. The zenith angle could be calculated using Equation 2.5
and altitude angle can be calculated using Equation 2.6 for a given solar time and
location.
cosθ = cosδcosωcosL+sinδsinL 2.5
z
sinα = cosδcosωcosL+sinδsinL 2.6
Solar azimuth angle could be calculated using Equation 2.7 for a given solar time and
location.
cosδsinω
sinγ = 2.7
cosα
tan𝛿
for cos𝜔 >
tan𝐿
If not, the sun is behind the east-west line and azimuth angle is –π+|γ| for the morning
hours and π-γ for evening hours.
Value of the altitude angle is zero at the sunshine and sunset. Therefore, hour angle at
sunshine and sunset known as sunshine/sunset angle ω could be calculated Equating
s
altitude angle to zero of Equations 2.5 and 2.6.
cosω = −tanδtanL 2.8
s
Page 12

Day length is the duration from sunshine to sunset. So that day length could be
expressed using Equation 2.9.
2
Day length = cos−1(−tanδtanL) 2.9
15
The incident angle θ is defined as the angle measured on the tilted surface between the
solar rays and the normal to the tilted surface. For the tilted surfaces, tilt angle β is
defined as angle of the surface to the tangential plane of location and surface azimuth
angle γ is defined as angle measured on the tangential plane between the projection
p
of normal to surface and due south. Figure 2.7 illustrates the incident angle, surface
azimuth angle and tilt angle in the zenith system.
Sun
E
θ
β
N
α
γ
p
S
γ
W
Figure 2.7 - Basic Solar angles on tilted plane
Incident angle could be calculated using Equation 2.10
cosθ = sinLsinδcosβ−cosLsinδsinβcosγ
p
+cosLcosδcosωcosβ+sinLcosδcosωsinβcosγ 2.10
p
+cosδsinωsinβsinγ
p
Similar to the sunrise/sunset angle on horizontal surface sunrise/sunset angle on tilted
surface ω could be expressed using Equation 2.11
ss
ω = min{ω ,cos−1[−tan(L−β)tanδ]} 2.11
ss s
Page 13

2.2.3 Angles for tracking surfaces
Some solar collector systems track the sun by different ways to minimize the angle of
incidence thus to maximise the energy intensity of the collector. The tracking systems
are classified according their movement as single axis and two axes. Single axis
tracking systems are classified as East-West axis tracking, North-South axis tracking
or parallel to the earth’s axis. Various types of tracking systems are shown in Figure
2.8.
Figure 2.8 - Various tracking surfaces
(Source: Soteris, 2009)
Full tracking
In two axes tracking surface is kept to face the sun all time. Therefore, incident angle
is always zero for the two axis tracking systems. Tilt angle is always equal to the solar
zenith angle and surface azimuth angle is equal to the solar azimuth angle.
Therefore, Equations 2.12 to 2.14 are applicable to two axis tracking systems.
cosθ = 0 2.12
β = θ 2.13
z
γ = γ 2.14
p
Tilted North-South axis tracking with daily adjusted tilt angle
For a surface moved about north-south axis with a single daily adjusted tilt angle i.e.
plane is normal to direction of propagation at solar noon, incident angle could be
expressed using Meinel and Meinel (1976) relationship given in Equation 2.15
cosθ = sin2δ+cos2δcosω 2.15
Tilt angle of this type of surface is fixed for each day and could be calculated using
Equation 2.16.
β = |L−δ| 2.16
Page 14

Surface azimuth angle of this type of tracking surface for day will be 0° or 180° as
given in Equation 2.17.
|     |     |     | 0°         if  (L−δ) |     |     | > 0 |     |       |
| --- | --- | --- | -------------------- | --- | --- | --- | --- | ----- |
|     |     | γ = | {                    |     |     |     |     | 2.17  |
p
180°      otherwise
Polar north-south axis with east-west axis tracking
Incident angle for the surface that tracks the sun continuously about an axis parallel to
the earth’s axis of rotation (polar axis) is given in Equation 2.18
|     |     |     | cosθ | =   | cosδ  |     |     |       |
| --- | --- | --- | ---- | --- | ----- | --- | --- | ----- |
|     |     |     |      |     |       |     |     | 2.18  |
Tilt angle of this surface varies continually and can be calculated using Equation 2.19
and surface azimuth angle can be calculated using Equation 2.20.
tanL
|     |     |     | tanβ | =   |     |     |     | 2.19  |
| --- | --- | --- | ---- | --- | --- | --- | --- | ----- |
cosγ
p
sinθ sinγ
|     |     | tan−1( |           | z   |        |     |     | 2.20  |
| --- | --- | ------ | --------- | --- | ------ | --- | --- | ----- |
|     |     | γ =    |           |     | )+180C | C   |     |       |
|     |     | p      | cosθ′sinL |     |        | 1   | 2   |       |
Where,
|     | cosθ′ | =   | cosθ | cosL+sinθ |           | sinLcosγ  |     | 2.21  |
| --- | ----- | --- | ---- | --------- | --------- | --------- | --- | ----- |
|     |       |     | z    |           | z         |           |     |       |
|     |       |     |      |           | sinθ sinγ |           |     |       |
z
|     |     | 0          if (tan−1 |     |     |           | )γ ≥ | 0   |       |
| --- | --- | -------------------- | --- | --- | --------- | ---- | --- | ----- |
|     | C   | = {                  |     |     |           |      |     | 2.22  |
|     | 1   |                      |     |     | cosθ′sinL |      |     |       |
+1     otherwise
|     |     |     | +1          if γ |     | ≥ 0        |     |     |       |
| --- | --- | --- | ---------------- | --- | ---------- | --- | --- | ----- |
|     |     | C   | = {              |     |            |     |     | 2.23  |
2
−1         otherwise
Horizontal east-west axis with north-south axis tracking
Incident angle for the surface that tracks the sun continuously about horizontal east-
west axis can be calculated using Kreith and Kreider (1978) relationship given in
Equation 2.24.
1⁄
|     |     | cosθ | = (1−cos2δsin2ω) |     |     | 2   |     | 2.24  |
| --- | --- | ---- | ---------------- | --- | --- | --- | --- | ----- |
Tilt angle of this kind of tracking surface is given by Equation 2.25.
|     |     |     | tanβ = | tanθ | |cosγ|  |     |     | 2.25  |
| --- | --- | --- | ------ | ---- | ------- | --- | --- | ----- |
z
Surface azimuth angle of this type of tracking surface for day will be 0° or 180° as
given in Equation 2.26.
|     |     |     | 0°         if  |γ| |     | <   | 90  |     |       |
| --- | --- | --- | ------------------ | --- | --- | --- | --- | ----- |
|     |     | γ   | = {                |     |     |     |     | 2.26  |
p
180°      otherwise
Page 15

Horizontal north-south axis with east-west axis tracking
Incident angle for the surface that tracks the sun continuously about horizontal north
south axis could be calculated using Kreith and Kreider (1978) relationship as given
in Equation 2.27.
|     |      | (cos2θ | +cos2δsin2ω) | 1⁄  | 2.27  |
| --- | ---- | ------ | ------------ | --- | ----- |
|     | cosθ | =      |              | 2   |       |
z
Tilt angle of this kind of tracking surface is given by Equation 2.28.
|     | tanβ | = tanθ | |cos(𝛾 −γ)|  |     | 2.28  |
| --- | ---- | ------ | ------------ | --- | ----- |
z 𝑝
Surface azimuth angle of this type of tracking surface for day will be 90° or -90° as
given in Equation 2.29.
|     |     |       | 90°         if  γ | > 0 |       |
| --- | --- | ----- | ----------------- | --- | ----- |
|     |     | γ = { |                   |     | 2.29  |
p −90°      otherwise
2.3  Reckoning of time
In solar time, the time Sun crosses the meridian of the observer is considered as solar
noon. Solar energy calculations are based on this solar time and normally it is known
as Apparent Solar Time (AST). This AST usually does not match with the Local
Standard Time (LST). The orbital velocity of the Erath’s is varying around the year
and does not uniform. Therefore, AST is slightly varying with compared to the
uniformly running clock. This variation of the AST is known as Equation of Time (ET)
and it is arising due to variation of the length of the day around the year against mean
length of 24 hours.  The ET in minute could be calculated using Equation 2.30.
|     | ET = 9.87sin(2B)−7.53cos(B)−1.5sin(B)  |     |     |     | 2.30  |
| --- | -------------------------------------- | --- | --- | --- | ----- |
Where,
360
|     |     |     |        |     | 2.31  |
| --- | --- | --- | ------ | --- | ----- |
|     |     | B = | (n−81) |     |       |
364
The LST of an Earth’s point is based on the centre meridian of the observer’s time
zone. Therefore, difference between observer’s actual longitude and meridian of the
time  zone  should  be  considered  when  calculating  the  AST.  The  AST  could  be
calculated using Equation 2.32 for a given location.
|     | AST | = LST+ET+4(SL−LL)−DS  |     |     | 2.32  |
| --- | --- | --------------------- | --- | --- | ----- |
Where,
| SL  :  Standard Longitude  |     |     |     |     |     |
| -------------------------- | --- | --- | --- | --- | --- |
| LL  :   Local Longitude    |     |     |     |     |     |
| DS  :  Daylight Saving     |     |     |     |     |     |
Page 16

2.4 Extra-terrestrial and Terrestrial Solar Radiation
2.4.1 Definitions
Beam (direct) Radiation
The solar radiation received to any point, without having been scattered or reflected
by the atmosphere is known as beam radiation or direct radiation.
Diffuse (sky) radiation
The solar radiation received to any point, after scattered by the atmosphere is known
as diffuse or sky radiation.
Ground Reflected radiation
The solar radiation received to any point, after reflection by the ground surface or
nearby mountains, buildings etc. is known as ground reflected radiation.
Global (total) radiation
The sum of the beam, beam and ground reflected radiation is known as global or total
radiation.
Irradiance
The rate of the radiant energy incident on a unit area of a surface is known as
Irradiance. The symbol G is used for solar irradiance and measured by W/m2.
Irradiation/Radiant Exposure
The amount of incident radiant energy per unit surface over the specified time period
is known as Irradiance or radiant exposure.
Insolation
Usually solar irradiance is known as Insolation. The symbol I is used for an hour and
H is used for a day. In addition to that symbol H̅ is used for monthly averaged daily
insolation values.
In conjunction with above symbols G, H,H̅ and I subscripts o, b, d, g, n, t are used.
Subscript o is used for the extra-terrestrial radiation. Subscripts b, d, g, are used for
beam (direct), diffuse (sky) and ground reflected radiation respectively. Subscripts n
Page 17

and t are used for radiation on plane normal to direction of propagation and radiation
on tilted planes. If neither t nor n specified it implies that terms are for the horizontal
surface.
2.4.2  Extra-terrestrial solar radiation
The solar radiation at the entrance to the earth’s atmosphere, i.e. outside the earth
atmosphere  is  known  as  extra-terrestrial  solar  radiation.  The  intensity  of  extra-
terrestrial radiation is varying throughout the year due to variation of sun earth
distance. The extra-terrestrial radiation at a plane normal to the solar rays at mean sun
earth distance is known as Solar Constant G  and value is adapted to 1367 W/m2.
sc
Spencer (1971) introduced mathematical equation to calculate Intensity of the extra-
terrestrial radiation G on a plane normal to the soar rays on the nth day of the year
on
using solar constant which is expressed in Equation is 2.33.
360n
|     |     | G = | G [1+0.033cos( | )]  | 2.33  |
| --- | --- | --- | -------------- | --- | ----- |
|     |     | on  | sc             |     |       |
365
Extra-terrestrial radiation on given day could be calculated with reasonable accuracy
using Equation 2.33. More accurate equation introduced by Iqbal (1983) is given by
the Equation 2.34.
|     | G = G |  (1.000110+0.034221cosΓ+0.001280sinΓ |     |     |       |
| --- | ----- | ------------------------------------ | --- | --- | ----- |
|     | on    | sc                                   |     |     |       |
|     |       |                                      |     |     | 2.34  |
+0.000719cos2Γ+0.000077sin2Γ)
Where,
| Γ   | :   | day angle given by equation 2.3  |     |     |     |
| --- | --- | -------------------------------- | --- | --- | --- |
However, in most engineering calculations Equation 2.33 is used to calculate the extra-
terrestrial radiation in a given day.
The extra-terrestrial radiation on horizontal surface G  (plane parallel to the earth
o
surface) could be calculated using extra-terrestrial normal radiation G and zenith
on
| angle θ which is expressed in Equations 2.35.  |     |     |     |     |     |
| ---------------------------------------------- | --- | --- | --- | --- | --- |
z
|     |     |     | G = G cosθ |     | 2.35  |
| --- | --- | --- | ---------- | --- | ----- |
|     |     |     | o on       | z   |       |
G o  could be expressed using equations 2.5, 2.33 and 2.35 as Equation 2.36.
360n
|     | G = G [1+0.033cos( |     | )](cosδcosωcosL+sinδsinL)  |     | 2.36  |
| --- | ------------------ | --- | -------------------------- | --- | ----- |
o sc
365
Page 18

Extra-terrestrial insolation values could be fined by integration equation 2.36 over the
period of time which is expressed in equation 2.37.
|     | ω2  |     | ω2  |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
360n
|     | ∫   | G = ∫ | G   | [1+0.033cos( |     |     | )](cosδcosωcosL |     |     |     |
| --- | --- | ----- | --- | ------------ | --- | --- | --------------- | --- | --- | --- |
|     |     | o     | sc  |              |     |     |                 |     |     |     |
365
|     | ω1  |     | ω1  |     |     |     |     |     |     | 2.37  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----- |
+sinδsinL) dω
Result is given in equation 2.35.
|     |     |     | 12×3600×G |     |     |     | 360n |     |     |     |
| --- | --- | --- | --------- | --- | --- | --- | ---- | --- | --- | --- |
sc
|     |     | I = |     |                 | [1+0.033cos( |            |       | )]  |     |       |
| --- | --- | --- | --- | --------------- | ------------ | ---------- | ----- | --- | --- | ----- |
|     |     | o   |     | π               |              |            | 365   |     |     |       |
|     |     |     |     | ×[cosLcosδ(sinω |              |            | −sinω | )   |     | 2.38  |
|     |     |     |     |                 |              |            | 2     | 1   |     |       |
|     |     |     |     | π(ω             | −ω           | )          |       |     |     |       |
|     |     |     |     |                 | 2            | 1          |       |     |     |       |
|     |     |     |     | +               |              | sinLsinδ]  |       |     |     |       |
180
Daily extra-terrestrial insolation values could be obtained by substitution of sunshine
angle and sunset angle to equation 2.38. Resulting equation is given in 2.39
|     |     | 24×3600×G |     |     |              |     | 360n |     |     |     |
| --- | --- | --------- | --- | --- | ------------ | --- | ---- | --- | --- | --- |
|     |     | H =       |     | sc  | [1+0.033cos( |     |      | )]  |     |     |
o
|     |     |     | π   |     |     |     | 365 |     |     | 2.39  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----- |
πω
s
|     |     |     | ×[cosLcosδsinω |     |     | +(  | )sinLsinδ]  |     |     |     |
| --- | --- | --- | -------------- | --- | --- | --- | ----------- | --- | --- | --- |
|     |     |     |                |     |     | s   | 180         |     |     |     |
Monthly averaged daily extra-terrestrial values H̅̅̅̅ could be calculated using mean day
o
of each month. Recommended mean dates of each month which are given in Table 2.1.
Table 2.1 - Day number and recommended average day for each month
Average day of the month
Month  Day number  Julian day of the year  Declination angle
Date
|            |     |         |     |     |     | n    |     |     | δ (°)   |     |
| ---------- | --- | ------- | --- | --- | --- | ---- | --- | --- | ------- | --- |
| January    |     |         | i   | 17  |     | 17   |     |     | -20.92  |     |
| February   |     | 31 +i   |     | 16  |     | 47   |     |     | -12.95  |     |
| March      |     | 59 +i   |     | 16  |     | 75   |     |     | -2.42   |     |
| April      |     | 90 +i   |     | 15  |     | 105  |     |     | 9.41    |     |
| May        |     | 120 +i  |     | 15  |     | 135  |     |     | 18.79   |     |
| June       |     | 151 +i  |     | 11  |     | 162  |     |     | 23.09   |     |
| July       |     | 181 +i  |     | 17  |     | 198  |     |     | 21.18   |     |
| August     |     | 212 +i  |     | 16  |     | 228  |     |     | 13.45   |     |
| September  |     | 243 +i  |     | 15  |     | 258  |     |     | 2.22    |     |
| October    |     | 273 +i  |     | 15  |     | 288  |     |     | -9.60   |     |
| November   |     | 304 +i  |     | 14  |     | 318  |     |     | -18.91  |     |
| December   |     | 334 +i  |     | 10  |     | 344  |     |     | -23.05  |     |
Page 19

2.4.3 Earth’s Atmosphere
The atmosphere of the Earth is an envelope of several air layers containing various
gaseous, dust, liquid and solid particulate matter and clouds covering entire surface of
earth. The earth’s atmosphere extends about 9600 km from the earth surface and these
gaseous layers are attracted to earth due to gravitational force of earth. The structure
of atmosphere consists with five main layers and four transition layers in between. The
density of the atmosphere rapidly decreases with altitude and temperature varies
according to the layer. Figure 2.9 (a) describes the various layers of the earth’s
atmosphere and Figure 2.9 (b) shows the temperature profile of the atmosphere.
a. Source: Team ESRL Web, 2008) b. (Source: “Layers of Earth's Atmosphere”, n.d.)
Figure 2.9 - Layers and Temperature profile of the earth's atmosphere
The troposphere is the lowest layer of the atmosphere and its thickness varies with the
latitude and season. The troposphere begins at the earth’s surface and extends up to 17
km at equator and 7 km at poles. Temperature decreases within the troposphere with
altitude at 6.5 °C gradient for 1 km altitude. The troposphere contains most of the water
vapour and wind motion which influence significantly weather occurrences. The
tropopause is the transition layer between the troposphere and stratosphere.
Temperature of the thin tropopause layer remain constant with the altitude and it act
as the upper limit of weather occurrences. The stratosphere extends up to 48 km from
the tropopause and temperature keep constant at lower part. Temperature increases
with altitude in upper part of the stratosphere, finally reaches up to 7 °C at the top the
Page 20

stratosphere. The atmospheric ozone layer is concentrated between 19 km and 30 km
in the stratosphere. The stratopause is a thin transition layer between stratosphere and
mesosphere. The mesosphere extends up to 80 km from stratopause and temperature
decrease with altitude within the mesosphere finally reduces to -100 °C. Radio waves
reflected concentrated electron layer (Dlayer) could be found at 70 km altitude.
Mesopause is the transition layer between mesosphere and thermosphere.
Thermosphere extends up to 500-1000 km altitude depend on location session from
mesopause. Temperature remains constant in this layer up to 90 km and then increases
with altitude finally reach up to 1800 °C. The ionosphere is located within the
thermosphere. Thermopause is the transition layer between thermosphere and
exosphere. Exosphere is the upper most layer of the earth’s atmosphere and it gradually
fades to space with altitude. The average pressure and temperature at mean sea level
are 101325 Pa and 15 °C respectively. Total atmospheric mass is about 5.148 × 1018
and density at mean sea level is 1.2 kg/m3.
2.4.4 Atmospheric attenuation
The atmospheric attenuation of solar radiation occurs due to scattering and absorption
from gas molecules and other substances contain in the earth’s atmosphere. Solar
radiation that passed through earth’s atmosphere undergoes some degree of absorption
by gasses, water vapour and other substances particles. There are two mechanism of
absorption. One type occurs due to absorption by electrons in molecules which caused
narrow absorption lines. Other type occurs due to rotational-vibrations transition of
molecules which caused broad absorption band.
Absorption phenomena depend on the wave length λ of the solar rays. Gasses in
ionosphere like nitrogen (N ) and oxygen (O ) absorbs most amounts of x-rays and
2 2
ultraviolet radiation contain in solar rays. Ozone (O ) and water vapour (H O) absorbs
3 2
ultraviolet (λ < 0.40 μm) radiations and infrared radiations (λ > 2.3 μm). In addition to
that there is complete absorption of radiation below 0.29 μm wave lengths. Therefore,
solar radiation received at earth’s surface is almost between 0.29 μm and 2.3 μm.
Figure 2.10 (a) shows the total atmospheric absorption at sea level and figure 2.10 (b)
describes absorption from different type of gas molecules.
Page 21

a. (Source: “Geo Appendix A”, n.d.) b. (Source: “ATMS 101 Summer 2003”, n.d.)
Figure 2.10 - Total atmospheric absorption at sea level
Redirection of solar rays from its original direction of propagation due to interactions
with molecules and substance particles is known as solar radiation scattering. The
atmospheric scattering phenomenon is a function of wave length λ of the solar rays
and size of the interactive particles. Redistribution pattern of the incident solar
radiation depends on the ratio between particle size and wave length. The scattering
pattern is symmetrical along the propagation axis when particle is isotropic. Small
particles compared to the wave length scatter almost equal to both forward and
backward directions and forward direction percentage increases with the increasing of
particle size compared to the wave length. Size of the scattering particle is expressed
as non-dimensional parameter x shown in Equation 2.40.
2πr
x = 2.40
λ
Where,
r : radius of the particle
λ : wave length
Scattering from the relatively smaller scatters (x<< 1) is equally distributed in both
forward and backward directions and phenomena is known as Rayleigh scattering. In
Rayleigh scattering, scattered intensity is inversely proportional to the fourth power of
wave length. Smaller particles cause scattering than larger particles do. The total
scattered intensity of un-polarised solar radiation could be calculated using Equation
2.41.
Page 22

41+cos2θ
|     | G     | 2π  |     |       |
| --- | ----- | --- | --- | ----- |
|     | o α2( |     |     | 2.41  |
|     | G =   | )   |     |       |
|     | R2    | λ 2 |     |       |
Where,
G  :  Total scattered intensity of un-polarised solar radiation incident
on a molecule in the direction θ
| G :  Incident intensity  |     |     |     |     |
| ------------------------ | --- | --- | --- | --- |
o
| α  :  Polarisability of the particle  |     |     |     |     |
| ------------------------------------- | --- | --- | --- | --- |
R  :  Distance between the molecule and the point of observation
| λ  :  Wave length of the incident radiation  |     |     |     |     |
| -------------------------------------------- | --- | --- | --- | --- |
A larger portion of the solar energy belonging to visible spectrum blue colour is highly
scattered according to the theory of Rayleigh scattering. This higher scattering of blue
light is caused to appear sky as blue when viewed from distance. For relatively larger
particles, more energy is scattered in forward direction and phenomena is known as
mie  scattering. Mie scattering intensity is  inversely proportional  to the  λ4 to  λ0
depending upon the size of particles. Distribution pattern of both Rayleigh and Mie
scattering are shown in Figure 2.11 (a) and relationship between the particle size and
wavelength is shown in Figure 2.11 (b).

a.  (Source: “Blue Sky”, 2014)  b.  (Source: “Geo Appendix A”, n.d.)
Figure 2.11 - Rayleigh and Mie Scattering
In both Rayleigh and Mie scattering, scattered radiation has same wave length as
incident wave length and that type of scattering is known as elastic scatter. Almost half
of the scattered radiation is emitted back to the space and other part is directed to
earth’s surface from all around the sky. Scattering of radiation due to dust particles and
Page 23

water vapour varies location to location. Part of the received solar energy is absorbed
by the atmosphere while another part is scattered and remaining part is received to
earth’s surface as beam radiation. Therefore, earth’s surface receives two components
of radiation as beam radiation and diffuse radiation. Part of the received radiation
reflects back to the atmospheric by earth’s surface. In the cloudy atmosphere, clouds
also reflect part of the radiation back to the space.  Fraction sum of these reflected parts
to space and total scattered radiation to space is known as albedo of the earth. Earths
atmospheric albedo could be considered as 0.3 when consider earth as a whole.
Thickness of the atmosphere which solar radiation passes through is another important
parameter in the attenuation. Ratio between the vertical path and optical path length is
known as Air mass m . Equation 2.42 could be used to calculate Air mass m  using
|                | h   |     |     |     | h   |
| -------------- | --- | --- | --- | --- | --- |
| zenith angle θ | .   |     |     |     |     |
z
1
|     |     | m = |      |     | 2.42  |
| --- | --- | --- | ---- | --- | ----- |
|     |     | h   | cosθ |     |       |
z
Equation 2.39 is reasonably accurate up to 70° zenith angles. Kasten and Young (1989)
introduced more accurate model to predict air mass towards horizon. Equation 2.43 is
the model introduced by Kasten and Young.
1
|     | m = |     |     |     | 2.43  |
| --- | --- | --- | --- | --- | ----- |
h
|     | cosθ | +0.50572(96.07995−θ | )−1.6364 |     |     |
| --- | ---- | ------------------- | -------- | --- | --- |
z z
Diminution of solar radiation intensity within the solar radiation could be explained
using Bouger’s law. Bouger’s law assumes the attenuation is proportional to the local
intensity  of  transferring  media.  Equation  2.44  represents  the  bouger’s  law
mathematically.
|     |     |         |          |     | 2.44  |
| --- | --- | ------- | -------- | --- | ----- |
|     |     | −dG = G | (x)K 𝑑𝑥  |     |       |
|     |     | λ       | λ λ      |     |       |
Where,
| G (x)  | :  monochromatic intensity  |     |     |     |     |
| ------ | --------------------------- | --- | --- | --- | --- |
λ
| K   | :  monochromatic extinction co-efficient of the medium  |     |     |     |     |
| --- | ------------------------------------------------------- | --- | --- | --- | --- |
λ
Equation 2.38 could be integrated to find out intensity G λ  (L) after traveling through
L in the medium and results is expressed in Equation 2.45
|     |     | G (L) = | G e−K L  |     | 2.45  |
| --- | --- | ------- | -------- | --- | ----- |
λ
|     |     | λ   | λ,o |     |     |
| --- | --- | --- | --- | --- | --- |
Page 24

Where,
G : monochromatic intensity at x = 0
λ,0
Monochromatic transmittance τ is defined as ratio of the intensities after traveling
λ
though the medium and before entering the medium. The mathematical expression is
given by Equation 2.46.
G (L)
τ = λ = e−K λ L 2.46
λ G
λ,o
The extinction coefficient K is a property of the atmosphere and depends on the
λ
absorption, emission, scattering and diffraction of the molecules and substances
particles of the medium.
2.4.5 Terrestrial Solar Radiation
Solar radiation received on earth’s surface is known as terrestrial irradiance. The term
irradiance refers to process that surface is radiated by any radiant body. The solar
radiation received by earth’s surface could be divided into three main components
called beam (direct) radiation, diffuse radiation and ground reflection component.
Solar radiation received from the sun without having been scattered by the earth’s
atmosphere is known as beam radiation or direct radiation. The radiation received by
the earth’s surface whose direction has been changed by the reflection and scattering
from the atmosphere is known as diffuse radiation. Terms sky radiation, skylight and
diffuse skylight also refers to the diffuse radiation. The radiation received at a
particular point resulting due to ground reflection is called as ground reflection
radiation. Total radiation received at a particular point is known as global radiation or
total radiation. The beam radiation received on a plane normal to the beam solar rays
is known as beam normal radiation G . The beam radiation received on horizontal
bn
plane is known as beam horizontal radiation G and could be expressed using Equation
b
2.47.
G = G cosθ 2.47
b bn z
The diffuse radiation on horizontal plane is known as diffuse horizontal radiation G .
d
The ground reflected component on horizontal plane is known as ground reflected
horizontal radiation G . and could be assumed as negligible for most of the cases. The
g
Page 25

total radiation on horizontal surface is known as global horizontal radiation G and
mathematical expression is given in Equation 2.48.
|     | G = G | +G +G   | 2.48  |
| --- | ----- | ------- | ----- |
|     | b     | d g     |       |
The ground reflected component on horizontal plane could be assumed as negligible
for most of the cases. Therefore, equation 2.45 is reduced to Equation 2.49.
|     | G = G | +G   | 2.49  |
| --- | ----- | ---- | ----- |
b d
When the beam solar radiation is considered in solar insolation terms in hourly, daily
and monthly averaged daily irradiance equation 2.49 could be written as Equations
shown in 2.50, 2.51 and 2.52 respectively.
|     | I = I | +I   | 2.50  |
| --- | ----- | ---- | ----- |
b d
|     | H = H | +H   | 2.51  |
| --- | ----- | ---- | ----- |
b d
|     | H̅ = H̅̅̅̅+H̅̅̅̅  |     | 2.52  |
| --- | ----------------- | --- | ----- |
b d
2.4.6  Solar radiation on the tilted surface
Usually in most solar energy applications such as solar Photovoltaic panels and
thermal  collectors are  not  installed horizontally. Most of  the  net  metering solar
photovoltaic panels are mounted on existing roofs, hence mounting angle is equal to
roof angle. Also amount of captured solar energy could be increased significantly
using optimum mounting angles for the applications. Therefore, evaluation of solar
radiation on tilted surface is also important. The beam radiation received on tilted plane
is known as beam radiation on tilted surface G  and could be expressed using Equation
bt
2.53.
|     | G = G | cosθ  | 2.53  |
| --- | ----- | ----- | ----- |
|     | bt    | bn    |       |
For horizontal surfaces Equation 2.53 reduce to Equation 2.47
It follows that,
|     | G   | cosθ |     |
| --- | --- | ---- | --- |
bt
|     | r = | =    | 2.54  |
| --- | --- | ---- | ----- |
|     | b G | cosθ |       |
|     | b   | z    |       |
The ratio r b  is called the beam radiation tilt factor. The original relationship for the
beam radiation tilt factor is introduced by Hottel and Woertz in 1942 for the hourly
periods based on midpoint of the hour.  So the beam radiation component for any
surface can be written as Equation 2.55.
|     | G = | G r   | 2.55  |
| --- | --- | ----- | ----- |
|     | bt  | b b   |       |
Page 26

When the beam solar radiation is considered in solar insolation terms, it could be
written as Equation 2.56.
|     |     |     | H = | H R   |     | 2.56  |
| --- | --- | --- | --- | ----- | --- | ----- |
|     |     |     | bt  | b b   |     |       |
The ratio R  is known as daily beam radiation tilt factor and it could be evaluated by
b
integrating Equation 2.54 over the periods of sun rise to sun set for horizontal and tilt
surfaces.
𝜔𝑠𝑠cosθ
∫
𝜔𝑠𝑟
|     |     |     | R =  |     |     | 2.57  |
| --- | --- | --- | ---- | --- | --- | ----- |
|     |     |     | b 𝜔𝑠 |     |     |       |
∫ cosθ
z
𝜔−𝑠
The resulting equation for the equator facing surface in northern hemisphere is given
by Equation 2.58.
𝜋
|     | H cos(L−β)cosδsinω |              |     | +      | ω sin(L−β)sinδ |         |
| --- | ------------------ | ------------ | --- | ------ | -------------- | ------- |
|     | bt                 |              |     | ss 180 | ss             |         |
|     | R = =              |              |     |        |                |   2.58  |
|     | b                  |              |     | 𝜋      |                |         |
|     | H                  | cosLcosδsinω |     | +      | ω sinLsinδ     |         |
|     | b                  |              |     | s 180  | s              |         |
The same equation could be applied to the averaged beam radiation tilt factor, so that
Equation 2.59 can be written as follows,
𝜋
|     | H̅̅̅ ̅̅ cos(L−β)cosδsinω |     |     | +      | ω sin(L−β)sinδ |         |
| --- | ------------------------ | --- | --- | ------ | -------------- | ------- |
|     |                          |     |     | ss 180 | ss             |         |
|     | R̅̅̅̅ = b t =            |     |     |        |                |   2.59  |
|     | b                        |     |     | 𝜋      |                |         |
H̅̅̅ ̅
|     | b   | cosLcosδsinω |     | +      | ω sinLsinδ |     |
| --- | --- | ------------ | --- | ------ | ---------- | --- |
|     |     |              |     | s 1 80 | s          |     |
The diffuse radiation on tilted plane is known as diffuse radiation on tilted surface G .
dt
The ground reflected component of on tilted surface is known as ground reflected
radiation on tilted surface G gt . The total radiation on tilted surface is known as global
radiation on tilted surface G and mathematical expression is given in Equation 2.60.
t
|     |     | G   | = G  | +G +G |     |       |
| --- | --- | --- | ---- | ----- | --- | ----- |
|     |     |     | t bt | dt gt |     | 2.60  |
When the beam solar radiation is considered in solar insolation terms in hourly, daily
and monthly averaged daily irradiance equation 2.60 could be written as equations
2.61, 2.62 and 2.63 respectively.
|     |     |     | I = I | +I +I   |     | 2.61  |
| --- | --- | --- | ----- | ------- | --- | ----- |
|     |     |     | t bt  | dt gt   |     |       |
|     |     | H   | = H   | +H +H   |     | 2.62  |
|     |     |     | t bt  | dt gt   |     |       |
H̅̅̅ H̅̅̅̅̅+H̅̅̅̅̅+H̅̅̅̅
|     |     |     | =    |       |     | 2.63  |
| --- | --- | --- | ---- | ----- | --- | ----- |
|     |     |     | t bt | dt gt |     |       |
These components of radiation are shown in Figure 2.12.
Page 27

Figure 2.12 - Beam, diffuse and ground reflected solar radiation
(Source: “Empirical Correlation for Estimating Components of Light”, n.d.)
2.5 Measuring of Solar Radiation
Accurate data of solar radiation is required in solar energy applications design, sizing,
performance evaluations and solar energy researches. Mainly these data include global
solar radiation, beam radiation, diffuse radiation and sunshine hours. Various type of
equipment are available to measure instantaneous values and long term integrated
values. Usually these equipment use thermoelectric and photovoltaic effects to
measure solar radiation parameters. Mainly there are two types of solar radiation
measuring instruments called pyranometers and pyrheliometers.
2.5.1 Pyranometers
The pyranometer is used to measure global (total) radiation within hemispherical field
of horizontal view. Sensor of the pyranometer absorbs solar radiation from whole sky
dome and transformed it to heat energy. Global solar radiation could be evaluated by
measuring this heat energy. There are two types of pyranometers available in the field.
Most widely used type is thermopile type pyranometers which use principles of the
thermo couple. Other type is bimetallic pyranometers which use thermal expansion
properties of metal strips. The pyranometers could be used to measure the diffuse solar
radiation if the sensing element is shaded for the beam (direct) radiation. For this
purpose, shading devise should be mounted with tracking system to shade the sensor
Page 28

all over the time. Shading device also hide the considerable amount of diffuse radiation
from the sensor. Therefore, corrections are required for the shading device.
2.5.2 Pyrheliometers
The pyrheliometer is used to measure beam (direct) solar radiation. The receiving
surface of pyrheliometer should be normal to the direction of solar rays for the accurate
measurements. Therefore, pyrheliometers usually mounted with a tracking
mechanism. Mainly there are three types of pyrheliometers available. The Angstrom
electrical compensation pyrheliometer uses effect of thermocouple to measure beam
solar radiation. The silver disk pyrheliometer uses mercury bulb thermometer together
with silver disk to measure beam solar radiation. Thermoelectric pyrheliometers use
thermopile to measure beam solar radiation.
2.5.3 Sunshine recorders
The sunshine duration is an important parameter to estimate solar energy availability
during a certain the period. The sunshine duration is defined as the time during which
the sunshine is acute enough to cast a shadow. However, World Metrological
Organization (WMO) has defined sunshine duration as time during which the beam
solar irradiance exceeds the level of 120 W/m2. Basically two types of sunshine
recorders are used, i.e. focusing type and photoelectric type. The focusing type consists
with a solid glass sphere mounted concentrically in a section of a spherical bowl. The
bowl focuses sunrays into a paper placed in the bowl. The record card burns whenever
the bright sunshine is available. The portion of the burn trace is proportional to the
sunshine that exists. The photovoltaic sunshine recorders consist of two photovoltaic
cells with one cell exposed to the whole sky dome and the other one is covered by
shading ring to cover beam radiation. Thus, whenever the bright sunshine is not
available, two readings are approximately equal and whenever the bright sunshine is
available two readings are considerably different. Thus, difference of the two readings
is a measure of a sunshine duration. In addition to above measuring equipment satellite
images are also used to predict solar irradiance data.
The metrological department of Sri Lanka measures global solar radiation only at
Colombo station (6° 54' N, 79° 51' E at 10 m MSL). In addition to that, metrological
Page 29

department measures sunshine hours at four weather stations namely Colombo,
Nuwara Eliya (6° 50' N, 80° 50' E at 1500 m MSL), Anuradhapura (8° 20' N, 80° 25'
E at 25 m MSL) and Hambanthota (6° 10' N, 81° 15' E at 8 m MSL). The SLSEA
recently started to measure global solar radiation and diffuse radiation at two stations
namely Kilinochchi and Hambanthota. Methods of solar radiation estimation
2.6 Methods of solar radiation estimation
The global solar radiation received by the earth’s surface depends on the location and
the metrological condition of the location. Therefore, study of solar radiation under
local climatic conditions is necessary. Solar radiation can be estimated using empirical
models for locations where measured values are not available. Researchers have
developed various methods to estimate solar radiation with reasonable accuracy.
Basically these methods could be divided into two types as parametric models and
decomposition models. Parametric models use detailed metrological data such as cloud
cover data, sunshine hours, temperature, relative humidity, precipitation etc.
Decomposition models are used to estimate beam and diffuse compunctions using
global solar radiation data. Evaluation of long term performance of solar systems is
very important rather than looking on instantaneous values. Therefore, models are
developed to estimate long term monthly average daily insolation values, where
insolation is the total amount of solar radiation received by a given surface in a given
time duration.
2.6.1 Parametric Models
Estimation of monthly average daily solar radiation
One of the earliest methods of estimating solar radiation on a horizontal surface was
proposed by Angstrom in 1924. Angstrom model was a simple linear model to estimate
daily average horizontal radiation using sunshine hours and average clear day
horizontal radiation. Equation 2.64 represents the Angstrom 1924 model.
H̅ S̅
= (a+b )
H̅̅̅ S̅̅̅ 2.64
c o
Where,
Page 30

H̅
:  Monthly  averaged  daily  radiation  on  horizontal  surface  of
terrestrial region
H̅̅̅  :  Monthly averaged clear day radiation on horizontal surface
c
terrestrial region
| S̅  :  Monthly averaged hours of sunshine  |     |     |     |     |     |
| ------------------------------------------ | --- | --- | --- | --- | --- |
S̅̅̅
:  Monthly averaged maximum possible hours of sunshine
o
| a, b  :  Location specific constants  |     |     |     |     |     |
| ------------------------------------- | --- | --- | --- | --- | --- |
The location specific constants referred to as fractions of extra-terrestrial radiation on
overcast days and average days respectively. The ratio 𝑆̅/𝑆̅̅̅ is known as cloudless
𝑜
index and it explain about atmospheric characteristics and conditions of the location.
Basic difficulty of the Angstrom (1924) models is calculating clear day radiation
accurately.  Prescott  modified  Angstrom  (1924)  model  in  1940  to  overcome  the
difficultness of calculating the clear day radiation. The modified model replaces the
clear day radiation term by extra-terrestrial radiation. This new model is known as
Angstrom-Prescott (1940) model and is given in Equation 2.65.
|     |     | H̅     | S̅   |     |       |
| --- | --- | ------ | ---- | --- | ----- |
|     |     | = (a+b | )    |     | 2.65  |
|     |     | H̅̅̅̅  | S̅̅̅ |     |       |
|     |     | o      | o    |     |       |
Where,
H̅  :  Monthly  averaged  daily  radiation  on  horizontal  surface  of
terrestrial region
H̅̅̅̅
:  Monthly averaged daily radiation on horizontal surface of extra-
o
terrestrial region
| S̅  :   Monthly averaged hours of sunshine  |     |     |     |     |     |
| ------------------------------------------- | --- | --- | --- | --- | --- |
S̅̅̅  :  Monthly averaged maximum possible hours of sunshine
o
| a,b  :  Location specific constants  |     |     |     |     |     |
| ------------------------------------ | --- | --- | --- | --- | --- |
Ogelman et al (1984) presented second order model to predict monthly average daily
radiation based on sunshine hours which expressed in Equation 2.66.
|     | H̅    |      | S̅   | S̅ 2 |       |
| --- | ----- | ---- | ---- | ---- | ----- |
|     |       |      |      |      | 2.66  |
|     | =     | a+b( | )+c( | )    |       |
|     | H̅̅̅̅ |      | S̅̅̅ | S̅̅̅ |       |
o
|     |     |     | o   | o   |     |
| --- | --- | --- | --- | --- | --- |
Where,
| a, b, c :  Location specific constants  |     |     |     |     |     |
| --------------------------------------- | --- | --- | --- | --- | --- |
Page 31

Samuel (1991) presented third order model to predict monthly average daily radiation
based on sunshine hours which is expressed in Equation 2.67.
|     |        |      |      | 2     | 3    |       |
| --- | ------ | ---- | ---- | ----- | ---- | ----- |
|     | H̅     | S̅   | S̅   |       | S̅   |       |
|     | = a+b( | )+c( |      | ) +d( | )    | 2.67  |
|     | H̅̅̅̅  | S̅̅̅ | S̅̅̅ |       | S̅̅̅ |       |
|     | o      | o    | o    |       | o    |       |
Where,
| a, b, c, d  | :  Location specific constants  |     |     |     |     |     |
| ----------- | ------------------------------- | --- | --- | --- | --- | --- |
El-Metwally developed another model for estimating global solar radiation which is
expressed in Equation 2.68.
1
|     |     | H̅  | S̅         |     |     |       |
| --- | --- | --- | ---------- | --- | --- | ----- |
|     |     |     | ( )        |     |     | 2.68  |
|     |     |     | = a S̅̅̅ ̅ |     |     |       |
o
H̅̅̅̅
o
Where,
| a, b, c :  | Location specific constants  |     |     |     |     |     |
| ---------- | ---------------------------- | --- | --- | --- | --- | --- |
Bakirci (2009) developed the exponential model for global solar radiation prediction
which is expressed in Equation 2.69.
b
|     |     | H̅    | S̅   |     |     |       |
| --- | --- | ----- | ---- | --- | --- | ----- |
|     |     | =     | a( ) |     |     | 2.69  |
|     |     | H̅̅̅̅ | S̅̅̅ |     |     |       |
|     |     | o     | o    |     |     |       |
Where,
| a, b,  :   | Location specific constants  |     |     |     |     |     |
| ---------- | ---------------------------- | --- | --- | --- | --- | --- |
Sen Z. (2007) introduced another non liner model to estimate monthly average global
radiation which is expressed in Equation 2.70.
|     |     | H̅     |      | S̅ c |     |       |
| --- | --- | ------ | ---- | ---- | --- | ----- |
|     |     | = a+b( |      | )    |     | 2.70  |
|     |     | H̅̅̅̅  | S̅̅̅ |      |     |       |
|     |     | o      |      | o    |     |       |
Where,
| a, b, c :   | Location specific constants  |     |     |     |     |     |
| ----------- | ---------------------------- | --- | --- | --- | --- | --- |
Several other models based on other metrological data have been introduced by various
scientists in addition to the above sunshine data based models.
Hargreaves and Samani (1982) developed the relationship given by Equation 2.71.
H̅
|     |     | = a(T̅̅̅̅̅̅−T̅̅̅̅̅̅)0.5  |     |     |     | 2.71  |
| --- | --- | ------------------------ | --- | --- | --- | ----- |
|     |     | max                      |     | min |     |       |
H̅̅̅̅
o
Where,
| A  :        | Location specific constants                 |     |     |     |     |     |
| ----------- | ------------------------------------------- | --- | --- | --- | --- | --- |
| T̅̅̅̅̅̅  :  | Monthly averaged daily maximum temperature  |     |     |     |     |     |
max
Page 32

T̅̅̅̅̅̅
|     | :   | Monthly averaged daily maximum temperature  |     |     |     |     |     |     |
| --- | --- | ------------------------------------------- | --- | --- | --- | --- | --- | --- |
min
Bristow and Campbell (1984) established an empirical equation for daily global
irradiation using air temperature amplitude given in Equation 2.72.
H̅
|     |     |     | =   | a(1−e−b(T̅̅̅ | ̅̅ ̅̅ ̅−T̅̅ | ̅̅̅ ̅ ̅)c | )   | 2.72  |
| --- | --- | --- | --- | ------------ | ----------- | --------- | --- | ----- |
|     |     |     |     |              | m a x       | m i n     |     |       |
H̅̅̅̅
o
Where,
|     | a, b, c :  | Location specific constants  |     |     |     |     |     |     |
| --- | ---------- | ---------------------------- | --- | --- | --- | --- | --- | --- |
Hargreaves and Samani's (2000) introduced another model which is given in Equation
2.73.
H̅
  = [a+b(T̅̅̅̅̅̅−T̅̅̅̅̅̅)+c(T̅̅̅̅̅̅−T̅̅̅̅̅̅)2]×(T̅̅̅̅̅̅−T̅̅̅̅̅̅)0.5  2.73
|     | H̅̅̅̅ | max |     | min | max | min | max min |     |
| --- | ----- | --- | --- | --- | --- | --- | ------- | --- |
o
Where,
|     | a, b, c :  | Location specific constants  |     |     |     |     |     |     |
| --- | ---------- | ---------------------------- | --- | --- | --- | --- | --- | --- |
Chen et al (2004) introduced another model which is given in Equation 2.74.
H̅
|     |     |     |     | = a(T̅̅̅̅̅̅−T̅̅̅̅̅̅)0.5 |     | +b  |     | 2.74  |
| --- | --- | --- | --- | ----------------------- | --- | --- | --- | ----- |
|     |     |     |     | max                     | min |     |     |       |
H̅̅̅̅
o
Where,
|     | a, b, c :  | Location specific constants  |     |     |     |     |     |     |
| --- | ---------- | ---------------------------- | --- | --- | --- | --- | --- | --- |
In addition to above models following models are recommended by Duffie and
Beckman (1991)
|     |     |     |     | H̅  | S̅  |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
+cT̅
|     |     |     |     | =     | a+b      |     |     | 2.75  |
| --- | --- | --- | --- | ----- | -------- | --- | --- | ----- |
|     |     |     |     | H̅̅̅̅ | S̅̅̅     |     |     |       |
|     |     |     |     | o     | o        |     |     |       |
|     |     |     |     | H̅    | S̅       |     |     |       |
|     |     |     |     | = a+b | +cR̅̅̅̅  |     |     | 2.76  |
|     |     |     |     | H̅̅̅̅ | S̅̅̅     | h   |     |       |
|     |     |     |     | o     | o        |     |     |       |
H̅
|     |     |     |     | =     | a+bT̅+cR̅̅̅̅  |     |     | 2.77  |
| --- | --- | --- | --- | ----- | ------------- | --- | --- | ----- |
|     |     |     |     | H̅̅̅̅ |               | h   |     |       |
o
H̅
|     |     |     | =     | a+b(T̅̅̅̅̅̅−T̅̅̅̅̅̅)+cc̅̅̅  |         |     |     | 2.78  |
| --- | --- | --- | ----- | --------------------------- | ------- | --- | --- | ----- |
|     |     |     | H̅̅̅̅ |                             | max min |     | ω   |       |
o
H̅
a+b(T̅̅̅̅̅̅−T̅̅̅̅̅̅)0.5
|     |     |       | =   |     |         | +cc̅̅̅  |     | 2.79  |
| --- | --- | ----- | --- | --- | ------- | ------- | --- | ----- |
|     |     | H̅̅̅̅ |     |     | max min |         | ω   |       |
o
|     |     |     |     | H̅    | S̅      |     |     |       |
| --- | --- | --- | --- | ----- | ------- | --- | --- | ----- |
|     |     |     |     |       | +cc̅̅̅  |     |     | 2.80  |
|     |     |     |     | =     | a+b     |     |     |       |
|     |     |     |     | H̅̅̅̅ | S̅̅̅    | ω   |     |       |
|     |     |     |     | o     | o       |     |     |       |
Page 33

Where,
T̅
|          | :  Monthly averaged daily temperature        |     |     |     |     |     |
| -------- | -------------------------------------------- | --- | --- | --- | --- | --- |
|   R̅̅̅̅  | :  Monthly averaged daily relative humidity  |     |     |     |     |     |
h
|   c̅̅̅  | :  Monthly averaged daily cloud cover index  |     |     |     |     |     |
| ------- | -------------------------------------------- | --- | --- | --- | --- | --- |
ω
Same type of correlations set could be used to estimate daily irradiance values.
Estimation of Clear Sky Radiation
The  effects  of  the  atmospheric  attenuation  vary  with  the  time  and  atmospheric
conditions and magnitude of the air mass. Therefore, methods for estimation of clear
sky  radiation  in  standard  atmospheric  conditions  are  important.  Hottel  (1976)
introduced an Equation given in 2.81 to estimate atmospheric transmission for beam
radiation for four climate regions based on zenith angle (altitude angle) and altitude.
G
|     |     |     | bn  | e(−kcosecα)  |     |       |
| --- | --- | --- | --- | ------------ | --- | ----- |
|     |     | τ = | = a | +a           |     | 2.81  |
|     |     | b   | G 0 | 1            |     |       |
on
Where,
|     |     |     | a = | r a ∗  |     | 2.82  |
| --- | --- | --- | --- | ------ | --- | ----- |
|     |     |     | 0   | 0× 0   |     |       |
|     |     |     | a = | r a ∗  |     | 2.83  |
|     |     |     | 1   | 1× 1   |     |       |
k∗
|     |     |     | k = | r   |     | 2.84  |
| --- | --- | --- | --- | --- | --- | ----- |
k×
Three correlation factors r , r , and r  to allow changes in climate types are given in
|     |     | 0 1 | k   |     |     |     |
| --- | --- | --- | --- | --- | --- | --- |
Table 2.2.
Table 2.2  - Hottlel correlations factors for different climate types
|     |                      | Climate type  |     | r     | r   r       |     |
| --- | -------------------- | ------------- | --- | ----- | ----------- | --- |
|     |                      |               |     | 0     | 1 k         |     |
|     | Tropical             |               |     | 0.95  | 0.98  1.02  |     |
|     | Mid latitude Summer  |               |     | 0.97  | 0.99  1.02  |     |
|     | Subarctic Summer     |               |     | 0.99  | 0.99  1.01  |     |
|     | Mid latitude winter  |               |     | 1.03  | 1.01  1.00  |     |
Constants a , a , and k for the standard atmosphere with 23 km visibility are found
0 1
| from a *, a *, and k*for altitudes less than 2.5 km.  |     |                             |     |     |     |       |
| ----------------------------------------------------- | --- | --------------------------- | --- | --- | --- | ----- |
| 0 1                                                   |     |                             |     |     |     |       |
|                                                       |     | a ∗ = 0.4237−0.00821(6−A)2  |     |     |     | 2.85  |
|                                                       |     | 0                           |     |     |     |       |
∗ 0.5055+0.00595(6.5−A)2
|     |     | a = |     |     |     | 2.86  |
| --- | --- | --- | --- | --- | --- | ----- |
1
|     |     | k∗ 0.2711+0.01858(2.5−A)2  |     |     |     |       |
| --- | --- | -------------------------- | --- | --- | --- | ----- |
|     |     | =                          |     |     |     | 2.87  |
Page 34

Constants a , a , and k for the standard atmosphere with 5 km visibility are found from
0 1
*, a *, and k* for altitudes less than 2.5 km.
a 0 1
|     |     | ∗   | 0.2538−0.0063(6−A)2  |     |     |     |       |
| --- | --- | --- | -------------------- | --- | --- | --- | ----- |
|     |     | a = |                      |     |     |     | 2.88  |
0
|     |     | a ∗ = 0.7678+0.0010(6.5−A)2  |     |     |     |     | 2.89  |
| --- | --- | ---------------------------- | --- | --- | --- | --- | ----- |
1
|     |     | k∗ = | 0.249+0.081(2.5−A)2  |     |     |     | 2.90  |
| --- | --- | ---- | -------------------- | --- | --- | --- | ----- |
Where,
|     | A   | :  Altitude of the location in kilometres  |     |     |     |     |     |
| --- | --- | ------------------------------------------ | --- | --- | --- | --- | --- |
Using equations 2.47 and 2.81 clear sky horizontal beam radiation cloud be expressed
as equation 2.91.
e(−kcosecα)]cosθ
|     |     | G = G | [a +a |     |     |     | 2.91  |
| --- | --- | ----- | ----- | --- | --- | --- | ----- |
|     |     | b on  | 0     | 1   | z   |     |       |
The clear sky diffuse radiation could be estimated using Liu and Jordan (1960) given
in Equation 2.92.
e(−kcosecα)]}cosθ
|     | G = | G {0.2710−0.2939[a |     | +a  |     |     | 2.92  |
| --- | --- | ------------------ | --- | --- | --- | --- | ----- |
|     | d   | on                 |     | 0 1 |     | z   |       |
American Society of Heating Refrigeration and Air-conditioning Engineers ASHRAE
(2001) introduced equations given in 2.93 and 2.94 to predict clear sky beam and
diffuse radiation respectively.
−B
|     |     |     |     | ( )        |     |     | 2.93  |
| --- | --- | --- | --- | ---------- | --- | --- | ----- |
|     |     |     | G = | Ae cosθz   |     |     |       |
bn
|     |     |     |     |     |     |     | 2.94  |
| --- | --- | --- | --- | --- | --- | --- | ----- |
G = CG
|     |     |     | d   | bn  |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
Where,
|   A  | :   | apparent solar irradiation at zero air mass  |     |     |     |     |     |
| ---- | --- | -------------------------------------------- | --- | --- | --- | --- | --- |
|   B  | :   | atmospheric extinction coefficient           |     |     |     |     |     |
|   C  | :   | Diffuse radiation factor                     |     |     |     |     |     |
The constants A, B, and C are given in Table 2.3 which is given in ASHRAE (1985)
for the twenty first day of each month.

Page 35

Table 2.3 - ASHRAE (1985) clear sky radiation model coefficients
|     | Month      | n    |     | A (W/m2)   |     | B      | C      |     |
| --- | ---------- | ---- | --- | ---------- | --- | ------ | ------ | --- |
|     | January    | 21   |     | 1229.4750  |     | 0.142  | 0.058  |     |
|     | February   | 52   |     | 1213.7125  |     | 0.144  | 0.060  |     |
|     | March      | 80   |     | 1185.3400  |     | 0.156  | 0.071  |     |
|     | April      | 11   |     | 1134.9000  |     | 0.180  | 0.097  |     |
|     | May        | 141  |     | 1103.3750  |     | 0.196  | 0.121  |     |
|     | June       | 172  |     | 1087.6125  |     | 0.205  | 0.134  |     |
|     | July       | 202  |     | 1084.4600  |     | 0.207  | 0.136  |     |
|     | August     | 233  |     | 1106.5275  |     | 0.201  | 0.122  |     |
|     | September  | 264  |     | 1150.6625  |     | 0.177  | 0.092  |     |
|     | October    | 294  |     | 1191.6450  |     | 0.160  | 0.073  |     |
|     | November   | 325  |     | 1220.0175  |     | 0.149  | 0.063  |     |
|     | December   | 355  |     | 1232.6275  |     | 0.142  | 0.057  |     |
Various other correlations for clear sky radiations are found in the literature and some
of these are given in Equations 2.95 to 2.99
Hourtwitz correlation
−0.057
|     |     |     |     |          | (       | )   |     | 2.95  |
| --- | --- | --- | --- | -------- | ------- | --- | --- | ----- |
|     |     |     | G = | 1098cosθ | e cosθz |     |     |       |
z
Berger and Duffie correlation
|     |     |     | G = | 1350×0.7×cosθ |     |     |     | 2.96  |
| --- | --- | --- | --- | ------------- | --- | --- | --- | ----- |
z
Adnot et al correlation
951.39cos1.15θ
|     |     |     | G   | =   |     |     |     | 2.97  |
| --- | --- | --- | --- | --- | --- | --- | --- | ----- |
z
Kasten and Czeplak correlation
|     |     |     | G   | = 910cosθ | −30  |     |     | 2.98  |
| --- | --- | --- | --- | --------- | ---- | --- | --- | ----- |
z
Robledo and Soler correlation
π
|     |     |     | 1159.24cos1.179θ |     |     | −0.00149( −θz) |     | 2.99  |
| --- | --- | --- | ---------------- | --- | --- | -------------- | --- | ----- |
|     |     | G = |                  |     | −e  | 2              |     |       |
z
2.6.2  Decomposition Models
When considering the solar engineering applications, it is essential to quantify the
beam and diffuse radiation of a particular location of interest. The amount of global
insolation on a terrestrial tilted surface is the sum of beam, diffuse and ground reflected
insolation as discussed previously. There are some decomposition models available in
literature which are capable of estimating diffuse insolation from hourly radiation,
daily radiation and monthly average daily global solar radiation. The usual approach
Page 36

of decomposition models is to correlate diffuse component and global component
using clearness index. The clearness index is the ratio between terrestrial radiation and
extra-terrestrial radiation. The clearness indices could be defined as hourly clearness
index,  daily  clearness  index  and  monthly  average  daily  clearness  index.  Hourly
clearness index k , daily clearness index K  and monthly average daily clearness index
|     | T   |     | T   |     |     |
| --- | --- | --- | --- | --- | --- |
K̅̅̅̅are given in Equations 2.100, 2.101 and 2.102 respectively.
T
I
|     |     |     | k =   |     | 2.100  |
| --- | --- | --- | ----- | --- | ------ |
T
I
o
H
|     |     |     | K =   |     | 2.101  |
| --- | --- | --- | ----- | --- | ------ |
T
H
o
H̅
K̅̅̅̅
|     |     |     | =       |     | 2.102  |
| --- | --- | --- | ------- | --- | ------ |
|     |     |     | T H̅̅̅̅ |     |        |
o
Since the clearness index is a direct measurement of cloudiness of the sky, Iqbal (1983)
proposed the classification of sky given in Table 2.4 based on the clearness index.
Table 2.4 - Classification of the sky types according to the clearness index
|                | Sky Type  |     |                              | Clearness index  |     |
| -------------- | --------- | --- | ---------------------------- | ---------------- | --- |
| Clear          |           |     | 0.7 ≤ clearness index ≤ 0.9  |                  |     |
| Partly Cloudy  |           |     | 0.3 ≤ clearness index ≤ 0.7  |                  |     |
| Cloudy         |           |     | 0.0 ≤ clearness index ≤ 0.3  |                  |     |
Decomposition models based on hourly radiation
Liu and Jordan (1960) introduced decomposition model given in Equation 2.103 for
hourly radiation using data of 98 Canadian and USA stations.
I
d
|     |     | = 0.384k | −1 −0.416  |     | 2.103  |
| --- | --- | -------- | ---------- | --- | ------ |
T
I
Orgil and Hollands (1977) introduced decomposition model given in Equation 2.104
for hourly radiation using data of Canadian stations.
|     | 1.0−0.249k |     |      for  0 | ≤ k ≤ 0.35       |     |
| --- | ---------- | --- | ----------- | ---------------- | --- |
|     | I          |     | T           | T                |     |
d
|     | = {1.557−1.84k |     |   for  0.35 | < k < 0.75   | 2.104  |
| --- | -------------- | --- | ----------- | ------------ | ------ |
|     |                |     | T           | T            |        |
I
|     | 0.177                    for  k |     |     | > 0.75                 |     |
| --- | ------------------------------- | --- | --- | ---------------------- | --- |
T
Bugler (1977) introduced decomposition model given in Equation 2.105 for hourly
radiation using data of Australian stations.
Page 37

0.94 𝑓𝑜𝑟 0 ≤ 𝑘 ≤ 0.4
I 𝑇
d = {1.29−1.19𝑘 2.105
𝑇
I 𝑓𝑜𝑟 > 0.4
1.0−0.334𝑘
𝑇
Erbs et al (1982) introduced decomposition model given in Equation 2.106 using data
of US stations and one Australian station.
1.0−0.9k for 0 ≤ k ≤ 0
T T
I d = 0.9511−0.1604k T +4.388k T 2 −16.638k T 3 +12.336k T 4 2.106
I for 0.22 < k < 0.80
T
{0.165 for k > 0.8
T
Hawlader (1984) introduced model given in Equation 2.107 using data of Singapore
stations.
0.915 for 0 ≤ k ≤ 0.225
I T
d = {1.135−0.9422k −0.3878k 2 for 0.0.225 < k < 0.775 2.107
I T T T
0.215 for k > 0.775
T
Reindl et al (1990) introduced model given in Equation 2.108 using data of US stations
and European stations.
1.020−0.248k for 0 ≤ k ≤ 0.30
I T T
d
= {1.450−1.670k for 0.30 < k < 0.78 2.108
T T
I
0.147 for k > 0.78
T
Reindl et al (1990) introduced another model in terms of additional parameter solar
altitude angle α using the data of same stations which is given in Equation 2.109.
1.020−0.254k +0.0123sin𝛼 for 0 ≤ k ≤ 0.30
I T T
d
= {1.400−1.749k +0.177sin𝛼 for 0.30 < k < 0.78 2.109
T T
I
0.486k −0.182sin𝛼 for k > 0.78
T T
Reindl et al (1990) introduced another model in terms of additional parameters solar
altitude angle α, Outside temperature T and Relative Humidity R using the data of
h
same stations which is given in Equation 2.110.
1−0.232k +0.0239sinα−0.000682T+0.019R
T ℎ
for 0 ≤ k ≤ 0.30
T
I 1.329−1.716k +0.267sinα−0.00357T+0.106R
d = T ℎ 2.110
I for 0.30 < k
T
≤ 0.78
0.426k +0.256sinα−0.00349T+0.0734RH
T
{ for k > 0.78
T
Where,
Page 38

α : solar altitude angle
T : Outside air temperature
R : Relative humidity
h
Chandrasekaran and Kumar (1994) introduced another model using data of Indian
stations which is given in Equation 2.111.
1.0086−0.178k
T
for 0 ≤ k ≤ 0.24
T
I d 0.9686+0.1325k +1.4183k 2 −10.1862k 3 +8.3733k 4
= T T T T
2.111
I for 0.24 < k < 0.80
T
0.197
{ for k > 0.80
T
Lam and Li (1996) introduced another model based on data of Hong Kong stations
which is given in Equation 2.112.
0.977 for 0 ≤ k ≤ 0.1
I T
d
= {1.237−1.36k for 0.15 < k < 0.70 2.112
T T
I
0.273 for k > 0.70
T
Miguel et al (2001) introduced another model based on data of some European stations
which is given in Equation 2.113.
I
d
I
0.995−0.081k for 0 ≤ k ≤ 0.21 2.113
T T
= {0.724+2.738k −8.32k 2 +1.4926k 3 for 0.21 < k < 0.76
T T T T
0.18 for k > 0.76
T
Boland et al (2001) introduced another model in terms of additional parameter hour
angle ω using the data of some Australian stations which is given in Equation 2.114.
I 1.039
d = −0.039+ 2.114
I 1+e(−8.769+7325kT+0.377ω)
Karatasou et al (2003) introduced another model based on data of Athens which is
given in Equation 2.115.
I d = { 0.9995−0.05𝑘 𝑇 −2.4156𝑘 𝑇 2 +1.4926𝑘 𝑇 3 𝑓𝑜𝑟 0 ≤ 𝑘 𝑇 ≤ 0.78 2.115
I 0.2 𝑓𝑜𝑟 > 0.78
Page 39

Soares et al (2004) introduced another model based on data of Sao Paolo which is
given in Equation 2.116.
I
d
I
  1                                                                                 for  0 ≤ k ≤ 0.17       2.116
T
|     |     |           |     |       | 2      |     | 3      | 4           |     |              |     |
| --- | --- | --------- | --- | ----- | ------ | --- | ------ | ----------- | --- | ------------ | --- |
|     | =   | {0.9+1.1k |     | −4.5k | +0.01k |     | +3.14k |   for  0.17 |     | < k < 0.75   |     |
|     |     |           | T   |       | T      |     | T      | T           |     | T            |     |
0.17                                                                           for  k > 0.75
T
Zhou et al (2004) introduced another model based on data of 78 Chinese stations which
is given in Equation 2.117.
|     |     |     |     | 0.987                       for  0 |     |     |     | ≤ k ≤ 0.2          |     |     |     |
| --- | --- | --- | --- | ---------------------------------- | --- | --- | --- | ------------------ | --- | --- | --- |
|     |     |     | I   |                                    |     |     |     | T                  |     |     |     |
d
|     |     |     | =   | {1.292−1.447k                      |     |     |   for  0.17 | < k <                 | 0.75   |     | 2.117  |
| --- | --- | --- | --- | ---------------------------------- | --- | --- | ----------- | --------------------- | ------ | --- | ------ |
|     |     |     | I   |                                    |     |     | T           | T                     |        |     |        |
|     |     |     |     | 0.209                       for  k |     |     |             | > 0.75                |        |     |        |
T
Jacovides et al (2006) introduced another model based on data of Athalassa which is
given in Equation 2.118.
|     |     |     | 0.987                                                              for  0 |     |     |     |     |     | ≤ k | ≤ 0.1     |     |
| --- | --- | --- | ------------------------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --------- | --- |
T
I
|     |     | d   |                                                                            |     |        |     | 2      | 3  for  0.1 |     |                 |        |
| --- | --- | --- | -------------------------------------------------------------------------- | --- | ------ | --- | ------ | ----------- | --- | --------------- | ------ |
|     |     | =   | {0.94+0.937k                                                               |     | −5.01k |     | +3.32k |             | <   | k < 0.8         | 2.118  |
|     |     | I   |                                                                            |     | T      |     | T      | T           |     | T               |        |
|     |     |     | 0.209                                                               for  k |     |        |     |        |             | >   | 0.8             |        |
T
Boland et al (2008) introduced another model using the data of some Australian
stations which is given in Equation 2.116.
|     |     |     |     |     | I   |     | 1   |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
d
|     |     |     |     |     |     | =            |     |     |     |     | 2.119  |
| --- | --- | --- | --- | --- | --- | ------------ | --- | --- | --- | --- | ------ |
|     |     |     |     |     | I   | 1+e(8.6kT−5) |     |     |     |     |        |
Ridley et al (2010) introduced another model using the data of some Australian stations
which is given in Equation 2.120.
|     |     |     | I   |                                             |     |     | 1   |     |     |     |        |
| --- | --- | --- | --- | ------------------------------------------- | --- | --- | --- | --- | --- | --- | ------ |
|     |     |     | d   |                                             |     |     |     |     |     |     | 2.120  |
|     |     |     | =   |                                             |     |     |     |     |     |     |        |
|     |     |     | I   | 1+e(5.38+6.63kT−0.007α+0.006ω+1.75KT+1.31ψ) |     |     |     |     |     |     |        |
Where,
|     |     |     |     | k   | +k  |                  |     |              |     |     |     |
| --- | --- | --- | --- | --- | --- | ---------------- | --- | ------------ | --- | --- | --- |
|     |     |     |     | T−1 |     | T+1  𝑓𝑜𝑟 𝑠𝑢𝑛𝑟𝑖𝑠𝑒 |     | < 𝑇 < 𝑠𝑢𝑛𝑠𝑒𝑡 |     |     |     |
2
|     |     |     | ψ = | {   |                      |     |                                |     |     |     | 2.121  |
| --- | --- | --- | --- | --- | -------------------- | --- | ------------------------------ | --- | --- | --- | ------ |
|     |     |     |     | k   |                𝑓𝑜𝑟 𝑇 |     | = 𝑠𝑢𝑛𝑟𝑖𝑠𝑒                      |     |     |     |        |
T+1
|     |     |     |     | k   |               𝑓𝑜𝑟 𝑇 |     | = 𝑠𝑢𝑛𝑠𝑒𝑡                        |     |     |     |     |
| --- | --- | --- | --- | --- | ------------------- | --- | ------------------------------- | --- | --- | --- | --- |
T−1
Skartveit and Olesh (1987) estimated beam irradiance fraction from global irradiance
using clearness index and solar altitude angle which is given in Equation 2.122.
Page 40

|     |     |     | 0                                                      for  0 |     |     |     |     | ≤   | k < | k   |     |
| --- | --- | --- | ------------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
|     |     |     |                                                               |     |     |     |     |     | T   | 0   |     |

|     |     |     | (1−d | )[ak0.5 | +(1−a)k2] |     |     |     |     |     |     |
| --- | --- | --- | ---- | ------- | --------- | --- | --- | --- | --- | --- | --- |

|     | I   |     |     | 1   |      |     |    for  k | ≤   | k   | ≤ k |        |
| --- | --- | --- | --- | --- | ---- | --- | --------- | --- | --- | --- | ------ |
|     | b   |     |     |     |      |     |           | 0   | T   | 1   |        |
|     |     | =   |     |     | sinα |     |           |     |     |     | 2.122  |
I
|     |     |     | 1.09(1−ξ) |      |                                          |     |     |     |     |     |     |
| --- | --- | --- | --------- | ---- | ---------------------------------------- | --- | --- | --- | --- | --- | --- |
|     |     |     |           |      |                                   for  k |     |     |     | >   | k   |     |
|     |     |     |           |      |                                          |     |     |     | T   | 1   |     |
|     |     | {   | k         | sinα |                                          |     |     |     |     |     |     |
T
Where,
|     |     |     |     |     | k   | = 0.2  |     |     |     |     | 2.123  |
| --- | --- | --- | --- | --- | --- | ------ | --- | --- | --- | --- | ------ |
0
|     |     |     | k   | = 1.09(0.87−0.56e−0.06α)  |     |     |     |     |     |     | 2.124  |
| --- | --- | --- | --- | ------------------------- | --- | --- | --- | --- | --- | --- | ------ |
1
|     |     |     |     | d   | = 0.15+0.43e−0.06α  |     |     |     |     |     | 2.125  |
| --- | --- | --- | --- | --- | ------------------- | --- | --- | --- | --- | --- | ------ |
1
|     |     |     |     |     | a = | 0.27  |     |     |     |     | 2.126  |
| --- | --- | --- | --- | --- | --- | ----- | --- | --- | --- | --- | ------ |
a′
|     |     |     | k   | = 0.5{1+sin[π( |     |     | −0.5)]}  |     |     |     | 2.127  |
| --- | --- | --- | --- | -------------- | --- | --- | -------- | --- | --- | --- | ------ |
b′
|     |     |     |     |        | a′ =     | k −k |             |     |     |     | 2.128  |
| --- | --- | --- | --- | ------ | -------- | ---- | ----------- | --- | --- | --- | ------ |
|     |     |     |     |        |          | T    | 0           |     |     |     |        |
|     |     |     |     |        | b′ =     | k −k |             |     |     |     | 2.129  |
|     |     |     |     |        |          | 1    | 0           |     |     |     |        |
|     |     |     | ξ = | 1−(1−d | )[ak′0.5 |      | +(1−a)k′2]  |     |     |     | 2.130  |
1
a"
|     |     |     | k′  | = 0.5{1+sin[π( |     |     | −0.5)]}  |     |     |     | 2.131  |
| --- | --- | --- | --- | -------------- | --- | --- | -------- | --- | --- | --- | ------ |
b′
|     |     |     |     |     | a" = 1.09k |     | −k   |     |     |     | 2.132  |
| --- | --- | --- | --- | --- | ---------- | --- | ---- | --- | --- | --- | ------ |
1 0
Authors of this model have indicated that some of the constant may have to be adjusted
for conditions deviating from their validation domain.
Maxwell (1987) introduced a model to predict beam irradiance using extra-terrestrial
irradiance which is given in Equation 2.133.
I
|     |     |     |     | b   | = ψ−(n | +n  | eman3)  |     |     |     | 2.133  |
| --- | --- | --- | --- | --- | ------ | --- | ------- | --- | --- | --- | ------ |
|     |     |     |     |     |        | 1   | 2       |     |     |     |        |
I
o
Where,
|     | ψ   | = 0.866−0.122𝑚 |     |     | +0.0121𝑚 |     | 2 −0.000653𝑚 |     |     | 3   |        |
| --- | --- | -------------- | --- | --- | -------- | --- | ------------ | --- | --- | --- | ------ |
|     |     |                |     |     | 𝑎        |     | 𝑎            |     |     | 𝑎   | 2.134  |
4
+0.000014𝑚
𝑎
if k ≤ 0.6
t
|     |     | n   | = 0.512−1.56k |                 |                | +2.286k | 2       | −2.222k |     | 3   | 2.135  |
| --- | --- | --- | ------------- | --------------- | -------------- | ------- | ------- | ------- | --- | --- | ------ |
|     |     | 1   |               |                 | T              |         | T       |         | T   |     |        |
|     |     |     |               | n               | = 0.370+0.962k |         |         |         |     |     | 2.136  |
|     |     |     |               | 2               |                |         | T       |         |     |     |        |
|     |     |     | n             | = −0.280+0.923k |                |         | −2.048k |         | 2   |     | 2.137  |
|     |     |     | 3             |                 |                |         | T       | T       |     |     |        |
if  k > 0.6
t
Page 41

|     |     |     |                  |     |         |         | 2        | 3   |        |
| --- | --- | --- | ---------------- | --- | ------- | ------- | -------- | --- | ------ |
|     |     | n   | = −5.743+21.77k  |     |         | −27.49k | +11.56k  |     | 2.138  |
|     |     | 1   |                  |     | T       |         | T        | T   |        |
|     |     |     | n = 41.40−118.5k |     | +66.05k |         | 2 +31.9k | 3   | 2.139  |
|     |     |     | 2                |     | T       |         | T        | T   |        |
|     |     |     |                  |     |         |         | 2        | 3   |        |
|     |     | n   | = −47.01+184.2k  |     |         | −222k   | +73.81k  |     | 2.140  |
|     |     |     | 3                |     | T       |         | T        | T   |        |
Louche et all (1991) introduced a model to estimate beam fraction of global irradiance
using data of France which is given in Equation 2.141.
I
b
|     | =   | −10.676k | 5   | +15.307k | 4 −5.205k |     | 30.994k | 2 −0.059k |          |
| --- | --- | -------- | --- | -------- | --------- | --- | ------- | --------- | -------- |
|     |     |          | T   |          | T         |     | T       | T         | T 2.141  |
I
+0.002
Vignola and Mc Daniels (1986) introduced model to estimate beam fraction of global
irradiance using the data of USA stations which is given in Equation 2.142.
|     |     |     | 0.013−0.175k |     |     | +0.52k | 2 +1.08k | 3   |     |
| --- | --- | --- | ------------ | --- | --- | ------ | -------- | --- | --- |
|     |     |     |              |     | T   |        | T        | T   |     |

2π(n−20)

|     |     |     |   +(0.038k |     | −0.13k | 2)sin[   |     | ]   |        |
| --- | --- | --- | ---------- | --- | ------ | -------- | --- | --- | ------ |
|     |     | I   |            | T   |        | T        |     |     |        |
|     |     | b   |            |     |        |          | 365 |     |        |
|     |     |     | =          |     |        |          |     |     | 2.142  |
|     |     | I   |            |     | for k  | ≤ 0.175  |     |     |        |
T
|     |     |     |    0.125k | 2                                                          |     |     |     |     |     |
| --- | --- | --- | --------- | ---------------------------------------------------------- | --- | --- | --- | --- | --- |

T
|     |     |     | {   |     | for k | > 0.175    |     |     |     |
| --- | --- | --- | --- | --- | ----- | ---------- | --- | --- | --- |
T

Decomposition models based on daily radiation
Ruth and chant (1976) introduced model a to estimate diffuse fraction of daily global
irradiance using the data of Canadian stations which is given in Equation 2.143.
|     | H   | 0.98                                                                        for K |     |         |     |         |          | ≤ 0.175 |          |
| --- | --- | --------------------------------------------------------------------------------- | --- | ------- | --- | ------- | -------- | ------- | -------- |
|     | d   |                                                                                   |     |         |     |         |          | T       |          |
|     |   = | {                                                                                 |     |         |     |         |          |         |   2.143  |
|     |     |                                                                                   |     |         |     | 2       | 3  for K |         |          |
|     | H   |  1.91+1.154K                                                                      |     | −4.936K |     | −2.848K |          | > 0.175 |          |
|     |     |                                                                                   |     | T       |     | T       | T        | T       |          |
Collares-Pereira and Rabl (1979) introduced a model to estimate diffuse fraction of
daily global irradiance using the data of four USA stations which is given in Equation
2.144.
Page 42

0.99

|     |     |     |     |     | for K | ≤ 0.17               |     |     |     |     |     |
| --- | --- | --- | --- | --- | ----- | -------------------- | --- | --- | --- | --- | --- |
T

|     |     |  1.188−2.272K |     |     | +9.473K  | 2 −11.9514K |        | 3 +9.3879K |     | 4   |          |
| --- | --- | ------------- | --- | --- | -------- | ----------- | ------ | ---------- | --- | --- | -------- |
|     |     |               |     |     | T        | T           |        | T          |     | T   |          |
|     | H   |               |     |     | for 0.17 | < K         | ≤ 0.75 |            |     |     |          |
|     | d   |               |     |     |          | T           |        |            |     |     |          |
|     |     | =             |     |     |          |             |        |            |     |     |   2.144  |
H  0.632−0.54K
T
|     |     |     |     |     | for 0.75 | < K | ≤ 0.80 |     |     |     |     |
| --- | --- | --- | --- | --- | -------- | --- | ------ | --- | --- | --- | --- |
T

 0.2
|     |     | {   |     |     | for K | ≤ 0.80                |     |     |     |     |     |
| --- | --- | --- | --- | --- | ----- | --------------------- | --- | --- | --- | --- | --- |
T
Erbs et al (1982) introduced a model to estimate diffuse fraction of daily global
irradiance using the data of US stations and one Australian station which is given in
Equation 2.145.
|     |     |     |     |     | 1−0.2727K | +2.4495K |     | 2 −11.9514K |     |     | 3   |
| --- | --- | --- | --- | --- | --------- | -------- | --- | ----------- | --- | --- | --- |
|     |     |     |     |     |           | T        |     | T           |     | T   |     |
|     |     |     |     |     |           |          |     | 2           |     |     |     |
|     |     |     |     |     |           | +9.3879K |     |             |     |     |     |
T
|     |     |  for ω | ≤ 81.4  |     |     | for K | <   | 0.715 |     |     |     |
| --- | --- | ------ | ------- | --- | --- | ----- | --- | ----- | --- | --- | --- |
|     |     | s      |         |     |     |       | T   |       |     |     |     |

|     |     |     |     |     | 0.143                                                                       |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --------------------------------------------------------------------------- | --- | --- | --- | --- | --- | --- |
|     | H   |     |     |     |                                                                             |     |     |     |     |     |     |
d
|     |     | =   |     | {   |     | for K | <   | 0.715 |     |     |   2.145  |
| --- | --- | --- | --- | --- | --- | ----- | --- | ----- | --- | --- | -------- |
T
H
|     |     |        |          |     |                                                                          |         |     | 2        |     | 3   |     |
| --- | --- | ------ | -------- | --- | ------------------------------------------------------------------------ | ------- | --- | -------- | --- | --- | --- |
|     |     |        |          |     | 1+0.2832K                                                                | −2.555K |     | +0.8448K |     |     |     |
|     |     |        |          |     |                                                                          | T       |     | T        |     | T   |     |
|     |     |        |          |     |                                                                          | for K   | <   | 0.722    |     |     |     |
|     |     |  for ω |          |     |                                                                          |         | T   |          |     |     |     |
|     |     |        | > 81.4 { |     |                                                                          |         |     |          |     |     |     |
|     |     |        | s        |     | 0.175                                                                    |         |     |          |     |     |     |
|     |     | {      |          |     |                                                                          | for K   | <   | 0.722    |     |     |     |
T
Decomposition models based on monthly average radiation
Liu and Jordan (1960) developed a graphical relationship between monthly averaged
daily diffuse radiation fraction and monthly averaged daily clearness index which is
expressed later by Klein (1977) which is given in Equation 2.146.
H̅̅̅̅
|     |     | d 1.39−4.027K̅̅̅̅+5.531K̅̅̅̅2 |     |     |     | −3.108K̅̅̅̅3 |     |           |         |        |        |
| --- | --- | ----------------------------- | --- | --- | --- | ------------ | --- | --------- | ------- | ------ | ------ |
|     |     | =                             |     |     |     |              |     |   for 0.3 | < K̅̅̅̅ | < 0.7  | 2.146  |
|     | H̅  |                               |     | T   |     | T            | T   |           | T       |        |        |
Page (1961) introduced another model which is given in Equation 2.147.
H̅̅̅̅
d
|     |     |     |     |     | = 1.0−1.13K̅̅̅̅  |     |     |     |     |     | 2.147  |
| --- | --- | --- | --- | --- | ---------------- | --- | --- | --- | --- | --- | ------ |
|     |     |     |     |     | H̅               |     | T   |     |     |     |        |

Collares-Pereira and Rabl (1979) introduced another model which is given in Equation
2.148.
Page 43

H̅̅̅̅
|     | d   | = 0.775+0.00606(ω |     |     | −90) |     |     |     |     |     |        |
| --- | --- | ----------------- | --- | --- | ---- | --- | --- | --- | --- | --- | ------ |
|     |     |                   |     |     | s    |     |     |     |     |     | 2.148  |
H̅
|     |     |     | −[0.505+0.00455(ω |     |     |     | −90)]cos(K̅̅̅̅−103)  |     |     |     |     |
| --- | --- | --- | ----------------- | --- | --- | --- | -------------------- | --- | --- | --- | --- |
|     |     |     |                   |     |     |     | s                    |     | T   |     |     |
Iqbal (1979) model introduced another model which is given in Equation 2.149.
H̅̅̅̅
|     |     |     |     | d   | 0.958−0.952K̅̅̅̅  |     |     |     |     |     | 2.149  |
| --- | --- | --- | --- | --- | ----------------- | --- | --- | --- | --- | --- | ------ |
=
|     |     |     |     | H̅  |     |     | T   |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Erbs et al (1982) model introduced another model which is given in Equation 2.150.
|     |     |     | 1.391−3.567K̅̅̅̅+4.189K̅̅̅̅2 |     |     |     |     | −2.137K̅̅̅̅3 |     |     |     |
| --- | --- | --- | ---------------------------- | --- | --- | --- | --- | ------------ | --- | --- | --- |

|     |     |       |                               |       |                 | T   | T   |              | T   |     |        |
| --- | --- | ----- | ----------------------------- | ----- | --------------- | --- | --- | ------------ | --- | --- | ------ |
|     |     | H̅̅̅̅ |                               | for ω | ≤ 81.4° and 0.3 |     | <   | K̅̅̅̅ <      | 0.8 |     |        |
|     |     | d     |                               |       | s               |     |     | T            |     |     |        |
|     |     |       | =                             |       |                 |     |     |              |     |     | 2.150  |
|     |     | H̅    |  1.311−3.022K̅̅̅̅+3.427K̅̅̅̅2 |       |                 |     |     | −1.821K̅̅̅̅3 |     |     |        |

|     |     |     |     |     |     | T   | T   |     | T   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

|     |     |     |     | for ω | > 81.4° 𝑎𝑛𝑑 0.3 |     | <   | K̅̅̅̅ < | 0.8 |     |     |
| --- | --- | --- | --- | ----- | --------------- | --- | --- | ------- | --- | --- | --- |
|     |     |     | {   |       | s               |     |     | T       |     |     |     |
In addition to above clearness index based model some other authors have introduced
decomposition models using sunshine duration data which are given in Equations
2.151 to 2.155.
Stanhill (1966),
|     |     |     |     | H̅̅̅̅ |     |     | S̅  |     |     |     |     |
| --- | --- | --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- |
d
|     |     |     |     |     | = 0.964−0.786 |     |      |     |     |     | 2.151  |
| --- | --- | --- | --- | --- | ------------- | --- | ---- | --- | --- | --- | ------ |
|     |     |     |     | H̅  |               |     | S̅̅̅ |     |     |     |        |
0
Iqbal 1 (1979),
|     |     |     |     | H̅̅̅̅ |               |     | S̅   |     |     |     |        |
| --- | --- | --- | --- | ----- | ------------- | --- | ---- | --- | --- | --- | ------ |
|     |     |     |     | d     | = 0.791−0.635 |     |      |     |     |     | 2.152  |
|     |     |     |     | H̅    |               |     | S̅̅̅ |     |     |     |        |
0
Iqbal 2 (1979),
|     |     |     | H̅̅̅̅ |             |     | S̅      |     | S̅   | 2   |     |        |
| --- | --- | --- | ----- | ----------- | --- | ------- | --- | ---- | --- | --- | ------ |
|     |     |     | d =   | 0.163+0.478 |     | −0.655( |     |      | )   |     | 2.153  |
|     |     |     | H̅    |             |     | S̅̅̅    |     | S̅̅̅ |     |     |        |
|     |     |     |       |             |     | 0       |     | 0    |     |     |        |
Gopinathan and Soler 1 (1995),
|     |     |     | H̅̅̅̅ |     |     |     |     |     | S̅  |     |     |
| --- | --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
d
|     |     |     | = 0.87813−0.3328K̅̅̅̅−0.53039 |     |     |     |     |     |      |     | 2.154  |
| --- | --- | --- | ----------------------------- | --- | --- | --- | --- | --- | ---- | --- | ------ |
|     |     |     | H̅                            |     |     |     | T   |     | S̅̅̅ |     |        |
0
Gopinathan and Soler 2 (1995),
2
|     | H̅̅̅̅ |     |     |     |     |     | S̅  |     |     | S̅  |     |
| --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
d
|     |     | = 1.01833−0.33029̅K̅̅̅−0.5311 |     |     |     |     |      | −0.14696( |     | )    | 2.155  |
| --- | --- | ----------------------------- | --- | --- | --- | --- | ---- | --------- | --- | ---- | ------ |
|     | H̅  |                               |     |     |     | T   | S̅̅̅ |           |     | S̅̅̅ |        |
|     |     |                               |     |     |     |     | 0    |           |     | 0    |        |
2.6.3  Estimation of Hourly Irradiance from Daily Irradiance Data
Accurate  determination  of  the  hourly  solar  radiation  received  during  the  day  is
important  in  different  solar  energy  applications,  particularly  in  design  methods.
Page 44

Whillier  (1956)  introduced  the  ‘utilisability’  method  to  predict  analytically  the
performance of active solar collectors. This method used a simple formulation to
estimate the mean hourly radiation during each hour of an average day of the month,
based on the ratio of the hourly to daily irradiations received by a horizontal surface
outside of the atmosphere. The ratio of the hourly global irradiance to the daily
irradiance r in each hour could be expressed as a function of a day length and the
t
midpoint of the relevant hour. Based on the work of Whillier (1956) and Hottel and
Whiller (1958) Liu and Jordan (1960) introduced the mathematical model to estimate
hourly radiation from daily radiation, is given by the Equation 2.156.
|     |     | I   | π   | cosω−cosω |     |     |     |
| --- | --- | --- | --- | --------- | --- | --- | --- |
s
|     |     | r = = | ×    |     |       |     | 2.156  |
| --- | --- | ----- | ---- | --- | ----- | --- | ------ |
|     |     | t H   | 24   |     | πω    |     |        |
|     |     |       | sinω | −   | scosω |     |        |
|     |     |       |      | s   | 180   | s   |        |
Colars-pereira and Rabl (1979a) developed a model to integrate atmospheric effects to
the Liu and Jordan (1960) model as shown in Equation 2.157.
|     |     | π   |     |     | cosω−cosω |     |     |
| --- | --- | --- | --- | --- | --------- | --- | --- |
s
|     | r   | = ×(a+bcosω)× |     |      |     |       |        |
| --- | --- | ------------- | --- | ---- | --- | ----- | ------ |
|     |     | t             |     |      |     | πω    | 2.157  |
|     |     | 24            |     | sinω | −   | scosω |        |
|     |     |               |     |      | s   | 180 s |        |
Where,
|     |     | a = 0.409+0.5016sin(ω |     |     | −60)  |     | 2.158  |
| --- | --- | --------------------- | --- | --- | ----- | --- | ------ |
s
|     |     | b = 0.6609−0.4767sin(ω |     |     |     | −60)  | 2.159  |
| --- | --- | ---------------------- | --- | --- | --- | ----- | ------ |
s
Gueymard (1986) modified Colars-pereira and Rabl (1979a) to ensure consistency of
the equation with the same “a” and “b” constants. The modified equation is shown in
Equation 2.160.
|     |     | π           |     |     | cosω−cosω |     |     |
| --- | --- | ----------- | --- | --- | --------- | --- | --- |
|     |     | ×(a+bcosω)× |     |     |           | s   |     |
r =
|     | t 24 |     |      |     | πω      |        | 2.160  |
| --- | ---- | --- | ---- | --- | ------- | ------ | ------ |
|     |      |     | a+b( |     | s −sinω | cosω ) |        |
|     |      |     |      |     | 180     | s s    |        |
Newell (1983) introduced simple parabolic model to estimate hourly irradiance using
daily irradiance which is given in Equation 2.161.
.
225(𝑡−12)2
45
|     |     |      |      |     |     |     | 2.161  |
| --- | --- | ---- | ---- | --- | --- | --- | ------ |
|     |     | r =  | ×(1− |     |     | )   |        |
|     |     | t 4𝜔 |      |     | 𝜔 2 |     |        |
|     |     |      | 𝑠    |     | 𝑠   |     |        |
Page 45

Where,
|     | t   | :   | midpoint of the hour  |     |     |     |     |     |
| --- | --- | --- | --------------------- | --- | --- | --- | --- | --- |
Jain (1984) introduced another model based on normal distribution introduced another
model which is given in Equation 2.148.
(𝑡−12)2
1
|     |     |     |                |     | [− 2(0.461+0.0256𝜔𝑠 |     | ) ] | 2.162  |
| --- | --- | --- | -------------- | --- | ------------------- | --- | --- | ------ |
|     |     | r = |                |     | ×𝑒                  |     |     |        |
|     |     | t   | (0.461+0.0256𝜔 |     | )√2𝜋                |     |     |        |
𝑠
Baiget all (1991) modified Jain (1984) model for better performance around sunrise
and sunset introduced another model which is given in Equation 2.148.
|     |     |     |     |     | (𝑡−12)2        |            | 𝑡−12  |        |
| --- | --- | --- | --- | --- | -------------- | ---------- | ----- | ------ |
|     |     |     |     |     | {[−            | ]+cos[180( | )]}   |        |
|     |     |     | 1   |     | 2(0.26+0.028𝜔𝑠 | )          | 2𝜔𝑠−1 | 2.163  |
|     | r = |     |     | ×𝑒  |                |            | 15    |        |
t
|     |     | 2(0.26+0.028𝜔 |     | )√2𝜋 |     |     |     |     |
| --- | --- | ------------- | --- | ---- | --- | --- | --- | --- |
𝑠
Conversion ratio for the diffuse radiation could also be done from above models. But
most widely used model is Liu and Jordan (1960) model introduced another model
which is given in Equation 2.148.
|     |     |     | I   | π   | cosω−cosω |       |     |        |
| --- | --- | --- | --- | --- | --------- | ----- | --- | ------ |
|     |     |     | 𝑑   |     |           | s     |     |        |
|     |     |     | r = | = × |           |       |     | 2.164  |
|     |     |     | d H | 24  | πω        |       |     |        |
|     |     |     | 𝑑   |     | sinω −    | scosω |     |        |
|     |     |     |     |     | s 180     | s     |     |        |
2.7  Estimation of Radiation on Tilted Surfaces
Solar radiation received by the tilted surface consists of three components as described
in section 2.3.6. Total radiation on tilted surface could be computed by computing
these three components separately. Beam radiation component of tilted surface could
be computed by multiplying the horizontal beam radiation and relevant beam radiation
tilt factor. Therefore, hourly, daily and monthly averaged daily beam radiation on tilted
surface could be expressed as in Equations 2.165, 2.166 and 2.167 respectively.
|     |     |     |     | I      | = I r         |     |     | 2.165  |
| --- | --- | --- | --- | ------ | ------------- | --- | --- | ------ |
|     |     |     |     | bt     | b b           |     |     |        |
|     |     |     |     | H      | = H R         |     |     | 2.166  |
|     |     |     |     | bt     | b b           |     |     |        |
|     |     |     |     | H̅̅̅̅̅ | = H̅̅̅̅R̅̅̅̅  |     |     | 2.167  |
|     |     |     |     | bt     | b b           |     |     |        |
Ground reflected component of the total radiation on tilted surface could be estimated
using ground reflectance coefficient ρ g  (ground albedo) and view factor between the
ground and the tilted surface. The view factor of the tilted surface to the ground could
be expressed as shown in Equation 2.168.
Page 46

1−cosβ
F = 2.168
c−g 2
Annual variations of ground albedo for various land types for china is shown in Figure
2.13. (ENF: evergreen needle-leaf forest; EBF: evergreen broad-leaf forest; DNF:
deciduous needle-leaf forest; DBF: deciduous broad-leaf forest; MF: mixed forests)
Figure 2.13 - Annual variations of Ground Albedo in China
(Source : Zhengjia LIU, 2015)
Therefore, hourly, daily and monthly averaged daily ground reflected radiation on
tilted surface could be expressed as in Equations 2.169, 2.170 and 2.171 respectively.
(1−cosβ)
I = Iρ 2.169
gt g 2
(1−cosβ)
H = Hρ 2.170
gt g 2
(1−cosβ)
H̅̅̅̅ = H̅ρ 2.171
gt g 2
Estimation of the diffuse radiation is more complex than beam and ground reflected
radiation due to the unpredictable behaviour of the sky. Two distinct types of solar
radiation models developed to estimate diffuse radiation, called isotropic radiation
models and anisotropic radiation models based on the behaviour of the diffuse solar
radiation component of global solar radiation. The isotropic models have been
developed by assuming that intensity of the sky diffuse radiation is uniform over the
Page 47

entire sky dome. The assumption of isotropy of the sky provides a good fit to empirical
data at low intensity conditions found during overcast skies. Isotropic models generally
underestimate the amount of solar radiation falling on tilted surfaces at higher solar
intensities and in clear or partly clear sky situations. In anisotropic sky models sky
radiation has divided into three components as circumsolar, sky dome and horizon
brightening components. The anisotropic models provide good estimates at clear sky
condition and partly cloudy sky conditions and provide poor estimate at overcast sky
conditions.
2.7.1  Isotropic sky hourly radiation models
The first isotropic sky model is developed by the Hottel and Woertz (1942) and latter
refined by the Liu and Jordan (1960). This model estimates the diffuse radiation on
tilted surface by multiplying the horizontal diffuse radiation from sky view factor of
tilted surface. Sky view factor of tilted surface could be written as in Equation 2.172.
1+cosβ
|     |     | F = | = 𝑟   |     | 2.172  |
| --- | --- | --- | ----- | --- | ------ |
|     |     | c−s | 𝑑     |     |        |
2
Where,
|   r ,  :  | Diffuse radiation tilt factor  |     |     |     |     |
| --------- | ------------------------------ | --- | --- | --- | --- |
d
Therefore, hourly diffuse radiation on tilted surface could be expressed as in Equation
2.173.
(1+cos𝛽)
|     |     | I = I |     |     | 2.173  |
| --- | --- | ----- | --- | --- | ------ |
dt 𝑑
2
Therefore, hourly total radiation on tilted surface could be expressed as in Equation
2.174.
|     |         | (1+cos𝛽) | (1−cos𝛽) |     |        |
| --- | ------- | -------- | -------- | --- | ------ |
|     | I = I r | +I       | +Iρ      |     | 2.174  |
|     | t b     | b 𝑑      | 𝑔        |     |        |
|     |         | 2        | 2        |     |        |
Koronakis (1986) examined the Liu and Jordan model and they found that southern
part of sky (in northern hemisphere) is more (63%) responsible for the total radiation.
Based on that, Koronakis (1986) introduced a different equation to estimate diffuse
radiation tilt factor which is given in Equation 2.175.
(2+cosβ)
|     |     | r = |     |     | 2.175  |
| --- | --- | --- | --- | --- | ------ |
d
3
According to the Koronakis (1986) hourly total radiation on tilted surface could be
expressed by the Equation 2.176.
Page 48

|     |     |         | (2+cosβ) |     | (1−cosβ) |     |        |
| --- | --- | ------- | -------- | --- | -------- | --- | ------ |
|     |     | I = I r | +I       | +Iρ |          |     | 2.176  |
|     |     | t b     | b d      | g   |          |     |        |
|     |     |         | 3        |     | 2        |     |        |
Tian et al. (2001) introduced another model to estimate diffuse radiation tilt factor
which is given in Equation 2.177.
β
|     |     |     | r = (1− | )   |     |     | 2.177  |
| --- | --- | --- | ------- | --- | --- | --- | ------ |
d
180
According to the Tian et al. (2001) hourly total radiation on tilted surface could be
expressed as Equation 2.178.
β (1−cosβ)
|     |     |         |         |      |     |     | 2.178  |
| --- | --- | ------- | ------- | ---- | --- | --- | ------ |
|     |     | I = I r | +I (1−  | )+Iρ |     |     |        |
|     |     | t b     | b d 180 | g    | 2   |     |        |
Badescu (2002) introduced another model to estimate diffuse radiation tilt factor which
is given in Equation 2.179.
3+cos2β
|     |     |     | r = ( | )   |     |     | 2.179  |
| --- | --- | --- | ----- | --- | --- | --- | ------ |
d
4
According to the Badescu (2002) total radiation on tilted surface could be expressed
as Equation 2.180.
|     |     |         | 3+cos2β |      | (1−cosβ) |     |        |
| --- | --- | ------- | ------- | ---- | -------- | --- | ------ |
|     |     | I = I r | +I (    | )+Iρ |          |     | 2.180  |
|     |     | t b b   | d       |      | g        |     |        |
|     |     |         | 4       |      | 2        |     |        |
2.7.2  Anisotropic sky hourly radiation models
Temps and Coulson (1977) suggested an anisotropic modification to the clear-sky
diffuse radiance model. Temps and Coulson used clear sky measurements to explain
the anisotropic nature of diffuse irradiation. In their study they observed increased
intensity near the horizon and in the circumsolar region of the sky. Also they found
that 40% greater intensity at horizons than at zenith. They introduced (1+sin3β/2)
factor  to  account  for  the  effects  of  horizons  brightness.    Also  they  introduced
(1+cos2θsin3θ ) factor to account for the effects of circumsolar brightness. Hourly
z
diffuse radiation tilt factor of Temps and Coulson (1977) is given in Equation 2.181.
|     |     | (1+cosβ) |                |     |            | β   |        |
| --- | --- | -------- | -------------- | --- | ---------- | --- | ------ |
|     |     |          | [1+cos2θ(sin3θ |     | )][1+sin3( | )]  | 2.181  |
r =
|     |     | d 2 |     | z   |     | 2   |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
Therefore, Temps and Coulson’s anisotropic model (1977) for the estimation of hourly
total radiation for a tilted surface could be expressed as Equation 2.182.
|     |     | (1+cosβ) |                |     |            | β   |        |
| --- | --- | -------- | -------------- | --- | ---------- | --- | ------ |
|     | I = | I r +I   | [1+cos2θ(sin3θ |     | )][1+sin3( | )]  |        |
|     | t   | b b d    |                |     | z          |     |        |
|     |     |          | 2              |     |            | 2   |        |
|     |     |          |                |     |            |     | 2.182  |
(1−cosβ)
|     |     | +ρ  | I   |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
g
2
Page 49

Bugler (1977) introduced another equation to estimate hourly diffuse radiation tilt
factor which is given in Equation 2.183.
(1+cosβ) I r 1 (1+cosβ)
b b
r = +0.05 [cosθ− ( )] 2.183
d 2 I cosθ 2
d z
Therefore, Bugler’s anisotropic model (1977) for the estimation of hourly total
radiation for a tilted surface could be expressed as Equation 2.184.
(1+cosβ) I r 1 (1+cosβ)
b b
I = I r +I { +0.05 [cosθ− ( )]}
t b b d 2 I cosθ 2
d z
2.184
(1−cosβ)
+ρ I
g 2
Klucher (1979) further studied the models of Liu and Jordan (1960) and Temps and
Coulson (1977) and found that Liu–Jordan isotropic model gives good results under
overcast skies, but under estimates insolation under clear and part-overcast conditions.
Klucher also noted that the Temps and Coulson model provides a good prediction for
clear-sky conditions but overestimates overcast insolation. Klucher used hourly
measured radiation values for New York for a 6-month period on surfaces tilted
towards the equator at 37° and 60° angles. Klucher (1979) proposed new hourly diffuse
radiation tilt factor based on the observations which is given in Equation 2.185.
(1+cosβ) β
r = [1+F′sin3( )](1+F′cos2θsin3θ ) 2.185
d 2 2 z
Where,
I 2
F′ = 1−( d ) 2.186
I
The factor F' is called as the modified clearness index. The first modifying factor
accounts for the horizons brightness and second modifying factor accounts for the
circumsolar brightness. Klucher’s equation (1979) reduced to Liu and Jordan’s (1960)
for the overcast sky and reduced to Temps and Coulson’s (1977) for the clear sky
conditions. Klucher’s anisotropic model (1979) for the estimation of hourly total
radiation for a tilted surface could be expressed as equation 2.187.
(1+cosβ) β
I = I r +I [1+F′sin3( )](1+F′cos2θsin3θ )
t b b d 2 2 z
2.187
(1−cosβ)
+ρ I
g 2
Page 50

Hay (1979) (Hay and Davies 1980) proposed a diffuse radiation tilt factor considering
only isotropic sky and circumsolar component, but horizon brightening is not taken
into account. According to the Hay’s equation (1979) hourly diffuse radiation tilt
factor could be expressed as Equation 2.188.
(1+cosβ)
|     |     |        |        |     | 2.188  |
| --- | --- | ------ | ------ | --- | ------ |
|     |     | r = Ar | +(1−A) |     |        |
|     |     | d      | b      | 2   |        |
Where,
I
bn
|     |     |     | A =   |     | 2.189  |
| --- | --- | --- | ----- | --- | ------ |
I
on
The factor A anisotropic index is used to quantify the portion of the diffuse radiation
treated as circumsolar, with the remaining portion of diffuse radiation is assumed
isotropic.
According to the Hay’s model (1979) hourly total radiation on tilted surface could be
expressed as Equation 2.190.
|     |            |       | (1+cosβ) | (1−cosβ) |          |
| --- | ---------- | ----- | -------- | -------- | -------- |
|     | I = (I +AI | )r +I | (1−A)    | +ρ I     |   2.190  |
|     | t b        | d b d |          | g        |          |
|     |            |       | 2        | 2        |          |
Willmot (1982) introduced new equations for the hourly diffuse radiation tilt factor
using same anisotropic index which is given in Equation 2.191.
|     | r = Ar | +(1.0115−0.20293β−0.080823β2)(1−A)  |     |     | 2.191  |
| --- | ------ | ----------------------------------- | --- | --- | ------ |
|     | d      | b                                   |     |     |        |
According to the Willmot’s model (1982) hourly total radiation on tilted surface could
be expressed as Equation 2.192.
|     | I = (I +AI | )r +I (1.0115−0.20293β−0.080823β2)(1−A) |     |     |        |
| --- | ---------- | --------------------------------------- | --- | --- | ------ |
|     | t b        | d b d                                   |     |     |        |
|     |            | (1−cosβ)                                |     |     | 2.192  |
|     |            | +ρ I                                    |     |     |        |
g
2
By using same anisotropic index and Latitude angle, Skartveit and Olseth (1986)
introduced another hourly diffuse radiation tilt factor which is given in Equation 2.193.
(1+cosβ)
|     |     |                     |     |     | 2.193  |
| --- | --- | ------------------- | --- | --- | ------ |
|     | r   | = Ar +Ωcosβ+(1−A−Ω) |     |     |        |
|     | d   | b                   |     | 2   |        |
Where,
|     |     | Ω = | max{0,(0.3−2A)}  |     | 2.194  |
| --- | --- | --- | ---------------- | --- | ------ |
According to the Skartveit and Olseth’s model (1986) hourly total radiation on tilted
surface could be expressed as Equation 2.195.
Page 51

1+cosβ
|     | I = | (I +AI | )r  | +I  | {Ωcosβ+(1−A−Ω)[ |     |     |     | ]}  |     |
| --- | --- | ------ | --- | --- | --------------- | --- | --- | --- | --- | --- |
|     | t   | b      | d   | b   | d               |     |     |     |     |     |
2
|     |     |     |     |     |     |     |     |     |     | 2.195  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------ |
(1−cosβ)
|     |     |     | +ρ  | I   |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|     |     |     |     | g   | 2   |     |     |     |     |     |
By using the same definition for anisotropy index, Reindl et al. (1990) proposed hourly
diffuse solar radiation tilt factor given in Equation 2.196 which also accounts for the
horizon brightening.
|     |     |     |     |     |     | 1+cosβ |     | β   |     |     |
| --- | --- | --- | --- | --- | --- | ------ | --- | --- | --- | --- |
][1+fsin3(
|     |     | r   | = Ar | +(1−A)[ |     |     |     |     | )]  | 2.196  |
| --- | --- | --- | ---- | ------- | --- | --- | --- | --- | --- | ------ |
|     |     | d   | b    |         |     | 2   |     | 2   |     |        |
Where,
I
|     |     |     |     |     | f = | √ b   |     |     |     | 2.197  |
| --- | --- | --- | --- | --- | --- | ----- | --- | --- | --- | ------ |
I
Reindl et al. (1990) has modified Hay and Davies (1980) model by adding factor like in
Klucher’s model (1979). Therefore, this model is called as HDKR model and is given in
Equation 2.198.
|     |     |     |     |     |     | (1+cosβ) |     |     | β   |     |
| --- | --- | --- | --- | --- | --- | -------- | --- | --- | --- | --- |
[1+fsin3(
|     | I = | (I  | +AI )r | +I  | (1−A) |     |     |     | )]  |        |
| --- | --- | --- | ------ | --- | ----- | --- | --- | --- | --- | ------ |
|     | t   | b   | d      | b   | D     | 2   |     |     | 2   |        |
|     |     |     |        |     |       |     |     |     |     | 2.198  |
(1−cosβ)
|     |     |     | +ρ  | I   |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
g
2
Steven and Unswoth (1980) also proposed an anisotropic model which has the hourly
diffuse radiation tilt factor explained in Equation 2.199.
|     |           |     | 1+cosβ |     | 1.74 |        | πβcosβ |        |     | β         |
| --- | --------- | --- | ------ | --- | ---- | ------ | ------ | ------ | --- | --------- |
|     | r = 0.51r |     | +(     |     | )−   | (sinβ− |        | −πsin2 |     | )  2.199  |
d b
|     |     |     |     | 2   | 1.26π |     | 180 |     |     | 2   |
| --- | --- | --- | --- | --- | ----- | --- | --- | --- | --- | --- |
According to the Steven and Unswoth’s model (1980) hourly total radiation on tilted
surface could be expressed as Equation 2.197.
| I   | = (I +0.51I |     | )r  |        |     |        |        |     |        |        |
| --- | ----------- | --- | --- | ------ | --- | ------ | ------ | --- | ------ | ------ |
| t   | b           |     | d b |        |     |        |        |     |        |        |
|     |             |     |     | 1+cosβ |     | 1.74   | πβcosβ |     |        | β      |
|     |             | +I  | [(  |        | )−  | (sinβ− |        |     | −πsin2 | )]     |
|     |             |     | D   |        |     |        |        |     |        | 2.200  |
|     |             |     |     | 2      |     | 1.26π  | 180    |     |        | 2      |
(1−cosβ)
|     |     | +ρ  | I   |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|     |     |     | g   | 2   |     |     |     |     |     |     |
Iqbal  (1983)  introduced  equations  for  the  hourly  diffuse  radiation  tilt  factor  using
clearness index.
(1+cosβ)
|     |     |     | r   | = k r | +(1−k | )   |     |     |     | 2.201  |
| --- | --- | --- | --- | ----- | ----- | --- | --- | --- | --- | ------ |
|     |     |     | d   | T     | b     | T   |     |     |     |        |
2
According to the Iqbal’s model (1983) hourly total radiation on tilted surface could be
expressed as Equation 2.202.
Page 52

(1+cosβ) (1−cosβ)
I = (I +k I )r +I (1−k ) +ρ I 2.202
t b T d b D T 2 g 2
Perez et al (1986) introduced more detailed model based on three diffuse components and
later Perez et al (1990) introduced modification to the previous model. Perez (1990)
modified hourly radiation tilt factor and the relationship is given in Equation 3.203.
(1+cosβ) a
r = (1−F ) +F +F sinβ 2.203
d 1 2 1b 2
Where,
F : circumsolar brightness factor (given in Equation 2.208)
1
F : horizon brightness factor (given in Equation 2.209)
2
a, b terms accounts for the angle of incident of the cone of circumsolar radiation
(given in Equations 2.204 and 2.205).
a = max(0,cosθ) 2.204
b = max(cos85,cosθ ) 2.205
z
The brightness coefficients F and F are functions of the zenith angle θ , sky
1 2 z
clearness ε (given in Equation 2.206) and brightness Δ (given in Equation 2.207).
I +I
d bn +5.535×10−6θ 3
ε = I d z 2.206
1+5.535×10−6θ 3
z
I
d
Δ = m 2.207
hI
on
πθ
F = max[0,(f +f Δ+ z f )] 2.208
1 11 12 180 13
πθ
F = (f +f Δ+ z f ) 2.209
2 21 22 180 23
Coefficients f , f , f , f , f and f are given in Table 2.5.
11 12 13 21 22 23
Table 2.5 - Perez et al brightness coefficients
ε f f f f f f
11 12 13 21 22 23
1.000 -1.065 -0.008 0.588 -0.062 -0.060 0.072 -0.022
1.065 - 1.230 0.130 0.683 -0.151 -0.019 0.066 -0.029
1.230 - 1.500 0.330 0.487 -0.221 0.055 -0.064 -0.026
1.500 - 1.950 0.568 0.187 -0.295 0.109 -0.152 0.014
1.950 - 2.800 0.873 -0.392 -0.362 0.226 -0.462 0.001
2.800 - 4.500 1.132 -1.237 -0.412 0.288 -0.823 0.056
4.500 - 6.200 1.06 -1.600 -0.359 0.264 -1.127 0.131
6.200 - ∞ 0.678 -0.327 -0.250 0.156 -1.377 0.251
Page 53

According to the Perez (1990) model hourly total radiation on tilted surface could be
expressed as Equation 2.210.
|     |     |     |       | (1+cosβ) |     |     | a   |       |        |
| --- | --- | --- | ----- | -------- | --- | --- | --- | ----- | ------ |
|     |     |     | [(1−F | )        |     |     |     |       |        |
|     | I = | I r | +I    |          |     | +F  | +F  | sinβ] |        |
|     | t   | b b | D     | 1        | 2   |     | 1b  | 2     |        |
|     |     |     |       |          |     |     |     |       | 2.210  |
(1−cosβ)
|     |     |     | +ρ I  |     |     |     |     |     |     |
| --- | --- | --- | ----- | --- | --- | --- | --- | --- | --- |
g
2
2.7.3  Daily radiation and averaged radiation models
Procedure for the calculation of the daily and averaged total radiation on a tilted
surface is same as the hourly radiation. The developed calculation methods for the
daily and averaged radiation on tilted surface are not satisfactory as hourly radiation
models. The first model is introduced by Liu and Jordan (1962) which was later refined
by Klein (1977) is widely used in literature.
As explained in section 3.4.1 this model estimates the diffuse radiation on tilted surface
by multiplying the horizontal diffuse radiation from sky view factor of tilted surface.
Sky view factor of tilted surface could be written as in Equation 2.211.
1+cosβ
|     |     |     |     |     |     |     | R̅̅̅̅  |     | 2.211  |
| --- | --- | --- | --- | --- | --- | --- | ------ | --- | ------ |
|     |     |     | F = |     | =   | R = |        |     |        |
|     |     |     | c−s | 2   |     | d   | d      |     |        |
Where,
, 𝑅̅̅̅̅ :
|   R d |     | Diffuse radiation tilt factors  |     |     |     |     |     |     |     |
| ----- | --- | ------------------------------- | --- | --- | --- | --- | --- | --- | --- |
𝑑
Therefore, daily and monthly averaged daily diffuse radiation on tilted surface could
be expressed as in equations 2.212, and 2.213 respectively.
(1+cosβ)
|     |     |     | H   | = H |     |     |     |     | 2.212  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ------ |
|     |     |     | dt  | d   | 2   |     |     |     |        |
(1+cosβ)
|     |     |     | H̅̅̅̅̅ | = H̅̅̅̅ |     |     |     |     | 2.213  |
| --- | --- | --- | ------ | ------- | --- | --- | --- | --- | ------ |
|     |     |     | dt     | d       |     |     |     |     |        |
2
Therefore, daily and monthly averaged daily total radiation on tilted surface could be
expressed as in Equations 2.214 and 2.215 respectively using equations.
π
|     |     | cos(L−β)cosδsinω |     |     | +   |     | ω sin(L−β)sinδ |     |     |
| --- | --- | ---------------- | --- | --- | --- | --- | -------------- | --- | --- |
|     |     |                  |     |     | ss  | 180 | ss             |     |     |
H = H
π
bt b
|     |     |     | cosLcosδsinω |     | +   |          | ω sinLsinδ |     | 2.214  |
| --- | --- | --- | ------------ | --- | --- | -------- | ---------- | --- | ------ |
|     |     |     |              |     | s   | 180      | s          |     |        |
|     |     |     | (1+cosβ)     |     |     | (1−cosβ) |            |     |        |
|     |     |     | +H           |     | +Hρ |          |            |     |        |
|     |     |     | d            |     |     | g        |            |     |        |
|     |     |     |              | 2   |     |          | 2          |     |        |
π
|     |     | cos(L−β)cosδsinω |     |     | +   |     | ω sin(L−β)sinδ |     |     |
| --- | --- | ---------------- | --- | --- | --- | --- | -------------- | --- | --- |
|     |     |                  |     |     | ss  | 180 | ss             |     |     |
H̅̅̅̅̅ H̅̅̅̅
|     | =   |     |     |     |     | π   |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
bt b
|     |     |     | cosLcosδsinω |     | +    |          | ω sinLsinδ |     | 2.215  |
| --- | --- | --- | ------------ | --- | ---- | -------- | ---------- | --- | ------ |
|     |     |     |              |     | s    | 180      | s          |     |        |
|     |     |     | (1+cosβ)     |     |      | (1−cosβ) |            |     |        |
|     |     |     | +H̅̅̅̅       |     | +H̅ρ |          |            |     |        |

|     |     |     | d   |     |     | g   |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|     |     |     |     | 2   |     |     | 2   |     |     |
Page 54

Klein and Theilacker (1981) introduced a model (KT model) given in Equation 2.216
to estimate daily and averaged total radiation of tilted surface facing the equator.
H̅̅̅ = H̅R̅ 2.216
t
Where,
cos(L−β) H̅̅̅̅ πω
R̅ = {(a− d )(sinω − ss cosω′ )
cosL H̅ ss 180 ss
b πω
+ [ ss +sinω (cosω −2cosω′ )]} 2.217
2 180 ss ss ss
H̅̅̅̅(1+cosβ) (1−cosβ)
d
+ +ρ
H̅ 2 g 2
ω′ = cos−1[(−tan(L−β)tanδ)] 2.218
ss
πω
s
d = sinω − cosω 2.219
s 180 s
Also a and b are same as the Equations given in 2.158 and 2.159.
Klein and Theilacker (1981) later modified the equation to be used for all surfaces.
Modified equation is given in Equation 2.220
H̅̅̅̅(1+cosβ) (1−cosβ)
R̅ = D+ d +ρ 2.220
H̅ 2 g 2
Where,
max[0,G(ω ,ω )] if ω ≥ ω
D = { ss sr ss sr 2.221
max[0,G(ω ,−ω )+G(ω ,ω )] if ω < ω
ss s s sr ss sr
1 bA π
G(ω ,ω ) = [( −a′B)(ω −ω )
1 2 2d 2 1 2 180
+(a′A−bB)(sinω −sinω )−a′C(cosω −cosω )
1 2 1 2
bA 2.222
+ (sinω cosω −sinω cosω )
2 1 1 2 2
bC
+ (sin2ω −sin2ω )]
2 1 2
H̅̅̅̅
a′ = a− d 2.223
H̅
AB+C√A2 −B2 +C2
|ω | = min(ω ,cos−1 ) 2.224
sr s A2 +B2
−|ω | if (A > 𝐵 𝑎𝑛𝑑 𝐵 > 0) or A ≥ B
ω = { sr 2.225
sr |ω | otherwise
sr
Page 55

|     |     |     |     |     | AB−C√A2 |     | −B2 | +C2 |     |
| --- | --- | --- | --- | --- | ------- | --- | --- | --- | --- |
,cos−1
|     | |ω  | | = | min(ω       |     |         |        |         | )   | 2.226  |
| --- | --- | --- | ----------- | --- | ------- | ------ | ------- | --- | ------ |
|     |     | ss  | s           |     |         | A2 +B2 |         |     |        |
|     |     |     | −|ω | if (A | >   | 𝐵 𝑎𝑛𝑑 𝐵 | >      | 0) or A | ≥ B |        |
|     | ω   | = { | ss          |     |         |        |         |     | 2.227  |
sr
|     |     | |ω  | |   otherwise                                           |     |     |     |     |     |     |
| --- | --- | --- | ------------------------------------------------------- | --- | --- | --- | --- | --- | --- |
ss
|     |     |     | A = cosβ+tanLcosγ |     |     | sinβ  |     |     | 2.228  |
| --- | --- | --- | ----------------- | --- | --- | ----- | --- | --- | ------ |
p
|     |     | B = | cosω | cosβ+tanδcosγ |     |     | sinβ  |     |        |
| --- | --- | --- | ---- | ------------- | --- | --- | ----- | --- | ------ |
|     |     |     | s    |               |     |     | p     |     | 2.229  |
sinγ sinβ
|     |     |     |     |     | p   |     |     |     | 2.230  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ------ |
|     |     |     | C   | =   |     |     |     |     |        |
cosL
In addition to the Liu and Jordan’s model (1962) and KT’s model (1981), most of the
other models explained in sections 2.6.1 and 2.6.2 have been used by various other
authors in their papers for calculating the daily radiation and averaged radiation with
modification of diffuse tilt factor. Models given in equations 2.231 to 2.251 were
originally developed to estimate hourly radiation but many authors have used them for
the estimation of daily and averaged radiation. Due to the similarity of the equations,
only daily radiation equations are presented. Monthly averaged radiation model could
be obtained by replacing the daily radiation terms and tilt factors from monthly
averaged daily radiation terms and tilt factors, as shown in below.
Koronakis (1986),
(2+cosβ)
|     |     |     | R = | R̅̅̅̅ = |     |     |     |     | 2.231  |
| --- | --- | --- | --- | ------- | --- | --- | --- | --- | ------ |
d d
3
π
|     |     | cos(L−β)cosδsinω |     |     | +   |     | ω sin(L−β)sinδ |     |     |
| --- | --- | ---------------- | --- | --- | --- | --- | -------------- | --- | --- |
|     |     |                  |     |     | ss  |     | ss             |     |     |
180
| H   | = H |     |     |     |     | π   |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
bt b
|     |     |     | cosLcosδsinω |     | +   |          | ω sinLsinδ |     |        |
| --- | --- | --- | ------------ | --- | --- | -------- | ---------- | --- | ------ |
|     |     |     |              |     | s   | 180      | s          |     | 2.232  |
|     |     |     | (2+cosβ)     |     |     | (1−cosβ) |            |     |        |
|     |     | +H  |              |     | +Hρ |          |            |     |        |
|     |     |     | d            |     |     | g        |            |     |        |
|     |     |     |              | 3   |     |          | 2          |     |        |
Tian et al. (2001),
β
|     |     |     | R = | R̅̅̅̅ = | (1− | )   |     |     | 2.233  |
| --- | --- | --- | --- | ------- | --- | --- | --- | --- | ------ |
|     |     |     | d   | d       |     | 180 |     |     |        |
π
|     |     | cos(L−β)cosδsinω |     |     | +   |     | ω sin(L−β)sinδ |     |     |
| --- | --- | ---------------- | --- | --- | --- | --- | -------------- | --- | --- |
|     |     |                  |     |     | ss  |     | ss             |     |     |
180
H = H
| bt  |     | b   |              |     |      | π        |            |     |        |
| --- | --- | --- | ------------ | --- | ---- | -------- | ---------- | --- | ------ |
|     |     |     | cosLcosδsinω |     | +    |          | ω sinLsinδ |     |        |
|     |     |     |              |     | ss   | 180      | s          |     | 2.234  |
|     |     |     |              | β   |      | (1−cosβ) |            |     |        |
|     |     | +H  | (1−          |     | )+Hρ |          |            |     |        |
|     |     |     | d            | 180 |      | g        | 2          |     |        |
Badescu (2002),
Page 56

(3+cos2β)
|     |     |     | R   | = R̅̅̅̅ = |     |     |     |     |     | 2.235  |
| --- | --- | --- | --- | --------- | --- | --- | --- | --- | --- | ------ |
|     |     |     | d   | d         |     |     |     |     |     |        |
4
π
|     |     |     | cos(L−β)cosδsinω |     | +   |     | ω sin(L−β)sinδ |     |     |     |
| --- | --- | --- | ---------------- | --- | --- | --- | -------------- | --- | --- | --- |
|     |     |     |                  |     | ss  | 180 | ss             |     |     |     |
H = H
|     | bt  | b   |              |     |     | π        |            |     |     |        |
| --- | --- | --- | ------------ | --- | --- | -------- | ---------- | --- | --- | ------ |
|     |     |     | cosLcosδsinω |     | +   |          | ω sinLsinδ |     |     |        |
|     |     |     |              |     | ss  | 180      | s          |     |     | 2.236  |
|     |     |     | (3+cos2β)    |     |     | (1−cosβ) |            |     |     |        |
|     |     |     | +H           |     | +Hρ |          |            |     |     |        |
|     |     |     | d            |     |     | g        |            |     |     |        |
|     |     |     |              | 4   |     |          | 2          |     |     |        |
Hay (1979) and (Hay and Davies 1980),
(1+cosβ)
|     |     |     | R = AR | +(1−A) |     |     |     |     |     | 2.237  |
| --- | --- | --- | ------ | ------ | --- | --- | --- | --- | --- | ------ |
|     |     |     | d      | b      |     |     |     |     |     |        |
2
Where,
H
bn
|     |     |     |     | A = |     |     |     |     |     | 2.238  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------ |
H
on
|     |     |        |       |       | (1+cosβ) |     |     | (1−cosβ) |     |          |
| --- | --- | ------ | ----- | ----- | -------- | --- | --- | -------- | --- | -------- |
|     | H = | (H +AH | )R +H | (1−A) |          |     | +ρ  | H        |     |   2.239  |
|     | t   | b      | d b   | d     |          |     |     | g        |     |          |
|     |     |        |       |       |          | 2   |     | 2        |     |          |
Willmot (1982),
+(1.0115−0.20293β−0.080823β2)(1−A)
|     | R    | = AR |       |                                   |     |     |     |     |     | 2.240  |
| --- | ---- | ---- | ----- | --------------------------------- | --- | --- | --- | --- | --- | ------ |
|     |      | d    | b     |                                   |     |     |     |     |     |        |
| H   | = (H | +AH  | )R +H | (1.0115−0.20293β−0.080823β2)(1−A) |     |     |     |     |     |        |
|     | t    | b    | d b d |                                   |     |     |     |     |     |        |
|     |      |      |       |                                   |     |     |     |     |     | 2.241  |
(1−cosβ)
|     |     | +ρ  | H   |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
g
2
Skartveit and Olseth (1986),
(1+cosβ)
|     |     | R   | = AR +Ωcosβ+(1−A−Ω) |     |     |     |     |     |     | 2.242  |
| --- | --- | --- | ------------------- | --- | --- | --- | --- | --- | --- | ------ |
|     |     | d   | b                   |     |     |     |     |     |     |        |
2
Where,
|     |     |     | Ω = | max{0,(0.3−2A)}  |     |     |     |     |     | 2.243  |
| --- | --- | --- | --- | ---------------- | --- | --- | --- | --- | --- | ------ |
(1+cosβ)
|     | H = | (H +AH | )R +H | [Ωcosβ+(1−A−Ω) |     |     |     |     | ]   |     |
| --- | --- | ------ | ----- | -------------- | --- | --- | --- | --- | --- | --- |
|     | t   | b      | d b   | d              |     |     |     |     |     |     |
2
|     |     |     |     |     |     |     |     |     |     | 2.244  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------ |
1−cosβ
|     |     |     | +ρ H[ |     | ]   |     |     |     |     |     |
| --- | --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- |
|     |     |     | g     | 2   |     |     |     |     |     |     |
Reindl et al. (1990),
|     |     |     |             | (1+cosβ) |     |           |     | β   |     |        |
| --- | --- | --- | ----------- | -------- | --- | --------- | --- | --- | --- | ------ |
|     |     | R   | = AR +(1−A) |          |     | [1+fsin3( |     | )]  |     | 2.245  |
|     |     | d   | b           |          |     |           |     |     |     |        |
|     |     |     |             |          | 2   |           |     | 2   |     |        |
Where,
H
|     |     |     |     | f = | √ b   |     |     |     |     | 2.246  |
| --- | --- | --- | --- | --- | ----- | --- | --- | --- | --- | ------ |
H
Page 57

|     |        |     |     |     |       | (1+cosβ) |     |           | β   |        |
| --- | ------ | --- | --- | --- | ----- | -------- | --- | --------- | --- | ------ |
|     | H = (H | +AH | )R  | +H  | (1−A) |          |     | [1+fsin3( | )]  |        |
|     | t      | b   | d   | b D |       |          |     |           |     |        |
|     |        |     |     |     |       | 2        |     |           | 2   |        |
|     |        |     |     |     |       |          |     |           |     | 2.247  |
(1−cosβ)
|     |     |     | +ρ  | H   |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
g
2
Steven and Unswoth (1980),
(1+cosβ)
|     |           |      |        |     | 1.74  |        | πβcosβ |        | β   |        |
| --- | --------- | ---- | ------ | --- | ----- | ------ | ------ | ------ | --- | ------ |
|     | R = 0.51R | +    |        |     | −     | (sinβ− |        | −πsin2 | )   | 2.248  |
|     | d         | b    |        |     |       |        |        |        |     |        |
|     |           |      |        | 2   | 1.26π |        |        | 180    | 2   |        |
|     | H         | = (H | +0.51H | )R  |       |        |        |        |     |        |
|     | t         | b    |        | d   | b     |        |        |        |     |        |
(1+cosβ)
|     |     |     |     | +H [ |     |        |     |     |     |        |
| --- | --- | --- | --- | ---- | --- | ------ | --- | --- | --- | ------ |
|     |     |     |     | D    | 2   |        |     |     |     |        |
|     |     |     |     |      |     |        |     |     |     | 2.249  |
|     |     |     |     | 1.74 |     | πβcosβ |     | β   |     |        |
−πsin2
|     |     |     |     | −     | (sinβ− |     |     | )]  |     |     |
| --- | --- | --- | --- | ----- | ------ | --- | --- | --- | --- | --- |
|     |     |     |     | 1.26π |        | 180 |     | 2   |     |     |
(1−cosβ)
|     |     |     |     | +ρ H |     |     |     |     |     |     |
| --- | --- | --- | --- | ---- | --- | --- | --- | --- | --- | --- |
g
2
Iqbal (1983),
(1+cosβ)
|     |     |     | R = | K r +(1−K |     | )   |     |     |     | 2.250  |
| --- | --- | --- | --- | --------- | --- | --- | --- | --- | --- | ------ |
|     |     |     | d   | T b       |     | T   |     |     |     |        |
2
|     |        |      |     |         |     | (1+cosβ) |     | (1−cosβ) |     |          |
| --- | ------ | ---- | --- | ------- | --- | -------- | --- | -------- | --- | -------- |
|     | H = (H | +K H | )R  | +H (1−K |     | )        |     | +ρ H     |     |   2.251  |
|     | t b    | T    | d b | D       |     | T        |     | g        |     |          |
|     |        |      |     |         |     | 2        |     |          | 2   |          |
Page 58

3  RESEARCH METHODOLOGY
3.1  Analysis of existing diffuse radiation models
Hourly diffuse radiation models described in Equations 2.172 to 2.210 was analysed
and compared with actual measured data from August 2011 to December 2012 at
Hambathota (6.23° N, 81.08° E) solar park owned to SLSEA. The data has been
recorded  hourly  basis  according  to  the  Local  Standard  Time  (LST).    LST  was
converted to Apparent Solar Time (AST) using Equation 2.32. Actual diffuse radiation
at 7° tilt about east west axis in due south orientation was calculated using Equation
2.61 by substituting measured total tilted radiation, calculated tilted beam radiation
and assumed ground reflected radiation. Tilted beam radiation was calculated using
Equation 2.165 by substituting beam radiation tilt factor using Equation 2.54 and
horizontal  beam  radiation  from  Equation  2.50.  Horizontal  beam  radiation  was
calculated by subtracting the measured horizontal diffuse radiation from measured
global  horizontal  radiation  assuming  that  zero  ground  reflectance  radiation  at
horizontal surface. Ground reflected diffuse radiation was calculated using Equation
2.170 assuming that 0.11 uniform ground reflectance throughout the year.
Model comparison was carried out by using statistical parameters called Mean Bias
Error (MBE), Mean Absolute Error (MAE), Root Mean Square Error (RMSE), Mean
Percentage Error (MPE) and Mean Absolute Percentage Error (APE) which are given
in Equations 3.1 to 3.5
∑(C −M )
|     |        | i i | 3.1  |
| --- | ------ | --- | ---- |
|     | MBE =  |     |      |
n
∑|C −M |
|     |        | i i | 3.2  |
| --- | ------ | --- | ---- |
|     | MAE =  |     |      |
n
∑(C )2
−M
|     | RMSE = √  | i i   | 3.3  |
| --- | --------- | ----- | ---- |
n
|     | (C −M | )          |      |
| --- | ----- | ---------- | ---- |
|     | ∑( i  | i ⁄ )×100% |      |
|     |       | M          | 3.4  |
i
MPE =
n
Page 59

|     |     |        | (C −M | )        |     |     |      |
| --- | --- | ------ | ----- | -------- | --- | --- | ---- |
|     |     |        | i     | i        |     |     |      |
|     |     |        | ∑|    | ⁄ |×100% |     |     |      |
|     |     |        |       | M        |     |     | 3.5  |
|     |     | APE =  |       | i        |     |     |      |
n
Where,
ith calculated value
|   C  i | :   |     |     |     |     |     |     |
| ------ | --- | --- | --- | --- | --- | --- | --- |
ith measured value
|   M  i | :               |     |     |     |     |     |     |
| ------ | --------------- | --- | --- | --- | --- | --- | --- |
|   n    | :  Sample size  |     |     |     |     |     |     |
3.2  Development of new model suitable for dry zone in Sri Lanka
Percentage errors of existing hourly diffuse radiation models were analysed with
various parameters such as clearness index, declination angle, azimuth angle etc. It
was found that declination angle and clearness index have correlation with percentage
errors of models. Figure 3.1 described the variation of percentage variations of annual
average hourly insolation with annual average hourly clearness index and Figure 3.2
described the variations of percentage variations of annual average daily insolation
with annual average daily clearness index.
Variations of percentage variations of predicted diffuse radiation with hourly
clearness index
80%
70%
| n 60% |     |     |     |     |     |     |     |
| ----- | --- | --- | --- | --- | --- | --- | --- |
 fo
o ita
|  s 50% |     |     |     |     |     |     |     |
| ------ | --- | --- | --- | --- | --- | --- | --- |
id
n
| oa 40% |     |     |     |     |     |     |     |
| ------ | --- | --- | --- | --- | --- | --- | --- |
ita r
 d
| ire 30% |     |     |     |     |     |     |     |
| ------- | --- | --- | --- | --- | --- | --- | --- |
as
vu
|  e f f 20% |     |     |     |     |     |     |     |
| ---------- | --- | --- | --- | --- | --- | --- | --- |
gid
a
| tn  d 10% |     |     |     |     |     |     |     |
| --------- | --- | --- | --- | --- | --- | --- | --- |
e
e tc
| c r id | 0%  |     |     |     |     |     |     |
| ------ | --- | --- | --- | --- | --- | --- | --- |
e
Pe
r -10%
p
-20%
-30%
-40%
|     | 0 0.05 0.1 | 0.15 0.2 | 0.25 0.3 | 0.35 0.4 | 0.45 0.5 | 0.55 0.6 |     |
| --- | ---------- | -------- | -------- | -------- | -------- | -------- | --- |
Clearness Index k
T
| Liu and Jordan        |     |     | Koronokis         |     | Tian et al          |     |     |
| --------------------- | --- | --- | ----------------- | --- | ------------------- | --- | --- |
| Badescu               |     |     | Temps and Coulson |     | Bugler              |     |     |
| Klucher               |     |     | Hay               |     | Willmot             |     |     |
| Skartveit and Ollseth |     |     | Reindl            |     | Steven and  Unswoth |     |     |
| Iqbal                 |     |     | Perez             |     |                     |     |     |
Figure 3.1 - Variations of percentage variations of predicted diffuse radiation
with hourly clearness index
Page 60

Variations of percentage variations of predicted diffuse radiation with daily
clearness index
70%
65%
60%
55%
50%
n
fo 45%
o
s n
ita
id
oa 40%
ita r
d
ir
a
e
s
vu 35%
e
f
f
gid
a
tn d
e
30%
e
c
tc
r
e
id
Pe 25%
r
p
20%
15%
10%
5%
0%
-5%
-10%
0.48 0.5 0.52 0.54 0.56 0.58 0.6 0.62
Clearness Index K
T
Liu and Jordan Koronokis Tian et al
Badescu Temps and Coulson Bugler
Klucher Hay Willmot
Skartveit and Ollseth Reindl Steven and Unswoth
Iqbal Perez
Figure 3.2 - Variations of percentage variations of predicted diffuse radiation
with daily clearness index
Figure 3.1 and Figure 3.2 indicate that the significant relevance between the percentage
variations of predicted diffuse radiation and clearness index. Figure 3.1 and Figure 3.2
Page 61

also indicate that models under estimate the diffuse radiation for relatively cloudy sky
conditions and overestimate for clear sky conditions. Figure 3.1 indicates that there
exists exponential relationship between the percentage variations and hourly clearness
index. Variations of percentage variations of monthly averaged daily diffuse insolation
with declination angle are shown in Figure 3.3.
Variations of Percentage variations of predicted diffuse radiation with
declination angle
70%
65%
60%
55%
n
f o
s n
o
o ita
id
a 4
5
5
0
%
%
ita r
d
ire 40%
as
vu
e f f 35%
gid
a
tn d
e
30%
e
c
tc
r
e
id 25%
Pe
r p 20%
15%
10%
5%
0%
-5%
-10%
-24 -21 -18 -15 -12 -9 -6 -3 0 3 6 9 12 15 18 21 24
Declination angle δ
Liu and Jordan Koronokis Tian et al
Badescu Temps and Coulson Bugler
Klucher Hay Willmot
Skartveit and Ollseth Reindl Steven and Unswoth
Iqbal Perez
Figure 3.3 - Variations of Percentage variations of predicted diffuse radiation
with declination angle
Page 62

Figure 3.3 indicates that linear relationship between the percentage variations and
declination angle. Hence various types of nonlinear regression were performed by
modifying the models using clearness index and declination angle to find out suitable
model for dry zone. In addition to that separate nonlinear regressions were performed
for each sky clearness band of Perez et al (1990) model in order to find out new
brightness coefficient for Perez et al (1990) model. Modified models were compared
using statistical parameters to find out more accurate hourly diffuse solar radiation
model to predict diffuse radiation for dry zone in Sir Lanka.
3.3 Estimation of solar radiation potential on horizontal surfaces in dry zone
in Sri Lanka
Measured hourly global horizontal radiation, diffuse horizontal radiation and total
tilted radiation from August 2011 to December 2012 at Hambanthota (6.23° N, 81.08°
E) solar park were used for estimating of averaged daily and hourly insolation.
Calculation of hourly horizontal beam radiation and time conversion were performed
as described in section 3.1. Monthly averaged hourly and daily clearness indexes was
calculated using Equations 2.100 and 2.102 respectively.
3.4 Estimation of solar radiation potential on tilted surfaces in dry zone in Sri
Lanka
The diffuse radiation potential on due south and north faced inclined surfaces of dry
zone was estimated by using modified Perez et al (1990) model and total radiation
potential on tilted surfaces was estimated by adopting estimated diffuse radiation
values. Tilt angles of 0° to 45° with 1° increment for both due south and due north
faced was used for the assessment of radiation potential.
3.5 Estimation of optimum tilt angle for dry zone in Sri Lanka
Daily optimum tilt angles and monthly optimum tilt angles were obtained to maximise
predicted daily and monthly averaged global radiation. Optimum tilt angles for daily
tracking and monthly tracking systems about the east west axis were also calculated.
Page 63

4 RESULTS AND DISCUSSION
4.1 Analysis of existing diffuse radiation models
4.1.1 Isotropic models
Four existing isotropic hourly diffuse radiation models namely Liu and Jordan (1960),
Koronakis (1986), Tian et al (2001) and Badescu (2002) were analysed using hourly
data from August, 2011 to December, 2012 of Hambanthota solar park which is owned
by SLSEA. Predicted annual average hourly insolation from isotropic models and
actual annual average insolation for 7° due south faced surfaces are shown in Figure
4.1 and percentage variations of predictions are shown in Figure 4.2. Percentage
variations of annual average daily insolation predicted from isotropic models are also
plotted in the Figure 4.2.
Annual average hourly diffuse insolation from isotropic models
1.4
1.3
1.2
1.1
1.0
)
2
m
0.9
/J
M
( 0.8
n
o
ita 0.7
lo
s 0.6
n
I
0.5
0.4
0.3
0.2
0.1
0.0
6 7 8 9 0 1 2 3 4 5 6 7 8 9
-
5
-
6
-
7
-
8
1
-
9
1
-
0
1
-
1
1
-
2
1
-
3
1
-
4
1
-
5
1
-
6
1
-
7
1
-
8
1 1 1 1 1 1 1 1 1
Hour
Idt Liu and Jordan Koronokis Tian et al Badescu
Figure 4.1 - Annual average hourly diffuse insolation from isotropic models
Page 64

Percentage varation of hourly diffuse insolation from isotropic models
20%
15%
10%
5%
n
o 0%
ita
ir -5%
a
V
 e -10%
g
a
tn -15%
e
c
r -20%
e P
-25%
-30%
-35%
-40%
| 6 7 8    | 9 0   | 1 2   | 3 4   | 5 6   | 7   | 8 9   |
| -------- | ----- | ----- | ----- | ----- | --- | ----- |
|  -  -  - | - 1   | 1 1   | 1 1   | 1 1   | 1   | 1 1   |
|  5  6  7 |  8  - |  -  - |  -  - |  -  - |  -  |  -  - |
|          |  9    |  0  1 |  2  3 |  4  5 |  6  |  7  8 |
|          |       | 1 1   | 1 1   | 1 1   | 1   | 1 1   |
Hour
| Liu and Jordan                      |     |     | Koronokis                      |     |     |     |
| ----------------------------------- | --- | --- | ------------------------------ | --- | --- | --- |
| Tian et al                          |     |     | Badescu                        |     |     |     |
| Liu and Jordan annual average daily |     |     | Koronakis annual average daily |     |     |     |
| Tian et al annual average daily     |     |     | Badescu annual average daily   |     |     |     |

Figure 4.2 - Percentage variation of hourly diffuse insolation from isotropic
models
All of the isotropic models overestimate the radiation from 0900 hour to 1500 hour
while under estimating in rest of the morning hours and evening hours. Total annual
average daily variation from four isotropic models Liu and Jordan, Koronakis, Tian et
al and Badescu were 5.19%, 5.32%, 1.48% and 4.8% respectively. Comparison among
the models were performed using statistical parameters MBE, MAE, RMSE, MPE and
MAPE and results are illustrated in Table 4.1.
Table 4.1 - Comparison of isotropic models using statistical parameters
| Model           | MBE     | MAE     | RMSE    | MPE     | MAPE    |     |
| --------------- | ------- | ------- | ------- | ------- | ------- | --- |
| Liu and Jordan  | 0.0373  | 0.0903  | 0.1295  | 10.64%  | 24.62%  |     |
| Koronokis       | 0.0382  | 0.0905  | 0.1300  | 10.78%  | 24.63%  |     |
| Tian et al      | 0.0106  | 0.0877  | 0.1192  | 6.74%   | 24.47%  |     |
| Badescu         | 0.0345  | 0.0897  | 0.1281  | 10.23%  | 24.57%  |     |
Page 65

Table 4.1 indicates that Tian et al (2001) model shows minimum values for all five
statistical parameters among four isotropic models. Therefore, it can be concluded that
Tian et al (2001) model predict the hourly diffuse radiation more accurately than other
isotropic models.
4.1.2 Anisotropic models
Ten existing anisotropic hourly diffuse radiation models namely Temps and Coulson
(1977), Bugler (1977), Klucher (1979), Hay (1979), Willmot (1982), Skartveit and
Olseth (1986), Reindel (1990), Stevan and Unswoth (1980), Iqbal (1983) and Perez
(1990) were analysed using same data set used in isotropic models. Predicted annual
average hourly insolation from anisotropic models and actual annual average
insolation for 7° due south faced surface are shown in Figure 4.3 and percentage
variations of predictions are shown in Figure 4.4. Percentage variations of annual
average daily insolation predicted from anisotropic models are also plotted in the
Figure 4.4.
Annual average hourly diffuse insolation from anisotropic models
2.0
1.9
1.8
1.7
1.6
1.5
1.4
2
)1.3
m
/J 1.2
M1.1
(
n1.0
o ita
lo 0
0
.
.
8
9
s0.7
n
I0.6
0.5
0.4
0.3
0.2
0.1
0.0
6 7 8 9 0 1 2 3 4 5 6 7 8 9
-
5
-
6
-
7
-
8
1
-
9
1
-
0
1
-
1
1
-
2
1
-
3
1
-
4
1
-
5
1
-
6
1
-
7
1
-
8
1 1 1 1 1 1 1 1 1
Hour
Idt Temps and Coulson Bugler
Klucher Hay Willmot
Skartveit and Ollseth Reindl Steven and Unswoth
Iqbal Perez
Figure 4.3 - Annual average hourly diffuse insolation from anisotropic models
Page 66

Percentage variation of hourly diffuse insolation from anisotropic models
80%
75%
70%
65%
60%
55%
50%
45%
40%
35%
30%
25%
n
o 20%
ita
ir 15%
a
V
 e 10%
g
a 5%
tn
e
c 0%
r
e
P -5%
-10%
-15%
-20%
-25%
-30%
-35%
-40%
-45%
-50%
-55%
-60%
| 6 7 8    | 9 0   | 1 2   | 3 4   | 5 6   | 7 8   | 9   |
| -------- | ----- | ----- | ----- | ----- | ----- | --- |
|  -  -  - | - 1   | 1 1   | 1 1   | 1 1   | 1 1   | 1   |
|  5  6  7 |  8  - |  -  - |  -  - |  -  - |  -  - |  -  |
|          |  9    |  0  1 |  2  3 |  4  5 |  6  7 |  8  |
|          |       | 1 1   | 1 1   | 1 1   | 1 1   | 1   |
Hour
| Temps and Coulson                      |     |     | Bugler                      |     |     |     |
| -------------------------------------- | --- | --- | --------------------------- | --- | --- | --- |
| Klucher                                |     |     | Hay                         |     |     |     |
| Willmot                                |     |     | Skartveit and Ollseth       |     |     |     |
| Reindl                                 |     |     | Steven and  Unswoth         |     |     |     |
| Iqbal                                  |     |     | Perez                       |     |     |     |
| Temps and Coulson annual average daily |     |     | Bugler annual average daily |     |     |     |
| Klucher annual average daily           |     |     | Hay annual average daily    |     |     |     |
Wilmot annual average daily Skartveit and Ollseth annual average daily
Reindl average annual daily Steven and  Unswoth annual average daily
| Iqbal annual average daily |     |     | Perez annual average daily |     |     |     |
| -------------------------- | --- | --- | -------------------------- | --- | --- | --- |

Figure 4.4 - Percentage variation of hourly insolation from anisotropic models
Page 67

Wilmot (1982) and Steven and Unswoth (1980) models highly overestimate the hourly
radiation among considered models having 31.82% and 54.60% variations of annual
average  diffuse insolation respectively. Temps  and  Coulson  (1977)  and Klucher
(1979) models overestimate the radiation from 0800 hour to 1600 hour while under
estimating the other hours resulting considerable overestimation of total daily diffuse
radiation with variations of 16.21% and 14.49% of annual average daily diffuse
insolation respectively. Behavior of the other anisotropic models Bugler (1979), Hay
(1979), Skartveit and Ollseth (1986), Reindl (1990), Iqbal (1983) and Perez (1986) are
same as the isotropic models having 1.42%, 5.52%, 5.49%, 5.52%, 5.91% and 6.42%
annual average daily diffuse insolation respectively.  Comparison among the models
were performed using statistical parameters MBE, MAE, RMSE, MPE and MAPE and
results are illustrated in Table 4.2.
Table 4.2 - Comparison of anisotropic models using statistical parameters
| Model              | MBE  MAE        | RMSE    | MPE     | MAPE    |
| ------------------ | --------------- | ------- | ------- | ------- |
| Temps and Coulson  | 0.1164  0.1378  | 0.1781  | 20.98%  | 29.68%  |
| Bugler             | 0.0102  0.0993  | 0.1355  | 3.83%   | 27.05%  |
| Klucher            | 0.1040  0.1241  | 0.1684  | 21.43%  | 28.72%  |
| Hay                | 0.0396  0.0898  | 0.1290  | 10.99%  | 24.61%  |
| Willmot            | 0.2285  0.2483  | 0.3636  | 44.41%  | 51.92%  |
Skartveit and Ollseth  0.0394  0.0899  0.1290  10.96%  24.63%
| Reindl               | 0.0397  0.0898  | 0.1290  | 11.00%  | 24.61%  |
| -------------------- | --------------- | ------- | ------- | ------- |
| Steven and  Unswoth  | 0.3921  0.3949  | 0.4959  | 62.56%  | 64.35%  |
| Iqbal                | 0.0424  0.0886  | 0.1283  | 11.15%  | 24.84%  |
| Perez                | 0.0461  0.0928  | 0.1340  | 11.97%  | 25.26%  |
Table 4.2 indicates that Iqbal (1983) model shows minimum values for MAE and
RMSE statistical parameters among ten anisotropic models. Therefore, it can be
concluded that Iqbal (1983) model predict the hourly diffuse radiation more accurately
than other anisotropic models.
4.1.3  Summary of Analysis of existing diffuse radiation models
Monthly averaged daily diffuse insolation for 7° due south faced surfaces were also
predicted for each considered models and results are shown in Figure 4.5. Percentage
variations of the predicted values are shown in the Figure 4.6.
Page 68

Prediction of monthly averaged daily total diffuse tilted insolation
16.5
16.0
15.5
15.0
14.5
14.0
13.5
13.0
12.5
2 m12.0 )
/J
M 11.5
(  n
o
ita 11.0
lo
s
n10.5
I
10.0
9.5
9.0
8.5
8.0
7.5
7.0
6.5
6.0
| y   | y h lir | y   | e   | y   | ts  | r e | r e r e r e | la  |
| --- | ------- | --- | --- | --- | --- | --- | ----------- | --- |
| r a | r a c p | a   | n   | lu  | u   | b   | b b b       | u   |
| u   | u r a A | M   | u   | J   | g   | m   | o m m       | n   |
| n   | r M     |     | J   |     | u   |     | tc          | n   |
| a   | b       |     |     |     | A   | e   | e e         | A   |
| J   | e       |     |     |     |     | tp  | O v c       |     |
|     | F       |     |     |     |     | e   | o e D       |     |
|     |         |     |     |     |     | S   | N           |     |
Month
| Hdt                 |     |     | Liu and Jordan        |     |     |     | Koronokis         |     |
| ------------------- | --- | --- | --------------------- | --- | --- | --- | ----------------- | --- |
| Tian et al          |     |     | Badescu               |     |     |     | Temps and Coulson |     |
| Bugler              |     |     | Klucher               |     |     |     | Hay               |     |
| Willmot             |     |     | Skartveit and Ollseth |     |     |     | Reindl            |     |
| Steven and  Unswoth |     |     | Iqbal                 |     |     |     | Perez             |     |

Figure 4.5 - Prediction of monthly averaged daily total diffuse tilted insolation
Page 69

Percentage variations of predicted monthly averaged daily diffuse tilted
insolation
70%
65%
60%
55%
50%
45%
) 40%
2
m
/J 35%
M
(
 n 30%
o
ita
25%
id
a
R 20%
15%
10%
5%
0%
-5%
-10%
| y   | y h lir   | y   | e n | y   | ts  | r e | r e | r e r e | la  |
| --- | --------- | --- | --- | --- | --- | --- | --- | ------- | --- |
| r a | r a c r p | a M | u   | lu  | u   | b   | b   | b b     | u   |
| u   | u a A     |     | J   | J   | g   | m   | o   | m m     | n   |
| n   | r M       |     |     |     | u   |     | tc  |         | n   |
| a   | b         |     |     |     | A   | e   |     | e e     | A   |
| J   | e         |     |     |     |     | tp  | O   | v c e   |     |
|     | F         |     |     |     |     | e   |     | o D     |     |
|     |           |     |     |     |     | S   |     | N       |     |
Month
| Liu and Jordan        |     |     | Koronokis         |     |     |     |     | Tian et al          |     |
| --------------------- | --- | --- | ----------------- | --- | --- | --- | --- | ------------------- | --- |
| Badescu               |     |     | Temps and Coulson |     |     |     |     | Bugler              |     |
| Klucher               |     |     | Hay               |     |     |     |     | Willmot             |     |
| Skartveit and Ollseth |     |     | Reindl            |     |     |     |     | Steven and  Unswoth |     |
| Iqbal                 |     |     | Perez             |     |     |     |     |                     |     |

Figure 4.6 - Percentage variations of predicted monthly averaged daily diffuse
tilted insolation
Figure 4.6 indicates that four anisotropic models Temps and Coulson (1979), Klucher
(1979), Wilmot (1982) and Steven and Unswoth (1980) are overestimate the daily total
diffuse  radiation  throughout  the  year.  One  isotropic  model  Tian  et  al  and  one
anisotropic model Bugler overestimate the daily total diffuse radiation from vernal
equinox to autumnal equinox while under estimating autumnal to vernal. Other models
overestimate  the  daily  total  diffuse  radiation  around  the  year  except  months  of
November and December. Comparison among the models using statistical parameters
MBE, MAE, RMSE, MPE and MAPE and results are illustrated in Figure 4.7.
Page 70

Comparison of diffuse radiation models using statistical parameters
0.50 75%
0.48 72%
0.46 69%
0.44 66%
0.42 63%
0.40 60%
0.38 57%
0.36 54%
0.34 51%
0.32 48%
0.30 45%
r o
0.28 42% r
r
E
r 0.26 39%  e
o g
r a
r E0.24 36% tn
e
0.22 33% c
r e
0.20 30% P
0.18 27%
0.16 24%
0.14 21%
0.12 18%
0.10 15%
0.08 12%
0.06 9%
0.04 6%
0.02 3%
0.00 0%
| n    | s la   | u n   | r e r e y to | h ld | h la z  |
| ---- | ------ | ----- | ------------ | ---- | ------- |
| a    | ik  te | c o   | lg h a m     | te n | to b e  |
| d    | o      | s e s | c H          | s ie | w q r e |
| r o  | n  n   | d lu  | u u lliW     | llO  | I P     |
| J    | o      | a o   | B lK         | R    | s       |
|  d   | r a iT | B C   |              |      | n       |
|      | o      |  d    |              |  d   | U       |
| n    | K      |       |              | n    |   d     |
| a  u |        | n     |              | a    |         |
|      |        | a     |              |  tie | n       |
| iL   |        |  s    |              |      | a       |
|      |        | p     |              | v    |  n      |
|      |        | m     |              | tr   | e       |
v
|     |     | e   |                          | a k  | e   |
| --- | --- | --- | ------------------------ | ---- | --- |
|     |     | T   |                          |      | tS  |
|     |     |     | Diffused radiation model | S    |     |
|     | MBE |     | MAE                      | RMSE |     |
|     | MPE |     | MAPE                     |      |     |

Figure 4.7 - Comparison of diffuse radiation models using statistical parameters
Figure 4.7 indicates that among all considered models, Bugler anisotropic model has
comparatively high MAE, RMSE and MAPE even though it has least MBE and MPE
values among considered models. Therefore, Bugler model cannot be considered as
accurate model for prediction of diffuse radiation.  Tian et al model has minimum
RMSE, MAE and MAPE values. Hence, it can be concluded that among all considered
Page 71

models Tian et al isotropic model predicts the diffuse radiation more accurately than
other models.
4.2  Development of new diffuse radiation model suitable for dry zone in Sri
Lanka
Existing  hourly  diffuse  solar  radiation  models  were  modified  and  statistically
compared as described in section 3.2. Modified Perez et al (1990) model shows the
better statistical performance and comparison among Tian et al (2001), Bugler (1977),
Iqbal (1983), Perez (1990) and modified model is shown in Table 4.3.
Table 4.3 - Comparison of modified Perez model using statistical parameters
|     |     | Model           |        | MBE     | MAE     | RMSE    | MPE     | MAPE    |     |
| --- | --- | --------------- | ------ | ------- | ------- | ------- | ------- | ------- | --- |
|     |     | Tian et al      |        | 0.0106  | 0.0877  | 0.1192  | 6.74%   | 24.47%  |     |
|     |     | Bugler          |        | 0.0102  | 0.0993  | 0.1355  | 3.83%   | 27.05%  |     |
|     |     |                 | Iqbal  | 0.0424  | 0.0886  | 0.1283  | 11.15%  | 24.84%  |     |
|     |     |                 | Perez  | 0.0461  | 0.0928  | 0.1340  | 11.97%  | 25.26%  |     |
|     |     | Modified Perez  |        | 0.0209  | 0.0735  | 0.1021  | 5.67%   | 19.95%  |     |

Table 4.3 indicates that modified model has minimum values for MAE, RMSE and
MAPE even though MBE and MPE not minimum. Therefore, it can be concluded that
new model can predict the hourly diffuse solar radiation more accurately than previous
hourly diffuse radiation models.
Modified Brightness coefficient of Perez et al (1990) hourly diffuse radiation model
are shown in Table 4.4.
Table 4.4 - Modified Brightness coefficient of Perez et al
|                | ε   |     | f       | f       | f       |     | f       | f       | f       |
| -------------- | --- | --- | ------- | ------- | ------- | --- | ------- | ------- | ------- |
|                |     |     | 11      | 12      | 13      |     | 21      | 22      | 23      |
| 1.000 – 1.065  |     |     | -0.008  | 0.588   | -0.062  |     | 0.055   | -0.194  | -0.011  |
| 1.065 – 1.230  |     |     | 0.130   | 0.683   | -0.151  |     | -0.032  | -0.012  | 0.004   |
| 1.230 – 1.500  |     |     | 0.330   | 0.487   | -0.221  |     | -0.063  | -0.187  | 0.106   |
| 1.500 – 1.950  |     |     | 0.568   | 0.187   | -0.295  |     | -0.204  | -0.120  | 0.212   |
| 1.950 – 2.800  |     |     | 0.873   | -0.392  | -0.362  |     | -0.517  | 0.295   | 0.358   |
| 2.800 – 4.500  |     |     | 1.132   | -1.237  | -0.412  |     | -1.140  | 1.684   | 0.553   |
| 4.500 – 6.200  |     |     | 1.060   | -1.600  | -0.359  |     | -1.732  | 3.224   | 0.923   |
| 6.200 - ∞      |     |     | 0.678   | -0.327  | -0.250  |     | -3.910  | 16.730  | 1.275   |
Page 72

Normal probability plot, residual plot, observation order plot and histogram of the
modified model are shown in Figure 4.9, Figure 4.10, Figure 4.11 and Figure 4.12
respectively.
Normal Probability Plot
4.0
3.5
3.0
e
u2.5
la
V
d2.0
e
tc
id
e1.5
r
P
1.0
0.5
0.0
0 0.5 1 1.5 2 2.5 3 3.5 4
Measured Value
Figure 4.8 - Normal probability plot of modified Perez model
Residual Plot
0.5
0.4
0.3
0.2
0.1
la
u
d 0.0
is
e
R
-0.1
-0.2
-0.3
-0.4
-0.5
0.00 0.50 1.00 1.50 2.00 2.50 3.00 3.50 4.00
Predicted Value
Figure 4.9 - Residual plot of modified Perez model
Page 73

Residual observation order
0.50
0.40
0.30
0.20
0.10
la
u d 0.00
is
e -0.10
R
-0.20
-0.30
-0.40
-0.50
00000000000000000000000000000000000000
0000000000000000000000000000000000000
2468024680246802468024680246802468024
111112222233333444445555566666777
Observation Order
Figure 4.10 - Residual observation order of modified Perez model
Histogram for modified Perez et al (1990) model
1400
1300
1200
1100
1000
900
y
c 800
n
e u 700
q e 600
r
F 500
400
300
200
100
0
086420864208642086420864202468024680246802468024680
544444333332222211111000000000111112222233333444445
.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0
-------------------------
Residual
Figure 4.11 - Histogram for modified Perez et al (1990) model
Figure 4.8 described the normality of the model. Randomly distributed residuals in
Figure 4.9 indicates the appropriateness of the model. Figure 4.10 describes that, there
is no significance deviations of the prediction with considered time period. Therefore,
model can be used for prediction of diffuse radiation throughout the year. Histogram
of the model has symmetrically distributed with negative centre at -0.02 residual value
indicating that approximate normal distribution.
Page 74

4.3  Estimation of solar radiation potential on horizontal surfaces in dry zone
in Sri Lanka
4.3.1  Estimation of Annually averaged hourly radiation
Annual hourly solar energy potential derived from actual measured data from August
2011 to December 2012 at Hambanthota are shown in Figure 4.12. annually averaged
hourly beam normal radiation, beam tilted radiation at 7° tilt angle, diffuse tilted and
diffuse total at same tilt angle and clearness index are also plotted in Figure 4.12 and
same values are tabulated in Table 4.5.
Table 4.5 - Annually averaged hourly Insolation
Annually averaged hourly insolation
| Hour   | I      | I      | I      | I      | I         |   I    | I         |
| ------ | ------ | ------ | ------ | ------ | --------- | ------ | --------- |
|        |        | d      | t      | b      | bt @ β=7° | bn     | dt @ β=7° |
|        | MJ/m2  | MJ/m2  | MJ/m2  | MJ/m2  | MJ/m2     | MJ/m2  | MJ/m2     |
| 5-6    | 0.00   | 0.00   | 0.00   | 0.00   | 0.00      | 0.00   | 0.00      |
| 6-7    | 0.17   | 0.13   | 0.19   | 0.04   | 0.04      | 0.32   | 0.15      |
| 7-8    | 0.81   | 0.42   | 0.89   | 0.38   | 0.39      | 1.09   | 0.50      |
| 8-9    | 1.56   | 0.70   | 1.60   | 0.86   | 0.87      | 1.52   | 0.73      |
| 9-10   | 2.16   | 0.94   | 2.11   | 1.23   | 1.24      | 1.65   | 0.87      |
| 10-11  | 2.60   | 1.12   | 2.49   | 1.48   | 1.50      | 1.70   | 0.99      |
| 11-12  | 2.78   | 1.22   | 2.63   | 1.57   | 1.58      | 1.67   | 1.04      |
| 12-13  | 2.79   | 1.23   | 2.63   | 1.57   | 1.58      | 1.65   | 1.05      |
| 13-14  | 2.60   | 1.14   | 2.49   | 1.46   | 1.47      | 1.64   | 1.01      |
| 14-15  | 2.14   | 0.97   | 2.10   | 1.16   | 1.17      | 1.51   | 0.93      |
| 15-16  | 1.48   | 0.73   | 1.52   | 0.75   | 0.76      | 1.26   | 0.76      |
| 16-17  | 0.76   | 0.44   | 0.83   | 0.32   | 0.32      | 0.82   | 0.50      |
| 17-18  | 0.20   | 0.15   | 0.22   | 0.05   | 0.05      | 0.33   | 0.17      |
| 18-19  | 0.00   | 0.00   | 0.00   | 0.00   | 0.00      | 0.01   | 0.00      |
| Total  | 20.07  | 9.19   | 19.69  | 10.87  | 10.98     | 15.17  | 8.71      |
Page 75

Annually averaged hourly insolation
| 3.0 |     |     |     |     |     |     | 0.75 |
| --- | --- | --- | --- | --- | --- | --- | ---- |
| 2.8 |     |     |     |     |     |     | 0.70 |
| 2.6 |     |     |     |     |     |     | 0.65 |
| 2.4 |     |     |     |     |     |     | 0.60 |
k T
| 2.2 |     |     |     |     |     |     | 0.55  |
| --- | --- | --- | --- | --- | --- | --- | ------ |
)  x
| 2 m 2.0 |     |     |     |     |     |     | 0.50 |
| ------- | --- | --- | --- | --- | --- | --- | ---- |
e
| /J 1 . 8 |     |     |     |     |     |     | 0 . 4 5 d |
| -------- | --- | --- | --- | --- | --- | --- | --------- |
M n
| 1 . 6 |     |     |     |     |     |     | 0 . 4 0 i s |
| ----- | --- | --- | --- | --- | --- | --- | ----------- |
(
|  n 1 . 4 |     |     |     |     |     |     | 0 . 3 5 s e |
| -------- | --- | --- | --- | --- | --- | --- | ----------- |
o n
ita r
| 1 . 2 |     |     |     |     |     |     | 0 . 3 0 a |
| ----- | --- | --- | --- | --- | --- | --- | --------- |
lo e
| 1 . 0 |     |     |     |     |     |     | 0 . 2 5 lc |
| ----- | --- | --- | --- | --- | --- | --- | ---------- |
s  y
| n 0 . 8 |     |     |     |     |     |     | 0 . 2 0 |
| ------- | --- | --- | --- | --- | --- | --- | ------- |
I lr
| 0.6 |     |     |     |     |     |     | 0.15 u |
| --- | --- | --- | --- | --- | --- | --- | ------ |
o
| 0.4   |     |     |     |     |     |     | 0.10 H |
| ----- | --- | --- | --- | --- | --- | --- | ------ |
| 0.2   |     |     |     |     |     |     | 0.05   |
| 0.0   |     |     |     |     |     |     | 0.00   |
| 6 7 8 | 9   | 0 1 | 2 3 | 4 5 | 6 7 | 8   | 9      |
| - - - | -   | 1 1 | 1 1 | 1 1 | 1 1 | 1   | 1      |
| 5 6 7 | 8   | - - | - - | - - | - - | -   | -      |
|       |     | 9 0 | 1 2 | 3 4 | 5 6 | 7   | 8      |
|       |     | 1   | 1 1 | 1 1 | 1 1 | 1   | 1      |
Hour
| I   |     | Id       |     | It       |     |     | Ib  |
| --- | --- | -------- | --- | -------- | --- | --- | --- |
| Ibn |     | Ibt@β=7° |     | Idt@β=7° |     |     | kT  |

Figure 4.12 - Annually averaged hourly insolation
Figure 4.12 indicates that hourly global horizontal radiation is higher than the global
tilted radiation 0900 hour to 1500 hour during the averaged day. It also indicates that
difference between the global horizontal and global tilted radiation is almost equal to
the difference between two diffuse components. There is no significant difference
between the beam horizontal radiation and beam tilted radiation. Hence, it can be
concluded that there is no significant advantage of tilting the surface towards due south
by same angle equal to latitude for fixed axis systems. Figure 4.12 also indicates that
variation of the beam normal radiation and clearness index is significantly low during
the 0800 hour to 1500 hour illustrating that potential of maximising the energy
generation by solar system using single axis hourly tracking system.
4.3.2  Estimation of monthly averaged hourly radiation
Monthly averaged hourly solar energy radiation also derived using the same data set
at Hambanthota. Monthly averaged hourly global horizontal, beam horizontal, diffuse
horizontal, global tilted, beam tilted, diffuse tilted and beam normal plots are shown
in Figure 4.13 to 4.19 respectively. Tabulated values are given in appendix A to G
respectively.
Page 76

Monthly averaged hourly global horizontal insolation
3.4
3.2
3.0
2.8
2.6
)2.4
2
m2.2
/J
M2.0
(1.8
n o1.6
ita 1.4
lo1.2
s
n1.0
I
0.8
0.6
0.4
0.2
0.0
5-6 6-7 7-8 8-9 9-10 10-1111-1212-1313-1414-1515-1616-1717-1818-19
Hour
January February March April
May June July August
September October November December
Annual Average
Figure 4.13 - Monthly averaged hourly global horizontal insolation
Monthly averaged hourly beam horizontal insolation
2.6
2.4
2.2
2.0
1.8
)
2
m
1.6
/J
M
1.4
(
n
o1.2
ita
lo1.0
s
n
I0.8
0.6
0.4
0.2
0.0
5-6 6-7 7-8 8-9 9-10 10-1111-1212-1313-1414-1515-1616-1717-1818-19
Hour
January February March
April May June
July August September
October November December
Annual Average
Figure 4.14 -Monthly averaged hourly beam horizontal insolation
Page 77

Monthly averaged hourly diffuse horizontal insolation
1.6
1.4
1.2
)
2
m
/J 1.0
M
(
n0.8
o
ita
lo 0.6
s
n
I
0.4
0.2
0.0
5-6 6-7 7-8 8-9 9-10 10-1111-1212-1313-1414-1515-1616-1717-1818-19
Hour
January February March
April May June
July August September
October November December
Annual Average
Figure 4.15 - Monthly averaged hourly diffuse horizontal insolation
Monthly averaged hourly tilted insolation (at β= 7°)
3.4
3.2
3.0
2.8
2.6
2.4
)
2 m2.2
/J2.0
M
(1.8
n o1.6
ita1.4
lo
s1.2
n
I1.0
0.8
0.6
0.4
0.2
0.0
5-6 6-7 7-8 8-9 9-10 10-1111-1212-1313-1414-1515-1616-1717-1818-19
Hour
January February March
April May June
July August September
October November December
Annual Average
Figure 4.16 - Monthly averaged hourly tilted insolation (at β = 7°)
Page 78

Monthly averaged hourly beam tilted insolation (at β= 7°)
2.8
2.6
2.4
2.2
2.0
)
2 m1.8
/J
M1.6
(
n1.4
o
ita 1.2
lo
s1.0
n
I0.8
0.6
0.4
0.2
0.0
5-6 6-7 7-8 8-9 9-10 10-1111-1212-1313-1414-1515-1616-1717-1818-19
Hour
January February March
April May June
July August September
October November December
Annual Average
Figure 4.17 - Monthly averaged hourly beam tilted insolation (at β = 7°)
Monthly averaged hourly diffuse tilted insolation (at β= 7°)
1.4
1.2
1.0
)
2
m
/J
M0.8
(
n
o
ita 0.6
lo
s
n I0.4
0.2
0.0
5-6 6-7 7-8 8-9 9-10 10-1111-1212-1313-1414-1515-1616-1717-1818-19
Hour
January February March
April May June
July August September
October November December
Annual Average
Figure 4.18 - Monthly averaged hourly diffuse tilted insolation (at β = 7°)
Page 79

Monthly averaged hourly beam normal insolation
3.0
2.8
2.6
2.4
2.2
2
)2.0
m
/J 1.8
M
1.6
(
n
o1.4
ita1.2
lo
s n1.0
I
0.8
0.6
0.4
0.2
0.0
5-6 6-7 7-8 8-9 9-10 10-1111-1212-1313-1414-1515-1616-1717-1818-19
Hour
January February March
April May June
July August September
October November December
Annual Average
Figure 4.19 - Monthly averaged hourly beam normal insolation
Maximum global horizontal radiation occurs during the months of May and July while
lowest occurs at months of November and December according to the Figure 4.13. In
moths of November and December Sun is traveling on its lowest altitude path in south
and fixed solar systems are tilted to latitude angle to capture energy equally during the
highest and lowest path of Sun. Figure 4.19 also indicates that beam normal radiation
has its lowest values during the month of November and December. Therefore, it
implies that tilting to south by angle equal to latitude angle may not be the optimum
tilted angle.
4.3.3 Estimation of monthly averaged clearness index
Monthly averaged hourly clearness index also calculated and values are tabulated in
Table 4.6. and graphical presentation is given in Figure 4.20. Annually averaged
clearness index and boundary lines between the clear sky conditions and partly cloudy
sky condition also plotted in the Figure 4.20.
Page 80

|     | Table 4.6 - Monthly averaged hourly clearness index K |                                            |     |     |     |     |     | T   |     |     |
| --- | ------------------------------------------------------ | ------------------------------------------ | --- | --- | --- | --- | --- | --- | --- | --- |
|     |                                                        | Monthly averaged hourly clearness index K |     |     |     |     |     |     |     |     |
T
|       |       |     |         |     |      |   r |   r   |   r |     |     |
| ----- | ----- | --- | ------- | --- | ---- | --- | ----- | --- | --- | --- |
|       |   y y |     |         |     |      | e   |   r e | e   |     |     |
|       | r r   | h   |   ril   |     |   st | b   | e b   | b   | al  |     |
|       | a u a | c   | y       | e   | y u  | m   | b m   | m   | u   |     |
| Hour  | u r   | a r | p a     | n   | ul g | e   | o e   | e   | n   |     |
|       | n b   | M   | A M     | u   | J u  | pt  | ct v  | c   | n   |     |
|       | a e   |     |         | J   | A    |     | O o   | e   | A   |     |
|       | J F   |     |         |     |      | e   | N     | D   |     |     |
S
5-6  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.02
6-7  0.32  0.22  0.28  0.37  0.37  0.32  0.35  0.32  0.30  0.29  0.26  0.32  0.31
7-8  0.48  0.37  0.49  0.55  0.51  0.46  0.53  0.47  0.52  0.49  0.38  0.43  0.47
8-9  0.59  0.51  0.60  0.62  0.58  0.54  0.62  0.57  0.59  0.56  0.49  0.53  0.56
9-10  0.65  0.55  0.64  0.61  0.63  0.59  0.63  0.60  0.62  0.56  0.54  0.54  0.59
10-11  0.69  0.61  0.64  0.60  0.66  0.61  0.68  0.60  0.64  0.57  0.54  0.55  0.60
11-12  0.72  0.63  0.58  0.56  0.68  0.60  0.69  0.61  0.65  0.57  0.53  0.51  0.60
12-13  0.66  0.62  0.65  0.57  0.68  0.57  0.64  0.63  0.63  0.61  0.53  0.49  0.60
13-14  0.66  0.61  0.66  0.57  0.66  0.58  0.64  0.60  0.62  0.59  0.53  0.53  0.60
14-15  0.58  0.56  0.67  0.54  0.66  0.57  0.64  0.58  0.59  0.59  0.49  0.45  0.57
15-16  0.57  0.52  0.58  0.44  0.59  0.52  0.57  0.55  0.54  0.48  0.44  0.40  0.51
16-17  0.47  0.43  0.48  0.27  0.50  0.46  0.48  0.49  0.44  0.36  0.35  0.27  0.41
17-18  0.29  0.29  0.33  0.17  0.37  0.35  0.34  0.37  0.30  0.25  0.23  0.15  0.30
18-19  0.09  0.08  0.16  0.11  0.06  0.20  0.19  0.15  0.00  0.00  0.00  0.00  0.15
Daily  0.62  0.56  0.61  0.54  0.62  0.55  0.61  0.57  0.59  0.55  0.48  0.49  0.56
Monthly averaged hourly clearness index
0.8
0.7
0.6
T
k

 x0.5
e
d
n
i s 0.4
s
e n0.3
r
a
e
lC0.2
0.1
0.0
5-6 6-7 7-8 8-9 9-10 10-1111-1212-1313-1414-1515-1616-1717-1818-19
Hour
|     | January |     |     | February  |     |     | March             |     |     |     |
| --- | ------- | --- | --- | --------- | --- | --- | ----------------- | --- | --- | --- |
|     | April   |     |     | May       |     |     | June              |     |     |     |
|     | July    |     |     | August    |     |     | September         |     |     |     |
|     | October |     |     | November  |     |     | December          |     |     |     |
|     | Annual  |     |     | Clear Sky |     |     | Partly Cloudy Sky |     |     |     |
Figure 4.20 - Monthly averaged hourly clearness index
Page 81

According to the Table 4.6 and Figure 4.20 November and December months are
cloudier than other months and January, March, May and July months are lies in the
upper part of the partly cloudy region. According the Figure 4.20 clear sky conditions
occurs only in the 1100 hour to 1200 hour in January for whole year. Figure 4.20 also
indicates that Sri Lanka has partly cloudy sky condition throughout year. Hence, it can
be concluded that diffuse radiation component also has a significant impact on the
global radiation and should be considered when selecting the suitable tilt angles for
solar energy collecting systems.
4.3.4  Estimation of monthly averaged daily radiation
Monthly averaged daily insolation derived from actual measured data from August
2011 to December 2012 at Hambanthota are shown in Figure 4.21. Monthly averaged
daily beam normal radiation, beam tilted radiation at 7° tilt about east west axis in due
south orientation, diffuse tilted and diffuse total at same tilt angle and clearness index
are also plotted in Figure 4.20 and same values are tabulated in Table 4.7.
Monthly averaged daily insolation
| 24  |     |     |     |     | 0.72 |
| --- | --- | --- | --- | --- | ---- |
| 22  |     |     |     |     | 0.66 |
| 20  |     |     |     |     | 0.60 |
| 18  |     |     |     |     | 0.54 |
T
| 16  |     |     |     |     | 0.48 K |
| --- | --- | --- | --- | --- | ------ |
)
2 m 
 x
| /J 14 |     |     |     |     | 0.42 e |
| ----- | --- | --- | --- | --- | ------ |
M d
n
| (  n 12 |     |     |     |     | 0.36 i s |
| ------- | --- | --- | --- | --- | -------- |
o s
| ita 10 |     |     |     |     | 0 . 3 0 e n |
| ------ | --- | --- | --- | --- | ----------- |
r
lo a
| 8   |     |     |     |     | 0 . 2 4 e |
| --- | --- | --- | --- | --- | --------- |
s n lC
I
| 6     |         |      |      |     | 0.18 |
| ----- | ------- | ---- | ---- | --- | ---- |
| 4     |         |      |      |     | 0.12 |
| 2     |         |      |      |     | 0.06 |
| 0     |         |      |      |     | 0.00 |
| y y h | lir y e | y ts | r r  | r r | la   |
| r r c | a n     | lu   | e e  | e e |      |
| a a r | p M u   | u    | b b  | b b | u    |
| u u a | A J     | J g  | m o  | m m | n    |
| n r M |         | u    | e tc | e e | n    |
| a b   |         | A    | tp O | v c | A    |
| J e F |         |      |      | o e |      |
|       |         |      | e    | N D |      |
S
Month
| H              | Ht (@ β = 7°) |     | Hbn            |     | Hb  |
| -------------- | ------------- | --- | -------------- | --- | --- |
| Hbt (@ β = 7°) | Hd            |     | Hdt (@ β = 7°) |     | KT  |

Figure 4.21 - Monthly averaged daily insolation
Page 82

Table 4.7 - Monthly averaged daily insolation
|            |        |        |        | H t         | H bt        | H dt        |        |
| ---------- | ------ | ------ | ------ | ----------- | ----------- | ----------- | ------ |
|            | H      | H      | H      |             |             |             | H      |
| Month      |        | b      | d      | (@ β = 7°)  | (@ β = 7°)  | (@ β = 7°)  | bn     |
|            | MJ/m2  | MJ/m2  | MJ/m2  | MJ/m2       | MJ/m2       | MJ/m2       | MJ/m2  |
| January    | 21.02  | 13.87  | 7.15   | 21.78       | 14.87       | 6.91        | 20.70  |
| February   | 19.99  | 10.32  | 9.67   | 20.05       | 10.79       | 9.58        | 14.29  |
| March      | 22.69  | 14.01  | 8.68   | 22.19       | 14.17       | 8.01        | 19.03  |
| April      | 20.21  | 10.03  | 10.18  | 19.37       | 9.82        | 9.55        | 13.48  |
| May        | 22.75  | 13.52  | 9.23   | 20.88       | 12.90       | 7.97        | 18.34  |
| June       | 19.83  | 8.44   | 11.40  | 18.38       | 7.93        | 10.44       | 11.53  |
| July       | 22.22  | 13.32  | 8.90   | 20.32       | 12.62       | 7.70        | 18.22  |
| August     | 21.26  | 11.18  | 10.08  | 20.02       | 10.80       | 9.21        | 15.32  |
| September  | 22.01  | 12.48  | 9.53   | 21.28       | 12.51       | 8.76        | 16.67  |
| October    | 20.09  | 11.62  | 8.46   | 20.19       | 12.00       | 8.19        | 16.20  |
| November   | 16.48  | 7.47   | 9.02   | 17.21       | 7.95        | 9.25        | 10.94  |
| December   | 16.30  | 7.79   | 8.51   | 17.18       | 8.40        | 8.77        | 11.87  |
| Annual     | 20.07  | 10.87  | 9.19   | 19.69       | 10.98       | 8.71        | 15.17  |
According to the Figure 4.20 and Table 4.6 maximum global horizontal solar resource
potential occurs in May which is 22.75 MJ/m2/day (6.32 kWh/m2/day) and minimum
of 16.30 MJ/m2/day (4.52 kWh/m2/day) occurs in December. The annual average
global horizontal solar insolation is 20.07 MJ/m2/day (5.75 kWh/m2/day). Figure 4.20
also indicates that seasonal variations of solar radiation potential is minimum except
months of November and December which has 18% less potential than the annual
average. According to the Figure 4.20 except Months of January, November and
December all other months global horizontal radiation is higher than the global tilted
radiation.
4.4  Estimation of solar radiation potential on tilted surfaces in dry zone in Sri
Lanka
4.4.1  Annual averaged insolation on tilted surfaces
Predicted annual averaged daily insolation on due south faced surfaces from -45° to
+45° are shown in Figure 4.22.
Page 83

Variation of annual averaged daily insolation on tilted surfaces
)
2
m
/J
M 20
(
n
o
ita
lo 15
s
n
i
d
e
tlit
y
10
lia
d
d
e
g 5
e
r
e
v
a
y
lla 0
u
n -45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45
n
A
Tilt angle β(°)
It Ibt Igt
Idt It max Ibt max
Idt max βoptimum for It βoptimum for Ibt
βoptimum for Idt
Figure 4.22 - Variation of annual averaged daily insolation on tilted surfaces
According to the Figure 4.22 maximum of 20.40 MJ/m2/day (5.67 kWh/m2/day)
annually averaged daily global insolation occurs on due north faced 2° tilted surfaces
and maximum of 11.24 MJ/m2/day (3.12 kWh/m2/day) annually averaged daily beam
insolation occurs on due south faced 6° tilted surfaces. Therefore, it can be suggested
that due north faced 2° tilt angle is suitable for fixed axis solar photovoltaic systems
and parabolic collector systems. In addition to that, due south faced 6° tilt angle which
is equal to latitude angle is more suitable for flat plate collector systems, where its
intention is to utilised the beam radiation as much as possible.
4.4.2 Monthly averaged daily insolation on tilted surfaces
Predicted monthly averaged daily global insolation on due south faced and due north
faced surfaces up to 45° are shown in Figure 4.23. Annually averaged daily values are
also plotted on Figure 4.23 as reference line.
Page 84

Variation of monthly averaged daily global insolation on tilted surfaces
25
)
2
m
/J
M
(
n20
o
ita
lo
s
n
i
d15
e
tlit
y
lia
d
d
10
e
g
e
r
e
v
a
y 5
lh
tn
o
M
0
-45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45
Tilt angle β(°)
January February March
April May June
July August September
October November December
Figure 4.23 - Variation of monthly averaged daily global insolation on tilted
surfaces
According to the Figure 4.23 optimum tilt angle for maximising the daily global
insolation varies throughout the year and maximum for April to August occurs on due
north faced surfaces while maximum for October to February occurs on due south
faced surfaces and maximum for March and September occurs on nearly horizontal
faced surfaces. Hence, it can be concluded that there exist potential to maximise energy
collection by using east-west axis monthly tracking systems.
Monthly averaged daily global insolation, beam insolation, diffuse insolation and
ground reflected insolation for January to December were calculated and graphical
representation with optimum tilt angle and maximum global insolation are given in
Figure 4.24 to Figure 4.35 respectively. Tabulated values for Monthly averaged daily
global insolation, beam insolation and diffuse insolation are given in Appendix H to J
respectively.
Page 85

Variation of monthly averaged daily insolation on tilted surfaces for January
)
2
m
/J 25
M
(
n
o
ita 20
lo
s
n
i
d15
e
tlit
y
lia 10
d
d
e
g
e 5
r
e
v
a
y
lh 0
tn
o -45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45
M
Tilt angle β(°)
It Ibt Igt Idt Maximum It βoptimum
Figure 4.24 - Variation of monthly averaged daily insolation on tilted surfaces
for January
Variation of monthly averaged daily insolation on tilted surfaces for February
)25
2
m
/J
M
(20
n
o
ita
lo15
s
n
i
d
e
tlit
y
10
lia
d
d 5
e
g
e
r
e
v 0
a
y -45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45
lh
tn
Tilt angle β(°)
o
M
It Ibt Igt Idt It max βoptimum
Figure 4.25 - Variation of monthly averaged daily insolation on tilted surfaces
for February
Page 86

Variation of monthly averaged daily insolation on tilted surfaces for March
)
2 m25
/J
M
(
n o20
ita
lo
s
n
i
d
15
e
tlit
y
lia 10
d
d
e
g
e 5
r
e
v
a
y
lh 0
tn
o -45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45
M
Tilt angle β(°)
It Ibt Igt Idt It max βoptimum
Figure 4.26 - Variation of monthly averaged daily insolation on tilted surfaces
for March
Variation of monthly averaged daily insolation on tilted surfaces for April
)
2
m
/J 25
M
(
n
o
ita 20
lo
s
n
i
d
e 15
tlit
y
lia
d 10
d
e
g
e
r
e 5
v
a
y
lh
tn
0
o
M -45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45
Tilt angle β(°)
It Ibt Igt Idt It max βoptimum
Figure 4.27 - Variation of monthly averaged daily insolation on tilted surfaces
for April
Page 87

Variation of monthly averaged daily insolation on tilted surfaces for May
)
2 m25
/J
M
(
n20
o
ita
lo
s
n15
i
d
e
tlit
y10
lia
d
d
e
g 5
e
r
e
v
a
y
lh 0
tn
-45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45
o
M
Tilt angle β(°)
It Ibt Igt Idt It max βoptimum
Figure 4.28 - Variation of monthly averaged daily insolation on tilted surfaces
for May
Variation of monthly averaged daily insolation on tilted surfaces for June
)
2 m25
/J
M
(
n20
o
ita
lo
s15
n
i
d
e
tlit
y
10
lia
d
d 5
e
g
e
r
e
v
a 0
y
lh -45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45
tn
o Tilt angle β(°)
M
It Ibt Igt Idt It max βoptimum
Figure 4.29 - Variation of monthly averaged daily insolation on tilted surfaces
for June
Page 88

Variation of monthly averaged daily insolation on tilted surfaces for July
)
2 m25
/J
M
(
n
o20
ita
lo
s
n
i
d
15
e
tlit
y
lia 10
d
d
e
g
e r 5
e
v
a
y
lh
tn 0
o
M -45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45
Tilt angle β(°)
It Ibt Igt Idt It max βoptimum
Figure 4.30 - Variation of monthly averaged daily insolation on tilted surfaces
for July
Variation of monthly averaged daily insolation on tilted surfaces for August
)
2 m25
/J
M
(
n20
o
ita
lo
s15
n
i
d
e
tlit
y
10
lia
d
d 5
e
g
e
r
e
v 0
a
y -45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45
lh
tn Tilt angle β(°)
o
M
It Ibt Igt Idt It max βoptimum
Figure 4.31 - Variation of monthly averaged daily insolation on tilted surfaces
for August
Page 89

Variation of monthly averaged daily insolation on tilted surfaces for September
)
2
m25
/J
M
(
n
o ita 20
lo
s
n
i
d e15
tlit
y
lia
d10
d
e
g
e
r
e
v
a 5
y
lh
tn
o
M
0
-45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45
Tilt angle β(°)
It Ibt Igt Idt It max βoptimum
Figure 4.32 - Variation of monthly averaged daily insolation on tilted surfaces
for September
Variation of monthly averaged daily insolation on tilted surfaces for October
)
2
m
/J
M
25
(
n
o
ita
lo 20
s
n
i
d
e15
tlit
y
lia
d10
d
e
g
e
r 5
e
v
a
y
lh
0
tn
o -45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45
M
Tilt angle β(°)
It Ibt Igt Idt It max βoptimum
Figure 4.33 - Variation of monthly averaged daily insolation on tilted surfaces
for October
Page 90

Variation of monthly averaged daily insolation on tilted surfaces for November
)
2
m
/J
M25
(
n
o
ita20
lo
s
n
i
d
e15
tlit
y
lia
d10
d
e
g
e
r
e 5
v
a
y
lh
tn
0
o
M -45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45
Tilt angle β(°)
It Ibt Igt Idt It max βoptimum
Figure 4.34 - Variation of monthly averaged daily insolation on tilted surfaces
for November
Variation of monthly averaged daily insolation on tilted surfaces for December
n
o
ita 25
lo
s
n
i
d
20
e
tlit
y2 ) 15
lia
d
m
/J
dM
e( 10
g
e
r
e
v
a 5
y
lh
tn
o 0
M
-45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45
Tilt angle β(°)
It Ibt Igt Idt It max βoptimum
Figure 4.35 - Variation of monthly averaged daily insolation on tilted surfaces
for December
Page 91

Figure 4.24 to Figure 4.35 indicates that optimum tilt angle varies between -26° to
+27° tilt angles and maximum global radiation varies between 24.50 MJ/m2/day (6.8
kWh/m2/day) to 17.46 MJ/m2/day (4.85 kWh/m2/day) throughout the year. Maximum
monthly averaged global, beam and diffuse radiation for each month and optimum tilt
angles are tabulated in Table 4.8.
Table 4.8 - Maximum monthly averaged insolation and optimum tilt angles
|        |     | I  | I  |     | I  |     |      |
| ------ | --- | --- | --- | --- | --- | --- | ---- |
| Month  |     | t   |     | bt  |     | dt  | k   |
T
|            | Maximum  | β optimum   Maximum  |        | β optimum   Maximum  |        | β optimum   |       |
| ---------- | -------- | -------------------- | ------ | -------------------- | ------ | ----------- | ----- |
| January    |          | 23.09  26.00         | 16.54  | 33.00                | 7.15   | -2.00       | 0.62  |
| February   |          | 20.55  15.00         | 11.24  | 23.00                | 9.67   | -1.00       | 0.56  |
| March      |          | 22.69  1.00          | 14.18  | 9.00                 | 8.96   | -16.00      | 0.61  |
| April      |          | 20.63  -13.00        | 10.09  | -6.00                | 10.64  | -20.00      | 0.54  |
| May        |          | 24.50  -24.00        | 14.19  | -18.00               | 10.35  | -31.00      | 0.62  |
| June       |          | 21.41  -25.00        | 9.19   | -23.00               | 12.13  | -24.00      | 0.55  |
| July       |          | 24.29  -26.00        | 14.22  | -20.00               | 10.04  | -32.00      | 0.61  |
| August     |          | 22.08  -17.00        | 11.43  | -12.00               | 10.69  | -22.00      | 0.57  |
| September  |          | 22.04  -3.00         | 12.52  | 5.00                 | 9.84   | -17.00      | 0.59  |
| October    |          | 20.01  10.00         | 12.02  | 18.00                | 8.38   | -8.00       | 0.55  |
| November   |          | 17.46  22.00         | 8.69   | 31.00                | 9.05   | 6.00        | 0.48  |
| December   |          | 17.83  27.00         | 9.55   | 35.00                | 8.58   | 9.00        | 0.49  |
| Annual     |          | 20.40  -2.00         | 11.24  | 6.00                 | 9.44   | -15.00      | 0.57  |
4.5  Estimation of optimum tilt angle for dry zone in Sri Lanka
Daily optimum tilt angles were obtained by predicting daily global insolation on due
south and north faced surfaces. The results were not varying consistently throughout
the year to limited availability of measured data. Therefore, trend line was used to
predict the daily optimum tilt angles and results are shown in Figure 4.36.
Page 92

Daily variation of optimum tilt angle
40
35
30
25
20
15
° ) 10
(
β
e
lg 5
n
a
tliT
0
-5
-10
-15
-20
-25
-30
n
a J - 1 0
n
a J - 1 1
n
a J - 1 2
n
a J - 1 3
b
e F - 0 1
b
e F - 0 2
r
a M - 1 0
r
a M - 1 1
r
a M - 1 2
r
a M - 1 3
r
p A - 0 1
r
p A - 0 2
r
p A - 0 3
y
a M - 0 1
y
a M - 0 2
y
a M - 0 3
n
u J - 9 0
n
u J - 9 1
n
u J - 9 2
lu
J - 9 0
lu
J - 9 1
lu
J - 9 2
g
u A - 8 0
g
u A - 8 1
g
u A - 8 2
p
e S - 7 0
p
e S - 7 1
p
e S - 7 2
tc
O - 7 0
tc
O - 7 1
tc
O - 7 2
v
o N - 6 0
v
o N - 6 1
v
o N - 6 2
c
e D - 6 0
c
e D - 6 1
c
e D - 6 2
Date
It optimum angle Ibt optimum angle
Figure 4.36 - Daily variation of optimum tilt angle
According to the Figure 4.36 it can be concluded that the daily optimum tilt angles are
varying between +28° to -26° throughout the year.
Monthly averaged daily maximum global insolation with monthly tracking and daily
tracking for each month are plotted in the Figure 4.37. Monthly averaged daily global
horizontal, beam horizontal, diffuse horizontal, extra-terrestrial horizontal, global
tilted at tilt angle 7° insulations and optimum monthly averaged daily tilt angle also
plotted in Figure 4.37. Annual optimum fixed tilt angle (-2°) and daily insolation for
same tilt angle are plotted in the Figure 4.37 as reference lines.
Page 93

Monthly averaged daily maximum insolation and optimum tilt angle
40 40
38 35
2 )
m
/J
35 30
M
(  n
o 33 25
ita
lo
s
n 30 20
i d
e
tlit y
28 15
lia
d 25 10
 d )
e °
g (
e β
r 23 5  e
e lg
v
a  y n
a
lh 20 0  tlit m
tn
o
M u
18 -5 m
itp
O
15 -10
13 -15
10 -20
8 -25
5 -30
3 -35
0 -40
| y y     | h lir | y   | e y  | ts  | r r     | r r     |
| ------- | ----- | --- | ---- | --- | ------- | ------- |
| r r     | c     | a   | n lu | u   | e b e b | e b e b |
| a u a u | r a p | M   | u J  | g   | m o     | m m     |
| n r     | M A   |     | J    | u   | tc      |         |
| a b     |       |     |      | A   | e       | e e     |
| J e     |       |     |      |     | tp O    | v c     |
| F       |       |     |      |     | e       | o e     |
|         |       |     |      |     | S       | N D     |
Month
| It Max (monthly tracking) |     |     |     |     | It @β annual optimum    |     |
| ------------------------- | --- | --- | --- | --- | ----------------------- | --- |
| Ib                        |     |     |     |     | Id                      |     |
| I                         |     |     |     |     | It Max (daily tracking) |     |
| Io                        |     |     |     |     | It (@β=7)               |     |
| βoptimum                  |     |     |     |     | βannual optimum         |     |

Figure 4.37 - Monthly averaged daily maximum insolation and optimum tilt angle
According to the Figure 4.37 monthly averaged daily global insolation for monthly
tracking systems and daily tracking systems are higher than the monthly averaged
Page 94

global horizontal insolation and global tilted insolation at 7° due south faced surfaces.
It implies that energy maximising can be done using single axis tracking system about
the east west axis. Figure 4.37 also indicates that there is no significance difference
between the monthly tracking system and daily tracking systems. Percentage
variations between the fixed systems and daily and monthly tracking systems were
calculated and values are tabulated in Table 4.9 and graphical representations given in
Figure 4.38.
Table 4.9 - Maximum solar resource potential with tracking (about E-W axis)
systems
I t Max As
I
t Max
I (monthly I I percentage
t (@β=7) b
Month tracking) (daily tracking) of I
MJ/m2/day MJ/m2/day MJ/m2/day MJ/m2/day MJ/m2/day
January 21.02 23.09 9.83% 23.13 10.04% 21.78 3.59% 13.87 65.99%
February 19.99 20.55 2.81% 20.60 3.05% 20.05 0.28% 10.32 51.64%
March 22.69 22.69 0.00% 22.77 0.37% 22.19 -2.20% 14.01 61.76%
April 20.21 20.63 2.07% 20.66 2.24% 19.37 -4.14% 10.03 49.61%
May 22.75 24.50 7.69% 24.52 7.80% 20.88 -8.22% 13.52 59.44%
June 19.83 21.41 7.94% 21.45 8.15% 18.38 -7.36% 8.44 42.53%
July 22.22 24.29 9.28% 24.32 9.42% 20.32 -8.57% 13.32 59.95%
August 21.26 22.08 3.88% 22.14 4.15% 20.02 -5.83% 11.18 52.57%
September 22.01 22.04 0.15% 22.10 0.41% 21.28 -3.32% 12.48 56.71%
October 19.76 20.01 1.27% 20.05 1.48% 19.87 0.53% 11.44 57.87%
November 16.48 17.46 5.94% 17.49 6.10% 17.21 4.37% 7.47 45.29%
December 16.30 17.83 9.40% 17.87 9.58% 17.18 5.37% 7.79 47.78%
Annual 20.39 21.40 4.96% 21.44 5.16% 19.88 -2.48% 11.18 54.82%
Page 95

Percentage variations of Monthly averaged daily insolation with tracking
systems
11%
10%
9%
8%
7%
) 6%
2
m
/J
M 5%
(
n 4%
o
ita
lo 3%
s
n
i
d
2%
e
tlit
y
1%
lia
0%
d
d
e g -1%
e
r
e
v -2%
a
y
lh -3%
tn
o
M -4%
-5%
-6%
-7%
-8%
-9%
y
r a u n a J
y
r a u r b e F
h
c r a M
lir
p A
y
a M
e
n u J
y
lu J
ts
u g u A
r
e b m e tp e S
r
e b o tc O
r
e b m e v o N
r
e b m e c e D
Month
It Max (monthly tracking) It Max (daily tracking)
It (@β=7) `It Max (monthly tracking - average)
`It Max (daily tracking - average) `It (@β=7 average)
Figure 4.38 - Percentage variations of Monthly averaged daily insolation with
tracking systems
Table 4.9 and Figure 4.38 clearly indicate that additional 4.96 % of annual energy can
be harnessed by using very simple single axis monthly tracking system about the east
Page 96

west axis. It also indicates that there is no significance increment of harnessed energy
by using complex single axis daily tracking systems about the east west axis.
Therefore, it can be suggested monthly single axis tracking systems about the east west
axis is more suitable for the simple solar energy systems. In addition to that Table 4.9
and Figure 4.38 indicates that 2.48% decrement in 7° due south tilted surface than
horizontal surfaces. Therefore, tilting towards due south for fixed systems not
recommended.
MJ
Annual averaged daily horizontal potential in dry zone = 20.39
m2 ×day
kWh
= 5.66
m2 ×day
kWh
Annual horizontal solar resource potential in dry zone = 5.66×365
m2 ×day
kWh
= 2067
m2 ×day
Annual averaged daily solar resource potential in dry MJ
} = 21.40
zone with monthly tracking system m2 ×day
kWh
= 5.94
m2 ×day
Annual solar resource potential in dry kWh
} = 5.94×365
zone with monthly tracking system m2 ×day
kWh
= 2169
m2 ×day
Page 97

5 CONCLUSIONS AND RECOMMENDATIONS
An analysis of existing diffuse radiation models was carried out in this thesis using
ground level measured solar radiation data at Hambanthota obtained from Sri Lanka
Sustainable Energy Authority SLSEA. Global, beam and diffuse solar radiation on
horizontal and 7° tilted towards due south facing surfaces was used for analysing
existing isotropic and anisotropic models. Four isotropic hourly diffuse radiation
models namely Liu and Jordan (1960), Koronakis (1986), Tian et al (2001) and
Badescu (2002) and ten anisotropic hourly diffuse radiation models namely Temps and
Coulson (1977), Bugler (1977), Klucher (1979), Hay (1979), Willmot (1982),
Skartveit and Olseth (1986), Reindel (1990), Stevan and Unswoth (1980), Iqbal (1983)
and Perez (1990) were analysed. Tian et al (2001) isotropic model and Iqbal (1983)
anisotropic model gave a better approximation for diffuse radiation among considered
models. Horizon brightness coefficients of Perez et al (1990) was modified by using
least square error method. Statistical test indicates that modified model gave a better
approximation for the estimation of diffuse radiation than existing models.
Solar resource potential assessment for horizontal and zero azimuth tilted surfaces was
also performed for the dry zone in Sri Lanka using measured hourly solar radiation
data. The calculated monthly averaged daily insolation for dry zone in Sri Lanka varied
between 16.30 MJ/m2/day to 22.75 MJ/m2/day with the annually averaged daily
insolation of 20.07 MJ/m2/day. Seasonal variations of solar radiation potential are
minimum except months of November and December where 18% less potential was
observed than the annual average. Calculated annually averaged beam horizontal
radiation was 10.87 MJ/m2/day and diffuse horizontal radiation was 9.19 MJ/m2/day.
The calculated monthly averaged clearness index for dry zone in Sri Lanka varied
between 0.48 to 0.62 in November and May, July respectively while having 0.56
annual average clearness index indicating partly cloudy sky conditions throughout the
year.
Modified Perez et al (1990) model was used for estimation of titled radiation on due
south and north faced surfaces. Diffuse tilted daily insolation and global tilted
insolation for -45° to +45° inclined surfaces with 1° increments was estimated and
Page 98

optimum tilt angle for each month and annual optimum tilt angle were derived. The
calculated monthly optimum tilt angle varied between -26° to 27° while having annual
optimum tilt angle of -2°. Monthly averaged daily maximum global insolation with
monthly tracking and daily tracking was also calculated. It was found that there is no
significant difference between the daily and monthly tracking performance about east
west axis. Hence, it can be suggested that monthly single axis tracking systems about
the east west axis is more suitable due to its simplicity in solar energy collecting
systems. Optimum tilt angle for beam radiation was derived and it was found that
annual optimum tilt angle for beam radiation is 6° towards due south. The derived
maximum solar resource potential was 2068 kWh/m2 per annum for fixed system at -
2° tilt angle and 2169 kWh/m2 per annum for monthly tracking system which is 4.96%
higher than the horizontal potential.
It is required to validate modified Perez et al (1990) model using another yearly data
set in future and it is not possible to validate model for another tilt angles except 7°
due south due to the unavailability of data for other angles. It is proposed to assess the
solar resource potential for tilted surfaces with different surface azimuth angle by using
modified Perez et al (1990) model in future. It also required to calculate the global
normal radiation for dry zone in order to find optimum tilt angles for hourly tracking
systems. It is also proposed to modify the coefficients of circumsolar brightness
components of Perez et al (1990) model.
Page 99

References
Sri Lanka commissions 10MW solar power plant. (2017, 02 05). Retrieved from
ECONOMYNEXT:
http://www.economynext.com/Sri_Lanka_commissions_10MW_solar_power
_plant-3-6916-8.html
Sri Lanka Energy Balence 2015. (2017, 02 02). Retrieved from Sri Lanka Sustainable
Energy Authority: http://www.info.energy.gov.lk/
windforce. (2017, January 18). Retrieved from POWER PROJECTS:
http://www.windforce.lk/power-projects/solar-one-ceylon.html
UC Santa Barbara Geography. (2010, April 22). Retrieved October 25, 2014, from
Scattering and Absorption:
http://www.geog.ucsb.edu/~joel/g266_s10/lecture_notes/chapt04/oh10_4_2/o
h10_4_2.html
Blue Sky. (2014, August 19). Retrieved October 25, 2014, from HyperPhysics:
http://hyperphysics.phy-astr.gsu.edu/hbase/atmos/blusky.html
Abdullah, Y. (2011). Investigation Of Applicability Of Ashrae Clear-Sky Model To
Izmir, Turkey. Isı Bilimi ve Tekniği Dergisi, 25-32.
Aggarwa, K. (September 2012). Precise estimation of total solar radiation on tilted.
Environmental Science and Technology, 365-370.
Ahmad, M. J., & Tiwari, G. (2008-2). Study of Models for Predicting the Mean Hourly
Global Radiation from Daily Summations. Open Environmental Sciences, 6-
14.
Al-Dabbas, & Ali, M. A. (2010). The analysis of the characteristics of the solar
radiation climate of the daily global radiation and diffuse radiation in Amman,
Jordan. Renewable Energy, 23-38.
Al-Rawahi, N. Z., Zurigat, Y. H., & Al-Azri, N. A. (2011). Prediction of Hourly Solar
Radiation on Horizontal and Inclined Surfaces for Muscat/Oman. Engineering
Research, 19-31.
Al-Rawahi, N. Z., Zurigat, Y. H., & Al-Azri, N. A. (2012). Prediction of global solar
radiation using relativehumidity, maximum temperature and sunshine hours in
Uyo, in the NigerDelta Region, Nigeria. Advances in Applied Science Research
(pp. 1923-1937). Pelagia Research Library.
Anwar, S., Efstathiadis, H., & Qazi, S. (2013). Handbook of Research on Solar Energy
Systems and Technologies. Hershey: IGI Global.
Page 100

ATMS 101 Summer 2003. (n.d.). Retrieved October 29, 2014, from
http://www.ems.psu.edu/~nese/f2_10.gif
Batlles, F., Rubio, M.A., Tovar, J., Olmo, F., & Alados-Arboledas, L. (2000).
Empirical modeling of hourly direct irradiance by means of. Energy, 675-688.
Chandel, S. S., & Aggarwal, R. K. (2011). Estimation of Hourly Solar Radiation on
Horizontal and Inclined Surfaces in Western Himalayas. Smart Grid and
Renewable Energy, 45-55.
Cucumo, M., De Rosa, A., Ferraro, V., Kaliakatsos, D., & Marinelli, V. (n.d.).
Experimental Validation Of Correlations For The Estimation Of Beam And
Diffuse Components Of Hourly Radiation. 61st ATI National Congress –
International Session “Solar Heating and Cooling”.
Dervishi, S., & Mahdavi, A. (2011). Comparison Of Models For The Derivation Of
Diffuse Fraction Of Global Irradiance Data For Vienna, Austria. 12th
Conference of International Building Performance Simulation Association (pp.
765-771). Sydney: Building Performance Simulation Association.
Duffie, J. A., & Beckman, W. A. (2013). Solar Engineering of Thermal Process.
Hoboken: John Wiley & Sons, Inc.
Edeoja, Okibe, A., Eloka-Eboka, & Andrew, C. (2013). Experimental Validation of
Hottel’s Transmittance Model for Estimating Beam Radiation In Makurdi
Location. Engineering Research, 51-57.
El-Sebaii, A. A., Al-Hazmi, F., Al-Ghamdi, A. A., & Yaghmour, S. (2010). Global,
direct and diffuse solar radiation on horizontal and tilted surfaces in Jeddah,
Saudi Arabia. Applied Energy, 568-576.
Emanuele, C. (2012). The Disagreement between Anisotropic-Isotropic Diffuse Solar
Radiation Models as a Function of Solar Declination: Computing the Optimum
Tilt Angle of Solar Panels in the Area of Southern-Italy. Smart Grid and
Renewable Energy, 253-259.
Empirical Correlation for Estimating Components of Light. (n.d.). Retrieved
November 5, 2014, from John A. Dutton e-Education Institute: College of
Earth and Mineral Sciences: https://www.e-
education.psu.edu/eme810/node/543
Gana, N. N., & Akpootu, D. O. (2013). Angstrom Type Empirical Correlation for
Estimating Global Solar Radiation in North-Eastern Nigeria. Engineering And
Science, 58-78.
Geo Appendix A. (n.d.). Retrieved October 20, 2014, from Uniwersytet Im. Adama
Mickiewicza w Poznaniu:
http://geoinfo.amu.edu.pl/wpk/geos/GEO_APPENDIX_A.HTML
Page 101

Gueymard, C. A. (1986). Monthly Averages of the Daily Effective Optical Air Mass
and Solar Related Angles for Horizontal or Inclined Surfaces. Solar Energy,
320-324.
Gueymard, C. A. (2003). Direct solar transmittance and irradiance predictions with
broadband models. Part I: detailed theoretical performance assessment. Solar
Energy, 355-379.
Gueymard, C. A. (2008). From Global Horizontal To Global Tilted Irradiance: How
Accurate Are Solar Energy Engineering Predictions In Practice? Solar 2008
Conference. San Diego: American Solar Energy Society.
Gulin, M., Vasak, M., & Baotic, M. (n.d.). Estimation of the global solar irradiance
on tilted surfaces.
Hussein, T. A. (2012). Estimation of Hourly Global Solar Radiation in Egypt Using
Mathematical Model. Latest Trends in Agriculture & Food Sciences, 74-82.
Idso, B., & Sherwood. (1969). Atmospheric Attenuation of Solar Radiation.
Atmospheric Sciences, 1088-1095.
Ihya, B., Mechaqrane, A., Tadili, R., & Bargach, M. N. (2014). Optimal tilt angles for
solar collectors facing south at Fez city (Morocco). Natural Sciences Research,
120-127.
Ineichen, P. (2008). Comparison and validation of three global-to-beam irradiance
models against ground measurements. Solar Energy, 501-512.
Jakhrani, A. Q., Othman, K., Rigit, A. R., Samo, S. R., & Kamboh, S. A. (December
2012). Estimation of Incident Solar Radiation on Tilted Surface by Different
Empirical Models. Scientific and Research Publications, 1-6.
Jakhrani, A. Q., Samo, S. R., Rigit, A. R., & Kamboh, S. A. (2013). Selection of
Models for Calculation of Incident Solar Radiation on Tilted Surfaces. World
Applied Sciences, 1334-1343.
Kasten, F., & Young, A. T. (1989). Revised Optical Air Mass Tables and
Approximation Formula. Applied Optics, 4735-4738.
Keith, F., & Kreider, J. F. (2011). Principles of Sustainable Energy. Boca Raton:
Taylor and Francis Group, LLC.
Khan, M. M., & Ahmad, M. J. (2012). Estimation of global solar radiation using clear
sky radiation in Yemen. Engineering Science and Technology Review, 12-19.
Kuo, C., Chang, W., & Chang, K. (2014). Modeling the hourly solar diffuse fraction
in Taiwan. Renewable Energy, 56-61.
Layers of Earth's Atmosphere . (n.d.). Retrieved October 15, 2014, from
windows2universe:
Page 102

http://www.windows2universe.org/earth/Atmosphere/layers_activity_print.ht
ml
Lealea, T., & Tchinda, R. (2013). Estimation of Diffuse Solar Radiation in the South
of Cameroon. Energy Technologies and Policy, 32-42.
Liu, B. Y., & Jordan, R. C. (1960). The Interrelationship and Characteristic
Distribution of Direct, Diffuse and Total Solar Radiation. Solar Energy, 1-9.
Loutzenhiser, P., Manz, H., Felsmann, C., Strachan, P., Frank, T., & Maxwell, G.
(2006). Empirical validation of models to compute solar irradiance on inclined
surfaces for building energy simulation. Solar Energy, 254-267.
Muneer, T., Gueymard, C., & Kambezidis, H. (2004). Solar Radiation and Daylight
Models. Burlington: Elsevier Ltd.
Olayinka, S. (2011). Estimation of global and diffuse solar radiations for selected cities
in Nigeria. International Journal of Energy and Environmental Engineering,
13-33.
Oliveira, A. P., Escobedo, J. F., Machado, A. J., & Soares, J. (2002). Correlation
models of diffuse solar-radiation applied to the city of Sa˜o Paulo, Brazil.
Applied Energy, 59-73.
Orgill, J. F., & Hollands, K. G. (1977). Correlation Equation For Hourly Diffuse
Radiation On A Horizontal Surface. Solar Energy, 357-359.
Raichijk, C., Fasulo, A., & Gallegos, H. G. (2009). Estudio De Validación De Las
Correlaciones Para La Fracción Difusa De La Irradiación Solar En San Luis.
Avances en Energías Renovables y Medio Ambiente, 11.17-11.24.
Reindl, D. T., Beckman, W. A., & Duffle, J. A. (1990). Diffuse Fraction Correlations.
Solar Energy, 1-7.
Rivington, M., Bellocchi, G., Matthews, K. B., & Buchan, K. (2005). Evaluation of
three model estimations of solar radiation at 24 UK stations. Agricultural and
Forest Meteorology, 228–243.
Sen, Z. (2008). Solar Energy Fundamentals and Modeling Techniques: Atmosphere,
Environment, Climate Change. Springer-Verlag London Limited.
Singh, J., Bhattacharya, B. l., Kumar, M., & Mallick, K. (2013). Modelling monthly
diffuse solar radiation fraction and its validity over the Indian sub-tropics.
Climatology, 77-86.
Soteris, K. (2009). Solar energy engineering : processes and systems. Burlington:
Elsevier Inc.
Souza, A. P., & Escobedo, J. F. (2013). Estimates of Hourly Diffuse Radiation on
Tilted Surfaces in Southeast of Brazil. Renewable Energy Research.
Page 103

Talebizadeh, P., Mehrabian, M., & Abdolzadeh, M. (2011). Prediction of the optimum
slope and surface azimuth angles using the Genetic Algorithm. Energy and
Buildings, 2998-3005.
Team, E. W. (2005, October 1). Education and Outreach : Teacher Lesson Plans.
Retrieved October 15, 2014, from Earth System Research Laboratory: Global
Monitoring Division: http://www.esrl.noaa.gov/gmd/outreach/lesson_plans/
The Sun as a Source of energy: Part 1: Solar Astronomy. (n.d.). Retrieved October 10,
2014, from ITACA: http://www.itacanet.org/the-sun-as-a-source-of-
energy/part-1-solar-astronomy/
Viorel, B. (2008). Modeling Solar Radiation at the Earth’s Surface Recent Advances.
Berlin Heidelberg: Springer.
Web materials shown in class. (n.d.). Retrieved October 20, 2014, from Earth System
science Center: http://www.essc.psu.edu/~dbabb/Chapter_2/sun-earth-
radiation.jpg
Wong, L., & Chow, W. (2001). Solar radiation model. Applied Energy, 191–224.
Page 104

Appendix A  Monthly averaged hourly global horizontal insolation
Monthly averaged hourly Global horizontal insolation I
|     |     |       |     |     |     |   r |     |   r |     |
| --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- |
|     |   y |       |     |     |     | e   |   r | e   | e r |
| y   | r   |   h   |     |     | st  | b   | e   | b   | b   |
| a r | a   | c ril | y e | y   | u   | m   | b   | m   | m   |
|   u | u   | r p   | a n | ul  | g   | e   | o   |     |     |
| n   | b r | M a A | M u |     | u   | pt  | ct  | v e | e   |
| a   | e   |       | J   | J   | A   |     | O   | o   | e c |
| J   | F   |       |     |     |     | e   |     | N   | D   |
S
Hour  MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2
5-6  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00
6-7  0.07  0.05  0.10  0.22  0.26  0.21  0.19  0.18  0.20  0.22  0.20  0.10
7-8  0.63  0.50  0.77  1.00  0.94  0.81  0.89  0.80  0.97  0.96  0.77  0.58
8-9  1.43  1.27  1.62  1.80  1.66  1.49  1.67  1.59  1.76  1.72  1.49  1.26
9-10  2.18  1.91  2.37  2.32  2.36  2.12  2.26  2.21  2.40  2.19  1.98  1.85
10-11  2.79  2.58  2.83  2.67  2.84  2.55  2.85  2.60  2.86  2.57  2.34  2.18
11-12  3.20  2.93  2.80  2.70  3.14  2.71  3.11  2.86  3.11  2.77  2.29  2.32
12-13  2.97  2.94  3.18  2.76  3.17  2.58  2.96  2.98  3.06  2.90  2.20  2.32
13-14  2.83  2.75  3.08  2.58  2.87  2.46  2.78  2.71  2.79  2.57  2.19  2.17
14-15  2.14  2.25  2.73  2.12  2.50  2.14  2.43  2.29  2.26  2.17  1.57  1.69
15-16  1.66  1.64  1.85  1.35  1.75  1.55  1.75  1.70  1.59  1.32  1.01  1.17
16-17  0.90  0.91  1.03  0.55  0.97  0.91  0.99  1.01  0.81  0.58  0.39  0.55
17-18  0.21  0.27  0.31  0.14  0.29  0.31  0.33  0.33  0.19  0.10  0.05  0.10
18-19  0.00  0.00  0.01  0.00  0.00  0.01  0.01  0.01  0.00  0.00  0.00  0.00
Total  21.02  19.99  22.69  20.21  22.75  19.83  22.22  21.26  22.01  20.09  16.48  16.30

Page 105

Appendix B  Monthly averaged hourly beam horizontal insolation
|     |     | Monthly averaged hourly beam horizontal insolation I |     |     |     |     |     |     |     |
| --- | --- | ----------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
b
|     |     |       |     |     |     |   r |     |   r |     |
| --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- |
|     |   y |       |     |     |     | e   |   r | e   | e r |
| y   | r   |   h   |     |     | st  | b   | e   | b   | b   |
| a r | a   | c ril | y e | y   | u   | m   | b   | m   | m   |
|   u | u   | r p   | a n | ul  | g   | e   | o   |     |     |
| n   | b r | M a A | M u |     | u   | pt  | ct  | v e | e   |
| a   | e   |       | J   | J   | A   |     | O   | o   | e c |
| J   | F   |       |     |     |     | e   |     | N   | D   |
S
Hour  MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2
5-6  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00
6-7  0.02  0.01  0.01  0.05  0.08  0.03  0.04  0.04  0.04  0.06  0.05  0.02
7-8  0.35  0.19  0.39  0.47  0.45  0.27  0.40  0.35  0.51  0.57  0.33  0.23
8-9  0.93  0.67  1.04  0.96  0.94  0.59  0.92  0.82  1.04  1.04  0.75  0.65
9-10  1.49  1.07  1.54  1.21  1.43  0.96  1.33  1.16  1.43  1.27  1.00  1.05
10-11  2.01  1.44  1.86  1.33  1.78  1.19  1.77  1.34  1.68  1.51  1.21  1.16
11-12  2.38  1.65  1.68  1.26  1.99  1.27  2.05  1.52  1.83  1.61  1.07  1.14
12-13  2.03  1.57  1.92  1.37  2.02  1.20  1.85  1.64  1.81  1.78  0.97  1.12
13-14  1.92  1.45  1.94  1.40  1.78  1.07  1.73  1.50  1.65  1.56  0.99  1.03
14-15  1.30  1.13  1.79  1.16  1.51  0.94  1.54  1.26  1.27  1.26  0.66  0.73
15-16  0.96  0.74  1.17  0.63  0.99  0.58  1.05  0.94  0.83  0.69  0.38  0.47
16-17  0.43  0.34  0.57  0.16  0.45  0.29  0.52  0.49  0.35  0.26  0.08  0.16
17-18  0.05  0.06  0.10  0.02  0.09  0.06  0.11  0.12  0.05  0.03  0.00  0.02
18-19  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00
Total  13.87  10.32  14.01  10.03  13.52  8.44  13.32  11.18  12.48  11.62  7.47  7.79

Page 106

Appendix C  Monthly averaged hourly diffuse horizontal insolation
|     |     | Monthly averaged hourly diffuse horizontal insolation I |     |     |     |     |     |     |     |
| --- | --- | -------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
dt
|     |     |       |     |     |     |   r |     |   r |     |
| --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- |
|     |   y |       |     |     |     | e   |   r | e   | e r |
| y   | r   |   h   |     |     | st  | b   | e   | b   | b   |
| a r | a   | c ril | y e | y   | u   | m   | b   | m   | m   |
|   u | u   | r p   | a n | ul  | g   | e   | o   |     |     |
| n   | b r | M a A | M u |     | u   | pt  | ct  | v e | e   |
| a   | e   |       | J   | J   | A   |     | O   | o   | e c |
| J   | F   |       |     |     |     | e   |     | N   | D   |
S
Hour  MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2
5-6  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00
6-7  0.05  0.04  0.09  0.17  0.19  0.18  0.15  0.13  0.16  0.15  0.15  0.07
7-8  0.29  0.31  0.38  0.53  0.50  0.54  0.49  0.45  0.46  0.39  0.44  0.35
8-9  0.50  0.59  0.58  0.84  0.72  0.90  0.75  0.76  0.72  0.69  0.75  0.61
9-10  0.70  0.84  0.83  1.11  0.93  1.16  0.92  1.05  0.97  0.92  0.98  0.80
10-11  0.78  1.14  0.97  1.34  1.05  1.36  1.08  1.26  1.18  1.07  1.13  1.02
11-12  0.83  1.28  1.12  1.44  1.15  1.44  1.06  1.33  1.28  1.16  1.23  1.18
12-13  0.94  1.37  1.26  1.39  1.14  1.38  1.11  1.34  1.25  1.12  1.23  1.20
13-14  0.91  1.30  1.15  1.19  1.08  1.39  1.05  1.21  1.14  1.01  1.21  1.14
14-15  0.84  1.12  0.93  0.96  0.98  1.20  0.89  1.03  0.99  0.91  0.92  0.97
15-16  0.69  0.90  0.68  0.72  0.75  0.96  0.70  0.76  0.76  0.63  0.64  0.70
16-17  0.47  0.57  0.46  0.38  0.51  0.62  0.47  0.52  0.47  0.33  0.31  0.39
17-18  0.16  0.21  0.22  0.12  0.21  0.25  0.22  0.22  0.15  0.07  0.04  0.08
18-19  0.00  0.00  0.01  0.00  0.00  0.01  0.01  0.01  0.00  0.00  0.00  0.00
Total  7.15  9.67  8.68  10.18  9.23  11.40  8.90  10.08  9.53  8.46  9.02  8.51

Page 107

Appendix D  Monthly  averaged  hourly  global  tilted  (β  =  7°)
insolation
|     |     | Monthly averaged hourly Global tilted insolation I |       |       |      | t (β = 7°) |     |     |     |
| --- | --- | --------------------------------------------------- | ----- | ----- | ---- | ---------- | --- | --- | --- |
|     |     |                                                     |       |       |      |   r        |     |   r |   r |
|   y | y   |                                                     |       |       |      | e          |   r | e   | e   |
| r   | a r | h                                                   |   ril |       |   st | b          | e   | b   | b   |
| a   | u   | c                                                   |       | y n e | y u  | m          | b   | m   | m   |
|   u | r   | a r                                                 | p     | a     | ul g | e          | o   | e   | e   |
| n   | b   | M                                                   | A     | M u   | J u  | pt         | ct  | v   | c   |
| a   | e   |                                                     |       | J     | A    |            | O   | o   | e   |
| J   | F   |                                                     |       |       |      | e          |     | N   | D   |
S
MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2
Hour
5-6  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00
6-7  0.10  0.06  0.11  0.23  0.26  0.21  0.19  0.18  0.22  0.27  0.24  0.12
7-8  0.83  0.59  0.87  1.04  0.93  0.78  0.85  0.83  1.06  1.11  0.91  0.71
8-9  1.63  1.37  1.69  1.79  1.55  1.41  1.57  1.55  1.76  1.79  1.62  1.41
9-10  2.29  1.95  2.33  2.21  2.12  1.94  2.06  2.07  2.29  2.17  2.04  1.94
10-11  2.81  2.55  2.70  2.49  2.54  2.31  2.55  2.40  2.68  2.50  2.35  2.22
11-12  3.12  2.83  2.62  2.51  2.82  2.45  2.75  2.61  2.89  2.65  2.29  2.34
12-13  2.84  2.80  2.94  2.55  2.84  2.34  2.64  2.71  2.83  2.78  2.21  2.33
13-14  2.77  2.64  2.89  2.42  2.60  2.26  2.51  2.49  2.63  2.52  2.23  2.22
14-15  2.19  2.21  2.65  2.04  2.31  2.00  2.23  2.15  2.20  2.20  1.67  1.79
15-16  1.83  1.70  1.89  1.35  1.67  1.48  1.66  1.66  1.62  1.41  1.13  1.31
16-17  1.10  1.02  1.13  0.57  0.94  0.88  0.96  1.03  0.88  0.68  0.45  0.66
17-18  0.28  0.32  0.36  0.16  0.29  0.30  0.32  0.33  0.22  0.12  0.06  0.14
18-19  0.00  0.00  0.01  0.00  0.00  0.01  0.02  0.01  0.00  0.00  0.00  0.00
Total  21.78  20.05  22.19  19.37  20.88  18.38  20.32  20.02  21.28  20.19  17.21  17.18

Page 108

Appendix E  Monthly  averaged  hourly  beam  tilted  (β  =  7°)
insolation
|     |     | Monthly averaged hourly beam tilted insolation I |       |       |      | bt (β = 7°) |     |     |     |
| --- | --- | ------------------------------------------------- | ----- | ----- | ---- | ----------- | --- | --- | --- |
|     |     |                                                   |       |       |      |   r         |     |   r |   r |
|   y | y   |                                                   |       |       |      | e           |   r | e   | e   |
| r   | a r | h                                                 |   ril |       |   st | b           | e   | b   | b   |
| a   | u   | c                                                 |       | y n e | y u  | m           | b   | m   | m   |
|   u | r   | a r                                               | p     | a     | ul g | e           | o   | e   | e   |
| n   | b   | M                                                 | A     | M u   | J u  | pt          | ct  | v   | c   |
| a   | e   |                                                   |       | J     | A    |             | O   | o   | e   |
| J   | F   |                                                   |       |       |      | e           |     | N   | D   |
S
MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2
Hour
5-6  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00
6-7  0.04  0.01  0.02  0.05  0.06  0.02  0.02  0.03  0.03  0.07  0.06  0.04
7-8  0.41  0.21  0.40  0.45  0.41  0.23  0.35  0.33  0.51  0.60  0.37  0.27
8-9  1.02  0.72  1.05  0.94  0.89  0.54  0.85  0.79  1.04  1.08  0.80  0.71
9-10  1.59  1.12  1.56  1.19  1.37  0.90  1.26  1.13  1.44  1.30  1.06  1.13
10-11  2.13  1.49  1.88  1.31  1.72  1.13  1.70  1.30  1.68  1.55  1.27  1.24
11-12  2.51  1.71  1.70  1.24  1.92  1.21  1.97  1.49  1.84  1.65  1.12  1.21
12-13  2.15  1.63  1.94  1.35  1.95  1.15  1.78  1.60  1.82  1.82  1.01  1.19
13-14  2.04  1.51  1.95  1.38  1.72  1.02  1.66  1.46  1.66  1.61  1.04  1.10
14-15  1.39  1.18  1.81  1.14  1.45  0.88  1.47  1.22  1.27  1.30  0.70  0.78
15-16  1.04  0.78  1.18  0.61  0.94  0.54  0.98  0.91  0.83  0.71  0.41  0.52
16-17  0.48  0.37  0.58  0.15  0.41  0.26  0.47  0.46  0.35  0.27  0.09  0.19
17-18  0.07  0.07  0.10  0.02  0.07  0.04  0.09  0.10  0.04  0.03  0.01  0.03
18-19  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00
Total  14.87  10.79  14.17  9.82  12.90  7.93  12.62  10.80  12.51  12.00  7.95  8.40

Page 109

Appendix F  Monthly  averaged  hourly  diffuse  tilted  (β  =  7°)
insolation
|     | Monthly averaged hourly diffuse tilted insolation I |     |       |       |      | dt (β = 7°) |     |     |     |
| --- | ---------------------------------------------------- | --- | ----- | ----- | ---- | ----------- | --- | --- | --- |
|     |                                                      |     |       |       |      |   r         |     |   r |   r |
|   y | y                                                    |     |       |       |      | e           |   r | e   | e   |
| r   | a r                                                  | h   |   ril |       |   st | b           | e   | b   | b   |
| a   | u                                                    | c   |       | y n e | y u  | m           | b   | m   | m   |
|   u | r                                                    | a r | p     | a     | ul g | e           | o   | e   | e   |
| n   | b                                                    | M   | A     | M u   | J u  | pt          | ct  | v   | c   |
| a   | e                                                    |     |       | J     | A    |             | O   | o   | e   |
| J   | F                                                    |     |       |       |      | e           |     | N   | D   |
S
MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2
Hour
5---6  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00
6-7  0.06  0.05  0.10  0.19  0.20  0.19  0.17  0.15  0.18  0.19  0.09  0.18
7-8  0.43  0.39  0.47  0.59  0.52  0.55  0.50  0.50  0.55  0.51  0.44  0.54
8-9  0.61  0.68  0.63  0.86  0.67  0.86  0.72  0.76  0.72  0.71  0.70  0.81
9-10  0.69  0.86  0.77  1.02  0.75  1.04  0.79  0.95  0.85  0.86  0.81  0.98
10-11  0.67  1.09  0.82  1.19  0.82  1.18  0.85  1.10  1.00  0.95  0.99  1.08
11-12  0.60  1.16  0.92  1.27  0.90  1.24  0.78  1.12  1.05  1.00  1.13  1.17
12-13  0.70  1.21  1.00  1.20  0.89  1.19  0.86  1.11  1.02  0.95  1.13  1.19
13-14  0.73  1.17  0.94  1.04  0.89  1.24  0.85  1.03  0.97  0.91  1.11  1.19
14-15  0.80  1.07  0.83  0.89  0.86  1.12  0.76  0.93  0.93  0.90  1.00  0.97
15-16  0.78  0.95  0.71  0.74  0.73  0.94  0.68  0.76  0.79  0.70  0.79  0.72
16-17  0.62  0.68  0.55  0.42  0.53  0.62  0.49  0.57  0.53  0.41  0.47  0.36
17-18  0.22  0.26  0.26  0.14  0.22  0.26  0.23  0.23  0.18  0.09  0.11  0.06
18-19  0.00  0.00  0.01  0.00  0.00  0.01  0.02  0.01  0.00  0.00  0.00  0.00
Total  6.91  9.58  8.01  9.55  7.97  10.44  7.70  9.21  8.76  8.19  8.77  9.25

Page 110

| Appendix G  |     | Monthly averaged hourly beam normal insolation    |     |     |     |     |     |     |     |
| ----------- | --- | ------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
|             |     | Monthly averaged hourly beam normal insolation I |     |     |     |     |     |     |     |
bn
|     |     |       |     |     |     |   r |     |   r |     |
| --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- |
|     |   y |       |     |     |     | e   |   r | e   | e r |
| y   | r   |   h   |     |     | st  | b   | e   | b   | b   |
| a r | a   | c ril | y e | y   | u   | m   | b   | m   | m   |
|   u | u   | r p   | a n | ul  | g   | e   | o   |     |     |
| n   | b r | M a A | M u |     | u   | pt  | ct  | v e | e   |
| a   | e   |       | J   | J   | A   |     | O   | o   | e c |
| J   | F   |       |     |     |     | e   |     | N   | D   |
S
Hour  MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2 MJ/m2
5---6  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00  0.00
6-7  0.33  0.11  0.15  0.44  0.51  0.20  0.33  0.36  0.26  0.43  0.26  0.38
7-8  1.32  0.71  1.24  1.28  1.16  0.73  1.14  0.98  1.32  1.45  0.78  0.93
8-9  1.95  1.36  1.89  1.63  1.56  1.01  1.62  1.42  1.71  1.70  1.27  1.33
9-10  2.25  1.55  2.07  1.55  1.84  1.27  1.78  1.51  1.81  1.62  1.55  1.37
10-11  2.53  1.73  2.10  1.46  1.98  1.36  2.02  1.48  1.83  1.67  1.45  1.43
11-12  2.73  1.80  1.74  1.28  2.06  1.34  2.16  1.56  1.86  1.67  1.32  1.19
12-13  2.29  1.67  1.95  1.38  2.09  1.26  1.92  1.66  1.84  1.87  1.30  1.08
13-14  2.29  1.62  2.07  1.50  1.96  1.20  1.90  1.60  1.80  1.79  1.28  1.21
14-15  1.78  1.43  2.19  1.44  1.92  1.19  1.92  1.55  1.61  1.71  1.06  0.96
15-16  1.69  1.18  1.80  0.99  1.61  0.94  1.63  1.46  1.38  1.25  0.91  0.74
16-17  1.17  0.81  1.31  0.40  1.12  0.69  1.19  1.13  0.92  0.78  0.52  0.28
17-18  0.37  0.32  0.52  0.15  0.52  0.31  0.55  0.60  0.34  0.27  0.17  0.05
18-19  0.00  0.00  0.01  0.00  0.00  0.02  0.07  0.01  0.00  0.00  0.00  0.00
Total  20.70  14.29  19.03  13.48  18.34  11.53  18.22  15.32  16.67  16.20  11.87  10.94

Page 111

Appendix H Monthly averaged daily global insolation
e Monthly averaged daily global insolation I
gl t
n
S u r f a c e A β J a n u a r y F e b r u a r y M a r c h A p ril M a y J u n e J ul y A u g u st S e pt e m b e r O ct o b e r N o v e m b e r D e c e m b e r A n n u al
2 2 2 2 2 2 2 2 2 2 2 2 2
m m m m m m m m m m m m m
° J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/
M M M M M M M M M M M M M
-45 9.92 12.31 16.86 18.08 23.07 20.38 23.13 20.01 17.46 12.99 9.35 8.36 16.02
-44 10.21 12.55 17.10 18.23 23.20 20.48 23.25 20.16 17.67 13.23 9.56 8.58 16.21
-43 10.51 12.80 17.34 18.38 23.32 20.57 23.36 20.30 17.87 13.45 9.76 8.79 16.39
-42 10.81 13.04 17.57 18.52 23.44 20.66 23.46 20.43 18.07 13.68 9.96 9.00 16.58
-41 11.10 13.27 17.79 18.66 23.55 20.74 23.56 20.56 18.27 13.90 10.16 9.21 16.75
-40 11.40 13.51 18.02 18.79 23.66 20.82 23.65 20.69 18.46 14.13 10.37 9.42 16.93
-39 11.70 13.74 18.23 18.93 23.76 20.90 23.74 20.81 18.65 14.34 10.57 9.63 17.10
-38 11.99 13.97 18.45 19.05 23.85 20.97 23.82 20.92 18.83 14.56 10.77 9.83 17.27
-37 12.28 14.20 18.66 19.17 23.94 21.03 23.89 21.03 19.01 14.77 10.96 10.04 17.44
-36 12.57 14.42 18.86 19.29 24.02 21.09 23.96 21.13 19.18 14.97 11.16 10.24 17.60
-35 12.86 14.64 19.06 19.40 24.09 21.15 24.02 21.23 19.35 15.18 11.36 10.45 17.75
-34 13.15 14.86 19.25 19.51 24.16 21.20 24.07 21.32 19.51 15.38 11.55 10.66 17.91
-33 13.43 15.08 19.44 19.61 24.22 21.24 24.12 21.41 19.67 15.58 11.74 10.87 18.06
-32 13.72 15.29 19.63 19.71 24.28 21.28 24.16 21.50 19.83 15.77 11.93 11.07 18.20
-31 14.01 15.50 19.81 19.80 24.33 21.31 24.20 21.57 19.98 15.96 12.12 11.28 18.34
-30 14.30 15.70 19.98 19.89 24.37 21.34 24.23 21.64 20.12 16.15 12.30 11.48 18.48
-29 14.58 15.91 20.15 19.97 24.41 21.37 24.25 21.71 20.26 16.33 12.48 11.68 18.61
-28 14.86 16.10 20.32 20.05 24.44 21.38 24.27 21.77 20.40 16.51 12.66 11.88 18.74
-27 15.13 16.30 20.48 20.12 24.46 21.40 24.28 21.83 20.53 16.69 12.84 12.08 18.86
-26 15.40 16.49 20.63 20.19 24.48 21.41 24.29 21.88 20.65 16.86 13.01 12.27 18.98
-25 15.67 16.68 20.78 20.26 24.49 21.41 24.28 21.92 20.77 17.02 13.18 12.47 19.10
-24 15.93 16.86 20.92 20.32 24.50 21.41 24.28 21.96 20.88 17.19 13.35 12.65 19.21
Page 112

Monthly averaged daily global insolation I continued
t
e Monthly averaged daily global insolation I
gl t
n
S u r f a c e A β J a n u a r y F e b r u a r y M a r c h A p ril M a y J u n e J ul y A u g u st S e pt e m b e r O ct o b e r N o v e m b e r D e c e m b e r A n n u al
2 2 2 2 2 2 2 2 2 2 2 2 2
m m m m m m m m m m m m m
° J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/
M M M M M M M M M M M M M
-23 16.19 17.04 21.06 20.37 24.50 21.40 24.26 22.00 20.99 17.35 13.52 12.84 19.31
-22 16.45 17.22 21.19 20.42 24.49 21.39 24.24 22.03 21.10 17.50 13.68 13.02 19.41
-21 16.70 17.39 21.32 20.46 24.48 21.37 24.21 22.05 21.20 17.65 13.84 13.20 19.51
-20 16.95 17.56 21.44 20.50 24.46 21.35 24.18 22.07 21.29 17.80 14.00 13.38 19.60
-19 17.19 17.72 21.56 20.53 24.43 21.32 24.14 22.08 21.38 17.94 14.15 13.55 19.68
-18 17.43 17.88 21.67 20.56 24.40 21.29 24.09 22.08 21.46 18.08 14.30 13.73 19.76
-17 17.67 18.04 21.78 20.59 24.36 21.25 24.04 22.08 21.54 18.21 14.45 13.89 19.84
-16 17.90 18.19 21.88 20.60 24.31 21.21 23.98 22.08 21.61 18.34 14.60 14.06 19.91
-15 18.13 18.33 21.97 20.62 24.26 21.16 23.92 22.07 21.67 18.46 14.74 14.22 19.98
-14 18.36 18.48 22.06 20.63 24.20 21.10 23.85 22.05 21.74 18.58 14.88 14.38 20.04
-13 18.58 18.61 22.14 20.63 24.14 21.05 23.77 22.03 21.79 18.70 15.02 14.54 20.10
-12 18.79 18.75 22.22 20.63 24.07 20.98 23.69 22.01 21.84 18.81 15.15 14.70 20.15
-11 19.00 18.88 22.29 20.62 23.99 20.91 23.60 21.97 21.88 18.92 15.28 14.85 20.20
-10 19.21 19.00 22.35 20.61 23.91 20.84 23.50 21.94 21.92 19.02 15.41 15.00 20.24
-9 19.42 19.12 22.41 20.59 23.82 20.76 23.40 21.89 21.96 19.11 15.54 15.15 20.28
-8 19.61 19.24 22.47 20.57 23.73 20.68 23.30 21.84 21.98 19.20 15.66 15.29 20.31
-7 19.81 19.35 22.52 20.54 23.63 20.59 23.18 21.79 22.01 19.29 15.77 15.43 20.34
-6 20.00 19.45 22.56 20.51 23.52 20.50 23.06 21.73 22.02 19.37 15.89 15.56 20.36
-5 20.18 19.56 22.59 20.47 23.40 20.40 22.94 21.67 22.04 19.45 15.99 15.70 20.38
-4 20.36 19.65 22.62 20.43 23.29 20.29 22.81 21.59 22.04 19.52 16.10 15.83 20.39
-3 20.53 19.74 22.65 20.38 23.16 20.19 22.67 21.52 22.04 19.59 16.20 15.95 20.40
-2 20.70 19.83 22.67 20.33 23.03 20.07 22.53 21.44 22.04 19.65 16.30 16.07 20.40
-1 20.86 19.91 22.68 20.27 22.89 19.96 22.38 21.35 22.02 19.71 16.39 16.19 20.40
Page 113

Monthly averaged daily global insolation I continued
t
e Monthly averaged daily global insolation I
gl t
n
S u r f a c e A β J a n u a r y F e b r u a r y M a r c h A p ril M a y J u n e J ul y A u g u st S e pt e m b e r O ct o b e r N o v e m b e r D e c e m b e r A n n u al
2 2 2 2 2 2 2 2 2 2 2 2 2
m m m m m m m m m m m m m
° J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/
M M M M M M M M M M M M M
0 21.02 19.99 22.69 20.21 22.75 19.83 22.22 21.26 22.01 19.76 16.48 16.30 20.39
1 21.17 20.06 22.69 20.14 22.60 19.71 22.06 21.16 21.99 19.81 16.57 16.41 20.37
2 21.32 20.13 22.68 20.07 22.45 19.58 21.90 21.06 21.96 19.85 16.65 16.52 20.36
3 21.46 20.19 22.67 19.99 22.29 19.44 21.73 20.95 21.93 19.89 16.73 16.62 20.33
4 21.59 20.25 22.65 19.91 22.12 19.30 21.55 20.84 21.89 19.92 16.81 16.72 20.30
5 21.72 20.30 22.63 19.82 21.95 19.15 21.37 20.72 21.84 19.95 16.88 16.81 20.27
6 21.84 20.35 22.60 19.73 21.77 19.00 21.18 20.60 21.79 19.97 16.94 16.90 20.23
7 21.96 20.39 22.57 19.64 21.59 18.85 20.99 20.47 21.74 19.99 17.01 16.99 20.19
8 22.07 20.43 22.53 19.53 21.40 18.69 20.79 20.34 21.68 20.00 17.07 17.07 20.14
9 22.18 20.46 22.48 19.43 21.21 18.53 20.59 20.20 21.61 20.01 17.12 17.15 20.09
10 22.28 20.49 22.43 19.32 21.01 18.36 20.38 20.06 21.54 20.01 17.17 17.22 20.03
11 22.38 20.51 22.37 19.20 20.81 18.19 20.16 19.91 21.46 20.01 17.22 17.29 19.97
12 22.47 20.53 22.31 19.08 20.60 18.02 19.95 19.76 21.38 20.00 17.26 17.36 19.90
13 22.55 20.54 22.24 18.96 20.38 17.84 19.72 19.60 21.29 19.99 17.30 17.42 19.82
14 22.63 20.55 22.16 18.83 20.16 17.65 19.49 19.44 21.20 19.97 17.34 17.48 19.75
15 22.70 20.55 22.08 18.69 19.94 17.47 19.26 19.27 21.10 19.95 17.37 17.53 19.66
16 22.76 20.55 21.99 18.56 19.71 17.27 19.02 19.10 21.00 19.92 17.39 17.58 19.58
17 22.82 20.54 21.90 18.41 19.47 17.08 18.78 18.92 20.89 19.89 17.41 17.62 19.48
18 22.88 20.53 21.80 18.27 19.23 16.88 18.53 18.74 20.77 19.85 17.43 17.66 19.39
19 22.92 20.51 21.70 18.11 18.99 16.68 18.28 18.56 20.66 19.81 17.45 17.70 19.28
20 22.96 20.49 21.59 17.96 18.74 16.47 18.03 18.37 20.53 19.76 17.46 17.73 19.18
21 23.00 20.46 21.47 17.80 18.49 16.26 17.77 18.17 20.40 19.71 17.46 17.76 19.07
22 23.03 20.43 21.35 17.63 18.23 16.05 17.51 17.97 20.27 19.65 17.46 17.78 18.95
Page 114

Monthly averaged daily global insolation I continued
t
e Monthly averaged daily global insolation I
gl t
n
S u r f a c e A β J a n u a r y F e b r u a r y M a r c h A p ril M a y J u n e J ul y A u g u st S e pt e m b e r O ct o b e r N o v e m b e r D e c e m b e r A n n u al
2 2 2 2 2 2 2 2 2 2 2 2 2
m m m m m m m m m m m m m
° J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/
M M M M M M M M M M M M M
23 23.05 20.39 21.23 17.47 17.97 15.84 17.24 17.83 20.13 19.59 17.46 17.80 18.83
24 23.07 20.35 21.10 17.29 17.70 15.62 16.97 17.56 19.98 19.52 17.45 17.82 18.70
25 23.08 20.30 20.96 17.12 17.43 15.40 16.70 17.35 19.83 19.45 17.44 17.83 18.57
26 23.09 20.25 20.82 16.94 17.16 15.17 16.42 17.14 19.68 19.37 17.43 17.83 18.44
27 23.08 20.19 20.67 16.75 16.88 14.95 16.14 16.92 19.52 19.29 17.41 17.83 18.30
28 23.08 20.12 20.52 16.56 16.60 14.72 15.85 16.70 19.36 19.20 17.39 17.83 18.16
29 23.06 20.06 20.36 16.37 16.32 14.49 15.56 16.47 19.19 19.11 17.36 17.83 18.01
30 23.05 19.98 20.20 16.17 16.04 14.25 15.27 16.24 19.01 19.01 17.33 17.81 17.86
31 23.02 19.91 20.03 15.97 15.75 14.01 14.98 16.01 18.84 18.91 17.29 17.80 17.71
32 22.99 19.82 19.85 15.77 15.46 13.77 14.68 15.77 18.65 18.80 17.25 17.78 17.55
33 22.95 19.74 19.67 15.57 15.17 13.53 14.38 15.53 18.47 18.69 17.21 17.76 17.39
34 22.91 19.64 19.49 15.36 14.87 13.29 14.07 15.29 18.28 18.58 17.16 17.73 17.22
35 22.86 19.55 19.30 15.14 14.57 13.04 13.77 15.04 18.08 18.46 17.11 17.69 17.05
36 22.80 19.45 19.11 14.93 14.27 12.79 13.46 14.79 17.88 18.33 17.05 17.66 16.87
37 22.74 19.34 18.91 14.71 13.96 12.53 13.15 14.54 17.67 18.21 16.99 17.62 16.69
38 22.67 19.23 18.71 14.49 13.65 12.28 12.83 14.28 17.47 18.07 16.93 17.57 16.51
39 22.60 19.11 18.50 14.26 13.34 12.02 12.52 14.02 17.25 17.93 16.86 17.52 16.32
40 22.52 18.99 18.29 14.03 13.02 11.76 12.20 13.76 17.04 17.79 16.79 17.47 16.13
41 22.44 18.87 18.07 13.80 12.70 11.50 11.87 13.50 16.81 17.65 16.71 17.41 15.94
42 22.35 18.74 17.85 13.57 12.38 11.23 11.55 13.23 16.59 17.49 16.63 17.35 15.74
43 22.25 18.60 17.62 13.33 12.06 10.97 11.22 12.96 16.36 17.34 16.55 17.28 15.54
44 22.15 18.46 17.39 13.09 11.73 10.70 10.89 12.69 16.13 17.18 16.46 17.21 15.33
45 22.04 18.32 17.16 12.85 11.40 10.43 10.56 12.42 15.89 17.02 16.37 17.14 15.12
Page 115

Appendix I Monthly averaged daily beam insolation
e Monthly averaged daily beam insolation I
gl bt
n
S u r f a c e A β J a n u a r y F e b r u a r y M a r c h A p ril M a y J u n e J ul y A u g u st S e pt e m b e r O ct o b e r N o v e m b e r D e c e m b e r A n n u al
2 2 2 2 2 2 2 2 2 2 2 2 2
m m m m m m m m m m m m m
° J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/
M M M M M M M M M M M M M
-45 3.74 4.20 8.38 7.86 12.60 8.54 12.94 9.59 8.13 5.49 2.24 1.81 7.15
-44 3.99 4.38 8.58 7.97 12.71 8.59 13.04 9.70 8.29 5.67 2.37 1.96 7.30
-43 4.25 4.56 8.77 8.07 12.82 8.65 13.14 9.80 8.46 5.85 2.51 2.11 7.44
-42 4.51 4.73 8.96 8.18 12.92 8.70 13.23 9.90 8.62 6.03 2.65 2.26 7.58
-41 4.77 4.91 9.15 8.28 13.02 8.75 13.32 10.00 8.77 6.21 2.79 2.40 7.72
-40 5.02 5.08 9.34 8.38 13.12 8.80 13.41 10.09 8.93 6.39 2.92 2.55 7.86
-39 5.28 5.25 9.53 8.47 13.21 8.84 13.49 10.19 9.08 6.57 3.06 2.70 8.00
-38 5.54 5.42 9.71 8.57 13.30 8.89 13.56 10.27 9.23 6.74 3.20 2.84 8.13
-37 5.80 5.59 9.89 8.66 13.39 8.92 13.64 10.36 9.38 6.91 3.34 2.99 8.26
-36 6.05 5.76 10.06 8.75 13.47 8.96 13.71 10.44 9.52 7.08 3.47 3.13 8.39
-35 6.30 5.92 10.24 8.84 13.54 9.00 13.77 10.52 9.66 7.25 3.61 3.28 8.52
-34 6.56 6.09 10.40 8.92 13.61 9.03 13.83 10.60 9.80 7.41 3.74 3.43 8.64
-33 6.81 6.25 10.57 9.00 13.68 9.05 13.89 10.67 9.93 7.58 3.88 3.58 8.77
-32 7.07 6.41 10.73 9.08 13.74 9.08 13.94 10.74 10.06 7.74 4.01 3.74 8.89
-31 7.32 6.57 10.89 9.15 13.80 9.10 13.98 10.81 10.19 7.90 4.14 3.89 9.01
-30 7.58 6.73 11.05 9.23 13.86 9.12 14.03 10.87 10.32 8.05 4.27 4.04 9.12
-29 7.83 6.88 11.20 9.30 13.91 9.14 14.07 10.93 10.44 8.21 4.40 4.18 9.23
-28 8.08 7.04 11.35 9.36 13.96 9.15 14.10 10.99 10.56 8.36 4.53 4.33 9.34
-27 8.32 7.19 11.50 9.43 14.00 9.17 14.13 11.04 10.67 8.51 4.65 4.47 9.45
-26 8.57 7.34 11.64 9.49 14.04 9.18 14.16 11.09 10.79 8.65 4.78 4.62 9.55
-25 8.81 7.49 11.78 9.55 14.07 9.18 14.18 11.14 10.89 8.80 4.90 4.76 9.65
-24 9.05 7.63 11.92 9.60 14.10 9.18 14.20 11.18 11.00 8.94 5.02 4.90 9.75
Page 116

Monthly averaged daily beam insolation I continued
bt
e Monthly averaged daily beam insolation I
gl bt
n
S u r f a c e A β J a n u a r y F e b r u a r y M a r c h A p ril M a y J u n e J ul y A u g u st S e pt e m b e r O ct o b e r N o v e m b e r D e c e m b e r A n n u al
2 2 2 2 2 2 2 2 2 2 2 2 2
m m m m m m m m m m m m m
° J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/
M M M M M M M M M M M M M
-23 9.28 7.77 12.05 9.65 14.13 9.19 14.21 11.22 11.10 9.08 5.15 5.04 9.85
-22 9.52 7.91 12.18 9.70 14.15 9.18 14.22 11.25 11.20 9.21 5.27 5.18 9.94
-21 9.75 8.05 12.30 9.75 14.16 9.18 14.22 11.29 11.30 9.35 5.38 5.32 10.03
-20 9.98 8.19 12.42 9.79 14.18 9.17 14.22 11.32 11.39 9.48 5.50 5.45 10.12
-19 10.20 8.32 12.54 9.83 14.19 9.16 14.22 11.34 11.48 9.61 5.61 5.58 10.20
-18 10.42 8.45 12.66 9.87 14.19 9.15 14.21 11.37 11.57 9.73 5.73 5.72 10.28
-17 10.64 8.58 12.77 9.91 14.19 9.13 14.20 11.38 11.65 9.85 5.84 5.84 10.36
-16 10.86 8.70 12.87 9.94 14.18 9.11 14.18 11.40 11.73 9.97 5.95 5.97 10.43
-15 11.07 8.82 12.97 9.97 14.17 9.09 14.16 11.41 11.80 10.09 6.06 6.10 10.50
-14 11.29 8.94 13.07 9.99 14.16 9.06 14.13 11.42 11.87 10.20 6.17 6.22 10.57
-13 11.49 9.06 13.16 10.01 14.14 9.04 14.10 11.43 11.94 10.31 6.27 6.35 10.63
-12 11.70 9.18 13.25 10.03 14.12 9.01 14.07 11.43 12.00 10.42 6.38 6.47 10.70
-11 11.90 9.29 13.34 10.05 14.09 8.97 14.03 11.43 12.06 10.52 6.48 6.59 10.75
-10 12.10 9.40 13.42 10.06 14.06 8.94 13.99 11.42 12.12 10.62 6.58 6.71 10.81
-9 12.29 9.50 13.50 10.07 14.03 8.90 13.94 11.41 12.17 10.71 6.68 6.83 10.86
-8 12.48 9.61 13.57 10.08 13.99 8.86 13.89 11.40 12.22 10.81 6.77 6.95 10.91
-7 12.67 9.71 13.64 10.08 13.95 8.82 13.83 11.38 12.27 10.90 6.87 7.06 10.95
-6 12.85 9.80 13.71 10.09 13.90 8.77 13.77 11.36 12.31 10.99 6.96 7.17 11.00
-5 13.03 9.90 13.77 10.08 13.85 8.72 13.71 11.34 12.35 11.07 7.05 7.28 11.04
-4 13.21 9.99 13.83 10.08 13.79 8.67 13.64 11.31 12.38 11.15 7.14 7.39 11.07
-3 13.38 10.08 13.88 10.07 13.73 8.61 13.57 11.28 12.41 11.23 7.22 7.49 11.10
-2 13.55 10.16 13.93 10.06 13.66 8.56 13.49 11.25 12.44 11.30 7.31 7.59 11.13
-1 13.71 10.24 13.97 10.04 13.60 8.50 13.41 11.22 12.46 11.37 7.39 7.69 11.16
Page 117

Monthly averaged daily beam insolation I continued
bt
e Monthly averaged daily beam insolation I
gl bt
n
S u r f a c e A β J a n u a r y F e b r u a r y M a r c h A p ril M a y J u n e J ul y A u g u st S e pt e m b e r O ct o b e r N o v e m b e r D e c e m b e r A n n u al
2 2 2 2 2 2 2 2 2 2 2 2 2
m m m m m m m m m m m m m
° J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/
M M M M M M M M M M M M M
0 13.87 10.32 14.01 10.03 13.52 8.44 13.32 11.18 12.48 11.44 7.47 7.79 11.18
1 14.03 10.40 14.05 10.01 13.45 8.37 13.23 11.13 12.50 11.50 7.54 7.89 11.20
2 14.18 10.47 14.08 9.98 13.37 8.30 13.14 11.09 12.51 11.56 7.62 7.98 11.21
3 14.32 10.54 14.10 9.96 13.28 8.23 13.04 11.04 12.51 11.61 7.69 8.07 11.22
4 14.47 10.61 14.13 9.93 13.19 8.16 12.94 10.98 12.52 11.67 7.76 8.16 11.23
5 14.60 10.67 14.15 9.89 13.10 8.09 12.84 10.93 12.52 11.71 7.82 8.24 11.23
6 14.74 10.73 14.16 9.86 13.00 8.01 12.73 10.87 12.51 11.76 7.89 8.32 11.24
7 14.87 10.79 14.17 9.82 12.90 7.93 12.62 10.80 12.51 11.80 7.95 8.40 11.23
8 14.99 10.84 14.18 9.78 12.79 7.85 12.50 10.73 12.50 11.84 8.01 8.48 11.23
9 15.11 10.89 14.18 9.73 12.68 7.76 12.38 10.66 12.48 11.87 8.07 8.56 11.22
10 15.23 10.94 14.17 9.69 12.57 7.68 12.26 10.59 12.46 11.90 8.12 8.63 11.21
11 15.34 10.98 14.17 9.64 12.46 7.59 12.13 10.52 12.44 11.93 8.18 8.70 11.19
12 15.44 11.02 14.15 9.58 12.33 7.50 12.00 10.44 12.41 11.96 8.23 8.77 11.17
13 15.54 11.06 14.14 9.53 12.21 7.40 11.86 10.35 12.38 11.98 8.27 8.83 11.15
14 15.64 11.09 14.12 9.47 12.08 7.31 11.73 10.27 12.35 11.99 8.32 8.89 11.12
15 15.73 11.12 14.09 9.40 11.95 7.21 11.58 10.18 12.31 12.00 8.36 8.95 11.09
16 15.82 11.15 14.06 9.34 11.82 7.11 11.44 10.09 12.27 12.01 8.40 9.01 11.06
17 15.90 11.17 14.03 9.27 11.68 7.01 11.29 9.99 12.22 12.02 8.44 9.06 11.02
18 15.98 11.19 13.99 9.20 11.53 6.90 11.14 9.89 12.17 12.02 8.47 9.12 10.99
19 16.05 11.21 13.95 9.13 11.39 6.79 10.98 9.79 12.12 12.02 8.51 9.16 10.94
20 16.12 11.22 13.91 9.05 11.24 6.69 10.82 9.69 12.06 12.01 8.54 9.21 10.90
21 16.18 11.23 13.86 8.97 11.09 6.58 10.66 9.58 12.00 12.00 8.56 9.25 10.85
22 16.24 11.23 13.80 8.89 10.93 6.47 10.50 9.47 11.94 11.99 8.59 9.29 10.79
Page 118

Monthly averaged daily beam insolation I continued
bt
e Monthly averaged daily beam insolation I
gl bt
n
S u r f a c e A β J a n u a r y F e b r u a r y M a r c h A p ril M a y J u n e J ul y A u g u st S e pt e m b e r O ct o b e r N o v e m b e r D e c e m b e r A n n u al
2 2 2 2 2 2 2 2 2 2 2 2 2
m m m m m m m m m m m m m
° J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/
M M M M M M M M M M M M M
23 16.29 11.24 13.74 8.81 10.77 6.35 10.33 9.39 11.87 11.97 8.61 9.33 10.74
24 16.34 11.24 13.68 8.72 10.61 6.24 10.16 9.24 11.80 11.95 8.63 9.36 10.68
25 16.38 11.23 13.61 8.63 10.44 6.12 9.99 9.12 11.73 11.93 8.64 9.39 10.62
26 16.42 11.22 13.54 8.54 10.27 6.00 9.81 9.00 11.65 11.90 8.66 9.42 10.55
27 16.45 11.21 13.47 8.44 10.10 5.88 9.63 8.88 11.57 11.87 8.67 9.45 10.48
28 16.48 11.20 13.39 8.34 9.93 5.76 9.45 8.75 11.48 11.84 8.68 9.47 10.41
29 16.50 11.18 13.30 8.24 9.75 5.64 9.27 8.62 11.39 11.80 8.68 9.49 10.34
30 16.52 11.16 13.22 8.14 9.58 5.51 9.08 8.49 11.30 11.76 8.69 9.51 10.26
31 16.53 11.13 13.12 8.04 9.40 5.39 8.89 8.36 11.20 11.71 8.69 9.52 10.18
32 16.54 11.11 13.03 7.93 9.21 5.26 8.70 8.22 11.10 11.66 8.69 9.53 10.10
33 16.54 11.08 12.93 7.82 9.03 5.13 8.51 8.08 11.00 11.61 8.68 9.54 10.01
34 16.54 11.04 12.83 7.71 8.84 5.00 8.31 7.94 10.90 11.55 8.67 9.55 9.92
35 16.53 11.00 12.72 7.59 8.65 4.87 8.11 7.80 10.79 11.49 8.66 9.55 9.83
36 16.52 10.96 12.61 7.48 8.46 4.74 7.91 7.65 10.67 11.43 8.65 9.55 9.73
37 16.50 10.92 12.49 7.36 8.27 4.60 7.71 7.50 10.56 11.36 8.64 9.55 9.63
38 16.48 10.87 12.37 7.24 8.07 4.46 7.51 7.35 10.44 11.29 8.62 9.54 9.53
39 16.45 10.82 12.25 7.12 7.87 4.33 7.30 7.20 10.32 11.22 8.60 9.53 9.43
40 16.42 10.76 12.12 6.99 7.67 4.19 7.09 7.05 10.19 11.14 8.58 9.52 9.32
41 16.38 10.70 11.99 6.86 7.46 4.05 6.88 6.90 10.06 11.06 8.55 9.50 9.21
42 16.34 10.64 11.86 6.74 7.26 3.91 6.67 6.74 9.93 10.98 8.52 9.49 9.10
43 16.29 10.58 11.72 6.61 7.05 3.76 6.45 6.58 9.80 10.89 8.49 9.46 8.98
44 16.24 10.51 11.58 6.47 6.84 3.62 6.23 6.42 9.66 10.80 8.46 9.44 8.86
45 16.18 10.44 11.44 6.34 6.62 3.47 6.01 6.26 9.52 10.71 8.42 9.41 8.74
Page 119

Appendix J Monthly averaged daily diffuse insolation
β Monthly averaged daily diffuse insolation I
e
dt
gl
S u r f a c e A n J a n u a r y F e b r u a r y M a r c h A p ril M a y J u n e J ul y A u g u st S e pt e m b e r O ct o b e r N o v e m b e r D e c e m b e r A n n u al
2 2 2 2 2 2 2 2 2 2 2 2 2
m m m m m m m m m m m m m
° J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/
M M M M M M M M M M M M M
-45 5.84 7.79 8.12 9.89 10.10 11.52 9.83 10.08 8.97 7.19 6.85 6.29 8.54
-44 5.90 7.87 8.17 9.95 10.14 11.58 9.86 10.13 9.03 7.25 6.93 6.37 8.59
-43 5.95 7.94 8.23 10.01 10.17 11.63 9.89 10.18 9.09 7.31 7.00 6.44 8.65
-42 6.00 8.02 8.28 10.06 10.20 11.68 9.92 10.23 9.14 7.37 7.08 6.52 8.70
-41 6.06 8.10 8.33 10.11 10.22 11.73 9.94 10.28 9.20 7.42 7.16 6.59 8.76
-40 6.11 8.17 8.38 10.16 10.24 11.77 9.96 10.32 9.25 7.48 7.23 6.66 8.81
-39 6.16 8.25 8.43 10.20 10.27 11.81 9.98 10.36 9.30 7.53 7.30 6.73 8.86
-38 6.21 8.32 8.47 10.25 10.28 11.85 9.99 10.40 9.34 7.59 7.38 6.80 8.90
-37 6.26 8.39 8.52 10.29 10.30 11.89 10.01 10.43 9.39 7.64 7.45 6.87 8.95
-36 6.30 8.45 8.56 10.33 10.31 11.92 10.02 10.47 9.43 7.69 7.52 6.94 8.99
-35 6.35 8.52 8.60 10.36 10.32 11.95 10.03 10.50 9.47 7.73 7.59 7.00 9.03
-34 6.39 8.59 8.64 10.40 10.33 11.98 10.03 10.53 9.51 7.78 7.65 7.07 9.07
-33 6.44 8.65 8.67 10.43 10.34 12.01 10.04 10.55 9.55 7.83 7.72 7.14 9.11
-32 6.48 8.71 8.70 10.46 10.34 12.03 10.04 10.58 9.58 7.87 7.78 7.20 9.14
-31 6.52 8.77 8.74 10.49 10.35 12.05 10.04 10.60 9.61 7.91 7.85 7.27 9.18
-30 6.57 8.83 8.76 10.51 10.34 12.07 10.04 10.62 9.64 7.95 7.91 7.33 9.21
-29 6.61 8.88 8.79 10.54 10.34 12.09 10.03 10.63 9.67 7.99 7.97 7.39 9.24
-28 6.64 8.94 8.82 10.56 10.34 12.10 10.03 10.65 9.70 8.02 8.03 7.45 9.27
-27 6.68 8.99 8.84 10.58 10.33 12.11 10.02 10.66 9.72 8.06 8.09 7.51 9.29
-26 6.72 9.04 8.86 10.59 10.32 12.12 10.00 10.67 9.74 8.09 8.14 7.56 9.32
-25 6.75 9.09 8.88 10.61 10.30 12.13 9.99 10.68 9.76 8.12 8.20 7.62 9.34
-24 6.78 9.14 8.90 10.62 10.29 12.13 9.97 10.68 9.78 8.15 8.25 7.67 9.36
Page 120

Monthly averaged daily diffuse insolation I continued
dt
e Monthly averaged daily diffuse insolation I
gl dt
n
S u r f a c e A β J a n u a r y F e b r u a r y M a r c h A p ril M a y J u n e J ul y A u g u st S e pt e m b e r O ct o b e r N o v e m b e r D e c e m b e r A n n u al
2 2 2 2 2 2 2 2 2 2 2 2 2
m m m m m m m m m m m m m
° J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/
M M M M M M M M M M M M M
-23 6.82 9.18 8.91 10.63 10.27 12.13 9.95 10.69 9.79 8.18 8.30 7.73 9.37
-22 6.85 9.23 8.92 10.63 10.25 12.12 9.93 10.69 9.81 8.21 8.35 7.78 9.39
-21 6.88 9.27 8.94 10.64 10.23 12.12 9.91 10.68 9.82 8.23 8.40 7.83 9.40
-20 6.90 9.31 8.94 10.64 10.20 12.11 9.88 10.68 9.82 8.25 8.44 7.88 9.41
-19 6.93 9.34 8.95 10.64 10.18 12.10 9.86 10.67 9.83 8.28 8.49 7.92 9.42
-18 6.95 9.38 8.95 10.64 10.15 12.09 9.82 10.66 9.83 8.29 8.53 7.97 9.43
-17 6.98 9.41 8.96 10.63 10.12 12.07 9.79 10.65 9.84 8.31 8.57 8.01 9.44
-16 7.00 9.44 8.96 10.62 10.08 12.05 9.76 10.64 9.84 8.33 8.61 8.05 9.44
-15 7.02 9.47 8.96 10.61 10.04 12.03 9.72 10.62 9.83 8.34 8.65 8.09 9.44
-14 7.04 9.50 8.95 10.60 10.01 12.01 9.68 10.60 9.83 8.35 8.69 8.13 9.44
-13 7.06 9.52 8.94 10.59 9.96 11.98 9.64 10.58 9.82 8.36 8.72 8.17 9.44
-12 7.07 9.55 8.94 10.57 9.92 11.95 9.59 10.55 9.81 8.37 8.76 8.20 9.43
-11 7.09 9.57 8.93 10.55 9.88 11.92 9.55 10.53 9.80 8.38 8.79 8.24 9.42
-10 7.10 9.59 8.91 10.53 9.83 11.88 9.50 10.50 9.79 8.38 8.82 8.27 9.41
-9 7.11 9.61 8.90 10.50 9.78 11.85 9.45 10.47 9.77 8.38 8.85 8.30 9.40
-8 7.12 9.62 8.88 10.48 9.72 11.81 9.40 10.43 9.75 8.38 8.87 8.33 9.39
-7 7.13 9.63 8.86 10.45 9.67 11.77 9.34 10.40 9.73 8.38 8.90 8.36 9.37
-6 7.14 9.64 8.84 10.42 9.61 11.72 9.29 10.36 9.71 8.38 8.92 8.39 9.36
-5 7.14 9.65 8.82 10.38 9.55 11.67 9.23 10.32 9.68 8.38 8.94 8.41 9.34
-4 7.15 9.66 8.80 10.35 9.49 11.62 9.17 10.28 9.66 8.37 8.96 8.44 9.32
-3 7.15 9.66 8.77 10.31 9.43 11.57 9.10 10.23 9.63 8.36 8.98 8.46 9.29
-2 7.15 9.67 8.74 10.27 9.36 11.52 9.04 10.19 9.60 8.35 8.99 8.48 9.27
-1 7.15 9.67 8.71 10.23 9.30 11.46 8.97 10.14 9.56 8.34 9.01 8.50 9.24
Page 121

Monthly averaged daily diffuse insolation I continued
dt
e Monthly averaged daily diffuse insolation I
gl dt
n
S u r f a c e A β J a n u a r y F e b r u a r y M a r c h A p ril M a y J u n e J ul y A u g u st S e pt e m b e r O ct o b e r N o v e m b e r D e c e m b e r A n n u al
2 2 2 2 2 2 2 2 2 2 2 2 2
m m m m m m m m m m m m m
° J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/
M M M M M M M M M M M M M
0 7.15 9.67 8.68 10.18 9.23 11.40 8.90 10.08 9.53 8.33 9.02 8.51 9.21
1 7.14 9.66 8.64 10.14 9.15 11.34 8.83 10.03 9.49 8.31 9.03 8.53 9.18
2 7.14 9.66 8.60 10.09 9.08 11.27 8.76 9.97 9.45 8.29 9.04 8.54 9.15
3 7.13 9.65 8.56 10.03 9.00 11.20 8.68 9.92 9.41 8.27 9.04 8.55 9.11
4 7.12 9.64 8.52 9.98 8.93 11.14 8.60 9.86 9.37 8.25 9.05 8.56 9.07
5 7.11 9.63 8.48 9.93 8.85 11.06 8.52 9.79 9.32 8.23 9.05 8.57 9.03
6 7.10 9.61 8.44 9.87 8.76 10.99 8.44 9.73 9.27 8.21 9.05 8.57 8.99
7 7.09 9.60 8.39 9.81 8.68 10.91 8.36 9.66 9.22 8.18 9.05 8.58 8.95
8 7.07 9.58 8.34 9.74 8.60 10.83 8.28 9.59 9.17 8.15 9.05 8.58 8.90
9 7.06 9.56 8.29 9.68 8.51 10.75 8.19 9.52 9.12 8.12 9.04 8.58 8.85
10 7.04 9.54 8.24 9.61 8.42 10.67 8.10 9.45 9.06 8.09 9.04 8.58 8.81
11 7.02 9.51 8.18 9.55 8.33 10.58 8.01 9.37 9.00 8.06 9.03 8.58 8.75
12 7.00 9.49 8.12 9.48 8.23 10.50 7.92 9.30 8.94 8.02 9.02 8.57 8.70
13 6.98 9.46 8.07 9.40 8.14 10.41 7.83 9.22 8.88 7.98 9.00 8.56 8.65
14 6.95 9.43 8.01 9.33 8.04 10.31 7.73 9.13 8.82 7.95 8.99 8.56 8.59
15 6.93 9.40 7.94 9.25 7.94 10.22 7.64 9.05 8.75 7.91 8.97 8.55 8.53
16 6.90 9.36 7.88 9.17 7.84 10.12 7.54 8.97 8.68 7.86 8.96 8.53 8.47
17 6.87 9.32 7.82 9.09 7.74 10.03 7.44 8.88 8.61 7.82 8.94 8.52 8.41
18 6.84 9.29 7.75 9.01 7.64 9.93 7.34 8.79 8.54 7.78 8.92 8.50 8.35
19 6.81 9.25 7.68 8.93 7.54 9.82 7.23 8.70 8.47 7.73 8.89 8.49 8.28
20 6.78 9.20 7.61 8.84 7.43 9.72 7.13 8.61 8.39 7.68 8.87 8.47 8.21
21 6.74 9.16 7.54 8.75 7.32 9.61 7.03 8.51 8.32 7.63 8.84 8.45 8.14
22 6.71 9.11 7.46 8.66 7.21 9.51 6.92 8.42 8.24 7.58 8.81 8.43 8.07
Page 122

Monthly averaged daily diffuse insolation I continued
dt
e Monthly averaged daily diffuse insolation I
gl dt
n
S u r f a c e A β J a n u a r y F e b r u a r y M a r c h A p ril M a y J u n e J ul y A u g u st S e pt e m b e r O ct o b e r N o v e m b e r D e c e m b e r A n n u al
2 2 2 2 2 2 2 2 2 2 2 2 2
m m m m m m m m m m m m m
° J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/ J/
M M M M M M M M M M M M M
23 6.67 9.07 7.39 8.57 7.10 9.40 6.81 8.35 8.16 7.53 8.78 8.40 8.00
24 6.63 9.02 7.31 8.48 6.99 9.29 6.70 8.22 8.08 7.47 8.75 8.38 7.93
25 6.59 8.96 7.23 8.38 6.88 9.18 6.59 8.12 7.99 7.41 8.71 8.35 7.85
26 6.55 8.91 7.15 8.29 6.76 9.06 6.48 8.02 7.91 7.36 8.68 8.32 7.78
27 6.51 8.85 7.07 8.19 6.65 8.95 6.37 7.91 7.82 7.30 8.64 8.29 7.70
28 6.46 8.80 6.98 8.09 6.53 8.83 6.26 7.81 7.73 7.24 8.60 8.26 7.62
29 6.42 8.74 6.90 7.99 6.41 8.71 6.14 7.70 7.64 7.17 8.56 8.22 7.54
30 6.37 8.68 6.81 7.88 6.29 8.59 6.03 7.59 7.55 7.11 8.52 8.19 7.45
31 6.32 8.61 6.72 7.78 6.18 8.47 5.91 7.48 7.46 7.05 8.47 8.15 7.37
32 6.27 8.55 6.63 7.67 6.06 8.35 5.79 7.37 7.37 6.98 8.43 8.11 7.28
33 6.22 8.48 6.54 7.57 5.93 8.23 5.67 7.26 7.27 6.91 8.38 8.07 7.20
34 6.17 8.42 6.45 7.46 5.81 8.10 5.55 7.15 7.17 6.84 8.33 8.03 7.11
35 6.12 8.35 6.36 7.35 5.69 7.97 5.43 7.03 7.07 6.77 8.28 7.98 7.02
36 6.06 8.27 6.26 7.24 5.57 7.84 5.31 6.92 6.97 6.70 8.23 7.94 6.93
37 6.01 8.20 6.17 7.12 5.44 7.71 5.19 6.80 6.87 6.62 8.17 7.89 6.83
38 5.95 8.13 6.07 7.01 5.32 7.58 5.07 6.68 6.77 6.55 8.12 7.84 6.74
39 5.89 8.05 5.97 6.90 5.19 7.45 4.95 6.56 6.67 6.47 8.06 7.79 6.65
40 5.83 7.97 5.87 6.78 5.06 7.32 4.82 6.44 6.56 6.40 8.00 7.74 6.55
41 5.77 7.89 5.77 6.66 4.93 7.18 4.70 6.32 6.45 6.32 7.94 7.69 6.45
42 5.71 7.81 5.67 6.55 4.80 7.05 4.57 6.19 6.35 6.24 7.88 7.63 6.35
43 5.65 7.73 5.57 6.43 4.67 6.91 4.44 6.07 6.24 6.16 7.82 7.58 6.25
44 5.58 7.65 5.46 6.31 4.54 6.77 4.32 5.95 6.13 6.08 7.75 7.52 6.15
45 5.52 7.56 5.36 6.18 4.41 6.63 4.19 5.82 6.02 5.99 7.68 7.46 6.05
Page 123
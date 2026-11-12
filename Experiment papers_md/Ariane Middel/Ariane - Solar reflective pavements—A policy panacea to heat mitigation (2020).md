LETTER • OPEN ACCESS You may also like
Solar reflective pavements—A policy panacea to -Measuring the impacts of a real-world
neighborhood-scale cool pavement
deployment on albedo and temperatures
heat mitigation?
in Los Angeles
Joseph Ko, Hannah Schlaerth, Alexandra
Bruce et al.
To cite this article: Ariane Middel et al 2020 Environ. Res. Lett. 15 064016 -Micrometeorological simulations to predict
the impacts of heat mitigation strategies
on pedestrian thermal comfort in a Los
Angeles neighborhood
Mohammad Taleghani, David Sailor and
George A Ban-Weiss
View the article online for updates and enhancements.
-Attribution and mitigation of heat wave-
induced urban heat storage change
Ting Sun, Simone Kotthaus, Dan Li et al.
This content was downloaded from IP address 104.28.195.126 on 31/10/2026 at 23:13

Environ.Res.Lett.15(2020)064016 https://doi.org/10.1088/1748-9326/ab87d4
Environmental Research Letters
LETTER
Solar reflective pavements—A policy panacea to heat mitigation?
OPENACCESS
ArianeMiddel1,2,VKellyTurner3,FlorianASchneider4,YujiaZhang5andMatthewStiller6
RECEIVED 1 SchoolofArts,MediaandEngineering,ArizonaStateUniversity,UnitedStatesofAmerica
24December2019
2 SchoolofComputing,Informatics,andDecisionSystemsEngineering,ArizonaStateUniversity,UnitedStatesofAmerica
REVISED 3 UrbanPlanningDepartment,LuskinSchoolofPublicAffairs,UniversityofCaliforniaLosAngeles,UnitedStatesofAmerica
7April2020 4 SchoolofSustainability,ArizonaStateUniversity,UnitedStatesofAmerica
ACCEPTEDFORPUBLICATION 5 SchoolofGeographicalSciencesandUrbanPlanning,ArizonaStateUniversity,UnitedStatesofAmerica
8April2020 6 DepartmentofGeography,KentStateUniversity,UnitedStatesofAmerica
PUBLISHED
27May2020 E-mail:ariane.middel@asu.edu
Keywords:coolpavement,urbanheatisland,heatmitigation,pedestrianthermalexposure
Originalcontentfrom
thisworkmaybeused
underthetermsofthe
CreativeCommons Abstract
Attribution4.0licence.
CitiesworldwidearepilotingtheuseofsolarreflectivecoatingsonroadstomitigatetheUrban
Anyfurtherdistribution
ofthisworkmust HeatIsland(UHI).Solarreflectivepavementhasbeenpraisedassimple,low-costsolutionwitha
maintainattributionto
theauthor(s)andthetitle demonstratedabilitytoreducesurfacetemperature.Lesswellunderstoodistheeffectofsolar
ofthework,journal
reflectivecoatingsonradiantheat,whichinfluenceshumanthermalexposureandcomfort.We
citationandDOI.
presentthefirstbiometeorologicalobservationsofsolarreflectivecoatingtoinvestigateitsthermal
performancefromapedestrianperspective.HourlytransectswereconductedintwoLosAngeles
neighborhoodswithMaRTy,amobileplatformthatmeasuresair,surface,andmeanradiant
temperature.TransectswereperformedonJuly30,2019,atypicalsummerdaywithlowwind
◦
speedsandmaximumairtemperatureof31 C.Thesurfacetemperatureofcoatedasphaltconcrete
◦ ◦
was4 Cto6 Clowerthanthatofregularasphaltconcrete,butcoatedsurfacesreflected
118Wm
−2
moreshortwaveradiationonaverageandupto168Wm
−2
moreatnoon.Inthe
evening,MaRTyobserved20to30Wm
−2
ofaddedreflectedshortwaveradiationonsidewalksnext
◦
tothereflectivepavement.Meanradianttemperatureoverreflectivepavementwas4 Chigher
◦
duringmidday.Althoughairtemperaturewasreducedby0.5 Cintheafternoon,after-sunset
coolingwasnegligible.Findingsillustratethebenefitsanddisadvantagesofreflectivepavement
withrespecttovariousthermalperformancemetrics.CitiesshouldweighthetradeoffsofUHI
mitigation,thermalexposure,implementationandmaintenancecosts,lifecycle,andother
competingprioritiesinthecontextofspaceuse.
1.Introduction greening (Oliveira et al 2011, Norton et al 2015),
climate-sensitiveurbanformanddesign(Emmanuel
Urbanheatisaninvisibleenvironmentalhazardwith andFernando2007,Pearlmutteretal2007,Middelet
deadly consequences that poses a growing threat to al 2014), or change in materials and material prop-
humanhealth(Matthewsetal2017,Howeetal2019). erties, e.g. surface reflectivity (albedo) (Rosenfeld et
Exposuretoprolonguedheatisexpectedtoincrease al1995,AkbariandMatthews2012,Georgescuetal
infrequency,duration,andintensitywithcontinued 2014).Thisstudypresentsthefirstfield-basedassess-
urbanization and climatic change in the absence of ment of the heat mitigating performance of solar
effective adaptation measures (Jones et al 2015). In reflectivecoatingappliedtostreets.
addition to human health concerns, excess heat in Theinverserelationshipbetweenalbedoandsur-
urbanareashasimplicationsforairpollution(Sarrat facetemperatureissupportedbydecadesofurbancli-
etal2006)andenergyuse(Santamourisetal2001), mate scholarship (Rosenfeld et al 1995, Sailor 1995,
especiallyatnightwhentheUrbanHeatIsland(UHI), Taha 1997, Akbari et al 2001, Arnfield 2003, San-
i.e.increasedurbanvs.ruralnearsurfaceairtemper- tamouris 2013, 2014, Georgakis et al 2014, Akbari
ature,ismostpronounced(Oke1982).Awidesuiteof andKolokotsa2016).Fieldstudies,labexperiments,
urbanheatmitigationstrategieshavebeenproposed and modeling studies that focus on solar reflective
thatgenerallyfallintooneofthreecategories:urban coating and proxy materials have confirmed surface
©2020TheAuthor(s).PublishedbyIOPPublishingLtd

Environ.Res.Lett.15(2020)064016 AMiddeletal
temperature reductions of pavements and roofs via residentialblocksin2017.Thisinitiativeispartofa
albedo increases (Synnefa et al 2011, Carnielo and broadermunicipalwideefforttoreducethecitywide
Zinzi2013,Santamouris2013,Georgescuetal2014, average temperature by 1.7 ◦C by 2035 (City of Los
Mohegh et al 2017). Many authors have called for Angeles, Mayor’s Office of Sustainability 2019). Los
promotion of solar reflective coatings on pavement Angelesidentified‘coolpavements’asonestrategyto
inroads,parkinglots,andschoolplayyards(Rosen- achieveneighborhoodcooling,callingforpilotpro-
feld et al 1998, Akbari and Matthews 2012, Gilbert gramsandmonitoringtoinformthecityhowtomax-
et al 2016). To mitigate the UHI, municipalities in imizecooling.LosAngleleswillexpanditsheatmitig-
the United States have increasingly explored the use ationeffortstosixvulnerablecommunitiesby2021,
of solar reflective coatings (Estrada et al 2017, Gil- andtenby2025usingcoolroofs,solarreflectivecoat-
bertetal2016).Forexample,NewYork,NYandLos ing,andgreeninfrastructure.Inaddition,LAStreets
Angeles,CApassedcoolroofordinanceswithreflect- will coat 250 lane miles of City streets by 2028. The
anceandemittancestandardsfornewandretrofitted pLAn also calls for air temperature monitoring and
roofs (City of New York, Mayor’s Office of Sustain- coolstreetsefficacystudies.
ability 2019, City of Los Angeles, Mayor’s Office of Sun Valley and Pacoima are two of the San
Sustainability2019).Solarreflectivecoatingsarealso Fernando Valley residential neighborhoods that
included in long-term planning documents as UHI received solar reflective coatings in the summer of
mitigationstrategy,toenhanceresiliencetoextreme 2019 (figure 1). The neighborhoods were selected
heat,adapttoclimatechange,andachieveco-benefits using the Trust for Public Land Smart Cities Tool
such as energy savings and public health benefits. (CarynandBlaha2015)accountingforheatexposure
However,UHImitigation,i.e.thereductionofexcess and socio-economic vulnerability. Each neighbor-
ambienttemperatureincitiescomparedtoruralsur- hood received 10 to 12 contiguous blocks of Guard
roundings, is often confused with lowering surface TopCoolSealsurfacing(GuardTop2018).LAStreets
temperature—yet another measure that describes a reported surface temperature reductions over 10 ◦C
multifacetedconcept:heat. inbothneighborhoodsinJune2019(Mcdowelland
Pedestrianthermalexposureisgenerallyconcep- Lindblad 2019), a hot and dry month with average
tualizedasmeanradianttemperature(T ),asyn- maximum air temperature of 26 ◦C and a few days
MRT
thetic parameter that quantifies the radiative load recordinghighsofover32◦C.
on the human body (Verein Deutscher Ingenieure
(VDI) 1998). In hot dry environments, T is the 2.2.Datacollection
MRT
maindriverofhumanthermalcomfortandthemost The thermal performance of solar reflective pave-
human-relevant heat metric (Middel et al 2016). ment was monitored during hourly biometeorolo-
While impacts of solar reflective coatings on air or gicaltransectsusingthemobileinstrumentplatform
surface temperature have been widely studied (San- MaRTy(MiddelandKrayenhoff2019).MaRTymeas-
tamouris 2013, Georgakis et al 2014, Middel et al uressix-directionallongwave(L)andshortwave(K)
2015,Qin2015a,Moheghetal2017),todate,obser- radiation flux densities, air temperature (T ), sur-
a
vational studies on radiative temperature are rare, face temperature (T), horizontal wind speed (v),
s
andtheradiativeeffectofreflectivesurfacesonped- andrelativehumidity(RH)atpedestrianheight(1.1
estrians has only been assessed in physical models to 1.5 m). Simultaneous transects were conducted
(Pearlmutteretal2006),notcomplexurbansettings. in Sun Valley and Pacoima from 11:00 LST (Local
Solar reflective pavement interventions, or ‘cool Standard Time) to 21:00 LST on July 30, 2019,
streets’,forefronttheissueofhumanoutdoorthermal a typical Los Angeles summer day with low wind
exposure. Some scholars hypothesize improvements speeds(<1.6ms−1)andmaximumairtemperature
(Synnefaetal2007);otherspredictincreasedthermal of 31.0 ◦C. Each transect took 50 min to complete
stress and glare (Erell et al 2014, Taleghani et al and included 24 stops per neighborhood (figure 2):
2016,TaleghaniandBerardi2018).Here,wegobey- foursitesonsolarreflectivepavement,fourreference
ond modeling and simulation. We present the first sites on asphalt concrete, and 16 stops on adjacent
T on-sitemeasurementsofsolarreflectivecoating cementconcretesidewalksthatwereseparatedfrom
MRT
(GuardTopCoolSeal)usinganovelmobilebiomet- theroadbya1munobstructeddecomposedgranite
eorologicalinstrumentplatform(MaRTy)thatmeas- andcementconcretesetback.Thestopswerechosen
uresallmeteorologicalvariablesrelevanttoaperson’s accordingtotheresponsetimeoftheslowestsensor
weather experience to assess the thermal impacts of to minimize the impact of sensor lag on observed
albedoincreaseonpedestrians. thermal performance (H¨ab et al 2015). All biomet-
eorologicalvariableswererecordedat2sintervals.
2.Methods
2.3.Dataprocessingandanalysis
2.1.Studysites Observed six-directional radiation flux densities
The Los Angeles Streets Department (LA Streets) were transformed into mean radiant temperature
began piloting the use of solar reflective coatings in (T ). T integrates the total longwave and
MRT MRT
2

| Environ.Res.Lett.15(2020)064016 |     |     |     |     | AMiddeletal |
| ------------------------------- | --- | --- | --- | --- | ----------- |
Figure1.(a)Regularasphaltconcrete(left)andCoolSealcoatedasphaltconcrete(right)inPacoima,CA;(b)Biometeorological
observationsatacoolpavementsiteinSunValley,CAwiththemobileinstrumentplatformMaRTy(MiddelandKrayenhoff
2019).
Figure2.BiometeorologicalobservationsinPacoima,CA(a)andSunValley,CA(b)withthemobileinstrumentplatformMaRTy
(MiddelandKrayenhoff2019).
shortwave radiation a human body is exposed the monitored surfaces was calculated as daytime
=
to ( into a single temperature ) value: T MRT average ratio of observed reflected and incoming K.
| ∑6  | 0.25 |     | For each neighborhood, | average hourly | differences |
| --- | ---- | --- | ---------------------- | -------------- | ----------- |
−273.15[◦C],where
| W i (a k K i +aL)/aσ | l i l |     |                            |                       |     |
| -------------------- | ----- | --- | -------------------------- | --------------------- | --- |
|                      |       |     | andstandarddeviationsofT,T | s a ,reflectedK,emit- |     |
i=1
K and L are shortwave and longwave radiation tedL,andT betweenthereflectivepavementand
i i MRT
[Wm−2],
flux densities in all cardinal directions regularasphaltconcretesiteswerecalculatedtoassess
a and a are absorption coefficients for shortwave multi-metricthermalperformance.
k l
(0.70)andlongwave(0.97)radiation,σistheStefan-
| Boltzmann constant, | and W | are weighting factors | 3.Results |     |     |
| ------------------- | ----- | --------------------- | --------- | --- | --- |
i
| (0.06 for up/down | and 0.22 | for cardinal directions) |     |     |     |
| ----------------- | -------- | ------------------------ | --- | --- | --- |
to account for the human body’s elongated shape We observed albedo, hourly surface temperature
(Middel and Krayenhoff 2019). All biometeoro- (T s ), six-directional radiation flux densities, T MRT ,
logical variables and directional fluxes were time- and air temperature (T ) of solar reflective pave-
a
detrended to the nearest half hour. The albedo of ment,regularasphaltconcrete,andadjacentcement
3

| Environ.Res.Lett.15(2020)064016 |     |     |     |     |     |     |     |     |     | AMiddeletal |
| ------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------- |
Table1.HourlyairandsurfacetemperatureobservationswithMaRTyinSunValley(left)andPacoima(right)between11:30LSTand
20:00LSTonJuly30,2019.Summaryincludesobservationsoncementconcretesidewalks(C),asphaltconcrete(A),solarreflectivecool
pavement(CP),thedifferencebetweenCPandA,andthedifferencebetweenCPandC.Observationsthatwereinfluencedbyshadows
frombuildingsandtreeswereexcluded(blankcells).
|       |      |                        | SunValley |      |      |     |      |                        | Pacoima   |      |
| ----- | ---- | ---------------------- | --------- | ---- | ---- | --- | ---- | ---------------------- | --------- | ---- |
|       |      | Surfacetemperature[◦C] |           |      |      |     |      | Surfacetemperature[◦C] |           |      |
| Time  | C    | A                      | CP        | CP-A | CP-C |     | C    | A                      | CP CP-A   | CP-C |
| 11:30 | 42.7 | 48.3                   | 43.1      | −5.1 |      | 0.4 | 43.0 | 48.2                   | 43.6 −4.6 | 0.6  |
| 12:30 | 46.8 | 53.1                   | 47.2      | −5.9 |      | 0.3 | 46.9 | 53.2                   | 47.8 −5.4 | 0.9  |
|       |      |                        |           | −5.9 |      |     |      |                        | −5.8      |      |
| 13:30 | 48.5 | 54.8                   | 48.9      |      |      | 0.4 | 48.7 | 55.9                   | 50.2      | 1.5  |
|       |      |                        |           | −6.0 |      |     |      |                        | −5.4      |      |
| 14:30 | 49.1 | 55.3                   | 49.3      |      |      | 0.2 | 48.9 | 55.8                   | 50.3      | 1.4  |
| 15:30 | 48.0 | 53.9                   | 48.2      | −5.7 |      | 0.2 | 47.8 | 54.0                   | 49.7 −4.2 | 1.9  |
| 16:30 | 45.7 | 50.9                   | 45.7      | −5.3 |      | 0.0 | 45.3 | 50.9                   | 46.2 −4.7 | 0.9  |
|       |      |                        |           | −3.9 | −0.2 |     |      |                        |           |      |
| 17:30 | 42.5 | 46.3                   | 42.3      |      |      |     |      |                        |           |      |
| 18:30 | 39.5 | 42.1                   | 38.1      | −4.0 | −1.4 |     |      |                        |           |      |
19:30
|       |      |      |                    | −1.6 |      |     |      |                    | −1.8      |          |
| ----- | ---- | ---- | ------------------ | ---- | ---- | --- | ---- | ------------------ | --------- | -------- |
| 20:00 | 30.6 | 32.5 | 30.9               |      |      | 0.3 | 31.3 | 33.6               | 31.8      | 0.5      |
|       |      |      | Airtemperature[◦C] |      |      |     |      | Airtemperature[◦C] |           |          |
| Time  | C    | A    | CP                 | CP-A | CP-C |     | C    | A                  | CP CP-A   | CP-C     |
| 11:30 | 27.6 | 27.5 | 27.8               |      | 0.2  | 0.2 | 28.6 | 28.3               | 28.6      | 0.3 0.0  |
| 12:30 | 30.1 | 30.3 | 30.1               | −0.2 | −0.1 |     | 31.3 | 30.9               | 31.1      | 0.2 −0.2 |
| 13:30 | 30.9 | 30.9 | 31.0               |      | 0.1  | 0.0 | 33.0 | 32.6               | 33.0      | 0.4 0.0  |
|       |      |      |                    | −0.1 | −0.1 |     |      |                    | −0.1      |          |
| 14:30 | 30.8 | 30.8 | 30.7               |      |      |     | 32.7 | 32.8               | 32.7      | 0.0      |
| 15:30 | 30.1 | 30.3 | 29.9               | −0.5 | −0.3 |     | 32.4 | 32.1               | 32.5      | 0.4 0.1  |
| 16:30 | 29.4 | 29.7 | 29.2               | −0.5 | −0.2 |     | 31.2 | 31.3               | 31.2 −0.1 | 0.0      |
−0.1
| 17:30 | 28.9 | 28.8 | 28.8 |     | 0.0 |     |     |     |     |     |
| ----- | ---- | ---- | ---- | --- | --- | --- | --- | --- | --- | --- |
| 18:30 | 28.4 | 28.7 | 27.8 |     |     |     |     |     |     |     |
19:30
|       |      |      |      | −0.2 | −0.1 |     |      |      | −0.1 | −0.1 |
| ----- | ---- | ---- | ---- | ---- | ---- | --- | ---- | ---- | ---- | ---- |
| 20:00 | 23.6 | 23.7 | 23.5 |      |      |     | 24.6 | 24.7 | 24.6 |      |
Wm−2
concrete sidewalks in Sun Valley and Pacoima (San pavement emitted 33 to 47 less longwave
FernandoValley,CA) residential neighborhoods radiation than untreated asphalt concrete between
(table 1). The 7 weeks old reflective pavement in 11:30 LST and 16:00 LST. Due to this net radiation
Sun Valley had an average albedo of 0.18, while the gain,T overreflectivepavementwas4.0◦Chigher
MRT
◦C
5 weeks old reflective pavement in Pacoima exhib- during midday and 2.0 higher in the afternoon
itedanalbedoof0.25.Theuncoatedasphaltconcrete than T over asphalt concrete. At low sun angles
MRT
(earlyevening),weobservedanadded20to30Wm−2
roadalbedowasbetween0.06and0.08,andtheadja-
centcementconcretesidewalkhadanaveragealbedo ofreflectedshortwaveradiationoncementconcrete
| of0.20. |     |     |     |     |     | sidewalksadjacenttothereflectivepavement.After- |     |     |     |     |
| ------- | --- | --- | --- | --- | --- | ----------------------------------------------- | --- | --- | --- | --- |
Thehighlyreflectivecoatingreducedroadsurface noon near ground air temperature was 0.4◦ C to
0.5◦
temperature at all observation times (11:30 LST to Cloweroverreflectivepavementthanuncoated
20:00LST).Comparedtouncoatedasphaltconcrete, asphaltconcrete,butcoolingwasnegligibleaftersun-
|              |     |      | ◦C,             |     |          | set(0.1◦ | Cto0.2◦C,whichisintherangeofsensor |     |     |     |
| ------------ | --- | ---- | --------------- | --- | -------- | -------- | ---------------------------------- | --- | --- | --- |
| which peaked | at  | 55.9 | T of reflective |     | pavement |          |                                    |     |     |     |
s
| wasupto6.0◦Clowerduringmidday,4.0◦Clower |     |     |     |     |     | accuracy). |     |     |     |     |
| ---------------------------------------- | --- | --- | --- | --- | --- | ---------- | --- | --- | --- | --- |
◦C
| in the early | evening, |     | and 1.6 to 1.8 |     | lower after |     |     |     |     |     |
| ------------ | -------- | --- | -------------- | --- | ----------- | --- | --- | --- | --- | --- |
sunset.T ofthecoatedroadwascomparabletothe 4.Discussionandconclusions
s
adjacentcementconcretesidewalktemperaturedur-
| ing the | day, but | the reflective | pavement |     | was 2.0 ◦C |       |                    |     |           |             |
| ------- | -------- | -------------- | -------- | --- | ---------- | ----- | ------------------ | --- | --------- | ----------- |
|         |          |                |          |     |            | MaRTy | field observations |     | show that | high albedo |
coolerthanthesidewalkaftersunset. solar reflective coatings on asphalt concrete reduce
| We  | decomposed |     | observed six-directional |     | flux |         |              |     |                 |          |
| --- | ---------- | --- | ------------------------ | --- | ---- | ------- | ------------ | --- | --------------- | -------- |
|     |            |     |                          |     |      | surface | temperatures | to  | cement concrete | sidewalk |
densities into their directional longwave and short- levels,especiallyinthemid-to-lateafternoonhours.
wave components to assess the impact of different Observedmitigativeeffectsconfirmpreviouslyrepor-
paving on human thermal exposure (table 2). The ted surface temperature reductions. Conversely,
Wm−2
coated asphalt concrete reflected up to 130 coated streets increased T MRT in the early-to-mid
(SunValley)and168Wm−2 (Pacoima)moreshort- afternoonhours,revealingadirecttradeoffbetween
wave radiation than regular asphalt concrete at surfacetemperaturereductionandhumanheatload
solar noon (total incoming shortwave radiation: on solar reflective pavements. Results are in accord-
Wm−2).
1125 On average, daytime hourly reflec- ance with biometeorological simulations (Erell et al
tedshortwaveradiationincreasedby118Wm−2 and 2014, Taleghani and Berardi 2018) and suggest that
Wm−2,
144 respectively. Conversely, the reflective cool pavement does not advance municipal goals
4

| Environ.Res.Lett.15(2020)064016 |     |     |     |     |     | AMiddeletal |
| ------------------------------- | --- | --- | --- | --- | --- | ----------- |
Table2.HourlyradiationfluxobservationswithMaRTyinSunValley(left)andPacoima(right)between11:30LSTand20:00LSTon
July30,2019.Summaryincludesobservationsoncementconcretesidewalks(C),asphaltconcrete(A),solarreflectivecoolpavement
(CP),thedifferencebetweenCPandA,andthedifferencebetweenCPandC.Observationsthatwereinfluencedbyshadowsfrom
buildingsandtreeswereexcluded(blankcells).
|     | SunValley |     |     |     | Pacoima |     |
| --- | --------- | --- | --- | --- | ------- | --- |
Emittedlongwaveradiation[Wm−2] Emittedlongwaveradiation[Wm−2]
| Time C | A CP | CP-A | CP-C | C A | CP CP-A | CP-C |
| ------ | ---- | ---- | ---- | --- | ------- | ---- |
11:30 564.4 605.0 567.3 −37.7 2.9 566.2 604.4 570.6 −33.8 4.5
12:30 594.5 642.4 596.8 −45.6 2.3 595.0 643.3 601.7 −41.5 6.8
|             |             | −45.9 |     |             | −45.4 |      |
| ----------- | ----------- | ----- | --- | ----------- | ----- | ---- |
| 13:30 607.2 | 656.1 610.2 |       | 3.0 | 608.6 665.0 | 619.6 | 10.9 |
|             |             | −46.9 |     |             | −42.8 |      |
| 14:30 611.5 | 659.9 613.0 |       | 1.5 | 610.1 663.6 | 620.8 | 10.7 |
15:30 603.0 648.9 604.6 −44.3 1.6 602.1 649.2 616.0 −33.2 14.0
16:30 586.0 625.3 585.8 −39.5 −0.2 583.4 625.3 590.1 −35.2 6.7
|             |             | −28.6 | −1.3 |     |     |     |
| ----------- | ----------- | ----- | ---- | --- | --- | --- |
| 17:30 563.0 | 590.2 561.7 |       |      |     |     |     |
| 18:30 541.8 | 559.5 531.9 |       |      |     |     |     |
19:30
|             |             | −10.1 |     |             | −11.3 |     |
| ----------- | ----------- | ----- | --- | ----------- | ----- | --- |
| 20:00 482.9 | 494.9 484.8 |       | 1.9 | 487.4 501.7 | 490.5 | 3.1 |
Reflectedshortwaveradiation[Wm−2] Reflectedshortwaveradiation[Wm−2]
| Time C | A CP | CP-A | CP-C | C A | CP CP-A | CP-C |
| ------ | ---- | ---- | ---- | --- | ------- | ---- |
11:30 165.3 62.6 179.4 116.8 14.1 189.2 80.6 225.8 145.2 36.6
12:30 174.9 65.7 195.4 129.7 20.5 203.2 80.2 243.6 163.4 40.4
13:30 177.3 67.7 197.7 130.0 20.5 197.8 79.8 248.0 168.2 50.2
14:30 166.2 63.2 191.4 128.2 25.2 173.9 72.1 227.1 155.0 53.3
15:30 153.1 60.7 174.4 113.7 21.4 148.8 64.5 206.1 141.5 57.3
| 16:30 119.0 | 51.8 142.7 | 90.9 | 23.7 | 115.5 52.7 | 142.5 89.8 | 27.0 |
| ----------- | ---------- | ---- | ---- | ---------- | ---------- | ---- |
| 17:30 74.2  | 34.7 96.5  | 61.8 | 22.3 |            |            |      |
| 18:30 37.1  | 17.6 50.6  |      |      |            |            |      |
19:30
|            |                            | −0.9 | −0.4 |                            | −0.3     |      |
| ---------- | -------------------------- | ---- | ---- | -------------------------- | -------- | ---- |
| 20:00 3.5  | 4.0 3.1                    |      |      | 4.0 4.5                    | 4.2      | 0.3  |
|            | Meanradianttemperature[◦C] |      |      | Meanradianttemperature[◦C] |          |      |
| Time C     | A CP                       | CP-A | CP-C | C A                        | CP CP-A  | CP-C |
| 11:30 61.4 | 58.8 63.0                  | 4.2  | 1.5  | 60.5 57.2                  | 61.4 4.2 | 0.9  |
| 12:30 61.2 | 58.8 63.0                  | 4.2  | 1.8  | 60.6 57.6                  | 61.5 4.0 | 0.9  |
| 13:30 62.3 | 60.2 63.2                  | 3.0  | 0.9  | 61.7 59.8                  | 63.5 3.7 | 1.8  |
| 14:30 64.7 | 63.2 65.4                  | 2.2  | 0.6  | 62.2 61.7                  | 64.5 2.8 | 2.3  |
| 15:30 63.9 | 62.1 64.5                  | 2.3  | 0.6  | 65.1 64.4                  | 67.0 2.6 | 1.9  |
| 16:30 61.3 | 59.9 61.1                  | 1.2  | −0.1 | 65.1 63.7                  | 64.9 1.2 | −0.2 |
| 17:30 57.0 | 56.8 57.0                  | 0.2  | 0.0  |                            |          |      |
| 18:30 53.3 | 55.1 52.1                  |      |      |                            |          |      |
19:30
|            |           | −0.9 | −0.2 |           | −1.0 | −0.6 |
| ---------- | --------- | ---- | ---- | --------- | ---- | ---- |
| 20:00 22.7 | 23.4 22.5 |      |      | 24.4 24.9 | 23.8 |      |
to promote outdoor activities and walkability for Incombination,thesefindingsimplythathighly
positive health outcomes. Observations also reveal reflective coating cannot substitute all of the micro-
that pedestrian heat load in the early evening may climateregulatingservicesofvegetationlosttourban
beslightlyhigheronsidewalkswherepeoplewalkif development,especiallytheshadebenefitsthatreduce
the road is not separated by a vegetated setback as pedestrianexposuretoheat.
noted by Rosado et al (2017). Observed air temper- Policiespromotingwidespreadadoptionofsolar
aturereductionovercoolpavementwasinsignificant reflectivecoatingscanbecharacterizedas‘policypan-
compared to predicted decreases from whole-city aceas,’(Ostrometal2007):aclassofseeminglysimple
models(Santamouris 2013).Airtemperaturediffer- remedies for major environmental challenges that,
ences(0.1–0.2◦C)werethesameorderofmagnitude whenuniversallyapplied,frequentlyfailduetofaulty
as the sensor accuracy of the air temperature probe assumptions of similarity in conditions in which a
(0.1◦C)andcanthereforebeconsiderednoise.These problem occurs. The effectiveness of solar reflective
results are expected due to the limited extent of the coatingsishighlycontextdependent.Reflectivecoat-
cool pavement intervention. Millstein and Levinson ings likely perform differently between intervention
(2018)developedanidealizedtheoreticalframework sitesbecauseeffectivenessisdependentontheback-
toestimatehowfarairwouldhavetoflowtoregister ground climate and built environment (Salata et al
atemperaturechangeandfoundthatairtemperature 2015, Qin 2015a, 2015b). For example, the surface
at 1.5 m height would have to flow > 200 m over a temperaturereductionduetohighlyreflectivecoating
coolersurfacetoregistera0.1◦Creduction.
isexpectedtobesmallerincolderclimatesandsites
5

| Environ.Res.Lett.15(2020)064016 |     |     |     |     |     |     |     |     |     | AMiddeletal |
| ------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----------- |
withmorecloudcover.Moreover,albedohasdiffer- implementingsolarreflectivecoatings,municipalities
enteffectsonsurface,air,andradianttemperatures, should consider all environmental, social, and eco-
and those effects are moderated by urban design— nomic tradeoffs for long-term viability. They also
building shape, sky view factor, street setbacks— need to consider when and how people use land to
at the sub-neighborhood scale (Middel etal 2014, decidewhichheatmetric(air,surface,orradianttem-
2017). Although the scientific community recog- perature) should be prioritized. Extrapolations that
nizes cool pavement creates trade-offs between sur- solar reflective coatings can migrate from roofs to
face, air, and radiant temperature across times, loc- streetsasanequallyeffectivemeanstoaddressUHI,
ations, and scales, policy response is less nuanced. energyconsumption,andhumanheatexposuresim-
Planning documents and political narratives some- plify complex relationships between the built envir-
| timesframetheLosAngelescoolpavementpilotpro- |          |        |             |      |      | onmentandheat. |     |     |     |     |
| -------------------------------------------- | -------- | ------ | ----------- | ---- | ---- | -------------- | --- | --- | --- | --- |
| gram as an                                   | approach | to     | mitigate    | UHIs | with | the co-        |     |     |     |     |
| benefits of                                  | reducing | energy | consumption |      | and  | redu-          |     |     |     |     |
Acknowledgments
cinghumanheatexposure,explicitlyprioritizinglow
incomeareasofthecity(CityofLosAngeles,Mayor’s
|     |     |     |     |     |     | This study | was funded | by the | University | of Califor- |
| --- | --- | --- | --- | --- | --- | ---------- | ---------- | ------ | ---------- | ----------- |
OfficeofSustainability2019).Ourfindingspointto
theneedforpolicydocumentstomakeexplicitwhich nia Los Angeles Luskin Center for Innovation and
supportedbytheUrbanClimateResearchCenterat
heat-relatedgoalswillbeadvancedbywhichcooling
interventionsand to more comprehensively discuss ArizonaStateUniversity.Anyopinions,findings,and
|     |     |     |     |     |     | conclusions | or recommendations |     | expressed | in this |
| --- | --- | --- | --- | --- | --- | ----------- | ------------------ | --- | --------- | ------- |
tradeoffs.
Finally, roofs and streets are used differently by materialarethoseoftheauthorsanddonotnecessar-
ilyreflecttheviewsofthesponsoringorganizations.
people,sothenormativerankingofsurface,air,and
| radiant temperature |     | may | differ. | For instance, |     | while |     |     |     |     |
| ------------------- | --- | --- | ------- | ------------- | --- | ----- | --- | --- | --- | --- |
Dataavailabilitystatement
| school playgrounds |     | offer | abundant |     | government- |     |     |     |     |     |
| ------------------ | --- | ----- | -------- | --- | ----------- | --- | --- | --- | --- | --- |
ownedpavementtotargetforinterventiontoreduce
|            |     |        |        |             |     | The data | that support | the findings | of  | this study are |
| ---------- | --- | ------ | ------ | ----------- | --- | -------- | ------------ | ------------ | --- | -------------- |
| urban heat | and | energy | costs, | playgrounds | are | recre-   |              |              |     |                |
ational spaces used by a vulnerable group (chil- available from the corresponding author upon reas-
onablerequest.
| dren) at | peak | T hours. |     | Considering | potential |     |     |     |     |     |
| -------- | ---- | -------- | --- | ----------- | --------- | --- | --- | --- | --- | --- |
MRT
| tradeoffs | between | surface    | and | radiant    | temperat- |         |     |     |     |     |
| --------- | ------- | ---------- | --- | ---------- | --------- | ------- | --- | --- | --- | --- |
| ure under | such    | conditions | is  | paramount. | Alternat- | ORCIDiD |     |     |     |     |
ively,targetingpedestrian-freeroofsreducesconcerns
about human thermal exposure, but raises imple- ArianeMiddelhttps://orcid.org/0000-0002-1565-
| mentation | challenges | related |     | to fragmented |     | owner- |     |     |     |     |
| --------- | ---------- | ------- | --- | ------------- | --- | ------ | --- | --- | --- | --- |
095X
ship(CoolRoofToolkit2012).
| Cool | street | interventions |     | are novel | experiments |     |     |     |     |     |
| ---- | ------ | ------------- | --- | --------- | ----------- | --- | --- | --- | --- | --- |
References
| that capitalize |     | on an accessible |     | municipal |     | asset by |     |     |     |     |
| --------------- | --- | ---------------- | --- | --------- | --- | -------- | --- | --- | --- | --- |
repositioningstreetsasasolutiontoUHI,asopposed
AkbariHandKolokotsaD2016Threedecadesofurbanheat
| to a cause, | and | provide | important | opportunities |     | to  |     |     |     |     |
| ----------- | --- | ------- | --------- | ------------- | --- | --- | --- | --- | --- | --- |
islandsandmitigationtechnologiesresearchEnergyBuild.
| learn how | solar | reflective | coatings | work | in practice. |     |     |     |     |     |
| --------- | ----- | ---------- | -------- | ---- | ------------ | --- | --- | --- | --- | --- |
133834–42
Our study provides first field observations of T , AkbariHandMatthewsHD2012Globalcoolingupdates:
MRT
and others should follow. Measurements were con- reflectiveroofsandpavementsEnergyBuild.552–6
AkbariH,PomerantzMandTahaH2001Coolsurfacesand
ductedinfullsun-exposedlocationsover9hintwo
shadetreestoreduceenergyuseandimproveairqualityin
| similarly | treated | sites, | but more | ‘living | laboratory’ |     |     |     |     |     |
| --------- | ------- | ------ | -------- | ------- | ----------- | --- | --- | --- | --- | --- |
urbanareasSol.Energy70295–310
experiments are needed to investigate diurnal, sea- ArnfieldAJ2003Twodecadesofurbanclimateresearch:Areview
sonal, and inter-annual variability as well as differ- ofturbulence,exchangesofenergyandwater,andtheurban
heatislandInt.J.Climatol.231–26
| ences related | to  | intervention |     | scale, urban | form, | cli- |     |     |     |     |
| ------------- | --- | ------------ | --- | ------------ | ----- | ---- | --- | --- | --- | --- |
CarnieloEandZinziM2013Opticalandthermalcharacterisation
maticcontexts,andcoolsurfacecoatingmaterials.
ofcoolasphaltstomitigateurbantemperaturesand
This study examined one potential trade-off buildingcoolingdemandBuild.Environ.6056–65
between land surface temperature and T . Other CarynEandBlahaK(2015)Decisionsupporttoolsforclimate
MRT
changeplanning(https://www.tpl.org/sites/default/files/
potentialcoolpavementtradeoffstoconsiderinclude
files_upload/ClimateSmartDecisionSupport.pdf)
increasedreflectedUVradiation(Epsteinetal2017),
CityofNewYork,Mayor’sOfficeofSustainability2019
daytimeglareversusnighttimevisibility,lowupfront OneNewYork:ThePlanforaStrongandJustCity
installationcostsversusmaintenancecostsasmater- (http://1w3f31pzvdm485dou3dppkcq.wpengine.netdna-
cdn.com/wp-content/uploads/2020/01/OneNYC-2050-Full-
| ials degrade, | and | environmental |     | impact | over | the |     |     |     |     |
| ------------- | --- | ------------- | --- | ------ | ---- | --- | --- | --- | --- | --- |
Report-1.3.pdf)
| material | lifecycle | (Gilbert | et  | al 2016, | Mohegh | et al |     |     |     |     |
| -------- | --------- | -------- | --- | -------- | ------ | ----- | --- | --- | --- | --- |
CityofLosAngeles,Mayor’sOfficeofSustainability2019L.A.’s
| 2017). |     |     |     |     |     | GreenNewDeal:SustainableCitypLAn(LosAngeles) |     |     |     |     |
| ------ | --- | --- | --- | --- | --- | -------------------------------------------- | --- | --- | --- | --- |
Solarreflectivecoatingsarenotapolicypanacea (https://plan.lamayor.org/sites/default/files/pLAn_
2019_final.pdf)
| for urban | heat | problems | through | which | similarity |     |     |     |     |     |
| --------- | ---- | -------- | ------- | ----- | ---------- | --- | --- | --- | --- | --- |
GlobalCoolCitiesAllianceandR20RegionsofClimateAction.
| in conditions | and | context | can | be assumed. |     | Before |     |     |     |     |
| ------------- | --- | ------- | --- | ----------- | --- | ------ | --- | --- | --- | --- |
2012APracticalGuidetoCoolRoofsandCoolPavements
6

Environ.Res.Lett.15(2020)064016 AMiddeletal
Retrievedfrom(https://www.coolrooftoolkit.org/wp- MoheghA,RosadoP,JinL,MillsteinD,LevinsonRand
content/pdfs/CoolRoofToolkit_Full.pdf) Ban-WeissG2017Modelingtheclimateimpactsof
EmmanuelRandFernandoHJS2007Urbanheatislandsin deployingsolarreflectivecoolpavementsinCaliforniacities
humidandaridclimates:roleofurbanformandthermal J.Geophys.Res.1226798–817
propertiesinColombo,SriLankaandPhoenix,USAClim. NortonBA,CouttsAM,LivesleySJ,HarrisRJ,HunterAMand
Res.34241–51 WilliamsNSG2015Planningforcoolercities:aframework
EpsteinSA,LeeSM,KatzensteinAS,Carreras-SospedraM, toprioritisegreeninfrastructuretomitigatehigh
ZhangX,FarinaSC,VahmaniP,FinePMandBan-WeissG temperaturesinurbanlandscapesLandsc.UrbanPlan.
2017Air-qualityimplicationsofwidespreadadoptionof 134127–38
coolroofsonozoneandparticulatematterinsouthern OkeTR1982TheenergeticbasisoftheurbanheatislandQ.J.R.
CaliforniaProc.NatlAcad.Sci.U.S.A.1148991–6 Meteorol.Soc.1081–24
ErellE,PearlmutterD,BonehDandKutielPB2014Effectof OliveiraS,AndradeHandVazT2011Thecoolingeffectofgreen
high-albedomaterialsonpedestrianheatstressinurban spacesasacontributiontothemitigationofurbanheat:a
streetcanyonsUrbanClim.10367–86 casestudyinLisbonBuild.Environ.462186–94
EstradaF,BotzenWJWandTolRSJ2017Aglobaleconomic OstromE,JanssenMAandAnderiesJM2007Goingbeyond
assessmentofcitypoliciestoreduceclimatechangeimpacts panaceasProc.NatlAcad.Sci.U.S.A.10415176–8
Nat.Clim.Change7403–6 PearlmutterD,BerlinerPandShavivE2006Physicalmodelingof
GeorgakisC,ZorasSandSantamourisM2014Studyingtheeffect pedestrianenergyexchangewithintheurbancanopyBuild.
of“cool”coatingsinstreeturbancanyonsanditspotential Environ.41783–95
asaheatislandmitigationtechniqueSustain.CitiesSoc. PearlmutterD,BerlinerPandShavivE2007Urbanclimatologyin
1320–31 aridregions:currentresearchintheNegevdesertInt.J.
GeorgescuM,MorefieldPE,BierwagenBGandWeaverCP2014 Climatol.271875–85
Urbanadaptationcanrollbackwarmingofemerging QinY2015aAreviewonthedevelopmentofcoolpavementsto
megapolitanregionsProc.NatlAcad.Sci.U.S.A.111 mitigateurbanheatislandeffectRenew.Sustain.EnergyRev.
2909–14 52445–59
GilbertH,MandelBHandLevinsonR2016KeepingCalifornia QinY2015bUrbancanyonalbedoanditsimplicationontheuse
cool:recentcoolcommunitydevelopmentsEnergyBuild. ofreflectivecoolpavementsEnergyBuild.9686–94
11420–26 RosadoPJ,Ban-WeissG,MoheghAandLevinsonRM2017
GuardTop2018CoolSeal(https://guardtop.com/wp-content/ Influenceofstreetsetbacksonsolarreflectionandair
uploads/2018/02/CoolSeal_trifold.pdf) coolingbyreflectivestreetsinurbancanyonsSol.Energy
H¨abK,RuddellBLandMiddelA2015Sensorlagcorrectionfor 144144–57
mobileurbanmicroclimatemeasurementsUrbanClim.14 RosenfeldAH,AkbariH,BretzS,FishmanBL,KurnDM,
622–35 SailorDandTahaH1995Mitigationofurbanheatislands:
HowePD,MarlonJR,WangXandLeiserowitzA2019Public materials,utilityprograms,updatesEnergyBuild.
perceptionsofthehealthrisksofextremeheatacrossUS 22255–65
states,counties,andneighborhoodsProc.NatlAcad.Sci. RosenfeldAH,AkbariH,RommJJandPomerantzM1998Cool
U.S.A.1166743–8 communities:strategiesforheatislandmitigationandsmog
JonesB,O’NeillBC,McdanielL,McginnisS,MearnsLOand reductionEnergyBuild.2851–62
TebaldiC2015FuturepopulationexposuretoUSheat SailorDJ1995Simulatedurbanclimateresponseto
extremesNat.Clim.Change5652–5 modificationsinsurfacealbedoandvegetativecoverJ.Appl.
MatthewsTKR,WilbyRLandMurphyC2017Communicating Meteorol.341694–704
thedeadlyconsequencesofglobalwarmingforhumanheat SalataF,GolasiI,VollaroADLandVollaroRDL2015Howhigh
stressProc.NatlAcad.Sci.U.S.A.1143861–6 albedoandtraditionalbuildings’materialsandvegetation
McdowellJPandLindbladB2019LosAngelescoolpavement affectthequalityofurbanmicroclimate.AcasestudyEnergy
pilotInt.Conf.onCountermeasurestoUrbanHeatIslands Build.9932–49
(availableat:https://www.climateresolve.org/wp- SantamourisM2014Ontheenergyimpactofurbanheatisland
content/uploads/2019/12/CoolPavementsForLosAngeles andglobalwarmingonbuildingsEnergyBuild.82100–13
_IC2UHI2019.pdf) SantamourisM2013Usingcoolpavementsasamitigation
MiddelA,ChhetriNandQuayR2015Urbanforestryandcool strategytofighturbanheatisland—Areviewoftheactual
roofs:assessmentofheatmitigationstrategiesinPhoenix developmentsRenew.Sustain.EnergyRev.26224–40
residentialneighborhoodsUrbanFor.UrbanGreen. SantamourisM,PapanikolaouN,LivadaI,KoronakisI,
14178–86 GeorgakisC,ArgiriouAandAssimakopoulosDN2001On
MiddelA,H¨abK,BrazelAJ,MartinCAandGuhathakurtaS theimpactofurbanclimateontheenergyconsuptionof
2014Impactofurbanformanddesignonmid-afternoon buildingSol.Energy70201–16
microclimateinPhoenixLocalClimateZonesLandsc. SarratC,LemonsuA,MassonVandGuedaliaD2006Impactof
UrbanPlan.12216–28 urbanheatislandonregionalatmosphericpollutionAtmos.
MiddelAandKrayenhoffES2019Micrometeorological Environ.401743–58
determinantsofpedestrianthermalexposureduring SynnefaA,KarlessiT,GaitaniN,SantamourisM,
record-breakingheatinTempe,Arizona:introducingthe AssimakopoulosDNandPapakatsikasC2011Experimental
MaRTyobservationalplatformSci.TotalEnviron. testingofcoolcoloredthinlayerasphaltandestimationofits
687137–51 potentialtoimprovetheurbanmicroclimateBuild.Environ.
MiddelA,SeloverN,HagenBandChhetriN2016Impactof 4638–44
shadeonoutdoorthermalcomfort—aseasonalfield SynnefaA,SantamourisMandApostolakisK2007Onthe
studyinTempe,ArizonaInt.J.Biometeorol.60 development,opticalpropertiesandthermalperformance
1849–61 ofcoolcoloredcoatingsfortheurbanenvironmentSol.
MiddelA,LukasczykJandMaciejewskiR2017Skyviewfactors Energy81488–97
fromsyntheticfisheyephotosforthermalcomfort TahaH1997Urbanclimatesandheatislands:albedo,
routing—acasestudyinPhoenix,ArizonaUrbanPlan. evapotranspiration,andanthropogenicheatEnergyBuild.
219–30 2599–103
MillsteinDandLevinsonR2018Preparatorymeteorological TaleghaniMandBerardiU2018Theeffectofpavement
modelingandtheoreticalanalysisforaneighborhood-scale characteristicsonpedestrians’thermalcomfortinToronto
coolroofdemonstrationUrbanClim.24616–32 UrbanClim.24449–59
7

Environ.Res.Lett.15(2020)064016 AMiddeletal
TaleghaniM,SailorD,andBan-WeissGA2016 VereinDeutscherIngenieure(VDI)1998VDI3787PartI:
Micrometeorologicalsimulationstopredicttheimpactsof EnvironmentalMeteorology,Methodsforthe
heatmitigationstrategiesonpedestrianthermalcomfortin Human-biometeorologicalEvaluationofClimateandAir
aLosAngelesneighborhoodEnviron.Res.Lett. QualityfortheUrbanandRegionalPlanningatRegional
11024003 Level.PartI:Climate(Berlin:Beuth)
8
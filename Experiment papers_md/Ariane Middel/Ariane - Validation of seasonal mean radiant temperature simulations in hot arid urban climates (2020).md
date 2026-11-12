ScienceoftheTotalEnvironment749(2020)141392
ContentslistsavailableatScienceDirect
Science of the Total Environment
journal homepage: www.elsevier.com/locate/scitotenv
Validation of seasonal mean radiant temperature simulations in hot arid
urban climates
PeterJ.Cranka,f,ArianeMiddelb,c,f,⁎ ,MelissaWagnerd,DaniHootsa,MartinSmithe,AnthonyBrazela,f
aSchoolofGeographicalSciencesandUrbanPlanning,ArizonaStateUniversity,UnitedStatesofAmerica
bSchoolofArts,Media,andEngineering,ArizonaStateUniversity,UnitedStatesofAmerica
cSchoolforComputing,Informatics,andDecisionSystemsEngineering,ArizonaStateUniversity,UnitedStatesofAmerica
dCooperativeInstituteforMesoscaleMeteorologicalStudies,theUniversityofOklahoma,UnitedStatesofAmerica
eSchoolofArchitecture,UniversityofMinnesota,UnitedStatesofAmerica
fUrbanClimateResearchCenter,ArizonaStateUniversity,UnitedStatesofAmerica
H I G H L I G H T S G R A P H I C A L A B S T R A C T
• RayManandENVI-metfailtoaccurately
modelT underextremeheat.
MRT
• SeasonalT errorsexceedsuggested
MRT
accuracyof±5°Cforheatstressstudies.
• ModelsshowseasonalswinginRMSE
withincreasederrorsunderhighsolar
radiation.
• RayManstruggledmostwithengineered
enclosed spaces and complex urban
forms.
• ENVI-metstruggledwithengineered
shade and did not resolve spatial
variability.
a r t i c l e i n f o a b s t r a c t
Articlehistory: WevalidatedseasonalRayManandENVI-metmeanradianttemperature(T )simulationstoassessmodelper-
MRT
Received23June2020 formanceinasensitivityanalysisfromcoldtoextremelyhotconditions.Human-biometeorologicalvalidation
Receivedinrevisedform8July2020 datawerecollectedinTempe,Arizonaviatransectsduringfivefieldcampaignsbetween2014and2017.Tran-
Accepted29July2020
sectswereconductedacrosssevenlocationsintwotothree-hourintervalsfrom6:00to23:00LSTwithaKestrel
Availableonline1August2020 meterandthermalcamera(2014–2015)andthemobileinstrumentplatformMaRTy(2017).Observationsacross
diverseurbanforms,skyviewfactors,andseasonscoveredawiderangeofsolarradiationregimesfromamin-
Editor:SCOTTSHERIDAN
imumT of8.7°Ctoamaximumof84.9°C.Bothmodelsproducedlargesimulationerrorsacrossregimeswith
MRT
Keywords: RMSErangingfrom8°Cto12°C(RayMan)and11.2°Cto16.1°C(ENVI-met),exceedingasuggestedT MRT accu-
Meanradianttemperaturemodelvalidation racyof±5°Cforheatstressstudies.RayManmodelerrorswerelargestforengineeredenclosedspaces,complex
Seasonalsensitivityanalysis urbanforms,andextremeheatconditions.ENVI-metwasunabletoresolveintra-domainspatialvariabilityof
Hoturbanenvironments T andexhibitedlargeerrorswithRMSEupto25.5°Cforengineeredshade.Bothmodelsfailedtoaccurately
MRT
ENVI-met simulate T for hot conditions. Errors varied seasonally with overestimated T in the summer and
MRT MRT
RayMan underestimatedT inthewinterandshoulderseasons.Resultsdemonstratethatmodelsshouldnotbeused
MRT
undermicrometeorologicalormorphologicalextremeswithoutin-situvalidationtoquantifyerrorsandassess
directionalbiasduetomodellimitations.
©2020TheAuthors.PublishedbyElsevierB.V.ThisisanopenaccessarticleundertheCCBY-NC-NDlicense(http://
creativecommons.org/licenses/by-nc-nd/4.0/).
⁎ Correspondingauthorat:SchoolofArts,MediaandEngineering,SchoolofComputing,Informatics,andDecisionSystemsEngineering,ArizonaStateUniversity,950S.ForestMall,
StaufferB,Tempe,AZ,85281,UnitedStatesofAmerica.
E-mailaddress:ariane.middel@asu.edu(A.Middel).
https://doi.org/10.1016/j.scitotenv.2020.141392
0048-9697/©2020TheAuthors.PublishedbyElsevierB.V.ThisisanopenaccessarticleundertheCCBY-NC-NDlicense(http://creativecommons.org/licenses/by-nc-nd/4.0/).

2 P.J.Cranketal./ScienceoftheTotalEnvironment749(2020)141392
1.Introduction 2.Methods
Whiletheworldcontinuestourbanizewithaprojected68%of 2.1.Studyarea
thepopulationlivingincitiesby2050(UN,2019),ananticipatedin-
creaseinthelength,frequency,andintensityofextremeheatevents ThisstudywasconductedinTempe(33°25′28.6″N,111°56′18.6″W),a
threatensthehealthandlivelihoodofurbanpopulations(Jonesetal., cityintheEastValleyofthePhoenixmetropolitanareainMaricopa
2015).Thecombinedeffectsofurbanizationandglobal-scalecli- county, Arizona, USA (Fig. 1). Located in the Sonoran Desert of the
maticchangeonlocalandmicroscaleurbanclimatewilllikelylead AmericanSouthwest,the192,000Temperesidentsexperienceasubtrop-
toincreasedhumanexposuretoheat,drivingthermaldiscomfort icalaridclimate(KöppenClimateClassificationsubtypeBwh,tropicaland
andraisingtheriskofheat-relatedillnessandmortality,especially subtropicaldesertclimate)withdaytimemaximumT exceeding40°C
a
forvulnerablepopulations. formostofJune,July,andAugust(periodofrecord:1953–2013).While
Intheadventofawarmingworld,agrowingbodyofliteraturehas maximumsummerT canpeakcloseto50°C,overnightlowsoftenare
a
investigatedtheimpactofextremeheatonurbanpopulationsusinga between 27 °C and 29 °C (Western Regional Climate Center, 2020).
varietyofthermalmetrics,fromairtemperature(T)andsurfacetem- Mean annual rainfall is relatively low (219 mm, period of record:
a
perature(T)toradianttemperatureandcomplexindicesthatcombine 1953–2013) with 40% of the annual total occurring in the summer
s
severalatmosphericvariables.Underhot,dryconditions,humanther- monthsduetotheNorthAmericanMonsoon.
mal exposure is mainly driven by the radiative environment (Lee MostoftheCityofTempecanbeclassifiedasopenlow-riseLocalCli-
etal.,2013;Mayeretal.,2008),andmeanradianttemperature(T ) mateZone(StewartandOke,2012)withdetachedone-totwo-story
MRT
hasemergedasthemostimportantatmosphericvariableforoutdoor single-family homes and lower density development patterns. The
thermalcomfort(ChenandNg,2012;Johanssonetal.,2014;Middel studyareainDowntownTempeisdenserwiththree-tofour-storyof-
etal.,2016).T isasyntheticparameterthatintegratesshort-and ficeandcommercialbuildings(Fig.1)andmixed-use,high-riseapart-
MRT
longwaveradiationfluxdensitiesahumanbodyisexposedtointoasin- ments currently under construction, transitioning from an open
glevalue(ISO,1998).Thisparameteristhebasisformanyhuman- midrisetoopenhigh-risezone.TheMillAvenueDistrictisashopping
biometeorologicalindices,suchasPhysiologicallyEquivalentTempera- andentertainmentareanorthofArizonaStateUniversity'sTempecam-
turePET(MayerandHöppe,1987)andtheUniversalThermalComfort pus.Streetscapesarelinedwithstores,restaurants,andbusinesses;
IndexUTCI(Brödeetal.,2012). sidewalksarecanopiedwithstreettrees;andnarrowpedestriancorri-
Numerousmodelshavebeendevelopedtosimulatethermalcondi- dorsconnectsmallcourtyardsandplazas.Incontrast,theMillAvenue
tionsinoutdoorspacesatpeople-relevantscales–fromneighborhoods Districtisborderedbyanarterialtothesouth(UniversityDrive)anda
toindividualfeatures(e.g.,trees).Modelsmainlydifferintheirspatial collector road to the west (Ash Avenue) with low-rise buildings,
extent(singlelocationvs.2Dor3Dgrid),spatialandtemporalresolu- parkinglots,andlittleshade.
tion,computationalintensity,inputrequirements,thetypeofoutput Buildingonhuman-biometeorologicalobservationsfromaprevious
heatmetrics(e.g.,T,T ,thermalcomfortindices),andcalculationof study on outdoor thermal comfort in Tempe's Mill Avenue district
a MRT
atmosphericconditions(empiricalvs.physics-based).Modelshave (Creweetal.,2016),sevensiteswerechosenforcontinuedseasonalmon-
beenappliedtoassessthermalimpactsofurbanformanddesignsce- itoringtovalidateT simulationsinthearea(Fig.1).Thesitesprovidea
MRT
narios(Emmanueletal.,2007;Herisetal.,2020;Middeletal.,2014; goodtradeoffbetweenlimitedtransectwalkingdistanceandmaximum
YahiaandJohansson,2013),theeffectivenessofheatmitigationstrate- spatialcoveragetovalidatemodeledintra-neighborhoodT distribu-
MRT
giessuchasincreasedtreecanopycoverandcoolroofs(Aminipouri tion.ThelocationscoverarangeofSkyViewFactors(amountofvisible
etal.,2019a,2019b;Cranketal.,2018;Middeletal.,2015;Zölchetal., skyintheupperhemisphere),varyingamountsofvegetation,anddiffer-
2016), human outdoor thermal comfort (Lee et al., 2016; Lin and entcanyonorientations(Table1).
Matzarakis,2008;Morakinyoetal.,2017),andtherelationshipbetween
heatandmortality(Thorssonetal.,2014). 2.2.Fieldobservations
RayMan(Matzarakisetal.,2010)andENVI-met(BruseandFleer,
1998)havemostfrequentlybeenusedtoassessthermalconditionsin Weconductedfiveclear-skyfieldcampaignstocollectseasonal
complexurbanenvironmentsatthemicroscale.AScopussearchin human-biometeorologicaldatainthestudyareaformodelvalidation:
June2020forthepast20yearsyielded87RayManand423ENVI-met on October 24, 2014 (fall), February 15, 2015 (winter), March 23,
studies.WhileRayManwasspecificallydesignedtomodelradiation 2015(spring),June20,2015(summer),andJune21,2017(summer).
fluxdensitiesandT forsinglepointsinspace,ENVI-metisanumer- Duringthefirstfourcampaigns(2014–2015),weusedaKestrel4400
MRT
ical model that simulates a full suite of atmospheric variables in a heatstresstrackertocollectT ,relativehumidity(RH),windspeed
a
griddeddomain.Bothmodelsweredevelopedinatemperateclimate ( ),andglobetemperature(T)at1.1-mheight–thecenterofgravity
v g
(Germany),buthavebeenemployedinawidearrayofurbanandcli- ofastandinghuman(ISO,1998)–ontransectsacrossallsites(Supp.
maticcontexts.Althoughthesemodelshavepreviouslybeenusedin Fig.1a).Observationswereperformedinthree-hourintervalsfrom
hot,aridenvironments(e.g.,ChowandBrazel,2012;Hedquistand 06:00to21:00andagainat23:00LocalStandardTime(LST).Each
Brazel,2014;Mahmoud,2011),theirabilitytoaccuratelysimulateday- human-biometeorological transect took an hour to complete, with
timeT inthoseregionshasnotbeenassessedsystematicallybysea- seven-minstopsateverysitetoaccountfortheglobethermometer's
MRT
son.Additionally,withrecenttrendsinurbanclimatescholarshipto slowresponsetime(Middeletal.,2016).Duringthesummerandwin-
investigatehumanthermalexposureunderextremeheat,theneed terfieldcampaigns,T wascollectedateachsiteusingaFLIRi3thermal
s
emergestoevaluateifthemodelsproduceaccurateresultsforextreme imaginginfraredcamerafacinginallcardinaldirectionsanddown-
conditions. wards(Supp.Fig.1b).Eachsitewasdocumentedthroughhemispherical
Recognizing the impact future urbanization and climate will 180°photostakenat1.1mheightwithaCanonEOS6DandCanonEF
have on human vulnerability to extreme conditions, the goal of 8–15-mmf/4FisheyeUSMUltra-WideZoomlens.
thisstudyistovalidateseasonalRayManandENVI-metT simula- Withtheavailabilityofnewequipment,wecompletedanadditional
MRT
tionsforheterogeneousurbanformsusingin-situobservationsin fieldworkcampaignonJune21,2017usingaKestrel4400heatstress
Tempe,Arizona.Modelperformanceisassessedinasensitivityanal- trackerandthemobilesensorplatformMaRTy(Middeletal.,2020;
ysisfromcoldtoextremelyhotconditionsacrossawiderangeof Middel and Krayenhoff, 2019). MaRTy observes georeferenced 6-
solarradiationregimestodetermine:AreRayManandENVI-met directionallongwave(L)andshortwave(K)radiationfluxdensities
heat-ready? withthreeHukseflux4-ComponentNetRadiometers,T ,T,v,andRH
a s

P.J.Cranketal./ScienceoftheTotalEnvironment749(2020)141392 3
Fig.1.AerialviewofstudyareainDowntownTempe,Arizona,USAwithhemisphericalfisheyeviewsforeachstopalongahuman-biometeorologicaltransect,correspondingphotos,and
thermalimages(October24,2014,15:00LocalStandardTime).
Table1
Fieldcampaignsitecharacteristics:albedoofgroundsurface,surroundingvegetationfraction,SkyViewFactor(SVF),canyonorientation,andsitedescription.SVFwascalculatedfrom
fisheyephotos(Middeletal.,2018);surroundingvegetationfractiononaspherewascalculatedfromimagecubes(Middeletal.,2019).ForcorrespondingfisheyephotosseeSupp.Fig.2.
Site Albedo Vegetation Skyviewfactor Canyon Sitedescription
fraction(%) orientation
AshAvenue 0.13 5 0.948 N-S ExposedN-Sstreetlinedbyscatteredtrees;siteonbrickwestsidewalk
Arcade 0.12 9 0.050 E-W Bricksidewalkcoveredbybrickoverhang-columnedarcadestructureonNsideofE-Wstreet
Breezeway 0.22 39 0.436(spring, E-W E-WwalkthroughfromsmallplazatotheeasttomainN-Sstreettothewest;buildingstonorthand
summer,fall) southofwalkthrough;coloredbricksurface;seasonaldeciduousarbortreecanopyoverwalkthrough
0.123(winter)
Tunnel 0.14 3 0.030 E-W E-WwalkthroughfrommainN-Sstreettoopenplaza;buildingtunnel
Overhang 0.12 11 0.213 E-W ThinmetalshadeoverhangstructureoverbricksidewalkonNsideofE-Wstreet
MillAvenue 0.15 18 0.190 N-S WestsidewalkofMillAvenuewithlargetreecanopyyear-roundforshade
UniversityDr 0.23 17 0.783 N-Wcorner OpenNWstreetcornerbrick/cementconcretesidewalkwithbuildingstoNandW

| 4   |     |     | P.J.Cranketal./ScienceoftheTotalEnvironment749(2020)141392 |     |     |     |     |     |     |
| --- | --- | --- | ---------------------------------------------------------- | --- | --- | --- | --- | --- | --- |
in2-sintervalsatpedestrianheight(Supp.Fig.1c,Table2).Human- FLIR-derivedT;2a)MaRTyT ,v,andRH;2b)MaRTyT ,v,RH,andT
|     |     |     |     |     |     | s   | a   | a   | s   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
biometeorologicaltransectswereperformed everytwohoursfrom fromthedownwardfacingpyrgeometer.
8:00to14:00LST,at17:00LST,andaftersunsetat20:00LST,following
thesametraverseprotocolasinpreviouscampaigns.
2.5.ENVI-metsimulations
2.3.Dataprocessing
ENVI-met(BruseandFleer,1998)isanon-hydrostaticComputa-
tionalFluidDynamics(CFD)modelusedtosimulatemicroscaleinterac-
AllT observationswerelinearlytime-detrendedtothefullhour
| a                                          |     |     |     |                     | tionsbetweensurfaces,vegetation,andtheatmosphereintheurban |     |     |     |     |
| ------------------------------------------ | --- | --- | --- | ------------------- | ---------------------------------------------------------- | --- | --- | --- | --- |
| usingSkyHarborairportdata.KestrelobservedT |     |     |     | [°C]wasconverted    |                                                            |     |     |     |     |
|                                            |     |     |     | g                   | canopylayer.WeusedENVI-metScienceversion4.3releasedinthe   |     |     |     |     |
| toT [°C]usingtheon-sitemeasurementsofT     |     |     |     | [ °C]andv[ms−1],as- |                                                            |     |     |     |     |
MRT a winterof2017/2018tomodelhuman-biometeorologicalconditionsin
sumingaglobeemissivityεof0.95andanadjustedglobediameterDof
theMillAvenueDistrictforthefivefieldcampaigndaysandtestthe
150mm(ISO,1998;Thorssonetal.,2007):
|     |     |     |     |     | model'sabilitytosimulateT |     | acrossspace,timesofday,andseasons. |     |     |
| --- | --- | --- | --- | --- | ------------------------- | --- | ---------------------------------- | --- | --- |
MRT
| "   |     |     |     | #   | Theinputdomainsizewas190×195×25gridcellswith20nesting |     |     |     |     |
| --- | --- | --- | --- | --- | ----------------------------------------------------- | --- | --- | --- | --- |
(cid:1) (cid:3) 1:1(cid:2)108v0:6(cid:1) (cid:3) 1=4 grids(Supp.Fig.3)atagridcellsizeofΔx=Δy=Δz=4mand20%
| ¼     | þ273:15 | 4þ  | −T    | −273:15 | ð1Þ |     |     |     |     |
| ----- | ------- | --- | ----- | ------- | --- | --- | --- | --- | --- |
| T MRT | T g     |     | T g a |         |     |     |     |     |     |
εD0:4 telescopingafterz=40m.Thedomainwasdesignedlargerthanthe
studyareatominimizeedgeeffects.Buildingwallmaterialswereset
tomoderateinsulation(buildingplanfraction22.6%),andplantswere
T wasextractedfromthethermalimagesusingtheFLIRToolsIR
s amixofevergreen,deciduous,andpalmtreeswithlittlegrass(vegeta-
software,andanarealaverageT s wascalculatedforeachsiteandhour tionplanareafraction9.1%).Soilconditionsmatchedvaluesreportedby
(Häbetal.,2014).MaRTyobservationswerecleaned,i.e.thefirstminute
Middeletal.(2014).WeranENVI-metfora24-hourperiodstartingat
ofeachtransectstopwasdiscardedtoaccountforsensorlag(Häbetal., 03:00LSTwithaconstanttimestepof(2s)andmodeloutputevery
2015),andtheremainingtransectobservationsateachsitewereaver- 60min.ThemodelwasforcedwithhourlyT,RH,andall-dayprevailing
a
aged.T wascalculatedfromrecorded6-directionalradiationflux windspeedanddirection(fixed)fromthen earbySkyHarborInterna-
| MRT | [Wm−2]using |     |     |     |     |     |     |     |     |
| --- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
densitiesK andL absorption coefficients a =0.07 tionalAirport(ENVI-met“simpleforcing”,standardTKEmodel)(Fig.2).
|                 | i i                                         |     |     | k   |     |     |     |     |     |
| --------------- | ------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
| (shortwave)anda | =0.97(longwave),theStefan-Boltzmannconstant |     |     |     |     |     |     |     |     |
l
| σ,andweightingfactorsW |     | =0.06(up/down)andW |     | =0.22(cardinal |     |     |     |     |     |
| ---------------------- | --- | ------------------ | --- | -------------- | --- | --- | --- | --- | --- |
|                        |     | i                  |     | i              |     |     |     |     |     |
directions)forastandingperson(Höppe,1992;ISO,1998): 2.6.Modelvalidation
(cid:4) (cid:5) ToquantifythemodelaccuracyofRayManinsimulatingT ,wefit
|     | W ða K | þa L Þ 1 4−273:15 |     |     |     |     |     | M R T |     |
| --- | ------ | ----------------- | --- | --- | --- | --- | --- | ----- | --- |
T ¼ ∑6 i k i l i ð2Þ li n e a r r e gr e s si o n m od e ls t o th e o b se r v e d fi el d w o r kd at a an d r e p o r t th e
| MRT | i¼1 a | σ   |     |     |     |     |     |     |     |
| --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
l c o e f fi c ie n t o f d e te rm in a ti o n (R 2 ) to i n v e st ig a te h o w m u ch v ar i a n c e c an
beexplainedintheobserved(O)databythemodel-predicted(P)data.
Furthertestingthereliabilityofresults,wereportfiveperformancesta-
tistics:themeanbiaserror(MBE),rootmeansquareerror(RMSE),its
2.4.RayMansimulations
|     |     |     |     |     | systematicandunsystematiccomponentsRMSE |     | andRMSE | ,meanab- |     |
| --- | --- | --- | --- | --- | --------------------------------------- | --- | ------- | -------- | --- |
s u
TheRayManmodelcalculateslongwaveandshortwaveradiation soluteerror(MAE),andWilmott'sindexofagreement(d)(Willmott,
fluxdensities,T
MRT ,SVF,sunduration,andthermalcomfortindicesfor 1981).Theindexofagreement(d)evaluatestheerrorbetweenob-
asinglelocationbasedonmeteorologicalinputsandhemispherical servedandmodeleddataasastandardizedmeasurebetween0and1
photos(Matzarakisetal.,2007,2010).Ataminimum,RayManrequires (avalueof1indicatesperfectagreement):
T,v,vaporpressureorRH,cloudcover,latitudeandlongitude,timeof
a
day,anddayofyeartoestimateT fromafisheyephotothatcaptures " #
|     |     | M R T |     |     |     | ∑N Þ2 |     |     |     |
| --- | --- | ----- | --- | --- | --- | ----- | --- | --- | --- |
thesurrounding3Durbanenviro n m entin2D.Optionalinputparame- i¼(cid:1)1 ðP −O
|     |     |     |     |     | d¼1− | i i (cid:3) |     |     |     |
| --- | --- | --- | --- | --- | ---- | ----------- | --- | --- | --- |
tersincludetheaveragealbedo(α)andT ofsurroundingsurfaces,the ∑N jP0 j−jO 0 j 2
|     |     |     | s   |     |     | i¼1 i i |     |     |     |
| --- | --- | --- | --- | --- | --- | ------- | --- | --- | --- |
Bowenratio(ß),andglobalradiation(G).Additionally,theusercan
specifypersonalcharacteristics(height,weight,age,gender),clothing,
andactivitytotailorthermalcomfortoutputstoaspecificdemographic. whereP0 ¼P−O,O0 ¼O−O,andNisthenumberofcases.
|     |     |     |     |     | i   | i i | i   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Weran70RayManPro2.1simulationsusingthefisheyephotoscol- ToassesstheperformanceofENVI-met,wefirstevaluatethemodel's
lectedon-site.Foreachoftheseventransectstops,wesimulatedtwo abilitytosimulateT,whichisgovernedbytheurbancanopylayertur-
a
stagesofmeteorologicalforcingfromtheseasonalfieldcampaigndata bulenttransport,beforeevaluatingsimulatedT usingthesameper-
MRT
(Supp.Table1):1a)KestrelT ,v,andRH;1b)KestrelT ,v,RH,and formancestatistics.
|     |     | a   |     | a   |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Table2
Summaryofsensorspecificationsandaccuracies.
| Sensor |     |     |     | Variable |     | Range |     | Accuracy |     |
| ------ | --- | --- | --- | -------- | --- | ----- | --- | -------- | --- |
Kestrel4400heatstresstracker Airtemperature −10.0to55.0°C 0.5°C
−10.0to55.0°C
|        |     |     |     | Globetemperature   |     |               |     | 1.4°C   |     |
| ------ | --- | --- | --- | ------------------ | --- | ------------- | --- | ------- | --- |
|        |     |     |     | Windspeed          |     | 0.6to40.0ms−1 |     | 0.2ms−1 |     |
|        |     |     |     | Relativehumidity   |     | 0to100%       |     | 3.00%   |     |
| FLIRi3 |     |     |     | Surfacetemperature |     | −20to250°C    |     | ±2°C    |     |
−50to100°C
| HC2S3RotronicHygroClip2 |     |     |     | Airtemperature   |     |           |     | ±0.1°C     |     |
| ----------------------- | --- | --- | --- | ---------------- | --- | --------- | --- | ---------- | --- |
| T/RHProbe               |     |     |     | Relativehumidity |     | 0to100%   |     | ±0.8RH     |     |
| Gill2DWindSonic         |     |     |     | Windspeed        |     | 0to60ms−1 |     | ±2%@12ms−1 |     |
−90to90°
| GPS16XGarminGPS |     |     |     | Lat/Lon |     |     |     | <3m |     |
| --------------- | --- | --- | --- | ------- | --- | --- | --- | --- | --- |
−180to180°
3Hukseflux4-componentnetradiometers SWradiation 285to3000×10−9m ±10%
4.5to40×10−6m
|     |     |     |     | LWradiation |     |     |     | ±10% |     |
| --- | --- | --- | --- | ----------- | --- | --- | --- | ---- | --- |

P.J.Cranketal./ScienceoftheTotalEnvironment749(2020)141392 5
Fig.2.SummaryofforcingdataandparametersfromSkyHarborInternationalAirportforseasonalENVI-metsimulations:a)hourlyairtemperature;b)hourlyrelativehumidity;tables
withpredominantwindspeed/directionfromSkyHarborInternationalAirportandothersimulationparameters.
3.Results 3.2.RayManvalidation
3.1.Seasonalhuman-biometeorologicalfieldobservations ToexamineourRayMansimulations,weusedmultipleerrormetrics
toassessthevalidityofthemode.Forallseasons,timesofday,andcom-
T variessignificantlybetweenlocationsthroughoutthedayforall binedreceptors(N=238),RMSEis10.7°CwithMBE=−0.5°Cand
MRT
seasons(Fig.3).Variabilityismainlydrivenbytheavailabilityorab- d=0.88.Acrossallsites,timesofday,andseasons(N=49),RayMan
senceofshade,whichmodulatesthecontributionsofincomingshort- simulated T exhibits an RMSE of 8.0° to 12.4 °C (Fig. 4, Supp.
MRT
waveradiationtoT .Openlocations(AshAvenueandUniversity Table2).Theerrorremainshighirrespectiveoftheinstrumentation
MRT
Drive)exhibitconsistentlyhigherT thanT exceptintheearlymorn- usedforin-situobservations(Kestrelvs.MaRTy).MBEispositivein
MRT a
inghours.Differencesaremostpronouncedat12:00LSTinthesummer thesummerbutnegativeforwinterandshoulderseasons,i.e.RayMan
(23.5°C–43.3°C)andat9:00LSTinthewinter(36.2°C–40.7°C)and overestimatesT inthesummerandunderestimatesT otherwise.
MRT MRT
shoulderseasons(18.8°C–50.7°C).Incontrast,thetunnellocationisex- AddingT asaforcingparameteryieldssimilarperformancemetrics
s
posedtominimaldiurnalincomingshortwaveradiationthatpeaksat overallwithRMSErangingfrom9.1–14.1°C(Supp.Table3).Theunsys-
lowsunangles.WhileT observedinthemorningissubjecttolateral tematicerrorisalwayslargerthanthesystematicerror,whichreflects
MRT
shortwaveradiationinwinterandspring,T isclosetoT intheafter- theheterogeneityofthesitesin termsofurbanfabric andhorizon
MRT a
noon all year round when the enclosing building blocks the sun limitations.
completely.Inthesummer,T isslightlybelowT formostpartsof RayMan performs best for the open site Ash Avenue (SVF =
MRT a
theday(0.6°C–8.1°Clower).Thetwoeast-westlocations(Overhang 0.948)withanindexofagreementof0.98inthefalland0.90–0.99
andArcade)aresun-exposedfromlatemorningintotheafternoondur- in the summer, but yields an RMSE of 16.2 °C in the winter and
ingfall(maxT =76.5°C),winter(maxT =43.6°C),andspring 16.7 °C in the spring despite an acceptable index of agreement
MRT MRT
(maxT =66.0°C),becausetheyareonthesidewalktothenorthand (d = 0.94 and 0.93, respectively). RayMan underestimates T
MRT MRT
notshadedbytallbuildingstothesouth.Inthesummer,theArcadepro- consistently for open sites independent of season with negative
videsshadealldayduetothehighsunelevation(maxT =66.0°C), MBEvaluesbetween−7.4°C(June2017)and−14.9°C(February
MRT
whiletheoverhangsiteissun-exposed,becausetheoverhangisonthe 2015).Consequently,thesystematicerrorforopensitesishigher
southsideofthebuilding.TheNorth-Southstreetcanyonsite(MillAv- thantheunsystematicerror.
enue),whichreceivesreduceddirectshortwaveradiationinthemorn- Thetunnelrevealsaseasonalinfluenceonsimulationperfor-
ingbecauseofatreetotheeast,isbrieflysun-exposedaroundnoon,and mance;RMSEislowestinthewinter(4.9°C),increaseswithhigher
fullyshadedbyabuildingfortherestoftheday.T peaksat46.1°Cin T ,andpeaksinJune2017with16.2°C.MBEispositiveforallsea-
MRT a
thespring,61.4°Cinthesummer,50.6°Cinthefall,and32.0°Cinthe sons,i.e.RayManconsistentlyoverpredictsT inthetunnel,and
MRT
winter.ThevegetatedbreezewayexhibitsarandomT pattern.A MBEmirrorstheRMSEtrendwiththelowestvalueinthewinter
MRT
buildingandadeciduoustreetothesouthprovideshademostofthe (1.0°C),anincreaseduringshoulderseasons(2.7°Cand7.7°C),
day,butthesiteisoccasionallyhitbydirectsunlight,penetratingthe andamaximumerrorof14.1°Cinthesummer.Resultsareimproved
canopy. withT asanadditionalforcingparameter,butstillyielderrorsover
s
Comparingobservationsacrosssummerfieldworkcampaigns,T 10.0°CforJune2017.Theindexofagreementshowsnosignificant
MRT
attheUniversityDrivesiteat12:00LSTonJune20,2015is17°Chigher agreementbetweenpredictedandobservedsummervaluesforthe
thanonJune21,2017despitesimilarsunelevationanglesanddiurnal tunnel(d=0.51inJune2015,d=0.12inJune2017).Thesefindings
T profiles(maxTa=44.1°Cvs.47.4°C).Thisisattributedtothediffer- suggestthatRayManisnotabletoaccuratelysimulateengineered
a
enceinsensorsetupandwindconditions(seeDiscussion). enclosedoutdoorspaces.

6 P.J.Cranketal./ScienceoftheTotalEnvironment749(2020)141392
Fig.3.Meanradianttemperature[°C]observationsforeachstudysiteandhourlytransectbyseason(a–e)comparedtoPhoenixSkyHarborairtemperature[°C];correspondingfisheye
viewsandskyviewfactors.
The north-south oriented Mill Avenue and east-west oriented thanthesystematicerrorinthewinterandshoulderseasonsbyup
Breezewaysitesareurbancanyonswithtreecanopycover.TheBreeze- to5.4°C;thesummerexhibitssimilarunsystematicandsystematic
wayisthemostcomplexlocationobservedinthisstudywithsignificant errors(RMSEuandRMSEsbetween3.9°Cand4.8°C).ForcingT
s
horizonlimitationchangesinthewinterduetoadeciduoustreetothe slightlyimprovestheresults.
south.RayManresultsaremixed,withthebestperformanceforMillAv- Observationsontheeast-westorientedsidewalkshadedbyanar-
enue(RMSE=4.3°C,d=0.96)andtheworstperformanceforthe cadefurtherconfirmtheseasonalperformanceofRayMan.RMSEis
Breezeway(RMSE=13.6°C,d=0.39)inthespring.Forallothersea- lowerinthecoldseason(5.8°C)andincreaseswithhigherT (14.3°C
a
sons,RMSEresultsaresimilartotheoverallmodelperformance(7.7°C inJune2017).Thesystematicerrorfollowsthesametrendandbecomes
to12.4°C),buttheindexofagreementisgenerallylow(0.47–0.73).The largerasT rises(RMSEs=3.9°CinFebruary2015,RMSEs=13.15°C
a
Breezewaydisplaysahighunsystematicerrorforthewinter(RMSEu= inJune2017)whiletheindexofagreementdropsfrom0.94to0.79
10.58,RMSEs=2.85)duetothedeciduoustrees.Whilethesiteis (June2015)and0.33(June2017).Observationsunderthesheltered
shadedbyadefinablevegetationcanopyinthesummer,thehorizon walkwayconfirmRayMan'ssignificantperformancedropinsimulating
islimitedbytreebranchesinthewinterthatcreatearandompattern T forengineeredenclosedspaceswithincreasingT alreadyobserved
MRT a
ofsunexposureandshadethroughouttheday.Consistentwithother forthetunnel.
locations,MBEispositiveandlargeinthesummer(5.6°Cto8.2°C)in-
dicatinganoverpredictionofT . 3.3.ENVI-metvalidation
MRT
Theeast-westoverhangissimulatedreasonablywellforallsea-
sons,withtheindexofagreementrangingfromd=0.84inthe BeforeevaluatingENVI-met'sseasonalT outputforthestudy
MRT
wintertod=0.93inthesummer.Theunsystematicerrorislarger area,wevalidatesimulated1.2-mT toassessthemodel'sabilityto
a

P.J.Cranketal./ScienceoftheTotalEnvironment749(2020)141392 7
Fig.4.Meanradianttemperature[°C]statisticsforseasonalRayMansimulations:a)MeanBiasError(MBE);b)RootMeanSquareErrorRMSEasbarsandIndexofAgreement(d)aspoints;
c)UnsystematicRootMeanSquareError(RMSEu)andSystematicRootMeanSquareError(RMSEs).
representphysicalprocessesintheurbancanopylayer.Sevenrecep- hotseason(from11.5°CinFebruary2015to16.1°CinJune2017)
tors/observationpoints(AshAvenue;UniversityDrive;Overhang;Mill withnegativeMBEinthewinterandshoulderseasons(−2.4°Cto
Avenue;Arcade;Breezeway;Tunnel)inthedomainallowforaspatially −0.3°C)andpositiveMBEinthesummer(6.6°Cto12.0°C)(Fig.5c/
andtemporallyexplicitevaluation(Fig.5a/b,Supp.Table4). d,Fig.6,Supp.Table5).Theoverallindexofagreementissatisfactory
Acrossallseasons,timesofday,andreceptors(N=238),RMSEis forallseasonsbutdecreasesslightlyinthesummer(fromd=0.87in
2.1°CwithMBE=−0.5°Candd=0.99.ENVI-metperformsbestfor February2015tod=0.73inJune2017).Site-specificRMSEishigher
June(RMSEis1.6°Cin2015and1.6°Cin2017)andworstforFebruary in June 2017 than 2015 for most locations. At open, unobstructed
(RMSE is 2.7 °C) with a larger systematic than unsystematic error sites,RMSEisworsethanexpectedwithalargeunsystematicerror,es-
(RMSEu=1.3°C,RMSEs=2.4°C).ThemodeloverpredictsT inthe peciallyatUniversityAvenueinthewinter(RMSE=15.3°C,RMSEu=
a
summer(MBE=0.9°C),butunderpredictsinmilderseasons(MBE 13.2°C)andAshAvenueinthespring(RMSE=18.6°C,RMSEu=
rangesbetween−0.9°Cinthefalland−1.8°Cinthespring). 18.5°C).March2015modeloutputcomparedwithobservations
Theseasonalindexofagreementisgoodtoexcellent(0.84to1.00) showvariableperformancewithinconsistentresultsacrosssites.
foralllocations,butRMSEvarieswidelyacrosssites.Thegreatesterrors WhileRMSEis<10.0°CforMillAvenue(N-Sstreetcanyon),the
areobservedinthewinter,withRMSErangingfrom1.7°C(Breezeway) tunnel,andUniversityAvenue(open),RMSEpeaksat14.5°Cto
to4.2°C(AshAvenue)andlargesystematicerrorsofupto3.8°C(Ash 18.6°Cfortheothersites.Acrossseasons,thereisnodetectable
Avenue). The smallest errors occur in June 2017 at the Breezeway patternthatshowsoneormoresitesconsistentlyoutperforming
(RMSE=0.8°C)andUniversityAvenue(RMSE=1.0°C). others.
WhiletheerrorsareoutsidetheT sensoraccuraciesof0.5°C InJune2017,allsitesthatareenclosedbyengineeredshade(Tunnel,
a
(Kestrelmeter)and0.1°C(MaRTy),theyarewithintherangeof Overhang,Arcade)exhibitlargeerrorswithRMSEupto25.5°C,RMSEs
previously reported performance statistics for ENVI-met. Larger upto22.7°C,andcorrespondinghighpositiveMBE(12.4°Cto20.4°C),
errorvariabilitiesforindividuallocations,whileoptimizingoverall indicatingthatENVI-metheavilyoverpredictsT anddoesnotresolve
MRT
fit,suggestthatENVI-metdoesnotaccuratelymodelintra-domain thesolarregimecorrectlyatthoselocations.TheTunnelandArcadedo
T distributioninheterogeneousenvironments,whichisprobably notyieldasignificantagreementwithobservedT asevidencedby
a MRT
related to the static diurnal wind profile of the “simple forcing” lowindexofagreementvaluesof0.13and0.22,respectively.Addition-
setting. ally,R2is0.001fortheTunnel,furtherunderliningENVI-met'sinability
SimilartoRayMan,ENVI-metexhibitsseasonalperformancetrends tomodelradiationfluxdensitiesforenclosedlocationsunderextreme
insimulatingT .Foralllocationscombined,RMSEincreasesinthe heatconditions.
MRT

8 P.J.Cranketal./ScienceoftheTotalEnvironment749(2020)141392
Fig.5.ENVI-metsimulated1.2-mairtemperatureat15:00hLSTfor(a)June21,2017;(b)February18,2015;ENVI-metsimulated1.2-mmeanradianttemperaturefor(c)June21,2017;
(d)February18,2015.
4.Discussion T wasobservedusingtwoinstrumentsetups,i.e.aKestrelmeter
MRT
(2014,2015)andthe6-directionalmethodwithMaRTy(2017).Hourly
4.1.Seasonalhuman-biometeorologicalfieldobservations T forJune20,2015isslightlyhigherthanJune21,2017despitesim-
MRT
ilarsunelevationanglesanddiurnalT profiles.Thesedifferencescanbe
a
ObservedT variessignificantlybyseason,timeofday,andloca- attributedtowindconditionsandsensoraccuracies.WhiletheKestrel
MRT
tion,fromaminimumof8.7°C(Breezeway,February19,2015,6:00 metershaveafasterresponsetimethanstandard150-mmglobether-
LST) to a maximum of 84.9 °C (University Drive, June 2015, 12:00 mometersandallowforstop-and-gotransects,theyaremoresensitive
LST).SpatialandtemporalT variationissignificantlydrivenbyshort- towindspeedduetoconvectiveexchangewithT andleadtoanover-
MRT a
waveradiation(Leeetal.,2014;MiddelandKrayenhoff,2019).Thedif- estimationofT whenwindspeediselevated(Teitelbaumetal.,
MRT
ferencesbetweenT andT aremostpronouncedat12:00LSTinthe 2020).ItisalsoexpectedthatT estimatedfromKestrelmeterread-
MRT a MRT
summerand9:00LSTinthewinter.Whilemanystudieshaveemployed ingsisoverestimatedduringmid-dayandunderestimatedintheearly
the6-directionalsetuptomeasureradiationfluxdensitiesinurban morningandevening(Johanssonetal.,2014;Thorssonetal.,2007).
areasformodelingpurposes,mostobservationswereconductedin Thedifferenceinsensorperformance(Kestrelvs.MaRTy)hasadirect
temperateclimates(Table3)withT peakingaround29°Cto35°C impact on the validation of the two models. In the summer, the
a
andT inthe40to65°Crange(Ali-ToudertandMayer,2007;Holst overestimatedKestrelreadingslikelyamplifythepositiveMBEfound
MRT
andMayer,2011;Kántoretal.,2018;LeeandMayer,2018).Thewide acrossmostlocationssimulatedwithENVI-met,furtherincreasingthe
rangeofsolarradiationregimesinthisstudyallowsforasensitivity RMSE.ForRayMan,resultsforopensiteswouldslightlyimproveusing
analysisandassessmentofmodelperformanceundercoldandex- the6-directionalsetup.Intheshoulderandwinterseasonswhensun
tremelyhotconditions. anglesarelower,resultswouldbeamplifiedintheoppositedirection.

P.J.Cranketal./ScienceoftheTotalEnvironment749(2020)141392 9
Fig.6.Meanradianttemperature(TMRT)[°C]statisticsforseasonalENVI-metsimulations:a)MeanBiasError(MBE);b)RootMeanSquareErrorRMSEasbarsandIndexofAgreement
(d)aspoints;c)UnsystematicRootMeanSquareError(RMSEu)andSystematicRootMeanSquareError(RMSEs).
IncontrasttosimilarstudiesvalidatingT inurbanareas,ourfield unchangedduringtheobservationperiod,whiletransectsallowsam-
MRT
observationswereconductedusingtransects.Stationarystationshave plingofavarietyoflocationsusingthesamesensors.Toensurethat
theadvantagethatthepositionofthesensorsin3Dspaceremains theKestrelmeterandMaRTycartweresetupattheexactsamespot,
Table3
Otherpeer-reviewedRayManandENVI-metstudiesthatevaluatedMeanRadiantTemperature(TMRT)usingin-situobservations.Onlystudiesarelistedthatreporttherootmeansquare
error(RMSE)ofTMRTataminimum.
Study Locationandvalidationperiod Climate Model(andgridcellsize) RMSE Wilmott'sd
|                   | Bilbao,Spain(43°N),August6–8,2010 |                 | Ta0.9°C–2.1°C    | 0.83–0.94 |
| ----------------- | --------------------------------- | --------------- | ---------------- | --------- |
| Aceroand          | Oceanic                           | ENVI-metv.4.0,  |                  |           |
| Arrizabalaga,2018 |                                   | 1.5×1.5×2,2×2×2 | TMRT7.4°C–19.0°C | 0.51–0.87 |
(telescoping)
Colteretal.,2019 Phoenix,USA(33oN),12June-8July2015 Arid RayMan TMRT5.5°C 0.94
Hannover,Germany(52°N),July7–September4,2016;Jan- Ta0.7°C–3.6°C –
| Forouzandeh,2018 | Temperate             | ENVI-metv.4.1.0,2×2×1 |                 |     |
| ---------------- | --------------------- | --------------------- | --------------- | --- |
|                  | uary27–February3,2017 |                       | TMRT2.2°C–8.4°C |     |
GálandKántor,2020 Szeged,Hungary(46°N),August7–8,2016 Temperate RayMan/ENVI-metv.4.4.2, TMRT8.0°C/6.9°C 0.92/0.95
1×1×0.5
Krügeretal.,2014 Glasgow,UK(55°N),March3–July29,2011 Temperate RayMan TMRT11.6°C–20.2°C 0.37–0.69
Leeetal.,2016 Freiburg,Germany(48°N),August4,2003;July27,2009 Temperate RayMan/ENVI-metv.4(2013 TMRT5.5°C/12.6°C 0.95/0.64
release),1×1×1
LeeandMayer,2016 Freiburg,Germany(48°N),July27,2009 Temperate RayMan TMRT12.6°C 0.64
Matzarakisetal.,2010 Freiburg,Germany(48°N),July16–19,2006 Temperate RayMan TMRT3.7°C(open) –
0.7°C(tree)
|     |     |     | Ta0.7°C–1.4°C | 0.87–0.96 |
| --- | --- | --- | ------------- | --------- |
RothandLim,2017 Singapore(1°N),October1,8,15,2012;January29,2013; Tropical ENVI-metv.3.1,4×4×4
February2,2013;July21,24,28,2013 TMRT6.4°C–14.1°C(day) 0.77–0.96
|     |     |     | TMRT4.3°C–9.2°C(night) | 0.11–0.86 |
| --- | --- | --- | ---------------------- | --------- |
Zhangetal.,2018 Wuhan,China(31°N),August16,2016;January14,2017 Subtropical ENVI-metv.4.0;2×2×0.9 Ta1.5°C(summer), 0.91
|     |     | (telescoping) | Ta1.0°C(winter),       | 0.72 |
| --- | --- | ------------- | ---------------------- | ---- |
|     |     |               | TMRT5.2°C(summer),TMRT | 0.78 |
|     |     |               | 5.0°C(winter)          | 0.76 |
–
ZhaoandFong,2017 HongKong,China(22°N),August5,2015 Subtropical ENVI-metv.4.0,3×3×0.6 Ta0.6°C,TMRT5.7°C
(telescoping)
Cranketal.,2020(this Phoenix,AZ,USA(33°N),October24,2014;February18, Arid RayMan/ENVI-metv.4.3, TMRT8.9°C–12.4°C/Ta1.5°C– 0.88/0.99
study) 2015;March23,2015;June20,2015;June21,2017 4×4×4 2.7°C,TMRT11.2°C–16.1°C

10 P.J.Cranketal./ScienceoftheTotalEnvironment749(2020)141392
wemarkedeachlocationwithanXandindicatedtheorientationofthe statistics(Hwangetal.,2011;Linetal.,2010).Thorssonetal.(2007)
cartwithanarrowtoguaranteeconsistentalignment.Thecartwasop- simulatedT withRayManforfivedaysinthefallof2005andsum-
MRT
eratedbythesamepersonallday,andtheKestreltransectswerecon- merof2006inGöteborg,Swedentocomparetointegralradiationmea-
ducted in pairs of two with at least one of the two people being surementsandgreyT observations.ThemodelunderestimatedT
g MRT
familiarwiththelocations.Weestimatethespatialoffsetbetweentran- considerablyinthemorningandeveningforthesummerandthrough-
sectstobeamaximumof20cm.Consistencyintransectlocationsacross outthewholedayinOctober.Theauthorspointoutthatreflectedshort-
seasonswasmoredifficult,becausethechalkmarkingswerenotper- waveandemittedlongwaveradiationfromsurroundingsurfacesare
manent.WetookphotosofthemarkingsinOctober2014toensure importantdriversofT atlowsunelevationanglesthathavenot
MRT
thatthesamelocationsgetmarkedinsubsequentseasonsandyears. beenwelldocumentedintheRayManliterature.Chenetal.(2014)fur-
Weestimatethespatialoffsetbetweenfieldcampaignstobelessthan thercorroborateunderestimatedT values(byabout7°C)forobser-
MRT
ameter,whichiswithinthespatialresolutionoftheestablished vationsconductedin Freiburg,Germanyon August10,2010.More
ENVI-met grid and therefore should not have an impact on the recently,GálandKántor(2020)evaluatedRayManusingintegralradia-
modelvalidation. tionmeasurementsindowntownSzeged,Hungaryforaclearsummer
dayinAugust2018andconfirmedthatRayManconsistentlyunderesti-
4.2.RayManvalidation matesT withanRMSEof8.0°C.
MRT
Oursummerresultscontrastwithpreviousstudiesduetoextreme
RayManyieldslargemodelingerrorsacrossallfieldcampaigns,with heatconditionsandhighersunelevationangles.WhileRayManunder-
RMSErangingfrom8°Cto12°C,irrespectiveofinstrumentation.The estimatesT fortemperateclimateconditionsandlowsunelevation
MRT
magnitudeoftheerrorislargerthantheT accuracyof±5°Csug- angles,itoverestimatesT forhot,dryoutdoorconditionswhenT ex-
MRT MRT a
gestedbyGálandKántor(2020)forheatandcoldstressstudies.Field ceeds40°CandyieldsalargepositiveMBE,especiallyforsemi-open
campaignsintemperateclimatesfoundsimilaraccuracyissuesthat andenclosedsites.Colteretal.(2019)foundcomparabletrendsfor
weremostpronouncedatlowsunanglesandcomplexsites.Leeand T measurementsundertreesinPhoenixparksin2015withRMSE
MRT
Mayer(2016)validatedRayManforfiveheterogeneoussitesinFrei- anddcalculatedforobservedandmodeledT of5.5°Cand0.94,re-
MRT
burg,GermanyforJuly27,2009andshowanoverallRMSEof12.6°C spectively.OursensitivityanalysisacrossseasonsrevealsthatRayMan
withlargesystematicerrorsandanindexofagreementof0.64.Theau- errorsbecomelargerwithincreasingT andexceedacceptablelevels
a
thorsraisedconcernsaboutthephysicalprinciplesimplementedin evenforopensitesunderextremeheat.T errorsforTempeexhibit
MRT
RayMan and recommend updating the governing formulas. Krüger aclearseasonaltrend;valuesareunderestimatedinthewinterand
etal.(2014)testedtheperformanceofRayManinGlasgowduringsum- shoulderseasonsandoverestimatedunderhotsunnyconditions,dou-
mer2011forvariousinputparametercombinationsandfoundthatthe blingtheacceptable±5°CerrorforT suggestedbyGálandKántor
MRT
standardmethodofrunningRayManusingfisheyephotos,T,RH,andv (2020)forheatstressstudies.
a
yieldedthelargesterrors(RMSE=20.2°Candd=0.37).Theycon-
cludedthatRayManisunfittosimulateT withoutadditionalinput
MRT
ofsolarradiation. 4.3.ENVI-metvalidation
OurresultsconfirmpreviousfindingsthatRayMandoesnotperform
wellincomplexurbansettingswithheterogeneoussurfacesandhori- ENVI-metproduceslargemodelingerrorsacrossallfieldcampaigns
zonlimitations,suchastheBreezewaylocationwiththedeciduous forT (RMSErangesfrom11.2°Cto16.1°C)thatareoutsideoftheac-
MRT
treethatmainlyconsistsofbranchesduringthewinter.Errorsfortree ceptableerrorrange.Yet,similarRMSEvalueshavebeenreportedinthe
shadedlocationsarelargelyunsystematic,mostlikelyduetotheran- literature(Table3).AceroandArrizabalaga(2018)foundRMSEranges
domnatureofgapsinthetreecrown.RayManassumesalocationis of7.4°Cto19.0°CforaneighborhoodinBilboa,Spain;Forouzandeh
sun-exposedifthefisheyepixelthatintersectswiththecalculatedsun (2018)conductedENVI-metsimulationsforHannover,Germanythat
position is “white”, which can lead to false positives (a location is yieldedaRMSEofupto8.4°C;Leeetal.(2016)reportedaRMSEof
treatedassun-exposedalthoughitisshaded),especiallyforlowleaf 12.6°CforastudysiteinFreiburg,Germany;andRothandLim(2017)
areadensitytrees.Additionally,heterogeneousenvironmentsoftenex- foundaRMSEofupto14.1°Cfordaytimesimulationsofasiteintropical
hibithighlyvariableT.Parketal.(2018)conductedasensitivityanaly- Singapore.ENVI-metstudiesthatreportanRMSEclosetotheacceptable
s
sisforT modelparametersinMMRT,amultilayerT simulation errorrangeincludetwostudiesinChina(Zhangetal.,2018;Zhaoand
MRT MRT
tool,andfoundthatshadeestimatesandT aremostimportantfor Fong,2017)withRMSEbetween5.0°and5.7°C.Despitedemonstrated
s
predicting T . In our RayMan evaluation, T results improved largeerrors,moststudiesconcludedthatthemodelvalidationwassuc-
MRT MRT
slightlywhenaddingT asanadditionalforcingparameter,butnotsig- cessfulandthatENVI-metisausefulresearchtool;whilesomeauthors
s
nificantly.ObservedT duringallfieldcampaignsmostlycapturethe cautionthatitisimportanttoknowthelimitationsofthemodel,none
s
ground(FLIR)orthelowerhemisphere(MaRTy)andarenotrepresen- ofthepreviousstudiesdiscourageditsusebasedonthereportederrors.
tativeoftheaverageT ofallsurfacesinthe360°surroundings,which ENVI-metshowsthesameseasonalperformancetrendsasRayMan.
s
requiresusingspecialequipment,suchastheSMARTsensororthermal Comparedtowinterandshoulderseasonsimulations,RMSEismuch
panoramas(Avivetal.,n.d.). largerunderextremeheatconditionswithpositiveMBEofupto12°C,
Observations at the Tunnel and Arcade sites demonstrate that i.e.themodeloverestimatesT ,withalargesystematicerrorofupto
MRT
RayManisunabletoaccuratelysimulateengineeredenclosedspaces 22.7°Cforsemi-openandenclosedsitesdespitegoodagreementwithin-
andconsistentlyoverpredictsT ,especiallyinthesummer.Thisfur- comingglobalsolarradiationmeasurements.Thepredispositionofthe
MRT
therhighlightstheneedtoupdatephysicalprinciplesofthemodelto modeltooverestimateT inhoturbanenvironmentshaspreviously
MRT
moreaccuratelysimulatelongwaveradiationfluxdensities,assug- beenreportedbyotherauthors.Forexample,Elnabawietal.(2013)sim-
gestedbyLeeandMayer(2016). ulatedanurbancanyoninahistoricneighborhoodofCairo,Egyptand
Previously,RayManhasmostlybeenvalidatedintemperateclimates foundthatENVI-metoverpredictsT byupto4°Cintheafternoon.
MRT
athigherlatitudeswithatendencytounderestimateT .Matzarakis RothandLim(2017)evaluatedENVI-met3.1foralow-riseneighborhood
MRT
etal.(2010)reportgoodagreementwith6-directionalmeasurements inSingaporeandreportedoverpredictedT for6outof8receptorloca-
MRT
attwo sites fora summer day in Freiburg, Germany with RMSE of tions.TheauthorsnotedthatENVI-met'srepresentationoftheparameter
0.7°Cunderatreeand3.7°Cinasemi-openspace.Twostudiesin f,i.e.theproportionofthesurfaceofanupright,rotationallysymmetric
p
TaiwanfoundthatRayManoverestimatesT by0.7°Cto2.3°Cfor bodythatisexposedtodirectincomingsolarradiation,isdifferentfrom
MRT
globethermometerobservedT =60°C,butdidnotprovideerror thestandardapproachusedinhuman-biometeorologicalstudies.After
MRT

P.J.Cranketal./ScienceoftheTotalEnvironment749(2020)141392 11
correctingforthedeviationsinf ,T peakvaluesintheafternoonde- Modelvalidationthroughin-situobservationsisvital,notjusttoim-
p MRT
creasedanddaytimemagnitudesweremostlylower. provefuturemodelperformancebutalsotoassessbiasesandreliability
WhileENVI-metgenerallyoverestimatesT forextremeheatcondi- ofcurrentsimulationresults.Thisisamplifiedforsoftwarethatisnot
a
tionsinthisstudy,whichcanbeattributedtodrysoilconditionsthatdis- open-sourcedorwithactivecommunityengagementoncodinglimita-
proportionatelyaffectT (RothandLim,2017),modelperformanceis tions.EventhoughENVI-metandRayManhavebeenwidelyusedby
a
surprisinglyunsatisfactoryforrepresentingintra-neighborhoodT and theurbanclimateandhuman-biometeorologycommunityinvariouscli-
a
T variabilityacrossseasons.Noneofthereceptorsinthemodeldomain maticandmorphologicalcontextsforoveradecade,manystudiesdidnot
MRT
aresubjecttoedgeeffects,becausetheyareplacedawayfromthemodel validateT modelresultsusingin-situobservations(e.g.,Abdel-Ghany
MRT
boundaries(Middeletal.,2014).DifferencesinsimulatedandobservedT etal.,2014;deAbreu-Harbichetal.,2015;Fröhlichetal.,2019;Ketterer
a
atreceptorlocationsaremostlikelyrelatedtothediurnalwindregime andMatzarakis,2014;Nabonietal.,2017;Taleghanietal.,2016,2019).
thatisheldconstantthroughoutthesimulation.Forexample,theob- Some ENVI-met studies validated simulated T (e.g., Emmanuel and
a
servedwindspeedatAshAvenuewas1.5m−sat14:00LSTonJune21, Fernando,2007;Teshnehdeletal.,2020),whichhelpsassessthemodel's
2017butsimulatedas0.8m−s.AceroandArrizabalaga(2018)reported abilitytorepresentphysicalprocessesindomainbutdoesnotevaluatera-
similardiscrepanciesbetweenmodeledandobservedwindspeedinthe diativefluxcalculationsthatdriveT Ingeneral,effortstovalidatemi-
MRT.
domain.Todate,nostudyhassystematicallyassessedthehourlyspatial crometeorologicalandhuman-biometeorologicalvariablesinENVI-met
windprofileENVI-metgeneratesusingthe“simpleforcing”settingto aresparse.InasystematicreviewofENVI-metstudiesbetween1999
quantifyerrorsinintra-neighborhoodT variabilityresultingfromtheas- and2018,Tsokaetal.(2018)reported52evaluationstudiesoutofalmost
a
sumptionthatwindspeedanddirectionareconstantthroughoutthesim- 280reviewed,andonly16studiesvalidatedT .Similarly,aScopus
MRT
ulation.AlthoughENVI-met4.4offers“fullforcing”withvariablehourly search for “RayMan” in June 2020 yielded 87 studies that used the
windspeedanddirection,itisunclearifthisoptionproducesmoreaccu- modelbetween2007and2020,butonly11studiesevaluatedT With-
MRT.
rateresultsandwhetherthetradeoffbetweenincreasedcomputation outevaluatingthemodeloutputbeingusedinanalysis,thereisinsuffi-
timeandmagnitudeofimprovedaccuracyisfeasible. cientevidencefromtheresultsfromanymodeltomakeconclusionsor
UnsystematicdifferencesinobservedandsimulatedT atsemi- providepolicyrecommendationstostakeholders.
MRT
enclosed sites can partially be explained through shading errors WhileRayManandENVI-metarethemostpopularmodelstodate
(AceroandHerranz-Pascual,2015;Chenetal.,2014;GálandKántor, forradiationfluxmodelingandthermalcomfortassessments,other
2020)inthesimulatedradiationregime.TheArcadeinthisstudyissub- modelshavebeendevelopedthatcouldnotbeassessedwithinthelim-
jecttoshadingerrorsduringmiddayinthesummer:theextentofthe itedscopeofthisstudy.SOLWEIG(Lindbergetal.,2008;Lindbergand
horizontalshadestructureequalsonegridcell(4m)inENVI-met,but Grimmond,2011)wasspecificallydevelopedtosimulatespatialand
theArcadeisonlyabout2.5mdeep.Althoughthelocationisshaded temporalvariationsof3DradiantfluxesandT incomplexurbanen-
MRT
allday,ENVI-metsimulationsforJuneyieldsixhoursofsun-exposure vironments.ItsperformanceincomparisontoENVI-metandRayMan
withaddeddirectshortwaveradiation,artificiallyinflatingT .This has been assessed by various authors (Chen et al., 2014; Gál and
MRT
errorislikelyduetothecoarseverticalgridcellsizeof4m.While Kántor,2020;Liuetal.,2020).VTUF-3D1.0(Niceetal.,2018)builds
ENVI-metcansimulatedomainswithsmallergridcellsizes,thiscreates on the urban micro-climate surface energy balance model TUF-3D
atradeoffbetweenmorphologicaldetailsandperformancethatcould (KrayenhoffandVoogt,2007)andprovidesestimatesofT,T ,and
s MRT
bealleviatedbyallowingvariablegridcellsizes.Choosingourstudy thethermalcomfortindexUTCI.Parketal.(2018)developedamulti-
sites,wetriedtoavoidlocationsthatwereaffectedbyshadingerrors layerT model(MMRT)thatcalculatestheradiationtransferincom-
MRT
duetothecoarsegridcellsizeoftheENVI-metdomain.Theonlytwolo- plexenvironmentsusingMonteCarloRayTracing.Anotherpromising
cationsaffectedbythiserrorarethearcadeandoverhanginJune,which approachfromthearchitecturecommunitytocalculateT istheLady-
MRT
becomesevidentinthelargesystematicerror. bug/HoneybeepluginforGrasshopper(Evolaetal.,2020;Lobaccaro
DifferencesbetweenobservedandENVI-metsimulatedT for etal.,2018;Nabonietal.,2017;RoudsariandPak,2013)andCohen
MRT
enclosed sites such as the Tunnel exceed 24.0 °C with an RMSE of etal.(2020)developedMr.T,anEXCELspreadsheetbasedsoftware
17.3°CinJune2017.Thiserrorisalmostfourtimeslargerthantheac- that calculates T for individual locations, analogous to RayMan.
MRT
ceptableerrorrangeforheatstressstudies.Huttner(2012)outlined ENVI-metcounterpartsincludeOpenFOAM,Star-CCM+,andFLUENT;
limitationstoradiativefluxcalculationsinENVI-metrelatedtodiffuse however, not all have been tested or validated for T (Botham-
MRT
shortwave radiation and vegetation, which were confirmed in an Myintetal.,2015).Futureresearchshouldconductasystematiccom-
experimentbyGálandKántor(2020)whofoundthatENVI-metoveres- parisonacrossvariousT modelsusinghighquality6-directional
MRT
timatesT by9°Cundershadedconditions.Yet,themissingattenua- fluxdensitymeasurementsinvariousclimaticzonesandurbancontexts
MRT
tionofdiffuseshortwaveradiationbytreesdoesnotexplainthelarge acrossseasonsasbenchmarkstoperformsensitivityanalysesandafull
simulationerrorattheTunnelsite.Explorationofthedirectionalflux assessmentofmodelperformancetoguidefuturemodeldevelopment.
densitiesatthereceptorlocationshowsthattheerrorstemsfroman
overestimationofreflectedshortwaveradiation. 5.Conclusions
4.4.Notesonmodeldocumentationandvalidation ThisstudyvalidatedRayManandENVI-metT simulationsfor
MRT
Tempe,Arizona'sMillAvenuedistrictusingin-situobservationswith
OurseasonalT validationforRayManandENVI-metdemon- KestrelmetersandMaRTytoassessmodelperformanceacrossseasons
MRT
stratesthatbothmodelsperformunsatisfactoryunderextremeheat andunderextremeheatconditions.Observationscoveredawiderange
conditions.Evenforopensites,whicharelesscomplexduetominimal ofsolarradiationregimesfromaminimumobservedT of8.7°Cdur-
MRT
horizonlimitationsandlimitedurbanfeaturesinthefieldofview,model ingwintertoamaximumof84.9°Cinthesummer.Bothmodelspro-
errorsaremuchlargerthaninstrumentationerrorsandfailtomeetrec- duced large errors across seasons irrespective of instrumentation
ommended accuracy requirements for heat stress studies (±5 °C). (Kestrelvs.MaRTy),withRMSErangingfrom8°Cto12°C(RayMan)
Whilesystematicandunsystematicerrorsandmodelbiasescanbequan- and11.2°Cto16.1°C(ENVI-met),exceedingasuggestedT accuracy
MRT
tifiedusingin-situobservations,incompletedocumentationoftheimple- of±5°Cforheatandcoldstressstudies.
mented underlying physical principles impedes the detection and OurresultsshowthatRayMandoesnotworkwellforengineered
eliminationofpossibleerrors.ThisisparticularlytrueforENVI-met,as enclosedspaces(e.g.tunnel,arcade),complexsettings(e.g.,lowleaf
themodelfullyreliesoncasestudiesbyurbanclimatecommunitypaying area density trees or deciduous trees during leaf-off season), and
customersforvalidationandmodelparameterimprovement. underextremeheatconditions.ENVI-metexhibitsthesameseasonal

12 P.J.Cranketal./ScienceoftheTotalEnvironment749(2020)141392
swingtoRMSEandMBEasRayMan,underestimatingT incoldersea- Acero,J.A.,Herranz-Pascual,K.,2015.Acomparisonofthermalcomfortconditionsinfour
MRT
urbanspacesbymeansofmeasurementsandmodellingtechniques.Build.Environ.
sonsandoverestimatinginthesummerwhileerrorsbecomelarger 93,245–257.https://doi.org/10.1016/j.buildenv.2015.06.028.
withincreasingT a towardsextremeheat(RMSEupto25.5°C).ENVI- Ali-Toudert,F.,Mayer,H.,2007.Thermalcomfortinaneast–westorientedstreetcanyon
metdidnotresolveintra-domainspatial variabilityof T andT . inFreiburg(Germany)underhotsummerconditions.Theor.Appl.Climatol.87,
a MRT 223–237.https://doi.org/10.1007/s00704-005-0194-4.
Thiscanbepartiallyattributedtoconstantdiurnalwindforcing(T )
a Aminipouri,M.,Knudby,A.J.,Krayenhoff,E.S.,Zickfeld,K.,Middel,A.,2019a.Modellingthe
andtheuniformlygriddednatureofENVI-metthatcreatesatradeoff impact of increased street tree cover on mean radiant temperature across
betweendetailedurbanmorphologyrepresentationandmodelperfor- Vancouver’slocalclimatezones.UrbanForestryandUrbanGreening39,9–17.
mance(T ),leadingtoerrorsinthemodeledradiationregime.For https://doi.org/10.1016/j.ufug.2019.01.016.
encloseds M p R a T ces,ENVI-metestimatesreflectedshortwaveradiationto Aminipouri,M.,Rayner,D.,Lindberg,F.,Thorsson,S.,Knudby,A.J.,Zickfeld,K.,Middel,A.,
Krayenhoff,E.S.,2019b.Urbantreeplantingtomaintainoutdoorthermalcomfort
beequaltosun-exposedlocations,whichislikelyabuginthecode underclimatechange:thecaseofVancouver’slocalclimatezones.Build.Environ.
that produces highly inaccurate results for T under engineered
158,226–236.https://doi.org/10.1016/j.buildenv.2019.05.022.
MRT
Aviv,D.,Guo,H.,Middel,A.,Meggers,F.,n.d.Evaluatingradiantheatinanoutdoorurban
shade,e.g.fromshadesails.
environment:resolvingspatialandtemporalvariationswithtwosensingplatforms
Basedonourmodelassessment,wedonotrecommendusingENVI- anddata-drivensimulation.UrbanClim.
metandRayManforthermalcomfort,exposure,andshadestudiesin Botham-Myint,D.,Recktenwald,G.W.,Sailor,D.J.,2015.Thermalfootprinteffectofroof-
topurbancoolingstrategies.UrbanClim.14,268–277.https://doi.org/10.1016/j.
hotenvironmentswithoutextensivein-situT observationsforbias
MRT uclim.2015.07.005.
evaluation,asbothmodelsstrugglewithradiationfluxcalculationsof
Bröde,P.,Fiala,D.,B\la\.zejczyk,K.,Holmér,I.,Jendritzky,G.,Kampmann,B.,Tinz,B.,Havenith,
enclosedspaces,anderrorsgetlargerasincomingshortwaveradiation G.,2012.DerivingtheoperationalprocedurefortheUniversalThermalClimateIndex
increases.Moregenerally,wecautionagainstusingmodelsinmicrome-
(UTCI).Int.J.Biometeorol.56,481–494.https://doi.org/10.1007/s00484-011-0454-1.
Bruse,M.,Fleer,H.,1998.Simulatingsurface-plant-airinteractionsinsideurbanenviron-
teorologicalormorphologicalextremesthattheywerenotdesignedfor
mentswithathreedimensionalnumericalmodel.Environ.Model.Softw.13,
withoutin-situvalidationtoassessmodelperformance.Whilemodels 373–384.https://doi.org/10.1016/S1364-8152(98)00042-5.
mayyieldsatisfactoryresultsfortemperateclimates,extremecondi- Chen,L.,Ng,E.,2012.Outdoorthermalcomfortandoutdooractivities:areviewofresearch
tions could amplify errors inherent in the radiative flux modeling.
inthepastdecade.Cities29,118–125.https://doi.org/10.1016/j.cities.2011.08.006.
Chen,Y.C.,Lin,T.P.,Matzarakis,A.,2014.Comparisonofmeanradianttemperaturefrom
Modelvalidationshouldbeperformedacrossmultiplepointsinspace, fieldexperimentandmodelling:acasestudyinFreiburg,Germany.Theor.Appl.
time,urbanforms,and,ideally,includethefullparameterspaceofout- Climatol.118,535–551.https://doi.org/10.1007/s00704-013-1081-z.
Chow,W.T.L.,Brazel,A.J.,2012.Assessingxeriscapingasasustainableheatislandmitiga-
putvariables,butataminimum,thevariableofinterest(Krayenhoff
tionapproachforadesertcity.Build.Environ.47,170–181.https://doi.org/10.1016/j.
etal.,n.d.).Ininterpretingresults,usersshouldbeawareofmodellim- buildenv.2011.07.027.
itationsduetoimplementedphysicalprinciples,parameterizations,and Cohen,S.,Palatchi,Y.,Palatchi,D.P.,Shashua-Bar,L.,Lukyanov,V.,Yaakov,Y.,Matzarakis,
assumptions.Rigorousvalidationwilladvancemodeldevelopmentand A.,Tanny,J.,Potchter,O.,2020.Meanradianttemperatureinurbancanyonsfrom
solarcalculations,climateandsurfaceproperties–theory,validationandʽMr.Tʼsoft-
improveourunderstandingofthecomplexdynamicsintheurbancan- ware.Build.Environ.,106927https://doi.org/10.1016/j.buildenv.2020.106927.
opylayerthroughobservationsandmodeling. Colter,K.R.,Middel,A.C.,Martin,C.A.,2019.Effectsofnaturalandartificialshadeonhuman
thermalcomfortinresidentialneighborhoodparksofPhoenix,Arizona,USA.Urban
ForestryandUrbanGreening44.https://doi.org/10.1016/j.ufug.2019.126429.
CRediTauthorshipcontributionstatement Crank,P.J.,Sailor,D.J.,Ban-Weiss,G.,Taleghani,M.,2018.EvaluatingtheENVI-metmicro-
scalemodelforsuitabilityinanalysisoftargetedurbanheatmitigationstrategies.
UrbanClim.26,188–197.
PeterJ.Crank:Formalanalysis,Investigation,Writing-original Crewe,K.,Brazel,A.,Middel,A.,2016.Desertnewurbanism:testingforcomfortin
draft,Writing-review&editing.ArianeMiddel:Conceptualization, downtownTempe,Arizona.J.UrbanDes.21,746–763.https://doi.org/10.1080/
Methodology,Formalanalysis,Investigation,Visualization,Writing- 13574809.2016.1187558.
Elnabawi,M.H.,Hamza,N.,Dudek,S.,2013.Useandevaluationoftheenvi-metmodelfor
originaldraft,Writing-review&editing.MelissaWagner:Conceptual-
twodifferenturbanformsinCairo,Egypt:measurementsandmodelsimulations.
ization,Methodology,Formalanalysis,Writing-originaldraft,Writing- ProceedingsofBS2013:13thConferenceoftheInternationalBuildingPerformance
review&editing.DaniHoots:Conceptualization,Methodology,Formal SimulationAssociation,pp.2800–2806.
Emmanuel,R.,Fernando,H.J.S.,2007.Urbanheatislandsinhumidandaridclimates:role
analysis,Writing-originaldraft,Writing-review&editing.Martin
ofurbanformandthermalpropertiesinColombo,SriLankaandPhoenix,USA.Clim.
Smith: Conceptualization,Methodology, Formal analysis, Writing - Res.34,241–251.https://doi.org/10.3354/cr00694.
originaldraft,Writing-review&editing.AnthonyBrazel:Conceptual- Emmanuel,R.,Rosenlund,H.,Johansson,E.,2007.Urbanshading—adesignoptionforthe
tropics?AstudyinColombo,SriLanka.Int.J.Climatol.27,1995–2004.https://doi.org/
ization,Methodology,Formalanalysis,Investigation,Writing-original
10.1002/joc.1609.
draft,Writing-review&editing. Evola,G.,Costanzo,V.,Magrì,C.,Margani,G.,Marletta,L.,Naboni,E.,2020.Anovelcom-
prehensiveworkflowformodellingoutdoorthermalcomfortandenergydemandin
urbancanyons:resultsandcriticalissues.Energy&Buildings216,109946.https://
Declarationofcompetinginterest doi.org/10.1016/j.enbuild.2020.109946.
Forouzandeh,A.,2018.Numericalmodelingvalidationforthemicroclimatethermalcon-
Theauthorsdeclarethattheyhavenoknowncompetingfinancial ditionofsemi-closedcourtyardspacesbetweenbuildings.Sustain.CitiesSoc.36,
327–345.https://doi.org/10.1016/j.scs.2017.07.025.
interestsorpersonalrelationshipsthatcouldhaveappearedtoinflu-
Fröhlich,D.,Gangwisch,M.,Matzarakis,A.,2019.Effectofradiationandwindonthermal
encetheworkreportedinthispaper. comfortinurbanenvironments-applicationoftheraymanandskyHeliosmodel.
UrbanClim.27,1–7.https://doi.org/10.1016/j.uclim.2018.10.006.
Gál,C.V.,Kántor,N.,2020.Modelingmeanradianttemperatureinoutdoorspaces,acom-
AppendixA.Supplementarydata
parativenumericalsimulationandvalidationstudy.UrbanClim.32,100571.https://
doi.org/10.1016/j.uclim.2019.100571.
Supplementarydatatothisarticlecanbefoundonlineathttps://doi. Häb,K.,Feige,N.H.,Huettenberger,L.S.,Middel,A.,Hagen,H.,2014.Visualizingthetem-
poraldevelopmentofthermo-radiativefeaturesonground-basedthermographs.En-
org/10.1016/j.scitotenv.2020.141392. viron.EarthSci.72,3781–3793.https://doi.org/10.1007/s12665-014-3472-6.
Häb,K.,Ruddell,B.L.,Middel,A.,2015.Sensorlagcorrectionformobileurbanmicroclimate
measurements.UrbanClim.14,622–635.https://doi.org/10.1016/j.uclim.2015.10.003.
References
Hedquist,B.C.,Brazel,A.J.,2014.Seasonalvariabilityoftemperaturesandoutdoorhuman
comfortinPhoenix,Arizona,U.S.A.Build.Environ.72,377–388.https://doi.org/
Abdel-Ghany,A.M.,Al-Helal,I.M.,Shady,M.R.,2014.Evaluationofhumanthermalcom- 10.1016/j.buildenv.2013.11.018.
fortandheatstressinanoutdoorurbansettinginsummerunderaridclimaticcon- Heris,M.P.,Middel,A.,Muller,B.,2020.Impactsofformanddesignpoliciesonurban
ditions.Environ.Prot.Eng.40,139–150.https://doi.org/10.5277/epel40311. microclimate:assessmentofzoninganddesignguidelinechoicesinurbanrede-
deAbreu-Harbich,L.V.,Labaki,L.C.,Matzarakis,A.,2015.Effectoftreeplantingdesignand velopmentprojects.Landsc.UrbanPlan.202,103870.https://doi.org/10.1016/j.
treespeciesonhumanthermalcomfortinthetropics.Landsc.UrbanPlan.138, landurbplan.2020.103870.
99–109.https://doi.org/10.1016/j.landurbplan.2015.02.008. Holst,J.,Mayer,H.,2011.Impactsofstreetdesignparametersonhuman-biometeorological
Acero,J.A.,Arrizabalaga,J.,2018.EvaluatingtheperformanceofENVI-metmodelindiur- variables.Meteorol.Z.20,541–552.https://doi.org/10.1127/0941-2948/2011/0254.
nal cycles for different meteorological conditions. Theor. Appl. Climatol. 131, Höppe,P.,1992.Anewproceduretodeterminethemeanradianttemperatureoutdoors.
455–469.https://doi.org/10.1007/s00704-016-1971-y. WetterundLeben44,147–151.

P.J.Cranketal./ScienceoftheTotalEnvironment749(2020)141392 13
Huttner,S.,2012.FurtherDevelopmentandApplicationofthe3DMicroclimateSimulation Middel,A.,Chhetri,N.,Quay,R.,2015.Urbanforestryandcoolroofs:assessmentofheat
ENVI-Met.Dissertation.JohannesGutenberg-UniversityofMainz,Germanyhttp:// mitigationstrategiesinPhoenixresidentialneighborhoods.UrbanForestryand
ubm.opus.hbznrw.de/volltexte/2012/3112/pdf/doc.pdf.(Accessed7July2020). UrbanGreening14,178–186.https://doi.org/10.1016/j.ufug.2014.09.010.
Hwang,R.L.,Lin,T.P.,Matzarakis,A.,2011.Seasonaleffectsofurbanstreetshadingon Middel,A.,Selover,N.,Hagen,B.,Chhetri,N.,2016.Impactofshadeonoutdoorthermalcom-
long-termoutdoorthermalcomfort.Build.Environ.46,863–870.https://doi.org/ fort—aseasonalfieldstudyinTempe,Arizona.Int.J.Biometeorol.60,1849–1861.https://
10.1016/j.buildenv.2010.10.017. doi.org/10.1007/s00484-016-1172-5.
ISO,1998.ISOStandard7726,ErgonomicsoftheThermalEnvironment,Instrumentsfor Middel,A.,Lukasczyk,J.,Maciejewski,R.,Demuzere,M.,Roth,M.,2018.Skyviewfactor
MeasuringPhysicalQuantities.ISO,Geneva. footprintsforurbanclimatemodeling.UrbanClim.25,120–134.https://doi.org/
Johansson,E.,Thorsson,S.,Emmanuel,R.,Krüger,E.,2014.Instrumentsandmethodsin 10.1016/j.uclim.2018.05.004.
outdoorthermalcomfortstudies-theneedforstandardization.UrbanClim.10, Middel,A.,Lukasczyk,J.,Zakrzewski,S.,Arnold,M.,Maciejewski,R.,2019.Urbanformand
346–366.https://doi.org/10.1016/j.uclim.2013.12.002. compositionofstreetcanyons:ahuman-centricbigdataanddeeplearningapproach.
Jones,B.,O’Neill,B.C.,Mcdaniel,L.,Mcginnis,S.,Mearns,L.O.,Tebaldi,C.,2015.Futurepop- Landsc.UrbanPlan.183,122–132.https://doi.org/10.1016/j.landurbplan.2018.12.001.
ulationexposuretoUSheatextremes.Nat.Clim.Chang.5,652–655.https://doi.org/ Middel,A.,Turner,V.K.,Schneider,F.A.,Zhang,Y.,Stiller,M.,2020.Solarreflectivepave-
10.1038/nclimate2631.
ment–apolicypanaceatoheatmitigation?Environ.Res.Lett.15(6),064016.
Kántor,N.,Chen,L.,Gál,C.V.,2018.Human-biometeorologicalsignificanceofshadingin https://doi.org/10.1088/1748-9326/ab87d4.
urbanpublicspaces—summertimemeasurementsinPécs,Hungary.Landsc.Urban Morakinyo,T.E.,Kong,L.,Lau,K.K.L.,Yuan,C.,Ng,E.,2017.Astudyontheimpactof
Plan.170,241–255.https://doi.org/10.1016/j.landurbplan.2017.09.030. shadow-castandtreespeciesonin-canyonandneighborhood’sthermalcomfort.
Build.Environ.115,1–17.https://doi.org/10.1016/j.buildenv.2017.01.005.
Ketterer,C.,Matzarakis,A.,2014.Human-biometeorologicalassessmentofheatstressre-
Naboni,E.,Meloni,M.,Coccolo,S.,Kaempf,J.,Scartezzini,J.L.,2017.Anoverviewofsimu-
ductionbyreplanningmeasuresinStuttgart,Germany.Landsc.UrbanPlan.122,
78–88.https://doi.org/10.1016/j.landurbplan.2013.11.003. lationtoolsforpredictingthemeanradianttemperatureinanoutdoorspace.Energy
Procedia,1111–1116https://doi.org/10.1016/j.egypro.2017.07.471.
Krayenhoff,E.S.,Voogt,J.A.,2007.Amicroscalethree-dimensionalurbanenergybalance
modelforstudyingsurfacetemperatures.Boundary-LayerMeteorol123,433–461. Nice
m
,K
ic
.A
ro
.,
-
C
c
o
li
u
m
t
a
ts
t
,
e
A
m
.M
o
.
d
,
e
T
l
a
t
p
o
p
s
e
u
r,
p
N
p
.
o
J.
r
,
t
2
a
0
s
1
s
8
es
.
s
D
m
ev
e
e
n
l
t
o
o
p
f
m
u
e
r
n
ba
t
n
of
v
t
e
h
g
e
e
V
ta
T
t
U
io
F
n
-3
in
D
fl
v
u
1
e
.0 nc
u
e
r
s
b
o
a
n
n
https://doi.org/10.1007/s10546-006-9153-6. humanthermalcomfort.UrbanClim.24,1052–1076.https://doi.org/10.1016/
Krayenhoff,S.E.,Broadbent,A.M.,Zhao,L.,Georgescu,M.,Middel,A.,Voogt,J.A.,Martilli,
j.uclim.2017.12.008.
A.,Sailor,D.,Erell,E.,n.d.Coolinghotcities:asystematicandcriticalreviewofthenu-
Park,C.Y.,Lee,D.K.,Krayenhoff,E.S.,Heo,H.K.,Ahn,S.,Asawa,T.,Murakami,A.,Kim,
mericalmodellingliterature.Environ.Res.Lett.
H.G.,2018.Amultilayermeanradianttemperaturemodelforpedestriansina
Krüger,E.L.,Minella,F.O.,Matzarakis,A.,2014.Comparisonofdifferentmethodsofesti- streetcanyonwithtrees.Build.Environ.141,298–309.https://doi.org/10.1016/
matingthemeanradianttemperatureinoutdoorthermalcomfortstudies.Int. j.buildenv.2018.05.058.
J.Biometeorol.58,1727–1737.https://doi.org/10.1007/s00484-013-0777-1.
Roth,M.,Lim,V.H.,2017.Evaluationofcanopy-layerairandmeanradianttem-
Lee,H.,Mayer,H.,2016.ValidationofthemeanradianttemperaturesimulatedbytheRay peraturesimulationsbyamicroclimatemodeloveratropicalresidential
Mansoftwareinurbanenvironments.Int.J.Biometeorol.60,1775–1785.https://doi. neighbourhood. Build. Environ. 112, 177–189. https://doi.org/10.1016/j.
org/10.1007/s00484-016-1166-3. buildenv.2016.11.026.
Lee,H.,Mayer,H.,2018.Maximumextentofhumanheatstressreductiononbuilding Roudsari,M.S.,Pak,M.,2013.Ladybug:aparametricenvironmentalpluginforgrasshop-
areasduetourbangreening.UrbanForestryandUrbanGreening32,154–167. pertohelpdesignerscreateanenvironmentally-consciousdesign.ProceedingsofBS
https://doi.org/10.1016/j.ufug.2018.04.010. 2013: 13th Conference of the International Building Performance Simulation
Lee,H.,Holst,J.,Mayer,H.,2013.Modificationofhuman-biometeorologicallysignificantra- Association.
diantfluxdensitiesbyshadingaslocalmethodtomitigateheatstressinsummerwithin Stewart,I.D.,Oke,T.R.,2012.Localclimatezonesforurbantemperaturestudies.Bull.Am.
urbanstreetcanyons.Adv.Meteorol.2013.https://doi.org/10.1155/2013/312572. Meteorol.Soc.93,1879–1900.https://doi.org/10.1175/BAMS-D-11-00019.1.
Lee,H.,Mayer,H.,Schindler,D.,2014.Importanceof3-Dradiantfluxdensitiesforoutdoor Taleghani,M.,Sailor,D.,Ban-Weiss,G.A.,2016.Micrometeorologicalsimulationstopre-
humanthermalcomfortonclear-skysummerdaysinFreiburg,SouthwestGermany. dicttheimpactsofheatmitigationstrategiesonpedestrianthermalcomfortina
Meteorol.Z.,315–330https://doi.org/10.1127/0941-2948/2014/0536. LosAngelesneighborhood.Environ.Res.Lett.11,024003.https://doi.org/10.1088/
Lee,H.,Mayer,H.,Chen,L.,2016.Contributionoftreesandgrasslandstothemitigationof 1748-9326/11/2/024003.
humanheatstressinaresidentialdistrictofFreiburg,SouthwestGermany.Landsc. Taleghani,M.,Crank,P.J.,Mohegh,A.,Sailor,D.J.,Ban-Weiss,G.A.,2019.Theimpactofheat
UrbanPlan.148,37–50.https://doi.org/10.1016/j.landurbplan.2015.12.004. mitigationstrategiesontheenergybalanceofaneighborhoodinLosAngeles.Sol.En-
Lin,T.P.,Matzarakis,A.,2008.TourismclimateandthermalcomfortinSunMoonLake, ergy177,604–611.
Taiwan.Int.J.Biometeorol.52,281–290.https://doi.org/10.1007/s00484-007-0122-7. Teitelbaum,E.,Chen,K.W.,Meggers,F.,Guo,H.,Houchois,N.,Pantelic,J.,Rysanek,A.,
Lin,T.P.,Matzarakis,A.,Hwang,R.L.,2010.Shadingeffectonlong-termoutdoorthermal 2020.Globethermometerfreeconvectionerrorpotentials.Sci.Rep.10.https://doi.
comfort.Build.Environ.45,213–221.https://doi.org/10.1016/j.buildenv.2009.06.002. org/10.1038/s41598-020-59441-1.
Lindberg,F.,Grimmond,C.S.B.,2011.Natureofvegetationandbuildingmorphologycharac- Teshnehdel,S.,Akbari,H.,DiGiuseppe,E.,Brown,R.D.,2020.Effectoftreecoverandtree
teristicsacrossacity:influenceonshadowpatternsandmeanradianttemperaturesin speciesonmicroclimateandpedestriancomfortinaresidentialdistrictinIran.Build.
London.UrbanEcosyst.14,617–634.https://doi.org/10.1007/s11252-011-0184-5. Environ.178.https://doi.org/10.1016/j.buildenv.2020.106899.
Lindberg,F.,Holmer,B.,Thorsson,S.,2008.SOLWEIG1.0-Modellingspatialvariationsof Thorsson,S.,Lindberg,F.,Eliasson,I.,Holmer,B.,2007.Differentmethodsforestimating
3Dradiantfluxesandmeanradianttemperatureincomplexurbansettings.Int. themeanradianttemperatureinanoutdoorurbansetting.Int.J.Climatol.27,
J.Biometeorol.52,697–713.https://doi.org/10.1007/s00484-008-0162-7. 1983–1993.https://doi.org/10.1002/joc.1537.
Thorsson,S.,Rockl??v,J.,Konarska,J.,Lindberg,F.,Holmer,B.,Dousset,B.,Rayner,D.,
Liu,D.,Hu,S.,Liu,J.,2020.Contrastingtheperformancecapabilitiesofurbanradiation
fieldbetweenthreemicroclimatesimulationtools.Build.Environ.175.https://doi. 2014.Meanradianttemperature-apredictorofheatrelatedmortality.UrbanClim.
10,332–345.https://doi.org/10.1016/j.uclim.2014.01.004.
org/10.1016/j.buildenv.2020.106789.
Tsoka,S.,Tsikaloudaki,A.,Theodosiou,T.,2018.AnalyzingtheENVI-MetMicroclimate
Lobaccaro,G.,Croce,S.,Vettorato,D.,Carlucci,S.,2018.Aholisticapproachtoassesstheex- Model’sPerformanceandAssessingCoolMaterialsandUrbanVegetationApplications-
ploitationofrenewableenergysourcesfordesigninterventionsintheearlydesign
phases.Energy&Buildings175,235–256.https://doi.org/10.1016/j.enbuild.2018.06.066. AReview. https://doi.org/10.1016/j.scs.2018.08.009.
UN,2019.WorldUrbanizationProspects:The2018Revision,WorldUrbanizationPros-
Mahmoud,A.H.A.,2011.Analysisofthemicroclimaticandhumancomfortconditionsin
pects:The2018Revision. https://doi.org/10.18356/b9e995fe-en.
anurbanparkinhotandaridregions.Build.Environ.46,2641–2656.https://doi.
WesternRegionalClimateCenter,2020.HistoricalClimateInformation.URLhttps://wrcc.
org/10.1016/j.buildenv.2011.06.025.
dri.edu/cgi-bin/cliMAIN.pl?az8499(accessedJuly7,2020).
Matzarakis,A.,Rutz,F.,Mayer,H.,2007.Modellingradiationfluxesinsimpleandcomplex Willmott,C.J.,1981.Onthevalidationofmodels.Phys.Geogr.2(2),184–194.https://doi.
environments-applicationoftheRayManmodel.Int.J.Biometeorol.51,323–334.
org/10.1080/02723646.1981.10642213.
https://doi.org/10.1007/s00484-006-0061-8. Yahia,M.W.,Johansson,E.,2013.Influenceofurbanplanningregulationsonthemicrocli-
Matzarakis,A.,Rutz,F.,Mayer,H.,2010.Modellingradiationfluxesinsimpleandcomplex
mateinahotdryclimate:theexampleofDamascus,Syria.J.HousingBuiltEnviron.
environments:basicsoftheRayManmodel.Int.J.Biometeorol.54,131–139.https:// 28,51–65.https://doi.org/10.1007/s10901-012-9280-y.
doi.org/10.1007/s00484-009-0261-0. Zhang,L.,Zhan,Q.,Lan,Y.,2018.Effectsofthetreedistributionandspeciesonout-
Mayer,H.,Höppe,P.,1987.Thermalcomfortofmanindifferenturbanenvironments. doorenvironmentconditionsinahotsummerandcoldwinterzone:acase
Theor.Appl.Climatol.38,43–49.https://doi.org/10.1007/BF00866252. studyinWuhanresidentialquarters.Build.Environ.130,27–39.https://doi.
Mayer,H.,Holst,J.,Dostal,P.,Imbery,F.,Schindler,D.,2008.Humanthermalcomfortin org/10.1016/j.buildenv.2017.12.014.
summerwithinanurbanstreetcanyoninCentralEurope.Meteorol.Z.,241–250 Zhao,T.F.,Fong,K.F.,2017.Characterizationofdifferentheatmitigationstrategiesinland-
https://doi.org/10.1127/0941-2948/2008/0285. scapetofightagainstheatislandandimprovethermalcomfortinhot-humidclimate
Middel,A.,Krayenhoff,E.S.,2019.Micrometeorologicaldeterminantsofpedestrianthermal (partII):evaluationandcharacterization.Sustain.CitiesSoc.35,841–850.https://doi.
exposureduringrecord-breakingheatinTempe,Arizona:introducingtheMaRTyobser- org/10.1016/j.scs.2017.05.006.
vationalplatform.Sci.TotalEnviron.https://doi.org/10.1016/j.scitotenv.2019.06.085. Zölch,T.,Maderspacher,J.,Wamsler,C.,Pauleit,S.,2016.Usinggreeninfrastructurefor
Middel,A.,Hab,K.,Brazel,A.J.,Martin,C.A.,Guhathakurta,S.,2014.Impactofurbanform urbanclimate-proofing:anevaluationofheatmitigationmeasuresatthemicro-
anddesignonmid-afternoonmicroclimateinPhoenixlocalclimatezones.Landsc. scale.UrbanForestryandUrbanGreening20,305–316.https://doi.org/10.1016/j.
UrbanPlan.122,16–28.https://doi.org/10.1016/j.landurbplan.2013.11.004. ufug.2016.09.011.
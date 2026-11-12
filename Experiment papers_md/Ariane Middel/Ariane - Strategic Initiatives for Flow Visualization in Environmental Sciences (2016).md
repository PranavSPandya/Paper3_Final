WorkshoponVisualisationinEnvironmentalSciences(EnvirVis)(2016) ShortPaper
A.Middel,K.Rink,andD.Zeckzer(Editors)
|     |     |     | Strategic |     | Initiatives |               |     | for Flow | Visualization |     |     |     |     |     |
| --- | --- | --- | --------- | --- | ----------- | ------------- | --- | -------- | ------------- | --- | --- | --- | --- | --- |
|     |     |     |           |     | in          | Environmental |     | Sciences |               |     |     |     |     |     |
RoxanaBujack1andArianeMiddel2
1TechnicalUniversityKaiserslautern,Germany
2ArizonaStateUniversity,USA
Abstract
Flowplaysabigroleintheenvironmentalsciences,buttherearemajordifferencesbetweentheoreticallyavailableandpracti-
callyappliedvisualizationtechniques.Thispapersurveysvarioustechniquesincomputationalandenvironmentalflowvisual-
ization,identifieschallenges,andsuggestsstrategicinitiativesonhowtobridgethegap.
1. Introduction surfaces [MLZ09,KGJ09]. Emphasis on divergence is well pro-
videdbyflowpolygons[SVL91]orflowvolumes[MBC93],which
| Flow plays | an important |     | role in | environmental |     | sciences, | because |     |     |     |     |     |     |     |
| ---------- | ------------ | --- | ------- | ------------- | --- | --------- | ------- | --- | --- | --- | --- | --- | --- | --- |
copyexperimentalsmokeadvection.
| many of   | the Earth’s | physical |          | and biological     |     | processes | involve  |     |     |     |     |     |     |     |
| --------- | ----------- | -------- | -------- | ------------------ | --- | --------- | -------- | --- | --- | --- | --- | --- | --- | --- |
| movement. | In computer |          | science, | flow visualization |     | is a      | well es- |     |     |     |     |     |     |     |
tablishedresearchfieldthatprovidesavarietyofmethodsandal-
gorithmsthatallowahumantoseeandunderstandthemotionof
water,air,orparticles.Yet,agapexistsbetweenthetoolsthathave
| been proposed |     | in flow visualization |     | and | those | that have | actually |     |     |     |     |     |     |     |
| ------------- | --- | --------------------- | --- | --- | ----- | --------- | -------- | --- | --- | --- | --- | --- | --- | --- |
beenappliedtorealworldproblemsbydomainexpertsinenviron-
| mental sciences. |     | In this       | paper,  | we investigate | the     | differences | be-     |                   |     |               |     |                 |     |                  |
| ---------------- | --- | ------------- | ------- | -------------- | ------- | ----------- | ------- | ----------------- | --- | ------------- | --- | --------------- | --- | ---------------- |
|                  |     |               |         |                |         |             |         | (a)Ill.str.lines. |     | (b)Str.tubes. |     | (c)Str.ribbons. |     | (d)Str.surfaces. |
| tween these      | two | theoretically | closely | related        | fields, | point       | out po- |                   |     |               |     |                 |     |                  |
tentialreasonsforthegap,andsuggestsolutionstobridgeit. Figure1:Differentstreamline-basedgeometrictechniquesapplied
toanexample3Dflowfieldofswirlingbehavior.
2. FlowVisualization
|     |     |     |     |     |     |     |     | Texture-Based |     | Techniques. | Dense | and | texture-based | techniques |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | --- | ----------- | ----- | --- | ------------- | ---------- |
areverypopularforthevisualizationof2Dflowfields[LHD∗04,
| Flow visualization |     | is the | science | of making |     | flow fields | visible |     |     |     |     |     |     |     |
| ------------------ | --- | ------ | ------- | --------- | --- | ----------- | ------- | --- | --- | --- | --- | --- | --- | --- |
[HJ05]. It is older than scientific computing [SL00,Mer12], but EGL∗06,NW13].Theycoverthewholedomaindenselybytrans-
theuseofcomputershasleverageditintoanewera,onwhichwe forming a texture along the flow and are inspired by the experi-
willfocus.Openlyavailableprograms,likeParaView[AGL∗05]or mental flow visualization technique where oil is applied to parts
VisIt[CBW∗12],providemanyflowvisualizationtechniques.Even
|     |     |     |     |     |     |     |     | in the wind | tunnel | to form | schlieren. | The | first such | method in- |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------- | ------ | ------- | ---------- | --- | ---------- | ---------- |
thoughthereareoverlaps,theycanbestructuredintothefollowing troducedwasspotnoise[VW91],whereasetofspotsareplaced
categories. on the domain and smeared in flow direction, Fig. 2a. Line inte-
gralconvolution(LIC)[CL93]isasimilartechnique,Fig.2b.In-
| Geometric          | Techniques. |           | Some | of the most | popular      | flow        | visual- |            |          |               |             |         |                   |               |
| ------------------ | ----------- | --------- | ---- | ----------- | ------------ | ----------- | ------- | ---------- | -------- | ------------- | ----------- | ------- | ----------------- | ------------- |
|                    |             |           |      |             |              |             |         | stead of   | a finite | set of spots, | a dense     | texture | is used           | as a starting |
| ization techniques |             | fall into | the  | category    | of geometric | techniques, |         |            |          |               |             |         |                   |               |
|                    |             |           |      |             |              |             |         | point. The | output   | texture       | is produced | by      | a one-dimensional | con-          |
Fig.1.Here,geometricobjectssuchascurves,surfaces,andvol-
volutionoftheinputtexturealongthestreamlinepassingthrough
| umes, are | built        | from seeding | and           | advecting | massless       | particles | to      |          |        |             |             |     |                   |       |
| --------- | ------------ | ------------ | ------------- | --------- | -------------- | --------- | ------- | -------- | ------ | ----------- | ----------- | --- | ----------------- | ----- |
|           |              |              |               |           |                |           |         | a pixel. | Follow | up research | generalizes |     | these fundamental | tech- |
| represent | the behavior | of           | the underling |           | flow [MLP∗09]. |           | The ba- |          |        |             |             |     |                   |       |
niquestobetterencodeorientation[WG97],avarietyofinputtex-
| sic curves | that | form the | foundation | of  | the geometric | objects | are |     |     |     |     |     |     |     |
| ---------- | ---- | -------- | ---------- | --- | ------------- | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
tures[KB96],surfaces[FC95],3Dflowfields[IG97],time-varying
| stream, path, | streak, | and | time | lines [BS85]. | Instead | of  | visualiz- |     |     |     |     |     |     |     |
| ------------- | ------- | --- | ---- | ------------- | ------- | --- | --------- | --- | --- | --- | --- | --- | --- | --- |
flowdata[SK97],andmoreefficientcalculation[SH95].Still,the
| ing the flow | simply | as lines, | the | curves | can be | colored | and illu- |     |     |     |     |     |     |     |
| ------------ | ------ | --------- | --- | ------ | ------ | ------- | --------- | --- | --- | --- | --- | --- | --- | --- |
mainapplicationremainstobe2Dsteadyflowbecauseofthein-
| minated | [ZSH96] | and drawn | in  | the shape | of tubes | or ribbons | to  |     |     |     |     |     |     |     |
| ------- | ------- | --------- | --- | --------- | -------- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- |
ducedclutterofadensevisualizationtechnique.
encodeadditionalinformation,e.g.rotation,divergence,orveloc-
ity[USM96].Concatenationofthebasiclinesseededalongastart- Topology-Based Techniques. Vector field topology [HH89] sep-
ingcurveresultsinstreamsurfaces[Hul92],path,time,orstreak arates the domain into areas in which all flow parcels have the
(cid:13)c 2016TheAuthor(s)
| EurographicsProceedings(cid:13)c |     | 2016TheEurographicsAssociation. |     |     |     |     |     |     |     |     |     |     |     |     |
| -------------------------------- | --- | ------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
DOI: 10.2312/envirvis.20161103

24 R. Bujack & A. Middel / Strategic Initiatives for Flow Visualization
(a)Notenough. (b)Featurebased. (c)Toomany.
Figure3:Featurebasedseedingofstreamlinesinregionsofvortical
behavior(b)vsequidistantseeding(a),(c).
(a)Spotnoise. (b)LIC.
basedtechniques[SJWS08],illustrativetechniques[BCP∗12],vi-
sualizationbasedonglyphs[PPVWS95,WPL96],Fig.2d,orvisu-
alizationofderivedscalarquantities(e.g.velocitymagnitude,vor-
ticity,finite-timeLjapunovexponent,[HY00]).
3. EnvironmentalFlowVisualization
Environmentalscienceis,bynature,aninterdisciplinaryfield,com-
biningphysical,biological,andinformationsciencestostudyen-
vironmental systems. Based on our literature review, we grouped
environmentalresearchintothreecategories:(1)atmosphericsci-
(c)Topology. (d)Glyphs.
ence;(2)ecology;and(3)geosciences.Thefollowingparagraphs
Figure2:Differenttechniquesappliedtoanexample2Dflowfield reviewexamplesofapplicationsineachcategorythatinvolvetime
withasource,asaddle,andasink. andspacedependentmovementdataappropriateforflowvisualiza-
tion.
same origin and destination, Fig. 2c. The topological skeleton Atmospheric Science. Predominant atmospheric variables that
consists of critical points (the positions that have zero veloc- pertain to flow are air and water, usually retrieved through CFD
ity) and separatrices (their one-dimensional invariant manifolds) simulations.Windyty[win16]isaweb-basedwindforecastingand
[PVH∗03,LHZP07].Thedifferentflowpatternsofvectorfieldcrit- visualization tool that maps wind direction and speed in Google
icalpointscanbecategorizedintosaddles,sinks,sources,andvor- Mapsusingabackgroundimage,color-codedbyvelocity,Fig.4b.
tices by the eigenvalues of their Jacobian [PC87]. It has become Atasmallerspatialscale,[LPA11]conductedlarge-eddysimula-
animportantcomponentofflowvisualization,becauseitcontains tionsofwindfarmsandmappedsimulatedwindvelocitiesascolor-
the important features of a vector field in a highly compressed coded maps. They also provided contours of the time-averaged
representation [HH89]. Extensions have been made to the detec- stream-wise velocity and turbulence intensity as color-coded iso-
tion of higher order critical points [SHK∗97], separation and at- lines. [VHB10] illustrated microscale wind flow as color-coded
tachment lines [KHL99], closed streamlines [WS01], 3D vector contours of velocity magnitude in four horizontal planes, while
fields [WTS∗05], and Galilean invariance [BHJ16]. It is also a [MHB∗14]displayedCFDmodelingresultsforwindusingarrows
means for flow field decomposition, simplification [TSH00], and on a heat map, Fig. 4c. Another study investigated the impact of
design[The02].Currently,themainchallengeliesingeneralizing verticalwindshearonthepredictabilityoftropicalcyclonesvisu-
flowtopologytotimevaryingdata[PPF∗11]. alizing wind as arrows [ZT13]. Air quality assessment is another
applicationareaforflowvisualization,asitisconcernedwithpol-
Feature-Based Techniques. Most flow visualization techniques
lutantdispersionthroughwind.In[GZCL11],arrowsareusedas
produce great results when applied to 2D fields, but fail in the
velocityvectorstodisplayair-flowinurbanstreetcanyons.Model-
3D case due to clutter, because each drawn object occludes ev-
ingandanalyzingwindflowisalsoimportanttoassesstheimpact
erythinglocatedbehindit,Fig.3.Featurebasedtechniquesreduce
ofhurricanesandtsunamis[PMD∗10,JS10,DBW∗10].
the amount of visualization elements to the important areas of a
flow field [PVH∗03,EGL∗06]. This selection process can be im- Ecology.Thepredominantapplicationofflowvisualizationinecol-
posed to all the techniques mentioned earlier. Specific detectors ogyisanimalmigration.Inarecentreview,varioustrackingtech-
havebeentayloredtoidentifythemosttypicalflowfeatures,like niquesformigratorybirdswerepresented,rangingfromGPStrack-
vortices[Rot00],theelementsoftheflowtopology[LHZP07],or ingtogeologgers[BTB∗11].Whilebirdtrackingtechniqueswere
shockwaves[WXWH13].Formoregeneralpurposes,vectorfield diverse, the presented migration visualizations were limited to a
patterndetectionalgorithms[Ebl06,Sch11,BHSH15,WSW16]al- GoogleEarthoverlayofmigrationpathsanda2Dviewofdotted
lowtheextractionofuserdefinedfeatures. linesonaradarimage.Otherapplicationsusedlinesona2Dmap,
color-codedbybirdindividuals[ESP∗10,SBvLP∗11].
FurtherTechniques.Thereareotherflowvisualizationtechniques
that can be considered as their own category, such as partition- Geosciences. Ocean flow simulation and analysis are crucial for
(cid:13)c 2016TheAuthor(s)
EurographicsProceedings(cid:13)c 2016TheEurographicsAssociation.

R. Bujack & A. Middel / Strategic Initiatives for Flow Visualization 25
(a)OkuboWeiss.
(a)ImagecourtesyofL.Treinish[Tre93].
(b)WindforecastinginWindity[win16]. (c)ENVI-met[MHB∗14].
(b)Kineticenergy.
Figure4:Winddirectionandvelocitymappingapplications.
Figure 5: Ocean visualization by color coding of derived scalar
assessing environmental hazards, such as oil spills and sea trash. fields.ImagescourtesyofF.Samsel,M.Petersen,G.Abramwith
Previous research has predominantly used color-coding [MM98, MPAS-Ocean,COSIM,LANL[WPS∗16].
Ain99,WPS∗16]andiso-lines[Sch02]tovisualizeoceanflow,Fig.
5.Forcoastalcities,floodingofurbanareaswasvisualizedusing
photo-realistic animations to explain impacts of sea level rise to averages;instantaneousflowpatternsbecomesecondary.Environ-
decision-makersandthegeneralpublic[GSH∗15].Arecentstudy
mentalscientistsalsohavetoaddressabroader,non-expertaudi-
presentedOpenGeosys,atooltovisualizegeothermalenergyand encetocommunicatetheirfindings,yieldingmorecolorful,catchy,
groundwaterusingstreamlinesandarrowglyphs[KBB∗12].Flow
simplified, and sometimes animated visualizations and so far, we
visualizationhasalsobeenusedtoillustrateglacierretreat[Kau12] seefeweremphasisonanimationandvisualanalyticsinflowvisu-
andvolcanoes[SYM14]. alization[KMS∗08].
In our opinion, the demand for sparsity in comparative envi-
4. BridgingtheGap
ronmental visualization could be well satisfied by using feature
Ourliteraturereviewsuggeststhatenvironmentalscientistsgener- based techniques and vector field topology. Environmental scien-
allyusebasicflowvisualizationtechniques;atmosphericdataare tistswouldbenefitfromimplementationsthatconnecttotheirdata
mappedascolor-codedderivedscalarfieldsorarrows,Fig.4aand formatsandcaneasilybeincorporatedintoexistingtoolsthescien-
Fig.4c,whileecologistspreferstreamlinestovisualizeanimalmi- tistsdependon.Interactionmightbedifficulttoachieveduetothe
grationdata.Thegapbetweenavailableflowvisualizationmethods sizeofthedatasets,butGPU-basedtechniques,highperformance
andtheirapplicationseemstobesmallestingeosciences,particu- computing,andscientificcomputingcouldoffersolutions.
larlyoceanflows.Inallthreeareas,highervisualizationelements,
likesurfacesandvolumes,featurebasedapproaches,ortopology
arehardlyused.Weseethefollowingreasonsforthisgap. 5. Conclusion
While fluid dynamics analysts often concentrate on relatively Wefoundthatthetwoseeminglysimilarfieldsofflowvisualiza-
small,containedproblems,environmentalscientistsdealwithbig, tionandenvironmentalflowvisualizationaremoredifferentthan
complex data sets from various sources in different formats. The expected. In environmental sciences, flow is almost always only
data sets exhibit complex boundaries, are multidimensional, or visualized bybasic techniques, like arrowglyphs, streamlines, or
stemfromobservationsthataretoosparseforhighervisualization colorcodingofthevelocitymagnitude.Thisgapismainlybased
elements.Forbigdataproblems,environmentalscientistsoftenfo- onthedemandsofenvironmentalsciencesforsparse,catchy,and
cusonthecomparisonofdifferentparametersandvariables,sothe simplifiedvisualizationsthatrunfastonbigdatasetsandareeasyto
flowitselfisvisualizedsparselytosharespacewithothervariables integrateintoexistingenvironments.Inthefutureitcanbebridged
(e.g.,rain,snow,temperature)andtopographicfeatures(e.g.,rivers, ifflowvisualizationinvestigatesviewsinwhichtheimmediateflow
administrativeboundaries).Often,environmentaldatasetsareana- may play a subordinate role and the environmental sciences con-
lyzedwithrespecttolongtermcorrelations,longitudinaltrends,or siderfeature-basedandtopologicalmethods.
(cid:13)c 2016TheAuthor(s)
EurographicsProceedings(cid:13)c 2016TheEurographicsAssociation.

26 R. Bujack & A. Middel / Strategic Initiatives for Flow Visualization
| Ackknowledgements |     |     |     |     |     |     | [GSH∗15] |     |     |     |     |     |
| ----------------- | --- | --- | --- | --- | --- | --- | -------- | --- | --- | --- | --- | --- |
GROTTELS.,STAIBJ.,HEYERT.,VETTERB.,GUMHOLD
S.: Real-TimeVisualizationofUrbanFloodSimulationDataforNon-
ThisresearchwaspartlyfundedbytheGermanResearchFounda- Professionals. InWorkshoponVisualisationinEnvironmentalSciences
tion(DFG)aspartofthetheIRTG2057"PhysicalModelingfor (EnvirVis)(2015),MiddelA.,RinkK.,WeberG.H.,(Eds.),TheEuro-
VirtualManufacturingSystemsandProcesses". graphicsAssociation.3
|     |     |     |     |     |     |     | [GZCL11] | GU Z.-L., ZHANG | Y.-W., | CHENG | Y., LEE S.-C.: | Effect |
| --- | --- | --- | --- | --- | --- | --- | -------- | --------------- | ------ | ----- | -------------- | ------ |
ofunevenbuildinglayoutonairflowandpollutantdispersioninnon-
References
uniformstreetcanyons.BuildingandEnvironment46,12(2011),2657–
| [AGL∗05] | AHRENS | J., GEVECI | B., | LAW C., | HANSEN C., | JOHNSON | 2665.2 |     |     |     |     |     |
| -------- | ------ | ---------- | --- | ------- | ---------- | ------- | ------ | --- | --- | --- | --- | --- |
C.:36-paraview:Anend-usertoolforlarge-datavisualization,2005.1 [HH89] HELMANJ.,HESSELINKL.:Representationanddisplayofvec-
[Ain99] AINSWORTH E.: Visualization of ocean colour and tempera- torfieldtopologyinfluidflowdatasets. Computer22,8(1989),27–36.
| turefrommulti-spectralimagerycapturedbythejapaneseadeossatellite. |     |     |     |     |     |     | 1,2 |     |     |     |     |     |
| ----------------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
JournalofVisualization2,2(1999),195–204.3 [HJ05] HANSENC.,JOHNSONC.:TheVisualizationHandbook.Referex
[BCP∗12] BRAMBILLA A., CARNECKY R., PEIKERT R., VIOLA I., Engineering.Butterworth-Heinemann,2005.1
| HAUSER | H.: | IllustrativeFlowVisualization:StateoftheArt,Trends |     |     |     |     |                   |        |              |        |             |           |
| ------ | --- | -------------------------------------------------- | --- | --- | --- | --- | ----------------- | ------ | ------------ | ------ | ----------- | --------- |
|        |     |                                                    |     |     |     |     | [Hul92] HULTQUIST | J. P.: | Constructing | stream | surfaces in | steady 3d |
andChallenges.EG2012StateoftheArtReports(2012),75–94.2
|     |     |     |     |     |     |     | vectorfields. | InProceedingsofthe3rdconferenceonVisualization’92 |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------------- | ------------------------------------------------- | --- | --- | --- | --- |
(1992),IEEEComputerSocietyPress,pp.171–178.1
[BHJ16] BUJACKR.,HLAWITSCHKAM.,JOYK.I.:Topology-Inspired
| GalileanInvariantVectorFieldAnalysis. |     |     |     | Inacceptedforpublicationat |     |     |     |     |     |     |     |     |
| ------------------------------------- | --- | --- | --- | -------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
[HY00] HALLERG.,YUANG.:Lagrangiancoherentstructuresandmix-
IEEEPacificVisualizationSymposium,PacificVis2016inTaipei,Taiwan
|                                                        |                                            |               |     |          |                 |       | ingintwo-dimensionalturbulence. |     |                                   | Phys.D147,3-4(2000),352–370.    |     |     |
| ------------------------------------------------------ | ------------------------------------------ | ------------- | --- | -------- | --------------- | ----- | ------------------------------- | --- | --------------------------------- | ------------------------------- | --- | --- |
| (2016).2                                               |                                            |               |     |          |                 |       | 2                               |     |                                   |                                 |     |     |
| [BHSH15]                                               | BUJACKR.,HOTZI.,SCHEUERMANNG.,HITZERE.:Mo- |               |     |          |                 |       |                                 |     |                                   |                                 |     |     |
|                                                        |                                            |               |     |          |                 |       | [IG97] INTERRANTEV.,GROSCHC.:   |     |                                   | Strategiesforeffectivelyvisual- |     |     |
| mentInvariantsfor2DFlowFieldsviaNormalizationinDetail. |                                            |               |     |          |                 | IEEE  |                                 |     |                                   |                                 |     |     |
|                                                        |                                            |               |     |          |                 |       | izing3dflowwithvolumelic.       |     | InProceedingsofthe8thconferenceon |                                 |     |     |
| Transactions                                           | on                                         | Visualization | and | Computer | Graphics (TVCG) | 21, 8 |                                 |     |                                   |                                 |     |     |
Visualization’97(1997),IEEEComputerSocietyPress,pp.421–ff.1
(2015),916–929.2
|               |        |                 |        |                                |                 |        | [JS10] JAIMESB.,SHAYL.K.: |                     | Near-inertialwavewakeofhurricanes |         |         |             |
| ------------- | ------ | --------------- | ------ | ------------------------------ | --------------- | ------ | ------------------------- | ------------------- | --------------------------------- | ------- | ------- | ----------- |
| [BS85]        | BUNING | P., STEGER      | J. L.: | Graphicsandflowvisualizationin |                 |        |                           |                     |                                   |         |         |             |
|               |        |                 |        |                                |                 |        | katrina and               | rita over mesoscale | oceanic                           | eddies. | Journal | of Physical |
| computational |        | fluid dynamics. | In     | Proceedings                    | of the American | Insti- |                           |                     |                                   |         |         |             |
Oceanography40,6(2010),1320–1337.2
tuteofAeronauticsandAstronautics8thComputationalFluidDynamics
[Kau12] KAUFMANNV.:Theevolutionofrockglaciermonitoringusing
Conference(1985),p.814?820.1
terrestrialphotogrammetry:theexampleofäussereshochebenkarrock
| [BTB∗11] | BRIDGEE.S.,THORUPK.,BOWLINM.S.,CHILSONP.B., |           |           |     |                |        |                   |                                               |     |     |     |     |
| -------- | ------------------------------------------- | --------- | --------- | --- | -------------- | ------ | ----------------- | --------------------------------------------- | --- | --- | --- | --- |
|          |                                             |           |           |     |                |        | glacier(austria). | AustrianJournalofEarthSciences105,2(2012),63– |     |     |     |     |
| DIEHL    | R. H.,                                      | FLÉRON R. | W., HARTL | P., | KAYS R., KELLY | J. F., |                   |                                               |     |     |     |     |
77.3
| ROBINSON | W.  | D.: Technologyonthemove:recentandforthcoming |     |     |     |     |     |     |     |     |     |     |
| -------- | --- | -------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
innovationsfortrackingmigratorybirds. BioScience61,9(2011),689– [KB96] KIUM.-H.,BANKSD.C.:Multi-frequencynoiseforlic.InPro-
698.2 ceedingsofthe7thConferenceonVisualization’96(1996),IEEECom-
| [CBW∗12] |             |             |        |              |              |     | puterSocietyPress,pp.121–126.1 |                                            |     |     |     |     |
| -------- | ----------- | ----------- | ------ | ------------ | ------------ | --- | ------------------------------ | ------------------------------------------ | --- | --- | --- | --- |
|          | CHILDS      | H., BRUGGER |        | E., WHITLOCK | B., MEREDITH | J., |                                |                                            |     |     |     |     |
|          |             |             |        |              |              |     | [KBB∗12]                       | KOLDITZO.,BAUERS.,BILKEL.,BÖTTCHERN.,DELFS |     |     |     |     |
| AHERN    | S., PUGMIRE | D.,         | BIAGAS | K., MILLER   | M., HARRISON | C., |                                |                                            |     |     |     |     |
WEBER G. H., KRISHNAN H., FOGAL T., SANDERSON A., GARTH J.-O.,FISCHERT.,GÖRKEU.J.,KALBACHERT.,KOSAKOWSKIG.,
C.,BETHELE.W.,CAMPD.,RÜBELO.,DURANTM.,FAVREJ.M., MCDERMOTTC.,ETAL.:Opengeosys:anopen-sourceinitiativefornu-
NAVRÁTILP.: VisIt:AnEnd-UserToolForVisualizingandAnalyzing merical simulation of thermo-hydro-mechanical/chemical (thm/c) pro-
VeryLargeData.InHighPerformanceVisualization–EnablingExtreme- cesses in porous media. Environmental Earth Sciences 67, 2 (2012),
| ScaleScientificInsight.Oct2012,pp.357–372.1 |     |     |     |     |     |     | 589–599.3 |     |     |     |     |     |
| ------------------------------------------- | --- | --- | --- | --- | --- | --- | --------- | --- | --- | --- | --- | --- |
[CL93] CABRAL B., LEEDOM L. C.: Imagingvectorfieldsusingline [KGJ09] KRISHNANH.,GARTHC.,JOYK.: TimeandStreakSurfaces
integralconvolution. InProceedingsofthe20thannualconferenceon forFlowVisualizationinLargeTime-VaryingDataSets.IEEETransac-
tionsonVisualizationandComputerGraphics15,6(2009),1267–1274.
Computergraphicsandinteractivetechniques(1993),SIGGRAPH’93,
| ACM,pp.263–270.1 |     |     |     |     |     |     | 1   |     |     |     |     |     |
| ---------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
[DBW∗10] DIETRICHJ.C.,BUNYAS.,WESTERINKJ.J.,EBERSOLE [KHL99] KENWRIGHTD.,HENZEC.,LEVITC.:FeatureExtractionof
B.A.,SMITHJ.M.,ATKINSONJ.H.,JENSENR.,RESIOD.T.,LUET- SeparationandAttachmentLines. VisualizationandComputerGraph-
TICHR.A.,DAWSONC.:Ahigh-resolutioncoupledriverineflow,tide, ics,IEEETransactionson5,2(1999),135–144.2
wind,windwave,andstormsurgemodelforsouthernlouisianaandmis-
|     |     |     |     |     |     |     | [KMS∗08] | KEIMD.A.,MANSMANNF.,SCHNEIDEWINDJ.,THOMAS |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | -------- | ----------------------------------------- | --- | --- | --- | --- |
sissippi.partII:Synopticdescriptionandanalysisofhurricaneskatrina
J.,ZIEGLERH.:Visualanalytics:Scopeandchallenges.Springer,2008.
andrita.MonthlyWeatherReview138,2(2010),378–404.2
3
[Ebl06] EBLINGJ.:VisualizationandAnalysisofFlowFieldsusingClif-
|                  |     |                                             |     |     |     |     | [LHD∗04] | LARAMEER.S.,HAUSERH.,DOLEISCHH.,VROLIJKB., |     |     |     |     |
| ---------------- | --- | ------------------------------------------- | --- | --- | --- | --- | -------- | ------------------------------------------ | --- | --- | --- | --- |
| fordConvolution. |     | PhDthesis,UniversityofLeipzig,Germany,2006. |     |     |     |     |          |                                            |     |     |     |     |
POSTF.H.,WEISKOPFD.:TheStateoftheArtinFlowVisualization:
2
|          |                                             |     |     |     |     |     | DenseandTexture-BasedTechniques. |     |     | ComputerGraphicsForum23 |     |     |
| -------- | ------------------------------------------- | --- | --- | --- | --- | --- | -------------------------------- | --- | --- | ----------------------- | --- | --- |
| [EGL∗06] | ERLEBACHERG.,GARTHC.,LARAMEER.S.,THEISELH., |     |     |     |     |     |                                  |     |     |                         |     |     |
(2004),2004.1
| TRICOCHE                                          | X., | WEINKAUF | T., WEISKOPF |     | D.: TextureandFeature- |     |                                                   |            |            |     |               |        |
| ------------------------------------------------- | --- | -------- | ------------ | --- | ---------------------- | --- | ------------------------------------------------- | ---------- | ---------- | --- | ------------- | ------ |
|                                                   |     |          |              |     |                        |     | [LHZP07]                                          | LARAMEE R. | S., HAUSER | H., | ZHAO L., POST | F. H.: |
| BasedFlowVisualization-MethodologyandApplication. |     |          |              |     | InIEEEVi-              |     |                                                   |            |            |     |               |        |
|                                                   |     |          |              |     |                        |     | Topology-BasedFlowVisualization,TheStateoftheArt. |            |            |     | InTopology-   |        |
sualizationTutorial(2006).1,2
basedMethodsinVisualization(2007),pp.1–19.2
| [ESP∗10] | EGEVANGC.,STENHOUSEI.J.,PHILLIPSR.A.,PETERSEN |     |     |     |     |     |     |     |     |     |     |     |
| -------- | --------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
[LPA11] LUH.,PORTÉ-AGELF.:Large-eddysimulationofaverylarge
| A.,FOXJ.W.,SILKJ.R.:           |     |     | Trackingofarcticternssternaparadisaea |     |     |     |           |                         |     |          |                |           |
| ------------------------------ | --- | --- | ------------------------------------- | --- | --- | --- | --------- | ----------------------- | --- | -------- | -------------- | --------- |
|                                |     |     |                                       |     |     |     | wind farm | in a stable atmospheric |     | boundary | layer. Physics | of Fluids |
| revealslongestanimalmigration. |     |     | ProceedingsoftheNationalAcademy       |     |     |     |           |                         |     |          |                |           |
(1994-present)23,6(2011),065101.2
ofSciences107,5(2010),2078–2081.2
|     |     |     |     |     |     |     | [MBC93] | MAXN.,BECKERB.,CRAWFISR.: |     |     | Flowvolumesforinter- |     |
| --- | --- | --- | --- | --- | --- | --- | ------- | ------------------------- | --- | --- | -------------------- | --- |
[FC95] FORSSELLL.K.,COHENS.D.:Usinglineintegralconvolution
activevectorfieldvisualization.InProceedingsofthe4thconferenceon
forflowvisualization:Curvilineargrids,variable-speedanimation,and
Visualization’93(1993),IEEEComputerSociety,pp.19–24.1
| unsteadyflows. |     | VisualizationandComputerGraphics,IEEETransac- |     |     |     |     |     |     |     |     |     |     |
| -------------- | --- | --------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
tionson1,2(1995),133–141.1 MERZKIRCHW.:Flowvisualization.Elsevier,2012.1
[Mer12]
(cid:13)c 2016TheAuthor(s)
|     |     |     |     |     |     |     |     | EurographicsProceedings(cid:13)c |     | 2016TheEurographicsAssociation. |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------------------------- | --- | ------------------------------- | --- | --- |

R. Bujack & A. Middel / Strategic Initiatives for Flow Visualization 27
[MHB∗14]
MIDDEL A., HÄB K., BRAZEL A. J., MARTIN C. A., [SK97] SHENH.-W.,KAOD.L.: Uflic:alineintegralconvolutional-
GUHATHAKURTAS.:Impactofurbanformanddesignonmid-afternoon gorithmforvisualizingunsteadyflows.InProc.ofthe8thconferenceon
microclimate in phoenix local climate zones. Landscape and Urban Visualization’97(1997),IEEEComputerSocietyPress,pp.317–ff.1
Planning122(2014),16–28.2,3
|          |            |     |     |         |     |             |          | [SL00] SMITSA.J.,LIMT.T.:                   | FlowVisualizationTechniquesandEx- |     |     |     |
| -------- | ---------- | --- | --- | ------- | --- | ----------- | -------- | ------------------------------------------- | --------------------------------- | --- | --- | --- |
| [MLP∗09] |            |     |     |         |     |             |          | amples.ImperilCollegePress,London,UK,2000.1 |                                   |     |     |     |
|          | MCLOUGHLIN |     | T., | LARAMEE | R.  | S., PEIKERT | R., POST |                                             |                                   |     |     |     |
F. H., CHEN M.: OverTwo DecadesofIntegration-Based,Geomet- [SVL91] SCHROEDER W. J., VOLPE C. R., LORENSEN W. E.: The
| ricFlowVisualization. |     |     | InEG2009-StateoftheArtReports(2009), |     |     |     |     |                                                        |     |     |     |        |
| --------------------- | --- | --- | ------------------------------------ | --- | --- | --- | --- | ------------------------------------------------------ | --- | --- | --- | ------ |
|                       |     |     |                                      |     |     |     |     | streampolygon:Atechniquefor3dvectorfieldvisualization. |     |     |     | InPro- |
pp.73–92.1 ceedingsofthe2ndconferenceonVisualization’91(1991),IEEECom-
puterSocietyPress,pp.126–132.1
| [MLZ09] | MCLOUGHLIN |     | T., | LARAMEE | R. S., | ZHANG | E.: Easyinte- |     |     |     |     |     |
| ------- | ---------- | --- | --- | ------- | ------ | ----- | ------------- | --- | --- | --- | --- | --- |
gralsurfaces:afast,quad-basedstreamandpathsurfacealgorithm. In [SYM14] SAUERF.,YUH.,MAK.-L.: Trajectory-basedflowfeature
Proceedingsofthe2009ComputerGraphicsInternationalConference trackinginjointparticle/volumedatasets. VisualizationandComputer
(2009),ACM,pp.73–82.1 Graphics,IEEETransactionson20,12(2014),2565–2574.3
[MM98] MCPHERSON A., MALTRUD M.: Poptex: Interactive ocean [The02] THEISELH.: Designing2dvectorfieldsofarbitrarytopology.
|       |               |     |               |         |           |     |                | In Computer Graphics | Forum (2002), | vol. 21, Wiley | Online | Library, |
| ----- | ------------- | --- | ------------- | ------- | --------- | --- | -------------- | -------------------- | ------------- | -------------- | ------ | -------- |
| model | visualization |     | using texture | mapping | hardware. |     | In Proceedings |                      |               |                |        |          |
pp.595–604.2
oftheconferenceonVisualization’98(1998),IEEEComputerSociety
Press,pp.471–474.3
|     |     |     |     |     |     |     |     | [Tre93] TREINISHL.A.: | Visualizationofstratosphericozonedepletion     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --------------------- | ---------------------------------------------- | --- | --- | --- |
|     |     |     |     |     |     |     |     | andthepolarvortex.    | InVisualization,1993.Visualization’93,Proceed- |     |     |     |
[NW13] NETZELR.,WEISKOPFD.:Texture-BasedFlowVisualization.
ings.,IEEEConferenceon(1993),IEEE,pp.391–396.3
ComputinginScienceandEngineering15,6(2013),96–102.1
|     |     |     |     |     |     |     |     | [TSH00] TRICOCHE | X., SCHEUERMANN | G., HAGEN | H.: | Atopology |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --------------- | --------- | --- | --------- |
[PC87] PERRYA.,CHONGM.: Adescriptionofeddyingmotionsand simplificationmethodfor2dvectorfields. InVisualization2000.Pro-
AnnualReviewofFluidMe-
flowpatternsusingcritical-pointconcepts. ceedings(2000),IEEE,pp.359–366.2
chanics19,1(1987),125–155.2
|     |     |     |     |     |     |     |     | [USM96] UENGS.K.,SIKORSKIC.,MAK.L.: |     |     | Efficientstreamline, |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------------------------------- | --- | --- | -------------------- | --- |
[PMD∗10] POWELL M. D., MURILLO S., DODGE P., UHLHORN E., streamribbon,andstreamtubeconstructionsonunstructuredgrids. Vi-
GAMACHEJ.,CARDONEV.,COXA.,OTEROS.,CARRASCON.,AN- sualizationandComputerGraphics,IEEETransactionson2,2(1996),
| NANE | B.: Reconstructionofhurricanekatrina’swindfieldsforstorm |     |     |     |     |     |     | 100–110.1 |     |     |     |     |
| ---- | -------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --------- | --- | --- | --- | --- |
surgeandwavehindcasting.OceanEngineering37,1(2010),26–36.2
|     |     |     |     |     |     |     |     | [VHB10] VANHOOFFT.,BLOCKENB.: |     | Coupledurbanwindflowand |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------------------------- | --- | ----------------------- | --- | --- |
[PPF∗11] POBITZER A., PEIKERT R., FUCHS R., SCHINDLER B., indoornaturalventilationmodellingonahigh-resolutiongrid:Acase
KUHN A., THEISEL H., MATKOVIC K., HAUSER H.: The State of studyfortheamsterdamArenAstadium. EnvironmentalModelling&
theArtinTopology-basedVisualizationofUnsteadyFlow. Computer Software25,1(2010),51–65.2
GraphicsForum30,6(2011),1789–1811.2 [VW91] VAN WIJK J. J.: Spotnoisetexturesynthesisfordatavisual-
[PPVWS95] POST F. H., POST F. J., VAN WALSUM T., SILVER D.: ization. InACMSiggraphComputerGraphics(1991),vol.25,ACM,
| Iconictechniquesforfeaturevisualization. |     |     |     |     |     | InProceedingsofthe6th |     | pp.309–318.1 |     |     |     |     |
| ---------------------------------------- | --- | --- | --- | --- | --- | --------------------- | --- | ------------ | --- | --- | --- | --- |
conferenceonVisualization’95(1995),IEEEComputerSociety,p.288. [WG97] WEGENKITTLR.,GRÖLLERE.:Fastorientedlineintegralcon-
2 volutionforvectorfieldvisualizationviatheinternet. InProceedingsof
[PVH∗03] the8thconferenceonVisualization’97(1997),IEEEComputerSociety
|     | POST | F. H., | VROLIJK | B., | HAUSER | H., LARAMEE | R. S., |     |     |     |     |     |
| --- | ---- | ------ | ------- | --- | ------ | ----------- | ------ | --- | --- | --- | --- | --- |
DOLEISCHH.: TheStateoftheArtinFlowVisualisation:FeatureEx- Press,pp.309–316.1
tractionandTracking.ComputerGraphicsForum22,4(2003),775–792. [win16] Windyty, SE, wind map & forecast, 2016. URL: https://
| 2   |     |     |     |     |     |     |     | www.windyty.com.2,3 |             |              |     |            |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------- | ----------- | ------------ | --- | ---------- |
|     |     |     |     |     |     |     |     | [WPL96] WITTENBRINK | C. M., PANG | A. T., LODHA | S.  | K.: Glyphs |
[Rot00] ROTHM.:AutomaticExtractionofVortexCoreLinesandOther
Line-Type Features for Scientific Visualization. PhD Dissertation No. forvisualizinguncertaintyinvectorfields. VisualizationandComputer
13673,ETHZurich,2000. publishedbyHartung-GorreVerlag,Kon- Graphics,IEEETransactionson2,3(1996),266–279.2
stanz,ISBN3-89649-582-8.2 [WPS∗16] WOODRINGJ.,PETERSENM.,SCHMEISSERA.,PATCHETT
|            |     |                                           |     |                |     |     |                 | J.,AHRENSJ.,HAGENH.: | Insitueddyanalysisinahigh-resolution |              |           |      |
| ---------- | --- | ----------------------------------------- | --- | -------------- | --- | --- | --------------- | -------------------- | ------------------------------------ | ------------ | --------- | ---- |
| [SBvLP∗11] |     | SHAMOUN-BARANESJ.,VANLOONE.E.,PURVESR.S., |     |                |     |     |                 |                      |                                      |              |           |      |
|            |     |                                           |     |                |     |     |                 | ocean climate        | model. Visualization                 | and Computer | Graphics, | IEEE |
| SPECKMANN  |     | B., WEISKOPF                              |     | D., CAMPHUYSEN |     | C.  | J.: Analysisand |                      |                                      |              |           |      |
visualizationofanimalmovement.Biologyletters(2011).2 Transactionson22,1(2016),857–866.3
|         |           |            |                                           |       |           |               |        | [WS01] WISCHGOLLT.,SCHEUERMANNG.:     |     | Detectionandvisualiza-   |     |     |
| ------- | --------- | ---------- | ----------------------------------------- | ----- | --------- | ------------- | ------ | ------------------------------------- | --- | ------------------------ | --- | --- |
| [Sch02] | SCHLITZER | R.:        | Interactiveanalysisandvisualizationofgeo- |       |           |               |        |                                       |     |                          |     |     |
|         |           |            |                                           |       |           |               |        | tionofclosedstreamlinesinplanarflows. |     | VisualizationandComputer |     |     |
| science | data      | with ocean | data                                      | view. | Computers | & geosciences | 28, 10 |                                       |     |                          |     |     |
Graphics,IEEETransactionson7,2(2001),165–172.2
(2002),1211–1218.3
|     |     |     |     |     |     |     |     | [WSW16] WANGZ.,SEIDELH.-P.,WEINKAUFT.: |     |     | Multi-fieldpattern |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------------------------------- | --- | --- | ------------------ | --- |
PatternRecognitionforFeatureBasedand
[Sch11] SCHLEMMER M.: matchingbasedonsparsefeaturesampling.VisualizationandComputer
ComparativeVisualization.PhDthesis,UniversitätKaiserslautern,Ger-
Graphics,IEEETransactionson22,1(2016),807–816.2
many,2011.2
|     |     |     |     |     |     |     |     | [WTS∗05] WEINKAUFT.,THEISELH.,SHIK.,HEGEH.-C.,SEIDEL |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------------------------------------------- | --- | --- | --- | --- |
[SH95] STALLING D., HEGE H.-C.: Fast and resolution independent H.-P.: ExtractingHigherOrderCriticalPointsandTopologicalSimpli-
line integral convolution. In Proceedings of the 22nd annual confer- ficationof3DVectorFields. InProc.IEEEVisualization2005(Min-
ence on Computer graphics and interactive techniques (1995), ACM, neapolis,U.S.A.,2005),pp.559–566.2
pp.249–256.1
|     |     |     |     |     |     |     |     | [WXWH13] WUZ.,XUY.,WANGW.,HUR.:ReviewofShockWave |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------------------------------------ | --- | --- | --- | --- |
[SHK∗97] SCHEUERMANNG.,HAGENH.,KRÜGERH.,MENZELM., DetectionMethodin{CFD}Post-Processing. ChineseJournalofAero-
nautics26,3(2013),501–513.2
| ROCKWOOD |     | A.: Visualizationofhigherordersingularitiesinvector |     |     |     |     |     |     |     |     |     |     |
| -------- | --- | --------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
fields. InProceedingsofthe8thconferenceonVisualization’97(1997), [ZSH96] ZÖCKLERM.,STALLINGD.,HEGEH.-C.:Interactivevisual-
IEEEComputerSocietyPress,pp.67–74.2
|     |     |     |     |     |     |     |     | izationof3d-vectorfieldsusingilluminatedstreamlines. |     |     |     | InVisualiza- |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------------------------------------------- | --- | --- | --- | ------------ |
tion’96.Proceedings.(1996),IEEE,pp.107–113.1
| [SJWS08] | SALZBRUNN |     | T., JÄNICKE |     | H., WISCHGOLL |     | T., SCHEUER- |     |     |     |     |     |
| -------- | --------- | --- | ----------- | --- | ------------- | --- | ------------ | --- | --- | --- | --- | --- |
MANN.G.: TheStateoftheArtinFlowVisualization:Partition-based [ZT13] ZHANG F., TAO D.: Effectsofverticalwindshearonthepre-
dictabilityoftropicalcyclones.JournaloftheAtmosphericSciences70,
| Techniques. |     | InSimulationandVisualization2008Proceedings(2008). |     |     |     |     |     |     |     |     |     |     |
| ----------- | --- | -------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
3(2013),975–983.2
2
(cid:13)c 2016TheAuthor(s)
| EurographicsProceedings(cid:13)c |     | 2016TheEurographicsAssociation. |     |     |     |     |     |     |     |     |     |     |
| -------------------------------- | --- | ------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
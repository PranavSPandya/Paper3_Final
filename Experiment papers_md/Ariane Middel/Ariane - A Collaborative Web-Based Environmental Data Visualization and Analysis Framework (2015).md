WorkshoponVisualisationinEnvironmentalSciences(EnvirVis)(2015)
A.Middel,G.Weber,andK.Rink(Editors)
|     | A   | Collaborative |     |     | Web-Based |              | Environmental |           |     |     | Data |     |
| --- | --- | ------------- | --- | --- | --------- | ------------ | ------------- | --------- | --- | --- | ---- | --- |
|     |     | Visualization |     |     |           | and Analysis |               | Framework |     |     |      |     |
J.Lukasczyk1,X.Liang2,W.Luo2,E.D.Ragan3,A.Middel2,N.Bliss2,D.White2,H.Hagen1,andR.Maciejewski2
1TUKaiserslautern,Germany 2ArizonaStateUniversity,USA 3OakRidgeNationalLaboratory,USA
Abstract
Wepresentanenvironmentaldatavisualizationframeworkthatfeaturessynchronousandasynchronousmulti-user
interactionwithallthebenefitsofmodernweb-basedapplications,suchaseasyaccessibilityandcross-platform
compatibility.Incontrasttooutdatedweb-basednetworkprotocols,theproposedframeworkusesHTML5Web-
Socketstoenablefull-duplexcommunicationbetweenserverandclients.Todemonstratetheframework,wechose
theecologicalproblemofwaterscarcityinAfrica.Inthiscasestudy,waterscarcityiscalculatedandvisualized
usingvariousmodelsandparameters,whichcaneasilybesharedamongusersanddevices.Hence,weshowthe
potentialandtheutilizationofwebtechnologiesforcollaborativeenvironmentaldataexplorationondistributed
desktopandmobiledevices.
1. Introduction policyplanningandsustainabilitytoexplorepotentialdesign
|     |     |     |     |     |     |     | spaces | that can | facilitate collaborative |     | analysis and | deci- |
| --- | --- | --- | --- | --- | --- | --- | ------ | -------- | ------------------------ | --- | ------------ | ----- |
The coupled effects of global climate change and popula- sionmaking.Whilemuchworkinvisualizationhasfocused
| tion dynamics | on  | water systems |     | are widely | considered | to  |     |     |     |     |     |     |
| ------------- | --- | ------------- | --- | ---------- | ---------- | --- | --- | --- | --- | --- | --- | --- |
oncollaboration[WHHA11,MST12,Rob08,WSM13],there
beamongthegreatesturbansustainabilitychallengesfacing arestillchallenges[IES∗11]rangingfromengagingnewau-
| humanity | in the Anthropocene |     | - an | era that | recognizes | the |     |     |     |     |     |     |
| -------- | ------------------- | --- | ---- | -------- | ---------- | --- | --- | --- | --- | --- | --- | --- |
diencestodevelopinghybridcollaborativeplatforms.
indeliblesignatureandlong-termimpactofhumaninfluence
ontheEarthsystem[VMG∗10].Semiaridandaridregions Our work builds upon the platform of Lukasczyk et al.
willbeatparticularrisk.Meanwhile,theworld’surbanpop- [LMH14], which highlighted the creation of visualizations
ulationisprojectedtodoubleinthenextgeneration[Uni12], that are easily accessible and cross platform compatible.
withmuchofthisurbangrowthoccurringinaridorsemiarid Theseadvantagesenablecollaboratorstoeasilysharetheir
environments.Indeed,thenonclimaticstressorsonwaterre- work and reach out to a large audience. Here, we specif-
|     |     |     |     |     |     |     | ically facilitate |     | another feature | of  | web-based applications, |     |
| --- | --- | --- | --- | --- | --- | --- | ----------------- | --- | --------------- | --- | ----------------------- | --- |
sourcesmayoutweightheclimateimpactsforsomeregions
[STN09,GMBW14,VMG∗10].Takentogether,theseinter-
|     |     |     |     |     |     |     | the potential | of  | easily interconnecting |     | users and devices. |     |
| --- | --- | --- | --- | --- | --- | --- | ------------- | --- | ---------------------- | --- | ------------------ | --- |
related pressures pose unprecedented challenges for urban This enables collaborative data exploration on distributed
sustainabilityandenvironmentalgovernance.Todevelopso- andmobiledevices.Ourdomaintaskfocusesonexploring
lutions, environmental governance is increasingly focused theeffectsofpopulationgrowthandclimatechangeinthe
|              |          |         |     |            |           |     | Niger | River Delta. | We present | our | system architecture, | a   |
| ------------ | -------- | ------- | --- | ---------- | --------- | --- | ----- | ------------ | ---------- | --- | -------------------- | --- |
| on improving | linkages | between |     | scientific | knowledge | and |       |              |            |     |                      |     |
decision making through collaborative problem solving. In casestudy,andfeedbackfromdomainscientists.
thisprocess,stakeholderscommunicateoptions,makeplans,
| monitor    | events, and   | often | politically | strategize | [SGH09].   |     |                |     |     |     |     |     |
| ---------- | ------------- | ----- | ----------- | ---------- | ---------- | --- | -------------- | --- | --- | --- | --- | --- |
|            |               |       |             |            |            |     | 2. RelatedWork |     |     |     |     |     |
| Given that | such planning |       | must engage | multiple   | stakehold- |     |                |     |     |     |     |     |
ersintheproblemformulation,thereisaneedforwaysin Isenbergetal.[IES∗11]definedandexploredbasicconcepts
which stakeholders can engage with data analysts, model- and challenges of combining collaboration and visualiza-
ers,andsimulationstodefineproblemthreatsandsolutions tion techniques. They predicted that collaborative software
through multiple perspectives. One means of doing this is tools will become more standardized and that researchers
throughcomputer-supportedcollaborativevisualizationen- will be confronted with the challenge of integrating use-
vironments in which decision-makers can run models and ful multi-user capabilities into data analysis environments.
simulationstoexploretheimpactofvariouspolicychoices. Forinstance,abasicconceptofcollaborationissavingand
Tothisend,wehavebeenworkingwithdomainexpertsfrom sharing the current state of a visualization. Mahyar et al.
(cid:13)c TheEurographicsAssociation2015.
DOI: 10.2312/envirvis.20151087

26 J.Lukasczyketal./ACollaborativeWeb-BasedEnvironmentalDataVisualizationandAnalysisFramework
|     |     | (a)WorkspaceWindow |     |     |     |     | (b)SnapshotBrowser |     |
| --- | --- | ------------------ | --- | --- | --- | --- | ------------------ | --- |
Figure1:Thecollaborativevisualizationframework.(a)TheWorkspaceWindowisusedforexploringwateravailability,pop-
ulationgrowth,andwaterscarcity.(b)TheSnapshotBrowserallowsuserstoannotate,discuss,andsharescenarioinformation.
[MST12] explicitly emphasize the importance of record- thatareeasyaccessible,cross-platformcompatible,capable
keeping. Their observations showed that users extensively of saving visualization states, and storing structured notes,
tooknotesandsavedvisualizationsnapshotsduringthecol- but the underlying communication protocol does not pro-
laborativedecision-makingprocess.Anotherresearchissue vide synchronous collaboration. For instance, most tools
is the synthesis of such result records. Robinson [Rob08] useAJAXtoactivelyrequestinshorttimeintervalsupdates
presentedresultsofexperimentswhereteamsconsistingof from a server, or use exploits such as long-polling to keep
participants with various backgrounds had to combine vi- a pseudo connection to the server, which causes in both
sual analytic results. Their study showed that collabora- casesahighnetworkoverheadandisnottrulysynchronous
tion tools benefit from a platform where users can easily [PHJsM14,Cha13]. On the other hand, modern web tech-
comprehendthehistoryofrecords,theircommonfeatures, nologies, such as HTML5 and WebSockets, can be used to
and their relationship. Synchronized visualization also fa- easily augment visualizations with synchronous and asyn-
cilitates data exploration. A user study conducted by Wal- chronousmulti-userinteraction.MarionandJomier[MJ12]
laceetal.[WSM13]indicatedthatcollaboratingusersper- proposed a prototype that combines the Web Graphics Li-
form better using a shared device on which they can com- brary(WebGL)andWebSocketstoenablesynchronouscol-
bineinformationandcollaborativelyinteractwiththesame laborationonamedicaldatavisualization.Inparticular,they
usedWebSocketstosynchronizetheviewsrenderedbyWeb-
| visualization. | An example | of  | a collaborative | visualization |     |     |     |     |
| -------------- | ---------- | --- | --------------- | ------------- | --- | --- | --- | --- |
tool for environmental planning is the distributed collabo- GLacrossallconnecteddevices.However,WebSocketsare
rativegeovisualizationenvironmentproposedbyBreweret capableofmuchmorethansimplysynchronizingcamerapa-
al. [BMA∗00,MB04]. The tool enables the exploration of rameters.Inourapplication,weuseWebSocketstocommu-
climatic time series via interactions and animations, while nicatedatabasequeries,annotations,andmodelfeatures.
| offering | support for | collaborative | sensemaking. | Other | ex- |     |     |     |
| -------- | ----------- | ------------- | ------------ | ----- | --- | --- | --- | --- |
amples for the use of collaborative visualization tools can 3. CollaborationFramework
| be found | in the Decision | Theater | at Arizona | State | Univer- |     |     |     |
| -------- | --------------- | ------- | ---------- | ----- | ------- | --- | --- | --- |
Themainwindowofourapplication,calledtheworkspace
sity[EL09].AsdescribedinSection3,ourframeworkde-
|     |     |     |     |     |     | window, is | the actual visualization | and enables multiple |
| --- | --- | --- | --- | --- | --- | ---------- | ------------------------ | -------------------- |
signfollowsthesepreviouslydescribedconcepts.
userstointeractivelyexploredata(Figure1a).Thewindow
consistsofthreemapsandaparametermenu.Theparameter
Fromatechnicalstandpoint,therearevariouswaystoim-
menuisusedtoadjustvisualizationandmodelparameters,
plementtheseconceptsandthereexistalargenumberofcol-
[Har09,SBO∗08,WHHA11, andcontainsadynamicQRcodeinthebottomrightcorner.
| laborative | visualization | tools |     |     |     |     |     |     |
| ---------- | ------------- | ----- | --- | --- | --- | --- | --- | --- |
Thiscodecould,forexample,encodeahyperlinktothecur-
| HVW07,VWvH∗07,BMZ∗06,IF09,VBA∗11]. |     |     |     | However, |     |     |     |     |
| ---------------------------------- | --- | --- | --- | -------- | --- | --- | --- | --- |
rentvisualizationortoawebsitewithdetailedinformation
| most of | the tools require | the | user to install | software, | use |                   |                   |                        |
| ------- | ----------------- | --- | --------------- | --------- | --- | ----------------- | ----------------- | ---------------------- |
|         |                   |     |                 |           |     | about the dataset | and models. Since | this is a standardized |
outdatedtechnologies,orarelimitedtobasicmulti-userin-
methodtosupplyweblinks,userscansimplyscantheQR
| teraction. | For example, | Hardisty          | [Har09] | and Stock    | et al. |                                                     |     |     |
| ---------- | ------------ | ----------------- | ------- | ------------ | ------ | --------------------------------------------------- | --- | --- |
| [SBO∗08]   |              |                   |         |              |        | codewiththeirmobiledevicesandimmediatelyparticipate |     |     |
|            | introduced   | geovisualizations |         | that support | syn-   |                                                     |     |     |
inthevisualization.
| chronous | communication | over | different | locations, | but re- |     |     |     |
| -------- | ------------- | ---- | --------- | ---------- | ------- | --- | --- | --- |
quire the users to install toolkits, which is not suitable for The three maps visualize one scenario according to pa-
interconnecting and reaching out to large and diverse au- rameterscontrolledthroughtheparametermenu.Tosupport
diences. Willet et al. [WHHA11], Heer et al. [HVW07], the user in comparing the different overlays, the views of
[VWvH∗07]
and Viegas et al. proposed web-based tools allthreemapsaresynchronized.Hence,ausercanexamine
(cid:13)c TheEurographicsAssociation2015.

J.Lukasczyketal./ACollaborativeWeb-BasedEnvironmentalDataVisualizationandAnalysisFramework 27
thesamespatialdomainwiththreedifferentoverlayswith-
| out occlusion. | We            | use Leaflet | [Lea15] | as              | our map engine, |     |     |     |     |     |     |
| -------------- | ------------- | ----------- | ------- | --------------- | --------------- | --- | --- | --- | --- | --- | --- |
| since it is    | light weight, | and         | offers  | mobile-friendly | interac-        |     |     |     |     |     |     |
tions,suchaszooming,areaselection,andpop-ups,which
| make collaboration |         | much     | easier | and faster  | between hand-  |     |     |     |     |     |     |
| ------------------ | ------- | -------- | ------ | ----------- | -------------- | --- | --- | --- | --- | --- | --- |
| held and           | desktop | devices. | The    | actual data | is stored on a |     |     |     |     |     |     |
GeoServer[Geo15],whichrespondstorequestsfromclients
andprovidesthedataqueriesasmapoverlaysviaaWebMap
Service(WMS).Leafletcanaddtheseoverlaysbyincluding
theserviceasatileproviderandthereforereduceworkload
ontheclientside.
| To enable | multiple | users | to interact | with | our web appli- |     |     |     |     |     |     |
| --------- | -------- | ----- | ----------- | ---- | -------------- | --- | --- | --- | --- | --- | --- |
Socket.IO Express.js Figure2:UserscollaboratingintheDecisionTheateratASU.
| cation, we  | use the |             | [Soc15], |                | [Exp15],        |                  |          |        |      |            |     |
| ----------- | ------- | ----------- | -------- | -------------- | --------------- | ---------------- | -------- | ------ | ---- | ---------- | --- |
| and Node.js | [Nod15] | libraries.  | We       | created        | a Visualization |                  |          |        |      |            |     |
|             |         |             |          |                |                 | Climate Research | program, | CORDEX | aims | to develop | ad- |
| Room, which | can     | be compared |          | to an ordinary | chat room.      |                  |          |        |      |            |     |
vancedRegionalClimateModelstodynamicallydownscale
UserswhowouldliketocollaboratecanjointhesameVisu-
|     |     |     |     |     |     | the latest | set of global | climate scenarios |     | and predictions |     |
| --- | --- | --- | --- | --- | --- | ---------- | ------------- | ----------------- | --- | --------------- | --- |
alizationRoombyfollowingalinktoawebsitefromade-
viceoftheirchoice.Eachusercaninteractwiththeirindivid- produced within the 5th Coupled Model Intercomparison
Project(CMIP5).Abasicwatersupplymodelquantifiesand
ualvisualization,sharetheirfindings,andviewinformation
predicts“BlueWater”asasumofthelocalwaterrunoffplus
providedbyotherusersofthesameVisualizationRoom.In
therivercorridordischarge[VLR05].Populationgrowthcan
particular,theuserscanshareandsynchronizetheircamera
|            |          |               |     |           |               | be simulated | exponentially | or by | shared | social pathways |     |
| ---------- | -------- | ------------- | --- | --------- | ------------- | ------------ | ------------- | ----- | ------ | --------------- | --- |
| positions, | selected | data subsets, |     | comments, | and used mod- |              |               |       |        |                 |     |
els.Thesefeaturesarestoredinaso-calledsnapshot,which from1960to2100.Tovisualizethedifferentmodelaspects,
ourtoolfeaturesamapensembleofpredictedwaterscarcity,
alsocontainsatitle,adescription,thetimeofcreation,and
watersupply,andpopulation(Figure1a).
theuserswhocontributedtothesnapshot.Thisfollowsthe
basicconceptofrecord-keepingpresentedin[MST12].Fur- Figure2showsusersinteractingintheDecisionTheater
thermore,eachsnapshotstoresahistoryofcomments,sim- atASU.Here,studentsexploredthemodelslocallyontheir
ilartotheapproachproposedin[WHHA11].Allsnapshots
tabletsandusedthelargedisplaystodiscussandsharetheir
aredisplayedonaseparatewindow,theso-calledSnapshot findings. In this scenario, the population model was fixed,
Browser(seeFigure1b).Theusercansearchforsnapshots andthemaintaskwastoexaminetheeffectsofdifferentcli-
withspecifickeywords,orgroupthembytheirfeatures,such mateandwatersupplymodelsatSokotoandNiameyfrom
asusedmodel,year,anduser.Asproposedin[Rob08],this 2010 to 2050. The goal was to understand potential water
facilitatestheunderstandingofthehistoryofrecords,their
threatsandtodiscussthesewithrespecttovariousscenarios
commonfeatures,andtheirrelationshipsamongeachother. ofpopulationgrowth.Sokotoanditsurbanareaishighlyde-
Ifauserenablesthesynchronizeflagintheparametermenu, pendentuponagriculture,andthereforehighlydependenton
theirvisualizationissynchronizedwithachosenmasterde- thewatersupplyprovidedbytheSokotoRiver.Niamey,on
vice.Updatesonthemasterdevice,suchasviewandmodel the other hand, is surrounded by a dense river system and
parameterchanges,aresenttotheserver,whichinturnsends
|     |     |     |     |     |     | is the largest | city in Western | Africa. | With | our collabora- |     |
| --- | --- | --- | --- | --- | --- | -------------- | --------------- | ------- | ---- | -------------- | --- |
theupdatestoallclientswhowanttosynchronizewiththat
|     |     |     |     |     |     | tion framework, | users explored | future | climate | and | popula- |
| --- | --- | --- | --- | --- | --- | --------------- | -------------- | ------ | ------- | --- | ------- |
master device. This allows users to work on a simulated tionscenariosacrosstheseregions,commentedonfindings
shareddevice,ashasproventobebeneficialinWallaceet in the browser, and shared and loaded model parameters,
al. [WSM13]. Moreover, one user could open the visual- both from their analysis and those of our water modeling
izationmultipletimesindifferentbrowsersordeviceswith experts. Figure 3 shows population, water supply, and wa-
distinctparameters,andthensynchronizetheinstanceswith
terscarcitypredictionsaroundNiameyandSokotofor2050.
eachothertocomparedifferentscenarios. ThefirstrowindicatesthatalthoughNiameyissurrounded
byadenseriversystem,theurbanspreadin2050willcause
4. CaseStudy waterscarcityinthenorth-easternregions.Themodelalso
|     |     |     |     |     |     | predicts | that areas around | Sokoto | that are | not close | to the |
| --- | --- | --- | --- | --- | --- | -------- | ----------------- | ------ | -------- | --------- | ------ |
Todemonstrateourframeworkandtheprovidedmulti-user
SokotoRiverwillhavemassivewaterproblemsin2050.
interactions,wevisualizewaterscarcityintheNigerRiver
Basin in Western Africa. Users can select and combine Overall,usersfoundthatthesetoolsperformedwelland
severalclimate,watersupply,andpopulationgrowthmod- showed enthusiasm for working together to explore com-
els. The climate models are derived from different combi- plexproblems.Feedbackfromthedomainexpertindicated
nations of global and regional climate models developed thatsuchcollaborationallowsuserstoimplementanticipa-
throughtheCoordinatedRegionalClimateDownscalingEx- toryapproachestodecisionmakingby:a)characterizingand
periment (CORDEX) database. Sponsored by the World exploring uncertainty in a transparent manner by creating
(cid:13)c TheEurographicsAssociation2015.

28 J.Lukasczyketal./ACollaborativeWeb-BasedEnvironmentalDataVisualizationandAnalysisFramework
Figure3:VisualizationofthepredictionsaccordingtotheHadGEM2-ESmodelaroundNiamey(firstrow)andSokoto(second
row)in2050.Thefirstcolumnshowsthepopulation,thesecondcolumnthewatersupply,andthethirdthewaterscarcity.
multiplescenariosofwatersupplyanddemandfutureswith resentation.Inadditiontocomments,userscouldalsostore
varying assumptions about climate and population dynam- moreadvancedannotations,suchasfreedrawnshapesand
ics;b)definingaproblemspaceforcomplexityusingasys- externaldocuments.Toimprovepermanentrecord-keeping,
temsapproachtomodelingthatincorporatesinteractionsand the Node.js server can be combined with a database sys-
feedbacksbetweensystemelements;andc)outliningadeci- temthatstoressnapshotsinastandardizedformat,suchas
sionspaceusingpolicyoptionstoexploreinterestsofvaried JSON. This would also enable importing and exporting of
stakeholders.Futureworkcouldusesuchcollaborativepro- snapshotstoothervisualizationtools.Inthefuture,wealso
cessestoidentifyexamplesofsustainableorresiliencede- plantoconductaformaluserstudytoevaluateandimprove
velopmentpatternsthatmaydifferfromexistingtrendsand theusabilityandutilityofourframework.Whileresearchers
wouldentaildifferentwaterusepatterns.Thesepotentialde- havelongrecognizedtheneedforcollaborativevisualization
velopmentpathwayscouldthenbecategorizedbythecom- [IES∗11,Rob08]anddevelopedtoolsandtechniquesforcol-
ponents that affect the water balance, and users could de- laborativeanalysis[WSM13,WHHA11,VWvH∗07],thereis
liberateondevelopmentinterventionsnecessarytoachieve stillfurtherneedtointegratevisualizationintopublic-policy
desirablefuturesandavoidundesirableones. modeling[KNRB12].
Acknowledgements
5. ResultsandFutureWork
ThismanuscripthasbeenauthoredbyUT-Battelle,LLCun-
Thisworkintroducedaweb-basedframeworkwhichiseas- derContractNo.DEAC05-00OR22725withtheU.S.De-
ily extendable, accessible, cross-platform compatible, pro- partment of Energy. The U.S. Government retains and the
videssynchronousandasynchronousmulti-userinteraction, publisher,byacceptingthearticleforpublication,acknowl-
and does not require the user to install software. We be- edges that the U.S. Government retains a non-exclusive,
lieve that such frameworks will enhance data exploration, paid-up,irrevocable,world-widelicensetopublishorrepro-
analysis, and collaboration among researchers. In particu- duce the published form of this manuscript, or allow oth-
lar,wedemonstratedtheuseofNode.js,Socket.IO,Express, ers to do so, for U.S. Government purposes. Some of the
and other modern web technologies to create a multi-user materialpresentedherewassponsoredbyagrantfromthe
environmentaldatavisualization,whereuserscansharere- DoDanduponworksupportedbytheNSFunderGrantNo.
sults,visualizationstates,andmodelparameters.Theframe- (NSF 1350573). This research was supported by the DFG
work is designed to beeasily extendable in the future. For (IRTG2057).Disclaimer:The viewsandconclusionscon-
instance, instead of storing a snapshot of a visualization tainedhereinarethoseoftheauthorsandshouldnotbein-
state, it would be possible to archive the history of a visu- terpretedasnecessarilyrepresentingtheofficialpoliciesor
alization and enable the users to browse through time by endorsements,eitherexpressedorimplied,ofASU,DoD,or
showing the entire process that built up to the current rep- theU.S.Government.
(cid:13)c TheEurographicsAssociation2015.

J.Lukasczyketal./ACollaborativeWeb-BasedEnvironmentalDataVisualizationandAnalysisFramework 29
References [Nod15] Node.JS.http://nodejs.org/,2015.LastAccessed:Febru-
ary14,2015.3
| [BMA∗00] | BREWER | I., MACEACHREN |     | A., | ABDO | H., GUN- |     |     |     |     |     |     |     |
| -------- | ------ | -------------- | --- | --- | ---- | -------- | --- | --- | --- | --- | --- | --- | --- |
DRUMJ.,OTTOG.: Collaborativegeographicvisualization:en- [PHJsM14] PARKJ.-T.,HWANGH.-S.,JUN-SOOY.,MOONI.-
ablingsharedunderstandingofenvironmentalprocesses.InIEEE Y.: StudyofHTML5WebSocketforaMultimediaCommuni-
SymposiumonInformationVisualization(2000),pp.137–141.2 cation. InternationalJournalofMultimedia&UbiquitousEngi-
neering9,7(2014),61–72.2
| [BMZ∗06] | BRENNAN | S., MUELLER |     | K., ZELINSKY |     | G., RA- |     |     |     |     |     |     |     |
| -------- | ------- | ----------- | --- | ------------ | --- | ------- | --- | --- | --- | --- | --- | --- | --- |
MAKRISHNANI.,WARREND.,KAUFMANA.:TowardaMulti- [Rob08] ROBINSON A.: Collaborativesynthesisofvisualana-
Analyst,CollaborativeFrameworkforVisualAnalytics.InIEEE
|     |     |     |     |     |     |     | lyticresults. | InIEEESymposiumonVisualAnalyticsScience |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------------- | --------------------------------------- | --- | --- | --- | --- | --- |
SymposiumOnVisualAnalyticsScienceAndTechnology(2006), andTechnology(2008),pp.67–74.1,2,3,4
pp.129–136.2
|     |     |     |     |     |     |     | [SBO∗08] STOCKC.,BISHOPI.D.,O’CONNORA.N.,CHEN |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --------------------------------------------- | --- | --- | --- | --- | --- | --- |
[Cha13] CHA S.-H.: Developing a HTML5-Based Real-Time T., PETTIT C. J., AURAMBOUT J.-P.: SIEVE: Collaborative
| MonitoringSystemforWirelessSensorNetworks. |     |     |     |     | InAdvances |     |                                                |     |     |     |     |     |         |
| ------------------------------------------ | --- | --- | --- | --- | ---------- | --- | ---------------------------------------------- | --- | --- | --- | --- | --- | ------- |
|                                            |     |     |     |     |            |     | Decision-makinginanImmersiveOnlineEnvironment. |     |     |     |     |     | Cartog- |
in Mechanical and Electronic Engineering, vol. 178. Springer raphyandGeographicInformationScience35,2(2008),133–
| BerlinHeidelberg,2013,pp.241–245.2 |     |            |     |        |               |      | 144.2              |     |     |              |     |           |     |
| ---------------------------------- | --- | ---------- | --- | ------ | ------------- | ---- | ------------------ | --- | --- | ------------ | --- | --------- | --- |
| [EL09] EDSALL                      | R.  | M., LARSON |     | K. L.: | Effectiveness | of a |                    |     |     |              |     |           |     |
|                                    |     |            |     |        |               |      | [SGH09] STEINEBACH |     | G., | GUHATHAKURTA |     | S., HAGEN | H.: |
Semi-ImmersiveVirtualEnvironmentinUnderstandingHuman- Visualizing Sustainable Planning,
|     |     |     |     |     |     |     |     |     |     | 1st | ed. Springer | Publishing |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ------------ | ---------- | --- |
EnvironmentInteractions. CartographyandGeographicInfor- Company,Incorporated,2009.1
mationScience36,4(2009),367–384.2
[Soc15] Socket.IO.http://socket.io/,2015.LastAccessed:Febru-
| [Exp15] Express.JS. |     | http://expressjs.com/,2015. |     |     | LastAccessed: |     |     |     |     |     |     |     |     |
| ------------------- | --- | --------------------------- | --- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
ary14,2015.3
February14,2015.3
[STN09] SEAGERR.,TZANOVAA.,NAKAMURAJ.:Droughtin
| [Geo15] GeoServer. |     | http://geoserver.org/,2015. |     |     | LastAccessed: |     |     |     |     |     |     |     |     |
| ------------------ | --- | --------------------------- | --- | --- | ------------- | --- | --- | --- | --- | --- | --- | --- | --- |
theSoutheasternUnitedStates:Causes,VariabilityovertheLast
February14,2015.3
Millennium,andthePotentialforFutureHydroclimateChange.
[GMBW14] GEORGESCU M., MOREFIELD P. E., BIERWAGEN JournalofClimate22,19(2009),5021–5045.1
B.G.,WEAVERC.P.:UrbanAdaptationCanRollBackWarm-
|                 |             |     |          |     |             |        | [Uni12] UNITED              | NATIONALS |     | DEVELOPMENT               |     | PROGRAMME: |     |
| --------------- | ----------- | --- | -------- | --- | ----------- | ------ | --------------------------- | --------- | --- | ------------------------- | --- | ---------- | --- |
| ing of Emerging | Megapolitan |     | Regions. | In  | Proceedings | of the |                             |           |     |                           |     |            |     |
|                 |             |     |          |     |             |        | TheSustainableFutureWeWant. |           |     | Tech.rep.,UnitedNationals |     |            |     |
NationalAcademyofSciences(PNAS)(2014).1
DevelopmentProgramme,2012.1
| [Ha r 0 9 ] H |     | F . : G e o | Ja b b e r: | E n a b l in | g G e o - C | o ll a b o ra ti v e |     |     |     |     |     |     |     |
| ------------- | --- | ----------- | ----------- | ------------ | ----------- | -------------------- | --- | --- | --- | --- | --- | --- | --- |
A R D I S T Y [VBA∗11] VOGT K., BRADEL L., ANDREWS C., NORTH C.,
| V i s u alA n | al y si s . C | a r t og ra p | h y a n d G | e o g r a p | hi c In f o r | m a t io n S c i - |                       |     |     |                               |     |     |     |
| ------------- | ------------- | ------------- | ----------- | ----------- | ------------- | ------------------ | --------------------- | --- | --- | ----------------------------- | --- | --- | --- |
|               |               |               |             |             |               |                    | ENDERTA.,HUTCHINGSD.: |     |     | Co-locatedCollaborativeSense- |     |     |     |
ence36,3(2009),267–280.2
|         |          |        |                |     |     |          | making on    | a Large        | High-resolution |        | Display with | Multiple | In-      |
| ------- | -------- | ------ | -------------- | --- | --- | -------- | ------------ | -------------- | --------------- | ------ | ------------ | -------- | -------- |
| [HVW07] | HEER J., | VIEGAS | F., WATTENBERG |     | M.: | Voyagers |              |                |                 |        |              |          |          |
|         |          |        |                |     |     |          | put Devices. | In Proceedings |                 | of the | 13th IFIP    | TC 13    | Interna- |
andVoyeurs:SupportingAsynchronousCollaborativeInforma-
tionalConferenceonHuman-computerInteraction-VolumePart
tionVisualization. InACMHumanFactorsinComputingSys- II(Berlin,Heidelberg,2011),Springer-Verlag,pp.589–604.2
tems(2007),pp.1029–1038.2
|                   |     |              |     |             |     |        | [VLR05] VOROSMARTY |     | C.  | J., LEVEQUE | C., | REVENGA | C.: |
| ----------------- | --- | ------------ | --- | ----------- | --- | ------ | ------------------ | --- | --- | ----------- | --- | ------- | --- |
| [IES∗11] ISENBERG |     | P., ELMQVIST |     | N., SCHOLTZ | J., | CERNEA |                    |     |     |             |     |         |     |
Freshwater.InEcosystemsandHumanWell-being:CurrentState
D.,MAK.-L.,HAGENH.:CollaborativeVisualization:Defini-
andTrends.2005.3
| tion,Challenges,andResearchAgenda. |     |     |     | InformationVisualiza- |     |     |                     |     |     |              |     |                |     |
| ---------------------------------- | --- | --- | --- | --------------------- | --- | --- | ------------------- | --- | --- | ------------ | --- | -------------- | --- |
|                                    |     |     |     |                       |     |     | [VMG∗10] VOROSMARTY |     | C.  | J., MCINTYRE |     | P. B., GESSNER |     |
tion10,4(2011),310–326.1,4
|                 |     |        |     |               |          |     | M. O., DUDGEON |     | D., PRUSEVICH |     | A., GREEN | P., GLIDDEN |     |
| --------------- | --- | ------ | --- | ------------- | -------- | --- | -------------- | --- | ------------- | --- | --------- | ----------- | --- |
| [IF09] ISENBERG | P., | FISHER | D.: | Collaborative | Brushing | and |                |     |               |     |           |             |     |
S.,BUNNS.E.,SULLIVANC.A.,LIERMANNC.R.,DAVIES
| Linking for | Co-located | Visual | Analytics | of  | Document | Collec- |     |     |     |     |     |     |     |
| ----------- | ---------- | ------ | --------- | --- | -------- | ------- | --- | --- | --- | --- | --- | --- | --- |
P.M.:Globalthreatstohumanwatersecurityandriverbiodiver-
tions.InProceedingsofEurovis(2009),Eurographics.2 sity.Nature(2010),555–561.1
| [KNRB12]  | KOHLHAMMER |        | J., NAZEMI    |     | K., RUPPERT | T.,       |                  |        |                |           |        |                   |     |
| --------- | ---------- | ------ | ------------- | --- | ----------- | --------- | ---------------- | ------ | -------------- | --------- | ------ | ----------------- | --- |
|           |            |        |               |     |             |           | [VWvH∗07]        | VIEGAS | F., WATTENBERG |           | M.,    | VAN HAM           | F., |
| BURKHARDT | D.:        | Toward | Visualization |     | in Policy   | Modeling. |                  |        |                |           |        |                   |     |
|           |            |        |               |     |             |           | KRISS J., MCKEON |        | M.:            | ManyEyes: | a Site | for Visualization |     |
IEEEComputerGraphicsandApplications32,5(2012),84–89. IEEETransactionsonVisualizationandCom-
| 4   |     |     |     |     |     |     | atInternetScale. |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ---------------- | --- | --- | --- | --- | --- | --- |
puterGraphics13,6(2007),1121–1128.2,4
[Lea15] Leaflet.http://leafletjs.com/,2015.LastAccessed:Febru-
|     |     |     |     |     |     |     | [WHHA11] | WILLETT | W., | HEER | J., HELLERSTEIN |     | J., |
| --- | --- | --- | --- | --- | --- | --- | -------- | ------- | --- | ---- | --------------- | --- | --- |
ary14,2015.3
|     |     |     |     |     |     |     | AGRAWALA | M.: | CommentSpace: |     | Structured | Support | for |
| --- | --- | --- | --- | --- | --- | --- | -------- | --- | ------------- | --- | ---------- | ------- | --- |
[LMH14] LUKASCZYK J., MIDDEL A., HAGEN H.: WebGL- Collaborative Visual Analysis. In Proceedings of the SIGCHI
based Geodata Visualization for Policy Support and Decision Conference on Human Factors in Computing Systems (2011),
Making.InWorkshoponVisualisationinEnvironmentalSciences ACM,pp.3131–3140.1,2,3,4
(EnvirVis)(2014).1
|     |     |     |     |     |     |     | [WSM13] WALLACEJ.R.,SCOTTS.D.,MACGREGORC.G.: |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | -------------------------------------------- | --- | --- | --- | --- | --- | --- |
[MB04] MACEACHRENA.M.,BREWERI.: Developingacon- CollaborativeSensemakingonaDigitalTabletopandPersonal
ceptual framework for visually-enabled geocollaboration. In- Tablets:Prioritization,Comparisons,andTableaux. InProceed-
ternationalJournalofGeographicalInformationScience18,1 ingsoftheSIGCHIConferenceonHumanFactorsinComputing
(2004),1–34.2
Systems(2013),ACM,pp.3345–3354.1,2,3,4
| [MJ12] MARIONC.,JOMIERJ.:             |     |     | Real-timeCollaborativeScien- |     |                 |     |     |     |     |     |     |     |     |
| ------------------------------------- | --- | --- | ---------------------------- | --- | --------------- | --- | --- | --- | --- | --- | --- | --- | --- |
| tificWebGLVisualizationwithWebSocket. |     |     |                              |     | InProceedingsof |     |     |     |     |     |     |     |     |
the17thInternationalConferenceon3DWebTechnology(New
York,NY,USA,2012),ACM,pp.47–50.2
| [MST12] MAHYARN.,SARVGHADA.,TORYM.: |     |     |     |     |     | Note-taking |     |     |     |     |     |     |     |
| ----------------------------------- | --- | --- | --- | --- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- |
inCo-locatedCollaborativeVisualAnalytics:AnalysisofanOb-
| servationalStudy. |     | InformationVisualization11,3(2012),190– |     |     |     |     |     |     |     |     |     |     |     |
| ----------------- | --- | --------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
204.1,2,3
(cid:13)c TheEurographicsAssociation2015.
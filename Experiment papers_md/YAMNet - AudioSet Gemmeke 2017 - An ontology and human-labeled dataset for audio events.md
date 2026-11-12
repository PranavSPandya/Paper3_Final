AUDIOSET:ANONTOLOGYANDHUMAN-LABELEDDATASETFORAUDIOEVENTS
JortF.Gemmeke,DanielP.W.Ellis,DylanFreedman,ArenJansen,
WadeLawrence,R.ChanningMoore,ManojPlakal,MarvinRitter
Google,Inc.,MountainView,CA,andNewYork,NY,USA
{jgemmeke,dpwe,freedmand,arenjansen,wadelawrence,channingmoore,plakal,marvinritter}@google.com
ABSTRACT among50environmentalsounds. LeMaitreandHeller[8]proposed
ataxonomyofsoundeventsdistinguishingobjectsandactions,and
Audioeventrecognition, thehuman-likeabilitytoidentifyandre- used identification time and priming effects to show that listeners
late sounds from audio, is a nascent problem in machine percep- finda“middlerange”ofabstractionmostnatural.
tion. Comparableproblemssuchasobjectdetectioninimageshave
Engineering-orientedtaxonomiesanddatasetsbeganwithGaver
reapedenormousbenefitsfromcomprehensivedatasets–principally
|           |                                          |     |     |     |     |     |         | [9] who       | used perceptual |     | factors   | to guide | the design    | of synthetic |     |
| --------- | ---------------------------------------- | --- | --- | --- | --- | --- | ------- | ------------- | --------------- | --- | --------- | -------- | ------------- | ------------ | --- |
| ImageNet. | ThispaperdescribesthecreationofAudioSet, |     |     |     |     |     | alarge- |               |                 |     |           |          |               |              |     |
|           |                                          |     |     |     |     |     |         | sound effects | conveying       |     | different | actions  | and materials | (tapping,    |     |
scaledatasetofmanually-annotatedaudioeventsthatendeavorsto
|               |     |           |              |              |          |           |        | scraping,      | etc.).   | Nakatani   | & Okuno       | [10]     | devised       | a sound         | ontol- |
| ------------- | --- | --------- | ------------ | ------------ | -------- | --------- | ------ | -------------- | -------- | ---------- | ------------- | -------- | ------------- | --------------- | ------ |
| bridge the    | gap | in data   | availability | between      | image    | and audio | re-    |                |          |            |               |          |               |                 |        |
|               |     |           |              |              |          |           |        | ogy to support |          | real-world | computational |          | auditory      | scene analysis. |        |
| search. Using | a   | carefully | structured   | hierarchical | ontology |           | of 632 |                |          |            |               |          |               |                 |        |
|               |     |           |              |              |          |           |        | Burger et      | al. [11] | developed  |               | a set of | 42 “noisemes” | (by             | anal-  |
audioclassesguidedbytheliteratureandmanualcuration,wecol-
|     |     |     |     |     |     |     |     | ogy with | phonemes) | to  | provide | a practical | basis | for fine-grained |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------- | --------- | --- | ------- | ----------- | ----- | ---------------- | --- |
lectdatafromhumanlabelerstoprobethepresenceofspecificaudio
|     |     |     |     |     |     |     |     | manual annotation |     | of 5.6 | hours | of web | video soundtrack. |     | Shar- |
| --- | --- | --- | --- | --- | --- | --- | --- | ----------------- | --- | ------ | ----- | ------ | ----------------- | --- | ----- |
classesin10secondsegmentsofYouTubevideos.Segmentsarepro- ing many of the motivations of this paper, Salamon et al. [12] re-
posedforlabelingusingsearchesbasedonmetadata,context(e.g., leased a dataset of 18.5 hours of urban sound recordings selected
links),andcontentanalysis.Theresultisadatasetofunprecedented from freesound.org, labeled at fine temporal resolution with
| breadthandsizethatwill, |     |     | wehope, | substantiallystimulatethede- |     |     |     |     |     |     |     |     |     |     |     |
| ----------------------- | --- | --- | ------- | ---------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
10low-levelsoundcategorieschosenfromtheirurbansoundtaxon-
velopmentofhigh-performanceaudioeventrecognizers.
|     |     |     |     |     |     |     |     | omyof101categories. |     |     | Mostrecently,Sa¨geretal. |     |     | [13]systemati- |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------- | --- | --- | ------------------------ | --- | --- | -------------- | --- |
Index Terms— Audio event detection, sound ontology, audio callyconstructedadjective-nounandverb-nounpairsfromtagsap-
databases,datacollection pliedtoentirefreesound.orgrecordingstoconstructAudioSen-
|     |     |     |              |     |     |     |     | tiBank, 1,267 | hours       | of audio | labeled | with    | 1,123           | adjective-noun | or      |
| --- | --- | --- | ------------ | --- | --- | --- | --- | ------------- | ----------- | -------- | ------- | ------- | --------------- | -------------- | ------- |
|     |     |     |              |     |     |     |     | verb-noun     | “sentiment” | tags.    | The     | labels’ | time resolution | is             | limited |
|     |     | 1.  | INTRODUCTION |     |     |     |     |               |             |          |         |         |                 |                |         |
wholeclips,whichcanbeupto15minlong,andthereisnoguaran-
teethattheword-pairsactuallybelongtogether–e.g.,“talkingbird”
Withinthedomainofmachineperception,weareinterestedinartifi-
yieldsmostlytrackscontainingboth“talking”and“bird”,butvery
cialsoundunderstanding. Wewouldliketoproduceanaudioevent fewbirdsdoingthetalking.
recognizerthatcanlabelhundredsorthousandsofdifferentsound Automaticsystemsforaudioeventclassificationgobacktothe
| events in  | real-world | recordings |           | with a time | resolution | better     | than |                                                         |           |     |             |       |           |            |     |
| ---------- | ---------- | ---------- | --------- | ----------- | ---------- | ---------- | ---- | ------------------------------------------------------- | --------- | --- | ----------- | ----- | --------- | ---------- | --- |
|            |            |            |           |             |            |            |      | MuscleFishcontent-basedsoundeffectsretrievalsystem[14]. |           |     |             |       |           |            | EU  |
| one second | – just     | as human   | listeners | can         | recognize  | and relate | the  |                                                         |           |     |             |       |           |            |     |
|            |            |            |           |             |            |            |      | Project CHIL                                            | conducted |     | an Acoustic | Event | Detection | evaluation |     |
soundstheyhear.
[15]overexamplesof16“meetingroomacousticevents”comparing
| Recently,                         | there | have | been astonishing |                      | results in | the analogous |     |                        |     |     |                                   |     |     |     |     |
| --------------------------------- | ----- | ---- | ---------------- | -------------------- | ---------- | ------------- | --- | ---------------------- | --- | --- | --------------------------------- | --- | --- | --- | --- |
|                                   |       |      |                  |                      |            |               |     | resultsofthreesystems. |     |     | AsimilartaskwasincludedintheIEEE- |     |     |     |     |
| problemofimagerecognition[1,2,3]. |       |      |                  | ThesemakeuseoftheIm- |            |               |     |                        |     |     |                                   |     |     |     |     |
sponsoredDCASE2013[16]whichattracted7submissionstodetect
ageNetdataset,whichprovidesmorethan1millionimageslabeled
|                              |     |     |     |                            |     |     |     | 16“office”audioevents. |     |     | F-measures(harmonicmeanofprecision |     |     |     |     |
| ---------------------------- | --- | --- | --- | -------------------------- | --- | --- | --- | ---------------------- | --- | --- | ---------------------------------- | --- | --- | --- | --- |
| with1000objectcategories[4]. |     |     |     | ImageNetappearstohavebeena |     |     |     |                        |     |     |                                    |     |     |     |     |
andrecallofdetectedevents)werebelow0.2,leavingmuchroomto
| major factor | driving | these | developments, |     | yet nothing | of this | scale |          |                                                 |     |     |     |     |     |     |
| ------------ | ------- | ----- | ------------- | --- | ----------- | ------- | ----- | -------- | ----------------------------------------------- | --- | --- | --- | --- | --- | --- |
|              |         |       |               |     |             |         |       | improve. | DCASE2016[17],includesanaudioeventdetectiontask |     |     |     |     |     |     |
existsforsoundsources.
basedon90minutesofrealhomeandoutdoorrecordings,carefully
This paper describes the creation of Audio Set, a dataset and annotatedwith13audioeventcategoriesspanning“birdsinging”to
| ontology | of audio      | events | that endeavors | to               | provide | comprehensive |        | “washingdishes”. |          |       |       |     |           |           |        |
| -------- | ------------- | ------ | -------------- | ---------------- | ------- | ------------- | ------ | ---------------- | -------- | ----- | ----- | --- | --------- | --------- | ------ |
| coverage | of real-world |        | sounds         | at ImageNet-like | scale.  | Our           | inten- |                  |          |       |       |     |           |           |        |
|          |               |        |                |                  |         |               |        | Unlike           | previous | work, | Audio | Set | considers | all sound | events |
tionistousethedatasettocreateautomaticaudioeventrecognition
|     |     |     |     |     |     |     |     | ratherthanalimiteddomain. |     |     | Webelievethatalarge-scaletask,in |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------------------- | --- | --- | -------------------------------- | --- | --- | --- | --- |
systemsthatarecomparabletothestate-of-the-artinrecognizingob-
termsofbothcategoriesanddata,willenablemorepowerfullearn-
jectsinreal-worldimages.
ingtechniques,andhenceastep-changeinsystemquality.
| Audio                    | eventrecognition |     | has                             | beenstudied | from | perceptual | and |     |     |     |     |     |     |     |     |
| ------------------------ | ---------------- | --- | ------------------------------- | ----------- | ---- | ---------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| engineeringperspectives. |                  |     | Warren&Verbrugge[5]wereamongthe |             |      |            |     |     |     |     |     |     |     |     |     |
first to connect perceptual properties to acoustic features in their 2. THEAUDIOSETONTOLOGY
| studyofbouncingandbreakingsounds. |     |     |     | Ballas[6]probedtheper- |     |     |     |     |     |     |     |     |     |     |     |
| --------------------------------- | --- | --- | --- | ---------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
ceptionof41shorteventsobtainedfromasoundeffectscollectionby Giventhegoalofcreatingageneral-purposeaudioeventrecognizer,
relatingidentificationtimetoacousticfeatures, measuresoffamil- weneedtodefinethesetofeventsthesystemshouldrecognize.This
iarity,andenvironmentalprevalence.Gygi,Kidd&Watson[7]used set of classes will allow us to collect labeled data for training and
multidimensional scaling to identify acoustic factors such as tem- evaluation. Inturn, human-labeleddataprovidesacrispdefinition
poralenvelopeandpitchmeasuresthatpredictedsimilarityratings ofourresearchgoal: tocreateasystemabletopredictthehuman

labelingsfromaudioalone. We stopped when the list seemed to be supplying terms that were
Rather than a flat list of audio events, we want to have events allobscureorill-defined(e.g.,“Wilhelmscream”,“TheOakRidge
structured into an abstraction hierarchy. In training, this indicates Boys”,“Earcon”,“Whump”). Theresultingstructureisnotastrict
classeswithnonexclusiverelationships;forinstancewedonotwant hierarchyasnodesmayoccurinseveralplaces;forinstance,“Hiss”
toourclassifierstoattempttoseparate“dogsounds”from“bark”. appearsunder“Cat”, “Steam”, and“Onomatopoeia”. Therearein
Duringrecognition,hierarchicalrelationsallowbacking-offtomore total33categoriesthatappearmorethanonce.
generaldescriptionswhentheclassifierencountersambiguityamong
|     |     |     |     | We refined | this | initial | structure by | comparing | it with | existing |
| --- | --- | --- | --- | ---------- | ---- | ------- | ------------ | --------- | ------- | -------- |
severalsubcategories(e.g.,asoundthatisrecognizedambiguously audioeventlistsortaxonomies,including[9,20,11,12,21,8,17].
as “growl”, “bark” and “howl” can fall back to a classification of Our hope was that the initial list would subsume these earlier ef-
“dogsounds”). Finally, awell-structuredhierarchycanaidhuman forts;infact,numerousgapswereexposed,althougheventuallywe
labelingbyallowingalabelertoquicklyanddirectlyfindthesetof reached a point where nearly every class from other sets was cov-
termsthatbestdescribeasound;thiswasalsoimportantduringthe ered. Someclassesfromothersetswerenotincorporatedbecause
developmentoftheeventsetwhentryingtoaddcategorieswithout theyweretoospecific,orotherwisedidnotmeetourcriteriaofbe-
overlapandduplication. ing readily identifiable. For instance, the urban sounds taxonomy
ThisstructuredsetofaudioeventcategoriesiscalledtheAudio of[12]includes“Carradio”asasourceofrecordedmusic, which
Set Ontology. The specific principles that guided its development makessensewhenlabelingcitystreetambiencerecordingsbutistoo
were: specialized or context-dependent for our set (although we do have
• Thecategoriesshouldprovideacomprehensivesetthatcan “Radio”forsoundsthatareclearlybeingproducedbyaradio). The
|     |     |     |     | 165 verified-distinct |     | sound | clips used in | [21] | include | detailed ex- |
| --- | --- | --- | --- | --------------------- | --- | ----- | ------------- | ---- | ------- | ------------ |
beusedtodescribetheaudioeventsencounteredinreal-world
|     |     |     |     | amples such | “Trumpet | jazz | solo” and “Walking |     | on leaves”; | in our |
| --- | --- | --- | --- | ----------- | -------- | ---- | ------------------ | --- | ----------- | ------ |
recordings.
|     |     |     |     | scheme, these | would | be simply | “Trumpet” | and | “Walk, | footsteps”, |
| --- | --- | --- | --- | ------------- | ----- | --------- | --------- | --- | ------ | ----------- |
• Thecategoryofaparticularaudioeventshouldcorrespondto
respectively.
theideaorunderstandingthatimmediatelycomestothemind
Wethenbeganusingthissettolabelrecordings,aswellastry-
ofalistenerhearingthesound. ingtofindexamplesforeverycategory(asdescribedinsection2.1
• Individualcategoriesshouldbedistinguishablebya“typical” below). Feedback from the larger group of people involved led to
listener. Thatis,iftwocategoriescorrespondtosoundsthat furthermodificationstothecategoryset.
alistenercannoteasilyorreliablydistinguish,thecategories Our final list contains 632 audio event categories, arranged in
shouldbemerged. Soundsthatcanbedistinguishedonlyby a hierarchy with a maximum depth of 6 levels; an example from
anexpert(suchasparticularbirdspecies,orfinedistinctions amongtheeightlevel-6nodesis“Soundsofthings”→“Vehicle”→
inmusicalinstruments)shouldnotbeseparated.Thisisanat- “Motorvehicle”→“Emergencyvehicle”→“Siren”→“Ambulance
uralconditiontopreventthesetbecomingunwieldy,although (siren)”(acategorythatwasappropriatedfromtheUrbanSoundtax-
werecognizethepossibilityofextensionsthatexpandcertain onomy[12]).Figure1showsthe50first-andsecond-levelnodesin
| nodeswithmoredetailed,expert,distinctions. |     |     |     | thishierarchy. |     |     |     |     |     |     |
| ------------------------------------------ | --- | --- | --- | -------------- | --- | --- | --- | --- | --- | --- |
• Ideally,individualcategoriesaredistinctbasedontheirsound
alone,i.e. withoutrelyingonaccompanyingvisualinforma- 2.1. OntologyDataRelease
| tionordetailsofcontext. | Thus,asoundisa“thump”,rather |     |     |     |     |     |     |     |     |     |
| ----------------------- | ---------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
than“barefootstampingonawoodenfloor”. The ontology is released1 as a JSON file containing the following
fieldsforeachcategory:
| • The hierarchical | structure allows | annotators | to identify the |     |     |     |     |     |     |     |
| ------------------ | ---------------- | ---------- | --------------- | --- | --- | --- | --- | --- | --- | --- |
best,mostspecificcategoriesforgivenaudioeventsaseasily
|             |                                         |     |     | • ID: | The Knowledge |     | Graph Machine | ID  | (MID) | best match- |
| ----------- | --------------------------------------- | --- | --- | ----- | ------------- | --- | ------------- | --- | ----- | ----------- |
| aspossible. | Thismeansthatthehierarchyshouldnotbetoo |     |     |       |               |     |               |     |       |             |
ingthesoundorsource,usedastheprimaryidentifierforthe
deep,whilethenumberofchildreninanynodeshouldrarely
|     |     |     |     | class. | InKnowledgeGraph,manyMIDsrefertospecificob- |     |     |     |     |     |
| --- | --- | --- | --- | ------ | ------------------------------------------- | --- | --- | --- | --- | --- |
bemorethan10,tofacilitaterapidscanning.
|     |     |     |     | jects(e.g., |     | /m/0gy1t2s, | “Bicyclebell”or/m/02y |     |     | 763, |
| --- | --- | --- | --- | ----------- | --- | ----------- | --------------------- | --- | --- | ---- |
To avoid biasing the category set by the orientation of a par- “Slidingdoor”); whenusedintheontology, theyareunder-
ticularresearcher, orthelimiteddiversityofsoundsinaparticular stoodtomean“thesoundreadilyassociatedwiththespecified
object”.Forinstance,inthecaseof“Slidingdoor”,thesound
datasetortask,wesoughttostartfromaneutral,large-scaleanalysis
of web text. We seeded our audio event lexicon using a modified madebysomeonecrashingintoacloseddoorwouldbeema-
formofthe“Hearstpatterns”[18]toidentifyhyponymsof“sound”, natingfromthedoor;however,itwouldnotbethecharacter-
i.e. terms that frequently occur in constructions of the form “... isicshortburstofbearingnoisethatsuggests“Slidingdoor”,
sounds,suchasXandY...”or“X,Y,andothersounds...”,etc.Ap- soitshouldinsteadbelabeled“Smash”or“Thump”.
plyingtheserulesoverweb-scaletextyieldsaverylargesetofterms,
|     |     |     |     | • Displayname: |     | Abriefoneortwowordnameforthesound, |     |     |     |     |
| --- | --- | --- | --- | -------------- | --- | ---------------------------------- | --- | --- | --- | --- |
whicharethensortedintermsofhowwelltheyrepresentsounds-
sometimeswithasmallnumberofcomma-separatedalterna-
calculatedasacombinationofoverallfrequencyofoccurrencewith
tives(e.g.,“Burst,pop”),andsometimeswithparenthesized
howexclusivelytheyareidentifiedashyponymsof“sound”rather
disambiguation(e.g.“Fill(withliquid)”).Displaynamesare
| thanotherterms. Thisgaveusastartinglistofover3000terms;as |     |     |     |     |     |     |     |     |     |     |
| --------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
intendedtobeunambiguousevenwhenshownwithouttheir
partofthematchingprocess,theywerealsoresolvedagainstFree-
ancestornodes.
base/KnowledgeGraphentity/machineIDs(MIDs)[19],whichwe
| useasstableidentifiers. |     |     |     | •            |     |                                          |     |     |     |     |
| ----------------------- | --- | --- | --- | ------------ | --- | ---------------------------------------- | --- | --- | --- | --- |
|                         |     |     |     | Description: |     | Alongerdescription,typicallyoneortwosen- |     |     |     |     |
Startingfromthetopofthesortedlist,wemanuallyassembled tences, used to provide more explanation of the meaning
ahierarchytocontainthesetermsinawaythatbestagreedwithour and limits of the class. In many cases these are based on
| intuitiveunderstandingofthesounds. |     | Thisstepissubjective,butit |     |     |     |     |     |     |     |     |
| ---------------------------------- | --- | -------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
bestcapturestheroleofthehierarchyinsupportinghumanlabelers. 1g.co/audioset

{
|     | Human sounds       |     |     | Sounds of things |                              |     |     |                  |               |             |               |      |        |
| --- | ------------------ | --- | --- | ---------------- | ---------------------------- | --- | --- | ---------------- | ------------- | ----------- | ------------- | ---- | ------ |
|     |                    |     |     |                  |                              |     |     | id: ’/m/020bb7’, |               |             |               |      |        |
|     | Human voice        |     |     |                  | Vehicle                      |     |     |                  |               |             |               |      |        |
|     |                    |     |     |                  |                              |     |     | name: ’Bird      | vocalization, | bird        | call,         | bird | song’, |
|     | Whistling          |     |     |                  | Engine                       |     |     |                  |               |             |               |      |        |
|     |                    |     |     |                  |                              |     |     | description:     | ’Bird         | sounds that | are melodious |      | to     |
|     | Respiratory sounds |     |     |                  | Domestic sounds, home sounds |     |     |                  |               |             |               |      |        |
|     | Human locomotion   |     |     |                  | Bell                         |     |     | the human        | ear.’,        |             |               |      |        |
Digestive Alarm citationuri: ’http://en.wikipedia.org/wiki/Bird
|     | Hands |     |     |     | Mechanisms |     |     | vocalization’, |     |     |     |     |     |
| --- | ----- | --- | --- | --- | ---------- | --- | --- | -------------- | --- | --- | --- | --- | --- |
Heart sounds, heartbeat Tools examples: ’youtu.be/vRg6EQm8pBw?start=30&end=40’,
Otoacoustic emission Explosion children: ’/m/07pggtf,/m/07pggtn,/m/07sx8x’,
|     | Human group actions |     |     |     | Wood |     |     | restrictions: | ’’  |     |     |     |     |
| --- | ------------------- | --- | --- | --- | ---- | --- | --- | ------------- | --- | --- | --- | --- | --- |
Glass
}
|     | Animal sounds |     |     |     | Liquid |     |     |     |     |     |     |     |     |
| --- | ------------- | --- | --- | --- | ------ | --- | --- | --- | --- | --- | --- | --- | --- |
Miscellaneous sources
Domestic animals, pets Fig.2: ThefulldatarecordforonesoundcategoryfromtheAudio
Specific impact sounds
Livestock, farm animals, Set Ontology. The children correspond to “Tweet”, “Chirp”, and
working animals
“Squawk”.
|     | Wild animals |     |     | Source-ambiguous |     |     |     |     |     |     |     |     |     |
| --- | ------------ | --- | --- | ---------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
sounds
|     | Natural sounds |     |     |     | Generic impact sounds |     |     |     |     |     |     |     |     |
| --- | -------------- | --- | --- | --- | --------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
Wind Surface contact all10secondslong(exceptwhenthatexceedsthelengthoftheun-
Thunderstorm Deformable shell derlyingvideo). Eachdatasetsegmentcarriesoneormoreontology
|     | Water |     |     |     | Onomatopoeia |     |     | classlabels. |     |     |     |     |     |
| --- | ----- | --- | --- | --- | ------------ | --- | --- | ------------ | --- | --- | --- | --- | --- |
|     | Fire  |     |     |     | Silence      |     |     |              |     |     |     |     |     |
Other sourceless
|     | Music |     |     |     |     |     |     | 3.1. Humanrating |     |     |     |     |     |
| --- | ----- | --- | --- | --- | --- | --- | --- | ---------------- | --- | --- | --- | --- | --- |
Channel, environment
Musical instrument Humanraterswerepresentedwitha10-secondsegmentsincluding
and background
Music genre boththevideoandaudiocomponents,butdidnothaveaccesstothe
Musical concepts Acoustic environment titleorothermeta-informationoftheunderlyingYouTubevideo. If
Music role Noise thedurationofthevideowaslessthan10seconds,theentirevideo
Sound reproduction
Music mood was used for rating. We experimented both with shorter segments
|     |     |     |     |     |     |     |     | and audio-only | presentation, | but raters found | these | conditions | far |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------- | ------------- | ---------------- | ----- | ---------- | --- |
Fig.1:ThetoptwolayersoftheAudioSetontology.
|     |     |     |     |     |     |     |     | moredifficult, | possiblyduetothefine-grainednatureofouraudio |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | -------------- | -------------------------------------------- | --- | --- | --- | --- |
eventontology.
|     | Wikipedia | or  | WordNet | descriptions | (with | appropriate | cita- |     |     |     |     |     |     |
| --- | --------- | --- | ------- | ------------ | ----- | ----------- | ----- | --- | --- | --- | --- | --- | --- |
tionURIs),adaptedtoemphasizetheirspecificuseforaudio For each segment, raters were asked to independently rate the
events. presenceofoneormorelabels.Thepossibleratingswere“present”,
|     |             |           |                                          |             |        |       |            | “notpresent”and“unsure”. |                   | Eachsegmentwasratedbythreeraters |            |     |             |
| --- | ----------- | --------- | ---------------------------------------- | ----------- | ------ | ----- | ---------- | ------------------------ | ----------------- | -------------------------------- | ---------- | --- | ----------- |
|     | • Examples: |           | Asanalternativetothetextualdescriptions, |             |        |       | we         |                          |                   |                                  |            |     |             |
|     |             |           |                                          |             |        |       |            | and a majority           | vote was required | to record                        | an overall |     | rating. For |
|     | also        | collected | at least                                 | one example | of the | sound | (excepting |                          |                   |                                  |            |     |             |
speed,asegment’sthirdratingwasnotcollectedifthefirsttworat-
|     | “Abstract” | classes, | described | below). | At  | present, | all exam- |     |     |     |     |     |     |
| --- | ---------- | -------- | --------- | ------- | --- | -------- | --------- | --- | --- | --- | --- | --- | --- |
ingsagreedforalllabels.
plesareprovidedasURLsindicatingshortexcerptsfrompub-
|     |     |     |     |     |     |     |     | The raters | were unanimous | in 76.2% | of votes. | The | “unsure” |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | -------------- | -------- | --------- | --- | -------- |
licYouTubevideos. Theexerciseoffindingconcreteexam- ratingwasrare,representingonly0.5%ofresponses,so2:1majority
ples for each class was helpful in flushing out indistinct or votesaccountfor23.6%ofthedecisions. Categoriesthatachieved
ambiguouscategoriesfromearlierversionsoftheontology. thehighestrateragreementinclude“Christmasmusic”,“Accordion”
and“Babbling”(>0.92);whilesomecategorieswithlowagreement
• Children:Thehierarchyisencodedbyincludingwithineach
include“Basketballbounce”,“Boiling”and“Bicycle”(<0.17).
nodetheMIDsofalltheimmediatechildrenofthatcategory.
Spotcheckingrevealedasmallnumberoflabelingerrorswhich
|     | • Restrictions: |     | Of the | 632 categories, | 56  | are “blacklisted”, |     |                         |     |                                    |     |     |     |
| --- | --------------- | --- | ------ | --------------- | --- | ------------------ | --- | ----------------------- | --- | ---------------------------------- | --- | --- | --- |
|     |                 |     |        |                 |     |                    |     | weremostlyattributedto: |     | 1)confusinglabels,2)humanerror,and |     |     |     |
meaningtheyarenotexposedtolabelersbecausetheyhave
|     |     |     |     |     |     |     |     | 3) difference | in detection | of faint/non-salient | audio | events. | As an |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------- | ------------ | -------------------- | ----- | ------- | ----- |
turnedouttobeobscure(e.g.,“Altosaxophone”)orconfus-
additionalcheckweanalyzedcorrelationsbetween“present”labels
|     | ing(e.g.,“Soundsofthings”). |        |                  |     | Another22nodesaremarked |      |            |                               |     |                          |     |     |     |
| --- | --------------------------- | ------ | ---------------- | --- | ----------------------- | ---- | ---------- | ----------------------------- | --- | ------------------------ | --- | --- | --- |
|     |                             |        |                  |     |                         |      |            | andwordsinthevideo’smetadata. |     | Thisexposedsomecommonly- |     |     |     |
|     | “Abstract”                  | (e.g., | “Onomatopoeia”), |     | meaning                 | that | they exist |                               |     |                          |     |     |     |
misinterpretedlabels,whichwerethenremovedfromtheontology.
|     | purely | as intermediate |     | nodes to | help structure | the | ontology, |     |     |     |     |     |     |
| --- | ------ | --------------- | --- | -------- | -------------- | --- | --------- | --- | --- | --- | --- | --- | --- |
Duetothescaleofthedataandsincemajorityagreementwasvery
andarenotexpectedtoeverbeuseddirectlyaslabels.These
high,nootherothercorrectiveactionsweretaken.
flagsappearintheRestrictionsfield.
Figure2showsthecompleterecordforasingleexamplecate- 3.2. Selectingsegmentsforrating
gory,“Birdvocalization,birdcall,birdsong”.
Inordertoobtainasufficientnumberofpositiveratingsfromamod-
eratevolumeoflabelingeffort,itisimportanttosendforratingonly
thosethathaveagoodchanceofcontainingparticularaudioevents.
|     |     |     | 3. AUDIOSETDATASET |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | ------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
Weusedavarietyofmethodstoidentifyvideosthatwerelikely
|     |       |             |        |          |            |         |      | to be relevant | to particular | labels: About | half of | the audio | events |
| --- | ----- | ----------- | ------ | -------- | ---------- | ------- | ---- | -------------- | ------------- | ------------- | ------- | --------- | ------ |
| The | Audio | Set YouTube | Corpus | consists | of labeled | YouTube | seg- |                |               |               |         |           |        |
ments, structured as a CSV file2 comprising YouTube identifiers, correspondedtolabelsalreadypredictedbyaninternalvideo-level
start time, end timeand oneor more labels. Dataset segmentsare automatic annotation system, and we used the videos bearing the
|     |     |     |     |     |     |     |     | label to provide | segments | for rating. The | labels | from | the inter- |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | -------- | --------------- | ------ | ---- | ---------- |
2g.co/audioset nalvideolabelingsystemareautomaticallygeneratedandthusin-

Audio class 3.3. Datasetconstructionandcharacteristics
Music 1,006,882 The released dataset constitutes a subset of the collected material:
Speech 893,911 Only “present” ratings are represented in the release. Rating was
Vehicle 80,422 conducted with an effort to maximize balance across audio event
Musical Instrument 74,729 labels. However, since segments can be labeled with multiple au-
Guitar 30,466 dioevents(includingthealways-rated“Speech”and“Music”),cer-
235 classes omitted ... tain labels appear much more frequently. A second objective was
Sizzle 969 toavoiddrawingmorethanonesegmentfromanygivenvideo, to
Heart sounds, heartbeat 963 avoidcorrelationofexamples.
Rooster 955 Theseobjectiveswereachievedbyiterativelyaddingsegments
Tire squeal 955 fortheleast-representedclass(forwhichfurtherexamplesareavail-
Fixed-wing aircraft 953 able).Outofthesetofcandidatesegmentsforthisaudioeventclass,
235 classes omitted ... preference is given to segments bearing the greatest number of la-
Squeak 127 bels. We also provide maximally-balanced train and test subsets
Shatter 126 (fromdisjointvideos),chosentoprovideatleast50positiveexam-
Zing 126 ples (in both subsets) for as many classes as possible. These sets
Slap 123 wereconstructedbyfirstcollectingexamplesfortherarestclasses,
Screech 121 thenmovingontoless-rareclassesandaddingmoresegmentsonly
where they had not already passed the threshold of 50. Even so,
100 1,000 10,000 100,000 1,000,000
verycommonlabelssuchas“Music”endedupwithmorethan5000
Number of examples labels.
The resulting dataset includes 1,789,621 segments (4,971
Fig.3:Histogramoflabelcountsovertheentire1,789,621segment hours), comprising at least 100 instances for 485 audio event cat-
dataset. egories. Theremainingcategoriesareeitherexcluded(blacklisted/
abstractasdescribedinsection2.1),ordifficulttofindusingourcur-
rentapproaches.Wewillcontinuetodevelopmethodsforproposing
segments for rating, and aim eventually to cover all non-excluded
classes. Theunbalancedtrainsetcontains1,771,873segmentsand
evitablyimperfect. Theyare, however, basedonmultiplecomple-
the evaluation set contains 17,748. Because single segments can
mentary sources of information, such as metadata, anchor text of
havemultiplelabels(onaverage2.7labelspersegment),theoverall
incominglinks, comments, anduserengagementsignals, andtheir
countoflabelsisnotuniform,andisdistributedasshowninFig. 3.
reliability is greatest for popular videos which have more of these
“Music”isparticularlycommon,presentin56%ofthesegments.
attributes.Wethereforeselectonlyvideoswithatleast1,000views.
In addition, videos were selected by searching titles and other
4. BENCHMARK
metadataforrelevantkeywords. Weusedaranking-basedapproach
wherevideoswerescoredbymatchingnotonlyagainstthedisplay
Togiveasenseoftheperformancepossiblewiththisdata,wehave
nameoftheaudioevent, butalso, withdecreasingweight, itspar-
trainedasimplebaselinesystem. Usingtheembeddinglayerrepre-
entsintheontology. Includingtheterm“sound”asarootnodein
sentationofadeep-networkclassifiertrainedonalargesetofgeneric
thesesearchesimprovedtheprecisionofresults.Temporalselection
videotopiclabels[22],weusedthetrainingportionoftheAudioSet
of segments with the returned videos was arbitrary, typically tak-
YouTubeCorpustotrainashallowfully-connectedneuralnetwork
ing segments with a start time at 30 sec to avoid any introduction
classifierforthe485categoriesinthereleasedsegments. Weeval-
orchannelbrandingatthestartofthevideo. Forsomeofthedata,
uatedonthetestpartitionbyapplyingtheclassifierto1secframes
temporal selection was based on content analysis such as nearest-
takenfromeachsegment,averagingthescores,thenforeachcate-
neighboursearchbetweenthemanually-verifiedclipsclipsandthe
goryrankingallsegmentsbytheirscores. Thissystemgaveabal-
label-specificcandidatevideos.
anced mean Average Precision across the 485 categories of 0.314,
andanaverageAUCof0.959(correspondingtoad-primeclasssep-
Usingallthesetechniques,thereweresomecategoriesforwhich
arationof2.452). ThecategorywiththebestAPwas“Music”with
wewereunabletofindenoughpositiveexamplestofullypopulate
AP/AUC/d-primeof0.896/0.951/2.34(reflectingitshighprior);
thedataset,butthisproportionisnowverysmall(andshrinking).
theworstAPwasfor“Rattle”with0.020/0.796/1.168.
Ingeneralwefoundthatsegmentsnominatedbytheautomatic
videoannotationsystemperformedthebest(49%ofsegmentsrated
5. CONCLUSION
present, versus 41% for the metadata-based approach), with the
caveat that not all audio classes are included. For audio classes We have introduced the Audio Set dataset of generic audio events,
not included in the automatic annotations, 36% of the metadata-
comprisinganontologyof632audioeventcategoriesandacollec-
basedsegmentswereratedpresent.Theeffectivenessofthecontent-
tionof1,789,621labeled10secexcerptsfromYouTubevideos.The
similarityapproachesvariedwidelydependingonthequalityofthe
ontology is hierarchically structured with the goal of covering all
exampleandthecandidatesetofvideos.
acousticdistinctionsmadebya‘typical’listener. Wearereleasing
thisdatatoaccelerateresearchintheareaofacousticeventdetection,
Regardless of the mechanism by which a segment was nom-
justasImageNethasdrivenresearchinimageunderstanding.Inthe
inated, we gathered ratings for all labels associated with the seg-
future, we hope to be able to make larger and improved releases,
mentbyanymethod. Additionally,wealwayscollectedratingsfor
ideallyincludingcontributionsfromthewidercommunity.
“Speech”and“Music”(exceptingafewexperimentalruns).

6. REFERENCES [16] Dan Stowell, Dimitrios Giannoulis, Emmanouil Benetos,
MathieuLagrange,andMarkDPlumbley,“Detectionandclas-
[1] AlexKrizhevsky,IlyaSutskever,andGeoffreyEHinton,“Ima- sificationofacousticscenesandevents,”IEEETransactionson
genetclassificationwithdeepconvolutionalneuralnetworks,” Multimedia,vol.17,no.10,pp.1733–1746,2015.
in Advances in neural information processing systems, 2012, [17] Annamaria Mesaros, Toni Heittola, and Tuomas Virtanen,
pp.1097–1105.
|     |     |     |     |     |     |     | “TUT database | for acoustic scene | classification | and sound |
| --- | --- | --- | --- | --- | --- | --- | ------------- | ------------------ | -------------- | --------- |
[2] Christian Szegedy, Wei Liu, Yangqing Jia, Pierre Sermanet, event detection,” in 24th European Signal Processing Con-
ScottReed,DragomirAnguelov,DumitruErhan,VincentVan- ference 2016 (EUSIPCO 2016), Budapest, Hungary, 2016,
houcke,andAndrewRabinovich, “Goingdeeperwithconvo- http://www.cs.tut.fi/sgn/arg/dcase2016/.
lutions,” inProceedingsoftheIEEEConferenceonComputer [18] Marti A Hearst, “Automatic acquisition of hyponyms from
VisionandPatternRecognition,2015,pp.1–9. largetextcorpora,” inProceedingsofthe14thconferenceon
[3] Kaiming He, Xiangyu Zhang, Shaoqing Ren, and Jian Sun, Computationallinguistics-Volume2.AssociationforCompu-
“Deepresiduallearningforimagerecognition,”arXivpreprint tationalLinguistics,1992,pp.539–545.
arXiv:1512.03385,2015.
|     |     |     |     |     |     |     | [19] Amit Singhal, | “Introducing | the knowledge | graph: |
| --- | --- | --- | --- | --- | --- | --- | ------------------ | ------------ | ------------- | ------ |
[4] OlgaRussakovsky, JiaDeng, HaoSu, JonathanKrause, San- things, not strings,” 2012, Official Google blog,
jeev Satheesh, Sean Ma, Zhiheng Huang, Andrej Karpathy, https://googleblog.blogspot.com/2012/05/
AdityaKhosla,MichaelBernstein,etal.,“Imagenetlargescale introducing-knowledge-graph-things-not.
| visualrecognitionchallenge,” |     |     | InternationalJournalofCom- |     |     |     | html. |     |     |     |
| ---------------------------- | --- | --- | -------------------------- | --- | --- | --- | ----- | --- | --- | --- |
puterVision,vol.115,no.3,pp.211–252,2015. [20] GeorgeAMiller, “WordNet: alexicaldatabaseforEnglish,”
[5] WilliamHWarrenandRobertRVerbrugge,“Auditorypercep- CommunicationsoftheACM,vol.38,no.11,pp.39–41,1995.
tionofbreakingandbouncingevents: acasestudyinecolog- [21] SamNorman-Haignere,NancyGKanwisher,andJoshHMc-
icalacoustics,” JournalofExperimentalPsychology: Human Dermott, “Distinctcorticalpathwaysformusicandspeechre-
perceptionandperformance,vol.10,no.5,pp.704,1984.
|     |     |     |     |     |     |     | vealedbyhypothesis-freevoxeldecomposition,” |     |     | Neuron,vol. |
| --- | --- | --- | --- | --- | --- | --- | ------------------------------------------- | --- | --- | ----------- |
[6] JamesABallas, “Commonfactorsintheidentificationofan 88,no.6,pp.1281–1296,2015.
assortmentofbriefeverydaysounds,” Journalofexperimental [22] Shawn Hershey, Sourish Chaudhury, Daniel P. W. Ellis, Jort
psychology: humanperceptionandperformance,vol.19,no. Gemmeke, Aren Jansen, R. Channing Moore, Manoj Plakal,
2,pp.250,1993. Rif A. Saurous, Brian Seybold, Malcolm Slaney, and Ron
[7] BrianGygi,GaryRKidd,andCharlesSWatson, “Similarity Weiss, “CNN architectures for large-scale audio classifica-
and categorization of environmental sounds,” Perception & tion,” inIEEEICASSP2017,NewOrleans,2017.
psychophysics,vol.69,no.6,pp.839–855,2007.
| [8] Guillaume                                 | Lemaitre | and | Laurie M. | Heller, | “Evidence | for a   |     |     |     |     |
| --------------------------------------------- | -------- | --- | --------- | ------- | --------- | ------- | --- | --- | --- | --- |
| basiclevelinataxonomyofeverydayactionsounds,” |          |     |           |         |           | Experi- |     |     |     |     |
mentalBrainResearch,vol.226,pp.253–264,2013.
| [9] WilliamWGaver, |     | “Whatintheworlddowehear?anecolog- |                    |     |            |      |     |     |     |     |
| ------------------ | --- | --------------------------------- | ------------------ | --- | ---------- | ---- | --- | --- | --- | --- |
| ical approach      |     | to auditory                       | event perception,” |     | Ecological | psy- |     |     |     |     |
chology,vol.5,no.1,pp.1–29,1993.
| [10] Tohomiro                           | Nakatani | and | Hiroshi G Okuno, | “Sound          |     | ontology |     |     |     |     |
| --------------------------------------- | -------- | --- | ---------------- | --------------- | --- | -------- | --- | --- | --- | --- |
| forcomputationalauditorysceneanalysis,” |          |     |                  | inProceedingfor |     |          |     |     |     |     |
the1998conferenceoftheAmericanAssociationforArtificial
Intelligence,1998.
[11] SusanneBurger,QinJin,PeterFSchulam,andFlorianMetze,
| “Noisemes:    | Manualannotationofenvironmentalnoiseinau- |            |                |          |     |        |     |     |     |     |
| ------------- | ----------------------------------------- | ---------- | -------------- | -------- | --- | ------ | --- | --- | --- | --- |
| dio streams,” |                                           | Tech. Rep. | CMU-LTI-12-07, | Carnegie |     | Mellon |     |     |     |     |
University,2012.
| [12] JustinSalamon,ChristopherJacoby,andJuanPabloBello, |     |     |     |     |            | “A  |     |     |     |     |
| ------------------------------------------------------- | --- | --- | --- | --- | ---------- | --- | --- | --- | --- | --- |
| datasetandtaxonomyforurbansoundresearch,”               |     |     |     |     | inProceed- |     |     |     |     |     |
ingsofthe22ndACMinternationalconferenceonMultimedia.
ACM,2014,pp.1041–1044.
| [13] Sebastian   | Sager, | Damian      | Borth, Benjamin    |             | Elizalde, | Chris-   |     |     |     |     |
| ---------------- | ------ | ----------- | ------------------ | ----------- | --------- | -------- | --- | --- | --- | --- |
| tian Schulze,    |        | Bhiksha     | Raj, Ian Lane,     | and Andreas |           | Dengel,  |     |     |     |     |
| “Audiosentibank: |        | Large-scale | semantic           | ontology    | of        | acous-   |     |     |     |     |
| tic concepts     |        | for audio   | content analysis,” |             | arXiv     | preprint |     |     |     |     |
arXiv:1607.03766,2016.
| [14] Erling                                            | Wold,                                    | Thom   | Blum, Douglas       | Keislar, | and           | James |     |     |     |     |
| ------------------------------------------------------ | ---------------------------------------- | ------ | ------------------- | -------- | ------------- | ----- | --- | --- | --- | --- |
| Wheaten,                                               | “Content-basedclassification,            |        |                     | search,  | andretrieval  |       |     |     |     |     |
| ofaudio,”                                              | IEEEmultimedia,vol.3,no.3,pp.27–36,1996. |        |                     |          |               |       |     |     |     |     |
| [15] Andrey                                            | Temko,                                   | Robert | Malkin, Christian   | Zieger,  | Dusˇan        | Ma-   |     |     |     |     |
| cho, ClimentNadeu,                                     |                                          |        | andMaurizioOmologo, |          | “Clearevalua- |       |     |     |     |     |
| tionofacousticeventdetectionandclassificationsystems,” |                                          |        |                     |          |               | in    |     |     |     |     |
InternationalEvaluationWorkshoponClassificationofEvents,
ActivitiesandRelationships.Springer,2006,pp.311–322.
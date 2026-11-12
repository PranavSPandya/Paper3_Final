Sentiment and Social Signals in the Climate Crisis: A Survey on
Analyzing Social Media Responses to Extreme Weather Events
PouyaShaeri∗ YasamanMohammadpour∗
pshaeri@asu.edu ymoham15@asu.edu
SchoolofComputingandAugmentedIntelligence, NewCollegeofInterdisciplinaryArtsandSciences,
ArizonaStateUniversity ArizonaStateUniversity
Tempe,Arizona,USA Tempe,Arizona,USA
AlimohammadBeigi ArianeMiddel
abeigi@asu.edu ariane.middel@asu.edu
SchoolofComputingandAugmentedIntelligence, TheGAMESchool,
ArizonaStateUniversity ArizonaStateUniversity
Tempe,Arizona,USA Tempe,Arizona,USA
Abstract climatescientists,publichealthofficials,policymakers,emergency
Extremeweathereventsdrivenbyclimatechange,suchaswildfires, responders,andcommunicationstrategists[27,125].
floods,andheatwaves,promptsignificantpublicreactionsonsocial Oneofthemostdirectandunfilteredsourcesofpublicresponse
mediaplatforms.Analyzingthesentimentexpressedintheseonline inthemoderneraissocialmedia.PlatformslikeTwitter(nowX),
discussionscanoffervaluableinsightsintopublicperception,in- Reddit,Facebook,andTikTokhavebecomeessentialspaceswhere
formpolicydecisions,andenhanceemergencyresponses.Although peoplesharetheirexperiences,expresstheirconcerns,voicetheir
sentimentanalysishasbeenwidelystudiedinvariousfields,its anger or solidarity, and seek information or emotional support
specificapplicationtoclimate-inducedevents,particularlyinreal- duringandafterclimate-relateddisasters[19,55,131,209].These
time,high-impactsituationslikethe2025LosAngelesforestfires, digitalplatformsservenotonlyasoutletsforindividualsentiment
remainsunderexplored.Inthissurvey,wethoroughlyexaminethe butalsoassociotechnicalsystemsthatinfluencecollectiveunder-
methods,datasets,challenges,andethicalconsiderationsrelated standingandpublicopinion[126,127,153].Theyofferadynamic
tosentimentanalysisofsocialmediacontentconcerningweather andrichsourceforcomputationalsentimentanalysis, allowing
andclimatechangeevents.Wepresentadetailedtaxonomyofap- forthestudyofemotionalresponsestoclimateeventsonalarge
proaches,rangingfromlexicon-basedandmachinelearningmodels scale,inreal-time,andacrossvariousdemographicandgeographic
tothelateststrategiesdrivenbylargelanguagemodels(LLMs).Ad- segments[183].
ditionally,wediscussdatacollectionandannotationtechniques, However,miningsentimentfromsocialmediaduringclimate
includingweaksupervisionandreal-timeeventtracking.Finally, crisesisacomplextask.Unlikestructuredsurveysorformalre-
wehighlightseveralopenproblems,suchasmisinformationdetec- ports,socialmediadataisunstructured,fleeting,andmultimodal[8,
tion,multimodalsentimentextraction,andmodelalignmentwith 103,170,197].Postsmayincludesarcasm,codedlanguage,memes,
humanvalues.Ourgoalistoguideresearchersandpractitionersin images,andcontextualreferencesthatrequiredeeplinguisticand
effectivelyunderstandingsentimentduringtheclimatecrisisera. culturalunderstandingforaccurateinterpretation[127,151].Addi-
tionally,theemotionaltoneofclimatediscourseisoftenintertwined
Keywords withpoliticalideology,narrativesofenvironmentaljustice,mis-
information,andconspiracytheories,whichcomplicatesefforts
sentimentanalysis,climatechange,socialmedia,misinformation,
forobjectiveanalysis[69,109,200].Therapidchangesintrending
heatcrisis,extremeweatherevents
hashtags,newslang,andplatform-specificconventionscontribute
tothelinguisticvolatilityofplatforms,makingitmorechalleng-
1 Introduction
ing[9,150].
Asclimateinstabilityintensifies,societiesworldwidearegrappling
Despitethesechallenges,sentimentanalysisinthisfieldshows
notonlywiththephysicalconsequencesofextremeweatherevents
greatpotential.Byexamininghowindividualsfeel,whattheyfear,
butalsowiththeirpsychologicalandsocioculturalimpacts[60,142,
whomtheyblame,andwhichsolutionstheysupportorreject,re-
180].Catastrophiceventssuchaswildfires,hurricanes,floods,heat-
searcherscangainabetterunderstandingoftheemotionalcontext
waves,anddroughts—drivenbyhuman-inducedclimatechangeare
surroundingclimateevents[102,117,153].Thiscanleadtobet-
occurringwithincreasingfrequency,severity,andunpredictabil-
terempatheticdisastercommunicationstrategies,identifymental
ity[58,168,177].Theseeventsdonotoccurinisolation;theyare
healthstresssignals,revealmisinformationdynamics,andguide
partofacomplexwebofsocialnarratives,politicaldiscourse,me-
policydiscussions[2,30,46,192].
diaframing,andpublicemotion[9,34,117].Understandinghow
Inadditiontosuddenclimatedisasterslikewildfiresandhur-
individualsandcommunitiesemotionallyandbehaviorallyreactto
ricanes,chronicstressorssuchasextremesummerheatindesert
sucheventsiscrucialforawiderangeofstakeholders,including
citiesarebecominganincreasingpublichealthconcern.Urban
∗PouyaShaeriandYasamanMohammadpourcontributedequallytothiswork.
5202
tcO
11
]IS.sc[
4v73881.4052:viXra

ShaeriandMohammadpour,etal.
Data Collection
Sentiment
Climate Events Modeling
- Wildfires Social
- Heatwaves Media and
- Hurricanes, floods Real-World
Annotation
Impact
and
Policies
Figure1:Overviewoftheclimatesentimentpipelinelinkingextremeeventstosocialmediareactions,analyzedthroughdata,
models,andtheirsocietalimpact.Oursurveyfollowsthisstructure,reviewingexistingliteratureacrosseachstageofthe
pipeline.
areasintheU.S.Southwest,inparticular,faceheightenedwarm- ofmultilingualandmultimodalcorpora,insufficientreal-timemod-
ingduetotheUrban HeatIsland(UHI) effect, whichcanoften elingofsentimentevolution,andtheinadequaterepresentation
exceedtolerablelimitsduringsummerheatwaves[11,136,166]. ofmisinformation-awaresentimentsystems[103,110,197,206].A
Recentstudiesindicatethatprolongedexposuretoheatcanre- primarymotivationforthissurveyistheincreasingprevalenceof
sultinheatstress,physiologicalstrain,andemotionalexhaustion, AI-generatedmisinformationduringclimateemergencies.[69,135,
particularlyamongvulnerablegroupssuchasunhousedindivid- 206].Eventslikethe2025LAforestfiresrevealedhowsynthetic
uals[93,172].Discussionsabouttheseimpactsareincreasingly imagesandvideos,suchasfakedepictionsofburningHollywood
prevalentonsocialmedia,wherepublicsentimentreflectsdistress landmarks,canmisleadthepublic[4,35,70].
andfrustrationregardinginadequateurbaninfrastructure.There Inadditiontomethodologicalsynthesis,weexplorehowsenti-
are also rising calls for cooling interventions, such as shade or mentanalysisisincorporatedintoclimateadaptationandmitiga-
mistingsystems[31,81,189].Byconsideringextremeheatasa tionframeworks.Thisincludesitsuseincrisisdashboards,policy
slow-onsetclimatedisaster,webroadenthefocusofthissurveyto responsiveness, and early warning systems for emotional well-
incorporatetheemotionalandcommunicativeaspectsofprolonged being[27,55,63,73].Wealsoemphasizeeffortsthatextendbeyond
thermalcrises. classificationtoincludepsychologicalaspectsofemotionaltrauma,
Thissurveyprovidesathoroughoverviewofsentimentanalysis distress,andcollectivefeelingsduringenvironmentalcrises[111,
techniquesusedinsocialmediarelatedtoweatherandclimate 133,191].Finally,weconsiderthebroadersocietalimplications,
changeevents1.Whiletherearegeneralreviewsavailable,very includingconcernsaboutsurveillance,algorithmicbias,andthe
fewspecificallyaddresstheuniquechallenges,methodologies,and potentialmisuseofaffectivecomputing,especiallyinwaysthat
insightsthatemergeattheintersectionofclimatedisastersand mayreinforceinequalityormarginalizevulnerablevoices[11,12,
publicsentiment[6,164,197].Toframeourdiscussion,wewilluse 109,127,200].Thispaperoutlinesaroadmapforinterdisciplinary
the2025LosAngelesforestfiresasacasestudy.Thislarge-scale collaborationamongNLP,socialcomputing,environmentalcom-
wildfiresparkedintenseonlinediscourse,characterizedbygrief, munication,anddigitalhumanities,demonstratinghowemotional
outrage,politicalpolarization,andsystemiccritique[53,69]. signalsindigitaldiscoursecanenhanceourunderstandingand
Westartbydiscussingthefundamentalconceptsinsentiment responsetotheclimatecrisis(Figure1).
andemotionanalysis.Wecategorizetheapproachesintoseveral
types,includingearlylexicon-basedmethods,traditionalmachine
2 Preliminaries
learningmodels,andmorerecentdeeplearningarchitectures.Ad-
ditionally,wehighlighttheemerginguseoflargelanguagemodels Thissectiondefineskeyterms,techniques,andmodelingparadigms
(LLMs)likeGPT-4andLLaMA[24,108,115]. usedthroughoutthediscussion.Thepreliminariesorientreaders
Weexaminemethodsforreal-timedatacollectionandannota- fromdiversedisciplines—rangingfromNLPandmachinelearning
tion,includinghashtagtracking,socialmediascraping,andweak toclimatescienceandsocialmediastudies—byintroducingboth
supervision,whichareusedtocreatelabeleddatasetsduringrapidly domain-specificterminologyandthecomputationaltoolsappliedto
evolvingclimateevents[9,55,145].Specialattentionisgivento sentimentanalysisinthecontextofclimate-relatedsocialdiscourse.
thechallengesofannotatingsarcasm,emotionalnuance,andcross-
culturalexpressionsofemotioninhigh-stakesandpoliticallysensi-
2.1 KeyConcepts
tivecontexts[127,151,153].Wealsoexaminecurrentevaluation
strategiesanddatasets,highlightingkeyresearchgaps:theabsence SentimentAnalysis:Alsoknownasopinionmining,sentiment
analysisisthecomputationaltaskofidentifyingandcategorizing
the emotional valence expressed in a given piece of text. Most
1Thefullandextendedliteraturereview—includingallreferencesanalyzedandcat-
commonly,thisinvolveslabelinguser-generatedcontent—suchas
egorizedbeyondthosecitedinthismanuscript—isavailableattheproject’sGitHub
repository:https://github.com/pouyashaeri/ClimateSentiment tweets,Redditposts,orFacebookcomments—aspositive,negative,

SentimentandSocialSignalsintheClimateCrisis:ASurveyonAnalyzingSocialMediaResponsestoExtremeWeatherEvents
orneutral.Inthecontextofclimate-relatedevents,sentimentanal- Regression,DecisionTrees,andRandomForests.Althoughthese
ysishelpsdetectexpressionsofoutrage,fear,solidarity,blame,or modelsremaininterpretableandcomputationallyefficient,they
hopeintheaftermathorbuildupofenvironmentalcrises[26,120]. strugglewithinformallanguage,sarcasm,anddomain-specificter-
EmotionDetection:Emotiondetectionextendsbeyondbinaryor minologyprevalentinclimatediscourseonsocialmedia[55,159].
ternarysentimentclassificationbyidentifyingnuancedemotional NeuralModels:Withtheriseofdeeplearning,neuralarchitectures
statessuchasanger,anxiety,empathy,sadness,joy,orfrustration. likeConvolutionalNeuralNetworks(CNNs)andLongShort-Term
Theseemotionalsignalsprovideafiner-grainedlensintopublic Memorynetworks(LSTMs)[182]gainedprominenceforsentiment
perceptionandcanbeparticularlyimportantduringclimatedis- analysis.Thesemodelsareabletocapturesequentialdependencies
asters where emotional polarity alone may not be sufficient to andlocalcontextintextdata,betterhandlingnoisyandinformal
capturethefullspectrumofhumanreactions[63,153].Emotion socialmedialanguage.Inclimateapplications,LSTM-basedmod-
detectionmodelsoftenrelyonspecializedemotionlexiconsorare elshavebeenappliedtowildfirediscoursetoanalyzetemporal
fine-tunedusingemotion-labeledcorporasuchasGoEmotions[43] emotionalpatterns[63],whileCNNswereemployedinvisual-text
orEmpatheticDialogues[154]. sentimentfusionmodelsindisaster-relatedimagecaptioning[135].
HeatStress:Heatstressreferstothephysiologicalandpsycho- Transformer-Based Models: The introduction of transformer
logicalstrainthatoccurswhenthehumanbodyisexposedtoex- architectures,particularlyBERT(BidirectionalEncoderRepresenta-
tremeheat,particularlywhenitcannoteffectivelyregulateitsin- tionsfromTransformers)[45]anditsvariants(e.g.,RoBERTa[123],
ternaltemperature.Thisconditionisexacerbatedinurbanareas DistilBERT[161],ClimateBERT[201]),hasrevolutionizedtextclas-
duetotheUrbanHeatIsland(UHI)effect,wherebuiltenviron- sificationtasks.Transformersarepre-trainedonmassivecorpora
mentsretainheatmorethannaturallandscapes.Indesertcities andfine-tunedfordownstreamtaskswithrelativelysmalllabeled
likePhoenixorLasVegas,heatstresscanreachcrisislevelsdur- datasets. They excel at capturing long-range dependencies and
ingsummer,posingseverehealthriskstovulnerablepopulations contextualsemantics[153,197].Inclimatesentimentresearch,fine-
includingoutdoorworkers,children,theelderly,andunhoused tunedtransformers havebeenshowntooutperform traditional
individuals[72,73,193].Inthecontextofclimatecommunication, modelsinhandlingdomainshifts,contextualnuance,andmulti-
heatstressisnotonlyapublichealthissuebutalsoarecurring lingualinputs[171,206].
emotionalthemeinsocialmediaposts,whereusersexpressanxiety, LargeLanguageModels(LLMs):Themostrecentadvancement
exhaustion, and anger about ongoing exposure and insufficient inthefieldcomeswiththeemergenceofgenerativelargelanguage
urbanadaptation[27,137]. modelslikeGPT-3.5,GPT-4,Claude,andLLaMA.Thesemodels,
Event-Centric Sentiment: Unlike general sentiment analysis, trainedontrillionsoftokens,possessstrongcapabilitiesinzero-
event-centricsentimentfocusesonlinkingemotionaloraffective shotandfew-shotlearningthroughprompting.LLMscanbeused
expressionstospecificreal-worldeventsortriggers.Forinstance,a notonlyfordirectsentimentclassificationbutalsoforgenerating
tweetexpressingoutrageaboutdelayedwildfireevacuationefforts rationales,explanations,andevensyntheticlabeleddatasets[187].
maybetaggednotonlyasnegativebutalsotemporallyandcon- Inthecontextofclimateeventsentimentanalysis,LLMsofferthe
textuallytiedtoaspecificclimateevent(e.g.,the2025LosAngeles potentialforreal-timedeploymentandon-demandadaptationto
forestburns)[102,159].Thisapproachenablessentimenttracking neweventswithoutextensiveretraining[68,115].
acrossthetimelineofaneventandsupportstemporalandcausal Together,theseconceptsandmodelingparadigmsestablishthe
modelingofemotionaltrajectories. technicalandtheoreticalbasisfortherestofthissurvey.Aswe
MisinformationandDisinformation:Inclimatediscourse,the explorespecificmethodologies,datasets,andchallengesinsubse-
linebetweenfactandfictioncanoftenbeblurred.Misinformation quentsections,wewillreferbacktothesefoundationalideasto
referstofalseormisleadinginformationspreadwithoutharmful situateeachcontributionwithinthebroaderlandscapeofsentiment
intent,whereasdisinformationdenotesthedeliberatespreadofsuch analysisforclimatecommunication.
contenttomanipulateordeceive[152,197].Bothphenomenacan
significantlydistortsentimentanalysisoutcomesbyinfluencing
publicperceptionandemotionalresponsetoclimateevents.For
example,falsenarrativesaboutthecausesofawildfireorconspiracy 3 DataCollectionandAnnotation
theoriessurroundinggeoengineeringmayamplifyangerorfear
Theeffectivenessofsentimentanalysisforclimateeventsdepends
withinonlinecommunities[69].
largelyonthequalityoftheanalyzeddata.Buildingaccuratesentiment-
2.2 ModelingParadigms awaremodelsrequirescollectingrepresentative,relevant,andhigh-
fidelitysocialmediadata.However,thistaskdemandscarefulstrate-
Thesentimentanalysispipelinegenerallyinvolvespreprocessing
giesthatconsiderplatformdifferences,event-drivendynamics,and
socialmediadata,extractingfeatures,trainingmodels,andeval-
linguisticdiversity[75,199].Annotationqualityisequallycrucial,
uatingpredictions.Awiderangeofcomputationalmodelshave
asitdirectlyimpactsmodeltraining,evaluation,andbenchmarking.
beenemployedovertheyears,andtheircapabilitieshaveevolved
Thissectionreviewsmajordatasourcesandannotationmethodsin
alongsideadvancesinmachinelearningandNLP:
climatesentimentstudies.Severalworkshaveleveragedhashtags,
TraditionalMachineLearningModels:Earlyapproachestosen-
geolocation,andevent-basedkeywordsforsocialmediadatacollec-
timentanalysisoftenreliedonhand-engineeredfeatures—suchas
tion[9,145].Otherstudieshaveaddressedchallengesinannotating
n-grams,TF-IDFscores,andpart-of-speechtags—fedintoclassi-
emotionalnuancesacrosscultures,especiallyduringfast-evolving
calclassifiersincludingSupportVectorMachines(SVMs),Logistic
disastercontexts[117,127].

ShaeriandMohammadpour,etal.
3.1 SourcesofClimate-RelatedSocialMedia chargedoremotionallysubtle.Inter-annotatoragreement(e.g.,Co-
Data hen’skappa)isusedtoevaluatelabelreliability[10,117].
WeakSupervisionandLexicon-BasedLabeling:Insteadofrely-
Socialmediaprovidesamassive,real-timestreamofuser-generated
ingonexpensivemanuallabeling,manystudiesemployweaksuper-
contentthatcanreflectthecollectiveemotionallandscapeduring
visiontechniques,includinglexicon-basedmethodsusingresources
climateevents.Severalplatformsareparticularlyrelevantformin-
suchasVADER[83],NRCEmotionLexicon[139],SentiWordNet[23],
ingsentimentinthisdomain:
orAFINN[44].Thesetoolsscorewordsorphrasesbasedontheir
Twitter/XandMastodon:Twitterremainsthemostwidelyused
emotionalpolarityoraffectivestrengthandaggregatesentiment
sourceforclimate-relatedsentimentanalysisduetoitspublicna-
acrossapost.Whilescalable,lexicon-basedmethodsstrugglewith
ture,short-textformat,andwidespreaduseduringemergencies.
slang,sarcasm,negation,anddomain-specificlanguage(e.g.,cli-
Researcherstypicallycollecttweetsusingeventspecifichashtags
matejargonoractivistrhetoric),limitingtheirprecisioninclimate
(e.g.,#LAfire,#ClimateCrisis,#HeatWave),location-basedfilters,
sentimentapplications[57,183].
orkeyword-basedqueries.Twitter’sreal-timeAPIortoolssuchas
Rule-BasedandHeuristicMethods:Insomecases,heuristic
TweepyandHydratorarecommonlyusedtoscrapetweetcontent,
rulesaredefinedbasedonhashtags,emojis,orcommonphrases[83].
metadata,timestamps,andgeolocation(whenavailable).Mastodon,
Forexample,tweetscontaining#ClimateEmergencyorfire-related
adecentralizedalternativetoTwitter,offerssimilarmicroblogging
emojismaybeassumedtoconveynegativesentiment.Thesetech-
functionalitywithinafederatednetworkofindependentservers.
niquesofferlightweightlabelingstrategiesbutmustbeusedcau-
Althoughlesswidelyadopted,itspublicpostsandchronological
tiouslytoavoidbiasandovergeneralization[205,211].
timelinescanalsoserveasasourceforevent-basedsentimenttrack-
LLM-AssistedAnnotation:Thegrowingavailabilityofpowerful
ing[9,89,102].
LLMssuchasGPT-4andClaudehasenabledanewformofsemi-
Reddit: Reddit hosts long-form discussions in climate-focused
automatedannotation.Withappropriateprompting,LLMscanlabel
communities such as r/climate, r/environment, r/news, and
sentimentwithcontext-awareness,explaintheirreasoning,and
r/disasterpreppers.UnlikeTwitter,Redditsupportsin-depth,
evenprovideprobabilisticuncertaintyestimates.Insomestudies,
context-richexchangesthroughdialoguetrees,debates,andnu-
humanannotatorsrevieworverifyLLM-generatedlabels,creating
anced emotional reflection. Data are commonly collected using
hybridannotationpipelinesthatcombinescalewithinterpretabil-
PushshiftAPIsorcustomwebscraperstoaccesspostsandhierar-
ity[24,187].However,LLM-generatedlabelsmaystillreflectthe
chicalcommentthreadsforasentimentanalysis[127].
model’strainingbiasorhallucinateinterpretations,especiallyin
NewsArticleCommentSectionsandBlogs:Climatesentiment
emotionallychargedorculturallysensitivecontexts[5,24,143].
isalsoexpressedinthecommentsectionsofdigitalnewsarticles,
DistantSupervisionfromEmojisorReactions:Someresearchers
especiallyduringhigh-visibilityevents.Publiclyavailabledatasets
useemojisorplatform-specificreactions(e.g.,Facebook’s“angry”
orscrapedcontentfromplatformssuchasTheGuardian,CNN,or
or“sad”emojis)asdistantproxiesforemotionallabels.Whilenoisy,
localnewspapersprovidecomplementarysourcesforsentiment
this method enables the creation of large-scale labeled corpora
extractionthatdifferintoneandvocabularyfromtraditionalsocial
withminimalmanualinterventionandcanbeusedforpre-training
media[145].
sentimentmodels[8,121,178].
Multimodal Platforms (TikTok, Instagram, YouTube): Al-
AnnotationforComplexTasks:Inadditiontobasicsentiment,
thoughthissurveyfocusesontextualsentiment,itisimportantto
someclimatestudiesannotaterelatedtaskssuchasstancedetection
notethatplatformssuchasTikTokandInstagramcontainrichemo-
(support/oppositiontoclimateaction),misinformationclassifica-
tionalnarrativessharedthroughimages,videos,captions,andcom-
tion,emotionalintensity,orcauseattribution.Theserequiretask-
ments.Althoughhardertoprocess,theseplatformsofferagrowing
specificguidelinesandareoftenusedtotrainmulti-taskmodels
frontierformultimodalclimatesentimentanalysis[71,103].
capableofdeeperinterpretation[51,99,110,151].
Theannotationstrategyselectedinfluencesnotonlymodelper-
3.2 AnnotationTechniquesforClimate
formancebutalsothetypeofinsightsthatcanbederived.Given
Sentiment
thesubjectiveandpoliticizednatureofclimatediscourse,ensuring
Oncerawdataiscollected,itmustbeannotatedwithappropriate annotationconsistency,transparency,andethicaloversightiscriti-
sentimentlabelsbeforeitcanbeusedformodeltrainingorevalua- calforproducingtrustworthyandsociallyresponsiblesentiment
tion.Climate-relatedsocialmediadataoftencontainssubjective, analysissystems.
ambiguous,oremotionallycomplexexpressionsthatmakelabeling
4 MethodologyTaxonomy
difficult.Thefollowingarethemostcommonlyusedannotation
strategiesinthisdomain: Inthissection,wepresentastructuredtaxonomyofmethodologies
ManualAnnotation:Humanannotators—eitherdomainexperts used for sentiment analysis in the context of social media and
orcrowdworkersrecruitedviaplatformssuchasAmazonMechan- climate-relatedevents.Thesemethodscanbebroadlygroupedinto
icalTurkorProlific—labelsocialmediapostsbasedonpredefined fivecategories,reflectingboththehistoricalevolutionandcurrent
sentiment categories [18, 47]. These may include basic polarity state-of-the-artinNLP:lexicon-basedmethods,traditionalmachine
labels(positive,negative,neutral)orfine-grainedemotions(e.g., learning,deeplearningarchitectures,transformer-basedmodels,
anger,fear,hope,sadness).Manualannotationtypicallyyieldshigh- andLLMs.Eachcategorybringsuniquestrengthsandlimitationsin
qualitylabelsbutistime-consuming,expensive,andoftenincon- handlingthelinguisticcomplexity,emotionalnuance,anddomain-
sistentacrossannotators,especiallywhenthecontentispolitically specificityofclimatediscourse.

SentimentandSocialSignalsintheClimateCrisis:ASurveyonAnalyzingSocialMediaResponsestoExtremeWeatherEvents
4.1 Lexicon-BasedMethods RecurrentNeuralNetworks(RNNs):IncludingLSTMand
Lexicon-based methods are among the earliest and most inter- GatedRecurrentUnit(GRU)variants,RNNsaredesignedtomodel
pretableapproachestosentimentanalysis.Theserule-basedmod- sequentialtextdependenciesandcancapturetheflowofsentiment
elsrelyonpredefinedsentimentdictionaries—alsoknownaslexi- inlongertextsorthreads[50,54,62].
cons—thatassociateindividualwordsorphraseswithsentiment AttentionMechanisms:Theseallowmodelstodynamically
scores.Prominentlexiconsinclude: focusonrelevantpartsoftheinputtextwhenmakingpredictions,
SentiWordNet:AnextensionofWordNetthatassignspolarity improvingperformanceinemotionallycomplexormulti-topicin-
scores(positive,negative,objective)tosynsets. puts[116,129,174].
VADER(ValenceAwareDictionaryandsEntimentReasoner): Deeplearningmodelsoutperformtraditionalapproachesincap-
Alexiconandrule-basedsentimentanalysistooldesignedspecifi- turingcontext,emotion,andnon-linearrelationships.However,
callyforsocialmediatext,accountingforcapitalization,intensifiers, they typically require larger labeled datasets and are less inter-
negations,andemoticons. pretable.Theirperformancemaydegradewhenappliedtodomains
NRCEmotionLexicon:Associateswordswithmultipleemotional (likeclimatediscourse)withrareoremergingtermsnotwellrepre-
categoriessuchasanger,anticipation,andjoy. sentedinpretrainingdata[22,63,69].
AFINN:Assignsinteger-basedsentimentscorestowordsbasedon
theiremotionaltone. 4.4 Transformer-BasedModels
Thesemethodsarefast,transparent,andeasytoimplement,mak- Transformerarchitectures,particularlysincetheintroductionof
ingthemusefulforexploratoryanalysesorasweaksupervision BERT,havebecomethedominantparadigminNLP.Transformers
signalsindownstreamtasks.However,theystrugglewiththein- useself-attentionmechanismstomodelrelationshipsbetweenall
formal,ambiguous,andcontext-dependentnatureofsocialmedia tokensinasentencesimultaneously,allowingfordeepcontextual
language—particularlyinclimate-relateddiscussionswheresar- understandingrecentlyinclimateresearch.
casm,irony,activismrhetoric,ortechnicalterminologymaynot Keytransformermodelsusedinsentimentanalysisinclude:
berepresentedinthelexicon.Theyarealsolimitedincapturing BERT(BidirectionalEncoderRepresentationsfromTrans-
phrase-levelorsentence-levelsentimentcomposition,whereword- formers): Adeeplybidirectional modelpre-trainedon masked
levelpolaritymaybeinsufficient[102,159,208]. languagemodelingandnextsentenceprediction[41,104,194].
RoBERTa:ArobustlyoptimizedBERTvarianttrainedwithmore
4.2 TraditionalMachineLearningApproaches dataanddynamicmasking[17,140].
DistilBERTandALBERT:Lightweightalternatives[66,195].
Traditionalsupervisedmachinelearningmethodsformtheback-
ClimateBERT:Adomain-adaptedBERTmodelfine-tunedoncli-
boneofmanyearlysentimentclassifiers.Theseapproachestypi-
matechange-relatedtexts,improvingrelevanceforenvironmental
callyinvolvetransformingrawtextintonumericalfeaturerepresen-
discourse[64,165,201].
tations—suchas:Bag-of-Words(BoW)(Asimplefrequencycount
Thesemodelscanbefine-tunedonsmalllabeleddatasetsforsen-
ofwordsinadocument),TermFrequency-InverseDocument
timentclassification.Theyexcelathandlingcontext,sarcasm,nega-
Frequency (TF-IDF) (A weighting scheme that balances word
tion,andmulti-lingualsentiment,makingthemhighlyeffectivein
frequencywithdistinctivenessacrossdocuments),andN-grams
climate-relatedsocialmediaanalysis.However,theirinterpretabil-
andPOStags(Featurescapturingshortsequencesorgrammatical
ityandcomputationalcostremainareasofconcern,especiallyfor
structures).
real-timedeploymentduringrapidlyunfoldingevents[21,101].
Oncefeaturesareextracted,theyarefedintoclassifierssuch
asSupportVectorMachines(SVMs),NaiveBayes,Logistic
4.5 LLMsforSentimentAnalysis
Regression,andRandomForests.
Whilethesemodelsarerelativelylightweightandinterpretable, TheemergenceofgenerativeLLMssuchasGPT-3.5,GPT-4,Claude,
theyrelyheavilyonfeatureengineeringandcannotinherently andLLaMArepresentsanewfrontierinsentimentanalysis.Unlike
modelwordorderorsemantics.Thislimitstheirunderstanding fixedclassifiers,LLMscanbeprompteddynamicallytoperform
ofnuancedsentimentorevolvingslanginclimateconversations. zero-shotorfew-shotsentimentclassificationusingnaturallan-
Nonetheless,theyarestillwidelyusedasbaselinesorforensemble guageinstructions[76,106].Forexample,apromptsuchas:
methodswhencomputationalefficiencyisprioritized[13,20,128]. "Determinethesentimentofthefollowingtweet:‘Anotherdayof
orangeskiesandtoxicair.Whenwillthefiresend?’"→"Sentiment:
Negative.Reason:Thespeakerexpressesfrustrationanddespairabout
4.3 DeepLearningApproaches
ongoingwildfires."
Deeplearningrevolutionizedsentimentanalysisbyenablingmod- LargeLanguageModels(LLMs)offerflexiblesentimentanalysis
elstolearncomplexpatternsinrawtextdatawithoutrequiring throughprompt-basedinference,enablingthemtointerpretsar-
extensive manual feature engineering. The most common deep casm,moralnuance,andemotionalintensitywithouttask-specific
learningarchitecturesinclude: fine-tuning[24,28,188].Theycanalsogeneratesyntheticlabeled
ConvolutionalNeuralNetworks(CNNs):Originallydesigned dataandrationales,supportingdownstreammodelswithimproved
forimageprocessing,CNNshavebeenadaptedfortextclassification trainingsamplesandricheremotionalreasoning[82,185].
bytreatingsentencesasmatricesofwordembeddings.Theyare However,LLMsalsohavechallenges:theymayhallucinatelabels
particularlygoodatcapturinglocaln-grampatterns[54,94,97]. orexplanations,exhibitbias,orlacktransparencyintheirreasoning.

ShaeriandMohammadpour,etal.
Theiroutputsoftenrequirehumanoversight,especiallyinsensitive arebloodorange—thisisterrifying!”)[70,163].Asthefireswors-
orhigh-stakesdomainssuchasclimatemisinformationordisaster ened,negativesentimentpeaked,withsharpincreasesinanger,
response[25,198]. helplessness,andblameattribution[40,202].
Themethodologicallandscapeforsentimentanalysisinclimate BlameandPoliticalPolarization:Arecurringpatterninthe
discoursehasevolvedsignificantlyoverthelastdecade.Thechoice data was the attribution of responsibility. Users expressed frus-
ofmethoddependsonthenatureofthetask,thequalityandsize trationatperceivedgovernmentinaction,utilitycompanies(e.g.,
ofavailabledata,theurgencyofanalysis,andtheinterpretability PG&E),andclimateinactionbypoliticalleaders.Sentimentanalysis
orethicalconstraintsoftheapplication.Inthefollowingsections, clusteredbypoliticalhashtags(#GreenNewDeal,#ClimateHoax)
wedelveintothepracticaldeploymentofthesemodels,supported revealedstarkpolarization:someusersframedthefiresasevidence
bycasestudiesandperformancebenchmarks.Acomprehensive ofanthropogenicclimatechange,whileothersrejectedsuchnarra-
comparisonofsentimentanalysisapproachesappliedtoclimate- tives,attributingthecrisistopoorforestmanagementor“natural
relatedsocialmediaispresentedinTable1,organizingkeyliterature cycles”[61,122,144].
bymethodology,performance,keyfindings,andlimitations. EmergentThemes:Socialmediaplatformsalsoservedasdigi-
Theevolutionfromlexicon-basedmethods(65-75%accuracy)to taloutletsforpsychologicalcopingandcommunitysupport,where
Transformer-basedmethodsandLLMs(85-89%accuracy)shows expressionsoffear,confusion,andsolidarityofferedinsightinto
clearperformanceprogression.Lexiconmethodsofferinterpretabil- thepopulation’scollectiveemotionalburden.Fourthematicclus-
itybutstrugglewithcontext.TraditionalMLrequiresfeatureengi- tersemergedintheonlinediscourse:(1)PublicHealth:Concerns
neeringbutprovidesefficiency.Deeplearningcapturescomplex about air quality, asthma, and mask usage are often tied to on-
patternsbutneedslargedatasets.Transformersachievestrongcon- goingCOVID-19sensitivities[77,203].(2)SolidarityandSup-
textualunderstanding,whileLLMsofferflexibilitythroughprompt- port:Tweetsofferingshelter,fundraisinglinks,orexpressionsof
ingbutraisereliabilityconcerns. empathy(e.g.,“PrayingforSoCal”)[15,32,163,175].(3)Misin-
formation and Rumors: Unverified reports about evacuation
5 Event-CentricCaseStudies
zones,fireorigins,orconspiracytheories(e.g.,“directedenergy
Event-centricanalysisisapowerfullensthroughwhichwecan weapons”)alsospreadrapidly,confoundingsentimentclassification
understandhowsentimentevolvesinrealtimeandacrossdifferent efforts[35,162].(4)PsychologicalDistress:Manyusersopenly
phasesofaclimate-relateddisaster[85,124].Byfocusingonspecific sharedfeelingsofanxiety,burnout,andemotionalexhaustion,with
high-impactevents,researcherscanstudythetemporaldynamics postsreflectingsignsoftrauma,climategrief,andmentalhealth
ofemotionalexpression,theemergenceofmisinformation,therole strain—underscoringtheneedforintegratingpsychologicalmoni-
ofpoliticalandgeographicfactors,andthebroadersocio-cultural toringintocrisisresponsesystems[15,207].
implicationsofpublicdiscourse.Especially,whileearlierclimate Temporal Sentiment Modeling: Models such as Dynamic
disasterswereshapedbyorganicinformationflowsandtraditional BERTandLSTM-basedsentimenttrackersrevealedthatsentiment
medianarratives,the2025LosAngeles(LA)forestfiresunfoldedin fluctuations were tightly correlated with official press releases,
anerawherebothAI-generatedtextandsyntheticimagesplayed visualmediacoverage,andviralcontent[74,160].Theseresults
anactiveroleinmanipulatingpublicperception[69,203].This underscoretheneedfortemporally-awaresentimentsystemsthat
dualuseofAI—bothforanalyzingsentimentandforfabricating adapt to evolving discourse and event phases (e.g., onset, peak,
emotionally charged misinformation—marks a turning point in containment,aftermath)[186].
climatediscourse[35].Thissectionpresentsadetailedcasestudy
ofthe2025LAforestfires,followedbycomparativeinsightsdrawn
5.2 ComparisonwithPastEvents
frompriorglobalclimateevents[39,113].
Whilethe2025LAforestfiresrepresentarecentandhighlymedia-
5.1 LAForestFires(2025)
tizedcase—markedbybothAI-drivensentimentanalysisandthe
The2025LosAngeleswildfires,drivenbyseveredrought,high spreadofsyntheticmedia—sentimentpatternscanbecompared
winds,andextremeheat,becameoneofthemostdestructivein withearlierclimate-relateddisasters,whichunfoldedwithoutthe
U.S.history.Thefiresledtomassevacuations,extensiveproperty influenceofgenerativeAI,toidentifycommonalitiesanddiver-
damage,fatalities,andwidespreadsmokepollution.Publicsenti- gences.
mentsurgedacrosssocialmediainahighlynetworkedenviron- AustralianBushfires(2019–2020):The“BlackSummer”fires
ment[92,114].AI-generatedmisinformation,suchasfakeimages inAustraliageneratedaglobaloutpouringofemotiononplatforms
andfabricatednarratives,furthercomplicatedemotionalreactions likeTwitter,withwidespreadsympathy,internationalsolidarity
andpublicunderstanding[69,206].Theseemotionalresponsesre- (e.g.,donationcampaigns),andecologicalgriefoverwildlifeloss.
vealeddeeppsychologicalimpacts,includingtrauma,helplessness, Sentimentwaspredominantlynegative,butlesspoliticallypolar-
andenvironmentalgrief. izedthanintheU.S.context.Emotiondetectionhighlighteddeep
SentimentTrajectory:Usingtemporalsentimentanalysison sadness and despair, amplified by distressing images of burned
millionsofgeo-taggedandhashtag-filteredtweets(e.g.,#LAFires, koalasandscorchedlandscapes[1,138].
#LAWildfire,#SummerHeat,#ClimateCrisis),researchersobserved HurricaneIda(2021):SocialmediasentimentduringHurricane
pronouncedshiftsinpublicemotionasthefiresprogressed.The Ida,whichstrucktheGulfCoastandmovedintotheNortheastern
earlyphaseofthedisasterwasmarkedbyfearandanxiety,often U.S.,wasshapedbyresilience,resourcedisparity,andinfrastructure
expressedthroughexclamatory,urgentlanguage(e.g.,“Theskies failurethemes.Tweetsfromaffectedareasconveyedhelplessness

SentimentandSocialSignalsintheClimateCrisis:ASurveyonAnalyzingSocialMediaResponsestoExtremeWeatherEvents
Table1:Comprehensivecomparisonofsentimentanalysismethodologiesforclimate-relatedsocialmedia
Study Method Data/Event Performance KeyFindingsandLimitations
Lexicon-BasedMethods
Rosenbergetal.[156] VADER,TextBlob Twitter/ClimateSDGs VADER:56%,TextBlob:46% VADERbetter;keywordbias
|     |     |     | accuracy | remains |
| --- | --- | --- | -------- | ------- |
MohamadShamet Hybrid(TextBlob Twitter/Climate 75.3%F1-score Hybridoutperformsindividual
| al.[173] | +LR) | discussions |     | models |
| -------- | ---- | ----------- | --- | ------ |
Mendonetal.[132] TextBlob Twitter/KeralaFloods 9%neg,71%neutral,20% Combinedwithclustering;polarity
|     |     |     | pos | limitations |
| --- | --- | --- | --- | ----------- |
Amangeldietal.[14] PMI,NRCLex Twitter,Reddit, 65%accuracy PMIoutperformsVADER;domain
|     |     | YouTube |     | tuningneeded |
| --- | --- | ------- | --- | ------------ |
TraditionalMachineLearningMethods
Kimetal.[96] SVM,NB,LR,RF, News/Environmental 73%F1-Score MLmodelswithtermweighting;
|     | XGBoost | categories |     | lackssentimentcontext |
| --- | ------- | ---------- | --- | --------------------- |
Sabrietal.[158] SVM Twitter/Climate 91%accuracy, 90%F1-score SVMwithTF-IDF;focusedon
|     |     | awareness |     | awarenessdetection |
| --- | --- | --------- | --- | ------------------ |
Reyes-Menendezet SVM(MonkeyLearn) Twitter/#WorldEnvi- 72.4%accuracy SVMmapssentimenttoSDGs;
| al.[155] |     | ronmentDay |     | sarcasmmisclassification |
| -------- | --- | ---------- | --- | ------------------------ |
Thenmozhietal.[190] SVMwithTF-IDF Twitter/Climate 76.3%accuracy,70.5% SVMcapturesnuancedsentiment
|     |     | debates | F1-score |     |
| --- | --- | ------- | -------- | --- |
DeepLearningApproaches
Rumlawangetal.[157] LSTM Twitter/Climate 85.6%accuracy,84% LSTMcapturestemporalpatterns;
|     |     | sentiment(Indonesia) | F1-score | smalldataset |
| --- | --- | -------------------- | -------- | ------------ |
Wuetal.[204] BiLSTM Weibo/Climatetopics ∼90%accuracy BiLSTMrevealsspatio-temporal
trends;China-specific
Rumlawangetal.[157] LSTM Twitter/Climate 60%accuracy, 59%F1-score LSTMoutperformsMLbaselines;
|     |     | changesentiment |     | struggleswithneutralvsnegative |
| --- | --- | --------------- | --- | ------------------------------ |
|     |     | (Indonesia)     |     | distinction                    |
ElBarachietal.[49] BiLSTM Twitter/Real-time 89.3%accuracy Real-timetracking;classimbalance
|     |     | sentiment |     | issues |
| --- | --- | --------- | --- | ------ |
Marjanietal.[130] CNN-BiLSTM Social+ 73%F1-scoretrain,58% Social-physicalsignalfusion;
|     |     | Satellite/Wildfires | F1-scoreval | moderatetemporalaccuracy |
| --- | --- | ------------------- | ----------- | ------------------------ |
Transformer-BasedModels
Leippoldetal.[112] ClimateBERT News/Climaterisk 35.7%errorreductionvs Domainpretrainingboosts
|     |     | texts | BERT | performance |
| --- | --- | ----- | ---- | ----------- |
Ongetal.[146] RoBERTa, Twitter/Sustainable 88%accuracy Handlessentimentandtopics;
|     | DistilBERT | investing |     | financialbiasrisk |
| --- | ---------- | --------- | --- | ----------------- |
Garrido-Merchanet BERT FinancialReports 85%F1-score Fine-tunedforclimaterisk;
| al.[65] |     |     |     | finance-focused |
| ------- | --- | --- | --- | --------------- |
KrishnanandAnoop[105] ClimateBERT Twitter/Globalclimate 90.2%accuracy,85.5% Socialsentimentfocused;small
|     |     |     | F1-score | dataset |
| --- | --- | --- | -------- | ------- |
LargeLanguageModels
Andersonetal.[16] GPT-2 Twitter/Sustainability 84.3%accuracy GPT-2beatsMLbaselines;limited
|     |     | topics |     | fine-tuning |
| --- | --- | ------ | --- | ----------- |
Jengetal.[88] GPT-4o News/Climate Behavioralimprovementon GPT-4oforemotionalframing;lacks
|     |     | journalism | intent | standardmetrics |
| --- | --- | ---------- | ------ | --------------- |
FanandXu[52] GPT-4o,Claude Twitter, 52-68%neutralresponses; LLMsdemonstrateemotional
3.5,Gemma, Reddit/Climatechange significantlylower moderationinclimatediscussions
|     | Llama3/3.3 |     | emotionalintensity |     |
| --- | ---------- | --- | ------------------ | --- |
(p<0.001)
Linardosetal.[118] GPT-4o-mini Twitter/Disaster 70-86%accuracyby LLMaidstweetunderstanding;used
|     |     | response | category;66-87%F1-score | withMLclustering |
| --- | --- | -------- | ----------------------- | ---------------- |

ShaeriandMohammadpour,etal.
andfrustrationaboutpoweroutages,whilenationaldiscoursefo- HumanJudgmentandLLMOutputEvaluation:ForLLMs,hu-
cusedonemergencyresponse.Comparedtowildfirediscourse,the manevaluationisessentialtoassessexplanationquality,emotional
sentiment here was more logistical and survival-oriented, with coherence,andalignmentwithhumanreasoning[29,38,48,59].
fewerideologicaldivides[91,95]. FairnessandBiasAudits:ToolsandapproacheslikeEquityEvalu-
EuropeanHeatwaves(2022and2023):InWesternEurope, ationCorpus(EEC)[100]anddisparitymetricsdetectperformance
repeatedheatwavesfuelednegativesentimentaboutheatstress, gapsacrossdialectsorcommunities—criticalforensuringequitable
transportfailures,andpublichealth,whileirony,memes,anddark climatesentimentanalysis[67].
humorcomplicatedemotionclassification.Politicaldiscussionson
energy dependency, infrastructure, and climate denialism were
7 SocietalandEthicalImplications
prominentinFrench,German,andSpanishtweets,highlightingthe
needformultilingualsentimentanalysistools.[56,84,141,184]. Theuseofsentimentanalysisonclimate-relatedsocialmediacon-
Tohighlighttemporalshiftsinpublicclimatediscourse,wecom- tentintroducesseveralpressingsocietalandethicalconsiderations.
paresentimentpatternsacrossmajorclimateevents.Table2sum- Thesegobeyondtechnicalchallengesandencompassquestionsof
marizesdominantemotionsandkeycharacteristicsforeachevent, power,representation,accountability,andharmmitigation.Inthis
reflectingchangesinemotionaltoneandtheincreasinginfluence section,weexaminethreecoredimensionsofethicalconcern:bias,
ofAI-generatedcontent. misinformation,andtheresponsibleuseofuserdata.
ComparativeObservations:
UniversalEmotions:Fear,anxiety,andangerwerecommonacross
allevents,thoughexpressedinculturallyspecificways[27]. 7.1 BiasandRepresentation
EventTypeMatters:Firespromptedmorevividimageryandper- Sentimentanalysistools,especiallythosetrainedongeneral-purpose
sonalstorytelling;stormsinducedlogisticalandsurvival-focused or Western-centric corpora, often fail to accurately capture the
sentiments;heatwavesoftensparkedsystemiccritiquesandsatire[138]. voicesofmarginalizedgroupsorspeakersusingnon-standarddi-
TemporalRhythm:Sentimenttypicallyfollowsasurge-plateau alects,regionalslang,orculturallyspecificexpressions.Forinstance,
-declinepatternalignedwitheventprogressionandmediacover- AfricanAmericanVernacularEnglish(AAVE),Indigenousdialects,
age[79]. orimmigrantlanguagemixingmaybemisinterpretedasnegativeor
PlatformDifferences:Twitterfostersreal-timereactionandam- neutralduetounderrepresentationintrainingdata.Similarly,hash-
plification;Redditenablesreflectivedialogue;Facebookemphasizes tagsoremojisthatsignalcommunityidentityorresiliencemaybe
localcommunitysentiment[145]. incorrectlylabeledasemotionallyneutralorambiguous[111,147].
These case studies collectively illustrate the value of event- Moreover,climatediscourseitselfisshapedbyinequalitiesin
centricsentimentanalysisinclimatecommunicationresearch.They whohasaccesstodigitalplatforms,whoseexperiencesgetampli-
alsohighlighttheneedformodelsthatarecontext-aware,culturally fied,andwhosenarrativesarealgorithmicallysuppressed.These
sensitive,andcapableoftrackingemotionalshiftsovertimeand disparitiescanleadtosentimentanalysesthatoverrepresentafflu-
space. ent,English-speaking,urbanpopulationswhileunderrepresenting
frontlinecommunitieswhoexperiencetheworsteffectsofclimate
change[98,169,196].
6 EvaluationMetrics
Mitigatingthesebiasesrequiresinclusivedatacuration,diverse
Evaluatingsentimentanalysismodelsinclimatediscourserequires annotatorpools,dialect-awaremodeling,andexplicitfairnessbench-
interpretablemetricsthatreflectbothtechnicalperformanceand marks.
societalimpact.Thesemetricshavebeenwidelyusedinclimate-
relatedsentimentstudies[3,79,86,176].
7.2 MisinformationandItsEmotionalImpact
Accuracy,Precision,Recall,F1-Score:Commonclassification
metrics thatassess correctness, balance between false positives Climate discourse is frequently entangled with misinformation,
andnegatives,andoverallmodelreliability—especiallyunderclass conspiracytheories,andpoliticallymotivateddisinformationcam-
imbalanceduringcrisisevents[3,37,176]. paigns.Falseclaimsaboutthecausesofwildfires,denialofanthro-
Macrovs.MicroAveraging:Macro-averagedmetricshighlight pogenicclimatechange,orrumorsaboutevacuationorderscan
minority emotion categories, supporting fairness, while micro- triggerstrongemotionalreactions,whichinturnskewsentiment
averagedmetricsreflectoverallperformanceandscalability[33,86, distributions[149].
212]. Misinformationcanalsobestrategic:actorsmayintentionally
ConfusionMatrixAnalysis:Helpsuncoversystematicerrors, manipulatesentimentthroughcoordinatedcampaignstoinduce
suchasmisinterpretingsarcasmormisclassifyingangerasfear[36, panic, deflect blame, or suppress climate activism. Models that
179]. failtodetectoraccountforsuchmanipulationmayinadvertently
EmotionIntensityCorrelation:PearsonandSpearmancorrela- reinforcemisleadingnarrativesoramplifypolarization[87,149].
tionsassessagreementbetweenmodel-predictedandhuman-rated Futuresentimentsystemsexpectedtoincorporatemisinforma-
emotionstrength[80,119]. tiondetectionmodulesorco-trainingwithfact-checkingdatasets.
TemporalStability:Evaluateshowwellmodelsmaintainaccuracy Additionally,researchersmustreflectonwhethertoincludeorex-
acrossthetimelineofaclimateevent—fromonsettorecovery[42, cludemisinformation-drivenpostsinsentimentmodelingpipelines,
78,167]. andhowtoannotatethemappropriately.

SentimentandSocialSignalsintheClimateCrisis:ASurveyonAnalyzingSocialMediaResponsestoExtremeWeatherEvents
Table2:Comparativeanalysisofsentimentpatternsacrossmajorclimateevents
Event Year Dominant KeyCharacteristics
Emotions
AustralianBushfires 2019-20 Sadness,grief, Globalempathy,wildlifefocus,
solidarity minimalAI
HurricaneIda 2021 Fear,frustration, Infrastructurefailure,regional
resilience discourse
EuropeanHeatwaves 2022-23 Anger,irony,anxiety Multilingualcontent,satirical
responses
LAForestFires 2025 Fear,anger, Extensivesyntheticmedia,
helplessness politicalblame
7.3 EthicalUseandPrivacyConcerns Aerialphotosofwildfiredamage,videosoffloodedneighborhoods,
Analyzingpublicsentimentduringclimatedisasters,particularlyin orinfographicsonheatwavesallcarrystrongemotionalsignals.
real-time,raisescriticalquestionsaboutsurveillance,consent,and However,mostsentimentanalysismodelsremaintext-centric.Re-
dataethics.Whilemuchofsocialmediacontentistechnicallypublic, centworkhasexploredmultimodalsentimentanalysisinother
usersoftendonotexpecttheirpoststobeharvested,classified,or domains—such as general cross-lingual or affective computing
scrutinizedbyalgorithms—especiallyduringtraumaticeventssuch tasks[134,148,181]—butnotinthecontextofclimateresearch.
ashomeloss,injury,orcommunitydisplacement[90]. Futureworkshouldexplorefusionmodelsthatintegratevision
Real-timesentimenttrackingcanbebeneficialfordisasterre- andlanguage(e.g.,CLIP,LRQ-Fact,orimage-captionsentiment
sponseagencies,mentalhealthinterventions,orpolicydecision- alignment)tocapturethefullaffectivescopeofclimatediscourse.
making,butitalsorisksinfringingonpersonalprivacy,stigmatiz- Thisalsoincludesanalyzingvisualmisinformationoremotionally
ingcertaincommunities,orbeingrepurposedforcommercialor manipulativecontentinclimateactivismordenial.
politicalexploitation. Real-TimeEmotionDynamicsDuringEvolvingEvents:Cli-
Keyethicalguidelinesinclude: mateeventsunfoldovertime,oftenwithunpredictabletrajectories.
InformedConsent:Wherepossible,respectuserexpectations Thepublic’semotionalresponsecanshiftrapidly—fromfearand
andincludeethicaldisclosureswhendeployingsentimentsystems confusionduringtheearlystages,toangerandblameasimpacts
atscale[107]. escalate,togriefandfatigueintheaftermath.Capturingthesedy-
AnonymizationandAggregation:Alwaysremovepersonally namicsrequirestemporally-awaremodelsthatupdatecontinuously
identifiableinformation(PII)andpresentfindingsattheaggregate asnewdataflowsin.Futureresearchshouldfocusonstreaming
leveltoprotectuseridentity[26,196]. sentimentsystems,adaptiveclassifiers,andemotionstatemodel-
ImpactAudits:Regularlyassesshowsentimentoutputsmay ing(e.g.,hiddenMarkovmodelsordynamicembeddings)totrack
affectpublicnarratives,mediareporting,orinstitutionaldecisions, emotionalevolutionduringdisastertimelines.
especiallywhentiedtoresourceallocationorpublicsafety[26,149]. Fine-GrainedEmotionClassification:Currentsentimentsys-
CommunityInvolvement:Collaboratewithaffectedcommu- temsoftenoperateatcoarsegranularity(positive/negative/neutral)
nitiestoco-interpretsentimentresultsandensureoutputsaremean- orwithalimitedemotionpalette(anger,fear,joy,sadness).How-
ingful,respectful,andcontextuallyaccurate[7,26]. ever,climatecommunicationinvolvescomplexemotionalstates
Whilesentimentanalysisofferspowerfultoolsforunderstanding suchashelplessness,betrayal,anxiety,urgency,climategrief,and
publicresponsetoclimatechange,itsapplicationmustbeguided eco-hope.Thesenuancedemotionsareparticularlyimportantfor
byaprincipledcommitmenttofairness,accountability,andrespect informingtargetedinterventions(e.g.,mentalhealthsupport,mo-
forhumandignity—especiallyaswefaceincreasinglysevereand bilizationcampaigns).Developingnewtaxonomies,datasets,and
emotionallychargedclimatedisruptions. annotationguidelinesforfine-grainedemotionalcategorization
remainsanopenandpressingchallenge.
8 ChallengesandFutureWork Cross-LingualandCross-CulturalSentimentTracking:Cli-
matechangeisaglobalphenomenon,yetmostsentimentmodels
Whilesignificantprogresshasbeenmadeindevelopingsentiment
aretrainedonEnglish-languagedata.Thisexcludesvastpopula-
analysissystemsforsocialmediaandclimatediscourse,numer-
tionswhoseemotionalnarrativesunfoldinSpanish,Hindi,Arabic,
ousopenchallengesremain.Thesespantechnicallimitations,data
Swahili,Mandarin,andotherglobalandIndigenouslanguages[210].
availability,linguisticdiversity,ethicalboundaries,andmodelinter-
Whilemanyplatformsnowofferautomatictranslationfeatures,
pretability.Addressingtheseissueswillbecrucialforscalingsen-
theseoftenfailtopreservenuancedemotionaltone,culturalidioms,
timentsystemsthatareaccurate,equitable,andpracticallyuseful
orcontext-specificsarcasm—leadingtosentimentdistortionorloss.
duringclimatecrises.Below,weoutlinefiveprominentdirections
Therefore,effectivecross-lingualsentimentanalysis—utilizingmul-
forfutureresearch.
tilingualtransformers(suchasXLM-RandmBERT),translation-
MultimodalSentimentAnalysis(Text+Images/Videos):Cli-
enhancedframeworks,orculturallysensitivelargelanguagemod-
mateeventsareoftencapturedandsharednotjustthroughtext,
els—willbeessentialforglobal-scalemonitoringandnewdirectives
butviaimages,videos,emojis,andothernon-verbalmodalities.

ShaeriandMohammadpour,etal.
intheinvestigationof[134].Furthermore,culturalfactorsshape References
howemotionsareexpressedandinterpreted,demandingmodels [1] CaroleAdam,CharlesBailly,andJulieDugdale.2023.Communicationduring
thatavoidWestern-centricassumptionsandaccountforregional bushfires,towardsaseriousgameforaseriousmatter:communicationduring
bushfires.InResearchAnthologyonManagingCrisisandRiskCommunications.
affectivenorms.
IGIGlobal,100–130.
IntegrationwithLLMReasoningandExplanationFrame- [2] IoannisAdamopoulos,AikateriniFrantzana,andNikiSyrou.2024. Climate
works:LLMsofferunprecedentedcapabilitiesincontextualunder- crisesassociatedwithepidemiological,environmental,andecosystemeffects
ofastorm:Flooding,landslides,anddamagetourbanandruralareas(Extreme
standing,emotionalreasoning,andexplanationgeneration.How- weathereventsofStormDanielinThessaly,Greece).InMedicalSciencesForum,
ever,theirintegrationintosentimentanalysispipelinesremains Vol.25.MDPI,7.
[3] IoannisAdamopoulos,AntoniosValamontes,andGeorgeDounias.2025.Pre-
underexplored.FuturesystemscouldpromptLLMsnotonlyfor
dictiveAnalysisResearchforWorkplaceJobRisksandBurnoutofPublicHealth
classification,butalsoforrationalegeneration(“Whyisthistweet andSafetyInspectorsAmidtheGlobalClimateCrisis.(2025).
angry?”),counterfactualreasoning(“Howwouldsentimentchange [4] MelissaFleurAfshar.2025. HowAIConvincedWorldHollywoodSignWas
BurningDowninLAFire. https://www.newsweek.com/how-ai-convinced-
ifthemessagecamefromapublicofficial?”),andcross-checking
hollywood-sign-burning-down-los-angeles-sunset-fire-2013048 Accessed:
forhallucinations.Additionally,combiningLLMsentimentoutputs 2025-01-24.
withsymbolicreasoningorgraph-basedmodelsmayyieldmore [5] PegahAhadianandQiangGuan.2025. ASurveyonHallucinationinLarge
LanguageandFoundationModels.(2025).
interpretableandcontrollablesystems. [6] FridoonJawadAhmad.2022.Climatechange:AGlobalCrisis.PakistanJournal
Beyondthesetechnicaldirections,futureworkshouldalsoprior- ofHealthSciences(2022),01–01.
[7] ShahriarAkterandSamuelFossoWamba.2019.Bigdataanddisastermanage-
itizeinterdisciplinarycollaborationwithsocialscientists,linguists,
ment:asystematicreviewandagendaforfutureresearch.AnnalsofOperations
climatecommunicationscholars,andcommunitystakeholdersto Research283(2019),939–959.
ensurethatsentimentmodelsarenotonlycomputationallyrobust [8] AhmedAl-Rawi,BreannaBlackwell,OumarKane,DerrickO’Keefe,andAimé-
JulesBizimana.2022.COVID-19inthetimeofclimatechange:Memeticdis-
butalsosociallygroundedandactionable.
coursesonsocialmedia.EnvironmentalCommunication16,7(2022),864–882.
[9] WalidAl-SaqafandPeterBerglez.2019.Howdosocialmediauserslinkdifferent
9 Conclusion typesofextremeeventstoclimatechange?AstudyofTwitterduring2008–2017.
JournalofExtremeEvents6,02(2019),1950002.
Sentimentanalysisofsocialmediainthecontextofclimatechange [10] RahmaAlahmaryandHmoodAl-Dossari.2023.Asemiautomaticannotation
approachforsentimentanalysis. JournalofInformationScience49,2(2023),
andextremeweathereventsrepresentsbothacompellingtechnical
398–410.
challengeandaprofoundpsychologicalandsocietalnecessity.As [11] SaudRAlKhaled,ArianeMiddel,PouyaShaeri,IsaacBuo,andFlorianASchnei-
climatedisruptionsbecomemorefrequent,severe,andemotionally der.2024. WebMRT:Anonlinetooltopredictsummertimemeanradiant
temperatureusingmachinelearning.SustainableCitiesandSociety115(2024),
charged,theabilitytounderstandandrespondtopublicsentiment
105861.
inrealtimebecomesincreasinglyimportantforresearchers,re- [12] ShayanMeshkatAlsadat,NasimBaharisangari,YashPaliwal,andZheXu.2024.
sponders,policymakers,andcitizensalike. Distributedreinforcementlearningforswarmsystemswithrewardmachines.
In2024AmericanControlConference(ACC).IEEE,33–38.
Inthissurvey,wehaveprovidedacomprehensivetaxonomyof [13] ShayanMeshkatAlsadatandZheXu.2024.Multi-AgentReinforcementLearn-
sentimentanalysismethodologies,reviewedadiversesetofanno- inginNon-CooperativeStochasticGamesUsingLargeLanguageModels.IEEE
ControlSystemsLetters(2024).
tationstrategies,andexaminedhowthesetoolshavebeenapplied
[14] DaniyarAmangeldi,AidaUsmanova,andPakizarShamoi.2024.Understanding
toreal-worldclimateeventssuchasthe2025LosAngelesforest environmentalposts:Sentimentandemotionanalysisofsocialmediadata.IEEE
fires.Weanalyzedthestrengthsandlimitationsofvariousmodel- Access(2024).
[15] FrancescaAncarani,PedroGarijoAñaños,BainGutiérrez,JuanPérez-Nievas,
ingapproaches—fromlexicon-basedsystemsandclassicalmachine
GermánVicente-Rodríguez,andFernandoGimenoMarco.2025.TheEffective-
learningtodeeplearning,transformerarchitectures,andthelatest nessofDebriefingontheMentalHealthofRescueTeams:ASystematicReview.
LLMs.Wealsohighlightedthesocietalandethicalimplications InternationalJournalofEnvironmentalResearchandPublicHealth22,4(2025),
590.
ofapplyingsentimenttechnologiesinhigh-stakesenvironments, [16] Oscar Anderson, Bilal Mustafa, and Priya Nambisan. 2024. Analyzing
includingissuesofbias,misinformation,andprivacy. Sustainability-RelatedSocialMediaTextsUsingTransformer-BasedandLarge
LanguageModels.NaturalLanguageProcessing1,1(2024),1–12.doi:10.1016/j.
Byidentifyingemergingtrends,methodologicalchallenges,and
nlp.2024.100002
futureresearchopportunities,wehopethissurveyservesasbotha [17] MerihAngin,BeyzaTaşdemir,CenkArdaYılmaz,GökcanDemiralp,MertAtay,
referenceandaroadmapforthecommunity.Ourgoalistofoster PelinAngin,andGökhanDikmener.2022.Arobertaapproachforautomated
processingofsustainabilityreports.Sustainability14,23(2022),16139.
responsible,inclusive,andscientificallyrigoroussentimentanaly-
[18] SinemAslan,SinemEmineMete,EdaOkur,EceOktay,NeseAlyuz,UtkuErgin
sisresearchthatenhancespublicunderstanding,informsclimate Genc,DavidStanhill,andAsliArslanEsme.2017. Humanexpertlabeling
action,andsupportsmoreempatheticandequitableresponsestoa process(HELP):towardsareliablehigher-orderuserstatelabelingprocessand
tooltoassessstudentengagement.EducationalTechnology(2017),53–59.
warmingworld. [19] RezaRahimiAzghan,NicholasCGlodosky,RameshKumarSah,CarrieCuttler,
RyanMcLaughlin,MichaelJCleveland,andHassanGhasemzadeh.2023.Per-
sonalizedmodelinganddetectionofmomentsofcannabisuseinfree-living
Acknowledgments environments.In2023IEEE19thInternationalConferenceonBodySensorNet-
works(BSN).IEEE,1–4.
TheauthorthanksthefacultyandcolleaguesattheSchoolofCom- [20] RezaRahimiAzghan,NicholasCGlodosky,RameshKumarSah,CarrieCuttler,
putingandAugmentedIntelligence,ArizonaStateUniversity,for RyanMcLaughlin,MichaelJCleveland,andHassanGhasemzadeh.2024.CU-
DLE:LearningUnderLabelScarcitytoDetectCannabisUseinUncontrolled
theirfeedbackandsupport.SpecialappreciationgoestotheSHaDE
Environments.arXivpreprintarXiv:2410.03211(2024).
Labforinspiringinterdisciplinaryclimateresearch,theDMMLLab [21] RezaRahimiAzghan,NicholasCGlodosky,RameshKumarSah,CarrieCuttler,
forinsightfuldiscussions,andtheNLPandcomputationalsocial RyanMcLaughlin,MichaelJCleveland,andHassanGhasemzadeh.2025.CAN-
STRESS:AReal-WorldMultimodalDatasetforUnderstandingCannabisUse,
sciencecommunitiesforopentoolsanddatasets.Automatedtools, Stress,andPhysiologicalResponses.arXivpreprintarXiv:2503.19935(2025).
includingGPT-basedmodels,wereusedforminorlanguageand
grammarrefinements.

SentimentandSocialSignalsintheClimateCrisis:ASurveyonAnalyzingSocialMediaResponsestoExtremeWeatherEvents
[22] RezaRahimiAzghan,NicholasCGlodosky,RameshKumarSah,CarrieCuttler, [44] RadhiDDesai.2018.SentimentanalysisofTwitterdata.In2018SecondInterna-
RyanMcLaughlin,MichaelJCleveland,andHassanGhasemzadeh.2025.CU- tionalConferenceonIntelligentComputingandControlSystems(ICICCS).IEEE,
DLE:LearningUnderLabelScarcitytoDetectCannabisUseinUncontrolled 114–117.
EnvironmentsusingWearables.IEEESensorsJournal(2025). [45] JacobDevlin,Ming-WeiChang,KentonLee,andKristinaToutanova.2019.Bert:
[23] StefanoBaccianella,AndreaEsuli,FabrizioSebastiani,etal.2010.Sentiwordnet Pre-trainingofdeepbidirectionaltransformersforlanguageunderstanding.In
3.0:anenhancedlexicalresourceforsentimentanalysisandopinionmining.. Proceedingsofthe2019conferenceoftheNorthAmericanchapteroftheassociation
InLrec,Vol.10.Valletta,2200–2204. forcomputationallinguistics:humanlanguagetechnologies,volume1(longand
[24] AlimohammadBeigi,BohanJiang,DaweiLi,TharinduKumarage,ZhenTan, shortpapers).4171–4186.
PouyaShaeri,andHuanLiu.2024.Lrq-fact:Llm-generatedrelevantquestions [46] RaktimaDeyandSophieCLewis.2021. Naturaldisasterslinkedtoclimate
formultimodalfact-checking.arXivpreprintarXiv:2410.04616(2024). change.InTheImpactsofClimateChange.Elsevier,177–193.
[25] AlimohammadBeigi,ZhenTan,NivedhMudiam,CanyuChen,KaiShu,and [47] MarcoD’Orazio,ElisaDiGiuseppe,andGabrieleBernardini.2022.Automatic
HuanLiu.2024.Modelattributioninllm-generateddisinformation:Adomain detectionofmaintenancerequests:ComparisonofHumanManualAnnotation
generalizationapproachwithsupervisedcontrastivelearning.In2024IEEE11th andSentimentAnalysistechniques. AutomationinConstruction134(2022),
InternationalConferenceonDataScienceandAdvancedAnalytics(DSAA).IEEE, 104068.
1–10. [48] JamesNDruckmanandMaryCMcGrath.2019.Theevidenceformotivated
[26] GhazalehBeigi,XiaHu,RossMaciejewski,andHuanLiu.2016.AnOverviewof reasoninginclimatechangepreferenceformation.NatureClimateChange9,2
SentimentAnalysisinSocialMediaandItsApplicationsinDisasterRelief.Springer (2019),111–119.
InternationalPublishing,Cham,313–340. doi:10.1007/978-3-319-30319-2_13 [49] MayElBarachi,AliKardan,AhmedBassyouni,andMohamedHammad.2021.
[27] MagnusBergquist,AndreasNilsson,andPWesleySchultz.2019.Experiencing Anovelreal-timesocialmediaanalyticsframeworkforsmarttransportation
asevereweathereventincreasesconcernaboutclimatechange.Frontiersin usinghybriddeeplearningmodels.JournalofCleanerProduction315(2021),
psychology10(2019),220. 128202.doi:10.1016/j.jclepro.2021.128202
[28] NamanBhargava,MohammedIRadaideh,OHwangKwon,AditiVerma,and [50] MohcenElMakkaoui,AnouarDalli,andKhalidElbaamrani.2024. ACom-
MajdiIRadaideh.2025. OntheImpactofLanguageNuancesonSentiment parativeStudyofRNNandDNNforClimatePrediction.In2024International
AnalysiswithLargeLanguageModels:Paraphrasing,Sarcasm,andEmojis. ConferenceonGlobalAeronauticalEngineeringandSatelliteTechnology(GAST).
arXivpreprintarXiv:2504.05603(2025). IEEE,1–6.
[29] RachelBina,KhaLuong,ShreyMehta,DaphnePang,MingjunXie,Christine [51] AlNahianBinEmran,AmritaGanguly,SadiyaSayaraChowdhuryPuspo,
Chou,andStevenOKimbrough.2025. OnLargeLanguageModelsasData DhimanGoswami,andMdNishatRaihan.2024.Masonperplexityatclimate-
SourcesforPolicyDeliberationonClimateChangeandSustainability.arXiv activism2024:Integratingadvancedensembletechniquesanddataaugmenta-
preprintarXiv:2503.05708(2025). tionforclimateactivismstanceandhateeventidentification.arXivpreprint
[30] LucaBracchetti,MartinaCapriotti,MassimilianoFazzini,PaoloCocci,and arXiv:2402.01976(2024).
FrancescoAlessandroPalermo.2024.MassmortalityeventofMediterranean [52] WenluFanandWentaoXu.2025.ArtificialIntelligenceandCivilDiscourse:How
mussels(Mytilusgalloprovincialis)inthemiddleAdriatic:potentialimplications LLMsModerateClimateChangeConversations.arXivpreprintarXiv:2506.12077
oftheclimatecrisisformarineecosystems.Diversity16,3(2024),130. (2025).
[31] MatthewBrowning,KathleenWolf,PamelaMurray-Tuite,LaraBrowning, [53] EbrahimFarahmand,RezaRahimiAzghan,NooshinTaheriChatrudi,EricKim,
MashrurChowdhury,Chien-FeiChen,DavidCoyle,AngelMDzhambov,Chao GauthamKrishnaGudur,EdisonThomaz,GiuliaPedrielli,PavanTuraga,and
Fan,RichardHauer,etal.2024. TheValueandUrgencyofTransportation HassanGhasemzadeh.2025.Attengluco:Multimodaltransformer-basedblood
Forestry.(2024). glucoseforecastingonai-readidataset.arXivpreprintarXiv:2502.09919(2025).
[32] CaliforniaGovernor’sOfficeofEmergencyServices.2025. ShelterAvail- [54] VahidFarhangmehr,HanifehImanian,AbdolmajidMohammadian,JuanHiedra
able for Communities Impacted by the Wildfires in Southern Califor- Cobo,HamidrezaShirkhani,andPierrePayeur.2025.AspatiotemporalCNN-
nia. https://news.caloes.ca.gov/shelters-available-for-communities-impacted- LSTMdeeplearningmodelforpredictingsoiltemperatureindiverselarge-scale
by-wildfires-in-southern-california-5/Accessed:2025-04-24. regionalclimates.ScienceofTheTotalEnvironment968(2025),178901.
[33] ErikCambria,YangLi,FrankZXing,SoujanyaPoria,andKennethKwok.2020. [55] MiriamFernandez,LaraSGPiccolo,DianaMaynard,MeiaWippoo,Christoph
SenticNet6:EnsembleapplicationofsymbolicandsubsymbolicAIforsentiment Meili,andHarithAlani.2016.Talkingclimatechangeviasocialmedia:commu-
analysis.InProceedingsofthe29thACMinternationalconferenceoninformation nication,engagementandbehaviour.InProceedingsofthe8thACMConference
&knowledgemanagement.105–114. onWebScience.85–94.
[34] AnabelaCarvalho.2009.Reportingtheclimatechangecrisis.InTheRoutledge [56] FraukeFeser,LindavanGarderen,andFelicitasHansen.2024. TheSummer
CompaniontoNewsandJournalism.Routledge,485–495. Heatwave2022overWesternEurope:AnAttributiontoAnthropogenicClimate
[35] BillChappell.2025.LA’swildfirespromptedarashoffakeimages.Here’swhy. Change.BulletinoftheAmericanMeteorologicalSociety105,11(2024),E2175–
https://www.npr.org/2025/01/16/nx-s1-5259629/la-wildfires-fake-imagesAc- E2179.
cessed:2025-04-24. [57] JuliaCoombsFine.2022.LanguageandsocialjusticeinUSclimatemovements:
[36] PriyavratChauhan,NonitaSharma,andGeetaSikka.2021. Theemergence Barriersandwaysforward.FrontiersinCommunication7(2022),920568.
ofsocialmediadataandsentimentanalysisinelectionprediction.Journalof [58] JaymundMFloranzaandJohnMarkRAsio.2019.TheImpactofDisastersand
AmbientIntelligenceandHumanizedComputing12(2021),2601–2627. ClimateChangeonMigrationandDisplacement.(2019).
[37] DavideChiccoandGiuseppeJurman.2020.TheadvantagesoftheMatthews [59] NinaLFrings,JessicaFHelm,andUlfJJHahnel.2024. Theenergycrisis
correlationcoefficient(MCC)overF1scoreandaccuracyinbinaryclassification differentiallyimpactedSwissandGermancitizens’energyliteracyandefficiency
evaluation.BMCgenomics21(2020),1–13. preferencesbutnottheirsupportforclimatepolicies.CommunicationsEarth&
[38] A.Chiorrini,C.Diamantini,A.Mircoli,etal.[n.d.].EmotionandSentiment Environment5,1(2024),544.
AnalysisofTweetsUsingBERT.([n.d.]). [60] AlbertJGabric.2023. Theclimatechangecrisis:areviewofitscausesand
[39] AkshatChulahwatandHussamMahmoud.2024.Theimpactofwindcharac- possibleresponses.Atmosphere14,7(2023),1081.
teristicsonthespatialdistributionofdamagetothebuiltenvironmentduring [61] ColinSGannonandNikCSteinberg.2021. Aglobalassessmentofwildfire
wildfireevents:the2022MarshallFire. NaturalHazardsReview25,1(2024), potentialunderclimatechangeutilizingKeetch-Byramdroughtindexand
06023003. landcoverclassifications.EnvironmentalResearchCommunications3,3(2021),
[40] ShelbyNCorning,EstherBoere,AndreyKrasovskiy,AndreyLessaDerciAu- 035002.
gustynczik,TedShepherd,RohitGhosh,FlorianKraxner,andPeterHavlík. [62] WenliangGao,JingxiangGao,LiuYang,MingjunWang,andWenhaoYao.2021.
2024.Flammablefutures—storylinesofclimaticimpactsonwildfireeventsand AnovelmodelingstrategyofweightedmeantemperatureinChinausingRNN
palmoilplantationsinIndonesia.EnvironmentalResearchLetters19,11(2024), andLSTM.RemoteSensing13,15(2021),3004.
114039. [63] YuryEGarcía,MiryamElizabethVilla-Pérez,KuangLi,XiaoHuiTai,LuisA
[41] TomCorringham,DanielSpokoyny,EricXiao,ChristopherCha,ColinLemarc- Trejo,MariaLDaza-Torres,JCricelioMontesinos-López,andMiriamNuño.
hand,MandeepSyal,EthanOlson,andAlexanderGershunov.2021.Bertclas- 2024.Wildfiresandsocialmediadiscourse:exploringmentalhealthandemo-
sificationofparisagreementclimateactionplans.InICML2021Workshopon tionalwellbeingthroughTwitter.Frontiersinpublichealth12(2024),1349609.
TacklingClimateChangewithMachineLearning,Vol.45. [64] EduardoCGarrido-Merchán,CristinaGonzález-Barthe,andMaríaCoronado
[42] BirajDahal,SathishAPKumar,andZhenlongLi.2019. Topicmodelingand Vaca.2023.Fine-tuningClimateBerttransformerwithClimaTextforthedisclo-
sentimentanalysisofglobalclimatechangetweets.Socialnetworkanalysisand sureanalysisofclimate-relatedfinancialrisks.arXivpreprintarXiv:2303.13373
mining9(2019),1–20. (2023).
[43] DorottyaDemszky,DanaMovshovitz-Attias,JeongwooKo,AlanCowen,Gau- [65] EduardoCGarrido-Merchán,CristinaGonzález-Barthe,andMaríaCoronado
ravNemade,andSujithRavi.2020. GoEmotions:Adatasetoffine-grained Vaca.2023.Fine-tuningClimateBerttransformerwithClimaTextforthedisclo-
emotions.arXivpreprintarXiv:2005.00547(2020). sureanalysisofclimate-relatedfinancialrisks.arXivpreprintarXiv:2303.13373
(2023).

ShaeriandMohammadpour,etal.
[66] ElizabethLeahGeorgeandSubashiniParthasarathy.2024.DecodingBiasin# [89] UjunJeong,AlimohammadBeigi,AniqueTahir,SusanXuTang,HRussell
ClimatechangeTweets:ANeuralLanguageStyleTransferApproach.In2024 Bernard,andHuanLiu.2025. FediverseSharing:ANovelDatasetonCross-
InternationalConferenceonArtificialIntelligenceandQuantumComputation- PlatformInteractionDynamicsbetweenThreadsandMastodonUsers.arXiv
BasedSensorApplication(ICAIQSA).IEEE,1–7. preprintarXiv:2502.17926(2025).
[67] CarolineMGevaert,ThomasBuunk,andMarcJCVanDenHomberg.2024.Au- [90] YuqinJiang,ZhenlongLi,andXinyueYe.2019.Understandingdemographic
ditinggeospatialdatasetsforbiases:Usingglobalbuildingdatasetsfordisaster andsocioeconomicbiasesofgeotaggedTwitterusersatthecountylevel.Car-
riskmanagement.IEEEJournalofSelectedTopicsinAppliedEarthObservations tographyandgeographicinformationscience46,3(2019),228–242.
andRemoteSensing(2024). [91] XianlinJinandPatricRSpence.2023. CheckcrisisinformationonTwitter:
[68] PawanjitSinghGhatora,SeyedEbrahimHosseini,ShahbazPervez,Muham- Informationflowandcrisiscommunicationpatternsofhurricaneida.Commu-
madJavedIqbal,andNabilShaukat.2024. SentimentAnalysisofProduct nicationStudies74,4(2023),337–355.
ReviewsUsingMachineLearningandPre-TrainedLLM.BigDataandCognitive [92] WMattJolly,MarkACochrane,PatrickHFreeborn,ZacharyAHolden,Tim-
Computing8,12(2024),199. othyJBrown,GrantJWilliamson,andDavidMJSBowman.2015. Climate-
[69] FrédéricGimello.2025.FromEmberstoRumors:DecodingtheSocietalImpact inducedvariationsinglobalwildfiredangerfrom1979to2013.Naturecommu-
oftheJanuary2025LosAngelesWildfiresonMisinformation.(2025). nications6,1(2015),7537.
[70] FrédéricGimello-Mesplomb.[n.d.].DecodingJanuary2025LosAngelesWild- [93] JosephKaranja,JenniferVanos,AnkitJoshi,ScottPenner,GiselEGuzman,
fires:How(andWhy)theEmotionalPowerofIconicFiresRevivesAncestral DylanSConnor,andKonradRykaczewski.2024.Impactoftentshadeonheat
FearsandFuelsMisinformation.([n.d.]). exposuresandsimulatedheatstrainforpeopleexperiencinghomelessness.
[71] NicholasCGlodosky,MichaelJCleveland,RezaRahimiAzghan,Hassan Internationaljournalofbiometeorology(2024),1–14.
Ghasemzadeh,RyanJMcLaughlin,andCarrieCuttler.2024.Multimodalexami- [94] ShahabKareem,ZhalaJameelHamad,andShavanAskar.2021.Anevaluation
nationofdailystressrhythmsinchronicCannabisusers.Psychopharmacology ofCNNandANNinpredictionweatherforecasting:Areview. Sustainable
(2024),1–24. EngineeringandInnovation3,2(2021),148–159.
[72] GiselGuzman-Echavarria,ArianeMiddel,DanielJVecellio,andJenniferVanos. [95] WaelKhallouli.2024.HarnessingSocialMediaforDisasterResponse:Intelligent
2024.Thedevelopmentofanadaptiveheatstresscompensabilityclassification IdentificationofReliableRescueRequestsDuringHurricanes.Ph.D.Dissertation.
appliedtotheUnitedStates. Internationaljournalofbiometeorology(2024), OldDominionUniversity.
1–15. [96] JungJinKim,Han-UlKim,JanAdamowski,ShadiHatami,andHanseokJeong.
[73] PSolHart,LaurenFeldman,SoobinChoi,SedonaChinn,andDanHiaeshutter- 2022. Comparativestudyofterm-weightingschemesforenvironmentalbig
Rice.2024.ClimateChangeAdvocacyandEngagementonSocialMedia.Science datausingmachinelearning.EnvironmentalModelling&Software157(2022),
Communication(2024),10755470241284934. 105536.
[74] AixiangHeandMidethAbisado.2024.TextsentimentanalysisofDoubanfilm [97] JongsungKim,MyungjinLee,HeechanHan,DonghyunKim,YunghyeBae,and
shortcommentsbasedonBERT-CNN-BiLSTM-Attmodel.IeeeAccess(2024). HungSooKim.2022.Casestudy:DevelopmentoftheCNNmodelconsidering
[75] SungKuHeo,PouyaIfaei,MohammadMoosazadeh,andChangKyooYoo.2022. teleconnectionforspatialdownscalingofprecipitationinaclimatechange
Publicperceptionassessmentonclimatechangeandnaturaldisasterinfluence scenario.Sustainability14,8(2022),4719.
usingsocialmediabig-data:AcasestudyofUSA.InEGUGeneralAssembly [98] MiraeKim.2024. EvaluatingEnglishFluencyEffectontheDeliveryofWater
ConferenceAbstracts.EGU22–3482. CampaignMessagestoResidentsinMetroVancouver. Master’sthesis.Royal
[76] DavidHerrera-Poyatos,CarlosPeláez-González,CristinaZuheros,Andrés RoadsUniversity(Canada).
Herrera-Poyatos,ViriloTejedor,FranciscoHerrera,andRosanaMontes.2025. [99] SooYunKim.2022.UnderstandingAttitudeExtremityinClimateChange:Public
AnoverviewofmodeluncertaintyandvariabilityinLLM-basedsentiment PerceptionsofClimateChangeDeniersandClimateChangeDoomsdayBelievers.
analysis.Challenges,mitigationstrategiesandtheroleofexplainability.arXiv TheUniversityofWisconsin-Madison.
preprintarXiv:2504.04462(2025). [100] SvetlanaKiritchenkoandSaifMMohammad.2018.Examininggenderandrace
[77] AttilaJHertelendy,JeremyMaggin,andGregoryRCiottone.2025.Health-care biasintwohundredsentimentanalysissystems.arXivpreprintarXiv:1805.04508
systemadaptabilityduringwildfiredisasters:crucialinsightsfromLACounty. (2018).
TheLancet(2025). [101] MariaKlarizaMadrazo,HuikyoLee,ArezooKhodayari,WeileWang,Taejin
[78] SolomonMHsiangandMarshallBurke.2014. Climate,conflict,andsocial Park,andColinRaymond.2023. Theimpactofclimatechangeonfiredan-
stability:whatdoestheevidencesay?Climaticchange123(2014),39–55. geroverthecontiguousUnitedStates.InEGUGeneralAssemblyConference
[79] QianHu,SeonghoAn,NaimKapucu,TimothySellnow,MuratYuksel,Rebecca Abstracts.EGU–16986.
Freihaut,andPrasunKantiDey.2024.Emergencycommunicationnetworks [102] JessieWYKo,ShengquanNi,AlexanderTaylor,XiusiChen,YicongHuang,
onTwitterduringHurricaneIrma:informationflow,influentialactors,andtop AvinashKumar,SadeemAlsudais,ZuozhiWang,XiaozhenLiu,WeiWang,etal.
messages.Disasters48,4(2024),e12628. 2024.HowtheexperienceofCaliforniawildfiresshapeTwitterclimatechange
[80] HuanchunHuang,YangLi,YiminZhao,andWeiZhai.2022.Analysisofthe framings.ClimaticChange177,1(2024),17.
impactofurbansummerhightemperaturesandoutdooractivitydurationon [103] VanessaKokoschka,CristianASecco,andKawaNazemi.2024.VisualAnalytics-
residents’emotionalhealth:Takinghostilityasanexample.FrontiersinPublic ClimateChangeinSocialMedia.In202428thInternationalConferenceInforma-
Health10(2022),955077. tionVisualisation(IV).IEEE,167–173.
[81] XinjieHuang,ElieBou-Zeid,JenniferVanos,ArianeMiddel,andPrathapRa- [104] JulianFKölbel,MarkusLeippold,JordyRillaerts,andQianWang.2024.Ask
mamurthy.2025.OutdoorMistingIsanEffectiveBlueInfrastructureSolution BERT:Howregulatorydisclosureoftransitionandphysicalclimaterisksaffects
forUrbanHeatMitigation.In105thAMSAnnualMeeting.AMS. theCDStermstructure.JournalofFinancialEconometrics22,1(2024),30–69.
[82] XiangHuang,JiayuShen,ShanshanHuang,SitaoCheng,XiaxiaWang,and [105] AnandKrishnanandBAnoop.2023.ClimateNLP:AClimateChangeDomain-
YuzhongQu.2024.TARGA:TargetedSyntheticDataGenerationforPractical SpecificPre-trainedLanguageModelforSocialMediaAnalysis.arXivpreprint
ReasoningoverStructuredData.arXivpreprintarXiv:2412.19544(2024). arXiv:2310.08099(2023).
[83] ClaytonHuttoandEricGilbert.2014.Vader:Aparsimoniousrule-basedmodel [106] JanOleKrugmannandJochenHartmann.2024.Sentimentanalysisintheage
forsentimentanalysisofsocialmediatext.InProceedingsoftheinternational ofgenerativeAI.CustomerNeedsandSolutions11,1(2024),3.
AAAIconferenceonwebandsocialmedia,Vol.8.216–225. [107] YuryKryvasheyeu,HaohuiChen,NickObradovich,EstebanMoro,Pascal
[84] ChibuikeChiedozieIbebuchiandItohan-OsaAbu.2023.Characterizationof VanHentenryck,JamesFowler,andManuelCebrian.2016.Rapidassessment
temperatureregimesinWesternEurope,asregardsthesummer2022Western ofdisasterdamageusingsocialmediaactivity. Scienceadvances2,3(2016),
Europeanheatwave.ClimateDynamics61,7(2023),3707–3720. e1500779.
[85] UmarIshfaq,HikmatUllahKhan,andDanialShabbir.2024.Exploringtherole [108] BatoolLakzaei,MostafaHaghirChehreghani,andAlirezaBagheri.2025. A
ofsentimentanalysiswithnetworkandtemporalfeaturesforfindinginfluential Decision-BasedHeterogenousGraphAttentionNetworkforMulti-ClassFake
usersinsocialmediaplatforms.SocialNetworkAnalysisandMining14,1(2024), NewsDetection.arXivpreprintarXiv:2501.03290(2025).
241. [109] Batool Lakzaei, Mostafa Haghir Chehreghani, and Alireza Bagheri. 2025.
[86] TunazzinaIslam,RuqiZhang,andDanGoldwasser.2023.Analysisofclimate Neighborhood-OrderLearningGraphAttentionNetworkforFakeNewsDetec-
campaignsonsocialmediausingbayesianmodelaveraging.InProceedingsof tion.arXivpreprintarXiv:2502.06927(2025).
the2023AAAI/ACMConferenceonAI,Ethics,andSociety.15–25. [110] BatoolLakzaei,MostafaHaghirChehreghani,andAlirezaBagheri.2024.Disin-
[87] SMoJangandPSolHart.2015. Polarizedframeson“climatechange”and formationdetectionusinggraphneuralnetworks:asurvey.ArtificialIntelligence
“globalwarming”acrosscountriesandstates:EvidencefromTwitterbigdata. Review57,3(2024),52.
Globalenvironmentalchange32(2015),11–17. [111] JessLasoff-Santos.2024.SupportingCommunityandPsychologicalResilienceto
[88] Ting-YuJeng,Ren-JieYu,Chia-HaoLee,andYu-LinWu.2025. TheRoleof theClimateCrisis.Ph.D.Dissertation.
AIinClimateJournalism:UsingGPT-4oforFear-HopeFramingtoImprove [112] MarkusLeippold,AngeloRanaldo,Yik-KunSugianto,andThaiDuongTran.
Pro-EnvironmentalIntentions.InProceedingsofthe33rdACMInternational 2022.ClimateBERT:APretrainedLanguageModelforClimate-RelatedText.
ConferenceonUserModeling,AdaptationandPersonalization(UMAP).

SentimentandSocialSignalsintheClimateCrisis:ASurveyonAnalyzingSocialMediaResponsestoExtremeWeatherEvents
InProceedingsoftheAAAIConferenceonArtificialIntelligence,Vol.36.11111– [137] ArianeMiddelandEScottKrayenhoff.2019.Micrometeorologicaldeterminants
11119. ofpedestrianthermalexposureduringrecord-breakingheatinTempe,Arizona:
[113] JakeLever,SiboCheng,andRossellaArcucci.2023.Human-sensors&physics IntroducingtheMaRTyobservationalplatform.Scienceofthetotalenvironment
awaremachinelearningforwildfiredetectionandnowcasting.InInternational 687(2019),137–151.
ConferenceonComputationalScience.Springer,422–429. [138] Marie-GabrielleMocattaandErinHawley.2020.Uncoveringaclimatecatastro-
[114] JakeLever,SiboCheng,andRossellaArcucci.2023.Social&PhysicsBasedData phe?MediacoverageofAustralia’sBlackSummerbushfiresandtherevelatory
DrivenMethodsforWildfirePrediction.InEGUGeneralAssemblyConference extentoftheclimateblameframe.(2020).
Abstracts.EGU–15645. [139] SaifMMohammadandPeterDTurney.2013.Nrcemotionlexicon.National
[115] DaweiLi,BohanJiang,LiangjieHuang,AlimohammadBeigi,ChengshuaiZhao, ResearchCouncil,Canada2(2013),234.
ZhenTan,AmritaBhattacharjee,YuxuanJiang,CanyuChen,TianhaoWu, [140] MohasinaMohasina.2023. RoBERTa:amachinereadingcomprehensionfor
etal.2024. Fromgenerationtojudgment:Opportunitiesandchallengesof climatechangequestionansweringinnaturallanguageprocessing.Ph.D.Disser-
llm-as-a-judge.arXivpreprintarXiv:2411.16594(2024). tation.
[116] HaoboLi,ZhaoweiWang,JiachenWang,AlexisKaiHonLau,andHuaminQu. [141] MOMolina,CGutiérrez,MOrtega,andESánchez.2023.Summerheatwaves,
2024.Cllmate:Amultimodalllmforweatherandclimateeventsforecasting. windproductionandelectricitydemandinSouthernEurope:climaticconditions
arXivpreprintarXiv:2409.19058(2024). andimpacts.EnvironmentalResearchCommunications5,8(2023),085005.
[117] QiuyanLiao,YucanXu,SijiaLi,etal.2024.Decodingpublic’sreal-timeemo- [142] AbdelRaufMostafa,AllaaMOwes,andShimaaGhoniem.2025.Interconnected
tionalandcognitiveresponsestothechangingclimateonsocialmedia.(2024). ImpactsofClimateChangeonBiodiversity,Agriculture,andHumanHealth.
[118] PanagiotisLinardosandKatiaKermanidis.2025.UtilizingLLMsandMLAlgo- AdvancesinBasicandAppliedSciences(2025).
rithmsinDisaster-RelatedSocialMediaContent.Preprints2025051798(2025). [143] MahjabinNahar,HaeseungSeo,Eun-JuLee,AipingXiong,andDongwonLee.
doi:10.20944/preprints202505.1798.v1 2024. Fakesofvaryingshades:Howwarningaffectshumanperceptionand
[119] BingLiu.2022.Sentimentanalysisandopinionmining.SpringerNature. engagementregardingLLMhallucinations. arXivpreprintarXiv:2404.03745
[120] BingLiuetal.2010.Sentimentanalysisandsubjectivity.Handbookofnatural (2024).
languageprocessing2,2010(2010),627–666. [144] SamuelChukwujinduNwokolo.2025.ClimateHoax:TheShiftfromScientific
[121] ChuchuLiu,FanFang,XuLin,TieCai,XuTan,JianguoLiu,andXinLu.2021. DiscoursetoSpeculativeRhetoricinClimateChangeConversations. Next
Improvingsentimentanalysisaccuracywithemojiembedding.JournalofSafety Research(2025),100322.
ScienceandResilience2,4(2021),246–252. [145] AlexandraOlteanu,CarlosCastillo,NicholasDiakopoulos,andKarlAberer.
[122] QiaoyiLiu,YuheunKim,andJeffHemsley.2025.Scientists,butdenyscience? 2015.Comparingeventscoverageinonlinenewsandsocialmedia:Thecaseof
ClimatechangescepticsnetworksonYouTubeledbyscientists.Information climatechange.InProceedingsoftheinternationalAAAIconferenceonweband
Researchaninternationalelectronicjournal30,iConf(2025),741–751. socialmedia,Vol.9.288–297.
[123] YinhanLiu,MyleOtt,NamanGoyal,JingfeiDu,MandarJoshi,DanqiChen, [146] KeaneOng,RuiMao,DeekshaVarshney,RanjanSatapathy,ErikCambria,
OmerLevy,MikeLewis,LukeZettlemoyer,andVeselinStoyanov.2019.Roberta: andGianmarcoMengaldo.2024.SentimentAnalysisonClimateChangefor
Arobustlyoptimizedbertpretrainingapproach.arXivpreprintarXiv:1907.11692 SustainableInvestment.In2024IEEEInternationalConferenceonDataMining
(2019). Workshops(ICDMW).IEEE,479–486.
[124] YongcongLuo.2024. ResearchontheSentimentAnalysisandEvolutionary [147] NathanielO’Grady.2025.(Re)framingthepoliticsofclimatechange:resilience,
MechanismofSuddenNetworkPublicOpinionBasedonSNA-ARIMAModel reparativecritiqueandaffectivelifeinsituationsofextremeheat. Critical
withTextMining.J.ElectricalSystems20,2(2024),1961–1972. StudiesonSecurity13,1(2025),70–86.
[125] RidhaMahmood,PhilippaClery,JustinYang,LiyingCao,JenniferDykxhoorn, [148] AnanyaPandeyandDineshKumarVishwakarma.2024.Progress,achievements,
andJenniferDykxhoorn.[n.d.].Theimpactofclimatechangeonmentalhealth andchallengesinmultimodalsentimentanalysisusingdeeplearning:Asurvey.
invulnerablegroups:asystematicreview.([n.d.]). AppliedSoftComputing152(2024),111206.
[126] JudithMair.2011.Eventsandclimatechange:anAustralianperspective.Inter- [149] WarrenPearce,KimHolmberg,IinaHellsten,andBrigitteNerlich.2014.Climate
nationalJournalofEventandFestivalManagement2,3(2011),245–253. changeonTwitter:Topics,communitiesandconversationsaboutthe2013IPCC
[127] MariaMäkelä.2024.Climateuncertainty,socialmediacertainty:Astory-critical WorkingGroup1report.PloSone9,4(2014),e94785.
approachtoclimatechangestorytellingonsocialmedia.FrontiersofNarrative [150] EdouardPignot,HajerKéfi,andMarkThompson.2023.AffectiveCirculationvia
Studies9,2(2024),232–253. SocialMedia:ExaminingClimateChangeasanExample.InIFIPJointWorking
[128] SunilMalviya,ArvindKumarTiwari,RajeevSrivastava,andVipinTiwari.2020. ConferenceontheFutureofDigitalWork:TheChallengeofInequality.Springer,
Machinelearningtechniquesforsentimentanalysis:Areview.SAMRIDDHI:A 21–27.
JournalofPhysicalSciences,EngineeringandTechnology12,02(2020),72–78. [151] ProtikBosePranto.2024.SatireorFakeNews?MachineLearning-BasedAp-
[129] FranciscoSMarcondes,AdelinoGala,RenataMagalhães,FernandoPerezde proachestoResolvetheDilemma.In20244thInternationalConferenceonElec-
Britto,DalilaDurães,andPauloNovais.2025.CaseStudy:LLM-BasedAnxiety trical,Computer,CommunicationsandMechatronicsEngineering(ICECCME).
ClimateIndex.InNaturalLanguageAnalyticswithGenerativeLarge-Language IEEE,1–6.
Models:APracticalApproachwithOllamaandOpen-SourceLLMs.Springer, [152] ProtikBosePranto,WaqarHassanKhan,SaharAbdelnabi,RebeccaWeil,Mario
53–73. Fritz,andRakibulHasan.2023. FromBadtoWorse:UsingPrivateDatato
[130] MohammadhosseinMarjani,OmidGhorbanzadeh,MasoudMahdianpari,and PropagateDisinformationonOnlinePlatformswithaGreaterEfficiency.arXiv
BrianBrisco.2024.CNN-BiLSTMforSpatiotemporalWildfireSpreadPrediction preprintarXiv:2306.04883(2023).
UsingSocialandPhysicalSignals.RemoteSensing16,14(2024),1467.doi:10. [153] YashaswiPupneja,JosephZou,SachaLévy,andShenyangHuang.2023.Under-
3390/rs16091467 standingOpinionsTowardsClimateChangeonSocialMedia.arXivpreprint
[131] AleksandrinaVMavrodieva,OkkyKRachman,VitoBHarahap,andRajibShaw. arXiv:2312.01217(2023).
2019.Roleofsocialmediaasasoftpowertoolinraisingpublicawarenessand [154] HannahRashkin,EricMichaelSmith,MargaretLi,andY-LanBoureau.2018.
engagementinaddressingclimatechange.Climate7,10(2019),122. Towardsempatheticopen-domainconversationmodels:Anewbenchmarkand
[132] ShalakMendon,PankajDutta,AbhishekBehl,andStefanLessmann.2021. dataset.arXivpreprintarXiv:1811.00207(2018).
Ahybridapproachofmachinelearningandlexiconstosentimentanalysis: [155] AnaReyes-Menendez,JoséRamónSaura,andCesarAlvarez-Alonso.2018.
enhancedinsightsfromtwitterdataofnaturaldisasters.InformationSystems Understanding#WorldEnvironmentDayuseropinionsinTwitter:Atopic-based
Frontiers23,5(2021),1145–1168. sentimentanalysisapproach.Internationaljournalofenvironmentalresearch
[133] DorotheaMetzenandSebastianOcklenburg.2024.ThePsychologyandNeuro- andpublichealth15,11(2018),2537.
scienceoftheClimateCrisis.Springer. [156] EmelieRosenberg,CarlotaTarazona,FermínMallor,HamidrezaEivazi,David
[134] MdSaefUllahMiah,MdMohsinKabir,TalhaBinSarwar,MejdlSafran,Sultan Pastor-Escuredo,FrancescoFuso-Nerini,andRicardoVinuesa.2023.Sentiment
Alfarhood,andMFMridha.2024. Amultimodalapproachtocross-lingual analysisonTwitterdatatowardsclimateaction.ResultsinEngineering19(2023),
sentimentanalysiswithensembleoftransformerandLLM.ScientificReports 101287.
14,1(2024),9603. [157] StevenRumlawang,HenryWijaya,AchmadMulyana,andAbdurrahmanSun-
[135] EmmanouilMichail,AristeidisBozas,DimitriosStefanopoulos,StavrosPas- dara.2025.ClimatechangesentimentanalysisusingLSTMbaseddeeplearning
palakis,GeorgiosOrfanidis,AnastasiaMoumtzidou,IliasGialampoukidis,Kon- approach.JurnalIlmuKomputerdanInformatika(JournalofComputerScience
stantinosIoannidis,StefanosVrochidis,andIoannisKompatsiaris.2024.Incor- andInformatics)9,1(2025),77–85.doi:10.30865/jurikom.v9i1.8302
poratingSocialMediaSensingandComputerVisionTechnologiestoSupport [158] NorlinaMohdSabri,IzzatulSyahirahIsmail,NikMarsyaharianiNikDaud,
WildfireMonitoring.InIGARSS2024-2024IEEEInternationalGeoscienceand andNorAzilaAwangAbuBakar.2025. PublicSentimentonAwarenessof
RemoteSensingSymposium.IEEE,2082–2085. ClimateChangeBasedonSupportVectorMachine.PertanikaJournalofScience
[136] ArianeMiddel,BenjaminBechtel,MatthiasDemuzere,andNeginNazarian. &Technology33(2025).
2023.Urbanclimateinformatics.FrontiersMediaSA. [159] SunySadik,JacobBenedetti,andSwapnaSGokhale.2022.AnalyzingClimate
ChangeDialogueDuringCaliforniaWildfires.In20222ndAsianConferenceon

ShaeriandMohammadpour,etal.
InnovationinTechnology(ASIANCON).IEEE,1–8. arXiv:1909.09586(2019).
[160] HajarSakai,SarahSLam,MohammadsadeghMikaeili,andJoshuaBosire.2024. [183] BebeChandSultana,MdTabiurRahmanProdhan,EdrisAlam,MdSalman
PatientExperienceFeedbackSentimentAnalysis:CombiningBERTandLSTM Sohel,ABMMainulBari,SubodhChandraPal,MdKamrulIslam,andAbuReza
withGeneticAlgorithmOptimization.InIISEAnnualConference.Proceedings. MdTowfiqulIslam.2024.Asystematicreviewofthenexusbetweenclimate
InstituteofIndustrialandSystemsEngineers(IISE),1–6. changeandsocialmedia:presentstatus,trends,andfuturechallenges.Frontiers
[161] VictorSanh,LysandreDebut,JulienChaumond,andThomasWolf.2019.Distil- inCommunication9(2024),1301400.
BERT,adistilledversionofBERT:smaller,faster,cheaperandlighter.arXiv [184] YuqingSun,GensuoJia,andXiyanXu.2025.Extremehightemperaturesand
preprintarXiv:1910.01108(2019). heatwaveeventsacrossEuropein2023.EnvironmentalResearchCommunica-
[162] SrikantaSannigrahi,FrancescoPilla,ArabindaMaiti,SomnathBar,Sandeep tions(2025).
Bhatt,QiZhang,SaskiaKeesstra,ArtemiCerda,etal.2022. Examiningthe [185] PushpikaSundarresonandSapnaKumarapathirage.2024.SentiGEN:Synthetic
statusofforestfireemissionin2020anditsconnectiontoCOVID-19incidents DataGeneratorforSentimentAnalysis. JournalofComputingTheoriesand
inWestCoastregionsoftheUnitedStates.EnvironmentalResearch210(2022), Applications1,4(2024),461–477.
112818. [186] DimitrisSykas,DimitriosZografakis,KonstantinosDemestichas,Constantina
[163] SeptienDwiSavandha,AmeliaAmelia,andGinnaNovariantiDwiPutriPra- Costopoulou,andPavlosKosmidis.2023.EO4WildFires:AnEarthobservation
mesti.2025.FromHeadlinestoPublicAwareness:AMediaDiscourseAnalysis multi-sensor,time-seriesmachine-learning-readybenchmarkdatasetforwild-
ofTheLosAngeles2025Wildfire. WINTERJOURNAL:IMWISTUDENTRE- fireimpactprediction.InNinthInternationalConferenceonRemoteSensingand
SEARCHJOURNAL6,1(2025),43–54. GeoinformationoftheEnvironment(RSCy2023),Vol.12786.SPIE,11–20.
[164] AliSayigh.2023. GlobalCatastrophe:ClimateChangeIsHappeningNow, [187] ZhenTan,DaweiLi,SongWang,AlimohammadBeigi,BohanJiang,Amrita
RenewableEnergyCanReduceItsImpact.InMediterraneanArchitectureand Bhattacharjee,MansoorehKarami,JundongLi,LuCheng,andHuanLiu.2024.
theGreen-DigitalTransition:SelectedPapersfromtheWorldRenewableEnergy Largelanguagemodelsfordataannotationandsynthesis:Asurvey. arXiv
CongressMedGreenForum2022.Springer,291–312. preprintarXiv:2402.13446(2024).
[165] TobiasSchimanski,JuliaBingler,CamillaHyslop,MathiasKraus,andMarkus [188] HorusCleopatraTanoKania.[n.d.].EnhancingE-commerceCustomerInsights:
Leippold.2023.ClimateBERT-NetZero:Detectingandassessingnetzeroand SentimentAnalysis,CausalReasoning,andLLMBenchmarking.([n.d.]).
reductiontargets.arXivpreprintarXiv:2310.08096(2023). [189] KushThakar,RajeshPatel,andGauravPatel.2021.Techno-economicanalysis
[166] FlorianASchneider,ErinEpel,andArianeMiddel.2024.Adisconnectinscience ofdistrictcoolingsystem:Acasestudy.JournalofCleanerProduction313(2021),
andpractitionerperspectivesonheatmitigation.npjUrbanSustainability4,1 127812.
(2024),17. [190] MThenmozhi,GShubigsha,GSindhuja,andVDhinakar.2024. Sentiment
[167] SamuelSellers,KristieLEbi,andJeremyHess.2019.Climatechange,human AnalysisonClimateChangeusingTwitterData.In20242ndInternational
health,andsocialstability:addressinginterlinkages. Environmentalhealth ConferenceonNetworkingandCommunications(ICNWC).IEEE,1–6.
perspectives127,04(2019),045002. [191] MyriamVThoma,NicolasRohleder,andShaunaLRohner.2021. Clinical
[168] SoniaSeneviratne,MichaelWindisch,BiancaBiess,FelixJaeger,LukasGud- ecopsychology:Thementalhealthimpactsandunderlyingpathwaysofthe
mundsson,MathiasHauser,LaibaoLiu,QuilcailleYann,SchwaabJonas,and climateandenvironmentalcrisis.Frontiersinpsychiatry12(2021),675936.
SieberPetra.2024. Extremeeventsandlandusechangesintheclimatecrisis. [192] AdelleThomasandWilliamWLCheung.[n.d.]. IMPACTSOFCLIMATE
TechnicalReport.CopernicusMeetings. CHANGE.([n.d.]).
[169] QuintaSeon,NatalieGreaves,MichaelCampbell,SimonAnderson,PaulaHenry, [193] VKellyTurner,EmmaMFrench,JohnDialesandro,ArianeMiddel,David
EdenAugustus,EmanuelCummings,LeannKendall,EricaWheeler,AnsVer- MHondula,GeorgeBanWeiss,andHanaAbdellati.2022. Howarecities
cammen,etal.2024. Exploratoryempiricalmodelofcombinedeffectsof planningforheat?AnalysisofUnitedStatesmunicipalplans.Environmental
COVID-19andclimatechangeonyouthmentalhealth.NatureMentalHealth2, researchletters17,6(2022),064054.
2(2024),218–227. [194] SamsonEbenezarUthirapathyandDomnicSandanam.2023.TopicModelling
[170] PouyaShaeri,SaudAlKhaled,andArianeMiddel.2025.AMultimodalPhysics- andOpinionAnalysisOnClimateChangeTwitterDataUsingLDAAndBERT
InformedNeuralNetworkApproachforMeanRadiantTemperatureModeling. Model.ProcediaComputerScience218(2023),908–917.
arXiv:2503.08482[cs.CV] https://arxiv.org/abs/2503.08482 [195] RoopalVaid,KartikeyPant,andManishShrivastava.2022.Towardsfine-grained
[171] PouyaShaeriandAliKatanforoush.2023. Asemi-supervisedfakenewsde- classificationofclimatechangerelatedsocialmediatext.InProceedingsofthe
tectionusingsentimentencodingandlstmwithself-attention.In202313th 60thannualmeetingoftheassociationforcomputationallinguistics:Student
InternationalConferenceonComputerandKnowledgeEngineering(ICCKE).IEEE, researchworkshop.434–443.
590–595. [196] A.Valdivia,M.V.Luzon,E.Cambria,etal.2018. Consensusvotemodelsfor
[172] MaryamShafieeShakib,PatriciaSolís,andKateVarfalameyeva.2024.Mapswipe detectingandfilteringneutralityinsentimentanalysis.InformationFusion44
forSDGs3&13:takeurgentcartographicactiontocombatheatvulnerabil- (2018),126–135.
ityofmanufacturedandmobilehomecommunities.InternationalJournalof [197] MarylineVivion,ValérieTrottier,ÈveBouhêlier,IsabelleGoupil-Sormany,
Cartography(2024),1–23. ThiernoDiallo,etal.2024. MisinformationAboutClimateChangeandRe-
[173] NabilaMohamadShamandAzlinahMohamed.2022.Climatechangesentiment latedEnvironmentalEventsonSocialMedia:ProtocolforaScopingReview.
analysisusinglexicon,machinelearningandhybridapproaches.Sustainability JMIRResearchProtocols13,1(2024),e59345.
14,8(2022),4723. [198] JimWaldoandSolineBoussard.2024.GPTsandHallucination:Whydolarge
[174] ShanShan.2024. FromCorrelationtoCausation:UnderstandingClimate languagemodelshallucinate?Queue22,4(2024),19–33.
ChangethroughCausalAnalysisandLLMInterpretations. arXivpreprint [199] YanWangandCaiyangPeng.2024. Publicperceptionsofclimatechange
arXiv:2412.16691(2024). duringtheCOVID-19crisis:EvidencefromsocialmediadatainChina.Current
[175] ShelterBoxUSA.2025.LosAngelesWildfires:InSolidaritywithDisplacedFamilies. Sociology(2024),00113921241248448.
https://www.shelterboxusa.org/los-angeles-wildfires-update/Accessed:2025- [200] HelenaWebb,MarinaJirotka,BerndCarstenStahl,WilliamHousley,Adam
04-24. Edwards,MatthewWilliams,RobProcter,OmerRana,andPeteBurnap.2016.
[176] ValeriyShevchenko,AleksandrLukashevich,DariaTaniushkina,Alexander Digitalwildfires:hyper-connectivity,havocandaglobalethostogovernsocial
Bulkin,RolandGrinis,KirillKovalev,VeronikaNarozhnaia,NazarSotiriadi, media.ACMSIGCASComputersandSociety45,3(2016),193–201.
AlexanderKrenke,andYuryMaximov.2024.Climatechangeimpactonagri- [201] NicolasWebersinke,MathiasKraus,JuliaAnnaBingler,andMarkusLeippold.
culturallandsuitability:Aninterpretablemachinelearning-basedEurasiacase 2021.Climatebert:Apretrainedlanguagemodelforclimate-relatedtext.arXiv
study.IEEEAccess12(2024),15748–15763. preprintarXiv:2110.12010(2021).
[177] ZhiyingShi.2018. Impactofclimatechangeontheglobalenvironmentand [202] RaquelWinker,AlexisPayton,EricBrown,ElenaMcDermott,JonathanHFreed-
associatedhumanhealth.OpenAccessLibraryJournal5,10(2018),1–6. man,ChrisLenhardt,LaurenAEaves,RebeccaCFry,andJuliaERager.2024.
[178] MohammedShihaandSerkanAyvaz.2017.Theeffectsofemojiinsentiment Wildfiresandclimatejustice:futurewildfireeventspredictedtodispropor-
analysis.Int.J.Comput.Electr.Eng.(IJCEE.)9,1(2017),360–369. tionallyimpactsocioeconomicallyvulnerablecommunitiesinNorthCarolina.
[179] YerikAfriantoSinggalen.2024.SentimentClassificationofClimateChangeand Frontiersinpublichealth12(2024),1339700.
TourismContentUsingSupportVectorMachine.J.Comput.Syst.Informatics5, [203] OrisonOWoolcott.2025.LosAngelesCountyinflames:responsibilitiesonfire.
2(2024),357–367. TheLancetRegionalHealth–Americas42(2025).
[180] EASingh,MRShindikar,etal.2023.Acomprehensivereviewonclimatechange [204] HongWu,XinXu,YanJiang,andRuiYe.2023. Spatio-temporaltopicand
anditseffects.(2023). sentimentanalysisofclimatechangediscussionsonsocialmedia:Acasestudy
[181] UpendraSingh,KumarAbhishek,andHiteshwarKumarAzad.2024.Asurvey ofChina.Resources,ConservationandRecycling189(2023),106742.doi:10.1016/
ofcutting-edgemultimodalsentimentanalysis.Comput.Surveys56,9(2024), j.resconrec.2023.106742
1–38. [205] SelimFYilmaz,EBatuhanKaynak,AykutKoç,HamdiDibeklioğlu,andSuley-
[182] RalfCStaudemeyerandEricRothsteinMorris.2019.UnderstandingLSTM–a manSerdarKozat.2021.Multi-labelsentimentanalysison100languageswith
tutorialintolongshort-termmemoryrecurrentneuralnetworks.arXivpreprint

SentimentandSocialSignalsintheClimateCrisis:ASurveyonAnalyzingSocialMediaResponsestoExtremeWeatherEvents
dynamicweightingforlabelimbalance.IEEETransactionsonNeuralNetworks [209] MuhammadRifkiAdinurZein,KurniaLuckyFadillah,NadiaFebriani,Riki
andLearningSystems(2021). Nasrullah,andNguyenTanKhang.2024.Socialmediauseforclimatechange
[206] AbrahamYosipof,OrElroy,andNadejdaKomendantova.2024.Cyber-Echoes campaignamongIndonesianmillennials.PRofesiHumas8,2(2024),168–194.
ofClimateCrisis:UnravelingAnthropogenicClimateChangeNarrativeson [210] ChuanjunZhao,MeilingWu,XinyiYang,WenyueZhang,ShaoxiaZhang,Suge
SocialMedia.InEGUGeneralAssemblyConferenceAbstracts.16779. Wang,andDeyuLi.2024. Asystematicreviewofcross-lingualsentiment
[207] DouglasCYouvan.2025.FacingtheFlame:TheHiddenVulnerabilitiesofLos analysis:Tasks,strategies,andprospects.Comput.Surveys56,7(2024),1–37.
AngelesintheEraofWildfireandGlobalConflict.(2025). [211] SichengZhao,XiaopengHong,JufengYang,YanyanZhao,andGuiguangDing.
[208] GorkaZamarreño-Aramendia,FJCristòfol,JordideSan-Eugenio-Vela,and 2023.Towardlabel-efficientemotionandsentimentanalysis.Proc.IEEE111,10
XavierGinesta.2020. Social-mediaanalysisfordisasterprevention:Forest (2023),1159–1197.
fireinArtenaraandValleseco,CanaryIslands. JournalofOpenInnovation: [212] YiyinZhou,YanrongHu,HongjiuLiu,PingHuang,andDanDai.2024.Linking
Technology,Market,andComplexity6,4(2020),169. negativeherdingeffecttoonlinepublicopinion:AnewBiGADGapproachfor
sentimentclassification.ExpertSystems41,8(2024),e13587.
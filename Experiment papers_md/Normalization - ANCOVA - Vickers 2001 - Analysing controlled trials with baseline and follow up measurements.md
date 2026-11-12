Educationanddebate
Statistics Notes
Analysing controlled trials with baseline and follow up
measurements
AndrewJVickers,DouglasGAltman
Inmanyrandomisedtrialsresearchersmeasureacon› whereaandbareestimatedcoefficientsandgroup Integrative
tinuousvariableatbaselineandagainasanoutcome is a binary variable coded 1 for treatment and 0 for MedicineService,
BiostatisticsService,
assessedatfollowup.Baselinemeasurementsarecom› control.The coefficient b is the effect of interest—the Memorial
monintrialsofchronicconditionswhereresearchers estimated difference between the two treatment Sloan›Kettering
CancerCenter,New
want to see whether a treatment can reduce groups.Ineffectananalysisofcovarianceadjustseach
York,NewYork
pre›existing levels of pain,anxiety,hypertension,and patient’sfollowupscoreforhisorherbaselinescore, 10021,USA
thelike. buthastheadvantageofbeingunaffectedbybaseline AndrewJVickers
Statisticalcomparisonsinsuchtrialscanbemade differences.If,bychance,baselinescoresareworsein assistantattending
researchmethodologist
in several ways. Comparison of follow up (post› the treatment group, the treatment effect will be
ICRFMedical
treatment)scoreswillgivearesultsuchas“attheend underestimatedbyafollowupscoreanalysisandover›
StatisticsGroup,
ofthetrial,meanpainscoreswere15mm(95%confi› estimated by looking at change scores (because of CentreforStatistics
dence interval 10 to 20 mm) lower in the treatment regressiontothemean).Bycontrast,analysisofcovari› inMedicine,
InstituteofHealth
group.”Alternativelyachangescorecanbecalculated ance gives the same answer whether or not there is Sciences,Oxford
by subtracting the follow up score from the baseline baselineimbalance. OX37LF
score,leadingtoastatementsuchas“painreductions As an illustration,Kleinhenz et al randomised 52 DouglasGAltman
professorofstatistics
were20mm(16to24mm)greaterontreatmentthan patientswithshoulderpaintoeithertrueorshamacu›
inmedicine
control.”Iftheaveragebaselinescoresarethesamein puncture.4 Patients were assessed before and after
Correspondenceto:
each group the estimated treatment effect will be the treatment using a 100 point rating scale of pain and DrVickers
same using these two simple approaches. If the function,withlowerscoresindicatingpooreroutcome. vickersa@mskcc.org
treatment is effective the statistical significance of the There was an imbalance between groups at baseline,
treatmenteffectbythetwomethodswilldependonthe withbetterscoresintheacupuncturegroup(seetable). BMJ2001;323:1123–4
correlation between baseline and follow up scores.If Analysis of post›treatment scores is therefore biased.
thecorrelationislowusingthechangescorewilladd The authors analysed change scores, but as baseline
variationandthefollowupscoreismorelikelytoshow and change scores are negatively correlated (about
asignificantresult.Conversely,ifthecorrelationishigh r= -0.25 within groups) this analysis underestimates
using only the follow up score will lose information theeffectofacupuncture.Fromanalysisofcovariance
andthechangescoreismorelikelytobesignificant.It weget:
is incorrect, however, to choose whichever analysis followupscore=
givesamoresignificantfinding.Themethodofanaly› 24+0.71(cid:215)baselinescore+12.7(cid:215)group
sisshouldbespecifiedinthetrialprotocol. (seefigure).Thecoefficientforgroup(b)hasause›
Someusechangescorestotakeaccountofchance fulinterpretation:itisthedifferencebetweenthemean
imbalancesatbaselinebetweenthetreatmentgroups. changescoresofeachgroup.Intheaboveexampleit
However, analysing change does not control for can be interpreted as “pain and function score
baseline imbalance because of regression to the improvedbyanestimated12.7pointsmoreonaverage
mean12:baselinevaluesarenegativelycorrelatedwith in the treatment group than in the control group.”A
change because patients with low scores at baseline 95%confidenceintervalandPvaluecanalsobecalcu›
generallyimprovemorethanthosewithhighscores.A lated for b (see table).5 The regression equation
better approach is to use analysis of covariance provides a means of prediction: a patient with a
(ANCOVA), which, despite its name, is a regression baselinescoreof50,forexample,wouldbepredicted
method.3 In effect two parallel straight lines (linear tohaveafollowupscoreof72.2ontreatmentand59.5
regression) are obtained relating outcome score to oncontrol.
baselinescoreineachgroup.Theycanbesummarised Anadditionaladvantageofanalysisofcovarianceis
asasingleregressionequation: thatitgenerallyhasgreaterstatisticalpowertodetecta
followupscore= treatmenteffectthantheothermethods.6Forexample,
constant+a(cid:215)baselinescore+b(cid:215)group atrialwithacorrelationbetweenbaselineandfollow
Resultsoftrialofacupunctureforshoulderpain4
Painscores(meanandSD)
Placebogroup Acupuncturegroup Differencebetweenmeans
(n=27) (n=25) (95%CI) Pvalue
Baseline 53.9(14) 60.4(12.3) 6.5
Analysis
Followup 62.3(17.9) 79.6(17.1) 17.3(7.5to27.1) 0.0008
Changescore* 8.4(14.6) 19.2(16.1) 10.8(2.3to19.4) 0.014
ANCOVA 12.7(4.1to21.3) 0.005
*Analysisreportedbyauthors.4
BMJ VOLUME323 10NOVEMBER2001 bmj.com 1123
BMJ:
first
published
as
10.1136/bmj.323.7321.1123
on
10
November
2001.
Downloaded
from
http://www.bmj.com/
on
6
December
2019
by
guest.
Protected
by
copyright.

Educationanddebate
|     |     |     |     |     | situations, | analysis | of change | scores | can | be a | BMJ: first published as 10.1136/bmj.323.7321.1123 on 10 November 2001. Downloaded from http://www.bmj.com/ on 6 December 2019 by guest. Protected by copyright. |
| --- | --- | --- | --- | --- | ----------- | -------- | --------- | ------ | --- | ---- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
erocs tnemtaert–tsoP 100 reasonable alternative, particularly if restricted
randomisationisusedtoensurebaselinecomparability
|     |     |     |     |     | between | groups.7 | Analysis | of covariance |     | is the |     |
| --- | --- | --- | --- | --- | ------- | -------- | -------- | ------------- | --- | ------ | --- |
preferredgeneralapproach,however.
80
Aswithallanalysesofcontinuousdata,theuseof
analysisofcovariancedependsonsomeassumptions
thatneedtobetested.Inparticular,datatransforma›
60
|     |     |     |     |     | tion, such | as taking | logarithms,   | may       | be indicated.8 |          |     |
| --- | --- | --- | --- | --- | ---------- | --------- | ------------- | --------- | -------------- | -------- | --- |
|     |     |     |     |     | Lastly,    | analysis  | of covariance | is a type | of             | multiple |     |
regressionandcanbeseenasaspecialtypeofadjusted
40
analysis.Theanalysiscanthusbeexpandedtoinclude
Acupuncture
|     |     |     |     |     | additional | prognostic | variables | (not | necessarily | con› |     |
| --- | --- | --- | --- | --- | ---------- | ---------- | --------- | ---- | ----------- | ---- | --- |
Placebo
tinuous),suchasageanddiagnosticgroup.
20
WethankDrJKleinhenzforsupplyingtherawdatafromhis
|     | 20  | 40  | 60 80 | 100 |     |     |     |     |     |     |     |
| --- | --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
study.
Pretreatment score
Pretreatmentandpost›treatmentscoresineachgroupshowingfitted 1 Bland JM, Altman DG. Regression towards the mean. BMJ
|     | lines.Squaresshowmeanvaluesforthetwogroups.Theestimated |     |     |     | 1994;308:1499. |     |     |     |     |     |     |
| --- | ------------------------------------------------------- | --- | --- | --- | -------------- | --- | --- | --- | --- | --- | --- |
differencebetweenthegroupsfromanalysisofcovarianceisthe 2 BlandJM,AltmanDG.Someexamplesofregressiontowardsthemean.
|     | verticaldistancebetweenthetwolines |     |     |     | BMJ1994;309:780.                                       |     |     |     |     |         |     |
| --- | ---------------------------------- | --- | --- | --- | ------------------------------------------------------ | --- | --- | --- | --- | ------- | --- |
|     |                                    |     |     |     | 3 SennS.Baselinecomparisonsinrandomizedclinicaltrials. |     |     |     |     | StatMed |     |
1991;10:1157›9.
|     |     |     |     |     | 4 KleinhenzJ,StreitbergerK,WindelerJ,GussbacherA,MavridisG,Mar› |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --------------------------------------------------------------- | --- | --- | --- | --- | --- | --- |
tinE.Randomisedclinicaltrialcomparingtheeffectsofacupunctureand
upscoresof0.6thatrequired85patientsforanalysisof
|     |                                              |     |     |     | a newly                                                    | designed | placebo needle | in rotator | cuff tendonitis. | Pain |     |
| --- | -------------------------------------------- | --- | --- | --- | ---------------------------------------------------------- | -------- | -------------- | ---------- | ---------------- | ---- | --- |
|     | followupscores,wouldrequire68forachangescore |     |     |     | 1999;83:235›41.                                            |          |                |            |                  |      |     |
|     |                                              |     |     |     | 5 AltmanDG,GardnerMJ.Regressionandcorrelation.In:AltmanDG, |          |                |            |                  |      |     |
analysisbutonly54foranalysisofcovariance.
MachinD,BryantTN,GardnerMJ,eds.Statisticswithconfidence.2nded.
|     | Theefficiencygainsofanalysisofcovariancecom› |     |     |     | London:BMJBooks,2000:73›92. |     |     |     |     |     |     |
| --- | -------------------------------------------- | --- | --- | --- | --------------------------- | --- | --- | --- | --- | --- | --- |
paredwithachangescorearelowwhenthereisahigh 6 VickersAJ.Theuseofpercentagechangefrombaselineasanoutcomein
acontrolledtrialisstatisticallyinefficient:asimulationstudy.BMCMed
correlation(sayr>0.8)betweenbaselineandfollowup
ResMethodol2001;1:16.
measurements.Thiswilloftenbethecase,particularly 7 AltmanDG,BlandJM.Howtorandomise.BMJ1999;319:703›4.
|     |                   |            |                  |          | 8 BlandJM,AltmanDG.Theuseoftransformationwhencomparingtwo |     |     |     |     |     |     |
| --- | ----------------- | ---------- | ---------------- | -------- | --------------------------------------------------------- | --- | --- | --- | --- | --- | --- |
|     | in stable chronic | conditions | such as obesity. | In these |                                                           |     |     |     |     |     |     |
means.BMJ1996;312:1153.
Amemorablepatient
Informedconsent
IfirstmetIvythreeyearsagowhenshecameforher
andshewasbroughtbackthefollowingdayfor
|     | 29thoesophagealdilatation.Shewasan86yearold |     |     |     | removalofthebolusbyendoscopy. |     |     |     |     |     |     |
| --- | ------------------------------------------- | --- | --- | --- | ----------------------------- | --- | --- | --- | --- | --- | --- |
spinster,deafwithoutspeechfromchildhood,andthe Shecametotheendoscopyroombutdidnothave
onlysignlanguagesheknewwasthumbsup,whichshe herfamiliarsmile.Shelookedaroundforaminute,got
woulduseforsayinggoodmorningorforshowing offhertrolley,andwalkedout.Everyoneinthe
happiness.Shehadnonextofkinandhadlivedina endoscopyroomunderstoodthatshewastryingtosay,
|     | residentialhomeforthepast50years.Shedevelopeda |     |     |     | “I’vehadenough.” |     |     |     |     |     |     |
| --- | ---------------------------------------------- | --- | --- | --- | ---------------- | --- | --- | --- | --- | --- | --- |
benignoesophagealstricturein1992andcametothe Shedidnotcomebackforarepeatendoscopy,and
endoscopyunitforrepeateddilatations.Thecarersin shestayednilbymouthonintravenousfluids.Two
theresidentialhomeusedtosaythatsheenjoyedher weekslatershediedofanaspirationpneumonia.We
“daysout”attheendoscopyunit. thinksheunderstoodalltheproceduresshehad
Wewouldexplaintheproceduretoherinsign agreedto.Wealsothinkitwasinformedconsent.I
language.Shewouldusethethumbsupsignandmake hopewewereright.Shegaveusaveryclearmessage
acrossonthedottedlineontheconsentform.She withoutsayingawordonherlastvisittothe
wouldentertheendoscopyroomsmiling,putherleft
endoscopyroom.
armouttobecannulated,turntoherleftsidefor Dowereallyunderstandwhataphasicpatientsare
endoscopy,andwhenfullyawakewouldshowher tryingtotelluswhenwegetinformedconsentfor
thumbsupagain.Everytimeafterherdilatationthe invasiveprocedures?Weshouldtrytoreadthe
|     | nursingstaffwouldquestionwhyanexpandable |     |     |     | non›verbalmessagesverycarefully. |     |     |     |     |     |     |
| --- | ---------------------------------------- | --- | --- | --- | -------------------------------- | --- | --- | --- | --- | --- | --- |
oesophagealstentwasnotbeingconsidered.Wewould
|     |     |     |     |     | ITiwari | associatespecialistingastroenterology,Broomfield |     |     |     |     |     |
| --- | --- | --- | --- | --- | ------- | ------------------------------------------------ | --- | --- | --- | --- | --- |
concludethattheindicationsforanexpandablestent
Hospital,Chelmsford
inbenignstricturesarenotwellestablished.
Herneedfordilatationwasbecomingmore Wewelcomearticlesofupto600wordsontopics
frequent,andsoonher46thdilatationwedecidedto suchasAmemorablepatient,Apaperthatchangedmy
referhertoourregionalcentrefortheinsertionofa practice,Mymostunfortunatemistake,oranyotherpiece
stent.Shehadanexpandablestentinserted,andinhis conveyinginstruction,pathos,orhumour.Ifpossible
reporttheendoscopistmentionedtheriskofthestent thearticleshouldbesuppliedonadisk.Permissionis
migratingdowninthestomachbeyondthestricture. neededfromthepatientorarelativeifanidentifiable
Sixweekslatershedevelopedabolusobstruction.At patientisreferredto.Wealsowelcomecontributions
endoscopyitwasnotedthatthestenthadindeed for“Endpieces,”consistingofquotationsofupto80
migrateddown.Sheconsentedtoanotherstent.Four words(butmostareconsiderablyshorter)fromany
weekslatershehadanotherbolusobstructionthat source,ancientormodern,whichhaveappealedto
|      | couldnotbecompletelyremovedatthefirstattempt, |     |     |     | thereader. |     |           |                |     |         |     |
| ---- | --------------------------------------------- | --- | --- | --- | ---------- | --- | --------- | -------------- | --- | ------- | --- |
| 1124 |                                               |     |     |     |            | BMJ | VOLUME323 | 10NOVEMBER2001 |     | bmj.com |     |
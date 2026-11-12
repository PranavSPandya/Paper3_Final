"Tell Me What That Is": Examining Blind and Low Vision
Individuals’ Reviews on Assistive Smartphone Applications
Waqar Hassan Khan Isaac Buo Ariane Middel
School of Computing and Augmented The GAME School The GAME School, School of
Intelligence Arizona State University Computing and Augmented
Arizona State University Tempe, Arizona, USA Intelligence
Tempe, Arizona, USA ibuo1@asu.edu Arizona State University
wkhan17@asu.edu Tempe, Arizona, USA
ariane.middel@asu.edu
Abstract Denver, CO, USA. ACM, New York, NY, USA, 6 pages. https://doi.org/10.
Smartphone applications (apps) designed for Blind and Low Vision 1145/3663547.3759699
(BLV) individuals play a crucial role in supporting their indepen-
dence and accessibility. In this study, we adopted a mixed-methods
approach, combining topic modeling, keyword-based filtering, and
1 Introduction
thematic analysis to analyze user-written reviews from 27 assistive
smartphone apps focused on navigation and object/text recognition. Smartphones have become an integral part of our lives. For Blind
We curated a list of 133 keywords related to visual impairment and and Low Vision (BLV) individuals, smartphones can serve as an
eye conditions and extracted 2,163 reviews (out of 12,229 reviews). assistive tool and enhance accessibility and independence [33]. iOS
We analyzed 3,163 reviews (containing the extracted 2,163 reviews and Android, the two major smartphone platforms, provide inte-
and a random 1,000 reviews that did not contain BLV-related key- grated assistive technology [19, 26, 33]. However, many applications
words). Our findings reveal six major categories of user feedback, (apps) do not provide adequate accessibility features [3, 21, 29, 33].
including praise and usefulness, general app usage, usability is- These shortcomings can often be identified through user-written
sues, feature requests, bug reports, and privacy concerns. From reviews [8, 22]. Incorporating user feedback from the reviews has
the 2,163 keyword-matched reviews, we manually annotated and been shown to have a positive impact on app success [23].
isolated 680 reviews written by or about BLV individuals, revealing Prior research has revealed how BLV individuals use smart-
references to 20 distinct eye conditions. Our analysis shows that phones [5, 25]. To explore accessibility challenges, researchers have
reviews involving BLV individuals appear more frequently in assis- analyzed Android app reviews related to accessibility [10] both
tive apps than in general-purpose ones. While the overall sentiment manually [3] and with automated techniques [1, 2]. Although prior
of these 680 reviews was positive, BLV-authored reviews contained research has analyzed top Android app reviews to uncover insights
a higher proportion of critical feedback—particularly regarding us- related to accessibility [10, 21], these studies primarily focused on
ability—compared to reviews from non-BLV users, highlighting the accessibility related reviews. As a result, there remains a gap in
need to prioritize their perspectives in app design. understanding the broader content of reviews for apps specifically
designed for BLV individuals. Thus, in this work, we focus on two
CCS Concepts types of apps that BLV individuals can use in their regular life to
enhance accessibility and independence: 1) apps for navigating and
• Human-centered computing → Empirical studies in acces-
2) apps for object/text recognition. We selected 27 such apps and
sibility.
analyzed their reviews to answer the following research questions:
Keywords
RQ1: What do users express in reviews of assistive apps designed
accessibility, blind, low vision, visual impairment, apps, user review, to help BLV individuals navigate and recognize objects? How
BLV can the reviews be categorized?
ACM Reference Format:
RQ2: Of all the reviews, how many involve or are written by BLV
Waqar Hassan Khan, Isaac Buo, and Ariane Middel. 2025. "Tell Me What
That Is": Examining Blind and Low Vision Individuals’ Reviews on Assis- individuals? Is the presence of such reviews higher in this
tive Smartphone Applications. In The 27th International ACM SIGACCESS type of app? What type of eye conditions do they mention?
Conference on Computers and Accessibility (ASSETS ’25), October 26–29, 2025, What sentiment do the reviews express?
Permission to make digital or hard copies of all or part of this work for personal or To address these research questions, we analyzed user reviews
classroom use is granted without fee provided that copies are not made or distributed from 27 assistive smartphone apps developed to aid BLV individuals
for profit or commercial advantage and that copies bear this notice and the full citation
navigate or detect objects and text. We adopted a mixed methods
on the first page. Copyrights for third-party components of this work must be honored.
For all other uses, contact the owner/author(s). approach that combined keyword-based filtering, topic modeling [6,
ASSETS ’25, Denver, CO, USA 16], and thematic analysis [9]. Our findings reveal not only the
© 2025 Copyright held by the owner/author(s).
diverse experiences of BLV individuals but also highlight the crucial
ACM ISBN 979-8-4007-0676-9/25/10
https://doi.org/10.1145/3663547.3759699 role of BLV user feedback in improving assistive technologies.

ASSETS ’25, October 26–29, 2025, Denver, CO, USA Waqar Hassan Khan et al.
Figure 1: Overview of the methodological workflow: (1) selection of 27 assistive apps and retrieval of 12,229 user reviews; (2)
preprocessing and topic modeling to define review categories; (3) keyword-based filtering to identify 2,163 reviews related
to visual impairment, including 680 written by or about Blind and Low Vision (BLV) individuals; and (4) top-down thematic
analysis of 3,163 reviews to uncover user perspectives. Each step corresponds to a subsection in the Methodology.
2 Methodology 2.2 Topic modeling and Review Category
Our methodology involved four key stages (Fig. 1): (1) identifying Creation
and selecting relevant apps from major app platforms and online We adopted a topic-modeling approach to categorize the 12,229 re-
sources; (2) retrieving, cleaning, and preparing user review data views using the Latent Dirichlet Allocation (LDA) model [6, 16]. We
for analysis and creating categories; (3) identifying and analyzing pre-processed the reviews in three steps — tokenization, lemmatiza-
reviews specifically referencing BLV individuals; and (4) applying tion, and stop word elimination [15, 24] and then ran the model [27]
topic modeling to assign categories to the reviews. on the processed data. We used a coherence score (CV metric) [28]
to evaluate the results. To achieve a good coherence score [7], we
ran the model ten times and fine-tuned it. Moreover, from the initial
2.1 Selection of Apps and Review Retrieval
results, we identified keywords — app, good, great, application, use,
We focused on two categories of apps that BLV individuals can using, love, like, thank, thanks, work — that appeared frequently in
utilize to perform essential daily tasks: 1) navigation and 2) object the topics and made them less interpretable. We reran the whole
and text recognition. We searched for the apps of the desired cate- process by adding these with the stop words and were able to im-
gories on Google Play [14] and Apple App Store [4]. Moreover, we prove the coherence score. We ran the LDA model separately for
explored online resources discussing apps helpful for BLV individu- the reviews of the two app categories (Be My Eyes was considered
als [12, 17, 31]. We merged the results and inspected the descriptions with navigation). Finally, we retrieved six topics for the navigation
of these apps on Google Play and the Apple App Store to ensure app reviews (coherence=0.56) and five topics for the object and text
that they had been created exclusively for BLV individuals. Finally, recognition app reviews (coherence=0.61). From the keywords for
we selected 27 apps (Table 3), among which ten were only available each topic, we determined a category (Table 1 and 2). Merging these
for iOS and two were only available for Android. Among the 27 two, we developed four categories: (1) Praise and usefulness -
apps, we included an app called Be My Eyes [11], which enables reviews expressing satisfaction with the app, or describing how
users to connect with sighted volunteers for assistance. Although it is helpful, or praising it; (2) General app usage -reviews that
the app is officially categorized under Lifestyle in the Apple App describe everyday usage or app functionality; (3) Usability issues
Store, it can be utilized for both navigation and object recognition. and negative feedback -reviews that describe the challenges in
We utilized two Python libraries [20, 30] to extract publicly avail- using the app, or features and styles that the users do not like; (4)
able app reviews from Google Play and the Apple App Store, result- Feature requests -reviews suggesting new features or asking for
ing in 13,641 reviews (7,562 from Google Play and 6,079 from the improvements to existing functionality. Additionally, we included
Apple App Store) written between 2010 and 2025. Five of the se- two more categories from prior research [18, 21, 22]: (5) Bug re-
lected apps did not have any reviews. Non-English and emoji-only ports -where users report app crashes, unexpected behaviors, etc.,
reviews were excluded, resulting in 12,229 reviews. and (6) Privacy and security issues -reviews that mention data
The app reviews were publicly available. Thus, IRB approval privacy, permissions or trust/security concerns.
was not required. To ensure anonymity, we only stored the reviews,
user ratings, and review dates, excluding any personally identifiable
2.3 Identifying Reviews Related to BLV
information (e.g., username, profile picture). Moreover, the reviews
Individuals
quoted in this paper’s findings were paraphrased in such a way
that preserves the original meaning but prevents the identification We identified reviews that involved users with visual impairments
of the original authors. or eye-related conditions. We compiled a list of eye conditions using

Examining Blind and Low Vision Individuals’ Reviews on Assistive Smartphone Applications ASSETS ’25, October 26–29, 2025, Denver, CO, USA
the “Glossary of Eye Conditions” from the American Foundation college to read signs at train stations, and also in class to help me find
for the Blind [13] and “Common Vocabulary in Eye Reports” by [32]. the lecture halls.” (user review, Lookout -Assisted Vision). Another
We considered all the terms related to the eye and diseases of the user mentioned, “I assisted a woman by reading her prescription
eye, yielding 133 keywords. We conducted a keyword search across labels so she could identify the correct medication.” (user review,
all reviews and found 2,163 reviews (out of 12,229) that had at least Be My Eyes). The reviews in this category indicate that users rely
one keyword from the list and manually inspected these reviews. on the apps for a variety of everyday tasks, such as outdoor and
Reviews with vague references, such as those stating that the app indoor navigation, identifying groceries, clothes, and more. Future
was helpful to blind individuals without further context, were ex- research could provide detailed insights into how BLV individuals
cluded. In these cases, the reviewer’s identity was unclear, and it utilize these apps in outdoor and indoor environments.
was uncertain whether they had first-hand experience or direct
3.1.3 Usability issues and negative feedback (n=489). In these re-
involvement with a BLV user who benefits from the app. There
views, users complained about features they disliked, such as the
were 680 reviews involving BLV individuals. Each of these reviews
user interface (UI) (e.g., no dark theme, small fonts, low contrast).
was labeled with the sentiment they expressed (positive, negative,
Some mentioned apps being less accessible: “Tabular and Excel data
and neutral), the eye condition (e.g., legally blind, macular degener-
should be presented in a more accessible way.” (user review, Envision
ation, etc.) mentioned in it, and the reviewer (BLV individual, their
AI). Pricing was also a prevailing concern, with BLV individuals
family members or friends, or someone else).
mentioning that they already have many accessibility-related ex-
penses, making it difficult to purchase additional apps. Users also
2.4 Categorization of App Reviews
complained about apps being laggy, incompatibility with older
We filtered the reviews (2,163) related to visual impairment from phones, video and image quality, etc. These reviews offer valuable
all the reviews (12,229). From the remaining reviews that did not insights for developers by highlighting less desired features by the
have any keywords related to visual impairment, we randomly users and opportunities to enhance the user experience. However,
selected 1,000 reviews, each containing at least five words. These user experience varies significantly, and customizable accessibility
1,000 random reviews were then merged with the 2,163 reviews features are desired: “Not every blind person does things the same
related to visual impairment, yielding a data set of 3,163 reviews. way. We should be able to choose the accessibility features that suit
These reviews were analyzed manually in a deductive (top-down us.” (user review, Be My Eyes). Thus, the design process of these
thematic analysis) approach [9]. The categories that we created apps should actively involve BLV individuals.
were used as themes.
3.1.4 Feature requests (n=208). Users requested a wide range of
3 Results and Discussion features, including support for additional languages (e.g., Arabic,
Bengali, French, Indian regional languages), capability of identi-
3.1 RQ1: Categories of the App Reviews
fying different currencies, integration with smart glasses, offline
The reviews (n=3,163) were assigned one or more categories (Fig. 2a). functionality, facial recognition from photos, image sharing and
Some reviews (n=100) were irrelevant, out of context, and insub- importing, alternative notification methods, enabling volunteers to
stantial (e.g., “how do blind people install apps?”); thus, they were set availability, support for reading PDF and DOC files, etc. Some
marked as outliers. The insights from the analysis of the rest os the apps are only available for iOS, and users have asked for an Android
reviews are presented in the following subsubsections: version. A significant presence of reviews with language support
indicates that not all BLV individuals have equal opportunities, par-
3.1.1 Praise and usefulness (n=2142). The majority of the reviews
ticularly those in underdeveloped regions. Future research should
fall in this category. In these reviews, the users have expressed satis-
explore accessibility issues, technology usage, and the specific needs
faction and love for the app. These often included positive feedback
of BLV individuals from underdeveloped regions.
emphasizing usefulness and accessibility. In some of the reviews,
gratitude to the developers was expressed: “I really appreciate this 3.1.5 Bug reports (n=89). Users reported various unexpected be-
tool; it’s the most helpful one for people like me with dyslexia.” (user haviors of the apps, including glitches during sign-up or sign-in,
review, Seeing AI). Another user wrote, “I think this app could dra- unresponsive UI elements such as buttons, crashes on particular de-
matically improve accessibility for blind people everywhere.” (user vices, notification issues, inaccuracy in image recognition, location
review, Lookout -Assisted Vision). Users also mentioned how the inaccuracy, and problems introduced by buggy updates. Some re-
apps enabled them to gain independence, which they value greatly: views mentioned bugs without providing specific details. Bugs can
“Blind users often hesitate to seek assistance, but this app enables us to be found in all types of software. However, bugs in assistive apps
be self-reliant.” (user review, TapTapSee). A significant presence of can be dangerous, as one user reported that the app provided them
this category suggests that these apps have a positive impact on the with the results of a past image scan where they were scanning
everyday activities of BLV individuals, enhancing their accessibility medications: “I tried to use it to read my prescription, but instead it
and independence. These reviews also reveal user-favored features showed me an old one that I scanned previously. It’s really risky if it
that developers can leverage to enhance their apps. tells me I’m taking the wrong medicine.” (user review, Be My Eyes).
3.1.2 General app usage (n=558). This category includes reviews 3.1.6 Privacy and security issues (n=56). All the reviews of this
about how the app is used or what can be done using the app. Users category belong to the app Be My Eyes. Users raised concerns about
often shared specific scenarios, detailing the tasks they completed the app sharing information with third-party organizations. One
using the app: “I use this app daily during my commute from home to user mentioned the possibility of confidential data (e.g., credit card

ASSETS ’25, October 26–29, 2025, Denver, CO, USA  Waqar Hassan Khan et al.
100%
0.00 %
|     | Outlier  3 .1 6%  |     |     | 90%  |     |     |
| --- | ----------------- | --- | --- | ---- | --- | --- |
86%
1 .0 1 %
| Privacy and security issues  | 1 .7 7 %   |     |     | 80%  77%  74%  |     |     |
| ---------------------------- | ---------- | --- | --- | -------------- | --- | --- |
 sweiveR fo egatnecreP 70%  68%
| Bug reports       | 1.2 6 %    |     |     |      |     |     |
| ----------------- | ---------- | --- | --- | ---- | --- | --- |
|                   | 2 .8 1%    |     |     | 60%  |     |     |
| Feature requests  | 7 .3 0 %   |     |     | 50%  |     |     |
6 .5 8 %
40%
21.91%
| Usability issues and negative feedback  | 15.46%  |     |     |     |     |     |
| --------------------------------------- | ------- | --- | --- | --- | --- | --- |
30%
36.27%
| General app usage      |                        | 17.64%                  |                         | 20%       | 17%  18%  |             |
| ---------------------- | ---------------------- | ----------------------- | ----------------------- | --------- | --------- | ----------- |
|                        |                        |                         |                         |           | 14%       | 14%         |
|                        |                        |                         |                         | 10%       | 8%        | 9%  9%  6%  |
| Praise and usefulness  |                        |                         | 57.68%                  |           |           |             |
|                        |                        |                         | 67.72%                  | 0%        |           |             |
|                        |                        |                         |                         | Positive  | Negative  | Neutral     |
|                        | 0.00%  10.00%  20.00%  | 30.00%  40.00%  50.00%  | 60.00%  70.00%  80.00%  |           |           |             |
BLV Individual Written Reviews  All reviews  All  Self  Friends or Family  Other People
|     |     | (a)  |     |     | (b)  |     |
| --- | --- | ---- | --- | --- | ---- | --- |
Figure 2: a) Category distribution of reviews across all reviews (n=3,163) and the subset written by BLV individuals (n=397).
While "Praise and Usefulness" dominates both groups, BLV-written reviews show higher proportions of "General App Usage"
and "Usability Issues," offering deeper insights into real-world use cases and challenges faced by BLV users. b) Sentiment
distribution of reviews involving BLV individuals, categorized by overall authors, BLV individuals themselves, their family and
friends, and other people
information) being exposed when a BLV individual seeks sighted  We specifically examined the perspective of BLV individuals by
help. One visually impaired user wrote that the app refused to  comparing the distribution of review categories across all reviews
read out credit card information to preserve privacy and suggested  and those written by BLV individuals (Fig. 2a). Most of the reviews
calling a volunteer: “As a blind user, I need to check my credit card  fall into the first category, where users expressed how useful the app
details, but the app refuses for privacy reasons and tells me to call a  is. The proportions across categories are generally similar, except
volunteer. Why share sensitive info with a stranger? An AI reading  for the second and third categories, which are more prominent in
it would be more secure”. The most common privacy issue was  BLV-authored reviews. BLV individuals shared a lot about how they
people who faked visual impairment and played a prank or sexually  use these apps, contributing to the higher prevalence of the second
harassed volunteers, highlighting the necessity for user verification  category. These reveal real-world usage contexts that can help app
during the onboarding process in remote sighted assistance apps.  developers improve app functionality and guide Software Quality
The absence of privacy concerns in other app reviews calls for  Assurance (SQA) teams in designing realistic test cases. The third
further research. Interviewing users of those apps may help surface  category also has a significant presence, with expressed usability is-
privacy concerns.  sues. This may explain why the number of negative reviews written
by BLV individuals is higher compared to other people. However,
3.2  RQ2: Insights from Reviews Involving BLV  only 11 (0.08% of the total) BLV-authored reviews were related to
Of the 2,163 reviews containing at least one keyword related to vi- accessibility, which aligns with previous research [10, 21].
sual impairment or eye conditions, 680 reviews involved BLV users.
4  Conclusion
These reviews were either written by BLV individuals (n=397), or
their family and friends (n=65), or by another person (n=218). A  We presented an analysis of user-written reviews from 27 assistive
total of 20 eye conditions (listed in A.1) were mentioned. These  smartphone apps designed for BLV individuals. We categorized over
included, but were not limited to, total or legal blindness, color  3,000 reviews and identified six prominent themes. Our findings
blindness, partial sight, having low vision, albinism, macular degen- reveal that a substantial portion of the reviews—especially those
eration, retinal detachment, glaucoma, and retinitis pigmentosa.  authored by BLV individuals or their close networks—highlight
Among all the reviews, 17% had at least one keyword related  both the value and the limitations of these apps. We found that the
to visual impairment. 5.5% of the total reviews explicitly involved  majority of reviews expressed positive sentiment, particularly about
BLV individuals. In contrast, previous research on general-purpose  the apps’ usefulness in fostering independence and accessibility.
apps found that less than 0.1% of the reviews included keywords
In contrast to prior studies that examined general-purpose apps,
related to visual impairment [21], suggesting that assistive apps  our approach showed a significantly higher prevalence of BLV-
have more reviews involving BLV individuals.  related content and user engagement in these niche applications.
The sentiment analysis of reviews related to BLV individuals  Future research could expand the scope to include additional app
showed an overall positive impression (Fig. 2b), even when reviews  categories beyond navigation and object recognition, incorporate
were grouped by author, suggesting the usefulness of the apps.  other review platforms and languages, and involve collaborative
However, we observed a significantly higher proportion of negative  annotation to minimize individual bias. Despite limitations related
reviews among those written by BLV individuals or their family  to app selection imbalance (72% of the reviews referred to one app,
and friends, compared to those written by others.  five of the apps did not have reviews, and 11 apps had fewer than

Examining Blind and Low Vision Individuals’ Reviews on Assistive Smartphone Applications ASSETS ’25, October 26–29, 2025, Denver, CO, USA
20 reviews), our findings highlight the importance of centering [20] Jo Mingyu. 2024. Google-Play-Scraper. Retrieved May 7, 2025 from https://pypi.
user feedback—especially from marginalized communities—in the org/project/google-play-scraper/
[21] Alberto Dumont Alves Oliveira, Paulo Sérgio Henrique Dos Santos, Wil-
development and refinement of assistive digital tools.
son Estécio Marcílio Júnior, Wajdi M Aljedaani, Danilo Medeiros Eler, and
Marcelo Medeiros Eler. 2023. Analyzing Accessibility Reviews Associated with
Visual Disabilities or Eye Conditions. In Proceedings of the 2023 CHI Conference
Acknowledgments on Human Factors in Computing Systems. 1–14.
[22] Dennis Pagano and Walid Maalej. 2013. User feedback in the appstore: An
We are grateful to Rudaiba Adnin for providing valuable feedback empirical study. In 2013 21st IEEE international requirements engineering conference
on the abstract and for suggesting an improvement to the paper (RE). IEEE, 125–134.
[23] Fabio Palomba, Mario Linares-Vásquez, Gabriele Bavota, Rocco Oliveto, Massim-
title. The icons used in Fig. 1 were created by Freepik (Database and
iliano Di Penta, Denys Poshyvanyk, and Andrea De Lucia. 2015. User reviews
Apple App Store icon), Ricardo Ruiz (Google Play Store), Icongeek26 matter! tracking crowdsourced reviews to support evolution of successful apps. In
(Website icon in App Selection), mikan933 (Literature review search 2015 IEEE international conference on software maintenance and evolution (ICSME).
IEEE, 291–300.
icon), and Vectorslab (VI keywords search icon) from www.flaticon.
[24] Brandon Palonis, Samantha Jane Dobesh, Selah Bellscheidt, Mohamed Wiem
com, and are used under Flaticon’s free license with attribution Mkaouer, Yudong Liu, and Yasmine N Elglaly. 2023. Large-Scale Anonymized
Text-based Disability Discourse Dataset. In Proceedings of the 25th International
ACM SIGACCESS Conference on Computers and Accessibility. 1–5.
References [25] Yogendra Pandey, Jaehoon Lee, Devender R Banda, Nora Griffin-Shirley, The
Nguyen, and Vitalis Othuon. 2023. A survey of mobile app use among university
[1] Wajdi Aljedaani, Mohamed Wiem Mkaouer, Stephanie Ludi, and Yasir Javed. students with visual impairment in India. British Journal of Visual Impairment
2022. Automatic classification of accessibility user reviews in android apps. In 41, 3 (2023), 662–674.
2022 7th international conference on data science and machine learning applications [26] Mauro C Pichiliani and Celso M Hirata. 2015. Evaluation of the android accessi-
(CDMA). IEEE, 133–138. bility api recognition rate towards a better user experience. In Universal Access
[2] Eman Abdullah AlOmar, Wajdi Aljedaani, Murtaza Tamjeed, Mohamed Wiem in Human-Computer Interaction. Access to Today’s Technologies: 9th International
Mkaouer, and Yasmine N El-Glaly. 2021. Finding the needle in a haystack: On Conference, UAHCI 2015, Held as Part of HCI International 2015, Los Angeles, CA,
the automatic identification of accessibility user reviews. In Proceedings of the USA, August 2-7, 2015, Proceedings, Part I 9. Springer, 340–349.
2021 CHI conference on human factors in computing systems. 1–15. [27] Radim Řehůřek and Petr Sojka. 2010. Software Framework for Topic Modelling
[3] Abdulaziz Alshayban, Iftekhar Ahmed, and Sam Malek. 2020. Accessibility issues with Large Corpora. In Proceedings of the LREC 2010 Workshop on New Challenges
in android apps: state of affairs, sentiments, and ways forward. In Proceedings of for NLP Frameworks. ELRA, Valletta, Malta, 45–50. http://is.muni.cz/publication/
the ACM/IEEE 42nd International Conference on Software Engineering. 1323–1334. 884893/en.
[4] Apple. 2008. App Store. Retrieved May 7, 2025 from https://www.apple.com/app- [28] Michael Röder, Andreas Both, and Alexander Hinneburg. 2015. Exploring the
store/ space of topic coherence measures. In Proceedings of the eighth ACM international
[5] Giulia Barbareschi, Catherine Holloway, Katherine Arnold, Grace Magomere, conference on Web search and data mining. 399–408.
Wycliffe Ambeyi Wetende, Gabriel Ngare, and Joyce Olenja. 2020. The social [29] Christopher Vendome, Diana Solano, Santiago Liñán, and Mario Linares-Vásquez.
network: How people with visual impairment use mobile phones in kibera, Kenya. 2019. Can everyone use my app? an empirical study on accessibility in android
In Proceedings of the 2020 CHI conference on human factors in computing systems. apps. In 2019 IEEE International Conference on Software Maintenance and Evolution
1–15. (ICSME). IEEE, 41–52.
[6] David M Blei, Andrew Y Ng, and Michael I Jordan. 2003. Latent dirichlet allocation. [30] Denis Washington and Eric Lim. 2024. Google-Play-Scraper. Retrieved May 7,
Journal of machine Learning research 3, Jan (2003), 993–1022. 2025 from https://pypi.org/project/app-store-web-scraper/
[7] Chaitanya Chemudugunta, Padhraic Smyth, and Mark Steyvers. 2006. Model- [31] Carmen Willings. [n. d.]. Teaching Students with Visual Impairments. Retrieved
ing general and specific aspects of documents with a probabilistic topic model. May 7, 2025 from https://www.teachingvisuallyimpaired.com/navigation--
Advances in neural information processing systems 19 (2006). location-apps.html
[8] Adelina Ciurumelea, Andreas Schaufelbühl, Sebastiano Panichella, and Harald C [32] Teaching Students with Visual Impairments. [n. d.]. Common Vocabulary in Eye
Gall. 2017. Analyzing reviews and code of mobile apps for better release planning. Reports. Retrieved June 15, 2025 from https://www.teachingvisuallyimpaired.
In 2017 IEEE 24th international conference on software analysis, evolution and com/common-vocabulary.html
reengineering (SANER). IEEE, 91–102. [33] Shunguo Yan and PG Ramachandran. 2019. The current status of accessibility in
[9] Victoria Clarke and Virginia Braun. 2014. Thematic analysis. In Encyclopedia of mobile apps. ACM Transactions on Accessible Computing (TACCESS) 12, 1 (2019),
quality of life and well-being research. Springer, 6626–6628. 1–31.
[10] Marcelo Medeiros Eler, Leandro Orlandin, and Alberto Dumont Alves Oliveira.
2019. Do Android app users care about accessibility? an analysis of user reviews
A Appendix
on the Google play store. In Proceedings of the 18th Brazilian symposium on human
factors in computing systems. 1–11.
A.1 Eye Conditions
[11] Be My Eyes. 2015. Be My Eyes. Retrieved May 7, 2025 from https://www.
bemyeyes.com/ We found 20 distinct eye conditions mentioned in the reviews —
[12] American Foundation for the Blind. [n. d.]. Three Blindness-Aware Mobile
Navigation Apps. Retrieved May 7, 2025 from https://www.afb.org/blindness- vision, partially sighted, low vision, impaired, blind, blindness, legally
and-low-vision/using-technology/smartphone-gps-navigation-people-visual- blind, totally blind, glaucoma, macular degeneration, peripheral vi-
impairments/three
sion, impairement, VI, retinal detachment, visual acuity, retinitis pig-
[13] American Foundation for the Blind. 2025. Glossary of Eye Conditions. https:
//www.afb.org/blindness-and-low-vision/eye-conditions. Accessed: June 15, mentosa, glare, albinism, color blindness, and CVI. Moreover, tools
2025. such as braille and lens were mentioned. Dyslexia, a neurologi-
[14] Google. 2012. Android Apps on Google Play. Retrieved May 7, 2025 from https:
//play.google.com/
cal condition, was mentioned, which is not a vision disorder but
[15] Gregory Grefenstette. 1999. Tokenization. In Syntactic wordclass tagging. Springer, presents challenges similar to those experienced by BLV individu-
117–133. als.
[16] Thomas Griffiths, Mark Steyvers, David Blei, and Joshua Tenenbaum. [n. d.].
Integrating topics and syntax. Advances in neural information processing systems
17 ([n. d.]). A.2 Topic Modeling Results
[17] Justin Harris. 2022. Free navigation apps for the blind. Retrieved May 7, 2025
from https://applevis.com/forum/ios-ipados/free-navigation-apps-blind A.3 List of selected apps
[18] Waqar Hassan Khan, Protik Bose Pranto, Tianyi Yang, and Rakibul Hasan. 2023.
Exploring Privacy and Security Concerns of EdTech Users: A Qualitative Analysis
of User Written Reviews. (2023).
[19] Barbara Leporini, Maria Claudia Buzzi, and Marina Buzzi. 2012. Interacting with
mobile devices via VoiceOver: usability and accessibility issues. In Proceedings of
the 24th Australian computer-human interaction conference. 339–348.

ASSETS ’25, October 26–29, 2025, Denver, CO, USA  Waqar Hassan Khan et al.
Table 1: Navigation app review categories and associated keywords. The six topics were identified through Latent Dirichlet
Allocation (LDA) modeling applied to navigation app reviews.
| Category  |     | Keywords  |     |     |     |
| --------- | --- | --------- | --- | --- | --- |
The review expresses that the app is helpful for blind people  blind, helpful, useful, eye, person, people, microsoft, life, make, developer
The users describing challenges related to some feature  help, call, get, answer, time, phone, receive, month, need, try
The review is about adding new features to the app  feature, time, add, ai, option, language, star, update, want, find
The review praises the app  help, people, need, able, amazing, way, volunteer, easy, feel, idea
The review is about content recognition  read, tell, product, mail, identify, service, try, person, ask, email
The review is about volunteering (a functionality of an app)  friend, get, know, today, volunteer, think, nice, recommend, help, hear
Table 2: Object and text recognition app review categories and associated keywords. The five topics were derived from LDA
modeling of reviews for object and text recognition apps.
| Category  |     | Keywords  |     |     |     |
| --------- | --- | --------- | --- | --- | --- |
The user is praising the app’s features  blind, people, picture, thing, amazing, tell, think, see, money, try
The review is about the app’s functionality  picture, read, take, pay, time, scan, well, get, free, thing
The review is about adding new features to the app; The review is about  blind, read, help, identify, picture, add, language, helpful, useful,
| the usefulness of the app  |     | easy  |     |     |     |
| -------------------------- | --- | ----- | --- | --- | --- |
The review discusses general app usage or usability challenges  read, thing, picture, time, text, know, find, want, blind, file
The review is about document scanning or text reading improvements  time, read, update, document, scan, text, page, try, buy, fix
Table 3: List of assistive apps analyzed in this study. Each entry includes the app name, platform availability (iOS, Android,
or both), and its primary function (navigation or object/text recognition). The selection process ensured that all apps were
designed specifically to support BLV individuals in their daily activities.
|     |     |     | Total Reviews  | Total Reviews  | Total Reviews Related  |
| --- | --- | --- | -------------- | -------------- | ---------------------- |
Name  Category  Platform  Collected  Categorized  BVI Individuals
Lazarillo Accessible GPS  Navigation  Android, iOS  133  50  17
| Blind Explorer  | Navigation  | Android, iOS  | 12    | 3     | 0    |
| --------------- | ----------- | ------------- | ----- | ----- | ---- |
| Be My Eyes      | Lifestyle   | Android, iOS  | 8820  | 2125  | 351  |
Vision: for blind people  Navigation  Android, iOS  14  4  0
| BlindSquare                  | Navigation  | iOS  | 83  | 39  | 17  |
| ---------------------------- | ----------- | ---- | --- | --- | --- |
| Loadstone GPS                | Navigation  | iOS  | 2   | 0   | 0   |
| VoiceVista                   | Navigation  | iOS  | 15  | 2   | 1   |
| Oko -Cross streets and Maps  | Navigation  | iOS  | 82  | 28  | 17  |
| NaviBlind                    | Navigation  | iOS  | 0   | 0   | 0   |
RightHear -Blind Assistant  Navigation  Android, iOS  32  9  1
| WeWALK -Smart Map      | Navigation  | Android, iOS  | 31  | 7   | 2   |
| ---------------------- | ----------- | ------------- | --- | --- | --- |
| Seeing Eye GPS         | Navigation  | iOS           | 37  | 15  | 6   |
| Seeing Assistant Move  | Navigation  | Android, iOS  | 3   | 2   | 1   |
| All_Aboard             | Navigation  | Android, iOS  | 0   | 0   | 0   |
| AI Guide Dog           | Navigation  | iOS           | 0   | 0   | 0   |
| NOA Companion          | Navigation  | Android, iOS  | 0   | 0   | 0   |
| OpenWay                | Navigation  | Android       | 0   | 0   | 0   |
Seeing AI  Object and text recognition  Android, iOS  631  225  85
Lookout -Assisted vision  Object and text recognition  Android  469  125  24
NaviLens  Object and text recognition  Android, iOS  39  12  3
Envision AI  Object and text recognition  Android, iOS  623  161  35
Supersense -AI for Blind  Object and text recognition  iOS  107  30  8
OneStep Reader  Object and text recognition  Android, iOS  361  93  30
TapTapSee  Object and text recognition  Android, iOS  653  206  73
Seeing Assistant Home  Object and text recognition  Android, iOS  11  3  1
| Digit-Eyes  | Object and text recognition  | iOS  | 29  | 8   | 5   |
| ----------- | ---------------------------- | ---- | --- | --- | --- |
Cash Reader for the Blind  Object and text recognition  iOS  42  16  6
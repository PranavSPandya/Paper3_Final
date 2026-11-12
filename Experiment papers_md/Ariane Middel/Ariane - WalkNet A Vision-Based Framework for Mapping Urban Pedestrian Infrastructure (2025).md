.yranimilerpebyamataD.deweiver-reepneebtonsahdnatnirperpasisihT—1v/90061023.364043671.ua/14522.01/gro.iod//:sptth—.noissimreptuohtiwesueroN.devresersthgirllA.rednuf/rohtuaehtsiredlohthgirypocehT—5202voN71nodetsoP
| WalkNet:    | A Vision-Based   |           | Framework      | for Mapping | Urban |
| ----------- | ---------------- | --------- | -------------- | ----------- | ----- |
| Pedestrian  | Infrastructure   |           |                |             |       |
| Protik Bose | Pranto1, Isaac   | Buo1, and | Ariane Middel1 |             |       |
| 1Arizona    | State University |           |                |             |       |
| November    | 17, 2025         |           |                |             |       |
Abstract
Pedestrianinfrastructureisinadequatelyorinconsistentlymappedinmostcities,limitingeffortstoassesswalkability,accessi-
bility, and equitable transportation systems. This study introduces WalkNet, a city-wide scalable framework that generates
detailed, georeferenced pedestrian networks by integrating street-level imagery with open geospatial data. The framework
applies a semantic segmentation model on panoramic images to extract sidewalks and roads, then computes a sidewalk-to-
road height ratio as a geometric proxy for road type. It classifies roads as arterial, collector, or residential using the ratio,
aligning with U.S. transportation codes. We implemented WalkNet in Phoenix, Arizona, a city with a diverse urban form.
UsingtheSegmentAnythingmodel,GoogleStreetViewimagery,andOpenStreetMap,WalkNetachieved78.2%overallroad
classificationaccuracy,98.05%and78.19%forarterialandresidentialroads,respectively. Collectorroadsshowedhighrecall
(96.43%)butlowerprecisionduetooverlapwithresidentialfeatures. Amanualevaluationconfirmedthattherepresentation
of crosswalks, park trails, and informal footways in OpenStreetMap often does not match real-world conditions, highlighting
keygapsinexistingopenpedestrianmaps. Theresultsshowthatvisuallyderivedmetricscansupportcity-scaleinfrastructure
mapping. Researchers and city planners can use the resulting data to support thermal comfort routing, walkability analyses,
and climate-responsive urban planning. In addition, Walknet is a low-cost alternative to comprehensively map pedestrian
infrastructurecomparedtoclassicalfield-surveyingmethods.
Figure 1: In the figure, there is an example of Pedestrian Network Mapping. On the left, a sample area in
Phoenix, Arizona, before processing. On the right, the same area after applying WalkNet, with different
walkable features color-coded for clarity. Sidewalks are shown in red, crosswalks in blue, parks in green, and
| other walkable | features in yellow. |     |     |     |     |
| -------------- | ------------------- | --- | --- | --- | --- |
Hosted file
1

.yranimilerpebyamataD.deweiver-reepneebtonsahdnatnirperpasisihT—1v/90061023.364043671.ua/14522.01/gro.iod//:sptth—.noissimreptuohtiwesueroN.devresersthgirllA.rednuf/rohtuaehtsiredlohthgirypocehT—5202voN71nodetsoP
AGU Annual Meeting’25.pptx available at https://authorea.com/users/981631/articles/1352124-
walknet-a-vision-based-framework-for-mapping-urban-pedestrian-infrastructure
2
Package ‘usdm’
May8,2026
Type Package
Title UncertaintyAnalysisforSpeciesDistributionModels
Version 2.1-7
Date 2023-09-29
Author BabakNaimi
Depends methods,terra
Imports raster
Maintainer BabakNaimi<naimi.b@gmail.com>
Description Thisisaframeworkthataimstoprovidemethodsandtoolsforassessingtheim-
pactofdifferentsourcesofuncertainties(e.g.positionaluncertainty)onperfor-
manceofspeciesdistributionmodels(SDMs).)
License GPL(>=3)
URL https://r-gis.net/
NeedsCompilation no
Repository CRAN
Date/Publication 2023-09-2904:20:02UTC
Contents
usdm-package . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 2
exclude . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 2
lisa . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 4
plot.RasterVariogram . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 6
plot.speciesLISA . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 7
RasterVariogram-class . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 9
speciesLisa . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
speciesLISA-class . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
Variogram . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
vif . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
VIF-class . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
Index 18
1

2 exclude
usdm-package UncertaintyanalysisforSDMs
Description
Thispackageprovidesanumberoffunctionsforexploringtheimpactofdifferentsourcesofuncer-
tainties(e.g.positionaluncertainty)onperformanceofspeciesdistributionmodels(SDMs).
Inaddition,thereisafunctiontoquantifydifferentlocalindicatorsofspatialassociation(LISA)for
rasterdata.
Author(s)
BabakNaimi<naimi.b@gmail.com>
https://r-gis.net/
https://www.biogeoinformatics.org/
exclude ExcludingvariablesspecifiedinaVIFobject
Description
Phisicallyexcludethecollinearvariableswhichareidentifiedusingvifcororvifstepfromaset
ofvariables.
Usage
exclude(x, vif, ...)
Arguments
x explanatory variables (predictors), defined as a raster object (RasterStack or
RasterBrick),orasamatrix,orasadata.frame.
vif anobjectofclassVIF,resultedfromvifcororvifstepfunctions.
... additionalargumentasinvifstep
Details
Beforeusingthisfunction,youshouldexecuteoneofvifsteporvifcorwhichdetectcollinearity
based on calculating variance inflation factor (VIF) statistics. If vif is missing, then vifstep is
called.
Value
anobjectofclasssameasx(i.e. RasterStackorRasterBrickordata.frameormatrix)

exclude 3
Author(s)
BabakNaimi<naimi.b@gmail.com>
https://r-gis.net/
https://www.biogeoinformatics.org/
References
IFyouusedthismethod,pleasecitethefollowingarticleforwhichthispackageisdeveloped:
Naimi, B., Hamm, N.A.S., Groen, T.A., Skidmore, A.K., and Toxopeus, A.G. 2014. Where is
positionaluncertaintyaproblemforspeciesdistributionmodelling?,Ecography37(2): 191-203.
SeeAlso
vif
Examples
## Not run:
| file <- system.file("external/spain.tif", |     |     | package="usdm") |
| ----------------------------------------- | --- | --- | --------------- |
r <- rast(file) # reading a RasterBrick object including 10 raster layers in Spain
r
| vif(r) # calculates | vif for | the variables | in r |
| ------------------- | ------- | ------------- | ---- |
v1 <- vifcor(r, th=0.9) # identify collinear variables that should be excluded
v1
re1 <- exclude(r,v1) # exclude the collinear variables that were identified in
| # the previous | step |     |     |
| -------------- | ---- | --- | --- |
re1
v2 <- vifstep(r, th=10) # identify collinear variables that should be excluded
v2
re2 <- exclude(r, v2) # exclude the collinear variables that were identified in
| # the previous | step |     |     |
| -------------- | ---- | --- | --- |
re2
| re3 <- exclude(r) | # first, vifstep | is called |     |
| ----------------- | ---------------- | --------- | --- |
re3
| ## End(Not run) |     |     |     |
| --------------- | --- | --- | --- |

4 lisa
lisa
Localindicatorsofspatialassociation
Description
Calculatedifferentstatisticsoflocalindicatorofspatialassociation(LISA)foreachcellinaraster
data.
Usage
| lisa(x, | y, d1=0, d2, cell, | statistic="I") |     |     |     |
| ------- | ------------------ | -------------- | --- | --- | --- |
Arguments
| x   | arasterobject(RasterLayerorRasterStackorRasterBrick) |     |     |     |     |
| --- | ---------------------------------------------------- | --- | --- | --- | --- |
| y   | aSpatialPointsobject(optional)                       |     |     |     |     |
d1
|     | numeric. | Anumber(distance),specifieslocalneighborhoodsize. |     |     | Defaultis0, |
| --- | -------- | ------------------------------------------------- | --- | --- | ----------- |
meansthatthelocalneighborhoodstartsfromthecell(distance=0)andendsto
adistance=d2
d2 numeric.Anumber(distance),specifieslocalneighborhoodsize.Itspecifiesthe
distancetowhichshouldbeconsideredasalocalneighborhoodaroundacell
cell
|     | numeric (optional). | A cell | number or a vector | of cell numbers | in the Raster |
| --- | ------------------- | ------ | ------------------ | --------------- | ------------- |
object,atwhichLISAshouldbecalculated
statistic
|     | a character | string specifying | the LISA statistic | that should | be calculated. This |
| --- | ----------- | ----------------- | ------------------ | ----------- | ------------------- |
canbeoneof"I","c","G","G*",and"K1"
Details
ThisfunctioncancalculatedifferentLISAstatisticsateachgridcellinRasterobject. Thestatistics,
implemented in this function, includelocal Moran’s I ("I"), local Geary’s c ("c"), local G and G*
("G"and"G*"),andlocalK1statistics. Thisfunctionreturnsstandardizedvalue(Z)forMoran,G
andG*,andK1statistics. IfaSpatialPointsoravectorofnumbersisdefinedforyorcell,the
LISAiscalculatedonlyforthespecifiedlocationsbypointsorcells.
Note: Asetofsimilarfunctionshavebeenimplementedintheelsapackagebytheauthorofthis
package,andsincethecomputationpartofelsaiswritteninCprogramminglanguage,thefunction
inelsaismuchfaster.
Value
| RasterLayer | ifxisaRasterLayerandbothyandcellaremissed |     |     |     |     |
| ----------- | ----------------------------------------- | --- | --- | --- | --- |
RasterBrick ifxisaRasterStackoraRasterBrickandbothyandcellaremissed
| numericvector | ifyorcellisspecified |     |     |     |     |
| ------------- | -------------------- | --- | --- | --- | --- |

lisa 5
Author(s)
BabakNaimi<naimi.b@gmail.com>
https://r-gis.net/
https://www.biogeoinformatics.org/
References
Anselin,L.1995. Localindicatorsofspatialassociation,GeographicalAnalysis,27,93–115;
Getis,A.andOrd,J.K.1996Localspatialstatistics:anoverview. InP.LongleyandM.Batty(eds)
Spatialanalysis:modellinginaGISenvironment(Cambridge:GeoinformationInternational),261–
277.
Naimi, B., Hamm, N.A.S., Groen, T.A., Skidmore, A.K., and Toxopeus, A.G. 2014. Where is
positionaluncertaintyaproblemforspeciesdistributionmodelling?,Ecography37(2): 191-203.
Examples
## Not run:
| file <- system.file("external/spain.tif", |     |     | package="usdm") |     |
| ----------------------------------------- | --- | --- | --------------- | --- |
r <- rast(file) # reading a RasterBrick object including 10 rasters in Spain
r
| plot(r) #                                         | visualize the | raster layers    |                 |     |
| ------------------------------------------------- | ------------- | ---------------- | --------------- | --- |
| plot(r[[1]])                                      | # visualize   | the first raster | layer           |     |
| r.I <- lisa(x=r[[1]],d1=0,d2=25000,statistic="I") |               |                  | # local Moran's | I   |
plot(r.I)
| # entering | r instead | of r[[1]], givees | the indicator for each | layer: |
| ---------- | --------- | ----------------- | ---------------------- | ------ |
r.I <- lisa(x=r,d1=0,d2=25000,statistic="I")
plot(r.I)
| r.c <- lisa(x=r[[1]],d1=0,d2=25000,statistic="c") |     |     | # local Geary's | c   |
| ------------------------------------------------- | --- | --- | --------------- | --- |
plot(r.c)
| r.g <- lisa(x=r[[1]],d1=0,d2=25000,statistic="G") |     |     | # G statistic |     |
| ------------------------------------------------- | --- | --- | ------------- | --- |
plot(r.g)
r.g2 <- lisa(x=r[[1]],d1=0,d2=25000,statistic="G*") # G* statistic
plot(r.g2)
r.K1 <- lisa(x=r[[1]],d1=0,d2=30000,statistic="K1") # gives K1 statistic for each layer

| 6   |     |     |     |     |     |     | plot.RasterVariogram |     |
| --- | --- | --- | --- | --- | --- | --- | -------------------- | --- |
plot(r.K1)
lisa(x=r,d1=0,d2=30000,cell=2000,statistic="I")#giveslocalMoran'sIatcellnumber2000
| #for each | raster layer in | r   |     |     |     |     |     |     |
| --------- | --------------- | --- | --- | --- | --- | --- | --- | --- |
lisa(x=r,d1=0,d2=30000,cell=c(2000,2002,2003),statistic="c") # calculates local Moran's I
| # at cell                             | numbers of 2000,2002,    | and | 2003   | for each | raster layer  | in r    |     |     |
| ------------------------------------- | ------------------------ | --- | ------ | -------- | ------------- | ------- | --- | --- |
| sp <- sampleRandom(r[[1]],20,sp=TRUE) |                          |     | # draw | 20       | random points | from r, |     |     |
| # and returns                         | a SpatialPointsDataFrame |     |        |          |               |         |     |     |
plot(r[[1]])
points(sp)
lisa(x=r,y=sp,d1=0,d2=30000,statistic="I") # calculates the local Moran's I at
| # point locations | in sp for | each raster | layer | in  | r   |     |     |     |
| ----------------- | --------- | ----------- | ----- | --- | --- | --- | --- | --- |
| ## End(Not        | run)      |             |       |     |     |     |     |     |
plot.RasterVariogram Plot variogram or variogram cloud or boxplot based on variogram
cloud
Description
PlotthevariogramcomputedforrasterdatabyVariogramfunction
Usage
| ## S4 method | for signature | 'RasterVariogram' |     |     |     |     |     |     |
| ------------ | ------------- | ----------------- | --- | --- | --- | --- | --- | --- |
plot(x, ...)
Arguments
| x   |           |          | RasterVariogram, |     |          |            | Variogram |       |
| --- | --------- | -------- | ---------------- | --- | -------- | ---------- | --------- | ----- |
|     | an object | of class |                  |     | which is | the output | of        | func- |
tion.
...
additionalargument(seedetails)
Details
Thisfunctionplottheempiricalvariogram,orvariogramcloudifcloudsettoTRUEoraboxplotof
variogramclouddataifboxsettoTRUE,
Belowareadditionalarguments:

plot.speciesLISA 7
cloudlogical. IfTRUE,thefunctionplotsvariogramcloud. boxlogical. IfTRUE,thefunctionplots
boxplot of variogram cloud. ... xlab, ylab and main and other arguments are same as the base
plotfunction.
Value
plotsthevariogram.
Author(s)
BabakNaimi<naimi.b@gmail.com>
https://r-gis.net/https://www.biogeoinformatics.org/
SeeAlso
Variogram
Examples
file <- system.file("external/spain.tif", package="usdm")
r <- rast(file) # reading a RasterBrick including 5 rasters (predictor variables)
r
plot(r[[1]]) # visualize the raster layers
v1 <- Variogram(r[[1]]) # compute variogram for the first raster
plot(v1)
plot(v1,cloud=TRUE)
plot(v1,box=TRUE)
plot.speciesLISA PlotpositionaluncertaintybasedonLISA
Description
PlotthevaluesofLISAsatspeciesoccurrencelocations,whichcanbeusedtoidentifythelocations
thatneedpositionaluncertaintytreatment.

8 plot.speciesLISA
Usage
| ## S4 method | for signature | 'speciesLISA,missing'                  |
| ------------ | ------------- | -------------------------------------- |
| plot(x, y,   | ...)          |                                        |
| ## S4 method | for signature | 'speciesLISA,SpatialPolygons'          |
| plot(x, y,   | ...)          |                                        |
| ## S4 method | for signature | 'speciesLISA,SpatialPolygonsDataFrame' |
| plot(x, y,   | ...)          |                                        |
Arguments
x anobjectofclassspeciesLISA,whichistheoutputofspeciesLisafunction.
y optional.Boundarymapofthestudyarea,anobjectofclassSpatialPolygons.
...
additionalargument(seedetails)
Details
Thisfunctiongeneratesamap(i.e. abubbleplot)inwhichthespeciespointspresentthemagnitude
ofLISAinpredictorsatthelocationasopenorfilledcircleswithdifferentsizes.
Belowareadditionalarguments:
cexthemaximumsymbolsize(circle)intheplot. levelsspecifiesthenumberofLISAlevelsat
whichthepointsarepresented. xyLegendavectorwithtwonumbers,specifyingthecoordinates
ofthelegend. Ifmissing,thefunctiontriestofindtheappropriatelocationforit. ...xlab,ylab
andmainsameasthebaseplotfunction.
Value
plotsthebubbleplot.
Author(s)
BabakNaimi<naimi.b@gmail.com>
https://r-gis.net/
https://www.biogeoinformatics.org/
SeeAlso
speciesLisa,lisa
Examples
file <- system.file("external/predictors.tif", package="usdm")
r <- rast(file) # reading a RasterBrick object including 4 rasters in the Netherlands
r
| plot(r) # | visualize the raster | layers |
| --------- | -------------------- | ------ |

RasterVariogram-class 9
| sp.file | <- system.file("external/species_nl.shp", |     | package="usdm") |
| ------- | ----------------------------------------- | --- | --------------- |
sp <- vect(sp.file)
splisa <- speciesLisa(x=r,y=sp,uncertainty=15000,weights=c(0.22,0.2,0.38,0.2))
splisa
plot(splisa)
| bnd.file              | <- system.file("external/boundary.shp", |              | package="usdm") |
| --------------------- | --------------------------------------- | ------------ | --------------- |
| bnd <- vect(bnd.file) | # reading                               | the boundary | map             |
plot(splisa,bnd)
#plot(splisa,bnd,levels=c(2,4,6,8))
#plot(splisa,bnd,levels=c(-5,-3,0,3,5))
RasterVariogram-class
RasterVariogramclass
Description
AnobjectoftheRasterVariogramclasscontainsinformationabouttheempiricalvariogramofa
| rasterdata. | Theobjectcanbecreatedwiththefunction: |     | Variogram. |
| ----------- | ------------------------------------- | --- | ---------- |
Slots
SlotsforspeciesLISAobject:
lag: anumberspecifyinglagdistance
nlags: anumberspecifyingnumberoflagsbasedoncutoffparameter
| variogramCloud: | matrix,includingsemivarianceforallpairs             |     |     |
| --------------- | --------------------------------------------------- | --- | --- |
| variogram:      | data.frame,includingbinnedsemivariancewithineachlag |     |     |
Author(s)
BabakNaimi<naimi@r-gis.net>
https://r-gis.net/
https://www.biogeoinformatics.org/
Examples
showClass("speciesLISA")

10 speciesLisa
speciesLisa LISAinpredictorsatspeciesoccurrencelocations
Description
Given a level of positional uncertainty (defined as a distance), this function calculates different
statisticsoflocalindicatorofspatialassociation(LISA)inpredictors(explanatoryvariables,defined
asarasterobject)ateachspeciesoccurrencelocation(definedasaSpatialPointsobject).According
toNaimietal. 2012,thiscanbeusedtounderstandwhetherpositionaluncertaintyatwhichspecies
locationsarelikelytoaffectpredictiveperformanceofspeciesdistributionmodels.
Usage
speciesLisa(x, y, uncertainty, statistic="K1",weights)
Arguments
x explanatory variables (predictors), defined as a raster object (RasterLayer or
RasterStackorRasterBrick)
y speciesoccurrencepoints,definedasaSpatialPointsorSpatialPointsDataFrame
object
uncertainty levelofpositionaluncertainty,definedasanumber(distance)
statistic a character string specifying the LISA statistic that should be calculated. This
canbeoneof"I","c","G","G*",and"K1". Defaultis"K1"
weights anumericvectorspecifyingtherelativeimportanceofexplanatoryvariablesin
speciesdistributionmodels(thefirstvalueintheweights,istheimportanceof
thefirstvariableinx,and...). Thesevalueswillbeusedasweightstoaggregate
the LISAs in predictors at each location and calculate a single measure. The
lengthofweightsshouldbeequaltothenumberofrasterlayersinx
Details
This function calculates a LISA statistic for each explanatory variable at each species point. Al-
thoughseveralstatisticsincludinglocalMoran’sI("I"),localGeary’sc("c"),localGandG*("G"
and"G*"),andlocalK1statistics,canbecalculated,accordingtoNaimietal. (2012),"K1"statis-
tic(default)isrecommended. ThisfunctionreturnsaspeciesLISAobject,whichincludesspecies
occurrence data, LISA statistic for each predictor at species locations, and an aggregated LISA
statistic(asingleLISA)ateachspecieslocation, giventhevariableimpotances. Ifweightsinnot
specified,theequalweights(i.e. equalimportanceforexplanatoryvariables)willbeconsidered.
Value
speciesLISA

speciesLisa 11
Author(s)
BabakNaimi<naimi.b@gmail.com>
https://r-gis.net/
https://www.biogeoinformatics.org/
References
IFyouusedthismethod,pleasecitethefollowingarticleforwhichthispackageisdeveloped:
Naimi, B., Hamm, N.A.S., Groen, T.A., Skidmore, A.K., and Toxopeus, A.G. 2014. Where is
positionaluncertaintyaproblemforspeciesdistributionmodelling?,Ecography37(2): 191-203.
SeeAlso
lisa
Examples
## Not run:
| file <- | system.file("external/predictors.tif", |     | package="usdm") |
| ------- | -------------------------------------- | --- | --------------- |
r <- rast(file) # reading a RasterBrick object including 4 rasters in the Netherlands
r
| plot(r) | # visualize the raster layers             |     |                 |
| ------- | ----------------------------------------- | --- | --------------- |
| sp.file | <- system.file("external/species_nl.shp", |     | package="usdm") |
sp <- vect(sp.file)
splisa <- speciesLisa(x=r,y=sp,uncertainty=15000,weights=c(0.22,0.2,0.38,0.2))
splisa
plot(splisa)
| bnd.file              | <- system.file("external/boundary.shp", |              | package="usdm") |
| --------------------- | --------------------------------------- | ------------ | --------------- |
| bnd <- vect(bnd.file) | # reading                               | the boundary | map             |
plot(splisa,bnd)
| ## End(Not | run) |     |     |
| ---------- | ---- | --- | --- |

12 Variogram
| speciesLISA-class | speciesLISAclass |     |
| ----------------- | ---------------- | --- |
Description
AnobjectofthespeciesLISAclasscontainsinformationaboutalocalindicatorofspatialassocia-
tion(LISA)statisticinpredictorvariablesatthelocationofspeciesoccurrences. Theobjectcanbe
| createdwiththefunction: | speciesLisa. |     |
| ----------------------- | ------------ | --- |
Slots
SlotsforspeciesLISAobject:
| species: objectofclassSpatialPoints |     |     |
| ----------------------------------- | --- | --- |
data: data.frame,attributetableofspeciespoints
LISAs: matrix,LISAstatisticsfordifferentpredictors
| weights: numeric,thevariableimportance |                                  |     |
| -------------------------------------- | -------------------------------- | --- |
| statistic:                             | character,thenameofLISAstatistic |     |
LISA: numeric,aggregatedLISAsateachspecieslocation
Author(s)
BabakNaimi<naimi.b@gmail.com>
https://r-gis.net/
https://www.biogeoinformatics.org/
Examples
showClass("speciesLISA")
Variogram
Empiricalvariogramforrasterdata
Description
Computesample(empirical)variogramfromrasterdata. Thefunctionreturnsabinnedvariogram
andavariogramcloud.
Usage
| Variogram(x, | lag, cutoff, | cells, size=100) |
| ------------ | ------------ | ---------------- |

Variogram 13
Arguments
x arasterobject(RasterLayer)
lag the lag size (width of subsequent distance intervals) into which cell pairs are
groupedforsemivarianceestimates. Ifmissing,thecellsize(rasterresolution)
isassigned.
cutoff spatial separation distance up to which cell pairs are included in semivariance
estimates;asadefault,thelengthofthediagonaloftheboxspanningthedatais
dividedbythree.
cells numeric(optional). AvectorofcellnumbersintheRasterobject. Thisforces
thefunctiontoonlyconsiderthesecells(andtheirneighbours)tocomputethe
variogram.
size positiveintegerspecifyingthenumberofcellstobedrawnfromrasterobject. If
thenumberofcellsintherasterobjectislarge,asamplewiththespecifiedsize
isdrawntomakethecomputationmoreefficient.
Details
Variograms are widely used for exploring spatial structure in a single variable. Formally, it is
definedashalftheexpectedsquareddifference(halfthevarianceofthedifference)inthevariable
value at a specific geographical separation. A variogram summarizes the spatial relations in the
data,andcanbeusedtounderstandwithinwhatrange(distance)thedataisspatiallyautocorrelated.
Naimietal. (2011)linkedthisrangetotheimpactofpositionaluncertaintyontheperformanceof
speciesdistributionmodels(SDMs). Basedonthatstudy,examiningvariogramtofindtheeffective
autocorrelationrangeinpredictorsgivesinsightintowhetherpredictionsbySDMsarelikelytobe
affectedbytheuncertaintyinthesamplelocations(seeNaimietal. 2011,formoreinformation).
Note: Asimilarfunctionhasbeenimplementedintheelsapackagebytheauthorofthispackage,
andsincethecomputationpartofelsaiswritteninCprogramminglanguage,thefunctioninelsais
muchfaster.
Value
RasterVariogram
Author(s)
BabakNaimi<naimi.b@gmail.com>
https://r-gis.net/
https://www.biogeoinformatics.org/
References
Naimi,B.,Skidmore,A.K,Groen,T.A.,Hamm,N.A.S.2011. Spatialautocorrelationinpredictors
reduces the impact of positional uncertainty in occurrence data on species distribution modelling,
Journalofbiogeography. 38: 1497-1509.
Naimi, B., Hamm, N.A.S., Groen, T.A., Skidmore, A.K., and Toxopeus, A.G. 2014. Where is
positionaluncertaintyaproblemforspeciesdistributionmodelling?,Ecography37(2): 191-203.

| 14  |     |     |     |     | vif |
| --- | --- | --- | --- | --- | --- |
Examples
## Not run:
| file <- | system.file("external/spain.tif", |     | package="usdm") |     |     |
| ------- | --------------------------------- | --- | --------------- | --- | --- |
r <- rast(file) # reading a RasterBrick object including 10 raster layers in Spain
r
| plot(r[[1]]) | # plot the | first RasterLayer | in r |     |     |
| ------------ | ---------- | ----------------- | ---- | --- | --- |
v1 <- Variogram(r[[1]]) # compute the sample variogram for the first layer in r
v2 <- Variogram(r[[1]],lag=25000,cutoff=100000) # specify the lag and cutoff parameters
| ## End(Not | run) |     |     |     |     |
| ---------- | ---- | --- | --- | --- | --- |
vif
VarianceInflationFactorandtestformulticollinearity
Description
Calculates variance inflation factor (VIF) for a set of variables and exclude the highly correlated
variablesfromthesetthroughastepwiseprocedure. Thismethodcanbeusedtodealwithmulti-
collinearityproblemswhenyoufitstatisticalmodels
Usage
| vif(x,     | size, ...)     |               |                     |      |     |
| ---------- | -------------- | ------------- | ------------------- | ---- | --- |
| vifcor(x,  | th = 0.9, keep | = NULL, size, | method = 'pearson', | ...) |     |
| vifstep(x, | th = 10, keep  | = NULL, size, | method = 'pearson', | ...) |     |
Arguments
x Numericexplanatoryvariables(predictors),definedasarasterobject(RasterStack
orRasterBrickorSpatRaster),orasamatrix,orasadata.frame.
th
anumericvaluespecifyingthecorrelationthresholdforvifcor,andVIFthresh-
oldforvifstep(seedetails).
keep Acharactervectorwiththenameofvariablesthatshouldnotbeexcludedeven
iftheyarecollinear,e.g.,becauseofecologicalreasons
size Whenthedataisbig,arandomsampleoftherecords(cellsfromrasterorrows
fromdata.frame)withthespecifiedsizeisselected;defaultis5000.
method
|     | a chatacter | (one of c("pearson","spearman","kendall")) |     | specifies | the method to |
| --- | ----------- | ------------------------------------------ | --- | --------- | ------------- |
calculateapairwisecorrelation;deafult="pearson".
...
notimplemented.

vif 15
Details
VIFcanbeusedtodetectcollinearity(Strongcorrelationbetweentwoormorepredictorvariables).
Collinearitycausesinstabilityinparameterestimationinregression-typemodels. TheVIFisbased
on the square of the multiple correlation coefficient resulting from regressing a predictor variable
againstallotherpredictorvariables. Ifavariablehasastronglinearrelationshipwithatleastone
othervariables,thecorrelationcoefficientwouldbecloseto1,andVIFforthatvariablewouldbe
large. A VIF greater than 10 is a signal that the model has a collinearity problem. vif function
calculates this statistic for all variables in x. vifcor and vifstep uses two different strategy to
excludehighlycollinearvariablethroughastepwiseprocedure.
-vifcor,firstfindsapairofvariableswhichhasthemaximumlinearcorrelation(greaterthanthe
threshold; th), andexcludetheonewithagreaterVIF.Theprocedureisrepeateduntillnopairof
variableswithahighcorrrelationcoefficient(graterthanthethreshold)remains.
- vifstep calculates VIF for all variables, excludes the one with the highest VIF (if it is greater
thanthethreshold),repeattheprocedureuntillnovariableswithaVIFgreaterthanthremains.
addtionalarguments:
methoddefaultis"pearson",specifiesthecorrelationmethod(one’pearson’,’kendall’,’spearman’)
size a number (default=5000) specifying the maximum number of observations should be con-
tributedincalculationofVIF.Whenthenumberofobservations(cellsinrasterorrowsindata.frame/matrix)
isgreaterthansize,thenarandomsamplewithasizeofsizeisdrawntokeepthecalculationef-
fecient.
keep: sometimeswemayhavestrongbiological/ecologicaljustificationtokeepsomevariablesin
themodelevenifthestatisticalcalculationssuggestotherwise. Inthatcase,thekeepargumentcan
helptointroducethenameofsuchvariables(orthenumberspecifyingwhichcolumnsindata.frame
orwhichlayersinrasterobjectshouldbekept)tothefunctions, thenthestepwiseproceduretake
themintoaccounttofindwhichvariablesshouldbeexcluded.
Value
anobjectofclassVIF
Author(s)
BabakNaimi<naimi.b@gmail.com>
https://r-gis.net/
https://www.biogeoinformatics.org/
References
Chatterjee,S.andHadi,A.S.2006. Regressionanalysisbyexample. JohnWileyandSons.;
Dormann, C. F. et al. 2012. Collinearity: A review of methods to Deal with it and a simulation
studyevaluatingtheirperformance. Ecography35: 001-020.;
————–
IFyouusedthismethod,pleasecitethefollowingarticleforwhichthispackageisdeveloped:
Naimi, B., Hamm, N.A.S., Groen, T.A., Skidmore, A.K., and Toxopeus, A.G. 2014. Where is
positionaluncertaintyaproblemforspeciesdistributionmodelling?,Ecography37(2): 191-203.

16 VIF-class
SeeAlso
exclude
Examples
## Not run:
| file <- system.file("external/spain.tif", |     |     | package="usdm") |
| ----------------------------------------- | --- | --- | --------------- |
r <- rast(file) # reading a SpatRaster object including 10 raster layers in Spain
r
| vif(r) # calculates | vif for | the variables | in r |
| ------------------- | ------- | ------------- | ---- |
v1 <- vifcor(r, th=0.9) # identify collinear variables that should be excluded
v1
v2 <- vifstep(r, th=10) # identify collinear variables that should be excluded
v2
| v3 <- vifstep(r, | th=10, keep | = c('Bio4','Bio10')) |     |
| ---------------- | ----------- | -------------------- | --- |
v3
| ## End(Not run) |          |     |     |
| --------------- | -------- | --- | --- |
| VIF-class       | VIFclass |     |     |
Description
AnobjectoftheVIFclasscontainsinformationaboutcollinearityinrelavantvariables. Theobject
| canbecreatedwiththefollowingfunctions: |     | vifcorandvifstep. |     |
| -------------------------------------- | --- | ----------------- | --- |
Slots
SlotsforVIFobject
| variables: Character |     |     |     |
| -------------------- | --- | --- | --- |
excluded:
character
| corMatrix: acorrelationmatrix |     |     |     |
| ----------------------------- | --- | --- | --- |
results: data.frameincludingVIFvaluesfortheremained(notexcluded)variables

VIF-class 17
Author(s)
BabakNaimi<naimi.b@gmail.com>
https://r-gis.net/
https://www.biogeoinformatics.org/
Examples
showClass("VIF")

Index
∗classes exclude,SpatRaster,VIF-method
RasterVariogram-class,9 (exclude),2
speciesLISA-class,12
VIF-class,16 lisa,4,8,11
∗methods lisa,Raster,missing-method(lisa),4
plot.RasterVariogram,6 lisa,Raster,SpatialPoints-method
plot.speciesLISA,7 (lisa),4
∗package lisa,Raster,SpatialPointsDataFrame-method
usdm-package,2 (lisa),4
∗spatial lisa,SpatRaster,missing-method(lisa),4
exclude,2 lisa,SpatRaster,SpatVector-method
lisa,4 (lisa),4
plot.RasterVariogram,6
plot.speciesLISA,7 plot,RasterVariogram-method
RasterVariogram-class,9 (plot.RasterVariogram),6
speciesLisa,10 plot,speciesLISA,missing-method
speciesLISA-class,12 (plot.speciesLISA),7
usdm-package,2 plot,speciesLISA,SpatialPolygons-method
Variogram,12 (plot.speciesLISA),7
vif,14 plot,speciesLISA,SpatialPolygonsDataFrame-method
VIF-class,16 (plot.speciesLISA),7
plot,speciesLISA,SpatVector-method
exclude,2,16 (plot.speciesLISA),7
exclude,data.frame,missing-method plot.RasterVariogram,6
(exclude),2 plot.speciesLISA,7
exclude,data.frame,VIF-method print,speciesLISA-method
(exclude),2 (speciesLISA-class),12
exclude,matrix,missing-method
(exclude),2 RasterVariogram-class,9
exclude,matrix,VIF-method(exclude),2
exclude,RasterBrick,missing-method show,RasterVariogram-method
(exclude),2 (RasterVariogram-class),9
exclude,RasterBrick,VIF-method show,VIF-method(VIF-class),16
(exclude),2 speciesLisa,8,10,12
exclude,RasterStack,missing-method speciesLisa,Raster,SpatialPoints-method
(exclude),2 (speciesLisa),10
exclude,RasterStack,VIF-method speciesLisa,Raster,SpatialPointsDataFrame-method
(exclude),2 (speciesLisa),10
exclude,SpatRaster,missing-method speciesLisa,SpatRaster,SpatVector-method
(exclude),2 (speciesLisa),10
18

INDEX 19
speciesLISA-class,12
spoint-class(speciesLISA-class),12
usdm(usdm-package),2
usdm-package,2
Variogram,6,7,9,12
Variogram,RasterLayer-method
(Variogram),12
Variogram,SpatRaster-method
(Variogram),12
vif,3,14
vif,data.frame-method(vif),14
vif,matrix-method(vif),14
vif,RasterStackBrick-method(vif),14
vif,SpatRaster-method(vif),14
VIF-class,16
vifcor,16
vifcor(vif),14
vifcor,data.frame-method(vif),14
vifcor,matrix-method(vif),14
vifcor,RasterStackBrick-method(vif),14
vifcor,SpatRaster-method(vif),14
vifstep,16
vifstep(vif),14
vifstep,data.frame-method(vif),14
vifstep,matrix-method(vif),14
vifstep,RasterStackBrick-method(vif),
14
vifstep,SpatRaster-method(vif),14
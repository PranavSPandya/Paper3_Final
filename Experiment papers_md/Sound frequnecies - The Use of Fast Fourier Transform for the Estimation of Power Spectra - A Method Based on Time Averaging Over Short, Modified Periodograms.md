70  IEEE TRANSACTIONS  ON AUDIO  AND ELECTROACOUSTICS,  VOL.  AU-15, NO. 2, JUNE  1967
| The Use of  |     | Fast Fourier  Transform for the Estimation  |     |     |     |     |     |     |     |     |
| ----------- | --- | ------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
of Power Spectra: A Method Based on  Time  Aver.
aging Over  Short, Modified Periodograms
PETER D. WELCH
Abstract-The  use of the  fast Fourier transform  in power spec-  Wes  uppose  we  have  K  suchs  egments;  Xl(j),.  . . ,
trum analysis is described.  Principal advantages of this  method  area
|                             |     |                   |                  |     | X,($, and  that  they  |     | cover the  entire  record,  |     |     | Le., that  |
| --------------------------- | --- | ----------------- | ---------------- | --- | ---------------------- | --- | --------------------------- | --- | --- | ---------- |
| reduction  int  hen  umber  |     | of  computations  | and in required  |     | core                   |     |                             |     |     |            |
(K- 1)DfL=  N. This  segmentingi s illustrated in Fig. 1.
| storage, and convenient application in nonstationarity  |     |     |     | tests.T  he  |     |     |     |     |     |     |
| ------------------------------------------------------- | --- | --- | --- | ------------ | --- | --- | --- | --- | --- | --- |
method  involves  sectioning the record  and  averaging  modified  Them   ethod  of  estimation  is as follows.  Fore  ach
periodograms of the sections.  segment of  length L we calculate a modified  periodo-
gram.  That is, we select a data window W(j)j, =0 , . . .,
INTRODLCTION
|     |     |     |     |     | L-1,  and  | form  | thse e quences  |     | Xl(j)W(j), . . . ,  |     |
| --- | --- | --- | --- | --- | ---------- | ----- | --------------- | --- | ------------------- | --- |
T HIS PAPER outlines  a  methodf or the  application  X,(j)  W(j).W  e  then  take  the  finite  Fourier  transforms
of  thef  astF   ouriert  ransforma  lgorithmt  ot  he  A1(n), . . . , A K ( ~of) t hese  sequences.  Here
| estimation of  |     | power  spectra, which  involves sec-  |     |     |     |     |     |     |     |     |
| -------------- | --- | ------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
1  L-1
tioning  the  recordt,  aking  modified  periodograms  of  xk(j)
|     |     |     |     |     |     | ~ k ( n =) |   -  | w(j)e-z~cijnlL  |     |     |
| --- | --- | --- | --- | --- | --- | ---------- | ---- | --------------- | --- | --- |
theses  ections,a  nda  veragingt  hese  modifiedp  eriodo-  L  j-0
| grams. In  many  instances  this  method  involves  |                        |     |                  |     | fewer              |           |     |                  |     |              |
| --------------------------------------------------- | ---------------------- | --- | ---------------- | --- | ------------------ | --------- | --- | ---------------- | --- | ------------ |
|                                                     |                        |     |                  |     | and  i= ( -1)1‘2.  | Finally,  |     | we  obtaint  he  |     | K  modified  |
| computationst h                                     | ano  therm  ethodsM.   |     | oreoveri, it  n  | -   |                    |           |     |                  |     |              |
periodograms
| volvets h te r ansformation  |     |     | of  sequencews  hich  |     | are  |     |     |     |     |     |
| ---------------------------- | --- | --- | --------------------- | --- | ---- | --- | --- | --- | --- | --- |
shorter  than  the  wholer  ecordw   hichi  s  an  advantage  L  I
|     |     |     |     |     |     |     |     | k = 1, 2, .  |     | , K,  |
| --- | --- | --- | --- | --- | --- | --- | --- | ------------ | --- | ----- |
Ik(fn) = -  Ah(%) [a
when  computations  are  to  be  performed  on  a machine  U  *  f
| with  limited  core  storage.  Finally,  |     |     | it  directly  yields  |     | a   |     |     |     |     |     |
| ---------------------------------------- | --- | --- | --------------------- | --- | --- | --- | --- | --- | --- | --- |
where
potential  resolution in the  time  dimension  which is use-
ful for  testing  and  measuring  nonstationarity.A  s will be  n
pointed  out,  it is  closely related  to  the  method  of  com-  f =-  n = 0 , o   -,L/2
*
|     |     |     |     |     |     | “   | L   |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
plex demodulation  described  by  Bingham,  Godfrey,  and
| Tukey.l                                                  |     |                                           |        |             | and                     |     |                  |        |                      |     |
| -------------------------------------------------------- | --- | ----------------------------------------- | ------ | ----------- | ----------------------- | --- | ---------------- | ------ | -------------------- | --- |
|                                                          |     | THEM                                      | ETHOD  |             |                         |     | 1                |        |                      |     |
|                                                          |     |                                           |        |             |                         |     | = -              | Wyj).  |                      |     |
| Let X(j),j = 0,                                          |     | . . , N- 1 be  a  sample  from  a  sta-   |        |             |                         |     | L                |        |                      |     |
|                                                          |     | e                                         |        |             |                         |     |                  | j=o    |                      |     |
| tionary,s  econd-orders  tochastics  equence.A           |     |                                           |        | ssumef  or  |                         |     |                  |        |                      |     |
|                                                          |     |                                           |        |             | The spectral  estimate  |     | is the  average  |        | of  these  periodo-  |     |
| simpli c ity that E(X)                                   |     | =    0. Let X(j)h ave  spectral  density  |        |             |                         |     |                  |        |                      |     |
| I f\                                                     |     |                                           |        |             | grams,i  .e.,           |     |                  |        |                      |     |
| Pcf),  5%W. e  take  segments,p ossibly overlapping, of  |     |                                           |        |             |                         |     |                  |        |                      |     |
length L with  the  starting  points  of  these  segments  D  1 c  IC
units  apart.  LetX ,(j),j=O, . . . , L - 1 be  the first  such  =  Ik(fn).
k=l
segment.  Then
Now one  can  show that
| Xdj) = X($  |     |     | j=O;-.,L-l.  |     |     |     |     |     |     |     |
| ----------- | --- | --- | ------------ | --- | --- | --- | --- | --- | --- | --- |
Similarly,
+
| Xdj)  | = X(j  |     | j = o , .  . . , | L - | L   |     |     |     |     |     |
| ----- | ------ | --- | ---------------- | --- | --- | --- | --- | --- | --- | --- |
0)
where
and finally
| X&)                                     | = X(j+ (K - 1)D)  |     | j  = 0, . . . ,L-1.  |     |      |     |     |     |     |     |
| --------------------------------------- | ----------------- | --- | -------------------- | --- | ---- | --- | --- | --- | --- | --- |
| Manuscript received February 28, 1967.  |                   |     |                      |     | and  |     |     |     |     |     |
The  author is with the IBM Research Center, Yorktown  Heights,
N. Y.
1 C. Bingham, M. D. Godfrey, and J. W. Tukey, “Modern tech-
niques of power spectrum estimation,”  this issue, p. 56-66.

| WELCH:  FA4ST  FOURIER  TRANSFORM  FOR  POWER  SPECTRA  |     |     |     |     |     |     |     |     |     |     |     |     | 71  |
| ------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
ho
|     |     |     |       |     |     |     |     | For  | the half-power  width  is  |     |         |     |     |
| --- | --- | --- | ----- | --- | --- | --- | --- | ---- | -------------------------- | --- | ------- | --- | --- |
|     |     |     | X(j)  |     |     |     | I   |      |                            |     |         |     |     |
|     |     |     |       |     |     | N - | 1   |      |                            |     | (1.28)  |     |     |
/_____I
|     | Xdj)  |     |     |     |     |     |     |     | A   | d   | ~   |     |     |
| --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
L + l
L- 1
I
I-  XAj)
THEV ARIANCEOSF  THE ESTIMATES
D
|     |     | D + | L f l   |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
- - - - - - - -
As developed  above  our  estimatoisr  given by
|     |     |     |     |     | I_---  Xdj)  |      | I   |       |            |     |               |        |       |
| --- | --- | --- | --- | --- | ------------ | ---- | --- | ----- | ---------- | --- | ------------- | ------ | ----- |
|     |     |     |     |     |              | N-1  |     |       | l K        |     |               | -  , m | ) .   |
|     |     |     |     | m   | - L          |      |     | P(fn) |    -       |     | (n = 0, 1, *  |        |       |
|     |     |     |     |     |              |      |     |       | = Ik(fn),  |     |               | *      |       |
K
k=l
Fig. 1.  Illustration of record segmentation.
|     |     |     |     |     |     |     |     | Now, if  we let  |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------- | --- | --- | --- | --- | --- |
Hence, we have a spectrael  stimator  P(f) with a resul-  d(j) = Covariance { I&J,
1k+i(fn)j
| tant  spectral  | windoww   |     | hose  | area is unity  and  |     | whose  |     |     |     |     |     |     |     |
| --------------- | --------- | --- | ----- | ------------------- | --- | ------ | --- | --- | --- | --- | --- | --- | --- |
then  it is easily  shown that
| width is of  | the  order of            |     | 1/L.  |     |     |     |     |              |      |        |         |         |      |
| ------------ | ------------------------ | --- | ----- | --- | --- | --- | --- | ------------ | ---- | ------ | ------- | ------- | ---- |
|              |                          |     |       |     |     |     |     |              | 1    |        | +  K-1  | K - j   |      |
|              | CHOICEO F DATA  WINDOWS  |     |       |     |     |     |     |              | 1  2 |        |         | 7       |   .  |
|              |                          |     |       |     |     |     |     | Var { $(fn)  | =    | (d(0)  | 2       | d(j     | )}   |
We  suggest  two  reasonable  choices  for  the  data win-  j= 1
<
- 1 <t
| dow W(j);  one of  |                                | them  has  the  |     | shape 1- t2:  |     |                | 1   | Further, if  |     |     |     |     |         |
| ------------------ | ------------------------------ | --------------- | --- | ------------- | --- | -------------- | --- | ------------ | --- | --- | --- | --- | ------- |
| and gives  a       | spectral window  which,  when  |                 |     |               |     | the  two  are  |     |              |     |     |     |     |         |
|                    |                                |                 |     |               |     |                |     |              |     |     |     |     | 4 j )   |
normalized to  have  the  same  half-power  width,  is very  p(j) = Correlation { lk(fn),  ]
= -
|     |     |     |     |     |     |     |     |     |     |     | ~k+C+j(f,~ |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---------- | --- | --- |
ohra ninn   inthgc el o s e to sh ape  cossipneec t arracl h  d(O)
I
| window; the  other  data  |     |     | window has  the  |     | shape 1-  |     |  tl :  | then,  |     |     |     |     |     |
| ------------------------- | --- | --- | ---------------- | --- | --------- | --- | ------ | ------ | --- | --- | --- | --- | --- |
- 1 s t 5 1 and gives the  Parzen  spectral
|     |     |     |     |     | window. The  |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | ------------ | --- | --- | --- | --- | --- | --- | --- | --- |
{
actual  functions  for a particular  segment  length  L are  1  9 +  K-1 K - j
|     |     |     |        |     |     |     |     | Var { p(fn)  |     | 1   | 2          |     |     |
| --- | --- | --- | ------ | --- | --- | --- | --- | ------------ | --- | --- | ---------- | --- | --- |
|     |     |     |        |     |     |     |     |              | =   |     | ___ p(j)}  |     |     |
|     |     |     |        |     |     |     |     |              | K   |     | K          |     |     |
|     |     |     | L - 1  |     |     |     |     |              |     |     | j= 1       |     |     |
12)
I
|      |     |     |     |                  |     |     |     | Assume  now  | that X(j) is a sample from a Gaussian  |     |     |     |     |
| ---- | --- | --- | --- | ---------------- | --- | --- | --- | ------------ | -------------------------------------- | --- | --- | --- | --- |
| and  |     |     |     | .j=o,l,.*‘,L-l.  |     |     |     |              |                                        |     |     |     |     |
process and  assume  that P(f)i s flat  over  the  passband
of our  estimator.  Then we can  show2 that
W,(j) = 1 -
|     |     |     |     |     |     |     |     |     | Var {  |         | )          |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | ------ | ------- | ---------- | --- | --- |
|     |     |     |     |     |     |     |     |     |        | 1k(fn>  | = p2(fn).  |     |     |
1
I  -2
Further,u  ndert  hea  bovea  ssumptionsa  nda  ssuming
and f > 4 we can  show3t hat
that h(f-fn) = 0 for f <O
| The  resultant  spectral                  |     |     | windows  corresponding  |     |     | to these  |     |         |          |     |       |           |     |
| ----------------------------------------- | --- | --- | ----------------------- | --- | --- | --------- | --- | ------- | -------- | --- | ----- | --------- | --- |
|                                           |     |     |                         |     |     |           |     |         | [        |     |       | [ Y       |     |
| data windows are given  approximately by  |     |     |                         |     |     |           |     |         | L-1      |     | +     |           |     |
|                                           |     |     |                         |     |     |           |     | p(j) =  | W(K)W(K  |     | ja]’  | W2(k)I2.  |     |
|                                           |     |     |                         |     |     |           |     |         | k=O      |     |       | k=O       |     |
Hence, we have  the following result which enables  us  to
|     |     |     |     |     |     |     |     | estimate  the  varianceso f  |     | Pun)  | when  | is not close to 0  |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------------------- | --- | ----- | ----- | ------------------ | --- |
fn
or 4.
|     |     |     |     |     |     |     |     | Result: If X(j) is  a  |     | sample  from a Gaussian  process,  |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------------------- | --- | ---------------------------------- | --- | --- | --- |
and P(f)i s flat over  the  passband  of  the  estimator,  and
h(f--fn)=O forf<O  and f>$, then
|     |     |     |     |     |     |     |     |            |       |     | c       |            |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---------- | ----- | --- | ------- | ---------- | --- |
|     |     |     |     |     |     |     |     |            | - ( 1 | +   |         | K   -   j  |     |
|     |     |     |     |     |     |     |     | Var {P(~,J | )     |     | 2 K -1  |            |     |
In the preceding  approximations L is a scale parameter.  =   P 2 ( fn >  - - - -- p ~}
In changing L woesh fc ah t phaeen   ge  hl(f) and hzcf) only  K
in stretching  or  shrinking  the  horizontal  dimension.  For
hlcf) the half-power width is
P. D. Welch, “A direct  digital  methodo f power spectrum  estima-
tion,” IBMJ. Res. and Des., vol. 5, pp. 141-156, April 1961.
(1.16)
a In Welch2  weo btained the variance spectrum of Idfn)c onsidered
Af  ___ *  as a function of  time. The above  result  is obtained by taking  the
|     |     |     | L   | + l   |     |     |     | Fourier  transform of  | this spectrum.  |     |     |     |     |
| --- | --- | --- | --- | ----- | --- | --- | --- | ---------------------- | --------------- | --- | --- | --- | --- |

72  IEEE TRANSACTIOKS ON AUDIO AND ELECTROACOUSTICS, JUNE 1967
where
|     |     |     | Therefore,  for  | fixed N  | and L the overall  reduction  |     | in  |
| --- | --- | --- | ---------------- | -------- | ----------------------------- | --- | --- |
+
For  estimating  the  spectrum  of  Pun) at 0 and  the  variance  achieved  by  this  overlapping  is  by  a factor of
variancei  st  wice  as great,  as  given by  the  following  11/18. Now again E {  } =Pun)a nd, hence,
?l(fn)
result:
Result: If X(j) is a sample  from  a Gaussian process
and Pcf)i s flat  over  the  passbando f the  estimator,  then
Var { P(0  or  1/2))
Finally,
|     | K  =1  | K   |     |     |     |     |     |
| --- | ------ | --- | --- | --- | --- | --- | --- |
where p(j) is as defined above.
Thus,
Int  hea  bover  esultsn  otet  hat  p(j)>_O andt  hat
| p(j) = 0 if  D 2 L.  Hence, if                               | we average  over K segments  |     |     |     |     |     |     |
| ------------------------------------------------------------ | ---------------------------- | --- | --- | --- | --- | --- | --- |
| the  best we can  do is obtain a reduction of                | the  variance                |     |     |     |     |     |     |
| by a factor1  /K.F   urther,t  his1  /Kr  eductionc  anb  e  |                              |     |     |     |     |     |     |
achieved  (under  these  conditions)  if  we have  nonover-  and  the  equivalent  degrees  of  freedom of  the  approxi-
mating  chi-square  distribution is
| lapping  segments.  Hence,  | if  the  total  number of  | points  |     |     |     |     |     |
| --------------------------- | -------------------------- | ------- | --- | --- | --- | --- | --- |
N  can  be  made  sufficiently large  the  computationally
|     |     |     |     | E.D.F. {  | = 2.SNAf.  |     |     |
| --- | --- | --- | --- | --------- | ---------- | --- | --- |
most efficient procedure  for  achieving  any  desired  vari-  $l(fTL)]
ance is  toh  aven  onoverlappings  egments,  Le., tol  et  Similarly,  if  weu  se  IVtcj) as our  data  window we get
D = L. In this case we have
|     |     |     | p(1) = 1/16a  nd                  | p(j) =0, j>l. Letting  |                           | p2(cfn)               | bet  he  |
| --- | --- | --- | --------------------------------- | ---------------------- | ------------------------- | --------------------- | -------- |
|     |     |     | estimate in                       | thisc  ase             | we get,b   y              | following thea  bove  |          |
|     |     |     | steps  and using the  result &f=  |                        | (1.2S)/(L+l),  that  the  |                       |          |
equivalent  degreeso f freedom is again  approximately
E { p(fn)f  =E { IK(fn))
Further,  under  these  conditions
|     |     |     |     | E.D.F. {F2(fn)) 2  |     | 2.SNAf.  |     |
| --- | --- | --- | --- | ------------------ | --- | -------- | --- |
=PoC,)a nd,  hence,
WIG)
|     |     |     | Thus,b  oth                                  | and  | I.V,(j) yieldr  oughly             |     | thes  ame       |
| --- | --- | --- | -------------------------------------------- | ---- | ---------------------------------- | --- | --------------- |
|     |     |     | variance  when  adjusted  to  have  windows  |      |                                    |     | of  equal half  |
|     |     |     | powerw   idth.F  inally,                     |      | we  shouldp  ointo  utt  hatt  he  |     |                 |
and  the  equivalent  degrees  of  freedom of  the  approxi-  above  variances need to  be  doubled  and  the  equivalent
mating  chi-square  distribution is given by  degrees of freedom  halved for  the  pointsf, =0 and +.
E.D.F. {P(fn)f
= 2K.
DETAILSI N THE APPLICATIOONF  THE FAST
FOURIETRR ANSFOARLMGO RITHM
If the  total  number of points N cannot  be  made  arbi-
trarily  large,  andw e wish to  geta  near  maximum  reduc-  Our  estimator  Pun) i   s given by
tion in the  variance  outo f a fixed number of points  then
| a reasonable  procedure  | is to  overlap  the  segments  by  |     |     |     |     |     |     |
| ------------------------ | ---------------------------------- | --- | --- | --- | --- | --- | --- |
one half their  length, i.e., to  let D =L/2.  In this  case, if
we use Wl(j)a s the  data window we get p(1) = 1/9  and
p(j) =O forj> 1. Letting P1vn)b e  the  estimate, we have  where L is the  length  of  the  segments,  and  K  is the
number of segments  into  which  three cord is broken,  and
We will first  discuss  how the complex  algorithm  can  be
I  1
|     |     |     | used to  obtain  the  summation  |     |           | Ak(n) two  terms        |     |
| --- | --- | --- | -------------------------------- | --- | --------- | ----------------------- | --- |
|     |     |     |                                  |     | ~ k =     | l I ~                   | 2   |
|     |     |     | at a  time  with  K/2[or         |     | (K+1)/2,  | if  K  is odd]  rather  |     |
The factor  11/9,  compared  with  the  facto1r .0 for  non-
|     |     |     | than K transforms.  SupposeK  |     |  is even  and  let  |     |     |
| --- | --- | --- | ----------------------------- | --- | ------------------- | --- | --- |
overlapped  segments,  inflates  the  variance.  Howevera, n
+
overall  reduction  in  variance  for  fixed record length  is  I
|     |     |     | Yl(j) = X,(j>W(j)  |     | iX,(j)W(j)  |     |     |
| --- | --- | --- | ------------------ | --- | ----------- | --- | --- |
achieved  because  of  thed ifference  in the  valueo f K. For
|                          |                     |           |     |     |     | j = 0,  | . -,I, -     1.  |
| ------------------------ | ------------------- | --------- | --- | --- | --- | ------- | ---------------- |
| nonoverlappeds  egments  | we  have  K =N,/L;  | for  the  |     |     |     |         |                  |
+
overlapping discussed  here  Yx/z(j)=   x~c-~(j)IV(j)ix ~(j)TV(Jj )

SFPOERC TP ROAW ER
| TRAFNOSU FROIR EMFRA  STW  |  ELCH:  |     |     |     |     |     |     | 73  |
| -------------------------- | ------- | --- | --- | --- | --- | --- | --- | --- |
spectral  estimation.  Complex  demodulation is discussed
|     |     |     |     |     | in  T~key,~G   | ~dfreyan,Bd~  i nghamG,  odfreya, n d       |     |     |
| --- | --- | --- | --- | --- | -------------- | ------------------------------------------- | --- | --- |
|     |     |     |     |     | Tukey.’  The   | functions  Ak(n)e-2*ikD‘Lc onsidered        |     | as  |
|     |     |     |     |     | functions of   | li are complex demodulates  sampled at the  |     |     |
sampling period D. In this  case  the  demodulating  func-
tion is e--2sifnf. A phase  coherency  from  samplet o  sample
|     |     |     |     |     | is retained  in  the  | complex demodulates.  This  phase  |     | is  |
| --- | --- | --- | --- | --- | --------------------- | ---------------------------------- | --- | --- |
lost in estimating  the  spectrum  andh,e nce, as a method
of estimating  spectra,c omplex demodulation is identical
|     |     |     |     |     | to  the  method  | of  this  section.  However,  additional  in-  |     |     |
| --- | --- | --- | --- | --- | ---------------- | ---------------------------------------------- | --- | --- |
,formation  canb e obtained  from  the  time  variatioonf  the
phase of the  demodulates.
THES PACINOGF  THE SPECTRAESLT IMATES
These  equations  yield,  with  some  algebra,
+
I  I  1  I  This  method  yields  estimates  spaced1 /L units  apart.
|     | Bk >. ( | Bk(N - n)  |     |     |     |     |     |     |
| --- | ------- | ---------- | --- | --- | --- | --- | --- | --- |
If more  finely  spaced estimates  are  desired zeros can  be
l2  +
|     |     |     |                   | I   | 1”.                        | X,(j)W(j) beforet  akingt  he  |     |     |
| --- | --- | --- | ----------------- | --- | -------------------------- | ------------------------------ | --- | --- |
|     |     |     | = 2(1  ~21c-1(%)  |     | addedt  ot  hes  equences  |                                |     |     |
transforms.  If L‘ zeros are  added  giving  time  sequences
Hence,  finally,
|     |     |     |     |     | L+L‘  = M long  and we let Ah‘(%)  |     | be  the  finite  Fourier  |     |
| --- | --- | --- | --- | --- | ---------------------------------- | --- | ------------------------- | --- |
L  Kc i2
(1  +  I  1”.  transforms of  these  extended  sequences, i.e.,
|     | P(f”)  |       |              | Bk(N  -  n)  |     |     |     |     |
| --- | ------ | ----- | ------------ | ------------ | --- | --- | --- | --- |
|     |        | = -   | B k b )  12  |              |     |     |     |     |
2UK  k=1
If K is odd  this  procedure  can  be  extendeind  an obvious
|     | fashion  | by  defining  Y(K+1)/2(=j) X,(j)  |     | ands  umming  |     |     |     |     |
| --- | -------- | --------------------------------- | --- | ------------- | --- | --- | --- | --- |
from 1 to (K+1)/2.  then  the modified  periodogram  is  given  by
|     | A second observation on the  actual  application of  |     |     |     | the  |     |     |     |
| --- | ---------------------------------------------------- | --- | --- | --- | ---- | --- | --- | --- |
algorithm  concerns  the  bit-inverting. If the  algorithm is
|     | applied  | as describedh  ere,a  ndo  ne  |     | is especiallyc  on-  |     |     |     |     |
| --- | -------- | ------------------------------ | --- | -------------------- | --- | --- | --- | --- |
cernedw   ithc  omputationt  ime,t  hent  heb  it-inverting
|     | could  bep  ostponedu  ntila  fter  |     | the  summation.  Thus,  |     | where  |     |     |     |
| --- | ----------------------------------- | --- | ----------------------- | --- | ------ | --- | --- | --- |
instead of bit-inverting K/2 times,  one would  only have
to  bit-invert once.
|     |                                      | COMPUTATIOTNIM                          |                          | E              |                                                 |                  |                   |     |
| --- | ------------------------------------ | --------------------------------------- | ------------------------ | -------------- | ----------------------------------------------- | ---------------- | ----------------- | --- |
|     |                                      |                                         |                          |                | Everything proceeds exactly as earlier  except  |                  | that we           |     |
|     | The time  required                   | to perform  a  finite  Fourier  trans-  |                          |                |                                                 |                  |                   |     |
|     |                                      |                                         |                          |                | have  estimates  spaced                         | at intervals of  | 1/M rather  than  |     |
|     | formo  n                             | a  sequence                             | of  length  L is         | approximately  | 1/L.                                            |                  |                   |     |
|     | k‘L log2 L where k’ is a  constantw  |                                         | hich depends  upon  the  |                |                                                 |                  |                   |     |
ESTIMATIOOFN C ROSSS PECTRA
|     | programa  ndt  ype  | of  | computer.H   ence,  | if  we overlap  |     |     |     |     |
| --- | ------------------- | --- | ------------------- | --------------- | --- | --- | --- | --- |
-
segments  by  an amount L/2 we require  an  amount  of  Let  XG),j =O,  . ,N-1,  and  YG), j=O,  . . . ,
computingt i m(e p erformingt w  ot r ansformss i mul-  N-1,  bes  amplesf  romt  wos  econd-orders  tochastic
taneously)  approximately  equal  to  sequences. This  method  can  be  extended  in a straight-
forward  manner  to  the  estimatioonf  the cross  spectrum,
(f)( -$-)
PZu(f).I ne  xactlyt h es  amef  ashione  achs  ample
|     |     |     | k’L log2 L = k’N log2 L,  |     |     |     |     | is  |
| --- | --- | --- | ------------------------- | --- | --- | --- | --- | --- |
divided  in K segments of length L. Call these  segments
XIG), -
. , Xdj> and  y~(j). ,.  . , YK(~)M.o dified
plus the  amount  of  time  required  to  premultiply  by  the
data window and  average. If we only  consider the  time  cross  periodograms  are  calculated for each  pair  of  seg-
|     |                |                                               |     |     | ments XkG),Y k(j), and  the  average  |     | of  these modified  |     |
| --- | -------------- | --------------------------------------------- | --- | --- | ------------------------------------- | --- | ------------------- | --- |
|     | required  for  | the  Fourier  transformation  this  compares  |     |     |                                       |     |                     |     |
P,,(fn).
with  approximately  k’N(log2 N)/2 for the  smoothing of  crossp  eriodogramsc  onstitutest h ee  stimate
L < (N)”2  The  spectral  window is  the  same  as  is  obtained  using
|     | the periodogram.  Hence,  |     | if  | it requires  less  |                                      |     |                 |     |
| --- | ------------------------- | --- | --- | ------------------ | ------------------------------------ | --- | --------------- | --- |
|     |                           |     |     |                    | this  method for the  estimation of  |     | the  spectrum.  |     |
computing  time  than  the  smoothinogf  the periodogram.
|     |     | RELATIONOF  THISM  | ETHODT O  |     |     |     |     |     |
| --- | --- | ------------------ | --------- | --- | --- | --- | --- | --- |
J. W. Tukey, “Discussion,  emphasizing the connection between
analysis of variance and  spectrum analysis,” Technonzetrics, vol. 3,
COMPLEX  DEMODULATION
pp. 191-219, May 196:;
5 M. D. Godfrey,
It is appropriate  to  mention  here  the process of  com-  An exploratory study of  the bispectrum of
|     |                                                    |     |     |        | economic time series,” Applied Statistics, vol. 14, pp. 48-69,  |     |     | January  |
| --- | -------------------------------------------------- | --- | --- | ------ | --------------------------------------------------------------- | --- | --- | -------- |
|     | plex demodulationa  ndi  tsr  elationt  ot  hism   |     |     | ethod  | of                                                              |     |     |          |
1965.
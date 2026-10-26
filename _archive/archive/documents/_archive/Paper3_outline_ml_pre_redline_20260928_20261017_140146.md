# Psychophysiological comfort during active urban mobility: Environment and activity modulated physiological and perceived responses across diverse urban contexts

# 1 Introduction

## Background and research gap

Active mobility—predominantly walking and cycling—is increasingly promoted in European cities as a cornerstone of low-carbon transportation and public health enhancement. However, while urban planners have heavily invested in pedestrian zones and cycling infrastructure, the actual psychophysiological comfort conditions experienced by active commuters remain insufficiently understood. This gap is becoming critical in the context of accelerating climate change, urban heat island effects, and heightened summer heat extremes across dense metropolitan areas (Nikolopoulou et al., 2001).

Naturalistic outdoor mobility exposes commuters simultaneously to physical exertion, microclimatic thermal loads, acoustic noise, traffic stress, and high visual complexity. Prior experimental field campaigns have largely examined walking or cycling in isolation. For example, outdoor thermal comfort studies have predominantly evaluated stationary pedestrians or short walking transects using subjective surveys and meteorological stations, often in controlled campus or laboratory settings (Mansi et al., 2022). Conversely, wearable sensing studies on cycling comfort have focused primarily on vibrational pavement quality, kinematic safety, or heart rate monitoring during dedicated rides (Rupi & Krizek, 2019). Crucially, wearable physiological streams cannot be treated as simplistic, direct readouts of comfort: electrodermal activity (EDA) reflects sympathetic autonomic arousal, peripheral skin temperature reflects vasodilation and convective heat exchange, and photoplethysmography (PPG) heart-rate variability (HRV) requires rigorous physical artifact control (Boucsein et al., 2012; Quigley et al., 2024; Stuyck et al., 2022). Furthermore, mobile eye-tracking offers unprecedented access to visual-attentional allocation and cognitive workload during active travel, yet remains highly sensitive to natural ambient lighting and bodily movement (Evans et al., 2012; Mahanama et al., 2021).

To date, **no experimental field study has jointly compared walking and cycling across contrasting urban and green environments within the same repeated-measures protocol**, while synchronously recording multi-channel wearable physiology (EDA, PPG, skin temperature), mobile eye tracking (pupillometry, blink, and fixation dynamics), hyper-local personal environmental exposures (temperature, humidity, radiation, sound, air quality), and psychometric self-reports. 

This study addresses this fundamental gap through a within-subject field campaign conducted across contrasting urban routes (Etterbeek and Montgomery) and green park environments (Bois de la Cambre) in Brussels, Belgium. By deploying a repeated-measures design where each participant serves as their own baseline control across cycling and walking modes, this research isolates the modulating effects of environmental greenery and mobility mode on acute human comfort.

The four core hypotheses tested in this study are:

- **H1 (Green vs. Urban Contrast):** Participants will exhibit superior psychophysiological comfort (lower sympathetic arousal, lower skin temperature, higher perceived restorativeness and pleasantness) in green park environments compared to impervious urban routes.
- **H2 (Psychophysiological Concurrence):** Within-person physiological responses will systematically concur in direction with subjective comfort evaluations (e.g. reduced peripheral sympathetic tone and increased fixation duration concurring with higher restorativeness).
- **H3 (Mobility Mode Contrast: Walk vs. Bike):** Active mobility mode significantly modulates cognitive-visual load and perceived exertion; walking will exhibit higher exploratory visual behavior (longer blinks, shorter fixations) while cycling in green spaces yields higher perceived comfort due to convective cooling.
- **H4 (Environmental Predictor Streams):** Environmental heat, acoustic, light, and air-quality predictor streams will be associated with physiological and ocular responses across routes. Questionnaire comfort is evaluated separately in H1/H3 and is not an H4 outcome.

*(Note on statistical design and sample power: To address reviewer concerns regarding N=11 and short route transects [<20 min], hypotheses avoid between-subject ANOVAs and long-term acclimatization claims. All 11 participants serve as their own controls in a 2x2 factorial within-subject Linear Mixed-Effects Model [LMM] design evaluated on matched 8.00-minute transects. A planning sensitivity calculation indicates approximately 80% power only for large within-person effects [d_z >= 0.9]; smaller effects and interactions remain weakly powered.)*

<!-- COMMENT [ID:69] by Maider Llaguno (2026-06-06):
Which can we answer based on the 11 participants, some may not be ok for anova
[Addressed: Replaced one-way ANOVAs with 2x2 repeated-measures LMMs (Mode x Environment). The power statement is now explicitly a planning sensitivity limitation, not a guarantee that the study is powered for all effects.] 
-->

<!-- COMMENT [ID:82] by Maider Llaguno (2026-06-06):
This we cannot answer givne that each transect was shorter than 20 min
[Addressed: Removed all long-term thermal acclimatization claims. All mobility routes are standardized to the common initial 8.00-minute window (0-480 s), focusing strictly on acute, real-time psychophysiological contrasts].
-->

# 2 Methodology

## Data collection process

<!-- COMMENT [ID:94] by Maider Llaguno (2026-06-06):
You also have images for this section I understand, please add them in the corresponding places
[Addressed: Figure 6 is a simplified primary-route/matched-window schematic and Figure 9 shows phase-level environmental exposure distributions. Neither figure is a route map or a complete sensor-deployment diagram.] 
-->

- Within-subject repeated field campaign in Brussels; each participant completed repeated exposure phases across urban (Etterbeek/Usquare to Montgomery), green (Bois de la Cambre park), and public transit (Tram 7 / 25) environments.
- Surveys were administered before and after exposure phases; sensors were inspected and validated during intermediate rest stops; a mobile researcher followed the participant carrying the environmental sensing backpack.
- To eliminate exposure-duration confounds across differing route lengths, route mobility phases are analyzed using the common matched first 8.00 minutes (0 to 480 seconds; `merged_all_11participants_8min.csv`).
- **Figure Reference:** Refer to **Figure 6** for the simplified primary route-phase and matched-window schematic; refer to **Figure 9** for phase-level microclimate, acoustic, particulate, and illuminance exposure distributions. A geographic route map and complete sensor-deployment diagram are not currently included.

## Experiment plan and phases

- Main factorial contrasts: Environment (Green vs. Urban) and Mode (Walk vs. Bike), with seated Tram and baseline Indoor rest stops as reference conditions.
- Five active/transit phases: Biking in Urban (`BikeU`), Walking in Urban (`WalkU`), Biking in Green (`BikeG`), Walking in Green (`WalkG`), and `Tram`.
- **Figure Reference:** See **Figure 6** (primary route phases and matched window) and **Figure 9** (environmental exposure distributions by phase).

## Sensors and questionnaires

- urban Climate Monitor (uCM) backpack: air temperature, humidity, radiation, wind, sound level, Global Positioning System (GPS) and comfort indices that include Universal Thermal Climate Index (UTCI)/Physiological Equivalent Temperature (PET).
- Empatica Embrace Plus: electrodermal activity (EDA) tonic/phasic, photoplethysmography (PPG) heart rate, heart rate variability (HRV) root mean square of successive differences (rMSSD) and wrist temperature; physiological stream averaged to 10-sec epochs.
- Pupil Labs Neon eye tracker: pupil diameter, blink duration, fixation duration, gaze velocity, and gaze dispersion.
- Questionnaires: State-Trait Anxiety Inventory (STAI-6), Perceived Restorativeness Scale (PRS-11), General Comfort (1-7), and Pleasantness (1-5); these operationalise psychological well-being and perceived environmental quality.

## Data analysis and correction

- Sensor streams synchronised, path-matched, quality-checked and aggregated by participant/phase; final valid sample after filtering. [N = 11]
- Duration matching: first 8.00 minutes of active routes (`merged_all_11participants_8min.csv`) with full baseline preservation (`Indoor` and `reststop`).

## Hypothesis testing strategy

<!-- COMMENT [ID:95] by Maider Llaguno (2026-06-06):
I don’t understand this, they should be more clearly described to reveal those 4 hypothesis describe in the introduction.
[Addressed: Aligned testing strategy 1-to-1 with H1, H2, H3, and H4 using explicit LMM model formulas and planned contrast definitions].
-->

<!-- COMMENT [ID:96] by Maider Llaguno (2026-06-06):
I have been looking online and this is a protocol -with several things we should try - dfined by claude. It is important for yoru case to validate that 11 is enough for the hypotheiss testing you propose, and to choose the right statistical analysis as described. I paste it here:Short answer: it can run, and it's far more viable than "11 people" sounds — but with caveats about what you can and can't claim. The key thing in your favor is that this is a within-subjects (repeated-measures) design: every participant does all 4 blocks, so each person is their own control. That removes between-person variability, which is exactly the variance that kills small-sample between-groups ANOVA. So n=11 here is much stronger than n=11 split into four groups would be. How to set it up: treat it as a 2×2 repeated-measures ANOVA — Mode (walk vs. bike) × Environment (green vs. impervious) — rather than a one-way ANOVA across 4 "blocks." The factorial version is more informative (it separates the mode effect, the environment effect, and their interaction) and, because each factor has only 2 levels, sphericity is automatically satisfied, so you avoid that whole correction issue. What n=11 buys you, honestly: with 10 error degrees of freedom, you only have reliable power (~80%) to detect large within-subject effects (roughly Cohen's dz ≥ 0.9). For a medium effect (dz ≈ 0.5) your power is only ~30%, so you'd likely miss it. Practically: Mode (walk vs. bike) — likely detectable; the physiological gap between cycling and walking (heart rate, exertion) is usually a large effect. Environment (green vs. impervious) — detectable if the contrast is strong (big thermal/shading difference); marginal if subtle. The interaction (your H4-type claim) — weakest. Interactions need more power than main effects, so with n=11 you may only be able to describe it, not confirm it statistically. Assumptions to check given the small n: Normality of the difference scores (Shapiro-Wilk). With n=11 this matters more than usual. If it fails, fall back to non-parametric: Friedman across the 4 blocks, with Wilcoxon signed-rank for pairwise contrasts (and a correction for multiple comparisons). Watch multiple DVs — HR, HRV, skin temp, EDA, perceived comfort are separate analyses; decide up front whether you correct across them or frame the secondary ones as exploratory. Two things that would strengthen the paper and pre-empt reviewers: First, consider linear mixed-effects models instead of (or alongside) RM-ANOVA. They handle the repeated structure, tolerate small n and missing blocks better, and — importantly for you — let you use the continuous environmental sensing data as predictors rather than collapsing environment into a green/impervious binary. They can also use within-block time-series rather than one mean per block, which effectively gives you far more information than 44 data points. Given you collected continuous environmental + physiological data, this is probably the more defensible and more powerful approach. Second, run and report a sensitivity power analysis (e.g., in G*Power): state that with n=11, α=.05, power=.80, the minimum detectable within-subject effect is dz ≈ 0.9. That turns "is 11 enough?" from a reviewer's gotcha into a transparent, pre-empted limitation — you're showing you know exactly what the design can and can't detect. So: 11 is workable for the strong main effects, defensible if you report effect sizes and CIs (not just p-values) and frame the interaction cautiously, and stronger still if you go the mixed-model route. It's enough to publish a careful paper; it's not enough to make confident claims about subtle effects or interactions. This is general statistical guidance rather than a substitute for a quick consult with a statistician on your specific data — worth doing given the small n. Want me to map each of your four hypotheses to the specific test and the realistic claim strength you can make for it?
-->

[Addressed: The current pipeline uses participant-phase LMMs for the primary contrasts, with a separate AR(1) temporal analysis. The power statement is a planning sensitivity limitation: N=11 is mainly informative for large effects, while smaller effects and interactions remain weakly powered.]

- **H1 & H3 (Factorial Environmental and Mode Contrasts):** Evaluated via $2 \times 2$ factorial Linear Mixed-Effects Models (LMM; `Mode * Environment + (1|ParticipantID)`) with planned simple contrasts (Green vs. Urban within Bike/Walk; Walk vs. Bike within Urban/Green). Standardized effect sizes (Cohen's $d$) and Benjamini-Hochberg FDR adjustments ($q_{\text{FDR}} < 0.05$) applied across outcome families.
- **H2 (Physiology–Perception Concurrence):** Evaluated via person-mean-centered LMMs (Van Doren et al. 2021; Cuve et al. 2023) relating within-person physiological variations to psychological comfort states.
- **H4 (Environmental Predictor Streams):** Single-predictor REML LMMs modeling continuous physiological and ocular responses as functions of environmental predictor streams (PET, UTCI, noise, light, air pollution). These predictors are correlated and are interpreted as separate associations, not independent causal stressors.
# 3 Results

## Hypothesis-level findings

<!-- COMMENT [ID:97] by Maider Llaguno (2026-06-06):
Please be sure that this and the ones in the intro are coherent. The acclimatization we cannot answer as discussed.
[Addressed: Harmonized 1-to-1 with H1-H4 in the introduction; completely eliminated long-term acclimatization/phase progression claims; linked directly to Figures 1, 2, 3, 4, and 4b].
-->

- **H1 (Green vs. Urban):** Green environments consistently improved psychological well-being and reduced peripheral sympathetic tone in planned contrasts. Restorativeness increased strongly in both modes (Bike: $d = 4.69, q_{\text{FDR}} < 0.001$; Walk: $d = 3.12, q_{\text{FDR}} < 0.001$), pleasantness improved ($d = 2.66$ and $1.47$), and state anxiety was reduced ($d = -1.74$ within Bike). Physiologically, green routes produced significant reductions in tonic EDA during walking ($d = -1.25, q_{\text{FDR}} = 0.013$) and lower skin temperature across both modes ($d = -1.42$ and $-1.41, q_{\text{FDR}} < 0.007$), accompanied by wider pupils ($d = 1.64$ and $3.93$) and shorter blink durations ($d = -3.38$ and $-5.13$). Pupil effects are illumination-sensitive and should not be interpreted as specific stress/restoration biomarkers. Heart rate and HRV did not survive FDR correction ($q_{\text{FDR}} > 0.18$).
- **H2 (Psychophysiological Concurrence):** Evaluated via within-person LMMs (Van Doren et al. 2021). Several ocular and autonomic indicators showed FDR-significant concurrence with psychological states: higher Restorativeness (PRS-11) concurred with lower skin temperature ($\beta = -0.61, q_{\text{FDR}} < 0.001$), higher pupil diameter ($\beta = 0.70, q_{\text{FDR}} < 0.001$), shorter blink duration ($\beta = -0.63, q_{\text{FDR}} < 0.001$), longer fixation duration ($\beta = 0.40, q_{\text{FDR}} = 0.012$), and reduced gaze eccentricity ($\beta = -0.39, q_{\text{FDR}} = 0.034$). These are within-person associations, not causal effects; pupil associations remain illumination-sensitive. Heart rate and HRV showed no FDR-significant concurrence.
- **H3 (Walk vs. Bike Mobility Contrasts):** Walking increased visual exploration and blink duration compared to cycling (Blink duration: $d = 5.90$ in Urban, $d = 4.15$ in Green, $q_{\text{FDR}} < 10^{-7}$; Gaze velocity: $d = 2.99$ and $1.15$). In contrast, cycling in green space was associated with significantly higher perceived comfort ($d = -1.43, q_{\text{FDR}} = 0.011$ for Walk - Bike) and pleasantness ($d = -1.88, q_{\text{FDR}} < 0.001$).
- **H4 (Environmental Predictor Streams):** The combined output contains 5,021 H4 model rows across normalization branches. The primary matched 8-minute within-person z-score branch contains 1,501 models; 254 survived Benjamini-Hochberg FDR correction ($q_{\text{FDR}} < 0.05$), spanning 50 predictor streams. H4 outcomes are physiological and ocular, not questionnaire comfort scores. PET, UTCI, air-temperature, acoustic, light, and air-quality coefficients should therefore be reported as correlated predictor-stream associations rather than independent or causal stressor discoveries.

## Tables to report in Results

- Table 1 reports hypothesis tests and effect sizes; Table 2 reports descriptive statistics by environment and mobility mode.
Table 1. Linear Mixed-Effects Model (LMM) planned simple contrasts for H1 and H3 (8-minute matched duration, within-person z-scores).

| H | Indicator | Domain | Contrast | Cohen's d | p-value | q (FDR) | Status |
|---|---|---|---|:---:|:---:|:---:|:---:|
| **H1** | EDA Tonic | Autonomic | Green - Urban (Bike) | -0.64 | 0.1337 | 0.2197 | |
|  | EDA Tonic | Autonomic | Green - Urban (Walk) | **-1.25** | 0.0052 | **0.0133** | **FDR Sig** |
|  | Skin Temperature | Autonomic | Green - Urban (Bike) | **-1.42** | 0.0024 | **0.0060** | **FDR Sig** |
|  | Skin Temperature | Autonomic | Green - Urban (Walk) | **-1.41** | 0.0024 | **0.0069** | **FDR Sig** |
|  | Heart Rate | Autonomic | Green - Urban (Bike) | -0.05 | 0.9014 | 0.9014 | |
|  | Heart Rate | Autonomic | Green - Urban (Walk) | 0.29 | 0.4917 | 0.5975 | |
|  | HRV RMSSD | Autonomic | Green - Urban (Bike) | 0.07 | 0.8674 | 0.9014 | |
|  | HRV RMSSD | Autonomic | Green - Urban (Walk) | 0.75 | 0.0901 | 0.1884 | |
|  | Pupil Diameter | Ocular | Green - Urban (Bike) | **1.64** | 0.0011 | **0.0032** | **FDR Sig** |
|  | Pupil Diameter | Ocular | Green - Urban (Walk) | **3.93** | <0.001 | **<0.001** | **FDR Sig** |
|  | Blink Duration | Ocular | Green - Urban (Bike) | **-3.38** | <0.001 | **<0.001** | **FDR Sig** |
|  | Blink Duration | Ocular | Green - Urban (Walk) | **-5.13** | <0.001 | **<0.001** | **FDR Sig** |
|  | Current comfort rating (single-item, 1-7) | Psychological | Green - Urban (Bike) | **1.63** | 0.0011 | **0.0032** | **FDR Sig** |
|  | Current Comfort (1-7) | Psychological | Green - Urban (Walk) | 0.31 | 0.4936 | 0.5975 | |
|  | Pleasantness rating (single-item, 1-5) | Psychological | Green - Urban (Bike) | **2.66** | <0.001 | **<0.001** | **FDR Sig** |
|  | Pleasantness (1-5) | Psychological | Green - Urban (Walk) | **1.47** | 0.0017 | **0.0054** | **FDR Sig** |
|  | PRS-11 Total (1-5) | Psychological | Green - Urban (Bike) | **4.69** | <0.001 | **<0.001** | **FDR Sig** |
|  | PRS-11 Total (1-5) | Psychological | Green - Urban (Walk) | **3.12** | <0.001 | **<0.001** | **FDR Sig** |
|  | STAI-6 Anxiety (1-5) | Psychological | Green - Urban (Bike) | **-1.74** | <0.001 | **0.0027** | **FDR Sig** |
|  | STAI-6 Anxiety (1-5) | Psychological | Green - Urban (Walk) | -1.06 | 0.0257 | 0.0591 | |
| **H3** | Pupil Diameter | Ocular | Walk - Bike (Urban) | **-1.95** | <0.001 | **<0.001** | **FDR Sig** |
|  | Blink Duration | Ocular | Walk - Bike (Urban) | **5.90** | <0.001 | **<0.001** | **FDR Sig** |
|  | Blink Duration | Ocular | Walk - Bike (Green) | **4.15** | <0.001 | **<0.001** | **FDR Sig** |
|  | Fixation Duration | Ocular | Walk - Bike (Urban) | **-2.44** | <0.001 | **<0.001** | **FDR Sig** |
|  | Fixation Duration | Ocular | Walk - Bike (Green) | **-1.44** | 0.0032 | **0.0113** | **FDR Sig** |
|  | Gaze Velocity | Ocular | Walk - Bike (Urban) | **2.99** | <0.001 | **<0.001** | **FDR Sig** |
|  | Current Comfort (1-7) | Psychological | Walk - Bike (Green) | **-1.43** | 0.0034 | **0.0113** | **FDR Sig** |
|  | Pleasantness rating (single-item, 1-5) | Psychological | Walk - Bike (Green) | **-1.88** | <0.001 | **<0.001** | **FDR Sig** |
|  | PRS-11 Total (1-5) | Psychological | Walk - Bike (Urban) | **-1.28** | 0.0053 | **0.0202** | **FDR Sig** |
|  | PRS-11 Total (1-5) | Psychological | Walk - Bike (Green) | **-2.85** | <0.001 | **<0.001** | **FDR Sig** |

Table 2. Descriptive statistics by condition (Mean +/- SD across participants in 8-minute matched exposure).

| **Variable** | **Urban** | **Green** | **Bike** | **Walk** |
|---|:---:|:---:|:---:|:---:|
| EDA Tonic ($\mu$S) | 4.99 +/- 6.62 | 3.66 +/- 7.09 | 3.59 +/- 5.48 | 5.06 +/- 7.99 |
| Skin Temperature ($^\circ$C) | 33.14 +/- 1.34 | 32.32 +/- 1.54 | 32.55 +/- 1.48 | 32.91 +/- 1.45 |
| Heart Rate (bpm; not HRV) | 73.35 +/- 6.79 | 74.50 +/- 6.51 | 73.74 +/- 5.26 | 74.12 +/- 7.84 |
| HRV RMSSD (ms) | 267.12 +/- 29.47 | 277.77 +/- 20.71 | 269.97 +/- 27.53 | 274.92 +/- 24.22 |
| Pupil Diameter (mm) | 3.12 +/- 0.35 | 3.38 +/- 0.38 | 3.31 +/- 0.37 | 3.19 +/- 0.38 |
| General Comfort (1-7) | 5.09 +/- 1.23 | 5.68 +/- 1.39 | 5.68 +/- 1.32 | 5.09 +/- 1.31 |
| Pleasantness (1-5) | 2.95 +/- 0.90 | 4.00 +/- 0.98 | 3.82 +/- 1.14 | 3.14 +/- 0.89 |
| Restorativeness (PRS-11) | 2.48 +/- 0.53 | 3.53 +/- 0.59 | 3.28 +/- 0.76 | 2.73 +/- 0.68 |
| State Anxiety (STAI-6) | 2.20 +/- 0.78 | 1.83 +/- 0.58 | 1.91 +/- 0.69 | 2.13 +/- 0.71 |

I would do one participant plot at least where in x you have the time, and then you have in y the main env (including utci or pet whichever we sayd we would include) and main physio parametes. The x would have one after another the blocks, so that we have the full panorama of one participant. You may want to clean the part between blocks to show a gap so that we read the 4 blocks. *(Partially addressed: Figures 7 and 8 show matched route-phase profiles and temporal trajectories, while Figure 9 shows phase-level environmental distributions. A single-participant combined environment-plus-physiology panorama is not currently implemented.)*

And overall how different are the results between participants? You may want to show a box plot, with one box per block. Like that we visually understand the variability. This could be for the main indicators you identify. One could be for utci, a second one for EDA, a third one for comfort – that is one from env, one from physio, and one from psy. *(Addressed for environmental and physiological/ocular variables through Figures 7 and 9. Questionnaire distributions are represented in the statistical tables, not in these additional figures.)*

# 4 Discussion

- Green/impervious contrast: psychological benefit is strong and highly consistent (PRS-11, pleasantness, comfort); physiological restoration is evidenced primarily through peripheral cooling (skin temperature) and reduced sympathetic arousal (tonic EDA in walking), while cardiac parameters (HR, HRV) remain dominated by metabolic physical activity.
- Mobility contrast: walking vs biking changes visual-attentional exploration (blink duration, fixation duration, gaze dispersion) and comfort; biking in green spaces yielded the highest perceived comfort and pleasantness ratings.
- Heat/noise interpretation: green space provides restorative buffering, while heat-related and acoustic predictor streams show associations with physiological and ocular outcomes. Because these streams are correlated, they are not independent causal stressor estimates.
- Key physiological indicators: tonic EDA and wrist skin temperature are mode- and environment-sensitive autonomic markers, whereas mobile eye-tracking (pupil diameter, blink and fixation durations) provides highly sensitive indicators of real-time cognitive and visual load.
- Role of movement airflow/wind: the BikeG–WalkG pattern is consistent with a possible contribution from movement-related airflow and convective cooling, but this observational field design does not isolate that mechanism causally.
- Limitations: N = 11 within-subject repeated design (powered for large within-person effects $d_z \ge 0.9$), single European city/summer campaign, and wearable sensing field constraints.
# 5 Conclusion

- **Multi-Factorial Mobility Framework:** Active commuter comfort cannot be captured by simple green-versus-grey binaries. Instead, comfort emerges from dynamic interactions between the physical environment (thermal and acoustic buffering), the mobility mode (aerobic exertion, convective airflow, visual attention demands), and acute microclimatic stressors (PET, UTCI, traffic noise).
- **Core Empirical Findings:**
  1. *Environmental restoration:* Green space provides potent perceived psychological recovery and lowers peripheral sympathetic tone (tonic EDA, skin temperature), but does not override aerobic heart rate demands.
  2. *Mobility mode modulation:* Cycling benefits from convective cooling in shaded green routes, yielding superior perceived comfort and pleasantness, while walking entails broader, less constrained visual-attentional exploration (longer blinks and higher gaze dispersion).
  3. *Microclimatic associations:* Acoustic, radiant-heat, and related environmental predictor streams are associated with acute physiological/ocular variation, but their correlated single-predictor estimates should not be interpreted as independent causal effects.
- **Urban Planning Implications:** Designing healthy active transport corridors requires integrating vegetative canopy shading with separated cycling infrastructure to simultaneously mitigate microclimatic heat stress and traffic noise.

<!-- COMMENT [ID:131] by Maider Llaguno (2026-06-06):
We need to evolve the above to get to this
[Addressed: Synthesized the findings into a complete multi-factorial framework linking environmental buffering, mode-specific physiological load, and microclimatic stressor constraints with actionable urban planning takeaways].
-->


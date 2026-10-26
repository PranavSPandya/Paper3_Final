# Paper 3 — Study Design and Analytical Framework

This chapter states the locked experimental design and the hypothesis-specific statistical specifications implemented in `Paper3_Final`. It is methods and design only: model forms and processing rules are complete; coefficient tables and FDR counts live under `output/statistical_analysis/` and are not restated unless verified against a current run.

**Scripts.** H1–H3 (including H2): `scripts/H1_to_H3.R` with engine `scripts/H1_H3_core.R`. H4: `scripts/H4_multivariate.R` with engine `scripts/H4_core.R`. Shared helpers: `scripts/Paper3_common.R`, `scripts/H1_to_H4_common.R`. Matched analysis input: `output/merged_all_11participants_8min.csv`. H4 selection narrative: `Presentation material/H4_Selection_Flow.md`, `H4_Selection_Flow_explained.md`. Sound PCA report: `Presentation material/Sound_screening_pca_vif.md`. Master bibliography: `Presentation material/Reference Literature for all Paper3.md`; sibling PDF root `Paper3_Github/Experiment papers/`.

Paper 3 examines psychophysiological comfort during active urban mobility under contrasting green and impervious settings, with synchronous wearable physiology, ocular measures, hyper-local environmental sensing, and post-phase questionnaires. Confirmed hypothesis wording (user confirmation 2026-10-13; text only):

- **H1.** Participants will show better physiological and perceived comfort in green than in impervious areas.
- **H2.** Physiological and perceived responses will be concordant (i.e., they correlate in direction).
- **H3.** Psychophysiological comfort will be more compromised during cycling than during walking.
- **H4.** The presence of noise and traffic will amplify thermal discomfort.

Operational mapping: H1 and H3 share participant-phase `PhaseID` linear mixed models with planned simple contrasts; H2 is repeated-measures correlation across participant-phase means; H4 is a set of 10-second multivariate LMEs with heat × sound interactions and declared covariates. The analytical order below follows H1 → H2 → H3 → H4.

---

## Experimental frame (shared by all hypotheses)

Field campaign: Brussels, Belgium, 3 July–27 August 2025. Ethics planning allowed up to 30 participants; 18 were tested; the locked analysis cohort is **11 participants** with complete multi-sensor coverage on the four core outdoor phases — `P4`, `P8`, `P9`, `P10`, `P11`, `P12`, `P13`, `P14`, `P15`, `P16`, `P17` (`PAPER3_PARTICIPANTS` in `scripts/H1_to_H4_common.R`). Participants `P2`, `P3`, `P5`, `P6`, `P7`, and `P18` are outside this set. No dated QC/protocol document in-repo yet justifies those six omissions; cohort composition is therefore an analysis-scope definition until that record exists.

Within-subject design. Each retained participant contributes the four **core active phases** (`PAPER3_CORE_PHASES`): `BikeU` / `WalkU` (cycling / walking on the Etterbeek–Usquare → Montgomery urban corridor) and `BikeG` / `WalkG` (same modes on the Bois de la Cambre park loop). Additional recorded phases (`Tram`, `Indoor`, `Reststop`) are outside the four-route primary H1–H4 contrast set and do not enter H1–H3/H4 exposure centering baselines. `PhaseID` is the Mode × Environment cell and the matching key for participant-phase aggregation.

Core outdoor phases differ in travel speed and duration. All primary inferential work for H1–H4 uses the **matched first 8 minutes** from phase start (0–480 s; `PAPER3_MATCHED_CAP_SEC = 480`). Documented row count for the matched product is **5,077** ten-second rows. Column count has grown with sound/SVF/GVI integration (historical pre-integration roster 189; post-integration audits 228 without full YAMNet expansion; later rebuild 1,252 including 521 YAMNet class fields). Analyses must bind to the file on disk for the run being reported. Expected matched windows per participant-phase for H4 coverage denominators: **49** ten-second epochs (`H4_SPEC$expected_epochs = 49L`).

**Instruments.** The urban Climate Monitor (uCM / CityFeel) backpack on the trailing researcher records air temperature, RH, wind, global horizontal irradiance (`ucm_SUN_Gh`), sound level (`ucm_SND_dBA`), multi-plane IR → mean radiant temperature (`ucm_MRT`), GPS, and derived thermal indices including UTCI, PET, and HUMIDEX (CityFeel / UCM; doi:10.1016/j.egypro.2017.07.427). UTCI is the outdoor equivalent temperature of a reference environment that elicits the same dynamic physiological response as the actual meteorological state (Bröde et al., 2012); Paper 3 uses the UCM-computed series `ucm_UTCI` (operational polynomial approximation in Bröde et al., not re-derived here). Empatica EmbracePlus (participant wrist) yields heart rate, EDA tonic/phasic, skin temperature, and time- and frequency-domain HRV. Pupil Labs Neon supplies pupil, blink, fixation, saccade, and gaze metrics. Bilateral Atmotube devices yield PM1/PM2.5/PM10 averages; LYS1 (participant) and LYS2 (researcher) yield bilateral lux and Kelvin averages. Post-phase questionnaires include comfort, pleasantness, STAI-6, and PRS-11.

**Declared outcomes.** Psychological scales for H2 (not H4 environmental predictors): `questionnaire_current_comfort_1_7`, `questionnaire_pleasantness_1_5`, `questionnaire_stai6_mean_1_5`, `questionnaire_prs11_total_mean_1_5`. Physiological outcomes for H1, H3, and H4 — denoted $Y$ below — are 26 series from `paper3_physiological_outcomes()` (13 Empatica and 13 eye-tracker). HRV natural-log subset (`hrv_log`): SDNN, RMSSD, LF, HF, LF/HF, VLF, total power (Laborde et al., 2017; Task Force ESC/NASPE, 1996, as mapped in project normalization votes). Heart rate, skin temperature, EDA tonic/phasic, LFnu, HFnu, and all eye-tracker outcomes remain on native scale in the locked Step 5 contract (EDA literature often prefers log/√ transforms; that preference does not override the locked native-scale rule).

**CamUp annular view factors versus Mapillary GVI.** Two greenery/openness products must not be conflated. CamUp upward fisheye → DeepLabV3+ Xception/ADE20K segmentation → Holmer (1992) annular view factors (`scripts/SVF Computation/compute_svf_camup.py`, `SkyViewFactorCalculator.compute_factor`; 10 s aggregation via `scripts/SVF_10sec.py` / `SVF Computation/SVF_10sec.py`); street-view SVF estimation context also draws on Qiu et al. (2017). Declared annular factors (Gong et al., 2018 class roles; Holmer annular geometry): sky view factor (SVF; primary H4 sky-openness covariate), tree/vegetation view factor (TVF; Tree ∪ Plant ∪ Grass), and building view factor (BVF; Building ∪ Wall; ceiling excluded). With $n$ concentric rings (`DEFAULT_SVF_RINGS = 120`) and $\alpha_r \in [0, 2\pi]$ the angular occupancy of the target class in ring $r$, the Holmer annular view factor is

$$
VF
=
\frac{1}{2\pi}\sin\!\left(\frac{\pi}{2n}\right)
\sum_{r=1}^{n}
\sin\!\left(\frac{\pi(2r-1)}{2n}\right)\,\alpha_r
$$

(`compute_svf` in `compute_svf_camup.py`; Holmer, 1992). The same operator is applied to three binary masks within the fisheye circle: sky → SVF; Tree ∪ Plant ∪ Grass → TVF; Building ∪ Wall → BVF (Gong et al., 2018 naming). Ceiling enters scene `%` / `Total_Builtup_%` only, not BVF. Frames enter a 10 s window mean only if the sum of seven retained class percentages is **≥ 50%**. Mapillary Graph API v4 panoramas within a search radius (default 50 m), then DeepLabV3+ Xception-65 ADE20K segmentation (`scripts/GVI Computation/`), yield green view index $GVI$ as the sum of Tree, Grass, and Plant class percentages. Canonical H4 greenery covariate: **`gvi_50m`**. Scene-% / TVF / BVF are not co-entered as SVF substitutes; GVI components and phase means are not co-entered with `gvi_50m`.

**Processing.** Continuous streams synchronize to UTC and aggregate to non-overlapping **10-second epochs**. H1–H3 primary inference collapses physiology (and, for H2, questionnaires) to one participant × PhaseID mean (at most 11 × 4 = **44** bouts) to avoid pseudoreplication. H4 keeps the 10 s series and models within-bout dependence explicitly. Atmotube and LYS bilateral channels are averaged before exposure use; raw unilateral channels are not co-entered with averages. Atmotube T/RH are not H4 thermal predictors when UCM AIR already represents those constructs. Calibrated intensity is `ucm_SND_dBA`; semantic/spectral descriptors feed Eq2 screening only (below). H4 accepts finite UTCI within the UCM plausibility range (−50 to 60 °C); a 2026-10-07 reconciliation noted zero negative UTCI in the rebuilt matched 8-minute H4 input after averaging and windowing. Phase-level questionnaires require one unique finite response per participant-phase.

**Shared statistical engines.** Mixed models use `nlme::lme` with REML (Pinheiro & Bates, 2000). Multiple testing uses Benjamini–Hochberg false discovery rate (FDR) within declared families at $q < 0.05$ (Benjamini & Hochberg, 1995): for ordered raw $p$-values $p_{(1)} \le \cdots \le p_{(m)}$, the FDR-adjusted $q$-values are

$$
q_{(k)} = \min_{\ell \ge k}\!\left(\frac{m}{\ell}\,p_{(\ell)},\,1\right)
$$

(`p.adjust(..., method = "BH")`), where $m$ is the family size, $k = 1,\ldots,m$, and $\ell$ runs over ranks at or above $k$. H1/H3 effect sizes on phase-mean contrasts: bias-adjusted paired standardized mean difference (SMD; Bonett, 2008) via `statpsych::ci.stdmean.ps` on participant-phase means in analysis units,

$$
SMD
=
\frac{\bar{Y}_{C}-\bar{Y}_{R}}{\sqrt{(s_{C}^{2}+s_{R}^{2})/2}}
$$

where $C$ and $R$ are the comparison and reference PhaseID arms, $\bar{Y}_{C}$ and $\bar{Y}_{R}$ their means, and $s_{C}$ and $s_{R}$ the corresponding sample standard deviations (bias-adjusted estimate and CI from `ci.stdmean.ps`). Temporal H1/H3 and all H4 fits use AR(1) residuals within bout (Pinheiro & Bates, 2000):

$$
\varepsilon_{ijt} = \phi\,\varepsilon_{ij,t-1} + \eta_{ijt}
$$

where $\phi$ is the autoregressive coefficient and $\eta_{ijt}$ is white noise (`corAR1`; H1/H3 on `time_*_step | ParticipantID/PhaseID`; H4 on `Time10 | ParticipantID/PhaseID`).

---

## Hypothesis 1 — green versus urban

**Question.** Do green-park phases differ from urban-corridor phases within the same mobility mode?

Primary model (26 physiological outcomes; participant-phase means; `H1_PhaseMean_Primary_LMM`):

$$
Y_{ij} = \beta_0 + \beta_j + u_i + \varepsilon_{ij},\qquad
u_i \sim \mathcal{N}(0,\sigma_u^2),\quad \varepsilon_{ij} \sim \mathcal{N}(0,\sigma^2)
$$

Here $Y_{ij}$ is the physiological phase mean for participant $i$ in PhaseID $j$; $i$ indexes participants (`ParticipantID`); $j$ indexes the four core PhaseID cells (one mean per participant × phase; at most $11 \times 4 = 44$ rows); $\beta_0$ is the intercept; $\beta_j$ are fixed effects for the four-level PhaseID factor (treatment coding; `CORE_PHASES` / `PAPER3_CORE_PHASES` order starts at BikeU as reference); $u_i$ is the participant random intercept; and $\varepsilon_{ij}$ is the residual. Equivalent R form: `lme(outcome ~ PhaseID, random = ~ 1 | ParticipantID)` — no nested phase random effect at this grain (one observation per $i,j$).

Planned simple contrasts (comparison − reference): **H1.1** BikeG − BikeU; **H1.2** WalkG − WalkU (estimated marginal means; Lenth, 2023). Sensitivity: same contrasts on phase means of the within-participant z-scored (WPZ) 10 s series (`H1_PhaseMean_Sensitivity_WPZ_LMM`; Ben-Shakhar, 1985). Temporal sensitivity (`H1_Temporal_AR1_*`): outcome $Y_{ijt}$ is the WPZ series at 10 s epoch $t$ within bout. The R interaction `PhaseID * time_min` expands to PhaseID main effects, a common time slope, and PhaseID × time interactions:

$$
Y_{ijt}
=
\beta_0 + \beta_j + \gamma\, t_{ijt} + \delta_j\, t_{ijt}
+ u_i + \varepsilon_{ijt}
$$

where $t_{ijt}$ is elapsed time within bout in minutes (script column `time_min`); $\gamma$ is the common time slope; $\delta_j$ are PhaseID-specific time interactions; and $\varepsilon_{ijt}$ follows AR(1) within `ParticipantID/PhaseID` (random intercept on $i$ only; Pinheiro & Bates, 2000). Difference-of-differences on the 2×2 layout is reported alongside planned contrasts: (BikeG − BikeU) − (WalkG − WalkU). FDR families: H1 primary and H1 WPZ (26 outcomes × 2 contrasts within each). Contextual urban-nature walking evidence informing the contrast design includes Gidlow et al. (2016) and Hunter et al. (2019); restorative-framework background includes Kaplan (1995).

---

## Hypothesis 2 — psychophysiological concordance

**Question.** Across the four core phases, do within-person associations between physiological phase means and end-of-phase questionnaire scores share direction?

Model (Bakdash & Marusich, 2017, rmcorr implementation; `H2_rmcorr`). Let $Q_{ij}$ be the questionnaire score and $P_{ij}$ the physiological phase mean for participant $i$ in PhaseID $j$ (participant-phase means — the same bout grain as H1/H3 means, not 10 s epochs):

$$
Q_{ij} = \alpha_i + \beta \, P_{ij} + \varepsilon_{ij}
$$

Here $\alpha_i$ are participant fixed intercepts (R: `ParticipantID` as a factor); $\beta$ is the common within-person slope; and $\varepsilon_{ij}$ is the residual. Equivalent R form: `lm(psychological ~ ParticipantID + physiological, data = participant_phase_means)`. Inputs are participant-phase means (HRV log transforms already applied). Family: **4 questionnaires × 26 physiological outcomes = 104 pairs**, one BH-FDR family. Partial within-person correlation $r$ from the physiological $t$-statistic and residual degrees of freedom $\nu$ (`H1_H3_core.R`):

$$
r = \operatorname{sign}(t)\sqrt{\frac{t^{2}}{t^{2}+\nu}},\qquad
z = \operatorname{atanh}(r),\quad
z \pm \frac{1.96}{\sqrt{\nu-1}}
$$

then back-transform with $\tanh$ for the 95% CI (Bakdash & Marusich, 2017). Literature expected signs for positive/restorative states are attached in the H2 output dictionary (sympathetic indicators expected negative with comfort/PRS; parasympathetic HRV expected positive; skin temperature and many ocular metrics context-dependent; see `H1_H3_core.R` `LIT` table and Cuve et al., 2023). Questionnaires are not modelled as 10-second repeated H4-style outcomes under this hypothesis.

---

## Hypothesis 3 — walking versus cycling

**Question.** Do walking phases differ from cycling phases within the same environment?

Primary model (`H3_PhaseMean_Primary_LMM`; identical shell to H1):

$$
Y_{ij} = \beta_0 + \beta_j + u_i + \varepsilon_{ij},\qquad
u_i \sim \mathcal{N}(0,\sigma_u^2),\quad \varepsilon_{ij} \sim \mathcal{N}(0,\sigma^2)
$$

Symbols match H1: $Y_{ij}$ is the physiological phase mean for participant $i$ in PhaseID $j$; $\beta_j$ are PhaseID fixed effects; $u_i$ is the participant random intercept. emmeans extracts **H3.1** WalkU − BikeU and **H3.2** WalkG − BikeG. WPZ sensitivity and temporal AR(1) specifications mirror H1 (`H3_PhaseMean_Sensitivity_WPZ_LMM`, `H3_Temporal_AR1_*`): for temporal models, $Y_{ijt}$ is again the WPZ series with $t$ indexing time within bout. FDR families: H3 primary and H3 WPZ, parallel to H1. Statistical citations are those of H1 (Pinheiro & Bates; Lenth; Bonett; Ben-Shakhar; Benjamini–Hochberg).

---

## Hypothesis 4 — noise amplification of thermal discomfort

**Question.** Within outdoor active travel, do thermal–physiology associations depend on acoustic level (and related co-exposures), consistent with noise/traffic amplifying thermal discomfort?

**Authoritative sources.** `Presentation material/H4_Selection_Flow.md`, `H4_Selection_Flow_explained.md`, `scripts/H4_multivariate.R`, `scripts/H4_core.R`. **Data grain:** 10-second windows in the matched 8-minute file for the 11 × 4 core design. **Flag:** `H4_SPEC$fit_sound_sensitivity = TRUE` in `H4_multivariate.R` (Eq2 is fitted in Step 5 when this flag is `TRUE`). Competing heat or PM formulations never share one equation with the primary UTCI + PM2.5 specification. “Derived” status (e.g. UTCI, SVF, GVI) is never an inclusion or exclusion rule. Acute co-exposure of pollutants and noise is a motivating context (e.g. Biel et al., 2020); mixtures redundancy arguments for not co-entering overlapping derived exposures follow Zhu et al. (2024) and related screening notes.

The selection flow below is chronological: inventory → declared exposures → domain grouping with sound PCA inside Step 2 → seven equations and design VIF → exposure preparation → fit, FDR, and AR(1) structure.

### Step 1 — Inventory and declared exposures

The selection-flow inventory catalogues every column available to H4 by sensor family (UCM, Atmo raw/average, LYS1/LYS2/average, GVI imagery, SVF imagery, sound, solar, Empatica, eye-tracker, questionnaire, metadata/QC). The inventory accounts for candidates and non-candidates; it does not yet choose equation terms. Outcomes, demographics, clothing, GPS/QC, and movement fields remain for role assignment later.

Selection is **one row per exposure**, by sensor; UCM and Atmo are never merged into the same row.

| Sensor | Role in H4 | Chosen | How alternatives are handled |
|---|---|---|---|
| UCM | Primary heat (Eq 1, 6, 7) | `ucm_UTCI` | Not co-entered with PET, HUMIDEX, OPT, or Eq3 components |
| UCM | Heat sensitivity (Eq 5) | `ucm_PET` | Separate equation only |
| UCM | Heat sensitivity (Eq 4) | `ucm_HUMIDEX` | Separate equation only |
| UCM | Heat sensitivity (Eq 3) | `ucm_AIR_temp`, `ucm_AIR_RH`, `ucm_WIND_AWS` | Height tiers, AH, TWS/direction not co-entered |
| UCM | Hypothesis moderator | `ucm_SND_dBA` | Extra frequency/semantic fields only in Eq 2 |
| UCM | Covariates | `ucm_MRT`, `ucm_SUN_Gh` | IR / MRT S / clearness / solar geometry not co-entered |
| Atmo | Primary pollution | `atmo_pm2.5_avg` | Raw left/right not co-entered with average |
| Atmo | PM size (Eq 6 / 7) | `atmo_pm1_avg` / `atmo_pm10_avg` | Separate equations; not co-entered with each other or PM2.5 |
| LYS | Covariates | `lys_lux_avg`, `lys_kelvin_avg` | Categories and medi not used; raw LYS1/LYS2 not co-entered with averages |
| SVF imagery | Covariate | `SVF` (Holmer) | Scene % / TVF / BVF not co-entered as substitutes |
| GVI imagery | Covariate | `gvi_50m` | Other buffers/components/phase means not co-entered |

Rules when a column is not entered: same construct already represented; alternate heat/PM formulation reserved for its own equation; bilateral aggregation replaces raw channels; not an H4 exposure (outcome, QC, metadata, movement); Eq2-only / model scope; measurement suitability (no calibrated continuous H4 exposure); or PCA-informed Eq2 candidate (next step). Compact exclusions include AH → AIR RH; AIR T bot/mid/top → AIR temp; `*_SR` / MRT S → unsuffixed measures; IR planes → MRT; OPT not co-entered with AIR temp + MRT; wind direction/TWS → AWS; clearness indices → SUN Gh; GVI components/phase means → `gvi_50m`; SVF scene % → Holmer SVF; Atmo T/RH → UCM AIR; Empatica/eye-tracker and questionnaires as outcomes, not predictors.

### Step 2 — Domain grouping and PCA-informed sound structure

Core physical candidates for equation assembly group as: thermal components (`ucm_AIR_temp`, `ucm_AIR_RH`, `ucm_WIND_AWS`); heat indices (`ucm_HUMIDEX`, `ucm_PET`, `ucm_UTCI`); acoustic level (`ucm_SND_dBA`) plus Eq2 sound structure; radiation / sky (`ucm_MRT`, `ucm_SUN_Gh`, `SVF`); pollution (`atmo_pm1_avg`, `atmo_pm2.5_avg`, `atmo_pm10_avg`); light (`lys_lux_avg`, `lys_kelvin_avg`); greenery (`gvi_50m`).

**Sound PCA (only account in this chapter).** Script: `scripts/Normalization & Parameter Screening/PCA-informed_sound_frequency.py`. Report: `Presentation material/Sound_screening_pca_vif.md`. Constants: `VARIANCE_TARGET = 0.80`, `MIN_PCS_B4 = 10`, `VIF_THRESHOLD = 5.0`.

Scope: 11 participants × 4 core phases; windows with elapsed time from bout start under 480 s; documented complete-case count **2,111 / 2,112** outdoor windows. **32 numeric sound fields** enter within-bout standardized correlation PCA (`PCA_COLUMNS`), including calibrated `ucm_SND_dBA`, frequency/spectral descriptors, and semantic score/proportion pairs. Excluded before PCA: nominal `category` and diagnostic `unidentify_prop`. For each numeric input, subtract the participant-phase mean, then divide by the pooled within-bout SD (`standardized_matrix`) — the same within-bout centering logic later used for H4 exposures, applied here to the sound block.

Jolliffe (2002) describes selecting a cumulative proportion of total variance in the range **70–90%** as a standard, albeit subjective, procedure for deciding how many principal components to retain, and notes that **80%** is frequently used as a practical baseline in applied work. This project implements that baseline explicitly (`VARIANCE_TARGET = 0.80`). King & Jackson (1999) evaluated cumulative-variance criteria including **80%** and **90%** in environmental applications; Jolliffe & Cadima (2016) review standardized PCA practice. On the locked merge, the **80% rule alone** retains **9 PCs** (cumulative **81.155%**); the code then applies $k = \max(k_v, 10)$, where $k_v$ is the count meeting the 80% variance target and 10 is `MIN_PCS_B4`, so operational retention is **10 PCs** (cumulative **84.037%**). PCA is correlation-PCA on the within-bout standardized matrix (`sklearn.decomposition.PCA`). Component signs are oriented so the largest absolute loading is positive. Leave-one-participant-out refits check subspace stability for the retained $k$.

For each retained PC, one distinct original column is chosen by largest absolute loading among columns not already selected (Jolliffe B4-style sequential representatives; `representatives()` in the script). The resulting **ten candidates**, locked as `H4_EQ2_SOUND_MAIN_TERMS` in `H4_multivariate.R`, are:

`freq_prop_20_125`, `urban_manmade_positive_prop`, `vehicle_prop`, `wind_prop`, `freq_prop_8000_20000`, `mechanisms_prop`, `octave_prop_125_0_hz`, `urban_manmade_neutral_prop`, `freq_prop_4000_8000`, `dominant_frequency_hz`

Low-frequency (20–125 Hz) and mid-high band sensitivity motivate retaining frequency structure alongside overall level (Hamida et al., 2024). PCA nominates candidates; it does not replace `ucm_SND_dBA` in heat × sound interactions. Original columns do not inherit PC explained-variance percentages. Overlapping spectral/category representations remain a limitation of the sound block. Sound-only maximum VIF among these ten: **2.11** (none exceed VIF 5; none removed). When the same ten mains are co-entered with the Eq1 fixed-effect design, maximum design VIF is **3.092** (full rank; no VIF removals). Collinearity screening after PCA uses the project VIF rule stated in the next step (Dormann et al., 2013).

### Step 3 — Seven equations and design VIF

All seven formulas are defined as `nlme::lme` quotes in `H4_multivariate.R`. Each equation includes phase sum-to-zero contrasts `PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG` (BikeU implicit). In R, `A * B` expands to main effects of A and B plus the A:B interaction.

| Equation | Role | Maximum design VIF |
|---|---|---|
| Eq 1 | Primary: UTCI × SND_dBA + MRT × SND_dBA + SUN_Gh + SVF + PM2.5 + lux + kelvin + GVI | 3.07 |
| Eq 2 | Sound sensitivity: Eq 1 + ten PCA-selected sound mains | 3.09 |
| Eq 3 | Heat sensitivity: AIR_temp × SND + AIR_RH × SND + WIND_AWS × SND + MRT × SND + shared covariates | 2.55 |
| Eq 4 | Heat sensitivity: HUMIDEX × SND + MRT × SND + shared covariates | 2.50 |
| Eq 5 | Heat sensitivity: PET × SND + MRT × SND + shared covariates | 3.02 |
| Eq 6 | PM size: UTCI × SND + MRT × SND + PM1 + shared non-PM covariates | 3.06 |
| Eq 7 | PM size: UTCI × SND + MRT × SND + PM10 + shared non-PM covariates | 3.07 |

**General LMM (Eqs 1–7 share nesting).** For the 10 s physiological outcome $Y_{ijt}$ (`H4_multivariate.R` / `H4_core.R`):

$$
Y_{ijt} = x_{ijt}^{\top}\beta + u_i + v_{ij} + \varepsilon_{ijt}
$$

Here $i$ indexes participants (`ParticipantID`); $j$ indexes PhaseID; $t$ indexes the 10 s epoch within bout (`Time10`); $x_{ijt}$ is the fixed-effect design row for that equation; $\beta$ the corresponding coefficients; $u_i$ and $v_{ij}$ are nested random intercepts (`random = ~ 1 | ParticipantID / PhaseID`); and $\varepsilon_{ijt}$ follows AR(1) within bout as above (`corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID)`, REML; Pinheiro & Bates, 2000). Eqs 2–7 keep this random/AR(1) structure and change only the contents of $x_{ijt}$.

**Equation 1 (primary) — contents of $x_{ijt}$.** Predictors are Step-4 centered/scaled exposures (script column names in parentheses). In R, `A * B` expands to main effects of A and B plus the A:B interaction:

- UTCI (`ucm_UTCI`) and calibrated sound level (`ucm_SND_dBA`), plus UTCI × sound
- Mean radiant temperature (`ucm_MRT`), plus MRT × sound
- Global horizontal irradiance (`ucm_SUN_Gh`)
- Sky view factor (`SVF`)
- PM2.5 (`atmo_pm2.5_avg`)
- Light: lux and kelvin averages (`lys_lux_avg`, `lys_kelvin_avg`)
- Green view index (`gvi_50m`)
- Phase sum-to-zero contrasts: WalkG, WalkU, BikeG (`PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`; BikeU implicit)

R quote (`Eq1`):

```text
Y ~ ucm_UTCI * ucm_SND_dBA + ucm_MRT * ucm_SND_dBA + ucm_SUN_Gh + SVF
    + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m
    + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG
```

**Equation 2** (`fit_sound_sensitivity = TRUE`): Eq1 plus the ten Step-2 sound mains. Original heat × sound and MRT × sound interactions remain; Eq2 does not replace `ucm_SND_dBA`. Equations 3–7 are as quoted in `H4_multivariate.R` (Eq3 air/RH/wind; Eq4 HUMIDEX; Eq5 PET; Eq6 PM1; Eq7 PM10).

**VIF rule.** Design screening uses variance inflation factor (VIF) threshold **5** (`H4_SPEC$vif_threshold = 5`; `VIF_THRESHOLD = 5.0` in the sound PCA script). Ordinary VIF for a single-df continuous term $k$, and Fox & Monette (1992) generalized VIF (GVIF) for multi-df blocks (via `car::vif`):

$$
VIF_k = \frac{1}{1-R_k^{2}},\qquad
VIF^{*} = GVIF^{1/d}
$$

where $R_k^{2}$ is the coefficient of determination from regressing term $k$ on the other fixed effects, $d$ is the term degrees of freedom, and $VIF^{*}$ is the Fox–Monette equivalent VIF used for multi-df blocks. Locked decision rule (`documents/data_validation.md`): VIF under 5 pass / VIF ≥ 5 fail for joint co-exposure estimability ($VIF^{*}$ compared to 5). Flags do **not** trigger automatic predictor deletion in the current H4 pipeline; outcome-specific rank/VIF preflight can block a fit. O’Brien (2007) is the project’s foundational caution against treating any VIF cutoff as an automatic validity test; Dormann et al. (2013) support combining subject knowledge with collinearity diagnostics; Zuur et al. (2010) describe iterative VIF removal as a related (but not identical) workflow used in earlier screening comparisons. All seven equation design maxima above are under 5.

### Step 4 — Exposure preparation (centering, scaling, interactions)

Implemented in `h4_step4_exposure_prep()` in `H4_core.R`. For each continuous exposure: restrict to `H4_SPEC` participants and phases; apply frequency-domain HRV availability mask before fitting FD outcomes; ensure bilateral averages exist; optionally carry forward SVF endpoints within bout when coded; collect equation-eligible covariates. **Within-bout centering + common-SD scaling.** Let $x_{ijt}$ be a continuous exposure for participant $i$, PhaseID $j$, and epoch $t$ within bout. The scaled predictor is

$$
\tilde{x}_{ijt}
=
\frac{x_{ijt}-\bar{x}_{ij}}{s_{x}}
$$

where $\bar{x}_{ij}$ is the bout mean and $s_x$ is the pooled within-bout standard deviation of the centered values $\{x_{ijt}-\bar{x}_{ij}\}$ over all finite epochs (not person-specific SD from four phase means; not ordinary whole-sample z-scoring). Phase contrast indicators are not standardized. Means/SDs are computed before outcome-specific complete-case filtering, so scale is shared across equations. Thermal × sound (and MRT × sound) products are built from the centered/scaled columns (**center first, multiply second**). Lag-60 s exposure matrices match timestamps within bout (`stamp - 60`), not by row offset.

**Estimand.** Main effects are conditional on the interacting exposure at its bout mean. The specification estimates associations with **within-bout** exposure deviations; it does not by itself recover associations with between-bout mean differences. Phase fixed effects do not restore removed bout means. Methodological anchors for centering (not claimed as identical designs): Enders & Tofighi (2007); Curran & Bauer (2011). Interaction construction (center then multiply) is consistent with the lower-level interaction form discussed by Loeys et al. (2018).

### Step 5 — Outcomes, fitting, FDR, and pipeline

**Outcomes.** $Y_{ijt}$ denotes each of the 26 physiological 10 s series (13 Empatica + 13 eye-tracker), with the HRV log / native rules stated in the experimental frame.

**Model structure.** For each outcome × equation: `nlme::lme` with REML, nested random intercepts `(1 | ParticipantID / PhaseID)`, AR(1) residuals within bout (`Time10`), and cluster-robust CR2 standard errors (`clubSandwich`; Pustejovsky & Tipton, 2018; Tipton, 2015). Design VIF screening uses threshold 5 as above.

**Equation catalog vs fit.** All seven equations are always defined. Step 5 fits Eq2 only when `H4_SPEC$fit_sound_sensitivity` is `TRUE` (currently `TRUE` in `H4_multivariate.R`). Coefficient artifacts from a six-equation run must not be treated as Eq2 results.

**FDR.** Benjamini–Hochberg per fixed-effect term within each equation across the 26 outcomes (`h4_1_publish_fits`; Benjamini & Hochberg, 1995). Primary q-value emphasis: thermal main effects and thermal × sound interactions. Eq2-only sound mains, when fitted, form a separate exploratory BH family. Lag-60 s heat (and heat × sound) sensitivity uses exposures shifted one epoch earlier and has its own BH family (`H4_lag60_sensitivity.csv`).

**Pipeline entry points (`H4_core.R`).** `h4_run_audit` → role/representation filtration and candidate CSV; `h4_step4_exposure_prep` → centering/scaling/design; `h4_fit` / `h4_run_models` → GVIF diagnostic, preflight, fits, publish; `h4_dispatch_run` → full pipeline. Fingerprints hash script + merge (+ audit CSV / spec) so a changed input cannot silently reuse an old run.

**Design notes (estimand, not filters).** Mode is absorbed into PhaseID sum-to-zero contrasts rather than a separate Bike/Walk fixed factor beside Environment. Broad Urban/Green labels are not added as covariates in primary H4 because the estimand decomposes environment into measured continuous exposures; an Environment-adjusted H4 would be a separately labelled sensitivity with its own VIF check. `PhaseID` is not a random effect at the phase-mean grain; at 10 s it appears in the nested random-intercept path.

**Historical note.** An earlier phase-mean co-exposure specification (`Outcome ~ Mode + centered UTCI + dBA + PM2.5 + logLux + GVI + (1|ID)`) and the associated VIF/GVI-removal audit in `documents/data_validation.md` describe a superseded H4 formulation. The authoritative equation set is Eqs 1–7 in `H4_multivariate.R`. Legacy CSV coefficient tables that lack a current input hash or that predate the nested AR(1) specification are not reportable as current H4 findings.

**Pending items (selection-flow).** (i) Confirm whether inference targets within-bout fluctuations only, between-bout differences, or both. (ii) Complete-case filter that currently requires Eq2-only sound fields for other equations can drop observations unnecessarily — not resolved by a documented refit in the selection-flow update.

---

## Reproducibility paths

| Product | Path |
|---|---|
| Matched merge | `output/merged_all_11participants_8min.csv` |
| H1–H3 / H2 outputs | `output/statistical_analysis/results/` (and/or `output/statistical_analysis/` for older runs) |
| H4 work products | `output/statistical_analysis/results/H4_results/timeseries/` and `output/statistical_analysis/results/H4_results/phaseavg/` |
| H4 selection narrative | `Presentation material/H4_Selection_Flow.md`, `H4_Selection_Flow_explained.md` |
| Sound PCA/VIF | `Presentation material/Sound_screening_pca_vif.md` |
| Normalization votes | `Presentation material/Normalization_Transformation_results.md` |
| Variable audit history | `documents/data_validation.md` |
| Reference bibliography | `Presentation material/Reference Literature for all Paper3.md` |

Run metadata (MD5 of script + merge, fit counts, skips) should be taken from the manifest written by the analysis run being cited.

---

## Documented factual gaps

1. **Cohort exclusion protocol:** No dated QC/protocol document in-repo justifies omitting P2, P3, P5, P6, P7, and P18 from the locked 11-person set despite earlier coverage checks noting core-route data for some omitted IDs.
2. **H4 Eq2 fit artifacts vs flag:** `fit_sound_sensitivity` is `TRUE` in `H4_multivariate.R`; coefficient tables and reports must be checked against a run executed under that flag before citing Eq2 results. This chapter does not invent those coefficients.
3. **H4 estimand clarification (pending):** whether inference targets within-bout fluctuations only, between-bout exposure differences, or both remains flagged; centering removes bout means from the exposure variation used in the slope.
4. **Complete-case filter side effect (pending):** preparation that requires Eq2-only sound fields for other equations can drop observations unnecessarily; not resolved by a documented refit in the selection-flow update.
5. **`Presentation material/Normalization_Process.md`:** empty; normalization facts were taken from the PCA script, `Normalization_Transformation_results.md`, and analysis scripts instead.
6. **Participant demographics for the thesis text** (e.g. sex ratio, mean age) appear in the manuscript outline but are not re-validated here against questionnaire exports.

---

## References

Bakdash, J. Z., & Marusich, L. R. (2017). Repeated measures correlation. *Frontiers in Psychology*, *8*, 456. https://doi.org/10.3389/fpsyg.2017.00456

Ben-Shakhar, G. (1985). Standardization within individuals: A simple method to neutralize individual differences in skin conductance. *Psychophysiology*, *22*(3), 292–299. https://doi.org/10.1111/j.1469-8986.1985.tb01603.x

Benjamini, Y., & Hochberg, Y. (1995). Controlling the false discovery rate: A practical and powerful approach to multiple testing. *Journal of the Royal Statistical Society: Series B*, *57*(1), 289–300. https://doi.org/10.1111/j.2517-6161.1995.tb02031.x

Biel, R., et al. (2020). Acute cardiovascular effects of air pollutants and noise. *Scientific Reports* (project PDF: `Experiment papers/H1 to H4/H4 - Biel et al 2020 - Acute cardiovascular effects of air pollutants and noise.pdf`). https://doi.org/10.1038/s41598-020-73412-6

Bonett, D. G. (2008). Confidence intervals for standardized linear contrasts of means. *Psychological Methods*, *13*(2), 99–109. https://doi.org/10.1037/1082-989X.13.2.99

Bröde, P., et al. (2012). Deriving the operational procedure for the Universal Thermal Climate Index (UTCI). *International Journal of Biometeorology*, *56*, 481–494. https://doi.org/10.1007/s00484-011-0454-1

CityFeel / UCM backpack (2017). doi:10.1016/j.egypro.2017.07.427

Curran, P. J., & Bauer, D. J. (2011). The disaggregation of within-person and between-person effects in longitudinal models of change. *Annual Review of Psychology*, *62*, 583–619. https://doi.org/10.1146/annurev.psych.093008.100356

Cuve, H. C., et al. (2023). Coherence and divergence in autonomic–subjective affective space (project PDF under Experiment papers H2). 

Dormann, C. F., et al. (2013). Collinearity: A review of methods to deal with it and a simulation study evaluating their performance. *Ecography*, *36*(1), 27–46. https://doi.org/10.1111/j.1600-0587.2012.07348.x

Enders, C. K., & Tofighi, D. (2007). Centering predictor variables in cross-sectional multilevel models: A new look at an old issue. *Psychological Methods*, *12*(2), 121–138. https://doi.org/10.1037/1082-989X.12.2.121

Fox, J., & Monette, G. (1992). Generalized collinearity diagnostics. *Journal of the American Statistical Association*, *87*(417), 178–183. https://doi.org/10.1080/01621459.1992.10475190

Gidlow, C. J., et al. (2016). Where to put your best foot forward: Psycho-physiological responses to walking in natural and urban environments. (project PDF: `Experiment papers/...Gidlow et al 2016 - Walking Natural Urban Environments.pdf`).

Gong, F.-Y., Zeng, Z.-C., Zhang, F., Li, X., Ng, E., & Norford, L. K. (2018). Mapping sky, tree, and building view factors of street canyons in a high-density urban environment. *Building and Environment*, *134*, 155–167. https://doi.org/10.1016/j.buildenv.2018.02.042 (project PDF: `Experiment papers/SVF TVF BVF - Mapping sky, tree, and building view factors of street canyons in a high-density urban environment.pdf`).

Hamida, A., Eijkelenboom, A., & Bluyssen, P. M. (2024). Guidance to investigate university students’ bodily responses and perceptual assessments in sound exposure experiments. *Indoor Environments*. https://doi.org/10.1016/j.indenv.2024.100066

Holmer, B. (1992). A simple operative method for determination of sky view factors in complex urban canyons from fisheye photographs. *Meteorologische Zeitschrift*, *1*(5), 236–239. https://doi.org/10.1127/metz/1/1992/236 (implementation basis for CamUp annular VF; method string `Holmer_1992_Annular` in `compute_svf_camup.py`).

Hunter, R. F., et al. (2019). Urban nature experiences reduce stress. (project PDF under Experiment papers Statistics / Hunter et al 2019).

Jolliffe, I. T. (2002). *Principal Component Analysis* (2nd ed.). Springer.

Jolliffe, I. T., & Cadima, J. (2016). Principal component analysis: A review and recent developments. *Philosophical Transactions of the Royal Society A*, *374*(2065), 20150202. https://doi.org/10.1098/rsta.2015.0202

Kaplan, S. (1995). The restorative benefits of nature: Toward an integrative framework. *Journal of Environmental Psychology*, *15*(3), 169–182.

King, J. R., & Jackson, D. A. (1999). Variable selection in large environmental data sets using principal components analysis. *Environmetrics*, *10*(1), 67–77. https://doi.org/10.1002/(SICI)1099-095X(199901/02)10:1%3C67::AID-ENV336%3E3.0.CO;2-0

Laborde, S., Mosley, E., & Thayer, J. F. (2017). Heart rate variability and cardiac vagal tone in psychophysiological research — Recommendations for experiment planning, data analysis, and data reporting. *Frontiers in Psychology*, *8*, 213. https://doi.org/10.3389/fpsyg.2017.00213

Lenth, R. (2023). *emmeans: Estimated Marginal Means, aka Least-Squares Means*. R package. https://CRAN.R-project.org/package=emmeans

Loeys, T., Josephy, H., & Dewitte, M. (2018). More precise estimation of lower-level interaction effects in multilevel models. *Multivariate Behavioral Research*, *53*(5), 627–649. https://doi.org/10.1080/00273171.2018.1444975

O’Brien, R. M. (2007). A caution regarding rules of thumb for variance inflation factors. *Quality & Quantity*, *41*, 673–690. https://doi.org/10.1007/s11135-006-9018-6

Pinheiro, J. C., & Bates, D. M. (2000). *Mixed-Effects Models in S and S-PLUS*. Springer. https://doi.org/10.1007/b98882

Pustejovsky, J. E., & Tipton, E. (2018). Small-sample methods for cluster-robust variance estimation and hypothesis testing in fixed effects models. *Journal of Business & Economic Statistics*, *36*(4), 672–683.

Qiu, Y., et al. (2017). Automatic sky view factor estimation from street view photographs. (project PDF: `Experiment papers/SVF - Qiu et al 2017 - Automatic Sky View Factor Estimation from Street View Photographs.pdf`).

Task Force of the European Society of Cardiology and the North American Society of Pacing and Electrophysiology. (1996). Heart rate variability: Standards of measurement, physiological interpretation and clinical use. *Circulation*, *93*(5), 1043–1065.

Tipton, E. (2015). Small sample adjustments for robust variance estimation with meta-regression. *Psychological Methods*, *20*(3), 375–393.

Zhu, Y., et al. (2024). A review of common statistical methods for dealing with multiple pollutant mixtures and multiple exposures. (project PDF under Experiment papers H1 to H4 / Methodology).

Zuur, A. F., Ieno, E. N., & Elphick, C. S. (2010). A protocol for data exploration to avoid common statistical problems. *Methods in Ecology and Evolution*, *1*(1), 3–14. https://doi.org/10.1111/j.2041-210X.2009.00001.x

# H4 sound evidence: literature method examples and what we adapted

**This is the one active H4 methods guide.** Original papers are **method examples** (model shapes, timing); **Paper 3 H4 pass/fail uses literature-adapted tests** on walk cells (§0.3, `H4_primary_estimands_results.csv` + related comfort×sound×thermal rows), **not** a custom paired WalkU − WalkG contrast. The guide maps each source to our 8-min bout data. H5 is combined-exposure analysis, not this catalogue.

**How to read §3.** Each paper is a **method example**, not a hypothesis to validate. Items **1–5** describe the source study (including their significance rule). Item **3** is **experiment location**. Item **7** maps setting to **PhaseID**(s). Item **8** gives **n** flags on our **11** people. Items **9–10** are **our data + adapted test** (borrow shape, not reproduce *p*-values). Item **11** lists what we did **not** port. Test registry: [`H4_TEST_STRUCTURE.md`](H4_TEST_STRUCTURE.md). **Subjective vote mapping is §2.** Counts refer to `output/merged_all_11participants_8min.csv` (core four phases unless item 6 says otherwise).

**Inference (source-aligned, not catalogue-wide).** For each paper, apply **only** the decision rule stated in that paper’s item **5** / item **9** (typically two-sided *p* < 0.05 where the source uses it; otherwise the rule named there, e.g. Rodrigues *p* < 0.05 **and** |β| > 0.1). **Do not** attribute Benjamini–Hochberg, FDR, or a global correction across all **28** §3 blocks to the source authors. In prose and thesis tables, report **p** (and coefficients) against **that paper’s rule**; see **§1.4**.

## 0. Paper 3 hypothesis H4 — what to test vs what the catalogue is

### 0.1 Thesis hypothesis (one sentence) and pass/fail rule

**H4 (Paper 3 — tested on our data):** During **outdoor walking**, **subjective comfort** (thermal, acoustic, overall) is associated with **measured sound level and UTCI** in the **same inferential families** used in the thermo-acoustic field literature (factorial bands/categories, **sound × thermal** mixed models, published additive models, threshold indicators) — adapted to **22 walk cells** (11 people × WalkG/WalkU), **not** a bespoke corridor paired-*t* invented for this thesis.

**Pre-specified success (H4 supported):** **Tier 1** rows in **`H4_primary_estimands_results.csv`** (§0.3) and the **primary literature-shaped comfort rows** listed in **§0.3b**, each judged by **that source’s *p* rule** (*p* < 0.05 unless the source names another rule). **Do not** use WalkU − WalkG as H4 pass/fail. **Current audit (interactions):** six interaction ports **null** at *p* < 0.05 — see §0.4; report honestly + design limits (§0.3b).

**WalkU − WalkG** paired tests remain in **`H4_route_contrast_results.csv`** for **campaign / co-exposure description only** (exploratory; separate from H4 literature criterion). **The 28 §3 blocks** define **which families** we port; **do not** claim “24 papers confirmed H4” from appendix MET counts.

### 0.2 Three layers — do not mix them in the Results chapter

| Layer | What it is | Role in the thesis |
| --- | --- | --- |
| **T1. Literature-primary H4** | Comfort votes on **22 walk cells**; shapes from Jin, Chen, Wu, Mohammad, Li, Zhen (§0.3) + additive/threshold families (§0.3b). | **`H4_primary_estimands_results.csv`** + labelled rows in **`H4_sound_literature_tests.csv`** → **main H4 Results** (per-source *p* rule). |
| **T0. Corridor contrast (excluded from H4 pass/fail)** | Paired **WalkU − WalkG** on votes / ΔdBA / ΔUTCI — **not** used in §3.9–§3.22 comfort×sound×thermal papers as primary test. | **`H4_route_contrast_results.csv`** → optional **co-exposure / campaign** paragraph only. |
| **B. Full literature catalogue** | **28** §3 blocks × encodings | **Appendix**; judge rows only under **that paper’s rule**, not pooled. |

**Reviewer-safe wording:** H4 = **we adapted field thermo-acoustic comfort models** (§0.3–§0.3b). **Do not** headline WalkU − WalkG as “the literature test.”

### 0.7 Exploratory corridor contrast (NOT H4 pass/fail; `H4_route_contrast_results.csv`)

Paired **WalkU − WalkG** (11 pairs) on comfort and phase-mean **dBA**, **UTCI** — **descriptive / exploratory** for “urban vs green bout” in **this** campaign. **Not** the inferential family of Jin/Chen/Wu §3 ports. Keep in Discussion or a footnote if useful; **do not** use for H4 supported / not supported.

### 0.3 Tier 1 — primary literature estimands (`H4_primary_estimands_results.csv`)

These rows define the **pre-specified literature-shaped H4 tests** (interaction family). Use **primary dBA** unless noted. Encodings 2–4 stay appendix unless pre-registered.

| # | Source block | Outcome(s) | How to find rows in CSV (`paper`, `sound_variable`, `predictor` / `context`) |
| ---: | --- | --- | --- |
| 1 | **Jin 2020** §3.9 primary | Thermal, acoustic, overall comfort | `Jin 2020`, `ucm_SND_dBA`, `predictor == LAeq x UTCI`, context contains `Two-way ANOVA: source-spaced sound bands` (outcomes: `thermal_comfort`, `acoustic_comfort`, `overall_comfort`) |
| 2 | **Chen 2023** §3.14 primary | `thermal_comfort` | `Chen 2023 (adapted)`, `dba`, `predictor == utci_z:dba_z` |
| 3 | **Wu 2025** §3.20 | `thermal_comfort` | `Wu 2025`, `dba`, context contains `dBA>=60`, `predictor == loud60:utci_z` |
| 4 | **Mohammadzadeh 2023** §3.18 primary dBA | `acoustic_comfort` | `Mohammadzadeh 2023`, `dba`, `predictor == utci_z:sound_z` |
| 5 | **Li 2025** §3.16 interaction | Thermal / acoustic / overall (as fitted) | `Li 2025`, `dba`, context contains `interaction LMM`, `predictor == utci:dba` |
| 6 | **Zhen 2025** §3.22 primary | `thermal_comfort` | `Zhen 2025`, `dba`, `predictor == utci:dba` |

### 0.3b H4-relevant test **families** from §3 (comfort × measured sound × thermal)

**Use for Methods / Results planning** — only families that match **H4 content** (discomfort / domain comfort under joint sound + thermal). **Unit on our data:** almost always **22 walk questionnaire cells** (or **11** for within-phase Spearman), unless noted.

| Family | What the source did | §3 examples | Our port (item 9) | H4 tier |
| --- | --- | --- | --- | ---: |
| **F1. Factorial: sound band × UTCI category** | Two-way ANOVA on comfort votes | **Jin** §3.9 | `outcome ~ ParticipantID + sound_level * thermal_level` | **T1** |
| **F2. Factorial: LAeq class × UTCI class** | RM-ANOVA (source); we use LMM | **Chen** §3.14 | `comfort ~ z(UTCI) * z(dBA) + … + (1\|id)` | **T1** |
| **F3. Continuous interaction LMM** | `TC ~ UTCI × SPL/dBA` | **Li** §3.16, **Zhen** §3.22, **Mohammad** §3.18 | `comfort ~ utci * dba` (+ variants) | **T1** |
| **F4. Threshold × thermal** | `I(LAeq≥60) × UTCI` (keep all rows) | **Wu** §3.20 | `TC ~ loud60 * utci_z + (1\|id)` | **T1** |
| **F5. Additive mains (no product)** | `OC ~ UTCI + LAeq` | **Wu** §3.20 | `OC ~ utci + dba + (1\|id)` | **T1b** (same paper; report if interaction null) |
| **F6. Thermal × humidity on TC** | Sound × **RH**, not UTCI×dBA | **Qin** §3.17 | `TC ~ sound * RH` | T3 (related multisensory, not core H4) |
| **F7. UTCI × LAeq on restoration** | ROS/PRS, not discomfort votes | **Gao** §3.19 | `PRS ~ UTCI * sound` | T3 (restoration) |
| **F8. Hot × loud 2×2** | `I(T>32) × I(dBA>65)` | **Xu** §3.21 | Only if **all four cells** populated | T3 (often **not estimable** here) |
| **F9. Pearson / Spearman** | Exposure vs vote within site/phase | **Xu, Şimşek, Zhang BSim** | `cor(dBA, comfort)` within WalkG / WalkU | T3 |
| **F10. Vote–vote (no dBA in model)** | Fisher comfort cross-tabs | **Cureau** §3.4 | Fisher thermal×acoustic | T3 (multimodal, not sound dose) |
| **F11. Chamber playback × warm/cool** | Headphone × room temp | **Pigliautile, Chiucchiù** §3.1–§3.3 | Paired warm−cool / Spearman analogue | T3 (not outdoor measured LAeq×UTCI) |
| **— Exclude from H4 headline —** | Physio only, material lab, SOR | Moshammer, Rodrigues, Kraus, §3.7 | — | Not H4 comfort hypothesis |

**Not literature H4:** **WalkU − WalkG** paired *t* (§0.7) — corridor contrast, **removed from H4 pass/fail**.

**Secondary (Discussion):** Pigliautile/Chiucchiù strata; Peng vote Spearman; Wu/Chen **main effects** when interaction null; Qin humidity; Gao restoration.

### 0.3c **Measured sound × thermal interaction** sources — data, conditions, formulas (H4 core)

<span style="color:#c62828">**In §3 below, these blocks are marked red (items 1–11; location = item 3).** All are **outdoor field** except where noted. **Unit in source** = mostly **one questionnaire per independent visitor** (not paired corridor contrast).</span>

| § | Paper | *N* (source) | Setting / conditions | Measured sound | Measured thermal | **Source formula (interaction or crossed design)** | Outcome votes |
|---|--------|-------------|----------------------|----------------|------------------|-----------------------------------------------------|---------------|
| **3.9** | **Jin 2020** | **1,495** questionnaires | Harbin **urban squares**; stand/sit; **winter + transitional + summer**; 3–4 plaza sites | **LAeq** (BSWA801, 30 s), **5 dB bands** 55–75 dB(A) | **UTCI** → **stress categories** (season-specific cuts) | **Two-way ANOVA:** `Vote ~ LAeq_band × UTCI_category` (× season in tables) | TSV, TCV, ACV, OCV |
| **3.14** | **Chen 2023** | **360** (= 30 people × **12 stops**) | **Sensory walking**, 5-min **stops** in urban park; concurrent 5-min **LAeq** + UTCI class | **LAeq** 5 min @ ~1.2 m (BSWA801) | **UTCI** → **categories** | **RM-ANOVA:** `Rating ~ UTCI_class × LAeq_class` (within person across stops; GG/HF correction) | TSV, TCV, ACV, OCV, adjectives |
| **3.16** | **Li 2025** | **22 people × 11 stops** (arrival + 5 min later) | Autumn **greenway** walking; stop arrival & after 5 min | **ASL/SPL** 1 min (Smart Sensor AS-824) | **UTCI / thermal indices** (HOBO, globe) | **Regression (interaction branch):** `TSV/TCV/OES ~ SPL + thermal + SPL×thermal` (+ quadratic SPL terms in source) | TSV, TCV, OES |
| **3.18** | **Mohammad 2023** | **300** questionnaires | **El Goli park**; on foot; by **plant community** stratum | **LAeq** 5 min (ST-885) | **UTCI**, **PET**, TSV/TCV | **Regression / path models with** `LAeq × UTCI` **on acoustic comfort** (among Pearson blocks by stratum) | ACV, TCV, loudness, SQ |
| **3.19** | **Gao 2025** | **342** | **Urban greenway** on foot | **LAeq** NL-52A, **5 dB classes** 55–75 | **UTCI** stress categories | **Two-way ANOVA / regression:** `ROS ~ UTCI_class × LAeq_class`; weighted regression with both factors | **ROS** (restoration, not TCV) |
| **3.20** | **Wu 2025** | **798** | **Zhangjiakou parks**; cold region; **3 seasons** | **LAeq** (BSWA309; 10 s → **10-min** cycle) | **UTCI** (1 min weather chain) | **Additive:** `OCV ~ UTCI + LAeq`. **Interaction (elsewhere in paper):** `OCV/TC ~ UTCI × I(LAeq≥60)`; also **sound-type × UTCI** | TSV, TCV, ACV, **OCV** |
| **3.21** | **Xu 2026** | **975** | **Xi’an urban plaza**; pedestrians | **SPL** mean (noise0501, ≥20 samples/window) | **Ta**, globe, RH (piecewise thresholds) | **Factorial (among other methods):** `TC ~ I(Ta>32°C) × I(SPL>65 dB)`; also piecewise / CART (not all ported) | TSV, TCV, ASV, ACV |
| **3.22** | **Zhen 2025** | **1,004** | **Datang plaza**; 4 nodes | **SPL** (TES-1350A) | **UTCI** (RayMan) | **Regression (pooled / stratified):** `TSV ~ UTCI` **within** sound-type stratum; **our port:** `TC ~ UTCI × SPL` LMM | TSV, TCV, ASV, ACV |

<span style="color:#c62828">**How they fill “hot + loud” and “hot + quiet” cells:** large *N*, many sites and times — **no row dropping**; quiet/cool moments stay in the dataset as **low factor levels** or low continuous values. They do **not** require UTCI > 26 on every row.</span>

### 0.4 Audit snapshot (refresh after re-run)

**T1 — `H4_primary_estimands_results.csv`** (literature-primary H4; source rule *p* < 0.05):

Interaction rows:

| Primary block | MET? | Notes |
| --- | ---: | --- |
| Jin LAeq × UTCI (dBA), thermal / acoustic / overall | **No** | *p* ≈ 0.56, 0.68, 0.59 |
| Chen `utci_z:dba_z` → thermal comfort | **No** | *p* ≈ 0.11 |
| Wu `loud60:utci_z` → thermal comfort | **No** | *p* ≈ 0.61 |
| Mohammad `utci_z:sound_z` → acoustic comfort | **No** | *p* ≈ 0.58 |
| Li `utci:dba` (interaction block) | **No** | *p* ≈ 0.37 (each outcome in block) |
| Zhen `utci:dba` → thermal comfort | **No** | *p* ≈ 0.37 |

**Exploratory — `H4_route_contrast_results.csv` (not H4 pass/fail):** thermal *p* ≈ 0.010, visual *p* ≈ 0.0016, acoustic *p* ≈ 0.095; ΔdBA, ΔUTCI *p* < 0.001 — useful for **co-exposure description** only.

**H4 verdict (literature-primary):** **Interaction ports not supported** at *p* < 0.05 on walk cells (§0.4 table). Report **null interactions** + **design limits** (§0.3b: *n* = 22, route–sound–heat coupling). **Do not** rescue H4 with WalkU − WalkG or post-hoc filters unless explicitly re-registered.

### 0.5 Reporting rules (reviewer-safe)

- **Do** state **Tier 1 literature rows** (§0.3–§0.4) as **H4 Results**; optional one sentence on corridor contrast (§0.7); full catalogue in **appendix**.
- **Do not** write “H4 supported because 18/24 papers had ≥1 MET” or “2,344 tests.”
- **Do not** cite Rodrigues/Moshammer/Kraus physiology MET rows as **comfort amplification**.
- **Do not** treat Jin **quartile/YAMNet** interaction METs as H4 evidence; label **exploratory**.
- Per-row significance remains **`paper_rule` only** for **that adapted row** (§1.4); no catalogue-wide FDR.
- **Do not** cherry-pick catalogue METs; Tier 2 ports the **listed interaction families** (§0.3) for transparency regardless of source significance.

### 0.6 Literature identification and partial porting (Methods wording)

**Purpose:** Literature informs **which method families exist** in outdoor thermo-acoustic research. We **adapt** feasible families to our design; we do **not** validate those studies.

| Step | What we did |
| --- | --- |
| **Search** | Scopus title/abstract/keywords: **`therm*`** AND **`outdoor`** AND **`sound*`** (209 documents, export `scripts/_scopus_export_text.txt`, snapshots `H4Scopus_therm_outdoor_sound.pdf`). |
| **Screen** | Retain papers with **measured sound** (LAeq/dBA or accepted analogue), **thermal exposure** (UTCI, air temperature, PET, etc.), and **outcomes we collected** (domain comfort votes and/or wearables during outdoor mobility). Drop blocks with **no sound and no thermal** in the source test (e.g. Song park vs city — item 10). |
| **Port** | Per retained source, fit **one closest statistical family** that our 11-person, 8-min bout data can support (§3 items **8–9**). Item **10** lists everything **not** ported (personality inventories, pollutants, EEG/SHAP, chamber-only arms, subjective loudness scales we did not ask, etc.). |
| **Hypothesis layer** | **§0.3–§0.3b** define **H4** (literature comfort×sound×thermal families). **§0.7** corridor contrast is **exploratory**, not pass/fail. |

**Thesis Methods (one paragraph):** Literature search → inclusion on joint outdoor thermo-acoustic measurement → **method adaptation** (not validation) per [`H4_TEST_STRUCTURE.md`](H4_TEST_STRUCTURE.md). **Results:** H4 pass/fail = **Tier 1 / A1** only (`H4_route_contrast_results.csv`). Tier 2–3 = sensitivity + appendix. Prose: [`H4_THESIS_READY.md`](H4_THESIS_READY.md).

### 0.8 H4 test structure (start here)

Full blueprint: **[`H4_TEST_STRUCTURE.md`](H4_TEST_STRUCTURE.md)** — tiers (T1 registered test, T2 literature-shaped sensitivity, T3 appendix), data lattice (11 people, 48×10 s, one vote/bout), time-series counts in sources vs Paper 3, execution workflow, thesis wiring.

| Tier | What | H4 significance? |
| --- | --- | ---: |
| **T1** | Literature-primary ports (`H4_PRIMARY`) | **Yes — defines pass/fail** |
| **T0** | Corridor paired contrast (`H4_ROUTE`) | **No — exploratory only** |
| **T3** | 28× method catalogue CSV | No (Methods only) |

### 0.9 Anna Laura / **Pisello AL** network (anchor vs excluded)

| Paper | In H4 §3? | In **5 Methods anchors**? | Local PDF |
| --- | ---: | ---: | --- |
| **Pigliautile et al. 2021** (NEXT.ROOM chamber) | §3.1 | No (chamber analogue only; Tier 1 cites route papers) | `Anna Laura/` + `Sound_evidence/` |
| **IBPC 2018 poster** (NEXT.ROOM) | §3.2 | No | `Anna Laura/Sound - IBPC 2018 poster - NEXT.ROOM thermal soundscape perception.pdf` |
| **Chiucchiù et al. 2026** (NEXT.ROOM + personality) | §3.3 | No (Tier 3 port) | `Anna Laura/` |
| **Cureau et al. 2022** (outdoor park walks) | §3.4 | **Yes** (multimodal outdoor comfort) | `Sound_evidence/`; copy `Anna Laura/Sound - Cureau et al 2022 - …pdf` |
| **Cureau et al. 2023** Forum Acusticum comfort walk | §3.5 | No (journal §3.4 is Methods anchor) | `Sound_evidence/Sound - A multi-domain comfort walk - cross-modal interactions on acoustic perception.pdf` |
| **Grapas et al. 2026** (Brussels wearable walks; **Pisello AL**) | §3.6 | No | `Urban Climate Literature/Sound - Grapas et al 2026 - …pdf` |
| **Pisello-network material acoustics** (4 lab panel studies) | §3.7 | No | `Anna Laura/Sound - …` (cardboard ×2, PET, cool-roof aggregates) |
| **Mansi et al. 2022** (physio decode comfort) | **No** | No | cite in intro only (`Paper3_outline`) — thermal decode only, **no sound** |

**Of the five Methods anchors (Moshammer, Song, Jin, Chen, Cureau): only Cureau is Anna Laura / Pisello.** Pigliautile is a **Tier 1 method analogue** in code notes, not one of the five main-text citations.

**§3 numbering rule:** **§3.1–§3.7** = **Anna Laura / Pisello / UCLab line** (chamber → outdoor walks → material lab acoustics), listed **before** the Scopus screen. **§3.8–§3.28** = Scopus **24**. **H4 pass/fail unchanged** (Tier 1 only).

### 0.10 Collaborator & local PDF audit (outdoor thermal **and** sound)

**Bottom line for thesis / examiners:** **§3.1–§3.7** document the Pisello-network **measured sound + thermal** line (NEXT.ROOM → outdoor comfort walks → Brussels multimodal walks → lab panels). **Cureau §3.4** = Methods anchor #5. **Scopus ports** start at **§3.8** (Moshammer … Şimşek). **Cureau 2024 microclimate** remains **outside §3** (thermal maps only).

| Local PDF / paper | Outdoor sound + thermal measured? | In H4 §3? | Where else in Paper 3 | Verdict |
| --- | ---: | ---: | --- | --- |
| **Grapas et al. 2026** — *Urban chronotypes…* (`Urban Climate Literature/Sound - Grapas et al 2026 - Urban chronotypes climate vulnerability safety-modulated bioclimatic responses.pdf`) | **Yes** — wearable **dBA, UTCI**, physiology, behavior on Brussels walks | **§3.6** | Ref list + **Fig. 11 SOR**; Discussion pathway latency | **Tier 3** port: exposure–biomarker–vote **Pearson web** analogue, not comfort×UTCI×dBA interaction |
| **Cureau et al. 2024** — *On urban microclimate spatial-temporal dynamics…* (`Experiment papers/On urban microclimate spatial-temporal dynamics_ Evidence from the integration of fixed and wearable sensing and mapping techniques.pdf`) | **Thermal / PET / Ta only** — **no measured sound** | **No** | Wearable microclimate / Kriging precedent | **Cannot add to §3** (no sound arm) |
| **Cureau 2022** + **Forum Acusticum 2023** comfort walk | **Yes** — outdoor walks, multimodal comfort | **§3.4** + **§3.5** (FA preprint) | Methods anchor **#5** = journal | FA block = same Fisher family as §3.4, labelled preprint |
| **Pigliautile / Chiucchiù / IBPC** NEXT.ROOM | Chamber headphones + temperature (+ poster) | §3.1, §3.2, §3.3 | Tier 1 route analogue (Pigliautile) | Chamber — documents Pisello sound×thermal perception line |
| **Material acoustics** (Anna Laura folder) | **Lab** transmission / absorption + thermal conductivity — **not** field LAeq | **§3.7** | Building-material Discussion if needed | Measured **sound** at material level; **no** human comfort vote port |
| **Rodrigues 2026** | Walk Lden + weather; physiology | §3.11 | LMM precedent in outline | **Physio** block; comfort not primary |
| **Ueberham 2019** | Cycling objective sound + heat | §3.15 | Bike phases only | No subjective loudness items here |
| **Korkmaz 2025** | Urban walk physiology + **temperature**; **no noise sensor** | No | Ambulatory reliability precedent | **Out of H4 screen** (no measured sound) |
| **Fahy et al.** PET transects Geneva (`ucm paper - urban walk LCZ.pdf`) | Thermal (**PET**) only along transects | No | Morphology / PET context elsewhere | No sound outcome |
| **Ma & Zhang** Beijing OTC (`ucm paper - thermal paper.pdf`) | Outdoor **thermal** questionnaires + microclimate | No | General OTC background | No sound measurement |
| **Lan 2024** (excluded folder) | Thermal + **air quality** parks; physio | No | — | **Not thermo-acoustic** (PM/air, not LAeq) |
| **Schaupp 2025** (excluded folder) | **Noise**-manipulated forest vs urban **walk** RCT | No | Optional restoration Discussion | Traffic noise + greenspace; **no joint thermal–acoustic comfort vote port** aligned with §0.6 |
| **Lam 2024, Tu 2026, Li 2026, Tartarini 2023** (excluded) | Partial overlap (thermal **or** sound **or** wearables) | No | H5 / other hypotheses if needed | Fail **§0.6** joint criterion or wrong outcome (PEQ, EDA-only, chamber/app) |
**Reviewer-safe sentence (paste):** *Literature method adaptation uses **28** §3 blocks. **§3.1–§3.7** list the Pisello / UCLab / Anna Laura thermo-acoustic line (NEXT.ROOM, outdoor comfort walks, Grapas et al., 2026, lab material acoustics) **before** the Scopus screen (**§3.8–§3.28**, *n* = 24). **H4 pass/fail** remains Tier 1 paired WalkU − WalkG only. Cureau et al. (2022, §3.4) is the Pisello-network outdoor comfort Methods anchor.*

## 1. Data available to H4

| Available analysis data | Four active phases | With Tram |
| --- | ---: | ---: |
| Independent participants | 11 | 11 |
| Participant × phase cells (bouts) | 44 | 55 |
| Ten-second rows in those phases | 2,112 (48 per bout) | 2,637 |
| Rows with finite `ucm_SND_dBA` and `ucm_UTCI` | 2,112 | 2,629 |
| Rows with finite YAMNet class and spectral columns | 2,111 | 2,634 |
| Cells with each of thermal, acoustic and overall-comfort ratings | 44 | 55 |
| People with both green (WalkG, BikeG) and urban (WalkU, BikeU) corridors | **11** | **11** |
| People with both YAMNet vehicle>rural nature and traffic phase labels | **9** | **10** |
| Sound representations considered (estimability varies by method) | four (dBA, corridor, vehicle vs rural_natural, 8 class proportions) | same four |

**Where 2,112 versus 2,111 comes from.** The four core phases contain exactly 44 bouts × 48 ten-second rows = 2,112 rows. Sound level, UTCI, air temperature, RH, heart rate, skin temperature and the listed comfort/PRS scores are finite on all 2,112 rows. One ten-second row (P13, BikeG, 2025-08-13 14:22:40) has no YAMNet class proportions and no spectral descriptors, so those columns have 2,111 finite rows. That bout's phase-mean proportions use its other 47 rows. Physiological 10-s columns have their own coverage: SDNN 1,782, RMSSD 1,945, 5-min LF 1,334 and tonic EDA 1,843 of 2,112 rows.

Sound and temperature vary: the core phase-energy-mean dBA ranges from **55.86 to 81.15 dB(A)** and phase-mean UTCI from **20.61 to 35.71 °C**. Phase-mean air temperature ranges from 21.42 to 32.08 °C. Individual physiological models have their own missingness and sample counts (given per paper in §3).

### 1.1 Four sound representations, where supported by the method

H4 does **not** use only a majority cut. The four representations are attempted in the compatible measured-sound blocks, using the same 10 s / 8-min data. Some fits are not estimable; vote-to-vote, thermal-only and site-specific blocks do not use every representation. Corridor represents environmental context, not an isolated sound exposure. **Each encoding is a separate predictor and a separate adapted hypothesis, not an exact replication of the source exposure.** Report these analyses separately.

| Encoding | What it is | Scale |
| --- | --- | --- |
| 1. Recorded A-weighted sound level | `ucm_SND_dBA`, energy-aggregated within the analysis window; native LAeq/calibration provenance remains unverified (the 10-s value is a median of the UCM samples) | continuous dB(A) |
| 2. Corridor / phaseavg | WalkG and BikeG vs WalkU and BikeU | binary; 11 of 11 people have both |
| 3. YAMNet vehicle vs rural_natural | per 10-s row, traffic if `vehicle_proportion` > `rural_natural_proportion` (744 of 2,111 core rows); at phase level this becomes the **share** of traffic rows (27 distinct values, 0–0.83) or, in Pigliautile/Chiucchiù, a phase label | two-minority head-to-head, **not** 8-class majority. Urban/man-made positive wins ~63% of 10 s rows; vehicle wins ~6.5%. Do not use “all other classes” as the base (0 walking phases would be traffic). Label occupancy: 9 of 11 people have both phase labels (P10 all traffic, P16 all nature); 10 of 11 with Tram |
| 4. YAMNet class proportions | each of eight category columns, phase or window mean | continuous 0–1: `wind_proportion`, `rural_natural_proportion`, `vehicle_proportion`, `urban_manmade_neutral_proportion`, `urban_manmade_positive_proportion`, `urban_manmade_negative_proportion`, `mechanisms_proportion`, `unidentify_proportion` |

Papers and how the four encodings enter (details and data per paper in §3):

- **Moshammer, Biel, Kraus, Rodrigues:** substitute the representation for sound level in the explicitly adapted source-inspired model. **Jin (WalkG/WalkU):** primary **dBA** block uses **5 dB-spaced** sound bands × **UTCI stress-category** cuts; **encodings 2–4 and spectral** substitutes use **`H4_JIN$run`** (sample **quartiles** of sound and UTCI). For Rodrigues, within-trip corridor SD is zero, making the joint max+SD model singular; the max still varies between trips. The Kraus two-segment corridor fit is also singular.
- **Korpilo:** source run keeps the NDSI analogue; the same LMM is also fitted with each other encoding in place of NDSI (corridor is aliased with PhaseID and not estimable).
- **Pigliautile:** paired traffic-minus-nature person means for encodings 2–3, and thermal-stratum person-mean Spearman for encodings 1 and 4. Full-session vote–sound Spearman is fitted once under Chiucchiù, not repeated under a second family.
- **Chiucchiù:** paired physiological warmer/cooler means; Table 5 analogue for encodings 2–3; full-session person-mean Spearman of thermal/pleasantness/acoustic votes against encodings 1 and 4. Where the source uses **TSV**, the runner uses **`questionnaire_thermal_comfort_1_5`** (§2).
- **Chen:** `rating ~ zUTCI * zSound + (1|participant)` for each encoding. Primary dBA also includes `zNaturalShare`.
- **Qin:** `TC ~ zSound * zRH` on all four encodings (humidity, not UTCI).
- **Gao:** `PRS ~ zUTCI * zSound` on all four encodings; two-way ANOVA of PRS on dBA × UTCI quartiles.
- **Wu:** `OC ~ zUTCI + zSound` on all four encodings; `TC ~ I(dBA≥60) * zUTCI`; median-split analogue on encodings 2–4.
- **Xu:** thermally unadjusted linear `AC ~ zSound` (not a threshold); combined `TC ~ I(air_temp_c>32) * I(dBA>65)` only if all four cells are observed (not in core; §3.21). Air temperature, not UTCI. The ASV 64.8 dB knot is not imposed on AC.
- **Zhen:** unstandardized `TC ~ UTCI * dBA` sensitivity without Chen’s natural-share covariate; source **TSV** slopes use **`questionnaire_thermal_comfort_1_5`** (§2). Alternative encodings are not refitted because they reparameterize Chen TC.
- **Mohammadzadeh:** `AC ~ zUTCI`, `AC ~ TC`, and the primary dBA interaction without Chen’s natural-share covariate. Alternative-encoding AC interactions are canonical Chen fits, not duplicated.
- **Cureau:** no sound exposure (vote vs vote by phase). **Zhang SciRep:** perceived AC × **PET** (`ucm_PET`), not a measured sound encoding. **Zhang BSim:** Spearman vs dBA by phase. **Song / Ueberham / Li 2025:** see §3.15–§3.16 and §3.25. **Tang / Peng / Şimşek:** §3.26–§3.28.

Fifteen spectral descriptors are an extra substitution on Moshammer, Jin, Biel, Rodrigues, Kraus and Korpilo only. They are not one of the four encodings. (Earlier text listed five papers; Korpilo also fits them as NDSI substitutes.)

Walking is the more stable loudness pair (energy-mean **64.4 dB(A)** WalkG vs **69.4** WalkU). Cycling is louder and more variable (**65.8** BikeG vs **76.3** BikeU). **dBA label trap:** those §1 walk/cycle numbers pool **all 10-s rows** within each `PhaseID`; many §3 walk-only tables (**61.7 / 67.6**) are **means of 11 bout energy-means** (one value per person×phase)—same column, different aggregation, not a pipeline bug. Encoding 3 seconds: of 2,111 core 10 s rows, WalkG is 28% vehicle>rural, BikeG 25%, BikeU 54%, WalkU **34% vehicle / 66% nature**. The previously cited native 1-s output path is absent; see **§7** (measurement provenance).

### 1.2 What the YAMNet proportion columns are, and their mapping limitation

The proportion columns come from `D:\Pranav\docker\Analysis\analysis_scripts\Updated_JOS_Environmental_sound_classification_with_YAMNet_yenshuo.ipynb` (outputs in `Analysis\analysis_output\Sound_ucm`). A proportion is the **share of YAMNet frames** (about 20 per 10-s window) in which any class mapped to that category scores ≥ 0.20. Categories overlap, so the eight columns can sum to more than 1; `unidentify` is the share of frames with no category. These are thresholded frame-detection prevalences, not exact sound durations, energy shares, calibrated levels or classifier confidence. Peak normalisation removes the absolute amplitude reference; the proportions cannot recover calibrated sound level, although they may correlate with recorded dBA.

**Known category-mapping errors:** categories are assigned by case-insensitive substring matching. 42 YAMNet classes fall into more than one category. Examples: "Train" also counts as Rural/Natural ("rain" is inside "train"); "Crowd" counts as Rural/Natural ("crow"); "Rain", "Water", "Fire" and some music classes count as Vehicle; the generic "Noise" class and "Owl" count as Wind; "Traffic noise, roadway noise" is in Urban negative but **not** in Vehicle; and the generic "Vehicle" class is in both Vehicle and Urban negative. This limitation applies to every analysis below that uses encodings 3 or 4 (and Chen's natural share). **The proportion columns have not been regenerated with a corrected mapping**, so current results use the mapping as described. These known semantic mapping errors prevent interpreting the exported labels as validated natural/vehicle exposure. Until correction and regeneration, report associations with the exported labels only; source-specific design recommendations are not supported by them.

### 1.3 Units of independent information, and what "sparse" means here

- **Comfort, pleasantness, visual-comfort and PRS ratings were asked once per phase.** Every 10-s row in a bout repeats the same rating (at most one distinct value per bout). The 2,112 ten-second rows therefore give **44 phase ratings from 11 people**, not 2,112 ratings. Every comfort-outcome model below uses **44 phase cells** when item 6 includes all four phases, **22 walk cells** when item 6 is WalkG+WalkU only, or **11 participant means** when the helper collapses paired walks (`H4_AL$spearman_row`, vote–vote Spearman)—never 10-s rows as fake *n*.
- **§1 vs §3 counts:** tables and bullets above that say **44** describe the **full four-phase merged file**. Walk-only method ports (most §3 blocks) use **22** questionnaire cells unless stated otherwise; do not read §1.3 “44 cells” as the *n* for Pigliautile, Jin, Moshammer, etc.
- Physiological outcomes vary within a bout, so some physiology blocks use sub-bout windows (Biel 2-min windows, Kraus 5-min interval, Moshammer 5-min/3-min split). These windows are serially correlated repeated observations, not new people.
- Tram adds another repeated condition, not new participants. These observations permit model fitting. They do not turn 11 people into 44 or 55 independent people. The headphone experiments cannot be reconstructed, because temperature and route travel together. Short recordings also prevent several source lag/window analyses. Statistical significance is not a data-sufficiency certificate.
- **Continuous predictors versus thresholds.** A continuous predictor uses all 44 cells when it varies within people. Across the 44 core cells, the share of predictor variance that lies within persons is 0.89 for dBA, 0.81 for the vehicle-vs-rural share and 0.57–0.91 for the eight class proportions. Median splits of encodings 2–4 give about 22/22 cells, with 9–11 people having both levels. A fixed published threshold can instead leave almost no data on one side. **"Sparse" in this guide is not a universal minimum.** It means that a specific contrast is supported by so few cells or people (for example 0–3) that the coefficient is unidentifiable or rests on one or two people.
- Corridor and the YAMNet label are tied to temperature: when each person's own phases are split into cooler and warmer by air temperature, corridor gives cooler 21 green + 2 urban and warmer 1 green + 20 urban. The YAMNet phase label gives cooler 16 nature / 7 traffic and warmer 5 / 16. That does not remove the 11-person corridor contrast, but nature-versus-traffic **within** a thermal stratum has only 1–3 people with both levels (Pigliautile and Chiucchiù below).

### 1.4 Inference and results reporting

| Layer | What to use |
| --- | --- |
| **Paper 3 H4 hypothesis** | **Tier 1 only** (`H4_route_contrast_results.csv`, §0.7) in main Results. Tier 2 optional; Tier 3 appendix. |
| **Runner outputs** | `H4_route_contrast_results.csv` (**T1**), `H4_primary_estimands_results.csv` (**T2**), `H4_sound_literature_tests.csv` (**T3**) in `output/statistical_analysis/results/H4_sound_literature_test/`; from `H4_sound_literature_test.R` (`H4_ROUTE` runs first). |
| **Source paper** | Significance rule in §3 **item 5** (and any stricter rule in **item 9**) applies to **that adapted row only**. |
| **Our adapted port row** | Compare **p** to **`paper_rule`** for **appendix / Tier 2** interpretation. **≥1 MET per paper** or catalogue counts **do not** define H4. |
| **Thesis / paper prose** | Cite **test family + p + coefficient** per block. Name the **source** decision rule when discussing “significance.” **Do not** write that Jin, Chen, Xu, etc. “used FDR” or BH correction unless the PDF explicitly does (most selected blocks do not). |

**Outputs:** [H4_sound_literature_tests.csv](../output/statistical_analysis/results/H4_sound_literature_test/H4_sound_literature_tests.csv), `SUMMARY_sound_tests_paper_rule.csv`, and `METHODS_NOTES.md` after `H4_sound_literature_test.R`. Refresh after each run.

**No catalogue FDR:** current `H4_sound_literature_test.R` does **not** write `q_BH` or Benjamini–Hochberg columns. Use `SUMMARY_sound_tests_paper_rule.csv` (counts under each block’s `paper_rule` only). Older result folders may still contain legacy `SUMMARY_sound_tests_p_and_FDR.csv`; ignore those for thesis reporting.

**Illustration (p only, not a ranking of papers):** the Chen-style LMM `thermal_comfort ~ zUTCI × zSound` on walk cells can be read from the CSV; significance is **Wald *p* vs 0.05** as in the source regression tradition, not a corrected score across encodings. The four sound encodings (§1.1) are **separate adapted hypotheses** — report each with its own *p*, without pooling tests as one discovery list.

**Not implemented:** conditional dBA “when class X is present” (§4); do not cite as an H4 result.

**H5:** combined-exposure tables are separate; this guide is §3 literature tests only.

## 2. Questionnaire and indices used in H4

Scored from `Recurring questionnaire.csv` via `05_questionnaire_build.py` → merged `questionnaire_*` columns (one rating per phase, repeated on 10 s rows).

| What we collected | Question (short) | Merged column | Scale |
| --- | --- | --- | --- |
| Thermal comfort | Please describe your comfort **[Thermal]** | `questionnaire_thermal_comfort_1_5` | 1–5, higher = more comfortable |
| Acoustic comfort | … **[Acoustic (Urban Noise)]** | `questionnaire_acoustic_comfort_1_5` | 1–5 |
| Visual / air / odour | … **[Visual / Air / Odors]** | `questionnaire_visual_comfort_1_5`, etc. | 1–5 |
| Overall comfort | How comfortable do you feel right now? | `questionnaire_current_comfort_1_7` | 1–7 |

Thermal row anchors: Extremely uncomfortable → … → Comfortable (`COMFORT_MAP_5`).

### 2.1 Mapping source paper constructs → our columns

| When the source paper uses… | H4 column | Rule |
| --- | --- | --- |
| **TCV** (thermal comfort vote) | `questionnaire_thermal_comfort_1_5` | Same test family as the paper on this column |
| **TSV** (thermal sensation in tables) | **`questionnaire_thermal_comfort_1_5`** | **Adaptation:** same test as the source; outcome is domain thermal comfort (subjective thermal response). Do not rescale or label results as TSV. |
| **ACV** | `questionnaire_acoustic_comfort_1_5` | Direct |
| **OCV** (overall comfort) | `questionnaire_current_comfort_1_7` | When the source outcome is overall / 7-point comfort |
| **PET** | **`ucm_PET`** phase mean | When the source used PET |
| **UTCI** | **`ucm_UTCI`** phase mean | When the source used UTCI |

**Index rule:** PDF says PET → `ucm_PET`; PDF says UTCI → `ucm_UTCI`. Both are finite on all **44** core phase cells.

Optional monotone rescores (sensitivity; ranks unchanged): `comfort_5_centered = 2 × (thermal_comfort_1_5 − 3)`; `comfort_7_centered = current_comfort_1_7 − 4`. Constants: `H4_QUESTIONNAIRE` in `Paper3_common.R`.

Models use **raw scores** unless item **9** names a rescore. **Audit:** 55 thermal + 55 acoustic + 55 overall phase ratings checked against raw export and build script.

## 3. Paper by paper (numbered story)

### 3.0 Quick audit — what each block measures (for thesis Tables / Appendix)

| § | Source (short) | Source design (timing) | Our outcome focus | Comfort votes in port? |
| ---: | --- | --- | --- | ---: |
| **3.1** | Pigliautile 2021 | Chamber; votes after each playback / temp step | Votes + warm−cool / traffic−nature analogues | Yes (1×/phase) |
| **3.2** | IBPC 2018 poster | Chamber NEXT.ROOM (poster) | Thermal × soundscape perception (descriptive) | Yes (chamber analogue) |
| **3.3** | Chiucchiù 2026 | Chamber; physiology + votes | Physiology warm−cool + vote Spearman | Yes |
| **3.4** | Cureau 2022 | ~55 min park walk; votes at end | Vote–vote associations by walk phase | Yes — **Methods anchor #5** |
| **3.5** | Cureau FA 2023 | Outdoor comfort walk (Perugia) | Cross-modal comfort; Fisher analogue | Yes (vote–vote) |
| **3.6** | Grapas 2026 | Brussels walks; wearable multimodal | SOR-style **Pearson** exposure→vote web | Votes + physio (Tier 3) |
| **3.7** | Pisello material (×4 PDFs) | Lab impedance / transmission loss + thermal | Material **acoustic** + thermal props | **No** human votes |
| 3.8 | Moshammer 2019 | 1 h outdoor road vs park | HRV after noise window | **Physio only** |
| 3.9 | Jin 2020 | Many sites; 1 questionnaire/respondent | ANOVA bands × UTCI; **T2 shape** | Yes (vote; Tier 2) |
| 3.10 | Biel 2020 | Day-long mixed activity | Noise + Ta on HRV | **Physio only** |
| 3.11 | Rodrigues 2026 | Trip-level walking panel | Noise / temp blocks on physiology | **Physio only** |
| 3.12 | Kraus 2013 | 24–48 h personal noise | Piecewise dBA on HR/HRV | **Physio only** |
| 3.13 | Korpilo 2024 | Park/beach visits | EDA on soundscape index | **Physio only** |
| 3.14 | Chen 2023 | Repeated outdoor stops | LMM zUTCI × zSound; **T2 shape** | Yes (vote; Tier 2) |
| 3.15 | Ueberham 2019 | Cycling routes | Sound–thermal on cycling | Bike phases |
| 3.16 | Li 2025 | Arrival/departure greenway | LMM utci×dba; **T2** | Yes (vote; Tier 2) |
| 3.17–3.28 | Qin … Şimşek | Site surveys / walks | Mixed votes, PRS, thresholds | Mostly votes (see §3) |

**Paper 3 Tier 1 (not a §3 row):** paired **WalkU − WalkG**, end-of-phase votes, *n* = 11 — [`H4_route_contrast_results.csv`](../output/statistical_analysis/results/H4_sound_literature_test/H4_route_contrast_results.csv).

*(Item 7 counts audited from `output/merged_all_11participants_8min.csv` core phases WalkG, WalkU, BikeG, BikeU — run `python scripts/h4_sample_size_audit.py` to refresh.)*

Default file: `output/merged_all_11participants_8min.csv`; 11 participants (P4, P8–P17); four scheduled phases exist (BikeU, WalkU, BikeG, WalkG), but **item 6** per paper restricts which phases enter each method port (**WalkG/WalkU** for walk-only sources; **BikeU/BikeG** for §3.15 only; **all four** for mixed-mobility sources §3.10, §3.12). Each bout has **48 ten-second rows** (full series available where window logic needs them).

Each subsection: **1** citation → **11** what cannot be matched (item **3** = experiment location). **Pisello AL** appears in bold in **§3.1–§3.7** (Anna Laura / UCLab block listed **first**). `---` separates papers. **Setting:** **indoor chamber / lab:** §3.1–§3.3, §3.7; **outdoor field or mixed mobility:** §3.4–§3.6, §3.8–§3.28. Our measured data are **outdoor walk/cycle bouts**; chamber playbacks and material benches are not reproduced.

### 3.1 Pigliautile 2021 — indoor NEXT.ROOM / headphones

1. **Citation.** Pigliautile I, Fusaro G, Kang J, Chang WS, **Pisello AL**. Environmental thermal influence over soundscape perception (NEXT.ROOM). *J. Phys.: Conf. Ser.* 2021;2042:012136. doi:[10.1088/1742-6596/2042/1/012136](https://doi.org/10.1088/1742-6596/2042/1/012136). Local PDF: `Experiment papers/Sound_evidence/Sound - Environmental thermal influence over soundscape perception - a test room experimental campaign involving the psychological and physiological description of the indoor environment.pdf`.
2. **Objective.** Cross-modal effect of warming the room on soundscape evaluation (pp. 1–2).
3. **Experiment location.** **Perugia, Umbria, Italy** — indoor **NEXT.ROOM** test chamber (UCLab / University of Perugia network).
4. **Instruments and sensors (source study).** Sony WH-1000XM4; seven fixed playbacks; room Ta ±0.2 °C at 1.10 m; 10dB SOLO background grid (pp. 2–3). No physiology in text checked.
5. **Data they collected (type, timing, resolution, sample).** *n* = 40; C0 **21 °C** then C1 **~23 °C**; 5-point thermal/visual/acoustic/air-quality votes; identical thermal order for all.
6. **Statistical test in the source paper.** The paper reports **descriptive mean comparisons** of thermal, visual, acoustic and air-quality votes between **C0 (21 °C)** and **C1 (~23 °C)** and between **assigned soundscape playbacks** (e.g. woodland vs busy street); Figures 3a–3b. No formal inferential model is reported in the conference text we checked.
7. **Mode/Environment.** **Source:** seated **indoor NEXT.ROOM**; no locomotion—**headphone soundscape playbacks** (e.g. woodland vs busy street) at **C0 21 °C / C1 ~23 °C**. **Our phases:** thermal strata on **WalkG + WalkU** only (**no BikeG/BikeU**—source did not walk or cycle). **WalkG** ≈ greener / nature-associated soundscape; **WalkU** ≈ urban traffic context. **Ten-second data:** all **48 rows × 11 participants** per included walk phase (up to **1,056** rows on WalkG+WalkU).

8. **Sample size (for test).** **WalkG 11 + WalkU 11 = 22** questionnaire cells (§1.3 **44** = full four-phase file only). **Paired WalkU−WalkG:** **11/11** people. **Cooler vs warmer** (median phase `ucm_AIR_temp` on walk cells): **11 cooler / 11 warmer** bout labels. **Within-person both thermal halves (walk only):** **11/11**. **10 s rows:** **1056** on WalkG∪WalkU. **Flag:** Fig. 3b **within-stratum** traffic vs nature often **not estimable**; Spearman in a thermal half uses **≤11 participant means**; source **n=40** chamber.

9. **Our data for method port.** Input: `output/merged_all_11participants_8min.csv` → **WalkG + WalkU** cells (item 6) via `H4_AL$bout_frame()`. **Thermal analogue:** split each person’s phases into **cooler vs warmer** by median phase-mean `ucm_AIR_temp` (C0/C1 substitute). **Sound analogue:** per phase, **traffic vs nature** from `sound_yamnet_majority_traffic` or corridor (**WalkU** vs **WalkG**), plus continuous `ucm_SND_dBA` and YAMNet class proportions. Outcomes: `questionnaire_thermal_comfort_1_5`, `questionnaire_visual_comfort_1_5`, `questionnaire_acoustic_comfort_1_5`, `questionnaire_air_quality_comfort_1_5`, `questionnaire_pleasantness_1_5` (pleasantness proxy).
10. **Our statistical test (closest family).** (`H4_PIGLIAUTILE` in `H4_sound_literature_helpers.R`.) **(a)** Paired *t*-test on **person means**: warmer minus cooler for **thermal, visual, acoustic, air-quality** votes (Fig. 3a analogue; air-quality is our item, not a source ISO scale). **(b)** Paired *t* on person means **traffic minus nature** for pleasantness and acoustic comfort, **overall** (11 pairs when both walks exist). **Within each thermal stratum**, the same traffic-vs-nature paired *t* (Fig. 3b) is usually **not estimable** on walk-only data (corridor and YAMNet labels align with temperature—often **≤2** people with both labels in one half); those rows are **dropped from the CSV** and listed under **not estimable** in `METHODS_NOTES.md`—that is data geometry, not a code bug. **(c)** **Spearman** ρ (vote vs continuous sound) **within** cooler and within warmer strata; `H4_AL$spearman_row` uses **participant means inside the stratum** (at most **n = 11**), not 22 pooled phase rows. Compare *p* to 0.05 only where the source highlights differences (conference text is mostly descriptive).
11. **What cannot be matched.** No test room, no Sony headphone playbacks, no fixed +2 °C step for everyone, no 10 dB SOLO grid, no eight ISO soundscape descriptor scales.

---

### 3.2 IBPC 2018 — NEXT.ROOM thermal × soundscape (poster)

1. **Citation.** **Pisello AL**, Pigliautile I, Fusaro G, et al. NEXT.ROOM: thermal influence on soundscape perception (IBPC 2018 poster). Local PDF: `Experiment papers/Anna Laura/Sound - IBPC 2018 poster - NEXT.ROOM thermal soundscape perception.pdf`.
2. **Objective.** Introduce the **NEXT.ROOM** test-room line: how **indoor temperature** modulates **headphone soundscape** evaluation (poster figures; precursor to Pigliautile 2021, §3.1).
3. **Experiment location.** **Perugia, Umbria, Italy** — indoor **NEXT.ROOM** (IBPC 2018 poster campaign; same facility lineage as §3.1).
4. **Instruments and sensors (source study).** Controlled test room; **Sony WH-1000XM4** playbacks; room temperature steps; **measured sound levels** of calibrated playbacks (poster diagrams).
5. **Data they collected (type, timing, resolution, sample).** Pilot / campaign visuals; multi-domain perceptual votes under **warm vs cool** room conditions and **contrasting soundscapes** (e.g. green vs traffic-associated clips).
6. **Statistical test in the source paper.** **Descriptive** means and graphics; **no peer-reviewed inferential table** on the poster sheet we archive.
7. **Mode/Environment.** **Source:** seated **indoor NEXT.ROOM** (same lineage as §3.1). **Our phases:** **WalkG + WalkU** as **field** green vs urban sound/thermal analogues only (**no headphones**).
8. **Sample size (for test).** Same lattice as §3.1: **22** walk questionnaire cells; paired warm−cool on **11** people when both thermal halves exist.
9. **Our data for method port.** Reuse **`H4_PIGLIAUTILE`** paired warm−cool vote contrasts (thermal, acoustic, pleasantness) — poster is **protocol background**, not a separate CSV family.
10. **Our statistical test (closest family).** Label rows **`IBPC 2018 poster (adapted from Pigliautile block)`** when exported; compare to source **visually**, not to foreign *p*-values.
11. **What cannot be matched.** No poster sample *n* table, no full ISO descriptor battery, no chamber reproduction on Brussels walks.

---

### 3.3 Chiucchiù et al. 2026 — indoor NEXT.ROOM / headphones

1. **Citation.** Chiucchiù A, Gnecco VM, Pigliautile I, **Pisello AL**. The role of personality in multi-domain environmental perception. *Building and Environment* 2026;290:114140. doi:[10.1016/j.buildenv.2025.114140](https://doi.org/10.1016/j.buildenv.2025.114140). Local PDF: `Experiment papers/Anna Laura/Sound - The role of personality in multi-domain environmental perception An occupant-centric approach.pdf`.
2. **Objective.** Cross-domain thermal–acoustic perception and personality (abstract). Same NEXT.ROOM campaign as Pigliautile; *n* = 25 analysed sessions.
3. **Experiment location.** **Perugia, Umbria, Italy** — indoor **NEXT.ROOM** chamber (controlled temperature + headphone soundscapes).
4. **Instruments and sensors (source study).** Empatica E4 (EDA, HR, skin T, **1 min**); Sony WH-1000XM4; PT100 / Delta OHM room sensors; IPIP-NEO-120 personality (source paper §2).
5. **Data they collected (type, timing, resolution, sample).** C0 21 °C / C1 23 °C; seven randomised soundscapes; paired physiology C0 vs C1; Spearman across domains; Table 5 descriptor deltas within assigned soundscapes.
6. **Statistical test in the source paper.** **Paired *t*-tests** (and Cohen’s *d*) on Empatica **EDA tonic, HR, skin temperature** between **C0 (21 °C)** and **C1 (23 °C)** across assigned soundscapes (§2.4). **Spearman** correlations among perceptual domains (thermal, acoustic, pleasantness). **Table 5 analogue:** within each assigned soundscape, paired C0 vs C1 deltas on votes. **K-means** on **IPIP-NEO-120** personality (five profiles); physiology–personality links not repeated here.
7. **Mode/Environment.** **Source:** same **indoor NEXT.ROOM / headphone** campaign as §3.1 (C0/C1, randomised soundscapes). **Our phases:** votes and physiology on **WalkG + WalkU** for field sound/thermal analogues (**no cycling**). **Ten-second data:** **48 rows × 11** per walk phase used in each test.

8. **Sample size (for test).** **22** walk **bouts** for phase-mean physiology; **11** independent people for vote–vote Spearman and paired *t*. Physiology finite walk: **HR / tonic EDA / skin T 22/22** each (no SDNN/RMSSD in `H4_CHIUCCHIU`). **Paired warm−cool (walk):** **11/11** people. **Flag:** no personality inventory; Table 5 / nature-only or traffic-only warm−cool pairs often need **≥3** people with both thermal halves in one sound stratum—many are sparse.

9. **Our data for method port.** Same **WalkG + WalkU** cells as §3.1 item 6. Physiology phase means: `empatica_eda_tonic`, `empatica_heart_rate`, `empatica_skin_temperature`. Votes: thermal, acoustic, pleasantness. Thermal/sound strata as in §3.1. No personality columns in merged file.
10. **Our statistical test (closest family).** (`H4_CHIUCCHIU` on **WalkG/WalkU** only — **22** bout rows in frame, **11** people.) **(a)** Paired *t* **warmer − cooler** person means on **HR, tonic EDA, skin temperature** (C0/C1 analogue) and on **`thermal_comfort`** (source **TSV** paired test; §2). **(b)** Spearman on **n = 11 participant means** (one mean per person across their two walks): thermal vs acoustic comfort; thermal vs pleasantness—**not** a 22-cell correlation (that would double-count people). **(c)** Within **nature-only** or **traffic-only** subsets, paired *t* **warmer − cooler** on pleasantness and acoustic comfort (Table 5 analogue; encodings 2–3); sparse cells → not estimable. **(d)** Spearman votes vs `ucm_SND_dBA` / YAMNet proportions via the same **participant-mean** rule (`H4_AL$spearman_row`). Personality k-means **not** run (inventory absent).
11. **What cannot be matched.** No chamber, no randomised seven headphone soundscapes, no 1-min Empatica cadence as in NEXT.ROOM, no Big Five inventory. Source **TSV** paired block uses domain thermal comfort (§2).

---

### 3.4 Cureau et al. 2022 — outdoor park walks

1. **Citation.** Cureau RJ, Pigliautile I, Kousis I, **Pisello AL**. Multi-domain human-oriented approach to evaluate human comfort in outdoor environments. *Int. J. Biometeorol.* 2022;66:2033–2045. doi:[10.1007/s00484-022-02338-7](https://doi.org/10.1007/s00484-022-02338-7). Local PDF: `Experiment papers/Sound_evidence/Sound - Multi-domain human-oriented approach to evaluate human comfort in outdoor environments.pdf`; duplicate `Experiment papers/Anna Laura/Sound - Cureau et al 2022 - Multi-domain human-oriented approach evaluate human comfort outdoor environments.pdf`.
2. **Objective.** Evaluate outdoor park comfort across thermal, visual, acoustic and air-quality domains (abstract).
3. **Experiment location.** **Perugia, Italy** — **outdoor** field campaign between two **urban parks** (local-user comfort walks).
4. **Instruments and sensors (source study).** Backpack wearable (GPS, Ta, RH, wind, radiation, illuminance, CO2, PM); C.A. 832 sonometer at response time; fixed weather station (p. 2036).
5. **Data they collected (type, timing, resolution, sample).** 24 walkers (3/walk, 8 walks) plus local park users; walk Park 1 → Park 2, ~55 min + surveys; 5-point ISO / soundscape votes.
6. **Statistical test in the source paper.** **Fisher exact** associations between comfort-domain answer categories **separately by park** (p. 2037); also Mann–Whitney and multinomial models on other samples.
7. **Mode/Environment.** **Source:** **outdoor walk** between two Perugia **parks** (~55 min). **Our phases:** **WalkG** and **WalkU** as two park-walk contexts (**walking only**; **no bikes**). **Ten-second data:** **11 × 48** rows per phase (**22** bouts total).

8. **Sample size (for test).** **WalkG 11 + WalkU 11 = 22** cells. Fisher tables **11** responses per walk phase. **Flag:** **n=11** per table is small; source multi-walker parks not reproduced.

9. **Our data for method port.** **WalkG** and **WalkU** as park analogue (item 6); **11 people per walk phase**, one rating each. Pairs: thermal vs acoustic, thermal vs visual, thermal vs overall, acoustic vs visual, acoustic vs overall, visual vs overall via **`h4_additional_outdoor_tests(..., papers = "Cureau")`** in `H4_sound_literature_helpers.R`. No measured dBA in this test.
10. **Our statistical test (same family, closest timing).** Fisher exact on contingency of ordinal comfort categories, **per WalkG and per WalkU** (item 6; **no Bike phases**).
11. **What cannot be matched.** Not two Perugia parks; not independent local-user tables; multinomial comfort models not replicated.

---

### 3.5 Cureau et al. 2023 — Forum Acusticum comfort walk (preprint)

1. **Citation.** Cureau RJ, Domenighini L, Pigliautile I, Cotana F, **Pisello AL**. A multi-domain comfort walk: cross-modal interactions on acoustic perception. *Forum Acusticum* 2023. doi:[10.61782/fa.2023.1153](https://doi.org/10.61782/fa.2023.1153). Local PDF: `Experiment papers/Sound_evidence/Sound - A multi-domain comfort walk - cross-modal interactions on acoustic perception.pdf`.
2. **Objective.** Outdoor **comfort walk** with environmental monitoring and **acoustic perception** ratings during urban mobility (conference paper; journal version = §3.4).
3. **Experiment location.** **Perugia, Italy** — **outdoor** urban walk segments (Forum Acusticum / comfort-walk preprint).
4. **Instruments and sensors (source study).** Wearable / portable environmental monitoring on walk; **measured sound level** alongside thermal and other domains during **Perugia** urban walk segments.
5. **Data they collected (type, timing, resolution, sample).** Walk segments with synchronized **dBA (or equivalent)** and comfort-domain responses; cross-modal acoustic perception emphasis.
6. **Statistical test in the source paper.** **Descriptive / survey** associations during walks; supplements the journal **Fisher / multinomial** suite (§3.4).
7. **Mode/Environment.** **Source:** **outdoor on-foot** comfort walk. **Our phases:** **WalkG + WalkU** (green vs urban corridor), walking only.
8. **Sample size (for test).** **22** bout-level comfort cells (11 per phase).
9. **Our data for method port.** Duplicate **Fisher vote–vote** family as §3.4 with CSV label **`Cureau FA 2023`** for transparency (same `h4_additional_outdoor_tests` engine; journal §3.4 remains Methods anchor).
10. **Our statistical test (closest family).** Fisher exact **per WalkG and WalkU** on ordinal comfort cross-tabs (no measured dBA term).
11. **What cannot be matched.** Conference *n* and segment timing differ; full multinomial and independent park-user tables not duplicated here.

---

### 3.6 Grapas et al. 2026 — outdoor Brussels walks (multimodal SOR)

1. **Citation.** Grapas C, Llaguno-Munitxa M, **Pisello AL**, Irajpour A. Urban chronotypes as climate vulnerability indicators: Safety-modulated bioclimatic responses and adaptive behavior across diurnal urban contexts. *Urban Climate* 2026;67:102906. doi:[10.1016/j.uclim.2026.102906](https://doi.org/10.1016/j.uclim.2026.102906). Local PDF: `Experiment papers/Urban Climate Literature/Sound - Grapas et al 2026 - Urban chronotypes climate vulnerability safety-modulated bioclimatic responses.pdf`.
2. **Objective.** Ambulatory **stimulus–organism–response** networks linking **acoustic, thermal, visual, air-quality** exposures to physiology and behavior on **Brussels walks** (safety × day/night).
3. **Experiment location.** **Brussels, Belgium** — **outdoor** urban walking routes (wearable multimodal campaign; day/night × safety strata in source).
4. **Instruments and sensors (source study).** Wearable **sound (dBA)**, **UTCI / thermal**, visual exposure, air quality, Empatica physiology, eye-tracking; GPS behaviour.
5. **Data they collected (type, timing, resolution, sample).** *n* = 18 participants, 36 walk sessions; synchronized time series and session summaries.
6. **Statistical test in the source paper.** **Bootstrap pathway strength**, **Granger-style latency**, mixed-effects on **response delays** — **not** comfort-vote × UTCI × LAeq ANOVA/LMM.
7. **Mode/Environment.** **Source:** **outdoor walk** in Brussels (day/night × high/low safety). **Our phases:** **WalkG + WalkU** as green vs urban walk bouts (**8 min**).
8. **Sample size (for test).** **11** people × 2 walk phases = **22** cells for phase-mean SOR analogue; full latency models **not** estimable on one vote per bout.
9. **Our data for method port.** Phase-mean **dBA, UTCI**, domain comfort votes, **HR / EDA**; Fig. 11 layout in `Paper3_outline_readable.md`.
10. **Our statistical test (closest family).** **Pearson** (or Spearman) **participant × phase mean** web among exposures, biomarkers, votes — **Tier 3** (`paper_rule`: exploratory *p* for layout only); **no** pathway bootstrap port.
11. **What cannot be matched.** Safety × chronotype factorial, Granger lags, 36-session design, eye-tracking graphs, full *n* = 18 Brussels cohort.

---

### 3.7 Pisello-network material panels — lab thermo-acoustic properties (×4 PDFs)

1. **Citation (bundle).** **Pisello AL** and co-authors — **measured acoustic** (transmission loss, absorption, impedance-tube metrics) **and thermal conductivity / resistance** on **building panels**: (a) stone aggregates in cool roofs; (b–c) innovative cardboard panels (×2 PDFs); (d) recycled PET prefabricated panels. Local PDFs: `Experiment papers/Anna Laura/Sound - Acoustic properties of stone aggregates used in cool roofs.pdf`; `Sound - Innovative cardboard based panels with recycled materials from the packaging industry Thermal and acoustic performance analysis.pdf`; `Sound - Experimental and numerical characterization of innovative cardboard based panels Thermal and acoustic performance analysis and life cycle assessment.pdf`; `Sound - Advancing sustainable construction through comprehensive analysis of thermal, acoustic, and environmental properties in prefabricated panels with recycled PET materials.pdf`.
2. **Objective.** Characterize **joint thermal and acoustic** performance of **materials** (not human outdoor comfort).
3. **Experiment location.** **Italy / EU materials laboratories** (Pisello-network affiliation; **indoor** acoustic–thermal bench tests on building panels — no field site).
4. **Instruments and sensors (source study).** Laboratory **acoustic** benches (impedance tube, transmission loss rigs) and **thermal** conductivity / diffusivity apparatus per paper.
5. **Data they collected.** Sample-level **sound reduction / absorption indices** vs **thermal** properties across panel types and compositions.
6. **Statistical test in the source paper.** **Regression / comparison of means** across material formulations; no human subjects.
7. **Mode/Environment.** **Source:** **indoor materials laboratory**. **Our phases:** **no mapping** — human walk data are unrelated to panel coupons.
8. **Sample size (for test).** **n/a** for questionnaire lattice (0 walk ports).
9. **Our data for method port.** **Methods catalogue only** — documents that the Pisello group **measures sound and thermal on the same specimens**; **no row** in `H4_sound_literature_tests.csv` unless a future sensitivity links phase-mean dBA to UTCI as a **toy** analogue (not recommended).
10. **Our statistical test (closest family).** **None fitted by default** — cite in thesis Methods/Discussion as **materials-science complement** to outdoor perception work (§3.1–§3.6).
11. **What cannot be matched.** No impedance-tube data, no panel build-ups, no human comfort votes; field **dBA** is **not** material transmission loss.

---

### 3.8 Moshammer 2019 — outdoor road/park walks

1. **Citation.** Moshammer H, Panholzer J, Ulbing L, Udvarhelyi E, Ebenbauer B, Peter S. Acute effects of air pollution and noise from road traffic in a panel of young healthy adults. *International Journal of Environmental Research and Public Health* 2019;16:788. doi:[10.3390/ijerph16050788](https://doi.org/10.3390/ijerph16050788). Local PDF: `Experiment papers/H4 Sound literature test/Included - Sound - Moshammer et al 2019 IJERPH acute air pollution noise road traffic panel HRV.pdf`.
2. **Objective.** Whether acute respiratory and cardiovascular reactions to everyday urban traffic air pollution occur, and whether noise can be separated from particle exposure when both come from road traffic (p. 2).
3. **Experiment location.** **Vienna, Austria** — **outdoor** busy-road vs urban-park walking loops (1 h per setting).
4. **Instruments and sensors (source study).** Grimm Portable Laser Aerosol Spectrometer 1.108 (PM2.5, PM1); miniDiSC (particle number, **6 s** averages); Brüel & Kjær type 2236 (**Leq every 15 min**); EasyOne spirometer; NObreath (exhaled NO); eMotion Faros ECG (**15-min** HRV, Kubios 2.2); blood pressure at end of each 15-min period (device not named); fixed stations (PM10, temperature).
5. **Data they collected (type, timing, resolution, sample).** *n* = 24 non-smoking students, Vienna (20 then +4 women); ≥4 walks per setting, **1 h** per walk. Settings: busy road; road + ear plugs; park; park + **65 dB** recorded traffic in headphones. BP and HRV **every 15 min** (4 periods/walk); lung function and exhaled NO at pre/post/1 h/24 h. Exposure for each CV period = **Leq of the preceding 15 min**; ECG over that 15 min; BP at period end. Descriptive LAeq: road ~56, park ~46, headphones 65, ear-plugs ~30 dB lower (p. 4).
6. **Statistical test in the source paper.** Stata 13.1 `xtreg`, random-effects GLS. Outcome in 15-min period ~ preceding 15-min Leq (+ particles; + temperature in adjusted runs). Appendix Table A2 = noise-only. Unit: 15-min period × walk × person. Example finding: SDNN −1.87 ms per dB (15-min lag), *p* = 0.001.
7. **Mode/Environment.** **Source:** **1 h outdoor walks**—**busy road**, road with earplugs, **urban park**, park with recorded traffic in headphones (Vienna). **Our phases:** **WalkU** ≈ road/traffic; **WalkG** ≈ park; **WalkG + WalkU only** (source panel walked; we do not use Bike*). **Ten-second data:** full **48 × 11** series per bout; physiology blocks may use **5 min exposure + 3 min outcome** windows within those rows.

8. **Sample size (for test).** **22** walk bouts; **1056** ten-second rows. **GLS/LMM rows:** **22** (physiology above). **Mean energy dBA:** WalkU **67.6** (11 cells), WalkG **61.7** (11). **Flag:** source **1 h×4** settings ≫ **8 min×2** routes.

9. **Our data for method port.** Input: `output/merged_all_11participants_8min.csv` + `output/empatica_files/01_empatica_rri_native.csv`. Phases: **WalkU + WalkG only** (item 6). 11 people; one row per participant×phase (8 min, **48 × 10 s** per bout). Exposure: energy-mean `ucm_SND_dBA`, **first 5 min** only. Outcomes **5–8 min**: RR, SDNN, RMSSD, LF, HF from native beats. Optional: mean `ucm_AIR_temp` on outcome window. **22** walk bouts.
10. **Our statistical test (same family, closest timing).** Noise only: `outcome_5to8min ~ noise_leq_first5min + (1|ParticipantID)`, Swamy–Arora GLS (`xtreg, re`), per 1 dB(A), Wald *z*, *p* < 0.05 as in Table A2. With temperature: add `air_temp_outcome_window`. No particles, settings, or 15/30/45/60 min lags.
11. **What cannot be matched.** No 1 h / four 15-min periods; we use **5 min exposure + 3 min outcome**. No lung function, exhaled NO, BP, or particles. No plug/headphone routes. Their Table A2 coefficients are for their panel and timing only.

---

### 3.9 Jin, Jin & Kang 2020 — outdoor squares, respondents standing/sitting

<div style="color:#c62828">


1. **Citation.** Jin Y, Jin H, Kang J. Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares. *Building and Environment* 2020;168:106517. doi:[10.1016/j.buildenv.2019.106517](https://doi.org/10.1016/j.buildenv.2019.106517). Local PDF: `Experiment papers/H4 Sound literature test/Included - Sound - Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares.pdf`.
2. **Objective.** How the thermal-acoustic environment of Harbin urban squares affects thermal, acoustic and overall comfort, and how to predict equivalent overall comfort (pp. 1–3).
3. **Experiment location.** **Harbin, Heilongjiang, China** — **outdoor urban squares** (cold continental climate; winter, transitional, and summer campaigns).
4. **Instruments and sensors (source study).** BSWA801 (LAeq, 30 s samples, 19–137 dB(A)); BES-01 globe (0.08 m), BES-02 T/RH, Kestrel 5500 wind; tripod ~1.2 m, ISO 7726 (p. 4).
5. **Data they collected (type, timing, resolution, sample).** *N* = 1,495 valid questionnaires in three squares (P1–P4 sites), winter / transitional / summer; volunteers standing or sitting; concurrent measurement. Votes: TSV (−4…+4), TCV/ACV/OCV (−3…+3). LAeq in **5 dB bands** 55–60 / 60–65 / 65–70 / 70–75 dB(A); UTCI **stress categories** by season (Tables 3–4).
6. **Statistical test in the source paper.** Two-way **ANOVA** of each vote on **LAeq level × UTCI category**, by season (Tables 5–7). Unit: one independent respondent per questionnaire. **SOURCE FORMULA:** \(Y_{k} \sim \mu + \alpha_{i}^{\mathrm{LAeq}} + \beta_{j}^{\mathrm{UTCI}} + (\alpha\beta)_{ij}^{\mathrm{LAeq}\times\mathrm{UTCI}} + \varepsilon\) for each vote \(Y_k \in \{\mathrm{TSV,TCV,ACV,OCV}\}\); fitted **by season** on **independent** questionnaires (not repeated measures).
7. **Mode/Environment.** **Source:** respondents **standing or sitting** in Harbin **urban squares** (pedestrian, not cycling). **Our phases:** **WalkG + WalkU** as square-exposure analogues (**22** cells; **no BikeG/BikeU**). **Ten-second data:** **11 × 48** per phase for objective dBA/UTCI.

8. **Sample size (for test).** **22** walk cells. **Primary ANOVA grid (dBA):** **5 dB-spaced** `sound_level` × **UTCI stress-category** `thermal_level`; many cells empty or **rank-deficient** on summer data. **Alternate encoding runs:** quartile sound × quartile UTCI via `H4_JIN$run` (see runner cell-count table in `METHODS_NOTES.md`). **Flag:** min cell **1** (<5) on some crossed tables; source **N=1,495**.

9. **Our data for method port.** `output/merged_all_11participants_8min.csv` → **WalkG + WalkU** only (item 6). One thermal / acoustic / overall comfort rating per cell (§2). **Primary block (`H4_sound_literature_test.R`):** phase energy-mean `ucm_SND_dBA` binned at **5 dB** spacing; phase-mean `ucm_UTCI` cut with **published-style stress breakpoints** (extended grid so quiet/cool bouts are retained). **Substitute encodings:** `H4_JIN$run` uses **sample quartiles** of the chosen sound column and UTCI (not source physical bands); reports **thermal, acoustic, and overall** comfort (`H4_JIN$outcomes`). Many quartile×quartile cells are empty on *n* = 22 — see `METHODS_NOTES.md`, not a silent omission.
10. **Our statistical test (same family, closest timing).** **(A) Primary dBA:** participant-blocked Type-II two-way ANOVA — `outcome ~ ParticipantID + sound_level * thermal_level` for **`thermal_comfort`**, **`acoustic_comfort`**, **`overall_comfort`** (`H4_JIN$anova_type2`). **(B) Encodings 2–4 + 15 spectral descriptors:** same ANOVA machinery via `H4_JIN$run(epochs_walk, sound)` with quartile factors. Source **TSV/TCV** outcomes map to §2 columns. Report source *p* < 0.05 where applicable.
11. **What cannot be matched.** Not 1,495 independent square respondents; three-season field design; sparse or non-estimable cells in the fitted band×category tables (not a balanced replication of Tables 5–7). **5-point comfort scores** are not relabelled as bipolar −3…+3 TCV categories.

</div>

---

### 3.10 Biel 2020 — mixed indoor/outdoor daily activity

1. **Citation.** Biel R, Danieli C, Shekarrizfard M, Minet L, Abrahamowicz M, Baumgartner J, Liu R, Hatzopoulou M, Weichenthal S. Acute cardiovascular health effects in a panel study of personal exposure to traffic-related air pollutants and noise in Toronto. *Scientific Reports* 2020;10:16703. doi:[10.1038/s41598-020-73412-6](https://doi.org/10.1038/s41598-020-73412-6). Local PDF: `Experiment papers/H1 to H4/H4 - Biel et al 2020 - Acute cardiovascular effects of air pollutants and noise.pdf`.
2. **Objective.** Acute cardiovascular responses to personal air pollution and whether personal noise confounds them (abstract).
3. **Experiment location.** **Toronto, Ontario, Canada** — **free-living** urban region (personal dosimetry; indoor/outdoor mix, May–August).
4. **Instruments and sensors (source study).** DiSCmini (UFP, 1 s); MicroAeth (BC); Brüel & Kjær 4448 dosimeter (**dBA, 1 min**); HOBO Ta/RH; Space Labs BP; EndoPAT; Holter; fixed-site PM2.5/NO2/O3 hourly (p. 7).
5. **Data they collected (type, timing, resolution, sample).** *n* = 46 adults, Toronto, May–August 2016; up to 7 h/day, mean 4.9 h monitored; HRV Holter every **30 min**, HRV from **last 5 min** of each 30-min window; baseline and post-exposure BP/RHI same day.
6. **Statistical test in the source paper.** LMM with subject random intercepts **and slopes**, **AR(1)** on repeated 30-min windows; `g(Y) ~ personal_noise + Ta` (+ pollutants, RH/caffeine/alcohol if ≥10% coefficient change).
7. **Mode/Environment.** **Source:** **free-living daytime** in Toronto (indoor/outdoor mix; personal dosimeter on **walk, transit, other activities**). **Our phases:** **all four**—**WalkU, WalkG, BikeU, BikeG**—because the source mixed mobility modes (**11** per phase). **Ten-second data:** phase aggregates or **2-min windows** over rows inside each 8-min bout.

8. **Sample size (for test).** **All four phases 44** cells (**11** each). **2-min windows:** up to **~3** per bout ⇒ **≤132** correlated sub-rows (not independent). **Flag:** no full-day panel.

9. **Our data for method port.** **All four phases** (item 6). Input: merged 11 + Empatica columns. **Phase-level set:** one row per participant×phase; exposure = energy-mean `ucm_SND_dBA`; covariate = phase-mean `ucm_AIR_temp`, optional `ucm_AIR_RH`. Outcomes phase-mean: HR, SDNN, RMSSD; ln phase-mean LF, HF, LF/HF (`H4_BIEL$outcomes`). **Repeated-window set (closer timing):** consecutive **2-min** windows inside each 8-min bout (≥60% of expected 10-s rows per window); window energy-mean dBA and air temperature; same outcomes (`H4_BIEL_REPEATED`).
10. **Our statistical test (closest family).** (`H4_BIEL` / `H4_BIEL_REPEATED`.) **Phase LMM:** `Y ~ noise + air_temp_c [+ air_rh if RH changes noise β by ≥10%] + (1|ParticipantID)`; REML; noise coefficient scaled **per IQR** of phase dBA (their personal Leq scale). **Repeated LMM:** same fixed effects with **`corCAR1(~ window_index | ParticipantID)`** and random intercept (AR(1) analogue to their 30-min panels). Log-transform LF/HF/LF:HF as in helper. No random **slopes**; no pollutant terms (UFP/BC absent).
11. **What cannot be matched.** No 30-min Holter windows, no baseline/post RHI or office BP, no caffeine/alcohol diaries, no MicroAeth/DiSCmini, no day-long dosimetry beyond one 8-min bout per phase.

---

### 3.11 Rodrigues 2026 — outdoor walking

1. **Citation.** Rodrigues AL, da Conceição MSA, Ramusga RAL, Lima Azevedo C, Morgado P. The influence of urban context on emotions and bodily responses during walking. *Journal of Urban Health* 2026;103:344–356. doi:[10.1007/s11524-025-01051-1](https://doi.org/10.1007/s11524-025-01051-1). Local PDF: `Experiment papers/H4 Sound literature test/Included - Sound - Rodrigues2026 - Repeated hotspot exposures Lisbon walks LMM.pdf`.
2. **Objective.** How urban features (noise, heat, vegetation, infrastructure) relate to physiology and post-trip emotion during everyday walking; H2: stressors increase physiological activation (pp. 345, 348).
3. **Experiment location.** **Lisbon, Portugal** — **outdoor** everyday walking trips (app-logged urban context).
4. **Instruments and sensors (source study).** Empatica E4 (HR, RMSSD, EDA, skin T; HRV in **10 s** windows, trip summaries); X-ing app + GPS; **Lden noise map** in 25 m buffer (mean/min/max/SD); IPMA daily weather (pp. 347–348).
5. **Data they collected (type, timing, resolution, sample).** *n* = 90 residents, 2,207 walking trips, Aug–Dec 2024; trip kept if ≥2 min valid sensor contact. Predictors standardised; separate **Noise** and **Temperature** thematic blocks, 27 physiological indicators.
6. **Statistical test in the source paper.** Trip-level **MixedLM**, participant random intercept; each block tested separately; retain if *p* < 0.05 and |β| > 0.1. Noise block: e.g. physiology ~ z(max noise) + z(SD noise). No sound×temperature in H2 blocks.
7. **Mode/Environment.** **Source:** **walking trips** in urban Lisbon (app-logged). **Our phases:** **WalkU + WalkG only** (**22** trips; **no cycling**). **Ten-second data:** **48 × 11** per trip for trip-level min/max/SD summaries.

8. **Sample size (for test).** **22** walking trips (**WalkG 11**, **WalkU 11**); **11/11** people with both. **LMM rows:** **22**.

9. **Our data for method port.** WalkU + WalkG only: **22 trips**, 11 people, 8-min bout → trip summaries (mean/min/max/SD HR, HRV, wrist T). Sound: personal `ucm_SND_dBA` trip max and SD. Temperature: trip max and mean `ucm_AIR_temp`. Separate noise and temperature blocks as in source.
10. **Our statistical test (same family, closest timing).** `Y_trip ~ z(dBA_max) + z(dBA_SD) + (1|participant)` and `Y_trip ~ z(Ta_max) + z(Ta_mean) + (1|participant)`; Wald *z*; source rule *p* < 0.05 and |β| > 0.1 kept for reporting.
11. **What cannot be matched.** Worn dBA is not mapped Lden; trip weather is not daily station summary; cycling phases excluded; no post-trip emotion app items.

---

### 3.12 Kraus 2013 — mixed indoor/outdoor daily life

1. **Citation.** Kraus U, Schneider A, Breitner S, Hampel R, Rückerl R, Pitz M, Geruschkat U, Belcredi P, Radon K, Peters A. Individual daytime noise exposure during routine activities and heart rate variability in adults. *Environmental Health Perspectives* 2013;121:607–612. doi:[10.1289/ehp.1205606](https://doi.org/10.1289/ehp.1205606). Local PDF: `Experiment papers/Sound_evidence/Sound - Individual daytime noise exposure during routine activities and heart rate variability in adults - a repeated measures study.pdf`.
2. **Objective.** Association between individual daytime noise and HRV as a cardiovascular-risk mechanism (p. 607).
3. **Experiment location.** **Augsburg, Bavaria, Germany** — **routine daytime** activities (collar dosimetry; indoor/outdoor mix).
4. **Instruments and sensors (source study).** Mortara H12 Holter; Larson Davis Spark 703 collar dosimeter (A-weighted Leq, **5-min** aligns); particle counter (p. 608).
5. **Data they collected (type, timing, resolution, sample).** *n* = 110 adults, Augsburg; up to 6 h recordings, ~20,000 **5-min segments**; activity diaries; piecewise Leq at **65 dB(A)**; lags 0–15 min; compound symmetry + lagged outcome.
6. **Statistical test in the source paper.** Additive mixed models; log outcomes except HR; activity and time trends; HRV models adjust for HR; SAS 9.2.
7. **Mode/Environment.** **Source:** **routine daytime activities** (collar dosimeter; walking, home, work, etc.). **Our phases:** **all four phases**; **PhaseID** encodes **walk vs cycle** as activity analogue. **Ten-second data:** **5-min intervals** built from rows inside each bout when interval coverage rules are met.

8. **Sample size (for test).** **44** phase cells. **dBA ≥65 dB(A):** **23 yes / 21 no**. Walk **22** / Bike **22**. **5-min interval rows:** ≤**44** (often **0–1** per bout). **Flag:** no 15-min lags.

9. **Our data for method port.** Input: merged 10-s rows + `01_empatica_rri_native.csv`. Build **5-min interval** records inside each 8-min bout when ≥⅔ of interval 10-s rows exist (`H4_KRAUS$interval_frame`): interval energy-mean dBA as **Leq**; outcomes HR (raw), SDNN, ln LF/HF/LF:HF from native beats at interval end. Attach `study_day`, simplified **activity** from `PhaseID` (walk vs cycle). Only **lag 0** and one interval per bout are reliably populated (no 15-min lag chain).
10. **Our statistical test (closest family).** (`H4_KRAUS$run`.) Additive **mixed model** per outcome: piecewise **Leq at 65 dB(A)** (`L0_below65_per5`, `L0_above65_per5` per 1 SD increase above knot); optional **lag-0** duplicate; **time trend** chosen by AIC among linear/poly/spline forms on interval index; **`weekday`** if it improves AIC vs base; **lagged outcome** term only if a prior interval exists (usually omitted here). HR untransformed; HRV powers log-transformed. SAS-style compound symmetry approximated via **`lme` random intercept + correlation structure** as coded in helper; Wald *t* on sound terms.
11. **What cannot be matched.** No 6 h collar dosimeter with 20 000 five-minute segments, no activity diary codes, no lags 5–15 min, no particle adjustment, no prior-day rest reference.

---

### 3.13 Korpilo 2024 — outdoor visits to nearby forest/beach/park

1. **Citation.** Korpilo S, Nyberg E, Vierikko K, Ojala A, Kaseva J, Lehtimäki J, Kopperoinen L, Cerwén G, Hedblom M, Castellazzi E, Raymond CM. Landscape and soundscape quality promote stress recovery in nearby urban nature. *Urban Forestry & Urban Greening* 2024;95:128286. doi:[10.1016/j.ufug.2024.128286](https://doi.org/10.1016/j.ufug.2024.128286).
2. **Objective.** The authors asked whether stress recovery after exposure to nearby urban nature depends on stop type (forest, beach, park) and on measured landscape and soundscape quality.
3. **Experiment location.** **Helsinki metropolitan area, Finland** — **outdoor** visits to nearby urban **forest, beach, and park** stops.
4. **Instruments and sensors (source study).** A smart ring recorded electrodermal activity at 3 Hz. A Zoom H4n Pro captured 5-minute sound clips (44.1 kHz). They also used a Flow particulate monitor, GPS, and FMI weather data at 10-minute resolution. Soundscape quality used the Normalized Difference Soundscape Index (NDSI), with anthropogenic sound in 1–2 kHz and biophonic sound in 2–8 kHz. The methods text we checked does not name a separate sound level meter.
5. **Data they collected (type, timing, resolution, sample).** Forty-five participants made group walks with planned visits to three environments: forest, beach, and park. Each person contributed restorative outcome (ROS) scores and an EDA-derived stress index. In Model 1, stop type was the main predictor; Model 2 added continuous measures, including NDSI.
6. **Statistical test in the source paper.** Generalized linear mixed models: beta regression with logit link for the EDA outcome and Gaussian models for ROS; Kenward–Roger adjustment for degrees of freedom. In the source, predictors could enter the model when *p* < 0.10.
7. **Mode/Environment.** **Source:** **outdoor group walks** with planned stops at **forest, beach, park**. **Our phases:** **WalkG** ≈ forest/park/nature stop; **WalkU** ≈ more urban/traffic context; **WalkG + WalkU only**. **Ten-second data:** **11 × 48** per walk phase (one phase cell per person×route).

8. **Sample size (for test).** **22** walk cells. **WalkG** mean dBA **61.7**; **WalkU** **67.6**. **LMM:** **22** rows.

9. **Our data for method port.** One row per **WalkG or WalkU** bout (item 6): **ln(mean `empatica_eda_tonic`)** when >0; **NDSI analogue** = phase mean of \((f_{2000–20k} - f_{200–2k})/(f_{2000–20k} + f_{200–2k})\) from merged frequency proportions (or substitute each of the **four sound encodings** for `sound_x`). Covariates: phase-mean `ucm_AIR_temp`, `ucm_AIR_RH`; route (**WalkG** vs **WalkU**). No ROS questionnaire.
10. **Our statistical test (closest family).** (`H4_KORPILO$run`.) **Gaussian LMM** (source used **beta-logit** on a normalised stress index): `eda_ln ~ sound_x + air_temp_c + air_rh + PhaseID + (1|ParticipantID)`, REML; report Wald *t* on `sound_x` (NDSI or encoding). Repeat with dBA, corridor, vehicle share, each class proportion. Source also modelled **ROS** with Kenward–Roger — not replicated (no ROS).
11. **What cannot be matched.** No randomised forest/beach/park stops or group order; no Zoom H4n stop recordings; no beta-logit on their normalised EDA index; PRS/ROS not collected.

---

### 3.14 Chen et al. 2023 — outdoor sensory walks / stops

<div style="color:#c62828">


1. **Citation.** Chen Y, Liu F, Lin X, Liu J, Chen Z, Shi K, Li J, Dong J. Combined effects of the thermal-acoustic environment on subjective evaluations in urban park based on sensory-walking. *Forests* 2023;14:1161. doi:[10.3390/f14061161](https://doi.org/10.3390/f14061161). Local PDF: `Experiment papers/Sound_evidence/Chen2023_Sensory_walking_thermal_acoustic.pdf`.
2. **Objective.** Thermal-acoustic effects on park thermal, acoustic and overall evaluations (abstract).
3. **Experiment location.** **Fuzhou, Fujian, China** — **outdoor** urban park (sensory-walking stops; humid subtropical summer).
4. **Instruments and sensors (source study).** Kestrel 5500, BES-01/02, BSWA801; **LAeq over continuous 5 min** at each stop, ~1.2 m (§2.4–2.6).
5. **Data they collected (type, timing, resolution, sample).** *n* = 30 × **12 sites** = 360 questionnaires; 5-min stop; respondent **ranking of dominant sound source**; many 5-point acoustic adjective scales + TSV/TCV/UTCI.
6. **Statistical test in the source paper.** **Repeated-measures ANOVA** (SPSS 22): each subjective rating (TSV, TCV, ACV, OCV, acoustic adjectives) as dependent variable; within-subject factors **UTCI category** and **LAeq class** (and **dominant sound-source rank** where applicable); **Mauchly** sphericity test; **Greenhouse–Geisser** or **Huynh–Feldt** correction when sphericity fails; post hoc comparisons at *p* < 0.05 (§2.7). **SOURCE FORMULA:** **within-person factorial** `Rating ~ UTCI_class × LAeq_class` (+ sound-source rank where reported) = classic **sound × thermal interaction** on comfort; 30 people × 12 stops ⇒ correlated repeated measures.
7. **Mode/Environment.** **Source:** **sensory walking** with **5-min stops** along urban park paths (12 sites). **Our phases:** **WalkG + WalkU** (**park walking**; **no Bike***). **Ten-second data:** **22** questionnaire cells; continuous exposure from **48 × 11** rows per phase.

8. **Sample size (for test).** **22** cells; **11/11** repeated walk contexts. **10 s:** **1056** rows. **Flag:** not **12 sites×30** respondents.

9. **Our data for method port.** **22** WalkG+WalkU cells (item 6), 11 people; outcomes `questionnaire_thermal_comfort_1_5`, `questionnaire_acoustic_comfort_1_5`, `questionnaire_current_comfort_1_7`; phase-mean `ucm_UTCI`, energy-mean `ucm_SND_dBA`; **`rural_natural_proportion`** as dominant-natural share (no ranked source-type factor).
10. **Our statistical test (closest family).** (`h4_additional_outdoor_tests` → Chen block.) **Adapted LMM** (not their RM-ANOVA): `rating ~ z(UTCI) * z(dBA) + z(natural_share) + (1|ParticipantID)`, REML; Wald *t* on `utci_z`, `dba_z`, interaction. **Encoding variants:** replace `dba_z` with z-scored corridor, vehicle-over-rural share, or each YAMNet proportion (interaction `utci_z * sound_z`, no natural-share term). Labelled **adaptation** in output because factorial RM-ANOVA with 12 sites is not structurally estimable on 4 phases.
11. **What cannot be matched.** No 12 stop sites × 30 participants; no five-point acoustic-descriptor battery; no Huynh–Feldt on a balanced site×sound factorial. **TSV** source outcomes use §2 subjective thermal column.

</div>

---

### 3.15 Ueberham et al. 2019 — outdoor cycling

1. **Citation.** Ueberham M, Schlink U, Dijst M, Weiland U. Cyclists' multiple environmental urban exposures—comparing subjective and objective measurements. *Sustainability* 2019;11:1412. doi:[10.3390/su11051412](https://doi.org/10.3390/su11051412). Local PDF: `Experiment papers/Sound_evidence/Ueberham2019_Cyclists_multiple_environmental_exposures.pdf`.
2. **Objective.** Compare cyclists' objective vs perceived noise, particles and heat (abstract).
3. **Experiment location.** **Leipzig, Saxony, Germany** — **outdoor** urban cycling routes.
4. **Instruments and sensors (source study).** Dylos PNC (60 s); HOBO temperature; smartphone + Edutige mic, noise and heat **every 2 s** (§2.2).
5. **Data they collected (type, timing, resolution, sample).** *n* = 66 cyclists, Leipzig; 730 routes; post-trip **perceived noise / PNC / heat** (1–5), not comfort.
6. **Statistical test in the source paper.** **Spearman** ρ between **objective route means** (personal noise dBA, particle counts, temperature) and **post-trip subjective ratings** of noise intensity, particle annoyance, and heat (1–5) (§2.3). **Ordinal (proportional odds) regression** of subjective class on objective exposure class after categorising both into ordered groups.
7. **Mode/Environment.** **Source:** **cyclists only** (Leipzig route archive). **Our phases:** **BikeU + BikeG only**—**do not use WalkG or WalkU**. **Ten-second data:** **11 × 48** per cycling phase (**22** cells).

8. **Sample size (for test).** **BikeG 11 + BikeU 11 = 22** cells; **11/11** cyclists both routes. Mean dBA **BikeU 71.6** vs **BikeG 60.6**. **Spearman per phase:** **n=11** each.

9. **Our data for method port.** No subjective noise/heat **intensity** items. **Partial analogue:** **22** cells (**BikeU + BikeG** only; item 6) with objective energy-mean `ucm_SND_dBA`, `ucm_UTCI`, `ucm_AIR_temp`; subjective **`questionnaire_acoustic_comfort_1_5`** and **`questionnaire_thermal_comfort_1_5`** (comfort, not intensity). **BikeU** vs **BikeG** as urban vs green route.
10. **Our statistical test (closest family).** **Spearman** `cor.test` within each cycling phase (`H4_sound_literature_test.R`): phase-mean **`dba`** vs **`acoustic_comfort`**; phase-mean **`utci`** vs **`thermal_comfort`** — **BikeG** and **BikeU** separately (*n* = 11 each). Source **polr** on intensity scales **not fitted** (intensity items not collected).
11. **What cannot be matched.** No cyclists-only sample, no Dylos PNC, no 730 route archive, no perceived loudness/PNC/heat intensity scales; comfort votes are not the source outcomes.

---

### 3.16 Li, Li & Wang 2025 — outdoor greenway walking

<div style="color:#c62828">


1. **Citation.** Li Y, Li L, Wang W. Enhancing autumn greenway walking experience: noise and thermal environment. *Int. J. Biometeorol.* 2025;69:35–50. doi:[10.1007/s00484-024-02790-7](https://doi.org/10.1007/s00484-024-02790-7). Local PDF: `Experiment papers/Sound_evidence/Sound - Li2025 - autumn greenway noise thermal walking.pdf`.
2. **Objective.** Combined noise and thermal effects by walking state (arrival vs after 5-min stay) on TSV/TCV/OES (abstract).
3. **Experiment location.** **Beijing, China** — **outdoor** urban **greenway** (autumn walking stops).
4. **Instruments and sensors (source study).** HOBO / Delta OHM thermal; Smart Sensor AS-824 SPL at 1.5 m, **1-min** (pp. 38–39). Variables include **SLV** (subjective loudness) and **ASL**.
5. **Data they collected (type, timing, resolution, sample).** 22 respondents, 11 stops, questionnaire **on arrival and again after 5 min** at each stop; autumn Beijing greenway.
6. **Statistical test in the source paper.** **Binned regressions** (linear and quadratic) of **objective SPL (ASL)** and **thermal indices** on **TSV, TCV, and outdoor emotional state (OES)** at **stop arrival** and again **after 5-min stay** at each of 11 greenway stops; compares curve shapes between arrival and departure (p. 39). **SLV** (subjective loudness) enters parallel models. **SOURCE FORMULA (interaction branch):** \(Y \sim \mathrm{SPL} + \mathrm{UTCI} + \mathrm{SPL}\times\mathrm{UTCI} + \mathrm{SPL}^2\) (and parallel **SLV × thermal** models); **22 walkers × 11 stops × 2 times** = repeated exposure ladder (not independent *n*).
7. **Mode/Environment.** **Source:** **walking** along an autumn **greenway** (11 stops). **Our phases:** **WalkG** (greenway/green corridor) primary; **WalkU** as urban-walking contrast; **walking only**. **Ten-second data:** **48 × 11** per included walk phase.

8. **Sample size (for test).** **22** walk cells. **dBA ≥60:** **18 yes / 4 no**. **dBA ≥65:** **12 yes / 10 no**.

9. **Our data for method port.** Single comfort rating per 8-min bout (no arrival/departure pair). Phase-mean `ucm_SND_dBA` (ASL analogue), `ucm_UTCI`, outcomes thermal/acoustic/current comfort. **11 people × 2 walk phases = 22** cells (WalkG + WalkU; item 6).
10. **Our statistical test (closest family).** **Arrival-only analogue:** `thermal_comfort ~ utci + dba + I(dba^2)` and `thermal_comfort ~ utci * dba` with **`(1|ParticipantID)`** LMM on phase cells; duplicate for acoustic and overall comfort. Compare linear vs quadratic via nested-model *F* or AIC. **Cannot fit departure or SLV branch.**
11. **What cannot be matched.** No 11-stop greenway tour, no paired before/after 5-min stay, no **OES** or **SLV**, no autumn Beijing campaign (TSV/TCV branches use §2 on arrival-only cells).

</div>

---

### 3.17 Qin et al. 2024 — outdoor Xi’an campus, sound × humidity

1. **Citation.** Qin Z, Lu B, Jing W, Yin Y, Zhang L, Wang X, Luo W, Zhang J, Qiu J, Dong Y. Creating comfortable outdoor environments: sound, humidity, and thermal comfort. *Urban Climate* 2024;55:101967. doi:[10.1016/j.uclim.2024.101967](https://doi.org/10.1016/j.uclim.2024.101967). Local PDF: `Experiment papers/Sound_evidence/Sound - Qin2024 - sound humidity outdoor thermal comfort cold regions.pdf`.
2. **Objective.** How sound and humidity together affect outdoor thermal comfort (abstract).
3. **Experiment location.** **Xi'an, Shaanxi, China** — **outdoor** university campus (cold-region / northwest China field questionnaires).
4. **Instruments and sensors (source study).** Mobile station 1.2 m: noise0501, wind0501, globe/humidity; ≥20 sound readings averaged per site (§2.2).
5. **Data they collected (type, timing, resolution, sample).** 1,603 valid questionnaires; RH grades and sound **20–40 / 40–60 / 60–80 dB(A)** bins; 7-point TSV/TCV; PET (§2.3–3).
6. **Statistical test in the source paper.** **Pearson/Spearman Table 2** between meteorology, SPL, RH and TSV/TCV. **Descriptive cell means:** mean TSV (and PET) tabulated in **humidity grades** (e.g. 25–40, 40–55, 55–70, 70–85%) × **sound grades** (20–40, 40–60, 60–80 dB(A)) on pooled site questionnaires (§3). No single mixed model with continuous interaction in the main text we replicate.
7. **Mode/Environment.** **Source:** **outdoor campus** field questionnaires (pedestrians). **Our phases:** **WalkG + WalkU** (**22** cells; **no bikes**). **Ten-second data:** **11 × 48** per phase.

8. **Sample size (for test).** **22** walk cells; RH and dBA defined on each. **LMM:** **22** rows.

9. **Our data for method port.** **22** WalkG+WalkU cells (item 6): **`questionnaire_thermal_comfort_1_5`** (TCV and **TSV** source outcomes per §2), phase-mean `ucm_SND_dBA`, `ucm_AIR_RH`, **`ucm_PET`**. Summer field only.
10. **Our statistical test (closest family).** (`H4_sound_literature_helpers.R` → `h4_scopus_outdoor_tests` / Qin; Pearson rows in `H4_sound_literature_test.R`.) **Primary adaptation:** `thermal_comfort ~ z(sound) * z(RH) + (1|ParticipantID)` for each of the **four sound encodings** (REML LMM on **22** bout rows with participant random intercept). **Table 2 analogue (Pearson):** **within WalkG and within WalkU separately** (*n* = 11 people each)—**not** a literal copy of Qin’s pooled **1,603** independent questionnaires. **Descriptive bin means** (RH × dBA quartiles on walk bouts) when quartile cells *n* < 5.
11. **What cannot be matched.** No 1 603 independent campus visitors; bin boundaries differ from Xi’an cold-region campaign.

---

### 3.18 Mohammadzadeh, Karimi & Brown 2023 — outdoor El Goli park

<div style="color:#c62828">


1. **Citation.** Mohammadzadeh N, Karimi A, Brown RD. The influence of outdoor thermal comfort on acoustic comfort of urban parks. *Building and Environment* 2023;228:109884. doi:[10.1016/j.buildenv.2022.109884](https://doi.org/10.1016/j.buildenv.2022.109884). Local PDF: `Experiment papers/Sound_evidence/Sound - Mohammadzadeh2023 - thermal on acoustic comfort urban parks.pdf`.
2. **Objective.** How thermal comfort dimensions affect acoustic comfort by plant community (abstract).
3. **Experiment location.** **Tabriz, East Azerbaijan, Iran** — **outdoor** El Goli **urban park**.
4. **Instruments and sensors (source study).** ST-885 LAeq **5 min** at 1.2 m; Kestrel 5400 globe; logger at 1.7 m (§2.2).
5. **Data they collected (type, timing, resolution, sample).** 300 questionnaires; TSV, TCV, **soundscape quality, reported loudness**, % natural dominant sound — not generic AC alone (§2.3).
6. **Statistical test in the source paper.** **Pearson** (and linear **regression**) relating **TSV, TCV, PET** to **acoustic comfort vote, soundscape quality, reported loudness, % natural dominant sound**, and measured **LAeq** and **UTCI/PET**, **stratified by plant community** type in El Goli park (§2.5). **SOURCE FORMULA (measured joint exposure — H4 port):** \(\mathrm{ACV} \sim \mathrm{UTCI} + \mathrm{LAeq} + \mathrm{UTCI}\times\mathrm{LAeq}\) (continuous product in our LMM; source tables emphasise correlations and **per-stratum** regressions on **300** independent park visitors).
7. **Mode/Environment.** **Source:** **outdoor urban park** (El Goli) on foot. **Our phases:** **WalkG** primary (park/green); **WalkU** as urban corridor comparison; **walking only**. **Ten-second data:** per **WalkG/WalkU** bout (**48 × 11**).

8. **Sample size (for test).** **WalkG 11 + WalkU 11 = 22** cells for Pearson/LMM.

9. **Our data for method port.** Outcomes: `questionnaire_acoustic_comfort_1_5` (only generic AC collected — not SQ/RL/%RNDS). Predictors: `questionnaire_thermal_comfort_1_5`, phase-mean `ucm_UTCI`, energy-mean `ucm_SND_dBA`. **WalkG** and **WalkU** (item 6) as coarse site/plant analogues (not shrub vs lawn).
10. **Our statistical test (closest family).** (`H4_sound_literature_helpers.R` → `h4_scopus_outdoor_tests` / Mohammadzadeh; Pearson in `H4_sound_literature_test.R`.) **(a)** `acoustic_comfort ~ z(UTCI) + (1|ParticipantID)` — thermal driver of AC. **(b)** `acoustic_comfort ~ thermal_comfort + (1|ParticipantID)` — vote-to-vote. **(c)** `acoustic_comfort ~ z(UTCI) * z(dBA) + (1|ParticipantID)` — measured sound × thermal (dBA encoding; Chen duplicates for other encodings omitted here). **Pearson** AC vs dBA and AC vs UTCI **per walk phase** (WalkG *n* = 11, WalkU *n* = 11)—independence analogue aligned with §3.21 Xu, **not** Mohammadzadeh’s pooled field tables across hundreds of unrelated visitors or their plant-community strata.
11. **What cannot be matched.** No soundscape-quality or loudness items, no % natural-dominant sound, no three plant-community strata; default block uses **UTCI** (not a full reproduction of source **PET–TSV** Pearson strata).

</div>

---

### 3.19 Gao & Zhu 2025 — outdoor greenway restoration

<div style="color:#c62828">


1. **Citation.** Gao M, Zhu X. Thermal-acoustic environments and psychological restoration on urban greenways. *Building and Environment* 2025;282:113269. doi:[10.1016/j.buildenv.2025.113269](https://doi.org/10.1016/j.buildenv.2025.113269). Local PDF: `Experiment papers/Sound_evidence/Sound - GaoZhu2025 - thermal-acoustic psychological restoration greenways.pdf`.
2. **Objective.** Link thermal-acoustic environments to psychological restoration (abstract).
3. **Experiment location.** **Shenzhen, Guangdong, China** — **outdoor urban greenways** (summer field questionnaires; dense subtropical coastal city).
4. **Instruments and sensors (source study).** Kestrel 5500, BES-01/02, NL-52A at 1.5 m; LAeq in **5 dB classes** 55–75 dB(A) (§3.2–3.3).
5. **Data they collected (type, timing, resolution, sample).** *n* = 342; **ROS** (−2…+2, six items); TSV/TCV/ASV/ACV; UTCI categories.
6. **Statistical test in the source paper.** **Multiple regression / weighted regression** of **ROS** (−2…+2, six items) on **UTCI** and **LAeq class** (5 dB bins 55–75 dB(A)). **Two-way ANOVA** on ROS by **UTCI stress category × LAeq class**. **Veto probability:** proportion of cases where thermal or acoustic discomfort blocks overall restoration when the other domain is comfortable (source paper §3.5). **SOURCE FORMULA:** \(\mathrm{ROS} \sim \mathrm{UTCI} + \mathrm{LAeq\_class} + \mathrm{UTCI}\times\mathrm{LAeq\_class}\) (ANOVA) and weighted regression with both factors; **342** independent greenway respondents.
7. **Mode/Environment.** **Source:** **on-foot** survey along an **urban greenway**. **Our phases:** **WalkG + WalkU**; **no cycling phases**. **Ten-second data:** **22** phase-mean cells (11 people × 2 walk bouts).

8. **Sample size (for test).** **22** walk cells. **Low thermal comfort (TC≤3):** **5 yes / 17 no**. **Low acoustic (AC≤3):** **10 yes / 12 no**. **Both low:** **4**; **TC low only:** **1**; **AC low only:** **6**; **neither low:** **11**. **Flag:** veto/cross-tab cells **<5**.

9. **Our data for method port.** **WalkG + WalkU** bouts (item 6). **PRS-11** subscales (`questionnaire_prs11_*_mean_1_5`) and their **four-scale mean** as ROS substitute. Phase-mean `ucm_UTCI`, energy-mean `ucm_SND_dBA`. Overall/thermal/acoustic comfort for veto analogue.
10. **Our statistical test (closest family).** (`H4_sound_literature_helpers.R` → `h4_scopus_outdoor_tests` / Gao.) **(a)** LMM: `PRS_subscale ~ z(UTCI) * z(sound) + (1|ParticipantID)` per subscale and mean, **four encodings**. **(b)** Participant-blocked **two-way ANOVA** on PRS mean with **sample quartile** LAeq and UTCI factors (`H4_JIN$anova_type2` machinery). **(c)** Veto analogue: cross-tab **low thermal comfort (≤3)** vs **low acoustic comfort (≤3)** vs PRS mean; descriptive only (small *n*).
11. **What cannot be matched.** ROS (−2…+2) is not PRS-11; no source LAeq 5 dB bands or UTCI stress table; no 342 independent greenway respondents.

</div>

---

### 3.20 Wu, Yuan, Xue & Yan 2025 — outdoor Zhangjiakou parks

<div style="color:#c62828">


1. **Citation.** Wu X, Yuan C, Xue H, Yan Y. Comprehensive effects of thermal and acoustic environments on overall comfort in urban parks of cold regions. *Energy & Buildings* 2025;347:116329. doi:[10.1016/j.enbuild.2025.116329](https://doi.org/10.1016/j.enbuild.2025.116329). Local PDF: `Experiment papers/Sound_evidence/Sound - Wu2025 - thermal acoustic overall comfort cold-region parks.pdf`.
2. **Objective.** Combined thermal and acoustic effects on subjective evaluations in a cold-region park (abstract).
3. **Experiment location.** **Zhangjiakou, Hebei, China** — **outdoor urban parks** (cold-region; multi-season campaign).
4. **Instruments and sensors (source study).** Yigu weather monitor, Jianda Renke globe, BSWA309; thermal **1 min**, sound **10 s** summarised in **10-min** cycles; questionnaires near hourly acoustic cycle (§2.2.1).
5. **Data they collected (type, timing, resolution, sample).** 798 responses, three seasons; TSV (9-point), TCV/ACV/**OCV** (7-point); UTCI per respondent; zone sound-type labels (§2.2).
6. **Statistical test in the source paper.** **Separate additive regressions** (Eqs 1 & 4): OCV ~ UTCI + LAeq; OCV ~ TCV + ACV; by season (§2.4). Elsewhere the source also uses **LAeq≥60 dB(A) × UTCI** and **sound-type × UTCI** (we fit those as **separate adaptation rows**, not as extensions of Eqs 1 & 4). **SOURCE FORMULA (interaction rows):** \(\mathrm{OCV}/\mathrm{TC} \sim \mathrm{UTCI} \times \mathbb{1}(\mathrm{LAeq}\ge 60\ \mathrm{dB(A)})\); factorial **UTCI × acoustic zone type**; **798** questionnaires, **3 seasons**, cold-region parks.
7. **Mode/Environment.** **Source:** **pedestrians in urban parks** (cold-region field campaign). **Our phases:** **WalkG + WalkU** (**22** cells; **no bikes**). **Ten-second data:** **48 × 11** per walk phase.

8. **Sample size (for test).** **22** walk cells. **dBA ≥60:** **18 yes / 4 no**.

9. **Our data for method port.** **22** WalkG+WalkU cells (item 6), 11 people. `questionnaire_current_comfort_1_7`, phase-mean `ucm_UTCI`, phase energy-mean `ucm_SND_dBA`, thermal and acoustic comfort columns.
10. **Our statistical test (same family, closest timing).** **Published pair (runner):** Model A `OC ~ utci + dBA + (1|ParticipantID)`; Model B `OC ~ thermal_comfort + acoustic_comfort + (1|ParticipantID)` — raw units, participant intercept, *p* < 0.05. **Adaptation rows** (`h4_scopus_outdoor_tests` / Wu, §1.1): `OC ~ z(UTCI) + z(sound)` for encodings 1–4; `TC ~ I(dBA≥60) × z(UTCI)`; median-split high-sound × UTCI for encodings 2–4. Report each block with its own source-style *p*.
11. **What cannot be matched.** No three-season split; no passers-by independent sample; winter/transitional cells absent.

</div>

---

### 3.21 Xu et al. 2026 — outdoor Xi’an plaza thresholds

<div style="color:#c62828">


1. **Citation.** Xu L, Jing W, Ding W, He J, Ge Z, Ai Y. Threshold-based multi-scale analysis of thermal-acoustic comfort in urban public spaces. *Environ. Dev. Sustain.* (2026). doi:[10.1007/s10668-026-08213-4](https://doi.org/10.1007/s10668-026-08213-4). Local PDF: `Experiment papers/Sound_evidence/Sound - Xu2026 - threshold thermal-acoustic urban public spaces.pdf`.
2. **Objective.** Thresholds and heterogeneity in thermal-acoustic comfort (abstract).
3. **Experiment location.** **Xi'an, Shaanxi, China** — **outdoor urban public plaza** (pedestrian questionnaires).
4. **Instruments and sensors (source study).** noise0501, wind0501, globe/humidity, bolometer at 1.5 m; ≥20 SPL readings averaged per questionnaire window (§3.2.1).
5. **Data they collected (type, timing, resolution, sample).** 975 valid plaza questionnaires; 7-point TSV/TCV/ASV/ACV; piecewise/CART/SHAP also in source (§3.3–6).
6. **Statistical test in the source paper (replicated part).** **Section 4.1 / Table 3: Pearson** correlation of measured sound with TSV and AC votes. Threshold/CART/SHAP blocks are **not** replicated here. **SOURCE FORMULA (interaction — adaptation row):** \(\mathrm{TC} \sim \mathbb{1}(T_a>32\,^\circ\mathrm{C}) \times \mathbb{1}(\mathrm{SPL}>65\ \mathrm{dB})\) on **975** plaza questionnaires (full 2×2 kept; no row dropping); piecewise/CART elsewhere in paper.
7. **Mode/Environment.** **Source:** **pedestrians** in **urban public plaza** (Xi'an). **Our phases:** Pearson/stratified tests **within WalkU and within WalkG** (**walking only**; **not BikeU/BikeG**). **Ten-second data:** **11 participants × 48 rows** per phase analysed.

8. **Sample size (for test).** By-phase Pearson: **WalkU n=11**, **WalkG n=11**. **All 44 core cells — `airt_c>32`:** **1 yes / 43 no**; **dBA>65:** **23 yes / 21 no**; **both true:** **1 yes / 43 no**. **Walk only `airt_c>32`:** **0/22**. **Flag:** interaction **not estimable** (both true **1**).

9. **Our data for method port.** Within each **WalkU** and **WalkG** (item 6): Pearson `ucm_SND_dBA` (phase mean) vs thermal comfort and vs acoustic comfort, **11 independent people** per correlation.
10. **Our statistical test (same family, closest timing).** **Source Table 3 analogue (runner):** `cor.test(dBA, vote, method = "pearson")` within **WalkG** and within **WalkU** for thermal and acoustic comfort; two-sided *p*; no CART/SHAP. **Adaptation rows** (`h4_scopus_outdoor_tests` / Xu): linear `acoustic_comfort ~ z(sound)` on four encodings (no ASV 64.8 dB knot on AC); `thermal_comfort ~ I(air_temp_c>32) × I(dBA>65)` on walk cells **only when all four 2×2 cells are populated** (on core data the hot×loud cell is empty — see item 7 and `METHODS_NOTES.md`).
11. **What cannot be matched.** Not 975 independent pedestrians; no piecewise bootstrap, CART, or SHAP. Source Table 3 **TSV** Pearson uses thermal domain comfort (§2).

</div>

---

### 3.22 Zhen et al. 2025 — outdoor Datang plaza

<div style="color:#c62828">


1. **Citation.** Zhen M, Yuan X, Gao L, Xia W, Nan K, Zhang M. Outdoor thermal comfort of urban plaza space under thermoacoustic interactions. *Building and Environment* 2025;267:112327. doi:[10.1016/j.buildenv.2024.112327](https://doi.org/10.1016/j.buildenv.2024.112327). Local PDF: `Experiment papers/Sound_evidence/Sound - Zhen2025 - plaza OTC thermoacoustic Datang.pdf`.
2. **Objective.** Thermal-acoustic comfort in a cold-region plaza (abstract).
3. **Experiment location.** **Datang, Tangshan, Hebei, China** — **outdoor urban plaza** (cold-region pedestrian survey).
4. **Instruments and sensors (source study).** JT2020, TES1333 radiation, TES-1350A SPL; 1.5 m; SPL averaged per questionnaire; surveyor-noted **positive/neutral/negative sound type** (§2.2.1).
5. **Data they collected (type, timing, resolution, sample).** 1,004 questionnaires; TSV, TCV, ASV, ACV; UTCI via RayMan; four plaza nodes.
6. **Statistical test in the source paper.** **Spearman** ρ of **TSV** against air temperature, radiation, wind, SPL **per plaza node** (§3.2). **Separate linear regressions** (and fitted curves) of **TSV on UTCI** within each interviewer-assigned **sound-type stratum** (positive / neutral / negative) (§3.3). **SOURCE FORMULA (H4 pooled port):** \(\mathrm{TSV}/\mathrm{TCV} \sim \mathrm{UTCI} + \mathrm{SPL} + \mathrm{UTCI}\times\mathrm{SPL}\) on **1,004** independent plaza questionnaires; source stratifies slopes by **sound-type**, we add explicit **UTCI×SPL** LMM on Brussels walk cells.
7. **Mode/Environment.** **Source:** **pedestrians** in **outdoor plaza** space (Datang). **Our phases:** **WalkG + WalkU**; **no bikes**. **Ten-second data:** **48 × 11** per phase; per-phase Spearman on **WalkU/WalkG** only.

8. **Sample size (for test).** **22** cells. **YAMNet traffic-majority (phase mean v>r):** **11 true / 11 false**; **WalkG traffic-majority 3/11**, **WalkU 8/11**; **7/11** people differ WalkG vs WalkU. **Per-phase Spearman:** **n=11**.

9. **Our data for method port.** **`questionnaire_thermal_comfort_1_5`** (TCV and source **TSV** per §2). Phase-mean `ucm_UTCI`, `ucm_SND_dBA`. **Sound-type analogue:** binary **YAMNet traffic-majority** vs **nature-majority** phase label.
10. **Our statistical test (closest family).** (`H4_sound_literature_helpers.R` → `h4_scopus_outdoor_tests` / Zhen.) **Pooled LMM:** `thermal_comfort ~ utci * dba + (1|ParticipantID)` (raw units; primary dBA block). **Stratified slopes (source §3.3 TSV-on-UTCI):** `thermal_comfort ~ utci + (1|ParticipantID)` within **traffic-majority** vs **nature-majority** phases. **Per-phase Spearman:** UTCI vs subjective thermal within **WalkU** and **WalkG**.
11. **What cannot be matched.** No 1 004 plaza questionnaires; no surveyor sound-type trichotomy; no four Datang nodes.

</div>

---

### 3.23 Zhang, Uchiyama & Sato 2026 — outdoor parks, Sci Rep

1. **Citation.** Zhang Y, Uchiyama Y, Sato M. Exploring interactions of thermal, acoustic, and aesthetic environments on thermal experience in parks. *Scientific Reports* (2026). doi:[10.1038/s41598-026-39787-8](https://doi.org/10.1038/s41598-026-39787-8). Local PDF: `Experiment papers/Sound_evidence/Sound - ZhangUchiyamaSato2026 - thermal acoustic aesthetic parks.pdf`.
2. **Objective.** Thermal, acoustic and aesthetic interactions on thermal experience in parks (abstract).
3. **Experiment location.** **Kobe and Osaka, Japan** — **outdoor urban parks** (humid subtropical Japan).
4. **Instruments and sensors (source study).** HOBO sensors; SL-4023SD; 1.5 m; LAeq **5-min** intervals (Field measurements).
5. **Data they collected (type, timing, resolution, sample).** 559 questionnaires; TSV/TCV/TAV; AcCV; **aesthetic satisfaction**; PET (§2).
6. **Statistical test in the source paper.** **Ordered logistic regression** (proportional odds) in SPSS/Stata: dependent variable **TCV** (7-point ordered categories). Core models **TCV ~ AcCV × PET** and extensions with **LAeq**, **dominant sound type**, **aesthetic satisfaction (AeSV)**, and controls (**park city**, **gender**, **activity**, visit covariates). **AcSV** and **AcCV** enter **separate** models (collinearity). **VIF** screening; **Brant test** for proportional odds assumption; parallel models for **overall satisfaction (OSV)** (Data analysis section).
7. **Mode/Environment.** **Source:** **park visitors on foot** (Kobe/Osaka). **Our phases:** **WalkG + WalkU** (**22** phase ratings; **no cycling**). **Ten-second data:** as needed for optional **dba** covariate.

8. **Sample size (for test).** **22** walk cells (WalkG+WalkU) for LMM / ordinal analogue.

9. **Our data for method port.** **22** WalkG+WalkU cells (item 6): **`questionnaire_thermal_comfort_1_5`**, **`questionnaire_acoustic_comfort_1_5`**, phase-mean **`ucm_PET`** (source PET); optional **`ucm_SND_dBA`**. No aesthetic or AcSV items.
10. **Our statistical test (closest family).** Gaussian LMM: `thermal_comfort ~ z(acoustic_comfort) * z(PET) + z(dBA) + (1|ParticipantID)` — source **TCV ~ AcCV × PET** family (ordered logit not fitted).
11. **What cannot be matched.** No 559 independent park visitors; no AeSV/TAV items; no Kobe vs Osaka park factor; 5-point comfort vs 7-point ordered TCV.

---

### 3.24 Zhang et al. 2026 — outdoor Jinci Temple historic spaces

1. **Citation.** Zhang R, Cui L, Liu J, Xia W, Wang Z, Zhen M. Outdoor comfort in historic spaces under thermoacoustic interactions. *Building Simulation* (2026). doi:[10.1007/s12273-026-1507-z](https://doi.org/10.1007/s12273-026-1507-z). Local PDF: `Experiment papers/Sound_evidence/Sound - Zhang2026 - historic spaces thermoacoustic Building Simulation.pdf`.
2. **Objective.** Thermal and acoustic conditions vs outdoor comfort; simulated optimisation (abstract).
3. **Experiment location.** **Taiyuan, Shanxi, China** — **outdoor** Jinci Temple **historic open spaces** (four space typologies).
4. **Instruments and sensors (source study).** AZ87783, RS-HQ globe, SM206 radiation, anemometer, BSWA 309 at 1.5 m; SPL mean during questionnaire (§2.2.1).
5. **Data they collected (type, timing, resolution, sample).** 504 questionnaires; four historic space types; TSV, TCV, ASV, ACV; PET; dominant sound source noted.
6. **Statistical test in the source paper.** **Spearman** correlations between **TSV** and **Ta, RH, wind, globe/radiation, SPL** computed **separately for each historic space type** (four open-space categories) (§3.2.1.1). Simulation blocks (ENVI-met, CadnaA, HIA) are separate from these field rank correlations.
7. **Mode/Environment.** **Source:** **pedestrians** in four **historic open-space** types. **Our phases:** **WalkU** and **WalkG** as two field open-space analogues (source walked; **exclude BikeU/BikeG**). **Ten-second data:** **11 × 48** per walking phase for Spearman-by-site blocks.

8. **Sample size (for test).** Spearman by route: **WalkU n=11**, **WalkG n=11** (not Bike*).

9. **Our data for method port.** **WalkU** and **WalkG** (item 6) as **two open-space analogues**. Per phase: meteorology + comfort votes (§2). Source **TSV**–meteorology block uses **`questionnaire_thermal_comfort_1_5`**.
10. **Our statistical test (closest family).** (`H4_sound_literature_helpers.R` → `h4_scopus_outdoor_tests` / ZhangBSim.) Spearman **dBA vs each comfort vote** within **WalkU** and **WalkG**; Spearman **meteorology vs subjective thermal** (source §3.2.1.1). ENVI-met/CadnaA **not** replicated.
11. **What cannot be matched.** No 504 campaign at Jinci typologies; no ENVI-met/CadnaA loop.

---

### 3.25 Song et al. — outdoor park vs city walks, HR/HRV

1. **Citation.** Song et al.; park vs urban **heart rate / HRV** during walking (park–city walk studies). Local PDF: not listed in §6.
2. **Objective.** Compare cardiovascular load during **park** versus **city** walking (no acoustic exposure model in the recorded source summary).
3. **Experiment location.** **Not fixed in our screened summary** — source literature compares **park vs built-environment walks** (city specified in original Song et al. paper; check source PDF before citing).
4. **Instruments and sensors (source study).** Holter/HRV and HR as in original park–city papers (details in source PDF).
5. **Data they collected.** Repeated walks in park vs built environment; HR/HRV summaries per walk type.
6. **Statistical test in the source paper.** **Between-route comparison** of HR/HRV (paired or independent tests as reported); **no LAeq or temperature predictor** in the block recorded for H4.
7. **Mode/Environment.** **Source:** **park walk vs city walk** (Holter/HRV). **Our phases:** **WalkG** (park/green) vs **WalkU** (city/traffic)—**paired within 11 people**; **walking only**. **Ten-second data:** phase-mean physiology from **48 rows** per walk bout.

8. **Sample size (for test).** **Paired WalkU vs WalkG:** **11/11** people, **22** cells → **11** paired differences per outcome.

9. **Our data for method port.** WalkG vs WalkU only: 11 people, phase-mean **`empatica_heart_rate`**, SDNN, RMSSD, LF/HF from merged Empatica columns on **`output/merged_all_11participants_8min.csv`**.
10. **Our statistical test (closest family).** **Paired *t*-test** on person means **WalkU − WalkG** (or Wilcoxon if *n* < 30 and non-normal) for each outcome — mirrors park-vs-city contrast. **No sound or UTCI regressor** (faithful to source absence). Does **not** test H4 thermo-acoustic hypothesis.
11. **What cannot be matched.** Not Song’s cities/parks; 8-min instrumented bouts; adding dBA would depart from their published model.

---

### 3.26 Tang et al. 2026 — outdoor soundscape diversity × thermal stress (Xi’an)

1. **Citation.** Tang Z, Huang W, Zhang M, Deng P, Hong B. Soundscape diversity governs thermo-physiological and psychological states in a sexually dimorphic manner. *Building and Environment* 2026;301:114742. doi:[10.1016/j.buildenv.2026.114742](https://doi.org/10.1016/j.buildenv.2026.114742). Local PDF: `Experiment papers/Sound_evidence/Sound - Tang2026 - soundscape diversity thermo physiological sex dimorphic.pdf`.
2. **Objective.** How **soundscape diversity** (low/medium/high) and **nature- vs anthropogenic-dominant** context interact with **graded thermal stress** on physiology and psychology, including **sex differences** (abstract, §1).
3. **Experiment location.** **Xi'an, Shaanxi, China** — **outdoor** experimental site (loudspeaker soundscape × induced thermal-stress protocol).
4. **Instruments and sensors (source study).** HOBO Ta/RH; Kestrel wind; globe T; **LAeq** at site; concealed **loudspeaker** playbacks; **BP, HR, eardrum temperature**; **14-ch EEG (EPOC X)**; psychological questionnaires; **PET/TSV strata** for thermal stress (§2).
5. **Data they collected.** *n* = 864 participants; **six acoustic conditions** × **PET/TSV thermal strata**; 15-min restoration exposure after stress induction; **one-way ANOVA / Kruskal–Wallis** on physiology and EEG bands by condition; sex-stratified follow-ups (§2.4).
6. **Statistical test in the source paper.** **Parametric one-way ANOVA** or **Kruskal–Wallis** (SPSS 26) comparing outcomes across **soundscape-diversity × dominance** cells within each **thermal-stress stratum**; EEG bands δ, θ, α, β from FFT pipeline; post hoc where reported.
7. **Mode/Environment.** **Source:** **outdoor seated** recovery with **loudspeaker** soundscapes (six conditions)—not a walk study. **Our phases:** mobile **WalkG + WalkU** analogue for green vs urban sound/thermal (**no bikes**). **Ten-second data:** **48 × 11** per walk phase for dBA, diversity, HR/HRV phase means or sub-bout windows.

8. **Sample size (for test).** **22** walk cells; physiology **22/22** HR etc. **Median PET split:** **11 cool / 11 warm** cells. **Kruskal dBA quartiles within half — cool:** **[5, 3, 2, 1]**; **warm:** **[1, 2, 3, 5]** (min **1**). **Flag:** min cell **1**.

9. **Our data for method port.** **WalkG + WalkU** only (item 6)—no playbacks, stress task, or EEG. Phase-level: **`ucm_SND_dBA`**, YAMNet **diversity proxy**, phase-mean **`ucm_PET`** (source thermal index); physiology **HR, SDNN, RMSSD**.
10. **Our statistical test (closest family).** `hr/sdnn/rmssd ~ z(dba)*z(PET) + (1|ParticipantID)`; `outcome ~ z(soundscape_diversity)*z(PET)`; **Kruskal–Wallis** across **dBA quartiles** within **median-split PET** half (source PET-stratum ANOVA analogue).
11. **What cannot be matched.** No loudspeaker manipulation, no 864-subject between-subjects design, no EEG/BP/eardrum measures, no English stressor task.

---

### 3.27 Peng et al. 2026 — outdoor greenway plaza openness × multisensory

1. **Citation.** Peng Z, Liu W, Teng M, Zhang Y, Keyhani AB, Wang P. Multisensory interactions in greenway plazas of differing openness and effects on user behaviors. *Urban Science* 2026;10(1):60. doi:[10.3390/urbansci10010060](https://doi.org/10.3390/urbansci10010060). Local PDF: `Experiment papers/Sound_evidence/Sound - Peng2026 - Multisensory greenway plazas openness.pdf`.
2. **Objective.** How **spatial openness** (enclosed / semi / open plaza) shapes **visual, acoustic and thermal evaluations** and **user behaviors** on a greenway (abstract).
3. **Experiment location.** **China (urban greenway)** — six **plaza points (R1–R6)** along one greenway corridor (exact city in Peng et al. 2026 PDF; northern/central China greenway context).
4. **Instruments and sensors (source study).** **LAeq,5min, L10, L90**; Ta, RH; questionnaire **VE, AE, TE** composites from PCA; **behaviour observation** (§2).
5. **Data they collected.** Six plaza points R1–R6 along one greenway; physical measurements + surveys + observed activity time/frequency (§2–3).
6. **Statistical test in the source paper.** **Descriptive means**; **PCA** for VE/AE/TE; **Kruskal–Wallis** across openness types; **Spearman** ρ among VE, AE, TE and behaviour metrics; **multiple linear regression** of behaviours on VE/AE/TE (adjusted *R*², β, *p* < 0.05, VIF < 2) (§2.5).
7. **Mode/Environment.** **Source:** **pedestrians** at **six greenway plaza** points (R1–R6). **Our phases:** **WalkG** (greenway) and **WalkU** (urban edge); **walking only**—not BikeG/BikeU. **Ten-second data:** **22** phase-mean cells.

8. **Sample size (for test).** **WalkG 11 vs WalkU 11** for Kruskal (**11** each). Pooled comfort LMM **22** rows.

9. **Our data for method port.** **WalkG vs WalkU** as **greenway vs urban-edge** openness analogue (item 6; not three plaza typologies). Phase-mean **dBA, UTCI, RH**; votes **thermal, acoustic, visual** comfort (no PCA composite). No behaviour observation.
10. **Our statistical test (closest family).** **Kruskal–Wallis** of dBA, UTCI and comfort votes across **WalkG vs WalkU**; **Spearman** among thermal/acoustic/visual votes and dBA (participant-mean adaptation); **`overall_comfort ~ thermal_comfort + acoustic_comfort + visual_comfort + (1|ParticipantID)`** (behaviour regression analogue).
11. **What cannot be matched.** No greenway plaza typology, no LAeq,L10,L90 profile, no PCA factor scores, no observational behaviour time series.

---

### 3.28 Şimşek 2026 — outdoor urban parks (Adana)

1. **Citation.** Şimşek O. Auditory comfort and noise perception under thermal and visual conditions in urban parks. *Sci. Rev. Eng. Env. Sci.* 2026;35(2):199–218. doi:[10.22630/srees.11113](https://doi.org/10.22630/srees.11113). Local PDF: `Experiment papers/Sound_evidence/Sound - Simsek2026 - auditory comfort thermal visual urban parks.pdf`.
2. **Objective.** **Auditory comfort** and **noise perception** under combined **acoustic, thermal and visual** conditions in **two urban parks** (abstract).
3. **Experiment location.** **Adana, Turkey** — **outdoor** surveys in **two urban parks** (eastern Mediterranean; autumn campaign).
4. **Instruments and sensors (source study).** Ta, RH, wind, **MRT**, **SPL**, horizontal and **vertical illuminance**; questionnaire auditory comfort and perceived quietness (§2).
5. **Data they collected.** Field campaign in **two parks**, autumn; simultaneous env measurements and surveys (§2–3).
6. **Statistical test in the source paper.** Stage 1: **Pearson** correlations of auditory comfort and noise perception with each physical variable. Stage 2: **Multiple linear regression** of auditory comfort on predictors that remain significant jointly. Stage 3: qualitative sound-preference coding (§Results).
7. **Mode/Environment.** **Source:** **two urban parks**, on-foot survey (Adana). **Our phases:** **WalkG** ≈ park/green corridor; **WalkU** ≈ urban/traffic corridor—**walking only** (replace any BikeG/BikeU mapping). **Ten-second data:** Pearson **within WalkG** and **within WalkU** (**11 × 48** each).

8. **Sample size (for test).** **Pearson within WalkG n=11, WalkU n=11**. **Wind `ucm_WIND_AWS` finite:** **22/22** bout(s). Pooled LMM **22** cells.

9. **Our data for method port.** Two-park analogue: **WalkG** vs **WalkU** (item 6)—green vs urban **walking** corridors only. Outcome **`questionnaire_acoustic_comfort_1_5`**; predictors phase-mean **dBA, UTCI, RH, wind** if finite; **no illuminance** in merged file.
10. **Our statistical test (closest family).** **Pearson** `acoustic_comfort` vs **dBA, UTCI, RH, wind** within **WalkG** and within **WalkU** (item 6); pooled LMM on **WalkG + WalkU** cells: **`acoustic_comfort ~ z(dba)+z(utci)+z(rh)+z(wind_aws) + (1|ParticipantID)`**. No illuminance or quietness item.
11. **What cannot be matched.** No Adana parks, no MRT/globe, no vertical illuminance, no subjective quietness scale, no Mediterranean autumn design.

---

**No entire source study is ported exactly.** Procedures are **adapted** to our 8-min bouts; design and *n* differ. Report omissions (item 10) and tier (T1–T3).

**Paper 3 H4** is **not** “did every §3 block match its PDF?” **H4 pass/fail = Tier 1 / §0.7** (paired WalkU − WalkG). **§0.3** is **Tier 2 sensitivity** only. Physiology blocks, vote–vote tests, and sound×**RH** (Qin) belong in **Tier 3 / Discussion**, not the H4 headline.

## 4. Cross-paper limitations of the data used

- **Same data, many adaptations.** Every port reuses the same 11 people and 44 bouts (22 walk cells where walk-only). Results under different paper labels are **not independent** and **do not** stack as H4 evidence. Duplicate families dropped per **§6.1**. **H4 significance = Tier 1 / §0.7 only**; §0.3 + catalogue = Tier 2–3.
- **Potential mode confounding.** Moshammer all-phase, Biel and vote models without mode adjustment can mix within-mode and between-mode associations. Kraus does include a mode-derived activity covariate; Rodrigues and Moshammer walking-only restrict the mode. A mode-driven explanation has not been established by these fits.
- **Temperature–corridor coupling.** Urban bouts are almost always the warmer ones. This affects Rodrigues (noise block without temperature), the Pigliautile/Chiucchiù stratum tests and every corridor contrast.
- **Rodrigues** uses asymptotic Wald z and zero-imputes missing predictors before scaling. **Source rule:** *p* < 0.05 and |β| > 0.1 on the retained term — not a global FDR rule across the catalogue.
- **Kraus** has redundant participant/CS variance parameters under the stated homogeneous specification (§3.12); study day supplies between-person information only.
- **Biel FD windows** are averages of overlapping centred 5-min estimates, so 2-min LF/HF values are not independent spectral measurements.
- **Thresholds.** Wu 60 dB(A) has 3 cells from 2 people below it. Xu >32 °C × >65 dB(A) has an **empty factorial cell** — interaction model not estimable (§3.21). **Jin** primary band×stress grid and **Gao** quartile ANOVA cells hold **0–6** questionnaires per cell.
- **YAMNet mapping** (§1.2): substring matching places 42 classes in more than one category and misroutes some (e.g. Train → Rural/Natural; Traffic noise not in Vehicle). This applies to encodings 3–4 and the Chen natural share; the columns have not been regenerated. YAMNet proportions also cannot be split into a dBA per sound source: only the dBA of 10-s rows in which a class is present (a mixture level) can be computed.
- **Sound-level provenance**: see **§7** (10-s `ucm_SND_dBA` is not certified LAeq).

## 5. Differences from the selected source studies and candidate contributions

These bullets identify differences relevant to the selected analysis blocks, not exhaustive summaries of each paper or proof of a gap across the entire field. A different measurement is not automatically a novel contribution or a valid substitute. In particular, different paper labels and standardized versus unstandardized versions do not create independent **samples**; see **§6.1**. Significance is still read **per source rule**, not by pooling *p* across blocks.

- **Moshammer 2019:** Studied air pollution as well as noise and cardiovascular/respiratory outcomes; it was not limited to Leq and air temperature. Our selected noise-model adaptation adds source/context representations not used in that selected block.
- **Jin, Jin & Kang 2020 (squares):** Source: LAeq 5 dB bands × UTCI stress categories on standing/sitting respondents. **We fit:** walk-only band×stress ANOVA (primary dBA) plus quartile ANOVA for substitute encodings (§3.9). No wearable physiology, no YAMNet on the primary source table, no humidity×sound term.
- **Biel 2020:** Studied air pollutants, noise and cardiovascular outcomes in daily activity. Our noise-only adaptation and source-class substitutions are extensions, not a complete reproduction of its pollutant/noise models.
- **Rodrigues 2026:** Mapped Lden and station weather, additive blocks, no interaction, no classifier.
- **Kraus 2013:** Piecewise Leq at 65 dB on 5 min HRV in daily life. No thermal-comfort votes, no source classification.
- **Korpilo 2024:** NDSI from 1–2 vs 2–8 kHz band energy, not a sound-event classifier. Frequency ratio ≠ YAMNet vehicle vs rural_natural.
- **Pigliautile 2021 / Chiucchiù 2026 / IBPC 2018:** NEXT.ROOM chamber lineage; headphone woodland vs street at two room temperatures (poster = descriptive only). No field dBA, no YAMNet, no mobility.
- **Cureau 2022 / FA 2023:** The selected Fisher tests concern comfort-domain associations; the journal source also used multinomial models. Our Fisher block is not a measured dBA effect test.
- **Grapas et al. 2026:** Brussels ambulatory SOR and pathway latency; we port **Pearson phase-mean web** only, not bootstrap/Granger machinery.
- **Pisello material panels (§3.7):** Laboratory acoustic indices with thermal conductivity; **no** human walk port.
- **Chen 2023:** Respondent ranking of dominant sources at stops, then RM-ANOVA. Respondent source rankings are not equivalent to classifier-derived proportions.
- **Ueberham 2019:** Subjective loudness/exposure intensity (not collected here). No YAMNet.
- **Li, Li & Wang 2025:** Arrival vs departure + subjective loudness. Our plan uses single-time-point LMM only (§3.16). Mobile ASL is not a classifier.
- **Qin 2024:** LAeq bins × RH grades on TSV/TCV. No source classifier, no YAMNet, no wearable physiology, no repeated within-person mobility design.
- **Mohammadzadeh 2023:** Thermal votes → acoustic quality/loudness. No YAMNet. Plant-community labels are not sound-event classes. No wearable physiology.
- **Gao & Zhu 2025:** ROS vs UTCI/LAeq; LAeq in 5 dB bins. No classifier. Restoration scale is ROS, not PRS-11. No wearable physiology.
- **Wu 2025:** Field-noted natural/human/artificial sound types + LAeq. Those labels are site notes, not YAMNet. No wearable physiology, no class proportions.
- **Xu 2026:** Piecewise/CART/SHAP on 975 plaza questionnaires. No classifier, no YAMNet, no within-person repeated bouts, no wearable physiology.
- **Zhen 2025:** Perceived positive/neutral/negative source type (respondent report). Not YAMNet. TSV–UTCI slopes, no wearable physiology.
- **Zhang, Uchiyama & Sato 2026:** Perceived acoustic comfort and aesthetic satisfaction; PET. Its acoustic models also included measured LAeq and dominant sound type. The vote×thermal interaction selected for our adaptation must not be taken as a complete account of the source models.
- **Zhang et al. 2026 (Building Simulation):** Perceived source classed positive/neutral/negative; ENVI-met/CadnaA. Perception ranking is not YAMNet. No wearable physiology.
- **Tang et al. 2026:** Assigned six soundscape playbacks + EEG/BP in outdoor seats. Our walk data has no playback factorial; diversity is a YAMNet proxy only (§3.26).
- **Peng et al. 2026:** Plaza openness + behaviour regression. PhaseID is not enclosure typology; no PCA composites (§3.27).
- **Şimşek 2026:** Auditory comfort vs SPL and illuminance. No lux columns in merged file (§3.28).

## 6. Source papers — open the actual methods

### 6.1 Catalogue deduplication (same data, no double counting)

- **Chen vs Zhen:** `thermal_comfort ~ UTCI × sound` on encodings other than the dedicated **Zhen** sensitivity row is fitted once under **Chen**; **Zhen** keeps the unstandardized **`TC ~ UTCI * dBA`** block without Chen’s natural-share term (§3.22).
- **Chen vs Mohammadzadeh:** `acoustic_comfort ~ UTCI × dBA` on non-primary encodings is not duplicated under Mohammadzadeh (§3.18 item 9).
- **Pigliautile vs Chiucchiù:** full-session vote–sound Spearman rows are **canonical under Chiucchiù**; Pigliautile keeps thermal-stratum Spearman and paired contrasts (§1.1).
- **Encodings 1–4** are separate **source-inspired** blocks; each row is judged by **that block’s `paper_rule`**, not by merging *p*-values across papers or encodings.

Local PDF links below open the saved source files in this project (`Experiment papers/…` under the repo root). Method descriptions in §3 are reconstructions aligned to those sources, not verbatim quotations. Song (§3.25) has no saved source PDF in §6.

### 6.2 PDF index

| Source             | PDF / primary link                                                                                                                                                                                                                                                                                        | Methods to inspect                                                                                                                                                                                |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Moshammer 2019     | [Local PDF](Experiment papers/H4 Sound literature test/Included - Sound - Moshammer et al 2019 IJERPH acute air pollution noise road traffic panel HRV.pdf); [DOI](https://doi.org/10.3390/ijerph16050788)                                                     | PDF p4 statistical methods; p6 recording period; Appendix A2                                                                                                                                      |
| Jin 2020           | [Local PDF](Experiment papers/H4 Sound literature test/Included - Sound - Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares.pdf); [DOI](https://doi.org/10.1016/j.buildenv.2019.106517)                          | PDF p5 Table1 scales; p6–7 procedures/categories; Table5 tests                                                                                                                                    |
| Biel 2020          | [Local PDF](Experiment papers/H1 to H4/H4 - Biel et al 2020 - Acute cardiovascular effects of air pollutants and noise.pdf); [DOI](https://doi.org/10.1038/s41598-020-73412-6)                                                                                 | PDF p8–9 exposure/HRV windows and statistical analysis                                                                                                                                            |
| Rodrigues 2026     | [Local PDF](Experiment papers/H4 Sound literature test/Included - Sound - Rodrigues2026 - Repeated hotspot exposures Lisbon walks LMM.pdf); [DOI](https://doi.org/10.1007/s11524-025-01051-1)                                                                    | Methods/data exposure definitions; noise and temperature thematic blocks                                                                                                                          |
| Korpilo 2024       | [Full paper, institutional repository](https://pub.epsilon.slu.se/34864/1/korpilo-s-et-al-20240827.pdf); [DOI](https://doi.org/10.1016/j.ufug.2024.128286)                                                                                                                                                | Statistical-analysis Models1/2; Table2                                                                                                                                                              |
| Kraus 2013         | [Local PDF](Experiment papers/Sound_evidence/Sound - Individual daytime noise exposure during routine activities and heart rate variability in adults - a repeated measures study.pdf); [Full text](https://pmc.ncbi.nlm.nih.gov/articles/PMC3672128/)         | Methods, five-minute windows, activity/time adjustment, 65dBA piecewise model and lags                                                                                                            |
| Pigliautile 2021   | [Local PDF](Experiment papers/Sound_evidence/Sound - Environmental thermal influence over soundscape perception - a test room experimental campaign involving the psychological and physiological.pdf); [DOI](https://doi.org/10.1088/1742-6596/2042/1/012136) | §3.1 NEXT.ROOM protocol; Fig3a/3b descriptive comparisons                                                                                                                                       |
| IBPC 2018 poster   | [Local PDF](Experiment papers/Anna Laura/Sound - IBPC 2018 poster - NEXT.ROOM thermal soundscape perception.pdf)                                                                                                                                               | §3.2 Poster figures; precursor to §3.1                                                                                                                                                            |
| Chiucchiù 2026     | [Local PDF](Experiment papers/Anna Laura/Sound - The role of personality in multi-domain environmental perception An occupant-centric approach.pdf); [DOI](https://doi.org/10.1016/j.buildenv.2025.114140)                                                     | §3.3 PDF p4 §2.4; Table5/Fig7                                                                                                                                                                     |
| Cureau 2022        | [Local PDF](Experiment papers/Sound_evidence/Sound - Multi-domain human-oriented approach to evaluate human comfort in outdoor environments.pdf); [Full text](https://doi.org/10.1007/s00484-022-02338-7)                                                      | §3.4 Fisher, multinomial models; Methods anchor #5                                                                                                                                                |
| Cureau FA 2023     | [Local PDF](Experiment papers/Sound_evidence/Sound - A multi-domain comfort walk - cross-modal interactions on acoustic perception.pdf); [DOI](https://doi.org/10.61782/fa.2023.1153)                                                                           | §3.5 Comfort-walk preprint; superseded by §3.4 journal                                                                                                                                            |
| Grapas 2026        | [Local PDF](Experiment papers/Urban Climate Literature/Sound - Grapas et al 2026 - Urban chronotypes climate vulnerability safety-modulated bioclimatic responses.pdf); [DOI](https://doi.org/10.1016/j.uclim.2026.102906)                                      | §3.6 SOR / pathway methods; Fig. 11 analogue                                                                                                                                                      |
| Pisello materials  | [Anna Laura folder](Experiment papers/Anna Laura/) (cardboard ×2, PET, cool-roof PDFs)                                                                                                                                                                           | §3.7 Lab thermo-acoustic material indices; catalogue only                                                                                                                                         |
| Chen 2023          | [Local PDF](Experiment papers/Sound_evidence/Chen2023_Sensory_walking_thermal_acoustic.pdf); [Full text](https://doi.org/10.3390/f14061161)                                                                                                                    | §§2.5–2.7, sample, stopping protocol, ANOVA and sphericity                                                                                                                                        |
| Ueberham 2019      | [Local PDF](Experiment papers/Sound_evidence/Ueberham2019_Cyclists_multiple_environmental_exposures.pdf); [Full text](https://doi.org/10.3390/su11051412)                                                                                                      | Objective/subjective exposure comparison, route means, ordinal regressions                                                                                                                        |
| Li 2025            | [Local PDF](Experiment papers/Sound_evidence/Sound - Li2025 - autumn greenway noise thermal walking.pdf); [DOI](https://doi.org/10.1007/s00484-024-02790-7)                                                                                                    | Arrival/departure + SLV protocol; §3.16                                                                                                                                                           |
| Qin 2024           | [Local PDF](Experiment papers/Sound_evidence/Sound - Qin2024 - sound humidity outdoor thermal comfort cold regions.pdf); [DOI](https://doi.org/10.1016/j.uclim.2024.101967)                                                                                    | Humidity grades, LAeq bins, TSV/TCV vs PET                                                                                                                                                        |
| Mohammadzadeh 2023 | [Local PDF](Experiment papers/Sound_evidence/Sound - Mohammadzadeh2023 - thermal on acoustic comfort urban parks.pdf); [DOI](https://doi.org/10.1016/j.buildenv.2022.109884)                                                                                   | Pearson TSV/TCV/PET vs acoustic quality; reverse arrow                                                                                                                                            |
| Gao 2025           | [Local PDF](Experiment papers/Sound_evidence/Sound - GaoZhu2025 - thermal-acoustic psychological restoration greenways.pdf); [DOI](https://doi.org/10.1016/j.buildenv.2025.113269)                                                                             | ROS ANOVA/regression; veto probability                                                                                                                                                            |
| Wu 2025            | [Local PDF](Experiment papers/Sound_evidence/Sound - Wu2025 - thermal acoustic overall comfort cold-region parks.pdf); [DOI](https://doi.org/10.1016/j.enbuild.2025.116329)                                                                                    | OCV regression; LAeq ≥ 60 dB; sound-type × UTCI                                                                                                                                                   |
| Xu 2026            | [Local PDF](Experiment papers/Sound_evidence/Sound - Xu2026 - threshold thermal-acoustic urban public spaces.pdf); [DOI](https://doi.org/10.1007/s10668-026-08213-4)                                                                                           | §4.1 Table 3 Pearson; piecewise/CART/SHAP in source                                                                                                                                               |
| Zhen 2025          | [Local PDF](Experiment papers/Sound_evidence/Sound - Zhen2025 - plaza OTC thermoacoustic Datang.pdf); [DOI](https://doi.org/10.1016/j.buildenv.2024.112327)                                                                                                    | TSV–UTCI / NUTCI by perceived sound type                                                                                                                                                          |
| Zhang 2026 SciRep  | [Local PDF](Experiment papers/Sound_evidence/Sound - ZhangUchiyamaSato2026 - thermal acoustic aesthetic parks.pdf); [DOI](https://doi.org/10.1038/s41598-026-39787-8)                                                                                          | Ordered logit TCV ~ AcCV × PET; aesthetics omitted                                                                                                                                                |
| Zhang 2026 BSim    | [Local PDF](Experiment papers/Sound_evidence/Sound - Zhang2026 - historic spaces thermoacoustic Building Simulation.pdf); [DOI](https://doi.org/10.1007/s12273-026-1507-z)                                                                                     | Spearman by space type; §3.24                                                                                                                                                                     |
| Tang 2026          | [Local PDF](Experiment papers/Sound_evidence/Sound - Tang2026 - soundscape diversity thermo physiological sex dimorphic.pdf); [DOI](https://doi.org/10.1016/j.buildenv.2026.114742)                                                                             | §2.4 ANOVA/Kruskal physiology; §3.26                                                                                                                                                              |
| Peng 2026          | [Local PDF](Experiment papers/Sound_evidence/Sound - Peng2026 - Multisensory greenway plazas openness.pdf); [DOI](https://doi.org/10.3390/urbansci10010060)                                                                                                    | §2.5 Kruskal, Spearman, regression; §3.27                                                                                                                                                          |
| Şimşek 2026        | [Local PDF](Experiment papers/Sound_evidence/Sound - Simsek2026 - auditory comfort thermal visual urban parks.pdf); [DOI](https://doi.org/10.22630/srees.11113)                                                                                                  | Pearson + multiple regression; §3.28                                                                                                                                                                |

## 7. Measurement provenance (sound level and classifiers)

- **`ucm_SND_dBA`:** per 10-s row, a **median** of UCM sound samples in that window (not a laboratory-certified LAeq chain documented here). Phase-level values used in H4 are **energy means** of those 10-s medians across each 8-min bout.
- **Native 1-s LAeq export path** referenced in earlier drafts is **not** present in the current pipeline; do not cite it as the H4 exposure definition.
- **YAMNet proportions** come from the analysis notebook named in §1.2; they are frame-detection shares, not calibrated level or duration (§1.2).

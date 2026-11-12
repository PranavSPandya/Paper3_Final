# H4 outdoor replacement papers — field evidence set for the 6 chamber sources

**Date:** 2026-11-02 · **Prepared for:** Paper 3, H4 (`scripts/statistical_analysis/H4_sound_literature_tests.R`; outline §2.3.4)
**Scope:** Replace the 6 climate-chamber H4 sources (Jo 2019; Yousefinezhad 2026; Dehghan 2017; Molaeifar 2020; Tohidi 2025; Abbasi 2020) with outdoor/naturalistic field studies. **Keep as anchors:** Rodrigues et al. (2026) and Kraus et al. (2013).

**Selection criteria (from request):** (a) outdoor / naturalistic field, not climate chamber; (b) noise/sound *measured*; (c) thermal exposure measured **or** thermal comfort/discomfort outcome; (d) wearable/ambulatory physiology preferred; (e) bonus: sound × thermal interaction tested, or evidence that noise worsens thermal discomfort.

---

## 1. Executive summary

**A perfect set of 6 does not exist.** Screening 13 prior local extracts plus targeted web searches (Cozie Apple, Moshammer Vienna panel, Teixeira 5-city cycling, Jin urban squares, DigitalExposome, "Stress in the City"/Urban Emotions, Apple Hearing Study, Fahy PET transects, Nakayoshi mobile thermal physiology, Korkmaz ambulatory reliability) found:

- **Only 1 paper meets all core criteria at once** — Moshammer et al. (2019): outdoor 1-h walks, class-1 measured LAeq, ambulatory ECG-HRV + blood pressure every 15 min, and ambient temperature retained as a model covariate (reported as *the most important predictor* of the cardiovascular outcomes, with noise effects robust to temperature adjustment). Even it does **not** formally test a noise × temperature interaction.
- **2 papers meet (a)+(b)+(d) with a partial thermal channel** — Mahecha et al. (2018) and Teixeira et al. (2020): outdoor cycling with noise sensors and smartband skin conductance **+ skin temperature**; ambient thermal exposure is *not* modelled, so the thermal criterion is only half-met.
- **1 paper meets (a)+(b)+(c)+(e) but has no physiology** — Jin, Jin & Kang (2020): urban-square surveys with measured LAeq and air temperature; higher traffic noise significantly *lowered thermal comfort* (the requested "noise worsens thermal discomfort" evidence) and season-specific temperature × noise interactions were tested. This is the strongest field analogue to the Tohidi/Abbasi interaction question but is perception-only.
- **2 weaker tier entries complete the 6** — Tartarini et al. (2023, Cozie Apple: measured watch sound level + HR + thermal-comfort micro-surveys; largely descriptive) and Burns et al. (2016: 24-h personal noise dosimetry → ambulatory HR in outdoor occupational work in Ghana; thermal not modelled).

**Recommendation:** adopt the ranked 6 below as the *field evidence set* for §2.3.4; demote the 6 chamber papers to "laboratory precedent" context rather than primary H4 sources. Only the Moshammer block is a straight upgrade in rigor; the others trade chamber control for ecological validity and must be framed with the honest gaps stated in §2.

Anchors retained (unchanged): **Rodrigues et al. 2026** (2,207 walking trips, 90 participants; HRV/EDA/skin temperature; noise and heat blocks both associated with physiological stress) and **Kraus et al. 2013** (personal Leq → HRV, piecewise 65 dBA). Note: Kraus did **not** model air temperature (time-trend + activity adjustment only), so even the anchors do not fully close the thermal criterion — one more reason not to over-claim the replacement set.

## 2. Ranked replacement set (top 6)

| Rank | Replaces (chamber source) | Citation | DOI | Outdoor? | Physio (ambulatory) | Noise measured | Thermal | Interaction tested? | H4 template to code (contrast · model · covariates) | Fit |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Yousefinezhad 2026 | Moshammer H, Panholzer J, Ulbing L, Udvarhelyi E, Ebenbauer B, Peter S. *Acute Effects of Air Pollution and Noise from Road Traffic in a Panel of Young Healthy Adults.* IJERPH 2019;16(5):788 | 10.3390/ijerph16050788 | Yes — 1-h walks, Vienna road vs park, 4 settings incl. earplugs / park + 65 dB playback | Yes — ambulatory ECG (eMotion Faros) HRV + BP every 15 min | Yes — B&K 2236 SLM, LAeq per 15 min | Air temperature in models; "most important predictor" of HR/HRV/BP; noise effects robust to temp adjustment | No formal noise×temp term | (a) Paired road-vs-park contrast on HRV/HR adjusted for Δtemperature (maps to our WalkU vs WalkG). (b) Phase-level LMM: `log(HRV) ~ Leq + air_temp + activity + (1\|Participant)`; per-5 dB slope | **Strong** (only full-criteria paper) |
| 2 | Molaeifar 2020 | Mahecha Nuñez JY, Teixeira IP, Rodrigues da Silva AN, Zeile P, Dekoninck L, Botteldooren D. *The Influence of Noise, Vibration, Cycle Paths, and Period of Day on Stress Experienced by Cyclists.* Sustainability 2018;10(7):2379 | 10.3390/su10072379 | Yes — naturalistic cycling routes, São Carlos | Yes — smartband skin conductance level + skin temperature (10 Hz), GPS | Yes — backpack noise sensor, 8 Hz | Partial — skin temperature signal only; ambient thermal not modelled | No (noise main effect in logit; period-of-day dominant) | Epoch GLMM (binomial): `EDA-stress event ~ dBA class (≥65) + PhaseID + (1\|Participant)`; OR per noise class; exertion context = cycling phases | Acceptable (thermal gap) |
| 3 | Jo 2019 | Teixeira IP, Rodrigues da Silva AN, Schwanen T, Manzato GG, Dörrzapf L, Zeile P, Dekoninck L, Botteldooren D. *Does cycling infrastructure reduce stress biomarkers in commuting cyclists? A comparison of five European cities.* J Transp Geogr 2020;88:102830 | 10.1016/j.jtrangeo.2020.102830 | Yes — 6 km routes, 5 cities, 70 cyclists | Yes — smartband SCL + skin temperature stress biomarker | Yes — noise sensor; "noisier places" ↑ stress, effect consistent across all 5 cities | Partial — skin temperature channel only | No | Segment/hotspot multilevel logit: `stress-event ~ noisy + phase/green + (1\|Participant) (+ (1\|cell))`; field analogue of Jo's "real sound environment → physiology", replacing playback with measured exposure | Acceptable (thermal gap) |
| 4 | Tohidi 2025 | Jin Y, Jin H, Kang J. *Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares.* Build Environ 2020;168:106517 | 10.1016/j.buildenv.2019.106517 | Yes — urban squares, 3 seasons, severe-cold region | No (perception only) | Yes — LAeq monitored on site | Air temperature + UTCI framing; thermal sensation/comfort votes are primary outcomes | **Yes** — temperature × traffic noise on acoustic comfort (summer) and overall comfort (winter); **higher traffic noise → lower thermal comfort in all seasons** | Perception family (separate from physio): end-of-phase thermal-comfort item ~ `dBA bin × UTCI bin`, participant-blocked; noise main effect + interaction | Acceptable (no physio; best available interaction evidence) |
| 5 | Abbasi 2020 | Tartarini F, Schiavon S, Cheung T, Höyt T, Quintana M, Miller C. *Cozie Apple: An iOS mobile and smartwatch application for environmental quality satisfaction and physiological data collection.* J Phys Conf Ser 2023;2600:142003 | 10.1088/1742-6596/2600/14/142003 | Yes — free-living urban deployment (Singapore; mixed in/outdoor micro-settings) | Yes (lite) — Apple Watch HR, activity, GPS | Yes — watch-measured environmental sound level | Thermal comfort/preference micro-surveys (co-occurrence with noise distraction reported) | No formal test (descriptive co-occurrence) | Micro-survey association: `phase-mean HR ~ mean sound level + comfort vote` (descriptive family); noise-distraction × thermal-comfort co-reporting rate | Weak–acceptable (descriptive; watch-grade) |
| 6 | Dehghan 2017 | Burns KN, Sun K, Fobil JN, Neitzel RL. *Heart Rate, Stress, and Occupational Noise Exposure among Electronic Waste Recycling Workers.* IJERPH 2016;13(2):140 | 10.3390/ijerph13010140 | Yes — outdoor e-waste site, Accra, Ghana; up to 24-h monitoring | Yes — continuous ambulatory HR | Yes — personal noise dosimetry, continuous | Hot-climate outdoor context; thermal exposure **not** modelled | No | Phase/trip LMM: `HR ~ mean dBA (per-dB slope) + activity + (1\|Participant)`; echoes Kraus block restricted to HR | Weak (occupational, thermal gap) |

**First alternate (if a reviewer objects to #6):** Johnson T, Kanjo E, Woodward K. *DigitalExposome: quantifying impact of urban environment on wellbeing using sensor fusion and deep learning.* Comput Urban Sci 2023;3:14 (DOI 10.1007/s43762-023-00088-9) — pre-specified urban route, 40 participants, Empatica E4 (EDA, HR, HRV, **body temperature**) + noise (dB) + PM sensors; multivariate regression shows EDA/HRV responses; no ambient thermal metric and ML-centric analysis keep it below the top 6.

**Walking-design upgrade (extended screening):** Korpilo et al. (2024), *Urban Forestry & Urban Greening* 96:128286 (DOI [10.1016/j.ufug.2024.128286](https://doi.org/10.1016/j.ufug.2024.128286)) — outdoor walking, n = 45, continuous **EDA** (Vigofere ring), **5-min audio → NDSI** (soundscape index, not personal dBA), **temperature + RH** as GLMM covariates on EDA (beta-logit). **Strong** for your walk phases and LMM shell; prefer over Cozie (#5) when the H4 slot should mirror **walking + EDA + acoustic environment + weather**. Full-text extract: `temp/ext_korpilo2024.txt`. Perception-only cross-domain alternates if reviewers insist on explicit “noise worsens thermal discomfort” citations: Ning (2025) *Atmosphere* 16:410 (campus squares, noise × temperature-band); Li, Li & Wang (2025) *Int J Biometeorol* (greenway, bidirectional noise–thermal comfort) — **weak**, no wearables (see §8).

## 3. Mapping: each chamber paper → outdoor replacement

| Chamber source | What it tested (verified) | Suggested outdoor replacement | 1:1? |
|---|---|---|---|
| Jo et al. (2019), 10.3390/ijerph16152649 | Lab playback forest vs urban sound → HR, ln HF, ln LF/HF (paired) | **Teixeira et al. (2020)** — measured real acoustic environments → stress biomarkers along routes; "sound→physio" logic moved outdoors. Rodrigues 2026 (anchor) already covers the green-vs-urban physio contrast, so Teixeira adds the explicit *noise-exposure* version | Yes (fit rank 3) |
| Yousefinezhad et al. (2026), 10.1038/s41598-026-41251-6 | Chamber 2×2 (WBGT × 75 dBA) crossover; HR, BP, core temp, cognition | **Moshammer et al. (2019)** — the only field study with a quasi-2×2 acoustic design (road / road+earplugs / park / park+65 dB), repeated ambulatory cardiovascular outcomes, and temperature as model covariate | Yes (fit rank 1) |
| Dehghan et al. (2017), 10.4103/jehp.jehp_107_15 | Chamber heat × noise → blood pressure | **Burns et al. (2016)** — field noise→cardiovascular (HR) dose-response, hot-climate outdoor work. Note: Moshammer's BP endpoint *also* answers Dehghan's question with temperature adjustment and may be cited jointly | Yes, weaker (rank 6); joint-cite Moshammer BP |
| Molaeifar et al. (2020), 10.32604/sv.2020.08810 | Chamber sound × heat × physical workload | **Mahecha et al. (2018)** — noise → physio stress *under real physical exertion* (cycling), the field echo of the workload factor | Yes (fit rank 2) |
| Tohidi et al. (2025), 10.1016/j.exger.2025.112829 | Chamber 3-way: temperature × sound type × sound level | **Jin, Jin & Kang (2020)** — the only outdoor study that *tests the temperature × noise interaction* and shows noise degrading thermal comfort; downgrade: perception-only | Yes, perception tier (rank 4) |
| Abbasi et al. (2020), 10.1016/j.apergo.2020.103189 | Chamber 18/22/26/30 °C × 55/75 dBA → neurophysiology (EEG) + responses | **Tartarini et al. (2023, Cozie Apple)** — wearable HR + measured sound level + thermal comfort in free-living urban settings; weakest mapping (descriptive, watch-grade) — flag honestly or mark "no strict 1:1; pooled field template" | Weak (rank 5); pooled-template fallback acceptable |

## 4. Recommended next step for `H4_sound_literature_tests.R`

Add new literature blocks in this priority order (each becomes its own BH-FDR family, sound terms only, mirroring current practice):

1. **`Moshammer2019` block (highest value).** (a) Temperature-adjusted phase-level LMM per HRV/HR outcome: `outcome_tr ~ ucm_SND_dBA + ucm_AIR_temp + MET/activity + (1 | ParticipantID)`; report per-5 dB slope with and without the temperature term (their key robustness claim). (b) Road-vs-park analogue: paired WalkU vs WalkG contrast on phase-mean HRV/HR adjusted for Δ air temperature between the paired phases. This reuses the existing Jo infrastructure (paired phase means) and the Kraus-style covariate machinery — small code delta.
2. **`Mahecha2018` / `Teixeira2020` block.** Binary epoch indicator for EDA stress events (top-decile tonic EDA or SCR-count > 0 within 10-s epochs); `glmer(event ~ dBA65 + PhaseID + (1 | ParticipantID), family = binomial)`; optional hotspot random effect at H5 buffer cells. Report OR for loud vs quiet, matching their logit framing. Mark exploratory if EDA quality flags apply.
2b. **`Korpilo2024` block (walking + EDA + soundscape + weather).** Phase-mean or stop-level EDA (beta GLMM/logit as in source): `EDA ~ sound_metric × Phase + UTCI + RH + order + (1 | ParticipantID)` with `sound_metric` = personal dBA or green/urban class as NDSI analogue; two-way interaction Wald tests. Maps Abbasi/Tohidi *structure* to field GLMM rather than chamber ANOVA.
3. **`Jin2020` perception block (new family type).** End-of-phase questionnaire thermal-comfort item ~ `dBA bin × UTCI bin` on participant × phase cells; participant-blocked; declare explicitly as a *perception* family, separate from the 26-outcome physio families. Optional sensitivity blocks mirroring **Ning 2025** (noise × UTCI band) and **Li et al. 2025** greenway (early vs late route segment) on the same perception items only.
4. **`Burns2016` block (optional).** Phase/trip `HR ~ mean dBA` LMM with activity covariate — largely redundant with the Kraus block; include only if a cardiovascular-only family is wanted for comparability.
5. **Housekeeping.** (i) Re-label the 6 chamber blocks in `SUMMARY` output as `lab-precedent` tier; (ii) extend `METHODS_NOTES.md` with the adaptation notes above (field cut-offs, perception family, EDA-event definition); (iii) update the "Not testable" list (Li 2025 stays not-testable — hypertension outcome unavailable); (iv) keep `reporting_eligible` gating unchanged.

## 5. Screened and rejected (audit trail)

| Candidate | Why rejected |
|---|---|
| Fahy et al. 2025 (Geneva PET transects, 10.1016/j.uclim.2025.102460) | No physiology, no noise — thermal mapping only (already cited in H5) |
| Korkmaz et al. 2025 (Sci Rep 15:28940) | Ambulatory EDA/ECG + temperature on urban walks, but **noise not measured** |
| Nakayoshi et al. 2015 (IJB 59:503) | Full mobile thermal physiology (Tskin, pulse, sweat) but **no noise** |
| Li et al. 2025 (BMC Public Health 25:3533) | Heat×noise synergy on hypertension/ECG, but occupational cross-sectional surveillance, no ambulatory wearables; already flagged "not testable" in the script |
| Jin, Ji & Kang 2020 (Build Environ 107215) | **Chamber** study simulating seasons — fails outdoor criterion |
| Cureau et al. 2022 (IJB 66:2033) / 2023 (Eurocoustics comfort walk) | Outdoor + measured LAeq + thermal comfort surveys, but perception-only and no noise×thermal inferential test — kept as **second alternates** behind Jin 2020 |
| Choi et al. 2021 (Build Environ 206:108333) | Outdoor thermal comfort + UTCI, but acoustics are *perceived* votes, not measured SPL |
| "Stress in the City" / Urban Emotions (Zeile, Resch et al.) | Same smartband lineage already represented by Mahecha 2018 / Teixeira 2020 |
| `Experiment papers/Empatica - Stress in the City Multimodal Biosensing of Urban Stress.pdf` | **Mislabeled file** — contents are unrelated traffic-sign recognition; do not cite from this path |
| Apple Hearing Study | Noise exposure metrics only; no published noise × thermal physiological outcome |
| Teixeira/Mahecha skin temperature | Counted as *partial* thermal channel, not ambient exposure — stated as a gap, not a criterion pass |

## 6. Verification status

- Full text / full extract inspected locally: Yousefinezhad 2026, Jin 2020, Mahecha 2018, Teixeira 2020 (Oxford ORA), Burns 2016, Cureau 2022, Korkmaz 2025, Fahy 2025, Nakayoshi 2015, Rodrigues 2026, Kraus 2013; chamber-source methods per `Experiment papers/Sound_evidence/SOURCE_METHOD_VERIFICATION.md`.
- Web-verified (publisher pages): Moshammer 2019 (MDPI IJERPH full text, incl. temperature-as-confounder statements); Cozie Apple (J Phys Conf Ser + arXiv 2210.13977); DigitalExposome (PMC10025809, Comput Urban Sci 2023).
- **Local PDF (Moshammer 2019):** `Experiment papers/Sound_evidence/Sound - Moshammer et al 2019 IJERPH acute air pollution noise road traffic panel HRV.pdf` (MDPI CDN `ijerph-16-00788.pdf`, verified `%PDF`, ~511 KB).
- Kraus 2013 temperature: full-text search finds no temperature term — adjustment was time trend + physical activity only.

## 7. Ariane Middel group (screened)

**Workspace search (2026-11-02):** `Experiment papers/Ariane Middel/` — 220 works in `Ariane - _manifest.md` (75 local PDFs, 199 manifest-only `.md` stubs); no `fetch_ariane_middel_papers.py` in repo. First-three-page PDF extracts: `temp/scr_ariane_*.txt` (13 H4-relevant titles).

**Verdict vs §2:** Middel / GCHA work is the best local precedent for **outdoor PHE, MaRTy/HeatSuite, and heat load → strain** — but **no screened paper combines measured noise with thermal exposure and ambulatory physiology** (or Jin-style noise×thermal interaction on comfort). **No promotions into §2**; cite Middel for **methods and gap framing**, not chamber replacement.

**Why thermal-only Middel papers do not replace chamber sound×heat tests:** Abbasi/Tohidi/Yousefinezhad isolate **sound level/type × thermal level** with concurrent cardiovascular outcomes. Middel-group field work measures **MRT/PHE without SPL**, **wearable HR/strain without a noise term**, or **SPL for tree attenuation** — not human noise×heat dose–response. Same tier as Fahy (2025) in §5: useful for **exposure profiling and HR~heat covariates**, not H4 factorial replication.

### 7.1 Screened papers (H4-relevant)

| Paper | Year | DOI | Outdoor | Wearable physio | Noise | Thermal | Sound×heat | H4 promote? |
|---|---|---|---|---|---|---|---|---|
| Guzman-Echavarria, **Middel** & Vanos. *Beyond heat exposure — Temperature toolbox* | 2023 | 10.1080/23328940.2022.2149024 | Multi-city PHE | Model-based strain (not wearables in main text) | No | PHE, MRT | No | **No** |
| Kuras et al. (+ **Middel**). *Opportunities and challenges for personal heat exposure research* | 2017 | 10.1289/EHP556 | Field examples in review | Wearables discussed | No | PHE | No | **No** |
| Guzman-Echavarria et al. (+ **Middel**). *Who can avoid the heat?* 24-h PHE | 2026 | 10.1029/2026GH001914 | Free-living Phoenix (HeatSuite, Kestrel, smartwatch) | **Excluded** here (companion physio/EMA) | No | IET/IEH, heat balance model | No | **No** — HeatSuite **methods** |
| **Middel** et al. *GCHA HeatSuite Phoenix 2024 pilot* (PASTA) | 2026 | 10.6073/pasta/b18c58d2805b4caa1393dddc5dbe6d22 | Free-living | Per title: physio + perception (no local PDF) | Not in manifest | PHE | No | **No** |
| **Middel** et al. *Heart rate during rest vs personal heat exposure* (Physiology abstract) | 2026 | 10.1152/physiol.2026.41.s1.2300843 | Free-living | Resting HR vs PHE | No | PHE | No | **No** — HR + heat covariate (Kraus/Moshammer) |
| Pandya et al. (+ **Middel**). *Environmental, neuropsychological, and physiological factors…* (systematic review) | 2025 | 10.1007/s00484-025-02942-3 | Review (217 OTC field studies) | GSR, HRV, skin temp in literature | Acoustics as OTC factor only | OTC / thermal stress | No | **No** |
| Wardenaar et al. (+ **Middel**). *Hikers: risk perception vs physiology* | 2025 | 10.1088/2752-5309/ae11cf | Phoenix trails | Core temp / hydration subsample | No | Heat stress (self-report + physio) | No | **No** |
| Li et al. (+ **Middel**). *Travel behavior to mitigate heat exposure* | 2023 | 10.3389/frsc.2023.1129388 | Phoenix ABM | None (simulation) | No | MRT | No | **No** |
| Li et al. (+ **Middel**). *Occupation/travel heat burdens (MAHE)* | 2024 | 10.21203/rs.3.rs-4204964/v1 | Simulated | None | No | MRT | No | **No** |
| Van Tol et al. (+ **Middel**). *Overexposed… homelessness* | 2025 | 10.1029/2025GH001372 | MaRTy + PM2.5 field | Survey | No | Thermal radiation | Heat + PM | **No** |
| **Middel** et al. *Observed determinants… thermal exposure* (Guelph) | 2024 | 10.1016/j.scs.2024.106019 | MaRTy transects | No | No | PET/MRT | No | **No** — H5/Fahy tier |
| **Middel** et al. *Impact of shade on outdoor thermal comfort* (Tempe) | 2016 | 10.1007/s00484-016-1172-5 | Seasonal field | No | No | PET, comfort votes | No | **No** |
| **Middel** et al. *Evidence of alliesthesia… thermal walk* | 2022 | 10.1016/j.scitotenv.2022.155294 | Walk (metadata; no PDF) | No | No | Thermal pleasure/discomfort | No | **No** |
| Li et al. (+ **Middel**). *Street-level heat and air pollution, mobile sensing* | 2022 | 10.1016/j.trd.2022.103535 | Transects | No | No | Heat + PM | No | **No** |
| **Middel** et al. *Child heat exposure… school microenvironments* | 2026 | 10.1016/j.buildenv.2026.115409 | School mobile sensing | Thermal/mobile (metadata) | No | Cumulative heat stress | No | **No** |
| Lu et al. (+ **Middel**, Kang). *Sound attenuation of single trees* | 2024 | 10.1016/j.jenvman.2024.122818 | Outdoor SPL | No human subjects | SPL experiments | Indirect | No | **No** |
| Guzman-Echavarria et al. *Turbulence of airflow… thermophysiological response* | 2026 | 10.1080/23328940.2026.2620979 | Toolbox (metadata) | Thermophysiology | No | Airflow × heat | No | **No** |
| **Middel** et al. *CARla heat exposure sensing* | 2025 | 10.1007/s00484-025-02860-4 | Instrument validation | No | No | MRT, wind | No | **No** |
| **Middel** et al. *Concurrent heat and air pollution… homelessness* (perspective) | 2024 | 10.1289/ehp13402 | Conceptual | N/A | No | Heat + PM | No | **No** |

### 7.2 Cite Middel for (not §2 slots)

- **HeatSuite / GCHA:** multimodal free-living stack (env + physio + EMA) — PASTA 10.6073/pasta/b18c58d2805b4caa1393dddc5dbe6d22; Who Can Avoid 10.1029/2026GH001914.
- **HR ~ personal heat (no noise):** Heart-rate abstract 10.1152/physiol.2026.41.s1.2300843; Beyond heat exposure 10.1080/23328940.2022.2149024.
- **Outdoor thermal only:** MaRTy/PHE transects (Observed determinants; Opportunities 10.1289/EHP556) — parallel **H5**, not H4.
- **Gap:** no Middel paper in library joins **personal dBA** with **Empatica-class strain** outdoors; Brussels protocol + Rodrigues 2026 + Moshammer 2019 remain the combined-exposure precedents.

**Local library:** `Moshammer et al. 2019` (rank-1 H4 replacement) — `Experiment papers/Sound_evidence/Sound - Moshammer et al 2019 IJERPH acute air pollution noise road traffic panel HRV.pdf` (local copy confirmed 2026-11-02).

## 8. Extended screening pass (physio + noise outdoors)

Independent full-text/web pass converges on **≤4 strong physio + measured-sound field papers** (Mahecha, Teixeira, **Korpilo**, Burns); slots 5–6 remain perception-only if six chamber replacements are required. **Korpilo et al. (2024)** is the best **walking + EDA** analogue to your protocol and should be coded before Cozie. **Ning (2025)** and **Li, Li & Wang (2025)** add outdoor noise×thermal *comfort* interactions without sensors — cite only in perception-family text, not as physio templates. Do not confuse **Li et al. (2025) BMC Public Health** (occupational heat×noise synergy, hypertension) with the greenway Li paper; the former stays “not testable” in `H4_sound_literature_tests.R`. Artifacts: `temp/ext_korpilo2024.txt`, `temp/search_*.json`. **Local PDF:** Korpilo not auto-retrieved (publisher/Luke URLs returned HTML); use OA copy at [jukuri.luke.fi](https://jukuri.luke.fi/items/d0f23835-2e2a-480c-9573-47c4d49b393f) manually if needed.

# Archived non-European §3 blocks\n\nRemoved 2026-11-09.\n\n### 3.9 Jin, Jin & Kang 2020 — outdoor squares, respondents standing/sitting

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

\n---\n\n### 3.14 Chen et al. 2023 — outdoor sensory walks / stops

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


# H4 literature PDF inventory

Generated: 2026-11-02. Sources: publisher OA, PMC HTML, Nature, IOP, MDPI, Springer, Elsevier (no Sci-Hub or paywall circumvention).

| DOI | Saved path | Status | Notes |
|-----|------------|--------|-------|
| 10.3390/ijerph16152649 | `Experiment papers/Sound_evidence/Sound - Jo2019 - Physiological and Psychological Effects of Forest and Urban Sounds.pdf` | **local/exists** | Valid PDF (~1.3 MB). |
| 10.1038/s41598-026-41251-6 | `Experiment papers/Sound_evidence/Sound - Yousefinezhad2026 - Thermal-acoustic exposure human performance Sci Reports.pdf` | **new download** | Nature Sci Reports OA PDF (~1.9 MB). |
| 10.4103/jehp.jehp_107_15 | `Experiment papers/Sound_evidence/Sound - Dehghan2017 - Evaluating combined effect noise heat blood pressure JEHP.pdf` | **local/exists** | Publisher PDF (~495 KB); `%PDF` verified 2026-11-02. HTML copy retained: `Sound - Dehghan2017 - Heat and Noise Blood Pressure - FULLTEXT.html`. |
| 10.32604/sv.2020.08810 | `Experiment papers/Sound_evidence/Sound - Molaeifar2020 - Concomitant Sound Heat and Physical Workload.pdf` | **local/exists** | Valid PDF (~239 KB). |
| 10.1007/s11524-025-01051-1 | `Experiment papers/Sound_evidence/Sound - Rodrigues2026 - Repeated hotspot exposures Lisbon walks LMM.pdf` | **new download (copied from repo OA copy)** | Copied from `Experiment papers/Repeated hotspot exposures and reactivity/Repeated hotspot - Rodrigues et al 2026 J Urban Health Lisbon walks LMM weather.pdf` (~1.0 MB). Same article: *The Influence of Urban Context on Emotions and Bodily Responses During Walking*. |
| 10.1289/ehp.1205606 | `Experiment papers/Sound_evidence/Sound - Kraus2013 - Individual daytime noise exposure HRV EHP.pdf` | **local/exists** | Alias copy of existing `Sound - Individual daytime noise exposure during routine activities and heart rate variability in adults - a repeated measures study.pdf` (~341 KB). (Audit table DOI 10.1289/ehp.1205506 is a typo; correct DOI is **10.1289/ehp.1205606**.) ACS/PMC PDF fetch returned HTML from this environment. |
| 10.1016/j.exger.2025.112829 | `Experiment papers/Sound_evidence/Sound - Tohidi2025 - Ambient temperature sound type noise level heart rate elderly.pdf` | **local/exists** | OA CC BY-NC PDF (~1.1 MB); `%PDF` verified 2026-11-02. Methods notes: `Tohidi2025_ACCESS_STATUS.md`. |
| 10.1016/j.apergo.2020.103189 | `Experiment papers/Sound_evidence/Sound - Abbasi2020 - Combined effects noise air temperature neurophysiological responses.pdf` | **local/exists** | Full PDF (~857 KB); `%PDF` verified 2026-11-02. Methods notes: `Abbasi2020_ACCESS_STATUS.md`. |

## Field replacement papers

| DOI | Saved path | Status | Notes |
|-----|------------|--------|-------|
| 10.1016/j.buildenv.2019.106517 | `Experiment papers/Sound_evidence/Sound - Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares.pdf` | **local/exists** | Jin et al. 2020; valid PDF (~924 KB). |
| 10.1016/j.ufug.2024.128286 | `Experiment papers/Sound_evidence/Sound - Korpilo2024 - Landscape soundscape quality stress recovery urban nature.pdf` | **local/exists** | CC BY 4.0 OA PDF (~7.5 MB); `%PDF` verified 2026-11-02. |
| 10.1088/1742-6596/2600/14/142003 | `Experiment papers/Sound_evidence/Sound - Tartarini2023 - Cozie Apple environmental quality physiological JPCS.pdf` | **new download** | IOP JPCS OA PDF (~3.6 MB). |
| 10.3390/ijerph13010140 | `Experiment papers/Sound_evidence/Sound - Heart Rate, Stress, and Occupational Noise Exposure among Electronic Waste Recycling Workers.pdf` | **local/exists** | Burns et al. 2016; valid PDF (~1.8 MB). |
| 10.3390/ijerph16050788 | `Experiment papers/Sound_evidence/Sound - Moshammer et al 2019 IJERPH acute air pollution noise road traffic panel HRV.pdf` | **local/exists** | Valid PDF (~523 KB). |

## Verification rule

All listed PDFs pass `%PDF` header check and size > 50 KB (verified 2026-11-02).

## Methods fit check — verified from local PDF (2026-11-02)

- **Tohidi 2025:** Primary inference is **three-way ANOVA** (ambient temperature × sound type × noise level) on heart rate in 216 elderly men (20/25/30 °C; 55–85 dBA; music/traffic/crowd). Script’s **two-way** temperature×noise branch omits sound type and is not an exact replication; appendix also reports **two-way ANOVAs** with sound type held constant (e.g. music only). Field binning and repeated-participant structure still require dependency-aware analysis in our pipeline.
- **Abbasi 2020:** **Within-subjects** design: 35 men, **eight sessions**, **four air temperatures including 18 °C** (18/22/26/30 °C) × 55/75 dBA; **repeated-measures ANOVA** (Huynh–Feldt if sphericity fails), Tukey post hoc, effect sizes. Script should document that omitting **18 °C** is an adaptation; N-back workload levels and EEG/ECG endpoints differ from our HRV field outcomes.
- **Dehghan 2017:** Quasi-experiment; **Friedman** on BP under heat (40 °C), noise (75/85/95 dB), and combined conditions — aligns with Friedman extension in `SOURCE_METHOD_VERIFICATION.md`; BP endpoints unavailable in our data.
- **Korpilo 2024 (field replacement):** Multisensory **field RCT** (n=45) across beach/forest/urban park; restoration vs landscape/soundscape quality (NDSI, PEQ scales) — supports field soundscape/HRV-adjacent evidence, not a chamber factorial match to H4 primary tests.

## Additional candidates (download pass 2026-11-02)

Legal/OA channels only (publisher, MDPI, Nature, PMC, institutional mirrors). **7/7** saved as of 2026-11-02 (Li/Tu/Qin via user-saved ScienceDirect PDFs, renamed from `1-s2.0-*` default names to the `Sound - AuthorYear - short title.pdf` pattern); all saved PDFs pass `%PDF` and size > 50 KB.

| # | Citation (short) | DOI | Status | Saved path / reason |
|---|------------------|-----|--------|---------------------|
| 1 | Li et al. 2026 — noise × odor × outdoor thermal stress, construction workers, EEG (*Build Environ*) | [10.1016/j.buildenv.2026.114576](https://doi.org/10.1016/j.buildenv.2026.114576) | **downloaded (user-saved)** | `Experiment papers/Sound_evidence/Sound - Li2026 - noise odor construction workers outdoor thermal stress.pdf` (user-saved ScienceDirect PDF, renamed from `1-s2.0-S0360132326003811-main.pdf`, first page verified 2026-11-02). Earlier agent fetches were 403-blocked from this environment. |
| 2 | Tu et al. 2026 — restorative pathways, urban walking crossover, EDA (*EIAR*) | [10.1016/j.eiar.2026.108642](https://doi.org/10.1016/j.eiar.2026.108642) | **downloaded (user-saved)** | `Experiment papers/Sound_evidence/Sound - Tu2026 - restorative responses urban walking crossover field trial.pdf` (user-saved ScienceDirect PDF, renamed from `1-s2.0-S0195925526003161-main.pdf`, first page verified 2026-11-02). |
| 3 | Lan et al. 2024 — thermal + air quality, urban parks, HR/HRV/EDA (*Forests*) | [10.3390/f15091640](https://doi.org/10.3390/f15091640) | **downloaded** | `Experiment papers/Sound_evidence/Sound - Lan2024 - urban parks thermal air quality physio.pdf` (~15.3 MB; MDPI `mdpi-res.com`, gold OA). |
| 4 | Schaupp et al. 2025 — forest vs urban walk, traffic noise, cortisol/SCL (*J Environ Psychol*) | [10.1016/j.jenvp.2025.102662](https://doi.org/10.1016/j.jenvp.2025.102662) | **downloaded** | `Experiment papers/Sound_evidence/Sound - Schaupp2025 - forest urban walk noise psychophys.pdf` (~7.0 MB; hybrid OA CC-BY; institutional mirror [DORA Empa](https://www.dora.lib4ri.ch/empa/dload/empa:41923/PDF/view)). Publisher `pdfft` returned 403 here. |
| 5 | Qin et al. 2024 — sound, humidity, thermal comfort (*Urban Climate*, survey) | [10.1016/j.uclim.2024.101967](https://doi.org/10.1016/j.uclim.2024.101967) | **downloaded (user-saved)** | `Experiment papers/Sound_evidence/Sound - Qin2024 - sound humidity outdoor thermal comfort cold regions.pdf` (user-saved ScienceDirect PDF, renamed from `1-s2.0-S2212095524001639-main.pdf`, first page verified 2026-11-02: *Urban Climate* 55:101967). |
| 6 | Lam et al. 2024 — PEQ, psychological status, outdoor thermal comfort walks (*Sustain Cities Soc*) | [10.1016/j.scs.2024.105578](https://doi.org/10.1016/j.scs.2024.105578) | **downloaded** | `Experiment papers/Sound_evidence/Sound - Lam2024 - PEQ outdoor thermal comfort walks.pdf` (~3.6 MB; green OA [PEARL Plymouth](https://pearl.plymouth.ac.uk/cgi/viewcontent.cgi?article=2047&context=gees-research)). |
| 7 | Zhang et al. 2026 — thermal × acoustic × aesthetic parks (*Sci Rep*) | [10.1038/s41598-026-39787-8](https://doi.org/10.1038/s41598-026-39787-8) | **downloaded** | `Experiment papers/Sound_evidence/Sound - Zhang2026 - thermal acoustic aesthetic parks.pdf` (~5.7 MB; Nature Sci Reports OA `_reference.pdf`; PMC indexed PMC12976342 but PDF fetch blocked here). |

**Not the same as local Sci Reports PDF:** `Sound - Yousefinezhad2026...pdf` is DOI [10.1038/s41598-026-41251-6](https://doi.org/10.1038/s41598-026-41251-6) (chamber Yousefinezhad), not Zhang #7.

## Scopus screen add-on (2026-11-08)

| Citation (short) | DOI | Status | Saved path / notes |
|------------------|-----|--------|---------------------|
| Peng et al. 2026 — greenway plaza openness × multisensory × behavior (*Urban Science*) | [10.3390/urbansci10010060](https://doi.org/10.3390/urbansci10010060) | **downloaded** | `Sound - Peng2026 - Multisensory greenway plazas openness.pdf` (~2.6 MB; MDPI `mdpi-res.com` mirror; `%PDF` verified 2026-11-08). |
| Şimşek 2026 — auditory comfort, parks, thermal/visual (*SREES*) | [10.22630/srees.11113](https://doi.org/10.22630/srees.11113) | **downloaded** | `Sound - Simsek2026 - auditory comfort thermal visual urban parks.pdf` (~2.0 MB; [srees.sggw.edu.pl](https://srees.sggw.edu.pl/article/download/11113/10024); `%PDF` verified 2026-11-08). |
| Tang et al. 2026 — soundscape diversity × thermal stress, HR/BP/EEG (*Build Environ*) | [10.1016/j.buildenv.2026.114742](https://doi.org/10.1016/j.buildenv.2026.114742) | **downloaded (user-saved)** | `Sound - Tang2026 - soundscape diversity thermo physiological sex dimorphic.pdf` (~22 MB; ScienceDirect `S0360132326005470`; verified 2026-11-08). |

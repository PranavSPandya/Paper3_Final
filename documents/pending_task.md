# Paper 3 - pending tasks before submission to Urban Climate

## 1. Header

- Purpose: every task left to make C:\Users\sanga\Desktop\Pranav Paper3_Final\documents\Paper3_outline_ml.md ready to submit.
- Date: 31 Oct 2026.
- Target journal: Urban Climate (Elsevier, ISSN 2212-0955). Submission system: https://www.editorialmanager.com/uclim/default.aspx
- Journal requirements source: https://www.sciencedirect.com/journal/urban-climate/publish/guide-for-authors (accessed 31 Oct 2026). The live page blocked automated access (captcha). Requirements in section 6 were read from the most recent archived copy of that same page (Wayback Machine, 2 Apr 2024): https://web.archive.org/web/20240402165207/https://www.sciencedirect.com/journal/urban-climate/publish/guide-for-authors . Open the live guide once in a browser and re-check section 6 before submitting.
- Outline state: 843 lines, checked 31 Oct 2026. Line numbers below are current.
- Study facts: N = 11 participants; phases WalkU, WalkG, BikeU, BikeG (+ Tram, descriptive); Brussels, Aug 2025. H4 time-series: 0 terms with q < 0.05 across 9 runs (572 models each). H4_sound_tests: 45 q_all hits in 7 of 64 folders, all from phase-mean or no-Phase models.
- Priority: Must = blocks submission. Should = strongly advised.
- Rule: nothing in section 3 is run without Pranav's explicit go-ahead.

## 2. Decisions needed from Pranav first

- [ ] Must - D1. Primary H4 model. The outline calls the phase-mean model primary (lines 5, 83, 177, 270-283, 407), but the run settings label the 10 s time-series as the pre-specified primary. Pick one and use it everywhere.
- [ ] Must - D2. H4 covariates. Irradiance and GVI only exist in the time-series Eq1, but lines 73 and 177 claim them for the phase-mean model. Either add them to the phase-mean model or remove them from the text.
- [ ] Must - D3. VIF cutoff. Outline says 10 (lines 121, 177); the run uses 5. Max observed VIF = 2.91. Pick one value.
- [ ] Must - D4. H4_minimal_utci_dba.R does not exist, but line 357 reports numbers from it. Either write and run it, or delete lines 187 and 357 and the `H4_minimal_utci_dba/` mention at line 195.
- [ ] Must - D5. H4_sound_tests (64 scripts) check for 24 sounds; the locked list has 22. Fix to 22 and rerun, or leave that track out of the paper.
- [ ] Must - D6. H1 hit count: 11/52 (27 Oct run) vs 12/52 (pushed 11 Oct run). Pick the run of record.
- [ ] Must - D7. H3 hit count: 11/52 is the z-score sensitivity run; the primary run gave 8/52. Report 8/52 as primary (11/52 only as sensitivity).
- [ ] Must - D8. H1 promises perceived comfort (line 35). Either cite H6_1 PRS green vs urban (q = 0.008) as the perceived-comfort evidence, or narrow H1 to physiology.
- [ ] Should - D9. Move Sections 7-9 (lines 447-843) to the supplement (they are design notes and extra analyses, not part of the paper core).

## 3. Analysis reruns (need explicit go-ahead before running anything)

- [ ] Must - R1. Rerun C:\Users\sanga\Desktop\Pranav Paper3_Final\scripts\statistical_analysis\H4_phaseavg.R. Saved results are from 27 Oct; the script changed after that.
- [ ] Must - R2. Rerun C:\Users\sanga\Desktop\Pranav Paper3_Final\scripts\statistical_analysis\H4_phaseavg_sound.R with the 22 locked sounds (main folder + wind_aws_le_5ms folder).
- [ ] Must - R3. Rerun the time-series sound wind-screen runs (H4_timeseries_sound.R, wind_aws_le_5ms) at 10 s, 30 s, 60 s and 300 s with the 22 sounds.
- [ ] Must - R4. If D4 = keep: write and run H4_minimal_utci_dba.R (pooled + single-phase 10 s, with --wind-sensitivity), then update line 357 from its CSV.
- [ ] Must - R5. If D5 = keep: change the 64 H4_sound_tests scripts from 24 to 22 sounds and rerun.
- [ ] Must - R6. Rerun or confirm H9 and H5 RH1 (both scripts changed after the saved results).
- [ ] Must - R7. After all reruns: regenerate all figures and tables from the final runs (current figures are from 28 Oct).

## 4. Outline / manuscript text fixes (current line numbers)

Overclaims (Must):
- [ ] Must - T1. Tonic EDA was never FDR-significant (H1 q = 0.30-0.49; H3 q = 0.35-0.67). Remove tonic EDA from the result claims at lines 5, 217, 254, 391, 395, 411.
- [ ] Must - T2. H3 skin temperature and fixation rate were not FDR-significant. Remove them from the H3 claims at lines 5, 254, 395, 411.
- [ ] Must - T3. Lines 5 and 413 say physiological-perceptual concordance was not confirmed, but H2 had 5 FDR hits (5/104). Rewrite both lines to report the 5/104.
- [ ] Must - T4. Line 189: 'explains' overclaims. Use 'is associated with' or similar.
- [ ] Must - T5. Check: line 5 says thermal-by-noise interactions did not survive FDR in phase-mean models, while line 283 reports 24 H4 terms with q < 0.05. After R1, state exactly which term types the 24 hits are.

Numbers and counts (Must):
- [ ] Must - T6. Replace '598' and '780 models' (lines 189, 353, 355) with the final run numbers (time-series runs now have 572 models each).
- [ ] Must - T7. Line 185: '23 measures' -> 22 sounds. Line 189: '23 sound measures x 26 outcomes = 598' -> recompute with 22.
- [ ] Must - T8. Update H1 count (D6) and H3 count (D7) wherever they appear in 3.2, 3.4, Discussion and Conclusion.

Design description (Must, reviewer-level errors):
- [ ] Must - T9. Line 55: phase labels read 'BikeU, WalkU, WalkG, WalkG' - the second WalkG must be BikeG.
- [ ] Must - T10. Line 55: dates 'from 3 July to 27 August 2025' -> 3-26 Aug 2025. Same fix at line 603 ('July-August 2025').
- [ ] Must - T11. Line 57: 'counterbalanced routes' is wrong. WalkG always came before BikeG (this confounds H3.2). Also fix 'counterbalanced' at lines 578 and 662.
- [ ] Must - T12. Line 57: 'All streams were time-aligned to UTC' - correct the time base to what the pipeline actually uses.
- [ ] Must - T13. Line 67: inclusion 'age 18-40' conflicts with the analysed participants (ages 24-58). Report the actual range and fix the inclusion text.
- [ ] Must - T14. Line 67: 'minimum detectable f = 0.52' -> report as eta2 = 0.21 (the text next to it says partial eta2 = 0.11; correct it).
- [ ] Must - T15. Lines 217, 391, 791: 'square-root-transformed tonic EDA' is wrong. Code uses natural log (or no transform). Use the actual transform.
- [ ] Must - T16. Lines 193 and 213: remove D:\ local paths (line 193 points to D:\Pranav\docker\...). Replace with a citation or supplement reference.
- [ ] Must - T17. Hypothesis labels jump from H6 to H9 (no H7, H8). Renumber or add one sentence explaining the gap (lines 45-47, 81, 83, 322).
- [ ] Must - T18. 'matched eight-minute' / '8 min' segments (lines 73, 89) -> 470 s. Also check lines 207, 461, 723, 747.
- [ ] Must - T19. Flowchart labels 'FDR - 26 outcomes x contrasts' (lines 101, 115) -> 'FDR across 26 outcomes, per contrast'.
- [ ] Must - T20. Line 121 flowchart 'Design VIF screen - limit 10' -> value chosen in D3.

Limitations and diagnostics (Must):
- [ ] Must - T21. Line 407 (Limitations): add the order confound (WalkG always before BikeG).
- [ ] Must - T22. Section 3.9 (line 347): add two lines on model checks - report the VIFs (max 2.91) and singular fits (34/182 phase-mean and 65/182 time-series models with near-zero between-person variance).

Discussion and results (Should):
- [ ] Should - T23. Expand Discussion 4.3 (line 397) and 4.4 (line 401).
- [ ] Should - T24. Add a short discussion of H5, H6 and H9 (no Discussion subsection covers them now).
- [ ] Should - T25. Report Bonett effect sizes next to q values (already in H1_Contrasts.csv).

## 5. Tables, figures, references

Tables:
- [ ] Must - F1. Tables 1 and 2 (lines 363-385) are marked 'illustrative' and use old sqrt EDA names. Delete or rebuild from the final CSVs.
- [ ] Should - F2. Add a participant table (age, sex, height, weight, BMI) in 3.1 (line 211).
- [ ] Should - F3. Add an exposure-by-phase table (UTCI, dBA, PM, lux per phase) in 3.1.
- [ ] Must - F4. Number all tables consecutively in order of first mention; table notes under the table; tables as editable text, not images.

Figures:
- [ ] Must - F5. Regenerate all figures from the final runs (after R1-R7).
- [ ] Must - F6. Lines 59, 61, 63 are placeholders ('Figure: Experiment timeline', 'trajectory', 'Sensors'). Number them and write real captions (title + description, all symbols explained).
- [ ] Should - F7. Make the heat x sound predicted-value plot promised at lines 272 and 403, or remove the promise.
- [ ] Must - F8. Export figures at journal resolution (see S14).

References:
- [ ] Must - B1. Add to the reference list (cited in text, missing from list at lines 415-445): Bakdash & Marusich 2017 (cited at 169, 723), Gong 2018, Benjamini & Hochberg 1995 (cited at 5, 81, 123, 161, 189, 207, 324...).
- [ ] Must - B2. No PDF in the literature folder for: AR(1) source, CR2 source (cited line 187), Bonett 2008, Neale 2022, Anusha 2018, Marins 2014. Get the PDFs and check each citation.
- [ ] Must - B3. Check every in-text citation has a list entry and vice versa (reference list has only 15 non-empty lines at 416-445).
- [ ] Must - B4. Format the list as author-year, alphabetical, with DOIs (see S11).

## 6. Urban Climate submission requirements

Source: archived copy (2 Apr 2024) of the official guide; live page blocked on 31 Oct 2026. Re-check on the live guide.

- [ ] Must - S1. Article type: choose in Editorial Manager. Article types and word/length limits were NOT stated on the archived page - check on the live guide. (A third-party site, scraiber.com, lists Full length Article 10,000 words, abstract 250 words - unverified, check on the guide.)
- [ ] Must - S2. Abstract: concise, factual, stands alone; purpose, principal results, major conclusions; avoid references and non-standard abbreviations. Word limit not stated on the archived page - check on the guide. Current abstract (line 5) = 161 words.
- [ ] Must - S3. Keywords: max 6, right after the abstract, American spelling, no general/plural terms, avoid 'and'/'of'. Current line 7 has 6 - OK; recheck after edits.
- [ ] Must - S4. Highlights: mandatory. Separate editable file with 'Highlights' in the file name; 3-5 bullets, max 85 characters each including spaces. Not written yet.
- [ ] Should - S5. Graphical abstract: listed 'where applicable' in the submission checklist; no size spec on the archived page - check on the guide.
- [ ] Must - S6. Title page: concise title (avoid abbreviations/formulae), all author names and affiliations (full postal address, country, e-mails), corresponding author clearly marked with e-mail and full postal address.
- [ ] Must - S7. Declaration of competing interest: required even if none.
- [ ] Must - S8. CRediT author contribution statement (14 CRediT roles) for all authors.
- [ ] Must - S9. Funding: state funders in standard form with grant numbers and the sponsor's role; if none, use 'This research did not receive any specific grant from funding agencies in the public, commercial, or not-for-profit sectors.'
- [ ] Must - S10. Declaration of Generative AI and AI-assisted technologies in the writing process: new section at the end of the manuscript, before References, using the journal's statement template, if any AI tool was used in writing.
- [ ] Must - S11. References: any consistent style accepted at submission; final style is author-year (Name, year; 'et al.' for 3+ authors), list alphabetical then chronological, 2000a/2000b for same author-year, DOIs encouraged, journal names abbreviated (ISO title word list). Cite datasets with a [dataset] reference.
- [ ] Must - S12. Data availability statement: required; given during submission and published with the article.
- [ ] Must - S13. Ethics: guide points to Elsevier 'Ethics in publishing'; for human-participant research, add the ethics approval reference (line 67 still says 'approval reference from approved PDF') and informed-consent statement. Sex/gender: report sex of participants and address sex/gender (SGBA guidance on the page).
- [ ] Must - S14. Figures: TIFF/JPG photos >= 300 dpi; bitmapped line drawings >= 1000 dpi; combinations >= 500 dpi; or EPS/PDF/MS Office. Each figure needs a caption; say if colour is needed in print.
- [ ] Must - S15. Manuscript structure: numbered sections (1, 1.1, 1.1.1); abstract not numbered; must contain Abstract, Keywords, Introduction, Methods, Results, Conclusions, figures and tables with captions. Appendices as A, B with Eq. (A.1), Table A.1, Fig. A.1.
- [ ] Must - S16. Format at first submission: single Word or PDF file accepted ('Your Paper Your Way'); editable source (Word/LaTeX) needed at revision.
- [ ] Must - S17. Supplementary material: include it with the initial submission (relevant if Sections 7-9 move to the supplement).
- [ ] Must - S18. Suggested reviewers: names and institutional e-mails of several reviewers; no colleagues or co-authors from the last 3 years.
- [ ] Must - S19. Submission checklist from the guide: spell/grammar check; all references cited and vice versa; permissions for copyrighted material (check route maps / sensor photos at lines 59-63); competing interests statement; reviewer suggestions.
- [ ] Should - S20. Acknowledgements: separate section before References (not on title page).
- [ ] Should - S21. Abbreviations: define non-standard ones in a first-page footnote (UTCI, EDA, GVI, SVF, PRS, etc.).
- [ ] Should - S22. Language: one variety only (American or British). Outline mixes them (e.g. 'stabilisation' at line 395) - pick one.
- [ ] Should - S23. Review is single anonymized - no blinding of the manuscript needed.
- [ ] Should - S24. Cover letter and line numbering: not stated on the archived page - check on the live guide.
- [ ] Should - S25. Optional SSRN preprint during submission - decide yes/no.

## 7. Housekeeping (Pranav decides; nothing has been deleted)

- [ ] Should - K1. Stale folder: C:\Users\sanga\Desktop\Pranav Paper3_Final\output\statistical_analysis\results\H4_timeseries_sound_30s (superseded by H4_timeseries_sound\epoch_30s).
- [ ] Should - K2. Large dump files: C:\Users\sanga\agent-tools\e585d936-9c78-4d76-99d3-82b41e460a9f.txt and C:\Users\sanga\agent-tools\bac4a48a-2121-4eac-84af-aed5da8ed17b.txt.
- [ ] Should - K3. Backup copy: %TEMP%\H4_timeseries_sound.orig_backup.R.
- [ ] Should - K4. Archive backup: C:\Users\sanga\Desktop\Pranav Paper3_Final\Documents\_archive\H4_Screening_Literature_Guide_before_complete_20261031_0039.md.
- [ ] Should - K5. Misfiled PDFs: the 'Empatica - Stress in the City' PDF actually contains a traffic-sign paper; the Rodrigues Lisbon PDF is duplicated in Sound_evidence; the Lloyd & Havenith commentary has no sound data.
- [ ] Should - K6. Fix 2,156 -> 2,112 epochs in C:\Users\sanga\Desktop\Pranav Paper3_Final\documents\H4_Screening_Literature_Guide.md (the runs use 2,112; outline line 191 already says 2112).

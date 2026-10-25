# PhD Status & Progress Tracker (Single Source of Truth)

> **File Purpose:** Authoritative, stage-by-stage status tracking of the PhD journey, compiled by reading the chronological history of `WORK_DIARY.md` (600+ entries) and `Tasks.md`, benchmarked directly against [PhD_proposal.md](./PhD_proposal.md).
>
> **Last Synchronized:** 2026-09-29 21:02:21  
> **Candidate:** Pranav Shailesh Pandya  
> **Institution:** UCLouvain | **Funding:** F.R.S.-FNRS (Aspirant / Research Fellow, Ref: 40011852)  
> **PhD Topic:** Urban Green Infrastructure for Stress Reduction and Thermal Comfort (GIST)

---

## 1. High-Level PhD Milestone Summary

```
[WP1] Systematic Review & Framework  ──► [DONE -> PUBLISHED]
[WP1] Human Ethics Protocol Clearance──► [DONE -> APPROVED]
[WP2] Macro Geospatial & Climate Reanalysis ──► [DONE]
[WP3] Paper 2: Bike Count & GVI Modeling ───► [REVISIONS COMPLETED -> RESUBMISSION READY]
[WP4] Paper 3: Multi-Sensor Field Campaign ──► [FIELD EXPERIMENT DONE | PRIMARY ANALYSIS CURRENT | OUTLINE RESOLVED | MANUSCRIPT DRAFTING REMAINS]
       ├── Sensor Processing Pipelines      ──► [DONE] (Empatica, UCM, Atmo/LYS, Eye Tracker, Surveys)
       ├── Validation & Phase Alignment    ──► [DONE] (`key.csv` synchronized with Indoor windows)
       ├── Merged Master Dataset (8-min)   ──► [DONE -> LOCKED] (`merged_all_11participants_8min.csv`, 5,077 rows)
       ├── Statistical & Temporal Modeling  ──► [CURRENT OUTPUTS VERIFIED] (H1-H4 LMMs, H2 concurrence, separate temporal AR(1) analysis)
       ├── GVI Route Imagery & Features      ──► [DONE] (GSV/Mapillary point metrics merged for full and matched datasets)
       ├── Publication Figures             ──► [PARTIAL] (inferential figures regenerated; Maider's full H1 domain/participant-variability layout remains)
       ├── Reviewer Comments & Outline     ──► [DONE] (`Paper3_outline_ml.md` resolved and verified)
       └── Manuscript Full Text Drafting   ──► [IN PROGRESS] (Ready to draft into `Paper3_Manuscript.md`)
[WP5] Doctoral Thesis Packaging & Defense  ──► [PENDING]
```

---

## 2. Chronological Progression & Detailed Status by Paper

### 📄 Paper 1 (WP1): Systematic Literature Review & Experimental Framework
- **Official Title:** *Environmental and psychophysiological data collection for urban outdoor thermal comfort assessment*
- **Current Status:** `DONE -> Published`
- **Target Deliverable:** Paper #1 published in peer-reviewed international journal.
- **Current State:** Completed, fully documented, and referenced in thesis Chapter 2.

---

### 📄 Paper 2 (WP3): Bicycle Mobility, Weather Extremes & Green View Index
- **Topic:** Investigating how urban morphology, seasonal weather extremes, and street greenery (GVI) influence bicycle flow across 18 stations in Brussels (2019–2023).
- **Current Status:** `REVISIONS COMPLETED -> READY FOR RESUBMISSION`
- **What is strictly LEFT for Paper 2:**
  - `[PENDING]` Final verification check of the standalone package `C:\Users\pandya\OneDrive - UCL\Data shared\Response 30Mar\Paper2_Revision\Resubmission package`.
  - `[PENDING]` Portal upload to journal for second round review.
  - **LOCKED ANTI-REDO RULE:** All models, coefficients, and tables for Paper 2 are FROZEN. Do NOT re-run scripts or modify results.

---

### 📄 Paper 3 (WP4): Human-Centered Multi-Sensor Field Campaign
- **Topic:** Real-time physiological stress, subjective psychological comfort, personal exposure, and eye tracking across contrasting urban and green environments for active mobility users.
- **Current Status:** `8-MIN HARMONIZATION COMPLETED | LMM PIPELINE FINALIZED | PUBLICATION FIGURES GENERATED | OUTLINE RESOLVED | READY FOR FULL TEXT DRAFTING`
- **Detailed Component-by-Component Breakdown:**

| Component / Sub-Task | Status | Progress & Authoritative Details |
|---|---|---|
| **1. Ethics & Approvals** | **`[DONE]`** | Fully approved by UCLouvain Ethics Committee (`Formulaire Commission éthique_ABCD_27May25_signed.pdf`). |
| **2. Field Experiment Campaign** | **`[DONE]`** | 18 participants recruited and tested (P2 to P18 complete cohort). Active analysis focuses on 11 selected complete participants (P4, P8–P17). |
| **3. Staged Raw Sensor Data** | **`[DONE]`** | Canonical raw sensor data read-only under `C:\Users\pandya\Documents\Github\docker\Paper3_Github\rawdata`. |
| **4. Participant Phase Key Table** | **`[DONE]`** | Authoritative key file established: `C:\Users\pandya\Documents\Github\docker\Paper3_Github\output\key.csv`. |
| **5. Sensor Pipelines & Processing** | **`[DONE]`** | All 5 pipelines executed: Empatica (HR, EDA, HRV, Temp), UCM (PET, UTCI, MRT, Noise, Air), Atmo/LYS (PM, Lux), Eye Tracker (Pupil, Blinks, Fixations, Saccades), Questionnaires (STAI, PRS, Comfort). |
| **6. Canonical Merged Dataset (8-min)** | **`[DONE -> LOCKED]`** | Authoritative 8-min matched dataset finalized: `C:\Users\pandya\Documents\Github\docker\Paper3_Github\output\merged_all_11participants_8min.csv` (5,077 rows: 2,691 route rows clipped to 0-480 s; 412 Indoor and 1,974 reststop rows preserved). |
| **7. Hypothesis Testing (H1 to H3)** | **`[DONE]`** | Full $2 \times 2$ factorial LMM pipeline (`Mode * Environment + (1\|ParticipantID)`) executed via `statistical_analysis.R` on matched 8-min routes: <br>• H1 Green vs Urban cooling (Skin temp $d = -1.42$ bike, $-1.41$ walk, $q_{\text{FDR}} < 0.007$) and autonomic reduction (EDA tonic $d = -1.25$ walk, $q_{\text{FDR}} = 0.013$); PRS-11 restorativeness ($d = 4.69$ bike, $3.12$ walk, $q_{\text{FDR}} < 0.001$). <br>• H2 Concurrence established via within-person LMMs for skin temperature, pupil diameter, blink duration, fixation duration, and gaze eccentricity ($q_{\text{FDR}} < 0.05$). <br>• H3 Mode contrasts (Blink duration $d = 5.90$ urban, $4.15$ green; Gaze velocity $d = 2.99$ and $1.15$; Cycling green comfort $d = -1.43, q_{\text{FDR}} = 0.011$). |
| **8. Environmental Predictor-Stream Models (H4)** | **`[CURRENT OUTPUTS VERIFIED]`** | Current `H4_Environmental_Stressors.csv` contains 5,021 model rows across normalization branches. The primary matched 8-minute within-person z-score branch contains 1,501 models; 254 survived Benjamini-Hochberg FDR correction across 50 predictor streams. These are correlated single-predictor associations, not independent causal stressor effects; questionnaire comfort is not an H4 outcome. |
| **8a. GVI Route Imagery & Features** | **`[DONE]`** | GSV and Mapillary 50 m point-level GVI, tree, grass, and plant metrics are merged into both full-duration and matched 8-minute datasets. Shared GVI columns are present for all route phases, including Tram; invalid spatial matches at or above 50 m were removed, with a maximum retained match distance of 48.004 m. Phase-level GVI, tree, grass, and plant means are included. |
| **9. Temporal AR(1) Models** | **`[SECONDARY / DIAGNOSTIC]`** | `H1_H3_Temporal_TimeSeries_AR1.csv` currently contains 96 rows using `corAR1`. These quantify temporal association and serial dependence; they do not replace the primary matched phase-level contrasts or establish causality. |
| **10. Publication Figures** | **`[PARTIAL]`** | Inferential forest/synthesis figures and additional exposure figures are regenerated from the matched 8-minute dataset. Maider's requested three H1 domain plots, participant-coloured point plots with legend, fixed indicator order, and full-versus-matched selection plots are not all implemented in the current notebook. |
| **11. Reviewer Comments & Outline Resolution** | **`[DONE WITH ONE PARTIAL FIGURE REQUEST]`** | `Paper3_outline_ml.md` contains the 13 reviewer comments and their resolutions. Maider's exact single-participant combined environment-plus-physiology panorama is documented as partial because it is not currently implemented. |
| **12. Cleanup & Redundancy Removal** | **`[DONE]`** | Deleted exploratory cluster analysis script and output directory `output/cluster analysis/`. Completely removed non-requested unified multivariable models. |
| **13. Manuscript Full Text Drafting** | **`[IN PROGRESS]`** | Outline is synchronized; full Results, Discussion, Methods, and final manuscript prose remain to be drafted and internally reviewed. |

---

## 3. Permanent "LOCKED / DO NOT REDO" Registry

The following outputs have been verified and finalized. **They must NEVER be recomputed, overwritten, or modified:**

| Locked Output Item | Authoritative Path | Verification / Proof |
|---|---|---|
| **Paper 2 Primary Results** | `02_primary_NB2_output_summer/NB2_master_results_table.csv` | Full NB2 coefficients and hypothesis test outputs verified. |
| **Paper 2 Master Dataset** | `Paper2_Revision/PreparedForModel_micro_nomicro_21May_Final.csv` | 473,454 rows, 94 audited columns. |
| **Paper 3 Canonical 8-min Dataset** | `Paper3_Github/output/merged_all_11participants_8min.csv` | 5,077 rows, 172 columns: 2,691 route rows capped at 0-480 s plus intact Indoor/reststop baseline rows. |
| **Paper 3 Participant Phase Key** | `Paper3_Github/output/key.csv` | Active canonical phase boundary table. |
| **Paper 3 Statistical Pipeline Output** | `Paper3_Analysis/output/statistical_analysis/results_H1-4.csv` | 5,457 total output rows across H1-H4; H4 contributes 5,021 rows, with 1,501 in the primary matched 8-minute WPZ branch. |
| **Paper 3 Publication Figures** | `Paper3_Analysis/output/Figures/` | Figures 1-10 regenerated via `Paper3_Figures.ipynb`. |
| **Paper 3 Approved Outline** | `Paper3_Analysis/documents/Paper3_outline_ml.md` | All 13 reviewer comments resolved; Table 1 & Table 2 matched to 8-min models. |

---

## 4. Immediate High-Yield Action Priorities

1. **Priority 1 (Paper 3 Manuscript Drafting):** Draft the full paper text from [Paper3_outline_ml.md](./source_documents/Paper3_outline_ml.md), keeping primary matched phase-level contrasts separate from H4 predictor-stream associations and secondary temporal AR(1) results.
2. **Priority 2 (Paper 3 Figure Completion):** Complete and audit Maider's requested H1 figure set: physiology, environment, and psychology domain plots; participant-coloured points with legend and no connecting lines for phase comparisons; fixed indicator order; internal full-versus-matched comparison; and effect estimates/CIs. The single-participant combined panorama remains an additional unresolved request.
3. **Priority 3 (Methods metadata):** Obtain the official ethics reference code and participant demographic summaries ($N=11$ age $M \pm SD$, gender breakdown, fitness) if they are not already available in the manuscript materials.
4. **Priority 4 (Paper 2 Resubmission Portal):** Upload the completed `Resubmission package` to the journal portal.

# Paper 2 revision

Created: 2026-08-16

## Purpose

This is a row- and cell-level audit of the authoritative Excel reviewer tracker against Ariana's 11 August 2026 Paper 2 revision meeting. It records what is already acceptable, what Ariana asked to change, and the wording I recommend changing before synchronising the response DOCX and manuscript.

This audit is read-only with respect to the Excel workbook, response DOCX and manuscript. None of those three files has been edited.

## Authoritative files

- [Reviewer_comment.xlsx](<C:\Users\pandya\OneDrive - UCL\Pranav PhD\Paper 2\Building and Environment submission\Internal review_07May\Resubmission 1\Reviewer_comment.xlsx>) — current response tracker.
- [Reviewer comments_response.docx](<C:\Users\pandya\OneDrive - UCL\Pranav PhD\Paper 2\Building and Environment submission\Internal review_07May\Resubmission 1\Reviewer comments_response.docx>) — response document to synchronise later.
- [Latest_Paper_update.docx](<C:\Users\pandya\OneDrive - UCL\Pranav PhD\Paper 2\Building and Environment submission\Internal review_07May\Resubmission 1\Latest_Paper_update.docx>) — manuscript to synchronise later.
- [Paper 2 revision.txt](<./Paper 2 revision.txt>) — renamed Ariana meeting transcript.

The backup `Reviewer comments.docx` was deliberately excluded from this audit.

## Excel map

In the `Comments` sheet:

- `A2:A27` = comment IDs;
- `D2:D27` = reviewer comments;
- `E2:E27` = responses;
- `F2:F27` = manuscript locations;
- `G2:G27` = `Finished?` status.

In the `Action_matrix` sheet:

- `D2:D23` = what was done;
- `G2:G23` = required change to;
- `K2:K23` = paper-updated status.

Current tracker status is not yet a reliable completion gate: the `Comments` sheet has 7 rows marked `Updated` and 19 blank, while `Action_matrix` has 15 `Pending`, 3 `Partially updated`, and 4 `Updated` rows.

## What Ariana disagreed with

The meeting criticism was mainly about the earlier response style and framing, not every sentence in the current XLSX. The main instructions were:

1. Do not accept the reviewer’s demand for a complex mixed model as automatically correct. Defend segmented ANOVA as primary; use a mixed/GEE model only as a secondary check where it is estimable and approved.
2. Do not write an agreeable response that simply says the reviewer is right. Explain the design choice and partially address the concern.
3. For R4.1, do not describe three equal objectives without identifying the methodological contribution and how the components form one workflow.
4. For sensitivity analysis, answer whether the conclusion changes, not only whether p-values change.
5. For R4.5, keep partial eta-squared, relative change and inferential significance separate, and verify H4 Q4.
6. For R4.10, do not say only “we streamlined the abstract”; paste the actual revised abstract.
7. Where possible, paste exact manuscript wording into the response instead of saying only “we added”, “we clarified” or “we revised”.

## Rows requiring wording changes or explicit confirmation

The following bold rows are the cells most directly affected by Ariana’s instructions. The current Excel contents are shown first; strike-through marks the part I would remove, and bold text is the proposed replacement.

### R1.2 and R4.3 — ANOVA must remain primary

The current `Comments!E4` and `Comments!E20` are substantively aligned with Ariana because they say ANOVA is primary and GEE is secondary. The remaining issue is the generic agreeable opening and the need to use exactly the same response in both rows.

| **Excel cells** | **Current issue** | **Proposed change** |
|---|---|---|
| **Comments!E4; Comments!E20; Action_matrix!D3/G3; Action_matrix!D16/G16** | **~~Thank you for the comment.~~ We retain the pre-specified segmented Type III ANOVA as the primary analysis and add an observed-only Poisson GEE...** | **The reviewer’s concern is addressed by retaining the pre-specified segmented Type III ANOVA as the primary analysis because the design is explicitly structured by quarter and weekend daytime, with station-normalised contrasts matching H1–H7. An observed-only Poisson GEE with AR(1) working correlation and robust standard errors is reported only as a secondary repeated-measures check. Its rate ratios, confidence intervals and BH-adjusted p-values remain separate from Table 1’s descriptive eta-squared and relative-change values.** |

Decision: keep the current ANOVA-primary substance; replace only the opening/style and make R1.2 and R4.3 identical.

### R4.1 — methodological contribution must lead

Ariana explicitly said that the earlier answer to this comment was confusing and did not explain the primary contribution. The current `Comments!E18` is much better and already contains useful exact manuscript wording, but its opening still begins defensively with “the three components already form one workflow”.

| **Excel cells** | **Current text to replace** | **Proposed replacement** |
|---|---|---|
| **Comments!E18; Action_matrix!D14/G14/K14** | **~~The three components already form one workflow; the revision makes their roles explicit rather than restructuring the analysis.~~** | **The primary contribution is a transferable methodology for linking automated bike counts with micrometeorological and urban indicators to assess environmental-comfort associations with cycling volumes. The three components form one workflow: temporal imputation is preprocessing for short gaps; environmental-comfort inference on observed weekend counts is the primary analysis for H1–H7; and new-station prediction is an exploratory extension that was not used for hypothesis testing.** |

Keep the two exact manuscript quotations already present later in `E18`, but make this methodological hierarchy the first sentence.

### R1.3 and R4.4 — report conclusion stability, including the H2 exception

The current `Comments!E5` and `Comments!E21` correctly say that heat is threshold-sensitive, but they omit an important current result: H2 Q3 changes direction at some high wind thresholds. Ariana specifically asked whether the conclusion changes.

| **Excel cells** | **Current text to replace** | **Proposed replacement** |
|---|---|---|
| **Comments!E5; Comments!E21; Action_matrix!D4/G4/K4; Action_matrix!D17/G17/K17** | **~~Rain and cold directions were stable in supported cells; heat was threshold-sensitive; and one-station comparisons were not forced.~~** | **Rain remained negative across supported cells. The wet-and-windy H2 conclusion was not threshold-invariant in Q3 at the highest wind cut-offs, so this sensitivity result must be reported explicitly. Heat direction and support were threshold-sensitive. Cold remained negative in the supported Q1 and Q4 cells. One-station comparisons were labelled inference-unavailable rather than interpreted as null results.** |

The current response should not claim that all rain/wind conclusions are stable without this H2-Q3 qualification.

### R4.10 — the abstract must be actual text, not a claim of editing

The current `Comments!E27` is substantially improved because it contains a full revised abstract. However, `Action_matrix!D23` still says only “streamlined abstract”, and the active manuscript still contains the old effect-size-heavy abstract.

| **Excel cells** | **Current text to replace** | **Proposed replacement** |
|---|---|---|
| **Action_matrix!D23/G23/K23** | **~~Streamlined abstract and standardised presentation, equations, captions, and references.~~** | **Replaced the effect-size-heavy abstract with the full text reproduced in `Comments!E27`; standardised the term “weekend biking” and checked equations, captions, citations and references against the revised manuscript.** |
| **Comments!E27** | **~~Abstract revised to foreground...~~** | **Keep the full revised abstract already pasted below this sentence, but do not mark the response complete until exactly that text appears in `Latest_Paper_update.docx`.** |

### R4.5 — current wording is substantively acceptable, but the manuscript must prove it

The current `Comments!E22` is aligned with Ariana’s instruction: it separates the quantities and reports the reproduced H4 Q4 values. I do not recommend changing its statistical substance. The required action is to make the manuscript Table 1 and Results contain exactly the values claimed:

- normalised partial eta-squared: **5.6%**;
- normalised relative change: **−39.31%**;
- raw partial eta-squared: **1.2%**;
- raw relative change: **−17.63%**;
- secondary GEE result: reported separately, not as the Table 1 effect.

Relevant cells: `Comments!E22`, `Action_matrix!D18/G18/K18`.

Do not leave the response saying “We corrected Table 1” while the active manuscript row remains blank or the backup still contains 16.1%/−10.5%.

## Cells that are factually acceptable but still need exact manuscript wording

These were not direct substantive disagreements in the current XLSX, but they do not fully satisfy Ariana’s instruction to paste the actual change:

| Excel cells | Current status | Required follow-up |
|---|---|---|
| `Comments!E7` / R1.5 | GVI timing explanation is substantively good. | Add the exact final GVI limitation sentence instead of ending with “See Section 2.2 and Limitations”. |
| `Comments!E13` / R3.3 | Correctly distinguishes GVI from SOLWEIG shade. | Paste the exact Section 2.2 sentence. |
| `Comments!E14` / R3.4 | Correctly restricts H5 to exploratory spatial association. | Paste the exact H5 Results sentence. |
| `Comments!E19` / R4.2 | Correctly addresses weekend purpose and GVI timing. | Paste the exact weekend-purpose and GVI limitation wording rather than “See also R1.1 and R1.5”. |
| `Comments!E25` / R4.8; `Action_matrix!D21/G21/K21` | Honest that conditional-effect uncertainty is incomplete. | Add the exact manuscript limitation and keep feature importance exploratory, not causal. |
| `Comments!E26` / R4.9; `Action_matrix!D22/G22/K22` | References are identified. | Paste the actual literature-positioning sentence(s), not only “additional positioning added”. |
| `Comments!E23` / R4.6 | Original-scale validation is clearly described. | Keep the exact Supplementary Table S2 sentence and ensure it appears in the manuscript. |

## Rows I agree with as currently written

- `Comments!E3` / R1.1 and `Comments!E11` / R3.1: weekend biking is defined as the sampling window and trip purpose is not inferred.
- `Comments!E7` / R1.5 and `Comments!E13:E14` / R3.3–R3.4: GVI is treated as static June 2025 spatial information, not time-matched causal greenness.
- `Comments!E8` / R1.6: planning recommendations are framed as future evaluation rather than proven interventions.
- `Comments!E12` / R3.2: city-wide wind and the absence of CFD are correctly stated as limitations.
- `Comments!E15` / R3.5: mixed bicycle/e-bike passage types and lack of vehicle-type deconfounding are acknowledged.
- `Comments!E23` / R4.6: original-count MAE, RMSE, sMAPE, bias and block masking are the correct validation direction.
- `Comments!E24` / R4.7: the response correctly withdraws historical R² = 0.73 as external-validation evidence and reports LOSO metrics.
- `Comments!E25` / R4.8: the response correctly keeps the RF analysis exploratory and non-causal.
- `Comments!E26` / R4.9: the suggested literature areas are correctly identified.

These rows still need manuscript verification; “agree with the wording” does not mean the corresponding change is already visible in the active DOCX.

## Immediate XLSX-only decisions

1. Keep the ANOVA-primary/GEE-secondary wording in `Comments!E4` and `Comments!E20`, but make the two cells identical and remove the generic agreeable opening.
2. Revise `Comments!E5` and `Comments!E21` to disclose the H2-Q3 high-wind threshold reversal.
3. Replace the opening of `Comments!E18` with the methodology-first wording above.
4. Replace the vague `Action_matrix!D23` wording with a statement that the full abstract is reproduced in `Comments!E27`.
5. Do not change the statistical values in `Comments!E22`; instead, later make the manuscript Table 1 and Results match it exactly.
6. Add exact manuscript quotations to the GVI, R4.2, R4.8 and R4.9 response cells before finalising the response DOCX.

No change has yet been made to the XLSX, response DOCX or manuscript.

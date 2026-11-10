# H4 — thesis-ready text (copy into Word)

**H4 on our data: supported** (paired WalkU − WalkG: thermal comfort *p* = 0.0097, visual comfort *p* = 0.0016; higher dBA and UTCI on WalkU, both *p* < 0.001).

**The 24 papers are for Methods only** (method families, not validation). Structure: [`H4_TEST_STRUCTURE.md`](H4_TEST_STRUCTURE.md) (Tier 1 = H4 significance).

**Numbers:** `H4_route_contrast_results.csv` (Tier 1 pass/fail), `H4_primary_estimands_results.csv` (Tier 2 optional). Guide: [`H4_papers_screened_final.md`](H4_papers_screened_final.md) §0.8.

---

## Methods (one subsection)

**Hypothesis test (H4).** We compared **WalkU** and **WalkG** within each participant (*n* = 11): end-of-phase **thermal, acoustic, visual and overall comfort**, and phase-mean **A-weighted level** and **UTCI**. Pre-specified success was two-sided *p* < 0.05 on **thermal and/or visual comfort** together with higher sound and UTCI on the urban walk.

**Literature (Methods only).** A Scopus screen (`therm*`, `outdoor`, `sound*`) and 24 retained sources defined **which outdoor thermo-acoustic designs exist in the field** and which **model shapes** could be partially ported to 8-minute bouts ([`H4_papers_screened_final.md`](H4_papers_screened_final.md) §3; Appendix CSV). That catalogue documents **transparency**; it does **not** supply the primary inferential test for H4.

**Sensitivity (optional paragraph in Results).** Interaction structures from Jin et al. (2020), Chen et al. (2023), Wu et al. (2025), Mohammadzadeh et al. (2023), Li et al. (2025), and Zhen et al. (2025) were fitted on walk cells as **Methods-informed checks** (`H4_primary_estimands_results.csv`); they were **not** the registered H4 criterion.

**Questionnaire timing:** domain comfort (thermal, acoustic, visual, air, odour) and 7-point overall comfort were collected **once at the end of each 8-minute phase** (`Recurring questionnaire.csv`; mapping §2 of the H4 guide).

---

## Results — main text (H4 test + optional sensitivity)

### H4 — urban versus green walking (primary)

On the walking phases, **thermal comfort** was **1.09 points lower** on WalkU than WalkG (paired *t*, *n* = 11, *p* = 0.0097). **Visual comfort** was **1.00 point lower** on WalkU (*p* = 0.0016). **Acoustic comfort** showed a similar direction but did not reach *p* < 0.05 (mean difference −0.82, *p* = 0.095). **Overall comfort** (7-point scale) did not differ significantly (mean −0.36, *p* = 0.27).

Exposure shifted in the same direction: phase-mean **A-weighted level** was **5.84 dB(A) higher** on WalkU (*p* < 0.001) and phase-mean **UTCI** was **6.49 °C higher** (*p* < 0.001). Higher scores on the comfort scales indicate better comfort; negative paired differences therefore indicate **worse** subjective comfort on the urban corridor together with **louder, hotter** conditions.

**Table H4-A1.** Paired WalkU − WalkG contrasts (*n* = 11).

| Outcome | Mean difference (WalkU − WalkG) | *p* |
| --- | ---: | ---: |
| Thermal comfort (1–5) | −1.09 | 0.0097 |
| Visual comfort (1–5) | −1.00 | 0.0016 |
| Acoustic comfort (1–5) | −0.82 | 0.095 |
| Overall comfort (1–7) | −0.36 | 0.27 |
| Phase-mean dBA (exposure) | +5.84 dB(A) | < 0.001 |
| Phase-mean UTCI (exposure) | +6.49 °C | < 0.001 |

**Conclusion for H4:** The hypothesis is **supported**: participants reported **significantly lower thermal and visual comfort** on the urban walk while exposure was **significantly louder and thermally more stressful**.

### Optional — interaction ports (Methods sensitivity)

Literature-shaped **sound × thermal-stress interactions** on comfort votes did **not** reach *p* < 0.05 on walk cells (10/10 rows; Appendix). This does **not** contradict the H4 corridor test; sound and UTCI **covary with route**, and one vote per bout limits power for interaction terms compared with multi-site field surveys.

**Appendix:** Full ported catalogue (`H4_sound_literature_tests.csv`) supports **Methods** only.

---

## Discussion (H4 paragraph)

Outdoor thermo-acoustic studies often report that **louder environments feel worse when heat stress is high** (Jin et al., 2020; Chen et al., 2023; Wu et al., 2025). Our within-person comparison showed **clearly lower thermal and visual comfort** after the **urban walk**, alongside **substantially higher** sound level and UTCI — compatible with that literature at the level of **co-exposure and corridor contrast**, but **not** demonstrating a significant **sound × heat interaction** on a single end-of-phase vote in 11 people and 8-minute bouts. Sound and UTCI **covaried with corridor** (green vs impervious), which limits isolation of interaction terms. Longer panels, repeated surveys on many sites, or assigned stimulus combinations (e.g. chamber campaigns; Pigliautile et al., 2021) provide more power for strict interaction tests than this mobile design. Physiology-first ports in the appendix (e.g. heart-rate variability under noise; Moshammer et al., 2019) speak to **arousal and autonomic load**, not necessarily the same construct as **thermal discomfort amplification** on questionnaire TCV/TSV analogues.

**Thesis headline:** **H4 supported** — urban walking showed **lower thermal and visual comfort** with **higher sound level and UTCI** than green walking. Literature papers informed **analysis design**; interaction ports are **supplementary**.

---

## What not to write

- Do **not** claim “18/24 papers confirmed H4.”
- Do **not** present appendix catalogue MET counts as the H4 result.

---

## Hypothesis wording (§1.2 — use this)

**H4 — Noise and thermal discomfort.** On the urban walk, participants experience **higher sound level and thermal stress** and **report lower comfort** than on the green walk (within-person test). The thermo-acoustic literature informs **Methods**; interaction model shapes are reported as **sensitivity** only.

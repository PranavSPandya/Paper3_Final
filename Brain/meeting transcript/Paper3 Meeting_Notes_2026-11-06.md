# Meeting Notes - 6 November 2026

Paper 3 supervision meeting (Friday). Source: Teams transcript pasted by Pranav on 12 Nov 2026. Some names and terms are garbled by transcription (for example "Analora", "Christos", "sore/swarm model") and are kept as heard.

## Main purpose of the meeting

Review progress on Paper 3, especially:

- the H4 sound and thermal comfort analysis and why the earlier multivariable models were not significant;
- the replication of methods from five sound papers;
- the decision to filter data to UTCI > 26 and sound > 65 dB;
- H1, H2 and the combined-effect hypothesis (H5) results;
- figures for the paper and for the next group meeting;
- paper framing and section naming.

---

## 1. Hypothesis behind the sound analysis

The idea under test: when thermal discomfort is present, noise makes people even more uncomfortable.

- Thermal discomfort is quantified through **UTCI**, not qualitatively.
- Conceptual point from the supervisor: **UTCI itself is not affected by sound.** What sound could change is either physiology (for example skin temperature) or perceived comfort (questionnaire responses).
- Literature widely reports that **perceived** comfort is modified by sound; the effect on **physiological** comfort is less established.

---

## 2. Why the earlier model gave no significant results

Earlier approach: one equation with UTCI, sound, solar irradiance, sky view factor, air pollution together, then swapping UTCI for its components (air temperature, humidity, wind, MRT) one by one.

- Pranav's explanation: too many variables at once in a linear model, each receiving a coefficient, so nothing reached significance.
- Supervisor asked why a **mixed-effects model** was not used, as in the other paper.
- Pranav mentioned that handling this might need something like random forest.

---

## 3. Replication of five sound papers

Pranav found at least five papers and replicated each paper's exact test (t-test or whatever they used).

### What the papers did

- Most use sound plus air temperature (not UTCI, since they lack MRT). They do not build a full model with PM and other parameters.
- One paper (the one discussed with the supervisor live) used fixed conditions of 21-23 °C, environmental data, subjective survey data and **PMV**, plus questionnaire clustering. They report survey (PMV) effects for sound, but EDA and skin temperature results are not reported with exact values, so it is unclear whether they found a physiological effect.
- Paper formulas discussed:
  1. Sound only (sound level in the first 5 minutes versus the next 5). Supervisor: this is about sound, **not related to thermal comfort**, so not our question.
  2. UTCI.
  3. Interaction of sound and UTCI.
  4. Temperature, relative humidity and sound (DSI unit) with **EDA** as outcome.
  5. Mean and max of sound and skin temperature. Supervisor: that is the effect of sound on skin temperature, a different story.
- Three of the replications gave p < 0.05. These papers used plain p-values, no FDR.
- Pranav still needs to check the Analora (name as transcribed) sound paper. Supervisor asked to look at it carefully, because how she did it is important.

### Not yet tried

- Replicating the air-temperature formulas with **UTCI** instead of air temperature.

---

## 4. Filtering to UTCI > 26 and sound > 65 dB

Pranav filtered the 10-second data to UTCI > 26 and sound >= 65 dB, because the replicated papers had fixed conditions. Significance only appears in this subset; the whole-day data and the earlier model show nothing.

### Supervisor concerns

- Choosing a high-sound subset removes much of the variability, so it is unclear how sound can explain discomfort when it is always high in the subset.
- The subset looks small.
- Trying different thresholds (> 55, > 45) to find significance risks being **cheating**. If there were a real effect, it should show regardless.

### Agreed alternative: remove background noise instead of capping

- Rather than capping, **remove the constant background sound** so spikes are not dampened in the total decibel level. In a busy environment people habituate (as Sergio noted), but they notice sudden spikes.
- Pranav already has supplementary **spectrum** analyses with about 7 significant outcomes. Check which spectrum bands are significant.
- Find **literature that justifies** removing some spectrum bands and keeping others.
- Supervisor considers this more coherent than capping.

### Testing against perception

- Supervisor suggested testing sound plus heat against the **thermal comfort questionnaire**, since the claim is that we feel thermally more uncomfortable.
- Limitation: psychological data exist only once per block, so this may not be testable; physiology may be the only option.

---

## 5. H1 - Green versus urban

- Contrasts for biking and walking; for example bike-urban skin temperature is 1.12 °C higher than bike-green (reported as -1.12), statistically significant.
- Run two ways: **phase average** (one value per phase) and **10-second time series** within phases. Both give results.
- Supervisor: check whether the **cohort size** supports a block-level analysis, since each side of the contrast has only about 12 values. If one value per block is acceptable, psychology could be included; otherwise keep psychology separate. Unclear whether n = 12 is acceptable.

---

## 6. H2 - Psychology and physiology

- About 11 values per phase; some correlations (shown in bold) are significant.
- Supervisor also wants **psychology versus environment** relationships.
- Concern: without that, the paper has no place to discuss whether higher UTCI means more discomfort.

---

## 7. H5 - Combined effect (mixed model)

Pranav added a fifth hypothesis combining the seven equations, each of which had significant terms. These are mixed-effects models.

- Example: with other terms held constant, a 1-degree UTCI increase raises heart rate variability by 0.335.
- HRV frequency bands (low and high frequency) come from the Empatica.
- Velocity values (about 320) are in **pixels per second**. Convert to a realistic unit (for example millimetres) so it reads like the other variables.
- Run per block average and per 10 seconds. Per block gives few significant results; per 10 seconds gives about 30, including mean radiant temperature, pupil diameter, sky view factor and pupil change rate.
- Some predictors explain little. Supervisor: these need studying for comfort, especially where psychology is available.

---

## 8. Model and figure framing

- Pranav drafted a figure based on the **stimulus-organism-response (SOR)** model, showing only FDR-significant links from H5 (solid line positive, hollow negative).
- Supervisor: if SOR is used, it must be introduced as the paper's model, as Christos (name as transcribed) does, not only as a plot. Don't reinvent the wheel; **adopt one framework, not many**. If the paper does not use SOR, do not introduce it via the plot. A similar plot is still possible if explained differently.
- A plot showing all collected variables and how they are grouped is needed.
- Mean pupil diameter plot (higher in green, lower in walking; red/orange urban, green/blue green phases) is a start; more plots like it will follow.

### General figures

- Belgium/study-area map and timeline figures were updated.
- **Direction/route-order figure:** likely adds confusion. Mention in the text (or appendix) that the order was randomised and then remapped to compare like with like; probably not worth a figure.
- **Participant view figure:** show one participant across the four phase environments (bike urban, bike green, walk urban, walk green) rather than different participants.
- The table of all columns and units goes to the **appendix**.
- Sensor descriptions are still being written (like in the second paper); some of this also goes to the appendix.

---

## 9. Paper writing

- **Introduction:** be crystal clear what is novel (biking and walking; the combined environmental, psychological and physiological measures) and what open questions remain compared with the literature.
- Decide whether the Analora paper is critical, and which papers relate to each hypothesis. Papers are not cited inside the hypotheses, but the motivation should lead to them.
- **Section naming:** don't title a section after a product (for example "Empatica measures"). Use "Physiological data" and cite the product inside. Explaining the product is not the scientific aim.
- Don't overcomplicate the paper.

---

## 10. Actions

### Analysis

- Check the Analora sound paper's method carefully.
- Replace the UTCI > 26 / sound > 65 dB capping with **background-noise removal** and spectrum-based analysis; identify which spectrum bands are significant and find literature justifying the choice.
- Consider testing sound plus heat against thermal comfort questionnaire data, if block-level psychology allows.
- Check whether n of about 12 per contrast is enough for block-level analysis.
- Add psychology versus environment analysis.
- Convert eye-movement velocity from pixels per second to a physical unit.

### Writing

- Draft the introduction and motivation leading to each hypothesis.
- Rename product-named sections (for example to "Physiological data").

### Next group meeting (Thursday 12 November 2026)

- Bring **one or two plots per hypothesis** that answer it without text. Explaining the plots alone should let the group answer each hypothesis.
- Also show the context figures (study area, timeline and so on), so the paper is explained through its figures.
- Each person talks briefly; Elena gives a longer presentation.
- A short talk with the supervisor before Thursday is possible if needed.

---

## 11. One-sentence meeting takeaway

**Drop the threshold capping in favour of background-noise removal grounded in literature, add psychology-environment links, pick one framework rather than inventing a new model, and come to Thursday's group meeting with plots that answer each hypothesis on their own.**

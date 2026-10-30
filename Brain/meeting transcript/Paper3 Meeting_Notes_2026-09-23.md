# Meeting Notes — 23 September 2026

## Main purpose of the meeting

Review the current Paper 3 analysis strategy, especially:

- the structure of the hypotheses;
- use of linear mixed models (LMMs);
- normalization / baseline correction;
- matched-duration analysis;
- treatment of physiological, eye-tracking, psychological, and environmental variables;
- single-predictor versus multivariable environmental models;
- methodological questions to clarify with Martin.

---

## 1. Overall analysis strategy

A major point from the discussion was that the analysis should be made **simpler and sequential**, rather than testing many alternatives simultaneously.

Agreed working order:

1. Use the **matched 8-minute data** first.
2. Resolve the **normalization approach**.
3. Once normalization is fixed, interpret the hypothesis tests.
4. Only afterwards test whether results change when using the **full / longer phase duration**.
5. Avoid multiplying scenarios before the previous methodological decision is settled.

The supervisors emphasized that the analysis should clearly state:

- what the outcome variable is;
- what the predictors are;
- what model is being used;
- what question each model is answering.

---

## 2. Matched-duration analysis

The current matched-duration analysis uses the **first 8 minutes** of comparable urban and green phases.

This was considered a reasonable starting point because some phases have different total durations.

### Decision

For now:

- keep the **8-minute matched-duration dataset** as the standard dataset;
- resolve normalization using this dataset first;
- only after that compare against the full-duration analysis.

### Later sensitivity check

Once the main normalization method is decided:

- compare the 8-minute results with results using longer / full phase durations;
- check whether the overall interpretation changes.

The meeting explicitly recommended **not testing normalization and duration sensitivity at the same time**, because that would create too many scenarios.

---

## 3. Normalization / baseline correction

This was the main methodological issue discussed.

### Methods currently considered

1. **Indoor baseline subtraction**
2. **Tram baseline subtraction**
3. **Baseline used as a covariate**
4. **Within-person Z-score normalization**

### Key problem: indoor baseline

Indoor baseline data are available for Empatica-related variables, but **eye-tracking data are not available during the indoor baseline**.

Therefore, using indoor baseline correction would mean different outcome variables are normalized differently.

This was considered problematic because the analysis should ideally use a **consistent normalization approach**.

### Key problem: tram baseline

The tram phase contains eye-tracking data and therefore provides a common reference across more variables.

However, the tram is not necessarily a neutral physiological baseline.

Potential concern:

- tram thermal conditions may be unusually hot;
- air-conditioning may be absent or inconsistent;
- subtracting a hot tram value could make green phases appear strongly negative for skin temperature simply because the tram itself was hot.

Therefore, direct subtraction may change the interpretation of the raw values.

### Covariate approach

Using the baseline value as a covariate was discussed as potentially preferable because:

- the original outcome values are not directly transformed by subtraction;
- baseline differences can be statistically adjusted rather than mechanically removed.

However, a baseline value still needs to be selected.

Because indoor eye-tracking baseline is unavailable, the same limitation remains if the baseline covariate is based on indoor data.

### Within-person Z-score

Within-person Z-score normalization was discussed as another possible method because it may not require a separate indoor or tram control phase in the same way as direct subtraction.

However, its suitability for the present study, particularly for questionnaire data and the specific phase-level structure, still needs confirmation.

---

## 4. Agreed normalization check before deciding

Before selecting the normalization method, compare **indoor baseline versus tram baseline** for variables where both are available.

### Required comparison

Using the matched 8-minute dataset:

- run the same analysis using indoor normalization;
- run the same analysis using tram normalization;
- compare whether the **direction, significance pattern, and general scientific story** are similar.

If the overall story is coherent between indoor and tram normalization, then tram may be defensible as the common baseline because it also contains eye-tracking data.

If the story changes substantially, the normalization strategy needs further discussion with Martin.

### Important principle

Do **not** select different normalization methods simply because one produces more significant results.

One defensible method should be chosen and applied consistently.

---

## 5. Question to Martin about normalization

The discussion suggested that Martin should not be sent a long menu of alternative methods without context.

Instead, explain the methodological problem clearly:

- indoor is the preferred conventional baseline but has no eye-tracking data;
- tram contains all relevant sensor streams but may not represent a neutral baseline;
- tram subtraction may distort some variables because the tram thermal environment can itself be extreme;
- ask whether a baseline-covariate approach, tram-based approach, or within-person standardization is most defensible for this design.

Also show Martin a **small number of illustrative results**, rather than every possible model combination.

---

# Hypothesis structure

## H1 — Green versus urban exposure

H1 compares **green versus urban environments** within the same activity.

The activities should remain separate.

### H1a / biking comparison

Compare:

- Bike Green
- Bike Urban

### H1b / walking comparison

Compare:

- Walk Green
- Walk Urban

Do not pool biking and walking together for this comparison.

### Outcomes

Primary outcomes are physiological / behavioral sensor variables, including:

- Empatica-derived variables;
- eye-tracking variables.

Examples discussed in the meeting included:

- skin temperature;
- pupil diameter;
- blink duration;
- distance from centre / gaze centrality-related variables;
- fixation-related variables;
- gaze velocity / dispersion-related measures.

### Direction of effects

Results should not be reported only as “significant”.

For each significant result, report:

- estimate;
- direction;
- interpretation.

For example, if the model coding is Green − Urban:

- negative skin-temperature estimate → lower skin temperature in green;
- negative distance-from-centre estimate → smaller distance from centre in green.

The coding and reference category must be stated clearly so that the sign is interpreted consistently.

---

## Psychological questionnaires in H1

The supervisors questioned why psychological questionnaire outcomes are being separated from the physiological outcomes if both are responses to the environmental exposure.

The difficulty is that:

- sensor data can provide many observations or phase-level summaries;
- questionnaires may provide only one value per participant per phase.

### Question to Martin

Confirm whether questionnaire outcomes can be analysed in the same conceptual H1 framework using an LMM / contrast structure despite having one questionnaire value per participant per phase.

The key question is whether the difference in measurement density creates a modelling problem.

---

## H2 — Relationship / concurrence between psychological and physiological responses

The current interpretation of H2 is not fully settled.

The intended concept appears to be the **relationship or concurrence between psychological and physiological responses**.

A major unresolved issue is how to model this because questionnaire data consist of approximately one value per participant per phase, whereas physiological measurements originate from time-series data.

### Action

Clarify H2 with Martin before finalizing the model.

Specifically ask:

- whether psychological and physiological outcomes should be modelled jointly;
- whether phase-level aggregation makes the comparison appropriate;
- whether the LMM framework can accommodate this structure;
- how normalization should be applied consistently to questionnaire variables.

---

## H3 — Activity comparison

H3 compares **walking versus biking** within the same environmental context.

Example discussed:

- Walk Urban versus Bike Urban.

Equivalent green comparisons may also be considered depending on the formal hypothesis structure.

The same principle applies:

- define the outcome clearly;
- define the contrast clearly;
- do not mix environmental prediction models into this hypothesis unless that is explicitly the research question.

---

# 6. Environmental predictors and physiological / eye-tracking outcomes

A separate modelling objective is to determine whether environmental variables explain variation in physiological or eye-tracking outcomes.

Examples of environmental predictors discussed:

- UTCI;
- PET;
- air temperature;
- MRT / Tmrt;
- sound;
- PM2.5;
- illuminance / Lux;
- potentially relative humidity and wind-related variables.

Possible outcome variables include:

- skin temperature;
- pupil diameter;
- blink duration;
- fixation measures;
- gaze-related measures;
- other Empatica variables.

---

## 7. Single-predictor versus multivariable environmental models

A key criticism during the meeting was that the current analysis appeared to mix two different modelling strategies.

### Strategy A — single-predictor models

Example:

`Skin temperature ~ UTCI`

then separately:

`Skin temperature ~ Sound`

then:

`Skin temperature ~ PM2.5`

etc.

This answers:

> Is this specific environmental variable associated with the outcome?

If this approach is used, all predefined predictors should be tested systematically and the results reported transparently.

It would be incorrect to first filter variables using another procedure and then state that only the remaining variables were significant.

---

### Strategy B — combined / multivariable model

Example conceptually:

`Skin temperature ~ UTCI + Sound + PM2.5 + Lux + ...`

This answers a different question:

> Which predictors explain the outcome while controlling for the other predictors in the model?

Significance may disappear when correlated environmental variables are included together.

That does **not** necessarily mean the individual variable has no association.

---

## 8. Collinearity / variable selection

Before fitting a multivariable linear or linear mixed-effects model, correlated predictors need to be considered.

The meeting specifically raised the issue that several environmental variables may represent overlapping physical phenomena.

Examples:

- UTCI already combines several meteorological inputs;
- PET is another thermal index;
- air temperature and MRT are components related to thermal exposure;
- including UTCI together with its strongly related components may create redundancy / collinearity.

### Important distinction

The analysis should not mix:

- a thermal index such as UTCI;
- and the raw variables used to construct / strongly determine that index,

without a clear modelling rationale.

### Current proposed approach

One reasonable structure discussed was:

Base environmental model:

- UTCI
- Sound
- PM2.5
- Lux

Then run alternative thermal specifications by substituting UTCI with:

- PET;
- air temperature;
- MRT / Tmrt;
- other relevant thermal variables.

This allows comparison of alternative representations of thermal exposure without placing all highly related thermal variables into the same model.

However, this modelling plan should be finalized only after clarifying the exact scientific objective.

---

## 9. Concern about current predictor-selection results

The supervisors were skeptical of the result where UTCI appeared significant while related thermal variables such as PET or MRT did not.

This may be caused by:

- previous feature selection;
- testing variables after filtering;
- mixing single-predictor and multivariable procedures;
- collinearity;
- inconsistent model specifications.

### Action

Recheck the environmental predictor pipeline from the beginning.

Clearly separate:

1. single-predictor analysis;
2. multivariable prediction / explanatory modelling;
3. any feature-selection or clustering step.

Do not describe a variable as “not significant” if it was removed before the relevant statistical test.

---

# 10. Clustering / variable grouping

A silhouette analysis had previously suggested approximately **K = 6** clusters.

Thermal variables / thermal indices appeared in one group, with other environmental groups also identified.

The clustering was used to reduce the number of candidate variables.

The supervisors questioned how this selection interacts with the later regression analysis.

### Action

Document exactly:

- what variables entered the clustering;
- what distance / clustering method was used;
- how K was selected;
- how one representative variable was chosen from each cluster;
- whether the clustering is used only to reduce redundancy or is part of formal inference.

The clustering step must not make later significance statements misleading.

---

# 11. LMM interpretation

The current main inferential framework is the **linear mixed-effects model**.

The discussion emphasized that model construction must follow the research question.

Possible uses include:

### Contrast model

To test green versus urban or walking versus biking:

`Outcome ~ Condition + random effect for participant`

### Environmental explanatory model

To test whether environmental exposure predicts physiology:

`Physiological outcome ~ Environmental predictor(s) + random effect for participant`

These are different research questions and should not be mixed in the same results narrative.

---

# 12. Phase-level aggregation

The meeting clarified that for the current LMM analysis, variables are being summarized to approximately **one value per participant per phase**, based on the selected duration.

For example:

- blink duration → one summary value for that participant and phase;
- skin temperature → one summary value for that participant and phase;
- environmental variables → corresponding phase-level summaries.

This clarification is important and should be stated explicitly in the Methods.

---

# 13. Time-series / segment-level modelling

Another analysis discussed by a colleague uses much finer spatial / temporal resolution, for example approximately **30 m segments** within a phase.

This analysis attempts to retain the time-series / spatial structure rather than reducing each phase to a single mean.

A more complex causal / mediation-type model was described in which:

- environmental variables influence physiological outcomes;
- activity / movement / metabolic rate may mediate part of the relationship;
- direct and indirect effects can be separated.

This is conceptually different from the current phase-level LMM.

### Important methodological point

Participant-to-participant physiological differences can be much larger than environmental effects.

Therefore, normalization is especially important for time-series / segment-level models.

---

# 14. Activity / mediation findings discussed

A preliminary example from the colleague's model suggested that some gaze-related outcomes may be influenced strongly through activity rather than directly by environmental variables.

Examples discussed included:

- MRT;
- gaze centrality;
- heart-rate-related measures;
- movement speed;
- metabolic rate.

The model may estimate a mediation ratio indicating how much of an environmental association operates through physical activity.

These results are still exploratory and should not be treated as established conclusions until the model and normalization are validated.

---

# 15. Variables requiring documentation

Two variables / computations need to be traced carefully.

## Gaze centrality / distance from centre

Clarify:

- exact mathematical definition;
- whether larger values mean more peripheral gaze;
- whether smaller values mean more central gaze;
- where the variable is computed in the code.

## Cold stress composite

This variable was apparently computed in code rather than directly by the Neon eye tracker.

The recollection was that it may involve the rate of change of variables such as pupil diameter and/or fixation-related measures, but this needs to be verified from the actual code.

### Action

Locate the exact computation and document the formula.

---

# 16. Metabolic rate

The meeting also raised the question of how metabolic rate is produced.

It is not yet clear whether it comes directly from hardware, another processing step, or a derived calculation.

### Action

Trace the metabolic-rate variable to its original source and document:

- source device / input;
- formula or algorithm;
- units;
- whether it is measured or estimated.

---

# 17. Figures / plots required

For hypothesis results, plots should show more than statistical significance.

Recommended information:

- Green versus Urban distributions / estimated marginal means;
- Bike and Walk shown separately where appropriate;
- model estimate and confidence interval;
- direction of effect;
- participant-level variation where feasible.

Potential outcomes to visualize include:

- skin temperature;
- pupil diameter;
- blink duration;
- gaze distance from centre / centrality;
- gaze velocity;
- gaze dispersion;
- other significant Empatica / eye-tracking outcomes.

---

# 18. Immediate tasks

## Priority 1 — normalization

- [ ] Use the **8-minute matched dataset**.
- [ ] Compare indoor-baseline and tram-baseline normalization for variables where both are available.
- [ ] Compare direction and overall pattern, not just p-values.
- [ ] Check whether the scientific interpretation remains coherent.
- [ ] Examine why questionnaire results are currently not appearing / normalizing as expected.
- [ ] Prepare a concise methodological question for Martin.
- [ ] Ask Martin whether within-person Z-score normalization is appropriate for this study design.
- [ ] Ask Martin whether baseline-as-covariate is preferable when direct subtraction may distort values.

## Priority 2 — hypothesis structure

- [ ] Finalize H1 as Green vs Urban, separately for Bike and Walk.
- [ ] Confirm whether questionnaire outcomes should also be included under H1.
- [ ] Clarify H2 with Martin, especially psychological–physiological concurrence.
- [ ] Finalize H3 activity contrasts.

## Priority 3 — environmental models

- [ ] Separate single-predictor models from combined multivariable models.
- [ ] Recheck predictor-selection / clustering logic.
- [ ] Check collinearity among thermal variables.
- [ ] Do not combine UTCI, PET, air temperature, MRT, etc. indiscriminately.
- [ ] Decide whether the primary environmental model uses UTCI with alternative thermal-variable substitution models.

## Priority 4 — variable provenance

- [ ] Find exact code / definition for gaze centrality or distance from centre.
- [ ] Find exact code / formula for the cold stress composite.
- [ ] Determine how metabolic rate is computed / obtained.

## Priority 5 — sensitivity analysis

Only after normalization is finalized:

- [ ] compare 8-minute matched results against full-duration results;
- [ ] determine whether the direction and interpretation change.

---

# 19. Questions to send to Martin

1. **Normalization / missing baseline eye tracking**  
   Indoor baseline is unavailable for eye-tracking variables. Is it statistically defensible to use the tram phase as the common baseline, or would you prefer a baseline-covariate or within-person standardization approach?

2. **Potential tram-baseline bias**  
   Because tram thermal conditions may themselves be unusually hot, direct subtraction can substantially change skin-temperature values. Would a covariate-based adjustment be preferable to direct baseline subtraction?

3. **Consistency across modalities**  
   Should all physiological and eye-tracking outcomes use one common normalization method, even if this means using tram rather than the indoor baseline?

4. **Within-person Z-score**  
   Is within-person Z-score normalization appropriate for these phase-level repeated-measures data, particularly when no common neutral baseline exists for every sensor?

5. **Questionnaire outcomes**  
   Can psychological questionnaire outcomes, with one value per participant per phase, be analysed within the same LMM / contrast framework as phase-level physiological outcomes?

6. **H2**  
   What is the most appropriate statistical formulation for testing concurrence / association between psychological responses and physiological responses?

---

# 20. Main decisions from the meeting

- Use **matched 8-minute data first**.
- Resolve **normalization before duration sensitivity analysis**.
- Do not multiply normalization × duration × model combinations simultaneously.
- Compare **tram and indoor normalization** where both are available.
- Prefer one consistent and scientifically defensible normalization strategy.
- Keep **Bike Green vs Bike Urban** separate from **Walk Green vs Walk Urban**.
- Report **direction and estimate**, not only significance.
- Clearly separate:
  - condition contrasts,
  - single-predictor environmental models,
  - multivariable environmental models.
- Recheck the current environmental-variable selection procedure.
- Ask Martin specifically about:
  - baseline strategy;
  - within-person Z-score;
  - questionnaire modelling;
  - H2 formulation.
- After normalization is fixed, perform the **full-duration sensitivity analysis**.

---

# 21. Next meeting

Tentatively planned for:

**Wednesday afternoon, approximately 14:00, one week later.**

Tuesday was unavailable and Wednesday morning was also unavailable due to teaching.


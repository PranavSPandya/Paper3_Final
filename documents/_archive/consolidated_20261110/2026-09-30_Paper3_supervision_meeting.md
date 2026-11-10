# Paper 3 Supervision Meeting — 30 September 2026

> **Source:** meeting transcript supplied by Pranav on 30 Sep 2026. The transcript is automatic speech recognition and contains transcription errors. Unclear names/terms are marked as uncertain rather than silently corrected.
>
> **Meeting status:** This was not a final approval meeting. The supervisors repeatedly expressed that the analysis/story was still going in circles and asked for a more complete, cumulative analysis package before the next substantive meeting.

## 1. Executive summary

The central outcome of the meeting was a **redirect of the Paper 3 analysis away from a collection of one-to-one correlations/univariate models toward a coherent co-exposure story**. The supervisors' main concern was not that the experiment lacked data; it was that the analysis was not yet using the full strength of the synchronised multi-sensor field campaign.

The requested direction is:

- keep the within-participant design and the matched 8-minute framework;
- do not prematurely discard physiological/environmental variables simply because they are not currently significant or because the team is not yet certain which is most important;
- distinguish simple one-to-one relationships from questions that require mixed/multivariable models;
- for simple predictor–outcome relationships, report a simple association/correlation and significance rather than using a complex model without added value;
- add **co-exposure / multivariable analyses** that examine environmental factors together and test whether combined heat, sound/noise, pollution, radiation/light/wind etc. explain physiological and psychological responses better than isolated predictors;
- explicitly assess **covariance / multicollinearity**, especially because PET, UTCI, MRT and related thermal variables are not independent;
- connect physiology, psychology and environment into a paper-level story rather than listing significant/non-significant associations;
- verify the direction and interpretation of H2 models (which variable is predictor and which is outcome);
- use literature more actively to justify which physiological/ocular variables are meaningful and how their directions should be interpreted;
- complete a defensible normalization framework once, based on literature and robustness metrics, rather than repeatedly changing the pipeline.

## 2. Data and variables presented in the meeting

### 2.1 Environmental / uCM variables

Pranav reported that the current environmental set retains the main standard parameters, including thermal indices such as PET/UTCI and standard meteorological/exposure variables (wind, solar/radiation-related variables, etc.), while excluding Humidex and some additional/redundant uCM-derived parameters.

**Supervisor feedback:** variable exclusion should be conservative at this stage. The team does not yet have enough domain certainty to discard potentially relevant variables purely by intuition. The final model can be reduced later, but the screening/analysis should not miss variables that prior literature has identified as relevant.

### 2.2 Clearness Index

- Clearness Index has now been computed.
- It is a **derived** quantity, not a direct backpack measurement.
- It was described as being calculated from solar-radiation quantities using a literature formula and representing clear-sky versus cloudy/low-sun conditions.
- The supervisors saw value in it because local MRT/radiation sensors can be affected by temporary local shading (participant, furniture, passer-by, etc.), whereas clearness index captures broader sky/radiation conditions.
- It may therefore provide useful context for whether a participant was likely to receive solar radiation even when a local sensor was temporarily shaded.

### 2.3 Empatica variables

Pranav reported retaining EDA tonic, EDA phasic, heart rate and skin temperature, while excluding some other channels such as acceleration and some computed frequency-domain HRV variables.

**Important correction requested:** do **not** exclude potentially relevant frequency-domain HRV or other physiologically meaningful variables merely because they were not in the first shortlist. A paper discussed during the meeting (name unclear in transcript; sounds like the paper by/used by 'Anarola' or a related collaborator) reportedly found cold/warm differences in frequency-domain HRV and used the same/similar device. The instruction was explicit: include these variables in the broad analysis first and shorten later.

### 2.4 Eye-tracking variables

- Pupil diameter and the principal non-derived eye-tracking variables were included.
- Date fields and a derived 'stress' variable were excluded.
- The supervisors asked for stronger literature grounding for the interpretation of pupil, blink, fixation and gaze results under heat/environmental exposure.
- Pupil diameter has an obvious illumination/radiation dependency and must not be interpreted as a pure stress marker.
- Blink-duration literature for thermal exposure was acknowledged as less clear and needs further checking.
- Fixation/gaze variables may be more activity/task driven (e.g., cycling versus walking) than direct thermal markers.

### 2.5 Atmotube and light sensors

- Left/right Atmotube values were averaged for the analysis.
- LYS/light values were also averaged in the presented workflow.
- These preprocessing choices were presented as a way to avoid separately modelling paired sensors when the intended exposure is a single representative value.

### 2.6 Green View Index (GVI)

- GVI was reported as completed along the routes at approximately 50 m spacing.
- Mapillary imagery was used because suitable summertime/in-season imagery was available along the phases.
- The intention is to quantify visual greenery across the experimental routes rather than rely only on the binary Green/Urban label.

### 2.7 YAMNet sound classification

- YAMNet sound analysis was rerun/updated.
- The earlier 15-second window was changed to **10-second windows** to align with the Paper 3 analysis resolution.
- The updated processing also reports the sound-level field appropriately.
- Pranav was asked to upload/share the latest YAMNet file/code in GitHub.

### 2.8 Psychological measures and participant background

The active psychological measures discussed were:

- General/current comfort;
- Pleasantness;
- STAI / state anxiety;
- PRS / perceived restorativeness.

Height, weight and other participant-background questions were recognised as background variables but were **not currently being added to the main model**.

## 3. H1 — Green versus Urban

### 3.1 Current comparison

H1 is being presented as Green minus Urban, separately within cycling and walking. The sign convention discussed was:

- **negative contrast** = higher value in Urban;
- **positive contrast** = higher value in Green.

The supervisors asked that this sign convention be stated clearly because the plots are otherwise easy to misread.

### 3.2 Results discussed verbally

The following patterns were discussed as examples of the current significant results:

- skin temperature was higher in Urban than Green and appeared consistent across walking and cycling;
- tonic EDA showed a significant Urban > Green pattern for walking;
- pupil diameter was higher in Green in the discussed contrast;
- several ocular measures (fixation/blink/gaze/peak-velocity-related outcomes) were discussed, but the transcript is too garbled to treat every stated direction as final; directions must be checked against the actual output before manuscript text is written.

Only FDR-significant findings should be emphasised in the main inferential table/interpretation, but the supervisors also want the **qualitative pattern across participants/conditions** to be visible before interpretation.

### 3.3 EDA concern

A major discussion concerned why tonic EDA looked stronger/more significant during walking than cycling.

Possible explanations raised:

- walking may involve less convective ventilation and more sweating;
- sweat can affect skin-conductance measurement quality;
- cycling wind/airflow may alter sweating and electrode behaviour;
- the observed EDA effect could therefore reflect both physiology and measurement conditions.

**Action:** revisit the prior EDA/device literature (including the MUSIC-related work / paper mentioned in the meeting, name uncertain) and determine whether tonic EDA is expected to be the critical parameter and how sweating/exercise affects reliability. Do not simply interpret larger EDA as greater discomfort without this check.

### 3.4 Normalization question raised during H1

The supervisors explicitly asked whether normalization is applied **before or after** subtraction/contrast formation. The verbal answer during the meeting was not sufficiently clear and may not match the current code.

**Required:** document the exact pipeline in mathematical order (raw 10-s values -> any transformation -> within-person standardization/baseline adjustment -> participant-phase aggregation -> planned contrast). Verify the code rather than relying on the verbal explanation.

## 4. H2 — Psychology–Physiology relationship

### 4.1 Main conceptual problem identified

The displayed H2 equation caused confusion over directionality. The supervisors asked:

- Is physiology predicting the psychological questionnaire?
- Or is psychology the predictor and physiology the outcome?

Pranav was not fully confident in the explanation during the meeting.

**Required:** make the model direction explicit and be able to explain it as `Y = aX + b`. If the goal is concurrence/association rather than causal prediction, state that clearly and explain why one side is placed as the model outcome.

### 4.2 Current repo implication

As of this meeting, the current `statistical_analysis.R` implementation is explicitly:

`Physiology_z ~ Mode + Psychology_within + Psychology_between + (1 | ParticipantID)`

with a within-person z-score branch using:

`phys_z ~ Mode + psych_z`.

This means **physiology is the model outcome and the psychological measure is the predictor** in the current code. That must be explained consistently in the figure/table text.

### 4.3 Do not blindly model every physiology variable

The supervisors suggested that after broad screening/literature review, the paper should identify a **small, defensible set of key physiological indicators** and then examine whether those tell the same story as psychology.

Candidate examples mentioned in the meeting:

- EDA tonic;
- skin temperature;
- one or more gaze/pupil-related indicators.

These were suggestions, **not yet a final fixed shortlist**.

### 4.4 Add qualitative/visual comparison

The supervisors repeatedly asked to first look at the qualitative patterns rather than only model coefficients. Suggested view:

- psychological response (pleasantness, PRS, comfort, possibly STAI);
- selected physiological indicators;
- environmental context such as UTCI;
- all shown in a way that allows participant/phase coherence to be judged visually.

### 4.5 Missing environmental–psychological comparison

A specific gap was identified: **psychology versus environment had not been directly examined** in the presented analysis.

The supervisors expect environmental exposure to sometimes align more clearly with perceived comfort/pleasantness/restorativeness than with physiology because physiological adaptation may be delayed.

**Action:** explicitly evaluate environment–psychology relationships using an appropriately simple or multilevel method depending on the data structure.

## 5. H3 — Walk versus Bike

H3 compares Walk versus Bike separately within Urban and Green environments.

Discussion points:

- the same normalization-order question applies here (normalization before/after contrast must be verified);
- skin-temperature and EDA mode effects did not appear as clear/significant in the discussed plots as the Green–Urban effects;
- ocular variables appeared to carry more obvious mode differences;
- cycling may create a more constrained/fixed forward visual strategy, whereas walking may permit broader visual exploration.

No final H3 interpretation was approved; the request was to keep the analysis consistent with H1 and use the eventual physiological shortlist/literature to tell a coherent story.

## 6. H4 — Environmental predictors: the largest requested change

### 6.1 Problem with the current analysis

Pranav explained that H4 currently fits environmental predictors **one at a time** against each physiological outcome. Each line in the plot therefore comes from a separate one-predictor model.

The supervisors' reaction was that this is essentially a one-to-one association. If the question is only one predictor versus one outcome, a simple correlation plus its significance may answer the question more transparently.

### 6.2 Required new direction: co-exposure / multivariable modelling

The supervisors stated that the real strength of the experiment is that many environmental and physiological variables were collected **synchronously**. The paper should exploit this by asking how environmental exposures work **together**, not only separately.

Examples discussed conceptually:

- heat exposure + sound/noise;
- heat + air pollution;
- radiation/thermal conditions + noise;
- combinations affecting EDA tonic, skin temperature, ocular measures and/or psychological responses;
- whether these combined responses differ between Bike and Walk.

The precise final interaction set was **not decided in the meeting**. The instruction was to build a scientifically justified multivariable/co-exposure model rather than indiscriminately include every possible interaction.

### 6.3 Why this matters for the paper story

The supervisors explicitly said that a paper that only says 'this is correlated, this is not correlated' is not enough. The potential novelty is the empirical ability to study combined environmental exposures during active mobility, especially cycling, because few studies have synchronously measured all of these domains.

A possible framing suggested in discussion was broader **environmental discomfort / co-exposure burden**, combining dimensions such as heat, noise and air pollution, and asking whether the combined exposure corresponds to lower pleasantness/restorativeness or a clearer physiological signature.

This was a **conceptual direction**, not an approved composite index or final formula.

### 6.4 Multicollinearity/covariance is mandatory

The supervisors repeatedly warned that environmental predictors covary.

Examples:

- PET, UTCI and MRT are structurally/physically related;
- wind, cold/heat, rain/cloud/radiation can co-occur;
- thermal indices already contain some of the raw variables.

**Required:** assess covariance/multicollinearity before interpreting a multivariable model. The meeting referenced the same type of issue raised by reviewers in the previous bike paper.

Practical implication: do not put PET + UTCI + MRT + all of their component variables into one model without a deliberate non-redundant selection strategy.

### 6.5 Variable-selection principle for the new H4

There was a tension in the discussion that should be preserved correctly:

1. **Do not prematurely exclude candidate variables** during the broad screening stage, because relevant physiology/environmental variables may otherwise be missed.
2. **Do not blindly put all correlated variables into one final model.** After broad inclusion, use literature, physical meaning and collinearity diagnostics to define a defensible non-redundant multivariable predictor set.

Pranav summarised the required change as moving from the current univariate H4 to a multivariate model using appropriate raw/non-redundant environmental parameters rather than stacking redundant derived thermal indices.

### 6.6 Current repository gap relative to this meeting

The current final `statistical_analysis.R` still implements H4 as **single-predictor REML models** (`Outcome ~ Mode + Predictor + (1|Participant)`), and explicitly says no unified multivariable model is retained.

Therefore, the meeting's main requested change — **co-exposure/multivariable modelling and interactions** — is **not yet implemented in the current final script**.

## 7. GVI, sound and environmental-story implications

The meeting confirmed that GVI, clearness index and YAMNet sound classification are part of the environmental characterisation work. However, the meeting did **not** define an exact final model formula for GVI or YAMNet categories.

Important repo implication as of 30 Sep:

- YAMNet classification outputs exist, but the current main `statistical_analysis.R` does not merge/use the categorical YAMNet output in H4;
- GPS-matched GVI outputs exist, but the current main statistical script does not yet use the GVI-enriched merged file as its H4 input.

These should therefore not be described in the manuscript as already-tested H4 predictors until they are actually integrated and rerun. Whether they belong in the final co-exposure model should be decided based on the new H4 design and collinearity/domain logic.

## 8. Normalization discussion

A substantial part of the meeting concerned a separate normalization review/framework.

Methods mentioned included:

- within-person Z-score;
- min–max / 0–1 scaling;
- baseline subtraction / delta;
- percentage change relative to baseline;
- log transformation for skewed variables;
- combinations such as log transformation followed by standardization;
- literature-specific normalization by variable family.

### 8.1 Baseline limitation

- The original experiment included an Indoor baseline.
- Eye tracking was not recorded during Indoor, so Indoor subtraction cannot be applied consistently to ocular variables.
- A transit/Tram reference had also been explored previously but was not viewed as an ideal universal baseline.
- This is one reason a participant-centred standardization strategy remains attractive.

### 8.2 Literature-first method selection

The strong process feedback was: **do not repeatedly try methods ad hoc**. Start from the literature, define the candidate normalization methods for each physiological family, run the evaluation once comprehensively, and then select/document the method.

A paper discussed in the meeting reportedly recommends log transformation for some skewed physiological measures; another paper using the same/similar device reportedly identifies frequency-domain HRV as relevant. Exact references/names must be recovered from the shared papers/chat because the transcript does not identify them reliably.

### 8.3 Proposed robustness criteria

The normalization presentation described using metrics such as:

- **ICC**: to quantify how much variance is between participants versus within participants, and whether normalization reduces nuisance between-person variance while preserving meaningful within-person variation;
- **Leave-one-participant-out R² / predictive validation**: repeatedly leave one participant out, fit a relationship on the remaining participants and test whether it generalizes to the excluded participant;
- additional robustness metrics (not fully recoverable from the transcript).

The preliminary conclusion presented was that z-score / log-plus-z-score style methods performed well for the available data, particularly because the baseline is incomplete/inconsistent across modalities.

**Status:** the supervisors liked the idea of validating normalization quantitatively, but the transcript does not establish that one single normalization method was formally approved for every variable family. Treat the final normalization choice as still requiring a documented, reproducible evaluation.

### 8.4 Possible pupil normalization idea

A paper was mentioned in which pupil diameter was normalized relative to screen brightness. The meeting floated the possibility of accounting for outdoor solar/radiation conditions analogously. This was exploratory discussion only; no method was approved.

## 9. Literature follow-ups

Required literature work identified in the meeting:

1. Revisit the paper/work where EDA was reported as a critical environmental-discomfort variable (name unclear in transcript; possibly connected to the MUSIC project / 'Lauda'/'Anarola' as transcribed).
2. Check how sweating and physical activity affect tonic/phasic EDA reliability in field mobility experiments.
3. Include/reconsider frequency-domain HRV variables if the same-device literature supports them.
4. Review thermal-comfort / environmental-exposure literature for pupil diameter, blink duration, fixation and gaze behaviour.
5. Use literature to establish expected directionality before interpreting significant coefficients.
6. Recover the exact normalization references shown during the meeting and map each physiological variable family to literature-supported candidate transforms.

## 10. Paper framing / story

The supervisors were explicit that the current analysis risks becoming a list of statistical findings rather than a paper.

The paper should build a coherent chain such as:

**environmental/co-exposure conditions -> physiological/ocular response -> perceived comfort/pleasantness/restorativeness, moderated by mobility mode**

Potential novelty emphasised:

- physiology + psychology + environment measured synchronously;
- Green/Urban and Walk/Bike within the same participants;
- active mobility, especially cycling, in a multi-exposure context;
- ability to test combined heat/noise/pollution/radiation effects rather than infer them from separate studies.

Do not claim a new 'environmental discomfort index' unless it is actually defined, validated and justified; that was only an example of how the story might evolve.

## 11. Process feedback from supervisors

This was a major part of the meeting and should not be lost:

- the analysis was perceived as changing too often between meetings;
- the supervisors felt the group was revisiting the same plots rather than building cumulatively;
- concern was expressed about confidence in the data and in explaining what the models actually do;
- the instruction was to slow down, understand each modelling choice, and do each analytical component once comprehensively rather than repeatedly rerunning after discovering omitted variables later;
- AI-generated code/results must be understood and independently checked; the confusion over H2 equation direction was used as an example;
- the next package should be complete enough that supervisors can review a stable analysis rather than another intermediate version.

Pranav's own post-meeting assessment was that the meeting went badly and felt like there had been little/no progress. This is consistent with the explicit supervisor statement that the work was 'going in circles' and not visibly building week to week.

## 12. Confirmed / high-priority actions

### A. Statistical analysis

- [ ] Redesign H4 from only univariate/single-predictor models to a scientifically justified **multivariable co-exposure model**.
- [ ] Define a limited, non-redundant environmental predictor set for the multivariable model using literature + physical meaning + collinearity diagnostics.
- [ ] Test relevant co-exposure interactions (e.g., thermal × sound/noise; other combinations only if justified).
- [ ] Examine whether co-exposure effects differ by mobility mode (Bike vs Walk) where supportable.
- [ ] Assess covariance / multicollinearity explicitly (correlation matrix and/or VIF/condition diagnostics as appropriate).
- [ ] For genuinely one-predictor/one-outcome questions, use/report a simple correlation/association and significance unless the repeated design specifically requires a mixed model.
- [ ] Add **environment -> psychology** analyses, not only environment -> physiology and psychology -> physiology.
- [ ] Verify H2 model direction and rewrite the equation/figure so the predictor/outcome roles are unambiguous.
- [ ] Verify exact normalization order in code for H1/H3 and document it mathematically.
- [ ] Keep a broad candidate physiological variable set initially; do not discard HRV frequency-domain or other plausible variables before literature-based screening.

### B. Interpretation / visual checks

- [ ] Identify a defensible shortlist of key physiological indicators only after broad screening and literature review.
- [ ] Create/inspect qualitative participant/phase plots linking selected physiology + psychology + UTCI/environmental context.
- [ ] Recheck every reported coefficient direction against the plotted/raw condition means before writing interpretation.
- [ ] Investigate EDA tonic reliability under sweating/walking/cycling and explain why walking shows the stronger Urban–Green signal if retained.
- [ ] Strengthen literature support for pupil/blink/fixation/gaze interpretations.

### C. Environmental derived data

- [ ] Keep Clearness Index and document that it is derived from radiation/astronomical inputs rather than directly measured.
- [ ] Ensure final GVI implementation and intended statistical role are accurately described.
- [ ] Upload/share the latest 10-second YAMNet notebook/output.
- [ ] Decide whether YAMNet categories and GVI belong in the final H4/co-exposure model; if yes, actually merge them into the analysis dataset and rerun before claiming them as predictors.

### D. Normalization

- [ ] Complete the normalization-method comparison once using literature-defined candidates by variable family.
- [ ] Compute/report robustness criteria such as ICC and leave-one-participant-out performance where methodologically meaningful.
- [ ] Do not claim a single winning normalization for all modalities until the evaluation supports it.
- [ ] Explicitly document the Indoor-baseline limitation for eye tracking.

### E. Paper/story

- [ ] Reframe the Results/Discussion around a coherent multi-domain story rather than a catalogue of significant correlations.
- [ ] Make clear which analyses are primary, sensitivity, exploratory and newly added co-exposure analyses.
- [ ] Preserve cautious language: associations are not causal; ocular measures have illumination/task confounding; correlated environmental predictors cannot be interpreted as independent causal stressors without appropriate adjustment.

## 13. Deliverables and deadlines discussed

### Main analysis package

The transcript contains two very close deadline statements:

- 'by the ninth, you share all the packets';
- later, 'the night of the 8th' was noted as the hand-off point.

**Safest operational deadline: 8 October 2026, end of day**, so supervisors have roughly a week to review before the planned in-person meeting.

The package should include:

- updated code/link;
- all hypotheses;
- the new co-exposure/multivariable analysis;
- broad variable coverage before final reduction;
- covariance/collinearity assessment;
- stable figures/tables rather than another interim rerun.

## 14. Meetings / administrative follow-up

- A separate meeting for **1 October 2026 at 13:00** was agreed; Pranav was asked to send the invitation.
- A larger **in-person meeting on 15 October 2026 at 10:00** was proposed and accepted in the transcript.
- There was discussion of contacting another collaborator/reviewer ('G' in the transcript; exact identity unclear) quickly for feedback:
  - possible short meeting early the following week (Monday or Tuesday morning), or
  - Wednesday afternoon / Friday before 15:00 depending availability;
  - then a joint follow-up around 15 October.
- Alternative availability mentioned for the week of 14 Oct included 14 Oct after ~14:00, 15 Oct broadly available, and 16 Oct before 15:00.
- Reply to **Chen's email** was identified as an administrative action.
- The EPFL master's-student item was described as **not urgent**.

## 15. What has *not* been finally decided

Do not treat these as settled decisions:

- exact final H4 predictor subset;
- exact interaction hierarchy for the co-exposure model;
- whether a new composite 'environmental discomfort' index will be created;
- exact final shortlist of physiological outcomes;
- exact final normalization method for every physiological/ocular family;
- exact statistical form for environment–psychology analyses;
- whether GVI/YAMNet categories enter the final inferential model or remain environmental characterisation/descriptive variables;
- exact causal interpretation of EDA/ocular findings;
- all names/references mentioned orally (some are corrupted by transcription).

## 16. Immediate implication for the current GitHub analysis

Compared with the current repository state on 30 Sep 2026, the largest required change is clear:

1. **H1/H3 factorial framework can remain**, subject to the normalization-order verification and broader variable screening.
2. **H2 code currently models physiology as the outcome and psychology as predictor**; this is acceptable as an association model only if clearly explained, but the meeting requires the direction/concept to be made explicit and psychology–environment relationships to be added.
3. **H4 current final code is still single-predictor/univariate.** This does not yet satisfy today's request for co-exposure/multivariable modelling.
4. **Current statistical analysis does not yet integrate YAMNet categories or GPS-matched GVI as inferential predictors**, despite those datasets existing. Do not write that they have been statistically tested until integration/rerun is complete.
5. The next stable analysis should be generated once after the variable set, co-exposure model, normalization strategy and collinearity plan are explicitly fixed.

## 17. One-sentence meeting takeaway

**The experiment/data are potentially strong, but the next step is to stop adding isolated analyses and build one verified, literature-grounded, multivariable co-exposure framework that connects environment, physiology and psychology, with clear model direction, normalization and collinearity control.**

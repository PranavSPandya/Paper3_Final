# Paper 3: From all columns to the multivariable mixed-effects model

## The short answer

The analysis starts with **all 189 columns** in:

`output/merged_all_11participants_8min.csv`

It does **not** put all 189 columns into one equation. The columns have different jobs:

1. Some identify the participant, phase, time, or sensor record.
2. Some are quality-control fields.
3. Some are outcomes to be explained.
4. Some are possible environmental predictors.
5. Some are redundant versions of the same physical exposure.

Only the last group is reduced to the final environmental predictor set. The current primary H4 model uses:

- **Five environmental predictors:** UTCI, sound level, PM2.5, illuminance, and GVI.
- **One design covariate:** travel mode (Bike versus Walk).
- **One random effect:** participant ID.
- **One outcome at a time:** 30 declared physiological, ocular, and psychological outcomes.

This is the model actually represented in the current statistical output:

```text
wpz(Outcome) ~ Mode + wpz(UTCI) + wpz(SND_dBA) + wpz(PM2.5)
               + wpz(Lux) + wpz(GVI) + (1 | ParticipantID)
```

The model is fitted separately for each of the 30 outcomes. Therefore, the primary H4 output contains **30 models × 5 environmental coefficients = 150 predictor-result rows**, not one model containing 189 predictors.

---

## 1. Starting point: the complete source table

| Item | Current value |
|---|---:|
| Raw input columns | 189 |
| Raw input rows | 5,077 |
| Participants | 11 |
| Primary route phases | 4 per participant: BikeU, WalkU, BikeG, WalkG |
| Matched route epochs | 2,156 ten-second rows |
| Participant-phase model units | 44 |
| Primary duration | First 8 minutes of each route phase |

The four route phases provide the matched primary analysis. Indoor and Tram records remain in the master table for descriptive or separate sensitivity work; they are not used to define the primary within-person route normalization.

The R scripts create **13 temporary derived sensor-fusion columns** during processing, so the working R data frame has 202 columns after loading. The source CSV itself still has 189 columns. This explains why the statistical `Run_Manifest.csv` records 202 working columns: it records the post-fusion R object rather than the untouched CSV schema.

---

## 2. First reduction: classify every source column by function

This is an audit, not a model-fitting step. Every source column is retained in the inventory and assigned one role.

| Role | What happens to it in the primary H4 model |
|---|---|
| Participant, phase, timestamp, GPS, tracking metadata | Used to identify and order observations; not entered as environmental predictors |
| Demographics and clothing | Descriptive baseline information; not entered as time-varying H4 predictors; participant baseline is represented by the random intercept where appropriate |
| Sensor quality and HRV-window flags | Used for quality control and missingness checks; not entered as exposures |
| Physiological and ocular measures | Outcomes, not predictors |
| Questionnaire measures | Outcomes for the psychological models; not predictors in H4 |
| Movement variables and travel mode | Possible exertion controls; the current primary H4 model includes `Mode` (Bike/Walk), not every GPS or accelerometer column |
| Environmental sensor and derived streams | Candidate exposure predictors; reduced in the next steps |

The important distinction is:

```text
All 189 columns are audited
        ↓
Columns are assigned a scientific role
        ↓
Only environmental exposure candidates enter predictor reduction
        ↓
Only the pre-specified five representatives enter primary H4
```

---

## 3. Second reduction: create comparable environmental candidates

The environmental pool contains raw sensor channels and derived indices. Before assessing collinearity, channels measuring the same exposure are harmonized:

- Left and right Atmotube channels are averaged into PM1, PM2.5, PM10, temperature, and humidity streams.
- The two LYS illuminance sensors are combined into `lys_lux_avg`.
- Derived thermal indices are retained as candidate streams but are not all entered together.
- Raw directional infrared channels, duplicate solar-forced thermal formulas, discrete labels, IDs, and protocol flags are not treated as independent continuous exposures.
- YAMNet semantic sound proportions remain available for secondary sound-type analyses; they are distinct from measured sound intensity (`ucm_SND_dBA`).

The current statistical script tests **32 cleaned environmental streams** in its secondary mode-adjusted single-predictor screening. That screening is not the primary multivariable model and is not used to choose predictors after seeing significance.

---

## 4. Final environmental predictor reduction

The primary model uses one interpretable representative from each exposure domain. The representatives are chosen before interpreting the H4 results and are checked for collinearity before co-entry.

| Exposure domain | Final predictor | Why this represents the domain |
|---|---|---|
| Thermal conditions | `ucm_UTCI` | Standard integrated thermal-stress index using air temperature, radiation, humidity, and wind |
| Acoustic exposure | `ucm_SND_dBA` | Measured sound pressure level in dBA |
| Air pollution | `atmo_pm2.5_avg` | Bilateral Atmotube PM2.5 average |
| Visual light | `lys_lux_avg` | Bilateral photopic illuminance average |
| Greenery | `gvi_50m` | Continuous 50-m greenery exposure measure |

The point is not that the other measurements are unimportant. They are either:

- alternate measurements of the same domain;
- component variables of a derived index;
- raw bilateral channels replaced by a physically meaningful average;
- discrete or metadata fields;
- or secondary variables reserved for sensitivity or exploratory analyses.

The five final predictors are entered **simultaneously**, so each coefficient estimates the association of that exposure while the other four exposure domains and travel mode are held in the model.

---

## 5. Primary multivariable mixed-effects model

The current primary H4 model is fitted at the participant-phase level using the matched first 8 minutes:

```text
wpz(Outcome) ~ Mode + wpz(UTCI) + wpz(SND_dBA) + wpz(PM2.5)
               + wpz(Lux) + wpz(GVI) + (1 | ParticipantID)
```

### What each part means

- `wpz(Outcome)`: the outcome is within-person standardized using the four outdoor route phases only.
- `Mode`: adjusts for Bike versus Walk.
- `wpz(UTCI)`, `wpz(SND_dBA)`, `wpz(PM2.5)`, `wpz(Lux)`, and `wpz(GVI)`: the five simultaneous environmental predictors, also standardized within participant.
- `(1 | ParticipantID)`: allows each participant to have their own baseline level.
- `REML`: used for estimation of the linear mixed-effects model.
- `N = 44`: one participant-phase observation for each of 11 participants across four route phases.

The primary co-exposure model is not the temporal AR(1) model. AR(1) is used in the separate continuous time-series sensitivity analysis, where the outcome remains at epoch resolution and adjacent observations are modeled as serially correlated.

---

## 6. Outcomes in the current primary H4 run

The five predictors are tested against 30 outcomes, fitted one outcome at a time:

- **4 psychological:** general comfort, pleasantness, STAI-6 anxiety, and PRS-11 total restorativeness.
- **13 autonomic:** heart rate, EDA tonic, EDA phasic, skin temperature, SDNN, RMSSD, LF, HF, LF/HF ratio, LFnu, HFnu, VLF, and total power.
- **13 ocular:** pupil diameter, pupil change rate, blink duration, fixation duration, fixation rate, saccade duration, saccade amplitude, saccade peak velocity, gaze velocity, gaze dispersion, distance from center, gaze centrality, and eyelid aperture.

These are dependent variables. They are not part of the environmental predictor-selection funnel.

---

## 7. What the current files contain

| File | Purpose |
|---|---|
| `scripts/data_validation.R` | Audits all source columns and validates the five-domain predictor set |
| `documents/data_validation.md` | Plain-language explanation of the all-columns-to-five-predictors reduction |
| `scripts/statistical_analysis.R` | Fits H1-H4 models using the declared outcomes and the five primary H4 predictors |
| `output/statistical_analysis/H4_Multivariable_CoExposure.csv` | 150 primary H4 predictor-result rows |
| `output/statistical_analysis/H4_Environmental_Stressors.csv` | Secondary single-predictor and interaction results, separate from primary H4 |
| `output/statistical_analysis/Model_Audit.csv` | Records fitted, skipped, and failed model attempts |
| `output/statistical_analysis/Run_Manifest.csv` | Records the current input, duration, normalization, and model specifications |

## Bottom line

The defensible reduction is:

```text
189 raw source columns
→ role classification for every column
→ environmental candidate harmonization
→ 32 cleaned secondary environmental streams
→ 5 pre-specified domain representatives
→ 30 separate multivariable mixed-effects models
```

The five predictors are **UTCI, sound dBA, PM2.5, illuminance, and GVI**. The document is not claiming that all other columns are useless; it is documenting why they are not simultaneous primary H4 predictors.

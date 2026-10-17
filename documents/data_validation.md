# Paper 3 variable audit and reduction — historical snapshot

> **Current status (7 October 2026):** The counts below describe the 5 October merged-table snapshot. `scripts/H4_multivariate.R` is the single H4 script. Its revised implementation now uses person-mean-centered predictors, iterative highest-VIF removal, phase-level coverage, questionnaire uniqueness checks, and fit-qualified FDR. It has not been run after these changes; all saved H4 model tables and audit figures remain historical and non-reportable. The five H4 exposure domains are analyst-selected candidates, not a documented preregistered set; no protocol/QC rationale for the fixed 11-person cohort has been located.

> **Merge blocker:** ExpData\.venv\Scripts\python.exe is not present, so the updated merge could not be run in the required environment. Rebuild the merged inputs before refreshing this audit or using H4 outputs.

## Aim

This document records the audit rules applied to a historical Paper 3 merged analysis table. The earlier candidate formula below is superseded by the updated, unrun specification in the H4 section:

```text
Outcome_GZ ~ Mode + centered_UTCI + centered_dBA + centered_PM25 + centered_logLux + centered_GVI + (1 | ParticipantID)
```

It establishes:
1. **Complete Accounting:** The historical pre-integration roster is classified into its exact functional role, while the current sound and SVF integration fields are listed explicitly below.
2. **Physical Sensor Fusion:** Bilateral sensor pairs (Atmotube and LYS) are averaged, duplicate calculations are removed, and QC flags are reserved for row filtering.
3. **Candidate Exposure Set:** One analyst-selected representative per physical domain enters an outcome-blind VIF screen. This selection is exploratory unless a dated analysis plan establishes prespecification.
4. **Statistical Verification:** The fitter is implemented but has not been run. This document does not establish that models converged, passed residual checks, or produced reportable FDR-adjusted results.

> **Schema synchronization (5 October 2026).** The active merge produces 228 columns in both the matched 8-minute and full tables. The older 189-column roster below is retained as audit history, not as the current post-integration schema. The active merge removes `ucm_AQ_CO_m1`, `ucm_AQ_CO2`, `ucm_AQ_NO2_m1`, `ucm_AQ_O3_m1`, `ucm_AQ_SO2_m4`, `ucm_AQ_pm010`, `ucm_AQ_pm025`, and `ucm_AQ_pm100` from the statistical inputs.

## Step 0 — Source

Input: `output/merged_all_11participants_8min.csv`

- 228 integrated columns in the current matched 8-minute output
- 5,077 rows
- 11 participants
- Primary phases: `BikeU`, `WalkU`, `BikeG`, `WalkG`
- Primary duration: first 8 minutes

The historical pre-integration roster is listed below, followed by the current integrated fields added by the active merge.

## Step 1 — Classify all 189 columns

### Class 1 — Metadata and tracking: 16

`ParticipantID`, `PhaseID`, `Datetime`, `Date`, `ucm_Date`, `ucm_GPS_lat`, `ucm_GPS_lon`, `ucm_GPS_alt`, `ucm_GPS_HDOP`, `ucm_GPS_hdg`, `ucm_MAG_hdg`, `ucm_GPS_speed_valid_sample_count`, `atmo_lys_Date`, `eyetracker_Date`, `pct_complete`, `gvi_match_dist_m`

Action: use for identification, ordering, timing, and coverage. Do not use as environmental predictors.

### Class 2 — Empatica HRV quality-control fields: 7

`empatica_hrv_fd_5min_available`, `empatica_hrv_fd_5min_segment_start`, `empatica_hrv_fd_5min_segment_end`, `empatica_hrv_fd_5min_valid_rri_count`, `empatica_hrv_fd_5min_removed_pct`, `empatica_hrv_fd_5min_max_gap_seconds`, `empatica_hrv_fd_5min_valid_span_seconds`

Action: use for quality control. Do not use as predictors or outcomes.

### Class 3 — Demographics and clothing: 28

`questionnaire_participant_id`, `questionnaire_response_index_within_participant`, `questionnaire_clothing_height_raw`, `questionnaire_clothing_weight_raw`, `questionnaire_clothing_skin_tone`, `questionnaire_clothing_upper_body`, `questionnaire_clothing_lower_body`, `questionnaire_clothing_footwear`, `questionnaire_clothing_accessories`, `questionnaire_height_m`, `questionnaire_weight_kg`, `questionnaire_bmi_kg_m2`, `questionnaire_bmi_category_who`, `questionnaire_background_name`, `questionnaire_background_age`, `questionnaire_background_gender`, `questionnaire_background_nationality`, `questionnaire_background_residential_area`, `questionnaire_background_years_in_brussels`, `questionnaire_background_vision_correction`, `questionnaire_background_site_familiarity_1_10`, `questionnaire_background_residence_type`, `questionnaire_background_has_children`, `questionnaire_background_commute_modes`, `questionnaire_background_regular_physical_activity`, `questionnaire_background_daily_walking`, `questionnaire_background_bike_frequency`, `questionnaire_background_own_bike_for_experiment`

Action: use for participant description. Do not use as time-varying environmental predictors.

### Class 4 — Movement and exertion: 6

`empatica__met`, `empatica_acc_x`, `empatica_acc_y`, `empatica_acc_z`, `empatica_vector_magnitude`, `ucm_GPS_speed_kmh`

Action: possible exertion covariates. Not all are automatically entered into primary H4.

### Class 5 — Physiological and eye-tracking outcomes: 28

`empatica__eda_scl_usiemens`, `empatica_eda_tonic`, `empatica_eda_phasic`, `empatica_skin_temperature`, `empatica_hrv_td_sdnn`, `empatica_hrv_fd_lf`, `empatica_hrv_fd_hf`, `empatica_hrv_fd_lf_hf_ratio`, `empatica_hrv_fd_lfnu`, `empatica_hrv_fd_hfnu`, `empatica_hrv_fd_vlf`, `empatica_hrv_fd_total_power`, `empatica_hrv_td_rmssd`, `empatica_heart_rate`, `eyetracker_pupil_diameter_avg`, `eyetracker_pupil_change_rate`, `eyetracker_blink_duration_s`, `eyetracker_fixation_duration_s`, `eyetracker_fixation_rate`, `eyetracker_saccade_duration_s`, `eyetracker_saccade_amplitude`, `eyetracker_saccade_peak_velocity`, `eyetracker_gaze_velocity`, `eyetracker_gaze_dispersion`, `eyetracker_distance_from_center`, `eyetracker_gaze_centrality`, `eyetracker_eyelid_aperture_avg`, `eyetracker_stress_composite`

Action: dependent variables, not environmental predictors.

### Class 6 — Questionnaire outcomes: 11

`questionnaire_current_comfort_1_7`, `questionnaire_space_familiarity_1_5`, `questionnaire_pleasantness_1_5`, `questionnaire_thermal_comfort_1_5`, `questionnaire_environmental_comfort_mean_1_5`, `questionnaire_stai6_mean_1_5`, `questionnaire_prs11_fascination_mean_1_5`, `questionnaire_prs11_being_away_mean_1_5`, `questionnaire_prs11_coherence_mean_1_5`, `questionnaire_prs11_scope_mean_1_5`, `questionnaire_prs11_total_mean_1_5`

Action: dependent variables, not environmental predictors.

### Class 7 — Environmental candidates: 93

#### UCM environmental columns: 35

`ucm_AIR_temp`, `ucm_AIR_RH`, `ucm_AIR_T_bot`, `ucm_AIR_T_mid`, `ucm_AIR_T_top`, `ucm_IR_back`, `ucm_IR_front`, `ucm_IR_left`, `ucm_IR_right`, `ucm_IR_up`, `ucm_IR_down`, `ucm_IR_spot_gnd`, `ucm_IR_spot_sky`, `ucm_IR_spot_left`, `ucm_IR_spot_right`, `ucm_SUN_Gh`, `ucm_SND_dBA`, `ucm_WIND_AWS`, `ucm_WIND_AWA`, `ucm_WIND_TWS`, `ucm_WIND_TWD`, `ucm_IO_flag`, `ucm_AH`, `ucm_SUN_alt`, `ucm_SUN_az`, `ucm_fp`, `ucm_MRT`, `ucm_MRT_S`, `ucm_OPT`, `ucm_HUMIDEX`, `ucm_HUMIDEX_SR`, `ucm_UTCI`, `ucm_UTCI_SR`, `ucm_PET`, `ucm_PET_SR`

#### LYS light columns: 24

`atmo_lys_LYS1__lys_b'`, `atmo_lys_LYS1__lys_g'`, `atmo_lys_LYS1__lys_kelvin`, `atmo_lys_LYS1__lys_lux`, `atmo_lys_LYS1__lys_medi`, `atmo_lys_LYS1__lys_movement`, `atmo_lys_LYS1__lys_r'`, `atmo_lys_LYS1__lys_rgbb`, `atmo_lys_LYS1__lys_rgbg`, `atmo_lys_LYS1__lys_rgbir`, `atmo_lys_LYS1__lys_rgbr`, `atmo_lys_LYS2__lys_b'`, `atmo_lys_LYS2__lys_g'`, `atmo_lys_LYS2__lys_kelvin`, `atmo_lys_LYS2__lys_lux`, `atmo_lys_LYS2__lys_medi`, `atmo_lys_LYS2__lys_movement`, `atmo_lys_LYS2__lys_r'`, `atmo_lys_LYS2__lys_rgbb`, `atmo_lys_LYS2__lys_rgbg`, `atmo_lys_LYS2__lys_rgbir`, `atmo_lys_LYS2__lys_rgbr`, `atmo_lys_LYS1__lux_cat`, `atmo_lys_LYS2__lux_cat`

#### Atmotube columns: 10

`atmo_lys_atmotube_left__atmotube_pm10`, `atmo_lys_atmotube_left__atmotube_pm1`, `atmo_lys_atmotube_left__atmotube_pm2.5`, `atmo_lys_atmotube_left__atmotube_humidity`, `atmo_lys_atmotube_left__atmotube_temperature`, `atmo_lys_atmotube_right__atmotube_pm10`, `atmo_lys_atmotube_right__atmotube_pm1`, `atmo_lys_atmotube_right__atmotube_pm2.5`, `atmo_lys_atmotube_right__atmotube_humidity`, `atmo_lys_atmotube_right__atmotube_temperature`

#### Current canonical GVI columns

`gvi_50m`, `gvi_tree_50m`, `gvi_grass_50m`, `gvi_plant_50m`, `gvi_match_dist_m`, `gvi_phase_mean`, `tree_phase_mean`, `grass_phase_mean`, `plant_phase_mean`

#### Clearness-index columns: 3

`Clearness_Index_G0`, `Clearness_Index`, `Clearness_Index_Infer`

#### Current integrated sound columns

The active merge retains calibrated `ucm_SND_dBA` from the base table and adds `sound_category_label`, seven semantic prevalence fields (`sound_prop_natural`, `sound_prop_traffic`, `sound_prop_human`, `sound_prop_music`, `sound_prop_mechanical`, `sound_prop_nonmotorized_transport`, `sound_prop_unidentified`), six corresponding semantic score fields, 21 original-rate frequency descriptors, and nine sound-window/QC fields. The 521 official YAMNet class fields remain in the per-window sound output but are not all copied into the statistical merge.

#### Current integrated SVF columns

`Sky_%`, `SVF`, `Tree_%`, `Plant_%`, `Grass_%`, `Total_Vegetation_%`, `Building_%`, `Wall_%`, `Ceiling_%`, `Total_Builtup_%`

The historical count check `16 + 7 + 28 + 6 + 28 + 11 + 93 = 189` applies only to the earlier pre-integration roster.

## Step 2 — Process environmental candidates

1. Atmotube left/right channels: create bilateral averages for PM1, PM2.5, PM10, temperature, and humidity.
2. LYS1/LYS2 channels: create comparable bilateral light measures; do not treat raw left/right channels as independent exposures.
3. UCM infrared planes and mast tiers: do not enter separately when represented by standard thermal measures.
4. Solar-forced duplicate indices and astronomical coordinates: exclude from the primary exposure pool.
5. GVI spatial, component, and phase-summary fields: retain `gvi_50m` in the full audit; its primary-H4 status is decided by the exact matched-design VIF rule.
6. Sound: retain measured `ucm_SND_dBA` for primary intensity; retain semantic sound proportions only for secondary screening; exclude IDs, text labels, and unidentified residue.
7. Keep all remaining eligible continuous environmental candidates for the collinearity audit.

## Step 3 — Candidate environmental streams

The active statistical script audits continuous environmental candidate streams after explicit sensor fusion. Calibrated `ucm_SND_dBA` is the primary acoustic-intensity stream; the new semantic sound proportions and original-rate frequency descriptors remain available for clearly labelled secondary/exploratory screening. Missing values remain missing and are not silently converted into zero exposure.

`Clearness_Index`, `atmo_humidity_avg`, `atmo_lys_LYS1__lys_lux`, `atmo_pm1.0_avg`, `atmo_pm10_avg`, `atmo_pm2.5_avg`, `atmo_temperature_avg`, `gvi_50m`, `lys_kelvin_avg`, `lys_lux_avg`, `lys_lux_participant`, `lys_rgbb_avg`, `lys_rgbg_avg`, `lys_rgbr_avg`, `sound_prop_natural`, `sound_prop_traffic`, `sound_prop_human`, `sound_prop_music`, `sound_prop_mechanical`, `sound_prop_nonmotorized_transport`, `sound_prop_unidentified`, `dominant_frequency_hz`, `spectral_centroid_hz`, `spectral_rolloff85_hz`, `ucm_AIR_RH`, `ucm_AIR_temp`, `ucm_HUMIDEX`, `ucm_MRT`, `ucm_OPT`, `ucm_PET`, `ucm_SND_dBA`, `ucm_SUN_Gh`, `ucm_UTCI`, `ucm_WIND_AWA`, `ucm_WIND_AWS`, `ucm_WIND_TWD`, `ucm_WIND_TWS`, `Sky_%`, `SVF`, `Tree_%`, `Plant_%`, `Grass_%`, `Total_Vegetation_%`, `Building_%`, `Wall_%`, `Ceiling_%`, `Total_Builtup_%`

No outcome p-value is used to create this list. The linked `H4_Candidate_Audit.csv` is the historical disposition of the earlier 189-column roster; it must be regenerated from the current 228-column merged input before being treated as the current audit.
## Locked validation protocol

This section is the **decision protocol** for Paper 3. It does not create a new sample or redefine the experiment.

**Fixed study scope (not a filter):**
- Participants: `P4, P8, P9, P10, P11, P12, P13, P14, P15, P16, P17`.
- Primary phases: `BikeU, WalkU, BikeG, WalkG`.
- Primary route window: matched first 8 minutes.
- `Indoor` and `Tram` are not part of the four-route H4 predictor-centering reference or primary H4 phase model.
- Raw versus derived status is **never** an exclusion criterion. A scientifically meaningful derived variable (e.g. UTCI, HRV frequency-domain metrics, GVI) remains eligible.

The validation pipeline contains only **three actual variable-selection gates**. Predictor centering and participant-phase matching are processing invariants, not additional filters.

---

## Filter 1 — Analytical role and deterministic eligibility

### Scientific question
Is a column an analytically meaningful exposure/outcome for the stated model role, or is it metadata, QC support, participant description, movement context, a duplicate representation, categorical text/ID, or a zero-variance field?

### Decision rule
This gate is **role-based**, not outcome-driven and not based on p-values.

- Metadata/identifiers/timestamps/GPS-quality fields are retained for provenance, alignment and QC but are not environmental predictors.
- Empatica HRV QC fields are retained for signal-quality verification but are not physiological outcomes. The actual HRV metrics (LF, HF, LF/HF, LFnu, HFnu, VLF, total power, RMSSD, SDNN) remain physiological outcomes.
- Demographics and clothing variables are retained for participant description, not treated as time-varying environmental exposures.
- Movement/exertion variables are retained as context or potential sensitivity covariates, not automatically entered into primary H4.
- Zero-variance variables cannot be modelled and are excluded from inferential entry.
- A variable is **not** excluded because it is derived.

### RETAINED
**Physiological/ocular outcomes:** all variables listed in Class 5 above, including:
`empatica_heart_rate`, `empatica_eda_tonic`, `empatica_eda_phasic`, `empatica_skin_temperature`, `empatica_hrv_td_sdnn`, `empatica_hrv_td_rmssd`, `empatica_hrv_fd_lf`, `empatica_hrv_fd_hf`, `empatica_hrv_fd_lf_hf_ratio`, `empatica_hrv_fd_lfnu`, `empatica_hrv_fd_hfnu`, `empatica_hrv_fd_vlf`, `empatica_hrv_fd_total_power`, and the declared eye-tracking outcomes.

**Psychological outcomes:** the questionnaire outcome variables listed in Class 6 above.

**Environmental streams retained for audit/screening:**  
`Clearness_Index`, `atmo_humidity_avg`, `atmo_lys_LYS1__lys_lux`, `atmo_pm1.0_avg`, `atmo_pm10_avg`, `atmo_pm2.5_avg`, `atmo_temperature_avg`, `gvi_50m`, `lys_kelvin_avg`, `lys_lux_avg`, `lys_lux_participant`, `lys_rgbb_avg`, `lys_rgbg_avg`, `lys_rgbr_avg`, `sound_prop_natural`, `sound_prop_traffic`, `sound_prop_human`, `sound_prop_music`, `sound_prop_mechanical`, `sound_prop_nonmotorized_transport`, `sound_prop_unidentified`, `dominant_frequency_hz`, `spectral_centroid_hz`, `spectral_rolloff85_hz`, `ucm_AIR_RH`, `ucm_AIR_temp`, `ucm_HUMIDEX`, `ucm_MRT`, `ucm_OPT`, `ucm_PET`, `ucm_SND_dBA`, `ucm_SUN_Gh`, `ucm_UTCI`, `ucm_WIND_AWA`, `ucm_WIND_AWS`, `ucm_WIND_TWD`, `ucm_WIND_TWS`, `Sky_%`, `SVF`, `Tree_%`, `Plant_%`, `Grass_%`, `Total_Vegetation_%`, `Building_%`, `Wall_%`, `Ceiling_%`, `Total_Builtup_%`.

### EXCLUDED FROM THE PRIMARY ENVIRONMENTAL-PREDICTOR ROLE
These columns remain in the dataset where useful; “excluded” means they do not enter primary H4 as environmental predictors.

- **Metadata/QC/tracking:** the Class 1 and Class 2 variables above.
- **Participant description:** the Class 3 variables above.
- **Movement/exertion context:** `empatica__met`, `empatica_acc_x`, `empatica_acc_y`, `empatica_acc_z`, `empatica_vector_magnitude`, `ucm_GPS_speed_kmh`.
- **Outcomes:** all physiological/ocular and questionnaire outcomes; they are responses, not environmental predictors.
- **Raw duplicate/fused channels:** unilateral Atmotube channels after construction of the paired route averages; raw LYS colour channels where a harmonized physical light metric is used.
- **IDs/text/categorical sound fields:** `sound_category_label`, `sound_prop_unidentified`.
- **Zero-variance fields:** excluded from model entry if variance = 0.

No outcome significance is consulted at this gate.

---

## Filter 2 — Within-domain redundancy

### Scientific question
Do multiple candidate variables within the same physical domain carry sufficiently overlapping information that they should not be co-entered into the primary joint model?

### Test
Absolute Spearman rank correlation with the **predeclared domain representative**.

### Locked decision rule

[
\boxed{|\rho_{Spearman}| \ge 0.70 \Rightarrow \text{redundant for simultaneous primary co-entry}}
]

[
\boxed{|\rho_{Spearman}| < 0.70 \Rightarrow \text{not automatically removed; may remain secondary}}
]

This is an **outcome-blind redundancy rule**. It is not used to choose the representative by whichever variable gives the best outcome association.

### Predeclared domain representatives
- Thermal: `ucm_UTCI`
- Acoustic intensity: `ucm_SND_dBA`
- Air pollution: `atmo_pm2.5_avg`
- Visual light: `lys_lux_avg`
- Greenery: `gvi_50m`

Raw versus derived status plays no role in this selection.

### RETAINED AFTER THE REDUNDANCY GATE

**Primary representatives:**  
`ucm_UTCI`, `ucm_SND_dBA`, `atmo_pm2.5_avg`, `lys_lux_avg`, `gvi_50m`.

**Non-primary variables that remain available for secondary/mechanistic analysis when they are not redundant with the representative:**  
thermal context such as `ucm_AIR_RH`, `ucm_WIND_AWS`, `ucm_WIND_TWS`, `Clearness_Index`; semantic sound variables such as `sound_prop_natural`, `sound_prop_traffic`, `sound_prop_human`, `sound_prop_music`, `sound_prop_mechanical`, and `sound_prop_nonmotorized_transport`; frequency descriptors and SVF components remain available as clearly labelled secondary candidates.

### EXCLUDED FROM SIMULTANEOUS PRIMARY CO-ENTRY

Variables meeting $|\rho| \ge 0.70$ with the predeclared representative are not co-entered with that representative in primary H4. Examples documented in the current audit include:

- **Thermal:** `ucm_PET`, `ucm_OPT`, `ucm_MRT`, `ucm_AIR_T_mid`, `ucm_AIR_temp`, `ucm_HUMIDEX` when their observed $|\rho|$ with UTCI is at or above 0.70.
- **Greenery:** duplicate/component representations such as `gvi_tree_50m`, `gvi_grass_50m`, `gvi_plant_50m`, `gvi_phase_mean`, `tree_phase_mean`, `grass_phase_mean`, and `plant_phase_mean` when their observed $|\rho|$ with `gvi_50m` is at or above 0.70.
- Any additional same-domain candidate reaching the same locked threshold is treated identically.

“Excluded” here means **excluded from simultaneous primary co-entry**, not deleted from the dataset and not forbidden from clearly labelled secondary analyses.

---

## Filter 3 — Joint multicollinearity of the primary co-exposure set

### Scientific question
After redundancy filtering, can the predeclared domain representatives be estimated jointly without unacceptable coefficient variance inflation?

### Test
Variance Inflation Factor (VIF), calculated on the participant-phase design used for H4 and checked again for the eye-tracking complete-case subset.

$$
VIF_k = \frac{1}{1-R_k^2}
$$

### Locked Paper 3 decision rule

$$
\boxed{VIF < 5.0 = \mathrm{PASS}}
$$

$$
\boxed{VIF \ge 5.0 = \mathrm{FAIL\ for\ the\ primary\ co\text{-}exposure\ specification}}
$$

There is **no second Paper 3 acceptance threshold of 10**. If a proposed primary specification produces VIF $\ge 5$, that specification must be revised before interpreting outcome coefficients.

### Starting candidates for the current H4 VIF iteration

The initial outcome-blind co-exposure candidates are:

`ucm_UTCI` + `ucm_SND_dBA` + `atmo_pm2.5_avg` + `lys_lux_avg` + `gvi_50m`.

This list is the starting set, not a promise that all five remain in the final model. The active script recomputes VIF after each step and removes whichever current predictor has the highest VIF until every retained VIF is < 5. Historical saved VIF and coefficient outputs do not determine the new retained set.

### EXCLUDED AFTER VIF

The final removed set is determined at each run by the VIF trace; it is not fixed in advance.

Alternative redundant specifications are rejected when they violate the same VIF < 5 rule. For example, adding PET alongside UTCI or adding air temperature alongside UTCI creates an unacceptable joint specification when the resulting VIF reaches or exceeds 5. These failed alternatives are evidence for not co-entering multiple overlapping thermal metrics; they do not imply that PET or air temperature are invalid measurements.

---

## Processing invariants — not additional filters

### Participant-mean centering

For each participant, each phase-level exposure is centered using that participant's mean across the four active route phases:

`BikeU + WalkU + BikeG + WalkG`.

$$
x_{ij}^{centered}=x_{ij}-\bar{x}_i
$$

`Indoor` and `Tram` are excluded from the primary centering reference. The predictor is not divided by a participant-specific SD estimated from only four observations. Outcomes remain pooled z-scores after the stated HRV transformations.

### Exact participant-phase pairing

Phase-level values are aggregated by:

`ParticipantID + PhaseID + Mode + Environment`.

Therefore, for example:

`P8 BikeG UTCI` is paired only with `P8 BikeG` physiology/psychology.

It is never paired with `P8 BikeU`, `P8 WalkG`, or another participant.

---

## H4 design-factor handling — why Mode is fixed, why Environment is not in primary H4, and why PhaseID is not random

This section defines the **estimand** rather than another variable filter.

### ParticipantID

`ParticipantID` is the repeated observational unit. Each participant contributes four route-condition means, so the primary H4 model uses a participant random intercept:

$$
(1|ParticipantID)
$$

This accounts for persistent between-person baseline differences.

### Mode

`Mode` (Bike vs Walk) is included as a **fixed adjustment factor** in primary H4 because activity mode can alter physiological/ocular response independently of the measured environmental exposure mixture (e.g. exertion, airflow, visual task demands). Mode is therefore a nuisance/design factor for the primary co-exposure association, not one of the environmental exposure domains.

### Environment

`Environment` (Urban vs Green) is **not omitted because it is unimportant**. It is not included in the primary H4 adjustment set because the purpose of H4 is to decompose the environmental context into its measured continuous exposure dimensions (thermal, acoustic, particulate, light and greenery). Conditioning simultaneously on the broad Urban/Green label would change the estimand to an association **within a fixed environment category** and can absorb part of the very exposure contrast that UTCI, sound, PM2.5, lux and GVI are intended to represent.

Environment is tested directly in H1/H3 through the factorial experimental model. If an Environment-adjusted H4 is later requested, it must be labelled a **sensitivity model**, and VIF must be recalculated for that exact design matrix before interpretation. It must not silently replace the locked primary H4 after seeing outcome results.

### PhaseID

`PhaseID` has four planned levels: `BikeU`, `WalkU`, `BikeG`, `WalkG`. It is the deterministic combination of Mode × Environment and is retained as the **matching/aggregation key**.

It is **not** used as `(1|PhaseID)` in the primary participant-phase H4 because:

1. these four phases are fixed experimental conditions, not a random sample from a larger population of phase types;
2. there are only four PhaseID levels, so treating their variance as a random-effect distribution is poorly supported;
3. at the participant-phase mean level there is only one observation for each `ParticipantID × PhaseID` cell, so a nested random intercept for the individual participant-phase cell would be confounded with the residual;
4. entering PhaseID together with Mode and Environment would duplicate the same 2 × 2 design information.

The 10-second temporal sensitivity model is different: there are repeated observations within participant-phase, so `ParticipantID/PhaseID` and AR(1) structure can be used there. That does not justify a PhaseID random intercept in the phase-mean H4.

---

## Updated H4 model specification

The systematic analysis cohort specified for this study is P4 and P8-P17, with BikeU/BikeG/WalkU/WalkG. It aggregates each participant-phase to one row, giving at most 44 observations. Mode is the Bike/Walk fixed adjustment; PhaseID remains the matching and aggregation key, not a fixed effect in the model.

The predictor screen contains UTCI, calibrated dBA, bilateral PM2.5, bilateral Lux, and GVI. Lux uses 10-second bilateral raw lux, participant-phase mean lux, then `log10(mean lux + 1)`. Each phase-level predictor is centered by subtracting that participant's mean across the four selected routes, with no person-specific SD scaling. The code removes the current highest-VIF predictor whenever any VIF is >= 5, recalculates all remaining VIFs, and repeats until every retained VIF is < 5. The trace records each step and all VIFs. Missing primary predictors or absent participant-phase cells stop the run.

For each predictor and outcome, `H4_Phase_Coverage.csv` records `N_valid`, `N_expected`, coverage, and availability for every participant-phase. Sensor means use available valid rows, with 49 expected matched rows as the coverage denominator. No new missingness cutoff is imposed; an entirely missing cell remains missing. H4 accepts any finite UTCI value, including negative and zero values. Existing builder QC is carried through: dBA < 0 is masked upstream, frequency-domain HRV requires `empatica_hrv_fd_5min_available`, positive-only HRV is flagged and non-positive values treated as missing, and eye-tracker 10-second rows retain the upstream valid-gaze-sample rule. Questionnaire outcomes use one expected response per participant-phase: exactly one unique finite response is required and copied forward; conflicting duplicates stop the run.

For the 28 continuous outcomes, seven positive-only HRV measures are log-transformed after participant-phase aggregation and continuous outcomes are pooled z-scores. Non-positive HRV values are counted, flagged, and treated as missing without replacement. All four questionnaire outcomes require one unique finite response per participant-phase; duplicated identical values are carried forward once and inconsistent duplicates stop the run. The two single-item comfort/pleasantness outcomes retain their original ordered categories. The outcome formula is:

`Outcome_GZ ~ Mode + retained person-mean-centered exposures + (1 | ParticipantID)`

For comfort and pleasantness, the same fixed and random effects use an ordinal cumulative-logit mixed model. Continuous fits enter BH only when convergence, nonsingularity, Hessian, gradient, warning, and DHARMa criteria pass. Ordinal p-values remain outside BH until ordinal goodness-of-fit criteria are met. The BH family size remains the full declared outcome-by-retained-exposure count, including failed and ineligible tests; Mode is outside that family.

Interpretation requires verified input provenance and outcome-specific diagnostic review; unstable fits must not support inferential claims. Any alternative adjustment set is a separately labeled sensitivity model with its own collinearity check.

---

## Statistical reporting after validation

Data validation determines whether variables/model specifications are eligible. Statistical significance is a later inferential step, not a variable-selection filter.

- Primary model convergence/failure is logged.
- Effect estimates and confidence intervals are reported.
- Multiple testing is controlled using Benjamini-Hochberg FDR.
- The inferential significance criterion is `q < 0.05`.
- No variable enters or leaves the primary co-exposure set because of its outcome p-value.

---

## Final audit trail

The document therefore separates four different concepts that must not be mixed:

1. **Current H4 roster:** fixed scope P4 and P8-P17 with four outdoor phases; protocol/QC rationale for omitting six participants is not documented.
2. **Variable eligibility/redundancy:** analytical role + (|\rho| \ge 0.70) same-domain redundancy rule.
3. **Joint estimability:** exact-design `VIF < 5` required for every primary co-exposure predictor.
4. **Inference:** mixed-effects model estimates followed by BH-FDR `q < 0.05`.

The full raw-column categorization remains above so every source column can be traced to its sensor/source and analytical role.


H4 refresh on 2026-10-07: rebuilt both analysis-specific merges using the existing statistical-input builder. The 8-minute input has 5,077 rows and 1,252 columns, including all 521 YAMNet classes. Canonical sensor values now match, including corrected P16 WalkG UCM values and missing P8 WalkU ocular values. H4 checks canonical provenance before generating outputs. All 30 outcomes were fit: 25 continuous fits passed the coded diagnostics; SDNN, HF and pupil change rate were singular (pupil change rate also had DHARMa outlier p=0.0387). Two ordinal fits require separate goodness-of-fit review. The BH family contains 120 planned exposure coefficients; 100 entered adjustment and seven have q<0.05. Mode coefficients are outside that family. GVI was removed at VIF 8.500; retained exposure VIFs are 1.274-1.469 and the largest fixed-effect VIF including Mode is 2.399. Ocular models use 39 cells/10 participants, others 44/11. Coverage records 1,540 measure-cells, including 65 empty ocular cells and 38 available cells below 50%; no coverage cutoff is imposed.

UTCI source-to-analysis reconciliation (2026-10-07): the 20 negative samples previously mentioned are in the staged one-second raw UCM CSVs, not 20 negative H4 rows. Counts over the exact first 49 H4 windows are P10 BikeG=9, P14 BikeG=4, P14 WalkG=2, and P15 BikeU=5. The rebuilt UCM builder uses the pre-existing broad plausibility range in `00_QC_Gap_check.py` (-50 to 60 C): 18 out-of-range raw samples are masked; the two P14 WalkG readings (-3 and -2.9 C) are retained. Ten-second averaging combines those two with other samples in the same bins, yielding 22.06 C; therefore the H4 8-minute merged input has zero negative UTCI values. The full-duration processed UCM table has three negative ten-second summaries in P4 WalkU (outside the H4 first-eight-minute window); all are within the retained range and remain visible in that sensor output. Raw staged data were not modified. This reconciles the previous wording: negatives remain in the raw source file, while the H4 model receives phase means from processed 10-second values. H4 was rerun after the rebuild. No leave-one-participant-out sensitivity analysis was added.

## STEP 1 — Inventory (230)


| UCM                                                                                                         | Atmo raw                                                                                                                        | Atmo average                                                | LYS1 raw                                                                                                                       | LYS2 raw                   | LYS average                                                                                                                | GVI imagery                                                                                                                | SVF imagery                 | Sound                                                                                                             | Solar                                                                              | Empatica                                                                                                                                                                                                                                                                                                                                        | Eye-tracker                                                                                                                                                                                                                                                                                                                                              | Questionnaire                                                                | Metadata / QC                                            |                                                                                                                                                                 |                                                                |                                                                                                                                                                                                                                                            |                                                                                                                                                                                                                                                      |                                                                                                                                                                                    |                                                                                                                                                                                                                                                |                                                                                                                                                                                                                                 |                                                                                                                                                                                                                                  |                   |
| ----------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ | -------------------------- | -------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- | --------------------------- | ----------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- | -------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| AIR RH AIR temp HUMIDEX MRT PET SND dBA SUN Gh UTCI WIND AWS AH AIR T bot AIR T mid AIR T top GPS speed kmh | HUMIDEX SR IO flag IR back IR down IR front IR left IR right IR spot gnd IR spot left IR spot right IR spot sky IR up MRT S OPT | PET SR SUN alt SUN az UTCI SR WIND AWA WIND TWD WIND TWS fp | left pm1 left pm10 left pm2.5 right pm1 right pm10 right pm2.5 left humidity left temperature right humidity right temperature | pm1 avg pm10 avg pm2.5 avg | LYS1 kelvin LYS1 lux LYS1 lux cat LYS1 b' LYS1 g' LYS1 medi LYS1 movement LYS1 r' LYS1 rgbb LYS1 rgbg LYS1 rgbir LYS1 rgbr | LYS2 kelvin LYS2 lux LYS2 lux cat LYS2 b' LYS2 g' LYS2 medi LYS2 movement LYS2 r' LYS2 rgbb LYS2 rgbg LYS2 rgbir LYS2 rgbr | kelvin avg lux avg medi avg | GVI 50m GVI grass 50m GVI phase mean GVI plant 50m GVI tree 50m Grass phase mean Plant phase mean Tree phase mean | SVF TVF BVF Building % Ceiling % Total Vegetation % Total Builtup % Grass % Plant % Sky % Tree % Wall % | band proportion 1000-4000 Hz band proportion 125-1000 Hz band proportion 20-125 Hz band proportion 4000-8000 Hz band proportion 8000-20000 Hz category dominant frequency (Hz) mechanisms prop mechanisms score octave proportion 1000 Hz octave proportion 125 Hz octave proportion 2000 Hz octave proportion 250 Hz octave proportion 31.5 Hz | octave proportion 4000 Hz octave proportion 500 Hz octave proportion 63 Hz octave proportion 8000 Hz rural natural prop rural natural score spectral centroid (Hz) spectral rolloff 85% (Hz) unidentify prop urban manmade negative prop urban manmade negative score urban manmade neutral prop urban manmade neutral score urban manmade positive prop | urban manmade positive score vehicle prop vehicle score wind prop wind score | Clearness Index Clearness Index G0 Clearness Index Infer | acc x acc y acc z eda phasic eda scl usiemens eda tonic heart rate hrv fd hf hrv fd hfnu hrv fd lf hrv fd lf hf ratio hrv fd lfnu hrv fd total power hrv fd vlf | hrv td rmssd hrv td sdnn met skin temperature vector magnitude | blink duration s distance from center eyelid aperture avg fixation duration s fixation rate gaze centrality gaze dispersion gaze velocity pupil change rate pupil diameter avg saccade amplitude saccade duration s saccade peak velocity stress composite | current comfort 1 7 environmental comfort mean 1 5 pleasantness 1 5 prs11 being away mean 1 5 prs11 coherence mean 1 5 prs11 fascination mean 1 5 prs11 scope mean 1 5 prs11 total mean 1 5 space familiarity 1 5 stai6 mean 1 5 thermal comfort 1 5 | Date Date (Atmo/LYS) Date (UCM) Date (eye) Datetime GPS HDOP GPS alt GPS hdg GPS lat GPS lon GPS speed valid sample count GVI match dist m HRV 5min available HRV 5min max gap (s) | HRV 5min removed pct HRV 5min segment end HRV 5min segment start HRV 5min valid rri count HRV 5min valid span (s) MAG hdg ParticipantID PhaseID SVF Frames In Window SVF Status age bike frequency | bmi category who bmi kg m2 clothing accessories clothing footwear clothing height raw clothing lower body clothing skin tone clothing upper body clothing weight raw commute modes daily walking end time s gender has children | height m nationality own bike for experiment participant id pct complete phase start offset s regular physical activity residence type residential area response index segment site familiarity 1 10 vision correction weight kg | years in brussels |


---


### H4 specification

**Hypothesis:** Noise and traffic amplify thermal discomfort.

**Primary model (Eq 1):** UTCI × sound, with MRT × sound, solar irradiance (SUN Gh), SVF, PM2.5, lux, kelvin, and GVI as covariates, plus phase sum-to-zero contrasts.

**Sensitivities:** alternate heat formulations (Eq 3–5), PM size (Eq 6–7), and optional Eq 2 sound block. Competing heat formulations are never co-entered in one equation.

Selection method: one row per exposure (not one bundled “heat” row), by sensor; then check design VIF/rank. *Available cols* are inventory names for that exposure; *Chosen* is what enters the equations. "Derived" only describes how a field is produced — it is never an inclusion or exclusion rule.

Equations live in `scripts/H4_multivariate.R`. Extended narrative (centering, outcomes, FDR): [H4_Selection_Flow_explained.md](H4_Selection_Flow_explained.md).


### Declared exposures (by sensor)

One row per exposure. UCM and Atmo are never merged into the same row.


| Sensor | Role in H4 | Available cols | Chosen | How alternatives are handled |
| ------ | ---------- | -------------- | ------ | ---------------------------- |
| UCM | Primary heat (Eq 1, 6, 7) | UTCI; UTCI SR | **UTCI** | Not co-entered with PET, HUMIDEX, OPT, or Eq3 components |
| UCM | Heat sensitivity (Eq 5) | PET; PET SR | **PET** | Separate equation only |
| UCM | Heat sensitivity (Eq 4) | HUMIDEX; HUMIDEX SR | **HUMIDEX** | Separate equation only |
| UCM | Heat sensitivity (Eq 3) | AIR temp; AIR T bot; AIR T mid; AIR T top | **AIR temp** | Height tiers not co-entered |
| UCM | Heat sensitivity (Eq 3) | AIR RH; AH | **AIR RH** | AH not co-entered |
| UCM | Heat sensitivity (Eq 3) | WIND AWS; WIND TWS; WIND AWA; WIND TWD | **WIND AWS** | TWS / direction not co-entered |
| UCM | Not entered | OPT | — | Operative temperature not co-entered with AIR temp + MRT |
| UCM | Hypothesis moderator | SND dBA; band proportion 1000-4000 Hz; band proportion 125-1000 Hz; band proportion 20-125 Hz; band proportion 4000-8000 Hz; band proportion 8000-20000 Hz; category; dominant frequency (Hz); mechanisms prop; mechanisms score; octave proportion 1000 Hz; octave proportion 125 Hz; octave proportion 2000 Hz; octave proportion 250 Hz; octave proportion 31.5 Hz; octave proportion 4000 Hz; octave proportion 500 Hz; octave proportion 63 Hz; octave proportion 8000 Hz; rural natural prop; rural natural score; spectral centroid (Hz); spectral rolloff 85% (Hz); unidentify prop; urban manmade negative prop; urban manmade negative score; urban manmade neutral prop; urban manmade neutral score; urban manmade positive prop; urban manmade positive score; vehicle prop; vehicle score; wind prop; wind score | **SND dBA** | Extra frequency/semantic fields only in Eq 2 |
| UCM | Covariate | MRT; MRT S; IR back; IR down; IR front; IR left; IR right; IR spot gnd; IR spot left; IR spot right; IR spot sky; IR up | **MRT** | IR channels and MRT S not co-entered |
| UCM | Covariate | SUN Gh; SUN alt; SUN az; Clearness Index; Clearness Index G0; Clearness Index Infer | **SUN Gh** | Clearness / solar geometry not co-entered |
| Atmo | Covariate (primary pollution) | left pm2.5; right pm2.5; pm2.5 avg | **pm2.5 avg** | Raw left/right not co-entered with average |
| Atmo | PM size sensitivity (Eq 6) | left pm1; right pm1; pm1 avg | **pm1 avg** | Separate equation; not co-entered with PM2.5/PM10 |
| Atmo | PM size sensitivity (Eq 7) | left pm10; right pm10; pm10 avg | **pm10 avg** | Separate equation; not co-entered with PM2.5/PM1 |
| Atmo | Not entered | left temperature; right temperature | — | Use UCM AIR temp (separate sensor row) |
| Atmo | Not entered | left humidity; right humidity | — | Use UCM AIR RH (separate sensor row) |
| LYS | Covariate | LYS1 lux; LYS2 lux; LYS1 lux cat; LYS2 lux cat; lux avg | **lux avg** | Categories not used; raw LYS1/LYS2 not co-entered with average |
| LYS | Covariate | LYS1 kelvin; LYS2 kelvin; kelvin avg | **kelvin avg** | Raw LYS1/LYS2 not co-entered with average |
| LYS | Not entered | LYS1 medi; LYS2 medi; medi avg | — | Not used as H4 light exposure |
| SVF imagery | Covariate | SVF; TVF; BVF; Building %; Ceiling %; Total Vegetation %; Total Builtup %; Grass %; Plant %; Sky %; Tree %; Wall % | **SVF (Holmer)** | Scene % / TVF / BVF not co-entered as SVF substitutes |
| GVI imagery | Covariate | GVI 50m; GVI grass 50m; GVI phase mean; GVI plant 50m; GVI tree 50m; Grass phase mean; Plant phase mean; Tree phase mean | **GVI 50m Buffer** | Other buffers/components/phase means not co-entered |


**Rules used when a column is not entered**


| Rule                            | Meaning                                                                                          |
| ------------------------------- | ------------------------------------------------------------------------------------------------ |
| Same construct, not co-entered  | Another retained field already represents this exposure (or is a deterministic transform of it). |
| Alternate heat / PM formulation | Valid for H4, but only in its own equation.                                                      |
| Aggregation                     | Raw bilateral channels replaced by the declared average.                                         |
| Not an H4 exposure              | Outcome, QC, metadata, movement, or undocumented field.                                          |
| Eq2-only / model scope          | Outside the primary equation; optional sensitivity only.                                         |
| Measurement suitability         | No calibrated continuous H4 exposure declared.                                                   |
| PCA-informed (Eq 2)             | Sound sensitivity candidate list; see [Sound_screening_pca_vif.md](Sound_screening_pca_vif.md).  |


---

## STEP 2 — Domain grouping (16 core candidates + 10 Eq2 sound candidates)


| Thermal                  | Index            | Acoustic                                                                                                                                                                                                                           | Radiation      | Pollution                  | Light              | Greenery |
| ------------------------ | ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | -------------------------- | ------------------ | -------- |
| AIR temp AIR RH WIND AWS | HUMIDEX PET UTCI | SND dBA Eq2 additions: freq_prop_20_125, vehicle_prop, wind_prop, freq_prop_8000_20000, mechanisms_prop, octave_prop_125_0_hz, urban_manmade_neutral_prop, freq_prop_4000_8000, urban_manmade_positive_prop, dominant_frequency_hz | MRT SUN Gh SVF | pm1 avg pm2.5 avg pm10 avg | lux avg kelvin avg | GVI 50m  |


---



## STEP 3 — Equations + design VIF (7 equations)


| Equation                                                                                                                                                                                                                                                                  | Maximum VIF |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| Eq 1 (Primary Model): UTCI &#42; Sound + MRT &#42; Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) | 3.07 |
| Eq 2 (Sound sensitivity): Eq 1 + `freq_prop_20_125` + `vehicle_prop` + `wind_prop` + `freq_prop_8000_20000` + `mechanisms_prop` + `octave_prop_125_0_hz` + `urban_manmade_neutral_prop` + `freq_prop_4000_8000` + `urban_manmade_positive_prop` + `dominant_frequency_hz` | 3.09 |
| Eq 3 (Heat sensitivity — air temp, RH, wind): air temp &#42; Sound + RH &#42; Sound + wind &#42; Sound + MRT &#42; Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) | 2.55 |
| Eq 4 (Heat sensitivity — HUMIDEX): HUMIDEX &#42; Sound + MRT &#42; Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) | 2.50 |
| Eq 5 (Heat sensitivity — PET): PET &#42; Sound + MRT &#42; Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) | 3.02 |
| Eq 6 (PM size sensitivity — PM1): UTCI &#42; Sound + MRT &#42; Sound + solar irradiance + SVF (sky view) + PM1 + lux + kelvin (light) + GVI (greenery) | 3.06 |
| Eq 7 (PM size sensitivity — PM10): UTCI &#42; Sound + MRT &#42; Sound + solar irradiance + SVF (sky view) + PM10 + lux + kelvin (light) + GVI (greenery) | 3.07 |


Eq2 adds 10 sound main effects; original interactions and phase adjustment remain. The full design has been checked for all 26 outcome-specific samples. `scripts/H4_multivariate.R` defines all seven equations; Step 5 fits Eq2 only when `H4_SPEC$fit_sound_sensitivity` is TRUE (default FALSE). Published fit artifacts remain from the last six-equation run until rerun.

Each fitted equation also includes phase sum-to-zero contrasts (`PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`; BikeU implicit). In R formula notation, heat–sound interactions are written with `*` (e.g. `ucm_UTCI * ucm_SND_dBA`), which expands to main effects plus the product term.

**Eq2 sound note:** Within-participant-phase centering and unit-SD scaling precede PCA. B4 selection uses 10 PCs (84.04% cumulative; 80% rule alone → 9 PCs at 81.15%). Ten original-variable candidates; sound-only max VIF 2.11; full Eq1+10 mains max VIF 2.884–3.092; full rank; no VIF removals. Method: [Sound_screening_pca_vif.md](Sound_screening_pca_vif.md).



---



## APPENDIX B — Fields not entered (by rule)

Compact audit of inventory fields that are not H4 environmental predictors. Reasons use the declared-exposure rule table only.

**Same construct, not co-entered**

- AH → humidity is AIR RH.
- AIR T bot / mid / top → air temperature is AIR temp.
- HUMIDEX SR, MRT S, PET SR, UTCI SR → unsuffixed UCM measures.
- IR channels → MRT.
- OPT → not co-entered with air temperature and MRT.
- WIND TWS, WIND AWA, WIND TWD → wind speed is WIND AWS.
- Clearness Index, Clearness Index G0, Clearness Index Infer → solar is SUN Gh.
- GVI grass/plant/tree / phase means → greenery is GVI 50m.
- SVF scene percentages → sky openness is SVF Holmer.
- Atmo left/right humidity and temperature → UCM AIR RH / AIR temp.
- lux cat → continuous lux.
- medi (raw and avg) → not used; light representatives are lux avg and kelvin avg.

**Aggregation**

- Atmo left/right PM1/PM2.5/PM10 → pm1/pm2.5/pm10 avg.
- LYS1/LYS2 kelvin and lux → kelvin avg, lux avg.

**Alternate heat / PM formulation**

- AIR temp, AIR RH, WIND AWS, HUMIDEX, PET, PM1, PM10 — retained as candidates; enter only via Eq 3–7, not beside UTCI+PM2.5 in Eq 1.

**Eq2-only / model scope**

- Ten PCA-selected sound fields (Eq 2 only); other numeric sound fields not selected by that rule.
- GPS speed, LYS movement, Empatica movement/MET — movement, not environmental predictors.
- SUN alt, SUN az, IO flag, fp — outside declared H4 exposure set.

**Measurement suitability**

- LYS RGB / r'g'b' / IR export channels — no calibrated H4 average declared.

**Not an H4 exposure**

- Empatica and eye-tracker physiological/ocular series → outcomes (Y), not predictors.
- eda scl → input to phasic/tonic.
- stress composite → ocular composite, not an environmental predictor.
- Questionnaire comfort/PRS/STAI fields → psychological outcomes.
- All Date/GPS/QC/clothing/demographics/metadata fields → design or QC only.

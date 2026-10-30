# Wind Correction for sound — FHWA highway noise field measurement (5 m/s limit)

## Source

- FHWA noise barrier design / field measurement guidance (e.g. atmospheric effects and instrumentation sections).
- Summarized in state DOT procedures citing FHWA (e.g. Missouri EPG 127.13 Noise): measurements should not be conducted when wind speed at the microphone exceeds **12 mph (5 m/s)**, regardless of wind direction; wind speed should be monitored and recorded.

**URLs (accessed 2026-10-29):**

- https://www.fhwa.dot.gov/environment/noise/noise_barriers/design_construction/design/design17.cfm  
- https://www.fhwa.dot.gov/environment/noise/noise_barriers/design_construction/design/design14.cfm (windscreen on outdoor microphones)  
- https://epg.modot.org/index.php/127.13_Noise  

## What the guidance says

1. **Windscreens:** Porous windscreen on outdoor microphones; clean, dry, good condition; reduces wind-generated noise on the diaphragm (does not remove all wind effects).
2. **Wind speed cap:** Do not perform (or exclude) measurements when wind at the microphone **> 5 m/s (~12 mph)**, any direction — limits turbulence, refraction, and wind-on-microphone artifacts.
3. **This is exclusion / QC**, not a formula to subtract X dB from measured levels.

## How Paper3 uses it

- We adopt the **5 m/s exclusion** as a **predeclared sensitivity** on **`ucm_WIND_AWS`** per 10 s window in H4 sound scripts (`--wind-sensitivity`).
- We **do not** claim FHWA compliance for the full mobile uCM campaign without documenting microphone-height wind and windscreens (see master implementation note).

## What we do not do

- No calibrated dBA correction from FHWA TNM or traffic-noise prediction models.
- No substitution of AWS for microphone-height anemometry without stating the limitation.

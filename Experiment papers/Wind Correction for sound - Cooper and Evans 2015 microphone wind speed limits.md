# Wind Correction for sound — Cooper & Evans (2015) microphone wind speed limits

## Source

- **Cooper, J., & Evans, T.** (2015). *Microphone wind speed limits during wind farm noise measurements.*  
  Australian Acoustical Society Conference, Hunter Valley (AAS 2015).  
  PDF: https://www.acoustics.asn.au/conference_proceedings/AAS2015/papers/p122.pdf  

## Main findings (for Paper3)

1. A **5 m/s limit at the microphone** is widely used to avoid wind-induced **microphone** noise, but **excluding data above 5 m/s does not guarantee** clean measurements.
2. Field examples show adverse wind-microphone effects at **lower** speeds (e.g. ~1.7–3 m/s depending on site and windscreen).
3. Recommended practice: measure wind **adjacent to the microphone**, assess windscreen suitability, predict/correct wind-induced noise where needed — **not** rely on a single speed cutoff alone.

## How Paper3 uses it

- Justifies reporting **5 m/s screening as sensitivity**, not as proof that remaining data are wind-free.
- Motivates documenting **windscreen type** and **cycling/walking airflow** (apparent wind on body ≠ free-field anemometer).
- Supports **not** inventing a fixed dB wind correction when Cooper & Evans show cutoff-only strategies can be insufficient.

## Implementation link

- `Paper3_Final/scripts/statistical_analysis/library/H4_sound_core.R` — exclusion only; README in screening CSV states this limitation.

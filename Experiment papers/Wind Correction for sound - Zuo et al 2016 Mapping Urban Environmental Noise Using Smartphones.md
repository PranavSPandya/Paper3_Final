# Wind Correction for sound — Zuo et al. (2016) mobile noise mapping

## Source

- **Zuo, J., Xia, H., Liu, S., & Qiao, Y.** (2016). *Mapping Urban Environmental Noise Using Smartphones.*  
  **Sensors**, 16(10), 1692. https://doi.org/10.3390/s16101692  

## Main findings (for Paper3)

1. **Moving volunteers** need an external microphone with **windscreen**, clip, and cord — not only the phone’s built-in mic.
2. Avoid measurements in **strong wind**; authors state they generally **do not measure when wind is stronger than 5 m/s**, and use windscreens when windy.
3. Windscreens reduce but do not eliminate wind effect during **walking-style** mobility.

## How Paper3 uses it

- Supports **mobile / wearable** context for a **5 m/s operational cutoff** as literature-aligned **QC**, not a calibrated correction.
- Highlights that **self-motion** (walking/cycling) and microphone placement matter — our study uses **`ucm_WIND_AWS`** on the uCM unit as a practical proxy, with known limits vs microphone-local wind.

## What Paper3 does not implement from this paper

- Smartphone calibration workflow, Kriging noise maps, or region-type tagging from Zuo et al.

## Implementation link

- Same H4 sound wind **screening** (`--wind-sensitivity`); see master implementation markdown in this folder.

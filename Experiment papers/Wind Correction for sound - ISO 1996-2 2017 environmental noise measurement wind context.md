# Wind Correction for sound — ISO 1996-2:2017 (environmental noise measurement)

## Source

- **ISO 1996-2:2017** — *Acoustics — Description, measurement and assessment of environmental noise — Part 2: Determination of sound pressure levels* (frequency-resolved and outdoor measurement context).
- Local copy (preview): `Experiment papers/Sound frequencies - ISO 1996-2 2017 - PREVIEW ONLY.pdf`

## Relevance to Paper3

1. **Outdoor measurements** are affected by **meteorology** (including wind) and require appropriate instrumentation and measurement conditions.
2. **Frequency-resolved assessment** (used in our WAV / band-proportion work) sits in the same standards family as broadband dBA; wind can affect **low-frequency** content and broadband levels differently.
3. ISO frameworks emphasize **valid measurement conditions** and documented procedure — not ad hoc post-hoc dB subtraction.

## How Paper3 uses it

- Supports treating **high wind** as a **measurement-quality concern** for sound exposure, alongside windscreens and stable mounting.
- Supports **separate streams**: uCM `ucm_SND_dBA` vs Welch/YAMNet features from WAV (`Sound spectrum in field experiment.md`) — wind on WAV does not automatically imply the same contamination on uCM dBA.
- Our H4 implementation is **window exclusion** at 5 m/s on `ucm_WIND_AWS`, reported as sensitivity — **not** an ISO-certified correction factor applied to dBA.

## What we do not claim

- Full ISO 1996-2 compliance for every 10 s mobile sample without a complete measurement uncertainty and instrumentation dossier.

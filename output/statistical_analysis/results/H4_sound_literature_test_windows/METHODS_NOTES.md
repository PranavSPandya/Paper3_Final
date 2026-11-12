# H4 updated-approach window sensitivity
Run UTC: 2026-11-11 09:38:03 UTC
Input MD5: a3c4f9388b61def82e5b97b4232315be

## Windows
- full_8min: current 10 s series, minutes 0-8.
- skip_first_3min: drop the first 180 s (start-up); remaining ~5 min. Common field-physiology acclimatization cut.
- skip_first_5min: drop the first 300 s; remaining ~3 min. Same idea, shorter steady window.
- avg_1min / avg_2min: energy-mean dBA and arithmetic means inside 60 s / 120 s bins of the full 8 min. Grapas lag step matches the bin.
- These windows cannot recover Grapas's published 14-16 min delay.
- Questionnaire votes are one per bout, so Chiucchiù Spearman/comfort paired t and Cureau Fisher/comfort/multinom stay almost unchanged.

## Papers
- Grapas, Chiucchiu, Cureau 2022, Rodrigues only. Walk and bike as in the primary updated run.

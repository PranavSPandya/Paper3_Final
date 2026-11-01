H4 sound-source-adjusted block: exploratory extension of H4 (formerly H6.3); not a separate hypothesis; no causal claims.
Generated: 2026-10-31 22:08:57.134085
Input: C:\Users\sanga\Desktop\Pranav Paper3_Final\output\merged_all_11participants_8min.csv
Input MD5: d1566f55ce744035511d5bf17c7d8114
Script: scripts\statistical_analysis\H4_timeseries.R
Script MD5: 4857de998004fa18cfc3dccd3d96e227
Participants: P10, P11, P12, P13, P14, P15, P16, P17, P4, P8, P9
Core route rows: 2112
Method: per participant, 10 s rows with complete source, ucm_SND_dBA, ucm_UTCI, lys_lux_avg (mean of available LYS1/LYS2) and outcome (>=60 rows, >=2 phases); each variable centred within phase and standardised within person; lm(y ~ source + dba + utci + lux); participant dropped if rank-deficient or source VIF >= 5; Beta_SD = source slope.
Inference: exact two-sided sign-flip test on the mean participant slope (>=6 people); t-interval; BH across the 4 source x outcome rows.
Differs from H4_timeseries_sound.R, where the source proportion replaces dBA; here it is adjusted for dBA, UTCI and lux. Raw outcome units (no log).

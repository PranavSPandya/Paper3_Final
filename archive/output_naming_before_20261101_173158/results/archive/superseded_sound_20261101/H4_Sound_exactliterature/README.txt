H4_Sound_exactliterature: published physiology methods applied to our data with our own coefficients.
See the header of scripts/statistical_analysis/H4_Sound_exactliterature.R for each citation and every adaptation.
Outcome transforms: project normalization CSV (ln for HF, LF/HF etc., HR raw, as in Jo et al.), except D (Kraus rule: log all positive outcomes except HR).
Each paper's own p is reported unchanged; q_BH columns are our addition (no paper used FDR).
A compares whole green vs urban routes (heat, light, air also differ), so it cannot isolate sound.
B cut points: heat UTCI > 26 C, noise LAeq >= 65 dB(A), on 10 s epochs pooled over phases; >= 3 epochs per condition required.
C uses air temperature (ucm_AIR_temp), as Rodrigues used daily air temperature; p values are Wald z as in statsmodels MixedLM.
D uses 60 s epochs; Leq lags (0-15 min) omitted because phases last 8 min; random intercept = compound symmetry.
E is not from one paper; it is the form proposed in the group discussion.

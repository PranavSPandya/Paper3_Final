# Jo et al. paired-test adaptation
Reference: https://doi.org/10.3390/ijerph16152649
Question: Within each travel mode, does physiology differ between Green and Urban?
Paired t-tests: HR Green < Urban; ln(HF) Green > Urban; ln(LF/HF) Green < Urban.
Jo-style decision: one-sided p < 0.05. q_FDR is an ADDED correction across six tests.
Analysis unit: one participant-phase average; epochs are not independent participants.
Log HRV before averaging; exclude invalid frequency-domain windows and nonpositive values.
Adaptations: full 8-min field phases, two modes, wearable-derived HRV and 11 participants;
Jo used 60-s controlled headphone playback, ECG-derived HRV and 29 female participants.
Oxyhemoglobin and respiratory frequency are not replicated: matching measures unavailable here.
No matched pre-stimulus baseline comparison is attempted.
No UTCI restriction and no sound-proportion predictor. Green/Urban are environment labels.
These comparisons cannot isolate sound from other environmental differences and overlap H1.
Directions were taken from the literature after this dataset was examined: retrospective sensitivity.
Input: C:/Users/sanga/Desktop/Pranav Paper3_Final/output/merged_all_11participants_8min.csv
Input MD5: d1566f55ce744035511d5bf17c7d8114
Jo p<.05: 0 of 6; added FDR q<.05: 0 of 6

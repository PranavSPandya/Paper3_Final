# Psychophysiology - May 1981 - Fowles - Publication Recommendations for Electrodermal Measurements

## Document Metadata
- **Source PDF:** [Psychophysiology - May 1981 - Fowles - Publication Recommendations for Electrodermal Measurements.pdf](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Github/Experiment%20papers/Psychophysiology%20-%20May%201981%20-%20Fowles%20-%20Publication%20Recommendations%20for%20Electrodermal%20Measurements.pdf)
- **Title:** Publication Recommendations for Electrodermal Measurements
- **Authors:** Don C. Fowles, Michael J. Christie, Robert Edelberg, William W. Grings, David T. Lykken, Peter H. Venables
- **Journal:** *Psychophysiology*, Vol. 18, No. 3, May 1981, pp. 232–239
- **Pages:** 8

## Executive Summary
This landmark committee report published by the Society for Psychophysiological Research (SPR) established standard reporting recommendations and methodological guidelines for electrodermal activity (EDA), including skin conductance (SC), skin potential (SP), and skin resistance (SR).

### Key Physiological Norms & Thresholds Established
1. **Skin Conductance Response (SCR) Amplitude Range (Page 237, Right Column, Section "Tonic Level Control"):**
   > *"SCRs can be expected to range from .01 to 5 µmhos/cm² [0.01 to 5 µS], whereas SCLs range from 2 to 100 µmhos/cm² (Venables & Christie, 1973, p. 8)."*
   - This sets the foundational lower boundary of physical skin conductance responses at **0.01 µS** under controlled laboratory conditions.
2. **Units Standardization (Page 237, Footnote 8):**
   > *"The terms sieman and µsieman have replaced the terms mho and µmho as the internationally agreed units for conductance."* (1 µmho = 1 µS).
3. **Ambulatory / Field Measurement Threshold (Boucsein et al., 2012 Evolution):**
   - Building directly upon Fowles et al. (1981), the updated SPR committee guidelines (Boucsein et al., 2012) recommend increasing the minimum detection threshold to **0.05 µS** for ambulatory, field, and motion-heavy recordings to prevent motion artifacts, cable movement, and loose electrode contacts from registering as false SCRs.

## Methodological Recommendations
- **Measurement Configuration:** Recommends constant voltage (typically 0.5 V across electrodes) and recording skin conductance (SC in µS) rather than skin resistance (SR).
- **Electrode Placement & Electrolyte:** Bipolar recording on palmar or distal phalangeal sites using Ag/AgCl electrodes with a neutral, isotonic paste (0.05 M NaCl or KCl).
- **Separation of Tonic (SCL) vs Phasic (SCR):** Highlights that small phasic responses (.01 to 5 µS) are superimposed on much larger, slow-moving tonic baselines (2 to 100 µS), necessitating either AC-coupling, baseline tracking, or modern computational decomposition (e.g., Ledalab / cvxEDA).

## Direct Application to Paper 3
- **Data Filtering Criterion:** Justifies setting the minimum valid EDA threshold to **0.05 µS** for filtering out electrode dropouts and loose wristband contact (P4, P8, P16) during active cycling and walking in Brussels.
- **Methods Section Citation:** Serves as the primary foundational citation for skin conductance response amplitudes and physiological validity bounds.

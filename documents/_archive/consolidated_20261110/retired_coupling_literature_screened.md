**H5 papers screened.** Literature-style **sensitivity** (not primary H5): `H5_literature_sensitivity.R` runs Johnson multivar LMM and Van Doren psych–physio rmcorr at phase means. **Rodrigues (2026) is implemented under H4** (`H4_sound_literature_test.R`, noise/temperature blocks from their `7.Model_H2.py`), not duplicated here. Gidlow-style setting contrasts stay in H1_H3; Bakdash pairwise stays in `H5_stress_composite_pairwise.R`.

The live test is the restored pairwise screen: within-person repeated-measures correlation, `lm(composite_y ~ ParticipantID + composite_x)`, across the 55 stress-oriented composites (26 physiological, 21 environmental, 6 environmental groups, 2 ocular), then one Benjamini–Hochberg family on the fitted pairs. One numbered entry per paper. Under each citation: Measured, Test specified, and Reason. [Included] only when that paper states a test this screen runs. One included, twelve excluded. Nobody published this 55-composite pairwise grid. The included paper is the method for the within-person slope. It did not measure outdoor stress.

1. Bakdash and Marusich (2017) [Included]:
   - Measured: no urban environment, no physiology, and no mood or restoration scale. Two example repeated-measures datasets in a methods paper.
   - Test specified: repeated-measures correlation, the common within-person slope from an ANCOVA with a separate intercept per person (`Frontiers in Psychology`, 8:456).
   - Reason: That slope is the pair model in `H5_stress_composite_pairwise.R`. The paper does not define these 55 composites and did not test walking or cycling stress.

2. Johnson, Kanjo and Woodward (2023) [Excluded]:
   - Measured: on one walked urban route, PM1, PM2.5, PM10, oxidised and reduced gases, ammonia, noise, people count, EDA, heart rate, HRV, body temperature, BVP, movement, and self-reported valence (`Computational Urban Science`).
   - Test specified: a pooled Pearson correlation matrix, PCA factor maps, multiple linear regression of EDA and of heart rate on the environmental variables, and a CNN classifier of wellbeing.
   - Reason: Those are not participant-intercept repeated-measures correlations, and the paper does not specify the 55 composites (no eye tracking, no thermal-comfort index group, no restoration items).

3. Rodrigues, Conceição, Ramusga, Morgado and Lima Azevedo (2025) [Excluded]:
   - Measured: 2,207 walking trips, GPS, noise, temperature, vegetation, sky, street imagery, points of interest, HRV, EDA, skin temperature, and post-walk emotion ratings (Research Square preprint, doi:10.21203/rs.3.rs-7186620/v1).
   - Test specified: route-level correlations and mixed-effects models of environmental features with EDA and HRV summaries, plus clustering of route types.
   - Reason: Several outdoor indicators with several physiological summaries, still not a within-person pairwise screen of these 55 composites.

4. Korkmaz, Knauth, Brands, Schmeck, Büning and Peters (2025) [Excluded]:
   - Measured: the same urban walking route on two days, heart rate, HRV, and electrodermal activity, plus a check of outside temperature against EDA (`Scientific Reports`).
   - Test specified: fasted versus sated contrasts and bootstrapped test–retest correlations, including a first principal component of the physiological measures.
   - Reason: Reliability of physiology on one repeated route. Not an environment-by-physiology pairwise screen.

5. Amaro et al. (2025) [Excluded]:
   - Measured: a backpack that can record EEG, eye tracking, ECG, BVP, galvanic skin response, noise, and the inputs to UTCI (`Sensors`, 25:7163).
   - Test specified: none. The paper describes the instrument.
   - Reason: No association test to rerun.

6. Gidlow et al. (2016) [Excluded]:
   - Measured: self-paced walks in a residential street, a green setting, and a blue setting; mood, restoration, cognition, salivary cortisol, and HRV (`Journal of Environmental Psychology`, 45, 22–29).
   - Test specified: change from baseline by environment in a randomised crossover.
   - Reason: A setting contrast. That is the same family as a park walk versus a city walk, not the pairwise composite screen.

7. Hunter, Gillespie and Chen (2019) [Excluded]:
   - Measured: self-chosen nature visits and salivary cortisol and alpha-amylase (`Frontiers in Psychology`, 10:722).
   - Test specified: the association of visit duration with those two biomarkers.
   - Reason: One exposure feature and two biomarkers this campaign did not collect. Not the 55-composite grid.

8. Chrisinger and King (2018) [Excluded]:
   - Measured: citizen-science photo and audio walks with Empatica E4 accelerometry, skin temperature, blood volume pulse, heart rate, inter-beat interval, and EDA (`International Journal of Health Geographics`, 17:17).
   - Test specified: a protocol to organise, clean, geocode, and visualise those series.
   - Reason: No within-person pairwise test of environmental and physiological composites.

9. Kim et al. (2023) [Excluded]:
   - Measured: real-world pedestrian EDA, gait, and heart rate, geocoded against self-reported environmental stimuli (`Scientific Reports`, 13:5940).
   - Test specified: spatial summaries and a machine-learning classifier of location-based collective distress.
   - Reason: Not repeated-measures correlation of environmental sensor composites with physiological composites.

10. Torku, Chan, Yung and Seo (2023) [Excluded]:
    - Measured: older pedestrians’ wearable physiology under urban built conditions the authors labelled stressful or non-stressful (Healthy City Design 2022 proceedings, SALUS).
    - Test specified: whether those physiological reactions indicate the stressful versus non-stressful condition.
    - Reason: A condition contrast, not the pairwise composite screen.

11. Van Doren, Dickens, Benson, Brick, Gatzke-Kopp and Oravecz (2021) [Excluded]:
    - Measured: four weeks of ambulatory physiology and ecological momentary emotion ratings (Biological Psychology, doi:10.1016/j.biopsycho.2021.108074).
    - Test specified: within-person association between subjective emotion and physiology.
    - Reason: The within-person part matches the Bakdash question, and the paired measures are emotion and physiology. There is no outdoor environmental indicator, so it does not specify this screen.

12. Zhu, Wen, Cao, He and Wang (2024) [Excluded]:
    - Measured: no new field series. A review of mixture methods (`Frontiers in Public Health`, doi:10.3389/fpubh.2024.1377685).
    - Test specified: weighted quantile sum, Bayesian kernel machine regression, and related mixture models.
    - Reason: Those mixture models are not the pairwise repeated-measures correlation, and this screen does not run them.

13. Benjamini and Hochberg (1995) [Excluded]:
    - Measured: no environment and no physiology (`Journal of the Royal Statistical Society, Series B`, 57, 289–300).
    - Test specified: the Benjamini–Hochberg false-discovery procedure.
    - Reason: The screen applies that procedure to the fitted pair p-values. The paper does not specify which pairs to test. It is not an empirical source for the composites.

Local files opened and not given their own entries: `Empatica - Stress in the City Multimodal Biosensing of Urban Stress.pdf` is Ulan Alsiyeu and Zhasdauren Duisebekov on traffic-sign data augmentation, so it was not screened as an urban-stress study. `Empatica - Kyriakou et al 2019...pdf` is a one-page download placeholder, so Kyriakou et al. (2019) is not cited.

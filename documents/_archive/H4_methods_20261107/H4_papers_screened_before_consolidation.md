**H4 papers screened.** One numbered entry per paper; under each citation, sub-bullets for Measured, Outdoor/Sound/Thermal/Outcome, and Reason, then [Included] or [Excluded] on the citation line. Historical core screening is retained below. Current implementation also includes a labelled noise-only comparator (Kraus), two indoor Anna Laura analogues, and the explicitly scoped outdoor additions listed at the end; inclusion does not mean exact replication.

1. Moshammer et al. (2019) [Included]:
   - Measured: ambulatory ECG on a road and in a park, personal Leq, air temperature, MET, and blood pressure.
   - Outdoor: present. Sound: present (Leq). Thermal: present (air temperature). Outcome: present (heart rate, HRV, and blood pressure).
   - Reason: Missing: blood pressure in this campaign. Heart rate, HRV, Leq, and air temperature are present, so those terms were tested.

2. Song et al. (2013, 2014) [Excluded]:
   - Measured: HRV on a park walk and a city-street walk.
   - Outdoor: present. Sound: missing (no dBA). Thermal: missing. Outcome: present (SDNN and RMSSD).
   - Reason: Missing: sound level and a thermal term. A park-versus-city setting contrast is not an H4 sound test. Removed from H4_sound_literature_test.R on 2026-11-05.

3. Jin, Jin and Kang (2020) [Included]:
   - Measured: sound level, UTCI, and thermal and environmental comfort in outdoor squares.
   - Outdoor: present. Sound: present (dBA). Thermal: present (UTCI). Outcome: present (those two comfort items).
   - Reason: Missing: none. Outdoor, dBA, UTCI, and the two comfort items are all present.

4. Rodrigues et al. (2026) [Included]:
   - Measured: trip noise, heat, HRV, EDA, skin temperature, and gaze while walking.
   - Outdoor: present. Sound: present. Thermal: present. Outcome: present (physiology and gaze).
   - Reason: Missing: none. Outdoor, trip noise, heat, and physiology/gaze are all present.

5. Kraus et al. (2013) [Noise-only comparator]:
   - Measured: personal Leq and HRV, with a slope change at 65 dBA. Their model uses activity and time of day.
   - Outdoor: present (daily life). Sound: present (Leq). Thermal: missing. Outcome: present (heart rate and HRV).
   - Reason: Missing: thermal term. Air temperature was offered to the model and was not kept for any of the five outcomes, so the slope has no thermal term.

6. Mahecha Nuñez et al. (2018) [Excluded]:
   - Measured: a smartband stress event from skin conductance and skin temperature on cycle paths.
   - Outdoor: present. Sound: present. Thermal: present. Outcome: present (their stress-event score).
   - Reason: Missing: that stress-event score. This campaign has the two signals, not their algorithm.

7. Teixeira et al. (2020) [Excluded]:
   - Measured: the same smartband stress event while cycling in five cities.
   - Outdoor: present. Sound: present. Thermal: present. Outcome: present (their stress-event score).
   - Reason: Missing: that stress-event score. Same gap as Mahecha Nuñez et al. (2018).

8. Korpilo et al. (2024) [Included]:
   - Measured: smart-ring EDA on walking visits to forest, beach and park; 5-min audio recordings scored as NDSI; temperature and relative humidity as GLMM covariates.
   - Outdoor: present. Sound: present (NDSI, not dBA). Thermal: present (temperature and RH as covariates, verified from full text). Outcome: present (EDA level).
   - Reason: Missing: none for the terms this campaign holds. Tested as its own H4 block from 2026-11-05: ln phase-mean tonic EDA ~ NDSI analogue + air temperature + RH + PhaseID, random participant intercept. The earlier exclusion note (thermal not in the paper) was wrong: their EDA models include temperature and RH covariates.

9. Burns et al. (2016) [Excluded]:
   - Measured: personal noise and heart rate.
   - Outdoor: present. Sound: present. Thermal: missing. Outcome: present (heart rate).
   - Reason: Missing: thermal term.

10. Tartarini et al. (2023) [Excluded]:
    - Measured: watch sound level and thermal-comfort micro-surveys.
    - Outdoor: present. Sound: present. Thermal: present as a survey. Outcome: missing (no heat–noise test).
    - Reason: Missing: a heat-by-noise test. Sound and comfort surveys are present, with no model that joins them.

11. Schaupp et al. (2025) [Excluded]:
    - Measured: dBA on forest and urban walks, cortisol, an attention test, and questionnaires.
    - Outdoor: present. Sound: present. Thermal: not in the model. Outcome: present (cortisol).
    - Reason: Missing: a thermal term, and cortisol was not collected here.

12. Jafari et al. (2021) [Excluded]:
    - Measured: salivary cortisol under a sound or heat contrast.
    - Outdoor: present. Sound: present in the sound arm. Thermal: present in the heat arm. Outcome: present (cortisol).
    - Reason: Missing: cortisol. It was not collected here.

13. Lan et al. (2024) [Excluded]:
    - Measured: physiology in a park versus an urban setting.
    - Outdoor: present. Sound: missing as a dose. Thermal: present as place climate. Outcome: present.
    - Reason: Missing: a sound-level term. Park versus urban is already the Moshammer walk contrast.

14. Zhang et al. (2026) [Excluded]:
    - Measured: aesthetic and environmental-quality ratings outdoors.
    - Outdoor: present. Sound: present as perception. Thermal: present as perception. Outcome: missing (those scales).
    - Reason: Missing: their aesthetic and environmental-quality items.

15. Lam et al. (2024) [Excluded]:
    - Measured: perceived environmental quality outdoors.
    - Outdoor: present. Sound: present as perception. Thermal: present as perception. Outcome: missing (those scales).
    - Reason: Missing: their perceived-environmental-quality items.

16. Tu et al. (2026) [Excluded]:
    - Measured: a multi-pathway mediation of outdoor exposures.
    - Outdoor: present. Sound: present. Thermal: present. Outcome: present in kind.
    - Reason: Missing: enough cells for their mediation paths. Outdoor, sound, and thermal are present.

17. Li et al. (2026) [Excluded]:
    - Measured: EEG and an odor condition.
    - Outdoor: present. Sound: present. Thermal: present. Outcome: present (EEG and odor).
    - Reason: Missing: EEG and the odor condition. Neither was recorded here.

18. Li, Li and Wang (2025) [Excluded]:
    - Measured: sound level, air temperature, and walking-comfort surveys on a greenway.
    - Outdoor: present. Sound: present. Thermal: present. Outcome: missing (those surveys; no wearable model).
    - Reason: Missing: a wearable outcome. Sound, air temperature, and comfort surveys are present; the comfort test already run is Jin.

19. Li et al. (2025) [Excluded]:
    - Measured: noise or heat with hypertension as the endpoint.
    - Outdoor: present. Sound: present. Thermal: present. Outcome: present (hypertension).
    - Reason: Missing: blood pressure. It was not recorded here.

20. Chen (2007) [Excluded]:
    - Measured: hearing threshold under noise.
    - Outdoor: not a walked route. Sound: present (noise). Thermal: not in the paper. Outcome: present (hearing threshold).
    - Reason: Missing: a thermal term. Hearing threshold was not recorded here.

21. Bidel et al. (2022) [Excluded]:
    - Measured: EMG. This screening note does not have a walked route, a dBA term, or a thermal term for this paper.
    - Outdoor: not in the paper. Sound: not in the paper. Thermal: not in the paper. Outcome: present (EMG).
    - Reason: Missing: a thermal term. EMG is their outcome and was not recorded here.

22. He et al. (2025) [Excluded]:
    - Measured: responses near 90 dB.
    - Outdoor: not this walking exposure. Sound: present, at about 90 dB. Thermal: not in the paper. Outcome: present in the paper.
    - Reason: Missing: a thermal term. These routes do not reach 90 dB.

23. El Aarbaoui et al. (2017) [Excluded]:
    - Measured: personal Leq and SDNN, LF, HF, and LF/HF, adjusted for heart rate and activity.
    - Outdoor: present (daily life). Sound: present. Thermal: missing. Outcome: present (HRV).
    - Reason: Missing: thermal term.

24. El Aarbaoui and Chaix (2020) [Excluded]:
    - Measured: the same Leq–HRV link split by home and transport.
    - Outdoor: present. Sound: present. Thermal: missing. Outcome: present (HRV).
    - Reason: Missing: thermal term. Their contrast is also home versus transport, which these four phases are not.

25. Huang et al. (2013) [Excluded]:
    - Measured: sitting in traffic versus a park; noise as a modifier of the particle effect on HF.
    - Outdoor: present. Sound: present as a modifier. Thermal: missing. Outcome: present (HF).
    - Reason: Missing: thermal term. Noise only modifies the particle effect.

26. Biel et al. (2020) [Included]:
   - Measured: personal noise and air pollution with ambulatory HR and HRV; air temperature in every model, relative humidity as a potential confounder.
   - Outdoor: present. Sound: present (personal dBA). Thermal: present (mean air temperature as a linear term). Outcome: present (HR, SDNN, RMSSD, LF, HF, LF:HF).
   - Reason: Missing: none for the terms this campaign holds. Tested as its own H4 block from 2026-11-05: HR/HRV at phase means ~ phase-mean personal dBA (per IQR) + air temperature, random participant intercept. The earlier exclusion (duplicate of the Moshammer family) understated the difference: Biel models concurrent noise with a temperature term, Moshammer models a preceding-window Leq.

27. Buregeya, Apparicio and Gelb (2020) [Excluded]:
    - Measured: cycling change in heart rate and HRV versus a percent noise dose, in four riders.
    - Outdoor: present. Sound: missing as Leq (percent dose). Thermal: missing. Outcome: present (heart rate and HRV).
    - Reason: Missing: Leq (they use a percent noise dose) and a thermal term.

28. Schnell et al. (2015) [Excluded]:
    - Measured: body-worn noise, CO, and thermal load versus place discomfort.
    - Outdoor: present. Sound: present. Thermal: present. Outcome: missing (place-discomfort rating).
    - Reason: Missing: an HRV outcome. They model place discomfort.

29. Krüger et al. (2025) [Excluded]:
    - Measured: climate walks, skin temperature, and questionnaires, with noise noted near roads.
    - Outdoor: present. Sound: missing as a model term. Thermal: present. Outcome: present (skin temperature and questionnaires).
    - Reason: Missing: a sound term in the model. Noise is only described.

30. Cureau et al. (2022) [Partially implemented — Fisher exact comfort-domain tests]:
    - Measured: sound level on park walks and comfort surveys.
    - Outdoor: present. Sound: present. Thermal: present. Outcome: missing (survey logistics; no wearable model).
    - Current scope (2026-11-06): Fisher exact comfort-domain associations are implemented separately by phase/site analogue in library/H4_additional_outdoor_methods.R. Absence of physiology does not exclude a comfort-outcome test. Independent-local-sample comparisons and original multinomial model suite are not fitted; matching respondents/items and adequate category support are absent.

31. Franěk et al. (2018) [Excluded]:
    - Measured: walking speed under headphone traffic noise or birdsong.
    - Outdoor: present. Sound: present as headphone playback, not route Leq. Thermal: not in the paper. Outcome: present (walking speed).
    - Reason: Missing: a thermal term and route Leq. Walking speed was not the H4 outcome.

32. Alvarsson et al. (2010) [Excluded]:
    - Measured: skin conductance and HF under played nature sound or traffic noise.
    - Outdoor: missing (laboratory). Sound: present as playback. Thermal: missing. Outcome: present (skin conductance and HF).
    - Reason: Missing: outdoor exposure and a thermal term.

33. Hedblom et al. (2019) [Excluded]:
    - Measured: skin conductance under virtual-reality bird song or traffic noise.
    - Outdoor: missing. Sound: present as playback. Thermal: missing. Outcome: present (skin conductance).
    - Reason: Missing: outdoor exposure and a thermal term. Sound is playback.

34. Cai et al. (2021) [Excluded]:
    - Measured: SDNN, LF/HF, and heart rate at assigned levels from 35 to 65 dBA.
    - Outdoor: missing. Sound: present as assigned levels. Thermal: missing (room held near 25 °C). Outcome: present (heart rate and HRV).
    - Reason: Missing: outdoor exposure and a thermal term. The room was held near 25 °C.

35. Barros et al. (2025) [Excluded]:
    - Measured: skin conductance, heart rate, and HF while auralized traffic changed.
    - Outdoor: missing. Sound: present as playback. Thermal: missing. Outcome: present (skin conductance, heart rate, HF).
    - Reason: Missing: outdoor walked Leq and a thermal term. Sound is indoor playback.

36. Yousefinezhad et al. (2026) [Excluded]:
    - Measured: heart rate and body temperature under assigned heat and 75 dBA.
    - Outdoor: missing (laboratory). Sound: present as an assigned level. Thermal: present as assigned heat. Outcome: partly present (heart rate and skin temperature; blood pressure is missing).
    - Reason: Missing: outdoor exposure. Heat and 75 dBA were assigned in a laboratory.

37. Chiu et al. (2021) [Excluded]:
    - Measured: wind-turbine low-frequency noise and SDNN, with ambient temperature.
    - Outdoor: partly (home sites). Sound: missing (not route A-weighted Leq). Thermal: present. Outcome: present (SDNN).
    - Reason: Missing: route A-weighted Leq. Their sound is residential low-frequency wind-turbine noise.

38. Li et al. (2023) [Excluded]:
    - Measured: HRV, skin conductance, and weather on a planned route chosen to be quiet.
    - Outdoor: present. Sound: missing. Thermal: present. Outcome: present (HRV and skin conductance).
    - Reason: Missing: a sound term. The route was chosen to be quiet.

39. Temperature and vehicle flow (2021) [Excluded]:
    - Measured: how air and pavement temperature change noise emitted by traffic.
    - Outdoor: present (roadside). Sound: present as an emission. Thermal: present. Outcome: missing (no person).
    - Reason: Missing: a person-level outcome. The paper models emitted traffic noise.



## Added outdoor / Anna Laura implementation registry — 2026-11-06

40. Chen et al. (2023), Forests 14:1161, doi:10.3390/f14061161 [Explicit adaptation only]:
   - Outdoor sensory walking, 30 people, 12 locations, five-minute stops, thermal/acoustic/source-type data and votes.
   - Original method: ANOVA with sphericity assessment and GG/HF corrections. Original repeated factorial/source-ranking structure cannot be reconstructed here.
   - Implemented and named as an adaptation: continuous participant-intercept LMM of available comfort ratings on standardized UTCI, dBA, their interaction, and natural-source share. NOT their exact ANOVA.
41. Ueberham et al. (2019), Sustainability 11:1412, doi:10.3390/su11051412 [Evidence only; not fitted]:
   - Outdoor cycling, objective temperature/noise/particles and subjective exposure intensity. Original route-level Spearman and person-mean ordinal regressions.
   - Missing equivalent subjective exposure/loudness items. Acoustic/thermal comfort is not substituted silently.
42. Li, Li & Wang (2025), doi:10.1007/s00484-024-02790-7 [Pending full text; not fitted]:
   - Outdoor greenway walking, thermal/acoustic perceptions, arrival/departure comparisons.
   - Publisher PDF is paywalled; exact model cannot be verified from abstract. Arrival/departure paired ratings not present here.
43. Pigliautile et al. (2021), CISBAT/JPCS 2042:012136 [Indoor protocol analogue]:
   - Existing H4 block retained. Controlled test room / headphone soundscapes; outdoor cooler/warmer and nature/traffic mappings are adaptations.
44. Chiucchiu et al. (2026), Building and Environment 290:114140 [Indoor protocol analogue]:
   - Existing paired physiology and perceptual-domain tests retained with explicit outdoor mapping; no recreated assigned temperature, headphones or Big Five clustering.

Full papers and access/adaptation details: Experiment papers/Sound_evidence/ADDITIONAL_OUTDOOR_METHODS_20261106.md.
Tram is an additional five-phase sensitivity (--include-tram), not classified as walking/cycling. Source walking-only tests remain walking-only.

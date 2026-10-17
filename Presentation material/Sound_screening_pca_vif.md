# Sound screening: PCA and VIF

**All candidate fields:** `category`, `ucm_SND_dBA`, `dominant_frequency_hz`, `spectral_centroid_hz`, `spectral_rolloff85_hz`, `freq_prop_20_125`, `freq_prop_125_1000`, `freq_prop_1000_4000`, `freq_prop_4000_8000`, `freq_prop_8000_20000`, `octave_prop_31_5_hz`, `octave_prop_63_0_hz`, `octave_prop_125_0_hz`, `octave_prop_250_0_hz`, `octave_prop_500_0_hz`, `octave_prop_1000_0_hz`, `octave_prop_2000_0_hz`, `octave_prop_4000_0_hz`, `octave_prop_8000_0_hz`, `wind_score`, `rural_natural_score`, `vehicle_score`, `urban_manmade_neutral_score`, `urban_manmade_positive_score`, `urban_manmade_negative_score`, `mechanisms_score`, `wind_prop`, `rural_natural_prop`, `vehicle_prop`, `urban_manmade_neutral_prop`, `urban_manmade_positive_prop`, `urban_manmade_negative_prop`, `mechanisms_prop`, `unidentify_prop`

**Exclude before PCA:** `category`: Nominal classifier text label (e.g. Vehicle, Wind); audit field, not a PCA input.; `unidentify_prop`: Unidentified-classification proportion; retain for classification review, not as a sound exposure.

**Retain 32 PCA inputs:** `ucm_SND_dBA`, `dominant_frequency_hz`, `spectral_centroid_hz`, `spectral_rolloff85_hz`, `freq_prop_20_125`, `freq_prop_125_1000`, `freq_prop_1000_4000`, `freq_prop_4000_8000`, `freq_prop_8000_20000`, `octave_prop_31_5_hz`, `octave_prop_63_0_hz`, `octave_prop_125_0_hz`, `octave_prop_250_0_hz`, `octave_prop_500_0_hz`, `octave_prop_1000_0_hz`, `octave_prop_2000_0_hz`, `octave_prop_4000_0_hz`, `octave_prop_8000_0_hz`, `wind_score`, `rural_natural_score`, `vehicle_score`, `urban_manmade_neutral_score`, `urban_manmade_positive_score`, `urban_manmade_negative_score`, `mechanisms_score`, `wind_prop`, `rural_natural_prop`, `vehicle_prop`, `urban_manmade_neutral_prop`, `urban_manmade_positive_prop`, `urban_manmade_negative_prop`, `mechanisms_prop`

**Process:** 11 participants, 44 bouts; 2111/2112 complete outdoor windows starting before 480 s. Center within participant-phase and divide by pooled within-bout SD. The 80% rule gives 9 PCs (81.155%); the current minimum-10 setting retains 10 (84.037%).

| PC | terms | cumulative terms | coefficient | Cumulative max VIF |
|---:|---|---|---:|---:|
| 1 | freq_prop_20_125 | freq_prop_20_125 | 0.338 | 1.378 |
| 2 | urban_manmade_positive_prop | freq_prop_20_125 + urban_manmade_positive_prop | 0.385 | 2.112 |
| 3 | vehicle_prop | freq_prop_20_125 + urban_manmade_positive_prop + vehicle_prop | 0.343 | 1.445 |
| 4 | wind_prop | freq_prop_20_125 + urban_manmade_positive_prop + vehicle_prop + wind_prop | 0.536 | 1.324 |
| 5 | freq_prop_8000_20000 | freq_prop_20_125 + urban_manmade_positive_prop + vehicle_prop + wind_prop + freq_prop_8000_20000 | 0.325 | 1.079 |
| 6 | mechanisms_prop | freq_prop_20_125 + urban_manmade_positive_prop + vehicle_prop + wind_prop + freq_prop_8000_20000 + mechanisms_prop | 0.520 | 1.257 |
| 7 | octave_prop_125_0_hz | freq_prop_20_125 + urban_manmade_positive_prop + vehicle_prop + wind_prop + freq_prop_8000_20000 + mechanisms_prop + octave_prop_125_0_hz | 0.551 | 1.044 |
| 8 | urban_manmade_neutral_prop | freq_prop_20_125 + urban_manmade_positive_prop + vehicle_prop + wind_prop + freq_prop_8000_20000 + mechanisms_prop + octave_prop_125_0_hz + urban_manmade_neutral_prop | 0.447 | 1.148 |
| 9 | freq_prop_4000_8000 | freq_prop_20_125 + urban_manmade_positive_prop + vehicle_prop + wind_prop + freq_prop_8000_20000 + mechanisms_prop + octave_prop_125_0_hz + urban_manmade_neutral_prop + freq_prop_4000_8000 | -0.422 | 1.176 |
| 10 | dominant_frequency_hz | freq_prop_20_125 + urban_manmade_positive_prop + vehicle_prop + wind_prop + freq_prop_8000_20000 + mechanisms_prop + octave_prop_125_0_hz + urban_manmade_neutral_prop + freq_prop_4000_8000 + dominant_frequency_hz | 0.730 | 1.138 |

**VIF decision:** No terms exceed VIF 5, these 10 terms can be added together to Eq1.

**Proposed Eq2:** Eq1 + `freq_prop_20_125` + `urban_manmade_positive_prop` + `vehicle_prop` + `wind_prop` + `freq_prop_8000_20000` + `mechanisms_prop` + `octave_prop_125_0_hz` + `urban_manmade_neutral_prop` + `freq_prop_4000_8000` + `dominant_frequency_hz`. **Maximum VIF: 3.092 .**

**References:** [Jolliffe & Cadima (2016)](https://doi.org/10.1098/rsta.2015.0202), [King & Jackson (1999)](https://doi.org/10.1002/%28SICI%291099-095X%28199901/02%2910%3A1%3C67%3A%3AAID-ENV336%3E3.0.CO%3B2-0), [Dormann et al. (2013)](https://doi.org/10.1111/j.1600-0587.2012.07348.x).

Input: C:\Users\pandya\Documents\Github\docker\Paper3_Final\output\merged_all_11participants_8min.csv

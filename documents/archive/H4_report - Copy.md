# H4 report

The Brussels study followed 11 participants through four eight-minute bouts each, with one post-bout questionnaire per bout. Analyses use bout-mean UTCI and energy-mean A-weighted sound. H4 is the 22 walking bouts, matching the European outdoor-walk sources. Cycling is not an H4 extension. Tram is not in H4. Nominal *p* < 0.05.

> **Old H4:** The presence of noise will amplify thermal discomfort.

> **Updated H4:** The presence of noise will increase thermal discomfort.

Old H4 is the product `dBA × UTCI` on comfort. Updated H4 is `Y ~ dBA_z + UTCI_z + (1 | participant)`: both measured exposures in one model. Support for updated H4 needs **both** coefficients on the same comfort vote, predicted sign, *p* < 0.05. Peng fits five separate one-predictor models, not this equation. Cureau predicts overall comfort from ratings, not from UTCI and dBA. Coupled votes are context, not updated H4. The European review came after the product tests; keep that labelled as a follow-up.

Outside Europe the published test is often a product or crossed arms. In Europe it is mostly additive models, separate blocks, or vote coupling. No screened review states that amplification exists in Asia and not in Europe. No screened European outdoor walking or cycling study estimated `dBA × UTCI` on discomfort.

Local columns: `UTCI` = bout-mean `ucm_UTCI`; `dBA` = energy-mean `ucm_SND_dBA`; `Ta` = bout-mean `ucm_AIR_temp`; `PET` = bout-mean `ucm_PET`; `overall_comfort` = `questionnaire_current_comfort_1_7`; `prs_score` = `questionnaire_prs11_total_mean_1_5`. Subscript z is a z-score.

---

**How to read the formula citations.** The numbered formulas are Brussels analyses. Highlighted pages document the source method or the relevant equation where printed. A highlight does not verify an exact formula when the citation says the specification is unverified. PDF page numbers are counted from the first page of the highlighted copy.

## 1. Old approach — old hypothesis (outside Europe)

Product, crossed arms, or sound inside a thermal stratum. Almost all China, Iran, India. European papers are only in §2. Lab/occupational arms are not available, so those rows use a median-split or continuous product on the same 22 walking bouts.

Place is the study city and its Köppen–Geiger class (Beck et al., 2018). Chamber rows use the host-city class, not the chamber setpoint. Test: source *p*<0.05 procedure first, then local *k*/*n* on the ported product. An *F* and its *p* from the same ANOVA are one test. Rows that list two procedures ran two families in the source, not *p* then a second confirmatory *F* on the same claim.

**1. Jin, Jin & Kang 2020 (0/3) {Source formula not verified in the available local PDF. See the [UCL accepted manuscript for DOI 10.1016/j.buildenv.2019.106517](https://discovery.ucl.ac.uk/id/eprint/10087342/1/Yumeng%20Jin2019_BAE_Whiterose.pdf).}**

Harbin (Köppen–Geiger Dwa).

**Significant**

None.

**Not significant**

- **1.1** `thermal_comfort ~ UTCI_z * dBA_z + (1 | participant)` (p = 0.373275)
- **1.2** `acoustic_comfort ~ UTCI_z * dBA_z + (1 | participant)` (p = 0.580771)
- **1.3** `overall_comfort ~ UTCI_z * dBA_z + (1 | participant)` (p = 0.580494)

**2. Chen et al. 2023 (0/3) {PDF pp. 7-8, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/02 Chen2023 - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/02 Chen2023 - highlighted.pdf). ANOVA passages verified. The Brussels continuous interaction is a local adaptation.}**

Fuzhou (Köppen–Geiger Cfa).

**Significant**

None.

**Not significant**

- **2.1** `thermal_comfort ~ UTCI_z * dBA_z + (1 | participant)` (p = 0.373275)
- **2.2** `acoustic_comfort ~ UTCI_z * dBA_z + (1 | participant)` (p = 0.580771)
- **2.3** `overall_comfort ~ UTCI_z * dBA_z + (1 | participant)` (p = 0.580494)

**3. Li, Li & Wang 2025 (0/3) {Source formula not verified in the available PDF.}**

Beijing (Köppen–Geiger Dwa).

**Significant**

None.

**Not significant**

- **3.1** `thermal_comfort ~ UTCI_z * dBA_z + (1 | participant)` (p = 0.373275)
- **3.2** `acoustic_comfort ~ UTCI_z * dBA_z + (1 | participant)` (p = 0.580771)
- **3.3** `overall_comfort ~ UTCI_z * dBA_z + (1 | participant)` (p = 0.580494)

**4. Mohammadzadeh et al. 2023 (0/1) {PDF pp. 5, 10, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/04 Mohammadzadeh2023 - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/04 Mohammadzadeh2023 - highlighted.pdf). Source passages describe correlations, weighted regression and one-way ANOVA. The cited UTCI-by-LAeq product is unverified.}**

Tabriz (Köppen–Geiger BSk).

**Significant**

None.

**Not significant**

- **4.1** `acoustic_comfort ~ UTCI_z * dBA_z + (1 | participant)` (p = 0.580771)

**5. Gao & Zhu 2025 (0/1) {PDF pp. 5, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/05 GaoZhu2025 - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/05 GaoZhu2025 - highlighted.pdf). Two-way ANOVA method verified. The Brussels continuous model is a local adaptation.}**

Shenzhen (Köppen–Geiger Cwa).

**Significant**

None.

**Not significant**

- **5.1** `prs_score ~ UTCI_z * dBA_z + (1 | participant)` (p = 0.207144)

**6. Wu et al. 2025 (0/1) {PDF pp. 5, 10-11, 13, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/06 Wu2025 - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/06 Wu2025 - highlighted.pdf). Source UTCI and LAeq ANOVA and interaction verified. The Brussels continuous model differs from the source analysis.}**

Zhangjiakou (Köppen–Geiger BSk).

**Significant**

None.

**Not significant**

- **6.1** `overall_comfort ~ UTCI_z * dBA_z + (1 | participant)` (p = 0.580494)

**7. Xu et al. 2026 (0/1) {PDF pp. 9, 17, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/07 Xu2026 - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/07 Xu2026 - highlighted.pdf). Two-way ANOVA verified. The Brussels continuous interaction is a local adaptation.}**

Xi’an (Köppen–Geiger Cwa).

**Significant**

None.

**Not significant**

- **7.1** `thermal_comfort ~ Ta_z * dBA_z + (1 | participant)` (p = 0.670917)

**8. Zhen et al. 2025 (0/1) {PDF pp. 9, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/08 Zhen2025 - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/08 Zhen2025 - highlighted.pdf). The highlighted source passage reports Spearman correlation. The quoted product is unverified.}**

Datang, Tangshan (Köppen–Geiger Dwa).

**Significant**

None.

**Not significant**

- **8.1** `thermal_comfort ~ UTCI_z * dBA_z + (1 | participant)` (p = 0.373275)

**9. Tang et al. 2026 (0/3) {PDF pp. 5, 11, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/09 Tang2026 - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/09 Tang2026 - highlighted.pdf). Highlighted source comparisons use one-way ANOVA or Kruskal–Wallis. The Brussels PET-by-dBA product is a local adaptation.}**

Xi’an (Köppen–Geiger Cwa).

**Significant**

None.

**Not significant**

- **9.1** `heart_rate ~ dBA_z * pet_z + (1 | participant)` (p = 0.100161)
- **9.2** `sdnn ~ dBA_z * pet_z + (1 | participant)` (p = 0.343122)
- **9.3** `rmssd ~ dBA_z * pet_z + (1 | participant)` (p = 0.431614)

**10. Yousefinezhad et al. 2026 (0/3) {PDF pp. 5-6, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/10 Yousefinezhad2026 - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/10 Yousefinezhad2026 - highlighted.pdf). Repeated-measures ANOVA verified. The Brussels median-split interaction is a local adaptation.}**

Sari lab (Köppen–Geiger Cfa).

**Significant**

None.

**Not significant**

- **10.1** `thermal_comfort ~ I(UTCI >= median) * I(dBA >= median) + (1 | participant)` (p = 0.243683)
- **10.2** `acoustic_comfort ~ I(UTCI >= median) * I(dBA >= median) + (1 | participant)` (p = 0.8171)
- **10.3** `overall_comfort ~ I(UTCI >= median) * I(dBA >= median) + (1 | participant)` (p = 0.654392)

**11. Bhattacharya et al. 1991 (1/3) {Source formula unverified. Publisher PDF: https://www.jstage.jst.go.jp/article/indhealth1963/29/4/29_4_129/_pdf}**

Ahmedabad (Köppen–Geiger BSh).

**Significant**

- **11.3** `heart_rate ~ Ta_z * dBA_z + (1 | participant)` (p = 0.0402175)

**Not significant**

- **11.1** `thermal_comfort ~ Ta_z * dBA_z + (1 | participant)` (p = 0.670917)
- **11.2** `acoustic_comfort ~ Ta_z * dBA_z + (1 | participant)` (p = 0.370285)

**12. Abbasi 2020 (1/2) {Source formula not verified in the available PDF.}**

Hamadan lab (Köppen–Geiger Dsa).

**Significant**

- **12.2** `heart_rate ~ Ta_z * dBA_z + (1 | participant)` (p = 0.0402175)

**Not significant**

- **12.1** `thermal_comfort ~ Ta_z * dBA_z + (1 | participant)` (p = 0.670917)

**13. Tohidi 2025 (1/1) {PDF pp. 3, 5, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/13 Tohidi2025 - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/13 Tohidi2025 - highlighted.pdf). Three-way ANOVA verified. The Brussels two-predictor interaction is a local adaptation.}**

Ilam lab (Köppen–Geiger Csa).

**Significant**

- **13.1** `heart_rate ~ Ta_z * dBA_z + (1 | participant)` (p = 0.0402175)

**Not significant**

None.

**14. Dehghan 2017 (1/3) {Source formula not verified in the available PDF.}**

Isfahan lab (Köppen–Geiger BWk).

**Significant**

- **14.3** `heart_rate ~ I(UTCI >= median) * I(dBA >= median) + (1 | participant)` (p = 0.0029743)

**Not significant**

- **14.1** `thermal_comfort ~ I(UTCI >= median) * I(dBA >= median) + (1 | participant)` (p = 0.243683)
- **14.2** `acoustic_comfort ~ I(UTCI >= median) * I(dBA >= median) + (1 | participant)` (p = 0.8171)

**15. Molaeifar 2020 (1/3) {PDF pp. 4-5, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/15 Molaeifar2020 - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/15 Molaeifar2020 - highlighted.pdf). Source mixed model, paired t-test and ANCOVA passages verified. The quoted product is unverified.}**

Shiraz lab (Köppen–Geiger BSk).

**Significant**

- **15.3** `heart_rate ~ Ta_z * dBA_z + (1 | participant)` (p = 0.0402175)

**Not significant**

- **15.1** `thermal_comfort ~ Ta_z * dBA_z + (1 | participant)` (p = 0.670917)
- **15.2** `acoustic_comfort ~ Ta_z * dBA_z + (1 | participant)` (p = 0.370285)

**16. Wang, Li & Shi 2026 (0/3) {No matching source PDF located in the checked folders. Source formula unverified.}**

Changsha (Köppen–Geiger Cfa).

**Significant**

None.

**Not significant**

- **16.1** `thermal_comfort ~ UTCI_z * urban + (1 | participant)` (p = 0.466815)
- **16.2** `acoustic_comfort ~ UTCI_z * urban + (1 | participant)` (p = 0.75798)
- **16.3** `overall_comfort ~ UTCI_z * urban + (1 | participant)` (p = 0.610813)

35 tests. Five *p* < 0.05, all heart rate. Comfort products 0. Jin, Wu and Xu splits were empty or rank-deficient, so those rows used the continuous product. Bhattacharya, Abbasi, Tohidi and Molaeifar share `heart_rate ~ Ta_z * dBA_z` +4.80 (*p* = 0.040). Dehghan median-split heart rate +23.3 (*p* = 0.0030). Route co-exposure remains. **Old H4 not recovered here.** That does not falsify the source sites.

---

## 2. New approach — updated hypothesis (Europe)

Walk is the published design for Grapas, Rodrigues, Peng, Grapas Rome and Baquero. Ports use walking bouts only. Chiucchiù is chamber (C0 → green, C1 → urban). Cureau Mann–Whitney → paired Wilcoxon. Rodrigues keeps *p* < 0.05 and |β| > 0.1. Baquero’s published DV is stay counts; locally overall comfort. Newcastle 2020 and Zouad & Baron 2026 are not ported.

Place is the study city and its Köppen–Geiger class (Beck et al., 2018). Chiucchiù is a Perugia chamber; the class is the host city. Test: source *p*<0.05 procedure first, then local *k*/*n*. Several sources ran more than one family (not *p* then a second *F* on the same model).

**1. Grapas 2026 (0/4) {PDF pp. 5, 10, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/17 Urban chronotypes - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/17 Urban chronotypes - highlighted.pdf). Source timing methods verified. The Brussels delay regression is a local adaptation.}**

Brussels (Köppen–Geiger Cfb).

**Significant**

None.

**Not significant**

- **1.1** [Walking] `delay_hr_after_dba ~ dBA_z + (1 | participant)` (p = 0.274544)
- **1.2** [Walking] `delay_eda_after_dba ~ dBA_z + (1 | participant)` (p = 0.22742)
- **1.3** [Walking] `delay_hr_after_utci ~ UTCI_z + (1 | participant)` (p = 0.240135)
- **1.4** [Walking] `delay_eda_after_utci ~ UTCI_z + (1 | participant)` (p = 0.516382)

**2. Chiucchiù 2026 (4/10) {PDF pp. 4, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/18 Chiucchiu2026 - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/18 Chiucchiu2026 - highlighted.pdf). Source paired t-test and Spearman methods verified. The green–urban mapping is a local adaptation.}**

Perugia (Köppen–Geiger Csa).

**Significant**

- **2.3** [Walking] `Paired t-test(skin_temp_urban - skin_temp_green)` (p = 0.00657572)
- **2.4** [Walking] `Paired t-test(thermal_comfort_urban - thermal_comfort_green)` (p = 0.00974521)
- **2.6** [Walking] `Spearman(thermal_comfort, acoustic_comfort)` (p = 0.0138359)
- **2.8** [Walking] `Spearman(acoustic_comfort, pleasantness)` (p = 0.0343164)

**Not significant**

- **2.1** [Walking] `Paired t-test(eda_tonic_urban - eda_tonic_green)` (p = 0.0941428)
- **2.2** [Walking] `Paired t-test(heart_rate_urban - heart_rate_green)` (p = 0.531936)
- **2.5** [Walking] `Paired t-test(acoustic_comfort_urban - acoustic_comfort_green)` (p = 0.0948469)
- **2.7** [Walking] `Spearman(thermal_comfort, pleasantness)` (p = 0.139293)
- **2.9** [Walking] `Spearman(thermal_comfort, overall_comfort)` (p = 0.0619364)
- **2.10** [Walking] `Spearman(acoustic_comfort, overall_comfort)` (p = 0.213348)

**3. Cureau 2022 (4/10) {PDF pp. 5, 8, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/19 Cureau2022 - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/19 Cureau2022 - highlighted.pdf). Source Mann–Whitney, Fisher and multinomial methods verified. Brussels uses paired Wilcoxon.}**

Perugia parks (Köppen–Geiger Csa).

**Significant**

- **3.5** [Walking] `Wilcoxon signed-rank test(dba_urban - dba_green)` (p = 0.000976562)
- **3.6** [Walking] `Wilcoxon signed-rank test(air_temp_urban - air_temp_green)` (p = 0.000976562)
- **3.7** [Walking] `Wilcoxon signed-rank test(utci_urban - utci_green)` (p = 0.000976562)
- **3.8** [Walking] `Wilcoxon signed-rank test(thermal_comfort_urban - thermal_comfort_green)` (p = 0.015625)

**Not significant**

- **3.1** [WalkG] `Fisher exact test(thermal_comfort x acoustic_comfort)` (p = 0.52381)
- **3.2** [WalkU] `Fisher exact test(thermal_comfort x acoustic_comfort)` (p = 0.0606061)
- **3.3** [WalkG] `Fisher exact test(overall_comfort x acoustic_comfort)` (p = 0.792208)
- **3.4** [WalkU] `Fisher exact test(overall_comfort x acoustic_comfort)` (p = 0.788052)
- **3.9** [Walking] `Wilcoxon signed-rank test(acoustic_comfort_urban - acoustic_comfort_green)` (p = 0.15625)

**p value unavailable**

- **3.10** [Walking] `overall_comfort ~ thermal_comfort + visual_comfort + acoustic_comfort (multinomial likelihood-ratio test)` (p unavailable)

**4. Rodrigues 2026 (3/20) {PDF pp. 5, 7, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/20 Rodrigues2026 - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/20 Rodrigues2026 - highlighted.pdf). Source participant-intercept models verified. The author code specifies maximum and mean temperature. The Brussels fits use local outcome summaries and t-reference inference.}**

Lisbon (Köppen–Geiger Csa).

**Significant**

- **4.5** [Walking] `skin_temp ~ Noise_max_z + Noise_sd_z + (1 | participant)` (Noise_max_z p = 0.000172943)
- **4.15** [Walking] `skin_temp ~ Temp_max_z + Temp_mean_z + (1 | participant)` (Temp_max_z p = 0.00429996)
- **4.16** [Walking] `skin_temp ~ Temp_max_z + Temp_mean_z + (1 | participant)` (Temp_mean_z p = 0.0449453)

**Not significant**

- **4.1** [Walking] `heart_rate ~ Noise_max_z + Noise_sd_z + (1 | participant)` (Noise_max_z p = 0.919556)
- **4.2** [Walking] `heart_rate ~ Noise_max_z + Noise_sd_z + (1 | participant)` (Noise_sd_z p = 0.151427)
- **4.3** [Walking] `eda_tonic ~ Noise_max_z + Noise_sd_z + (1 | participant)` (Noise_max_z p = 0.292732)
- **4.4** [Walking] `eda_tonic ~ Noise_max_z + Noise_sd_z + (1 | participant)` (Noise_sd_z p = 0.632694)
- **4.6** [Walking] `skin_temp ~ Noise_max_z + Noise_sd_z + (1 | participant)` (Noise_sd_z p = 0.476387)
- **4.7** [Walking] `sdnn ~ Noise_max_z + Noise_sd_z + (1 | participant)` (Noise_max_z p = 0.966878)
- **4.8** [Walking] `sdnn ~ Noise_max_z + Noise_sd_z + (1 | participant)` (Noise_sd_z p = 0.204259)
- **4.9** [Walking] `rmssd ~ Noise_max_z + Noise_sd_z + (1 | participant)` (Noise_max_z p = 0.200606)
- **4.10** [Walking] `rmssd ~ Noise_max_z + Noise_sd_z + (1 | participant)` (Noise_sd_z p = 0.112394)
- **4.11** [Walking] `heart_rate ~ Temp_max_z + Temp_mean_z + (1 | participant)` (Temp_max_z p = 0.679077)
- **4.12** [Walking] `heart_rate ~ Temp_max_z + Temp_mean_z + (1 | participant)` (Temp_mean_z p = 0.616929)
- **4.13** [Walking] `eda_tonic ~ Temp_max_z + Temp_mean_z + (1 | participant)` (Temp_max_z p = 0.776442)
- **4.14** [Walking] `eda_tonic ~ Temp_max_z + Temp_mean_z + (1 | participant)` (Temp_mean_z p = 0.91103)
- **4.17** [Walking] `sdnn ~ Temp_max_z + Temp_mean_z + (1 | participant)` (Temp_max_z p = 0.0529427)
- **4.18** [Walking] `sdnn ~ Temp_max_z + Temp_mean_z + (1 | participant)` (Temp_mean_z p = 0.0811415)
- **4.19** [Walking] `rmssd ~ Temp_max_z + Temp_mean_z + (1 | participant)` (Temp_max_z p = 0.719581)
- **4.20** [Walking] `rmssd ~ Temp_max_z + Temp_mean_z + (1 | participant)` (Temp_mean_z p = 0.684634)

**5. Peng 2025 (4/5) {PDF pp. 4, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/21 Peng2025 - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/21 Peng2025 - highlighted.pdf). Conference abstract confirms the variables and five mixed-model hypotheses. It does not print the five exact equations.}**

Schiphol (Köppen–Geiger Cfb).

**Significant**

- **5.1** [Walking] `thermal_comfort ~ dBA_z + (1 | participant)` (p = 0.00367539)
- **5.2** [Walking] `thermal_comfort ~ acoustic_comfort + (1 | participant)` (p = 0.00211915)
- **5.4** [Walking] `acoustic_comfort ~ dBA_z + (1 | participant)` (p = 0.0205604)
- **5.5** [Walking] `acoustic_comfort ~ thermal_comfort + (1 | participant)` (p = 0.00211765)

**Not significant**

- **5.3** [Walking] `acoustic_comfort ~ UTCI_z + (1 | participant)` (p = 0.133571)

**6. Grapas Rome 2026 (4/16) {PDF pp. 5-6, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/22 Rome feel - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/22 Rome feel - highlighted.pdf). Pearson, Spearman and Richards model passages verified. The Brussels linear model is a local adaptation.}**

Rome (Köppen–Geiger Csa).

**Significant**

- **6.4** [Walking] `Pearson(heart_rate, oct_low)` (p = 0.0148663)
- **6.5** [Walking] `Pearson(heart_rate, oct_mid)` (p = 0.0246106)
- **6.6** [Walking] `Spearman(heart_rate, oct_high)` (p = 0.00376064)
- **6.7** [Walking] `Spearman(eda_tonic, utci)` (p = 0.0133392)

**Not significant**

- **6.1** [Walking] `Pearson(heart_rate, utci)` (p = 0.693157)
- **6.2** [Walking] `Spearman(heart_rate, dba)` (p = 0.824241)
- **6.3** [Walking] `Spearman(heart_rate, pm25)` (p = 0.205851)
- **6.8** [Walking] `Spearman(eda_tonic, dba)` (p = 0.161928)
- **6.9** [Walking] `Spearman(eda_tonic, pm25)` (p = 0.464961)
- **6.10** [Walking] `Spearman(eda_tonic, oct_low)` (p = 0.962207)
- **6.11** [Walking] `Spearman(eda_tonic, oct_mid)` (p = 0.962207)
- **6.12** [Walking] `Spearman(eda_tonic, oct_high)` (p = 0.331137)
- **6.13** [Walking] `heart_rate ~ UTCI_z + dBA_z + (1 | participant)` (utci_z p = 0.957896)
- **6.14** [Walking] `heart_rate ~ UTCI_z + dBA_z + (1 | participant)` (dba_z p = 0.670724)
- **6.15** [Walking] `eda_tonic ~ UTCI_z + dBA_z + (1 | participant)` (utci_z p = 0.108806)
- **6.16** [Walking] `eda_tonic ~ UTCI_z + dBA_z + (1 | participant)` (dba_z p = 0.41673)

**7. Baquero 2019 (1/10) {PDF pp. 6-7, 10, [C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/23 Madrid environmental - highlighted.pdf](C:/Users/sanga/Desktop/Pranav Paper3_Final/Experiment papers/H4 highlighted sources/23 Madrid environmental - highlighted.pdf). Source correlations and multiple regression passages verified. The source outcome is stay counts. Brussels uses overall comfort.}**

Madrid (Köppen–Geiger BSk).

**Significant**

- **7.6** [Walking] `Spearman(overall_comfort, acoustic_comfort)` (p = 0.0357234)

**Not significant**

- **7.1** [Walking] `Pearson(overall_comfort, air_temp)` (p = 0.974082)
- **7.2** [Walking] `Pearson(overall_comfort, air_rh)` (p = 0.441219)
- **7.3** [Walking] `Pearson(overall_comfort, dba)` (p = 0.748693)
- **7.4** [Walking] `Pearson(overall_comfort, wind_aws)` (p = 0.534976)
- **7.5** [Walking] `Spearman(overall_comfort, thermal_comfort)` (p = 0.0599627)
- **7.7** [Walking] `overall_comfort ~ air_temp_z + air_rh_z + dba_z + wind_aws_z + (1 | participant)` (air_temp_z p = 0.695923)
- **7.8** [Walking] `overall_comfort ~ air_temp_z + air_rh_z + dba_z + wind_aws_z + (1 | participant)` (air_rh_z p = 0.850907)
- **7.9** [Walking] `overall_comfort ~ air_temp_z + air_rh_z + dba_z + wind_aws_z + (1 | participant)` (dba_z p = 0.186518)
- **7.10** [Walking] `overall_comfort ~ air_temp_z + air_rh_z + dba_z + wind_aws_z + (1 | participant)` (wind_z p = 0.257464)

75 walking adaptations; not the old product. Grapas 0/4. Chiucchiù 4/10: urban−green skin temperature and thermal comfort, Spearman thermal~acoustic and acoustic~pleasantness. Cureau 4/10: three are H1 exposure contrasts plus thermal comfort. Rodrigues 3/20, all for skin temperature (Noise_max and both temperature terms). Peng 4/5; the miss is `acoustic_comfort ~ UTCI`. Grapas Rome 4/16 is HR octave bands and EDA~UTCI. Baquero 1/10 is Spearman overall~acoustic.

**Brussels test of updated H4**

1. Context, not the hypothesis: Spearman thermal_comfort ~ acoustic_comfort on 11 person-means; `overall_comfort ~ thermal_comfort + acoustic_comfort + (1 | participant)`.
2. The hypothesis: `Y ~ dBA_z + UTCI_z + (1 | participant)` on thermal, acoustic and overall comfort.

| Scope | Outcome | dBA β (*p*) | UTCI β (*p*) | Both exposures? |
| --- | --- | ---: | ---: | --- |
| Walk | thermal_comfort | **−0.564 (0.031)** | −0.049 (0.838) | no |
| Walk | acoustic_comfort | −0.564 (0.081) | −0.012 (0.968) | no |
| Walk | overall_comfort | −0.367 (0.245) | 0.133 (0.699) | no |

| Scope | Test | Estimate | *p* |
| --- | --- | ---: | ---: |
| Walk | Spearman thermal_comfort ~ acoustic_comfort | **ρ = 0.713** | **0.014** |
| Walk | overall ~ thermal vote | 0.154 | 0.491 |
| Walk | overall ~ acoustic vote | 0.376 | 0.088 |

**Updated H4 not supported.** dBA is associated with thermal comfort on walking. UTCI on that same vote, after dBA, is not.

---

## 3. Conclusion

Sound is not a null. Old H4 is not recovered. Updated H4 is not supported, because UTCI does not show on the same comfort vote once dBA is in the model. Coupled ratings are in the table; they do not save the hypothesis.

Cureau et al. (2022) https://doi.org/10.1007/s00484-022-02338-7 modelled overall comfort from ratings. Peng et al. (2025) https://doi.org/10.5194/icuc12-816 fitted separate TSV/ASV models; heat → ASV was the miss. Neither is the Brussels two-exposure equation.

Walk medians of participant medians: UTCI 23.8 °C green vs 32.0 °C urban; sound 61.5 vs 67.8 dB(A). Heat and sound rise with the same route. Eleven people, two eight-minute walking bouts, one rating per bout. That limits how far heat and sound can be pulled apart. It does not prove Belgian weather cannot amplify. More work needs a larger sample and a design that does not tie heat and sound to the same route.

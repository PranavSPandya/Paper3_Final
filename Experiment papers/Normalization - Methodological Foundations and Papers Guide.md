# Normalization in Psychophysiology: Foundational Benchmark Papers

This directory contains the foundational methodological literature justifying the baseline adjustment and normalization protocols in Paper 3.

---

## 1. Method 1: Baseline as a Covariate (ANCOVA / Mixed Model Covariate)

### Foundational Paper:
* **File:** [`Normalization - Vickers 2001 - Analysing controlled trials with baseline and follow up measurements.md`](file:///C:/Users/pandya/Documents/Github/docker/Paper3_Github/Experiment%20papers/Normalization%20-%20Vickers%202001%20-%20Analysing%20controlled%20trials%20with%20baseline%20and%20follow%20up%20measurements.md)
* **Citation:** Vickers, A. J., & Altman, D. G. (2001). Statistics notes: Analysing controlled trials with baseline and follow up measurements. *BMJ (British Medical Journal)*, 323(7321), 1123–1124. DOI: [10.1136/bmj.323.7321.1123](https://doi.org/10.1136/bmj.323.7321.1123).
* **Core Principles:**
  1. **Flaws of Change Scores ($Y - \text{Baseline}$):** Subtracting baseline from outcome does *not* control for baseline imbalances because of regression to the mean ($r_{\text{baseline, change}} < 0$).
  2. **Variance Inflation:** When baseline and follow-up correlations are imperfect, simple change scores inject baseline measurement noise directly into each outcome score.
  3. **The ANCOVA / Covariate Solution:** Including the baseline measurement as an unconstrained covariate ($Y_{ij} \sim \text{Condition} + a \cdot \text{Baseline}_i + (1|\text{ID})$) provides unbiased treatment estimates, protects against baseline imbalance, and possesses demonstrably higher statistical power than change scores or percentage change.

---

## 2. Method 5: Within-Participant Range Correction and Z-Score Standardization

### Foundational Papers:
1. **Lykken & Venables (1971):**
   * **Citation:** Lykken, D. T., & Venables, P. H. (1971). Direct measurement of skin conductance: A proposal for standardization. *Psychophysiology*, 8(5), 656–672. DOI: [10.1111/j.1469-8986.1971.tb00501.x](https://doi.org/10.1111/j.1469-8986.1971.tb00501.x).
   * **Core Contribution:** Introduced the foundational principles of within-subject range-correction in electrodermal psychophysiology. Demonstrated that raw skin conductance levels are heavily driven by anatomical peripheral factors (skin thickness, sweat gland density) unrelated to psychological state. Normalizing to an individual's personal range removes between-subject error variance without mathematical distortion.

2. **Bush, Hess, & Wolford (1993):**
   * **Citation:** Bush, L. K., Hess, U., & Wolford, G. (1993). Transformations for within-subject designs: A Monte Carlo investigation. *Psychological Bulletin*, 113(3), 566–579. DOI: [10.1037/0033-2909.113.3.566](https://doi.org/10.1037/0033-2909.113.3.566).
   * **Core Contribution:** Conducted extensive Monte Carlo simulations on psychophysiological data demonstrating that **within-subject Z-score standardization** ($z_{ij} = (Y_{ij} - \mu_i) / \sigma_i$) produces the greatest increase in statistical power for repeated-measures designs, outperforming raw subtraction and percentage change while remaining robust against individual differences in physiological reactivity.

3. **Boucsein (2012):**
   * **Citation:** Boucsein, W. (2012). *Electrodermal Activity* (2nd ed.). Springer Science & Business Media. DOI: [10.1007/978-1-4614-1126-0](https://doi.org/10.1007/978-1-4614-1126-0).
   * **Core Recommendation:** The definitive psychophysiological handbook. Section on data transformation establishes that crude baseline subtraction in ambulatory environments violates the Law of Initial Values, and recommends within-subject standardization or baseline covariance.

# Lab Problem Statement 6: Statistical Analysis of Palmer Penguins
**Author:** Dhruv D. Bhrasadiya (23102C0075)  
**Date:** September 12, 2026

## Executive Summary
This report presents a thorough statistical investigation of the physical metrics of Palmer Archipelago penguins based on the *Palmer Penguins* dataset. The objectives are to execute descriptive statistical profiling, evaluate biological sex variations via parametric testing, perform variance multi-comparisons across species groups, validate underlying statistical assumptions, and quantify demographic interaction criteria.

---

## 1. Descriptive Statistical Analysis

### 1.1 Overall Body Mass Descriptive Statistics
The aggregate distribution of penguin body mass (in grams) across all cleaned records ($N = 333$) is summarized below:

| Metric | Value |
| :--- | :--- |
| **Mean** | 4,207.06 g |
| **Median** | 4,050.00 g |
| **Minimum** | 2,700.00 g |
| **Maximum** | 6,300.00 g |
| **Variance** | 648,372.13 g² |
| **Standard Deviation (SD)** | 805.22 g |
| **First Quartile (Q1)** | 3,550.00 g |
| **Third Quartile (Q3)** | 4,775.00 g |
| **Interquartile Range (IQR)** | 1,225.00 g |
| **Skewness** | 0.468 |
| **Kurtosis** | -0.754 |

* **Interpretation**: The overall mean weight is **4,207.06g** with a standard deviation of **805.22g**. A positive skewness value (**0.468**) indicates a minor right tail shift, while the negative excess kurtosis (**-0.754**) signifies a slightly flatter platykurtic layout compared to a standard normal curve.

### 1.2 Species-Wise Descriptive Statistics
The statistical matrices split by specific population classes are detailed below:

| Species | Mean (g) | Median (g) | Min (g) | Max (g) | SD (g) | IQR (g) | Skewness | Kurtosis |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Adelie** | 3,706.16 | 3,700.00 | 2,850.00 | 4,775.00 | 458.62 | 637.50 | 0.274 | -0.564 |
| **Chinstrap** | 3,733.09 | 3,700.00 | 2,700.00 | 4,800.00 | 384.34 | 462.50 | 0.237 | -0.462 |
| **Gentoo** | 5,092.44 | 5,050.00 | 3,950.00 | 6,300.00 | 501.48 | 800.00 | 0.044 | -0.758 |

* **Interpretation**: Substantial mass differences are visible between categories. **Gentoo** penguins stand out as significantly heavier ($\mu \approx 5,092.44\text{g}$) relative to **Adelie** ($\mu \approx 3,706.16\text{g}$) and **Chinstrap** ($\mu \approx 3,733.09\text{g}$) colonies.

---

## 2. Hypothesis Testing: Male vs. Female Body Mass

We seek to evaluate whether biological sex maps to a substantial divergence in body weight values.

* **Null Hypothesis ($H_0$):** $\mu_{\text{male}} = \mu_{\text{female}}$ (The mean body mass is equal across both sexes).
* **Alternative Hypothesis ($H_1$):** $\mu_{\text{male}} \neq \mu_{\text{female}}$ (The mean body mass differs significantly across sexes).

### 2.1 Normality Assessment
* **Shapiro-Wilk Test for Normality by Sex:**
  * **Female:** $W = 0.919, p < 0.001$
  * **Male:** $W = 0.925, p < 0.001$

* **Interpretation:** The Shapiro-Wilk test strongly rejects the assumption of normality for both groups ($p < 0.001$). Quantile-Quantile (QQ) plots confirm slight deviations at the tails. However, given the large sample size available ($N = 333$), the Central Limit Theorem allows us to safely employ parametric t-tests as they remain highly robust under large-sample scenarios.

### 2.2 Independent Two-Sample T-Test & Effect Size
Since normality assumptions are modified by sample boundaries, a Welch Independent Two-Sample t-test (not assuming equal variances) was conducted.

* **t-statistic:** -8.5545
* **Degrees of Freedom (df):** 323.9
* **p-value:** $4.794 \times 10^{-16}$ (highly significant)
* **95% Confidence Interval for Difference:** [-840.58, -526.25] grams
* **Mean Estimates:** Female = 3,862.27g, Male = 4,545.69g
* **Cohen's d Effect Size:** 0.9362

### 2.3 Interpretation and Conclusions
The difference between male and female penguins is highly significant ($p < 0.05$). We reject $H_0$ in favor of $H_1$. Male penguins are significantly heavier than female penguins, with an estimated difference of roughly **683.41g**. Cohen's d value of **0.936** indicates a very **large effect size**, highlighting structural phenotypic dimorphism based on sex.

---

## 3. One-Way ANOVA: Body Mass Across Species

We evaluate whether structural variations in core mass metrics track distinct phylogenetic paths across species boundaries.

### 3.1 Assumption Verifications
* **Shapiro-Wilk Test for Normality by Species:**
  * **Adelie:** $W = 0.981, p = 0.0423$ (Significant deviation)
  * **Chinstrap:** $W = 0.984, p = 0.5610$ (Normal)
  * **Gentoo:** $W = 0.986, p = 0.2610$ (Normal)
* **Levene's Test for Homogeneity of Variance:** $F(2, 330) = 5.135, p = 0.0064$

* **Interpretation:** While Chinstrap and Gentoo subsets exhibit standard Gaussian consistency ($p > 0.05$), the Adelie strain slightly deviates ($p = 0.042$). Concurrently, Levene’s test rejects equal variance across species ($p < 0.01$). Thus, standard classic ANOVA baseline configurations are partially violated, making parallel non-parametric options necessary to cross-validate conclusions.

### 3.2 One-Way ANOVA Table

| Factor | Df | Sum Sq | Mean Sq | F-value | Pr(>F) |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Species** | 2 | 145,190,219 | 72,595,110 | 341.9 | < 2e-16 *** |
| **Residuals** | 330 | 70,069,447 | 212,332 | | |

Because the Omnibus F-test is highly significant ($F = 341.9, p < 0.001$), we proceed with Tukey’s Honest Significant Difference (HSD) multi-comparison checks:

### 3.3 Tukey HSD Post-Hoc Pairwise Comparisons

| Comparison Pair | Difference (g) | Lower 95% CL | Upper 95% CL | p adj |
| :--- | :---: | :---: | :---: | :---: |
| **Chinstrap - Adelie** | 26.92 | -132.35 | 186.20 | 0.9164 |
| **Gentoo - Adelie** | 1,386.27 | 1,252.29 | 1,520.26 | 0.0000 *** |
| **Gentoo - Chinstrap** | 1,359.35 | 1,194.43 | 1,524.27 | 0.0000 *** |

* **Interpretation**: Gentoo penguins are significantly heavier than both other species ($\Delta > 1350\text{g}, p < 0.001$). However, the mass difference between Chinstrap and Adelie is small and not statistically significant ($p = 0.916$).

---

## 4. Non-Parametric Analysis: Kruskal-Wallis Test

To account for the heteroscedasticity flag raised by Levene's Test, a non-parametric Kruskal-Wallis test was carried out.

* **Kruskal-Wallis Chi-Squared:** 212.09
* **Degrees of Freedom:** 2
* **p-value:** $< 2.2 \times 10^{-16}$

### 4.1 Comparative Discussion
Both parametric One-Way ANOVA ($p < 0.001$) and non-parametric Kruskal-Wallis implementations ($p < 0.001$) return strong statistical significance. This alignment demonstrates that variance heteroscedasticity did not alter the core finding: **Gentoo penguins have a distinct, significantly larger body mass profile compared to the other two species.**

---

## 5. Two-Way ANOVA: Interaction Effects (Species x Sex)

We model structural variations in penguin weights using both biological factors simultaneously.

| Factor | Df | Sum Sq | Mean Sq | F-value | Pr(>F) |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Species** | 2 | 145,190,219 | 72,595,110 | 758.358 | < 2e-16 *** |
| **Sex** | 1 | 37,090,262 | 37,090,262 | 387.460 | < 2e-16 *** |
| **Species : Sex** | 2 | 1,676,557 | 838,278 | 8.757 | 0.000197 *** |
| **Residuals** | 327 | 31,302,628 | 95,727 | | |

### 5.1 Interpretation
1. **Main Effect of Species:** Highly significant ($F = 758.36, p < 0.001$). Species classification remains a primary predictor of body mass.
2. **Main Effect of Sex:** Highly significant ($F = 387.46, p < 0.001$). Males are consistently heavier than females across all species.
3. **Interaction Effect (Species $\times$ Sex):** Statistically significant ($F = 8.76, p = 0.000197$). This confirms that the effect of biological sex on body mass varies depending on the specific penguin species (i.e., sexual dimorphism is more pronounced in some species than others).

---

## 6. Additional Analysis: Flipper Length Across Species

We repeat the cross-species variance evaluations using **flipper length (mm)** as the target variable.

| Factor | Df | Sum Sq | Mean Sq | F-value | Pr(>F) |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Species** | 2 | 50,526 | 25,263 | 567.4 | < 2e-16 *** |
| **Residuals** | 330 | 14,693 | 45 | | |

### 6.1 Post-Hoc Pairwise Comparisons (Tukey HSD for Flipper Length)

| Comparison Pair | Difference (mm) | Lower 95% CL | Upper 95% CL | p adj |
| :--- | :---: | :---: | :---: | :---: |
| **Chinstrap - Adelie** | 5.72 | 3.41 | 8.03 | 0.0000 *** |
| **Gentoo - Adelie** | 27.13 | 25.19 | 29.07 | 0.0000 *** |
| **Gentoo - Chinstrap** | 21.41 | 19.02 | 23.80 | 0.0000 *** |

### 6.2 Comparative Discussion
The flipper length variation across species matches the patterns observed for body mass:
* The omnibus F-test is highly significant ($F = 567.4, p < 0.001$).
* Unlike body mass, the post-hoc test shows that **all pairwise comparisons for flipper length are highly significant ($p_{\text{adj}} < 0.001$)**. Chinstrap penguins display a small but statistically significant increase in flipper length compared to Adelie penguins ($\Delta = 5.72\text{mm}$), while Gentoo penguins maintain the largest flippers by a wide margin ($\Delta = 27.13\text{mm}$).

---

## 7. Conclusions

1. **Descriptive Summary:** The dataset shows clear physical differences. Gentoo penguins are the largest, both in body mass ($\mu \approx 5,092\text{g}$) and flipper length ($\mu \approx 217.1\text{mm}$).
2. **Sexual Dimorphism:** Across all species, male penguins are significantly heavier than female penguins (Mean Difference = **683.41g**, $p < 0.001$). This difference represents a **large effect size** (Cohen's d = **0.936**).

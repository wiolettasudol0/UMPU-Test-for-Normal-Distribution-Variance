# UMPU Test for Normal Distribution Variance

This project implements the theoretical construction and computational verification of the **Uniformly Most Powerful Unbiased (UMPU)** statistical test for the variance of a normal distribution with an unknown mean ($H_0: \sigma = 2$ vs. $H_1: \sigma \neq 2$).

The implementation numerically calculates exact asymmetric critical values ($c_a, c_b$) by solving the non-linear Neyman-Pearson unbiasedness system via bracket search and the bisection root-finding method, validating test size ($\alpha = 0.05$) and the empirical power function via Monte Carlo simulations ($N = 10{,}000$ iterations).

## Statistical Methods & Theory
  * **Hypothesis Testing:** Neyman-Pearson Lemma, UMPU testing framework for two-sided scale alternatives in exponential families.
  * **Distributions:** $\chi^2(n-1)$ and $\chi^2(n+1)$ density transformations for unbiased condition formulation:
    $$\int_{c_a}^{c_b} f_{\chi^2_{n-1}}(u)\,du = 1 - \alpha \quad \text{and} \quad \int_{c_a}^{c_b} f_{\chi^2_{n+1}}(u)\,du = 1 - \alpha$$
  * **Monte Carlo Validation:** Type I error rate verification and empirical power curve estimation across $\sigma \in [1, 3]$ with $n = 40$.


## Project Structure
* Statistical testing & simulation script (`ths.R`)


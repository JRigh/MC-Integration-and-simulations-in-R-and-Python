# Monte Carlo (MC) Integrations and Simulations

Examples in R programing.

We take an example of Poisson data (artificially generated) of size 20 and model the prior with a Gamma(2,2) distribution. We then sample from the posterior
Gamma(19,22) and compute posterior quantities using direct sampling from the identified distribution. 

![Plot1R](/assets/Plot1R.png)

We also show how to derive the Jeffreys prior, which is an improper prior but has the propriety of being weakly informative.

![jeffreys](/assets/jeffreys.png)

Then using we show an example of multi-stage Gibbs sampling for a Poisson process with Gamma prior.

![Rplot01.](/assets/Rplot01.png)

Python implementation will be added soon.


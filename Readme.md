# Monte Carlo (MC) Integrations and Simulations

Example of MC integration in R programing.


```r
g = function(x) {sin(x) + cos(x)}
set.seed(2023)
m = 10000
fx = runif(m, 0, pi)

I_hat = ((pi - 0) / m) * sum(g(fx))  
# [1] 2.047382

se_I_hat = (pi / m) * sqrt(sum((g(fx) - I_hat)^2)) 
# [1] 0.05000365

c(I_hat - qnorm(1 - 0.05/2) * se_I_hat, I_hat + qnorm(1 - 0.05/2) * se_I_hat) 
# [1] 1.949377 2.145387
```

![plot1R](/Assets/plot1R.png)

Same example this time in Python for similar results.

```python
import pandas as pd
from sklearn.preprocessing import PolynomialFeatures
from sklearn.model_selection import LeaveOneOut, cross_val_score
loocv1 = LeaveOneOut()

# linear model
mod1 = PolynomialFeatures(degree = 1, include_bias = False).fit_transform(xn)
mod11 = LinearRegression().fit(mod1, yn)

loocv1 = LeaveOneOut()
scoresmod1 = cross_val_score(mod11, 
                         mod1,
                         yn, 
                         scoring = 'neg_mean_squared_error',
                         cv = loocv1)
```


![plot1Py](/Assets/plot1Py.png)

Then using we show an example of multi-stage Gibbs sampling for a Poisson process with Gamma prior.

![plotR2](/Assets/plotR2.png)

Python implementation will be added soon.


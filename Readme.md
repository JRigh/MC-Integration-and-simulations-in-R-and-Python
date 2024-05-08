# Monte Carlo (MC) Integrations and Simulations

Example of MC integration in R programing.


```r
pred.cv.mod1 <- pred.cv.mod2 <- numeric(n)

for(i in 1:n) {
  
  # quadratic model
  mod1 = lm(y ~ x, subset = -i)
  pred.cv.mod1[i] = predict(mod1, data[i,])
  
  # quadratic model
  mod2 = lm(y ~ x + I(x^2), subset = -i)
  pred.cv.mod2[i] = predict(mod2, data[i,])
}
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


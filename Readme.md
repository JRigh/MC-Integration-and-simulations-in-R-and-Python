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
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

def g(x):
  return np.sin(x) + np.cos(x)

np.random.seed(2023)
m = 10000
fx = np.random.uniform(0, np.pi, m)

I_hat = ((np.pi - 0) / m) * np.sum(g(fx))
# 2.0111916600488873

se_I_hat = (np.pi / m) * np.sqrt(np.sum((g(fx) - I_hat)**2))
# 0.049309740888497745

confidence_interval = norm.interval(0.95, loc=I_hat, scale=se_I_hat/np.sqrt(m))
Confidence Interval: [1.9145463438204295, 2.107836976277345]
```


![plot1Py](/Assets/plot1Py.png)



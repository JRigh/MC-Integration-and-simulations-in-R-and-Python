#----------------------------------------
# Monte Carlo Integration and Simulations
# in R
#----------------------------------------

#------------------
# A: MC Integration
#------------------

# 1. Define the function g() that we wish to integrate
import math
import numpy as np

def g(m): 
    x = np.array(np.random.uniform(low = 0, high = math.pi, size = m), dtype = float)
    g = np.sin(x) + np.cos(x)
    return g


# 2. Perform the MC approximation using m = 10,000 simulations
np.random.seed(2023)
k = 10000

# MC estimate of the integral
I_hat = ((math.pi - 0) / k) * np.sum(g(m = k))  
# 2.0111916600488873

# approximation of the standard error of the MC estimate
se_I_hat = (math.pi / k) * np.sqrt(np.sum((g(m = k) - I_hat)**2)) 
# 0.04923566222812938

# 95% Confidence Interval
import scipy.stats

[I_hat - scipy.stats.norm.ppf(1 - 0.05/2) * se_I_hat, I_hat + scipy.stats.norm.ppf(1 - 0.05/2) * se_I_hat]
# [1.9146915353267746, 2.107691784771]

# 3. Plots in base R
import matplotlib.pyplot as plt
from matplotlib.pyplot import figure

# plot the function to integrate between 0 and pi
np.random.seed(2020)
xp = np.linspace(0, math.pi, 50000)   # start,stop,step
yp = np.sin(xp) + np.cos(xp)

px = 1/plt.rcParams['figure.dpi'] 
plt.figure(figsize=(850*px, 400*px))
plt.subplot(1, 2, 1)
plt.plot(xp, yp, color = 'red')
plt.hlines(y = 0, xmin = 0, xmax = 3.15, colors = 'black', linestyles='solid', linewidth = 1)
plt.xlabel('x') ; plt.ylabel('g(x)')

# plot convergence of MC estimator with error bounds
seq = np.linspace(1, k, k)
# standard error I_hat
seI_hat = math.pi * np.sqrt(np.cumsum(g(m = k)**2) / seq - (np.cumsum(g(m = k)) / seq)**2)
plt.subplot(1, 2, 2)
plt.plot(math.pi * np.cumsum(g(m = k)) / seq, color = 'black', linewidth = 1.2)
plt.xlabel('MC estimate') ; plt.ylabel('m') ;  plt.ylim([1.5, 3])
# lower bound of 95% confidence interval
plt.plot(math.pi * np.cumsum(g(m = k)) / seq - scipy.stats.norm.ppf(1 - 0.05/2) * seI_hat / np.sqrt(seq),
      color = 'red', linewidth = 1.2)
# upper bound of 95% confidence interval
plt.plot(math.pi * np.cumsum(g(m = k)) / seq + scipy.stats.norm.ppf(1 - 0.05/2) * seI_hat / np.sqrt(seq),
      color = 'red', linewidth = 1.2)
plt.suptitle('Function to integrate and convergence of MC estimate', fontsize = 14)

#------------------
# B: MC Simulations
#------------------

# 1. MC simulations (simple for loop)
# Using MC simulation and MC integration

import statistics
np.random.seed(2023)

n = 10000
m = 5000
est = []
I_hat = []
    
for i in range(n): 
    g = []
    x = np.random.uniform(low = 0, high = math.pi, size = m) 
    g = (np.sin(x) + np.cos(x))
    # MC estimate of the integral
    est = (((math.pi - 0) / m) * np.sum(g))
    I_hat.append(est)
    
statistics.mean(I_hat)   
# 2.0002932056229525

# 2. Histogram with kernel density estimator
px = 1/plt.rcParams['figure.dpi'] 
plt.figure(figsize=(850*px, 400*px))
plt.subplot(1, 2, 1)
plt.hist(x = I_hat, bins = 25, density = 0,
         color = 'red', rwidth = 0.9)
plt.xlabel('I_hat') ; plt.ylabel('count')

from scipy.stats import gaussian_kde
plt.subplot(1, 2, 2)
dens = gaussian_kde(I_hat)
xaxis = np.linspace(1.9, 2.1, 1000)
plt.plot(xaxis, dens(xaxis), color = 'red')
plt.xlabel('I_hat') ; plt.ylabel('density')
plt.suptitle('Histogram and kernel density estimator of the MC estimates', fontsize = 15)

# we clearly see that the MC estimates are centered about the value 2
#----
# end
#----

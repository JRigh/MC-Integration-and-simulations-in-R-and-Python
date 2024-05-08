#----------------------------------------
# Monte Carlo Integration and Simulations
# in R
#----------------------------------------

#------------------
# A: MC Integration
#------------------

# 1. Define the function g() that we wish to integrate
g = function(x) {sin(x) + cos(x)}

# 2. Perform the MC approximation using m = 10,000 simulations
set.seed(2023)

m = 10000
fx = runif(m, 0, pi)

# MC estimate of the integral
I_hat = ((pi - 0) / m) * sum(g(fx))  
# [1] 2.047382

# approximation of the standard error of the MC estimate
se_I_hat = (pi / m) * sqrt(sum((g(fx) - I_hat)^2)) 
# [1] 0.05000365

# 95% Confidence Interval
c(I_hat - qnorm(1 - 0.05/2) * se_I_hat, I_hat + qnorm(1 - 0.05/2) * se_I_hat) 
# [1] 1.949377 2.145387

# 3. Plots in base R
par(mfrow=c(1,2), pty="s")

# plot the function to integrate between 0 and pi
xrange <- seq(from = 0, to = pi, by = 0.01)
plot(xrange, g(xrange), type = "l", ylab = 'g(x)', 
     xlab = "x", col = 'red', lwd = 2)
mtext('Function to integrate and convergence of MC estimate',
      side = 3, line = -3, outer = TRUE)
abline(h = 0)

# plot convergence of MC estimator with error bounds
seq = 1:m
plot(pi * cumsum(g(fx))/seq, ylab = 'MC estimate',
     xlab = 'm', type = 'l', ylim = c(1.4, 3))
# standard error I_hat
seI_hat = pi*sqrt(cumsum(g(fx)^2)/ seq - (cumsum(g(fx))/seq)^2)
# lower bound of 95% confidence interval
lines(pi*cumsum(g(fx))/seq - qnorm(1 - 0.05/2) * seI_hat / sqrt(seq), type = 'l',
      col = 'red', lty = 2)
# upper bound of 95% confidence interval
lines(pi*cumsum(g(fx))/seq + qnorm(1 - 0.05/2) * seI_hat / sqrt(seq), type = 'l',
      col = 'red', lty = 2)

#------------------
# B: MC Simulations
#------------------

# 1. MC simulations (simple for loop)
# Using MC simulation and MC integration

set.seed(12023)
n = 10000
m = 5000
est = numeric(n)

for(i in 1:n) {
  x = runif(m, 0, pi) 
  g = sin(x) + cos(x)
  est[i] = (((pi - 0) / m) * sum(g))
}

I_hat = mean(est)
I_hat
# [1] 1.99988

# 2. Histogram and kernel density estimator of the MC estimates

par(mfrow=c(1,2), pty="s")
hist(est, col = 'red', breaks = 25, freq = NULL, border = 'white', main = '',
     ylab = 'count', xlab = 'I_hat')
box()
plot(density(est), col = 'red', main = '', lwd = 2)
mtext('Histogram and kernel density estimator of the MC estimates',
      side = 3, line = -3, outer = TRUE)


# 3. Advanced example of MC simulations: nested for loop
# MC simulations (example taking about 3 min to run)
# for MC integration

# Define the function g() that we wish to integrate
g = function(x) {sin(x) + cos(x)}

# 4. Define storage objects and erform the MC approximation 
# using m = 500 replications and n = 10,000 simulations.
set.seed(2023)

n = 10000
I_hat = numeric(n)
m = 500
est = matrix(m*n, nrow = n, ncol = m)

for(i in 1:n) {
  for(j in 1:m) {
    
    # MC estimate of the integral
    est[i, j] = ((pi - 0) / m) * sum(g(runif(j, 0, pi))[j])
  }
  # MC estimate of the integral
  I_hat[i] = sum(est[i,])
}

mean(I_hat)
# [1] 2.000983

# 5. Plot the behavior of 5 estimates
par(mfrow = c(1,1), pty = 'm')
den = 1:m
k = 500
p1 = cumsum(apply(est[,], 1, sum)[1:k]) / den
p2 = cumsum(apply(est[,], 1, sum)[(k+1):(2*k)]) / den
p3 = cumsum(apply(est[,], 1, sum)[((2*k)+1):(3*k)]) / den
p4 = cumsum(apply(est[,], 1, sum)[((3*k)+1):(4*k)]) / den
p5 = cumsum(apply(est[,], 1, sum)[((4*k)+1):(5*k)]) / den
plot(p1, type="l", xlim=c(1,m), ylim=c(1.95, 2.05), main="Behavior of the MC estimates of I",
     xlab = 'Number of replicates, m', ylab = 'I_hat')
lines(p2)
lines(p3)
lines(p4)
lines(p5)

#----
# end
#----

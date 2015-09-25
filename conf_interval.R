# confidence intervals
# confint(object, parm, level = 0.95, ...)
# Computes confidence intervals for one or more parameters in a fitted model. 
# There is a default and a method for objects inheriting from class "lm".

# normal distribution
a <- 5 # mean
s <- 2 # standard deviation
n <- 20
error <- qnorm(0.975)*s/sqrt(n)
left <- a-error
right <- a+error

# The true mean has a probability of 95% of being in the interval between 
# 4.12 (left) and 5.88 (right) assuming that the original random variable is normally 
# distributed, and the samples are independent.

# univariate dataset and mean
w1 <- read.csv(file="w1.dat",sep=",",head=TRUE)
summary(w1) # outpust min, 1st Q, median, mean, 3rd Q, max of the column "vals"
mean(w1$vals)
sd(w1$vals)
# calculate the error
error <- qt(0.975,df=length(w1$vals)-1)*sd(w1$vals)/sqrt(length(w1$vals))
# confidence interval comes from subtracting the error from the mean
left <- mean(w1$vals)-error
right <- mean(w1$vals)+error
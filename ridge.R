# ridge regression

setwd("/Users/laurenbutlercurley/Documents/R codes/first TP")

dat <- read.csv("firstTP_MRI_FA.csv", header = TRUE)
output <- lm.ridge(formula, dat, subset, na.action, lambda = 0)

#formula expression as for regression models, of the form response ~ predictors
#an optional data frame in which to interpret the variables occurring in formula.
#which subset of the rows of the data should be used in the fit. All observations are included by default.
#a function to filter missing data.
#lambda	A scalar or vector of ridge constants.
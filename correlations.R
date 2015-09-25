# correlations

setwd("/Users/laurenbutlercurley/Documents/R codes/first TP")

#cor(x, y = NULL, use = "complete.obs") # also for cov
# x = matrix or dataframe
# use = "everything", "all.obs", "complete.obs", "na.or.complete", or "pairwise.complete.obs"

library(Hmisc)
rocrr(x, type="pearson") # produces correlations/covariances and significance
                         # input must be a matrix, pariwise deletion used

# partial correlations
library(ggm)
data(mydata)
pcor(c("a", "b", "x", "y", "z"), var(mydata))
# partial corr between a and b controlling for x, y, z
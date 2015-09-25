# Pricipal Components Analysis
# entering raw data and extracting PCs 
# from the correlation matrix 
# http://www.statmethods.net/advstats/factor.html

setwd("/Users/laurenbutlercurley/Documents/R codes")
# load in data as mydata
mydata <- read.csv("firstTP_PLING_goodMRI_area_PCA.csv", header = TRUE)
# mydata can be a raw data matrix or a covariance matrix. Pairwise deletion of missing data is used.

fit <- princomp(mydata, cor=TRUE)
# use cor=FALSE to base the principal components on the covariance matrix

summary(fit) # print variance accounted for 
loadings(fit) # pc loadings 
plot(fit,type="lines") # scree plot 
fit$scores # the principal components
biplot(fit)

# Varimax Rotated Principal Components
# retaining 5 components 
library(psych)
fit <- principal(mydata, nfactors=5, rotate="varimax")
fit # print results

# Maximum Likelihood Factor Analysis
# entering raw data and extracting 3 factors, 
# with varimax rotation 
fit <- factanal(mydata, 3, rotation="varimax")
print(fit, digits=2, cutoff=.3, sort=TRUE)
# plot factor 1 by factor 2 
load <- fit$loadings[,1:2] 
plot(load,type="n") # set up plot 
text(load,labels=names(mydata),cex=.7) # add variable names

# Determine Number of Factors to Extract
library(nFactors)
ev <- eigen(cor(mydata)) # get eigenvalues
ap <- parallel(subject=nrow(mydata),var=ncol(mydata),
               rep=100,cent=.05)
nS <- nScree(x=ev$values, aparallel=ap$eigen$qevpea)
plotnScree(nS)

# PCA Variable Factor Map 
library(FactoMineR)
result <- PCA(mydata) # graphs generated automatically

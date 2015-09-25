# Correlation matrices and plotting

setwd("/Users/laurenbutlercurley/Documents/R codes/first TP")

library(lattice)
dat <- read.csv("firstTP_DTI_FA.csv", header = TRUE)
dat <- read.csv("firstTP_MRI_area_ChiHua.csv", header = TRUE)
correls <- cor(dat)
levelplot(correls)

library(corrplot)
corrplot(correls, method='cirlce')

#corrgram(x, order= TRUE, panel=, lower.panel=panel.shade, upper.panel=panel.ellipse, 
#          text.panel=, diag.panel=, mean = "Title of my chart")
          # x is a dataframe with 1 obs per row

library(ggplot2)
library(reshape)
correls<- cor(dat)
correls.m <- melt(correls)
ggplot(correls.m, aes(X1, X2, fill = value)) + geom_tile() + 
    scale_fill_gradient2(low = "blue",  high = "yellow")


library(plotrix)
library(seriation)
library(MASS)
plotcor(cor(dat), mar=c(0.1, 4, 4, 0.1))
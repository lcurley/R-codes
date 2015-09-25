####################################################################################
## Spaghetti plots for longitudinal data ##
# first, using interaction.plot 
# then, using ggplot

## todo - design function to input behavior of interest (and "instance" measure) ##
####################################################################################
library(plyr)

rm(list=ls())
setwd("/Users/laurenbutlercurley/Documents/R codes")

dat <- read.csv("usercache_PLING_lauren.csv", header = TRUE)
# rownum <- nrow(dat)
# dat[seq(1,rownum,100),]# preview every 100th row
## Looking at both CTOPP and SSRT ##

# get data with good imaging
goodMRI <- dat[!is.na(dat$MRI_cort_thick.ctx.lh.bankssts),]

# get data with good imaging and CTOPP
goodMRI_CTOPP <- goodMRI[!is.na(goodMRI$BEH_CTOPP_BW_Raw),]
hist(goodMRI_CTOPP$BEH_CTOPP_BW_instance)
count_instanceBW <- count(goodMRI_CTOPP, 'BEH_CTOPP_BW_instance')
rowCTP = nrow(goodMRI_CTOPP)
write.csv(goodMRI_CTOPP, file = "allTP_goodMRI_CTOPP.csv")

# get data with good imaging and CANTAB
goodMRI_CANTAB <- goodMRI[!is.na(goodMRI$BEH_CANTAB_SST_SSRT_last_half),]
hist(goodMRI_CANTAB$BEH_CANTAB_SST_instance)
count_instanceSST <- count(goodMRI_CANTAB, 'BEH_CANTAB_SST_instance')
rowCAN = nrow(goodMRI_CANTAB)
write.csv(goodMRI_CANTAB, file = "allTP_goodMRI_CANTAB.csv")

# plot CTOPP scores over visit w/ color
interaction.plot(goodMRI_CTOPP$BEH_CTOPP_BW_instance, goodMRI_CTOPP$SubjID, 
                 goodMRI_CTOPP$BEH_CTOPP_BW_Raw, xlab="timepoint", ylab="CTOPP BW Raw", 
                 col=c(1:rowCTP), legend=F)

# plot SSRT scores over visit w/ color
interaction.plot(goodMRI_CANTAB$BEH_CANTAB_SST_instance, goodMRI_CANTAB$SubjID, 
                 goodMRI_CANTAB$BEH_CANTAB_SST_SSRT_last_half, xlab="timepoint", ylab="SSRT", 
                 col=c(1:rowCAN), legend=F)

# create linear fit lines for each subject
## RETURNS EMPTY PLOT ##
fit <- by(goodMRI_CTOPP, goodMRI_CTOPP$SubjID, function(x) fitted.values(lm(BEH_CTOPP_BW_Raw ~ Age, data=x)))
fit1 <- unlist(fit)
names(fit1) <- NULL
# plot linear fit by SubjID
interaction.plot(goodMRI_CTOPP$Age, goodMRI_CTOPP$SubjID, fit1, xlab = "Age", ylab="CTOPP BW raw ", legend=F)

####################################################################################
### Alternative plotting using ggplot ###
####################################################################################
library(ggplot2)

# using data loaded in above
# following analyses/examples are for CTOPP only
pts <- ggplot(data = goodMRI_CTOPP, aes(x = BEH_CTOPP_BW_instance, y = BEH_CTOPP_BW_Raw, group = SubjID))

# plotting scatterplot
pts + geom_point()
# basic spaghetti plot
pts + geom_line()
# spaghetti plot split by gender - produces two plots
pts + geom_line() + facet_grid(.~Gender)

# calculate and plot the mean for each instance/ timepoint
pts + geom_line() + stat_summary(aes(group = 1), geom = "point", fun.y = mean, 
                                 shape = 17, size = 3) + facet_grid(. ~ Gender) 

# plot with quartiles
pts + geom_line() + stat_summary(aes(group = 1), geom = "point", fun.y = quantile,     
                               probs = c(0.25, 0.75), shape = 17, size = 3) + facet_grid(. ~ Gender) 

# plot with smooth trend line and shaded confidence intervals
pts + geom_line() + stat_smooth(aes(group = 1)) + stat_summary(aes(group = 1),  geom = "point", 
                              fun.y = median, shape = 17, size = 3) + facet_grid(. ~ Gender)
## geom_smooth: method="auto" and size of largest group is <1000, so using ## loess. 
## Use 'method = x' to change the smoothing method. 

# same plot as above with trendline only, no shading
pts + geom_line() + stat_smooth(aes(group = 1), method = "lm", se = FALSE) +     
     stat_summary(aes(group = 1), geom = "point", fun.y = mean, shape = 17, size = 3) +     
     facet_grid(. ~ Gender) 

# plot independent trendlines between timepoints - this example looks at time 1 vs. not time 1
pts + geom_line() + stat_smooth(aes(group = 1), method = "lm", 
      formula = y ~ x * I(x > 1), se = FALSE) + stat_summary(aes(group = 1), fun.y = mean, 
      geom = "point", shape = 17, size = 3) + facet_grid(. ~ Gender) 


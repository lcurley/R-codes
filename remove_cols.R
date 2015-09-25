# removing data from usercache
# ex. removing all MRI or DTI data
rm(list=ls())
setwd("/Users/laurenbutlercurley/Documents/R codes")

dat <- read.csv("usercache_PLING_lauren.csv", header = TRUE)
dat_noDTI <- dat[, -grep("DTI", colnames(dat))]
# dat_noDTI2 <- dat[, grep("DTI", colnames(dat), invert = TRUE)] # equivalent to line above
dat_noMRI <- dat[, -grep("MRI", colnames(dat))]

dat_onlyDTI <- dat[, -grep("DTI|Subj|Visit", colnames(dat), invert = TRUE)] # SubjID,VisitID, DTI
dat_onlyMRI <- dat[, -grep("MRI|Subj|Visit", colnames(dat), invert = TRUE)] # SubjID, VisitID, MRI
dat_BehMRI <- dat[, -grep("MRI|Subj|Visit|BEH", colnames(dat), invert = TRUE)] # SubjID, VisitID, Behavior, MRI

write.csv(dat_BehMRI, file = "usercache_BehMRI.csv")

# include only columns with the following strings in the column name
# subj, visitID, MRI, CANTAB, CTOPP
## Taking the first timepoint (TP) of PLING data
## First TP for each SubjID with complete /x/ data; options below (x = MRI, DTI, etc.)
rm(list=ls())
setwd("/Users/laurenbutlercurley/Documents/R codes")
dat <- read.csv("usercache_PLING_lauren.csv", header = TRUE)
dat[order(dat$SubjID,dat$Date),]  # Sort by ID and week - shouldn't be necessary

# keep only rows with complete data ---> BAD IDEA
# allData <- dat[complete.cases(dat),] # No data

# use first occuring MRI measure
goodMRI <- dat[!is.na(dat$MRI_cort_thick.ctx.lh.bankssts),]
write.csv(goodMRI, file = "allTP_goodMRI.csv") # all TPs w/ MRI data

# use first occuring DTI measure
goodDTI <- dat[!is.na(dat$DTI_fiber_FA.R_Fx),]
write.csv(goodDTI, file = "allTP_goodDTI.csv") #all TPs w/ good IM
     # no good DTI w/o good MRI, but not the same TPs as filtering for good MRI above

# Keep first obs per SubjID with good MRI and DTI
filtIMdat <- goodMRI[!duplicated(goodMRI$SubjID),] 
write.csv(filtIMdat, file = "firstTP_PLING_goodMRI_goodDTI.csv")

# Keep first obs per SubjID with good MRI only
filtgoodIM <- goodMRI[!duplicated(goodMRI$SubjID),] 
write.csv(filtgoodIM, file = "firstTP_PLING_goodMRI.csv") 

# Keep first obs per SubjID w/o cleaning MRI/DTI
filtdat <- dat[!duplicated(dat$SubjID),] 
write.csv(filtdat, file = "firstTP_PLING.csv") 

# clear all variables
rm(list=ls())

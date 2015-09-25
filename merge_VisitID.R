# merge two sheets on VisitID

setwd("/Users/laurenbutlercurley/Documents/R codes/PLING_data")

dat1 <- read.csv("Connectivity_Measures_forLauren.csv", header = TRUE)
dat2 <- read.csv("usercache_PLING_lauren_Aug07_2015.csv", header = TRUE)
final <- merge(dat1, dat2, by = "VisitID")
write.csv(final, file = "PLING_usercache_connectivity.csv")

dat <- read.csv("JA_OB_wmparc.csv", header = TRUE)
tbss <- read.csv("VisitID_ROI_FA_data.csv", header = TRUE)
final <- merge(dat, tbss, by = "VisitID")
write.csv(final, file = "JA_OB_TBSS.csv")
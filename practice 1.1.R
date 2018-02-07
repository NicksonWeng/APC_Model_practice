# preprocessing the GSS vocab test data and attempt to reproduce the APC mixed-model
# haoran weng
# 2/5/2018

##########################################################################
#Cleasing
##########################################################################

rm(list = ls())

#path
path <- "D:/works/APC study/GSS data 27 p.27 examples"
setwd(path)

#library 

library(plyr) # revalue
library(dplyr) # recode
library(car) # recode 2
recode <- car::recode
#data
ds <- read.csv("gssdata_for_P27.csv")
# Cleansing NAs 
# drop missing age
ds <- ds[complete.cases(ds[,3]),]
# drop missing wordsum
ds <- ds[complete.cases(ds[,2]),]
# note: complete.cases() vs na.omit()


#Recode age race sex
ds$AGE.Recode <- revalue(ds$AGE, c("89 OR OLDER" = "89"))
ds$MALE <- revalue(ds$SEX, c("FEMALE" = "0", "MALE" = "1"))
ds$RACE.Recode <- revalue(ds$RACE, c("BLACK" = "1", "OTHER" = "3", "WHITE" = "2"))
ds$AGE.Recode <- as.numeric(as.character(ds$AGE.Recode))  #!!!! RECODE FACTOR TO NUMBER

ds$BIRTH <- ds$YEAR - ds$AGE.Recode
ds <- ds[ds$AGE.Recode > 17,]

# add cohort
ds$COHORT <- ds$BIRTH
ds$COHORT.S <- ds$BIRTH
ds$COHORT[ds$COHORT < 1895] <- "- 1894"
ds$COHORT.S[ds$COHORT.S < 1895] <- "1890"

e = 1
i = 1895

while(e<18){
  a <- paste(i,":",(i+4),"=","'",i,"-",(i+4),"'" )
  b <- paste(i,":",(i+4),"=","'",i,"'" )
  ds$COHORT.S <- recode(ds$COHORT.S, b)
  ds$COHORT <- recode(ds$COHORT, a)
  i = i+5
  e = e+1
}
ds$COHORT <- factor(ds$COHORT)

#save
path <- "D:/works/APC study/GSS data 27 p.27 examples"
setwd(path)
write.csv(ds, "gssdata_for_P27_preprocessed.csv")

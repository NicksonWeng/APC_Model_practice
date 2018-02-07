# class-classified data structure
# Haoran
# 2/7/2018

rm(list = ls())
#path
path <- "D:/works/APC study/GSS data 27 p.27 examples"
setwd(path)

#data
ds <- read.csv("gssdata_for_P27_preprocessed.csv")

# attemp to create age/period table
# table of sum of average score for cohorts in different periods
list.of.period <- unique(ds$YEAR)
list.of.cohort <- sort(unique(ds$COHORT.S))
# loop to create risk matrix
P.C.frame <- data.frame(list.of.cohort)

i <- 1
while(i< 18){
  co <- list.of.period[i]
  sub.ds <- ds[ds$YEAR == co,]
  average.score <- aggregate(sub.ds$WORDSUM, by=list(list.of.cohort=sub.ds$COHORT.S), FUN=mean)
  P.C.frame <- merge(P.C.frame, average.score, by="list.of.cohort", all.x = TRUE)
  colnames(P.C.frame)[i+1] <- list.of.period[i]
  i <- i+1
}
P.C.frame <- P.C.frame[,2:18]
rownames(P.C.frame) <- list.of.cohort

path <- "D:/works/APC study/GSS data 27 p.27 examples"
setwd(path)
write.csv(P.C.frame, "Cohort-period class-classified data structure of GSS.csv")

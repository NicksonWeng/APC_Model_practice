# attempt to process GSS DATA for APC practice
# 2/5/2018
# Weng Haoran

##########################################################################
#preprocessing
##########################################################################
rm(list = ls())
library(Hmisc)

#path of file
path <- "D:/works/APC study/GSS data 27 p.27 examples/SPSS FORMAT"
setwd(path)
data.list <- list.files(path)

### patch extract data, extract only listed variables ###
list.extract <- c("WORDSUM", "AGE","SEX", "RACE", "EDUC", "YEAR")
whole.ds <- as.data.frame(NULL)
i=1
while(i<18){
  gssdataframe <- spss.get(data.list[i],use.value.labels=TRUE)
  extracted.frame <- gssdataframe[list.extract]
  whole.ds <- rbind(whole.ds, extracted.frame)
  print(i)
  i=i+1
}
summary(whole.ds)
# dataset that is has missing data
# missing.ds <- whole.ds[!complete.cases(whole.ds),]


# DS[, order(names(DS))] # sort columns by column names //deleted
# summary(gssdataframe[, WORDSUM])
# match("VAR", list)


#save the file
path <- "D:/works/APC study/GSS data 27 p.27 examples"
setwd(path)
write.csv(whole.ds, "gssdata_for_P27.csv")


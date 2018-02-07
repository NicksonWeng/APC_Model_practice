# APC ploting without further understanding
# Haoran
# 2/7/2018


rm(list = ls())
#path
path <- "D:/works/APC study/GSS data 27 p.27 examples"
setwd(path)

# apc library
#install.packages("apc")
library(apc)

#data
ds <- read.csv("Cohort-period class-classified data structure of GSS.csv")

#editing
ds <- ds[,2:18]
ds <- as.matrix(ds)

pc.data <- apc.data.list(ds, "CP", coh1 = 1890, unit = 5)
plots <- apc.plot.data.all(pc.data)

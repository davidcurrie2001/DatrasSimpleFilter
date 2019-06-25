library(DATRAS)

filteredData<- readRDS("data/filteredData.rds")
myHH <- filteredData[["HH"]]
myHL<- filteredData[["HL"]]
myCA <- filteredData[["CA"]]

head(myCA)

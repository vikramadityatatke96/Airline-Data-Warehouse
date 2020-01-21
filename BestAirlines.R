library(tidyverse)
library(dplyr)
library(data.table)
library(matrixStats)
library(tidyr)

#Cleaning starts for Best airlines (Statista) dataset.
bestAirlinesData <- read.csv("C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Best Airlines.csv", header=F, na.strings=c(""), stringsAsFactors=T)
airlineRevenue <- read.csv("C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\Airline Revenue1.csv")
colnames(bestAirlinesData) <- c("Airline","Airline Score")
bestAirlinesData <- bestAirlinesData[c(-1:-3, -10:-13, -15:-17),]
row.names(bestAirlinesData) <- 1:nrow(bestAirlinesData)
bestAirlinesData$Airline <- gsub("(.*),.*", "\\1", bestAirlinesData$Airline)
bestAirlinesData[7,1] <- "KLM"
bestAirlinesData <- bestAirlinesData %>% arrange(Airline)
setDT(bestAirlinesData)[, AirlineID := .GRP, by = Airline]
bestAirlinesData$Country <- airlineRevenue$Country
setDT(bestAirlinesData)[, CountryID := .GRP, by = Country]
bestAirlinesData <- bestAirlinesData %>% select(AirlineID, Airline, CountryID, Country, `Airline Score`)
write.csv(bestAirlinesData, file = "C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\Scores.csv", row.names = F)
#Cleaning ends for Best airlines (Statista) dataset.


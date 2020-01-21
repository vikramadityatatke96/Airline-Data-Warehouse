library(tidyverse)
library(dplyr)
library(data.table)
library(matrixStats)
library(tidyr)
library(stringr)

#Cleaning begins for airline ratings dataset.
AirlinesData <- read.csv("C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Airline-Dataset.csv", header=T, na.strings=c(""), stringsAsFactors=T)
segregatedAirlinesData <- AirlinesData[apply(AirlinesData,1,function(x) {any(c('austrian-airlines','etihad-airways', 'klm-royal-dutch-airlines', 'lufthansa', 'qatar-airways', 'singapore-airlines', 'south-african-airways', 'turkish-airlines') %in% x)}),]
segregatedAirlinesData$content <- NULL
segregatedAirlinesData$author <- NULL
segregatedAirlinesData$Month <-NULL
segregatedAirlinesData$recommended <- NULL
segregatedAirlinesData$`Overall Rating` <- NULL
segregatedAirlinesData$X <- NULL
sapply(segregatedAirlinesData, function(x) sum(is.na(x)))
segregatedAirlinesData$airline_name <- str_replace_all(segregatedAirlinesData$airline_name, 
                                                       c("austrian-airlines" = "Austrian Airlines", 
                                                         "etihad-airways" = "Eithad Airways", 
                                                         "klm-royal-dutch-airlines" = "KLM",
                                                         "lufthansa" = "Lufthansa",
                                                         "qatar-airways" = "Qatar Airways",
                                                         "singapore-airlines" = "Singapore Airlines",
                                                         "south-african-airways" = "South African Airways",
                                                         "turkish-airlines" = "Turkish Airlines"))
colnames(segregatedAirlinesData) <- c("PersonID", "Airline", "Author Country", "Cabin Flown", "Comfort Rating", "Staff Rating", "Food Rating", "Entertainment Rating", "Value for Money", "Year")
segregatedAirlinesData <- segregatedAirlinesData %>% arrange(Airline)
setDT(segregatedAirlinesData)[, AirlineID := .GRP, by = Airline]
setDT(segregatedAirlinesData)[, CountryID := .GRP, by = `Author Country`]
setDT(segregatedAirlinesData)[, CabinID := .GRP, by = `Cabin Flown`]
segregatedAirlinesData <- segregatedAirlinesData %>% select(PersonID, AirlineID, Airline, `CountryID`, `Author Country`, `Year`, CabinID, `Cabin Flown`, `Comfort Rating`, `Staff Rating`, `Food Rating`, `Entertainment Rating`, `Value for Money`)
write.csv(segregatedAirlinesData, file = "C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\Airline Ratings.csv", row.names = F)
#Cleaning ends for airline ratings dataset.
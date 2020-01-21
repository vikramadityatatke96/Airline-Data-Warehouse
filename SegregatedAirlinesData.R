library(tidyverse)
library(dplyr)
library(data.table)
library(matrixStats)
library(tidyr)
library(stringr)
library(plyr)

#Cleaning begins for airline ratings dataset.
AirlinesData <- read.csv("C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Airline-Dataset.csv", header=T, na.strings=c(""), stringsAsFactors=T)
segregatedAirlinesData <- AirlinesData[apply(AirlinesData,1,function(x) {any(c('austrian-airlines','etihad-airways', 'klm-royal-dutch-airlines', 'lufthansa', 'qatar-airways', 'singapore-airlines', 'south-african-airways', 'turkish-airlines') %in% x)}),]
segregatedAirlinesData$content <- NULL
segregatedAirlinesData$author <- NULL
segregatedAirlinesData$Month <-NULL
segregatedAirlinesData$recommended <- NULL
segregatedAirlinesData$overall_rating <- NULL
segregatedAirlinesData$X <- NULL
segregatedAirlinesData$`Author Country` <- NULL
sapply(segregatedAirlinesData, function(x) sum(is.na(x)))
segregatedAirlinesData$airline_name <- str_replace_all(segregatedAirlinesData$airline_name, 
                                                       c("austrian-airlines" = "Austrian Airlines", 
                                                         "etihad-airways" = "Etihad Airways", 
                                                         "klm-royal-dutch-airlines" = "KLM",
                                                         "lufthansa" = "Lufthansa",
                                                         "qatar-airways" = "Qatar Airways",
                                                         "singapore-airlines" = "Singapore Airlines",
                                                         "south-african-airways" = "South African Airways",
                                                         "turkish-airlines" = "Turkish Airlines"))
colnames(segregatedAirlinesData) <- c ("Percent", "Airline", "Author Country", "Cabin Flown", "Comfort Rating", "Staff Rating", "Food Rating", "Entertainment Rating", "Value for Money", "Year")
segregatedAirlinesData$Percent <- NULL
segregatedAirlinesData <- segregatedAirlinesData %>% arrange(Airline)
setDT(segregatedAirlinesData)[, AirlineID := .GRP, by = Airline]
setDT(segregatedAirlinesData)[, CabinID := .GRP, by = `Cabin Flown`]
segregatedAirlinesData <- segregatedAirlinesData %>%
                          select(AirlineID, Airline, CabinID, `Cabin Flown`, `Comfort Rating`, `Staff Rating`, `Food Rating`, `Entertainment Rating`, `Value for Money`)

f = segregatedAirlinesData$Airline 
out <- split( segregatedAirlinesData , f)
`Austrian Airlines` <- out$`Austrian Airlines`
`Austrian Airlines` <- ddply(`Austrian Airlines`, .(CabinID), numcolwise(median), .drop = FALSE)
`Austrian Airlines`$Airline <- c("Austrian Airlines", "Austrian Airlines", "Austrian Airlines")
`Austrian Airlines`$`Cabin Flown` <- c("Business Class", "Economy", "Premium Economy")

`Etihad Airways` <- out$`Etihad Airways`
`Etihad Airways` <- ddply(`Etihad Airways`, .(CabinID), numcolwise(median), .drop = FALSE)
`Etihad Airways`$Airline <- c("Etihad Airways", "Etihad Airways", "Etihad Airways")
`Etihad Airways`$`Cabin Flown` <- c("Business Class", "Economy", "First Class")

`KLM` <- out$`KLM`
`KLM` <- ddply(`KLM`, .(CabinID), numcolwise(median), .drop = FALSE)
`KLM`$Airline <- c("KLM", "KLM", "KLM")
`KLM`$`Cabin Flown` <- c("Business Class", "Economy", "Premium Economy")

`Lufthansa` <- out$`Lufthansa`
`Lufthansa` <- ddply(`Lufthansa`, .(CabinID), numcolwise(median), .drop = FALSE)
`Lufthansa`$Airline <- c("Lufthansa", "Lufthansa", "Lufthansa", "Lufthansa")
`Lufthansa`$`Cabin Flown` <- c("Business Class", "Economy", "Premium Economy", "First Class")

`Qatar Airways` <- out$`Qatar Airways`
`Qatar Airways` <- ddply(`Qatar Airways`, .(CabinID), numcolwise(median), .drop = FALSE)
`Qatar Airways`$Airline <- c("Qatar Airways", "Qatar Airways", "Qatar Airways", "Qatar Airways")
`Qatar Airways`$`Cabin Flown` <- c("Business Class", "Economy", "Premium Economy", "First Class")

`South African Airways` <- out$`South African Airways`
`South African Airways` <- ddply(`South African Airways`, .(CabinID), numcolwise(median), .drop = FALSE)
`South African Airways`$Airline <- c("South African Airways", "South African Airways")
`South African Airways`$`Cabin Flown` <- c("Business Class", "Economy")

`Singapore Airlines` <- out$`Singapore Airlines`
`Singapore Airlines` <- ddply(`Singapore Airlines`, .(CabinID), numcolwise(median), .drop = FALSE)
`Singapore Airlines`$Airline <- c("Singapore Airlines", "Singapore Airlines", "Singapore Airlines", "Singapore Airlines")
`Singapore Airlines`$`Cabin Flown` <- c("Business Class", "Economy", "Premium Economy", "First Class")

`Turkish Airlines` <- out$`Turkish Airlines`
`Turkish Airlines` <- ddply(`Turkish Airlines`, .(CabinID), numcolwise(median), .drop = FALSE)
`Turkish Airlines`$Airline <- c("Turkish Airlines", "Turkish Airlines", "Turkish Airlines")
`Turkish Airlines`$`Cabin Flown` <- c("Business Class", "Economy", "Premium Economy")
 segregatedAirlinesData2 <- rbind.data.frame(`Austrian Airlines`, `Etihad Airways`, `KLM`, `Lufthansa`,`Qatar Airways`,`Singapore Airlines`,`South African Airways`,`Turkish Airlines`)
segregatedAirlinesData2 <- segregatedAirlinesData2 %>% 
                          dplyr::mutate(RID = row_number()) %>%
                          select(RID, AirlineID, Airline, CabinID, `Cabin Flown`, `Comfort Rating`,`Staff Rating`, `Food Rating`, `Entertainment Rating`, `Value for Money`)

segregatedAirlinesData2$Country <-ifelse(segregatedAirlinesData2$AirlineID == 1, 1, 
                                  ifelse(segregatedAirlinesData2$AirlineID == 2, 2,
                                  ifelse(segregatedAirlinesData2$AirlineID == 3, 3,
                                  ifelse(segregatedAirlinesData2$AirlineID == 4, 4,
                                  ifelse(segregatedAirlinesData2$AirlineID == 5, 5,
                                  ifelse(segregatedAirlinesData2$AirlineID == 6, 6,
                                  ifelse(segregatedAirlinesData2$AirlineID == 7, 7,
                                  ifelse(segregatedAirlinesData2$AirlineID == 8, 8,'something else'))))))))
segregatedAirlinesData3 <- rbind(segregatedAirlinesData2, segregatedAirlinesData2)
segregatedAirlinesData3 <- head(segregatedAirlinesData3, -4)
segregatedAirlinesData3 <- segregatedAirlinesData3 %>% arrange(AirlineID)
rownames(segregatedAirlinesData3) <- NULL
segregatedAirlinesData3 <- segregatedAirlinesData3 %>% arrange(AirlineID)
segregatedAirlinesData3$RID <- rownames(segregatedAirlinesData3)
write.csv(segregatedAirlinesData3, file = "C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\Airline Ratings.csv", row.names = F)
#Cleaning ends for airline ratings dataset.
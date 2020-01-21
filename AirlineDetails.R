library(magrittr)
library(dplyr)
library(tidyr)
library(tidyverse)
library(data.table)

#Cleaning starts for Fuel (Gallons) dataset.
fuelData <- read.csv("C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Fuel.csv", header=T, na.strings=c("","?"), stringsAsFactors=T)
fuelData$X<-NULL
complete.cases(fuelData)
colnames(fuelData) <- c("Airlines","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")
fuelData <- na.omit(fuelData)
fuelData <- fuelData[c(-8,-14,-19,-20),]
rownames(fuelData) <- NULL
fuelData <- fuelData %>% select(Airlines,`2017`)
names(fuelData) <- c("Airline", "Gallons_Fuel")
fuelData <- fuelData %>% mutate(Gallons_Fuel = as.numeric(gsub(",","", Gallons_Fuel)))
fuelMedian <- fuelData$Gallons_Fuel
fuelMedian[is.na(fuelMedian)] <- median(fuelMedian, na.rm =TRUE)
fuelData$Gallons_Fuel <- fuelMedian
fuelData$Airline <- as.character(fuelData$Airline)
fuelData[7,1] <- "America West"
fuelData <- fuelData %>% arrange(Airline)
#Cleaning ends for Fuel (Gallons) dataset.

#Cleaning starts for Total Load Factor dataset.
loadFactorData <- read.csv("C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Total System Load Factor.csv", header=T, na.strings=c("","?"), stringsAsFactors=T)
loadFactorData$X<-NULL
complete.cases(loadFactorData)
names(loadFactorData) <- c("Airlines","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")
rownames(loadFactorData) <- NULL
loadFactorData <- loadFactorData[c(-1:-4,-12,-13,-19,-20,-25:-30),]
rownames(loadFactorData) <- NULL
loadFactorData <- loadFactorData %>% select(Airlines,`2017`)
names(loadFactorData) <- c("Airline", "Load_Factor")
loadFactorData <- loadFactorData %>% mutate(Load_Factor = as.numeric(gsub("%","", Load_Factor)))
loadMedian <- loadFactorData$Load_Factor
loadMedian[is.na(loadMedian)] <- median(loadMedian, na.rm =TRUE)
loadFactorData$Load_Factor<- loadMedian
loadFactorData <- loadFactorData %>% arrange(Airline)
#Cleaning ends for Total Load Factor dataset.

#Cleaning starts for Total Operating Revenue dataset.
operatingRevenueData <- read.csv("C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\System Total Operating Revenue.csv", header=T, na.strings=c("","?"), stringsAsFactors=T)
operatingRevenueData$X<-NULL
complete.cases(operatingRevenueData)
colnames(operatingRevenueData) <- c("Airlines","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")
operatingRevenueData <- na.omit(operatingRevenueData)
rownames(operatingRevenueData) <- NULL
operatingRevenueData <- operatingRevenueData[c(-8,-14,-19,-20,-21),]
rownames(operatingRevenueData) <- NULL
operatingRevenueData <- operatingRevenueData%>% select(Airlines,`2017`)
names(operatingRevenueData) <- c("Airline", "Operating_Revenue")
operatingRevenueData <- operatingRevenueData %>% mutate(Operating_Revenue = as.numeric(gsub("\\$","", Operating_Revenue)))
revenueMedian <- operatingRevenueData$Operating_Revenue
revenueMedian[is.na(revenueMedian)] <- median(revenueMedian, na.rm =TRUE)
operatingRevenueData$Operating_Revenue <- revenueMedian
operatingRevenueData <- operatingRevenueData %>% arrange(Airline)
#Cleaning ends for Total Operating Revenue dataset.

#Cleaning starts for Total Operating Expenses dataset.
operatingExpensesData <- read.csv("C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\System Total Operating Expenses.csv", header=T, na.strings=c("","?"), stringsAsFactors=T)
operatingExpensesData$X<-NULL
complete.cases(operatingExpensesData)
colnames(operatingExpensesData) <- c("Airlines","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")
operatingExpensesData <- na.omit(operatingExpensesData)
rownames(operatingExpensesData) <- NULL
operatingExpensesData <- operatingExpensesData[c(-8,-14,-19,-20,-21),]
rownames(operatingExpensesData) <- NULL
operatingExpensesData <- operatingExpensesData%>% select(Airlines,`2017`)
names(operatingExpensesData) <- c("Airline", "Operating_Expense")
operatingExpensesData <- operatingExpensesData %>% mutate(Operating_Expense = as.numeric(gsub("\\$","", Operating_Expense)))
expenseMedian <- operatingExpensesData$Operating_Expense
expenseMedian[is.na(expenseMedian)] <- median(expenseMedian, na.rm =TRUE)
operatingExpensesData$Operating_Expense <- expenseMedian
operatingExpensesData <- operatingExpensesData %>% arrange(Airline)
#Cleaning ends for Total Operating Expenses dataset.

operatingExpensesData$Airline <- as.character(operatingExpensesData$Airline)
operatingRevenueData$Airline <- as.character(operatingRevenueData$Airline)
loadFactorData$Airline <- as.character(loadFactorData$Airline)

airlineFinancial <- merge(operatingRevenueData, operatingExpensesData, by="Airline")
airlinePerformance <- merge(fuelData, loadFactorData, by = "Airline")
airlineDetails <- merge(airlineFinancial, airlinePerformance, by = "Airline")
airlineRevenue <- read.csv("C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\Airline Revenue1.csv")
bestAirlinesData <- read.csv("C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\Scores.csv")
segregatedAirlinesData <- read.csv("C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\Companies.csv")
#bestAirlinesData$Country <- as.character(bestAirlinesData$Country)
airlineDetails[1,1] <- "Austrian Airlines"
airlineDetails[2,1] <- "Etihad Airways"
airlineDetails[3,1] <- "KLM"
airlineDetails[4,1] <- "Lufthansa"
airlineDetails[5,1] <- "Qatar Airways"
airlineDetails[6,1] <- "Singapore Airlines"
airlineDetails[7,1] <- "South African Airways"
airlineDetails[8,1] <- "Turkish Airlines"
airlineDetails <- airlineDetails[c(-9:-16),]
row.names(airlineDetails) <- 1:nrow(airlineDetails)
setDT(airlineDetails)[, AirlineID := .GRP, by = Airline]
airlineDetails <- airlineDetails %>% arrange(Airline) %>% select(AirlineID, Airline, Operating_Revenue, Operating_Expense, Gallons_Fuel, Load_Factor)
airlineDetails$Airline <- as.factor(airlineDetails$Airline)
temp1 <- airlineDetails %>% right_join(airlineRevenue, by=c("AirlineID","Airline"))
temp2 <- temp1 %>% right_join(bestAirlinesData, by=c("AirlineID","Airline", "CountryID", "Country"))
temp3 <- temp2 %>% right_join(segregatedAirlinesData, by=c("AirlineID","Airline", "CountryID", "Country"))
temp3 <- temp3 %>% arrange(Airline) %>% select(AirlineID, Airline, IATA.Code, CountryID, Country, Country.Code, Airline.Score, Revenue, Operating_Revenue, Operating_Expense, Gallons_Fuel, Load_Factor, Number.of.Airplanes, Fleet.Age.AVG.)
#write.csv(airlineDetails, file = "C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\AirlineDetails.csv", row.names = F)
write.csv(temp3, file = "C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\AirlineDetails1.csv", row.names = F)

#Cleaning ends for Total Operating Expenses dataset.

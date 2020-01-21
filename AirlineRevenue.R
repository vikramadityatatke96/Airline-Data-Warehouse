library(htmltab)
library(tidyverse)
library(dplyr)
library(data.table)
library(matrixStats)
library(tidyr)

url <- "https://en.wikipedia.org/wiki/World%27s_largest_airlines"
#Cleaning for airlineRevenue Starts
airlineRevenue <- htmltab(doc=url, which = 1, stringsAsFactors = TRUE)
head(airlineRevenue)

airlineRevenue <- airlineRevenue %>%
  mutate(`Revenue(US$B)` = as.numeric(`Revenue(US$B)`),
         Country = as.character(sub('.','',Country))) %>%
  select(Airline, Country, `Revenue(US$B)`) %>%
  arrange(Airline)
names(airlineRevenue)[names(airlineRevenue) == "Revenue(US$B)"] <- "Revenue"
airlineRevenue[1,1] <- "KLM"
airlineRevenue[1,2] <- "Netherlands"
airlineRevenue[2,1] <- "Austrian Airlines"
airlineRevenue[2,2] <- "Austria"
airlineRevenue[3,1] <- "South African Airways"
airlineRevenue[3,2] <- "South Africa"
airlineRevenue[4,1] <- "Singapore Airlines"
airlineRevenue[4,2] <- "Singapore"
airlineRevenue[5,1] <- "Turkish Airlines"
airlineRevenue[5,2] <- "Turkey"
airlineRevenue[6,1] <- "Etihad Airways"
airlineRevenue[6,2] <- "United Arab Emirates"
airlineRevenue[7,1] <- "Qatar Airways"
airlineRevenue[7,2] <- "Qatar"
airlineRevenue[8,2] <- "Germany"
airlineRevenue <- airlineRevenue %>% arrange(Airline)
airlineRevenue <- airlineRevenue[c(-8,-10),]
row.names(airlineRevenue) <- 1:nrow(airlineRevenue)
airlineRevenue <- airlineRevenue %>% arrange(Airline)
setDT(airlineRevenue)[, AirlineID := .GRP, by = Airline]
setDT(airlineRevenue)[, CountryID := .GRP, by = Country]
airlineRevenue <- airlineRevenue %>% select(AirlineID, Airline, CountryID, Country, Revenue)
write.csv(airlineRevenue, file = "C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\Airline Revenue1.csv", row.names = F)
#Cleaning for airlineRevenue ends
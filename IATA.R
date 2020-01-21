#Downloading and cleaning IATA Data

library(dplyr)
library(curl)
library(httr)
library(jsonlite)
library(tidyr)
library(data.table)

url <- "https://aviation-edge.com/v2/public/airlineDatabase?key=e5c06d-d3426f"
#Getting data from Aviation Edge API
differentAirlines <- fromJSON(url)
codeIata <- c("OS", "EY", "KL", "LH", "QR", "SQ", "SA", "TK")
alt_result <- differentAirlines %>% filter(codeIataAirline%in%codeIata)
alt_result[alt_result==""]<-NA
alt_result <- alt_result %>% drop_na() %>% select(nameAirline, codeIataAirline, sizeAirline, ageFleet, codeIso2Country, nameCountry)
names(alt_result) <- c("Airline", "IATA Code", "Number of Airplanes","Fleet Age(AVG)", "Country Code", "Country")
alt_result[1,1] <- "Turkish Airlines"
alt_result[2,1] <- "Lufthansa"
alt_result[6,1] <- "Singapore Airlines"
alt_result[7,1] <- "Austrian Airlines"
alt_result[8,1] <- "South African Airways"
alt_result <- alt_result %>% arrange(Airline) 
setDT(alt_result)[, AirlineID := .GRP, by = Airline]
setDT(alt_result)[, CountryID := .GRP, by = Country]
alt_result <- alt_result %>% arrange(Airline) %>% select(AirlineID, Airline, CountryID, Country,  `IATA Code`, `Number of Airplanes`, `Fleet Age(AVG)`, `Country Code`)
write.csv(alt_result, file="C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\Companies.csv", row.names = F)






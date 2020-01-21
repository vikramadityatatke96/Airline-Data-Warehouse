library(dplyr)
tempCabin <- read.csv("C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\Airline Ratings.csv")

Cabin <- data.frame(AirlineID=with(tempCabin, AirlineID))
Cabin$CabinGroupID <- (CabinGroupID= with(tempCabin, CabinID))
Cabin$Cabin.Flown <- (Cabin.Flown=with(tempCabin, Cabin.Flown))
Cabin <- Cabin %>% dplyr::mutate(CabinID = row_number()) %>%
                    select(CabinID, CabinGroupID, Cabin.Flown, AirlineID)
write.csv(Cabin, file = "C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\Cabin.csv", row.names = F)

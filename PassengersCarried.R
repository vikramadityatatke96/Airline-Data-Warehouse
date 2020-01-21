library(htmltab)
library(tidyverse)
library(dplyr)
library(data.table)
library(matrixStats)
library(tidyr)
url <- "https://en.wikipedia.org/wiki/World%27s_largest_airlines"

# cleaning for passengersCarried starts
passengersCarried <- htmltab(doc=url, which = 2, stringsAsFactors = TRUE)
rownames(passengersCarried) <- c(1:10)
head(passengersCarried)
passengersCarried <- passengersCarried %>%
  mutate(`2011` = as.numeric(gsub(",","", `2011`)),
         `2012` = as.numeric(gsub(",","", `2012`)),
         `2013` = as.numeric(gsub(",","", `2013`)),
         `2014` = as.numeric(gsub(",","", `2014`)),
         `2015` = as.numeric(gsub(",","", `2015`)),
         `2016` = as.numeric(gsub(",","", `2016`)),
         Country = as.character(sub('.','',Country))) %>%
  arrange(Airline)

passengersCarriedt <- as.matrix(passengersCarried[,c(4:9)])
k <- which(is.na(passengersCarriedt), arr.ind = TRUE)
passengersCarriedt[k] <- rowMedians(passengersCarriedt, na.rm = TRUE) [k[,1]]
passengersCarried[c(4:9)] <- as.data.frame(passengersCarriedt)
passengersCarried$Rank <- NULL
passengersCarried$`2016` <- NULL
passengersCarried[1,1] <- "Austrian Airlines"
passengersCarried[1,2] <- "Austria"
passengersCarried[2,1] <- "Qatar Airways"
passengersCarried[2,2] <- "Qatar"
passengersCarried[3,1] <- "Etihad Airways"
passengersCarried[3,2] <- "United Arab Emirates"
passengersCarried[4,1] <- "South African Airways"
passengersCarried[4,2] <- "South Africa"
passengersCarried[5,1] <- "Singapore Airlines"
passengersCarried[5,2] <- "Singapore"
passengersCarried[6,1] <- "KLM"
passengersCarried[6,2] <- "Netherlands"
passengersCarried[7,1] <- "Lufthansa"
passengersCarried[7,2] <- "Germany"
passengersCarried <- passengersCarried[c(-8,-10),]
passengersCarried[,3:7] <- format(round(passengersCarried[,3:7] / 1000000, 2), scientific =FALSE)
row.names(passengersCarried) <- 1:nrow(passengersCarried)
passengersCarried <- passengersCarried %>% arrange(Airline)
setDT(passengersCarried)[, AirlineID := .GRP, by = Airline]
setDT(passengersCarried)[, CountryID := .GRP, by = Country]
passengersCarried <- passengersCarried %>% select(AirlineID, Airline, CountryID, Country, `2011`, `2012`, `2013`, `2014`, `2015`)
passengersCarried1 <- data.frame(No.of.Passengers = c(passengersCarried[,`2011`], 
                                          passengersCarried[,`2012`],
                                          passengersCarried[,`2013`], 
                                          passengersCarried[,`2014`],
                                          passengersCarried[,`2015`]), 
                                "AirlineID" = c(passengersCarried[,AirlineID]))
N <- 8L 
passengersCarried1$YearID <- rep(seq_len(nrow(passengersCarried1)%/%N+1L),each=N,len=nrow(passengersCarried1))

passengersCarried1$Year <-   ifelse(passengersCarried1$YearID == 1, 2011, 
                                ifelse(passengersCarried1$YearID == 2, 2012,
                                ifelse(passengersCarried1$YearID == 3, 2013,  
                                ifelse(passengersCarried1$YearID == 4, 2014,
                                ifelse(passengersCarried1$YearID == 5, 2015, "something else")))))
passengersCarried1 <- passengersCarried1 %>%  
                                      arrange(AirlineID) %>%
                                      select(AirlineID, YearID, Year, No.of.Passengers)

write.csv(passengersCarried1, file = "C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\Passengers Carried1.csv", row.names = F)
#Cleaning for passengersCarried ends
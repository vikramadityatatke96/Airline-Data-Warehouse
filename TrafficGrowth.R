library(dplyr)

trafficGrowth <- read.csv("C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Global Air Traffic.csv", header = FALSE ,stringsAsFactors = TRUE)
names(trafficGrowth) <- c("Year", "Percentage Growth", "Delete This")
trafficGrowth$`Delete This` <- NULL
trafficGrowth <- trafficGrowth[-c(1:9),]
trafficGrowth <- trafficGrowth[-c(6:8),]
rownames(trafficGrowth) <- NULL
trafficGrowth <- trafficGrowth%>% mutate(YearID = row_number()) %>% 
                                  select(YearID, Year, `Percentage Growth`)
write.csv(trafficGrowth, file = "C:\\Users\\vikra\\OneDrive - National College of Ireland\\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\Final CSVs\\Traffic Growth.csv", row.names = F)

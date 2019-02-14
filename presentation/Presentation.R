#The datasets

#setwd()
#air <- read.csv("air.csv")
nrow(air)  #7001975 rows
colnames(air)
# [1] "X"                 "Dest"              "Origin"           
# [4] "Month"             "DayofMonth"        "DayOfWeek"        
# [7] "DepTime"           "CRSDepTime"        "ArrTime"          
# [10] "CRSArrTime"        "UniqueCarrier"     "FlightNum"        
# [13] "TailNum"           "ActualElapsedTime" "CRSElapsedTime"   
# [16] "AirTime"           "ArrDelay"          "DepDelay"         
# [19] "Distance"          "TaxiIn"            "TaxiOut"          
# [22] "Cancelled"         "CancellationCode"  "Diverted"         
# [25] "CarrierDelay"      "WeatherDelay"      "NASDelay"         
# [28] "SecurityDelay"     "LateAircraftDelay"

source("airports.R")
colnames(airports)  #301 rows
# [1] "latitude_deg"  "longitude_deg" "elevation_ft"  "iata_code"    
# [5] "NDepartures"   "NArrivals"     "Cancelled"    
#add a column to airports and export as cvs
airports$PropCancelled <- airports$Cancelled / airports$NDepartures
write.csv(airports, file = "airports.csv")

# In QGIS: identify hot spots and cold spots by cancellation rate and by number of cancellations 

# Read the resulting csv files of the hot spot airports
HSNCxl <- read.csv("HotSpotNCxl.csv")
HSCxlProp <- read.csv("HotSpotCxlProp.csv")
#Subset the Hot Spot airports from the air dataset
airHSNCxl <- subset(air,air$Origin %in% HSNCxl$iata_code)  #104 airports
airHSCxlProp <- subset(air,air$Origin %in% HSCxlProp$iata_code)  #128 airports

# Read the resulting csv files of the cold spot airports
CSNCxl <- read.csv("ColdSpotNCxl.csv")
CSCxlProp <- read.csv("ColdSpotCxlProp.csv")
# Subset the Cold Spot airports from the air dataset
airCSNCxl <- subset(air,air$Origin %in% CSNCxl$iata_code) #11 airports
airCSCxlProp <- subset(air,air$Origin %in% CSCxlProp$iata_code) #65 airports

#Histagrams: a specified column of the four datasets
fourHist <- function(coln){
  par(mfrow=c(2,2))
  hist(airHSNCxl[[coln]] ,col='red4',
       main=paste("Hot Spot by Number of Cancellations:",coln),xlab=coln)
  hist(airCSNCxl[[coln]],col='blue4',
       main=paste("Cold Spot by Number of Cancellations:",coln),xlab=coln)
  hist(airHSCxlProp[[coln]],col='red',
       main=paste("Hot Spot by Cancellation Rate:",coln),xlab=coln)
  hist(airCSCxlProp[[coln]],col='blue',
       main=paste("Cold Spot by Cancellation Rate:",coln),xlab=coln)
}

fourHist('AirTime')
#Interesting findings:
#"Month" , "DayOfWeek", "DepTime", "AirTime" ,"Distance" 

#Shiny
library(shiny)
runApp("fourHist")


#Conditional barplots
library(lattice)
barchart(Month~AirTime|UniqueCarrier=='9E' ,data=airCSNCxl,col='blue4',
         main="Month~AirTime Given UniqueCarrier==9E \n  Cold Spots by Number of Cancellations")
barchart(Month~AirTime ,data=airCSNCxl,col='blue4',
         main="Month~AirTime \n Cold Spots by Number of Cancellations")



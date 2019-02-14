# US2008Airports
R Shiny dashboard to visualize USA airport data on cancellations in 2008

### Data
The dataset air.csv was downloaded from http://rtricks4kids.ok.ubc.ca/wjbraun/DS550/air.csv
```{r}
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
```
The data folder contains two aggregated datasets generated from the air.csv file.
```{r}
colnames(airports)  #301 rows
# [1] "latitude_deg"  "longitude_deg" "elevation_ft"  "iata_code"    
# [5] "NDepartures"   "NArrivals"     "Cancelled"   
colnames(cancellations) # 5354 rows
# [1] "latOrigin"     "longOrigin"    "latDest"       "longDest"     
# [5] "Cancelled"     "propCancelled" "Diverted"      "propDiverted" 
# [9] "ArrDelay"      "DepDelay"      "Number" 
```


### Poster


### Presentation

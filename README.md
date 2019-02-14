# US2008Airports
[R Shiny](https://shiny.rstudio.com/) applet and [QGIS](https://www.qgis.org/en/site/) to visualize USA airport data on cancellations in 2008

### Data
The dataset air.csv was downloaded from http://rtricks4kids.ok.ubc.ca/wjbraun/DS550/air.csv
```
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
```
colnames(airports)  #301 rows
# [1] "latitude_deg"  "longitude_deg" "elevation_ft"  "iata_code"    
# [5] "NDepartures"   "NArrivals"     "Cancelled"   
colnames(cancellations) # 5354 rows
# [1] "latOrigin"     "longOrigin"    "latDest"       "longDest"     
# [5] "Cancelled"     "propCancelled" "Diverted"      "propDiverted" 
# [9] "ArrDelay"      "DepDelay"      "Number" 
```

### Poster
The poster (poster.pdf) presents preliminary analysis resutls of the cancellation data.

1. Airpotrs with unusually high cancellation percentages (the "top6% airports" identified in Fig. 1) are all small in flight volumns. We use all the small-volumn airpotrs as the baseline (Fig. 3).

2. Compared with the baseline airports (Fig. 4 and Fig. 5), the "top6% airports" have higher cancellation rates in certain months and on certain days of week.

3. Mapping the "top6% airports" (Shiny applet in the poster folder), there is no correlation between cancellation percentage and fight volumn (Fig. 2). There is a cluster in the Midwest, which we performed a case study in Fig. 6 and more spatial analysis in Presentation.

### Presentation
The presentation (Presentation.pdf) provides more visulizations from spatial analysis.

1. Finding the spatial pattern: classifying the airports into hot spots, cold spots, and insignificant. The was done in QGIS, and the outputs are the maps in Presentation.pdf and the csv files in the presentation folder.

2. A Shiny dashboad (code in the presentation folder) was developed for the user to compare cancellation hot spots and cold spots.

3. `lattice` conditional plots were employed to compare monthly flight volumn by different airlines at the cold spots. We can also examine airlines performance at hot spots, or other factors such as flight duration (airtime).

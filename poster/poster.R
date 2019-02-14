airports <- source("airports.R")
airport <- airports$value
#add column: percent cancelled
airport$percentcancelled <- airport$Cancelled*100/airport$NDepartures

##Fig 1 -------------------------------------------
#Histogram: what is considered an usually high cancellation percentage?
hist(airport$percentcancelled, breaks = c(100),
     main = "Fig. 1: Distribution of Percentage Cancelled", 
     xlab = "Percentage Cancelled")
rug(x = 6,ticksize = 0.7,lwd = 2, col = "red")
text(6,19, label ="6%", col ="red" )
airport$Volume <- airport$NDepartures +airport$NArrivals

# The histogram shows the distriubtion of percent cancelled.
# We can identify a break at 6%.

# We also noticed that the top 6% airports have flights volumes <15000, 
# so we define airports with <20000 flights as our baseline (the small airports)
smallApt <- subset(airport, airport$percentcancelled >=6 & airport$Volume < 20000)

##Fig 2 -------------------------------------------
#A map of the airports showing
        #the traffic volume (size of the circle) 
        #cancellation percentage (size of airport code)

#install.packages("rworldmap")
library(rworldmap)
newmap <- getMap(resolution = "low")
plot(newmap,ylim=c(17, 72), xlim=c(-177, -65), asp = 1, 
     col = colourPalette)
par(new=TRUE)

#install.packages("classInt")
library(RColorBrewer)
library(classInt)
colourPalette <- RColorBrewer::brewer.pal(5,"RdPu")
#top 6% airports by cancellation percentage
t6<-subset(airport, airport$percentcancelled>=6)

#Scaling font size for airport code based on Flight_Volume = Arrivals + Departures
#The fron size are normalized to 0.4 - 0.8
x<- t6$Volume
Vol = (0.8-0.4)*(x-min(x))/(max(x)-min(x)) + 0.4 

#Plot the airports as circles, the size of which represent the flight volumes
plot(latitude_deg ~ longitude_deg, data = t6, 
     cex=sqrt(percentcancelled),
     ylim=c(17, 72), xlim=c(-177, -65), axes=FALSE, xlab="", ylab="",col="red")
#Add lable: size of airport code represents the cancellation percentage
text(latitude_deg ~ longitude_deg, label=iata_code, 
     data = t6, ylim=c(17, 72), xlim=c(-177, -65), cex= Vol)
#Add title and legends
title("Fig. 2: Percentage Cancelled and Volume")
legend("bottomleft", legend=c("size: Percentage Cancelled"), 
       pch=c(1), col = "red")
legend("bottomright", legend=c("Code size: Volume"))

#Shiny app for our cancellation percentage USA map plot
#install.packages("shiny")
library(shiny)
#setwd()
runApp("CancelPctPlot/")

##Fig 3 -------------------------------------------
#A histogram comparing the top 6% airports and the small airports.
#The histograms shows that the top 6% airports are small in flight volumn and
#that using a baseline with flight volumn < 20000 is reasonable.


#Visualize the points that have the highest cancellation percentage.
#library(dplyr)
#points(subset(airport, airport$iata_code %in% smallApt$iata_code), col = "red")
#It's better to use a histogram.

Vol_top6 <- subset(airport, airport$iata_code %in% smallApt$iata_code)
#Volume <= 20000 is considered to be a small airport volume
sub_v<- subset(airport,airport$Volume <= 20000)

hist(sub_v$Volume, breaks = c(100), 
     main ="Fig. 3: Total Flights for Low Volume Airports", 
     xlab = "Flight Volume")
rug(x = max(Vol_top6$Volume),ticksize = 0.7,lwd = 2, col = "red")
rug(x = min(Vol_top6$Volume),ticksize = 0.7,lwd = 2, col = "red")
text(max(Vol_top6$Volume),10, label ="max", col ="red" )
text(min(Vol_top6$Volume),10, label ="min", col ="red" )

##Fig 4 -------------------------------------------
#Bar chart comparing top6 airports to baseline airports:
#We overlay bars of cancellation percentage at the top6 airports with at the baseline airports (small airports)

#We are looking for differences between the bars for a given factor such as month, or day of week.
#This will help us understand how the top6 airports can improve operations as small-volumn airports.


#We need to use air.csv (a large file)
#air <- read.csv("air.csv")

#subest of 17 airports (top 6% by percentage cancelled)
top6 <- subset(air, air$Origin %in% smallApt$iata_code) 

#ref is baseline airports: the subset of air that consists of only low volume airports.
ref<- subset(air, air$Origin %in% sub_v$iata_code)


#Comparing top6 and baseline airports in terms of month of the year
t1 <- as.data.frame(table(ref$Month, ref$Cancelled))
t1 <- subset(t1, t1$Var2 == 1) 
                #Var2 ==1 meaning cancelled; ==0 meaning not cancelled
t2 <- as.data.frame(table(top6$Month, top6$Cancelled))
t2 <- subset(t2, t2$Var2 == 1)

t3<-table(ref$Month)
t4<-table(top6$Month)

colour1 <- rgb(0, 0, 1, alpha=0.5)
colour2 <- rgb(0.1, 0.6, 0, alpha=0.5)

x<-t1$Freq*100/t3
t_month= (max(t2$Freq*100/t4))*(x-min(x))/(max(x)-min(x))

# Creating an overlay barplot
par(mfrow = c(1,2))
barplot(t_month,main="",ylim = c(0, max(t2$Freq*100/t4)), col = colour1, width = 0.3)
par(new = TRUE)
barplot(t2$Freq*100/t4,col = colour2, 
        main ="Fig. 4: Monthly Cancellation Percentage", 
        ylim = c(0,max(t2$Freq*100/t4)), xlab = "Months", width = 0.3)


#Comparing top6 and baseline airports in terms of day of week
a1 <- as.data.frame(table(ref$DayOfWeek, ref$Cancelled))
a1 <- subset(a1, a1$Var2 == 1)

a2 <- as.data.frame(table(top6$DayOfWeek, top6$Cancelled))
a2 <- subset(a2, a2$Var2 == 1)

a3<-table(ref$DayOfWeek)
a4<-table(top6$DayOfWeek)

x<-a1$Freq*100/a3
a_week= (max(a2$Freq*100/a4))*(x-min(x))/(max(x)-min(x))

#Creating an overlay barplot
barplot(a_week, main = "", ylim = c(0,max(a2$Freq*100/a4)), col = colour1, width = 0.3)
par(new = TRUE)
barplot(a2$Freq*100/a4, 
        main ="Fig. 5: Weekly Cancellation Percentage", 
        ylim = c(0,max(a2$Freq*100/a4)), xlab = "Day of Week", 
        col=colour2, width = 0.3)
legend("topright", legend = c("Top 6%", "Baseline"), fill = c(colour1, colour2))

#Additional comparison between top6 and baseline airports (not included in the poster)
#Deptime (Departure Time)
# We will categorize the departure time into 2 categories:
        # -1 for convenient hours meaning that it is between 6am to 7pm
        # and 1 for all the other times that are considered inconvenienet, which is before 6 am and after 7pm
ref$con <- as.numeric(ref$DepTime)
ref$con[ref$con>= 600 & ref$con<= 1900] <- -1
ref$con[(ref$con < 600 | ref$con> 1900) & ref$con!= -1] <- 1  #inconvenient

#inconvenient hours is only a small part of the data
top6$con <- as.numeric(top6$DepTime)
top6$con[top6$con>= 600 & top6$con<= 1900] <- -1
top6$con[(top6$con < 600 | top6$con> 1900) & top6$con!= -1] <- 1  #inconvenient

c1<- as.data.frame(table(ref$con, ref$Cancelled))
c1 <- subset(c1, c1$Var2 == 1)
c3<-table(ref$con)

c2 <- as.data.frame(table(top6$con, top6$Cancelled))
c2 <- subset(c2, c2$Var2 == 1)
c4<-table(top6$con)
par(mfrow = c(1,3))
hist(ref$con, main ="Departure Time (Convenient and Inconvenient) Distribution")
hist(ref$con, freq = TRUE, main = "", ylim = c(0,max(c3)),xlab = "Convenience")
par(new = TRUE)
barplot(c1$Freq*100/c3,col = "red", 
        main ="Departure Time Small Airport and Percentage Cancelled", 
        ylim = c(0,max(c2$Freq*100/c4)), axes = FALSE, width =0.3,xlab = "Convenience")
axis(4,cex.axis=0.5)


barplot(c2$Freq*100/c4, col = "red", main = "Departure Time Top 6 and Percentage Cancelled", ylim = c(0, max(c2$Freq*100/c4)), axes = FALSE)
axis(4, cex.axis = 0.5)
par(new =TRUE)
hist(top6$con,main= "", freq= TRUE, ylim = c(0, max(c4)), cex = 2,xlab = "Convenience")

#Fig 5 -------------------------------------------
#Noticing a cluster in the Midwest in Fig.2,
#we can compare airtime or flight distance between 
#the top6% airports in this cluster with the baseline airports (all the small airports) 
#The comparison was done using 2 overlay histograms, with 2 additional detial histograms

#We first define an rectangular boundary for this cluster
#by looking at the coordinates of the top6% airports in the Midwest.
        #SUX lat 42.4026, long -96.3844
        #CMX
        #LAT 47.1684, long: -88.4891
        #SPI
        #LAT 39.844, -89.6779
        #AZO
#Subset all the small airports (baseline) in the rectangular boundary
sub_cluster <- subset(smallApt, smallApt$latitude_deg > 39.8 & smallApt$latitude_deg <47.2 & smallApt$longitude_deg > -96.4 & smallApt$longitude_deg < -85.6)
#subset from the air dataset
cluster <- subset(air, air$Origin %in% sub_cluster$iata_code)

par(mfrow = c(2,2))
#plot1 (upper left)
hist(ref$AirTime, main = "Baseline Airports: Airtime", 
     xlab = "Airtime",col = "white")
par(new = T)
hist(cluster$AirTime, main = "", col ="red", 
     xlab = "", xlim = c(0, 350), ylim = c(0, 150000), axes = FALSE)

#plot2 (upper right)
hist(cluster$AirTime, main = "Cluster: Airtime", xlab = "Airtime", col ="red")
legend("topright", legend = c("cluster", "Baseline"), fill = c("red", "white"))

#plot3 (lower left)
hist(ref$Distance, main = "Baseline Airports: Distance", 
     xlab = "Distance", col = "white")
par(new= T)
hist(cluster$Distance, main = "", xlab = "", col= "red",
     xlim = c(0, max(ref$Distance)), ylim =c(0, 130000),axes = FALSE)

#plot4 (lower right)
hist(cluster$Distance, main = "Cluster: Distance", xlab = "Distance", col= "red")

#Fig. 6 title
mtext("Fig. 6: Cluster Similarity barplots", side = 3, line = -25, outer = TRUE)





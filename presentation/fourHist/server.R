server <-
function(input,output){
    output$main_plot <- renderPlot({
        colN <- input$ColN
        
        #air <- read.csv("air.csv")
        #Read the output files (csv) from QGIS
        HSNCxl <- read.csv("HotSpotNCxl.csv")
        HSCxlProp <- read.csv("CHotSpotCxlProp.csv")
        CSNCxl <- read.csv("ColdSpotNCxl.csv")
        CSCxlProp <- read.csv("ColdSpotCxlProp.csv")
        #Subset the Hot Spot airports from the air dataset
        airHSNCxl <- subset(air,air$Origin %in% HSNCxl$iata_code)  #104 airports
        airHSCxlProp <- subset(air,air$Origin %in% HSCxlProp$iata_code)  #128 airports
        # Subset the Cold Spot airports from the air dataset
        airCSNCxl <- subset(air,air$Origin %in% CSNCxl$iata_code) #11 airports
        airCSCxlProp <- subset(air,air$Origin %in% CSCxlProp$iata_code) #65 airports
        
        #Subset the Hot Spot airports from the air dataset
        airHSNCxl <- subset(air,air$Origin %in% HSNCxl$iata_code)  #104 airports
        airHSCxlProp <- subset(air,air$Origin %in% HSCxlProp$iata_code)  #128 airports
        
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
        
        fourHist(colN)
    })
}



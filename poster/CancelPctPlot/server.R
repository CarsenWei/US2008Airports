server <-
function(input,output){
    output$main_plot <- renderPlot({
        df1 <- source("airports.R")
        airport <- df1$value
        airport$percentcancelled <- airport$Cancelled*100/airport$NDepartures
        
        airport$Volume <- airport$NDepartures +airport$NArrivals
        
        par(mar=c(1, 1, 3, 1))
        library(rworldmap)
        newmap <- getMap(resolution = "low")
        plot(newmap,ylim=c(17, 71), xlim=c(-197, -65), asp = 1, col = colourPalette);par(new=TRUE)
        library(RColorBrewer)
        library(classInt)
        colourPalette <- RColorBrewer::brewer.pal(5,"RdPu")
        
        output$value <- renderPrint({ input$slider1 })
		    
		    df<- subset(airport, airport$percentcancelled >= input$slider1)
		    x<- df$Volume
		    Vol = (0.8-0.4)*(x-min(x))/(max(x)-min(x)) + 0.4
		    
		    plot(latitude_deg ~ longitude_deg, data = df, cex=sqrt(df$percentcancelled), ylim=c(17, 72), xlim=c(-177, -65), axes=FALSE, xlab="", ylab="",col="red")
		    title("Fig. 2: Percentage Cancelled and Volume")
		    legend("bottomleft", legend=c("size: Percentage Cancelled"), pch=c(1), col = "red")
		    legend("bottomright", legend=c("Code size: Volume"))
		    
		    text(latitude_deg ~ longitude_deg, label=iata_code, data = df, ylim=c(17, 72), xlim=c(-177, -65), cex= Vol)
		    })
}



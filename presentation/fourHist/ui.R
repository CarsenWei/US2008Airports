ui <- shinyUI(pageWithSidebar(
  headerPanel("Histograms for Hot Spots and Cold Spots"),
  sidebarPanel(
    textInput("ColN", "Enter the name of the column to be visualized:", "Month") 
  ),
  mainPanel(
    plotOutput(outputId='main_plot')
)
)
)




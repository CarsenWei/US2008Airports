ui <- shinyUI(pageWithSidebar(
  headerPanel("Fig. 2: Percentage Cancelled and Volume"),
  sidebarPanel(
    sliderInput("slider1", label = h3("Percentage Cancelled"), min = 0, 
                max = 21.13402, value = 6)
  ),
  mainPanel(
    plotOutput(outputId='main_plot')
  )
)
)



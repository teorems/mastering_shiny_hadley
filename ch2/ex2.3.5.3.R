# resetting plot

library(shiny)

ui <- fluidPage(
  plotOutput("plot", width = "400px")
)
server <- function(input, output, session) {
  output$plot <- renderPlot(plot(1:5),
                            res = 96,
                            height = 300,
                            width = 700,
                            alt = "scatterplot of 5 random numbers")
}

shinyApp(ui, server)

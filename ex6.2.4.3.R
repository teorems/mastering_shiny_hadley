

library(shiny)
library(tidyverse)
library(cluster)

ui <- fluidPage(
  theme = bslib::bs_theme(preset = "vapor"),
  fluidRow(
  column(6,
         plotOutput("first_plot")),
  column(6,
         plotOutput("second_plot"))
  ),
  fluidRow(
    column(12,
           sliderInput("k", "Number of clusters", 3, min = 2, max = 10, width = "100%"))
  )
)

server <- function(input, output, session) {
  
  output$first_plot <- renderPlot(cluster::clara(iris, input$k) |> plot(which.plots = 1, main = "Clara clustering"))
  output$second_plot <- renderPlot(cluster::pam(iris, input$k) |> plot(which.plots = 1, main = "Pam clustering"))
}

thematic::thematic_shiny()
shinyApp(ui, server)
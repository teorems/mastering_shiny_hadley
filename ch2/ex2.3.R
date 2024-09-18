library(shiny)

ui <- fluidPage(
  sliderInput(
    "values",
    "Select value",
    min = 0,
    max =  100,
    step = 5,
    animate = TRUE,
    value = 0
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)

# convert DT to reactable
library(shiny)
library(reactable)

ui <- fluidPage(
  reactableOutput("table")
)
server <- function(input, output, session) {
  output$table <- renderReactable(reactable(mtcars))
}

shinyApp(ui, server)

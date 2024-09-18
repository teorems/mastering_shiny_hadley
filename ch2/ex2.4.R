library(shiny)

ui <- fluidPage(
  verbatimTextOutput()
)

server <- function(input, output, session) {

}

shinyApp(ui, server)

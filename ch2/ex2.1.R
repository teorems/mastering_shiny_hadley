library(shiny)

ui <- fluidPage(
  textInput(
    "name", "", placeholder = "Your name"
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)

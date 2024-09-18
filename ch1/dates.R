library(shiny)

ui <- fluidPage(
  dateInput("dob", "When were you born?", ),
  dateRangeInput("holiday", "When do you want to go on vacation next?", language = "fr", format = 'dd/mm/yyyy')
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)
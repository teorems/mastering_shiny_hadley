ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server <- function(input, output, session) {


  output$greeting <- renderText(paste0("Hello ", input$name, "!"))
  # outputs the console everytime the input changes
  observeEvent(input$name, {
    message("Greeting performed")
  })
}

shinyApp(ui, server)

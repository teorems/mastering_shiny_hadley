library(shiny)

ui <- fluidPage(
  numericInput("num", "Enter a number", value = 1)
)

server <- function(input, output, session) {

  # BAD CODE
  # var <- reactive(iris[[input$var]])
  # range <- reactive(range(var(), na.rm = TRUE))
  #
  # observe({
  #   print(var())
  #   cat("\n")
  #   print(range())
  #   cat("\n")
  #   })

  # var and range do not work as there are already existing functions named like that. For ex.
  # R might try to evaluate var() as the base function to calculate variance, but it's expecting a numeric input.
  # The built-in range() function might get masked by your reactive expression range.
  #
  # GOOD CODE

   col_c <- reactive(iris[[input$num]])
   range_c <- reactive(range(col_c(), na.rm = TRUE))

# observeEvent() is very similar to eventReactive(). It has two important arguments: eventExpr and handlerExpr. The first argument is the input or expression to take a dependency on; the second argument is the code that will be run.

   observeEvent(input$num, {
     print(col_c())
    cat("\n")
     print(range_c())
    cat("\n")
     })

   # or just observe({})


}

shinyApp(ui, server)

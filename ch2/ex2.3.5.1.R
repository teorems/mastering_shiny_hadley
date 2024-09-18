# text outputs

library(shiny)

ui <- fluidPage(
verbatimTextOutput("summary"),
textOutput("greet"),
verbatimTextOutput("test"),
textOutput("str")
)

server <- function(input, output, session) {
  output$summary <- renderPrint(summary(mtcars))
  output$greet <- renderText("Good morning!")
  output$test <- renderPrint(t.test(1:5, 2:6))
  # !! str alone returns NULL
  output$str <- renderText(capture.output(str(lm(mpg~wt, data = mtcars))))
}

shinyApp(ui, server)

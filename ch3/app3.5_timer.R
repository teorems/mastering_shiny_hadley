# Imagine you wanted to reinforce the fact that this is for simulated data by constantly resimulating the data, so that you see an animation rather than a static plot. We can increase the frequency of updates with a new function: reactiveTimer().

ui <- fluidPage(
  titlePanel( "Constantly resimulating data"),
  fluidRow(
    column(3,
           numericInput("lambda1", label = "lambda1", value = 3),
           numericInput("lambda2", label = "lambda2", value = 5),
           numericInput("n", label = "n", value = 1e4, min = 0)
    ),
    column(9, plotOutput("hist"))
  )
)
server <- function(input, output, session) {
  source("funcs_3.4.2.R")
  # the following code uses an interval of 500 ms so that the plot will update twice a second.
  timer <- reactiveTimer(500)

  x1 <- reactive({
    timer()
    rpois(input$n, input$lambda1)
  })
  x2 <- reactive({
    timer()
    rpois(input$n, input$lambda2)
  })

  output$hist <- renderPlot({
    freqpoly(x1(), x2(), binwidth = 1, xlim = c(0, 40))
  }, res = 96)
}
shinyApp(ui, server)

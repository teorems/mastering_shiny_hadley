library(shiny)

library(shiny)

# Define UI
ui <- fluidPage(
  
  # Application title
  titlePanel("Hello Shiny!"),
  

    
    # Sidebar with a slider input
    fluidRow(
      column(
      4,
      sliderInput("obs",
                  "Number of observations:",
                  min = 0,
                  max = 1000,
                  value = 500)
    ),
    column(8,
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

)

# Server logic
server <- function(input, output) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}
shinyApp(ui, server)
library(xts)
library(lubridate)
library(shiny)

thematic::thematic_shiny()

ui <- fluidPage(
  uiOutput("interaction_slider"),
  verbatimTextOutput("breaks")
)

# original server ------------
# server <- function(input, output, session) {
#   df <- data.frame(
#     dateTime = c(
#       "2019-08-20 16:00:00",
#       "2019-08-20 16:00:01",
#       "2019-08-20 16:00:02",
#       "2019-08-20 16:00:03",
#       "2019-08-20 16:00:04",
#       "2019-08-20 16:00:05"
#     ),
#     var1 = c(9, 8, 11, 14, 16, 1),
#     var2 = c(3, 4, 15, 12, 11, 19),
#     var3 = c(2, 11, 9, 7, 14, 1)
#   )
#   
#   timeSeries <- as.xts(df[, 2:4], 
#                        order.by = strptime(df[, 1], format = "%Y-%m-%d %H:%M:%S")
#   )
#   print(paste(min(time(timeSeries)), is.POSIXt(min(time(timeSeries))), sep = " "))
#   print(paste(max(time(timeSeries)), is.POSIXt(max(time(timeSeries))), sep = " "))
#   
#   output$interaction_slider <- renderUI({
#     sliderInput(
#       "slider",
#       "Select Range:",
#       min = min(time(timeSeries)),
#       max = max(time(timeSeries)),
#       value = c(min, max)
#     )
#   })
#   
#   brks <- reactive({
#     req(input$slider)
#     seq(input$slider[1], input$slider[2], length.out = 10)
#   })
#   
#   output$breaks <- brks
# }
# simplified server --------------------------
datetime <- Sys.time() + (86400 * 0:10)

server <- function(input, output, session) {
  # this is not necessary, a simple sliderInput will work
  output$interaction_slider <- renderUI({
    sliderInput(
      "slider",
      "Select Range:",
      min   = min(datetime),
      max   = max(datetime),
      # here is the error :
      # value = c(min, max)
      value = c(min(datetime), max(datetime))
    )
  })
  
  brks <- reactive({
    req(input$slider)
    seq(input$slider[1], input$slider[2], length.out = 10)
  })
  
  output$breaks <- brks
}
shinyApp(ui, server)
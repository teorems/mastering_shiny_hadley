library(shiny)
library(tidyverse)

if (!exists("injuries"))
source("read_data.R")

ui <- fluidPage(
  fluidRow(
    column(6,
           selectInput("code", "Product",
          choices = prod_codes,
           width = "100%")
    ),
    # addding a control for the number of rows
    column(2,
           selectInput("n", "TopN",
                       choices = 5:10)
           ),
    # adding a  selection for count or rate
    column(2, selectInput("y", "Y axis", c("rate", "count")))
  ),
  fluidRow(
    column(4, tableOutput("diag")),
    column(4, tableOutput("body_part")),
    column(4, tableOutput("location"))
  ),
  fluidRow(
    column(12, plotOutput("age_sex"))
  ),

  # final touch - add a button to get a narrative
  fluidRow(
    column(2, actionButton("story", "Get a narrative :")),
    column(10, textOutput("narrative"))
  ),
  fluidRow(
    column(2, actionButton("nxt", "Next")),
    column(8, textOutput("sequence")),
    column(2, actionButton("bck", "Back"))
  )
)

server <- function(input, output, session) {

  count_top <- function(df, var, n = as.integer(input$n)) {
    df %>%
      mutate({{ var }} := fct_lump(fct_infreq({{ var }}), n = n)) %>%
      group_by({{ var }}) %>%
      summarise(n = as.integer(sum(weight)))
  }


  selected <- reactive(injuries %>% filter(prod_code == input$code))

  #original tables, too large

  # output$diag <- renderTable(
  #   selected() %>% count(diag, wt = weight, sort = TRUE)
  # )
  # output$body_part <- renderTable(
  #   selected() %>% count(body_part, wt = weight, sort = TRUE)
  # )
  # output$location <- renderTable(
  #   selected() %>% count(location, wt = weight, sort = TRUE)
  # )
  #
  # top 5 tables created with count_top function

  output$diag <- renderTable(count_top(selected(), diag), width = "100%")
  output$body_part <- renderTable(count_top(selected(), body_part), width = "100%")
  output$location <- renderTable(count_top(selected(), location), width = "100%")

  summary <- reactive({
    selected() %>%
      count(age, sex, wt = weight) %>%
      left_join(population, by = c("age", "sex")) %>%
      mutate(rate = n / population * 1e4)
  })

  # ORIGINAL CODE
  #
  # output$age_sex <- renderPlot({
  #   summary() %>%
  #     ggplot(aes(age, n, colour = sex)) +
  #     geom_line() +
  #     labs(y = "Estimated number of injuries")
  # }, res = 96)
  #
  # updated code to account for rate or count

  output$age_sex <- renderPlot({
    if (input$y == "count") {
      summary() %>%
        ggplot(aes(age, n, colour = sex)) +
        geom_line() +
        labs(y = "Estimated number of injuries")
    } else {
      summary() %>%
        ggplot(aes(age, rate, colour = sex)) +
        geom_line(na.rm = TRUE) +
        labs(y = "Injuries per 10,000 people")
    }
  }, res = 96)

  # FINAL TOUCH -- eventReactive() to create a reactive that only updates when the button is clicked or the underlying data changes.
  #
  
  narratives <- reactive(selected() %>% pull(narrative))
  
  narrative_sample <- eventReactive(
    list(input$story, selected()),
    narratives() %>% sample(1)
  )
  current_index <- reactiveVal()
  
  observeEvent(list(input$code,input$story), {
    current_index(NULL)
  })
  
  observe({
    if (is.null(current_index())) {
    current_index(match(narrative_sample(), narratives()))
    current_index(current_index() + 1) } else {
      current_index(current_index() + 1)
    }
    max_rows <- reactive(length(narratives()))
    if (current_index() > max_rows()) {current_index(1)}
          }) |> 
    bindEvent(input$nxt)
  
  observe({
    if (is.null(current_index())) {
      current_index(match(narrative_sample(), narratives()))
      current_index(current_index() + 1) } else {
        current_index(current_index() - 1)
      }
    max_rows <- reactive(length(narratives()))
    if (current_index() == 0) {current_index(max_rows())}
  }) |> 
    bindEvent(input$bck)
  

  output$narrative <- renderText(narrative_sample())
  output$sequence <- renderText(narratives()[current_index()])
  

}

shinyApp(ui, server)

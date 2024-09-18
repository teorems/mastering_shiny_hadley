# datatable parameters
# normally a list value (BOOLEAN, string etc.)
# when written like parameter.sousparameter then parameter = list(sousparameter = ...)
# The dom option controls the visibility and order of various table components. For instance:
# t shows the table itself.
# f adds the filter input.
# p adds pagination controls.
# i shows table information.

library(shiny)

ui <- fluidPage(
  dataTableOutput("table")
)
server <- function(input, output, session) {
  output$table <- renderDataTable(mtcars,
                                  options = list(
                                                 searching = FALSE,
                                                 paging = FALSE,
                                                 columns = list(orderable = FALSE)

                                                 ))
}

shinyApp(ui, server)

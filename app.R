#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Stacked barplot"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotlyOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  get_data <- reactive({
    data <- tibble(category = letters[1:4], numeric = c(0.1, 0.2, 0.2, 0.4))
    text <- paste0(data$numeric, " %")
    data$text <- text
    data
  })
   output$distPlot <- renderPlotly({
      data <- get_data()
      
      plot_ly(data, x = ~numeric, y = ~0, color = ~category, text = ~text, orientation = 'h', hoverinfo = "text") %>% add_bars() %>% 
        layout(barmode = 'stack', 
               xaxis = list(title = "",
                            showgrid = F, showticklabels = F, zeroline = F),
               yaxis = list(title = "",
                            showgrid = F, showticklabels = F),
               legend = list(orientation = 'h', xanchor = "center", x = 0.5, y = 1)) %>%
        config(displayModeBar = F)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)


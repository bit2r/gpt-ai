library(shiny)
library(ggplot2)

# Load the Old Faithful dataset
data(faithful)

# Define UI
ui <- fluidPage(
  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$distPlot <- renderPlot({
    ggplot(faithful, aes(x = waiting)) +
      geom_histogram(bins = input$bins, fill = "steelblue", color = "white") +
      labs(title = "Histogram of waiting times",
           x = "Waiting time to next eruption (in mins)",
           y = "Frequency") +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5))
  })
}


# Run the application 
shinyApp(ui = ui, server = server)
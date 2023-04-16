#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(ggplot2)
fritos = read.csv('https://github.com/athibeaux/DS6306/raw/main/CaseStudy2_Thibeaux/CaseStudy2-data.csv', header = TRUE, fill = TRUE)


# Define UI for application that draws a scatterplot
ui <- fluidPage(
  
  # Application title
  titlePanel("Select Job Role to measure Job Level and Monthly Income"),
  
  # Sidebar with a Job Role input 
  sidebarLayout(
    sidebarPanel(
      selectInput("roles", "Select the Job Role", 
                  choices = c("Sales Executive" = "Sales Executive","Research Scientist" = "Research Scientist","Laboratory Technician" = "Laboratory Technician",
                              "Manufacturing Director" = "Manufacturing Director","Healthcare Representative" = "Healthcare Representative","Sales Representative" = "Sales Representative",
                              "Human Resources" = "Human Resources","Manager" = "Manager","Research Director" = "Research Director"), 
                  selected = c("Manager"), multiple = TRUE),
      
    ),
    
    # Show the generated scatterplot
    mainPanel(
      plotOutput("myplot")
    )
  )
)

# Define server logic required to filter by neighborhood
server <- function(input, output) {
  
  output$myplot <- renderPlot({
    
    fritos %>% filter(JobRole == {input$roles}) %>% ggplot(aes(JobLevel, MonthlyIncome, color = JobRole)) + geom_point() +
      geom_smooth(method = "lm") + 
      xlab("Job Level") + ylab("Monthly Income") +
      ggtitle("Job Level vs. Monthly Income")
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

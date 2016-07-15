rm(list=ls())

library(shiny)
library(ggplot2)
#library(dplyr)
library(sna)
library(network)
library(ergm)
library(GGally)
library(rsconnect)

load("data_to_plot_nets.RData")

ui <- fluidPage(
  #titlePanel("Sampson's Monk dataset"),
  sidebarLayout(
    sidebarPanel( 
      selectInput("dataset", "Choose a dataset", 
                  choices = c("Raw", "Imputed"),
                  selected="Raw"),
      selectInput("colors", "Color Respondents?", 
                  choices = c("No", "Yes"),
                  selected="No")
    ),
    mainPanel(
      plotOutput("net"),
      br(), br(), br(), br()
    )
  )
)

server <- function(input, output) {

  datasetInput <- reactive({
    switch(input$dataset,
           "Raw" = r0_net_no_isolates,
           "Imputed" = imp_to_plot_no_isolates
           ) 
  })
  
  output$net <- renderPlot(
    
    {
      if (input$colors == "No"){
        ggnet2(datasetInput(), size=2)
      } else
        ggnet2(datasetInput(), size=2, color="respondent", palette="Set2")
    }
    
    )
  
}

shinyApp(ui = ui, server = server)

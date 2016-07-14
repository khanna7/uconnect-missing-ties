rm(list=ls())

library(shiny)
library(ggplot2)
#library(dplyr)
library(sna)
library(network)
library(ergm)
library(GGally)

load("data_to_plot_nets.RData")

ui <- fluidPage(
  #titlePanel("Sampson's Monk dataset"),
  sidebarLayout(
    sidebarPanel( 
      selectInput("dataset", "Choose a dataset", 
                  choices = c("Raw", "Imputed"),
                  selected="Raw")
    ),
    mainPanel(
      plotOutput("net"),
      br(), br(), br(), br()
      #plotOutput("imp_to_plot")
     ## tableOutput("results")
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
  
  output$net <- renderPlot({
    #net_to_plot <- datasetInput()
    ggnet2(datasetInput(), size=1, color="respondent", 
          palette="Set2")
  })

}

shinyApp(ui = ui, server = server)

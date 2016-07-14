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
    ),
    mainPanel(
      plotOutput("raw_net"),
      br(), br(), br(), br(),
      plotOutput("imp_to_plot")
     ## tableOutput("results")
    )
  )
)

server <- function(input, output) {
  
    output$raw_net <- renderPlot({
      ggnet2(r0_net_no_isolates, size=1, color="respondent",
             palette="Set2")+
        ggtitle("Raw data")
    })
  
    output$imp_to_plot <- renderPlot({
      ggnet2(imp_to_plot_no_isolates, size=1, color="respondent",
             palette="Set2"
      )+ggtitle("Imputed data")    
    })
}

shinyApp(ui = ui, server = server)

rm(list=ls())

library(shiny)
library(ggplot2)
#library(dplyr)
library(sna)
library(network)
library(ergm)
library(GGally)
library(rsconnect)



set.seed(1234)
#####
load("organized_data_for_app.RData")

#####

ui <- fluidPage(
  #titlePanel("Sampson's Monk dataset"),
  sidebarLayout(
    sidebarPanel( 
      selectInput("dataset", "Choose a dataset", 
                  choices = c("Raw", "Imputed"),
                  selected="Raw"),
      selectInput("colors", "Color Respondents?", 
                  choices = c("No", "Yes"),
                  selected="No"),
      checkboxGroupInput("crit_nodes", "Select critical nodes?", 
                  choices = c("Betweenness", "Eigenvector",
                              "Bridges", "Keyplayer"),
                  selected=NULL)
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
           "Raw" = r0_net,
           "Imputed" = imp_to_plot
           ) 
  })
  
  output$net <- renderPlot(
    
    {
      if (input$colors == "No" && 
            (is.null(input$crit_nodes))){
        ggnet2(datasetInput(), size=2)
      } else {
        ggnet2(datasetInput(), size=2, color="respondent", palette="Set2")
    }
    if (input$crit_nodes == "None" || is.null(input$crit_nodes)){
      ggnet2(datasetInput(), size=2)
    } else if (input$crit_nodes == "Betweenness"){
      ggnet2(datasetInput(), size=2, color="btwn", palette="Set1")
    } else if (input$crit_nodes == "Eigenvector"){
      ggnet2(datasetInput(), size=2, color="evcent", palette="Set1")
    }
      else if (input$crit_nodes == "Bridges"){
      ggnet2(datasetInput(), size=2, color="bridge", palette="Set1")
    }
     else if (input$crit_nodes == "Keyplayer"){
      ggnet2(datasetInput(), size=2, color="kp", palette="Set1")
     }    
}
    )
}

shinyApp(ui = ui, server = server)

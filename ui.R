#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  #titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("survey","Select a survey",choices= c("Any")),
      selectInput("year","Select a year",choices= c("Any")),
      selectInput("quarter","Select a quarter",choices= c("Any")),
      selectInput("haul","Select a haul",choices= c("Any")),
      selectInput("species","Select a species",choices= c("Any")),
      selectInput("sex","Select a sex",choices= c("Any"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
    #  dataTableOutput("testTable")
    )
  )
))

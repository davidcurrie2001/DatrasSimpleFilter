#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(DATRAS)

# Add "Any" to a list if required
addAnyToList<-function(myList){
  
  if (length(myList)>1){
    myList<-c("Any", myList)
  } 
  else if (length(myList)==0){
    myList<-c("Any")
  }
  
  myList
  
}
  
# Format a column from CA into a list for the drop down filters
formatList<- function(myColumn){
  
  myNames <- as.character(CAdata[,myColumn])
  myList<-sort(unique(myNames))
  myList <- addAnyToList(myList)
}

DATRASdata <- readICES("data/DATRAS_Exchange_Data.csv" ,strict=TRUE)
CAdata <- DATRASdata[["CA"]]

# Create the lists for our drop-down filters
surveyList<-formatList("Survey")
yearList<-formatList("Year")
quarterList<-formatList("Quarter")
haulList<-formatList("HaulNo")
speciesList<-formatList("ScientificName_WoRMS")
sexList<-formatList("Sex")





# Define server logic required to draw a histogram
shinyServer(function(session,input, output) {
   
  updateSelectInput(session, "survey", label = NULL, choices = surveyList, selected = NULL)
  updateSelectInput(session, "year", label = NULL, choices = yearList, selected = NULL)
  updateSelectInput(session, "quarter", label = NULL, choices = quarterList, selected = NULL)
  updateSelectInput(session, "haul", label = NULL, choices = haulList, selected = NULL)
  updateSelectInput(session, "species", label = NULL, choices = speciesList, selected = NULL)
  updateSelectInput(session, "sex", label = NULL, choices = sexList, selected = NULL)

  
})

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

DefaultText <- "Any"

# Add "Any" to a list if required
addAnyToList<-function(myList){
  
  if (length(myList)>1){
    myList<-c(DefaultText, myList)
  } 
  else if (length(myList)==0){
    myList<-c(DefaultText)
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



shinyServer(function(session,input, output) {
   
  updateSelectInput(session, "survey", label = NULL, choices = surveyList, selected = NULL)
  updateSelectInput(session, "year", label = NULL, choices = yearList, selected = NULL)
  updateSelectInput(session, "quarter", label = NULL, choices = quarterList, selected = NULL)
  updateSelectInput(session, "haul", label = NULL, choices = haulList, selected = NULL)
  updateSelectInput(session, "species", label = NULL, choices = speciesList, selected = NULL)
  updateSelectInput(session, "sex", label = NULL, choices = sexList, selected = NULL)

  
  FilterSummaryData<-function(selectedSurvey,selectedYear,selectedQuarter,selectedHaul,selectedSpecies,selectedSex){
    
    # Filter the data using the selected values
    filteredData <- DATRASdata
    
    #selectedSpecies<- "Gadus morhua"
    
    if (selectedSurvey != DefaultText){
      filteredData <- subset.DATRASraw(filteredData, Survey==selectedSurvey)
    }
    
    if (selectedYear != DefaultText){
      filteredData <- subset.DATRASraw(filteredData, Year==selectedYear)
    }
    
    if (selectedQuarter != DefaultText){
      filteredData <- subset.DATRASraw(filteredData, Quarter==selectedQuarter)
    }
    
    if (selectedHaul != DefaultText){
      filteredData <- subset.DATRASraw(filteredData, HaulNo==selectedHaul)
    }
    
    if (selectedSpecies != DefaultText){
      filteredData <- subset.DATRASraw(filteredData, Species==selectedSpecies)
    }
    
    if (selectedSex != DefaultText){
      filteredData <- subset.DATRASraw(filteredData, Sex==selectedSex)
    }
    

    filteredData
    
  }
  
  
  # handle drop down list filters
  observe({
    
    
    selectedSurvey <- input$survey
    selectedYear <- input$year
    selectedQuarter <- input$quarter
    selectedHaul <- input$haul
    selectedSpecies <- input$species
    selectedSex <- input$sex
    
    # Store the filter values in a data frame
    myFilters <- data.frame("Survey" = selectedSurvey, "Year" = selectedYear, "Quarter" = selectedQuarter, "HaulNo" = selectedHaul,  "ScientificName_WoRMS" =  selectedSpecies,  "Sex" =  selectedSex)
    
    filteredData <- FilterSummaryData(selectedSurvey,selectedYear,selectedQuarter,selectedHaul,selectedSpecies,selectedSex)
    
    
    print(paste("Number of records in HH:",nrow(filteredData[["HH"]])))
    print(paste("Number of records in HL:",nrow(filteredData[["HL"]])))
    print(paste("Number of records in CA:",nrow(filteredData[["CA"]])))
    
    # save the data
    
    #saveRDS(filteredData,file = "data/filteredData.rds")
    write.csv(myFilters, file = "data/myFilters.csv")
    
    #CAdata<-currentData[["CA"]]
      
      
  })
  
  # output$testTable <- renderDataTable({
  #   
  #   selectedSurvey <- input$survey
  #   selectedYear <- input$year
  #   selectedQuarter <- input$quarter
  #   selectedHaul <- input$haul
  #   selectedSpecies <- input$species
  #   selectedSex <- input$sex
  #   
  #   filteredData <- FilterSummaryData(selectedSurvey,selectedYear,selectedQuarter,selectedHaul,selectedSpecies,selectedSex)
  #   
  #   tempCA<- filteredData[["CA"]]
  #   tempCA[,c("Survey","Year","Quarter","HaulNo","ScientificName_WoRMS","Sex")]
  # })
  
  
  
})

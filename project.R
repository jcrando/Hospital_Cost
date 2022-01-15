library('shinydashboard')
library(tidyverse)
library(plotly)
library(leaflet)

hospitals=read_rds('map_and_hospitals.rds')
hospitals= relocate(hospitals, Latitude,.after = Longitude) 


area_list= c('County','City','Zip Code','Hospital Name')
procedure= hospitals %>% 
              select(HCPCS_DESCRIPTION)


header= dashboardHeader()

sidebar= dashboardSidebar(
  selectInput(
    inputId = 'area',
    label= 'Area',
    choices= area_list),
    
 ## uiOutput('moreControls'),
  
selectInput(
    inputId = 'procedure',
    label= 'Procedure',
    choices= procedure)
  )



body= dashboardBody(fluidPage(
  leafletOutput('mymap'),
  p(),
  actionButton('recal', 'New points')
))

ui= dashboardPage(header, sidebar, body)



#hospitalIcon= icons('clipart-hospital-hospital-building-6.png', 
#                    iconWidth = 10, iconHeight = 15,
#                    iconAnchorX = 22, iconAnchorY = 94)
  

server= function(input, output, session) {
  output$value <- reactive({ input$select })
  
  ##output$moreControls= renderUI({
    ##tagList(
      ##selectInput(
        ##inputId= 'city',
        ##label= 'City',
        ##choices= c()
##     )
##    )
##  })
  

  points <- eventReactive(input$recalc, {
    cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
  }, ignoreNULL = FALSE)
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addMarkers(data = hospitals, 
                 label = (hospitals$`Hospital Name`))
                 #icon = hospitalIcon )
  })
}
shiny:: shinyApp(ui, server)


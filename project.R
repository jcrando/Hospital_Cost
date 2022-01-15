library('shinydashboard')
library(tidyverse)
library(plotly)
library(leaflet)

hospitals=read_rds('map_and_hospitals.rds')
hospitals= relocate(hospitals, Latitude,.after = Longitude) 


area_list= hospitals %>% 
  select(County,City,`Zip Code`,`Hospital Name`)

header= dashboardHeader()

sidebar= dashboardSidebar(
  selectInput(
    inputId = 'area',
    label= 'Area',
    choices= area_list,
    
    selectInput(
      inputId= 'city',
      label= 'City',
      choices= c()
    )
  )
)


body= dashboardBody(fluidPage(
  leafletOutput('mymap'),
  p(),
  actionButton('recal', 'New points')
))

ui= dashboardPage(header, sidebar, body)

  

server= function(input, output, session) {
  output$value <- reactive({ input$select })
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
  })
}
shiny:: shinyApp(ui, server)


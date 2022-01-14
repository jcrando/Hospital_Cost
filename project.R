library('shinydashboard')
library(tidyverse)
library(plotly)
library(leaflet)

hospitals=read_rds('map_and_hospitals.rds')


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


body= dashboardBody()

ui= dashboardPage(header, sidebar, body)

server= function(input, output) {
  output$value <- reactive({ input$select })
}
shiny:: shinyApp(ui, server)


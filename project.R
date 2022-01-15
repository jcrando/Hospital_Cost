library('shinydashboard')
library(tidyverse)
library(plotly)
library(leaflet)

hospitals=read_rds('map_and_hospitals.rds')
hospitals= relocate(hospitals, Latitude,.after = Longitude) 
hospitals= hospitals %>% 
  mutate(contentbox= paste(hospitals$`Hospital Name`, '</br>',  hospitals$Address, '</br>', hospitals$`(sum(TOTAL_SERVICES * AVG_MEDICARE_PAYMENT)/(sum(TOTAL_SERVICES)))`))


hospitalIcon= makeIcon(iconUrl = 'clipart-hospital-hospital-building-6.png', 
                       iconWidth = 35, iconHeight = 35)#,
                       #iconAnchorX = 22, iconAnchorY = 94)



area_list= hospitals %>% 
  select(County,City,`Zip Code`,`Hospital Name`)

procedure= hospitals %>% 
              select(HCPCS_DESCRIPTION)


header= dashboardHeader()

sidebar= dashboardSidebar(
  selectInput(
    inputId = 'area',
    label= 'County, City, Zip, or Hospital',
    choices= area_list,
    selected= 'DAVIDSON'),
  
    
 ## uiOutput('secondary_drop_down'),
  
selectInput(
    inputId = 'procedure',
    label= 'Procedure',
    choices= procedure,
    selected= 'URINALYSIS, MANUAL TEST')
  )



body= dashboardBody(fluidPage(
  leafletOutput('mymap'),
####  p(),
#### actionButton('recal', 'New points')
))

ui= dashboardPage(header, sidebar, body)





server= function(input, output, session) {
 ##### output$value <- reactive({ input$select })
  
  ##output$secondary_drop_down= renderUI({
    ##tagList(
      ##selectInput(
        ##inputId= 'city',
        ##label= 'City',
        ##choices= c()
##     )
##    )
##  })
  

  ###output$value <- reactive({ input$select })###
  ### points <- eventReactive(input$recalc, { ###
  ###   cbind(rnorm(40) * 2 + 13, rnorm(40) + 48) ###
  ###  }, ignoreNULL = FALSE)###
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addTiles(group = 'Open Street Map'
      ) %>%
      addMarkers(data = hospitals %>% 
                   filter(County== input$area | 
                          City==input$area |
                          `Zip Code`== input$area |
                            `Hospital Name`== input$area) %>% 
                            filter(HCPCS_DESCRIPTION== input$procedure), 
                     popup =  ~contentbox,
                 icon = hospitalIcon)
  })
}
shiny:: shinyApp(ui, server)


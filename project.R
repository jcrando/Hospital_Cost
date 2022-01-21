library('shinydashboard')
library(tidyverse)
library(leaflet)
library(plotly)

hospitals=read_rds('maps_and_hospitals.rds')
hospitals= relocate(hospitals, Latitude,.after = Longitude)

hospitals= 
  mutate(hospitals, mean_col=round(`mean(AVG_MEDICARE_STANDARIZED_AMOUNT)`, 2)) 

hospitals$Price= paste0('$', hospitals$mean_col)

hospitals= hospitals %>% 
  mutate(contentbox= paste(hospitals$`Hospital Name`, '</br>',  hospitals$Address, '</br>', hospitals$Price))


hospitalIcon= makeIcon(iconUrl = 'clipart-hospital-hospital-building-6.png', 
                       iconWidth = 35, iconHeight = 35) # if needed, reinsert ____ here

hospitals= 
  rename(hospitals, Cost=mean_col)






procedure= hospitals %>% 
  select(HCPCS_DESCRIPTION)

group= c('County', 'City', 'Zip Code', 'Hospital Name')


header= dashboardHeader()

sidebar= dashboardSidebar(
  selectInput(
    inputId = 'Group',
    label= 'County, City, Zip, or Hospital',
    choices= group,
    selected= 'City'),
  
  
  uiOutput('selector'),
  
  selectInput(
    inputId = 'procedure',
    label= 'Procedure',
    choices= procedure,
    selected= procedure)
)



body= dashboardBody(fluidPage(
  leafletOutput('mymap'),
  ####  p(),
  #### actionButton('recal', 'New points')
  
  plotlyOutput('myplot'),
  
  
  
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
  
  output$selector= renderUI({
    
    default= c('County'= 'DAVIDSON', 'City'= 'NASHVILLE', 'Zip Code'= '37211', 'Hospital Name'='VANDERBILT UNIVERSITY MEDICAL CENTER')
    
    area_list=hospitals %>% 
      pull(input$Group) %>% 
      sort()
    
    
    selectInput(
      inputId = 'area',
      label= 'County, City, Zip, or Hospital',
      choices= area_list,
      selected= 1)
  })
  
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
  
  
  output$myplot= renderPlotly({
    
    hospitals %>% 
      filter(County== input$area  | 
               City==input$area |
               `Zip Code`== input$area |
               `Hospital Name`== input$area) %>% 
      filter(HCPCS_DESCRIPTION== input$procedure) %>% 
      mutate(`Hospital Name`= factor(`Hospital Name`) %>% 
               fct_reorder(Cost, .desc = TRUE)) %>% 
      ggplot(aes(x=`Hospital Name`, y=Cost, fill=`Street Address`))+
      geom_bar(stat='summary',fun= 'mean')+
      coord_flip()+
      ggtitle('Cost at Hospital')+
      labs(x= '', y='')+
      theme (legend.position = "none")+
      scale_y_continuous(labels=scales::dollar_format())+
      scale_color_grey()
    
    
  })}

shiny:: shinyApp(ui, server)


# Define UI
ui <- fluidPage(
  
  #Navbar structure for UI
  navbarPage("Hospital Cost", theme = shinytheme("lumen"),
             tabPanel("Program Finder", fluid = TRUE, icon = icon("globe-americas"),
                      #tags$style(button_color_css),
                      # Sidebar layout with a input and output definitions
                      sidebarLayout(
                        sidebarPanel(
                          
                          titlePanel("Desired Program Characteristics"),
                          #shinythemes::themeSelector(),
                          fluidRow(column(3,
                                          
                                          # Select which Gender(s) to plot
                                          checkboxGroupInput(inputId = "GenderFinder",
                                                             label = "Select Gender(s):",
                                                             choices = c("Male" = "M", "Female" = "F"),
                                                             selected = "M"),
                                          
                                          # Select which Division(s) to plot
                                          checkboxGroupInput(inputId = "DivisionFinder",
                                                             label = "Select Division(s):",
                                                             choices = c("DI", "DII", "DIII"),
                                                             selected = "DI")
                          ),
                          column(6, offset = 2,
                                 # Select which Region(s) to plot
                                 checkboxGroupInput(inputId = "RegionFinder",
                                                    label = "Select Region(s):",
                                                    choices = c("New England" = "NewEngland", "Mid Atlantic" = "MidAtlantic", "Mid West" = "MidWest", "South", "West", "South West" = "SouthWest", "Pacific", "Alaska", "Hawaii"),
                                                    selected = "NewEngland")
                          )),
                         
                          # Set Time Range
                          fluidRow(column(5,
                                          textInput(inputId = "TimeFinderMin",
                                                    label = "From:",
                                                    value = "19.00",
                                                    width = "100px")
                          ),
                          column(5, ofset = 3,
                                 textInput(inputId = "TimeFinderMax",
                                           label = "To:",
                                           value = "22.00",
                                           width = "100px")
                          )),
                          helpText("Format example: 1:39.99"),
                          actionButton(inputId = "EnterTimes", label = "Enter Times"),
                          hr(),
                          sliderInput(inputId = "RankOnTeam",
                                      label = "Select Swimmer Rank On Team",
                                      min = 1,
                                      max = 10,
                                      value = c(1,6),
                                      width = "220px"),
                          helpText("For example: Find 1st fastest through 6th fastest athletes on a given team"),
                          hr(),
                          titlePanel("School Characteristics"),
                          # Select which School Type to plot
                          checkboxGroupInput(inputId = "School_TypeFinder",
                                             label = "Select School Type(s):",
                                             choices = c("National University", "Regional University", "National Liberal Arts College", "Regional College"),
                                             selected = c("National University", "Regional University", "National Liberal Arts College", "Regional College")),
                          
                          sliderInput(inputId = "School_RankFinder",
                                      label = "School Rank",
                                      min = 1,
                                      max = 250,
                                      value = c(1,250),
                                      width = "220px")
                        ),
                        mainPanel(
                          fluidRow(
                            
                            ))
                        
                      )
             )
             
            
                        )
             )
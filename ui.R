library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Say Their Names"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            dateRangeInput("daterange",
                        "Select Date Range",
                        start = "2013-01-01",
                        min = "2013-01-01",
                        end = "2021-05-15",
                        max = "2021-05-15",
                        format = "mm/dd/yyyy",
                        separator = " - "),
           
             checkboxGroupInput("race", "Select race/ethnicity",c("Black","White","Hispanic","Asian"
                                                                  ,"Native American","Pacific Islander"
                                                                  ,"Asian/Pacific Islander","Unknown Race")
                                ,selected = c("Black","White","Hispanic","Asian"
                                              ,"Native American","Pacific Islander"
                                              ,"Asian/Pacific Islander","Unknown Race")),
            checkboxGroupInput("gender", "Select gender:",c("Male","Female","Transgender","Unknown")
                               ,selected = c("Male","Female","Transgender","Unknown")),
            checkboxGroupInput("armed", "Select armed status:",c("Allegedly Armed"
                                                                 ,"Unarmed/Did Not Have Actual Weapon"
                                                                 ,"Vehicle")
                               ,selected = c("Allegedly Armed","Unarmed/Did Not Have Actual Weapon"
                                        ,"Vehicle"))
            
        ),
        
            
        

        
        mainPanel(
            leafletOutput("map"),
            plotlyOutput("plot")
        )
    )
))

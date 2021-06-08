library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    theme = bslib::bs_theme(bootswatch = "darkly"),
    titlePanel("Say Their Names"),

    sidebarLayout(
        sidebarPanel(width = 3,
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
            leafletOutput("map"))),
        
        navlistPanel(
            "Visualizations of Tracking Quotient",
            tabPanel( title = "Log Plot",
                plotlyOutput("plotlog")),
            tabPanel( title = "Regular Plot",
                plotlyOutput("plot")),
            tabPanel( title = "Histogram",
                plotlyOutput("hist"))
        )
    
))

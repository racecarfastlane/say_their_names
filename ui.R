library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    theme = bslib::bs_theme(bootswatch = "darkly"),
    titlePanel("Say Their Names"),

    sidebarLayout(
        sidebarPanel(width = 3,
            dateRangeInput("daterange",
                        "Select Date Range",
                        start = "2020-01-01",
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
            h4("Traction Quotient", align = "left"),
            h5("The Traction Quotient is a factor that determines how much an event is in the media zeitgeist.", align = "left"),   
            h5("It measures the sum of the log of days each article’s publishing date is from the event.", align = "left"),
            h5("",align = "left"),
            h5("TQ = (log(ad1-doi+1)+log(ad2-doi+1)...)",align = "left"),
            leafletOutput("map"))),
            fluidRow(
                column(8,align = "center",offset = 3,
                plotlyOutput("plot")))
        
    
))

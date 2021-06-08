shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })
    
    points <- eventReactive(input$recalc, {
        cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
    }, ignoreNULL = FALSE)
    
    victimIconsiter <- (
    for (x in seq_along(reactiveMain()$victim)) {
        victimIconsiter <- reactiveMain()$URL.of.image.of.victim
    })
         
    
    victimIcons <- icons(
        iconUrl = victimIconsiter,
                         #$URL.of.image.of.victim,
        iconWidth = 28, iconHeight = 28
    )
    
    output$map <- renderLeaflet({
        validate(
            need(input$race, 'Check at least one race'),
            need(input$gender, 'Check at least one gender'),
            need(input$armed, 'Check at least one armed status'))
        
        
        leaflet(reactiveMain()) %>%
            setView(lng = -96,lat =  37.8, zoom = 4)%>%
            addProviderTiles("CartoDB.Positron", 
                             options = providerTileOptions(noWrap = TRUE))%>%
            addMarkers(lng = ~Longitude, lat = ~Latitude, icon = victimIcons,
                       popup = ~as.character(victim), label = ~as.character(victim))
    })
    
    reactiveMain <- reactive({
            victims_sq_demo_unique %>% 
            filter(doi>=input$daterange[1] & doi<input$daterange[2])%>%
            filter(victim_race %in% input$race)%>%
            filter(victim_gender %in% input$gender)%>%
            filter(Armed.Unarmed.Status %in% input$armed)
        })
    
    
    output$plot <- renderPlotly({
        
        validate(
            need(input$race, 'Check at least one race'),
            need(input$gender, 'Check at least one gender'),
            need(input$armed, 'Check at least one armed status'))
        
        line <- ggplot(reactiveMain(), aes(x = doi,y=sq))+
            geom_line(size=1.25)+
            xlab("Date")+
            ylab("SQ")+
            labs(color = "SQ")+
            scale_x_date(date_labels = "%m-%Y")+
            geom_hline(yintercept=mean(reactiveMain()$sq), linetype='dotted', col = 'red')
    })
})
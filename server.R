shinyServer(function(input, output) {


    points <- eventReactive(input$recalc, {
        cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
    }, ignoreNULL = FALSE)
    

    
    output$map <- renderLeaflet({
        
        validate(
            need(input$race, 'Check at least one race'),
            need(input$gender, 'Check at least one gender'),
            need(input$daterange, 'Both dates in range must be selected'),
            need(input$armed, 'Check at least one armed status'))
        
        
        leaflet(reactiveMain()) %>%
            setView(lng = -96,lat =  37.8, zoom = 4)%>%
            addProviderTiles("CartoDB.Positron", 
                             options = providerTileOptions(noWrap = TRUE))%>%
            addMarkers(lng = ~Longitude, lat = ~Latitude,
                       popup = paste ("<img src = ", reactiveMain()$URL.of.image.of.victim, " width = 300>", "<br>",
                                      "Name: ", reactiveMain()$victim, "<br>",
                                      "Age: ", reactiveMain()$victim_age, "<br>",
                                      "Gender: ",reactiveMain()$victim_gender,"<br>",
                                      "Race: ",reactiveMain()$victim_race,"<br>",
                                      "DOI: ",reactiveMain()$doi,"<br>",
                                      "TQ: ",reactiveMain()$sq,"<br>",
                                      '<a href =', reactiveMain()$link, '>Additional Reading</a>',"<br>",
                                      reactiveMain()$description)
                       , label = ~as.character(victim))
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
            need(input$daterange, 'Both dates in range must be selected'),
            need(input$armed, 'Check at least one armed status'))

        plot <- ggplot(reactiveMain(), aes(x = doi,y=sq))+
            geom_point(size=1.25)+
            xlab("Date")+
            ylab("SQ")+
            labs(color = "SQ")+
            scale_x_date(date_labels = "%m-%Y")+
            geom_hline(yintercept=mean(reactiveMain()$sq), linetype='dotted', col = 'red')
    })
    
    output$hist <- renderPlotly({
        
        validate(
            need(input$race, 'Check at least one race'),
            need(input$gender, 'Check at least one gender'),
            need(input$daterange, 'Both dates in range must be selected'),
            need(input$armed, 'Check at least one armed status'))
        
        hist <- ggplot(reactiveMain(), aes(x = log10(sq)))+
        geom_histogram()
    })
    
    
    output$plotlog <- renderPlotly({
        
        validate(
            need(input$race, 'Check at least one race'),
            need(input$gender, 'Check at least one gender'),
            need(input$daterange, 'Both dates in range must be selected'),
            need(input$armed, 'Check at least one armed status'))
        
        plotlog <- ggplot(reactiveMain(), aes(x = doi,y=log10(sq)))+
            geom_point(size=1.25)+
            xlab("Date")+
            ylab("SQ")+
            labs(color = "SQ")+
            scale_x_date(date_labels = "%m-%Y")+
            geom_hline(yintercept=mean(reactiveMain()$sq), linetype='dotted', col = 'red')
        
    })
})
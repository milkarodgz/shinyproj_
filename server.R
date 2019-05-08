shinyServer(function(input, output) {
  output$mymap <- renderLeaflet({
    df1 %>%
      filter(BOROUGH == input$borough) %>%
      leaflet(.) %>%
      addTiles() %>%
      addMarkers(
        lng = ~ LONGITUDE,
        lat = ~ LATITUDE,
        clusterOptions = markerClusterOptions()
      )
  })
  
  output$maxBox <- renderInfoBox({
    info = df1 %>%
      filter(BOROUGH == input$borough) %>%
      group_by(ZIP.CODE) %>%
      summarise(num_accidents = n()) %>%
      arrange(desc(num_accidents)) %>%
      top_n(1)
    infoBox(
      paste("Zipcode:", info$ZIP.CODE),
      paste("Accidents:", info$num_accidents),
      icon = icon("car-crash"),
      fill = TRUE
    )
    
  })
  
  output$minBox <- renderInfoBox({
    info2 = df1 %>%
      filter(BOROUGH == input$borough) %>%
      group_by(ZIP.CODE) %>%
      summarise(num_accidents = n()) %>%
      top_n(-1, num_accidents)
    infoBox(
      paste("zipcode:", info2$ZIP.CODE),
      paste("Accidents:", info2$num_accidents),
      icon = icon("search-minus"),
      fill = TRUE
    )
  })
  ################
  output$zmap <- renderLeaflet({
    
    shinyshape <-shapemap()
 #maybe I can add the column zipcode as a list 
  
    subdf1 <- df1 %>%
      mutate(ZIPCODE = ZIP.CODE) %>%
      group_by(ZIPCODE) %>%
      summarise(num_accidents = n()) %>%
      mutate_at(vars(ZIPCODE), as.factor)
    
    shinyshape@data <- shinyshape@data %>%
      full_join(subdf1, by = 'ZIPCODE')
    
    pal <-
      colorBin("YlOrRd",
               domain = shinyshape$num_accidents,
               bins = 7)
    
    # labels <- sprintf('%s: %g', m$ZIPCODE, m$Total) %>%
    #  lapply(htmltools::HTML)
    #
    leaflet(shinyshape) %>%
      addTiles() %>%
      addPolygons(
        fillColor = ~ pal(num_accidents) ,
        weight = 1,
        opacity = 1,
        color = ~ pal(num_accidents),
        dashArray = '3',
        fillOpacity = 0.5,
        popup = ~ paste(
          '<b>Zip Code:</b>',
          shinyshape@data$ZIPCODE ,
          '<br>',
          '<b>Count: </b>',
          shinyshape$num_accidents,
          '<br>'
        ),
        highlight = highlightOptions(
          weight = 3,
          color = ~ pal(num_accidents),
          dashArray = '',
          fillOpacity = 0.2,
          bringToFront = TRUE
        )
      ) %>%
      addLegend(
        position = 'bottomright',
        pal = pal,
        values = ~ num_accidents,
        title = 'Accidents per Zip Code',
        opacity = 1
      )
  })
  
  #################
  output$table <- DT::renderDataTable({
    datatable(df2, rownames = FALSE) %>%
      formatStyle(input$selected,
                  background = "skyblue",
                  fontWeight = 'bold')
  })
  
  })
  


  









# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  
  
  
  
  server = function (input,output){
    output$summaryDset <- renderPrint({
      print(summary(NFTitles)) 
    })}
  
  
  # type Output plot and table
  output$type <- renderPlot(
    T_by_type %>%
      ggplot() + geom_col(aes(x = type, y = count, fill = type)) +
      labs(title = "Netflix Titles By Type",
           caption = 'Data Source: Kaggle') +  xlab("Type") 
    + ylab("Count") + theme_classic()
  )
  
  output$type_table <- renderDataTable({T_by_type})
  
  # Genres Output plot and table
  
  output$genrestop <- renderPlot(
    T_by_listedin %>% arrange(desc(count)) %>%head(20) %>%
      ggplot() + geom_col(aes( x = count , y =reorder(listed_in, count))) +
      labs(title = 'Top 20 Genre of Titles',
           x = 'Number of Titles',
           y = 'Genre') + theme_classic()  + xlim(0, 3000)
  )
  
  output$genresleast <- renderPlot(
    T_by_listedin %>% arrange((count)) %>%head(20) %>%
      ggplot() + geom_col(aes( x = count , y =reorder(listed_in, count))) +
      labs(title = 'Least 20 Genre of Titles',
           x = 'Number of Titles',
           y = 'Genre') + theme_classic()  + xlim(0, 40)
  )
  

  
  output$genres_table <- renderDataTable({T_by_listedin %>% arrange(desc(count))})
  
  
  # Country Output plot and table
  
  output$country <- renderPlotly(
    fig <- plot_ly(CountriesFinal, x = CountriesFinal$country, y = ~movie_count, type = 'bar', name = 'Movie')
    %>% add_trace(y = ~tvshow_count, name = 'TV Show') 
    %>% layout(xaxis=list(categoryorder = "array", categoryarray = CountriesFinal$country, title="Country"), yaxis = list(title = 'Amount of content'), barmode = 'stack', title = 'top 10 countries by produced contetnt ( Movies )')
    
  )
  
  output$country_table <- renderDataTable({CountriesFinal})
  
  
  # Year Output plot and table
  
  output$year <- renderPlotly(
    fig <- plot_ly(T_by_date, x = ~date_added, y = ~total_number_of_content, color = ~type, type = 'scatter', mode = 'lines', colors=c("#bd3939",  "#9addbd", "#399ba3")) 
    %>% layout(yaxis = list(title = 'Total Count'), xaxis = list(title = 'Year',nticks=8), title="Amount of Content by Time") 
    
    
  )
  
  output$year_table <- renderDataTable({T_by_date})
  
  
  # Rating Output plot and table
  
  output$rating <- renderPlotly(
    figure3 <- plot_ly(RatingsFinal, x = ~rating, y = ~movie_count, type = 'bar', name = 'Movie')
    %>% add_trace(y = ~tvshow_count, name = 'TV Show')
    %>% layout(yaxis = list(title = 'Total Count'),
                                  xaxis = list(title = 'Rating'),
                                  barmode = 'stack', 
                                  title="Content By Rating (Movie and TV Show)")
    
    
  )
  
  output$rating_table <- renderDataTable({RatingsFinal})
  
  
  # Movies duration Output plot and table
  
  output$duration_movies <- renderPlotly(
    fig <- plot_ly(DurationCountryFinalM_subset, y = ~duration, color = ~country, type = "box")
    %>% layout(xaxis=list(title="Country"), yaxis = list(title = 'Duration (in min)'), 
                            title="Box-Plots Of Movie Duration In Top 11 Countries")
    
    
    
  )
  
  output$duration_movies_table <- renderDataTable({DurationCountryFinalM})
  
  
  # SPI Output plot and table
  
  output$SPI_1 <- renderPlotly(
    figure5 <- plot_ly(sk_ta_df_tv %>% group_by(duration) %>% summarise(count = n()), x = ~duration, y = ~count, type = 'bar')
    %>% layout(yaxis = list(title = 'Total Count'),
                                 xaxis = list(title = 'Number Of Seasons'),
                                 barmode = 'stack', 
                                 title="TV shows duration in South Korea and Taiwan")
    
    
  )
  
  output$SPI_1_table <- renderDataTable({sk_ta_df_tv})
  
  
  

})

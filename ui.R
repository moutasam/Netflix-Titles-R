


library(shinydashboard)




dashboardPage(
  dashboardHeader(title='Netflix Titles EDA'),
  dashboardSidebar(
    sidebarUserPanel("Netflix Titles",
                     image = 'netflix.png' ),
    sidebarMenu(
      menuItem("By Type", tabName = "Type", icon = icon("file")),
      menuItem("By Country", tabName = "Country", icon = icon("map-marker")),
      menuItem("By Genere", tabName = "Genre", icon = icon("database")),
      menuItem("By Time", tabName = "Time", icon = icon("calendar")),
      menuItem("By Duration", tabName = "Duration", icon = icon("eye")),
      menuItem("By Rating", tabName = "Rating", icon = icon("bars")),
      menuItem("Special Investiagation", tabName = "SPI", icon = icon("lightbulb-o")),
      menuItem("Recommendations & Future", tabName = "RF", icon = icon("book"))
    ),
    
     selectizeInput("dataset", "Choose Data set",
                   choices="NetflixTitle.csv")
  ),
  
  dashboardBody(
    tabItems(
    tabItem(tabName = "Type",tabsetPanel(
               tabsetPanel(
                 tabPanel("Plot",
                          fluidRow(
                            column(width = 12,
                                   plotOutput("type") 
                            )
                          )
                 ),
                 tabPanel("Table",
                          fluidRow(
                            column(width = 12,
                                   dataTableOutput("type_table") 
                            ) 
                          )
                 )
               ))),
    tabItem(tabName = "Genre",tabsetPanel(
      tabsetPanel(
        tabPanel("Plot",
                 fluidRow(
                   column(10, plotOutput("genrestop")),
                   column(10, plotOutput("genresleast") 
                   )
                 )
        ),
        tabPanel("Table",
                 fluidRow(
                   column(width = 12,
                          dataTableOutput("genres_table") 
                   ) 
                 )
        )
      ))),
    
    tabItem(tabName = "Country",tabsetPanel(
      tabsetPanel(
        tabPanel("Plot",
                 fluidRow(
                   column(width = 12,
                          plotlyOutput("country") 
                   )
                 )
        ),
        tabPanel("Table",
                 fluidRow(
                   column(width = 12,
                          dataTableOutput("country_table") 
                   ) 
                 )
        )
      ))),
    
    tabItem(tabName = "Time",tabsetPanel(
      tabsetPanel(
        tabPanel("Plot",
                 fluidRow(
                   column(width = 12,
                          plotlyOutput("year") 
                   )
                 )
        ),
        tabPanel("Table",
                 fluidRow(
                   column(width = 12,
                          dataTableOutput("year_table") 
                   ) 
                 )
        )
      ))),
    
    tabItem(tabName = "Rating",tabsetPanel(
      tabsetPanel(
        tabPanel("Plot",
                 fluidRow(
                   column(width = 12,
                          plotlyOutput("rating") 
                   )
                 )
        ),
        tabPanel("Table",
                 fluidRow(
                   column(width = 12,
                          dataTableOutput("rating_table") 
                   ) 
                 )
        )
      ))),
    
    tabItem(tabName = "Duration",tabsetPanel(
      tabsetPanel(
        tabPanel("Plot",
                 fluidRow(
                   column(width = 12,
                          plotlyOutput("duration_movies") 
                   )
                 )
        ),
        tabPanel("Table",
                 fluidRow(
                   column(width = 12,
                          dataTableOutput("duration_movies_table") 
                   ) 
                 )
        )
      ))) ,
    
    tabItem(tabName = "SPI",tabsetPanel(
      tabsetPanel(
        tabPanel("Plot",
                 fluidRow(
                   column(width = 12,
                          plotlyOutput("SPI_1") 
                   )
                 )
        ),
        tabPanel("Table",
                 fluidRow(
                   column(width = 12,
                          dataTableOutput("SPI_1_table") 
                   ) 
                 )
        )
      ))) ,
    
    tabItem(tabName = "RF",tabsetPanel(
      tabsetPanel(
        tabPanel("Findings & Recommendation",h1("Findings"),
                 h4("1. Movies produced are more than double tv shows"),
                 h4("2. We see that International Movies / TV Shows are showing up as the dominant category in both Movies and TV Shows, followed by Dramas and Comedies."),
                 h4("3. The least desired genres in movies are :  LGBTQ , Sports and Sci-fi & Fantasy ."),
                 h4("4. The least desired genres in tv-shows are : Classic and Culture ,|Stand-up comedy and Sci-Fi and Fanatsy."),
                 h4("5. The United States is the leading country by content production followed by India then United Kingdom ."),
                 h4("6. Japan , South Korea ,Taiwan and Singapore are producing more Tv-shows than Movies."),
                 h4("7. 2016 was the year that production took-off exponentially , with Movies producing at almost 2x the Tv-Shows ."),
                 h4("8. Most produced contetnt are TV-MA rated , then TV-14."),
                 h4("9. India have the longest avg movie duration (127 min) , then South Korea (111 min) ,then Taiwan (106 min)."),
                 h4("10 . Most TV Shows (90%) in South Korea and Taiwan tend to be short (1 season only) ."),
                 h1("Recommendation"),
                 h4("Regarding far east countries , especially Sout Korea and Taiwan it might be better to produce shorter Movies since 
                    the production is concentrating on mostly Tv-Shows with short duration (only one season).")
                 
        ),
        tabPanel("Future Work",h4("Integrate the current dataset with IMDB or Rotten Tomatoes and add more attributes to the research and analysis like (User and Critics Ratings)."),
                  h4("Try to model the system into and create a prediction system using ML and maybe regression")
                 
                 )
      )
    )
    )
    
    
    
    
    
    )
  )
)

      

  
  
  
  
#   
#   dashboardBody(
#     tabItems(
#       tabItem(tabName = "Type", plotOutput("type")),
#       tabItem(tabName = "Genre",fluidRow(
#         column(10, plotOutput("genrestop")),
#         column(10, plotOutput("genresleast")) 
#       )
#       )
#     )
#   )
# )

     
  
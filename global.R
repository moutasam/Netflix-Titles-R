library(shiny)
library(ggplot2)
library(ggthemes)
library(forcats)
library(extrafont)
library(plotly)
library(dplyr)
library(tidytext)
library(tidyr)
library(stringr)
library(data.table)



NFTitles <- read.csv(file ='netflix_titles.csv', na.strings=c("","NA"))

NFTitles = subset(NFTitles, select = -c(show_id, description) )


# drop any duplicate values
NFTitles=distinct(NFTitles,title,country,type,release_year, .keep_all= TRUE)

# delete unwanted rating values

NFTitles = filter(NFTitles, !(rating %in% c("66 min", "74 min","84 min")))

# groupong titles by type : movies or tv shows

T_by_type <- NFTitles %>% group_by(type) %>% summarise(count = n())

# split all listed in types and count all of them seperatley

T_by_listedin <-  NFTitles %>% select(listed_in) %>%
  mutate(listed_in = str_split(listed_in,',')) %>%
  unnest(listed_in) %>% group_by(listed_in) %>% summarise(count = n()) 

# analysis by country 

# creates a country list
CountryLst <- strsplit(NFTitles$country, split = ", ")

# over ride dyplr group msg
options(dplyr.summarise.inform = FALSE)

# get all types by country
Type_Countries <- na.omit(data.frame(type = rep(NFTitles$type, sapply(CountryLst, length)), country = unlist(CountryLst))) %>% 
  group_by(country, type) %>%
  summarise(count = n())

CountriesFinal <- reshape(data=data.frame(Type_Countries),idvar="country",
                          v.names = "count",
                          timevar = "type",
                          direction="wide") %>% arrange(desc(count.Movie)) %>%
  top_n(20)


# plot county by type and count 

#rename count columns
names(CountriesFinal)[2] <- "movie_count"
names(CountriesFinal)[3] <- "tvshow_count"

# change date_added column type 

NFTitles$date_added <- as.Date(NFTitles$date_added, format = "%B %d, %Y")


# add all title count by date
T_by_date <- NFTitles %>% group_by(date_added,type) %>% summarise(count_on_day = n()) %>% 
  ungroup() %>% group_by(type) %>% mutate(total_number_of_content = cumsum(count_on_day))

# titles by rating 

T_by_rating <- na.omit(NFTitles %>% group_by(rating,type)%>% 
                         summarise(count = n()))

RatingsFinal <- reshape(data=data.frame(T_by_rating),idvar="rating",
                        v.names = "count",
                        timevar = "type",
                        direction="wide")

names(RatingsFinal)[2] <- "movie_count"
names(RatingsFinal)[3] <- "tvshow_count"


# movies by duration 


duration_country_M<-na.omit(NFTitles[NFTitles$type=="Movie",][,c("country", "duration")])
DCountry <- strsplit(duration_country_M$country, split = ", ")

DurationCountryFinalM <- data.frame(duration = rep(duration_country_M$duration, sapply(DCountry, length)), country = unlist(DCountry))

# take only duration in minutes not in seasons

DurationCountryFinalM$duration <- as.numeric(gsub(" min","", DurationCountryFinalM$duration))

# take a subse , only top 20 producing countries

duration_country_subset= c("United States", "India", "United Kingdom", "Canada", "France", "Japan", "Spain", "South Korea", "Mexico", "Australia", "Taiwan","Italy","Turkey","Brazil","Thailand","Colombia","Taiwan","Singapore")



DurationCountryFinalM_subset <- DurationCountryFinalM[DurationCountryFinalM$country %in% duration_country_subset,]



# Investigate South Korea and Taiwan tv shows duration 

# chosse the two countries and assig data to new df

sk_ta_df <- NFTitles %>% filter(country %in% c("South Korea", "Taiwan"))  %>% select(country,type,release_year,rating,duration,listed_in) 


# clean the duration column  

sk_ta_df_tv <- filter(sk_ta_df,type == "TV Show")  
sk_ta_df_tv$duration <- gsub(" Season","",sk_ta_df_tv$duration) 
sk_ta_df_tv$duration <- gsub("s","",sk_ta_df_tv$duration)

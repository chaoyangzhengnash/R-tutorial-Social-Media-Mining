#
# Program: 3.5 -3.6 Tweets Data Visualization and mapping
#
# Purpose: 
#
# Required dataset: tweets_COVID2019.csv
#
#
# Written by: Zhenghao Wang, Chaoyang Zheng
# 
# Updated: March 2020
#        
# ------------------------------------------------------.


# Loading data and required libraries

# load twitter library - the rtweet library is recommended now over twitteR
library(rtweet)
# plotting and pipes - tidyverse!
library(tidyverse)
library(ggplot2)
library(dplyr)
library(wordcloud)
library(RColorBrewer)
# text mining library
library(tidytext)
library(igraph)
library(ggraph)
library(tidyr)
library(widyr)
library(tm)
library(igraph)
library(ggraph)
library(RJSONIO)
library(maps)
library(ggthemes)


# Load data 
setwd("C:/Users/Zheng Chaoyang/Desktop/Advanced Statistics/Team project/Data")
tweets <- read.csv2("tweets_COVID2019.csv")
#_______________________________________________________

# Data clean up 

# Set up start and end window for tweets data 
start_date <- as.POSIXct('2020-03-24 00:00:00')
end_date <- as.POSIXct('2020-03-26 00:00:00')

tweet_clean <- tweets %>%
  
  mutate(date_time = as.POSIXct(date_time, format = "%a %b %d %H:%M:%S +0000 %Y"),
         
         tweet_text = gsub("\\s?(f|ht)(tp)(s?)(://)([^\\.]*)[\\.|/](\\S*)", 
                           "", tweet_text)) %>% # remove signals
  
  #  filter(date_time >= start_date & date_time <= end_date ) %>%   # Focus on the predifined period 
  
  dplyr::select(tweet_text) %>%
  unnest_tokens(word, tweet_text) %>%  # remove punctuation, convert to lowercase, add id for each tweet
  
  anti_join(stop_words) %>% # remove stopwords in tweet
  
  filter(!word == "rt") # remove all rows that contain "rt" or retweet

#_______________________________________________________

# plot the top 15 common words 
tweet_clean %>%
  count(word, sort = TRUE) %>%
  top_n(15) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(x = word, y = n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip() +
  labs(x = "Count",
       y = "Unique words",
       title = "Count of unique words found in tweets")


#_______________________________________________________
# Paired word analysis
tweets_paired <- tweets %>%
  dplyr::select(tweet_text) %>%
  mutate(tweet_text = removeWords(as.character(tweet_text), stop_words$word)) %>%
  mutate(tweet_text = gsub("\\brt\\b|\\bRT\\b", "", tweet_text)) %>%
  mutate(tweet_text = gsub("http://*", "", tweet_text)) %>%
  unnest_tokens(paired_words, tweet_text, token = "ngrams", n = 2)

tweets_paired %>%
  count(paired_words, sort = TRUE)

tweets_separated <- tweets_paired %>%
  separate(paired_words, c("word1", "word2"), sep = " ")

# new bigram counts:
tweets_word_counts <- tweets_separated %>%
  count(word1, word2, sort = TRUE)
tweets_word_counts

# plot  change word network
# (plotting graph edges is currently broken)

tweets_word_counts %>%
  filter(n >= 4000) %>%
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  #geom_edge_link(aes(edge_alpha = n, edge_width = n)) +
  geom_node_point(color = "darkslategray4", size = 3) +
  geom_node_text(aes(label = name), vjust = 3, size = 4) +
  labs(title = "Word Network: Tweets during the COVID2019",
       subtitle = "Mar 2020 - Text mining twitter data ",
       x = "", y = "")
theme_void()

# Word cloud 

tweet_clean_freq <- as.data.frame(table(tweet_clean))


wordcloud(words = tweet_clean_freq$tweet_clean, 
          freq = tweet_clean_freq$Freq,min.freq = 1000, 
          max.words=300,
          random.order=FALSE,
          rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

#_______________________________________________________
# Create Maps of Social Media Twitter Tweet Locations Over Time in R
tweets2<-tweets

tweets2$city <- as.character(tweets2$city)

tweets2$city[tweets2$city == "NA"] <- NA

tweets3 <- dplyr::filter(tweets, !is.na(city)) 




# get coords basde on city & country
counter <- 1
tweets3$lon[counter] <- 0
tweets3$lat[counter] <- 0

# please noted that, as the website "nominatim" has limit access for 
# one individual ip, therefore in the presence of large data set, 
# at some point, we may need to stop the function manually or the 
# function will run forever without bring any meaningful information.

while (counter <= nrow(tweets3)){
  CityName <- gsub(' ','%20',tweets3$city[counter]) #remove space for URLs
  CountryCode <- tweets3$country_code[counter]
  url <- paste(
    "https://nominatim.openstreetmap.org/search.php?q="
    , CityName
    , "+"
    , CountryCode
    , "&limit=9&format=json"
    , sep="")
  
  tryCatch(
    x <- fromJSON(url)
    , error=function(e){}
  )
  
  tryCatch(
    if(is.list(x) == TRUE){
      tweets3$lon[counter] <- x[[1]]$lon
      tweets3$lat[counter] <- x[[1]]$lat
    } , error=function(e){}
  )
  counter <- counter + 1
}


# remove NA values
tweets4<-tweets3[!(tweets3$lon == "0"  & tweets3$lat=="0"),]
tweets4$lon <-as.numeric( tweets4$lon)
tweets4$lat <-as.numeric( tweets4$lat)
# create basemap of the globe
world_basemap <- ggplot() +
  borders("world", colour = "gray85", fill = "gray80") +
  theme_map()

world_basemap +
  geom_point(data = tweets4, aes(x = lon, y = lat),
             colour = 'purple', alpha = .5) +
  scale_size_continuous(range = c(1, 8),
                        breaks = c(250, 500, 750, 1000)) +
  labs(title = "Tweet Locations : Covid_19")



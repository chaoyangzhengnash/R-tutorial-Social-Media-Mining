#
# Program: 4.0 Sentiment analysis
#
# Purpose: 
#
# Required dataset: tweets_COVID2019.csv
#
#
# Written by: Zhenghao Wang , Chaoyang Zheng
# 
# Updated: March 2020
#        
# ------------------------------------------------------.# load twitter library - the rtweet library is recommended now over twitteR
library(rtweet)
# plotting and pipes - tidyverse!
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

setwd("C:/Users/Zheng Chaoyang/Desktop/Advanced Statistics/Team project/Data")

# Load data 
tweets <- read.csv2("tweets_COVID2019.csv")

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
# A quick sentiment Analysis
# join sentiment classification to the tweet words

bing_word_counts <- tweet_clean %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()


bing_word_counts %>%
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(title = "Sentiment during the COVID2019period.",
       y = "Contribution to sentiment",
       x = NULL) +
  coord_flip()

#_______________________________________________________
# Track the trajectory of sentiments


COVID2019_sentiment <- tweet_clean %>%
  mutate(linenumber = row_number())%>%
  inner_join(get_sentiments("bing")) %>%
  count(word, index = linenumber %/% 800, sentiment) %>%
# Small sections of text may not have enough words in them 
# to get a good estimate of sentiment while really large 
# sections can wash out narrative structure. For our tweets data,
# using 80 lines works well, but this can vary depending on individual texts, 
# how many words were to start with, etc. 
  
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative) 
# We then use spread() so that we have negative and positive sentiment 
# in separate columns, and lastly calculate a net sentiment (positive - negative)

COVID2019_sentiment <- aggregate(sentiment ~ index, data= COVID2019_sentiment,  FUN = sum)
# AfTer calculating the score of each word, we can aggregate by index 
# to get the sum of words score, which is the sentiment score for each section of text



# plot 
ggplot(COVID2019_sentiment, aes(index, sentiment)) +
  geom_col(show.legend = FALSE) 


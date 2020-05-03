#
# Program: 3.4 Collecting tweets and cleaning data
#
# Purpose: 
#
# Required dataset: None
#
#
# Written by: Zhenghao Wang , Chaoyang Zheng
# 
# Updated: March 2020
#        
# ------------------------------------------------------.

# load twitter library - the rtweet library is recommended now over twitteR
library(rtweet)
# plotting and pipes - tidyverse!
library(ggplot2)
library(dplyr)
# text mining library
library(tidytext)
# plotting packages
library(igraph)
library(ggraph)

# For repurduction purpose, please replace the following information with your own tweet token
appname <- "ASL_Twitter_Project"
key <- "5PPc1TKJZx5FNjxNDIzCQjmKv"
secret <- "mhlIz9U72H3MgT64MmjuSA2LJrtVjjygjTz2kGzLzmU0rqmjqU"
twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret)

tweets <- search_tweets(q = "#COVID2019", n = 1000,lang = "en", include_rts = FALSE)

# remove http elements manually
tweets$stripped_text <- gsub("http.*","",  tweets$text)
tweets$stripped_text <- gsub("https.*","", tweets$stripped_text)

# remove punctuation, convert to lowercase, add id for each tweet!
tweets_clean <- tweets %>%
  dplyr::select(stripped_text) %>%
  unnest_tokens(word, stripped_text)

# load list of stop words - from the tidytext package
data("stop_words")
cleaned_tweet_words <- tweets_clean %>%
  anti_join(stop_words)


#
# Program: 3.3 Request friend/follower (Social Networwork)
#
# Purpose: 
#
# Required dataset: variable.RData
#
#
# Written by: Zhenghao Wang , Chaoyang Zheng
# 
# Updated: March 2020
#        
# ------------------------------------------------------.

library(tidyverse)
library(rtweet)

appname <- "ASL_Twitter_Project"
key <- "5PPc1TKJZx5FNjxNDIzCQjmKv"
secret <- "mhlIz9U72H3MgT64MmjuSA2LJrtVjjygjTz2kGzLzmU0rqmjqU"
twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret)

#api_key<-"5PPc1TKJZx5FNjxNDIzCQjmKv"
#api_secret_key <- "mhlIz9U72H3MgT64MmjuSA2LJrtVjjygjTz2kGzLzmU0rqmjqU"
#access_token<- "1084492026266243073-dAm2knvd4ZCVjJbeSOZ94CVg3JICCR"
#access_token_secret<- "qiVC5gfDozoEF2cmoLqyrboa66UXswzSvEP1W5yX7n7QX"
#twitter_token<-create_token(
#  app = appname,
#  consumer_key = key,
#  consumer_secret = secret,
#  access_token=access_token,
#  access_secrect=access_token_secret)

twitter_token

rate_limit()

my_followers <- get_followers("ek_turkina")
my_friends <- get_friends("ek_turkina")
# ids <- sample.int(my_followers$user_id, 75, useHash = TRUE)

# create empty list to store results
friends <- list()

# start loop
for (a in 1:length(ids)){
  friends[[a]] <- get_friends(ids[a])
  
  #  pause if divisible by 15
  if (a %% 15 == 0){
    Sys.sleep(15*60) # must enter time in seconds
  }
}

# Combine data tables in list
friends <- bind_rows(friends) %>% 
  rename(friend = user_id)


net <- friends %>% 
  group_by(friend) %>% 
  mutate(count = n()) %>% 
  ungroup() %>% 
  filter(count > 1)
glimpse(net)

library(tidygraph)
library(ggraph)

g2 <- net %>% 
  select(user, friend) %>%  # drop the count column
  as_tbl_graph(directed = F) %>%  # make undirected
  activate(nodes) %>% 
  mutate(centrality = centrality_betweenness())
g2

ggraph(g2) +
  geom_edge_link() +
  geom_node_point(aes(size = centrality, colour = centrality)) +
  theme_graph()


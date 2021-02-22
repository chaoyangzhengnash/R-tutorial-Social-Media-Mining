# R tutorial : Social Media Mining
The tutorial is wrote by Chaoyang Zheng and Zhenghao Wang for PHD course: Advanced Statistical Leaning in HEC MONTREAL.

![Alt text](https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/0.png "Optional title")

## 1.Introduction
In the era of internet, more than 1 billion people log in to social media, making comments, sharing feelings and connecting friends. The increasing development of Social media network provides an unprecedented volume and variety of both personal and impersonal data that can be a valuable, given it provide a near real-time outlook on both social processes(public opinions towards event, such as politics) and natural process(such as natural disasters).

In this report we are going to explain how to implement data mining techniques with social media data, speciﬁcally Twitter, to gain insights towards the social impacts and public perceptions of Covid 19. The rest of this project starts from a literature review, in which we discuss the deﬁnition of social media, social media mining, and compare the features of several popular R packages for analysing twitter data. Then, the step by step guidelines to extract, manipulate, and visualize twitter data are presented in the methodology part. Finally, the data analysis part will explain how to proceed sentiment analysis in the twitter data.

## 2.Literature Review
### 2.1 Social media
According to Andreas Kaplan and Michael (2012), the deﬁnition of social media as follows: ”A group of Internet-based applications that build on the ideological and technological foundations of Web 2.0 and that allow the creation and exchange of user-generated content”. People communicate bidirectional using online tools such as Twitter, Facebook, Instagram etc., with text, graph, audio and video. People are paying more attention the impact and value made from social media mining. Businesses need to notice people’s opinion by mining social networks, and gain insights of current and potential outlooks from data. Such informative data could inﬂuence business decisions and the development of company in long run (Tuten Solomon, 2017).

### 2.2 Social media mining
Social media mining is a systematic analysis of information generated from social media. It is a challenging task not only the normal data mining challenges, but those merge because of social-relationship aspect. The huge amount of relational data that can shrink the searching frame or criteria to very detailed level could lead to unclear boundary of data usage, which can also call as ‘over-ﬁtting’ in social media mining. On the contrary, sometimes the data is not enough to generate insightful or complete information due to strict information regulation. And it can refer as ‘under-ﬁtting’. The third is noise removal error. Due to the clutter of social media data, pre-processing step is important but tricky. We can always end of missing some information when we are removing noise, for example emoji. The last one can be evaluation dilemma. Because of the sheer amount of data, a proper annotated data set for training supervised algorithm is impossible, only clustering (unsupervised algorithms) can be applied. But domain expertise is needed. (Ravindran Garg, 2015).

Social media mining can be divided into two basic tasks, graph mining and text mining. The social relationship existing between people can be treated as a graph network. Typically, each user can be treated as a node within network, and nodes within the same cluster tend to share common features. The most obvious example is friend or interest recommendation system in social media. Extracting unstructured text data is the other task. It is common for twitter, Facebook that users post blog and article on them (Ravindran Garg, 2015)

### 2.3 R packages for social media mining
Base on the development recent years, lots of tools and techniques are released used to mine such information. In R, several packages are available for text data processing and social media mining. These libraries oﬀer better and more convenience way to get and analyze text data. In this project, for accessing Tweeter API speciﬁcally, ‘rtweet’ will be used. Moreover, other visualization and analysis packages will also be applied in the following section.

## 3. Methodology
In this part, we are going to explain how to implement social media mining in R. First, we introduce R packages used in this project, and compare the pros and cons for some of them; Then we explain what is API, how to apply and use it in R; After that, we will introduce how to implement fundamental functions of social media mining for Tweet in R.

### 3.1 Introduction to social media mining packages in R
Twitter has REST (Representational State Transfer) API which allows developers to access everyone’s Tweets. But the API has limitations at the same time:

1. Users can only access tweets from the last 6-9 days.
2. Users can only request 18,000 tweets for each call.

In order to use the API to collect data, several packages are available for R. The most frequent used packages that you can ﬁnd online are ‘rtweet’,’twitterR’,’streamR’ and ‘RtwitterAPI’. Only three of them, ‘rtweet’,’twitterR’, and ’streamR’, are available on CRAN. ‘twitterR’ hasn’t updated since 2016, therefore, this package can not used in this project for the consideration and stability and adaptability. The main diﬀerence between ‘rtweet’ and ‘streamR’ is the capacity of functions within package. ‘rtweet’ has the most complete and robust functions among other packages. ‘rtweet’ is an implementation of calls for collecting and organize Twitter data compliance with Tweeter development policies. Users can easily get the lasted version from CRAN. A compact summary of diﬀerent functions from packages can be found in the table.

<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/2.PNG" width="400">

Basically, ‘trweet’ has three main goals: formulate and send request from user to Twitter, iterate over returned data and wrangling data into tidy format. This package can outputs tweets into standard ‘data.frame’ format , which is very friendly for further cleaning process. It is becoming a commonly used package for R programmer.

Besides of the API access package, some other packages will also be applied in social media mining project.

‘tidygraph’ is a package that available on CRAN, designed speciﬁcally for visualization. It is designed as a tool that provides tidy framework for all relational graphs (networks, tress, etc). More details can be found in here. Package ‘wordcloud’ is a good tool for creating word cloud, which clearly visualize diﬀerences and similarity between documents and avoid over-plotting in text scatter plot. Related documents is attached here. Other visualization packages are used, such as ‘igraph’ and ‘ggraph’. Both of them can be treated as extension of ‘ggplot2’ tailored for graph or network visualization. They can easily handle large scale graph ﬂexibly by building up graph layer by layer. You can ﬁnd deeper in following links:

[Oﬃcial website of ggraph](https://cran.r-project.org/web/packages/ggraph/readme/README.html)
[Oﬃcial website of iggraph](https://igraph.org/r/)

For text mining, several pre-process packages will be used. ‘tidytext’ package integrates many tools that have already existed in other libraries, making the whole tidying text work convenience and eﬃcient. It provides functions and supports data sets to allow text converse from or to tidy format, and to switch between other tidy tools and existing text mining packages. More details about text tidying can be found in the authors’ book:https: //www.tidytextmining.com/. Another tools for reprocess is ‘tidyr’, used for converting deeply nested data set into rectangular data frames. And it also works for handling missing values. More information can be found on CRAN( https://cran.r-project.org/web/ packages/tidyr/readme/README.html.)

### 3.2 API application, authorization and token secret 
Although ‘rtweet’ allows users to acquire tweets without developer account and private Twitter application, however, having a developer account and creating own application is always a better option. With the developer account and private app, users can make full use of ‘rtweet’. The table below shows the usage diﬀerence between public app and private app.

<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/3.PNG" width="400">

Users can apply for developer account with their existed Twitter account through https: //developer.twitter.com/en. After ﬁlling in several API usage purpose questions and signing acknowledgements, Twitter will contact you in several days for the application result.

After developer account activation, developers can create own APP for their personal mining project by clicking APP button under their account name on the top right corner of developer homepage . Please notice that the ‘Callback URLs’ should exactly be http://127.0.0.1:1410 when creating application, apart from ﬁlling other cells clear and honestly. Once ﬁnished application setup with Tweeter account, users can create their own key and token in two ways to authorize their access to data.

The ﬁrst is browser-based authorization. Authentication with web browser requires installing ‘httpuv’ package. First, we need to navigate to application page and generate keys and secrete keys. With ‘rtweet’ package installed, a browser page will pop up when users passed the keys to create.token function, telling users that they get the access.

<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/4.PNG" width="400">

```
appname <- "ASL_Twitter_Project"
key <- "5PPc1TKJZx5FNjxNDIzCQjmKv"
secret <- "mhlIz9U72H3MgT64MmjuSA2LJrtVjjygjTz2kGzLzmU0rqmjqU"
twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret)
```

There is other way for authorization without browser. Users need to create access token access token secrete in the App page and pass all four keys and tokens to create.token function. The function will automatically save your token as an environment variable. Thus ‘rtweet’
should automatically ﬁnd the token for the next time when users start an R session on the same machine. When you ﬁnished this step, print out the token just saved for check.

```
api_key<-"Balabalabala"
api_secret_key <- "Balabalabala"
access_token<-"Balabalabala"
access_token_secret<-"Balabalabala"
twitter_token<-create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret,
access_token=access_token,
access_secrect=access_token_secret)
```
<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/5.PNG" width="400">

Now, you are all set for mining Twitter!

### 3.3 Request friend/follower (Social Network) 
This section, we will start with discussing some fundamental functions of social media mining for Twitter. The ﬁrst one is getting the friend or followers of a speciﬁc Twitter account. And a graph of relation network will be plotted.

When working with Twitter API, it is important to understand the data limiting which helps regulated traﬃc caused by developer querying. Tweeter API is a collection of many small APIs, and diﬀerent API has diﬀerent limits. We can check the details of limits with rate.limit() function. The ‘reset’ column is time remaining in minutes for cool down.

<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/6.PNG" width="400">

The reset for querying friend of speciﬁc account is 15 minutes for each 15 requests. Therefore, we need to keep enough time for extracting data or shorten the length of query list. In the example, 75 sampled friends are pulled just for illustration, cost 1 hour and 15 minutes. The code below shows we extract followers and friends of Twitter account ”ek.turkina”. The output is a list of number (user.id) which present diﬀerent twitter account names instead of strings to protect privacy. Left table is follower table, and right one is friend table.

```
my_followers <- get_followers("ek_turkina")
my_friends <- get_friends("ek_turkina")
```
<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/7.PNG" width="400">

Then, in order to see whether there is a connection between followers, we also pulled out the friend of friends, which can be treated as nodes in graph. The query will pause for every 15 minutes because of the limitation.

```
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
```

After getting these raw data, we need to do a little clean up for plotting. In order to ﬁnd the network through friends, we dropped all the rows that appear only once in the ‘friend’ column. 

<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/8.PNG" width="400">

Then we got the links which can be used create graph.

```
friends <- bind_rows(friends) %>% 
  rename(friend = user_id)

net <- friends %>% 
  group_by(friend) %>% 
  mutate(count = n()) %>% 
  ungroup() %>% 
  filter(count > 1)
glimpse(net)
```
<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/9.PNG" width="400">

In the graph, one conception is very important, centrality. It measures and identiﬁes the most important vertices with a graph. In the context of social network, key node represents the most inﬂuential person. ‘tidygraph’ contains many diﬀerent measures of centrality, for example, betweenness, closeness. Here we used betweenness for illustration. Note that the graph is set as undirected, since only followers have connections to other nodes when links are directed.

```
library(tidygraph)
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
```
<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/10.PNG" width="400">

As we can see from left bottom the graph, except connecting with two main nodes in the center, few followers are also connected because of other accounts. And those more connected nodes have higher centrality. This is only scratch some basic application for mining networks of friends and followers. Both of teammates in our team are not obsessed with Twitter. Highly recommend people who are heavily user of Twitter to mine more insightful and interesting network for their own account, that would be fun.

### 3.4 Collecting tweets and cleaning data
#### 3.4.1 Searching for tweets
Compared with data sources such as NASA and USGS, which have structured cleaning steps to implement(for instance removing na or scaling data), data collected through social media usually have no speciﬁc rules to clean up, as the text data is created and curated by the user community. This means that we may have to perform extra steps to clean the data to ensure we are analyzing the right thing.

Let’s starting from exploring the actual text of the tweets which will involve some text mining.

First, we need load the rtweet and other needed R packagesand complete the authentication process in browser.

```
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

appname <- "ASL_Twitter_Project"
key <- "5PPc1TKJZx5FNjxNDIzCQjmKv"
secret <- "mhlIz9U72H3MgT64MmjuSA2LJrtVjjygjTz2kGzLzmU0rqmjqU"
twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret)
```
Now we are ready to search twitter for recent tweets. In this example, let’s ﬁnd tweets that are using the words “COVID2019” in them. We use the rtweet::search.tweets() function to search. Please noted that Search.tweets() requires the following arguments:

    q: the query word that we want to look for 
    n: the number of tweets that we want returned. 
    lang:the language of tweets to be collect include.
    rts : indicating whether to include retweets in search results
    
```
tweets <- search_tweets(q = "#COVID2019", n = 1000,lang = "en", include_rts = FALSE)
```
The output data.frame ”tweets” contain detailed information for tweets that use ”COVID2019” as hashtag, such as userid, location and text etc.

<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/11.PNG" width="400">

#### 3.4.2 Data cleaning
Looking at the data above, it becomes clear that there is a lot of clean-up associated with social media data.

A common way to implement text analysis is to create a list of unique words according to data. We should be noted that words with capitalization will be diﬀerent from words that are all lowercase, and we don’t need punctuation to be returned as a unique word. Meanwhile, we may also want to remove url in the text as they won’t for text analysis

We can use the tidytext::unnest.tokens() function in the tidytext package to magically clean up our text! When we use this function the following things will be cleaned up in the text:

    1.Convert text to lowercase: each word found in the text will converted to lowercase, so ensure that you don’t get duplicate words due to variation in capitalization. 
    2.Punctuation is removed: all instances of periods, commas etc will be removed from your list of words. 
    3.Unique id associated with the tweet: will be added for each occurrence of the word

The unnest.tokens() function takes two arguments:

    The name of the column where the unique word will be stored. 
    The column name from the data.frame that we are using that we want to pull unique words from.

```
# remove http elements manually
tweets$stripped_text <- gsub("http.*","",  tweets$text)
tweets$stripped_text <- gsub("https.*","", tweets$stripped_text)

# remove punctuation, convert to lowercase, add id for each tweet!
tweets_clean <- tweets %>%
  dplyr::select(stripped_text) %>%
  unnest_tokens(word, stripped_text)
```

We may also noticed that the text contains some words that may not be useful to use. For instance “a” and “to”. In the word of text mining we call those words - ‘stop words’. We may want to remove these words from our analysis as they are ﬁllers used to compose a sentence. The ’tidytext’ package has a function that will help us clean up ’stop words’. What we need to do are just loading the stop.words data, which is simply a list of words that we may want to remove in a natural language analysis; then we use anti.join to remove all stop words.

```
# load list of stop words - from the tidytext package
data("stop_words")
cleaned_tweet_words <- tweets_clean %>%
  anti_join(stop_words)
```

The ﬁnal cleaned output looks as follows, which is a list of unique words according to data.

<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/12.PNG" width="400">

### 3.5 Data visualization 
In this part, we will explain how to visualize the twitter data to implement the preliminary analysis. Speciﬁcally, bar chart of word count, word network, and word cloud will be discussed.

Let’s starting from loading data and install/load required libraries.

```
# load twitter library - the rtweet library is recommended now over twitteR
library(rtweet)
# plotting and pipes - tidyverse!
library(ggplot2)
library(dplyr)
library("wordcloud")
library("RColorBrewer")
# text mining library
library(tidytext)
library(igraph)
library(ggraph)
library(tidyr)
library(widyr)
library(tm)
library(igraph)
library(ggraph)

# Load data 
tweets <- read.csv("tweets_COVID2019.csv")
```

Once the data and libraries are loaded successfully, we can implement data cleaning like we did in previous part.

```
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
```

Next let’s explore the content of the tweets using some visualizing techniques to do basic text mining approaches.

#### 3.5.1 Common words visualization
First of all, we can generate a list of the most popular words found in the tweets related to COVID2019. To do this, we can simply use count and sort function, and call ggplot to plot the most frequent word:

```
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
 ```
 Then we can get the Bar-chart outputs for top 15 common words. See ﬁgure 12.
 
 <img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/13.PNG" width="400">

#### 3.5.2 Paired words visualization
It is also a good idea to explore words that occur together in tweets using words network, we may found some interesting patterns in words distribution.

As the data structure for paired words analysis is diﬀerent with Common words analysis, we need to re-clean and organize the twitter data. Speciﬁcally, this case we will create a data frame with two columns which contain word pairs found in the data and a third column that has the count of how many time that word pair is found in the data.

```
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
```

After the re-organization of twits data, the new data frame can be seen on ﬁgure 13:

<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/14.PNG" width="400">

Finally, plot the word network.

```
tweets_word_counts %>%
  filter(n >= 4000) %>% # the frequency(n) should based on the nature of data 
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  #geom_edge_link(aes(edge_alpha = n, edge_width = n)) +
  geom_node_point(color = "darkslategray4", size = 3) +
  geom_node_text(aes(label = name), vjust = 3, size = 4) +
  labs(title = "Word Network: Tweets during the COVID2019",
       subtitle = "Mar 2020 - Text mining twitter data ",
       x = "", y = "")
  theme_void()
```

The following graph of word network shows that which words are most often being used together. Some pair of words distribute quite intuitively. For example, the word ”stay” is closed to word ”safe” and ”home”, while all of them are quite far away from ”negative words” located at the left side of word network, such as ”coranavarious” and ”pandemic”, hence we may reach some inference that, under this situation public may suppose ”stay home” equals to ”stay safe”.

<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/15.PNG" width="400">

3.5.3 Words cloud 
Another common visualization techniques for social media data is word clouds, which is a potent communication tool, and is easy to understand, to be shared and is impactful.

What we need to is just get the frequency of tokens appeared in the data, then call wordcloud function(from wordcloud package) to plot them.

```
tweet_clean_freq <- as.data.frame(table(tweet_clean))
 
wordcloud(words = tweet_clean_freq$tweet_clean, 
            freq = tweet_clean_freq$Freq,min.freq = 1000, 
            max.words=300,
            random.order=FALSE,
            rot.per=0.35, 
            colors=brewer.pal(8, "Dark2"))
```

The following word cloud clearly shows that “coronavirus”, “lockdown” and “stay” are the three most frequent words in tweets using covid2019 as hashtag.

<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/16.PNG" width="400">

### 3.6 Mapping tweet location 
Now, we will create a map that shows the location from where people were tweeting during this COVID2019 pandemic. Please noted that even though some tweets collected by rtweet including coordinates, while most of them(99.9 percent) do not have latitude and longitude information. One solution is that we can use the city name as the proxy to get location info, as about 15 percent of tweets attached with city tag.

Firstly. let’s load the data again, and remove tweets that have no city tag.

```
# Create Maps of Social Media Twitter Tweet Locations Over Time in R
tweets2<-tweets

tweets2$city <- as.character(tweets2$city)

tweets2$city[tweets2$city == "NA"] <- NA
  
tweets3 <- dplyr::filter(tweets, !is.na(city)) 
```

Then, we make loop to get coordinates for each tweet, based on the city name and country code. Please noted that in this case, since we are actually referencing geography information from an external website (nominatim.com), which have a limitation of access(about 1000 access every day), we should be careful once our tweets data is relatively big.

```
# get coords basde on city & country
counter <- 1
tweets3$lon[counter] <- 0
tweets3$lat[counter] <- 0

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
```

Then we can plot in a based map.

```
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
```

<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/17.PNG" width="400">

We can clearly ﬁnd that, people in India and U.S particularly care about this disease. However, it seems like European people don’t concern a lot.

## 4. Sentiment analysis
Sentiment analysis is extremely useful in social media monitoring as it allows us to gain an overview of the wider public opinion behind certain topics. There are lots of approaches to implement such analysis in R, while in generally, those approaches can be divided into either the machine learning methods or dictionary-based methods.

On the one hand, machine learning approaches are preferred when one strives for high prediction performance. However, machine learning usually works as a black-box, thereby making interpretations diﬃcult, and requires labeled data to proceed supervised learning, which generally is uneasy to collect in social media mining, as the Twitter data is time sensitive.

On the other hand, dictionary-based approaches generate lists of positive and negative words. The respective occurrences of these words are then combined into a single sentiment score. Therefore, the underlying decisions become traceable, and researchers can understand the factors that result in a speciﬁc sentiment. Therefore, in this report we will only focus on dictionary based models.

### 4.1 Search most common positive and negative words

Dictionary-based methods aim to ﬁnd the total sentiment of a piece of text by adding up the individual sentiment scores for each word in the text, while the sentiment scores are referenced from sentiment lexicons. To implement the dictionary-based method, what we need do are cleaning the Twitter’s data, then call a inner join function to reference the sentiment score of each token, then we can analyze or visualize outputs.

Once we ﬁnish collecting the data, we may want to know what are the most common positive and negative words in our tweets data. Let’s load the data and library, then implement data cleaning.

```
# load twitter library - the rtweet library is recommended now over twitteR
# plotting and pipes - tidyverse!
library(ggplot2)
library(dplyr)
# text mining library
library(tidytext)
library(ggraph)
library(tidyr)
library(widyr)

# Load data 
tweets <- read.csv2("tweets_COVID2019.csv")

# Data clean up 
tweet_clean <- tweets %>%
  mutate(date_time = as.POSIXct(date_time, format = "%a %b %d %H:%M:%S +0000 %Y"),
         tweet_text = gsub("\\s?(f|ht)(tp)(s?)(://)([^\\.]*)[\\.|/](\\S*)", 
                           "", tweet_text)) %>% # remove signals
  dplyr::select(tweet_text) %>%
  unnest_tokens(word, tweet_text) %>%  # remove punctuation, convert to lowercase, add id for each tweet
  anti_join(stop_words) %>% # remove stopwords in tweet
  filter(!word == "rt") # remove all rows that contain "rt" or retweet
```

Next, we can join the words extracted from the tweets with the sentiment data. The “bing” sentiment data classiﬁes words as positive or negative. Note that other sentiment datasets use various classiﬁcation approaches,and we can learn more in the sentiment analysis chapter of the tidytext e-book.

```
bing_word_counts <- tweet_clean %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()
```

Finally, we can plot top words, grouped by positive vs. negative sentiment.

```
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
```

From following graph, we see mostly positive words about safe, support and positive here (while in this case it may refer to ”tested positive”,which is bad, this can be view as one of the main drawbacks of dictionary based methods, as the lexicon is based on unigrams, i.e., single words) , and virus, crisis and death for negative words.

<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/18.PNG" width="400">

### 4.2 Track the trajectory of sentiments over time
We can also examine how sentiment changes throughout time. We can do this with just a handful of lines that are mostly dplyr functions. First, we ﬁnd a sentiment score for each word using the Bing lexicon and innerjoin(). Next, we count up how many positive and negative words there are in deﬁned sections of of our tweets data. We deﬁne an index here to keep track time; this index (using integer division) counts up sections of 800 words of text.

```
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
# to get the sum of words score, which is the sentiment score for each defined 
# section of text
```

Now we can plot these sentiment scores across the plot trajectory. Notice that we are plotting against the index on the x-axis as a proxy to keep track of time.

```
library(ggplot2)
ggplot(COVID2019_sentiment, aes(index, sentiment)) +
  geom_col(show.legend = FALSE) 
```

The following graph shows that generally the negative sentiment of COVID2019 tweets data outperform the positive sentiment over time.

<img src="https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/19.PNG" width="400">

# 5. Summary
Social media mining provides a way to understand the attitudes and opinions of public in terms of either natural or social events. In this report, ﬁrst we introduced and compared R packages commonly used for Twitter data mining; Then we explained how to use API to collect tweets through rtweet,and how search users and their friends to create an user network graph. After that, we also show how to proceed a quick data cleaning and implement classical visualization techniques to enable users to understand collected tweets data in a more clear way. Finally, the most common dictionary based sentiment analysis methods were introduced so that developers could easily get handful information from public.

# 6. Reference
Julia Silge and David Robinson. 2017. Text Mining with R: A Tidy Approach (1st. ed.). O’Reilly Media, Inc.

Kaplan, A. M., Haenlein, M. (2012). Social media: back to the roots and back to the future. Journal of Systems and Information, 101-104.

Kearney, M. W. (n.d.). rtweet. Retrieved from rtweet: https://rtweet.info/

Ravindran, S. K., Garg, V. (2015). Mastering Social Media Mining with R. Birmingham: Packt Publishing.

Sharan Kumar Ravindran and Vikram Garg. 2015. Mastering Social Media Mining with R. Packt Publishing.

Tuten, T. L., Solomon, M. R. (2017). Social Media Marketing.



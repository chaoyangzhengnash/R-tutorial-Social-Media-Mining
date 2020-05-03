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

![Alt text](https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/2.PNG "Optional title")

Basically, ‘trweet’ has three main goals: formulate and send request from user to Twitter, iterate over returned data and wrangling data into tidy format. This package can outputs tweets into standard ‘data.frame’ format , which is very friendly for further cleaning process. It is becoming a commonly used package for R programmer.

Besides of the API access package, some other packages will also be applied in social media mining project.

‘tidygraph’ is a package that available on CRAN, designed speciﬁcally for visualization. It is designed as a tool that provides tidy framework for all relational graphs (networks, tress, etc). More details can be found in here. Package ‘wordcloud’ is a good tool for creating word cloud, which clearly visualize diﬀerences and similarity between documents and avoid over-plotting in text scatter plot. Related documents is attached here. Other visualization packages are used, such as ‘igraph’ and ‘ggraph’. Both of them can be treated as extension of ‘ggplot2’ tailored for graph or network visualization. They can easily handle large scale graph ﬂexibly by building up graph layer by layer. You can ﬁnd deeper in following links:

[Oﬃcial website of ggraph](https://cran.r-project.org/web/packages/ggraph/readme/README.html)
[Oﬃcial website of iggraph](https://igraph.org/r/)

For text mining, several pre-process packages will be used. ‘tidytext’ package integrates many tools that have already existed in other libraries, making the whole tidying text work convenience and eﬃcient. It provides functions and supports data sets to allow text converse from or to tidy format, and to switch between other tidy tools and existing text mining packages. More details about text tidying can be found in the authors’ book:https: //www.tidytextmining.com/. Another tools for reprocess is ‘tidyr’, used for converting deeply nested data set into rectangular data frames. And it also works for handling missing values. More information can be found on CRAN( https://cran.r-project.org/web/ packages/tidyr/readme/README.html.)

### 3.2 API application, authorization and token secret 
Although ‘rtweet’ allows users to acquire tweets without developer account and private Twitter application, however, having a developer account and creating own application is always a better option. With the developer account and private app, users can make full use of ‘rtweet’. The table below shows the usage diﬀerence between public app and private app.

![Alt text](https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/3.PNG "Optional title")

Users can apply for developer account with their existed Twitter account through https: //developer.twitter.com/en. After ﬁlling in several API usage purpose questions and signing acknowledgements, Twitter will contact you in several days for the application result.

After developer account activation, developers can create own APP for their personal mining project by clicking APP button under their account name on the top right corner of developer homepage . Please notice that the ‘Callback URLs’ should exactly be http://127.0.0.1:1410 when creating application, apart from ﬁlling other cells clear and honestly. Once ﬁnished application setup with Tweeter account, users can create their own key and token in two ways to authorize their access to data.

The ﬁrst is browser-based authorization. Authentication with web browser requires installing ‘httpuv’ package. First, we need to navigate to application page and generate keys and secrete keys. With ‘rtweet’ package installed, a browser page will pop up when users passed the keys to create.token function, telling users that they get the access.

![Alt text](https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/4.PNG "Optional title")

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
api_key<-"5PPc1TKJZx5FNjxNDIzCQjmKv"
api_secret_key <- "mhlIz9U72H3MgT64MmjuSA2LJrtVjjygjTz2kGzLzmU0rqmjqU"
access_token<-"1084492026266243073-dAm2knvd4ZCVjJbeSOZ94CVg3JICCR"
access_token_secret<-"qiVC5gfDozoEF2cmoLqyrboa66UXswzSvEP1W5yX7n7QX"
twitter_token<-create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret,
access_token=access_token,
access_secrect=access_token_secret)
```
![Alt text](https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/5.PNG "Optional title")

Now, you are all set for mining Twitter!

### 3.3 Request friend/follower (Social Network) 
This section, we will start with discussing some fundamental functions of social media mining for Twitter. The ﬁrst one is getting the friend or followers of a speciﬁc Twitter account. And a graph of relation network will be plotted.

When working with Twitter API, it is important to understand the data limiting which helps regulated traﬃc caused by developer querying. Tweeter API is a collection of many small APIs, and diﬀerent API has diﬀerent limits. We can check the details of limits with rate.limit() function. The ‘reset’ column is time remaining in minutes for cool down.

![Alt text](https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/6.PNG "Optional title")

The reset for querying friend of speciﬁc account is 15 minutes for each 15 requests. Therefore, we need to keep enough time for extracting data or shorten the length of query list. In the example, 75 sampled friends are pulled just for illustration, cost 1 hour and 15 minutes. The code below shows we extract followers and friends of Twitter account ”ek.turkina”. The output is a list of number (user.id) which present diﬀerent twitter account names instead of strings to protect privacy. Left table is follower table, and right one is friend table.

```
my_followers <- get_followers("ek_turkina")
my_friends <- get_friends("ek_turkina")
```
![Alt text](https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/7.PNG "Optional title")

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

![Alt text](https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/8.PNG "Optional title")

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
![Alt text](https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/9.PNG "Optional title")



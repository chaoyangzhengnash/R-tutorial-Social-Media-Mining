# R tutorial : Social Media Mining
The tutorial is wrote by Chaoyang Zheng and Zhenghao Wang for PHD course: Advanced Statistical Leaning in HEC MONTREAL.

![Alt text](https://raw.githubusercontent.com/chaoyangzhengnash/R-tutorial-Social-Media-Mining/master/figure/0.png "Optional title")

```
function test() {
  console.log("notice the blank line before this function?");
}
```
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


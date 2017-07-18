## Using twitterAPI
## install.packages("twitteR")
library(twitteR)
library(httr)
api <- read.csv("twitter_api.txt",header = FALSE)
api_key <- as.character(api[1,1])
api_secret <- as.character(api[1,2])
access_token <- as.character(api[2,1])
access_token_secret <- as.character(api[2,2])

setup_twitter_oauth(api_key,api_secret,
                    access_token = access_token,
                    access_secret = access_token_secret)

## search tweets
tweets <- searchTwitter("#수원",n=10,lang = "ko")
head(tweets)
head(strip_retweets(tweets))

## looking at users
user <- getUser('ebay')
user$getFriends(n=5)

## Conversion to data.frames
df <- twListToDF(tweets)
df

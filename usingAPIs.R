## Getting Data from APIs
## http://vahidmirjalili.com/static/articles/R_gettingData.html

## Using httr package.
## Create a developer account at web
## Create an application, with authentication keys: OAuth
## Your keys are private

library(httr)
library(jsonlite)
ConsumerSecret <- ''
## store app from twitter
myapp = oauth_app("twitter",key = "",
                  secret = "")
sig = sign_oauth1.0(
    myapp,token = '',
    token_secret = '')

## Get the home timeline
homeTL = GET('https://api.twitter.com/1.1/search/tweets.json',sig)

## Extract its contents
json1 <- content(homeTL)
json2 <- jsonlite::fromJSON(toJSON(json1))

json2

## Github API:
## Register an application at http://github.com/settings/applications
## Get your key and secret pair for authentication

myapp <- oauth_app("github","",
                   '')
github_token <- oauth2.0_token(oauth_endpoints("github"),myapp)

req <- GET("https://api.github.com/users/kkalla/repos",
	   config(token = github_token))
stop_for_status(req)
json1 <- content(req)
json2 <- fromJSON(toJSON(json1))

str(json2)

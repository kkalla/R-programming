## Getting Data from APIs
## http://vahidmirjalili.com/static/articles/R_gettingData.html

## Using httr package.
## Create a developer account at web
## Create an application, with authentication keys: OAuth
## Your keys are private

library(httr)
library(jsonlite)
ConsumerSecret <- 'OP8GlSPy8jUn29k5OEghLVQkyPPIaPjdtm1q66YJU8qf2QFvYY'
## store app from twitter
myapp = oauth_app("twitter",key = "8p2mcx18rrnOPUPWZOsuJfD7w",
                  secret = "OP8GlSPy8jUn29k5OEghLVQkyPPIaPjdtm1q66YJU8qf2QFvYY")
sig = sign_oauth1.0(
    myapp,token = '839833109734400000-1riY1LhZhM7kkGyn0sjjPOEI5C01AbH',
    token_secret = 'qhPOxsOUqCg6mrL0SDZn0fsua8LUb2W5q00Nr0XSBEvis')

## Get the home timeline
homeTL = GET('https://api.twitter.com/1.1/search/tweets.json',sig)

## Extract its contents
json1 <- content(homeTL)
json2 <- jsonlite::fromJSON(toJSON(json1))

json2

## Github API:
## Register an application at http://github.com/settings/applications
## Get your key and secret pair for authentication

myapp <- oauth_app("github","455aac01d95614a2dfce",
                   '1996d1c49ad35042797930c5a9810810a0759e66')
github_token <- oauth2.0_token(oauth_endpoints("github"),myapp)

req <- GET("https://api.github.com/users/kkalla/repos",config(token = 
                                                                  github_token))
stop_for_status(req)
json1 <- content(req)
json2 <- fromJSON(toJSON(json1))

str(json2)

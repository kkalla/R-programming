## Using instagram APIs
library(httr)
library(jsonlite)
library(RCurl)
library(rvest)
?oauth2.0_token
full_url <- oauth_callback()
print(full_url)

app_name <- "BDS"
client_id <- ""
client_secret <- ""
scope <- "public_content"

## Get access point
instagram <- oauth_endpoint(
    authorize = "https://api.instagram.com/oauth/authorize",
    access = "https://api.instagram.com/oauth/access_token"
)

myapp <- oauth_app(app_name,client_id, client_secret)

## Do the authentication
ig_token <- oauth2.0_token(instagram,myapp,scope=scope,
                           cache = FALSE)
token <- ig_token$credentials$access_token
user_name <- "fjarilflickans"
user_info <- fromJSON(
    getURL(
        paste(
    'https://api.instagram.com/v1/users/',user_name,
    '/?access_token=',token,sep=""
    )))
user <- read_html(user_info)

## 이런것 보다  'instaR' package를 써보쟈
## permission이 없으면 아무것도 못불러옴
devtools::install_github("pablobarbera/instaR/instaR")
library(instaR)

token <- instaOAuth(client_id,client_secret)
obama <- searchInstagram("obama",token,n=10,folder = "obama")

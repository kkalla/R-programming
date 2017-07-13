# rvest, httr
# install.packages("rvest")
library(rvest)
library(httr)

text1 <- GET("https://cran.r-project.org/web/packages/httr/index.html")
text2 <- read_html(text1)
text3 <- html_nodes(text2,xpath = "//h2")
str(text3)
?html_nodes

##네이버 뉴스 크롤링 하기
query <- "경기도+빅파이" # 검색어.
naver <- GET(paste0("https://search.naver.com/search.naver?where=news&sm=tab_jum&ie=utf8&query=",
                    query))
text_naver <- read_html(naver)
text_naver2 <- html_nodes(text_naver,xpath = "body/div/div/div/div/div/a")
text_naver2 <- text_naver2[10]
html_attr(text_naver2,'href')

url <- "https:"
searchUrl <- paste(url,html_attr(text_naver2,'href'),sep="")
naver <- GET(searchUrl)
text_naver <- read_html(naver)
text_naver2 <- html_nodes(text_naver,xpath = "body/div/div/div/div/div/a")


## Google crawling

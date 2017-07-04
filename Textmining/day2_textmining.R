## Textmining
setwd('Textmining')
rm(list=ls())
library(KoNLP)
library(wordcloud)
library(stringi);library(stringr)

textdata <- readLines('big.txt',encoding='UTF-8')

## 사전(Dictionary)작업이 필요.
## 신조어, 분야별 전문용어 등록

## mergeUserDic(data.frame(c("빅데이터","ncn"))) - 
## It cannot be used in new version
buildDictionary(user_dic = data.frame(c("빅데이터","ncn")),
                replace_usr_dic = TRUE)


## Text handling using
## gsub, grep - function / stringr - package
## Capital to lower
textdata_low <- str_to_lower(textdata)

# 유사단어(ex. 사투리)를 한 단어로 통일

textdata_1<-gsub("빅데이타","빅데이터",textdata_low)
textdata_1<-gsub("bigdata","빅데이터",textdata_1)
textdata_1<-gsub("big data","빅데이터",textdata_1)

# 불필요한 단어들 제거(특수문자 등)

textdata_1<-gsub("[[:digit:]]","",textdata_1)
textdata_1<-gsub("[[:punct:]]","",textdata_1)
textdata_1<-gsub("[A-z]","",textdata_1)
# [[:graph:]] = [:alnum:] & [:punct:]
## textdata_1<-gsub("[(a(\\d)+)]","",textdata_1) - 특정 pattern 지우기

# "  " 스페이스(2개 짜리)를 하나짜리로

textdata_1 <- gsub("  "," ",textdata_1)



textdata_no0 <- textdata_1[str_length(textdata_1)>1]


## Extract noun -> make table(frequence) -> make wordcloud or plot

textdata_noun <- extractNoun(textdata_no0)
freq_table <- table(unlist(textdata_noun))
freq_table_sorted <-sort(freq_table,decreasing = TRUE)

freq_table_sorted<- freq_table_sorted[str_length(names(freq_table_sorted))>1]


wordcloud(names(freq_table_sorted),
          freq_table_sorted,random.order = F,
          scale = c(5,0.5),min.freq = 3,rot.per = 0.2,
          colors = colorRampPalette(brewer.pal(8,"Blues"))(1000))

install.packages("wordcloud2")
library(wordcloud2)
str(demoFreq)
wordcloud2(demoFreq,size=2,color=colorVec,backgroundColor = "grey")
colorVec = rep(c('red','skyblue'),length.out=nrow(demoFreq))
head(demoFreq)

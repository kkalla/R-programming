##Text mining

##remove enviroment
##rm(list=ls())

## packages
##install.packages("KoNLP",dependencies = TRUE)
##install.packages("wordcloud")
install.packages("colorRampPalette")

library(KoNLP)
library(wordcloud)
library(RColorBrewer)
library(colorPalette)



## Reading lines
big <- readLines('Statistic/big.txt',encoding='UTF-8')
str(big)

big_n0<-big[nchar(big)>1]
## Extracting Noun after use Sejong Dictionary
useSejongDic()

str(big_ext)
head(big_ext)
## Frequency table
big_table<-table(unlist(big_ext))

## Make wordcloud
wordcloud(names(big_table),big_table,colors = 
              colorRampPalette(brewer.pal(10,"Spectral"))(length(big_table)))
?colorRampPalette

##Use gsub to chage EN to Korean
txt1 <- gsub("bigdata","빅데이터",big_n0)
txt1 <- gsub("[A-z]","",txt1)
txt1 <- gsub("[[:digit:]]","",txt1)
txt1 <- gsub("[[:punct:]]","",txt1)
txt1 <- gsub("  "," ",txt1)
big_ext<-extractNoun(txt1)
big_table<-table(unlist(big_ext))
wordcloud(names(big_table),big_table,colors = 
              colorRampPalette(brewer.pal(9,"BuPu"))(length(big_table)))

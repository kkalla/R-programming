##rm(list=ls())

# Big data analysis example (Using Clustering and EDA)

## Reading data from csv files
librarys <- c("plyr","ggplot2","stringr","lubridate","corrplot","RColorBrewer")
unlist(lapply(librarys,require,character.only=T))
##install.packages("corrplot")

product <- read.csv("C:/Users/Ajou/Desktop/product_2015_data/product.csv",
                    fileEncoding = "UTF-8",header = T)
code <- read.csv("C:/Users/Ajou/Desktop/product_2015_data/code.csv",
                 fileEncoding = "UTF-8",header = T)
weather <- read.csv("C:/Users/Ajou/Desktop/product_2015_data/weather.csv",
                 fileEncoding = "UTF-8",header = T)
head(product,n=10)
str(product)
head(code,n=10)
str(code)
head(weather,n=10)
str(weather)
sum(is.na(weather$일자))
weather$일자 <- ymd(weather$일자)
na_weather <- is.na(weather$일자)
old[na_weather]

product$date <- as.Date.character(product$date,format = "%Y-%m-%d")

## Change variable names
colnames(product) <- c('date','category','item','region','mart','price')
category <- subset(code,code$구분코드설명=="품목코드")
colnames(category) <- c("code",'exp','item','name')

total_pig <- product[which(product$item==514),]
region <- subset(code,code$구분코드설명=="지역코드")
colnames(region) <- c('code','exp','region','name')

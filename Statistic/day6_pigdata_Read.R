
rm(list=ls())
# Big data analysis example (Using Clustering)

##rm(list=ls())

# Big data analysis example (Using Clustering and EDA)
# Download data from below link
# https://kbig.kr/edu_manual/html/data/product_2015_data.zip


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



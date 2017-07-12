################################################################################
####            클러스터링 기법을 이용한 농축산물 데이터 분석               ####
#reference: "빅데이터 분석: 농산물편", 미래창조과학부, NIA, K-ICT 빅데이터센터 #
################################################################################

# Download data from below link
# https://kbig.kr/edu_manual/html/data/product_2015_data.zip
#rm(list= ls())
#install.packages("TSclust")

# Importing libraries and Reading data
library3 <- c("plyr","TSclust","zoo","ggplot2")
unlist(lapply(library3,require,character.only = TRUE))

pig_region <- read.csv("C:/Users/Ajou/Desktop/product_2015_data/pig.region.csv",
                       header = T,fileEncoding = "UTF-8")[,-1]
pig_region_monthly_mean <- 
    read.csv("C:/Users/Ajou/Desktop/product_2015_data/pig.region.monthly.mean.csv",
             header = T,fileEncoding = "UTF-8")[,-1]
date_item_mean <- 
    read.csv("C:/Users/Ajou/Desktop/product_2015_data/date.item.mean.csv",
             header = T,fileEncoding = "UTF-8")[,-1]
month_item_mean <- 
    read.csv("C:/Users/Ajou/Desktop/product_2015_data/month.item.mean.csv",
             header = T,fileEncoding = "UTF-8")[,-1]
head(pig_region)
head(pig_region_monthly_mean)
head(date_item_mean)

# Data processing
temp <- dlply(date_item_mean,.(name),summarise,mean.price)
farm_product <- as.data.frame(temp[!names(temp) %in% c("닭고기","돼지고기")])
colnames(farm_product) <- names(temp)[-c(1,2)]
str(farm_product)

# hierarchical clustering
plot(hclust(diss(farm_product,"COR")))


################################################################################
##                  날씨 자료와 농산물 자료의 인과관계 분석                   ##
################################################################################
##install.packages('dygraphs')
library(stringr);library(dygraphs);library(xts)


100000+9000+20000+10000+80000+20000+9000+50000

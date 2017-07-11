##rm(list = ls())

## Error message "invalid multibyte character in parser" is caused by
## encoding problem. So, change default encoding to UTF-8

source('Statistic/day6_pigdata_Read.R',encoding="UTF-8")
source('Statistic/day7_pigdata_Handling.R',encoding="UTF-8")
library(dplyr)
library(zoo)
pig_region_monthly_mean$month <- 
    as.Date(as.yearmon(pig_region_monthly_mean$month,"%Y-%m"))
str(pig_region_monthly_mean)

## mean price by month

g <- ggplot(pig_region_monthly_mean,
            aes(month,mean_price,color = name,group = name))
g + geom_line()+theme_bw()+geom_point(size=6,shape = 20,alpha = .5)+
    ylab("돼지고기 가격") + xlab("")

## mean price by year
g <- ggplot(pig_region_yearly_mean,
            aes(year,mean_price,color = name,group = name))
g + geom_line()+theme_bw()+geom_point(size=6,shape = 20,alpha = .5)+
    ylab("돼지고기 가격") + xlab("")
## barplot
g2 <- ggplot(pig_region_yearly_mean,aes(name,mean_price,fill = factor(year)))
g2 + geom_bar(stat = "identity",position = "dodge",color = "white")
?melt

## corrplot
library(corrplot)

temp <- plyr::dlply(pig_region_daily_mean,.(name),select,mean_price)
temp2 <- as.data.frame(temp)
colnames(temp2) <- attr(temp,"split_labels")$name
cor_pig <- cor(temp2)
corrplot(cor_pig,method = "color",type = "upper",order = "hclust",
         addCoef.col="white",tl.srt=0,tl.col="black",tl.cex=.7,
         col=brewer.pal(n=8,name="PuOr"))

## data saving
write.csv(temp2,"Statistic/pig_region.csv",fileEncoding = "UTF-8")
write.csv(pig_region_monthly_mean,"Statistic/pig_region_monthly_mean.csv",
          fileEncoding = "UTF-8")

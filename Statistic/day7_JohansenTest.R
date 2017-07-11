library2 <- c("plyr","stringr","urca","ggplot2","zoo","gridExtra")
unlist(lapply(library2,require,character.only=TRUE))
##install.packages("urca")
library(dplyr)

## read files
product <- read.csv("C:/Users/Ajou/Desktop/product_2015_data/product.csv",
                    fileEncoding = "UTF-8")
code <- read.csv("C:/Users/Ajou/Desktop/product_2015_data/code.csv",
                 fileEncoding = "UTF-8")

## change col names and calculate mean of price by item and date
colnames(product) <- c("date",'category','item','region','mart','price')
temp <- ddply(product,.(item,date),summarise,mean_price = mean(price))

## Make category dataset and change col names
category <- subset(code, code$구분코드설명=="품목코드")
colnames(category) <- c('code','exp','item','name')

date_item_mean <- merge(temp,category, by = 'item')

## Monthly data
month_item_mean <- ddply(
    date_item_mean,.(name,item,month = str_sub(as.character.Date(date),1,7)),
    summarise, mean_price = mean(mean_price))

## data for analysis(Johansen Procedure for VAR = Johansen test)
temp <- dlply(date_item_mean,.(name),select,mean_price)
daily_product <- as.data.frame(temp)
colnames(daily_product)<- names(temp)
str(daily_product)

for (i in 1:9){
    for(j in 1:9){
        if((i+j)<11){
            jc <- ca.jo(data.frame(daily_product[,i],daily_product[,i+j]),
                        type = "trace",K = 2,ecdet = "const")
            if(jc@teststat[1] > jc@cval[1]){
                if(jc@V[1,1]*jc@V[2,1]>0){
                    cat(colnames(daily_product)[i],'와',
                        colnames(daily_product)[i+j],": \'음\'의 공적분. \n")
                }else{
                    cat(colnames(daily_product)[i],'와',
                        colnames(daily_product)[i+j],": \'양\'의 공적분. \n")
                }
            }
        }
    }
}

## 조금더 살펴보면
output <- ca.jo(data.frame(daily_product[,3], 
                           daily_product[,4]), type="trace", K=2, ecdet="const") 
summary(output)
str(output)
corrplot::corrplot(cor(daily_product),method = "number",type = "upper")

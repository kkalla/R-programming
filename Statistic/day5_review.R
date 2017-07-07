# Review

##rm(list=ls())

library(MASS)
data(sleep)
var.test(sleep[sleep$group==1,]$extra,sleep[sleep$group==2,]$extra)
with(sleep,{
    t.test(extra~group,paired = TRUE,var.equal = TRUE,conf.level = .99)
})
?read.xlsx

g2 <- read.xlsx('PM10.xlsx',2,encoding = 'UTF-8',endRow = 31)
colnames(g2) <- c('location',paste('H',1:24))
g2
mean_row <- apply(g2[,-1],1,function(x) mean(x,na.rm = T))
for(i in 1:nrow(g2)){
    g2[i,is.na(g2[i,])] <- mean_row[i]
}
## install.packages('XML')
library(XML)
library(stringr)
library(httr)
fileUrl <- 'http://www.kma.go.kr/weather/asiandust/graph_exel.jsp?area=2&stnId=0&&tm=2017.07.06.'
file.create('pm.csv')
download.file(fileUrl,'pm.csv')

pm <- read.csv('pm.csv',encoding = 'UTF-8')
htmlCode = readLines('pm.csv',encoding = 'UTF-8')
htmlCode <- htmlCode[str_length(htmlCode)>0]
parsedHtml <- htmlParse(htmlCode,encoding = "UTF-8")
a <- xpathSApply(parsedHtml,"//tr",xmlValue)
a

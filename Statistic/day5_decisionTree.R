# Decision Tree

install.packages('rpart')
install.packages('rpart.plot')

library(rpart);library(rpart.plot)

# Species를 기반으로 데이터를 분리
m1 <- rpart(Species~.,data=iris)
m1

# Make graph
prp(m1,type=4,extra=2,digit=3)

# Species를 기반으로 Sepal.Length에 맞추어 분리
m3 <- rpart(Species~Sepal.Length,data=iris)
m3
prp(m3,type=4,extra=2,digit=3)
library(httr)
library(grDevices)
library(graphics)

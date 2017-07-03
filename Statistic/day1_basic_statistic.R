getwd()
x<-table(iris$Species)
Sys.Date()
x3<-1:10
x3[2]
m2 <- matrix(1:15, nrow = 3,ncol=3,byrow = F)
str(iris)
?data.frame
##MEAN
x1<-c(1,2,3,4,5,4,3,6,7,8,9,1000)
sum(x1)/length(x1)
##median
median(x1)
summary(iris)
sd(iris$Sepal.Length)
sd(x1)
x1<-c(3:1)                                          
x2<-c(98,90,95)


##Random Sampling
sample(1:45,6)
ind <- sample(1:nrow(iris),150)
A1 <- iris[ind,]
View(iris)
View(A1)
        
ind1 <- sample(1:nrow(iris),nrow(iris)*0.7)
train <- iris[ind1,]
test <- iris[-ind1,]

##Descriptive Statistic
summary(iris)
install.packages("ggplot2")
hist(iris$Petal.Length)
scatter.smooth(iris$Petal.Length)
boxplot(iris[,1:4])
help(package=plyr)

##Normalize
A2 <- iris
A2[,1:4] <- scale(A2[,1:4])
A2
summary(A2)
boxplot(A2)

levels(iris$Species)

##Example data "survey" in package 'MASS'
library(MASS)
help(package = MASS)
str(survey)
data("survey")
t1<-table(survey$Sex,survey$Smoke)

##Probability of table t1 by column
prop.table(table(survey$Sex,survey$Smoke),2)
barplot(t1)
stem(survey$Wr.Hnd)

##Truncated Mean
n <- round((length(iris$Sepal.Length)*0.1)/2,0)
sorted<-sort(iris$Sepal.Length)[(n+1):(length(iris$Sepal.Length)-n)]
length(sorted)

##Measurement of Dispersion
hist(rnorm(1000))
?qnorm

##Correlation Coefficient
cor(iris[,1:4])
cor.test(iris$Sepal.Length,iris$Petal.Length)

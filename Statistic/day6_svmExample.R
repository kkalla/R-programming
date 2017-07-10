##rm(list=ls())
# SVM example

set.seed(200)
train <- iris[ind<-sample(nrow(iris),nrow(iris)*.7),]
test <- iris[-ind,]

svm <- svm(Species~.,train)
pred <- predict(svm, newdata=test)
summary(svm)
t1 <- table(test$Species,pred)
# 정분류율
sum(diag(t1))/sum(t1)
str(svm)

## non-equal variance
x1 <- seq(0,2*pi,0.01)
data <- data.frame()
for(i in x1){
    e <- rnorm(10,0,sample(1:4,1,replace=TRUE))
    y <- 2*sin(i) + e
    x2 <- rep(i,10)
    data1 <- cbind(x2,y)
    data <- rbind(data,data1)
}
plot(data,cex=.2)

svm2 <- svm(y~x2,data)
pred2 <- predict(svm2,newdata=data)
points(data$x2,pred2,col = "#F6AB0F",cex=.5)

y2 <- data$y - pred2
data3 <- cbind(data,y2)
svm_e <- svm(y2~x2,data3)
pred3 <- predict(svm_e,newdata = data3)
y_hat = pred2 + pred3
points(data3$x2,y_hat,col = "BLUE",cex=.6)

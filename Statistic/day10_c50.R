###############################################################################
## Example - identifying risky bank loans using C5.0 decision trees          ##
## Machine Learning with R 2nd Ed, Brett Lantz, 2015, Packt Publishing       ##
###############################################################################

##install.packages("C50")
credit_data <- read.csv("credit.csv")
str(credit_data)

train <- credit_data[ind <- sample(1000,900),]
test <- credit_data[-ind,]

library(C50)
model1 <- C5.0(x = train[,-17],
               y = train[,17])
model2 <- C5.0(y = train$default,
               x = train[,c(1,11,3,2,4)])

pred1 <- predict(model1,newdata=test)
pred2 <- predict(model2,newdata = test)
summary(model2)

library(party)
ctree1 <- ctree(default~.,data=train)
summary(ctree1)
ctree1
pred3 <- predict(ctree1,test)
table(test$default,pred3)

library(e1071)
model3 <- naiveBayes(x = train[,-17],y = train[,17])
summary(model3)
pred4 <- predict(model3 , newdata = test)
table(test$default,pred4)

library(randomForest)
model4 <- randomForest(x = train[,-17],y = train[,17])
summary(model4)
pred5 <- predict(model4,newdata = test)
table(test$default,pred5)

################################################################################
######## Vowel data
################################################################################
library(mlbench)
data(Vowel)

ind <- sample(nrow(Vowel),nrow(Vowel)*.7)
train <- Vowel[ind,]
test <- Vowel[-ind,]

## C5.0
c50model <- C5.0(y = train$Class,x = train[,-11])

## Naive Bayse
navmodel <- naiveBayes(x = train[,-11],y = train[,11])

## randomForest
rdfmodel <- randomForest(x = train[,-11],y = train[,11])

##Predict
pred1 <- predict(c50model,test)
pred2 <- predict(navmodel,test)
pred3 <- predict(rdfmodel,test)
pred <- c(pred1,pred2,pred3)
t1 <- table(test$Class,pred1)
correct <- sum(diag(t1))/sum(t1)
correct;t1


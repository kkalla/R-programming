# Logistic regression
data <- iris[1:100,]
data$Species <- factor(data$Species)
levels(data$Species)
m <- glm(Species~.,data=data,family = 'binomial')
fitted(m)[c(1:5,51:55)]

# make train set and test set
set.seed(1000)
train <- data[ind <- sample(1:nrow(data),nrow(data)*.7),]
test <- data[-ind,]

# logistic regression model using train
m <- glm(Species~.,data=train,family = 'binomial')
summary(m)
m$fitted.values

train_y <- ifelse(m$fitted.values >= 0.5,2,1)
table(train_y,train$Species)

# Predict y of test set
pred1 <- predict(m,newdata = test, type = 'response')
test_y <- ifelse(pred1 >= 0.5,2,1)
table(test_y,test$Species)

# Multinomial logistic regression
library(nnet)
train <- iris[ind <- sample(1:nrow(iris),nrow(iris)*.7),]
test <- iris[-ind,]

m <- multinom(Species~.,data = train)
str(m)
summary(m)
m$fitted.values
m_class <- max.col(m$fitted.values)
table(m_class,train$Species)

pred2 <- predict(m,newdata=test,type = "class")
table(test$Species,pred2)

library(mlbench)
data("Sonar")
str(Sonar)
head(Sonar)
sonar_train <- Sonar[int <- sample(1:nrow(Sonar),nrow(Sonar)*.7),]
sonar_test <- Sonar[-int,]
levels(sonar_train$Class)
m <- glm(Class~.,data = sonar_train,family = "binomial")


train_y<-ifelse(m$fitted.values>=0.5,"R","M")
table(train_y,sonar_train$Class)

pred3 <- predict(m,newdata=sonar_test,type = "response")
test_y <- ifelse(pred3>=.5,"R","M")
t1 <- table(test_y,sonar_test$Class)
sum(diag(t1))/sum(t1)

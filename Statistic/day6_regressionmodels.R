# Regression models
cars
plot(cars)
cor.test(cars$speed,cars$dist)

model <- lm(dist~speed,cars)
abline(reg = model,col = "BLUE", lwd = 3)
##text(10,10,labels = paste("intercept = ",model$coefficients[1]))
##text(20,80,labels = paste("beta1 = ",model$coefficients[2]))
summary(model)
residuals(model)
par(mfrow=c(1,1))
plot(model, which = 1,xlim = c(20,60))

#____________________________________________________________________________#

## Durbin-Watson test
library(car)
durbinWatsonTest(model$residuals)
?durbinWatsonTest

#____________________________________________________________________________#

## Predict
predict(model, newdata = data.frame(speed = c(3,7)))

#____________________________________________________________________________#

## Multiple Linear Regression
set.seed(200)
n <- nrow(iris)
ind <- sample(1:n,n*.7,replace=F )
train <- iris[ind,] 
test <- iris[-ind,]

model_m <- lm(Sepal.Length ~ Petal.Length,
              data = train)
model_f <- lm(Sepal.Length ~ Petal.Length+Sepal.Width+Petal.Length,
              data = train)
summary(model_m)
plot(model_m)
durbinWatsonTest(model_m$residuals)

vif(model_m)

## Another example
library(mlbench)
data("BostonHousing")
str(BostonHousing)
m <- lm (medv~.,data=BostonHousing)
m2 <- step(m,direction = "both")

m3 <- step(lm(medv~1,BostonHousing),direction = "forward",
     scope = "~crim+zn+indus+chas+nox+rm+dis+rad+tax+ptratio+b+lstat")
summary(m3)

## outlierTest() - outlier 검출
o1 <- outlierTest(m)
o2 <- as.numeric(names(o1$rstudent))
b2 <- BostonHousing[-o2,]
m2 <- lm (medv~.,data=b2)
outlierTest(m2)
plot(m2)

## Predict
pred_m <- predict(model_m, newdata = test)
pred_f <- predict(model_f, newdata = test)

mse1 <- mean((test$Sepal.Length - pred_m)^2)
mse2 <- mean((test$Sepal.Length - pred_f)^2)

RMSE1 <- sqrt(mean((test$Sepal.Length - pred_m)^2))
RMSE2 <- sqrt(mean((test$Sepal.Length - pred_f)^2))
c(mse1,mse2,RMSE1,RMSE2)

#__________________________________________________________________________#

# mixlm Package - Mixed model ANOVA and Statistics for education.
install.packages("mixlm")
library(mixlm)

#__________________________________________________________________________#

# Regression on categorical variables
library(stats)
levels(train$Species)
d1 <- lm(Sepal.Length~.,data=train)
summary(d1)

## Plot multiple regression models
with(train, plot(Sepal.Width,Sepal.Length, cex = .7,
                 pch = as.numeric(Species)))
legend("topright",levels(train$Species),pch=1:3,bg="white")
model <- lm(Sepal.Length~Sepal.Width + Species,data=train)
coef <- coef(model)
abline(coef[1],coef[2])
abline(coef[1]+coef[3],coef[2],lty=2)
abline(coef[1]+coef[4],coef[2],lty=3)

## Predict
pred_setosa <- predict(model, newdata = test[test$Species=="setosa",c(2,5)])
points(test[test$Species=="setosa",c(2)],pred_setosa,col = "RED",pch = 1)
points(test[test$Species=="setosa",c(2)],
       test[test$Species=="setosa",c(1)],
       col = "BLUE",pch = 4)

#__________________________________________________________________________#

# Nonlinear Regression
?seq
x <- sample(seq(0,2*pi,0.01),1000,replace=TRUE)
y <- sin(x)
e <- rnorm(50,0,1)
y_e <- y+e
plot(x,y_e)
x1 <- seq(0,2*pi,0.01)
data <- data.frame()
for(i in x1){
    e <- rnorm(10,0,1)
    y <- sin(i) + e
    x2 <- rep(i,10)
    data1 <- cbind(x2,y)
    data <- rbind(data,data1)
}
## Linear regression으로 라인을 구하면 직선이 나온다.
plot(data,cex=0.1)
non1 <- lm(y~x2,data)
abline(reg = non1)

## e1071 Package
install.packages("e1071")
library(e1071)
##svm은 선형, 곡선, 분류에도 쓰인다. (ex, 번호판인식, 시계열분석)
svm1 <- svm(y~x2,data)
summary(svm1)
dim(data)
## 곡선으로 점이 찍히는 것을 볼 수 있다.
lines(data$x2,svm1$fitted,col = "#FF0FF0",lwd = 2)
pred1 <- predict(svm1,newdata = data)
points(data$x2,pred1,pch=3,cex=.5,col = "VIOLET")
points(x<-sample(data$x2,100),sin(x),pch='#',cex=.5,col = "BLUE")

## lm 과 svm의 비교
non_svm <- lm(y ~ x2,data)
pred2 <- predict(non_svm,newdata=data)
points(data$x2,pred2,pch=18,cex=.5,col = "GREEN")
rmse_s <- sqrt(mean((data$y-pred1)^2))
rmse_l <- sqrt(mean((data$y-pred2)^2))
c(rmse_s,rmse_l)
                                    
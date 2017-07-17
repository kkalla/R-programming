## SVM tutorial in R 
## https://www.svm-tutorial.com/2014/10/support-vector-regression-r/

data <- read.csv("svm.csv")

# plot points
plot(data, pch=16)
model <- lm(Y~X,data)
abline(model)

# svm
library(e1071)
?svm
model <- svm(Y~X , data)
predictedY <- predict(model,data)

model$coefs

## MSE, RMSE
rmse <- function(error){
    sqrt(mean(error^2))
}

error <- model$residuals
predictionRMSE <- rmse(error)

points(predictedY, pch = 'x',col = 'violet')

model_1 <- svm(Y ~ X, data, kernel = "sigmoid")
predictedY_1 <- predict(model_1,data)
points(predictedY_1, pch = '*',col = 'blue')

model_2 <- svm(Y ~ X, data, kernel = "sigmoid")
predictedY_2 <- predict(model_2,data)
points(predictedY_2, pch = 's',col = 'green')

## tuning model
tuneResult <- tune(svm, Y~X, data= data, 
                   range=list(epsilon = seq(0,0.2,0.01),cost = 2^(2:9)))
print(tuneResult)
plot(tuneResult)

tunedModel <- tuneResult$best.model
tunedModelY <- predict(tunedModel, data)
points(tunedModelY,pch = 'o',col = 'red')
lines(tunedModelY)
lines(predictedY,col = 'violet')
rmse(tunedModel$residuals)
rmse(error)
?tune

## Time series data
data1 <- seq(1,500,2)
d1 <- array(dim = c(80,6))
for(i in 1:80){
    d1[i,] <- data1[i:(i+5)]
}

X = d1[,1:5]
y = d1[,6]

model1 <- svm(x=X[1:60,],y = y[1:60],kernel = "linear")
pred <- predict(model1,newdata = X[61:80,])
result <- cbind(y[61:80],pred)
str(result)
head(result)

## svm tutorial using Ozone data
data(Ozone, package = "mlbench")
head(Ozone)
O3 <- na.omit(Ozone)
O3$V1 <- as.numeric(O3$V1)
O3$V2 <- as.numeric(O3$V2)
O3$V3 <- as.numeric(O3$V3)
nn <- nrow(O3)
train <- O3[1:(nn*0.7),]
test <- O3[-(1:(nn*.7)),]

svm_model <- svm(V4~.,train,cost=10,gamma=1e-02)
error <- train$V4 - svm_model$fitted
rmse(error)
svm_pred <- predict(svm_model, newdata= test)
error <- test$V4 - svm_pred
rmse(error)

## svm tutorial using weather data
library(httr)
library(rvest)
url <- GET("http://www.kma.go.kr/weather/climate/past_table.jsp?stn=119&yy=2015&obs=07&x=24&y=7")
## input conversion error 발생시 encoding 명시해줘야
weather <- read_html(url,encoding = "EUC-KR")
## html에서 table노드만 뽑아
weather_table <- html_node(weather,"table.table_develop")
## table -> data frame 으로 변환
weather_table3 <- html_table(weather_table,header = FALSE)
## invalid multibyte string 오류시 해결방법.(한글때문인것같다.)
## Sys.setlocale(category = "LC_ALL", locale = "us")
##########
install.packages("neuralnet")

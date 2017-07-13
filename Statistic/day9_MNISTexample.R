# rm(list=ls())
# MNIST data example
fileUrl1 <- "https://github.com/ozt-ca/tjo.hatenablog.samples/raw/master/r_samples/public_lib/jp/mnist_reproduced/short_prac_test.csv"
fileUrl2 <- "https://github.com/ozt-ca/tjo.hatenablog.samples/raw/master/r_samples/public_lib/jp/mnist_reproduced/short_prac_train.csv"

file.create("short_prac_train.csv")
file.create("short_prac_test.csv")
download.file(fileUrl2,"short_prac_train.csv")
download.file(fileUrl1,"short_prac_test.csv")

train <- read.csv("short_prac_train.csv")
test <- read.csv("short_prac_test.csv")
train$label <- factor(train$label)
test$label <- factor(test$label)
str(train)

r_train <- randomForest(label~.,train)
str(r_train)

pred_test <- predict(r_train,newdata = test)
table(pred_test,test$label)

train2 <- train
train2[,-1] <- round(train2[,-1]/255,0)
str(train2)
test2 <- test
test2[,-1] <- round(test2[,-1]/255,0)
start_time <- Sys.time()
r3 <- randomForest(label~.,train2)
end_time <- Sys.time()

start_time-end_time
pred3 <- predict(r3,newdata = test2)
t3 <- table(pred3,test2$label)
sum(diag(t3))/sum(t3)

# five <- train[train$label=="7",-1]
# five <- five[100,]
# five_mat <- as.matrix(five)
# five_mat <- matrix(five_mat, nrow = 28,ncol = 28)
# str(five_mat)
# image(x = c(1:28),y = c(1:28),z = five_mat,
#       col = gray(seq(0,1,0.01)))
# ?image


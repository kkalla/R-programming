fileUrl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data"
file.create("wdbc.txt")
download.file(fileUrl,"wdbc.txt")
?read.csv
wdbc_data <- read.csv("wdbc.txt",header = F,stringsAsFactors = T,
                      na.strings = "none")
cols <- rep(c('mean','SE','worst'),each = 10)
cols2 <- rep(c('radius','texture','perimeter','area','smoothness','compactness',
           'concavity','concave_points','symmetry','fractal_dimension'),3)
names <- paste(cols2,cols,sep="_")
colnames(wdbc_data) <- c('id','diagnosis',names)
str(wdbc_data)
head(wdbc_data)

## Normalize
wdbc_n <- wdbc_data
wdbc_n[,-c(1,2)] <- scale(wdbc_n[,-c(1,2)])
head(wdbc_n)

train <- wdbc_n[1:(nrow(wdbc_n)*.7),]
test <- wdbc_n[-(1:(nrow(wdbc_n)*.7)),]

## k-nn clustering
library(class)
pred <- knn(train[,-c(1,2)],test[,-c(1,2)],train[,2],k=3)

## Correctness
t1 <- table(test[,2],pred)
correctness <- sum(diag(t1))/sum(t1)

## find optimized k
correctness <- numeric(length = 10)
tt <- data.frame()
for(j in 1:10){
    for(i in 1:10){
        pred_i <- knn(train[,-c(1,2)],test[,-c(1,2)],train[,2],k=i)
        t1 <- table(test[,2],pred_i)
        correctness[i] <- sum(sum(diag(t1))/sum(t1))
    }
    tt<-rbind(tt,correctness)
}
tt


## Clustering example
a<-c(1,6);b<-c(2,4);c<-c(5,7);d<-c(3,5);e<-c(5,2);f<-c(5,1)
data <- data.frame(a,b,c,d,e,f)
data <- t(data)
d <- dist(data)
h <- hclust(d,method = 'single')
plot(h)
str(h)
k1 <- kmeans(iris[,1:4],centers = 3,iter.max = 10000)
?kmeans


table(iris$Species,k1$cluster)
k1$centers
plot(ki$centers[,c(1,3)],col = ki$centers,pch = 4,cex=5)

k0 <- data.frame()

for(i in 1:6){
    ki <- kmeans(iris[,1:4],centers = 3,iter.max = 100)
    ki_totwithin <- cbind(i,ki$tot.withinss)
    k0 <- rbind(k0,ki_totwithin)
    
    plot(ki$centers[,c(1,3)],col = ki$centers,pch = 5,cex=5)
    points(iris[,c(1,3)],col = iris$Species)
    Sys.sleep(5)
}
##############################################################################
##                          Tutorial with snsdata                           ##
## reference: Machine learning with R, second Ed, Brett Lantz               ##
##############################################################################

### download and read data
fileUrl <- "https://github.com/stedy/Machine-Learning-with-R-datasets/raw/master/snsdata.csv"
file.create("snsdata.csv")
download.file(fileUrl,"snsdata.csv")
teens <- read.csv("snsdata.csv")
str(teens)

### explore and prepare data
table(teens$gender,useNA = "ifany")
summary(teens$age)

#### 십대들만 데이터셋에 포함시키기위해 13~20세 범위를 벗어나는 나이를 NA로
teens$age <- ifelse(teens$age >= 13 & teens$age < 20, teens$age, NA)
summary(teens$age)

#### Dummy coding missing values
teens$female <- ifelse(teens$gender == "F" & !is.na(teens$gender),1,0)
teens$no_gender <- ifelse(is.na(teens$gender),1,0)
table(teens$gender,useNA = "ifany")
table(teens$female,useNA = "ifany")
table(teens$no_gender,useNA = "ifany")

#### Imputing the missing values
?aggregate
str(aggregate(data=teens,age~gradyear,mean,na.rm=TRUE))
##### aggregate() returns data frame               #####
##### so use ave() function instead of aggregate() #####
ave_age <- ave(teens$age,teens$gradyear,FUN = function(x) mean(x,na.rm = TRUE))
str(ave_age)
teens$age <- ifelse(is.na(teens$age),ave_age,teens$age)
summary(teens$age)

### training a model on the data
interest <- teens[,5:40]
interests_z <- scale(interest)
str(interests_z)
teen_clusters <- kmeans(interests_z,5)

### Evaluating model performance
table(teen_clusters$cluster) # size of each cluster
str(teen_clusters$centers)

### Finding optimal number of clusters
k_max <- 15
wss <- sapply(1:k_max,function(k){
    kmeans(interests_z,k,iter.max = 15)$tot.withinss
})
plot(1:k_max,wss,type="b",pch=19,frame = FALSE)

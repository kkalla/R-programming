## Write files
write.csv(iris,'data1') # or
write(iris, 'data1.csv')

## save() and load()
a1 <- iris
a2 <- cars
save(a1,a2,file='a.rdata')


## rbind(), cbind()
x1 <- matrix(1:15,nrow=5)
x2 <- matrix(1:15,nrow=5,byrow = T)

y1 <- rbind(x1,x2)
y2 <- cbind(x1,x2)

x3 <- c(1,2,3); x4<- c(4,5,6)
cbind(x3,x4);rbind(x3,x4)

## merge()
x <- data.frame(name1=c("a", "b", "c"), math=c(1, 2, 3))
y <- data.frame(name2=c("d", "b", "a"), english=c(4, 5, 6))
merge(x,y,by.x = 'name1',by.y = 'name2',all=T)

## subset() - factor values를 그대로 가져와서 주의해야 함.
s1 <- subset(iris,Species=='setosa')
s1$Species = factor(s1$Species)
str(s1)

## split()
s2 <- split(iris,iris$Species)
str(s2)

## sort(), order() - sort returns sorted vector, order returns sorted index
s3 <- c(15,2,4,8,5,15,3,8,5,1,84,5,1,54,15,3,54)
sort(s3,decreasing = F)
order(s3)
s3

## with(), within()
## attach(), detach(), search() - attach 시 바뀐 데이터프레임의 값은 detach하면 
## 원래 데이터프레임은 바뀌지 않는다.

## which() - returns index of row which satisfies condition, 
## which.max(), which.min() - return index of row 
## which has minimum or maximum value

## apply() - MARGIN = 1 => idicates rows, 2 indicates cols
## lapply() - returns list, sapply - friendly version of lapply 
## returns vector, matrix or array.
d <- matrix(1:9, ncol=3)
apply(d,1,sum)

## tapply - apply a function to each cell of a ragged array, that is 
## to each (non-empty) group of values given by a unique combination of the levels
## of certain factors
tapply(iris$Sepal.Length,iris$Species,sum)

## mapply - multivariate version of sapply. applies FUN to the elts of ...argument

##doBy package - 데이터를 그룹별로 나눈 뒤 각 그룹별로 함수를 호출.
##install.packages('doBy')
library(doBy)

##summaryBy()
summary(iris)
summaryBy(.~Species,iris,FUN = sum)

## sampleBy()
table(sample(1:20,200,replace = T,prob = c(1,5,5,rep(1,17))))
sampleBy(formula=Petal.Length~Species,data=iris,frac=0.01,systematic = T)

## aggregate(formula,data, FUN)

## stack() - 다수의 벡터를 하나의 벡토로 합치면서 관측값이 온 곳을 factor로 명시
## unstack(
##    x, form - 관측값~factor
## ) - reverse of stack()

## reshape2 package - melt(), cast()

##RMySQL package - dbConnect, dbListTables, dbGetQuery

## sqldf package
## install.packages('sqldf')
library(sqldf)
iris_2 <- iris
names(iris_2) <- gsub('[.]','_',names(iris)) #or names(iris) <- c('<col-names>')
sqldf("SELECT avg(Sepal_Length) FROM iris_2 WHERE Species = 'setosa'")
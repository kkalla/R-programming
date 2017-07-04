## IF, FOR, WHILE Clauses

## IF
x <- 5
if(x>6){
    print('true')
    print('hello')
}else {
    print('false')
    print('world')
}

## FOR

sum =0
for(i in seq(1,100,3)){
    sum = sum + i
    print(sum)
}

s = array(dim=c(1,50))
str(s)
for(i in 1:50){
    if(iris[i,1]>2) {
        s[1,i]=1
    }else {
        s[1,i]=0
    }
}

## Make function
add <- function(a,b){
    if(is.numeric(a) & is.numeric(b))
        return (a+b)
    else
        return (paste(a,b,sep=','))
}
add('col','row')


## vector operations
x = seq(-2*pi,2*pi,0.01)
y = sin(x) + rnorm(length(x))
plot(x,y)
setwd('..')

## File input & output
data1 <- read.table('clipboard',header = TRUE)
data2 <- read.csv('example_data.csv')
names(data2) <- c('A','B')
##install.packages('xlsx')
library(xlsx)
data3 <- read.xlsx('example_data.xlsx',sheetIndex=1)
str(data3)
data3


## Read image
install.packages('readbitmap')
library(readbitmap)
bmp1 <- read.bitmap('number7.bmp')
jpg <- read.bitmap('number7.jpg')
png <- read.bitmap('number7.png')
dim(bmp1)

jpg_m <- matrix(jpg,nrow = 1, byrow = T)
bmp_m <- matrix(bmp1,nrow=1,byrow=T)
png_m <- matrix(png,nrow = 1, byrow = T)
dim(png_m)
bmp_m[-(1:10)]

## listing files
list1 <- list.dirs('.',full.names=T)
list2 <- vector("list",length = length(list1))
for(i in 1:length(list1))
    list2[[i]] <- list.files(list1[i],full.names = TRUE,include.dirs = TRUE)
list2

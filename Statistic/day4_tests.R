# Probability Distribution in R
##rm(list=ls())

## normal distribution
options(digits = 3)
set.seed(100)
x1<-rnorm(100,0,3)
### make density plot 
plot(density.default(x1))
### basic statistics
mean(x1);median(x1)
quantile(x1,c(.25,.5,.75))
#### mode
a <- sample(factor(letters[1:4]),100,replace = TRUE)
pie(table(a),)
?pie
## Poisson distribution
### density
dpois(3,1)

#------------------------------------------------------------------------------#

# Sampling
ind1 <- sample(nrow(iris),nrow(iris),replace = F)
A1 <- iris[ind1,]
n1 <- nrow(A1)
train <- A1[1:(nrow(A1)*.7),]
test <- A1[-(1:(nrow(A1)*.7)),] 

ind2 <- sample(n1,n1*.7,replace = F)
train2 <- iris[ind2,]
test2 <- iris[-ind2,]

ind3 <- sample(2,n1,replace = TRUE,prob=c(.7,.3))
train3 <- iris[ind3==1,]
test3 <- iris[ind3==2,]

## Stratified Random Sampling
install.packages("sampling")
library(sampling)
### method = srswor(Stratified random sample without replacement)
x <- strata ( c ("Species" ) , size = c (3 , 3 , 3) , method = "srswor" ,
               data = iris )
getdata(iris,x)
### method = srswr with multi levels
iris$Species2 <- rep(1:2,75)
x1 <- strata(c("Species","Species2"),size=c(3,3,3,3,3,3),method="srswr",
             data=iris)
### It can be done by doBy::sampleBy() as same as strata()
library(doBy)
sampleBy(~Species+Species2,frac=.3,data=iris)

## Systematic Sampling
d1 <- data.frame()
for (i in seq(sample(1:10,1),150,10)){
    d2 <- iris[i,]
    d1 <- rbind(d1,d2)
}

#------------------------------------------------------------------------------#

# Contingency Table
d2 <- data.frame(x = sample(as.character(1:4),100,T),
                 y = sample(letters[1:4],100,T),
                 num = sample(1:10,100,TRUE))
table(d2$x,d2$y)
xt <- xtabs(num~x+y,data=d2)
margin.table(xt,2)
margin.table(xt)
prop.table(xt,2)


## Independent Test - Chi-squared test
library(MASS)
data("survey")
str(survey)
xt <- xtabs(~Sex+Exer,data=survey)
chi_test <- chisq.test(xt)
?chisq.test
str(chi_test)

## Fisher's Exact Test
chisq.test(xtabs(~W.Hnd+Clap,data=survey)) # prints warning message
fisher.test(xtabs(~W.Hnd+Clap,data=survey))

## McNemar Test
?mcnemar.test

#------------------------------------------------------------------------------#

# Goodness of Fit
## Chi Square Test
table(survey$W.Hnd)
chisq.test(table(survey$W.Hnd),p = c(.3,.7))

## Shapiro Wilk Test / nortest package에는 Anderson-Darling Test, 
## Pearson Chi-Squared Test 등의 정규성 검정 함수들이 있다.
shapiro.test(rnorm(1000))
shapiro.test(rbinom(5000,10,.3))

## Kolmogorov-Smirnov Test
ks.test(rnorm(100),rnorm(100))
ks.test(rnorm(100),runif(100))

## Q-Q Plot - 자료가 특정 분포를 따르는지를 시각적으로 검토.
x <- rnorm(1000,mean=10,sd=1)
par(mfrow = c(1,1))
qqnorm(x)
qqline(x,lty=2,col = "RED")
x2 <- rcauchy(1000)
qqnorm(x2)
qqline(x2,lty=2)

#------------------------------------------------------------------------------#

# Correlation Coefficient
## Pearson correlation coefficient
## cor() / symnum(cor())
install.packages("corrgram")
library(corrgram)
corrgram(cor(iris[,1:4]),type="corr",upper.panel = panel.conf)

## Spearman's Rank Correlation Coefficient
## - 순위를 사용해 상관계수를 비교하는 방식.
install.packages("Hmisc")
library(Hmisc)
m <- matrix(c((1:10),(1:10)^2),ncol = 2)
m
rcorr(m,type = "spearman")

## Kendal's Rank Correlation Coefficient
## - (X,Y) 형태의 순서쌍으로 데이터가 있을 때, concordant와 discordant의 비율
install.packages("Kendall")
library(Kendall)
Kendall(x<-c(1,2,3,4,5),y<-c(1,0,3,4,5))

## Correlation Test
cor.test(x,y,method = "pearson")

#------------------------------------------------------------------------------#

# Inference and Test
## One sample mean
ss1 <- survey[survey$Sex=='Male',"Height"]
f1 <- survey[survey$Sex=='Female',]
m1 <- survey[survey$Sex=='Male',]

ss1_complete <- na.omit(ss1)
t.test(ss1_complete,mu=178)
t.test(f1$Height,mu=165)
var.test(f1$Height,m1$Height)
t.test(f1$Height,m1$Height,var.equal = FALSE)

## Two independent samples mean
var.test(extra~group,data=sleep)
t.test(extra~group,data=sleep,var.equal = TRUE,paired=FALSE)
str(sleep)

sleep1 <- sleep[1:10,]
sleep1$group2 = sleep[11:20,1]
sleep1
t.test(sleep1$extra,sleep1$group2,var.equal = TRUE,paired = TRUE)

## Two samples variance

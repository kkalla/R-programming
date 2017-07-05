##rm(list=ls())
## Student's t-Test
library('MASS')
data(survey)
View(survey)

model1 <- t.test(survey$Height ~ survey$Sex, data = survey)

qnorm(0.05,lower.tail = FALSE)
qnorm(0.025,lower.tail=FALSE)
qnorm(0.005,lower.tail=FALSE)

## Hypothesis test
data1 <- rnorm(100,mean = 180, sd= 10)
data2 <- rnorm(100,mean = 178, sd = 5)
t.test(data1,mu=180)
var.test(x=data1,y=data2)
t.test(x=data1,y=data2,var.equal = FALSE)

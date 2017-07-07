cars

plot(cars)
lines(c(25:50),aa)
abline(model01,col = "RED",lwd = 4,lty=10)
aa<-as.numeric(aa <- predict(model01, newdata = data.frame(speed = c(25:50))))
model01 <- lm(dist ~speed,cars)
summary(model01)
model01$coefficients
?abline


g <- ggplot(cars,aes(dist,speed))
g+ geom_smooth(method = "lm") + geom_point()

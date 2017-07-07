# Compute Levene's test for homogeneity of variance across groups
install.packages('car')
library(car)
leveneTest(Sepal.Length~Species,data = iris)
?leveneTest
?aov

# Monte carlo Method
n <- 1000

area <- function(n){
    points <- array(dim = c(1000,3))
    for(i in 1:n){
        points[i,1:2]<-runif(2)
        if(sqrt(points[i,1]^2+points[i,2]^2)<1)
            points[i,3] <- 1
        else
            points[i,3] <- 2
    }
    return(points)
}

result <- area(n)
plot(result[,1],result[,2],col = result[,3])
points

############################################################
library(ggplot2)
##install.packages("lubridate")
library(lubridate)
?strftime

fileUrl <- 'https://archive.ics.uci.edu/ml/machine-learning-databases/00354/GPS%20Trajectory.rar'

go_track_trackspoints <- read.csv('GPS_Trajectory/go_track_trackspoints.csv')
go_track_tracks <- read.csv('GPS_Trajectory/go_track_tracks.csv',
                            stringsAsFactors = F)
head(go_track_tracks)
str(go_track_tracks)
str(go_track_trackspoints)
sub <- go_track_trackspoints
sub$time <- ymd_hms(sub$time)
sub$time <- format(sub$time,"%H:%M:%S")
go_track_tracks$rating<-factor(go_track_tracks$rating)
go_track_tracks$rating_bus<-factor(go_track_tracks$rating_bus)
go_track_tracks$rating_weather<-factor(go_track_tracks$rating_weather)
go_track_tracks$car_or_bus<-factor(go_track_tracks$car_or_bus)
range(go_track_tracks$rating_weather)

## 교통체증 - 복잡도에 따라 걸리는 시간이 차이나는지
sub <- go_track_tracks[,c(4,6,7)]
model <- aov(time~rating*rating_bus,data=sub)
tukey <- TukeyHSD(model,c('rating','rating_bus'))
plot(tukey)
leveneTest(time~rating_bus,sub)


## car_or_bus 에서 car 인 경우를 제외
sub2_car <- go_track_tracks[go_track_tracks$car_or_bus==1,]
sub2_bus <- go_track_tracks[go_track_tracks$car_or_bus==2,]
rm(sub2)

model2 <- aov(time~rating,data=sub2_car)
tukey2 <- TukeyHSD(model2,c('rating'))
plot(tukey2)

model3 <- aov(time~rating*rating_bus,data=sub2_bus)
tukey3 <- TukeyHSD(model3,c('rating','rating_bus'))
summary(model3)
plot(tukey3)
## weather 에서 비오는 경우 or 아닌경우
sub3_norm <- go_track_tracks[go_track_tracks$rating_weather==0,]
sub3_rain <- go_track_tracks[go_track_tracks$rating_weather==1,]
sub3_sunny <- go_track_tracks[go_track_tracks$rating_weather==2,]

model4 <- aov(time~rating*rating_bus,data=sub3_rain)
tukey4 <- TukeyHSD(model4,c('rating','rating_bus'))
summary(model4)
plot(tukey4)

model5 <- aov(time~rating*rating_bus,data=sub3_sunny)
tukey5 <- TukeyHSD(model5,c('rating','rating_bus'))
summary(model5)
plot(tukey5)

model6 <- aov(time~rating,data=sub3_norm)
tukey6 <- TukeyHSD(model6,c('rating'))
summary(model6)
plot(tukey6)
### 두 개의 factor에 따라 다른지 확인
var.test(as.numeric(rating)~rating_weather,rbind(sub3_rain,sub3_sunny))
sub3 <- rbind(sub3_rain,sub3_sunny)
t.test(as.numeric(rating)~rating_weather,sub3,var.equal = TRUE)

##
sub4 <- go_track_trackspoints[go_track_trackspoints$longitude > -40,
                              c("longitude","latitude")]
sub4 <- as.matrix(sub4)
fit <- kmeans(sub4,10)
str(fit)
sub4 <- as.data.frame(sub4)
sub4$cluster <- factor(as.numeric(fit$cluster))

g <- ggplot(sub4,aes(longitude,latitude,col = cluster))
g + geom_point()+ ylim(c(-11,-10.8))+ xlim(c(-37.1,-37))
?xlim

# ANOVA
library(MASS)
str(survey)

model1 <- aov(Pulse~Exer,data=survey)
summary(model1)

model2 <- aov(Sepal.Length~Species,data = iris)
summary(model2)

model3 <- aov(Pulse~Exer*Smoke,data = survey)
summary(model3)

#----------------------------------------------------------------------------#

# 사후검정
survey_tukey <- TukeyHSD(model2,'Species')
survey_tukey

#----------------------------------------------------------------------------#

library(reshape2)
g2 <- read.xlsx('PM10.xlsx',2,encoding = 'UTF-8',endRow = 31)
colnames(g2) <- c('location',paste('H',1:24))
g2
mean_row <- apply(g2[,-1],1,function(x) mean(x,na.rm = T))
for(i in 1:nrow(g2)){
    g2[i,is.na(g2[i,])] <- mean_row[i]
}
g2$q1 <- apply(g2[,2:7],1,mean)
g2$q2 <- apply(g2[,8:13],1,mean)
g2$q3 <- apply(g2[,14:19],1,mean)
g2$q4 <- apply(g2[,20:25],1,mean)
g2
g3 <- melt(g2,id=1:25)

model11 <- aov(value~variable,data=g3)
summary(model11)
model11_tukey <- TukeyHSD(model11,'variable')
summary(model11_tukey)

g4 <- melt(g2[,1:25],id=1)
model22 <- aov(value~variable,data=g4)
summary(model22)
model22_tukey <- TukeyHSD(aov(value~variable,data=g4),'variable')
model22_tukey$variable[model22_tukey$variable[,4]<.5,]

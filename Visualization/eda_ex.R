################################################################################
###############         Practice EDA                ############################
###############     using datasets 'mtcars'         ############################
###############     and 'diamonds'                  ############################
################################################################################
library(ggplot2)
## step1:
mtcars

## step2:
plot(mtcars[,1:5])
plot(mtcars[,6:11])
## step3:
with(mtcars,plot(mpg~disp))

## step4: correlation of mpg & disp
with(mtcars,cor(mpg,disp))

## step5:
boxplot(mtcars$mpg)
title(main = 'mpg of mtcars',xlab = 'mpg')
hist(mtcars$mpg, breaks = 10)
## step6:
boxplot(mtcars$disp)
title(main = 'Disp of mtcars',xlab = 'disp')
hist(mtcars$disp, breaks=20)

############ diamonds ###########
dia <- diamonds
str(dia)
sample <- sample(nrow(dia),10000)
sample <- dia[sample,]

## step1:
boxplot(dia$price)

## step2:
par(mfrow = c(3,3))
plot(price~.,data=sample)

## step3:
par(mfrow = c(1,1))
with(sample,plot(price,cut))
tapply(sample$price,sample$cut,mean)

## step4:
par(mfrow = c(2,2))
with(sample,plot(price~carat+x+y+z))

## step5:
library(corrplot)
par(mfrow= c(1,1))
sample2 <- sample[,c(7,1,8,9,10)]
corrplot(cor(sample2),method = "number")
?corrplot

range(sample2$carat)
ordered_carat <- sample2$carat[order(sample2$carat)]
plot(ordered_carat)

## step6: cut the outlier
sample3 <- subset(sample2, subset = (sample2$carat<2))
par(mfrow = c(1,2))
boxplot(sample$carat)
boxplot(sample3$carat)
?subset

## 섬세한 그래프
## install.packages("ggthemes")
library(ggthemes)
?ggthemes
g <- ggplot(dia,aes(x=x,y=price,color = clarity))
## legend의 color만 alpha = 1로 만드려면 guides() function을 쓴다.
## guides() adjust each scale
g + geom_point(alpha = 0.03) + theme_solarized_2() + 
    guides(color = guide_legend(override.aes = list(alpha=1)))

######################## guides() tutorial #####################################
dat <- data.frame(x = 1:5, y = 1:5, p = 1:5, q = factor(1:5),
                  r = factor(1:5))
p <- ggplot(dat, aes(x, y, colour = p, size = q, shape = r)) + geom_point()
p
## show colorbar guide for color
p + guides(color = "colorbar",size = "legend",shape = "legend")
## It is same as
p + scale_color_continuous(guide = "colorbar") +
    scale_size_discrete(guide = "legend") +
    scale_shape(guide = "legend")
## Remove all guides
p + guides(color = "colorbar",size = "none")
## Guides are integrated where possible
p + guides(colour = guide_legend("title"), size = guide_legend("title"),
           shape = guide_legend("title"))

## Set order for multiple guides
ggplot(mpg, aes(displ, cty)) +
    geom_point(aes(size = hwy, colour = cyl, shape = drv)) +
    guides(
        colour = guide_colourbar(order = 1),
        shape = guide_legend(order = 2),
        size = guide_legend(order = 3)
    )
################################################################################

## example ts
tsdata <- read.csv("example_ts.csv")
str(tsdata)
par(mfrow = c(1,1))
with(tsdata,plot(Date,Sales,type = 'l'))

g <- ggplot(tsdata,aes(x=factor(Date),y = Sales, group = 1))
g + geom_line(color = "orange1",size = 1) +
    geom_point(color = "orangered2",size = 4) + theme_light() + xlab("X") +
    ylab("Y") + ggtitle("X-Y")

## example population_f
library(dplyr)
popf <- read.csv("example_population_f.csv")
str(popf)
df <- popf[,-1]
sub1 <- df[df$Provinces=="충청남도" | df$Provinces=="충청북도",]

sub2 <- df %>% filter(SexRatio>1, PersInHou<2)
g <- ggplot(sub2, aes(x=reorder(City,Population),y=Population,label = Provinces)
g + geom_bar(stat='identity')+theme_wsj()+geom_label()
?geom_label
library(reshape2)
## SexF 변수추가
df <- mutate(df, SexF = ifelse(SexRatio<1 ,"여자비율높음",
                               ifelse(SexRatio>1,"남자비율높음","비율같음")))
df <- df %>% filter(Provinces == "경기도")
g <- ggplot(df, aes(x=City,y=(SexRatio-1),color = SexF))
g + geom_bar(stat='identity',position = "identity")+theme_wsj()
            
df <- df %>% filter(Provinces == "서울특별시")
g <- ggplot(df, aes(x=City,y=(SexRatio-1),color = SexF))
g + geom_bar(stat='identity',position = "identity")+theme_wsj()

##
popf <- read.csv("example_population_f.csv")
df <- popf[,-1]
df2 <- df %>% group_by(Provinces) %>% 
    summarise(sumPop = sum(Population),male = sum(Male),female = sum(Female))
df3 <- melt(df2,
            id.vars = c("Provinces","sumPop"),
            measure.vars = c("male","female"),
            value.name = "Pop",variable.name = "Sex")
df4 <- mutate(df3, Ratio = round(Pop/sumPop,3))
g <- ggplot(df4, aes(x=Provinces,y=Ratio,fill=Sex))
g + geom_bar(stat='identity')+coord_cartesian(ylim = c(0.45,0.55)) + 
    theme_bw() + geom_text(aes(y=Ratio , label = Ratio),color = 'white')


df2 <- mutate(df, SexF = ifelse(SexRatio<1 ,"여자비율높음",
                               ifelse(SexRatio>1,"남자비율높음","비율같음")))
df3 <- filter(df2,Provinces=='경기도')
ggplot(df3,aes(x=(SexRatio-1),y=reorder(City,SexRatio)))+
    geom_segment(aes(yend=City),xend=0.05,color="gray50")+
    geom_point(size=4,aes(color=SexF))

#### population 2 data
library(scales)
df <- read.csv("example_population2.csv")
str(df)
sum(!is.na(df$age100to104))
df2 <- df %>% group_by(Time) %>% 
    summarise(s0=sum(df$age0to4,df$age5to9))
df3 <- melt(df2, id.vars = "Time",measure.vars = colnames(df2)[-1])
colnames(df3) <- c("Time","Generation","Pop")
ggplot(df3, aes(x=Time,y=Pop, color=Generation,fill = Generation)) + 
    theme_wsj() + geom_area() + scale_y_continuous(labels = comma)
?scale_y_continuous

###################################################
########### ggplot 2             ##################
###################################################

library(ggplot2)
## install.packages("ggtheme")
## example student
student <- read.csv("example_studentlist.csv")
g1 <- ggplot(student,aes(x=height,y=weight,color = bloodtype))
g1 + geom_point(size = 1) + geom_line(size = 1)
g1 + geom_line(aes(color=sex),size=1)+geom_point(size=10)

g1 + geom_line(size=2) + geom_point(size=10)+facet_grid(.~sex,scales = "fixed")+
    theme_bw()
g1 + geom_line(size=2) + geom_point(size=10)+facet_wrap(~sex,scales = "fixed")+
    theme_bw()
?facet_wrap

## example mpg

## diamond exaple
data("diamonds")
str(diamonds)
g1 <- ggplot(data=diamonds,aes(carat))
g1 + geom_histogram(aes(fill = color),binwidth=.1,alpha=.6)

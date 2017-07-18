###############################################################################
#######                     R Graphics                                  #######
###############################################################################

split.screen(c(2,3))
screen(5)
plot(poly(1:100),type = 'l')
abc <- sample(1:1000,10)
def <- sample(1:1000,10)
ghi <- sample(1:1000,10)
screen(1)
plot(abc, type = 'o')
screen(3)
plot(def,type = 's')
screen(4)
plot(ghi,type = 'b')
close.screen(all = TRUE)

## save graphics
dev.copy(pdf,"sample.pdf")
dev.off()

data("lh")
data <- lh
str(data)
head(data)
data

## plotrix package
install.packages("plotrix")
library(plotrix)
demo(plotrix)

## par()
par(mfrow = c(1,1))
plot(abc, type = 'o')
plot(def,type = 's')
plot(ghi,type = 'b')
?switch
ccc <- c("b","QQ","a","A","bb")
# note: cat() produces no output for NULL
for(ch in ccc)
    cat(ch,":", switch(EXPR = ch, a = 1, b = 2:3), "\n")
        
##step 1:
abc <- rcauchy(30)
##step 2:
plot(abc, type = "o",col = "red", ylim = c(-10,10),axe = F, ann = F)
##step 3:
axis(1, at=1:30)
axis(2, ylim = c(-10,10))
##step 4:
title(main = "rcauchy(30)", col.main = "blue", font.main = 5)
title(xlab = "1:30",ylab = "Values")
##step 5:
lines(rcauchy(30,scale = 2), type = 'o',
      pch = 20, col = "green",lty = 2)
##step 6:
legend(1,6,c("1","2"),cex = 0.8, col = c("red","green"),pch = 21, lty=1:2,
       title = "scale")
?points

## lines, arrows, rectangle , text
x <- c(1,3,6,8,9)
y <- c(12,56,78,32,9)
plot(x,y)

segments(6,78,8,32,col = "blue")
arrows(3,56,1,12)
rect(4,20,6,30, density = 4)

text(4,40, "샘플 text")
mtext("우측의 문자열",side=4,adj=.3)
mtext("상단의 문자열",side=3,adj=.7)

?stars

## four fold plot
x <- aperm(UCBAdmissions, c(2, 1, 3))
dimnames(x)[[2]] <- c("Yes", "No")
names(dimnames(x)) <- c("Sex", "Admit?", "Department")
stats::ftable(x)
fourfoldplot(margin.table(x, c(1, 2)))
fourfoldplot(x, margin = 2)

## 3D plot - image, persp, contour, filled, contour, scatterplot3d


## lattice package
library(lattice)
layout(matrix(c(1,2,3,3,4,4),2,3))
layout.show(3)

## ggplot2 package
library(ggplot2)


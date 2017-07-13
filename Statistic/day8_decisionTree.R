# Decision tree
# install.packages("party")
library(party)
conf <- ctree_control(maxdepth = 2)
m <- ctree(Species~.,data=train,controls = conf)
plot(m)
summary(train[train$Species=="setosa",3])
?ctree_control

cpred <- predict(m,newdata = test)
sum(cpred==test$Species)/length(cpred)
table(test$Species,cpred)

## example
data("Vowel")
vowel_train <- Vowel[ind <- sample(1:nrow(Vowel),nrow(Vowel)*.7),-1]
vowel_test <- Vowel[-ind,-1]
c2 <- ctree(Class~.,data=vowel_train,
            controls = ctree_control(maxdepth = 4))
plot(c2)
cpred2 <- predict(c2,newdata=vowel_test)
sum(cpred2==vowel_test$Class)/length(cpred2)
table(vowel_test$Class,cpred2)

##
install.packages("tree")
library(MASS);library(tree)

iris_tree <- tree(Species~.,data=train)
summary(iris_tree)
plot(iris_tree)
text(iris_tree,all = T)
iris_tree2 <- snip.tree(iris_tree)
plot(iris_tree2)
text(iris_tree2,all = T)

vowel_tree <- tree(Class~.,data=vowel_train)
x11()
plot(vowel_tree)
text(vowel_tree,all = T)

summary(vowel_tree)
vowel_tree2 <- snip.tree(vowel_tree,c(12,7))
plot(vowel_tree2)
text(vowel_tree2,all = T)
?snip.tree
iris_tr1 <- prune.misclass(iris_tree,best = 14)
plot(iris_tr1)
text(iris_tr1,all =T)

plot(prune.misclass(vowel_tree))
vowel_tr1 <- prune.misclass(vowel_tree,best = 9)
plot(vowel_tr1)
text(vowel_tr1,all =T)

# Random Forest
install.packages("randomForest")
library(randomForest)

r1 <- randomForest(Class~.,vowel_train)
r1$predicted
t1 <- table(r1$predicted,vowel_train$Class)
sum(diag(t1))/length(r1$predicted)
str(r1)

pred4 <- predict(r1,newdata = vowel_test)
t2 <- table(vowel_test$Class,pred4)
sum(diag(t2))/length(pred4)

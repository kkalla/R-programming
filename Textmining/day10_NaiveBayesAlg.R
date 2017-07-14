################################################################################
#####             Naive Bayes Algorithm                                ########
##############################################################################

sms_raw <- read.csv("SMSSpamCollection.txt",header = F,
                    sep="\t",stringsAsFactors = F,quote = "",encoding = "UTF-8")
colnames(sms_raw) <- c('type','text')
sms_raw$type <- factor(sms_raw$type)

library(tm)
sms_corpus <- Corpus(VectorSource(sms_raw$text))
str(sms_corpus)

# Clean up corpus using tm_map()
corpus_clean <- tm_map(sms_corpus, tolower)
corpus_clean <- tm_map(corpus_clean, removeNumbers)
corpus_clean <- tm_map(corpus_clean, removeWords,stopwords())
corpus_clean <- tm_map(corpus_clean, removePunctuation)
corpus_clean <- tm_map(corpus_clean, stripWhitespace)

# Make document-term matrix
sms_dtm <- DocumentTermMatrix(corpus_clean)

# Make trainset and test set
sms_raw_train <- sms_raw[ind<- sample(1:nrow(sms_raw),nrow(sms_raw)*.7),]
sms_raw_test <- sms_raw[-ind,]

sms_dtm_train <- sms_dtm[ind,]
sms_dtm_test <- sms_dtm[-ind,]
sms_corpus_train <- corpus_clean[ind]
sms_corpus_test <- corpus_clean[-ind]

sms_train_labels <- sms_raw_train$type
sms_test_labels <- sms_raw_test$type
prop.table(table(sms_raw_train$type))
prop.table(table(sms_raw_test$type))

# Word Cloud
library(wordcloud)
wordcloud(sms_corpus_train,min.freq = 30,random.order = FALSE)

####
spam <- subset(sms_raw_train,type =="spam")
ham <- subset(sms_raw_train,type =="ham")
par(mfrow = c(2,1))
wordcloud(spam$text,max.words = 40, scale =c(3,.5))
wordcloud(ham$text,max.words = 50, scale =c(3,.5))

# 빈번한 단어에 대한 속성 지시자
# dtm 중에 spam인것만 걸러서 빈도수가 5 이상인 단어들을 찾을 수 있다.
train_words <- findFreqTerms(sms_dtm_train,5)
test_words <- findFreqTerms(sms_dtm_test,5)

sms_dtm_train_freq <- sms_dtm_train[,train_words]
sms_dtm_test_freq <- sms_dtm_test[,test_words]

# COunts to factor
convert_counts <- function(x){
    x <- ifelse(x>0,1,0)
    x <- factor(x, levels = c(0,1),labels = c("No","Yes"))
}

# apply convert_counts() to sms_dtm_train
sms_train <- apply(sms_dtm_train_freq,MARGIN = 2,convert_counts)
sms_test <- apply(sms_dtm_test_freq,MARGIN = 2,convert_counts)

# train a model on the data
library(e1071)
start <- Sys.time()
sms_classifier <- naiveBayes(sms_train,sms_train_labels)
end <- Sys.time()
end - start

sms_classifier$apriori

# evaluate model performance
start <- Sys.time()
sms_test_pred <- predict(sms_classifier,sms_test)
end <- Sys.time()
end - start
length(sms_test_labels)
length(sms_test_pred)
str(sms_test)

library(gmodels)
CrossTable(sms_test_pred,sms_test_labels,prop.chisq = FALSE,prop.t = FALSE,
           dnn = c('predicted','actual'))

?DocumentTermMatrix

## Random forest algorithm
sms_train2 <- apply(sms_train,MARGIN = 2,function(x) {x<-ifelse(x=="No",0,1)})
library(randomForest)
startTime <- Sys.time()
rndf <- randomForest(sms_train2,sms_train_labels)
end <- Sys.time()-startTime
print(end)

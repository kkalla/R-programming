## Tests example
library(xlsx)

data_1 <- read.xlsx2('PM10.xlsx',sheetIndex = 1,startRow = 2,
                  header = TRUE,encoding = "UTF-8")
data_2 <-read.xlsx('PM10.xlsx',sheetIndex = 2,startRow = 2,
                   header = TRUE,encoding = "UTF-8")

colnames(data_1) <- c("location",paste0("H",1:24))
colnames(data_2) <- c("location",paste0("H",1:24))

var.test(data_1$H4,data_1$H12)
with(data_1,t.test(H6,H18,paired = TRUE,var.equal = TRUE))

var.test(data_2$H6,data_2$H18)
with(data_2,t.test(H6,H18,paired = TRUE,var.equal = T))


apply(is.na(data_2),1,sum)


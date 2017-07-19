## Tree map
## install.packages("treemap")
library(treemap)

data("GNI2014")
str(GNI2014)
treemap(GNI2014,index=c("continent","iso3"),vSize = "population",
        vColor = "GNI",type = "value")
treemap(GNI2014,index=c("continent","iso3"),vSize = "population",
        type = "index")

data("business")
str(business)
head(business)
level <- levels(business$NACE1)
treemap(business[business$NACE1==level[8],],
        index=c("NACE2","NACE3"),vSize = "employees",type="value")



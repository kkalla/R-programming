

sum(is.na(weather$일자))
weather$일자 <- ymd(weather$일자)
na_weather <- is.na(weather$일자)


## Change variable names
colnames(product) <- c('date','category','item','region','mart','price')
product$date <- as.Date.character(product$date,format = "%Y-%m-%d")

category <- subset(code,code$구분코드설명=="품목코드")
colnames(category) <- c("code",'exp','item','name')

total_pig <- product[which(product$item==514),]
region <- subset(code,code$구분코드설명=="지역코드")
colnames(region) <- c('code','exp','region','name')

## Merge total_pig and region(dataset) by region variable
day_pig <- merge(total_pig,region,by = "region",all = T)
str(day_pig)
head(day_pig)

## Calculate mean price of pig by day and region using
## ddply, arrange, group_by functions
total_pig_mean <- dlply(
    ddply(
        ddply(day_pig,.(date),select, 
              name = name, region= region, price = price),
        .(date,name),summarise,mean_price=mean(price)),
    .(name)
    )

str(total_pig_mean)    

## sub <- day_pig %>% select(date,name,region,price) %>%
## group_by(date,name) %>% summarise(mean_price = mean(price)) %>% 
## dlply(.(name))

## drop regions which of length is less than 745
numRows <- numeric()
for(i in 1:length(total_pig_mean)){
    numRows[i] <- nrow(total_pig_mean[[i]])
}
day_pig <- day_pig[!day_pig$name %in% names(total_pig_mean[numRows!=745]),]

## Calculate mean price of pig by name,region and date.
pig_region_daily_mean <- ddply(day_pig,.(name,region,date),summarise,
                               mean_price = mean(price))
head(pig_region_daily_mean)

## Calculate mean price of pig by month and region.
pig_region_monthly_mean <- ddply(
    pig_region_daily_mean,
    .(name,region,month = str_sub(pig_region_daily_mean$date,1,7)),
    summarise, mean_price = mean(mean_price))
head(pig_region_monthly_mean)

## Calculate mean price of big by year
pig_region_yearly_mean <- ddply(
    pig_region_daily_mean,
    .(name,region,year = year(pig_region_daily_mean$date)),
    summarise, mean_price = mean(mean_price)
)
head(pig_region_yearly_mean)

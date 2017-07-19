###############################################################################
##############      how to use google map API                   ###############
###############################################################################

##library - ggmap
##geocode
##get_googlemap() -> returns googlemap object
##

install.packages("ggmap")
library(ggmap)
library(ggplot2)
library(httr)
library(jsonlite)
citation('ggmap')
api_key <- read.csv("Visualization/googleAPI.txt")
geo_key <- as.character(api_key$geocodeAPI)
address <- "강원도+속초시"
requestUrl <- paste("https://maps.googleapis.com/maps/api/geocode/json?address=",
address,"&key=",geo_key,"&language=ko",sep = "")
result_json <- fromJSON(requestUrl)
cen <- c(lon = result_json$results$geometry$location$lng,
         lat = result_json$results$geometry$location$lat)
dfcen <- data.frame(lng = cen[1],lat = cen[2])
map <- get_map(location = 'seoul',zoom=14,maptype="watercolor",scale=1)
ggmap(map)
?get_googlemap
?data.frame
## 강원도 속초시 해수욕장
df <- read.csv("kang.csv",stringsAsFactors = FALSE)
map <- get_googlemap(center=cen,maptype = "roadmap",
                     language = "ko",zoom = 11)
gmap <- ggmap(map)
str(df)
gmap+geom_text(data=df,aes(x=longitude,y=latitude,col=factor(names)),
               label = df$names,hjust=-.5,size = 5)

## Population
pop <- read.csv("population.csv",dec=".")
region <- pop$지역명
str(pop)
lon <- pop$LON
lat <- pop$LAT
house <- pop$세대수
house <- as.numeric(gsub(x=house,',',''))

map <- get_googlemap(center = c(mean(lon),mean(lat)),zoom = 7,
                     maptype = "roadmap")
gmap <- ggmap(map)
gmap + geom_point(data=pop,aes(x=lon,y=lat,color=as.factor(house),size=house))+
    guides(size=FALSE)
?geom_point


## Earthquakes data
quakes <- read.csv("quakes.csv",sep = " ")
str(quakes)
head(quakes)

quakes$long <- ifelse(quakes$long>180, -(360-quakes$long),quakes$long)
markers <- data.frame(lon = quakes$long,lat = quakes$lat)[1:30,]
map <- get_googlemap(center = c(round(median(quakes$long),2),
                                round(median(quakes$lat),2)),
                                maptype = "roadmap",
                                zoom = 1,scale=2)
gmap <- ggmap(map)
gmap + geom_point(data=quakes,aes(long,lat,size=mag,alpha=mag),cex=.2)

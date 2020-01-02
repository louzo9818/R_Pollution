library(readr)
library(ggplot2)
library(tidyverse)
library(maps)

gdp <- read_csv("API_NY.GDP.MKTP.CD_DS2_en_csv_v2_10576830.csv")


gdp <- select(gdp, `Country Name`, `2017`)
colnames(gdp)[colnames(gdp)=="2017"]<- "GDP"
colnames(gdp)[colnames(gdp)=="Country Name"]<- "Country"
gdp[201,1]<-"Russia"
gdp[250,1]<-"USA"
gdp[42,1]<-"Democratic Republic of the Congo"
gdp[66,1]<-"Egypt"

gdp<- drop_na(gdp)

map("world")

color<-c(rgb(3:1/3,0,0),rgb(0.3,3:1/3,0))

gdp<-aggregate(data.frame(value = gdp$GDP), by = list(gdp$Country), FUN = sum)
Countries<- select(gdp,Group.1)
def<-data.frame(map("world",plot=FALSE)$name)

gdp<-merge(gdp,def,by.x= "Group.1", by.y = "map..world...plot...FALSE..name")

gdp$CLASS <- cut(gdp$value, c(0,1e+9,1e+10,1e+11,1e+12,1e+13,1e+14), right = TRUE)
map("world",regions= gdp$Group.1, col = color[gdp$CLASS], fill = TRUE, add = TRUE, exact = TRUE)

legend("bottomleft", legend= attr(gdp$CLASS,"levels"), col = color, lty = 1, lwd = 10)





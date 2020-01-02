library(ggplot2)
library(tidyverse)
library(maps)

map("world")
polluateCountry = read.csv("Exposure_to_PM2.5_fine_particles-countries_and_regions.csv", sep = ",",stringsAsFactors=FALSE)

polluateCountry%>%
  select(COU,Country, Variable, Year, Value)%>%
  filter(Variable == "Mean population exposure to PM2.5")%>%
  arrange(Variable)->polluateCountry


polluateCountry %>%
  filter( Year == 1990 | Year == 2017)%>%
  spread(Year,Value)->pollutionEvol

title(main = "PM2.5 air pollution, mean annual exposure (micrograms per cubic meter),
2017")
color<-c(rgb(0.3,2:1/2,0), rgb(3:1/3,0,0))
df<-aggregate(data.frame(value = pollutionEvol$`2017`), by = list(pollutionEvol$Country), FUN = sum)
df[182,1]<-"USA"
df[39,1]<-"China"
Countries<- select(df,Group.1)
def<-data.frame(map("world",plot=FALSE)$names)

df<-merge(df,def,by.x= "Group.1", by.y = "map..world...plot...FALSE..names")

df$CLASS <- cut(df$value, c(0,20,40,60,80,100), right = TRUE)
map("world",regions= df$Group.1, col = color[df$CLASS], fill = TRUE, add = TRUE, exact = TRUE)
legend("bottomleft", legend= attr(df$CLASS,"levels"), col = color, lty = 1, lwd = 10)
                                                     



library(ggplot2)
library(tidyverse)
polluateCountry = read.csv("Exposure_to_PM2.5_fine_particles-countries_and_regions.csv", sep = ",")

polluateCountry%>%
  select( ï..COU,Country, Variable, Year, Value)%>%
  filter(Variable == "Mean population exposure to PM2.5")%>%
  arrange(Variable)->polluateCountry


polluateCountry %>%
  filter( Year == 1990 | Year == 2017)%>%
  spread(Year,Value)->pollutionEvol

pollutionEvol%>%
  filter(ï..COU== "FRA"|ï..COU== "USA"|ï..COU== "NPL"|ï..COU== "QAT"|ï..COU== "EGY"|ï..COU== "IND"|
          ï..COU== "SAU"|ï..COU== "NER"|ï..COU== "LKA"|ï..COU== "LBY"|ï..COU== "MKD"|ï..COU== "RUS"
          |ï..COU== "CMR"|ï..COU== "TCD"|ï..COU== "URG"|ï..COU== "MNG"|ï..COU== "CHN"|ï..COU== "CZE"
          |ï..COU == "THA")->selCountry

ggplot(pollutionEvol) + 
  geom_point(aes(x=pollutionEvol$`1990`,y=pollutionEvol$`2017`))+
  geom_abline(intercept=1/2)+
  labs(y = "Year 2017 in micrograms per cubic meter", x = "Year 1990 in micrograms per cubic meter")
  
ggplot(selCountry) + 
  geom_point(aes(x=selCountry$`1990`,y=selCountry$`2017`))+
  geom_abline(intercept=1/2)+
  labs(y = "Year 2017 in micrograms per cubic meter", x = "Year 1990 in micrograms per cubic meter")+
  geom_text(label = selCountry$ï..COU, aes(x=selCountry$`1990`,y=selCountry$`2017`), size = 3, nudge_x = -2)
    




  
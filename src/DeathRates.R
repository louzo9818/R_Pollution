library(ggplot2)
library(tidyverse)

polluateCountry = read.csv("Exposure_to_PM2.5_fine_particles-countries_and_regions.csv", sep = ",")
deathRates = read.csv("death-rates-from-ambient-particulate-air-pollution.csv", sep = ",")
polluateCountry%>%
  select( ï..COU,Country, Variable, Year, Value)%>%
  filter(Variable == "Mean population exposure to PM2.5")%>%
  arrange(Variable)->polluateCountry


polluateCountry %>%
  filter( Year == 2017)%>%
  spread(Year,Value)->pollutionEvol

deathRates<-filter(deathRates, Year == 2017)
colnames(deathRates)[colnames(deathRates)=="Entity"]<- "Country"
df<-left_join(pollutionEvol,deathRates, by = "Country")

df%>%
  select(`2017`,Deaths...Ambient.particulate.matter.pollution...Sex..Both...Age..Age.standardized..Rate...deaths.per.100.000.)%>%
  drop_na()->df


ggplot(df, mapping  = aes(x = df$`2017`, y = df$Deaths...Ambient.particulate.matter.pollution...Sex..Both...Age..Age.standardized..Rate...deaths.per.100.000.)) +
  geom_point()

cor(df$`2017`, df$Deaths...Ambient.particulate.matter.pollution...Sex..Both...Age..Age.standardized..Rate...deaths.per.100.000.) 


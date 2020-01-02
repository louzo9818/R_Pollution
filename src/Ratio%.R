library(ggplot2)
library(tidyverse)

polluateCountry = read.csv("Exposure_to_PM2.5_fine_particles-countries_and_regions.csv", sep = ",",stringsAsFactors=FALSE)
deathRates = read.csv("death-rates-from-ambient-particulate-air-pollution.csv", sep = ",", stringsAsFactors=FALSE)

polluateCountry%>%
  select(COU,Country, Variable, Year, Value)%>%
  filter(Variable == "Mean population exposure to PM2.5")%>%
  arrange(Variable) %>% 
  filter( Year == 2017) %>% 
  select(Country,COU, Value)->polluateCountry

colnames(deathRates)[colnames(deathRates)=="Deaths...Ambient.particulate.matter.pollution...Sex..Both...Age..Age.standardized..Rate...deaths.per.100.000."]<- "Death per 100.000"
colnames(deathRates)[colnames(deathRates)=="Entity"]<- "Country"
colnames(polluateCountry)[colnames(polluateCountry)=="COU"]<- "Code"
colnames(polluateCountry)[colnames(polluateCountry)=="Value"]<- "Pollution"

deathRates %>% 
  filter(Year == 2017) %>% 
  select(Country, Code, `Death per 100.000`) %>% 
  drop_na()->deathRates
  
df<-left_join(polluateCountry,deathRates, by = c("Country", "Code"))
df %>% 
  drop_na() %>% 
  mutate(ratio =`Death per 100.000` / 109.61627)->df

ggplot(df, mapping  = aes(x = df$Pollution, y = df$ratio)) +
  geom_point()

              
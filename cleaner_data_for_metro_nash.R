library(tidyverse)

tn_hos_data= read_csv('data_science/hosptial-cost-/CSV_2018_Hospital_Cost_Report.csv') %>% 
  filter(`State Code`== 'TN')

tn_metro_list = read_csv('data_science/hosptial-cost-/metro_list1_2020 - List 1.csv') %>% 
  filter(`...3`==400) %>% 
  select(-...2, -...6,) %>% 
  mutate_if(is.character,str_to_upper) 

tn_metro_list$...8= str_replace_all(tn_metro_list$...8, ' COUNTY', '' )
  
merge(tn_hos_data, tn_metro_list, by.x = 'County', by.y = '...8') %>% 
  view()

  

tn_metro_list %>% 
  mutate_if(is.character,str_to_upper) %>% 
  view()

metro_nash_hos_data= tn_hos_data %>% 
  filter(City== 'NASHVILLE'| City=='MURFREESBORO'| City=='FRANKLIN'| City=='HENDERSONVILLE'| City=='SMYRNA'| City=='COLUMBIA'| City=='GALLATIN'| City=='HERMITAGE'| City=='LEBANON'| City=='DICKSON'| City=='SPRINGFIELD'| City=='ASHLAND CITY'| City=='CARTHAGE'| City=='HARTSVILLE'| City=='LAFAYETTE'| City=='WOODBURY'| City=='HICKMAN')

repl


str_replace_all(tn_metro_list, ' COUNTY', '' ) %>% 
  view()
  
str_replace_all(tn_metro_list, '[qwertyuioplaksjdhfgzmxncbv]', tou) %>% 
  view()  


merge(tn_hos_data,tn_metro_list, by= ) %>% 
  view()


metro_nash_hos_data= tn_hos_data %>% 
  filter(City== 'NASHVILLE'| City=='MURFREESBORO'| City=='FRANKLIN'| City=='HENDERSONVILLE'| City=='SMYRNA'| City=='COLUMBIA'| City=='GALLATIN'| City=='HERMITAGE'| City=='LEBANON'| City=='DICKSON'| City=='SPRINGFIELD'| City=='ASHLAND CITY'| City=='CARTHAGE'| City=='HARTSVILLE'| City=='LAFAYETTE'| City=='WOODBURY'| City=='HICKMAN')

metro_nash_hos_data  


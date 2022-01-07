library(tidyverse)

raw_hosptial_data = read_csv('data_science/hosptial-cost-/CSV_2018_Hospital_Cost_Report.csv')

raw_hosptial_data %>% 


tn_hos_data = raw_hosptial_data %>% 
  filter(`State Code`== 'TN')

raw_metro_list = read_csv('data_science/hosptial-cost-/metro_list1_2020 - List 1.csv')

tn_metro_list = raw_metro_list %>% 
  filter(`...3`==400)




metro_nash_hos_data= tn_hos_data %>% 
  filter(City== 'NASHVILLE'| City=='MURFREESBORO'| City=='FRANKLIN'| City=='HENDERSONVILLE'| City=='SMYRNA'| City=='COLUMBIA'| City=='GALLATIN'| City=='HERMITAGE'| City=='LEBANON'| City=='DICKSON'| City=='SPRINGFIELD'| City=='ASHLAND CITY'| City=='CARTHAGE'| City=='HARTSVILLE'| City=='LAFAYETTE'| City=='WOODBURY'| City=='HICKMAN')

metro_nash_hos_data  

  
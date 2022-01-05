library(tidyverse)
install.packages('readxl')

raw_hosptial_data= read_csv('data_science/mid course project/CSV_2018_Hospital_Cost_Report.csv')

raw_metro_list= readxl_example('data_science/mid course project/metro_list1_2020.xls')
read_excel(raw_metro_list)


raw_hosptial_data %>% 
  glimpse()

tn_hos_data= raw_hosptial_data %>% 
  filter(`State Code`== 'TN')

metro_nash_hos_data= tn_hos_data %>% 
  filter(City== 'NASHVILLE'| City=='MURFREESBORO'| City=='FRANKLIN'| City=='HENDERSONVILLE'| City=='SMYRNA'| City=='COLUMBIA'| City=='GALLATIN'| City=='HERMITAGE'| City=='LEBANON'| City=='DICKSON'| City=='SPRINGFIELD'| City=='ASHLAND CITY'| City=='CARTHAGE'| City=='HARTSVILLE'| City=='LAFAYETTE'| City=='WOODBURY'| City=='HICKMAN')

metro_nash_hos_data  

  
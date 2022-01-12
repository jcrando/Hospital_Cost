library(tidyverse)
install.packages("rsconnect")

tn_hos_data= read_csv('data_science/hosptial-cost-/CSV_2018_Hospital_Cost_Report.csv') %>% 
  filter(`State Code`== 'TN')


v1= c('CBSA Code','Metropolitan Division Code','CSA Code','CBSA Title','Metropolitan/Micropolitan Statistical Area','Metropolitan Division Title','CSA Title','County/County Equivalent','State Name','FIPS State Code','FIPS County Code','Central/Outlying County')
raw_metro_list = read_csv('data_science/hosptial-cost-/metro_list1_2020 - List 1.csv')
names(raw_metro_list)[1:12] <- v1
raw_metro_list <- raw_metro_list[-1, ]
raw_metro_list <- raw_metro_list[-1, ]


tn_metro_list= raw_metro_list%>%   
  filter(`CSA Code`==400) %>% 
  select(-`Metropolitan Division Code`, -`Metropolitan Division Title`,) %>% 
  mutate_if(is.character,str_to_upper) 
tn_metro_list$`County/County Equivalent`= str_replace_all(tn_metro_list$`County/County Equivalent`, ' COUNTY', '' )
  

metro_tn_hos_data=merge(tn_hos_data, tn_metro_list, by.x = 'County', by.y = 'County/County Equivalent') 

lean_metro_data= metro_tn_hos_data %>% 
  select(County, `Hospital Name`, `Street Address`, City, `Zip Code`, `Inpatient Total Charges`, `Outpatient Total Charges`, `Combined Outpatient + Inpatient Total Charges`, `Hospital Total Discharges (V + XVIII + XIX + Unknown) For  Adults & Peds`)

final_df= read_csv('data_science/hosptial-cost-/final_df.csv')


#attempt to use a groupby on MERGE to do calculations
group_by_final= final_df %>% 
  group_by(MERGE) 

#maybe try summarize

group_by_final= group_by_final %>% 
  mutate((sum(TOTAL_SERVICES*AVG_MEDICARE_PAYMENT)/(sum(TOTAL_SERVICES)))) 

write_rds(group_by_final, 'final_data.rds')

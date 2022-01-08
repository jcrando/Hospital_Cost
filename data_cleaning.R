library(tidyverse)

raw_hosptial_data = read_csv('data_science/hosptial-cost-/CSV_2018_Hospital_Cost_Report.csv')

raw_hosptial_data %>% 


tn_hos_data = raw_hosptial_data %>% 
  filter(`State Code`== 'TN')

raw_metro_list = read_csv('data_science/hosptial-cost-/metro_list1_2020 - List 1.csv')

 
raw_metro_list <- raw_metro_list[-1, ]

names(raw_metro_list)[1:12] <- v1


v1= c('CBSA Code','Metropolitan Division Code','CSA Code','CBSA Title','Metropolitan/Micropolitan Statistical Area','Metropolitan Division Title','CSA Title','County/County Equivalent','State Name','FIPS State Code','FIPS County Code','Central/Outlying County')

tn_metro_list = raw_metro_list %>% 
  filter(`...3`==400)




metro_nash_hos_data= tn_hos_data %>% 
  filter(City== 'NASHVILLE'| City=='MURFREESBORO'| City=='FRANKLIN'| City=='HENDERSONVILLE'| City=='SMYRNA'| City=='COLUMBIA'| City=='GALLATIN'| City=='HERMITAGE'| City=='LEBANON'| City=='DICKSON'| City=='SPRINGFIELD'| City=='ASHLAND CITY'| City=='CARTHAGE'| City=='HARTSVILLE'| City=='LAFAYETTE'| City=='WOODBURY'| City=='HICKMAN')

metro_nash_hos_data  

providers= read_csv('data_science/hosptial-cost-/MUP_PHY_R20_P04_V10_D18_Prov_Svc_zip.csv')
providers= providers %>% 
  mutate_if(is.character, str_to_upper)

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

lean_metro_data %>% 
  mutate(`Combined Outpatient + Inpatient Total Charges`/`Hospital Total Discharges (V + XVIII + XIX + Unknown) For  Adults & Peds`) %>% 
  view()


merge(lean_metro_data, providers, by.x = 'Street Address', by.y = 'Rndrng_Prvdr_St1') %>% 
  view()

providers$addy= providers$Rndrng_Prvdr_St1
prov_metro=providers %>% 
  filter(Rndrng_Prvdr_City== c("SHELBYVILLE",    "WOODBURY",       "ASHLAND CITY",   "NASHVILLE",      "HERMITAGE",     
                               "DICKSON",        "LAWRENCEBURG",   "LAFAYETTE",      "LEWISBURG",      "COLUMBIA",      
                               "SPRINGFIELD",    "MURFREESBORO",  "SMYRNA",         "CARTHAGE",       "HENDERSONVILLE",
                               "GALLATIN",       "HARTSVILLE",     "FRANKLIN" ,      "LEBANON")) 

str_replace_all(lean_metro_data$`Street Address`, '\\d', '') %>% 
  view()

prov_metro$addy_no_dig= str_replace_all(prov_metro$addy, '\\d', '' )


prov_metro$combo=paste(prov_metro$addy, prov_metro$Rndrng_Prvdr_City, sep = ' ')
lean_metro_data$combo=paste(lean_metro_data$`Street Address`, lean_metro_data$City, sep = ' ')
install.packages('fuzzyjoin')
library(fuzzyjoin)
fuzzy_left_join(lean_metro_data, prov_metro,
                by ="combo", distance_col = NULL, match_fun= NULL) %>% 
  view()

hospital-cost
Data Question: R Shiny Dashboard (Cost Paid by Medicare in Metro Nashville)
The cost of healthcare has been going up consistently over the last 50 years.  This is due to many factors ranging from the cost of educating healthcare proffesionals and the substantial overhead to run a medical practice to waste in the form of expensive one time use tools.  In addition, there is a lack of clarity in pricing for healthcare which makes it hard for consumers to make an educated decision based on price.  Using data from Metro Nashville Hospitals, who receveived over $8,582,511 in services from Medicare in 2018, I've created an app that allows you to see on average how much Medicare paid to various hospitals for various procedures in the Nashville area.  This app can be used a tool to gauge how much hospitals are charging for different procedures across the board and therefore estimate which hospital they are likely to spend the most or least amount of money.

Part 1:
I start by determining what areas make up Metro Nashville by using https://www.census.gov/geographies/reference-files/time-series/demo/metro-micro/delineation-files.html and then using https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Physician-and-Other-Supplier and https://catalog.data.gov/dataset/hospital-provider-cost-report-characteristics-e564f to consolidate hospital names, addresses, City, County, Medicare charges, number and type of services, along with several other data points that may be of value in future iterations.  I also used a geocoder to convert the address into latitude and longitude.

Part 2:
I then built an app using R Shiny. This app should allow the user to view procedure cost that can be filter by county/city/zip code /hospital name.


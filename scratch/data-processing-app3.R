# load packages ---
library(tidyverse)

# import data ---
lake_raw <- read_csv(here::here("data","FCWO_lakemonitoringdata_2011_2022_daily.csv"))

# avg deptth & temp ----
avg_depth_temp <- lake_raw %>% 
  select(Site, Depth, BedTemperature) %>% 
  # there are missing variables we will get rid of them
  # here the NaN are character strings
  filter(Depth != "NaN") %>% 
  # get rid of those that are NA 
  drop_na(BedTemperature) %>% 
  group_by(Site) %>% 
  summarize(
    AvgDepth = round(mean(Depth),1),
    AvgTemp = round(mean(BedTemperature),1)
  )

# join our raw and the average data 
joined_dfs <- full_join(lake_raw,avg_depth_temp)

# get unique lakes observations (with corresponding lat, lon, elev, avgDepth, avgTemp) for mapping ----
unique_lakes <- joined_dfs |> 
  select(Site, Latitude, Longitude, Elevation, AvgDepth, AvgTemp) |> 
  distinct()

# save processed data to your app's data directory ----
write_csv(x = unique_lakes, 
          file = here::here("shinydashboard", "data", "lake_data_processed.csv"))


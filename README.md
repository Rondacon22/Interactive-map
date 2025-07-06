# Interactive map of Pakidstan voters data

library(tidyverse)
library(ggplot2)
library(plotly)
library(geojsonio)
library(sf)

# Using sf to read the GeoJSON file
pakistan_shapefile <- st_read("STAT317A/pakistanmap/pakistan_districts.geojson")

# Filter for Punjab
punjab_shapefile <- pakistan_shapefile %>%
  filter(province_territory == "Punjab")

# Load voter data
voter_data <- read_csv("STAT317A/District Wise Voter stats.csv")

# Standardize district names for proper join
punjab_shapefile <- punjab_shapefile %>%
  mutate(district_agency = tolower(trimws(district_agency)))

voter_data <- voter_data %>%
  mutate(District = tolower(trimws(District)))

# Merge shapefile with voter data
punjab_voter_map <- punjab_shapefile %>%
  left_join(voter_data, by = c("district_agency" = "District"))

# Create a static ggplot map
map_plot <- ggplot(data = punjab_voter_map) +
  geom_sf(aes(fill = Total)) +
  geom_sf_text(aes(label = district_agency), size = 2, color = "black") +
  scale_fill_viridis_c(option = "plasma", name = "Total Voters") +
  theme_minimal() +
  labs(
    title = "District-wise Voter Map of Punjab",
    subtitle = "Based on provided voter statistics",
    caption = "Source: Pakistan GeoJSON Shapefile and Voter Data"
  )

# Convert the ggplot map to an interactive plotly map
interactive_map <- ggplotly(map_plot)

# Display the interactive map
interactive_map





ibrary(tidyverse)
library(ggplot2)
library(plotly)
library(gapminder)
library(echarts4r)
library(gganimate)
library(ggiraph)
library(widgetframe)
library(ggthemes)
library(viridis)
library(DT)

# Load Data
crop_data <- read.csv("STAT317A/prediction-of-crop-yields-or-to-identify-areas-of-risk-for-crop-in-pakistan.csv")

# Clean and restructure data
crop_data_clean <- crop_data %>% 
  rename(Region = X) %>% 
  select(Region, Wheat = Acres, Gram = Acres.1, Barley = Acres.2, Potato = Acres.3) %>% 
  filter(Region != "") %>% 
  mutate(
    Wheat = as.numeric(gsub(",", "", Wheat)),
    Gram = as.numeric(gsub(",", "", Gram)),
    Barley = as.numeric(gsub(",", "", Barley)),
    Potato = as.numeric(gsub(",", "", Potato))
  )

# Remove empty rows and regions
crop_data_clean <- crop_data_clean %>% drop_na(Region)

# Merge with World Map
world <- map_data("world")

# Join crop data with world map
crop_map <- world %>% 
  right_join(crop_data_clean, by = c("region" = "Region"))

# Create static ggplot map
crop_map_plot <- ggplot(crop_map, aes(long, lat, group = group, fill = Wheat)) + 
  geom_polygon(color = "white", linewidth = 0.1) + 
  theme_void() + 
  scale_fill_viridis_c(name = "Crop Yield (Wheat)") + 
  labs(title = "Crop Yield Predictions in Pakistan", subtitle = "Wheat Production") + 
  theme(
    plot.title = element_text(size = 14, hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )

# Convert ggplot map to interactive using plotly
interactive_map <- ggplotly(crop_map_plot)

# Display interactive map
interactive_map


# Pakistan map with crop production

library(tidyverse)
library(ggplot2)
library(plotly)
library(viridis)

# Load Data
crop_data <- read.csv("STAT317A/prediction-of-crop-yields-or-to-identify-areas-of-risk-for-crop-in-pakistan.csv")

# Clean and restructure data
crop_data_clean <- crop_data %>% 
  rename(Region = X) %>% 
  select(Region, Wheat = Acres, Gram = Acres.1, Barley = Acres.2, Potato = Acres.3) %>% 
  filter(Region != "") %>% 
  mutate(
    Wheat = as.numeric(gsub(",", "", Wheat)),
    Gram = as.numeric(gsub(",", "", Gram)),
    Barley = as.numeric(gsub(",", "", Barley)),
    Potato = as.numeric(gsub(",", "", Potato))
  )

# Remove empty rows and regions
crop_data_clean <- crop_data_clean %>% drop_na(Region)

# Merge with World Map
world <- map_data("world")

# Check if 'Region' names match the map data 'region' names
crop_data_clean$Region <- tolower(crop_data_clean$Region)  # Match case if necessary

# Filter the map data for Punjab, Pakistan
# Here, you need to know the exact name or boundary for Punjab in the 'world' map data
# Assuming that the "region" corresponds to provinces within Pakistan (usually it does not in world maps)
# You might need a shapefile for Pakistan that contains the provinces or use another source for Punjab data
punjab_map <- world %>% 
  filter(region == "Pakistan" & long >= 70 & long <= 78 & lat >= 30 & lat <= 37)  # Rough boundaries for Punjab

# Merge the filtered Punjab map with crop data
crop_map <- punjab_map %>% 
  left_join(crop_data_clean, by = c("region" = "Region"))

# Create static ggplot map
crop_map_plot <- ggplot(crop_map, aes(long, lat, group = group, fill = Wheat)) +
  geom_polygon(color = "white", linewidth = 0.1) +
  theme_void() +
  scale_fill_viridis_c(name = "Crop Yield (Wheat)") +
  labs(title = "Crop Yield Predictions in Punjab, Pakistan", subtitle = "Wheat Production") +
  theme(
    plot.title = element_text(size = 14, hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )

# Convert ggplot map to interactive using plotly
interactive_map <- ggplotly(crop_map_plot)

# Display interactive map
interactive_map

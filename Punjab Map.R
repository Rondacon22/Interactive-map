# Load necessary libraries
library(geojsonio)
library(sf)

# Using geojsonio to read the GeoJSON file
pakistan_json <- geojson_read("C:/Users/HP/Desktop/Pitb/DUA/pakistan_districts.json", what = "sp")

# Using sf to read the GeoJSON file
pakistan_sf <- st_read("C:/Users/HP/Desktop/Pitb/DUA/pakistan_districts.json")

# View the first few rows of the data read by sf
print(head(pakistan_sf))


library(tidyverse)
# Read the GeoJSON file
pakistan_shapefile <- st_read("C:/Users/HP/Desktop/Pitb/DUA/pakistan_districts.geojson")

# Display basic information about the shapefile
print(pakistan_shapefile)

# Plot the shapefile using ggplot2
pakistan_shapefile%>%filter(province_territory=="Punjab")%>%
  ggplot() +
  geom_sf() +
  geom_sf_text( aes(label = district_agency), size = 2, color = "red") +
  theme_minimal() +
  labs(title = "Map of Pakistan with District Names", 
       caption = "Source: Pakistan GeoJSON Shapefile")
pakistan_sf%>%filter(province_territory == "Punjab")%>%view()

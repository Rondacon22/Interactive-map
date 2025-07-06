# Load required libraries
library(geojsonio)
library(sf)
library(tidyverse)
library(ggplot2)

# Read the GeoJSON file using sf
pakistan_shapefile <- st_read("STAT317A/pakistanmap/pakistan_districts.geojson")

# Display basic information about the shapefile
print(pakistan_shapefile)

# Plot the shapefile showing all provinces
pakistan_shapefile %>%
  ggplot() +
  geom_sf(aes(fill = province_territory), color = "black", size = 0.2) + # Color provinces differently
  geom_sf_text(aes(label = district_agency), size = 2, color = "red") + # Add district labels
  theme_minimal() +
  labs(
    title = "Map of Pakistan with District Names and Provinces",
    caption = "Source: Pakistan GeoJSON Shapefile",
    fill = "Province/Territory"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "right"
  )





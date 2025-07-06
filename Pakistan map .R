library(geojsonio)
library(sf)
library(readr)
library(ggplot2)

# Using geojsonio to read the GeoJSON file
pakistan_json <- geojson_read 
pakistan_districts <- read_csv("STAT317A/pakistanmap/pakistan_districts.csv")


# Using sf to read the GeoJSON file
pakistan_sf <- st_read("STAT317A/pakistanmap/pakistan_districts.geojson")

# View the first few rows of the data read by sf
print(head(pakistan_sf))

pakistan_shapefile <- st_read("STAT317A/pakistanmap/pakistan_districts.geojson")

# Filter for Punjab
punjab_shapefile <- pakistan_shapefile %>%
  filter(province_territory == "Punjab")


# Load voter data
voter_data <- read_csv("STAT317A/District Wise Voter stats.csv")

# Inspect the voter data
head(voter_data)

# Standardize district names for proper join
punjab_shapefile <- punjab_shapefile %>%
  mutate(district_agency = tolower(trimws(district_agency)))

voter_data <- voter_data %>%
  mutate(District = tolower(trimws(District)))

# Merge shapefile with voter data
punjab_voter_map <- punjab_shapefile %>%
  left_join(voter_data, by = c("district_agency" = "District"))

# Plot the map
ggplot(data = punjab_voter_map) +
  geom_sf(aes(fill = Total)) +
  geom_sf_text(aes(label = district_agency), size = 2, color = "black") +
  scale_fill_viridis_c(option = "plasma", name = "Total Voters") +
  theme_minimal() +
  labs(
    title = "District-wise Voter Map of Punjab",
    subtitle = "Based on provided voter statistics",
    caption = "Source: Pakistan GeoJSON Shapefile and Voter Data"
  )



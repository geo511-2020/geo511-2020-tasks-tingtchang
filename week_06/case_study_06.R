# Load the libraries
library(raster)
library(sp)
library(spData)
library(tidyverse)
library(sf)


# Prepare world vector data
data(world)
head(world)

world_filter_sf <- world %>%
  filter(continent != "Antarctica")    #filter out Antarctica
head(world_filter_sf)

world_filter_sp <- as(world_filter_sf, "Spatial")    #convert sf to sp


# Prepare monthly WorldClim data
tmax_monthly <- getData(name="worldclim", var="tmax", res=10)
# tmax_monthly
# plot(tmax_monthly)

tmax_annual <- max(tmax_monthly)
names(tmax_annual) <- "tmax"
gain(tmax_annual) <- 0.1
# tmax_annual
# plot(tmax_annual)


# Extract maximum temperature for each country (extract raster values for the polygons)
tmax_country_sp <- raster::extract(tmax_annual, world_filter_sp, fun=max, na.rm=T, small=T, sp=T)

tmax_country_sf <- st_as_sf(tmax_country_sp)
head(tmax_country_sf)


# Plot out maximum temperature for each country
figure_tmax <- ggplot(data=tmax_country_sf, aes(fill=tmax)) +
  geom_sf() +
  scale_fill_viridis_c(name="Annual\nMaximum\nTemperature (C)") +
  theme(legend.position='bottom')

print(figure_tmax)

# ggsave("tmax_countries.png", dpi=300)


# Find the hottest country in each continent
tmax_summary_df <- tmax_country_sf %>%
  select(name_long, continent, tmax) %>%
  st_set_geometry(NULL) %>%
  group_by(continent) %>%
  top_n(1, tmax) %>%      # suggested by groupmate, Sandra, to specify the "tmax" column
  arrange(desc(tmax))

head(tmax_summary_df)

# write.csv(tmax_summary_df,"tmax_summary.csv", row.names = FALSE)


# Reference
# Export CSV refers to
# https://datatofish.com/export-dataframe-to-csv-in-r/
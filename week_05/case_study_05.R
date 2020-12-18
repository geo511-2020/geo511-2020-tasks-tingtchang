# Load in related libraries
library(spData)
library(sf)
library(tidyverse)
library(units)


# Load in world and US data
data(world)
data(us_states)

head(world)
head(us_states)


# Filter out Canada and NY and transform the projection
albers = "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +
ellps=GRS80 +datum=NAD83 +units=m +no_defs"

canada <- world %>%
  filter(name_long == "Canada") %>%
  st_transform(crs = albers)

ny <- us_states %>%
  filter(NAME == "New York") %>%
  st_transform((crs = albers))


# Spatial operation
ca_buffer <- canada%>%
  st_buffer(10000)   #buffer the canadian borders

ny_polygon <- st_intersection(ca_buffer, ny)   #intersect NY State with CA border's buffer


# Plot out the polygons and NY State
ggplot()+
  geom_sf(data=ny)+
  geom_sf(data=ny_polygon, fill="red")+
  labs(title="New York Land within 10km")


# Calculate the area of obtained polygon
ny_poly_area <- st_area(ny_polygon) %>%
  set_units(km^2)

print(ny_poly_area)
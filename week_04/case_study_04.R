# Week 4 Case Study 4

# Import related libraries
library(tidyverse)
library(nycflights13)

# Look up the data
View(flights)
View(airlines)
View(airports)
View(planes)
View(weather)

# Drop unnecessary columns
flights_cleaned <- flights %>%
  select(origin, dest, distance)

# Make sure origins from the flights df are all located in NYC
unique(flights_cleaned$origin)

origins <- flights_cleaned %>%
  left_join(airports, c("origin" = "faa")) %>%
  select(origin, tzone)

unique(origins$tzone)

# Find out the farthest airports from origin
dest_desc_dist <- flights_cleaned %>%
  left_join(airports, c("dest" = "faa")) %>%
  select(origin, dest, distance, name) %>%
  rename(dest_name = name) %>%
  arrange(desc(distance))

dest_desc_dist

# Print out the farthest airport
farthest_airport <- dest_desc_dist[[1,4]]
cat("The farthest airport is:", farthest_airport,"\n")



# Reference
# unique() function refers to
# https://stackoverflow.com/questions/7755240/list-distinct-values-in-a-vector-in-r

# rename() function refers to
# https://medium.com/@HollyEmblem/renaming-columns-with-dplyr-in-r-55b42222cbdc

# double brackets [[ ]] refers to 
# https://stackoverflow.com/questions/18508633/get-only-the-value-of-an-element-in-an-r-data-frame-without-the-index

# cat() function refers to
# https://stackoverflow.com/questions/32241806/how-to-print-text-and-variables-in-a-single-line-in-r
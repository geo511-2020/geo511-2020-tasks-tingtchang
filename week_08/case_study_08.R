# Load the libraries
library(tidyverse)
library(ggplot2)
library(kableExtra)
library(magick)


# # Explore the format of the data
# temp <- read_table("ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_annmean_mlo.txt")
# str(temp)
# view(temp)


# Load the data
co2_data <- read_table("ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_annmean_mlo.txt", skip=56)
# view(co2_data)

co2_data <- co2_data %>%
  select(year, mean, unc)


# Timeseries plot
co2_series <- ggplot(data=co2_data) +
  geom_line(aes(x=year, y=mean), col="orange", size=1.25) +
  labs(x="Year", y="Mean Loa Annual Mean CO_2 (ppm)",
       title="Annual Mean Carbon Dioxide Concentrations 1959-Present") +
  theme_light()

co2_series


# Top ten annual mean CO2
top_ten_co2 <- co2_data %>%
  top_n(10, mean) %>%
  arrange(desc(mean)) %>%
  select(year, mean)
  
top_ten_co2
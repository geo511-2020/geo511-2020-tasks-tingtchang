# Load libraries
library(tidyverse)
library(reprex)
library(sf)

# Load Data
library(spData)
data(world)

# # Reproduible code
# library(spData)
# data(world)
# 
# library(ggplot2)
# 
# ggplot(world,aes(x=gdpPercap, y=continent, color=continent))+
#   geom_density(alpha=0.5,color=F)

# Fix the code
gdp_plot <- ggplot(world,aes(x=gdpPercap, fill=continent))+
  geom_density(alpha=0.5,color=F)+
  labs(x="GDP Per Capital", y="Density")+
  theme(legend.position = 'bottom')

print(gdp_plot)

# ggsave("gdp_continent.png")

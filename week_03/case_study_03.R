# Import related library
library(ggplot2)
library(gapminder)
library(dplyr)

# Remove Kuwait from gapminder
data <- gapminder %>%
  filter(country != "Kuwait")

p1 <- ggplot(data, aes(lifeExp, gdpPercap, color=continent, size=pop/100000)) + 
  geom_point() + 
  facet_wrap(~year, nrow=1) + 
  scale_y_continuous(trans="sqrt") + 
  theme_bw() + 
  labs(x="Life Expectancy", y="GDP per capita",size="Population (100k)", color="continent")

print(p1)

ggsave("plot1.png", width=15, units="in")
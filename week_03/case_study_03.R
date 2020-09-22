# Import related library
library(ggplot2)
library(gapminder)
library(dplyr)

# Remove Kuwait from gapminder
gapminder_filtered <- gapminder %>%
  filter(country != "Kuwait")

# Plot one
p1 <- ggplot(gapminder_filtered, aes(lifeExp, gdpPercap, color=continent, size=pop/100000)) + 
  geom_point() + 
  facet_wrap(~year, nrow=1) + 
  scale_y_continuous(trans="sqrt") + 
  theme_bw() + 
  labs(x="Life Expectancy", y="GDP per capita",size="Population (100k)", color="Continent")

print(p1)

ggsave("plot1.png", width=15, units="in")

# Plot two
# Preparing the data
gapminder_continent <- gapminder_filtered %>%
  group_by(continent, year) %>%
  summarize(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop), 
            pop = sum(as.numeric(pop)))

# Plotting
p2 <- ggplot(gapminder_filtered, aes(x=year, y=gdpPercap, col=continent)) +
  geom_line(aes(group=country)) +
  geom_point(aes(size=pop/100000, group=country)) +
  geom_line(data=gapminder_continent, mapping=aes(x=year, y=gdpPercapweighted, col="black")) +
  geom_point(data=gapminder_continent, mapping=aes(x=year, y=gdpPercapweighted, size=pop/100000, col="black")) +
  facet_wrap(~continent, nrow=1) +
  theme_bw() +
  labs(x="Year", y="GDP per capita", size="Population (100K)", color="Continent")

print(p2)
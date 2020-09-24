# Import related libraries
library(ggplot2)
library(gapminder)
library(dplyr)

# Remove Kuwait from gapminder dataset
gapminder_filtered <- gapminder %>%
  filter(country != "Kuwait")

## Plot one
p1 <- ggplot(gapminder_filtered, aes(lifeExp, gdpPercap, color=continent, size=pop/100000)) + 
  geom_point() + 
  facet_wrap(~year, nrow=1) + 
  scale_y_continuous(trans="sqrt") + 
  theme_bw() + 
  labs(x="Life Expectancy", y="GDP per capita", size="Population (100k)", color="Continent")

print(p1)

ggsave("plot1.png", width=15, units="in")

## Plot two
# Preparing the data
gapminder_continent <- gapminder_filtered %>%
  group_by(continent, year) %>%
  summarize(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop), 
            pop = sum(as.numeric(pop)))

# Plotting
# Looked up "group argument" at R4DS Chapter 3.6 
# and "https://drsimonj.svbtle.com/plotting-individual-observations-and-group-means-with-ggplot2"

p2 <- ggplot(gapminder_filtered, aes(x=year, y=gdpPercap)) +
  geom_line(aes(group=country, color=continent)) +
  geom_point(aes(size=pop/100000, group=country, color=continent)) +
  geom_line(data=gapminder_continent, color="black", aes(x=year, y=gdpPercapweighted)) +
  geom_point(data=gapminder_continent, color="black", aes(x=year, y=gdpPercapweighted, size=pop/100000)) +
  facet_wrap(~continent, nrow=1) +
  theme_bw() +
  labs(x="Year", y="GDP per capita", size="Population (100k)", color="Continent")

print(p2)

ggsave("plot2.png", width=15, units="in")
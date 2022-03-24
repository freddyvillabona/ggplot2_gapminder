
# Lib:
library(ggplot2)
library(dplyr)
library(gapminder)
library(hrbrthemes)

data <- gapminder

?gapminder

data <- gapminder %>% 
  dplyr::filter(year=="2007") %>% 
  dplyr::select(-year)

names(data)[2] = "Continente"
data$pop <- as.numeric(data$pop)

data <- data %>%
  dplyr::arrange(desc(pop)) %>%
  dplyr::mutate(country = factor(country, country))

legend_size <- c(8,9,10,11,12)

ggplot(data, aes(gdpPercap, lifeExp)) +
  ggtitle("Esperanza de vida, PIB per cápita y población por países - 2007") +
  ylab("Esperanza de vida") +
  xlab("PIB per cápita") +
  geom_point(aes(size = pop, 
             fill = Continente), 
             shape = 21, 
             alpha = 0.7) +
  scale_fill_viridis_d(
    guide = guide_legend(override.aes = list(size = 10))) +
  scale_size(range = c(0.1, 30),
             name="Población (mills.)",
           breaks = 1000000 * c(250, 500, 750, 1000, 1250),
           labels = c("250", "500", "750", "1000", "1250"),
           ) +
  geom_text(aes(x = gdpPercap, y = lifeExp + 3, label = country),
            color = "blue",
            data = filter(data, pop > 1000000000 | country %in% c("Nigeria", 
                                                                  "United States",
                                                                  "Brazil",
                                                                  "Spain",
                                                                  "Argentina",
                                                                  "Japan",
                                                                  "Zambia",
                                                                  "Australia"))) +
theme_ipsum(axis_title_size = 13,
              base_family = "Arial Narrow") 








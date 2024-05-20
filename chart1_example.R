library(dplyr)
library(ggplot2)

king_county <- wa_data %>%
  filter(county_name == "King County")

# king county chart with trends over time of jail population
ggplot() +
  labs(title = "Jail Population Rates in King County From 1990 - 2018",
       x = "Year",
       y = "Total Jail Population Rate") +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 24)) +
  geom_line(data = king_county, aes(x = year, y = aapi_jail_pop_rate, color="AAPI")) +
  geom_line(data = king_county, aes(x = year, y = black_jail_pop_rate, color = "Black")) +
  geom_line(data = king_county, aes(x = year, y = latinx_jail_pop_rate, color = "Latinx")) +
  geom_line(data = king_county, aes(x = year, y = native_jail_pop_rate, color = "Native")) +
  geom_line(data = king_county, aes(x = year, y = white_jail_pop_rate, color = "White")) +
  theme(axis.text.x = element_text(size = 5))


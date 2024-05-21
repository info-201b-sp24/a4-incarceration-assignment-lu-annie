library(dplyr)
library(ggplot2)

# calculate correlation

correlation_coefficient <- cor(king_county$white_jail_pop_rate, king_county$black_jail_pop_rate)
print(correlation_coefficient)

# plot king county chart with trends between white and black population rates

ggplot(king_county, aes(x = white_jail_pop_rate, y = black_jail_pop_rate)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "White vs Black Jail Population Rate in King County for 1990 - 2018", x = "White Jail Population Rate", y = "Black Jail Population Rate")

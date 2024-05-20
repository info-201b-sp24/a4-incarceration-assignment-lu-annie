library(dplyr)

wa_data <- read.csv("/Users/annielu/Desktop/info201 hw/a4-incarceration-assignment-lu-annie/raw.githubusercontent.com_melaniewalsh_Neat-Datasets_main_us-prison-jail-rates-1990-WA.csv")

summary_info <- list()

# county with lowest prison pop

summary_info$county_highest_prison_pop <- wa_data %>%
  arrange(desc(total_jail_pop_rate)) %>%
  slice(1) %>%
  select(county_name, total_jail_pop_rate)

# county with highest prison pop

summary_info$county_lowest_prison_pop <- wa_data %>%
  arrange(total_jail_pop_rate) %>%
  slice(1) %>%
  select(county_name, total_jail_pop_rate)

# the highest number of poc in prison

summary_info$highest_poc_prison_pop <- wa_data %>%
  summarize(
    highest_poc_prison_pop = max(
    aapi_prison_pop_rate,
    black_prison_pop_rate,
    latinx_prison_pop_rate,
    native_prison_pop_rate,
    na.rm = TRUE
    )) %>%
  select(highest_poc_prison_pop)

# which county with highest poc in prison

summary_info$county_highest_poc_prison <- wa_data %>%
  group_by(county_name) %>%
  summarize(
    county_highest_poc_prison = max(
      aapi_jail_pop_rate,
      black_jail_pop_rate,
      latinx_jail_pop_rate,
      native_jail_pop_rate,
      na.rm = TRUE
    )) %>%
  slice(1) %>%
  select(county_name, county_highest_poc_prison)

# year with greatest amount of prisoners (and county)

summary_info$year_highest_prisoners <- wa_data %>%
  filter(total_jail_pop_rate == max(total_jail_pop_rate, na.rm = TRUE)) %>%
  select(year, county_name, total_jail_pop_rate)

print(summary_info)
  

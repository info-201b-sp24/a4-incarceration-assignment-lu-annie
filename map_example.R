library(dplyr)
library(ggplot2)
library(sf)
library(maps)
library(patchwork)

# set county boundaries

counties <- map_data("county")
wa_counties <- counties %>%
  filter(region == 'washington')

# edits for joining dataframes

wa_data$county_name <- tolower(wa_data$county_name)
wa_data <- wa_data %>%
  mutate(county_name = gsub(" county$", "", county_name, ignore.case = TRUE))

# merge datasets

merged_wa_data <- left_join(wa_counties, wa_data, by = c("subregion" = "county_name"), relationship= "many-to-many")

# create map of total jail pop rates in wa counties
# retrieved from https://www.geeksforgeeks.org/how-to-create-state-and-county-maps-easily-in-r/

map <- function(x,y,dataset,fill_column, fill_title){
  p <- ggplot(data = dataset,
              mapping = aes(x = x, y = y, group = group, fill = fill_column))
  p + geom_polygon() + labs(fill = fill_title) + 
    coord_fixed(ratio = 2) +
    theme(legend.text = element_text(size = 5),
          legend.title = element_text(size = 5),
          legend.key.size = unit(0.25, "cm"),
          axis.title.x = element_blank(),
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          axis.title.y = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank())
}

# create individual plots

map1 <- map(merged_wa_data$long,merged_wa_data$lat,merged_wa_data, merged_wa_data$total_jail_pop_rate, "Total Jail Pop Rate")
map2 <- map(merged_wa_data$long,merged_wa_data$lat,merged_wa_data, merged_wa_data$aapi_jail_pop_rate, "AAPI Jail Pop Rate")
map3 <- map(merged_wa_data$long,merged_wa_data$lat,merged_wa_data, merged_wa_data$black_jail_pop_rate, "Black Jail Pop Rate")
map4 <- map(merged_wa_data$long,merged_wa_data$lat,merged_wa_data, merged_wa_data$latinx_jail_pop_rate, "Latinx Jail Pop Rate")
map5 <- map(merged_wa_data$long,merged_wa_data$lat,merged_wa_data, merged_wa_data$native_jail_pop_rate, "Native Jail Pop Rate")
map6 <- map(merged_wa_data$long,merged_wa_data$lat,merged_wa_data, merged_wa_data$white_jail_pop_rate, "White Jail Pop Rate")

# put plots together

patchwork <- (map1 | map2 | map3 ) / (map4 | map5 | map6 )
patchwork + plot_annotation(
  title = 'Jail Population Rates by County in WA State'
)



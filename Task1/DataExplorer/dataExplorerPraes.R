#Paktet installieren und Daten vorbereiten

install.packages("DataExplorer")
install.packages("nycflights13")
library(nycflights13)
library(DataExplorer)

#Daten für Introduction
data_list <- list(airlines, airports, flights, planes, weather)

plot_str(data_list)

plot_str(data_list, type = "r") 
#Daten für Report
merge_airlines <- merge(flights, airlines, by = "carrier", all.x = TRUE)
merge_planes <- merge(merge_airlines, planes, by = "tailnum", all.x = TRUE, suffixes = c("_flights", "_planes"))
merge_airports_origin <- merge(merge_planes, airports, by.x = "origin", by.y = "faa", all.x = TRUE, suffixes = c("_carrier", "_origin"))
final_data <- merge(merge_airports_origin, airports, by.x = "dest", by.y = "faa", all.x = TRUE, suffixes = c("_origin", "_dest"))


create_report(final_data)

config <- configure_report(
  add_plot_str = FALSE,
  add_plot_qq = FALSE,
  add_plot_prcomp = FALSE,
  add_plot_boxplot = FALSE,
  add_plot_scatterplot = FALSE,
  global_ggtheme = quote(theme_minimal(base_size = 14))
)
create_report(final_data, config = config)

introduce(final_data)

profile_missing(final_data)
plot_missing(final_data)

final_data <- drop_columns(final_data, "speed")

plot_missing(final_data)

introduce(final_data)


#Bar Charts
plot_bar(final_data)
plot_bar(final_data$manufacturer)

  #Clean up duplicates
final_data[which(final_data$manufacturer == "AIRBUS INDUSTRIE"),]$manufacturer <- "AIRBUS"
final_data[which(final_data$manufacturer == "CANADAIR LTD"),]$manufacturer <- "CANADAIR"
final_data[which(final_data$manufacturer %in% c("MCDONNELL DOUGLAS AIRCRAFT CO", "MCDONNELL DOUGLAS CORPORATION")),]$manufacturer <- "MCDONNELL DOUGLAS"

plot_bar(final_data$manufacturer)

plot_bar(final_data, by = "origin")


#Correlation analysis

plot_correlation(na.omit(final_data), maxcat = 5L)

plot_correlation(na.omit(final_data), type = "c")
plot_correlation(na.omit(final_data), type = "d")

install.packages("DataExplorer")
install.packages("nycflights13")
library(nycflights13)
library(DataExplorer)
#Data Introduction
data_list <- list(airlines, airports, flights, planes, weather)
plot_str(data_list)

plot_str(data_list, type = "r") 

merge_airlines <- merge(flights, airlines, by = "carrier", all.x = TRUE)
merge_planes <- merge(merge_airlines, planes, by = "tailnum", all.x = TRUE, suffixes = c("_flights", "_planes"))
merge_airports_origin <- merge(merge_planes, airports, by.x = "origin", by.y = "faa", all.x = TRUE, suffixes = c("_carrier", "_origin"))
final_data <- merge(merge_airports_origin, airports, by.x = "dest", by.y = "faa", all.x = TRUE, suffixes = c("_origin", "_dest"))
introduce(final_data)

plot_intro(final_data)

plot_missing(final_data)

final_data <- drop_columns(final_data, "speed")

#Barplots

barplot(final_data)

final_data[which(final_data$manufacturer == "AIRBUS INDUSTRIE"),]$manufacturer <- "AIRBUS"
final_data[which(final_data$manufacturer == "CANADAIR LTD"),]$manufacturer <- "CANADAIR"
final_data[which(final_data$manufacturer %in% c("MCDONNELL DOUGLAS AIRCRAFT CO", "MCDONNELL DOUGLAS CORPORATION")),]$manufacturer <- "MCDONNELL DOUGLAS"
plot_bar(final_data$manufacturer)

final_data <- drop_columns(final_data, c("dst_origin", "tzone_origin", "year_flights", "tz_origin"))

plot_bar(final_data, with = "arr_delay")

plot_bar(final_data, by = "origin")
plot_bar(final_data$name_carrier, by = "origin")

#Histograms

plot_histogram(final_data)

final_data <- update_columns(final_data, "flight", as.factor)
final_data <- drop_columns(final_data, c("year_flights", "tz_origin"))

plot_histogram(final_data)

#gg plots

qq_data <- final_data[, c("arr_delay", "air_time", "distance", "seats")]

plot_qq(qq_data, sampled_rows = 1000L)

log_qq_data <- update_columns(qq_data, 2:4, function(x) log(x + 1))

plot_qq(log_qq_data[, 2:4], sampled_rows = 1000L)

qq_data <- final_data[, c("name_origin", "arr_delay", "air_time", "distance", "seats")]

plot_qq(qq_data, by = "name_origin", sampled_rows = 1000L)

#Correlation analysis

plot_correlation(na.omit(final_data), maxcat = 5L)

plot_correlation(na.omit(final_data), type = "c")
plot_correlation(na.omit(final_data), type = "d")

#Principal Component Analysis

pca_df <- na.omit(final_data[, c("origin", "dep_delay", "arr_delay", "air_time", "year_planes", "seats")])

plot_prcomp(pca_df, variance_cap = 0.9, nrow = 2L, ncol = 2L)

#Boxplots

## Reduce data size for demo purpose
arr_delay_df <- final_data[, c("arr_delay", "month", "day", "hour", "minute", "dep_delay", "distance", "year_planes", "seats")]

## Call boxplot function
plot_boxplot(arr_delay_df, by = "arr_delay")

#Scatterplots

arr_delay_df2 <- final_data[, c("arr_delay", "dep_time", "dep_delay", "arr_time", "air_time", "distance", "year_planes", "seats")]

plot_scatterplot(arr_delay_df2, by = "arr_delay", sampled_rows = 1000L)

#Group sparse categories

group_category(data = final_data, feature = "manufacturer", threshold = 0.2)

final_df <- group_category(data = final_data, feature = "manufacturer", threshold = 0.2, update = TRUE)
plot_bar(final_df$manufacturer)

group_category(data = final_data, feature = "name_carrier", threshold = 0.2, measure = "distance")

final_df <- group_category(data = final_data, feature = "name_carrier", threshold = 0.2, measure = "distance", update = TRUE)
plot_bar(final_df$name_carrier)

#Dummify data (one hot encoding)

plot_str(
  list(
    "original" = final_data,
    "dummified" = dummify(final_data, maxcat = 5L)
  )
)

#Data Reporting

create_report(final_data)

create_report(final_data, y = "arr_delay")

configure_report(
  add_plot_str = FALSE,
  add_plot_qq = FALSE,
  add_plot_prcomp = FALSE,
  add_plot_boxplot = FALSE,
  add_plot_scatterplot = FALSE,
  global_ggtheme = quote(theme_minimal(base_size = 14))
)

config <- configure_report(
  add_plot_str = FALSE,
  add_plot_qq = FALSE,
  add_plot_prcomp = FALSE,
  add_plot_boxplot = FALSE,
  add_plot_scatterplot = FALSE,
  global_ggtheme = quote(theme_minimal(base_size = 14))
)
create_report(final_data, config = config)

config <- list(
  "introduce" = list(),
  "plot_intro" = list(),
  "plot_str" = list(
    "type" = "diagonal",
    "fontSize" = 35,
    "width" = 1000,
    "margin" = list("left" = 350, "right" = 250)
  ),
  "plot_missing" = list(),
  "plot_histogram" = list(),
  "plot_density" = list(),
  "plot_qq" = list(sampled_rows = 1000L),
  "plot_bar" = list(),
  "plot_correlation" = list("cor_args" = list("use" = "pairwise.complete.obs")),
  "plot_prcomp" = list(),
  "plot_boxplot" = list(),
  "plot_scatterplot" = list(sampled_rows = 1000L)
)
create_report(final_data, config = config)
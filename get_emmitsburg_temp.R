# get_emmitsburg_temp.R

library(httr)
library(jsonlite)
library(readr)

url <- "https://api.weather.gov/stations/KHGR/observations/latest"
data <- fromJSON(url)

temp_c <- data$properties$temperature$value
temp_f <- temp_c * 9/5 + 32

wind_speed_km <- data$properties$windSpeed$value
wind_speed_mph <- wind_speed_km/1.6

df <- data.frame(
  time = format(Sys.time(), tz="America/New_York", usetz=T),
  station = "KHGR",
  temp_c = temp_c,
  temp_f = temp_f,
  wind_speed_km = wind_speed_km,
  wind_speed_mph = wind_speed_mph
)

file <- "data/emmitsburg_weather.csv"

if(file.exists(file)){
  write_csv(df, file, append = T)
} else {
  write_csv(df, file)
}

library(shiny)
library(leaflet)
library(dplyr)
library(rgeos)
library(ggplot2)
library(shinydashboard)
library(DT)
library(googleVis)
library(magrittr)
library(rgdal)
library(purrr)
df1 <- read.csv(
  './final_data.csv',
  stringsAsFactors = FALSE,
  na.strings = c("", " ", "NA")
)

#creating new columns to display total number of people injured
#(includes:persons, cyclists, pedestrians, and motorists)
df1$TOTAL.INJURED <-
  df1$NUMBER.OF.PERSONS.INJURED +
  df1$NUMBER.OF.PEDESTRIANS.INJURED +
  df1$NUMBER.OF.CYCLIST.INJURED +
  df1$NUMBER.OF.MOTORIST.INJURED

#creating new columns to display total number of fatalities
#(includes:persons, cyclists, pedestrians, and motorists)
df1$TOTAL.FATALITIES <-
  df1$NUMBER.OF.PERSONS.KILLED +
  df1$NUMBER.OF.PEDESTRIANS.KILLED +
  df1$NUMBER.OF.CYCLIST.KILLED +
  df1$NUMBER.OF.MOTORIST.KILLED

#select variables I want to display on my dataframe
myvars <-
  c(
    "DATE",
    "TIME",
    "BOROUGH",
    "ZIP.CODE",
    "ON.STREET.NAME",
    "TOTAL.INJURED",
    "TOTAL.FATALITIES"
  )

df2 <- df1[myvars]
#shape

shapemap <- reactive({
    shape <- readOGR(dsn = "./ZIP_CODE_040114/ZIP_CODE_040114.shp")
    finalshape <- spTransform(shape, CRS("+proj=longlat +ellps=GRS80"))
  })




#smaller dataframe that will be displayed in shinyapp



#latitude, longitude, location

#add filter by date, borouh, zipcode
?map




#created a dataset of 50000 values to put into the map
# sample_data <- df1[c(1:50000),]
# saveRDS(sample_data, "./sample_data.rds")
# df1 <- readRDS("./sample_data.rds")
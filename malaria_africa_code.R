#loading the required libraries
library(tidyverse)
library(leaflet)
library(sf)
library(htmlwidgets)
library(leaflet.providers)
library(scales)
#loading the polygon dataset
africa <- st_read("C:/Users/DELL/Documents/Data Science/datasets_1/spatial_data/africa/africa_shapefile.shp")
###loading the malaria dataset
data <- read_csv("C:/Users/DELL/Documents/Data Science/datasets_1/spatial_data/DatasetAfricaMalaria.csv")
glimpse(data)
st_crs(africa)
#compressing the variable names
colnames(data) <- make.names(colnames(data))

## Plotting
map <- leaflet() %>% 
  addTiles() %>% 
  addPolygons(data = africa,
              fillColor = "lightblue",
              color = "blue",
              fillOpacity = 0.2,
              weight = 2) %>% 
  addCircleMarkers(data = data,
                   ~longitude, ~latitude,
                   radius = ~rescale(Malaria.cases.reported, to = c(1,5)),
                   color = "red",
                   fillOpacity = 0.7,
                   popup = ~paste(Country.Name, ":", 
                                  Malaria.cases.reported, "cases")) %>% 
  addControl(html = "<h2>Malaria Cases in Africa (2007-2017<h2>",
             position = "topright") %>% 
  addControl(html = "Data Source: Kaggle",
             position = "bottomright") %>% 
  addProviderTiles(providers$OpenStreetMap)


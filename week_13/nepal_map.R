# install.packages(c("leaflet", "geojsonio"))

library(leaflet)
library(geojsonio)

province_map <- geojsonio::topojson_read("./data/map/province-named.topojson") 


province_map %>% 
  leaflet(options = leaflet::leafletOptions(attributionControl=F, 
                                            preferCanvas = F)) %>%
  setView(lat = 28.3949, lng = 84.1240, zoom = 7) %>% 
  addProviderTiles("CartoDB.Positron", 
                   options = leaflet::providerTileOptions(
    minZoom = 7, maxZoom = 14
  )) %>%
  
  leaflet::addPolygons(data = province_map,
                       # fillColor = ~pal_province(province_df$infected), 
                       fillOpacity = 0.7,
                       opacity = 1,
                       weight = 0.5,
                       color = "#666",
                       dashArray = "0.5",
                       smoothFactor = 0.5,
                       label  = label1,
                       labelOptions = leaflet::labelOptions(
                         style = list("font-weight" = "normal", padding = "3px 8px"),
                         textsize = "15px",
                         direction = "auto"), 
                       group = "Cases"
  )

  
  
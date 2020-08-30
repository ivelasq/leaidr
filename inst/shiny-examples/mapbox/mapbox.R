#' Create Mapbox Map
#' Tutorial here:
#' https://asmae-toumi.netlify.app/posts/2020-08-10-how-to-make-web-ready-us-county-level-maps/

# Libraries ---------------------------------------------------------------

# remotes::install_github("walkerke/mapboxapi")
library(mapboxapi)

# if you haven't installed the package yet
# devtools::install_github("ivelasq/leaidr")
library(leaidr)

library(rmapshaper)
library(mapdeck)
library(tidyverse)

# Get Data ----------------------------------------------------------------

shp <- # leaidr shapefiles
  lea_get(c("or", "wa")) %>% 
  sf::st_as_sf()

dat <- 
  read_csv("/Users/shortessay/Downloads/ccd_lea_141_1819_l_1a_091019/ccd_lea_141_1819_l_1a_091019.csv") %>%
  filter(ST %in% c("OR", "WA"))

northwest <-
  shp %>%
  select(GEOID, geometry) %>%
  sp::merge(dat, by.x = "GEOID", by.y = "LEAID")

# Upload to Mapbox --------------------------------------------------------

tippecanoe(
  input = northwest,
  output = "nw.mbtiles",
  layer_name = "northwest")

upload_tiles(input = "nw.mbtiles",
             username = "ivelasq3", 
             tileset_id = "northwest",
             multipart = TRUE)

#' Once you have uploaded the tiles, you should see them available under "Custom tileset"
#' on this webpage: https://studio.mapbox.com/tilesets/
#' 
#' Then, go to Styles on this webpage: https://studio.mapbox.com/
#' Click "New Style" and choose the template you want, then Customize
#' To add your tileset, go to Layers, click the Plus sign, then under "Source"
#' find your uploaded tileset or add the tileset by the ID given by upload_tiles().
#' Once there, I zoomed to where my tiles are located and started editing.
#' Then, I clicked "Publish" on the top right.
#' To get the information to bring it back into R and be able to use the map
#' in a Shiny app, I clicked "Share" and scrolled to find the Style ID.
#' I copied it to include in this function.
#' For the location, I used the latitude/longitude listed in the browser URL.
#' I played around with the zoom level until I found one I liked.

# Bring back into R -------------------------------------------------------

mapdeck(token = Sys.getenv("MAPBOX_PUBLIC_TOKEN"),
        style = "mapbox://styles/ivelasq3/ckegq2o5r1gbv19lrtv3v2tnj",
        zoom = 4,
        location = c(-120.919, 45.685))
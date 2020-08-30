# Helpful example: https://github.com/greghuang8/Geovis/blob/master/shinyApp.R

# Packages ----------------------------------------------------------------

library(tidyverse)
library(shiny)
library(mapdeck)

# UI ----------------------------------------------------------------------

ui <- fluidPage(
  mapdeckOutput(outputId = "createMap")
)

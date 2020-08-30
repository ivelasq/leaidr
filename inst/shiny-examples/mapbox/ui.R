# Helpful example: https://github.com/greghuang8/Geovis/blob/master/shinyApp.R

# Packages ----------------------------------------------------------------

library(tidyverse)
library(shiny)
library(mapdeck)

# Mapdeck key: copy and paste your key in between the quotation marks

# UI ----------------------------------------------------------------------

ui <- fluidPage(
  mapdeckOutput(outputId = "createMap")
)

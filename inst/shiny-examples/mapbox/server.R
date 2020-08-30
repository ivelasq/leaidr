# Server ------------------------------------------------------------------

server <- function(input, output) {

  output$createMap <- renderMapdeck({
    mapdeck(token = Sys.getenv("MAPBOX_PUBLIC_TOKEN"),
            style = "mapbox://styles/ivelasq3/ckegq2o5r1gbv19lrtv3v2tnj",
            zoom = 4,
            location = c(-120.919, 45.685))
    })
}
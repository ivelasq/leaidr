# Server ------------------------------------------------------------------

server <- function(input, output) {

  output$createMap <- renderMapdeck({
    mapdeck(token = Sys.getenv("MAPBOX_PUBLIC_TOKEN"),
            style = "mapbox://styles/ivelasq3/ckehhzzld3l3p19mht1n8hksj",
            zoom = 4,
            location = c(-120.161, 45.843))
  })
}
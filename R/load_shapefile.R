#' Load Nation-Wide District Shapefile
#'
#' @description
#' `load_shapefile()` creates your designated shapefile
#'
#' @usage
#' load_shapefile()
#'
#' @rdname load_shapefile
#' @export

load_shapefile <- function() {
  message("This may take a while...")
  piggyback::pb_download()
  load("~/leaidr/default/Downloads/schooldistrict_rda.rda")
  suppressWarnings(
    rgdal::writeOGR(
      schooldistrict_rda,
      dsn = "./default/Downloads",
      layer = "schooldistrict_sy1819_tl19",
      driver = "ESRI Shapefile"
    )
  )
}
#' Get Nation-Wide District Shapefile
#'
#' @description
#' `get_shapefile()` creates your designated shapefile
#'
#' @usage
#' get_shapefile()
#'
#' @rdname get_shapefile
#' @export

get_shapefile <- function(path = NULL) {
  if(is.null(path)){
    stop("Please designate a file path, like this: `path = './test'`.")
  }
  message("This may take a while...")
  piggyback::pb_download(file = "schooldistrict_rda.rda",
                         repo = "ivelasq/leaidr",
                         dest = path)
  load(paste0(path, "/schooldistrict_rda.rda"))
  suppressWarnings(
    rgdal::writeOGR(
      schooldistrict_rda,
      dsn = path,
      layer = "schooldistrict_sy1819_tl19",
      driver = "ESRI Shapefile"
    )
  )
}

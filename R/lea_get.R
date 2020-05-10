#' Get Nation-Wide District Shapefile
#'
#' @description
#' `lea_get()`downloads the U.S. district shapefile
#'
#' @usage
#' lea_get()
#'
#' @rdname lea_get
#' @export lea_get

lea_get <- function(path = NULL) {
  if(is.null(path)){
    stop("Please designate a file path, like this: `path = './test'`.")
  }
  fs::dir_create(path)
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

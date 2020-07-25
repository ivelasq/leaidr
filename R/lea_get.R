#' Get Nation-Wide District Shapefile
#'
#' @name lea_get
#' @aliases lea_get
#' @export lea_get
#' 
#' @description
#' `lea_get()`downloads the U.S. district shapefile from GitHub.
#' @usage
#' lea_get(path = NULL)
#' 
#' @param path A character vector specifying a file path, such as: 
#' path = "./test". Will attempt to create the directory if it does not 
#' currently exist.
#'
#' @rdname lea_get
#' @export lea_get
#' 
#' @return
#' An RDS object and shapefiles.
lea_get <- function(path = NULL) {
  if(is.null(path)){
    stop("Please designate a file path, like this: `path = './test'`.")
  }
  if(!dir_exists(path)) {
    dir_create(path)  
  }
  message("This may take a while...")
  pb_download(file = "schooldistrict_rda.rda",
              repo = "ivelasq/leaidr",
              dest = path)
  load(file.path(path, "schooldistrict_rda.rda"))
  suppressWarnings(
    writeOGR(
      schooldistrict_rda,
      dsn = path,
      layer = "schooldistrict_sy1819_tl19",
      driver = "ESRI Shapefile"
    )
  )
}

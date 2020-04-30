#' Create State- or Nation-Wide District Shapefile
#'
#' @description
#' `create_shapefile()` creates your designated shapefile
#'
#' @usage
#' create_shapefile()
#'
#' @rdname create_shapefile
#' @export

create_shapefile <- function(state_abb){
  message("This may take a while...")
  fpath <- system.file("extdata", "schooldistrict_sy1819_tl19.shp", package = "leaidr")
  dis_map <- rgdal::readOGR(fpath)
  if(state_abb == "All"){
    dis_map
  } else {
    dis_map <-
      dis_map[which(dis_map$state %in% state_abb),]
  }
}

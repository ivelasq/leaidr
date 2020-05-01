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

create_shapefile <- function(fips){
  dis_map <- rgdal::readOGR("./default/Downloads", "schooldistrict_sy1819_tl19")
  if(fips == "All"){
    dis_map
  } else {
    dis_map <-
      dis_map[which(dis_map$STATEFP %in% fips),]
  }
}

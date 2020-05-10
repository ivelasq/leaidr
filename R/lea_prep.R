#' Prep State- or Nation-Wide District Shapefile
#'
#' @description
#' `lea_prep()` creates your designated shapefile
#'
#' @usage
#' lea_prep()
#'
#' @rdname lea_prep
#' @export lea_prep

lea_prep <- function(path = NULL, fips = NULL){
  if(is.null(path)){
    stop("Please designate where the .shp file from `get_sh()` exists, like this: `path = './test'`.")
  }
  if(is.null(fips)){
    stop("Please designate which fip(s) shapefiles you would like. If you would like the whole U.S., please write `fips = 'All'.")
  }
  dis_map <- rgdal::readOGR(dsn = paste0(path, "/schooldistrict_sy1819_tl19.shp"),
                            layer = "schooldistrict_sy1819_tl19")
  if(fips == "All"){
    dis_map
  } else {
    dis_map <-
      dis_map[which(dis_map$STATEFP %in% fips),]
  }
}

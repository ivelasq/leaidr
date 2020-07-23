#' Prep State- or Nation-Wide District Shapefile
#'
#' @name lea_prep
#' @aliases lea_prep
#' @export lea_prep
#' 
#' @description
#' `lea_prep()` creates your desired shapefile.
#' @usage
#' lea_prep(path = NULL, fips = NULL)
#' 
#' @param path A character vector specifying a file path, such as: path = "./test".
#' @param fips A character vector specifying a FIPS code for a state. A reference table is available [here](https://www.mcc.co.mercer.pa.us/dps/state_fips_code_listing.htm).
#'
#' @rdname lea_prep
#' @export lea_prep
#' 
#' @return 
#' A shapefile.
lea_prep <- function(path = NULL, fips = NULL){
  if(is.null(path)){
    stop("Please designate where the shapefiles from `lea_get()` exist, like this: `path = './test'`.")
  }
  if(is.null(fips)){
    stop("Please designate which fip(s) you would like. If you would like the whole U.S., please write `fips = 'All'`.")
  }
  dis_map <- readOGR(dsn = file.path(path, "schooldistrict_sy1819_tl19.shp"),
                     layer = "schooldistrict_sy1819_tl19")
  if(fips == "All"){
    dis_map
  } else {
    dis_map <-
      dis_map[which(dis_map$STATEFP %in% fips),]
  }
}

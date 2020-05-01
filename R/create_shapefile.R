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
  piggyback::pb_download()
  load("~/leaidr/default/Downloads/schooldistrict_rda.rda")
  suppressWarnings(rgdal::writeOGR(schooldistrict_rda, dsn = "./default/Downloads", layer = "schooldistrict_sy1819_tl19", driver = "ESRI Shapefile"))
  dis_map <- rgdal::readOGR("./default/Downloads", "schooldistrict_sy1819_tl19")
  if(state_abb == "All"){
    dis_map
  } else {
    dis_map <-
      dis_map[which(dis_map$state %in% state_abb),]
  }
}

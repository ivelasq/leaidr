#' Run {leaidr} Mapbox Shiny App Example
#'
#' @name runExample
#' @aliases runExample
#' @export runExample
#' 
#' @description
#' `runExample()` runs a Shiny app example. A great tutorial on how to include Shiny apps in packages is here: https://deanattali.com/2015/04/21/r-package-shiny-app/
#' @usage
#' runExample()
#' 
#' @rdname runExample
#' @export runExample
#' 
#' @return 
#' A Shiny app.
runExample <- function() {
  appDir <- system.file("shiny-examples", "mapbox", package = "leaidr")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing {leaidr}.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}
pull_state_fip <- function(state_abb) {
  state_abb <- toupper(state_abb)
  fips <- c("02", "01", "05", "60", "04", "06", "08", "09", "11", "10", "12", 
            "13", "66", "15", "19", "16", "17", "18", "20", "21", "22", "25", 
            "24", "23", "26", "27", "29", "28", "30", "37", "38", "31", "33", 
            "34", "35", "32", "36", "39", "40", "41", "42", "72", "44", "45", 
            "46", "47", "48", "49", "51", "78", "50", "53", "55", "54", "56")
  
  states <- c("AK", "AL", "AR", "AS", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", 
              "GA", "GU", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", 
              "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", 
              "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", 
              "SD", "TN", "TX", "UT", "VA", "VI", "VT", "WA", "WI", "WV", "WY")
  names(fips) <- states
  fips[state_abb]
}

create_paths <- function(fip) {
  base_url <- "https://github.com/datalorax/us-district-shapefiles/raw/master/individ-districts/"
  extensions <- c(".dbf", ".prj", ".shp", ".shx")
  paste0(base_url, rep(fip, each = length(extensions)), extensions)
}


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
#' @param state Either a FIPS code or two-digit abbreviation for the state to 
#' obtain district shape files. If \code{NULL}, shape files for the entire US 
#' will be downloaded. Can be a vector of multiple states.
#'
#' @rdname lea_get
#' @export lea_get
#' 
#' @return
#' An RDS object and shapefiles.
lea_get <- function(state = NULL) {
  if(!is.null(state)) {
    if(any(is.na(suppressWarnings(as.numeric(state))))) {
      state <- pull_state_fip(state)
    }
    paths <- create_paths(state)
    file_names <- lapply(paths, strsplit, "/")
    file_names <- lapply(file_names, function(x) x[[1]][length(x[[1]])])
    
    tmpdir <- tempdir(check = TRUE)
    lapply(state, function(x) dir_create(tmpdir, x))
    
    Map(function(.x, .y, state) {
      download.file(.x, destfile = file.path(tmpdir, state, .y))
      },
      .x = paths, 
      .y = file_names,
      rep(state, each = 4)
    )
    
    l <- lapply(state, function(x) {
            readOGR(dsn = file.path(tmpdir, x),
                    layer = x)
      })
    return(Reduce(rbind, l))
  }
  else {
    message("Downloading shape files for the school districts across the entire 
            United States. This may take a while...")
    
    tmpdir <- tempdir(check = TRUE)
    pb_download(file = "schooldistrict_rda.rda",
                repo = "ivelasq/leaidr",
                dest = tmpdir)
    load(file.path(tmpdir, "schooldistrict_rda.rda"))
    schooldistrict_rda
  }
}

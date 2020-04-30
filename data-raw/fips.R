## code to prepare `fips` dataset goes here

fips <-
  tigris::fips_codes %>% 
  dplyr::select(state_code, state, state_name) %>% 
  dplyr::distinct()

usethis::use_data(fips, overwrite = TRUE)

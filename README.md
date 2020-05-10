
<!-- README.md is generated from README.Rmd. Please edit that file -->

# leaidr <img src='man/figures/logo.png' align="right" height="150" />

<!-- badges: start -->

<!-- badges: end -->

The goal of leaidr is to provide an easy way to map U.S. school
districts in R.

## Installation

You can install the development version of this package from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ivelasq/leaidr")
```

## About

The original shapefiles can be found on the [National Center for
Education
Statistics](https://nces.ed.gov/programs/edge/Geographic/DistrictBoundaries)
site. These files are from 2019.

We’ll work on adding state names/abbreviation so we don’t have to use
FIPS, but
[here](https://www.mcc.co.mercer.pa.us/dps/state_fips_code_listing.htm)
are the codes for quick reference.

## Get the U.S. Shapefile

Load the shapefile for the entire U.S. using `lea_get()`. Loading may
take a while - large files were uploaded to Github using {piggyback}.
You will have to load the shapefile anytime you’re in a new
directory/project.

  - **You must have a GITHUB\_PAT before you can run `get_sh()`.** You
    can set a token in your [developer
    settings](https://github.com/settings/tokens) and save it in your R
    Environment. More info can be found in [Happy Git with
    R](https://happygitwithr.com/github-pat.html).

## Prep a Shapefile

Run the function `lea_prep()` to create a shapefile with district
boundaries. If you want the entire U.S., then designate `fips = "All"`.
If you want a specific state, then designate it with the state
abbrevation `fips = "47"`. To designate multiple states, designate it in
a vector `fips = c("47", "06")`.

## Use the Data

Once you have the shapefile, you can merge other data using `merge()`.
You can also plot the shapefiles in {leaflet} and {ggplot2}.

### ggplot2 Example

``` r
library(leaidr)
library(ggplot2)
library(mapproj)

# if you haven't downloaded the shapefile
# lea_get(path = "./leaid_sh")

tn <- lea_prep(path = "./leaid_sh", fips = "47")
#> OGR data source with driver: ESRI Shapefile 
#> Source: "/Users/shortessay/leaidr/leaid_sh/schooldistrict_sy1819_tl19.shp", layer: "schooldistrict_sy1819_tl19"
#> with 13315 features
#> It has 18 fields

tn_df <- ggplot2::fortify(tn)

tn_map <-
  ggplot() +
  geom_path(data = tn, 
            aes(x = long, y = lat, group = group),
            color = "gray", size = .2) +
  theme_void()

tn_map_projected <- 
  tn_map +
  coord_map()

print(tn_map_projected)
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

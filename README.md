
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

School districts in the U.S. have associated local education agency
identification numbers (LEAID) used in the [National Center for
Education Statistics (NCES)](https://nces.ed.gov/) Common Core of Data.
These are very useful because if you have other datasets with NCES ID’s,
then you can (sometimes easily) join them.

The original shapefiles can be found on the
[NCES](https://nces.ed.gov/programs/edge/Geographic/DistrictBoundaries)
site. These files are from 2019.

For now, you must use the state’s FIPS code. FIPS state codes are
numeric and two-letter alphabetic codes to identify U.S. states and
certain other associated areas.
[Here](https://www.mcc.co.mercer.pa.us/dps/state_fips_code_listing.htm)
is a table with the codes for quick reference.

## Get the U.S. Shapefile

Load the shapefile for the entire U.S. using `lea_get()`. Loading may
take a while - large files were uploaded to GitHub using ROpenSci’s
{piggyback}. You will have to load the shapefile anytime you’re in a new
directory/project.

**You must have a GITHUB\_PAT before you can run `get_sh()`.** You can
set a token in your [developer
settings](https://github.com/settings/tokens) and save it in your R
Environment. More info can be found in [Happy git with
R](https://happygitwithr.com/github-pat.html).

## Prep a Shapefile

Run the function `lea_prep()` to create a shapefile with district
boundaries. If you want the entire U.S., then designate `fips = "All"`.
If you want a specific state, then designate it with the state
abbrevation `fips = "47"`. To designate multiple states, designate it in
a vector `fips = c("47", "06")`.

## Use the Data

Once you have the shapefile, you can plot using {leaflet} and {ggplot2}.

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

### Merged Data Example

You can merge other data to the shapefiles using `merge()`. A
walkthrough on how to do this is available on my
[blog](https://ivelasq.rbind.io/blog/leaid-shapefiles/).


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
site. These files are from 2019. All the state-level shapefiles are
saved
[here](https://github.com/datalorax/us-district-shapefiles/tree/master/individ-districts).

## Get the U.S. Shapefile

Load the shapefile for the entire U.S. using `lea_get()` and the state
abbreviation. Loading may take a while. You will have to load the
shapefile anytime you’re in a new directory/project.

**You must have a GITHUB\_PAT before you can run `lea_get()`.** You can
set a token in your [developer
settings](https://github.com/settings/tokens) and save it in your R
Environment. More info can be found in [Happy git with
R](https://happygitwithr.com/github-pat.html).

## Use the Data

Once you have the shapefile, you can plot using {leaflet} and {ggplot2}.

### {ggplot2} Example

``` r
library(leaidr)

tn <- lea_get("tn")
#> OGR data source with driver: ESRI Shapefile 
#> Source: "/private/var/folders/pj/nmg9b8_93dq4kwt8nt2d4cj40000gn/T/RtmpHBSznh/47", layer: "47"
#> with 158 features
#> It has 18 fields

tn %>% 
  sf::st_as_sf() %>% 
  ggplot2::ggplot() +
  ggplot2::geom_sf()
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

### Download all states

If you use `lea_get()` (i.e., with state = NULL), you get the whole US
back via ROpenSci’s {piggyback}

## Acknowlegements

Many thanks to [datalorax](https://github.com/datalorax) for the
incredible improvements to this package.

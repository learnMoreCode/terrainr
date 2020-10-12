
<!-- README.md is generated from README.Rmd. Please edit that file -->

# terrainr <a href='https://mikemahoney218.github.io/terrainr/'><img src="man/figures/logo.png" align="right" height="138.5"/></a>

<!-- badges: start -->

[![License:
MIT](https://img.shields.io/badge/license-MIT-green)](https://choosealicense.com/licenses/mit/)
[![CRAN
status](https://www.r-pkg.org/badges/version/terrainr)](https://CRAN.R-project.org/package=terrainr)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Travis build
status](https://travis-ci.com/mikemahoney218/terrainr.svg?branch=master)](https://travis-ci.com/mikemahoney218/terrainr)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/mikemahoney218/terrainr?branch=master&svg=true)](https://ci.appveyor.com/project/mikemahoney218/terrainr)
[![codecov](https://codecov.io/gh/mikemahoney218/terrainr/branch/master/graph/badge.svg)](https://codecov.io/gh/mikemahoney218/terrainr)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

<!-- badges: end -->

## Overview

terrainr makes it easy to identify your area of interest from point
data, retrieve data for that area from the National Map API, and then
process that data into larger, joined images or crop it into tiles that
can be imported into the Unity rendering engine.

At the absolute simplest level, terrainr provides a convenient and
consistent API to downloading data from the National Map.

``` r
library(terrainr)
simulated_data <-  data.frame(id = seq(1, 100, 1),
                              lat = runif(100, 44.04905, 44.17609), 
                              lng = runif(100, -74.01188, -73.83493))

bbox <- get_coord_bbox(lat = simulated_data$lat, lng = simulated_data$lng) 
output_tiles <- get_tiles(bbox = bbox,
                          services = c("elevation", "ortho"))
```

``` r
# output_tiles is now a list of two vectors pointing to the elevation and 
# orthoimagery tiles we just downloaded -- here we're displaying the first
# of the ortho tiles
raster::plot(raster::raster(output_tiles[[2]][[1]]))
```

<img src="man/figures/naip.png" width="100%" />

Once downloaded, these images are in standard GeoTIFF or PNG formats and
can be used as expected with other utilities:

``` r
raster::plot(raster::raster(output_tiles[[1]][[1]]))elev
```

<img src="man/figures/elevation.png" width="100%" />

Additionally, terrainr provides functions to transform these tiles into
RAW images ready to be imported into the Unity rendering engine,
allowing you to fly or walk through your downloaded data sets in 3D or
VR:

``` r
merged_dem <- tempfile(fileext = ".tif")
merged_ortho <- tempfile(fileext = ".tif")
# we can call these vectors by name instead of position, too
merge_rasters(output_tiles$`3DEPElevation`, 
              merged_dem, 
              output_tiles$USGSNAIPPlus, 
              merged_ortho)

mapply(function(x, y) raster_to_raw_tiles(input_file = x, 
                                          output_prefix = tempfile(), 
                                          side_length = 4097, 
                                          raw = y),
       c(merged_dem, merged_ortho),
       c(TRUE, FALSE))

# With about ten minutes of movie magic (loading the files into Unity), 
# we can turn that into:
```

<img src="man/figures/unity-lakeside.jpg" width="100%" />

terrainr also includes functionality to merge and crop the files you’ve
downloaded, and to resize your area of interest so you’re sure to
download exactly the area you want. Additionally, the more time
intensive processing steps can all be monitored via the
[progressr](https://github.com/HenrikBengtsson/progressr) package, so
you’ll be more confident that your computer is still churning along and
not just hung. For more information, check out [the introductory
vignette\!](https://mikemahoney218.github.io/terrainr/articles/overview.html)

## Available Datasets

The following datasets can currently be downloaded using `get_tiles` or
`hit_national_map_api`:

  - [3DEPElevation](https://elevation.nationalmap.gov/arcgis/rest/services/3DEPElevation/ImageServer)
  - [USGSNAIPPlus](https://services.nationalmap.gov/arcgis/rest/services/USGSNAIPPlus/MapServer)
  - [nhd](https://hydro.nationalmap.gov/arcgis/rest/services/nhd/MapServer)
  - [govunits](https://carto.nationalmap.gov/arcgis/rest/services/govunits/MapServer)
  - [contours](https://carto.nationalmap.gov/arcgis/rest/services/contours/MapServer)
  - [geonames](https://carto.nationalmap.gov/arcgis/rest/services/geonames/MapServer)
  - [NHDPlus\_HR](https://hydro.nationalmap.gov/arcgis/rest/services/NHDPlus_HR/MapServer)
  - [structures](https://carto.nationalmap.gov/arcgis/rest/services/structures/MapServer)
  - [transportation](https://carto.nationalmap.gov/arcgis/rest/services/transportation/MapServer)
  - [wbd](https://hydro.nationalmap.gov/arcgis/rest/services/wbd/MapServer)

## Installation

You can install the development version of terrainr from
[GitHub](https://github.com/mikemahoney218/terrainr) with:

``` r
# install.packages("devtools")
devtools::install_github("mikemahoney218/terrainr")
```

If you’re planning on using `raster_to_raw_tiles()`, you’ll also need to
install the development version of the `magick` package for the time
being:

``` r
devtools::install_github("ropensci/magick")
```

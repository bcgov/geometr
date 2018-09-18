<a id="devex-badge" rel="Inspiration" href="https://github.com/BCDevExchange/assets/blob/master/README.md"><img alt="An idea being explored and shaped. Open for discussion, but may never go anywhere." style="border-width:0" src="https://assets.bcdevexchange.org/images/badges/inspiration.svg" title="An idea being explored and shaped. Open for discussion, but may never go anywhere." /></a>

[![Travis build
status](https://travis-ci.org/bcgov/geometr.svg?branch=master)](https://travis-ci.org/bcgov/geometr)

# geometr

An R package to query Environment and Climate Change Canada’s GeoMet
webservices

## Project Status

This package is maintained by the Knowledge Management Branch of the
[British Columbia Ministry of Environment and Climate Change
Strategy](https://www2.gov.bc.ca/gov/content/governments/organizational-structure/ministries-organizations/ministries/environment-climate-change).
This project is under construction is not stable for any kind of
sustained use.

### Features

  - Currently the hydrometric historical webservice is the only data
    available through this service

### Installation

``` r
install.packages("remotes")
remotes::install_github("bcgov/geometr")
```

### Usage

First we have to load the package

``` r
library(geometr)
```

The collections current supported by the geomet webservice are (as of
2018-09-18):

``` r
collections <- geomet_collection()

collections[,c("title", "name")]
#> # A tibble: 15 x 2
#>    title                                            name                  
#>    <chr>                                            <chr>                 
#>  1 Monthly Mean of Water Level or Flow              hydrometric-monthly-m~
#>  2 Hydrometric Monitoring Stations                  hydrometric-stations  
#>  3 Adjusted and Homogenized Canadian Climate Data ~ ahccd-stations        
#>  4 Daily Mean of Water Level or Flow                hydrometric-daily-mean
#>  5 Adjusted and Homogenized Canadian Climate Data ~ ahccd-annual          
#>  6 Annual Maximum and Minimum Instantaneous Water ~ hydrometric-annual-pe~
#>  7 Adjusted and Homogenized Canadian Climate Data ~ ahccd-seasonal        
#>  8 Adjusted and Homogenized Canadian Climate Data ~ ahccd-trends          
#>  9 Coupled Model Intercomparison Project Phase 5 (~ cmip5                 
#> 10 MSC Monthly Data                                 climate-monthly       
#> 11 Annual Maximum and Minimum Daily Water Level or~ hydrometric-annual-st~
#> 12 1981-2010 Climate Normals                        climate-normals       
#> 13 Climate Stations                                 climate-stations      
#> 14 MSC Daily Data                                   climate-daily         
#> 15 Adjusted and Homogenized Canadian Climate Data ~ ahccd-monthly
```

For instance daily mean flow values can be queried using:

``` r
geomet_daily_mean(station_number = "10PC003")
#> No start and end dates specified. All dates available will be returned.
#> OK
#> Simple feature collection with 500 features and 12 fields
#> geometry type:  POINT
#> dimension:      XY
#> bbox:           xmin: -115.3786 ymin: 67.74028 xmax: -115.3786 ymax: 67.74028
#> epsg (SRID):    4326
#> proj4string:    +proj=longlat +datum=WGS84 +no_defs
#> # A tibble: 500 x 13
#>    id    station_number level level_symbol_en  flow flow_symbol_en
#>    <chr> <chr>          <chr> <chr>           <dbl> <chr>         
#>  1 10PC~ 10PC003        <NA>  <NA>               NA <NA>          
#>  2 10PC~ 10PC003        <NA>  <NA>               NA <NA>          
#>  3 10PC~ 10PC003        <NA>  <NA>               NA <NA>          
#>  4 10PC~ 10PC003        <NA>  <NA>               NA <NA>          
#>  5 10PC~ 10PC003        <NA>  <NA>               NA <NA>          
#>  6 10PC~ 10PC003        <NA>  <NA>               NA <NA>          
#>  7 10PC~ 10PC003        <NA>  <NA>               NA <NA>          
#>  8 10PC~ 10PC003        <NA>  <NA>               NA <NA>          
#>  9 10PC~ 10PC003        <NA>  <NA>              682 <NA>          
#> 10 10PC~ 10PC003        <NA>  <NA>              641 <NA>          
#> # ... with 490 more rows, and 7 more variables: flow_symbol_fr <chr>,
#> #   level_symbol_fr <chr>, date <date>, station_name <chr>,
#> #   identifier <chr>, prov_terr_state_loc <chr>, geometry <POINT [Â°]>
```

This returns an `sf` object by default. If you would rather simply
return a tibble you can set `as_spatial=FALSE`:

``` r
geomet_daily_mean(station_number = "10PC003", as_spatial = FALSE)
#> No start and end dates specified. All dates available will be returned.
#> OK
#> # A tibble: 1,280 x 13
#>    station_number level level_symbol_en  flow flow_symbol_en flow_symbol_fr
#>  * <chr>          <lgl> <lgl>           <dbl> <chr>          <chr>         
#>  1 10PC003        NA    NA                 NA <NA>           <NA>          
#>  2 10PC003        NA    NA                 NA <NA>           <NA>          
#>  3 10PC003        NA    NA                 NA <NA>           <NA>          
#>  4 10PC003        NA    NA                 NA <NA>           <NA>          
#>  5 10PC003        NA    NA                 NA <NA>           <NA>          
#>  6 10PC003        NA    NA                 NA <NA>           <NA>          
#>  7 10PC003        NA    NA                 NA <NA>           <NA>          
#>  8 10PC003        NA    NA                 NA <NA>           <NA>          
#>  9 10PC003        NA    NA                 NA <NA>           <NA>          
#> 10 10PC003        NA    NA                 NA <NA>           <NA>          
#> # ... with 1,270 more rows, and 7 more variables: level_symbol_fr <lgl>,
#> #   date <date>, station_name <chr>, identifier <chr>,
#> #   prov_terr_state_loc <chr>, longitude <dbl>, latitude <dbl>
```

We can also query by time ranges using the `start_date` and `end_date`
arguments:

``` r
geomet_daily_mean(station_number = "10PC003", start_date = "1983-07-11")
geomet_daily_mean(station_number = "10PC003", end_date = "1983-07-11")
```

### Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an
[issue](https://github.com/bcgov/geometr/issues/).

### How to Contribute

If you would like to contribute to the package, please see our
[CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.

### License

    Copyright 2018 Province of British Columbia
    
    Licensed under the Apache License, Version 2.0 (the &quot;License&quot;);
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
    http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an &quot;AS IS&quot; BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and limitations under the License.

-----

*This project was created using the
[bcgovr](https://github.com/bcgov/bcgovr) package.*
